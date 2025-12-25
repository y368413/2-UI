---------- DressingSlots--## Version: 1.5.1 ## Author: Crinseth
local version, build, date, tocversion = GetBuildInfo()
local undressButton
local TargetButton
local toggleSheatheButton
local resizeButton

-- Temporary support for TWW until Midnight
local SideDetailPanel
if tocversion < 120000 then
    SideDetailPanel = DressUpFrame.OutfitDetailsPanel
else
    SideDetailPanel = DressUpFrame.CustomSetDetailsPanel
end

--[[ Undress button
undressButton = CreateFrame("Button", nil, SideDetailPanel, "UIPanelButtonTemplate")
undressButton:SetSize(80, 22)
undressButton:SetText("Undress")
undressButton:SetPoint("BOTTOMLEFT", 8, 9) --7
undressButton:SetScript("OnClick", function()
    DressUpFrame.ModelScene:GetPlayerActor():Undress()
    PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
end)]]

-- Target button
TargetButton = CreateFrame("Button", nil, SideDetailPanel, "UIPanelButtonTemplate")
TargetButton:SetSize(80, 22)
TargetButton:SetText(CHARMS_TARGET)
TargetButton:SetPoint("BOTTOMLEFT", 8, 9) --7
TargetButton:Disable()
TargetButton:SetScript("OnClick", function()
	DressUpFrame.ModelScene:GetPlayerActor():SetModelByUnit("target", false, true)
	--updateSlots()
end)
TargetButton:RegisterEvent("PLAYER_TARGET_CHANGED")
TargetButton:SetScript("OnEvent", function()
	if UnitExists("target") and UnitIsPlayer("target") then
		TargetButton:Enable() 
	else 
		TargetButton:Disable() 
	end
end)

-- Toggle sheathe button
toggleSheatheButton = CreateFrame("Button", nil, SideDetailPanel, "UIPanelButtonTemplate")
toggleSheatheButton:SetSize(80, 22)
toggleSheatheButton:SetText(WEAPON)
toggleSheatheButton:SetPoint("BOTTOMLEFT", 88, 9)
toggleSheatheButton:SetScript("OnClick", function()
    local playerActor = DressUpFrame.ModelScene:GetPlayerActor()
    playerActor:SetSheathed(not playerActor:GetSheathed())
    PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
end)

-- Resize window button
resizeButton = CreateFrame("Button", nil, DressUpFrame)
resizeButton:SetSize(16, 16)
resizeButton:SetNormalTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Up")
resizeButton:SetHighlightTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Highlight")
resizeButton:SetPushedTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Down")
resizeButton:SetPoint("BOTTOMRIGHT", -2, 2)
resizeButton:SetScript("OnMouseDown", function(self, button)
    DressUpFrame:StartSizing("BOTTOMRIGHT")
end)
resizeButton:SetScript("OnMouseUp", function(self, button)
    DressUpFrame:StopMovingOrSizing()
    UpdateUIPanelPositions(self)
    DressHeight = DressUpFrame:GetHeight()
    DressWidth = DressUpFrame:GetWidth()
end)

DressUpFrame.ResetButton:HookScript("OnHide", function ()
    resizeButton:Hide()
end)
DressUpFrame.ResetButton:HookScript("OnShow", function ()
    resizeButton:Show()
end)

-- Hook onto DressUpFrame ConfigureSize in order to provide resize functionality
local _ConfigureSize = DressUpFrame.ConfigureSize
function DressUpFrame:ConfigureSize(isMinimized)
    local result = _ConfigureSize(self, isMinimized)
    -- Resize stuff
    DressUpFrameCancelButton:SetPoint("BOTTOMRIGHT", -14, 4)
    DressUpFrame:SetResizable(true)
        --DressUpFrame:SetMinResize(334, 423)
        --DressUpFrame:SetMaxResize(DressUpFrame:GetTop() * 0.8, DressUpFrame:GetTop())
    DressUpFrame:SetResizeBounds(334, 423, DressUpFrame:GetTop() * 0.8, DressUpFrame:GetTop())
    if DressHeight and DressHeight <= DressUpFrame:GetTop() and DressWidth <= (DressUpFrame:GetTop()) then
        DressUpFrame:SetSize(DressWidth, DressHeight)
        UpdateUIPanelPositions(self)
    end
    -- Listen for minimize/maximize to reset size
    local maximize = DressUpFrame.MaximizeMinimizeFrame.MaximizeButton:GetScript("OnClick")
    DressUpFrame.MaximizeMinimizeFrame.MaximizeButton:SetScript("OnClick", function(self)
        DressHeight = nil
        DressWidth = nil
        maximize(self)
    end)
    local minimize = DressUpFrame.MaximizeMinimizeFrame.MinimizeButton:GetScript("OnClick")
    DressUpFrame.MaximizeMinimizeFrame.MinimizeButton:SetScript("OnClick", function(self)
        DressHeight = nil
        DressWidth = nil
        minimize(self)
    end)
    return result
end

-- Handle right-clicks for each "slot" in the appearance list
local _Acquire = SideDetailPanel.slotPool.Acquire
function SideDetailPanel.slotPool:Acquire()
    local frame, isNew = _Acquire(self)
    if isNew then
        frame:HookScript("OnMouseUp", function (self, button)
            if button == "RightButton" then
                local playerActor = DressUpFrame.ModelScene:GetPlayerActor()
                local itemTransmogInfo = playerActor:GetItemTransmogInfo(frame.slotID)
                if itemTransmogInfo then
                    if itemTransmogInfo.secondaryAppearanceID ~= Constants.Transmog.NoTransmogID and itemTransmogInfo.secondaryAppearanceID ~= -1 then
                        if frame.transmogID == itemTransmogInfo.appearanceID then
                            itemTransmogInfo.appearanceID = itemTransmogInfo.secondaryAppearanceID
                        end
                        if C_TransmogCollection.IsAppearanceHiddenVisual(itemTransmogInfo.appearanceID) then
                            itemTransmogInfo.secondaryAppearanceID = itemTransmogInfo.appearanceID
                            playerActor:SetItemTransmogInfo(itemTransmogInfo, frame.slotID, false)
                            playerActor:UndressSlot(frame.slotID)
                        else
                            itemTransmogInfo.secondaryAppearanceID = Constants.Transmog.NoTransmogID
                            playerActor:SetItemTransmogInfo(itemTransmogInfo, frame.slotID, false)
                        end
                    elseif frame.transmogID == itemTransmogInfo.illusionID then
                        itemTransmogInfo.illusionID = Constants.Transmog.NoTransmogID
                        playerActor:SetItemTransmogInfo(itemTransmogInfo, frame.slotID, false)
                    else
                        playerActor:UndressSlot(frame.slotID)
                    end
                    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
                end
            end
        end)
    end
    return frame, isNew
end


local SLOTS = {
	"HeadSlot",
	"ShoulderSlot",
	"BackSlot",
	"ChestSlot",
	"ShirtSlot",
	"TabardSlot",
	"WristSlot",

	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",

	"MainHandSlot",
	"SecondaryHandSlot",
}
local HIDDEN_SOURCES = {
	[77344] = true, -- head
	[77343] = true, -- shoulder
	[77345] = true, -- back
	[83202] = true, -- shirt
	[83203] = true, -- tabard
	[84223] = true, -- waist
}
local buttons = {}
local updateSlots
local makePrimarySlotButton
local makeSecondarySlotButton

-- Toggle buttons visibility
local function showButtons(show)
    for slot, slotButtons in pairs(buttons) do
        for i, button in ipairs(slotButtons) do
            if show then
                button:Show()
            else
                button:Hide()
            end
        end
    end
end
-- Button click event
local function onClick(self, button)
	if button == "RightButton" then
        local playerActor = DressUpFrame.ModelScene:GetPlayerActor()
        local slotID = GetInventorySlotInfo(self.slot)
        local itemTransmogInfo = playerActor:GetItemTransmogInfo(slotID)
        if itemTransmogInfo.secondaryAppearanceID ~= Constants.Transmog.NoTransmogID and itemTransmogInfo.secondaryAppearanceID ~= -1 then
            itemTransmogInfo.appearanceID = itemTransmogInfo.secondaryAppearanceID
            itemTransmogInfo.secondaryAppearanceID = Constants.Transmog.NoTransmogID
            playerActor:SetItemTransmogInfo(itemTransmogInfo, slotID, false)
        else
            playerActor:UndressSlot(slotID)
        end
        updateSlots()
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	elseif self.item and IsModifiedClick() then
		HandleModifiedItemClick(self.item)
	end
end
local function secondaryOnClick(self, button)
	if button == "RightButton" then
        local playerActor = DressUpFrame.ModelScene:GetPlayerActor()
        local slotID = GetInventorySlotInfo(self.slot)
        local itemTransmogInfo = playerActor:GetItemTransmogInfo(slotID)
        itemTransmogInfo.secondaryAppearanceID = Constants.Transmog.NoTransmogID
        playerActor:SetItemTransmogInfo(itemTransmogInfo, slotID, false)
        updateSlots()
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	elseif self.item and IsModifiedClick() then
		HandleModifiedItemClick(self.item)
	end
end
-- Button hover event
local function onEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	if self.item then
		GameTooltip:SetHyperlink(self.item)
	else
		GameTooltip:SetText(self.text or _G[string.upper(self.slot)])
	end
end
-- Button size constants
local buttonSize = 35
local secondaryButtonSize = 25
local buttonSizeWithPadding = buttonSize + 5
local sideInsetLeft = 10
local sideInsetRight = 12
local topInset = -80
-- Create item slot buttons
makePrimarySlotButton = function(i, slot)
    local button = CreateFrame("Button", nil, DressUpFrame)
    button.slot = slot
    button:SetFrameStrata("HIGH")
    button:SetSize(buttonSize, buttonSize)
    if i <= 7 then
        button:SetPoint("TOPLEFT", sideInsetLeft, topInset + -buttonSizeWithPadding * (i - 1))
    else
        local place = i
        if i > 11 then
            place = place + 1
        end
        button:SetPoint("TOPRIGHT", -sideInsetRight, topInset + -buttonSizeWithPadding * (place - 8))
    end
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:SetMotionScriptsWhileDisabled(true)
    button:SetScript("OnClick", onClick)
    button:SetScript("OnEnter", onEnter)
    button:SetScript("OnLeave", GameTooltip_Hide)

    button.icon = button:CreateTexture(nil, "BACKGROUND")
    button.icon:SetSize(buttonSize, buttonSize)
    button.icon:SetPoint("CENTER")

    button.highlight = button:CreateTexture()
    button.highlight:SetSize(buttonSize, buttonSize)
    button.highlight:SetPoint("CENTER")
    button.highlight:SetAtlas("bags-glow-white")
    button.highlight:SetBlendMode("ADD")
    button:SetHighlightTexture(button.highlight)

    return button
end
makeSecondarySlotButton = function(i, slot)
    local button = CreateFrame("Button", nil, DressUpFrame)
    button.slot = slot
    button:SetFrameStrata("HIGH")
    button:SetSize(secondaryButtonSize, secondaryButtonSize)
    if i <= 7 then
        button:SetPoint("TOPLEFT", sideInsetLeft + buttonSizeWithPadding, topInset + -buttonSizeWithPadding * (i - 1))
    else
        local place = i
        if i > 11 then
            place = place + 1
        end
        button:SetPoint("TOPRIGHT", -sideInsetRight - buttonSizeWithPadding, topInset + -buttonSizeWithPadding * (place - 8))
    end
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:SetMotionScriptsWhileDisabled(true)
    button:SetScript("OnClick", secondaryOnClick)
    button:SetScript("OnEnter", onEnter)
    button:SetScript("OnLeave", GameTooltip_Hide)

    button.icon = button:CreateTexture(nil, "BACKGROUND")
    button.icon:SetSize(secondaryButtonSize, secondaryButtonSize)
    button.icon:SetPoint("CENTER")

    button.highlight = button:CreateTexture()
    button.highlight:SetSize(secondaryButtonSize, secondaryButtonSize)
    button.highlight:SetPoint("CENTER")
    button.highlight:SetAtlas("bags-glow-white")
    button.highlight:SetBlendMode("ADD")
    button:SetHighlightTexture(button.highlight)

    return button
end
for i, slot in ipairs(SLOTS) do
    local primaryButton = makePrimarySlotButton(i, slot)
    local secondaryButton = makeSecondarySlotButton(i, slot)

    buttons[slot] = {primaryButton, secondaryButton}
    if masqueGroup then
        masqueGroup:AddButton(primaryButton)
        masqueGroup:AddButton(secondaryButton)
    end
end

-- Updates slot buttons content based on PlayerActor
updateSlots = function()
    local playerActor = DressUpFrame.ModelScene:GetPlayerActor()
    if playerActor then
        for slot, slotButtons in pairs(buttons) do
            local primaryButton = slotButtons[1]
            local secondaryButton = slotButtons[2]
            local slotID, slotTexture = GetInventorySlotInfo(slot)
            local itemTransmogInfo = playerActor:GetItemTransmogInfo(slotID)
		    if itemTransmogInfo == nil or HIDDEN_SOURCES[itemTransmogInfo.appearanceID] then
			    primaryButton.item = nil
			    primaryButton.text = nil
			    primaryButton.icon:SetTexture(slotTexture)
			    primaryButton:Disable()
		    else
			    local categoryID, appearanceID, canEnchant, icon, isCollected, link = C_TransmogCollection.GetAppearanceSourceInfo(itemTransmogInfo.appearanceID)
			    primaryButton.item = link
			    primaryButton.text = UNKNOWN
			    primaryButton.icon:SetTexture(icon or [[Interface\Icons\INV_Misc_QuestionMark]])
			    primaryButton:Enable()
		    end
            if itemTransmogInfo ~= nil and itemTransmogInfo.secondaryAppearanceID ~= Constants.Transmog.NoTransmogID and not HIDDEN_SOURCES[itemTransmogInfo.secondaryAppearanceID] and itemTransmogInfo.secondaryAppearanceID ~= -1 then
                local categoryID, appearanceID, canEnchant, icon, isCollected, link = C_TransmogCollection.GetAppearanceSourceInfo(itemTransmogInfo.secondaryAppearanceID)
			    secondaryButton.item = link
			    secondaryButton.text = UNKNOWN
			    secondaryButton.icon:SetTexture(icon or [[Interface\Icons\INV_Misc_QuestionMark]])
			    secondaryButton:Enable()
                if DressUpFrame.ResetButton:IsShown() then
                    secondaryButton:Show()
                end
            else
                secondaryButton:Hide()
            end
        end
    end
end
-- Hook onto save button update events to trigger slot updates
local _DressUpFrameOutfitDropdown_UpdateSaveButton = DressUpFrameOutfitDropdown.UpdateSaveButton
function DressUpFrameOutfitDropdown:UpdateSaveButton(...)
    updateSlots()
    return _DressUpFrameOutfitDropdown_UpdateSaveButton(self, ...)
end
DressUpFrame.ResetButton:HookScript("OnHide", function ()
    showButtons(false)
end)
DressUpFrame.ResetButton:HookScript("OnShow", function ()
    showButtons(true)
end)

-- TransmogrifyResize ## Version: 1.7  ## Author: Eskiso
local function Round(number, decimals)
    local power = 10 ^ decimals
    return math.floor(number * power) / power
end
local TransmogrifyResize = CreateFrame("Frame");
TransmogrifyResize:RegisterEvent("TRANSMOG_COLLECTION_UPDATED")
TransmogrifyResize:SetScript("OnEvent", function(self,event, ...)
    if not C_Transmog.IsAtTransmogNPC() then return end
    
    local initialParentFrameWidth = WardrobeFrame:GetWidth() -- Expecting 965
    local desiredParentFrameWidth = 1200
    local parentFrameWidthIncrease = desiredParentFrameWidth - initialParentFrameWidth
    WardrobeFrame:SetWidth(desiredParentFrameWidth)

    local initialTransmogFrameWidth = WardrobeTransmogFrame:GetWidth()
    local desiredTransmogFrameWidth = initialTransmogFrameWidth + parentFrameWidthIncrease
    WardrobeTransmogFrame:SetWidth(desiredTransmogFrameWidth)

    -- These frames are built using absolute sizes instead of relative points for some reason. Let's stick with that..
    local insetWidth = Round(initialTransmogFrameWidth - WardrobeTransmogFrame.ModelScene:GetWidth(), 0)
    WardrobeTransmogFrame.Inset.BG:SetWidth(WardrobeTransmogFrame.Inset.Bg:GetWidth() - insetWidth)
    WardrobeTransmogFrame.ModelScene:SetWidth(WardrobeTransmogFrame:GetWidth() - insetWidth)
    WardrobeTransmogFrame.HeadButton:SetPoint("LEFT", WardrobeTransmogFrame.ModelScene,"LEFT", 15, 100);
    WardrobeTransmogFrame.HandsButton:SetPoint("TOPRIGHT", WardrobeTransmogFrame.ModelScene,"TOPRIGHT", -15, 0);
    WardrobeTransmogFrame.MainHandButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", -50, 15);
    WardrobeTransmogFrame.SecondaryHandButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 50, 15);
    WardrobeTransmogFrame.MainHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 100, 20);
    WardrobeTransmogFrame.SecondaryHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 100, 20);
    WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:SetPoint("LEFT", WardrobeTransmogFrame.ModelScene,"TOPRIGHT", 50, -200);
end)