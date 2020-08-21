local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local strsplit, pairs, tonumber, sub, strfind = string.split, pairs, tonumber, string.sub, string.find
local deletedelay, mailItemIndex, inboxItems = .5, 0, {}
local button1, button2, button3, lastopened, imOrig_InboxFrame_OnClick, hasNewMail, takingOnlyCash, onlyCurrentMail, needsToWait, skipMail

function MISC:MailItem_OnClick()
	mailItemIndex = 7 * (InboxFrame.pageNum - 1) + tonumber(sub(self:GetName(), 9, 9))
	local modifiedClick = IsModifiedClick("MAILAUTOLOOTTOGGLE")
	if modifiedClick then
		InboxFrame_OnModifiedClick(self, self.index)
	else
		InboxFrame_OnClick(self, self.index)
	end
end

function MISC:MailBox_OpenAll()
	if GetInboxNumItems() == 0 then return end

	button1:SetScript("OnClick", nil)
	button2:SetScript("OnClick", nil)
	button3:SetScript("OnClick", nil)
	imOrig_InboxFrame_OnClick = InboxFrame_OnClick
	InboxFrame_OnClick = M.Dummy

	if onlyCurrentMail then
		button3:RegisterEvent("UI_ERROR_MESSAGE")
		MISC.MailBox_Open(button3, mailItemIndex)
	else
		button1:RegisterEvent("UI_ERROR_MESSAGE")
		MISC.MailBox_Open(button1, GetInboxNumItems())
	end
end

function MISC:MailBox_Update(elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if (not needsToWait) or (self.elapsed > deletedelay) then
		self.elapsed = 0
		needsToWait = false
		self:SetScript("OnUpdate", nil)

		local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo(lastopened)
		if skipMail then
			MISC.MailBox_Open(self, lastopened - 1)
		elseif money > 0 or (not takingOnlyCash and numItems and numItems > 0 and COD <= 0) then
			MISC.MailBox_Open(self, lastopened)
		else
			MISC.MailBox_Open(self, lastopened - 1)
		end
	end
end

function MISC:MailBox_Open(index)
	if not InboxFrame:IsVisible() or index == 0 then
		MISC:MailBox_Stop()
		return
	end

	local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo(index)
	if not takingOnlyCash then
		if money > 0 or (numItems and numItems > 0) and COD <= 0 then
			AutoLootMailItem(index)
			needsToWait = true
		end
		if onlyCurrentMail then MISC:MailBox_Stop() return end
	elseif money > 0 then
		TakeInboxMoney(index)
		needsToWait = true
	end

	local items = GetInboxNumItems()
	if (numItems and numItems > 0) or (items > 1 and index <= items) then
		lastopened = index
		self:SetScript("OnUpdate", MISC.MailBox_Update)
	else
		MISC:MailBox_Stop()
	end
end

function MISC:MailBox_Stop()
	button1:SetScript("OnUpdate", nil)
	button1:SetScript("OnClick", function() onlyCurrentMail = false MISC:MailBox_OpenAll() end)
	button2:SetScript("OnClick", function() takingOnlyCash = true MISC:MailBox_OpenAll() end)
	button3:SetScript("OnUpdate", nil)
	button3:SetScript("OnClick", function() onlyCurrentMail = true MISC:MailBox_OpenAll() end)
	if imOrig_InboxFrame_OnClick then
		InboxFrame_OnClick = imOrig_InboxFrame_OnClick
	end
	if onlyCurrentMail then
		button3:UnregisterEvent("UI_ERROR_MESSAGE")
	else
		button1:UnregisterEvent("UI_ERROR_MESSAGE")
	end
	takingOnlyCash = false
	onlyCurrentMail = false
	needsToWait = false
	skipMail = false
end

function MISC:MailBox_OnEvent(event, _, msg)
	if event == "UI_ERROR_MESSAGE" then
		if msg == ERR_INV_FULL then
			MISC:MailBox_Stop()
		elseif msg == ERR_ITEM_MAX_COUNT then
			skipMail = true
		end
	elseif event == "MAIL_CLOSED" then
		if not hasNewMail then MiniMapMailFrame:Hide() end
		MISC:MailBox_Stop()
	end
end

function MISC:TotalCash_OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	local total_cash = 0
	for index = 0, GetInboxNumItems() do
		total_cash = total_cash + select(5, GetInboxHeaderInfo(index))
	end
	if total_cash > 0 then SetTooltipMoney(GameTooltip, total_cash)	end
	GameTooltip:Show()
end

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

function MISC:CreatButton(parent, text, w, h, ap, frame, rp, x, y)
	local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	button:SetWidth(w)
	button:SetHeight(h)
	button:SetPoint(ap, frame, rp, x, y)
	button:SetText(text)
	return button
end

function MISC:InboxFrame_Hook()
	hasNewMail = false
	if select(4, GetInboxHeaderInfo(1)) then
		for i = 1, GetInboxNumItems() do
			local wasRead = select(9, GetInboxHeaderInfo(i))
			if not wasRead then
				hasNewMail = true
				break
			end
		end
	end
end

function MISC:InboxItem_OnEnter()
	wipe(inboxItems)

	local itemAttached = select(8, GetInboxHeaderInfo(self.index))
	if itemAttached then
		for attachID = 1, 12 do
			local _, _, _, itemCount = GetInboxItem(self.index, attachID)
			if itemCount and itemCount > 0 then
				local _, itemid = strsplit(":", GetInboxItemLink(self.index, attachID))
				itemid = tonumber(itemid)
				inboxItems[itemid] = (inboxItems[itemid] or 0) + itemCount
			end
		end

		if itemAttached > 1 then
			GameTooltip:AddLine(U["Attach List"])
			for key, value in pairs(inboxItems) do
				local itemName, _, itemQuality, _, _, _, _, _, _, itemTexture = GetItemInfo(key)
				if itemName then
					local r, g, b = GetItemQualityColor(itemQuality)
					GameTooltip:AddDoubleLine(" |T"..itemTexture..":12:12:0:0:50:50:4:46:4:46|t "..itemName, value, r, g, b)
				end
			end
			GameTooltip:Show()
		end
	end
end

function MISC:MailBox_ContactList()
	local bars = {}
	local barIndex = 0

	local bu = M.CreateGear(SendMailFrame)
	bu:SetPoint("LEFT", SendMailNameEditBox, "RIGHT", -3, 0)

	local list = CreateFrame("Frame", nil, bu)
	list:SetSize(210, 421)
	list:SetPoint("TOPLEFT", MailFrame, "TOPRIGHT", 5, 0)
	list:SetFrameStrata("Tooltip")
	--M.SetBD(list)
    list.Tex = list:CreateTexture(nil, "BACKGROUND")
		list.Tex:SetAllPoints(list)
		list.Tex:SetTexture("Interface\\ENCOUNTERJOURNAL\\AdventureGuide")
		list.Tex:SetTexCoord(0,335/512,160/512,500/512);
		list.Tex:SetAllPoints();
    list.Tex:SetAlpha(0.85)
	M.CreateFS(list, 14, U["ContactList"], "system", "TOP", 0, -6)

	local editbox = M.CreateEditBox(list, 121, 26)
	editbox:SetPoint("TOPLEFT", 6, -21)
	local swatch = M.CreateColorSwatch(list, "")
	swatch:SetPoint("LEFT", editbox, "RIGHT", 5, 0)

	local function sortBars()
		local index = 0
		for _, bar in pairs(bars) do
			if bar:IsShown() then
				bar:SetPoint("TOPLEFT", list, 1, -50 - index*21)
				index = index + 1
			end
		end
	end

	local function buttonOnClick(self)
		local text = self.name:GetText() or ""
		SendMailNameEditBox:SetText(text)
	end

	local function deleteOnClick(self)
		MaoRUIDB["ContactList"][self.__owner.name:GetText()] = nil
		self.__owner:Hide()
		sortBars()
		barIndex = barIndex - 1
	end

	local function createContactBar(text, r, g, b)
		local button = CreateFrame("Button", nil, list)
		button:SetSize(166, 21)
		button.HL = button:CreateTexture(nil, "HIGHLIGHT")
		button.HL:SetAllPoints()
		button.HL:SetColorTexture(1, 1, 1, .25)
	
		button.name = M.CreateFS(button, 13, text, false, "LEFT", 12, 0)
		button.name:SetPoint("RIGHT", button, "LEFT", 233, 0)
		button.name:SetJustifyH("LEFT")
		button.name:SetTextColor(r, g, b)
	
		button:RegisterForClicks("AnyUp")
		button:SetScript("OnClick", buttonOnClick)
	
		button.delete = M.CreateButton(button, 21, 21, true, "Interface\\RAIDFRAME\\ReadyCheck-NotReady")
		button.delete:SetPoint("LEFT", button, "RIGHT", 6, 0)
		button.delete.__owner = button
		button.delete:SetScript("OnClick", deleteOnClick)
	
		return button
	end

	local function createBar(text, r, g, b)
		if barIndex < 17 then
			barIndex = barIndex + 1
		end
		for i = 1, barIndex do
			if not bars[i] then
				bars[i] = createContactBar(text, r, g, b)
			end
			if not bars[i]:IsShown() then
				bars[i]:Show()
				bars[i].name:SetText(text)
				bars[i].name:SetTextColor(r, g, b)
				break
			end
		end
	end

	bu:SetScript("OnClick", function()
		M:TogglePanel(list)
	end)

	local add = M.CreateButton(list, 43, 26, ADD, 14)
	add:SetPoint("LEFT", swatch, "RIGHT", 6, 0)
	add:SetScript("OnClick", function()
		local text = editbox:GetText()
		if text == "" or tonumber(text) then return end -- incorrect input
		if not strfind(text, "-") then text = text.."-"..I.MyRealm end -- complete player realm name

		local r, g, b = swatch.tex:GetVertexColor()
		MaoRUIDB["ContactList"][text] = r..":"..g..":"..b
		createBar(text, r, g, b)
		sortBars()
		editbox:SetText("")
	end)

	for name, color in pairs(MaoRUIDB["ContactList"]) do
		if color then
			local r, g, b = strsplit(":", color)
			r, g, b = tonumber(r), tonumber(g), tonumber(b)
			createBar(name, r, g, b)
		end
	end
	sortBars()
end

function MISC:MailBox()
	if not MaoRUIPerDB["Misc"]["Mail"] then return end
	if IsAddOnLoaded("Postal") then return end

	for i = 1, 7 do
		local itemButton = _G["MailItem"..i.."Button"]
		itemButton:SetScript("OnClick", MISC.MailItem_OnClick)
		MISC.MailItem_AddDelete(itemButton, i)
	end

	button1 = MISC:CreatButton(InboxFrame, MAIL_RECEIVELETTERS, 80, 26, "TOPLEFT", "InboxFrame", "TOPLEFT", 60, -28)
	button1:RegisterEvent("MAIL_CLOSED")
	button1:SetScript("OnClick", MISC.MailBox_OpenAll)
	button1:SetScript("OnEvent", MISC.MailBox_OnEvent)

	button2 = MISC:CreatButton(InboxFrame, MAIL_RECEIVECOINS, 80, 26, "LEFT", button1, "RIGHT", 2, 0)
	button2:SetScript("OnClick", function()
		takingOnlyCash = true
		MISC:MailBox_OpenAll()
	end)
	button2:SetScript("OnEnter", MISC.TotalCash_OnEnter)
	button2:SetScript("OnLeave", M.HideTooltip)

	button3 = MISC:CreatButton(OpenMailFrame, MAIL_RECEIVELETTERS, 80, 22, "RIGHT", "OpenMailReplyButton", "LEFT", -2, 0)
	button3:SetScript("OnClick", function()
		onlyCurrentMail = true
		MISC:MailBox_OpenAll()
	end)
	button3:SetScript("OnEvent", MISC.MailBox_OnEvent)
	
	-------DelMailbutton----------------
	button4 = MISC:CreatButton(InboxFrame, MAIL_DELETEEMPTYMAILS, 100, 26, "LEFT", button2, "RIGHT", 2, 0)
	button4:SetScript("OnClick", function() sendCmd("/mbclean") end)

	hooksecurefunc("InboxFrame_Update", MISC.InboxFrame_Hook)
	hooksecurefunc("InboxFrameItem_OnEnter", MISC.InboxItem_OnEnter)

	MISC:MailBox_ContactList()

	-- Replace the alert frame
	if InboxTooMuchMail then
		InboxTooMuchMail:ClearAllPoints()
		InboxTooMuchMail:SetPoint("BOTTOM", MailFrame, "TOP", 0, 5)
	end

	-- Hide Blizz
	M.HideObject(OpenAllMail)
end
MISC:RegisterMisc("MailBox", MISC.MailBox)

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