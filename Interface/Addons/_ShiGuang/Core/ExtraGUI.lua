local _, ns = ...
local M, R, U, I = unpack(ns)
local G = M:GetModule("GUI")

local _G = _G
local unpack, pairs, ipairs, tinsert = unpack, pairs, ipairs, tinsert
local min, max, strmatch, strfind, tonumber = min, max, strmatch, strfind, tonumber
local GetSpellInfo, GetSpellTexture = GetSpellInfo, GetSpellTexture
local GetInstanceInfo, EJ_GetInstanceInfo = GetInstanceInfo, EJ_GetInstanceInfo
local IsControlKeyDown = IsControlKeyDown

local function sortBars(barTable)
	local num = 1
	for _, bar in pairs(barTable) do
		bar:SetPoint("TOPLEFT", 10, -10 - 35*(num-1))
		num = num + 1
	end
end

local extraGUIs = {}
local function toggleExtraGUI(guiName)
	for name, frame in pairs(extraGUIs) do
		if name == guiName then
			M:TogglePanel(frame)
		else
			frame:Hide()
		end
	end
end

local function hideExtraGUIs()
	for _, frame in pairs(extraGUIs) do
		frame:Hide()
	end
end

local function createExtraGUI(parent, name, title, bgFrame)
	local frame = CreateFrame("Frame", name, parent)
	local bgTexture = frame:CreateTexture("name", "BACKGROUND")
    bgTexture:SetTexture("Interface\\Destiny\\EndscreenBG");  --FontStyles\\FontStyleGarrisons
    --bgTexture:SetTexCoord(740,950,0,600/1024);
    bgTexture:SetAllPoints();
    bgTexture:SetAlpha(1)
	frame:SetSize(300, 580)
	frame:SetPoint("LEFT", parent:GetParent(), "RIGHT", -360, -16)
	--M.SetBD(frame)

	if title then
		M.CreateFS(frame, 14, title, "system", "TOPLEFT", 20, -5)
	end

	if bgFrame then
		frame.bg = CreateFrame("Frame", nil, frame, "BackdropTemplate")
		frame.bg:SetSize(280, 540)
		frame.bg:SetPoint("TOPLEFT", 10, -30)
		M.CreateBD(frame.bg, .25)
	end

	if not parent.extraGUIHook then
		parent:HookScript("OnHide", hideExtraGUIs)
		parent.extraGUIHook = true
	end
	extraGUIs[name] = frame

	return frame
end

local function clearEdit(options)
	for i = 1, #options do
		G:ClearEdit(options[i])
	end
end

local function updateRaidDebuffs()
	M:GetModule("UnitFrames"):UpdateRaidDebuffs()
end

local function AddNewDungeon(dungeons, dungeonID)
	local name = EJ_GetInstanceInfo(dungeonID)
	if name then
		tinsert(dungeons, name)
	end
end

function G:SetupRaidDebuffs(parent)
	local guiName = "UIGUI_RaidDebuffs"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["RaidFrame Debuffs"].."*", true)
	panel:SetScript("OnHide", updateRaidDebuffs)

	local setupBars
	local frame = panel.bg
	local bars, options = {}, {}

	local iType = G:CreateDropdown(frame, U["Type*"], 10, -30, {DUNGEONS, RAID}, U["Instance Type"])
	for i = 1, 2 do
		iType.options[i]:HookScript("OnClick", function()
			for j = 1, 2 do
				G:ClearEdit(options[j])
				if i == j then
					options[j]:Show()
				else
					options[j]:Hide()
				end
			end

			for k = 1, #bars do
				bars[k]:Hide()
			end
		end)
	end

	local dungeons = {}
	for dungeonID = 1182, 1189 do
		AddNewDungeon(dungeons, dungeonID)
	end
	AddNewDungeon(dungeons, 1194)

	local raids = {
		[1] = EJ_GetInstanceInfo(1190),
		[2] = EJ_GetInstanceInfo(1193),
		[3] = EJ_GetInstanceInfo(1195),
	}

	options[1] = G:CreateDropdown(frame, DUNGEONS.."*", 120, -30, dungeons, U["Dungeons Intro"], 130, 30)
	options[1]:Hide()
	options[2] = G:CreateDropdown(frame, RAID.."*", 120, -30, raids, U["Raid Intro"], 130, 30)
	options[2]:Hide()

	options[3] = G:CreateEditbox(frame, "ID*", 10, -90, U["ID Intro"])
	options[4] = G:CreateEditbox(frame, U["Priority"], 120, -90, U["Priority Intro"])

	local function analyzePrio(priority)
		priority = priority or 2
		priority = min(priority, 6)
		priority = max(priority, 1)
		return priority
	end

	local function isAuraExisted(instName, spellID)
		local localPrio = R.RaidDebuffs[instName][spellID]
		local savedPrio = MaoRUIDB["RaidDebuffs"][instName] and MaoRUIDB["RaidDebuffs"][instName][spellID]
		if (localPrio and savedPrio and savedPrio == 0) or (not localPrio and not savedPrio) then
			return false
		end
		return true
	end

	local function addClick(options)
		local dungeonName, raidName, spellID, priority = options[1].Text:GetText(), options[2].Text:GetText(), tonumber(options[3]:GetText()), tonumber(options[4]:GetText())
		local instName = dungeonName or raidName
		if not instName or not spellID then UIErrorsFrame:AddMessage(I.InfoColor..U["Incomplete Input"]) return end
		if spellID and not GetSpellInfo(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		if isAuraExisted(instName, spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end

		priority = analyzePrio(priority)
		if not MaoRUIDB["RaidDebuffs"][instName] then MaoRUIDB["RaidDebuffs"][instName] = {} end
		MaoRUIDB["RaidDebuffs"][instName][spellID] = priority
		setupBars(instName)
		G:ClearEdit(options[3])
		G:ClearEdit(options[4])
	end

	local scroll = G:CreateScroll(frame, 240, 370)
	scroll.reset = M.CreateButton(frame, 70, 25, RESET)
	scroll.reset:SetPoint("TOPLEFT", 10, -120)
	StaticPopupDialogs["RESET_UI_RAIDDEBUFFS"] = {
		text = U["Reset your raiddebuffs list?"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			MaoRUIDB["RaidDebuffs"] = {}
			ReloadUI()
		end,
		whileDead = 1,
	}
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_RAIDDEBUFFS")
	end)
	scroll.add = M.CreateButton(frame, 70, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -10, -120)
	scroll.add:SetScript("OnClick", function()
		addClick(options)
	end)
	scroll.clear = M.CreateButton(frame, 70, 25, KEY_NUMLOCK_MAC)
	scroll.clear:SetPoint("RIGHT", scroll.add, "LEFT", -10, 0)
	scroll.clear:SetScript("OnClick", function()
		clearEdit(options)
	end)

	local function iconOnEnter(self)
		local spellID = self:GetParent().spellID
		if not spellID then return end
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:ClearLines()
		GameTooltip:SetSpellByID(spellID)
		GameTooltip:Show()
	end

	local function createBar(index, texture)
		local bar = CreateFrame("Frame", nil, scroll.child, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		bar.index = index

		local icon, close = G:CreateBarWidgets(bar, texture)
		icon:SetScript("OnEnter", iconOnEnter)
		icon:SetScript("OnLeave", M.HideTooltip)
		bar.icon = icon

		close:SetScript("OnClick", function()
			bar:Hide()
			if R.RaidDebuffs[bar.instName][bar.spellID] then
				if not MaoRUIDB["RaidDebuffs"][bar.instName] then MaoRUIDB["RaidDebuffs"][bar.instName] = {} end
				MaoRUIDB["RaidDebuffs"][bar.instName][bar.spellID] = 0
			else
				MaoRUIDB["RaidDebuffs"][bar.instName][bar.spellID] = nil
			end
			setupBars(bar.instName)
		end)

		local spellName = M.CreateFS(bar, 14, "", false, "LEFT", 30, 0)
		spellName:SetWidth(120)
		spellName:SetJustifyH("LEFT")
		bar.spellName = spellName

		local prioBox = M.CreateEditBox(bar, 30, 24)
		prioBox:SetPoint("RIGHT", close, "LEFT", -15, 0)
		prioBox:SetTextInsets(10, 0, 0, 0)
		prioBox:SetMaxLetters(1)
		prioBox:SetTextColor(0, 1, 0)
		prioBox.bg:SetBackdropColor(1, 1, 1, .2)
		prioBox:HookScript("OnEscapePressed", function(self)
			self:SetText(bar.priority)
		end)
		prioBox:HookScript("OnEnterPressed", function(self)
			local prio = analyzePrio(tonumber(self:GetText()))
			if not MaoRUIDB["RaidDebuffs"][bar.instName] then MaoRUIDB["RaidDebuffs"][bar.instName] = {} end
			MaoRUIDB["RaidDebuffs"][bar.instName][bar.spellID] = prio
			self:SetText(prio)
		end)
		M.AddTooltip(prioBox, "ANCHOR_TOPRIGHT", U["Prio Editbox"], "info", true)
		bar.prioBox = prioBox

		return bar
	end

	local function applyData(index, instName, spellID, priority)
		local name, _, texture = GetSpellInfo(spellID)
		if not bars[index] then
			bars[index] = createBar(index, texture)
		end
		bars[index].instName = instName
		bars[index].spellID = spellID
		bars[index].priority = priority
		bars[index].spellName:SetText(name)
		bars[index].prioBox:SetText(priority)
		bars[index].icon.Icon:SetTexture(texture)
		bars[index]:Show()
	end

	function setupBars(self)
		local instName = self.text or self
		local index = 0

		if R.RaidDebuffs[instName] then
			for spellID, priority in pairs(R.RaidDebuffs[instName]) do
				if not (MaoRUIDB["RaidDebuffs"][instName] and MaoRUIDB["RaidDebuffs"][instName][spellID]) then
					index = index + 1
					applyData(index, instName, spellID, priority)
				end
			end
		end

		if MaoRUIDB["RaidDebuffs"][instName] then
			for spellID, priority in pairs(MaoRUIDB["RaidDebuffs"][instName]) do
				if priority > 0 then
					index = index + 1
					applyData(index, instName, spellID, priority)
				end
			end
		end

		for i = 1, #bars do
			if i > index then
				bars[i]:Hide()
			end
		end

		for i = 1, index do
			bars[i]:SetPoint("TOPLEFT", 10, -10 - 35*(i-1))
		end
	end

	for i = 1, 2 do
		for j = 1, #options[i].options do
			options[i].options[j]:HookScript("OnClick", setupBars)
		end
	end

	local function autoSelectInstance()
		local instName, instType = GetInstanceInfo()
		if instType == "none" then return end
		for i = 1, 2 do
			local option = options[i]
			for j = 1, #option.options do
				local name = option.options[j].text
				if instName == name then
					iType.options[i]:Click()
					options[i].options[j]:Click()
				end
			end
		end
	end
	autoSelectInstance()
	panel:HookScript("OnShow", autoSelectInstance)
end

function G:SetupClickCast(parent)
	local guiName = "UIGUI_ClickCast"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["Add ClickSets"], true)

	local textIndex, barTable = {
		["target"] = TARGET,
		["focus"] = SET_FOCUS,
		["follow"] = FOLLOW,
	}, {}

	local function createBar(parent, data)
		local key, modKey, value = unpack(data)
		local clickSet = modKey..key
		local texture
		if tonumber(value) then
			texture = GetSpellTexture(value)
		else
			value = textIndex[value] or value
			texture = 136243
		end

		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		barTable[clickSet] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", value, "system")
		close:SetScript("OnClick", function()
			bar:Hide()
			MaoRUIDB["RaidClickSets"][I.MyClass][clickSet] = nil
			barTable[clickSet] = nil
			sortBars(barTable)
		end)

		local key1 = M.CreateFS(bar, 14, key, false, "LEFT", 35, 0)
		key1:SetTextColor(.6, .8, 1)
		modKey = modKey ~= "" and "+ "..modKey or ""
		local key2 = M.CreateFS(bar, 14, modKey, false, "LEFT", 130, 0)
		key2:SetTextColor(0, 1, 0)

		sortBars(barTable)
	end

	local frame = panel.bg
	local keyList, options = {
		KEY_BUTTON1,
		KEY_BUTTON2,
		KEY_BUTTON3,
		KEY_BUTTON4,
		KEY_BUTTON5,
		U["WheelUp"],
		U["WheelDown"],
	}, {}

	options[1] = G:CreateEditbox(frame, U["Action*"], 10, -30, U["Action Intro"], 260, 30)
	options[2] = G:CreateDropdown(frame, U["Key*"], 10, -90, keyList, U["Key Intro"], 120, 30)
	options[3] = G:CreateDropdown(frame, U["Modified Key"], 170, -90, {NONE, "ALT", "CTRL", "SHIFT"}, U["ModKey Intro"], 85, 30)

	local scroll = G:CreateScroll(frame, 240, 350)
	scroll.reset = M.CreateButton(frame, 70, 25, RESET)
	scroll.reset:SetPoint("TOPLEFT", 10, -140)
	StaticPopupDialogs["RESET_UI_CLICKSETS"] = {
		text = U["Reset your click sets?"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			wipe(MaoRUIDB["RaidClickSets"][I.MyClass])
			ReloadUI()
		end,
		whileDead = 1,
	}
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_CLICKSETS")
	end)

	local function addClick(scroll, options)
		local value, key, modKey = options[1]:GetText(), options[2].Text:GetText(), options[3].Text:GetText()
		if not value or not key then UIErrorsFrame:AddMessage(I.InfoColor..U["Incomplete Input"]) return end
		if tonumber(value) and not GetSpellInfo(value) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		if (not tonumber(value)) and value ~= "target" and value ~= "focus" and value ~= "follow" and not strmatch(value, "/") then UIErrorsFrame:AddMessage(I.InfoColor..U["Invalid Input"]) return end
		if not modKey or modKey == NONE then modKey = "" end
		local clickSet = modKey..key
		if MaoRUIDB["RaidClickSets"][I.MyClass][clickSet] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ClickSet"]) return end

		MaoRUIDB["RaidClickSets"][I.MyClass][clickSet] = {key, modKey, value}
		createBar(scroll.child, MaoRUIDB["RaidClickSets"][I.MyClass][clickSet])
		clearEdit(options)
	end

	scroll.add = M.CreateButton(frame, 70, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -10, -140)
	scroll.add:SetScript("OnClick", function()
		addClick(scroll, options)
	end)

	scroll.clear = M.CreateButton(frame, 70, 25, KEY_NUMLOCK_MAC)
	scroll.clear:SetPoint("RIGHT", scroll.add, "LEFT", -10, 0)
	scroll.clear:SetScript("OnClick", function()
		clearEdit(options)
	end)

	for _, v in pairs(MaoRUIDB["RaidClickSets"][I.MyClass]) do
		createBar(scroll.child, v)
	end
end

local function updatePartyWatcherSpells()
	M:GetModule("UnitFrames"):UpdatePartyWatcherSpells()
end

function G:SetupPartyWatcher(parent)
	local guiName = "UIGUI_PartyWatcher"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["AddPartyWatcher"].."*", true)
	panel:SetScript("OnHide", updatePartyWatcherSpells)

	local barTable = {}
	local ARCANE_TORRENT = GetSpellInfo(25046)

	local function createBar(parent, spellID, duration)
		local spellName = GetSpellInfo(spellID)
		if spellName == ARCANE_TORRENT then return end
		local texture = GetSpellTexture(spellID)

		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		barTable[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID, "system")
		close:SetScript("OnClick", function()
			bar:Hide()
			if R.PartySpells[spellID] then
				MaoRUIDB["PartySpells"][spellID] = 0
			else
				MaoRUIDB["PartySpells"][spellID] = nil
			end
			barTable[spellID] = nil
			sortBars(barTable)
		end)

		local name = M.CreateFS(bar, 14, spellName, false, "LEFT", 30, 0)
		name:SetWidth(120)
		name:SetJustifyH("LEFT")

		local timer = M.CreateFS(bar, 14, duration, false, "RIGHT", -30, 0)
		timer:SetWidth(60)
		timer:SetJustifyH("RIGHT")
		timer:SetTextColor(0, 1, 0)

		sortBars(barTable)
	end

	local frame = panel.bg
	local options = {}

	options[1] = G:CreateEditbox(frame, "ID*", 10, -30, U["ID Intro"])
	options[2] = G:CreateEditbox(frame, U["Cooldown*"], 120, -30, U["Cooldown Intro"])

	local scroll = G:CreateScroll(frame, 240, 410)
	scroll.reset = M.CreateButton(frame, 60, 25, RESET)
	scroll.reset:SetPoint("TOPLEFT", 10, -80)
	scroll.reset.text:SetTextColor(1, 0, 0)
	StaticPopupDialogs["RESET_UI_PARTYWATCHER"] = {
		text = U["Reset your raiddebuffs list?"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			wipe(MaoRUIDB["PartySpells"])
			ReloadUI()
		end,
		whileDead = 1,
	}
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_PARTYWATCHER")
	end)

	local function addClick(scroll, options)
		local spellID, duration = tonumber(options[1]:GetText()), tonumber(options[2]:GetText())
		if not spellID or not duration then UIErrorsFrame:AddMessage(I.InfoColor..U["Incomplete Input"]) return end
		if not GetSpellInfo(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		local modDuration = MaoRUIDB["PartySpells"][spellID]
		if modDuration and modDuration ~= 0 or R.PartySpells[spellID] and not modDuration then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end

		MaoRUIDB["PartySpells"][spellID] = duration
		createBar(scroll.child, spellID, duration)
		clearEdit(options)
	end

	scroll.add = M.CreateButton(frame, 60, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -10, -80)
	scroll.add:SetScript("OnClick", function()
		addClick(scroll, options)
	end)

	scroll.clear = M.CreateButton(frame, 60, 25, KEY_NUMLOCK_MAC)
	scroll.clear:SetPoint("RIGHT", scroll.add, "LEFT", -6, 0)
	scroll.clear:SetScript("OnClick", function()
		clearEdit(options)
	end)

	local menuList = {}
	local function AddSpellFromPreset(_, spellID, duration)
		options[1]:SetText(spellID)
		options[2]:SetText(duration)
		DropDownList1:Hide()
	end

	local index = 1
	for class, value in pairs(R.PartySpellsDB) do
		local color = M.HexRGB(M.ClassColor(class))
		local localClassName = LOCALIZED_CLASS_NAMES_MALE[class]
		menuList[index] = {text = color..localClassName, notCheckable = true, hasArrow = true, menuList = {}}

		for spellID, duration in pairs(value) do
			local spellName, _, texture = GetSpellInfo(spellID)
			if spellName then
				tinsert(menuList[index].menuList, {
					text = spellName,
					icon = texture,
					tCoordLeft = .08,
					tCoordRight = .92,
					tCoordTop = .08,
					tCoordBottom = .92,
					arg1 = spellID,
					arg2 = duration,
					func = AddSpellFromPreset,
					notCheckable = true,
				})
			end
		end
		index = index + 1
	end
	scroll.preset = M.CreateButton(frame, 60, 25, U["Preset"])
	scroll.preset:SetPoint("RIGHT", scroll.clear, "LEFT", -6, 0)
	scroll.preset.text:SetTextColor(1, .8, 0)
	scroll.preset:SetScript("OnClick", function(self)
		EasyMenu(menuList, M.EasyMenu, self, -100, 100, "MENU", 1)
	end)

	local UF = M:GetModule("UnitFrames")
	for spellID, duration in pairs(UF.PartyWatcherSpells) do
		createBar(scroll.child, spellID, duration)
	end
end

function G:SetupNameplateFilter(parent)
	local guiName = "UIGUI_NameplateFilter"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName)

	local frameData = {
		[1] = {text = U["WhiteList"].."*", offset = -5, barList = {}},
		[2] = {text = U["BlackList"].."*", offset = -295, barList = {}},
	}

	local function createBar(parent, index, spellID)
		local name, _, texture = GetSpellInfo(spellID)
		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		frameData[index].barList[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID)
		close:SetScript("OnClick", function()
			bar:Hide()
			MaoRUIDB["NameplateFilter"][index][spellID] = nil
			frameData[index].barList[spellID] = nil
			sortBars(frameData[index].barList)
		end)

		local spellName = M.CreateFS(bar, 14, name, false, "LEFT", 30, 0)
		spellName:SetWidth(180)
		spellName:SetJustifyH("LEFT")
		if index == 2 then spellName:SetTextColor(1, 0, 0) end

		sortBars(frameData[index].barList)
	end

	local function addClick(parent, index)
		local spellID = tonumber(parent.box:GetText())
		if not spellID or not GetSpellInfo(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		if MaoRUIDB["NameplateFilter"][index][spellID] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end

		MaoRUIDB["NameplateFilter"][index][spellID] = true
		createBar(parent.child, index, spellID)
		parent.box:SetText("")
	end

	for index, value in ipairs(frameData) do
		M.CreateFS(panel, 14, value.text, "system", "TOPLEFT", 20, value.offset)
		local frame = CreateFrame("Frame", nil, panel, "BackdropTemplate")
		frame:SetSize(280, 250)
		frame:SetPoint("TOPLEFT", 10, value.offset - 25)
		M.CreateBD(frame, .25)

		local scroll = G:CreateScroll(frame, 240, 200)
		scroll.box = M.CreateEditBox(frame, 185, 25)
		scroll.box:SetPoint("TOPLEFT", 10, -10)
		M.AddTooltip(scroll.box, "ANCHOR_TOPRIGHT", U["ID Intro"], "info", true)
		scroll.add = M.CreateButton(frame, 70, 25, ADD)
		scroll.add:SetPoint("TOPRIGHT", -8, -10)
		scroll.add:SetScript("OnClick", function()
			addClick(scroll, index)
		end)

		for spellID in pairs(MaoRUIDB["NameplateFilter"][index]) do
			createBar(scroll.child, index, spellID)
		end
	end
end

local function updateCornerSpells()
	M:GetModule("UnitFrames"):UpdateCornerSpells()
end

function G:SetupBuffIndicator(parent)
	local guiName = "UIGUI_BuffIndicator"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName)
	panel:SetScript("OnHide", updateCornerSpells)

	local frameData = {
		[1] = {text = U["RaidBuffWatch"].."*", offset = -5, width = 160, barList = {}},
		[2] = {text = U["BuffIndicator"].."*", offset = -295, width = 50, barList = {}},
	}
	local decodeAnchor = {
		["TL"] = "TOPLEFT",
		["T"] = "TOP",
		["TR"] = "TOPRIGHT",
		["U"] = "LEFT",
		["R"] = "RIGHT",
		["BL"] = "BOTTOMLEFT",
		["M"] = "BOTTOM",
		["BR"] = "BOTTOMRIGHT",
	}
	local anchors = {"TL", "T", "TR", "U", "R", "BL", "M", "BR"}

	local function createBar(parent, index, spellID, anchor, r, g, b, showAll)
		local name, _, texture = GetSpellInfo(spellID)
		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		frameData[index].barList[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID)
		close:SetScript("OnClick", function()
			bar:Hide()
			if index == 1 then
				MaoRUIDB["RaidAuraWatch"][spellID] = nil
			else
				local value = R.CornerBuffs[I.MyClass][spellID]
				if value then
					MaoRUIDB["CornerSpells"][I.MyClass][spellID] = {}
				else
					MaoRUIDB["CornerSpells"][I.MyClass][spellID] = nil
				end
			end
			frameData[index].barList[spellID] = nil
			sortBars(frameData[index].barList)
		end)

		name = U[anchor] or name
		local text = M.CreateFS(bar, 14, name, false, "LEFT", 30, 0)
		text:SetWidth(180)
		text:SetJustifyH("LEFT")
		if anchor then text:SetTextColor(r, g, b) end
		if showAll then M.CreateFS(bar, 14, "ALL", false, "RIGHT", -30, 0) end

		sortBars(frameData[index].barList)
	end

	local function addClick(parent, index)
		local spellID = tonumber(parent.box:GetText())
		if not spellID or not GetSpellInfo(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		local anchor, r, g, b, showAll
		if index == 1 then
			if MaoRUIDB["RaidAuraWatch"][spellID] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end
			MaoRUIDB["RaidAuraWatch"][spellID] = true
		else
			anchor, r, g, b = parent.dd.Text:GetText(), parent.swatch.tex:GetColor()
			showAll = parent.showAll:GetChecked() or nil
			local modValue = MaoRUIDB["CornerSpells"][I.MyClass][spellID]
			if (modValue and next(modValue)) or (R.CornerBuffs[I.MyClass][spellID] and not modValue) then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end
			anchor = decodeAnchor[anchor]
			MaoRUIDB["CornerSpells"][I.MyClass][spellID] = {anchor, {r, g, b}, showAll}
		end
		createBar(parent.child, index, spellID, anchor, r, g, b, showAll)
		parent.box:SetText("")
	end

	local currentIndex
	StaticPopupDialogs["RESET_UI_RaidAuraWatch"] = {
		text = U["Reset your raiddebuffs list?"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			if currentIndex == 1 then
				MaoRUIDB["RaidAuraWatch"] = nil
			else
				wipe(MaoRUIDB["CornerSpells"][I.MyClass])
			end
			ReloadUI()
		end,
		whileDead = 1,
	}

	local function optionOnEnter(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:ClearLines()
		GameTooltip:AddLine(U[decodeAnchor[self.text]], 1, 1, 1)
		GameTooltip:Show()
	end

	local UF = M:GetModule("UnitFrames")

	for index, value in ipairs(frameData) do
		M.CreateFS(panel, 14, value.text, "system", "TOPLEFT", 20, value.offset)

		local frame = CreateFrame("Frame", nil, panel, "BackdropTemplate")
		frame:SetSize(280, 250)
		frame:SetPoint("TOPLEFT", 10, value.offset - 25)
		M.CreateBD(frame, .25)

		local scroll = G:CreateScroll(frame, 240, 200)
		scroll.box = M.CreateEditBox(frame, value.width, 25)
		scroll.box:SetPoint("TOPLEFT", 10, -10)
		scroll.box:SetMaxLetters(6)
		M.AddTooltip(scroll.box, "ANCHOR_TOPRIGHT", U["ID Intro"], "info", true)

		scroll.add = M.CreateButton(frame, 45, 25, ADD)
		scroll.add:SetPoint("TOPRIGHT", -8, -10)
		scroll.add:SetScript("OnClick", function()
			addClick(scroll, index)
		end)

		scroll.reset = M.CreateButton(frame, 45, 25, RESET)
		scroll.reset:SetPoint("RIGHT", scroll.add, "LEFT", -5, 0)
		scroll.reset:SetScript("OnClick", function()
			currentIndex = index
			StaticPopup_Show("RESET_UI_RaidAuraWatch")
		end)
		if index == 1 then
			for spellID in pairs(MaoRUIDB["RaidAuraWatch"]) do
				createBar(scroll.child, index, spellID)
			end
		else
			scroll.dd = M.CreateDropDown(frame, 60, 25, anchors)
			scroll.dd:SetPoint("TOPLEFT", 10, -10)
			scroll.dd.options[1]:Click()

			for i = 1, 8 do
				scroll.dd.options[i]:HookScript("OnEnter", optionOnEnter)
				scroll.dd.options[i]:HookScript("OnLeave", M.HideTooltip)
			end
			scroll.box:SetPoint("TOPLEFT", scroll.dd, "TOPRIGHT", 5, 0)

			local swatch = M.CreateColorSwatch(frame, "")
			swatch:SetPoint("LEFT", scroll.box, "RIGHT", 5, 0)
			scroll.swatch = swatch

			local showAll = M.CreateCheckBox(frame)
			showAll:SetPoint("LEFT", swatch, "RIGHT", 2, 0)
			showAll:SetHitRectInsets(0, 0, 0, 0)
			--showAll.bg:SetBackdropBorderColor(1, .8, 0, .5)
			M.AddTooltip(showAll, "ANCHOR_TOPRIGHT", U["ShowAllTip"], "info", true)
			scroll.showAll = showAll

			for spellID, value in pairs(UF.CornerSpells) do
				local r, g, b = unpack(value[2])
				createBar(scroll.child, index, spellID, value[1], r, g, b, value[3])
			end
		end
	end
end

local function createOptionTitle(parent, title, offset)
	M.CreateFS(parent, 14, title, "system", "TOP", 0, offset)
	local line = M.SetGradient(parent, "H", 1, 1, 1, .25, .25, 200, R.mult)
	line:SetPoint("TOPLEFT", 30, offset-20)
end

local function toggleOptionCheck(self)
	local value = R.db[self.__key][self.__value]
	value = not value
	self:SetChecked(value)
	R.db[self.__key][self.__value] = value
	if self.__callback then self:__callback() end
end

local function createOptionCheck(parent, offset, text, key, value, callback, tooltip)
	local box = M.CreateCheckBox(parent)
	box:SetPoint("TOPLEFT", 10, offset)
	box:SetChecked(R.db[key][value])
	box.__key = key
	box.__value = value
	box.__callback = callback
	M.CreateFS(box, 14, text, nil, "LEFT", 30, 0)
	box:SetScript("OnClick", toggleOptionCheck)
	if tooltip then
		M.AddTooltip(box, "ANCHOR_RIGHT", tooltip, "info", true)
	end

	return box
end

local function sliderValueChanged(self, v)
	local current = tonumber(format("%.0f", v))
	self.value:SetText(current)
	R.db[self.__key][self.__value] = current
	if self.__update then self.__update() end
end

local function createOptionSlider(parent, title, minV, maxV, defaultV, yOffset, value, func, key)
	local slider = M.CreateSlider(parent, title, minV, maxV, 1, 30, yOffset)
	if not key then key = "UFs" end
	slider:SetValue(R.db[key][value])
	slider.value:SetText(R.db[key][value])
	slider.__key = key
	slider.__value = value
	slider.__update = func
	slider.__default = defaultV
	slider:SetScript("OnValueChanged", sliderValueChanged)
end

local function updateDropdownHighlight(self)
	local dd = self.__owner
	for i = 1, #dd.__options do
		local option = dd.options[i]
		if i == R.db[dd.__key][dd.__value] then
			option:SetBackdropColor(1, .8, 0, .3)
			option.selected = true
		else
			option:SetBackdropColor(0, 0, 0, .3)
			option.selected = false
		end
	end
end

local function updateDropdownState(self)
	local dd = self.__owner
	R.db[dd.__key][dd.__value] = self.index
	if dd.__func then dd.__func() end
end

local function createOptionDropdown(parent, title, yOffset, options, tooltip, key, value, default, func)
	local dd = G:CreateDropdown(parent, title, 40, yOffset, options, nil, 180, 28)
	dd.__key = key
	dd.__value = value
	dd.__default = default
	dd.__options = options
	dd.__func = func
	dd.Text:SetText(options[R.db[key][value]])

	if tooltip then
		M.AddTooltip(dd, "ANCHOR_TOP", tooltip, "info", true)
	end

	dd.button.__owner = dd
	dd.button:HookScript("OnClick", updateDropdownHighlight)

	for i = 1, #options do
		dd.options[i]:HookScript("OnClick", updateDropdownState)
	end
end

local function SetUnitFrameSize(self, unit)
	local width = R.db["UFs"][unit.."Width"]
	local healthHeight = R.db["UFs"][unit.."Height"]
	local powerHeight = R.db["UFs"][unit.."PowerHeight"]
	local height = healthHeight + powerHeight + R.mult
	self:SetSize(width, height)
	self.Health:SetHeight(healthHeight)
	self.Power:SetHeight(powerHeight)
	if self.powerText then
		self.powerText:SetPoint("RIGHT", -3, R.db["UFs"][unit.."PowerOffset"])
	end
end

function G:SetupUnitFrame(parent)
	local guiName = "UIGUI_UnitFrameSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["UnitFrame Size"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local sliderRange = {
		["Player"] = {120, 400},
		["Focus"] = {120, 400},
		["Pet"] = {100, 300},
		["Boss"] = {100, 400},
	}

	local defaultValue = { -- healthWidth, healthHeight, powerHeight, healthTag, powerTag, powerOffset
		["Player"] = {245, 24, 4, 2, 4, 2},
		["Focus"] = {200, 22, 3, 2, 4, 2},
		["Pet"] = {100, 18, 2, 5},
		["Boss"] = {120, 21, 3, 5, 5},
	}

	local function createOptionGroup(parent, title, offset, value, func)
		createOptionTitle(parent, title, offset)
		createOptionDropdown(parent, U["HealthValueType"], offset-50, G.HealthValues, U["100PercentTip"], "UFs", value.."HPTag", defaultValue[value][4], func)
		local mult = 0
		if value ~= "Pet" then
			mult = 60
			createOptionDropdown(parent, U["PowerValueType"], offset-50-mult, G.HealthValues, U["100PercentTip"], "UFs", value.."MPTag", defaultValue[value][4], func)
		end
		createOptionSlider(parent, U["Width"], sliderRange[value][1], sliderRange[value][2], defaultValue[value][1], offset-110-mult, value.."Width", func)
		createOptionSlider(parent, U["Height"], 15, 50, defaultValue[value][2], offset-180-mult, value.."Height", func)
		createOptionSlider(parent, U["Power Height"], 2, 30, defaultValue[value][3], offset-250-mult, value.."PowerHeight", func)
		if defaultValue[value][6] then
			createOptionSlider(parent, U["Power Offset"], -20, 20, defaultValue[value][4], offset-320-mult, value.."PowerOffset", func)
		end
	end

	local UF = M:GetModule("UnitFrames")
	local mainFrames = {_G.oUF_Player, _G.oUF_Target}
	local function updatePlayerSize()
		for _, frame in pairs(mainFrames) do
			SetUnitFrameSize(frame, "Player")
			UF.UpdateFrameHealthTag(frame)
			UF.UpdateFramePowerTag(frame)
		end
		UF:UpdateUFAuras()
	end
	createOptionGroup(scroll.child, U["Player&Target"], -10, "Player", updatePlayerSize)

	local function updateFocusSize()
		local frame = _G.oUF_Focus
		if frame then
			SetUnitFrameSize(frame, "Focus")
			UF.UpdateFrameHealthTag(frame)
			UF.UpdateFramePowerTag(frame)
		end
	end
	createOptionGroup(scroll.child, U["FocusUF"], -480, "Focus", updateFocusSize)

	local subFrames = {_G.oUF_Pet, _G.oUF_ToT, _G.oUF_FocusTarget}
	local function updatePetSize()
		for _, frame in pairs(subFrames) do
			SetUnitFrameSize(frame, "Pet")
			UF.UpdateFrameHealthTag(frame)
		end
	end
	createOptionGroup(scroll.child, U["Pet&*Target"], -950, "Pet", updatePetSize)

	local function updateBossSize()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.mystyle == "boss" or frame.mystyle == "arena" then
				SetUnitFrameSize(frame, "Boss")
				UF.UpdateFrameHealthTag(frame)
				UF.UpdateFramePowerTag(frame)
			end
		end
	end
	createOptionGroup(scroll.child, U["Boss&Arena"], -1290, "Boss", updateBossSize)
end

function G:SetupRaidFrame(parent)
	local guiName = "UIGUI_RaidFrameSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["RaidFrame"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)
	local UF = M:GetModule("UnitFrames")

	local defaultValue = {80, 32, 2, 6, 1}
	local options = {}
	for i = 1, 8 do
		options[i] = UF.RaidDirections[i].name
	end

	local function updateRaidDirection()
		if UF.CreateAndUpdateRaidHeader then
			UF:CreateAndUpdateRaidHeader(true)
			UF:UpdateRaidTeamIndex()
		end
	end

	local function resizeRaidFrame()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.mystyle == "raid" and not frame.raidType then
				SetUnitFrameSize(frame, "Raid")
				UF.UpdateRaidNameAnchor(frame, frame.nameText)
			end
		end
		if UF.CreateAndUpdateRaidHeader then
			UF:CreateAndUpdateRaidHeader()
		end
	end

	local function updateNumGroups()
		if UF.CreateAndUpdateRaidHeader then
			UF:CreateAndUpdateRaidHeader()
			UF:UpdateRaidTeamIndex()
			UF:UpdateAllHeaders()
		end
	end

	createOptionDropdown(scroll.child, U["GrowthDirection"], -30, options, U["RaidDirectionTip"], "UFs", "RaidDirec", 1, updateRaidDirection)
	createOptionSlider(scroll.child, U["Width"], 60, 200, defaultValue[1], -100, "RaidWidth", resizeRaidFrame)
	createOptionSlider(scroll.child, U["Height"], 25, 60, defaultValue[2], -180, "RaidHeight", resizeRaidFrame)
	createOptionSlider(scroll.child, U["Power Height"], 2, 30, defaultValue[3], -260, "RaidPowerHeight", resizeRaidFrame)
	createOptionSlider(scroll.child, U["Num Groups"], 2, 8, defaultValue[4], -340, "NumGroups", updateNumGroups)
	createOptionSlider(scroll.child, U["RaidRows"], 1, 8, defaultValue[5], -420, "RaidRows", updateNumGroups)
end

function G:SetupSimpleRaidFrame(parent)
	local guiName = "UIGUI_SimpleRaidFrameSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["SimpleRaidFrame"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)
	local UF = M:GetModule("UnitFrames")

	local options = {}
	for i = 1, 4 do
		options[i] = UF.RaidDirections[i].name
	end
	local function updateSimpleModeGroupBy()
		if UF.UpdateSimpleModeHeader then
			UF:UpdateSimpleModeHeader()
		end
	end
	createOptionDropdown(scroll.child, U["GrowthDirection"], -30, options, U["SMRDirectionTip"], "UFs", "SMRDirec", 1) -- needs review, cannot live toggle atm due to blizz error
	createOptionDropdown(scroll.child, U["SimpleMode GroupBy"], -90, {GROUP, CLASS, ROLE}, nil, "UFs", "SMRGroupBy", 1, updateSimpleModeGroupBy)
	createOptionSlider(scroll.child, U["UnitsPerColumn"], 5, 40, 20, -160, "SMRPerCol", updateSimpleModeGroupBy)
	createOptionSlider(scroll.child, U["Num Groups"], 1, 8, 6, -240, "SMRGroups", updateSimpleModeGroupBy)

	local function resizeSimpleRaidFrame()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.raidType == "simple" then
				local scale = R.db["UFs"]["SMRScale"]/10
				local frameWidth = 100*scale
				local frameHeight = 20*scale
				local powerHeight = 2*scale
				local healthHeight = frameHeight - powerHeight
				frame:SetSize(frameWidth, frameHeight)
				frame.Health:SetHeight(healthHeight)
				frame.Power:SetHeight(powerHeight)
				frame.Auras.size = 18*scale/10
				UF:UpdateAuraContainer(frame, frame.Auras, 1)
				UF.UpdateRaidNameAnchor(frame, frame.nameText)
			end
		end

		updateSimpleModeGroupBy()
	end
	createOptionSlider(scroll.child, U["SimpleMode Scale"], 8, 15, 10, -320, "SMRScale", resizeSimpleRaidFrame)
end

function G:SetupPartyFrame(parent)
	local guiName = "UIGUI_PartyFrameSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["PartyFrame"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)
	local UF = M:GetModule("UnitFrames")

	local function resizePartyFrame()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.raidType == "party" then
				SetUnitFrameSize(frame, "Party")
				UF.UpdateRaidNameAnchor(frame, frame.nameText)
			end
		end
		if UF.CreateAndUpdatePartyHeader then
			UF:CreateAndUpdatePartyHeader()
		end
		UF:UpdatePartyElements()
	end

	local defaultValue = {100, 32, 2}
	local options = {}
	for i = 1, 4 do
		options[i] = UF.PartyDirections[i].name
	end
	createOptionCheck(scroll.child, -10, U["UFs PartyAltPower"], "UFs", "PartyAltPower", resizePartyFrame, U["PartyAltPowerTip"])
	createOptionCheck(scroll.child, -40, U["DescRole"], "UFs", "DescRole", resizePartyFrame, U["DescRoleTip"])
	createOptionDropdown(scroll.child, U["GrowthDirection"], -100, options, nil, "UFs", "PartyDirec", 1, resizePartyFrame)
	createOptionSlider(scroll.child, U["Width"], 80, 200, defaultValue[1], -180, "PartyWidth", resizePartyFrame)
	createOptionSlider(scroll.child, U["Height"], 25, 60, defaultValue[2], -260, "PartyHeight", resizePartyFrame)
	createOptionSlider(scroll.child, U["Power Height"], 2, 30, defaultValue[3], -340, "PartyPowerHeight", resizePartyFrame)
end

function G:SetupPartyPetFrame(parent)
	local guiName = "UIGUI_PartyPetFrameSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["PartyPetFrame"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local UF = M:GetModule("UnitFrames")

	local function updatePartyPetHeader()
		if UF.UpdatePartyPetHeader then
			UF:UpdatePartyPetHeader()
		end
	end

	local function resizePartyPetFrame()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.raidType == "pet" then
				SetUnitFrameSize(frame, "PartyPet")
				UF.UpdateRaidNameAnchor(frame, frame.nameText)
			end
		end

		updatePartyPetHeader()
	end

	local options = {}
	for i = 1, 8 do
		options[i] = UF.RaidDirections[i].name
	end

	createOptionDropdown(scroll.child, U["GrowthDirection"], -30, options, nil, "UFs", "PetDirec", 1, updatePartyPetHeader)
	createOptionDropdown(scroll.child, U["Visibility"], -90, {U["ShowInParty"], U["ShowInRaid"], U["ShowInGroup"]}, nil, "UFs", "PartyPetVsby", 1, UF.UpdateAllHeaders)
	createOptionSlider(scroll.child, U["Width"], 60, 200, 100, -150, "PartyPetWidth", resizePartyPetFrame)
	createOptionSlider(scroll.child, U["Height"], 20, 60, 22, -220, "PartyPetHeight", resizePartyPetFrame)
	createOptionSlider(scroll.child, U["Power Height"], 2, 30, 2, -290, "PartyPetPowerHeight", resizePartyPetFrame)
	createOptionSlider(scroll.child, U["UnitsPerColumn"], 5, 40, 5, -360, "PartyPetPerCol", updatePartyPetHeader)
	createOptionSlider(scroll.child, U["MaxColumns"], 1, 5, 1, -430, "PartyPetMaxCol", updatePartyPetHeader)
end

local function createOptionSwatch(parent, name, key, value, x, y)
	local swatch = M.CreateColorSwatch(parent, name, R.db[key][value])
	swatch:SetPoint("TOPLEFT", x, y)
	swatch.__default = G.DefaultSettings[key][value]
end

function G:SetupSwingBars(parent)
	local guiName = "UIGUI_SwingSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["UFs SwingBar"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local UF = M:GetModule("UnitFrames")
	local parent, offset = scroll.child, -10
	local frame = _G.oUF_Player

	local function configureSwingBars()
		if not frame then return end

		local width, height = R.db["UFs"]["SwingWidth"], R.db["UFs"]["SwingHeight"]
		frame.Swing:SetSize(width, height)
		frame.Swing.Offhand:SetHeight(height)
		frame.Swing.mover:SetSize(width, height)
		frame.Swing.mover:Show()

		frame.Swing.Text:SetShown(R.db["UFs"]["SwingTimer"])
		frame.Swing.TextMH:SetShown(R.db["UFs"]["SwingTimer"])
		frame.Swing.TextOH:SetShown(R.db["UFs"]["SwingTimer"])
	end

	createOptionCheck(parent, offset, U["UFs SwingTimer"], "UFs", "SwingTimer", configureSwingBars, U["SwingTimer Tip"])
	createOptionSlider(parent, U["Width"], 50, 1000, 275, offset-70, "SwingWidth", configureSwingBars)
	createOptionSlider(parent, U["Height"], 1, 50, 3, offset-140, "SwingHeight", configureSwingBars)

	panel:HookScript("OnHide", function()
		local mover = frame and frame.Swing and frame.Swing.mover
		if mover then mover:Hide() end
	end)
end

function G:SetupBagFilter(parent)
	local guiName = "UIGUI_BagFilterSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["BagFilterSetup"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local filterOptions = {
		[1] = "FilterJunk",
		[2] = "FilterConsumable",
		[3] = "FilterAzerite",
		[4] = "FilterEquipment",
		[5] = "FilterEquipSet",
		[6] = "FilterLegendary",
		[7] = "FilterCollection",
		[8] = "FilterFavourite",
		[9] = "FilterGoods",
		[10] = "FilterQuest",
		[11] = "FilterAnima",
		[12] = "FilterRelic",
	}

	local BAG = M:GetModule("Bags")
	local function updateAllBags()
		BAG:UpdateAllBags()
	end

	local offset = 10
	for _, value in ipairs(filterOptions) do
		createOptionCheck(scroll, -offset, U[value], "Bags", value, updateAllBags)
		offset = offset + 35
	end
end

local function refreshMajorSpells()
	M:GetModule("UnitFrames"):RefreshMajorSpells()
end

function G:PlateCastbarGlow(parent)
	local guiName = "UIGUI_PlateCastbarGlow"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["PlateCastbarGlow"].."*", true)
	panel:SetScript("OnHide", refreshMajorSpells)

	local barTable = {}

	local function createBar(parent, spellID)
		local spellName = GetSpellInfo(spellID)
		local texture = GetSpellTexture(spellID)

		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		barTable[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID, "system")
		close:SetScript("OnClick", function()
			bar:Hide()
			barTable[spellID] = nil
			if R.MajorSpells[spellID] then
				MaoRUIDB["MajorSpells"][spellID] = false
			else
				MaoRUIDB["MajorSpells"][spellID] = nil
			end
			sortBars(barTable)
		end)

		local name = M.CreateFS(bar, 14, spellName, false, "LEFT", 30, 0)
		name:SetWidth(120)
		name:SetJustifyH("LEFT")

		sortBars(barTable)
	end

	local frame = panel.bg
	local scroll = G:CreateScroll(frame, 240, 450)
	scroll.box = G:CreateEditbox(frame, "ID*", 10, -30, U["ID Intro"], 100, 30)

	local function addClick(button)
		local parent = button.__owner
		local spellID = tonumber(parent.box:GetText())
		if not spellID or not GetSpellInfo(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		local modValue = MaoRUIDB["MajorSpells"][spellID]
		if modValue or modValue == nil and R.MajorSpells[spellID] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end
		MaoRUIDB["MajorSpells"][spellID] = true
		createBar(parent.child, spellID)
		parent.box:SetText("")
	end
	scroll.add = M.CreateButton(frame, 70, 25, ADD)
	scroll.add:SetPoint("LEFT", scroll.box, "RIGHT", 10, 0)
	scroll.add.__owner = scroll
	scroll.add:SetScript("OnClick", addClick)

	scroll.reset = M.CreateButton(frame, 70, 25, RESET)
	scroll.reset:SetPoint("LEFT", scroll.add, "RIGHT", 10, 0)
	StaticPopupDialogs["RESET_UI_MAJORSPELLS"] = {
		text = U["Reset your raiddebuffs list?"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			MaoRUIDB["MajorSpells"] = {}
			ReloadUI()
		end,
		whileDead = 1,
	}
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_MAJORSPELLS")
	end)

	local UF = M:GetModule("UnitFrames")
	for spellID, value in pairs(UF.MajorSpells) do
		if value then
			createBar(scroll.child, spellID)
		end
	end
end

function G:SetupNameplateSize(parent)
	local guiName = "UIGUI_PlateSizeSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["NameplateSize"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local optionValues = {
		["enemy"] = {"PlateWidth", "PlateHeight", "NameTextSize", "HealthTextSize", "HealthTextOffset", "PlateCBHeight", "CBTextSize", "PlateCBOffset"},
		["friend"] = {"FriendPlateWidth", "FriendPlateHeight", "FriendNameSize", "FriendHealthSize", "FriendHealthOffset", "FriendPlateCBHeight", "FriendCBTextSize", "FriendPlateCBOffset"},
	}
	local function createOptionGroup(parent, title, offset, value, func)
		createOptionTitle(parent, title, offset)
		createOptionSlider(parent, U["Width"], 50, 500, 190, offset-60, optionValues[value][1], func, "Nameplate")
		createOptionSlider(parent, U["Height"], 5, 50, 8, offset-130, optionValues[value][2], func, "Nameplate")
		createOptionSlider(parent, U["NameTextSize"], 10, 50, 14, offset-200, optionValues[value][3], func, "Nameplate")
		createOptionSlider(parent, U["HealthTextSize"], 10, 50, 16, offset-270, optionValues[value][4], func, "Nameplate")
		createOptionSlider(parent, U["Health Offset"], -50, 50, 5, offset-340, optionValues[value][5], func, "Nameplate")
		createOptionSlider(parent, U["Castbar Height"], 5, 50, 8, offset-410, optionValues[value][6], func, "Nameplate")
		createOptionSlider(parent, U["CastbarTextSize"], 10, 50, 14, offset-480, optionValues[value][7], func, "Nameplate")
		createOptionSlider(parent, U["CastbarTextOffset"], -50, 50, -1, offset-550, optionValues[value][8], func, "Nameplate")
	end

	local UF = M:GetModule("UnitFrames")
	createOptionGroup(scroll.child, U["HostileNameplate"], -10, "enemy", UF.RefreshAllPlates)
	createOptionGroup(scroll.child, U["FriendlyNameplate"], -650, "friend", UF.RefreshAllPlates)
end

function G:SetupActionBar(parent)
	local guiName = "UIGUI_ActionBarSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["ActionbarSetup"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local Bar = M:GetModule("Actionbar")
	local defaultValues = {
		-- defaultSize, minButtons, maxButtons, defaultButtons, defaultPerRow 
		["Bar1"] = {34, 6, 12, 12, 12},
		["Bar2"] = {34, 1, 12, 12, 12},
		["Bar3"] = {32, 0, 12, 0, 12},
		["Bar4"] = {32, 1, 12, 12, 1},
		["Bar5"] = {32, 1, 12, 12, 1},
		["BarPet"] = {26, 1, 10, 10, 10},
	}
	local function createOptionGroup(parent, title, offset, value, color)
		color = color or ""
		local data = defaultValues[value]
		local function updateBarScale()
			Bar:UpdateActionSize(value)
		end
		createOptionTitle(parent, title, offset)
		createOptionSlider(parent, U["ButtonSize"], 20, 80, data[1], offset-60, value.."Size", updateBarScale, "Actionbar")
		createOptionSlider(parent, color..U["MaxButtons"], data[2], data[3], data[4], offset-130, value.."Num", updateBarScale, "Actionbar")
		createOptionSlider(parent, U["ButtonsPerRow"], 1, data[3], data[5], offset-200, value.."PerRow", updateBarScale, "Actionbar")
		createOptionSlider(parent, U["ButtonFontSize"], 8, 20, 12, offset-270, value.."Font", updateBarScale, "Actionbar")
	end

	createOptionGroup(scroll.child, U["Actionbar"].."1", -10, "Bar1")
	createOptionGroup(scroll.child, U["Actionbar"].."2", -370, "Bar2")
	createOptionGroup(scroll.child, U["Actionbar"].."3", -730, "Bar3", "|cffff0000")
	createOptionGroup(scroll.child, U["Actionbar"].."4", -1090, "Bar4")
	createOptionGroup(scroll.child, U["Actionbar"].."5", -1450, "Bar5")
	createOptionGroup(scroll.child, U["Pet Actionbar"], -1810, "BarPet")

	createOptionTitle(scroll.child, U["LeaveVehicle"], -2170)
	createOptionSlider(scroll.child, U["ButtonSize"], 20, 80, 34, -2230, "VehButtonSize", Bar.UpdateVehicleButton, "Actionbar")
end

function G:SetupStanceBar(parent)
	local guiName = "UIGUI_StanceBarSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["ActionbarSetup"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local Bar = M:GetModule("Actionbar")
	local parent, offset = scroll.child, -10
	createOptionTitle(parent, U["StanceBar"], offset)
	createOptionSlider(parent, U["ButtonSize"], 20, 80, 30, offset-60, "BarStanceSize", Bar.UpdateStanceBar, "Actionbar")
	createOptionSlider(parent, U["ButtonsPerRow"], 1, 10, 10, offset-130, "BarStancePerRow", Bar.UpdateStanceBar, "Actionbar")
	createOptionSlider(parent, U["ButtonFontSize"], 8, 20, 12, offset-200, "BarStanceFont", Bar.UpdateStanceBar, "Actionbar")
end

function G:SetupUFClassPower(parent)
	local guiName = "UIGUI_ClassPowerSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["UFs ClassPower"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local UF = M:GetModule("UnitFrames")
	local parent, offset = scroll.child, -10

	createOptionCheck(parent, offset, U["UFs RuneTimer"], "UFs", "RuneTimer")
	createOptionSlider(parent, U["Width"], 100, 400, 150, offset-70, "CPWidth", UF.UpdateUFClassPower)
	createOptionSlider(parent, U["Height"], 2, 30, 5, offset-140, "CPHeight", UF.UpdateUFClassPower)
	createOptionSlider(parent, U["xOffset"], -20, 200, 12, offset-210, "CPxOffset", UF.UpdateUFClassPower)
	createOptionSlider(parent, U["yOffset"], -200, 20, -2, offset-280, "CPyOffset", UF.UpdateUFClassPower)

	local bar = _G.oUF_Player and _G.oUF_Player.ClassPowerBar
	panel:HookScript("OnHide", function()
		if bar and bar.bg then bar.bg:Hide() end
	end)
end

function G:SetupUFAuras(parent)
	local guiName = "UIGUI_UnitFrameAurasSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["ShowAuras"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local UF = M:GetModule("UnitFrames")
	local parent, offset = scroll.child, -10

	local defaultData = {
		["Player"] = {1, 1, 9, 20, 20},
		["Target"] = {2, 2, 9, 20, 20},
		["Focus"] = {3, 2, 9, 20, 20},
		["ToT"] = {1, 1, 5, 6, 6},
		["Pet"] = {1, 1, 5, 6, 6},
		["Boss"] = {2, 3, 6, 6, 6},
	}
	local buffOptions = {DISABLE, U["ShowAll"], U["ShowDispell"]}
	local debuffOptions = {DISABLE, U["ShowAll"], U["BlockOthers"]}

	local function createOptionGroup(parent, title, offset, value, func, isBoss)
		local default = defaultData[value]
		createOptionTitle(parent, title, offset)
		createOptionDropdown(parent, U["BuffType"], offset-50, buffOptions, nil, "UFs", value.."BuffType", default[1], func)
		createOptionDropdown(parent, U["DebuffType"], offset-110, debuffOptions, nil, "UFs", value.."DebuffType", default[2], func)
		createOptionSlider(parent, U["MaxBuffs"], 1, 40, default[4], offset-180, value.."NumBuff", func)
		createOptionSlider(parent, U["MaxDebuffs"], 1, 40, default[5], offset-250, value.."NumDebuff", func)
		if isBoss then
			createOptionSlider(parent, "Buff "..U["IconsPerRow"], 5, 20, default[3], offset-320, value.."BuffPerRow", func)
			createOptionSlider(parent, "Debuff "..U["IconsPerRow"], 5, 20, default[3], offset-390, value.."DebuffPerRow", func)
		else
			createOptionSlider(parent, U["IconsPerRow"], 5, 20, default[3], offset-320, value.."AurasPerRow", func)
		end
	end

	createOptionTitle(parent, GENERAL, offset)
	createOptionCheck(parent, offset-35, U["DesaturateIcon"], "UFs", "Desaturate", UF.UpdateUFAuras, U["DesaturateIconTip"])
	createOptionCheck(parent, offset-70, U["DebuffColor"], "UFs", "DebuffColor", UF.UpdateUFAuras, U["DebuffColorTip"])

	createOptionGroup(parent, U["PlayerUF"], offset-140, "Player", UF.UpdateUFAuras)
	createOptionGroup(parent, U["TargetUF"], offset-550, "Target", UF.UpdateUFAuras)
	createOptionGroup(parent, U["TotUF"], offset-960, "ToT", UF.UpdateUFAuras)
	createOptionGroup(parent, U["PetUF"], offset-1370, "Pet", UF.UpdateUFAuras)
	createOptionGroup(parent, U["FocusUF"], offset-1780, "Focus", UF.UpdateUFAuras)
	createOptionGroup(parent, U["BossFrame"], offset-2190, "Boss", UF.UpdateUFAuras, true)
end

function G:SetupActionbarStyle(parent)
	local maxButtons = 6
	local size, padding = 26, 1

	local frame = CreateFrame("Frame", "UIActionbarStyleFrame", parent.child)
	frame:SetSize((size+padding)*maxButtons + padding, size + 2*padding)
	frame:SetPoint("TOPRIGHT", 100, -60)
	--M.CreateBDFrame(frame, .25)

	local Bar = M:GetModule("Actionbar")

	local styleString = {
		[1] = "NAB:34:12:12:12:34:12:12:12:32:12:0:12:32:12:12:1:32:12:12:1:26:12:10:10:30:12:10:0B24:0B60:-271B26:271B26:-1BR336:-35BR336:0B100:-202B100",
		[2] = "NAB:34:12:12:12:34:12:12:12:34:12:12:12:32:12:12:1:32:12:12:1:26:12:10:10:30:12:10:0B24:0B60:0B96:271B26:-1BR336:-35BR336:0B134:-200B138",
		[3] = "NAB:34:12:12:12:34:12:12:12:34:12:12:6:32:12:12:1:32:12:12:1:26:12:10:10:30:12:10:-108B24:-108B60:216B24:271B26:-1TR-336:-35TR-336:0B98:-310B100",
		[4] = "NAB:34:12:12:12:34:12:12:12:32:12:12:6:32:12:12:6:32:12:12:1:26:12:10:10:30:12:10:0B24:0B60:536BL26:271B26:-536BR26:-1TR-336:0B100:-202B100",
	}
	local styleName = {
		[1] = _G.DEFAULT,
		[2] = "3X12",
		[3] = "2X18",
		[4] = "12+24+12",
		[5] = U["Export"],
		[6] = U["Import"],
	}
	local tooltips = {
		[5] = U["ExportActionbarStyle"],
		[6] = U["ImportActionbarStyle"],
	}

	local function applyBarStyle(self)
		if not IsControlKeyDown() then return end
		local str = styleString[self.index]
		if not str then return end
		Bar:ImportActionbarStyle(str)
	end

	StaticPopupDialogs["UI_BARSTYLE_EXPORT"] = {
		text = U["Export"],
		button1 = OKAY,
		OnShow = function(self)
			self.editBox:SetText(Bar:ExportActionbarStyle())
			self.editBox:HighlightText()
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide()
		end,
		whileDead = 1,
		hasEditBox = 1,
		editBoxWidth = 250,
	}

	StaticPopupDialogs["UI_BARSTYLE_IMPORT"] = {
		text = U["Import"],
		button1 = OKAY,
		button2 = CANCEL,
		OnShow = function(self)
			self.button1:Disable()
		end,
		OnAccept = function(self)
			Bar:ImportActionbarStyle(self.editBox:GetText())
		end,
		EditBoxOnTextChanged = function(self)
			local button1 = self:GetParent().button1
			local text = self:GetText()
			local found = text and strfind(text, "^NAB:")
			if found then
				button1:Enable()
			else
				button1:Disable()
			end
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide()
		end,
		whileDead = 1,
		showAlert = 1,
		hasEditBox = 1,
		editBoxWidth = 250,
	}

	local function exportBarStyle()
		StaticPopup_Hide("UI_BARSTYLE_IMPORT")
		StaticPopup_Show("UI_BARSTYLE_EXPORT")
	end

	local function importBarStyle()
		StaticPopup_Hide("UI_BARSTYLE_EXPORT")
		StaticPopup_Show("UI_BARSTYLE_IMPORT")
	end

	M:RegisterEvent("PLAYER_REGEN_DISABLED", function()
		StaticPopup_Hide("UI_BARSTYLE_EXPORT")
		StaticPopup_Hide("UI_BARSTYLE_IMPORT")
	end)

	local function styleOnEnter(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
		GameTooltip:ClearLines()
		GameTooltip:AddLine(self.title)
		GameTooltip:AddLine(self.tip, .6,.8,1,1)
		GameTooltip:Show()
	end

	local function GetButtonText(i)
		if i == 5 then
			return "|T"..I.ArrowUp..":18|t"
		elseif i == 6 then
			return "|T"..I.ArrowUp..":18:18:0:0:1:1:0:1:1:0|t"
		else
			return i
		end
	end

	for i = 1, maxButtons do
		local bu = M.CreateButton(frame, size, size, GetButtonText(i))
		bu:SetPoint("LEFT", (i-1)*(size + padding) + padding, 0)
		bu.index = i
		bu.title = styleName[i]
		bu.tip = tooltips[i] or U["ApplyBarStyle"]
		if i == 5 then
			bu:SetScript("OnClick", exportBarStyle)
		elseif i == 6 then
			bu:SetScript("OnClick", importBarStyle)
		else
			bu:SetScript("OnClick", applyBarStyle)
		end
		bu:HookScript("OnEnter", styleOnEnter)
		bu:HookScript("OnLeave", M.HideTooltip)
	end
end

function G:SetupBuffFrame(parent)
	local guiName = "UIGUI_BuffFrameSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["BuffFrame"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local A = M:GetModule("Auras")
	local parent, offset = scroll.child, -10
	local defaultSize, defaultPerRow = 30, 16

	local function updateBuffFrame()
		if not A.settings then return end
		A:UpdateOptions()
		A:UpdateHeader(A.BuffFrame)
		A.BuffFrame.mover:SetSize(A.BuffFrame:GetSize())
	end
	
	local function updateDebuffFrame()
		if not A.settings then return end
		A:UpdateOptions()
		A:UpdateHeader(A.DebuffFrame)
		A.DebuffFrame.mover:SetSize(A.DebuffFrame:GetSize())
	end

	local function createOptionGroup(parent, title, offset, value, func)
		createOptionTitle(parent, title, offset)
		createOptionCheck(parent, offset-35, U["ReverseGrow"], "Auras", "Reverse"..value, func)
		createOptionSlider(parent, U["Auras Size"], 20, 50, defaultSize, offset-100, value.."Size", func, "Auras")
		createOptionSlider(parent, U["IconsPerRow"], 10, 40, defaultPerRow, offset-170, value.."sPerRow", func, "Auras")
	end

	createOptionGroup(parent, "Buffs", offset, "Buff", updateBuffFrame)
	createOptionGroup(parent, "Debuffs", offset-260, "Debuff", updateDebuffFrame)
end