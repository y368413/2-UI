--## Version: v1.28  ## Author: iceeagle
--------------------------------------------------------------------------------------------------------
--                                    QuestLevelPatch variables                                       --
--------------------------------------------------------------------------------------------------------
local QuestLevelPatch = {}

--------------------------------------------------------------------------------------------------------
--                                QuestLevelPatch hooked functions                                    --
--------------------------------------------------------------------------------------------------------

-- Hook quest log on map
function QuestLogQuests_hook(self, poiTable)
	local button
	local prevButton = nil
	for button in QuestScrollFrame.titleFramePool:EnumerateActive() do
		local questID = C_QuestLog.GetQuestIDForLogIndex(button.questLogIndex)
		local quest = QuestCache:Get(questID)
		if ( not quest or not quest.level ) then
			break
		end
		local buttonText = button.Text:GetText() or ''
		local oldBlockHeight = button:GetHeight()
		local oldHeight = button.Text:GetStringHeight()
		local newTitle = "["..quest.level.."] "..buttonText
		button.Text:SetText(newTitle)
		local newHeight = button.Text:GetStringHeight()
		button:SetHeight(oldBlockHeight + newHeight - oldHeight)
	end
end
hooksecurefunc("QuestLogQuests_Update", QuestLogQuests_hook)

-- Hook quest info
function QuestInfo_hook(template, parentFrame, acceptButton, material, mapView)
	local elementsTable = template.elements
	for i = 1, #elementsTable, 3 do
		if elementsTable[i] == QuestInfo_ShowTitle then
			local questFrame = parentFrame:GetParent():GetParent()
			local questID
			if ( template.questLog ) then
				questID = questFrame.questID
			else
				questID = GetQuestID()
			end
			local quest = QuestCache:Get(questID)
			if quest.level then
				local newTitle = "["..quest.level.."] "..QuestInfoTitleHeader:GetText()
				QuestInfoTitleHeader:SetText(newTitle)
			end
		end
	end
end
hooksecurefunc("QuestInfo_Display", QuestInfo_hook)
