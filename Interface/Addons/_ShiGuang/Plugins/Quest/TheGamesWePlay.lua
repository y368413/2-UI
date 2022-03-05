--## Version: 1.0.0 ## Author: Kuletco
local TheGamesWePlay = {}
local QuestHelper = TheGamesWePlay.QuestHelper or CreateFrame('Frame', "QuestHelperMainFrame", QuestHelper)
TheGamesWePlay.QuestHelper = QuestHelper

local QUEST_HELPER_UPDATE_TIMER = 1
QuestHelper.Timer = QUEST_HELPER_UPDATE_TIMER
QuestHelper.StopOnUpdate = false

QuestHelper.UpdateHandlers = {}
QuestHelper.EventHandlers = {}
QuestHelper.QuestHandlers = {}
QuestHelper.QuestButtons = {}
QuestHelper.QuestButtonUpdateHandlers = {}

QuestHelper.CurrentQuest = nil

DebugMode = false
local _DBG = function(...)
    if DebugMode then
        print(...)
    end
end
QuestHelper._DBG = _DBG
_DBG("QuestHelper:", QuestHelper)

-- Class Fuctions
QuestHelper.TabLength = function(tab)
    if type(tab) == "table" then
        local length = 0
        for _,_ in pairs(tab) do
            length = length + 1
        end
        return length
    end
end

QuestHelper.GetNumQuests = function()
    local numQuests = 0
    local numEntries = C_QuestLog.GetNumQuestLogEntries()
    for i = 1, numEntries do
        local info = C_QuestLog.GetInfo(i)
        if not info.isHidden and not info.isHeader then
            numQuests = numQuests + 1
        end
    end
    return numQuests
end

QuestHelper.IsExistQuest = function(questID)
    if not questID then return end
    local numEntries = C_QuestLog.GetNumQuestLogEntries()
    for i = 1, numEntries do
        local info = C_QuestLog.GetInfo(i)
        if not info.isHeader and info.questID == tonumber(questID) then
            return true
        end
    end
end

QuestHelper.RemoveObjectFromTable = function(container, questID, callback)
    if not questID then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    local object = container[questID]
    if callback and type(callback) == "function" then
        callback(object)
    end
    if object then
        local index = 1
        for k,_ in pairs(container) do
            if k == questID then
                table.remove(container, index)
                return
            end
            index = index + 1
        end
    end
end

QuestHelper.DetermineCurrentQuest = function(self, SpellID, NPCName, MSG)
    -- _DBG("DetermineCurrentQuest -", "SpellID:", NPCName, "NPCName:", NPCName, "MSG:", MSG)
    if SpellID then
        for questID, handler in pairs(self.QuestHandlers) do
            if handler.SpellID == SpellID then
                return questID
            end
        end
    elseif NPCName then
        for questID, handler in pairs(self.QuestHandlers) do
            if handler.NPCName == NPCName then
                return questID
            end
        end
    elseif MSG then
        for questID, handler in pairs(self.QuestHandlers) do
            if type(handler.Begin) == "string" and handler.Begin == MSG then
                return questID
            elseif type(handler.Begin) == "table" then
                for _, str in pairs(handler.Begin) do
                    if str == MSG then
                        return questID
                    end
                end
            elseif handler.Actions then
                for _,v in pairs(handler.Actions) do
                    if v.text == MSG then
                        return questID
                    end
                end
            end
        end
    end
end

-- UpdateHandler: function(self, questID) end
function QuestHelper:RegisterUpdateHandler(questID, handler)
    _DBG("RegisterUpdateHandler -", "QuestID", questID, "Handler:", handler)
    if not questID or not handler then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    if type(handler) == "function" then
        self.UpdateHandlers[questID] = handler
    end
end

function QuestHelper:UnRegisterUpdateHandler(questID)
    _DBG("UnRegisterUpdateHandler -", "QuestID", questID)
    if not questID then return end
    self.RemoveObjectFromTable(self.UpdateHandlers, questID)
end

function QuestHelper:GetUpdateHandler(questID)
    _DBG("GetUpdateHandler -", "QuestID", questID)
    if not questID then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    return self.UpdateHandlers[questID]
end

-- EventHandler: function(self, event, ...) end
function QuestHelper:RegisterEventHandler(questID, handler)
    _DBG("RegisterEventHandler -", "QuestID", questID, "Handler:", handler)
    if not questID or not handler then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    if type(handler) == "function" then
        self.EventHandlers[questID] = handler
    end
end

function QuestHelper:UnRegisterEventHandler(questID)
    _DBG("UnRegisterEventHandler -", "QuestID", questID)
    if not questID then return end
    self.RemoveObjectFromTable(self.EventHandlers, questID)
end

function QuestHelper:GetEventHandler(questID)
    _DBG("GetEventHandler -", "QuestID", questID)
    if not questID then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    return self.EventHandlers[questID]
end

-- QuestHandler ( need by DetermineCurrentQuest() ): table {}
-- { SpellID = number, Distance = number, OnContinent = true|false, NPCName = string, Actions = { { text = string, action = string, }, ... }, Begin = string|{strings} }
function QuestHelper:RegisterQuestHandler(questID, handler, force)
    _DBG("RegisterQuestHandler -", "QuestID", questID, "Handler:", handler)
    if not questID or not handler then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    if not self.QuestHandlers[questID] or force then
        self.QuestHandlers[questID] = handler
    end
end

function QuestHelper:UnRegisterQuestHandler(questID)
    _DBG("UnRegisterQuestHandler -", "QuestID", questID)
    if not questID then return end
    self.RemoveObjectFromTable(self.QuestHandlers, questID)
end

function QuestHelper:GetQuestHandler(questID)
    _DBG("GetQuestHandler -", "QuestID", questID)
    if not questID then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    return self.QuestHandlers[questID]
end

-- QuestButton
function QuestHelper:RegisterQuestButton(questID)
    _DBG("RegisterQuestButton -", "QuestID", questID)
    if not questID then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    local name = "QuestButton_"..questID
    local button = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
    button:SetSize(52, 52)
    button:SetScale(0.85)
    button:SetPoint("CENTER", 0, -200)

    button.icon = button:CreateTexture(name.."Icon", "BACKGROUND")
    button.icon:SetPoint("TOPLEFT", 0, -1)
    button.icon:SetPoint("BOTTOMRIGHT", 0, -1)
    
    button.Style = button:CreateTexture(name.."Style", "OVERLAY")
    button.Style:SetSize(256, 128)
    button.Style:SetPoint("CENTER", -2, 0)
    button.Style:SetTexture("Interface\\ExtraButton\\ChampionLight")

    -- button.text = button:CreateFontString(name.."Text", "ARTWORK", "SystemFont_Med1")
    button.text = button:CreateFontString(name.."Text", "ARTWORK", "SystemFont_Shadow_Med1")
    button.text:SetSize(50, 16)
    button.text:SetJustifyH("CENTER")
    button.text:SetPoint("CENTER", button.icon, 0, 0)

    button:RegisterForClicks("AnyUp")

    button:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
    do local tex = button:GetPushedTexture()
        tex:SetPoint("TOPLEFT", 0, -1)
        tex:SetPoint("BOTTOMRIGHT", 0, -1)
    end
    button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    do local tex = button:GetHighlightTexture()
        tex:SetPoint("TOPLEFT", 0, -1)
        tex:SetPoint("BOTTOMRIGHT", 0, -1)
    end

    button.questID = tonumber(questID)
    button.handler = self:GetQuestHandler(questID)
    button:Hide()

    self.QuestButtons[questID] = button

    return button
end

function QuestHelper:UnRegisterQuestButton(questID)
    _DBG("UnRegisterQuestButton -", "QuestID", questID)
    if not questID then return end
    self.RemoveObjectFromTable(self.QuestButtons, questID, function(button)
        if (button) then
            button:Hide()
        end
    end)
end

function QuestHelper:GetQuestButton(questID)
    _DBG("GetQuestButton -", "QuestID", questID)
    if not questID then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    return self.QuestButtons[questID]
end

-- QuestButtonUpdateHandler: function(self, questID) end
function QuestHelper:RegisterQuestButtonUpdateHandler(questID, handler)
    _DBG("RegisterQuestButtonUpdateHandler -", "QuestID", questID, "Handler:", type(handler), handler)
    if not questID or not handler then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    if type(handler) == "function" then
        self.QuestButtonUpdateHandlers[questID] = handler
    end
end

function QuestHelper:UnRegisterQuestButtonUpdateHandler(questID)
    _DBG("UnRegisterQuestButtonUpdateHandler -", "QuestID", questID)
    if not questID then return end
    self.RemoveObjectFromTable(self.QuestButtonUpdateHandlers, questID, function(button)
        if (button) then
            button:Hide()
        end
    end)
end

function QuestHelper:GetQuestButtonUpdateHandler(questID)
    _DBG("GetQuestButtonUpdateHandler -", "QuestID", questID)
    if not questID then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    return self.QuestButtonUpdateHandlers[questID]
end


function QuestHelper:UpdateQuestButton(questID, ...)
    _DBG("UpdateQuestButton -", "QuestID", questID)
    if not questID then return end
    if type(questID) ~= "string" then questID = tostring(questID) end

    if C_QuestLog.IsComplete(tonumber(questID)) then
        self:UnRegisterQuestHandler(questID)
        self:UnRegisterQuestButton(questID)
    else
        local handler = self:GetQuestButtonUpdateHandler(questID)
        if handler and type(handler) == "function" then
            handler(self, questID)
        end
    end
end

function QuestHelper:Update()
    for questID, handler in pairs(self.UpdateHandlers) do
        if type(handler) == "function" then
            handler(self. questID)
        end
    end
end

-- NoUsed
-- QuestHelper:SetScript("OnUpdate", function(self, elapsed)
--     if self.StopOnUpdate then return end
--     self.Timer = self.Timer - elapsed
--     if self.Timer < 0 then
--         self.Timer = QUEST_HELPER_UPDATE_TIMER
--         self:Update()
--     end
-- end)

QuestHelper:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        _DBG("OnEvent -", event)
    elseif event == "QUEST_ACCEPTED" then
        local questID = tostring(...)
        _DBG("OnEvent -", event, "QuestID:", questID)
        self:RegisterQuestButton(questID)
    elseif event == "QUEST_REMOVED" then
        local questID = tostring(...)
        _DBG("OnEvent -", event, "QuestID:", questID)
        self:UnRegisterUpdateHandler(questID)
        -- self:UnRegisterEventHandler(questID)
        self:UnRegisterQuestButton(questID)
        self:UnRegisterQuestButtonUpdateHandler(questID)
    elseif event == "QUEST_LOG_UPDATE" then
        _DBG("OnEvent -", event)
        for questID, _ in pairs(self.QuestHandlers) do
            if C_QuestLog.IsComplete(tonumber(questID)) then
                _DBG("OnEvent -", event, "Quest", questID, "Completed!")
                self:UnRegisterQuestHandler(questID)
                self:UnRegisterQuestButton(questID)
            end
        end
    end

    for questID, handler in pairs(self.EventHandlers) do
        if type(handler) == "function" then
            if self.IsExistQuest(questID) and not C_QuestLog.IsComplete(tonumber(questID)) then
                handler(self, event, ...)
            end
        end
    end
end)

QuestHelper:RegisterEvent("PLAYER_ENTERING_WORLD")
QuestHelper:RegisterEvent("QUEST_ACCEPTED")
QuestHelper:RegisterEvent("QUEST_REMOVED")
QuestHelper:RegisterEvent("QUEST_LOG_UPDATE")
QuestHelper:RegisterEvent("QUEST_WATCH_LIST_CHANGED")

QuestHelper:RegisterEvent("CHAT_MSG_MONSTER_SAY")
QuestHelper:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")


local _DBG = QuestHelper._DBG

-- The Games We Play / 林鬼的游戏 (https://www.wowhead.com/quest=57870/the-games-we-play)
local QuestID = 57870
local QuestHandler = {
    SpellID = 6477, -- 轻笑之篮
    Distance = 25,
    OnContinent = true,
    -- TODO: Multi-Language Support
    -- TODO: Replace NPCName with NPCID?
    NPCName = "顽皮的欺诈者",
    Actions = {
        {
            label = "强壮",
            text = "林鬼与我们有着同样的英雄！据说伟大英雄霍莱恩投出的长矛能够将山峰分成两半。多么壮观的景象！他一定非常强壮！",
            action = "/flex",
        },
        {
            label = "感谢",
            text = "许多人寻求我们的天赋，但很少有人能得偿所愿。有人献上礼物，我们总是欣然接受。有些人试图与我们斗智，大多都失败了。有些人请求许可，并总是感谢我们的辛劳。",
            action = "/thank",
        },
        {
            label = "跳舞",
            text = "哦，我太激动了，双脚不断跳跃根本停不下来！我可以跳舞跳到宇宙终结！和我共舞吧！",
            action = "/dance",
        },
        {
            label = "欢呼",
            text = "有一次，我试着欺骗一片林地里所有的希尔梵，让他们认为我是议会的一员！其他的林鬼都欢呼我的名字，持续好多天！",
            action = "/cheer",
        },
        {
            label = "介绍",
            text = "法夜宫廷非常注重礼仪，你明白的。稍微有失体统便会带来……毁灭性的后果。自我介绍是第一印象的重要部分！",
            action = "/introduce",
        },
        {
            label = "表扬",
            text = "我们为帮助这里的居民做了很多。我相信你也听说过相关的故事。缝补鞋子，种植庄稼，帮助走散的爱人重聚。但我们还得到过什么？连一句赞美的话都没有！哼！",
            action = "/praise",
        },
    },
    Begin = {
        "规则很简单！你只需要跟上我的对话节奏，给出适当回应就行！很简单，对吧？那就开始咯！",
    },
    Wrong = {
        "如果我不了解你的话，我会以为你毫无礼仪观念！但我已经告诉你规矩了！",
        "不，不，那完全不对！你到底有没有在听？",
        "我并不生气，我只是失望。",
    },
    Right = {
        "正确！还不赖……",
        "哦，非常好！非常好！",
        "非常完美！你干的真心不错！",
    },
    Success = {
        "真令人惊讶！你几乎如林鬼一样睿智……大概吧。",
    },
}

local function UpdateQuestButton(self, questID, playername, text)
    _DBG("UpdateQuestButton -", "QuestID:", questID, "playername:", playername)
    if not questID then return end
    if type(questID) ~= "string" then questID = tostring(questID) end
    
    local button = self:GetQuestButton(questID)
    if not button then
        button = self:RegisterQuestButton(questID)
    end

    if C_QuestLog.IsComplete(tonumber(questID)) then
        self:UnRegisterQuestHandler(questID)
        self:UnRegisterQuestButton(questID)
    else
        if QuestHandler and QuestHandler.Actions and text then
            local npcname = QuestHandler.NPCName
            if playername and npcname and playername == npcname and text then
                for _, v in pairs(QuestHandler.Actions) do
                    if v.text and string.find(v.text, text) then
                        if v.label then
                            button.text:SetText(v.label)
                        else
                            button.text:SetText("")
                        end
                        button:SetAttribute("type", "macro")
                        button:SetAttribute("macrotext1", string.format("/target %s\n%s", npcname, v.action));
                        if not button:IsShown() then
                            button:Show()
                        end
                        return
                    end
                end

                for _, v in pairs(QuestHandler.Begin) do
                    if v and string.find(v, text) then
                        _DBG("Begin!")
                        button.text:SetText("准备")
                        button:Show()
                        return
                    end
                end

                for _, v in pairs(QuestHandler.Right) do
                    if v and string.find(v, text) then
                        _DBG("Right!")
                        button:Hide()
                        DoEmote("STAND")
                        return
                    end
                end

                for _, v in pairs(QuestHandler.Wrong) do
                    if v and string.find(v, text) then
                        _DBG("Wrong!")
                        button:Hide()
                        return
                    end
                end

                for _, v in pairs(QuestHandler.Success) do
                    if v and string.find(v, text) then
                        _DBG("Success!")
                        button:Hide()
                        return
                    end
                end
            end
        end
    end
end

local function EventHandler(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        _DBG("EventHandler -", event)
        if not self:GetQuestHandler(QuestID) and self.IsExistQuest(QuestID) and not C_QuestLog.IsComplete(QuestID) then
            self:RegisterQuestHandler(QuestID, QuestHandler)
        end
    elseif event == "QUEST_ACCEPTED" then
        _DBG("EventHandler -", event, "QuestID:", ...)
        self:RegisterQuestHandler(QuestID, QuestHandler)
    elseif event == "QUEST_REMOVED" then
        _DBG("EventHandler -", event, "QuestID:", ...)
        self:UnRegisterQuestHandler(QuestID, QuestHandler)
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        local _, _, spellID = ...
        self.CurrentQuest = self:DetermineCurrentQuest(spellID)
        _DBG("EventHandler -", event, "CurrentQuest:", self.CurrentQuest, "SpellID:", spellID)
        UpdateQuestButton(self, self.CurrentQuest)
    elseif event == "CHAT_MSG_MONSTER_SAY" then
        local text, playername = ...
        self.CurrentQuest = self:DetermineCurrentQuest(nil, playername, text)
        _DBG("EventHandler -", event, "CurrentQuest:", self.CurrentQuest)
        UpdateQuestButton(self, self.CurrentQuest, playername, text)
    end
end

QuestHelper:RegisterEventHandler(QuestID, EventHandler)