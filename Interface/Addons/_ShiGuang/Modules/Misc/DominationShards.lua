local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")
local TT = M:GetModule("Tooltip")

local wipe, pairs, mod, floor = wipe, pairs, mod, floor
local InCombatLockdown = InCombatLockdown
local PickupContainerItem, ClickSocketButton, ClearCursor = PickupContainerItem, ClickSocketButton, ClearCursor
local GetContainerNumSlots, GetContainerItemID, GetContainerItemLink = GetContainerNumSlots, GetContainerItemID, GetContainerItemLink
local GetItemIcon, GetItemCount, GetSocketTypes, GetExistingSocketInfo = GetItemIcon, GetItemCount, GetSocketTypes, GetExistingSocketInfo

local EXTRACTOR_ID = 187532
local foundShards = {}

function MISC:DomiShard_Equip()
	if not self.itemLink then return end

	PickupContainerItem(self.bagID, self.slotID)
	ClickSocketButton(1)
	ClearCursor()
end

function MISC:DomiShard_ShowTooltip()
	if not self.itemLink then return end

	GameTooltip:ClearLines()
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
	GameTooltip:SetHyperlink(self.itemLink)
	GameTooltip:Show()
end

function MISC:DomiShards_Refresh()
	wipe(foundShards)

	for bagID = 0, 4 do
		for slotID = 1, GetContainerNumSlots(bagID) do
			local itemID = GetContainerItemID(bagID, slotID)
			local rank = itemID and TT.DomiRankData[itemID]
			if rank then
				local index = TT.DomiIndexData[itemID]
				if not index then break end

				local button = MISC.DomiShardsFrame.icons[index]
				button.bagID = bagID
				button.slotID = slotID
				button.itemLink = GetContainerItemLink(bagID, slotID)
				button.count:SetText(rank)
				button.Icon:SetDesaturated(false)

				foundShards[index] = true
			end
		end
	end

	for index, button in pairs(MISC.DomiShardsFrame.icons) do
		if not foundShards[index] then
			button.itemLink = nil
			button.count:SetText("")
			button.Icon:SetDesaturated(true)
		end
	end
end

function MISC:DomiShards_ListFrame()
	if MISC.DomiShardsFrame then return end

	local iconSize = 28
	local frameSize = iconSize*3

	local frame = CreateFrame("Frame", "UIDomiShards", ItemSocketingFrame)
	frame:SetSize(frameSize, frameSize)
	frame:SetPoint("BOTTOMLEFT", 32, 3)
	frame.icons = {}
	MISC.DomiShardsFrame = frame

	for index, value in pairs(TT.DomiDataByGroup) do
		for itemID in pairs(value) do
			local button = CreateFrame("Button", nil, frame)
			button:SetSize(iconSize, iconSize)
			button:SetPoint("TOPLEFT", mod(index-1, 3)*iconSize, - floor((index-1)/3)*iconSize)
			M.PixelIcon(button, GetItemIcon(itemID), true)
			button:SetScript("OnClick", MISC.DomiShard_Equip)
			button:SetScript("OnEnter", MISC.DomiShard_ShowTooltip)
			button:SetScript("OnLeave", M.HideTooltip)
			button.count = M.CreateFS(button, 14, "", "system", "BOTTOMRIGHT", -3, 3)

			frame.icons[index] = button
			break
		end
	end

	MISC:DomiShards_Refresh()
	M:RegisterEvent("BAG_UPDATE", MISC.DomiShards_Refresh)
end

function MISC:DomiShards_ExtractButton()
	if MISC.DomiExtButton then return end

	if GetItemCount(EXTRACTOR_ID) == 0 then return end
	ItemSocketingSocketButton:SetWidth(80)
	if InCombatLockdown() then return end

	local button = CreateFrame("Button", "UIExtractorButton", ItemSocketingFrame, "UIPanelButtonTemplate, SecureActionButtonTemplate")
	button:SetSize(80, 22)
	button:SetText(U["Drop"])
	button:SetPoint("RIGHT", ItemSocketingSocketButton, "LEFT", -3, 0)
	button:SetAttribute("type", "macro")
	button:SetAttribute("macrotext", "/use item:"..EXTRACTOR_ID.."\n/click ItemSocketingSocket1")
	--if R.db["Skins"]["BlizzardSkins"] then M.Reskin(button) end

	MISC.DomiExtButton = button
end

function MISC:DominationShards()
	hooksecurefunc("ItemSocketingFrame_LoadUI", function()
		if not ItemSocketingFrame then return end

		MISC:DomiShards_ListFrame()
		MISC:DomiShards_ExtractButton()

		if MISC.DomiShardsFrame then
			MISC.DomiShardsFrame:SetShown(GetSocketTypes(1) == "Domination" and not GetExistingSocketInfo(1))
		end

		if MISC.DomiExtButton then
			MISC.DomiExtButton:SetAlpha(GetSocketTypes(1) == "Domination" and GetExistingSocketInfo(1) and 1 or 0)
		end
	end)
end
MISC:RegisterMisc("DomiShards", MISC.DominationShards)