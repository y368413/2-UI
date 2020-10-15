local ADDON, Addon = ...
local Mod = Addon:NewModule('ProgressTracker')
Mod.playerDeaths = {}

local lastQuantity
local lastDied
local lastDiedName
local lastDiedTime
local lastAmount
local lastAmountTime
local lastQuantity

local PRIDEFUL_AFFIX_ID = 121

local progressPresets = {
	-- 通灵战潮
	[166264] = 1, -- 备用部件
	[166266] = 1, -- 备用部件
	[165138] = 1, -- 凋零之袋
	[163623] = 3, -- 烂吐残渣
	[163622] = 3, -- 碎淤残块
	[162729] = 4, -- 帕奇维克士兵
	[165597] = 4, -- 帕奇维克士兵
	[163128] = 4, -- 佐尔拉姆斯巫师
	[163619] = 4, -- 佐尔拉姆斯刻骨者
	[165222] = 4, -- 佐尔拉姆斯愈骨者
	[166302] = 4, -- 尸体收割者
	[163121] = 5, -- 缝合先锋
	[173016] = 5, -- 尸体采集者
	[165872] = 5, -- 血肉工匠
	[165911] = 5, -- 忠诚的造物
	[165137] = 6, -- 佐尔拉姆斯守门人
	[165919] = 6, -- 骷髅劫掠者
	[163618] = 8, -- 佐尔拉姆斯通灵师
	[173044] = 8, -- 缝合助理
	[167731] = 8, -- 分离助理
	[172981] = 8, -- 格里恩缝合憎恶
	[163620] = 8, -- 烂吐
	[163621] = 8, -- 碎淤
	[165824] = 10, -- 纳祖达
	[165197] = 10, -- 骸骨巨怪
	-- 晋升高塔
	[166411] = 1, -- 弃誓篡位者
	[163503] = 2, -- 以太俯冲者
	[163457] = 4, -- 弃誓先锋
	[163459] = 4, -- 弃誓治愈者
	[163458] = 4, -- 弃誓谴罚者
	[163506] = 4, -- 弃誓潜爪狮
	[163501] = 4, -- 弃誓散兵
	[168420] = 4, -- 弃誓勇士
	[168418] = 4, -- 弃誓审判官
	[168718] = 4, -- 弃誓看守人
	[168717] = 4, -- 弃誓裁决者
	[163524] = 5, -- 格里恩黑暗裁定者
	[163520] = 6, -- 弃誓小队长
	[168681] = 6, -- 弃誓恶火
	[168318] = 8, -- 弃誓哥利亚
	[168425] = 8, -- 弃誓歼灭者
	[168658] = 8, -- 弃誓毁灭者
	[168843] = 12, -- 克罗托斯
	[168844] = 12, -- 拉科西斯
	[168845] = 12, -- 阿斯托诺斯
	-- 伤逝剧场
	[163089] = 1, -- 恶心的残躯
	[169875] = 2, -- 桎梏之魂
	[170838] = 4, -- 不屈的参赛者
	[174197] = 4, -- 战场祭师
	[164510] = 4, -- 蹒跚的弩手
	[167994] = 4, -- 骨化的援兵
	[170690] = 4, -- 染病恐魔
	[174210] = 4, -- 凋零淤泥喷射者
	[160495] = 4, -- 狂热的缚魂者
	[170882] = 4, -- 白骨魔导师
	[164506] = 5, -- 上古队长
	[169927] = 5, -- 腥臭屠夫
	[169893] = 6, -- 卑劣的暗语者
	[170850] = 7, -- 狂怒的血角
	[163086] = 8, -- 腐臭的气囊怪
	[167998] = 8, -- 传送门守卫
	[162763] = 8, -- 魂铸白骨编织者
	[167538] = 20, -- 残暴者多基格
	[167536] = 20, -- 嗜血的哈鲁吉亚
	[167534] = 20, -- 老练的里克
	-- 彼界
	[170486] = 1, -- 阿塔莱虔信者
	[170488] = 1, -- 哈卡之子
	[171341] = 1, -- 刃喙雏鹤
	[168986] = 3, -- 骷髅迅猛龙
	[171342] = 3, -- 幼年符文牡鹿
	[164857] = 3, -- 林鬼折愈者
	[164861] = 3, -- 林鬼缚皮者
	[168949] = 4, -- 复生的骷髅战士
	[168992] = 4, -- 复生的祭师
	[164862] = 4, -- 仙野烁光蛾
	[171181] = 4, -- 领地刃喙鹤
	[170490] = 5, -- 阿塔莱高阶祭司
	[170480] = 5, -- 阿塔莱死亡行者
	[167963] = 5, -- 无头的终端机
	[167965] = 5, -- 润滑器
	[164873] = 5, -- 大角符文牡鹿
	[169905] = 6, -- 复生的督军
	[168942] = 6, -- 亡语者
	[170572] = 6, -- 阿塔莱灾厄妖术师
	[171343] = 6, -- 刃喙鹤母
	[168934] = 7, -- 激怒之灵
	[167962] = 8, -- 失灵的牙钻
	[167964] = 8, -- 4.RF-4.RF
	[171184] = 12, -- 密斯雷什，苍穹之爪
	-- 赎罪大厅
	[167610] = 1, -- 石魔噬踝者
	[165415] = 2, -- 劳苦的管理员
	[165515] = 4, -- 堕落的黑暗剑士
	[164563] = 4, -- 邪恶的加尔贡
	[164562] = 4, -- 堕落的驯犬者
	[165414] = 4, -- 堕落的歼灭者
	[174175] = 4, -- 忠诚的石裔魔
	[165529] = 4, -- 堕落的搜集者
	[167611] = 4, -- 石裔剔骨者
	[167612] = 6, -- 石裔掠夺者
	[167607] = 7, -- 石裔切割者
	[164557] = 10, -- 哈尔吉亚斯的碎片
	[167876] = 20, -- 审判官西加尔
	-- 赤红深渊
	[168058] = 1, -- 注能的羽翎
	[168457] = 1, -- 石墙加尔贡
	[171455] = 1, -- 石墙加尔贡
	[162056] = 1, -- 缚石岩精
	[167955] = 1, -- 赤红学员
	[162046] = 1, -- 饥饿的虱子
	[169753] = 1, -- 饥饿的虱子
	[167956] = 1, -- 黑暗助祭
	[162051] = 2, -- 疯狂的食尸鬼
	[162041] = 2, -- 肮脏的嚼土者
	[171448] = 4, -- 恐怖的狩猎大师
	[172265] = 4, -- 愤怒残余
	[162049] = 4, -- 疑虑残迹
	[171384] = 4, -- 研究铭文师
	[171805] = 4, -- 研究铭文师
	[165076] = 4, -- 贪食的虱子
	[166396] = 4, -- 贵族散兵
	[162039] = 4, -- 邪恶的镇压者
	[168591] = 4, -- 贪婪的恐惧蝠
	[162057] = 7, -- 大厅哨兵
	[162040] = 7, -- 大监督者
	[171799] = 7, -- 深渊狱卒
	[162038] = 7, -- 皇家舞雾者
	[164852] = 7, -- 皇家舞雾者
	[162047] = 7, -- 贪食的蛮兵
	[171376] = 10, -- 首席管理者加弗林
	-- 凋魂之殇
	[168969] = 1, -- 喷薄软泥
	[163857] = 4, -- 凋缚狂热者
	[163892] = 6, -- 腐烂的黏液之爪
	[164705] = 6, -- 传染软泥
	[163891] = 6, -- 腐髓软泥
	[164707] = 6, -- 凝结软泥
	[169696] = 8, -- 泽地士兵
	[168580] = 8, -- 钻凋者
	[168361] = 8, -- 碱沼大黄蜂
	[168578] = 8, -- 菌菇术士
	[168572] = 8, -- 真菌猛攻者
	[168574] = 8, -- 致命的收割者
	[168891] = 8, -- 被操纵的钻凋者
	[168627] = 8, -- 魔药束缚者
	[167493] = 8, -- 喷毒狙击手
	[174802] = 8, -- 喷毒狙击手
	[163862] = 8, -- 万眼防御者
	[163915] = 10, -- 幼蜂之巢
	[168022] = 10, -- 软泥触须
	[168310] = 12, -- 凋零大鹏
	[168153] = 12, -- 凋零大鹏
	[168393] = 12, -- 魔药喷吐者
	[168396] = 12, -- 魔药喷吐者
	[173360] = 12, -- 魔药喷吐者
	[163894] = 12, -- 凋零碎脊者
	[164737] = 12, -- 巢群伏击者
	[163882] = 14, -- 腐烂的血肉巨人
	[168886] = 25, -- 维鲁拉克斯魔药编织者
	[169861] = 25, -- 艾柯尔·胆肉
	-- 塞兹仙林的迷雾
	[167117] = 1, -- 锥喉幼虫
	[165111] = 2, -- 德鲁斯特恶爪者
	[164920] = 4, -- 德鲁斯特斩魂者
	[172991] = 4, -- 德鲁斯特斩魂者
	[164921] = 4, -- 德鲁斯特收割者
	[163058] = 4, -- 纱雾防御者
	[171772] = 4, -- 纱雾防御者
	[166299] = 4, -- 纱雾照看者
	[166301] = 4, -- 纱雾追猎者
	[166275] = 4, -- 纱雾塑形者
	[166304] = 4, -- 纱雾钉刺蛾
	[166276] = 4, -- 纱雾守护者
	[167113] = 4, -- 锥喉酸咽者
	[172312] = 4, -- 锥喉饕餮者
	[167116] = 4, -- 锥喉掠夺者
	[167111] = 5, -- 锥喉鹿角巨虫
	[164926] = 6, -- 德鲁斯特碎枝者
	[164929] = 7, -- 仙木林居民(血量仅计算80%)
	[173720] = 16, -- 纱雾噬喉者
	[173714] = 16, -- 纱雾夜花
--	[] = 16, -- 纱雾龙母
}

local function ProcessLasts()
	if lastDied and lastDiedTime and lastAmount and lastAmountTime then
		if abs(lastAmountTime - lastDiedTime) < 0.1 then
			if not AngryKeystones_Data.progress[lastDied] then AngryKeystones_Data.progress[lastDied] = {} end
			if AngryKeystones_Data.progress[lastDied][lastAmount] then
				AngryKeystones_Data.progress[lastDied][lastAmount] = AngryKeystones_Data.progress[lastDied][lastAmount] + 1
			else
				AngryKeystones_Data.progress[lastDied][lastAmount] = 1
			end
			lastDied, lastDiedTime, lastAmount, lastAmountTime, lastDiedName = nil, nil, nil, nil, nil
		end
	end
end

function Mod:COMBAT_LOG_EVENT_UNFILTERED()
	local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10 = CombatLogGetCurrentEventInfo()
	if event == "UNIT_DIED" then
		if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) > 0
				and bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_NPC) > 0
				and (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 or bit.band(destFlags, COMBATLOG_OBJECT_REACTION_NEUTRAL) > 0) then
			local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", destGUID)
			lastDied = tonumber(npc_id)
			lastDiedTime = GetTime()
			lastDiedName = destName
			ProcessLasts()
		end
		if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
			if UnitIsFeignDeath(destName) then
				-- Feign Death
			elseif Mod.playerDeaths[destName] then
				Mod.playerDeaths[destName] = Mod.playerDeaths[destName] + 1
			else
				Mod.playerDeaths[destName] = 1
			end
			--Addon.ObjectiveTracker:UpdatePlayerDeaths()
		end
	end
end

function Mod:SCENARIO_CRITERIA_UPDATE()
	local scenarioType = select(10, C_Scenario.GetInfo())
	if scenarioType == LE_SCENARIO_TYPE_CHALLENGE_MODE then
		local numCriteria = select(3, C_Scenario.GetStepInfo())
		for criteriaIndex = 1, numCriteria do
			local criteriaString, criteriaType, _, quantity, totalQuantity, _, _, quantityString, _, _, _, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(criteriaIndex)
			if isWeightedProgress then
				local currentQuantity = quantityString and tonumber( strsub(quantityString, 1, -2) )
				if lastQuantity and currentQuantity < totalQuantity and currentQuantity > lastQuantity then
					lastAmount = currentQuantity - lastQuantity
					lastAmountTime = GetTime()
					ProcessLasts()
				end
				lastQuantity = currentQuantity
			end
		end
	end
end

local function StartTime()
	Mod:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	local numCriteria = select(3, C_Scenario.GetStepInfo())
	for criteriaIndex = 1, numCriteria do
		local criteriaString, criteriaType, _, quantity, totalQuantity, _, _, quantityString, _, _, _, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(criteriaIndex)
		if isWeightedProgress then
			local quantityString = select(8, C_Scenario.GetCriteriaInfo(criteriaIndex))
			lastQuantity = quantityString and tonumber( strsub(quantityString, 1, -2) )
		end
	end
end

local function StopTime()
	Mod:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

local function CheckTime(...)
	for i = 1, select("#", ...) do
		local timerID = select(i, ...)
		local _, elapsedTime, type = GetWorldElapsedTime(timerID)
		if type == LE_WORLD_ELAPSED_TIMER_TYPE_CHALLENGE_MODE then
			local mapID = C_ChallengeMode.GetActiveChallengeMapID()
			if mapID then
				StartTime()
				return
			end
		end
	end
	StopTime()
end

local function OnTooltipSetUnit(tooltip)
	local scenarioType = select(10, C_Scenario.GetInfo())
	if scenarioType == LE_SCENARIO_TYPE_CHALLENGE_MODE and Addon.Config.progressTooltip then
		local name, unit = tooltip:GetUnit()
		local guid = unit and UnitGUID(unit)
		if guid then
			local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", guid)
			npc_id = tonumber(npc_id)
			local info = AngryKeystones_Data.progress[npc_id]
			local preset = progressPresets[npc_id]
			if info or preset then
				local numCriteria = select(3, C_Scenario.GetStepInfo())
				local total
				local progressName
				for criteriaIndex = 1, numCriteria do
					local criteriaString, _, _, quantity, totalQuantity, _, _, quantityString, _, _, _, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(criteriaIndex)
					if isWeightedProgress then
						progressName = criteriaString
						total = totalQuantity
					end
				end

				local value, valueCount
				if info then
					for amount, count in pairs(info) do
						if not valueCount or count > valueCount or (count == valueCount and amount < value) then
							value = amount
							valueCount = count
						end
					end
				end
				if preset and (not value or valueCount == 1) then
					value = preset
				end
				if value and total then
					local forcesFormat = format(" - %s: %%s", progressName)
					local text
					if Addon.Config.progressFormat == 1 or Addon.Config.progressFormat == 4 then
						text = format( format(forcesFormat, "+%.2f%%"), value/total*100)
					elseif Addon.Config.progressFormat == 2 or Addon.Config.progressFormat == 5 then
						text = format( format(forcesFormat, "+%d"), value)
					elseif Addon.Config.progressFormat == 3 or Addon.Config.progressFormat == 6 then
						text = format( format(forcesFormat, "+%.2f%% - +%d"), value/total*100, value)
					end

					if text then
						local matcher = format(forcesFormat, "%d+%%")
						for i=2, tooltip:NumLines() do
							local tiptext = _G["GameTooltipTextLeft"..i]
							local linetext = tiptext and tiptext:GetText()

							if linetext and linetext:match(matcher) then
								tiptext:SetText(text)
								tooltip:Show()
							end
						end
					end
				end
			end
		end
	end
end

function Mod:GeneratePreset()
	local ret = {}
	for npcID, info in pairs(AngryKeystones_Data.progress) do
		local value, valueCount
		for amount, count in pairs(info) do
			if not valueCount or count > valueCount or (count == valueCount and amount < value) then
				value = amount
				valueCount = count
			end
		end
		ret[npcID] = value
	end
	AngryKeystones_Data.preset = ret
	return ret
end

function Mod:PLAYER_ENTERING_WORLD(...) CheckTime(GetWorldElapsedTimers()) end
function Mod:WORLD_STATE_TIMER_START(...) local timerID = ...; CheckTime(timerID) end
function Mod:WORLD_STATE_TIMER_STOP(...) local timerID = ...; StopTime(timerID) end
function Mod:CHALLENGE_MODE_START(...) CheckTime(GetWorldElapsedTimers()) end
function Mod:CHALLENGE_MODE_RESET(...) wipe(Mod.playerDeaths) end

local function ProgressBar_SetValue(self, percent)
	if self.criteriaIndex then
		local _, _, _, _, totalQuantity, _, _, quantityString, _, _, _, _, _ = C_Scenario.GetCriteriaInfo(self.criteriaIndex)
		local currentQuantity = quantityString and tonumber( strsub(quantityString, 1, -2) )
		if currentQuantity and totalQuantity then
			if Addon.Config.progressFormat == 1 then
				self.Bar.Label:SetFormattedText("%.2f%%", currentQuantity/totalQuantity*100)
			elseif Addon.Config.progressFormat == 2 then
				self.Bar.Label:SetFormattedText("%d/%d", currentQuantity, totalQuantity)
			elseif Addon.Config.progressFormat == 3 then
				self.Bar.Label:SetFormattedText("%.2f%% - %d/%d", currentQuantity/totalQuantity*100, currentQuantity, totalQuantity)
			elseif Addon.Config.progressFormat == 4 then
				self.Bar.Label:SetFormattedText("%.2f%% (%.2f%%)", currentQuantity/totalQuantity*100, (totalQuantity-currentQuantity)/totalQuantity*100)
			elseif Addon.Config.progressFormat == 5 then
				self.Bar.Label:SetFormattedText("%d/%d (%d)", currentQuantity, totalQuantity, totalQuantity - currentQuantity)
			elseif Addon.Config.progressFormat == 6 then
				self.Bar.Label:SetFormattedText("%.2f%% (%.2f%%) - %d/%d (%d)", currentQuantity/totalQuantity*100, (totalQuantity-currentQuantity)/totalQuantity*100, currentQuantity, totalQuantity, totalQuantity - currentQuantity)
			end
		end

		local isPridefulActive = false
		local _, affixes = C_ChallengeMode.GetActiveKeystoneInfo()
		if affixes then
			for i = 1, #affixes do
				if affixes[i] == PRIDEFUL_AFFIX_ID then
					isPridefulActive = true
				end
			end
		end

		if isPridefulActive and currentQuantity < totalQuantity then
			if not self.ReapingFrame then
				local reapingFrame = CreateFrame("Frame", nil, self)
				reapingFrame:SetSize(56, 16)
				reapingFrame:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, 0)
		
				reapingFrame.Icon = CreateFrame("Frame", nil, reapingFrame, "ScenarioChallengeModeAffixTemplate")
				reapingFrame.Icon:SetPoint("LEFT", reapingFrame, "LEFT", 0, 0)
				reapingFrame.Icon:SetSize(14, 14)
				reapingFrame.Icon.Portrait:SetSize(12, 12)
				reapingFrame.Icon:SetUp(PRIDEFUL_AFFIX_ID)

				reapingFrame.Text = reapingFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				reapingFrame.Text:SetPoint("LEFT", reapingFrame.Icon, "RIGHT", 4, 0)

				self.ReapingFrame = reapingFrame

				self:HookScript("OnShow", function(self) self.ReapingFrame:Show(); self.ReapingFrame.Icon:Show() end )
				self:HookScript("OnHide", function(self) self.ReapingFrame:Hide(); self.ReapingFrame.Icon:Hide() end )
			end
			local threshold = totalQuantity / 5
			local current = currentQuantity
			local value = threshold - current % threshold
			local total = totalQuantity
			if Addon.Config.progressFormat == 1 or Addon.Config.progressFormat == 4 then
				self.ReapingFrame.Text:SetFormattedText("%.2f%%", value/total*100)
			elseif Addon.Config.progressFormat == 2 or Addon.Config.progressFormat == 5 then
				self.ReapingFrame.Text:SetFormattedText("%d", ceil(value))
			elseif Addon.Config.progressFormat == 3 or Addon.Config.progressFormat == 6 then
				self.ReapingFrame.Text:SetFormattedText("%.2f%% - %d", value/total*100, ceil(value))
			else
				self.ReapingFrame.Text:SetFormattedText("%d%%", value/total*100)
			end
			self.ReapingFrame:Show()
			self.ReapingFrame.Icon:Show()
		elseif self.ReapingFrame then
			self.ReapingFrame:Hide()
			self.ReapingFrame.Icon:Hide()
		end
	end
end

local function DeathCount_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:SetText(CHALLENGE_MODE_DEATH_COUNT_TITLE:format(self.count), 1, 1, 1)
	GameTooltip:AddLine(CHALLENGE_MODE_DEATH_COUNT_DESCRIPTION:format(SecondsToClock(self.timeLost, false)))

	GameTooltip:AddLine(" ")
	local list = {}
	local deathsCount = 0
	for unit,count in pairs(Mod.playerDeaths) do
		local _, class = UnitClass(unit)
		deathsCount = deathsCount + count
		table.insert(list, { count = count, unit = unit, class = class })
	end
	table.sort(list, function(a, b)
		if a.count ~= b.count then
			return a.count > b.count
		else
			return a.unit < b.unit
		end
	end)

	for _,item in ipairs(list) do
		local color = RAID_CLASS_COLORS[item.class] or HIGHLIGHT_FONT_COLOR
		GameTooltip:AddDoubleLine(item.unit, item.count, color.r, color.g, color.b, HIGHLIGHT_FONT_COLOR:GetRGB())
	end
	GameTooltip:Show()
end

function Mod:Blizzard_ObjectiveTracker()
	ScenarioChallengeModeBlock.DeathCount:SetScript("OnEnter", DeathCount_OnEnter)
end

function Mod:Startup()
	if not AngryKeystones_Data then
		AngryKeystones_Data = {}
	end
	if not AngryKeystones_Data.progress then
		AngryKeystones_Data = { progress = AngryKeystones_Data }
	end
	if not AngryKeystones_Data.state then AngryKeystones_Data.state = {} end
	local mapID = C_ChallengeMode.GetActiveChallengeMapID()
	if select(10, C_Scenario.GetInfo()) == LE_SCENARIO_TYPE_CHALLENGE_MODE and mapID and mapID == AngryKeystones_Data.state.mapID and AngryKeystones_Data.state.playerDeaths then
		Mod.playerDeaths = AngryKeystones_Data.state.playerDeaths
	else
		AngryKeystones_Data.state.mapID = nil
		AngryKeystones_Data.state.playerDeaths = Mod.playerDeaths
	end

	self:RegisterEvent("SCENARIO_CRITERIA_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("WORLD_STATE_TIMER_START")
	self:RegisterEvent("WORLD_STATE_TIMER_STOP")
	self:RegisterEvent("CHALLENGE_MODE_START")
	self:RegisterEvent("CHALLENGE_MODE_RESET")
	self:RegisterAddOnLoaded("Blizzard_ObjectiveTracker")
	CheckTime(GetWorldElapsedTimers())
	GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)

	Addon.Config:RegisterCallback('progressFormat', function()
		local usedBars = SCENARIO_TRACKER_MODULE.usedProgressBars[ScenarioObjectiveBlock] or {}
		for _, bar in pairs(usedBars) do
			ProgressBar_SetValue(bar)
		end
	end)
end

hooksecurefunc("ScenarioTrackerProgressBar_SetValue", ProgressBar_SetValue)
