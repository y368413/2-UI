-----------------------## Author: Actuarius
----LOCAL VARIABLES----
-----------------------

local ActsFunctions = {};
local functions = {};
local variables = {};
local loadFrame = CreateFrame("FRAME");

--Create a sub-namespace for the global function.
ActsFunctions.functions = functions;
ActsFunctions.variables = variables;

--Slash command
SLASH_ACTFUNCTIONS1 = "/actfunctions"
SLASH_ACTFUNCTIONS2 = "/act"

SlashCmdList.ACTFUNCTIONS = function(msg)
	msg = string.lower(msg) or "";

	if msg == nil or msg == "" then 
		print("No command received.");

		return;
	end

	if string.find(msg, "config") then
		functions.toggleActConfig();

		return;
	end

	if string.find(msg, "print") then
		for key, value in pairs(ShiGuangDB) do
			print(key);
			print(value);
		end

		print("");

		return;
	end

	if string.find(msg, "追踪") then
		if select(2, UnitClass("player")) == "HUNTER"  then
			functions.hunterTrack(UnitCreatureType("target"));
		end

		return;
	end

	local useString = "";

	if string.find(msg, "坐骑") then
		useString = functions.getMount();

		if IsMounted() and GetMacroBody(msg):find(useString) then
			Dismount();
			useString = "";
		end
	elseif string.find(msg, "分解")then
		useString = functions.disenchantScan();
	elseif string.find(msg, "选矿") then
		useString  = functions.prospectScan();
	elseif string.find(msg, "研磨") then
		useString  = functions.millScan();
	elseif string.find(msg, "开锁") then
		useString = functions.itemScan("Lockbox");
	end

	EditMacro(msg, nil, nil, GetMacroBody(msg):gsub("(us[e]).*","%1 " .. (useString or "")));
end


-----------------------
-----EVENT HANDLING----
-----------------------

loadFrame:RegisterEvent("ADDON_LOADED");
loadFrame:SetScript("OnEvent", function(_, event)
    if event == "ADDON_LOADED" then
        ------------
        --Settings--
        ------------
		if ShiGuangDB.ActsFMinIlvl == nil then
			ShiGuangDB.ActsFMinIlvl = 210;
		end

		if ShiGuangDB.ActsFDeArmor == nil then
			ShiGuangDB.ActsFDeArmor = true;
		end

		if ShiGuangDB.ActsFDeWeapon == nil then
			ShiGuangDB.ActsFDeWeapon = true;
		end

		if ShiGuangDB.ActsFMinQuality == nil then
			ShiGuangDB.ActsFMinQuality = 2;
		end

		if ShiGuangDB.ActsFMaxQuality == nil then
			ShiGuangDB.ActsFMaxQuality = 2;
		end


        ------------
        ---Mounts---
        ------------
		if ShiGuangPerDB.ActFCtrlMount == nil then
			ShiGuangPerDB.ActFCtrlMount = "主脑";  --Grand Expedition Yak
		end

		if ShiGuangPerDB.ActFAltMount == nil then
			ShiGuangPerDB.ActFAltMount = "猩红水黾";  --Mighty Caravan Brutosaur
		end

		if ShiGuangPerDB.ActFShiftMount == nil then
			ShiGuangPerDB.ActFShiftMount = "灰熊丘陵魁熊"; --Sandstone Drake
		end

		if ShiGuangPerDB.ActFDragonFlyingMount == nil then
			ShiGuangPerDB.ActFDragonFlyingMount = "星光云端翔龙";  --Renewed Proto-Drake
		end

		if ShiGuangPerDB.ActFGroundMount == nil then
			ShiGuangPerDB.ActFGroundMount = "幽灵驭风者";  --Vulpine Familiar
		end

		if ShiGuangPerDB.ActFDefaultMount == nil then
			ShiGuangPerDB.ActFDefaultMount = "X-51虚空火箭特别加强版";
		end

		if ShiGuangPerDB.ActFCtrlMountBool == nil then
			ShiGuangPerDB.ActFCtrlMountBool = false;
		end

		if ShiGuangPerDB.ActFAltMountBool == nil then
			ShiGuangPerDB.ActFAltMountBool = false;
		end

		if ShiGuangPerDB.ActFShiftMountBool == nil then
			ShiGuangPerDB.ActFShiftMountBool = false;
		end

		if ShiGuangPerDB.ActFDragonFlyingMountBool == nil then
			ShiGuangPerDB.ActFDragonFlyingMountBool = false;
		end

		if ShiGuangPerDB.ActFGroundMountBool == nil then
			ShiGuangPerDB.ActFGroundMountBool = false;
		end

		loadFrame:UnregisterEvent("ADDON_LOADED");
	end
end);


-----------------------
--VARIABLE DEFINITIONS-
-----------------------

--Item Quality array to be used for disenchant macro.
variables.itemQuality = {
	{
		name = "|cFF00FF00Uncommon|r",
		number = 2
	},
	{
		name = "|cFF0000FFRare|r",
		number = 3
	},
	{
		name = "|cFFA335EEEpic|r",
		number = 4
	}
};

--Array to keep tracking types for hunter tracking macro.
variables.trackingArray = {
	Beast = 0,
	Demon = 0,
	Dragonkin = 0,
	Elemental = 0,
	Giant = 0,
	Humanoid = 0,
	Mechanical = 0,
	Undead = 0
};


-----------------------
--FUNCTION DEFINITIONS-
-----------------------

--Mount function
function functions.getMount()
	return
		(ShiGuangPerDB.ActFCtrlMountBool and IsControlKeyDown()) and
			ShiGuangPerDB.ActFCtrlMount
		or
		(ShiGuangPerDB.ActFAltMountBool and IsAltKeyDown()) and
			ShiGuangPerDB.ActFAltMount
		or
		(ShiGuangPerDB.ActFShiftMountBool and IsShiftKeyDown()) and
			ShiGuangPerDB.ActFShiftMount
		or
		(ShiGuangPerDB.ActFDragonFlyingMountBool and IsAdvancedFlyableArea() and C_UnitAuras.GetPlayerAuraBySpellID(404464)) and
			ShiGuangPerDB.ActFDragonFlyingMount
		or
		(ShiGuangPerDB.ActFGroundMountBool and not IsFlyableArea()) and
			ShiGuangPerDB.ActFGroundMount
		or
			ShiGuangPerDB.ActFDefaultMount;
end

--Function for finding items to disenchant, they have to be disenchantable and over ilvl 230.
function functions.disenchantScan()
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local itemTable = {C_Item.GetItemInfo(C_Container.GetContainerItemLink(bag, slot) or 0)}

			if itemTable[4] and
				itemTable[4] > ShiGuangDB.ActsFMinIlvl and
				itemTable[3] >= ShiGuangDB.ActsFMinQuality and
				itemTable[3] <= ShiGuangDB.ActsFMaxQuality and
				(itemTable[6] == "武器" and ShiGuangDB.ActsFDeWeapon) or (itemTable[6] =="护甲" and ShiGuangDB.ActsFDeArmor)
			then
				print(C_Container.GetContainerItemLink(bag, slot));
				return bag .. " " .. slot;
			end
		end
	end
end

--Function for finding ores in the bag and check if there's 5 or more of it.
function functions.prospectScan()
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local itemTable = {C_Item.GetItemInfo(C_Container.GetContainerItemLink(bag, slot) or 0)}

			if
				itemTable[7] == "金属 & 石头" and
				select(2, C_Container.GetContainerItemInfo(bag,slot)) >= 5
			then
				print(C_Container.GetContainerItemLink(bag, slot));
				return bag .. " " .. slot;
			end
		end
	end
end

--Function for finding ores in the bag and check if there's 5 or more of it.
function functions.millScan()
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local itemTable = {C_Item.GetItemInfo(C_Container.GetContainerItemLink(bag, slot) or 0)}

			if
				itemTable[7] == "植物" and
				select(2, C_Container.GetContainerItemInfo(bag, slot)) >= 5
			then
				print(C_Container.GetContainerItemLink(bag, slot));
				return bag .. " " .. slot;
			end
		end
	end
end

--Itemscanner function to check if there is an item in the bags that contains given string.
function functions.itemScan(name)
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local itemName = C_Container.GetContainerItemLink(bag, slot);

			if
				itemName and
				string.find(itemName, name)
			then
				print(C_Container.GetContainerItemLink(bag, slot));
				return bag .. " " .. slot;
			end
		end
	end
end

--Hunter tracking function.
function functions.hunterTrack(track)
	if track then
		local id = variables.trackingArray[track];

		if id ~= nil then
			local trackingInfo = {C_Minimap.GetTrackingInfo(id)};

			C_Minimap.SetTracking(id, not trackingInfo[3]);
		end
	else
		table.foreach(
			variables.trackingArray,
			function(_, value)
				C_Minimap.SetTracking(value, false);
			end
		);
	end
end


-----------------------
----LOCAL VARIABLES----
-----------------------

local actConfigWindow = CreateFrame("FRAME", "ActConfigWindow", UIParent);
local loadFrame = CreateFrame("FRAME");


-----------------------
--FUNCTION DEFINITIONS-
-----------------------

--Check button factory.
local function createCheckbutton(anchor, name, parent, x_loc, y_loc, displayname, tooltip)
	local checkbutton = CreateFrame("CheckButton", name, parent, "ChatConfigCheckButtonTemplate");
	checkbutton:SetPoint(anchor, x_loc, y_loc);
	_G[checkbutton:GetName() .. "Text"]:SetText(displayname);
	checkbutton.tooltip = tooltip;

	return checkbutton;
end

--Quality dropdown factory
local function qualityDropDownFactory(frame, frameDropDown, x_loc, y_loc, title)
	frame:SetPoint("TOPLEFT", x_loc, y_loc);
	frame:SetSize(100, 200);

	frame.dropDown = frameDropDown;
	frame.dropDown:SetPoint("CENTER", frame, "CENTER", 0, -20);

	frame.dropDown.displayMode = "MENU";
	UIDropDownMenu_SetText(frame.dropDown, title);

	frame.dropDown.onClick = function(self, _)
		frame.dropDown.quality = self.value;
	end

	frame.dropDown.initialize = function(self, level)
		local info = UIDropDownMenu_CreateInfo();

		for i = 1, #variables.itemQuality do
			local item = variables.itemQuality[i];
			info.text = item.name;
			info.func = self.onClick;
			info.value = item.number;
			info.checked = info.value == frame.dropDown.quality;
			UIDropDownMenu_AddButton(info, level);
		end
	end
end

--Function for creating the roll setting frames.
local function editBoxFactory(frame, frameEditbox, x, y, title)
	frame:SetPoint("TOPLEFT", actConfigWindow, "TOPLEFT", x, y);
	frame:SetSize(100,200);

	--Create and set title of the setting.
	frame.title = frame:CreateFontString(nil,"OVERLAY");
	frame.title:SetFontObject("GameFontHighLight");
	frame.title:SetPoint("CENTER", frame, "CENTER", 0, 5);
	frame.title:SetText(title);

	--Create the editbox for the setting.
	frame.editBox = frameEditbox;
	frame.editBox:SetPoint("CENTER", frame, "CENTER", 0, -15);
	frame.editBox:SetSize(40,40);
	frame.editBox:SetAutoFocus(false);
	frame.editBox:SetFontObject("GameFontHighLight");
	frame.editBox:SetNumeric(true);
	frame.editBox:SetMaxLetters(4);
end

--Function for creating the mount setting frames.
local function mountEditBoxFactory(frame, frameEditbox, x, y, title, checkName, withCheckButton)
	frame:SetPoint("TOPLEFT", actConfigWindow, "TOPLEFT", x, y);
	frame:SetSize(100,200);

	--Create and set title of the setting.
	frame.title = frame:CreateFontString(nil,"OVERLAY");
	frame.title:SetFontObject("GameFontHighLight");
	frame.title:SetPoint("CENTER", frame, "CENTER", 0, 5);
	frame.title:SetText(title);

	--Create the editbox for the setting.
	frame.editBox = frameEditbox;
	frame.editBox:SetPoint("CENTER", frame, "CENTER", 0, -15);
	frame.editBox:SetSize(130,20);
	frame.editBox:SetAutoFocus(false);
	frame.editBox:SetFontObject("GameFontHighLight");

	frame.editBox:SetScript("OnEnterPressed", function(self)
		frame.editBox.mountIdentification = frame.editBox:GetText();

		frame.editBox:ClearFocus();
	end);

	if withCheckButton then
		local checkbutton = CreateFrame("CheckButton", checkName, frame, "ChatConfigCheckButtonTemplate");
		checkbutton:SetPoint("LEFT", frame, "LEFT", -42, -15);
		checkbutton.tooltip = "启用/禁用 此设置。";
	end
end

--Updating the config windows values.
local function updateConfigWindow()
	actConfigWindow.ActsFMinIlvl.editBox:SetNumber(ShiGuangDB.ActsFMinIlvl)
	actConfigWindow.ActsFMinQuality.dropDown.quality = ShiGuangDB.ActsFMinQuality;
	actConfigWindow.ActsFMaxQuality.dropDown.quality = ShiGuangDB.ActsFMaxQuality;

	actConfigWindow.ActFCtrlMount.editBox.mountIdentification = ShiGuangDB.ActFCtrlMount;
	actConfigWindow.ActFAltMount.editBox.mountIdentification = ShiGuangDB.ActFAltMount;
	actConfigWindow.ActFShiftMount.editBox.mountIdentification = ShiGuangDB.ActFShiftMount;
	actConfigWindow.ActFDragonFlyingMount.editBox.mountIdentification = ShiGuangDB.ActFDragonFlyingMount;
	actConfigWindow.ActFGroundMount.editBox.mountIdentification = ShiGuangDB.ActFGroundMount;
	actConfigWindow.ActFDefaultMount.editBox.mountIdentification = ShiGuangDB.ActFDefaultMount;

	_G["actDeArmor"]:SetChecked(ShiGuangDB.ActsFDeArmor);
	_G["actDeWeapon"]:SetChecked(ShiGuangDB.ActsFDeWeapon);

	_G["actCtrlMount"]:SetChecked(ShiGuangPerDB.ActFCtrlMountBool);
	_G["actAltMount"]:SetChecked(ShiGuangPerDB.ActFAltMountBool);
	_G["actShiftMount"]:SetChecked(ShiGuangPerDB.ActFShiftMountBool);
	_G["actDragonflyingMount"]:SetChecked(ShiGuangPerDB.ActFDragonFlyingMountBool);
	_G["actGroundMount"]:SetChecked(ShiGuangPerDB.ActFGroundMountBool);

	actConfigWindow.ActFCtrlMount.editBox:SetText(ShiGuangPerDB.ActFCtrlMount);
	actConfigWindow.ActFAltMount.editBox:SetText(ShiGuangPerDB.ActFAltMount);
	actConfigWindow.ActFShiftMount.editBox:SetText(ShiGuangPerDB.ActFShiftMount);
	actConfigWindow.ActFDragonFlyingMount.editBox:SetText(ShiGuangPerDB.ActFDragonFlyingMount);
	actConfigWindow.ActFGroundMount.editBox:SetText(ShiGuangPerDB.ActFGroundMount);
	actConfigWindow.ActFDefaultMount.editBox:SetText(ShiGuangPerDB.ActFDefaultMount);
end

--Function for saving data from config window and closing it.
local function saveData()
	local ActsFMinIlvl = actConfigWindow.ActsFMinIlvl.editBox:GetNumber();
	local ActsFMinQuality = actConfigWindow.ActsFMinQuality.dropDown.quality;
	local ActsFMaxQuality = actConfigWindow.ActsFMaxQuality.dropDown.quality;

	local ActFCtrlMount = actConfigWindow.ActFCtrlMount.editBox.mountIdentification;
	if not (ActFCtrlMount == nil or ActFCtrlMount == 0) then
		ShiGuangPerDB.ActFCtrlMount = ActFCtrlMount;
	end

	local ActFAltMount = actConfigWindow.ActFAltMount.editBox.mountIdentification;
	if not (ActFAltMount == nil or ActFAltMount == 0) then
		ShiGuangPerDB.ActFAltMount = ActFAltMount;
	end

	local ActFShiftMount = actConfigWindow.ActFShiftMount.editBox.mountIdentification;
	if not (ActFShiftMount == nil or ActFShiftMount == 0) then
		ShiGuangPerDB.ActFShiftMount = ActFShiftMount;
	end

	local ActFDragonFlyingMount = actConfigWindow.ActFDragonFlyingMount.editBox.mountIdentification;
	if not (ActFDragonFlyingMount == nil or ActFDragonFlyingMount == 0) then
		ShiGuangPerDB.ActFDragonFlyingMount = ActFDragonFlyingMount;
	end

	local ActFGroundMount = actConfigWindow.ActFGroundMount.editBox.mountIdentification;
	if not (ActFGroundMount == nil or ActFGroundMount == 0) then
		ShiGuangPerDB.ActFGroundMount = ActFGroundMount;
	end

	local ActFDefaultMount = actConfigWindow.ActFDefaultMount.editBox.mountIdentification;
	if not (ActFDefaultMount == nil or ActFDefaultMount == 0) then
		ShiGuangPerDB.ActFDefaultMount = ActFDefaultMount;
	end

	if
		ActsFMinIlvl == 0 or
		ActsFMinQuality == 0 or
		ActsFMaxQuality == 0 or
		ActsFMinQuality > ActsFMaxQuality
	then
		print("Error, invalid values");

		return;
	end

	ShiGuangDB.ActsFMinIlvl = ActsFMinIlvl;
	ShiGuangDB.ActsFMinQuality = ActsFMinQuality;
	ShiGuangDB.ActsFMaxQuality = ActsFMaxQuality;
	ShiGuangDB.ActsFDeArmor = _G["actDeArmor"]:GetChecked();
	ShiGuangDB.ActsFDeWeapon = _G["actDeWeapon"]:GetChecked();

	SetCVar("ActionButtonUseKeyDown", ShiGuangPerDB.castOnPressDown);

	ShiGuangPerDB.ActFCtrlMountBool = _G["actCtrlMount"]:GetChecked();
	ShiGuangPerDB.ActFAltMountBool = _G["actAltMount"]:GetChecked();
	ShiGuangPerDB.ActFShiftMountBool = _G["actShiftMount"]:GetChecked();
	ShiGuangPerDB.ActFDragonFlyingMountBool = _G["actDragonflyingMount"]:GetChecked();
	ShiGuangPerDB.ActFGroundMountBool = _G["actGroundMount"]:GetChecked();
end

--Function for resetting values to default.
local function setValuesToDefault()
	actConfigWindow.ActsFMinIlvl.editBox:SetNumber(210);
	actConfigWindow.ActsFMinQuality.dropDown.quality = 2;
	actConfigWindow.ActsFMaxQuality.dropDown.quality = 2;

	_G["actDeArmor"]:SetChecked(false);
	_G["actDeWeapon"]:SetChecked(false);

	_G["actAltMount"]:SetChecked(false);
	_G["actCtrlMount"]:SetChecked(false);
	_G["actShiftMount"]:SetChecked(false);
	_G["actDragonflyingMount"]:SetChecked(false);
	_G["actGroundMount"]:SetChecked(false);

	actConfigWindow.ActFCtrlMount.editBox:SetText("");
	actConfigWindow.ActFAltMount.editBox:SetText("");
	actConfigWindow.ActFShiftMount.editBox:SetText("");
	actConfigWindow.ActFDragonFlyingMount.editBox:SetText("");
	actConfigWindow.ActFGroundMount.editBox:SetText("");
	actConfigWindow.ActFDefaultMount.editBox:SetText("");
end


-----------------------
-----EVENT HANDLING----
-----------------------

loadFrame:RegisterEvent("ADDON_LOADED");
loadFrame:SetScript("OnEvent", function(_, event)
	if event == "ADDON_LOADED" then
		updateConfigWindow();
		loadFrame:UnregisterEvent("ADDON_LOADED");
	end
end);

if GetLocale() == "zhCN" then
  ActsFunctionsLocal = "|cff33ff99[便捷]|r副业功能";
elseif GetLocale() == "zhTW" then
  ActsFunctionsLocal = "|cff33ff99[便捷]|r副业功能";
else
  ActsFunctionsLocal = "Act's Functions";
end

-----------------------
-----CONFIG WINDOW-----
-----------------------

--Add config to standard wow interface window.
local category = Settings.RegisterCanvasLayoutCategory(actConfigWindow, ActsFunctionsLocal);
Settings.RegisterAddOnCategory(category);

--Create DE checkboxes.
createCheckbutton("TOPLEFT", "actDeArmor", actConfigWindow, 12, -30, "开启装备分解", "如果勾选，插件将分解装备。");
createCheckbutton("TOPLEFT", "actDeWeapon", actConfigWindow, 12, -60, "开启武器分解", "如果勾选，插件将分解武器。");

--Create frames to hold the minIlvl setting.
actConfigWindow.ActsFMinIlvl = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.ActsFMinIlvl.editBox = CreateFrame("EditBox", nil, actConfigWindow.ActsFMinIlvl, "InputBoxTemplate");
editBoxFactory(actConfigWindow.ActsFMinIlvl, actConfigWindow.ActsFMinIlvl.editBox, 25, -10, "分解的最低装等：");

--Create quality dropdowns
actConfigWindow.ActsFMinQuality = CreateFrame("frame", nil, actConfigWindow);
actConfigWindow.ActsFMinQuality.dropDown = CreateFrame("frame", nil, actConfigWindow.ActsFMinQuality, "UiDropDownMenuTemplate");
qualityDropDownFactory(actConfigWindow.ActsFMinQuality, actConfigWindow.ActsFMinQuality.dropDown, -35, -45, "最低稀有度：");

actConfigWindow.ActsFMaxQuality = CreateFrame("frame", nil, actConfigWindow);
actConfigWindow.ActsFMaxQuality.dropDown = CreateFrame("frame", nil, actConfigWindow.ActsFMaxQuality, "UiDropDownMenuTemplate");
qualityDropDownFactory(actConfigWindow.ActsFMaxQuality, actConfigWindow.ActsFMaxQuality.dropDown, -35, -85, "最高稀有度：");

--Create mount editboxes

actConfigWindow.ActFCtrlMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.ActFCtrlMount.editBox = CreateFrame("EditBox", nil, actConfigWindow.ActFCtrlMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.ActFCtrlMount,
	actConfigWindow.ActFCtrlMount.editBox,
	45,
	-130,
	"CTRL 坐骑：",
	"actCtrlMount",
	true
);

actConfigWindow.ActFAltMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.ActFAltMount.editBox = CreateFrame("EditBox", nil, actConfigWindow.ActFAltMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.ActFAltMount, 
	actConfigWindow.ActFAltMount.editBox,
	45,
	-170,
	"ALT 坐骑：",
	"actAltMount",
	true
);

actConfigWindow.ActFShiftMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.ActFShiftMount.editBox = CreateFrame("EditBox", nil, actConfigWindow.ActFShiftMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.ActFShiftMount,
	actConfigWindow.ActFShiftMount.editBox,
	45,
	-210,
	"SHIFT 坐骑：",
	"actShiftMount",
	true
);

actConfigWindow.ActFDragonFlyingMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.ActFDragonFlyingMount.editBox = CreateFrame("EditBox", nil, actConfigWindow.ActFDragonFlyingMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.ActFDragonFlyingMount,
	actConfigWindow.ActFDragonFlyingMount.editBox,
	45,
	-250,
	"飞行坐骑：",
	"actDragonflyingMount",
	true
);

actConfigWindow.ActFGroundMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.ActFGroundMount.editBox = CreateFrame("Editbox", nil, actConfigWindow.ActFGroundMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.ActFGroundMount,
	actConfigWindow.ActFGroundMount.editBox,
	45,
	-290,
	"地面坐骑：",
	"actGroundMount",
	true
);

actConfigWindow.ActFDefaultMount = CreateFrame("Frame", nil, actConfigWindow);
actConfigWindow.ActFDefaultMount.editBox = CreateFrame("EditBox", nil, actConfigWindow.ActFDefaultMount, "InputBoxTemplate");
mountEditBoxFactory(
	actConfigWindow.ActFDefaultMount,
	actConfigWindow.ActFDefaultMount.editBox,
	45,
	-330,
	"默认坐骑：",
	"actDefaultMount"
);


--Create and set title of the setting.
actConfigWindow.title = actConfigWindow:CreateFontString(nil,"OVERLAY");
actConfigWindow.title:SetFontObject("GameFontNormalLarge");
actConfigWindow.title:SetPoint("TOPLEFT", actConfigWindow, "TOPLEFT", 15, -5);
actConfigWindow.title:SetText(ActsFunctionsLocal .. " version:2.1.8" );

actConfigWindow:Hide();
actConfigWindow:SetScript("OnShow", function(_) updateConfigWindow(); end);
actConfigWindow:SetScript("OnHide", function(_) saveData(); end);


-----------------------
---GLOBAL FUNCTIONS----
-----------------------

--Create a "global" config toggle function so the settings window can be opened from the init.lua file code.
function functions.toggleActConfig()
	Settings.OpenToCategory(category:GetID());
end


-----------------------
----LOCAL VARIABLES----
-----------------------

local loadFrame = CreateFrame("FRAME");

-----------------------
--FUNCTION DEFINITIONS-
-----------------------

--Fill tracking array.
local function fillTrackingArray()
	for i = 1 , C_Minimap.GetNumTrackingTypes() do
		local TrackingItemTable = C_Minimap.GetTrackingInfo(i);

		local s1, type, _ = strsplit(" ", TrackingItemTable["name"], 3);

		if
			TrackingItemTable["type"] == "spell" and
			s1 == "Track" and
			type ~= nil
		then
			if string.match(type, "s", -1) then
				type = type:sub(1, -2);
			end

			table.foreach(
				variables.trackingArray,
				function(key, value)
					if key == type and value ~= i then
						variables.trackingArray[key] = i;
					end
				end
			);
		end
	end
end


-----------------------
-----EVENT HANDLING----
-----------------------

loadFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
loadFrame:SetScript("OnEvent", function(_, event, _)
	if event == "PLAYER_ENTERING_WORLD" then
		fillTrackingArray();
		loadFrame:UnregisterEvent("PLAYER_ENTERING_WORLD");
	end
end);
