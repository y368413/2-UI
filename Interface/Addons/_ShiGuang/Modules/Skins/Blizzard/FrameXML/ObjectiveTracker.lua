local _, ns = ...
local M, R, U, I = unpack(ns)

local r, g, b = I.r, I.g, I.b
local select, unpack = select, unpack

	-- Reskin Headers
	local function reskinHeader(header)
		header.Text:SetTextColor(r, g, b)
		header.Background:SetTexture(nil)
		local bg = header:CreateTexture(nil, "ARTWORK")
		bg:SetTexture("Interface\\LFGFrame\\UI-LFG-SEPARATOR")
		bg:SetTexCoord(0, .66, 0, .31)
		bg:SetVertexColor(r, g, b, .8)
		bg:SetPoint("BOTTOMLEFT", -30, -4)
		bg:SetSize(250, 30)
	end
	
tinsert(R.defaultThemes, function()
	local LE_QUEST_FREQUENCY_DAILY = LE_QUEST_FREQUENCY_DAILY or 2
	local C_QuestLog_IsQuestReplayable = C_QuestLog.IsQuestReplayable

	local headers = {
		ObjectiveTrackerBlocksFrame.QuestHeader,
		ObjectiveTrackerBlocksFrame.AchievementHeader,
		ObjectiveTrackerBlocksFrame.ScenarioHeader,
		BONUS_OBJECTIVE_TRACKER_MODULE.Header,
		WORLD_QUEST_TRACKER_MODULE.Header,
		ObjectiveTrackerFrame.BlocksFrame.UIWidgetsHeader
	}
	for _, header in pairs(headers) do reskinHeader(header) end

	--[[ Show quest color and level
	local function Showlevel(_, _, _, title, level, _, isHeader, _, isComplete, frequency, questID)
		if ENABLE_COLORBLIND_MODE == "1" then return end

		for button in pairs(QuestScrollFrame.titleFramePool.activeObjects) do
			if title and not isHeader and button.questID == questID then
				local title = "["..level.."] "..title
				if isComplete then
					title = "|cffff78ff"..title
				elseif C_QuestLog_IsQuestReplayable(questID) then
					title = "|cff00ff00"..title
				elseif frequency == LE_QUEST_FREQUENCY_DAILY then
					title = "|cff3399ff"..title
				end
				button.Text:SetText(title)
				button.Text:SetPoint("TOPLEFT", 24, -5)
				button.Text:SetWidth(205)
				button.Text:SetWordWrap(false)
				button.Check:SetPoint("LEFT", button.Text, button.Text:GetWrappedWidth(), 0)
			end
		end
	end
	hooksecurefunc("QuestLogQuests_AddQuestButton", Showlevel)

	-- Hook objective tracker
	hooksecurefunc(QUEST_TRACKER_MODULE, "Update", function()
		for i = 1, GetNumQuestWatches() do
			local questID, title, questLogIndex, numObjectives, requiredMoney, isComplete, startEvent, isAutoComplete, failureTime, timeElapsed, questType, isTask, isStory, isOnMap, hasLocalPOI = GetQuestWatchInfo(i)
			if ( not questID ) then break end
			local oldBlock = QUEST_TRACKER_MODULE:GetExistingBlock(questID)
			if oldBlock then
				local oldBlockHeight = oldBlock.height
			  local oldHeight = QUEST_TRACKER_MODULE:SetStringText(oldBlock.HeaderText, title, nil, OBJECTIVE_TRACKER_COLOR["Header"])
			  local newTitle = "["..select(2, GetQuestLogTitle(questLogIndex)).."] "..title
			  local newHeight = QUEST_TRACKER_MODULE:SetStringText(oldBlock.HeaderText, newTitle, nil, OBJECTIVE_TRACKER_COLOR["Header"])
			  oldBlock:SetHeight(oldBlockHeight + newHeight - oldHeight);
			end end end)

-- Hook quest info
	hooksecurefunc("QuestInfo_Display", function(template, parentFrame, acceptButton, material, mapView)
		local elementsTable = template.elements
		for i = 1, #elementsTable, 3 do
			if elementsTable[i] == QuestInfo_ShowTitle then
				if QuestInfoFrame.questLog then
					if GetQuestLogSelection() > 0 then QuestInfoTitleHeader:SetText("["..select(2, GetQuestLogTitle(GetQuestLogSelection())).."] "..QuestInfoTitleHeader:GetText()) end
	end end end end)]]

----------------------------------------------------------------------------------------
--[[	Ctrl+Click to abandon a quest or Alt+Click to share a quest(by Suicidal Katt)
----------------------------------------------------------------------------------------
hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self)
	if IsControlKeyDown() then
		CloseDropDownMenus()
		QuestMapQuestOptions_AbandonQuest(self.questID)
	elseif IsAltKeyDown() and GetQuestLogPushable(self.questID) then
		CloseDropDownMenus()
		QuestMapQuestOptions_ShareQuest(self.questID)
	end
end)
hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderClick", function(_, block)
	local questLogIndex = block.id
	if IsControlKeyDown() then
		CloseDropDownMenus()
		QuestMapQuestOptions_AbandonQuest(questLogIndex)
	elseif IsAltKeyDown() and GetQuestLogPushable(questLogIndex) then
		CloseDropDownMenus()
		QuestLogPushQuest(questLogIndex)
	end
end)]]

--[[ 任务名称职业着色 -------------------------------------------------------
 if  MaoRUIPerDB["Skins"]["QuestTrackerSkinTitle"] then
    hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", function(_, block)
        --for i = 1, GetNumQuestWatches() do
		    --local questID = GetQuestWatchInfo(i)
	        --if not questID then break end
            --local block = QUEST_TRACKER_MODULE:GetBlock(questID)
	          block.HeaderText:SetFont(STANDARD_TEXT_FONT, 12, 'nil')
	          block.HeaderText:SetShadowOffset(.7, -.7)
	          block.HeaderText:SetShadowColor(0, 0, 0, 1)
              block.HeaderText:SetTextColor(I.r, I.g, I.b)
              block.HeaderText:SetJustifyH("LEFT")
          --end
     end)
     local function hoverquest(_, block)
     --for i = 1, GetNumQuestWatches() do
		    --local id = GetQuestWatchInfo(i)
	        --if not id then break end
	        --QUEST_TRACKER_MODULE:GetBlock(id).HeaderText:SetTextColor(r, g, b)
	        block.HeaderText:SetTextColor(I.r, I.g, I.b)
        --end
     end
    hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderEnter", hoverquest)  
    hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderLeave", hoverquest)
 end   
  
 end)   ]]
 -- numQuests -------------------------------------------------------
local numQuests=CreateFrame('frame')
numQuests:RegisterEvent('PLAYER_LOGIN')
numQuests:RegisterEvent('QUEST_LOG_UPDATE')
numQuests:SetScript('OnEvent',function() 
   local numQuests = 0
   for index=1,C_QuestLog.GetNumQuestLogEntries() do
      if not C_QuestLog.GetInfo(index).isHidden then
         if not C_QuestLog.GetInfo(index).isHeader then
            numQuests = numQuests + 1
         end
      end
   end
   if not InCombatLockdown() then  --not InCombat and 
		ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(numQuests.."/"..C_QuestLog.GetMaxNumQuestsCanAccept().." "..TRACKER_HEADER_QUESTS)  --MAX_QUESTS
		ObjectiveTrackerFrame.HeaderMenu.Title:SetText(numQuests.."/"..C_QuestLog.GetMaxNumQuestsCanAccept().." "..OBJECTIVES_TRACKER_LABEL)
		--WorldMapFrame.BorderFrame.TitleText:SetText(MAP_AND_QUEST_LOG.." ("..numQuests.."/"..C_QuestLog.GetMaxNumQuestsCanAccept()..")")
	end 
end)

 --[[ CompletedTip -----------------------------------------------------------Version: 1.0.0.80300    --Author: InvisiBill
local function onSetHyperlink(self, link)
    local type, id = string.match(link,"^(%a+):(%d+)")
    if not type or not id then return end
    if type == "quest" then
        if IsQuestFlaggedCompleted(id) then
            self:AddDoubleLine(AUCTION_CATEGORY_QUEST_ITEMS, GARRISON_MISSION_COMPLETE, 1, 0.82, 0, 0, 1, 0)
        else
            self:AddDoubleLine(AUCTION_CATEGORY_QUEST_ITEMS, INCOMPLETE , 1, 0.82, 0, 1, 0, 0)
        end
        self:Show()
    end
end
hooksecurefunc(ItemRefTooltip, "SetHyperlink", onSetHyperlink)
hooksecurefunc(GameTooltip, "SetHyperlink", onSetHyperlink)]]
end)