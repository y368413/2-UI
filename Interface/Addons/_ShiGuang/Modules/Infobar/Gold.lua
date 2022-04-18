local _, ns = ...
local M, R, U, I = unpack(ns)
if not R.Infobar.Gold then return end

local module = M:GetModule("Infobar")
local info = module:RegisterInfobar("Gold", R.Infobar.GoldPos)

local format, pairs, wipe, unpack = string.format, pairs, table.wipe, unpack
local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS
local GetMoney, GetNumWatchedTokens, Ambiguate = GetMoney, GetNumWatchedTokens, Ambiguate
local GetContainerNumSlots, GetContainerItemInfo, UseContainerItem = GetContainerNumSlots, GetContainerItemInfo, UseContainerItem
local GetContainerItemEquipmentSetInfo = GetContainerItemEquipmentSetInfo
local C_Timer_After, IsControlKeyDown, IsShiftKeyDown = C_Timer.After, IsControlKeyDown, IsShiftKeyDown
local C_CurrencyInfo_GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo
local C_CurrencyInfo_GetBackpackCurrencyInfo = C_CurrencyInfo.GetBackpackCurrencyInfo
local CalculateTotalNumberOfFreeBagSlots = CalculateTotalNumberOfFreeBagSlots
local slotString = U["Bags"]..": %s%d"

local profit, spent, oldMoney = 0, 0, 0
local myName, myRealm = I.MyName, I.MyRealm

local crossRealms = GetAutoCompleteRealms()
if not crossRealms or #crossRealms == 0 then
	crossRealms = {[1]=myRealm}
end

local function getClassIcon(class)
	local c1, c2, c3, c4 = unpack(CLASS_ICON_TCOORDS[class])
	c1, c2, c3, c4 = (c1+.03)*50, (c2-.03)*50, (c3+.03)*50, (c4-.03)*50
	local classStr = "|TInterface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes:13:15:0:-1:50:50:"..c1..":"..c2..":"..c3..":"..c4.."|t "
	return classStr or ""
end

local function getSlotString()
	local num = CalculateTotalNumberOfFreeBagSlots()
	if num < 10 then
		return format(slotString, "|cffff0000", num)
	else
		return format(slotString, "|cff00ff00", num)
	end
end

info.eventList = {
	"PLAYER_MONEY",
	"SEND_MAIL_MONEY_CHANGED",
	"SEND_MAIL_COD_CHANGED",
	"PLAYER_TRADE_MONEY",
	"TRADE_MONEY_CHANGED",
	"PLAYER_ENTERING_WORLD",
}

info.onEvent = function(self, event, arg1)
	if event == "PLAYER_ENTERING_WORLD" then
		oldMoney = GetMoney()
		self:UnregisterEvent(event)

		if MaoRUIDB["ShowSlots"] then
			self:RegisterEvent("BAG_UPDATE")
		end
	elseif event == "BAG_UPDATE" then
		if arg1 < 0 or arg1 > 4 then return end
	end

	local newMoney = GetMoney()
	local change = newMoney - oldMoney	-- Positive if we gain money
	if oldMoney > newMoney then			-- Lost Money
		spent = spent - change
	else								-- Gained Moeny
		profit = profit + change
	end
	--if MaoRUIDB["ShowSlots"] then
		--self.text:SetText(getSlotString())
	--else
		self.text:SetText(module:GetMoneyString(newMoney))
	--end

	if not MaoRUIDB["totalGold"][myRealm] then MaoRUIDB["totalGold"][myRealm] = {} end
	if not MaoRUIDB["totalGold"][myRealm][myName] then MaoRUIDB["totalGold"][myRealm][myName] = {} end
	MaoRUIDB["totalGold"][myRealm][myName][1] = GetMoney()
	MaoRUIDB["totalGold"][myRealm][myName][2] = I.MyClass

	oldMoney = newMoney
end

StaticPopupDialogs["RESETGOLD"] = {
	text = U["Are you sure to reset the gold count?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		for _, realm in pairs(crossRealms) do
			if MaoRUIDB["totalGold"][realm] then
				wipe(MaoRUIDB["totalGold"][realm])
			end
		end
		MaoRUIDB["totalGold"][myRealm][myName] = {GetMoney(), I.MyClass}
	end,
	whileDead = 1,
}

info.onMouseUp = function(self, btn)
	if btn == "RightButton" then
		--if IsControlKeyDown() then
			StaticPopup_Show("RESETGOLD")
		--else
			--MaoRUIDB["ShowSlots"] = not MaoRUIDB["ShowSlots"]
			--if MaoRUIDB["ShowSlots"] then
				--self:RegisterEvent("BAG_UPDATE")
			--else
				--self:UnregisterEvent("BAG_UPDATE")
			--end
			--self:onEvent()
		--end
	elseif btn == "MiddleButton" then
		MaoRUIDB["AutoSell"] = not MaoRUIDB["AutoSell"]
		self:onEnter()
	else
		--if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end -- fix by LibShowUIPanel
		ToggleCharacter("TokenFrame")
	end
end

info.onEnter = function(self)
	local _, anchor, offset = module:GetTooltipAnchor(info)
	GameTooltip:SetOwner(self, "ANCHOR_"..anchor, 0, offset)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(CURRENCY, 0,.6,1)
	GameTooltip:AddLine(" ")

	GameTooltip:AddLine(U["Session"], .6,.8,1)
	GameTooltip:AddDoubleLine(U["Earned"], module:GetMoneyString(profit, true), 1,1,1, 1,1,1)
	GameTooltip:AddDoubleLine(U["Spent"], module:GetMoneyString(spent, true), 1,1,1, 1,1,1)
	if profit < spent then
		GameTooltip:AddDoubleLine(U["Deficit"], module:GetMoneyString(spent-profit, true), 1,0,0, 1,1,1)
	elseif profit > spent then
		GameTooltip:AddDoubleLine(U["Profit"], module:GetMoneyString(profit-spent, true), 0,1,0, 1,1,1)
	end
	GameTooltip:AddLine(" ")

	local totalGold = 0
	GameTooltip:AddLine(U["RealmCharacter"], .6,.8,1)
	for _, realm in pairs(crossRealms) do
		local thisRealmList = MaoRUIDB["totalGold"][realm]
		if thisRealmList then
			for k, v in pairs(thisRealmList) do
				local name = Ambiguate(k.."-"..realm, "none")
				local gold, class = unpack(v)
				local r, g, b = M.ClassColor(class)
				GameTooltip:AddDoubleLine(getClassIcon(class)..name, module:GetMoneyString(gold), r,g,b, 1,1,1)
				totalGold = totalGold + gold
			end
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(TOTAL..":", module:GetMoneyString(totalGold), .6,.8,1, 1,1,1)

	for i = 1, GetNumWatchedTokens() do
		local currencyInfo = C_CurrencyInfo_GetBackpackCurrencyInfo(i)
		if not currencyInfo then break end
		local name, count, icon, currencyID = currencyInfo.name, currencyInfo.quantity, currencyInfo.iconFileID, currencyInfo.currencyTypesID
		if name and i == 1 then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(CURRENCY..":", .6,.8,1)
		end
		if name and count then
			local total = C_CurrencyInfo_GetCurrencyInfo(currencyID).maxQuantity
			local iconTexture = " |T"..icon..":13:15:0:0:50:50:4:46:4:46|t"
			if total > 0 then
				GameTooltip:AddDoubleLine(name, count.."/"..total..iconTexture, 1,1,1, 1,1,1)
			else
				GameTooltip:AddDoubleLine(name, count..iconTexture, 1,1,1, 1,1,1)
			end
		end
	end
  GameTooltip:AddDoubleLine(" ","--------------",1,1,1,0.5,0.5,0.5)
	GameTooltip:AddDoubleLine(" ",U["AutoSell Junk"]..": "..(MaoRUIDB["AutoSell"] and "|cff55ff55"..VIDEO_OPTIONS_ENABLED or "|cffff5555"..VIDEO_OPTIONS_DISABLED),1,1,1,.6,.8,1)
	GameTooltip:Show()
end

info.onLeave = M.HideTooltip

-- Auto selljunk
local stop, cache = true, {}
local errorText = _G.ERR_VENDOR_DOESNT_BUY

local function startSelling()
	if stop then return end
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			if stop then return end
			local _, _, _, quality, _, _, link, _, noValue, itemID = GetContainerItemInfo(bag, slot)
			local isInSet = GetContainerItemEquipmentSetInfo(bag, slot)
			if link and not noValue and not isInSet and (quality == 0 or MaoRUIDB["CustomJunkList"][itemID]) and not cache["b"..bag.."s"..slot] then
				cache["b"..bag.."s"..slot] = true
				UseContainerItem(bag, slot)
				C_Timer_After(.1, startSelling)
				return
			end
		end
	end
end

local function updateSelling(event, ...)
	if not MaoRUIDB["AutoSell"] then return end

	local _, arg = ...
	if event == "MERCHANT_SHOW" then
		if IsShiftKeyDown() then return end
		stop = false
		wipe(cache)
		startSelling()
		M:RegisterEvent("UI_ERROR_MESSAGE", updateSelling)
	elseif event == "UI_ERROR_MESSAGE" and arg == errorText or event == "MERCHANT_CLOSED" then
		stop = true
	end
end
M:RegisterEvent("MERCHANT_SHOW", updateSelling)
M:RegisterEvent("MERCHANT_CLOSED", updateSelling)