local ACEDB_MAJOR, ACEDB_MINOR = "AceDB-3.0", 27
local AceDB = LibStub:NewLibrary(ACEDB_MAJOR, ACEDB_MINOR)

if not AceDB then return end -- No upgrade needed

-- Lua APIs
local type, pairs, next, error = type, pairs, next, error
local setmetatable, rawset, rawget = setmetatable, rawset, rawget

-- WoW APIs
local _G = _G

AceDB.db_registry = AceDB.db_registry or {}
AceDB.frame = AceDB.frame or CreateFrame("Frame")

local CallbackHandler
local CallbackDummy = { Fire = function() end }

local DBObjectLib = {}

--[[-------------------------------------------------------------------------
	AceDB Utility Functions
---------------------------------------------------------------------------]]

-- Simple shallow copy for copying defaults
local function copyTable(src, dest)
	if type(dest) ~= "table" then dest = {} end
	if type(src) == "table" then
		for k,v in pairs(src) do
			if type(v) == "table" then
				-- try to index the key first so that the metatable creates the defaults, if set, and use that table
				v = copyTable(v, dest[k])
			end
			dest[k] = v
		end
	end
	return dest
end

local function copyDefaults(dest, src)
	for k, v in pairs(src) do
		if k == "*" or k == "**" then
			if type(v) == "table" then
				-- This is a metatable used for table defaults
				local mt = {
					-- This handles the lookup and creation of new subtables
					__index = function(t,k)
							if k == nil then return nil end
							local tbl = {}
							copyDefaults(tbl, v)
							rawset(t, k, tbl)
							return tbl
						end,
				}
				setmetatable(dest, mt)
				-- handle already existing tables in the SV
				for dk, dv in pairs(dest) do
					if not rawget(src, dk) and type(dv) == "table" then
						copyDefaults(dv, v)
					end
				end
			else
				-- Values are not tables, so this is just a simple return
				local mt = {__index = function(t,k) return k~=nil and v or nil end}
				setmetatable(dest, mt)
			end
		elseif type(v) == "table" then
			if not rawget(dest, k) then rawset(dest, k, {}) end
			if type(dest[k]) == "table" then
				copyDefaults(dest[k], v)
				if src['**'] then
					copyDefaults(dest[k], src['**'])
				end
			end
		else
			if rawget(dest, k) == nil then
				rawset(dest, k, v)
			end
		end
	end
end

-- Called to remove all defaults in the default table from the database
local function removeDefaults(db, defaults, blocker)
	-- remove all metatables from the db, so we don't accidentally create new sub-tables through them
	setmetatable(db, nil)
	-- loop through the defaults and remove their content
	for k,v in pairs(defaults) do
		if k == "*" or k == "**" then
			if type(v) == "table" then
				-- Loop through all the actual k,v pairs and remove
				for key, value in pairs(db) do
					if type(value) == "table" then
						-- if the key was not explicitly specified in the defaults table, just strip everything from * and ** tables
						if defaults[key] == nil and (not blocker or blocker[key] == nil) then
							removeDefaults(value, v)
							-- if the table is empty afterwards, remove it
							if next(value) == nil then
								db[key] = nil
							end
						-- if it was specified, only strip ** content, but block values which were set in the key table
						elseif k == "**" then
							removeDefaults(value, v, defaults[key])
						end
					end
				end
			elseif k == "*" then
				-- check for non-table default
				for key, value in pairs(db) do
					if defaults[key] == nil and v == value then
						db[key] = nil
					end
				end
			end
		elseif type(v) == "table" and type(db[k]) == "table" then
			-- if a blocker was set, dive into it, to allow multi-level defaults
			removeDefaults(db[k], v, blocker and blocker[k])
			if next(db[k]) == nil then
				db[k] = nil
			end
		else
			-- check if the current value matches the default, and that its not blocked by another defaults table
			if db[k] == defaults[k] and (not blocker or blocker[k] == nil) then
				db[k] = nil
			end
		end
	end
end

-- This is called when a table section is first accessed, to set up the defaults
local function initSection(db, section, svstore, key, defaults)
	local sv = rawget(db, "sv")

	local tableCreated
	if not sv[svstore] then sv[svstore] = {} end
	if not sv[svstore][key] then
		sv[svstore][key] = {}
		tableCreated = true
	end

	local tbl = sv[svstore][key]

	if defaults then
		copyDefaults(tbl, defaults)
	end
	rawset(db, section, tbl)

	return tableCreated, tbl
end

-- Metatable to handle the dynamic creation of sections and copying of sections.
local dbmt = {
	__index = function(t, section)
			local keys = rawget(t, "keys")
			local key = keys[section]
			if key then
				local defaultTbl = rawget(t, "defaults")
				local defaults = defaultTbl and defaultTbl[section]

				if section == "profile" then
					local new = initSection(t, section, "profiles", key, defaults)
					if new then
						-- Callback: OnNewProfile, database, newProfileKey
						t.callbacks:Fire("OnNewProfile", t, key)
					end
				elseif section == "profiles" then
					local sv = rawget(t, "sv")
					if not sv.profiles then sv.profiles = {} end
					rawset(t, "profiles", sv.profiles)
				elseif section == "global" then
					local sv = rawget(t, "sv")
					if not sv.global then sv.global = {} end
					if defaults then
						copyDefaults(sv.global, defaults)
					end
					rawset(t, section, sv.global)
				else
					initSection(t, section, section, key, defaults)
				end
			end

			return rawget(t, section)
		end
}

local function validateDefaults(defaults, keyTbl, offset)
	if not defaults then return end
	offset = offset or 0
	for k in pairs(defaults) do
		if not keyTbl[k] or k == "profiles" then
			error(("Usage: AceDBObject:RegisterDefaults(defaults): '%s' is not a valid datatype."):format(k), 3 + offset)
		end
	end
end

local preserve_keys = {
	["callbacks"] = true,
	["RegisterCallback"] = true,
	["UnregisterCallback"] = true,
	["UnregisterAllCallbacks"] = true,
	["children"] = true,
}

local realmKey = GetRealmName()
local charKey = UnitName("player") .. " - " .. realmKey
local _, classKey = UnitClass("player")
local _, raceKey = UnitRace("player")
local factionKey = UnitFactionGroup("player")
local factionrealmKey = factionKey .. " - " .. realmKey
local localeKey = GetLocale():lower()

local regionTable = { "US", "KR", "EU", "TW", "CN" }
local regionKey = regionTable[GetCurrentRegion()]
local factionrealmregionKey = factionrealmKey .. " - " .. regionKey

-- Actual database initialization function
local function initdb(sv, defaults, defaultProfile, olddb, parent)
	-- Generate the database keys for each section

	-- map "true" to our "Default" profile
	if defaultProfile == true then defaultProfile = "Default" end

	local profileKey
	if not parent then
		-- Make a container for profile keys
		if not sv.profileKeys then sv.profileKeys = {} end

		-- Try to get the profile selected from the char db
		profileKey = sv.profileKeys[charKey] or defaultProfile or charKey

		-- save the selected profile for later
		sv.profileKeys[charKey] = profileKey
	else
		-- Use the profile of the parents DB
		profileKey = parent.keys.profile or defaultProfile or charKey

		-- clear the profileKeys in the DB, namespaces don't need to store them
		sv.profileKeys = nil
	end

	-- This table contains keys that enable the dynamic creation
	-- of each section of the table.  The 'global' and 'profiles'
	-- have a key of true, since they are handled in a special case
	local keyTbl= {
		["char"] = charKey,
		["realm"] = realmKey,
		["class"] = classKey,
		["race"] = raceKey,
		["faction"] = factionKey,
		["factionrealm"] = factionrealmKey,
		["factionrealmregion"] = factionrealmregionKey,
		["profile"] = profileKey,
		["locale"] = localeKey,
		["global"] = true,
		["profiles"] = true,
	}

	validateDefaults(defaults, keyTbl, 1)

	-- This allows us to use this function to reset an entire database
	-- Clear out the old database
	if olddb then
		for k,v in pairs(olddb) do if not preserve_keys[k] then olddb[k] = nil end end
	end

	-- Give this database the metatable so it initializes dynamically
	local db = setmetatable(olddb or {}, dbmt)

	if not rawget(db, "callbacks") then
		-- try to load CallbackHandler-1.0 if it loaded after our library
		if not CallbackHandler then CallbackHandler = LibStub:GetLibrary("CallbackHandler-1.0", true) end
		db.callbacks = CallbackHandler and CallbackHandler:New(db) or CallbackDummy
	end

	-- Copy methods locally into the database object, to avoid hitting
	-- the metatable when calling methods

	if not parent then
		for name, func in pairs(DBObjectLib) do
			db[name] = func
		end
	else
		-- hack this one in
		db.RegisterDefaults = DBObjectLib.RegisterDefaults
		db.ResetProfile = DBObjectLib.ResetProfile
	end

	-- Set some properties in the database object
	db.profiles = sv.profiles
	db.keys = keyTbl
	db.sv = sv
	--db.sv_name = name
	db.defaults = defaults
	db.parent = parent

	-- store the DB in the registry
	AceDB.db_registry[db] = true

	return db
end

local function logoutHandler(frame, event)
	if event == "PLAYER_LOGOUT" then
		for db in pairs(AceDB.db_registry) do
			db.callbacks:Fire("OnDatabaseShutdown", db)
			db:RegisterDefaults(nil)

			-- cleanup sections that are empty without defaults
			local sv = rawget(db, "sv")
			for section in pairs(db.keys) do
				if rawget(sv, section) then
					-- global is special, all other sections have sub-entrys
					-- also don't delete empty profiles on main dbs, only on namespaces
					if section ~= "global" and (section ~= "profiles" or rawget(db, "parent")) then
						for key in pairs(sv[section]) do
							if not next(sv[section][key]) then
								sv[section][key] = nil
							end
						end
					end
					if not next(sv[section]) then
						sv[section] = nil
					end
				end
			end
		end
	end
end

AceDB.frame:RegisterEvent("PLAYER_LOGOUT")
AceDB.frame:SetScript("OnEvent", logoutHandler)

function DBObjectLib:RegisterDefaults(defaults)
	if defaults and type(defaults) ~= "table" then
		error(("Usage: AceDBObject:RegisterDefaults(defaults): 'defaults' - table or nil expected, got %q."):format(type(defaults)), 2)
	end

	validateDefaults(defaults, self.keys)

	-- Remove any currently set defaults
	if self.defaults then
		for section,key in pairs(self.keys) do
			if self.defaults[section] and rawget(self, section) then
				removeDefaults(self[section], self.defaults[section])
			end
		end
	end

	-- Set the DBObject.defaults table
	self.defaults = defaults

	-- Copy in any defaults, only touching those sections already created
	if defaults then
		for section,key in pairs(self.keys) do
			if defaults[section] and rawget(self, section) then
				copyDefaults(self[section], defaults[section])
			end
		end
	end
end

function DBObjectLib:SetProfile(name)
	if type(name) ~= "string" then
		error(("Usage: AceDBObject:SetProfile(name): 'name' - string expected, got %q."):format(type(name)), 2)
	end

	-- changing to the same profile, dont do anything
	if name == self.keys.profile then return end

	local oldProfile = self.profile
	local defaults = self.defaults and self.defaults.profile

	-- Callback: OnProfileShutdown, database
	self.callbacks:Fire("OnProfileShutdown", self)

	if oldProfile and defaults then
		-- Remove the defaults from the old profile
		removeDefaults(oldProfile, defaults)
	end

	self.profile = nil
	self.keys["profile"] = name

	-- if the storage exists, save the new profile
	-- this won't exist on namespaces.
	if self.sv.profileKeys then
		self.sv.profileKeys[charKey] = name
	end

	-- populate to child namespaces
	if self.children then
		for _, db in pairs(self.children) do
			DBObjectLib.SetProfile(db, name)
		end
	end

	-- Callback: OnProfileChanged, database, newProfileKey
	self.callbacks:Fire("OnProfileChanged", self, name)
end

function DBObjectLib:GetProfiles(tbl)
	if tbl and type(tbl) ~= "table" then
		error(("Usage: AceDBObject:GetProfiles(tbl): 'tbl' - table or nil expected, got %q."):format(type(tbl)), 2)
	end

	-- Clear the container table
	if tbl then
		for k,v in pairs(tbl) do tbl[k] = nil end
	else
		tbl = {}
	end

	local curProfile = self.keys.profile

	local i = 0
	for profileKey in pairs(self.profiles) do
		i = i + 1
		tbl[i] = profileKey
		if curProfile and profileKey == curProfile then curProfile = nil end
	end

	-- Add the current profile, if it hasn't been created yet
	if curProfile then
		i = i + 1
		tbl[i] = curProfile
	end

	return tbl, i
end

--- Returns the current profile name used by the database
function DBObjectLib:GetCurrentProfile()
	return self.keys.profile
end

function DBObjectLib:DeleteProfile(name, silent)
	if type(name) ~= "string" then
		error(("Usage: AceDBObject:DeleteProfile(name): 'name' - string expected, got %q."):format(type(name)), 2)
	end

	if self.keys.profile == name then
		error(("Cannot delete the active profile (%q) in an AceDBObject."):format(name), 2)
	end

	if not rawget(self.profiles, name) and not silent then
		error(("Cannot delete profile %q as it does not exist."):format(name), 2)
	end

	self.profiles[name] = nil

	-- populate to child namespaces
	if self.children then
		for _, db in pairs(self.children) do
			DBObjectLib.DeleteProfile(db, name, true)
		end
	end

	-- switch all characters that use this profile back to the default
	if self.sv.profileKeys then
		for key, profile in pairs(self.sv.profileKeys) do
			if profile == name then
				self.sv.profileKeys[key] = nil
			end
		end
	end

	-- Callback: OnProfileDeleted, database, profileKey
	self.callbacks:Fire("OnProfileDeleted", self, name)
end

function DBObjectLib:CopyProfile(name, silent)
	if type(name) ~= "string" then
		error(("Usage: AceDBObject:CopyProfile(name): 'name' - string expected, got %q."):format(type(name)), 2)
	end

	if name == self.keys.profile then
		error(("Cannot have the same source and destination profiles (%q)."):format(name), 2)
	end

	if not rawget(self.profiles, name) and not silent then
		error(("Cannot copy profile %q as it does not exist."):format(name), 2)
	end

	-- Reset the profile before copying
	DBObjectLib.ResetProfile(self, nil, true)

	local profile = self.profile
	local source = self.profiles[name]

	copyTable(source, profile)

	-- populate to child namespaces
	if self.children then
		for _, db in pairs(self.children) do
			DBObjectLib.CopyProfile(db, name, true)
		end
	end

	-- Callback: OnProfileCopied, database, sourceProfileKey
	self.callbacks:Fire("OnProfileCopied", self, name)
end

function DBObjectLib:ResetProfile(noChildren, noCallbacks)
	local profile = self.profile

	for k,v in pairs(profile) do
		profile[k] = nil
	end

	local defaults = self.defaults and self.defaults.profile
	if defaults then
		copyDefaults(profile, defaults)
	end

	-- populate to child namespaces
	if self.children and not noChildren then
		for _, db in pairs(self.children) do
			DBObjectLib.ResetProfile(db, nil, noCallbacks)
		end
	end

	-- Callback: OnProfileReset, database
	if not noCallbacks then
		self.callbacks:Fire("OnProfileReset", self)
	end
end

function DBObjectLib:ResetDB(defaultProfile)
	if defaultProfile and type(defaultProfile) ~= "string" then
		error(("Usage: AceDBObject:ResetDB(defaultProfile): 'defaultProfile' - string or nil expected, got %q."):format(type(defaultProfile)), 2)
	end

	local sv = self.sv
	for k,v in pairs(sv) do
		sv[k] = nil
	end

	initdb(sv, self.defaults, defaultProfile, self)

	-- fix the child namespaces
	if self.children then
		if not sv.namespaces then sv.namespaces = {} end
		for name, db in pairs(self.children) do
			if not sv.namespaces[name] then sv.namespaces[name] = {} end
			initdb(sv.namespaces[name], db.defaults, self.keys.profile, db, self)
		end
	end

	-- Callback: OnDatabaseReset, database
	self.callbacks:Fire("OnDatabaseReset", self)
	-- Callback: OnProfileChanged, database, profileKey
	self.callbacks:Fire("OnProfileChanged", self, self.keys["profile"])

	return self
end

function DBObjectLib:RegisterNamespace(name, defaults)
	if type(name) ~= "string" then
		error(("Usage: AceDBObject:RegisterNamespace(name, defaults): 'name' - string expected, got %q."):format(type(name)), 2)
	end
	if defaults and type(defaults) ~= "table" then
		error(("Usage: AceDBObject:RegisterNamespace(name, defaults): 'defaults' - table or nil expected, got %q."):format(type(defaults)), 2)
	end
	if self.children and self.children[name] then
		error(("Usage: AceDBObject:RegisterNamespace(name, defaults): 'name' - a namespace called %q already exists."):format(name), 2)
	end

	local sv = self.sv
	if not sv.namespaces then sv.namespaces = {} end
	if not sv.namespaces[name] then
		sv.namespaces[name] = {}
	end

	local newDB = initdb(sv.namespaces[name], defaults, self.keys.profile, nil, self)

	if not self.children then self.children = {} end
	self.children[name] = newDB
	return newDB
end

function DBObjectLib:GetNamespace(name, silent)
	if type(name) ~= "string" then
		error(("Usage: AceDBObject:GetNamespace(name): 'name' - string expected, got %q."):format(type(name)), 2)
	end
	if not silent and not (self.children and self.children[name]) then
		error(("Usage: AceDBObject:GetNamespace(name): 'name' - namespace %q does not exist."):format(name), 2)
	end
	if not self.children then self.children = {} end
	return self.children[name]
end

function AceDB:New(tbl, defaults, defaultProfile)
	if type(tbl) == "string" then
		local name = tbl
		tbl = _G[name]
		if not tbl then
			tbl = {}
			_G[name] = tbl
		end
	end

	if type(tbl) ~= "table" then
		error(("Usage: AceDB:New(tbl, defaults, defaultProfile): 'tbl' - table expected, got %q."):format(type(tbl)), 2)
	end

	if defaults and type(defaults) ~= "table" then
		error(("Usage: AceDB:New(tbl, defaults, defaultProfile): 'defaults' - table expected, got %q."):format(type(defaults)), 2)
	end

	if defaultProfile and type(defaultProfile) ~= "string" and defaultProfile ~= true then
		error(("Usage: AceDB:New(tbl, defaults, defaultProfile): 'defaultProfile' - string or true expected, got %q."):format(type(defaultProfile)), 2)
	end

	return initdb(tbl, defaults, defaultProfile)
end

-- upgrade existing databases
for db in pairs(AceDB.db_registry) do
	if not db.parent then
		for name,func in pairs(DBObjectLib) do
			db[name] = func
		end
	else
		db.RegisterDefaults = DBObjectLib.RegisterDefaults
		db.ResetProfile = DBObjectLib.ResetProfile
	end
end
