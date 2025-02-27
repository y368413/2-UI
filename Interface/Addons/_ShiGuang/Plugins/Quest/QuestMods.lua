--20周年
local answers = {
    ["111320"] = "狐人",
    ["46036"] = "幸运符",
    ["46185"] = "水果商人",
    ["46166"] = "埃德拉斯·布莱克摩尔",
    ["111330"] = "赦罪仪式",
    ["46202"] = "塔蕾莎·福克斯顿",
    ["46130"] = "希尔斯布莱德丘陵",
    ["111287"] = "凯诺兹多姆",
    ["111284"] = "黑石氏族",
    ["45687"] = "蒋",
    ["45699"] = "阿古斯的觉醒",
    ["42220"] = "莫德雷萨",
    ["46168"] = "耐奥祖",
    ["41536"] = "塔泰",
    ["42166"] = "维拉努斯",
    ["111290"] = "先知维伦",
    ["111314"] = "萨拉塔斯",
    ["111347"] = "泰拉纳斯塔兹",
    ["46146"] = "玛瑟里顿",
    ["46063"] = "鹰身人",
    ["111308"] = "阿坎多尔的果实",
    ["111278"] = "玛诺洛斯之血",
    ["46206"] = "奥伯丁",
    ["46139"] = "亚历山德罗斯",
    ["42098"] = "努波顿",
    ["111311"] = "麦格尼·铜须",
    ["42156"] = "米拉多尔",
    ["46094"] = "暴龙",
    ["111327"] = "统御头盔",
    ["46073"] = "艾萨拉",
    ["111355"] = "可汗",
    ["42176"] = "泰瑞纳斯·米奈希尔二世国王",
    ["42162"] = "诺甘农",
    ["41674"] = "大德鲁伊",
    ["46085"] = "玛维·影歌",
    ["111336"] = "裴拉戈斯",
    ["42099"] = "塔尼布隆、维斯匹隆和沙德隆",
    ["46134"] = "伯瓦尔·弗塔根",
    ["45695"] = "忠诚者",
    ["111342"] = "伊瑟拉",
    ["46069"] = "塔纳利斯",
    ["111351"] = "玛里苟斯",
    ["46101"] = "萨多尔大桥",
    ["46088"] = "本尼迪塔斯",
    ["41686"] = "行尸鱼人",
    ["46026"] = "奈法利安",
    ["46237"] = "泰拉纳斯塔兹",
    ["111302"] = "雄狮之眠",
    ["41683"] = "塞纳里奥议会",
    ["111300"] = "希利苏斯",
    ["46080"] = "血牙",
    ["42157"] = "德拉卡的狂怒",
    ["42025"] = "被污染的粮食",
    ["46004"] = "野猪人",
    ["42179"] = "萨维斯",
    ["42185"] = "卡雷什",
    ["42026"] = "阿彻鲁斯",
    ["111295"] = "阿古斯",
    ["42210"] = "霍利亚·萨希尔德",
    ["46019"] = "血精灵",
    ["46148"] = "管理者鹿盔",
    ["111323"] = "第四次战争",
    ["42169"] = "残次的雷象粪便",
    ["41544"] = "穆厄扎拉",
    ["111340"] = "潜行者",
    ["41706"] = "玛格汉兽人",
    ["46106"] = "贫瘠之地",
    ["46017"] = "煞魔",
    ["41532"] = "塔拉克",
    ["46031"] = "“真正的正义者将由命运择示！”",
    ["42184"] = "蒂芬·艾莉安·乌瑞恩",
    ["46212"] = "喷火",
    ["46214"] = "烈焰短笛",
    ["42192"] = "红色天灾",
    ["46192"] = "刘浪",
    ["46159"] = "风险投资公司",
    ["46219"] = "右眼，左臂",
    ["42214"] = "磨齿",
    ["41528"] = "基尔斯",
    ["41676"] = "格尔宾·梅卡托克",
    ["45705"] = "奥里登"
}
local AnswerYes = CreateFrame("Frame")
AnswerYes:RegisterEvent("GOSSIP_SHOW")
AnswerYes:RegisterEvent("QUEST_GREETING")
AnswerYes:SetScript("OnEvent", function()
if UnitGUID("target") then
    local unitID = tonumber(select(6, strsplit("-", UnitGUID("target"))), 10);
    if unitID == 110034 or unitID == 110035 then
        local info = C_GossipInfo.GetOptions()
        if info then
            for _, option in pairs(info) do
                if answers[tostring(option["gossipOptionID"])] then
                    C_GossipInfo.SelectOption(option["gossipOptionID"])
                end
            end
        end
    end
end
end)

--ObjectiveTrackerFrame.Header.Background:SetTexture(nil)
----------------------------------------------------------------------------------------
--[[	Auto collapse Objective Tracker
----------------------------------------------------------------------------------------
-- NOTE: SetCollapsed() cause UseQuestLogSpecialItem() taint
local QuestAutoCollapse = "RAID"
local headers = {
	ScenarioObjectiveTracker,
	BonusObjectiveTracker,
	UIWidgetObjectiveTracker,
	CampaignQuestObjectiveTracker,
	QuestObjectiveTracker,
	AdventureObjectiveTracker,
	AchievementObjectiveTracker,
	MonthlyActivitiesObjectiveTracker,
	ProfessionsRecipeTracker,
	WorldQuestObjectiveTracker,
}
if QuestAutoCollapse ~= "NONE" then
	local collapse = CreateFrame("Frame")
	--collapse:RegisterEvent("PLAYER_ENTERING_WORLD")
	collapse:RegisterEvent("PLAYER_REGEN_ENABLED")
	collapse:RegisterEvent("PLAYER_REGEN_DISABLED")
	collapse:SetScript("OnEvent", function()
		if QuestAutoCollapse == "RAID" then
			if IsInInstance() then
				C_Timer.After(0.1, function()
					--ObjectiveTrackerFrame:SetCollapsed(true)
					if QuestObjectiveTracker and QuestObjectiveTracker.ContentsFrame then
    if QuestObjectiveTracker.ContentsFrame:IsShown() and QuestObjectiveTracker.Header and QuestObjectiveTracker.Header.MinimizeButton then
        QuestObjectiveTracker.Header.MinimizeButton:Click()
        --print("任务列表")
    end
end
				end)
			elseif not InCombatLockdown() then
				if ObjectiveTrackerFrame.isCollapsed then
					--ObjectiveTrackerFrame:SetCollapsed(false)
						if QuestObjectiveTracker and QuestObjectiveTracker.ContentsFrame then
    if not QuestObjectiveTracker.ContentsFrame:IsShown() and QuestObjectiveTracker.Header and QuestObjectiveTracker.Header.MinimizeButton then
        QuestObjectiveTracker.Header.MinimizeButton:Click()
        print("已自动展开任务列表")
    end
end
				end
			end
		elseif QuestAutoCollapse == "SCENARIO" then
			local inInstance, instanceType = IsInInstance()
			if inInstance then
				if instanceType == "party" or instanceType == "scenario" then
					C_Timer.After(0.1, function() -- for some reason it got error after reload in instance
						--for i = 3, #headers do
							--headers[i]:SetCollapsed(true)
						--end
						if QuestObjectiveTracker and QuestObjectiveTracker.ContentsFrame then
    if QuestObjectiveTracker.ContentsFrame:IsShown() and QuestObjectiveTracker.Header and QuestObjectiveTracker.Header.MinimizeButton then
        QuestObjectiveTracker.Header.MinimizeButton:Click() --print("任务列表")
    end
end
					end)
				else
					--C_Timer.After(0.1, function()
						--ObjectiveTrackerFrame:SetCollapsed(true)
					--end)
					if QuestObjectiveTracker and QuestObjectiveTracker.ContentsFrame then
    if QuestObjectiveTracker.ContentsFrame:IsShown() and QuestObjectiveTracker.Header and QuestObjectiveTracker.Header.MinimizeButton then
        QuestObjectiveTracker.Header.MinimizeButton:Click() --print("任务列表")
    end
end
				end
			else
				if not InCombatLockdown() then
					for i = 3, #headers do
						--if headers[i].isCollapsed then
							--headers[i]:SetCollapsed(false)
						--end
						if QuestObjectiveTracker and QuestObjectiveTracker.ContentsFrame then
    if not QuestObjectiveTracker.ContentsFrame:IsShown() and QuestObjectiveTracker.Header and QuestObjectiveTracker.Header.MinimizeButton then
        QuestObjectiveTracker.Header.MinimizeButton:Click()
        print("已自动展开任务列表")
    end
end
					end
					if ObjectiveTrackerFrame.isCollapsed then
						--ObjectiveTrackerFrame:SetCollapsed(false)
						if QuestObjectiveTracker and QuestObjectiveTracker.ContentsFrame then
    if not QuestObjectiveTracker.ContentsFrame:IsShown() and QuestObjectiveTracker.Header and QuestObjectiveTracker.Header.MinimizeButton then
        QuestObjectiveTracker.Header.MinimizeButton:Click()
        print("已自动展开任务列表")
    end
end
					end
				end
			end
		elseif QuestAutoCollapse == "RELOAD" then
			C_Timer.After(0.1, function()
				--ObjectiveTrackerFrame:SetCollapsed(true)
				if QuestObjectiveTracker and QuestObjectiveTracker.ContentsFrame then
    if QuestObjectiveTracker.ContentsFrame:IsShown() and QuestObjectiveTracker.Header and QuestObjectiveTracker.Header.MinimizeButton then
        QuestObjectiveTracker.Header.MinimizeButton:Click() print("任务列表")
    end
end
			end)
		end
	end)
end]]
	
----------------------------------------------------------------------------------------
--	Ctrl+Click to abandon a quest or Alt+Click to share a quest(by Suicidal Katt)
----------------------------------------------------------------------------------------
hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self) 
	if IsControlKeyDown() then
		Menu.GetManager():HandleESC()
		QuestMapQuestOptions_AbandonQuest(self.questID)
	elseif IsAltKeyDown() and C_QuestLog.IsPushableQuest(self.questID) then
		Menu.GetManager():HandleESC()
		QuestMapQuestOptions_ShareQuest(self.questID)
	end
end)