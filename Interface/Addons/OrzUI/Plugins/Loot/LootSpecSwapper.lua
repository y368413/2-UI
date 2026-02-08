-- Core.lua
-- Main addon initialization and namespace
if GetLocale() == "zhCN" then
  LootSpecSwapperLocal = "|cff33ff99[拾取]|r专精切换";
elseif GetLocale() == "zhTW" then
  LootSpecSwapperLocal = "|cff33ff99[拾取]|r专精切换";
else
  LootSpecSwapperLocal = "Loot Spec Swapper";
end
local  LSS = {}

-- Addon info
LSS.version = "12.0.0.03"
LSS.author = "Cilraaz"

-- Module references (will be populated by modules)
LSS.db = nil
LSS.specManager = nil
LSS.eventHandler = nil
LSS.commands = nil
LSS.ui = nil
LSS.config = nil

-- Constants
LSS.DIFFICULTY_NAMES = {
	[1] = "普通地下城通",
	[2] = "英雄地下城",
	[14] = "普通团队",
	[15] = "英雄团队",
	[16] = "史诗团队",
	[17] = "随机团队",
	[23] = "史诗地下城",
}

-- Utility functions
function LSS:Print(msg, ...)
	if not self.db or not self.db:IsSilenced() then
		print("|cff00ff00[LSS]|r", string.format(msg, ...))
	end
end

function LSS:Debug(msg, ...)
	if self.db and self.db:IsDebugMode() then
		print("|cffff8800[LSS Debug]|r", string.format(msg, ...))
	end
end

function LSS:Error(msg, ...)
	print("|cffff0000[LSS Error]|r", string.format(msg, ...))
end


-- Data\BossFixes.lua
-- Maps actual in-game boss names to Encounter Journal names

LSS.BossFixes = {
	----- Dungeons -----
	
	-- Cataclysm
	["Asaad"] = "Asaad, Caliph of Zephyrs",
	
	-- Legion
	["Dargrul"] = "Dargrul the Underking",
	
	-- Battle for Azeroth
	["Captain Eudora"] = "Council o' Captains",
	["Captain Jolly"] = "Council o' Captains",
	["Captain Raoul"] = "Council o' Captains",
	["Shark Puncher"] = "Ring of Booty",
	["The Platinum Puncher"] = "Tussle Tonks",
	["Gnomercy 4.U."] = "Tussle Tonks",
	["Head Machinist Sparkflux"] = "Machinist's Garden",
	
	-- Shadowlands
	["Milificent Manastorm"] = "The Manastorms",
	["Millhouse Manastorm"] = "The Manastorms",
	["Halkias"] = "Halkias, the Sin-Stained Goliath",
	["Azules"] = "Kin-Tara",
	["Devos"] = "Devos, Paragon of Doubt",
	["Stitchflesh's Creation"] = "Surgeon Stitchflesh",
	["Dessia the Decapitator"] = "An Affront of Challengers",
	["Paceran the Virulent"] = "An Affront of Challengers",
	["Sathel the Accursed"] = "An Affront of Challengers",
	["Mordretha"] = "Mordretha, the Endless Empress",
	
	-- Dragonflight
	["Rira Hackclaw"] = "Hackclaw's War-Band",
	["Gashtooth"] = "Hackclaw's War-Band",
	["Tricktotem"] = "Hackclaw's War-Band",
	["Erkhart Stormvein"] = "Kyrakka and Erkhart Stormvein",
	["Teera"] = "Teera and Maruuk",
	["Maruuk"] = "Teera and Maruuk",
	["Baelog"] = "The Lost Dwarves",
	["Eric \"The Swift\""] = "The Lost Dwarves",
	["Olaf"] = "The Lost Dwarves",
	
	-- The War Within
	["Nx"] = "Fangs of the Queen",
	["Vx"] = "Fangs of the Queen",
	["Starved Crawler"] = "Avanoxx",
	["Thirsty Patron"] = "Brew Master Aldryr",
	["Brew Drop"] = "I'pa",
	["Cindy"] = "Benk Buzzbee",
	["Ravenous Cinderbee"] = "Benk Buzzbee",
	["Yes Man"] = "Goldie Baronbottom",
	["Elaena Emberlanz"] = "Captain Dailcry",
	["Sergeant Shaynemail"] = "Captain Dailcry",
	["Taener Duelmal"] = "Captain Dailcry",
	["E.D.N.A"] = "E.D.N.A.",
	["Speaker Dorlita"] = "Master Machinists",
	["Speaker Brokk"] = "Master Machinists",
	["Keeza Quickfuse"] = "Demolition Duo",
	["Bront"] = "Demolition Duo",
	["A'wazj"] = "Taah'bat and A'wazj",
	["Taah'bat"] = "Taah'bat and A'wazj",
	
	-- Midnight
	["Muro'jin"] = "Muro'jin and Nekraxx",
	["Nekraxx"] = "Muro'jin and Nekraxx",
	["Rak'tul"] = "Rak'tul, Vessel of Souls",
	["Meittik"] = "Lightblossom Trinity",
	["Lekshi"] = "Lightblossom Trinity",
	["Kezkitt"] = "Lightblossom Trinity",
	["Kalis"] = "Derelict Duo",
	["Latch"] = "Derelict Duo",
	["Restless Heart"] = "The Restless Heart",
	
	----- Raids -----
	
	-- Shadowlands World Bosses
	["Valinor"] = "Valinor, the Light of Eons",
	["Mor'geth"] = "Mor'geth, Tormentor of the Damned",
	["Sav'thul"] = "Antros",
	
	-- Castle Nathria
	["Margore"] = "Huntsman Altimor",
	["Kael'thas Sunstrider"] = "Sun King's Salvation",
	["High Torturor Darithos"] = "Sun King's Salvation",
	["Bleakwing Assassin"] = "Sun King's Salvation",
	["Vile Occultist"] = "Sun King's Salvation",
	["Castellan Niklaus"] = "The Council of Blood",
	["Baroness Frieda"] = "The Council of Blood",
	["Lord Stavros"] = "The Council of Blood",
	["General Kaal"] = "Stone Legion Generals",
	["General Grashaal"] = "Stone Legion Generals",
	
	-- Sanctum of Domination
	["Eye of the Jailer"] = "The Eye of the Jailer",
	["Kyra"] = "The Nine",
	["Signe"] = "The Nine",
	["Skyja"] = "The Nine",
	
	-- Sepulcher of the First Ones
	["Vigilant Custodian"] = "Vigilant Guardian",
	["Skolex"] = "Skolex, the Insatiable Ravener",
	["Dausegne"] = "Dausegne, the Fallen Oracle",
	["Prototype of War"] = "Prototype Pantheon",
	["Prototype of Duty"] = "Prototype Pantheon",
	["Lihuvim"] = "Lihuvim, Principal Architect",
	["Halondrus"] = "Halondrus the Reclaimer",
	["Mal'Ganis"] = "Lords of Dread",
	["Kin'tessa"] = "Lords of Dread",
	
	-- Dragonflight World Bosses
	["Strunraan"] = "Strunraan, The Sky's Misery",
	["Basrikron"] = "Basrikron, The Shale Wing",
	["Bazual"] = "Bazual, The Dreaded Flame",
	["Liskanoth"] = "Liskanoth, The Futurebane",
	
	-- Vault of the Incarnates
	["Kadros Icewrath"] = "The Primal Council",
	["Dathea Stormlash"] = "The Primal Council",
	["Opalfang"] = "The Primal Council",
	["Embar Firepath"] = "The Primal Council",
	["Sennarth"] = "Sennarth, the Cold Breath",
	
	-- Aberrus, the Shadowed Crucible
	["Kazzara"] = "Kazzara, the Hellforged",
	["Essence of Shadow"] = "The Amalgamation Chamber",
	["Eternal Blaze"] = "The Amalgamation Chamber",
	["Neldris"] = "The Forgotten Experiments",
	["Thadrion"] = "The Forgotten Experiments",
	["Rionthus"] = "The Forgotten Experiments",
	["Rashok"] = "Rashok, the Elder",
	["Warlord Kagni"] = "Assault of the Zaqali",
	["Zskarn"] = "The Vigilant Steward, Zskarn",
	["Neltharion"] = "Echo of Neltharion",
	["Sarkareth"] = "Scalecommander Sarkareth",
	
	-- Amidrassil
	["Urctos"] = "Council of Dreams",
	["Aerwynn"] = "Council of Dreams",
	["Pip"] = "Council of Dreams",
	["Nymue"] = "Nymue, Weaver of the Cycle",
	["Tindral Sageswift"] = "Tindral Sageswift, Seer of the Flame",
	["Fyrakk"] = "Fyrakk the Blazing",
	
	-- The War Within World Bosses
	["Kordac"] = "Kordac, the Dormant Protector",
	["Shurrai"] = "Shurrai, Atrocity of the Undersea",
	["Orta"] = "Orta, the Broken Mountain",
	["Reshanor"] = "Reshanor, The Untethered",
	
	-- Nerub-ar Palace
	["Sikran"] = "Sikran, Captain of the Sureki",
	["Anum'arash"] = "The Silken Court",
	["Skeinspinner Takazj"] = "The Silken Court",
	["Shattershell Scarab"] = "The Silken Court",
	
	-- Liberation of Undermine
	["The Geargrinder"] = "Vexie and the Geargrinders",
	["Vexie Fullthrottle"] = "Vexie and the Geargrinders",
	["Flarendo the Furious"] = "Cauldron of Carnage",
	["Flarendo"] = "Cauldron of Carnage",
	["Torq the Tempest"] = "Cauldron of Carnage",
	["Torq"] = "Cauldron of Carnage",
	["One-Armed Bandit"] = "The One-Armed Bandit",
	["Mug'Zee"] = "Mug'Zee, Heads of Security",
	
	-- Manaforge Omega
	["Ilyssa Darksorrow"] = "The Soul Hunters",
	["Velaryn Bloodwrath"] = "The Soul Hunters",
	["Adarus Duskblaze"] = "The Soul Hunters",
	["Dimensius"] = "Dimensius, the All-Devouring",
	
	-- Midnight World Bosses
	["Belo'ren"] = "Belo'ren, Child of Al'ar",
	["L'ura"] = "Midnight Falls",
	["Midnight Crystal"] = "Midnight Falls",
	["Dusk Crystal"] = "Midnight Falls",
	["Dawn Crystal"] = "Midnight Falls",
	
	-- The Dreamrift
	["chimaerus"] = "Chimaerus the Undreamt God",
	
	-- The Voidspire
	["Vaelgor"] = "Vaelgor & Ezzorak",
	["Ezzorak"] = "Vaelgor & Ezzorak",
	["War Champion Senn"] = "Lightblinded Vanguard",
	["General Amias Bellamy"] = "Lightblinded Vanguard",
	["Command Venel Lightblood"] = "Lightblinded Vanguard",
	["Alleria Windrunner"] = "Crown of the Cosmos",
}


-- Modules\Database.lua
-- Handles SavedVariables and database operations
local Database = {}
LSS.db = Database

-- Default database structure
local defaults = {
	version = 1,
	perDifficulty = false,
	afterLootSpec = 0, -- 0 = none, -1 = current spec, >0 = specific spec ID
	globalSilence = false,
	debugMode = false,
	disabled = false,
	minimized = true,
	specPerBoss = {
		allDifficulties = {},
		-- Per-difficulty tables will be created as needed: [difficultyID] = {}
	},
}

-- Initialize database
function Database:Initialize()
	if type(LSSDB) ~= "table" then
		LSSDB = {}
	end
	
	self.data = LSSDB
	
	-- Apply defaults for missing values
	for key, value in pairs(defaults) do
		if self.data[key] == nil then
			if type(value) == "table" then
				self.data[key] = self:DeepCopy(value)
			else
				self.data[key] = value
			end
		end
	end
	
	-- Clean up old data structures from previous versions
	self:CleanupOldData()
	
	LSS:Debug("Database initialized (version %d)", self.data.version)
end

-- Deep copy a table
function Database:DeepCopy(orig)
	local copy
	if type(orig) == "table" then
		copy = {}
		for k, v in pairs(orig) do
			copy[k] = self:DeepCopy(v)
		end
	else
		copy = orig
	end
	return copy
end

-- Clean up old SavedVariables from previous addon versions
function Database:CleanupOldData()
	local oldKeys = {
		"bossNameToSpecMapping",
		"bossNameToSpecMapping_L",
		"bossNameToSpecMapping_N",
		"bossNameToSpecMapping_H",
		"bossNameToSpecMapping_M",
		"specToSwitchToAfterLooting",
	}
	
	for _, key in ipairs(oldKeys) do
		if self.data[key] ~= nil then
			self.data[key] = nil
			LSS:Debug("Removed old database key: %s", key)
		end
	end
end

-- Get spec for a boss
function Database:GetBossSpec(instanceID, bossName, difficulty)
	if not instanceID or not bossName then
		return nil
	end
	
	if self.data.perDifficulty and difficulty then
		if self.data.specPerBoss[difficulty] and 
		   self.data.specPerBoss[difficulty][instanceID] then
			return self.data.specPerBoss[difficulty][instanceID][bossName]
		end
	else
		if self.data.specPerBoss.allDifficulties[instanceID] then
			return self.data.specPerBoss.allDifficulties[instanceID][bossName]
		end
	end
	
	return nil
end

-- Set spec for a boss
function Database:SetBossSpec(instanceID, bossName, specID, difficulty)
	if not instanceID or not bossName or not specID then
		return false
	end
	
	if self.data.perDifficulty and difficulty then
		-- Ensure structure exists
		if not self.data.specPerBoss[difficulty] then
			self.data.specPerBoss[difficulty] = {}
		end
		if not self.data.specPerBoss[difficulty][instanceID] then
			self.data.specPerBoss[difficulty][instanceID] = {}
		end
		
		self.data.specPerBoss[difficulty][instanceID][bossName] = specID
	else
		-- Ensure structure exists
		if not self.data.specPerBoss.allDifficulties[instanceID] then
			self.data.specPerBoss.allDifficulties[instanceID] = {}
		end
		
		self.data.specPerBoss.allDifficulties[instanceID][bossName] = specID
	end
	
	return true
end

-- Remove spec for a boss
function Database:RemoveBossSpec(instanceID, bossName, difficulty)
	if not instanceID or not bossName then
		return false
	end
	
	if self.data.perDifficulty and difficulty then
		if self.data.specPerBoss[difficulty] and 
		   self.data.specPerBoss[difficulty][instanceID] then
			self.data.specPerBoss[difficulty][instanceID][bossName] = nil
			return true
		end
	else
		if self.data.specPerBoss.allDifficulties[instanceID] then
			self.data.specPerBoss.allDifficulties[instanceID][bossName] = nil
			return true
		end
	end
	
	return false
end

-- Get all boss specs (for listing)
function Database:GetAllBossSpecs()
	local results = {}
	
	if self.data.perDifficulty then
		for difficulty, instances in pairs(self.data.specPerBoss) do
			if difficulty ~= "allDifficulties" then
				for instanceID, bosses in pairs(instances) do
					for bossName, specID in pairs(bosses) do
						table.insert(results, {
							difficulty = difficulty,
							instanceID = instanceID,
							bossName = bossName,
							specID = specID,
						})
					end
				end
			end
		end
	else
		for instanceID, bosses in pairs(self.data.specPerBoss.allDifficulties) do
			for bossName, specID in pairs(bosses) do
				table.insert(results, {
					difficulty = nil,
					instanceID = instanceID,
					bossName = bossName,
					specID = specID,
				})
			end
		end
	end
	
	return results
end

-- Set default spec
function Database:SetDefaultSpec(specID)
	self.data.afterLootSpec = specID
end

-- Get default spec
function Database:GetDefaultSpec()
	return self.data.afterLootSpec
end

-- Toggle per-difficulty mode
function Database:TogglePerDifficulty()
	self.data.perDifficulty = not self.data.perDifficulty
	return self.data.perDifficulty
end

-- Reset all data
function Database:Reset()
	LSSDB = self:DeepCopy(defaults)
	self.data = LSSDB
end

-- Accessor methods for settings
function Database:IsDisabled()
	return self.data.disabled
end

function Database:SetDisabled(disabled)
	self.data.disabled = disabled
end

function Database:IsMinimized()
	return self.data.minimized
end

function Database:SetMinimized(minimized)
	self.data.minimized = minimized
end

function Database:IsSilenced()
	return self.data.globalSilence
end

function Database:ToggleSilence()
	self.data.globalSilence = not self.data.globalSilence
	return self.data.globalSilence
end

function Database:IsDebugMode()
	return self.data.debugMode
end

function Database:ToggleDebugMode()
	self.data.debugMode = not self.data.debugMode
	return self.data.debugMode
end

function Database:IsPerDifficulty()
	return self.data.perDifficulty
end


-- Modules\SpecManager.lua
-- Handles specialization switching and tracking

local SpecManager = {}
LSS.specManager = SpecManager

-- Local variables
local specCache = {}
local classID
local autoSwapActive = false
local inDefaultSpecAlready = false
local pendingDefaultSpec = nil

-- Initialize spec manager
function SpecManager:Initialize()
	_, _, classID = UnitClass("player")
	self:BuildSpecCache()
	LSS:Debug("SpecManager initialized for class %d", classID)
end

-- Build cache of available specs
function SpecManager:BuildSpecCache()
	specCache = {}
	local numSpecs = GetNumSpecializations()
	
	for i = 1, numSpecs do
		local specID, specName, _, icon = GetSpecializationInfoForClassID(classID, i)
		specCache[specID] = {
			id = specID,
			name = specName,
			icon = icon,
			index = i,
		}
	end
	
	LSS:Debug("Built spec cache with %d specializations", numSpecs)
end

-- Get spec info by ID
function SpecManager:GetSpecInfo(specID)
	-- First check cache
	if specCache[specID] then
		return specCache[specID]
	end
	
	-- If not in cache, get it directly (for loot spec IDs)
	local id, name, description, icon = GetSpecializationInfoByID(specID)
	if id then
		local info = {
			id = id,
			name = name,
			icon = icon,
			index = nil,
		}
		-- Cache it for future use
		specCache[specID] = info
		return info
	end
	
	return nil
end

-- Get all available specs
function SpecManager:GetAllSpecs()
	local specs = {}
	for _, spec in pairs(specCache) do
		table.insert(specs, spec)
	end
	
	-- Sort by index
	table.sort(specs, function(a, b) return a.index < b.index end)
	
	return specs
end

-- Get next spec in rotation (for cycling)
function SpecManager:GetNextSpec(currentSpecID)
	local numSpecs = GetNumSpecializations()
	
	if numSpecs == 0 then
		return nil
	end
	
	-- Build list of all spec IDs for this class
	local specIDs = {}
	for i = 1, numSpecs do
		local specID = GetSpecializationInfoForClassID(classID, i)
		table.insert(specIDs, specID)
	end
	
	-- If no current spec, return first spec
	if not currentSpecID then
		return specIDs[1]
	end
	
	-- Find current spec in list
	local currentIndex = nil
	for i, specID in ipairs(specIDs) do
		if specID == currentSpecID then
			currentIndex = i
			break
		end
	end
	
	-- If current spec found, return next (or wrap to first)
	if currentIndex then
		local nextIndex = (currentIndex % numSpecs) + 1
		return specIDs[nextIndex]
	end
	
	-- If current spec not found, return first
	return specIDs[1]
end

-- Get next default spec (includes "Current Spec" and "None" options)
function SpecManager:GetNextDefaultSpec(currentDefault)
	local numSpecs = GetNumSpecializations()
	
	if numSpecs == 0 then
		return nil
	end
	
	-- Build list: -1 (Current Spec), then all spec IDs, then 0 (None)
	local options = {-1} -- Start with "Current Spec"
	
	for i = 1, numSpecs do
		local specID = GetSpecializationInfoForClassID(classID, i)
		table.insert(options, specID)
	end
	
	table.insert(options, 0) -- End with "None"
	
	-- If no current default, return first option
	if not currentDefault then
		return options[1]
	end
	
	-- Find current in list
	local currentIndex = nil
	for i, option in ipairs(options) do
		if option == currentDefault then
			currentIndex = i
			break
		end
	end
	
	-- Return next (or wrap to first)
	if currentIndex then
		local nextIndex = (currentIndex % #options) + 1
		return options[nextIndex]
	end
	
	-- Default to first option
	return options[1]
end

-- Switch to a specific spec
function SpecManager:SwitchToSpec(specID)
	local currentSpec = GetLootSpecialization()
	
	if currentSpec == specID then
		LSS:Debug("已经使用%d专精，无需切换", specID)
		return false
	end
	
	if specID == -1 then
		-- 特殊情况：切换到当前实际专精
		SetLootSpecialization(0)
		LSS:Print("拾取专精已更改为当前专精")
		return true
	elseif specID == 0 then
		-- 无专精设置
		SetLootSpecialization(0)
		return true
	else
		local specInfo = self:GetSpecInfo(specID)
		if specInfo then
			SetLootSpecialization(specID)
			LSS:Print("拾取专精已更改为 |cff00ff00%s|r", specInfo.name)
			return true
		else
			LSS:Error("无效的专精ID: %d", specID)
			return false
		end
	end
end

-- Handle target change
function SpecManager:OnTargetChanged()
	if LSS.db:IsDisabled() then
		return
	end
	
	if not UnitIsDead("target") then
		local targetName = UnitName("target")
		if not targetName or issecretvalue(targetName) then
			return
		end
		
		-- Get instance and boss information
		local mapID = C_Map.GetBestMapForUnit("player")
		if not mapID then
			return
		end
		
		local instanceID = EJ_GetInstanceForMap(mapID)
		if not instanceID then
			return
		end
		
		-- Apply boss name fixes
		local originalName = targetName
		local fixedName = LSS.BossFixes[targetName] or targetName
		
		-- Special case for General Kaal in Castle Nathria
		if targetName == "General Kaal" and instanceID == 1189 then
			fixedName = targetName
		end
		
		LSS:Debug("Target: %s (Fixed: %s, Instance: %d)", originalName, fixedName, instanceID)
		
		-- Get the spec for this boss
		local difficulty = select(3, GetInstanceInfo())
		local specID = LSS.db:GetBossSpec(instanceID, fixedName, difficulty)
		
		if specID then
			LSS:Debug("Found spec %d for boss %s", specID, fixedName)
			self:SwitchToSpec(specID)
			autoSwapActive = true
			inDefaultSpecAlready = false
		else
			LSS:Debug("No spec configured for boss: %s", fixedName)
		end
	end
end

-- Handle loot closed (restore default spec)
function SpecManager:OnLootClosed()
	if LSS.db:IsDisabled() then
		return
	end
	
	if autoSwapActive and not inDefaultSpecAlready then
		autoSwapActive = false
		local defaultSpec = LSS.db:GetDefaultSpec()
		
		if defaultSpec ~= 0 then
			-- Check if bonus roll window is visible
			if GroupLootContainer and GroupLootContainer:IsVisible() then
				-- Defer spec change until after bonus roll
				pendingDefaultSpec = defaultSpec
				LSS:Debug("Bonus roll window visible, deferring default spec change")
			else
				self:SwitchToSpec(defaultSpec)
				inDefaultSpecAlready = true
			end
		end
	end
end

-- Handle bonus roll completion
function SpecManager:OnBonusRollComplete()
	if pendingDefaultSpec then
		self:SwitchToSpec(pendingDefaultSpec)
		pendingDefaultSpec = nil
		inDefaultSpecAlready = true
	end
end

-- Get current loot spec
function SpecManager:GetCurrentLootSpec()
	return GetLootSpecialization()
end

-- Get spec name from ID
function SpecManager:GetSpecName(specID)
	if specID == 0 then
		return "None"
	elseif specID == -1 then
		return "Current Spec"
	else
		-- Use GetSpecializationInfoByID directly, which works with loot spec IDs
		local _, name = GetSpecializationInfoByID(specID)
		return name or "Unknown"
	end
end


-- Modules\EventHandler.lua
-- Handles game events

local EventHandler = {}
LSS.eventHandler = EventHandler

local frame

-- Initialize event handler immediately
frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(_, event, ...)
	EventHandler:OnEvent(event, ...)
end)

-- Register events
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

-- Initialize event handler
function EventHandler:Initialize()
	-- Events already registered at module load
end

-- Event dispatcher
function EventHandler:OnEvent(event, ...)
	local handler = self[event]
	if handler then
		handler(self, ...)
	end
end

-- ADDON_LOADED event
function EventHandler:ADDON_LOADED(addonName)
	if addonName == "OrzUI" then
		-- Initialize database
		if LSS.db and LSS.db.Initialize then
			LSS.db:Initialize()
		end
		
		-- Initialize spec manager
		if LSS.specManager and LSS.specManager.Initialize then
			LSS.specManager:Initialize()
		end
		
		-- Initialize slash commands
		if LSS.commands and LSS.commands.Initialize then
			LSS.commands:Initialize()
		end
		
		-- Initialize config panel
		if LSS.config and LSS.config.Initialize then
			LSS.config:Initialize()
		end
		
		--LSS:Print("Loaded v%s", LSS.version or "unknown")
		
	elseif addonName == "Blizzard_EncounterJournal" then
		-- Initialize UI when Encounter Journal loads
		if LSS.ui and LSS.ui.Initialize then
			LSS.ui:Initialize()
		end
		LSS:Debug("Encounter Journal loaded, UI initialized")
	end
end

-- PLAYER_LOGIN event
function EventHandler:PLAYER_LOGIN()
	-- Register combat events
	frame:RegisterEvent("PLAYER_TARGET_CHANGED")
	frame:RegisterEvent("LOOT_CLOSED")
	
	LSS:Debug("Player logged in, combat events registered")
end

-- PLAYER_TARGET_CHANGED event
function EventHandler:PLAYER_TARGET_CHANGED()
	LSS.specManager:OnTargetChanged()
end

-- LOOT_CLOSED event
function EventHandler:LOOT_CLOSED()
	LSS.specManager:OnLootClosed()
end


-- Modules\Commands.lua
-- Handles slash commands

local Commands = {}
LSS.commands = Commands

-- Command handlers
local commandHandlers = {}

-- /lss toggle - 启用/禁用插件
commandHandlers.toggle = function()
	local disabled = LSS.db:IsDisabled()
	LSS.db:SetDisabled(not disabled)
	
	if LSS.db:IsDisabled() then
		LSS:Print("插件 |cffff0000已禁用|r")
		if LSS.ui and LSS.ui.Hide then
			LSS.ui:Hide()
		end
	else
		LSS:Print("插件 |cff00ff00已启用|r")
		if LSS.ui and LSS.ui.Show then
			LSS.ui:Show()
		end
	end
end

-- /lss quiet - 切换消息静音
commandHandlers.quiet = function()
	local silenced = LSS.db:ToggleSilence()
	
	if not silenced then
		-- 只有在取消静音时才打印
		LSS:Print("消息 |cff00ff00已启用|r")
	end
end

-- /lss debug - 切换调试模式
commandHandlers.debug = function()
	local debug = LSS.db:ToggleDebugMode()
	LSS:Print("调试模式: |cff00ff00%s|r", debug and "开启" or "关闭")
end

-- /lss diff - 切换按难度设置模式
commandHandlers.diff = function()
	local perDiff = LSS.db:TogglePerDifficulty()
	LSS:Print("按难度设置模式: |cff00ff00%s|r", perDiff and "开启" or "关闭")
end

-- /lss list - 列出所有配置的专精
commandHandlers.list = function()
	LSS:Print("=== 拾取专精配置 ===")
	
	local specs = LSS.db:GetAllBossSpecs()
	
	if #specs == 0 then
		LSS:Print("尚未配置任何首领专精。")
	else
		for _, entry in ipairs(specs) do
			local diffName = entry.difficulty and LSS.DIFFICULTY_NAMES[entry.difficulty] or "所有难度"
			local specName = LSS.specManager:GetSpecName(entry.specID)
			
			LSS:Print("%s - 副本 %d - %s: |cff00ff00%s|r", 
				diffName, entry.instanceID, entry.bossName, specName)
		end
	end
	
	-- 显示默认专精
	local defaultSpec = LSS.db:GetDefaultSpec()
	local defaultName = LSS.specManager:GetSpecName(defaultSpec)
	LSS:Print("默认专精 (拾取后): |cff00ff00%s|r", defaultName)
end

-- /lss setspecafter - 将默认专精设置为当前拾取专精
commandHandlers.setspecafter = function()
	local currentSpec = GetLootSpecialization()
	
	if currentSpec == 0 then
		LSS.db:SetDefaultSpec(-1)
		LSS:Print("默认专精已设置为 |cff00ff00当前专精|r")
	else
		LSS.db:SetDefaultSpec(currentSpec)
		local specName = LSS.specManager:GetSpecName(currentSpec)
		LSS:Print("默认专精已设置为 |cff00ff00%s|r", specName)
	end
end

-- /lss setactualafter - 将默认专精设置为当前实际专精
commandHandlers.setactualafter = function()
	LSS.db:SetDefaultSpec(-1)
	LSS:Print("默认专精已设置为 |cff00ff00当前专精|r")
end

-- /lss forgetdefault - 清除默认专精
commandHandlers.forgetdefault = function()
	LSS.db:SetDefaultSpec(0)
	LSS:Print("默认专精已清除")
end

-- /lss reset - 重置所有设置
commandHandlers.reset = function()
	LSS:Print("|cffff0000警告:|r 这将重置所有设置。请输入 |cffff8800/lss confirmreset|r 确认。")
end

commandHandlers.confirmreset = function()
	LSS:Print("正在重置所有设置...")
	LSS.db:Reset()
	ReloadUI()
end

-- /lss help 或未知命令
commandHandlers.help = function()
	LSS:Print("=== 拾取专精切换命令 ===")
	LSS:Print("|cffff8800/lss toggle|r - 启用/禁用插件")
	LSS:Print("|cffff8800/lss quiet|r - 切换聊天消息")
	LSS:Print("|cffff8800/lss debug|r - 切换调试模式")
	LSS:Print("|cffff8800/lss diff|r - 切换按难度设置")
	LSS:Print("|cffff8800/lss list|r - 列出所有配置的专精")
	LSS:Print("|cffff8800/lss setspecafter|r - 设置默认专精 (拾取后)")
	LSS:Print("|cffff8800/lss setactualafter|r - 设置默认专精为当前专精")
	LSS:Print("|cffff8800/lss forgetdefault|r - 清除默认专精")
	LSS:Print("|cffff8800/lss reset|r - 重置所有设置")
	LSS:Print("使用地下城手册界面配置首领专精")
end

-- Main command handler
function Commands:HandleCommand(input)
	local command = string.lower(input or "")
	
	-- Remove leading/trailing whitespace
	command = strtrim(command)
	
	-- Get the handler
	local handler = commandHandlers[command]
	
	if handler then
		handler()
	else
		commandHandlers.help()
	end
end

-- Initialize slash commands
function Commands:Initialize()
	SLASH_LOOTSPECSWAPPER1 = "/lootspecswapper"
	SLASH_LOOTSPECSWAPPER2 = "/lss"
	
	SlashCmdList["LOOTSPECSWAPPER"] = function(msg)
		Commands:HandleCommand(msg)
	end
	
	LSS:Debug("Slash commands initialized")
end


-- Modules\UI.lua
-- Handles UI integration with Encounter Journal

local UI = {}
LSS.ui = UI

-- UI Elements
local mainFrame
local bossButton
local defaultButton
local minimizeButton

-- Initialize UI
function UI:Initialize()
	self:CreateMainFrame()
	self:CreateButtons()
	self:SetupMinimizeButton()
	
	-- Start minimized when journal opens
	self:Minimize()
	
	LSS:Debug("UI initialized")
end

-- Create main frame
function UI:CreateMainFrame()
	-- Create backdrop template mixin check for compatibility
	local backdropTemplate = BackdropTemplateMixin and "BackdropTemplate" or nil
	
	mainFrame = CreateFrame("Frame", "LSSMainFrame", EncounterJournal, backdropTemplate)
	mainFrame:SetSize(220, 260)
	mainFrame:SetPoint("TOP", EncounterJournal, "TOP", 650, 0)
	
	-- Backdrop
	mainFrame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = {left = 11, right = 12, top = 12, bottom = 11},
	})
	mainFrame:SetBackdropColor(0, 0, 0, 1)
	
	-- Make it movable
	mainFrame:SetFrameStrata("HIGH")
	mainFrame:SetToplevel(true)
	mainFrame:EnableMouse(true)
	mainFrame:SetMovable(true)
	mainFrame:RegisterForDrag("LeftButton")
	mainFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	mainFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	
	-- Title bar
	local titleBar = CreateFrame("Frame", nil, mainFrame)
	titleBar:SetSize(185, 40)
	titleBar:SetPoint("TOP", 0, 15)
	titleBar:EnableMouse(true)
	titleBar:RegisterForDrag("LeftButton")
	titleBar:SetScript("OnDragStart", function() mainFrame:StartMoving() end)
	titleBar:SetScript("OnDragStop", function() mainFrame:StopMovingOrSizing() end)
	
	local titleTexture = titleBar:CreateTexture(nil, "BACKGROUND")
	titleTexture:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
	titleTexture:SetPoint("TOPRIGHT", 57, 0)
	titleTexture:SetPoint("BOTTOMLEFT", -58, -24)
	
	local titleText = titleBar:CreateFontString(nil, "OVERLAY")
	titleText:SetFont("Fonts/MORPHEUS.ttf", 15)
	titleText:SetText(LootSpecSwapperLocal)
	titleText:SetPoint("CENTER", 0, 0)
	
	-- Close button
	local closeButton = CreateFrame("Button", nil, mainFrame, "UIPanelCloseButton")
	closeButton:SetPoint("TOPRIGHT", 12, 12)
	closeButton:SetScript("OnClick", function()
		self:Minimize()
	end)
	
	mainFrame:Hide()
end

-- 创建首领和默认专精按钮
function UI:CreateButtons()
	-- 首领专精按钮
	bossButton = CreateFrame("Button", "LSSBossButton", mainFrame, "UIPanelButtonTemplate")
	bossButton:SetSize(80, 80)
	bossButton:SetPoint("TOP", mainFrame, "TOP", 0, -25)
	bossButton:SetText("<无>")
	bossButton:RegisterForClicks("AnyDown")
	
	bossButton:SetScript("OnClick", function(self, button)
		UI:OnBossButtonClick(button)
	end)
	
	local bossDesc = bossButton:CreateFontString(nil, "OVERLAY")
	bossDesc:SetFont("Fonts/FRIZQT__.TTF", 10)
	bossDesc:SetText("首领: <未选择>\n左键: 切换, 右键: 清除")
	bossDesc:SetPoint("BOTTOM", bossButton, "BOTTOM", 0, -20)
	bossButton.desc = bossDesc
	
	-- 默认专精按钮
	defaultButton = CreateFrame("Button", "LSSDefaultButton", mainFrame, "UIPanelButtonTemplate")
	defaultButton:SetSize(80, 80)
	defaultButton:SetPoint("TOP", mainFrame, "TOP", 0, -135)
	defaultButton:RegisterForClicks("AnyDown")
	
	defaultButton:SetScript("OnClick", function(self, button)
		UI:OnDefaultButtonClick(button)
	end)
	
	local defaultDesc = defaultButton:CreateFontString(nil, "OVERLAY")
	defaultDesc:SetFont("Fonts/FRIZQT__.TTF", 10)
	defaultDesc:SetText("默认 (拾取后切换回来):\n左键: 保存, 右键: 清除\n(使用头像菜单选择...)")
	defaultDesc:SetPoint("BOTTOM", defaultButton, "BOTTOM", 0, -20)
	defaultButton.desc = defaultDesc
	
	-- 在框架显示时和定期更新按钮
	mainFrame:SetScript("OnUpdate", function()
		self:UpdateButtons()
	end)
end

-- Setup minimize/restore button
function UI:SetupMinimizeButton()
	minimizeButton = CreateFrame("Button", "LSSMinimizeButton", EncounterJournal, "UIPanelButtonTemplate")
	minimizeButton:SetSize(60, 14)
	minimizeButton:SetPoint("TOP", EncounterJournal, "TOP", 340, -4)
	minimizeButton:SetText("LSS>>")
	minimizeButton:SetFrameStrata(EncounterJournalCloseButton:GetFrameStrata())
	minimizeButton:SetFrameLevel(EncounterJournalCloseButton:GetFrameLevel() + 100)
	minimizeButton:Hide()
	
	minimizeButton:SetScript("OnClick", function()
		self:Restore()
	end)
end

-- 更新按钮显示
function UI:UpdateButtons()
	if not mainFrame:IsVisible() then
		return
	end
	
	-- 更新首领按钮
	local encounterID = EncounterJournal.encounterID
	local instanceID = EncounterJournal.instanceID
	
	if encounterID and instanceID then
		local bossName = EJ_GetEncounterInfo(encounterID)
		
		if bossName then
			local difficulty = EJ_GetDifficulty()
			local specID = LSS.db:GetBossSpec(instanceID, bossName, difficulty)
			
			bossButton.desc:SetText(string.format("首领: %s\n左键: 切换, 右键: 清除", bossName))
			self:UpdateButtonIcon(bossButton, specID)
		end
	else
		bossButton.desc:SetText("首领: <未选择>\n左键: 切换, 右键: 清除")
		self:UpdateButtonIcon(bossButton, nil)
	end
	
	-- 更新默认按钮
	local defaultSpec = LSS.db:GetDefaultSpec()
	self:UpdateButtonIcon(defaultButton, defaultSpec)
end

-- 更新按钮图标
function UI:UpdateButtonIcon(button, specID)
	if type(specID) == "number" then
		if specID == 0 then
			-- 无专精
			local normalTexture = button:GetNormalTexture()
			if normalTexture then
				normalTexture:SetTexture(nil)
			end
			button:SetText("<无>")
		elseif specID == -1 then
			-- 当前专精
			local normalTexture = button:GetNormalTexture()
			if normalTexture then
				normalTexture:SetTexture(nil)
			end
			button:SetText("<自动>")
		else
			local specInfo = LSS.specManager:GetSpecInfo(specID)
			if specInfo then
				button:SetNormalTexture(specInfo.icon)
				button:SetText("")
			else
				local normalTexture = button:GetNormalTexture()
				if normalTexture then
					normalTexture:SetTexture(nil)
				end
				button:SetText("???")
			end
		end
	else
		-- nil specID - 清除所有内容
		local normalTexture = button:GetNormalTexture()
		if normalTexture then
			normalTexture:SetTexture(nil)
		end
		button:SetText("<无>")
	end
end

-- 首领按钮点击处理
function UI:OnBossButtonClick(button)
	local encounterID = EncounterJournal.encounterID
	local instanceID = EncounterJournal.instanceID
	
	if not encounterID or not instanceID then
		LSS:Print("请先选择一个首领")
		return
	end
	
	local bossName = EJ_GetEncounterInfo(encounterID)
	if not bossName then
		return
	end
	
	local difficulty = EJ_GetDifficulty()
	
	if button == "RightButton" then
		-- 清除专精
		LSS.db:RemoveBossSpec(instanceID, bossName, difficulty)
		LSS:Print("已清除 |cff00ff00%s|r 的专精", bossName)
	else
		-- 循环切换专精
		local currentSpec = LSS.db:GetBossSpec(instanceID, bossName, difficulty)
		local newSpec = LSS.specManager:GetNextSpec(currentSpec)
		
		if newSpec then
			LSS.db:SetBossSpec(instanceID, bossName, newSpec, difficulty)
			local specName = LSS.specManager:GetSpecName(newSpec)
			LSS:Print("为 %s 设置 |cff00ff00%s|r", bossName, specName)
		else
			LSS:Print("无可用的专精")
		end
	end
end

-- 默认按钮点击处理
function UI:OnDefaultButtonClick(button)
	if button == "RightButton" then
		-- 设置为 "当前专精" (-1)
		LSS.db:SetDefaultSpec(-1)
		LSS:Print("默认专精已设置为 |cff00ff00当前专精|r")
	else
		-- 循环切换专精
		local currentDefault = LSS.db:GetDefaultSpec()
		local newSpec = LSS.specManager:GetNextDefaultSpec(currentDefault)
		
		if newSpec then
			LSS.db:SetDefaultSpec(newSpec)
			local specName = LSS.specManager:GetSpecName(newSpec)
			LSS:Print("默认专精已设置为 |cff00ff00%s|r", specName)
		else
			LSS:Print("无可用的专精")
		end
	end
end

-- 最小化UI
function UI:Minimize()
	if mainFrame then
		mainFrame:Hide()
	end
	if minimizeButton then
		minimizeButton:Show()
	end
	LSS.db:SetMinimized(true)
end

-- 恢复UI
function UI:Restore()
	if mainFrame then
		mainFrame:Show()
	end
	if minimizeButton then
		minimizeButton:Hide()
	end
	LSS.db:SetMinimized(false)
end

-- 显示UI
function UI:Show()
	if LSS.db:IsMinimized() then
		minimizeButton:Show()
	else
		mainFrame:Show()
	end
end

-- 隐藏UI
function UI:Hide()
	if mainFrame then
		mainFrame:Hide()
	end
	if minimizeButton then
		minimizeButton:Hide()
	end
end


-- Modules\Config.lua
-- Settings panel for interface options

local Config = {}
LSS.config = Config

-- Create settings panel
function Config:CreatePanel()
	local panel = CreateFrame("Frame", "LSSConfigPanel")
	panel.name = LootSpecSwapperLocal
	
	-- Check WoW version for settings API
	local buildInfo = {GetBuildInfo()}
	local isRetail = buildInfo[4] >= 110000
	
	if isRetail then
		-- Modern settings API (11.0+)
		local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
		Settings.RegisterAddOnCategory(category)
	else
		-- Legacy interface options
		InterfaceOptions_AddCategory(panel)
	end
	
	-- Create UI elements
	self:CreateTitle(panel)
	self:CreateOptions(panel)
	self:CreateSpecOptions(panel)
	self:CreateOtherOptions(panel)
	
	LSS:Debug("Config panel created")
end

-- Create title
function Config:CreateTitle(parent)
	local title = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(LootSpecSwapperLocal)
	
	local version = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	version:SetPoint("BOTTOMLEFT", title, "BOTTOMRIGHT", 8, 0)
	version:SetText(LSS.version)
	
	local author = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	author:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -16, -24)
	author:SetText("Author: " .. LSS.author)
	
	return title
end

-- 创建主要选项
function Config:CreateOptions(parent)
	local lastCheckbox
	
	-- 部分标签
	local label = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	label:SetPoint("TOPLEFT", 16, -60)
	label:SetText("选项")
	
	-- 禁用复选框
	local disableCheck = self:CreateCheckbox(parent, "禁用插件")
	disableCheck:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 20, -5)
	disableCheck:SetChecked(LSS.db:IsDisabled())
	disableCheck:SetScript("OnClick", function(self)
		LSS.commands.HandleCommand(LSS.commands, "toggle")
		self:SetChecked(LSS.db:IsDisabled())
	end)
	lastCheckbox = disableCheck
	
	-- 按难度设置复选框
	local diffCheck = self:CreateCheckbox(parent, "启用按难度设置")
	diffCheck:SetPoint("TOPLEFT", lastCheckbox, "BOTTOMLEFT", 0, -5)
	diffCheck:SetChecked(LSS.db:IsPerDifficulty())
	diffCheck:SetScript("OnClick", function(self)
		LSS.commands.HandleCommand(LSS.commands, "diff")
		self:SetChecked(LSS.db:IsPerDifficulty())
	end)
	lastCheckbox = diffCheck
	
	-- 消息静音复选框
	local silenceCheck = self:CreateCheckbox(parent, "禁用插件消息")
	silenceCheck:SetPoint("TOPLEFT", lastCheckbox, "BOTTOMLEFT", 0, -5)
	silenceCheck:SetChecked(LSS.db:IsSilenced())
	silenceCheck:SetScript("OnClick", function(self)
		LSS.commands.HandleCommand(LSS.commands, "quiet")
		self:SetChecked(LSS.db:IsSilenced())
	end)
	lastCheckbox = silenceCheck
	
	-- 调试模式复选框
	local debugCheck = self:CreateCheckbox(parent, "启用调试模式")
	debugCheck:SetPoint("TOPLEFT", lastCheckbox, "BOTTOMLEFT", 0, -5)
	debugCheck:SetChecked(LSS.db:IsDebugMode())
	debugCheck:SetScript("OnClick", function(self)
		LSS.commands.HandleCommand(LSS.commands, "debug")
		self:SetChecked(LSS.db:IsDebugMode())
	end)
	
	return label
end

-- 创建专精选项
function Config:CreateSpecOptions(parent)
	local label = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	label:SetPoint("TOPLEFT", 16, -200)
	label:SetText("专精选项")
	
	-- 清除默认专精按钮
	local forgetBtn = self:CreateButton(parent, "清除默认专精", 150, 24)
	forgetBtn:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 20, -5)
	forgetBtn:SetScript("OnClick", function()
		LSS.commands.HandleCommand(LSS.commands, "forgetdefault")
	end)
	
	-- 设置默认专精为拾取专精按钮
	local setLootBtn = self:CreateButton(parent, "默认 - 拾取", 150, 24)
	setLootBtn:SetPoint("LEFT", forgetBtn, "RIGHT", 10, 0)
	setLootBtn:SetScript("OnClick", function()
		LSS.commands.HandleCommand(LSS.commands, "setspecafter")
	end)
	
	-- 设置默认专精为实际专精按钮
	local setActualBtn = self:CreateButton(parent, "默认 - 实际", 150, 24)
	setActualBtn:SetPoint("LEFT", setLootBtn, "RIGHT", 10, 0)
	setActualBtn:SetScript("OnClick", function()
		LSS.commands.HandleCommand(LSS.commands, "setactualafter")
	end)
end

-- 创建其他选项
function Config:CreateOtherOptions(parent)
	local label = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	label:SetPoint("TOPLEFT", 16, -280)
	label:SetText("其他选项")
	
	-- 列出选择按钮
	local listBtn = self:CreateButton(parent, "列出选择", 150, 24)
	listBtn:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 20, -5)
	listBtn:SetScript("OnClick", function()
		LSS.commands.HandleCommand(LSS.commands, "list")
	end)
	
	-- 重置按钮
	local resetBtn = self:CreateButton(parent, "重置 LSS", 150, 24)
	resetBtn:SetPoint("TOPLEFT", listBtn, "BOTTOMLEFT", 0, -100)
	resetBtn:SetScript("OnClick", function()
		LSS.commands.HandleCommand(LSS.commands, "reset")
	end)
end

-- Helper: Create checkbox
function Config:CreateCheckbox(parent, text)
	local checkbox = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
	
	local label = checkbox:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	label:SetPoint("LEFT", checkbox, "RIGHT", 0, 0)
	label:SetText(text)
	checkbox.label = label
	
	checkbox:SetScript("OnClick", function(self)
		if self:GetChecked() then
			PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
		else
			PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
		end
	end)
	
	return checkbox
end

-- Helper: Create button
function Config:CreateButton(parent, text, width, height)
	local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	button:SetSize(width, height)
	button:SetText(text)
	return button
end

-- Initialize config
function Config:Initialize()
	self:CreatePanel()
end