if select(2, UnitClass("player")) ~= "PALADIN" then return end

local _, MaxDps_PaladinTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Paladin = MaxDps_PaladinTable.Paladin;
local MaxDps = MaxDps;

function Paladin:Holy()

end