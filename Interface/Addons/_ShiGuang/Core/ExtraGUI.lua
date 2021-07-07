local _, ns = ...
local M, R, U, I = unpack(ns)
local G = M:GetModule("GUI")

local _G = _G
local unpack, pairs, ipairs, tinsert = unpack, pairs, ipairs, tinsert
local min, max, strmatch, tonumber = min, max, strmatch, tonumber
local GetSpellInfo, GetSpellTexture = GetSpellInfo, GetSpellTexture
local GetInstanceInfo, EJ_GetInstanceInfo = GetInstanceInfo, EJ_GetInstanceInfo

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
	local guiName = "NDuiGUI_RaidDebuffs"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["RaidFrame Debuffs"].."*", true)
	panel:SetScript("OnHide", updateRaidDebuffs)

	local setupBars
	local frame = panel.bg
	local bars, options = {}, {}

	--[[local iType = G:CreateDropdown(frame, U["Type*"], 10, -30, {DUNGEONS, RAID}, U["Instance Type"])
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
	end]]

	local dungeons = {}
	for dungeonID = 1182, 1189 do
		AddNewDungeon(dungeons, dungeonID)
	end
	AddNewDungeon(dungeons, 1194)

	local raids = {
		[1] = EJ_GetInstanceInfo(1190),
		[2] = EJ_GetInstanceInfo(1193),
	}

	options[1] = G:CreateDropdown(frame, DUNGEONS.."*", 10, -30, dungeons, U["Dungeons Intro"], 110, 30)
	--options[1]:Hide()
	options[2] = G:CreateDropdown(frame, RAID.."*", 140, -30, raids, U["Raid Intro"], 110, 30)
	--options[2]:Hide()

	options[3] = G:CreateEditbox(frame, "ID*", 10, -80, U["ID Intro"])
	options[4] = G:CreateEditbox(frame, U["Priority"], 120, -80, U["Priority Intro"])

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
	StaticPopupDialogs["RESET_NDUI_RAIDDEBUFFS"] = {
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
		StaticPopup_Show("RESET_NDUI_RAIDDEBUFFS")
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
		prioBox.title = U["Tips"]
		M.AddTooltip(prioBox, "ANCHOR_RIGHT", U["Prio Editbox"], "info")
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
	local guiName = "NDuiGUI_ClickCast"
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
	StaticPopupDialogs["RESET_NDUI_CLICKSETS"] = {
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
		StaticPopup_Show("RESET_NDUI_CLICKSETS")
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
	local guiName = "NDuiGUI_PartyWatcher"
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
	StaticPopupDialogs["RESET_NDUI_PARTYWATCHER"] = {
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
		StaticPopup_Show("RESET_NDUI_PARTYWATCHER")
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
	local guiName = "NDuiGUI_NameplateFilter"
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
	local guiName = "NDuiGUI_BuffIndicator"
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
	StaticPopupDialogs["RESET_NDUI_RaidAuraWatch"] = {
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
		scroll.box.title = U["Tips"]
		M.AddTooltip(scroll.box, "ANCHOR_RIGHT", U["ID Intro"], "info")

		scroll.add = M.CreateButton(frame, 45, 25, ADD)
		scroll.add:SetPoint("TOPRIGHT", -8, -10)
		scroll.add:SetScript("OnClick", function()
			addClick(scroll, index)
		end)

		scroll.reset = M.CreateButton(frame, 45, 25, RESET)
		scroll.reset:SetPoint("RIGHT", scroll.add, "LEFT", -5, 0)
		scroll.reset:SetScript("OnClick", function()
			currentIndex = index
			StaticPopup_Show("RESET_NDUI_RaidAuraWatch")
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
			showAll.title = U["Tips"]
			M.AddTooltip(showAll, "ANCHOR_RIGHT", U["ShowAllTip"], "info")
			scroll.showAll = showAll

			local UF = M:GetModule("UnitFrames")
			for spellID, value in pairs(UF.CornerSpells) do
				local r, g, b = unpack(value[2])
				createBar(scroll.child, index, spellID, value[1], r, g, b, value[3])
			end
		end
	end
end

local function createOptionTitle(parent, title, offset)
	M.CreateFS(parent, 14, title, nil, "TOP", 0, offset)
	local line = M.SetGradient(parent, "H", 1, 1, 1, .25, .25, 200, R.mult)
	line:SetPoint("TOPLEFT", 30, offset-20)
end

local function sliderValueChanged(self, v)
	local current = tonumber(format("%.0f", v))
	self.value:SetText(current)
	R.db["UFs"][self.__value] = current
	self.__update()
end

local function createOptionSlider(parent, title, minV, maxV, defaultV, x, y, value, func)
	local slider = M.CreateSlider(parent, title, minV, maxV, 1, x, y)
	slider:SetValue(R.db["UFs"][value])
	slider.value:SetText(R.db["UFs"][value])
	slider.__value = value
	slider.__update = func
	slider.__default = defaultV
	slider:SetScript("OnValueChanged", sliderValueChanged)
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

function G:SetupRaidFrame(parent)
	local guiName = "NDuiGUI_RaidFrameSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["RaidFrame Size"])
	local scroll = G:CreateScroll(panel, 260, 540)

	local minRange = {
		["Party"] = {80, 25},
		["PartyPet"] = {80, 8},
		["Raid"] = {60, 12},
		["Focus"] = {120, 16},
		["Boss"] = {100, 16},
	}

	local defaultValue = {
		["Party"] = {100, 32, 2},
		["PartyPet"] = {100, 22, 2},
		["Raid"] = {80, 32, 2},
		["Focus"] = {120, 21, 3},
		["Boss"] = {120, 21, 3},
	}

	local function createOptionGroup(parent, title, offset, value, func)
		createOptionTitle(parent, title, offset)
		createOptionSlider(parent, U["Health Width"], minRange[value][1], 300, defaultValue[value][1], 30, offset-60, value.."Width", func)
		createOptionSlider(parent, U["Health Height"], minRange[value][2], 60, defaultValue[value][2], 30, offset-130, value.."Height", func)
		createOptionSlider(parent, U["Power Height"], 2, 20, defaultValue[value][3], 30, offset-200, value.."PowerHeight", func)
	end

	local function resizeRaidFrame()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.mystyle == "raid" and not frame.isPartyFrame and not frame.isPartyPet then
				if R.db["UFs"]["SimpleMode"] then
					local scale = R.db["UFs"]["SimpleRaidScale"]/10
					local frameWidth = 100*scale
					local frameHeight = 20*scale
					local powerHeight = 2*scale
					local healthHeight = frameHeight - powerHeight
					frame:SetSize(frameWidth, frameHeight)
					frame.Health:SetHeight(healthHeight)
					frame.Power:SetHeight(powerHeight)
				else
					SetUnitFrameSize(frame, "Raid")
				end
			end
		end
	end
	createOptionGroup(scroll.child, U["RaidFrame"], -10, "Raid", resizeRaidFrame)
	createOptionSlider(scroll.child, "|cff00cc4c"..U["SimpleMode Scale"], 8, 15, 10, 30, -280, "SimpleRaidScale", resizeRaidFrame)

	local function resizePartyFrame()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.isPartyFrame then
				SetUnitFrameSize(frame, "Party")
			end
		end
	end
	createOptionGroup(scroll.child, U["PartyFrame"], -340, "Party", resizePartyFrame)

	local function resizePartyPetFrame()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.isPartyPet then
				SetUnitFrameSize(frame, "PartyPet")
			end
		end
	end
	createOptionGroup(scroll.child, U["PartyPetFrame"], -600, "PartyPet", resizePartyPetFrame)

	local function updateFocusSize()
		local frame = _G.oUF_Focus
		if frame then
			SetUnitFrameSize(frame, "Focus")
		end
	end
	createOptionGroup(scroll.child, U["FocusUF"], -860, "Focus", updateFocusSize)
	
	local function updateBossSize()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.mystyle == "boss" or frame.mystyle == "arena" then
				SetUnitFrameSize(frame, "Boss")
			end
		end
	end
	createOptionGroup(scroll.child, U["Boss&Arena"], -1120, "Boss", updateBossSize)
end

local function createOptionSwatch(parent, name, value, x, y)
	local swatch = M.CreateColorSwatch(parent, name, value)
	swatch:SetPoint("TOPLEFT", x, y)
	swatch.text:SetTextColor(1, .8, 0)
end

function G:SetupCastbar(parent)
	local guiName = "NDuiGUI_CastbarSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["Castbar Settings"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	createOptionTitle(scroll.child, U["Castbar Colors"], -10)
	createOptionSwatch(scroll.child, U["Interruptible Color"], R.db["UFs"]["CastingColor"], 40, -40)
	createOptionSwatch(scroll.child, U["NotInterruptible Color"], R.db["UFs"]["NotInterruptColor"], 40, -70)

	local defaultValue = {
		["Player"] = {300, 20},
		["Target"] = {280, 20},
		["Focus"] = {320, 20},
	}

	local function createOptionGroup(parent, title, offset, value, func)
		createOptionTitle(parent, title, offset)
		createOptionSlider(parent, U["Castbar Width"], 200, 400, defaultValue[value][1], 30, offset-60, value.."CBWidth", func)
		createOptionSlider(parent, U["Castbar Height"], 10, 50, defaultValue[value][2], 30, offset-130, value.."CBHeight", func)
	end

	local function updatePlayerCastbar()
		if _G.oUF_Player then
			local width, height = R.db["UFs"]["PlayerCBWidth"], R.db["UFs"]["PlayerCBHeight"]
			_G.oUF_Player.Castbar:SetSize(width, height)
			_G.oUF_Player.Castbar.Icon:SetSize(height, height)
			_G.oUF_Player.Castbar.mover:Show()
			_G.oUF_Player.Castbar.mover:SetSize(width+height+5, height+5)
			if _G.oUF_Player.QuakeTimer then
				_G.oUF_Player.QuakeTimer:SetSize(width, height)
				_G.oUF_Player.QuakeTimer.Icon:SetSize(height, height)
				_G.oUF_Player.QuakeTimer.mover:Show()
				_G.oUF_Player.QuakeTimer.mover:SetSize(width+height+5, height+5)
			end
			if _G.oUF_Player.Swing then
				_G.oUF_Player.Swing:SetWidth(width-height-5)
			end
		end
	end
	createOptionGroup(scroll.child, U["Player Castbar"], -110, "Player", updatePlayerCastbar)

	local function updateTargetCastbar()
		if _G.oUF_Target then
			local width, height = R.db["UFs"]["TargetCBWidth"], R.db["UFs"]["TargetCBHeight"]
			_G.oUF_Target.Castbar:SetSize(width, height)
			_G.oUF_Target.Castbar.Icon:SetSize(height, height)
			_G.oUF_Target.Castbar.mover:Show()
			_G.oUF_Target.Castbar.mover:SetSize(width+height+5, height+5)
		end
	end
	createOptionGroup(scroll.child, U["Target Castbar"], -310, "Target", updateTargetCastbar)

	local function updateFocusCastbar()
		if _G.oUF_Focus then
			local width, height = R.db["UFs"]["FocusCBWidth"], R.db["UFs"]["FocusCBHeight"]
			_G.oUF_Focus.Castbar:SetSize(width, height)
			_G.oUF_Focus.Castbar.Icon:SetSize(height, height)
			_G.oUF_Focus.Castbar.mover:Show()
			_G.oUF_Focus.Castbar.mover:SetSize(width+height+5, height+5)
		end
	end
	createOptionGroup(scroll.child, U["Focus Castbar"], -510, "Focus", updateFocusCastbar)

	panel:HookScript("OnHide", function()
		if _G.oUF_Player then
			_G.oUF_Player.Castbar.mover:Hide()
			if _G.oUF_Player.QuakeTimer then _G.oUF_Player.QuakeTimer.mover:Hide() end
		end
		if _G.oUF_Target then _G.oUF_Target.Castbar.mover:Hide() end
		if _G.oUF_Focus then _G.oUF_Focus.Castbar.mover:Hide() end
	end)
end

local function createOptionCheck(parent, offset, text)
	local box = M.CreateCheckBox(parent)
	box:SetPoint("TOPLEFT", 10, -offset)
	M.CreateFS(box, 14, text, false, "LEFT", 30, 0)
	return box
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
	StaticPopupDialogs["RESET_NDUI_MAJORSPELLS"] = {
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
		StaticPopup_Show("RESET_NDUI_MAJORSPELLS")
	end)

	local UF = M:GetModule("UnitFrames")
	for spellID, value in pairs(UF.MajorSpells) do
		if value then
			createBar(scroll.child, spellID)
		end
	end
end