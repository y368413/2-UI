local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:RegisterModule("AurasTable")

local pairs, next, format, wipe, unpack = pairs, next, format, wipe, unpack
local GetSpellInfo = GetSpellInfo
local EJ_GetInstanceInfo = EJ_GetInstanceInfo

-- AuraWatch
local AuraWatchList = {}
local groups = {
	-- groups name = direction, interval, mode, iconsize, position, barwidth
	["ClassBar"] = {"RIGHT", 6, "ICON", 36, R.Auras.ClassBarPos},
	["Player Aura"] = {"UP", 2, "BAR2", 21, R.Auras.PlayerAuraPos, 60},
	["Target Aura"] = {"UP", 2, "BAR", 28, R.Auras.TargetAuraPos, 80},
	["Special Aura"] = {"UP", 2, "BAR2", 28, R.Auras.SpecialPos, 80},
	["Focus Aura"] = {"UP", 2, "BAR", 21, R.Auras.FocusPos, 60},
	["Spell Cooldown"] = {"LEFT", 2, "ICON", 32, R.Auras.CDPos},
	["Enchant Aura"] = {"UP", 2, "ICON", 32, R.Auras.EnchantPos},	
	["Raid Buff"] = {"UP", 2, "ICON", 36, R.Auras.RaidBuffPos},
	["Raid Debuff"] = {"UP", 2, "ICON", 36, R.Auras.RaidDebuffPos},
	["Warning"] = {"UP", 2, "ICON", 32, R.Auras.WarningPos},
	["InternalCD"] = {"DOWN", 2, "BAR2", 16, R.Auras.InternalPos, 120},
	["Absorb"] = {"DOWN", 2, "TEXT", 21, R.Auras.AbsorbPos},
	["Shield"] = {"DOWN", 2, "TEXT", 21, R.Auras.ShieldPos},
}

local function newAuraFormat(value)
	local newTable = {}
	for _, v in pairs(value) do
		local id = v.AuraID or v.SpellID or v.ItemID or v.SlotID or v.TotemID or v.IntID
		if id then
			newTable[id] = v
		end
	end
	return newTable
end

function module:AddNewAuraWatch(class, list)
	for _, k in pairs(list) do
		for _, v in pairs(k) do
			local spellID = v.AuraID or v.SpellID
			if spellID then
				local name = GetSpellInfo(spellID)
				if not name then
					wipe(v)
					if I.isDeveloper then print(format("|cffFF0000XXX:|r '%s' %s", class, spellID)) end
				end
			end
		end
	end

	if class ~= "ALL" and class ~= I.MyClass then return end
	if not AuraWatchList[class] then AuraWatchList[class] = {} end

	for name, v in pairs(list) do
		local direction, interval, mode, size, pos, width = unpack(groups[name])
		tinsert(AuraWatchList[class], {
			Name = name,
			Direction = direction,
			Interval = interval,
			Mode = mode,
			IconSize = size,
			Pos = pos,
			BarWidth = width,
			List = newAuraFormat(v)
		})
	end
end

function module:AddDeprecatedGroup()
	if R.db["AuraWatch"]["DeprecatedAuras"] then
		for name, value in pairs(R.DeprecatedAuras) do
			for _, list in pairs(AuraWatchList["ALL"]) do
				if list.Name == name then
					local newTable = newAuraFormat(value)
					for spellID, v in pairs(newTable) do
						list.List[spellID] = v
					end
				end
			end
		end
	end
	wipe(R.DeprecatedAuras)
end

-- RaidFrame spells
local RaidBuffs = {}
function module:AddClassSpells(list)
	for class, value in pairs(list) do
		RaidBuffs[class] = value
	end
end

-- RaidFrame debuffs
local RaidDebuffs = {}
function module:RegisterDebuff(_, instID, _, spellID, level)
	local instName = EJ_GetInstanceInfo(instID)
	if not instName then
		if I.isDeveloper then print("Invalid instance ID: "..instID) end
		return
	end

	if not RaidDebuffs[instName] then RaidDebuffs[instName] = {} end
	if not level then level = 2 end
	if level > 6 then level = 6 end

	RaidDebuffs[instName][spellID] = level
end

-- Party watcher spells
function module:CheckPartySpells()
	for spellID, duration in pairs(R.PartySpells) do
		local name = GetSpellInfo(spellID)
		if name then
			local modDuration = MaoRUIDB["PartySpells"][spellID]
			if modDuration and modDuration == duration then
				MaoRUIDB["PartySpells"][spellID] = nil
			end
		else
			if I.isDeveloper then print("Invalid partyspell ID: "..spellID) end
		end
	end
end

function module:CheckCornerSpells()
	if not MaoRUIDB["CornerSpells"][I.MyClass] then MaoRUIDB["CornerSpells"][I.MyClass] = {} end
	local data = R.CornerBuffs[I.MyClass]
	if not data then return end

	for spellID in pairs(data) do
		local name = GetSpellInfo(spellID)
		if not name then
			if I.isDeveloper then print("Invalid cornerspell ID: "..spellID) end
		end
	end

	for spellID, value in pairs(MaoRUIDB["CornerSpells"][I.MyClass]) do
		if not next(value) and R.CornerBuffs[I.MyClass][spellID] == nil then
			MaoRUIDB["CornerSpells"][I.MyClass][spellID] = nil
		end
	end
end

function module:CheckMajorSpells()
	for spellID in pairs(R.MajorSpells) do
		local name = GetSpellInfo(spellID)
		if name then
			if MaoRUIDB["MajorSpells"][spellID] then
				MaoRUIDB["MajorSpells"][spellID] = nil
			end
		else
			if I.isDeveloper then print("Invalid majorspells ID: "..spellID) end
		end
	end

	for spellID, value in pairs(MaoRUIDB["MajorSpells"]) do
		if value == false and R.MajorSpells[spellID] == nil then
			MaoRUIDB["MajorSpells"][spellID] = nil
		end
	end
end

function module:OnLogin()
	for instName, value in pairs(RaidDebuffs) do
		for spell, priority in pairs(value) do
			if MaoRUIDB["RaidDebuffs"][instName] and MaoRUIDB["RaidDebuffs"][instName][spell] and MaoRUIDB["RaidDebuffs"][instName][spell] == priority then
				MaoRUIDB["RaidDebuffs"][instName][spell] = nil
			end
		end
	end
	for instName, value in pairs(MaoRUIDB["RaidDebuffs"]) do
		if not next(value) then
			MaoRUIDB["RaidDebuffs"][instName] = nil
		end
	end

	RaidDebuffs[0] = {} -- OTHER spells
	module:AddDeprecatedGroup()
	R.AuraWatchList = AuraWatchList
	R.RaidBuffs = RaidBuffs
	R.RaidDebuffs = RaidDebuffs

	module:CheckPartySpells()
	module:CheckCornerSpells()
	module:CheckMajorSpells()
end