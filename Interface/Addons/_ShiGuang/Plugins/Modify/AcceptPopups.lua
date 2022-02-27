--[[

## Title: AcceptPopups
## Notes: Accepts a dialog for a day, week or month
## Author: Dahk Celes (DDCorkum)
## X-License: All rights reserved

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

1.5 (2022-01-17) by Dahk Celes
- Options menu tooltips to describe each popup type.

1.4 (2021-12-11) by Dahk Celes
- Add popups from the options menu
- Custom durations up to 365 days

1.3 (2021-12-08) by Dahk Celes
- Rudimentary options menu
- 30 day duration with alt (bugfix)

1.2 (2021-11-19) by Dahk Celes
- Blocklist improvements
- No action on normal clicks (bugfix)

1.1 (2021-11-17) by Dahk Celes
- Prepopulated blocklist
- Error detection for auto-blocklist

1.0 (2021-11-11) by Dahk Celes
- Initial version

--]]


-------------------------
-- Saved Variables

AcceptPopupsUntil = {}			-- timers and interim blocklist
AcceptPopupsOptions = {}		-- persistent options


-------------------------
-- Blocklist

local BLOCKLIST = -1

local neverAcceptPopups =
{
	-- Protected
	["ADD_FRIEND"] = BLOCKLIST,							-- C_FriendList.AddFriend()
	["BID_AUCTION"] = BLOCKLIST,						-- C_AuctionHouse.PlaceBid()
	["BID_BLACKMARKET"] = BLOCKLIST,					-- C_BlackMarket.ItemPlaceBid()
	["BUYOUT_AUCTION"] = BLOCKLIST,						-- C_AuctionHouse.PlaceBid()
	["CANCEL_AUCTION"] = BLOCKLIST,						-- C_AuctionHouse.CancelAuction()
	["DIALOG_REPLACE_MOUNT_EQUIPMENT"] = BLOCKLIST,		-- C_MountJournal.ApplyMountEquipment()
	["DANGEROUS_SCRIPTS_WARNING"] = BLOCKLIST,			-- SetAllowDangerousScripts()
	["QUIT"] = BLOCKLIST,								-- ForceQuit()
		
	-- Requires user input
	["BATTLE_PET_RENAME"] = BLOCKLIST,
	["NAME_CHAT"] = BLOCKLIST,
	["RENAME_GUILD"] = BLOCKLIST,
	["RENAME_PET"] = BLOCKLIST,
}

local function isEligibleDialog(which)
	dialog = StaticPopupDialogs[which]
	if (dialog) then return
		not neverAcceptPopups[which]
		and AcceptPopupsUntil[which] ~= BLOCKLIST
		and dialog.hasMoneyInputFrame ~= 1
		and (dialog.button2 or dialog.button3 or dialog.button4)	-- rules out dialogs with only a single button, such as StaticPopupDialogs.CAMP
	else return
		not neverAcceptPopups[which]
		and AcceptPopupsUntil[which] ~= BLOCKLIST
	end
end


------------------------
-- Popup Automation

do
	local listener = CreateFrame("Frame")
	listener:RegisterEvent("ADDON_ACTION_FORBIDDEN")
	listener:RegisterEvent("ADDON_ACTION_BLOCKED")
	listener:SetScript("OnEvent", function()
		if listener.listenFor then
			print("AcceptPopups detected an error so it will no longer try to automate " .. listener.listenFor .. " popups.")
			listener.listenFor = nil
		end
	end)

	local function popupOnUpdate(self)
		self:SetScript("OnUpdate", nil)
		local which = self:GetParent().which
		if AcceptPopupsUntil[which] and isEligibleDialog(which) and AcceptPopupsUntil[which] > time() then
			listener.listenFor = which
			self:Enable()
			local expiry = AcceptPopupsUntil[which]
			AcceptPopupsUntil[which] = BLOCKLIST	-- place on the interim blocklist, so it is already there if an error happens
			self:Click("Button30")
			C_Timer.After(0.2, function()
				if listener.listenFor then
					listener.listenFor = nil
					AcceptPopupsUntil[which] = expiry	-- it worked, so remove from the interim blocklist
				end
			end)
		end	
	end

	local function popupOnEnter(self)
		local which = self:GetParent().which
		if isEligibleDialog(which) then
			if GameTooltip:GetOwner() ~= self then
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
			end
			--GameTooltip:AddLine("AcceptPopups")
			GameTooltip:AddLine("|cffccccff" .. SHIFT_KEY_TEXT .. "|r|cff999999 - " .. DAYS_ABBR:format(AcceptPopupsOptions.shiftDays or 1))
			GameTooltip:AddLine("|cffccccff" .. CTRL_KEY_TEXT .. "|r|cff999999 - " .. DAYS_ABBR:format(AcceptPopupsOptions.ctrlDays or 7))
			GameTooltip:AddLine("|cffccccff" .. ALT_KEY_TEXT .. "|r|cff999999 - " .. DAYS_ABBR:format(AcceptPopupsOptions.altDays or 30))
			GameTooltip:Show()
		end

	end

	local function popupOnLeave(self)
		GameTooltip:Hide()
	end

	local function popupOnShow(self)
		self:SetScript("OnUpdate", popupOnUpdate) -- delays until the next frame
		self:HookScript("OnEnter", popupOnEnter)
		self:HookScript("OnLeave", popupOnLeave)
	end

	local function popupOnHide(self)
		self:SetScript("OnEnter", nil)
		self:SetScript("OnLeave", nil)
	end

	local function popupPreClick(self, button)
		local which = self:GetParent().which
		if isEligibleDialog(which) and button ~= "Button30" and IsModifierKeyDown() then
			AcceptPopupsUntil[which] = time() + 86400 * (IsShiftKeyDown() and (AcceptPopupsOptions.shiftDays or 1) or IsControlKeyDown() and (AcceptPopupsOptions.ctrlDays or 7) or (AcceptPopupsOptions.altDays or 30))
		end
	end

	StaticPopup1Button1:HookScript("OnShow", popupOnShow)
	StaticPopup1Button1:HookScript("OnHide", popupOnHide)
	StaticPopup1Button1:HookScript("PreClick", popupPreClick)

	StaticPopup2Button1:HookScript("OnShow", popupOnShow)
	StaticPopup2Button1:HookScript("OnHide", popupOnHide)
	StaticPopup2Button1:HookScript("PreClick", popupPreClick)

	StaticPopup3Button1:HookScript("OnShow", popupOnShow)
	StaticPopup3Button1:HookScript("OnHide", popupOnHide)
	StaticPopup3Button1:HookScript("PreClick", popupPreClick)
end


-------------------------
-- Options Menu
if GetLocale() == "zhCN" then
  AcceptPopupsLocal = "|cffe6cc80[弹窗]|r自动确认";
elseif GetLocale() == "zhTW" then
  AcceptPopupsLocal = "|cffe6cc80[弹窗]|r自动确认";
else
  AcceptPopupsLocal = "AcceptPopups";
end

do
	local panel = CreateFrame("Frame")
	panel.name = AcceptPopupsLocal
	panel:Hide()
	InterfaceOptions_AddCategory(panel)
	
	local title = panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
	title:SetText("AcceptPopups")
	title:SetPoint("TOP", 0, -5)

	local subtitle = panel:CreateFontString("ARTWORK", nil, "GameFontNormal")
	subtitle:SetText("Accepts a dialog for a day, week or month")
	subtitle:SetPoint("TOP", title, "BOTTOM", 0, -2)

	local scrollParent = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
	scrollParent:SetPoint("TOPLEFT", 3, -50)
	scrollParent:SetPoint("BOTTOMRIGHT", -27, 4)
	
	local track = scrollParent:CreateTexture("BACKGROUND")
	track:SetColorTexture(0.1, 0.1, 0.1, 0.3)
	track:SetPoint("TOPLEFT", scrollParent, "TOPRIGHT", 4, 0)
	track:SetPoint("BOTTOMRIGHT", scrollParent, 22, 0)
	
	local scrollChild = CreateFrame("Frame")
	scrollParent:SetScrollChild(scrollChild)
	scrollChild:SetWidth(InterfaceOptionsFramePanelContainer:GetWidth()-18)
	
	function panel.default()
		for key, date in pairs(AcceptPopupsUntil) do
			if date > time() then
				AcceptPopupsUntil[key] = 1
			end
		end
		wipe(AcceptPopupsOptions)
		if panel:IsVisible() then
			panel:Hide()
			panel:Show()
		end
	end

	local fontStrings = CreateFontStringPool(scrollChild, "ARTWORK", 0, "GameFontNormal")
	local buttons = CreateObjectPool(
		function(self)
			local button = CreateFrame("Button", nil, scrollChild, "UIPanelButtonNoTooltipTemplate")
			button:SetSize(14,14)
			button:SetText("?")
			button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			button:SetScript("OnClick", function(__, mouseBtn)
				if mouseBtn == "LeftButton" and IsModifierKeyDown() then
					AcceptPopupsUntil[button.key] = time() + 86400 * (IsShiftKeyDown() and (AcceptPopupsOptions.shiftDays or 1) or IsControlKeyDown() and (AcceptPopupsOptions.ctrlDays or 7) or (AcceptPopupsOptions.altDays or 30))
				elseif mouseBtn == "RightButton" then
					AcceptPopupsUntil[button.key] = AcceptPopupsUntil[button.key] > time() and 1 or nil
				end
				panel:Hide()
				panel:Show()
			end)
			button:SetScript("OnEnter", function()
				GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
				GameTooltip:AddLine(button.key)
				GameTooltip:AddLine("|n|cffffffff" .. KEY_BUTTON1)
				GameTooltip:AddLine("|cffccccff" .. SHIFT_KEY_TEXT .. "|r|cff999999 - " .. DAYS_ABBR:format(AcceptPopupsOptions.shiftDays or 1))
				GameTooltip:AddLine("|cffccccff" .. CTRL_KEY_TEXT .. "|r|cff999999 - " .. DAYS_ABBR:format(AcceptPopupsOptions.ctrlDays or 7))
				GameTooltip:AddLine("|cffccccff" .. ALT_KEY_TEXT .. "|r|cff999999 - " .. DAYS_ABBR:format(AcceptPopupsOptions.altDays or 30))
				if AcceptPopupsUntil[button.key] > time() then
					GameTooltip:AddLine("|n|cffffffff" .. KEY_BUTTON2 .. "|r|cffff6666 - " .. CANCEL)
				else
					GameTooltip:AddLine("|n|cffffffff" .. KEY_BUTTON2 .. "|r|cffff6666 - " .. REMOVE)
				end
				if StaticPopupDialogs[button.key] then
					GameTooltip:AddLine("|n" .. StaticPopupDialogs[button.key].text, 0.5, 0.5, 0.5)
				end
				GameTooltip:Show()
			end)
			button:SetScript("OnLeave", function()
				GameTooltip:Hide()
			end)
			return button
		end,
		FramePool_HideAndClearAnchors
	)
	
	
	local dropdown = CreateFrame("Frame", nil, scrollChild, "UIDropDownMenuTemplate")
	UIDropDownMenu_Initialize(dropdown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		info.notCheckable = true
		if level == 1 then
			info.hasArrow = true
			info.text = "CONFIRM ... a-m"
			info.menuList = "CONFIRMA"
			UIDropDownMenu_AddButton(info)
			info.text = "CONFIRM ... n-z"
			info.menuList = "CONFIRMN"
			UIDropDownMenu_AddButton(info)
			info.text = "a-c"
			info.menuList = "ABC"
			UIDropDownMenu_AddButton(info)
			info.text = "d-j"
			info.menuList = "DEFGHIK"
			UIDropDownMenu_AddButton(info)
			info.text = "k-r"
			info.menuList = "KLMNOPQR"
			UIDropDownMenu_AddButton(info)
			info.text = "s-z"
			info.menuList = "STUVWXYZ"
			UIDropDownMenu_AddButton(info)
		elseif menuList then
			function info.func(__, which)
				AcceptPopupsUntil[which] = time() + 86400
				panel:Hide()
				panel:Show()
			end
			local keys = {}
			if menuList == "CONFIRMA" then
				for key in pairs(StaticPopupDialogs) do
					if isEligibleDialog(key) and not AcceptPopupsUntil[key] and key:sub(1,8) == "CONFIRM_" and ("ABCDEFGHIJKLM"):find(key:sub(9,9)) then
						tinsert(keys, key)
					end
				end
			elseif menuList == "CONFIRMN" then
				for key in pairs(StaticPopupDialogs) do
					if isEligibleDialog(key) and not AcceptPopupsUntil[key] and key:sub(1,8) == "CONFIRM_" and ("NOPQRSTUVWXYZ"):find(key:sub(9,9)) then
						tinsert(keys, key)
					end
				end
			else
				for key in pairs(StaticPopupDialogs) do
					if isEligibleDialog(key) and not AcceptPopupsUntil[key] and key:sub(1,8) ~= "CONFIRM_" and menuList:find(key:sub(1,1)) then
						tinsert(keys, key)
					end
				end
			end
			sort(keys)
			for __, key in ipairs(keys) do
				info.text = key
				info.arg1 = key
				info.tooltipTitle = StaticPopupDialogs[key].text and key
				info.tooltipText = StaticPopupDialogs[key].text
				info.tooltipOnButton = true
				UIDropDownMenu_AddButton(info, 2)
			end
		end
	end, "MENU")

	local dropdownTrigger = CreateFrame("Button", nil, scrollChild, "UIPanelButtonTemplate")
	dropdownTrigger:SetSize(80,30)
	dropdownTrigger:SetText(NEW)
	dropdownTrigger:SetScript("OnClick", function()
		ToggleDropDownMenu(1, nil, dropdown)
	end)
	dropdown:SetPoint("TOPLEFT", dropdownTrigger)
	
	local besideDropdown = scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormal")
	besideDropdown:SetPoint("LEFT", dropdownTrigger, "RIGHT", 5, 0)
	besideDropdown:SetText("Some popup types only appear once triggered in-game.")
	besideDropdown:SetTextColor(0.9, 0.9, 0.9)
	besideDropdown:SetJustifyH("LEFT")

	local shiftEditBox = CreateFrame("EditBox", nil, scrollChild, "NumericInputSpinnerTemplate")
	shiftEditBox:SetMinMaxValues(1, 365)
	shiftEditBox:SetOnValueChangedCallback(function(__, value) AcceptPopupsOptions.shiftDays = value end)
	
	local ctrlEditBox = CreateFrame("EditBox", nil, scrollChild, "NumericInputSpinnerTemplate")
	ctrlEditBox:SetMinMaxValues(1, 365)
	ctrlEditBox:SetOnValueChangedCallback(function(__, value) AcceptPopupsOptions.ctrlDays = value end)
	
	local altEditBox = CreateFrame("EditBox", nil, scrollChild, "NumericInputSpinnerTemplate")
	altEditBox:SetMinMaxValues(1, 365)
	altEditBox:SetOnValueChangedCallback(function(__, value) AcceptPopupsOptions.altDays = value end)
	
	shiftEditBox:SetPoint("RIGHT", ctrlEditBox, "LEFT", -80, 0)
	altEditBox:SetPoint("LEFT", ctrlEditBox, "RIGHT", 80, 0)

	local shiftLabel = shiftEditBox:CreateFontString("ARTWORK", nil, "GameFontNormal")
	shiftLabel:SetText(SHIFT_KEY_TEXT)
	shiftLabel:SetPoint("TOP", shiftEditBox, "BOTTOM")
	
	local ctrlLabel = ctrlEditBox:CreateFontString("ARTWORK", nil, "GameFontNormal")
	ctrlLabel:SetText(CTRL_KEY_TEXT)
	ctrlLabel:SetPoint("TOP", ctrlEditBox, "BOTTOM")
	
	local altLabel = altEditBox:CreateFontString("ARTWORK", nil, "GameFontNormal")
	altLabel:SetText(ALT_KEY_TEXT)
	altLabel:SetPoint("TOP", altEditBox, "BOTTOM")
	
	local function increment(self)
		local old = self:GetValue()
		if old < 15 then
			self:SetValue(old + 1)
		elseif old < 90 then
			self:SetValue(floor(old/2)*2 + 2)
		else
			self:SetValue(floor(old/5)*5 + 5)
		end
	end
	
	local function decrement(self)
		local old = self:GetValue()
		if old <= 15 then
			self:SetValue(old - 1)
		elseif old <= 90 then
			self:SetValue(ceil(old/2)*2 - 2)
		else
			self:SetValue(ceil(old/5)*5 - 5)
		end
	end
	
	shiftEditBox.Increment, shiftEditBox.Decrement = increment, decrement
	ctrlEditBox.Increment, ctrlEditBox.Decrement = increment, decrement
	altEditBox.Increment, altEditBox.Decrement = increment, decrement

	local function panelOnShow(self)
		-- alphabetical sorting
		local keys = {}
		for key, date in pairs(AcceptPopupsUntil) do
			if date > 0 and isEligibleDialog(key) then
				tinsert(keys, key)
			end
		end
		sort(keys)
		
		-- list the active and disabled ones
		local y = -10
		for __, key in ipairs(keys) do
			local duration = AcceptPopupsUntil[key] - time()
			local fontString = fontStrings:Acquire()
			local button = buttons:Acquire()
			if duration > 86400 then
				fontString:SetText(key .. " |cff999999" .. SPELL_DURATION_DAYS:format(duration/86400))
			elseif duration > 0 then
				fontString:SetText(key .. " |cff999999" .. SPELL_DURATION_HOURS:format(duration/3600))
			else
				fontString:SetText(key .. " |cff996666" .. ADDON_DISABLED)
			end
			fontString:SetPoint("LEFT", scrollChild, "TOPLEFT", 30, y)
			fontString:Show()
			button:SetPoint("LEFT", scrollChild, "TOPLEFT", 15, y)
			button.key = key
			button:Show()
			y = y - 20
		end
		
		-- menu to add others
		dropdownTrigger:SetPoint("LEFT", scrollChild, "TOPLEFT", 60, y-20)
		
		-- control the durations for shift, ctrl and alt
		ctrlEditBox:SetPoint("CENTER", scrollChild, "TOP", 0, y-60)
		shiftEditBox:SetValue(AcceptPopupsOptions.shiftDays or 1)
		ctrlEditBox:SetValue(AcceptPopupsOptions.ctrlDays or 7)
		altEditBox:SetValue(AcceptPopupsOptions.altDays or 30)
		
		-- set the height of the scrollChild
		scrollChild:SetHeight(-y+50)
		if #keys > 21 then
			scrollParent.ScrollBar:Show()
			track:Show()
		else
			scrollParent.ScrollBar:Hide()
			track:Hide()
		end
	end

	local function panelOnHide(self)
		fontStrings:ReleaseAll()
		buttons:ReleaseAll()
	end

	panel:SetScript("OnShow", panelOnShow)
	panel:SetScript("OnHide", panelOnHide)

	function SlashCmdList.ACCEPTPOPUPS()
		InterfaceAddOnsList_Update()	-- https://github.com/Stanzilla/WoWUIBugs/issues/89
		InterfaceOptionsFrame_OpenToCategory(panel)
	end
	SLASH_ACCEPTPOPUPS1 = "/acceptpopups"
end