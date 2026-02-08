local _, ns = ...
local B, C, L, DB = unpack(ns)
if not C.Infobar.Bags then return end

local module = B:GetModule("Infobar")
local info = module:RegisterInfobar("Bags", C.Infobar.BagsPos)
		
info.eventList = {
	"BAG_UPDATE",
}

info.onEvent = function(self)
  local free = 0
		for i = 0, NUM_BAG_SLOTS do
			free = free + C_Container.GetContainerNumFreeSlots(i)
		end
	self.text:SetText("|cff00cccc"..free)
end

info.onEnter = function(self)
  local free, total, used = 0, 0, 0
		for i = 0, NUM_BAG_SLOTS do
			free, total = free + C_Container.GetContainerNumFreeSlots(i), total + C_Container.GetContainerNumSlots(i)
		end
		used = total - free
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 6);
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(L["Bags"].." : "..used.."/"..total,0,.6,1)
	--GameTooltip:AddLine()
	--GameTooltip:AddDoubleLine(L["Total"]..":",,.6,.8,1, 1, 1, 1)
	--GameTooltip:AddDoubleLine(L["Used"]..":",,.6,.8,1, 1, 1, 1)
	GameTooltip:Show()
end

info.onLeave = function() GameTooltip:Hide() end
info.onMouseUp = function(_, btn) ToggleAllBags() end