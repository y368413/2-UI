local SkadaWindowName = "D/HPS"

local function SkadaFormatNumber(self,number)
    if number then
        if self.db.profile.numberformat == 1 then
            if number > 100000000 then -- 亿
                return ("%02.2f亿"):format(number / 100000000)
            end
            if number > 100000 then    -- 十万
                return ("%d万"):format(number / 10000)
            end
            return ("%02.2f万"):format(number / 10000)
        else
            return math.floor(number)
        end
    end
end

local function GetChatFrameIndex(cname)
	local skadatabindex = 0
	for i = 1, NUM_CHAT_WINDOWS do
		name, _, _, _, _, _, _, _, _, _ = GetChatWindowInfo(i)
		if name == cname then
			skadatabindex = i
			break
		end
	end
	return skadatabindex
end

local function CreateSkadaWindow()
    local index = GetChatFrameIndex(SkadaWindowName)
    if index == 0 then
        FCF_OpenNewWindow(SkadaWindowName)
        index = GetChatFrameIndex(SkadaWindowName)
    else
        local chatFrame = _G['ChatFrame' .. index]
        chatTab = _G["ChatFrame"..index.."Tab"];
        chatFrame:Show();
        chatTab:Show();
        FCF_DockFrame(chatFrame, (#FCFDock_GetChatFrames(GENERAL_CHAT_DOCK)+1), true);
        FCF_SelectDockFrame(ChatFrame1)
        FCF_FadeInChatFrame(FCFDock_GetSelectedWindow(GENERAL_CHAT_DOCK));
    end
    local chatframe = _G['ChatFrame' .. index]
    if chatframe then
        ChatFrame_RemoveAllChannels(chatframe)
        ChatFrame_RemoveAllMessageGroups(chatframe)
    end

    FCF_SelectDockFrame(DEFAULT_CHAT_FRAME)
    FCF_FadeInChatFrame(FCFDock_GetSelectedWindow(GENERAL_CHAT_DOCK));
end

local function ShowSkadaWindow()
    local cindex = GetChatFrameIndex(SkadaWindowName)
    if not cindex then return end
    local chattab = _G['ChatFrame' .. cindex]
    local windex = 1
    if windex ~= 0 then
        local sw = Skada:GetWindows()
        if sw[windex].db.hidden then
            sw[windex].db.hidden = false
        end
        sw[windex].bargroup:ClearAllPoints()
        if sw[windex].db.reversegrowth then
            sw[windex].bargroup:SetPoint('TOP', chattab, 'TOP', 0, 0)
        else
            sw[windex].bargroup:SetPoint('TOP', chattab, 'TOP', 0, (sw[windex].db.enabletitle and -1 * sw[windex].db.barheight) or 0)
        end
        sw[windex]:Show()
    end
end

local function HideSkadaWindow()
    local cindex = GetChatFrameIndex(SkadaWindowName)
    if not cindex then return end
    local windex = 1
    local sw = Skada:GetWindows()
    if windex ~= 0 then
        if not sw[windex].db.hidden then
            sw[windex].db.hidden = true
        end
        sw[windex]:Hide()
    end
end

local function EmbedSkada()
    local windex = 1
    local index = GetChatFrameIndex(SkadaWindowName)
    if not index then return end
    if index == 0 or index > NUM_CHAT_WINDOWS then return end
    local shown = false
    local chattab = _G['ChatFrame' .. index]
    local sw = Skada:GetWindows()
    _, _, _, _, _, _, shown, _, _, _ = GetChatWindowInfo(index)
    if not sw[windex] then
        return
    end
    sw[windex].db.barwidth = chattab:GetWidth()
    if sw[windex].db.enabletitle then
        sw[windex].db.background.height = chattab:GetHeight() - sw[windex].db.barheight + 3
    else
        sw[windex].db.background.height = chattab:GetHeight() + 3
    end
    sw[windex].db.hidden = not shown
    sw[windex].db.barslocked = true
    Skada:ApplySettings()
    sw[windex].bargroup:ClearAllPoints()
    if sw[windex].db.reversegrowth then
        sw[windex].bargroup:SetPoint('TOP', chattab, 'TOP', 0, 0)
    else
        sw[windex].bargroup:SetPoint('TOP', chattab, 'TOP', 0, (sw[windex].db.enabletitle and -1 * sw[windex].db.barheight) or 0)
    end
    sw[windex]:UpdateDisplay(true)
end

local function HookSkada()
    local index = GetChatFrameIndex(SkadaWindowName)
    if index == 0 or index > NUM_CHAT_WINDOWS then return end
    local chattab = _G['ChatFrame' .. index]	-- that tab
    chattab:HookScript('OnShow', function(self)
        ShowSkadaWindow()
    end)
    chattab:HookScript('OnHide', function(self)
        HideSkadaWindow()
    end)
    chattab:HookScript('OnSizeChanged', function(self,w,h)
        EmbedSkada()
    end)
end

local frame = CreateFrame('Frame', nil)
frame:SetScript('OnEvent', function(self, event)
    --Skada.FormatNumber = SkadaFormatNumber
    CreateSkadaWindow()
    EmbedSkada()
    HookSkada()
end)
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
