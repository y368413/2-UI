local _, ns = ...
local M, R, U, I = unpack(ns)

tinsert(R.defaultThemes, function()
	-- [[ Item buttons ]]
	local function UpdateCorruption(self)
		local itemLink = GetInventoryItemLink("player", self:GetID())
		self.IconOverlay:SetShown(itemLink and IsCorruptedItem(itemLink))
	end

	local slots = {"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand", "SecondaryHand", "Tabard",}

	for i = 1, #slots do
		local slot = _G["Character"..slots[i].."Slot"]
		--slot.IconBorder:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\WhiteIconFrame")
		--slot.ignoreTexture:SetTexture("Interface\\PaperDollInfoFrame\\UI-GearManager-LeaveItem-Transparent")
		slot.CorruptedHighlightTexture:SetAtlas("Nzoth-charactersheet-item-glow")
		slot.IconOverlay:SetAtlas("Nzoth-inventory-icon")
		slot.IconOverlay:SetInside()
		--hooksecurefunc(slot.IconBorder, "SetTexture", function() slot:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\WhiteIconFrame") end)
	end

	hooksecurefunc("PaperDollItemSlotButton_Update", function(button) UpdateCorruption(button) end)
end)

hooksecurefunc("SetItemButtonQuality", function(button, quality, itemIDOrLink, suppressOverlays)
	if itemIDOrLink then
		if IsArtifactRelicItem(itemIDOrLink) then
			button.IconBorder:SetTexture("Interface\\Artifacts\\RelicIconFrame");
		else
			button.IconBorder:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\WhiteIconFrame");
		end
		
		if not suppressOverlays and C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemIDOrLink) then
			button.IconOverlay:SetAtlas("AzeriteIconFrame");
			button.IconOverlay:Show();
		else
			button.IconOverlay:Hide();
		end
	else
		button.IconBorder:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\WhiteIconFrame");
		button.IconOverlay:Hide();
	end

	if quality then
		if quality >= LE_ITEM_QUALITY_COMMON and BAG_ITEM_QUALITY_COLORS[quality] then
			button.IconBorder:Show();
			button.IconBorder:SetVertexColor(BAG_ITEM_QUALITY_COLORS[quality].r, BAG_ITEM_QUALITY_COLORS[quality].g, BAG_ITEM_QUALITY_COLORS[quality].b);
		else
			button.IconBorder:Hide();
		end
	else
		button.IconBorder:Hide();
	end
end)