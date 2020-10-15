local cql = ClassicQuestLog

ClassicQuestLogCollapsedHeaders = {} -- per-character savedvar of header indexes that are collapsed
local collapsedHeaders -- local reference so I don't have to type ClassicQuestLogCollapsedHeaders all the time
-- REMINDER: the quest api has isCollapsed, but it always collapses everything (except campaigns) on login;
-- we want to remember what was expanded so we need to handle collapsed independently!

local factionIcon = UnitFactionGroup("player")=="Alliance" and "Interface\\WorldStateFrame\\AllianceIcon" or "Interface\\WorldStateFrame\\HordeIcon"

cql.log.quests = {} -- ordered list of quests in the log
cql.log.numQuests = 0 -- number of displayed quests, excluding headers
cql.log.somethingExpanded = false -- true when at least one quest header is expanded (for "All" button use)

-- sets up the scrollframe of quests in the log
function cql.log:Initialize()
    collapsedHeaders = ClassicQuestLogCollapsedHeaders
    local scrollFrame = cql.log
    scrollFrame.update = cql.log.UpdateLog
    HybridScrollFrame_CreateButtons(scrollFrame, "ClassicQuestLogListButtonTemplate")
end

-- updates the cql.log.quests ordered list of quest infos to display
function cql.log:Update()
    --cql:CallerID()
    local quests = cql.log.quests
    cql.log.numQuests = 0
    cql.log.somethingExpanded = false

    wipe(quests) -- revisit: this is causing some garbage

    -- first gather all non-hidden headers and quests
    for i=1,C_QuestLog.GetNumQuestLogEntries() do
        local info = C_QuestLog.GetInfo(i)
        if info and not info.isHidden then
            tinsert(quests,info)
            if not info.isHeader then
                cql.log.numQuests = cql.log.numQuests + 1
            end
        end
    end

    -- next flag any quest headers that have no quests for removal
    local currentHeader
    for i=1,#quests do
        if quests[i].isHeader and (i==#quests or quests[i+1].isHeader) then
            quests[i] = false  -- if header has no quests (at end or next entry is a header too), flag for removal
        elseif quests[i].isHeader then
            currentHeader = quests[i].title -- if entry is a header, display and note header we're on
        elseif collapsedHeaders[currentHeader] then
            quests[i] = false -- header is collapsed, flag for removal
        else
            cql.log.somethingExpanded = true -- non-header item to display, so something expanded
        end
    end

    -- now tremove any entries flagged for removal
    for i=#quests,1,-1 do
        if quests[i]==false then
            tremove(quests,i)
        end
    end

    cql.log:UpdateLog() -- now that quests are built, show them in the log
end

-- this updates the HybridScrollFrame with the displayed list of quests
function cql.log:UpdateLog()

    local quests = cql.log.quests
    local numEntries = #quests
    local scrollFrame = cql.log
    local offset = HybridScrollFrame_GetOffset(scrollFrame)
    local buttons = scrollFrame.buttons

    for i=1, #buttons do
        local index = i + offset
        if (index <= numEntries) then
            buttons[i].index = index
            cql.log:UpdateListButton(buttons[i],quests[index])
            buttons[i]:Show()
        else
            buttons[i]:Hide()
        end
    end

    if numEntries==0 then
        cql.log.background:SetTexCoord(0,0.28125,0,0.5) -- spiderweb background when no quests
    else
        cql.log.background:SetTexCoord(0,0.28125,0.5,1.0) -- regular background with quests
        cql.log.expandAll:SetNormalTexture(cql.log.somethingExpanded and "Interface\\Buttons\\UI-MinusButton-Up" or "Interface\\Buttons\\UI-PlusButton-Up")
    end
 
    cql.log:HybridScrollFrameUpdate()

end

-- sole purpose of this is to update the scrollbar/move content in range, for both an UpdateLog
-- and when the window resizes
function cql.log:HybridScrollFrameUpdate()
    HybridScrollFrame_Update(cql.log, 16*#cql.log.quests, 16)
end

-- updates the log list button to reflect the quest info
function cql.log:UpdateListButton(button,info)
    if type(info)~="table" then
        return
    end

    button.questID = info.questID
    button.questLogIndex = info.questLogIndex
    button.campaignID = info.campaignID

    button.normalText:SetWidth(275)
    local maxWidth = 275 -- we may shrink normalText to accomidate check and tag icons

    -- color text/selection
    local color = info.isHeader and QuestDifficultyColors["header"] or GetQuestDifficultyColor(info.difficultyLevel)
    if not info.isHeader and C_QuestLog.GetSelectedQuest() == info.questID then -- highlight selected quest
        button:SetNormalFontObject("GameFontHighlight")
        button.selected:SetVertexColor(color.r,color.g,color.b)
        button.selected:Show()
    else
        button:SetNormalFontObject(color.font)
        button.selected:Hide()
    end    

    if info.isHeader then
        button:SetText(info.title)
        button.check:Hide()
        button.groupmates:Hide()
        local isCollapsed = collapsedHeaders[info.title]
        button:SetNormalTexture(isCollapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up")
        button:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
        -- special styling for campaign quest headers
        if info.campaignID then
            -- repurpose selected background to blue for alliance/red for horde
            if UnitFactionGroup("player")=="Alliance" then
                button.selected:SetVertexColor(0,0,0.75,0.75)
            else
                button.selected:SetVertexColor(0.5,0,0,0.75)
            end
            button.selected:Show()
            -- if mouse is over this header, display the lore button; otherwise show a tag with faction icon
            button.tag:SetTexture(factionIcon) -- but still set up the icon for a potential tag:Show() when mouse moves away
            button.tag:SetTexCoord(0,1,0,1)
            local focus = GetMouseFocus()
            if (focus==button or (focus==cql.loreButton and cql.loreButton:GetParent()==button)) and cql.lore.campaignHasLore[info.campaignID] then
                cql.lore:ShowLoreButton(button)
                button.tag:Hide()
            else
                button.tag:Show()
            end
            -- display the 0/x Chapters progress beside the tag
            local campaign = CampaignCache:Get(info.campaignID)
            button.progress:SetText(format("%d/%d",campaign:GetCompletedChapterCount() or 0,campaign:GetChapterCount() or 0))
            button.progress:Show()
        else
            button.tag:Hide()
            button.progress:Hide()
        end
    else -- not a header, a regular quest
        --if cql.options:Get("ShowLevels") then
            button:SetText(format("  [%d] %s",info.level,info.title))
        --else
            --button:SetText(format("  %s",info.title))
        --end
        button:SetNormalTexture("")
        button:SetHighlightTexture("")
        -- if quest is tracked, show a check
        if C_QuestLog.GetQuestWatchType(info.questID) then
            maxWidth = maxWidth - 16
            button.check:Show()
        else
            button.check:Hide()
        end
        -- display an icon to note what type of quest it is
        if cql.log:UpdateQuestTypeIcon(button,info) then
            maxWidth = maxWidth - 16
        end
        -- if any nearby groupmembers are on this quest show the number to left of title
        local unitsOnQuest = QuestUtils_GetNumPartyMembersOnQuest(info.questID)
        if unitsOnQuest > 0 then
            button.groupmates:SetText(format("[%d]",unitsOnQuest))
            button.groupmates:Show()
        else
            button.groupmates:Hide()
        end

        button.progress:Hide() -- only used on campaign headers

        -- limit normalText width to the maxWidth
        button.normalText:SetWidth(min(maxWidth,button.normalText:GetStringWidth()))        
    end

end

-- copy/pasted from QuestMapFrame.lua/QuestLogQuests_AddQuestButton; displays the quest type icon
-- returns true if there's an icon to display
function cql.log:UpdateQuestTypeIcon(button,info)
    local tagID
    local tagInfo = C_QuestLog.GetQuestTagInfo(info.questID)
    local questTagID = tagInfo and tagInfo.tagID
    local isComplete = C_QuestLog.IsComplete(info.questID)

    if not isComplete and C_QuestLog.IsFailed(info.questID) then
        tagID = "FAILED"
    elseif isComplete then
        tagID = "COMPLETED"
    elseif questTagID == Enum.QuestTag.Account then
        local factionGroup = GetQuestFactionGroup(info.questID);
        if factionGroup then
            tagID = factionGroup == LE_QUEST_FACTION_HORDE and "HORDE" or "ALLIANCE"
        else
            tagID = Enum.QuestTag.Account
        end
    elseif info.frequency == Enum.QuestFrequency.Daily and (not isComplete or isComplete == 0) then
        tagID = "DAILY"
    elseif info.frequency == Enum.QuestFrequency.Weekly and (not isComplete or isComplete == 0) then
        tagID = "WEEKLY"
    elseif questTagID then
        tagID = questTagID
    end

    local tagCoords = tagID and QUEST_TAG_TCOORDS[tagID]
    button.tag:SetShown(tagCoords ~= nil)

    if tagCoords then
        button.tag:SetTexture("Interface\\QuestFrame\\QuestTypeIcons")
        button.tag:SetTexCoord(unpack(tagCoords));
        button.tag:SetDesaturated(C_QuestLog.IsQuestDisabledForSession(info.questID));
    end

    return tagCoords~=nil
end

--[[ clickable Stuff ]]

-- click of the +/- All button at the top of the log, to expand/collapse all headers
function cql.log:ExpandAllOnClick()
    if cql.log.somethingExpanded then -- if at least one header expanded, then collapse all
        for _,info in ipairs(cql.log.quests) do
            if info.isHeader then
                collapsedHeaders[info.title] = true
            end
        end
    else -- otherwise if no headers expanded, expand all (remove all collapsedHeaders)
        wipe(collapsedHeaders)
    end
    cql.log:Update()
end

-- click of a quest log list button, either header or quest
function cql.log:ListButtonOnClick()
    local info = self.index and cql.log.quests[self.index]
    if not info then return end

    if info.isHeader then -- this is a header, toggle its collapsed state
        collapsedHeaders[info.title] = not collapsedHeaders[info.title]
        cql.log:Update()
    elseif info.questID then -- this is a regular quest
        -- first try to link to chat or elsewhere and leave if successfull
        if ChatEdit_TryInsertQuestLinkForQuestID(info.questID) then
            return
        end
        -- next toggle watch if shift (or whatever key defined) is down
        if IsModifiedClick("QUESTWATCHTOGGLE") then
            cql.chrome:ToggleWatch(info.questID)
        else -- just clicking a quest with nothing special will select and display the quest details
            C_QuestLog.SetSelectedQuest(info.questID)
            cql:SetMode("detail")
        end
    end
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
    cql.chrome:Update()
end

--[[ tooltip ]]

-- onenter of quest log list button, displays a tooltip
-- most of this is shamelessly lifted from Blizzard's QuestMapLogTitleButton_OnEnter in QuestMapFrame.lua
function cql.log:ListButtonOnEnter()
    local info = self.index and cql.log.quests[self.index]
    if not info then return end

    -- only campaign headers are shown; the rest of headers have no template
    if info.isHeader then
        if info.campaignID then -- for campaign headers, show its tooltip
            --if cql.options:Get("ShowTooltips") then
                cql.campaignTooltip:SetPoint("TOPLEFT",self,"TOPRIGHT",28,0)
                cql.campaignTooltip:SetCampaign(CampaignCache:Get(info.campaignID))
            --end
            cql.lore:ShowLoreButton(self)
        end
        return
    end

    --if not cql.options:Get("ShowTooltips") then return end

    local questID = info.questID

	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 28, 0)
	GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
    GameTooltip:SetText(info.title)
    
	if C_QuestLog.IsQuestReplayable(questID) then
		GameTooltip_AddInstructionLine(GameTooltip, QuestUtils_GetReplayQuestDecoration(questID)..QUEST_SESSION_QUEST_TOOLTIP_IS_REPLAY, false)
	elseif C_QuestLog.IsQuestDisabledForSession(questID) then
		GameTooltip_AddColoredLine(GameTooltip, QuestUtils_GetDisabledQuestDecoration(questID)..QUEST_SESSION_ON_HOLD_TOOLTIP_TITLE, DISABLED_FONT_COLOR, false)
	end

	-- quest tag
	local tagInfo = C_QuestLog.GetQuestTagInfo(questID)
	if ( tagInfo ) then
		local tagName = tagInfo.tagName
		local factionGroup = GetQuestFactionGroup(questID)
		-- Faction-specific account quests have additional info in the tooltip
		if ( tagInfo.tagID == Enum.QuestTag.Account and factionGroup ) then
			local factionString = FACTION_ALLIANCE
			if ( factionGroup == LE_QUEST_FACTION_HORDE ) then
				factionString = FACTION_HORDE
			end
			tagName = format("%s (%s)", tagName, factionString)
		end

		local overrideQuestTag = tagInfo.tagID
		if ( QUEST_TAG_TCOORDS[tagInfo.tagID] ) then
			if ( tagInfo.tagID == Enum.QuestTag.Account and factionGroup ) then
				overrideQuestTag = "ALLIANCE"
				if ( factionGroup == LE_QUEST_FACTION_HORDE ) then
					overrideQuestTag = "HORDE"
				end
			end
		end

		QuestUtils_AddQuestTagLineToTooltip(GameTooltip, tagName, overrideQuestTag, tagInfo.worldQuestType, NORMAL_FONT_COLOR)
	end

	if ( info.frequency == Enum.QuestFrequency.Daily ) then
		QuestUtils_AddQuestTagLineToTooltip(GameTooltip, DAILY, "DAILY", nil, NORMAL_FONT_COLOR)
	elseif ( info.frequency == Enum.QuestFrequency.Weekly ) then
		QuestUtils_AddQuestTagLineToTooltip(GameTooltip, WEEKLY, "WEEKLY", nil, NORMAL_FONT_COLOR)
	end

	if C_QuestLog.IsFailed(info.questID) then
		QuestUtils_AddQuestTagLineToTooltip(GameTooltip, FAILED, "FAILED", nil, RED_FONT_COLOR)
	end

	GameTooltip:AddLine(" ")

	-- description
	if C_QuestLog.IsComplete(questID) then
		local completionText = GetQuestLogCompletionText(self.questLogIndex) or QUEST_WATCH_QUEST_READY
		GameTooltip:AddLine(completionText, 1, 1, 1, true)
		GameTooltip:AddLine(" ")
	else
		local needsSeparator = false
		local _, objectiveText = GetQuestLogQuestText(self.questLogIndex)
		GameTooltip:AddLine(objectiveText, 1, 1, 1, true)
		GameTooltip:AddLine(" ")
		local requiredMoney = C_QuestLog.GetRequiredMoney(questID)
		local numObjectives = GetNumQuestLeaderBoards(self.questLogIndex)
		for i = 1, numObjectives do
			local text, objectiveType, finished = GetQuestLogLeaderBoard(i, self.questLogIndex)
			if ( text ) then
				local color = HIGHLIGHT_FONT_COLOR
				if ( finished ) then
					color = GRAY_FONT_COLOR
				end
				GameTooltip:AddLine(QUEST_DASH..text, color.r, color.g, color.b, true)
				needsSeparator = true
			end
		end
		if ( requiredMoney > 0 ) then
			local playerMoney = GetMoney()
			local color = HIGHLIGHT_FONT_COLOR
			if ( requiredMoney <= playerMoney ) then
				playerMoney = requiredMoney
				color = GRAY_FONT_COLOR
			end
			GameTooltip:AddLine(QUEST_DASH..GetMoneyString(playerMoney).." / "..GetMoneyString(requiredMoney), color.r, color.g, color.b)
			needsSeparator = true
		end

	end

	if QuestUtils_GetNumPartyMembersOnQuest(questID) > 0 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(PARTY_QUEST_STATUS_ON)
		GameTooltip:SetQuestPartyProgress(questID, true, true)
	end

    GameTooltip:Show()
end


function cql.log:ListButtonOnLeave()
    cql.campaignTooltip:Hide()
    GameTooltip:Hide()
    local index = self.index
    local info = index and cql.log.quests[index]
    local focus = GetMouseFocus()
    if info and info.isHeader and info.campaignID and not ((focus==self or (focus==cql.loreButton and cql.loreButton:GetParent()==self)) and cql.lore.campaignHasLore[info.campaignID]) then
        self.tag:Show()
    end
end


