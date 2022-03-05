-- ## Version: v1.1  ## Author: Hascat
-- This HearthRoulette provides a macro which will use a randomly-selected hearthstone,
-- including the standard hearthstone item and any hearthstone toys available to
-- the player. This will not activate any hearthstones which do not return the
-- player to their home inn.

local HearthRoulette = {}

-- Initialize HearthRoulette state.

HearthRoulette.eligibleItems = {}
HearthRoulette.eligibleSpells = {}
HearthRoulette.eligibleToys = {}

-- Return the time the given item has left on cooldown, zero if none.
local function GetItemCooldownRemaining(itemId)
    local start, duration, _ = GetItemCooldown(itemId)
    return max(0, (start + duration) - GetTime())
end

-- Return the time the given spell has left on cooldown, zero if none.
local function GetSpellCooldownRemaining(spellId)
    local start, duration, _, _ = GetSpellCooldown(spellId)
    return max(0, (start + duration) - GetTime())
end

-- Return a random item from the given table, or nil if the table is empty.
local function RandomItem(t)
    if #t > 0 then
        return t[random(#t)]
    else
        return nil
    end
end

-- Randomly choose a hearthstone from the lists of eligible toys, spells, and
-- items. Preference is given to the hearthstone with the shortest cooldown. The
-- chosen hearthstone will be used in the generated macro. If no hearthstones
-- are available, set the macro to emit a message indicating that.
--
-- This function is sensitive to item cache information being available. The
-- item cache may not be populated at login, causing item info queries to return
-- nil values.
function HearthRoulette:ChooseHearth()
    local name = nil
    local cooldown = nil

    if #self.eligibleToys > 0 then
        local toyId = RandomItem(self.eligibleToys)
        local toyName = select(2, C_ToyBox.GetToyInfo(toyId))
        if toyName then
            name = toyName
            cooldown = GetItemCooldownRemaining(toyId)
        end
    end

    if #self.eligibleItems > 0 then
        local itemId = RandomItem(self.eligibleItems)
        local itemCooldown = GetItemCooldownRemaining(itemId)
        if not cooldown or (itemCooldown < cooldown) then
            local itemName = C_Item.GetItemNameByID(itemId)
            if itemName then
                name = itemName
                cooldown = itemCooldown
            end
        end
    end

    if #self.eligibleSpells > 0 then
        local spellId = RandomItem(self.eligibleSpells)
        local spellName = select(1, GetSpellInfo(spellId))
        local spellCooldown = GetSpellCooldownRemaining(spellId)
        if not cooldown or (spellCooldown < cooldown) then
            name = spellName
            cooldown = spellCooldown
        end
    end

    if name then
        self:_SetMacro("#showtooltip\n/cast " .. name)
    else
        self:_SetMacro("/run print(\"No hearthstones found!\")")
    end
end

-- Set the macro to have the given body. If the macro does not yet exist, it
-- will be created for all characters. If the player is in combat, no action is
-- taken.
function HearthRoulette:_SetMacro(body)
    if InCombatLockdown() then
        return
    end

    local name = select(1, GetMacroInfo("HearthRoulette"))
    if not name then
        CreateMacro("HearthRoulette", self.MACRO_ICON_ID, body, false)
    else
        EditMacro("HearthRoulette", "HearthRoulette", self.MACRO_ICON_ID, body)
    end
end

-- Update the set of hearthstone toys, items and spells available, then choose a
-- new hearthstone.
function HearthRoulette:UpdateAll()
    self:_UpdateToys()
    self:_UpdateSpells()
    self:_UpdateItems()
    self:ChooseHearth()
end

-- Update the set of hearthstone items, then choose a new hearthstone.
function HearthRoulette:UpdateItems()
    self:_UpdateItems()
    self:ChooseHearth()
end

-- Update the set of hearthstone spells, then choose a new hearthstone.
function HearthRoulette:UpdateSpells()
    self:_UpdateSpells()
    self:ChooseHearth()
end

-- Update the set of hearthstone toys, then choose a new hearthstone.
function HearthRoulette:UpdateToys()
    self:_UpdateToys()
    self:ChooseHearth()
end

-- Update the set of hearthstone items available in the player's bags. This
-- should only ever include the generic hearthstone item. If the player has
-- marked one or more hearthstone toys as favorites, the generic hearthstone
-- will be ignored in favor of those.
function HearthRoulette:_UpdateItems()
    wipe(self.eligibleItems)

    for bagId = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bagId) do
            local itemId = GetContainerItemID(bagId, slot)
            if tContains(self.HEARTHSTONE_ITEM_ID, itemId) then
                table.insert(self.eligibleItems, itemId)
            end
        end
    end
end

-- Populate a set of all known hearthstone spells.
function HearthRoulette:_UpdateSpells()
    wipe(self.eligibleSpells)

    for _, spellId in pairs(self.HEARTHSTONE_SPELL_ID) do
        if IsPlayerSpell(spellId) then
            table.insert(self.eligibleSpells, spellId)
        end
    end
end

-- Build up a list of all known hearthstone toys. If any of these are marked as
-- favorites, only the favorited toys will be included in the list.
function HearthRoulette:_UpdateToys()
    wipe(self.eligibleToys)
    local hasFavorites = false

    for _, toyId in pairs(self.HEARTHSTONE_TOY_ID) do
        if PlayerHasToy(toyId) then
            local isFavorite = select(4, C_ToyBox.GetToyInfo(toyId))
            if isFavorite then
                if not hasFavorites then
                    wipe(self.eligibleToys)
                    hasFavorites = true
                end
                table.insert(self.eligibleToys, toyId)
            elseif not hasFavorites then
                table.insert(self.eligibleToys, toyId)
            end
        end
    end
end

-- Path to the icon to use for the macro.
HearthRoulette.MACRO_ICON_PATH = "Interface/icons/achievement_guildperk_hastyhearth.blp"
HearthRoulette.MACRO_ICON_ID = GetFileIDFromPath(HearthRoulette.MACRO_ICON_PATH)

-- Item ID numbers for the hearthstone and hearthstone-equivalent items.
HearthRoulette.HEARTHSTONE_ITEM_ID = {
	6948, -- Hearthstone
	28585, -- Ruby Slippers
	142298, -- Astonishingly Scarlet Slippers
}

-- Toy ID numbers for the hearthstone-equivalent toys.
HearthRoulette.HEARTHSTONE_TOY_ID = {
    54452, -- Ethereal Portal
    64488, -- The Innkeeper's Daughter
    93672, -- Dark Portal
    142542, -- Tome of Town Portal
    162973, -- Greatfather Winter's Hearthstone
    163045, -- Headless Horseman's Hearthstone
    165669, -- Lunar Edler's Hearthstone
    165670, -- Peddlefeet's Lovely Hearthstone
    165802, -- Noble Gardener's Hearthstone
    166746, -- Fire Eater's Hearthstone
    166747, -- Brewfest Reveler's Hearthstone
    168907, -- Holographic Digitalization Hearthstone
    172179, -- Eternal Traveler's Hearthstone
    180290, -- Night Fae Hearthstone
    182773, -- Necrolord Hearthstone
    183716, -- Venthyr Sinstone
    184353, -- Kyrian Hearthstone
}

-- Spell ID numbers for hearthstone-equivalent spells.
HearthRoulette.HEARTHSTONE_SPELL_ID = {
    556, -- Astral Recall
}


local events = CreateFrame("Frame", "HearthRouletteEvents", UIParent)
HearthRoulette.events = events

function events:OnEvent(event, ...)
    if self[event] then
        self[event](self, event, ...)
    end
end

events:SetScript("OnEvent", events.OnEvent)
events:RegisterEvent("ADDON_LOADED")

-- Register events to ensure bag changes and toy changes are handled.
function events:ADDON_LOADED()
    self:UnregisterAllEvents()
    self:RegisterEvent("BAG_UPDATE")
    self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("SPELLS_CHANGED")
    self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    self:RegisterEvent("TOYS_UPDATED")
end

-- Look for hearthstone and hearthstone-equivalent items in the player's
-- inventory, then choose a random hearthstone. This ensures new hearthstone-
-- equivalent items become available when they are acquired by the player, or
-- become unavailable when removed from the player's inventory.
function events:BAG_UPDATE(...)
    HearthRoulette:UpdateItems()
end

-- Choose a new hearthstone when the item info cache has been updated. Item info
-- queries performed by ChooseHearth may fail before this event is triggered.
function events:GET_ITEM_INFO_RECEIVED(...)
    HearthRoulette:ChooseHearth()
end

-- Ensure the toys, items, and spells have been scanned when the player enters
-- the world, then update the chosen hearthstone.
function events:PLAYER_ENTERING_WORLD(...)
    HearthRoulette:UpdateAll()
end

-- Look for hearthstone-equivalent spells in the player's spellbook, then
-- choose a random hearthstone. This ensures new hearthstone-equivalent spells
-- become available when they are learned by the player.
function events:SPELLS_CHANGED(...)
    HearthRoulette:UpdateSpells()
end

-- Choose a new hearthstone while casting. This ensures cooldowns will be
-- respected once a hearthstone is used.
function events:SPELL_UPDATE_COOLDOWN(...)
    HearthRoulette:ChooseHearth()
end

-- Look for hearthstone-equivalent toys in the player's toy collection, then
-- choose a random hearthstone. This ensures new hearthstone-equivalent toys
-- become available when they are added to the player's toy box.
function events:TOYS_UPDATED(...)
    HearthRoulette:UpdateToys()
end