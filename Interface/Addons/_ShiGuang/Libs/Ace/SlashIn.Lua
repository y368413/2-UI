
local CTimerAfter = C_Timer.After
local print = print
local tonumber = tonumber
local MacroEditBox = MacroEditBox
local dummy = function() end
local function OnCallback(command)
	MacroEditBox:SetText(command)
	local ran = xpcall(ChatEdit_SendText, dummy, MacroEditBox)
	if not ran then
		print("|cff33ff99SlashIn:|r", "This command failed:", command)
	end
end

SLASH_SLASHIN1 = "/in"
SLASH_SLASHIN2 = "/slashin"

function SlashCmdList.SLASHIN(msg)
	local secs, command = msg:match("^([^%s]+)%s+(.*)$")
	secs = tonumber(secs)
	if (not secs) or (#command == 0) then
		print("|cff33ff99SlashIn:|r")
		print("|cff33ff99Usage:|r /in <seconds> <command>")
		print("|cff33ff99Example:|r /in 1.5 /emote rocks")
	else
		CTimerAfter(secs, function() OnCallback(command) end)
	end
end