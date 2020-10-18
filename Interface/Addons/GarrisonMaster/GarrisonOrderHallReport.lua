local GarrisonOrderHallReportButtons = {}

GarrisonLandingPageMinimapButton:SetScript("OnClick", function(self, button, down)
	if button == GarrisonOrderHallReportButton then
		HideUIPanel(GarrisonLandingPage);
		ToggleDropDownMenu(1, nil, GarrisonReportDropDown, self, 0, 0)
	elseif button == "LeftButton" then
		GarrisonLandingPage_Toggle();
	end
end)

function GarrisonOrderHallReportFrameOnEvent(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "GarrisonOrderHallReport" then
		if GarrisonOrderHallReportButton == nil then
			GarrisonOrderHallReportButton = "RightButton"
		end
		self:UnregisterEvent("ADDON_LOADED")
	end
	if UnitLevel("player") >= 90 then
		GarrisonLandingPageMinimapButton:Show()
	end
end

function GarrisonReportDropDownOnLoad()
	local garrison = {}
	garrison.text = "Garrison"
	garrison.value = 2
	garrison.func = GarrisonReportDropDownOnClick
	local order = {}
	order.text = "Order Hall"
	order.value = 3
	order.func = GarrisonReportDropDownOnClick
	UIDropDownMenu_AddButton(garrison)
	UIDropDownMenu_AddButton(order)
end

function GarrisonReportDropDownOnClick(value)
	ShowGarrisonLandingPage(value.value)
end

function GarrisonOrderHallReportRadioButtonClick(self)
	for i=1, table.getn(GarrisonOrderHallReportButtons) do
		GarrisonOrderHallReportButtons[i]:SetChecked(false)
	end
	self:SetChecked(true)
end

function GarrisonOrderHallReportRadioButton(text, parent, x, y)
	local button = CreateFrame("CheckButton", nil, parent, "UIRadioButtonTemplate")
	local font = button:CreateFontString(nil, nil, "GameFontNormal")
	font:SetText(text)
	font:SetPoint("LEFT", x, 0)
	button:SetFontString(font)
	button:SetPoint("TOPLEFT", x, y)
	button:Show()
	button:SetScript("OnClick", GarrisonOrderHallReportRadioButtonClick)
	table.insert(GarrisonOrderHallReportButtons, button)
end

function GarrisonOrderHallReportOptionsRefresh()
	if GarrisonOrderHallReportButton == "RightButton" then
		GarrisonOrderHallReportButtons[1]:SetChecked(true)
		GarrisonOrderHallReportButtons[2]:SetChecked(false)
	else
		GarrisonOrderHallReportButtons[1]:SetChecked(false)
		GarrisonOrderHallReportButtons[2]:SetChecked(true)
	end
end

function GarrisonOrderHallReportOptionsOkay()
	if GarrisonOrderHallReportButtons[1]:GetChecked() then
		GarrisonOrderHallReportButton = "RightButton"
	else
		GarrisonOrderHallReportButton = "MiddleButton"
	end
end

local GarrisonOrderHallReportFrame = CreateFrame("FRAME", nil, UIParent)
GarrisonOrderHallReportFrame:RegisterEvent("ADDON_LOADED")
GarrisonOrderHallReportFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
GarrisonOrderHallReportFrame:RegisterEvent("PLAYER_UPDATE_RESTING")
GarrisonOrderHallReportFrame:RegisterEvent("ZONE_CHANGED")
GarrisonOrderHallReportFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
GarrisonOrderHallReportFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
GarrisonOrderHallReportFrame:RegisterEvent("PLAYER_LOGIN")
GarrisonOrderHallReportFrame:SetScript("OnEvent", GarrisonOrderHallReportFrameOnEvent)
GarrisonLandingPageMinimapButton:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
GarrisonReportDropDown = CreateFrame("FRAME", "GarrisonReportDropDown", UIParent, "UIDropDownMenuTemplate")
UIDropDownMenu_Initialize(GarrisonReportDropDown, GarrisonReportDropDownOnLoad, "MENU")

local GarrisonOrderHallReportOptions = CreateFrame("FRAME")
GarrisonOrderHallReportOptions.name = "Garrison Order Hall Report"
GarrisonOrderHallReportRadioButton("Right Mouse Button", GarrisonOrderHallReportOptions, 20, -20)
GarrisonOrderHallReportRadioButton("Middle Mouse Button", GarrisonOrderHallReportOptions, 20, -40)
GarrisonOrderHallReportOptions.refresh = GarrisonOrderHallReportOptionsRefresh
GarrisonOrderHallReportOptions.okay = GarrisonOrderHallReportOptionsOkay
GarrisonOrderHallReportOptions.cancel = GarrisonOrderHallReportOptionsRefresh
InterfaceOptions_AddCategory(GarrisonOrderHallReportOptions)