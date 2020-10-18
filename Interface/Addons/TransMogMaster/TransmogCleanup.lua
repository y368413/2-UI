TransmogCleanup = CreateFrame("Frame")
local TransmogCleanup = TransmogCleanup

TransmogCleanupDB = {}
TransmogCleanup.db = TransmogCleanupDB

local version = "v9.0.1-1"

--------------------------------------------------------------------------------
-- Upvalues
--

local _G = _G
local orgPrint = print
local ItemUpgradeInfo = LibStub("LibItemUpgradeInfo-1.0")
local C_Timer = C_Timer
local CreateFrame = CreateFrame
local GetCoinTextureString = GetCoinTextureString
local GetContainerItemLink = GetContainerItemLink
local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemPurchaseInfo = GetContainerItemPurchaseInfo
local GetItemInfo = GetItemInfo
local GetItemSpell = GetItemSpell
local SecondsToTime = SecondsToTime
local select = select
local tonumber = tonumber
local UseContainerItem = UseContainerItem
local unpack = unpack
local GameFontHighlightSmall = GameFontHighlightSmall
local floor = math.floor
local max = math.max
local sort = table.sort
local pairs = pairs
local GameTooltip = GameTooltip
local SetUpSideDressUpFrame = SetUpSideDressUpFrame
local IsControlKeyDown = IsControlKeyDown
local DressUpItemLink = DressUpItemLink
local SideDressUpFrame = SideDressUpFrame
local CloseSideDressUpFrame = CloseSideDressUpFrame
local ITEM_SOULBOUND = ITEM_SOULBOUND
local ITEM_BNETACCOUNTBOUND = ITEM_BNETACCOUNTBOUND
local ITEM_BIND_ON_EQUIP = ITEM_BIND_ON_EQUIP
local IsAddOnLoaded = IsAddOnLoaded
local GetTime = GetTime
local type = type

--------------------------------------------------------------------------------
-- Variables
--

local enabled = true -- changed via checkForDependencies
local merchantButton = nil
local sellWindow = nil
local scanningTooltip = nil
local updateItemListThrottle = nil
local lastWindowState = nil
local maxIlvl = 155
local itemQualities = {
	{   1,    1,    1}, -- common
	{0.12,    1,    0}, -- uncommon
	{   0, 0.44, 0.87}, -- rare
	{0.64, 0.21, 0.93}, -- epic
	{   1, 0.50,    0}, -- legendary
}
local bindOn = {
	{"装绑", "Bind on Equip"},
	{"拾绑", "Bind on Pickup"},
	{"战网", "Bind to Account"},
}
local learnedTypes = {
	{"已可幻化", "Sell items learned by any char"},
	{"不能幻化", "Sell items which are non transmoggable (like trinkets and rings)"},
	{"其他角色可幻化", "Sell items which can be learned by another character"},
}

--------------------------------------------------------------------------------
-- Functions

local function isTransmogable(link)
	return link and CanIMogIt:IsTransmogable(link)
end
local function getTransmogStatus(link)
	local mogStatus = CanIMogIt:GetTooltipText(link)

	if not mogStatus or type(mogStatus) ~= "string" then
		--print(("|cff8080ff[幻化]|r忽略: %s."):format(link))  --Couldn't determine status of item
		return
	end

	-- if CanIMogIt:TextIsKnown(mogStatus) then -- < Could just use this, but let's be independent
	if mogStatus == CanIMogIt.KNOWN or
		 mogStatus == CanIMogIt.KNOWN_FROM_ANOTHER_ITEM or
		 mogStatus == CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER or
		 mogStatus == CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL or
		 mogStatus == CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL or
		 mogStatus == CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER then
		return 1
	elseif mogStatus == CanIMogIt.NOT_TRANSMOGABLE or
		   mogStatus:find(CanIMogIt.UNKNOWABLE_SOULBOUND) then
		return 2
	elseif mogStatus:find(CanIMogIt.UNKNOWABLE_BY_CHARACTER) then
		return 3
	end
	return nil
end

local function getItemIdByLink(itemLink)
	return tonumber(select(3, itemLink:find("item:(%d+)")))
end

local function isItemIgnored(itemLink)
	local id = getItemIdByLink(itemLink)

	return TransmogCleanup.db.ignoredItems[id]
end

local function getItemBind(bag, slot)
	local name = "TransmogCleanupTT"
	scanningTooltip = scanningTooltip or CreateFrame("GameTooltip", name, nil, "GameTooltipTemplate") -- TODO
	local r = nil
	scanningTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	scanningTooltip:SetBagItem(bag, slot)
	scanningTooltip:Show()
	for i = 1,scanningTooltip:NumLines() do
		if(_G[name.."TextLeft"..i]:GetText() == ITEM_BIND_ON_EQUIP) then
			r = 1
		elseif(_G[name.."TextLeft"..i]:GetText() == ITEM_SOULBOUND) then
			r = 2
		elseif(_G[name.."TextLeft"..i]:GetText() == ITEM_BNETACCOUNTBOUND) then
			r = 3
		end
	end
	scanningTooltip:Hide()
	return r
end

local function iterateBagItems()
	local itemList = {}

	for bag = 0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link then
				local ilvl = ItemUpgradeInfo:GetUpgradedItemLevel(link)
				--local transmoggable = isTransmogable(link)
				local bind = getItemBind(bag, slot)
				local _, _, quality = GetItemInfo(link)
				local vendorPrice = select(11, GetItemInfo(link))
				local hasOnUseEffect = GetItemSpell(link)
				local status = getTransmogStatus(link)

				if status ~= nil then
				if status and status > 0 then -- check if Can I Mog It checks the itemList
						if TransmogCleanup.db.filters.onuse or not hasOnUseEffect then -- not (not addon.db.filters.onuse and hasOnUseEffect)
					if ilvl <= TransmogCleanup.db.filters.ilvl then
						if TransmogCleanup.db.filters.quality[quality] then
							if TransmogCleanup.db.filters.bind[bind] then
								if TransmogCleanup.db.filters.learned[status] then
									itemList[#itemList+1] = {link = link, ilvl = ilvl, bag = bag, slot = slot, status = status, price = vendorPrice}
								else
									--print(link, "learned", status)
								end
							else
								--print(link, "bind", bind)
							end
						else
							--print(link, "quality", quality)
						end
					else
						--print(link, "ilvl", ilvl, TransmogCleanup.db.filters.ilvl, ilvl < TransmogCleanup.db.filters.ilvl)
						end
					else
						--print(link, "hasOnUseEffect", hasOnUseEffect)
					end
					else
						--print(link, "status", status)
				end
				else
					--print(link, "transmoggable", transmoggable)
			end
		end
	end
 end

	return itemList
end

local function sortItemList(itemList)
	sort(itemList, function(a,b)
		return a.ilvl == b.ilvl and a.link < b.link or a.ilvl < b.ilvl -- sort by ilvl, then by itemlink (should be item id)
	end)
	return itemList
end

local function isSafeModeEnabled()
	return TransmogCleanup.db.sellMode.safe
end

local function isVerboseModeEnabled()
	return TransmogCleanup.db.sellMode.verbose
end

local function sellItems()
	local itemList = sellWindow.scrollframe.content.itemList
	local itemsSold = 0
	local itemsSoldValue = 0

	for i = 1, #itemList do
		local item = itemList[i]
		if not isItemIgnored(item.link) then
			if item.price > 0 then

			local _, _, refundSec = GetContainerItemPurchaseInfo(item.bag, item.slot)
			if refundSec then
				print(("Not selling %s because it is still refundable. Please wait %s before selling it."):format(item.link, SecondsToTime(refundSec, true, true)))
			else
			if isVerboseModeEnabled() then
				print(("售出 %s ,赚了 %s."):format(item.link, GetCoinTextureString(item.price)))
			end

			UseContainerItem(item.bag, item.slot)
			itemsSold = itemsSold + 1
			itemsSoldValue = itemsSoldValue + item.price

			if isSafeModeEnabled() and i > 11 then
				print(("为了避免你卖错,先出售 %d 件装备.你后悔可选择购回.点击出售按钮继续出售剩下的 %d 件装备."):format(i, #itemList - i))
				break
					end
				end
			else
				if isVerboseModeEnabled() then
					print(("无法卖出 %s 因为不值钱."):format(item.link))
				end
			end
		else
			if isVerboseModeEnabled() then
				print(("无法卖出 %s 因为你不准."):format(item.link))
			end
		end
	end

	if itemsSold > 0 then
		print(("你卖了 %d 件幻化物品，赚了 %s "):format(itemsSold, GetCoinTextureString(itemsSoldValue)))
	else
		print("哥，全卖完了啊.")
	end
end

local function onIgnoredCheckedChange(self, ...)
	if IsControlKeyDown() then
		DressUpItemLink(self.item.link)
		self:SetChecked(not self:GetChecked()) -- hack it to the limit!
		if GameTooltip:GetOwner() == sellWindow then
			GameTooltip:SetPoint("TOPLEFT", SideDressUpFrame, "TOPRIGHT")
		end
	else
		TransmogCleanup.db.ignoredItems[self.itemId] = self:GetChecked()
	end
end

local function updateItemList(frame)
	local content = frame.scrollframe.content

	content.lines =	content.lines or {}

	local itemList = iterateBagItems()

	itemList = sortItemList(itemList)

	for i = #content.lines+1, #itemList do
		local cb = CreateFrame("CheckButton", "parentCB"..i, content, "InterfaceOptionsCheckButtonTemplate")
		cb:SetPoint("TOPLEFT", content, "TOPLEFT", 8, -1 - 16 * (i-1))
		cb:SetHitRectInsets(0, -300, 0, 0)
		cb:SetHeight(20)
		cb:SetWidth(20)
		cb:SetScript("OnClick", onIgnoredCheckedChange)
		cb:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(frame, "ANCHOR_NONE")
			if SideDressUpFrame:IsShown() then
				GameTooltip:SetPoint("TOPLEFT", SideDressUpFrame, "TOPRIGHT")
			else
				GameTooltip:SetPoint("TOPLEFT", frame, "TOPRIGHT")
			end
			GameTooltip:SetBagItem(self.item.bag, self.item.slot)
		end)
		cb:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

		local itemString = content:CreateFontString("$parentItem"..i, nil, "GameFontNormal")
		itemString:SetPoint("TOPLEFT", content, "TOPLEFT", 35, -5 - 16 * (i-1))
		itemString:SetFont(STANDARD_TEXT_FONT, 12)
		itemString:SetWidth(125)
		itemString:SetWordWrap(false)
		itemString:SetJustifyH("LEFT")

		local ilvlString = content:CreateFontString("$parentIlvl"..i, nil, "GameFontNormal")
		ilvlString:SetPoint("TOPLEFT", content, "TOPLEFT", 160, -5 - 16 * (i-1))
		ilvlString:SetFont(STANDARD_TEXT_FONT, 12)
		ilvlString:SetTextColor(1, 1, 1)
		ilvlString:SetJustifyH("CENTER")
		ilvlString:SetWidth(35)

		local statusString = content:CreateFontString("$parentStatus"..i, nil, "GameFontNormal")
		statusString:SetPoint("TOPLEFT", content, "TOPLEFT", 195, -5 - 16 * (i-1))
		statusString:SetFont(STANDARD_TEXT_FONT, 12)
		statusString:SetTextColor(1, 1, 1)
		statusString:SetJustifyH("LEFT")

		content.lines[#content.lines + 1] = {cb = cb, item = itemString, ilvl = ilvlString, status = statusString}
	end

	for i = 1, #itemList do
		local line = content.lines[i]
		line.cb:Show()
		line.item:Show()
		line.ilvl:Show()
		line.status:Show()
	end

	for i = #itemList+1, #content.lines do
		local line = content.lines[i]
		line.cb:Hide()
		line.cb.itemId = nil
		line.cb.item = nil
		line.item:Hide()
		line.ilvl:Hide()
		line.status:Hide()
	end

	for i = 1, #itemList do
		local line = content.lines[i]
		local item = itemList[i]

		line.cb:SetChecked(isItemIgnored(item.link))
		line.cb.itemId = getItemIdByLink(item.link)
		line.cb.item = item
		line.item:SetText(item.link)
		line.ilvl:SetText(item.ilvl)
		line.status:SetText(learnedTypes[item.status][1])
	end

	content.itemList = itemList

	content:SetWidth(300)
	content:SetHeight(#itemList * 16 + 5)

	frame.scrollbar:SetMinMaxValues(1, max(1, content:GetHeight() - (frame:GetHeight() - (180+35)))) -- scrollframe points
end

local function onFilterCheckedChange(self, ...)
	if self.type=="onuse" then
		TransmogCleanup.db.filters[self.type] = self:GetChecked()
	else
		TransmogCleanup.db.filters[self.type][self.id] = self:GetChecked()
	end
	updateItemList(sellWindow)
end

local function onSellModeCheckedChange(self, ...)
	TransmogCleanup.db.sellMode[self.type] = self:GetChecked()
end

local function ilvlSliderValueChanged(self, value)
	local newValue = floor(value + 0.5)
	self:SetValue(newValue)
	self.editbox:SetText(newValue)
	TransmogCleanup.db.filters.ilvl = newValue

	if updateItemListThrottle then
		updateItemListThrottle:Cancel()
	end

	updateItemListThrottle = C_Timer.NewTimer(0.2, function()
		updateItemList(sellWindow)
	end)
end

local function createSellWindow()
	-- Main Window
	local frame = CreateFrame("Frame", "TCSellWindow", MerchantFrame)
	frame:SetWidth(MerchantFrame:GetWidth())
	frame:SetHeight(MerchantFrame:GetHeight())
	frame:SetPoint("TOPLEFT", MerchantFrame, "TOPRIGHT", 26, 0)

	local tex = frame:CreateTexture("$parentBg","BACKGROUND")
	tex:SetColorTexture(0, 0, 0, 0.4)
	tex:SetAllPoints(frame)

	-- Header Text
	local header = frame:CreateFontString("$parentHeaderText", nil, "GameFontNormal")
	header:SetPoint("TOP", frame, "TOP", 0, -5)
	header:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
	header:SetTextColor(1, 1, 1)
	header:SetText("已收藏幻化装备自动出售")

	local filterText = frame:CreateFontString("$parentDescText", nil, "GameFontNormal")
	filterText:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -10 - header:GetStringHeight())
	filterText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
	filterText:SetTextColor(1, 1, 1)
	filterText:SetJustifyH("left")
	filterText:SetText("装备品质")

	local qualityCBs = {}
	for i = 1, #itemQualities do
		local cb = CreateFrame("CheckButton", "TCSellWindowQualityCB"..i, frame, "InterfaceOptionsCheckButtonTemplate")
		cb:SetPoint("LEFT", frame, "TOPLEFT", 15, -34 - 17 * i)
		_G["TCSellWindowQualityCB"..i.."Text"]:SetText(_G["ITEM_QUALITY"..i.."_DESC"])
		_G["TCSellWindowQualityCB"..i.."Text"]:SetTextColor(unpack(itemQualities[i]))
		cb:SetHitRectInsets(0, -80, 0, 0)
		cb.type = "quality"
		cb.id = i
		cb:SetScript("OnClick", onFilterCheckedChange)
		qualityCBs[#qualityCBs + 1] = cb
	end
	frame.qualityCBs = qualityCBs

	local bindCBs = {}
	for i = 1, #bindOn do
		local cb = CreateFrame("CheckButton", "TCSellWindowBindCB"..i, frame, "InterfaceOptionsCheckButtonTemplate")
		cb:SetPoint("LEFT", frame, "TOPLEFT", 100, -34 - 17 * i)
		_G["TCSellWindowBindCB"..i.."Text"]:SetText(bindOn[i][1])
		cb:SetHitRectInsets(0, -35, 0, 0)
		cb.type = "bind"
		cb.id = i
		cb:SetScript("OnClick", onFilterCheckedChange)
		bindCBs[#bindCBs + 1] = cb
	end
	frame.bindCBs = bindCBs

	local learnedCBs = {}
	for i = 1, #learnedTypes do
		local cb = CreateFrame("CheckButton", "TCSellWindowLearnedCB"..i, frame, "InterfaceOptionsCheckButtonTemplate")
		cb:SetPoint("LEFT", frame, "TOPLEFT", 180, -34 - 17 * i)
		_G["TCSellWindowLearnedCB"..i.."Text"]:SetText(learnedTypes[i][1])
		_G["TCSellWindowLearnedCB"..i.."Text"]:SetWidth(120)
		cb:SetHitRectInsets(0, -110, 0, 0)
		cb.type = "learned"
		cb.id = i
		cb:SetScript("OnClick", onFilterCheckedChange)
		learnedCBs[#learnedCBs + 1] = cb
	end
	frame.learnedCBs = learnedCBs

	-- some shenanigans for the long text CheckButton
	-- this will break with localization
	_G["TCSellWindowLearnedCB3Text"]:SetPoint("TOPLEFT", "TCSellWindowLearnedCB3", "TOPRIGHT", 2, 1)
	_G["TCSellWindowLearnedCB3Text"]:SetHeight(37)
	_G["TCSellWindowLearnedCB3Text"]:SetWordWrap(true)
	_G["TCSellWindowLearnedCB3Text"]:SetJustifyV("MIDDLE")

	-- On Use Filter
	local cb = CreateFrame("CheckButton", "TCSellWindowOnUseCB", frame, "InterfaceOptionsCheckButtonTemplate")
	cb:SetPoint("LEFT", frame, "TOPLEFT", 100, -102)
	_G["TCSellWindowOnUseCBText"]:SetText("使用中")
	cb:SetHitRectInsets(0, -35, 0, 0)
	cb.type = "onuse"
	cb:SetScript("OnClick", onFilterCheckedChange)
	frame.onUseCB = cb

	-- Safe mode selling
	local safeModeCB = CreateFrame("CheckButton", "TCSellWindowSafeModeCB", frame, "InterfaceOptionsCheckButtonTemplate")
	safeModeCB:SetPoint("LEFT", frame, "BOTTOMLEFT", 135, 24)
	safeModeCB:SetHeight(20)
	safeModeCB:SetWidth(20)
	_G["TCSellWindowSafeModeCBText"]:SetText("把稳")
	_G["TCSellWindowSafeModeCBText"]:SetFont(STANDARD_TEXT_FONT, 12)
	safeModeCB:SetHitRectInsets(0, -50, 0, 0)
	safeModeCB.type = "safe"
	safeModeCB:SetScript("OnClick", onSellModeCheckedChange)
	frame.safeModeCB = safeModeCB

	-- Verbose selling
	local verboseModeCB = CreateFrame("CheckButton", "TCSellWindowVerboseModeCB", frame, "InterfaceOptionsCheckButtonTemplate")
	verboseModeCB:SetPoint("TOPLEFT", safeModeCB, "BOTTOMLEFT", 0, 7)
	verboseModeCB:SetHeight(20)
	verboseModeCB:SetWidth(20)
	_G["TCSellWindowVerboseModeCBText"]:SetText("详细")
	_G["TCSellWindowVerboseModeCBText"]:SetFont(STANDARD_TEXT_FONT, 12)
	verboseModeCB:SetHitRectInsets(0, -50, 0, 0)
	verboseModeCB.type = "verbose"
	verboseModeCB:SetScript("OnClick", onSellModeCheckedChange)
	frame.verboseModeCB = verboseModeCB

	-- Item level slider
	local ilvlSlider = CreateFrame("Slider", "TCSellWindowIlvlSlider", frame, "OptionsSliderTemplate")
	ilvlSlider:SetPoint("TOPLEFT", frame, "TOPLEFT", 125, -120)
	ilvlSlider:SetWidth(190)
	_G["TCSellWindowIlvlSliderText"]:SetText("最高出售装等")
	_G["TCSellWindowIlvlSliderLow"]:SetText("1")
	_G["TCSellWindowIlvlSliderHigh"]:SetText("316")
	ilvlSlider:SetMinMaxValues(1, 316)
 	ilvlSlider:SetValue(210)
	ilvlSlider:SetValueStep(1)
	ilvlSlider:SetHitRectInsets(0, 0, 0, 0) -- default from OptionsSliderTemplate: 0,0,-10,-10

	local editbox = CreateFrame("EditBox", nil, frame, "BackdropTemplate")
	editbox:SetAutoFocus(false)
	editbox:SetFontObject(GameFontHighlightSmall)
	editbox:SetPoint("TOP", ilvlSlider, "BOTTOM")
	editbox:SetHeight(14)
	editbox:SetWidth(70)
	editbox:SetJustifyH("CENTER")
	editbox:EnableMouse(true)
	editbox:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
		tile = true, edgeSize = 1, tileSize = 5,
	})
	editbox:SetBackdropColor(0, 0, 0, 0.5)
	editbox:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80)
	editbox:SetText(ilvlSlider:GetValue())

	editbox.slider = ilvlSlider
	ilvlSlider.editbox = editbox
	frame.ilvlSlider = ilvlSlider

	ilvlSlider:SetScript("OnValueChanged", ilvlSliderValueChanged)

	editbox:SetScript("OnEnterPressed", function(self)
		self.slider:SetValue(tonumber(self:GetText()))
	end)

	editbox:SetScript("OnEscapePressed", function(self)
		self:SetText(self.slider:GetValue())
	end)

	local ignoredHeaderText = frame:CreateFontString("$parentIgnoredHeaderText", nil, "GameFontNormal")
	ignoredHeaderText:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -165)
	ignoredHeaderText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
	ignoredHeaderText:SetTextColor(1, 1, 1)
	ignoredHeaderText:SetText("忽略")

	local itemHeaderText = frame:CreateFontString("$parentItemHeaderText", nil, "GameFontNormal")
	itemHeaderText:SetPoint("TOPLEFT", frame, "TOPLEFT", 95, -165)
	itemHeaderText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
	itemHeaderText:SetTextColor(1, 1, 1)
	itemHeaderText:SetText("装备")

	local ilvlHeaderText = frame:CreateFontString("$parentIlvlHeaderText", nil, "GameFontNormal")
	ilvlHeaderText:SetPoint("TOPLEFT", frame, "TOPLEFT", 176, -165)
	ilvlHeaderText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
	ilvlHeaderText:SetTextColor(1, 1, 1)
	ilvlHeaderText:SetText("装等")

	local statusHeaderText = frame:CreateFontString("$parentStatusHeaderText", nil, "GameFontNormal")
	statusHeaderText:SetPoint("TOPLEFT", frame, "TOPLEFT", 235, -165)
	statusHeaderText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
	statusHeaderText:SetTextColor(1, 1, 1)
	statusHeaderText:SetText("可否幻化")

	--scrollframe
	local scrollframe = CreateFrame("ScrollFrame", nil, frame)
	scrollframe:SetPoint("TOPLEFT", 5, -180)
	scrollframe:SetPoint("BOTTOMRIGHT", -26, 35)
	scrollframe:SetScript("OnMouseWheel", function(self, value)
		local scrollbar = self:GetParent().scrollbar
		local scrollStep = scrollbar.scrollStep or scrollbar:GetHeight() / 2
		if ( value > 0 ) then
			scrollbar:SetValue(scrollbar:GetValue() - scrollStep)
		else
			scrollbar:SetValue(scrollbar:GetValue() + scrollStep)
		end
	end)
	local texture = scrollframe:CreateTexture()
	texture:SetAllPoints()
	texture:SetColorTexture(0, 0, 0, 0.4)
	frame.scrollframe = scrollframe

	--scrollbar
	local scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate")
	scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 2, -16)
	scrollbar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", 2, 16)
	scrollbar:SetMinMaxValues(1, 200)
	scrollbar:SetValueStep(1)
	scrollbar:SetValue(0)
	scrollbar:SetWidth(16)
	scrollbar:SetScript("OnValueChanged", function (self, value)
		self:GetParent():SetVerticalScroll(value)
	end)
	local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND")
	scrollbg:SetAllPoints(scrollbar)
	scrollbg:SetColorTexture(0, 0, 0, 0.4)
	frame.scrollbar = scrollbar

	--content frame
	local content = CreateFrame("Frame", nil, scrollframe)

	scrollbar.scrollStep = 16

	scrollframe.content = content

	scrollframe:SetScrollChild(content)

	local sellButton = CreateFrame("Button", "TCSellWindowSellButton", frame, "UIPanelButtonTemplate")
	sellButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5)
	sellButton:SetWidth(120)
	sellButton:SetHeight(26)
	sellButton:SetText("说卖就卖!")
	sellButton:SetScript("OnClick", function(self) sellItems() end)

	local hideButton = CreateFrame("Button", "TCSellWindowSellButton", frame, "UIPanelButtonTemplate")
	hideButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 5, 5)
	hideButton:SetWidth(120)
	hideButton:SetHeight(26)
	hideButton:SetText("关闭")
	hideButton:SetScript("OnClick", function(self) self:GetParent():Hide() end)

	frame:Hide()

	sellWindow = frame
end

local function updateSellSettings(sellWindow)
	for i =1,#sellWindow.qualityCBs do
		sellWindow.qualityCBs[i]:SetChecked(TransmogCleanup.db.filters.quality[i])
	end

	for i =1,#sellWindow.bindCBs do
		sellWindow.bindCBs[i]:SetChecked(TransmogCleanup.db.filters.bind[i])
	end

	for i =1,#sellWindow.learnedCBs do
		sellWindow.learnedCBs[i]:SetChecked(TransmogCleanup.db.filters.learned[i])
	end

	sellWindow.onUseCB:SetChecked(TransmogCleanup.db.filters.onuse)

	sellWindow.ilvlSlider:SetValue(TransmogCleanup.db.filters.ilvl)

	sellWindow.safeModeCB:SetChecked(TransmogCleanup.db.sellMode.safe)

	sellWindow.verboseModeCB:SetChecked(TransmogCleanup.db.sellMode.verbose)
end

local function displaySellWindow()
	--print("displaySellWindow:", sellWindow and "window already created" or "creating window")

	if not sellWindow then createSellWindow() end

	updateSellSettings(sellWindow)

	updateItemList(sellWindow)

	SetUpSideDressUpFrame(sellWindow, 400, 600, "TOPLEFT", "TOPRIGHT", -5, 0)

	sellWindow:Show()
end

local function hideSellWindow()
	--print("sellWindow()", sellWindow, lastWindowState)
	if sellWindow then
		lastWindowState = sellWindow:IsShown()
		sellWindow:Hide()
		CloseSideDressUpFrame(sellWindow)
	end
end

local function toggleSellWindows()
	if sellWindow and sellWindow:IsShown() then
		hideSellWindow()
	else
		displaySellWindow()
	end
end

local function fixButtonPosition()
	local fixPosition, fixFramelevel = nil, nil

	-- Addons which use the space our button should be
	if SellJunk then
		fixPosition = true
	end

	if IsAddOnLoaded("GnomishVendorShrinker") then
		fixPosition = true
		fixFramelevel = true
	end

	-- different solutions for whatever is needed
	if fixPosition then
		merchantButton:SetPoint("BOTTOMLEFT", MerchantFramePortrait, "BOTTOMRIGHT", 5, -12)
		merchantButton:SetHeight(16)
	end

	if fixFramelevel then
		merchantButton:SetFrameLevel(merchantButton:GetFrameLevel()+2)
	end
end

local function createMerchantButton()
	if not merchantButton then
		merchantButton = CreateFrame("Button", "TCMerchantButton", MerchantFrame, "UIPanelButtonTemplate")
		merchantButton:SetWidth(160)
		merchantButton:SetHeight(26)
		merchantButton:SetPoint("TOPRIGHT", MerchantFrame, "BOTTOMRIGHT", -6, 0)
		merchantButton:SetText("幻化装备出售")
		merchantButton:SetScript("OnClick", function(self) toggleSellWindows() end)
	end
	fixButtonPosition() -- dirty hack to avoid overlapping buttons with other addons
	C_Timer.NewTicker(0.2, function() -- give lod addons some time to load
		fixButtonPosition()
	end, 5)
end

-- Event Handler
local events = {}

function events:ADDON_LOADED(...)
	if select(1, ...) == "TransMogMaster" then
		TransmogCleanup:UnregisterEvent("ADDON_LOADED")
		TransmogCleanup.db = TransmogCleanupDB
		local db = TransmogCleanup.db

		if not db.filters then
			db.filters = {
				["quality"] = {
					[1] = true,
					[2] = true,
					[3] = true,
					[4] = true,
				},
				["bind"] = {
					[1] = true,
					[2] = true,
					[3] = true,
				},
				["learned"] = {
					[1] = true,
					[2] = true,
				},
				["ilvl"] = 700,
			}
		end
		if not db.filters.onuse and db.filters.onuse ~= false then
			db.filters.onuse = true
		end

		if not db.ignoredItems then
			db.ignoredItems = {}
		end

		for k,v in pairs(TransmogCleanup:getDefaultIgnoredItems()) do
			if not db.ignoredItems[k] and db.ignoredItems[k] ~= false then
				db.ignoredItems[k] = v
			end
		end

		if not db.sellMode then
			db.sellMode = {
				["safe"] = true,
				["verbose"] = false,
			}
		end
	end
end

function events:MERCHANT_SHOW(...)
	if enabled then
		createMerchantButton()
	end

	if sellWindow and lastWindowState then
		displaySellWindow()
	end
end

local prev = 0 -- Throttle because MERCHANT_CLOSED fires twice
function events:MERCHANT_CLOSED(...)
	local t = GetTime()

	if t - prev > 1 then
		prev = t
		hideSellWindow()
	end
end

function events:BAG_UPDATE(...)
	if sellWindow and sellWindow:IsShown() then
		if updateItemListThrottle then
			updateItemListThrottle:Cancel()
		end

		updateItemListThrottle = C_Timer.NewTimer(0.2, function()
			updateItemList(sellWindow)
		end)
	end
end
TransmogCleanup:SetScript("OnEvent", function(self, event, ...)
	events[event](self, ...)
end)
for k,_ in pairs(events) do
	TransmogCleanup:RegisterEvent(k)
end


SlashCmdList['TRANSMOGCLEANUP_SLASHCMD'] = slashCmdHandler
SLASH_TRANSMOGCLEANUP_SLASHCMD1 = '/transmogcleanup'

--------------------------------------------------------------------------------
-- TransmogCleanup by Elvador
--
function TransmogCleanup:getDefaultIgnoredItems()
	return {
		-- List from http://www.wowhead.com/item=65274/cloak-of-coordination#comments
		[6948] = true, --Hearthstone
		[17690] = true, --Frostwolf Insignia Rank 1
		[17691] = true, --Stormpike Insignia Rank 1
		[17900] = true, --Stormpike Insignia Rank 2
		[17901] = true, --Stormpike Insignia Rank 3
		[17902] = true, --Stormpike Insignia Rank 4
		[17903] = true, --Stormpike Insignia Rank 5
		[17904] = true, --Stormpike Insignia Rank 6
		[17905] = true, --Frostwolf Insignia Rank 2
		[17906] = true, --Frostwolf Insignia Rank 3
		[17907] = true, --Frostwolf Insignia Rank 4
		[17908] = true, --Frostwolf Insignia Rank 5
		[17909] = true, --Frostwolf Insignia Rank 6
		[18984] = true, --Dimensional Ripper - Everlook
		[18986] = true, --Ultrasafe Transporter: Gadgetzan
		[22631] = true, --Atiesh, Greatstaff of the Guardian
		[28585] = true, --Ruby Slippers
		[30542] = true, --Dimensional Ripper - Area 52
		[30544] = true, --Ultrasafe Transporter: Toshley's Station
		[32757] = true, --Blessed Medallion of Karabor
		[37118] = true, --Scroll of Recall
		[37863] = true, --Direbrew's Remote
		[40585] = true, --Signet of the Kirin Tor
		[44314] = true, --Scroll of Recall II
		[44315] = true, --Scroll of Recall III
		[45691] = true, --Inscribed Signet of the Kirin Tor
		[46874] = true, --Argent Crusader's Tabard
		[48933] = true, --Wormhole Generator: Northrend
		[48957] = true, --Etched Signet of the Kirin Tor
		[50287] = true, --Boots of the Bay
		[51557] = true, --Runed Signet of the Kirin Tor
		[52251] = true, --Jaina's Locket
		[54452] = true, --Ethereal Portal
		[58487] = true, --Potion of Deepholm
		[63206] = true, --Wrap of Unity
		[63207] = true, --Wrap of Unity
		[63352] = true, --Shroud of Cooperation
		[63353] = true, --Shroud of Cooperation
		[63378] = true, --Hellscream's Reach Tabard
		[63379] = true, --Baradin's Wardens Tabard
		[64457] = true, --The Last Relic of Argus
		[64488] = true, --The Innkeeper's Daughter
		[65274] = true, --Cloak of Coordination
		[65360] = true, --Cloak of Coordination
		[87215] = true, --Wormhole Generator: Pandaria
		[93672] = true, --Dark Portal
		[95050] = true, --The Brassiest Knuckle
		[95051] = true, --The Brassiest Knuckle
		[103678] = true, --Time-Lost Artifact

		[52252] = true, -- Tabard of the Lightbringer

		[9149] = true, -- Philosopher's Stone
		[13503] = true, -- Alchemist Stone
		[31080] = true, -- Mercurial Stone
		[35748] = true, -- Guardian's Alchemist Stone
		[35749] = true, -- Sorcerer's Alchemist Stone
		[35750] = true, -- Redeemer's Alchemist Stone
		[35751] = true, -- Assassin's Alchemist Stone
		[44322] = true, -- Mercurial Alchemist Stone
		[44323] = true, -- Indestructible Alchemist Stone
		[44324] = true, -- Mighty Alchemist Stone
		[58483] = true, -- Lifebound Alchemist Stone
		[68775] = true, -- Volatile Alchemist Stone
		[68776] = true, -- Quicksilver Alchemist Stone
		[68777] = true, -- Vibrant Alchemist Stone
		[75274] = true, -- Zen Alchemist Stone
		[109262] = true, -- Draenic Philosopher's Stone
		[122601] = true, -- Stone of Wind
		[122602] = true, -- Stone of the Earth
		[122603] = true, -- Stone of the Waters
		[122604] = true, -- Stone of Fire
		[127842] = true, -- Infernal Alchemist Stone
		[128023] = true, -- Stone of the Wilds
		[128024] = true, -- Stone of the Elements
		
		[44050] = true, --Mastercraft Kalu'ak Fishing Pole
		[84661] = true, --dragon-fishing-pole
		[45858] = true, --nats-lucky-fishing-pole
		[19970] = true, --arcanite-fishing-pole
		
		[44935] = true, --Ring of the Kirin Tor
		[40586] = true, --Band of the Kirin Tor
		[44934] = true, --Loop of the Kirin Tor
		[45688] = true, --Inscribed Band of the Kirin Tor
		[45689] = true, --Inscribed Loop of the Kirin Tor
		[45690] = true, --Inscribed Ring of the Kirin Tor
		[48954] = true, --Etched Band of the Kirin Tor
		[48955] = true, --Etched Loop of the Kirin Tor
		[48956] = true, --Etched Ring of the Kirin Tor
		[51558] = true, --Runed Loop of the Kirin Tor
		[51559] = true, --Runed Ring of the Kirin Tor
		[51560] = true, --Runed Band of the Kirin Tor
	}
end
