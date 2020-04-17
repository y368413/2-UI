local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")
local cfg = R.bars.bar5

function Bar:CreateBar5()
	local padding, margin = 2, 2
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}
	local layout = MaoRUIPerDB["Actionbar"]["Style"]
	if (layout == 8) or (layout == 9) or (layout == 10) then cfg.size = 38 end

	--create the frame to hold the buttons
	local frame = CreateFrame("Frame", "NDui_ActionBar5", UIParent, "SecureHandlerStateTemplate")
	frame:SetWidth(cfg.size + 2*padding)
	frame:SetHeight(num*cfg.size + (num-1)*margin + 2*padding)
	if layout == 1 or layout == 4 or layout == 5 then
		frame.Pos = {"RIGHT", UIParent, "RIGHT", -(frame:GetWidth()-1), -88}
	elseif layout == 3 then
	  frame:SetWidth(num*cfg.size + (num-1)*margin + 2*padding)
		frame:SetHeight(cfg.size + 2*padding)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 80}
	elseif layout == 8 then
		frame:SetWidth(4*cfg.size + 3*margin + 2*padding)
		frame:SetHeight(3*cfg.size + 1*margin + 0*padding)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 8*cfg.size + 8*margin + 2*padding, 2}
	elseif layout == 9 then
		frame:SetWidth(24*cfg.size + 24*margin + 6*padding)
		frame:SetHeight(2*cfg.size + margin + 2*padding)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 2}
	elseif layout == 10 then
		frame.Pos = {"CENTER", UIParent, "CENTER", 8*cfg.size, -2*cfg.size}
	else
		frame.Pos = {"RIGHT", UIParent, "RIGHT", -1, -88}
	end

	--move the buttons into position and reparent them
	MultiBarLeft:SetParent(frame)
	MultiBarLeft:EnableMouse(false)

	for i = 1, num do
		local button = _G["MultiBarLeftButton"..i]
		table.insert(buttonList, button) --add the button object to the list
		button:SetSize(cfg.size, cfg.size)
		button:ClearAllPoints()
		if layout == 3 then
		  if i == 1 then
			  button:SetPoint("BOTTOMLEFT", frame, padding, padding)
		  else
			  local previous = _G["MultiBarLeftButton"..i-1]
			  button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
			 end
		elseif layout == 8 then
			if i == 1 then
				button:SetPoint("TOPLEFT", frame, padding, -padding)
			elseif i == 5 then
				local previous = _G["MultiBarLeftButton1"]
				button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
			elseif i == 9 then
				local previous = _G["MultiBarLeftButton5"]
				button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
			else
				local previous = _G["MultiBarLeftButton"..i-1]
				button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
			end
		elseif layout == 9 then
			if i == 1 then
				button:SetPoint("TOPLEFT", frame, padding, -padding)
			elseif i == 4 then
				local previous = _G["MultiBarLeftButton1"]
				button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
			elseif i == 7 then
				local previous = _G["MultiBarLeftButton3"]
				button:SetPoint("LEFT", previous, "RIGHT", 18*cfg.size + 18*margin + 6*padding, 0)
			elseif i == 10 then
				local previous = _G["MultiBarLeftButton7"]
				button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
			else
				local previous = _G["MultiBarLeftButton"..i-1]
				button:SetPoint("LEFT", previous, "RIGHT", margin, 0)
			end
		elseif layout == 10 then
		  if i == 1 then
				button:SetPoint("TOPLEFT", frame, padding, -padding)
			elseif i == 4 then
				local previous = _G["MultiBarLeftButton1"]
				button:SetPoint("TOPRIGHT", previous, "BOTTOM", 0, -3*margin)
			elseif i == 8 then
				local previous = _G["MultiBarLeftButton4"]
				button:SetPoint("TOPLEFT", previous, "BOTTOM", 0, -3*margin)
			elseif i == 11 then
				local previous = _G["ActionButton9"]
				button:SetPoint("RIGHT", previous, "BOTTOMLEFT", -2*margin, 0)
			elseif i == 12 then
				local previous = _G["ActionButton11"]
				button:SetPoint("LEFT", previous, "BOTTOMRIGHT", 2*margin, 0)
			else
				local previous = _G["MultiBarLeftButton"..i-1]
				button:SetPoint("LEFT", previous, "RIGHT", 3*margin, 0)
			end
		else
		if i == 1 then
			button:SetPoint("TOPRIGHT", frame, -padding, -padding)
		else
			local previous = _G["MultiBarLeftButton"..i-1]
			button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
		end
		end
	end

	--show/hide the frame on a given state driver
	frame.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	--create drag frame and drag functionality
	if R.bars.userplaced then
		frame.mover = M.Mover(frame, SHOW_MULTIBAR4_TEXT, "Bar5", frame.Pos)
	end

	--create the mouseover functionality
	if MaoRUIPerDB["Actionbar"]["Bar5Fade"] and cfg.fader then
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end
end