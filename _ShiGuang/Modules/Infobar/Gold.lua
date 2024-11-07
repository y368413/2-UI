local _, ns = ...
local M, R, U, I = unpack(ns)
if not R.Infobar.Gold then return end

local module = M:GetModule("Infobar")
local info = module:RegisterInfobar("Gold", R.Infobar.GoldPos)

local format, pairs, wipe, unpack = string.format, pairs, table.wipe, unpack
local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS
local GetMoney, GetNumWatchedTokens, Ambiguate = GetMoney, GetNumWatchedTokens, Ambiguate
local C_Timer_After, IsControlKeyDown, IsShiftKeyDown = C_Timer.After, IsControlKeyDown, IsShiftKeyDown
local C_CurrencyInfo_GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo
local C_CurrencyInfo_GetBackpackCurrencyInfo = C_CurrencyInfo.GetBackpackCurrencyInfo
local CalculateTotalNumberOfFreeBagSlots = CalculateTotalNumberOfFreeBagSlots
local C_TransmogCollection_GetItemInfo = C_TransmogCollection.GetItemInfo
local C_Container_UseContainerItem = C_Container.UseContainerItem
local C_Container_GetContainerNumSlots = C_Container.GetContainerNumSlots
local C_Container_GetContainerItemInfo = C_Container.GetContainerItemInfo

local slotString = U["Bags"]..": %s%d"

local profit, spent, oldMoney = 0, 0, 0
local myName, myRealm = I.MyName, I.MyRealm
myRealm = gsub(myRealm, "%s", "") -- fix for multi words realm name

StaticPopupDialogs["RESETGOLD"] = {
	text = U["Are you sure to reset the gold count?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		wipe(MaoRUISetDB["totalGold"])
		if not MaoRUISetDB["totalGold"][myRealm] then MaoRUISetDB["totalGold"][myRealm] = {} end
		MaoRUISetDB["totalGold"][myRealm][myName] = {GetMoney(), I.MyClass}
	end,
	whileDead = 1,
}

local menuList = {
	{text = M.HexRGB(1, .8, 0)..REMOVE_WORLD_MARKERS.."!!!", notCheckable = true, func = function() StaticPopup_Show("RESETGOLD") end},
}

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

		if MaoRUISetDB["ShowSlots"] then
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
	--if MaoRUISetDB["ShowSlots"] then
		--self.text:SetText(getSlotString())
	--else
		self.text:SetText(module:GetMoneyString(newMoney))
	--end

	if not MaoRUISetDB["totalGold"][myRealm] then MaoRUISetDB["totalGold"][myRealm] = {} end
	if not MaoRUISetDB["totalGold"][myRealm][myName] then MaoRUISetDB["totalGold"][myRealm][myName] = {} end
	MaoRUISetDB["totalGold"][myRealm][myName][1] = GetMoney()
	MaoRUISetDB["totalGold"][myRealm][myName][2] = I.MyClass

	oldMoney = newMoney
end

local RebuildCharList

local function clearCharGold(_, realm, name)
	MaoRUISetDB["totalGold"][realm][name] = nil
	DropDownList1:Hide()
	RebuildCharList()
end

function RebuildCharList()
	for i = 2, #menuList do
		if menuList[i] then wipe(menuList[i]) end
	end

	local index = 1
	for realm, data in pairs(MaoRUISetDB["totalGold"]) do
		for name, value in pairs(data) do
			if not (realm == myRealm and name == myName) then
				index = index + 1
				if not menuList[index] then menuList[index] = {} end
				menuList[index].text = M.HexRGB(M.ClassColor(value[2]))..Ambiguate(name.."-"..realm, "none")
				menuList[index].notCheckable = true
				menuList[index].arg1 = realm
				menuList[index].arg2 = name
				menuList[index].func = clearCharGold
			end
		end
	end
end

info.onMouseUp = function(self, btn)
	if btn == "RightButton" then
		--if IsControlKeyDown() then
			if not menuList[1].created then
				RebuildCharList()
				menuList[1].created = true
			end
			EasyMenu(menuList, M.EasyMenu, self, -80, 100, "MENU", 1)
		--else
			--MaoRUISetDB["ShowSlots"] = not MaoRUISetDB["ShowSlots"]
			--if MaoRUISetDB["ShowSlots"] then
				--self:RegisterEvent("BAG_UPDATE")
			--else
				--self:UnregisterEvent("BAG_UPDATE")
			--end
			--self:onEvent()
		--end
	elseif btn == "MiddleButton" then
		MaoRUISetDB["AutoSell"] = not MaoRUISetDB["AutoSell"]
		self:onEnter()
	else
		--if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end -- fix by LibShowUIPanel
		ToggleCharacter("TokenFrame")
	end
end

local title

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

	if MaoRUISetDB["totalGold"][myRealm] then
		for k, v in pairs(MaoRUISetDB["totalGold"][myRealm]) do
			local name = Ambiguate(k.."-"..myRealm, "none")
			local gold, class = unpack(v)
			local r, g, b = M.ClassColor(class)
			GameTooltip:AddDoubleLine(getClassIcon(class)..name, module:GetMoneyString(gold), r,g,b, 1,1,1)
			totalGold = totalGold + gold
		end
	end

	local isShiftKeyDown = IsShiftKeyDown()
	for realm, data in pairs(MaoRUISetDB["totalGold"]) do
		if realm ~= myRealm then
			for k, v in pairs(data) do
				local gold, class = unpack(v)
				if isShiftKeyDown then -- show other realms while holding shift
					local name = Ambiguate(k.."-"..realm, "none")
					local r, g, b = M.ClassColor(class)
					GameTooltip:AddDoubleLine(getClassIcon(class)..name, module:GetMoneyString(gold), r,g,b, 1,1,1)
				end
				totalGold = totalGold + gold
			end
		end
	end
	if not isShiftKeyDown then
		GameTooltip:AddLine(U["Hold Shift"], .6,.8,1)
	end

	local accountmoney = C_Bank.FetchDepositedMoney(Enum.BankType.Account)
	GameTooltip:AddDoubleLine(CHARACTER..":", module:GetMoneyString(totalGold), .6,.8,1, 1,1,1)
	GameTooltip:AddDoubleLine(ACCOUNT_BANK_PANEL_TITLE..":", module:GetMoneyString(accountmoney), .6,.8,1, 1,1,1)
	GameTooltip:AddDoubleLine(TOTAL..":", module:GetMoneyString(totalGold + accountmoney), .6,.8,1, 1,1,1)

	title = false
	local chargeInfo = C_CurrencyInfo_GetCurrencyInfo(2813) -- Tier charges
	if chargeInfo then
		if not title then
			GameTooltip:AddLine(CURRENCY..":", .6,.8,1)
			title = true
		end
		local iconTexture = " |T"..chargeInfo.iconFileID..":13:15:0:0:50:50:4:46:4:46|t"
		GameTooltip:AddDoubleLine(chargeInfo.name, chargeInfo.quantity.."/"..chargeInfo.maxQuantity..iconTexture, 1,1,1, 1,1,1)
	end

	for i = 1, 10 do -- seems unlimit, but use 10 for now, needs review
		local currencyInfo = C_CurrencyInfo_GetBackpackCurrencyInfo(i)
		if not currencyInfo then break end
		local name, count, icon, currencyID = currencyInfo.name, currencyInfo.quantity, currencyInfo.iconFileID, currencyInfo.currencyTypesID
		if name and count then
			if not title then
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(CURRENCY..":", .6,.8,1)
				title = true
			end
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
	GameTooltip:AddDoubleLine(" ", I.ScrollButton..U["AutoSell Junk"]..": "..(MaoRUISetDB["AutoSell"] and "|cff55ff55"..VIDEO_OPTIONS_ENABLED or "|cffff5555"..VIDEO_OPTIONS_DISABLED).." ", 1,1,1, .6,.8,1)
	GameTooltip:AddDoubleLine(" ", I.RightButton..U["Reset Gold"].." ", 1,1,1, .6,.8,1)
	GameTooltip:Show()
end

info.onLeave = M.HideTooltip

-- Auto selljunk
local stop, cache = true, {}
local errorText = _G.ERR_VENDOR_DOESNT_BUY

local function startSelling()
	if stop then return end
	for bag = 0, 5 do
		for slot = 1, C_Container_GetContainerNumSlots(bag) do
			if stop then return end
			local info = C_Container_GetContainerItemInfo(bag, slot)
			if info then
				if not cache["b"..bag.."s"..slot] and info.hyperlink and not info.hasNoValue
				and (info.quality == 0 or MaoRUISetDB["CustomJunkList"][info.itemID])
				and (not C_TransmogCollection_GetItemInfo(info.hyperlink) or not M.IsUnknownTransmog(bag, slot)) then
					cache["b"..bag.."s"..slot] = true
					C_Container_UseContainerItem(bag, slot)
					C_Timer_After(.1, startSelling)
					return
				end
			end
		end
	end
end

local function updateSelling(event, ...)
	if not MaoRUISetDB["AutoSell"] then return end

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