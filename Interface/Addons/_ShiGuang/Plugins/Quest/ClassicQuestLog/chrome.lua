local cql = ClassicQuestLog

-- one-time initialization of chrome bits
function cql.chrome:Initialize()
    cql.chrome.mapButton:GetDisabledTexture():SetDesaturated(true) -- makes disabled version greyed out
    EventRegistry:RegisterCallback("QuestSessionManager.Update", cql.chrome.QuestSessionManagerUpdate, cql) -- callback for party sync status change
end

-- updates all the chrome bits
function cql.chrome:Update()
    local questID = C_QuestLog.GetSelectedQuest()
	local isQuestDisabled = C_QuestLog.IsQuestDisabledForSession(questID)

    cql.chrome.abandonButton:SetEnabled(not isQuestDisabled and C_QuestLog.CanAbandonQuest(questID))

    local isWatched = questID and C_QuestLog.GetQuestWatchType(questID)~=nil
    cql.chrome.trackButton:SetText(isWatched and UNTRACK_QUEST_ABBREV or TRACK_QUEST_ABBREV)
    cql.chrome.trackButton:SetEnabled(isWatched or not isQuestDisabled)

    cql.chrome.pushButton:SetEnabled(not isQuestDisabled and C_QuestLog.IsPushableQuest(questID) and IsInGroup())

    cql.chrome:QuestSessionManagerUpdate() -- update party sync stuff

    cql.chrome.mapButton:SetEnabled(not InCombatLockdown())

    cql.chrome.countFrame.text:SetText(format("%s \124cffffffff%d/%d",QUESTS_COLON,cql.log.numQuests or 0,MAX_QUESTLOG_QUESTS))
end

function cql.chrome:ShowMap()
    cql:Hide() -- don't want map quest details fighting with our details
    local questID = C_QuestLog.GetSelectedQuest()
    if not questID or questID==0 then
       ToggleWorldMap()
    else
       if not WorldMapFrame:IsVisible() then
          ToggleWorldMap()
       end
       QuestMapFrame_ShowQuestDetails(questID)
    end
end

-- tooltip for map button warns the user is in combat (an addon can't ToggleWorldMap in combat)
function cql.chrome:ShowMapTooltip()
    if InCombatLockdown() then
        GameTooltip:ClearAllPoints()
        GameTooltip:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, 0)
        GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
        GameTooltip:SetText(ERR_AFFECTING_COMBAT)
        GameTooltip:AddLine("Try again when out of combat.",0.75,0.75,0.75)
        GameTooltip:Show()
    end
end

-- used by the "Track/Untrack" button and shift+click of a quest in the log;
-- toggles watching the given questID, or the currently selected one if none given
function cql.chrome:ToggleWatch(questID)
    if not questID then
        questID = C_QuestLog.GetSelectedQuest()
    end
    if questID and questID > 0 then
        if C_QuestLog.GetQuestWatchType(questID) then
            C_QuestLog.RemoveQuestWatch(questID)
        else
            C_QuestLog.AddQuestWatch(questID)
        end
    end
end

-- the "Share" button will attempt to push the quest to party members
function cql.chrome:PushQuest()
    local questID = C_QuestLog.GetSelectedQuest()
    if questID and questID > 0 then
        local questLogIndex = C_QuestLog.GetLogIndexForQuestID(questID)
        QuestLogPushQuest(questLogIndex)
        PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
    end
end

-- click of the "Start Party Sync" or "Stop Party Sync" button
function cql.chrome:PartySync()
    local command = QuestSessionManager:GetSessionCommand()
    if command==1 then -- unsynced (i guess; this part of Blizzard's UI is hard to read)
        QuestSessionManager:StartSession()
    elseif command>1 then
        QuestSessionManager:StopSession()
    end
end

-- registered in PLAYER_LOGIN, the callback for when party sync situation changes
function cql.chrome:QuestSessionManagerUpdate()
    local shouldBeVisible = QuestSessionManager:ShouldSessionManagementUIBeVisible()
    local command = QuestSessionManager:GetSessionCommand()
    if shouldBeVisible then
        -- command 1="Start Party Sync", command 2 = "Stop Party Sync" (leader), command 3 = "Party Sync"
        cql.chrome.syncButton:SetText(command==1 and QUEST_SESSION_START_SESSION or command==2 and QUEST_SESSION_STOP_SESSION or SPLASH_BATTLEFORAZEROTH_8_2_5_FEATURE1_TITLE)
        cql.chrome.syncButton:SetEnabled(command and command < 3)
    end
    -- show the green "Party Sync is Active" text with the icon at the top if it's active
    cql.chrome.syncButton:SetShown(shouldBeVisible) -- party sync panel button
    cql.chrome.syncStatus:SetShown(shouldBeVisible and command and command>1) -- "Party Sync is Active" text at top
    cql.chrome.syncIcon:SetShown(shouldBeVisible and command and command>1) -- icon beside "Party Sync is Active"
end
