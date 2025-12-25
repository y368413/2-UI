--[[
Skada Chat Frame Integrator by Raka@Raka.Rocks
Embed Skada Damage Meter window to a Chat window.

Usage:
1. Create chat windows you want Skada window to fit in.
2. By default, the first Skada window will be embedded into "Skada" chat window, but there're more options now, see below.
2-1. You can manually embed a Skada window to any Chat window you want by using command: /scfi n x , where n is the number of Skada Window, x is the name of the chat window. For example, if you want to embed the second Skada window into Chat window called "Threat", use command /scfi 2 threat .
2-2. The addon will automatically remember this operation and save it to a per-character settings file.
2-3. After that you can use /scfi to embed all windows you previously done embedding.
2-4. If you don't know the numbers of Skada Windows, use command "/scfi stat" to get them.
2-5. If you want to release a Skada window from chat window, use command "/scfi rm n", where n is the number of the Skada Window. Or just reset(see below) and re-integrate again.
2-6. If you want to reset all the settings you have done before, use command "/scfi reset" and addon will fall back to its default behaviors after a UI reload.
3. If this addon failed to embed Skada windows, use /skadacfi or /scfi to manually embed.
4. When in doubt, /reload.
]]
local Skada = Skada
local SCFI = {}

if not ScfiDB then
	ScfiDB = {
		[1] = 'skada'
	}
end

--locale
local L = {}
if (GetLocale() == 'zhCN') then
	L = {
		'|cFFFF5151SkadaCFI|r: 请新建一个新的"%s"聊天窗口，然后执行/SkadaCFI或/scfi。',
		'|cFFFF5151SkadaCFI|r: 整合失败。找不到Skada窗口%d。',
		'|cFFFF5151SkadaCFI|r: 执行整合中……',
		'|cFFFF5151SkadaCFI|r: 尝试整合Skada窗口 #%d 到聊天窗口 %s ...',
		'===SCFI:当前Skada窗口===',
		'窗口ID：%d ，窗口标题：%s ',
		'|cFFFF5151SkadaCFI|r: 释放Skada窗口 #%d ...'
	}
else
	L = {
		'|cFFFF5151SkadaCFI|r: Please Create a new chat tab called "%s" then SkadaCFI or /scfi.',
		'|cFFFF5151SkadaCFI|r: Integrate failed. Skada window #%d not found.',
		'|cFFFF5151SkadaCFI|r: Integrating...',
		'|cFFFF5151SkadaCFI|r: Trying to integrate Skada Window #%d to Chat window %s ...',
		'===SCFI: Current Skada Windows===',
		'Window ID： %d , Window Title: %s ',
		'|cFFFF5151SkadaCFI|r: Releasing Skada Window #%d ...'
	}
end

SCFI.L = L

function SCFI:GetSkadaChatFrame(cname) --Find Chat Tab named cname
	local skadatabindex = 0
	for i = 1, NUM_CHAT_WINDOWS do
		name, _, _, _, _, _, _, _, _, _ = GetChatWindowInfo(i)
		if string.lower(name) == string.lower(cname) then
			skadatabindex = i
			break
		end
	end
	
	if skadatabindex == 0 then
		--print(string.format(SCFI.L[1], cname))
	end
	
	return skadatabindex
end

function SCFI:EmbedSkada(index, windex)
	if not index then return end
	if index == 0 or index > NUM_CHAT_WINDOWS then return end
	local shown = false
	local chattab = _G['ChatFrame' .. index]
	local sw = Skada:GetWindows()
	_, _, _, _, _, _, shown, _, _, _ = GetChatWindowInfo(index)
	if not sw[windex] then
		print(string.format(SCFI.L[2], windex))
		if ScfiDB[windex] then
			ScfiDB[windex] = nil
		end
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

function SCFI:ShowSkadaWindow(cindex)
	if not cindex then return end
	local chattab = _G['ChatFrame' .. cindex]
	local windex = SCFI:IDtoSW(cindex)
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
		Skada:ApplySettings()
	end
end

function SCFI:HideSkadaWindow(cindex)
	if not cindex then return end
	local windex = SCFI:IDtoSW(cindex)
	local sw = Skada:GetWindows()
	if windex ~= 0 then
		if not sw[windex].db.hidden then
			sw[windex].db.hidden = true
		end
		sw[windex]:Hide()
		Skada:ApplySettings()
	end
end

function SCFI:IDtoSW(cindex)
	for k, v in ipairs(ScfiDB) do
		local i = SCFI:GetSkadaChatFrame(v)
		if tonumber(i) == tonumber(cindex) then
			return k
		end
	end
	return 0
end

function SCFI:BindSkadaToChatFrame(index)
	if not index then return end
	if index == 0 or index > NUM_CHAT_WINDOWS then return end
	local chattab = _G['ChatFrame' .. index]	-- that tab
	chattab:HookScript('OnShow', function(self)
		SCFI:ShowSkadaWindow(self:GetName():match('[%d-]$'))
	end)
	chattab:HookScript('OnHide', function(self)
		SCFI:HideSkadaWindow(self:GetName():match('[%d-]$'))
	end)
end

function SCFI:CoreFunction()
	if not ScfiDB then return end
	for k, v in ipairs(ScfiDB) do
		local i = SCFI:GetSkadaChatFrame(v)
		local chatframe = _G['ChatFrame' .. i]
		if chatframe then
			ChatFrame_RemoveAllChannels(chatframe)
			ChatFrame_RemoveAllMessageGroups(chatframe)
			SCFI:EmbedSkada(i, k)
			SCFI:BindSkadaToChatFrame(i)
		end
	end
end

_G.SCFI = SCFI

--Try to embed on startup
local frame = CreateFrame('Frame', nil)
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:SetScript('OnEvent', function(self, event)
	SCFI:CoreFunction()
	self:UnregisterAllEvents()
	self = nil
end)

--Manually embed
SLASH_SCFI1, SLASH_SCFI2 = '/skadacfi', '/scfi'
local function aphandler(msg)
	local arg1, arg2 = msg:match('^(%S*)%s*(.-)$')
	if string.len(arg1) > 0 and string.len(arg2) > 0 then
		if string.lower(arg1) ~= 'rm' then
			print(string.format(L[4], arg1, arg2))
			local i = SCFI:GetSkadaChatFrame(arg2)
			if tonumber(i) ~= 0 then
				SCFI:EmbedSkada(i, tonumber(arg1))
				SCFI:BindSkadaToChatFrame(i)
				ScfiDB[tonumber(arg1)] = arg2
			end
		else
			print(string.format(L[7], arg2))
			local i = tonumber(arg2)
			local sw = Skada:GetWindows()
			if sw[i] then
				if ScfiDB[i] then
					ScfiDB[i] = nil
				end
				sw[i].db.barslocked = false
				sw[i].db.hidden = false
				Skada:ApplySettings()
			else
				print(string.format(SCFI.L[2], i))
			end
		end
	elseif string.lower(arg1) == 'reset' then
		ScfiDB = {
			[1] = 'skada'
		}
		for i, win in ipairs(Skada:GetWindows()) do
			win.db.barslocked = false
			win.db.hidden = false
		end
		Skada:ApplySettings()
		ReloadUI()
	elseif string.lower(arg1) == 'stat' then
		print(SCFI.L[5])
		for i, win in ipairs(Skada:GetWindows()) do
			print(string.format(SCFI.L[6], i, win.db.name or 'Skada'))
		end
	else
		print(SCFI.L[3])
		SCFI:CoreFunction()
	end
	for i, win in ipairs(Skada:GetWindows()) do
		win:UpdateDisplay(true)
	end
end
SlashCmdList['SCFI'] = aphandler