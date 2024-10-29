--## Version: v11.0.5.X-10.16.24 ## Author: Raelsion_

-- CREATE THE ADDON TABLE
local QuestCounter = CreateFrame("Frame", "QuestCounterFrame")

-- MAXIMUM NUMBER OF QUESTS
local MAX_QUESTS = 35

-- FUNCTION TO COUNT ACTUAL QUESTS IN THE QUEST LOG
local function countQuests()
    local questsCounted = 0
    local numQuestLogEntries = C_QuestLog.GetNumQuestLogEntries()
    for index = 1, numQuestLogEntries do
        local questInfo = C_QuestLog.GetInfo(index)
        if not questInfo["isHeader"] and not questInfo["isHidden"] then
            questsCounted = questsCounted + 1
        end
    end
    return questsCounted
end

-- FUNCTION TO UPDATE THE QUEST COUNT DISPLAY
function QuestCounter:UpdateQuestCount()
    local questsCounted = countQuests()
    local displayText = string.format("%d/%d", questsCounted, MAX_QUESTS)
    QuestObjectiveTracker.Header.Text:SetText(displayText)
end

-- FUNCTION TO HANDLE UI ELEMENT SHOW EVENT
function QuestCounter:OnShow()
    if QuestObjectiveTracker and QuestObjectiveTracker.Header and QuestObjectiveTracker.Header.Text then
        self:UpdateQuestCount()
    else
        self:UnregisterAllEvents()
    end
end

-- FUNCTION TO INITIALIZE THE ADDON AND REGISTER EVENTS
function QuestCounter:OnLoad()
    self:RegisterEvent('QUEST_ACCEPTED')
    self:RegisterEvent('QUEST_AUTOCOMPLETE')
    self:RegisterEvent('QUEST_LOG_UPDATE')
    self:RegisterEvent('QUEST_REMOVED')
    self:RegisterEvent('QUEST_WATCH_LIST_CHANGED')
    self:RegisterUnitEvent('UNIT_QUEST_LOG_CHANGED', 'player')

    -- ENSURE THE DISPLAY IS UPDATED WHEN THE UI ELEMENT IS SHOWN
    if QuestObjectiveTracker and QuestObjectiveTracker.Header then
        QuestObjectiveTracker.Header:HookScript("OnShow", function() self:OnShow() end)
    end

    -- INITIALIZE THE QUEST COUNT ON LOAD
    self:UpdateQuestCount()
end

-- FUNCTION TO HANDLE EVENTS
function QuestCounter:OnEvent(event, ...)
    if event == "QUEST_ACCEPTED" or event == "QUEST_AUTOCOMPLETE" or 
       event == "QUEST_LOG_UPDATE" or event == "QUEST_REMOVED" or 
       event == "QUEST_WATCH_LIST_CHANGED" or event == "UNIT_QUEST_LOG_CHANGED" then
        self:UpdateQuestCount()
    end
end

-- SET UP THE ADDON
QuestCounter:SetScript("OnEvent", QuestCounter.OnEvent)
QuestCounter:SetScript("OnLoad", QuestCounter.OnLoad)
QuestCounter:OnLoad()