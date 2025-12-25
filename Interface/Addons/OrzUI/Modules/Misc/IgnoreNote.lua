local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local unitName
local noteString = "|T"..I.copyTex..":12|t %s"

local function GetButtonName(button)
	local name = button.name:GetText()
	if not name then return end
	if not strmatch(name, "-") then
		name = name.."-"..I.MyRealm
	end
	return name
end

function MISC:IgnoreButton_OnClick()
	unitName = GetButtonName(self)
	StaticPopup_Show("ORZUI_IGNORE_NOTE", unitName)
end

function MISC:IgnoreButton_OnEnter()
	local name = GetButtonName(self)
	local savedNote = OrzUISetDB["IgnoreNotes"][name]
	if savedNote then
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 35, 0)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(name)
		GameTooltip:AddLine(format(noteString, savedNote), 1,1,1, 1)
		GameTooltip:Show()
	end
end

function MISC:IgnoreButton_Hook()
	if self.Title then return end

	if not self.hooked then
		self.name:SetFontObject(Game14Font)
		self:HookScript("OnDoubleClick", MISC.IgnoreButton_OnClick)
		self:HookScript("OnEnter", MISC.IgnoreButton_OnEnter)
		self:HookScript("OnLeave", M.HideTooltip)
	
		self.noteTex = self:CreateTexture()
		self.noteTex:SetSize(16, 16)
		self.noteTex:SetTexture(I.copyTex)
		self.noteTex:SetPoint("RIGHT", -5, 0)
	
		self.hooked = true
	end

	self.noteTex:SetShown(OrzUISetDB["IgnoreNotes"][GetButtonName(self)])
end

StaticPopupDialogs["ORZUI_IGNORE_NOTE"] = {
	text = SET_FRIENDNOTE_LABEL,
	button1 = OKAY,
	button2 = CANCEL,
	OnShow = function(self)
		local savedNote = OrzUISetDB["IgnoreNotes"][unitName]
		if savedNote then
			self.EditBox:SetText(savedNote)
			self.EditBox:HighlightText()
		end
	end,
	OnAccept = function(self)
		local text = self.EditBox:GetText()
		if text and text ~= "" then
			OrzUISetDB["IgnoreNotes"][unitName] = text
		else
			OrzUISetDB["IgnoreNotes"][unitName] = nil
		end
	end,
	EditBoxOnEscapePressed = function(editBox)
		editBox:GetParent():Hide()
	end,
	EditBoxOnEnterPressed = function(editBox)
		local text = editBox:GetText()
		if text and text ~= "" then
			OrzUISetDB["IgnoreNotes"][unitName] = text
		else
			OrzUISetDB["IgnoreNotes"][unitName] = nil
		end
		editBox:GetParent():Hide()
	end,
	whileDead = 1,
	hasEditBox = 1,
	editBoxWidth = 250,
}

function MISC:IgnoreNote()
	local ignoreHelpInfo = {
		text = U["IgnoreNoteHelp"],
		buttonStyle = HelpTip.ButtonStyle.GotIt,
		targetPoint = HelpTip.Point.RightEdgeCenter,
		onAcknowledgeCallback = M.HelpInfoAcknowledge,
		callbackArg = "IgnoreNote",
	}

	local ignoreWindow = FriendsFrame.IgnoreListWindow
	if ignoreWindow then
		ignoreWindow:HookScript("OnShow", function(frame)
			if not OrzUISetDB["Help"]["IgnoreNote"] then
				HelpTip:Show(frame, ignoreHelpInfo)
			end
		end)

		hooksecurefunc(ignoreWindow.ScrollBox, "Update", function(self)
			self:ForEachFrame(MISC.IgnoreButton_Hook)
		end)

		ignoreWindow.UnignorePlayerButton:HookScript("OnClick", function()
			local name = C_FriendList.GetIgnoreName(C_FriendList.GetSelectedIgnore())
			if name then
				if not strmatch(name, "-") then
					name = name.."-"..I.MyRealm
				end
				OrzUISetDB["IgnoreNotes"][name] = nil
			end
		end)
	end
end

MISC:RegisterMisc("IgnoreNote", MISC.IgnoreNote)