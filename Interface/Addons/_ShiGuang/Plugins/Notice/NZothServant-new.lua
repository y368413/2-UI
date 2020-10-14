local player1 = GetUnitName("player",true)
local ChannelV = {"SAY", "WHISPER", "EMOTE", "CHANNEL", "PARTY", "INSTANCE_CHAT", "GUILD", "OFFICER", "YELL", "RAID", "RAID_WARNING", "AFK", "DND","PRINT"}
local eventSwitch = {
	["SPELL_AURA_APPLIED"] = true,
	["SPELL_AURA_REMOVED"] = true,
	["SPELL_AURA_REFRESH"] = true,
	["SPELL_AURA_APPLIED_DOSE"] = true,
	["SPELL_AURA_APPLIED_REMOVED_DOSE"] = true,
	["SPELL_AURA_REMOVED_DOSE"] = true,
	["SPELL_AURA_BROKEN"] = true,
	["SPELL_AURA_BROKEN_SPELL"] = true,
	["ENCHANT_REMOVED"] = true,
	["ENCHANT_APPLIED"] = true,
	["SPELL_CAST_SUCCESS"] = true,
	["SPELL_PERIODIC_ENERGIZE"] = true,
	["SPELL_ENERGIZE"] = true,
	["SPELL_PERIODIC_HEAL"] = true,
	["SPELL_HEAL"] = true,
	["SPELL_DAMAGE"] = true,
	["SPELL_PERIODIC_DAMAGE"] = true,
	--added new
	["SPELL_DRAIN"] = true,
	["SPELL_LEECH"] = true,
	["SPELL_PERIODIC_DRAIN"] = true,
	["SPELL_PERIODIC_LEECH"] = true,
	["DAMAGE_SHIELD"] = true,
	["DAMAGE_SPLIT"] = true,
		["SPELL_UPDATE_COOLDOWN"]		= true,
		["SPELL_UPDATE_CHARGES"]		= true,
		["SPELL_UPDATE_USABLE"]			= true,
		["UPDATE_SHAPESHIFT_FORM"]		= true,
		["UNIT_SPELLCAST_START"]		= true,
		["UNIT_SPELLCAST_CHANNEL_START"]= true,
		["UNIT_AURA"]					= true,	
		--["UNIT_COMBO_POINTS"]			= true,
		["UNIT_DISPLAYPOWER"]			= true,
		["UNIT_HEALTH"]					= true,
		["UNIT_POWER_UPDATE"]			= true,
		["UNIT_POWER_FREQUENT"]			= true,
		["RUNE_TYPE_UPDATE"]			= true,
		["RUNE_POWER_UPDATE"]			= true,
		--["UNIT_SPELLCAST_SUCCEEDED"]	= true,		
		["PLAYER_TOTEM_UPDATE"]			= true,
}

local lrnFrame = CreateFrame("Frame", "lrnFrame")
lrnFrame:RegisterEvent("ADDON_LOADED")
lrnFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
lrnFrame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

function lrnFrame:ADDON_LOADED(event,...)
    if NZothServantDB_spelloggdata == nil then NZothServantDB_spelloggdata = {
    [317159] = {"|cffff0000暮光炮 |r - ","PRINT","kaipao.ogg",0,2},
		[317265] = {"|cffff0000无尽之星|r - ","PRINT","kaipao.ogg",0,2},
		[317291] = {"|cffff0000虚空鞭笞|r","PRINT","kaipao.ogg",0,2},
		[316661] = {"|cffff0000黑曜毁灭|r","PRINT","kaipao.ogg",0,2},
		[316818] = {"!贪婪触须!","PRINT","kaipao.ogg",0,2},
		[319695] = {"!壮美幻象!","PRINT","BassDrop.ogg",0,8},
		--[315161] = {"!腐化之眼!",false,"BassDrop.ogg",0,8},
		[316801] = {"!不可言喻的真相!","PRINT","BZ.ogg",0,2},
		[275540] = {"!力量的考验!","PRINT","YS.ogg",0,2},
    	}
	end
end

function lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, aAmount)
	if srcName == player1 and NZothServantDB_spelloggdata[spellId] then 
		if timestamp > NZothServantDB_spelloggdata[spellId][4] + NZothServantDB_spelloggdata[spellId][5] then
			NZothServantDB_spelloggdata[spellId][4] = timestamp
			local bAmount = ""
			if aAmount then
				if aAmount > 9999 then
					bAmount = string.format("%.1f万",aAmount*0.0001)
				else
					bAmount = aAmount
				end
			end --string.format("%.1f万",aAmount*0.0001)
			UIErrorsFrame:AddMessage(NZothServantDB_spelloggdata[spellId][1]..bAmount,1,0,0,5)
		end
	end
end

function lrnFrame:lrdebuff()
	for i=1,40 do
		------UnitAura---UnitBuff-----------UnitDebuff-------------------------------HELPFUL|HARMFUL------------------
	  local name1, icon1, count1, _, _, etime1 ,_,_,_, spellId1,_,_,_,_,_,value1 = UnitBuff("player",i)
	  local name2, icon2, count2, _, _, etime2 ,_,_,_, spellId2,_,_,_,_,_,value2 = UnitDebuff("player",i)

	  if name1 or name2 then 
		  if NZothServantDB_spelloggdata[spellId1] then
		  	lrnFrame:SpellDamage(etime1,_,_,player1,_,_,_,_,spellId1,_,_,value1)
		  end
		  if NZothServantDB_spelloggdata[spellId2] then
		  	lrnFrame:SpellDamage(etime2,_,_,player1,_,_,_,_,spellId2,_,_,value2)
		  end
	  else
	  	break
	  end
	end
end


function lrnFrame:COMBAT_LOG_EVENT_UNFILTERED(event,...)
	local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2,spellId, spellName, spellSchool, sAmount, aOverkill, sSchool, sResisted, sBlocked, sAbsorbed, sCritical, sGlancing, sCrushing, sOffhand, _ = CombatLogGetCurrentEventInfo();
	local eventPrefix, eventSuffix = eventType:match("^(.-)_?([^_]*)$");
	if (eventPrefix:match("^SPELL") or eventPrefix:match("^RANGE")) and eventSuffix == "DAMAGE" then
		lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, sAmount)
	elseif eventPrefix:match("^SPELL") and eventSuffix == "MISSED" then
		if sSchool then
			lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, sSchool)
		end
	elseif eventType == 'SPELL_SUMMON' then
		lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, sAmount)
	end
	if eventSwitch[eventType] then
		lrnFrame:lrdebuff()
	end
end