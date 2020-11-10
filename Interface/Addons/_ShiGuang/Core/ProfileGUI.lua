local _, ns = ...
local M, R, U, I = unpack(ns)
local G = M:GetModule("GUI")

local pairs, strsplit, Ambiguate = pairs, strsplit, Ambiguate
local SetPortraitTexture, StaticPopup_Show = SetPortraitTexture, StaticPopup_Show
local cr, cg, cb = I.r, I.g, I.b
local myFullName = I.MyFullName

-- Static popups
StaticPopupDialogs["RESET_NDUI"] = {
	text = U["Reset NDui Check"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		MaoRUIPerDB = {}
		MaoRUIDB = {}
		MaoRUIPlusDB = {}
		ReloadUI()
	end,
	whileDead = 1,
}

StaticPopupDialogs["NDUI_RESET_PROFILE"] = {
	text = U["Reset current profile?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		wipe(R.db)
		ReloadUI()
	end,
	whileDead = 1,
}

StaticPopupDialogs["NDUI_APPLY_PROFILE"] = {
	text = U["Apply selected profile?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		MaoRUIDB["ProfileIndex"][myFullName] = G.currentProfile
		ReloadUI()
	end,
	whileDead = 1,
}

StaticPopupDialogs["NDUI_DOWNLOAD_PROFILE"] = {
	text = U["Download selected profile?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		local profileIndex = MaoRUIDB["ProfileIndex"][myFullName]
		if G.currentProfile == 1 then
			MaoRUIPlusDB[profileIndex-1] = MaoRUIPerDB
		elseif profileIndex == 1 then
			MaoRUIPerDB = MaoRUIPlusDB[G.currentProfile-1]
		else
			MaoRUIPlusDB[profileIndex-1] = MaoRUIPlusDB[G.currentProfile-1]
		end
		ReloadUI()
	end,
	whileDead = 1,
}

StaticPopupDialogs["NDUI_UPLOAD_PROFILE"] = {
	text = U["Upload current profile?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		local profileIndex = MaoRUIDB["ProfileIndex"][myFullName]
		if G.currentProfile == 1 then
			MaoRUIPerDB = R.db
		else
			MaoRUIPlusDB[G.currentProfile-1] = R.db
		end
	end,
	whileDead = 1,
}

StaticPopupDialogs["NDUI_DELETE_UNIT_PROFILE"] = {
	text = "",
	button1 = YES,
	button2 = NO,
	OnAccept = function(self)
		local name, realm = strsplit("-", self.text.text_arg1)
		if MaoRUIDB["totalGold"][realm] and MaoRUIDB["totalGold"][realm][name] then
			MaoRUIDB["totalGold"][realm][name] = nil
		end
		MaoRUIDB["ProfileIndex"][self.text.text_arg1] = nil
	end,
	OnShow = function(self)
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
	StaticPopup_Show("NDUI_RESET_PROFILE")
end

function G:Apply_OnClick()
	G.currentProfile = self:GetParent().index
	StaticPopup_Show("NDUI_APPLY_PROFILE")
end

function G:Download_OnClick()
	G.currentProfile = self:GetParent().index
	StaticPopup_Show("NDUI_DOWNLOAD_PROFILE")
end

function G:Upload_OnClick()
	G.currentProfile = self:GetParent().index
	StaticPopup_Show("NDUI_UPLOAD_PROFILE")
end

function G:GetClassFromGoldInfo(name, realm)
	local class = "NONE"
	if MaoRUIDB["totalGold"][realm] and MaoRUIDB["totalGold"][realm][name] then
		class = MaoRUIDB["totalGold"][realm][name][2]
	end
	return class
end

function G:FindProfleUser(icon)
	icon.list = {}
	for fullName, index in pairs(MaoRUIDB["ProfileIndex"]) do
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
	for realm, value in pairs(self.list) do
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
	self:SetText(MaoRUIDB["ProfileNames"][self.index])
end

function G:Note_OnEnter()
	local text = self:GetText()
	if text == "" then
		MaoRUIDB["ProfileNames"][self.index] = self.__defaultText
		self:SetText(self.__defaultText)
	else
		MaoRUIDB["ProfileNames"][self.index] = text
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
	if not MaoRUIDB["ProfileNames"][index] then
		MaoRUIDB["ProfileNames"][index] = note.__defaultText
	end
	note:SetText(MaoRUIDB["ProfileNames"][index])
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
			bar.apply.bg:SetBackdropBorderColor(0, 0, 0)
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

	if MaoRUIDB["ProfileIndex"][text] or (MaoRUIDB["totalGold"][realm] and MaoRUIDB["totalGold"][realm][name]) then
		StaticPopup_Show("NDUI_DELETE_UNIT_PROFILE", text, G:GetClassFromGoldInfo(name, realm))
	else
		UIErrorsFrame:AddMessage(I.InfoColor..U["Incorrect unit name"])
	end
end

function G:Delete_OnEscape()
	self:SetText("")
end

function G:CreateProfileGUI(parent)
	local reset = M.CreateButton(parent, 120, 24, U["NDui Reset"])
	reset:SetPoint("BOTTOMLEFT", 100, 90)
	reset:SetScript("OnClick", function()
		StaticPopup_Show("RESET_NDUI")
	end)

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
	local description = M.CreateFS(parent, 14, U["Profile Description"], nil, "TOPLEFT", 52, -45)
	description:SetPoint("TOPRIGHT", -90, -45)
	description:SetWordWrap(true)
	description:SetJustifyH("LEFT")

	local delete = M.CreateEditBox(parent, 245, 26)
	delete:SetPoint("LEFT", export, "RIGHT", 6, 0)
	delete:HookScript("OnEnterPressed", G.Delete_OnEnter)
	delete:HookScript("OnEscapePressed", G.Delete_OnEscape)
	delete.title = U["DeleteUnitProfile"]
	M.AddTooltip(delete, "ANCHOR_TOP", U["DeleteUnitProfileTip"], "info")

	G.currentProfile = MaoRUIDB["ProfileIndex"][I.MyFullName]

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