local TransmogCostCutter = CreateFrame("Frame");
TransmogCostCutter.hiddenOptions = {
[77344] = "Hidden Helm",
[77343] = "Hidden Shoulder",
[77345] = "Hidden Cloak",
[104602] = "Hidden Chest",
[83202] = "Hidden Shirt",
[83203] = "Hidden Tabard",
[104604] = "Hidden Bracer",
[94331] = "Hidden Gloves",
[84223] = "Hidden Belt",
[104603] = "Hidden Boots",
}

TransmogCostCutter:RegisterEvent("TRANSMOGRIFY_UPDATE");
TransmogCostCutter:SetScript("OnEvent", function(evt,...)
if(evt == "TRANSMOGRIFY_UPDATE")then
local transmogLocation, transmogAction = ...;
if(transmogLocation and transmogAction == "set")then
local baseSourceID, baseVisualID, appliedSourceID, appliedVisualID, appliedCategoryID, pendingSourceID, pendingVisualID, pendingCategoryID, hasUndo, isHideVisual, itemSubclass = C_Transmog.GetSlotVisualInfo(transmogLocation)
--print(transmogLocation.slotID, transmogLocation.type, transmogLocation.modification, pendingVisualID )
local appearanceSources = C_TransmogCollection.GetAppearanceSources(pendingVisualID);
if(not appearanceSources)then return; end -- No Sources
for appearanceIndex, appearanceInfo  in pairs(appearanceSources) do
--print(appearanceInfo.sourceID, appearanceInfo.name);
for hiddenItemID, hiddenItemName in pairs(TransmogCostCutter.hiddenOptions)do
if(appearanceInfo.sourceID == hiddenItemID and pendingSourceID ~= hiddenItemID)then
local precost = C_Transmog.GetCost()
C_Transmog.SetPending(transmogLocation, hiddenItemID);
local postcost = C_Transmog.GetCost()
if(precost > postcost)then
print("[Transmog Cost Cutter]: "..appearanceInfo.name.." is being used instead as it is free, saving you "..GetCoinTextureString(precost-postcost)..".");
else
print("[Transmog Cost Cutter]: "..appearanceInfo.name.." is being used instead as it is free.");
end
return;
end
end
end
end
end
end)