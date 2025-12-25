local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert = tinsert
local UnitOnTaxi, TaxiRequestEarlyLanding, VehicleExit = UnitOnTaxi, TaxiRequestEarlyLanding, VehicleExit
local padding = R.Bars.padding

function Bar:UpdateVehicleButton()
	local frame = _G["OrzUI_ActionBarExit"]
	if not frame then return end

	local size = R.db["Actionbar"]["VehButtonSize"]
	local framSize = size + 2*padding
	frame.buttons[1]:SetSize(size, size)
	frame:SetSize(framSize, framSize)
	frame.mover:SetSize(framSize, framSize)
end

function Bar:CreateLeaveVehicle()
	local buttonList = {}

	local frame = CreateFrame("Frame", "OrzUI_ActionBarExit", UIParent, "SecureHandlerStateTemplate")
	frame.mover = M.Mover(frame, U["LeaveVehicle"], "LeaveVehicle", {"BOTTOM", UIParent, "BOTTOM", 310, 100})

	local button = CreateFrame("CheckButton", "OrzUI_LeaveVehicleButton", frame, "ActionButtonTemplate, SecureHandlerClickTemplate")
	tinsert(buttonList, button)
	button:SetPoint("BOTTOMLEFT", frame, padding, padding)
	button:RegisterForClicks("AnyUp")
	button.icon:SetTexture("INTERFACE\\PLAYERACTIONBARALT\\NATURAL")
	button.icon:SetTexCoord(.086, .168, .360, .441)
	button.icon:SetDrawLayer("ARTWORK")
	button.icon.__lockdown = true
	if button.Arrow then button.Arrow:SetAlpha(0) end

	button:SetScript("OnEnter", MainMenuBarVehicleLeaveButton.OnEnter)
	button:SetScript("OnLeave", M.HideTooltip)
	button:SetScript("OnClick", function(self)
		if UnitOnTaxi("player") then
			TaxiRequestEarlyLanding()
		else
			VehicleExit()
		end
		self:SetChecked(true)
	end)
	button:SetScript("OnShow", function(self)
		self:SetChecked(false)
	end)

	frame.buttons = buttonList

	frame.frameVisibility = "[canexitvehicle]c;[mounted]m;n"
	RegisterStateDriver(frame, "exit", frame.frameVisibility)

	frame:SetAttribute("_onstate-exit", [[ if CanExitVehicle() then self:Show() else self:Hide() end ]])
	if not CanExitVehicle() then frame:Hide() end
end