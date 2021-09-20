local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local pairs, strfind = pairs, strfind
local UnitGUID, InCombatLockdown, IsResting = UnitGUID, InCombatLockdown, IsResting
local GetActionInfo, GetSpellInfo, GetOverrideBarSkin = GetActionInfo, GetSpellInfo, GetOverrideBarSkin
local ClearOverrideBindings, SetOverrideBindingClick, SetBinding = ClearOverrideBindings, SetOverrideBindingClick, SetBinding
local C_QuestLog_GetLogIndexForQuestID = C_QuestLog.GetLogIndexForQuestID
local C_QuestLog_GetDistanceSqToQuest = C_QuestLog.GetDistanceSqToQuest
local C_GossipInfo_SelectOption, C_GossipInfo_GetNumOptions = C_GossipInfo.SelectOption, C_GossipInfo.GetNumOptions

local watchQuests = {
	-- check npc
	[60739] = true, -- https://www.wowhead.com/quest=60739/tough-crowd
	[62453] = true, -- https://www.wowhead.com/quest=62453/into-the-unknown
	-- glow
	[59585] = true, -- https://www.wowhead.com/quest=59585/well-make-an-aspirant-out-of-you
	[64271] = true, -- https://www.wowhead.com/quest=64271/a-more-civilized-way
	-- mousewheel
	[60657] = 333960, -- https://www.wowhead.com/quest=60657/aid-from-above
	[64018] = 356464, -- https://www.wowhead.com/quest=64018/the-weight-of-stone
	-- others
	[62459] = true, -- https://www.wowhead.com/quest=62459/go-beyond -- questItem = 183725
}
local activeQuests = {}

local questNPCs = {
	[170080] = true, -- Boggart
	[174498] = true, -- Shimmersod
}

function MISC:GetOverrideIndex(spellID)
	if spellID == 356464 then
		return 1, 2
	elseif spellID == 356151 or spellID == 333960 then
		return 1
	end
end

local function GetActionSpell(index)
	local button = _G["ActionButton"..index]
	local _, spellID = GetActionInfo(button.action)
	return spellID
end

local function GetOverrideButton(index)
	return "OverrideActionBarButton"..index
end

function MISC:QuestTool_Init()
	for questID, value in pairs(watchQuests) do
		if C_QuestLog_GetLogIndexForQuestID(questID) then
			activeQuests[questID] = value
		end
	end
end

function MISC:QuestTool_Accept(questID)
	if watchQuests[questID] then
		activeQuests[questID] = watchQuests[questID]
	end
end

function MISC:QuestTool_Remove(questID)
	if watchQuests[questID] then
		activeQuests[questID] = nil
	end
end

function MISC:QuestTool_IsMatch(questID, spellID)
	return activeQuests[questID] == spellID
end

function MISC:QuestTool_SetAction()
	local spellID = GetActionSpell(1)
	if MISC:QuestTool_IsMatch(60657, spellID) or MISC:QuestTool_IsMatch(64018, spellID) or spellID == 356151 then
		if InCombatLockdown() then
			M:RegisterEvent("PLAYER_REGEN_ENABLED", MISC.QuestTool_SetAction)
			MISC.isDelay = true
		else
			local index1, index2 = MISC:GetOverrideIndex(spellID)
			if index1 then
				ClearOverrideBindings(MISC.QuestHandler)
				SetOverrideBindingClick(MISC.QuestHandler, true, "MOUSEWHEELUP", GetOverrideButton(index1))
				if index2 then
					SetOverrideBindingClick(MISC.QuestHandler, true, "MOUSEWHEELDOWN", GetOverrideButton(index2))
				end

				MISC.QuestTip:SetText(I.NDuiString.." "..U["SpellTip"..spellID])
				MISC.QuestTip:Show()
				MISC.isHandling = true

				if MISC.isDelay then
					M:UnregisterEvent("PLAYER_REGEN_ENABLED", MISC.QuestTool_SetAction)
					MISC.isDelay = nil
				end
			end
		end
	end
end

function MISC:QuestTool_ClearAction()
	if MISC.isHandling then
		MISC.isHandling = nil
		ClearOverrideBindings(MISC.QuestHandler)
		MISC.QuestTip:Hide()
	end
end

local fixedStrings = {
	["横扫"] = "低扫",
	["突刺"] = "突袭",
}
local function isActionMatch(msg, text)
	return text and strfind(msg, text)
end

function MISC:QuestTool_SetGlow(msg)
	if GetOverrideBarSkin() and (activeQuests[59585] or activeQuests[64271]) then
		for i = 1, 3 do
			local button = _G["ActionButton"..i]
			local _, spellID = GetActionInfo(button.action)
			local name = spellID and GetSpellInfo(spellID)
			if fixedStrings[name] and isActionMatch(msg, fixedStrings[name]) or isActionMatch(msg, name) then
				M.ShowOverlayGlow(button)
			else
				M.HideOverlayGlow(button)
			end
		end
		MISC.isGlowing = true
	else
		MISC:QuestTool_ClearGlow()
	end
end

function MISC:QuestTool_ClearGlow()
	if MISC.isGlowing then
		MISC.isGlowing = nil
		for i = 1, 3 do
			M.HideOverlayGlow(_G["ActionButton"..i])
		end
	end
end

function MISC:QuestTool_SetQuestUnit()
	if not activeQuests[60739] and not activeQuests[62453] then return end

	local guid = UnitGUID("mouseover")
	local npcID = guid and M.GetNPCID(guid)
	if questNPCs[npcID] then
		self:AddLine(U["NPCisTrue"])
	end
end

function MISC:QuestTool_UpdateBinding()
	if activeQuests[62459] and not IsResting() and C_QuestLog_GetDistanceSqToQuest(62459) < 35000 then
		SetBinding("MOUSEWHEELUP", "EXTRAACTIONBUTTON1")
		MISC.isBinding = true
		MISC.QuestTip:SetText(I.NDuiString.." "..U["CatchButterfly"])
		MISC.QuestTip:Show()
	elseif MISC.isBinding then
		SetBinding("MOUSEWHEELUP", MISC.SavedKey)
		MISC.isBinding = nil
		MISC.QuestTip:Hide()
	end
end

function MISC:QuestTool()
	if not R.db["Misc"]["QuestTool"] then return end

	local handler = CreateFrame("Frame", nil, UIParent)
	MISC.QuestHandler = handler

	local text = M.CreateFS(handler, 20)
	text:ClearAllPoints()
	text:SetPoint("TOP", UIParent, 0, -200)
	text:SetWidth(800)
	text:SetWordWrap(true)
	text:Hide()
	MISC.QuestTip = text

	-- Check existing quests
	MISC:QuestTool_Init()
	M:RegisterEvent("QUEST_ACCEPTED", MISC.QuestTool_Accept)
	M:RegisterEvent("QUEST_REMOVED", MISC.QuestTool_Remove)

	-- Vehicle button quests
	C_Timer.After(10, MISC.QuestTool_SetAction) -- may need this for ui reload
	M:RegisterEvent("UNIT_ENTERED_VEHICLE", MISC.QuestTool_SetAction)
	M:RegisterEvent("UNIT_EXITED_VEHICLE", MISC.QuestTool_ClearAction)

	-- Override button quests
	if R.db["Actionbar"]["Enable"] then
		M:RegisterEvent("CHAT_MSG_MONSTER_SAY", MISC.QuestTool_SetGlow)
		M:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", MISC.QuestTool_ClearGlow)
	end

	-- Check npc in quests
	GameTooltip:HookScript("OnTooltipSetUnit", MISC.QuestTool_SetQuestUnit)

	-- Quest items
	MISC.SavedKey = GetBindingFromClick("MOUSEWHEELUP")
	MISC:QuestTool_UpdateBinding()
	M:RegisterEvent("ZONE_CHANGED", MISC.QuestTool_UpdateBinding)
	M:RegisterEvent("ZONE_CHANGED_INDOORS", MISC.QuestTool_UpdateBinding)

	-- Auto gossip
	local firstStep
	M:RegisterEvent("GOSSIP_SHOW", function()
		local guid = UnitGUID("npc")
		local npcID = guid and M.GetNPCID(guid)
		if npcID == 174498 then
			C_GossipInfo_SelectOption(3)
		elseif npcID == 174371 then
			if GetItemCount(183961) == 0 then return end
			if C_GossipInfo_GetNumOptions() ~= 5 then return end
			if firstStep then
				C_GossipInfo_SelectOption(5)
			else
				C_GossipInfo_SelectOption(2)
				firstStep = true
			end
		end
	end)
end

MISC:RegisterMisc("QuestTool", MISC.QuestTool)