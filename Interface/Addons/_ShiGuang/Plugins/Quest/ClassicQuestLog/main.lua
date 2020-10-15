-- handles the main parent frame and event handling

local cql = ClassicQuestLog

cql.options = { -- default settings
    ShowTooltips = true,
    ShowResizeGrip = false,
    ShowLevels = true,
    SolidBackground = false,
    LockWindow = false,
    ShowFromObjectiveTracker = true,
}

BINDING_HEADER_CLASSIC_QUEST_LOG = "任务日志"
BINDING_NAME_CLASSIC_QUEST_LOG_TOGGLE = "    显示/隐藏任务日志"

--[[ events ]]

function cql:PLAYER_LOGIN()
    cql.chrome:Initialize()
    --cql.options:Initialize()
    cql.log:Initialize() -- should be called before OnSizeChanged so all HybridScrollFrame buttons created for max height
    --cql.options:UpdateColors()
    -- set min/max height
    cql:SetMinResize(667,300)
    cql:SetMaxResize(667,700) -- if this changes, change in XML too
    -- script handlers for main window
    cql:SetScript("OnSizeChanged",cql.OnSizeChanged) -- not defined in XML to give HybridScrollFrame a chance to initialize above
    cql:OnSizeChanged(self:GetWidth(),self:GetHeight()) -- directly call the OnSizeChanged to set log/detail height
    -- BasicFrameTemplate stuff
    cql.CloseButton:SetScript("OnKeyDown",cql.CloseButtonOnKeyDown)
    cql.TitleText:SetText(QUEST_LOG)
    -- setup override to take over default quest toggle key/microbutton if needed
    cql:UpdateOverrides()
    cql:RegisterEvent("UPDATE_BINDINGS")
    -- setup objective tracker override
    if not IsAddOnLoaded("Blizzard_ObjectiveTracker") then
        cql:RegisterEvent("ADDON_LOADED")
    else
        cql:HandleObjectiveTracker()
    end
    -- setup hiding our frame when some default ones show since they can't (easily) co-exist with ours
    local hidefunc = function() cql:Hide() end
    QuestLogPopupDetailFrame:HookScript("OnShow",hidefunc)
    WorldMapFrame:HookScript("OnShow",hidefunc)
    QuestFrame:HookScript("OnShow",hidefunc)
    cql:SetMode("detail")
    if C_QuestLog.GetSelectedQuest()==0 then -- if user logs in with no quest, try again in half a second
        C_Timer.After(0.5,cql.Update)
    end
    cql:RegisterEvent("QUEST_ACCEPTED")
end

function cql:PLAYER_REGEN_DISABLED()
    cql.chrome.mapButton:Disable()
end

function cql:PLAYER_REGEN_ENABLED()
    cql.chrome.mapButton:Enable()
end

function cql:QUEST_DETAIL()
    cql:Hide()
end

function cql:UPDATE_BINDINGS()
    cql:UpdateOverrides()
end

function cql:ADDON_LOADED(addon)
    if addon=="Blizzard_ObjectiveTracker" then
        cql:HandleObjectiveTracker()
    end
end

function cql:QUEST_ACCEPTED(questID)
    cql.lastAcceptedQuestID = questID
    if cql:IsVisible() then -- generally, quests are not accepted while cql is up
        cql:Update()
    end
end

-- this event fires either in reaction to either ShowLoreButton OnEnter or SetLore call
function cql:LORE_TEXT_UPDATED_CAMPAIGN(campaignID,lore)
    cql:UnregisterEvent("LORE_TEXT_UPDATED_CAMPAIGN") -- can stop listening
    if campaignID then
        cql.lore.campaignHasLore[campaignID] = lore and #lore>0 -- set whether campaign has lore
        if cql.lore:IsVisible() then -- if lore is visible, update the lore
            cql.lore:Update(campaignID,lore)
        else -- otherwise show the lore button if we're waiting to see if it should be shown
            cql.lore:UpdateLoreButtonVisibility()
        end
    end
end

--[[ main window script handlers ]]

-- for events with a defined function, run them; for the rest do a UI update
function cql:OnEvent(event,...)
    if cql[event] then
        cql[event](self,...)
    else
        cql:Update()
    end
end

-- this handler is only watched after cql.log's HybridScrollFrame_CreateButtons, so that enough buttons are
-- made for the maximum height (700 height is defined in xml and should match the MaxResize height above)
function cql:OnSizeChanged(width,height)
    cql.detail:SetHeight(height-93)
    cql.log:SetHeight(height-93)
    -- update log scrollframe for changing height (no need to update data)
    cql.log:HybridScrollFrameUpdate()
end
 
 -- on mouse down of parent window, start moving unless LockWindow checked (of shift held)
 function cql:OnMouseDown()
    if IsShiftKeyDown() then
        cql.isWindowMoving = true
        self:StartMoving()
    end
 end

 -- on mouse up of parent window, stop moving if it was moving
 function cql:OnMouseUp()
    if self.isWindowMoving then
        self.isWindowMoving = nil
        self:StopMovingOrSizing()
    end
 end

-- when main window shows, hide anything that we're uncomfortable co-existing with and start listening for events
function cql:OnShow()
    QuestFrame:ClearAllPoints()
    QuestInfoSealFrame:ClearAllPoints()
    -- details frame can only be in one frame at a time; hide any frames that could have one
    if WorldMapFrame:IsVisible() and not InCombatLockdown() then
        ToggleWorldMap() -- can't hide in combat, may be unavoidable to co-exist
    end
    if QuestLogPopupDetailFrame:IsVisible() then
        QuestLogPopupDetailFrame:Hide()
    end
    if QuestFrame:IsVisible() then
        -- when the quest frame is up waiting to accept/deline and is abruptly hidden, it can prevent ESC from working
        -- until the window is dismissed normally; this will click the Close button to prevent the behavior
        if QuestFrameCloseButton:IsVisible() and QuestFrameCloseButton:IsEnabled() then
            QuestFrameCloseButton:Click()
        elseif QuestFrameAcceptButton:IsVisible() and QuestFrameAcceptButton:IsEnabled() then
            QuestFrameAcceptButton:Click() -- for automatic quests that appear (upon login), the close button may be disabled; click accept instead
        else
            QuestFrame:Hide()
        end
    end
    cql:RegisterEvent("QUEST_DETAIL")
    cql:RegisterEvent("QUEST_LOG_UPDATE")
    cql:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
    cql:RegisterEvent("GROUP_ROSTER_UPDATE")
    cql:RegisterEvent("PARTY_MEMBER_ENABLE")
    cql:RegisterEvent("PARTY_MEMBER_DISABLE")
    cql:RegisterEvent("QUEST_POI_UPDATE")
    cql:RegisterEvent("QUEST_WATCH_UPDATE")
    --cql:RegisterEvent("QUEST_ACCEPTED")
    cql:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
    cql:RegisterEvent("PLAYER_REGEN_ENABLED")
    cql:RegisterEvent("PLAYER_REGEN_DISABLED")
    PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
    cql:SetMode("detail")
end

-- whem main window hides, stop listening for events
function cql:OnHide()
    cql:UnregisterEvent("QUEST_DETAIL")
    cql:UnregisterEvent("QUEST_LOG_UPDATE")
    cql:UnregisterEvent("QUEST_WATCH_LIST_CHANGED")
    cql:UnregisterEvent("GROUP_ROSTER_UPDATE")
    cql:UnregisterEvent("PARTY_MEMBER_ENABLE")
    cql:UnregisterEvent("PARTY_MEMBER_DISABLE")
    cql:UnregisterEvent("QUEST_POI_UPDATE")
    cql:UnregisterEvent("QUEST_WATCH_UPDATE")
    --cql:UnregisterEvent("QUEST_ACCEPTED")
    cql:UnregisterEvent("UNIT_QUEST_LOG_CHANGED")
    cql:UnregisterEvent("PLAYER_REGEN_ENABLED")
    cql:UnregisterEvent("PLAYER_REGEN_DISABLED")
    PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
    --C_Timer.After(0.1,cql.options.UpdateDetailColors)
end

-- rather than UISpecialFrames, using the CloseButton (from BasicFrameTemplate) to capture keys to close the window
function cql:CloseButtonOnKeyDown(key)
    if key==GetBindingKey("TOGGLEGAMEMENU") then
        if cql.mode=="lore" or cql.mode=="options" then -- if on lore or options mode, hide them
            cql:SetMode("detail")
            PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
        else -- otherwise close Classic Quest Log
            cql:Hide()
        end
        self:SetPropagateKeyboardInput(false)
    else
        self:SetPropagateKeyboardInput(true)
    end
end

--[[ default UI behavior changes ]]

-- if a user sets a key in Key Bindings -> AddOns -> Classic Quest Log, then
-- we leave the default binding and micro button alone.
-- if no key is set, we override the default's binding and hook the macro button
local oldToggleQuestLog
function cql:UpdateOverrides()
local key = GetBindingKey("CLASSIC_QUEST_LOG_TOGGLE")
    if key then
        ClearOverrideBindings(cql)
        cql.overridingKey = nil
    else -- there's no binding for addon, so override the default stuff
        -- hook the ToggleQuestLog (if it's not been hooked before)
        if not oldToggleQuestLog then
            oldToggleQuestLog = ToggleQuestLog
            function ToggleQuestLog(...)
                if cql.overridingKey then
                    cql:ToggleWindow() -- to toggle our window if overriding
                    return
                else
                    return oldToggleQuestLog(...) -- and default stuff if they clear overriding
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

local function onBlockHeaderClick(self,block,mouseButton)
    if IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() then
        return -- user was linking quest to chat
    end
    cql.log:Update()
    if mouseButton~="RightButton" then
        if IsModifiedClick("QUESTWATCHTOGGLE") then
            return -- user was untracking a quest
        end
        if InCombatLockdown() then
            return -- in combat, always let map remain in combat (can't ToggleWorldMap then)
        end
        if not cql.options.ShowFromObjectiveTracker then
            return -- always let map remain if 'Show For Objective Tracker' is disabled
        end
        -- see if the questID is in the log and if so hide the world map and show it in the log
        for _,info in pairs(cql.log.quests) do
            if info.questID == block.id then -- found it, hide map, show log and leave
                ToggleWorldMap()
                cql:Show()
                return
            end
        end
    end
end

-- this will make clicking a quest on the objective tracker summon Classic Quest Log, unless
-- the Show From Objective Tracker option is unchecked; it should be run only once when objective tracker loads
function cql:HandleObjectiveTracker()
    cql:UnregisterEvent("ADDON_LOADED")
    -- hook clicking of quest objective to summon classic quest log instead of world map
    hooksecurefunc(QUEST_TRACKER_MODULE,"OnBlockHeaderClick",onBlockHeaderClick)
    hooksecurefunc(CAMPAIGN_QUEST_TRACKER_MODULE,"OnBlockHeaderClick",onBlockHeaderClick)
end

--[[ window ]]

function cql:ToggleWindow()
    cql:SetShown(not cql:IsVisible())
end

-- this does a full update of the UI
function cql:Update()
    -- first update the detail/lore/options panel, depending which is up
    if cql.mode and cql[cql.mode].Update then
        cql[cql.mode]:Update() -- call the Update for the mode we're in ("detail", "lore" or "options")
    end
    cql.log:Update() -- rebuilds cql.log.quests and updates log display
    cql.chrome:Update() -- updates panel buttons and other chrome bits
    cql.resizeGrip:SetShown(cql.options.ShowResizeGrip)
    --cql.options:UpdateDetailColors()
end

-- switches between "detail", "lore" and "options" modes; hiding the unused modes and showing the one being set
local modes = { {"detail","lore","options"}, {"lore","detail","options"}, {"options","detail","lore"} }
function cql:SetMode(mode)
    for i=1,#modes do
        if mode==modes[i][1] and cql.mode~=mode then
            cql.mode = mode
            cql[modes[i][2]]:Hide()
            --cql[modes[i][3]]:Hide()
            cql[modes[i][1]]:Show()
        end
    end
    cql:Update()
end

-- debug function to print where a function was called from
function cql:CallerID()
    local where = (debugstack():match(".-\n.-\n.-\n.-\\AddOns\\.-\\(.-:%d+.-)\n") or ""):gsub("\"]","")
    if where:len()==0 then
        where = (debugstack():match(".-\n.-\n.-\\AddOns\\.-\\(.-:%d+.-)\n") or ""):gsub("\"]","")
    end
    print("CallerID:",where:len()>0 and where or debugstack())
end
--:match(".-\n.-\n.-\n.-\\AddOns\\.-\\(.-)\n"