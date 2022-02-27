﻿---------------------------- QuickQuest, by P3lim  -- NDui MOD  -- y368413 DIY --------------------------
local _, ns = ...
local M, R, U, I = unpack(ns)

local next, ipairs, select = next, ipairs, select
local IsAltKeyDown = IsAltKeyDown
local UnitGUID, IsShiftKeyDown, GetItemInfoFromHyperlink = UnitGUID, IsShiftKeyDown, GetItemInfoFromHyperlink
local GetNumTrackingTypes, GetTrackingInfo, GetInstanceInfo, GetQuestID = GetNumTrackingTypes, GetTrackingInfo, GetInstanceInfo, GetQuestID
local GetNumActiveQuests, GetActiveTitle, GetActiveQuestID, SelectActiveQuest = GetNumActiveQuests, GetActiveTitle, GetActiveQuestID, SelectActiveQuest
local IsQuestCompletable, GetNumQuestItems, GetQuestItemLink, QuestIsFromAreaTrigger = IsQuestCompletable, GetNumQuestItems, GetQuestItemLink, QuestIsFromAreaTrigger
local QuestGetAutoAccept, AcceptQuest, CloseQuest, CompleteQuest, AcknowledgeAutoAcceptQuest = QuestGetAutoAccept, AcceptQuest, CloseQuest, CompleteQuest, AcknowledgeAutoAcceptQuest
local GetNumQuestChoices, GetQuestReward, GetItemInfo, GetQuestItemInfo = GetNumQuestChoices, GetQuestReward, GetItemInfo, GetQuestItemInfo
local GetNumAvailableQuests, GetAvailableQuestInfo, SelectAvailableQuest = GetNumAvailableQuests, GetAvailableQuestInfo, SelectAvailableQuest
local GetNumAutoQuestPopUps, GetAutoQuestPopUp, ShowQuestOffer, ShowQuestComplete = GetNumAutoQuestPopUps, GetAutoQuestPopUp, ShowQuestOffer, ShowQuestComplete
local C_QuestLog_IsWorldQuest = C_QuestLog.IsWorldQuest
local C_QuestLog_IsQuestTrivial = C_QuestLog.IsQuestTrivial
local C_QuestLog_GetQuestTagInfo = C_QuestLog.GetQuestTagInfo
local C_GossipInfo_GetOptions = C_GossipInfo.GetOptions
local C_GossipInfo_SelectOption = C_GossipInfo.SelectOption
local C_GossipInfo_GetNumOptions = C_GossipInfo.GetNumOptions
local C_GossipInfo_GetActiveQuests = C_GossipInfo.GetActiveQuests
local C_GossipInfo_SelectActiveQuest = C_GossipInfo.SelectActiveQuest
local C_GossipInfo_GetAvailableQuests = C_GossipInfo.GetAvailableQuests
local C_GossipInfo_GetNumActiveQuests = C_GossipInfo.GetNumActiveQuests
local C_GossipInfo_SelectAvailableQuest = C_GossipInfo.SelectAvailableQuest
local C_GossipInfo_GetNumAvailableQuests = C_GossipInfo.GetNumAvailableQuests
local MINIMAP_TRACKING_TRIVIAL_QUESTS = MINIMAP_TRACKING_TRIVIAL_QUESTS

local choiceQueue

local QuickQuestCheckButton = CreateFrame("CheckButton", nil, ObjectiveTrackerBlocksFrame.QuestHeader, "OptionsCheckButtonTemplate")
QuickQuestCheckButton:SetPoint("TOPLEFT", ObjectiveTrackerBlocksFrame.QuestHeader, -18, -2)
QuickQuestCheckButton:SetSize(21, 21)
QuickQuestCheckButton:SetHitRectInsets(0, -10, 0, 0)
QuickQuestCheckButton:RegisterEvent("PLAYER_LOGIN")
QuickQuestCheckButton:SetScript("OnEvent", function(self) self:SetChecked(R.db["Misc"]["AutoQuest"]) end)
QuickQuestCheckButton:SetScript("OnClick", function(self) R.db["Misc"]["AutoQuest"] = self:GetChecked() end)

-- Main
local QuickQuest = CreateFrame("Frame")
QuickQuest:SetScript("OnEvent", function(self, event, ...) self[event](...) end)

function QuickQuest:Register(event, func)
	self:RegisterEvent(event)
	self[event] = function(...)
		if R.db["Misc"]["AutoQuest"] and not IsShiftKeyDown() then
			func(...)
		end
	end
end

local function GetNPCID()
	return M.GetNPCID(UnitGUID("npc"))
end

local function IsTrackingHidden()
	for index = 1, GetNumTrackingTypes() do
		local name, _, active = GetTrackingInfo(index)
		if name == MINIMAP_TRACKING_TRIVIAL_QUESTS then
			return active
		end
	end
end

local ignoreQuestNPC = {
	[14847] = true,		-- DarkMoon
	[43929] = true,		-- 4000
	[88570] = true, -- Fate-Twister Tiklal
	[87391] = true, -- Fate-Twister Seress
	[93538] = true,		-- 达瑞妮斯
	[98489] = true,		-- 海难俘虏
	[99180] = true, -- Legendary Ring
	[99183] = true, -- Legendary Ring

	[101462] = true, -- Reaves
	[101880] = true,	-- 泰克泰克
	[103792] = true, 	-- 格里伏塔 -- Griftah (one of his quests is a scam)
	[105387] = true,	-- 安杜斯
	[106655] = true,	-- Legendary Item Upgrade
	[108868] = true, -- Hunter's order hall	
	[111243] = true, -- Archmage Lan'dalock

	[114719] = true,	-- 商人塞林
	[119388] = true,	-- 酋长哈顿
	[121263] = true,	-- 大技师罗姆尔
	[124312] = true,	-- 图拉扬
	[126954] = true,	-- 图拉扬
	[127037] = true, -- 纳毕鲁 (repeatable resource quest)
	[135690] = true,	-- 亡灵舰长
	[141584] = true,	-- 祖尔温
	[142063] = true,	-- 特兹兰
	[143388] = true,	-- 德鲁扎
	[143555] = true,	-- 山德·希尔伯曼，祖达萨PVP军需官	
	
	[150122] = true, -- 荣耀堡法师，联盟
	[150131] = true, -- 萨尔玛法师，部落
	[150563] = true,	-- 斯卡基特，麦卡贡订单日常
	[150987] = true,	-- 肖恩·维克斯，斯坦索姆
	[154534] = true,	-- 大杂院阿畅
	[160248] = true,	-- 档案员费安，罪魂碎片
	[162804] = true,	-- 威娜莉
	[168430] = true,	-- 戴克泰丽丝，格里恩挑战
	[326027] = true,	-- 运输站回收生成器DX-82	
}

R.IgnoreQuestNPC = {}

QuickQuest:Register("QUEST_GREETING", function()
	local npcID = GetNPCID()
	if R.IgnoreQuestNPC[npcID] then return end

	local active = GetNumActiveQuests()
	if active > 0 then
		for index = 1, active do
			local _, isComplete = GetActiveTitle(index)
			local questID = GetActiveQuestID(index)
			if isComplete and not C_QuestLog_IsWorldQuest(questID) then
				SelectActiveQuest(index)
			end
		end
	end

	local available = GetNumAvailableQuests()
	if available > 0 then
		for index = 1, available do
			local isTrivial = GetAvailableQuestInfo(index)
			if not isTrivial or IsTrackingHidden() then
				SelectAvailableQuest(index)
			end
		end
	end
end)

local ignoreGossipNPC = {
	-- Bodyguards
	[86945] = true, -- Aeda Brightdawn (Horde)
	[86933] = true, -- Vivianne (Horde)
	[86927] = true, -- Delvar Ironfist (Alliance)
	[86934] = true, -- Defender Illona (Alliance)
	[86682] = true, -- Tormmok
	[86964] = true, -- Leorajh
	[86946] = true, -- Talonpriest Ishaal

	-- Sassy Imps
	[95139] = true,
	[95141] = true,
	[95142] = true,
	[95143] = true,
	[95144] = true,
	[95145] = true,
	[95146] = true,
	[95200] = true,
	[95201] = true,

	-- Misc NPCs
	[79740] = true, -- Warmaster Zog (Horde)
	[79953] = true, -- Lieutenant Thorn (Alliance)
	[84268] = true, -- Lieutenant Thorn (Alliance)
	[84511] = true, -- Lieutenant Thorn (Alliance)
	[84684] = true, -- Lieutenant Thorn (Alliance)
	[117871] = true, -- War Councilor Victoria (Class Challenges @ Broken Shore)
	[155101] = true, -- 元素精华融合器
	[155261] = true, -- 肖恩·维克斯，斯坦索姆
	[150122] = true, -- 荣耀堡法师
	[150131] = true, -- 萨尔玛法师

	[173021] = true, -- 刻符牛头人
	[171589] = true, -- 德莱文将军
	[171787] = true, -- 文官阿得赖斯提斯
	[171795] = true, -- 月莓女勋爵
	[171821] = true, -- 德拉卡女男爵
	[172558] = true, -- 艾拉·引路者（导师）
	[172572] = true, -- 瑟蕾丝特·贝利文科（导师）
	[175513] = true, -- 纳斯利亚审判官，傲慢
	[165196] = true, -- 灰烬王庭，西塔尔
	[180458] = true, -- 灰烬王庭，大帝幻象
	[182681] = true, -- 扎雷殁提斯，强化控制台
}

local rogueClassHallInsignia = {
	[97004] = true, -- "Red" Jack Findle
	[96782] = true, -- Lucian Trias
	[93188] = true, -- Mongar
	[107486] = true, -- CoS rumors
	[167839] = true, -- 灵魂残渣，爬塔
}

local followerAssignees = {
	[138708] = true, -- 半兽人迦罗娜
	[135614] = true, -- 马迪亚斯·肖尔大师
}

local autoGossipTypes = {
	["taxi"] = true,
	["gossip"] = true,
	["banker"] = true,
	["vendor"] = true,
	["trainer"] = true,
}

local ignoreInstances = {
	[1571] = true, -- 枯法者
	[1626] = true, -- 群星庭院
}

local darkmoonDailyNPCs = {
	[54601] = true, -- Mola
	[15303] = true, -- Maxima Blastenheimer
	[14841] = true, -- Rinling
	[54605] = true, -- Finlay Coolshot
	[85546] = true, -- Ziggie Sparks
	[54485] = true, -- Jessica Rogers
	[85519] = true, -- Christoph VonFeasel
	[67370] = true, -- Jeremy Feasel
}

QuickQuest:Register("GOSSIP_SHOW", function()
	local npcID = GetNPCID()
	if R.IgnoreQuestNPC[npcID] then return end

	local active = C_GossipInfo_GetNumActiveQuests()
	if active > 0 then
		for index, questInfo in ipairs(C_GossipInfo_GetActiveQuests()) do
			local questID = questInfo.questID
			local isWorldQuest = questID and C_QuestLog_IsWorldQuest(questID)
			if questInfo.isComplete and (not questID or not isWorldQuest) then
				C_GossipInfo_SelectActiveQuest(index)
			end
		end
	end

	local available = C_GossipInfo_GetNumAvailableQuests()
	if available > 0 then
		for index, questInfo in ipairs(C_GossipInfo_GetAvailableQuests()) do
			local trivial = questInfo.isTrivial
			if not trivial or IsTrackingHidden() or (trivial and npcID == 64337) then
				C_GossipInfo_SelectAvailableQuest(index)
			end
		end
	end

	if rogueClassHallInsignia[npcID] then
		return C_GossipInfo_SelectOption(1)
	end

	if available == 0 and active == 0 then
		local numOptions = C_GossipInfo_GetNumOptions()
		if numOptions == 1 then
			if npcID == 57850 then
				return C_GossipInfo_SelectOption(1)
			end

			local _, instance, _, _, _, _, _, mapID = GetInstanceInfo()
			if instance ~= "raid" and not ignoreGossipNPC[npcID] and not ignoreInstances[mapID] then
				local gossipInfoTable = C_GossipInfo_GetOptions()
				local gType = gossipInfoTable[1] and gossipInfoTable[1].type
				if gType and autoGossipTypes[gType] then
					C_GossipInfo_SelectOption(1)
					return
				end
			end
		elseif followerAssignees[npcID] and numOptions > 1 then
			return C_GossipInfo_SelectOption(1)
		end
	end
end)

local darkmoonNPC = {
	[57850] = true, -- Teleportologist Fozlebub
	[55382] = true, -- Darkmoon Faire Mystic Mage (Horde)
	[54334] = true, -- Darkmoon Faire Mystic Mage (Alliance)
}

QuickQuest:Register("GOSSIP_CONFIRM", function(index)
	local npcID = GetNPCID()
	if npcID and darkmoonNPC[npcID] then
		C_GossipInfo_SelectOption(index, "", true)
		StaticPopup_Hide("GOSSIP_CONFIRM")
	end
end)

QuickQuest:Register("QUEST_DETAIL", function()
	if QuestIsFromAreaTrigger() then
		AcceptQuest()
	elseif QuestGetAutoAccept() then
		AcknowledgeAutoAcceptQuest()
	elseif not C_QuestLog_IsQuestTrivial(GetQuestID()) or IsTrackingHidden() then
		if not R.IgnoreQuestNPC[GetNPCID()] then
			AcceptQuest()
		end
	end
end)

QuickQuest:Register("QUEST_ACCEPT_CONFIRM", AcceptQuest)

QuickQuest:Register("QUEST_ACCEPTED", function()
	if QuestFrame:IsShown() and QuestGetAutoAccept() then
		CloseQuest()
	end
end)

QuickQuest:Register("QUEST_ITEM_UPDATE", function()
	if choiceQueue and QuickQuest[choiceQueue] then
		QuickQuest[choiceQueue]()
	end
end)

local itemBlacklist = {
	-- Inscription weapons
	[31690] = 79343, -- Inscribed Tiger Staff
	[31691] = 79340, -- Inscribed Crane Staff
	[31692] = 79341, -- Inscribed Serpent Staff

	-- Darkmoon Faire artifacts
	[29443] = 71635, -- Imbued Crystal
	[29444] = 71636, -- Monstrous Egg
	[29445] = 71637, -- Mysterious Grimoire
	[29446] = 71638, -- Ornate Weapon
	[29451] = 71715, -- A Treatise on Strategy
	[29456] = 71951, -- Banner of the Fallen
	[29457] = 71952, -- Captured Insignia
	[29458] = 71953, -- Fallen Adventurer's Journal
	[29464] = 71716, -- Soothsayer's Runes

	-- Tiller Gifts
	["progress_79264"] = 79264, -- Ruby Shard
	["progress_79265"] = 79265, -- Blue Feather
	["progress_79266"] = 79266, -- Jade Cat
	["progress_79267"] = 79267, -- Lovely Apple
	["progress_79268"] = 79268, -- Marsh Lily

	-- Garrison scouting missives
	[38180] = 122424, -- Scouting Missive: Broken Precipice
	[38193] = 122423, -- Scouting Missive: Broken Precipice
	[38182] = 122418, -- Scouting Missive: Darktide Roost
	[38196] = 122417, -- Scouting Missive: Darktide Roost
	[38179] = 122400, -- Scouting Missive: Everbloom Wilds
	[38192] = 122404, -- Scouting Missive: Everbloom Wilds
	[38194] = 122420, -- Scouting Missive: Gorian Proving Grounds
	[38202] = 122419, -- Scouting Missive: Gorian Proving Grounds
	[38178] = 122402, -- Scouting Missive: Iron Siegeworks
	[38191] = 122406, -- Scouting Missive: Iron Siegeworks
	[38184] = 122413, -- Scouting Missive: Lost Veil Anzu
	[38198] = 122414, -- Scouting Missive: Lost Veil Anzu
	[38177] = 122403, -- Scouting Missive: Magnarok
	[38190] = 122399, -- Scouting Missive: Magnarok
	[38181] = 122421, -- Scouting Missive: Mok'gol Watchpost
	[38195] = 122422, -- Scouting Missive: Mok'gol Watchpost
	[38185] = 122411, -- Scouting Missive: Pillars of Fate
	[38199] = 122409, -- Scouting Missive: Pillars of Fate
	[38187] = 122412, -- Scouting Missive: Shattrath Harbor
	[38201] = 122410, -- Scouting Missive: Shattrath Harbor
	[38186] = 122408, -- Scouting Missive: Skettis
	[38200] = 122407, -- Scouting Missive: Skettis
	[38183] = 122416, -- Scouting Missive: Socrethar's Rise
	[38197] = 122415, -- Scouting Missive: Socrethar's Rise
	[38176] = 122405, -- Scouting Missive: Stonefury Cliffs
	[38189] = 122401, -- Scouting Missive: Stonefury Cliffs

	-- Misc
	[31664] = 88604, -- Nat's Fishing Journal
}

QuickQuest:Register("QUEST_PROGRESS", function()
	if IsQuestCompletable() then
		local info = C_QuestLog_GetQuestTagInfo(GetQuestID())
		if info and (info.tagID == 153 or info.worldQuestType) then return end

		local npcID = GetNPCID()
		if R.IgnoreQuestNPC[npcID] then return end

		local requiredItems = GetNumQuestItems()
		if requiredItems > 0 then
			for index = 1, requiredItems do
				local link = GetQuestItemLink("required", index)
				if link then
					local id = GetItemInfoFromHyperlink(link)
					for _, itemID in next, itemBlacklist do
						if itemID == id then
							CloseQuest()
							return
						end
					end
				else
					choiceQueue = "QUEST_PROGRESS"
					GetQuestItemInfo("required", index)
					return
				end
			end
		end

		CompleteQuest()
	end
end)

local cashRewards = {
	[45724] = 1e5, -- Champion's Purse, 10 gold
	[64491] = 2e6, -- Royal Reward, 200 gold

	-- Items from the Sixtrigger brothers quest chain in Stormheim
	[138127] = 15, -- Mysterious Coin, 15 copper
	[138129] = 11, -- Swatch of Priceless Silk, 11 copper
	[138131] = 24, -- Magical Sprouting Beans, 24 copper
	[138123] = 15, -- Shiny Gold Nugget, 15 copper
	[138125] = 16, -- Crystal Clear Gemstone, 16 copper
	[138133] = 27, -- Elixir of Endless Wonder, 27 copper
}
local darkmoonNPCs = {
	-- Darkmoon Faire teleporation NPCs
	[57850] = true, -- Teleportologist Fozlebub
	[55382] = true, -- Darkmoon Faire Mystic Mage (Horde)
	[54334] = true, -- Darkmoon Faire Mystic Mage (Alliance)
}
local rogueNPCs = {
	-- Rogue class hall doors
	[97004] = true, -- "Red" Jack Findle
	[96782] = true, -- Lucian Trias
	[93188] = true, -- Mongar
}

QuickQuest:Register("QUEST_COMPLETE", function()
	-- Blingtron 6000 only!
	local npcID = GetNPCID()
	if npcID == 43929 or npcID == 77789 then return end

	local choices = GetNumQuestChoices()
	if choices <= 1 then
		GetQuestReward(1)
	elseif choices > 1 then
		local bestValue, bestIndex = 0

		for index = 1, choices do
			local link = GetQuestItemLink("choice", index)
			if link then
				local value = select(11, GetItemInfo(link))
				local itemID = GetItemInfoFromHyperlink(link)
				value = cashRewards[itemID] or value

				if value > bestValue then
					bestValue, bestIndex = value, index
				end
			else
				choiceQueue = "QUEST_COMPLETE"
				return GetQuestItemInfo("choice", index)
			end
		end

		local button = bestIndex and QuestInfoRewardsFrame.RewardButtons[bestIndex]
		if button then
			QuestInfoItem_OnClick(button)
		end
	end
end)

local function AttemptAutoComplete(event)
	if GetNumAutoQuestPopUps() > 0 then
		if UnitIsDeadOrGhost("player") then
			QuickQuest:Register("PLAYER_REGEN_ENABLED", AttemptAutoComplete)
			return
		end

		local questID, popUpType = GetAutoQuestPopUp(1)
		if not C_QuestLog_IsWorldQuest(questID) then
			if popUpType == "OFFER" then
				ShowQuestOffer(questID)
			elseif popUpType == "COMPLETE" then
				ShowQuestComplete(questID)
			end
		end
	end

	if event == "PLAYER_REGEN_ENABLED" then
		QuickQuest:UnregisterEvent(event)
	end
end
QuickQuest:Register("QUEST_LOG_UPDATE", AttemptAutoComplete)

-- Handle ignore list
local function UpdateIgnoreList()
	wipe(R.IgnoreQuestNPC)

	for npcID, value in pairs(ignoreQuestNPC) do
		R.IgnoreQuestNPC[npcID] = value
	end

	for npcID, value in pairs(R.db["Misc"]["IgnoreQuestNPC"]) do
		if value and ignoreQuestNPC[npcID] then
			R.db["Misc"]["IgnoreQuestNPC"][npcID] = nil
		else
			R.IgnoreQuestNPC[npcID] = value
		end
	end
end

local function UnitQuickQuestStatus(self)
	if not self.__ignore then
		local frame = CreateFrame("Frame", nil, self)
		frame:SetSize(100, 14)
		frame:SetPoint("TOP", self, "BOTTOM", 0, -2)
		M.AddTooltip(frame, "ANCHOR_RIGHT", U["AutoQuestIgnoreTip"], "info", true)
		M.CreateFS(frame, 14, IGNORED):SetTextColor(1, 0, 0)

		self.__ignore = frame

		UpdateIgnoreList()
	end

	local npcID = GetNPCID()
	local isIgnored = R.db["Misc"]["AutoQuest"] and npcID and R.IgnoreQuestNPC[npcID]
	self.__ignore:SetShown(isIgnored)
end

local function ToggleQuickQuestStatus(self)
	if not self.__ignore then return end
	if not R.db["Misc"]["AutoQuest"] then return end
	if not IsAltKeyDown() then return end

	self.__ignore:SetShown(not self.__ignore:IsShown())
	local npcID = GetNPCID()
	if self.__ignore:IsShown() then
		if ignoreQuestNPC[npcID] then
			R.db["Misc"]["IgnoreQuestNPC"][npcID] = nil
		else
			R.db["Misc"]["IgnoreQuestNPC"][npcID] = true
		end
	else
		if ignoreQuestNPC[npcID] then
			R.db["Misc"]["IgnoreQuestNPC"][npcID] = false
		else
			R.db["Misc"]["IgnoreQuestNPC"][npcID] = nil
		end
	end

	UpdateIgnoreList()
end

QuestNpcNameFrame:HookScript("OnShow", UnitQuickQuestStatus)
QuestNpcNameFrame:HookScript("OnMouseDown", ToggleQuickQuestStatus)
GossipNpcNameFrame:HookScript("OnShow", UnitQuickQuestStatus)
GossipNpcNameFrame:HookScript("OnMouseDown", ToggleQuickQuestStatus)