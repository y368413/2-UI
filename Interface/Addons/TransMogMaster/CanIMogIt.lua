 --  9.1.5v1.32
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
CanIMogIt.KNOWN_ICON = "|TInterface\\Addons\\TransMogMaster\\Icons\\KNOWN:0|t "
CanIMogIt.KNOWN_ICON_OVERLAY = "Interface\\Addons\\TransMogMaster\\Icons\\KNOWN_OVERLAY"
CanIMogIt.KNOWN_BOE_ICON = "|TInterface\\Addons\\TransMogMaster\\Icons\\KNOWN_BOE:0|t "
CanIMogIt.KNOWN_BOE_ICON_OVERLAY = "Interface\\Addons\\TransMogMaster\\Icons\\KNOWN_BOE_OVERLAY"
CanIMogIt.KNOWN_BUT_ICON = "|TInterface\\Addons\\TransMogMaster\\Icons\\KNOWN_circle:0|t "
CanIMogIt.KNOWN_BUT_ICON_OVERLAY = "Interface\\Addons\\TransMogMaster\\Icons\\KNOWN_circle_OVERLAY"
CanIMogIt.KNOWN_BUT_BOE_ICON = "|TInterface\\Addons\\TransMogMaster\\Icons\\KNOWN_BOE_circle:0|t "
CanIMogIt.KNOWN_BUT_BOE_ICON_OVERLAY = "Interface\\Addons\\TransMogMaster\\Icons\\KNOWN_BOE_circle_OVERLAY"
CanIMogIt.UNKNOWABLE_SOULBOUND_ICON = "|TInterface\\Addons\\TransMogMaster\\Icons\\UNKNOWABLE_SOULBOUND:0|t "
CanIMogIt.UNKNOWABLE_SOULBOUND_ICON_OVERLAY = "Interface\\Addons\\TransMogMaster\\Icons\\UNKNOWABLE_SOULBOUND_OVERLAY"
CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON = "|TInterface\\Addons\\TransMogMaster\\Icons\\UNKNOWABLE_BY_CHARACTER:0|t "
CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON_OVERLAY = "Interface\\Addons\\TransMogMaster\\Icons\\UNKNOWABLE_BY_CHARACTER_OVERLAY"
CanIMogIt.UNKNOWN_ICON = "|TInterface\\Addons\\TransMogMaster\\Icons\\UNKNOWN:0|t "
CanIMogIt.UNKNOWN_ICON_OVERLAY = "Interface\\Addons\\TransMogMaster\\Icons\\UNKNOWN_OVERLAY"
CanIMogIt.NOT_TRANSMOGABLE_ICON = "|TInterface\\Addons\\TransMogMaster\\Icons\\NOT_TRANSMOGABLE:0|t "
CanIMogIt.NOT_TRANSMOGABLE_ICON_OVERLAY = "Interface\\Addons\\TransMogMaster\\Icons\\NOT_TRANSMOGABLE_OVERLAY"
CanIMogIt.NOT_TRANSMOGABLE_BOE_ICON = "|TInterface\\Addons\\TransMogMaster\\Icons\\NOT_TRANSMOGABLE_BOE:0|t "
CanIMogIt.NOT_TRANSMOGABLE_BOE_ICON_OVERLAY = "Interface\\Addons\\TransMogMaster\\Icons\\NOT_TRANSMOGABLE_BOE_OVERLAY"
CanIMogIt.QUESTIONABLE_ICON = "|TInterface\\Addons\\TransMogMaster\\Icons\\QUESTIONABLE:0|t "
CanIMogIt.QUESTIONABLE_ICON_OVERLAY = "Interface\\Addons\\TransMogMaster\\Icons\\QUESTIONABLE_OVERLAY"

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
local KNOWN_BUT_TOO_LOW_LEVEL =                         L["Learned but cannot transmog yet."]
local KNOWN_BUT_TOO_LOW_LEVEL_BOE =                     L["Learned but cannot transmog yet."]
local KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL =       L["Learned from another item but cannot transmog yet."]
local KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL_BOE =   L["Learned from another item but cannot transmog yet."]
local KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER =           L["Learned for a different class and item."]
local KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE =       L["Learned for a different class and item."]
local UNKNOWABLE_SOULBOUND =                            L["Cannot learn: Soulbound"] .. " " -- subClass
local UNKNOWABLE_BY_CHARACTER =                         L["Cannot learn:"] .. " " -- subClass
local CAN_BE_LEARNED_BY =                               L["Can be learned by:"] -- list of classes
local UNKNOWN =                                         L["Not learned."]
local NOT_TRANSMOGABLE =                                L["Cannot be learned."]
local NOT_TRANSMOGABLE_BOE =                            L["Cannot be learned."]
local CANNOT_DETERMINE =                                L["Cannot determine status on other characters."]


-- Combine icons, color, and text into full tooltip
CanIMogIt.KNOWN =                                           CanIMogIt.KNOWN_ICON .. CanIMogIt.BLUE .. KNOWN
CanIMogIt.KNOWN_BOE =                                       CanIMogIt.KNOWN_BOE_ICON .. CanIMogIt.YELLOW .. KNOWN
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM =                         CanIMogIt.KNOWN_BUT_ICON .. CanIMogIt.BLUE .. KNOWN_FROM_ANOTHER_ITEM
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE =                     CanIMogIt.KNOWN_BUT_BOE_ICON .. CanIMogIt.YELLOW .. KNOWN_FROM_ANOTHER_ITEM
CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER =                      CanIMogIt.KNOWN_ICON .. CanIMogIt.BLUE .. KNOWN_BY_ANOTHER_CHARACTER
CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE =                  CanIMogIt.KNOWN_BOE_ICON .. CanIMogIt.YELLOW .. KNOWN_BY_ANOTHER_CHARACTER
CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL =                         CanIMogIt.KNOWN_ICON .. CanIMogIt.BLUE .. KNOWN_BUT_TOO_LOW_LEVEL
CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL_BOE =                     CanIMogIt.KNOWN_BOE_ICON .. CanIMogIt.YELLOW .. KNOWN_BUT_TOO_LOW_LEVEL
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL =       CanIMogIt.KNOWN_BUT_ICON .. CanIMogIt.BLUE .. KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL_BOE =   CanIMogIt.KNOWN_BUT_BOE_ICON .. CanIMogIt.YELLOW .. KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER =           CanIMogIt.KNOWN_BUT_ICON .. CanIMogIt.BLUE .. KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER
CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE =       CanIMogIt.KNOWN_BUT_BOE_ICON .. CanIMogIt.YELLOW .. KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER
-- CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER =        CanIMogIt.QUESTIONABLE_ICON .. CanIMogIt.YELLOW .. CANNOT_DETERMINE
CanIMogIt.UNKNOWABLE_SOULBOUND =                            CanIMogIt.UNKNOWABLE_SOULBOUND_ICON .. CanIMogIt.BLUE_GREEN .. UNKNOWABLE_SOULBOUND
CanIMogIt.UNKNOWABLE_BY_CHARACTER =                         CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON .. CanIMogIt.YELLOW .. UNKNOWABLE_BY_CHARACTER
CanIMogIt.UNKNOWN =                                         CanIMogIt.UNKNOWN_ICON .. CanIMogIt.RED_ORANGE .. UNKNOWN
CanIMogIt.NOT_TRANSMOGABLE =                                CanIMogIt.NOT_TRANSMOGABLE_ICON .. CanIMogIt.GRAY .. NOT_TRANSMOGABLE
CanIMogIt.NOT_TRANSMOGABLE_BOE =                            CanIMogIt.NOT_TRANSMOGABLE_BOE_ICON .. CanIMogIt.YELLOW .. NOT_TRANSMOGABLE
CanIMogIt.CANNOT_DETERMINE =                                CanIMogIt.QUESTIONABLE_ICON


CanIMogIt.tooltipIcons = {
    [CanIMogIt.KNOWN] = CanIMogIt.KNOWN_ICON,
    [CanIMogIt.KNOWN_BOE] = CanIMogIt.KNOWN_BOE_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM] = CanIMogIt.KNOWN_BUT_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE] = CanIMogIt.KNOWN_BUT_BOE_ICON,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER] = CanIMogIt.KNOWN_ICON,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE] = CanIMogIt.KNOWN_BOE_ICON,
    [CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL] = CanIMogIt.KNOWN_ICON,
    [CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL_BOE] = CanIMogIt.KNOWN_BOE_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL] = CanIMogIt.KNOWN_BUT_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL_BOE] = CanIMogIt.KNOWN_BUT_BOE_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = CanIMogIt.KNOWN_BUT_ICON,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE] = CanIMogIt.KNOWN_BUT_BOE_ICON,
    -- [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = CanIMogIt.QUESTIONABLE_ICON,
    [CanIMogIt.UNKNOWABLE_SOULBOUND] = CanIMogIt.UNKNOWABLE_SOULBOUND_ICON,
    [CanIMogIt.UNKNOWABLE_BY_CHARACTER] = CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON,
    -- [CanIMogIt.CAN_BE_LEARNED_BY] = CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON,
    [CanIMogIt.UNKNOWN] = CanIMogIt.UNKNOWN_ICON,
    [CanIMogIt.NOT_TRANSMOGABLE] = CanIMogIt.NOT_TRANSMOGABLE_ICON,
    [CanIMogIt.NOT_TRANSMOGABLE_BOE] = CanIMogIt.NOT_TRANSMOGABLE_BOE_ICON,
    [CanIMogIt.CANNOT_DETERMINE] = CanIMogIt.QUESTIONABLE_ICON,
}


-- Used by itemOverlay
CanIMogIt.tooltipOverlayIcons = {
    [CanIMogIt.KNOWN] = CanIMogIt.KNOWN_ICON_OVERLAY,
    [CanIMogIt.KNOWN_BOE] = CanIMogIt.KNOWN_BOE_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM] = CanIMogIt.KNOWN_BUT_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE] = CanIMogIt.KNOWN_BUT_BOE_ICON_OVERLAY,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER] = CanIMogIt.KNOWN_ICON_OVERLAY,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE] = CanIMogIt.KNOWN_BOE_ICON_OVERLAY,
    [CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL] = CanIMogIt.KNOWN_ICON_OVERLAY,
    [CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL_BOE] = CanIMogIt.KNOWN_BOE_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL] = CanIMogIt.KNOWN_BUT_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL_BOE] = CanIMogIt.KNOWN_BUT_BOE_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = CanIMogIt.KNOWN_BUT_ICON_OVERLAY,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE] = CanIMogIt.KNOWN_BUT_BOE_ICON_OVERLAY,
    -- [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER] = CanIMogIt.QUESTIONABLE_ICON_OVERLAY,
    [CanIMogIt.UNKNOWABLE_SOULBOUND] = CanIMogIt.UNKNOWABLE_SOULBOUND_ICON_OVERLAY,
    [CanIMogIt.UNKNOWABLE_BY_CHARACTER] = CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON_OVERLAY,
    -- [CanIMogIt.CAN_BE_LEARNED_BY] = CanIMogIt.UNKNOWABLE_BY_CHARACTER_ICON_OVERLAY,
    [CanIMogIt.UNKNOWN] = CanIMogIt.UNKNOWN_ICON_OVERLAY,
    [CanIMogIt.NOT_TRANSMOGABLE] = CanIMogIt.NOT_TRANSMOGABLE_ICON_OVERLAY,
    [CanIMogIt.NOT_TRANSMOGABLE_BOE] = CanIMogIt.NOT_TRANSMOGABLE_BOE_ICON_OVERLAY,
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
-- Loot Roll = NUM_GROUP_LOOT_FRAMES
CanIMogIt.NUM_MAIL_INBOX_ITEMS = 7
-- Mail Attachments = ATTACHMENTS_MAX_RECEIVE
-- Merchant Items = MERCHANT_ITEMS_PER_PAGE
CanIMogIt.NUM_WARDROBE_COLLECTION_BUTTONS = 12 -- Blizzard functions are locals
-- Trade Skill = no constants

-- Expansions before Shadowlands are all opened at level 10 as of 9.0. Shadowlands is opened at level 48.
CanIMogIt.MIN_TRANSMOG_LEVEL = 10
CanIMogIt.MIN_TRANSMOG_LEVEL_SHADOWLANDS = 48

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
CanIMogIt_OptionsVersion = "20"

CanIMogItOptions_Defaults = {
    ["options"] = {
        ["version"] = CanIMogIt_OptionsVersion,
        ["showEquippableOnly"] = true,
        ["showTransmoggableOnly"] = true,
        ["showUnknownOnly"] = true,
        ["showSetInfo"] = true,
        ["showItemIconOverlay"] = true,
        -- ["showBoEColors"] = true,
        ["showVerboseText"] = false,
        ["showSourceLocationTooltip"] = false,
        ["printDatabaseScan"] = false,
        ["iconLocation"] = "TOPRIGHT",
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
    -- ["showBoEColors"] = {
    --     ["displayName"] = L["Show Bind on Equip Colors"],
    --     ["description"] = L["Changes the color of icons and tooltips when an item is Bind on Equip or Bind on Account."]
    -- },
    ["showVerboseText"] = {
        ["displayName"] = L["Verbose Text"],
        ["description"] = L["Shows a more detailed text for some of the tooltips."]
    },
    ["showSourceLocationTooltip"] = {
        ["displayName"] = L["Show Source Location Tooltip"] .. " " .. CanIMogIt.YELLOW .. L["(Experimental)"],
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
}


CanIMogIt.frame = CreateFrame("Frame", "CanIMogItOptionsFrame", UIParent);
CanIMogIt.frame.name = L["Can I Mog It?"];
InterfaceOptions_AddCategory(CanIMogIt.frame);


local EVENTS = {
    "ADDON_LOADED",
    "TRANSMOG_COLLECTION_UPDATED",
    "PLAYER_LOGIN",
    "AUCTION_HOUSE_SHOW",
    "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED",
    "AUCTION_HOUSE_NEW_RESULTS_RECEIVED",
    "GET_ITEM_INFO_RECEIVED",
    "BLACK_MARKET_OPEN",
    "BLACK_MARKET_ITEM_UPDATE",
    "BLACK_MARKET_CLOSE",
    "CHAT_MSG_LOOT",
    "GUILDBANKFRAME_OPENED",
    "VOID_STORAGE_OPEN",
    "UNIT_INVENTORY_CHANGED",
    "PLAYER_SPECIALIZATION_CHANGED",
    "BAG_UPDATE",
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
    "PLAYERREAGENTBANKSLOTS_CHANGED",
    "LOADING_SCREEN_ENABLED",
    "LOADING_SCREEN_DISABLED",
}

for i, event in pairs(EVENTS) do
    CanIMogIt.frame:RegisterEvent(event);
end


-- Skip the itemOverlayEvents function until the loading screen is disabled.
local lastOverlayEventCheck = 0
local overlayEventCheckThreshold = .01 -- once per frame at 100 fps
local futureOverlayPrepared = false

local function futureOverlay(event)
    -- Updates the overlay in ~THE FUTURE~. If the overlay events had multiple
    -- requests in the same frame, then this gets called.
    futureOverlayPrepared = false
    local currentTime = GetTime()
    if currentTime - lastOverlayEventCheck > overlayEventCheckThreshold then
        lastOverlayEventCheck = currentTime
        CanIMogIt.frame:ItemOverlayEvents(event)
    end
end


CanIMogIt.frame.eventFunctions = {}


function CanIMogIt.frame:AddEventFunction(func)
    -- Adds the func to the list of functions that are called for all events.
    table.insert(CanIMogIt.frame.eventFunctions, func)
end


CanIMogIt.frame:HookScript("OnEvent", function(self, event, ...)
    --[[
        To add functions you want to run with CIMI's "OnEvent", do:

        local function MyOnEventFunc(event, ...)
            Do stuff here
        end
        CanIMogIt.frame:AddEventFunction(MyOnEventFunc)
        ]]

    for i, func in ipairs(CanIMogIt.frame.eventFunctions) do
        func(event, ...)
    end

    -- TODO: Move this to it's own event function.
    -- Prevent the ItemOverlayEvents handler from running more than is needed.
    -- If more than one occur in the same frame, we update the first time, then
    -- prepare a future update in a couple frames.
    local currentTime = GetTime()
    if currentTime - lastOverlayEventCheck > overlayEventCheckThreshold then
        lastOverlayEventCheck = currentTime
        self:ItemOverlayEvents(event, ...)
    else
        -- If we haven't already, plan to update the overlay in the future.
        if not futureOverlayPrepared then
            futureOverlayPrepared = true
            C_Timer.After(.02, function () futureOverlay(event) end)
        end
    end
end)


function CanIMogIt.frame.AddonLoaded(event, addonName)
    if event == "ADDON_LOADED" and addonName == "TransMogMaster" then
        CanIMogIt.frame.Loaded()
    end
end
CanIMogIt.frame:AddEventFunction(CanIMogIt.frame.AddonLoaded)


local changesSavedStack = {}


local function changesSavedText()
    local frame = CreateFrame("Frame", "CanIMogIt_ChangesSaved", CanIMogIt.frame)
    local text = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    text:SetText(CanIMogIt.YELLOW .. L["Changes saved!"])

    text:SetAllPoints()

    frame:SetPoint("BOTTOMRIGHT", -20, 10)
    frame:SetSize(100, 20)
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
    -- CanIMogIt.frame.showBoEColors = newCheckbox(CanIMogIt.frame, "showBoEColors")
    CanIMogIt.frame.showVerboseText = newCheckbox(CanIMogIt.frame, "showVerboseText")
    CanIMogIt.frame.showSourceLocationTooltip = newCheckbox(CanIMogIt.frame, "showSourceLocationTooltip")
    CanIMogIt.frame.printDatabaseScan = newCheckbox(CanIMogIt.frame, "printDatabaseScan")
    CanIMogIt.frame.iconLocation = newRadioGrid(CanIMogIt.frame, "iconLocation")

    -- position the checkboxes
    CanIMogIt.frame.showEquippableOnly:SetPoint("TOPLEFT", 16, -16)
    CanIMogIt.frame.showTransmoggableOnly:SetPoint("TOPLEFT", CanIMogIt.frame.showEquippableOnly, "BOTTOMLEFT")
    CanIMogIt.frame.showUnknownOnly:SetPoint("TOPLEFT", CanIMogIt.frame.showTransmoggableOnly, "BOTTOMLEFT")
    CanIMogIt.frame.showSetInfo:SetPoint("TOPLEFT", CanIMogIt.frame.showUnknownOnly, "BOTTOMLEFT")
    CanIMogIt.frame.showItemIconOverlay:SetPoint("TOPLEFT", CanIMogIt.frame.showSetInfo, "BOTTOMLEFT")
    -- CanIMogIt.frame.showBoEColors:SetPoint("TOPLEFT", CanIMogIt.frame.showItemIconOverlay, "BOTTOMLEFT")
    CanIMogIt.frame.showVerboseText:SetPoint("TOPLEFT", CanIMogIt.frame.showItemIconOverlay, "BOTTOMLEFT")
    CanIMogIt.frame.showSourceLocationTooltip:SetPoint("TOPLEFT", CanIMogIt.frame.showVerboseText, "BOTTOMLEFT")
    CanIMogIt.frame.printDatabaseScan:SetPoint("TOPLEFT", CanIMogIt.frame.showSourceLocationTooltip, "BOTTOMLEFT")
    CanIMogIt.frame.iconLocation:SetPoint("TOPLEFT", CanIMogIt.frame.printDatabaseScan, "BOTTOMLEFT")

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

function CanIMogIt:SlashCommands(input)
    -- Slash command router.
    if input == "" then
        self:OpenOptionsMenu()
    elseif input == 'overlay' then
        CanIMogIt.frame.showItemIconOverlay:Click()
    -- elseif input == 'colors' then
    --     CanIMogIt.frame.showBoEColors:Click()
    elseif input == 'verbose' then
        CanIMogIt.frame.showVerboseText:Click()
    elseif input == 'equiponly' then
        CanIMogIt.frame.showEquippableOnly:Click()
    elseif input == 'transmogonly' then
        CanIMogIt.frame.showTransmoggableOnly:Click()
    elseif input == 'unknownonly' then
        CanIMogIt.frame.showUnknownOnly:Click()
    elseif input == 'count' then
        self:Print(CanIMogIt.Utils.tablelength(CanIMogIt.db.global.appearances))
    elseif input == 'PleaseDeleteMyDB' then
        self:DBReset()
    elseif input == 'refresh' then
        self:ResetCache()
    else
        self:Print("Unknown command!")
    end
end

function CanIMogIt:OpenOptionsMenu()
    -- Run it twice, because the first one only opens
    -- the main interface window.
    InterfaceOptionsFrame_OpenToCategory(CanIMogIt.frame)
    InterfaceOptionsFrame_OpenToCategory(CanIMogIt.frame)
end


CanIMogIt.cache = {}

function CanIMogIt.cache:Clear()
    self.data = {
        ["text"] = {},
        ["source"] = {},
        ["dressup_source"] = {},
        ["sets"] = {},
        ["setsSumRatio"] = {},
    }
end


local function GetSourceIDKey(sourceID)
    return "source:" .. sourceID
end


local function GetItemIDKey(itemID)
    return "item:" .. itemID
end


local function GetItemLinkKey(itemLink)
    return "itemlink:" .. itemLink
end


local function CalculateCacheKey(itemLink)
    local sourceID = CanIMogIt:GetSourceID(itemLink)
    local itemID = CanIMogIt:GetItemID(itemLink)
    local key;
    if sourceID then
        key = GetSourceIDKey(sourceID)
    elseif itemID then
        key = GetItemIDKey(itemID)
    else
        key = GetItemLinkKey(itemLink)
    end
    return key
end


function CanIMogIt.cache:GetItemTextValue(itemLink)
    return self.data["text"][CalculateCacheKey(itemLink)]
end


function CanIMogIt.cache:SetItemTextValue(itemLink, value)
    self.data["text"][CalculateCacheKey(itemLink)] = value
end


function CanIMogIt.cache:RemoveItem(itemLink)
    self.data["text"][CalculateCacheKey(itemLink)] = nil
    self.data["source"][CalculateCacheKey(itemLink)] = nil
    -- Have to remove all of the set data, since other itemLinks may cache
    -- the same set information. Alternatively, we scan through and find
    -- the same set on other items, but they're loaded on mouseover anyway,
    -- so it shouldn't be slow. Also applies to RemoveItemBySourceID.
    self:ClearSetData()
end


function CanIMogIt.cache:RemoveItemBySourceID(sourceID)
    self.data["text"][GetSourceIDKey(sourceID)] = nil
    self.data["source"][GetSourceIDKey(sourceID)] = nil
    self:ClearSetData()
end


function CanIMogIt.cache:GetItemSourcesValue(itemLink)
    return self.data["source"][CalculateCacheKey(itemLink)]
end


function CanIMogIt.cache:SetItemSourcesValue(itemLink, value)
    self.data["source"][CalculateCacheKey(itemLink)] = value
end


function CanIMogIt.cache:GetSetsInfoTextValue(itemLink)
    return self.data["sets"][CalculateCacheKey(itemLink)]
end


function CanIMogIt.cache:SetSetsInfoTextValue(itemLink, value)
    self.data["sets"][CalculateCacheKey(itemLink)] = value
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
local COSMETIC_NAME = select(3, GetItemInfoInstant(130064))


-- Built-in colors
-- TODO: move to constants
local BLIZZARD_RED = "|cffff1919"
local BLIZZARD_GREEN = "|cff19ff19"
local BLIZZARD_DARK_GREEN = "|cff40c040"
local BLIZZARD_YELLOW = "|cffffd100"


-------------------------
-- Text related tables --
-------------------------


-- Maps a text to its simpler version
local simpleTextMap = {
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER] = CanIMogIt.KNOWN,
    [CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE] = CanIMogIt.KNOWN_BOE,
    [CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL] = CanIMogIt.KNOWN,
    [CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL_BOE] = CanIMogIt.KNOWN_BOE,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL] = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL_BOE] = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE,
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
    [CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL] = true,
    [CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL_BOE] = true,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL] = true,
    [CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL_BOE] = true,
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
        [130064] = CanIMogIt.NOT_TRANSMOGABLE, -- Deadeye Monocle
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


-----------------------------
-- CanIMogIt Core methods  --
-----------------------------

-- Variables for managing updating appearances.
local appearanceIndex = 0
local sourceIndex = 0
local getAppearancesDone = false;
local sourceCount = 0
local appearanceCount = 0
local buffer = 0
local sourcesAdded = 0
local sourcesRemoved = 0
local loadingScreen = true


local appearancesTable = {}
local removeAppearancesTable = nil
local appearancesTableGotten = false
local doneAppearances = {}


local function LoadingScreenStarted(event)
    if event ~= "LOADING_SCREEN_ENABLED" then return end
    loadingScreen = true
end
CanIMogIt.frame:AddEventFunction(LoadingScreenStarted)


local function LoadingScreenEnded(event)
    if event ~= "LOADING_SCREEN_DISABLED" then return end
    loadingScreen = false
end
CanIMogIt.frame:AddEventFunction(LoadingScreenEnded)


local function GetAppearancesTable()
    -- Sort the C_TransmogCollection.GetCategoryAppearances tables into something
    -- more usable.
    if appearancesTableGotten then return end
    for categoryID=1,28 do
        local categoryAppearances = C_TransmogCollection.GetCategoryAppearances(categoryID, transmogLocation)
        for i, categoryAppearance in pairs(categoryAppearances) do
            if categoryAppearance.isCollected then
                appearanceCount = appearanceCount + 1
                appearancesTable[categoryAppearance.visualID] = true
            end
        end
    end
    appearancesTableGotten = true
end


local function AddSource(source, appearanceID)
    -- Adds the source to the database, and increments the buffer.
    buffer = buffer + 1
    sourceCount = sourceCount + 1
    local sourceID = source.sourceID
    local sourceItemLink = CanIMogIt:GetItemLinkFromSourceID(sourceID)
    local added = CanIMogIt:DBAddItem(sourceItemLink, appearanceID, sourceID)
    if added then
        sourcesAdded = sourcesAdded + 1
    end
end


local function AddAppearance(appearanceID)
    -- Adds all of the sources for this appearanceID to the database.
    -- returns early if the buffer is reached.
    local sources = C_TransmogCollection.GetAppearanceSources(appearanceID, 1, transmogLocation)
    if sources then
        for i, source in pairs(sources) do
            if source.isCollected then
                AddSource(source, appearanceID)
            end
        end
    end
end


-- Remembering iterators for later
local appearancesIter, removeIter = nil, nil


local function _GetAppearances()
    -- Core logic for getting the appearances.
    if getAppearancesDone then return end
    C_TransmogCollection.ClearSearch(APPEARANCES_ITEMS_TAB)
    GetAppearancesTable()
    buffer = 0

    if appearancesIter == nil then appearancesIter = CanIMogIt.Utils.pairsByKeys(appearancesTable) end
    -- Add new appearances learned.
    for appearanceID, collected in appearancesIter do
        AddAppearance(appearanceID)
        if buffer >= CanIMogIt.bufferMax then return end
        appearancesTable[appearanceID] = nil
    end

    if removeIter == nil then removeIter = CanIMogIt.Utils.pairsByKeys(removeAppearancesTable) end
    -- Remove appearances that are no longer learned.
    for appearanceHash, sources in removeIter do
        for sourceID, source in pairs(sources.sources) do
            if not C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID) then
                local itemLink = CanIMogIt:GetItemLinkFromSourceID(sourceID)
                local appearanceID = CanIMogIt:GetAppearanceIDFromSourceID(sourceID)
                CanIMogIt:DBRemoveItem(appearanceID, sourceID, itemLink, appearanceHash)
                sourcesRemoved = sourcesRemoved + 1
            end
            buffer = buffer + 1
        end
        if buffer >= CanIMogIt.bufferMax then return end
        removeAppearancesTable[appearanceHash] = nil
    end

    getAppearancesDone = true
    appearancesTable = {} -- cleanup
    CanIMogIt:ResetCache()
    appearancesIter = nil
    removeIter = nil
    CanIMogIt.frame:SetScript("OnUpdate", nil)
    if CanIMogItOptions["printDatabaseScan"] then
        CanIMogIt:Print(CanIMogIt.DATABASE_DONE_UPDATE_TEXT..CanIMogIt.BLUE.."+" .. sourcesAdded .. ", "..CanIMogIt.ORANGE.."-".. sourcesRemoved)
    end
end


local timer = 0
local function GetAppearancesOnUpdate(self, elapsed)
    -- OnUpdate function with a reset timer to throttle getting appearances.
    -- We also don't run things if the loading screen is currently up, as some
    -- functions don't return values when loading.
    timer = timer + elapsed
    if timer >= CanIMogIt.throttleTime and not loadingScreen then
        _GetAppearances()
        timer = 0
    end
end


function CanIMogIt:GetAppearances()
    -- Gets a table of all the appearances known to
    -- a character and adds it to the database.
    if CanIMogItOptions["printDatabaseScan"] then
        CanIMogIt:Print(CanIMogIt.DATABASE_START_UPDATE_TEXT)
    end
    removeAppearancesTable = CanIMogIt.Utils.copyTable(CanIMogIt.db.global.appearances)
    CanIMogIt.frame:SetScript("OnUpdate", GetAppearancesOnUpdate)
end


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


function CanIMogIt:_GetRatio(setID)
    -- Gets the count of known and total sources for the given setID.
    local have = 0
    local total = 0
    for _, knownSource in pairs(C_TransmogSets.GetSetSources(setID)) do
        total = total + 1
        if knownSource then
            have = have + 1
        end
    end
    return have, total
end


function CanIMogIt:_GetRatioTextColor(have, total)
    if have == total then
        return CanIMogIt.BLUE
    elseif have > 0 then
        return CanIMogIt.RED_ORANGE
    else
        return CanIMogIt.GRAY
    end
end


function CanIMogIt:_GetRatioText(setID)
    -- Gets the ratio text (and color) of known/total for the given setID.
    local have, total = CanIMogIt:_GetRatio(setID)

    local ratioText = CanIMogIt:_GetRatioTextColor(have, total)
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

    local ratioText = CanIMogIt:_GetRatioText(setID)

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
        secondLineText = CanIMogIt.WHITE .. set.label .. ": " .. BLIZZARD_GREEN ..  set.description .. " "
    elseif set.label then
        secondLineText = CanIMogIt.WHITE .. set.label .. " "
    elseif set.description then
        secondLineText = BLIZZARD_GREEN .. set.description .. " "
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


function CanIMogIt:CalculateSetsVariantText(setID)
    --[[
        Given a setID, calculate the sum of all known sources for this set
        and it's variants.
    ]]

    local baseSetID = C_TransmogSets.GetBaseSetID(setID)

    local variantSets = {C_TransmogSets.GetSetInfo(baseSetID)}
    for i, variantSet in ipairs(CIMI_GetVariantSets(baseSetID)) do
        variantSets[#variantSets+1] = variantSet
    end

    local variantsText = ""

    for i, variantSet in CanIMogIt.Utils.spairs(variantSets, function(t,a,b) return t[a].uiOrder < t[b].uiOrder end) do
        local variantHave, variantTotal = CanIMogIt:_GetRatio(variantSet.setID)

        variantsText = variantsText .. CanIMogIt:_GetRatioTextColor(variantHave, variantTotal)

        -- There is intentionally an extra space before the newline, for positioning.
        variantsText = variantsText .. variantHave .. "/" .. variantTotal .. " \n"
    end

    -- uncomment for debug
    -- variantsText = variantsText .. "setID: " .. setID

    return string.sub(variantsText, 1, -2)
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
        local totalSourceTypes = { 0, 0, 0, 0, 0, 0 }
        local knownSourceTypes = { 0, 0, 0, 0, 0, 0 }
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
    return select(1, GetItemSubClassInfo(4, playerArmorTypeID))
end


function CanIMogIt:GetItemID(itemLink)
    return tonumber(itemLink:match("item:(%d+)"))
end


function CanIMogIt:GetItemLinkFromSourceID(sourceID)
    return select(6, C_TransmogCollection.GetAppearanceSourceInfo(sourceID))
end


function CanIMogIt:GetItemQuality(itemID)
    return select(3, GetItemInfo(itemID))
end


function CanIMogIt:GetItemExpansion(itemID)
    return select(15, GetItemInfo(itemID))
end


function CanIMogIt:GetItemMinTransmogLevel(itemID)
    -- Returns the minimum level required to transmog the item.
    -- This uses the expansion ID of the item to figure it out.
    -- Expansions before Shadowlands are all opened at level 10
    -- as of 9.0. Shadowlands is opened at level 48.
    local expansion = CanIMogIt:GetItemExpansion(itemID)
    if expansion == nil or expansion == 0 then return end
    if expansion < CanIMogIt.Expansions.SHADOWLANDS then
        return CanIMogIt.MIN_TRANSMOG_LEVEL
    else
        return CanIMogIt.MIN_TRANSMOG_LEVEL_SHADOWLANDS
    end
end


function CanIMogIt:GetItemClassName(itemLink)
    return select(2, GetItemInfoInstant(itemLink))
end


function CanIMogIt:GetItemSubClassName(itemLink)
    return select(3, GetItemInfoInstant(itemLink))
end


function CanIMogIt:GetItemSlotName(itemLink)
    return select(4, GetItemInfoInstant(itemLink))
end


function CanIMogIt:IsReadyForCalculations(itemLink)
    -- Returns true of the item's GetItemInfo is ready, or if it's a keystone,
    -- or if it's a battlepet.
    local itemInfo = GetItemInfo(itemLink)
    local isKeystone = string.match(itemLink, ".*(keystone):.*") == "keystone"
    local isBattlepet = string.match(itemLink, ".*(battlepet):.*") == "battlepet"
    if itemInfo or isKeystone or isBattlepet then
        return true
    end
    return false
end


function CanIMogIt:IsItemArmor(itemLink)
    local itemClass = CanIMogIt:GetItemClassName(itemLink)
    if itemClass == nil then return end
    return GetItemClassInfo(4) == itemClass
end


function CanIMogIt:IsArmorSubClassID(subClassID, itemLink)
    local itemSubClass = CanIMogIt:GetItemSubClassName(itemLink)
    if itemSubClass == nil then return end
    return select(1, GetItemSubClassInfo(4, subClassID)) == itemSubClass
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


local function IsHeirloomRedText(redText, itemLink)
    local itemID = CanIMogIt:GetItemID(itemLink)
    if redText == _G["ITEM_SPELL_KNOWN"] and C_Heirloom.IsItemHeirloom(itemID) then
        return true
    end
end


local function IsLevelRequirementRedText(redText)
    if string.match(redText, _G["ITEM_MIN_LEVEL"]) then
        return true
    end
end


function CanIMogIt:CharacterCanEquipItem(itemLink)
    -- Can the character equip this item eventually? (excluding level)
    if CanIMogIt:IsItemArmor(itemLink) and CanIMogIt:IsArmorCosmetic(itemLink) then
        return true
    end
    local redText = CanIMogItTooltipScanner:GetRedText(itemLink)
    if redText == "" or redText == nil then
        return true
    end
    if IsHeirloomRedText(redText, itemLink) then
        -- Special case for heirloom items. They always have red text if it was learned.
        return true
    end
    if IsLevelRequirementRedText(redText) then
        -- We ignore the level, since it will be equipable eventually.
        return true
    end
    return false
end


function CanIMogIt:IsValidAppearanceForCharacter(itemLink)
    -- Can the character transmog this appearance right now?
    if not CanIMogIt:CharacterIsHighEnoughLevelForTransmog(itemLink) then
        return false
    end
    if CanIMogIt:CharacterCanEquipItem(itemLink) then
        if CanIMogIt:IsItemArmor(itemLink) then
            return CanIMogIt:IsArmorAppropriateForPlayer(itemLink)
        else
            return true
        end
    else
        return false
    end
end


function CanIMogIt:CharacterIsHighEnoughLevelForTransmog(itemLink)
    local minLevel = CanIMogIt:GetItemMinTransmogLevel(itemLink)
    if minLevel == nil then return true end
    return UnitLevel("player") > minLevel
end


function CanIMogIt:IsItemSoulbound(itemLink, bag, slot)
    return CanIMogItTooltipScanner:IsItemSoulbound(itemLink, bag, slot)
end


function CanIMogIt:IsItemBindOnEquip(itemLink, bag, slot)
    return CanIMogItTooltipScanner:IsItemBindOnEquip(itemLink, bag, slot)
end


function CanIMogIt:GetItemClassRestrictions(itemLink)
    if not itemLink then return end
    return CanIMogItTooltipScanner:GetClassesRequired(itemLink)
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
    return slotName ~= "" and slotName ~= BAG
end


function CanIMogIt:GetSourceID(itemLink)
    local sourceID = select(2, C_TransmogCollection.GetItemInfo(itemLink))
    if sourceID then
        return sourceID, "C_TransmogCollection.GetItemInfo"
    end

    -- Some items don't have the C_TransmogCollection.GetItemInfo data,
    -- so use the old way to find the sourceID (using the DressUpModel).
    local itemID, _, _, slotName = GetItemInfoInstant(itemLink)
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


function CanIMogIt:_PlayerKnowsTransmog(itemLink, appearanceID)
    -- Internal logic for determining if the item is known or not.
    -- Does not use the CIMI database.
    if itemLink == nil or appearanceID == nil then return end
    local sources = C_TransmogCollection.GetAppearanceSources(appearanceID, 1, transmogLocation)
    if sources then
        for i, source in pairs(sources) do
            local sourceItemLink = CanIMogIt:GetItemLinkFromSourceID(source.sourceID)
            if CanIMogIt:IsItemSubClassIdentical(itemLink, sourceItemLink) and source.isCollected then
                return true
            end
        end
    end
    return false
end


function CanIMogIt:PlayerKnowsTransmog(itemLink)
    -- Returns whether this item's appearance is already known by the player.
    local appearanceID = CanIMogIt:GetAppearanceID(itemLink)
    if appearanceID == nil then return false end
    local requirements = CanIMogIt.Requirements:GetRequirements()
    if CanIMogIt:DBHasAppearanceForRequirements(appearanceID, itemLink, requirements) then
        if CanIMogIt:IsItemArmor(itemLink) then
            -- The character knows the appearance, check that it's from the same armor type.
            for sourceID, knownItem in pairs(CanIMogIt:DBGetSources(appearanceID, itemLink)) do
                if CanIMogIt:IsArmorSubClassName(knownItem.subClass, itemLink)
                        or knownItem.subClass == COSMETIC_NAME then
                    return true
                end
            end
        else
            -- Is not armor, don't worry about same appearance for different types
            return true
        end
    end

    -- Don't know from the database, try using the API.
    local knowsTransmog = CanIMogIt:_PlayerKnowsTransmog(itemLink, appearanceID)
    if knowsTransmog then
        CanIMogIt:DBAddItem(itemLink)
    end
    return knowsTransmog
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

    -- First check the Database
    if CanIMogIt:DBHasSource(appearanceID, sourceID, itemLink) then
        return true
    end

    local hasTransmog;
    hasTransmog = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID)

    -- Update Database
    if hasTransmog then
        CanIMogIt:DBAddItem(itemLink, appearanceID, sourceID)
    end

    return hasTransmog
end


function CanIMogIt:CharacterCanLearnTransmog(itemLink)
    -- Returns whether the player can learn the item or not.
    local slotName = CanIMogIt:GetItemSlotName(itemLink)
    if slotName == TABARD then return true end
    local sourceID = CanIMogIt:GetSourceID(itemLink)
    if sourceID == nil then return end
    if select(2, C_TransmogCollection.PlayerCanCollectSource(sourceID)) then
        return true
    end
    return false
end


function CanIMogIt:GetReason(itemLink)
    local reason = CanIMogItTooltipScanner:GetRedText(itemLink)
    if reason == "" then
        reason = CanIMogIt:GetItemSubClassName(itemLink)
    end
    return reason
end


function CanIMogIt:IsTransmogable(itemLink)
    -- Returns whether the item is transmoggable or not.

    -- White items are not transmoggable.
    local quality = CanIMogIt:GetItemQuality(itemLink)
    if quality == nil then return end
    if quality <= 1 then
        return false
    end

    local is_misc_subclass = CanIMogIt:IsArmorSubClassID(MISC, itemLink)
    if is_misc_subclass and miscArmorExceptions[CanIMogIt:GetItemSlotName(itemLink)] == nil then
        return false
    end

    local itemID, _, _, slotName = GetItemInfoInstant(itemLink)

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


function CanIMogIt:PreLogicOptionsContinue(itemLink)
    -- Apply the options. Returns false if it should stop the logic.
    if CanIMogItOptions["showEquippableOnly"] and
            not CanIMogIt:IsEquippable(itemLink) then
        -- Don't bother if it's not equipable.
        return false
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
            or unmodifiedText == CanIMogIt.NOT_TRANSMOGABLE_BOE) then
        -- If we don't want to show the tooltip if it's not transmoggable
        return "", ""
    end

    if not CanIMogItOptions["showVerboseText"] then
        text = simpleTextMap[text] or text
    end

    return text, unmodifiedText
end


function CanIMogIt:CalculateTooltipText(itemLink, bag, slot)
    --[[
        Calculate the tooltip text.
        No caching is done here, so don't call this often!
        Use GetTooltipText whenever possible!
    ]]
    local exception_text = CanIMogIt:GetExceptionText(itemLink)
    if exception_text then
        return exception_text, exception_text
    end

    local isTransmogable = CanIMogIt:IsTransmogable(itemLink)
    -- if isTransmogable == nil then return end

    local playerKnowsTransmogFromItem, isValidAppearanceForCharacter,
        characterIsHighEnoughLevelToTransmog, playerKnowsTransmog, characterCanLearnTransmog,
        isItemSoulbound, text, unmodifiedText;

    local isItemSoulbound = CanIMogIt:IsItemSoulbound(itemLink, bag, slot)

    -- Is the item transmogable?
    if isTransmogable then
        --Calculating the logic for each rule

        -- If the item is transmogable, bug didn't give a result for soulbound state, it's
        -- probably not ready yet.
        if isItemSoulbound == nil then return end

        playerKnowsTransmogFromItem = CanIMogIt:PlayerKnowsTransmogFromItem(itemLink)
        if playerKnowsTransmogFromItem == nil then return end

        isValidAppearanceForCharacter = CanIMogIt:IsValidAppearanceForCharacter(itemLink)
        if isValidAppearanceForCharacter == nil then return end

        playerKnowsTransmog = CanIMogIt:PlayerKnowsTransmog(itemLink)
        if playerKnowsTransmog == nil then return end

        characterCanLearnTransmog = CanIMogIt:CharacterCanLearnTransmog(itemLink)
        if characterCanLearnTransmog == nil then return end

        -- Is the item transmogable?
        if playerKnowsTransmogFromItem then
            -- Is this an appearance that the character can use now?
            if isValidAppearanceForCharacter then
                -- The player knows the appearance from this item
                -- and the character can transmog it.
                text = CanIMogIt.KNOWN
                unmodifiedText = CanIMogIt.KNOWN
            else
                -- Can the character use the appearance eventually?
                if characterCanLearnTransmog then
                    -- The player knows the appearance from this item, but
                    -- the character is too low level to use the appearance.
                    text = CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL
                    unmodifiedText = CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL
                else
                    -- The player knows the appearance from this item, but
                    -- the character can never use it.
                    text = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER
                    unmodifiedText = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER
                end
            end
        -- Does the player know the appearance from a different item?
        elseif playerKnowsTransmog then
            -- Is this an appearance that the character can use/learn now?
            if isValidAppearanceForCharacter then
                -- The player knows the appearance from another item, and
                -- the character can use it.
                text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM
                unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM
            else
                -- Can the character use/learn the appearance from the item eventually?
                if characterCanLearnTransmog then
                    -- The player knows the appearance from another item, but
                    -- the character is too low level to use/learn the appareance.
                    text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL
                    unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL
                else
                    -- The player knows the appearance from another item, but
                    -- this charater can never use/learn the apperance.
                    text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER
                    unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER
                end
            end
        else
            -- Can the character learn the appearance?
            if characterCanLearnTransmog then
                -- The player does not know the appearance and the character
                -- can learn this appearance.
                text = CanIMogIt.UNKNOWN
                unmodifiedText = CanIMogIt.UNKNOWN
            else
                -- Is the item Soulbound?
                if isItemSoulbound then
                    -- The player does not know the appearance, the character
                    -- cannot use the appearance, and the item cannot be mailed
                    -- because it is soulbound.
                    text = CanIMogIt.UNKNOWABLE_SOULBOUND
                            .. BLIZZARD_RED .. CanIMogIt:GetReason(itemLink)
                    unmodifiedText = CanIMogIt.UNKNOWABLE_SOULBOUND
                else
                    -- The player does not know the apperance, and the character
                    -- cannot use/learn the appearance.
                    text = CanIMogIt.UNKNOWABLE_BY_CHARACTER
                            .. BLIZZARD_RED .. CanIMogIt:GetReason(itemLink)
                    unmodifiedText = CanIMogIt.UNKNOWABLE_BY_CHARACTER
                end
            end
        end
    else
        -- This item is never transmogable.
        text = CanIMogIt.NOT_TRANSMOGABLE
        unmodifiedText = CanIMogIt.NOT_TRANSMOGABLE
    end

    -- if CanIMogItOptions["showBoEColors"] then
    --     -- Apply the option, if it is enabled then check item bind.
    --     text, unmodifiedText = CanIMogIt:CheckItemBindType(text, unmodifiedText, itemLink, bag, slot)
    -- end

    return text, unmodifiedText
end


function CanIMogIt:CheckItemBindType(text, unmodifiedText, itemLink, bag, slot)
    --[[
        Check what binding text is used on the tooltip and then
        change the Can I Mog It text where appropirate.
    ]]
    local isItemBindOnEquip = CanIMogIt:IsItemBindOnEquip(itemLink, bag, slot)
    if isItemBindOnEquip == nil then return end

    if isItemBindOnEquip then
        if unmodifiedText == CanIMogIt.KNOWN then
            text = CanIMogIt.KNOWN_BOE
            unmodifiedText = CanIMogIt.KNOWN_BOE
        elseif unmodifiedText == CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL then
            text = CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL_BOE
            unmodifiedText = CanIMogIt.KNOWN_BUT_TOO_LOW_LEVEL_BOE
        elseif unmodifiedText == CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER then
            text = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE
            unmodifiedText = CanIMogIt.KNOWN_BY_ANOTHER_CHARACTER_BOE
        elseif unmodifiedText == CanIMogIt.KNOWN_FROM_ANOTHER_ITEM then
            text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE
            unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BOE
        elseif unmodifiedText == CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL then
            text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL_BOE
            unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_BUT_TOO_LOW_LEVEL_BOE
        elseif unmodifiedText == CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER then
            text = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE
            unmodifiedText = CanIMogIt.KNOWN_FROM_ANOTHER_ITEM_AND_CHARACTER_BOE
        elseif unmodifiedText == CanIMogIt.NOT_TRANSMOGABLE then
            text = CanIMogIt.NOT_TRANSMOGABLE_BOE
            unmodifiedText = CanIMogIt.NOT_TRANSMOGABLE_BOE
        end
    -- elseif BoA
    end
    return text, unmodifiedText
end


local foundAnItemFromBags = false


function CanIMogIt:GetTooltipText(itemLink, bag, slot)
    --[[
        Gets the text to display on the tooltip from the itemLink.

        If bag and slot are given, this will use the itemLink from
        bag and slot instead.

        Returns two things:
            the text to display.
            the unmodifiedText that can be used for lookup values.
    ]]
    if bag and slot then
        itemLink = GetContainerItemLink(bag, slot)
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

    if not CanIMogIt:PreLogicOptionsContinue(itemLink) then return "", "" end

    -- Return cached items
    local cachedData = CanIMogIt.cache:GetItemTextValue(itemLink)
    if cachedData then
        local cachedText, cachedUnmodifiedText = unpack(cachedData)
        return cachedText, cachedUnmodifiedText
    end

    text, unmodifiedText = CanIMogIt:CalculateTooltipText(itemLink, bag, slot)

    text = CanIMogIt:PostLogicOptionsText(text, unmodifiedText)

    -- Update cached items
    if text ~= nil then
        CanIMogIt.cache:SetItemTextValue(itemLink, {text, unmodifiedText})
    end

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

local function addToTooltip(tooltip, itemLink, bag, slot)
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
    text = CanIMogIt:GetTooltipText(itemLink, bag, slot)
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
GameTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipCleared", TooltipCleared)


local function CanIMogIt_AttachItemTooltip(tooltip)
    -- Hook for normal tooltips.
    local link = select(2, tooltip:GetItem())
    if link then
        addToTooltip(tooltip, link)
    end
end


GameTooltip:HookScript("OnTooltipSetItem", CanIMogIt_AttachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", CanIMogIt_AttachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", CanIMogIt_AttachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", CanIMogIt_AttachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", CanIMogIt_AttachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", CanIMogIt_AttachItemTooltip)
GameTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipSetItem", CanIMogIt_AttachItemTooltip)


hooksecurefunc(GameTooltip, "SetMerchantItem",
    function(tooltip, index)
        addToTooltip(tooltip, GetMerchantItemLink(index))
    end
)


hooksecurefunc(GameTooltip, "SetBuybackItem",
    function(tooltip, index)
        addToTooltip(tooltip, GetBuybackItemLink(index))
    end
)


hooksecurefunc(GameTooltip, "SetBagItem",
    function(tooltip, bag, slot)
        addToTooltip(tooltip, GetContainerItemLink(bag, slot), bag, slot)
    end
)


--hooksecurefunc(GameTooltip, "SetAuctionItem",
    --function(tooltip, type, index)
        --addToTooltip(tooltip, GetAuctionItemLink(type, index))
    --end
--)


--hooksecurefunc(GameTooltip, "SetAuctionSellItem",
    --function(tooltip)
        --local name = GetAuctionSellItemInfo()
        --local _, link = GetItemInfo(name)
        --addToTooltip(tooltip, link)
    --end
--)


hooksecurefunc(GameTooltip, "SetLootItem",
    function(tooltip, slot)
        if LootSlotHasItem(slot) then
            local link = GetLootSlotLink(slot)
            addToTooltip(tooltip, link)
        end
    end
)


hooksecurefunc(GameTooltip, "SetLootRollItem",
    function(tooltip, slot)
        addToTooltip(tooltip, GetLootRollItemLink(slot))
    end
)


hooksecurefunc(GameTooltip, "SetInventoryItem",
    function(tooltip, unit, slot)
        addToTooltip(tooltip, GetInventoryItemLink(unit, slot))
    end
)


hooksecurefunc(GameTooltip, "SetGuildBankItem",
    function(tooltip, tab, slot)
        addToTooltip(tooltip, GetGuildBankItemLink(tab, slot))
    end
)


hooksecurefunc(GameTooltip, "SetRecipeResultItem",
    function(tooltip, itemID)
        addToTooltip(tooltip, C_TradeSkillUI.GetRecipeItemLink(itemID))
    end
)


hooksecurefunc(GameTooltip, "SetRecipeReagentItem",
    function(tooltip, itemID, index)
        addToTooltip(tooltip, C_TradeSkillUI.GetRecipeReagentItemLink(itemID, index))
    end
)


hooksecurefunc(GameTooltip, "SetTradeTargetItem",
    function(tooltip, index)
        addToTooltip(tooltip, GetTradeTargetItemLink(index))
    end
)


hooksecurefunc(GameTooltip, "SetQuestLogItem",
    function(tooltip, type, index)
        addToTooltip(tooltip, GetQuestLogItemLink(type, index))
    end
)


hooksecurefunc(GameTooltip, "SetInboxItem",
    function(tooltip, mailIndex, attachmentIndex)
        addToTooltip(tooltip, GetInboxItemLink(mailIndex, attachmentIndex or 1))
    end
)


hooksecurefunc(GameTooltip, "SetSendMailItem",
    function(tooltip, index)
        local name = GetSendMailItem(index)
        local _, link = GetItemInfo(name)
        addToTooltip(tooltip, link)
    end
)


local function OnSetHyperlink(tooltip, link)
    local type, id = string.match(link, ".*(item):(%d+).*")
    if not type or not id then return end
    if type == "item" then
        addToTooltip(tooltip, link)
    end
end


hooksecurefunc(GameTooltip, "SetHyperlink", OnSetHyperlink)


--[[
    global = {
        "appearances" = {
            appearanceID:INVTYPE_HEAD = {
                "sources" = {
                    sourceID = {
                        "subClass" = "Mail",
                        "classRestrictions" = {"Mage", "Priest", "Warlock"}
                    }
                }
            }
        }
    }
]]
CanIMogIt_DatabaseVersion = 1.2


local default = {
    global = {
        appearances = {},
        setItems = {}
    }
}


local function IsBadKey(key)
    -- Good key: 12345:SOME_TYPE

    -- If it's a number: 12345
    if type(key) == 'number' then
        -- Get the appearance hash for the source
        return true
    end

    -- If it has two :'s in it: 12345:SOME_TYPE:SOME_TYPE
    local _, count = string.gsub(key, ":", "")
    if count >= 2 then
        return true
    end
end


local function CheckBadDB()
    --[[
        Check if the database has been corrupted by a bad update or going
        back too many versions.
    ]]
    if CanIMogIt.db.global.appearances and CanIMogIt.db.global.databaseVersion then
        for key, _ in pairs(CanIMogIt.db.global.appearances) do
            if IsBadKey(key) then
                StaticPopupDialogs["CANIMOGIT_BAD_DATABASE"] = {
                    text = "Can I Mog It?" .. "\n\n" .. L["Sorry! Your database has corrupted entries. This will cause errors and give incorrect results. Please click below to reset the database."],
                    button1 = L["Okay"],
                    button2 = L["Ask me later"],
                    OnAccept = function () CanIMogIt:DBReset() end,
                    timeout = 0,
                    whileDead = true,
                    hideOnEscape = true,
                    preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
                }
                StaticPopup_Show("CANIMOGIT_BAD_DATABASE")
                return
            end
        end
    end
end


local function UpdateTo1_1()
    local appearancesTable = CanIMogIt.Utils.copyTable(CanIMogIt.db.global.appearances)
    for appearanceID, appearance in pairs(appearancesTable) do
        local sources = appearance.sources
        for sourceID, source in pairs(sources) do
            -- Get the appearance hash for the source
            local itemLink = CanIMogIt:GetItemLinkFromSourceID(sourceID)
            local hash = CanIMogIt:GetAppearanceHash(appearanceID, itemLink)
            -- Add the source to the appearances with the new hash key
            if not CanIMogIt.db.global.appearances[hash] then
                CanIMogIt.db.global.appearances[hash] = {
                    ["sources"] = {},
                }
            end
            CanIMogIt.db.global.appearances[hash].sources[sourceID] = source
        end
        -- Remove the old one
        CanIMogIt.db.global.appearances[appearanceID] = nil
    end
end


local function UpdateTo1_2()
    for hash, sources in pairs(CanIMogIt.db.global.appearances) do
        for sourceID, source in pairs(sources["sources"]) do
            local itemLink = CanIMogIt:GetItemLinkFromSourceID(sourceID)
            local appearanceID = CanIMogIt:GetAppearanceIDFromSourceID(sourceID)
            if sourceID and appearanceID and itemLink then
                CanIMogIt:_DBSetItem(itemLink, appearanceID, sourceID)
            end
        end
    end
end


local versionMigrationFunctions = {
    [1.1] = UpdateTo1_1,
    [1.2] = UpdateTo1_2
}


local function UpdateToVersion(version)
    CanIMogIt:Print(L["Migrating Database version to:"], version)
    versionMigrationFunctions[version]()
    CanIMogIt.db.global.databaseVersion = version
    CanIMogIt:Print(L["Database migrated to:"], version)
end


local function UpdateDatabase()
    if not CanIMogIt.db.global.databaseVersion then
        CanIMogIt.db.global.databaseVersion = 1.0
    end
    if  CanIMogIt.db.global.databaseVersion < 1.1 then
        UpdateToVersion(1.1)
    end
    if CanIMogIt.db.global.databaseVersion < 1.2 then
        CanIMogIt.CreateMigrationPopup("CANIMOGIT_DB_MIGRATION_1_2", function () UpdateToVersion(1.2) end)
    end
end


local function UpdateDatabaseIfNeeded()
    CheckBadDB()
    if next(CanIMogIt.db.global.appearances) and
            (not CanIMogIt.db.global.databaseVersion
            or CanIMogIt.db.global.databaseVersion < CanIMogIt_DatabaseVersion) then
        UpdateDatabase()
    else
        -- There is no database, add the default.
        CanIMogIt.db.global.databaseVersion = CanIMogIt_DatabaseVersion
    end
end


function CanIMogIt:OnInitialize()
    if (not CanIMogItDatabase) then
        StaticPopup_Show("CANIMOGIT_NEW_DATABASE")
    end
    self.db = LibStub("AceDB-3.0"):New("CanIMogItDatabase", default)
end


function CanIMogIt:GetAppearanceHash(appearanceID, itemLink)
    if not appearanceID or not itemLink then return end
    local slot = self:GetItemSlotName(itemLink)
    return appearanceID .. ":" .. slot
end

local function SourcePassesRequirement(source, requirementName, requirementValue)
    if source[requirementName] then
        if type(source[requirementName]) == "string" then
            -- single values, such as subClass = Plate
            if source[requirementName] ~= requirementValue then
                return false
            end
        elseif type(source[requirementName]) == "table" then
            -- multi-values, such as classRestrictions = Shaman, Hunter
            local found = false
            for index, sourceValue in pairs(source[requirementName]) do
                if sourceValue == requirementValue then
                    found = true
                end
            end
            if not found then
                return false
            end
        else
            return false
        end
    end
    return true
end


function CanIMogIt:DBHasAppearanceForRequirements(appearanceID, itemLink, requirements)
    --[[
        @param requirements: a table of {requirementName: value}, which will be
            iterated over for each known item to determine if all requirements are met.
            If the requirements are not met for any item, this will return false.
            For example, {"classRestrictions": "Druid"} would filter out any that don't
            include Druid as a class restriction. If the item doesn't have a restriction, it
            is assumed to not be a restriction at all.
    ]]
    if not self:DBHasAppearance(appearanceID, itemLink) then
        return false
    end
    for sourceID, source in pairs(self:DBGetSources(appearanceID, itemLink)) do
        for name, value in pairs(requirements) do
            if SourcePassesRequirement(source, name, value) then
                return true
            end
        end
    end
    return false
end


function CanIMogIt:DBHasAppearance(appearanceID, itemLink)
    local hash = self:GetAppearanceHash(appearanceID, itemLink)
    return self.db.global.appearances[hash] ~= nil
end


function CanIMogIt:DBAddAppearance(appearanceID, itemLink)
    if not self:DBHasAppearance(appearanceID, itemLink) then
        local hash = CanIMogIt:GetAppearanceHash(appearanceID, itemLink)
        self.db.global.appearances[hash] = {
            ["sources"] = {},
        }
    end
end


function CanIMogIt:DBRemoveAppearance(appearanceID, itemLink, dbHash)
    local hash = dbHash or self:GetAppearanceHash(appearanceID, itemLink)
    self.db.global.appearances[hash] = nil
end


function CanIMogIt:DBHasSource(appearanceID, sourceID, itemLink)
    if appearanceID == nil or sourceID == nil then return end
    if CanIMogIt:DBHasAppearance(appearanceID, itemLink) then
        local hash = self:GetAppearanceHash(appearanceID, itemLink)
        return self.db.global.appearances[hash].sources[sourceID] ~= nil
    end
    return false
end


function CanIMogIt:DBGetSources(appearanceID, itemLink)
    -- Returns the table of sources for the appearanceID.
    if self:DBHasAppearance(appearanceID, itemLink) then
        local hash = self:GetAppearanceHash(appearanceID, itemLink)
        return self.db.global.appearances[hash].sources
    end
end


CanIMogIt.itemsToAdd = {}

local function LateAddItems(event, itemID, success)
    if event == "GET_ITEM_INFO_RECEIVED" and itemID then
        -- The 8.0.1 update is causing this event to return a bunch of itemID=0
        if not success or itemID <= 0 then
            return
        end
        if CanIMogIt.itemsToAdd[itemID] then
            for sourceID, _ in pairs(CanIMogIt.itemsToAdd[itemID]) do
                local appearanceID = CanIMogIt:GetAppearanceIDFromSourceID(sourceID)
                local itemLink = CanIMogIt:GetItemLinkFromSourceID(sourceID)
                CanIMogIt:_DBSetItem(itemLink, appearanceID, sourceID)
            end
            table.remove(CanIMogIt.itemsToAdd, itemID)
        end
    end
end
CanIMogIt.frame:AddEventFunction(LateAddItems)


function CanIMogIt:_DBSetItem(itemLink, appearanceID, sourceID)
    -- Sets the item in the database, or at least schedules for it to be set
    -- when we get item info back.
    if GetItemInfo(itemLink) then
        local hash = self:GetAppearanceHash(appearanceID, itemLink)
        if self.db.global.appearances[hash] == nil then
            return
        end
        self.db.global.appearances[hash].sources[sourceID] = {
            ["subClass"] = self:GetItemSubClassName(itemLink),
            ["classRestrictions"] = self:GetItemClassRestrictions(itemLink),
        }
        if self:GetItemSubClassName(itemLink) == nil then
            CanIMogIt:Print("nil subclass: " .. itemLink)
        end
    else
        local itemID = CanIMogIt:GetItemID(itemLink)
        if not CanIMogIt.itemsToAdd[itemID] then
            CanIMogIt.itemsToAdd[itemID] = {}
        end
        CanIMogIt.itemsToAdd[itemID][sourceID] = true
    end
end


function CanIMogIt:DBAddItem(itemLink, appearanceID, sourceID)
    -- Adds the item to the database. Returns true if it added something, false otherwise.
    if appearanceID == nil or sourceID == nil then
        appearanceID, sourceID = self:GetAppearanceID(itemLink)
    end
    if appearanceID == nil or sourceID == nil then return end
    self:DBAddAppearance(appearanceID, itemLink)
    if not self:DBHasSource(appearanceID, sourceID, itemLink) then
        CanIMogIt:_DBSetItem(itemLink, appearanceID, sourceID)
        return true
    end
    return false
end


function CanIMogIt:DBRemoveItem(appearanceID, sourceID, itemLink, dbHash)
    -- The specific dbHash can be passed in to bypass trying to generate it.
    -- This is used mainly when Blizzard removes or changes item appearanceIDs.
    local hash = dbHash or self:GetAppearanceHash(appearanceID, itemLink)
    appearanceID = appearanceID or CanIMogIt.Utils.strsplit(":", hash)[1]
    if self.db.global.appearances[hash] == nil then return end
    if self.db.global.appearances[hash].sources[sourceID] ~= nil then
        self.db.global.appearances[hash].sources[sourceID] = nil
        if next(self.db.global.appearances[hash].sources) == nil then
            self:DBRemoveAppearance(appearanceID, itemLink, dbHash)
        end
    end
end


function CanIMogIt:DBHasItem(itemLink)
    local appearanceID, sourceID = self:GetAppearanceID(itemLink)
    if appearanceID == nil or sourceID == nil then return end
    return self:DBHasSource(appearanceID, sourceID, itemLink)
end


function CanIMogIt:DBReset()
    CanIMogItDatabase = nil
    CanIMogIt.db = nil
    ReloadUI()
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
        -- Make sure the database is updated to the latest version
        UpdateDatabaseIfNeeded()
        -- add all known appearanceID's to the database
        CanIMogIt:GetAppearances()
        CanIMogIt:GetSets()
    end
end
CanIMogIt.frame:AddEventFunction(GetAppearancesEvent)


local transmogEvents = {
    ["TRANSMOG_COLLECTION_SOURCE_ADDED"] = true,
    ["TRANSMOG_COLLECTION_SOURCE_REMOVED"] = true,
    ["TRANSMOG_COLLECTION_UPDATED"] = true,
}

local function TransmogCollectionUpdated(event, sourceID, ...)
    if transmogEvents[event] and sourceID then
        -- Get the appearanceID from the sourceID
        if event == "TRANSMOG_COLLECTION_SOURCE_ADDED" then
            local itemLink = CanIMogIt:GetItemLinkFromSourceID(sourceID)
            local appearanceID = CanIMogIt:GetAppearanceIDFromSourceID(sourceID)
            if itemLink and appearanceID then
                CanIMogIt:DBAddItem(itemLink, appearanceID, sourceID)
            end
        elseif event == "TRANSMOG_COLLECTION_SOURCE_REMOVED" then
            local itemLink = CanIMogIt:GetItemLinkFromSourceID(sourceID)
            local appearanceID = CanIMogIt:GetAppearanceIDFromSourceID(sourceID)
            if itemLink and appearanceID then
                CanIMogIt:DBRemoveItem(appearanceID, sourceID, itemLink)
            end
        end
        if sourceID then
            CanIMogIt.cache:RemoveItemBySourceID(sourceID)
        end
        CanIMogIt.frame:ItemOverlayEvents("BAG_UPDATE")
    end
end

CanIMogIt.frame:AddEventFunction(TransmogCollectionUpdated)


-- function CanIMogIt.frame:GetItemInfoReceived(event, ...)
--     if event ~= "GET_ITEM_INFO_RECEIVED" then return end
--     Database:GetItemInfoReceived()
-- end


--[[
    source: http://forums.wowace.com/showthread.php?t=15588&page=2

    To use:
    CanIMogItTooltipScanner:SetHyperlink(itemLink)
]]


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


-- Tooltip setup
CanIMogItTooltipScanner = CreateFrame( "GameTooltip", "CanIMogItTooltipScanner");
CanIMogItTooltipScanner:SetOwner( WorldFrame, "ANCHOR_NONE" );
CanIMogItTooltipScanner:AddFontStrings(
    CanIMogItTooltipScanner:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" ),
    CanIMogItTooltipScanner:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" ) );


local function GetRedText(text)
    if text and text:GetText() then
        local r,g,b = text:GetTextColor()
        -- Color values from RED_FONT_COLOR (see FrameXML/FontStyles.xml)
        if math.floor(r*256) == 255 and math.floor(g*256) == 32 and math.floor(b*256) == 32 then
            return text:GetText()
        end
    end
end


local function IsItemSoulbound(text)
    if not text then return end
    if text:GetText() == ITEM_SOULBOUND or text:GetText() == ITEM_BIND_ON_PICKUP then
        return true
    end
    return false
end


local function IsItemBindOnEquip(text)
    if not text then return end
    if text:GetText() == ITEM_BIND_ON_EQUIP or text:GetText() == ITEM_BIND_ON_USE then
        return true
    end
    return false
end


-- local function GetRequiredText(text)
--     -- Returns {Profession = level} if the text has a profession in it,
--     if text and text:GetText() then
--         return partOf(text:GetText(), ITEM_REQ_SKILL)
--     end
-- end


local function GetClassesText(text)
    -- Returns the text of classes required by this item, or nil if None
    if text and text:GetText() then
        return partOf(text:GetText(), ITEM_CLASSES_ALLOWED)
    end
end


function CanIMogItTooltipScanner:CIMI_SetItem(itemLink, bag, slot)
    -- Sets the item for the tooltip based on the itemLink or bag and slot.
    if bag and slot and bag == BANK_CONTAINER then
        self:SetInventoryItem("player", BankButtonIDToInvSlotID(slot, nil))
    elseif bag and slot then
        self:SetBagItem(bag, slot)
    else
        local isBattlepet = string.match(itemLink, ".*(battlepet):.*") == "battlepet"
        if not isBattlepet then
            self:SetHyperlink(itemLink)
        end
    end
end


function CanIMogItTooltipScanner:ScanTooltipBreak(func, itemLink, bag, slot)
    -- Scans the tooltip, breaking when an item is found.
    self:CIMI_SetItem(itemLink, bag, slot)
    local result;
    local tooltipName = self:GetName()
    for i = 1, self:NumLines() do
        result = func(_G[tooltipName..'TextLeft'..i]) or func(_G[tooltipName..'TextRight'..i])
        if result then break end
    end
    self:ClearLines()
    return result
end


function CanIMogItTooltipScanner:ScanTooltip(func, itemLink, bag, slot)
    -- Scans the tooltip, returning a table of all of the results.
    self:CIMI_SetItem(itemLink, bag, slot)
    local tooltipName = self:GetName()
    local results = {}
    for i = 1, self:NumLines() do
        results[tooltipName..'TextLeft'..i] = func(_G[tooltipName..'TextLeft'..i])
        results[tooltipName..'TextRight'..i] = func(_G[tooltipName..'TextRight'..i])
    end
    self:ClearLines()
    return results
end


function CanIMogItTooltipScanner:GetNumberOfLines(itemLink, bag, slot)
    -- Returns the number of lines on the tooltip with this item
    self:CIMI_SetItem(itemLink, bag, slot)
    local numberOfLines = self:NumLines()
    self:ClearLines()
    return numberOfLines
end


function CanIMogItTooltipScanner:GetRedText(itemLink)
    -- Returns all of the red text as space seperated string.
    local results = self:ScanTooltip(GetRedText, itemLink)
    local red_texts = {}
    for key, value in pairs(results) do
        if value then
            table.insert(red_texts, value)
        end
    end
    return string.sub(table.concat(red_texts, " "), 1, 80)
end


-- function CanIMogItTooltipScanner:GetProfessionInfo(itemLink)
--     -- Returns all of the red text as space seperated string.
--     local result = self:ScanTooltipBreak(GetProfessionText, itemLink)

--     return
-- end


function CanIMogItTooltipScanner:GetClassesRequired(itemLink)
    -- Returns a table of classes required for the item.
    local result = self:ScanTooltipBreak(GetClassesText, itemLink)
    if result then
        return CanIMogIt.Utils.strsplit(",%s*", result)
    end
end


function CanIMogItTooltipScanner:IsItemSoulbound(itemLink, bag, slot)
    -- Returns whether the item is soulbound or not.
    if bag and slot then
        return self:ScanTooltipBreak(IsItemSoulbound, nil, bag, slot)
    else
        return self:ScanTooltipBreak(IsItemSoulbound, itemLink)
    end
end


function CanIMogItTooltipScanner:IsItemBindOnEquip(itemLink, bag, slot)
    -- Returns whether the item is bind on equip or not.
    if bag and slot then
        return self:ScanTooltipBreak(IsItemBindOnEquip, nil, bag, slot)
    else
        return self:ScanTooltipBreak(IsItemBindOnEquip, itemLink)
    end
end

if IsAddOnLoaded("Combuctor") then

    -- Needs a slightly modified version of ContainerFrameItemButton_CIMIUpdateIcon(),
    -- to support cached Combuctor bags (e.g. bank when not at bank or other characters).
    function CombuctorItemButton_CIMIUpdateIcon(self)

        if not self or not self:GetParent() or not self:GetParent():GetParent() then return end
        if not CIMI_CheckOverlayIconEnabled() then
            self.CIMIIconTexture:SetShown(false)
            self:SetScript("OnUpdate", nil)
            return
        end

        local bag, slot = self:GetParent():GetParent():GetID(), self:GetParent():GetID()
        -- need to catch 0, 0 and 100, 0 here because the bank frame doesn't
        -- load everything immediately, so the OnUpdate needs to run until those frames are opened.
        if (bag == 0 and slot == 0) or (bag == 100 and slot == 0) then return end

        -- For cached Combuctor bags, GetContainerItemLink(bag, slot) would not work in CanIMogIt:GetTooltipText(nil, bag, slot).
        -- Therefore provide GetTooltipText() with itemLink when available.
        -- If the itemLink isn't available, then try with the bag/slot as backup (fixes battle pets).
        local itemLink = self:GetParent():GetItem()
        if not itemLink then
            -- This may be void storage or guild bank
            itemLink = self:GetParent():GetInfo().link
        end
        local cached = self:GetParent().info.cached
        -- Need to prevent guild bank items from using bag/slot from Combuctor,
        -- since they don't match Blizzard's frames.
        if itemLink or cached or self:GetParent().__name == "CombuctorGuildItem" then
            CIMI_SetIcon(self, CombuctorItemButton_CIMIUpdateIcon, CanIMogIt:GetTooltipText(itemLink))
        else
            CIMI_SetIcon(self, CombuctorItemButton_CIMIUpdateIcon, CanIMogIt:GetTooltipText(itemLink, bag, slot))
        end
    end

    function CIMI_CombuctorUpdate(self)
        CIMI_AddToFrame(self, CombuctorItemButton_CIMIUpdateIcon)
        CombuctorItemButton_CIMIUpdateIcon(self.CanIMogItOverlay)
    end

    hooksecurefunc(Combuctor.Item, "Update", CIMI_CombuctorUpdate)
    CanIMogIt:RegisterMessage("ResetCache", function () Combuctor.Frames:Update() end)
end