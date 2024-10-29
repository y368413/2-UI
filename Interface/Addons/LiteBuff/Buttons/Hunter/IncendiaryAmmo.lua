------------------------------------------------------------
-- IncendiaryAmmo.lua
--
-- Abin
-- 2015/7/17
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "HUNTER" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 162536)
addon:BuildSpellList(spellList, 162537)
addon:BuildSpellList(spellList, 162539)

local SPELL_NAME = GetSpellInfo(162534)

local button = addon:CreateActionButton("HunterIncendiaryAmmo", SPELL_NAME, nil, 3600, "PLAYER_AURA")
button:SetFlyProtect()
button:SetScrollable(spellList)
button:RequireSpell(162536)