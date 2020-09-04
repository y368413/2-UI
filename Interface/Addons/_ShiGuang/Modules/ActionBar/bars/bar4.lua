local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")
local cfg = R.bars.bar4

function Bar:CreateBar4()
	local padding, margin = 2, 2
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}
	local layout = MaoRUIPerDB["Actionbar"]["Style"]
	if (layout == 2) or (layout == 3) or (layout == 6) or (layout == 7)  or (layout == 8) or (layout == 9) or (layout == 10) then cfg.size = 38 end

	--create the frame to hold the buttons
	local frame = CreateFrame("Frame", "NDui_ActionBar4", UIParent, "SecureHandlerStateTemplate")
	if (layout == 2) or (layout == 3) then
		frame:SetWidth(6*cfg.size + 5*margin + padding)
		frame:SetHeight(2*cfg.size + margin + padding)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -9*cfg.size - 8*padding - padding, 4}
	--elseif layout == 8 then
		--frame:SetWidth(25*cfg.size + 25*margin + 2*padding)
		--frame:SetHeight(2*cfg.size + 2*margin + 2*padding)
		--frame.Pos = {"BOTTOM", UIParent, "BOTTOM", 0, 2}
	elseif layout == 7 then
	  frame:SetWidth(7*cfg.size + 6*margin)
		frame:SetHeight(2*cfg.size - margin)
		frame.Pos = {"CENTER", UIParent, "CENTER", 0, -230}
	elseif layout == 6 then
		frame:SetWidth(4*cfg.size + margin + padding)
		frame:SetHeight(3*cfg.size + margin + padding)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -8*cfg.size - 8*margin , 3*margin}
	elseif layout == 8 then
		frame:SetWidth(7*cfg.size + margin + padding)
		frame:SetHeight(2*cfg.size + margin + padding)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -9*cfg.size + 2*margin, 6}
	elseif (layout == 9) or (layout == 10) then
		frame:SetWidth(6*cfg.size)
		frame:SetHeight(2*cfg.size)
		frame.Pos = {"BOTTOM", UIParent, "BOTTOM", -9*cfg.size - 8*padding, 10}
	else
		frame:SetWidth(cfg.size + 2*padding)
		frame:SetHeight(num*cfg.size + (num-1)*margin + 2*padding)
		frame.Pos = {"RIGHT", UIParent, "RIGHT", -1, -88}
	end

	--move the buttons into position and reparent them
	MultiBarRight:SetParent(frame)
	MultiBarRight:EnableMouse(false)

	for i = 1, num do
		local button = _G["MultiBarRightButton"..i]
		table.insert(buttonList, button) --add the button object to the list
		button:SetSize(cfg.size, cfg.size)
		button:ClearAllPoints()
		if (layout == 2) or (layout == 3) then
			if i == 1 then
				button:SetPoint("TOPRIGHT", frame, -padding, -padding)
			elseif i == 7 then
				button:SetPoint("TOP", _G["MultiBarRightButton1"], "BOTTOM", 0, -margin)
			else
				local previous = _G["MultiBarRightButton"..i-1]
				button:SetPoint("RIGHT", previous, "LEFT", -margin, 0)
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
			  button:SetSize(cfg.size *1.2, cfg.size *1.2)
			  button:SetPoint("LEFT", frame, padding, 0)
		  elseif i == 2 then
			  button:SetSize(cfg.size *0.9, cfg.size *0.9)
			  button:SetPoint("LEFT", _G["MultiBarRightButton1"], "TOPRIGHT", margin, -2*margin)
		  elseif i == 7 then
			  button:SetSize(cfg.size *0.9, cfg.size *0.9)
			  button:SetPoint("TOP", _G["MultiBarRightButton2"], "BOTTOM", 0, -margin)
			elseif i == 12 then
			  button:SetSize(cfg.size *1.2, cfg.size *1.2)
			  button:SetPoint("TOPLEFT", _G["MultiBarRightButton6"], "RIGHT", margin, 2*margin)
			else
			  button:SetSize(cfg.size *0.9, cfg.size *0.9)
			  button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", margin, 0)
			end
		elseif layout == 8 then
			if i == 1 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("TOPLEFT", frame, padding, -padding)
			elseif i == 2 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", margin, 0)
			elseif i == 3 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", margin, 0)
			elseif i == 4 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", margin, 0)
			elseif i == 5 then
				button:SetSize(cfg.size - 7, cfg.size - 7)
				button:SetPoint("TOPLEFT", _G["MultiBarRightButton1"], "BOTTOMLEFT", 0, -margin)
			else
				button:SetSize(cfg.size - 7, cfg.size - 7)
				button:SetPoint("LEFT", _G["MultiBarRightButton"..i-1], "RIGHT", 1.3*margin, 0)
			end
		elseif layout == 9 then
			if i == 1 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("TOPRIGHT", frame, padding, -padding)
			elseif i == 2 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			elseif i == 3 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			elseif i == 4 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			elseif i == 5 then
				button:SetSize(cfg.size + 7, cfg.size + 7)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			elseif i == 6 then
				button:SetSize(cfg.size - 7, cfg.size - 7)
				button:SetPoint("TOPRIGHT", _G["MultiBarRightButton1"], "BOTTOMRIGHT", 0, -margin)
			else
				button:SetSize(cfg.size - 7, cfg.size - 7)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -1.3*margin, 0)
			end
		elseif layout == 10 then
		  if i == 1 then
				button:SetSize(cfg.size, cfg.size)
				button:SetPoint("TOPRIGHT", frame, padding, -padding)
			elseif i == 2 then
				button:SetSize(cfg.size, cfg.size)
				button:SetPoint("RIGHT", _G["MultiBarRightButton1"], "LEFT", -margin, 0)
			elseif i == 3 then
				button:SetSize(cfg.size, cfg.size)
				button:SetPoint("TOPRIGHT", _G["MultiBarRightButton1"], "BOTTOMRIGHT", 0, -margin)
			elseif i == 4 then
				button:SetSize(cfg.size, cfg.size)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			elseif i == 5 then
				button:SetSize(cfg.size + 10, cfg.size + 10)
				button:SetPoint("TOPRIGHT", _G["MultiBarRightButton2"], "TOPLEFT", -margin, 0)
			elseif i == 6 then
				button:SetSize(cfg.size + 10, cfg.size + 10)
				button:SetPoint("RIGHT", _G["MultiBarRightButton5"], "LEFT", -margin, 0)
			elseif i == 7 then
				button:SetSize(cfg.size + 10, cfg.size + 10)
				button:SetPoint("RIGHT", _G["MultiBarRightButton6"], "LEFT", -margin, 0)
			elseif i == 8 then
				button:SetSize(cfg.size - 10, cfg.size - 10)
				button:SetPoint("TOPRIGHT", _G["MultiBarRightButton5"], "BOTTOMRIGHT", 0, -margin)
			else
				button:SetSize(cfg.size - 10, cfg.size - 10)
				button:SetPoint("RIGHT", _G["MultiBarRightButton"..i-1], "LEFT", -margin, 0)
			end
		else
			if i == 1 then
				button:SetPoint("TOPRIGHT", frame, -padding, -padding)
			else
				local previous = _G["MultiBarRightButton"..i-1]
				button:SetPoint("TOP", previous, "BOTTOM", 0, -margin)
			end
		end
	end

	--show/hide the frame on a given state driver
	frame.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	--create drag frame and drag functionality
	if R.bars.userplaced then
		frame.mover = M.Mover(frame, SHOW_MULTIBAR3_TEXT, "Bar4", frame.Pos)
	end

	--create the mouseover functionality
	if MaoRUIPerDB["Actionbar"]["Bar4Fade"] and cfg.fader then
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end

	--fix annoying visibility
	local function updateVisibility(event)
		if InCombatLockdown() then
			M:RegisterEvent("PLAYER_REGEN_ENABLED", updateVisibility)
		else
			InterfaceOptions_UpdateMultiActionBars()
			M:UnregisterEvent(event, updateVisibility)
		end
	end
	M:RegisterEvent("UNIT_EXITING_VEHICLE", updateVisibility)
	M:RegisterEvent("UNIT_EXITED_VEHICLE", updateVisibility)
	M:RegisterEvent("PET_BATTLE_CLOSE", updateVisibility)
	M:RegisterEvent("PET_BATTLE_OVER", updateVisibility)
end