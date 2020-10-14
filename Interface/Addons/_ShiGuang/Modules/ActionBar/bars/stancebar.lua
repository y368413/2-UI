local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert = tinsert
local cfg = R.Bars.stancebar
local margin, padding = R.Bars.margin, R.Bars.padding

local function SetFrameSize(frame, size, num)
	size = size or frame.buttonSize
	num = num or frame.numButtons

	frame:SetWidth(num*size + (num-1)*margin + 2*padding)
	frame:SetHeight(size + 2*padding)
	if not frame.mover then
		frame.mover = M.Mover(frame, U["StanceBar"], "StanceBar", frame.Pos)
	else
		frame.mover:SetSize(frame:GetSize())
	end

	if not frame.SetFrameSize then
		frame.buttonSize = size
		frame.numButtons = num
		frame.SetFrameSize = SetFrameSize
	end
end

function Bar:CreateStancebar()
	local num = NUM_STANCE_SLOTS
	local NUM_POSSESS_SLOTS = NUM_POSSESS_SLOTS
	local buttonList = {}

	local frame = CreateFrame("Frame", "NDui_ActionBarStance", UIParent, "SecureHandlerStateTemplate")
	if (MaoRUIPerDB["Actionbar"]["Style"] == 7) or (MaoRUIPerDB["Actionbar"]["Style"] == 8) or (MaoRUIPerDB["Actionbar"]["Style"] == 10) then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -120, 82}
	elseif (MaoRUIPerDB["Actionbar"]["Style"] == 4) or (MaoRUIPerDB["Actionbar"]["Style"] == 6) then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -42, 120}
	elseif MaoRUIPerDB["Actionbar"]["Style"] == 3 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -295, 82}
	else
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -62, 82}
	end

	-- StanceBar
	if MaoRUIPerDB["Actionbar"]["ShowStance"] then
		StanceBarFrame:SetParent(frame)
		StanceBarFrame:EnableMouse(false)
		StanceBarLeft:SetTexture(nil)
		StanceBarMiddle:SetTexture(nil)
		StanceBarRight:SetTexture(nil)

		for i = 1, num do
			local button = _G["StanceButton"..i]
			tinsert(buttonList, button)
			tinsert(Bar.buttons, button)
			button:ClearAllPoints()
			if i == 1 then
				button:SetPoint("BOTTOMLEFT", frame, padding, padding)
			else
				local previous = _G["StanceButton"..i-1]
				button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
			end
		end
	end

	-- PossessBar
	PossessBarFrame:SetParent(frame)
	PossessBarFrame:EnableMouse(false)
	PossessBackground1:SetTexture(nil)
	PossessBackground2:SetTexture(nil)

	for i = 1, NUM_POSSESS_SLOTS do
		local button = _G["PossessButton"..i]
		tinsert(buttonList, button)
		button:ClearAllPoints()
		if i == 1 then
			button:SetPoint("BOTTOMLEFT", frame, padding, padding)
		else
			local previous = _G["PossessButton"..i-1]
			button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
		end
	end

	frame.buttonList = buttonList
	SetFrameSize(frame, cfg.size, num)

	frame.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	if cfg.fader then
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end
end