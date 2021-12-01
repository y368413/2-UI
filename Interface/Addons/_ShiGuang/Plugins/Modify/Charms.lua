local _, ns = ...
local M, R, U, I = unpack(ns)
--[[--------------Item Selling## Author: Spencer Sohn----------------------
local ItemSelling = StaticPopupDialogs["CONFIRM_MERCHANT_TRADE_TIMER_REMOVAL"] 
ItemSelling.OnAccept=nil 
ItemSelling.OnShow=function() StaticPopup_Hide("CONFIRM_MERCHANT_TRADE_TIMER_REMOVAL"); SellCursorItem(); end
----------------ArenaLeaveConfirmer----------------------
hooksecurefunc(StaticPopupDialogs["CONFIRM_LEAVE_BATTLEFIELD"],"OnShow",function(self)
	if IsActiveBattlefieldArena() or GetBattlefieldWinner() then self.button1:Click() end
end)]]
--------------------------------------Hide the left/right end cap------------------------
--MainMenuBarArtFrame.LeftEndCap:Hide()  MainMenuBarArtFrame.RightEndCap:Hide()   
-----------------------------------------	     随机队列倒计时    -----------------------------------------
local timerBar = CreateFrame("StatusBar", nil, LFGDungeonReadyPopup, "BackdropTemplate")
local timeLeft = 0
timerBar:SetPoint("BOTTOM", LFGDungeonReadyPopup, "TOP", 0, 0)
timerBar:SetSize(210, 12)
timerBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar", "BORDER")
timerBar:SetStatusBarColor(1,.1,0)
timerBar:SetBackdrop({
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	tile = true,
	tileSize = 32,
	insets = {left = -1, right = -1, top = -1, bottom = -1},
})
timerBar:Hide()
timerBar.Spark = timerBar:CreateTexture(nil, "OVERLAY")
timerBar.Spark:SetTexture"Interface\\CastingBar\\UI-CastingBar-Spark"
timerBar.Spark:SetSize(32, 32)
timerBar.Spark:SetBlendMode"ADD"
timerBar.Spark:SetPoint("LEFT", timerBar:GetStatusBarTexture(), "RIGHT", -15, 0)
timerBar.Border = timerBar:CreateTexture(nil, "ARTWORK")
timerBar.Border:SetTexture"Interface\\CastingBar\\UI-CastingBar-Border"
timerBar.Border:SetSize(266, 64)
timerBar.Border:SetPoint("TOP", timerBar, 0, 28)
timerBar.Text = timerBar:CreateFontString(nil, "OVERLAY")
timerBar.Text:SetFontObject(GameFontHighlight)
timerBar.Text:SetPoint("CENTER", timerBar, "CENTER")
timerBar:SetScript("OnUpdate", function(self, elapsed)
	timeLeft = (timeLeft or 0) - elapsed
	if(timeLeft <= 0) then return self:Hide() end
	self:SetValue(timeLeft)
	self.Text:SetFormattedText("%.1f", timeLeft)
end)

local LFGDungeonReadyTimeFrame = CreateFrame("Frame")
LFGDungeonReadyTimeFrame:RegisterEvent("LFG_PROPOSAL_SHOW") 
LFGDungeonReadyTimeFrame:SetScript("OnEvent", function(self, event, ...)
	timerBar:SetMinMaxValues(0, 40)
	timeLeft = 40
	timerBar:Show()
end)
----------------EventBossAutoSelect----------------------
LFDParentFrame:HookScript("OnShow",function()
  for i=1,GetNumRandomDungeons() do
   local id,name=GetLFGRandomDungeonInfo(i)
   if(select(15,GetLFGDungeonInfo(id)) and not GetLFGDungeonRewards(id)) then LFDQueueFrame_SetType(id) end
  end
 end)
-------------------------------------------------------------------------------  Auto Reagent Bank
local AutoReagentBank = CreateFrame("Frame")
AutoReagentBank:RegisterEvent("BANKFRAME_OPENED")
AutoReagentBank:SetScript("OnEvent", function(self, event, ...)
  if not R.db["Misc"]["AutoReagentInBank"] then self:UnregisterAllEvents() return end
	if not BankFrameItemButton_Update_OLD then
		BankFrameItemButton_Update_OLD = BankFrameItemButton_Update
		BankFrameItemButton_Update = function(button)
			if BankFrameItemButton_Update_PASS == false then
				BankFrameItemButton_Update_OLD(button)
			else
				BankFrameItemButton_Update_PASS = false
			end
		end
	end
	BankFrameItemButton_Update_PASS = true
	DepositReagentBank()
end)

--[[----------------------------------------------------------------------------- ItemQualityIcons
hooksecurefunc("SetItemButtonQuality", function(button, quality, itemIDOrLink)
	button.IconBorder:Hide()

	local qualityIcon = button.qualityIcon
	if not qualityIcon then
		qualityIcon = CreateFrame("Frame", nil, button)
		qualityIcon:SetAllPoints()
		button.qualityIcon = qualityIcon
	end

	local iconColor = button.iconColor
	if not iconColor then
		iconColor = qualityIcon:CreateTexture("iconColor", "OVERLAY")
		iconColor:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\Role\\bubbleTex")
		iconColor:ClearAllPoints()
		iconColor:SetPoint("TOPRIGHT", -5, -5)
		iconColor:SetSize(9, 9)
	end

	if quality then
		if BAG_ITEM_QUALITY_COLORS[quality] and quality ~= 1 then
			iconColor:SetVertexColor(BAG_ITEM_QUALITY_COLORS[quality].r, BAG_ITEM_QUALITY_COLORS[quality].g, BAG_ITEM_QUALITY_COLORS[quality].b)
		elseif quality == 1 then
			iconColor:SetVertexColor(1, 1, 1)
		elseif quality == 0 then
			iconColor:SetVertexColor(0.61568, 0.61568, 0.61568)
		end

		button.qualityIcon:Show()
	else
		button.qualityIcon:Hide()
	end
end)]]

------------------------------------------------------------------------------- NiceDamage
--Local NiceDamage = CreateFrame("Frame", "NiceDamage");
--function NiceDamage:ApplySystemDamageFonts() DAMAGE_TEXT_FONT = "Interface\\AddOns\\_ShiGuang\\Media\\Fonts\\RedCircl.ttf"; end
--NiceDamage:SetScript("OnEvent", function() if (event == "ADDON_LOADED") then NiceDamage:ApplySystemDamageFonts() end end);
--NiceDamage:RegisterEvent("ADDON_LOADED");
--NiceDamage:ApplySystemDamageFonts()


--[[---------------------------- ## Notes: Automatically destroys items in the pre-defined list    ## Author: Tim @ WoW Interface    ## Version: 1.0
local itemList = {
	--[2287] = true,		-- haunch of meat (tested in RFC)  肉排
}
local DESTROY = CreateFrame("Frame", "AutoItemDestroyer")
DESTROY:RegisterEvent("BAG_UPDATE")
DESTROY:RegisterEvent("BAG_UPDATE_DELAYED")
DESTROY:RegisterEvent("CHAT_MSG_LOOT")
DESTROY:SetScript("OnEvent", function(_, event, ...)
   for bags = 0, 4 do
      for slots = 1, GetContainerNumSlots(bags) do
         local itemLink, linkID = GetContainerItemLink(bags, slots), GetContainerItemID(bags, slots)
         if (itemLink and linkID) then
            if (select(11, GetItemInfo(itemLink)) ~= nil and select(2, GetContainerItemInfo(bags, slots)) ~= nil) then
               local itemName, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _ = GetItemInfo(linkID) 
               if itemList[linkID] then
                  PickupContainerItem(bags, slots)
                  DeleteCursorItem()
                  --print("Searched bags... FOUND & DESTROYED: |cff6699dd", itemName.." [ID: "..linkID.."]")
               end
            end
         end
      end
   end
end)]]

------------------------------------------------------------------------------- 
--## Version: 1.3.6 ## Author: Crinseth
--local undressButton
local toggleSheatheButton
--local resizeButton

--[[ Undress button
undressButton = CreateFrame("Button", nil, DressUpFrame.OutfitDetailsPanel, "UIPanelButtonTemplate")
undressButton:SetSize(80, 21)
undressButton:SetText(CHARMS_NAKEDIZE)
undressButton:SetPoint("BOTTOMLEFT", 6, 4)
undressButton:SetScript("OnClick", function()
    DressUpFrame.ModelScene:GetPlayerActor():Undress()
    PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
end)]]

-- Toggle sheathe button
toggleSheatheButton = CreateFrame("Button", nil, DressUpFrame.OutfitDetailsPanel, "UIPanelButtonTemplate")
toggleSheatheButton:SetSize(80, 21)
toggleSheatheButton:SetText(CHARMS_TARGET)
toggleSheatheButton:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", -82,0)
--[[toggleSheatheButton:SetScript("OnClick", function()
    local playerActor = DressUpFrame.ModelScene:GetPlayerActor()
    playerActor:SetSheathed(not playerActor:GetSheathed())
    PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
end)]]
toggleSheatheButton:Disable()
toggleSheatheButton:SetScript("OnClick", function()
	DressUpFrame.ModelScene:GetPlayerActor():SetModelByUnit("target", false, true)
	updateSlots()
end)
toggleSheatheButton:RegisterEvent("PLAYER_TARGET_CHANGED")
toggleSheatheButton:SetScript("OnEvent", function()
	if UnitExists("target") and UnitIsPlayer("target") then
		toggleSheatheButton:Enable() 
	else 
		toggleSheatheButton:Disable() 
	end
end)

--[[ Resize window button
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
end)]]

-- Hook onto PlayerActor creation in order to hook onto its functions
local _SetupPlayerForModelScene = SetupPlayerForModelScene
function SetupPlayerForModelScene(...)
    -- Resize stuff
    DressUpFrameCancelButton:SetPoint("BOTTOMRIGHT", -20, 4)
    DressUpFrame:SetResizable(true)
    DressUpFrame:SetMinResize(334, 423)
    DressUpFrame:SetMaxResize(DressUpFrame:GetTop() * 0.8, DressUpFrame:GetTop())
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
    return _SetupPlayerForModelScene(...)
end

local _Acquire = DressUpFrame.OutfitDetailsPanel.slotPool.Acquire
function DressUpFrame.OutfitDetailsPanel.slotPool:Acquire()
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

--if not ShowSlots then
    --ShowSlots = false
--end

-- Toggle buttons visibility
local function showButtons(show)
    for slot, slotButtons in pairs(buttons) do
        for i, button in ipairs(slotButtons) do
            if show then
                if i == 1 then
                    button:Show()
                end
            else
                button:Hide()
            end
        end
    --end
    --if show then
        --undressButton:Show()
        --DressUpTargetBtn:Show()
    --else
        --undressButton:Hide()
        --DressUpTargetBtn:Hide()
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

--[[ Settings dropdown
settingsDropdown = CreateFrame("Frame", "DressingSlotsSettingsDropdown", nil, "UIDropDownMenuTemplate")
settingsDropdown.initialize = function(self, level)
    local info = UIDropDownMenu_CreateInfo()

    info.isTitle = 1
    info.text = "DressingSlots"
    info.notCheckable = 1
    UIDropDownMenu_AddButton(info, level)

    info.disabled = nil
    info.isTitle = nil
    info.notCheckable = nil
    info.text = "Show slots"
    info.checked = function()
        return ShowSlots
    end
    info.func = function()
        ShowSlots = not ShowSlots
        showButtons(ShowSlots)
    end
    UIDropDownMenu_AddButton(info, level)
end

-- Settings dropdown toggle button
showSettingsButton = CreateFrame("DropDownToggleButton", "ShowSettingsButton", DressUpFrame.OutfitDetailsPanel)
showSettingsButton:SetSize(27, 27)
showSettingsButton:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Up")
showSettingsButton:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Down")
showSettingsButton:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight", "ADD")
showSettingsButton:SetPoint("BOTTOMLEFT", 205, 6)
showSettingsButton:SetScript("OnClick", function(self)
    ToggleDropDownMenu(1, nil, settingsDropdown, self, 0, 0)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end)]]

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
local _DressUpFrameOutfitDropDown_UpdateSaveButton = DressUpFrameOutfitDropDown.UpdateSaveButton
function DressUpFrameOutfitDropDown:UpdateSaveButton(...)
    updateSlots()
    return _DressUpFrameOutfitDropDown_UpdateSaveButton(self, ...)
end

DressUpFrame.ResetButton:HookScript("OnHide", function ()
    showButtons(false)
end)
DressUpFrame.ResetButton:HookScript("OnShow", function ()
    showButtons(true)
end)


--## Title: Extended Transmog UI  ## Author: Germbread ## Version: 1.1.1
local ExtTransmogUI = CreateFrame("Frame")
ExtTransmogUI:RegisterEvent("ADDON_LOADED")
ExtTransmogUI:SetScript("OnEvent",function(self,event,addon)
    if addon=="Blizzard_Collections" then
		ExtTransmogUI:UnregisterEvent("ADDON_LOADED")
		WardrobeFrame:SetWidth(1200);
    --WardrobeFrame:SetScale(0.82);
    WardrobeTransmogFrame.Inset.BG:SetWidth(529);
    WardrobeTransmogFrame:SetWidth(535);
    WardrobeTransmogFrame.ModelScene:ClearAllPoints();
    WardrobeTransmogFrame.ModelScene:SetPoint("TOP", WardrobeTransmogFrame, "TOP", 0, -4);
    WardrobeTransmogFrame.ModelScene:SetWidth(420);
    WardrobeTransmogFrame.ModelScene:SetHeight(420);
    
    --WardrobeTransmogFrame.HeadButton:ClearAllPoints();
    --WardrobeTransmogFrame.HeadButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -238, -41);
    WardrobeTransmogFrame.WristButton:ClearAllPoints();
    WardrobeTransmogFrame.WristButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", 235, -88);
    WardrobeTransmogFrame.HandsButton:ClearAllPoints();
    WardrobeTransmogFrame.HandsButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", 235, -142);
    WardrobeTransmogFrame.ShoulderButton:ClearAllPoints();
    WardrobeTransmogFrame.ShoulderButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -238, -88);
	
    --SecondaryShoulderButton
	--WardrobeTransmogFrame.SecondaryShoulderButton:ClearAllPoints();
    --WardrobeTransmogFrame.SecondaryShoulderButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -270, -130);
    
    WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:ClearAllPoints();
    WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:SetPoint("BOTTOMLEFT", WardrobeTransmogFrame.ModelScene, "TOP", 38, 3);

    WardrobeTransmogFrame.MainHandButton:ClearAllPoints();
    WardrobeTransmogFrame.MainHandButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "BOTTOM", -26, -5);
    WardrobeTransmogFrame.SecondaryHandButton:ClearAllPoints();
    WardrobeTransmogFrame.SecondaryHandButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "BOTTOM", 27, -5);
    WardrobeTransmogFrame.MainHandEnchantButton:ClearAllPoints();
    WardrobeTransmogFrame.MainHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene.MainHandButton, "BOTTOM", 0, -20);
    WardrobeTransmogFrame.SecondaryHandEnchantButton:ClearAllPoints();
    WardrobeTransmogFrame.SecondaryHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene.SecondaryHandButton, "BOTTOM", 0, -20); 
    
    UIPanelWindows["WardrobeFrame"].width = 1200;   
    
    	--[[ General Settings --
    WardrobeFrame:SetWidth(1650);
	WardrobeFrame:SetHeight(900);

	--WardrobeTransmogFrame--
	WardrobeTransmogFrame:SetWidth(950);
	WardrobeTransmogFrame:SetHeight(785);
	
	WardrobeTransmogFrame.Inset.BG:SetWidth(770);
	WardrobeTransmogFrame.Inset.BG:SetHeight(760);

	--WardrobeTransmogFrame.Model--
    WardrobeTransmogFrame.ModelScene:SetWidth(760);
    WardrobeTransmogFrame.ModelScene:SetHeight(750);																
	
    WardrobeTransmogFrame.ModelScene:ClearAllPoints();
    WardrobeTransmogFrame.ModelScene:SetPoint("TOP", WardrobeTransmogFrame, "TOP", 0, -4);



	--Helm
    WardrobeTransmogFrame.HeadButton:ClearAllPoints();
    WardrobeTransmogFrame.HeadButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -320, -80);
	WardrobeTransmogFrame.HeadButton:SetScale(1.25);


	-- Shoulders
	-- dual pauldron box
	WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:ClearAllPoints();
	WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -450, -15);
	
	--Shoulder
	WardrobeTransmogFrame.ShoulderButton:ClearAllPoints();
    WardrobeTransmogFrame.ShoulderButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -320, -130);
	WardrobeTransmogFrame.ShoulderButton:SetScale(1.25);
	
    --SecondaryShoulderButton
	WardrobeTransmogFrame.SecondaryShoulderButton:ClearAllPoints();
    WardrobeTransmogFrame.SecondaryShoulderButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -270, -130);
	WardrobeTransmogFrame.SecondaryShoulderButton:SetScale(1.25);
	
	--Cloak
	WardrobeTransmogFrame.BackButton:ClearAllPoints();
    WardrobeTransmogFrame.BackButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -320, -180);
	WardrobeTransmogFrame.BackButton:SetScale(1.25);
	
	--Chest
	WardrobeTransmogFrame.ChestButton:ClearAllPoints();
    WardrobeTransmogFrame.ChestButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -320, -230);
	WardrobeTransmogFrame.ChestButton:SetScale(1.25);
	
	
	--Shirt
	WardrobeTransmogFrame.ShirtButton:ClearAllPoints();
    WardrobeTransmogFrame.ShirtButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -320, -280);
	WardrobeTransmogFrame.ShirtButton:SetScale(1.25);
	
	--Tabby
	WardrobeTransmogFrame.TabardButton:ClearAllPoints();
    WardrobeTransmogFrame.TabardButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -320, -330);
	WardrobeTransmogFrame.TabardButton:SetScale(1.25);
	
	--Bracers
	WardrobeTransmogFrame.WristButton:ClearAllPoints();
    WardrobeTransmogFrame.WristButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", -320, -380);
	WardrobeTransmogFrame.WristButton:SetScale(1.25);
	
	--Gloves
    WardrobeTransmogFrame.HandsButton:ClearAllPoints();
	WardrobeTransmogFrame.HandsButton:SetScale(1.25);
    WardrobeTransmogFrame.HandsButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", 320, -80);
	
	--Belt
	WardrobeTransmogFrame.WaistButton:ClearAllPoints();
	WardrobeTransmogFrame.WaistButton:SetScale(1.25);
    WardrobeTransmogFrame.WaistButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", 320, -130);
	
	--Legs
	WardrobeTransmogFrame.LegsButton:ClearAllPoints();
	
	WardrobeTransmogFrame.LegsButton:SetScale(1.25);
    WardrobeTransmogFrame.LegsButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", 320, -180);
	
	--Boots
	
	WardrobeTransmogFrame.FeetButton:ClearAllPoints();
	WardrobeTransmogFrame.FeetButton:SetScale(1.25);
    WardrobeTransmogFrame.FeetButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "TOP", 320, -230);

	

	--MH
    WardrobeTransmogFrame.MainHandButton:ClearAllPoints();
	WardrobeTransmogFrame.MainHandButton:SetScale(1.25);
    WardrobeTransmogFrame.MainHandButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "BOTTOM", 320, 200);]]
	
    WardrobeTransmogFrame.MainHandEnchantButton:ClearAllPoints();
	--WardrobeTransmogFrame.MainHandEnchantButton:SetScale(1.25);
    WardrobeTransmogFrame.MainHandEnchantButton:SetPoint("RIGHT", WardrobeTransmogFrame.MainHandButton, "LEFT", 0, 0);
	
	
	--OH
	--WardrobeTransmogFrame.SecondaryHandButton:ClearAllPoints();
	--WardrobeTransmogFrame.SecondaryHandButton:SetScale(1.25);
    --WardrobeTransmogFrame.SecondaryHandButton:SetPoint("TOP", WardrobeTransmogFrame.ModelScene, "BOTTOM", 320, 120);
	
    WardrobeTransmogFrame.SecondaryHandEnchantButton:ClearAllPoints();
	--WardrobeTransmogFrame.SecondaryHandEnchantButton:SetScale(1.25);
    WardrobeTransmogFrame.SecondaryHandEnchantButton:SetPoint("LEFT", WardrobeTransmogFrame.SecondaryHandButton, "RIGHT", 0, 0);
	end
end)

local AutoViewDistance = CreateFrame("Frame", "AutoViewDistance")
AutoViewDistance:RegisterEvent("LOADING_SCREEN_DISABLED") 
AutoViewDistance:RegisterEvent("LOADING_SCREEN_ENABLED")
AutoViewDistance:RegisterEvent("PLAYER_LOGOUT") 
AutoViewDistance:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
	if event == "LOADING_SCREEN_ENABLED" then
		if GetCVar("graphicsViewDistance") ~= 1 then SetCVar("graphicsViewDistance", 1) end
	elseif event == "LOADING_SCREEN_DISABLED" then
		if GetCVar("graphicsViewDistance") ~= 5 then SetCVar("graphicsViewDistance", 5) end
	elseif event == "PLAYER_LOGOUT" then
		if GetCVar("graphicsViewDistance") ~= 1 then SetCVar("graphicsViewDistance", 1) end
	end
end)
