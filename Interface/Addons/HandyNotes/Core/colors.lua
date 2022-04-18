-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, Core = ...

-------------------------------------------------------------------------------
----------------------------------- COLORS ------------------------------------
-------------------------------------------------------------------------------

Core.COLORS = {
    Blue = 'FF0066FF',
    Gray = 'FF999999',
    Green = 'FF00FF00',
    LightBlue = 'FF8080FF',
    Orange = 'FFFF8C00',
    Red = 'FFFF0000',
    White = 'FFFFFFFF',
    Yellow = 'FFFFFF00',
    --------------------
    NPC = 'FFFFFD00',
    Spell = 'FF71D5FF'
}

Core.color = {}
Core.status = {}

for name, color in pairs(Core.COLORS) do
    Core.color[name] = function(t) return string.format('|c%s%s|r', color, t) end
    Core.status[name] = function(t)
        return string.format('(|c%s%s|r)', color, t)
    end
end
