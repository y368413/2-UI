CaerdonItem = {}
CaerdonItemMixin = {}

local version, build, date, tocversion = GetBuildInfo()
local isShadowlands = tonumber(build) > 35700

-- Should not be translated - used to provide me with screenshots for debugging.
CaerdonItemType = {
    Empty = "Empty",
    Unknown = "Unknown",
    Unhandled = "Unhandled",
    BattlePet = "Battle Pet", -- pets that have been caged
    CompanionPet = "Companion Pet", -- unlearned pets
    Conduit = "Conduit",
    Consumable = "Consumable",
    Currency = "Currency",
    Equipment = "Equipment",
    Mount = "Mount",
    Recipe = "Recipe",
    Quest = "Quest",
    Toy = "Toy"
}

CaerdonItemBind = {
    None = "None",
    BindOnPickup = "Bind on Pickup",
    BindOnEquip = "Bind on Equip",
    BindOnUse = "Bind on Use",
    QuestItem = "Quest Item",
	Unknown = "Unknown",
}

local function CreateItem()
    return CreateFromMixins(
        ItemMixin,
        CaerdonItemMixin
    )
end

--[[static]] function CaerdonItem:CreateFromItemLink(itemLink)
	if type(itemLink) ~= "string" then
		error("Usage: CaerdonItem:CreateFromItemLink(itemLinkString)", 2);
	end

    local item = CreateItem()
    item:SetItemLink(itemLink)    
	return item;
end

--[[static]] function CaerdonItem:CreateFromItemID(itemIDCheck)
    local itemID = tonumber(itemIDCheck)
	if type(itemID) ~= "number" then
		error("Usage: CaerdonItem:CreateFromItemID(itemID)", 2);
    end
    
    local item = CreateItem()
    item:SetItemID(itemID)
    return item;
end

--[[static]] function CaerdonItem:CreateFromItemLocation(itemLocation)
	if type(itemLocation) ~= "table" or type(itemLocation.HasAnyLocation) ~= "function" or not itemLocation:HasAnyLocation() then
		error("Usage: Item:CreateFromItemLocation(notEmptyItemLocation)", 2);
	end
	local item = CreateItem()
	item:SetItemLocation(itemLocation);
	return item;
end

--[[static]] function CaerdonItem:CreateFromBagAndSlot(bagID, slotIndex)
	if type(bagID) ~= "number" or type(slotIndex) ~= "number" then
		error("Usage: Item:CreateFromBagAndSlot(bagID, slotIndex)", 2);
	end
	local item = CreateItem()
	item:SetItemLocation(ItemLocation:CreateFromBagAndSlot(bagID, slotIndex));
	return item;
end

--[[static]] function CaerdonItem:CreateFromEquipmentSlot(equipmentSlotIndex)
	if type(equipmentSlotIndex) ~= "number" then
		error("Usage: Item:CreateFromEquipmentSlot(equipmentSlotIndex)", 2);
	end
	local item = CreateItem()
	item:SetItemLocation(ItemLocation:CreateFromEquipmentSlot(equipmentSlotIndex));
	return item;
end

--[[static]] function CaerdonItem:CreateFromSpeciesInfo(speciesID, level, quality, health, power, speed, customName, petID)
    -- TODO: This is a terrible hack until Blizzard gives me more to work with (mostly for tooltips where I don't have an itemLink).
	if type(speciesID) ~= "number" then
		error("Usage: CaerdonItem:CreateFromSpeciesInfo(speciesID, level, quality, health, power, speed, customName, petID)", 2);
	end

    local name, _, _, _, _, _, _, _, _, _, _, displayID = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
    local itemLink = format("|cff0070dd|Hbattlepet:%d:%d:%d:%d:%d:%d:%x:%d|h[%s]|h|r", speciesID, level, quality, health, power, speed, petID or 0, displayID, customName or name)
    return CaerdonItem:CreateFromItemLink(itemLink)
end

function CaerdonItemMixin:Clear()
    ItemMixin.Clear(self)
    self.caerdonItemType = nil
    self.caerdonItemData = nil
end

-- Add a callback to be executed when item data is loaded, if the item data is already loaded then execute it immediately
function CaerdonItemMixin:ContinueOnItemLoad(callbackFunction)
    if type(callbackFunction) ~= "function" or self:IsItemEmpty() then
        error("Usage: NonEmptyItem:ContinueOnLoad(callbackFunction)", 2);
    end

    ItemEventListener:AddCallback(self:GetItemID(), function ()
        -- TODO: Update things and delay callback if needed for tooltip data
        -- Make sure any dependent data is loaded
        local itemData = self:GetItemData()

        -- Allows for override of continue return if additional data needs to get loaded from a specific mixin (i.e. equipment sources)
        if itemData then
            itemData:ContinueOnItemDataLoad(callbackFunction)
        else
            callbackFunction()
        end
    end);
end

-- Same as ContinueOnItemLoad, except it returns a function that when called will cancel the continue
function CaerdonItemMixin:ContinueWithCancelOnItemLoad(callbackFunction)
    if type(callbackFunction) ~= "function" or self:IsItemEmpty() then
        error("Usage: NonEmptyItem:ContinueWithCancelOnItemLoad(callbackFunction)", 2);
    end

    local itemDataCancel
    local itemCancel = ItemEventListener:AddCancelableCallback(self:GetItemID(), function ()
        -- TODO: Update things and delay callback if needed for tooltip data
        local itemData = self:GetItemData()
        if itemData then
            itemDataCancel = itemData:ContinueWithCancelOnItemDataLoad(callbackFunction)
        else
            callbackFunction()
        end
    end);

    return function()
        if itemDataCancel then
            itemDataCancel()
        end

        itemCancel()
    end;
end

function CaerdonItemMixin:SetItemLink(itemLink)
    ItemMixin.SetItemLink(self, itemLink)
end

function CaerdonItemMixin:SetItemID(itemID)
    -- Used for embedded item tooltip rewards
    ItemMixin.SetItemID(self, itemID)
end

-- local itemID, itemType, itemSubType, itemEquipLoc, icon, itemTypeID, itemSubClassID = GetItemInfoInstant(self:GetStaticBackingItem())

-- TODO: Find lint rule - always need parens around select to reduce to single value
function CaerdonItemMixin:GetItemType()
    if not self:IsItemEmpty() then
        return (select(2, GetItemInfoInstant(self:GetItemID())))
    end
end

function CaerdonItemMixin:GetItemSubType()
    if not self:IsItemEmpty() then
        return (select(3, GetItemInfoInstant(self:GetItemID())))
    end
end

function CaerdonItemMixin:GetEquipLocation()
    if not self:IsItemEmpty() then
        local equipLocation = (select(4, GetItemInfoInstant(self:GetItemID())))
        if equipLocation == "" then
            return nil
        end
        return equipLocation
    end

    return nil
end

function CaerdonItemMixin:GetItemTypeID()
    if not self:IsItemEmpty() then
        return (select(6, GetItemInfoInstant(self:GetItemID())))
    end
end

function CaerdonItemMixin:GetItemSubTypeID()
    if not self:IsItemEmpty() then
        return (select(7, GetItemInfoInstant(self:GetItemID())))
    end
end

function CaerdonItemMixin:GetHasUse() -- requires item data to be loaded
    if not self:IsItemEmpty() then
        local spellName, spellID = GetItemSpell(self:GetItemID())
        return spellID ~= nil
    end
end

-- local itemName, itemLinkInfo, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
-- itemEquipLoc, iconFileDataID, itemSellPrice, itemTypeID, itemSubTypeID, bindType, expacID, itemSetID, 
-- isCraftingReagent = GetItemInfo(self:GetItemLink())
function CaerdonItemMixin:GetMinLevel() -- requires item data to be loaded
    if not self:IsItemEmpty() then
        return (select(5, GetItemInfo(self:GetItemLink())))
    end
end

function CaerdonItemMixin:GetBinding() -- requires item data to be loaded
    if not self:IsItemEmpty() then
        local bindType = (select(14, GetItemInfo(self:GetItemLink())))

        local binding = CaerdonItemBind.Unknown
        if bindType == 0 then
            binding = CaerdonItemBind.None
        elseif bindType == 1 then -- BoP
            binding = CaerdonItemBind.BindOnPickup
        elseif bindType == 2 then -- BoE
            binding = CaerdonItemBind.BindOnEquip
        elseif bindType == 3 then -- BoU
            binding = CaerdonItemBind.BindOnUse
        elseif bindType == 4 then -- Quest
            binding = CaerdonItemBind.QuestItem
        end

        return binding
    end
end

function CaerdonItemMixin:HasItemLocationBankOrBags()
    local itemLocation = self:GetItemLocation()
    if itemLocation and itemLocation:IsBagAndSlot() then
        return true
    else
        return false
    end
end

function CaerdonItemMixin:IsSoulbound()
    if self:IsItemInPlayersControl() then
        return C_Item.IsBound(self:GetItemLocation())
    else
        return false
    end
end

function CaerdonItemMixin:GetExpansionID() -- requires item data to be loaded
    if not self:IsItemEmpty() then
        return (select(15, GetItemInfo(self:GetItemLink())))
    end
end

function CaerdonItemMixin:GetSetID()
    if not self:IsItemEmpty() then
        return (select(16, GetItemInfo(self:GetItemLink())))
    end
end

function CaerdonItemMixin:GetIsCraftingReagent()  -- requires item data to be loaded
    if not self:IsItemEmpty() then
        return (select(17, GetItemInfo(self:GetItemLink())))
    else
        return false
    end
end

function IsUnhandledType(typeID, subTypeID)
    return typeID == Enum.ItemClass.Container or
        typeID == Enum.ItemClass.Gem or
        typeID == Enum.ItemClass.Reagent or
        typeID == Enum.ItemClass.Projectile or
        typeID == Enum.ItemClass.Tradegoods or
        typeID == Enum.ItemClass.ItemEnhancement or
        typeID == Enum.ItemClass.Quiver or 
        typeID == Enum.ItemClass.Key or
        typeID == Enum.ItemClass.Glyph or
        typeID == Enum.ItemClass.WoWToken
end

function CaerdonItemMixin:GetCaerdonItemType()
    local itemLink = self:GetItemLink()
    if not itemLink then
        return CaerdonItemType.Empty
    end

    -- TODO: Keep an eye on this - caching type now that I'm handling ItemLocation may not be a good idea
    -- if I want to support swapping the item out
    if not self.caerdonItemType then
        local caerdonType = CaerdonItemType.Unknown
        local linkType, linkOptions, displayText = LinkUtil.ExtractLink(itemLink)
        local typeID = self:GetItemTypeID()
        local subTypeID = self:GetItemSubTypeID()

        local toylink = typeID and C_ToyBox.GetToyLink(self:GetItemID())
        local isConduit = isShadowlands and C_Soulbinds.IsItemConduitByItemInfo(itemLink)

        if toylink then
            caerdonType = CaerdonItemType.Toy
        elseif isConduit then
            caerdonType = CaerdonItemType.Conduit
        elseif linkType == "item" then
            -- TODO: Switching to just checking type for equipment 
            -- instead of using GetEquipLocation (since containers are equippable)
            -- Keep an eye on this
            if IsUnhandledType(typeID, subTypeID) then
                caerdonType = CaerdonItemType.Unhandled
            elseif typeID == Enum.ItemClass.Armor or typeID == Enum.ItemClass.Weapon then
                caerdonType = CaerdonItemType.Equipment
            elseif typeID == Enum.ItemClass.Battlepet then
                caerdonType = CaerdonItemType.BattlePet
            elseif typeID == Enum.ItemClass.Consumable then
                caerdonType = CaerdonItemType.Consumable
            elseif typeID == Enum.ItemClass.Miscellaneous then
                if subTypeID == Enum.ItemMiscellaneousSubclass.CompanionPet then
                    local name, icon, petType, creatureID, sourceText, description, isWild, canBattle, isTradeable, isUnique, isObtainable, displayID, speciesID = C_PetJournal.GetPetInfoByItemID(self:GetItemID());
                    if creatureID and displayID then
                        caerdonType = CaerdonItemType.CompanionPet
                    else
                        caerdonType = CaerdonItemType.Unhandled
                    end
                elseif subTypeID == Enum.ItemMiscellaneousSubclass.Mount or subTypeID == Enum.ItemMiscellaneousSubclass.MountEquipment then
                    caerdonType = CaerdonItemType.Mount
                else
                    caerdonType = CaerdonItemType.Unhandled
                end
            elseif typeID == Enum.ItemClass.Questitem then
                caerdonType = CaerdonItemType.Quest
            elseif typeID == Enum.ItemClass.Recipe then
                caerdonType = CaerdonItemType.Recipe
            end
        elseif linkType == "battlepet" then
            caerdonType = CaerdonItemType.BattlePet
        elseif linkType == "quest" then
            caerdonType = CaerdonItemType.Quest
        elseif linkType == "currency" then
            caerdonType = CaerdonItemType.Currency
        end

        self.caerdonItemType = caerdonType
    end

    return self.caerdonItemType
end

function CaerdonItemMixin:GetItemData()
    if not self.caerdonItemData then
        local caerdonType = self:GetCaerdonItemType()

        if caerdonType == CaerdonItemType.BattlePet then
            self.caerdonItemData = CaerdonBattlePet:CreateFromCaerdonItem(self)
        elseif caerdonType == CaerdonItemType.CompanionPet then
            self.caerdonItemData = CaerdonCompanionPet:CreateFromCaerdonItem(self)
        elseif caerdonType == CaerdonItemType.Conduit then
            self.caerdonItemData = CaerdonConduit:CreateFromCaerdonItem(self)
        elseif caerdonType == CaerdonItemType.Consumable then
            self.caerdonItemData = CaerdonConsumable:CreateFromCaerdonItem(self)
        elseif caerdonType == CaerdonItemType.Equipment then
            self.caerdonItemData = CaerdonEquipment:CreateFromCaerdonItem(self)
        elseif caerdonType == CaerdonItemType.Mount then
            self.caerdonItemData = CaerdonMount:CreateFromCaerdonItem(self)
        elseif caerdonType == CaerdonItemType.Quest then
            self.caerdonItemData = CaerdonQuest:CreateFromCaerdonItem(self)
        elseif caerdonType == CaerdonItemType.Recipe then
            self.caerdonItemData = CaerdonRecipe:CreateFromCaerdonItem(self)
        elseif caerdonType == CaerdonItemType.Toy then
            self.caerdonItemData = CaerdonToy:CreateFromCaerdonItem(self)
        end
    end
    
    return self.caerdonItemData
end


local CaerdonAPIMixin = {}
CaerdonAPI = {}

StaticPopupDialogs.CopyLinkPopup = {
    text = "Item Link String",
	button1 = OKAY,
    OnAccept = function(self)
        local linkText = self.editBox:GetText()
        local selectedLink = gsub(linkText, "\124\124", "\124")
        print(selectedLink)
    end,
    hasEditBox = true,
    enterClicksFirstButton = true,  -- TODO: Not sure why these aren't working ... might need OnKeyDown?
	whileDead = true,
	hideOnEscape = true
}

function CaerdonAPIMixin:OnLoad()
end

function CaerdonAPIMixin:CopyMouseoverLink()
    local link = select(2, GameTooltip:GetItem())
    self:CopyLink(link)
end

function CaerdonAPIMixin:GetItemDetails(item)
    local itemData = item:GetItemData()
    local itemResults
    local caerdonType = item:GetCaerdonItemType()

    if caerdonType == CaerdonItemType.BattlePet then
        itemResults = itemData:GetBattlePetInfo()
    elseif caerdonType == CaerdonItemType.CompanionPet then
        itemResults = itemData:GetCompanionPetInfo()
    elseif caerdonType == CaerdonItemType.Equipment then
            itemResults = itemData:GetTransmogInfo()
    elseif caerdonType == CaerdonItemType.Quest then
        itemResults = itemData:GetQuestInfo()
    end

    return {
        itemResults = itemResults
    }
end

function CaerdonAPIMixin:DumpMouseoverLinkDetails()
    local link = select(2, GameTooltip:GetItem())
end

function CaerdonAPIMixin:CopyLink(itemLink)
    if not itemLink then return end

    local dialog = StaticPopup_Show("CopyLinkPopup")
    dialog.editBox:SetText(gsub(itemLink, "\124", "\124\124"))
    dialog.editBox:HighlightText()
end

function CaerdonAPIMixin:MergeTable(destination, source)
    for k,v in pairs(source) do destination[k] = v end
    return destination
end

-- Leveraging canEquip for now
-- function CaerdonAPIMixin:GetClassArmor()
--     local playerClass, englishClass = UnitClass("player");
--     if (englishClass == "ROGUE" or englishClass == "DRUID" or englishClass == "MONK" or englishClass == "DEMONHUNTER") then
--         classArmor = Enum.ItemArmorSubclass.Leather;
--     elseif (englishClass == "WARRIOR" or englishClass == "PALADIN" or englishClass == "DEATHKNIGHT") then
--         classArmor = Enum.ItemArmorSubclass.Plate;
--     elseif (englishClass == "MAGE" or englishClass == "PRIEST" or englishClass == "WARLOCK") then
--         classArmor = Enum.ItemArmorSubclass.Cloth;
--     elseif (englishClass == "SHAMAN" or englishClass == "HUNTER") then
--         classArmor = Enum.ItemArmorSubclass.Mail;
--     end

--     return classArmor
-- end

CaerdonAPI = CreateFromMixins(CaerdonAPIMixin)
CaerdonAPI:OnLoad()


local CombuctorMixin = {}

function CombuctorMixin:GetName()
    return "Combuctor"
end

function CombuctorMixin:Init()
	hooksecurefunc(Combuctor.Item, "Update", function(...) self:OnUpdateSlot(...) end)
end

function CombuctorMixin:SetTooltipItem(tooltip, item, locationInfo)
	if locationInfo.isOffline then
		if not item:IsItemEmpty() then
			tooltip:SetHyperlink(item:GetItemLink())
		end
	elseif not item:HasItemLocationBankOrBags() then
		local speciesID, level, breedQuality, maxHealth, power, speed, name = tooltip:SetGuildBankItem(locationInfo.tab, locationInfo.index)
	elseif locationInfo.bag == BANK_CONTAINER then
		local hasItem, hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = tooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(locationInfo.slot))
	else
		local hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = tooltip:SetBagItem(locationInfo.bag, locationInfo.slot)
	end
end

function CombuctorMixin:Refresh()
	Combuctor.Frames:Update()
end

function CombuctorMixin:GetDisplayInfo(button, item, feature, locationInfo, options, mogStatus, bindingStatus)
	if locationInfo.isOffline then
		local showBindingStatus = true
		local showOwnIcon = true
		local showOtherIcon = true
		local showSellableIcon = true
	
		return {
			bindingStatus = {
				shouldShow = showBindingStatus
			},
			ownIcon = {
				shouldShow = showOwnIcon
			},
			otherIcon = {
				shouldShow = showOtherIcon
			},
			sellableIcon = {
				shouldShow = showSellableIcon
			}
		}
	elseif not item:HasItemLocationBankOrBags() then
		return {
			bindingStatus = {
				shouldShow = true
			},
			ownIcon = {
				shouldShow = true
			},
			otherIcon = {
				shouldShow = true
			},
			sellableIcon = {
				shouldShow = true
			}
		}
	else
		return {}
	end
end

function CombuctorMixin:OnUpdateSlot(button)
	local bag, slot = button:GetBag(), button:GetID()
	if button.info.cached then
		if button.info.link then
			local item = CaerdonItem:CreateFromItemLink(button.info.link)
			CaerdonWardrobe:UpdateButton(button, item, self, {
				locationKey = format("bag%d-slot%d", bag, slot),
				isOffline = true
			}, { showMogIcon = true, showBindStatus = true, showSellables = true } )
		else
			CaerdonWardrobe:ClearButton(button)
		end
	else
		if bag ~= "vault" then
			local tab = GetCurrentGuildBankTab()
			if Combuctor:InGuild() and tab == bag then
				local itemLink = GetGuildBankItemLink(tab, slot)
				if itemLink then
					local item = CaerdonItem:CreateFromItemLink(itemLink)
					CaerdonWardrobe:UpdateButton(button, item, self, {
						locationKey = format("tab%d-index%d", tab, slot),
						tab = tab,
						index = slot
					}, { showMogIcon = true, showBindStatus = true, showSellables = true } )
				else
					CaerdonWardrobe:ClearButton(button)
				end
			else
				local item = CaerdonItem:CreateFromBagAndSlot(bag, slot)
				CaerdonWardrobe:UpdateButton(button, item, self, { bag = bag, slot = slot }, { showMogIcon = true, showBindStatus = true, showSellables = true } )
			end
		end
	end
end

local Version = nil
local isActive = false
if select(4, GetAddOnInfo("Combuctor")) then
	if IsAddOnLoaded("Combuctor") then
		Version = GetAddOnMetadata("Combuctor", "Version")
		CaerdonWardrobe:RegisterFeature(CombuctorMixin)
		isActive = true
	end
end

WagoAnalytics:Switch(addonName, isActive)
