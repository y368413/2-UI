--## Author: p3lim ## Version: 110000.37-Release
local BetterWorldQuests = {}
local addonName = "_ShiGuang"

--[[ namespace:IsRetail()
Checks if the current client is running the "retail" version.
--]]
function BetterWorldQuests:IsRetail()
	return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end

--[[ namespace:IsClassicEra()
Checks if the current client is running the "classic era" version (e.g. vanilla).
--]]
function BetterWorldQuests:IsClassicEra()
	return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

--[[ namespace:IsClassic()
Checks if the current client is running the "classic" version.
--]]
function BetterWorldQuests:IsClassic()
	-- instead of using the floating constant for classic we'll just NOR the other two,
	-- as they are static
	return not BetterWorldQuests:IsRetail() and not BetterWorldQuests:IsClassicEra()
end

local _, buildVersion, _, interfaceVersion = GetBuildInfo()
--[[ namespace:HasBuild(_buildNumber_[, _interfaceVersion_])
Checks if the current client is running a build equal to or newer than the specified.  
Optionally also check against the interface version.
--]]
function BetterWorldQuests:HasBuild(build, interface)
	if interface and interfaceVersion < interface then
		return
	end

	return tonumber(buildVersion) >= build
end




--[[ namespace:header
In each example `namespace` refers to the 2nd value of the BetterWorldQuests vararg, e.g:

```lua
local _, namespace = ...
```
--]]

--[[ namespace:ArgCheck(arg, argIndex, type[, type...])
Checks if the argument `arg` at position `argIndex` is of type(s).
--]]
function BetterWorldQuests:ArgCheck(arg, argIndex, ...)
	assert(type(argIndex) == 'number', 'Bad argument #2 to \'ArgCheck\' (number expected, got ' .. type(argIndex) .. ')')

	for index = 1, select('#', ...) do
		if type(arg) == select(index, ...) then
			return
		end
	end

	local types = string.join(', ', ...)
	local name = debugstack(2, 2, 0):match(': in function [`<](.-)[\'>]')
	error(string.format('Bad argument #%d to \'%s\' (%s expected, got %s)', argIndex, name, types, type(arg)), 3)
end

do
	-- UnitType-0-ServerID-InstanceID-ZoneUID-ID-SpawnUID
	local GUID_PATTERN = '(%w+)%-0%-(%d+)%-(%d+)%-(%d+)%-(%d+)%-(.+)'
	--[[ namespace:ExtractFieldsFromUnitGUID(_guid_)
	Returns the individual fields from the given [`guid`](https://warcraft.wiki.gg/wiki/GUID), typecast to their correct types.
	--]]
	function BetterWorldQuests:ExtractFieldsFromUnitGUID(guid)
		if guid then
			local unitType, serverID, instanceID, zoneUID, id, spawnUID = guid:match(GUID_PATTERN)
			if unitType then
				return unitType, tonumber(serverID), tonumber(instanceID), tonumber(zoneUID), tonumber(id), spawnUID
			end
		end
	end
end

--[[ namespace:GetUnitID(_unit_)
Returns the integer `id` of the given [`unit`](https://warcraft.wiki.gg/wiki/UnitId).
--]]
function BetterWorldQuests:GetUnitID(unit)
	if unit and UnitExists(unit) then
		local _, _, _, _, unitID = BetterWorldQuests:ExtractFieldsFromUnitGUID(UnitGUID(unit))
		return unitID
	end
end

--[[ namespace:GetNPCName(_npcID_)
Returns the name for the NPC by the given `npcID`.

Warning: this depends on the cache, and might not yield results the first time.
--]]
do
	local creatureNames = setmetatable({}, {
		__index = function(self, npcID)
			local data = C_TooltipInfo.GetHyperlink('unit:Creature-0-0-0-0-' .. npcID .. '-0')
			local name = data and data.lines and data.lines[1] and data.lines[1].leftText
			if name then
				rawset(self, npcID, name)
				return name
			end
		end
	})

	function BetterWorldQuests:GetNPCName(npcID)
		return creatureNames[npcID]
	end
end

do
	local ITEM_LINK_FORMAT = '|Hitem:%d|h'
	--[[ namespace:GetItemLinkFromID(_itemID_)
	Generates an [item link](https://warcraft.wiki.gg/wiki/ItemLink) from an `itemID`.  
	This is a crude generation and won't have valid data for complex items.
	--]]
	function BetterWorldQuests:GetItemLinkFromID(itemID)
		return ITEM_LINK_FORMAT:format(itemID)
	end
end

--[[ namespace:GetPlayerMapID()
Returns the ID of the current map the zone the player is located in.
--]]
function BetterWorldQuests:GetPlayerMapID()
	-- TODO: maybe use HBD data if it's available
	return C_Map.GetBestMapForUnit('player') or -1
end

--[[ namespace:GetPlayerPosition(_mapID_)
Returns the `x` and `y` coordinates for the player in the given `mapID` (if they are valid).
--]]
function BetterWorldQuests:GetPlayerPosition(mapID)
	local pos = C_Map.GetPlayerMapPosition(mapID, 'player')
	if pos then
		return pos:GetXY()
	end
end

do
	local function auraSlotsWrapper(unit, spellID, token, ...)
		local slot, data
		for index = 1, select('#', ...) do
			slot = select(index, ...)
			data = C_UnitAuras.GetAuraDataBySlot(unit, slot)
			if spellID == data.spellId and data.sourceUnit then
				return nil, data
			end
		end

		return token
	end

	--[[ namespace:GetUnitAura(_unit_, _spellID_, _filter_)
	Returns the aura by `spellID` on the [`unit`](https://warcraft.wiki.gg/wiki/UnitId), if it exists.

	* [`unitID`](https://warcraft.wiki.gg/wiki/UnitId)
	* `spellID` - spell ID to check for
	* `filter` - aura filter, see [UnitAura](https://warcraft.wiki.gg/wiki/API_C_UnitAuras.GetAuraDataByIndex#Filters)
	--]]
	function BetterWorldQuests:GetUnitAura(unit, spellID, filter)
		local token, data
		repeat
			token, data = auraSlotsWrapper(unit, spellID, C_UnitAuras.GetAuraSlots(unit, filter, nil, token))
		until token == nil

		return data
	end
end

--[[ namespace:CreateColor(r, g, b[, a])
Wrapper for CreateColor that can handle >1-255 range as well.  
Alpha (`a`) will always be in the 0-1 range.
--]]
--[[ namespace:CreateColor(hex)
Wrapper for CreateColor that can handle hex colors (both `RRGGBB` and `AARRGGBB`).
--]]
function BetterWorldQuests:CreateColor(r, g, b, a)
	if type(r) == 'table' then
		return BetterWorldQuests:CreateColor(r.r, r.g, r.b, r.a)
	elseif type(r) == 'string' then
		-- load from hex
		local hex = r:gsub('#', '')
		if #hex == 8 then
			-- prefixed with alpha
			a = tonumber(hex:sub(1, 2), 16) / 255
			r = tonumber(hex:sub(3, 4), 16) / 255
			g = tonumber(hex:sub(5, 6), 16) / 255
			b = tonumber(hex:sub(7, 8), 16) / 255
		elseif #hex == 6 then
			r = tonumber(hex:sub(1, 2), 16) / 255
			g = tonumber(hex:sub(3, 4), 16) / 255
			b = tonumber(hex:sub(5, 6), 16) / 255
		end
	elseif r > 1 or g > 1 or b > 1 then
		r = r / 255
		g = g / 255
		b = b / 255
	end

	local color = CreateColor(r, g, b, a)
	-- oUF compat; TODO: do something with this in oUF?
	color[1] = r
	color[2] = g
	color[3] = b
	return color
end

do
	local timeFormatter = CreateFromMixins(SecondsFormatterMixin)
	timeFormatter:Init(1, SecondsFormatter.Abbreviation.OneLetter)
	timeFormatter:SetStripIntervalWhitespace(true)
	--[[ namespace:FormatTime(_timeInSeconds_)
	Formats the given `timeInSeconds` to a readable, but abbreviated format.
	--]]
	function BetterWorldQuests:FormatTime(timeInSeconds)
		return timeFormatter:Format(tonumber(timeInSeconds))
	end
end

--[[ namespace.eventMixin
A multi-purpose [event](https://warcraft.wiki.gg/wiki/Events)-[mixin](https://en.wikipedia.org/wiki/Mixin).

These methods are also available as methods directly on `namespace`, e.g:

```lua
namespace:RegisterEvent('BAG_UPDATE', function(self, ...)
    -- do something
end)
```
--]]

local eventHandler = CreateFrame('Frame')
local callbacks = {}

local IsEventValid
if BetterWorldQuests:IsRetail() then
	IsEventValid = C_EventUtils.IsEventValid
else
	local eventValidator = CreateFrame('Frame')
	function IsEventValid(event)
		local isValid = pcall(eventValidator.RegisterEvent, eventValidator, event)
		if isValid then
			eventValidator:UnregisterEvent(event)
		end
		return isValid
	end
end

local unitEventValidator = CreateFrame('Frame')
local function IsUnitEventValid(event, unit)
	-- C_EventUntils.IsEventValid doesn't cover unit events, so we'll have to do this the old fashioned way
	local isValid = pcall(unitEventValidator.RegisterUnitEvent, unitEventValidator, event, unit)
	if isValid then
		unitEventValidator:UnregisterEvent(event)
	end
	return isValid
end

local unitValidator = CreateFrame('Frame')
local function IsUnitValid(unit)
	if unitValidator:RegisterUnitEvent('UNIT_HEALTH', unit) then
		local _, registeredUnit = unitValidator:IsEventRegistered('UNIT_HEALTH')
		unitValidator:UnregisterEvent('UNIT_HEALTH')
		return not not registeredUnit -- it will be nil if the registered unit is invalid
	end
end

local eventMixin = {}
--[[ namespace.eventMixin:RegisterEvent(_event_, _callback_)
Registers a [frame `event`](https://warcraft.wiki.gg/wiki/Events) with the `callback` function.  
If the callback returns positive it will be unregistered.
--]]
function eventMixin:RegisterEvent(event, callback)
	assert(IsEventValid(event), 'arg1 must be an event')
	assert(type(callback) == 'function', 'arg2 must be a function')

	if not callbacks[event] then
		callbacks[event] = {}
	end

	table.insert(callbacks[event], {
		callback = callback,
		owner = self,
	})

	if not eventHandler:IsEventRegistered(event) then
		eventHandler:RegisterEvent(event)
	end
end

--[[ namespace.eventMixin:UnregisterEvent(_event_, _callback_)
Unregisters a [frame `event`](https://warcraft.wiki.gg/wiki/Events) from the `callback` function.
--]]
function eventMixin:UnregisterEvent(event, callback)
	assert(IsEventValid(event), 'arg1 must be an event')
	assert(type(callback) == 'function', 'arg2 must be a function')

	if callbacks[event] then
		for index, data in next, callbacks[event] do
			if data.owner == self and data.callback == callback then
				callbacks[event][index] = nil
				break
			end
		end

		if #callbacks[event] == 0 then
			eventHandler:UnregisterEvent(event)
		end
	end
end

--[[ namespace.eventMixin:UnregisterAllEvents(_callback_)
Unregisters all [frame events](https://warcraft.wiki.gg/wiki/Events) from the `callback` function.
--]]
function eventMixin:UnregisterAllEvents(callback)
	assert(type(callback) == 'function', 'arg1 must be a function')

	for event, cbs in next, callbacks do
		for _, data in next, cbs do
			if data.owner == self and data.callback == callback then
				self:UnregisterEvent(event, callback)
			end
		end
	end
end

--[[ namespace.eventMixin:IsEventRegistered(_event_, _callback_)
Checks if the [frame `event`](https://warcraft.wiki.gg/wiki/Events) is registered with the `callback` function.
--]]
function eventMixin:IsEventRegistered(event, callback)
	assert(IsEventValid(event), 'arg1 must be an event')
	assert(type(callback) == 'function', 'arg2 must be a function')

	if callbacks[event] then
		for _, data in next, callbacks[event] do
			if data.callback == callback then
				return true
			end
		end
	end
end

--[[ namespace.eventMixin:TriggerEvent(_event_[, _..._])
Manually trigger the `event` (with optional arguments) on all registered callbacks.  
If the callback returns positive it will be unregistered.
--]]
function eventMixin:TriggerEvent(event, ...)
	if callbacks[event] then
		for _, data in next, callbacks[event] do
			local successful, ret = pcall(data.callback, data.owner, ...)
			if not successful then
				-- ret contains the error
				error(ret)
			elseif ret then
				-- callbacks can unregister themselves by returning positively,
				-- ret contains the boolean
				eventMixin.UnregisterEvent(data.owner, event, data.callback)
			end
		end
	end
end

eventHandler:SetScript('OnEvent', function(_, event, ...)
	eventMixin:TriggerEvent(event, ...)
end)

-- special handling for unit events
local unitEventHandlers = {}
local function getUnitEventHandler(unit)
	if not unitEventHandlers[unit] then
		local unitEventHandler = CreateFrame('Frame')
		unitEventHandler:SetScript('OnEvent', function(_, event, ...)
			eventMixin:TriggerUnitEvent(event, unit, ...)
		end)
		unitEventHandlers[unit] = unitEventHandler
	end
	return unitEventHandlers[unit]
end

local unitEventCallbacks = {}
--[[ namespace.eventMixin:RegisterUnitEvent(_event_, _unit_[, _unitN,..._], _callback_)
Registers a [`unit`](https://warcraft.wiki.gg/wiki/UnitId)-specific [frame `event`](https://warcraft.wiki.gg/wiki/Events) with the `callback` function.  
If the callback returns positive it will be unregistered for that unit.
--]]
function eventMixin:RegisterUnitEvent(event, ...)
	assert(IsEventValid(event), 'arg1 must be an event')
	local callback = select(select('#', ...), ...)
	assert(type(callback) == 'function', 'last argument must be a function')

	for i = 1, select('#', ...) - 1 do
		local unit = select(i, ...)
		assert(IsUnitValid(unit), 'arg' .. (i + 1) .. ' must be a valid unit')
		assert(IsUnitEventValid(event, unit), 'event "' .. event .. '" is not valid for the given unit')

		if not unitEventCallbacks[unit] then
			unitEventCallbacks[unit] = {}
		end
		if not unitEventCallbacks[unit][event] then
			unitEventCallbacks[unit][event] = {}
		end

		table.insert(unitEventCallbacks[unit][event], {
			callback = callback,
			owner = self,
		})

		local unitEventHandler = getUnitEventHandler(unit)
		local isRegistered, registeredUnit = unitEventHandler:IsEventRegistered(event)
		if not isRegistered then
			unitEventHandler:RegisterUnitEvent(event, unit)
		elseif registeredUnit ~= unit then
			error('unit event somehow registered with the wrong unit')
		end
	end
end

--[[ namespace.eventMixin:UnregisterUnitEvent(_event_, _unit_[, _unitN,..._], _callback_)
Unregisters a [`unit`](https://warcraft.wiki.gg/wiki/UnitId)-specific [frame `event`](https://warcraft.wiki.gg/wiki/Events) from the `callback` function.
--]]
function eventMixin:UnregisterUnitEvent(event, ...)
	assert(IsEventValid(event), 'arg1 must be an event')
	local callback = select(select('#', ...), ...)
	assert(type(callback) == 'function', 'last argument must be a function')

	for i = 1, select('#', ...) - 1 do
		local unit = select(i, ...)
		assert(IsUnitValid(unit), 'arg' .. (i + 1) .. ' must be a valid unit')
		assert(IsUnitEventValid(event, unit), 'event is not valid for the given unit')

		if unitEventCallbacks[unit] and unitEventCallbacks[unit][event] then
			for index, data in next, unitEventCallbacks[unit][event] do
				if data.owner == self and data.callback == callback then
					unitEventCallbacks[unit][event][index] = nil
					break
				end
			end

			if #unitEventCallbacks[unit][event] == 0 then
				getUnitEventHandler(unit):UnregisterEvent(event)
			end
		end
	end
end

--[[ namespace.eventMixin:IsUnitEventRegistered(_event_, _unit_[, _unitN,..._], _callback_)
Checks if the [`unit`](https://warcraft.wiki.gg/wiki/UnitId)-specific [frame `event`](https://warcraft.wiki.gg/wiki/Events) is registered with the `callback` function.
--]]
function eventMixin:IsUnitEventRegistered(event, ...)
	assert(IsEventValid(event), 'arg1 must be an event')
	local callback = select(select('#', ...), ...)
	assert(type(callback) == 'function', 'last argument must be a function')

	for i = 1, select('#', ...) - 1 do
		local unit = select(i, ...)
		assert(IsUnitValid(unit), 'arg' .. (i + 1) .. ' must be a valid unit')
		assert(IsUnitEventValid(event, unit), 'event is not valid for the given unit')

		if unitEventCallbacks[unit] and unitEventCallbacks[unit][event] then
			for _, data in next, unitEventCallbacks[unit][event] do
				if data.callback == callback then
					return true
				end
			end
		end
	end
end

--[[ namespace.eventMixin:TriggerEvent(_event_, _unit_[, _unitN,..._][, _..._])
Manually trigger the [`unit`](https://warcraft.wiki.gg/wiki/UnitId)-specific `event` (with optional arguments) on all registered callbacks.  
If the callback returns positive it will be unregistered.
--]]
function eventMixin:TriggerUnitEvent(event, unit, ...)
	if unitEventCallbacks[unit] and unitEventCallbacks[unit][event] then
		for _, data in next, unitEventCallbacks[unit][event] do
			local successful, ret = pcall(data.callback, data.owner, ...)
			if not successful then
				error(ret)
			elseif ret then
				-- callbacks can unregister themselves by returning positively
				eventMixin.UnregisterUnitEvent(data.owner, event, unit, data.callback)
			end
		end
	end
end

-- special handling for combat events
local combatEventCallbacks = {}
--[[ namespace.eventMixin:RegisterCombatEvent(_subEvent_, _callback_)
Registers a [combat `subEvent`](https://warcraft.wiki.gg/wiki/COMBAT_LOG_EVENT) with the `callback` function.  
If the callback returns positive it will be unregistered.
--]]
function eventMixin:RegisterCombatEvent(event, callback)
	assert(type(event) == 'string', 'arg1 must be a string')
	assert(type(callback) == 'function', 'arg2 must be a function')

	if not combatEventCallbacks[event] then
		combatEventCallbacks[event] = {}
	end

	table.insert(combatEventCallbacks[event], {
		callback = callback,
		owner = self,
	})

	if not self:IsEventRegistered('COMBAT_LOG_EVENT_UNFILTERED', self.TriggerCombatEvent) then
		self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', self.TriggerCombatEvent)
	end
end

--[[ namespace.eventMixin:UnregisterCombatEvent(_subEvent_, _callback_)
Unregisters a [combat `subEvent`](https://warcraft.wiki.gg/wiki/COMBAT_LOG_EVENT) from the `callback` function.
--]]
function eventMixin:UnregisterCombatEvent(event, callback)
	assert(type(event) == 'string', 'arg1 must be a string')
	assert(type(callback) == 'function', 'arg2 must be a function')

	if combatEventCallbacks[event] then
		for index, data in next, combatEventCallbacks[event] do
			if data.owner == self and data.callback == callback then
				combatEventCallbacks[event][index] = nil
				break
			end
		end
	end
end

--[[ namespace.eventMixin:TriggerCombatEvent(_subEvent_)
Manually trigger the [combat `subEvent`](https://warcraft.wiki.gg/wiki/COMBAT_LOG_EVENT) on all registered callbacks.  
If the callback returns positive it will be unregistered.

* Note: this is pretty useless on it's own, and should only ever be triggered by the event system.
--]]
do
	local function internalTrigger(_, event, _, ...)
		if combatEventCallbacks[event] then
			for _, data in next, combatEventCallbacks[event] do
				local successful, ret = pcall(data.callback, data.owner, ...)
				if not successful then
					error(ret)
				elseif ret then
					eventMixin.UnregisterCombatEvent(data.owner, event, data.callback)
				end
			end
		end
	end

	function eventMixin:TriggerCombatEvent()
		internalTrigger(CombatLogGetCurrentEventInfo())
	end
end

-- expose mixin
BetterWorldQuests.eventMixin = eventMixin

-- anonymous event registration
BetterWorldQuests = setmetatable(BetterWorldQuests, {
	__newindex = function(t, key, value)
		if key == 'OnLoad' then
			--[[ namespace:OnLoad()
			Shorthand for the [`ADDON_LOADED`](https://warcraft.wiki.gg/wiki/ADDON_LOADED) for the BetterWorldQuests.

			Usage:
			```lua
			function namespace:OnLoad()
			    -- I'm loaded!
			end
			```
			--]]
			BetterWorldQuests:RegisterEvent('ADDON_LOADED', function(self, name)
				if name == addonName then
					local successful, ret = pcall(value, self)
					if not successful then
						error(ret)
					end
					return true -- unregister event
				end
			end)
		elseif key == 'OnLogin' then
			--[[ namespace:OnLogin()
			Shorthand for the [`PLAYER_LOGIN`](https://warcraft.wiki.gg/wiki/PLAYER_LOGIN).

			Usage:
			```lua
			function namespace:OnLogin()
			    -- player has logged in!
			end
			```
			--]]
			BetterWorldQuests:RegisterEvent('PLAYER_LOGIN', function(self)
				local successful, ret = pcall(value, self)
				if not successful then
					error(ret)
				end
				return true -- unregister event
			end)
		elseif IsEventValid(key) then
			--[[ namespace:_event_
			Registers a  to an anonymous function.

			Usage:
			```lua
			function namespace:BAG_UPDATE(bagID)
			    -- do something
			end
			```
			--]]
			eventMixin.RegisterEvent(t, key, value)
		else
			-- default table behaviour
			rawset(t, key, value)
		end
	end,
	__index = function(t, key)
		if IsEventValid(key) then
			--[[ namespace:_event_([_..._])
			Manually trigger all registered anonymous `event` callbacks, with optional arguments.

			Usage:
			```lua
			namespace:BAG_UPDATE(1) -- triggers the above example
			```
			--]]
			return function(_, ...)
				eventMixin.TriggerEvent(t, key, ...)
			end
		else
			-- default table behaviour
			return rawget(t, key)
		end
	end,
})

-- mixin to namespace
Mixin(BetterWorldQuests, eventMixin)


--[[ namespace:RegisterSlash(_command_[, _commandN,..._], _callback_)
Registers chat slash `command`(s) with a `callback` function.

Usage:
```lua
namespace:RegisterSlash('/hello', '/hi', function(input)
    print('Hi')
end)
```
--]]
function BetterWorldQuests:RegisterSlash(...)
	local name = addonName .. 'Slash' .. math.random()
	local failed

	local numArgs = select('#', ...)
	local callback = select(numArgs, ...)
	if type(callback) ~= 'function' or numArgs < 2 then
		failed = true
	else
		for index = 1, numArgs - 1 do
			local slash = select(index, ...)
			if type(slash) ~= 'string' then
				failed = true
				break
			elseif not slash:match('^/%a+$') then
				failed = true
				break
			else
				_G['SLASH_' .. name .. index] = slash
			end
		end
	end

	if failed then
		error('Syntax: RegisterSlash("/slash1"[, "/slash2"[, ...]], callback)')
	else
		SlashCmdList[name] = callback
	end
end


--[[ namespace:Print(_..._)
Prints out a message in the chat frame, prefixed with the BetterWorldQuests name in color.
--]]
function BetterWorldQuests:Print(...)
	-- can't use string join, it fails on nil values
	local msg = ''
	for index = 1, select('#', ...) do
		local arg = select(index, ...)
		msg = msg .. tostring(arg) .. ' '
	end

	DEFAULT_CHAT_FRAME:AddMessage('|cff33ff99' .. addonName .. '|r: ' .. msg:trim())
end

--[[ namespace:Printf(_fmt_, _..._)
Wrapper for `namespace:Print(...)` and `string.format`.
--]]
function BetterWorldQuests:Printf(fmt, ...)
	self:Print(fmt:format(...))
end

--[[ namespace:Dump(_object_[, _startKey_])
Wrapper for `DevTools_Dump`.
--]]
function BetterWorldQuests:Dump(value, startKey)
	DevTools_Dump(value, startKey)
end

--[[ namespace:DumpUI(_object_)
Similar to `namespace:Dump(object)`; a wrapper for the graphical version.
--]]
function BetterWorldQuests:DumpUI(value)
	UIParentLoadAddOn('Blizzard_DebugTools')
	DisplayTableInspectorWindow(value)
end




local queue = {}
local function iterate()
	for _, info in next, queue do
		if info.callback then
			local successful, ret = pcall(info.callback, unpack(info.args))
			if not successful then
				error(ret)
			end
		elseif info.object then
			local successful, ret = pcall(info.object[info.method], info.object, unpack(info.args))
			if not successful then
				error(ret)
			end
		end
	end

	table.wipe(queue)
	return true -- unregister event
end

local function defer(info)
	table.insert(queue, info)

	if not BetterWorldQuests:IsEventRegistered('PLAYER_REGEN_ENABLED', iterate) then
		BetterWorldQuests:RegisterEvent('PLAYER_REGEN_ENABLED', iterate)
	end
end


--[[ namespace:Defer(_callback_[, _..._])
Defers a function `callback` (with optional arguments) until after combat ends.  
Callback can be the global name of a function.  
Triggers immediately if player is not in combat.
--]]
function BetterWorldQuests:Defer(callback, ...)
	if type(callback) == 'string' then
		callback = _G[callback]
	end

	BetterWorldQuests:ArgCheck(callback, 1, 'function')

	if InCombatLockdown() then
		defer({
			callback = callback,
			args = {...},
		})
	else
		local successful, ret = pcall(callback, ...)
		if not successful then
			error(ret)
		end
	end
end

--[[ namespace:DeferMethod(_object_, _method_[, _..._])
Defers a `method` on `object` (with optional arguments) until after combat ends.  
Triggers immediately if player is not in combat.
--]]
function BetterWorldQuests:DeferMethod(object, method, ...)
	BetterWorldQuests:ArgCheck(object, 1, 'table')
	BetterWorldQuests:ArgCheck(method, 2, 'string')
	BetterWorldQuests:ArgCheck(object[method], 2, 'function')

	if InCombatLockdown() then
		defer({
			object = object,
			method = method,
			args = {...},
		})
	else
		local successful, ret = pcall(object[method], object, ...)
		if not successful then
			error(ret)
		end
	end
end




-- localization
local localizations = {}
local locale = GetLocale()

--[[ namespace.L(_locale_)[`string`]
Sets a localization `string` for the given `locale`.

Usage:
```lua
local L = namespace.L('deDE')
L['New string'] = 'Neue saite'
```
--]]
--[[ namespace.L[`string`]
Reads a localized `string` for the active locale.  
If a localized string for the active locale is not available the `string` will be read back.

Usage:
```lua
print(namespace.L['New string']) --> "Neue saite" on german clients, "New string" on all others
print(namespace.L['Unknown']) --> "Unknown" on all clients since there are no localizations
```
--]]
BetterWorldQuests.L = setmetatable({}, {
	__index = function(_, key)
		local localeTable = localizations[locale]
		return localeTable and localeTable[key] or tostring(key)
	end,
	__call = function(_, newLocale)
		localizations[newLocale] = localizations[newLocale] or {}
		return localizations[newLocale]
	end,
})




--[[ namespace:IsAddOnEnabled(addonName)
Checks whether the BetterWorldQuests exists and is enabled.
--]]
function BetterWorldQuests:IsAddOnEnabled(name)
	return C_AddOns.GetAddOnEnableState(name, UnitName('player')) > 0
end


local addonCallbacks = {}
--[[ namespace:HookAddOn(_addonName_, _callback_)
Registers a hook for when an BetterWorldQuests with the name `addonName` loads with a `callback` function.
--]]
function BetterWorldQuests:HookAddOn(addonName, callback)
	if C_AddOns.IsAddOnLoaded(addonName) then
		callback(self)
	else
		table.insert(addonCallbacks, {
			addonName = addonName,
			callback = callback,
		})
	end
end

BetterWorldQuests:RegisterEvent('ADDON_LOADED', function(self, addonName)
	for _, info in next, addonCallbacks do
		if info.addonName == addonName then
			local successful, err = pcall(info.callback)
			if not successful then
				error(err)
			end
		end
	end
end)




--[[ namespace:CreateFrame(_..._)
A wrapper for [`CreateFrame`](https://warcraft.wiki.gg/wiki/API_CreateFrame), mixed in with `namespace.eventMixin`.
--]]
function BetterWorldQuests:CreateFrame(...)
	return Mixin(CreateFrame(...), BetterWorldQuests.eventMixin)
end

local KEY_DIRECTION_CVAR = 'ActionButtonUseKeyDown'

local function updateKeyDirection(self)
	if C_CVar.GetCVarBool(KEY_DIRECTION_CVAR) then
		self:RegisterForClicks('AnyDown')
	else
		self:RegisterForClicks('AnyUp')
	end
end

local function onCVarUpdate(self, cvar)
	if cvar == KEY_DIRECTION_CVAR then
		BetterWorldQuests:Defer(updateKeyDirection, self)
	end
end

--[[ namespace:CreateButton(...)
A wrapper for `namespace:CreateFrame(...)`, but will handle key direction preferences of the client.  
Use this specifically to create clickable buttons.
--]]
function BetterWorldQuests:CreateButton(...)
	local button = BetterWorldQuests:CreateFrame(...)
	button:RegisterEvent('CVAR_UPDATE', onCVarUpdate)

	-- the CVar doesn't trigger during login, so we'll have to trigger the handlers ourselves
	onCVarUpdate(button, KEY_DIRECTION_CVAR)

	return button
end

do -- scrollbox
	local function defaultSort(a, b)
		-- convert to string first so we can sort mixed types
		return tostring(a) > tostring(b)
	end

	local function initialize(scroll)
		if scroll._provider then
			return
		end

		-- TODO: assertions

		local provider = CreateDataProvider()
		provider:SetSortComparator(scroll._sort or defaultSort, true)

		local view
		if scroll.kind == 'list' then
			view = CreateScrollBoxListLinearView(scroll._insetTop, scroll._insetBottom, scroll._insetLeft, scroll._insetRight, scroll._spacingHorizontal)
		elseif scroll.kind == 'grid' then
			local width = scroll:GetWidth() - scroll.bar:GetWidth() - (scroll._insetLeft or 0) - (scroll._insetRight or 0)
			local stride = math.floor((width - (scroll._spacingHorizontal or 0)) / (scroll._elementWidth + (scroll._spacingHorizontal or 0)))
			view = CreateScrollBoxListGridView(stride, scroll._insetTop, scroll._insetBottom, scroll._insetLeft, scroll._insetRight, scroll._spacingHorizontal, scroll._spacingVertical)
			view:SetStrideExtent(scroll._elementWidth)
		end

		view:SetDataProvider(provider)
		view:SetElementExtent(scroll._elementHeight)
		view:SetElementInitializer(scroll._elementType, function(element, data)
			if scroll._elementWidth and scroll.kind == 'grid' then
				element:SetWidth(scroll._elementWidth)
			end
			if scroll._elementHeight then
				element:SetHeight(scroll._elementHeight)
			end

			if not element._initialized then
				element._initialized = true

				if scroll._scripts then
					for script, callback in next, scroll._scripts do
						element:SetScript(script, callback)

						if script == 'OnEnter' and not scroll._scripts.OnLeave then
							element:SetScript('OnLeave', GameTooltip_Hide)
						end
					end
				end

				if scroll._onLoad then
					local successful, err = pcall(scroll._onLoad, element)
					if not successful then
						error(err)
					end
				end
			end

			element.data = data

			if scroll._onUpdate then
				local successful, err = pcall(scroll._onUpdate, element, data)
				if not successful then
					error(err)
				end
			end
		end)

		ScrollUtil.InitScrollBoxListWithScrollBar(scroll, scroll.bar, view)
		ScrollUtil.AddManagedScrollBarVisibilityBehavior(scroll, scroll.bar) -- auto-hide the scroll bar

		scroll._provider = provider
	end

	local scrollMixin = {}
	function scrollMixin:SetInsets(top, bottom, left, right)
		self._insetTop = top
		self._insetBottom = bottom
		self._insetLeft = left
		self._insetRight = right
	end
	function scrollMixin:SetElementType(kind)
		self._elementType = kind
	end
	function scrollMixin:SetElementHeight(height)
		self._elementHeight = height
	end
	function scrollMixin:SetElementWidth(width)
		self._elementWidth = width
	end
	function scrollMixin:SetElementSize(width, height)
		self:SetElementWidth(width)
		self:SetElementHeight(height or width)
	end
	function scrollMixin:SetElementSpacing(horizontal, vertical)
		self._spacingHorizontal = horizontal
		self._spacingVertical = vertical or horizontal
	end
	function scrollMixin:SetElementSortingMethod(callback)
		self._sort = callback
	end
	function scrollMixin:SetElementOnLoad(callback)
		self._onLoad = callback
	end
	function scrollMixin:SetElementOnScript(script, callback)
		self._scripts = self._scripts or {}
		self._scripts[script] = callback
	end
	function scrollMixin:SetElementOnUpdate(callback)
		self._onUpdate = callback
	end
	function scrollMixin:AddData(...)
		initialize(self)
		self._provider:Insert(...)
	end
	function scrollMixin:AddDataByKeys(data)
		for key, value in next, data do
			if value then -- must be truthy
				self:AddData(key)
			end
		end
	end
	function scrollMixin:RemoveData(...)
		self._provider:Remove(...)
	end
	function scrollMixin:ResetData()
		self._provider:Flush()
	end

	local function createScrollWidget(parent, kind)
		local box = CreateFrame('Frame', nil, parent, 'WowScrollBoxList')
		box:SetPoint('TOPLEFT')
		box:SetPoint('BOTTOMRIGHT', -8, 0) -- offset to not overlap scrollbar
		box.kind = kind

		local bar = CreateFrame('EventFrame', nil, parent, 'MinimalScrollBar')
		bar:SetPoint('TOPLEFT', box, 'TOPRIGHT')
		bar:SetPoint('BOTTOMLEFT', box, 'BOTTOMRIGHT')
		box.bar = bar

		return Mixin(box, scrollMixin)
	end

	--[[ namespace:CreateScrollList(_parent_)
	Creates and returns a scroll box with scroll bar and a data provider in a list representation.
	It gets automatically sized to fill the space of the parent.

	It provides the following methods, and is initialized whenever data is provided, so do that last.

	* `list:SetInsets([top], [bottom], [left], [right])` - sets scroll box insets (all optional)
	* `list:SetElementType(kind)` - sets the element type or template (required)
	* `list:SetElementHeight(height)` - sets the element height (required)
	* `list:SetElementSpacing(spacing)` - sets the spacing between elements (optional)
	* `list:SetElementSortingMethod(callback)` - sets the sort method for element data (optional)
	* `list:SetElementOnLoad(callback)` - sets the OnLoad method for each element (optional)
	    * the callback signature is `(element)`
	* `list:SetElementOnUpdate(callback)` - sets the callback for element data updates (optional)
	    * the callback signature is `(element, data)`
	* `list:SetElementOnScript(script, callback)` - sets the script handler for an element (optional)
	* `list:AddData(...)`
	* `list:AddDataByKeys(table)`
	* `list:RemoveData(...)`
	* `list:ResetData()`
	--]]
	function BetterWorldQuests:CreateScrollList(parent)
		return createScrollWidget(parent, 'list')
	end

	--[[ namespace:CreateScrollGrid(_parent_)
	Creates and returns a scroll box with scroll bar and a data provider in a grid representation.  
	It gets automatically sized to fill the space of the parent.

	It provides the following methods, and is initialized whenever data is provided, so do that last.

	* `grid:SetInsets([top], [bottom], [left], [right])` - sets scroll box insets (all optional)
	* `grid:SetElementType(kind)` - sets the element type or template (required)
	* `grid:SetElementHeight(height)` - sets the element height (required)
	* `grid:SetElementWidth(width)` - sets the element width (required)
	* `grid:SetElementSize(width[, height])` - sets the element width and height, shorthand for the two above, height falls back to width if not provided
	* `grid:SetElementSpacing(horizontal[, vertical])` - sets the spacing between elements, vertical falls back to horizontal if not provided  (optional)
	* `grid:SetElementSortingMethod(callback)` - sets the sort method for element data (optional)
	* `grid:SetElementOnLoad(callback)` - sets the OnLoad method for each element (optional)
	    * the callback signature is `(element)`
	* `grid:SetElementOnUpdate(callback)` - sets the callback for element data updates (optional)
	    * the callback signature is `(element, data)`
	* `grid:SetElementOnScript(script, callback)` - sets the script handler for an element (optional)
	* `grid:AddData(...)`
	* `grid:AddDataByKeys(table)`
	* `grid:RemoveData(...)`
	* `grid:ResetData()`
	--]]
	function BetterWorldQuests:CreateScrollGrid(parent)
		return createScrollWidget(parent, 'grid')
	end
end


local function onSettingChanged(setting, value)
	BetterWorldQuests:TriggerOptionCallback(setting.variableKey, value)
end

-- local function onOptionChanged(setting, value)
-- 	setting:SetValue(value, true)
-- end

local createCanvas
do
	local canvasMixin = {}
	function canvasMixin:SetDefaultsHandler(callback)
		local button = self:GetParent().Header.DefaultsButton
		button:Show()
		button:SetScript('OnClick', callback)
	end

	function createCanvas(name)
		local frame = CreateFrame('Frame')

		-- replicate header from SettingsListTemplate
		local header = CreateFrame('Frame', nil, frame)
		header:SetPoint('TOPLEFT')
		header:SetPoint('TOPRIGHT')
		header:SetHeight(50)
		frame.Header = header

		local title = header:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightHuge')
		title:SetPoint('TOPLEFT', 7, -22)
		title:SetJustifyH('LEFT')
		title:SetText(string.format('%s - %s', addonName, name))
		header.Title = title

		local defaults = CreateFrame('Button', nil, header, 'UIPanelButtonTemplate')
		defaults:SetPoint('TOPRIGHT', -36, -16)
		defaults:SetSize(96, 22)
		defaults:SetText(SETTINGS_DEFAULTS)
		defaults:Hide()
		header.DefaultsButton = defaults

		local divider = header:CreateTexture(nil, 'ARTWORK')
		divider:SetPoint('TOP', 0, -50)
		divider:SetAtlas('Options_HorizontalDivider', true)

		-- exposed container the BetterWorldQuests can use
		local canvas = Mixin(CreateFrame('Frame', nil, frame), canvasMixin)
		canvas:SetPoint('BOTTOMLEFT', 0, 5)
		canvas:SetPoint('BOTTOMRIGHT', -12, 5)
		canvas:SetPoint('TOP', 0, -56)

		return frame, canvas
	end
end

local createColorPicker -- I wish Settings.CreateColorPicker was a thing
do
	local colorPickerMixin = {}
	function colorPickerMixin:OnSettingValueChanged(setting, value)
		local r, g, b, a = BetterWorldQuests:CreateColor(value):GetRGBA()
		self.Swatch:SetColorRGB(r, g, b)

		-- modify colorInfo for next run
		self.colorInfo.r = r
		self.colorInfo.g = g
		self.colorInfo.b = b
		self.colorInfo.a = a
	end

	local function onClick(self)
		local parent = self:GetParent()
		local info = parent.colorInfo
		if info.hasOpacity then
			parent.oldValue = CreateColor(info.r, info.g, info.b, info.a):GenerateHexColor()
		else
			parent.oldValue = CreateColor(info.r, info.g, info.b):GenerateHexColorNoAlpha()
		end

		ColorPickerFrame:SetupColorPickerAndShow(info)
	end

	local function onColorChanged(self, setting)
		local r, g, b = ColorPickerFrame:GetColorRGB()
		if self.colorInfo.hasOpacity then
			local a = ColorPickerFrame:GetColorAlpha()
			setting:SetValue(CreateColor(r, g, b, a):GenerateHexColor())
		else
			setting:SetValue(CreateColor(r, g, b):GenerateHexColorNoAlpha())
		end
	end

	local function onColorCancel(self, setting)
		setting:SetValue(self.oldValue)
	end

	local function initFrame(initializer, self)
		SettingsListElementMixin.OnLoad(self)
		SettingsListElementMixin.Init(self, initializer)
		Mixin(self, colorPickerMixin)

		self:SetSize(280, 26) -- templates have a size

		-- creating widgets would be equal to :OnLoad()
		self.Swatch = CreateFrame('Button', nil, self, 'ColorSwatchTemplate')
		self.Swatch:SetSize(30, 30)
		self.Swatch:SetPoint('LEFT', self, 'CENTER', -80, 0)
		self.Swatch:SetScript('OnClick', onClick)

		-- setting up state would be equal to :Init()
		local setting = initializer:GetSetting()
		local value = setting:GetValue()
		local r, g, b, a = BetterWorldQuests:CreateColor(value):GetRGBA()

		self.colorInfo = {
			swatchFunc = GenerateClosure(onColorChanged, self, setting),
			opacityFunc = GenerateClosure(onColorChanged, self, setting),
			cancelFunc = GenerateClosure(onColorCancel, self, setting),
			r = r,
			g = g,
			b = b,
			opacity = a,
			hasOpacity = #value == 8
		}

		self.Swatch:SetColorRGB(r, g, b)

		-- set up callbacks, see SettingsControlMixin.Init as an example
		-- this is used to change common values, and is triggered by setting:SetValue(), thus also from defaults
		self.cbrHandles:SetOnValueChangedCallback(setting:GetVariable(), self.OnSettingValueChanged, self)
	end

	function createColorPicker(category, setting, options, tooltip)
		local data = Settings.CreateSettingInitializerData(setting, options, tooltip)
		local init = Settings.CreateElementInitializer('SettingsListElementTemplate', data)
		init.InitFrame = initFrame
		init:AddSearchTags(setting:GetName())
		SettingsPanel:GetLayout(category):AddInitializer(init)
	end
end

local function formatCustom(fmt, value)
	return fmt:format(value)
end

local function registerSetting(category, savedvariable, info)
	BetterWorldQuests:ArgCheck(info.key, 3, 'string')
	BetterWorldQuests:ArgCheck(info.title, 3, 'string')
	BetterWorldQuests:ArgCheck(info.type, 3, 'string')
	assert(info.default ~= nil, "default must be set")

	local uniqueKey = savedvariable .. '_' .. info.key
	local setting = Settings.RegisterAddOnSetting(category, uniqueKey, info.key, _G[savedvariable], type(info.default), info.title, info.default)

	if info.type == 'toggle' then
		Settings.CreateCheckbox(category, setting, info.tooltip)
	elseif info.type == 'slider' then
		BetterWorldQuests:ArgCheck(info.minValue, 3, 'number')
		BetterWorldQuests:ArgCheck(info.maxValue, 3, 'number')
		BetterWorldQuests:ArgCheck(info.valueFormat, 3, 'string', 'function')

		local options = Settings.CreateSliderOptions(info.minValue, info.maxValue, info.valueStep or 1)
		if type(info.valueFormat) == 'string' then
			options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, GenerateClosure(formatCustom, info.valueFormat))
		elseif type(info.valueFormat) == 'function' then
			options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, info.valueFormat)
		end

		Settings.CreateSlider(category, setting, options, info.tooltip)
	elseif info.type == 'menu' then
		BetterWorldQuests:ArgCheck(info.options, 3, 'table')
		local options = function()
			local container = Settings.CreateControlTextContainer()
			for _, option in next, info.options do
				container:Add(option.value, option.label)
			end
			return container:GetData()
		end
		Settings.CreateDropdown(category, setting, options, info.tooltip)
	elseif info.type == 'color' or info.type == 'colorpicker' then -- TODO: remove in 12.x, compat
		createColorPicker(category, setting, nil, info.tooltip)
	else
		error('type is invalid') -- TODO: make this prettier
		return
	end

	if info.firstInstall then
		-- we don't want to add "new" tags to a freshly installed BetterWorldQuests
		_G[savedvariable][info.key .. '_seen'] = true
	elseif not _G[savedvariable][info.key .. '_seen'] then
		-- add new tag to the settings panel until it's been observed by the player
		-- possibly tainty, definitely  ugly
		local version = GetBuildInfo()
		if not NewSettings[version] then
			NewSettings[version] = {}
		end

		table.insert(NewSettings[version], uniqueKey)

		-- remove once seen
		EventRegistry:RegisterCallback('Settings.CategoryChanged', function(_, cat)
			if cat == category and not _G[savedvariable][info.key .. '_seen'] then
				_G[savedvariable][info.key .. '_seen'] = true

				local settingIndex
				for index, key in next, NewSettings[version] do
					if key == uniqueKey then
						settingIndex = index
						break
					end
				end

				if settingIndex then
					table.remove(NewSettings[version], settingIndex)
				end
			end
		end)
	end

	-- callback when settings change something
	setting:SetValueChangedCallback(onSettingChanged)

	-- callback when we change settings elsewhere
	-- TODO: reconsider this usecase
	-- BetterWorldQuests:RegisterOptionCallback(info.key, GenerateClosure(onOptionChanged, setting))

	-- trigger load callback
	BetterWorldQuests:TriggerOptionCallback(info.key, setting:GetValue())
end

local function registerSettings(savedvariable, settings)
	local categoryName = C_AddOns.GetAddOnMetadata(addonName, 'Title')
	local category = Settings.RegisterVerticalLayoutCategory(categoryName)
	Settings.RegisterAddOnCategory(category)

	local firstInstall
	if not _G[savedvariable] then
		-- for some dumb reason RegisterAddOnSetting doesn't initialize the savedvariables table
		_G[savedvariable] = {}
		firstInstall = true
	end

	for _, setting in next, settings do
		if firstInstall then
			setting.firstInstall = true
		end

		registerSetting(category, savedvariable, setting)
	end

	-- sub-categories
	for _, info in next, BetterWorldQuests.settingsChildren do
		if info.settings then
			local child = Settings.RegisterVerticalLayoutSubcategory(category, info.name)
			for _, setting in next, info.settings do
				registerSetting(child, savedvariable, setting)
			end
			Settings.RegisterAddOnCategory(child)
		elseif info.callback then
			local frame, canvas = createCanvas(info.name)
			local child = Settings.RegisterCanvasLayoutSubcategory(category, frame, info.name)
			Settings.RegisterAddOnCategory(child)

			-- delay callback until settings are shown
			local shown
			SettingsPanel:HookScript('OnShow', function()
				if not shown then
					info.callback(canvas)
					shown = true
				end
			end)
		end
	end
end

--[[ namespace:RegisterSettings(_savedvariables_, _settings_)
Registers a set of `settings` with the interface options panel.  
The values will be stored by the `settings`' objects' `key` in `savedvariables`.

Should be used with the options methods below.

Usage:
```lua
namespace:RegisterSettings('MyAddOnDB', {
    {
        key = 'myToggle',
        type = 'toggle',
        title = 'My Toggle',
        tooltip = 'Longer description of the toggle in a tooltip',
        default = false,
    },
    {
        key = 'mySlider',
        type = 'slider',
        title = 'My Slider',
        tooltip = 'Longer description of the slider in a tooltip',
        default = 0.5,
        minValue = 0.1,
        maxValue = 1.0,
        valueStep = 0.01,
        valueFormat = formatter, -- callback function or a string for string.format
    },
    {
        key = 'myMenu',
        type = 'menu',
        title = 'My Menu',
        tooltip = 'Longer description of the menu in a tooltip',
        default = 'key1',
        options = {
            {value = key1, label = 'First option'},
            {value = key2, label = 'Second option'},
            {value = key3, label = 'Third option'},
        },
    },
    {
        key = 'myColor',
        type = 'color',
        title = 'My Color',
        tooltip = 'Longer description of the color in a tooltip',
        default = 'ff00ff', -- either "RRGGBB" or "AARRGGBB" format
    }
})
```
--]]
function BetterWorldQuests:RegisterSettings(savedvariable, settings)
	BetterWorldQuests:ArgCheck(savedvariable, 1, 'string')
	BetterWorldQuests:ArgCheck(settings, 2, 'table')
	assert(not self.registeredVariables, "can't register settings more than once")
	self.registeredVariables = savedvariable

	if not self.settingsChildren then
		self.settingsChildren = {}
	end

	-- ensure we only add the settings after savedvariables are available to the client
	local _, isReady = C_AddOns.IsAddOnLoaded(addonName)
	if isReady then
		registerSettings(savedvariable, settings)
	else
		-- don't abuse OnLoad internally
		BetterWorldQuests:RegisterEvent('ADDON_LOADED', function(_, name)
			if name == addonName then
				registerSettings(savedvariable, settings)
				return true -- unregister
			end
		end)
	end
end

--[[ namespace:RegisterSubSettings(_name_, _settings_)
Registers a set of `settings` as a sub-category. `name` must be unique.  
The savedvariables will be stored under the main savedvariables in a table entry named after `name`.

The `settings` are identical to that of `namespace:RegisterSettings`.
--]]
function BetterWorldQuests:RegisterSubSettings(name, settings)
	BetterWorldQuests:ArgCheck(name, 1, 'string')
	BetterWorldQuests:ArgCheck(settings, 2, 'table')
	assert(not not self.settingsChildren, "can't register sub-settings without root settings")
	assert(not self.settingsChildren[name], "can't register two sub-settings with the same name")
	self.settingsChildren[name] = {
		name = name,
		settings = settings,
	}
end

--[[ namespace:RegisterSubSettingsCanvas(_name_, _callback_)
Registers a canvas sub-category. This does not handle savedvariables.

`name` must be unique, and `callback` is called with a canvas `frame` as payload.

Canvas frame has a custom method `SetDefaultsHandler` which takes a callback as arg1.
This callback is triggered when the "Defaults" button is clicked.
--]]
function BetterWorldQuests:RegisterSubSettingsCanvas(name, callback)
	BetterWorldQuests:ArgCheck(name, 1, 'string')
	BetterWorldQuests:ArgCheck(callback, 2, 'function')
	assert(not not self.settingsChildren, "can't register sub-settings without root settings")
	assert(not self.settingsChildren[name], "can't register two sub-settings with the same name")
	self.settingsChildren[name] = {
		name = name,
		callback = callback,
	}
end

--[[ namespace:RegisterSettingsSlash(_..._)
Wrapper for `namespace:RegisterSlash(...)`, except the callback is provided and will open the settings panel for this BetterWorldQuests.
--]]
function BetterWorldQuests:RegisterSettingsSlash(...)
	-- gotta do this dumb shit because `..., callback` is not valid Lua
	local data = {...}
	table.insert(data, function()
		-- iterate over all categories until we find ours, since OpenToCategory only takes ID
		local categoryID
		local categoryName = C_AddOns.GetAddOnMetadata(addonName, 'Title')
		for _, category in next, SettingsPanel:GetAllCategories() do
			if category.name == categoryName then
				assert(not categoryID, 'found multiple instances of the same category')
				categoryID = category:GetID()
			end
		end

		Settings.OpenToCategory(categoryID)
	end)

	BetterWorldQuests:RegisterSlash(unpack(data))
end

--[[ namespace:GetOption(_key_)
Returns the value for the given option `key`.
--]]
function BetterWorldQuests:GetOption(key)
	BetterWorldQuests:ArgCheck(key, 1, 'string')
	assert(BetterWorldQuests:AreOptionsLoaded(), "options aren't loaded")
	assert(_G[self.registeredVariables][key] ~= nil, "key doesn't exist")
	return _G[self.registeredVariables][key]
end

--[[ namespace:SetOption(_key_, _value_)
Sets a new `value` to the given options `key`.
--]]
function BetterWorldQuests:SetOption(key, value)
	BetterWorldQuests:ArgCheck(key, 1, 'string')
	assert(BetterWorldQuests:AreOptionsLoaded(), "options aren't loaded")
	assert(_G[self.registeredVariables][key] ~= nil, "key doesn't exist")

	_G[self.registeredVariables][key] = value -- this circumvents the setting system, bad?
	BetterWorldQuests:TriggerOptionCallback(key, value)
end

--[[ namespace:AreOptionsLoaded()
Checks to see if the savedvariables has been loaded in the game.
--]]
function BetterWorldQuests:AreOptionsLoaded()
	return (not not self.registeredVariables) and (not not _G[self.registeredVariables])
end

--[[ namespace:RegisterOptionCallback(_key_, _callback_)
Register a `callback` function with the option `key`.
--]]
function BetterWorldQuests:RegisterOptionCallback(key, callback)
	BetterWorldQuests:ArgCheck(key, 1, 'string')
	BetterWorldQuests:ArgCheck(callback, 2, 'function')

	if not self.settingsCallbacks then
		self.settingsCallbacks = {}
	end

	if not self.settingsCallbacks[key] then
		self.settingsCallbacks[key] = {}
	end

	table.insert(self.settingsCallbacks[key], callback)
end

--[[ namespace:TriggerOptionCallbacks(_key_, _value_)
Trigger all registered option callbacks for the given `key`, supplying the `value`.
--]]
function BetterWorldQuests:TriggerOptionCallback(key, value)
	BetterWorldQuests:ArgCheck(key, 1, 'string')

	if self.settingsCallbacks and self.settingsCallbacks[key] then
		for _, callback in next, self.settingsCallbacks[key] do
			local successful, ret = pcall(callback, value)
			if not successful then
				error(ret)
			end
		end
	end
end

do
	-- sliders aren't supported in menus, so we create our own custom element
	local function resetSlider(frame)
		frame.slider:UnregisterCallback('OnValueChanged', frame)
		frame.slider:Release()
	end

	local function createSlider(root, name, getter, setter, minValue, maxValue, steps, formatter)
		local element = root:CreateButton(name):CreateFrame()
		if BetterWorldQuests:HasBuild(57361, 110007) then
			element:AddResetter(resetSlider)
		end
		element:AddInitializer(function(frame)
			local slider = frame:AttachTemplate('MinimalSliderWithSteppersTemplate')
			slider:SetPoint('TOPLEFT', 0, -1)
			slider:SetSize(150, 25)
			slider:RegisterCallback('OnValueChanged', setter, frame)
			slider:Init(getter(), minValue, maxValue, (maxValue - minValue) / steps, {
				[MinimalSliderWithSteppersMixin.Label.Right] = formatter
			})
			frame.slider = slider -- ref for resetter

			if not BetterWorldQuests:HasBuild(57361, 110007) then
				-- there's no way to properly reset an element from the menu, so we'll need to use
				-- a dummy element we can hook OnHide onto
				-- https://github.com/Stanzilla/WoWUIBugs/issues/652
				local dummy = frame:AttachFrame('Frame')
				dummy:SetScript('OnHide', function()
					resetSlider(frame)
				end)
			end

			local pad = 30 -- for the label
			return slider:GetWidth() + pad, slider:GetHeight()
		end)

		return element
	end

	local function colorPickerClick(data)
		ColorPickerFrame:SetupColorPickerAndShow(data)
	end
	local function colorPickerChange(setting)
		local r, g, b = ColorPickerFrame:GetColorRGB()
		if #setting.default == 8 then
			local a = ColorPickerFrame:GetColorAlpha()
			BetterWorldQuests:SetOption(setting.key, BetterWorldQuests:CreateColor(r, g, b, a):GenerateHexColor())
		else
			BetterWorldQuests:SetOption(setting.key, BetterWorldQuests:CreateColor(r, g, b):GenerateHexColorNoAlpha())
		end
	end
	local function colorPickerReset(setting, previousColor)
		local color = BetterWorldQuests:CreateColor(previousColor)
		if #setting.default == 8 then
			BetterWorldQuests:SetOption(setting.key, color:GenerateHexColor())
		else
			BetterWorldQuests:SetOption(setting.key, color:GenerateHexColorNoAlpha())
		end
	end

	local function menuGetter(setting, value)
		return BetterWorldQuests:GetOption(setting.key) == value
	end
	local function menuSetter(setting, value)
		BetterWorldQuests:SetOption(setting.key, value)
	end

	local function registerMapSettings(savedvariable, settings)
		if not BetterWorldQuests.registeredVariables then
			-- these savedvariables are not handled by other means, let's deal with defaults and
			-- merging ourselves
			if not _G[savedvariable] then
				_G[savedvariable] = {}
			end

			for _, setting in next, settings do
				-- merge or default
				if _G[savedvariable][setting.key] == nil then
					_G[savedvariable][setting.key] = setting.default
				end
			end

			BetterWorldQuests.registeredVariables = savedvariable
		end

		-- TODO: menus also has "new feature" flags/textures, see if we can hook into that

		Menu.ModifyMenu('MENU_WORLD_MAP_TRACKING', function(_, root)
			root:CreateDivider()
			root:CreateTitle((addonName:gsub('(%l)(%u)', '%1 %2')) .. HEADER_COLON)

			for _, setting in next, settings do
				if setting.type == 'toggle' then
					root:CreateCheckbox(setting.title, function()
						return BetterWorldQuests:GetOption(setting.key)
					end, function()
						BetterWorldQuests:SetOption(setting.key, not BetterWorldQuests:GetOption(setting.key))
					end)
				elseif setting.type == 'slider' then
					local formatter
					if type(setting.valueFormat) == 'string' then
						formatter = GenerateClosure(formatCustom, setting.valueFormat)
					elseif type(setting.valueFormat) == 'function' then
						formatter = setting.valueFormat
					end

					createSlider(root, setting.title, function()
						return BetterWorldQuests:GetOption(setting.key)
					end, function(_, value)
						BetterWorldQuests:SetOption(setting.key, value)
					end, setting.minValue, setting.maxValue, setting.valueStep or 1, formatter)
				elseif setting.type == 'color' then
					local value = BetterWorldQuests:GetOption(setting.key)
					local r, g, b, a = BetterWorldQuests:CreateColor(value):GetRGBA()
					root:CreateColorSwatch(setting.title, colorPickerClick, {
						swatchFunc = GenerateClosure(colorPickerChange, setting),
						opacityFunc = GenerateClosure(colorPickerChange, setting),
						cancelFunc = GenerateClosure(colorPickerReset, setting),
						r = r,
						g = g,
						b = b,
						opacity = a,
						hasOpacity = #value == 8,
					})
				elseif setting.type == 'menu' then
					local menu = root:CreateButton(setting.title)
					for _, option in next, setting.options do
						menu:CreateRadio(
							option.label,
							GenerateClosure(menuGetter, setting),
							GenerateClosure(menuSetter, setting),
							option.value
						)
					end
				end
			end
		end)
	end

	--[[ namespace:RegisterMapSettings(_savedvariable_, _settings_)
	Registers a set of `settings` to inject into the world map tracking menu.
	The values will be stored by the `settings`' objects' `key` in `savedvariables`.

	The `settings` object is identical to the one for [RegisterSetting](namespaceregistersettingssavedvariables-settings).  
	--]]
	function BetterWorldQuests:RegisterMapSettings(savedvariable, settings)
		BetterWorldQuests:ArgCheck(savedvariable, 1, 'string')
		BetterWorldQuests:ArgCheck(settings, 2, 'table')

		-- ensure we only add the settings after savedvariables are available to the client
		local _, isReady = C_AddOns.IsAddOnLoaded(addonName)
		if isReady then
			registerMapSettings(savedvariable, settings)
		else
			-- don't abuse OnLoad internally
			BetterWorldQuests:RegisterEvent('ADDON_LOADED', function(_, name)
				if name == addonName then
					registerMapSettings(savedvariable, settings)
					return true -- unregister
				end
			end)
		end
	end
end




--[[ namespace:tsize(_table_)
Returns the number of entries in the `table`.  
Works for associative tables as opposed to `#table`.
--]]
function BetterWorldQuests:tsize(tbl)
	-- would really like Lua 5.2 for this
	local size = 0
	if tbl then
		for _ in next, tbl do
			size = size + 1
		end
	end
	return size
end

--[[ namespace:startswith(_str_, _contents_)
Checks if the first string starts with the 2nd string.
--]]
function BetterWorldQuests:startswith(str, contents)
	return str:sub(1, contents:len()) == contents
end




-- easy frame "removal"
local hidden = CreateFrame('Frame')
hidden:Hide()

--[[ namespace:Hide(_object_[, _child_,...])
Forcefully hide an `object`, or its `child`.  
It will recurse down to the last child if provided.
--]]
function BetterWorldQuests:Hide(object, ...)
	if type(object) == 'string' then
		object = _G[object]
	end

	if ... then
		-- iterate through arguments, they're children referenced by key
		for index = 1, select('#', ...) do
			object = object[select(index, ...)]
		end
	end

	if object then
		object:SetParent(hidden)
		object.SetParent = nop

		if object.UnregisterAllEvents then
			object:UnregisterAllEvents()
		end
	end
end

local CONTINENTS = {
	-- list of all continents and their sub-zones that have world quests
	[2274] = { -- Khaz Algar
		[2248] = true, -- Isle of Dorn
		[2215] = true, -- Hallowfall
		[2214] = true, -- The Ringing Deeps
		[2255] = true, -- Azj-Kahet
		[2256] = true, -- Azj-Kahet - Lower
		[2213] = true, -- City of Threads
		[2216] = true, -- City of Threads - Lower
	},
	[1978] = { -- Dragon Isles
		[2022] = true, -- The Walking Shores
		[2023] = true, -- Ohn'ahran Plains
		[2024] = true, -- The Azure Span
		[2025] = true, -- Thaldraszus
		[2151] = true, -- The Forbidden Reach
	},
	[1550] = { -- Shadowlands
		[1525] = true, -- Revendreth
		[1533] = true, -- Bastion
		[1536] = true, -- Maldraxxus
		[1565] = true, -- Ardenwald
		[1543] = true, -- The Maw
	},
	[619] = { -- Broken Isles
		[630] = true, -- Azsuna
		[641] = true, -- Val'sharah
		[650] = true, -- Highmountain
		[634] = true, -- Stormheim
		[680] = true, -- Suramar
		[627] = true, -- Dalaran
		[790] = true, -- Eye of Azshara (world version)
		[646] = true, -- Broken Shore
	},
	[424] = { -- Pandaria
		[1530] = true, -- Vale of Eternal Blossoms (BfA)
	},
	[875] = { -- Zandalar
		[862] = true, -- Zuldazar
		[864] = true, -- Vol'Dun
		[863] = true, -- Nazmir
	},
	[876] = { -- Kul Tiras
		[895] = true, -- Tiragarde Sound
		[896] = true, -- Drustvar
		[942] = true, -- Stormsong Valley
	},
	[13] = { -- Eastern Kingdoms
		[14] = true, -- Arathi Highlands (Warfronts)
	},
	[12] = { -- Kalimdor
		[62] = true, -- Darkshore (Warfronts)
		[1527] = true, -- Uldum (BfA)
	},
	[947] = { -- Azeroth
		[13] = true, -- Eastern Kingdoms
		[12] = true, -- Kalimdor
		[619] = true, -- Broken Isles
		[875] = true, -- Zandalar
		[876] = true, -- Kul Tiras
		[424] = true, -- Pandaria
		[1978] = true, -- Dragon Isles
		[2274] = true, -- Khaz Algar
	},
}

function BetterWorldQuests:IsParentMap(mapID)
	return not not CONTINENTS[mapID]
end

function BetterWorldQuests:IsChildMap(parentMapID, mapID)
	local mapInfo = C_Map.GetMapInfo(mapID)
	return parentMapID and mapID and mapInfo and mapInfo.parentMapID and mapInfo.parentMapID == parentMapID
end

function BetterWorldQuests:TranslatePosition(position, fromMapID, toMapID)
	local continentID, worldPos = C_Map.GetWorldPosFromMapPos(fromMapID, position)
	local _, newPos = C_Map.GetMapPosFromWorldPos(continentID, worldPos, toMapID)
	return newPos
end




local BWQL ={}
if GetLocale() == "zhCN" then
BWQL['Map pin scale'] = '地图任务标记缩放'
BWQL['The scale of world quest pins on the current map'] = '当前地图上世界任务标记的缩放比例'
BWQL['Overview pin scale'] = '概览地图任务标记缩放'
BWQL['The scale of world quest pins on a parent/continent map'] = '在主地图/大陆地图上的世界任务标记的缩放比例'
BWQL['Pin size zoom factor'] = '任务标记缩放比例'
BWQL['How much extra scale to apply when map is zoomed'] = '当放大地图时任务标记的额外缩放比例'
BWQL['Show events on continent'] = '在大陆地图上显示事件'
BWQL['Show on Azeroth'] = '在艾泽拉斯上显示'
BWQL['Hold key to hide'] = '按住此键隐藏'
BWQL['Hold this key to temporarily hide all world quests'] = '按住此键临时隐藏所有世界任务'
elseif GetLocale() == "zhTW" then
BWQL['Map pin scale'] = '地圖標記點大小'
BWQL['The scale of world quest pins on the current map'] = '在當前地圖的世界任務標記點大小'
BWQL['Overview pin scale'] = '總覽標記點大小'
BWQL['The scale of world quest pins on a parent/continent map'] = '在大陸地圖的世界任務標記點大小'
BWQL['Pin size zoom factor'] = '標記點大小縮放係數'
BWQL['How much extra scale to apply when map is zoomed'] = '縮放地圖時要應用多少額外的縮放'
else
BWQL['Map pin scale'] = '地圖標記點大小'
BWQL['The scale of world quest pins on the current map'] = '在當前地圖的世界任務標記點大小'
BWQL['Overview pin scale'] = '總覽標記點大小'
BWQL['The scale of world quest pins on a parent/continent map'] = '在大陸地圖的世界任務標記點大小'
BWQL['Pin size zoom factor'] = '標記點大小縮放係數'
BWQL['How much extra scale to apply when map is zoomed'] = '縮放地圖時要應用多少額外的縮放'
end

local function formatPercentage(value)
	return PERCENTAGE_STRING:format(math.floor((value * 100) + 0.5))
end

local settings = {
	{
		key = 'mapScale',
		type = 'slider',
		title = BWQL['Map pin scale'],
		tooltip = BWQL['The scale of world quest pins on the current map'],
		default = 1.5,
		minValue = 0.1,
		maxValue = 3,
		valueStep = 0.01,
		valueFormat = formatPercentage,
	},
	{
		key = 'parentScale',
		type = 'slider',
		title = BWQL['Overview pin scale'],
		tooltip = BWQL['The scale of world quest pins on a parent/continent map'],
		default = 1,
		minValue = 0.1,
		maxValue = 3,
		valueStep = 0.01,
		valueFormat = formatPercentage,
	},
	{
		key = 'zoomFactor',
		type = 'slider',
		title = BWQL['Pin size zoom factor'],
		tooltip = BWQL['How much extra scale to apply when map is zoomed'],
		default = 0.5,
		minValue = 0,
		maxValue = 1,
		valueStep = 0.01,
		valueFormat = formatPercentage,
	},
	{
		key = 'showEvents',
		type = 'toggle',
		title = BWQL['Show events on continent'],
		default = false,
	},
	{
		key = 'showAzeroth',
		type = 'toggle',
		title = BWQL['Show on Azeroth'],
		default = false,
	},
	{
		key = 'hideModifier',
		type = 'menu',
		title = BWQL['Hold key to hide'],
		tooltip = BWQL['Hold this key to temporarily hide all world quests'],
		default = 'NEVER',
		options = {
			{value='NEVER', label=NEVER},
			{value='ALT', label=ALT_KEY},
			{value='CTRL', label=CTRL_KEY},
			{value='SHIFT', label=SHIFT_KEY},
		},
	},
}

BetterWorldQuests:RegisterSettings('BetterWorldQuestsDB', settings)
BetterWorldQuests:RegisterSettingsSlash('/betterworldquests', '/bwq')
BetterWorldQuests:RegisterMapSettings('BetterWorldQuestsDB', settings)




local showAzeroth
BetterWorldQuests:RegisterOptionCallback('showAzeroth', function(value)
	showAzeroth = value
end)

local provider = CreateFromMixins(WorldMap_WorldQuestDataProviderMixin)
provider:SetMatchWorldMapFilters(true)
provider:SetUsesSpellEffect(true)
provider:SetCheckBounties(true)

-- override GetPinTemplate to use our custom pin
function provider:GetPinTemplate()
	return 'BetterWorldQuestPinTemplate'
end

-- override ShouldOverrideShowQuest method to show pins on continent maps
function provider:ShouldOverrideShowQuest()
	-- just nop so we don't hit the default
end

-- override ShouldShowQuest method to show pins on parent maps
function provider:ShouldShowQuest(questInfo)
	local mapID = self:GetMap():GetMapID()
	if mapID == 947 then
		-- TODO: change option to only show when there's few?
		return showAzeroth
	end

	if WorldQuestDataProviderMixin.ShouldShowQuest(self, questInfo) then -- super
		return true
	end

	local mapInfo = C_Map.GetMapInfo(mapID)
	if mapInfo.mapType == Enum.UIMapType.Continent then
		return true
	end

	return BetterWorldQuests:IsChildMap(mapID, questInfo.mapID)
end

-- remove the default provider
for dp in next, WorldMapFrame.dataProviders do
	if not dp.GetPinTemplates and type(dp.GetPinTemplate) == 'function' then
		if dp:GetPinTemplate() == 'WorldMap_WorldQuestPinTemplate' then
			WorldMapFrame:RemoveDataProvider(dp)
			break
		end
	end
end

-- add our own
WorldMapFrame:AddDataProvider(provider)

-- hook into changes
local function updateVisuals()
	-- update pins on changes
	if WorldMapFrame:IsShown() then
		provider:RefreshAllData()

		for pin in WorldMapFrame:EnumeratePinsByTemplate(provider:GetPinTemplate()) do
			pin:RefreshVisuals()
			pin:ApplyCurrentScale()
		end
	end
end

BetterWorldQuests:RegisterOptionCallback('mapScale', updateVisuals)
BetterWorldQuests:RegisterOptionCallback('parentScale', updateVisuals)
BetterWorldQuests:RegisterOptionCallback('zoomFactor', updateVisuals)
BetterWorldQuests:RegisterOptionCallback('showAzeroth', updateVisuals)
BetterWorldQuests:RegisterOptionCallback('showEvents', updateVisuals)

-- change visibility
local modifier
local function toggleVisibility()
	local state = true
	if modifier == 'ALT' then
		state = not IsAltKeyDown()
	elseif modifier == 'SHIFT' then
		state = not IsShiftKeyDown()
	elseif modifier == 'CTRL' then
		state = not IsControlKeyDown()
	end

	for pin in WorldMapFrame:EnumeratePinsByTemplate(provider:GetPinTemplate()) do
		pin:SetShown(state)
	end
end

WorldMapFrame:HookScript('OnHide', function()
	toggleVisibility()
end)

BetterWorldQuests:RegisterOptionCallback('hideModifier', function(value)
	if value == 'NEVER' then
		if BetterWorldQuests:IsEventRegistered('MODIFIER_STATE_CHANGED', toggleVisibility) then
			BetterWorldQuests:UnregisterEvent('MODIFIER_STATE_CHANGED', toggleVisibility)
		end

		modifier = nil
		toggleVisibility()
	else
		if not BetterWorldQuests:IsEventRegistered('MODIFIER_STATE_CHANGED', toggleVisibility) then
			BetterWorldQuests:RegisterEvent('MODIFIER_STATE_CHANGED', toggleVisibility)
		end

		modifier = value
	end
end)




local FACTION_ASSAULT_ATLAS = UnitFactionGroup('player') == 'Horde' and 'worldquest-icon-horde' or 'worldquest-icon-alliance'

local mapScale, parentScale, zoomFactor
BetterWorldQuests:RegisterOptionCallback('mapScale', function(value)
	mapScale = value
end)
BetterWorldQuests:RegisterOptionCallback('parentScale', function(value)
	parentScale = value
end)
BetterWorldQuests:RegisterOptionCallback('zoomFactor', function(value)
	zoomFactor = value
end)

BetterWorldQuestPinMixin = CreateFromMixins(WorldMap_WorldQuestPinMixin)
function BetterWorldQuestPinMixin:OnLoad()
	WorldMap_WorldQuestPinMixin.OnLoad(self) -- super

	-- recreate WorldQuestPinTemplate regions
	local TrackedCheck = self:CreateTexture(nil, 'OVERLAY', nil, 7)
	TrackedCheck:SetPoint('BOTTOM', self, 'BOTTOMRIGHT', 0, -2)
	TrackedCheck:SetAtlas('worldquest-emissary-tracker-checkmark', true)
	TrackedCheck:Hide()
	self.TrackedCheck = TrackedCheck

	local TimeLowFrame = CreateFrame('Frame', nil, self)
	TimeLowFrame:SetPoint('CENTER', 9, -9)
	TimeLowFrame:SetSize(22, 22)
	TimeLowFrame:Hide()
	self.TimeLowFrame = TimeLowFrame

	local TimeLowIcon = TimeLowFrame:CreateTexture(nil, 'OVERLAY')
	TimeLowIcon:SetAllPoints()
	TimeLowIcon:SetAtlas('worldquest-icon-clock')
	TimeLowFrame.Icon = TimeLowIcon

	-- add our own widgets
	local Reward = self:CreateTexture(nil, 'OVERLAY')
	Reward:SetPoint('CENTER', self.PushedTexture)
	Reward:SetSize(self:GetWidth() - 4, self:GetHeight() - 4)
	Reward:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	self.Reward = Reward

	local RewardMask = self:CreateMaskTexture()
	RewardMask:SetTexture([[Interface\CharacterFrame\TempPortraitAlphaMask]])
	RewardMask:SetAllPoints(Reward)
	Reward:AddMaskTexture(RewardMask)

	local Indicator = self:CreateTexture(nil, 'OVERLAY', nil, 2)
	Indicator:SetPoint('CENTER', self, 'TOPLEFT', 4, -4)
	self.Indicator = Indicator

	local Reputation = self:CreateTexture(nil, 'OVERLAY', nil, 2)
	Reputation:SetPoint('CENTER', self, 'BOTTOM', 0, 2)
	Reputation:SetSize(10, 10)
	Reputation:SetAtlas('socialqueuing-icon-eye')
	Reputation:Hide()
	self.Reputation = Reputation

	local Bounty = self:CreateTexture(nil, 'OVERLAY', nil, 3)
	Bounty:SetAtlas('QuestNormal', true)
	Bounty:SetScale(0.65)
	Bounty:SetPoint('LEFT', self, 'RIGHT', -(Bounty:GetWidth() / 2), 0)
	self.Bounty = Bounty
end

function BetterWorldQuestPinMixin:RefreshVisuals()
	WorldMap_WorldQuestPinMixin.RefreshVisuals(self) -- super

	-- hide optional elements by default
	self.Bounty:Hide()
	self.Reward:Hide()
	self.Reputation:Hide()
	self.Indicator:Hide()
	self.Display.Icon:Hide()

	-- update scale
	local mapID = self:GetMap():GetMapID()
	if mapID == 947 then
		self:SetScalingLimits(1, parentScale / 2, (parentScale / 2) + zoomFactor)
	elseif BetterWorldQuests:IsParentMap(mapID) then
		self:SetScalingLimits(1, parentScale, parentScale + zoomFactor)
	else
		self:SetScalingLimits(1, mapScale, mapScale + zoomFactor)
	end

	-- uniform coloring
	if self:IsSelected() then
		self.NormalTexture:SetAtlas('worldquest-questmarker-epic-supertracked', true)
	else
		self.NormalTexture:SetAtlas('worldquest-questmarker-epic', true)
	end

	-- set reward icon
	local questID = self.questID
	local currencyRewards = C_QuestLog.GetQuestRewardCurrencies(questID)
	if GetNumQuestLogRewards(questID) > 0 then
		local _, texture, _, _, _, itemID = GetQuestLogRewardInfo(1, questID)
		if C_Item.IsAnimaItemByID(itemID) then
			texture = 3528287 -- from item "Resonating Anima Core"
		end

		self.Reward:SetTexture(texture)
		self.Reward:Show()
	elseif #currencyRewards > 0 then
		self.Reward:SetTexture(currencyRewards[1].texture)
		self.Reward:Show()
	elseif GetQuestLogRewardMoney(questID) > 0 then
		self.Reward:SetTexture([[Interface\Icons\INV_MISC_COIN_01]])
		self.Reward:Show()
	else
		-- if there are no rewards just show the default icon
		self.Display.Icon:Show()
	end

	-- set world quest type indicator
	local questInfo = C_QuestLog.GetQuestTagInfo(questID)
	if questInfo then
		if questInfo.worldQuestType == Enum.QuestTagType.PvP then
			self.Indicator:SetAtlas('Warfronts-BaseMapIcons-Empty-Barracks-Minimap')
			self.Indicator:SetSize(18, 18)
			self.Indicator:Show()
		elseif questInfo.worldQuestType == Enum.QuestTagType.PetBattle then
			self.Indicator:SetAtlas('WildBattlePetCapturable')
			self.Indicator:SetSize(10, 10)
			self.Indicator:Show()
		elseif questInfo.worldQuestType == Enum.QuestTagType.Profession then
			self.Indicator:SetAtlas(WORLD_QUEST_ICONS_BY_PROFESSION[questInfo.tradeskillLineID])
			self.Indicator:SetSize(10, 10)
			self.Indicator:Show()
		elseif questInfo.worldQuestType == Enum.QuestTagType.Dungeon then
			self.Indicator:SetAtlas('Dungeon')
			self.Indicator:SetSize(20, 20)
			self.Indicator:Show()
		elseif questInfo.worldQuestType == Enum.QuestTagType.Raid then
			self.Indicator:SetAtlas('Raid')
			self.Indicator:SetSize(20, 20)
			self.Indicator:Show()
		elseif questInfo.worldQuestType == Enum.QuestTagType.Invasion then
			self.Indicator:SetAtlas('worldquest-icon-burninglegion')
			self.Indicator:SetSize(10, 10)
			self.Indicator:Show()
		elseif questInfo.worldQuestType == Enum.QuestTagType.FactionAssault then
			self.Indicator:SetAtlas(FACTION_ASSAULT_ATLAS)
			self.Indicator:SetSize(10, 10)
			self.Indicator:Show()
		end
	end

	-- update bounty icon
	local bountyQuestID = self.dataProvider:GetBountyInfo()
	if bountyQuestID and C_QuestLog.IsQuestCriteriaForBounty(questID, bountyQuestID) then
		self.Bounty:Show()
	end

	-- highlight reputation
	local _, factionID = C_TaskQuest.GetQuestInfoByQuestID(questID)
	if factionID then
		local factionInfo = C_Reputation.GetFactionDataByID(factionID)
		if factionInfo and factionInfo.isWatched then
			self.Reputation:Show()
		end
	end
end

function BetterWorldQuestPinMixin:AddIconWidgets()
	-- remove the obnoxious glow behind world bosses
end

function BetterWorldQuestPinMixin:SetPassThroughButtons()
	-- https://github.com/Stanzilla/WoWUIBugs/issues/453
end



local HBD = LibStub('HereBeDragons-2.0')

local DRAGON_ISLES_MAPS = {
	[2022] = true, -- The Walking Shores
	[2023] = true, -- Ohn'ahran Plains
	[2024] = true, -- The Azure Span
	[2025] = true, -- Thaldraszus
}

local function updatePOIs(self)
	local map = self:GetMap()
	local mapID = map:GetMapID()
	if mapID == 1978 then -- Dragon Isles
		for childMapID in next, DRAGON_ISLES_MAPS do
			for _, poiID in next, C_AreaPoiInfo.GetAreaPOIForMap(childMapID) do
				local info = C_AreaPoiInfo.GetAreaPOIInfo(childMapID, poiID)
				if info and BetterWorldQuests:startswith(info.atlasName, 'ElementalStorm') then
					local x, y = info.position:GetXY()
					info.dataProvider = self
					info.position:SetXY(HBD:TranslateZoneCoordinates(x, y, childMapID, mapID))
					map:AcquirePin(self:GetPinTemplate(), info)
				end
			end
		end
	end
end

for dp in next, WorldMapFrame.dataProviders do
	if not dp.GetPinTemplates and type(dp.GetPinTemplate) == 'function' then
		if dp:GetPinTemplate() == 'AreaPOIPinTemplate' then
			hooksecurefunc(dp, 'RefreshAllData', updatePOIs)
			break
		end
	end
end




local SPECIAL_ASSIGNMENT_WIDGET_SET = 1108

local provider = CreateFromMixins(AreaPOIDataProviderMixin)
function provider:GetPinTemplate()
	return 'BetterWorldQuestPOITemplate'
end

function provider:RefreshAllData()
	self:RemoveAllData()

	local map = self:GetMap()
	local mapID = map:GetMapID()

	if mapID == 947 then
		return
	end

	if BetterWorldQuests:IsParentMap(mapID) then
		for _, mapInfo in next, C_Map.GetMapChildrenInfo(mapID, Enum.UIMapType.Zone, true) do
			if mapInfo.flags == 6 or mapInfo.flags == 4 then -- TODO: do bitwise compare with 0x04
				-- copy from AreaPOIDataProviderMixin
				for _, poiID in next, GetAreaPOIsForPlayerByMapIDCached(mapInfo.mapID) do
					local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapInfo.mapID, poiID)
					if poiInfo and poiInfo.tooltipWidgetSet == SPECIAL_ASSIGNMENT_WIDGET_SET then
						poiInfo.dataProvider = self

						-- translate position
						poiInfo.position = BetterWorldQuests:TranslatePosition(poiInfo.position, mapInfo.mapID, mapID)

						if poiInfo.position then
							map:AcquirePin(self:GetPinTemplate(), poiInfo)
						end
					end
				end
			end
		end
	end
end

WorldMapFrame:AddDataProvider(provider)

-- hook into changes
local function updateVisuals()
	-- update pins on changes
	if WorldMapFrame:IsShown() then
		provider:RefreshAllData()
	end
end

BetterWorldQuests:RegisterOptionCallback('showEvents', updateVisuals)

-- change visibility
local modifier
local function toggleVisibility()
	local state = true
	if modifier == 'ALT' then
		state = not IsAltKeyDown()
	elseif modifier == 'SHIFT' then
		state = not IsShiftKeyDown()
	elseif modifier == 'CTRL' then
		state = not IsControlKeyDown()
	end

	for pin in WorldMapFrame:EnumeratePinsByTemplate(provider:GetPinTemplate()) do
		pin:SetShown(state)
	end

	for pin in WorldMapFrame:EnumeratePinsByTemplate('AreaPOIPinTemplate') do
		local poiInfo = pin:GetPoiInfo()
		if poiInfo and poiInfo.tooltipWidgetSet == SPECIAL_ASSIGNMENT_WIDGET_SET then
			pin:SetShown(state)
		end
	end
end

WorldMapFrame:HookScript('OnHide', function()
	toggleVisibility()
end)

BetterWorldQuests:RegisterOptionCallback('hideModifier', function(value)
	if value == 'NEVER' then
		if BetterWorldQuests:IsEventRegistered('MODIFIER_STATE_CHANGED', toggleVisibility) then
			BetterWorldQuests:UnregisterEvent('MODIFIER_STATE_CHANGED', toggleVisibility)
		end

		modifier = nil
		toggleVisibility()
	else
		if not BetterWorldQuests:IsEventRegistered('MODIFIER_STATE_CHANGED', toggleVisibility) then
			BetterWorldQuests:RegisterEvent('MODIFIER_STATE_CHANGED', toggleVisibility)
		end

		modifier = value
	end
end)




local showEvents
BetterWorldQuests:RegisterOptionCallback('showEvents', function(value)
	showEvents = value
end)

local provider = CreateFromMixins(AreaPOIEventDataProviderMixin)
function provider:GetPinTemplate()
	return 'BetterWorldQuestEventTemplate'
end

function provider:RefreshAllData()
	self:RemoveAllData()

	if not showEvents then
		return
	end

	local map = self:GetMap()
	local mapID = map:GetMapID()

	if mapID == 947 then
		return
	end

	if BetterWorldQuests:IsParentMap(mapID) then
		for _, mapInfo in next, C_Map.GetMapChildrenInfo(mapID, Enum.UIMapType.Zone, true) do
			if mapInfo.flags == 6 or mapInfo.flags == 4 then -- TODO: do bitwise compare with 0x04
				-- copy from AreaPOIDataProviderMixin
				for _, poiID in next, C_AreaPoiInfo.GetEventsForMap(mapInfo.mapID) do
					local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapInfo.mapID, poiID)
					if poiInfo then
						poiInfo.dataProvider = self

						-- translate position
						poiInfo.position = BetterWorldQuests:TranslatePosition(poiInfo.position, mapInfo.mapID, mapID)

						if poiInfo.position then
							map:AcquirePin(self:GetPinTemplate(), poiInfo)
						end
					end
				end
			end
		end
	end
end

WorldMapFrame:AddDataProvider(provider)

-- hook into changes
local function updateVisuals()
	-- update pins on changes
	if WorldMapFrame:IsShown() then
		provider:RefreshAllData()
	end
end

BetterWorldQuests:RegisterOptionCallback('showEvents', updateVisuals)

-- change visibility
local modifier
local function toggleVisibility()
	local state = true
	if modifier == 'ALT' then
		state = not IsAltKeyDown()
	elseif modifier == 'SHIFT' then
		state = not IsShiftKeyDown()
	elseif modifier == 'CTRL' then
		state = not IsControlKeyDown()
	end

	for pin in WorldMapFrame:EnumeratePinsByTemplate(provider:GetPinTemplate()) do
		pin:SetShown(state)
	end
end

WorldMapFrame:HookScript('OnHide', function()
	toggleVisibility()
end)

BetterWorldQuests:RegisterOptionCallback('hideModifier', function(value)
	if value == 'NEVER' then
		if BetterWorldQuests:IsEventRegistered('MODIFIER_STATE_CHANGED', toggleVisibility) then
			BetterWorldQuests:UnregisterEvent('MODIFIER_STATE_CHANGED', toggleVisibility)
		end

		modifier = nil
		toggleVisibility()
	else
		if not BetterWorldQuests:IsEventRegistered('MODIFIER_STATE_CHANGED', toggleVisibility) then
			BetterWorldQuests:RegisterEvent('MODIFIER_STATE_CHANGED', toggleVisibility)
		end

		modifier = value
	end
end)
