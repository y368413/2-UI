local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert, mod, min, ceil = tinsert, mod, min, ceil
local cfg = R.Bars.stancebar
local margin, padding = R.Bars.margin, R.Bars.padding

local num = NUM_STANCE_SLOTS
local NUM_POSSESS_SLOTS = NUM_POSSESS_SLOTS

function Bar:UpdateStanceBar()
	local frame = _G["UI_ActionBarStance"]
	if not frame then return end

	local size = R.db["Actionbar"]["BarStanceSize"]
	local fontSize = R.db["Actionbar"]["BarStanceFont"]
	local perRow = R.db["Actionbar"]["BarStancePerRow"]

	for i = 1, 12 do
		local button = frame.buttons[i]
		button:SetSize(size, size)
		if i < 11 then
			button:ClearAllPoints()
			if i == 1 then
				button:SetPoint("TOPLEFT", frame, padding, -padding)
			elseif mod(i-1, perRow) ==  0 then
				button:SetPoint("TOP", frame.buttons[i-perRow], "BOTTOM", 0, -margin)
			else
				button:SetPoint("LEFT", frame.buttons[i-1], "RIGHT", margin, 0)
			end
		end
		Bar:UpdateFontSize(button, fontSize)
	end

	local column = min(num, perRow)
	local rows = ceil(num/perRow)
	frame:SetWidth(column*size + (column-1)*margin + 2*padding)
	frame:SetHeight(size*rows + (rows-1)*margin + 2*padding)
	frame.mover:SetSize(size, size)
end

function Bar:CreateStancebar()
	if not R.db["Actionbar"]["ShowStance"] then return end

	local buttonList = {}
	local frame = CreateFrame("Frame", "UI_ActionBarStance", UIParent, "SecureHandlerStateTemplate")
	if (R.db["Actionbar"]["Style"] == 7) or (R.db["Actionbar"]["Style"] == 8) or (R.db["Actionbar"]["Style"] == 10) then
		--frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -120, 82}
		frame.mover = M.Mover(frame, U["StanceBar"], "StanceBar", {"BOTTOM", UIParent, "BOTTOM", -120, 82})
	elseif (R.db["Actionbar"]["Style"] == 4) or (R.db["Actionbar"]["Style"] == 6) then
		--frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -42, 120}
		frame.mover = M.Mover(frame, U["StanceBar"], "StanceBar", {"BOTTOM", UIParent, "BOTTOM", -42, 120})
	elseif R.db["Actionbar"]["Style"] == 3 then
		--frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -295, 82}
		frame.mover = M.Mover(frame, U["StanceBar"], "StanceBar", {"BOTTOM", UIParent, "BOTTOM", -295, 82})
	else
		--frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -62, 82}
		frame.mover = M.Mover(frame, U["StanceBar"], "StanceBar", {"BOTTOM", UIParent, "BOTTOM", -62, 82})
	end
	Bar.movers[8] = frame.mover

	-- StanceBar
	StanceBarFrame:SetParent(frame)
	StanceBarFrame:EnableMouse(false)
	StanceBarLeft:SetTexture(nil)
	StanceBarMiddle:SetTexture(nil)
	StanceBarRight:SetTexture(nil)

	for i = 1, num do
		local button = _G["StanceButton"..i]
		tinsert(buttonList, button)
		tinsert(Bar.buttons, button)
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
		button:SetPoint("CENTER", buttonList[i])
	end

	frame.buttons = buttonList

	frame.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	if cfg.fader then
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end
end