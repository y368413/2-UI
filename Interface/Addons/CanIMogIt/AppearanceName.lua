--## Author: Morizo  ## Notes: Show appearance name without mouseover.  ## Version: 1.2.4
local AppearanceName = {};

AppearanceName.GetName = function(visualInfo)
	local sourceID = visualInfo.sourceID;
	if sourceID then
		return C_TransmogCollection.GetIllusionStrings(sourceID);
	else
		local name;
		for _, source in ipairs(C_TransmogCollection.GetAppearanceSources(visualInfo.visualID)) do
			name = source.name;
			if source.isCollected then
				break;
			end
		end
		return name;
	end
end

AppearanceName.UpdateName = function(self)
	local name = self.visualInfo and AppearanceName.GetName(self.visualInfo);
	if name then
		self.nameFrame.name:SetText(name);
	else
		self.nameFrame.name:SetText("Loading...");
		C_Timer.After(
			1,
			function()
				AppearanceName.UpdateName(self);
			end
		);
	end
end

AppearanceName.CreateNameFrames = function(models)
	for _, model in ipairs(models) do
		model.nameFrame = CreateFrame("Frame", nil, model, "AppearanceNameFrameTemplate");
	end
end

AppearanceName.UpdateNameFrames = function(models)
	for _, model in ipairs(models) do
		AppearanceName.UpdateName(model);
	end
end

local IsAddOnLoadFinished = function(addOnName)
	local loaded, finished = C_AddOns.IsAddOnLoaded(addOnName);
	return loaded and finished;
end

local SetupFrames = function(itemsCollectionFrame)
	AppearanceName.CreateNameFrames(itemsCollectionFrame.Models);
	AppearanceName.UpdateNameFrames(itemsCollectionFrame.Models);
	hooksecurefunc(
		itemsCollectionFrame,
		"UpdateItems",
		function(self)
			AppearanceName.UpdateNameFrames(self.Models);
		end
	);
end

local SetupFuncs = {};
SetupFuncs.Blizzard_Collections = function(addOnName)
	if IsAddOnLoadFinished(addOnName) then
		SetupFuncs.Blizzard_Collections = nil;
		if IsAddOnLoadFinished("BetterWardrobe") then
			C_Timer.After(
				1,
				function()
					SetupFrames(_G["BetterWardrobeCollectionFrame"].ItemsCollectionFrame);
				end
			);
		else
			SetupFrames(WardrobeCollectionFrame.ItemsCollectionFrame);
		end
	end
end

local loadFrame = CreateFrame("Frame");
loadFrame:RegisterEvent("ADDON_LOADED");
loadFrame:SetScript(
	"OnEvent",
	function(_, event, ...)
		if event == "ADDON_LOADED" then
			local addOnName = ...;
			local funcs = SetupFuncs[addOnName];
			if funcs then
				funcs(addOnName);
			end
		end
	end
);