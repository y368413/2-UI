--## Author: Gello  ## Version: 1.4.7
local function ShowUIPanel(panel)
	QuestFrame:ClearAllPoints()
	QuestInfoSealFrame:ClearAllPoints()
	panel:Show()
end

local function NewHideUIPanel(panel)
	QuestFrame:ClearAllPoints()
	QuestInfoSealFrame:ClearAllPoints()
	panel:Hide()
end


local cql = ClassicQuestLog

-- settings: ShowTooltips, ShowLevels, UndockWindow, LockWindow, ShowResizeGrip, Height, SolidBackground

ClassicQuestLogSettings = {}
ClassicQuestLogCollapsedHeaders = {}

cql.quests = {}

BINDING_HEADER_CLASSIC_QUEST_LOG = "任务日志"
BINDING_NAME_CLASSIC_QUEST_LOG_TOGGLE = "    显示/隐藏任务日志"

function cql:OnEvent(event)
	QuestFrame:ClearAllPoints()
	QuestInfoSealFrame:ClearAllPoints()
   if event=="PLAYER_LOGIN" then
      local scrollFrame = cql.scrollFrame
      scrollFrame.update = cql.UpdateLogList
      HybridScrollFrame_CreateButtons(scrollFrame, "ClassicQuestLogListTemplate")
	  -- hide our frame if default's popup detail log appears
      QuestLogPopupDetailFrame:HookScript("OnShow",function() cql:HideWindow() end)

      cql:SetMinResize(667,300)
      cql:SetMaxResize(667,700)
      cql:SetHeight(496)

      cql:UpdateOverrides()
      cql:RegisterEvent("UPDATE_BINDINGS")
      cql:SetScript("OnSizeChanged",cql.OnSizeChanged)
      cql:UpdateBackgrounds()
      if not IsAddOnLoaded("Blizzard_ObjectiveTracker") then
         cql:RegisterEvent("ADDON_LOADED")
      else
         cql:HandleObjectiveTracker()
      end
	  hooksecurefunc("SelectQuestLogEntry",cql.UpdateLogList)

		-- awful workaround to initialize quest stuff
		cql:SetAlpha(0)
		cql:ShowWindow()
		cql:HideWindow()
		cql:SetAlpha(1)
	  

   elseif event=="UPDATE_BINDINGS" then
      cql:UpdateOverrides()
   elseif event=="QUEST_DETAIL" then
      cql:HideWindow()
   elseif event=="ADDON_LOADED" and IsAddOnLoaded("Blizzard_ObjectiveTracker") then
      cql:HandleObjectiveTracker()
   else
		QuestFrame:ClearAllPoints()
		QuestInfoSealFrame:ClearAllPoints()
      local selected = GetQuestLogSelection()
      if selected==0 then
         cql:SelectFirstQuest()
      else
         cql:UpdateLogList()
         -- cql:SelectQuestIndex(selected)
      end
   end
end

-- this handler is only watched after HybridScrollFrame_CreateButtons, so that enough buttons are
-- made for the maximum height.
function cql:OnSizeChanged(width,height)
	QuestFrame:ClearAllPoints()
	QuestInfoSealFrame:ClearAllPoints()
   if not height then
      height = cql:GetHeight()
   end
   self.detail:SetHeight(height-93)
   self.scrollFrame:SetHeight(height-93)
   self:UpdateLogList()
end

function cql:OnShow()
	QuestFrame:ClearAllPoints()
	QuestInfoSealFrame:ClearAllPoints()
   if WorldMapFrame:IsVisible() then
      ToggleWorldMap() -- can't have world map up at same time due to potential details frame being up
   end
   if QuestLogPopupDetailFrame:IsVisible() then
      NewHideUIPanel(QuestLogPopupDetailFrame)
   end
   if QuestFrame:IsVisible() then
      NewHideUIPanel(QuestFrame)
   end
   local selected = GetQuestLogSelection()
   if not selected or selected==0 then
      cql:SelectFirstQuest()
   else
      cql:SelectQuestIndex(selected)
   end
   cql:OnSizeChanged()
   cql:RegisterEvent("QUEST_DETAIL")
   cql:RegisterEvent("QUEST_LOG_UPDATE")
   cql:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
   cql:RegisterEvent("SUPER_TRACKED_QUEST_CHANGED")
   cql:RegisterEvent("GROUP_ROSTER_UPDATE")
   cql:RegisterEvent("PARTY_MEMBER_ENABLE")
   cql:RegisterEvent("PARTY_MEMBER_DISABLE")
   cql:RegisterEvent("QUEST_POI_UPDATE")
   cql:RegisterEvent("QUEST_WATCH_UPDATE")
   cql:RegisterEvent("QUEST_ACCEPTED")
   cql:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
   if not tContains(UISpecialFrames,"ClassicQuestLog") then
      tinsert(UISpecialFrames,"ClassicQuestLog")
   end
   cql.detail:ClearAllPoints()
   cql.detail:SetPoint("TOPRIGHT",-32,-63)
   PlaySound(PlaySoundKitID and "igQuestLogOpen" or SOUNDKIT.IG_QUEST_LOG_OPEN)
end

-- no need to watch these events while log isn't on screen
function cql:OnHide()
	QuestFrame:ClearAllPoints()
	QuestInfoSealFrame:ClearAllPoints()
   -- only keep this window in UISpecialFrames while it's up
   for i=#UISpecialFrames,1,-1 do
      if UISpecialFrames[i]=="ClassicQuestLog" then
         tremove(UISpecialFrames,i)
      end
   end
   cql:UnregisterEvent("QUEST_DETAIL")
   cql:UnregisterEvent("QUEST_LOG_UPDATE")
   cql:UnregisterEvent("QUEST_WATCH_LIST_CHANGED")
   cql:UnregisterEvent("SUPER_TRACKED_QUEST_CHANGED")
   cql:UnregisterEvent("GROUP_ROSTER_UPDATE")
   cql:UnregisterEvent("PARTY_MEMBER_ENABLE")
   cql:UnregisterEvent("PARTY_MEMBER_DISABLE")
   cql:UnregisterEvent("QUEST_POI_UPDATE")
   cql:UnregisterEvent("QUEST_WATCH_UPDATE")
   cql:UnregisterEvent("QUEST_ACCEPTED")
   cql:UnregisterEvent("UNIT_QUEST_LOG_CHANGED")

   -- expand all headers when window hides so default doesn't lose track of collapsed quests
   local index = 1
   while index<=GetNumQuestLogEntries() do
      local _,_,_,isHeader,isCollapsed = GetQuestLogTitle(index)
      if isHeader and isCollapsed then
         ExpandQuestHeader(index)
      end
      index = index + 1
   end

   PlaySound(PlaySoundKitID and "igQuestLogClose" or SOUNDKIT.IG_QUEST_LOG_CLOSE)

end

-- this shows the update frame whose purpose is to run UpdateLog below on the next frame
-- this prevents multiple events firing at once from recreating the log every event
function cql:UpdateLogList()
   cql.update:Show()
end

-- called from the OnUpdate of cql.update
function cql:UpdateLog()
	QuestFrame:ClearAllPoints()
	QuestInfoSealFrame:ClearAllPoints()
   cql.update:Hide() -- immediately stop the OnUpdate
   -- gather quests into a working table (cql.quests) to skip over collapsed headers
   wipe(cql.quests)
   cql.expanded = nil

   -- first add all non-hidden headers and quests to cql.quests table
   -- (btw this circuitous method is to future-proof it against future hidden quests; blizzard's
   -- code seems to imply it's possible for a header to contain both hidden and non-hidden quests)
   local numQuests = 0
   for index=1,GetNumQuestLogEntries() do
      local questTitle, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden = GetQuestLogTitle(index)
      if not isHidden then
         table.insert(cql.quests,{index,questTitle,level,suggestedGroup,isHeader,isCollapsed,isComplete,frequency,questID})
         if not isHeader then
            numQuests = numQuests + 1
         end
      end
   end

   -- next remove any quest headers that have no quests
   local hasQuests
   for index=#cql.quests,1,-1 do
      if cql.quests[index][5] then -- this is a header
		 if not hasQuests then -- with no quests beneath it
            tremove(cql.quests,index) -- remove the header
         end
         hasQuests = nil -- reset flag to look for quests
      else
         hasQuests = true -- this is a quest, keep the header this is beneath
      end
   end

   -- next flag quests to be removed due to collapsed headers (can't tremove since have to loop forward)
   local skipping
   for index=1,#cql.quests do
      if cql.quests[index][5] then -- this is a header
         skipping = ShiGuangPerDB[cql.quests[index][2]] -- [2] is questTitle
         cql.quests[index][6] = skipping -- update isCollapsed to reflect our version (which is independent of default's state)
         if not skipping then
            cql.expanded = true -- at least one header is expanded (for all quest +/- choice)
         end
      elseif skipping then
         cql.quests[index] = false
      end
   end
   -- then strip out flagged quests (doing this afterwards since we need to tremove backwards)
   for index=#cql.quests,1,-1 do
      if cql.quests[index]==false then
         tremove(cql.quests,index)
      end
   end

   -- if player is in a war campaign then add a fake header
   local warCampaignHeader = cql:GetWarCampaignHeader()
   if warCampaignHeader then
		tinsert(cql.quests,1,{0,warCampaignHeader,0,nil,true,false,false,nil,0}) -- insert a fake quest log index at top of list
   end

   -- finally update scrollframe

   local numEntries = #cql.quests
   local scrollFrame = cql.scrollFrame
   local offset = HybridScrollFrame_GetOffset(scrollFrame)
   local buttons = scrollFrame.buttons
   local selectedIndex = GetQuestLogSelection()

   cql.count.text:SetText(format("%s \124cffffffff%d/%d",QUESTS_COLON,numQuests,MAX_QUESTLOG_QUESTS))

   for i=1, #buttons do
      local index = i + offset
	  local button = buttons[i]

	  if ( index <= numEntries ) then
         local entry, questTitle, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = unpack(cql.quests[index])

         button.index = entry -- this is the questLogIndex
         button.questID = questID
         button.isHeader = isHeader
         button.isCollapsed = isCollapsed
         button.questTitle = questTitle

         button.normalText:SetWidth(275)
         local maxWidth = 275 -- we may shrink normalText to accomidate check and tag icons

         local color = isHeader and QuestDifficultyColors["header"] or GetQuestDifficultyColor(level)
         if not isHeader and selectedIndex==entry then
            button:SetNormalFontObject("GameFontHighlight")
            button.selected:SetVertexColor(color.r,color.g,color.b)
            button.selected:Show()
         else
            button:SetNormalFontObject(color.font)
            button.selected:Hide()
         end

         if isHeader then
            button:SetText(questTitle)
            button.check:Hide()
            button.tag:Hide()
			button.groupMates:Hide()
			if entry==0 then -- for fake entries (war campaign) show alliance/horde icon instead of +/- button
				local icon = UnitFactionGroup("player")=="Alliance" and "Interface\\WorldStateFrame\\AllianceIcon" or "Interface\\WorldStateFrame\\HordeIcon"
				button:SetNormalTexture(icon)
				button:SetHighlightTexture(icon)
			else
				button:SetNormalTexture(isCollapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up")
				button:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
			end
         else
            button:SetText(format(" [%d] %s",level,questTitle))
            button:SetNormalTexture("")
            button:SetHighlightTexture("")
            -- if quest is tracked, show check and shorted max normalText width
            if IsQuestWatched(entry) then
               maxWidth = maxWidth - 16
               button.check:Show()
            else
               button.check:Hide()
            end
            -- display an icon to note what type of quest it is
            -- tag. daily icon can be alone or before other icons except for COMPLETED or FAILED
            local tagID
            local questTagID, tagName = GetQuestTagInfo(questID)
            if isComplete and isComplete<0 then
               tagID = "FAILED"
            elseif isComplete and isComplete>0 then
               tagID = "COMPLETED"
            elseif questTagID and questTagID==QUEST_TAG_ACCOUNT then
               local factionGroup = GetQuestFactionGroup(questID)
               if factionGroup then
                  tagID = "ALLIANCE"
                  if factionGroup==LE_QUEST_FACTION_HORDE then
                     tagID = "HORDE"
                  end
               else
                  tagID = QUEST_TAG_ACCOUNT;
               end
            elseif frequency==LE_QUEST_FREQUENCY_DAILY and (not isComplete or isComplete==0) then
               tagID = "DAILY"
            elseif frequency==LE_QUEST_FREQUENCY_WEEKLY and (not isComplete or isComplete==0) then
               tagID = "WEEKLY"
            elseif questTagID then
               tagID = questTagID
            end
            button.tagID = nil
            button.tag:Hide()
            if tagID then -- this is a special type of quest
               maxWidth = maxWidth - 16
               local tagCoords = QUEST_TAG_TCOORDS[tagID]
               if tagCoords then
                  button.tagID = tagID
                  button.tag:SetTexCoord(unpack(tagCoords))
                  button.tag:Show()
               end
            end

            -- If not a header see if any nearby group mates are on this quest
            local partyMembersOnQuest = 0
            for j=1,GetNumSubgroupMembers() do
               if IsUnitOnQuest(entry,"party"..j) then
                  partyMembersOnQuest = partyMembersOnQuest + 1
               end
            end
            if partyMembersOnQuest>0 then
               button.groupMates:SetText("["..partyMembersOnQuest.."]")
               button.partyMembersOnQuest = partyMembersOnQuest
               button.groupMates:Show()
            else
               button.partyMembersOnQuest = nil
               button.groupMates:Hide()
            end

         end

         -- limit normalText width to the maxWidth
         button.normalText:SetWidth(min(maxWidth,button.normalText:GetStringWidth()))

         button:Show()
      else
         button:Hide()
      end
   end

   if numEntries==0 then
      cql.scrollFrame:Hide()
      cql.emptyLog:Show()
      cql.detail:Hide()
   else
      cql.scrollFrame:Show()
      cql.emptyLog:Hide()
      cql.scrollFrame.expandAll:SetNormalTexture(cql.expanded and "Interface\\Buttons\\UI-MinusButton-Up" or "Interface\\Buttons\\UI-PlusButton-Up")
   end

   cql:UpdateControlButtons()

   HybridScrollFrame_Update(scrollFrame, 16*numEntries, 16)

   cql:UpdateQuestDetail()
end

-- this updates the detail pane of the currently selected quest
function cql:UpdateQuestDetail()

	QuestFrame:ClearAllPoints()
	QuestInfoSealFrame:ClearAllPoints()
   local index = GetQuestLogSelection()
   if ( index == 0 ) then
      cql.selectedIndex = nil
      ClassicQuestLogDetailScrollFrame:Hide()
   elseif index>0 and index<=GetNumQuestLogEntries() then
      local _,_,_,isHeader,_,_,_,questID = GetQuestLogTitle(index)
      if not isHeader then
         ClassicQuestLogDetailScrollFrame:Show()
         ClassicQuestLog.questID = questID
         QuestInfo_Display(QUEST_TEMPLATE_LOG, ClassicQuestLogDetailScrollChildFrame)
         ClassicQuestLog.SealMaterialBG:Hide()
         -- if a different questID being viewed, scroll to top of detail pane
         if questID ~= cql.lastViewedQuestID then
            ClassicQuestLogDetailScrollFrameScrollBar:SetValue(0)
            cql.lastViewedQuestID = questID
         end
      end
   end
   -- show portrait off to side of window if one is available
   local questPortrait, questPortraitText, questPortraitName, questPortraitMount = GetQuestLogPortraitGiver();
   if (questPortrait and questPortrait ~= 0 and QuestLogShouldShowPortrait()) then
      -- only show quest portrait if it's not already shown
	  if QuestModelScene and (QuestModelScene:GetParent()~=ClassicQuestLog or not QuestModelScene:IsVisible() or cql.questPortrait~=questPortrait) then
		QuestFrame_ShowQuestPortrait(ClassicQuestLog, questPortrait, questPortraitMount, questPortraitText, questPortraitName, -3, -42)
         cql.questPortrait = questPortrait
      end
   else
      QuestFrame_HideQuestPortrait()
   end
end

--[[ list entry handling ]]

function cql:ListEntryOnClick()
   local index = self.index
   if self.index==0 then
		return -- this is a fake header/war campaign; don't do anything
		elseif self.isHeader then
      ShiGuangPerDB[self.questTitle] = not ShiGuangPerDB[self.questTitle] or nil
   else
      if IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() then
         local link = GetQuestLink(self.questID)
         if link then
            ChatEdit_InsertLink(link)
         end
      elseif IsModifiedClick("QUESTWATCHTOGGLE") then
         cql:ToggleWatch(index)
      else
         cql:SelectQuestIndex(index)
      end
   end
   cql:UpdateLogList()
end

function cql:ToggleWatch(index)
   if not index then
      index = GetQuestLogSelection()
   end
   if index>0 then
      if IsQuestWatched(index) then -- already watched, remove from watch
         RemoveQuestWatch(index)
      else -- not watched, see if there's room to add, add if so
         if GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS then
            UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY,MAX_WATCHABLE_QUESTS),1,0.1,0.1,1)
         else
            AddQuestWatch(index)
         end
      end
   end
end

-- tooltip
function cql:ListEntryOnEnter()
   local index = self.index

	if self.isHeader or not index then
		return
	end

   GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
   GameTooltip:AddLine((GetQuestLogTitle(index)),1,.82,0)

   local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI = GetQuestLogTitle(self.index)

   -- quest tag tooltip info (shameless copy-paste from QuestMapFrame.lua)
   local tagID, tagName = GetQuestTagInfo(questID);
   if ( tagName ) then
      local factionGroup = GetQuestFactionGroup(questID);
      -- Faction-specific account quests have additional info in the tooltip
      if ( tagID == QUEST_TAG_ACCOUNT and factionGroup ) then
         local factionString = FACTION_ALLIANCE;
         if ( factionGroup == LE_QUEST_FACTION_HORDE ) then
            factionString = FACTION_HORDE;
         end
         tagName = format("%s (%s)", tagName, factionString);
      end
      GameTooltip:AddLine(tagName, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      if ( QUEST_TAG_TCOORDS[tagID] ) then
         local questTypeIcon;
         if ( tagID == QUEST_TAG_ACCOUNT and factionGroup ) then
            questTypeIcon = QUEST_TAG_TCOORDS["ALLIANCE"];
            if ( factionGroup == LE_QUEST_FACTION_HORDE ) then
               questTypeIcon = QUEST_TAG_TCOORDS["HORDE"];
            end
         else
            questTypeIcon = QUEST_TAG_TCOORDS[tagID];
         end
         GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(questTypeIcon));
      end
   end
   if ( frequency == LE_QUEST_FREQUENCY_DAILY ) then
      GameTooltip:AddLine(DAILY, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(QUEST_TAG_TCOORDS["DAILY"]));
   elseif ( frequency == LE_QUEST_FREQUENCY_WEEKLY ) then
      GameTooltip:AddLine(WEEKLY, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(QUEST_TAG_TCOORDS["WEEKLY"]));
   end
   if ( isComplete and isComplete < 0 ) then
      GameTooltip:AddLine(FAILED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
      GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(QUEST_TAG_TCOORDS["FAILED"]));	
   end

   -- list members on quest if they exist
   if self.partyMembersOnQuest then
      GameTooltip:AddLine(PARTY_QUEST_STATUS_ON,1,.82,0)
      for j=1,GetNumSubgroupMembers() do
         if IsUnitOnQuest(index,"party"..j) then
            GameTooltip:AddLine(GetUnitName("party"..j),.9,.9,.9)
         end
      end
   end

   -- description
   if isComplete and isComplete>0 then
      if ( IsBreadcrumbQuest(self.questID) ) then
         GameTooltip:AddLine(GetQuestLogCompletionText(self.index), 1, 1, 1, true);
      else
         GameTooltip:AddLine(QUEST_WATCH_QUEST_READY, 1, 1, 1, true);
      end
   else
      local _, objectiveText = GetQuestLogQuestText(index)
      GameTooltip:AddLine(objectiveText,.85,.85,.85,true)
      local requiredMoney = GetQuestLogRequiredMoney(index)
      local numObjectives = GetNumQuestLeaderBoards(index)
      for i=1,numObjectives do
         local text, objectiveType, finished = GetQuestLogLeaderBoard(i,index)
         if ( text ) then
            local color = HIGHLIGHT_FONT_COLOR
            if ( finished ) then
               color = GRAY_FONT_COLOR
            end
            GameTooltip:AddLine(QUEST_DASH..text, color.r, color.g, color.b, true)
         end
      end
      if ( requiredMoney > 0 ) then
         local playerMoney = GetMoney()
         local color = HIGHLIGHT_FONT_COLOR
         if ( requiredMoney <= playerMoney ) then
            playerMoney = requiredMoney
            color = GRAY_FONT_COLOR
         end
         GameTooltip:AddLine(QUEST_DASH..GetMoneyString(playerMoney).." / "..GetMoneyString(requiredMoney), color.r, color.g, color.b);
      end

   end


   GameTooltip:Show()
end

--[[ selection ]]

function cql:SelectQuestIndex(index)

   SelectQuestLogEntry(index)

   StaticPopup_Hide("ABANDON_QUEST")
   StaticPopup_Hide("ABANDON_QUEST_WITH_ITEMS")
   SetAbandonQuest()

   cql:UpdateLogList()
end

-- selects the first quest in the log (if any)
function cql:SelectFirstQuest()
   for i=1,GetNumQuestLogEntries() do
      if not select(4,GetQuestLogTitle(i)) then
         cql:SelectQuestIndex(i)
         return
      end
   end
   cql:SelectQuestIndex(0) -- if we reached here, select nothing
end

--[[ control buttons ]]

function cql:UpdateControlButtons()
   local selectionIndex = GetQuestLogSelection()
   if selectionIndex==0 then
      cql.abandon:Disable()
      cql.push:Disable()
      cql.track:Disable()
   else
      local questID = select(8,GetQuestLogTitle(selectionIndex))
      cql.abandon:SetEnabled(GetAbandonQuestName() and CanAbandonQuest(questID))
      cql.push:SetEnabled(GetQuestLogPushable() and IsInGroup())
      cql.track:Enable()
   end
end

function cql:ExpandAllOnClick()
	--if not cql.expanded then
		--wipe(ShiGuangPerDB)
	--else
		for i=1,GetNumQuestLogEntries() do
			local questTitle,_,_,isHeader = GetQuestLogTitle(i)
			if isHeader then
				ShiGuangPerDB[questTitle] = true
			end
		end
	--end
	cql:UpdateLogList()
end

--[[ map button ]]

function cql:ShowMap()
   cql:HideWindow() -- can't let map quest details fight with our details
   local selectionIndex = GetQuestLogSelection()
   if selectionIndex==0 then
      ToggleWorldMap()
   else
      local questID = select(8,GetQuestLogTitle(selectionIndex))
      if not WorldMapFrame:IsVisible() then
         ToggleWorldMap()
      end
      QuestMapFrame_ShowQuestDetails(questID)
   end
end

--[[ overrides ]]

-- if a user sets a key in Key Bindings -> AddOns -> Classic Quest Log, then
-- we leave the default binding and micro button alone.
-- if no key is set, we override the default's binding and hook the macro button

function cql:UpdateOverrides()
   local key = GetBindingKey("CLASSIC_QUEST_LOG_TOGGLE")
   if key then -- and ShiGuangDB.AltBinding then
      ClearOverrideBindings(cql)
      cql.overridingKey = nil
   else -- there's no binding for addon, so override the default stuff
      -- hook the ToggleQuestLog (if it's not been hooked before)
      if not cql.oldToggleQuestLog then
         cql.oldToggleQuestLog = ToggleQuestLog
         function ToggleQuestLog(...)
            if cql.overridingKey then
               cql:ToggleWindow() -- to toggle our window if overriding
               return
            else
               return cql.oldToggleQuestLog(...) -- and default stuff if they clear overriding
            end
         end
      end
      -- now see if default toggle quest binding has changed
      local newKey = GetBindingKey("TOGGLEQUESTLOG")
      if cql.overridingKey~=newKey and newKey then
         ClearOverrideBindings(cql)
         SetOverrideBinding(cql,false,newKey,"CLASSIC_QUEST_LOG_TOGGLE")
         cql.overridingKey = newKey
      end
   end
end

function cql:ToggleWindow()
   cql[cql:IsVisible() and "HideWindow" or "ShowWindow"](self)
end

function cql:HideWindow()
	QuestFrame:ClearAllPoints()
	QuestInfoSealFrame:ClearAllPoints()
      ClassicQuestLog:Hide()
end

function cql:ShowWindow()
	QuestFrame:ClearAllPoints()
	QuestInfoSealFrame:ClearAllPoints()
      ClassicQuestLog:Show()
end
function cql:UpdateBackgrounds()
		cql.detail.DetailBG:SetTexture("Interface\\QuestFrame\\QuestBG")
		cql.detail.DetailBG:SetTexCoord(0,0.5859375,0,0.65625)
		cql.scrollFrame.BG:SetTexture("Interface\\QuestFrame\\QuestBookBG")
		cql.scrollFrame.BG:SetTexCoord(0,0.5859375,0,0.65625)
end

function cql:HandleObjectiveTracker()
   cql:UnregisterEvent("ADDON_LOADED")
   -- hook clicking of quest objective to summon classic quest log instead of world map
   hooksecurefunc(QUEST_TRACKER_MODULE,"OnBlockHeaderClick",function(self, block, mouseButton)
      if IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() then
         return -- user was linking quest to chat
      end
      if mouseButton~="RightButton" then
         if IsModifiedClick("QUESTWATCHTOGGLE") then
            return -- user was untracking a quest
         end
         local questLogIndex = GetQuestLogIndexByID(block.id)
         if not (IsQuestComplete(block.id) and GetQuestLogIsAutoComplete(questLogIndex)) and not InCombatLockdown() then
            HideUIPanel(WorldMapFrame)
            cql:ShowWindow()
         end
      end
   end)
end
-- returns the chapter title of the current war campaign if the player is on a war campaign
function cql:GetWarCampaignHeader()
	local warCampaignID = C_CampaignInfo.GetCurrentCampaignID()
	if warCampaignID then
		local warCampaignInfo = C_CampaignInfo.GetCampaignInfo(warCampaignID)
		if warCampaignInfo and warCampaignInfo.visibilityConditionMatched and not warCampaignInfo.complete then
			local campaignChapterID = C_CampaignInfo.GetCurrentCampaignChapterID()
			if campaignChapterID then
				local campaignChapterInfo = C_CampaignInfo.GetCampaignChapterInfo(campaignChapterID)
				return campaignChapterInfo.name
			end
		end
	end
end