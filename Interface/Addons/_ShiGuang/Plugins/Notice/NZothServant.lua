--## Author: JANY ## Version: 8.3.0 
--("SAY", "WHISPER", "EMOTE", "CHANNEL", "PARTY", "INSTANCE_CHAT", "GUILD", "OFFICER", "YELL", "RAID", "RAID_WARNING", "AFK", "DND")
local j, i, sum, sum_, flag, flag_, FirstTime, FirstTime_, zmhx, fhzy, tlcx, bkyydzx, lldky, xkbttime = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
local player1 = GetUnitName("player",true)

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

function lrnFrame:DisgustingTentacles(srcName,dstName,a13)
	if srcName == player1 and dstName == "扭曲的附肢" then
		--SendChatMessage("触须!", "EMOTE")
		UIErrorsFrame:AddMessage("!触须!",1,0,0,5)
	end	
end

function lrnFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, aAmount)
	if srcName == player1 and spellId == 317159 then --317159
		sum = sum + aAmount
		i = i + 1
		if flag == 0 then 
			FirstTime = timestamp
			flag =1
		end
  elseif srcName == player1 and spellId == 317265 then
		--SendChatMessage("流星 "..string.format("%.1f", aAmount*0.001).."k", "EMOTE")
		RaidNotice_AddMessage(RaidWarningFrame, "|cffff0000无尽之星 |r"..string.format("%.1f", aAmount*0.0001).."万", ChatTypeInfo["RAID_WARNING"])
  --elseif srcName == player1 and spellId == 295261 then
		--RaidNotice_AddMessage(RaidWarningFrame, "|cffff0000聚焦之虹 |r"..string.format("%.1f", aAmount*0.0001).."万", ChatTypeInfo["RAID_WARNING"])
  --elseif srcName == player1 and spellId == 317291 then
		--if xkbttime == 0 then xkbttime = timestamp end
		--SendChatMessage("虚空鞭笞 "..string.format("%.1f万",aAmount*0.0001), "EMOTE")
		--RaidNotice_AddMessage(RaidWarningFrame, "|cffff0000虚空鞭笞 |r"..string.format("%.1f", aAmount*0.0001).."万", ChatTypeInfo["RAID_WARNING"])
		--xkbttime = timestamp
	elseif srcName == player1 and spellId == 316661 then
		if xkbttime == 0 then xkbttime = timestamp end
		--SendChatMessage("黑曜毁灭 "..string.format("%.1f万",aAmount*0.0001), "EMOTE")
		RaidNotice_AddMessage(RaidWarningFrame, "|cffff0000黑曜毁灭 |r"..string.format("%.1f", aAmount*0.0001).."万", ChatTypeInfo["RAID_WARNING"])
		xkbttime = timestamp
	elseif srcName == player1 and spellId == 317291 then --317159
		sum_ = sum_ + aAmount
		j = j + 1
		if flag_ == 0 then 
			FirstTime_ = timestamp
			flag_ =1
		end	    
  end

	if timestamp - FirstTime > 2 and flag == 1 then
		flag = 0
		RaidNotice_AddMessage(RaidWarningFrame, "|cffff0000暮光炮 |r - "..string.format("%.d",i ).."个 - "..string.format("%.1f", sum*0.0001).."万", ChatTypeInfo["RAID_WARNING"])
		--SendChatMessage("暮光炮击中了"..string.format("%.d",i ).."个敌人，打出了" ..string.format("%.1f", sum*0.0001).."万的伤害，太香啦", "EMOTE")
		sum = 0
		i = 0
	elseif timestamp - FirstTime_ > 1 and flag_ == 1 then
		flag_ = 0
		--SendChatMessage("龍の鞭笞"..string.format("%.d",j ).."杀，打出了" ..string.format("%.1f", sum_*0.0001).."万吨的伤害！！！", "EMOTE")--("SAY", "WHISPER", "EMOTE", "CHANNEL", "PARTY", "INSTANCE_CHAT", "GUILD", "OFFICER", "YELL", "RAID", "RAID_WARNING", "AFK", "DND")
		RaidNotice_AddMessage(RaidWarningFrame, "|cffff0000触须|r - "..string.format("%.d",j ).."个 - "..string.format("%.1f", sum_*0.0001).."万", ChatTypeInfo["RAID_WARNING"])
		sum = 0
		j = 0
	end
end

function lrnFrame:lrdebuff()
	for i=1,40 do
	  local name, icon, _, _, _, etime = UnitDebuff("player",i)
	  if name == "壮美幻象" and icon == 575534 and zmhx < etime - 8 then
	  	zmhx = etime
	    --print(("%d=%s, %s, %.2f."):format(i,name,icon,(etime-GetTime())))
	    --SendChatMessage("壮美幻象!", "EMOTE")
	    UIErrorsFrame:AddMessage("!壮美幻象!",1,0,0,5)
	    --PlaySoundFile("Interface/AddOns/NZothServant/BassDrop.ogg")
	  end
	  if name == "腐化之眼" and fhzy < etime - 8 and false then
	  	fhzy = etime	
	    UIErrorsFrame:AddMessage("!腐化之眼!",1,0,0,5)
	  end
	  if name == "贪婪触须" and tlcx < etime - 5 and false then
	  	tlcx = etime
	    UIErrorsFrame:AddMessage("!贪婪触须!",1,0,0,5)
	  end
		---------------------------------------------------------------------
	  local name, icon, _, _, _, etime = UnitBuff("player",i)
	  if name == "不可言喻的真相" and bkyydzx < etime - 10 then
	  	bkyydzx = etime
	  	UIErrorsFrame:AddMessage("!不可言喻的真相!",1,0,0,5)
	    --print(("%d=%s, %s, %.2f minutes left."):format(i,name,icon,(etime-GetTime())/60))
	  end
	  if name == "力量的考验" and lldky < etime - 10 then
	  	lldky = etime
	  	UIErrorsFrame:AddMessage("!力量的考验!",1,0,0,5)
	  end
	end
end

function lrnFrame:COMBAT_LOG_EVENT_UNFILTERED(event,...)
	local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20 = CombatLogGetCurrentEventInfo(); -- Those arguments appear for all combat event variants.
	local eventPrefix, eventSuffix = eventType:match("^(.-)_?([^_]*)$");
	if eventType == 'SPELL_SUMMON' then 
		lrnFrame:DisgustingTentacles(srcName,dstName,a13)
	end
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