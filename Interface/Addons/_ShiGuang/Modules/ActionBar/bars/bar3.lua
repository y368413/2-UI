local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")
local cfg = R.bars.bar3

function Bar:CreateBar3()
	local padding, margin = 2, 2
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}
	local layout = MaoRUIPerDB["Actionbar"]["Style"]
	if layout ~= 1 then cfg = R.bars.bar2 end

	--create the frame to hold the buttons
	local frame = CreateFrame("Frame", "NDui_ActionBar3", UIParent, "SecureHandlerStateTemplate")
	if layout == 1 then
	  frame:SetWidth(19*cfg.size + 17*margin + 2*padding)
		frame:SetHeight(2*cfg.size + margin + 2*padding)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 2}
	elseif (layout == 4) or (layout == 8) then
		frame:SetWidth(num*cfg.size + (num-1)*margin + 2*padding)
		frame:SetHeight(cfg.size + 2*padding)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 82}
	elseif layout == 5 then
		frame:SetWidth(6*cfg.size + 5*margin + 2*padding)
		frame:SetHeight(2*cfg.size + margin)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 256, 4}
	elseif (layout == 6) or (layout == 9) or (layout == 10) then
	  frame:SetWidth(num*cfg.size + (num-1)*margin + 2*padding)
	  frame:SetHeight(cfg.size + 2*padding)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 44}
	else
		frame:SetWidth(19*cfg.size + 2*margin + 2*padding)
		frame:SetHeight(2*cfg.size + margin + 2*padding)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 2}
	end

	--move the buttons into position and reparent them
	MultiBarBottomRight:SetParent(frame)
	MultiBarBottomRight:EnableMouse(false)

	for i = 1, num do
		local button = _G["MultiBarBottomRightButton"..i]
		table.insert(buttonList, button) --add the button object to the list
		button:SetSize(cfg.size, cfg.size)
		button:ClearAllPoints()
		if i == 1 then
			if layout == 4 or layout == 8 then
				button:SetPoint("LEFT", frame, padding, 0)
			elseif (layout == 6) or (layout == 9) or (layout == 10) then
				button:SetPoint("BOTTOMLEFT", frame, padding, padding)
			else
				button:SetPoint("TOPLEFT", frame, padding, -padding)
			end
		elseif (i == 4 and layout < 4) or (i == 7 and layout == 5) or (i == 4 and layout == 7) then
			local previous = _G["MultiBarBottomRightButton1"]
			button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
		elseif (i == 7 and (layout > 1 and layout < 4)) or (i == 7 and layout == 7) then
			local previous = _G["MultiBarBottomRightButton3"]
			button:SetPoint("LEFT", previous, "RIGHT", 12*cfg.size + 12*margin + 5*padding, 0)
		elseif (i == 7 and layout == 1) then
			local previous = _G["MultiBarBottomRightButton3"]
			button:SetPoint("LEFT", previous, "RIGHT", 12*cfg.size + 14*margin + 16*padding, 0)
		elseif (i == 10 and layout < 4) or (i == 10 and layout == 7) then
			local previous = _G["MultiBarBottomRightButton7"]
			button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
		else
			local previous = _G["MultiBarBottomRightButton"..i-1]
			button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
		end
	end

	--show/hide the frame on a given state driver
	frame.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	--create drag frame and drag functionality
	if R.bars.userplaced then
		frame.mover = M.Mover(frame, SHOW_MULTIBAR2_TEXT, "Bar3", frame.Pos)
	end

	--create the mouseover functionality
	if cfg.fader then
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end
end