C_announcements = {
	HideCombat = true,				-- 开关 进战, 脱战
	Feasts = true,					-- 开关 大餐, 宴席, 法师召唤餐桌
	Portals = true,					-- 开关 法师传送门, 烈酒遥控器
	Toys = true,						-- 开关 玩具火车, 火鸡的羽毛, 自动跳舞信号发射器(跳舞手雷)
	ItemsPrompt = true,			-- 进副本提醒是否需要更换装备.
}
	T_AnnounceToys = {
		[61031] = true,		-- Toy Train Set
		[49844] = true,		-- Direbrew's Remote
	}
	T_AnnounceBots = {
		[22700] = true,		-- Field Repair Bot 74A
		[44389] = true,		-- Field Repair Bot 110G
		[54711] = true,		-- Scrapbot
		[67826] = true,		-- Jeeves
		[126459] = true,	-- Blingtron 4000
		[161414] = true,	-- Blingtron 5000
		[199109] = true,	-- Auto-Hammer
		[226241] = true,	-- Codex of the Tranquil Mind
	}
	T_AnnouncePortals = {
		-- Alliance
		[10059] = true,		-- Stormwind
		[11416] = true,		-- Ironforge
		[11419] = true,		-- Darnassus
		[32266] = true,		-- Exodar
		[49360] = true,		-- Theramore
		[33691] = true,		-- Shattrath
		[88345] = true,		-- Tol Barad
		[132620] = true,	-- Vale of Eternal Blossoms
		[176246] = true,	-- Stormshield
		[281400] = true,	-- Boralus
		-- Horde
		[11417] = true,		-- Orgrimmar
		[11420] = true,		-- Thunder Bluff
		[11418] = true,		-- Undercity
		[32267] = true,		-- Silvermoon
		[49361] = true,		-- Stonard
		[35717] = true,		-- Shattrath
		[88346] = true,		-- Tol Barad
		[132626] = true,	-- Vale of Eternal Blossoms
		[176244] = true,	-- Warspear
		[281402] = true,	-- Dazar'alor
		-- Alliance/Horde
		[53142] = true,		-- Dalaran
		[120146] = true,	-- Ancient Dalaran
		[224871] = true,	-- Dalaran, Broken Isles
	}
------------------------------------------------------------------------------------------	Announce Feasts/Souls/Repair Bots/Portals/Ritual of Summoning
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function()
	local _, subEvent, _, _, srcName, _, _, _, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
	if not IsInGroup() or InCombatLockdown() or not subEvent or not spellID or not srcName then return end
	if not UnitInRaid(srcName) and not UnitInParty(srcName) then return end
	local srcName = srcName:gsub("%-[^|]+", "")
	if subEvent == "SPELL_CAST_SUCCESS" then
		-- Feasts
		if C_announcements.feasts and (spellID == 126492 or spellID == 126494) then
			--SendChatMessage(string.format("%s → %s - [%s]。", srcName, GetSpellLink(spellID), SPELL_STAT1_NAME), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s - [%s]。", srcName, GetSpellLink(spellID), SPELL_STAT1_NAME), ChatTypeInfo["RAID_WARNING"])
		elseif C_announcements.feasts and (spellID == 126495 or spellID == 126496) then
			--SendChatMessage(string.format("%s → %s - [%s]。", srcName, GetSpellLink(spellID), SPELL_STAT2_NAME), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s - [%s]。", srcName, GetSpellLink(spellID), SPELL_STAT2_NAME), ChatTypeInfo["RAID_WARNING"])
		elseif C_announcements.feasts and (spellID == 126501 or spellID == 126502) then
			--SendChatMessage(string.format("%s → %s - [%s]。", srcName, GetSpellLink(spellID), SPELL_STAT3_NAME), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s - [%s]。", srcName, GetSpellLink(spellID), SPELL_STAT3_NAME), ChatTypeInfo["RAID_WARNING"])
		elseif C_announcements.feasts and (spellID == 126497 or spellID == 126498) then
			--SendChatMessage(string.format("%s → %s - [%s]。", srcName, GetSpellLink(spellID), SPELL_STAT4_NAME), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s - [%s]。", srcName, GetSpellLink(spellID), SPELL_STAT4_NAME), ChatTypeInfo["RAID_WARNING"])
		elseif C_announcements.feasts and (spellID == 126499 or spellID == 126500) then
			--SendChatMessage(string.format("%s → %s - [%s]。", srcName, GetSpellLink(spellID), SPELL_STAT5_NAME), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s - [%s]。", srcName, GetSpellLink(spellID), SPELL_STAT5_NAME), ChatTypeInfo["RAID_WARNING"])
		elseif C_announcements.feasts and (spellID == 104958 or spellID == 105193 or spellID == 126503 or spellID == 126504 or spellID == 145166 or spellID == 145169 or spellID == 145196) then
			--SendChatMessage(string.format("%s → %s", srcName, GetSpellLink(spellID)), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s", srcName, GetSpellLink(spellID)), ChatTypeInfo["RAID_WARNING"])
		-- Spirit Cauldron		-- Lavish Suramar Feast		-- Refreshment Table
		elseif C_announcements.feasts and (spellID == 188036 or spellID == 201352 or spellID == 43987) then
			--SendChatMessage(string.format("%s → %s", srcName, GetSpellLink(spellID)), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s", srcName, GetSpellLink(spellID)), ChatTypeInfo["RAID_WARNING"])
		-- Ritual of Summoning
		elseif C_announcements.portals and spellID == 698 then
			--SendChatMessage(string.format("%s → %s", srcName, GetSpellLink(spellID)), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s", srcName, GetSpellLink(spellID)), ChatTypeInfo["RAID_WARNING"])
		-- Piccolo of the Flaming Fire
		elseif C_announcements.toys and spellID == 18400 then
			--SendChatMessage(string.format("%s → %s", srcName, GetSpellLink(spellID)), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s", srcName, GetSpellLink(spellID)), ChatTypeInfo["RAID_WARNING"])
		end
	elseif subEvent == "SPELL_SUMMON" then
		-- Repair Bots
		if C_announcements.feasts and T_AnnounceBots[spellID] then
			--SendChatMessage(string.format("%s → %s", srcName, GetSpellLink(spellID)), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s", srcName, GetSpellLink(spellID)), ChatTypeInfo["RAID_WARNING"])
		end
	elseif subEvent == "SPELL_CREATE" then
		-- Ritual of Souls and MOLL-E
		if C_announcements.feasts and (spellID == 29893 or spellID == 54710) then
			--SendChatMessage(string.format("%s → %s", srcName, GetSpellLink(spellID)), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s", srcName, GetSpellLink(spellID)), ChatTypeInfo["RAID_WARNING"])
		-- Toys
		elseif C_announcements.toys and T_AnnounceToys[spellID] then
			--SendChatMessage(string.format("%s → %s", srcName, GetSpellLink(spellID)), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s", srcName, GetSpellLink(spellID)), ChatTypeInfo["RAID_WARNING"])
		-- Portals
		elseif C_announcements.portals and T_AnnouncePortals[spellID] then
			--SendChatMessage(string.format("%s → %s", srcName, GetSpellLink(spellID)), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s", srcName, GetSpellLink(spellID)), ChatTypeInfo["RAID_WARNING"])
		end
	elseif subEvent == "SPELL_AURA_APPLIED" then
		-- Turkey Feathers and Party G.R.E.N.A.D.E.
		if C_announcements.toys and (spellID == 61781 or ((spellID == 51508 or spellID == 51510) and destName == UnitName("player"))) then
			--SendChatMessage(string.format("%s → %s", srcName, GetSpellLink(spellID)), T.CheckChat(true))
			RaidNotice_AddMessage(RaidWarningFrame, string.format("%s → %s", srcName, GetSpellLink(spellID)), ChatTypeInfo["RAID_WARNING"])
		end
	end
end)

-- 提醒换装
if C_announcements.ItemsPrompt == true then
	local framenoss = CreateFrame("Frame")
	framenoss:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	framenoss:SetScript("OnEvent", function(self, event)
		if event ~= "ZONE_CHANGED_NEW_AREA" or not IsInInstance() then return end
		local spec = GetSpecialization()
		if not spec then return NONE, NONE end
		local _, TalentName = GetSpecializationInfo(spec)
		RaidNotice_AddMessage(RaidWarningFrame, "你现在的天赋是 |cffEE3A8C(".. TalentName.. ")|r, 请检查|cff00FF00装备|r是否符合", ChatTypeInfo["RAID_WARNING"])
		--ElvUIAlertRun("你现在的天赋是 |cffEE3A8C(".. TalentName.. ")|r, 请检查|cff00FF00装备|r是否符合", 0, 1, 1)
		DEFAULT_CHAT_FRAME:AddMessage(string.format("你现在的天赋是 |cffEE3A8C(".. TalentName.. ")|r, 请检查|cff00FF00装备|r是否符合."), 0, 1, 1)
	end)
end