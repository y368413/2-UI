--## Author: LanceDH ## Version: 9.0.01
--local TSP = LibStub("AceAddon-3.0"):NewAddon("TransmogSetProgress");
--local ADD = LibStub("AddonDropDown-1.0");

local TSP_SetsDataProvider = nil;
local TSP_COLORS = {
			[0] = { [true] = CreateColor(0, 0.75, 0), [false] = CreateColor(0, 0.40, 0)}
			,[1] = { [true] = CreateColor(0, 0.75, 0), [false] = CreateColor(0, 0.40, 0)}
			,[2]  = { [true] = CreateColor(0, 0.5, 0.9), [false] = CreateColor(0, 0.25, 0.40)}
			,[3]  = { [true] = CreateColor(0.7, 0.4, 0.8), [false] = CreateColor(0.30, 0.2, 0.40)}
			,[4]  = { [true] = CreateColor(0.8, 0.4, 0), [false] = CreateColor(0.4, 0.2, 0)}
			,[PLAYER_DIFFICULTY3] = { [true] = CreateColor(0, 0.75, 0), [false] = CreateColor(0, 0.40, 0)}
			,[PLAYER_DIFFICULTY1]  = { [true] = CreateColor(0, 0.5, 0.9), [false] = CreateColor(0, 0.25, 0.40)}
			,[PLAYER_DIFFICULTY2]  = { [true] = CreateColor(0.7, 0.4, 0.8), [false] = CreateColor(0.30, 0.2, 0.40)}
			,[PLAYER_DIFFICULTY6]  = { [true] = CreateColor(0.8, 0.4, 0), [false] = CreateColor(0.4, 0.2, 0)}
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
		bar[index] = button:CreateTexture(nil, "ARTWORK");
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
		button.TSPBars[index] = CreateFrame("FRAME", "TSP".. button:GetName():match("(%d+)").. "_"..index, button) --{};
		bar = button.TSPBars[index];
		bar:SetHeight(20);
		if index == 1 then
			bar:SetPoint("BOTTOMLEFT", button.Background, "BOTTOMLEFT", 2 + spacing/2 , 2);
		else
			bar:SetPoint("LEFT", button.TSPBars[index-1], "RIGHT", spacing, 0);
		end
	end
	return bar;
end

local function SetBarProgress(button, index, bar, space, numCollected, numTotal, description)	
	if numTotal == 0 then return; end
	local spacing = 2;
	local spacePerBlock = (space - spacing * (numTotal)) / numTotal;
	for i = 1, numTotal do
		local block = GetOrCreateBarBlock(button, bar, i);
		local progress = (numCollected == 0 or numTotal == 0) and 0 or numCollected / numTotal;
		local colorVariant = TSP_COLORS[description] or (description and TSP_COLORS[index] or TSP_COLORS[0]);
		
		block:ClearAllPoints();
		block:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", spacing/2 + ((i-1) * spacePerBlock) + ((i-1) * spacing), 0);
		block:SetHeight(2);
	
		block:SetWidth(spacePerBlock);
		block:SetColorTexture(colorVariant[i <= numCollected]:GetRGB());
		block:SetAlpha(1);
	end
end

local function SetButtonProgress(button, nrShown, variantIndex, space, numCollected, numTotal, description)
	local spacing = 4;
	
	local bar = GetOrCreateBar(button, nrShown, spacing)
	if (TSP.settings.HideCompleted and numCollected == numTotal) then return false; end
	local space = space - spacing
	bar:SetWidth(space);
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
			button.ProgressBar:SetAlpha(0);
			local variantSets = WardrobeSetsDataProviderMixin:GetVariantSets(button.setID);
			local splitWidth = floor(button:GetWidth())-2;
			if #variantSets > 0 then
				splitWidth = (splitWidth) / #variantSets;
				local index = 1;
				for i = 1, #variantSets do
					local numCollected, numTotal = TSP_SetsDataProvider:GetSetSourceCounts(variantSets[i].setID);
					if (SetButtonProgress(button, index, i, splitWidth, numCollected, numTotal, variantSets[i].description) or not TSP.settings.AlignLeft) then
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
		
--[[function TSP:InitDropDown(self, level)

	local info = ADD:CreateInfo();
	info.keepShownOnClick = true;	
	info.notCheckable = false;
	info.tooltipWhileDisabled = true;
	info.tooltipOnButton = true;
	info.isNotRadio = true;

	-- Hide Completed
	info.text = "Hide Completed";
	info.tooltipTitle = "Hides progress bar for\ncompleted set variants.";
	info.func = function(_, _, _, value)
		TSP.settings.HideCompleted = value;
		if (value) then
			ADD:EnableButton(1, 2);
		else
			ADD:DisableButton(1, 2);
		end
		UpdateButtons();
	end
	info.checked = function() return TSP.settings.HideCompleted end;
	ADD:AddButton(info, level);
	
	-- Align Left
	info.disabled = not TSP.settings.HideCompleted;
	info.text = "Align Left";
	info.tooltipTitle = "Aligns progress bars to\nthe left if any bars before\nit are hidden.";
	info.func = function(_, _, _, value)
		TSP.settings.AlignLeft = value;
		UpdateButtons();
	end
	info.checked = function() return TSP.settings.AlignLeft end;
	ADD:AddButton(info, level);
end]]

--local function HideDropDown()
	--HideDropDownMenu(1);
--end
		
--function TSP:OnEnable()
	--self.db = LibStub("AceDB-3.0"):New("TSPDB", TSP_DEFAULTS, true);
	--self.settings = self.db.global;
	--ADD:CreateMenuTemplate("TSP_SettingsDropDown", TSP_SettingsButton);
--end

local TSP_EventFrame = CreateFrame("FRAME", "TSP_EventFrame"); 
TSP_EventFrame:RegisterEvent("ADDON_LOADED");
TSP_EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

function TSP_EventFrame:ADDON_LOADED(loaded)
	if (loaded == "Blizzard_Collections") and (loaded ~= "TransmogSetProgress") then 
		hooksecurefunc(WardrobeCollectionFrameScrollFrame, "Update", UpdateButtons);
		hooksecurefunc(WardrobeCollectionFrameScrollFrame, "update", UpdateButtons);
		
		--WardrobeCollectionFrame.SetsCollectionFrame:HookScript("OnHide", HideDropDown)
		--WardrobeCollectionFrame:HookScript("OnHide", HideDropDown)
		--CollectionsJournal:HookScript("OnHide", HideDropDown)
		--DropDownList1:HookScript("OnShow", HideDropDown)
		
		TSP_SetsDataProvider = CreateFromMixins(WardrobeSetsDataProviderMixin);
		TSP_EventFrame:RegisterEvent("TRANSMOG_COLLECTION_UPDATED");
		--TSP_EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
		TSP_EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		--TSP_SettingsButton:SetParent(WardrobeCollectionFrame.SetsCollectionFrame);
		--TSP_SettingsButton:SetPoint("TOPRIGHT", WardrobeCollectionFrame, "TOPRIGHT", -11, -35);

		--ADD:Initialize(TSP_SettingsDropDown, function(self, level) TSP:InitDropDown(self, level) end, "MENU");
	end
end

function TSP_EventFrame:TRANSMOG_COLLECTION_UPDATED()
	if TSP_SetsDataProvider then
		TSP_SetsDataProvider:ClearSets();
	end
end

--function TSP_EventFrame:PLAYER_REGEN_DISABLED(loaded_addon)
	--TSP_SettingsButton:Disable();
	--HideDropDownMenu(1);
--end

function TSP_EventFrame:PLAYER_REGEN_ENABLED(loaded_addon)
	--TSP_SettingsButton:Enable();
	if TSP_SetsDataProvider then
		TSP_SetsDataProvider:ClearSets();
	end
end

