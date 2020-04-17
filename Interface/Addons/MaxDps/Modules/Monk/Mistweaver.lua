if select(2, UnitClass("player")) ~= "MONK" then return end

local _, MaxDps_MonkTable = ...;

--- @type MaxDps
if not MaxDps then return end

local MaxDps = MaxDps;
local Monk = MaxDps_MonkTable.Monk;

function Monk:Mistweaver()
	return nil;
end