local _, ns = ...
local M, R, U, I = unpack(ns)
if not R.Infobar.Bags then return end

local module = M:GetModule("Infobar")
local info = module:RegisterInfobar("Bag", R.Infobar.BagsPos)
		
info.eventList = {
	"BAG_UPDATE",
}

info.onEvent = function(self)
  local free, total, used = 0, 0, 0
		for i = 0, NUM_BAG_SLOTS do
			free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
		end
		used = total - free
	self.text:SetText("|cff00cccc"..free)
end

info.onEnter = function(self)
  local free, total, used = 0, 0, 0
		for i = 0, NUM_BAG_SLOTS do
			free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
		end
		used = total - free
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 6);
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(U["Bags"].." : "..used.."/"..total,0,.6,1)
	--GameTooltip:AddLine()
	--GameTooltip:AddDoubleLine(U["Total"]..":",,.6,.8,1, 1, 1, 1)
	--GameTooltip:AddDoubleLine(U["Used"]..":",,.6,.8,1, 1, 1, 1)
	GameTooltip:Show()
end

info.onLeave = function() GameTooltip:Hide() end
info.onMouseUp = function(_, btn) ToggleAllBags() end