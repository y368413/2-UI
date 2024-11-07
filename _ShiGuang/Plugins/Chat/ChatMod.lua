--[[--------------------------------------------------------------------
align
----------------------------------------------------------------------]]
SLASH_EA1 = "/align"
local AlignFrame
SlashCmdList["EA"] = function()
	if AlignFrame then
		AlignFrame:Hide()
		AlignFrame = nil		
	else
		AlignFrame = CreateFrame('Frame', nil, UIParent) 
		AlignFrame:SetAllPoints(UIParent)
		local AlignWide = GetScreenWidth() / 64
		local AlignHeight = GetScreenHeight() / 36
		for i = 0, 64 do
			local AlignTFrame = AlignFrame:CreateTexture(nil, 'BACKGROUND')
			if i == 32 then AlignTFrame:SetColorTexture(1, 0, 0, 0.5) else AlignTFrame:SetColorTexture(0, 0, 0, 0.5) end
			AlignTFrame:SetPoint('TOPLEFT', AlignFrame, 'TOPLEFT', i * AlignWide - 1, 0)
			AlignTFrame:SetPoint('BOTTOMRIGHT', AlignFrame, 'BOTTOMLEFT', i * AlignWide + 1, 0)
		end
		for i = 0, 36 do
			local AlignTFrame = AlignFrame:CreateTexture(nil, 'BACKGROUND')
			if i == 18 then AlignTFrame:SetColorTexture(1, 0, 0, 0.5)
			else AlignTFrame:SetColorTexture(0, 0, 0, 0.5) end
			AlignTFrame:SetPoint('TOPLEFT', AlignFrame, 'TOPLEFT', 0, -i * AlignHeight + 1)
			AlignTFrame:SetPoint('BOTTOMRIGHT', AlignFrame, 'TOPRIGHT', 0, -i * AlignHeight - 1)
		end	
	end
end


--[[---------ChatLootIcons----------------------------------------------------------------------
local function AddLootIcons(self, event, message, ...)
	local function Icon(link)
		local texture = GetItemIcon(link)
		return "\124T" .. texture .. ":" .. 12 .. "\124t" .. link
	end
	message = message:gsub("(\124c%x+\124Hitem:.-\124h\124r)", Icon)
	return false, message, ...
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", AddLootIcons)
	
--------------------------------------- 支持上下箭頭選取历史-- Author:M-------------------------------------
local ChatHistory = {}
local function AddHistoryLine(self, text)
    if (not text or text == "") then return end
    local type = self:GetAttribute("chatType")
    if (type == "WHISPER") then text = text:gsub("^/%w+%s*%S+%s*", "")
    elseif (string.find(text, "^/script")) then
    else text = text:gsub("^/%w+%s*", "") end
    if (text == "") then return end
    for i, v in ipairs(ChatHistory[self]) do
        if (v == text) then
            table.remove(ChatHistory[self], i)
            break
        end
    end
    table.insert(ChatHistory[self], 1, text)
end
local function GetHistoryLine(self, keyPress)
    local increment
    if (keyPress == "UP") then increment = 1
    elseif (keyPress == "DOWN") then increment = -1
    else return end
    ChatHistory[self].index = ChatHistory[self].index + increment
    local text = ChatHistory[self][ChatHistory[self].index]
    if (text) then self:SetText(text)
		self:SetCursorPosition(strlen(text))
    else ChatHistory[self].index = ChatHistory[self].index - increment end
end

local function ResetHistoryIndex(self)
    ChatHistory[self].index = 0
end

for i = 1, NUM_CHAT_WINDOWS do
    local editbox = _G["ChatFrame"..i.."EditBox"]
    ChatHistory[editbox] = { index = 0 }
    editbox:SetAltArrowKeyMode(false)
    editbox:HookScript("OnEditFocusLost", ResetHistoryIndex)
    editbox:HookScript("OnArrowPressed", GetHistoryLine)
    hooksecurefunc(editbox, "AddHistoryLine", AddHistoryLine)
end]]

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