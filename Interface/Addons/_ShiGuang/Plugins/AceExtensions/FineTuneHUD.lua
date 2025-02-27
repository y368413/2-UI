--## Author: Snowpanther ## Version: v1.1.5
local FineTuneHUD = {}; -- Namespace
local FineTune = {};
FineTuneHUD.FineTune = FineTune;
FineTuneHUD.frames = {
    extraAbilityContainer = _G["ExtraAbilityContainer"],
    targetFrame = _G["TargetFrame"],
    talkingHeadFrame = _G["TalkingHeadFrame"],
    partyFrame = _G["PartyFrame"],
    combatRaidFrameContainer = _G["CompactRaidFrameContainer"],
    debuffFrame = _G["DebuffFrame"],
    possessActionBar = _G["PossessActionBar"],
    playerFrame = _G["PlayerFrame"],
    chatFrame1 = _G["ChatFrame1"],
    mainMenuBarVehicleLeaveButton = _G["MainMenuBarVehicleLeaveButton"],
    playerCastingBarFrame = _G["PlayerCastingBarFrame"],
    stanceBar = _G["StanceBar"],
    petActionBar = _G["PetActionBar"],
    mainMenuBar = _G["MainMenuBar"],
    multiBarBottomLeft = _G["MultiBarBottomLeft"],
    multiBar7 = _G["MultiBar7"],
    multiBar6 = _G["MultiBar6"],
    multiBar5 = _G["MultiBar5"],
    multiBarBottomRight = _G["MultiBarBottomRight"],
    multiBarRight = _G["MultiBarRight"],
    multiBarLeft = _G["MultiBarLeft"],
    mainStatusTrackingBarContainer = _G["MainStatusTrackingBarContainer"],
    secondaryStatusTrackingBarContainer = _G["SecondaryStatusTrackingBarContainer"],
    petFrame = _G["PetFrame"],
    objectiveTrackerFrame = _G["ObjectiveTrackerFrame"],
    buffFrame = _G["BuffFrame"],
    minimapCluster = _G["MinimapCluster"],
    bossTargetFrameContainer = _G["BossTargetFrameContainer"],
    durabilityFrame = _G["DurabilityFrame"],
    arenaEnemyFramesContainer = _G["ArenaEnemyFramesContainer"],
    compactArenaFrame = _G["CompactArenaFrame"],
    gameTolltipDefaultContainer = _G["GameTooltipDefaultContainer"],
    bagsBar = _G["BagsBar"],
    microMenuContainer = _G["MicroMenuContainer"],
    lootFrame = _G["LootFrame"],
    focusFrame = _G["FocusFrame"],
    mirrorTimerContainer = _G["MirrorTimerContainer"],
    archeologyDigsiteProgressBar = _G["ArcheologyDigsiteProgressBar"],
    vehicleSeatIndicator = _G["VehicleSeatIndicator"],
}


local updateEventFrame = CreateFrame("Frame");
local settingDialog = _G["EditModeSystemSettingsDialog"];
local coordFrame = CreateFrame("Frame", "coordFrame", settingDialog)
coordFrame:SetSize(150, 30);
coordFrame:SetPoint("BOTTOM", settingDialog, "BOTTOM", 0, 125);
local X = settingDialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
X:SetPoint("LEFT", coordFrame, "LEFT", -30, 0);
X:SetText("X: ");
local editBoxX = CreateFrame("EditBox", "editBoxX", settingDialog, "InputBoxTemplate")
editBoxX:SetPoint("LEFT", X, "RIGHT", 0, 0);
editBoxX:SetSize(80, 30)
editBoxX:SetAutoFocus(false)
local Y = settingDialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
Y:SetPoint("LEFT", editBoxX, "RIGHT", 10, 0);
Y:SetText("Y: ");
local editBoxY = CreateFrame("EditBox", "editBoxX", settingDialog, "InputBoxTemplate")
editBoxY:SetPoint("LEFT", Y, "RIGHT", 0, 0);
editBoxY:SetSize(80, 30)
editBoxY:SetAutoFocus(false)



local leftArrowButton = CreateFrame("Button", "leftArrorButton", settingDialog, "UIPanelButtonTemplate")
leftArrowButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
leftArrowButton:SetPoint("BOTTOM", settingDialog, "BOTTOM", -40, 50);
leftArrowButton:SetSize(30, 30)

local rightArrowButton = CreateFrame("Button", "rightArrorButton", settingDialog, "UIPanelButtonTemplate")
rightArrowButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
rightArrowButton:SetPoint("BOTTOM", settingDialog, "BOTTOM", 40, 50);
rightArrowButton:SetSize(30, 30)

local upArrowButton = CreateFrame("Button", "upArrorButton", settingDialog, "UIPanelButtonTemplate")
upArrowButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
upArrowButton:SetPoint("BOTTOM", settingDialog, "BOTTOM", 0, 80);
upArrowButton:SetSize(30, 30)
upArrowButton:GetNormalTexture():SetRotation(math.rad(-90))

local downArrowButton = CreateFrame("Button", "downArrorButton", settingDialog, "UIPanelButtonTemplate")
downArrowButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
downArrowButton:SetPoint("BOTTOM", settingDialog, "BOTTOM", 0, 20);
downArrowButton:SetSize(30, 30)
downArrowButton:GetNormalTexture():SetRotation(math.rad(-90))


-- Set edit box events
local editBoxFocus = false;
local currentFrame = nil;
editBoxX:SetScript("OnEditFocusGained", function()
    editBoxFocus = true;
end)
editBoxY:SetScript("OnEditFocusGained", function()
    editBoxFocus = true;
end)
editBoxX:SetScript("OnEditFocusLost", function()
    editBoxFocus = false;
end)
editBoxY:SetScript("OnEditFocusLost", function()
    editBoxFocus = false;
end)
editBoxX:SetScript("OnEnterPressed", function()
    if currentFrame then
        local currentPoints = { currentFrame:GetPoint() }
        local x = editBoxX:GetText();
        local y = editBoxY:GetText();
        currentFrame:SetPoint(currentPoints[1], currentPoints[2], currentPoints[3], x, currentPoints[5])
        currentFrame:OnDragStop()
    end
end)
editBoxY:SetScript("OnEnterPressed", function()
    if currentFrame then
        local currentPoints = { currentFrame:GetPoint() }
        local x = editBoxX:GetText();
        local y = editBoxY:GetText();
        currentFrame:SetPoint(currentPoints[1], currentPoints[2], currentPoints[3], currentPoints[4], y)
        currentFrame:OnDragStop()
    end
end)

updateEventFrame:HookScript("OnUpdate", function()
    local screenWidth = GetScreenWidth();
    local middleOfScreen = screenWidth / 2;
    local screenHeight = GetScreenHeight();
    local middleOfScreenHeight = screenHeight / 2;


    if settingDialog:IsShown() then
        for name, frame in pairs(FineTuneHUD.frames) do
            local movable = frame:IsMovable();
            if movable and not editBoxFocus then
                currentFrame = frame;
                local x, y = frame.Selection:GetCenter();
                local left = x - middleOfScreen;
                local bottom = y - middleOfScreenHeight;
                local leftFormatted = string.format("%.1f", left);
                local bottomFormatted = string.format("%.1f", bottom);

                -- coordText:SetText("X: " .. leftFormatted .. " Y: " .. bottomFormatted)
                editBoxX:SetText(leftFormatted)
                editBoxY:SetText(bottomFormatted)
                FineTune:SetUpArrowFunctions(frame);
            end
        end
    end
end)

function FineTune:SetUpArrowFunctions(frame)
    leftArrowButton:SetScript("OnClick", function() FineTune:Move(frame, "left") end)
    rightArrowButton:SetScript("OnClick", function() FineTune:Move(frame, "right") end)
    upArrowButton:SetScript("OnClick", function() FineTune:Move(frame, "up") end)
    downArrowButton:SetScript("OnClick", function() FineTune:Move(frame, "down") end)
end

function FineTune:Move(frame, direction)
    local editModeTargetFrame = _G["EditModeManagerFrame"]
    if editModeTargetFrame then
        editModeTargetFrame:SetHasActiveChanges(true)
    end
    if frame then
        local currentPoints = { frame:GetPoint() }
        local movingPx = 1;
        if IsControlKeyDown() then
            movingPx = 0.1;
        else
            if IsShiftKeyDown() then
                movingPx = 10;
            end
        end
        if direction == "left" then
            frame:SetPoint(currentPoints[1], currentPoints[2], currentPoints[3], currentPoints[4] - movingPx,
                currentPoints[5])
        elseif direction == "right" then
            frame:SetPoint(currentPoints[1], currentPoints[2], currentPoints[3], currentPoints[4] + movingPx,
                currentPoints[5])
        elseif direction == "up" then
            frame:SetPoint(currentPoints[1], currentPoints[2], currentPoints[3], currentPoints[4],
                currentPoints[5] + movingPx)
        elseif direction == "down" then
            frame:SetPoint(currentPoints[1], currentPoints[2], currentPoints[3], currentPoints[4],
                currentPoints[5] - movingPx)
        end
        frame:OnDragStop()
    end
end

function FineTune:Toggle(value)
    if value then
        coordText:Show()
        leftArrowButton:Show()
        rightArrowButton:Show()
        upArrowButton:Show()
        downArrowButton:Show()
    else
        coordText:Hide()
        leftArrowButton:Hide()
        rightArrowButton:Hide()
        upArrowButton:Hide()
        downArrowButton:Hide()
    end
end

function FineTune:Initialize()
    FineTune:Toggle(EHUD.db.profile.fineTuneHUD.enable)
end