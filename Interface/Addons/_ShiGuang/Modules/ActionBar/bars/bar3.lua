local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert = tinsert
local cfg = R.Bars.bar3
local margin, padding = R.Bars.margin, R.Bars.padding

local function SetFrameSize(frame, size, num)
	size = size or frame.buttonSize
	num = num or frame.numButtons

	local layout = MaoRUIPerDB["Actionbar"]["Style"]
	if layout ~= 1 then cfg = R.Bars.bar2 end

	if layout == 1 then
	  frame:SetWidth(19*size + 17*margin + 2*padding)
		frame:SetHeight(2*size + margin + 2*padding)
	elseif (layout == 2) or (layout == 3) then
		frame:SetWidth(6*size + 5*margin + padding)
		frame:SetHeight(2*size + margin + padding)
	elseif (layout == 4) or (layout == 6) then
		frame:SetWidth(num*size + (num-1)*margin + 2*padding)
		frame:SetHeight(size + 2*padding)
	elseif layout == 5 then
		frame:SetWidth(6*size + 5*margin + 2*padding)
		frame:SetHeight(2*size + margin)
	elseif layout == 8 then
	  frame:SetWidth(num*(size+7) + (num-1)*margin + 4*padding)
	  frame:SetHeight(size + 5*padding)
	elseif (layout == 9) or (layout == 10) or (layout == 11) then
	  frame:SetWidth(num*size + (num-1)*margin + 2*padding)
	  frame:SetHeight(size + 2*padding)
	elseif layout == 7 then
	  frame:SetWidth(22*size + 4*margin + 2*padding)
	  frame:SetHeight(2*size + 2*padding)
	else
		frame:SetWidth(19*size + 2*margin + 2*padding)
		frame:SetHeight(2*size + margin + 2*padding)
	end
	
	--if layout < 4 then
		--local button = _G["MultiBarBottomRightButton7"]
		--button:SetPoint("TOPRIGHT", frame, -2*(size+margin) - padding, -padding)
	--end

	if not frame.mover then
		frame.mover = M.Mover(frame, SHOW_MULTIBAR2_TEXT, "Bar3", frame.Pos)
	else
		frame.mover:SetSize(frame:GetSize())
	end

	if not frame.SetFrameSize then
		frame.buttonSize = size
		frame.numButtons = num
		frame.SetFrameSize = SetFrameSize
	end
end

function Bar:CreateBar3()
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}
	local layout = MaoRUIPerDB["Actionbar"]["Style"]
	--if layout > 3 then cfg = R.Bars.bar2 end
	if layout ~= 1 then cfg = R.Bars.bar2 end

	local frame = CreateFrame("Frame", "NDui_ActionBar3", UIParent, "SecureHandlerStateTemplate")
	if layout == 1 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 2}
	elseif (layout == 2) or (layout == 3) then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 9*cfg.size + 8*margin + padding, 4}
	elseif (layout == 4) or (layout == 6) then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 82}
	elseif layout == 5 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 256, 4}
	elseif layout == 8 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, cfg.size}
	elseif (layout == 9) or (layout == 10) or (layout == 11) then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 44}
	elseif layout == 7 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 0}
	else
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 2}
	end

	MultiBarBottomRight:SetParent(frame)
	MultiBarBottomRight:EnableMouse(false)
	MultiBarBottomRight.QuickKeybindGlow:SetTexture("")

	for i = 1, num do
		local button = _G["MultiBarBottomRightButton"..i]
		tinsert(buttonList, button)
		tinsert(Bar.buttons, button)
		button:ClearAllPoints()
		if i == 1 then
			if layout == 4 then
				button:SetPoint("LEFT", frame, padding, 0)
			elseif layout == 7 then
				button:SetSize(cfg.size, cfg.size)
				button:SetPoint("LEFT", frame, padding, 0)
			elseif layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("BOTTOMLEFT", frame, padding, padding)
			elseif (layout == 9) or (layout == 10) or (layout == 11) then
				button:SetPoint("BOTTOMLEFT", frame, padding, padding)
			else
				button:SetPoint("TOPLEFT", frame, padding, -padding)
			end
		elseif i == 2 then
			if layout == 7 then
			  button:SetSize(cfg.size *1.5, cfg.size *1.5)
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 2*margin, 0)
			elseif layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 1.2*margin, 0)
			else
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", margin, 0)
			end
		elseif i == 3 then
			if layout == 7 then
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "TOPRIGHT", 2*margin, -3*margin)
			elseif layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 1.2*margin, 0)
			else
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", margin, 0)
			end
		elseif i == 4 then
			if layout == 1 then
			  button:SetPoint("TOP", _G["MultiBarBottomRightButton1"], "BOTTOM", 0, -margin)
			elseif layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 1.2*margin, 0)
			else
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", margin, 0)
			end
		elseif i == 5 then
			if layout == 7 then
			  button:SetPoint("TOP", _G["MultiBarBottomRightButton3"], "BOTTOM", 0, -margin)
			elseif layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 1.2*margin, 0)
			else
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", margin, 0)
			end
		elseif i == 7 then
		  if layout == 1 then
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton3"], "RIGHT", 12*cfg.size + 14*margin + 16*padding, 0)
			elseif layout == 2 or layout == 3 or layout == 5 then
			  button:SetPoint("TOP", _G["MultiBarBottomRightButton1"], "BOTTOM", 0, -margin)
			elseif layout == 7 then
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton4"], "RIGHT", 12*cfg.size + 11*margin + 2*padding, 0)
			elseif layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 1.2*margin, 0)
			else
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", margin, 0)
			end			
		elseif i == 9 then
			if layout == 7 then
			  button:SetPoint("TOP", _G["MultiBarBottomRightButton7"], "BOTTOM", 0, -margin)
			elseif layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 1.2*margin, 0)
			else
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", margin, 0)
			end
		elseif i == 10 then
			if layout == 1 then
		 	  button:SetPoint("TOP", _G["MultiBarBottomRightButton7"], "BOTTOM", 0, -margin)
			elseif layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 1.2*margin, 0)
			else
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", margin, 0)
			end
		elseif i == 11 then
			if layout == 7 then
			  button:SetSize(cfg.size *1.5, cfg.size *1.5)
			  button:SetPoint("TOPLEFT", _G["MultiBarBottomRightButton8"], "RIGHT", 2*margin, 3*margin)
			elseif layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 1.2*margin, 0)
			else
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", margin, 0)
			end
		elseif i == 12 then
			if layout == 7 then
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton11"], "RIGHT", 2*margin, 0)
			elseif layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 1.2*margin, 0)
			else
			  button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", margin, 0)
			end
		else
			if layout == 8 then
				button:SetSize(cfg.size+7, cfg.size+7)
				button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", 1.2*margin, 0)
			end
			button:SetPoint("LEFT", _G["MultiBarBottomRightButton"..i-1], "RIGHT", margin, 0)
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