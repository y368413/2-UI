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
        if node.group == self and map:CanDisplay(node, coord) then
            return true
        end
    end
    return false
end

-- Override to hide this group in the UI under certain circumstances
function Group:IsEnabled()
    if self.class and self.class ~= Core.class then return false end
    if self.faction and self.faction ~= Core.faction then return false end
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

Core.groups = {
    PETBATTLE = Group('pet_battles', 'paw_y'),
    QUEST = Group('quests', 'quest_ay'),
    RARE = Group('rares', 'skull_w', {defaults = Core.GROUP_ALPHA75}),
    TREASURE = Group('treasures', 'chest_gy', {defaults = Core.GROUP_ALPHA75}),
    MISC = Group('misc', 454046)
}
