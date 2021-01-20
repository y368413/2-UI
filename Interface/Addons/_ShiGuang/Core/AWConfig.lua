local _, ns = ...
local M, R, U, I = unpack(ns)
local G = M:GetModule("GUI")

local r, g, b = I.r, I.g, I.b
local pairs, floor = pairs, math.floor
local f

-- Elements
local function labelOnEnter(self)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(self:GetParent(), "ANCHOR_RIGHT", 0, 3)
	GameTooltip:AddLine(self.text)
	GameTooltip:AddLine(self.tip, .6,.8,1, 1)
	GameTooltip:Show()
end

local function createLabel(parent, text, tip)
	local label = M.CreateFS(parent, 14, text, "system", "CENTER", 0, 25)
	if not tip then return end
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetAllPoints(label)
	frame.text = text
	frame.tip = tip
	frame:SetScript("OnEnter", labelOnEnter)
	frame:SetScript("OnLeave", M.HideTooltip)
end

function G:CreateEditbox(parent, text, x, y, tip, width, height)
	local eb = M.CreateEditBox(parent, width or 90, height or 30)
	eb:SetPoint("TOPLEFT", x, y)
	eb:SetMaxLetters(255)
	createLabel(eb, text, tip)

	return eb
end

function G:CreateCheckBox(parent, text, x, y, tip)
	local cb = M.CreateCheckBox(parent)
	cb:SetPoint("TOPLEFT", x, y)
	cb:SetHitRectInsets(-5, -5, -5, -5)
	createLabel(cb, text, tip)

	return cb
end

function G:CreateDropdown(parent, text, x, y, data, tip, width, height)
	local dd = M.CreateDropDown(parent, width or 90, height or 30, data)
	dd:SetPoint("TOPLEFT", x, y)
	createLabel(dd, text, tip)

	return dd
end

function G:ClearEdit(element)
	if element.Type == "EditBox" then
		element:ClearFocus()
		element:SetText("")
	elseif element.Type == "CheckBox" then
		element:SetChecked(false)
	elseif element.Type == "DropDown" then
		element.Text:SetText("")
		for i = 1, #element.options do
			element.options[i].selected = false
		end
	end
end

local function createPage(name)
	local p = CreateFrame("Frame", nil, f, "BackdropTemplate")
	p:SetPoint("TOPLEFT", 160, -70)
	p:SetSize(620, 380)
	M.CreateBD(p, .25)
	M.CreateFS(p, 15, name, false, "TOPLEFT", 5, 20)
	p:Hide()
	return p
end

function G:CreateScroll(parent, width, height, text)
	local scroll = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
	scroll:SetSize(width, height)
	scroll:SetPoint("BOTTOMLEFT", 10, 10)
	M.CreateBDFrame(scroll, .2)
	if text then
		M.CreateFS(scroll, 15, text, false, "TOPLEFT", 5, 20)
	end
	scroll.child = CreateFrame("Frame", nil, scroll)
	scroll.child:SetSize(width, 1)
	scroll:SetScrollChild(scroll.child)
	--M.ReskinScroll(scroll.ScrollBar)

	return scroll
end

function G:CreateBarWidgets(parent, texture)
	local icon = CreateFrame("Frame", nil, parent)
	icon:SetSize(20, 20)
	icon:SetPoint("LEFT", 5, 0)
	M.PixelIcon(icon, texture, true)

	local close = CreateFrame("Button", nil, parent)
	close:SetSize(20, 20)
	close:SetPoint("RIGHT", -5, 0)
	close.Icon = close:CreateTexture(nil, "ARTWORK")
	close.Icon:SetAllPoints()
	close.Icon:SetTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up")
	close:SetHighlightTexture(close.Icon:GetTexture())

	return icon, close
end

local function auraWatchShow()
	SlashCmdList.AuraWatch("move")
end

local function auraWatchHide()
	SlashCmdList.AuraWatch("lock")
end

local function CreatePanel()
	if f then f:Show() return end

	-- Structure
	f = CreateFrame("Frame", "NDui_AWConfig", UIParent)
	f:SetPoint("CENTER")
	f:SetSize(800, 500)
	M.SetBD(f)
	M.CreateMF(f)
	M.CreateFS(f, 17, "从NDui趴来的自定义技能监视", true, "TOP", 0, -10)
	M.CreateFS(f, 15, U["Groups"], true, "TOPLEFT", 30, -50)
	f:SetFrameStrata("HIGH")
	f:SetFrameLevel(5)
	tinsert(UISpecialFrames, "NDui_AWConfig")

	auraWatchShow()
	f:HookScript("OnShow", auraWatchShow)
	f:HookScript("OnHide", auraWatchHide)

	f.Close = M.CreateButton(f, 80, 25, CLOSE)
	f.Close:SetPoint("BOTTOMRIGHT", -20, 15)
	f.Close:SetScript("OnClick", function()
		f:Hide()
	end)

	f.Complete = M.CreateButton(f, 80, 25, OKAY)
	f.Complete:SetPoint("RIGHT", f.Close, "LEFT", -10, 0)
	f.Complete:SetScript("OnClick", function()
		f:Hide()
		StaticPopup_Show("RELOAD_NDUI")
	end)

	f.Reset = M.CreateButton(f, 120, 25, "Reset?")
	f.Reset:SetPoint("BOTTOMLEFT", 25, 15)
	StaticPopupDialogs["RESET_NDUI_AWLIST"] = {
		text = U["Reset your AuraWatch List?"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			R.db["AuraWatchList"] = {}
			R.db["InternalCD"] = {}
			ReloadUI()
		end,
		whileDead = 1,
	}
	f.Reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_NDUI_AWLIST")
	end)

	local barTable = {}
	local function SortBars(index)
		local num, onLeft, onRight = 1, 1, 1
		for k in pairs(barTable[index]) do
			if (index < 10 and R.db["AuraWatchList"][index][k]) or (index == 10 and R.db["InternalCD"][k]) then
				local bar = barTable[index][k]
				if num == 1 then
					bar:SetPoint("TOPLEFT", 10, -10)
				elseif num > 1 and num/2 ~= floor(num/2) then
					bar:SetPoint("TOPLEFT", 10, -10 - 35*onLeft)
					onLeft = onLeft + 1
				elseif num == 2 then
					bar:SetPoint("TOPLEFT", 295, -10)
				elseif num > 2 and num/2 == floor(num/2) then
					bar:SetPoint("TOPLEFT", 295, -10 - 35*onRight)
					onRight = onRight + 1
				end
				num = num + 1
			end
		end
	end

	local slotIndex = {
		[6] = INVTYPE_WAIST,
		[11] = INVTYPE_FINGER.."1",
		[12] = INVTYPE_FINGER.."2",
		[13] = INVTYPE_TRINKET.."1",
		[14] = INVTYPE_TRINKET.."2",
		[15] = INVTYPE_CLOAK,
	}

	local function iconOnEnter(self)
		GameTooltip:ClearLines()
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 3)
		if self.typeID == "SlotID" then
			GameTooltip:SetInventoryItem("player", self.spellID)
		else
			GameTooltip:SetSpellByID(self.spellID)
		end
		GameTooltip:Show()
	end

	local function AddAura(parent, index, data)
		local typeID, spellID, unitID, caster, stack, amount, timeless, combat, text, flash = unpack(data)
		local name, _, texture = GetSpellInfo(spellID)
		if typeID == "SlotID" then
			texture = GetInventoryItemTexture("player", spellID)
			name = slotIndex[spellID]
		elseif typeID == "TotemID" then
			texture = "Interface\\ICONS\\Spell_Shaman_TotemRecall"
			name = U["TotemSlot"]..spellID
		end

		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(270, 30)
		M.CreateBD(bar, .25)
		barTable[index][spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		icon.typeID = typeID
		icon.spellID = spellID
		if typeID ~= "TotemID" then
			icon:SetScript("OnEnter", iconOnEnter)
			icon:SetScript("OnLeave", M.HideTooltip)
		end
		close:SetScript("OnClick", function()
			bar:Hide()
			R.db["AuraWatchList"][index][spellID] = nil
			barTable[index][spellID] = nil
			SortBars(index)
		end)

		local spellName = M.CreateFS(bar, 14, name, false, "LEFT", 30, 0)
		spellName:SetWidth(180)
		spellName:SetJustifyH("LEFT")
		M.CreateFS(bar, 14, text, false, "RIGHT", -30, 0)
		M.AddTooltip(bar, "ANCHOR_TOP", U["Type*"].." "..typeID, "system")

		typeID = typeID.." = "..spellID
		unitID = unitID and ", UnitID = \""..unitID.."\"" or ""
		caster = caster and ", Caster = \""..caster.."\"" or ""
		stack = stack and ", Stack = "..stack or ""
		amount = amount and ", Value = true" or ""
		timeless = timeless and ", Timeless = true" or ""
		combat = combat and ", Combat = true" or ""
		flash = flash and ", Flash = true" or ""
		text = text and text ~= "" and ", Text = \""..text.."\"" or ""
		local output = "{"..typeID..unitID..caster..stack..amount..timeless..combat..flash..text.."}"
		bar:SetScript("OnMouseUp", function()
			local editBox = ChatEdit_ChooseBoxForSend()
			ChatEdit_ActivateChat(editBox)
			editBox:SetText(output..",")
			editBox:HighlightText()
		end)

		SortBars(index)
	end

	local function AddInternal(parent, index, data)
		local intID, duration, trigger, unit, itemID = unpack(data)
		local name, _, texture = GetSpellInfo(intID)
		if itemID then
			name = GetItemInfo(itemID)
		end

		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(270, 30)
		M.CreateBD(bar, .25)
		barTable[index][intID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", intID)
		close:SetScript("OnClick", function()
			bar:Hide()
			R.db["InternalCD"][intID] = nil
			barTable[index][intID] = nil
			SortBars(index)
		end)

		local spellName = M.CreateFS(bar, 14, name, false, "LEFT", 30, 0)
		spellName:SetWidth(180)
		spellName:SetJustifyH("LEFT")
		M.CreateFS(bar, 14, duration, false, "RIGHT", -30, 0)
		M.AddTooltip(bar, "ANCHOR_TOP", U["Trigger"]..trigger.." - "..unit, "system")

		SortBars(index)
	end

	local function createGroupSwitcher(parent, index)
		local bu = M.CreateCheckBox(parent)
		bu:SetHitRectInsets(-100, 0, 0, 0)
		bu:SetPoint("TOPRIGHT", -40, -145)
		bu:SetChecked(R.db["AuraWatchList"]["Switcher"][index])
		bu:SetScript("OnClick", function()
			R.db["AuraWatchList"]["Switcher"][index] = bu:GetChecked()
		end)
		M.CreateFS(bu, 15, "|cffff0000"..U["AW Switcher"], false, "RIGHT", -25, 0)
	end

	-- Main
	local groups = {
		U["Player Aura"],			-- 1 PlayerBuff
		U["Special Aura"],			-- 2 SPECIAL
		U["Target Aura"],			-- 3 TargetDebuff
		U["Warning"],				-- 4 Warning
		U["Focus Aura"],			-- 5 FOCUS
		U["Spell Cooldown"],		-- 6 CD
		U["Enchant Aura"],			-- 7 Enchant
		U["Raid Buff"],				-- 8 RaidBuff
		U["Raid Debuff"],			-- 9 RaidDebuff
		U["InternalCD"],			-- 10 InternalCD
	}

	local preSet = {
		[1] = {1, false},
		[2] = {1, true},
		[3] = {2, true},
		[4] = {2, false},
		[5] = {3, false},
		[6] = {1, false},
		[7] = {1, false},
		[8] = {1, false},
		[9] = {1, false},
	}

	local tabs = {}
	local function tabOnClick(self)
		for i = 1, #tabs do
			if self == tabs[i] then
				tabs[i].Page:Show()
				tabs[i]:SetBackdropColor(r, g, b, .3)
				tabs[i].selected = true
			else
				tabs[i].Page:Hide()
				tabs[i]:SetBackdropColor(0, 0, 0, .3)
				tabs[i].selected = false
			end
		end
	end
	local function tabOnEnter(self)
		if self.selected then return end
		self:SetBackdropColor(r, g, b, .3)
	end
	local function tabOnLeave(self)
		if self.selected then return end
		self:SetBackdropColor(0, 0, 0, .3)
	end

	for i, group in pairs(groups) do
		if not R.db["AuraWatchList"][i] then R.db["AuraWatchList"][i] = {} end
		barTable[i] = {}

		tabs[i] = CreateFrame("Button", "$parentTab"..i, f, "BackdropTemplate")
		tabs[i]:SetPoint("TOPLEFT", 20, -40 - i*30)
		tabs[i]:SetSize(130, 28)
		M.CreateBD(tabs[i], .25)
		local label = M.CreateFS(tabs[i], 15, group, "system", "LEFT", 10, 0)
		if i == 10 then
			label:SetTextColor(0, .8, .3)
		end
		tabs[i].Page = createPage(group)
		tabs[i].List = G:CreateScroll(tabs[i].Page, 575, 200, U["AuraWatch List"])

		local Option = {}
		if i < 10 then
			for _, v in pairs(R.db["AuraWatchList"][i]) do
				AddAura(tabs[i].List.child, i, v)
			end
			Option[1] = G:CreateDropdown(tabs[i].Page, U["Type*"], 20, -30, {"AuraID", "SpellID", "SlotID", "TotemID"}, U["Type Intro"])
			Option[2] = G:CreateEditbox(tabs[i].Page, "ID*", 140, -30, U["ID Intro"])
			Option[3] = G:CreateDropdown(tabs[i].Page, U["Unit*"], 260, -30, {"player", "target", "focus", "pet"}, U["Unit Intro"])
			Option[4] = G:CreateDropdown(tabs[i].Page, U["Caster"], 380, -30, {"player", "target", "pet"}, U["Caster Intro"])
			Option[5] = G:CreateEditbox(tabs[i].Page, U["Stack"], 500, -30, U["Stack Intro"])
			Option[6] = G:CreateCheckBox(tabs[i].Page, U["Value"], 40, -95, U["Value Intro"])
			Option[7] = G:CreateCheckBox(tabs[i].Page, U["Timeless"], 120, -95, U["Timeless Intro"])
			Option[8] = G:CreateCheckBox(tabs[i].Page, U["Combat"], 200, -95, U["Combat Intro"])
			Option[9] = G:CreateEditbox(tabs[i].Page, U["Text"], 340, -90, U["Text Intro"])
			Option[10] = G:CreateCheckBox(tabs[i].Page, U["Flash"], 280, -95, U["Flash Intro"])
			Option[11] = G:CreateDropdown(tabs[i].Page, U["Slot*"], 140, -30, {slotIndex[6], slotIndex[11], slotIndex[12], slotIndex[13], slotIndex[14], slotIndex[15]}, U["Slot Intro"])
			Option[12] = G:CreateDropdown(tabs[i].Page, U["Totem*"], 140, -30, {U["TotemSlot"].."1", U["TotemSlot"].."2", U["TotemSlot"].."3", U["TotemSlot"].."4"}, U["Totem Intro"])

			for j = 2, 12 do Option[j]:Hide() end

			for j = 1, #Option[1].options do
				Option[1].options[j]:HookScript("OnClick", function()
					for k = 2, 12 do
						Option[k]:Hide()
						G:ClearEdit(Option[k])
					end

					if Option[1].Text:GetText() == "AuraID" then
						for k = 2, 10 do Option[k]:Show() end
						Option[3].options[preSet[i][1]]:Click()
						if preSet[i][2] then Option[4].options[1]:Click() end
					elseif Option[1].Text:GetText() == "SpellID" then
						Option[2]:Show()
					elseif Option[1].Text:GetText() == "SlotID" then
						Option[11]:Show()
					elseif Option[1].Text:GetText() == "TotemID" then
						Option[12]:Show()
					end
				end)
			end
		elseif i == 10 then
			for _, v in pairs(R.db["InternalCD"]) do
				AddInternal(tabs[i].List.child, i, v)
			end
			Option[13] = G:CreateEditbox(tabs[i].Page, U["IntID*"], 20, -30, U["IntID Intro"])
			Option[14] = G:CreateEditbox(tabs[i].Page, U["Duration*"], 140, -30, U["Duration Intro"])
			Option[15] = G:CreateDropdown(tabs[i].Page, U["Trigger"].."*", 260, -30, {"OnAuraGain", "OnCastSuccess"}, U["Trigger Intro"], 130, 30)
			Option[16] = G:CreateDropdown(tabs[i].Page, U["Unit*"], 420, -30, {"Player", "All"}, U["Trigger Unit Intro"])
			Option[17] = G:CreateEditbox(tabs[i].Page, U["ItemID"], 20, -95, U["ItemID Intro"])
		end

		local clear = M.CreateButton(tabs[i].Page, 60, 25, KEY_NUMLOCK_MAC)
		clear:SetPoint("TOPRIGHT", -100, -90)
		clear:SetScript("OnClick", function()
			if i < 10 then
				for j = 2, 12 do G:ClearEdit(Option[j]) end
			elseif i == 10 then
				for j = 13, 17 do G:ClearEdit(Option[j]) end
			end
		end)

		local slotTable = {6, 11, 12, 13, 14, 15}
		local add = M.CreateButton(tabs[i].Page, 60, 25, ADD)
		add:SetPoint("TOPRIGHT", -30, -90)
		add:SetScript("OnClick", function()
			if i < 10 then
				local typeID, spellID, unitID, slotID, totemID = Option[1].Text:GetText(), tonumber(Option[2]:GetText()), Option[3].Text:GetText()
				for i = 1, #Option[11].options do
					if Option[11].options[i].selected then slotID = slotTable[i] break end
				end
				for i = 1, #Option[12].options do
					if Option[12].options[i].selected then totemID = i break end
				end

				if not typeID then UIErrorsFrame:AddMessage(I.InfoColor..U["Choose a Type"]) return end
				if (typeID == "AuraID" and (not spellID or not unitID)) or (typeID == "SpellID" and not spellID) or (typeID == "SlotID" and not slotID) or (typeID == "TotemID" and not totemID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incomplete Input"]) return end
				if (typeID == "AuraID" or typeID == "SpellID") and not GetSpellInfo(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end

				local realID = spellID or slotID or totemID
				if R.db["AuraWatchList"][i][realID] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end

				R.db["AuraWatchList"][i][realID] = {typeID, realID, unitID, Option[4].Text:GetText(), tonumber(Option[5]:GetText()) or false, Option[6]:GetChecked(), Option[7]:GetChecked(), Option[8]:GetChecked(), Option[9]:GetText(), Option[10]:GetChecked()}
				AddAura(tabs[i].List.child, i, R.db["AuraWatchList"][i][realID])
				for i = 2, 12 do G:ClearEdit(Option[i]) end
			elseif i == 10 then
				local intID, duration, trigger, unit, itemID = tonumber(Option[13]:GetText()), tonumber(Option[14]:GetText()), Option[15].Text:GetText(), Option[16].Text:GetText(), tonumber(Option[17]:GetText())
				if not intID or not duration or not trigger or not unit then UIErrorsFrame:AddMessage(I.InfoColor..U["Incomplete Input"]) return end
				if intID and not GetSpellInfo(intID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
				if R.db["InternalCD"][intID] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end

				R.db["InternalCD"][intID] = {intID, duration, trigger, unit, itemID}
				AddInternal(tabs[i].List.child, i, R.db["InternalCD"][intID])
				for i = 13, 17 do G:ClearEdit(Option[i]) end
			end
		end)

		tabs[i]:SetScript("OnClick", tabOnClick)
		tabs[i]:SetScript("OnEnter", tabOnEnter)
		tabs[i]:SetScript("OnLeave", tabOnLeave)
	end

	for i = 1, 10 do
		createGroupSwitcher(tabs[i].Page, i)
	end

	tabs[1]:Click()

	local function showLater(event)
		if event == "PLAYER_REGEN_DISABLED" then
			if f:IsShown() then
				f:Hide()
				M:RegisterEvent("PLAYER_REGEN_ENABLED", showLater)
			end
		else
			f:Show()
			M:UnregisterEvent(event, showLater)
		end
	end
	M:RegisterEvent("PLAYER_REGEN_DISABLED", showLater)
end

SlashCmdList["NDUI_AWCONFIG"] = function()
	if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end
	CreatePanel()
end
SLASH_NDUI_AWCONFIG1 = "/awc"