------------------------------------------------------------
-- Stances.lua
--
-- Abin
-- 2015/7/26
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "MONK" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 115070)
addon:BuildSpellList(spellList, 154436)

local button = addon:CreateActionButton("MonkStances", L["stances"], nil, nil, "STANCE")
button:SetAttribute("type", "spell")
button:RequireSpell(115070)
button:SetScrollable(spellList)