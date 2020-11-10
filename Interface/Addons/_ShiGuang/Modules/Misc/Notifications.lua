local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local format, gsub, strsplit, strfind = string.format, string.gsub, string.split, string.find
local pairs, tonumber, wipe, select = pairs, tonumber, wipe, select
local GetInstanceInfo, PlaySound = GetInstanceInfo, PlaySound
local IsPartyLFG, IsInRaid, IsInGroup, IsInInstance, IsInGuild = IsPartyLFG, IsInRaid, IsInGroup, IsInInstance, IsInGuild
local UnitInRaid, UnitInParty, SendChatMessage = UnitInRaid, UnitInParty, SendChatMessage
local UnitName, Ambiguate, GetTime = UnitName, Ambiguate, GetTime
local GetSpellLink, GetSpellInfo, GetSpellCooldown = GetSpellLink, GetSpellInfo, GetSpellCooldown
local GetActionInfo, GetMacroSpell, GetMacroItem = GetActionInfo, GetMacroSpell, GetMacroItem
local GetItemInfo, GetItemInfoFromHyperlink = GetItemInfo, GetItemInfoFromHyperlink
local C_VignetteInfo_GetVignetteInfo = C_VignetteInfo.GetVignetteInfo
local C_Texture_GetAtlasInfo = C_Texture.GetAtlasInfo
local C_ChatInfo_SendAddonMessage = C_ChatInfo.SendAddonMessage
local C_ChatInfo_RegisterAddonMessagePrefix = C_ChatInfo.RegisterAddonMessagePrefix
local C_MythicPlus_GetCurrentAffixes = C_MythicPlus.GetCurrentAffixes

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

	if instType ~= "none" and diffID ~= 24 and instList[instID] and instList[instID] ~= diffID then
		MISC:SoloInfo_Create()
		soloInfo.Text:SetText(I.InfoColor..name..I.MyColor.."\n( "..diffName.." )\n\n"..I.InfoColor.."^-^")
	else
		if soloInfo then soloInfo:Hide() end
	end
end

function MISC:SoloInfo()
	if R.db["Misc"]["SoloInfo"] then
		self:SoloInfo_Update()
		M:RegisterEvent("UPDATE_INSTANCE_INFO", self.SoloInfo_Update)
		M:RegisterEvent("PLAYER_DIFFICULTY_CHANGED", self.SoloInfo_Update)
	else
		if soloInfo then soloInfo:Hide() end
		M:UnregisterEvent("UPDATE_INSTANCE_INFO", self.SoloInfo_Update)
		M:UnregisterEvent("PLAYER_DIFFICULTY_CHANGED", self.SoloInfo_Update)
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
		return strfind(atlas, "[Vv]ignette")
	end
end

function MISC:RareAlert_Update(id)
	if id and not cache[id] then
		local info = C_VignetteInfo_GetVignetteInfo(id)
		if not info or not isUsefulAtlas(info) then return end

		local atlasInfo = C_Texture_GetAtlasInfo(info.atlasName)
		if not atlasInfo then return end

		local file, width, height, txLeft, txRight, txTop, txBottom = atlasInfo.file, atlasInfo.width, atlasInfo.height, atlasInfo.leftTexCoord, atlasInfo.rightTexCoord, atlasInfo.topTexCoord, atlasInfo.bottomTexCoord
		if not file then return end

		local atlasWidth = width/(txRight-txLeft)
		local atlasHeight = height/(txBottom-txTop)
		local tex = format("|T%s:%d:%d:0:0:%d:%d:%d:%d:%d:%d|t", file, 0, 0, atlasWidth, atlasHeight, atlasWidth*txLeft, atlasWidth*txRight, atlasHeight*txTop, atlasHeight*txBottom)
		--UIErrorsFrame:AddMessage(I.InfoColor..U["Rare Found"]..tex..(info.name or ""))
		RaidNotice_AddMessage(RaidWarningFrame, "----------   "..tex..(info.name or "").."   ----------", ChatTypeInfo["RAID_WARNING"])
		if R.db["Misc"]["AlertinChat"] then
			local currrentTime = MaoRUIDB["TimestampFormat"] == 1 and "|cff00ff00["..date("%H:%M:%S").."]|r" or ""
			print(currrentTime.." -> "..I.InfoColor.." → "..tex..(info.name or ""))
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
	if R.db["Misc"]["RareAlerter"] then
		self:RareAlert_CheckInstance()
		M:RegisterEvent("UPDATE_INSTANCE_INFO", self.RareAlert_CheckInstance)
	else
		wipe(cache)
		M:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED", self.RareAlert_Update)
		M:UnregisterEvent("UPDATE_INSTANCE_INFO", self.RareAlert_CheckInstance)
	end
end

--[[
	闭上你的嘴！
	打断、偷取及驱散法术时的警报
]]
local function msgChannel()
	return IsPartyLFG() and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY"
end

local infoType = {
	["SPELL_INTERRUPT"] = U["Interrupt"],
	["SPELL_STOLEN"] = U["Steal"],
	["SPELL_DISPEL"] = U["Dispel"],
	["SPELL_AURA_BROKEN_SPELL"] = U["BrokenSpell"],
}

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
}

function MISC:IsAllyPet(sourceFlags)
	if I:IsMyPet(sourceFlags) or (not R.db["Misc"]["OwnInterrupt"] and (sourceFlags == I.PartyPetFlags or sourceFlags == I.RaidPetFlags)) then
		return true
	end
end

function MISC:InterruptAlert_Update(...)
	if R.db["Misc"]["AlertInInstance"] and (not IsInInstance() or IsPartyLFG()) then return end

	local _, eventType, _, sourceGUID, sourceName, sourceFlags, _, _, destName, _, _, spellID, _, _, extraskillID, _, _, auraType = ...
	if not sourceGUID or sourceName == destName then return end

	if UnitInRaid(sourceName) or UnitInParty(sourceName) or MISC:IsAllyPet(sourceFlags) then
		local infoText = infoType[eventType]
		if infoText then
			if infoText == U["BrokenSpell"] then
				if not R.db["Misc"]["BrokenSpell"] then return end
				if auraType and auraType == AURA_TYPE_BUFF or blackList[spellID] then return end
				if IsInInstance() then
					SendChatMessage(format(infoText, sourceName..GetSpellLink(extraskillID), destName..GetSpellLink(spellID)), "SAY")  --msgChannel()
				else
					SendChatMessage(format(infoText, sourceName..GetSpellLink(extraskillID), destName..GetSpellLink(spellID)), "PARTY")  --msgChannel()
				end
			else
				if R.db["Misc"]["OwnInterrupt"] and sourceName ~= I.MyName and not MISC:IsAllyPet(sourceFlags) then return end
				   if R.db["Misc"]["InterruptSound"] then
				      PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\ShutupFool.ogg", "Master")
				   end
				if IsInInstance() then
					SendChatMessage(infoText .. GetSpellLink(extraskillID), "SAY")  --msgChannel()
				else
					SendChatMessage(infoText .. GetSpellLink(extraskillID), "PARTY")  --msgChannel()
				end
			end
		end
	end
end

function MISC:InterruptAlert_CheckGroup()
	if IsInGroup() then
		M:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.InterruptAlert_Update)
	else
		M:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.InterruptAlert_Update)
	end
end

function MISC:InterruptAlert()
	if R.db["Misc"]["Interrupt"] then
		self:InterruptAlert_CheckGroup()
		M:RegisterEvent("GROUP_LEFT", self.InterruptAlert_CheckGroup)
		M:RegisterEvent("GROUP_JOINED", self.InterruptAlert_CheckGroup)
	else
		M:UnregisterEvent("GROUP_LEFT", self.InterruptAlert_CheckGroup)
		M:UnregisterEvent("GROUP_JOINED", self.InterruptAlert_CheckGroup)
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

local function startCount()
	wipe(R.db["Misc"]["ExplosiveCache"])
	M:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.Explosive_Update)
end

local function endCount()
	local text
	for name, count in pairs(R.db["Misc"]["ExplosiveCache"]) do
		text = (text or U["ExplosiveCount"])..name.."("..count..") "
	end
	--if text then SendChatMessage(text, "PARTY") end
	if text then print(text) end
	M:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.Explosive_Update)
end

local function pauseCount()
	local name, _, instID = GetInstanceInfo()
	if name and instID == 8 then
		M:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.Explosive_Update)
	else
		M:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", MISC.Explosive_Update)
	end
end

function MISC.Explosive_CheckAffixes(event)
	local affixes = C_MythicPlus_GetCurrentAffixes()
	if not affixes then return end

	if affixes[3] and affixes[3].id == 13 then
		M:RegisterEvent("CHALLENGE_MODE_START", startCount)
		M:RegisterEvent("CHALLENGE_MODE_COMPLETED", endCount)
		M:RegisterEvent("UPDATE_INSTANCE_INFO", pauseCount)
	end
	M:UnregisterEvent("PLAYER_ENTERING_WORLD", MISC.Explosive_CheckAffixes)
end

function MISC:ExplosiveAlert()
	if R.db["Misc"]["ExplosiveCount"] then
		self:Explosive_CheckAffixes()
		M:RegisterEvent("PLAYER_ENTERING_WORLD", self.Explosive_CheckAffixes)
	else
		M:UnregisterEvent("CHALLENGE_MODE_START", startCount)
		M:UnregisterEvent("CHALLENGE_MODE_COMPLETED", endCount)
		M:UnregisterEvent("UPDATE_INSTANCE_INFO", pauseCount)
		M:UnregisterEvent("PLAYER_ENTERING_WORLD", self.Explosive_CheckAffixes)
		M:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.Explosive_Update)
	end
end

--[[
	放大餐时叫一叫
]]
local lastTime = 0
local itemList = {
	[226241] = true,	-- 宁神圣典
	[256230] = true,	-- 静心圣典
	[185709] = true,	-- 焦糖鱼宴
	[259409] = true,	-- 海帆盛宴
	[259410] = true,	-- 船长盛宴
	[276972] = true,	-- 秘法药锅
	[286050] = true,	-- 鲜血大餐
	[265116] = true,	-- 工程战复
}

function MISC:ItemAlert_Update(unit, _, spellID)
	if not R.db["Misc"]["PlacedItemAlert"] then return end

	if (UnitInRaid(unit) or UnitInParty(unit)) and spellID and itemList[spellID] and lastTime ~= GetTime() then
		local who = UnitName(unit)
		local link = GetSpellLink(spellID)
		local name = GetSpellInfo(spellID)
		SendChatMessage(format(U["Place item"], who, link or name), msgChannel())

		lastTime = GetTime()
	end
end

function MISC:ItemAlert_CheckGroup()
	if IsInGroup() then
		M:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", MISC.ItemAlert_Update)
	else
		M:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED", MISC.ItemAlert_Update)
	end
end

function MISC:PlacedItemAlert()
	self:ItemAlert_CheckGroup()
	M:RegisterEvent("GROUP_LEFT", self.ItemAlert_CheckGroup)
	M:RegisterEvent("GROUP_JOINED", self.ItemAlert_CheckGroup)
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
	["Aurora"] = true,
	["AuroraClassic"] = true,
	["BigFoot"] = true,
	["NDui"] = true,
	["!!!163UI!!!"] = true,
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
		disable.text:SetTextColor(1, 0, 0)
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
local lastCDSend = 0
function MISC:SendCurrentSpell(thisTime, spellID)
	local start, duration = GetSpellCooldown(spellID)
	local spellLink = GetSpellLink(spellID)
	if start and duration > 0 then
		local remain = start + duration - thisTime
		SendChatMessage(format(U["CooldownRemaining"], spellLink, remain), msgChannel())
	else
		SendChatMessage(format(U["CooldownCompleted"], spellLink), msgChannel())
	end
end

function MISC:SendCurrentItem(thisTime, itemID, itemLink)
	local start, duration = GetItemCooldown(itemID)
	if start and duration > 0 then
		local remain = start + duration - thisTime
		SendChatMessage(format(U["CooldownRemaining"], itemLink, remain), msgChannel())
	else
		SendChatMessage(format(U["CooldownCompleted"], itemLink), msgChannel())
	end
end

function MISC:AnalyzeButtonCooldown()
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
	MISC:PlacedItemAlert()
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