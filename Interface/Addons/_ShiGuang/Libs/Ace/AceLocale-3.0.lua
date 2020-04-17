local MAJOR,MINOR = "AceLocale-3.0", 6

local AceLocale, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not AceLocale then return end -- no upgrade needed

-- Lua APIs
local assert, tostring, error = assert, tostring, error
local getmetatable, setmetatable, rawset, rawget = getmetatable, setmetatable, rawset, rawget
local gameLocale = GetLocale()
if gameLocale == "enGB" then
	gameLocale = "enUS"
end

AceLocale.apps = AceLocale.apps or {}          -- array of ["AppName"]=localetableref
AceLocale.appnames = AceLocale.appnames or {}  -- array of [localetableref]="AppName"

-- This metatable is used on all tables returned from GetLocale
local readmeta = {
	__index = function(self, key) -- requesting totally unknown entries: fire off a nonbreaking error and return key
		rawset(self, key, key)      -- only need to see the warning once, really
		geterrorhandler()(MAJOR..": "..tostring(AceLocale.appnames[self])..": Missing entry for '"..tostring(key).."'")
		return key
	end
}

-- This metatable is used on all tables returned from GetLocale if the silent flag is true, it does not issue a warning on unknown keys
local readmetasilent = {
	__index = function(self, key) -- requesting totally unknown entries: return key
		rawset(self, key, key)      -- only need to invoke this function once
		return key
	end
}

local registering

-- local assert false function
local assertfalse = function() assert(false) end

-- This metatable proxy is used when registering nondefault locales
local writeproxy = setmetatable({}, {
	__newindex = function(self, key, value)
		rawset(registering, key, value == true and key or value) -- assigning values: replace 'true' with key string
	end,
	__index = assertfalse
})

local writedefaultproxy = setmetatable({}, {
	__newindex = function(self, key, value)
		if not rawget(registering, key) then
			rawset(registering, key, value == true and key or value)
		end
	end,
	__index = assertfalse
})

function AceLocale:NewLocale(application, locale, isDefault, silent)

	local gameLocale = GAME_LOCALE or gameLocale

	local app = AceLocale.apps[application]

	if silent and app and getmetatable(app) ~= readmetasilent then
		geterrorhandler()("Usage: NewLocale(application, locale[, isDefault[, silent]]): 'silent' must be specified for the first locale registered")
	end

	if not app then
		if silent=="raw" then
			app = {}
		else
			app = setmetatable({}, silent and readmetasilent or readmeta)
		end
		AceLocale.apps[application] = app
		AceLocale.appnames[app] = application
	end

	if locale ~= gameLocale and not isDefault then
		return -- nop, we don't need these translations
	end

	registering = app -- remember globally for writeproxy and writedefaultproxy

	if isDefault then
		return writedefaultproxy
	end

	return writeproxy
end

function AceLocale:GetLocale(application, silent)
	if not silent and not AceLocale.apps[application] then
		error("Usage: GetLocale(application[, silent]): 'application' - No locales registered for '"..tostring(application).."'", 2)
	end
	return AceLocale.apps[application]
end
