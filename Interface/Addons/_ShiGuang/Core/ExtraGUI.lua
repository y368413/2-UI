local _, ns = ...
local M, R, U, I = unpack(ns)
local G = M:GetModule("GUI")

local function sortBars(barTable)
	local num = 1
	for _, bar in pairs(barTable) do
		if num == 1 then
			bar:SetPoint("TOPLEFT", 10, -10)
		else
			bar:SetPoint("TOPLEFT", 10, -10 - 35*(num-1))
		end
		num = num + 1
	end
end

local extraGUIs = {}
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
	parent:HookScript("OnHide", function()
		if frame:IsShown() then frame:Hide() end
	end)

	if title then
		M.CreateFS(frame, 14, title, "system", "TOPLEFT", 20, -5)
	end

	if bgFrame then
		frame.bg = CreateFrame("Frame", nil, frame)
		frame.bg:SetSize(280, 540)
		frame.bg:SetPoint("TOPLEFT", 10, -30)
		M.CreateBD(frame.bg, .3)
	end

	tinsert(extraGUIs, frame)
	return frame
end

local function toggleExtraGUI(name)
	for _, frame in next, extraGUIs do
		if frame:GetName() == name then
			M:TogglePanel(frame)
		else
			frame:Hide()
		end
	end
end

local function clearEdit(options)
	for i = 1, #options do
		G:ClearEdit(options[i])
	end
end

local raidDebuffsGUI, clickCastGUI, buffIndicatorGUI, plateGUI, unitframeGUI, castbarGUI, raidframeGUI, partyWatcherGUI, bagFilterGUI

local function updateRaidDebuffs()
	M:GetModule("UnitFrames"):UpdateRaidDebuffs()
end

function G:SetupRaidDebuffs(parent)
	toggleExtraGUI("NDuiGUI_RaidDebuffs")
	if raidDebuffsGUI then return end

	raidDebuffsGUI = createExtraGUI(parent, "NDuiGUI_RaidDebuffs", U["RaidFrame Debuffs"].."*", true)
	raidDebuffsGUI:SetScript("OnHide", updateRaidDebuffs)

	local setupBars
	local frame = raidDebuffsGUI.bg
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
	for _, dungeonID in next, C_ChallengeMode.GetMapTable() do
		if dungeonID < 369 then
			local name = C_ChallengeMode.GetMapUIInfo(dungeonID)
			tinsert(dungeons, name)
		end
	end
	local mechagon = EJ_GetInstanceInfo(1178)
	tinsert(dungeons, mechagon)

	local raids = {
		[1] = EJ_GetInstanceInfo(1031),
		[2] = EJ_GetInstanceInfo(1176),
		[3] = EJ_GetInstanceInfo(1177),
		[4] = EJ_GetInstanceInfo(1179),
		[5] = EJ_GetInstanceInfo(1180),
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
		local bar = CreateFrame("Frame", nil, scroll.child)
		bar:SetSize(220, 30)
		M.CreateBD(bar, .3)
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
		prioBox:SetBackdropColor(1, 1, 1, .2)
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

		for spellID, priority in pairs(R.RaidDebuffs[instName]) do
			if not (MaoRUIDB["RaidDebuffs"][instName] and MaoRUIDB["RaidDebuffs"][instName][spellID]) then
				index = index + 1
				applyData(index, instName, spellID, priority)
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
			if i == 1 then
				bars[i]:SetPoint("TOPLEFT", 10, -10)
			else
				bars[i]:SetPoint("TOPLEFT", bars[i-1], "BOTTOMLEFT", 0, -5)
			end
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
	raidDebuffsGUI:HookScript("OnShow", autoSelectInstance)
end

function G:SetupClickCast(parent)
	toggleExtraGUI("NDuiGUI_ClickCast")
	if clickCastGUI then return end

	clickCastGUI = createExtraGUI(parent, "NDuiGUI_ClickCast", U["Add ClickSets"], true)

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

		local bar = CreateFrame("Frame", nil, parent)
		bar:SetSize(220, 30)
		M.CreateBD(bar, .3)
		barTable[clickSet] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", value, "system")
		close:SetScript("OnClick", function()
			bar:Hide()
			MaoRUIPerDB["RaidClickSets"][clickSet] = nil
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

	local frame = clickCastGUI.bg
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
			MaoRUIPerDB["RaidClickSets"] = nil
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
		if (not tonumber(value)) and value ~= "target" and value ~= "focus" and value ~= "follow" and not value:match("/") then UIErrorsFrame:AddMessage(I.InfoColor..U["Invalid Input"]) return end
		if not modKey or modKey == NONE then modKey = "" end
		local clickSet = modKey..key
		if MaoRUIPerDB["RaidClickSets"][clickSet] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ClickSet"]) return end

		MaoRUIPerDB["RaidClickSets"][clickSet] = {key, modKey, value}
		createBar(scroll.child, MaoRUIPerDB["RaidClickSets"][clickSet])
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

	for _, v in pairs(MaoRUIPerDB["RaidClickSets"]) do
		createBar(scroll.child, v)
	end
end

function G:SetupPartyWatcher(parent)
	toggleExtraGUI("NDuiGUI_PartyWatcher")
	if partyWatcherGUI then return end

	partyWatcherGUI = createExtraGUI(parent, "NDuiGUI_PartyWatcher", U["AddPartyWatcher"].."*", true)

	local barTable = {}
	local ARCANE_TORRENT = GetSpellInfo(25046)

	local function createBar(parent, spellID, duration)
		local spellName = GetSpellInfo(spellID)
		if spellName == ARCANE_TORRENT then return end
		local texture = GetSpellTexture(spellID)

		local bar = CreateFrame("Frame", nil, parent)
		bar:SetSize(220, 30)
		M.CreateBD(bar, .3)
		barTable[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID, "system")
		close:SetScript("OnClick", function()
			bar:Hide()
			MaoRUIDB["PartyWatcherSpells"][spellID] = nil
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

	local frame = partyWatcherGUI.bg
	local options = {}

	options[1] = G:CreateEditbox(frame, "ID*", 10, -30, U["ID Intro"])
	options[2] = G:CreateEditbox(frame, U["Cooldown*"], 120, -30, U["Cooldown Intro"])

	local scroll = G:CreateScroll(frame, 240, 410)
	scroll.reset = M.CreateButton(frame, 70, 25, RESET)
	scroll.reset:SetPoint("TOPLEFT", 10, -80)
	StaticPopupDialogs["RESET_NDUI_PARTYWATCHER"] = {
		text = U["Reset your raiddebuffs list?"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			wipe(MaoRUIDB["PartyWatcherSpells"])
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
		if MaoRUIDB["PartyWatcherSpells"][spellID] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end

		MaoRUIDB["PartyWatcherSpells"][spellID] = duration
		createBar(scroll.child, spellID, duration)
		clearEdit(options)
	end

	scroll.add = M.CreateButton(frame, 70, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -10, -80)
	scroll.add:SetScript("OnClick", function()
		addClick(scroll, options)
	end)

	scroll.clear = M.CreateButton(frame, 70, 25, KEY_NUMLOCK_MAC)
	scroll.clear:SetPoint("RIGHT", scroll.add, "LEFT", -10, 0)
	scroll.clear:SetScript("OnClick", function()
		clearEdit(options)
	end)

	for spellID, duration in pairs(MaoRUIDB["PartyWatcherSpells"]) do
		createBar(scroll.child, spellID, duration)
	end
end

function G:SetupNameplateFilter(parent)
	toggleExtraGUI("NDuiGUI_NameplateFilter")
	if plateGUI then return end

	plateGUI = createExtraGUI(parent, "NDuiGUI_NameplateFilter")

	local frameData = {
		[1] = {text = U["WhiteList"].."*", offset = -5, barList = {}},
		[2] = {text = U["BlackList"].."*", offset = -295, barList = {}},
	}

	local function createBar(parent, index, spellID)
		local name, _, texture = GetSpellInfo(spellID)
		local bar = CreateFrame("Frame", nil, parent)
		bar:SetSize(220, 30)
		M.CreateBD(bar, .3)
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
		M.CreateFS(plateGUI, 14, value.text, "system", "TOPLEFT", 20, value.offset)
		local frame = CreateFrame("Frame", nil, plateGUI)
		frame:SetSize(280, 250)
		frame:SetPoint("TOPLEFT", 10, value.offset - 25)
		M.CreateBD(frame, .3)

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

function G:SetupBuffIndicator(parent)
	toggleExtraGUI("NDuiGUI_BuffIndicator")
	if buffIndicatorGUI then return end

	buffIndicatorGUI = createExtraGUI(parent, "NDuiGUI_BuffIndicator")

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
		local bar = CreateFrame("Frame", nil, parent)
		bar:SetSize(220, 30)
		M.CreateBD(bar, .3)
		frameData[index].barList[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID)
		close:SetScript("OnClick", function()
			bar:Hide()
			if index == 1 then
				MaoRUIDB["RaidAuraWatch"][spellID] = nil
			else
				MaoRUIDB["CornerBuffs"][I.MyClass][spellID] = nil
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
			anchor, r, g, b = parent.dd.Text:GetText(), parent.swatch.tex:GetVertexColor()
			showAll = parent.showAll:GetChecked() or nil
			if MaoRUIDB["CornerBuffs"][I.MyClass][spellID] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end
			anchor = decodeAnchor[anchor]
			MaoRUIDB["CornerBuffs"][I.MyClass][spellID] = {anchor, {r, g, b}, showAll}
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
				MaoRUIDB["CornerBuffs"][I.MyClass] = nil
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
		M.CreateFS(buffIndicatorGUI, 14, value.text, "system", "TOPLEFT", 20, value.offset)

		local frame = CreateFrame("Frame", nil, buffIndicatorGUI)
		frame:SetSize(280, 250)
		frame:SetPoint("TOPLEFT", 10, value.offset - 25)
		M.CreateBD(frame, .3)

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
			scroll.dd = M.CreateDropDown(frame, 45, 25, anchors)
			scroll.dd:SetPoint("TOPLEFT", 10, -10)
			scroll.dd.options[1]:Click()

			for i = 1, 8 do
				scroll.dd.options[i]:HookScript("OnEnter", optionOnEnter)
				scroll.dd.options[i]:HookScript("OnLeave", M.HideTooltip)
			end
			scroll.box:SetPoint("TOPLEFT", scroll.dd, "TOPRIGHT", 20, 0)

			local swatch = M.CreateColorSwatch(frame, "")
			swatch:SetPoint("LEFT", scroll.box, "RIGHT", 5, 0)
			scroll.swatch = swatch

			local showAll = M.CreateCheckBox(frame)
			showAll:SetPoint("LEFT", swatch, "RIGHT", 2, 0)
			showAll:SetHitRectInsets(0, 0, 0, 0)
			showAll.title = U["Tips"]
			M.AddTooltip(showAll, "ANCHOR_RIGHT", U["ShowAllTip"], "info")
			scroll.showAll = showAll

			for spellID, value in pairs(MaoRUIDB["CornerBuffs"][I.MyClass]) do
				local r, g, b = unpack(value[2])
				createBar(scroll.child, index, spellID, value[1], r, g, b, value[3])
			end
		end
	end
end

local function createOptionTitle(parent, title, offset)
	M.CreateFS(parent, 14, title, nil, "TOP", 0, offset)
	local l = CreateFrame("Frame", nil, parent)
	l:SetPoint("TOPLEFT", 30, offset-20)
	M.CreateGF(l, 200, R.mult, "Horizontal", 1, 1, 1, .25, .25)
end

local function sliderValueChanged(self, v)
	local current = tonumber(format("%.0f", v))
	self.value:SetText(current)
	MaoRUIPerDB["UFs"][self.__value] = current
	self.__update()
end

local function createOptionSlider(parent, title, minV, maxV, x, y, value, func)
	local slider = M.CreateSlider(parent, title, minV, maxV, x, y)
	slider:SetValue(MaoRUIPerDB["UFs"][value])
	slider.value:SetText(MaoRUIPerDB["UFs"][value])
	slider.__value = value
	slider.__update = func
	slider:SetScript("OnValueChanged", sliderValueChanged)
end

local function SetUnitFrameSize(self, unit)
	local width = MaoRUIPerDB["UFs"][unit.."Width"]
	local height = MaoRUIPerDB["UFs"][unit.."Height"] + MaoRUIPerDB["UFs"][unit.."PowerHeight"] + R.mult
	self:SetSize(width, height)
	self.Health:SetHeight(MaoRUIPerDB["UFs"][unit.."Height"])
	self.Power:SetHeight(MaoRUIPerDB["UFs"][unit.."PowerHeight"])
end

function G:SetupRaidFrame(parent)
	toggleExtraGUI("NDuiGUI_RaidFrameSetup")
	if raidframeGUI then return end

	raidframeGUI = createExtraGUI(parent, "NDuiGUI_RaidFrameSetup", U["RaidFrame Size"])

	local scroll = G:CreateScroll(raidframeGUI, 260, 540)

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
		createOptionSlider(parent, U["Health Width"].."("..defaultValue[value][1]..")", minRange[value][1], 300, 30, offset-60, value.."Width", func)
		createOptionSlider(parent, U["Health Height"].."("..defaultValue[value][2]..")", minRange[value][2], 60, 30, offset-130, value.."Height", func)
		createOptionSlider(parent, U["Power Height"].."("..defaultValue[value][3]..")", 2, 20, 30, offset-200, value.."PowerHeight", func)
	end

	local function resizeRaidFrame()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.mystyle == "raid" and not frame.isPartyFrame and not frame.isPartyPet then
				if MaoRUIPerDB["UFs"]["SimpleMode"] then
					local scale = MaoRUIPerDB["UFs"]["SimpleRaidScale"]/10
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
	createOptionSlider(scroll.child, "|cff00cc4c"..U["SimpleMode Scale"], 8, 15, 30, -280, "SimpleRaidScale", resizeRaidFrame)

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
		for _, frame in next, ns.oUF.objects do
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
	toggleExtraGUI("NDuiGUI_CastbarSetup")
	if castbarGUI then return end

	castbarGUI = createExtraGUI(parent, "NDuiGUI_CastbarSetup", U["Castbar Settings"].."*")

	local scroll = G:CreateScroll(castbarGUI, 260, 540)

	createOptionTitle(scroll.child, U["Castbar Colors"], -10)
	createOptionSwatch(scroll.child, U["Interruptible Color"], MaoRUIPerDB["UFs"]["CastingColor"], 40, -40)
	createOptionSwatch(scroll.child, U["NotInterruptible Color"], MaoRUIPerDB["UFs"]["NotInterruptColor"], 40, -70)

	local defaultValue = {
		["Player"] = {300, 20},
		["Target"] = {280, 20},
		["Focus"] = {320, 20},
	}

	local function createOptionGroup(parent, title, offset, value, func)
		createOptionTitle(parent, title, offset)
		createOptionSlider(parent, U["Castbar Width"].."("..defaultValue[value][1]..")", 200, 400, 30, offset-60, value.."CBWidth", func)
		createOptionSlider(parent, U["Castbar Height"].."("..defaultValue[value][2]..")", 10, 50, 30, offset-130, value.."CBHeight", func)
	end

	local function updatePlayerCastbar()
		if _G.oUF_Player then
			local width, height = MaoRUIPerDB["UFs"]["PlayerCBWidth"], MaoRUIPerDB["UFs"]["PlayerCBHeight"]
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
			local width, height = MaoRUIPerDB["UFs"]["TargetCBWidth"], MaoRUIPerDB["UFs"]["TargetCBHeight"]
			_G.oUF_Target.Castbar:SetSize(width, height)
			_G.oUF_Target.Castbar.Icon:SetSize(height, height)
			_G.oUF_Target.Castbar.mover:Show()
			_G.oUF_Target.Castbar.mover:SetSize(width+height+5, height+5)
		end
	end
	createOptionGroup(scroll.child, U["Target Castbar"], -310, "Target", updateTargetCastbar)

	local function updateFocusCastbar()
		if _G.oUF_Focus then
			local width, height = MaoRUIPerDB["UFs"]["FocusCBWidth"], MaoRUIPerDB["UFs"]["FocusCBHeight"]
			_G.oUF_Focus.Castbar:SetSize(width, height)
			_G.oUF_Focus.Castbar.Icon:SetSize(height, height)
			_G.oUF_Focus.Castbar.mover:Show()
			_G.oUF_Focus.Castbar.mover:SetSize(width+height+5, height+5)
		end
	end
	createOptionGroup(scroll.child, U["Focus Castbar"], -510, "Focus", updateFocusCastbar)

	castbarGUI:HookScript("OnHide", function()
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