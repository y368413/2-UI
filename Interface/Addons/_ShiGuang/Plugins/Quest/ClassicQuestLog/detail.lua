local cql = ClassicQuestLog

function cql.detail:Update()
    local questID = cql.detail:GetSelectedQuest() -- tries to select one if one isn't selected
    cql.questID = questID

    -- if there's no selected quest, hide the scrollchild with any lingering quests
    cql.detail.content:SetShown(questID and questID>0)

    -- 99% of the work is done by QuestInfo_Display; this fills the scrollchild with the quest details;
    -- note: this is a shared resource. if another frame uses this to display quest details, the details
    -- will disappear from this scrollchild.
    QuestInfo_Display(QUEST_TEMPLATE_LOG, cql.detail.content)

    -- note for future work: look at QuestMapFrame_ShowQuestDetails and use these templates instead:
    -- QuestInfo_Display(QUEST_TEMPLATE_MAP_DETAILS, QuestMapFrame.DetailsFrame.ScrollFrame.Contents);
	-- QuestInfo_Display(QUEST_TEMPLATE_MAP_REWARDS, QuestMapFrame.DetailsFrame.RewardsFrame, nil, nil, true);

    -- handling special backgrounds here; QuestInfo_Display assumes the background is the
    -- parent of parent of this detail frame and changes SealMaterialBG for some quests.
    -- this will keep SealMaterialBG at the parent frame and when we want to show it,
    -- detail.DetailBG:SetAlpha(0) to let the alternate background through
    cql.SealMaterialBG:ClearAllPoints()
    cql.SealMaterialBG:SetPoint("TOPLEFT",cql.detail)
    cql.SealMaterialBG:SetPoint("BOTTOMRIGHT",cql.detail)
    local theme = C_QuestLog.GetQuestDetailsTheme(questID)
    if theme and theme.background then
        cql.detail.DetailBG:SetAlpha(0)
    else--if not cql.options:Get("SolidBackground") then -- if in dark background mode, keep alpha 0
        cql.detail.DetailBG:SetAlpha(1)
    end

    -- show portrait if one exists and there's enough room to the right of the main window
	local questPortrait, questPortraitText, questPortraitName, questPortraitMount = GetQuestLogPortraitGiver()
	if questID>0 and (questPortrait and questPortrait ~= 0 and QuestLogShouldShowPortrait() and (UIParent:GetRight() - cql:GetRight() > QuestModelScene:GetWidth() + 6)) then
        QuestFrame_ShowQuestPortrait(cql, questPortrait, questPortraitMount, questPortraitText, questPortraitName, -2, -43)
        QuestModelScene:SetFrameStrata("HIGH")
	else
		QuestFrame_HideQuestPortrait()
	end

	StaticPopup_Hide("ABANDON_QUEST");
	StaticPopup_Hide("ABANDON_QUEST_WITH_ITEMS");
end

-- when no quest is selected, find the last accepted quest or the first one and select it if possible
function cql.detail:GetSelectedQuest()
    local questID = C_QuestLog.GetSelectedQuest()
    -- if log is emptied, last quest remain selected one even if abandoned; clear it here    
    if not questID or not C_QuestLog.IsOnQuest(questID) then
        questID = 0
    end
    -- if we need to select a quest because an active one isn't selected
    if not questID or questID==0 then
        -- if a quest has been recently accepted and is valid, then select the last one accepted
        if cql.lastAcceptedQuestID and C_QuestLog.IsOnQuest(cql.lastAcceptedQuestID) then
            C_QuestLog.SetSelectedQuest(cql.lastAcceptedQuestID)
            return cql.lastAcceptedQuestID
        end
        -- if still nothing selected, update the quest log and look for the first available
        cql.log:Update() -- refresh the list (may have had a quest completed and a new one accepted)
        for _,info in pairs(cql.log.quests) do
            if not info.isHeader and info.questID and C_QuestLog.IsOnQuest(info.questID) then
                C_QuestLog.SetSelectedQuest(info.questID)
                return info.questID
            end
        end
    end
    return questID
end
