if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, MaxDps_ShamanTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Shaman = MaxDps_ShamanTable.Shaman;

local RT = {
	FlameShock    = 188838,
	LightningBolt = 403,
};

function Shaman:Restoration()

end