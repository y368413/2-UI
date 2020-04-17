--## Author: JANY ## Version: 8.3.0
local FirstTime = 0
local chuxu = 0
local zmhx = 0
local fhzy = 0
local tlcx = 0
local bkyydzx = 0 
local sum = 0
local flag = 0
local i = 0

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
}

local lrnFrame = CreateFrame("Frame", "lrnFrame")
lrnFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
lrnFrame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

function lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, aAmount)
	if srcName == GetUnitName("player",true) and spellId == 317159 then --317159
		--if FirstTime < timestamp - 2 then
			--FirstTime = timestamp
			--SendChatMessage("开炮 "..string.format("%.1f", aAmount*0.001).."k", "EMOTE")--("SAY", "WHISPER", "EMOTE", "CHANNEL", "PARTY", "INSTANCE_CHAT", "GUILD", "OFFICER", "YELL", "RAID", "RAID_WARNING", "AFK", "DND")
			--RaidNotice_AddMessage(RaidWarningFrame, "|cffff0000开炮 |r"..string.format("%.1f", aAmount*0.0001).."万", ChatTypeInfo["RAID_WARNING"])
			--PlaySoundFile("Interface/AddOns/NZothServant/kaipao.ogg")
		--end
		sum = sum + aAmount
		i = i + 1
		if flag == 0 then 
			FirstTime = timestamp
			flag =1
		end

	if timestamp - FirstTime > 2 and flag == 1 then
		flag = 0
		--SendChatMessage("暮光炮击中了"..string.format("%.d",i ).."个敌人，打出了" ..string.format("%.1f", sum*0.0001).."万的伤害，太香啦", "EMOTE")
		RaidNotice_AddMessage(RaidWarningFrame, "|cffff0000开炮|r - "..string.format("%.d",i ).."个 - "..string.format("%.1f", aAmount*0.0001).."万", ChatTypeInfo["RAID_WARNING"])
		sum = 0
		i = 0
	end
	elseif srcName == GetUnitName("player",true) and spellId == 316835 then
		if chuxu < timestamp - 10 then
			chuxu = timestamp
			--SendChatMessage("触须 "..string.format("%.1f", aAmount*0.001).."k", "EMOTE")--("SAY", "WHISPER", "EMOTE", "CHANNEL", "PARTY", "INSTANCE_CHAT", "GUILD", "OFFICER", "YELL", "RAID", "RAID_WARNING", "AFK", "DND")
			RaidNotice_AddMessage(RaidWarningFrame, "|cffff0000触须 |r"..string.format("%.1f", aAmount*0.0001).."万", ChatTypeInfo["RAID_WARNING"])
			--PlaySoundFile("Interface/AddOns/NZothServant/kaipao.ogg")
		end		
	elseif srcName == GetUnitName("player",true) and spellId == 317265 then
		--SendChatMessage("流星 "..string.format("%.1f", aAmount*0.001).."k", "EMOTE")--("SAY", "WHISPER", "EMOTE", "CHANNEL", "PARTY", "INSTANCE_CHAT", "GUILD", "OFFICER", "YELL", "RAID", "RAID_WARNING", "AFK", "DND")
		RaidNotice_AddMessage(RaidWarningFrame, "|cffff0000流星 |r"..string.format("%.1f", aAmount*0.0001).."万", ChatTypeInfo["RAID_WARNING"])
		--PlaySoundFile("Interface/AddOns/NZothServant/kaipao.ogg")
	end
end

function lrnFrame:lrdebuff()
	for i=1,40 do
	  local name, icon, _, _, _, etime = UnitDebuff("player",i)
	  if name == "壮美幻象" and icon == 575534 and zmhx < etime - 8 then
	  	zmhx = etime
	    --print(("%d=%s, %s, %.2f."):format(i,name,icon,(etime-GetTime())))
	    --SendChatMessage("壮美幻象!", "EMOTE")
	    UIErrorsFrame:AddMessage("壮美幻象!",1,0,0,5)
	    --PlaySoundFile("Interface/AddOns/NZothServant/BassDrop.ogg")
	  end
	  if name == "腐化之眼" and fhzy < etime - 8 and false then
	  	fhzy = etime	
	    --SendChatMessage("腐化之眼!", "EMOTE")
	    UIErrorsFrame:AddMessage("腐化之眼!",1,0,0,5)
	    --PlaySoundFile("Interface/AddOns/NZothServant/BassDrop.ogg")
	  end
	  if name == "贪婪触须" and tlcx < etime - 5 and false then
	  	tlcx = etime
	    --SendChatMessage("贪婪触须!", "EMOTE")
	    UIErrorsFrame:AddMessage("贪婪触须!",1,0,0,5)
	    --PlaySoundFile("Interface/AddOns/NZothServant/BassDrop.ogg")
	  end
	end
	for i=1,40 do
	  local name, icon, _, _, _, etime = UnitBuff("player",i)
	  if name == "不可言喻的真相" and bkyydzx < etime - 10 then
	  	bkyydzx = etime
	  	--SendChatMessage("不可言喻的真相!", "EMOTE")
	  	UIErrorsFrame:AddMessage("不可言喻的真相!",1,0,0,5)
	    --print(("%d=%s, %s, %.2f minutes left."):format(i,name,icon,(etime-GetTime())/60))
	  end
	end
end

function lrnFrame:COMBAT_LOG_EVENT_UNFILTERED(event,...)
	local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20 = CombatLogGetCurrentEventInfo(); -- Those arguments appear for all combat event variants.
	local eventPrefix, eventSuffix = eventType:match("^(.-)_?([^_]*)$");
	--print(dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20)
	if (eventPrefix:match("^SPELL") or eventPrefix:match("^RANGE")) and eventSuffix == "DAMAGE" then
		local spellId, spellName, spellSchool, sAmount, aOverkill, sSchool, sResisted, sBlocked, sAbsorbed, sCritical, sGlancing, sCrushing, sOffhand, _ = select(12,CombatLogGetCurrentEventInfo())
		lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, sAmount)
	elseif eventPrefix:match("^SPELL") and eventSuffix == "MISSED" then
		local spellId, spellName, spellSchool, missType, isOffHand, mAmount  = select(12,CombatLogGetCurrentEventInfo())
		if mAmount then
			lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, mAmount)
		end
	end
	if eventSwitch[eventType] then
		lrnFrame:lrdebuff()
	end
end