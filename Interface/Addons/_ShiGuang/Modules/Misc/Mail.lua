local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local wipe, select, pairs, tonumber = wipe, select, pairs, tonumber
local strsplit, strfind, tinsert = strsplit, strfind, tinsert
local InboxItemCanDelete, DeleteInboxItem, TakeInboxMoney, TakeInboxItem = InboxItemCanDelete, DeleteInboxItem, TakeInboxMoney, TakeInboxItem
local GetInboxNumItems, GetInboxHeaderInfo, GetInboxItem, GetItemInfo = GetInboxNumItems, GetInboxHeaderInfo, GetInboxItem, GetItemInfo
local GetSendMailPrice, GetMoney = GetSendMailPrice, GetMoney
local C_Timer_After = C_Timer.After
local C_Mail_HasInboxMoney = C_Mail.HasInboxMoney
local C_Mail_IsCommandPending = C_Mail.IsCommandPending
local ATTACHMENTS_MAX_RECEIVE, ERR_MAIL_DELETE_ITEM_ERROR = ATTACHMENTS_MAX_RECEIVE, ERR_MAIL_DELETE_ITEM_ERROR
local NORMAL_STRING = GUILDCONTROL_OPTION16
local OPENING_STRING = OPEN_ALL_MAIL_BUTTON_OPENING

local mailIndex, timeToWait, totalCash, inboxItems = 0, .15, 0, {}
local isGoldCollecting

function MISC:MailBox_DelectClick()
	local selectedID = self.id + (InboxFrame.pageNum-1)*7
	if InboxItemCanDelete(selectedID) then
		DeleteInboxItem(selectedID)
	else
		UIErrorsFrame:AddMessage(I.InfoColor..ERR_MAIL_DELETE_ITEM_ERROR)
	end
end

function MISC:MailItem_AddDelete(i)
	local bu = CreateFrame("Button", nil, self)
	bu:SetPoint("BOTTOMRIGHT", self:GetParent(), "BOTTOMRIGHT", -8, 6)
	bu:SetSize(14, 14)
	M.PixelIcon(bu, 136813, true)
	bu.id = i
	bu:SetScript("OnClick", MISC.MailBox_DelectClick)
	M.AddTooltip(bu, "ANCHOR_RIGHT", DELETE, "system")
end

function MISC:InboxItem_OnEnter()
	if not self.index then return end -- may receive fake mails from Narcissus
	wipe(inboxItems)

	local itemAttached = select(8, GetInboxHeaderInfo(self.index))
	if itemAttached then
		for attachID = 1, 12 do
			local _, itemID, _, itemCount = GetInboxItem(self.index, attachID)
			if itemCount and itemCount > 0 then
				inboxItems[itemID] = (inboxItems[itemID] or 0) + itemCount
			end
		end

		if itemAttached > 1 then
			GameTooltip:AddLine(U["Attach List"])
			for itemID, count in pairs(inboxItems) do
				local itemName, _, itemQuality, _, _, _, _, _, _, itemTexture = GetItemInfo(itemID)
				if itemName then
					local r, g, b = GetItemQualityColor(itemQuality)
					GameTooltip:AddDoubleLine(" |T"..itemTexture..":12:12:0:0:50:50:4:46:4:46|t "..itemName, count, r, g, b)
				end
			end
			GameTooltip:Show()
		end
	end
end

local contactList = {}
local contactListByRealm = {}

function MISC:ContactButton_OnClick()
	local text = self.name:GetText() or ""
	SendMailNameEditBox:SetText(text)
	SendMailNameEditBox:SetCursorPosition(0)
end

function MISC:ContactButton_Delete()
	MaoRUIDB["ContactList"][self.__owner.name:GetText()] = nil
	MISC:ContactList_Refresh()
end

function MISC:ContactButton_Create(parent, index)
	local button = CreateFrame("Button", nil, parent)
	button:SetSize(150, 20)
	button:SetPoint("TOPLEFT", 2, -2 - (index-1) *20)
	button.HL = button:CreateTexture(nil, "HIGHLIGHT")
	button.HL:SetAllPoints()
	button.HL:SetColorTexture(1, 1, 1, .25)

	button.name = M.CreateFS(button, 13, "Name", false, "LEFT", 0, 0)
	button.name:SetPoint("RIGHT", button, "LEFT", 155, 0)
	button.name:SetJustifyH("LEFT")

	button:RegisterForClicks("AnyUp")
	button:SetScript("OnClick", MISC.ContactButton_OnClick)

	button.delete = M.CreateButton(button, 20, 20, true, "Interface\\RAIDFRAME\\ReadyCheck-NotReady")
	button.delete:SetPoint("LEFT", button, "RIGHT", 2, 0)
	button.delete.__owner = button
	button.delete:SetScript("OnClick", MISC.ContactButton_Delete)

	return button
end

local function GenerateDataByRealm(realm)
	if contactListByRealm[realm] then
		for name, color in pairs(contactListByRealm[realm]) do
			local r, g, b = strsplit(":", color)
			tinsert(contactList, {name = name.."-"..realm, r = r, g = g, b = b})
		end
	end
end

function MISC:ContactList_Refresh()
	wipe(contactList)
	wipe(contactListByRealm)

	for fullname, color in pairs(MaoRUIDB["ContactList"]) do
		local name, realm = strsplit("-", fullname)
		if not contactListByRealm[realm] then contactListByRealm[realm] = {} end
		contactListByRealm[realm][name] = color
	end

	GenerateDataByRealm(I.MyRealm)

	for realm in pairs(contactListByRealm) do
		if realm ~= I.MyRealm then
			GenerateDataByRealm(realm)
		end
	end

	MISC:ContactList_Update()
end

function MISC:ContactButton_Update(button)
	local index = button.index
	local info = contactList[index]

	button.name:SetText(info.name)
	button.name:SetTextColor(info.r, info.g, info.b)
end

function MISC:ContactList_Update()
	local scrollFrame = _G.UIMailBoxScrollFrame
	local usedHeight = 0
	local buttons = scrollFrame.buttons
	local height = scrollFrame.buttonHeight
	local numFriendButtons = #contactList
	local offset = HybridScrollFrame_GetOffset(scrollFrame)

	for i = 1, #buttons do
		local button = buttons[i]
		local index = offset + i
		if index <= numFriendButtons then
			button.index = index
			MISC:ContactButton_Update(button)
			usedHeight = usedHeight + height
			button:Show()
		else
			button.index = nil
			button:Hide()
		end
	end

	HybridScrollFrame_Update(scrollFrame, numFriendButtons*height, usedHeight)
end

function MISC:ContactList_OnMouseWheel(delta)
	local scrollBar = self.scrollBar
	local step = delta*self.buttonHeight
	if IsShiftKeyDown() then
		step = step*18
	end
	scrollBar:SetValue(scrollBar:GetValue() - step)
	MISC:ContactList_Update()
end

function MISC:MailBox_ContactList()
	local bu = M.CreateGear(SendMailFrame)
	bu:SetPoint("LEFT", SendMailNameEditBox, "RIGHT", 3, 0)

	local list = CreateFrame("Frame", nil, bu)
	list:SetSize(200, 424)
	list:SetPoint("TOPLEFT", MailFrame, "TOPRIGHT", 3, -R.mult)
	list:SetFrameStrata("Tooltip")
	M.SetBD(list)
	M.CreateFS(list, 14, U["ContactList"], "system", "TOP", 0, -5)

	bu:SetScript("OnClick", function()
		M:TogglePanel(list)
	end)

	local editbox = M.CreateEditBox(list, 120, 20)
	editbox:SetPoint("TOPLEFT", 5, -25)
	M.AddTooltip(editbox, "ANCHOR_BOTTOMRIGHT", I.InfoColor..U["AddContactTip"], "info", true)
	local swatch = M.CreateColorSwatch(list, "")
	swatch:SetPoint("LEFT", editbox, "RIGHT", 5, 0)
	local add = M.CreateButton(list, 42, 22, ADD, 14)
	add:SetPoint("LEFT", swatch, "RIGHT", 5, 0)
	add:SetScript("OnClick", function()
		local text = editbox:GetText()
		if text == "" or tonumber(text) then return end -- incorrect input
		if not strfind(text, "-") then text = text.."-"..I.MyRealm end -- complete player realm name
		if MaoRUIDB["ContactList"][text] then return end -- unit exists

		local r, g, b = swatch.tex:GetColor()
		MaoRUIDB["ContactList"][text] = r..":"..g..":"..b
		MISC:ContactList_Refresh()
		editbox:SetText("")
	end)

	local scrollFrame = CreateFrame("ScrollFrame", "UIMailBoxScrollFrame", list, "HybridScrollFrameTemplate")
	scrollFrame:SetSize(175, 370)
	scrollFrame:SetPoint("BOTTOMLEFT", 5, 5)
	M.CreateBDFrame(scrollFrame, .25)
	list.scrollFrame = scrollFrame

	local scrollBar = CreateFrame("Slider", "$parentScrollBar", scrollFrame, "HybridScrollBarTemplate")
	scrollBar.doNotHide = true
	M.ReskinScroll(scrollBar)
	scrollFrame.scrollBar = scrollBar

	local scrollChild = scrollFrame.scrollChild
	local numButtons = 19 + 1
	local buttonHeight = 22
	local buttons = {}
	for i = 1, numButtons do
		buttons[i] = MISC:ContactButton_Create(scrollChild, i)
	end

	scrollFrame.buttons = buttons
	scrollFrame.buttonHeight = buttonHeight
	scrollFrame.update = MISC.ContactList_Update
	scrollFrame:SetScript("OnMouseWheel", MISC.ContactList_OnMouseWheel)
	scrollChild:SetSize(scrollFrame:GetWidth(), numButtons * buttonHeight)
	scrollFrame:SetVerticalScroll(0)
	scrollFrame:UpdateScrollChildRect()
	scrollBar:SetMinMaxValues(0, numButtons * buttonHeight)
	scrollBar:SetValue(0)

	MISC:ContactList_Refresh()
end

function MISC:MailBox_CollectGold()
	if mailIndex > 0 then
		if not C_Mail_IsCommandPending() then
			if C_Mail_HasInboxMoney(mailIndex) then
				TakeInboxMoney(mailIndex)
			end
			mailIndex = mailIndex - 1
		end
		C_Timer_After(timeToWait, MISC.MailBox_CollectGold)
	else
		isGoldCollecting = false
		MISC:UpdateOpeningText()
	end
end

function MISC:MailBox_CollectAllGold()
	if isGoldCollecting then return end
	if totalCash == 0 then return end

	isGoldCollecting = true
	mailIndex = GetInboxNumItems()
	MISC:UpdateOpeningText(true)
	MISC:MailBox_CollectGold()
end

function MISC:TotalCash_OnEnter()
	local numItems = GetInboxNumItems()
	if numItems == 0 then return end

	for i = 1, numItems do
		totalCash = totalCash + select(5, GetInboxHeaderInfo(i))
	end

	if totalCash > 0 then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(U["TotalGold"])
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(MISC:GetMoneyString(totalCash, true), 1,1,1)
		GameTooltip:Show()
	end
end

function MISC:TotalCash_OnLeave()
	M:HideTooltip()
	totalCash = 0
end

function MISC:UpdateOpeningText(opening)
	if opening then
		MISC.GoldButton:SetText(OPENING_STRING)
	else
		MISC.GoldButton:SetText(NORMAL_STRING)
	end
end

function MISC:MailBox_CreatButton(parent, width, height, text, anchor)
	local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	button:SetSize(width, height)
	button:SetPoint(unpack(anchor))
	button:SetText(text)

	return button
end

function MISC:CollectGoldButton()
	OpenAllMail:ClearAllPoints()
	OpenAllMail:SetPoint("TOPLEFT", InboxFrame, "TOPLEFT", 50, -30)

	local button = MISC:MailBox_CreatButton(InboxFrame, 80, 25, "", {"LEFT", OpenAllMail, "RIGHT", 0, 0})
	button:SetScript("OnClick", MISC.MailBox_CollectAllGold)
	button:HookScript("OnEnter", MISC.TotalCash_OnEnter)
	button:HookScript("OnLeave", MISC.TotalCash_OnLeave)
	
	MISC.GoldButton = button
	MISC:UpdateOpeningText()
	
	-------DelMailbutton----------------
	local DelMailbutton = MISC:MailBox_CreatButton(InboxFrame, 80, 25, "", {"LEFT", button, "RIGHT", 0, 0})
	DelMailbutton:SetText(MAIL_DELETEEMPTYMAILS)
	DelMailbutton:SetScript("OnClick", function() SenduiCmd("/mbclean") end)
end

function MISC:MailBox_CollectAttachment()
	for i = 1, ATTACHMENTS_MAX_RECEIVE do
		local attachmentButton = OpenMailFrame.OpenMailAttachments[i]
		if attachmentButton:IsShown() then
			TakeInboxItem(InboxFrame.openMailID, i)
			C_Timer_After(timeToWait, MISC.MailBox_CollectAttachment)
			return
		end
	end
end

function MISC:MailBox_CollectCurrent()
	if OpenMailFrame.cod then
		UIErrorsFrame:AddMessage(I.InfoColor..U["MailIsCOD"])
		return
	end

	local currentID = InboxFrame.openMailID
	if C_Mail_HasInboxMoney(currentID) then
		TakeInboxMoney(currentID)
	end
	MISC:MailBox_CollectAttachment()
end

function MISC:CollectCurrentButton()
	local button = MISC:MailBox_CreatButton(OpenMailFrame, 82, 22, U["TakeAll"], {"RIGHT", "OpenMailReplyButton", "LEFT", -1, 0})
	button:SetScript("OnClick", MISC.MailBox_CollectCurrent)
end

function MISC:LastMailSaver()
	local mailSaver = CreateFrame("CheckButton", nil, SendMailFrame, "OptionsBaseCheckButtonTemplate")
	mailSaver:SetHitRectInsets(0, 0, 0, 0)
	mailSaver:SetPoint("LEFT", SendMailNameEditBox, "RIGHT", 0, 0)
	mailSaver:SetSize(24, 24)
	--M.ReskinCheck(mailSaver)
	--mailSaver.bg:SetBackdropBorderColor(1, .8, 0, .5)

	mailSaver:SetChecked(R.db["Misc"]["MailSaver"])
	mailSaver:SetScript("OnClick", function(self)
		R.db["Misc"]["MailSaver"] = self:GetChecked()
	end)
	M.AddTooltip(mailSaver, "ANCHOR_TOP", U["SaveMailTarget"])

	local resetPending
	hooksecurefunc("SendMailFrame_SendMail", function()
		if R.db["Misc"]["MailSaver"] then
			R.db["Misc"]["MailTarget"] = SendMailNameEditBox:GetText()
			resetPending = true
		else
			resetPending = nil
		end
	end)

	hooksecurefunc(SendMailNameEditBox, "SetText", function(self, text)
		if resetPending and text == "" then
			resetPending = nil
			self:SetText(R.db["Misc"]["MailTarget"])
		end
	end)

	SendMailFrame:HookScript("OnShow", function()
		if R.db["Misc"]["MailSaver"] then
			SendMailNameEditBox:SetText(R.db["Misc"]["MailTarget"])
		end
	end)
end

function MISC:ArrangeDefaultElements()
	InboxTooMuchMail:ClearAllPoints()
	InboxTooMuchMail:SetPoint("BOTTOM", MailFrame, "TOP", 0, 5)

	SendMailNameEditBox:SetWidth(155)
	SendMailNameEditBoxMiddle:SetWidth(146)
	SendMailCostMoneyFrame:SetAlpha(0)

	SendMailMailButton:HookScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:ClearLines()
		local sendPrice = GetSendMailPrice()
		local colorStr = "|cffffffff"
		if sendPrice > GetMoney() then colorStr = "|cffff0000" end
		GameTooltip:AddLine(SEND_MAIL_COST..colorStr..MISC:GetMoneyString(sendPrice, true))
		GameTooltip:Show()
	end)
	SendMailMailButton:HookScript("OnLeave", M.HideTooltip)
end

function MISC:MailBox()
	if not R.db["Misc"]["Mail"] then return end
	if IsAddOnLoaded("Postal") then return end

	-- Delete buttons
	for i = 1, 7 do
		local itemButton = _G["MailItem"..i.."Button"]
		MISC.MailItem_AddDelete(itemButton, i)
	end

	-- Tooltips for multi-items
	hooksecurefunc("InboxFrameItem_OnEnter", MISC.InboxItem_OnEnter)

	-- Custom contact list
	MISC:MailBox_ContactList()

	-- Elements
	MISC:ArrangeDefaultElements()
	MISC.GetMoneyString = M:GetModule("Infobar").GetMoneyString
	MISC:CollectGoldButton()
	MISC:CollectCurrentButton()
	MISC:LastMailSaver()
end
MISC:RegisterMisc("MailBox", MISC.MailBox)

-- Temp fix for GM mails
function OpenAllMail:AdvanceToNextItem()
	local foundAttachment = false
	while ( not foundAttachment ) do
		local _, _, _, _, _, CODAmount, _, _, _, _, _, _, isGM = GetInboxHeaderInfo(self.mailIndex)
		local itemID = select(2, GetInboxItem(self.mailIndex, self.attachmentIndex))
		local hasBlacklistedItem = self:IsItemBlacklisted(itemID)
		local hasCOD = CODAmount and CODAmount > 0
		local hasMoneyOrItem = C_Mail.HasInboxMoney(self.mailIndex) or HasInboxItem(self.mailIndex, self.attachmentIndex)
		if ( not hasBlacklistedItem and not isGM and not hasCOD and hasMoneyOrItem ) then
			foundAttachment = true
		else
			self.attachmentIndex = self.attachmentIndex - 1
			if ( self.attachmentIndex == 0 ) then
				break
			end
		end
	end
	
	if ( not foundAttachment ) then
		self.mailIndex = self.mailIndex + 1
		self.attachmentIndex = ATTACHMENTS_MAX
		if ( self.mailIndex > GetInboxNumItems() ) then
			return false
		end
		
		return self:AdvanceToNextItem()
	end
	
	return true
end

-- LockboxMailer ## Version: 0.1.5
local LockboxMailer = CreateFrame("Frame")
LockboxMailer:RegisterEvent("PLAYER_LOGIN")
LockboxMailer:SetScript("OnEvent", function(event, ...) LockboxMailer.LockboxTable = {} end)  
local LockBoxButton = CreateFrame("Button", "LockBoxMailButton", SendMailFrame, "ActionButtonTemplate")
LockBoxButton:ClearAllPoints()
LockBoxButton:SetPoint("BOTTOMRIGHT", SendMailFrame, "BOTTOMRIGHT", -66, 123)
LockBoxButton:SetSize(26,26)
LockBoxButton:RegisterForClicks("AnyUp")
LockBoxButton:SetScript("OnClick", function(_,btn) LockboxMailer:ProcessMailing() end)
LockBoxButton.icon:SetTexture(134344)
local LockboxMailerTooltip = CreateFrame("GameTooltip","LockboxMailerTooltip", UIParent, "GameTooltipTemplate");
LockboxMailerTooltip:SetOwner(LockboxMailer, "ANCHOR_NONE");
function LockboxMailer:FindLockboxes()
    wipe(LockboxMailer.LockboxTable)
    for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            local lootable, itemLink = select(6,GetContainerItemInfo(bag, slot))
            if itemLink then
                local bindType = select(14, GetItemInfo(itemLink))

                if bindType ~= 1 and lootable then
                    LockboxMailerTooltip:SetBagItem(bag, slot)
                    if LockboxMailerTooltip:IsShown() then
                        for i = 1, LockboxMailerTooltip:NumLines() do
                            local line = _G["LockboxMailerTooltipTextLeft"..i]:GetText()
                            if (line == LOCKED) or (line == ITEM_OPENABLE) then
                                tinsert(LockboxMailer.LockboxTable, { bag, slot } )
                            end
                        end
                    end
                end
            end
        end
    end
end
function LockboxMailer:ProcessMailing()
        --ClearSendMail()
        --SendMailNameEditBox:SetText("烂柯人")
    local attachmentIndex = 0
    for i = 1, ATTACHMENTS_MAX_SEND do
        if GetSendMailItem(i) then
            attachmentIndex = attachmentIndex + 1
        end
    end

    if attachmentIndex < ATTACHMENTS_MAX_SEND then
        LockboxMailer:FindLockboxes()
    end

    local quantity = #LockboxMailer.LockboxTable
    if next(LockboxMailer.LockboxTable) then
        attachmentIndex = (attachmentIndex == 0 and 1 or attachmentIndex + 1)
        for i = 1, quantity do
            local item = tremove(LockboxMailer.LockboxTable)
            if attachmentIndex == ATTACHMENTS_MAX_SEND then
                UIErrorsFrame:AddMessage(ERR_MAIL_INVALID_ATTACHMENT_SLOT, 1.0, 0.1, 0.1, 1.0)
                return
            end
            ClearCursor()
            PickupContainerItem(item[1], item[2])
            ClickSendMailItemButton()
            attachmentIndex = attachmentIndex + 1
        end
            SendMailSubjectEditBox:SetText("["..quantity.."]")
        end
end
-------MailinputboxResizer---------------------------------------------------------------
SendMailCostMoneyFrame:ClearAllPoints()
SendMailCostMoneyFrame:SetPoint("TOPLEFT","SendMailFrame","TOPLEFT",82,-70)
_G["SendMailNameEditBox"]:SetSize(228,21)				----EditBox width default: 224
_G["SendMailNameEditBoxRight"]:ClearAllPoints()
_G["SendMailNameEditBoxRight"]:SetPoint("TOPRIGHT",0,0)
_G["SendMailNameEditBoxMiddle"]:SetSize(0,21)
_G["SendMailNameEditBoxMiddle"]:ClearAllPoints()
_G["SendMailNameEditBoxMiddle"]:SetPoint("LEFT","SendMailNameEditBoxLeft","LEFT",3,0)
_G["SendMailNameEditBoxMiddle"]:SetPoint("RIGHT",_G["SendMailNameEditBoxRight"],"RIGHT",-3,0)

-- Mailbox Cleaner-------- by Jadya - EU-Well of Eternity---------------------------------
local title = GEAR_DELETEEMPTYMAILS_TITLE
local em_enabled = false
local timeout = 0
local MailboxCleaner = CreateFrame("Frame")
local options_desc = { ["read"] = "Delete unread mails" }

local function endloop()
 em_enabled = false
 MailboxCleaner:Hide()
 print(title.." - Done.")
end

local function update()
 if not em_enabled or not InboxFrame or not InboxFrame:IsVisible() then endloop() return end
 local num = GetInboxNumItems()
 if num < 1 or i < 1 then
  endloop()
  return
 end
 local t = time()
 if timeout > 0 then
  if i > num or (timeout < t) then
   i = math.min(i - 1, num)
   timeout = 0
  else
   return
  end
 end

 --if InboxItemCanDelete(i) then
 local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemCount, wasRead, wasReturned, textCreated, canReply, isGM, itemQuantity = GetInboxHeaderInfo(i)
 if (ShiGuangDB["MailRead"] or wasRead) and not isGM and (not snd or (snd and (snd == string.lower(sender)))) and (not itemCount or itemCount == 0) and (not money or money == 0) then
  DeleteInboxItem(i)
  timeout = t + 1
 else
  i = i - 1
 end   
 --end
 if i > num then 
  endloop()
 end
end

MailboxCleaner:SetScript("OnUpdate", update)
MailboxCleaner:Hide()

local function printOptionMsg(arg, help)
 if ShiGuangDB[arg] == nil then return end
 print(title.." - "..(options_desc[arg] or "<unknown>").." = |cff69CCF0"..tostring(ShiGuangDB[arg]).."|r".. (help and " (|cffCCCCCC/mbclean "..arg.."|r)" or ""))
end

local function start(arg)
 if arg == "MailRead" then
  ShiGuangDB["MailRead"] = not ShiGuangDB["MailRead"]
  printOptionMsg(arg)
  return
 end

 if not InboxFrame or not InboxFrame:IsVisible() then
  print(title..MAIL_OPENMAILBOX)
  return
 end
 if arg and arg ~= "" then
  snd = string.lower(arg)
 else
  snd = nil
 end
 i = GetInboxNumItems()
 print(title.." - Doing"..(snd and " from "..snd or "").."...")
 em_enabled = true
 MailboxCleaner:Show()
end

local eventframe = CreateFrame("Frame")
eventframe:RegisterEvent("PLAYER_ENTERING_WORLD")
eventframe:SetScript("OnEvent", function() printOptionMsg("...", true) eventframe:SetScript("OnEvent", nil) end)
-- slash command
SLASH_MAILBOXCLEANER1 = "/mbclean"
SLASH_MAILBOXCLEANER2 = "/mailboxcleaner"
SlashCmdList["MAILBOXCLEANER"] = start