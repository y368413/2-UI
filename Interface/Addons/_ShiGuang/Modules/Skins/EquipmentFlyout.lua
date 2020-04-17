local _, ns = ...
local M, R, U, I = unpack(ns)
local S = M:GetModule("Skins")

tinsert(R.defaultThemes, function()
	hooksecurefunc("EquipmentFlyout_CreateButton", function()
		local button = EquipmentFlyoutFrame.buttons[#EquipmentFlyoutFrame.buttons]
		if not button.Eye then
			button.Eye = button:CreateTexture()
			button.Eye:SetAtlas("Nzoth-inventory-icon")
			button.Eye:SetInside()
		end
	end)

	local function UpdateCorruption(button, location)
		local _, _, bags, voidStorage, slot, bag = EquipmentManager_UnpackLocation(location)
		if voidStorage then
			button.Eye:Hide()
			return
		end

		local itemLink
		if bags then
			itemLink = GetContainerItemLink(bag, slot)
		else
			itemLink = GetInventoryItemLink("player", slot)
		end
		button.Eye:SetShown(itemLink and IsCorruptedItem(itemLink))
	end

	hooksecurefunc("EquipmentFlyout_DisplayButton", function(button)
		local location = button.location
		if not location then return end
		UpdateCorruption(button, location)
	end)
end)