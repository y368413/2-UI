local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local tinsert = tinsert
local mod, min, ceil = mod, min, ceil
local cfg = R.Bars.bar4
local margin, padding = R.Bars.margin, R.Bars.padding

function Bar:CreateCustomBar(anchor)
	local num = 12
	local name = "UI_ActionBarX"
	local page = 8

	local frame = CreateFrame("Frame", name, UIParent, "SecureHandlerStateTemplate")
	frame.mover = M.Mover(frame, U[name], "CustomBar", anchor)

	RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show")
	RegisterStateDriver(frame, "page", page)

	local buttonList = {}
	for i = 1, num do
		local button = CreateFrame("CheckButton", "$parentButton"..i, frame, "ActionBarButtonTemplate")
		button.id = (page-1)*12 + i
		button.isCustomButton = true
		--button.commandName = U[name]..i
		button:SetAttribute("action", button.id)
		tinsert(buttonList, button)
		tinsert(Bar.buttons, button)
	end
	frame.buttons = buttonList

	if cfg.fader then
		frame.isDisable = not R.db["Actionbar"]["BarXFader"]
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end

	Bar:UpdateCustomBar()
end

function Bar:UpdateCustomBar()
	local frame = _G.UI_ActionBarX
	if not frame then return end

	local size = R.db["Actionbar"]["CustomBarButtonSize"]
	local scale = size/32
	local num = R.db["Actionbar"]["CustomBarNumButtons"]
	local perRow = R.db["Actionbar"]["CustomBarNumPerRow"]
	for i = 1, num do
		local button = frame.buttons[i]
		button:SetSize(size, size)
		button.Name:SetScale(scale)
		button.Count:SetScale(scale)
		button.HotKey:SetScale(scale)
		button:ClearAllPoints()
		if i == 1 then
			button:SetPoint("TOPLEFT", frame, padding, -padding)
		elseif mod(i-1, perRow) ==  0 then
			button:SetPoint("TOP", frame.buttons[i-perRow], "BOTTOM", 0, -margin)
		else
			button:SetPoint("LEFT", frame.buttons[i-1], "RIGHT", margin, 0)
		end
		button:SetAttribute("statehidden", false)
		button:Show()
	end

	for i = num+1, 12 do
		local button = frame.buttons[i]
		button:SetAttribute("statehidden", true)
		button:Hide()
	end

	local column = min(num, perRow)
	local rows = ceil(num/perRow)
	frame:SetWidth(column*size + (column-1)*margin + 2*padding)
	frame:SetHeight(size*rows + (rows-1)*margin + 2*padding)
	frame.mover:SetSize(frame:GetSize())
end

function Bar:CustomBar()
	if R.db["Actionbar"]["CustomBar"] then
		Bar:CreateCustomBar({"BOTTOM", UIParent, "BOTTOM", 0, 140})
	end
end