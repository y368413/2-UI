local MAJOR, MINOR = "AceBucket-3.0", 4
local AceBucket, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not AceBucket then return end -- No Upgrade needed

AceBucket.buckets = AceBucket.buckets or {}
AceBucket.embeds = AceBucket.embeds or {}

-- the libraries will be lazyly bound later, to avoid errors due to loading order issues
local AceEvent, AceTimer

-- Lua APIs
local tconcat = table.concat
local type, next, pairs, select = type, next, pairs, select
local tonumber, tostring, rawset = tonumber, tostring, rawset
local assert, loadstring, error = assert, loadstring, error

local bucketCache = setmetatable({}, {__mode='k'})

local xpcall = xpcall

local function errorhandler(err)
	return geterrorhandler()(err)
end

local function safecall(func, ...)
	if func then
		return xpcall(func, errorhandler, ...)
	end
end

local function FireBucket(bucket)
	local received = bucket.received
	
	-- we dont want to fire empty buckets
	if next(received) ~= nil then
		local callback = bucket.callback
		if type(callback) == "string" then
			safecall(bucket.object[callback], bucket.object, received)
		else
			safecall(callback, received)
		end
		
		for k in pairs(received) do
			received[k] = nil
		end
		
		-- if the bucket was not empty, schedule another FireBucket in interval seconds
		bucket.timer = AceTimer.ScheduleTimer(bucket, FireBucket, bucket.interval, bucket)
	else -- if it was empty, clear the timer and wait for the next event
		bucket.timer = nil
	end
end

local function BucketHandler(self, event, arg1)
	if arg1 == nil then
		arg1 = "nil"
	end
	
	self.received[arg1] = (self.received[arg1] or 0) + 1
	
	-- if we are not scheduled yet, start a timer on the interval for our bucket to be cleared
	if not self.timer then
		self.timer = AceTimer.ScheduleTimer(self, FireBucket, self.interval, self)
	end
end

local function RegisterBucket(self, event, interval, callback, isMessage)
	-- try to fetch the librarys
	if not AceEvent or not AceTimer then 
		AceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
		AceTimer = LibStub:GetLibrary("AceTimer-3.0", true)
		if not AceEvent or not AceTimer then
			error(MAJOR .. " requires AceEvent-3.0 and AceTimer-3.0", 3)
		end
	end
	
	if type(event) ~= "string" and type(event) ~= "table" then error("Usage: RegisterBucket(event, interval, callback): 'event' - string or table expected.", 3) end
	if not callback then
		if type(event) == "string" then
			callback = event
		else
			error("Usage: RegisterBucket(event, interval, callback): cannot omit callback when event is not a string.", 3)
		end
	end
	if not tonumber(interval) then error("Usage: RegisterBucket(event, interval, callback): 'interval' - number expected.", 3) end
	if type(callback) ~= "string" and type(callback) ~= "function" then error("Usage: RegisterBucket(event, interval, callback): 'callback' - string or function or nil expected.", 3) end
	if type(callback) == "string" and type(self[callback]) ~= "function" then error("Usage: RegisterBucket(event, interval, callback): 'callback' - method not found on target object.", 3) end
	
	local bucket = next(bucketCache)
	if bucket then
		bucketCache[bucket] = nil
	else
		bucket = { handler = BucketHandler, received = {} }
	end
	bucket.object, bucket.callback, bucket.interval = self, callback, tonumber(interval)
	
	local regFunc = isMessage and AceEvent.RegisterMessage or AceEvent.RegisterEvent
	
	if type(event) == "table" then
		for _,e in pairs(event) do
			regFunc(bucket, e, "handler")
		end
	else
		regFunc(bucket, event, "handler")
	end
	
	local handle = tostring(bucket)
	AceBucket.buckets[handle] = bucket
	
	return handle
end

function AceBucket:RegisterBucketEvent(event, interval, callback)
	return RegisterBucket(self, event, interval, callback, false)
end

function AceBucket:RegisterBucketMessage(message, interval, callback)
	return RegisterBucket(self, message, interval, callback, true)
end

function AceBucket:UnregisterBucket(handle)
	local bucket = AceBucket.buckets[handle]
	if bucket then
		AceEvent.UnregisterAllEvents(bucket)
		AceEvent.UnregisterAllMessages(bucket)
		
		-- clear any remaining data in the bucket
		for k in pairs(bucket.received) do
			bucket.received[k] = nil
		end
		
		if bucket.timer then
			AceTimer.CancelTimer(bucket, bucket.timer)
			bucket.timer = nil
		end
		
		AceBucket.buckets[handle] = nil
		-- store our bucket in the cache
		bucketCache[bucket] = true
	end
end

--- Unregister all buckets of the current addon object (or custom "self").
function AceBucket:UnregisterAllBuckets()
	-- hmm can we do this more efficient? (it is not done often so shouldn't matter much)
	for handle, bucket in pairs(AceBucket.buckets) do
		if bucket.object == self then
			AceBucket.UnregisterBucket(self, handle)
		end
	end
end

local mixins = {
	"RegisterBucketEvent",
	"RegisterBucketMessage", 
	"UnregisterBucket",
	"UnregisterAllBuckets",
} 

function AceBucket:Embed( target )
	for _, v in pairs( mixins ) do
		target[v] = self[v]
	end
	self.embeds[target] = true
	return target
end

function AceBucket:OnEmbedDisable( target )
	target:UnregisterAllBuckets()
end

for addon in pairs(AceBucket.embeds) do
	AceBucket:Embed(addon)
end
