local _, ns = ...
local M, R, U, I = unpack(ns)

local function NoTaintArrow(self, direction) -- needs review
	M.StripTextures(self)

	local tex = self:CreateTexture(nil, "ARTWORK")
	tex:SetAllPoints()
	M.SetupArrow(tex, direction)
	self.__texture = tex

	self:HookScript("OnEnter", M.Texture_OnEnter)
	self:HookScript("OnLeave", M.Texture_OnLeave)
end

tinsert(R.defaultThemes, function()
	local r, g, b = I.r, I.g, I.b
	-- [[ Item buttons ]]
	local function colourPopout(self)
		local aR, aG, aB
		local glow = self:GetParent().IconBorder

		if glow:IsShown() then
			aR, aG, aB = glow:GetVertexColor()
		else
			aR, aG, aB = r, g, b
		end

		self.arrow:SetVertexColor(aR, aG, aB)
	end

	local function clearPopout(self)
		self.arrow:SetVertexColor(1, 1, 1)
	end
	local function UpdateHighlight(self)
		local highlight = self:GetHighlightTexture()
		highlight:SetColorTexture(1, 1, 1, .25)
		highlight:SetInside(self.bg)
	end

	local function UpdateCosmetic(self)
		local itemLink = GetInventoryItemLink("player", self:GetID())
		self.IconOverlay:SetShown(itemLink and C_Item.IsCosmeticItem(itemLink))
	end

	local slots = {"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand", "SecondaryHand", "Tabard",}

	for i = 1, #slots do
		local slot = _G["Character"..slots[i].."Slot"]
		local cooldown = _G["Character"..slots[i].."SlotCooldown"]
		--slot.IconBorder:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\WhiteIconFrame")
		--slot.ignoreTexture:SetTexture("Interface\\PaperDollInfoFrame\\UI-GearManager-LeaveItem-Transparent")
		slot.IconOverlay:SetAtlas("CosmeticIconFrame")
		slot.IconOverlay:SetInside()
		local popout = slot.popoutButton
		--popout:SetNormalTexture(0)
		--popout:SetHighlightTexture(0)

		local arrow = popout:CreateTexture(nil, "OVERLAY")
		arrow:SetSize(14, 14)
		if slot.verticalFlyout then
			M.SetupArrow(arrow, "down")
			arrow:SetPoint("TOP", slot, "BOTTOM", 0, 1)
		else
			M.SetupArrow(arrow, "right")
			arrow:SetPoint("LEFT", slot, "RIGHT", -1, 0)
		end
		popout.arrow = arrow

		popout:HookScript("OnEnter", clearPopout)
		popout:HookScript("OnLeave", colourPopout)


	end

	hooksecurefunc("PaperDollItemSlotButton_Update", function(button)
		-- also fires for bag slots, we don't want that
		if button.popoutButton then
			button.icon:SetShown(GetInventoryItemTexture("player", button:GetID()) ~= nil)
			colourPopout(button.popoutButton)
		end
		UpdateCosmetic(button)
		UpdateHighlight(button)
	end)
	NoTaintArrow(TokenFrame.CurrencyTransferLogToggleButton, "right") -- taint control, needs review
end)