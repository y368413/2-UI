-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, Core = ...

local L = Core.locale
local Class = Core.Class

-------------------------------------------------------------------------------
--------------------------------- REQUIREMENT ---------------------------------
-------------------------------------------------------------------------------

--[[

Base class for all node requirements.

    text (string): Requirement text

--]]

local Requirement = Class('Requirement', nil, {text = UNKNOWN})
function Requirement:GetText() return self.text end
function Requirement:IsMet() return false end

-------------------------------------------------------------------------------
--------------------------------- ACHIEVEMENT ---------------------------------
-------------------------------------------------------------------------------

local Achievement = Class('Achievement', Requirement)

function Achievement:Initialize(id)
    self.id = id
    self.text = string.format('{achievement:%d}', self.id)
end

function Achievement:IsMet()
    local _, _, _, completed = GetAchievementInfo(self.id)

    return completed
end

-------------------------------------------------------------------------------
---------------------------------- CURRENCY -----------------------------------
-------------------------------------------------------------------------------

local Currency = Class('Currency', Requirement)

function Currency:Initialize(id, count)
    self.id, self.count = id, count
    self.text = string.format('{currency:%d} x%d', self.id, self.count)
end

function Currency:IsMet()
    local info = C_CurrencyInfo.GetCurrencyInfo(self.id)
    return info and info.quantity >= self.count
end

-------------------------------------------------------------------------------
------------------------------- GARRISON TALENT -------------------------------
-------------------------------------------------------------------------------

local GarrisonTalent = Class('GarrisonTalent', Requirement)

function GarrisonTalent:Initialize(id, text) self.id, self.text = id, text end

function GarrisonTalent:GetText()
    local info = C_Garrison.GetTalentInfo(self.id)
    return self.text == UNKNOWN and info.name or self.text:format(info.name)
end

function GarrisonTalent:IsMet()
    local info = C_Garrison.GetTalentInfo(self.id)
    return info and info.researched
end

-------------------------------------------------------------------------------
----------------------------- GARRISON TALENT RANK ----------------------------
-------------------------------------------------------------------------------

local GarrisonTalentRank = Class('GarrisonTalentRank', Requirement)

function GarrisonTalentRank:Initialize(id, rank) self.id, self.rank = id, rank end

function GarrisonTalentRank:GetText()
    local info = C_Garrison.GetTalentInfo(self.id)
    return L['ranked_research']:format(info.name, self.rank, info.talentMaxRank)
end

function GarrisonTalentRank:IsMet()
    local info = C_Garrison.GetTalentInfo(self.id)
    return info and info.talentRank and info.talentRank >= self.rank
end

-------------------------------------------------------------------------------
------------------------------------ ITEM -------------------------------------
-------------------------------------------------------------------------------

local Item = Class('Item', Requirement)

function Item:Initialize(id, count)
    self.id, self.count = id, count
    self.text = string.format('{item:%d}', self.id)
    if self.count and self.count > 1 then
        self.text = self.text .. ' x' .. self.count
    end
end

function Item:IsMet() return Core.PlayerHasItem(self.id, self.count) end

-------------------------------------------------------------------------------
------------------------------------ QUEST ------------------------------------
-------------------------------------------------------------------------------

local Quest = Class('Quest', Requirement)

function Quest:Initialize(id) self.id = id end

function Quest:GetText() return C_QuestLog.GetTitleForQuestID(self.id) end

function Quest:IsMet() return C_QuestLog.IsQuestFlaggedCompleted(self.id) end

-------------------------------------------------------------------------------
--------------------------------- REPUTATION ----------------------------------
-------------------------------------------------------------------------------

local Reputation = Class('Reputation', Requirement)

-- @todo will cause problems when requiring lower / negative reputations. Maybe add comparison as optional parameter with default value '>='.
function Reputation:Initialize(id, level) self.id, self.level = id, level end

function Reputation:GetText()
    local name = GetFactionInfoByID(self.id)
    local level = GetText('FACTION_STANDING_LABEL' .. self.level)
    return string.format(name .. ' (' .. level .. ')')
end

function Reputation:IsMet()
    local _, _, standingID = GetFactionInfoByID(self.id)

    return standingID >= self.level
end

-------------------------------------------------------------------------------
------------------------------------ SPELL ------------------------------------
-------------------------------------------------------------------------------

local Spell = Class('Spell', Requirement)

function Spell:Initialize(id)
    self.id = id
    self.text = string.format('{spell:%d}', self.id)
end

function Spell:IsMet()
    for i = 1, 255 do
        local buff = select(10, UnitAura('player', i, 'HELPFUL'))
        local debuff = select(10, UnitAura('player', i, 'HARMFUL'))
        if buff == self.id or debuff == self.id then return true end
    end
    return false
end

-------------------------------------------------------------------------------
----------------------------------- WAR MODE ----------------------------------
-------------------------------------------------------------------------------

local WarMode = Class('WarMode', Requirement, {
    text = PVP_LABEL_WAR_MODE,
    IsMet = function()
        return C_PvP.IsWarModeActive() or C_PvP.IsWarModeDesired()
    end
})()

-------------------------------------------------------------------------------

Core.requirement = {
    Achievement = Achievement,
    Currency = Currency,
    GarrisonTalent = GarrisonTalent,
    GarrisonTalentRank = GarrisonTalentRank,
    Item = Item,
    Quest = Quest,
    Reputation = Reputation,
    Requirement = Requirement,
    Spell = Spell,
    WarMode = WarMode
}
