--## Author: LanceDH ## Version: 9.0.01
--local TSP = LibStub("AceAddon-3.0"):NewAddon("TransmogSetProgress");
--local ADD = LibStub("AddonDropDown-1.0");

local TSP_SetsDataProvider = nil;
local TSP_COLORS = {
			[0] = { [true] = CreateColor(0, 0.65, 0), [false] = CreateColor(0, 0.40, 0)}
			,[1] = { [true] = CreateColor(0, 0.65, 0), [false] = CreateColor(0, 0.40, 0)}
			,[2]  = { [true] = CreateColor(0, 0.5, 0.9), [false] = CreateColor(0, 0.25, 0.40)}
			,[3]  = { [true] = CreateColor(0.65, 0.4, 0.8), [false] = CreateColor(0.30, 0.2, 0.40)}
			,[4]  = { [true] = CreateColor(0.75, 0.4, 0), [false] = CreateColor(0.4, 0.2, 0)}
		}
TSP_COLORS[PLAYER_DIFFICULTY3] = TSP_COLORS[1] -- LFR
TSP_COLORS[PLAYER_DIFFICULTY1] = TSP_COLORS[2] -- Normal
TSP_COLORS[PLAYER_DIFFICULTY2] = TSP_COLORS[3] -- Heroic
TSP_COLORS[PLAYER_DIFFICULTY6] = TSP_COLORS[4] -- Mythic

local n10 = string.format("%s (%s)", RAID_DIFFICULTY1, PLAYER_DIFFICULTY1);
TSP_COLORS[n10] = TSP_COLORS[1]; -- 10man normal
local n25 = string.format("%s (%s)", RAID_DIFFICULTY2, PLAYER_DIFFICULTY1);
TSP_COLORS[n25] = TSP_COLORS[2]; -- 25man normal
local h10 = string.format("%s (%s)", RAID_DIFFICULTY1, PLAYER_DIFFICULTY2);
TSP_COLORS[h10] = TSP_COLORS[3]; -- 10man heroic
local h25 = string.format("%s (%s)", RAID_DIFFICULTY2, PLAYER_DIFFICULTY2);
TSP_COLORS[h25] = TSP_COLORS[4]; -- 25man heroic
		
local ENUM_EMPTY_OPTION = {
	["keep"] = 1
	,["left"] = 2
	,["spread"] =3
}	

local TSP = {
	settings = {	
		HideCompleted = true;
		AlignLeft = false; 
	}   
}
		
local function GetOrCreateBarBlock(button, bar, index)
	local block = bar[index];
	if not block then 
		bar[index] = bar:CreateTexture(nil, "ARTWORK");
		block = bar[index];
	end
	return block;
end

local function GetOrCreateBar(button, index, spacing)
	if not button.TSPBars then 
		button.TSPBars = {}; 
	end
	local bar = button.TSPBars[index];
	if not bar then 
		bar = CreateFrame("FRAME", "TSP".. button:GetName():match("(%d+)").. "_Bar"..index, button);
		bar:SetHeight(4);
		button.TSPBars[index] = bar;
		
		if index == 1 then
			bar:SetPoint("BOTTOMLEFT", button.Background, "BOTTOMLEFT", 2 + spacing/2 , 2);
		else
			bar:SetPoint("LEFT", button.TSPBars[index-1], "RIGHT", spacing, 0);
		end
	end
	return bar;
end

local function SetBarProgress(button, index, bar, space, numCollected, numTotal, description)	
	if (numTotal == 0) then return; end
	local spacing = 2;
	local spacePerBlock = (space - spacing * (numTotal)) / numTotal;
	-- Commence nightmare
	local ceilFirst = (spacePerBlock - floor(spacePerBlock)) <= 0.5;
	if (ceilFirst) then
		spacePerBlock = ceil(spacePerBlock);
	else
		spacePerBlock = floor(spacePerBlock);
	end
	local otherSpace = space - (spacePerBlock * numTotal);
	local recalculatedSpacing;
	if (ceilFirst) then
		recalculatedSpacing = floor(otherSpace/(numTotal));
	else
		recalculatedSpacing = ceil(otherSpace/(numTotal));
	end
	-- You made it
	
	for i = 1, numTotal do
		local block = GetOrCreateBarBlock(button, bar, i);
		local progress = (numCollected == 0 or numTotal == 0) and 0 or numCollected / numTotal;
		local colorVariant = TSP_COLORS[description] or (description and TSP_COLORS[index] or TSP_COLORS[0]);
		
		block:ClearAllPoints();
		block:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", spacing/2 + ((i-1) * spacePerBlock) + ((i-1) * recalculatedSpacing), 1);
		block:SetHeight(2);
	
		block:SetWidth(spacePerBlock);
		block:SetColorTexture(colorVariant[i <= numCollected]:GetRGB());
		block:SetAlpha(1);
	end
end

local function SetButtonProgress(button, nrShown, variantIndex, space, numCollected, numTotal, description)
	local spacing = 4;
	
	local bar = GetOrCreateBar(button, nrShown, spacing)
	local space = space - spacing
	bar:SetWidth(space);
	
	if (TSP.settings.HideCompleted and numCollected == numTotal) then return false; end
	SetBarProgress(button, variantIndex, bar, space, numCollected, numTotal, description);
	
	return true;
end

local function HideAllBars(button)
	if not button.TSPBars then return end;
	for kBar, bar in ipairs(button.TSPBars) do
		for kBlock, block in ipairs(bar) do
			block:SetAlpha(0)
		end
	end
end

local function UpdateButtons()
	for k, button in ipairs(WardrobeCollectionFrameScrollFrame.buttons) do
		HideAllBars(button)
		if (button.setID) then
			if (not button.TSPBar) then
				button.TSPBar = CreateFrame("FRAME", nil, button, "TSP_MainBar");
				button.TSPBar:SetPoint("BOTTOMLEFT", button, 0, 2);
				button.TSPBar:SetPoint("BOTTOMRIGHT", button, 0, 2);
				button.TSPBar.variants = {};
			end
			
			wipe(button.TSPBar.variants);
			button.ProgressBar:SetAlpha(0);

			-- Copy the variants, as we don't want to taint the souce material
			tAppendAll(button.TSPBar.variants, TSP_SetsDataProvider:GetVariantSets(button.setID))
			local variantSets = button.TSPBar.variants
			

			for i = #variantSets, 1, -1  do
				local desc = variantSets[i].description;
				if (not TSP_COLORS[desc]) then
					variantSets[i].description = i;
				end
				 
				if (TSP.settings.HideCompleted and TSP.settings.handleEmpty == ENUM_EMPTY_OPTION.spread) then
					local numCollected, numTotal = TSP_SetsDataProvider:GetSetSourceCounts(variantSets[i].setID);
					if (numCollected == numTotal) then
						table.remove(variantSets, i);
					end
				end
			end
			
			
			local splitWidth = floor(button:GetWidth())-4;
			if #variantSets > 0 then
				splitWidth = (splitWidth) / #variantSets;
				local index = 1;
				for i = 1, #variantSets do
					local numCollected, numTotal = TSP_SetsDataProvider:GetSetSourceCounts(variantSets[i].setID);
					local setup = SetButtonProgress(button, index, i, splitWidth, numCollected, numTotal, variantSets[i].description);
					if (setup or TSP.settings.handleEmpty ~= ENUM_EMPTY_OPTION.left) then
						index = index + 1;
					end
				end
			else
				local numCollected, numTotal = TSP_SetsDataProvider:GetSetSourceCounts(button.setID);
				SetButtonProgress(button, 1, 1, splitWidth, numCollected, numTotal);
			end
		end
		button.Label:ClearAllPoints();
		button.Label:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 6, 7);
	end
end
		
local function InitDropDown(ddFrame)
	local info = ddFrame:CreateButtonInfo("checkbox");

	-- Hide Completed
	info.text = "Hide Completed";
	info.tooltipTitle = "Hide Completed";
	info.tooltipText = "Hides progress bar for completed set variants.";
	info.func = function(_, _, _, value)
		TSP.settings.HideCompleted = value;
		ddFrame:Refresh();
		UpdateButtons();
	end
	info.checked = function() return TSP.settings.HideCompleted end;
	ddFrame:AddButton(info);
	
	info = ddFrame:CreateButtonInfo("radio");
	-- Spread it like butter
	info.disabled = function() return not TSP.settings.HideCompleted end;
	info.text = "Unchanged";
	info.tooltipTitle = "Unchanged";
	info.tooltipText = "Keep remaining bars in their original position.";
	info.func = function(_, _, _, value)
		if (value) then
			TSP.settings.handleEmpty = ENUM_EMPTY_OPTION.keep;
			ddFrame:Refresh();
			UpdateButtons();
		end
	end
	
	info.checked = function() return TSP.settings.handleEmpty == ENUM_EMPTY_OPTION.keep; end;
	ddFrame:AddButton(info)
	
	-- Align Left
	info.disabled = function() return not TSP.settings.HideCompleted end;
	info.text = "Align Left";
	info.tooltipTitle = "Align Left";
	info.tooltipText = "Aligns progress bars to the left if any bars before it are hidden.";
	info.func = function(_, _, _, value)
		if (value) then
			TSP.settings.handleEmpty = ENUM_EMPTY_OPTION.left;
			ddFrame:Refresh();
			UpdateButtons();
		end
	end
	info.checked = function() return TSP.settings.handleEmpty == ENUM_EMPTY_OPTION.left; end;
	ddFrame:AddButton(info);
	
	-- Spread it like butter
	info.disabled = function() return not TSP.settings.HideCompleted end;
	info.text = "Spread";
	info.tooltipTitle = "Spread";
	info.tooltipText = "Fills up the empty space with the remaining bars.";
	info.func = function(_, _, _, value)
		if (value) then
			TSP.settings.handleEmpty = ENUM_EMPTY_OPTION.spread;
			ddFrame:Refresh();
			UpdateButtons();
		end
	end
	
	info.checked = function() return TSP.settings.handleEmpty == ENUM_EMPTY_OPTION.spread; end;
	ddFrame:AddButton(info);
end
		
function TSP:OnEnable()
	self.db = LibStub("AceDB-3.0"):New("TSPDB", TSP_DEFAULTS, true);
	self.settings = self.db.global;
	
	local currentVersion = GetAddOnMetadata(_addonName, "version");
	
	if (not self.settings.handleEmpty) then
		self.settings.handleEmpty = ENUM_EMPTY_OPTION.keep;
	end
	
	if (self.settings.AlignLeft) then
		self.settings.AlignLeft = false;
		self.settings.handleEmpty = ENUM_EMPTY_OPTION.left;
	end
	
	self.settings.version = currentVersion;
end

local TSP_EventFrame = CreateFrame("FRAME", "TSP_EventFrame"); 
TSP_EventFrame:RegisterEvent("ADDON_LOADED");
TSP_EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

function TSP_EventFrame:ADDON_LOADED(loaded)
	if (loaded == "Blizzard_Collections") and (loaded ~= "TransmogSetProgress") then 
		hooksecurefunc(WardrobeCollectionFrameScrollFrame, "Update", UpdateButtons);
		hooksecurefunc(WardrobeCollectionFrameScrollFrame, "update", UpdateButtons);
		
		TSP_SetsDataProvider = CreateFromMixins(WardrobeSetsDataProviderMixin);
		TSP_EventFrame:RegisterEvent("TRANSMOG_COLLECTION_UPDATED");
		TSP_EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
		--TSP_EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		--TSP_SettingsButton:SetParent(WardrobeCollectionFrame.SetsCollectionFrame);
		--TSP_SettingsButton:SetPoint("TOPRIGHT", WardrobeCollectionFrame, "TOPRIGHT", -11, -35);

		--ADD:LinkDropDown(TSP_SettingsButton, InitDropDown);
	end
end

function TSP_EventFrame:TRANSMOG_COLLECTION_UPDATED()
	if TSP_SetsDataProvider then
		TSP_SetsDataProvider:ClearSets();
	end
end

--function TSP_EventFrame:PLAYER_REGEN_DISABLED(loaded_addon)
	--TSP_SettingsButton:Disable();
--end

function TSP_EventFrame:PLAYER_REGEN_ENABLED(loaded_addon)
	--TSP_SettingsButton:Enable();
	if TSP_SetsDataProvider then
		TSP_SetsDataProvider:ClearSets();
	end
end

