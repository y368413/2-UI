local _, ns = ...
local M, R, U, I = unpack(ns)
local G = M:GetModule("GUI")

local _G = _G
local unpack, pairs, ipairs, tinsert = unpack, pairs, ipairs, tinsert
local min, max, strmatch, strfind, tonumber = min, max, strmatch, strfind, tonumber
local GetSpellName, GetSpellTexture = C_Spell.GetSpellName, C_Spell.GetSpellTexture
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

local function toggleOptionsPanel(option)
	local dd = option.__owner
	for i = 1, #dd.panels do
		dd.panels[i]:SetShown(i == option.index)
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

	local iType = G:CreateDropdown(frame, U["Type*"], 10, -30, {DUNGEONS, RAID, OTHER}, U["Instance Type"])
	for i = 1, 3 do
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

			if i == 3 then
				setupBars(0) -- add OTHER spells
			end
		end)
	end

	local maxLevel = UnitLevel("player") > 70
	local dungeons = {}

	if maxLevel then
		for dungeonID = 1267, 1274 do
			if dungeonID ~= 1273 then
				AddNewDungeon(dungeons, dungeonID)
			end
		end
		AddNewDungeon(dungeons, 1210) -- 暗焰裂口
		AddNewDungeon(dungeons, 71) -- 格瑞姆巴托
		AddNewDungeon(dungeons, 1023) -- 围攻伯拉勒斯
		AddNewDungeon(dungeons, 1182) -- 通灵战潮
		AddNewDungeon(dungeons, 1184) -- 塞兹仙林的迷雾
	else
		for dungeonID = 1196, 1204 do
			if dungeonID ~= 1200 then
				AddNewDungeon(dungeons, dungeonID)
			end
		end
		AddNewDungeon(dungeons, 1209)  -- 永恒黎明
		AddNewDungeon(dungeons, 65)  -- 潮汐王座
		AddNewDungeon(dungeons, 556)  -- 永茂林地
		AddNewDungeon(dungeons, 740)  -- 黑鸦堡垒
		AddNewDungeon(dungeons, 762)  -- 黑心林地
		AddNewDungeon(dungeons, 968)  -- 阿塔达萨
		AddNewDungeon(dungeons, 1021)  -- 维克雷斯庄园
	end

	local raids
	if maxLevel then
		raids = {
			[1] = EJ_GetInstanceInfo(1273), -- 尼鲁巴尔王宫
		}
	else
		raids = {
			[1] = EJ_GetInstanceInfo(1200),
			[2] = EJ_GetInstanceInfo(1208),
			[3] = EJ_GetInstanceInfo(1207),
		}
	end

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
		local savedPrio = MaoRUISetDB["RaidDebuffs"][instName] and MaoRUISetDB["RaidDebuffs"][instName][spellID]
		if (localPrio and savedPrio and savedPrio == 0) or (not localPrio and not savedPrio) then
			return false
		end
		return true
	end

	local function addClick(options)
		local dungeonName, raidName, spellID, priority = options[1].Text:GetText(), options[2].Text:GetText(), tonumber(options[3]:GetText()), tonumber(options[4]:GetText())
		local instName = dungeonName or raidName or (iType.Text:GetText() == OTHER and 0)
		if not instName or not spellID then UIErrorsFrame:AddMessage(I.InfoColor..U["Incomplete Input"]) return end
		if spellID and not GetSpellName(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		if isAuraExisted(instName, spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end

		priority = analyzePrio(priority)
		if not MaoRUISetDB["RaidDebuffs"][instName] then MaoRUISetDB["RaidDebuffs"][instName] = {} end
		MaoRUISetDB["RaidDebuffs"][instName][spellID] = priority
		setupBars(instName)
		G:ClearEdit(options[3])
		G:ClearEdit(options[4])
	end

	local scroll = G:CreateScroll(frame, 240, 370)
	scroll.reset = M.CreateButton(frame, 70, 25, RESET)
	scroll.reset:SetPoint("TOPLEFT", 10, -120)
	StaticPopupDialogs["RESET_UI_RAIDDEBUFFS"] = {
		text = U["Reset to default list"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			MaoRUISetDB["RaidDebuffs"] = {}
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
				if not MaoRUISetDB["RaidDebuffs"][bar.instName] then MaoRUISetDB["RaidDebuffs"][bar.instName] = {} end
				MaoRUISetDB["RaidDebuffs"][bar.instName][bar.spellID] = 0
			else
				MaoRUISetDB["RaidDebuffs"][bar.instName][bar.spellID] = nil
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
			if not MaoRUISetDB["RaidDebuffs"][bar.instName] then MaoRUISetDB["RaidDebuffs"][bar.instName] = {} end
			MaoRUISetDB["RaidDebuffs"][bar.instName][bar.spellID] = prio
			self:SetText(prio)
		end)
		M.AddTooltip(prioBox, "ANCHOR_TOPRIGHT", U["Prio Editbox"], "info", true)
		bar.prioBox = prioBox

		return bar
	end

	local function applyData(index, instName, spellID, priority)
		local name, texture = GetSpellName(spellID), GetSpellTexture(spellID)
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
		local instName = tonumber(self) or self.text or self
		local index = 0

		if R.RaidDebuffs[instName] then
			for spellID, priority in pairs(R.RaidDebuffs[instName]) do
				if not (MaoRUISetDB["RaidDebuffs"][instName] and MaoRUISetDB["RaidDebuffs"][instName][spellID]) then
					index = index + 1
					applyData(index, instName, spellID, priority)
				end
			end
		end

		if MaoRUISetDB["RaidDebuffs"][instName] then
			for spellID, priority in pairs(MaoRUISetDB["RaidDebuffs"][instName]) do
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

	local keyToLocale = {
		["LMB"] = U["LeftButon"],
		["RMB"] = U["RightButton"],
		["MMB"] = U["MiddleButton"],
		["MB4"] = U["Button4"],
		["MB5"] = U["Button5"],
		["MWU"] = U["WheelUp"],
		["MWD"] = U["WheelDown"],
	}
	local textIndex, barTable = {
		["target"] = TARGET,
		["focus"] = SET_FOCUS,
		["follow"] = FOLLOW,
	}, {}

	local function createBar(parent, fullkey, value)
		local key = strsub(fullkey, -3)
		local modKey = strmatch(fullkey, "(.+)%-%w+")
		local texture
		if tonumber(value) then
			texture = GetSpellTexture(value)
		else
			value = textIndex[value] or value
			local itemID = strmatch(value, "item:(%d+)")
			if itemID then
				texture = C_Item.GetItemIconByID(itemID)
			else
				texture = 136243
			end
		end

		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		barTable[fullkey] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", value, "system")
		close:SetScript("OnClick", function()
			bar:Hide()
			MaoRUISetDB["ClickSets"][I.MyClass][fullkey] = nil
			barTable[fullkey] = nil
			sortBars(barTable)
		end)

		local key1 = M.CreateFS(bar, 14, keyToLocale[key], false, "LEFT", 30, 0)
		key1:SetTextColor(.6, .8, 1)
		if modKey then
			local key2 = M.CreateFS(bar, 14, modKey, false, "RIGHT", -25, 0)
			key2:SetTextColor(0, 1, 0)
		end

		sortBars(barTable)
	end

	local frame = panel.bg
	local keyList = {"LMB","RMB","MMB","MB4","MB5","MWU","MWD"}
	local options = {}

	local function optionOnEnter(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:ClearLines()
		GameTooltip:AddLine(keyToLocale[self.text], 1, .8, 0)
		GameTooltip:Show()
	end

	options[1] = G:CreateEditbox(frame, U["Action*"], 10, -30, U["Action Intro"], 260, 30)
	options[2] = G:CreateDropdown(frame, U["Key*"], 10, -90, keyList, U["Key Intro"], 120, 30)
	for i = 1, #keyList do
		options[2].options[i]:HookScript("OnEnter", optionOnEnter)
		options[2].options[i]:HookScript("OnLeave", M.HideTooltip)
	end
	options[3] = G:CreateDropdown(frame, U["Modified Key"], 170, -90, {NONE, "ALT", "CTRL", "SHIFT","ALT-CTRL","ALT-SHIFT","CTRL-SHIFT","ALT-CTRL-SHIFT"}, U["ModKey Intro"], 85, 30)

	local scroll = G:CreateScroll(frame, 240, 350)
	scroll.reset = M.CreateButton(frame, 70, 25, RESET)
	scroll.reset:SetPoint("TOPLEFT", 10, -140)
	StaticPopupDialogs["RESET_UI_CLICKSETS"] = {
		text = U["Reset your click sets?"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			wipe(MaoRUISetDB["ClickSets"][I.MyClass])
			ReloadUI()
		end,
		whileDead = 1,
	}
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_CLICKSETS")
	end)

	local function addClick(scroll, options)
		local value, key, modKey = options[1]:GetText(), options[2].Text:GetText(), options[3].Text:GetText()
		local numValue = tonumber(value)
		if not value or not key then UIErrorsFrame:AddMessage(I.InfoColor..U["Incomplete Input"]) return end
		if numValue and not GetSpellName(value) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		if (not numValue) and (not textIndex[value]) and not strmatch(value, "/") then UIErrorsFrame:AddMessage(I.InfoColor..U["Invalid Input"]) return end
		if not modKey or modKey == NONE then modKey = "" end
		local fullkey = (modKey == "" and key or modKey.."-"..key)
		if MaoRUISetDB["ClickSets"][I.MyClass][fullkey] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ClickSet"]) return end

		MaoRUISetDB["ClickSets"][I.MyClass][fullkey] = numValue or value
		createBar(scroll.child, fullkey, value)
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

	for fullkey, value in pairs(MaoRUISetDB["ClickSets"][I.MyClass]) do
		createBar(scroll.child, fullkey, value)
	end
end

local function refreshNameplateFilters()
	M:GetModule("UnitFrames"):RefreshNameplateFilters()
end

function G:SetupNameplateFilter(parent)
	local guiName = "UIGUI_NameplateFilter"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName)
	panel:SetScript("OnHide", refreshNameplateFilters)

	local frameData = {
		[1] = {text = U["WhiteList"].."*", offset = -5, barList = {}},
		[2] = {text = U["BlackList"].."*", offset = -295, barList = {}},
	}

	local function createBar(parent, index, spellID)
		local name, texture = GetSpellName(spellID), GetSpellTexture(spellID)
		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		frameData[index].barList[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID)
		close:SetScript("OnClick", function()
			bar:Hide()
			if index == 1 then
				if R.WhiteList[spellID] then
					MaoRUISetDB["NameplateWhite"][spellID] = false
				else
					MaoRUISetDB["NameplateWhite"][spellID] = nil
				end
			elseif index == 2 then
				if R.BlackList[spellID] then
					MaoRUISetDB["NameplateBlack"][spellID] = false
				else
					MaoRUISetDB["NameplateBlack"][spellID] = nil
				end
			end
			frameData[index].barList[spellID] = nil
			sortBars(frameData[index].barList)
		end)

		local spellName = M.CreateFS(bar, 14, name, false, "LEFT", 30, 0)
		spellName:SetWidth(180)
		spellName:SetJustifyH("LEFT")
		if index == 2 then spellName:SetTextColor(1, 0, 0) end

		sortBars(frameData[index].barList)
	end

	local function isAuraExisted(index, spellID)
		local key = index == 1 and "NameplateWhite" or "NameplateBlack"
		local modValue = MaoRUISetDB[key][spellID]
		local locValue = (index == 1 and R.WhiteList[spellID]) or (index == 2 and R.BlackList[spellID])
		return modValue or (modValue == nil and locValue)
	end

	local function addClick(parent, index)
		local spellID = tonumber(parent.box:GetText())
		if not spellID or not GetSpellName(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		if isAuraExisted(index, spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end

		local key = index == 1 and "NameplateWhite" or "NameplateBlack"
		MaoRUISetDB[key][spellID] = true
		createBar(parent.child, index, spellID)
		parent.box:SetText("")
	end

	local UF = M:GetModule("UnitFrames")

	local filterIndex
	StaticPopupDialogs["RESET_UI_NAMEPLATEFILTER"] = {
		text = U["Reset to default list"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			local key = filterIndex == 1 and "NameplateWhite" or "NameplateBlack"
			wipe(MaoRUISetDB[key])
			ReloadUI()
		end,
		whileDead = 1,
	}

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

		scroll.reset = M.CreateButton(frame, 45, 25, RESET)
		scroll.reset:SetPoint("RIGHT", scroll.add, "LEFT", -5, 0)
		scroll.reset:SetScript("OnClick", function()
			filterIndex = index
			StaticPopup_Show("RESET_UI_NAMEPLATEFILTER")
		end)

		local key = index == 1 and "NameplateWhite" or "NameplateBlack"
		for spellID, value in pairs(UF[key]) do
			if value then
				createBar(scroll.child, index, spellID)
			end
		end
	end
end

local function updateCornerSpells()
	M:GetModule("UnitFrames"):UpdateCornerSpells()
end

function G:SetupSpellsIndicator(parent)
	local guiName = "UIGUI_SpellsIndicator"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["BuffIndicator"].."*")
	panel:SetScript("OnHide", updateCornerSpells)

	local barList = {}

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

	local function createBar(parent, spellID, anchor, r, g, b, showAll)
		local name, texture = GetSpellName(spellID), GetSpellTexture(spellID)
		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		barList[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID)
		close:SetScript("OnClick", function()
			bar:Hide()
			local value = R.CornerBuffs[I.MyClass][spellID]
			if value then
				MaoRUISetDB["CornerSpells"][I.MyClass][spellID] = {}
			else
				MaoRUISetDB["CornerSpells"][I.MyClass][spellID] = nil
			end
			barList[spellID] = nil
			sortBars(barList)
		end)

		name = U[anchor] or name
		local text = M.CreateFS(bar, 14, name, false, "LEFT", 30, 0)
		text:SetWidth(180)
		text:SetJustifyH("LEFT")
		if anchor then text:SetTextColor(r, g, b) end
		if showAll then M.CreateFS(bar, 14, "ALL", false, "RIGHT", -30, 0) end

		sortBars(barList)
	end

	local function addClick(parent)
		local spellID = tonumber(parent.box:GetText())
		if not spellID or not GetSpellName(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		local anchor, r, g, b, showAll
		anchor, r, g, b = parent.dd.Text:GetText(), parent.swatch.tex:GetColor()
		showAll = parent.showAll:GetChecked() or nil
		local modValue = MaoRUISetDB["CornerSpells"][I.MyClass][spellID]
		if (modValue and next(modValue)) or (R.CornerBuffs[I.MyClass][spellID] and not modValue) then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end
		anchor = decodeAnchor[anchor]
		MaoRUISetDB["CornerSpells"][I.MyClass][spellID] = {anchor, {r, g, b}, showAll}
		createBar(parent.child, spellID, anchor, r, g, b, showAll)
		parent.box:SetText("")
	end

	StaticPopupDialogs["RESET_UI_RaidBuffsWhite"] = {
		text = U["Reset to default list"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			wipe(MaoRUISetDB["CornerSpells"][I.MyClass])
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

	local frame = CreateFrame("Frame", nil, panel, "BackdropTemplate")
	frame:SetSize(280, 540)
	frame:SetPoint("TOPLEFT", 10, -50)
	M.CreateBD(frame, .25)

	local scroll = G:CreateScroll(frame, 240, 485)
	scroll.box = M.CreateEditBox(frame, 50, 25)
	scroll.box:SetPoint("TOPLEFT", 10, -10)
	scroll.box:SetMaxLetters(6)
	M.AddTooltip(scroll.box, "ANCHOR_TOPRIGHT", U["ID Intro"], "info", true)

	scroll.add = M.CreateButton(frame, 45, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -8, -10)
	scroll.add:SetScript("OnClick", function()
		addClick(scroll)
	end)

	scroll.reset = M.CreateButton(frame, 45, 25, RESET)
	scroll.reset:SetPoint("RIGHT", scroll.add, "LEFT", -5, 0)
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_RaidBuffsWhite")
	end)

	scroll.dd = M.CreateDropDown(frame, 60, 25, anchors)
	scroll.dd:SetPoint("TOPLEFT", 10, -10)
	scroll.dd.options[1]:Click()

	for i = 1, 8 do
		scroll.dd.options[i]:HookScript("OnEnter", optionOnEnter)
		scroll.dd.options[i]:HookScript("OnLeave", M.HideTooltip)
	end
	scroll.box:SetPoint("TOPLEFT", scroll.dd, "TOPRIGHT", 5, 0)

	local swatch = M.CreateColorSwatch(frame)
	swatch:SetPoint("LEFT", scroll.box, "RIGHT", 5, 0)
	scroll.swatch = swatch

	local showAll = M.CreateCheckBox(frame)
	showAll:SetPoint("LEFT", swatch, "RIGHT", 2, 0)
	showAll:SetHitRectInsets(0, 0, 0, 0)
	showAll.bg:SetBackdropBorderColor(1, .8, 0, .5)
	M.AddTooltip(showAll, "ANCHOR_TOPRIGHT", U["ShowAllTip"], "info", true)
	scroll.showAll = showAll

	local UF = M:GetModule("UnitFrames")
	for spellID, value in pairs(UF.CornerSpells) do
		local r, g, b = unpack(value[2])
		createBar(scroll.child, spellID, value[1], r, g, b, value[3])
	end
end

local function refreshBuffsIndicator()
	M:GetModule("UnitFrames"):UpdateRaidBuffsWhite()
end

function G:SetupBuffsIndicator(parent)
	local guiName = "UIGUI_BuffsIndicator"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["WhiteList"].."*")
	panel:SetScript("OnHide", refreshBuffsIndicator)

	local barList = {}

	local function createBar(parent, spellID, isNew)
		local name, texture = GetSpellName(spellID), GetSpellTexture(spellID)
		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		barList[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID)
		close:SetScript("OnClick", function()
			bar:Hide()
			if R.RaidBuffsWhite[spellID] then
				MaoRUISetDB["RaidBuffsWhite"][spellID] = false
			else
				MaoRUISetDB["RaidBuffsWhite"][spellID] = nil
			end
			barList[spellID] = nil
			sortBars(barList)
		end)

		local spellName = M.CreateFS(bar, 14, name, false, "LEFT", 30, 0)
		spellName:SetWidth(180)
		spellName:SetJustifyH("LEFT")
		if isNew then spellName:SetTextColor(0, 1, 0) end

		sortBars(barList)
	end

	local function isAuraExisted(spellID)
		local modValue = MaoRUISetDB["RaidBuffsWhite"][spellID]
		local locValue = R.RaidBuffsWhite[spellID]
		return modValue or (modValue == nil and locValue)
	end

	local function addClick(parent)
		local spellID = tonumber(parent.box:GetText())
		if not spellID or not GetSpellName(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		if isAuraExisted(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end

		MaoRUISetDB["RaidBuffsWhite"][spellID] = true
		createBar(parent.child, spellID, true)
		parent.box:SetText("")
	end

	StaticPopupDialogs["RESET_UI_BUFFS_WHITE"] = {
		text = U["Reset to default list"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			wipe(MaoRUISetDB["RaidBuffsWhite"])
			ReloadUI()
		end,
		whileDead = 1,
	}

	local frame = CreateFrame("Frame", nil, panel, "BackdropTemplate")
	frame:SetSize(280, 540)
	frame:SetPoint("TOPLEFT", 10, -50)
	M.CreateBD(frame, .25)

	local scroll = G:CreateScroll(frame, 240, 485)
	scroll.box = M.CreateEditBox(frame, 160, 25)
	scroll.box:SetPoint("TOPLEFT", 10, -10)
	M.AddTooltip(scroll.box, "ANCHOR_TOPRIGHT", U["ID Intro"], "info", true)

	scroll.add = M.CreateButton(frame, 45, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -8, -10)
	scroll.add:SetScript("OnClick", function()
		addClick(scroll)
	end)

	scroll.reset = M.CreateButton(frame, 45, 25, RESET)
	scroll.reset:SetPoint("RIGHT", scroll.add, "LEFT", -5, 0)
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_BUFFS_WHITE")
	end)

	local UF = M:GetModule("UnitFrames")
	for spellID, value in pairs(UF.RaidBuffsWhite) do
		if value then
			createBar(scroll.child, spellID)
		end
	end

	local box = M.CreateCheckBox(frame)
	box:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, 5)
	box:SetChecked(R.db["UFs"]["AutoBuffs"])
	box:SetHitRectInsets(-50, 0, 0, 0)
	box:SetScript("OnClick", function()
		R.db["UFs"]["AutoBuffs"] = box:GetChecked()
	end)
	local text = M.CreateFS(box, 24, "|cffff0000???")
	text:ClearAllPoints()
	text:SetPoint("RIGHT", box, "LEFT")
	M.AddTooltip(box, "ANCHOR_TOPRIGHT", U["AutoBuffsTip"], "info", true)
end

local function refreshDebuffsIndicator()
	M:GetModule("UnitFrames"):UpdateRaidDebuffsBlack()
end

function G:SetupDebuffsIndicator(parent)
	local guiName = "UIGUI_DebuffsIndicator"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["BlackList"].."*")
	panel:SetScript("OnHide", refreshDebuffsIndicator)

	local barList = {}

	local function createBar(parent, spellID, isNew)
		local name, texture = GetSpellName(spellID), GetSpellTexture(spellID)
		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		barList[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID)
		close:SetScript("OnClick", function()
			bar:Hide()
			if R.RaidDebuffsBlack[spellID] then
				MaoRUISetDB["RaidDebuffsBlack"][spellID] = false
			else
				MaoRUISetDB["RaidDebuffsBlack"][spellID] = nil
			end
			barList[spellID] = nil
			sortBars(barList)
		end)

		local spellName = M.CreateFS(bar, 14, name, false, "LEFT", 30, 0)
		spellName:SetWidth(180)
		spellName:SetJustifyH("LEFT")
		if isNew then spellName:SetTextColor(0, 1, 0) end

		sortBars(barList)
	end

	local function isAuraExisted(spellID)
		local modValue = MaoRUISetDB["RaidDebuffsBlack"][spellID]
		local locValue = R.RaidDebuffsBlack[spellID]
		return modValue or (modValue == nil and locValue)
	end

	local function addClick(parent)
		local spellID = tonumber(parent.box:GetText())
		if not spellID or not GetSpellName(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		if isAuraExisted(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end

		MaoRUISetDB["RaidDebuffsBlack"][spellID] = true
		createBar(parent.child, spellID, true)
		parent.box:SetText("")
	end

	StaticPopupDialogs["RESET_UI_DEBUFFS_BLACK"] = {
		text = U["Reset to default list"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			wipe(MaoRUISetDB["RaidDebuffsBlack"])
			ReloadUI()
		end,
		whileDead = 1,
	}

	local frame = CreateFrame("Frame", nil, panel, "BackdropTemplate")
	frame:SetSize(280, 540)
	frame:SetPoint("TOPLEFT", 10, -50)
	M.CreateBD(frame, .25)

	local scroll = G:CreateScroll(frame, 240, 485)
	scroll.box = M.CreateEditBox(frame, 160, 25)
	scroll.box:SetPoint("TOPLEFT", 10, -10)
	M.AddTooltip(scroll.box, "ANCHOR_TOPRIGHT", U["ID Intro"], "info", true)

	scroll.add = M.CreateButton(frame, 45, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -8, -10)
	scroll.add:SetScript("OnClick", function()
		addClick(scroll)
	end)

	scroll.reset = M.CreateButton(frame, 45, 25, RESET)
	scroll.reset:SetPoint("RIGHT", scroll.add, "LEFT", -5, 0)
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_DEBUFFS_BLACK")
	end)

	local UF = M:GetModule("UnitFrames")
	for spellID, value in pairs(UF.RaidDebuffsBlack) do
		if value then
			createBar(scroll.child, spellID)
		end
	end
end

local function createOptionTitle(parent, title, offset)
	M.CreateFS(parent, 14, title, "system", "TOP", 0, offset)
	local line = M.SetGradient(parent, "H", 1, 1, 1, .25, .25, 200, R.mult)
	line:SetPoint("TOPLEFT", 30, offset-20)
end

local function toggleOptionCheck(self)
	R.db[self.__key][self.__value] = self:GetChecked()
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
	local nameOffset = R.db["UFs"][unit.."NameOffset"]
	local powerOffset = R.db["UFs"][unit.."PowerOffset"]
	local height = powerHeight == 0 and healthHeight or healthHeight + powerHeight + R.mult
	self:SetSize(width, height)
	self.Health:SetHeight(healthHeight)
	if self.nameText and nameOffset then
		self.nameText:SetPoint("LEFT", 3, nameOffset)
		self.nameText:SetWidth(self:GetWidth()*(nameOffset == 0 and .55 or 1))
	end
	if powerHeight == 0 then
		if self:IsElementEnabled("Power") then
			self:DisableElement("Power")
			if self.powerText then self.powerText:Hide() end
		end
	else
		if not self:IsElementEnabled("Power") then
			self:EnableElement("Power")
			self.Power:ForceUpdate()
			if self.powerText then self.powerText:Show() end
		end
		self.Power:SetHeight(powerHeight)
		if self.powerText and powerOffset then
			self.powerText:SetPoint("RIGHT", -3, powerOffset)
		end
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

	local defaultValue = { -- healthWidth, healthHeight, powerHeight, healthTag, powerTag, powerOffset, nameOffset
		["Player"] = {245, 24, 4, 2, 4, 2, 0},
		["Focus"] = {200, 22, 3, 2, 4, 2, 0},
		["Pet"] = {100, 18, 2, 5, 0},
		["Boss"] = {120, 21, 3, 5, 5, 2, 0},
	}

	local function createOptionGroup(parent, offset, value, func)
		createOptionTitle(parent, "", offset)
		createOptionDropdown(parent, U["HealthValueType"], offset-50, G.HealthValues, U["100PercentTip"], "UFs", value.."HPTag", defaultValue[value][4], func)
		local mult = 0
		if value ~= "Pet" then
			mult = 60
			createOptionDropdown(parent, U["PowerValueType"], offset-50-mult, G.HealthValues, U["100PercentTip"], "UFs", value.."MPTag", defaultValue[value][5], func)
		end
		createOptionSlider(parent, U["Width"], sliderRange[value][1], sliderRange[value][2], defaultValue[value][1], offset-110-mult, value.."Width", func)
		createOptionSlider(parent, U["Height"], 15, 50, defaultValue[value][2], offset-180-mult, value.."Height", func)
		createOptionSlider(parent, U["Power Height"], 0, 30, defaultValue[value][3], offset-250-mult, value.."PowerHeight", func)
		if value ~= "Pet" then
			createOptionSlider(parent, U["Power Offset"], -20, 20, defaultValue[value][6], offset-320-mult, value.."PowerOffset", func)
			createOptionSlider(parent, U["Name Offset"], -50, 50, defaultValue[value][7], offset-390-mult, value.."NameOffset", func)
		else
			createOptionSlider(parent, U["Name Offset"], -20, 20, defaultValue[value][5], offset-320-mult, value.."NameOffset", func)
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

	local function updateFocusSize()
		local frame = _G.oUF_Focus
		if frame then
			SetUnitFrameSize(frame, "Focus")
			UF.UpdateFrameHealthTag(frame)
			UF.UpdateFramePowerTag(frame)
		end
	end

	local subFrames = {_G.oUF_Pet, _G.oUF_ToT, _G.oUF_FocusTarget}
	local function updatePetSize()
		for _, frame in pairs(subFrames) do
			SetUnitFrameSize(frame, "Pet")
			UF.UpdateFrameHealthTag(frame)
		end
	end

	local function updateBossSize()
		for _, frame in pairs(ns.oUF.objects) do
			if frame.mystyle == "boss" or frame.mystyle == "arena" then
				SetUnitFrameSize(frame, "Boss")
				UF.UpdateFrameHealthTag(frame)
				UF.UpdateFramePowerTag(frame)
			end
		end
	end

	local options = {
		[1] = U["Player&Target"],
		[2] = U["FocusUF"],
		[3] = U["Pet&*Target"],
		[4] = U["Boss&Arena"],
	}
	local data = {
		[1] = {"Player", updatePlayerSize},
		[2] = {"Focus", updateFocusSize},
		[3] = {"Pet", updatePetSize},
		[4] = {"Boss", updateBossSize},
	}

	local dd = G:CreateDropdown(scroll.child, "", 40, -15, options, nil, 180, 28)
	dd:SetFrameLevel(20)
	dd.Text:SetText(options[1])
	dd:SetBackdropBorderColor(1, .8, 0, .5)
	dd.panels = {}

	for i = 1, #options do
		local panel = CreateFrame("Frame", nil, scroll.child)
		panel:SetSize(260, 1)
		panel:SetPoint("TOP", 0, -30)
		panel:Hide()
		createOptionGroup(panel, -10, data[i][1], data[i][2])

		dd.panels[i] = panel
		dd.options[i]:HookScript("OnClick", toggleOptionsPanel)
	end
	toggleOptionsPanel(dd.options[1])
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

function G:SetupCastbar(parent)
	local guiName = "UIGUI_CastbarSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["Castbar Settings"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	createOptionTitle(scroll.child, U["Castbar Colors"], -10)
	createOptionSwatch(scroll.child, U["PlayerCastingColor"], "UFs", "OwnCastColor", 40, -40)
	createOptionSwatch(scroll.child, U["Interruptible Color"], "UFs", "CastingColor", 40, -70)
	createOptionSwatch(scroll.child, U["NotInterruptible Color"], "UFs", "NotInterruptColor", 40, -100)

	local defaultValue = {
		["Player"] = {310, 18},
		["Target"] = {280, 18},
		["Focus"] = {320, 18},
	}

	local UF = M:GetModule("UnitFrames")

	local function toggleCastbar(self)
		local value = self.__value.."CB"
		R.db["UFs"][value] = not R.db["UFs"][value]
		self:SetChecked(R.db["UFs"][value])
		UF.ToggleCastBar(_G["oUF_"..self.__value], self.__value)
	end

	local function createOptionGroup(parent, title, offset, value, func)
		local box = M.CreateCheckBox(parent)
		box:SetPoint("TOPLEFT", parent, 30, offset + 6)
		box:SetChecked(R.db["UFs"][value.."CB"])
		box.__value = value
		box:SetScript("OnClick", toggleCastbar)
		M.AddTooltip(box, "ANCHOR_RIGHT", U["ToggleCastbarTip"], "info", true)

		createOptionTitle(parent, title, offset)
		createOptionSlider(parent, U["Width"], 100, 800, defaultValue[value][1], offset-60, value.."CBWidth", func)
		createOptionSlider(parent, U["Height"], 10, 50, defaultValue[value][2], offset-130, value.."CBHeight", func)
	end

	local function updatePlayerCastbar()
		local castbar = _G.oUF_Player and _G.oUF_Player.Castbar
		if castbar then
			local width, height = R.db["UFs"]["PlayerCBWidth"], R.db["UFs"]["PlayerCBHeight"]
			castbar:SetSize(width, height)
			castbar.Icon:SetSize(height, height)
			castbar.mover:Show()
			castbar.mover:SetSize(width+height+5, height+5)
		end
	end
	createOptionGroup(scroll.child, U["Player Castbar"], -170, "Player", updatePlayerCastbar)

	local function updateTargetCastbar()
		local castbar = _G.oUF_Target and _G.oUF_Target.Castbar
		if castbar then
			local width, height = R.db["UFs"]["TargetCBWidth"], R.db["UFs"]["TargetCBHeight"]
			castbar:SetSize(width, height)
			castbar.Icon:SetSize(height, height)
			castbar.mover:Show()
			castbar.mover:SetSize(width+height+5, height+5)
		end
	end
	createOptionGroup(scroll.child, U["Target Castbar"], -390, "Target", updateTargetCastbar)

	local function updateFocusCastbar()
		local castbar = _G.oUF_Focus and _G.oUF_Focus.Castbar
		if castbar then
			local width, height = R.db["UFs"]["FocusCBWidth"], R.db["UFs"]["FocusCBHeight"]
			castbar:SetSize(width, height)
			castbar.Icon:SetSize(height, height)
			castbar.mover:Show()
			castbar.mover:SetSize(width+height+5, height+5)
		end
	end
	createOptionGroup(scroll.child, U["Focus Castbar"], -610, "Focus", updateFocusCastbar)

	panel:HookScript("OnHide", function()
		local playerCB = _G.oUF_Player and _G.oUF_Player.Castbar
		if playerCB then
			playerCB.mover:Hide()
		end
		local targetCB = _G.oUF_Target and _G.oUF_Target.Castbar
		if targetCB then
			targetCB.mover:Hide()
		end
		local focusCB = _G.oUF_Focus and _G.oUF_Focus.Castbar
		if focusCB then
			focusCB.mover:Hide()
		end
	end)
end

function G:SetupSwingBars(parent)
	local guiName = "UIGUI_SwingSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["UFs SwingBar"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local parent, offset = scroll.child, -10
	local frame = _G.oUF_Player

	local function configureSwingBars()
		if not frame then return end

		local width, height = R.db["UFs"]["SwingWidth"], R.db["UFs"]["SwingHeight"]
		local swing = frame.Swing
		swing:SetSize(width, height)
		swing.Offhand:SetHeight(height)
		swing.mover:SetSize(width, height)
		swing.mover:Show()

		swing.Text:SetShown(R.db["UFs"]["SwingTimer"])
		swing.TextMH:SetShown(R.db["UFs"]["SwingTimer"])
		swing.TextOH:SetShown(R.db["UFs"]["SwingTimer"])

		swing.Offhand:ClearAllPoints()
		if R.db["UFs"]["OffOnTop"] then
			swing.Offhand:SetPoint("BOTTOMLEFT", swing, "TOPLEFT", 0, 3)
			swing.Offhand:SetPoint("BOTTOMRIGHT", swing, "TOPRIGHT", 0, 3)
		else
			swing.Offhand:SetPoint("TOPLEFT", swing, "BOTTOMLEFT", 0, -3)
			swing.Offhand:SetPoint("TOPRIGHT", swing, "BOTTOMRIGHT", 0, -3)
		end
	end

	createOptionCheck(parent, offset, U["UFs SwingTimer"], "UFs", "SwingTimer", configureSwingBars, U["SwingTimer Tip"])
	createOptionCheck(parent, offset-35, U["OffhandOnTop"], "UFs", "OffOnTop", configureSwingBars)
	createOptionSlider(parent, U["Width"], 50, 1000, 275, offset-105, "SwingWidth", configureSwingBars)
	createOptionSlider(parent, U["Height"], 1, 50, 3, offset-175, "SwingHeight", configureSwingBars)

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
		[12] = "FilterStone",
		[13] = "FilterAOE",
		[14] = "FilterLower",
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
		local spellName, texture = GetSpellName(spellID), GetSpellTexture(spellID)

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
				MaoRUISetDB["MajorSpells"][spellID] = false
			else
				MaoRUISetDB["MajorSpells"][spellID] = nil
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
	scroll.box = M.CreateEditBox(frame, 160, 30)
	scroll.box:SetPoint("TOPLEFT", 10, -10)
	M.AddTooltip(scroll.box, "ANCHOR_TOPRIGHT", U["ID Intro"], "info", true)

	local function addClick(button)
		local parent = button.__owner
		local spellID = tonumber(parent.box:GetText())
		if not spellID or not GetSpellName(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		local modValue = MaoRUISetDB["MajorSpells"][spellID]
		if modValue or modValue == nil and R.MajorSpells[spellID] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end
		MaoRUISetDB["MajorSpells"][spellID] = true
		createBar(parent.child, spellID)
		parent.box:SetText("")
	end
	scroll.add = M.CreateButton(frame, 45, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -8, -10)
	scroll.add.__owner = scroll
	scroll.add:SetScript("OnClick", addClick)

	scroll.reset = M.CreateButton(frame, 45, 25, RESET)
	scroll.reset:SetPoint("RIGHT", scroll.add, "LEFT", -5, 0)
	StaticPopupDialogs["RESET_UI_MAJORSPELLS"] = {
		text = U["Reset to default list"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			MaoRUISetDB["MajorSpells"] = {}
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
		["enemy"] = {"PlateWidth", "PlateHeight", "NameTextSize","HealthTextSize", "HealthTextOffset", "PlateCBHeight", "CBTextSize", "PlateCBOffset", "HarmWidth", "HarmHeight", "NameTextOffset"},
		["friend"] = {"FriendPlateWidth", "FriendPlateHeight", "FriendNameSize","FriendHealthSize", "FriendHealthOffset", "FriendPlateCBHeight", "FriendCBTextSize", "FriendPlateCBOffset", "HelpWidth", "HelpHeight", "FriendNameOffset"},
	}
	local function createOptionGroup(parent, offset, value, func, isEnemy)
		createOptionTitle(parent, "", offset)
		createOptionSlider(parent, U["Width"], 50, 500, 190, offset-60, optionValues[value][1], func, "Nameplate")
		createOptionSlider(parent, U["Height"], 5, 50, 8, offset-130, optionValues[value][2], func, "Nameplate")
		createOptionSlider(parent, U["InteractWidth"], 50, 500, 190, offset-200, optionValues[value][9], func, "Nameplate")
		createOptionSlider(parent, U["InteractHeight"], 5, 50, 8, offset-270, optionValues[value][10], func, "Nameplate")
		createOptionSlider(parent, U["NameTextSize"], 10, 50, 14, offset-340, optionValues[value][3], func, "Nameplate")
		createOptionSlider(parent, U["Name Offset"], -100, 50, 5, offset-410, optionValues[value][11], func, "Nameplate")
		createOptionSlider(parent, U["HealthTextSize"], 10, 50, 16, offset-480, optionValues[value][4], func, "Nameplate")
		createOptionSlider(parent, U["Health Offset"], -50, 50, 5, offset-550, optionValues[value][5], func, "Nameplate")
		createOptionSlider(parent, U["Castbar Height"], 5, 50, 8, offset-620, optionValues[value][6], func, "Nameplate")
		createOptionSlider(parent, U["CastbarTextSize"], 10, 50, 14, offset-690, optionValues[value][7], func, "Nameplate")
		createOptionSlider(parent, U["CastbarTextOffset"], -50, 50, -1, offset-760, optionValues[value][8], func, "Nameplate")
		if isEnemy then
			createOptionSlider(parent, U["RaidTargetX"], -50, 500, 0, offset-830, "RaidTargetX", func, "Nameplate")
			createOptionSlider(parent, U["RaidTargetY"], -200, 200, 3, offset-900, "RaidTargetY", func, "Nameplate")
		end
	end

	local UF = M:GetModule("UnitFrames")
	local options = {
		[1] = U["HostileNameplate"],
		[2] = U["FriendlyNameplate"],
	}

	local dd = G:CreateDropdown(scroll.child, "", 40, -15, options, nil, 180, 28)
	dd:SetFrameLevel(20)
	dd.Text:SetText(options[1])
	dd:SetBackdropBorderColor(1, .8, 0, .5)
	dd.panels = {}

	for i = 1, #options do
		local panel = CreateFrame("Frame", nil, scroll.child)
		panel:SetSize(260, 1)
		panel:SetPoint("TOP", 0, -30)
		panel:Hide()
		if i == 1 then
			createOptionGroup(panel, -10, "enemy", UF.RefreshAllPlates, true)
		else
			createOptionGroup(panel, -10, "friend", UF.RefreshAllPlates)
		end

		dd.panels[i] = panel
		dd.options[i]:HookScript("OnClick", toggleOptionsPanel)
	end
	toggleOptionsPanel(dd.options[1])
end

function G:SetupNameOnlySize(parent)
	local guiName = "UIGUI_NameOnlySetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["NameOnlyMode"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)
	local parent, offset = scroll.child, -10

	local UF = M:GetModule("UnitFrames")
	createOptionCheck(parent, offset, U["ShowNPCTitle"], "Nameplate", "NameOnlyTitle", UF.RefreshAllPlates)
	createOptionCheck(parent, offset-35, U["ShowUnitGuild"], "Nameplate", "NameOnlyGuild", UF.RefreshAllPlates)
	createOptionSlider(parent, U["NameTextSize"], 10, 50, 14, offset-105, "NameOnlyTextSize", UF.RefreshAllPlates, "Nameplate")
	createOptionSlider(parent, U["TitleTextSize"], 10, 50, 12, offset-175, "NameOnlyTitleSize", UF.RefreshAllPlates, "Nameplate")
end

function G:SetupActionBar(parent)
	local guiName = "UIGUI_ActionBarSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["ActionbarSetup"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local Bar = M:GetModule("Actionbar")
	local defaultValues = {
		-- defaultSize, minButtons, maxButtons, defaultButtons, defaultPerRow, flyoutDirec
		["Bar1"] = {35, 6, 12, 12, 12, "UP"},
		["Bar2"] = {35, 1, 12, 12, 12, "UP"},
		["Bar3"] = {35, 1, 12, 12, 6, "UP"},
		["Bar4"] = {35, 1, 12, 12, 6, "UP"},
		["Bar5"] = {35, 1, 12, 12, 12, "LEFT"},
		["Bar6"] = {35, 1, 12, 12, 1, "LEFT"},
		["Bar7"] = {35, 1, 12, 12, 1, "UP"},
		["Bar8"] = {35, 1, 12, 12, 12, "UP"},
		["BarPet"] = {26, 1, 10, 10, 10},
	}
	local directions = {U["GO_UP"], U["GO_DOWN"], U["GO_LEFT"], U["GO_RIGHT"]}
	local function toggleBar(self)
		R.db["Actionbar"][self.__value] = self:GetChecked()
		Bar:UpdateVisibility()
	end
	local function createOptionGroup(parent, offset, value, color)
		if value ~= "BarPet" then
			local box = M.CreateCheckBox(parent)
			box:SetPoint("TOPLEFT", parent, 10, offset + 25)
			box:SetChecked(R.db["Actionbar"][value])
			--box.bg:SetBackdropBorderColor(1, .8, 0, .5)
			box.__value = value
			box:SetScript("OnClick", toggleBar)
			M.AddTooltip(box, "ANCHOR_RIGHT", U["ToggleActionbarTip"], "info", true)
		end

		color = color or ""
		local data = defaultValues[value]
		local function updateBarScale()
			Bar:UpdateActionSize(value)
		end
		createOptionTitle(parent, "", offset)
		createOptionSlider(parent, U["ButtonSize"], 20, 80, data[1], offset-60, value.."Size", updateBarScale, "Actionbar")
		createOptionSlider(parent, U["ButtonsPerRow"], 1, data[3], data[5], offset-130, value.."PerRow", updateBarScale, "Actionbar")
		createOptionSlider(parent, U["ButtonFontSize"], 8, 20, 12, offset-200, value.."Font", updateBarScale, "Actionbar")
		if value ~= "BarPet" then
			createOptionSlider(parent, color..U["MaxButtons"], data[2], data[3], data[4], offset-270, value.."Num", updateBarScale, "Actionbar")
			createOptionDropdown(parent, U["GrowthDirection"], offset-340, directions, nil, "Actionbar", value.."Flyout", data[6], Bar.UpdateBarConfig)
		end
	end

	local options = {}
	for i = 1, 8 do
		tinsert(options, U["Actionbar"]..i)
	end
	tinsert(options, U["Pet Actionbar"]) -- 9
	tinsert(options, U["LeaveVehicle"]) -- 10

	local dd = G:CreateDropdown(scroll.child, "", 40, -15, options, nil, 180, 28)
	dd:SetFrameLevel(20)
	dd.Text:SetText(options[1])
	dd:SetBackdropBorderColor(1, .8, 0, .5)
	dd.panels = {}

	for i = 1, #options do
		local panel = CreateFrame("Frame", nil, scroll.child)
		panel:SetSize(260, 1)
		panel:SetPoint("TOP", 0, -30)
		panel:Hide()
		if i == 9 then
			createOptionGroup(panel, -10, "BarPet")
		elseif i == 10 then
			createOptionTitle(panel, "", -10)
			createOptionSlider(panel, U["ButtonSize"], 20, 80, 34, -70, "VehButtonSize", Bar.UpdateVehicleButton, "Actionbar")
		else
			createOptionGroup(panel, -10, "Bar"..i)
		end

		dd.panels[i] = panel
		dd.options[i]:HookScript("OnClick", toggleOptionsPanel)
	end
	toggleOptionsPanel(dd.options[1])
end

function G:SetupMicroMenu(parent)
	local guiName = "UIGUI_MicroMenuSetup"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["Menubar"].."*")
	local scroll = G:CreateScroll(panel, 260, 540)

	local Bar = M:GetModule("Actionbar")
	local parent, offset = scroll.child, -10
	createOptionTitle(parent, U["Menubar"], offset)
	createOptionSlider(parent, U["ButtonSize"], 20, 40, 22, offset-60, "MBSize", Bar.MicroMenu_Setup, "Actionbar")
	createOptionSlider(parent, U["ButtonsPerRow"], 1, 12, 12, offset-130, "MBPerRow", Bar.MicroMenu_Setup, "Actionbar")
	createOptionSlider(parent, U["Spacing"], -10, 10, 5, offset-200, "MBSpacing", Bar.MicroMenu_Setup, "Actionbar")
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
	local growthOptions = {}
	for i = 1, 4 do
		growthOptions[i] = UF.AuraDirections[i].name
	end

	local function createOptionGroup(parent, offset, value, func, isBoss)
		local default = defaultData[value]
		createOptionTitle(parent, "", offset)
		if isBoss then
			offset = offset + 130
		else
			createOptionDropdown(parent, U["GrowthDirection"], offset-50, growthOptions, "", "UFs", value.."AuraDirec", 1, func)
			createOptionSlider(parent, U["yOffset"], 0, 200, 10, offset-110, value.."AuraOffset", func)
		end
		createOptionDropdown(parent, U["BuffType"], offset-180, buffOptions, nil, "UFs", value.."BuffType", default[1], func)
		createOptionDropdown(parent, U["DebuffType"], offset-240, debuffOptions, nil, "UFs", value.."DebuffType", default[2], func)
		createOptionSlider(parent, U["MaxBuffs"], 1, 40, default[4], offset-300, value.."NumBuff", func)
		createOptionSlider(parent, U["MaxDebuffs"], 1, 40, default[5], offset-370, value.."NumDebuff", func)
		if isBoss then
			createOptionSlider(parent, "Buff "..U["IconsPerRow"], 5, 20, default[3], offset-440, value.."BuffPerRow", func)
			createOptionSlider(parent, "Debuff "..U["IconsPerRow"], 5, 20, default[3], offset-510, value.."DebuffPerRow", func)
		else
			createOptionSlider(parent, U["IconsPerRow"], 5, 20, default[3], offset-440, value.."AurasPerRow", func)
		end
	end

	createOptionTitle(parent, GENERAL, offset)
	createOptionCheck(parent, offset-35, U["DesaturateIcon"], "UFs", "Desaturate", UF.UpdateUFAuras, U["DesaturateIconTip"])
	createOptionCheck(parent, offset-70, U["DebuffColor"], "UFs", "DebuffColor", UF.UpdateUFAuras, U["DebuffColorTip"])

	local options = {
		[1] = U["PlayerUF"],
		[2] = U["TargetUF"],
		[3] = U["TotUF"],
		[4] = U["PetUF"],
		[5] = U["FocusUF"],
		[6] = U["BossFrame"],
	}
	local data = {
		[1] = "Player",
		[2] = "Target",
		[3] = "ToT",
		[4] = "Pet",
		[5] = "Focus",
		[6] = "Boss",
	}

	local dd = G:CreateDropdown(scroll.child, "", 40, -135, options, nil, 180, 28)
	dd:SetFrameLevel(20)
	dd.Text:SetText(options[1])
	dd:SetBackdropBorderColor(1, .8, 0, .5)
	dd.panels = {}

	for i = 1, #options do
		local panel = CreateFrame("Frame", nil, scroll.child)
		panel:SetSize(260, 1)
		panel:SetPoint("TOP", 0, -30)
		panel:Hide()
		createOptionGroup(panel, -130, data[i], UF.UpdateUFAuras, i == 6)

		dd.panels[i] = panel
		dd.options[i]:HookScript("OnClick", toggleOptionsPanel)
	end
	toggleOptionsPanel(dd.options[1])
end

function G:SetupActionbarStyle(parent)
	local maxButtons = 6
	local size, padding = 80, 2

	local frame = CreateFrame("Frame", "UIActionbarStyleFrame", parent.child)
	frame:SetSize((size+padding)*maxButtons + padding, size + 2*padding)
	frame:SetPoint("TOP", 160, -10)
	--M.CreateBDFrame(frame, .25)

	local Bar = M:GetModule("Actionbar")

	local styleString = {
		[1] = "NAB:35:12:12:12:35:12:12:12:35:12:12:6:35:12:12:6:35:12:12:1:35:12:12:1:35:12:4:1:35:12:12:4:26:12:10:30:12:10:0M0:0M37:333M1:-333M1:-1BR318:-38BR318:210T-416:-210T-435",
		[2] = "NAB:35:12:12:12:35:12:12:12:35:12:12:12:35:12:12:1:35:12:12:1:35:12:12:1:35:12:4:1:35:12:12:4:26:12:10:30:12:10:0M0:0M37:0M75:-36TR-317:-1BR318:-38BR318:210T-416:-210T-435",
		[3] = "NAB:35:12:12:12:35:12:12:12:35:12:12:4:35:12:12:4:35:12:12:12:35:12:12:1:35:12:12:1:35:12:12:8:26:12:10:30:12:10:0M0:0M37:300M0:-300M0:0M74:-1BR318:-38BR318:0M293",
		[4] = "NAB:35:12:8:8:40:12:12:12:40:12:12:12:40:12:12:6:40:12:12:6:35:12:12:1:35:12:12:12:35:12:12:12:26:12:10:30:12:10:0M282:0M0:0M42:383M0:-383M0:0BR262:0T-482:0T-442",
	}
	local styleName = {
		[1] = _G.DEFAULT,
		[2] = "3X12",
		[3] = "12+24+12",
		[4] = "2UI Style",
		[5] = U["Export"],
		[6] = U["Import"],
	}
	local tooltips = {
		[5] = U["ExportActionbarStyle"],
		[6] = U["ImportActionbarStyle"],
	}

	local function applyBarStyle(self)
		--if not IsControlKeyDown() then return end
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
			return "导出布局"--"|T"..I.ArrowUp..":18|t"
		elseif i == 6 then
			return "导入布局"--"|T"..I.ArrowUp..":18:18:0:0:1:1:0:1:1:0|t"
		else
			return styleName[i]
		end
	end

	for i = 1, maxButtons do
		local bu = M.CreateButton(frame, size, 24, GetButtonText(i))
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
		if func then -- no func for private auras
			createOptionSlider(parent, U["IconsPerRow"], 10, 40, defaultPerRow, offset-170, value.."sPerRow", func, "Auras")
		end
	end

	createOptionGroup(parent, "Buffs*", offset, "Buff", updateBuffFrame)
	createOptionGroup(parent, "Debuffs*", offset-260, "Debuff", updateDebuffFrame)
	createOptionGroup(parent, "PrivateAuras", offset-520, "Private")
end

function G:NameplateColorDots(parent)
	local guiName = "UIGUI_NameplateColorDots"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["ColorDotsList"].."*", true)

	local barTable = {}

	local function createBar(parent, spellID, isNew)
		local spellName, texture = GetSpellName(spellID), GetSpellTexture(spellID)

		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		barTable[spellID] = bar

		local icon, close = G:CreateBarWidgets(bar, texture)
		M.AddTooltip(icon, "ANCHOR_RIGHT", spellID, "system")
		close:SetScript("OnClick", function()
			bar:Hide()
			barTable[spellID] = nil
			R.db["Nameplate"]["DotSpells"][spellID] = nil
			sortBars(barTable)
		end)

		local name = M.CreateFS(bar, 14, spellName, false, "LEFT", 30, 0)
		name:SetWidth(120)
		name:SetJustifyH("LEFT")
		if isNew then name:SetTextColor(0, 1, 0) end

		sortBars(barTable)
	end

	local frame = panel.bg

	local scroll = G:CreateScroll(frame, 240, 485)
	scroll.box = M.CreateEditBox(frame, 135, 25)
	scroll.box:SetPoint("TOPLEFT", 35, -10)
	M.AddTooltip(scroll.box, "ANCHOR_TOPRIGHT", U["ID Intro"], "info", true)

	local swatch = M.CreateColorSwatch(frame, nil, R.db["Nameplate"]["DotColor"])
	swatch:SetPoint("RIGHT", scroll.box, "LEFT", -5, 0)
	swatch.__default = G.DefaultSettings["Nameplate"]["DotColor"]

	local function addClick(button)
		local parent = button.__owner
		local spellID = tonumber(parent.box:GetText())
		if not spellID or not GetSpellName(spellID) then UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect SpellID"]) return end
		if R.db["Nameplate"]["DotSpells"][spellID] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end
		R.db["Nameplate"]["DotSpells"][spellID] = true
		createBar(parent.child, spellID, true)
		parent.box:SetText("")
	end
	scroll.add = M.CreateButton(frame, 45, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -8, -10)
	scroll.add.__owner = scroll
	scroll.add:SetScript("OnClick", addClick)

	scroll.reset = M.CreateButton(frame, 45, 25, RESET)
	scroll.reset:SetPoint("RIGHT", scroll.add, "LEFT", -5, 0)
	StaticPopupDialogs["RESET_UI_DOTSPELLS"] = {
		text = U["Reset to default list"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			R.db["Nameplate"]["DotSpells"] = {}
			ReloadUI()
		end,
		whileDead = 1,
	}
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_DOTSPELLS")
	end)

	for npcID in pairs(R.db["Nameplate"]["DotSpells"]) do
		createBar(scroll.child, npcID)
	end
end

local function refreshUnitTable()
	M:GetModule("UnitFrames"):CreateUnitTable()
end

function G:NameplateUnitFilter(parent)
	local guiName = "UIGUI_NameplateUnitFilter"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["UnitColor List"].."*", true)
	panel:SetScript("OnHide", refreshUnitTable)

	local barTable = {}

	local function createBar(parent, text, isNew)
		local npcID = tonumber(text)

		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		barTable[text] = bar

		local icon, close = G:CreateBarWidgets(bar, npcID and 136243 or 132288)
		if npcID then
			M.AddTooltip(icon, "ANCHOR_RIGHT", "ID: "..npcID, "system")
		end
		close:SetScript("OnClick", function()
			bar:Hide()
			barTable[text] = nil
			if R.CustomUnits[text] then
				R.db["Nameplate"]["CustomUnits"][text] = false
			else
				R.db["Nameplate"]["CustomUnits"][text] = nil
			end
			sortBars(barTable)
		end)

		local name = M.CreateFS(bar, 14, text, false, "LEFT", 30, 0)
		name:SetWidth(190)
		name:SetJustifyH("LEFT")
		if isNew then name:SetTextColor(0, 1, 0) end
		if npcID then
			M.GetNPCName(npcID, function(npcName)
				name:SetText(npcName)
				if npcName == UNKNOWN then
					name:SetTextColor(1, 0, 0)
				end
			end)
		end

		sortBars(barTable)
	end

	local frame = panel.bg

	local scroll = G:CreateScroll(frame, 240, 485)
	scroll.box = M.CreateEditBox(frame, 135, 25)
	scroll.box:SetPoint("TOPLEFT", 35, -10)
	M.AddTooltip(scroll.box, "ANCHOR_TOPRIGHT", U["NPCID or Name"], "info", true)

	local swatch = M.CreateColorSwatch(frame, nil, R.db["Nameplate"]["CustomColor"])
	swatch:SetPoint("RIGHT", scroll.box, "LEFT", -5, 0)
	swatch.__default = G.DefaultSettings["Nameplate"]["CustomColor"]

	local function addClick(button)
		local parent = button.__owner
		local text = tonumber(parent.box:GetText()) or parent.box:GetText()
		if text and text ~= "" then
			local modValue = R.db["Nameplate"]["CustomUnits"][text]
			if modValue or modValue == nil and R.CustomUnits[text] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end
			R.db["Nameplate"]["CustomUnits"][text] = true
			createBar(parent.child, text, true)
			parent.box:SetText("")
		end
	end
	scroll.add = M.CreateButton(frame, 45, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -8, -10)
	scroll.add.__owner = scroll
	scroll.add:SetScript("OnClick", addClick)

	scroll.reset = M.CreateButton(frame, 45, 25, RESET)
	scroll.reset:SetPoint("RIGHT", scroll.add, "LEFT", -5, 0)
	StaticPopupDialogs["RESET_UI_UNITFILTER"] = {
		text = U["Reset to default list"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			R.db["Nameplate"]["CustomUnits"] = {}
			ReloadUI()
		end,
		whileDead = 1,
	}
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_UNITFILTER")
	end)

	local UF = M:GetModule("UnitFrames")
	for npcID in pairs(UF.CustomUnits) do
		createBar(scroll.child, npcID)
	end
end

local function refreshPowerUnitTable()
	M:GetModule("UnitFrames"):CreatePowerUnitTable()
end

function G:NameplatePowerUnits(parent)
	local guiName = "UIGUI_NameplatePowerUnits"
	toggleExtraGUI(guiName)
	if extraGUIs[guiName] then return end

	local panel = createExtraGUI(parent, guiName, U["ShowPowerList"].."*", true)
	panel:SetScript("OnHide", refreshPowerUnitTable)

	local barTable = {}

	local function createBar(parent, text, isNew)
		local npcID = tonumber(text)

		local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
		bar:SetSize(220, 30)
		M.CreateBD(bar, .25)
		barTable[text] = bar

		local icon, close = G:CreateBarWidgets(bar, npcID and 136243 or 132288)
		if npcID then
			M.AddTooltip(icon, "ANCHOR_RIGHT", "ID: "..npcID, "system")
		end
		close:SetScript("OnClick", function()
			bar:Hide()
			barTable[text] = nil
			if R.PowerUnits[text] then
				R.db["Nameplate"]["PowerUnits"][text] = false
			else
				R.db["Nameplate"]["PowerUnits"][text] = nil
			end
			sortBars(barTable)
		end)

		local name = M.CreateFS(bar, 14, text, false, "LEFT", 30, 0)
		name:SetWidth(190)
		name:SetJustifyH("LEFT")
		if isNew then name:SetTextColor(0, 1, 0) end
		if npcID then
			M.GetNPCName(npcID, function(npcName)
				name:SetText(npcName)
				if npcName == UNKNOWN then
					name:SetTextColor(1, 0, 0)
				end
			end)
		end

		sortBars(barTable)
	end

	local frame = panel.bg

	local scroll = G:CreateScroll(frame, 240, 485)
	scroll.box = M.CreateEditBox(frame, 160, 25)
	scroll.box:SetPoint("TOPLEFT", 10, -10)
	M.AddTooltip(scroll.box, "ANCHOR_TOPRIGHT", U["NPCID or Name"], "info", true)

	local function addClick(button)
		local parent = button.__owner
		local text = tonumber(parent.box:GetText()) or parent.box:GetText()
		if text and text ~= "" then
			local modValue = R.db["Nameplate"]["PowerUnits"][text]
			if modValue or modValue == nil and R.PowerUnits[text] then UIErrorsFrame:AddMessage(I.InfoColor..U["Existing ID"]) return end
			R.db["Nameplate"]["PowerUnits"][text] = true
			createBar(parent.child, text, true)
			parent.box:SetText("")
		end
	end
	scroll.add = M.CreateButton(frame, 45, 25, ADD)
	scroll.add:SetPoint("TOPRIGHT", -8, -10)
	scroll.add.__owner = scroll
	scroll.add:SetScript("OnClick", addClick)

	scroll.reset = M.CreateButton(frame, 45, 25, RESET)
	scroll.reset:SetPoint("RIGHT", scroll.add, "LEFT", -5, 0)
	StaticPopupDialogs["RESET_UI_POWERUNITS"] = {
		text = U["Reset to default list"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			R.db["Nameplate"]["PowerUnits"] = {}
			ReloadUI()
		end,
		whileDead = 1,
	}
	scroll.reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_POWERUNITS")
	end)

	local UF = M:GetModule("UnitFrames")
	for npcID in pairs(UF.PowerUnits) do
		createBar(scroll.child, npcID)
	end
end