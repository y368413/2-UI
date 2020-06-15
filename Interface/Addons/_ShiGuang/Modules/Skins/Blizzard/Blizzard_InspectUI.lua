local _, ns = ...
local M, R, U, I = unpack(ns)

R.themes["Blizzard_InspectUI"] = function()
	local function UpdateCorruption(self)
		local unit = InspectFrame.unit
		local itemLink = unit and GetInventoryItemLink(unit, self:GetID())
		self.Eye:SetShown(itemLink and IsCorruptedItem(itemLink))
	end

	-- Character
	local slots = {
		"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand", "SecondaryHand", "Tabard",
	}

	for i = 1, #slots do
		local slot = _G["Inspect"..slots[i].."Slot"]
		if not slot.Eye then
			slot.Eye = slot:CreateTexture()
			slot.Eye:SetAtlas("Nzoth-inventory-icon")
			slot.Eye:SetInside()
		end
	end

	hooksecurefunc("InspectPaperDollItemSlotButton_Update", function(button)
		UpdateCorruption(button)
	end)
end