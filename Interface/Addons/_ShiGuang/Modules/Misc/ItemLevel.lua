local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")
local TT = M:GetModule("Tooltip")

local pairs, select, next, type, unpack = pairs, select, next, type, unpack
local UnitGUID, GetItemInfo, GetSpellInfo = UnitGUID, GetItemInfo, GetSpellInfo
local GetContainerItemLink, GetInventoryItemLink = GetContainerItemLink, GetInventoryItemLink
local EquipmentManager_UnpackLocation, EquipmentManager_GetItemInfoByLocation = EquipmentManager_UnpackLocation, EquipmentManager_GetItemInfoByLocation
local C_AzeriteEmpoweredItem_IsPowerSelected = C_AzeriteEmpoweredItem.IsPowerSelected
local GetTradePlayerItemLink, GetTradeTargetItemLink = GetTradePlayerItemLink, GetTradeTargetItemLink

local inspectSlots = {
	"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand", "SecondaryHand",
}
function MISC:GetSlotAnchor(index)
	if not index then return end
	if index <= 5 or index == 9 or index == 15 then
		return "BOTTOMLEFT", 46, 21
	elseif index == 16 then
		return "BOTTOMRIGHT", -46, 3
	elseif index == 17 then
		return "BOTTOMLEFT", 46, 3
	else
		return "BOTTOMRIGHT", -46, 21
	end
end

function MISC:CreateItemTexture(slot, relF, x, y)
	local icon = slot:CreateTexture()
	icon:SetPoint(relF, x, y)
	icon:SetSize(16, 16)
	icon:SetTexCoord(unpack(I.TexCoord))
	icon.bg = M.ReskinIcon(icon)
	icon.bg:SetFrameLevel(3)
	icon.bg:Hide()

	return icon
end

function MISC:CreateItemString(frame, strType)
	if frame.fontCreated then return end

	for index, slot in pairs(inspectSlots) do
		if index ~= 4 then
			local slotFrame = _G[strType..slot.."Slot"]
			local relF, x, y = MISC:GetSlotAnchor(index)
			slotFrame.iLvlText = M.CreateFS(slotFrame, I.Font[2]+3)
			slotFrame.iLvlText:ClearAllPoints()
			slotFrame.iLvlText:SetPoint(relF, slotFrame, x, y)
			slotFrame.enchantText = M.CreateFS(slotFrame, I.Font[2]-3)
			slotFrame.enchantText:ClearAllPoints()
			slotFrame.enchantText:SetPoint(relF, slotFrame, x-1, y-12)
			slotFrame.enchantText:SetTextColor(0, 1, 0)
			for i = 1, 10 do
				local offset = (i-1)*18 + 5
				local iconX = x > 0 and x+offset or x-offset
				local iconY = index > 15 and 20 or 2
				if index == 10 or index == 11 or index == 12 then
				slotFrame["textureIcon"..i] = MISC:CreateItemTexture(slotFrame, relF, x-39, y)
				else
				slotFrame["textureIcon"..i] = MISC:CreateItemTexture(slotFrame, relF, iconX, iconY)
				end
			end
		end
	end

	frame.fontCreated = true
end

local azeriteSlots = {
	[1] = true,
	[3] = true,
	[5] = true,
}

local locationCache = {}
local function GetSlotItemLocation(id)
	if not azeriteSlots[id] then return end

	local itemLocation = locationCache[id]
	if not itemLocation then
		itemLocation = ItemLocation:CreateFromEquipmentSlot(id)
		locationCache[id] = itemLocation
	end
	return itemLocation
end

function MISC:ItemLevel_UpdateTraits(button, id, link)
	if not R.db["Misc"]["AzeriteTraits"] then return end

	local empoweredItemLocation = GetSlotItemLocation(id)
	if not empoweredItemLocation then return end

	local allTierInfo = TT:Azerite_UpdateTier(link)
	if not allTierInfo then return end

	for i = 1, 2 do
		local powerIDs = allTierInfo[i] and allTierInfo[i].azeritePowerIDs
		if not powerIDs or powerIDs[1] == 13 then break end

		for _, powerID in pairs(powerIDs) do
			local selected = C_AzeriteEmpoweredItem_IsPowerSelected(empoweredItemLocation, powerID)
			if selected then
				local spellID = TT:Azerite_PowerToSpell(powerID)
				local name, _, icon = GetSpellInfo(spellID)
				local texture = button["textureIcon"..i]
				if name and texture then
					texture:SetTexture(icon)
					texture.bg:Show()
				end
			end
		end
	end
end

function MISC:ItemLevel_UpdateInfo(index, slotFrame, info, quality)
	local infoType = type(info)
	local level
	if infoType == "table" then
		level = info.iLvl
	else
		level = info
	end

	if level and level > 1 and quality and quality > 1 then
		local color = I.QualityColors[quality]
		slotFrame.iLvlText:SetText(level)
		slotFrame.iLvlText:SetTextColor(1, 0.8, 0)  --color.r, color.g, color.b
	end

	if infoType == "table" then
		local enchant = info.enchantText
		if enchant then
			slotFrame.enchantText:SetText(enchant)
		else
			if index == 5 or index == 8 or index == 9 or index == 11 or index == 12 or index == 15 or index == 16 or index == 17 then  -- or index == 10
				slotFrame.enchantText:SetText("|cFFFF0000FM|r")
			end
		end

		local gemStep, essenceStep = 1, 1
		for i = 1, 10 do
			local texture = slotFrame["textureIcon"..i]
			local bg = texture.bg
			local gem = info.gems and info.gems[gemStep]
			local essence = not gem and (info.essences and info.essences[essenceStep])
			if gem then
				texture:SetTexture(gem)
				bg:SetBackdropBorderColor(0, 0, 0)
				bg:Show()

				gemStep = gemStep + 1
			elseif essence and next(essence) then
				local r = essence[4]
				local g = essence[5]
				local b = essence[6]
				if r and g and b then
					bg:SetBackdropBorderColor(r, g, b)
				else
					bg:SetBackdropBorderColor(0, 0, 0)
				end

				local selected = essence[1]
				texture:SetTexture(selected)
				bg:Show()

				essenceStep = essenceStep + 1
			end
		end
	end
end

function MISC:ItemLevel_RefreshInfo(link, unit, index, slotFrame)
	C_Timer.After(.1, function()
		local quality = select(3, GetItemInfo(link))
		local info = M.GetItemLevel(link, unit, index, R.db["Misc"]["GemNEnchant"])
		if info == "tooSoon" then return end
		MISC:ItemLevel_UpdateInfo(index, slotFrame, info, quality)
	end)
end

function MISC:ItemLevel_SetupLevel(frame, strType, unit)
	if not UnitExists(unit) then return end

	MISC:CreateItemString(frame, strType)

	for index, slot in pairs(inspectSlots) do
		if index ~= 4 then
			local slotFrame = _G[strType..slot.."Slot"]
			slotFrame.iLvlText:SetText("")
			slotFrame.enchantText:SetText("")
			for i = 1, 10 do
				local texture = slotFrame["textureIcon"..i]
				texture:SetTexture(nil)
				texture.bg:Hide()
			end

			local link = GetInventoryItemLink(unit, index)
			if link then
				local quality = select(3, GetItemInfo(link))
				local info = M.GetItemLevel(link, unit, index, R.db["Misc"]["GemNEnchant"])
				if info == "tooSoon" then
					MISC:ItemLevel_RefreshInfo(link, unit, index, slotFrame)
				else
					MISC:ItemLevel_UpdateInfo(index, slotFrame, info, quality)
				end

				if strType == "Character" then
					MISC:ItemLevel_UpdateTraits(slotFrame, index, link)
				end
			end
		end
	end
end

function MISC:ItemLevel_UpdatePlayer()
	MISC:ItemLevel_SetupLevel(CharacterFrame, "Character", "player")
end

function MISC:ItemLevel_UpdateInspect(...)
	local guid = ...
	if InspectFrame and InspectFrame.unit and UnitGUID(InspectFrame.unit) == guid then
		MISC:ItemLevel_SetupLevel(InspectFrame, "Inspect", InspectFrame.unit)
	end
end

function MISC:ItemLevel_FlyoutUpdate(bag, slot, quality)
	if not self.iLvl then
		self.iLvl = M.CreateFS(self, I.Font[2]+1, "", false, "BOTTOMLEFT", 1, 1)
	end

	if quality and quality <= 1 then return end

	local link, level
	if bag then
		link = GetContainerItemLink(bag, slot)
		level = M.GetItemLevel(link, bag, slot)
	else
		link = GetInventoryItemLink("player", slot)
		level = M.GetItemLevel(link, "player", slot)
	end

	local color = I.QualityColors[quality or 0]
	self.iLvl:SetText(level)
	self.iLvl:SetTextColor(1, 0.8, 0)  --color.r, color.g, color.b
end

function MISC:ItemLevel_FlyoutSetup()
	if self.iLvl then self.iLvl:SetText("") end

	local location = self.location
	if not location then return end

	if tonumber(location) then
		if location >= EQUIPMENTFLYOUT_FIRST_SPECIAL_LOCATION then return end

		local _, _, bags, voidStorage, slot, bag = EquipmentManager_UnpackLocation(location)
		if voidStorage then return end
		local quality = select(13, EquipmentManager_GetItemInfoByLocation(location))
		if bags then
			MISC.ItemLevel_FlyoutUpdate(self, bag, slot, quality)
		else
			MISC.ItemLevel_FlyoutUpdate(self, nil, slot, quality)
		end
	else
		local itemLocation = self:GetItemLocation()
		local quality = itemLocation and C_Item.GetItemQuality(itemLocation)
		if itemLocation:IsBagAndSlot() then
			local bag, slot = itemLocation:GetBagAndSlot()
			MISC.ItemLevel_FlyoutUpdate(self, bag, slot, quality)
		elseif itemLocation:IsEquipmentSlot() then
			local slot = itemLocation:GetEquipmentSlot()
			MISC.ItemLevel_FlyoutUpdate(self, nil, slot, quality)
		end
	end
end

function MISC:ItemLevel_ScrappingUpdate()
	if not self.iLvl then
		self.iLvl = M.CreateFS(self, I.Font[2]+1, "", false, "BOTTOMLEFT", 1, 1)
	end
	if not self.itemLink then self.iLvl:SetText("") return end

	local quality = 1
	if self.itemLocation and not self.item:IsItemEmpty() and self.item:GetItemName() then
		quality = self.item:GetItemQuality()
	end
	local level = M.GetItemLevel(self.itemLink)
	local color = I.QualityColors[quality]
	self.iLvl:SetText(level)
	self.iLvl:SetTextColor(color.r, color.g, color.b)
end

function MISC.ItemLevel_ScrappingShow(event, addon)
	if addon == "Blizzard_ScrappingMachineUI" then
		for button in pairs(ScrappingMachineFrame.ItemSlots.scrapButtons.activeObjects) do
			hooksecurefunc(button, "RefreshIcon", MISC.ItemLevel_ScrappingUpdate)
		end

		M:UnregisterEvent(event, MISC.ItemLevel_ScrappingShow)
	end
end

function MISC:ItemLevel_UpdateMerchant(link)
	if not self.iLvl then
		self.iLvl = M.CreateFS(_G[self:GetName().."ItemButton"], I.Font[2]+1, "", false, "BOTTOMLEFT", 1, 1)
	end
	local quality = link and select(3, GetItemInfo(link)) or nil
	if quality and quality > 1 then
		local level = M.GetItemLevel(link)
		local color = I.QualityColors[quality]
		self.iLvl:SetText(level)
		self.iLvl:SetTextColor(color.r, color.g, color.b)
	else
		self.iLvl:SetText("")
	end
end

function MISC.ItemLevel_UpdateTradePlayer(index)
	local button = _G["TradePlayerItem"..index]
	local link = GetTradePlayerItemLink(index)
	MISC.ItemLevel_UpdateMerchant(button, link)
end

function MISC.ItemLevel_UpdateTradeTarget(index)
	local button = _G["TradeRecipientItem"..index]
	local link = GetTradeTargetItemLink(index)
	MISC.ItemLevel_UpdateMerchant(button, link)
end

function MISC:ShowItemLevel()
	if not R.db["Misc"]["ItemLevel"] then return end

	-- iLvl on CharacterFrame
	CharacterFrame:HookScript("OnShow", MISC.ItemLevel_UpdatePlayer)
	M:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", MISC.ItemLevel_UpdatePlayer)

	-- iLvl on InspectFrame
	M:RegisterEvent("INSPECT_READY", MISC.ItemLevel_UpdateInspect)

	-- iLvl on FlyoutButtons
	hooksecurefunc("EquipmentFlyout_UpdateItems", function()
		for _, button in pairs(EquipmentFlyoutFrame.buttons) do
			if button:IsShown() then
				MISC.ItemLevel_FlyoutSetup(button)
			end
		end
	end)

	-- iLvl on ScrappingMachineFrame
	M:RegisterEvent("ADDON_LOADED", MISC.ItemLevel_ScrappingShow)

	-- iLvl on MerchantFrame
	hooksecurefunc("MerchantFrameItem_UpdateQuality", MISC.ItemLevel_UpdateMerchant)

	-- iLvl on TradeFrame
	hooksecurefunc("TradeFrame_UpdatePlayerItem", MISC.ItemLevel_UpdateTradePlayer)
	hooksecurefunc("TradeFrame_UpdateTargetItem", MISC.ItemLevel_UpdateTradeTarget)
end
MISC:RegisterMisc("GearInfo", MISC.ShowItemLevel)