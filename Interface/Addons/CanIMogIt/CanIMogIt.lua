 --  11.0.5v2.5.1
-- Constants for CanIMogIt

local L = CanIMogIt.L
--------------------------------------------
-- Database scan speed values             --
--------------------------------------------


-- Instant - Only the best of connections, or you WILL crash with Error #134
-- CanIMogIt.throttleTime = 0.25
-- CanIMogIt.bufferMax = 10000

-- Near Instant - May cause your game to crash with Error #134
-- CanIMogIt.throttleTime = 0.25
-- CanIMogIt.bufferMax = 200

-- Fast - Less likely to cause lag or crash
-- CanIMogIt.throttleTime = 0.1
-- CanIMogIt.bufferMax = 50

-- Medium - Most likely safe
CanIMogIt.throttleTime = 0.1
CanIMogIt.bufferMax = 25

-- Slow - Will take a long time, but be 100% safe. Use if you have a poor connection.
-- CanIMogIt.throttleTime = 0.5
-- CanIMogIt.bufferMax = 5


--------------------------------------------
-- Tooltip icon, color and text constants --
--------------------------------------------

-- Icons
CanIMogIt.KNOWN_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\KNOWN:0|t "
CanIMogIt.KNOWN_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\KNOWN_OVERLAY"
CanIMogIt.KNOWN_SOULBOUND_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\KNOWN_BOP:0|t "
CanIMogIt.KNOWN_SOULBOUND_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\KNOWN_BOP_OVERLAY"
CanIMogIt.KNOWN_BOE_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\KNOWN_BOE:0|t "
CanIMogIt.KNOWN_BOE_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\KNOWN_BOE_OVERLAY"
CanIMogIt.KNOWN_WARBOUND_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\KNOWN_WARBOUND:0|t "
CanIMogIt.KNOWN_WARBOUND_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\KNOWN_WARBOUND_OVERLAY"
CanIMogIt.KNOWN_BUT_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\KNOWN_circle:0|t "
CanIMogIt.KNOWN_BUT_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\KNOWN_circle_OVERLAY"
CanIMogIt.KNOWN_BUT_BOE_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\KNOWN_BOE_circle:0|t "
CanIMogIt.KNOWN_BUT_BOE_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\KNOWN_BOE_circle_OVERLAY"
CanIMogIt.KNOWN_BUT_SOULBOUND_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\KNOWN_BOP_circle:0|t "
CanIMogIt.KNOWN_BUT_SOULBOUND_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\KNOWN_BOP_circle_OVERLAY"
CanIMogIt.KNOWN_BUT_WARBOUND_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\KNOWN_WARBOUND_circle:0|t "
CanIMogIt.KNOWN_BUT_WARBOUND_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\KNOWN_WARBOUND_circle_OVERLAY"
CanIMogIt.UNKNOWABLE_SOULBOUND_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\UNKNOWABLE_SOULBOUND:0|t "
CanIMogIt.UNKNOWABLE_SOULBOUND_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\UNKNOWABLE_SOULBOUND_OVERLAY"
CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\UNKNOWABLE_BY_CHARACTER:0|t "
CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\UNKNOWABLE_BY_CHARACTER_OVERLAY"
CanIMogIt.UNKNOWABLE_BY_CHARACTER_WARBOUND_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\UNKNOWABLE_BY_CHARACTER_WARBOUND:0|t "
CanIMogIt.UNKNOWABLE_BY_CHARACTER_WARBOUND_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\UNKNOWABLE_BY_CHARACTER_WARBOUND_OVERLAY"
CanIMogIt.UNKNOWN_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\UNKNOWN:0|t "
CanIMogIt.UNKNOWN_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\UNKNOWN_OVERLAY"
CanIMogIt.PARTIAL_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\PARTIAL:0|t "
CanIMogIt.PARTIAL_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\PARTIAL_OVERLAY"
CanIMogIt.NOT_TRANSMOGABLE_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\NOT_TRANSMOGABLE:0|t "
CanIMogIt.NOT_TRANSMOGABLE_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\NOT_TRANSMOGABLE_OVERLAY"
CanIMogIt.NOT_TRANSMOGABLE_BOE_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\NOT_TRANSMOGABLE_BOE:0|t "
CanIMogIt.NOT_TRANSMOGABLE_BOE_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\NOT_TRANSMOGABLE_BOE_OVERLAY"
CanIMogIt.NOT_TRANSMOGABLE_WARBOUND_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\NOT_TRANSMOGABLE_WARBOUND:0|t "
CanIMogIt.NOT_TRANSMOGABLE_WARBOUND_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\NOT_TRANSMOGABLE_WARBOUND_OVERLAY"
CanIMogIt.QUESTIONABLE_ICON = "|TInterface\\Addons\\CanIMogIt\\Icons\\QUESTIONABLE:0|t "
CanIMogIt.QUESTIONABLE_ICON_OVERLAY = "Interface\\Addons\\CanIMogIt\\Icons\\QUESTIONABLE_OVERLAY"


-- Colorblind colors
CanIMogIt.BLUE =   "|cff15abff"
CanIMogIt.BLUE_GREEN = "|cff009e73"
CanIMogIt.PINK = "|cffcc79a7"
CanIMogIt.ORANGE = "|cffe69f00"
CanIMogIt.RED_ORANGE = "|cffff9333"
CanIMogIt.YELLOW = "|cfff0e442"
CanIMogIt.GRAY =   "|cff888888"
CanIMogIt.WHITE =   "|cffffffff"


-- Tooltip Text
local KNOWN =                                           L["Learned."]
local KNOWN_BOE =                                       L["Learned."]
local KNOWN_FROM_ANOTHER_ITEM =                         L["Learned from another item."]
local KNOWN_FROM_ANOTHER_ITEM_BOE =                     L["Learned from another item."]
local KNOWN_BY_ANOTHER_CHARACTER =                      L["Learned for a different class."]
local KNOWN_BY_ANOTHER_CHARACTER_BOE =                  L["Learned for a different class."]
local KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER =           L["Learned for a different class and item."]
local KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE =       L["Learned for a different class and item."]
local UNKNOWABLE_SOULBOUND =                            L["Cannot learn: Soulbound"] .. " " -- subClass
local UNKNOWABLE_BY_CHARACTER =                         L["Cannot learn:"] .. " " -- subClass
local UNKNOWABLE_BY_CHARACTER_WARBOUND =                             L["Cannot learn:"] .. " " -- subClass
local CAN_BE_LEARNED_BY =                               L["Can be learned by:"] -- list of classes
local UNKNOWN =                                         L["Not learned."]
local PARTIAL =                                         UNKNOWN
local NOT_TRANSMOGABLE =                                L["Cannot be learned."]
local NOT_TRANSMOGABLE_BOE =                            L["Cannot be learned."]
local NOT_TRANSMOGABLE_WARBOUND =                       L["Cannot be learned."]
local CANNOT_DETERMINE =                                L["Cannot determine status on other characters."]


-- Combine icons, color, and text into full tooltip
CanIMogIt.KNOWN =                                           CanIMogIt.KNOWN_ICON .. CanIMogIt.BLUE .. KNOWN
CanIMogIt.KNOWN_BOE =                                       CanIMogIt.KNOWN_BOE_ICON .. CanIMogIt.YELLOW .. KNOWN
CanIMogIt.KNOWN_WARBOUND =                                  CanIMogIt.KNOWN_WARBOUND_ICON .. CanIMogIt.PINK .. KNOWN
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM =                         CanIMogIt.KNOWN_BUT_ICON .. CanIMogIt.BLUE .. KNOWN_FROM_ANOTHER_ITEM
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE =                     CanIMogIt.KNOWN_BUT_BOE_ICON .. CanIMogIt.YELLOW .. KNOWN_FROM_ANOTHER_ITEM
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_WARBOUND =                CanIMogIt.KNOWN_BUT_WARBOUND_ICON .. CanIMogIt.PINK .. KNOWN_FROM_ANOTHER_ITEM
CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER =                      CanIMogIt.KNOWN_SOULBOUND_ICON .. CanIMogIt.BLUE_GREEN .. KNOWN_BY_ANOTHER_CHARACTER
CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE =                  CanIMogIt.KNOWN_BOE_ICON .. CanIMogIt.YELLOW .. KNOWN_BY_ANOTHER_CHARACTER
CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_WARBOUND =             CanIMogIt.KNOWN_WARBOUND_ICON .. CanIMogIt.PINK .. KNOWN_BY_ANOTHER_CHARACTER
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER =           CanIMogIt.KNOWN_BUT_SOULBOUND_ICON .. CanIMogIt.BLUE_GREEN .. KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE =       CanIMogIt.KNOWN_BUT_BOE_ICON .. CanIMogIt.YELLOW .. KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_WARBOUND =  CanIMogIt.KNOWN_BUT_WARBOUND_ICON .. CanIMogIt.PINK .. KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER
-- CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER =        CanIMogIt.QUESTIONABLE_ICON .. CanIMogIt.YELLOW .. CANNOT_DETERMINE
CanIMogIt.UNKNOWABLE_SOULBOUND =                            CanIMogIt.UNKNOWABLE_SOULBOUND_ICON .. CanIMogIt.BLUE_GREEN .. UNKNOWABLE_SOULBOUND
CanIMogIt.UNKNOWABLE_BY_CHARACTER =                         CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON .. CanIMogIt.YELLOW .. UNKNOWABLE_BY_CHARACTER
CanIMogIt.UNKNOWABLE_BY_CHARACTER_WARBOUND =                             CanIMogIt.UNKNOWABLE_BY_CHARACTER_WARBOUND_ICON .. CanIMogIt.PINK .. UNKNOWABLE_BY_CHARACTER_WARBOUND
CanIMogIt.UNKNOWN =                                         CanIMogIt.UNKNOWN_ICON .. CanIMogIt.RED_ORANGE .. UNKNOWN
CanIMogIt.PARTIAL =                                         CanIMogIt.PARTIAL_ICON .. CanIMogIt.RED_ORANGE .. PARTIAL
CanIMogIt.NOT_TRANSMOGABLE =                                CanIMogIt.NOT_TRANSMOGABLE_ICON .. CanIMogIt.GRAY .. NOT_TRANSMOGABLE
CanIMogIt.NOT_TRANSMOGABLE_BOE =                            CanIMogIt.NOT_TRANSMOGABLE_BOE_ICON .. CanIMogIt.YELLOW .. NOT_TRANSMOGABLE
CanIMogIt.NOT_TRANSMOGABLE_WARBOUND =                            CanIMogIt.NOT_TRANSMOGABLE_WARBOUND_ICON .. CanIMogIt.PINK .. NOT_TRANSMOGABLE
CanIMogIt.CANNOT_DETERMINE =                                CanIMogIt.QUESTIONABLE_ICON


CanIMogIt.tooltipIcons = {
    [CanIMogIt.KNOWN] = CanIMogIt.KNOWN_ICON,
    [CanIMogIt.KNOWN_BOE] = CanIMogIt.KNOWN_BOE_ICON,
    [CanIMogIt.KNOWN_WARBOUND] = CanIMogIt.KNOWN_WARBOUND_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM] = CanIMogIt.KNOWN_BUT_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE] = CanIMogIt.KNOWN_BUT_BOE_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_WARBOUND] = CanIMogIt.KNOWN_BUT_WARBOUND_ICON,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER] = CanIMogIt.KNOWN_SOULBOUND_ICON,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE] = CanIMogIt.KNOWN_BOE_ICON,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_WARBOUND] = CanIMogIt.KNOWN_WARBOUND_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = CanIMogIt.KNOWN_BUT_SOULBOUND_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE] = CanIMogIt.KNOWN_BUT_BOE_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_WARBOUND] = CanIMogIt.KNOWN_BUT_WARBOUND_ICON,
    -- [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = CanIMogIt.QUESTIONABLE_ICON,
    [CanIMogIt.UNKNOWABLE_SOULBOUND] = CanIMogIt.UNKNOWABLE_SOULBOUND_ICON,
    [CanIMogIt.UNKNOWABLE_BY_CHARACTER] = CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON,
    [CanIMogIt.UNKNOWABLE_BY_CHARACTER_WARBOUND] = CanIMogIt.UNKNOWABLE_BY_CHARACTER_WARBOUND_ICON,
    -- [CanIMogIt.CAN_BE_LEARNED_BY] = CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON,
    [CanIMogIt.UNKNOWN] = CanIMogIt.UNKNOWN_ICON,
    [CanIMogIt.PARTIAL] = CanIMogIt.PARTIAL_ICON,
    [CanIMogIt.NOT_TRANSMOGABLE] = CanIMogIt.NOT_TRANSMOGABLE_ICON,
    [CanIMogIt.NOT_TRANSMOGABLE_BOE] = CanIMogIt.NOT_TRANSMOGABLE_BOE_ICON,
    [CanIMogIt.NOT_TRANSMOGABLE_WARBOUND] = CanIMogIt.NOT_TRANSMOGABLE_WARBOUND_ICON,
    [CanIMogIt.CANNOT_DETERMINE] = CanIMogIt.QUESTIONABLE_ICON,
}


-- Used by itemOverlay
CanIMogIt.tooltipOverlayIcons = {
    [CanIMogIt.KNOWN] = CanIMogIt.KNOWN_ICON_OVERLAY,
    [CanIMogIt.KNOWN_BOE] = CanIMogIt.KNOWN_BOE_ICON_OVERLAY,
    [CanIMogIt.KNOWN_WARBOUND] = CanIMogIt.KNOWN_WARBOUND_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM] = CanIMogIt.KNOWN_BUT_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE] = CanIMogIt.KNOWN_BUT_BOE_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_WARBOUND] = CanIMogIt.KNOWN_BUT_WARBOUND_ICON_OVERLAY,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER] = CanIMogIt.KNOWN_SOULBOUND_ICON_OVERLAY,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE] = CanIMogIt.KNOWN_BOE_ICON_OVERLAY,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_WARBOUND] = CanIMogIt.KNOWN_WARBOUND_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = CanIMogIt.KNOWN_BUT_SOULBOUND_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE] = CanIMogIt.KNOWN_BUT_BOE_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_WARBOUND] = CanIMogIt.KNOWN_BUT_WARBOUND_ICON_OVERLAY,
    -- [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = CanIMogIt.QUESTIONABLE_ICON_OVERLAY,
    [CanIMogIt.UNKNOWABLE_SOULBOUND] = CanIMogIt.UNKNOWABLE_SOULBOUND_ICON_OVERLAY,
    [CanIMogIt.UNKNOWABLE_BY_CHARACTER] = CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON_OVERLAY,
    [CanIMogIt.UNKNOWABLE_BY_CHARACTER_WARBOUND] = CanIMogIt.UNKNOWABLE_BY_CHARACTER_WARBOUND_ICON_OVERLAY,
    -- [CanIMogIt.CAN_BE_LEARNED_BY] = CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON_OVERLAY,
    [CanIMogIt.UNKNOWN] = CanIMogIt.UNKNOWN_ICON_OVERLAY,
    [CanIMogIt.PARTIAL] = CanIMogIt.PARTIAL_ICON_OVERLAY,
    [CanIMogIt.NOT_TRANSMOGABLE] = CanIMogIt.NOT_TRANSMOGABLE_ICON_OVERLAY,
    [CanIMogIt.NOT_TRANSMOGABLE_BOE] = CanIMogIt.NOT_TRANSMOGABLE_BOE_ICON_OVERLAY,
    [CanIMogIt.NOT_TRANSMOGABLE_WARBOUND] = CanIMogIt.NOT_TRANSMOGABLE_WARBOUND_ICON_OVERLAY,
    [CanIMogIt.CANNOT_DETERMINE] = CanIMogIt.QUESTIONABLE_ICON_OVERLAY,
}


-- Other text

CanIMogIt.DATABASE_START_UPDATE_TEXT = L["Updating appearances database."]
CanIMogIt.DATABASE_DONE_UPDATE_TEXT = L["Items updated: "] -- followed by a number


--------------------------------------------
-- Location constants                     --
--------------------------------------------

CanIMogIt.ICON_LOCATIONS = {
    ["TOPLEFT"] = {"TOPLEFT", 2, -2},
    ["TOPRIGHT"] = {"TOPRIGHT", -2, -2},
    ["BOTTOMLEFT"] = {"BOTTOMLEFT", 2, 2},
    ["BOTTOMRIGHT"] = {"BOTTOMRIGHT", -2, 2},
    ["CENTER"] = {"CENTER", 0, 0},
    ["RIGHT"] = {"RIGHT", -2, 0},
    ["LEFT"] = {"LEFT", 2, 0},
    ["BOTTOM"] = {"BOTTOM", 0, 2},
    ["TOP"] = {"TOP", 0, -2},
    ["AUCTION_HOUSE"] = {"LEFT", 137, 0}
}

--------------------------------------------
-- Blizzard frame constants --
--------------------------------------------


---- Auction Houses ----
CanIMogIt.NUM_BLACKMARKET_BUTTONS = 12  -- No Blizzard constant

---- Containers ----
-- Bags = NUM_CONTAINER_FRAMES
-- Bag Items = MAX_CONTAINER_ITEMS  -- Blizzard removed this variable in 9.0 for some reason
CanIMogIt.MAX_CONTAINER_ITEMS = MAX_CONTAINER_ITEMS or 36
-- Bank = NUM_BANKGENERIC_SLOTS
CanIMogIt.NUM_VOID_STORAGE_FRAMES = 80 -- Blizzard functions are locals

CanIMogIt.NUM_WARBANK_ITEMS = 112

---- Expansions ----
CanIMogIt.Expansions = {}
CanIMogIt.Expansions.BC = 1
CanIMogIt.Expansions.WRATH = 2
CanIMogIt.Expansions.CATA = 3
CanIMogIt.Expansions.MISTS = 4
CanIMogIt.Expansions.WOD = 5
CanIMogIt.Expansions.LEGION = 6
CanIMogIt.Expansions.BFA = 7
CanIMogIt.Expansions.SHADOWLANDS = 8

---- Others ----
CanIMogIt.NUM_ENCOUNTER_JOURNAL_ENCOUNTER_LOOT_FRAMES = 10 -- Blizzard functions are locals
CanIMogIt.NUM_MAIL_INBOX_ITEMS = 7
-- Mail Attachments = ATTACHMENTS_MAX_RECEIVE
-- Merchant Items = MERCHANT_ITEMS_PER_PAGE
-- Trade Skill = no constants
-- Loot Roll = NUM_GROUP_LOOT_FRAMES -- Blizzard removed in patch 10.1.5, using our own constant
CanIMogIt.NUM_GROUP_LOOT_FRAMES = 4

-- Built-in colors
CanIMogIt.BLIZZARD_RED = "|cffff1919"
CanIMogIt.BLIZZARD_GREEN = "|cff19ff19"
CanIMogIt.BLIZZARD_DARK_GREEN = "|cff40c040"
CanIMogIt.BLIZZARD_YELLOW = "|cffffd100"


CanIMogIt.AppearanceData = {}
CanIMogIt.AppearanceData.__index = CanIMogIt.AppearanceData


function CanIMogIt.AppearanceData:new(itemLink, playerKnowsTransmogFromItem, playerKnowsTransmog, isValidAppearanceForCharacter, characterCanLearnTransmog)
    if itemLink == nil
        or playerKnowsTransmogFromItem == nil
        or playerKnowsTransmog == nil
        or isValidAppearanceForCharacter == nil
        or characterCanLearnTransmog == nil then
        return nil
    end
    local this = setmetatable({}, CanIMogIt.AppearanceData)
    this.itemLink = itemLink
    this.key = CanIMogIt:CalculateKey(itemLink)
    this.playerKnowsTransmogFromItem = playerKnowsTransmogFromItem
    this.playerKnowsTransmog = playerKnowsTransmog
    this.isValidAppearanceForCharacter = isValidAppearanceForCharacter
    this.characterCanLearnTransmog = characterCanLearnTransmog
    this.status = this:CalculateKnownStatus()
    return this
end


function CanIMogIt.AppearanceData.FromItemLink(itemLink)
    if itemLink == nil then return end
    local playerKnowsTransmogFromItem = CanIMogIt:PlayerKnowsTransmogFromItem(itemLink)
    if playerKnowsTransmogFromItem == nil then return end
    local playerKnowsTransmog = CanIMogIt:PlayerKnowsTransmog(itemLink)
    if playerKnowsTransmog == nil then return end
    local isValidAppearanceForCharacter = CanIMogIt:IsValidAppearanceForCharacter(itemLink)
    if isValidAppearanceForCharacter == nil then return end
    local characterCanLearnTransmog = CanIMogIt:CharacterCanLearnTransmog(itemLink)
    if characterCanLearnTransmog == nil then return end
    return CanIMogIt.AppearanceData:new(itemLink, playerKnowsTransmogFromItem, playerKnowsTransmog, isValidAppearanceForCharacter, characterCanLearnTransmog)
end


function CanIMogIt.AppearanceData:CalculateKnownStatus()
    local status
    if self.playerKnowsTransmogFromItem then
        if self.isValidAppearanceForCharacter then
            -- The player knows the appearance from this item
            -- and the character can transmog it.
            status = CanIMogIt.KNOWN
        else
            -- The player knows the appearance from this item, but
            -- the character can't use this appearance.
            status = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER
        end
    -- Does the player know the appearance from a different item?
    elseif self.playerKnowsTransmog then
        if self.isValidAppearanceForCharacter then
            -- The player knows the appearance from another item, and
            -- the character can use it.
            status = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM
        else
            -- The player knows the appearance from another item, but
            -- this character can never use/learn the appearance.
            status = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER
        end
    else
        if self.characterCanLearnTransmog then
            -- The player does not know the appearance and the character
            -- can learn this appearance.
            status = CanIMogIt.UNKNOWN
        else
            -- Warbound shouldn't be possible in this state.
            status = CanIMogIt.UNKNOWABLE_BY_CHARACTER
        end
    end
    return status
end

function CanIMogIt.AppearanceData:CalculateBindStateText(bindData)
    local isItemWarbound = bindData.type == CanIMogIt.BindTypes.Warbound
    local isItemSoulbound = bindData.type == CanIMogIt.BindTypes.Soulbound
    local text, unmodifiedText;
    if self.status == CanIMogIt.KNOWN then
        if isItemWarbound then
            -- Pink Check
            text = CanIMogIt.KNOWN_WARBOUND
            unmodifiedText = CanIMogIt.KNOWN_WARBOUND
        elseif isItemSoulbound then
            -- Blue Check
            text = CanIMogIt.KNOWN
            unmodifiedText = CanIMogIt.KNOWN
        else -- BoE
            -- Yellow Check
            text = CanIMogIt.KNOWN_BOE
            unmodifiedText = CanIMogIt.KNOWN_BOE
        end
    elseif self.status == CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER then
        if isItemWarbound then
            -- Pink Check
            text = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_WARBOUND
            unmodifiedText = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_WARBOUND
        elseif isItemSoulbound then
            -- Green Check
            text = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER
            unmodifiedText = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER
        else -- BoE
            -- Yellow Check
            text = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE
            unmodifiedText = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE
        end
    elseif self.status == CanIMogIt.KNOWN_FROM_ANOTHER_ITEM then
        if isItemWarbound then
            -- Pink Circle Check
            text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_WARBOUND
            unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_WARBOUND
        elseif isItemSoulbound then
            -- Blue Circle Check
            text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM
            unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM
        else -- BoE
            -- Yellow Circle Check
            text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE
            unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE
        end
    elseif self.status == CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER then
        if isItemWarbound then
            -- Pink Circle Check
            text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_WARBOUND
            unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_WARBOUND
        elseif isItemSoulbound then
            -- Green Circle Check
            text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER
            unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER
        else -- BoE
            -- Yellow Circle Check
            text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE
            unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE
        end
    elseif self.status == CanIMogIt.UNKNOWN then
        -- Orange X
        text = CanIMogIt.UNKNOWN
        unmodifiedText = CanIMogIt.UNKNOWN
    elseif self.status == CanIMogIt.UNKNOWABLE_BY_CHARACTER then
        if isItemWarbound then
            -- Pink Star
            text = CanIMogIt.UNKNOWABLE_BY_CHARACTER_WARBOUND
                    .. CanIMogIt.BLIZZARD_RED .. CanIMogIt:GetReason(self.itemLink)
            unmodifiedText = CanIMogIt.UNKNOWABLE_BY_CHARACTER_WARBOUND
        elseif isItemSoulbound then
            -- Green Dash
            text = CanIMogIt.UNKNOWABLE_SOULBOUND
                    .. CanIMogIt.BLIZZARD_RED .. CanIMogIt:GetReason(self.itemLink)
            unmodifiedText = CanIMogIt.UNKNOWABLE_SOULBOUND
        else
            -- Yellow Star
            text = CanIMogIt.UNKNOWABLE_BY_CHARACTER
                    .. CanIMogIt.BLIZZARD_RED .. CanIMogIt:GetReason(self.itemLink)
            unmodifiedText = CanIMogIt.UNKNOWABLE_BY_CHARACTER
        end
    end
    return text, unmodifiedText
end



CanIMogIt.BindData = {}
CanIMogIt.BindData.__index = CanIMogIt.BindData


CanIMogIt.BindTypes = {
    Soulbound = "Soulbound",
    Warbound = "Warbound",
    BoE = "BoE"
}


function CanIMogIt.BindData:new(itemLink, bag, slot, tooltipData)
    if not itemLink then return nil end
    local this = setmetatable({}, CanIMogIt.BindData)
    this.itemLink = itemLink
    this.key = CanIMogIt.BindData.CalculateKey(itemLink, bag, slot, tooltipData)
    this.bag = bag
    this.slot = slot
    this.tooltipData = tooltipData
    this.type = this:CalculateType()
    -- If the type is nil, then the item is likely not ready yet.
    if this.type == nil then return nil end
    return this
end


function CanIMogIt.BindData.CalculateKey(itemLink, bag, slot, tooltipData)
    if not itemLink then return nil end
    if bag and slot then
        return "bag-slot:" .. bag .. "-" .. slot
    elseif tooltipData then
        local tooltipString = ""
        for i, line in pairs(tooltipData.lines) do
            if i > 10 then break end
            if line.leftText then
                tooltipString = tooltipString .. line.leftText
            end
            if line.rightText then
                tooltipString = tooltipString .. line.rightText
            end
        end
        return "tooltip:" .. tooltipString
    else
        return CanIMogIt:CalculateKey(itemLink)
    end
end


function CanIMogIt.BindData:CalculateType()
    local warbound = CIMIScanTooltip:IsItemWarbound(self.itemLink, self.bag, self.slot, self.tooltipData)
    if warbound == nil then return nil end
    if warbound then
        return CanIMogIt.BindTypes.Warbound
    end

    local soulbound = CIMIScanTooltip:IsItemSoulbound(self.itemLink, self.bag, self.slot, self.tooltipData)
    if soulbound == nil then return nil end
    if soulbound then
        return CanIMogIt.BindTypes.Soulbound
    end

    return CanIMogIt.BindTypes.BoE
end



CanIMogIt.ItemData = {}
CanIMogIt.ItemData.__index = CanIMogIt.ItemData


CanIMogIt.ItemTypes = {
    Transmogable = "Transmogable",
    Mount = "Mount",
    Toy = "Toy",
    Pet = "Pet",
    Ensemble = "Ensemble",
    Other = "Other"
}


function CanIMogIt.ItemData:new(itemLink, isTransmogable, isItemMount, isItemToy, isItemPet, isItemEnsemble, isItemEquippable)
    if itemLink == nil
        or isTransmogable == nil
        or isItemMount == nil
        or isItemToy == nil
        or isItemPet == nil
        or isItemEnsemble == nil
        or isItemEquippable == nil then
        return nil
    end
    local this = setmetatable({}, CanIMogIt.ItemData)
    this.itemLink = itemLink
    this.key = CanIMogIt:CalculateKey(itemLink)
    this.isTransmogable = isTransmogable
    this.isItemMount = isItemMount
    this.isItemToy = isItemToy
    this.isItemPet = isItemPet
    this.isItemEnsemble = isItemEnsemble
    this.isItemEquippable = isItemEquippable
    this.type = this:CalculateType()
    return this
end


function CanIMogIt.ItemData.FromItemLink(itemLink)
    if itemLink == nil then return end
    local isTransmogable = CanIMogIt:IsTransmogable(itemLink)
    if isTransmogable == nil then return end
    local isItemMount = CanIMogIt:IsItemMount(itemLink)
    if isItemMount == nil then return end
    local isItemToy = CanIMogIt:IsItemToy(itemLink)
    if isItemToy == nil then return end
    local isItemPet = CanIMogIt:IsItemPet(itemLink)
    if isItemPet == nil then return end
    local isItemEnsemble = CanIMogIt:IsItemEnsemble(itemLink)
    if isItemEnsemble == nil then return end
    local isItemEquippable = CanIMogIt:IsEquippable(itemLink)
    if isItemEquippable == nil then return end
    return CanIMogIt.ItemData:new(itemLink, isTransmogable, isItemMount, isItemToy, isItemPet, isItemEnsemble, isItemEquippable)
end


function CanIMogIt.ItemData:CalculateType()
    if self.isTransmogable then
        return CanIMogIt.ItemTypes.Transmogable
    elseif self.isItemMount then
        return CanIMogIt.ItemTypes.Mount
    elseif self.isItemToy then
        return CanIMogIt.ItemTypes.Toy
    elseif self.isItemPet then
        return CanIMogIt.ItemTypes.Pet
    elseif self.isItemEnsemble then
        return CanIMogIt.ItemTypes.Ensemble
    else
        return CanIMogIt.ItemTypes.Other
    end
end


-- Options for CanIMogIt
--
-- Thanks to Stanzilla and Semlar and their addon AdvancedInterfaceOptions, which I used as reference.

local _G = _G
local CREATE_DATABASE_TEXT = L["Can I Mog It? Important Message: Please log into all of your characters to compile complete transmog appearance data."]

StaticPopupDialogs["CANIMOGIT_NEW_DATABASE"] = {
    text = CREATE_DATABASE_TEXT,
    button1 = L["Okay, I'll go log onto all of my toons!"],
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}


local DATABASE_MIGRATION = "Can I Mog It?" .. "\n\n" .. L["We need to update our database. This may freeze the game for a few seconds."]


function CanIMogIt.CreateMigrationPopup(dialogName, onAcceptFunc)
    StaticPopupDialogs[dialogName] = {
        text = DATABASE_MIGRATION,
        button1 = L["Okay"],
        button2 = L["Ask me later"],
        OnAccept = onAcceptFunc,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
    }
    StaticPopup_Show(dialogName)
end


-- OptionsVersion: Keep this as an integer, so comparison is easy.
CanIMogIt_OptionsVersion = "23"

CanIMogItOptions_Defaults = {
    ["options"] = {
        ["version"] = CanIMogIt_OptionsVersion,
        ["showEquippableOnly"] = true,
        ["showTransmoggableOnly"] = true,
        ["showUnknownOnly"] = true,
        ["showSetInfo"] = false,
        ["showItemIconOverlay"] = true,
        ["showVerboseText"] = false,
        ["showSourceLocationTooltip"] = true,
        ["printDatabaseScan"] = false,
        ["iconLocation"] = "TOPRIGHT",
        ["showToyItems"] = true,
        ["showPetItems"] = true,
        ["showMountItems"] = true,
    },
}


CanIMogItOptions_DisplayData = {
    ["showEquippableOnly"] = {
        ["displayName"] = L["Equippable Items Only"],
        ["description"] = L["Only show on items that can be equipped."]
    },
    ["showTransmoggableOnly"] = {
        ["displayName"] = L["Transmoggable Items Only"],
        ["description"] = L["Only show on items that can be transmoggrified."]
    },
    ["showUnknownOnly"] = {
        ["displayName"] = L["Unknown Items Only"],
        ["description"] = L["Only show on items that you haven't learned."]
    },
    ["showSetInfo"] = {
        ["displayName"] = L["Show Transmog Set Info"],
        ["description"] = L["Show information on the tooltip about transmog sets."] .. "\n\n" .. L["Also shows a summary in the Appearance Sets UI of how many pieces of a transmog set you have collected."]
    },
    ["showItemIconOverlay"] = {
        ["displayName"] = L["Show Bag Icons"],
        ["description"] = L["Shows the icon directly on the item in your bag."]
    },
    ["showVerboseText"] = {
        ["displayName"] = L["Verbose Text"],
        ["description"] = L["Shows a more detailed text for some of the tooltips."]
    },
    ["showSourceLocationTooltip"] = {
        ["displayName"] = L["Show Source Location Tooltip"],
        ["description"] = L["Shows a tooltip with the source locations of an appearance (ie. Quest, Vendor, World Drop). This only works on items your current class can learn."] .. "\n\n" .. L["Please note that this may not always be correct as Blizzard's information is incomplete."]
    },
    ["printDatabaseScan"] = {
        ["displayName"] = L["Database Scanning chat messages"],
        ["description"] = L["Shows chat messages on login about the database scan."]
    },
    ["iconLocation"] = {
        ["displayName"] = L["Location: "],
        ["description"] = L["Move the icon to a different location on all frames."]
    },
    ["showToyItems"] = {
        ["displayName"] = L["Show Toy Items"],
        ["description"] = L["Show tooltips and overlays on toys (otherwise, shows as not transmoggable)."]
    },
    ["showPetItems"] = {
        ["displayName"] = L["Show Pet Items"],
        ["description"] = L["Show tooltips and overlays on pets (otherwise, shows as not transmoggable)."]
    },
    ["showMountItems"] = {
        ["displayName"] = L["Show Mount Items"],
        ["description"] = L["Show tooltips and overlays on mounts (otherwise, shows as not transmoggable)."]
    },
}


CanIMogIt.frame = CreateFrame("Frame", "CanIMogItOptionsFrame", InterfaceOptionsFramePanelContainer);
CanIMogIt.frame.name = L["Can I Mog It?"];
local category = Settings.RegisterCanvasLayoutCategory(CanIMogIt.frame, CanIMogIt.frame.name)
CanIMogIt.settingsCategory = category
Settings.RegisterAddOnCategory(category)


local EVENTS = {
    "ADDON_LOADED",
    "TRANSMOG_COLLECTION_UPDATED",
    "PLAYER_LOGIN",
    "GET_ITEM_INFO_RECEIVED",
    "BLACK_MARKET_OPEN",
    "BLACK_MARKET_ITEM_UPDATE",
    "BLACK_MARKET_CLOSE",
    "CHAT_MSG_LOOT",
    "UNIT_INVENTORY_CHANGED",
    "PLAYER_SPECIALIZATION_CHANGED",
    "BAG_UPDATE",
    "BAG_CONTAINER_UPDATE",
    "BAG_NEW_ITEMS_UPDATED",
    "QUEST_ACCEPTED",
    "BAG_SLOT_FLAGS_UPDATED",
    "BANK_BAG_SLOT_FLAGS_UPDATED",
    "PLAYERBANKSLOTS_CHANGED",
    "BANKFRAME_OPENED",
    "START_LOOT_ROLL",
    "MERCHANT_SHOW",
    "VOID_STORAGE_CONTENTS_UPDATE",
    "GUILDBANKBAGSLOTS_CHANGED",
    "TRANSMOG_COLLECTION_SOURCE_ADDED",
    "TRANSMOG_COLLECTION_SOURCE_REMOVED",
    "TRANSMOG_SEARCH_UPDATED",
    "LOADING_SCREEN_ENABLED",
    "LOADING_SCREEN_DISABLED",
    "TRADE_SKILL_SHOW",
    "NEW_TOY_ADDED",
    "NEW_MOUNT_ADDED",
    "ITEM_LOCK_CHANGED",
    "LOADING_SCREEN_ENABLED",
    "LOADING_SCREEN_DISABLED",
}

if CanIMogIt.isRetail then
    table.insert(EVENTS, "AUCTION_HOUSE_SHOW")
    table.insert(EVENTS, "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED")
    table.insert(EVENTS, "AUCTION_HOUSE_NEW_RESULTS_RECEIVED")
    table.insert(EVENTS, "PLAYERREAGENTBANKSLOTS_CHANGED")
    table.insert(EVENTS, "PET_JOURNAL_LIST_UPDATE")
end


for i, event in pairs(EVENTS) do
    CanIMogIt.frame:RegisterEvent(event);
end

CanIMogIt.Events = {}

for i, event in pairs(EVENTS) do
    CanIMogIt.Events[event] = true
end


-- Skip the itemOverlayEvents function until the loading screen is disabled.
local ifNotBusyLimit = .008
-- a dictionary of functions to run if we are not busy. Each event should only be in this once.
local ifNotBusyEvents = {}
local ifNotBusyKeys = {}

local loadingScreenEnabled = true
-- These events should be run during the loading screen, if it's enabled.
local loadingScreenEvents = {
    ["PLAYER_LOGIN"] = true,
    ["ADDON_LOADED"] = true,
}



local function makeKey(name, ...)
    -- Get the name of the function somehow??
    local key = name
    for i, arg in ipairs({...}) do
        key = key .. tostring(arg)
    end
    return key
end

--- Schedules a function to be executed when the system is not busy.
---
--- This function takes a name, a function, and additional arguments, and schedules the function
--- to be run later when the system is not busy. It ensures that the function is only added to
--- the schedule if it is not already present.
---
--- The function creates a unique key using the provided name and arguments. If the key is not
--- already in the `ifNotBusyEvents` dictionary, it adds the function and its arguments to the
--- dictionary and the key to the `ifNotBusyKeys` list.
---
--- @param name string: The name associated with the function to be scheduled.
--- @param func function: The function to be executed.
--- @param ... any: Additional arguments to be passed to the function when it is executed.
--- @return nil
local function RunIfNotBusy(name, func, ...)
    -- Sets the function to run the next time we aren't busy.
    local args = {...}
    -- only add it to the dict if it's not already in the there.
    local key = makeKey(name, ...)
    if ifNotBusyEvents[key] then
        return
    end
    ifNotBusyEvents[key] = {func, args}
    table.insert(ifNotBusyKeys, key)
end

--- Processes and executes functions that were scheduled to run when the system is not busy.
---
--- This function checks the list of scheduled functions (`ifNotBusyKeys`) and executes them
--- until the time limit (`ifNotBusyLimit`) is reached or there are no more functions to run.
--- It ensures that each function is only run once by removing it from the list and dictionary
--- after execution.
---
--- The function also updates the `eventTypes` and `functionsRun` tables to keep track of the
--- number of times each event type and function has been executed.
---
--- The execution loop will break if the time taken exceeds `ifNotBusyLimit` to prevent long
--- blocking operations.
local function RunIfNotBusyEvents()

    if #ifNotBusyKeys == 0 or loadingScreenEnabled then
        return
    end
    local startTime = GetTimePreciseSec()
    while #ifNotBusyKeys > 0 do
        local key = ifNotBusyKeys[1]
        local currentTime = GetTimePreciseSec()
        if currentTime - startTime > ifNotBusyLimit then
            break
        end
        local eventData = ifNotBusyEvents[key]
        table.remove(ifNotBusyKeys, 1)
        ifNotBusyEvents[key] = nil
        local func, args = eventData[1], eventData[2]
        func(unpack(args))
    end
    RunIfNotBusyEvents()
end


CanIMogIt.frame:SetScript("OnUpdate", RunIfNotBusyEvents)


CanIMogIt.frame.eventFunctions = {}


-- a dictionary of event names to a list of functions to run.
-- {event, {name, func}}
CanIMogIt.frame.smartEventFunctions = {}


function CanIMogIt.frame:AddSmartEvent(name, func, events)
    -- Smart events only run if there is enough time in the frame, otherwise,
    -- it pushes it off to the next frame to run.
    for i, event in ipairs(events) do
        if not CanIMogIt.frame.smartEventFunctions[event] then
            CanIMogIt.frame.smartEventFunctions[event] = {}
        end
        table.insert(CanIMogIt.frame.smartEventFunctions[event], {name, func})
    end
end


local function RunSmartEvent(event, ...)
    -- Run the overlay events if we are not busy.
    for i, eventData in ipairs(CanIMogIt.frame.smartEventFunctions[event]) do
        local name, func = unpack(eventData)
        RunIfNotBusy(name, func, event, ...)
    end
end


local function SmartEventHook(self, event, ...)
    if event == "LOADING_SCREEN_ENABLED" then
        loadingScreenEnabled = true
    elseif event == "LOADING_SCREEN_DISABLED" then
        loadingScreenEnabled = false
    end

    -- If the event is a loading screen event, run it and return.
    if loadingScreenEvents[event] then
        RunSmartEvent(event, ...)
        return
    end

    if loadingScreenEnabled then
        return
    end

    -- Smart events
    if CanIMogIt.frame.smartEventFunctions[event] then
        RunSmartEvent(event, ...)
    end
end
CanIMogIt.frame:HookScript("OnEvent", SmartEventHook)


function CanIMogIt.frame.AddonLoaded(event, addonName)
    if event == "ADDON_LOADED" and addonName == "CanIMogIt" then
        CanIMogIt.frame.Loaded()
    end
end
CanIMogIt.frame:AddSmartEvent("AddonLoaded", CanIMogIt.frame.AddonLoaded, {"ADDON_LOADED"})


local transmogEvents = {
    ["TRANSMOG_COLLECTION_SOURCE_ADDED"] = true,
    ["TRANSMOG_COLLECTION_SOURCE_REMOVED"] = true,
    ["TRANSMOG_COLLECTION_UPDATED"] = true,
}

local function TransmogCollectionUpdated(event, ...)
    if transmogEvents[event] then
        CanIMogIt:ResetCache()
    end
end

CanIMogIt.frame:AddSmartEvent("TransmogCollectionUpdated", TransmogCollectionUpdated, {"TRANSMOG_COLLECTION_SOURCE_ADDED", "TRANSMOG_COLLECTION_SOURCE_REMOVED", "TRANSMOG_COLLECTION_UPDATED"})


local changesSavedStack = {}


local function changesSavedText()
    local frame = CreateFrame("Frame", "CanIMogIt_ChangesSaved", CanIMogIt.frame)
    local text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    text:SetJustifyH("RIGHT")
    text:SetText(CanIMogIt.YELLOW .. L["Changes saved!"])

    text:SetAllPoints()

    frame:SetPoint("BOTTOMRIGHT", -20, 10)
    frame:SetSize(200, 20)
    frame:SetShown(false)
    CanIMogIt.frame.changesSavedText = frame
end


local function hideChangesSaved()
    table.remove(changesSavedStack, #changesSavedStack)
    if #changesSavedStack == 0 then
        CanIMogIt.frame.changesSavedText:SetShown(false)
    end
end


local function showChangesSaved()
    CanIMogIt.frame.changesSavedText:SetShown(true)
    table.insert(changesSavedStack, #changesSavedStack + 1)
    C_Timer.After(5, function () hideChangesSaved() end)
end


local function checkboxOnClick(self)
    local checked = self:GetChecked()
    PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
    self:SetValue(checked)
    showChangesSaved()
    -- Reset the cache when an option changes.
    CanIMogIt:ResetCache()

    CanIMogIt:SendMessage("OptionUpdate")
end

local function newCheckbox(parent, variableName, onClickFunction)
    -- Creates a new checkbox in the parent frame for the given variable name
    onClickFunction = onClickFunction or checkboxOnClick
    local displayData = CanIMogItOptions_DisplayData[variableName]
    local checkbox = CreateFrame("CheckButton", "CanIMogItCheckbox" .. variableName,
            parent, "InterfaceOptionsCheckButtonTemplate")

    -- checkbox.value = CanIMogItOptions[variableName]

    checkbox.GetValue = function (self)
        return CanIMogItOptions[variableName]
    end
    checkbox.SetValue = function (self, value) CanIMogItOptions[variableName] = value end

    checkbox:SetScript("OnClick", onClickFunction)
    checkbox:SetChecked(checkbox:GetValue())

    checkbox.label = _G[checkbox:GetName() .. "Text"]
    checkbox.label:SetText(displayData["displayName"])

    checkbox.tooltipText = displayData["displayName"]
    checkbox.tooltipRequirement = displayData["description"]
    return checkbox
end


local function newRadioGrid(parent, variableName)
    local displayData = CanIMogItOptions_DisplayData[variableName]
    local frameName = "CanIMogItCheckGridFrame" .. variableName
    local frame = CreateFrame("Frame", frameName, parent)

    frame.texture = CreateFrame("Frame", frameName .. "_Texture", frame)
    frame.texture:SetSize(58, 58)
    local texture = frame.texture:CreateTexture("CIMITextureFrame", "BACKGROUND")
    texture:SetTexture("Interface/ICONS/INV_Sword_1H_AllianceToy_A_01.blp")
    texture:SetAllPoints()
    texture:SetVertexColor(0.5, 0.5, 0.5)

    local reloadButton = CreateFrame("Button", frameName .. "_ReloadButton",
            frame, "UIPanelButtonTemplate")
    reloadButton:SetText(L["Reload to apply"])
    reloadButton:SetSize(120, 25)
    reloadButton:SetEnabled(false)
    reloadButton:SetScript("OnClick", function () ReloadUI() end)

    local title = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    title:SetText(L["Icon Location"])

    local text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    text:SetText(L["Does not affect Quests or Adventure Journal."])

    local text2 = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    text2:SetText(L["Default"] .. ": " .. L["Top Right"])

    local radioTopLeft = CreateFrame("CheckButton", frameName .. "_TopLeft",
            frame, "UIRadioButtonTemplate")
    local radioTop = CreateFrame("CheckButton", frameName .. "_Top",
            frame, "UIRadioButtonTemplate")
    local radioTopRight = CreateFrame("CheckButton", frameName .. "_TopRight",
            frame, "UIRadioButtonTemplate")
    local radioLeft = CreateFrame("CheckButton", frameName .. "_Left",
            frame, "UIRadioButtonTemplate")
    local radioCenter = CreateFrame("CheckButton", frameName .. "_Center",
            frame, "UIRadioButtonTemplate")
    local radioRight = CreateFrame("CheckButton", frameName .. "_Right",
            frame, "UIRadioButtonTemplate")
    local radioBottomLeft = CreateFrame("CheckButton", frameName .. "_BottomLeft",
            frame, "UIRadioButtonTemplate")
    local radioBottom = CreateFrame("CheckButton", frameName .. "_Bottom",
            frame, "UIRadioButtonTemplate")
    local radioBottomRight = CreateFrame("CheckButton", frameName .. "_BottomRight",
            frame, "UIRadioButtonTemplate")

    radioTopLeft:SetChecked(CanIMogItOptions[variableName] == "TOPLEFT")
    radioTop:SetChecked(CanIMogItOptions[variableName] == "TOP")
    radioTopRight:SetChecked(CanIMogItOptions[variableName] == "TOPRIGHT")
    radioLeft:SetChecked(CanIMogItOptions[variableName] == "LEFT")
    radioCenter:SetChecked(CanIMogItOptions[variableName] == "CENTER")
    radioRight:SetChecked(CanIMogItOptions[variableName] == "RIGHT")
    radioBottomLeft:SetChecked(CanIMogItOptions[variableName] == "BOTTOMLEFT")
    radioBottom:SetChecked(CanIMogItOptions[variableName] == "BOTTOM")
    radioBottomRight:SetChecked(CanIMogItOptions[variableName] == "BOTTOMRIGHT")

    local allRadios = {
        radioTopLeft,
        radioTop,
        radioTopRight,
        radioLeft,
        radioCenter,
        radioRight,
        radioBottomLeft,
        radioBottom,
        radioBottomRight
    }

    local function createOnRadioClicked (location)
        local function onRadioClicked (self, a, b, c)
            local checked = self:GetChecked()
            PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
            CanIMogItOptions[variableName] = location

            local anyChecked = false
            for _, radio in ipairs(allRadios) do
                if radio ~= self then
                    anyChecked = radio:GetChecked() or anyChecked
                    radio:SetChecked(false)
                end
            end
            if not anyChecked then
                self:SetChecked(true)
            end
            reloadButton:SetEnabled(true)
            showChangesSaved()
        end
        return onRadioClicked
    end

    radioTopLeft:SetScript("OnClick", createOnRadioClicked("TOPLEFT"))
    radioTop:SetScript("OnClick", createOnRadioClicked("TOP"))
    radioTopRight:SetScript("OnClick", createOnRadioClicked("TOPRIGHT"))
    radioLeft:SetScript("OnClick", createOnRadioClicked("LEFT"))
    radioCenter:SetScript("OnClick", createOnRadioClicked("CENTER"))
    radioRight:SetScript("OnClick", createOnRadioClicked("RIGHT"))
    radioBottomLeft:SetScript("OnClick", createOnRadioClicked("BOTTOMLEFT"))
    radioBottom:SetScript("OnClick", createOnRadioClicked("BOTTOM"))
    radioBottomRight:SetScript("OnClick", createOnRadioClicked("BOTTOMRIGHT"))

    title:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -5)

    radioTopLeft:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -5)
    radioTop:SetPoint("TOPLEFT", radioTopLeft, "TOPRIGHT", 5, 0)
    radioTopRight:SetPoint("TOPLEFT", radioTop, "TOPRIGHT", 5, 0)
    radioLeft:SetPoint("TOPLEFT", radioTopLeft, "BOTTOMLEFT", 0, -5)
    radioCenter:SetPoint("TOPLEFT", radioLeft, "TOPRIGHT", 5, 0)
    radioRight:SetPoint("TOPLEFT", radioCenter, "TOPRIGHT", 5, 0)
    radioBottomLeft:SetPoint("TOPLEFT", radioLeft, "BOTTOMLEFT", 0, -5)
    radioBottom:SetPoint("TOPLEFT", radioBottomLeft, "TOPRIGHT", 5, 0)
    radioBottomRight:SetPoint("TOPLEFT", radioBottom, "TOPRIGHT", 5, 0)

    text:SetPoint("TOPLEFT", radioTopRight, "TOPRIGHT", 14, -3)
    text2:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 0, -3)

    reloadButton:SetPoint("TOPLEFT", text2, "BOTTOMLEFT", 4, -8)

    frame.texture:SetPoint("TOPLEFT", radioTopLeft, "TOPLEFT")

    frame:SetSize(600, 80)

    -- Use this to show the bottom of the frame.
    -- local sample = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    -- sample:SetText("example.")
    -- sample:SetPoint("TOPLEFT", frame, "BOTTOMLEFT")

    return frame
end


local function createOptionsMenu()
    -- define the checkboxes
    CanIMogIt.frame.showEquippableOnly = newCheckbox(CanIMogIt.frame, "showEquippableOnly")
    CanIMogIt.frame.showTransmoggableOnly = newCheckbox(CanIMogIt.frame, "showTransmoggableOnly")
    CanIMogIt.frame.showUnknownOnly = newCheckbox(CanIMogIt.frame, "showUnknownOnly")
    CanIMogIt.frame.showSetInfo = newCheckbox(CanIMogIt.frame, "showSetInfo")
    CanIMogIt.frame.showItemIconOverlay = newCheckbox(CanIMogIt.frame, "showItemIconOverlay")
    CanIMogIt.frame.showVerboseText = newCheckbox(CanIMogIt.frame, "showVerboseText")
    CanIMogIt.frame.showSourceLocationTooltip = newCheckbox(CanIMogIt.frame, "showSourceLocationTooltip")
    CanIMogIt.frame.printDatabaseScan = newCheckbox(CanIMogIt.frame, "printDatabaseScan")
    CanIMogIt.frame.iconLocation = newRadioGrid(CanIMogIt.frame, "iconLocation")
    CanIMogIt.frame.showToyItems = newCheckbox(CanIMogIt.frame, "showToyItems")
    CanIMogIt.frame.showPetItems = newCheckbox(CanIMogIt.frame, "showPetItems")
    CanIMogIt.frame.showMountItems = newCheckbox(CanIMogIt.frame, "showMountItems")

    -- position the checkboxes
    CanIMogIt.frame.showEquippableOnly:SetPoint("TOPLEFT", 16, -16)
    CanIMogIt.frame.showTransmoggableOnly:SetPoint("TOPLEFT", CanIMogIt.frame.showEquippableOnly, "BOTTOMLEFT")
    CanIMogIt.frame.showUnknownOnly:SetPoint("TOPLEFT", CanIMogIt.frame.showTransmoggableOnly, "BOTTOMLEFT")
    CanIMogIt.frame.showSetInfo:SetPoint("TOPLEFT", CanIMogIt.frame.showUnknownOnly, "BOTTOMLEFT")
    CanIMogIt.frame.showItemIconOverlay:SetPoint("TOPLEFT", CanIMogIt.frame.showSetInfo, "BOTTOMLEFT")
    CanIMogIt.frame.showVerboseText:SetPoint("TOPLEFT", CanIMogIt.frame.showItemIconOverlay, "BOTTOMLEFT")
    CanIMogIt.frame.showSourceLocationTooltip:SetPoint("TOPLEFT", CanIMogIt.frame.showVerboseText, "BOTTOMLEFT")
    CanIMogIt.frame.printDatabaseScan:SetPoint("TOPLEFT", CanIMogIt.frame.showSourceLocationTooltip, "BOTTOMLEFT")
    CanIMogIt.frame.iconLocation:SetPoint("TOPLEFT", CanIMogIt.frame.printDatabaseScan, "BOTTOMLEFT")
    CanIMogIt.frame.showToyItems:SetPoint("TOPLEFT", CanIMogIt.frame.iconLocation, "BOTTOMLEFT")
    CanIMogIt.frame.showPetItems:SetPoint("TOPLEFT", CanIMogIt.frame.showToyItems, "BOTTOMLEFT")
    CanIMogIt.frame.showMountItems:SetPoint("TOPLEFT", CanIMogIt.frame.showPetItems, "BOTTOMLEFT")

    changesSavedText()
end


function CanIMogIt.frame.Loaded()
    -- Set the Options from defaults.
    if (not CanIMogItOptions) then
        CanIMogItOptions = CanIMogItOptions_Defaults.options
        print(L["CanIMogItOptions not found, loading defaults!"])
    end
    -- Set missing options from the defaults if the version is out of date.
    if (CanIMogItOptions["version"] < CanIMogIt_OptionsVersion) then
        local CanIMogItOptions_temp = CanIMogItOptions_Defaults.options;
        for k,v in pairs(CanIMogItOptions) do
            if (CanIMogItOptions_Defaults.options[k]) then
                CanIMogItOptions_temp[k] = v;
            end
        end
        CanIMogItOptions_temp["version"] = CanIMogIt_OptionsVersion;
        CanIMogItOptions = CanIMogItOptions_temp;
    end
    createOptionsMenu()
end

CanIMogIt:RegisterChatCommand("cimi", "SlashCommands")
CanIMogIt:RegisterChatCommand("canimogit", "SlashCommands")

local function printHelp()
    CanIMogIt:Print([[
Can I Mog It? help:
    Usage: /cimi <command>
    e.g. /cimi help

    help            Displays this help message.
    verbose         Toggles verbose mode on tooltip.
    overlay         Toggles the icon overlay.
    refresh         Refreshes the overlay, forcing a redraw.
    equiponly       Toggles showing overlay on non-equipable items.
    transmogonly    Toggles showing overlay on non-transmogable items.
    unknownonly     Toggles showing overlay on known items.
    toyitems        Toggles showing overlay on toy items.
    petitems        Toggles showing overlay on pet items.
    mountitems      Toggles showing overlay on mount items.
    ]])
end

function CanIMogIt:SlashCommands(input)
    -- Slash command router.
    if input == "" then
        self:OpenOptionsMenu()
    elseif input == 'overlay' then
        CanIMogIt.frame.showItemIconOverlay:Click()
    elseif input == 'verbose' then
        CanIMogIt.frame.showVerboseText:Click()
    elseif input == 'equiponly' then
        CanIMogIt.frame.showEquippableOnly:Click()
    elseif input == 'transmogonly' then
        CanIMogIt.frame.showTransmoggableOnly:Click()
    elseif input == 'unknownonly' then
        CanIMogIt.frame.showUnknownOnly:Click()
    elseif input == 'toyitems' then
        CanIMogIt.frame.showToyItems:Click()
    elseif input == 'petitems' then
        CanIMogIt.frame.showPetItems:Click()
    elseif input == 'mountitems' then
        CanIMogIt.frame.showMountItems:Click()
    elseif input == 'refresh' then
        self:ResetCache()
    elseif input == 'help' then
        printHelp()
    else
        self:Print("Unknown command!")
    end
end

function CanIMogIt:OpenOptionsMenu()
    Settings.OpenToCategory(CanIMogIt.settingsCategory.ID)
end

CanIMogIt.cache = {}

function CanIMogIt.cache:Clear()
    self.data = {
        ["source"] = {},
        ["dressup_source"] = {},
        ["sets"] = {},
        ["setsSumRatio"] = {},
        ["appearanceData"] = {},
        ["itemData"] = {},
        ["bindData"] = {},
    }
end


function CanIMogIt.cache:GetAppearanceDataValue(itemLink)
    return self.data["appearanceData"][CanIMogIt:CalculateKey(itemLink)]
end


function CanIMogIt.cache:SetAppearanceDataValue(appData)
    if appData == nil then return end
    self.data["appearanceData"][appData.key] = appData
end


function CanIMogIt.cache:GetItemDataValue(itemLink)
    return self.data["itemData"][CanIMogIt:CalculateKey(itemLink)]
end


function CanIMogIt.cache:SetItemDataValue(itemData)
    if itemData == nil then return end
    self.data["itemData"][itemData.key] = itemData
end


function CanIMogIt.cache:GetBindDataValue(itemLink, bag, slot)
    return self.data["bindData"][CanIMogIt.BindData.CalculateKey(itemLink, bag, slot)]
end


function CanIMogIt.cache:SetBindDataValue(bindData)
    if bindData == nil then return end
    self.data["bindData"][bindData.key] = bindData
end


function CanIMogIt.cache:DeleteBindDataValue(itemLink, bag, slot)
    if itemLink == nil and (bag == nil or slot == nil) then
        return
    end
    if itemLink == nil then
        itemLink = C_Container.GetContainerItemLink(bag, slot)
    end
    if self.data["bindData"][CanIMogIt.BindData.CalculateKey(itemLink, bag, slot)] ~= nil then
        self.data["bindData"][CanIMogIt.BindData.CalculateKey(itemLink, bag, slot)] = nil
    end
    if itemLink then
        -- Delete the itemLink key as well, since it may be cached without the bag and slot.
        self.data["bindData"][CanIMogIt:CalculateKey(itemLink)] = nil
    end
end


function CanIMogIt.cache:RemoveItem(itemLink)
    self.data["source"][CanIMogIt:CalculateKey(itemLink)] = nil
    -- Have to remove all of the set data, since other itemLinks may cache
    -- the same set information. Alternatively, we scan through and find
    -- the same set on other items, but they're loaded on mouseover anyway,
    -- so it shouldn't be slow. Also applies to RemoveItemBySourceID.
    self:ClearSetData()
end


function CanIMogIt.cache:GetItemSourcesValue(itemLink)
    return self.data["source"][CanIMogIt:CalculateKey(itemLink)]
end


function CanIMogIt.cache:SetItemSourcesValue(itemLink, value)
    self.data["source"][CanIMogIt:CalculateKey(itemLink)] = value
end


function CanIMogIt.cache:GetSetsInfoTextValue(itemLink)
    return self.data["sets"][CanIMogIt:CalculateKey(itemLink)]
end


function CanIMogIt.cache:SetSetsInfoTextValue(itemLink, value)
    self.data["sets"][CanIMogIt:CalculateKey(itemLink)] = value
end


function CanIMogIt.cache:GetDressUpModelSource(itemLink)
    return self.data["dressup_source"][itemLink]
end

function CanIMogIt.cache:SetDressUpModelSource(itemLink, value)
    self.data["dressup_source"][itemLink] = value
end


function CanIMogIt.cache:ClearSetData()
    self.data["sets"] = {}
    self.data["setsSumRatio"] = {}
end


function CanIMogIt.cache:GetSetsSumRatioTextValue(key)
    return self.data["setsSumRatio"][key]
end


function CanIMogIt.cache:SetSetsSumRatioTextValue(key, value)
    self.data["setsSumRatio"][key] = value
end


local function OnClearCacheEvent(event)
    if event == "TRANSMOG_COLLECTION_UPDATED" then
        CanIMogIt.cache:Clear()
    end
end

CanIMogIt.frame:AddSmartEvent("OnClearCacheEvent", OnClearCacheEvent, {"TRANSMOG_COLLECTION_UPDATED"})

local function OnClearBindCacheEvent(event, bag, slot)
    if event == "ITEM_LOCK_CHANGED" then
        CanIMogIt.cache:DeleteBindDataValue(nil, bag, slot)
    end
end

CanIMogIt.frame:AddSmartEvent("OnClearBindCacheEvent", OnClearBindCacheEvent, {"ITEM_LOCK_CHANGED"})

CanIMogIt.cache:Clear()

CanIMogIt.Requirements = {}


local function GetPlayerClass()
    return select(1, UnitClass("player"))
end


local requirements


function CanIMogIt.Requirements:GetRequirements()
    if not requirements then
        requirements = {
            classRestrictions = GetPlayerClass()
        }
    end
    return requirements
end
-- This file is loaded from "CanIMogIt.toc"

CanIMogIt.DressUpModel = CreateFrame('DressUpModel')
CanIMogIt.DressUpModel:SetUnit('player')


-----------------------------
-- Maps                    --
-----------------------------

---- Transmog Categories
-- 1 Head
-- 2 Shoulder
-- 3 Back
-- 4 Chest
-- 5 Shirt
-- 6 Tabard
-- 7 Wrist
-- 8 Hands
-- 9 Waist
-- 10 Legs
-- 11 Feet
-- 12 Wand
-- 13 One-Handed Axes
-- 14 One-Handed Swords
-- 15 One-Handed Maces
-- 16 Daggers
-- 17 Fist Weapons
-- 18 Shields
-- 19 Held In Off-hand
-- 20 Two-Handed Axes
-- 21 Two-Handed Swords
-- 22 Two-Handed Maces
-- 23 Staves
-- 24 Polearms
-- 25 Bows
-- 26 Guns
-- 27 Crossbows
-- 28 Warglaives


local HEAD = "INVTYPE_HEAD"
local SHOULDER = "INVTYPE_SHOULDER"
local BODY = "INVTYPE_BODY"
local CHEST = "INVTYPE_CHEST"
local ROBE = "INVTYPE_ROBE"
local WAIST = "INVTYPE_WAIST"
local LEGS = "INVTYPE_LEGS"
local FEET = "INVTYPE_FEET"
local WRIST = "INVTYPE_WRIST"
local HAND = "INVTYPE_HAND"
local CLOAK = "INVTYPE_CLOAK"
local WEAPON = "INVTYPE_WEAPON"
local SHIELD = "INVTYPE_SHIELD"
local WEAPON_2HAND = "INVTYPE_2HWEAPON"
local WEAPON_MAIN_HAND = "INVTYPE_WEAPONMAINHAND"
local RANGED = "INVTYPE_RANGED"
local RANGED_RIGHT = "INVTYPE_RANGEDRIGHT"
local WEAPON_OFF_HAND = "INVTYPE_WEAPONOFFHAND"
local HOLDABLE = "INVTYPE_HOLDABLE"
local TABARD = "INVTYPE_TABARD"
local BAG = "INVTYPE_BAG"
local NONEQUIP = "INVTYPE_NON_EQUIP_IGNORE"


local inventorySlotsMap = {
    [HEAD] = {1},
    [SHOULDER] = {3},
    [BODY] = {4},
    [CHEST] = {5},
    [ROBE] = {5},
    [WAIST] = {6},
    [LEGS] = {7},
    [FEET] = {8},
    [WRIST] = {9},
    [HAND] = {10},
    [CLOAK] = {15},
    [WEAPON] = {16, 17},
    [SHIELD] = {17},
    [WEAPON_2HAND] = {16, 17},
    [WEAPON_MAIN_HAND] = {16},
    [RANGED] = {16},
    [RANGED_RIGHT] = {16},
    [WEAPON_OFF_HAND] = {17},
    [HOLDABLE] = {17},
    [TABARD] = {19},
}


-- This is a one-time call to get a "transmogLocation" object, which we don't actually care about,
-- but some functions require it now.
local transmogLocation = TransmogUtil.GetTransmogLocation(inventorySlotsMap[HEAD][1], Enum.TransmogType.Appearance, Enum.TransmogModification.Main)


local MISC = 0
local CLOTH = 1
local LEATHER = 2
local MAIL = 3
local PLATE = 4
local COSMETIC = 5

local classArmorTypeMap = {
    ["DEATHKNIGHT"] = PLATE,
    ["DEMONHUNTER"] = LEATHER,
    ["DRUID"] = LEATHER,
    ["EVOKER"] = MAIL,
    ["HUNTER"] = MAIL,
    ["MAGE"] = CLOTH,
    ["MONK"] = LEATHER,
    ["PALADIN"] = PLATE,
    ["PRIEST"] = CLOTH,
    ["ROGUE"] = LEATHER,
    ["SHAMAN"] = MAIL,
    ["WARLOCK"] = CLOTH,
    ["WARRIOR"] = PLATE,
}


-- Class Masks
local classMask = {
    [1] = "WARRIOR",
    [2] = "PALADIN",
    [4] = "HUNTER",
    [8] = "ROGUE",
    [16] = "PRIEST",
    [32] = "DEATHKNIGHT",
    [64] = "SHAMAN",
    [128] = "MAGE",
    [256] = "WARLOCK",
    [512] = "MONK",
    [1024] = "DRUID",
    [2048] = "DEMONHUNTER",
    [4096] = "EVOKER",
}


local armorTypeSlots = {
    [HEAD] = true,
    [SHOULDER] = true,
    [CHEST] = true,
    [ROBE] = true,
    [WRIST] = true,
    [HAND] = true,
    [WAIST] = true,
    [LEGS] = true,
    [FEET] = true,
}


local miscArmorExceptions = {
    [HOLDABLE] = true,
    [BODY] = true,
    [TABARD] = true,
}


local APPEARANCES_ITEMS_TAB = 1
local APPEARANCES_SETS_TAB = 2


-- Get the name for Cosmetic. Uses http://www.wowhead.com/item=130064/deadeye-monocle.
local COSMETIC_NAME = select(3, C_Item.GetItemInfoInstant(130064))


-------------------------
-- Text related tables --
-------------------------


-- Maps a text to its simpler version
local simpleTextMap = {
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER] = CanIMogIt.KNOWN,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE] = CanIMogIt.KNOWN_BOE,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE] = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE,
}


-- List of all Known texts
local knownTexts = {
    [CanIMogIt.KNOWN] = true,
    [CanIMogIt.KNOWN_BOE] = true,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM] = true,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE] = true,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER] = true,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE] = true,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = true,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE] = true,
}


local unknownTexts = {
    [CanIMogIt.UNKNOWN] = true,
    [CanIMogIt.UNKNOWABLE_BY_CHARACTER] = true,
}


-----------------------------
-- Exceptions              --
-----------------------------


local exceptionItems = {
    [HEAD] = {
        -- [134110] = CanIMogIt.KNOWN, -- Hidden Helm
        [133320] = CanIMogIt.NOT_TRANSMOGABLE, -- Illidari Blindfold (Alliance)
        [112450] = CanIMogIt.NOT_TRANSMOGABLE, -- Illidari Blindfold (Horde)
        -- [150726] = CanIMogIt.NOT_TRANSMOGABLE, -- Illidari Blindfold (Alliance) - starting item
        -- [150716] = CanIMogIt.NOT_TRANSMOGABLE, -- Illidari Blindfold (Horde) - starting item
    },
    [SHOULDER] = {
        [119556] = CanIMogIt.NOT_TRANSMOGABLE, -- Trailseeker Spaulders - 100 Salvage Yard ilvl 610
        [117106] = CanIMogIt.NOT_TRANSMOGABLE, -- Trailseeker Spaulders - 90 boost ilvl 483
        [129714] = CanIMogIt.NOT_TRANSMOGABLE, -- Trailseeker Spaulders - 100 trial/boost ilvl 640
        [150642] = CanIMogIt.NOT_TRANSMOGABLE, -- Trailseeker Spaulders - 100 trial/boost ilvl 600
        [153810] = CanIMogIt.NOT_TRANSMOGABLE, -- Trailseeker Spaulders - 110 trial/boost ilvl 870
        [162796] = CanIMogIt.NOT_TRANSMOGABLE, -- Wildguard Spaulders - 8.0 BfA Pre-Patch event
        [119588] = CanIMogIt.NOT_TRANSMOGABLE, -- Mistdancer Pauldrons - 100 Salvage Yard ilvl 610
        [117138] = CanIMogIt.NOT_TRANSMOGABLE, -- Mistdancer Pauldrons - 90 boost ilvl 483
        [129485] = CanIMogIt.NOT_TRANSMOGABLE, -- Mistdancer Pauldrons - 100 trial/boost ilvl 640
        [150658] = CanIMogIt.NOT_TRANSMOGABLE, -- Mistdancer Pauldrons - 100 trial/boost ilvl 600
        [153842] = CanIMogIt.NOT_TRANSMOGABLE, -- Mistdancer Pauldrons - 110 trial/boost ilvl 870
        [162812] = CanIMogIt.NOT_TRANSMOGABLE, -- Serene Disciple's Padding - 8.0 BfA Pre-Patch event
        [134112] = CanIMogIt.KNOWN, -- Hidden Shoulders
    },
    [BODY] = {},
    [CHEST] = {},
    [ROBE] = {},
    [WAIST] = {
        [143539] = CanIMogIt.KNOWN, -- Hidden Belt
    },
    [LEGS] = {},
    [FEET] = {},
    [WRIST] = {},
    [HAND] = {
        [119585] = CanIMogIt.NOT_TRANSMOGABLE, -- Mistdancer Handguards - 100 Salvage Yard ilvl 610
        [117135] = CanIMogIt.NOT_TRANSMOGABLE, -- Mistdancer Handguards - 90 boost ilvl 483
        [129482] = CanIMogIt.NOT_TRANSMOGABLE, -- Mistdancer Handguards - 100 trial/boost ilvl 640
        [150655] = CanIMogIt.NOT_TRANSMOGABLE, -- Mistdancer Handguards - 100 trial/boost ilvl 600
        [153839] = CanIMogIt.NOT_TRANSMOGABLE, -- Mistdancer Handguards - 110 trial/boost ilvl 870
        [162809] = CanIMogIt.NOT_TRANSMOGABLE, -- Serene Disciple's Handguards - 8.0 BfA Pre-Patch event
    },
    [CLOAK] = {
        -- [134111] = CanIMogIt.KNOWN, -- Hidden Cloak
        [112462] = CanIMogIt.NOT_TRANSMOGABLE, -- Illidari Drape
    },
    [WEAPON] = {},
    [SHIELD] = {},
    [WEAPON_2HAND] = {},
    [WEAPON_MAIN_HAND] = {},
    [RANGED] = {},
    [RANGED_RIGHT] = {},
    [WEAPON_OFF_HAND] = {},
    [HOLDABLE] = {},
    [TABARD] = {
        -- [142504] = CanIMogIt.KNOWN, -- Hidden Tabard
    },
}


-----------------------------
-- Helper functions        --
-----------------------------

CanIMogIt.Utils = {}


function CanIMogIt.Utils.pairsByKeys (t, f)
    -- returns a sorted iterator for a table.
    -- https://www.lua.org/pil/19.3.html
    -- Why is it not a built in function? ¯\_(ツ)_/¯
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
        table.sort(a, f)
        local i = 0      -- iterator variable
        local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
            else return a[i], t[a[i]]
        end
    end
    return iter
end


function CanIMogIt.Utils.copyTable (t)
    -- shallow-copy a table
    if type(t) ~= "table" then return t end
    local target = {}
    for k, v in pairs(t) do target[k] = v end
    return target
end


function CanIMogIt.Utils.spairs(t, order)
    -- Returns an iterator that is a sorted table. order is the function to sort by.
    -- http://stackoverflow.com/questions/15706270/sort-a-table-in-lua
    -- Again, why is this not a built in function? ¯\_(ツ)_/¯

    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end


function CanIMogIt.Utils.strsplit(delimiter, text)
    -- from http://lua-users.org/wiki/SplitJoin
    -- Split text into a list consisting of the strings in text,
    -- separated by strings matching delimiter (which may be a pattern).
    -- example: strsplit(",%s*", "Anna, Bob, Charlie,Dolores")
    local list = {}
    local pos = 1
    if string.find("", delimiter, 1) then -- this would result in endless loops
       error("delimiter matches empty string!")
    end
    while 1 do
       local first, last = string.find(text, delimiter, pos)
       if first then -- found?
          table.insert(list, string.sub(text, pos, first-1))
          pos = last+1
       else
          table.insert(list, string.sub(text, pos))
          break
       end
    end
    return list
end


function CanIMogIt.Utils.tablelength(T)
    -- Count the number of keys in a table, because tables don't bother
    -- counting themselves if it's filled with key-value pairs...
    -- ¯\_(ツ)_/¯
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end


function CanIMogIt.Utils.GetKeys(T)
    --- Get an array of the keys from a table.
    local result = {}
    for key, _ in pairs(T) do
        table.insert(result, key)
    end
    return result
end


-----------------------------
-- CanIMogIt Core methods  --
-----------------------------


function CIMI_GetVariantSets(setID)
    --[[
        It seems that C_TransmogSets.GetVariantSets(setID) returns a number
        (instead of the expected table of sets) if it can't find a matching
        base set. We currently are checking that it's returning a table first
        to prevent issues.
    ]]
    local variantSets = C_TransmogSets.GetVariantSets(setID)
    if type(variantSets) == "table" then
        return variantSets
    end
    return {}
end


function CanIMogIt:GetSets()
    -- Gets a table of all of the sets available to the character,
    -- along with their items, and adds them to the sets database.
    C_TransmogCollection.ClearSearch(APPEARANCES_SETS_TAB)
    for i, set in pairs(C_TransmogSets.GetAllSets()) do
        -- This is a base set, so we need to get the variant sets as well
        for i, sourceID in pairs(C_TransmogSets.GetAllSourceIDs(set.setID)) do
            CanIMogIt:SetsDBAddSetItem(set, sourceID)
        end
        for i, variantSet in pairs(CIMI_GetVariantSets(set.setID)) do
            for i, sourceID in pairs(C_TransmogSets.GetAllSourceIDs(variantSet.setID)) do
                CanIMogIt:SetsDBAddSetItem(variantSet, sourceID)
            end
        end
    end
end
CanIMogIt.GetSets = CanIMogIt.RetailWrapper(CanIMogIt.GetSets)


function CanIMogIt.GetRatio(setID)
    -- Gets the count of known and total sources for the given setID.
    local have = 0
    local total = 0
    for _, appearance in pairs(C_TransmogSets.GetSetPrimaryAppearances(setID)) do
        total = total + 1
        if appearance.collected then
            have = have + 1
        end
    end
    return have, total
end


function CanIMogIt.GetRatioTextColor(have, total)
    if have == total then
        return CanIMogIt.BLUE
    elseif have > 0 then
        return CanIMogIt.RED_ORANGE
    else
        return CanIMogIt.GRAY
    end
end


function CanIMogIt.GetRatioText(setID)
    -- Gets the ratio text (and color) of known/total for the given setID.
    local have, total = CanIMogIt.GetRatio(setID)

    local ratioText = CanIMogIt.GetRatioTextColor(have, total)
    ratioText = ratioText .. "(" .. have .. "/" .. total .. ")"
    return ratioText
end


function CanIMogIt:GetSetClass(set)
    --[[
        Returns the set's class. If it belongs to more than one class,
        return an empty string.

        This is done based on the player's sex.
        Player's sex
        1 = Neutrum / Unknown
        2 = Male
        3 = Female
    ]]
    local playerSex = UnitSex("player")
    local className
    if playerSex == 2 then
        className = LOCALIZED_CLASS_NAMES_MALE[classMask[set.classMask]]
    else
        className = LOCALIZED_CLASS_NAMES_FEMALE[classMask[set.classMask]]
    end
    return className or ""
end


local classSetIDs = nil


function CanIMogIt:CalculateSetsText(itemLink)
    --[[
        Gets the two lines of text to display on the tooltip related to sets.

        Example:

        Demon Hunter: Garb of the Something or Other
        Ulduar: 25 Man Normal (2/8)

        This function is not cached, so avoid calling often!
        Use GetSetsText whenever possible!
    ]]
    local sourceID = CanIMogIt:GetSourceID(itemLink)
    if not sourceID then return end
    local setID = CanIMogIt:SetsDBGetSetFromSourceID(sourceID)
    if not setID then return end

    local set = C_TransmogSets.GetSetInfo(setID)

    local ratioText = CanIMogIt.GetRatioText(setID)

    -- Build the classSetIDs table, if it hasn't been built yet.
    if classSetIDs == nil then
        classSetIDs = {}
        for i, baseSet in pairs(C_TransmogSets.GetBaseSets()) do
            classSetIDs[baseSet.setID] = true
            for i, variantSet in pairs(C_TransmogSets.GetVariantSets(baseSet.setID)) do
                classSetIDs[variantSet.setID] = true
            end
        end
    end

    local setNameColor, otherClass
    if classSetIDs[set.setID] then
        setNameColor = CanIMogIt.WHITE
        otherClass = ""
    else
        setNameColor = CanIMogIt.GRAY
        otherClass = CanIMogIt:GetSetClass(set) .. ": "
    end


    local secondLineText = ""
    if set.label and set.description then
        secondLineText = CanIMogIt.WHITE .. set.label .. ": " .. CanIMogIt.BLIZZARD_GREEN ..  set.description .. " "
    elseif set.label then
        secondLineText = CanIMogIt.WHITE .. set.label .. " "
    elseif set.description then
        secondLineText = CanIMogIt.BLIZZARD_GREEN .. set.description .. " "
    end
    -- TODO: replace CanIMogIt.WHITE with setNameColor, add otherClass
    -- e.g.: setNameColor .. otherClass .. set.name
    return CanIMogIt.WHITE .. set.name, secondLineText .. ratioText
end


function CanIMogIt:GetSetsText(itemLink)
    -- Gets the cached text regarding the sets info for the given item.
    local line1, line2;
    if CanIMogIt.cache:GetSetsInfoTextValue(itemLink) then
        line1, line2 = unpack(CanIMogIt.cache:GetSetsInfoTextValue(itemLink))
        return line1, line2
    end

    line1, line2 = CanIMogIt:CalculateSetsText(itemLink)

    CanIMogIt.cache:SetSetsInfoTextValue(itemLink, {line1, line2})

    return line1, line2
end

-- sort by the uiOrder and then the setID
function CanIMogIt.SortSets(t, a, b)
    if t[a].uiOrder == t[b].uiOrder then
        return t[a].setID < t[b].setID
    end
    return t[a].uiOrder < t[b].uiOrder
end


function CanIMogIt.GetVariantSets(setID)
    --[[
        Given a setID, return a table of all the variant sets for that set.
    ]]
    local variantSets = {C_TransmogSets.GetSetInfo(setID)}
    for i, variantSet in pairs(CIMI_GetVariantSets(setID)) do
        variantSets[#variantSets+1] = variantSet
    end
    return variantSets
end


function CanIMogIt.GetVariantSetsTexts(variantSets)
    --[[
        Given a table of variant sets, return a table of the texts to display
        for each variant set.
    ]]
    local variantSetsTexts = {}

    for i, variantSet in CanIMogIt.Utils.spairs(variantSets, CanIMogIt.SortSets) do
        local variantHave, variantTotal = CanIMogIt.GetRatio(variantSet.setID)
        local color = CanIMogIt.GetRatioTextColor(variantHave, variantTotal)
        variantSetsTexts[#variantSetsTexts+1] = color .. variantHave .. "/" .. variantTotal
    end

    return variantSetsTexts
end


function CanIMogIt:CalculateSetsVariantText(setID)
    --[[
        Given a setID, calculate the sum of all known sources for this set
        and it's variants.

        We are assuming that there are never more than 8 variants for a set.
        If there are, we'll have to modify this to add a third row I guess?
        Or maybe change it entirely. ¯\_(ツ)_/¯
    ]]

    local variantSets = CanIMogIt.GetVariantSets(setID)

    local variantsTexts = CanIMogIt.GetVariantSetsTexts(variantSets)

    -- If there are 4 or less variants, we want to display them all on top of each other:
    --[[
        1/8
        2/8
        3/8
        4/8
    ]]
    -- If there are 5 or more, we want to display them in a 2x2 grid, growing from the bottom:
    --[[
             1/8
             2/8
        5/8  3/8
        6/8  4/8
    ]]
    local variantsTextTotal = ""
    local numVariants = #variantsTexts
    local grid = {}

    for i = 1, numVariants do
        -- The row is 1 through 4, then 1 through 4 again.
        local row = i > 4 and i - 4 or i
        -- The column is 1 for <= 4, 2 for > 4.
        local col = i > 4 and 1 or 2
        grid[row] = grid[row] or {}
        grid[row][col] = variantsTexts[i]
    end

    -- For each variant greater than 4
    for i = 1, 4-(8-numVariants) do
        -- If there are fewer than 8 variants, cells in the left column move to the bottom.
        grid[i+(8-numVariants)][1] = grid[i][1]
        grid[i][1] = " "
    end

    -- Output the grid to a string.
    for i = 1, #grid do
        if grid[i][2] then
            variantsTextTotal = variantsTextTotal .. (grid[i][1] or "") .. "  " .. (grid[i][2] or "") .. " \n"
        else
            variantsTextTotal = variantsTextTotal .. (grid[i][1] or "") .. " \n"
        end
    end

    return string.gsub(variantsTextTotal, " \n$", " ")
end


function CanIMogIt:GetSetsVariantText(setID)
    -- Gets the cached text regarding the sets info for the given item.
    if not setID then return end
    local line1;
    if CanIMogIt.cache:GetSetsSumRatioTextValue(setID) then
        line1 = CanIMogIt.cache:GetSetsSumRatioTextValue(setID)
        return line1
    end

    line1 = CanIMogIt:CalculateSetsVariantText(setID)

    CanIMogIt.cache:SetSetsSumRatioTextValue(setID, line1)

    return line1
end


function CanIMogIt:ResetCache()
    -- Resets the cache, and calls things relying on the cache being reset.
    CanIMogIt.cache:Clear()
    CanIMogIt:SendMessage("ResetCache")
    -- Fake a BAG_UPDATE event to updating the icons. TODO: Replace this with message
    CanIMogIt.frame:ItemOverlayEvents("BAG_UPDATE")
end


function CanIMogIt:CalculateSourceLocationText(itemLink)
    --[[
        Calculates the sources for this item.
        This function is not cached, so avoid calling often!
        Use GetSourceLocationText whenever possible!
    ]]
    local output = ""

    local appearanceID = CanIMogIt:GetAppearanceID(itemLink)
    if appearanceID == nil then return end
    local sources = C_TransmogCollection.GetAppearanceSources(appearanceID, 1, transmogLocation)
    if sources then
        local totalSourceTypes = { 0, 0, 0, 0, 0, 0, 0 }
        local knownSourceTypes = { 0, 0, 0, 0, 0, 0, 0 }
        local totalUnknownType = 0
        local knownUnknownType = 0
        for _, source in pairs(sources) do
            if source.sourceType ~= 0 and source.sourceType ~= nil then
                totalSourceTypes[source.sourceType] = totalSourceTypes[source.sourceType] + 1
                if source.isCollected then
                    knownSourceTypes[source.sourceType] = knownSourceTypes[source.sourceType] + 1
                end
            elseif source.sourceType == 0 and source.isCollected then
                totalUnknownType = totalUnknownType + 1
                knownUnknownType = knownUnknownType + 1
            end
        end
        for sourceType, totalCount in ipairs(totalSourceTypes) do
            if (totalCount > 0) then
                local knownCount = knownSourceTypes[sourceType]
                local knownColor = CanIMogIt.RED_ORANGE
                if knownCount == totalCount then
                    knownColor = CanIMogIt.GRAY
                elseif knownCount > 0 then
                    knownColor = CanIMogIt.BLUE
                end
                output = string.format("%s"..knownColor.."%s ("..knownColor.."%i/%i"..knownColor..")"..CanIMogIt.WHITE..", ",
                    output, _G["TRANSMOG_SOURCE_"..sourceType], knownCount, totalCount)
            end
        end
        if totalUnknownType > 0 then
            output = string.format("%s"..CanIMogIt.GRAY.."Unobtainable ("..CanIMogIt.GRAY.."%i/%i"..CanIMogIt.GRAY..")"..CanIMogIt.WHITE..", ",
                output, knownUnknownType, totalUnknownType)
        end
        output = string.sub(output, 1, -3)
    end
    return output
end


function CanIMogIt:GetSourceLocationText(itemLink)
    -- Returns string of the all the types of sources which can provide an item with this appearance.

    cached_value = CanIMogIt.cache:GetItemSourcesValue(itemLink)
    if cached_value then
        return cached_value
    end

    local output = CanIMogIt:CalculateSourceLocationText(itemLink)

    CanIMogIt.cache:SetItemSourcesValue(itemLink, output)

    return output
end


function CanIMogIt:GetPlayerArmorTypeName()
    local playerArmorTypeID = classArmorTypeMap[select(2, UnitClass("player"))]
    return select(1, C_Item.GetItemSubClassInfo(4, playerArmorTypeID))
end


function CanIMogIt:GetItemID(itemLink)
    return tonumber(itemLink:match("item:(%d+)"))
end


function CanIMogIt:GetItemLinkFromSourceID(sourceID)
    return select(6, C_TransmogCollection.GetAppearanceSourceInfo(sourceID))
end


function CanIMogIt:GetItemExpansion(itemID)
    return select(15, C_Item.GetItemInfo(itemID))
end


function CanIMogIt:GetItemClassName(itemLink)
    return select(2, C_Item.GetItemClassInfo(C_Item.GetItemInfoInstant(itemLink)))
end


function CanIMogIt:GetItemSubClassName(itemLink)
    return select(3, C_Item.GetItemInfoInstant(itemLink))
end


function CanIMogIt:GetItemSlotName(itemLink)
    return select(4, C_Item.GetItemInfoInstant(itemLink))
end


function CanIMogIt:IsItemBattlepet(itemLink)
    return string.match(itemLink, ".*(battlepet):.*") == "battlepet"
end


function CanIMogIt:IsItemKeystone(itemLink)
    return string.match(itemLink, ".*(keystone):.*") == "keystone"
end


function CanIMogIt:IsReadyForCalculations(itemLink)
    -- Returns true of the item's GetItemInfo is ready, or if it's a keystone,
    -- or if it's a battlepet.
    if C_Item.GetItemInfo(itemLink)
        or CanIMogIt:IsItemKeystone(itemLink)
        or CanIMogIt:IsItemBattlepet(itemLink) then
        return true
    end
    return false
end


function CanIMogIt:IsItemArmor(itemLink)
    local itemClass = CanIMogIt:GetItemClassName(itemLink)
    if itemClass == nil then return end
    return C_Item.GetItemClassInfo(4) == itemClass
end


function CanIMogIt:IsArmorSubClassID(subClassID, itemLink)
    local itemSubClass = CanIMogIt:GetItemSubClassName(itemLink)
    if itemSubClass == nil then return end
    return select(1, C_Item.GetItemSubClassInfo(4, subClassID)) == itemSubClass
end


function CanIMogIt:IsArmorSubClassName(subClassName, itemLink)
    local itemSubClass = CanIMogIt:GetItemSubClassName(itemLink)
    if itemSubClass == nil then return end
    return subClassName == itemSubClass
end


function CanIMogIt:IsItemSubClassIdentical(itemLinkA, itemLinkB)
    local subClassA = CanIMogIt:GetItemSubClassName(itemLinkA)
    local subClassB = CanIMogIt:GetItemSubClassName(itemLinkB)
    if subClassA == nil or subClassB == nil then return end
    return subClassA == subClassB
end


function CanIMogIt:IsArmorCosmetic(itemLink)
    return CanIMogIt:IsArmorSubClassID(COSMETIC, itemLink)
end


function CanIMogIt:IsArmorAppropriateForPlayer(itemLink)
    local playerArmorTypeID = CanIMogIt:GetPlayerArmorTypeName()
    local slotName = CanIMogIt:GetItemSlotName(itemLink)
    if slotName == nil then return end
    local isArmorCosmetic = CanIMogIt:IsArmorCosmetic(itemLink)
    if isArmorCosmetic == nil then return end
    if armorTypeSlots[slotName] and isArmorCosmetic == false then
        return playerArmorTypeID == CanIMogIt:GetItemSubClassName(itemLink)
    else
        return true
    end
end


function CanIMogIt:IsAppearanceUsable(itemLink)
    if not itemLink then return end
    local sourceID = CanIMogIt:GetSourceID(itemLink)
    if not sourceID then return end
    local appearanceInfo = C_TransmogCollection.GetAppearanceInfoBySource(sourceID)
    if not appearanceInfo then return end
    return appearanceInfo.appearanceIsUsable
end


function CanIMogIt:IsValidAppearanceForCharacter(itemLink)
    -- Can the character transmog this appearance right now?
    if CanIMogIt:IsAppearanceUsable(itemLink) then
        return true
    else
        return false
    end
end


function CanIMogIt:IsItemSoulbound(itemLink, bag, slot, tooltipData)
    return CIMIScanTooltip:IsItemSoulbound(itemLink, bag, slot, tooltipData)
end


function CanIMogIt:IsItemWarbound(itemLink, bag, slot, tooltipData)
    return CIMIScanTooltip:IsItemWarbound(itemLink, bag, slot, tooltipData)
end


function CanIMogIt:GetItemClassRestrictions(itemLink)
    if not itemLink then return end
    return CIMIScanTooltip:GetClassesRequired(itemLink)
end


function CanIMogIt:GetExceptionText(itemLink)
    -- Returns the exception text for this item, if it has one.
    local itemID = CanIMogIt:GetItemID(itemLink)
    local slotName = CanIMogIt:GetItemSlotName(itemLink)
    if slotName == nil then return end
    local slotExceptions = exceptionItems[slotName]
    if slotExceptions then
        return slotExceptions[itemID]
    end
end


function CanIMogIt:IsEquippable(itemLink)
    -- Returns whether the item is equippable or not (exluding bags)
    local slotName = CanIMogIt:GetItemSlotName(itemLink)
    if slotName == nil then return end
    return slotName ~= "" and slotName ~= NONEQUIP and slotName ~= BAG
end


local function RetailOldGetSourceID(itemLink)
    -- Some items don't have the C_TransmogCollection.GetItemInfo data,
    -- so use the old way to find the sourceID (using the DressUpModel).
    local itemID, _, _, slotName = C_Item.GetItemInfoInstant(itemLink)
    local slots = inventorySlotsMap[slotName]

    if slots == nil or slots == false or C_Item.IsDressableItemByID(itemID) == false then return end

    local cached_source = CanIMogIt.cache:GetDressUpModelSource(itemLink)
    if cached_source then
        return cached_source, "DressUpModel:GetItemTransmogInfo cache"
    end
    CanIMogIt.DressUpModel:SetUnit('player')
    CanIMogIt.DressUpModel:Undress()
    for i, slot in pairs(slots) do
        CanIMogIt.DressUpModel:TryOn(itemLink, slot)
        local transmogInfo = CanIMogIt.DressUpModel:GetItemTransmogInfo(slot)
        if transmogInfo and
            transmogInfo.appearanceID ~= nil and
            transmogInfo.appearanceID ~= 0 then
            -- Yes, that's right, we are setting `appearanceID` to the `sourceID`. Blizzard messed
            -- up the DressUpModel functions, so _they_ don't even know what they do anymore.
            -- The `appearanceID` field from `DressUpModel:GetItemTransmogInfo` is actually its
            -- source ID, not it's appearance ID.
            sourceID = transmogInfo.appearanceID
            if not CanIMogIt:IsSourceIDFromItemLink(sourceID, itemLink) then
                -- This likely means that the game hasn't finished loading things
                -- yet, so let's wait until we get good data before caching it.
                return
            end
            CanIMogIt.cache:SetDressUpModelSource(itemLink, sourceID)
            return sourceID, "DressUpModel:GetItemTransmogInfo"
        end
    end
end

local function ClassicOldGetSourceID(itemLink)
end

local OldGetSourceID = CanIMogIt.RetailWrapper(RetailOldGetSourceID, ClassicOldGetSourceID)

function CanIMogIt:GetSourceID(itemLink)
    local sourceID = select(2, C_TransmogCollection.GetItemInfo(itemLink))
    if sourceID then
        return sourceID, "C_TransmogCollection.GetItemInfo"
    end

    return OldGetSourceID(itemLink)
end


function CanIMogIt:IsSourceIDFromItemLink(sourceID, itemLink)
    -- Returns whether the source ID given matches the itemLink.
    local sourceItemLink = select(6, C_TransmogCollection.GetAppearanceSourceInfo(sourceID))
    if not sourceItemLink then return false end
    return CanIMogIt:DoItemIDsMatch(sourceItemLink, itemLink)
end


function CanIMogIt:DoItemIDsMatch(itemLinkA, itemLinkB)
    return CanIMogIt:GetItemID(itemLinkA) == CanIMogIt:GetItemID(itemLinkB)
end


function CanIMogIt:GetAppearanceID(itemLink)
    -- Gets the appearanceID of the given item. Also returns the sourceID, for convenience.
    local sourceID = CanIMogIt:GetSourceID(itemLink)
    return CanIMogIt:GetAppearanceIDFromSourceID(sourceID), sourceID
end


function CanIMogIt:GetAppearanceIDFromSourceID(sourceID)
    -- Gets the appearanceID from the sourceID.
    if sourceID ~= nil then
        local appearanceID = select(2, C_TransmogCollection.GetAppearanceSourceInfo(sourceID))
        return appearanceID
    end
end


function CanIMogIt:PlayerKnowsTransmog(itemLink)
    -- Internal logic for determining if the item is known or not.
    -- Does not use the CIMI database.
    if itemLink == nil then return end
    local appearanceID = CanIMogIt:GetAppearanceID(itemLink)
    if appearanceID == nil then return false end
    local sourceIDs = C_TransmogCollection.GetAllAppearanceSources(appearanceID)
    if sourceIDs then
        for i, sourceID in pairs(sourceIDs) do
            local hasSource = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID)
            if hasSource then
                local sourceItemLink = CanIMogIt:GetItemLinkFromSourceID(sourceID)
                if CanIMogIt:IsArmorCosmetic(sourceItemLink) then
                    return true
                end
                if CanIMogIt:IsItemSubClassIdentical(itemLink, sourceItemLink) then
                    return true
                end
            end
        end
    end
    return false
end


function CanIMogIt:PlayerKnowsTransmogFromItem(itemLink)
    -- Returns whether the transmog is known from this item specifically.
    local slotName = CanIMogIt:GetItemSlotName(itemLink)
    if slotName == TABARD then
        local itemID = CanIMogIt:GetItemID(itemLink)
        return C_TransmogCollection.PlayerHasTransmog(itemID)
    end
    local appearanceID, sourceID = CanIMogIt:GetAppearanceID(itemLink)
    if sourceID == nil then return end

    local hasTransmog;
    hasTransmog = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID)

    return hasTransmog
end


function CanIMogIt:CharacterCanLearnTransmog(itemLink)
    -- Returns whether the player can learn the item or not.
    local sourceID = CanIMogIt:GetSourceID(itemLink)
    if sourceID == nil then return end
    if select(2, C_TransmogCollection.PlayerCanCollectSource(sourceID)) then
        return true
    end
    return false
end


function CanIMogIt:GetReason(itemLink)
    local reason = CIMIScanTooltip:GetRedText(itemLink)
    if reason == "" then
        reason = CanIMogIt:GetItemSubClassName(itemLink)
    end
    return reason
end


function CanIMogIt:IsTransmogable(itemLink)
    -- Returns whether the item is transmoggable or not.

    local is_misc_subclass = CanIMogIt:IsArmorSubClassID(MISC, itemLink)
    if is_misc_subclass and miscArmorExceptions[CanIMogIt:GetItemSlotName(itemLink)] == nil then
        return false
    end

    local itemID, _, _, slotName = C_Item.GetItemInfoInstant(itemLink)

    if CanIMogIt:IsItemBattlepet(itemLink) or CanIMogIt:IsItemKeystone(itemLink) then
        -- Item is never transmoggable if it's a battlepet or keystone.
        -- We can't wear battlepets on our heads yet!
        return false
    end

    -- See if the game considers it transmoggable
    local transmoggable = select(3, C_Transmog.CanTransmogItem(itemID))
    if transmoggable == false then
        return false
    end

    -- See if the item is in a valid transmoggable slot
    if inventorySlotsMap[slotName] == nil then
        return false
    end
    return true
end


function CanIMogIt:TextIsKnown(text)
    -- Returns whether the text is considered to be a KNOWN value or not.
    return knownTexts[text] or false
end


function CanIMogIt:TextIsUnknown(unmodifiedText)
    -- Returns whether the text is considered to be an UNKNOWN value or not.
    return unknownTexts[unmodifiedText] or false
end


function CanIMogIt:PreLogicOptionsContinue(isItemMount, isItemToy, isItemPet,
        isItemEquippable)
    -- Apply the options. Returns false if it should stop the logic.
    local mountCheck = CanIMogItOptions["showMountItems"] and isItemMount
    local toyCheck = CanIMogItOptions["showToyItems"] and isItemToy
    local petCheck = CanIMogItOptions["showPetItems"] and isItemPet

    -- If showEquippableOnly is checked, only show equippable items.
    if CanIMogItOptions["showEquippableOnly"] and not isItemEquippable then
        -- Unless it's a mount, toy, or pet, and their respective option is enabled.
        if not (mountCheck or toyCheck or petCheck) then
            return false
        end
    end

    return true
end


function CanIMogIt:PostLogicOptionsText(text, unmodifiedText)
    -- Apply the options to the text. Returns the relevant text.

    if CanIMogItOptions["showUnknownOnly"] and not CanIMogIt:TextIsUnknown(unmodifiedText) then
        -- We don't want to show the tooltip if it's already known.
        return "", ""
    end

    if CanIMogItOptions["showTransmoggableOnly"]
            and (unmodifiedText == CanIMogIt.NOT_TRANSMOGABLE
            or unmodifiedText == CanIMogIt.NOT_TRANSMOGABLE_BOE
            or unmodifiedText == CanIMogIt.NOT_TRANSMOGABLE_WARBOUND) then
        -- If we don't want to show the tooltip if it's not transmoggable
        return "", ""
    end

    if not CanIMogItOptions["showVerboseText"] then
        text = simpleTextMap[text] or text
    end

    return text, unmodifiedText
end


function CanIMogIt:GetAppearanceData(itemLink)
    -- Returns the appearance data for the item. Uses the cache if available.
    local appData

    appData = CanIMogIt.cache:GetAppearanceDataValue(itemLink)
    if appData then
        return appData
    end

    appData = CanIMogIt.AppearanceData.FromItemLink(itemLink)
    if appData == nil then return end

    CanIMogIt.cache:SetAppearanceDataValue(appData)
    return appData
end


function CanIMogIt:GetItemData(itemLink)
    -- Returns the item data for the item. Uses the cache if available.
    local itemData

    itemData = CanIMogIt.cache:GetItemDataValue(itemLink)
    if itemData then
        return itemData
    end

    itemData = CanIMogIt.ItemData.FromItemLink(itemLink)
    if itemData == nil then return end

    CanIMogIt.cache:SetItemDataValue(itemData)
    return itemData
end


function CanIMogIt:GetBindData(itemLink, bag, slot, tooltipData)
    -- Returns the bind data for the item. Uses the cache if available.
    local bindData

    bindData = CanIMogIt.cache:GetBindDataValue(itemLink, bag, slot)
    if bindData then
        return bindData
    end

    bindData = CanIMogIt.BindData:new(itemLink, bag, slot, tooltipData)
    if bindData == nil then return end

    CanIMogIt.cache:SetBindDataValue(bindData)
    return bindData
end


function CanIMogIt:CalculateKey(itemLink)
    local sourceID = CanIMogIt:GetSourceID(itemLink)
    local itemID = CanIMogIt:GetItemID(itemLink)
    if sourceID then
        return "source:" .. sourceID
    elseif itemID then
        return "item:" .. itemID
    else
        return "itemlink:" .. itemLink
    end
end


function CanIMogIt:CalculateTooltipText(itemLink, bag, slot, tooltipData)
    --[[
        Calculate the tooltip text.
        Use GetTooltipText whenever possible!
    ]]
    local exception_text = CanIMogIt:GetExceptionText(itemLink)
    if exception_text then
        return exception_text, exception_text
    end

    local text, unmodifiedText;

    local itemData = CanIMogIt:GetItemData(itemLink)
    if itemData == nil then return end
    local bindData = CanIMogIt:GetBindData(itemLink, bag, slot, tooltipData)
    if bindData == nil then return end

    if not CanIMogIt:PreLogicOptionsContinue(
            itemData.isItemMount, itemData.isItemToy, itemData.isItemPet,
            itemData.isItemEquippable) then
        return "", ""
    end

    -- Is the item transmogable?
    if itemData.type == CanIMogIt.ItemTypes.Transmogable then
        local appData = CanIMogIt:GetAppearanceData(itemLink)
        if appData == nil then return end
        text, unmodifiedText = appData:CalculateBindStateText(bindData)
    elseif itemData.type == CanIMogIt.ItemTypes.Mount then
        -- This item is a mount, so let's figure out if we know it!
        text, unmodifiedText = CanIMogIt:CalculateMountText(itemLink)
    elseif itemData.type == CanIMogIt.ItemTypes.Toy then
        -- This item is a toy, so let's figure out if we know it!
        text, unmodifiedText = CanIMogIt:CalculateToyText(itemLink)
    elseif itemData.type == CanIMogIt.ItemTypes.Pet then
        -- This item is a pet, so let's figure out if we know it!
        text, unmodifiedText = CanIMogIt:CalculatePetText(itemLink)
    elseif itemData.type == CanIMogIt.ItemTypes.Ensemble then
        -- This item is an ensemble, so let's figure out if we know it!
        text, unmodifiedText = CanIMogIt:CalculateEnsembleText(itemLink)
    else  -- itemData.type == CanIMogIt.ItemTypes.Other
        -- This item is never transmogable.
        if bindData.type == CanIMogIt.BindTypes.Warbound then
            -- Pink Circle-Slash
            text = CanIMogIt.NOT_TRANSMOGABLE_WARBOUND
            unmodifiedText = CanIMogIt.NOT_TRANSMOGABLE_WARBOUND
        elseif bindData.type == CanIMogIt.BindTypes.Soulbound then
            -- Gray Circle-Slash
            text = CanIMogIt.NOT_TRANSMOGABLE
            unmodifiedText = CanIMogIt.NOT_TRANSMOGABLE
        else
            -- Yellow Circle-Slash
            text = CanIMogIt.NOT_TRANSMOGABLE_BOE
            unmodifiedText = CanIMogIt.NOT_TRANSMOGABLE_BOE
        end
    end
    return text, unmodifiedText
end


local foundAnItemFromBags = false


function CanIMogIt:GetTooltipText(itemLink, bag, slot, tooltipData)
    --[[
        Gets the text to display on the tooltip from the itemLink.

        If bag and slot are given, this will use the itemLink from
        bag and slot instead.

        If tooltipData is given, it will be used to get TooltipScanner info,
        instead of calculating it.

        Returns two things:
            the text to display.
            the unmodifiedText that can be used for lookup values.
    ]]
    if bag and slot then
        itemLink = C_Container.GetContainerItemLink(bag, slot)
        if not itemLink then
            if foundAnItemFromBags then
                return "", ""
            else
                -- If we haven't found any items in the bags yet, then
                -- it's likely that the inventory hasn't been loaded yet.
                return nil
            end
        else
            foundAnItemFromBags = true
        end
    end
    if not itemLink then return "", "" end
    if not CanIMogIt:IsReadyForCalculations(itemLink) then
        return
    end

    local text = ""
    local unmodifiedText = ""

    text, unmodifiedText = CanIMogIt:CalculateTooltipText(itemLink, bag, slot, tooltipData)

    text = CanIMogIt:PostLogicOptionsText(text, unmodifiedText)

    return text, unmodifiedText
end


function CanIMogIt:GetIconText(itemLink, bag, slot)
        --Gets the icon as text for this itemLink/bag+slot. Does not include the other text
        --that is also caluculated.
    local text, unmodifiedText = CanIMogIt:GetTooltipText(itemLink, bag, slot)
    local icon
    if text ~= "" and text ~= nil then
        icon = CanIMogIt.tooltipIcons[unmodifiedText]
    else
        icon = ""
    end
    return icon
end

-----------------------------
-- Adding to tooltip       --
-----------------------------

local function addDoubleLine(tooltip, left_text, right_text)
    tooltip:AddDoubleLine(left_text, right_text)
    tooltip:Show()
end


local function addLine(tooltip, text)
    tooltip:AddLine(text, nil, nil, nil, true)
    tooltip:Show()
end


-----------------------------
-- Tooltip hooks           --
-----------------------------

local itemLinks = {}

local function addToTooltip(tooltip, itemLink, tooltipData)
    -- Does the calculations for determining what text to
    -- display on the tooltip.
    if tooltip.CIMI_tooltipWritten then return end
    if not itemLink then return end
    if not CanIMogIt:IsReadyForCalculations(itemLink) then
        return
    end

    -- If it's a battlepet, then don't add any lines. Battle Pet uses a
    -- different tooltip frame than normal.
    local isBattlepet = string.match(itemLink, ".*(battlepet):.*") == "battlepet"
    if isBattlepet then
        tooltip.CIMI_tooltipWritten = true
        return
    end

    local text;
    text = CanIMogIt:GetTooltipText(itemLink, nil, nil, tooltipData)
    if text and text ~= "" then
        addDoubleLine(tooltip, " ", text)
        tooltip.CIMI_tooltipWritten = true
    end

    if CanIMogItOptions["showSetInfo"] then
        local setFirstLineText, setSecondLineText = CanIMogIt:GetSetsText(itemLink)
        if setFirstLineText and setFirstLineText ~= "" then
            addDoubleLine(tooltip, " ", setFirstLineText)
            tooltip.CIMI_tooltipWritten = true
        end
        if setSecondLineText and setSecondLineText ~= "" then
            addDoubleLine(tooltip, " ", setSecondLineText)
            tooltip.CIMI_tooltipWritten = true
        end
    end

    if CanIMogItOptions["showSourceLocationTooltip"] then
        local sourceTypesText = CanIMogIt:GetSourceLocationText(itemLink)
        if sourceTypesText and sourceTypesText ~= "" then
            addDoubleLine(tooltip, " ", sourceTypesText)
            tooltip.CIMI_tooltipWritten = true
        end
    end
end


local function TooltipCleared(tooltip)
    -- Clears the tooltipWritten flag once the tooltip is done rendering.
    tooltip.CIMI_tooltipWritten = false
end


GameTooltip:HookScript("OnTooltipCleared", TooltipCleared)
ItemRefTooltip:HookScript("OnTooltipCleared", TooltipCleared)
ItemRefShoppingTooltip1:HookScript("OnTooltipCleared", TooltipCleared)
ItemRefShoppingTooltip2:HookScript("OnTooltipCleared", TooltipCleared)
ShoppingTooltip1:HookScript("OnTooltipCleared", TooltipCleared)
ShoppingTooltip2:HookScript("OnTooltipCleared", TooltipCleared)

if CanIMogIt.isRetail then
    GameTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipCleared", TooltipCleared)
end


local function CanIMogIt_AttachItemTooltip(tooltip, tooltipData)
    -- Hook for normal tooltips.
    if tooltip.GetItem == nil then return end
    local link = select(2, tooltip:GetItem())
    if link then
        addToTooltip(tooltip, link, tooltipData)
    end
end


TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, CanIMogIt_AttachItemTooltip)


local L = CanIMogIt.L


local default = {
    global = {
        setItems = {}
    }
}


function CanIMogIt:OnInitialize()
    self.db = default
end


function CanIMogIt:SetsDBAddSetItem(set, sourceID)
    if CanIMogIt.db.global.setItems == nil then
        CanIMogIt.db.global.setItems = {}
    end

    CanIMogIt.db.global.setItems[sourceID] = set.setID
end

function CanIMogIt:SetsDBGetSetFromSourceID(sourceID)
    if CanIMogIt.db.global.setItems == nil then return end

    return CanIMogIt.db.global.setItems[sourceID]
end


local function GetAppearancesEvent(event, ...)
    if event == "PLAYER_LOGIN" then
        CanIMogIt:GetSets()
    end
end
CanIMogIt.frame:AddSmartEvent("GetAppearancesEvent", GetAppearancesEvent, {"PLAYER_LOGIN"})




CIMIScanTooltip = {}

-- This only works for Retail.

local function IsColorValRed(colorVal)
    return colorVal.r == 1 and colorVal.g < 0.126 and colorVal.b < 0.126
end

local rootStringMemoized = {}
local function getBeforeAfter(rootString)
    if not rootStringMemoized[rootString] then
        local s, e = string.find(rootString, '%%s')
        local before = string.sub(rootString, 1, s-1)
        local after = string.sub(rootString, e+1, -1)
        rootStringMemoized[rootString] = {before, after}
    end
    return unpack(rootStringMemoized[rootString])
end

local function partOf(input, rootString)
    -- Pulls the rootString out of input, leaving the rest of the string.
    -- rootString is a constant with %s, such as "Required %s" or "Hello %s!"
    -- We must assume that no part (before or after) of rootString is in the sub string...
    local before, after = getBeforeAfter(rootString)
    local cleanBefore, count = input:gsub(before, "")
    if before and count == 0 then return false end
    local cleanAfter, count = cleanBefore:gsub(after, "")
    if after and count == 0 then return false end
    return cleanAfter
end

function CIMIScanTooltip:GetRedText(itemLink)
    -- Returns all of the red text as space separated string.
    local redTexts = {}
    local tooltipData = C_TooltipInfo.GetItemByID(CanIMogIt:GetItemID(itemLink))
    for i, line in pairs(tooltipData.lines) do
        local leftColorRed, rightColorRed;
        if line.leftColor then
            leftColorRed = IsColorValRed(line.leftColor)
        end
        if line.rightColor then
            rightColorRed = IsColorValRed(line.rightColor)
        end

        if leftColorRed then
            table.insert(redTexts, line.leftText)
        end
        if rightColorRed then
            table.insert(redTexts, line.rightText)
        end
    end
    return string.sub(table.concat(redTexts, " "), 1, 80)
end

local function GetClassesText(text)
    -- Returns the text of classes required by this item, or nil if None
    if text then
        return partOf(text, ITEM_CLASSES_ALLOWED)
    end
end

function CIMIScanTooltip:GetClassesRequired(itemLink)
    -- Returns a table of classes required for the item, if any, or nil if none.
    local tooltipData = C_TooltipInfo.GetHyperlink(itemLink)
    for i, line in pairs(tooltipData.lines) do
        local req_classes = GetClassesText(line.leftText)
        if req_classes then
            return CanIMogIt.Utils.strsplit(",%s*", req_classes)
        end
    end
end


function CIMIScanTooltip:IsItemSoulbound(itemLink, bag, slot, tooltipData)
    -- Returns whether the item is soulbound or not.
    if bag and slot then
        return C_Container.GetContainerItemInfo(bag, slot).isBound
    end

    if tooltipData and tooltipData.lines then
        for i, line in pairs(tooltipData.lines) do
            if line.leftText == ITEM_SOULBOUND then
                return true
            end
            if line.rightText == ITEM_SOULBOUND then
                return true
            end
        end
    end

    return select(14, C_Item.GetItemInfo(itemLink)) == 1
end

local accountBoundTexts = {
    ITEM_ACCOUNTBOUND,
    ITEM_ACCOUNTBOUND_UNTIL_EQUIP,
    ITEM_BIND_TO_ACCOUNT,
    ITEM_BIND_TO_ACCOUNT_UNTIL_EQUIP,
}

function CIMIScanTooltip:IsItemWarbound(itemLink, bag, slot, tooltipData)
    -- Returns whether the item is warbound or not.
    if not tooltipData then
        if bag and slot then
            tooltipData = C_TooltipInfo.GetBagItem(bag, slot)
        else
            tooltipData = C_TooltipInfo.GetHyperlink(itemLink)
        end
    end
    if tooltipData and tooltipData.lines then
        for i, line in pairs(tooltipData.lines) do
            for _, accountBoundText in pairs(accountBoundTexts) do
                if line.leftText == accountBoundText then
                    return true
                end
                if line.rightText == accountBoundText then
                    return true
                end
            end
        end
    end
    return false
end


function CanIMogIt:IsItemMount(itemLink)
    local itemID = CanIMogIt:GetItemID(itemLink)
    if itemID == nil then return false end
    if C_MountJournal.GetMountFromItem(itemID) then
        return true
    end
    return false
end


function CanIMogIt:PlayerKnowsMount(itemLink)
    local itemID = CanIMogIt:GetItemID(itemLink)
    if itemID == nil then return false end
    local mountID = C_MountJournal.GetMountFromItem(itemID)
    local playerKnowsMount = select(11, C_MountJournal.GetMountInfoByID(mountID))
    return playerKnowsMount
end


function CanIMogIt:CalculateMountText(itemLink)
    -- Calculates if the mount is known or not.
    if not CanIMogItOptions["showMountItems"] then
        return CanIMogIt.NOT_TRANSMOGABLE, CanIMogIt.NOT_TRANSMOGABLE
    end

    local playerKnowsMount = CanIMogIt:PlayerKnowsMount(itemLink)

    if playerKnowsMount then
        return CanIMogIt.KNOWN, CanIMogIt.KNOWN
    else
        return CanIMogIt.UNKNOWN, CanIMogIt.UNKNOWN
    end
end


local function OnMountAdded(event)
    if event ~= "NEW_MOUNT_ADDED" then return end
    CanIMogIt:ResetCache()
end
CanIMogIt.frame:AddSmartEvent("OnMountAdded", OnMountAdded, {"NEW_MOUNT_ADDED"})


function CanIMogIt:IsItemToy(itemLink)
    local itemID = CanIMogIt:GetItemID(itemLink)
    if itemID == nil then return false end
    if C_ToyBox.GetToyInfo(itemID) then
        return true
    end
    return false
end

function CanIMogIt:PlayerKnowsToy(itemLink)
    local itemID = CanIMogIt:GetItemID(itemLink)
    if itemID == nil then return false end
    return PlayerHasToy(itemID)
end


function CanIMogIt:CalculateToyText(itemLink)
    -- Calculates if the toy is known or not.
    if not CanIMogItOptions["showToyItems"] then
        return CanIMogIt.NOT_TRANSMOGABLE, CanIMogIt.NOT_TRANSMOGABLE
    end

    local playerKnowsToy = CanIMogIt:PlayerKnowsToy(itemLink)

    if playerKnowsToy then
        return CanIMogIt.KNOWN, CanIMogIt.KNOWN
    else
        return CanIMogIt.UNKNOWN, CanIMogIt.UNKNOWN
    end
end


local function OnLearnedToy(event)
    if event ~= "NEW_TOY_ADDED" then return end
    CanIMogIt:ResetCache()
end
CanIMogIt.frame:AddSmartEvent("OnLearnedToy", OnLearnedToy, {"NEW_TOY_ADDED"})


function CanIMogIt:IsItemPet(itemLink)
    local itemID = CanIMogIt:GetItemID(itemLink)
    if itemID == nil then
        -- Check to see if it's a pet cage.
        if string.find(itemLink, "battlepet:") then
            return true
        end
        return false
    end
    if C_PetJournal.GetPetInfoByItemID(itemID) then
        return true
    end
    return false
end
CanIMogIt.IsItemPet = CanIMogIt.RetailWrapper(CanIMogIt.IsItemPet, false)

function CanIMogIt:PlayerKnowsPet(itemLink)
    local itemID = CanIMogIt:GetItemID(itemLink)
    local speciesID
    if itemID ~= nil then
        speciesID = select(13, C_PetJournal.GetPetInfoByItemID(itemID))
    else
        _, _, speciesID = string.find(itemLink, "battlepet:(%d+)")
        if speciesID ~= nil then
            speciesID = tonumber(speciesID)
        end
    end
    if speciesID == nil then return false end
    return C_PetJournal.GetNumCollectedInfo(speciesID) > 0
end

function CanIMogIt:CalculatePetText(itemLink)
    -- Calculates if the pet is known or not.
    if not CanIMogItOptions["showPetItems"] then
        return CanIMogIt.NOT_TRANSMOGABLE, CanIMogIt.NOT_TRANSMOGABLE
    end

    local playerKnowsPet = CanIMogIt:PlayerKnowsPet(itemLink)

    if playerKnowsPet then
        return CanIMogIt.KNOWN, CanIMogIt.KNOWN
    else
        return CanIMogIt.UNKNOWN, CanIMogIt.UNKNOWN
    end
end

local function OnPetUpdate(event)
    if event ~= "PET_JOURNAL_LIST_UPDATE" then return end
    CanIMogIt:ResetCache()
end
CanIMogIt.frame:AddSmartEvent("OnPetUpdate", OnPetUpdate, {"PET_JOURNAL_LIST_UPDATE"})


function CanIMogIt:IsItemEnsemble(itemLink)
    local itemID = CanIMogIt:GetItemID(itemLink)
    if itemID == nil then return false end
    if C_Item.GetItemLearnTransmogSet(itemID) then
        return true
    end
    return false
end
CanIMogIt.IsItemEnsemble = CanIMogIt.RetailWrapper(CanIMogIt.IsItemEnsemble, false)


function CanIMogIt:EnsembleItemsKnown(itemLink)
    -- Returns the number of appearances known, and the number of appearances total in the ensemble.
    local itemID = CanIMogIt:GetItemID(itemLink)
    if itemID == nil then return 0, 0 end
    local setID = C_Item.GetItemLearnTransmogSet(itemID)
    if setID == nil then return 0, 0 end
    local setSources = C_Transmog.GetAllSetAppearancesByID(setID)
    local knownAppearancesCount = 0
    local totalAppearancesCount = 0
    local knownSourcesCount = 0
    -- knownAppearances keys are the "appearanceIDs|armorSubClass" and the values are true if it's known.
    local knownAppearances = {}
    -- totalAppearances keys are the "appearanceIDs|armorSubClass" and the values are always true.
    local totalAppearances = {}
    if setSources == nil then return 0, 0 end
    for _, source in ipairs(setSources) do
        -- We have to use our custom function for this, since the WoW one doesn't include
        -- checking if items are from the correct armor type.
        local sourceID = source.itemModifiedAppearanceID
        if C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID) then
            knownSourcesCount = knownSourcesCount + 1
        end
        local appearanceID = CanIMogIt:GetAppearanceIDFromSourceID(sourceID)
        local sourceItemLink = CanIMogIt:GetItemLinkFromSourceID(sourceID)
        local playerKnowsTransmog = CanIMogIt:PlayerKnowsTransmogFromItem(sourceItemLink)
            or CanIMogIt:PlayerKnowsTransmog(sourceItemLink)
        local itemSubClass = "unknown"
        -- If it's armor, get the subclass. If not, it should be fine as unknown.
        if CanIMogIt:IsItemArmor(itemLink) then
            itemSubClass = CanIMogIt:GetItemSubClassName(sourceItemLink) or "unknown"
        end
        local key = appearanceID .. "|" .. itemSubClass
        if playerKnowsTransmog and not knownAppearances[key] then
            knownAppearances[key] = true
            knownAppearancesCount = knownAppearancesCount + 1
        end
        if not totalAppearances[key] then
            totalAppearances[key] = true
            totalAppearancesCount = totalAppearancesCount + 1
        end
    end
    return knownAppearancesCount, totalAppearancesCount, knownSourcesCount, #setSources
end


function CanIMogIt:CalculateEnsembleText(itemLink)
    -- Displays the standard KNOWN or UNKNOWN, then include the ratio of known to total.
    local knownAppearances, totalAppearances, knownSources, totalSources = CanIMogIt:EnsembleItemsKnown(itemLink)
    local ratio = knownAppearances .. "/" .. totalAppearances
    if CanIMogItOptions["showVerboseText"] then
        ratio = ratio .. " (".. L["Sources"] .. ": " .. knownSources .. "/" .. totalSources .. ")"
        if totalAppearances == 0 then
            return CanIMogIt.NOT_TRANSMOGABLE .. " " .. ratio, CanIMogIt.NOT_TRANSMOGABLE
        elseif knownSources == totalSources then
            return CanIMogIt.KNOWN .. " " .. ratio, CanIMogIt.KNOWN
        elseif knownAppearances == totalAppearances and knownSources > 0 then
            return CanIMogIt.KNOWN_FROM_ANOTHER_ITEM .. " " .. ratio, CanIMogIt.KNOWN_FROM_ANOTHER_ITEM
        elseif knownAppearances > 0 then
            return CanIMogIt.PARTIAL .. " " .. ratio, CanIMogIt.PARTIAL
        elseif knownSources == 0 then
            return CanIMogIt.UNKNOWN .. " " .. ratio, CanIMogIt.UNKNOWN
        end
    else
        if totalAppearances == 0 then
            return CanIMogIt.NOT_TRANSMOGABLE, CanIMogIt.NOT_TRANSMOGABLE
        elseif knownAppearances == totalAppearances then
            return CanIMogIt.KNOWN .. " " .. ratio, CanIMogIt.KNOWN
        elseif knownAppearances > 0 then
            return CanIMogIt.PARTIAL .. " " .. ratio, CanIMogIt.PARTIAL
        elseif knownAppearances == 0 then
            return CanIMogIt.UNKNOWN .. " " .. ratio, CanIMogIt.UNKNOWN
        end
    end
end

-- Adds overlays to items in the addon Auctionator: https://www.curseforge.com/wow/addons/auctionator


if C_AddOns.IsAddOnLoaded("Auctionator") then


    ----------------------------
    -- UpdateIcon functions   --
    ----------------------------

    CanIMogIt.ICON_LOCATIONS["AUCTIONATOR"] = {"LEFT", 0, 0}


    local function GetAuctionatorItemLink(auctionatorButton)
        -- rowData format: {
        --     ["battlePetSpeciesID"] = 0,
        --     ["itemID"] = 2140,
        --     ["itemLevel"] = 11,
        --     ["itemSuffix"] = 0,
        --     ["appearanceLink"] = 12345  -- Only sometimes
        --}
        local rowData = auctionatorButton.rowData
        if rowData then
            if rowData.appearanceLink then
                -- Items that have multiple appearances under the same itemID also include an appearance ID.
                -- Use that to get the appearance instead.
                local sourceID = string.match(rowData.appearanceLink, ".*transmogappearance:?(%d*)|.*")
                if sourceID then
                    return CanIMogIt:GetItemLinkFromSourceID(sourceID)
                else
                    -- This results in a bug from Blizzard, where the item is flagged as having an
                    -- appearanceLink (such as upgradable item appearances), but one is not provided.
                    -- Seem to be limited to crafted items. Making the same query twice causes the
                    -- data to be filled correctly.
                    return
                end
            else
                -- Most items have a single appearance, and will use this code.
                local itemKey = rowData.itemKey
                return "|Hitem:".. itemKey.itemID .."|h"
            end
        else
            -- No row data
            return
        end
    end


    function AuctionatorFrame_CIMIUpdateIcon(self)
        if not self then return end
        if not CIMI_CheckOverlayIconEnabled() then
            self.CIMIIconTexture:SetShown(false)
            self:SetScript("OnUpdate", nil)
            return
        end

        local button = self:GetParent()
        local itemLink = GetAuctionatorItemLink(button)

        if itemLink == nil then
            -- Mark the items we can't figure out as a question mark (rather than empty).
            CIMI_SetIcon(self, AuctionatorFrame_CIMIUpdateIcon, CanIMogIt.CANNOT_DETERMINE, CanIMogIt.CANNOT_DETERMINE)
        else
            CIMI_SetIcon(self, AuctionatorFrame_CIMIUpdateIcon, CanIMogIt:GetTooltipText(itemLink))
        end
    end

    ------------------------
    -- Function hooks     --
    ------------------------

    function AuctionatorFrame_CIMIOnValueChanged(_, elapsed)
        -- Some other addons *coughTSMcough* prevent this frame from loading.
        if _G["AuctionatorShoppingFrame"] == nil then return end
        if not CanIMogIt.FrameShouldUpdate("AuctionatorShopping", elapsed or 1) then return end
        local buttons = _G["AuctionatorShoppingFrame"].ResultsListing.ScrollArea.ScrollBox:GetFrames()
        if buttons == nil then
            return
        end
        for i, button in pairs(buttons) do
            if button then
                button.CIMI_index = i
                CIMI_AddToFrame(button, AuctionatorFrame_CIMIUpdateIcon, "AuctionatorShoppingList"..i, "AUCTIONATOR")
                AuctionatorFrame_CIMIUpdateIcon(button.CanIMogItOverlay)
            end
        end
    end


    ----------------------------
    -- Begin adding to frames --
    ----------------------------

    local function HookOverlay()
        -- Some other addons *coughTSMcough* prevent this frame from loading.
        if _G["AuctionatorShoppingFrame"] == nil then return end

        local scrollArea = _G["AuctionatorShoppingFrame"].ResultsListing.ScrollArea
        scrollArea:HookScript("OnUpdate", AuctionatorFrame_CIMIOnValueChanged)

        -- This GetChildren returns an _unpacked_ value for some reason, so we have to pack it in a table.
        local headers = {AuctionatorShoppingFrame.ResultsListing.HeaderContainer:GetChildren()}
        for i, header in ipairs(headers) do
            header:HookScript("OnClick", AuctionatorFrame_CIMIOnValueChanged)
        end
    end

    local function HookOverlayAuctionator(event)
        if event ~= "AUCTION_HOUSE_SHOW" then return end
        C_Timer.After(.1, function () HookOverlay() end)
    end

    CanIMogIt.frame:AddSmartEvent("HookOverlayAuctionator", HookOverlayAuctionator, {"AUCTION_HOUSE_SHOW"})

    ------------------------
    -- Event functions    --
    ------------------------

    local function AuctionatorUpdateEvents(event, ...)
        if event ~= "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED" then return end
        C_Timer.After(.1, AuctionatorFrame_CIMIOnValueChanged)
    end

    CanIMogIt.frame:AddSmartEvent("AuctionatorUpdateEvents", AuctionatorUpdateEvents, {"AUCTION_HOUSE_BROWSE_RESULTS_UPDATED"})

end
