local player1 = GetUnitName("player",true)
local ChannelV = {"SAY", "WHISPER", "EMOTE", "CHANNEL", "PARTY", "INSTANCE_CHAT", "GUILD", "OFFICER", "YELL", "RAID", "RAID_WARNING", "AFK", "DND", "MYSELF"}

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
-- 初始化
local JXFrame = CreateFrame("Frame", "JXFrame")
JXFrame:RegisterEvent("ADDON_LOADED")
JXFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

JXFrame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

-- 把字符串格式修正
function fixString(str)
	if str == nil or str == "" then return "" end
	-- 替换中文逗号变成英文逗号
	str = string.gsub(str, "，", ",")
	-- 移除全部空格
	str = string.gsub(str, " ", "")
	-- 给字符串首尾加入逗号方便匹配
	str = "," .. str .. ","
	return str
end

function JXFrame:ADDON_LOADED(event,...)
    if JXSkillDamgeDB == nil then JXSkillDamgeDB = {} end
    if JXSkillDamgeDB.ChannelN == nil then JXSkillDamgeDB.ChannelN = 3 end
    if JXSkillDamgeDB.TSkillID == nil then JXSkillDamgeDB.TSkillID = "317159" end
	if JXSkillDamgeDB.TSkillName == nil then JXSkillDamgeDB.TSkillName = "→" end
	if JXSkillDamgeDB.TSkillHitCount == nil then JXSkillDamgeDB.TSkillHitCount = "个 " end
	if JXSkillDamgeDB.TDamageDes == nil then JXSkillDamgeDB.TDamageDes = "打出了" end
	if JXSkillDamgeDB.TDamageCount == nil then JXSkillDamgeDB.TDamageCount = "万！ʕ •ɷ•ʔฅ✧" end
	if JXSkillDamgeDB.SkillTime == nil then JXSkillDamgeDB.SkillTime = 0 end
	-- 存放监控的法术列表
	JXSkillDamgeDB.SkillList = {295261,317159,317265,316661,317291}
	print(ChannelV[#ChannelV])
end

function JXFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, aAmount)
	-- 判断是自己造成的而且技能ID是自定义的
	if srcName == player1 then -- spellId == JXSkillDamgeDB.TSkillID then
		-- 存储
		if _G[string.format("%dSpellTable",spellId)] == nil then _G[string.format("%dSpellTable",spellId)] = {} end
		if _G[string.format("%dSpellTable",spellId)].sum  == nil then _G[string.format("%dSpellTable",spellId)].sum = 0 end
		if _G[string.format("%dSpellTable",spellId)].i == nil then _G[string.format("%dSpellTable",spellId)].i = 0 end
		if _G[string.format("%dSpellTable",spellId)].flag  == nil then _G[string.format("%dSpellTable",spellId)].flag = false end
		_G[string.format("%dSpellTable",spellId)].spellName = spellName
		_G[string.format("%dSpellTable",spellId)].sum = _G[string.format("%dSpellTable",spellId)].sum + aAmount
		_G[string.format("%dSpellTable",spellId)].i = _G[string.format("%dSpellTable",spellId)].i + 1
		if _G[string.format("%dSpellTable",spellId)].flag == false then 
			_G[string.format("%dSpellTable",spellId)].FirstTime = timestamp
			_G[string.format("%dSpellTable",spellId)].flag = true
			table.insert(JXSkillDamgeDB.SkillList, _G[string.format("%dSpellTable",spellId)])
		end
	end
	-- 如果没有触发就直接退出
	if #(JXSkillDamgeDB.SkillList) == 0 then return end
	-- 触发了对应的就遍历判断 反向循环方便删除不会漏
	for i = #JXSkillDamgeDB.SkillList, 1, -1 do
    	local spellTable = JXSkillDamgeDB.SkillList[i]
		-- 判断指定时长
		if timestamp - spellTable.FirstTime >= 0 and spellTable.flag == true then
				if JXSkillDamgeDB.TSkillHitCount == "" then 
					SendChatMessage(spellTable.spellName..JXSkillDamgeDB.TSkillName..JXSkillDamgeDB.TDamageDes..string.format("%.1f", spellTable.sum*0.0001)..JXSkillDamgeDB.TDamageCount, ChannelV[JXSkillDamgeDB.ChannelN])
				else 
					SendChatMessage(spellTable.spellName..JXSkillDamgeDB.TSkillName..string.format("%.d", spellTable.i )..JXSkillDamgeDB.TSkillHitCount..JXSkillDamgeDB.TDamageDes..string.format("%.1f", spellTable.sum*0.0001)..JXSkillDamgeDB.TDamageCount, ChannelV[JXSkillDamgeDB.ChannelN])
				end
			spellTable.flag = false
			spellTable.sum = 0
			spellTable.i = 0
			spellTable.spellName = ""
			table.remove(JXSkillDamgeDB.SkillList, i)
		end
	end
end

-- 战斗日志提取
function JXFrame:COMBAT_LOG_EVENT_UNFILTERED(event,...)
	local timestamp, eventType, hideCaster, srcGUID, srcName, srcFlags, srcFlags2, dstGUID, dstName, dstFlags, dstFlags2,a12,a13,a14,a15,a16,a17,a18,a19,a20 = CombatLogGetCurrentEventInfo(); -- Those arguments appear for all combat event variants.
	local eventPrefix, eventSuffix = eventType:match("^(.-)_?([^_]*)$");
	-- print(dstName, dstGUID, dstFlags, dstFlags2, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	if (eventPrefix:match("^SPELL") or eventPrefix:match("^RANGE")) and eventSuffix == "DAMAGE" then
		local spellId, spellName, spellSchool, sAmount, aOverkill, sSchool, sResisted, sBlocked, sAbsorbed, sCritical, sGlancing, sCrushing, sOffhand, _ = select(12,CombatLogGetCurrentEventInfo())
		JXFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, sAmount)
	elseif eventPrefix:match("^SPELL") and eventSuffix == "MISSED" then
		local spellId, spellName, spellSchool, missType, isOffHand, mAmount  = select(12,CombatLogGetCurrentEventInfo())
		if mAmount then
			JXFrame:SpellDamage(timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, mAmount)
		end
	end
end