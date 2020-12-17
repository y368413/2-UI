--## Version: 0.10.0
local Users = {}
local Timers = {}
local TimerData = {}
local CombinedFails = {}
local FailByAbility = {}
local activeUser = nil
local playerUser = GetUnitName("player",true).."-"..GetRealmName():gsub(" ", "")
local hardMinPct = 40

local Spells = {
	-- Debug
	--[252144] = 1,
	--[252150] = 1,
	
	-- Affixes
	[209862] = 20,		-- Volcanic Plume (Environment)
	[226512] = 20,		-- Sanguine Ichor (Environment)
	[240448] = 20,      -- Quaking (Environment)
	[343520] = 20,      -- Storming (Environment)
	
	-- Mists of Tirna Scythe
	[323250] = 20,      -- Anima Puddle (Droman Oulfarran)
	[325027] = 20,      -- Bramble Burst (Drust Boughbreaker)
	[336759] = 20,      --- Dodge Ball (Mistcaller)
	[326021] = 20,      --- Acid Globule (Spinemaw Gorger)
}

local SpellsNoTank = {
    -- Mists of Tirna Scythe
	[331721] = 20,      --- Spear Flurry (Mistveil Defender)
}

local Auras = {
    -- Mists of Tirna Scythe
    [323137] = true,      --- Bewildering Pollen (Drohman Oulfarran)
	[321893] = true,      --- Freezing Burst (Illusionary Vulpin)
}

local AurasNoTank = {
}

function round(number, decimals)
    return (("%%.%df"):format(decimals)):format(number)
end

local ElitismFrame = CreateFrame("Frame", "ElitismFrame")
ElitismFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
local MSG_PREFIX = "ElitismHelper"
local success = C_ChatInfo.RegisterAddonMessagePrefix(MSG_PREFIX)
ElitismFrame:RegisterEvent("CHAT_MSG_ADDON")
ElitismFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
ElitismFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
ElitismFrame:RegisterEvent("CHALLENGE_MODE_START")
ElitismFrame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
ElitismFrame:RegisterEvent("ADDON_LOADED")

ElitismFrame:ClearAllPoints()
ElitismFrame:SetHeight(100)
ElitismFrame:SetWidth(100)
ElitismFrame.text = ElitismFrame:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont")
ElitismFrame.text:SetAllPoints()
ElitismFrame.text:SetTextHeight(13)
ElitismFrame:SetAlpha(1)

function table.pack(...)
  return { n = select("#", ...), ... }
end

ElitismFrame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

function generateMaybeOutput(user)
	local func = function()
			local msg = "<EH> "..user.." → "
			local sending = false
			local _i = 0
			for spellID,amount in pairs(TimerData[user]) do
				local minPct = math.huge
				local spellMinPct = nil
				if Spells[spellID] then
					spellMinPct = Spells[spellID]
				elseif SpellsNoTank[spellID] then
					spellMinPct = SpellsNoTank[spellID]
				end
				if spellMinPct ~= nil and spellMinPct < minPct then
					minPct = spellMinPct
				end
				if minPct == math.huge then
					local spellNames = " "
					for spellID,amount in pairs(TimerData[user]) do
						spellNames = spellNames..GetSpellLink(spellID).." "
				end
				print("<XXX> : "..spellNames)
			end
			local userMaxHealth = UnitHealthMax(user)
			local msgAmount = round(amount/10000 ,1)
			local pct = Round(amount / userMaxHealth * 100)
			if pct >= hardMinPct and pct >= minPct then
					if _i > 0 then
						msg = msg.." & "..GetSpellLink(spellID).." "
					else
						msg = msg..GetSpellLink(spellID).." "
					end
				msg = msg.."X "..msgAmount..DANWEI_WAN.." (-"..pct.."%)."
					sending = true
					_i = _i + 1
				end
			end
			msg = msg.."."
			if sending then
				maybeSendChatMessage(msg)
			end
			TimerData[user] = nil
			Timers[user] = nil
		end
	return func
end

SLASH_ELITISMHELPER1 = "/eh"
SLASH_ELITISMHELPER2 = "/dmj"

SlashCmdList["ELITISMHELPER"] = function(msg,editBox)
	actions = {
		["activeuser"] = function()
			print("activeUser is "..activeUser)
			if activeUser == playerUser then
				print("You are the activeUser")
			end
		end,
		["resync"] = function()
			ElitismFrame:RebuildTable()
		end,
		["table"] = function()
			for k,v in pairs(Users) do
				print(k.." ;;; "..v)
			end
		end,
		["start"] = function()
			ElitismFrame:CHALLENGE_MODE_START()
		end,
		["eod"] = function()
			ElitismFrame:CHALLENGE_MODE_COMPLETED()
		end,
		["help"] = function()
			print("Elitism Helper options:")
			print(" start: Start logging failure damage")
			print(" eod: Dungeon is complete")
			print(" table: Prints users")
			print(" resync: Rebuilts table")
			print(" activeUser: Prints active user")
			print(" output: Define output channel between default | party | raid | yell | self")
		end,
		["messageTest"] = function()
			print("Testing output for self")
			maybeSendChatMessage("This is a test message")
		end,
		["list"] = function(args)
			local name = args
						
			if FailByAbility[name] == nil then
				name = GetUnitName(args, true)
			end
						
			if name == nil or FailByAbility[name] == nil then
				name = GetUnitName(args)
			end
				
			if name == nil or FailByAbility[name] == nil then
				for player,fails in pairs(FailByAbility) do
					print("Hits for "..player)
					for k,v in pairs(fails) do
						print("  " .. v.cnt .. "x" .. GetSpellLink(k) .. " = " .. round(v.sum / 1000, 1) .. "k")
					end
				end
			else
				--print("hits for " .. name)
				maybeSendChatMessage("Hits for "..name)
				
				local delay = 0;
				
				for k,v in pairs(FailByAbility[name]) do
					--print(v.cnt .. "x" .. GetSpellLink(k) .. " = " .. round(v.sum / 1000, 1) .. "k; " .. delay)
					--maybeSendChatMessage(v.cnt .. "x" .. GetSpellLink(k) .. " = " .. round(v.sum / 1000, 1) .. "k")
					delayMaybeSendChatMessage(v.cnt .. "x" .. GetSpellLink(k) .. " = " .. round(v.sum / 1000, 1) .. "k", delay * 0.1)
					delay = delay + 1
				end
			end
		end
	}

	local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
	local commandFunction = actions[cmd]
	if not commandFunction then
		commandFunction = actions["help"]
	end
	commandFunction(args)
end

function maybeSendAddonMessage(prefix, message)
	if IsInGroup() and not IsInGroup(2) and not IsInRaid() then
		C_ChatInfo.SendAddonMessage(prefix,message,"PARTY")
	elseif IsInGroup() and not IsInGroup(2) and IsInRaid() then
		C_ChatInfo.SendAddonMessage(prefix,message,"RAID")
	end
end

function maybeSendChatMessage(message)
	if activeUser ~= playerUser then return end
	print(message)
	--if IsInGroup() and not IsInGroup(2) and not IsInRaid() then SendChatMessage(message,"PARTY")
	--elseif IsInGroup() and not IsInGroup(2) and IsInRaid() then SendChatMessage(message,"RAID")
	--end	
end

function delayMaybeSendChatMessage(message, delay)
	C_Timer.After(
		delay,
		function()
			maybeSendChatMessage(message)
		end
	)
end

function ElitismFrame:RebuildTable()
	Users = {}
	activeUser = nil
	-- print("Reset Addon Users table")
	if IsInGroup() then
		maybeSendAddonMessage(MSG_PREFIX,"VREQ")
	else
		name = GetUnitName("player",true)
		activeUser = name.."-"..GetRealmName()
		-- print("We are alone, activeUser: "..activeUser)
	end
end

function ElitismFrame:ADDON_LOADED(event,addon)
	if addon == "_ShiGuang" then
		ElitismFrame:RebuildTable()
	end
end

function ElitismFrame:GROUP_ROSTER_UPDATE(event,...)
	-- print("GROUP_ROSTER_UPDATE")
	ElitismFrame:RebuildTable()
end

function ElitismFrame:ZONE_CHANGED_NEW_AREA(event,...)
	-- print("ZONE_CHANGED_NEW_AREA")
	ElitismFrame:RebuildTable()
end

function compareDamage(a,b)
	return a["value"] < b["value"]
end

function ElitismFrame:CHALLENGE_MODE_COMPLETED(event,...)
	local count = 0
	for _ in pairs(CombinedFails) do count = count + 1 end
	if count == 0 then
		print("No Damage?");
		--maybeSendChatMessage("Thank you for travelling with ElitismHelper. No failure damage was taken this run.")
		return
	else
		maybeSendChatMessage("Amount of failure damage:")
	end
	local u = { }
	for k, v in pairs(CombinedFails) do table.insert(u, { key = k, value = v }) end
	table.sort(u, compareDamage)
	for k,v in pairs(u) do
			maybeSendChatMessage(k..". "..v["key"].." "..round(v["value"] / 10000 ,1)..DANWEI_WAN)
	end
end

function ElitismFrame:CHALLENGE_MODE_START(event,...)
	CombinedFails = {}
	FailByAbility = {}
end

function ElitismFrame:CHAT_MSG_ADDON(event,...)
	local prefix, message, channel, sender = select(1,...)
	if prefix ~= MSG_PREFIX then
		return
	end
	if message == "VREQ" then
		maybeSendAddonMessage(MSG_PREFIX,"VANS;0.1")
	elseif message:match("^VANS") then
		Users[sender] = message
		for k,v in pairs(Users) do
			if activeUser == nil then
				activeUser = k
			end
			if k < activeUser then
				activeUser = k
			end
		end
	else
		-- print("Unknown message: "..message)
	end
end

function ElitismFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, aAmount)
	if (Spells[spellId] or (SpellsNoTank[spellId] and UnitGroupRolesAssigned(dstName) ~= "TANK")) and UnitIsPlayer(dstName) then
		-- Initialize TimerData and CombinedFails for Timer shot
		if TimerData[dstName] == nil then
			TimerData[dstName] = {}
		end
		if CombinedFails[dstName] == nil then
			CombinedFails[dstName] = 0
		end
		
		-- Add this event to TimerData / CombinedFails
		CombinedFails[dstName] = CombinedFails[dstName] + aAmount
		if TimerData[dstName][spellId] == nil then
			TimerData[dstName][spellId] = aAmount
		else
			TimerData[dstName][spellId] = TimerData[dstName][spellId] + aAmount
		end
		
		-- If there is no timer yet, start one with this event
		if Timers[dstName] == nil then
			Timers[dstName] = true
			C_Timer.After(3,generateMaybeOutput(dstName))
		end
		
		-- Add hit and damage to table
		if FailByAbility[dstName] == nil then
			FailByAbility[dstName] = {}
		end
		
		if FailByAbility[dstName][spellId] == nil then
			FailByAbility[dstName][spellId] = {
				cnt = 0,
				sum = 0
			}
		end
		
		FailByAbility[dstName][spellId].cnt = FailByAbility[dstName][spellId].cnt + 1
		FailByAbility[dstName][spellId].sum = FailByAbility[dstName][spellId].sum + aAmount
	end
end

function ElitismFrame:SwingDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, aAmount)
end

function ElitismFrame:AuraApply(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, auraAmount)
	if (Auras[spellId] or (AurasNoTank[spellId] and UnitGroupRolesAssigned(dstName) ~= "TANK")) and UnitIsPlayer(dstName)  then
		if auraAmount then
			maybeSendChatMessage("<EH> "..dstName.." → "..GetSpellLink(spellId)..". "..auraAmount.." Stacks.")
		else
			maybeSendChatMessage("<EH> "..dstName.." → "..GetSpellLink(spellId)..".")
		end
	end
end

function ElitismFrame:COMBAT_LOG_EVENT_UNFILTERED(event,...)
	local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2 = CombatLogGetCurrentEventInfo(); -- Those arguments appear for all combat event variants.
	local eventPrefix, eventSuffix = eventType:match("^(.-)_?([^_]*)$");
	if (eventPrefix:match("^SPELL") or eventPrefix:match("^RANGE")) and eventSuffix == "DAMAGE" then
		local spellId, spellName, spellSchool, sAmount, aOverkill, sSchool, sResisted, sBlocked, sAbsorbed, sCritical, sGlancing, sCrushing, sOffhand, _ = select(12,CombatLogGetCurrentEventInfo())
		ElitismFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, sAmount)
	elseif eventPrefix:match("^SWING") and eventSuffix == "DAMAGE" then
		local aAmount, aOverkill, aSchool, aResisted, aBlocked, aAbsorbed, aCritical, aGlancing, aCrushing, aOffhand, _ = select(12,CombatLogGetCurrentEventInfo())
		ElitismFrame:SwingDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, aAmount)
	elseif eventPrefix:match("^SPELL") and eventSuffix == "MISSED" then
		local spellId, spellName, spellSchool, missType, isOffHand, mAmount  = select(12,CombatLogGetCurrentEventInfo())
		if mAmount then
			ElitismFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, mAmount)
		end
	elseif eventType == "SPELL_AURA_APPLIED" then
		local spellId, spellName, spellSchool, auraType = select(12,CombatLogGetCurrentEventInfo())
		ElitismFrame:AuraApply(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType)
	elseif eventType == "SPELL_AURA_APPLIED_DOSE" then
		local spellId, spellName, spellSchool, auraType, auraAmount = select(12,CombatLogGetCurrentEventInfo())
		ElitismFrame:AuraApply(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, auraAmount)
	end
end
