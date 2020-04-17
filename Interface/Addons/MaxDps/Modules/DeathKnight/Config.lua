if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local _, MaxDps_DeathKnightTable = ...;

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;
local DeathKnight = MaxDps_DeathKnightTable.DeathKnight;

local defaultOptions = {
	unholyApocalypseAsCooldown = false,
	unholyDarkTransformationAsCooldown = false,
	unholyUnholyFrenzyAsCooldown = false,
};

function DeathKnight:GetConfig()
	local config = {
		layoutConfig = { padding = { top = 30 } },
		database     = self.db,
		rows         = {
			[1] = {
				outlaw = {
					type = 'header',
					label = 'Unholy options'
				}
			},
			[2] = {
				unholyApocalypseAsCooldown = {
					type   = 'checkbox',
					label  = 'Apocalypse as cooldown',
					column = 12
				},
			},
			[3] = {
				unholyDarkTransformationAsCooldown = {
					type   = 'checkbox',
					label  = 'Dark Transformation as cooldown',
					column = 12
				},
			},
			[4] = {
				unholyUnholyFrenzyAsCooldown = {
					type   = 'checkbox',
					label  = 'Unholy Frenzy as cooldown',
					column = 12
				},
			},
		},
	};

	return config;
end


function DeathKnight:InitializeDatabase()
	if self.db then return end;
	self.db = defaultOptions;
end