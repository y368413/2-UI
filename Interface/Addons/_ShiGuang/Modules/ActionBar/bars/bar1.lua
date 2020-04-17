local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:RegisterModule("Actionbar")
local cfg = R.bars.bar1

local function UpdateActionbarScale(bar)
	local frame = _G["NDui_Action"..bar]
	frame:SetScale(MaoRUIPerDB["Actionbar"]["Scale"])
	frame.mover:SetScale(MaoRUIPerDB["Actionbar"]["Scale"])
end

function Bar:UpdateAllScale()
	if not MaoRUIPerDB["Actionbar"]["Enable"] then return end

	UpdateActionbarScale("Bar1")
	UpdateActionbarScale("Bar2")
	UpdateActionbarScale("Bar3")
	UpdateActionbarScale("Bar4")
	UpdateActionbarScale("Bar5")

	UpdateActionbarScale("BarExtra")
	UpdateActionbarScale("BarZone")
	UpdateActionbarScale("BarExit")
	UpdateActionbarScale("BarPet")
	UpdateActionbarScale("BarStance")
end

function Bar:OnLogin()
	if not MaoRUIPerDB["Actionbar"]["Enable"] then return end

	local padding, margin = 2, 2
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}
	local layout = MaoRUIPerDB["Actionbar"]["Style"]

	--create the frame to hold the buttons
	local frame = CreateFrame("Frame", "NDui_ActionBar1", UIParent, "SecureHandlerStateTemplate")
	frame:SetWidth(num*cfg.size + (num-1)*margin + 2*padding)
	frame:SetHeight(cfg.size + 2*padding)
	if layout == 5 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -108, 2}
	elseif layout == 6 then
		frame.Pos = {"CENTER", UIParent, "CENTER", 105, -220}
	elseif layout == 9 then
	    frame:SetWidth(num*cfg.size + (num-1)*margin + 2*padding)
	    frame:SetHeight(cfg.size + 2*padding)
		frame.Pos = {"CENTER", UIParent, "CENTER", 76, -220}
	elseif layout == 10 then
		frame.Pos = {"CENTER", UIParent, "CENTER", 80, -220}
	else
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 2}
	end

	for i = 1, num do
		local button = _G["ActionButton"..i]
		table.insert(buttonList, button) --add the button object to the list
		button:SetParent(frame)
		button:SetSize(cfg.size, cfg.size)
		button:ClearAllPoints()
		if layout == 6 then
		  if i == 1 then
			  button:SetSize(cfg.size + 5, cfg.size + 5)
			  button:SetPoint("LEFT", frame, padding, 0)
		    elseif i == 7 then
			  button:SetSize(cfg.size, cfg.size)
			  button:SetPoint("RIGHT", _G["MultiBarRightButton2"], "LEFT", -margin, 0)
		    elseif i == 8 then
			  button:SetSize(cfg.size, cfg.size)
			  button:SetPoint("RIGHT", _G["ActionButton7"], "LEFT", -margin, 0)
		    elseif i == 9 then
			  button:SetSize(cfg.size + 8, cfg.size + 8)
			  button:SetPoint("TOPRIGHT", _G["ActionButton8"], "LEFT", -margin, 0)
		    elseif i == 10 then
			  button:SetSize(cfg.size, cfg.size)
			  button:SetPoint("LEFT", _G["MultiBarRightButton8"], "RIGHT", margin, 0)
			elseif i == 11 then
			  button:SetSize(cfg.size, cfg.size)
			  button:SetPoint("LEFT", _G["ActionButton10"], "RIGHT", margin, 0)
			elseif i == 12 then
			  button:SetSize(cfg.size + 8, cfg.size + 8)
			  button:SetPoint("TOPLEFT", _G["ActionButton11"], "RIGHT", margin, 0)
			else
			  button:SetSize(cfg.size + 5, cfg.size + 5)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", margin, 0)
			end
		elseif layout == 9 then
		  if i == 1 then
			  button:SetPoint("LEFT", frame, padding, 0)
		  elseif i == 9 then
			  local previous = _G["ActionButton1"]
			  button:SetPoint("TOPRIGHT", previous, "BOTTOM", -margin+10, 0)
			elseif i == 11 then
			  local previous = _G["ActionButton7"]
			  button:SetPoint("TOPLEFT", previous, "BOTTOM", margin-10, 0)
			else
			  local previous = _G["ActionButton"..i-1]
			  button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
			end
		elseif layout == 10 then
		  if i == 1 then
			  button:SetPoint("LEFT", frame, padding, 0)
		  elseif i == 9 then
			  local previous = _G["MultiBarRightButton1"]
			  button:SetPoint("RIGHT", previous, "LEFT", -margin, 0)
		  elseif i == 10 then
			  local previous = _G["ActionButton9"]
			  button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
			elseif i == 11 then
			  local previous = _G["MultiBarRightButton9"]
			  button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
			elseif i == 12 then
			  local previous = _G["ActionButton11"]
			  button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
			else
			  local previous = _G["ActionButton"..i-1]
			  button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
			end
		else
		  if i == 1 then
			  button:SetPoint("BOTTOMLEFT", frame, padding, padding)
		  else
			  local previous = _G["ActionButton"..i-1]
			  button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
		  end
		end
	end

	--show/hide the frame on a given state driver
	frame.frameVisibility = "[petbattle] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	--create drag frame and drag functionality
	if R.bars.userplaced then
		frame.mover = M.Mover(frame, U["Main Actionbar"], "Bar1", frame.Pos)
	end

	--create the mouseover functionality
	if cfg.fader then
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end

	--_onstate-page state driver
	local actionPage = "[bar:6]6;[bar:5]5;[bar:4]4;[bar:3]3;[bar:2]2;[overridebar]14;[shapeshift]13;[vehicleui]12;[possessbar]12;[bonusbar:5]11;[bonusbar:4]10;[bonusbar:3]9;[bonusbar:2]8;[bonusbar:1]7;1"
	local buttonName = "ActionButton"
	for i, button in next, buttonList do
		frame:SetFrameRef(buttonName..i, button)
	end

	frame:Execute(([[
		buttons = table.new()
		for i = 1, %d do
			table.insert(buttons, self:GetFrameRef("%s"..i))
		end
	]]):format(num, buttonName))

	frame:SetAttribute("_onstate-page", [[
		for _, button in next, buttons do
			button:SetAttribute("actionpage", newstate)
		end
	]])
	RegisterStateDriver(frame, "page", actionPage)

	--add elements
	self:CreateBar2()
	self:CreateBar3()
	self:CreateBar4()
	self:CreateBar5()
	self:CreateExtrabar()
	self:CreateLeaveVehicle()
	self:CreatePetbar()
	self:CreateStancebar()
	self:HideBlizz()
	self:ReskinBars()
	self:UpdateAllScale()
	self:CreateBackground()
	self:MicroMenu()

	--vehicle fix
	local function getActionTexture(button)
		return GetActionTexture(button.action)
	end

	M:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR", function()
		for _, button in next, buttonList do
			local icon = button.icon
			local texture = getActionTexture(button)
			if texture then
				icon:SetTexture(texture)
				icon:Show()
			else
				icon:Hide()
			end
		end
	end)
end

function Bar:CreateBackground()
	if not MaoRUIPerDB["Skins"]["BarLine"] then return end
	if MaoRUIPerDB["Actionbar"]["Scale"] ~= 1 then return end

	local cr, cg, cb = 0, 0, 0
	if MaoRUIPerDB["Skins"]["ClassLine"] then cr, cg, cb = I.r, I.g, I.b end

	local basic = 94
	if MaoRUIPerDB["Actionbar"]["Style"] == 4 then basic = 130 end

	local MactionbarL = CreateFrame("Frame", nil, UIParent)
	MactionbarL:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOM", 0, 4)
	M.CreateGF(MactionbarL, 250, basic, "Horizontal", 0, 0, 0, 0, .5)
	local MactionbarL1 = CreateFrame("Frame", nil, MactionbarL)
	MactionbarL1:SetPoint("BOTTOMRIGHT", MactionbarL, "TOPRIGHT")
	M.CreateGF(MactionbarL1, 230, R.mult, "Horizontal", cr, cg, cb, 0, .7)
	RegisterStateDriver(MactionbarL, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; show")

	local MactionbarR = CreateFrame("Frame", nil, UIParent)
	MactionbarR:SetPoint("BOTTOMLEFT", UIParent, "BOTTOM", 0, 4)
	M.CreateGF(MactionbarR, 250, basic, "Horizontal", 0, 0, 0, .5, 0)
	local MactionbarR1 = CreateFrame("Frame", nil, MactionbarR)
	MactionbarR1:SetPoint("BOTTOMLEFT", MactionbarR, "TOPLEFT")
	M.CreateGF(MactionbarR1, 230, R.mult, "Horizontal", cr, cg, cb, .7, 0)
	RegisterStateDriver(MactionbarR, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; show")

	-- OVERRIDEBAR
	local OverbarL = CreateFrame("Frame", nil, UIParent)
	OverbarL:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOM", 0, 4)
	M.CreateGF(OverbarL, 200, 57, "Horizontal", 0, 0, 0, 0, .5)
	local OverbarL1 = CreateFrame("Frame", nil, OverbarL)
	OverbarL1:SetPoint("BOTTOMRIGHT", OverbarL, "TOPRIGHT")
	M.CreateGF(OverbarL1, 200, R.mult, "Horizontal", cr, cg, cb, 0, .7)
	RegisterStateDriver(OverbarL, "visibility", "[petbattle]hide; [overridebar][vehicleui][possessbar,@vehicle,exists] show; hide")

	local OverbarR = CreateFrame("Frame", nil, UIParent)
	OverbarR:SetPoint("BOTTOMLEFT", UIParent, "BOTTOM", 0, 4)
	M.CreateGF(OverbarR, 200, 57, "Horizontal", 0, 0, 0, .5, 0)
	local OverbarR1 = CreateFrame("Frame", nil, OverbarR)
	OverbarR1:SetPoint("BOTTOMLEFT", OverbarR, "TOPLEFT")
	M.CreateGF(OverbarR1, 200, R.mult, "Horizontal", cr, cg, cb, .7, 0)
	RegisterStateDriver(OverbarR, "visibility", "[petbattle]hide; [overridebar][vehicleui][possessbar,@vehicle,exists] show; hide")
end