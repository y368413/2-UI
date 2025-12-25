-- Thank you to Partha    ## SavedVariables: MAILBAGDB
--  ... finer detail for how long items may stay in the inbox
--  ... PUSH_ITEM event based queue operation

-- TWW compatibility
local GetItemClassInfo = C_Item and C_Item.GetItemClassInfo or GetItemClassInfo
local GetItemInfo = C_Item and C_Item.GetItemInfo or GetItemInfo
local GetCoinTextureString = C_CurrencyInfo and C_CurrencyInfo.GetCoinTextureString or GetCoinTextureString
local GetCoinIcon = C_CurrencyInfo and C_CurrencyInfo.GetCoinIcon or GetCoinIcon

NUM_BAGITEMS_PER_ROW = 6
NUM_BAGITEMS_ROWS = 7

BAGITEMS_ICON_ROW_HEIGHT = 36
BAGITEMS_ICON_DISPLAYED = NUM_BAGITEMS_PER_ROW * NUM_BAGITEMS_ROWS

-- Saved variable (and default value)
MAILBAGDB = {
	["GROUP_STACKS"] = true,
	["ADVANCED"] = true,
	["MAIL_DEFAULT"] = true,
	["QUALITY_COLORS"] = true
}

-- Import globals
local insert = table.insert
local remove = table.remove


local IsRetail = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE

-- Export localization into namespace for XML localization
MB_BAGNAME = InboxMailBag_BAGNAME
MB_FRAMENAME = InboxMailBag_FRAMENAME
MB_GROUP_STACKS = InboxMailBag_Group_Stacks

-- Drawing in localization info
local WEAPON = GetItemClassInfo(Enum.ItemClass.Weapon)
local ARMOR = GetItemClassInfo(Enum.ItemClass.Armor)
local GLYPH = GetItemClassInfo(Enum.ItemClass.Glyph)

local MB_Items = {}
local MB_Queue = {}
local MB_Ready = true
local MB_SearchField
local MB_Tab -- The tab for our frame.
local MB_BattlePetTooltipLines

--[[local options = {
	name = InboxMailBag_FRAMENAME,
	type = "group",
	args = {
		advanced = {
			type = "toggle",
			name = "Advanced",
			desc = "ADVANCED_MODE_DESC",
			descStyle = "inline",
			width = "full",
			set = function(info, enabled)
					InboxMailbag_ToggleAdvanced(enabled)
					if (info[0]) then
						LibStub("AceConsole-3.0"):Print(enabled and "ADVANCED_MODE_ENABLED" or "ADVANCED_MODE_DISABLED")
					end
				 end,
			get = function(info) return MAILBAGDB["ADVANCED"] end,
		},
		quality_colors = {
			type = "toggle",
			name = "Quality Colors",
			desc = "QUALITY_COLOR_MODE_DESC",
			descStyle = "inline",
			width = "full",
			set = function(info, enabled)
					MAILBAGDB["QUALITY_COLORS"] = enabled
					if ( InboxMailbagFrame:IsVisible() ) then
						InboxMailbag_Update()
					end
					if (info[0]) then
						LibStub("AceConsole-3.0"):Print(enabled and "QUALITY_COLORS_MODE_ENABLED" or "QUALITY_COLORS_MODE_DISABLED")
					end
				 end,
			get = function(info) return MAILBAGDB["QUALITY_COLORS"] end,
		},
		mail_default = {
			type = "toggle",
			name = "MAIL_DEFAULT",
			desc = string.format( "MAIL_DEFAULT_DESC", INBOX ),
			descStyle = "inline",
			width = "full",
			set = function(info, enabled)
					MAILBAGDB["MAIL_DEFAULT"] = enabled
					if (info[0]) then
						LibStub("AceConsole-3.0"):Print(enabled and "MAIL_DEFAULT_ENABLED" or string.format("MAIL_DEFAULT_DISABLED", INBOX))
					end
				 end,
			get = function(info) return MAILBAGDB["MAIL_DEFAULT"] end,
		},
	},
}
LibStub("AceConfig-3.0"):RegisterOptionsTable("InboxMailbag", options, {"mailbag"})
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("InboxMailbag", InboxMailBag_FRAMENAME)]]

function InboxMailbagSearch_OnEditFocusGained(self, ...)
	MB_SearchField = self
end

function InboxMailbag_OnLoad(self)
	-- We have things to do after everything is loaded
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")

	-- Hook our tab to play nicely with MailFrame tabs
	hooksecurefunc("MailFrameTab_OnClick", InboxMailbag_Hide) -- Adopted from Sent Mail as a more general solution, and plays well with Sent Mail

	-- Hook our search field so we know what search field to use.
	-- Hack, because we can't use UI to give us current search string/search filter
	if BagItemSearchBox then
		BagItemSearchBox:HookScript("OnEditFocusGained", InboxMailbagSearch_OnEditFocusGained)
	end
	InboxMailbagFrameItemSearchBox:HookScript("OnEditFocusGained", InboxMailbagSearch_OnEditFocusGained)
	insert(ITEM_SEARCHBAR_LIST, "InboxMailbagFrameItemSearchBox")

	--Create Mailbag item buttons, button background textures
	assert(InboxMailbagFrameItem1)
	local frameParent = InboxMailbagFrameItem1:GetParent()

	for i = 2, BAGITEMS_ICON_DISPLAYED do
		local button = CreateFrame(ItemButtonMixin and "ItemButton" or "Button", "InboxMailbagFrameItem"..i, frameParent, "MailbagItemButtonGenericTemplate")
		button:SetID(i)
		if ((i%NUM_BAGITEMS_PER_ROW) == 1) then
			button:SetPoint("TOPLEFT", _G["InboxMailbagFrameItem"..(i-NUM_BAGITEMS_PER_ROW)], "BOTTOMLEFT", 0, -7)
		else
			button:SetPoint("TOPLEFT", _G["InboxMailbagFrameItem"..(i-1)], "TOPRIGHT", 9, 0)
		end
	end
	for i = 1, BAGITEMS_ICON_DISPLAYED do
		local button = _G["InboxMailbagFrameItem"..i]
		local texture = self:CreateTexture(nil, "BORDER", "Mailbag-Slot-BG")
		texture:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 2)
		texture:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
		texture:SetAlpha(0.66)

		if IsRetail and not button.ProfessionQualityOverlay then
			button.ProfessionQualityOverlay = button:CreateTexture(nil, "OVERLAY")
			button.ProfessionQualityOverlay:SetPoint("TOPLEFT", -3, 2)
		end
	end

	if BattlePetTooltip then
		-- From sample code at http://us.battle.net/wow/en/forum/topic/7415465636
		-- thank you Ro @ Underhill
		--local BattlePetTooltip = BattlePetTooltip -- not really needed
		MB_BattlePetTooltipLines = BattlePetTooltip:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		MB_BattlePetTooltipLines:SetPoint("TOPLEFT", BattlePetTooltip.Owned, "BOTTOMLEFT", -3, 0)
		MB_BattlePetTooltipLines:SetJustifyH("LEFT")
		BattlePetTooltip:HookScript("OnHide", InboxMailbag_BattlePetToolTip_OnHide)

		-- properly align Blizzard's default BattlePetTooltip
		BattlePetTooltip.Name:ClearAllPoints()
		BattlePetTooltip.Name:SetPoint("TOPLEFT", 10, -10)
	end
end

function InboxMailbag_OnPlayerLogin(self, event, ...)
	InboxMailbagTab_Create()

	-- Check for and adapt to the presence of the addon: Sent Mail
	if (SentMailTab) then
		MB_Tab:SetPoint("LEFT", SentMailTab, "RIGHT", -8, 0)
		MB_Tab:HookScript("OnClick", SentMail_UpdateTabs)
		SentMailTab:HookScript("OnClick", InboxMailbagTab_DeselectTab)
	end

	-- Check for and adapt to the presence of the addon: BeanCounter (part of Auctioneer's suite)
	if (BeanCounter) then
		BeanCounterMail:HookScript("OnShow", InboxMailbag_BeanCounter_OnShow)
		BeanCounterMail:HookScript("OnHide", InboxMailbag_BeanCounter_OnHide)
	end

	-- Last tweaks for advanced mode
	InboxMailbag_ToggleAdvanced( MAILBAGDB["ADVANCED"] )
end

function InboxMailbag_OnShow(self)
	self:RegisterEvent("MAIL_INBOX_UPDATE")
	self:RegisterEvent("ITEM_PUSH")
	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("UI_ERROR_MESSAGE")
	self:RegisterEvent("INVENTORY_SEARCH_UPDATE")

	InboxMailbag_Consolidate()
end

function InboxMailbag_OnHide(self)
	self:UnregisterEvent("MAIL_INBOX_UPDATE")
	self:UnregisterEvent("ITEM_PUSH")
	self:UnregisterEvent("PLAYER_MONEY")
	self:UnregisterEvent("UI_ERROR_MESSAGE")
	self:UnregisterEvent("INVENTORY_SEARCH_UPDATE")

	InboxMailbag_ResetQueue()
end

function InboxMailbag_OnEvent(self, event, ...)
	if ( event == "MAIL_INBOX_UPDATE" ) then
		InboxMailbag_Consolidate()
	elseif( event == "ITEM_PUSH" or event == "PLAYER_MONEY" ) then
		if not MB_Ready then
			MB_Ready = true
			InboxMailbag_Consolidate()
			InboxMailbag_FetchNext()
		end
	elseif( event == "INVENTORY_SEARCH_UPDATE" ) then
		InboxMailbag_UpdateSearchResults()
	elseif( event == "UI_ERROR_MESSAGE" ) then
		-- Assume it's our fault, stop the queue
		InboxMailbag_ResetQueue()
	elseif( event == "MAIL_SHOW" ) then
		if MAILBAGDB["MAIL_DEFAULT"] then
			InboxMailbagTab_OnClick(MB_Tab)
		end
	elseif( event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" ) then
		local type = ...
		if type == Enum.PlayerInteractionType.MailInfo and MAILBAGDB["MAIL_DEFAULT"] then
			InboxMailbagTab_OnClick(MB_Tab)
		end
	elseif( event == "PLAYER_LOGIN" ) then
		InboxMailbag_OnPlayerLogin(self, event, ...)
	end
end

-- Attempt to be clever and re-use pre-existing table entries where possible.
function MB_Items:SetCash( index, money, daysLeft, link )
	if ( self[index] ) then
		local item = self[index]
		item.money = money
		item.hasItem = false
		item.daysLeft = daysLeft
		wipe(item.links)
		insert( item.links, link )
		item.count = nil
		item.itemTexture = nil
	else
		local item = {
			["money"]    = money,
			["hasItem"]  = false,
			["daysLeft"] = daysLeft,
			["links"]    = { link }
		}
		self[index] = item
	end
end

function MB_Items:SetItem( index, count, itemTexture, daysLeft, link )
	if ( self[index] ) then
		local item = self[index]
		item.count = count
		item.hasItem = true
		item.daysLeft = daysLeft
		item.itemTexture = itemTexture
		wipe(item.links)
		insert( item.links, link )
		item.money = nil
	else
		local item = {
			["count"]       = count,
			["hasItem"]     = true,
			["daysLeft"]    = daysLeft,
			["itemTexture"] = itemTexture,
			["links"]       = { link }
		}
		self[index] = item
	end
end

-- Scan the mail. Gather it. Refresh our scroll system
function InboxMailbag_Consolidate()
	if not MB_Ready then  return  end

	local indexes = {} -- Name to MB_Items index mapping

	local counter = 0
	local index = ""
	local bGroupStacks = MAILBAGDB["GROUP_STACKS"]
	local bAdvanced    = MAILBAGDB["ADVANCED"]

	for i=1, GetInboxNumItems() do
		local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemCount, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(i)

		if ( bAdvanced and money > 0 ) then
			local link = { ["mailID"] = i, ["money"] = money }
			if ( bGroupStacks and indexes["CASH"] ) then
				local item = MB_Items[ indexes["CASH"] ]
				item.money = item.money + money
				insert(item.links, link)
				if ( daysLeft < item.daysLeft ) then
					item.daysLeft = daysLeft
				end
			else
				counter = counter + 1
				MB_Items:SetCash( counter, money, daysLeft, link)
				indexes["CASH"] = counter
			end
		end

		if (itemCount and CODAmount == 0) then
			for n=1,ATTACHMENTS_MAX_RECEIVE do
				local name, itemID, itemTexture, count, quality, canUse = GetInboxItem(i, n)
				if name and itemID then
					local itemKey = name..":"..itemID
					local link = { ["mailID"] = i, ["attachment"] = n }
					if ( bGroupStacks and indexes[itemKey] ) then
						local item = MB_Items[ indexes[itemKey] ]
						item.count = item.count + count
						insert(item.links, link)
						if ( daysLeft < item.daysLeft ) then
							item.daysLeft = daysLeft
						end
					else
						counter = counter + 1
						MB_Items:SetItem( counter, count, itemTexture, daysLeft, link )
						indexes[itemKey] = counter
					end
				end
			end
		end
	end

	-- If original MB_Items was greater than current, remove the tail
	-- Other functions rely on #MB_Item and queries past the end of the array to be nil
	if ( counter < #MB_Items ) then
		for i = counter + 1, #MB_Items do
			remove(MB_Items)
		end
	end

	InboxMailbag_Update()
end

-- If the itemLink is a [Pet Cage] then return a searchable pet name.
function InboxMailbag_GetInboxItemID( mailID, attachment, name)
	local itemLink = GetInboxItemLink( mailID, attachment )
	if ( itemLink and string.find(itemLink, "item:82800") ) then
		local cageName = GetItemInfo( itemLink )
		if cageName then
			if ( name ) then
				itemLink = name.." "..cageName
			else
				local itemName, _, itemTexture, count, quality, canUse = GetInboxItem( mailID, attachment )
				itemLink = itemName.." "..cageName
			end
		end
	end
	return itemLink
end

-- Adapt letters to match upper/lowercase. Escape anything else.
-- and cache the results, as typical use is many 'isFiltered' over one search term
local searchPattern = { lastString = "", pattern = "" }
local function MakeSearchPattern( string )
	if ( string ~= searchPattern.lastString ) then
		searchPattern.pattern = gsub(string, ".",
			function (c) 
				if c:match("%a") then
					return string.format("[%s%s]", c:lower(), c:upper())
				else
					--return "%"..c
				end
			end)
		searchPattern.lastString = string
	end
	return searchPattern.pattern
end
-- itemID is typically an itemLink UNLESS
-- itemID is CASH for a stack of money
-- itemID is simply the item name, typically for BattlePets
function InboxMailbag_isFiltered(itemID)
	local searchString = MB_SearchField and MB_SearchField:GetText()
	if searchString and searchString ~= SEARCH and strlen(searchString) > 0 then
		if (not itemID or itemID == "CASH") then  return true  end

		local name, link, _, _, _, itemType, subType, _, equipSlot, _, vendorPrice = GetItemInfo(itemID)
		name = name or itemID

		local subMatch = false
		searchString = MakeSearchPattern(searchString)
		if (itemType == ARMOR or itemType == WEAPON) then
			-- Armor/weapons search on name, type (axe/leather), and where you equip it (head)
			local secondary = _G[equipSlot] or ""
			subMatch = strfind(secondary, searchString) or strfind(subType, searchString)
		elseif (itemType == GLYPH) then
			subMatch = strfind(subType, searchString)
		end
		return (not subMatch and not strfind(name, searchString))
	else
		return false
	end
end

function InboxMailbag_UpdateSearchResults()
	for i=1, BAGITEMS_ICON_DISPLAYED do
		local itemButton = _G["InboxMailbagFrameItem"..i]
		local itemLink = itemButton.item and (itemButton.item.hasItem and InboxMailbag_GetInboxItemID(itemButton.item.links[1].mailID, itemButton.item.links[1].attachment) or "CASH")
		if ( itemLink and InboxMailbag_isFiltered(itemLink) ) then
			itemButton.searchOverlay:Show()
		else
			itemButton.searchOverlay:Hide()
		end
	end
end

-- Interact with Faux Scrollbar to 'scroll' the inventory icons.
function InboxMailbag_Update()
	local offset = FauxScrollFrame_GetOffset(InboxMailbagFrameScrollFrame)
	offset = offset * NUM_BAGITEMS_PER_ROW

	local numItems, totalItems = GetInboxNumItems()
	if ( totalItems > numItems ) then
		InboxMailbagFrameTotalMessages:SetText( format(InboxMailBag_TOTAL_MORE, numItems, totalItems) )
	else
		InboxMailbagFrameTotalMessages:SetText( format(InboxMailBag_TOTAL, numItems) )
	end

	local bQualityColors = MAILBAGDB["QUALITY_COLORS"]
	for i=1, BAGITEMS_ICON_DISPLAYED do
		local currentIndex = i + offset
		local item = MB_Items[currentIndex]
		local itemButton = _G["InboxMailbagFrameItem"..i]
		local itemName, itemTexture, count, quality, canUse, _, itemLink
		if (item) then
			assert(currentIndex <= #MB_Items)
			if ( item.hasItem ) then
				itemName, _, itemTexture, count, quality, canUse = GetInboxItem(item.links[1].mailID, item.links[1].attachment)
				itemLink = InboxMailbag_GetInboxItemID(item.links[1].mailID, item.links[1].attachment, itemName)

				SetItemButtonTexture(itemButton, itemTexture)
				SetItemButtonCount(itemButton, item.count)
			else
				SetItemButtonTexture(itemButton, GetCoinIcon(item.money))
				SetItemButtonCount(itemButton, 0)
				quality = nil
				itemLink = "CASH"
			end

			itemButton.item = item

			if ( item.daysLeft < 7 ) then
				if ( item.daysLeft < 1 ) then
					itemButton.deleteOverlay:SetTexture(1, 0.125, 0.125)
				else
					itemButton.deleteOverlay:SetTexture(1, 0.5, 0)
				end
				itemButton.deleteOverlay:Show()
			else
				itemButton.deleteOverlay:Hide()
			end

			if( bQualityColors and quality and quality ~= 1 ) then
				itemButton.qualityOverlay:SetVertexColor(ITEM_QUALITY_COLORS[quality].r, ITEM_QUALITY_COLORS[quality].g, ITEM_QUALITY_COLORS[quality].b)
				itemButton.qualityOverlay:Show()
			else
				itemButton.qualityOverlay:Hide()
			end

			if ( InboxMailbag_isFiltered(itemLink) ) then
				itemButton.searchOverlay:Show()
			else
				itemButton.searchOverlay:Hide()
			end
		else
			SetItemButtonTexture(itemButton, nil)
			SetItemButtonCount(itemButton, 0)
			itemButton.searchOverlay:Hide()
			itemButton.deleteOverlay:Hide()
			itemButton.qualityOverlay:Hide()
			itemButton.item = nil
		end

		if ( itemButton:IsMouseOver() ) then  InboxMailbagItem_OnEnter(itemButton)  end

		if itemButton.ProfessionQualityOverlay then
			itemButton.ProfessionQualityOverlay:SetAtlas(nil)
			SetItemCraftingQualityOverlay(itemButton, itemLink)
		end
	end

	-- Scrollbar stuff
	if (#MB_Items > BAGITEMS_ICON_DISPLAYED) then
		InboxMailbagFrameScrollFrame:Show()
	else
		InboxMailbagFrameScrollFrame:Hide()
	end
	FauxScrollFrame_Update(InboxMailbagFrameScrollFrame, ceil(#MB_Items / NUM_BAGITEMS_PER_ROW) , NUM_BAGITEMS_ROWS, BAGITEMS_ICON_ROW_HEIGHT )
end

function InboxMailbag_Hide()
	InboxMailbagFrame:Hide()
end

function InboxMailbag_ResetQueue()
	wipe(MB_Queue)
	MB_Ready = true
end

function InboxMailbag_FetchNext()
	if #MB_Queue > 0 and MB_Ready then
		MB_Ready = false

		local link = remove(MB_Queue)

		-- Fake get mail body. This marks the messages we alter as read
		GetInboxText(link.mailID) --  > MAIL_INBOX_UPDATE

		if ( link.attachment ) then
			TakeInboxItem(link.mailID, link.attachment) --  > MAIL_SUCCESS > ITEM_PUSH
		else
			assert(link.money)
			TakeInboxMoney(link.mailID)
		end
	end
end

local battletip = {}

function battletip:ClearLines()
	for i=1, #battletip do
		remove(battletip)
	end
	MB_BattlePetTooltipLines:SetText(nil)
end

function battletip:AddLine(text, r, g, b)
	if (r and g and b) then
		insert(self, format("|cff%2x%2x%2x%s|r", r * 255, g * 255, b * 255, text))
	else
		insert(self, text)
	end
end

function battletip:Show()
	MB_BattlePetTooltipLines:SetText( table.concat(self, "\n") )
	BattlePetTooltip:SetHeight( BattlePetTooltip:GetHeight() + MB_BattlePetTooltipLines:GetHeight() + 10 )
	BattlePetTooltip:SetWidth( max( 260, MB_BattlePetTooltipLines:GetWidth() + 15 ) )
end

function InboxMailbagItem_OnEnter(self, index)
	local item = self.item
	local links = item and item.links

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

	if ( links ) then
		local tip = GameTooltip

		if ( item.hasItem ) then
			local _, speciesID, level, breedQuality, maxHealth, power, speed, name = GameTooltip:SetInboxItem(links[1].mailID, links[1].attachment)

			if BattlePetTooltip then
				if C_TooltipInfo and C_TooltipInfo.GetInboxItem then
					local data = C_TooltipInfo.GetInboxItem(links[1].mailID, links[1].attachment)
					if data and data.battlePetSpeciesID then
						speciesID, level, breedQuality, maxHealth, power, speed, name = data.battlePetSpeciesID, data.battlePetLevel, data.battlePetBreedQuality, data.battlePetMaxHealth, data.battlePetPower, data.battlePetSpeed, data.battlePetName
					end
				end
				if ( speciesID and speciesID > 0 ) then
					BattlePetToolTip_Show(speciesID, level, breedQuality, maxHealth, power, speed, name)
					tip = battletip
					tip:ClearLines()
				else
					BattlePetTooltip:Hide()
				end
			end
		elseif ( MAILBAGDB["GROUP_STACKS"] ) then
			GameTooltip:AddLine( ENCLOSED_MONEY )
			GameTooltip:AddLine( GetCoinTextureString(item.money), 1, 1, 1 )
		else
			local invoiceType, itemName, playerName, bid, buyout, deposit, consignment = GetInboxInvoiceInfo( links[1].mailID )
			playerName = playerName or AUCTION_HOUSE_MAIL_MULTIPLE_BUYERS or ""

			if ( invoiceType == "seller" ) then
				GameTooltip:AddLine( format( "%s  |cffFFFFFF%s|r", ITEM_SOLD_COLON, itemName ) )
				GameTooltip:AddLine( format( "%s  |cffFFFFFF%s|r", PURCHASED_BY_COLON, playerName ) )
				GameTooltip:AddLine( format( "%s:   |cffFFFFFF%s|r", bid == buyout and BUYOUT or HIGH_BIDDER, GetCoinTextureString(bid) ) )
			else
				local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemCount, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo( links[1].mailID )
				GameTooltip:AddLine( subject )
				GameTooltip:AddLine( GetCoinTextureString(item.money), 1, 1, 1 )
			end
		end

		--local addSeparator = true;
		local GroupStacks = true;

		for i, link in ipairs(links) do
			local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemCount, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(link.mailID)

			if daysLeft and daysLeft > 0 then
				local strAmount

				if ( item.hasItem ) then
					local name, _, itemTexture, count, quality, canUse = GetInboxItem(link.mailID, link.attachment)
					strAmount = ( count and count > 0 ) and tostring(count)
				else
					strAmount = ( link.money and link.money > 0 ) and format( "|cffFFFFFF%s|r ", GetCoinTextureString(link.money) )

					if ( MAILBAGDB["GROUP_STACKS"] ) then
						local invoiceType, itemName, playerName, bid, buyout, deposit, consignment = GetInboxInvoiceInfo( link.mailID )
						if ( invoiceType == "seller" ) then
							sender = subject
						end
					end
				end

				-- Format expiration time
				if strAmount then
					--if addSeparator then  tip:AddLine(" ");  addSeparator = false;  end

					local canDelete = InboxItemCanDelete(link.mailID)

					if daysLeft < 1 then
						tip:AddLine( format( (canDelete and InboxMailBag_DELETED_1) or InboxMailBag_RETURNED_1, strAmount, sender or UNKNOWN, SecondsToTime( floor(daysLeft * 24 * 60 * 60) ) ) )
					elseif daysLeft < 7 then
						tip:AddLine( format( (canDelete and InboxMailBag_DELETED_7) or InboxMailBag_RETURNED_7, strAmount, sender or UNKNOWN, floor(daysLeft) ) )
					else
						tip:AddLine( format( (canDelete and InboxMailBag_DELETED) or InboxMailBag_RETURNED, strAmount, sender or UNKNOWN, floor(daysLeft) ) )
					end
				end
			end
		end

		tip:Show()
	else
		GameTooltip:Hide()
		if BattlePetTooltip then BattlePetTooltip:Hide() end
	end
end

function InboxMailbagItem_OnClick(self)
	local links = #MB_Queue == 0 and MB_Ready and self.item and self.item.links

	if links then
		if IsModifiedClick() then
			if ( self.item.hasItem and HandleModifiedItemClick( GetInboxItemLink(links[1].mailID, links[1].attachment) ) ) then
				return
			else
				insert( MB_Queue, links[#links] )
			end
		else
			for i = 1, #links do
				insert( MB_Queue, links[i] )
			end
		end

		InboxMailbag_FetchNext()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	end
end

-- Create our tab as +1 tab on the mailbox window. As long as other code builds the tabs
-- appropriately, then we can dynamically put our tab after them all.
function InboxMailbagTab_Create()
	local index = MailFrame.numTabs + 1

	MB_Tab = CreateFrame("Button", "MailFrameTab"..index, _G["MailFrame"], "MailFrameTabInboxMailbagTemplate", index)
	MB_Tab:SetPoint("LEFT", _G["MailFrameTab"..MailFrame.numTabs], "RIGHT", -8, 0)

	-- We want to run our frame's inherited OnShow first
	MB_Tab:HookScript("OnShow", InboxMailbagTab_TabBoundsCheck)

	PanelTemplates_SetNumTabs(MailFrame, index)
	PanelTemplates_SetTab(MailFrame, 1)
end

-- Adapted from Blizzard's CharacterFrame_TabBoundsCheck
local function CompareFrameSize(frame1, frame2)
	return frame1:GetWidth() > frame2:GetWidth()
end

local MailTabtable = {} 
function InboxMailbagTab_TabBoundsCheck()
	local tabCount = MailFrame.numTabs
	local diff = (_G["MailFrameTab"..tabCount]:GetRight() or 0) - (MailFrame:GetRight() or 0)

	-- First, try left justifying the tabs	
	if ( diff > 0 ) then
		local point, relativeTo, relativePoint, xOffset, yOffset = MailFrameTab1:GetPoint(1)
		MailFrameTab1:SetPoint("BOTTOMLEFT", relativeTo, relativePoint, 0, yOffset )
		diff = (_G["MailFrameTab"..tabCount]:GetRight() or 0) - (MailFrame:GetRight() or 0)
	end

	-- Second, try squishing tab spacing together
	if ( diff > 0 ) then
		for i = 2, tabCount do
			_G["MailFrameTab"..i]:SetPoint("LEFT", _G["MailFrameTab"..(i-1)], "RIGHT", -15, 0)
		end
		if ( SentMailTab ) then
			SentMailTab:SetPoint("LEFT", MailFrameTab2, "RIGHT", -15, 0)
			MB_Tab:SetPoint("LEFT", SentMailTab, "RIGHT", -15, 0)
		end
		diff = (_G["MailFrameTab"..tabCount]:GetRight() or 0) - (MailFrame:GetRight() or 0)
	end

	-- If that still wasn't enough, start squishing the padding on tabs
	if ( diff > 0 ) then
		--Find the biggest tab
		for i=1, tabCount do
			MailTabtable[i]=_G["MailFrameTab"..i]
		end
		if ( SentMailTab ) then
			tabCount = tabCount + 1
			MailTabtable[tabCount]=SentMailTab
		end
		table.sort(MailTabtable, CompareFrameSize)

		local i=1
		while ( diff > 0 and i <= tabCount) do
			local tabText = _G[MailTabtable[i]:GetName().."Text"]
			local change = min(10, diff)
			diff = diff - change
			tabText:SetWidth(0)
			PanelTemplates_TabResize(MailTabtable[i], -change, nil, 36-change, 88)
			i = i+1
		end
	end
end

function InboxMailbagTab_OnClick(self)
	-- Adapted from MailFrameTab_OnClick
	PanelTemplates_SetTab(MailFrame, self:GetID())
	ButtonFrameTemplate_HideButtonBar(MailFrame)
	MailFrameInset:SetPoint("TOPLEFT", 4, -58)
	InboxFrame:Hide()
	SendMailFrame:Hide()
	SetSendMailShowing(false)
	InboxMailbagFrame:Show()
	PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN)

	if IsRetail and MailFrame.SetTitle then
		MailFrame:SetTitle(MB_FRAMENAME)
		InboxMailbagFrameTitleText:Hide()
	end
end

function InboxMailbagTab_DeselectTab()
	PanelTemplates_DeselectTab(MB_Tab)
	InboxMailbagFrame:Hide()
end

function InboxMailbag_ToggleAdvanced(...)
	if ( select("#", ...) >= 1 ) then
		MAILBAGDB["ADVANCED"] = select(1, ...)
	else
		MAILBAGDB["ADVANCED"] = not MAILBAGDB["ADVANCED"]
	end

	if ( MAILBAGDB["ADVANCED"] ) then
		InboxMailbagFrameTotalMessages:Show()
	else
		InboxMailbagFrameTotalMessages:Hide()
	end

	if ( InboxMailbagFrame:IsVisible() ) then
		InboxMailbag_Consolidate()
	end
end

-- Respond to BeanCounter showing it's MailGUI by hiding ours,
-- hiding our tab (since BC hides the SendMail tab itself)
-- and then selecting the Inbox tab so people can't click on it while BC is running
function InboxMailbag_BeanCounter_OnShow()
	InboxMailbagFrame:Hide()
	PanelTemplates_SetTab(MailFrame, 1)
	MB_Tab:Hide()
end

-- Respond to BeanCounter hiding its GUI by showing ours if appropriate
function InboxMailbag_BeanCounter_OnHide()
	MB_Tab:Show()
	if MAILBAGDB["MAIL_DEFAULT"] then
		InboxMailbagTab_OnClick(MB_Tab)
	end
end

function InboxMailbag_BattlePetToolTip_OnHide()
	MB_BattlePetTooltipLines:SetText(nil)
end