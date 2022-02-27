local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert = tinsert
local cfg = R.Bars.bar4
local margin, padding = R.Bars.margin, R.Bars.padding

local function SetFrameSize(frame, size, num)
	size = size or frame.buttonSize
	num = num or frame.numButtons

	local layout = R.db["Actionbar"]["Style"]
	if (layout == 2) or (layout == 3) or (layout == 6) or (layout == 7)  or (layout == 8) or (layout == 9) or (layout == 10) or (layout == 11) then size = 38 end

	if (layout == 2) or (layout == 3) then
		frame:SetWidth(6*size + margin)
		frame:SetHeight(2*size + padding)
	elseif layout == 6 then
		frame:SetWidth(4*size + margin)
		frame:SetHeight(3*size + margin)
	elseif layout == 7 then
	  frame:SetWidth(7*size + 6*margin)
		frame:SetHeight(2*size - margin)
	elseif layout == 8 then
		frame:SetWidth(7*size + margin + padding)
		frame:SetHeight(2*size + margin + padding)
	elseif (layout == 9) or (layout == 10) then
		frame:SetWidth(6*size + 2*margin + 2*padding)
		frame:SetHeight(2*size + 2*margin + padding)
	elseif layout == 11 then
		frame:SetWidth((num+8)*size + (num+3)*margin + (num+3)*padding)
	  frame:SetHeight(2*size)
	else
		frame:SetWidth(size + padding)
		frame:SetHeight((num+1)*size + (num-1)*margin + 8*padding)
	end

	if not frame.mover then
		frame.mover = M.Mover(frame, SHOW_MULTIBAR3_TEXT, "Bar4", frame.Pos)
	else
		frame.mover:SetSize(frame:GetSize())
	end

	if not frame.SetFrameSize then
		frame.buttonSize = size
		frame.numButtons = num
		frame.SetFrameSize = SetFrameSize
	end
end

local function updateVisibility(event)
	if InCombatLockdown() then
		M:RegisterEvent("PLAYER_REGEN_ENABLED", updateVisibility)
	else
		InterfaceOptions_UpdateMultiActionBars()
		M:UnregisterEvent(event, updateVisibility)
	end
end

function Bar:FixSizebarVisibility()
	M:RegisterEvent("PET_BATTLE_OVER", updateVisibility)
	M:RegisterEvent("PET_BATTLE_CLOSE", updateVisibility)
	M:RegisterEvent("UNIT_EXITED_VEHICLE", updateVisibility)
	M:RegisterEvent("UNIT_EXITING_VEHICLE", updateVisibility)
end

function Bar:CreateBar4()
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}
	local layout = R.db["Actionbar"]["Style"]

	if (layout == 2) or (layout == 3) or (layout == 6) or (layout == 7)  or (layout == 8) or (layout == 9) or (layout == 10) or (layout == 11) then size = 38 end
	local frame = CreateFrame("Frame", "UI_ActionBar4", UIParent, "SecureHandlerStateTemplate")
	if (layout == 2) or (layout == 3) then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -9*size - 2*padding, 2}	
	elseif layout == 6 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -8*size - margin , margin}
	elseif layout == 7 then
		frame.Pos = {"CENTER", UIParent, "CENTER", 0, -230}
	elseif layout == 8 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -9*size + 2*margin, 6}
	elseif (layout == 9) or (layout == 10) then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -9*size - 2*padding, 2}
	elseif layout == 11 then
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 2}
	else
		frame.Pos = {"RIGHT", UIParent, "RIGHT", 0, -88}
	end
	MultiBarRight:SetParent(frame)
	MultiBarRight:EnableMouse(false)
	MultiBarRight.QuickKeybindGlow:SetTexture("")
	for i = 1, num do
		local button = _G["MultiBarRightButton"..i]
		tinsert(buttonList, button)
		tinsert(Bar.buttons, button)
		button:ClearAllPoints()
		if (layout == 2) or (layout == 3) then
			if i == 1 then
				button:SetPoint("TOPRIGHT", frame, -padding, -padding)
			elseif i == 7 then
				button:SetPoint("TOP", _G["MultiBarRightButton1"], "BOTTOM", 0, -margin)
			else
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			end	
		elseif layout == 6 then
			if i == 1 then
				button:SetPoint("TOPRIGHT", frame, -padding, -padding)
			elseif i == 5 then
				local previous = _G["MultiBarRightButton1"]
				button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
			elseif i == 9 then
				local previous = _G["MultiBarRightButton5"]
				button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
			else
				local previous = _G["MultiBarRightButton"..i-1]
				button:SetPoint("RIGHT", previous, "LEFT", -margin, 0)
			end
		elseif layout == 7 then
		  if i == 1 then
			  button:SetSize(size *1.2, size *1.2)
			  button:SetPoint("LEFT", frame, padding, 0)
		  elseif i == 2 then
			  button:SetSize(size *0.9, size *0.9)
			  button:SetPoint("LEFT", _G["MultiBarRightButton1"], "TOPRIGHT", margin, -2*margin)
		  elseif i == 7 then
			  button:SetSize(size *0.9, size *0.9)
			  button:SetPoint("TOP", _G["MultiBarRightButton2"], "BOTTOM", 0, -margin)
			elseif i == 12 then
			  button:SetSize(size *1.2, size *1.2)
			  button:SetPoint("TOPLEFT", _G["MultiBarRightButton6"], "RIGHT", margin, 2*margin)
			else
			  button:SetSize(size *0.9, size *0.9)
			  button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", margin, 0)
			end
		elseif layout == 8 then
			if i == 1 then
				button:SetSize(size + 7, size + 7)
				button:SetPoint("TOPLEFT", frame, padding, -padding)
			elseif i == 2 then
				button:SetSize(size + 7, size + 7)
				button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", margin, 0)
			elseif i == 3 then
				button:SetSize(size + 7, size + 7)
				button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", margin, 0)
			elseif i == 4 then
				button:SetSize(size + 7, size + 7)
				button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", margin, 0)
			elseif i == 5 then
				button:SetSize(size - 7, size - 7)
				button:SetPoint("TOPLEFT", _G["MultiBarRightButton1"], "BOTTOMLEFT", 0, -margin)
			else
				button:SetSize(size - 7, size - 7)
				button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", 1.3*margin, 0)
			end
		elseif layout == 9 then
			if i == 1 then
				button:SetSize(size + 7, size + 7)
				button:SetPoint("TOPRIGHT", frame, -padding, -padding)
			elseif i == 2 then
				button:SetSize(size + 7, size + 7)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			elseif i == 3 then
				button:SetSize(size + 7, size + 7)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			elseif i == 4 then
				button:SetSize(size + 7, size + 7)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			elseif i == 5 then
				button:SetSize(size + 7, size + 7)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			elseif i == 6 then
				button:SetSize(size - 7, size - 7)
				button:SetPoint("TOPRIGHT", _G["MultiBarRightButton1"], "BOTTOMRIGHT", 0, -margin)
			else
				button:SetSize(size - 7, size - 7)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -1.3*margin, 0)
			end
		elseif layout == 10 then
		  if i == 1 then
				button:SetSize(size, size)
				button:SetPoint("TOPRIGHT", frame, -padding, -padding)
			elseif i == 2 then
				button:SetSize(size, size)
				button:SetPoint("RIGHT", _G["MultiBarRightButton1"], "LEFT", -margin, 0)
			elseif i == 3 then
				button:SetSize(size, size)
				button:SetPoint("TOPRIGHT", _G["MultiBarRightButton1"], "BOTTOMRIGHT", 0, -margin)
			elseif i == 4 then
				button:SetSize(size, size)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			elseif i == 5 then
				button:SetSize(size + 10, size + 10)
				button:SetPoint("TOPRIGHT", _G["MultiBarRightButton2"], "TOPLEFT", -margin, 0)
			elseif i == 6 then
				button:SetSize(size + 10, size + 10)
				button:SetPoint("RIGHT", _G["MultiBarRightButton5"], "LEFT", -margin, 0)
			elseif i == 7 then
				button:SetSize(size + 10, size + 10)
				button:SetPoint("RIGHT", _G["MultiBarRightButton6"], "LEFT", -margin, 0)
			elseif i == 8 then
				button:SetSize(size - 10, size - 10)
				button:SetPoint("TOPRIGHT", _G["MultiBarRightButton5"], "BOTTOMRIGHT", 0, -margin)
			else
				button:SetSize(size - 10, size - 10)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			end
		elseif layout == 11 then
		  if i == 1 then
				button:SetPoint("LEFT", frame, padding, 0)
			elseif i == 2 then
				button:SetSize(size *1.5, size *1.5)
			  button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", 2*margin, 0)
			elseif i == 3 then
				button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "TOPRIGHT", 2*margin, -3*margin)
			elseif i == 5 then
				button:SetPoint("TOP", _G["MultiBarRightButton3"], "BOTTOM", 0, -margin)
			elseif i == 7 then
				button:SetPoint("LEFT", _G["MultiBarRightButton4"], "RIGHT", 12*size + 2*margin, 0)
			elseif i == 9 then
				button:SetPoint("TOP", _G["MultiBarRightButton7"], "BOTTOM", 0, -margin)
			elseif i == 11 then
				button:SetSize(size *1.5, size *1.5)
			  button:SetPoint("TOPLEFT", _G["MultiBarRightButton8"], "RIGHT", 2*margin, 3*margin)
			elseif i == 12 then
				button:SetPoint("LEFT", _G["MultiBarRightButton11"], "RIGHT", 2*margin, 0)
			else
				button:SetSize(size, size)
				button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", margin, 0)
			end
		else
			if i == 1 then
				button:SetPoint("TOPRIGHT", frame, 0, 0)
			else
				button:SetPoint("TOP", _G["MultiBarRightButton"..i-1], "BOTTOM", 0, -margin)
			end
		end
	end

	frame.buttonList = buttonList
	SetFrameSize(frame, cfg.size, num)

	frame.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	if R.db["Actionbar"]["Bar4Fade"] and cfg.fader then
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end

	-- Fix visibility when leaving vehicle or petbattle
	Bar:FixSizebarVisibility()
end