local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:RegisterModule("Actionbar")

local _G = _G
local tinsert, next = tinsert, next
local GetActionTexture = GetActionTexture
local cfg = R.Bars.bar1
local margin, padding = R.Bars.margin, R.Bars.padding

local function UpdateActionbarScale(bar)
	local frame = _G["NDui_Action"..bar]
	if not frame then return end

	local size = frame.buttonSize * R.db["Actionbar"]["Scale"]
	frame:SetFrameSize(size)
	for _, button in pairs(frame.buttonList) do
		--button:SetSize(size, size)
		button.Name:SetScale(R.db["Actionbar"]["Scale"])
		button.Count:SetScale(R.db["Actionbar"]["Scale"])
		button.HotKey:SetScale(R.db["Actionbar"]["Scale"])
	end
end

function Bar:UpdateAllScale()
	if not R.db["Actionbar"]["Enable"] then return end

	UpdateActionbarScale("Bar1")
	UpdateActionbarScale("Bar2")
	UpdateActionbarScale("Bar3")
	UpdateActionbarScale("Bar4")
	UpdateActionbarScale("Bar5")

	UpdateActionbarScale("BarExit")
	UpdateActionbarScale("BarPet")
	UpdateActionbarScale("BarStance")
end

local function SetFrameSize(frame, size, num)
	size = cfg.size or frame.buttonSize
	num = num or frame.numButtons
	
	local layout = R.db["Actionbar"]["Style"]
	if layout == 8 then
	  frame:SetWidth(7*size*1.05 + margin + padding)
	  frame:SetHeight(2*size - 6*padding)
	elseif layout == 9 then
	  frame:SetWidth(7*size + 3*padding)
	  frame:SetHeight(2*size - 3*padding)
	elseif layout == 10 then
	  frame:SetWidth(7*size - padding)
	  frame:SetHeight(2*size - 3*padding)
	elseif layout == 11 then
	  frame:SetWidth(7*size + 4*margin)
		frame:SetHeight(2*size - margin)
	else
		frame:SetWidth(num*size + padding)
		frame:SetHeight(size + 2*padding)
	end

	if not frame.mover then
		frame.mover = M.Mover(frame, U["Main Actionbar"], "Bar1", frame.Pos)
	else
		frame.mover:SetSize(frame:GetSize())
	end

	if not frame.SetFrameSize then
		frame.buttonSize = size
		frame.numButtons = num
		frame.SetFrameSize = SetFrameSize
	end
end

function Bar:CreateBar1()
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}
	local layout = R.db["Actionbar"]["Style"]

	local frame = CreateFrame("Frame", "NDui_ActionBar1", UIParent, "SecureHandlerStateTemplate")

	if layout == 5 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -108, 2}
	elseif layout == 8 then
	  frame.Pos = {"CENTER", UIParent, "CENTER", 0, -230}
	elseif layout == 9 then
		frame.Pos = {"CENTER", UIParent, "CENTER", 0, -230}
	elseif layout == 10 then
		frame.Pos = {"CENTER", UIParent, "CENTER", 0, -230}
	elseif layout == 11 then
		frame.Pos = {"CENTER", UIParent, "CENTER", 0, -225}
	else
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 2}
	end

	for i = 1, num do
		local button = _G["ActionButton"..i]
		tinsert(buttonList, button)
		tinsert(Bar.buttons, button)
		button:SetParent(frame)
		button:ClearAllPoints()
		if layout == 8 then
		  if i == 1 then
			  button:SetSize(cfg.size *1.05, cfg.size *1.05)
			  button:SetPoint("TOPLEFT", frame, margin, -padding)
			elseif i == 8 then
			  button:SetSize(cfg.size *0.75, cfg.size*0.75)
			  button:SetPoint("TOPLEFT", _G["ActionButton3"], "BOTTOMLEFT", -6*margin, 0)
			elseif i == 9 then
			  button:SetSize(cfg.size *0.75, cfg.size*0.75)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 0, 0)
			elseif i == 10 then
			  button:SetSize(cfg.size *0.75, cfg.size*0.75)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 0, 0)
			elseif i == 11 then
			  button:SetSize(cfg.size *0.75, cfg.size*0.75)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 0, 0)
			elseif i == 12 then
			  button:SetSize(cfg.size *0.75, cfg.size*0.75)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 0, 0)
			else
			  button:SetSize(cfg.size *1.05, cfg.size *1.05)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 0, 0)
			end
		elseif layout == 9 then
		  if i == 1 then
			  button:SetSize(cfg.size * 1.7, cfg.size * 0.85)
			  button:SetPoint("TOPLEFT", frame, padding, -padding)
		  elseif i == 2 then
			  button:SetSize(cfg.size * 1.7, cfg.size * 0.85)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", margin, 0)
			elseif i == 3 then
			  button:SetSize(cfg.size * 1.7, cfg.size * 0.85)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", margin, 0)
			elseif i == 4 then
			  button:SetSize(cfg.size * 1.7, cfg.size * 0.85)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 2*margin, 0)
			elseif i == 5 then
			  button:SetSize(cfg.size * 0.85, cfg.size * 0.85)
			  button:SetPoint("TOPLEFT", _G["ActionButton1"], "BOTTOMLEFT", -margin, -margin)
			else
			  button:SetSize(cfg.size * 0.85, cfg.size * 0.85)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", margin, 0)
			end
		elseif layout == 10 then
		  if i == 1 then
			  button:SetSize(cfg.size * 1.1, cfg.size * 0.85)
			  button:SetPoint("TOPLEFT", frame, padding, -padding)
			elseif i == 7 then
			  button:SetSize(cfg.size * 1.1, cfg.size * 0.85)
			  button:SetPoint("TOPLEFT", _G["ActionButton1"], "BOTTOMLEFT", 0, -padding)
			else
			  button:SetSize(cfg.size * 1.1, cfg.size * 0.85)
			  local previous = _G["ActionButton"..i-1]
			  button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
			end
		elseif layout == 11 then
		  if i == 1 then
			  button:SetSize(cfg.size *0.9, cfg.size *0.9)
			  button:SetPoint("LEFT", frame, cfg.size *1.2 + padding, cfg.size *0.5-margin)
		  elseif i == 6 then
			  button:SetSize(cfg.size *0.9, cfg.size *0.9)
			  button:SetPoint("TOP", _G["ActionButton1"], "BOTTOM", 0, -margin)
		  elseif i == 11 then
			  button:SetSize(cfg.size *1.2, cfg.size *01.2)
			  button:SetPoint("TOPRIGHT", _G["ActionButton1"], "LEFT", -margin, 2*margin)
			elseif i == 12 then
			  button:SetSize(cfg.size *1.2, cfg.size *1.2)
			  button:SetPoint("TOPLEFT", _G["ActionButton5"], "RIGHT", margin, 2*margin)
			else
			  button:SetSize(cfg.size *0.9, cfg.size *0.9)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", margin, 0)
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
	frame.buttonList = buttonList
	SetFrameSize(frame, cfg.size, num)

	frame.frameVisibility = "[petbattle] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	if cfg.fader then
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end

	local actionPage = "[bar:6]6;[bar:5]5;[bar:4]4;[bar:3]3;[bar:2]2;[possessbar]12;[overridebar]14;[shapeshift]13;[vehicleui]12;[bonusbar:5]11;[bonusbar:4]10;[bonusbar:3]9;[bonusbar:2]8;[bonusbar:1]7;1"
	local buttonName = "ActionButton"
	for i, button in next, buttonList do
		frame:SetFrameRef(buttonName..i, button)
	end

	frame:Execute(([[
		buttons = table.new()
		for i = 1, %d do
			tinsert(buttons, self:GetFrameRef("%s"..i))
		end
	]]):format(num, buttonName))

	frame:SetAttribute("_onstate-page", [[
		for _, button in next, buttons do
			button:SetAttribute("actionpage", newstate)
		end
	]])
	RegisterStateDriver(frame, "page", actionPage)

	-- Fix button texture
	local function FixActionBarTexture()
		for _, button in next, buttonList do
			local action = button.action
			if action < 120 then break end

			local icon = button.icon
			local texture = GetActionTexture(action)
			if texture then
				icon:SetTexture(texture)
				icon:Show()
			else
				icon:Hide()
			end
			Bar.UpdateButtonStatus(button)
		end
	end
	M:RegisterEvent("SPELL_UPDATE_ICON", FixActionBarTexture)
	M:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR", FixActionBarTexture)
	M:RegisterEvent("UPDATE_OVERRIDE_ACTIONBAR", FixActionBarTexture)
end

function Bar:OnLogin()
	Bar.buttons = {}

	if not R.db["Actionbar"]["Enable"] then return end

	Bar:CreateBar1()
	Bar:CreateBar2()
	Bar:CreateBar3()
	Bar:CreateBar4()
	Bar:CreateBar5()
	Bar:CustomBar()
	Bar:CreateExtrabar()
	Bar:CreateLeaveVehicle()
	Bar:CreatePetbar()
	Bar:CreateStancebar()
	Bar:HideBlizz()
	Bar:ReskinBars()
	Bar:UpdateAllScale()
	Bar:MicroMenu()
end