if (GAME_LOCALE or GetLocale()) == "zhCN" then SKADAACTIVITY = "活跃度" SKADAACTIVITYLOG = "活跃度记录" SKADAACTIVITYDEATHS = "死亡排名"
elseif (GAME_LOCALE or GetLocale()) == "zhTW" then SKADAACTIVITY = "活躍度" SKADAACTIVITYLOG = "活躍度記錄" SKADAACTIVITYDEATHS = "死亡排名"
else SKADAACTIVITY = "Activity" SKADAACTIVITYLOG = "Activity Log" SKADAACTIVITYDEATHS = "Activity_Deaths"
end

local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)
local Skada = Skada
local mod = Skada:NewModule(SKADAACTIVITY)
local activitylog = Skada:NewModule(SKADAACTIVITYLOG)
local deathlog = Skada:NewModule(SKADAACTIVITYDEATHS)


local function Activity_tooltip(win, id, label, tooltip)
	local set = win:get_selected_set()
	if set == Skada.Current then
	local sets = Skada:GetSets()
	set = sets[1]
	end
	local player = Skada:find_player(set, id)

	if player then
		tooltip:AddLine(player.name)
		sessionacti,sessionpossi,totalacti,totalpossi,sessiontext,totaltext = session_perma(set,player)
		if set == Skada.total then
			if SessionActivity[player.id] then
				if player.damage/sessionacti > player.healing/sessionacti then
					tooltip:AddDoubleLine("DPS:", Skada:FormatNumber(player.damage/sessionacti), 255,255,255,255,0.3,0.3)
					tooltip:AddDoubleLine("HPS:", Skada:FormatNumber(player.healing/sessionacti), 255,255,255,0.8,255,0.8)
				else
					tooltip:AddDoubleLine("DPS:", Skada:FormatNumber(player.damage/sessionacti), 255,255,255,255,0.8,0.8)
					tooltip:AddDoubleLine("HPS:", Skada:FormatNumber(player.healing/sessionacti), 255,255,255,0.3,255,0.3)
				end
				tooltip:AddDoubleLine("DTPS:", Skada:FormatNumber(player.damagetaken/sessionacti), 255,255,255,255,0.7,0.5)
			else
				active = "nil"
				total = "nil"
			end
				tooltip:AddDoubleLine(" "," ",0,0,0,0,0,0)
		else
			if player.damage/Skada:PlayerActiveTime(set, player) > player.healing/Skada:PlayerActiveTime(set, player) then
				tooltip:AddDoubleLine("DPS:", Skada:FormatNumber(player.damage/Skada:PlayerActiveTime(set, player)), 255,255,255,255,0.3,0.3)
				tooltip:AddDoubleLine("HPS:", Skada:FormatNumber(player.healing/Skada:PlayerActiveTime(set, player)), 255,255,255,0.8,255,0.8)
			else
				tooltip:AddDoubleLine("DPS:", Skada:FormatNumber(player.damage/Skada:PlayerActiveTime(set, player)), 255,255,255,255,0.8,0.8)
				tooltip:AddDoubleLine("HPS:", Skada:FormatNumber(player.healing/Skada:PlayerActiveTime(set, player)), 255,255,255,0.3,255,0.3)
			end
			tooltip:AddDoubleLine("DTPS:", Skada:FormatNumber(player.damagetaken/Skada:PlayerActiveTime(set, player)), 255,255,255,255,0.7,0.5)
				tooltip:AddDoubleLine(" "," ",0,0,0,0,0,0)
				tooltip:AddDoubleLine("Displayed Fight Activity:", Skada:PlayerActiveTime(set, player).. "/" ..settime(set) .." s (-".. math.floor(math.min(12,settime(set)/10)*10)/10 .."s)" , 255,255,255,255,255,255)
		end

		

		if sessionpossi then
			tooltip:AddDoubleLine("Session Activity:", math.floor(sessionacti).."/".. math.floor(sessionpossi+0.5) .. " s", 255,255,255,255,255,255)
		end
		if totalpossi then
			tooltip:AddDoubleLine("Permanent Recorded Activity:", math.floor(totalacti).."/".. math.floor(totalpossi+0.4) .. " s" , 255,255,255,255,255,255)
		end
	end
end

function settime(set)
	if set.time > 0 then
		return set.time
	else
		return (time() - set.starttime)
	end
end

function session_perma(set,player)
	if not SessionActivity[player.id] then
		sessionacti = 0
		sessionpossi = 0
	else
		sessionacti = SessionActivity[player.id].activity
		sessionpossi = SessionActivity[player.id].possible
	end
	if not PermanentActivity[player.id] then
		totalacti = 0
		totalpossi = 0
	else
		totalacti = PermanentActivity[player.id].activity
		totalpossi = PermanentActivity[player.id].possible
	end
	
	if (not set.endtime or set.stopped or set.time == 0) and Skada.current then

		if Skada:PlayerActiveTime(Skada.current, player) > (settime(Skada.current)-math.min(12,settime(Skada.current)/10)) then 
			sessionacti = sessionacti + Skada:PlayerActiveTime(Skada.current, player)
			sessionpossi = sessionpossi + Skada:PlayerActiveTime(Skada.current, player)
			totalacti = totalacti + Skada:PlayerActiveTime(Skada.current, player)
			totalpossi = totalpossi + Skada:PlayerActiveTime(Skada.current, player)
		else
			sessionacti = sessionacti + Skada:PlayerActiveTime(Skada.current, player)
			sessionpossi = sessionpossi + math.max (1,settime(Skada.current)-math.min(12,settime(Skada.current)/10))
			totalacti = totalacti + Skada:PlayerActiveTime(Skada.current, player)
			totalpossi = totalpossi + math.max (1,settime(Skada.current)-math.min(12,settime(Skada.current)/10))
		end
	end
	if sessionpossi >0 then
		sessiontext= math.floor(sessionacti /sessionpossi *1000)/10 .."%"

	else
		sessiontext = "nil"
	end
	if totalpossi >0 then
		totaltext = math.floor(totalacti/totalpossi*1000)/10 .."%"
	else
		totaltext = "nil"
	end
	return sessionacti,sessionpossi,totalacti,totalpossi,sessiontext,totaltext
end

function mod:Update(win, set)
	local segmenttext = "nil"
	local totaltext = "nil"
	local segmentactivity = 0
	local segmentpossible = 0
	local totalactivity = 0
	local totalpossible = 0
	if not SessionActivity then return end
	if set == Skada.total then
		local n = 1
		for i, player in ipairs(set.players) do
			if player.damage > 0 or player.healing > 0 or player.damagetaken > 0 then
				local d = win.dataset[n] or {}
				win.dataset[n] = d
				d.label = player.name
				d.id = player.id


				segmentactivity,segmentpossible,_,_,segmenttext,totaltext = session_perma(set,player)
					if segmentpossible >0 then
						
						d.value = math.floor(segmentactivity /segmentpossible *100)
					else
						
						d.value = 0
					end
				if totaltext == segmenttext then
					totaltext = "="
				end
				

				d.valuetext = Skada:FormatValueText(
					segmenttext, self.metadata.columns.Damage,
					totaltext, self.metadata.columns.DPS
					)
				d.class = player.class
				d.role = player.role
				n = n + 1
			end
		end
		
		win.metadata.maxvalue = 100
	else
		local n = 1
		local totalactivity = 0
		local totalpossible = 0
		for i, player in ipairs(set.players) do
			if player.damage > 0 or player.healing > 0 or player.damagetaken > 0 then

				local d = win.dataset[n] or {}
				win.dataset[n] = d
				d.id = player.id
				d.label = player.name
				
				-- since there is a penalty time of 10% - 12 seconds, we dont want to confuse players with contradictory numbers
				if Skada:PlayerActiveTime(set, player) > (settime(set)-math.min(12,settime(set)/10)) then 
					segmenttext = "100%"
					d.value = 100
				else
					segmenttext =  math.floor(Skada:PlayerActiveTime(set, player)/(settime(set)-math.min(12,settime(set)/10))*1000)*0.1 .. "%"
					d.value = math.floor(Skada:PlayerActiveTime(set, player)/math.max (1,settime(set)-math.min(12,settime(set)/10))*100)
				end
				if not SessionActivity[player.id] then
					totalactivity = 0
					totalpossible = 0
				else
					totalactivity = SessionActivity[player.id].activity
					totalpossible = SessionActivity[player.id].possible
				end
				
				if not set.endtime or set.stopped or set.time == 0 then
					totalactivity=totalactivity+Skada:PlayerActiveTime(set, player)
					totalpossible=totalpossible+settime(set)					
				end
				if totalpossible == 0 then
					totaltext = "nil"
				else
					totaltext = math.floor(totalactivity / totalpossible*1000)/10 .. "%"
				end
				Skada:PlayerActiveTime(set, player)
				d.valuetext = Skada:FormatValueText(
					segmenttext, self.metadata.columns.Damage,
					totaltext, self.metadata.columns.DPS
					)
				d.class = player.class
				d.role = player.role
				n = n + 1
			end
		end
		
		win.metadata.maxvalue = 100
	end

end

function activitylog:Update(win, set)
local player = Skada:get_player(set, self.playerid)

local n = 1
if not SessionActivity[player.id].sets then return end
while (SessionActivity[player.id].sets[n]) do
local d = win.dataset[n] or {}

win.dataset[n] = d

	d.label = SessionActivity[player.id].sets[n].activity .. " / " .. math.floor(SessionActivity[player.id].sets[n].possible)

	d.id = n.."/"..player.id
	d.value = SessionActivity[player.id].sets[n].activity / SessionActivity[player.id].sets[n].possible *100
	d.color = {r = 2- d.value/50, g = d.value/50, b = 0, a = 1}
	d.valuetext = Skada:FormatValueText(
		math.floor(d.value*10)/10 .."%", self.metadata.columns.Damage
		)
	d.class = player.class
	d.role = player.role
	n = n + 1

end
win.metadata.maxvalue = 100
end

function activitylog:Enter(win, id, label)
	activitylog.playerid = id
	activitylog.title = label:gsub(": .*$","").."'s Activity"
end


	--[[Deathlog Code from Skada --]]				function deathlog:Enter(win, id, label)
	--[[Deathlog Code from Skada --]]					deathlog.playerid = id
	--[[Deathlog Code from Skada --]]					deathlog.title = label:gsub(": .*$","")..L["'s Death"]
	--[[Deathlog Code from Skada --]]				end
    --[[Deathlog Code from Skada --]]
	--[[Deathlog Code from Skada --]]				local green = {r = 0, g = 255, b = 0, a = 1}
	--[[Deathlog Code from Skada --]]				local red = {r = 255, g = 0, b = 0, a = 1}
    --[[Deathlog Code from Skada --]]
	--[[Deathlog Code from Skada --]]				local function cmp_ts(a,b) 
	--[[Deathlog Code from Skada --]]					return a and b and a.ts > b.ts 
	--[[Deathlog Code from Skada --]]				end
    --[[Deathlog Code from Skada --]]
	--[[Deathlog Code from Skada --]]				-- Death log.
	--[[Deathlog Code from Skada --]]				function deathlog:Update(win, set)
											local words = {}
											for word in string.gmatch(self.playerid, '([^/]+)') do
												table.insert(words,word)
											end
											local deathid = words[1]
											local playerid = words[2]
											
											set = nil
											for i,sets in ipairs(Skada:GetSets()) do
												if tostring(i) == deathid then
													set = sets
												end
											end
											

	--	for _, player in ipairs (set.players) do
											if set then
	--[[code from skada, changed playerid --]]				local player = Skada:get_player(set, playerid)
	--[[Deathlog Code from Skada --]]						if player and player.deaths then
	--[[Deathlog Code from Skada --]]							local nr = 1
	--[[Deathlog Code from Skada --]]							local winmax = 1
    --[[Deathlog Code from Skada --]]	
	--[[Deathlog Code from Skada --]]							-- Sort deaths.
	--[[Deathlog Code from Skada --]]							table.sort(player.deaths, cmp_ts)
    --[[Deathlog Code from Skada --]]	
	--[[Deathlog Code from Skada --]]							for i, death in ipairs(player.deaths) do
	--[[Deathlog Code from Skada --]]								local maxhp = death.maxhp or player.maxhp
	--[[Deathlog Code from Skada --]]								winmax = math.max(winmax, maxhp)
	--[[Deathlog Code from Skada --]]								-- Sort log entries.
	--[[Deathlog Code from Skada --]]								table.sort(death.log, cmp_ts)
    --[[Deathlog Code from Skada --]]	
	--[[Deathlog Code from Skada --]]								for j, log in ipairs(death.log) do
	--[[Deathlog Code from Skada --]]									local diff = tonumber(log.ts) - tonumber(death.ts)
	--[[Deathlog Code from Skada --]]									-- Ignore hits older than 60s before death.
	--[[Deathlog Code from Skada --]]									if diff > -60 then
    --[[Deathlog Code from Skada --]]	
	--[[Deathlog Code from Skada --]]										local d = win.dataset[nr] or {}
	--[[Deathlog Code from Skada --]]										win.dataset[nr] = d
    --[[Deathlog Code from Skada --]]	
	--[[Deathlog Code from Skada --]]										d.id = nr
	--[[Deathlog Code from Skada --]]										local spellid = log.spellid or 88163 -- "Attack" spell
	--[[Deathlog Code from Skada --]]										local spellname = log.spellname or GetSpellInfo(spellid)
	--[[Deathlog Code from Skada --]]										local rspellname
	--[[Deathlog Code from Skada --]]										if spellid == death_spell then
	--[[Deathlog Code from Skada --]]											rspellname = spellname -- nicely formatted death message
	--[[Deathlog Code from Skada --]]										else
	--[[Deathlog Code from Skada --]]											rspellname = GetSpellLink(spellid) or spellname	
	--[[Deathlog Code from Skada --]]										end
	--[[Deathlog Code from Skada --]]										local label
	--[[Deathlog Code from Skada --]]										if log.ts >= death.ts then
	--[[Deathlog Code from Skada --]]											label = date("%H:%M:%S", log.ts).. ": "
	--[[Deathlog Code from Skada --]]										else
	--[[Deathlog Code from Skada --]]											label = ("%2.2f"):format(diff) .. ": "
	--[[Deathlog Code from Skada --]]										end
	--[[Deathlog Code from Skada --]]										if log.srcname then 
	--[[Deathlog Code from Skada --]]											label = label..log.srcname..L["'s "]
	--[[Deathlog Code from Skada --]]										end
	--[[Deathlog Code from Skada --]]										d.label =       label..spellname
	--[[Deathlog Code from Skada --]]										d.reportlabel = label..rspellname
	--[[Deathlog Code from Skada --]]										d.ts = log.ts
	--[[Deathlog Code from Skada --]]										d.value = log.hp or 0
	--[[Deathlog Code from Skada --]]										local _, _, icon = GetSpellInfo(spellid)
	--[[Deathlog Code from Skada --]]										d.icon = icon
	--[[Deathlog Code from Skada --]]										d.spellid = spellid
    --[[Deathlog Code from Skada --]]	
	--[[Deathlog Code from Skada --]]										local amt = ""
	--[[Deathlog Code from Skada --]]										local amount = log.amount or 0
	--[[Deathlog Code from Skada --]]										local absorb = log.absorb or 0
	--[[Deathlog Code from Skada --]]										if self.metadata.columns.Change then
	--[[Deathlog Code from Skada --]]											local change = Skada:FormatNumber(math.abs(amount))
	--[[Deathlog Code from Skada --]]											if amount > 0 then
	--[[Deathlog Code from Skada --]]												change = "+"..change
	--[[Deathlog Code from Skada --]]											elseif amount < 0 then
	--[[Deathlog Code from Skada --]]												change = "-"..change
	--[[Deathlog Code from Skada --]]											end
	--[[Deathlog Code from Skada --]]											amt = amt..change
	--[[Deathlog Code from Skada --]]										end
	--[[Deathlog Code from Skada --]]										if absorb ~= 0 and self.metadata.columns.Absorb then
	--[[Deathlog Code from Skada --]]											amt = amt.." ("..Skada:FormatNumber(math.abs(absorb)).." "..ABSORB..")"
	--[[Deathlog Code from Skada --]]										end
    --[[Deathlog Code from Skada --]]	
	--[[Deathlog Code from Skada --]]										if log.ts >= death.ts then
	--[[Deathlog Code from Skada --]]											d.valuetext = ""
	--[[Deathlog Code from Skada --]]										else
	--[[Deathlog Code from Skada --]]											d.valuetext = Skada:FormatValueText(
	--[[Deathlog Code from Skada --]]												amt, #amt > 0,
	--[[Deathlog Code from Skada --]]												Skada:FormatNumber(log.hp or 0), self.metadata.columns.Health,
	--[[Deathlog Code from Skada --]]												string.format("%02.1f%%", (log.hp or 1) / (maxhp or 1) * 100), self.metadata.columns.Percent
	--[[Deathlog Code from Skada --]]											)
	--[[Deathlog Code from Skada --]]										end
    --[[Deathlog Code from Skada --]]	
	--[[Deathlog Code from Skada --]]										if amount == 0 and absorb == 0 then -- non-hp event
	--[[Deathlog Code from Skada --]]											d.color = green
	--[[Deathlog Code from Skada --]]										elseif amount > 0 or absorb > 0 then -- heal event
	--[[Deathlog Code from Skada --]]											d.color = green
	--[[Deathlog Code from Skada --]]										else -- damage event
	--[[Deathlog Code from Skada --]]											d.color = red
	--[[Deathlog Code from Skada --]]										end
    --[[Deathlog Code from Skada --]]	
	--[[Deathlog Code from Skada --]]										nr = nr + 1
	--[[Deathlog Code from Skada --]]									end
	--[[Deathlog Code from Skada --]]								end
	--[[Deathlog Code from Skada --]]							end
    --[[Deathlog Code from Skada --]]	
	--[[Deathlog Code from Skada --]]							win.metadata.maxvalue = winmax
	--[[Deathlog Code from Skada --]]						end
														end
	--[[Deathlog Code from Skada --]]				end



function mod:OnEnable()
	--mod.metadata = {tooltip = Activity_tooltip, columns = {Damage= true, DPS = true}}
	mod.metadata = {tooltip = Activity_tooltip, click1 = activitylog, columns = {Damage= true, DPS = true}}
	activitylog.metadata 	= {click1 = deathlog, ordersort = true, columns = {Damage= true}}
	deathlog.metadata 	= {ordersort = true, columns = {Change = true, Health = false, Percent = true, Absorb = true}}
	Skada:AddMode(self)
	
	if not SessionActivity then 
		SessionActivity = {}
		
		for _, set in ipairs(Skada:GetSets()) do
			for _, player in ipairs (set.players) do

				if ( string.sub(player.id,1,6) == "Player") then
					if not SessionActivity[player.id] then
						SessionActivity[player.id] = {}
					end
					if not SessionActivity[player.id].sets then SessionActivity[player.id].sets = {} end

					SessionActivity[player.id].activity = (SessionActivity[player.id].activity or 0) + Skada:PlayerActiveTime(set, player)
					if (settime(set) - math.min(12,settime(set)/10)) < Skada:PlayerActiveTime(set, player) then
						SessionActivity[player.id].possible = (SessionActivity[player.id].possible or 0) + Skada:PlayerActiveTime(set, player)
						table.insert (SessionActivity[player.id].sets,{activity = Skada:PlayerActiveTime(set, player),possible = Skada:PlayerActiveTime(set, player)})
					else
						SessionActivity[player.id].possible = (SessionActivity[player.id].possible or 0) + settime(set)-math.min(12,settime(set)/10)
						table.insert (SessionActivity[player.id].sets,{activity = Skada:PlayerActiveTime(set, player),possible = settime(set)-math.min(12,settime(set)/10)})
					end
				end
			end
		end
	
		if not PermanentActivity then PermanentActivity = {} end
		for id, _ in pairs(SessionActivity) do
			if not PermanentActivity[id] then PermanentActivity[id] = {} end
			PermanentActivity[id].activity = (PermanentActivity[id].activity or 0) + SessionActivity[id].activity 
			PermanentActivity[id].possible = (PermanentActivity[id].possible or 0) + SessionActivity[id].possible	
		end
	end
end

function mod:OnDisable()
		Skada:RemoveMode(self)
end

function mod:GetSetSummary(set)
if not SessionActivity then return end
		return Skada:FormatValueText(math.floor(SessionActivity[UnitGUID("player")].activity/SessionActivity[UnitGUID("player")].possible*1000)/10 .."%", self.metadata.columns.Damage)
end

function mod:SetComplete(set)

	for i, player in ipairs(set.players) do

		if  ( string.sub(player.id,1,6) == "Player") then
			if not SessionActivity[player.id] then SessionActivity[player.id] = {} end
			if not PermanentActivity[player.id] then PermanentActivity[player.id] = {} end
			if not SessionActivity[player.id].sets then SessionActivity[player.id].sets = {} end

			SessionActivity[player.id].activity = (SessionActivity[player.id].activity or 0) + Skada:PlayerActiveTime(set, player)
			PermanentActivity[player.id].activity = (PermanentActivity[player.id].activity or 0) + Skada:PlayerActiveTime(set, player)
			
			if (settime(set) - math.min(12,settime(set)/10)) < Skada:PlayerActiveTime(set, player) then
				SessionActivity[player.id].possible = (SessionActivity[player.id].possible or 0) + Skada:PlayerActiveTime(set, player)
				PermanentActivity[player.id].possible = (PermanentActivity[player.id].possible or 0) + Skada:PlayerActiveTime(set, player)
				table.insert (SessionActivity[player.id].sets,1,{activity = Skada:PlayerActiveTime(set, player),possible = Skada:PlayerActiveTime(set, player)})

			else
				SessionActivity[player.id].possible = (SessionActivity[player.id].possible or 0) + settime(set)-math.min(12,settime(set)/10)
				PermanentActivity[player.id].possible = (PermanentActivity[player.id].possible or 0) + settime(set)-math.min(12,settime(set)/10)
				table.insert (SessionActivity[player.id].sets,1,{activity = Skada:PlayerActiveTime(set, player),possible = settime(set)-math.min(12,settime(set)/10)})
			end
		end
	end		
end

--function mod:Destroy(win)
--SessionActivity = {}
--end

function mod:AddSetAttributes(set)
if set.name == L["Total"] and next(set.players)==nil then
SessionActivity = {}
end

--	print(set)
--for a,b,c in pairs(set) do
--	print(a)
--	if a == "players" then
--		if next(set.players)==nil then
--			print ("next nil")
--		else
--			for a,b,c in pairs(b) do
--				print(a)
--				print(b)
--				print(c)
--			end
--		end
--	else
--		print(b)
--	end
--	print(" ")
--end
end