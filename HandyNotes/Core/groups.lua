-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, Core = ...
local L = Core.locale
local Class = Core.Class

-------------------------------------------------------------------------------
------------------------------------ GROUP ------------------------------------
-------------------------------------------------------------------------------

local Group = Class('Group')

function Group:Initialize(name, icon, attrs)
    if not name then error('Groups must be initialized with a name!') end
    if not icon then error('Groups must be initialized with an icon!') end

    self.name = name
    self.icon = icon

    self.label = L['options_icons_' .. name]
    self.desc = L['options_icons_' .. name .. '_desc']

    -- Prepare any links in this group label/description
    Core.PrepareLinks(self.label)
    Core.PrepareLinks(self.desc)

    if attrs then for k, v in pairs(attrs) do self[k] = v end end

    self.type = self.type or Core.group_types.EXPANSION
    self.order = self.order or 1

    self.alphaArg = 'icon_alpha_' .. self.name
    self.scaleArg = 'icon_scale_' .. self.name
    self.displayArg = 'icon_display_' .. self.name

    if not self.defaults then self.defaults = {} end
    self.defaults.alpha = self.defaults.alpha or 1
    self.defaults.scale = self.defaults.scale or 1
    self.defaults.display = self.defaults.display ~= false
end

function Group:HasEnabledNodes(map)
    for coord, node in pairs(map.nodes) do
        if node.group[1] == self and map:CanDisplay(node, coord) then
            return true
        end
    end
    return false
end

-- Override to hide this group in the UI under certain circumstances
function Group:IsEnabled()

    -- Check faction
    if self.faction then
        if Core:GetOpt('ignore_faction_restrictions') then return true end
        if self.faction ~= Core.faction then return false end
    end

    -- Check class
    if self.class then
        if Core:GetOpt('ignore_class_restrictions') then return true end
        if self.class ~= Core.class then return false end
    end

    return true
end

function Group:_GetOpt(option, default, mapID)
    local value
    if Core:GetOpt('per_map_settings') then
        value = Core:GetOpt(option .. '_' .. mapID)
    else
        value = Core:GetOpt(option)
    end
    return (value == nil) and default or value
end

function Group:_SetOpt(option, value, mapID)
    if Core:GetOpt('per_map_settings') then
        return Core:SetOpt(option .. '_' .. mapID, value)
    end
    return Core:SetOpt(option, value)
end

-- Get group settings
function Group:GetAlpha(mapID)
    return self:_GetOpt(self.alphaArg, self.defaults.alpha, mapID)
end
function Group:GetScale(mapID)
    return self:_GetOpt(self.scaleArg, self.defaults.scale, mapID)
end
function Group:GetDisplay(mapID)
    return self:_GetOpt(self.displayArg, self.defaults.display, mapID)
end

-- Set group settings
function Group:SetAlpha(v, mapID) self:_SetOpt(self.alphaArg, v, mapID) end
function Group:SetScale(v, mapID) self:_SetOpt(self.scaleArg, v, mapID) end
function Group:SetDisplay(v, mapID) self:_SetOpt(self.displayArg, v, mapID) end

-------------------------------------------------------------------------------

Core.Group = Group

Core.GROUP_HIDDEN = {display = false}
Core.GROUP_HIDDEN75 = {alpha = 0.75, display = false}
Core.GROUP_ALPHA75 = {alpha = 0.75}

Core.group_types = {
    -- Standard groups that apply to all zones in all expansions (rares, treasures,
    -- pet battles, etc).
    STANDARD = 1,

    -- Groups that are specific to a zone or expansion, such as dragon riding glyphs,
    -- disturbed dirts, expedition scout packs or magic-bound chests for Dragonflight.
    EXPANSION = 2,

    -- Groups that are intended to help complete a specific achievement. These will go
    -- into a sub-menu so the main menu does not grow too large.
    ACHIEVEMENT = 3,

    -- Any other groups that do not fall into the above categories
    OTHER = 4
}

Core.groups = {
    RARE = Group('rares', 'skull_w', {
        defaults = Core.GROUP_ALPHA75,
        type = Core.group_types.STANDARD,
        order = 1
    }),
    TREASURE = Group('treasures', 'chest_gy', {
        defaults = Core.GROUP_ALPHA75,
        type = Core.group_types.STANDARD,
        order = 2
    }),
    PETBATTLE = Group('pet_battles', 'paw_y',
        {type = Core.group_types.STANDARD, order = 3}),
    QUEST = Group('quests', 'quest_ay',
        {type = Core.group_types.STANDARD, order = 4}),
    VENDOR = Group('vendors', 'bag', {type = Core.group_types.STANDARD, order = 5}),
    MISC = Group('misc', 454046, {type = Core.group_types.STANDARD, order = 6})
}
