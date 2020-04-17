--------------------------------	Announce enemy drinking in arena(by Duffed)----------------------------------
local drinkSpell = {
	[GetSpellInfo(118358)] = true,	-- Drink
	[GetSpellInfo(167152)] = true,	-- Refreshment
	[GetSpellInfo(167268)] = true,	-- Ba'ruun's Bountiful Bloom
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
frame:SetScript("OnEvent", function(self, event, ...)
	if not (event == "UNIT_SPELLCAST_SUCCEEDED" and GetZonePVPInfo() == "arena") then return end

	local unit, _, spellID = ...
	if UnitIsEnemy("player", unit) and drinkSpell[GetSpellInfo(spellID)] then
		SendChatMessage(UnitClass(unit).." "..UnitName(unit)..TUTORIAL_TITLE11, CheckChat(true))
	end
end)

--------------------------------	Kill count ----------------------------------
local NextLimit = { 100, 500, 1000, 5000, 10000, 25000, 50000, 100000,250000,500000,1000000 }
local GetNextLimit = function(kills)
	for i =1, #NextLimit do
		if kills < NextLimit[i] then return NextLimit[i]
		elseif kills >= NextLimit[#NextLimit] then return
		end
	end
end
local oldKills = GetPVPLifetimeStats()
UIErrorsFrame:SetScript("OnUpdate",function(self,elapsed)
	self.nextUpdate = 0 + elapsed
	if self.nextUpdate > 1 then
		local newTime = GetTime()
		local newKills = GetPVPLifetimeStats()
		if newKills > oldKills then
			self:AddMessage(string.format(PVPPP_KILL_MSG, newKills, GetNextLimit(newKills)),1,1,0,1)
			oldKills = newKills
		elseif newKills == NextLimit[#NextLimit] then
			self:SetScript("OnUpdate",nil)
		end
		self.nextUpdate = 0
	end
end)

----------------------------------------------------------- KillingBlows---------------------------------------------------------
local KB_FILTER_ENEMY = bit.bor(
	COMBATLOG_OBJECT_AFFILIATION_PARTY,
	COMBATLOG_OBJECT_AFFILIATION_RAID,
	COMBATLOG_OBJECT_AFFILIATION_OUTSIDER,
	COMBATLOG_OBJECT_REACTION_NEUTRAL,
	COMBATLOG_OBJECT_REACTION_HOSTILE,
	COMBATLOG_OBJECT_CONTROL_PLAYER,
	COMBATLOG_OBJECT_TYPE_PLAYER
)
local Killmsg = CreateFrame("MessageFrame", "KilledItMessageFrame", UIParent)
Killmsg:SetWidth(512);
Killmsg:SetHeight(200);
Killmsg:SetPoint("TOP", 0, -200, "CENTER", 0, 200);
Killmsg:SetHeight(44)
Killmsg:SetInsertMode("TOP")
Killmsg:SetFrameStrata("HIGH")
Killmsg:SetTimeVisible(1.0)
Killmsg:SetFadeDuration(0.7)
Killmsg:SetScale(1.1)
Killmsg:SetFont(STANDARD_TEXT_FONT, 36, "OUTLINE")

local KillingBlows = CreateFrame("Frame") --Frame, nil, UIParent
KillingBlows:RegisterEvent("VARIABLES_LOADED")
KillingBlows:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
KillingBlows:SetScript("OnEvent", function(self, event, ...)
	if (event == "VARIABLES_LOADED") then self:UnregisterEvent("VARIABLES_LOADED")
	elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		local _, cmbEvent, _, sGUID, _, _, _, _, _, dFlag = select(1, ...)
		if (cmbEvent == "PARTY_KILL") then
			if (sGUID == UnitGUID("player") and CombatLog_Object_IsA(dFlag, KB_FILTER_ENEMY)) then
				PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Sonar.ogg", "Master")
				Killmsg:AddMessage("KILLING BLOW!", 1, 0, 0)
			end
		end
	end
end)

--[[--------------------------------------------------------- DuelCountdown------------## Author: meribold   ## Version: 1.0.3
DuelCountdown = {_G = _G}
setfenv(1, DuelCountdown)

local DuelCountdown = _G.DuelCountdown
local string, math, table = _G.string, _G.math, _G.table
local pairs, ipairs = _G.pairs, _G.ipairs
local assert, select, print = _G.assert, _G.select, _G.print
local MAGIC_NUMBER = 3
local handlerFrame = _G.CreateFrame("Frame")

-- Value of GetTime() at the start of the countdown timer animation.
local startTime

function startTimer()
  assert(_G.TimerTracker)
  _G.TimerTracker_OnEvent(_G.TimerTracker, "PLAYER_ENTERING_WORLD")
  _G.GetPlayerFactionGroup = function()
    return "Neutral"
  end
  _G.TimerTracker_OnEvent(_G.TimerTracker, "START_TIMER", _G.TIMER_TYPE_PVP, 3, 3)
  _G.GetPlayerFactionGroup = DuelCountdown.GetPlayerFactionGroup
  startTime = _G.GetTime()
end

function stopTimer()
  assert(_G.TimerTracker)
  _G.TimerTracker_OnEvent(_G.TimerTracker, "PLAYER_ENTERING_WORLD")
end

function handlerFrame:ADDON_LOADED(name)
  self:UnregisterEvent("ADDON_LOADED")

  assert(_G.GetPlayerFactionGroup)
  GetPlayerFactionGroup = _G.GetPlayerFactionGroup

  handlerFrame:RegisterEvent("DUEL_REQUESTED")
  handlerFrame:RegisterEvent("DUEL_INBOUNDS")
  --handlerFrame:RegisterEvent("DUEL_OUTOFBOUNDS")
  handlerFrame:RegisterEvent("DUEL_FINISHED")
  handlerFrame:RegisterEvent("CHAT_MSG_SYSTEM")

  self.ADDON_LOADED = nil
end

function handlerFrame:DUEL_FINISHED()
  --print("DuelCountdown: handlerFrame:DUEL_FINISHED called")
  if startTime and _G.GetTime() - startTime < MAGIC_NUMBER then
    DuelCountdown.stopTimer()
    startTime = nil
  end
end

function handlerFrame:CHAT_MSG_SYSTEM(message, _, _, _, _, _, _, channelNumber)
  if string.find(message, _G.DUEL_COUNTDOWN) then
    if string.find(message, '3') then DuelCountdown.startTimer() end
  end
end

handlerFrame:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, ...) end)
handlerFrame:RegisterEvent("ADDON_LOADED")]]