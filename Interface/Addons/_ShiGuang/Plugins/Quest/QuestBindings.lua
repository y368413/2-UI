-- This addon binds keys 1-9 to important elements of the quest pickup and turn-in windows and gossip frames.
-- 03/21/2020 2.0.0 rework for 8.3 client
-- 07/17/2018 1.0.5 toc update for 8.0 patch
-- 08/29/2017 1.0.4 toc update for 7.3 patch
-- 03/28/2017 1.0.3 toc update for 7.2 patch
-- 07/16/2016 1.0.2 toc update for 7.0 patch
-- 06/22/2015 1.0.1 toc update for 6.2 patch
-- 05/07/2015 1.0.0 initial release

local qb = {}
local qbFont = CreateFont("qb_NumberFont")
qbFont:CopyFontObject("GameFontHighlightSmall")
qbFont:SetFont("Interface\\AddOns\\_ShiGuang\\Media\\Fonts\\Pixel.ttf", 14, "OUTLINE")
	
qb.pool = {} -- pool of little buttons with numbers inside, that will click their parent when clicked via SetBindingOverrideClick
qb.noteworthy = {} -- named frames that we look for to attach a key to

-- not using CreateFramePool since these buttons need to be named for SetBindingOverrideClick to work
function qb:AcquireButton()
    -- find an unused button
    for _,button in ipairs(qb.pool) do
        if not button.isActive then
            button.isActive = true
            return button
        end
    end
    -- if still here, new button needs made
    local button = CreateFrame("Button","QuestBindingsOverride"..#qb.pool+1,qb.frame,"QuestBindingsButtonTemplate")
    button.isActive = true
    tinsert(qb.pool,button)
    return button
end

-- release all buttons in the pool and hide them; and also clear anything that might be bound to them (this can't happen in combat)
function qb:ReleaseAllButtons()
    for _,button in ipairs(qb.pool) do
        if button.isActive then
            button.isActive = false
            button:Hide()
            button:ClearAllPoints()
            button:SetParent(qb.frame)
        end
    end
    if not InCombatLockdown() then
        ClearOverrideBindings(qb.frame)
    end
end

-- title buttons (the clickable lines of text on gossip and quest frames) take first keys
for i=1,32 do
	tinsert(qb.noteworthy,"GossipTitleButton"..i)
	tinsert(qb.noteworthy,"QuestTitleButton"..i)
end
-- then quest rewards
for i=1,6 do
	tinsert(qb.noteworthy,"QuestInfoRewardsFrameQuestInfoItem"..i)
end
-- and finally the buttons at the bottom of the window
for _,button in pairs({ "GossipFrameGreetingGoodbyeButton", "QuestFrameAcceptButton", "QuestFrameDeclineButton", "QuestFrameCompleteButton", "QuestFrameCompleteQuestButton", "QuestFrameGreetingGoodbyeButton", "QuestFrameGoodbyeButton" }) do
	tinsert(qb.noteworthy,button)
end

-- event handling frame
qb.frame = CreateFrame("Frame")
qb.frame:SetScript("OnEvent",function(self,event,...)
    if qb[event] then
        qb[event](self,...)
    else
        qb:ShowKeyOverlays()
    end
end)
for _,event in pairs({"GOSSIP_SHOW", "QUEST_DETAIL", "QUEST_PROGRESS", "QUEST_GREETING", "GOSSIP_CLOSED", "QUEST_COMPLETE", "QUEST_FINISHED", "PLAYER_REGEN_DISABLED"}) do
	qb.frame:RegisterEvent(event)
end

-- any registered event not explicitly defined will run ShowKeyBindings

function qb:GOSSIP_CLOSED()
    qb:ReleaseAllButtons()
end

function qb:QUEST_FINISHED()
    qb:ReleaseAllButtons()
end

-- entering combat, hide buttons/release bindings
function qb:PLAYER_REGEN_DISABLED()
    qb:ReleaseAllButtons()
end

-- shows all overlays and binds keys 1-9 to them (this can't happen in combat)
function qb:ShowKeyOverlays()
    if InCombatLockdown() then
        return -- can't set bindings in combat
    end

    qb:ReleaseAllButtons()
    local currentKey = 0 -- key to be bound, only 1 to 9 are bound, others ignored

    -- look for any QuestFrameGreetingPanel title buttons first
    local titlePool = QuestFrameGreetingPanel.titleButtonPool
    if (titlePool.numActiveObjects > 0) then
        for titleButton in pairs(titlePool.activeObjects) do
            local titleID = titleButton:GetID()
            -- the Active quests display above Available quests and both reuse the same SetIDs
            local key = titleID
            if titleButton.isActive==0 then
                key = key + GetNumActiveQuests()
            end
            if key>0 and key<10 and titleButton:IsVisible() then
                qb:SetKey(key,titleButton)
                currentKey = max(currentKey,key) -- this is an unordered list, note the maximum number
            end
        end
    end

    -- now look for named buttons
    for _,name in ipairs(qb.noteworthy) do
        if currentKey < 9 then
            local button = _G[name]
            if button and button:IsVisible() and button:IsEnabled() and button:GetPoint() and not (name:match("QuestInfoRewardsFrameQuestInfoItem") and QuestFrameDetailPanel:IsVisible()) then
                currentKey = currentKey + 1
                qb:SetKey(currentKey,button)
            end
        end
    end
    
end

-- puts a new button for key by the parent (this can't happen in combat)
function qb:SetKey(key,parent)
    if key < 1 or key > 9 then
        return
    end
    local button = qb:AcquireButton()
    button:SetParent(parent)
    --button.parent = parent
    button:SetFrameStrata("FULLSCREEN")
    button.key:SetText(key)
    local name = parent:GetName()
    if not name or name:match("QuestTitleButton") then -- anonymous ones are (likely) from titleButtonPool
        button:SetPoint("RIGHT",parent,"LEFT",5,3)
    elseif name:match("GossipTitleButton") then
        -- gossip title buttons are too close to edge and scrollframe clips the buttons, so scooting them over
        if name=="GossipTitleButton1" and not qb.nudgedGossip then -- only need to anchor the parent since rest are anchored to previous title button
            qb.nudgedGossip = true
            local anchorPoint,anchorTo,relativePoint,xoff,yoff = parent:GetPoint()
            parent:SetPoint(anchorPoint,anchorTo,relativePoint,xoff+16,-20)
        end
        parent:SetWidth(parent:GetWidth()-16) -- reducing width of them all for the amount nudged
        button:SetPoint("RIGHT",parent,"LEFT",3,2)
    elseif name:match("QuestInfoRewardsFrameQuestInfoItem") then
        button:SetPoint("CENTER",parent,"TOPLEFT")
    else
        button:SetPoint("CENTER",parent,"LEFT")
    end
    button:Show()
    SetOverrideBindingClick(qb.frame,false,tostring(key),button:GetName()) -- note click is to button and not parent
    -- the overlay button will parent:Click()
end