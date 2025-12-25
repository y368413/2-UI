------------------------------ ## Notes: Automatically destroys items in the pre-defined list    ## Author: Tim @ WoW Interface    ## Version: 1.0
local itemList = {
	--[2287] = true,		-- haunch of meat (tested in RFC)  肉排
	[131810] = true,		-- haunch of meat (tested in RFC)  肉排
}
local DESTROY = CreateFrame("Frame", "AutoItemDestroyer")
DESTROY:RegisterEvent("BAG_UPDATE")
DESTROY:RegisterEvent("BAG_UPDATE_DELAYED")
DESTROY:RegisterEvent("CHAT_MSG_LOOT")
DESTROY:SetScript("OnEvent", function(_, event, ...)
   for bags = 0, 4 do
      for slots = 1, C_Container.GetContainerNumSlots(bags) do
         local itemLink, linkID = C_Container.GetContainerItemLink(bags, slots), C_Container.GetContainerItemID(bags, slots)
			if linkID == 131810 then
				ClearCursor()
				C_Container.PickupContainerItem(bags, slots)
				DeleteCursorItem()
				print("Searched bags... FOUND & DESTROYED: |cff6699dd", "被遗弃的天角风筝".." [ID: "..linkID.."]")
			end
         --if (itemLink and linkID) then
            --if (select(11, C_Item.GetItemInfo(itemLink)) ~= nil and select(2, C_Container.GetContainerItemInfo(bags, slots)) ~= nil) then
               --local itemName, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _ = C_Item.GetItemInfo(linkID) 
               --if itemList[linkID] then
                  --C_Container.PickupContainerItem(bags, slots)
                  --DeleteCursorItem()
                  --print("Searched bags... FOUND & DESTROYED: |cff6699dd", itemName.." [ID: "..linkID.."]")
               --end
            --end
         --end
      end
   end
end)