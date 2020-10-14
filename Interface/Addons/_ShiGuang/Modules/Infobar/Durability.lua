local _, ns = ...
local M, R, U, I = unpack(ns)
local oUF = ns.oUF
if not R.Infobar.Durability then return end

local module = M:GetModule("Infobar")
local info = module:RegisterInfobar("Durability", R.Infobar.DurabilityPos)

local format, sort, floor, select = string.format, table.sort, math.floor, select
local GetInventoryItemLink, GetInventoryItemDurability, GetInventoryItemTexture = GetInventoryItemLink, GetInventoryItemDurability, GetInventoryItemTexture
local GetMoney, GetRepairAllCost, RepairAllItems, CanMerchantRepair = GetMoney, GetRepairAllCost, RepairAllItems, CanMerchantRepair
local GetAverageItemLevel, IsInGuild, CanGuildBankRepair, GetGuildBankWithdrawMoney = GetAverageItemLevel, IsInGuild, CanGuildBankRepair, GetGuildBankWithdrawMoney
local C_Timer_After, IsShiftKeyDown, InCombatLockdown, CanMerchantRepair = C_Timer.After, IsShiftKeyDown, InCombatLockdown, CanMerchantRepair
local HelpTip = HelpTip

local repairCostString = gsub(REPAIR_COST, HEADER_COLON, ":")
local lowDurabilityCap = .25

local localSlots = {
	[1] = {1, HEADSLOT, 1000},
		[2] = {3, SHOULDERSLOT, 1000},
		[3] = {5, CHESTSLOT, 1000},
		[4] = {6, WAISTSLOT, 1000},
		[5] = {9, WRISTSLOT, 1000},
		[6] = {10, HANDSSLOT, 1000},
		[7] = {7, LEGSSLOT, 1000},
		[8] = {8, FEETSLOT, 1000},
		[9] = {16, MAINHANDSLOT, 1000},
		[10] = {17, SECONDARYHANDSLOT, 1000}
}

local function hideAlertWhileCombat()
	if InCombatLockdown() then
		info:RegisterEvent("PLAYER_REGEN_ENABLED")
		info:UnregisterEvent("UPDATE_INVENTORY_DURABILITY")
	end
end

local lowDurabilityInfo = {
	text = U["Low Durability"],
	buttonStyle = HelpTip.ButtonStyle.Okay,
	targetPoint = HelpTip.Point.TopEdgeCenter,
	onAcknowledgeCallback = hideAlertWhileCombat,
	offsetY = 10,
}

local function sortSlots(a, b)
	if a and b then
		return (a[3] == b[3] and a[1] < b[1]) or (a[3] < b[3])
	end
end

local function UpdateAllSlots()
	local numSlots = 0
	for i = 1, 10 do
		localSlots[i][3] = 1000
		local index = localSlots[i][1]
		if GetInventoryItemLink("player", index) then
			local current, max = GetInventoryItemDurability(index)
			if current then
				localSlots[i][3] = current/max
				numSlots = numSlots + 1
			end
			localSlots[i][4] = "|T"..GetInventoryItemTexture("player", index)..":13:15:0:0:50:50:4:46:4:46|t " or ""
		end
	end
	sort(localSlots, sortSlots)

	return numSlots
end

local function isLowDurability()
	for i = 1, 10 do
		if localSlots[i][3] < lowDurabilityCap then
			return true
		end
	end
end

local function getDurabilityColor(cur, max)
	local r, g, b = oUF:RGBColorGradient(cur, max, 1, 0, 0, 1, 1, 0, 0, 1, 0)
	return r, g, b
end

info.eventList = {
	"UPDATE_INVENTORY_DURABILITY", "PLAYER_ENTERING_WORLD",
}

info.onEvent = function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent(event)
	end

	local numSlots = UpdateAllSlots()
	local isLow = isLowDurability()

	if event == "PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent(event)
		self:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	else
		if numSlots > 0 then
			local r, g, b = getDurabilityColor(floor(localSlots[1][3]*100), 100)
			self.text:SetFormattedText("%s%%|r", M.HexRGB(r, g, b)..floor(localSlots[1][3]*100))
		else
			self.text:SetText(I.MyColor..NONE)
		end
	end

	if isLow then
		HelpTip:Show(info, lowDurabilityInfo)
	else
		HelpTip:Hide(info, U["Low Durability"])
	end
end

info.onMouseUp = function(self, btn)
	if btn == "RightButton" then
		MaoRUIDB["RepairType"] = mod(MaoRUIDB["RepairType"] + 1, 3)
		self:onEnter()
	else
		if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end
		ToggleCharacter("PaperDollFrame")
	end
end

local repairlist = {
	[0] = "|cffff5555"..VIDEO_OPTIONS_DISABLED,
	[1] = "|cff55ff55"..VIDEO_OPTIONS_ENABLED,
	[2] = "|cffffff55"..U["NFG"]
}

info.onEnter = function(self)
	local total, equipped = GetAverageItemLevel()
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 15)
	GameTooltip:ClearLines()
	GameTooltip:AddDoubleLine(DURABILITY, format("%s: %d/%d", STAT_AVERAGE_ITEM_LEVEL, equipped, total), 0,.6,1, 0,.6,1)
	GameTooltip:AddLine(" ")

	local totalCost = 0
	for i = 1, 10 do
		if localSlots[i][3] ~= 1000 then
			local slot = localSlots[i][1]
			local cur = floor(localSlots[i][3]*100)
			local slotIcon = localSlots[i][4]
			GameTooltip:AddDoubleLine(slotIcon..localSlots[i][2], cur.."%", 1,1,1, getDurabilityColor(cur, 100))

			M.ScanTip:SetOwner(UIParent, "ANCHOR_NONE")
			totalCost = totalCost + select(3, M.ScanTip:SetInventoryItem("player", slot))
		end
	end

	if totalCost > 0 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(repairCostString, module:GetMoneyString(totalCost), .6,.8,1, 1,1,1)
	end

	GameTooltip:AddDoubleLine(" ", I.LineString)
	GameTooltip:AddDoubleLine(" ", U["Auto Repair"]..": "..repairlist[MaoRUIDB["RepairType"]].." ", 1,1,1, .6,.8,1)
	GameTooltip:Show()
end

info.onLeave = M.HideTooltip

-- Auto repair
local isShown, isBankEmpty, autoRepair, repairAllCost, canRepair

local function delayFunc()
	if isBankEmpty then
		autoRepair(true)
	else
		print(format(I.InfoColor.."%s|r%s", U["Guild repair"], module:GetMoneyString(repairAllCost, true)))
	end
end

function autoRepair(override)
	if isShown and not override then return end
	isShown = true
	isBankEmpty = false

	local myMoney = GetMoney()
	repairAllCost, canRepair = GetRepairAllCost()

	if canRepair and repairAllCost > 0 then
		if (not override) and MaoRUIDB["RepairType"] == 1 and IsInGuild() and CanGuildBankRepair() and GetGuildBankWithdrawMoney() >= repairAllCost then
			RepairAllItems(true)
		else
			if myMoney > repairAllCost then
				RepairAllItems()
				print(format(I.InfoColor.."%s|r%s", U["Repair cost"], module:GetMoneyString(repairAllCost, true)))
				return
			else
				print(I.InfoColor..U["Repair error"])
				return
			end
		end

		C_Timer_After(.5, delayFunc)
	end
end

local function checkBankFund(_, msgType)
	if msgType == LE_GAME_ERR_GUILD_NOT_ENOUGH_MONEY then
		isBankEmpty = true
	end
end

local function merchantClose()
	isShown = false
	M:UnregisterEvent("UI_ERROR_MESSAGE", checkBankFund)
	M:UnregisterEvent("MERCHANT_CLOSED", merchantClose)
end

local function merchantShow()
	if IsShiftKeyDown() or MaoRUIDB["RepairType"] == 0 or not CanMerchantRepair() then return end
	autoRepair()
	M:RegisterEvent("UI_ERROR_MESSAGE", checkBankFund)
	M:RegisterEvent("MERCHANT_CLOSED", merchantClose)
end
M:RegisterEvent("MERCHANT_SHOW", merchantShow)