local frame, L = CreateFrame("Frame"), {}; 
frame:RegisterEvent("ADDON_LOADED"); 
frame:RegisterEvent("PLAYER_ENTERING_WORLD"); 
frame:RegisterEvent("PLAYER_XP_UPDATE")

if GetLocale() == "zhCN" then -- provided by y45853160 (https://www.curseforge.com/members/y45853160)
    L = {
        NORMAL = "正常",  NORMAL_EXP = "从怪物处获得 100%正常经验值。",
        RESTED = "休息充分", RESTED_EXP = "从怪物处获得 200%正常经验值。", BONUS_EXP0 = "当前奖励", BONUS_EXP1 = "经验加成",
        MAX_LVL0 = "您已达到最高等级", MAX_LVL1 = "完成任务不再获得经验值。", NEW_LEVEL = "你已达到%d级!",
    }
elseif GetLocale() == "zhTW" then -- provided by y45853160 (https://www.curseforge.com/members/y45853160)
    L = {
        NORMAL = "正常",  NORMAL_EXP = "从怪物处获得 100%正常经验值。",
        RESTED = "休息充分", RESTED_EXP = "从怪物处获得 200%正常经验值。", BONUS_EXP0 = "当前奖励", BONUS_EXP1 = "经验加成",
        MAX_LVL0 = "您已达到最高等级", MAX_LVL1 = "完成任务不再获得经验值。", NEW_LEVEL = "你已达到%d级!",
    }
else
    L = {
        NORMAL = "Normal", NORMAL_EXP = "100% of normal experience gained from monsters.",
        RESTED = "Rested", RESTED_EXP = "Experience gained from killing monsters is doubled.", BONUS_EXP0 = "Current bonus", BONUS_EXP1 = "XP",
        MAX_LVL0 = "You've reached the maximum level", MAX_LVL1 = "Completing quests no longer provides experience.", NEW_LEVEL = "You have reached level %d!",
    }
end

local function formatNumber(number) return string.format("%d", number):reverse():gsub("(%d%d%d)", "%1."):reverse():gsub("^%.", "") end

local expFrame, expFadeOut = CreateFrame("Frame", nil, PlayerFrame), nil; expFrame:SetSize(125, 10); expFrame:SetPoint("BOTTOM", PlayerFrame, "TOP", 32, -38)
expFrame.text = expFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal"); expFrame.text:SetPoint("LEFT", 0, 0); expFrame.text:SetTextColor(PlayerName:GetTextColor())

frame:SetScript("OnEvent", function(self, event, ...)
    StatusTrackingBarManager:Hide(); PlayerName:Hide() 
    hooksecurefunc(PlayerName, "Show", PlayerName.Hide) -- support for BlizzHUDTweaks
    StatusTrackingBarManager:Hide()

    local xpDisplay = format("%s / %s", formatNumber(UnitXP("player")), formatNumber(UnitXPMax("player")))
    
    if event == "ADDON_LOADED" or event == "PLAYER_ENTERING_WORLD" then
        if GetLocale() == "ruRU" and UnitSex("player") == 2 then
        L.NORMAL = L.NORMAL_M; L.RESTED = L.RESTED_M
        elseif GetLocale() == "ruRU" and UnitSex("player") == 3 then
        L.NORMAL = L.NORMAL_F; L.RESTED = L.RESTED_F end

        expFrame.text:SetText(PlayerName:GetText()); expFrame.text:SetFont(select(1, PlayerName:GetFont()), 10)
        expFrame.text:SetWidth(100); expFrame.text:SetJustifyH("LEFT"); expFrame.text:SetMaxLines(1)
    end
    
    if event == "PLAYER_XP_UPDATE" and UnitLevel("player") ~= GetMaxLevelForLatestExpansion() then
        
        if expFadeOut and not expFadeOut:IsCancelled() then -- if the experience is already displayed
            expFadeOut:Cancel(); expFrame.text:SetText(xpDisplay)
        end
        
        if expFrame.text:GetText() == PlayerName:GetText() then
            UIFrameFadeIn(expFrame, .25, 1, 0) -- hiding the character's name
            C_Timer.After(.25, function()
                expFrame.text:SetText(xpDisplay); UIFrameFadeOut(expFrame, .25, 0, 1) -- showing the experience
            end)
        end
        
        expFadeOut = C_Timer.NewTimer(5, function()
            UIFrameFadeIn(expFrame, .25, 1, 0)
            C_Timer.After(.25, function() 
                expFrame.text:SetText(PlayerName:GetText())
                UIFrameFadeOut(expFrame, .25, 0, 1)
                expFadeOut:Cancel()
            end)
        end)
    end
    
    expFrame:SetScript("OnEnter", function() GameTooltip:SetOwner(PlayerName, "ANCHOR_BOTTOM")
        if UnitLevel("player") ~= GetMaxLevelForLatestExpansion() then
            expFrame.text:SetText(xpDisplay)
        end
        if UnitLevel("player") == GetMaxLevelForLatestExpansion() then
            GameTooltip:AddLine(L.MAX_LVL0); GameTooltip:AddLine(L.MAX_LVL1, 1, 1, 1);
        elseif GetXPExhaustion() == nil and UnitLevel("player") ~= GetMaxLevelForLatestExpansion() then
            GameTooltip:SetText(L.NORMAL)
            GameTooltip:AddLine(L.NORMAL_EXP, 1, 1, 1, true)
        elseif GetXPExhaustion() ~= nil then
            GameTooltip:SetText(L.RESTED)
            GameTooltip:AddLine(L.RESTED_EXP, 1, 1, 1, true) 
            GameTooltip:AddDoubleLine("\n" .. L.BONUS_EXP0, "\n" .. format("%s %s", formatNumber(GetXPExhaustion()), L.BONUS_EXP1), 1, .8, 0, 1, 1, 1)
        end
        expFrame:SetAlpha(1); GameTooltip:Show()
    end)
    expFrame:SetScript("OnLeave", function()
        if expFadeOut and not expFadeOut:IsCancelled() then return end
        GameTooltip:Hide()
        if UnitLevel("player") ~= GetMaxLevelForLatestExpansion() then
            expFrame.text:SetText(PlayerName:GetText())
        end
    end)
end)

local XpGainFrame = CreateFrame("MessageFrame", "XpGainFrame", UIParent)
XpGainFrame:SetSize(RaidWarningFrame:GetWidth(), 50)
XpGainFrame:SetPoint("CENTER", RaidWarningFrame, "CENTER"); XpGainFrame:SetFontObject(GameFontNormalLarge)
XpGainFrame:SetInsertMode("BOTTOM"); XpGainFrame:SetFrameStrata(RaidWarningFrame:GetFrameStrata())
XpGainFrame:SetTimeVisible(3); XpGainFrame:SetFadeDuration(1)

EventRegistry:RegisterFrameEventAndCallback("CHAT_MSG_COMBAT_XP_GAIN", function(ownerID, text, ...)
    C_Timer.After(.1, function()
        local exp1, exp2 = text:gsub("|4", ""):match("(%d+)%D+(%d+)")
        if not exp2 then exp1 = text:gsub("|4", ""):match("(%d+)") end
        local experience, ratio = nil, math.floor(UnitXP("player") / UnitXPMax("player") * 100)

        if ratio >= 1 and UnitLevel("player") ~= GetMaxLevelForLatestExpansion() then
            experience = format("+ %s %s (%d%%)", formatNumber(exp1), L.BONUS_EXP1, ratio)
        else 
            experience = format("+ %s %s.", formatNumber(exp1), L.BONUS_EXP1)
        end

        if not IsInRaid() then
            if not GetXPExhaustion() then XpGainFrame:AddMessage(experience, .4, .6, 1)
            elseif GetXPExhaustion() and exp2 then XpGainFrame:AddMessage(experience, .353, 1, .129)
            else XpGainFrame:AddMessage(experience, .4, .6, 0) end
        end
    end)
end)

EventRegistry:RegisterFrameEventAndCallback("PLAYER_LEVEL_UP", function(ownerID, text, ...)
    C_Timer.After(.125, function() XpGainFrame:AddMessage(format(L.NEW_LEVEL, UnitLevel("player")), 1, .282, 0); EventToastManagerFrame:Hide() end)
end)

local updateName = CreateFrame("Frame"); updateName:SetScript("OnEvent", function() expFrame.text:SetText(PlayerName:GetText()) end)
updateName:RegisterEvent("UNIT_ENTERED_VEHICLE"); updateName:RegisterEvent("UNIT_EXITED_VEHICLE")