local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:RegisterModule("AurasTable")

local pairs, next, format, wipe, unpack = pairs, next, format, wipe, unpack
local GetSpellName = C_Spell.GetSpellName
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
		if id and not v.Disabled then
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
				local name = GetSpellName(spellID)
				if not name and not v.Disabled then
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

-- RaidFrame debuffs
local RaidDebuffs = {}
function module:RegisterDebuff(tierID, instID, _, spellID, level)
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

function module:CheckCornerSpells()
	if not OrzUISetDB["CornerSpells"][I.MyClass] then OrzUISetDB["CornerSpells"][I.MyClass] = {} end
	local data = R.CornerBuffs[I.MyClass]
	if not data then return end

	for spellID in pairs(data) do
		local name = GetSpellName(spellID)
		if not name then
			if I.isDeveloper then print("Invalid cornerspell ID: "..spellID) end
		end
	end

	for spellID, value in pairs(OrzUISetDB["CornerSpells"][I.MyClass]) do
		if not next(value) and R.CornerBuffs[I.MyClass][spellID] == nil then
			OrzUISetDB["CornerSpells"][I.MyClass][spellID] = nil
		end
	end
end

function module:CheckMajorSpells()
	for spellID in pairs(R.MajorSpells) do
		local name = GetSpellName(spellID)
		if name then
			if OrzUISetDB["MajorSpells"][spellID] then
				OrzUISetDB["MajorSpells"][spellID] = nil
			end
		else
			if I.isDeveloper then print("Invalid majorspells ID: "..spellID) end
		end
	end

	for spellID, value in pairs(OrzUISetDB["MajorSpells"]) do
		if value == false and R.MajorSpells[spellID] == nil then
			OrzUISetDB["MajorSpells"][spellID] = nil
		end
	end
end

local function CheckNameplateFilter(list, key)
	for spellID in pairs(list) do
		local name = GetSpellName(spellID)
		if name then
			if OrzUISetDB[key][spellID] then
				OrzUISetDB[key][spellID] = nil
			end
		else
			if I.isDeveloper then print("Invalid nameplate filter ID: "..spellID) end
		end
	end

	for spellID, value in pairs(OrzUISetDB[key]) do
		if value == false and list[spellID] == nil then
			OrzUISetDB[key][spellID] = nil
		end
	end
end

local function cleanupNameplateUnits(VALUE)
	for npcID in pairs(R[VALUE]) do
		if R.db["Nameplate"][VALUE][npcID] then
			R.db["Nameplate"][VALUE][npcID] = nil
		end
	end
	for npcID, value in pairs(R.db["Nameplate"][VALUE]) do
		if value == false and R[VALUE][npcID] == nil then
			R.db["Nameplate"][VALUE][npcID] = nil
		end
	end
end

function module:CheckNameplateFilters()
	CheckNameplateFilter(R.WhiteList, "NameplateWhite")
	CheckNameplateFilter(R.BlackList, "NameplateBlack")
	cleanupNameplateUnits("CustomUnits")
	cleanupNameplateUnits("PowerUnits")
end

function module:OnLogin()
	for instName, value in pairs(RaidDebuffs) do
		for spell, priority in pairs(value) do
			if OrzUISetDB["RaidDebuffs"][instName] and OrzUISetDB["RaidDebuffs"][instName][spell] and OrzUISetDB["RaidDebuffs"][instName][spell] == priority then
				OrzUISetDB["RaidDebuffs"][instName][spell] = nil
			end
		end
	end
	for instName, value in pairs(OrzUISetDB["RaidDebuffs"]) do
		if not next(value) then
			OrzUISetDB["RaidDebuffs"][instName] = nil
		end
	end

	RaidDebuffs[0] = {} -- OTHER spells
	module:AddDeprecatedGroup()
	R.AuraWatchList = AuraWatchList
	R.RaidDebuffs = RaidDebuffs

	module:CheckCornerSpells()
	module:CheckMajorSpells()
	module:CheckNameplateFilters()
end