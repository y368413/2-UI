-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, Core = ...

-------------------------------------------------------------------------------
----------------------------------- COLORS ------------------------------------
-------------------------------------------------------------------------------

Core.COLORS = {
    Blue = 'FF0066FF',
    Bronze = 'FFCD7F32',
    Gold = 'FFFFD700',
    Gray = 'FF999999',
    Green = 'FF00FF00',
    LightBlue = 'FF8080FF',
    Orange = 'FFFF8C00',
    Red = 'FFFF0000',
    Silver = 'FFC4D4E4',
    White = 'FFFFFFFF',
    Yellow = 'FFFFFF00',
    --------------------
    Heirloom = 'FF00CCFF',
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

-- Get ARGB values from HEX Colors
Core.getARGB = function(color, mul)
    local c = Core.COLORS[color] or 'FFFF00FF'
    local argb = {}
    for k, v in pairs({c:match('(%x%x)(%x%x)(%x%x)(%x%x)')}) do
        argb[k] = tonumber(v, 16) / 255 * (mul or 1)
    end
    local _, r, g, b = unpack(argb)
    return r, g, b
end
