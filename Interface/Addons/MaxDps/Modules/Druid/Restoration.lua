if select(2, UnitClass("player")) ~= "DRUID" then return end

local _, MaxDps_DruidTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Druid = MaxDps_DruidTable.Druid;

function Druid:Restoration()
	return nil;
end