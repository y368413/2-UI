local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert = tinsert
local cfg = R.Bars.bar2
local margin, padding = R.Bars.margin, R.Bars.padding

local function SetFrameSize(frame, size, num)
	size = size or frame.buttonSize
	num = num or frame.numButtons
	local layout = R.db["Actionbar"]["Style"]

	if layout == 8 then
		frame:SetWidth(12*(size-7) + (num-1)*margin + 2*padding)
		frame:SetHeight(size + padding)
	else
	frame:SetWidth(num*size + padding)
	frame:SetHeight(size + 2*padding)
	end
	
	if not frame.mover then
		frame.mover = M.Mover(frame, SHOW_MULTIBAR1_TEXT, "Bar2", frame.Pos)
	else
		frame.mover:SetSize(frame:GetSize())
	end

	if not frame.SetFrameSize then
		frame.buttonSize = size
		frame.numButtons = num
		frame.SetFrameSize = SetFrameSize
	end
end

function Bar:CreateBar2()
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}
	local layout = R.db["Actionbar"]["Style"]

	local frame = CreateFrame("Frame", "UI_ActionBar2", UIParent, "SecureHandlerStateTemplate")
	if layout == 5 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -108, 40}
	elseif layout == 8 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 4}
	elseif (layout == 9) or (layout == 10) or (layout == 11) then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 4}
	else
		frame.Pos = {"BOTTOM", _G.UI_ActionBar1, "TOP", 0, -margin}
	end

	MultiBarBottomLeft:SetParent(frame)
	MultiBarBottomLeft:EnableMouse(false)
	MultiBarBottomLeft.QuickKeybindGlow:SetTexture("")

	for i = 1, num do
		local button = _G["MultiBarBottomLeftButton"..i]
		tinsert(buttonList, button)
		tinsert(Bar.buttons, button)
		button:ClearAllPoints()
		if i == 1 then
			if layout == 8 then
			  button:SetSize(cfg.size-7, cfg.size-7)
			end
			button:SetPoint("BOTTOMLEFT", frame, padding, padding)
		else
			if layout == 8 then
			  button:SetSize(cfg.size-7, cfg.size-7)
			end
			button:SetPoint("LEFT", _G["MultiBarBottomLeftButton"..i-1], "RIGHT", margin, 0)
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