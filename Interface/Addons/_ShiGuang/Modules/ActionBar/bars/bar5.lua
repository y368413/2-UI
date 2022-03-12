local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert = tinsert
local cfg = R.Bars.bar5
local margin, padding = R.Bars.margin, R.Bars.padding

local function SetFrameSize(frame, size, num)
	size = size or frame.buttonSize
	num = num or frame.numButtons
	local layout = R.db["Actionbar"]["Style"]
	if (layout == 6) or (layout == 8) or (layout == 9) or (layout == 10) or (layout == 11) then cfg.size = 38 end

	if layout == 3 then
	  frame:SetWidth((num+1)*cfg.size + (num-2)*margin + (num-1)*padding)
		frame:SetHeight(cfg.size + 4*padding)
	elseif layout == 6 then
		frame:SetWidth(4*cfg.size + margin)
		frame:SetHeight(3*cfg.size + margin)
	elseif layout == 8 then
		frame:SetWidth(7*cfg.size + margin + padding)
		frame:SetHeight(2*cfg.size + margin + padding)
	elseif (layout == 9) or (layout == 10) then
		frame:SetWidth(6*size + 2*margin + 2*padding)
		frame:SetHeight(2*cfg.size + 2*margin + padding)
	elseif layout == 11 then
		frame:SetWidth(4*cfg.size + 2*margin + 2*padding)
		frame:SetHeight(3*cfg.size + 4*margin + 2*padding)
	else
			frame:SetWidth(size + padding)
	    frame:SetHeight((num+1)*size + (num-1)*margin + 8*padding)
	end

	if not frame.mover then
		frame.mover = M.Mover(frame, SHOW_MULTIBAR4_TEXT, "Bar5", frame.Pos)
	else
		frame.mover:SetSize(frame:GetSize())
	end

	if not frame.SetFrameSize then
		frame.buttonSize = size
		frame.numButtons = num
		frame.SetFrameSize = SetFrameSize
	end
end

function Bar:CreateBar5()
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}
	local layout = R.db["Actionbar"]["Style"]
	if (layout == 6) or (layout == 8) or (layout == 9) or (layout == 10) or (layout == 11) then cfg.size = 38 end

	--create the frame to hold the buttons
	local frame = CreateFrame("Frame", "UI_ActionBar5", UIParent, "SecureHandlerStateTemplate")
	if layout == 1 or layout == 4 or layout == 5 then
		frame.Pos = {"RIGHT", UIParent, "RIGHT", -(cfg.size + 3*margin), -88}
	elseif layout == 3 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 80}
	elseif layout == 6 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 8*cfg.size + margin , margin}
	elseif layout == 8 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 9*cfg.size - 2*margin, 6}
	elseif (layout == 9) or (layout == 10) then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 9*cfg.size + 2*padding, 2}
	elseif layout == 11 then
		frame.Pos = {"CENTER", UIParent, "CENTER", 8*cfg.size + 6*padding, 4*cfg.size + 6*padding}
	else
		frame.Pos = {"RIGHT", UIParent, "RIGHT", 0, -88}
	end

	MultiBarLeft:SetParent(frame)
	MultiBarLeft:EnableMouse(false)
	MultiBarLeft.QuickKeybindGlow:SetTexture("")
	hooksecurefunc(MultiBarLeft, "SetScale", function(self, scale, force)
		if not force and scale ~= 1 then
			self:SetScale(1, true)
		end
	end)

	for i = 1, num do
		local button = _G["MultiBarLeftButton"..i]
		tinsert(buttonList, button)
		tinsert(Bar.buttons, button)
		button:ClearAllPoints()
		if layout == 3 then
		  if i == 1 then
			  button:SetPoint("TOPLEFT", frame, padding, -padding)
		  else
			  button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", margin, 0)
			 end
		elseif layout == 6 then
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
		elseif layout == 8 then
			if i == 1 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("TOPRIGHT", frame, -padding, -padding)
			elseif i == 2 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("RIGHT", _G["MultiBarLeftButton"..i-1], "LEFT", -margin, 0)
			elseif i == 3 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("RIGHT", _G["MultiBarLeftButton"..i-1], "LEFT", -margin, 0)
			elseif i == 4 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("RIGHT", _G["MultiBarLeftButton"..i-1], "LEFT", -margin, 0)
			elseif i == 5 then
				button:SetSize(cfg.size - 7, cfg.size - 7)
				button:SetPoint("TOPRIGHT", _G["MultiBarLeftButton1"], "BOTTOMRIGHT", 0, -margin)
			else
				button:SetSize(cfg.size - 7, cfg.size - 7)
				button:SetPoint("RIGHT", _G["MultiBarLeftButton"..i-1], "LEFT", -1.3*margin, 0)
			end
		elseif layout == 9 then
			if i == 1 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("TOPLEFT", frame, padding, -padding)
			elseif i == 2 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", margin, 0)
			elseif i == 3 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", margin, 0)
			elseif i == 4 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", margin, 0)
			elseif i == 5 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", margin, 0)
			elseif i == 6 then
				button:SetSize(cfg.size - 7, cfg.size - 7)
				button:SetPoint("TOPLEFT", _G["MultiBarLeftButton1"], "BOTTOMLEFT", 0, -margin)
			else
				button:SetSize(cfg.size - 7, cfg.size - 7)
				button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", 1.3*margin, 0)
			end
		elseif layout == 10 then
		  if i == 1 then
				button:SetSize(cfg.size, cfg.size)
				button:SetPoint("TOPLEFT", frame, padding, -padding)
			elseif i == 2 then
				button:SetSize(cfg.size, cfg.size)
				button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", margin, 0)
			elseif i == 3 then
				button:SetSize(cfg.size, cfg.size)
				button:SetPoint("TOPLEFT", _G["MultiBarLeftButton1"], "BOTTOMLEFT", 0, -margin)
			elseif i == 4 then
				button:SetSize(cfg.size, cfg.size)
				button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", margin, 0)
			elseif i == 5 then
				button:SetSize(cfg.size + 10, cfg.size + 10)
				button:SetPoint("TOPLEFT", _G["MultiBarLeftButton2"], "TOPRIGHT", margin, 0)
			elseif i == 6 then
				button:SetSize(cfg.size + 10, cfg.size + 10)
				button:SetPoint("LEFT", _G["MultiBarLeftButton5"], "RIGHT", margin, 0)
			elseif i == 7 then
				button:SetSize(cfg.size + 10, cfg.size + 10)
				button:SetPoint("LEFT", _G["MultiBarLeftButton6"], "RIGHT", margin, 0)
			elseif i == 8 then
				button:SetSize(cfg.size - 10, cfg.size - 10)
				button:SetPoint("TOPLEFT", _G["MultiBarLeftButton5"], "BOTTOMLEFT", 0, -margin)
			else
				button:SetSize(cfg.size - 10, cfg.size - 10)
				button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", margin, 0)
			end
		elseif layout == 11 then
		  if i == 1 then
			  button:SetSize(cfg.size, cfg.size)
			  button:SetPoint("TOPLEFT", frame, padding, -margin)
		  elseif i == 2 then
			  button:SetSize(cfg.size, cfg.size)
			  button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", padding, 0)
			elseif i == 3 then
			  button:SetSize(cfg.size, cfg.size)
			  button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", padding, 0)
			elseif i == 4 then
			  button:SetSize(cfg.size, cfg.size)
			  button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", padding, 0)
			elseif i == 5 then
			  button:SetSize(cfg.size *1.35, cfg.size *1.35)
			  button:SetPoint("TOPLEFT", _G["MultiBarLeftButton1"], "BOTTOMLEFT", 0, -margin)
			elseif i == 6 then
			  button:SetSize(cfg.size *1.35, cfg.size *1.35)
			  button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", padding, 0)
			elseif i == 7 then
			  button:SetSize(cfg.size *1.35, cfg.size *1.35)
			  button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", padding, 0)
			elseif i == 8 then
			  button:SetSize(cfg.size *0.8, cfg.size*0.8)
			  button:SetPoint("TOPLEFT", _G["MultiBarLeftButton5"], "BOTTOMLEFT", 0, -margin)
			else
			  button:SetSize(cfg.size *0.8, cfg.size*0.8)
			  button:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", padding*0.8, 0)
			end
		else
		if i == 1 then
			button:SetPoint("TOPRIGHT", frame, 0, 0)
		else
			button:SetPoint("TOP", _G["MultiBarLeftButton"..i-1], "BOTTOM", 0, -margin)
		end
	end
	end
	frame.buttonList = buttonList
	SetFrameSize(frame, cfg.size, num)

	frame.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	if cfg.fader then
		frame.isDisable = not R.db["Actionbar"]["Bar5Fader"]
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end
end