--## SavedVariables: CaerdonWardrobeConfig  ## Version: v2.4.0

local isBagUpdate = false
local ignoreDefaultBags = false
CaerdonWardrobe = {}
CaerdonWardrobeNS = {}

if GetLocale() == "zhCN" then
  CaerdonWardrobeBoA = "|cffe6cc80战网|r";
  CaerdonWardrobeBoE = "|cff1eff00装绑|r";
elseif GetLocale() == "zhTW" then
  CaerdonWardrobeBoA = "|cffe6cc80战网|r";
  CaerdonWardrobeBoE = "|cff1eff00装绑|r";
else
  CaerdonWardrobeBoA = "|cffe6cc80BoA|r";
  CaerdonWardrobeBoE = "|cff1eff00BoE|r";
end

local bindTextTable = {
	[ITEM_ACCOUNTBOUND]        = CaerdonWardrobeBoA,
	[ITEM_BNETACCOUNTBOUND]    = CaerdonWardrobeBoA,
	[ITEM_BIND_TO_ACCOUNT]     = CaerdonWardrobeBoA,
	[ITEM_BIND_TO_BNETACCOUNT] = CaerdonWardrobeBoA,
	[ITEM_BIND_ON_EQUIP]       = CaerdonWardrobeBoE,
	[ITEM_BIND_ON_USE]         = CaerdonWardrobeBoE,
	[ITEM_SOULBOUND]           = "|cFF00DDFF    _|r",  -- 拾取后绑定
	[ITEM_BIND_ON_PICKUP]      = "|cFF00DDFF    _|r",
}

local InventorySlots = {
    ['INVTYPE_HEAD'] = INVSLOT_HEAD,
    ['INVTYPE_SHOULDER'] = INVSLOT_SHOULDER,
    ['INVTYPE_BODY'] = INVSLOT_BODY,
    ['INVTYPE_CHEST'] = INVSLOT_CHEST,
    ['INVTYPE_ROBE'] = INVSLOT_CHEST,
    ['INVTYPE_WAIST'] = INVSLOT_WAIST,
    ['INVTYPE_LEGS'] = INVSLOT_LEGS,
    ['INVTYPE_FEET'] = INVSLOT_FEET,
    ['INVTYPE_WRIST'] = INVSLOT_WRIST,
    ['INVTYPE_HAND'] = INVSLOT_HAND,
    ['INVTYPE_CLOAK'] = INVSLOT_BACK,
    ['INVTYPE_WEAPON'] = INVSLOT_MAINHAND,
    ['INVTYPE_SHIELD'] = INVSLOT_OFFHAND,
    ['INVTYPE_2HWEAPON'] = INVSLOT_MAINHAND,
    ['INVTYPE_WEAPONMAINHAND'] = INVSLOT_MAINHAND,
    ['INVTYPE_RANGED'] = INVSLOT_MAINHAND,
    ['INVTYPE_RANGEDRIGHT'] = INVSLOT_MAINHAND,
    ['INVTYPE_WEAPONOFFHAND'] = INVSLOT_OFFHAND,
    ['INVTYPE_HOLDABLE'] = INVSLOT_OFFHAND,
    ['INVTYPE_TABARD'] = INVSLOT_TABARD
}

local mainTip = CreateFrame( "GameTooltip", "CaerdonWardrobeGameTooltip", nil, "GameTooltipTemplate" )
mainTip.ItemTooltip = CreateFrame("FRAME", "CaerdonWardrobeGameTooltipChild", mainTip, "InternalEmbeddedItemTooltipTemplate")
mainTip.ItemTooltip.Tooltip.shoppingTooltips = { ShoppingTooltip1, ShoppingTooltip2 }

local cachedBinding = {}
local model = CreateFrame('DressUpModel')

local function GetItemID(itemLink)
	return tonumber(itemLink:match("item:(%d+)") or itemLink:match("battlepet:(%d+)"))
end

local function IsPetLink(itemLink)
	local isPet = false
	local itemName, itemLinkInfo, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, 
isCraftingReagent = GetItemInfo(itemLink)

	local itemID = GetItemID(itemLink)
	if itemID == 82800 then
		isPet = true -- probably at the guild bank
	elseif itemClassID == LE_ITEM_CLASS_MISCELLANEOUS and itemSubClassID == LE_ITEM_MISCELLANEOUS_COMPANION_PET then
		isPet = true
	elseif not itemClassID then
		local link, name = string.match(itemLink, "|H(.-)|h(.-)|h")
		isPet = strsub(link, 1, 9) == "battlepet"
	end

	return isPet
end

local function IsMountLink(itemLink)
	local isMount = false
	local itemName, itemLinkInfo, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, 
isCraftingReagent = GetItemInfo(itemLink)
	if itemClassID == LE_ITEM_CLASS_MISCELLANEOUS and itemSubClassID == LE_ITEM_MISCELLANEOUS_MOUNT then
		isMount = true
	end

	return isMount
end

local function IsToyLink(itemLink)
	local isToy = false
	local itemID = GetItemID(itemLink)
	if itemID then
		local itemIDInfo, toyName, icon = C_ToyBox.GetToyInfo(itemID)
	  	if (itemIDInfo and toyName) then
			isToy = true
		end
	end

	return isToy
end

local function IsRecipeLink(itemLink)
	local isRecipe = false
	local itemName, itemLinkInfo, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, 
isCraftingReagent = GetItemInfo(itemLink)

	if itemClassID == LE_ITEM_CLASS_RECIPE then
		isRecipe = true
	end

	return isRecipe
end

local function IsCollectibleLink(itemLink)
	return IsPetLink(itemLink) or IsMountLink(itemLink) or IsToyLink(itemLink) or IsRecipeLink(itemLink)
end

local cachedIsDressable = {}
local function IsDressableItemCheck(itemID, itemLink)
	local isDressable = true
	local shouldRetry = false
	local slot

	local dressableCache = cachedIsDressable[itemLink]
	if dressableCache then
		isDressable = dressableCache.isDressable
		slot = dressableCache.slot
	else
	    local _, _, _, slotName = GetItemInfoInstant(itemID)
	    if slotName and slotName ~= "" then -- make sure it's a supported slot
		    slot = InventorySlots[slotName]
		    if not slot then
				isDressable = false
		    elseif not IsDressableItem(itemLink) then
		    	-- IsDressableItem can return false instead of true for
		    	-- an item that is actually dressable (seems to happen
		    	-- most often during item caching).  Adding some
		    	-- retry tags to the cache if IsDressableItem says its
		    	-- not but transmog says it can be a source
				local canBeChanged, noChangeReason, canBeSource, noSourceReason = C_Transmog.GetItemInfo(itemID)
				isDressable = false
				if canBeSource then
					shouldRetry = true
				end
			end
		else
			isDressable = false
		end

		if not shouldRetry then
			cachedIsDressable[itemLink] = { isDressable = isDressable, slot = slot }
		end
	end
    return isDressable, shouldRetry, slot
end

local cachedItemSources = {}
local function GetItemSource(itemID, itemLink)
	local itemSources = cachedItemSources[itemLink]
	local shouldRetry = false
	local isDressable = false
	if itemSources == "NONE" then
		itemSources = nil
	elseif not itemSources then
		isDressable, shouldRetry, slot = IsDressableItemCheck(itemID, itemLink)
		if not shouldRetry then
			if not isDressable then
		    	cachedItemSources[itemLink] = "NONE"
			else
				-- Looks like I can use this now.  Keeping the old code around for a bit just in case.
				-- Actually, still seeing problems with this...try it first but fallback to model
				local appearanceID, sourceID = C_TransmogCollection.GetItemInfo(itemLink)
				if sourceID then
					itemSources = sourceID
				else
				    model:SetUnit('player')
				    model:Undress()
				    model:TryOn(itemLink, slot)
				    itemSources = model:GetSlotTransmogSources(slot)
				end

			    if itemSources then
					cachedItemSources[itemLink] = itemSources
				else
					cachedItemSources[itemLink] = "NONE"
				end
			end
		end
	end
    return itemSources, shouldRetry
end

local function GetItemAppearance(itemID, itemLink)
	local categoryID, appearanceID, canEnchant, texture, isCollected, sourceItemLink
	local sourceID, shouldRetry = GetItemSource(itemID, itemLink)

    if sourceID and sourceID ~= NO_TRANSMOG_SOURCE_ID then
        categoryID, appearanceID, canEnchant, texture, isCollected, sourceItemLink = C_TransmogCollection.GetAppearanceSourceInfo(sourceID)
        if sourceItemLink then
			local _, _, quality = GetItemInfo(sourceItemLink)
			-- Skip artifact weapons and common for now
			if quality == LE_ITEM_QUALITY_COMMON then
	 			appearanceID = nil
	 			isCollected = false
	 			sourceID = NO_TRANSMOG_SOURCE_ID
			end
		end
    end

    return appearanceID, isCollected, sourceID, shouldRetry
end

local function PlayerHasAppearance(appearanceID)
	local hasAppearance = false

    local sources = C_TransmogCollection.GetAllAppearanceSources(appearanceID)
    local matchedSource
    if sources then
		for i, sourceID in pairs(sources) do
			if sourceID and sourceID ~= NO_TRANSMOG_SOURCE_ID then
				local categoryID, appearanceID, canEnchant, texture, isCollected, sourceItemLink = C_TransmogCollection.GetAppearanceSourceInfo(sourceID)

				if isCollected then
					matchedSource = source
					hasAppearance = true
					break
				end
			end
        end
    end

    return hasAppearance, matchedSource
end
 
local function PlayerCanCollectAppearance(appearanceID, itemID, itemLink)
	local _, _, quality, _, reqLevel, itemClass, itemSubClass, _, equipSlot, _, _, itemClassID, itemSubClassID = GetItemInfo(itemID)
	local playerLevel = UnitLevel("player")
	local canCollect = false
	local isInfoReady
	local matchedSource
	local shouldRetry

	local playerClass = select(2, UnitClass("player"))

	local classArmor;
	if playerClass == "MAGE" or 
		playerClass == "PRIEST" or 
		playerClass == "WARLOCK" then
		classArmor = LE_ITEM_ARMOR_CLOTH
	elseif playerClass == "DEMONHUNTER" or
		playerClass == "DRUID" or 
		playerClass == "MONK" or
		playerClass == "ROGUE" then
		classArmor = LE_ITEM_ARMOR_LEATHER
	elseif playerClass == "DEATHKNIGHT" or
		playerClass == "PALADIN" or
		playerClass == "WARRIOR" then
		classArmor = LE_ITEM_ARMOR_PLATE
	elseif playerClass == "HUNTER" or 
		playerClass == "SHAMAN" then
		classArmor = LE_ITEM_ARMOR_MAIL
	end


	if playerLevel >= reqLevel then
	    local sources = C_TransmogCollection.GetAppearanceSources(appearanceID)
	    if sources then
	        for i, source in pairs(sources) do
				isInfoReady, canCollect = C_TransmogCollection.PlayerCanCollectSource(source.sourceID)
	            if isInfoReady then
	            	if canCollect then
		            	matchedSource = source
		            end
	                break
	            else
	            	shouldRetry = true
	            end
	        end
		else
		end
	end
	if equipSlot ~= "INVTYPE_CLOAK"
		and itemClassID == LE_ITEM_CLASS_ARMOR and 
		(	itemSubClassID == LE_ITEM_ARMOR_CLOTH or 
			itemSubClassID == LE_ITEM_ARMOR_LEATHER or 
			itemSubClassID == LE_ITEM_ARMOR_MAIL or
			itemSubClassID == LE_ITEM_ARMOR_PLATE)
		and itemSubClassID ~= classArmor then 
			canCollect = false
	end

    return canCollect, matchedSource, shouldRetry
end

local function GetItemInfoLocal(itemID, bag, slot)
	local name = GetItemInfo(itemID)
	if name then
		if bag == "MerchantFrame" then
			if MerchantFrame.selectedTab == 1 then
				name = GetMerchantItemInfo(slot)
			else
				name = GetBuybackItemInfo(slot)
			end
		end
	end

	return name
end

local function GetItemLinkLocal(bag, slot)
	if bag == "MerchantFrame" then
		if MerchantFrame.selectedTab == 1 then
			return GetMerchantItemLink(slot)
		else
			return GetBuybackItemLink(slot)
		end
	elseif bag == "BankFrame" then
		return GetInventoryItemLink("player", slot)
	elseif bag == "GuildBankFrame" then
		return GetGuildBankItemLink(slot.tab, slot.index)
	elseif bag == "EncounterJournal" then
		-- local itemID, encounterID, name, icon, slotName, armorType, itemLink = EJ_GetLootInfoByIndex(slot)
		return slot.link
	elseif bag == "LootFrame" or bag == "GroupLootFrame" then
		return slot.link
	elseif bag == "QuestButton" then
		if slot.itemLink then
			return slot.itemLink
		else
			local itemID = slot.itemID
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
			itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, 
			isCraftingReagent = GetItemInfo(itemID)
			return itemLink
		end
	else
	    if bag then
	      return GetContainerItemLink(bag, slot)
	    end
	end
end

local function GetItemKey(bag, slot, itemLink)
	local itemKey
	if bag == "MerchantFrame" then
		itemKey = itemLink
	elseif bag == "GuildBankFrame" then
		itemKey = itemLink .. slot.tab .. slot.index
	elseif bag == "EncounterJournal" then
		itemKey = itemLink .. bag .. slot.index
	elseif bag == "QuestButton" then
		itemKey = itemLink .. bag
	elseif bag == "LootFrame" or bag == "GroupLootFrame" then
		itemKey = itemLink
	else
		itemKey = itemLink .. bag .. slot
	end

	return itemKey
end

local equipLocations = {}

local function GetBindingStatus(bag, slot, itemID, itemLink)
	local scanTip = mainTip
	local itemKey = GetItemKey(bag, slot, itemLink)

	local binding = cachedBinding[itemKey]
	local bindingText, needsItem, hasUse

    local isInEquipmentSet = false
    local isBindOnPickup = false
	local isCompletionistItem = false
	local matchesLootSpec = true
	local unusableItem = false
    local isDressable, shouldRetry

    local isCollectionItem = IsCollectibleLink(itemLink)

    local shouldCheckEquipmentSet = false

   	if isCollectionItem then
		isDressable = false
		shouldRetry = false
	else
		isDressable, shouldRetry = IsDressableItemCheck(itemID, itemLink)
	end

	local playerSpec = GetSpecialization();
	local playerClassID = select(3, UnitClass("player")) 
	local playerSpecID = -1
	if (playerSpec) then
		playerSpecID = GetSpecializationInfo(playerSpec, nil, nil, nil, UnitSex("player"));
	end
	local playerLootSpecID = GetLootSpecialization()
	if playerLootSpecID == 0 then
		playerLootSpecID = playerSpecID
	end

	if binding then
		bindingText = binding.bindingText
		needsItem = binding.needsItem
		hasUse = binding.hasUse
		isInEquipmentSet = binding.isInEquipmentSet
		isBindOnPickup = binding.isBindOnPickup
		isCompletionistItem = binding.isCompletionistItem
		unusableItem = binding.unusableItem
		matchesLootSpec = binding.matchesLootSpec
	elseif not shouldRetry then
		needsItem = true
		scanTip:SetOwner(WorldFrame, "ANCHOR_NONE")
		if bag == "MerchantFrame" then
			if MerchantFrame.selectedTab == 1 then
				scanTip:SetMerchantItem(slot)
			else
				scanTip:SetBuybackItem(slot)
			end
		elseif bag == BANK_CONTAINER then
			scanTip:SetInventoryItem("player", BankButtonIDToInvSlotID(slot))
		   	if not isCollectionItem then
				shouldCheckEquipmentSet = true
			end
		elseif bag == "GuildBankFrame" then
			scanTip:SetGuildBankItem(slot.tab, slot.index)
		elseif bag == "LootFrame" then
			scanTip:SetLootItem(slot.index)
		elseif bag == "GroupLootFrame" then
			scanTip:SetLootRollItem(slot.index)
		elseif bag == "EncounterJournal" then
			local classID, specID = EJ_GetLootFilter();
			if (specID == 0) then
				if (playerSpec and classID == playerClassID) then
					specID = playerSpecID
				else
					specID = -1;
				end
			end
			scanTip:SetHyperlink(itemLink, classID, specID)

			local specTable = GetItemSpecInfo(itemLink)
			if specTable then
				for specIndex = 1, #specTable do
					matchesLootSpec = false

					local validSpecID = GetSpecializationInfo(specIndex, nil, nil, nil, UnitSex("player"));
					if validSpecID == playerLootSpecID then
						matchesLootSpec = true
						break
					end
				end
			end
		elseif bag == "QuestButton" then
			if slot.questItem ~= nil and slot.questItem.type ~= nil then
				if QuestInfoFrame.questLog then
					scanTip:SetQuestLogItem(slot.questItem.type, slot.index, slot.questID)
				else
					scanTip:SetQuestItem(slot.questItem.type, slot.index, slot.questID)
				end
			else
				GameTooltip_AddQuestRewardsToTooltip(scanTip, slot.questID)
				scanTip = scanTip.ItemTooltip.Tooltip
			end
		else
			scanTip:SetBagItem(bag, slot)
		   	if not isCollectionItem then
				shouldCheckEquipmentSet = true
			end
		end

		if shouldCheckEquipmentSet then
	 		local _, _, _, _, reqLevel, class, subclass, _, equipSlot = GetItemInfo(itemID)
		   -- Use equipment set for binding text if it's assigned to one
			if equipSlot ~= "" and C_EquipmentSet.CanUseEquipmentSets() then

				-- Flag to ensure flagging multiple set membership
				local isBindingTextDone = false

				for setIndex=1, C_EquipmentSet.GetNumEquipmentSets() do
			        local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs()
			        local equipmentSetID = equipmentSetIDs[setIndex]
							name, icon, setID, isEquipped, numItems, numEquipped, numInventory, numMissing, numIgnored = C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID)

			        local equipLocations = C_EquipmentSet.GetItemLocations(equipmentSetID)
			        if equipLocations then
						for locationIndex=INVSLOT_FIRST_EQUIPPED , INVSLOT_LAST_EQUIPPED do
							local location = equipLocations[locationIndex]
							if location ~= nil then
							    local isPlayer, isBank, isBags, isVoidStorage, equipSlot, equipBag, equipTab, equipVoidSlot = EquipmentManager_UnpackLocation(location)
							    equipSlot = tonumber(equipSlot)
							    equipBag = tonumber(equipBag)

							    if isVoidStorage then
							    	-- Do nothing for now
							    elseif isBank and not isBags then -- player or bank
									if bag == BANK_CONTAINER and BankButtonIDToInvSlotID(slot) == equipSlot then
							    		needsItem = false
										if bindingText then
											bindingText = "*" .. bindingText
											isBindingTextDone = true

											break
										else
											bindingText = name
											isInEquipmentSet = true
										end
							    	end
							    else
								    if equipSlot == slot and equipBag == bag then
										needsItem = false
										if bindingText then
											bindingText = "*" .. bindingText
											isBindingTextDone = true
											break
										else
											bindingText = name
											isInEquipmentSet = true
										end
									end
								end
							end
						end

						if isBindingTextDone then
							break
						end
					end
				end
			end
		end

		local canBeChanged, noChangeReason, canBeSource, noSourceReason = C_Transmog.GetItemInfo(itemID)
		if not isCollectionItem and canBeSource then
			local appearanceID, isCollected, sourceID
			appearanceID, isCollected, sourceID, shouldRetry = GetItemAppearance(itemID, itemLink)

			if sourceID and sourceID ~= NO_TRANSMOG_SOURCE_ID then 
				local hasTransmog = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID)
				if hasTransmog then
					needsItem = false
				else
					if CaerdonWardrobeConfig.Icon.ShowLearnable.SameLookDifferentItem then
						isCompletionistItem = true
					end
				end
			end
		else
	    	needsItem = false
	    end

		local numLines = scanTip:NumLines()
		local PET_KNOWN = strmatch(ITEM_PET_KNOWN, "[^%(]+")
		local needsCollectionItem = true

		if not isCollectionItem and not noSourceReason and numLines == 0 then
			shouldRetry = true
		end

		if not shouldRetry then
			for lineIndex = 1, numLines do
				local scanName = scanTip:GetName()
				local line = _G[scanName .. "TextLeft" .. lineIndex]
				local lineText = line:GetText()
				if lineText then
					-- TODO: Look at switching to GetItemSpell
					if strmatch(lineText, USE_COLON) or strmatch(lineText, ITEM_SPELL_TRIGGER_ONEQUIP) or strmatch(lineText, string.format(ITEM_SET_BONUS, "")) then -- it's a recipe or has a "use" effect or belongs to a set
						hasUse = true
						-- break
					end

					if not bindingText then
						bindingText = bindTextTable[lineText]
					end

					if lineText == RETRIEVING_ITEM_INFO then
						shouldRetry = true
						break
					elseif lineText == ITEM_BIND_ON_PICKUP or lineText == ITEM_SOULBOUND then
						isBindOnPickup = true
					elseif lineText == TRANSMOGRIFY_TOOLTIP_ITEM_UNKNOWN_APPEARANCE_KNOWN then
						if CaerdonWardrobeConfig.Icon.ShowLearnable.SameLookDifferentItem then
							isCompletionistItem = true
						else
							needsItem = false
						end
						break
					elseif lineText == TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN then
						if CaerdonWardrobeConfig.Icon.ShowLearnable.SameLookDifferentItem then
							isCompletionistItem = true
						end
					elseif lineText == ITEM_SPELL_KNOWN or strmatch(lineText, PET_KNOWN) then
						needsCollectionItem = false
					end

					-- TODO: Should possibly only look for "Classes:" but could have other reasons for not being usable
					local r, g, b = line:GetTextColor()
					hex = string.format("%02x%02x%02x", r*255, g*255, b*255)
					if hex == "fe1f1f" and (isBindOnPickup or IsRecipeLink(itemLink)) then
						-- Assume BoE recipes can't be learned to avoid erroneous stars in AH / vendor
						unusableItem = true
						if not bag == "EncounterJournal" then
							needsItem = false
							isCompletionistItem = false
						end
					end
				end
			end
		end

		if not shouldRetry then
			if isCollectionItem and not unusableItem then
				if numLines == 0 and IsPetLink(itemLink) then
					local petID = GetItemID(itemLink)
					if petID then
						if petID ~= 82800 then -- generic pet cage
							local numCollected = C_PetJournal.GetNumCollectedInfo(petID)
							if numCollected == nil then
								-- TODO: Not sure what else to do here
								needsItem = false
							elseif numCollected > 0 then				
								needsItem = false
							else
								needsItem = true
							end
						else
							-- TODO: Can we do something here?
							needsItem = false
						end
					end
				elseif needsCollectionItem then
					needsItem = true
				else
				end
			end

			-- cachedBinding[itemKey] = {bindingText = bindingText, needsItem = needsItem, hasUse = hasUse, isDressable = isDressable, isInEquipmentSet = isInEquipmentSet, isBindOnPickup = isBindOnPickup, isCompletionistItem = isCompletionistItem, unusableItem = unusableItem, matchesLootSpec = matchesLootSpec }
		end
	end

	ShoppingTooltip1:Hide()
	ShoppingTooltip2:Hide()
	scanTip:Hide()

	return bindingText, needsItem, hasUse, isDressable, isInEquipmentSet, isBindOnPickup, isCompletionistItem, shouldRetry, unusableItem, matchesLootSpec
end

local waitingOnItemData = {}

local function IsGearSetStatus(status)
	return status and status ~= CaerdonWardrobeBoA and status ~= CaerdonWardrobeBoE
end

local function SetIconPositionAndSize(icon, startingPoint, offset, size, iconOffset)
	icon:ClearAllPoints()

	local offsetSum = offset - iconOffset
	if startingPoint == "TOPRIGHT" then
		icon:SetPoint("TOPRIGHT", offsetSum, offsetSum)
	elseif startingPoint == "TOPLEFT" then
		icon:SetPoint("TOPLEFT", offsetSum * -1, offsetSum)
	elseif startingPoint == "BOTTOMRIGHT" then
		icon:SetPoint("BOTTOMRIGHT", offsetSum, offsetSum * -1)
	elseif startingPoint == "BOTTOMLEFT" then
		icon:SetPoint("BOTTOMLEFT", offsetSum * -1, offsetSum * -1)
	end

	icon:SetSize(size, size)
end

local function AddRotation(group, order, degrees, duration, smoothing, startDelay, endDelay)
	local anim = group:CreateAnimation("Rotation")
	group["anim" .. order] = anim
	anim:SetDegrees(degrees)
    anim:SetDuration(duration)
	anim:SetOrder(order)
	anim:SetSmoothing(smoothing)

	if startDelay then
		anim:SetStartDelay(startDelay)
	end

	if endDelay then
		anim:SetEndDelay(endDelay)
	end
end

local function IsBankOrBags(bag)
	local isBankOrBags = false

	if bag ~= "MerchantFrame" and 
	   bag ~= "GuildBankFrame" and
	   bag ~= "EncounterJournal" and
	   bag ~= "QuestButton" and
	   bag ~= "LootFrame" and
	   bag ~= "GroupLootFrame" then
		isBankOrBags = true
	end

	return isBankOrBags
end

local function ShouldHideBindingStatus(bag, bindingStatus)
	local shouldHide = false

	if not CaerdonWardrobeConfig.Binding.ShowStatus.BankAndBags and IsBankOrBags(bag) then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Binding.ShowStatus.GuildBank and bag == "GuildBankFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Binding.ShowStatus.Merchant and bag == "MerchantFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Binding.ShowBoA and bindingStatus == CaerdonWardrobeBoA then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Binding.ShowBoE and bindingStatus == CaerdonWardrobeBoE then
		shouldHide = true
	end

	return shouldHide
end

local function ShouldHideOwnIcon(bag)
	local shouldHide = false

	if not CaerdonWardrobeConfig.Icon.ShowLearnable.BankAndBags and IsBankOrBags(bag) then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowLearnable.GuildBank and bag == "GuildBankFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowLearnable.Merchant and bag == "MerchantFrame" then
		shouldHide = true
	end

	return shouldHide
end

local function ShouldHideOtherIcon(bag)
	local shouldHide = false

	if not CaerdonWardrobeConfig.Icon.ShowLearnableByOther.BankAndBags and IsBankOrBags(bag) then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowLearnableByOther.GuildBank and bag == "GuildBankFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowLearnableByOther.Merchant and bag == "MerchantFrame" then
		shouldHide = true
	end

	return shouldHide
end

local function ShouldHideSellableIcon(bag)
	local shouldHide = false

	if not CaerdonWardrobeConfig.Icon.ShowSellable.BankAndBags and IsBankOrBags(bag) then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowSellable.GuildBank and bag == "GuildBankFrame" then
		shouldHide = true
	end

	if bag == "MerchantFrame" then
		shouldHide = true
	end

	return shouldHide
end

local function SetItemButtonMogStatusFilter(originalButton, isFiltered)
	local button = originalButton.caerdonButton
	if button then
		local mogStatus = button.mogStatus
		if mogStatus then
			if isFiltered then
				mogStatus:SetAlpha(0.3)
			else
				mogStatus:SetAlpha(mogStatus.assignedAlpha)
			end
		end
	end
end

local function SetItemButtonMogStatus(originalButton, status, bindingStatus, options, bag, slot, itemID)
	local button = originalButton.caerdonButton
	if not button then
		button = CreateFrame("Frame", nil, originalButton)
		button:SetAllPoints()
		button.searchOverlay = originalButton.searchOverlay
		originalButton.caerdonButton = button
	end

	button:SetFrameLevel(originalButton:GetFrameLevel() + 100)

	local mogStatus = button.mogStatus
	local mogAnim = button.mogAnim
	local iconPosition, showSellables, isSellable
	local iconSize = 43
	local otherIcon = "Interface\\Store\\category-icon-placeholder"
	local otherIconSize = 43
	local otherIconOffset = 0
	local iconOffset = 0

	if options then 
		showSellables = options.showSellables
		isSellable = options.isSellable
		if options.iconSize then
			iconSize = options.iconSize
		end
		if options.iconOffset then
			iconOffset = options.iconOffset
			otherIconOffset = iconOffset
		end

		if options.otherIcon then
			otherIcon = options.otherIcon
		end

		if options.otherIconSize then
			otherIconSize = options.otherIconSize
		else
			otherIconSize = iconSize
		end

		if options.otherIconOffset then
			otherIconOffset = options.otherIconOffset
		end
	else
		options = {}
	end

	if options.overridePosition then -- for Encounter Journal so far
		iconPosition = options.overridePosition
	else
		iconPosition = CaerdonWardrobeConfig.Icon.Position
	end

	if not status then
		if mogAnim and mogAnim:IsPlaying() then
			mogAnim:Stop()
		end
		if mogStatus then
			mogStatus:SetTexture("")
		end

		-- Keep processing to handle gear set icon
		-- return
	end

	if not mogStatus then
		mogStatus = button:CreateTexture(nil, "OVERLAY", nil, 2)
		SetIconPositionAndSize(mogStatus, iconPosition, 15, iconSize, iconOffset)
		button.mogStatus = mogStatus
	end

	-- local mogFlash = button.mogFlash
	-- if not mogFlash then
	-- 	mogFlash = button:CreateTexture(nil, "OVERLAY")
	-- 	mogFlash:SetAlpha(0)
	-- 	mogFlash:SetBlendMode("ADD")
	-- 	mogFlash:SetAtlas("bags-glow-flash", true)
	-- 	mogFlash:SetPoint("CENTER")

	-- 	button.mogFlash = mogFlash
	-- end

	local showAnim = false
	if status == "waiting" then
		showAnim = true

		if not mogAnim or not button.isWaitingIcon then
			mogAnim = mogStatus:CreateAnimationGroup()

			AddRotation(mogAnim, 1, 360, 0.5, "IN_OUT")

		    mogAnim:SetLooping("REPEAT")
			button.mogAnim = mogAnim
			button.isWaitingIcon = true
		end
	else
		if status == "own" or status == "ownPlus" or status == "otherSpec" or status == "otherSpecPlus" or status == "refundable" or status == "openable" then
			showAnim = true

			if mogAnim and button.isWaitingIcon then
				if mogAnim:IsPlaying() then
					mogAnim:Finish()
				end

				mogAnim = nil
				button.mogAnim = nil
				button.isWaitingIcon = false
			end

			if not mogAnim then
				mogAnim = mogStatus:CreateAnimationGroup()

				AddRotation(mogAnim, 1, 110, 0.2, "OUT")
				AddRotation(mogAnim, 2, -155, 0.2, "OUT")
				AddRotation(mogAnim, 3, 60, 0.2, "OUT")
				AddRotation(mogAnim, 4, -15, 0.1, "OUT", 0, 2)

			    mogAnim:SetLooping("REPEAT")
				button.mogAnim = mogAnim
				button.isWaitingIcon = false
			end
		else
			showAnim = false
		end
	end

	-- 	if not mogAnim then
	-- 		mogAnim = button:CreateAnimationGroup()
	-- 		mogAnim:SetToFinalAlpha(true)
	-- 		mogAnim.alpha1 = mogAnim:CreateAnimation("Alpha")
	-- 		mogAnim.alpha1:SetChildKey("mogFlash")
	-- 		mogAnim.alpha1:SetSmoothing("OUT");
	-- 		mogAnim.alpha1:SetDuration(0.6)
	-- 		mogAnim.alpha1:SetOrder(1)
	-- 		mogAnim.alpha1:SetFromAlpha(1);
	-- 		mogAnim.alpha1:SetToAlpha(0);

	-- 		button.mogAnim = mogAnim
	-- 	end

	local alpha = 1
	mogStatus:SetVertexColor(1, 1, 1)
	if status == "refundable" and not ShouldHideSellableIcon(bag) then
		SetIconPositionAndSize(mogStatus, iconPosition, 3, 15, iconOffset)
		alpha = 0.9
		mogStatus:SetTexture("Interface\\COMMON\\mini-hourglass")
	elseif status == "openable" and not ShouldHideSellableIcon(bag) then -- TODO: Add separate option for showing
			SetIconPositionAndSize(mogStatus, iconPosition, 15, iconSize, iconOffset)
			mogStatus:SetTexture("Interface\\Store\\category-icon-free")
	elseif status == "own" or status == "ownPlus" then
		if not ShouldHideOwnIcon(bag) then
			SetIconPositionAndSize(mogStatus, iconPosition, 15, iconSize, iconOffset)
			mogStatus:SetTexture("Interface\\Store\\category-icon-featured")
			if status == "ownPlus" then
				mogStatus:SetVertexColor(0.4, 1, 0)
			end
		else
			mogStatus:SetTexture("")
		end
	elseif status == "other" or status == "otherPlus" then
		if not ShouldHideOtherIcon(bag) then
			SetIconPositionAndSize(mogStatus, iconPosition, 15, otherIconSize, otherIconOffset)
			mogStatus:SetTexture(otherIcon)
			if status == "otherPlus" then
				mogStatus:SetVertexColor(0.4, 1, 0)
			end
		else
			mogStatus:SetTexture("")
		end
	elseif status == "otherSpec" or status == "otherSpecPlus" then
		if not ShouldHideOtherIcon(bag) then
			SetIconPositionAndSize(mogStatus, iconPosition, 15, otherIconSize, otherIconOffset)
			mogStatus:SetTexture("Interface\\COMMON\\icon-noloot")
			if status == "otherSpecPlus" then
				mogStatus:SetVertexColor(0.4, 1, 0)
			end
		else
			mogStatus:SetTexture("")
		end
	elseif status == "collected" then
		if not IsGearSetStatus(bindingStatus) and showSellables and isSellable and not ShouldHideSellableIcon(bag) then -- it's known and can be sold
			SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
			alpha = 0.9
			mogStatus:SetTexture("Interface\\Store\\category-icon-bag")
		elseif IsGearSetStatus(bindingStatus) and CaerdonWardrobeConfig.Binding.ShowGearSetsAsIcon then
			SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
			mogStatus:SetTexture("Interface\\Store\\category-icon-clothes")
		else
			mogStatus:SetTexture("")
		end
	elseif status == "waiting" then
		alpha = 0.5
		SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
		mogStatus:SetTexture("Interface\\Common\\StreamCircle")
	elseif IsGearSetStatus(bindingStatus) and CaerdonWardrobeConfig.Binding.ShowGearSetsAsIcon then
		SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
		mogStatus:SetTexture("Interface\\Store\\category-icon-clothes")
	end

	mogStatus:SetAlpha(alpha)
	mogStatus.assignedAlpha = alpha

	C_Timer.After(0, function() 
		if(button.searchOverlay and button.searchOverlay:IsShown()) then
			mogStatus:SetAlpha(0.3)
		end
	end)

	if showAnim and CaerdonWardrobeConfig.Icon.EnableAnimation then
		if mogAnim and not mogAnim:IsPlaying() then
			mogAnim:Play()
		end
	else
		if mogAnim and mogAnim:IsPlaying() then
			mogAnim:Finish()
		end
	end
end

local function SetItemButtonBindType(button, mogStatus, bindingStatus, options, bag, itemID)
	local bindsOnText = button.bindsOnText

	if not bindingStatus and not bindsOnText then return end
	if not bindingStatus or ShouldHideBindingStatus(bag, bindingStatus) then
		if bindsOnText then
			bindsOnText:SetText("")
		end
		return
	end

	if not bindsOnText then
		bindsOnText = button:CreateFontString(nil, "BORDER", "SystemFont_Outline_Small") 
		button.bindsOnText = bindsOnText
	end

	bindsOnText:ClearAllPoints()
	bindsOnText:SetWidth(button:GetWidth())

	local bindingPosition = options.overrideBindingPosition or CaerdonWardrobeConfig.Binding.Position
	local bindingOffset = options.bindingOffset or 2

	if bindingPosition == "BOTTOM" then
		bindsOnText:SetPoint("BOTTOMRIGHT", bindingOffset, 2)
		if bindingStatus == CaerdonWardrobeBoA then
			local offset = options.itemCountOffset or 15
			if (button.count and button.count > 1) then
				bindsOnText:SetPoint("BOTTOMRIGHT", 0, offset)
			end
			if(options.bindingScale) then
				bindsOnText:SetScale(options.bindingScale)
			end
		end
	elseif bindingPosition == "CENTER" then
		bindsOnText:SetPoint("CENTER", 0, 0)
	elseif bindingPosition == "TOP" then
		bindsOnText:SetPoint("TOPRIGHT", 0, -2)
	else
		bindsOnText:SetPoint(bindingPosition, options.bindingOffsetX or 2, options.bindingOffsetY or 2)
	end

	local bindingText
	if IsGearSetStatus(bindingStatus) then -- is gear set
		if CaerdonWardrobeConfig.Binding.ShowGearSets and not CaerdonWardrobeConfig.Binding.ShowGearSetsAsIcon then
			bindingText = "|cFFFFFFFF" .. bindingStatus .. "|r"
		end
	else
		if mogStatus == "own" then
			if bindingStatus == CaerdonWardrobeBoA then
				local color = BAG_ITEM_QUALITY_COLORS[LE_ITEM_QUALITY_HEIRLOOM]
				bindsOnText:SetTextColor(color.r, color.g, color.b, 1)
				bindingText = bindingStatus
			else
				bindingText = "|cFF00FF00" .. bindingStatus .. "|r"
			end
		elseif mogStatus == "other" then
			bindingText = "|cFFFF0000" .. bindingStatus .. "|r"
		elseif mogStatus == "collected" then
			if bindingStatus == CaerdonWardrobeBoA then
				local color = BAG_ITEM_QUALITY_COLORS[LE_ITEM_QUALITY_HEIRLOOM]
				bindsOnText:SetTextColor(color.r, color.g, color.b, 1)
				bindingText = bindingStatus
			elseif bindingStatus == CaerdonWardrobeBoE then
				bindingText = "|cFF00FF00" .. bindingStatus .. "|r"
			else
				bindingText = bindingStatus
			end
		else
			if bindingStatus == CaerdonWardrobeBoA then
				local color = BAG_ITEM_QUALITY_COLORS[LE_ITEM_QUALITY_HEIRLOOM]
				bindsOnText:SetTextColor(color.r, color.g, color.b, 1)
				bindingText = bindingStatus
			else
				bindingText = "|cFF00FF00" .. bindingStatus .. "|r"
			end
		end
	end

	bindsOnText:SetText(bindingText)
end

local itemQueue = {}
local function QueueProcessItem(itemLink, itemID, bag, slot, button, options, itemProcessed)
	local itemKey = GetItemKey(bag, slot, itemLink)
	itemQueue[itemKey] = { itemID = itemID, bag = bag, slot = slot, button = button, options = options, itemProcessed = itemProcessed }
	SetItemButtonMogStatus(button, "waiting", nil, options, bag, slot, itemID)
	isItemUpdateRequested = true
end

local function ItemIsSellable(itemID, itemLink)
	local isSellable = true
	if itemID == 23192 then -- Tabard of the Scarlet Crusade needs to be worn for a vendor at Darkmoon Faire
		isSellable = false
	elseif itemID == 116916 then -- Gorepetal's Gentle Grasp allows faster herbalism in Draenor
		isSellable = false
	end
	return isSellable
end

local function GetBankContainer(button)
	local containerID = button:GetParent():GetID();
	if( button.isBag ) then
		containerID = -ITEM_INVENTORY_BANK_BAG_OFFSET;
		return
	end

	return containerID
end

local function ProcessItem(itemID, bag, slot, button, options, itemProcessed)
	local bindingText
	local mogStatus = nil

   	if not options then
   		options = {}
   	end

	local showMogIcon = options.showMogIcon
	local showBindStatus = options.showBindStatus
	local showSellables = options.showSellables

	local canBeChanged, noChangeReason, canBeSource, noSourceReason = C_Transmog.GetItemInfo(itemID)

	local itemLink = GetItemLinkLocal(bag, slot)
	if bag == "EncounterJournal" and not itemLink then
		return
	end

	local bindingStatus, needsItem, hasUse, isDressable, isInEquipmentSet, isBindOnPickup, isCompletionistItem, shouldRetry, unusableItem
	local appearanceID, isCollected, sourceID

	bindingStatus, needsItem, hasUse, isDressable, isInEquipmentSet, isBindOnPickup, isCompletionistItem, shouldRetry, unusableItem, matchesLootSpec = GetBindingStatus(bag, slot, itemID, itemLink)
	if shouldRetry then
		QueueProcessItem(itemLink, itemID, bag, slot, button, options, itemProcessed)
		return
	end

   	if IsCollectibleLink(itemLink) then
   		shouldRetry = false
   	else
		appearanceID, isCollected, sourceID, shouldRetry = GetItemAppearance(itemID, itemLink)
		if shouldRetry then
			QueueProcessItem(itemLink, itemID, bag, slot, button, options, itemProcessed)
			return
		end
	end

	if appearanceID then
		local canCollect, matchedSource, shouldRetry = PlayerCanCollectAppearance(appearanceID, itemID, itemLink)
		if shouldRetry then
			QueueProcessItem(itemLink, itemID, bag, slot, button, options, itemProcessed)
			return
		end

		if(needsItem and not isCollected and not PlayerHasAppearance(appearanceID)) then
			if canCollect and not unusableItem then
				mogStatus = "own"
			else
				if bindingStatus then
					mogStatus = "other"
				elseif (bag == "EncounterJournal" or bag == "QuestButton") then
					mogStatus = "other"
				elseif (bag == "LootFrame" or bag == "GroupLootFrame") and not isBindOnPickup then
					mogStatus = "other"
				elseif unusableItem then
					mogStatus = "collected"
				end
			end

			if not matchesLootSpec and bag == "EncounterJournal" then
				mogStatus = "otherSpec"
			end
		else

			if isCompletionistItem then
				-- You have this, but you want them all.  Why?  Because.

				-- local _, _, _, _, reqLevel, class, subclass, _, equipSlot = GetItemInfo(itemID)
				-- local playerLevel = UnitLevel("player")

				if canCollect then
					mogStatus = "ownPlus"
				else
					mogStatus = "otherPlus"
				end

				if not matchesLootSpec and bag == "EncounterJournal" then
					mogStatus = "otherSpecPlus"
				end

				if unusableItem then
					mogStatus = "otherPlus"
				end

			-- If an item isn't flagged as a source or has a usable effect,
			-- then don't mark it as sellable right now to avoid accidents.
			-- May need to expand this to account for other items, too, for now.
			elseif canBeSource and not isInEquipmentSet then
				if isDressable and not shouldRetry then -- don't flag items for sale that have use effects for now
					if IsBankOrBags(bag) then
					 	local money, itemCount, refundSec, currencyCount, hasEnchants = GetContainerItemPurchaseInfo(bag, slot, isEquipped);
						if hasUse and refundSec then
							mogStatus = "refundable"
						elseif not hasUse then
							mogStatus = "collected"
						end
					else 
						mogStatus = "collected"
					end
				end
			end
			-- TODO: Decide how to expose this functionality
			-- Hide anything that doesn't match
			-- if button then
			-- 	--button.IconBorder:SetVertexColor(100, 255, 50)
			-- 	button.searchOverlay:Show()
			-- end

		end
	elseif needsItem then
		if ((canBeSource and isDressable) or IsMountLink(itemLink)) and not shouldRetry then
			local _, _, _, _, reqLevel, class, subclass, _, equipSlot = GetItemInfo(itemID)
			local playerLevel = UnitLevel("player")

			if not reqLevel or playerLevel >= reqLevel then
				mogStatus = "own"
			else
				mogStatus = "other"
			end
		elseif IsPetLink(itemLink) or IsToyLink(itemLink) or IsRecipeLink(itemLink) then
			mogStatus = "own"
		end
	else
		if canBeSource then
	        local hasTransmog = C_TransmogCollection.PlayerHasTransmog(itemID)
	        if hasTransmog and not hasUse and isDressable then
	        	-- Tabards don't have an appearance ID and will end up here.
	        	mogStatus = "collected"
	        end
	    end

	    if(IsBankOrBags(bag)) then	    	
	    	local containerID = bag
	    	local containerSlot = slot

			local texture, itemCount, locked, quality, readable, lootable, _ = GetContainerItemInfo(containerID, containerSlot);
			if lootable then
				local startTime, duration, isEnabled = GetContainerItemCooldown(containerID, containerSlot)
				if duration > 0 and not isEnabled then
					mogStatus = "refundable" -- Can't open yet... show timer
				else
					mogStatus = "openable"
				end
			end

		elseif bag == "MerchantFrame" then
			if (MerchantFrame.selectedTab == 1) then
				-- TODO: If I can ever figure out how to process pets in the MerchantFrame
			else
			end
		end

		-- Hide anything that doesn't match
		-- if button then
		-- 	--button.IconBorder:SetVertexColor(100, 255, 50)
		-- 	button.searchOverlay:Show()
		-- end
	end

	if mogStatus == "collected" and 
		ItemIsSellable(itemID, itemLink) and 
		not isInEquipmentSet then
       	-- Anything that reports as the player having should be safe to sell
       	-- unless it's in an equipment set or needs to be excluded for some
       	-- other reason
		options.isSellable = true
	end

	if button then
		SetItemButtonMogStatus(button, mogStatus, bindingStatus, options, bag, slot, itemID)
		SetItemButtonBindType(button, mogStatus, bindingStatus, options, bag, itemID)
	end

	if itemProcessed then
		itemProcessed(mogStatus, bindingStatus)
	end
end

local function ProcessOrWaitItem(itemID, bag, slot, button, options, itemProcessed)
	if itemID and GetItemInfoInstant(itemID) then
		local waitItem = waitingOnItemData[tostring(itemID)]
		if not waitItem then
			waitItem = {}
			waitingOnItemData[tostring(itemID)] = waitItem
		end

		local waitBag = waitItem[tostring(bag)]
		if not waitBag then
			waitBag = {}
			waitItem[tostring(bag)] = waitBag
		end

		-- Turning off item name check for now as it seems unnecessary - revisit if problems
		-- local itemName = GetItemInfoLocal(itemID, bag, slot)
		local itemLink = GetItemLinkLocal(bag, slot)
		if itemLink == nil then
		-- if itemName == nil or itemLink == nil then
			SetItemButtonMogStatus(button, "waiting", nil, options, bag, slot, itemID)
			waitBag[tostring(slot)] = { itemID = itemID, bag = bag, slot = slot, button = button, options = options, itemProcessed = itemProcessed}
		else
			waitingOnItemData[tostring(itemID)][tostring(bag)][tostring(slot)] = nil
			ProcessItem(itemID, bag, slot, button, options, itemProcessed)
		end
	else
		SetItemButtonMogStatus(button, nil)
		SetItemButtonBindType(button, nil)
	end
end

local registeredAddons = {}
local registeredBagAddons = {}
local bagAddonCount = 0

function CaerdonWardrobe:RegisterAddon(name, addonOptions)
	local options = {
		isBag = true	
	}

	if addonOptions then
		for key, value in pairs(addonOptions) do
			options[key] = value
		end
	end

	registeredAddons[name] = options

	if options.isBag then
		registeredBagAddons[name] = options
		bagAddonCount = bagAddonCount + 1
		if bagAddonCount > 1 then
			for key in pairs(registeredBagAddons) do
				if addonList then
					addonList = addonList .. ", " .. key
				else
					addonList = key
				end	
			end
			StaticPopup_Show("CAERDON_WARDROBE_MULTIPLE_BAG_ADDONS", addonList)
		end
		if not options.hookDefaultBags then
			ignoreDefaultBags = true
		end
	end
end

function CaerdonWardrobe:ClearButton(button)
	SetItemButtonMogStatus(button, nil)
	SetItemButtonBindType(button, nil)
end

function CaerdonWardrobe:UpdateButton(itemID, bag, slot, button, options, itemProcessed)
	ProcessOrWaitItem(itemID, bag, slot, button, options, itemProcessed)
end

function CaerdonWardrobe:ResetButton(button)
	-- Deprecating to merge my other bag extensions
	-- Moved to CaerdonWardrobe:ClearButton
end

function CaerdonWardrobe:ProcessItem(itemID, bag, slot, button, options, itemProcessed)
	-- Deprecating to merge my other bag extensions
	-- Moved to CaerdonWardrobe:UpdateButton
end

function CaerdonWardrobe:RegisterBagAddon(options)
	-- Deprecating to merge my other bag extensions
	-- Moved to CaerdonWardrobe:RegisterAddon
end

local function OnContainerUpdate(self, asyncUpdate)
	local bagID = self:GetID()

	for buttonIndex = 1, self.size do
		local button = _G[self:GetName() .. "Item" .. buttonIndex]
		local slot = button:GetID()

		local itemID = GetContainerItemID(bagID, slot)
		local texture, itemCount, locked = GetContainerItemInfo(bagID, slot)

		ProcessOrWaitItem(itemID, bagID, slot, button, { showMogIcon = true, showBindStatus = true, showSellables = true })
	end
end

local function OnItemUpdate_Coroutine()
	local processQueue = {}
	local itemCount = 0

	for itemKey, itemInfo in pairs(itemQueue) do
		processQueue[itemKey] = itemInfo
		itemQueue[itemKey] = nil
	end

	for itemKey, itemInfo in pairs(processQueue) do
		itemCount = itemCount + 1

		ProcessOrWaitItem(itemInfo.itemID, itemInfo.bag, itemInfo.slot, itemInfo.button, itemInfo.options, itemInfo.itemProcessed)
		if itemCount % 8 == 0 then
			coroutine.yield()
		end
	end
end

local waitingOnBagUpdate = {}
local function OnBagUpdate_Coroutine()
    local processQueue = {}
    for frameID, shouldUpdate in pairs(waitingOnBagUpdate) do
      processQueue[frameID] = shouldUpdate
      waitingOnBagUpdate[frameID] = nil
    end

    for frameID, shouldUpdate in pairs(processQueue) do
      local frame = _G["ContainerFrame".. frameID]

      if frame:IsShown() then
        OnContainerUpdate(frame, true)
      end
      coroutine.yield()
    end

	-- waitingOnBagUpdate = {}
end

local function AddBagUpdateRequest(bagID)
	local foundBag = false
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local frame = _G["ContainerFrame"..i];
		if ( frame:GetID() == bagID ) then
			waitingOnBagUpdate[tostring(i)] = true
			foundBag = true
		end
	end
end

local function ScheduleContainerUpdate(frame)
	local bagID = frame:GetID()
	AddBagUpdateRequest(bagID)
end

-- hooksecurefunc("ContainerFrame_Update", ScheduleContainerUpdate)

local function OnBankItemUpdate(button)
	-- local containerID = GetBankContainer(button)
	-- local buttonID = button:GetID()

	-- local bag = "BankFrame"
	-- local slot = button:GetInventorySlot();
	local bag = GetBankContainer(button)
	local slot = button:GetID()

	-- local itemID = GetContainerItemID(containerID, buttonID)
	if bag and slot then
		local itemID = GetContainerItemID(bag, slot)
		ProcessOrWaitItem(itemID, bag, slot, button, { showMogIcon=true, showBindStatus=true, showSellables=true })
	end
end

hooksecurefunc("BankFrameItemButton_Update", OnBankItemUpdate)

local isGuildBankFrameUpdateRequested = false

local function OnGuildBankFrameUpdate_Coroutine()
	if( GuildBankFrame.mode == "bank" ) then
		local tab = GetCurrentGuildBankTab();
		local button, index, column;
		local texture, itemCount, locked, isFiltered, quality;

		for i=1, MAX_GUILDBANK_SLOTS_PER_TAB do
			index = mod(i, NUM_SLOTS_PER_GUILDBANK_GROUP);
			if ( index == 0 ) then
				index = NUM_SLOTS_PER_GUILDBANK_GROUP;

				coroutine.yield()
			end

			if isGuildBankFrameUpdateRequested then
				return
			end

			column = ceil((i-0.5)/NUM_SLOTS_PER_GUILDBANK_GROUP);
			button = _G["GuildBankColumn"..column.."Button"..index];

			local bag = "GuildBankFrame"
			local slot = {tab = tab, index = i}

			local options = {
				showMogIcon = true,
				showBindStatus = true,
				showSellables = true
			}

			local itemLink = GetGuildBankItemLink(tab, i)
			if itemLink then
				local itemID = GetItemID(itemLink)
				ProcessOrWaitItem(itemID, bag, slot, button, options)
			else
				-- nil results in button icon / text reset
				ProcessOrWaitItem(nil, bag, slot, button, options)
			end
		end
	end
end

local function OnGuildBankFrameUpdate()
	isGuildBankFrameUpdateRequested = true
end

local function OnMerchantUpdate()
	for i=1, MERCHANT_ITEMS_PER_PAGE, 1 do
		local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)

		local button = _G["MerchantItem"..i.."ItemButton"];

		local bag = "MerchantFrame"
		local slot = index

		local itemID = GetMerchantItemID(index)
		ProcessOrWaitItem(itemID, bag, slot, button, { showMogIcon=true, showBindStatus=true, showSellables=false})
	end
end

local function OnBuybackUpdate()
	local numBuybackItems = GetNumBuybackItems();

	for index=1, BUYBACK_ITEMS_PER_PAGE, 1 do -- Only 1 actual page for buyback right now
		if index <= numBuybackItems then
			local button = _G["MerchantItem"..index.."ItemButton"];

			local bag = "MerchantFrame"
			local slot = index

			local itemID = C_MerchantFrame.GetBuybackItemID(index)
			ProcessOrWaitItem(itemID, bag, slot, button, { showMogIcon=true, showBindStatus=true, showSellables=false})
		end
	end
end

hooksecurefunc("MerchantFrame_UpdateMerchantInfo", OnMerchantUpdate)
hooksecurefunc("MerchantFrame_UpdateBuybackInfo", OnBuybackUpdate)

local ignoreEvents = {
	["APPEARANCE_SEARCH_UPDATED"] = {},
	["ACTIONBAR_UPDATE_COOLDOWN"] = {},
	["BAG_UPDATE_COOLDOWN"] = {},
	["BN_FRIEND_INFO_CHANGED"] = {},
	["CHAT_MSG_BN_WHISPER"] = {},
	["CHAT_MSG_BN_WHISPER_INFORM"] = {},
	["CHAT_MSG_CHANNEL"] = {},
	["CHAT_MSG_SYSTEM"] = {},
	["CHAT_MSG_TRADESKILLS"] = {},
	["COMBAT_LOG_EVENT_UNFILTERED"] = {},
	["COMPANION_UPDATE"] = {},
	["CRITERIA_UPDATE"] = {},
	["CURSOR_UPDATE"] = {},
	["FRIENDLIST_UPDATE"] = {},
	["GET_ITEM_INFO_RECEIVED"] = {},
	["GUILDBANKBAGSLOTS_CHANGED"] = {},
	["GUILD_ROSTER_UPDATE"] = {},
	["ITEM_LOCK_CHANGED"] = {},
	["ITEM_LOCKED"] = {},
	["ITEM_UNLOCKED"] = {},
	["MODIFIER_STATE_CHANGED"] = {},
	["NAME_PLATE_UNIT_REMOVED"] = {},
	["RECEIVED_ACHIEVEMENT_LIST"] = {},
	["QUEST_LOG_UPDATE"] = {},
	["SPELL_UPDATE_COOLDOWN"] = {},
	["SPELL_UPDATE_USABLE"] = {},
	["UNIT_ABSORBE_AMOUNT_CHANGED"] = {},
	["UNIT_AURA"] = {},
	["UNIT_POWER"] = {},
	["UNIT_POWER_FREQUENT"] = {},
	["UPDATE_INVENTORY_DURABILITY"] = {},
	["UNIT_ATTACK_SPEED"] = {},
	["UNIT_SPELL_HASTE"] = {},
	["UNIT_TARGET"] = {},
	["UPDATE_MOUSEOVER_UNIT"] = {},
	["UPDATE_PENDING_MAIL"] = {},
	["UPDATE_UI_WIDGET"] = {},
	["UPDATE_WORLD_STATES"] = {},
	["QUESTLINE_UPDATE"] = {},
	["WORLD_MAP_UPDATE"] = {}
}

local function OnEvent(self, event, ...)
	local handler = self[event]
	if(handler) then
		handler(self, ...)
	end
end

local timeSinceLastGuildBankUpdate = nil
local timeSinceLastBagUpdate = nil
local GUILDBANKFRAMEUPDATE_INTERVAL = 0.1
local BAGUPDATE_INTERVAL = 0.1
local ITEMUPDATE_INTERVAL = 0.1
local timeSinceLastItemUpdate = nil

local function OnUpdate(self, elapsed)
	if self.itemUpdateCoroutine then
		if coroutine.status(self.itemUpdateCoroutine) ~= "dead" then
			local ok, result = coroutine.resume(self.itemUpdateCoroutine)
			if not ok then
				error(result)
			end
		else
			self.itemUpdateCoroutine = nil
		end
		return
	end

	if(self.bagUpdateCoroutine) then
		if coroutine.status(self.bagUpdateCoroutine) ~= "dead" then
			local ok, result = coroutine.resume(self.bagUpdateCoroutine)
			if not ok then
				error(result)
			end
		else
			self.bagUpdateCoroutine = nil
		end
		return
	end

	if(self.guildBankUpdateCoroutine) then
		if coroutine.status(self.guildBankUpdateCoroutine) ~= "dead" then
			local ok, result = coroutine.resume(self.guildBankUpdateCoroutine)
			if not ok then
				error(result)
			end
		else
			self.guildBankUpdateCoroutine = nil
		end
		return
	end

	if isGuildBankFrameUpdateRequested then
		isGuildBankFrameUpdateRequested = false
		timeSinceLastGuildBankUpdate = 0
	elseif timeSinceLastGuildBankUpdate then
		timeSinceLastGuildBankUpdate = timeSinceLastGuildBankUpdate + elapsed
	end

	if isBagUpdateRequested then
		isBagUpdateRequested = false
		timeSinceLastBagUpdate = 0
	elseif timeSinceLastBagUpdate then
		timeSinceLastBagUpdate = timeSinceLastBagUpdate + elapsed
	end

	if isItemUpdateRequested then
		isItemUpdateRequested = false
		timeSinceLastItemUpdate = 0
	elseif timeSinceLastItemUpdate then
		timeSinceLastItemUpdate = timeSinceLastItemUpdate + elapsed
	end

	if( timeSinceLastGuildBankUpdate ~= nil and (timeSinceLastGuildBankUpdate > GUILDBANKFRAMEUPDATE_INTERVAL) ) then
		timeSinceLastGuildBankUpdate = nil
		self.guildBankUpdateCoroutine = coroutine.create(OnGuildBankFrameUpdate_Coroutine)
	end

	if( timeSinceLastBagUpdate ~= nil and (timeSinceLastBagUpdate > BAGUPDATE_INTERVAL) ) then
		timeSinceLastBagUpdate = nil
		self.bagUpdateCoroutine = coroutine.create(OnBagUpdate_Coroutine)
	end

	if( timeSinceLastItemUpdate ~= nil and (timeSinceLastItemUpdate > ITEMUPDATE_INTERVAL) ) then
		timeSinceLastItemUpdate = nil
		self.itemUpdateCoroutine = coroutine.create(OnItemUpdate_Coroutine)
	end
end

local function OnEncounterJournalSetLootButton(item)
	local itemID, encounterID, name, icon, slot, armorType, itemLink = EJ_GetLootInfoByIndex(item.index);
	local options = {
		iconOffset = 8,
		otherIcon = "Interface\\Buttons\\UI-GroupLoot-Pass-Up",
		otherIconSize = 21,
		otherIconOffset = 16,
		overridePosition = "TOPRIGHT"
	}

	if name then
		ProcessItem(itemID, "EncounterJournal", item, item, options)
	end
end

local CaerdonWardrobeFrame = CreateFrame("FRAME", "CaerdonWardrobeFrame")
CaerdonWardrobeFrame:RegisterEvent("ADDON_LOADED")
CaerdonWardrobeFrame:RegisterEvent("PLAYER_LOGOUT")
CaerdonWardrobeFrame:SetScript("OnEvent", OnEvent)
CaerdonWardrobeFrame:SetScript("OnUpdate", OnUpdate)

C_TransmogCollection.SetShowMissingSourceInItemTooltips(true)
SetCVar("missingTransmogSourceInItemTooltips", 1)

function CaerdonWardrobeNS:GetDefaultConfig()
	return {
		Version = 7,
		Icon = {
			EnableAnimation = true,
			Position = "TOPRIGHT",

			ShowLearnable = {
				BankAndBags = true,
				GuildBank = true,
				Merchant = true,
				SameLookDifferentItem = false,
			},

			ShowLearnableByOther = {
				BankAndBags = true,
				GuildBank = true,
				Merchant = true,
				EncounterJournal = true,
				SameLookDifferentItem = false,
			},

			ShowSellable = {
				BankAndBags = true,
				GuildBank = true,
			}
		},

		Binding = {
			ShowStatus = {
				BankAndBags = true,
				GuildBank = true,
				Merchant = true,
			},

			ShowBoA = true,
			ShowBoE = true,
			ShowGearSets = true,
			ShowGearSetsAsIcon = false,
			Position = "BOTTOM",
		}
	}
end

local function ProcessSettings()
	if not CaerdonWardrobeConfig or CaerdonWardrobeConfig.Version ~= CaerdonWardrobeNS:GetDefaultConfig().Version then
		CaerdonWardrobeConfig = CaerdonWardrobeNS:GetDefaultConfig()
	end
end

function CaerdonWardrobeFrame:PLAYER_LOGOUT()
end

function CaerdonWardrobeFrame:ADDON_LOADED(name)
	if name == "Combuctor" then
		ProcessSettings()
		CaerdonWardrobeNS:FireConfigLoaded()

		if IsLoggedIn() then
			OnEvent(CaerdonWardrobeFrame, "PLAYER_LOGIN")
		else
			CaerdonWardrobeFrame:RegisterEvent("PLAYER_LOGIN")
		end
	elseif name == "Blizzard_GuildBankUI" then
		hooksecurefunc("GuildBankFrame_Update", OnGuildBankFrameUpdate)
	elseif name == "Blizzard_EncounterJournal" then
		hooksecurefunc("EncounterJournal_SetLootButton", OnEncounterJournalSetLootButton)
	end
end

function UpdatePin(pin)
	local options = {
		iconOffset = -5,
		iconSize = 60,
		overridePosition = "TOPRIGHT",
		-- itemCountOffset = 10,
		-- bindingScale = 0.9
	}

	if GetNumQuestLogRewards(pin.questID) > 0 then
		local itemName, itemTexture, numItems, quality, isUsable, itemID = GetQuestLogRewardInfo(1, pin.questID)
		CaerdonWardrobe:UpdateButton(itemID, "QuestButton", { itemID = itemID, questID = pin.questID }, pin, options)
	else
		CaerdonWardrobe:ClearButton(pin)
	end
end

local function OnQuestInfoShowRewards(template, parentFrame)
	local numQuestRewards = 0;
	local numQuestChoices = 0;
	local rewardsFrame = QuestInfoFrame.rewardsFrame;
	local questID

	if ( template.canHaveSealMaterial ) then
		local questFrame = parentFrame:GetParent():GetParent();
		if ( template.questLog ) then
			questID = questFrame.questID;
		else
			questID = GetQuestID();
		end
	end

	local spellGetter;
	if ( QuestInfoFrame.questLog ) then
		questID = select(8, GetQuestLogTitle(GetQuestLogSelection()));
		if C_QuestLog.ShouldShowQuestRewards(questID) then
			numQuestRewards = GetNumQuestLogRewards();
			numQuestChoices = GetNumQuestLogChoices();
			-- playerTitle = GetQuestLogRewardTitle();
			-- numSpellRewards = GetNumQuestLogRewardSpells();
			-- spellGetter = GetQuestLogRewardSpell;
		end
	else
		numQuestRewards = GetNumQuestRewards();
		numQuestChoices = GetNumQuestChoices();
		-- playerTitle = GetRewardTitle();
		-- numSpellRewards = GetNumRewardSpells();
		-- spellGetter = GetRewardSpell;
	end

	local options = {
		iconOffset = 0,
		iconSize = 40,
		overridePosition = "TOPLEFT",
		overrideBindingPosition = "TOPLEFT",
		bindingOffsetX = -53,
		bindingOffsetY = -16
	}

	local questItem, name, texture, quality, isUsable, numItems, itemID;
	local rewardsCount = 0;
	if ( numQuestChoices > 0 ) then
		local index;
		local itemLink;
		local baseIndex = rewardsCount;
		for i = 1, numQuestChoices do
			index = i + baseIndex;
			questItem = QuestInfo_GetRewardButton(rewardsFrame, index);
			if ( QuestInfoFrame.questLog ) then
				name, texture, numItems, quality, isUsable, itemID = GetQuestLogChoiceInfo(i);
			else
				name, texture, numItems, quality, isUsable = GetQuestItemInfo(questItem.type, i);
				itemLink = GetQuestItemLink(questItem.type, i);
				itemID = GetItemID(itemLink)
			end
			rewardsCount = rewardsCount + 1;

			CaerdonWardrobe:UpdateButton(itemID, "QuestButton", { itemID = itemID, questID = questID, index = i, questItem = questItem }, questItem, options)
		end
	end

	if ( numQuestRewards > 0) then
		local index;
		local itemLink;
		local baseIndex = rewardsCount;
		local buttonIndex = 0;
		for i = 1, numQuestRewards, 1 do
			buttonIndex = buttonIndex + 1;
			index = i + baseIndex;
			questItem = QuestInfo_GetRewardButton(rewardsFrame, index);
			questItem.type = "reward";
			questItem.objectType = "item";
			if ( QuestInfoFrame.questLog ) then
				name, texture, numItems, quality, isUsable, itemID = GetQuestLogRewardInfo(i);
			else
				name, texture, numItems, quality, isUsable = GetQuestItemInfo(questItem.type, i);
				itemLink = GetQuestItemLink(questItem.type, i);
				if itemLink ~= nil then
					itemID = GetItemID(itemLink)
				else
					itemID = -1
				end
			end
			rewardsCount = rewardsCount + 1;

			if itemID ~= -1 then
				CaerdonWardrobe:UpdateButton(itemID, "QuestButton", { itemID = itemID, questID = questID, index = i, questItem = questItem }, questItem, options)
			end
		end
	end
end

local function OnQuestInfoDisplay(template, parentFrame)
	-- Hooking OnQuestInfoDisplay instead of OnQuestInfoShowRewards directly because it seems to work
	-- and I was having some problems.  :)
	local i = 1
	while template.elements[i] do
		if template.elements[i] == QuestInfo_ShowRewards then OnQuestInfoShowRewards(template, parentFrame) return end
		i = i + 3
	end
end

function CaerdonWardrobeFrame:PLAYER_LOGIN(...)
		-- CaerdonWardrobeFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
		CaerdonWardrobeFrame:RegisterEvent("BAG_OPEN")
		CaerdonWardrobeFrame:RegisterEvent("BAG_UPDATE")
		CaerdonWardrobeFrame:RegisterEvent("BAG_UPDATE_DELAYED")
		CaerdonWardrobeFrame:RegisterEvent("BANKFRAME_OPENED")
		CaerdonWardrobeFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
		CaerdonWardrobeFrame:RegisterEvent("TRANSMOG_COLLECTION_UPDATED")
		-- CaerdonWardrobeFrame:RegisterEvent("TRANSMOG_COLLECTION_ITEM_UPDATE")
		CaerdonWardrobeFrame:RegisterEvent("EQUIPMENT_SETS_CHANGED")
		CaerdonWardrobeFrame:RegisterEvent("MERCHANT_UPDATE")
		CaerdonWardrobeFrame:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
	C_TransmogCollection.SetShowMissingSourceInItemTooltips(true)

	hooksecurefunc (WorldMap_WorldQuestPinMixin, "RefreshVisuals", function (self)
		if not IsModifiedClick("COMPAREITEMS") and not ShoppingTooltip1:IsShown() then
			UpdatePin(self);
		end
	end)
	-- hooksecurefunc("QuestInfo_GetRewardButton", OnQuestInfoGetRewardButton)
	-- hooksecurefunc("QuestInfo_ShowRewards", OnQuestInfoShowRewards)
end

function RefreshMainBank()
	if not ignoreDefaultBags then
		for i=1, NUM_BANKGENERIC_SLOTS, 1 do
			button = BankSlotsFrame["Item"..i];
			OnBankItemUpdate(button);
		end
	end
end

local function RefreshItems()
	cachedBinding = {}
	cachedIsDressable = {}

	if MerchantFrame:IsShown() then 
		if MerchantFrame.selectedTab == 1 then
			OnMerchantUpdate()
		else
			OnBuybackUpdate()
		end
	end

	if BankFrame:IsShown() then
		RefreshMainBank()
	end

	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local frame = _G["ContainerFrame"..i];
		waitingOnBagUpdate[tostring(i)] = true
		isBagUpdateRequested = true
	end
end

local function OnContainerFrameUpdateSearchResults(frame)
	local id = frame:GetID();
	local name = frame:GetName().."Item";
	local itemButton;
	local _, isFiltered;
	
	for i=1, frame.size, 1 do
		itemButton = _G[name..i] or frame["Item"..i];
		_, _, _, _, _, _, _, isFiltered = GetContainerItemInfo(id, itemButton:GetID())
		SetItemButtonMogStatusFilter(itemButton, isFiltered)
	end
end

hooksecurefunc("ContainerFrame_UpdateSearchResults", OnContainerFrameUpdateSearchResults)

local function OnEquipPendingItem()
	-- TODO: Bit of a hack... wait a bit and then update...
	--       Need to figure out a better way.  Otherwise,
	--		 you end up with BoE markers on things you've put on.
	C_Timer.After(1, function() RefreshItems() end)
end

hooksecurefunc("EquipPendingItem", OnEquipPendingItem)

local function OnOpenBag(bagID)
	if not ignoreDefaultBags then
		for i=1, NUM_CONTAINER_FRAMES, 1 do
			local frame = _G["ContainerFrame"..i];
			if ( frame:IsShown() and frame:GetID() == bagID ) then
				waitingOnBagUpdate[tostring(i)] = true
				isBagUpdateRequested = true
				break
			end
		end
	end
end

local function OnOpenBackpack()
	if not ignoreDefaultBags then
		isBagUpdateRequested = true
	end
end

hooksecurefunc("OpenBag", OnOpenBag)
hooksecurefunc("OpenBackpack", OnOpenBackpack)
hooksecurefunc("ToggleBag", OnOpenBag)

function CaerdonWardrobeFrame:BAG_UPDATE(bagID)
	AddBagUpdateRequest(bagID)
end

function CaerdonWardrobeFrame:BAG_UPDATE_DELAYED()
	local count = 0
	for _ in pairs(waitingOnBagUpdate) do 
		count = count + 1
	end

	if count == 0 then
		RefreshItems()
	else
		isBagUpdateRequested = true
	end
end

function CaerdonWardrobeFrame:GET_ITEM_INFO_RECEIVED(itemID)
	local itemData = waitingOnItemData[tostring(itemID)]
	if itemData then
        for bag, bagData in pairs(itemData) do
        	for slot, slotData in pairs(bagData) do
        		-- Checking item info before continuing.  In certain cases,
        		-- the name / link are still nil here for some reason.
        		-- I've seen it at merchants so far.  I'm assuming that
        		-- these requests will ultimately result in yet another
        		-- GET_ITEM_INFO_RECEIVED event as that seems to be the case.
				-- Turning off item name check for now as it seems unnecessary - revisit if problems
				-- local itemName = GetItemInfoLocal(itemID, slotData.bag, slotData.slot)
				local itemLink = GetItemLinkLocal(slotData.bag, slotData.slot)

				if itemLink then
				-- if itemLink and itemName then
					ProcessItem(itemID, slotData.bag, slotData.slot, slotData.button, slotData.options, slotData.itemProcessed)
				else
					ProcessOrWaitItem(itemID, slotData.bag, slotData.slot, slotData.button, slotData.options, slotData.itemProcessed)
				end
        	end
        end
	end
end

function CaerdonWardrobeFrame:PLAYER_LOOT_SPEC_UPDATED()
	if EncounterJournal then
		EncounterJournal_LootUpdate()
	end
end

function CaerdonWardrobeFrame:TRANSMOG_COLLECTION_ITEM_UPDATE()
	-- RefreshItems()
end

function CaerdonWardrobeFrame:TRANSMOG_COLLECTION_UPDATED()
	RefreshItems()
end

function CaerdonWardrobeFrame:MERCHANT_UPDATE()
	RefreshItems()
end

function CaerdonWardrobeFrame:EQUIPMENT_SETS_CHANGED()
	RefreshItems()
end

function CaerdonWardrobeFrame:BANKFRAME_OPENED()
	-- RefreshMainBank()
end

-- Turning this off for now as I made fixes for the container hook and don't
-- need to do this twice.  Keeping around for a bit just in case.
-- function CaerdonWardrobeFrame:PLAYERBANKSLOTS_CHANGED(slot, arg2)
-- 	if ( slot <= NUM_BANKGENERIC_SLOTS ) then
-- 		OnBankItemUpdate(BankSlotsFrame["Item"..slot]);
-- 	else
-- 		OnBankItemUpdate(BankSlotsFrame["Bag"..(slot-NUM_BANKGENERIC_SLOTS)]);
-- 	end
-- end

local function OnLootFrameUpdateButton(index)
	local numLootItems = LootFrame.numLootItems;
	local numLootToShow = LOOTFRAME_NUMBUTTONS;

	if LootFrame.AutoLootTable then
		numLootItems = #LootFrame.AutoLootTable
	end

	if numLootItems > LOOTFRAME_NUMBUTTONS then
		numLootToShow = numLootToShow - 1
	end

	local isProcessing = false
	
	local button = _G["LootButton"..index];
	local slot = (numLootToShow * (LootFrame.page - 1)) + index;
	if slot <= numLootItems then
		if ((LootSlotHasItem(slot) or (LootFrame.AutoLootTable and LootFrame.AutoLootTable[slot])) and index <= numLootToShow) then
			-- texture, item, quantity, quality, locked, isQuestItem, questId, isActive = GetLootSlotInfo(slot)
			link = GetLootSlotLink(slot)
			if link then
				local itemID = GetItemID(link)
				if itemID then
					isProcessing = true
					ProcessOrWaitItem(itemID, "LootFrame", { index = slot, link = link }, button, nil)
				end
			end
		end
	end

	if not isProcessing then
		SetItemButtonMogStatus(button, nil)
		SetItemButtonBindType(button, nil)
	end
end

function OnGroupLootFrameShow(frame)
	-- local texture, name, count, quality, bindOnPickUp, canNeed, canGreed, canDisenchant, reasonNeed, reasonGreed, reasonDisenchant, deSkillRequired = GetLootRollItemInfo(frame.rollID)
	-- if name == nil then
	-- 	return
	-- end

	local itemLink = GetLootRollItemLink(frame.rollID)
	if itemLink == nil then
		return
	end

	local itemID = GetItemID(itemLink)
	if itemID then
		ProcessOrWaitItem(itemID, "GroupLootFrame", { index = frame.rollID, link = itemLink}, frame.IconFrame, nil)
	end
end

hooksecurefunc("LootFrame_UpdateButton", OnLootFrameUpdateButton)
hooksecurefunc("QuestInfo_Display", OnQuestInfoDisplay)

GroupLootFrame1:HookScript("OnShow", OnGroupLootFrameShow)
GroupLootFrame2:HookScript("OnShow", OnGroupLootFrameShow)
GroupLootFrame3:HookScript("OnShow", OnGroupLootFrameShow)
GroupLootFrame4:HookScript("OnShow", OnGroupLootFrameShow)

local configFrame
local isConfigLoaded = false

function CaerdonWardrobeNS:RegisterConfigFrame(frame)
	configFrame = frame
	if isConfigLoaded then
		CaerdonWardrobeNS:FireConfigLoaded()
	end
end

function CaerdonWardrobeNS:FireConfigLoaded()
	isConfigLoaded = true
	if configFrame then
		configFrame:OnConfigLoaded()
	end
end

-- BAG_OPEN
-- GUILDBANKBAGSLOTS_CHANGED
-- GUILDBANKFRAME_OPENED

--[[---------------------------------config
local components, pendingConfig
local configFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)

local function PropagateErrors(func)
	-- Make sure that errors aren't swallowed for InterfaceOption callbacks
	return function() xpcall(function () func(configFrame) end, geterrorhandler()) end
end

function configFrame:InitializeConfig()
	self:Hide()
	self:CreateComponents()
	CaerdonWardrobeNS:RegisterConfigFrame(self)
end

function configFrame:CreateComponents()
	components = {}
	components.title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	components.title:SetText("|cff00ff00[背包]|r幻化提示")
	components.title:SetPoint("TOPLEFT", 16, -16)

	components.titleSeparator = self:CreateTexture(nil, "ARTWORK")
	components.titleSeparator:SetColorTexture(0.25, 0.25, 0.25)
	components.titleSeparator:SetSize(600, 1)
	components.titleSeparator:SetPoint("LEFT", self, "TOPLEFT", 10, -40)

	components.bindingTextLabel = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	components.bindingTextLabel:SetText("提示文字 (瞎JB翻译的，我也没来得及验证是不是准确，你们发现不对就告诉我)")
	components.bindingTextLabel:SetPoint("TOPLEFT", components.titleSeparator, "BOTTOMLEFT", 0, -10)

	components.bindingTextPositionLabel = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	components.bindingTextPositionLabel:SetText("定位:")
	components.bindingTextPositionLabel:SetPoint("TOPLEFT", components.bindingTextLabel, "BOTTOMLEFT", 15, -15)
	components.bindingTextPosition = CreateFrame("Button", "CaerdonWardrobeConfig_BindingTextPosition", self, "UIDropDownMenuTemplate")
	components.bindingTextPosition:SetPoint("TOPLEFT", components.bindingTextPositionLabel, "TOPRIGHT", -9, 9)

	components.showStatusLabel = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	components.showStatusLabel:SetText("显示于:")
	components.showStatusLabel:SetPoint("TOPLEFT", components.bindingTextPositionLabel, "BOTTOMLEFT", 0, -15)

	components.showBindingOnBags = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showBindingOnBags", self, "InterfaceOptionsCheckButtonTemplate")
	components.showBindingOnBags:SetPoint("TOPLEFT", components.showStatusLabel, "BOTTOMLEFT", 15, -5)
	components.showBindingOnBagsLabel = _G[components.showBindingOnBags:GetName() .. "Text"]
	components.showBindingOnBagsLabel:SetWidth(80)
	components.showBindingOnBagsLabel:SetText("背包+银行")

	components.showBindingOnGuildBank = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showBindingOnGuildBank", self, "InterfaceOptionsCheckButtonTemplate")
	components.showBindingOnGuildBank:SetPoint("LEFT", components.showBindingOnBagsLabel, "RIGHT", 21, 0)
	components.showBindingOnGuildBank:SetPoint("TOP", components.showBindingOnBags, "TOP", 0, 0)
	components.showBindingOnGuildBankLabel = _G[components.showBindingOnGuildBank:GetName() .. "Text"]
	components.showBindingOnGuildBankLabel:SetWidth(80)
	components.showBindingOnGuildBankLabel:SetText("工会银行")

	components.showBindingOnMerchant = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showBindingOnMerchant", self, "InterfaceOptionsCheckButtonTemplate")
	components.showBindingOnMerchant:SetPoint("LEFT", components.showBindingOnGuildBankLabel, "RIGHT", 20, 0)
	components.showBindingOnMerchant:SetPoint("TOP", components.showBindingOnGuildBank, "TOP", 0, 0)
	components.showBindingOnMerchantLabel = _G[components.showBindingOnMerchant:GetName() .. "Text"]
	components.showBindingOnMerchantLabel:SetWidth(80)
	components.showBindingOnMerchantLabel:SetText("商人")

	components.showGearSets = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showGearSets", self, "InterfaceOptionsCheckButtonTemplate")
	components.showGearSets:SetPoint("TOPLEFT", components.showBindingOnBags, "BOTTOMLEFT", -20, -10)
	components.showGearSetsLabel = _G[components.showGearSets:GetName() .. "Text"]
	components.showGearSetsLabel:SetText("显示角标")

	components.showGearSetsAsIcon = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showGearSetsAsIcon", self, "InterfaceOptionsCheckButtonTemplate")
	components.showGearSetsAsIcon:SetPoint("TOPLEFT", components.showGearSets, "BOTTOMLEFT", 22, 8)
	components.showGearSetsAsIconLabel = _G[components.showGearSetsAsIcon:GetName() .. "Text"]
	components.showGearSetsAsIconLabel:SetText("图标样式")

	components.showBoA = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showBoA", self, "InterfaceOptionsCheckButtonTemplate")
	components.showBoA:SetPoint("LEFT", components.showGearSetsLabel, "RIGHT", 20, 0)
	components.showBoA:SetPoint("TOP", components.showGearSets, "TOP", 0, 0)
	components.showBoALabel = _G[components.showBoA:GetName() .. "Text"]
	components.showBoALabel:SetWidth(140)
	components.showBoALabel:SetText("显示战网绑定物品")

	components.showBoE = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showBoE", self, "InterfaceOptionsCheckButtonTemplate")
	components.showBoE:SetPoint("LEFT", components.showBoALabel, "RIGHT", 20, 0)
	components.showBoE:SetPoint("TOP", components.showBoA, "TOP", 0, 0)
	components.showBoELabel = _G[components.showBoE:GetName() .. "Text"]
	components.showBoELabel:SetWidth(140)
	components.showBoELabel:SetText("显示装备绑定物品")

	components.mogIconLabel = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	components.mogIconLabel:SetText("幻化图标提示")
	components.mogIconLabel:SetPoint("TOPLEFT", components.showGearSetsAsIcon, "BOTTOMLEFT", -10, -20)

	components.mogIconPositionLabel = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	components.mogIconPositionLabel:SetText("定位:")
	components.mogIconPositionLabel:SetPoint("TOPLEFT", components.mogIconLabel, "BOTTOMLEFT", 15, -15)
	components.mogIconPosition = CreateFrame("Button", "CaerdonWardrobeConfig_MogIconPosition", self, "UIDropDownMenuTemplate")
	components.mogIconPosition:SetPoint("TOPLEFT", components.mogIconPositionLabel, "TOPRIGHT", -9, 9)


	components.showLearnableLabel = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	components.showLearnableLabel:SetText("显示可学:")
	components.showLearnableLabel:SetPoint("TOPLEFT", components.mogIconPositionLabel, "BOTTOMLEFT", 0, -20)

	components.showLearnableOnBags = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showLearnableOnBags", self, "InterfaceOptionsCheckButtonTemplate")
	components.showLearnableOnBags:SetPoint("TOPLEFT", components.showLearnableLabel, "BOTTOMLEFT", 15, -5)
	components.showLearnableOnBagsLabel = _G[components.showLearnableOnBags:GetName() .. "Text"]
	components.showLearnableOnBagsLabel:SetWidth(80)
	components.showLearnableOnBagsLabel:SetText("背包+银行")

	components.showLearnableOnGuildBank = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showLearnableOnGuildBank", self, "InterfaceOptionsCheckButtonTemplate")
	components.showLearnableOnGuildBank:SetPoint("LEFT", components.showLearnableOnBagsLabel, "RIGHT", 20, 0)
	components.showLearnableOnGuildBank:SetPoint("TOP", components.showLearnableOnBags, "TOP", 0, 0)
	components.showLearnableOnGuildBankLabel = _G[components.showLearnableOnGuildBank:GetName() .. "Text"]
	components.showLearnableOnGuildBankLabel:SetWidth(80)
	components.showLearnableOnGuildBankLabel:SetText("工会银行")

	components.showLearnableOnMerchant = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showLearnableOnMerchant", self, "InterfaceOptionsCheckButtonTemplate")
	components.showLearnableOnMerchant:SetPoint("LEFT", components.showLearnableOnGuildBankLabel, "RIGHT", 20, 0)
	components.showLearnableOnMerchant:SetPoint("TOP", components.showLearnableOnGuildBank, "TOP", 0, 0)
	components.showLearnableOnMerchantLabel = _G[components.showLearnableOnMerchant:GetName() .. "Text"]
	components.showLearnableOnMerchantLabel:SetWidth(80)
	components.showLearnableOnMerchantLabel:SetText("商人")

	components.showLearnableOtherLabel = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	components.showLearnableOtherLabel:SetText("在其它物品上显示可学:")
	components.showLearnableOtherLabel:SetPoint("TOPLEFT", components.showLearnableOnBags, "BOTTOMLEFT", -15, -15)

	components.showLearnableOtherOnBags = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showLearnableOtherOnBags", self, "InterfaceOptionsCheckButtonTemplate")
	components.showLearnableOtherOnBags:SetPoint("TOPLEFT", components.showLearnableOtherLabel, "BOTTOMLEFT", 15, -5)
	components.showLearnableOtherOnBagsLabel = _G[components.showLearnableOtherOnBags:GetName() .. "Text"]
	components.showLearnableOtherOnBagsLabel:SetWidth(80)
	components.showLearnableOtherOnBagsLabel:SetText("背包+银行")

	components.showLearnableOtherOnGuildBank = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showLearnableOtherOnGuildBank", self, "InterfaceOptionsCheckButtonTemplate")
	components.showLearnableOtherOnGuildBank:SetPoint("LEFT", components.showLearnableOtherOnBagsLabel, "RIGHT", 21, 0)
	components.showLearnableOtherOnGuildBank:SetPoint("TOP", components.showLearnableOtherOnBags, "TOP", 0, 0)
	components.showLearnableOtherOnGuildBankLabel = _G[components.showLearnableOtherOnGuildBank:GetName() .. "Text"]
	components.showLearnableOtherOnGuildBankLabel:SetWidth(80)
	components.showLearnableOtherOnGuildBankLabel:SetText("工会银行")

	components.showLearnableOtherOnMerchant = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showLearnableOtherOnMerchant", self, "InterfaceOptionsCheckButtonTemplate")
	components.showLearnableOtherOnMerchant:SetPoint("LEFT", components.showLearnableOtherOnGuildBankLabel, "RIGHT", 20, 0)
	components.showLearnableOtherOnMerchant:SetPoint("TOP", components.showLearnableOtherOnGuildBank, "TOP", 0, 0)
	components.showLearnableOtherOnMerchantLabel = _G[components.showLearnableOtherOnMerchant:GetName() .. "Text"]
	components.showLearnableOtherOnMerchantLabel:SetWidth(80)
	components.showLearnableOtherOnMerchantLabel:SetText("商人")

	components.showSellableLabel = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	components.showSellableLabel:SetText("显示可卖出物品:")
	components.showSellableLabel:SetPoint("TOPLEFT", components.showLearnableOtherOnBags, "BOTTOMLEFT", -15, -15)

	components.showSellableOnBags = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showSellableOnBags", self, "InterfaceOptionsCheckButtonTemplate")
	components.showSellableOnBags:SetPoint("TOPLEFT", components.showSellableLabel, "BOTTOMLEFT", 15, -5)
	components.showSellableOnBagsLabel = _G[components.showSellableOnBags:GetName() .. "Text"]
	components.showSellableOnBagsLabel:SetWidth(80)
	components.showSellableOnBagsLabel:SetText("背包+银行")

	components.showSellableOnGuildBank = CreateFrame("CheckButton", "CaerdonWardrobeConfig_showSellableOnGuildBank", self, "InterfaceOptionsCheckButtonTemplate")
	components.showSellableOnGuildBank:SetPoint("LEFT", components.showSellableOnBagsLabel, "RIGHT", 21, 0)
	components.showSellableOnGuildBank:SetPoint("TOP", components.showSellableOnBags, "TOP", 0, 0)
	components.showSellableOnGuildBankLabel = _G[components.showSellableOnGuildBank:GetName() .. "Text"]
	components.showSellableOnGuildBankLabel:SetWidth(80)
	components.showSellableOnGuildBankLabel:SetText("工会银行")

	components.mogIconShowAnimation = CreateFrame("CheckButton", "CaerdonWardrobeConfig_MogIconShowAnimation", self, "InterfaceOptionsCheckButtonTemplate")
	components.mogIconShowAnimation:SetPoint("TOPLEFT", components.showSellableOnBags, "BOTTOMLEFT", -20, -15)
	components.mogIconShowAnimationLabel = _G[components.mogIconShowAnimation:GetName() .. "Text"]
	components.mogIconShowAnimationLabel:SetText("显示图标动画")

	components.mogIconShowSameLookDifferentItem = CreateFrame("CheckButton", "CaerdonWardrobeConfig_mogIconShowSameLookDifferentItem", self, "InterfaceOptionsCheckButtonTemplate")
	components.mogIconShowSameLookDifferentItem:SetPoint("TOPLEFT", components.mogIconShowAnimation, "BOTTOMLEFT", 0, -10)
	components.mogIconShowSameLookDifferentItemLabel = _G[components.mogIconShowSameLookDifferentItem:GetName() .. "Text"]
	components.mogIconShowSameLookDifferentItemLabel:SetText("包括外观相同的不同物品(you completionist, you)")


end

function configFrame:InitializeMogIconPosition()
	self:AddMogIconPositionDropDownItem("Top Left", "TOPLEFT")
	self:AddMogIconPositionDropDownItem("Top Right", "TOPRIGHT")
	self:AddMogIconPositionDropDownItem("Bottom Left", "BOTTOMLEFT")
	self:AddMogIconPositionDropDownItem("Bottom Right", "BOTTOMRIGHT")

	UIDropDownMenu_SetSelectedValue(components.mogIconPosition, pendingConfig.Icon.Position)
end

function configFrame:InitializeBindingTextPosition()
	self:AddBindingTextPositionDropDownItem("Top", "TOP")
	self:AddBindingTextPositionDropDownItem("Center", "CENTER")
	self:AddBindingTextPositionDropDownItem("Bottom", "BOTTOM")

	UIDropDownMenu_SetSelectedValue(components.bindingTextPosition, pendingConfig.Binding.Position)
end

function configFrame:AddMogIconPositionDropDownItem(name, value)
	local info = UIDropDownMenu_CreateInfo()
	info.text = name
	info.value = value
	info.func = function(self, arg1, arg2, checked)
		UIDropDownMenu_SetSelectedValue(components.mogIconPosition, value)
		pendingConfig.Icon.Position = value
	end

	UIDropDownMenu_AddButton(info)
end

function configFrame:AddBindingTextPositionDropDownItem(name, value)
	local info = UIDropDownMenu_CreateInfo()
	info.text = name
	info.value = value
	info.func = function(self, arg1, arg2, checked)
		UIDropDownMenu_SetSelectedValue(components.bindingTextPosition, value)
		pendingConfig.Binding.Position = value
	end

	UIDropDownMenu_AddButton(info)
end

function configFrame:ApplyConfig(config)
	pendingConfig = CopyTable(config)
end

function configFrame:RefreshComponents()
	local config = pendingConfig

	UIDropDownMenu_Initialize(components.bindingTextPosition, function() self:InitializeBindingTextPosition() end)
	components.showBindingOnBags:SetChecked(config.Binding.ShowStatus.BankAndBags)
	components.showBindingOnGuildBank:SetChecked(config.Binding.ShowStatus.GuildBank)
	components.showBindingOnMerchant:SetChecked(config.Binding.ShowStatus.Merchant)
	components.showGearSets:SetChecked(config.Binding.ShowGearSets)
	components.showGearSetsAsIcon:SetChecked(config.Binding.ShowGearSetsAsIcon)
	components.showBoA:SetChecked(config.Binding.ShowBoA)
	components.showBoE:SetChecked(config.Binding.ShowBoE)

	UIDropDownMenu_Initialize(components.mogIconPosition, function() self:InitializeMogIconPosition() end)

	components.showLearnableOnBags:SetChecked(config.Icon.ShowLearnable.BankAndBags)
	components.showLearnableOnGuildBank:SetChecked(config.Icon.ShowLearnable.GuildBank)
	components.showLearnableOnMerchant:SetChecked(config.Icon.ShowLearnable.Merchant)

	components.showLearnableOtherOnBags:SetChecked(config.Icon.ShowLearnableByOther.BankAndBags)
	components.showLearnableOtherOnGuildBank:SetChecked(config.Icon.ShowLearnableByOther.GuildBank)
	components.showLearnableOtherOnMerchant:SetChecked(config.Icon.ShowLearnableByOther.Merchant)

	components.showSellableOnBags:SetChecked(config.Icon.ShowSellable.BankAndBags)
	components.showSellableOnGuildBank:SetChecked(config.Icon.ShowSellable.GuildBank)

	components.mogIconShowAnimation:SetChecked(config.Icon.EnableAnimation)
	components.mogIconShowSameLookDifferentItem:SetChecked(config.Icon.ShowLearnable.SameLookDifferentItem)
end

function configFrame:UpdatePendingValues()
	local config = pendingConfig

	config.Binding.Position = UIDropDownMenu_GetSelectedValue(components.bindingTextPosition)
	config.Binding.ShowStatus.BankAndBags = components.showBindingOnBags:GetChecked()
	config.Binding.ShowStatus.GuildBank = components.showBindingOnGuildBank:GetChecked()
	config.Binding.ShowStatus.Merchant = components.showBindingOnMerchant:GetChecked()
	config.Binding.ShowGearSets = components.showGearSets:GetChecked()
	config.Binding.ShowGearSetsAsIcon = components.showGearSetsAsIcon:GetChecked()
	config.Binding.ShowBoA = components.showBoA:GetChecked()
	config.Binding.ShowBoE = components.showBoE:GetChecked()
	
	config.Icon.Position = UIDropDownMenu_GetSelectedValue(components.mogIconPosition)

	config.Icon.ShowLearnable.BankAndBags = components.showLearnableOnBags:GetChecked()
	config.Icon.ShowLearnable.GuildBank = components.showLearnableOnGuildBank:GetChecked()
	config.Icon.ShowLearnable.Merchant = components.showLearnableOnMerchant:GetChecked()

	config.Icon.ShowLearnableByOther.BankAndBags = components.showLearnableOtherOnBags:GetChecked()
	config.Icon.ShowLearnableByOther.GuildBank = components.showLearnableOtherOnGuildBank:GetChecked()
	config.Icon.ShowLearnableByOther.Merchant = components.showLearnableOtherOnMerchant:GetChecked()

	config.Icon.ShowSellable.BankAndBags = components.showSellableOnBags:GetChecked()
	config.Icon.ShowSellable.GuildBank = components.showSellableOnGuildBank:GetChecked()

	config.Icon.EnableAnimation = components.mogIconShowAnimation:GetChecked()
	config.Icon.ShowLearnable.SameLookDifferentItem = components.mogIconShowSameLookDifferentItem:GetChecked()
end

function configFrame:OnConfigLoaded()
	self:ApplyConfig(CaerdonWardrobeConfig)

	self.name = "|cff00ff00[背包]|r幻化提示"
	self.okay = PropagateErrors(self.OnSave)
	self.cancel = PropagateErrors(self.OnCancel)
	self.default = PropagateErrors(self.OnResetToDefaults)
	self.refresh = PropagateErrors(self.OnRefresh)

	InterfaceOptions_AddCategory(self)
end

function configFrame:OnSave()
	self:UpdatePendingValues()
	CaerdonWardrobeConfig = CopyTable(pendingConfig)
end

function configFrame:OnCancel()
	self:ApplyConfig(CaerdonWardrobeConfig)
end

function configFrame:OnResetToDefaults()
	self:ApplyConfig(CaerdonWardrobeNS:GetDefaultConfig())
end

function configFrame:OnRefresh()
	self:RefreshComponents()
end

configFrame:InitializeConfig()]]

-----------------------------------------for Combuctor
local isBagUpdateRequested = false
local waitingOnBagUpdate = {}
local atGuild = false

local Version = nil
if select(4, GetAddOnInfo('Combuctor')) then
	Version = GetAddOnMetadata('Combuctor', 'Version')
	CaerdonWardrobe:RegisterAddon('Combuctor', { isBags = true, hookDefaultBags = true })
end

if Version then

	local function OnBagUpdate_Coroutine()
	    for bag, bagData in pairs(waitingOnBagUpdate) do
	    	for slot, slotData in pairs(bagData) do
	    		for itemID, itemData in pairs(slotData) do
					CaerdonWardrobe:UpdateButton(itemData.itemID, itemData.bag, itemData.slot, itemData.button, { showMogIcon = true, showBindStatus = true, showSellables = true } )
	    		end
	    	end

			waitingOnBagUpdate[bag] = nil
	    end

		waitingOnBagUpdate = {}
	end

	local function ScheduleItemUpdate(itemID, bag, slot, button)
		local waitBag = waitingOnBagUpdate[tostring(bag)]
		if not waitBag then
			waitBag = {}
			waitingOnBagUpdate[tostring(bag)] = waitBag
		end

		local waitSlot = waitBag[tostring(slot)]
		if not waitSlot then
			waitSlot = {}
			waitBag[tostring(slot)] = waitSlot
		end

		waitSlot[tostring(itemID)] = { itemID = itemID, bag = bag, slot = slot, button = button }
		isBagUpdateRequested = true
	end

	local function OnUpdateSlot(self)
		-- if not self:IsCached() then
			local bag, slot = self:GetBag(), self:GetID()

			if bag ~= "vault" then
				local tab = GetCurrentGuildBankTab()
				if atGuild and tab == bag then
					local itemLink = GetGuildBankItemLink(tab, slot)
					if itemLink then
						local itemID = tonumber(itemLink:match("item:(%d+)"))
						bag = "GuildBankFrame"
						slot = { tab = tab, index = slot }
						ScheduleItemUpdate(itemID, bag, slot, self)
					else
						CaerdonWardrobe:ClearButton(self)
					end
				else
					local itemID = GetContainerItemID(bag, slot)
					if itemID then
						ScheduleItemUpdate(itemID, bag, slot, self)
					else
						CaerdonWardrobe:ClearButton(self)
					end
				end
			end
		-- end
	end

	local function OnEvent(self, event, ...)
		local handler = self[event]
		if(handler) then
			handler(self, ...)
		end
	end

	local timeSinceLastBagUpdate = nil
	local BAGUPDATE_INTERVAL = 0.3

	local function OnUpdate(self, elapsed)
		if(self.bagUpdateCoroutine) then
			if coroutine.status(self.bagUpdateCoroutine) ~= "dead" then
				local ok, result = coroutine.resume(self.bagUpdateCoroutine)
				if not ok then
					error(result)
				end
			else
				self.bagUpdateCoroutine = nil
			end
			return
		end

		if isBagUpdateRequested then
			isBagUpdateRequested = false
			timeSinceLastBagUpdate = 0
		elseif timeSinceLastBagUpdate then
			timeSinceLastBagUpdate = timeSinceLastBagUpdate + elapsed
		end

		if( timeSinceLastBagUpdate ~= nil and (timeSinceLastBagUpdate > BAGUPDATE_INTERVAL) ) then
			timeSinceLastBagUpdate = nil
			self.bagUpdateCoroutine = coroutine.create(OnBagUpdate_Coroutine)
		end
	end


	local function HookCombuctor()
		hooksecurefunc(Combuctor.Item, "Update", OnUpdateSlot)
	end

	local CaerdonWardrobeFrame = CreateFrame("FRAME")

	CaerdonWardrobeFrame:SetScript("OnEvent", OnEvent)
	CaerdonWardrobeFrame:SetScript("OnUpdate", OnUpdate)
	-- CaerdonWardrobeFrame:RegisterEvent("TRANSMOG_COLLECTION_ITEM_UPDATE")

	HookCombuctor()

	function CaerdonWardrobeFrame:ADDON_LOADED(name)
	end

	function CaerdonWardrobeFrame:TRANSMOG_COLLECTION_ITEM_UPDATE()
	    if Combuctor.sets then
	        Combuctor:UpdateFrames()
	    end
	end

	function CaerdonWardrobeFrame:GUILDBANKFRAME_OPENED()
		atGuild = true
	end

	function CaerdonWardrobeFrame:GUILDBANKFRAME_CLOSED()
		atGuild = false
	end

end