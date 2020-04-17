--[[
	sortButton.lua
		A style agnostic item sorting button
--]]

local ADDON, Addon = ...
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
local SortButton = Addon.Tipped:NewClass('SortButton', 'CheckButton', true)


--[[ Construct ]]--

function SortButton:New(...)
	local b = self:Super(SortButton):New(...)
	b:RegisterSignal('SORTING_STATUS')
	b:SetScript('OnClick', b.OnClick)
	b:SetScript('OnEnter', b.OnEnter)
	b:SetScript('OnLeave', b.OnLeave)
	b:RegisterForClicks('anyUp')
	return b
end

function SortButton:SORTING_STATUS(_,_, bags)
	self:SetChecked(self:GetParent().Bags == bags)
end


--[[ Interaction ]]--

function SortButton:OnClick(button)
	self:SetChecked(nil)
	if IsControlKeyDown() and DepositReagentBank then return DepositReagentBank() end
	local frame = self:GetParent()
	if not frame:IsCached() then
		---------------Thanks Siweia  么么哒·~~~~
		if button == 'RightButton' then
		  SetSortBagsRightToLeft(false)      --整理向左边背包移动
		  --SetInsertItemsLeftToRight(false)  --新增物品自动进入最右边背包
			frame:SortItems()  --SortBags()
		  C_Timer.After(.3, function()
			for bag = 0, 4 do
				for slot = 1, GetContainerNumSlots(bag) do
					local texture, _, locked = GetContainerItemInfo(bag, slot)
					if texture and not locked then
						_G.PickupContainerItem(bag, slot)
						_G.PickupContainerItem(bag, GetContainerNumSlots(bag)+1 - slot)
					end
				end
			end
		  end)
		else
		  SetSortBagsRightToLeft(true)      --整理向左边背包移动
		  --SetInsertItemsLeftToRight(true)  --新增物品自动进入最左边背包
		  frame:SortItems()   --SortBags()
		end
	end
end

function SortButton:OnEnter()
	GameTooltip:SetOwner(self:GetTipAnchor())

	if DepositReagentBank then
		GameTooltip:SetText(BAG_FILTER_CLEANUP)
		GameTooltip:AddLine(L.TipCleanItems:format(L.LeftClick), 1,1,1)
		GameTooltip:AddLine(L.TipDepositReagents:format(L.RightClick), 1,1,1)
	else
		GameTooltip:SetText(L.TipCleanItems:format(L.Click))
	end

	GameTooltip:Show()
end
