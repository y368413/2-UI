if select(2, UnitClass("player")) ~= "ROGUE" then return end

local _, MaxDps_RogueTable = ...;

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;
local Rogue = MaxDps_RogueTable.Rogue;

local defaultOptions = {
	outlawMarkedAsCooldown = false,
};

function Rogue:GetConfig()
	local config = {
		layoutConfig = { padding = { top = 30 } },
		database     = self.db,
		rows         = {
			[1] = {
				outlaw = {
					type = 'header',
					label = 'Outlaw options'
				}
			},
			[2] = {
				outlawMarkedAsCooldown = {
					type   = 'checkbox',
					label  = 'Marked for Death as cooldown',
					column = 12
				},
			},
		},
	};

	return config;
end


function Rogue:InitializeDatabase()
	if self.db then return end;
	self.db = defaultOptions;
end