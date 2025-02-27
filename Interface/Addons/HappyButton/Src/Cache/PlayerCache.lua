local addonName, _ = ...


---@class HappyButton: AceAddon
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class CONST: AceModule
local const = addon:GetModule('CONST')

---@class Utils: AceModule
local U = addon:GetModule('Utils')

---@class Api: AceModule
local Api = addon:GetModule("Api")

---@class Client: AceModule
local Client = addon:GetModule("Client")


---@class PlayerCache: AceModule
---@field className string 本地名称，例如：战士
---@field classFileName string 英文大写，例如 DEMONHUNTER
---@field classId Class 职业编号
---@field gcdSpellId SpellID 玩家的gcd技能编号
local PlayerCache = addon:NewModule("PlayerCache")


function PlayerCache:Initial()
    local className, classFileName, classID = UnitClass("player")
    PlayerCache.className = className
    PlayerCache.classFileName = classFileName
    PlayerCache.classId = classID
    if Client:IsEra() then
        -- 怀旧服没有明确的gcd技能编号，使用初始技能替代
        if PlayerCache.classId == const.CLASS.MAGE then
            PlayerCache.gcdSpellId = 168 -- 法师：霜甲术
        elseif PlayerCache.classId == const.CLASS.WARLOCK then
            PlayerCache.gcdSpellId = 687 -- 术士：恶魔皮肤
        elseif PlayerCache.classId == const.CLASS.PRIEST then
            PlayerCache.gcdSpellId = 2050 -- 牧师：次级治疗术
        elseif PlayerCache.classId == const.CLASS.ROGUE then
            PlayerCache.gcdSpellId = 2098 -- 盗贼：剔骨
        elseif PlayerCache.classId == const.CLASS.DRUID then
            PlayerCache.gcdSpellId = 5185 -- 德鲁伊：治疗之触
        elseif PlayerCache.classId == const.CLASS.HUNTER then
            PlayerCache.gcdSpellId = 1494 -- 猎人：追踪野兽
        elseif PlayerCache.classId == const.CLASS.SHAMAN then
            PlayerCache.gcdSpellId = 331 -- 萨满：治疗波
        elseif PlayerCache.classId == const.CLASS.PALADIN then
            PlayerCache.gcdSpellId = 635 -- 骑士：治疗术
        elseif PlayerCache.classId == const.CLASS.WARRIOR then
            PlayerCache.gcdSpellId = 2457 -- 战士：战斗姿态
        else
            PlayerCache.gcdSpellId = 6603  -- 攻击
        end
    else
        PlayerCache.gcdSpellId = 61304  -- https://wowpedia.fandom.com/wiki/API_GetSpellCooldown
    end
end