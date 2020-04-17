if select(2, UnitClass("player")) ~= "HUNTER" then return end

local _, MaxDps_HunterTable = ...;

--- @type MaxDps
if not MaxDps then return end
local MaxDps = MaxDps;
local Hunter = MaxDps_HunterTable.Hunter;

local defaultOptions = {
	advancedAoeBM = true,
	huntersMarkCooldown = false,
	doubleTapCooldown = false,
};

function Hunter:GetConfig()
	local config = {
		layoutConfig = { padding = { top = 30 } },
		database     = self.db,
		rows         = {
			[1] = {
				beastmastery = {
					type = 'header',
					label = 'Beast Mastery options'
				}
			},
			[2] = {
				advancedAoeBM = {
					type   = 'checkbox',
					label  = 'Advanced AOE detection (need to put pet basic attack on YOUR action bars)',
					column = 12
				},
			},
			[3] = {
				beastmastery = {
					type = 'header',
					label = 'Marksmanship options'
				}
			},
			[4] = {
				huntersMarkCooldown = {
					type   = 'checkbox',
					label  = 'Hunters Mark as cooldown',
					column = 6
				},
				doubleTapCooldown = {
					type   = 'checkbox',
					label  = 'Double Tap as cooldown',
					column = 6
				},
			},
		},
	};

	return config;
end


function Hunter:InitializeDatabase()
	if self.db then return end;
	self.db = defaultOptions;
end