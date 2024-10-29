ShowQuestCountMixin = {}

local function countQuests()
    local questsCounted = 0
    local questInfo
    local numQuestLogEntries = C_QuestLog.GetNumQuestLogEntries()
    for index = 1, numQuestLogEntries do
        questInfo = C_QuestLog.GetInfo(index)
		if not questInfo["isHeader"] and not questInfo["isHidden"] then
			questsCounted = questsCounted + 1
		end
	end
    QuestObjectiveTracker.Header.Text:SetText(QUESTS_LABEL .. " " .. questsCounted .. "/35")
end
        
function ShowQuestCountMixin:OnEvent()
	countQuests()
end

function ShowQuestCountMixin:OnShow()
    countQuests()
end

function ShowQuestCountMixin:OnLoad()
    if QuestObjectiveTracker.Header.Text:GetText() then
        self:RegisterEvent 'QUEST_ACCEPTED'
        self:RegisterEvent 'QUEST_AUTOCOMPLETE'
        self:RegisterEvent 'QUEST_LOG_CRITERIA_UPDATE'
        self:RegisterEvent 'QUEST_POI_UPDATE'
        self:RegisterEvent 'QUEST_REMOVED'
        self:RegisterEvent 'QUEST_WATCH_LIST_CHANGED'
        self:RegisterUnitEvent ('UNIT_QUEST_LOG_CHANGED', 'player')
	else
		self:UnregisterAllEvents()
	end
end