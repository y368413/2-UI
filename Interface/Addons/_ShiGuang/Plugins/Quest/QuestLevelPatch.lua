--## Version: v1.28  ## Author: iceeagle

-- Hook quest log on map
hooksecurefunc("QuestLogQuests_Update", function(self, poiTable)
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
end)

-- Hook quest info
hooksecurefunc("QuestInfo_Display", function(template, parentFrame, acceptButton, material, mapView)
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
end)
