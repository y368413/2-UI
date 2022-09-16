local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local format, gsub, strsplit, strfind = string.format, string.gsub, string.split, string.find
local pairs, wipe, select = pairs, wipe, select
local GetInstanceInfo, PlaySound, print = GetInstanceInfo, PlaySound, print
local IsPartyLFG, IsInRaid, IsInGroup, IsInInstance, IsInGuild = IsPartyLFG, IsInRaid, IsInGroup, IsInInstance, IsInGuild
local UnitInRaid, UnitInParty, SendChatMessage = UnitInRaid, UnitInParty, SendChatMessage
local UnitName, Ambiguate, GetTime = UnitName, Ambiguate, GetTime
local GetSpellLink, GetSpellInfo, GetSpellCooldown = GetSpellLink, GetSpellInfo, GetSpellCooldown
local GetActionInfo, GetMacroSpell, GetMacroItem = GetActionInfo, GetMacroSpell, GetMacroItem
local GetItemInfo, GetItemInfoFromHyperlink = GetItemInfo, GetItemInfoFromHyperlink
local C_Timer_After = C_Timer.After
local C_Map_GetBestMapForUnit = C_Map.GetBestMapForUnit
local C_VignetteInfo_GetVignetteInfo = C_VignetteInfo.GetVignetteInfo
local C_VignetteInfo_GetVignettePosition = C_VignetteInfo.GetVignettePosition
local C_Texture_GetAtlasInfo = C_Texture.GetAtlasInfo
local C_ChatInfo_SendAddonMessage = C_ChatInfo.SendAddonMessage
local C_ChatInfo_RegisterAddonMessagePrefix = C_ChatInfo.RegisterAddonMessagePrefix
local C_ChallengeMode_GetActiveKeystoneInfo = C_ChallengeMode.GetActiveKeystoneInfo

--[[
	SoloInfo是一个告知你当前副本难度的小工具，防止我有时候单刷时进错难度了。
	instList左侧是副本ID，你可以使用"/getid"命令来获取当前副本的ID；右侧的是副本难度，常用的一般是：2为5H，4为25普通，6为25H。
]]
local soloInfo
local instList = {
	[556] = 2,		-- H塞塔克大厅，乌鸦
	[575] = 2,		-- H乌特加德之巅，蓝龙
	[585] = 2,		-- H魔导师平台，白鸡
	[631] = 6,		-- 25H冰冠堡垒，无敌
	[1205] = 16,	-- M黑石，裂蹄牛
	[1448] = 16,	-- M地狱火，魔钢
	[1651] = 23,	-- M卡拉赞，新午夜
}

function MISC:SoloInfo_Create()
	if soloInfo then soloInfo:Show() return end

	soloInfo = CreateFrame("Frame", nil, UIParent)
	soloInfo:SetPoint("CENTER", 0, 120)
	soloInfo:SetSize(150, 70)
	M.SetBD(soloInfo)

	soloInfo.Text = M.CreateFS(soloInfo, 14, "")
	soloInfo.Text:SetWordWrap(true)
	soloInfo:SetScript("OnMouseUp", function() soloInfo:Hide() end)
end

function MISC:SoloInfo_Update()
	local name, instType, diffID, diffName, _, _, _, instID = GetInstanceInfo()
	if diffID == 8 then return end -- don't alert in mythic+

	if (diffName and diffName ~= "") and instType ~= "none" and diffID ~= 24 and instList[instID] and instList[instID] ~= diffID then
		MISC:SoloInfo_Create()
		soloInfo.Text:SetText(I.InfoColor..name..I.MyColor.."\n( "..diffName.." )\n\n"..I.InfoColor.."^-^")
	else
		if soloInfo then soloInfo:Hide() end
	end
end

function MISC:SoloInfo_DelayCheck()
	C_Timer_After(3, MISC.SoloInfo_Update)
end

function MISC:SoloInfo()
	if R.db["Misc"]["SoloInfo"] then
		MISC:SoloInfo_Update()
		M:RegisterEvent("PLAYER_ENTERING_WORLD", MISC.SoloInfo_DelayCheck)
		M:RegisterEvent("PLAYER_DIFFICULTY_CHANGED", MISC.SoloInfo_DelayCheck)
	else
		if soloInfo then soloInfo:Hide() end
		M:UnregisterEvent("PLAYER_ENTERING_WORLD", MISC.SoloInfo_DelayCheck)
		M:UnregisterEvent("PLAYER_DIFFICULTY_CHANGED", MISC.SoloInfo_DelayCheck)
	end
end

--[[
	发现稀有/事件时的通报插件
]]
local cache = {}
local isIgnoredZone = {
	[1153] = true,	-- 部落要塞
	[1159] = true,	-- 联盟要塞
	[1803] = true,	-- 涌泉海滩
	[1876] = true,	-- 部落激流堡
	[1943] = true,	-- 联盟激流堡
	[2111] = true,	-- 黑海岸前线
}

local function isUsefulAtlas(info)
	local atlas = info.atlasName
	if atlas then
		return strfind(atlas, "[Vv]ignette") or (atlas == "nazjatar-nagaevent")
	end
end

function MISC:RareAlert_Update(id)
	if id and not cache[id] then
		local info = C_VignetteInfo_GetVignetteInfo(id)
		if not info or not isUsefulAtlas(info) then return end

		local atlasInfo = C_Texture_GetAtlasInfo(info.atlasName)
		if not atlasInfo then return end
		local tex = M:GetTextureStrByAtlas(atlasInfo)
		if not tex then return end

		--UIErrorsFrame:AddMessage(I.InfoColor..U["Rare Found"]..tex..(info.name or ""))
		RaidNotice_AddMessage(RaidWarningFrame, "----------   "..tex..(info.name or "").."   ----------", ChatTypeInfo["RAID_WARNING"])
		if R.db["Misc"]["RarePrint"] then
			local currrentTime = MaoRUIDB["TimestampFormat"] == 1 and "|cff00ff00["..date("%H:%M:%S").."]|r" or ""
			local nameString
			local mapID = C_Map_GetBestMapForUnit("player")
			local position = mapID and C_VignetteInfo_GetVignettePosition(info.vignetteGUID, mapID)
			if position then
				local x, y = position:GetXY()
				nameString = format(MISC.RareString, mapID, x*10000, y*10000, info.name, x*100, y*100, "")
			end
			print(currrentTime.." -> "..I.InfoColor..tex..(nameString or info.name or ""))  --.." → "
		end
		if not R.db["Misc"]["RareAlertInWild"] or MISC.RareInstType == "none" then
			PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Dadongda.ogg", "Master")
		end

		cache[id] = true
	end

	if #cache > 666 then wipe(cache) end
end

function MISC:RareAlert_CheckInstance()
	local _, instanceType, _, _, maxPlayers, _, _, instID = GetInstanceInfo()
	if (instID and isIgnoredZone[instID]) or (instanceType == "scenario" and (maxPlayers == 3 or maxPlayers == 6)) then
		M:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED", MISC.RareAlert_Update)
	else
		M:RegisterEvent("VIGNETTE_MINIMAP_UPDATED", MISC.RareAlert_Update)
	end
	MISC.RareInstType = instanceType
end

function MISC:RareAlert()
	MISC.RareString = "|Hworldmap:%d+:%d+:%d+|h[%s] <%.1f, %.1f>%s|h|r"

	if R.db["Misc"]["RareAlerter"] then
		MISC:RareAlert_CheckInstance()
		M:RegisterEvent("UPDATE_INSTANCE_INFO", MISC.RareAlert_CheckInstance)
	else
		wipe(cache)
		M:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED", MISC.RareAlert_Update)
		M:UnregisterEvent("UPDATE_INSTANCE_INFO", MISC.RareAlert_CheckInstance)
	end
end

--[[
	闭上你的嘴！
	打断、偷取及驱散法术时的警报
]]
function MISC:GetMsgChannel()
	return IsPartyLFG() and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY"
end

local function msgChannel()
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
		return "INSTANCE_CHAT"
	--elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
		--if warning and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or IsEveryoneAssistant()) then
			--return "RAID_WARNING"
		--else
			--return "RAID"
		--end
	elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
		return "PARTY"
	end
	return "SAY"
end

local infoType = {}

function MISC:InterruptAlert_Toggle()
	infoType["SPELL_STOLEN"] = R.db["Misc"]["DispellAlert"] and U["Steal"]
	infoType["SPELL_DISPEL"] = R.db["Misc"]["DispellAlert"] and U["Dispel"]
	infoType["SPELL_INTERRUPT"] = R.db["Misc"]["InterruptAlert"] and U["Interrupt"]
	infoType["SPELL_AURA_BROKEN_SPELL"] = R.db["Misc"]["BrokenAlert"] and U["BrokenSpell"]
end

function MISC:InterruptAlert_IsEnabled()
	for _, value in pairs(infoType) do
		if value then
			return true
		end
	end
end

local blackList = {
	[99] = true,		-- 夺魂咆哮
	[122] = true,		-- 冰霜新星
	[1776] = true,		-- 凿击
	[1784] = true,		-- 潜行
	[5246] = true,		-- 破胆怒吼
	[8122] = true,		-- 心灵尖啸
	[31661] = true,		-- 龙息术
	[33395] = true,		-- 冰冻术
	[64695] = true,		-- 陷地
	[82691] = true,		-- 冰霜之环
	[91807] = true,		-- 蹒跚冲锋
	[102359] = true,	-- 群体缠绕
	[105421] = true,	-- 盲目之光
	[115191] = true,	-- 潜行
	[157997] = true,	-- 寒冰新星
	[197214] = true,	-- 裂地术
	[198121] = true,	-- 冰霜撕咬
	[207167] = true,	-- 致盲冰雨
	[207685] = true,	-- 悲苦咒符
	[226943] = true,	-- 心灵炸弹
	[228600] = true,	-- 冰川尖刺
	[331866] = true,	-- 混沌代理人
	[354051] = true,	-- 轻盈步
}

function MISC:IsAllyPet(sourceFlags)
	if I:IsMyPet(sourceFlags) or sourceFlags == I.PartyPetFlags or sourceFlags == I.RaidPetFlags then
		return true
	end
end

function MISC:InterruptAlert_Update(...)
	local _, eventType, _, sourceGUID, sourceName, sourceFlags, _, _, destName, _, _, spellID, _, _, extraskillID, _, _, auraType = ...
	if not sourceGUID or sourceName == destName then return end

	if UnitInRaid(sourceName) or UnitInParty(sourceName) or MISC:IsAllyPet(sourceFlags) then
		local infoText = infoType[eventType]
		if infoText then
			local sourceSpellID, destSpellID
			if infoText == U["BrokenSpell"] then
				if auraType and auraType == AURA_TYPE_BUFF or blackList[spellID] then return end
				sourceSpellID, destSpellID = extraskillID, spellID
				if sourceSpellID and destSpellID then
					SendChatMessage(format(infoText, sourceName..GetSpellLink(sourceSpellID), destName..GetSpellLink(destSpellID)), msgChannel())
				end
			elseif infoText == U["Interrupt"] then
				if R.db["Misc"]["OwnInterrupt"] and sourceName ~= I.MyName and not I:IsMyPet(sourceFlags) then return end
				sourceSpellID, destSpellID = spellID, extraskillID
				if sourceSpellID and destSpellID then
					SendChatMessage(format(infoText, GetSpellLink(destSpellID)), msgChannel())
				end
			else
				if R.db["Misc"]["OwnDispell"] and sourceName ~= I.MyName and not I:IsMyPet(sourceFlags) then return end
				sourceSpellID, destSpellID = spellID, extraskillID
				if sourceSpellID and destSpellID then
					SendChatMessage(format(infoText, GetSpellLink(destSpellID)), msgChannel())
				end
			end
				if R.db["Misc"]["InterruptSound"] then
				    PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\ShutupFool.ogg", "Master")
				end
		end
	end
end

function MISC:InterruptAlert_CheckGroup()
	if IsInGroup() and (not R.db["Misc"]["InstAlertOnly"] or (IsInInstance() and not IsPartyLFG())) then
		M:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.InterruptAlert_Update)
	else
		M:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.InterruptAlert_Update)
	end
end

function MISC:InterruptAlert()
	MISC:InterruptAlert_Toggle()

	if MISC:InterruptAlert_IsEnabled() then
		MISC:InterruptAlert_CheckGroup()
		M:RegisterEvent("GROUP_LEFT", MISC.InterruptAlert_CheckGroup)
		M:RegisterEvent("GROUP_JOINED", MISC.InterruptAlert_CheckGroup)
		M:RegisterEvent("PLAYER_ENTERING_WORLD", MISC.InterruptAlert_CheckGroup)
	else
		M:UnregisterEvent("GROUP_LEFT", MISC.InterruptAlert_CheckGroup)
		M:UnregisterEvent("GROUP_JOINED", MISC.InterruptAlert_CheckGroup)
		M:UnregisterEvent("PLAYER_ENTERING_WORLD", MISC.InterruptAlert_CheckGroup)
		M:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.InterruptAlert_Update)
	end
end

--[[
	大米完成时，通报打球统计
]]
local eventList = {
	["SWING_DAMAGE"] = 13,
	["RANGE_DAMAGE"] = 16,
	["SPELL_DAMAGE"] = 16,
	["SPELL_PERIODIC_DAMAGE"] = 16,
	["SPELL_BUILDING_DAMAGE"] = 16,
}

function MISC:Explosive_Update(...)
	local _, eventType, _, _, sourceName, _, _, destGUID = ...
	local index = eventList[eventType]
	if index and M.GetNPCID(destGUID) == 120651 then
		local overkill = select(index, ...)
		if overkill and overkill > 0 then
			local name = strsplit("-", sourceName or UNKNOWN)
			local cache = R.db["Misc"]["ExplosiveCache"]
			if not cache[name] then cache[name] = 0 end
			cache[name] = cache[name] + 1
		end
	end
end

function MISC:Explosive_SendResult()
	local text
	for name, count in pairs(R.db["Misc"]["ExplosiveCache"]) do
		text = (text or U["ExplosiveCount"])..name.."("..count..") "
	end
	--if text then SendChatMessage(text, "PARTY") end
	if text then print(text) end
	M:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.Explosive_Update)
end

function MISC.Explosive_CheckAffixes(event)
	local _, affixes = C_ChallengeMode_GetActiveKeystoneInfo()
	if affixes[3] and affixes[3] == 13 then
		if event == "CHALLENGE_MODE_START" then
			wipe(R.db["Misc"]["ExplosiveCache"])
		end
		M:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.Explosive_Update)
		M:RegisterEvent("CHALLENGE_MODE_COMPLETED", MISC.Explosive_SendResult)
	else
		M:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.Explosive_Update)
		M:UnregisterEvent("CHALLENGE_MODE_COMPLETED", MISC.Explosive_SendResult)
	end
end

function MISC:ExplosiveAlert()
	if R.db["Misc"]["ExplosiveCount"] then
		MISC:Explosive_CheckAffixes()
		M:RegisterEvent("ZONE_CHANGED_NEW_AREA", MISC.Explosive_CheckAffixes)
		M:RegisterEvent("CHALLENGE_MODE_START", MISC.Explosive_CheckAffixes)
	else
		M:UnregisterEvent("ZONE_CHANGED_NEW_AREA", MISC.Explosive_CheckAffixes)
		M:UnregisterEvent("CHALLENGE_MODE_START", MISC.Explosive_CheckAffixes)
		M:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.Explosive_Update)
		M:UnregisterEvent("CHALLENGE_MODE_COMPLETED", MISC.Explosive_SendResult)
	end
end

--[[
	放大餐时叫一叫
]]
local myGUID = UnitGUID("player")
local groupUnits = {["player"] = true, ["pet"] = true}
for i = 1, 4 do
	groupUnits["party"..i] = true
	groupUnits["partypet"..i] = true
end
for i = 1, 40 do
	groupUnits["raid"..i] = true
	groupUnits["raidpet"..i] = true
end

local spellList = {
	[54710] = true,		-- 随身邮箱
	[67826] = true,		-- 基维斯
	[226241] = true,	-- 宁神圣典
	[256230] = true,	-- 静心圣典
	[185709] = true,	-- 焦糖鱼宴
	[259409] = true,	-- 海帆盛宴
	[259410] = true,	-- 船长盛宴
	[276972] = true,	-- 秘法药锅
	[286050] = true,	-- 鲜血大餐
	[265116] = true,	-- 8.0工程战复
	[308458] = true,	-- 惊异怡人大餐
	[308462] = true,	-- 纵情饕餮盛宴
	[345130] = true,	-- 9.0工程战复
	[307157] = true,	-- 永恒药锅
	[359336] = true,	-- 石头汤锅
	[324029] = true,	-- 宁心圣典

	[2825]   = true,	-- 嗜血
	[32182]  = true,	-- 英勇
	[80353]  = true,	-- 时间扭曲
	[264667] = true,	-- 原始暴怒，宠物
	[272678] = true,	-- 原始暴怒，宠物掌控
	[178207] = true,	-- 狂怒战鼓
	[230935] = true,	-- 高山战鼓
	[256740] = true,	-- 漩涡战鼓
	[292686] = true,	-- 雷皮之槌
	[309658] = true,	-- 死亡凶蛮战鼓
}

function MISC:ItemAlert_Update(unit, castID, spellID)
	if groupUnits[unit] and spellList[spellID] and (spellList[spellID] ~= castID) then
		SendChatMessage(format(U["SpellItemAlertStr"], UnitName(unit), GetSpellLink(spellID) or GetSpellInfo(spellID)), MISC:GetMsgChannel())
		spellList[spellID] = castID
	end
end

local bloodLustDebuffs = {
	[57723]  = true, -- 筋疲力尽
	[57724]  = true, -- 心满意足
	[80354]  = true, -- 时空错位
	[264689] = true, -- 疲倦
	[390435]  = true, -- 筋疲力尽，龙希尔
}

function MISC:CheckBloodlustStatus(...)
	local _, eventType, _, sourceGUID, _, _, _, _, _, _, _, spellID = ...
	if eventType == "SPELL_AURA_REMOVED" and bloodLustDebuffs[spellID] and sourceGUID == myGUID then
		SendChatMessage(format(U["BloodlustStr"], GetSpellLink(spellID), MISC.factionSpell), MISC:GetMsgChannel())
	end
end

function MISC:ItemAlert_CheckGroup()
	if IsInGroup() then
		M:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", MISC.ItemAlert_Update)
		M:RegisterEvent("CLEU", MISC.CheckBloodlustStatus)
	else
		M:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED", MISC.ItemAlert_Update)
		M:UnregisterEvent("CLEU", MISC.CheckBloodlustStatus)
	end
end

function MISC:SpellItemAlert()
	MISC.factionSpell = I.MyFaction == "Alliance" and 32182 or 2825
	MISC.factionSpell = GetSpellLink(MISC.factionSpell)

	if R.db["Misc"]["SpellItemAlert"] then
		MISC:ItemAlert_CheckGroup()
		M:RegisterEvent("GROUP_LEFT", MISC.ItemAlert_CheckGroup)
		M:RegisterEvent("GROUP_JOINED", MISC.ItemAlert_CheckGroup)
	else
		M:UnregisterEvent("GROUP_LEFT", MISC.ItemAlert_CheckGroup)
		M:UnregisterEvent("GROUP_JOINED", MISC.ItemAlert_CheckGroup)
		M:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED", MISC.ItemAlert_Update)
		M:UnregisterEvent("CLEU", MISC.CheckBloodlustStatus)
	end
end

-- 大幻象水晶及箱子计数
function MISC:NVision_Create()
	if MISC.VisionFrame then MISC.VisionFrame:Show() return end

	local frame = CreateFrame("Frame", nil, UIParent)
	frame:SetSize(24, 24)
	frame.bars = {}

	local mover = M.Mover(frame, U["NzothVision"], "NzothVision", {"TOP", PlayerPowerBarAlt, "BOTTOM"}, 216, 24)
	frame:ClearAllPoints()
	frame:SetPoint("CENTER", mover)

	local barData = {
		[1] = {
			anchorF = "RIGHT", anchorT = "LEFT", offset = -3,
			texture = 134110,
			color = {1, .8, 0}, reverse = false, maxValue = 10,
		},
		[2] = {
			anchorF = "LEFT", anchorT = "RIGHT", offset = 3,
			texture = 2000861,
			color = {.8, 0, 1}, reverse = true, maxValue = 12,
		}
	}

	for i, v in ipairs(barData) do
		local bar = CreateFrame("StatusBar", nil, frame)
		bar:SetSize(80, 20)
		bar:SetPoint(v.anchorF, frame, "CENTER", v.offset, 0)
		bar:SetMinMaxValues(0, v.maxValue)
		bar:SetValue(0)
		bar:SetReverseFill(v.reverse)
		M:SmoothBar(bar)
		M.CreateSB(bar, nil, unpack(v.color))
		bar.text = M.CreateFS(bar, 16, "0/"..v.maxValue, nil, "CENTER", 0, 0)

		local icon = CreateFrame("Frame", nil, bar)
		icon:SetSize(22, 22)
		icon:SetPoint(v.anchorF, bar, v.anchorT, v.offset, 0)
		M.PixelIcon(icon, v.texture)
		M.CreateSD(icon)

		bar.count = 0
		bar.__max = v.maxValue
		frame.bars[i] = bar
	end

	MISC.VisionFrame = frame
end

function MISC:NVision_Update(index, reset)
	local frame = MISC.VisionFrame
	local bar = frame.bars[index]
	if reset then bar.count = 0 end
	bar:SetValue(bar.count)
	bar.text:SetText(bar.count.."/"..bar.__max)
end

local castSpellIndex = {[143394] = 1, [306608] = 2}
function MISC:NVision_OnEvent(unit, _, spellID)
	local index = castSpellIndex[spellID]
	if index and (index == 1 or unit == "player") then
		local frame = MISC.VisionFrame
		local bar = frame.bars[index]
		bar.count = bar.count + 1
		MISC:NVision_Update(index)
	end
end

function MISC:NVision_Check()
	local diffID = select(3, GetInstanceInfo())
	if diffID == 152 then
		MISC:NVision_Create()
		M:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", MISC.NVision_OnEvent, "player")

		if not RaidBossEmoteFrame.__isOff then
			RaidBossEmoteFrame:UnregisterAllEvents()
			RaidBossEmoteFrame.__isOff = true
		end
	else
		if MISC.VisionFrame then
			MISC:NVision_Update(1, true)
			MISC:NVision_Update(2, true)
			MISC.VisionFrame:Hide()
			M:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED", MISC.NVision_OnEvent)
		end

		if RaidBossEmoteFrame.__isOff then
			if not R.db["Misc"]["HideBossEmote"] then
				RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
				RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_WHISPER")
				RaidBossEmoteFrame:RegisterEvent("CLEAR_BOSS_EMOTES")
			end
			RaidBossEmoteFrame.__isOff = nil
		end
	end
end

function MISC:NVision_Init()
	if not R.db["Misc"]["NzothVision"] then return end
	MISC:NVision_Check()
	M:RegisterEvent("UPDATE_INSTANCE_INFO", MISC.NVision_Check)
end

-- Incompatible check
local IncompatibleAddOns = {
	["BigFoot"] = true,
	["NDui"] = true,
	["!!!163UI!!!"] = true,
	["Aurora"] = true,
	["AuroraClassic"] = true, -- my own addon
	["DomiRank"] = true, -- my own addon
	["MDGuildBest"] = true, -- my own addon
	["SexyMap"] = true,
}
local AddonDependency = {
	["BigFoot"] = "!!!Libs",
}
function MISC:CheckIncompatible()
	local IncompatibleList = {}
	for addon in pairs(IncompatibleAddOns) do
		if IsAddOnLoaded(addon) then
			tinsert(IncompatibleList, addon)
		end
	end

	if #IncompatibleList > 0 then
		local frame = CreateFrame("Frame", nil, UIParent)
		frame:SetPoint("TOP", 0, -200)
		frame:SetFrameStrata("HIGH")
		M.CreateMF(frame)
		M.SetBD(frame)
		M.CreateFS(frame, 18, U["FoundIncompatibleAddon"], true, "TOPLEFT", 10, -10)
		M.CreateWatermark(frame)

		local offset = 0
		for _, addon in pairs(IncompatibleList) do
			M.CreateFS(frame, 14, addon, false, "TOPLEFT", 10, -(50 + offset))
			offset = offset + 24
		end
		frame:SetSize(300, 100 + offset)

		local close = M.CreateButton(frame, 16, 16, true, I.closeTex)
		close:SetPoint("TOPRIGHT", -10, -10)
		close:SetScript("OnClick", function() frame:Hide() end)

		local disable = M.CreateButton(frame, 150, 25, U["DisableIncompatibleAddon"])
		disable:SetPoint("BOTTOM", 0, 10)
		disable.text:SetTextColor(1, .8, 0)
		disable:SetScript("OnClick", function()
			for _, addon in pairs(IncompatibleList) do
				DisableAddOn(addon, true)
				if AddonDependency[addon] then
					DisableAddOn(AddonDependency[addon], true)
				end
			end
			ReloadUI()
		end)
	end
end

-- Send cooldown status
local function GetRemainTime(second)
	if second > 60 then
		return format("%d:%.2d", second/60, second%60)
	else
		return format("%ds", second)
	end
end

local lastCDSend = 0
function MISC:SendCurrentSpell(thisTime, spellID)
	local start, duration = GetSpellCooldown(spellID)
	local spellLink = GetSpellLink(spellID)
	if start and duration > 0 then
		local remain = start + duration - thisTime
		SendChatMessage(format(U["CooldownRemaining"], spellLink, GetRemainTime(remain)), MISC:GetMsgChannel())
	else
		SendChatMessage(format(U["CooldownCompleted"], spellLink), MISC:GetMsgChannel())
	end
end

function MISC:SendCurrentItem(thisTime, itemID, itemLink)
	local start, duration = GetItemCooldown(itemID)
	if start and duration > 0 then
		local remain = start + duration - thisTime
		SendChatMessage(format(U["CooldownRemaining"], itemLink, GetRemainTime(remain)), MISC:GetMsgChannel())
	else
		SendChatMessage(format(U["CooldownCompleted"], itemLink), MISC:GetMsgChannel())
	end
end

function MISC:AnalyzeButtonCooldown()
	if not self.action then return end -- no action for pet actionbar
	if not R.db["Misc"]["SendActionCD"] then return end
	if not IsInGroup() then return end

	local thisTime = GetTime()
	if thisTime - lastCDSend < 1.5 then return end
	lastCDSend = thisTime

	local spellType, id = GetActionInfo(self.action)
	if spellType == "spell" then
		MISC:SendCurrentSpell(thisTime, id)
	elseif spellType == "item" then
		local itemName, itemLink = GetItemInfo(id)
		MISC:SendCurrentItem(thisTime, id, itemLink or itemName)
	elseif spellType == "macro" then
		local spellID = GetMacroSpell(id)
		local _, itemLink = GetMacroItem(id)
		local itemID = itemLink and GetItemInfoFromHyperlink(itemLink)
		if spellID then
			MISC:SendCurrentSpell(thisTime, spellID)
		elseif itemID then
			MISC:SendCurrentItem(thisTime, itemID, itemLink)
		end
	end
end

function MISC:SendCDStatus()
	if not R.db["Actionbar"]["Enable"] then return end

	local Bar = M:GetModule("Actionbar")
	for _, button in pairs(Bar.buttons) do
		button:HookScript("OnMouseWheel", MISC.AnalyzeButtonCooldown)
	end
end

-- Init
function MISC:AddAlerts()
	MISC:SoloInfo()
	MISC:RareAlert()
	MISC:InterruptAlert()
	MISC:ExplosiveAlert()
	MISC:SpellItemAlert()
	MISC:NVision_Init()
	MISC:CheckIncompatible()
	MISC:SendCDStatus()
end
MISC:RegisterMisc("Notifications", MISC.AddAlerts)

--[[## Author: Nick Melancon  ## Version: 0.1
local JaniFailedBonusRoll = CreateFrame("FRAME");
JaniFailedBonusRoll:RegisterEvent("BONUS_ROLL_RESULT");
JaniFailedBonusRoll:SetScript("OnEvent", function(self, event, ...)
  if (self == "BONUS_ROLL_RESULT") then
    local rewardType = event;
    if rewardType == "currency" then
      PlaySoundFile("Sound\\Creature\\Jani\\VO_801_Jani_02_M.ogg", "Master")
    end
  end
end);]]