local _, ns = ...
local M, R, U, I = unpack(ns)
local G = M:GetModule("GUI")

local pairs, strsplit, Ambiguate = pairs, strsplit, Ambiguate
local strfind, tostring, select = strfind, tostring, select
local SetPortraitTexture, StaticPopup_Show = SetPortraitTexture, StaticPopup_Show
local cr, cg, cb = I.r, I.g, I.b
local myFullName = I.MyFullName

-- Static popups
StaticPopupDialogs["RESET_UI"] = {
	text = U["Reset UI Check"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		MaoRUIDB = {}
		MaoRUISetDB = {}
		MaoRUIPerDB = {}
		ReloadUI()
	end,
	whileDead = 1,
}

StaticPopupDialogs["RESET_UI_HELPINFO"] = {
	text = U["Reset UI Helpinfo"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		wipe(MaoRUISetDB["Help"])
	end,
	whileDead = 1,
}

StaticPopupDialogs["UI_RESET_PROFILE"] = {
	text = U["Reset current profile?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		wipe(R.db)
		ReloadUI()
	end,
	whileDead = 1,
}

StaticPopupDialogs["UI_APPLY_PROFILE"] = {
	text = U["Apply selected profile?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		MaoRUISetDB["ProfileIndex"][myFullName] = G.currentProfile
		ReloadUI()
	end,
	whileDead = 1,
}

StaticPopupDialogs["UI_DOWNLOAD_PROFILE"] = {
	text = U["Download selected profile?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		local profileIndex = MaoRUISetDB["ProfileIndex"][myFullName]
		if G.currentProfile == 1 then
			MaoRUIPerDB[profileIndex-1] = MaoRUIDB
		elseif profileIndex == 1 then
			MaoRUIDB = MaoRUIPerDB[G.currentProfile-1]
		else
			MaoRUIPerDB[profileIndex-1] = MaoRUIPerDB[G.currentProfile-1]
		end
		ReloadUI()
	end,
	whileDead = 1,
}

StaticPopupDialogs["UI_UPLOAD_PROFILE"] = {
	text = U["Upload current profile?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		if G.currentProfile == 1 then
			MaoRUIDB = R.db
		else
			MaoRUIPerDB[G.currentProfile-1] = R.db
		end
	end,
	whileDead = 1,
}

StaticPopupDialogs["UI_DELETE_UNIT_PROFILE"] = {
	text = "",
	button1 = YES,
	button2 = NO,
	OnAccept = function(self)
		local name, realm = strsplit("-", self.text.text_arg1)
		if MaoRUISetDB["totalGold"][realm] and MaoRUISetDB["totalGold"][realm][name] then
			MaoRUISetDB["totalGold"][realm][name] = nil
		end
		MaoRUISetDB["ProfileIndex"][self.text.text_arg1] = nil
	end,
	OnShow = function(self)
		local r, g, b
		local class = self.text.text_arg2
		if class == "NONE" then
			r, g, b = .5, .5, .5
		else
			r, g, b = M.ClassColor(class)
		end
		self.text:SetText(format(U["Delete unit profile?"], M.HexRGB(r, g, b), self.text.text_arg1))
	end,
	whileDead = 1,
}

function G:CreateProfileIcon(bar, index, texture, title, description)
	local button = CreateFrame("Button", nil, bar)
	button:SetSize(32, 32)
	button:SetPoint("RIGHT", -6 - (index-1)*36, 0)
	M.PixelIcon(button, texture, true)
	button.title = title
	M.AddTooltip(button, "ANCHOR_RIGHT", description, "info")

	return button
end

function G:Reset_OnClick()
	StaticPopup_Show("UI_RESET_PROFILE")
end

function G:Apply_OnClick()
	G.currentProfile = self:GetParent().index
	StaticPopup_Show("UI_APPLY_PROFILE")
end

function G:Download_OnClick()
	G.currentProfile = self:GetParent().index
	StaticPopup_Show("UI_DOWNLOAD_PROFILE")
end

function G:Upload_OnClick()
	G.currentProfile = self:GetParent().index
	StaticPopup_Show("UI_UPLOAD_PROFILE")
end

function G:GetClassFromGoldInfo(name, realm)
	local class = "NONE"
	if MaoRUISetDB["totalGold"][realm] and MaoRUISetDB["totalGold"][realm][name] then
		class = MaoRUISetDB["totalGold"][realm][name][2]
	end
	return class
end

function G:FindProfleUser(icon)
	icon.list = {}
	for fullName, index in pairs(MaoRUISetDB["ProfileIndex"]) do
		if index == icon.index then
			local name, realm = strsplit("-", fullName)
			if not icon.list[realm] then icon.list[realm] = {} end
			icon.list[realm][Ambiguate(fullName, "none")] = G:GetClassFromGoldInfo(name, realm)
		end
	end
end

function G:Icon_OnEnter()
	if not next(self.list) then return end

	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:ClearLines()
	GameTooltip:AddLine(U["SharedCharacters"])
	GameTooltip:AddLine(" ")
	local r, g, b
	for _, value in pairs(self.list) do
		for name, class in pairs(value) do
			if class == "NONE" then
				r, g, b = .5, .5, .5
			else
				r, g, b = M.ClassColor(class)
			end
			GameTooltip:AddLine(name, r, g, b)
		end
	end
	GameTooltip:Show()
end

function G:Note_OnEscape()
	self:SetText(MaoRUISetDB["ProfileNames"][self.index])
end

function G:Note_OnEnter()
	local text = self:GetText()
	if text == "" then
		MaoRUISetDB["ProfileNames"][self.index] = self.__defaultText
		self:SetText(self.__defaultText)
	else
		MaoRUISetDB["ProfileNames"][self.index] = text
	end
end

function G:CreateProfileBar(parent, index)
	local bar = M.CreateBDFrame(parent, .25)
	bar:ClearAllPoints()
	bar:SetPoint("TOPLEFT", 10, -10 - 45*(index-1))
	bar:SetSize(600, 40)
	bar.index = index

	local icon = CreateFrame("Frame", nil, bar)
	icon:SetSize(32, 32)
	icon:SetPoint("LEFT", 5, 0)
	if index == 1 then
		M.PixelIcon(icon, nil, true) -- character
		SetPortraitTexture(icon.Icon, "player")
	else
		M.PixelIcon(icon, 235423, true) -- share
		icon.Icon:SetTexCoord(.6, .9, .1, .4)
		icon.index = index
		G:FindProfleUser(icon)
		icon:SetScript("OnEnter", G.Icon_OnEnter)
		icon:SetScript("OnLeave", M.HideTooltip)
	end

	local note = M.CreateEditBox(bar, 150, 32)
	note:SetPoint("LEFT", icon, "RIGHT", 5, 0)
	note:SetMaxLetters(20)
	if index == 1 then
		note.__defaultText = U["DefaultCharacterProfile"]
	else
		note.__defaultText = U["DefaultSharedProfile"]..(index - 1)
	end
	if not MaoRUISetDB["ProfileNames"][index] then
		MaoRUISetDB["ProfileNames"][index] = note.__defaultText
	end
	note:SetText(MaoRUISetDB["ProfileNames"][index])
	note.index = index
	note:HookScript("OnEnterPressed", G.Note_OnEnter)
	note:HookScript("OnEscapePressed", G.Note_OnEscape)
	note.title = U["ProfileName"]
	M.AddTooltip(note, "ANCHOR_TOP", U["ProfileNameTip"], "info")

	local reset = G:CreateProfileIcon(bar, 1, "Atlas:transmog-icon-revert", U["ResetProfile"], U["ResetProfileTip"])
	reset:SetScript("OnClick", G.Reset_OnClick)
	bar.reset = reset

	local apply = G:CreateProfileIcon(bar, 2, "Interface\\RAIDFRAME\\ReadyCheck-Ready", U["SelectProfile"], U["SelectProfileTip"])
	apply:SetScript("OnClick", G.Apply_OnClick)
	bar.apply = apply

	local download = G:CreateProfileIcon(bar, 3, "Atlas:streamcinematic-downloadicon", U["DownloadProfile"], U["DownloadProfileTip"])
	download.Icon:SetTexCoord(.25, .75, .25, .75)
	download:SetScript("OnClick", G.Download_OnClick)
	bar.download = download

	local upload = G:CreateProfileIcon(bar, 4, "Atlas:bags-icon-addslots", U["UploadProfile"], U["UploadProfileTip"])
	upload.Icon:SetInside(nil, 6, 6)
	upload:SetScript("OnClick", G.Upload_OnClick)
	bar.upload = upload

	return bar
end

local function UpdateButtonStatus(button, enable)
	button:EnableMouse(enable)
	button.Icon:SetDesaturated(not enable)
end

function G:UpdateCurrentProfile()
	for index, bar in pairs(G.bars) do
		if index == G.currentProfile then
			UpdateButtonStatus(bar.upload, false)
			UpdateButtonStatus(bar.download, false)
			UpdateButtonStatus(bar.apply, false)
			UpdateButtonStatus(bar.reset, true)
			bar:SetBackdropColor(cr, cg, cb, .25)
			bar.apply.bg:SetBackdropBorderColor(1, .8, 0)
		else
			UpdateButtonStatus(bar.upload, true)
			UpdateButtonStatus(bar.download, true)
			UpdateButtonStatus(bar.apply, true)
			UpdateButtonStatus(bar.reset, false)
			bar:SetBackdropColor(0, 0, 0, .25)
			M.SetBorderColor(bar.apply.bg)
		end
	end
end

function G:Delete_OnEnter()
	local text = self:GetText()
	if not text or text == "" then return end
	local name, realm = strsplit("-", text)
	if not realm then
		realm = I.MyRealm
		text = name.."-"..realm
		self:SetText(text)
	end

	if MaoRUISetDB["ProfileIndex"][text] or (MaoRUISetDB["totalGold"][realm] and MaoRUISetDB["totalGold"][realm][name]) then
		StaticPopup_Show("UI_DELETE_UNIT_PROFILE", text, G:GetClassFromGoldInfo(name, realm))
	else
		UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect unit name"])
	end
end

function G:Delete_OnEscape()
	self:SetText("")
end

function G:CreateProfileGUI(parent)
	local reset = M.CreateButton(parent, 120, 24, U["UI Reset"])
	reset:SetPoint("BOTTOMLEFT", 100, 60)
	reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI")
	end)

	--[[local restore = M.CreateButton(parent, 120, 24, U["Reset Help"])
	restore:SetPoint("BOTTOM", reset, "TOP", 0, 2)
	restore:SetScript("OnClick", function()
		StaticPopup_Show("RESET_UI_HELPINFO")
	end)]]

	local import = M.CreateButton(parent, 120, 24, U["Import"])
	import:SetPoint("LEFT", reset, "RIGHT", 6, 0)
	import:SetScript("OnClick", function()
		parent:GetParent():Hide()
		G:CreateDataFrame()
		G.ProfileDataFrame.Header:SetText(U["Import Header"])
		G.ProfileDataFrame.text:SetText(U["Import"])
		G.ProfileDataFrame.editBox:SetText("")
	end)

	local export = M.CreateButton(parent, 120, 24, U["Export"])
	export:SetPoint("LEFT", import, "RIGHT", 6, 0)
	export:SetScript("OnClick", function()
		parent:GetParent():Hide()
		G:CreateDataFrame()
		G.ProfileDataFrame.Header:SetText(U["Export Header"])
		G.ProfileDataFrame.text:SetText(OKAY)
		G:ExportGUIData()
	end)

	--M.CreateFS(parent, 14, U["Profile Management"], "system", "TOPLEFT", 52, -40)
	--local description = M.CreateFS(parent, 14, U["Profile Description"], nil, "TOPLEFT", 52, -45)
	--description:SetPoint("TOPRIGHT", -90, -45)
	--description:SetWordWrap(true)
	--description:SetJustifyH("LEFT")

	local delete = M.CreateEditBox(parent, 245, 26)
	delete:SetPoint("LEFT", export, "RIGHT", 6, 0)
	delete:HookScript("OnEnterPressed", G.Delete_OnEnter)
	delete:HookScript("OnEscapePressed", G.Delete_OnEscape)
	delete.title = U["DeleteUnitProfile"]
	M.AddTooltip(delete, "ANCHOR_TOP", U["DeleteUnitProfileTip"], "info")

	G.currentProfile = MaoRUISetDB["ProfileIndex"][I.MyFullName]

	local numBars = 6
	local panel = M.CreateBDFrame(parent, 0)
	panel:ClearAllPoints()
	panel:SetPoint("BOTTOMLEFT", reset, "TOPLEFT", 0, 10)
	panel:SetWidth(parent:GetWidth() - 260)
	panel:SetHeight(15 + numBars*45)
	panel:SetFrameLevel(11)

	G.bars = {}
	for i = 1, numBars do
		G.bars[i] = G:CreateProfileBar(panel, i)
	end

	G:UpdateCurrentProfile()
end

-- Data transfer
local bloodlustFilter = {
	[57723] = true,
	[57724] = true,
	[80354] = true,
	[264689] = true,
	[390435] = true, -- evoker
}

local accountStrValues = {
	["ChatFilterList"] = true,
	["ChatFilterWhiteList"] = true,
	["CustomTex"] = true,
	["IgnoredButtons"] = true,
}

local spellBooleanValues = {
	["RaidBuffsWhite"] = true,
	["RaidDebuffsBlack"] = true,
	["NameplateWhite"] = true,
	["NameplateBlack"] = true,
}

local booleanTable = {
	["CustomUnits"] = true,
	["PowerUnits"] = true,
	["DotSpells"] = true,
}

function G:ExportGUIData()
	local text = "UISettings:"..I.Version..":"..I.MyName..":"..I.MyClass
	for KEY, VALUE in pairs(R.db) do
		if type(VALUE) == "table" then
			for key, value in pairs(VALUE) do
				if type(value) == "table" then
					if value.r then
						text = text..";"..KEY..":"..key
						for k, v in pairs(value) do
							text = text..":"..k..":"..v
						end
					elseif KEY == "AuraWatchList" then
						if key == "Switcher" then
							for k, v in pairs(value) do
								text = text..";"..KEY..":"..key..":"..k..":"..tostring(v)
							end
						elseif key == "IgnoreSpells" then
							text = text..";"..KEY..":"..key
							for spellID in pairs(value) do
								text = text..":"..tostring(spellID)
							end
						else
							for spellID, k in pairs(value) do
								text = text..";"..KEY..":"..key..":"..spellID
								if k[5] == nil then k[5] = false end
								for _, v in ipairs(k) do
									text = text..":"..tostring(v)
								end
							end
						end
					elseif KEY == "Mover" or KEY == "InternalCD" or KEY == "AuraWatchMover" then
						text = text..";"..KEY..":"..key
						for _, v in ipairs(value) do
							text = text..":"..tostring(v)
						end
					elseif key == "CustomItems" or key == "CustomNames" then
						text = text..";"..KEY..":"..key
						for k, v in pairs(value) do
							text = text..":"..k..":"..v
						end
					elseif booleanTable[key] then
						text = text..";"..KEY..":"..key
						for k, v in pairs(value) do
							text = text..":"..k..":"..tostring(v)
						end
					end
				else
					if R.db[KEY][key] ~= G.DefaultSettings[KEY][key] then -- don't export default settings
						text = text..";"..KEY..":"..key..":"..tostring(value)
					end
				end
			end
		end
	end

	for KEY, VALUE in pairs(MaoRUISetDB) do
		if spellBooleanValues[KEY] then
			text = text..";ACCOUNT:"..KEY
			for spellID, value in pairs(VALUE) do
				text = text..":"..spellID..":"..tostring(value)
			end
		elseif KEY == "RaidDebuffs" then
			for instName, value in pairs(VALUE) do
				for spellID, prio in pairs(value) do
					text = text..";ACCOUNT:"..KEY..":"..instName..":"..spellID..":"..prio
				end
			end
		elseif KEY == "CornerSpells" then
			text = text..";ACCOUNT:"..KEY
			for class, value in pairs(VALUE) do
				if class == I.MyClass then
					text = text..":"..class
					for spellID, data in pairs(value) do
						if not bloodlustFilter[spellID] then
							local anchor, color, filter = unpack(data)
							anchor = anchor or ""
							color = color or {"", "", ""}
							text = text..":"..spellID..":"..anchor..":"..color[1]..":"..color[2]..":"..color[3]..":"..tostring(filter or false)
						end
					end
				end
			end
		elseif KEY == "ContactList" then
			text = text..";ACCOUNT:"..KEY
			for name, color in pairs(VALUE) do
				local r, g, b = strsplit(":", color)
				r = M:Round(r, 2)
				g = M:Round(g, 2)
				b = M:Round(b, 2)
				text = text..":"..name..":"..r..":"..g..":"..b
			end
		elseif KEY == "ProfileIndex" or KEY == "ProfileNames" then
			text = text..";ACCOUNT:"..KEY
			for k, v in pairs(VALUE) do
				text = text..":"..k..":"..v
			end
		elseif KEY == "ClickSets" then
			text = text..";ACCOUNT:"..KEY
			if MaoRUISetDB[KEY][I.MyClass] then
				text = text..":"..I.MyClass
				for fullkey, value in pairs(MaoRUISetDB[KEY][I.MyClass]) do
					value = gsub(value, "%:", "`")
					value = gsub(value, ";", "}")
					text = text..":"..fullkey..":"..value
				end
			end
		elseif VALUE == true or VALUE == false or accountStrValues[KEY] then
			text = text..";ACCOUNT:"..KEY..":"..tostring(VALUE)
		end
	end

	G.ProfileDataFrame.editBox:SetText(M:Encode(text))
	G.ProfileDataFrame.editBox:HighlightText()
end

local function toBoolean(value)
	if value == "true" then
		return true
	elseif value == "false" then
		return false
	end
end

local function reloadDefaultSettings()
	for i, j in pairs(G.DefaultSettings) do
		if type(j) == "table" then
			if not R.db[i] then R.db[i] = {} end
			for k, v in pairs(j) do
				R.db[i][k] = v
			end
		else
			R.db[i] = j
		end
	end
	R.db["TWW"] = true -- don't empty data on next loading
end

local function IsOldProfileVersion(version)
	local major, minor, patch = strsplit(".", version)
	major = tonumber(major)
	minor = tonumber(minor)
	patch = tonumber(patch)
	return major < 7 and (minor < 23 or (minor == 23 and patch < 2))
end

function G:ImportGUIData()
	local profile = G.ProfileDataFrame.editBox:GetText()
	if M:IsBase64(profile) then profile = M:Decode(profile) end
	local options = {strsplit(";", profile)}
	local title, version, _, class = strsplit(":", options[1])
	if title ~= "UISettings"then -- or IsOldProfileVersion(version) 
		UIErrorsFrame:AddMessage(I.InfoColor..U["Import data error"])
		return
	end

	-- we don't export default settings, so need to reload it
	reloadDefaultSettings()

	for i = 2, #options do
		local option = options[i]
		local key, value, arg1 = strsplit(":", option)
		if arg1 == "true" or arg1 == "false" then
			if key == "ACCOUNT" then
				MaoRUISetDB[value] = toBoolean(arg1)
			else
				R.db[key][value] = toBoolean(arg1)
			end
		elseif arg1 == "EMPTYTABLE" then
			R.db[key][value] = {}
		elseif strfind(value, "Color") and (arg1 == "r" or arg1 == "g" or arg1 == "b") then
			local colors = {select(3, strsplit(":", option))}
			if R.db[key][value] then
				for i = 1, #colors, 2 do
					R.db[key][value][colors[i]] = tonumber(colors[i+1])
				end
			end
		elseif key == "AuraWatchList" then
			if value == "Switcher" then
				local index, state = select(3, strsplit(":", option))
				R.db[key][value][tonumber(index)] = toBoolean(state)
			elseif value == "IgnoreSpells" then
				local spells = {select(3, strsplit(":", option))}
				for _, spellID in next, spells do
					R.db[key][value][tonumber(spellID)] = true
				end
			else
				local idType, spellID, unit, caster, stack, amount, timeless, combat, text, flash = select(4, strsplit(":", option))
				value = tonumber(value)
				arg1 = tonumber(arg1)
				spellID = tonumber(spellID)
				stack = tonumber(stack)
				amount = toBoolean(amount)
				timeless = toBoolean(timeless)
				combat = toBoolean(combat)
				flash = toBoolean(flash)
				if not R.db[key][value] then R.db[key][value] = {} end
				R.db[key][value][arg1] = {idType, spellID, unit, caster, stack, amount, timeless, combat, text, flash}
			end
		elseif booleanTable[value] then
			local results = {select(3, strsplit(":", option))}
			for i = 1, #results, 2 do
				R.db[key][value][tonumber(results[i]) or results[i]] = toBoolean(results[i+1])
			end
		elseif value == "CustomItems" or value == "CustomNames" then
			local results = {select(3, strsplit(":", option))}
			for i = 1, #results, 2 do
				R.db[key][value][tonumber(results[i])] = tonumber(results[i+1]) or results[i+1]
			end
		elseif key == "Mover" or key == "AuraWatchMover" then
			local relFrom, parent, relTo, x, y = select(3, strsplit(":", option))
			value = tonumber(value) or value
			x = tonumber(x)
			y = tonumber(y)
			R.db[key][value] = {relFrom, parent, relTo, x, y}
		elseif key == "InternalCD" then
			local spellID, duration, indicator, unit, itemID = select(3, strsplit(":", option))
			spellID = tonumber(spellID)
			duration = tonumber(duration)
			itemID = tonumber(itemID)
			R.db[key][spellID] = {spellID, duration, indicator, unit, itemID}
		elseif value == "InfoStrLeft" or value == "InfoStrRight" or accountStrValues[value] then
			if key == "ACCOUNT" then
				MaoRUISetDB[value] = arg1
			else
				R.db[key][value] = arg1
			end
		elseif key == "ACCOUNT" then
			if spellBooleanValues[value] then
				local results = {select(3, strsplit(":", option))}
				for i = 1, #results, 2 do
					MaoRUISetDB[value][tonumber(results[i])] = toBoolean(results[i+1])
				end
			elseif value == "RaidDebuffs" then
				local instName, spellID, priority = select(3, strsplit(":", option))
				if not MaoRUISetDB[value][instName] then MaoRUISetDB[value][instName] = {} end
				MaoRUISetDB[value][instName][tonumber(spellID)] = tonumber(priority)
			elseif value == "CornerSpells" then
				local results = {select(3, strsplit(":", option))}
				local class = results[1]
				if class == I.MyClass then
					for i = 2, #results, 6 do
						local spellID, anchor, r, g, b, filter = results[i], results[i+1], results[i+2], results[i+3], results[i+4], results[i+5]
						spellID = tonumber(spellID)
						r = tonumber(r)
						g = tonumber(g)
						b = tonumber(b)
						filter = toBoolean(filter)
						if not MaoRUISetDB[value][class] then MaoRUISetDB[value][class] = {} end
						if anchor == "" then
							MaoRUISetDB[value][class][spellID] = {}
						else
							MaoRUISetDB[value][class][spellID] = {anchor, {r, g, b}, filter}
						end
					end
				end
			elseif value == "ContactList" then
				local names = {select(3, strsplit(":", option))}
				for i = 1, #names, 4 do
					MaoRUISetDB[value][names[i]] = names[i+1]..":"..names[i+2]..":"..names[i+3]
				end
			elseif value == "ProfileIndex" then
				local results = {select(3, strsplit(":", option))}
				for i = 1, #results, 2 do
					MaoRUISetDB[value][results[i]] = tonumber(results[i+1])
				end
			elseif value == "ProfileNames" then
				local results = {select(3, strsplit(":", option))}
				for i = 1, #results, 2 do
					MaoRUISetDB[value][tonumber(results[i])] = results[i+1]
				end
			elseif value == "ClickSets" then
				if arg1 == I.MyClass then
					MaoRUISetDB[value][arg1] = MaoRUISetDB[value][arg1] or {}
					local results = {select(4, strsplit(":", option))}
					for i = 1, #results, 2 do
						results[i+1] = gsub(results[i+1], "`", ":")
						results[i+1] = gsub(results[i+1], "}", ";")
						MaoRUISetDB[value][arg1][results[i]] = tonumber(results[i+1]) or results[i+1]
					end
				end
			end
		elseif tonumber(arg1) then
			if value == "DBMCount" then
				R.db[key][value] = arg1
			elseif R.db[key] then
				R.db[key][value] = tonumber(arg1)
			end
		end
	end
	ReloadUI()
end

local function updateTooltip()
	local dataFrame = G.ProfileDataFrame
	local profile = dataFrame.editBox:GetText()
	if M:IsBase64(profile) then profile = M:Decode(profile) end
	local option = strsplit(";", profile)
	local title, version, name, class = strsplit(":", option)
	if title == "UISettings" then
		dataFrame.version = version
		dataFrame.name = name
		dataFrame.class = class
	else
		dataFrame.version = nil
	end
end

function G:CreateDataFrame()
	if G.ProfileDataFrame then G.ProfileDataFrame:Show() return end

	local dataFrame = CreateFrame("Frame", nil, UIParent)
	dataFrame:SetPoint("CENTER")
	dataFrame:SetSize(500, 500)
	dataFrame:SetFrameStrata("DIALOG")
	M.CreateMF(dataFrame)
	M.SetBD(dataFrame)
	dataFrame.Header = M.CreateFS(dataFrame, 16, U["Export Header"], true, "TOP", 0, -5)

	local scrollArea = CreateFrame("ScrollFrame", nil, dataFrame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", 10, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", -28, 40)
	M.CreateBDFrame(scrollArea, .25)

	local editBox = CreateFrame("EditBox", nil, dataFrame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(true)
	editBox:SetFont(I.Font[1], 14, "")
	editBox:SetWidth(scrollArea:GetWidth())
	editBox:SetHeight(scrollArea:GetHeight())
	editBox:SetScript("OnEscapePressed", function() dataFrame:Hide() end)
	scrollArea:SetScrollChild(editBox)
	dataFrame.editBox = editBox

	StaticPopupDialogs["UI_IMPORT_DATA"] = {
		text = U["Import data warning"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			G:ImportGUIData()
		end,
		whileDead = 1,
	}
	local accept = M.CreateButton(dataFrame, 100, 20, OKAY)
	accept:SetPoint("BOTTOM", 0, 10)
	accept:SetScript("OnClick", function(self)
		if self.text:GetText() ~= OKAY and dataFrame.editBox:GetText() ~= "" then
			StaticPopup_Show("UI_IMPORT_DATA")
		end
		dataFrame:Hide()
	end)
	accept:HookScript("OnEnter", function(self)
		if dataFrame.editBox:GetText() == "" then return end
		updateTooltip()

		GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 10)
		GameTooltip:ClearLines()
		if dataFrame.version then
			GameTooltip:AddLine(U["Data Info"])
			GameTooltip:AddDoubleLine(U["Version"], dataFrame.version, .6,.8,1, 1,1,1)
			GameTooltip:AddDoubleLine(U["Character"], dataFrame.name, .6,.8,1, M.ClassColor(dataFrame.class))
		else
			GameTooltip:AddLine(U["Data Exception"], 1,0,0)
		end
		GameTooltip:Show()
	end)
	accept:HookScript("OnLeave", M.HideTooltip)
	dataFrame.text = accept.text

	G.ProfileDataFrame = dataFrame
end
