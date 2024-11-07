--Author: JamienAU  Version: r21  SavedVariables: rhDB  IconTexture: Interface\Icons\Inv_misc_rune_01

--[[

Random Hearthstone
======================================================================================================================================================
If there's a new hearthstone but the addon isn't being updated simply add it to the bottom of the list below.
ItemID can be found from the URL of the item page on Wowhead.com

Weary Spirit Binding (ID: 163206) does not appear to be in-game. Adding it to the list below will cause errors!

If you would like to contribute to localisation translations please reach out on:
	Github	https://github.com/JamienAU/RandomHearth/
	Curse	https://legacy.curseforge.com/private-messages/send?recipient=jamienau

]]

local RHL = {}
-- zhCN
if GetLocale() == "zhCN" then
    RHL["ADDON_NAME"] = "|cff33ff99[便捷]|r随机炉石"
    RHL["NO_VALID_CHOSEN"] = "|cff42E400随机炉石|r - 没有选择有效的炉石玩具。 设置宏来使用炉石玩具"
    RHL["MACRO_NAME"] = "_"
    RHL["RENOWN_LOCKED"] = "盟约锁定"
    RHL["THANKS"] = "谢谢你使用我的插件"
    RHL["DESCRIPTION"] = "在列表中选择启用或禁用循环炉石玩具"
    RHL["SELECT_ALL"] = "全部启用"
    RHL["DESELECT_ALL"] = "全部禁用"
    RHL["OPT_MACRO_ICON"] = "宏图标"
    RHL["COV_ONLY"] = "仅允许玩家使用当前盟约的炉石"
    RHL["DAL_R_CLICK"] = "鼠标右键点击宏使用达拉然炉石"
    RHL["GAR_M_CLICK"] = "鼠标中键点击宏使用要塞炉石"
    RHL["SETUP_1"] = "设置随机炉石数据库"
    RHL["SETUP_2"] = "现在您可以用鼠标右键点击达拉然炉石，用鼠标中键点击要塞炉石。"
    RHL["SETUP_3"] = "这些设置可以在选项中更改，输入 /rh"
    RHL["RANDOM"] = "随机"
    RHL["HEARTHSTONE"] = "炉石"
    RHL["MACRO_NOT_FOUND"] = "|cff42E400随机炉石|r - 未找到宏，正在创建宏名为 '"
    RHL["UPDATE_MACRO_NAME"] = "|cff42E400随机炉石|r - 更新宏名为 '"
    RHL["UNIQUE_NAME_ERROR"] = "使用中的宏名称！\n请选择一个唯一的名字。"
    RHL["OPT_MACRO_NAME"] = "宏名字"
elseif GetLocale() == "zhTW" then
    RHL["ADDON_NAME"] = "|cff33ff99[便捷]|r隨機爐石"
    RHL["NO_VALID_CHOSEN"] = "|cff42E400隨機爐石|r - 沒有選擇有效的爐石玩具。 設定巨集來使用爐石玩具"
    RHL["MACRO_NAME"] = "_"
    RHL["RENOWN_LOCKED"] = "誓盟鎖定"
    RHL["THANKS"] = "感謝您使用我的插件"
    RHL["DESCRIPTION"] = "在清單中選擇使用的循環爐石玩具"
    RHL["SELECT_ALL"] = "全選"
    RHL["DESELECT_ALL"] = "取消全選"
    RHL["OPT_MACRO_ICON"] = "巨集圖示"
    RHL["COV_ONLY"] = "只允許使用當前誓盟的爐石"
    RHL["DAL_R_CLICK"] = "滑鼠右鍵點擊使用達拉然爐石"
    RHL["GAR_M_CLICK"] = "滑鼠中鍵點擊使用要塞爐石"
    RHL["SETUP_1"] = "設定隨機爐石數據庫"
    RHL["SETUP_2"] = "現在您可以滑鼠右鍵使用達拉然爐石，滑鼠中鍵使用要塞爐石。"
    RHL["SETUP_3"] = "這些設定可以在選項中更改，請輸入 /rh"
    RHL["RANDOM"] = "隨機"
    RHL["HEARTHSTONE"] = "爐石"
    RHL["MACRO_NOT_FOUND"] = "|cff42E400隨機爐石|r - 未找到巨集，正在建立巨集名為 '"
    RHL["UPDATE_MACRO_NAME"] = "|cff42E400隨機爐石|r - 更新巨集名為 '"
    RHL["UNIQUE_NAME_ERROR"] = "使用中的巨集名稱！\n請選擇一個唯一的名字。"
    RHL["OPT_MACRO_NAME"] = "巨集名字"
else
RHL["ADDON_NAME"] = "Random Hearthstone"
RHL["NO_VALID_CHOSEN"] = "|cff42E400Random Hearthstone|r - No valid toy chosen. Setting macro to use Hearthstone"
RHL["MACRO_NAME"] = "Random Hearth"
RHL["RENOWN_LOCKED"] = "Renown locked"
RHL["THANKS"] = "Thanks for using my addon"
RHL["DESCRIPTION"] = "Add or remove hearthstone toys from rotation"
RHL["SELECT_ALL"] = "Select all"
RHL["DESELECT_ALL"] = "Deselect all"
RHL["OPT_MACRO_ICON"] = "Macro icon"
RHL["COV_ONLY"] = "Allow player's current Covenant hearthstone only"
RHL["DAL_R_CLICK"] = "Cast Dalaran Hearth on macro right click"
RHL["GAR_M_CLICK"] = "Cast Garrison Hearth on macro middle click"
RHL["SETUP_1"] = "Setting up Random Hearthstone database."
RHL["SETUP_2"] = "You can now cast Dalaran hearth with right click, and Garrison hearth with middle mouse button."
RHL["SETUP_3"] = "These settings can be changed in the options, type /rh"
RHL["RANDOM"] = "Random"
RHL["HEARTHSTONE"] = "Hearthstone"
RHL["MACRO_NOT_FOUND"] = "|cff42E400Random Hearthstone|r - Macro not found, creating macro named '"
RHL["UPDATE_MACRO_NAME"] = "|cff42E400Random Hearthstone|r - Updating macro name to '"
RHL["UNIQUE_NAME_ERROR"] = "Macro name in use!\nPlease pick a unique name."
RHL["OPT_MACRO_NAME"] = "Macro name"
RHL["LOGIN_MESSAGE"] = "|cff42E400Random Hearthstone|r - Macro name can now be customised. Type /rh to open options."
end


------------------------------------------------------------------------------------------------------------------------------------------------------
local rhToys = {
	184353, --Kyrian Hearthstone
	183716, --Venthyr Sinstone
	180290, --Night Fae Hearthstone
	182773, --Necrolord Hearthstone
	54452, --Ethereal Portal
	64488, --The Innkeeper's Daughter
	93672, --Dark Portal
	142542, --Tome of Town Portal
	162973, --Greatfather Winter's Hearthstone
	163045, --Headless Horseman's Hearthstone
	165669, --Lunar Elder's Hearthstone
	165670, --Peddlefeet's Lovely Hearthstone
	165802, --Noble Gardener's Hearthstone
	166746, --Fire Eater's Hearthstone
	166747, --Brewfest Reveler's Hearthstone
	168907, --Holographic Digitalization Hearthstone
	172179, --Eternal Traveler's Hearthstone
	193588, --Timewalker's Hearthstone
	188952, --Dominated Hearthstone
	200630, --Ohn'ir Windsage's Hearthstone
	190237, --Broker Translocation Matrix
	190196, --Enlightened Hearthstone
	209035, --Hearthstone of the Flame
	208704, --Deepdweller's Earthen Hearthstone
	206195, --Path of the Naaru
	212337, --Stone of the Hearth
	210455, --Draenic Hologem
	228940, --Notorious Thread's Hearthstone
}

------------------------------------------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW HERE
-- Unless you want to, I'm not your supervisor.

local rhList, macroIcon, macroToyName, macroTimer, waitTimer
local rhCheckButtons, wait, lastRnd, loginMsg = {}, false, 0, "r24"
local playerClass = select(3,UnitClass("player"))
local RH = {}

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Frames
------------------------------------------------------------------------------------------------------------------------------------------------------
local rhOptionsPanel = CreateFrame("Frame")
local rhCategory = Settings.RegisterCanvasLayoutCategory(rhOptionsPanel, RHL["ADDON_NAME"])
local rhTitle = CreateFrame("Frame", nil, rhOptionsPanel)
local rhDesc = CreateFrame("Frame", nil, rhOptionsPanel)
local rhOptionsScroll = CreateFrame("ScrollFrame", nil, rhOptionsPanel, "UIPanelScrollFrameTemplate")
local rhDivider = rhOptionsScroll:CreateLine()
local rhScrollChild = CreateFrame("Frame")
local rhSelectAll = CreateFrame("Button", nil, rhOptionsScroll, "UIPanelButtonTemplate")
local rhDeselectAll = CreateFrame("Button", nil, rhOptionsScroll, "UIPanelButtonTemplate")
local rhOverride = CreateFrame("CheckButton", nil, rhOptionsScroll, "UICheckButtonTemplate")
local rhListener = CreateFrame("Frame")
local rhBtn = CreateFrame("Button", "rhB", nil, "SecureActionButtonTemplate")
local rhDropdown = CreateFrame("Frame", nil, rhOptionsPanel, "UIDropDownMenuTemplate")
local rhDalHearth = CreateFrame("CheckButton", nil, rhOptionsPanel, "UICheckButtonTemplate")
local rhGarHearth = CreateFrame("CheckButton", nil, rhOptionsPanel, "UICheckButtonTemplate")
local rhMacroName = CreateFrame("EditBox", nil, rhOptionsPanel, "InputBoxTemplate")

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Functions
------------------------------------------------------------------------------------------------------------------------------------------------------
-- Combat Check
local function combatCheck()
	if (InCombatLockdown() or UnitAffectingCombat("player") or UnitAffectingCombat("pet")) then
		return true
	end
end

-- Create or update global macro
local function updateMacro()
	if not combatCheck() then
		local macroText
		if #rhList == 0 then
			if rhDB.settings.warnMsg ~= true then
				rhDB.settings.warnMsg = true
				print(RHL["NO_VALID_CHOSEN"])
			end
			macroText = "#showtooltip " .. macroToyName .. "\n/use " .. macroToyName
		else
			-- Add cancelform to macro if player is a druid
			if playerClass == 11 then
				macroText = "#showtooltip " .. macroToyName .. "\n/cancelform\n/stopcasting\n/click [btn:2]rhB 2;[btn:3]rhB 3;rhB"
			else
				macroText = "#showtooltip " .. macroToyName .. "\n/stopcasting\n/click [btn:2]rhB 2;[btn:3]rhB 3;rhB"
			end
		end
		if macroTimer ~= true then
			macroTimer = true
			C_Timer.After(0.1, function()
				local macroIndex = GetMacroIndexByName(rhDB.settings.macroName)
				if macroIndex == 0 then
					--print(RHL["MACRO_NOT_FOUND"], rhDB.settings.macroName, "'")
					CreateMacro(rhDB.settings.macroName, macroIcon, macroText, nil)
					rhMacroName:SetText(rhDB.settings.macroName)
				else
					EditMacro(macroIndex, nil, macroIcon, macroText)
				end
				macroTimer = false
			end)
		end
	end
end

local function updateMacroName()
	if not combatCheck() then
		local name = rhMacroName:GetText()
		local macroIndex = GetMacroIndexByName(rhDB.settings.macroName)
		if macroIndex == 0 then
			updateMacro()
		else
			EditMacro(macroIndex, name)
			rhDB.settings.macroName = name
			--print(RHL["UPDATE_MACRO_NAME"], name, "'")
		end
	end
end

local function checkMacroName()
	if not combatCheck() then
		local name = rhMacroName:GetText()
		if name == rhDB.settings.macroName or string.len(name) == 0 then return end
		if GetMacroIndexByName(name) == 0 then
			rhMacroName.Icon:Hide()
			updateMacroName()
		end
	end
end
-- Set random Hearthstone
local function setRandom()
	if not combatCheck() then
		if #rhList > 0 then
			local rnd = rhList[math.random(1, #rhList)]
			if #rhList > 1 then
				while rnd == lastRnd do
					rnd = rhList[math.random(1, #rhList)]
				end
				lastRnd = rnd
			end
			macroToyName = rhDB.RHL.tList[rnd]["name"]
			rhBtn:SetAttribute("toy", macroToyName)
			if rhDB.iconOverride.name == RHL["RANDOM"] then
				macroIcon = rhDB.RHL.tList[rnd]["icon"]
			else
				macroIcon = rhDB.iconOverride.icon
			end
		else
			macroToyName = "item:6948"
			macroIcon = 134414
		end
		updateMacro()
	end
end

-- Generate a list of valid toys
local function listGenerate()
	rhList = {}
	local allCovenant
	local covenantHearths = {
		-- {Criteria index, Covenant index, Covenant toy, Enabled}
		{ 1, 1, 184353, false }, --Kyrian
		{ 4, 2, 183716, false }, --Venthyr
		{ 3, 3, 180290, false }, --Night Fae
		{ 2, 4, 182773, false } --Necrolord
	}
	for i, v in pairs(covenantHearths) do
		if select(3, GetAchievementCriteriaInfo(15646, v[1])) == true then
			covenantHearths[i][4] = true
		elseif C_Covenants.GetActiveCovenantID() ~= v[2] then
			if rhDB.RHL.tList[v[3]] ~= nil then
				rhCheckButtons[v[3]].Extratext = rhCheckButtons[v[3]]:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				rhCheckButtons[v[3]].Extratext:SetText("|cff777777(" .. RHL["RENOWN_LOCKED"] .. ")|r")
				rhCheckButtons[v[3]].Extratext:SetPoint("LEFT", rhCheckButtons[v[3]].Text, "RIGHT", 10, 0)
			end
		end
	end

	if select(4, GetAchievementInfo(15241)) == true then
		if rhDB.settings.covOverride == true then
			allCovenant = false
		else
			allCovenant = true
		end
	end

	for i, v in pairs(rhDB.RHL.tList) do
		if v["status"] == true then
			if PlayerHasToy(i) then
				local addToy = true
				-- Check for Covenant
				for _, k in pairs(covenantHearths) do
					if i == k[3] then
						if k[4] == false and C_Covenants.GetActiveCovenantID() ~= k[2] then
							addToy = false
						elseif allCovenant == false and C_Covenants.GetActiveCovenantID() ~= k[2] then
							addToy = false
							break
						end
					end
				end
				-- Check Draenai
				if i == 210455 then
					local _, _, raceID = UnitRace("player")
					if not (raceID == 11 or raceID == 30) then
						addToy = false
					end
				end
				-- Create the list
				if addToy == true then
					table.insert(rhList, i)
				end
			end
		end
	end
	setRandom()
end

-- Update Hearthstone selections when options panel closes
local function rhOptionsOkay()
	for i, v in pairs(rhDB.RHL.tList) do
		v["status"] = rhCheckButtons[i]:GetChecked()
	end
	rhDB.settings.covOverride = rhOverride:GetChecked()
	rhDB.settings.dalOpt = rhDalHearth:GetChecked()
	rhDB.settings.garOpt = rhGarHearth:GetChecked()
	rhDB.settings.warnMsg = false
	listGenerate()
end

-- Macro icon selection
local function rhDropDownOnClick(self, arg1)
	if arg1 == "Random" then
		rhDB.iconOverride.name = RHL["RANDOM"]
		rhDB.iconOverride.icon = 134400
		rhDB.iconOverride.id = nil
	elseif arg1 == "Hearthstone" then
		rhDB.iconOverride.name = RHL["HEARTHSTONE"]
		rhDB.iconOverride.icon = 134414
		rhDB.iconOverride.id = 6948
	else
		rhDB.iconOverride.name = rhDB.RHL.tList[arg1]["name"]
		rhDB.iconOverride.icon = rhDB.RHL.tList[arg1]["icon"]
		rhDB.iconOverride.id = arg1
	end
	UIDropDownMenu_SetText(rhDropdown, rhDB.iconOverride.name)
	rhDropdown.Texture:SetTexture(rhDB.iconOverride.icon)
	CloseDropDownMenus()
end

-- Add items in savedvariable
local function rhInitDB(table, item, value)
	local isTable = type(value) == "table"
	local exists = false
	-- Check if the item already exists in the table
	for k, v in pairs(table) do
		if k == item or (type(v) == "table" and isTable and v == value) then
			exists = true
			break
		end
	end
	-- If the item does not exist, add it
	if not exists then
		if value ~= nil then
			-- Add item with a value
			table[item] = value
		else
			-- Add item without a value
			table.insert(table, item)
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Button creation
------------------------------------------------------------------------------------------------------------------------------------------------------
rhBtn:RegisterForClicks("AnyDown")
rhBtn:SetAttribute("pressAndHoldAction", true)
rhBtn:SetAttribute("type", "toy")
rhBtn:SetAttribute("typerelease", "toy")
rhBtn:SetScript("PreClick", function(self, button, isDown)
	if not combatCheck() then
		if (button == "2" or button == "RightButton") and rhDB.settings.dalOpt then
			rhBtn:SetAttribute("toy", rhDB.RHL.dalaran)
		elseif (button == "3" or button == "MiddleButton") and rhDB.settings.garOpt then
			rhBtn:SetAttribute("toy", rhDB.RHL.garrison)
		end
	end
end)
rhBtn:SetScript("PostClick", function(self, button)
	if not combatCheck() then
		if (button == "2" or button == "RightButton") and rhDB.settings.dalOpt then
			rhBtn:SetAttribute("toy", macroToyName)
		elseif (button == "3" or button == "MiddleButton") and rhDB.settings.garOpt then
			rhBtn:SetAttribute("toy", macroToyName)
		else
			setRandom()
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Options panel
------------------------------------------------------------------------------------------------------------------------------------------------------
rhOptionsPanel.name = RHL["ADDON_NAME"]  --"Random Hearthstone"
rhOptionsPanel.OnCommit = function() rhOptionsOkay(); end
rhOptionsPanel.OnDefault = function() end
rhOptionsPanel.OnRefresh = function() end
Settings.RegisterAddOnCategory(rhCategory)

-- Title
rhTitle:SetPoint("TOPLEFT", 10, -10)
rhTitle:SetWidth(SettingsPanel.Container:GetWidth() - 35)
rhTitle:SetHeight(1)
rhTitle.Text = rhTitle:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
rhTitle.Text:SetPoint("TOPLEFT", rhTitle, 0, 0)
rhTitle.Text:SetText(RHL["ADDON_NAME"])

-- Thanks
rhOptionsPanel.Thanks = rhOptionsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
rhOptionsPanel.Thanks:SetPoint("TOPRIGHT", rhOptionsPanel, "TOPRIGHT", -5, -5)
rhOptionsPanel.Thanks:SetTextColor(1, 1, 1, 0.5)
rhOptionsPanel.Thanks:SetText(RHL["THANKS"] .. " :)\nNiian - Khaz'Goroth")
rhOptionsPanel.Thanks:SetJustifyH("RIGHT")

-- Description
rhDesc:SetPoint("TOPLEFT", 20, -40)
rhDesc:SetWidth(SettingsPanel.Container:GetWidth() - 35)
rhDesc:SetHeight(1)
rhDesc.Text = rhDesc:CreateFontString(nil, "OVERLAY", "GameFontNormal")
rhDesc.Text:SetPoint("TOPLEFT", rhDesc, 0, 0)
rhDesc.Text:SetText(RHL["DESCRIPTION"])

-- Scroll Frame
rhOptionsScroll:SetPoint("TOPLEFT", 5, -60)
rhOptionsScroll:SetPoint("BOTTOMRIGHT", -25, 150)

-- Divider
rhDivider:SetStartPoint("BOTTOMLEFT", rhDivider:GetParent(), 20, -10)
rhDivider:SetEndPoint("BOTTOMRIGHT", rhDivider:GetParent(), 0, -10)
rhDivider:SetColorTexture(0.25, 0.25, 0.25, 1)
rhDivider:SetThickness(1.2)

-- Scroll Frame child
rhOptionsScroll:SetScrollChild(rhScrollChild)
rhScrollChild:SetWidth(SettingsPanel.Container:GetWidth() - 35)
rhScrollChild:SetHeight(1)

-- Checkbox for each toy
local chkOffset = 0
for i = 1, #rhToys do
	if i > 1 then
		chkOffset = chkOffset + -26
	end
	rhCheckButtons[rhToys[i]] = CreateFrame("CheckButton", nil, rhScrollChild, "UICheckButtonTemplate")
	rhCheckButtons[rhToys[i]]:SetPoint("TOPLEFT", 15, chkOffset)
	rhCheckButtons[rhToys[i]]:SetSize(25, 25)
	rhCheckButtons[rhToys[i]].Text = rhCheckButtons[rhToys[i]]:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	local item = Item:CreateFromItemID(rhToys[i])
	item:ContinueOnItemLoad(function()
		rhCheckButtons[rhToys[i]].Text:SetText(item:GetItemName())
	end)
	rhCheckButtons[rhToys[i]].Text:SetTextColor(1, 1, 1, 1)
	rhCheckButtons[rhToys[i]].Text:SetPoint("LEFT", 28, 0)
end

-- Select All button
rhSelectAll:SetPoint("TOPLEFT", rhSelectAll:GetParent(), "BOTTOMLEFT", 20, -20)
rhSelectAll:SetSize(100, 25)
rhSelectAll:SetText(RHL["SELECT_ALL"])
rhSelectAll:SetScript("OnClick", function(self)
	for i, v in pairs(rhCheckButtons) do
		v:SetChecked(true)
	end
end)

-- Deselect All button
rhDeselectAll:SetPoint("TOPLEFT", rhDeselectAll:GetParent(), "BOTTOMLEFT", 135, -20)
rhDeselectAll:SetSize(100, 25)
rhDeselectAll:SetText(RHL["DESELECT_ALL"])
rhDeselectAll:SetScript("OnClick", function(self)
	for i, v in pairs(rhCheckButtons) do
		v:SetChecked(false)
	end
end)

-- Macro override dropdown
rhDropdown:SetPoint("TOPRIGHT", rhOverride:GetParent(), "BOTTOMRIGHT", 0, -35)
rhDropdown.Texture = rhDropdown:CreateTexture()
rhDropdown.Texture:SetSize(24, 24)
rhDropdown.Texture:SetPoint("LEFT", rhDropdown, "RIGHT", -10, 2)
rhDropdown.Extratext = rhDropdown:CreateFontString(nil, "OVERLAY", "GameFontNormal")
rhDropdown.Extratext:SetText(RHL["OPT_MACRO_ICON"])
rhDropdown.Extratext:SetPoint("BOTTOMLEFT", rhDropdown, "TOPLEFT", 25, 5)

-- Covenant override checkbox
rhOverride:SetPoint("TOPLEFT", rhOverride:GetParent(), "BOTTOMLEFT", 15, -50)
rhOverride:SetSize(25, 25)
rhOverride.Text:SetJustifyH("LEFT")
rhOverride.Text:SetText(" " .. RHL["COV_ONLY"])
rhOverride.Text:SetTextColor(1, 1, 1, 1)

-- Dalaran hearth checkbox
rhDalHearth:SetPoint("TOPLEFT", rhOverride, "BOTTOMLEFT", 0, 0)
rhDalHearth:SetSize(25, 25)
rhDalHearth.Text:SetJustifyH("LEFT")
rhDalHearth.Text:SetText(" " .. RHL["DAL_R_CLICK"])
rhDalHearth.Text:SetTextColor(1, 1, 1, 1)

-- Garrison hearth checkbox
rhGarHearth:SetPoint("TOPLEFT", rhDalHearth, "BOTTOMLEFT", 0, 0)
rhGarHearth:SetSize(25, 25)
rhDalHearth.Text:SetJustifyH("LEFT")
rhGarHearth.Text:SetText(" " .. RHL["GAR_M_CLICK"])
rhGarHearth.Text:SetTextColor(1, 1, 1, 1)

-- Custom macro name box
rhMacroName:SetPoint("TOPLEFT", rhDropdown, "BOTTOMLEFT", 25, -20)
rhMacroName:SetAutoFocus(false)
rhMacroName:SetSize(208, 20)
rhMacroName:SetFontObject("GameFontNormal")
rhMacroName:SetTextColor(1, 1, 1, 1)
rhMacroName:SetMaxLetters(16)
rhMacroName.Text = rhMacroName:CreateFontString(nil, "OVERLAY", "GameFontNormal")
rhMacroName.Text:SetText(RHL["OPT_MACRO_NAME"])
rhMacroName.Text:SetPoint("BOTTOMLEFT", rhMacroName, "TOPLEFT", 0, 5)
rhMacroName.Exist = rhMacroName:CreateFontString(nil, "OVERLAY", "GameFontNormal")
rhMacroName.Exist:SetTextColor(1, 0, 0, 1)
rhMacroName.Exist:SetJustifyH("LEFT")
rhMacroName.Exist:SetPoint("TOPLEFT", rhMacroName, "BOTTOMLEFT", 0, -5)
rhMacroName.Exist:SetText(RHL["UNIQUE_NAME_ERROR"])
rhMacroName.Exist:Hide()
rhMacroName.Icon = rhMacroName:CreateTexture(nil, "OVERLAY")
rhMacroName.Icon:SetPoint("LEFT", rhMacroName, "RIGHT", 5, 0)
rhMacroName.Icon:SetTexture("Interface/COMMON/CommonIcons.PNG")
rhMacroName.Icon:SetSize(24, 24)
rhMacroName:SetScript("OnShow", function()
	rhMacroName.Exist:Hide()
	rhMacroName.Icon:Hide()
	rhMacroName:SetText(rhDB.settings.macroName)
end)
rhMacroName:SetScript("OnTextChanged", function(self, userInput)
	if userInput == true then
		-- Checking if the macro exists. Adding in a timer so it doesn't spam check on every key press.
		if waitTimer ~= true then
			waitTimer = true
			C_Timer.After(0.5, function()
				local name = rhMacroName:GetText()
				if name ~= rhDB.settings.macroName and GetMacroIndexByName(name) ~= 0 then
					rhMacroName.Exist:Show()
					rhMacroName.Icon:SetTexCoord(0.25, 0.38, 0, 0.26)
					rhMacroName.Icon:Show()
				elseif string.len(name) == 0 then
					rhMacroName.Icon:Hide()
				else
					rhMacroName.Exist:Hide()
					rhMacroName.Icon:SetTexCoord(0, 0.13, 0.51, 0.75)
					rhMacroName.Icon:Show()
				end
				waitTimer = false
			end)
		end
	end
end)
rhMacroName:SetScript("OnEditFocusLost", function() checkMacroName() end)
rhMacroName:SetScript("OnEnterPressed", function() checkMacroName() end)

-- Listener for addon loaded shenanigans
rhListener:RegisterEvent("ADDON_LOADED")
rhListener:RegisterEvent("PLAYER_ENTERING_WORLD")
rhListener:SetScript("OnEvent", function(self, event)
	if event == "ADDON_LOADED" then
		-- Set savedvariable defaults if first load or compare and update savedvariables with toy list
		if rhDB == nil then
			--print(RHL["SETUP_1"])
			--print(RHL["SETUP_2"])
			--print(RHL["SETUP_3"])
			rhDB = {}
		end
		rhInitDB(rhDB, "settings", {})
		rhInitDB(rhDB.settings, "covOverride", false)
		rhInitDB(rhDB.settings, "dalOpt", true)
		rhInitDB(rhDB.settings, "garOpt", true)
		rhInitDB(rhDB.settings, "macroName", RHL["MACRO_NAME"])
		rhInitDB(rhDB.settings, "loginMsg", "")
		rhInitDB(rhDB.settings, "warnMsg", false)
		rhInitDB(rhDB, "iconOverride", { name = "Random", icon = 134400 })
		rhInitDB(rhDB, "RHL", {})
		rhInitDB(rhDB.RHL, "locale", GetLocale())

		if rhDB.RHL.tList == nil then
			wait = true
			rhDB.RHL.tList = {}
			for i = 1, #rhToys do
				local item = Item:CreateFromItemID(rhToys[i])
				item:ContinueOnItemLoad(function()
					rhDB.RHL.tList[rhToys[i]] = {
						name = item:GetItemName(),
						icon = item:GetItemIcon(),
						status = true
					}
				end)
			end
		end

		rhDB.chkStatus = nil

		-- Remove IDs that no longer exist in rhToys list
		for i, v in pairs(rhDB.RHL.tList) do
			local exists = 0
			for l = 1, #rhToys do
				if i == rhToys[l] then
					exists = 1
				end
			end
			if exists == 0 then
				rhDB.RHL.tList[i] = nil
			end
		end

		-- Add any new IDs to saved variables as enabled
		for i = 1, #rhToys do
			if not rhDB.RHL.tList[rhToys[i]] then
				wait = true
				local item = Item:CreateFromItemID(rhToys[i])
				item:ContinueOnItemLoad(function()
					rhDB.RHL.tList[rhToys[i]] = {
						name = item:GetItemName(),
						icon = item:GetItemIcon(),
						status = true
					}
					rhCheckButtons[rhToys[i]]:SetChecked(true)
					if i == #rhToys then
						listGenerate()
					end
				end)
			end
		end

		-- Update rhDB if locale has changed
		if rhDB.RHL.locale ~= GetLocale() then
			-- Update main list
			for i, v in pairs(rhDB.RHL.tList) do
				local item = Item:CreateFromItemID(i)
				item:ContinueOnItemLoad(function()
					rhDB.RHL.tList[i]["name"] = item:GetItemName()
				end)
			end

			-- Update iconOverride
			if rhDB.iconOverride.id ~= nil then
				local item = Item:CreateFromItemID(rhDB.iconOverride.id)
				item:ContinueOnItemLoad(function()
					rhDB.iconOverride.name = item:GetItemName()
					UIDropDownMenu_SetText(rhDropdown, rhDB.iconOverride.name)
				end)
			end

			rhDB.RHL.locale = GetLocale()
		end

		-- Loop through options and set checkbox state
		for i, v in pairs(rhDB.RHL.tList) do
			rhCheckButtons[i]:SetChecked(v["status"])
		end

		-- Set localised name for Dalaran and Garrison hearths
		local tmp = { { "dalaran", 140192 }, { "garrison", 110560 } }
		for _, v in pairs(tmp) do
			local item = Item:CreateFromItemID(v[2])
			item:ContinueOnItemLoad(function()
				rhDB.RHL[v[1]] = item:GetItemName()
			end)
		end

		rhOverride:SetChecked(rhDB.settings.covOverride)
		rhDalHearth:SetChecked(rhDB.settings.dalOpt)
		rhGarHearth:SetChecked(rhDB.settings.garOpt)
		rhDropdown.Texture:SetTexture(rhDB.iconOverride.icon)
		UIDropDownMenu_SetText(rhDropdown, rhDB.iconOverride.name)
		UIDropDownMenu_SetWidth(rhDropdown, 200)
		UIDropDownMenu_SetAnchor(rhDropdown, 0, 0, "BOTTOM", rhDropdown, "TOP")
		UIDropDownMenu_Initialize(rhDropdown, function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func, info.topPadding, info.tSizeX, info.tSizeY = rhDropDownOnClick, 3, 15, 15
			info.arg1, info.text, info.checked, info.icon = "Random", RHL["Random"], rhDB.iconOverride.name == RHL["Random"],
				134400
			UIDropDownMenu_AddButton(info)
			info.arg1, info.text, info.checked, info.icon = "Hearthstone", RHL["Hearthstone"],
				rhDB.iconOverride.name == RHL["Hearthstone"], 134414
			UIDropDownMenu_AddButton(info)
			for i = 1, #rhToys do
				if rhDB.RHL.tList[rhToys[i]] ~= nil then
					info.arg1 = rhToys[i]
					info.text = rhDB.RHL.tList[rhToys[i]]["name"]
					info.checked = rhDB.iconOverride.name == rhDB.RHL.tList[rhToys[i]]["name"]
					info.icon = rhDB.RHL.tList[rhToys[i]]["icon"]
					UIDropDownMenu_AddButton(info)
				end
			end
		end)

		self:UnregisterEvent("ADDON_LOADED")
	end

	if event == "PLAYER_ENTERING_WORLD" then
		if not wait then
			listGenerate()
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create slash command
------------------------------------------------------------------------------------------------------------------------------------------------------
SLASH_RandomHearthstone1 = "/rh"
function SlashCmdList.RandomHearthstone(msg, editbox)
	Settings.OpenToCategory(rhCategory:GetID())
end

--[[
	Ignore this, it's for future me when Blizz breaks things again:
	/Interface/SharedXML/Settings/Blizzard_Settings.lua
]]
