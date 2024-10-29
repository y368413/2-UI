local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local keyButton = gsub(KEY_BUTTON4, "%d", "")
local keyNumpad = gsub(KEY_NUMPAD1, "%d", "")

local replaces = {
	{"("..keyButton..")", "M"},
	{"("..keyNumpad..")", "N"},
	{"(a%-)", "A"},
	{"(c%-)", "C"},
	{"(s%-)", "S"},
	{KEY_BUTTON3, "●"},
	{KEY_MOUSEWHEELUP, "▲"},
	{KEY_MOUSEWHEELDOWN, "▼"},
	{KEY_SPACE, "■■"},
	{CAPSLOCK_KEY_TEXT, "CL"},
	{"Capslock", "CL"},
	{"BUTTON", "M"},
	{"NUMPAD", "Num"},
	{"(Num Pad +)", "+"},
	{"(数字键盘 +)", "+"},
	{"(数字键盘 %-)", "Num"},
	{"(ALT%-)", "A"},
	{"(CTRL%-)", "C"},
	{"(SHIFT%-)", "S"},
	{"MOUSEWHEELUP", "▲"},
	{"MOUSEWHEELDOWN", "▼"},
	{"SPACE", "■■"},
	{"(Page Up)", "P↑"},
	{"(Page Down)", "P↓"},
	{"(Insert)", "Ins"},
	{"(Delete)", "Del"},
	{"(`)", "~"},
}

function Bar:UpdateHotKey()
	local text = self:GetText()
	if not text then return end

	if text == RANGE_INDICATOR then
		text = ""
	else
		for _, value in pairs(replaces) do
			text = gsub(text, value[1], value[2])
		end
	end
	self:SetFormattedText("%s", text)
end

function Bar:UpdateEquipedColor(button)
	if not button.__bg then return end

	if button.Border:IsShown() then
		button.__bg:SetBackdropBorderColor(0, .7, .1)
	else
		button.__bg:SetBackdropBorderColor(0, 0, 0)
	end
end

function Bar:StyleActionButton(button)
	if not button then return end
	if button.__styled then return end

	local buttonName = button:GetName()
	local icon = button.icon
	local cooldown = button.cooldown
	local hotkey = button.HotKey
	local count = button.Count
	local name = button.Name
	local flash = button.Flash
	local border = button.Border
	local normal = button.NormalTexture
	local normal2 = button:GetNormalTexture()
	local slotbg = button.SlotBackground
	local pushed = button.PushedTexture
	local checked = button.CheckedTexture
	local highlight = button.HighlightTexture
	local newActionTexture = button.NewActionTexture
	local spellHighlight = button.SpellHighlightTexture
	local iconMask = button.IconMask
	local petShine = _G[buttonName.."Shine"]
	local autoCastable = button.AutoCastable

	if normal then normal:SetAlpha(0) end
	if normal2 then normal2:SetAlpha(0) end
	if flash then flash:SetTexture(nil) end
	if newActionTexture then newActionTexture:SetTexture(nil) end
	if border then border:SetTexture(nil) end
	if slotbg then slotbg:Hide() end
	if iconMask then iconMask:Hide() end
	if button.style then button.style:SetAlpha(0) end
	if petShine then petShine:SetInside() end
	if autoCastable then
		autoCastable:SetTexCoord(.217, .765, .217, .765)
		autoCastable:SetInside()
	end

	if icon then
		icon:SetInside()
		if not icon.__lockdown then
			icon:SetTexCoord(unpack(I.TexCoord))
		end
		button.__bg = M.SetBD(icon, .25)
	end
	if cooldown then
		cooldown:SetAllPoints()
	end
	if pushed then
		pushed:SetInside()
		pushed:SetTexture(I.pushedTex)
	end
	if checked then
		checked:SetInside()
		checked:SetColorTexture(1, .8, 0, .35)
	end
	if highlight then
		highlight:SetInside()
		highlight:SetColorTexture(1, 1, 1, .25)
	end
	if spellHighlight then
		spellHighlight:SetOutside()
	end
	if hotkey then
		Bar.UpdateHotKey(hotkey)
		hooksecurefunc(hotkey, "SetText", Bar.UpdateHotKey)
	end

	button.__styled = true
end

function Bar:ReskinBars()
	for i = 1, 8 do
		for j = 1, 12 do
			Bar:StyleActionButton(_G["UI_ActionBar"..i.."Button"..j])
		end
	end
	--petbar buttons
	for i = 1, NUM_PET_ACTION_SLOTS do
		Bar:StyleActionButton(_G["PetActionButton"..i])
	end
	--stancebar buttons
	for i = 1, 10 do
		Bar:StyleActionButton(_G["StanceButton"..i])
	end
	--leave vehicle
	Bar:StyleActionButton(_G["UI_LeaveVehicleButton"])
	--extra action button
	Bar:StyleActionButton(ExtraActionButton1)
	--spell flyout
	SpellFlyout.Background:SetAlpha(0)
	local numFlyouts = 1
	local function checkForFlyoutButtons()
		local button = _G["SpellFlyoutButton"..numFlyouts]
		while button do
			Bar:StyleActionButton(button)
			numFlyouts = numFlyouts + 1
			button = _G["SpellFlyoutButton"..numFlyouts]
		end
	end
	SpellFlyout:HookScript("OnShow", checkForFlyoutButtons)
	SpellFlyout:HookScript("OnHide", checkForFlyoutButtons)
end
