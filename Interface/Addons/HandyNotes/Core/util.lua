local _, Core = ...

-------------------------------------------------------------------------------
------------------------------ DATAMINE TOOLTIP -------------------------------
-------------------------------------------------------------------------------

local function CreateDatamineTooltip(name)
    local f = CreateFrame('GameTooltip', name, UIParent, 'GameTooltipTemplate')
    f:SetOwner(UIParent, 'ANCHOR_NONE')
    return f
end

local NameResolver = {
    cache = {},
    prepared = {},
    preparer = CreateDatamineTooltip("HandyNotes_Core" .. '_NamePreparer'),
    resolver = CreateDatamineTooltip("HandyNotes_Core" .. '_NameResolver')
}

function NameResolver:IsLink(link)
    if link == nil then return link end
    return strsub(link, 1, 5) == 'unit:'
end

function NameResolver:Prepare(link)
    if self:IsLink(link) and not (self.cache[link] or self.prepared[link]) then
        -- use a separate tooltip to spam load NPC names, doing this with the
        -- main tooltip can sometimes cause it to become unresponsive and never
        -- update its text until a reload
        self.preparer:SetHyperlink(link)
        self.prepared[link] = true
    end
end

function NameResolver:Resolve(link)
    -- may be passed a raw name or a hyperlink to be resolved
    if not self:IsLink(link) then return link or UNKNOWN end

    -- all npcs must be prepared ahead of time to avoid breaking the resolver
    if not self.prepared[link] then
        Core.Debug('ERROR: npc link not prepared:', link)
    end

    local name = self.cache[link]
    if name == nil then
        self.resolver:SetHyperlink(link)
        name = _G[self.resolver:GetName() .. 'TextLeft1']:GetText() or UNKNOWN
        if name == UNKNOWN then
            Core.Debug('NameResolver returned UNKNOWN, recreating tooltip ...')
            self.resolver = CreateDatamineTooltip("HandyNotes_Core" .. '_NameResolver')
        else
            self.cache[link] = name
        end
    end
    return name
end

-------------------------------------------------------------------------------
-------------------------------- LINK RENDERER --------------------------------
-------------------------------------------------------------------------------

local function PrepareLinks(str)
    if not str then return end
    for type, id in str:gmatch('{(%l+):(%d+)(%l*)}') do
        id = tonumber(id)
        if type == 'npc' then
            NameResolver:Prepare(('unit:Creature-0-0-0-0-%d'):format(id))
        elseif type == 'item' then
            C_Item.RequestLoadItemDataByID(id) -- prime item info
        elseif type == 'daily' or type == 'quest' then
            C_QuestLog.RequestLoadQuestByID(id) -- prime quest title
        elseif type == 'spell' then
            C_Spell.RequestLoadSpellData(id) -- prime spell info
        end
    end
end

local function RenderLinks(str, nameOnly)
    -- render numberic ids
    local links, _ = str:gsub('{(%l+):(%d+)(%l*)}', function(type, id, suffix)
        id = tonumber(id)
        if type == 'npc' then
            local name = NameResolver:Resolve(
                ('unit:Creature-0-0-0-0-%d'):format(id))
            name = name .. (suffix or '')
            if nameOnly then return name end
            return Core.color.NPC(name)
        elseif type == 'achievement' then
            if nameOnly then
                local _, name = GetAchievementInfo(id)
                if name then return name end
            else
                local link = GetAchievementLink(id)
                if link then
                    return Core.GetIconLink('achievement', 15) .. link
                end
            end
        elseif type == 'currency' then
            local info = C_CurrencyInfo.GetCurrencyInfo(id)
            if info then
                if nameOnly then return info.name end
                local link = C_CurrencyInfo.GetCurrencyLink(id, 0)
                if link then
                    return '|T' .. info.iconFileID .. ':0:0:1:-1|t ' .. link
                end
            end
        elseif type == 'faction' then
            local name = GetFactionInfoByID(id)
            if nameOnly then return name end
            return Core.color.NPC(name) -- TODO: colorize based on standing?
        elseif type == 'item' then
            local name, link, _, _, _, _, _, _, _, icon = GetItemInfo(id)
            if link and icon then
                if nameOnly then return name .. (suffix or '') end
                return '|T' .. icon .. ':0:0:1:-1|t ' .. link
            end
        elseif type == 'daily' or type == 'quest' then
            local name = C_QuestLog.GetTitleForQuestID(id)
            if name then
                if nameOnly then return name end
                local icon = (type == 'daily') and 'quest_ab' or 'quest_ay'
                return Core.GetIconLink(icon, 12) ..
                           Core.color.Yellow('[' .. name .. ']')
            end
        elseif type == 'spell' then
            local name, _, icon = GetSpellInfo(id)
            if name and icon then
                if nameOnly then return name end
                local spell = Core.color.Spell(
                    '|Hspell:' .. id .. '|h[' .. name .. ']|h')
                return '|T' .. icon .. ':0:0:1:-1|t ' .. spell
            end
        end
        return type .. '+' .. id
    end)
    -- render non-numeric ids
    links, _ = links:gsub('{(%l+):([^}]+)}', function(type, id)
        if type == 'wq' then
            local icon = Core.GetIconLink('world_quest', 16, 0, -1)
            return icon .. Core.color.Yellow('[' .. id .. ']')
        end
        return type .. '+' .. id
    end)
    return links
end

-------------------------------------------------------------------------------
-------------------------------- BAG FUNCTIONS --------------------------------
-------------------------------------------------------------------------------

local function PlayerHasItem(item, count)
    return GetItemCount(item, true) >= (count and count > 1 and count or 1)
end

-------------------------------------------------------------------------------
------------------------------ DATABASE FUNCTIONS -----------------------------
-------------------------------------------------------------------------------

local function GetDatabaseTable(...)
    local db = _G["HandyNotes_Core" .. 'DB']
    for _, key in ipairs({...}) do
        if db[key] == nil then db[key] = {} end
        db = db[key]
    end
    return db
end

-------------------------------------------------------------------------------
------------------------------ LOCALE FUNCTIONS -------------------------------
-------------------------------------------------------------------------------

--[[

Wrap the AceLocale NewLocale() function to return a slightly modified locale
table. This table will ignore assignments of `nil`, allowing locales to include
noop translation lines in their files without overriding the default enUS
strings. This allows us to keep all the locale files in sync with the exact
same keys in the exact same order even before actual translations are done.

--]]

--[[local AceLocale = LibStub("AceLocale-3.0")
local LOCALES = {}

local function NewLocale(locale)
    if LOCALES[locale] then return LOCALES[locale] end
    local L = AceLocale:NewLocale("HandyNotes", locale, (locale == 'enUS'), true)
    if not L then return end
    local wrapper = {}
    setmetatable(wrapper, {
        __index = function(self, key) return L[key] end,
        __newindex = function(self, key, value)
            if value == nil then return end
            L[key] = value
        end
    })
    return wrapper
end]]

-------------------------------------------------------------------------------
------------------------------ TABLE CONVERTERS -------------------------------
-------------------------------------------------------------------------------

local function AsTable(value, class)
    -- normalize to table of scalars
    if type(value) == 'nil' then return end
    if type(value) ~= 'table' then return {value} end
    if class and Core.IsInstance(value, class) then return {value} end
    return value
end

local function AsIDTable(value)
    -- normalize to table of id objects
    if type(value) == 'nil' then return end
    if type(value) ~= 'table' then return {{id = value}} end
    if value.id then return {value} end
    for i, v in ipairs(value) do
        if type(v) == 'number' then value[i] = {id = v} end
    end
    return value
end

-------------------------------------------------------------------------------

Core.AsIDTable = AsIDTable
Core.AsTable = AsTable
Core.GetDatabaseTable = GetDatabaseTable
Core.NameResolver = NameResolver
--Core.NewLocale = NewLocale
Core.PlayerHasItem = PlayerHasItem
Core.PrepareLinks = PrepareLinks
Core.RenderLinks = RenderLinks
