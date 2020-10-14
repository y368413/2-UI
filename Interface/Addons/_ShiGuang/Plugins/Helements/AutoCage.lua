--[[
	AutoCage (C) @Kruithne <kruithne@gmail.com>
	Licensed under GNU General Public Licence version 3.
	https://github.com/Kruithne/AutoCage
	AutoCage.lua - Core engine file for the addon.
    ## Version: 1.4.5
]]

local petCagedPattern = string.gsub(BATTLE_PET_NEW_PET, "%%s", ".*Hbattlepet:(%%d+).*");
local acHasHooked = false;

L_AUTOCAGE_CAGED_MESSAGE = {
	["enUS"] = "Duplicate pet; caging it for you!",
	["zhCN"] = "重复宠物;把它关在笼子里！",
	["zhTW"] = "重複寵物;把它關在籠子裡！",
};

L_AUTOCAGE_LOADED = {
	["enUS"] = "Loaded!",
	["zhCN"] = "加载!",
	["zhTW"] = "載入!",
};

L_AUTOCAGE_DUPLICATE_PETS_BUTTON = {
  ["enUS"] = "Cage Duplicate Pets",
  ["zhCN"] = "重复宠物装笼",
};

L_AUTOCAGE_DUPLICATE_PETS_BUTTON_TOOLTIP = {
  ["enUS"] = "Cages all duplicate pets that are neither favourited or above level one.",
};

L_AUTOCAGE_CHECKBOX = {
	["enUS"] = "Automatically cage duplicates",
	["zhCN"] = "自动把重复宠物装笼",
	["zhTW"] = "自動籠子裡重複",
};

L_AUTOCAGE_CHECKBOX_TOOLTIP = {
	["zhCN"] = "如果启用，把学到的重复宠物自动将会在一个笼子里。",
	["zhTW"] = "如果啟用，把學到的重複寵物自動將會在一個籠子裡。",
};

L_AUTOCAGE_AUTO_ENABLED = {
	["enUS"] = "Duplicate pets will now be automatically caged when obtained.",
};

L_AUTOCAGE_AUTO_DISABLED = {
	["enUS"] = "Duplicate pets will no longer be automatically caged when obtained.",
};

L_AUTOCAGE_CAGING = {
	["enUS"] = "Caging duplicate pets...",
};

L_AUTOCAGE_COMMANDS_AVAILABLE = {
	["enUS"] = "Available Commands:",	
};

L_AUTOCAGE_COMMANDS_HELP = {
	["enUS"] = "List available commands.",
};

L_AUTOCAGE_COMMANDS_CAGE = {
	["enUS"] = "Toggle auto-caging functionality.",
};

L_AUTOCAGE_COMMANDS_TOGGLE = {
	["enUS"] = "Cage all duplicate pets.",
};

--[[
	AutoCage_GetLocalizedString
	Selects the localized string from a localization table.
]]
function AutoCage_GetLocalizedString(strings)
	return strings[GetLocale()] or strings["enUS"] or "Unknown";
end

--[[
	AutoCage_HandleAutoCaging
	Find all duplicates and cage them.
]]
local petsToCage = {};
function AutoCage_HandleAutoCaging(petToCageID)
	C_PetJournal.ClearSearchFilter(); -- Clear filter so we have a full pet list.
	C_PetJournal.SetPetSortParameter(LE_SORT_BY_LEVEL); -- Sort by level, ensuring higher level pets are encountered first.

	local total, owned = C_PetJournal.GetNumPets();
	local petCache = {};
	petsToCage = {};

	if petToCageID ~= nil then
		petToCageID = tonumber(petToCageID);
	end

	for index = 1, owned do -- Loop every pet owned (unowned will be over the offset).
		local pGuid, pBattlePetID, _, pNickname, pLevel, pIsFav, _, pName, _, _, _, _, _, _, _, pIsTradeable = C_PetJournal.GetPetInfoByIndex(index);

		if petToCageID == nil or petToCageID == pBattlePetID then
			if petCache[pBattlePetID] == true then
				if pLevel == 1 and not pIsFav and pIsTradeable then
					AutoCage_Message(pName .. " : " .. AutoCage_GetLocalizedString(L_AUTOCAGE_CAGED_MESSAGE));
					table.insert(petsToCage, pGuid);
				end
			else
				petCache[pBattlePetID] = true;
			end
		end
	end
end

--[[
	AutoCage_Load
	Run set-up tasks when addon is loaded.
]]
function AutoCage_Load()

	if ShiGuangDB["AutoCage"] == nil then
		-- No global enabled variable found, setting default.
		ShiGuangDB["AutoCage"] = true;
	end

	-- Set the checkbox to the correct state now we've loaded.
	-- Technically AutoCage_Load is called before AutoCage_JournalHook but
	-- if for some reason it's not, this is a safety net for that.
	if AutoCage_EnabledButton ~= nil then
		AutoCage_EnabledButton:SetChecked(ShiGuangDB["AutoCage"]);
	end
end

--[[
	AutoCage_JournalHook
	Hook our enable checkbox onto the journal frame.
]]
function AutoCage_JournalHook()
	if acHasHooked or IsAddOnLoaded("Rematch") then
		return;
	end

	-- Add a caging button
	cageButton = CreateFrame("Button", "AutoCage_CageButton", PetJournal, "MagicButtonTemplate");
	cageButton:SetPoint("LEFT", PetJournalSummonButton, "RIGHT", 0, 0);
	cageButton:SetWidth(125);
	cageButton:SetText(AutoCage_GetLocalizedString(L_AUTOCAGE_DUPLICATE_PETS_BUTTON));
	cageButton:SetScript("OnClick", function() AutoCage_HandleAutoCaging(nil) end);
	cageButton:SetScript("OnEnter",
		function(self)
			GameTooltip:SetOwner (self, "ANCHOR_RIGHT");
			GameTooltip:SetText(AutoCage_GetLocalizedString(L_AUTOCAGE_DUPLICATE_PETS_BUTTON), 1, 1, 1);
			GameTooltip:AddLine(AutoCage_GetLocalizedString(L_AUTOCAGE_DUPLICATE_PETS_BUTTON_TOOLTIP), nil, nil, nil, true);
			GameTooltip:Show();
		end
	);
	cageButton:SetScript("OnLeave",
		function()
			GameTooltip:Hide();
		end
	);

	-- Set-up enable/disable check-button.
	checkButton = CreateFrame("CheckButton", "AutoCage_EnabledButton", PetJournal, "ChatConfigCheckButtonTemplate");
	checkButton:SetPoint("LEFT", AutoCage_CageButton, "RIGHT", 3, -1);
	checkButton:SetChecked(ShiGuangDB["AutoCage"]);
	AutoCage_EnabledButtonText:SetPoint("LEFT", checkButton, "RIGHT", -1, -1);
	AutoCage_EnabledButtonText:SetText(AutoCage_GetLocalizedString(L_AUTOCAGE_CHECKBOX));
	checkButton.tooltip = AutoCage_GetLocalizedString(L_AUTOCAGE_CHECKBOX_TOOLTIP);
	checkButton:SetScript("OnClick", 
	  function()
	    if ShiGuangDB["AutoCage"] then
	    	ShiGuangDB["AutoCage"] = false;
	    else
	    	ShiGuangDB["AutoCage"] = true;
	    end
	  end
	);

	acHasHooked = true;
end

--[[
	AutoCage_Message
	Prints a formatted message to the default chat frame.
]]
function AutoCage_Message(msg)
	DEFAULT_CHAT_FRAME:AddMessage("\124cffc79c6eAutoCage:\124r \124cff69ccf0" .. msg .."\124r");
end

-- Event handling frame.
local eventFrame = CreateFrame("FRAME");
eventFrame:RegisterEvent("CHAT_MSG_SYSTEM");
eventFrame:RegisterEvent("ADDON_LOADED");
eventFrame.elapsed = 0;
eventFrame.pendingUpdate = false;
eventFrame.cageTimer = 0;

eventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "CHAT_MSG_SYSTEM" and ShiGuangDB["AutoCage"] then
		local msg, format = ...;
		local match = string.match(msg, petCagedPattern);

		if match ~= nil then
			self.pendingUpdate = true;
			self.petID = match;
		end
	elseif event == "ADDON_LOADED" then
		local addon = ...;
		if addon == "Blizzard_Collections" then
			AutoCage_JournalHook();
		elseif addon == "AutoCage" then
			AutoCage_Load();

			if IsAddOnLoaded("Blizzard_Collections") then
				AutoCage_JournalHook();
			end
		end
	end
end);

eventFrame:SetScript("OnUpdate", function(self, elapsed)
	if self.pendingUpdate then
		if self.elapsed >= 1 then
			AutoCage_HandleAutoCaging(self.petID);

			self.elapsed = 0;
			self.pendingUpdate = false;
		else
			self.elapsed = self.elapsed + elapsed;
		end
	end

	if self.cageTimer >= 1 then
		if #petsToCage > 0 then
			for i=1, #petsToCage do
				C_PetJournal.CagePetByID(petsToCage[i]);
			end
		end
		self.cageTimer = 0;
	else
		self.cageTimer = self.cageTimer + elapsed;
	end
end);

local AutoCageCommands = {};
function AutoCage_CommandToggle()
	if ShiGuangDB["AutoCage"] then
		ShiGuangDB["AutoCage"] = false;
		AutoCage_Message(AutoCage_GetLocalizedString(L_AUTOCAGE_AUTO_DISABLED));
	else
		ShiGuangDB["AutoCage"] = true;
		AutoCage_Message(AutoCage_GetLocalizedString(L_AUTOCAGE_AUTO_ENABLED));
	end
end

function AutoCage_CommandCage()
	AutoCage_HandleAutoCaging(nil);
	AutoCage_Message(AutoCage_GetLocalizedString(L_AUTOCAGE_CAGING));
end

function AutoCage_CommandDefault()
	AutoCage_Message(AutoCage_GetLocalizedString(L_AUTOCAGE_COMMANDS_AVAILABLE));
	local commandFormat = "   /%s - %s";

	for id, node in pairs(AutoCageCommands) do
		AutoCage_Message(commandFormat:format(id, node.info));
	end
end

AutoCageCommands["help"] = { func = AutoCage_CommandDefault, info = AutoCage_GetLocalizedString(L_AUTOCAGE_COMMANDS_HELP) };
AutoCageCommands["toggle"] = { func = AutoCage_CommandToggle, info = AutoCage_GetLocalizedString(L_AUTOCAGE_COMMANDS_TOGGLE) };
AutoCageCommands["cage"] = { func = AutoCage_CommandCage, info = AutoCage_GetLocalizedString(L_AUTOCAGE_COMMANDS_CAGE) };

-- Commands
SLASH_AUTOCAGE1 = "/autocage";
SlashCmdList["AUTOCAGE"] = function(text, editbox)
	local command = AutoCageCommands[text] or AutoCageCommands["help"];
	command.func();
end;