local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:GetModule("Chat")

local _G = getfenv(0)
local gsub, format, tconcat, tostring = string.gsub, string.format, table.concat, tostring
local FCF_SetChatWindowFontSize = FCF_SetChatWindowFontSize
local ScrollFrameTemplate_OnMouseWheel = ScrollFrameTemplate_OnMouseWheel

local lines, menu, frame, editBox = {}

local function canChangeMessage(arg1, id)
	if id and arg1 == "" then return id end
end

local function isMessageProtected(msg)
	return msg and (msg ~= gsub(msg, "(:?|?)|K(.-)|k", canChangeMessage))
end

local function replaceMessage(msg, r, g, b)
	local hexRGB = M.HexRGB(r, g, b)
	--msg = gsub(msg, "|T(.-):.-|t", "%1") -- accept texture path or id
	--msg = gsub(msg, "|A(.-):.-|a", "%1") -- accept atlas path or id, needs review
	msg = gsub(msg, "|T(.-):.-|t", "")
	msg = gsub(msg, "|A(.-):.-|a", "")
	return format("%s%s|r", hexRGB, msg)
end

function module:GetChatLines()
	local index = 1
	for i = 1, self:GetNumMessages() do
		local msg, r, g, b = self:GetMessageInfo(i)
		if msg and not isMessageProtected(msg) then
			r, g, b = r or 1, g or 1, b or 1
			msg = replaceMessage(msg, r, g, b)
			lines[index] = tostring(msg)
			index = index + 1
		end
	end

	return index - 1
end

function module:ChatCopy_OnClick(btn)
	if btn == "LeftButton" then
		if not frame:IsShown() then
			local chatframe = _G.SELECTED_DOCK_FRAME
			local _, fontSize = chatframe:GetFont()
			FCF_SetChatWindowFontSize(chatframe, chatframe, .01)
			frame:Show()

			local lineCt = module.GetChatLines(chatframe)
			local text = tconcat(lines, "\n", 1, lineCt)
			FCF_SetChatWindowFontSize(chatframe, chatframe, fontSize)
			editBox:SetText(text)
		else
			frame:Hide()
		end
	elseif btn == "RightButton" then
		M:TogglePanel(menu)
		R.db["Chat"]["ChatMenu"] = menu:IsShown()
	end
end

local function ResetChatAlertJustify(frame)
	frame:SetJustification("LEFT")
end

function module:ChatCopy_CreateMenu()
	menu = CreateFrame("Frame", nil, UIParent)
	menu:SetSize(25, 100)
	menu:SetPoint("TOPLEFT", _G.ChatFrame1, "TOPRIGHT", 15, 0)
	menu:SetShown(R.db["Chat"]["ChatMenu"])

	_G.ChatFrameMenuButton:ClearAllPoints()
	_G.ChatFrameMenuButton:SetPoint("TOP", menu)
	_G.ChatFrameMenuButton:SetParent(menu)
	_G.ChatFrameChannelButton:ClearAllPoints()
	_G.ChatFrameChannelButton:SetPoint("TOP", _G.ChatFrameMenuButton, "BOTTOM", 0, -2)
	_G.ChatFrameChannelButton:SetParent(menu)
	_G.ChatFrameToggleVoiceDeafenButton:SetParent(menu)
	_G.ChatFrameToggleVoiceMuteButton:SetParent(menu)
	_G.QuickJoinToastButton:SetParent(menu)

	_G.ChatAlertFrame:ClearAllPoints()
	_G.ChatAlertFrame:SetPoint("BOTTOMLEFT", _G.ChatFrame1Tab, "TOPLEFT", 5, 25)
	ResetChatAlertJustify(_G.ChatAlertFrame)
	hooksecurefunc(_G.ChatAlertFrame, "SetChatButtonSide", ResetChatAlertJustify)
end

function module:ChatCopy_Create()
	frame = CreateFrame("Frame", "NDuiChatCopy", UIParent)
	frame:SetPoint("CENTER")
	frame:SetSize(700, 400)
	frame:Hide()
	frame:SetFrameStrata("DIALOG")
	M.CreateMF(frame)
	M.SetBD(frame)
	frame.close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	frame.close:SetPoint("TOPRIGHT", frame)

	local scrollArea = CreateFrame("ScrollFrame", "ChatCopyScrollFrame", frame, "UIPanelScrollFrameTemplate, BackdropTemplate")
	scrollArea:SetPoint("TOPLEFT", 10, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", -28, 10)

	editBox = CreateFrame("EditBox", nil, frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFont(I.Font[1], 12, "")
	editBox:SetWidth(scrollArea:GetWidth())
	editBox:SetHeight(scrollArea:GetHeight())
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
	editBox:SetScript("OnTextChanged", function(_, userInput)
		if userInput then return end
		local _, max = scrollArea.ScrollBar:GetMinMaxValues()
		for i = 1, max do
			ScrollFrameTemplate_OnMouseWheel(scrollArea, -1)
		end
	end)

	scrollArea:SetScrollChild(editBox)
	scrollArea:HookScript("OnVerticalScroll", function(self, offset)
		editBox:SetHitRectInsets(0, 0, offset, (editBox:GetHeight() - offset - self:GetHeight()))
	end)

	local copy = CreateFrame("Button", "NDuiChatCopyButton", UIParent)
	copy:SetPoint("BOTTOMRIGHT", _G.ChatFrame1, 15, -6)
	copy:SetSize(20, 14)
	copy:SetAlpha(.5)
	copy.Icon = copy:CreateTexture(nil, "ARTWORK")
	copy.Icon:SetAllPoints()
	copy.Icon:SetTexture(I.copyTex)
	copy:RegisterForClicks("AnyUp")
	copy:SetScript("OnClick", self.ChatCopy_OnClick)
	local copyStr = format(U["Chat Copy"], I.LeftButton, I.RightButton)
	M.AddTooltip(copy, "ANCHOR_RIGHT", copyStr)
	copy:HookScript("OnEnter", function() copy:SetAlpha(1) end)
	copy:HookScript("OnLeave", function() copy:SetAlpha(.5) end)

	M.ReskinClose(frame.close)
	M.ReskinScroll(ChatCopyScrollFrameScrollBar)
end

function module:ChatCopy()
	self:ChatCopy_CreateMenu()
	self:ChatCopy_Create()
end


--------------------------------------- 聊天信息複製-- Author:M-------------------------------------
local CHAT_WHISPER_GET = CHAT_WHISPER_GET or ">>%s:"
local CHAT_WHISPER_INFORM_GET = CHAT_WHISPER_INFORM_GET or "<<%s:"

--注意規則順序, button(LeftButton/RightButton)可以指定鼠標左右鍵使用不同的邏輯
local rules = {
    { pat = "|c%x+|HChatCopy|h.-|h|r",      repl = "" },   --去掉本插件定義的鏈接
    { pat = "|c%x%x%x%x%x%x%x%x(.-)|r",     repl = "%1" }, --替換所有顔色值
    { pat = CHAT_WHISPER_GET:gsub("%%s",".-"), repl = "", button = "LeftButton" }, --密語
    { pat = CHAT_WHISPER_INFORM_GET:gsub("%%s",".-"), repl = "", button = "LeftButton" }, --密語
    { pat = "|Hchannel:.-|h.-|h",           repl = "", button = "LeftButton" }, --(L)去掉頻道文字
    { pat = "|Hplayer:.-|h.-|h" .. ":",     repl = "", button = "LeftButton" }, --(L)去掉發言玩家名字
    { pat = "|Hplayer:.-|h.-|h" .. "：",    repl = "", button = "LeftButton" }, --(L)去掉發言玩家名字
    { pat = "|HBNplayer:.-|h.-|h" .. ":",   repl = "", button = "LeftButton" }, --(L)去掉戰網發言玩家名字
    { pat = "|HBNplayer:.-|h.-|h" .. "：",  repl = "", button = "LeftButton" }, --(L)去掉戰網發言玩家名字
    { pat = "|Hchannel:.-|h(.-)|h",         repl = "%1", button = "RightButton" }, --(R)留下頻道文字
    { pat = "|Hplayer:.-|h(.-)|h",          repl = "%1", button = "RightButton" }, --(R)留下發言玩家名字
    { pat = "|HBNplayer:.-|h(.-)|h",        repl = "%1", button = "RightButton" }, --(R)留下戰網發言玩家名字
    { pat = "|H.-|h(.-)|h",                 repl = "%1" },  --替換所有超連接
    { pat = "|TInterface\\TargetingFrame\\UI%-RaidTargetingIcon_(%d):0|t", repl = "{rt%1}" },
    { pat = "|T.-|t",                       repl = "" },    --替換所有素材
    { pat = "|[rcTtHhkK]",                  repl = "" },    --去掉單獨的|r|c|K
    { pat = "^%s+",                         repl = "" },    --去掉空格
}
--替換字符
local function ClearMessage(msg, button)
    for _, rule in ipairs(rules) do
        if (not rule.button or rule.button == button) then msg = msg:gsub(rule.pat, rule.repl) end
    end
    return msg
end
--顯示信息
local function ShowMessage(msg, button)
    local editBox = ChatEdit_ChooseBoxForSend()
    msg = ClearMessage(msg, button)
    ChatEdit_ActivateChat(editBox)
    editBox:SetText(editBox:GetText() .. msg)
    editBox:HighlightText()
end
--獲取複製的信息
local function GetMessage(...)
    local object
    for i = 1, select("#", ...) do
        object = select(i, ...)
        if (object:IsObjectType("FontString") and MouseIsOver(object)) then
            return object:GetText()
        end
    end
    return ""
end
--HACK
local _SetItemRef = SetItemRef
SetItemRef = function(link, text, button, chatFrame)
    if (chatFrame and link:sub(1,8) == "ChatCopy") then
        local msg = GetMessage(chatFrame.FontStringContainer:GetRegions())
        return ShowMessage(msg, button)
    end
    _SetItemRef(link, text, button, chatFrame)
end

local function AddMessage(self, text, ...)
    if (type(text) ~= "string") then
        text = tostring(text)
    end
    if (CHAT_TIMESTAMP_FORMAT) then
        if (not string.find(CHAT_TIMESTAMP_FORMAT, "ChatCopy")) then
            CHAT_TIMESTAMP_FORMAT = "|cff68ccef|HChatCopy|h"..CHAT_TIMESTAMP_FORMAT.."|h|r"
        end
        if (not string.find(text, "%|HChatCopy%|h")) then
            text = format("|cff68ccef|HChatCopy|h%s|h|r%s", BetterDate(CHAT_TIMESTAMP_FORMAT, time()), text)
        end
    else
        text = format("|cff68ccef|HChatCopy|h%s|h|r%s", ">", text)
    end
    self.OrigAddMessage(self, text, ...)
end

for i = 1, NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i]
    if (chatFrame) then
        chatFrame.OrigAddMessage = chatFrame.AddMessage
        chatFrame.AddMessage = AddMessage
    end
end