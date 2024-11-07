local GetTime = GetTime
local wipe = wipe
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo
local IsUsableSpell = IsUsableSpell
local IsSpellInRange = IsSpellInRange
local HasPetSpells = HasPetSpells
local select = select
local type = type
local pairs = pairs
local ipairs = ipairs
local sort = sort
local tinsert = tinsert
local GetTalentInfo = GetTalentInfo
local strfind = strfind
local GetFlyoutInfo = GetFlyoutInfo
local GetFlyoutSlotInfo = GetFlyoutSlotInfo
local GetSpecialization = GetSpecialization
local GetSpecializationInfoByID = GetSpecializationInfoByID

local BOOKTYPE_PET = Enum.SpellBookSpellBank.Pet
local BOOKTYPE_SPELL = Enum.SpellBookSpellBank.Player
local FLYOUT_FACTOR = 10000000
local MAX_TALENT_TIERS = MAX_TALENT_TIERS
local NUM_TALENT_COLUMNS = NUM_TALENT_COLUMNS

local VERSION = 1.52

local lib = _G.LibPlayerSpells
if lib and lib.version >= VERSION then return end

if not lib then
	lib = {}
	_G.LibPlayerSpells = lib
end

_G["LibPlayerSpells-1.0"] = lib

lib.version = VERSION

local PLAYER_CLASS = select(2, UnitClass("player"))

local hookList = lib.hookList
if not hookList then
	hookList = {}
	lib.hookList = hookList
end

local function FindObject(object)
	if type(object) ~= "table" then
		return
	end

	for k, v in ipairs(hookList) do
		if v == object then
			return k
		end
	end
end

function lib:HookObject(object)
	if type(object) ~= "table" then
		object = {}
	end

	if not FindObject(object) then
		tinsert(hookList, object)
	end

	return object
end

function lib:UnhookObject(object)
	local index = FindObject(object)
	if index then
		tremove(hookList, index)
	end
end

local function CallHooks(method, ...)
	for _, object in ipairs(hookList) do
		local func = object[method]
		if type(func) == "function" then
			func(object, ...)
		end
	end
end

local spellList = {}
local spellTable = {}

function lib:PlayerHasSpell(spell)
	local id = spellList[spell]
	if id then
		if id > FLYOUT_FACTOR then
			return spell
		end

		if id < 0 then
			return -id, BOOKTYPE_PET
		end

		return id, BOOKTYPE_SPELL
	end
end

function lib:GetNumSpells()
	return #spellTable
end

function lib:GetSpellByIndex(index)
	return spellTable[index]
end

function lib:GetSpellCooldown(spell)
	local start, duration, enabled
	local id, bookType = lib:PlayerHasSpell(spell)
	if id then
		local spellCooldownInfo = C_SpellBook.GetSpellBookItemCooldown(id, bookType)
		if spellCooldownInfo then
			start, duration, enabled = spellCooldownInfo.startTime, spellCooldownInfo.duration, spellCooldownInfo.isEnabled
		end
	end

	if not start then
		return 0, 0, 0
	end

	return duration - GetTime() + start, start, duration, enabled
end

function lib:IsSpellInRange(spell, unit)
	local id, bookType = lib:PlayerHasSpell(spell)
	if not id then
		return 1
	end

	if type(unit) ~= "string" then
		unit = "target"
	end

	if bookType then
		return IsSpellInRange(id, bookType, unit) ~= 0
	end

	return IsSpellInRange(id, unit) ~= 0
end

function lib:IsUsableSpell(spell, checkCooldown, checkMana, checkRange)
	local id, bookType = lib:PlayerHasSpell(spell)
	if not id then
		return
	end

	local usable, oom = IsUsableSpell(id, bookType)
	if not usable then
		if not oom then
			return nil, 2
		elseif checkMana then
			return nil, 3
		end
	end

	if checkCooldown then
		local spellCooldownInfo = C_SpellBook.GetSpellBookItemCooldown(id, bookType)
		if spellCooldownInfo then
			local start, duration, enabled = spellCooldownInfo.startTime, spellCooldownInfo.duration, spellCooldownInfo.isEnabled
			local timeLeft = start and (duration - GetTime() + start) or 0
			if timeLeft > 0 and duration > 1.5 then
				return nil, 1, timeLeft, start, duration, enabled
			end
		end
	end

	if checkRange and not lib:IsSpellInRange(spell, checkRange) then
		return nil, 4
	end

	return 1
end

local function AddFlyouts(id)
	if not id then
		return
	end

	local _, _, numSlots, isKnown = GetFlyoutInfo(id)
	if not isKnown then
		return
	end

	for i = 1, numSlots do
		local _, _, isKnownFlag, name = GetFlyoutSlotInfo(id, i)
		if isKnownFlag and name then
			if not spellList[name] then
				tinsert(spellTable, name)
			end
			spellList[name] = id + FLYOUT_FACTOR
		end
	end
end

local function VerifySpell(id, bookType)
	local spellBookItemInfo = C_SpellBook.GetSpellBookItemInfo(id, bookType)
	if not spellBookItemInfo then return end
	if spellBookItemInfo.itemType == Enum.SpellBookItemType.Flyout then
		AddFlyouts(spellBookItemInfo.actionID)
	elseif spellBookItemInfo.itemType == Enum.SpellBookItemType.Spell or spellBookItemInfo.itemType == Enum.SpellBookItemType.PetAction then
		if spellBookItemInfo.name then
			if bookType == BOOKTYPE_PET then
				id = -id
			end

			if not spellList[spellBookItemInfo.name] then
				tinsert(spellTable, spellBookItemInfo.name)
			end

			spellList[spellBookItemInfo.name] = id
		end
	end
end

local function UpdateTabSpells(tab)
	local skillLineInfo = C_SpellBook.GetSpellBookSkillLineInfo(tab)
	if not skillLineInfo then return end
	local offset, count, offSpecID = skillLineInfo.itemIndexOffset, skillLineInfo.numSpellBookItems, skillLineInfo.offSpecID
    local isOffSpec = (offSpecID ~= nil)
	if offset and count and not isOffSpec then
		for i = 1, count do
			VerifySpell(offset + i, BOOKTYPE_SPELL)
		end
	end
end

local function UpdateSpellData()
	wipe(spellList)
	wipe(spellTable)
	local num = C_SpellBook.HasPetSpells()
	if type(num) == "number" and num > 0 then
		for id = 1, num do
			VerifySpell(id, BOOKTYPE_PET)
		end
	end

    for i=1, C_SpellBook.GetNumSpellBookSkillLines() do
        UpdateTabSpells(i)
    end

	sort(spellTable)
	CallHooks("OnSpellsChanged")
end

local talentList = {}
local talentMap = {}

local function UpdateTalentData()
	CallHooks("OnTalentsChanged")
end

function lib:PlayerHasTalent(talent)
	if type(talent) == "number" then
		return talentMap[talent] -- tie selection, return nil or 1-3
	end

	return talentList[talent] -- name
end

local spellSentList = {}
local castTimeRecords = {}

local function UpdateCastingTime(spell, func)
	local _, _, _, startTime, endTime = func("player")
	if startTime and endTime then
		castTimeRecords[spell] = (endTime - startTime) / 1000
	end
end

function lib:GetSpellCastTime(spell, useRecord)
	if not self:PlayerHasSpell(spell) then
		return
	end

	local castTime
	if useRecord then
		castTime = castTimeRecords[spell]
	else
		local spellInfo = C_Spell.GetSpellInfo(spell)
		if spellInfo then
			castTime = spellInfo.castTime
			if castTime then
				castTime = castTime / 1000
			end
		end
	end

	if not castTime and type(useRecord) == "number" then
		castTime = useRecord
	end
	return castTime
end

function lib:WasSpellSent(spell, elapsed)
	local sentTime = spellSentList[spell]
	if sentTime then
		local timeSpan = GetTime() - sentTime
		if type(elapsed) == "number" then
			return timeSpan <= elapsed, timeSpan
		else
			return true, timeSpan
		end
	end
end

function lib:GetLastSentSpell()
	return self.lastSentSpell, self.lastSentTime
end

function lib:GetCastingSpell()
	return self.castingSpell
end

--------------------------------------------------------
-- Spec Process
--------------------------------------------------------

local GLOBAL_SPEC_DATA = {
	MAGE =		{ 62, 63, 64 },
	PALADIN =	{ 65, 66, 70 },
	WARRIOR =	{ 71, 72, 73 },
	DRUID =		{ 102, 103, 104, 105 },
	DEATHKNIGHT =	{ 250, 251, 252 },
	HUNTER =	{ 253, 254, 255 },
	PRIEST =	{ 256, 257, 258 },
	ROGUE =		{ 259, 260, 261 },
	SHAMAN =	{ 262, 263, 264 },
	WARLOCK =	{ 265, 266, 267 },
	MONK =		{ 268, 269, 270 },
	DEMONHUNTER =	{ 577, 581 },
	EVOKER = 	{ 1467, 1468 },
}

local PLAYER_SPEC_DATA = GLOBAL_SPEC_DATA[PLAYER_CLASS]

local prevSpecIndex, prevSpecId

local function UpdateSpec()
	local index = GetSpecialization()
	local id = PLAYER_SPEC_DATA[index]
	if not id or prevSpecId == id then
		return
	end

	local _, name, description, icon, background, role, class = GetSpecializationInfoByID(id)
	if not name then
		return
	end

	prevSpecIndex, prevSpecId = index, id
	CallHooks("OnSpecChanged", index, id, name, description, icon, background, role, class)
end

function lib:GetSpecialization()
	if prevSpecId then
		return prevSpecIndex, GetSpecializationInfoByID(prevSpecId)
	end
end

function lib:GetNumSpecializations(class)
	local data = GLOBAL_SPEC_DATA[class or PLAYER_CLASS]
	return data and #data or 0
end

function lib:GetSpecializationByIndex(index, class)
	local data = GLOBAL_SPEC_DATA[class or PLAYER_CLASS]
	if not data then
		return
	end

	local id = data[index]
	if not id then
		return
	end

	return GetSpecializationInfoByID(id)
end

local frame = lib.frame
if not frame then
	frame = CreateFrame("Frame")
	lib.frame = frame
end

frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ACTIVE_PLAYER_SPECIALIZATION_CHANGED") --frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterEvent("TRAIT_CONFIG_UPDATED") --frame:RegisterEvent("PLAYER_TALENT_UPDATE")

frame:RegisterEvent("UNIT_SPELLCAST_SENT")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
frame:RegisterEvent("UNIT_SPELLCAST_START")
frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
frame:RegisterEvent("UNIT_SPELLCAST_STOP")
frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")

local isLengthy

frame:SetScript("OnEvent", function(self, event, unit, spell)
	if event == "PLAYER_LOGIN" then
		UpdateSpec() -- Added in 7.0
		UpdateSpellData()
		UpdateTalentData()

	elseif event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "ACTIVE_PLAYER_SPECIALIZATION_CHANGED" then
		UpdateSpec()
		UpdateSpellData()

	elseif event == "SPELLS_CHANGED" then
		if not unit then
			UpdateSpellData()
		end

	elseif event == "PLAYER_TALENT_UPDATE" or event == "TRAIT_CONFIG_UPDATED" then
		UpdateTalentData()
		UpdateSpellData()

		local now = GetTime()
		if event == "UNIT_SPELLCAST_SENT" then
			isLengthy = nil
		elseif event == "UNIT_SPELLCAST_START" then
			isLengthy = 1
			spellSentList[spell] = now
			lib.castingSpell = spell
			lib.lastSentSpell, lib.lastSentTime = spell, now
			UpdateCastingTime(spell, UnitCastingInfo)
		elseif event == "UNIT_SPELLCAST_CHANNEL_START" then
			isLengthy = 1
			spellSentList[spell] = now
			lib.castingSpell = spell
			lib.lastSentSpell, lib.lastSentTime = spell, now
			UpdateCastingTime(spell, UnitChannelInfo)
		elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
			spellSentList[spell] = now
			lib.lastSentSpell, lib.lastSentTime = spell, now
			if not isLengthy then
				lib.castingSpell = nil
			end
		elseif event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_CHANNEL_STOP" then
			isLengthy = nil
			lib.castingSpell = nil
		end
	end
end)
