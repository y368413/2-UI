--## Version: v56  ## Author: Kemayo
local AppearanceTooltip = {}
local GetScreenWidth = GetScreenWidth
local GetScreenHeight = GetScreenHeight

local setDefaults, db

local LAT = LibStub("LibArmorToken-1.0", true)
local LAI = LibStub("LibAppropriateItems-1.0")

-- minor compat:
local IsDressableItem = _G.IsDressableItem or C_Item.IsDressableItemByID

local tooltip = CreateFrame("Frame", "AppearanceTooltipTooltip", UIParent, "TooltipBorderedFrameTemplate")
tooltip:SetClampedToScreen(true)
tooltip:SetFrameStrata("TOOLTIP")
tooltip:SetSize(280, 380)
tooltip:Hide()

tooltip:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
tooltip:RegisterEvent("ADDON_LOADED")
tooltip:RegisterEvent("PLAYER_LOGIN")
tooltip:RegisterEvent("PLAYER_REGEN_DISABLED")
tooltip:RegisterEvent("PLAYER_REGEN_ENABLED")

function tooltip:ADDON_LOADED(addon)
    if addon ~= "CanIMogIt" then return end

    _G["AppearanceTooltipDB"] = setDefaults(_G["AppearanceTooltipDB"] or {}, {
        modifier = "None", -- or "Alt", "Ctrl", "Shift"
        mousescroll = true, -- scrolling mouse rotates model
        rotate = true, -- turn the model slightly, so it's not face-on to the camera
        spin = false, -- constantly spin the model
        zoomWorn = true, -- zoom in on the item in question
        zoomHeld = true, -- zoom in on weapons
        zoomMasked = false, -- use the transmog mask while zoomed
        dressed = true, -- whether the model should be wearing your current outfit, or be naked
        uncover = true, -- remove clothing to expose the previewed item
        customModel = false, -- use a model other than your current class, and if so:
        modelRace = 7, -- raceid (1:human)
        modelGender = 1, -- 0:male, 1:female
        notifyKnown = true, -- show text explaining the transmog state of the item previewed
        currentClass = false, -- only show for items the current class can transmog
        anchor = "vertical", -- vertical / horizontal
        byComparison = true, -- whether to show by the comparison, or fall back to vertical if needed
        tokens = true, -- try to preview tokens?
        learnable = true, -- show for other learnable items (toys, mounts)
        bags = false,
        bags_unbound = false,
        merchant = false,
        loot = false,
        encounterjournal = false,
        setjournal = false,
        alerts = true,
        appearances_known = {},
    })
    db = _G["AppearanceTooltipDB"]
    AppearanceTooltip.db = db
    db.customModel = false

    self:UnregisterEvent("ADDON_LOADED")
end

function tooltip:PLAYER_LOGIN()
    tooltip.model:SetUnit("player")
    tooltip.modelZoomed:SetUnit("player")
    C_CVar.SetCVar("missingTransmogSourceInItemTooltips", "1")
end

function tooltip:PLAYER_REGEN_ENABLED()
    if self:IsShown() and db.mousescroll then
        SetOverrideBinding(tooltip, true, "MOUSEWHEELUP", "AppearanceKnown_TooltipScrollUp")
        SetOverrideBinding(tooltip, true, "MOUSEWHEELDOWN", "AppearanceKnown_TooltipScrollDown")
    end
end

function tooltip:PLAYER_REGEN_DISABLED()
    ClearOverrideBindings(tooltip)
end

tooltip:SetScript("OnShow", function(self)
    if db.mousescroll and not InCombatLockdown() then
        SetOverrideBinding(tooltip, true, "MOUSEWHEELUP", "AppearanceKnown_TooltipScrollUp")
        SetOverrideBinding(tooltip, true, "MOUSEWHEELDOWN", "AppearanceKnown_TooltipScrollDown")
    end
end);

tooltip:SetScript("OnHide",function(self)
    if not InCombatLockdown() then
        ClearOverrideBindings(tooltip);
    end
end)

local function makeModel()
    local model = CreateFrame("DressUpModel", nil, tooltip)
    model:SetFrameLevel(1)
    model:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 5, -5)
    model:SetPoint("BOTTOMRIGHT", tooltip, "BOTTOMRIGHT", -5, 5)
    model:SetKeepModelOnHide(true)
    model:SetScript("OnModelLoaded", function(self, ...)
        -- Makes sure the zoomed camera is correct, if the model isn't loaded right away
        if self.cameraID then
            Model_ApplyUICamera(self, self.cameraID)
        end
    end)
    -- Use the blacked-out model:
    -- model:SetUseTransmogSkin(true)
    -- Display in combat pose:
    -- model:FreezeAnimation(1)
    return model
end
tooltip.model = makeModel()
tooltip.modelZoomed = makeModel()
tooltip.modelWeapon = makeModel()

local known = tooltip:CreateFontString(nil, "OVERLAY", "GameFontNormal")
known:SetWordWrap(true)
known:SetTextColor(0.5333, 0.6666, 0.9999, 0.9999)
known:SetPoint("BOTTOMLEFT", tooltip, "BOTTOMLEFT", 6, 12)
known:SetPoint("BOTTOMRIGHT", tooltip, "BOTTOMRIGHT", -6, 12)
known:Show()

local classwarning = tooltip:CreateFontString(nil, "OVERLAY", "GameFontRed")
classwarning:SetWordWrap(true)
classwarning:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 6, -12)
classwarning:SetPoint("TOPRIGHT", tooltip, "TOPRIGHT", -6, -12)
-- ITEM_WRONG_CLASS = "That item can't be used by players of your class!"
-- STAT_USELESS_TOOLTIP = "|cff808080Provides no benefit for your class|r"
classwarning:SetText(ITEM_WRONG_CLASS)
classwarning:Show()

-- Ye showing:
do
    local function GetTooltipItem(tip)
        if _G.C_TooltipInfo then
            return TooltipUtil.GetDisplayedItem(tip)
        end
        return tip:GetItem()
    end
    local function OnTooltipSetItem(self)
        local name, link, id = GetTooltipItem(self)
        AppearanceTooltip:ShowItem(link, self)
    end
    local function OnHide(self)
        AppearanceTooltip:HideItem()
    end

    local tooltips = {}
    function AppearanceTooltip.RegisterTooltip(tip)
        if (not tip) or tooltips[tip] then
            return
        end
        if not _G.C_TooltipInfo then
            tip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
        end
        tip:HookScript("OnHide", OnHide)
        tooltips[tip] = tip
    end

    if _G.C_TooltipInfo then
        -- Cata-classic has TooltipDataProcessor, but doesn't actually use the new tooltips
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(self, data)
            if tooltips[self] then
                OnTooltipSetItem(self)
            end
        end)
    end

    AppearanceTooltip.RegisterTooltip(GameTooltip)
    if GameTooltip.ItemTooltip then
        AppearanceTooltip.RegisterTooltip(GameTooltip.ItemTooltip.Tooltip)
    end
end

----

local positioner = CreateFrame("Frame")
positioner:Hide()
positioner:SetScript("OnShow", function(self)
    -- always run immediately
    self.elapsed = TOOLTIP_UPDATE_TIME
end)
positioner:SetScript("OnUpdate", function(self, elapsed)
    self.elapsed = self.elapsed + elapsed
    if self.elapsed < TOOLTIP_UPDATE_TIME then
        return
    end
    self.elapsed = 0

    local owner, our_point, owner_point = AppearanceTooltip:ComputeTooltipAnchors(tooltip.owner, db.anchor)
    if our_point and owner_point then
        tooltip:ClearAllPoints()
        tooltip:SetPoint(our_point, owner, owner_point)
    end
end)

do
    local points = {
        -- key is the direction our tooltip should be biased, with the first component being the primary (i.e. "on the top side, to the left")
        -- these are [our point, owner point]
        top = {
            left = {"BOTTOMRIGHT", "TOPRIGHT"},
            right = {"BOTTOMLEFT", "TOPLEFT"},
        },
        bottom = {
            left = {"TOPRIGHT", "BOTTOMRIGHT"},
            right = {"TOPLEFT", "BOTTOMLEFT"},
        },
        left = {
            top = {"BOTTOMRIGHT", "BOTTOMLEFT"},
            bottom = {"TOPRIGHT", "TOPLEFT"},
        },
        right = {
            top = {"BOTTOMLEFT", "BOTTOMRIGHT"},
            bottom = {"TOPLEFT", "TOPRIGHT"},
        },
    }
    function AppearanceTooltip:ComputeTooltipAnchors(owner, anchor)
        -- Because I always forget: x is left-right, y is bottom-top
        -- Logic here: our tooltip should trend towards the center of the screen, unless something is stopping it.
        -- If comparison tooltips are shown, we shouldn't overlap them
        local originalOwner = owner
        local x, y = owner:GetCenter()
        if not (x and y) then
            return
        end
        x = x * owner:GetEffectiveScale()
        -- the y comparison doesn't need this:
        -- y = y * owner:GetEffectiveScale()

        local biasLeft, biasDown
        -- we want to follow the direction the tooltip is going, relative to the cursor
        -- print("biasLeft check", x ,"<", GetCursorPosition())
        -- print("biasDown check", y, ">", GetScreenHeight() / 2)
        biasLeft = x < GetCursorPosition()
        biasDown = y > GetScreenHeight() / 2

        local outermostComparisonShown
        if owner.shoppingTooltips then
            local comparisonTooltip1, comparisonTooltip2 = unpack( owner.shoppingTooltips )
            if comparisonTooltip1:IsShown() or comparisonTooltip2:IsShown() then
                if comparisonTooltip1:IsShown() and comparisonTooltip2:IsShown() then
                    if comparisonTooltip1:GetCenter() > comparisonTooltip2:GetCenter() then
                        -- 1 is right of 2
                        outermostComparisonShown = biasLeft and comparisonTooltip2 or comparisonTooltip1
                    else
                        -- 1 is left of 2
                        outermostComparisonShown = biasLeft and comparisonTooltip1 or comparisonTooltip2
                    end
                else
                    outermostComparisonShown = comparisonTooltip1:IsShown() and comparisonTooltip1 or comparisonTooltip2
                end
                local outerx = outermostComparisonShown:GetCenter() * outermostComparisonShown:GetEffectiveScale()
                local ownerx = owner:GetCenter() * owner:GetEffectiveScale()
                if
                    -- outermost is right of owner while we're biasing left
                    (biasLeft and outerx > ownerx)
                    or
                    -- outermost is left of owner while we're biasing right
                    ((not biasLeft) and outerx < ownerx)
                then
                    -- the comparison won't be in the way, so ignore it
                    outermostComparisonShown = nil
                end
            end
        end

        -- print("ApTip bias", biasLeft and "left" or "right", biasDown and "down" or "up")

        local primary, secondary
        if anchor == "vertical" then
            -- attaching to the top/bottom of the tooltip
            -- only care about comparisons to avoid overlapping them
            primary = biasDown and "bottom" or "top"
            if outermostComparisonShown then
                secondary = biasLeft and "right" or "left"
            else
                secondary = biasLeft and "left" or "right"
            end
        else -- horizontal
            primary = biasLeft and "left" or "right"
            secondary = biasDown and "bottom" or "top"
            if outermostComparisonShown then
                if db.byComparison then
                    owner = outermostComparisonShown
                else
                    -- show on the opposite side of the bias, probably overlapping the cursor, since that's better than overlapping the comparison
                    primary = biasLeft and "right" or "left"
                end
            end
        end
        if
            -- would we be pushing against the edge of the screen?
            (primary == "left" and (owner:GetLeft() - tooltip:GetWidth()) < 0)
            or (primary == "right" and (owner:GetRight() + tooltip:GetWidth() > GetScreenWidth()))
        then
            return self:ComputeTooltipAnchors(originalOwner, "vertical")
        end
        return owner, unpack(points[primary][secondary])
    end
end

local spinner = CreateFrame("Frame", nil, tooltip);
spinner:Hide()
spinner:SetScript("OnUpdate", function(self, elapsed)
    if not (tooltip.activeModel and tooltip.activeModel:IsVisible()) then
        return self:Hide()
    end
    tooltip.activeModel:SetFacing(tooltip.activeModel:GetFacing() + elapsed)
end)

local hider = CreateFrame("Frame")
hider:Hide()
local shouldHide = function(owner)
    if not owner then return true end
    if not owner:IsShown() then return true end
    if _G.C_TooltipInfo then
        if not TooltipUtil.GetDisplayedItem(owner) then return true end
    else
        if not owner:GetItem() then return true end
    end
    return false
end
hider:SetScript("OnUpdate", function(self)
    if shouldHide(tooltip.owner) then
        spinner:Hide()
        positioner:Hide()
        tooltip:Hide()
        tooltip.item = nil
    end
    self:Hide()
end)

----

local _, class = UnitClass("player")
local class_colored = RAID_CLASS_COLORS[class]:WrapTextInColorCode(class)
local ATLAS_CHECK, ATLAS_CROSS = "common-icon-checkmark", "common-icon-redx"

local function AddItemToTooltip(itemInfo, for_tooltip, label)
    local name, link, quality, _, _, _, _, _, _, icon = C_Item.GetItemInfo(itemInfo)
    if name then
        if AppearanceTooltip.CanTransmogItem(link) then
            name = name .. CreateAtlasMarkup(AppearanceTooltip.PlayerHasAppearance(link) and ATLAS_CHECK or ATLAS_CROSS)
        end
        for_tooltip:AddDoubleLine(
            label or ITEM_PURCHASED_COLON,
            "|T" .. icon .. ":0|t " .. name,
            1, 1, 0,
            C_Item.GetItemQualityColor(quality)
        )
    else
        for_tooltip:AddDoubleLine(ITEM_PURCHASED_COLON, SEARCH_LOADING_TEXT, 1, 1, 0, 0, 1, 1)
    end
end
function AppearanceTooltip:ShowItem(link, for_tooltip)
    if not link then return end
    for_tooltip = for_tooltip or GameTooltip
    local id = tonumber(link:match("item:(%d+)"))
    if not id or id == 0 then return end
    local token = db.tokens and LAT and LAT:ItemIsToken(id)

    if token then
        -- It's a set token! Replace the id.
        local found
        local counts = {}
        local counts_known = {}
        for itemid, tclass, relevant in LAT:IterateItemsForToken(id) do
            found = found or itemid
            if relevant then
                AddItemToTooltip(itemid, for_tooltip, tclass == class and class_colored or tclass)
            else
                counts[tclass] = (counts[tclass] or 0) + 1
                counts_known[tclass] = (counts_known[tclass] or 0) + (AppearanceTooltip.PlayerHasAppearance(itemid) and 1 or 0)
            end
        end
        for tclass, count in pairs(counts) do
            -- ITEM_PET_KNOWN = "Collected (%d/%d)"
            local label = RAID_CLASS_COLORS[tclass] and RAID_CLASS_COLORS[tclass]:WrapTextInColorCode(tclass) or tclass
            local complete = counts_known[tclass] == counts[tclass]
            for_tooltip:AddDoubleLine(label, ITEM_PET_KNOWN:format(counts_known[tclass], counts[tclass]),
                1, 1, 1,
                complete and 0 or 1, complete and 1 or 0, 0
            )
        end
        if found then
            local _, maybelink = C_Item.GetItemInfo(found)
            if maybelink then
                link = maybelink
                id = found
            end
            for_tooltip:Show()
        end
    end

    local slot = select(9, C_Item.GetItemInfo(id))
    if (not db.modifier or self.modifiers[db.modifier]()) and tooltip.item ~= id then
        tooltip.item = id

        local appropriateItem = LAI:IsAppropriate(id)

        if self.slot_facings[slot] and IsDressableItem(id) and (not db.currentClass or appropriateItem) then
            local model
            local cameraID, itemCamera
            if db.zoomWorn or db.zoomHeld then
                cameraID, itemCamera = self:GetCameraID(id, db.customModel and db.modelRace, db.customModel and db.modelGender)
            end

            tooltip.model:Hide()
            tooltip.modelZoomed:Hide()
            tooltip.modelWeapon:Hide()

            local shouldZoom = (db.zoomHeld and cameraID and itemCamera) or (db.zoomWorn and cameraID and not itemCamera)

            if shouldZoom then
                if itemCamera then
                    model = tooltip.modelWeapon
                    local appearanceID = C_TransmogCollection.GetItemInfo(link)
                    if appearanceID then
                        model:SetItemAppearance(appearanceID)
                    else
                        model:SetItem(id)
                    end
                else
                    model = tooltip.modelZoomed
                    model:SetUseTransmogSkin(db.zoomMasked and slot ~= "INVTYPE_HEAD")
                    self:ResetModel(model)
                end
                model.cameraID = cameraID
                Model_ApplyUICamera(model, cameraID)
                -- ApplyUICamera locks the animation, but...
                model:SetAnimation(0, 0)
            else
                model = tooltip.model

                self:ResetModel(model)
            end
            tooltip.activeModel = model
            model:Show()

            if not cameraID then
                model:SetFacing(self.slot_facings[slot] - (db.rotate and 0.5 or 0))
            end

            tooltip:SetParent(for_tooltip)
            tooltip:Show()
            tooltip.owner = for_tooltip

            positioner:Show()
            spinner:SetShown(db.spin)

            if AppearanceTooltip.slot_removals[slot] and (AppearanceTooltip.always_remove[slot] or db.uncover) then
                -- 1. If this is a weapon, force-remove the item in the main-hand slot! Otherwise it'll get dressed into the
                --    off-hand, maybe, depending on things which are more hassle than it's worth to work out.
                -- 2. Other slots will be entirely covered, making for a useless preview. e.g. shirts.
                for _, slotid in ipairs(AppearanceTooltip.slot_removals[slot]) do
                    if slotid == AppearanceTooltip.SLOT_ROBE then
                        local chest_itemid = GetInventoryItemID("player", AppearanceTooltip.SLOT_CHEST)
                        if chest_itemid and select(4, C_Item.GetItemInfoInstant(chest_itemid)) == 'INVTYPE_ROBE' then
                            slotid = AppearanceTooltip.SLOT_CHEST
                        end
                    end
                    if slotid > 0 then
                        model:UndressSlot(slotid)
                    end
                end
            end
            C_Timer.After(0, function()
                model:TryOn(link)
            end)
        else
            tooltip:Hide()
        end

        classwarning:Hide()
        known:Hide()

        if db.notifyKnown then
            local hasAppearance, appearanceFromOtherItem, probablyEnsemble = AppearanceTooltip.PlayerHasAppearance(link)

            local label
            if not AppearanceTooltip.CanTransmogItem(link) and not probablyEnsemble then
                label = "|c00ffff00" .. TRANSMOGRIFY_INVALID_DESTINATION
            else
                if hasAppearance then
                    if appearanceFromOtherItem then
                        label = "|TInterface\\RaidFrame\\ReadyCheck-Ready:0|t " .. (TRANSMOGRIFY_TOOLTIP_ITEM_UNKNOWN_APPEARANCE_KNOWN):gsub(', ', ',\n')
                    else
                        label = "|TInterface\\RaidFrame\\ReadyCheck-Ready:0|t " .. TRANSMOGRIFY_TOOLTIP_APPEARANCE_KNOWN
                    end
                else
                    label = "|TInterface\\RaidFrame\\ReadyCheck-NotReady:0|t |cffff0000" .. TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN
                end
                classwarning:SetShown(not appropriateItem and not probablyEnsemble)
            end
            known:SetText(label)
            known:Show()
        end
    end
end

function AppearanceTooltip:HideItem()
    hider:Show()
end

function AppearanceTooltip:ResetModel(model)
    -- This sort of works, but with a custom model it keeps some items (shoulders, belt...)
    -- model:SetAutoDress(db.dressed)
    -- So instead, more complicated:
    if db.customModel then
        model:SetUnit("none")
        model:SetCustomRace(db.modelRace, db.modelGender)
    else
        model:SetUnit("player")
    end
    model:RefreshCamera()
    if db.dressed then
        model:Dress()
    else
        model:Undress()
    end
end

AppearanceTooltip.SLOT_MAINHAND = GetInventorySlotInfo("MainHandSlot")
AppearanceTooltip.SLOT_OFFHAND = GetInventorySlotInfo("SecondaryHandSlot")
AppearanceTooltip.SLOT_TABARD = GetInventorySlotInfo("TabardSlot")
AppearanceTooltip.SLOT_CHEST = GetInventorySlotInfo("ChestSlot")
AppearanceTooltip.SLOT_SHIRT = GetInventorySlotInfo("ShirtSlot")
AppearanceTooltip.SLOT_HANDS = GetInventorySlotInfo("HandsSlot")
AppearanceTooltip.SLOT_WAIST = GetInventorySlotInfo("WaistSlot")
AppearanceTooltip.SLOT_SHOULDER = GetInventorySlotInfo("ShoulderSlot")
AppearanceTooltip.SLOT_FEET = GetInventorySlotInfo("FeetSlot")
AppearanceTooltip.SLOT_ROBE = -99 -- Magic!

AppearanceTooltip.slot_removals = {
    INVTYPE_WEAPON = {AppearanceTooltip.SLOT_MAINHAND},
    INVTYPE_2HWEAPON = {AppearanceTooltip.SLOT_MAINHAND},
    INVTYPE_BODY = {AppearanceTooltip.SLOT_TABARD, AppearanceTooltip.SLOT_CHEST, AppearanceTooltip.SLOT_SHOULDER, AppearanceTooltip.SLOT_OFFHAND, AppearanceTooltip.SLOT_WAIST},
    INVTYPE_CHEST = {AppearanceTooltip.SLOT_TABARD, AppearanceTooltip.SLOT_OFFHAND, AppearanceTooltip.SLOT_WAIST, AppearanceTooltip.SLOT_SHIRT},
    INVTYPE_ROBE = {AppearanceTooltip.SLOT_TABARD, AppearanceTooltip.SLOT_WAIST, AppearanceTooltip.SLOT_SHOULDER, AppearanceTooltip.SLOT_OFFHAND},
    INVTYPE_LEGS = {AppearanceTooltip.SLOT_TABARD, AppearanceTooltip.SLOT_WAIST, AppearanceTooltip.SLOT_FEET, AppearanceTooltip.SLOT_ROBE, AppearanceTooltip.SLOT_MAINHAND, AppearanceTooltip.SLOT_OFFHAND},
    INVTYPE_WAIST = {AppearanceTooltip.SLOT_MAINHAND, AppearanceTooltip.SLOT_OFFHAND},
    INVTYPE_FEET = {AppearanceTooltip.SLOT_ROBE},
    INVTYPE_WRIST = {AppearanceTooltip.SLOT_HANDS, AppearanceTooltip.SLOT_CHEST, AppearanceTooltip.SLOT_ROBE, AppearanceTooltip.SLOT_SHIRT, AppearanceTooltip.SLOT_OFFHAND},
    INVTYPE_HAND = {AppearanceTooltip.SLOT_OFFHAND},
    INVTYPE_TABARD = {AppearanceTooltip.SLOT_WAIST, AppearanceTooltip.SLOT_OFFHAND},
    INVTYPE_HEAD = {AppearanceTooltip.SLOT_SHOULDER},
}
AppearanceTooltip.always_remove = {
    INVTYPE_WEAPON = true,
    INVTYPE_2HWEAPON = true,
}

AppearanceTooltip.slot_facings = {
    INVTYPE_HEAD = 0,
    INVTYPE_SHOULDER = 0,
    INVTYPE_CLOAK = 3.4,
    INVTYPE_CHEST = 0,
    INVTYPE_ROBE = 0,
    INVTYPE_WRIST = 0,
    INVTYPE_2HWEAPON = 1.6,
    INVTYPE_WEAPON = 1.6,
    INVTYPE_WEAPONMAINHAND = 1.6,
    INVTYPE_WEAPONOFFHAND = -0.7,
    INVTYPE_SHIELD = -0.7,
    INVTYPE_HOLDABLE = -0.7,
    INVTYPE_RANGED = 1.6,
    INVTYPE_RANGEDRIGHT = 1.6,
    INVTYPE_THROWN = 1.6,
    INVTYPE_HAND = 0,
    INVTYPE_WAIST = 0,
    INVTYPE_LEGS = 0,
    INVTYPE_FEET = 0,
    INVTYPE_TABARD = 0,
    INVTYPE_BODY = 0,
    -- for ensembles, which are dressable but non-equipable
    INVTYPE_NON_EQUIP_IGNORE = 0,
}

AppearanceTooltip.modifiers = {
    Shift = IsShiftKeyDown,
    Ctrl = IsControlKeyDown,
    Alt = IsAltKeyDown,
    None = function() return true end,
}

-- Utility fun

--/dump C_Transmog.GetItemInfo(C_Item.GetItemInfoInstant(""))
function AppearanceTooltip.CanTransmogItem(itemLink)
    local itemID = C_Item.GetItemInfoInstant(itemLink)
    if itemID then
        local canBeChanged, noChangeReason, canBeSource, noSourceReason = C_Transmog.CanTransmogItem(itemID)
        return canBeSource, noSourceReason
    end
end

local brokenItems = {
    -- itemid : {appearanceid, sourceid}
    [153268] = {25124, 90807}, -- Enclave Aspirant's Axe
    [153316] = {25123, 90885}, -- Praetor's Ornamental Edge
}
-- /dump C_TransmogCollection.GetAppearanceSourceInfo(select(2, C_TransmogCollection.GetItemInfo("")))
-- /dump C_TransmogCollection.GetAppearanceInfoBySource(select(2, C_TransmogCollection.GetItemInfo("")))
function AppearanceTooltip.PlayerHasAppearance(itemLinkOrID)
    -- hasAppearance, appearanceFromOtherItem
    local itemID, _, _, _, _, classID, subclassID = C_Item.GetItemInfoInstant(itemLinkOrID)
    if not itemID then return end
    local probablyEnsemble = IsDressableItem(itemID) and not C_Item.IsEquippableItem(itemID)
    if probablyEnsemble then
        -- *not* ERR_COSMETIC_KNOWN which is "Item Known"
        return AppearanceTooltip.CheckTooltipFor(itemID, ITEM_SPELL_KNOWN), false, true
    end
    if db.learnable then
        if C_MountJournal and classID == Enum.ItemClass.Miscellaneous and subclassID == Enum.ItemMiscellaneousSubclass.Mount then
            local mountID = C_MountJournal.GetMountFromItem(itemID)
            return mountID and (select(11, C_MountJournal.GetMountInfoByID(mountID))), false, true
        end
        if C_ToyBox and C_ToyBox.GetToyInfo(itemID)  then
            return PlayerHasToy(itemID), false, true
        end
    end
    local appearanceID, sourceID = C_TransmogCollection.GetItemInfo(itemLinkOrID)
    if not appearanceID then
        -- sometimes the link won't actually give us an appearance, but itemID will
        -- e.g. mythic Drape of Iron Sutures from Shadowmoon Burial Grounds
        appearanceID, sourceID = C_TransmogCollection.GetItemInfo(itemID)
    end
    if not appearanceID and brokenItems[itemID] then
        -- ...and there's a few that just need to be hardcoded
        appearanceID, sourceID = unpack(brokenItems[itemID])
    end
    if not appearanceID then return end
    -- /dump C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(C_TransmogCollection.GetItemInfo(""))
    local fromCurrentItem = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID)
    if fromCurrentItem then
        -- It might *also* be from another item, but we don't care or need to find out
        return true, false
    end
    -- The current item isn't known, but do we know the appearance in general?
    -- We can't use the direct functions for this, because they don't work
    -- for cross-class items, so we just check all the possible sources. This
    -- used to not work because you couldn't request the sources, but since
    -- Warbands were added in 11.0.0 this is now possible.
    local sources = C_TransmogCollection.GetAllAppearanceSources(appearanceID)
    if sources then
        local known_any = false
        for _, sourceID2 in pairs(sources) do
            if C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID2) then
                -- We know it, and it must be from a different source because of the above check
                return true, true
            end
        end
    end
    -- We don't know the appearance from any source
    return false, false
end

function AppearanceTooltip.CheckTooltipFor(itemInfo, text)
    if not _G.C_TooltipInfo then return false end
    local info = C_TooltipInfo[ type(itemInfo) == "number" and "GetItemByID" or "GetHyperlink" ](itemInfo)
    if not info then return false end
    for _, line in ipairs(info.lines) do
        -- print("line", line, line.leftText, line.rightText)
        if line.leftText and string.match(line.leftText, text) then
            return true
        end
    end
    return false
end

do
    local function ColorGradient(perc, ...)
        if perc >= 1 then
            local r, g, b = select(select("#", ...) - 2, ...)
            return r, g, b
        elseif perc <= 0 then
            local r, g, b = ...
            return r, g, b
        end

        local num = select("#", ...) / 3

        local segment, relperc = math.modf(perc*(num-1))
        local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

        return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
    end
    local function rgb2hex(r, g, b)
        if type(r) == "table" then
            g = r.g
            b = r.b
            r = r.r
        end
        return ("%02x%02x%02x"):format(r*255, g*255, b*255)
    end
    function AppearanceTooltip.ColorTextByCompletion(text, perc)
        return ("|cff%s%s|r"):format(rgb2hex(ColorGradient(perc, 1,0,0, 1,1,0, 0,1,0)), text)
    end
end

function AppearanceTooltip.Print(...) print("|cFF33FF99".. "|cff8080ff[幻化]|r预览增强".. "|r:", ...) end

function setDefaults(options, defaults)
    setmetatable(options, { __index = function(t, k)
        if type(defaults[k]) == "table" then
            t[k] = setDefaults({}, defaults[k])
            return t[k]
        end
        return defaults[k]
    end, })
    -- and add defaults to existing tables
    for k, v in pairs(options) do
        if defaults[k] and type(v) == "table" then
            setDefaults(v, defaults[k])
        end
    end
    return options
end


local races = {
    [1] = "Human",
    [3] = "Dwarf",
    [4] = "NightElf",
    [11] = "Draenei",
    [22] = "Worgen",
    [7] = "Gnome",
    [24] = "Pandaren",
    [25] = "Pandaren",
    [26] = "Pandaren",
    [2] = "Orc",
    [5] = "Undead",
    [10] = "BloodElf",
    [8] = "Troll",
    [6] = "Tauren",
    [9] = "Goblin",
    [52] = "Dracthyr",
    [70] = "Dracthyr",
    -- Allied!
    [27] = "Nightborne", -- "Nightborne",
    [28] = "HighmountainTauren", -- "HighmountainTauren",
    [29] = "VoidElf", -- "VoidElf",
    [30] = "LightforgedDraenei", -- "LightforgedDraenei",
    [31] = "ZandalariTroll",
    [32] = "KulTiran",
    [34] = "DarkIronDwarf",
    [35] = "Vulpera",
    [36] = "MagharOrc", -- "MagharOrc",
    [37] = "Mechagnome",
}
local fallback_races = {
    Nightborne = "NightElf", -- Nightborne -> male Blood Elf / female Night Elf
    MagharOrc = "Orc", -- Maghar -> Orc
    LightforgedDraenei = "Draenei", -- Lightforged -> Draenei
    KulTiran = "Human", -- Kul'Tiran -> Human
    HighmountainTauren = "Tauren", -- Highmountain -> Tauren
    VoidElf = "BloodElf", -- Void Elf -> Blood Elf
    Mechagnome = "Gnome", -- Mechagnome -> Gnome
    Vulpera = "Goblin", -- Vulpera -> Goblin
    ZandalariTroll = "Troll", -- Zandalari -> Troll
    DarkIronDwarf = "Dwarf", -- Dark Iron -> Dwarf
    Earthen = "Dwarf", -- Earthen -> Dwarf
    Dracthyr = {"BloodElf", "Human"}, -- Dracthyr -> male Draenei / female Human
}
local genders = {
    [0] = "Male",
    [1] = "Female",
}

local slots = {
    INVTYPE_BODY = "Shirt",
    INVTYPE_CHEST = "Shirt",
    INVTYPE_CLOAK = "Back",
    INVTYPE_FEET = "Feet",
    INVTYPE_HAND = "Hands",
    INVTYPE_HEAD = "Head",
    INVTYPE_LEGS = "Legs",
    INVTYPE_ROBE = "Robe",
    INVTYPE_SHOULDER = "Shoulder",
    -- INVTYPE_SHOULDER = "Shoulder-Alt",
    INVTYPE_TABARD = "Tabard",
    INVTYPE_WAIST = "Waist",
    INVTYPE_WRIST = "Wrist",
}
local item_slots = {
    INVTYPE_2HWEAPON = true,
    INVTYPE_WEAPON = true,
    INVTYPE_WEAPONMAINHAND = true,
    INVTYPE_WEAPONOFFHAND = true,
    INVTYPE_RANGED = true,
    INVTYPE_RANGEDRIGHT = true,
    INVTYPE_HOLDABLE = "Offhand",
    INVTYPE_SHIELD = "Shield",
}
local subclasses = {}
for k,v in pairs(Enum.ItemWeaponSubclass) do
    subclasses[v] = k
end
subclasses[Enum.ItemWeaponSubclass.Fishingpole] = "Staff"
subclasses[Enum.ItemWeaponSubclass.Generic] = "Sword1H"

local _, _, playerRaceID = UnitRace("player")
local playerSex
if UnitSex("player") == 2 then
    playerSex = "Male"
else
    playerSex = "Female"
end

local slots_to_cameraids, slot_override

-- Get a cameraid for Model_ApplyUICamera which will focus a DressUpModel on a specific item
-- itemid: number/string Anything that GetItemInfoInstant will accept
-- race: number raceid
-- gender: number genderid (0: male, 1: female)
function AppearanceTooltip:GetCameraID(itemLinkOrID, raceID, genderID)
    local key, itemcamera
    local itemid, _, _, slot, _, class, subclass = C_Item.GetItemInfoInstant(itemLinkOrID)
    if item_slots[slot] then
        itemcamera = true
        if item_slots[slot] == true then
            key = "Weapon-" .. subclasses[subclass] or subclasses["Generic"]
        else
            key = "Weapon-" .. item_slots[slot]
        end
    else
        local race = races[raceID or playerRaceID]
        local gender = genderID and genders[genderID] or playerSex
        if not raceID then
            -- alt form races need special handling:
            if race == 'Worgen' and select(2, C_PlayerInfo.GetAlternateFormInfo()) then
                race = 'Human'
            end
            if race == 'Dracthyr' and not select(2, C_PlayerInfo.GetAlternateFormInfo()) then
                gender = 'Male'
            end
        end
        --key = ("%s-%s-%s"):format(race, gender, slot_override[itemid] or slots[slot] or "Default")            -----------why bug ????
        if not slots_to_cameraids[key] and fallback_races[race] then
            local fallback = fallback_races[race]
            if type(fallback) == "table" then
                fallback = fallback[genderID == 0 and 1 or 2]
            end
            key = ("%s-%s-%s"):format(fallback, gender, slot_override[itemid] or slots[slot] or "Default")
        end
    end
    return slots_to_cameraids[key], itemcamera
end

slots_to_cameraids = {
    -- the 1h/2h have names altered to fit with the Enum.ItemWeaponSubclass names
    ["Weapon-Axe1H"] = 242,
    ["Weapon-Mace1H"] = 244,
    ["Weapon-Sword1H"] = 238,
    ["Weapon-Axe2H"] = 243,
    ["Weapon-Mace2H"] = 245,
    ["Weapon-Sword2H"] = 239,
    ["Weapon-Bows"] = 251, -- Bow
    ["Weapon-Crossbow"] = 253,
    ["Weapon-Dagger"] = 241,
    ["Weapon-Unarmed"] = 248, -- FistWeapon
    ["Weapon-Warglaive"] = 624, -- Glaive
    ["Weapon-Gun"] = 252,
    ["Weapon-Polearm"] = 247,
    ["Weapon-Shield"] = 249,
    ["Weapon-Staff"] = 246,
    ["Weapon-Wand"] = 240,
    ["Weapon-Offhand"] = 250,
    --
    ["BloodElf-Female-Back"] = 467,
    ["BloodElf-Female-Back-Backpack"] = 1490,
    ["BloodElf-Female-Feet"] = 475,
    ["BloodElf-Female-Hands"] = 472,
    ["BloodElf-Female-Head"] = 465,
    ["BloodElf-Female-Legs"] = 474,
    ["BloodElf-Female-Robe"] = 468,
    ["BloodElf-Female-Shirt"] = 469,
    ["BloodElf-Female-Shoulder"] = 466,
    ["BloodElf-Female-Shoulder-Alt"] = 739,
    ["BloodElf-Female-Tabard"] = 470,
    ["BloodElf-Female-Waist"] = 473,
    ["BloodElf-Female-Wrist"] = 471,
    ["BloodElf-Male-Back"] = 456,
    ["BloodElf-Male-Back-Backpack"] = 1491,
    ["BloodElf-Male-Feet"] = 464,
    ["BloodElf-Male-Hands"] = 461,
    ["BloodElf-Male-Head"] = 454,
    ["BloodElf-Male-Legs"] = 463,
    ["BloodElf-Male-Robe"] = 457,
    ["BloodElf-Male-Shirt"] = 458,
    ["BloodElf-Male-Shoulder"] = 455,
    ["BloodElf-Male-Shoulder-Alt"] = 738,
    ["BloodElf-Male-Tabard"] = 459,
    ["BloodElf-Male-Waist"] = 462,
    ["BloodElf-Male-Wrist"] = 460,
    ["Dracthyr-Male-Back"] = 1706,
    ["Dracthyr-Male-Back-Backpack"] = 1699,
    ["Dracthyr-Male-Feet"] = 1705,
    ["Dracthyr-Male-Hands"] = 1708,
    ["Dracthyr-Male-Head"] = 1702,
    ["Dracthyr-Male-Legs"] = 1701,
    ["Dracthyr-Male-Robe"] = 1698,
    ["Dracthyr-Male-Shirt"] = 1709,
    ["Dracthyr-Male-Shoulder"] = 1704,
    ["Dracthyr-Male-Shoulder-Alt"] = 1703,
    ["Dracthyr-Male-Tabard"] = 1707,
    ["Dracthyr-Male-Waist"] = 1700,
    ["Dracthyr-Male-Wrist"] = 1711,
    ["Draenei-Female-Back"] = 345,
    ["Draenei-Female-Back-Backpack"] = 1492,
    ["Draenei-Female-Feet"] = 358,
    ["Draenei-Female-Hands"] = 352,
    ["Draenei-Female-Head"] = 342,
    ["Draenei-Female-Legs"] = 356,
    ["Draenei-Female-Robe"] = 347,
    ["Draenei-Female-Shirt"] = 348,
    ["Draenei-Female-Shoulder"] = 343,
    ["Draenei-Female-Shoulder-Alt"] = 730,
    ["Draenei-Female-Tabard"] = 349,
    ["Draenei-Female-Waist"] = 355,
    ["Draenei-Female-Wrist"] = 350,
    ["Draenei-Male-Back"] = 333,
    ["Draenei-Male-Back-Backpack"] = 1493,
    ["Draenei-Male-Chest"] = 677,
    ["Draenei-Male-Feet"] = 341,
    ["Draenei-Male-Hands"] = 338,
    ["Draenei-Male-Head"] = 331,
    ["Draenei-Male-Legs"] = 340,
    ["Draenei-Male-Robe"] = 334,
    ["Draenei-Male-Shirt"] = 335,
    ["Draenei-Male-Shoulder"] = 332,
    ["Draenei-Male-Shoulder-Alt"] = 729,
    ["Draenei-Male-Tabard"] = 336,
    ["Draenei-Male-Waist"] = 339,
    ["Draenei-Male-Wrist"] = 337,
    ["Dwarf-Female-Back"] = 376,
    ["Dwarf-Female-Back-Backpack"] = 1494,
    ["Dwarf-Female-Feet"] = 384,
    ["Dwarf-Female-Hands"] = 381,
    ["Dwarf-Female-Head"] = 374,
    ["Dwarf-Female-Legs"] = 383,
    ["Dwarf-Female-Robe"] = 377,
    ["Dwarf-Female-Shirt"] = 378,
    ["Dwarf-Female-Shoulder"] = 375,
    ["Dwarf-Female-Shoulder-Alt"] = 809,
    ["Dwarf-Female-Tabard"] = 379,
    ["Dwarf-Female-Waist"] = 382,
    ["Dwarf-Female-Wrist"] = 380,
    ["Dwarf-Male-Back"] = 365,
    ["Dwarf-Male-Back-Backpack"] = 1495,
    ["Dwarf-Male-Feet"] = 373,
    ["Dwarf-Male-Hands"] = 370,
    ["Dwarf-Male-Head"] = 363,
    ["Dwarf-Male-Legs"] = 372,
    ["Dwarf-Male-Robe"] = 366,
    ["Dwarf-Male-Shirt"] = 367,
    ["Dwarf-Male-Shoulder"] = 364,
    ["Dwarf-Male-Shoulder-Alt"] = 731,
    ["Dwarf-Male-Tabard"] = 368,
    ["Dwarf-Male-Waist"] = 371,
    ["Dwarf-Male-Wrist"] = 369,
    ["Earthen-Female-Head"] = 1820,
    ["Earthen-Female-Shoulder"] = 1821,
    ["Earthen-Female-Shoulder-Alt"] = 1822,
    ["Earthen-Female-Shirt"] = 1823,
    ["Earthen-Female-Tabard"] = 1824,
    ["Earthen-Female-Wrist"] = 1825,
    ["Earthen-Female-Hands"] = 1826,
    ["Earthen-Female-Back-Backpack"] = 1827,
    ["Earthen-Female-Legs"] = 1828,
    ["Earthen-Male-Head"] = 1829,
    ["Earthen-Male-Shoulder"] = 1830,
    ["Earthen-Male-Shoulder-Alt"] = 1831,
    ["Earthen-Male-Back-Backpack"] = 1832,
    ["Earthen-Male-Shirt"] = 1833,
    ["Earthen-Male-Tabard"] = 1834,
    ["Earthen-Male-Wrist"] = 1835,
    ["Earthen-Male-Wrist-Alt"] = 1836,
    ["Earthen-Male-Hands"] = 1837,
    ["Earthen-Male-Legs"] = 1838,
    ["Earthen-Male-Feet"] = 1839,
    ["Gnome-Female-Back"] = 401,
    ["Gnome-Female-Back-Backpack"] = 1496,
    ["Gnome-Female-Feet"] = 409,
    ["Gnome-Female-Hands"] = 406,
    ["Gnome-Female-Head"] = 399,
    ["Gnome-Female-Legs"] = 408,
    ["Gnome-Female-Robe"] = 402,
    ["Gnome-Female-Shirt"] = 403,
    ["Gnome-Female-Shoulder"] = 400,
    ["Gnome-Female-Shoulder-Alt"] = 733,
    ["Gnome-Female-Tabard"] = 404,
    ["Gnome-Female-Waist"] = 407,
    ["Gnome-Female-Wrist"] = 405,
    ["Gnome-Male-Back"] = 387,
    ["Gnome-Male-Back-Backpack"] = 1497,
    ["Gnome-Male-Feet"] = 398,
    ["Gnome-Male-Hands"] = 395,
    ["Gnome-Male-Head"] = 385,
    ["Gnome-Male-Legs"] = 397,
    ["Gnome-Male-Robe"] = 389,
    ["Gnome-Male-Shirt"] = 390,
    ["Gnome-Male-Shoulder"] = 386,
    ["Gnome-Male-Shoulder-Alt"] = 732,
    ["Gnome-Male-Tabard"] = 393,
    ["Gnome-Male-Waist"] = 396,
    ["Gnome-Male-Wrist"] = 394,
    ["Goblin-Female-Back"] = 445,
    ["Goblin-Female-Back-Backpack"] = 1498,
    ["Goblin-Female-Feet"] = 453,
    ["Goblin-Female-Hands"] = 450,
    ["Goblin-Female-Head"] = 443,
    ["Goblin-Female-Legs"] = 452,
    ["Goblin-Female-Robe"] = 446,
    ["Goblin-Female-Shirt"] = 447,
    ["Goblin-Female-Shoulder"] = 444,
    ["Goblin-Female-Shoulder-Alt"] = 737,
    ["Goblin-Female-Tabard"] = 448,
    ["Goblin-Female-Waist"] = 451,
    ["Goblin-Female-Wrist"] = 449,
    ["Goblin-Male-Back"] = 434,
    ["Goblin-Male-Back-Backpack"] = 1499,
    ["Goblin-Male-Feet"] = 442,
    ["Goblin-Male-Hands"] = 439,
    ["Goblin-Male-Head"] = 432,
    ["Goblin-Male-Legs"] = 441,
    ["Goblin-Male-Robe"] = 435,
    ["Goblin-Male-Shirt"] = 436,
    ["Goblin-Male-Shoulder"] = 433,
    ["Goblin-Male-Shoulder-Alt"] = 736,
    ["Goblin-Male-Tabard"] = 437,
    ["Goblin-Male-Waist"] = 440,
    ["Goblin-Male-Wrist"] = 438,
    ["HighmountainTauren-Female-Back"] = 1207,
    ["HighmountainTauren-Female-Back-Backpack"] = 1500,
    ["HighmountainTauren-Female-Feet"] = 1206,
    ["HighmountainTauren-Female-Hands"] = 1205,
    ["HighmountainTauren-Female-Head"] = 1204,
    ["HighmountainTauren-Female-Legs"] = 1203,
    ["HighmountainTauren-Female-Robe"] = 1202,
    ["HighmountainTauren-Female-Shirt"] = 1201,
    ["HighmountainTauren-Female-Shoulder"] = 1200,
    ["HighmountainTauren-Female-Shoulder-Alt"] = 1199,
    ["HighmountainTauren-Female-Tabard"] = 1198,
    ["HighmountainTauren-Female-Waist"] = 1197,
    ["HighmountainTauren-Female-Wrist"] = 1196,
    ["HighmountainTauren-Male-Back"] = 1195,
    ["HighmountainTauren-Male-Back-Backpack"] = 1501,
    ["HighmountainTauren-Male-Feet"] = 1194,
    ["HighmountainTauren-Male-Hands"] = 1193,
    ["HighmountainTauren-Male-Head"] = 1192,
    ["HighmountainTauren-Male-Legs"] = 1191,
    ["HighmountainTauren-Male-Robe"] = 1190,
    ["HighmountainTauren-Male-Shirt"] = 1189,
    ["HighmountainTauren-Male-Shoulder"] = 1188,
    ["HighmountainTauren-Male-Shoulder-Alt"] = 1187,
    ["HighmountainTauren-Male-Tabard"] = 1186,
    ["HighmountainTauren-Male-Waist"] = 1185,
    ["HighmountainTauren-Male-Wrist"] = 1184,
    ["Human-Female-Back"] = 276,
    ["Human-Female-Back-Backpack"] = 1502,
    ["Human-Female-Feet"] = 284,
    ["Human-Female-Hands"] = 281,
    ["Human-Female-Head"] = 274,
    ["Human-Female-Legs"] = 283,
    ["Human-Female-Robe"] = 277,
    ["Human-Female-Shirt"] = 278,
    ["Human-Female-Shoulder"] = 275,
    ["Human-Female-Shoulder-Alt"] = 724,
    ["Human-Female-Tabard"] = 279,
    ["Human-Female-Waist"] = 282,
    ["Human-Female-Wrist"] = 280,
    ["Human-Male-Back"] = 235,
    ["Human-Male-Back-Backpack"] = 1503,
    ["Human-Male-Chest"] = 674,
    ["Human-Male-Feet"] = 227,
    ["Human-Male-Hands"] = 226,
    ["Human-Male-Head"] = 236,
    ["Human-Male-Legs"] = 228,
    ["Human-Male-Robe"] = 225,
    ["Human-Male-Shirt"] = 229,
    ["Human-Male-Shoulder"] = 221,
    ["Human-Male-Shoulder-Alt"] = 723,
    ["Human-Male-Tabard"] = 230,
    ["Human-Male-Waist"] = 234,
    ["Human-Male-Wrist"] = 237,
    ["KulTiran-Female-Back"] = 1406,
    ["KulTiran-Female-Back-Backpack"] = 1504,
    ["KulTiran-Female-Chest"] = 1407,
    ["KulTiran-Female-Feet"] = 1413,
    ["KulTiran-Female-Hands"] = 1410,
    ["KulTiran-Female-Head"] = 1403,
    ["KulTiran-Female-Legs"] = 1412,
    ["KulTiran-Female-Robe"] = 1414,
    ["KulTiran-Female-Shoulder"] = 1404,
    ["KulTiran-Female-Shoulder-Alt"] = 1405,
    ["KulTiran-Female-Tabard"] = 1408,
    ["KulTiran-Female-Waist"] = 1411,
    ["KulTiran-Female-Wrist"] = 1409,
    ["KulTiran-Male-Back"] = 1393,
    ["KulTiran-Male-Back-Backpack"] = 1505,
    ["KulTiran-Male-Chest"] = 1394,
    ["KulTiran-Male-Feet"] = 1400,
    ["KulTiran-Male-Hands"] = 1397,
    ["KulTiran-Male-Head"] = 1383,
    ["KulTiran-Male-Legs"] = 1399,
    ["KulTiran-Male-Robe"] = 1401,
    ["KulTiran-Male-Shoulder"] = 1384,
    ["KulTiran-Male-Shoulder-Alt"] = 1402,
    ["KulTiran-Male-Tabard"] = 1395,
    ["KulTiran-Male-Waist"] = 1398,
    ["KulTiran-Male-Wrist"] = 1396,
    ["LightforgedDraenei-Female-Back"] = 1151,
    ["LightforgedDraenei-Female-Back-Backpack"] = 1506,
    ["LightforgedDraenei-Female-Feet"] = 1150,
    ["LightforgedDraenei-Female-Hands"] = 1149,
    ["LightforgedDraenei-Female-Head"] = 1148,
    ["LightforgedDraenei-Female-Legs"] = 1147,
    ["LightforgedDraenei-Female-Robe"] = 1146,
    ["LightforgedDraenei-Female-Shirt"] = 1145,
    ["LightforgedDraenei-Female-Shoulder"] = 1144,
    ["LightforgedDraenei-Female-Shoulder-Alt"] = 1143,
    ["LightforgedDraenei-Female-Tabard"] = 1142,
    ["LightforgedDraenei-Female-Waist"] = 1141,
    ["LightforgedDraenei-Female-Wrist"] = 1140,
    ["LightforgedDraenei-Male-Back"] = 1139,
    ["LightforgedDraenei-Male-Back-Backpack"] = 1507,
    ["LightforgedDraenei-Male-Chest"] = 1138,
    ["LightforgedDraenei-Male-Feet"] = 1137,
    ["LightforgedDraenei-Male-Hands"] = 1136,
    ["LightforgedDraenei-Male-Head"] = 1135,
    ["LightforgedDraenei-Male-Legs"] = 1134,
    ["LightforgedDraenei-Male-Robe"] = 1133,
    ["LightforgedDraenei-Male-Shirt"] = 1132,
    ["LightforgedDraenei-Male-Shoulder"] = 1131,
    ["LightforgedDraenei-Male-Shoulder-Alt"] = 1130,
    ["LightforgedDraenei-Male-Tabard"] = 1129,
    ["LightforgedDraenei-Male-Waist"] = 1128,
    ["LightforgedDraenei-Male-Wrist"] = 1127,
    ["MagharOrc-Male-Back"] = 1361,
    ["MagharOrc-Male-Back-Backpack"] = 1508,
    ["MagharOrc-Male-Feet"] = 1369,
    ["MagharOrc-Male-Hands"] = 1366,
    ["MagharOrc-Male-Head"] = 1359,
    ["MagharOrc-Male-Legs"] = 1368,
    ["MagharOrc-Male-Robe"] = 1362,
    ["MagharOrc-Male-Shirt"] = 1363,
    ["MagharOrc-Male-Shoulder"] = 1360,
    ["MagharOrc-Male-Tabard"] = 1364,
    ["MagharOrc-Male-Waist"] = 1367,
    ["MagharOrc-Male-Wrist"] = 1365,
    ["Mechagnome-Female-Hands"] = 1534,
    ["Mechagnome-Male-Hands"] = 1533,
    ["Nightborne-Female-Back"] = 1099,
    ["Nightborne-Female-Back-Backpack"] = 1509,
    ["Nightborne-Female-Feet"] = 1106,
    ["Nightborne-Female-Hands"] = 1103,
    ["Nightborne-Female-Head"] = 1096,
    ["Nightborne-Female-Legs"] = 1105,
    ["Nightborne-Female-Robe"] = 1107,
    ["Nightborne-Female-Shirt"] = 1100,
    ["Nightborne-Female-Shoulder"] = 1097,
    ["Nightborne-Female-Shoulder-Alt"] = 1098,
    ["Nightborne-Female-Tabard"] = 1101,
    ["Nightborne-Female-Waist"] = 1104,
    ["Nightborne-Female-Wrist"] = 1102,
    ["Nightborne-Male-Back"] = 1183,
    ["Nightborne-Male-Back-Backpack"] = 1510,
    ["Nightborne-Male-Feet"] = 1095,
    ["Nightborne-Male-Hands"] = 1182,
    ["Nightborne-Male-Head"] = 1090,
    ["Nightborne-Male-Legs"] = 1181,
    ["Nightborne-Male-Robe"] = 1091,
    ["Nightborne-Male-Shirt"] = 1092,
    ["Nightborne-Male-Shoulder"] = 1180,
    ["Nightborne-Male-Shoulder-Alt"] = 1179,
    ["Nightborne-Male-Tabard"] = 1178,
    ["Nightborne-Male-Waist"] = 1177,
    ["Nightborne-Male-Wrist"] = 1176,
    ["NightElf-Female-Back"] = 423,
    ["NightElf-Female-Back-Backpack"] = 1511,
    ["NightElf-Female-Feet"] = 431,
    ["NightElf-Female-Hands"] = 428,
    ["NightElf-Female-Head"] = 421,
    ["NightElf-Female-Legs"] = 430,
    ["NightElf-Female-Robe"] = 424,
    ["NightElf-Female-Shirt"] = 425,
    ["NightElf-Female-Shoulder"] = 422,
    ["NightElf-Female-Shoulder-Alt"] = 735,
    ["NightElf-Female-Tabard"] = 426,
    ["NightElf-Female-Waist"] = 429,
    ["NightElf-Female-Wrist"] = 427,
    ["NightElf-Male-Back"] = 412,
    ["NightElf-Male-Back-Backpack"] = 1512,
    ["NightElf-Male-Feet"] = 420,
    ["NightElf-Male-Hands"] = 417,
    ["NightElf-Male-Head"] = 410,
    ["NightElf-Male-Legs"] = 419,
    ["NightElf-Male-Robe"] = 413,
    ["NightElf-Male-Shirt"] = 414,
    ["NightElf-Male-Shoulder"] = 411,
    ["NightElf-Male-Shoulder-Alt"] = 734,
    ["NightElf-Male-Tabard"] = 415,
    ["NightElf-Male-Waist"] = 418,
    ["NightElf-Male-Wrist"] = 416,
    ["Orc-Female-Back"] = 489,
    ["Orc-Female-Back-Backpack"] = 1513,
    ["Orc-Female-Feet"] = 497,
    ["Orc-Female-Hands"] = 494,
    ["Orc-Female-Head"] = 487,
    ["Orc-Female-Legs"] = 496,
    ["Orc-Female-Robe"] = 490,
    ["Orc-Female-Shirt"] = 491,
    ["Orc-Female-Shoulder"] = 488,
    ["Orc-Female-Shoulder-Alt"] = 741,
    ["Orc-Female-Tabard"] = 492,
    ["Orc-Female-Waist"] = 495,
    ["Orc-Female-Wrist"] = 493,
    ["Orc-Male-Back"] = 478,
    ["Orc-Male-Back-Backpack"] = 1514,
    ["Orc-Male-Feet"] = 486,
    ["Orc-Male-Hands"] = 483,
    ["Orc-Male-Head"] = 476,
    ["Orc-Male-Legs"] = 485,
    ["Orc-Male-Robe"] = 479,
    ["Orc-Male-Shirt"] = 480,
    ["Orc-Male-Shoulder"] = 477,
    ["Orc-Male-Shoulder-Alt"] = 740,
    ["Orc-Male-Tabard"] = 481,
    ["Orc-Male-Waist"] = 484,
    ["Orc-Male-Wrist"] = 482,
    ["Pandaren-Female-Back"] = 300,
    ["Pandaren-Female-Back-Backpack"] = 1515,
    ["Pandaren-Female-Chest"] = 676,
    ["Pandaren-Female-Feet"] = 308,
    ["Pandaren-Female-Hands"] = 305,
    ["Pandaren-Female-Head"] = 298,
    ["Pandaren-Female-Legs"] = 307,
    ["Pandaren-Female-Robe"] = 301,
    ["Pandaren-Female-Shirt"] = 302,
    ["Pandaren-Female-Shoulder"] = 299,
    ["Pandaren-Female-Shoulder-Alt"] = 726,
    ["Pandaren-Female-Tabard"] = 303,
    ["Pandaren-Female-Waist"] = 306,
    ["Pandaren-Female-Wrist"] = 304,
    ["Pandaren-Male-Back"] = 287,
    ["Pandaren-Male-Back-Backpack"] = 1516,
    ["Pandaren-Male-Chest"] = 675,
    ["Pandaren-Male-Feet"] = 295,
    ["Pandaren-Male-Hands"] = 292,
    ["Pandaren-Male-Head"] = 285,
    ["Pandaren-Male-Legs"] = 294,
    ["Pandaren-Male-Robe"] = 288,
    ["Pandaren-Male-Shirt"] = 289,
    ["Pandaren-Male-Shoulder"] = 286,
    ["Pandaren-Male-Shoulder-Alt"] = 725,
    ["Pandaren-Male-Tabard"] = 290,
    ["Pandaren-Male-Waist"] = 293,
    ["Pandaren-Male-Wrist"] = 291,
    ["Tauren-Female-Back"] = 511,
    ["Tauren-Female-Back-Backpack"] = 1517,
    ["Tauren-Female-Feet"] = 519,
    ["Tauren-Female-Hands"] = 516,
    ["Tauren-Female-Head"] = 509,
    ["Tauren-Female-Legs"] = 518,
    ["Tauren-Female-Robe"] = 512,
    ["Tauren-Female-Shirt"] = 513,
    ["Tauren-Female-Shoulder"] = 510,
    ["Tauren-Female-Shoulder-Alt"] = 743,
    ["Tauren-Female-Tabard"] = 514,
    ["Tauren-Female-Waist"] = 517,
    ["Tauren-Female-Wrist"] = 515,
    ["Tauren-Male-Back"] = 500,
    ["Tauren-Male-Back-Backpack"] = 1518,
    ["Tauren-Male-Feet"] = 508,
    ["Tauren-Male-Hands"] = 505,
    ["Tauren-Male-Head"] = 498,
    ["Tauren-Male-Legs"] = 507,
    ["Tauren-Male-Robe"] = 501,
    ["Tauren-Male-Shirt"] = 502,
    ["Tauren-Male-Shoulder"] = 499,
    ["Tauren-Male-Shoulder-Alt"] = 742,
    ["Tauren-Male-Tabard"] = 503,
    ["Tauren-Male-Waist"] = 506,
    ["Tauren-Male-Wrist"] = 504,
    ["Troll-Female-Back"] = 533,
    ["Troll-Female-Back-Backpack"] = 1519,
    ["Troll-Female-Feet"] = 541,
    ["Troll-Female-Hands"] = 538,
    ["Troll-Female-Head"] = 531,
    ["Troll-Female-Legs"] = 540,
    ["Troll-Female-Robe"] = 534,
    ["Troll-Female-Shirt"] = 535,
    ["Troll-Female-Shoulder"] = 532,
    ["Troll-Female-Shoulder-Alt"] = 745,
    ["Troll-Female-Tabard"] = 536,
    ["Troll-Female-Waist"] = 539,
    ["Troll-Female-Wrist"] = 537,
    ["Troll-Male-Back"] = 522,
    ["Troll-Male-Back-Backpack"] = 1520,
    ["Troll-Male-Chest"] = 689,
    ["Troll-Male-Feet"] = 530,
    ["Troll-Male-Hands"] = 527,
    ["Troll-Male-Head"] = 520,
    ["Troll-Male-Legs"] = 529,
    ["Troll-Male-Robe"] = 523,
    ["Troll-Male-Shirt"] = 524,
    ["Troll-Male-Shoulder"] = 521,
    ["Troll-Male-Shoulder-Alt"] = 744,
    ["Troll-Male-Tabard"] = 525,
    ["Troll-Male-Waist"] = 528,
    ["Troll-Male-Wrist"] = 526,
    ["Undead-Female-Back"] = 555,
    ["Undead-Female-Back-Backpack"] = 1521,
    ["Undead-Female-Feet"] = 563,
    ["Undead-Female-Hands"] = 560,
    ["Undead-Female-Head"] = 553,
    ["Undead-Female-Legs"] = 562,
    ["Undead-Female-Robe"] = 556,
    ["Undead-Female-Shirt"] = 557,
    ["Undead-Female-Shoulder"] = 554,
    ["Undead-Female-Shoulder-Alt"] = 747,
    ["Undead-Female-Tabard"] = 558,
    ["Undead-Female-Waist"] = 561,
    ["Undead-Female-Wrist"] = 559,
    ["Undead-Male-Back"] = 544,
    ["Undead-Male-Back-Backpack"] = 1522,
    ["Undead-Male-Chest"] = 690,
    ["Undead-Male-Feet"] = 552,
    ["Undead-Male-Hands"] = 549,
    ["Undead-Male-Head"] = 542,
    ["Undead-Male-Legs"] = 551,
    ["Undead-Male-Robe"] = 545,
    ["Undead-Male-Shirt"] = 546,
    ["Undead-Male-Shoulder"] = 543,
    ["Undead-Male-Shoulder-Alt"] = 746,
    ["Undead-Male-Tabard"] = 547,
    ["Undead-Male-Waist"] = 550,
    ["Undead-Male-Wrist"] = 548,
    ["VoidElf-Female-Back"] = 1175,
    ["VoidElf-Female-Back-Backpack"] = 1523,
    ["VoidElf-Female-Feet"] = 1174,
    ["VoidElf-Female-Hands"] = 1173,
    ["VoidElf-Female-Head"] = 1172,
    ["VoidElf-Female-Legs"] = 1171,
    ["VoidElf-Female-Robe"] = 1170,
    ["VoidElf-Female-Shirt"] = 1169,
    ["VoidElf-Female-Shoulder"] = 1168,
    ["VoidElf-Female-Shoulder-Alt"] = 1167,
    ["VoidElf-Female-Tabard"] = 1166,
    ["VoidElf-Female-Waist"] = 1165,
    ["VoidElf-Female-Wrist"] = 1164,
    ["VoidElf-Male-Back"] = 1163,
    ["VoidElf-Male-Back-Backpack"] = 1524,
    ["VoidElf-Male-Feet"] = 1162,
    ["VoidElf-Male-Hands"] = 1161,
    ["VoidElf-Male-Head"] = 1160,
    ["VoidElf-Male-Legs"] = 1159,
    ["VoidElf-Male-Robe"] = 1158,
    ["VoidElf-Male-Shirt"] = 1157,
    ["VoidElf-Male-Shoulder"] = 1156,
    ["VoidElf-Male-Shoulder-Alt"] = 1155,
    ["VoidElf-Male-Tabard"] = 1154,
    ["VoidElf-Male-Waist"] = 1153,
    ["VoidElf-Male-Wrist"] = 1152,
    ["Vulpera-Female-Back"] = 1477,
    ["Vulpera-Female-Back-Backpack"] = 1525,
    ["Vulpera-Female-Feet"] = 1484,
    ["Vulpera-Female-Hands"] = 1481,
    ["Vulpera-Female-Head"] = 1474,
    ["Vulpera-Female-Legs"] = 1483,
    ["Vulpera-Female-Robe"] = 1485,
    ["Vulpera-Female-Shirt"] = 1478,
    ["Vulpera-Female-Shoulder"] = 1475,
    ["Vulpera-Female-Shoulder-Alt"] = 1476,
    ["Vulpera-Female-Tabard"] = 1479,
    ["Vulpera-Female-Waist"] = 1482,
    ["Vulpera-Female-Wrist"] = 1480,
    ["Vulpera-Male-Back"] = 1466,
    ["Vulpera-Male-Back-Backpack"] = 1526,
    ["Vulpera-Male-Feet"] = 1473,
    ["Vulpera-Male-Hands"] = 1470,
    ["Vulpera-Male-Head"] = 1463,
    ["Vulpera-Male-Legs"] = 1472,
    ["Vulpera-Male-Shirt"] = 1467,
    ["Vulpera-Male-Shoulder"] = 1464,
    ["Vulpera-Male-Shoulder-Alt"] = 1465,
    ["Vulpera-Male-Tabard"] = 1468,
    ["Vulpera-Male-Waist"] = 1471,
    ["Vulpera-Male-Wrist"] = 1469,
    ["Worgen-Female-Back"] = 322,
    ["Worgen-Female-Back-Backpack"] = 1527,
    ["Worgen-Female-Feet"] = 330,
    ["Worgen-Female-Hands"] = 327,
    ["Worgen-Female-Head"] = 320,
    ["Worgen-Female-Legs"] = 329,
    ["Worgen-Female-Robe"] = 323,
    ["Worgen-Female-Shirt"] = 324,
    ["Worgen-Female-Shoulder"] = 321,
    ["Worgen-Female-Shoulder-Alt"] = 728,
    ["Worgen-Female-Tabard"] = 325,
    ["Worgen-Female-Waist"] = 328,
    ["Worgen-Female-Wrist"] = 326,
    ["Worgen-Male-Back"] = 311,
    ["Worgen-Male-Back-Backpack"] = 1528,
    ["Worgen-Male-Feet"] = 319,
    ["Worgen-Male-Hands"] = 316,
    ["Worgen-Male-Head"] = 309,
    ["Worgen-Male-Legs"] = 318,
    ["Worgen-Male-Robe"] = 312,
    ["Worgen-Male-Shirt"] = 313,
    ["Worgen-Male-Shoulder"] = 310,
    ["Worgen-Male-Shoulder-Alt"] = 727,
    ["Worgen-Male-Tabard"] = 314,
    ["Worgen-Male-Waist"] = 317,
    ["Worgen-Male-Wrist"] = 315,
    ["ZandalariTroll-Female-Back"] = 1430,
    ["ZandalariTroll-Female-Back-Backpack"] = 1529,
    ["ZandalariTroll-Female-Chest"] = 1431,
    ["ZandalariTroll-Female-Feet"] = 1437,
    ["ZandalariTroll-Female-Hands"] = 1434,
    ["ZandalariTroll-Female-Head"] = 1427,
    ["ZandalariTroll-Female-Legs"] = 1436,
    ["ZandalariTroll-Female-Robe"] = 1438,
    ["ZandalariTroll-Female-Shoulder"] = 1428,
    ["ZandalariTroll-Female-Shoulder-Alt"] = 1429,
    ["ZandalariTroll-Female-Tabard"] = 1432,
    ["ZandalariTroll-Female-Waist"] = 1435,
    ["ZandalariTroll-Female-Wrist"] = 1433,
    ["ZandalariTroll-Male-Back"] = 1418,
    ["ZandalariTroll-Male-Back-Backpack"] = 1530,
    ["ZandalariTroll-Male-Chest"] = 1419,
    ["ZandalariTroll-Male-Feet"] = 1425,
    ["ZandalariTroll-Male-Hands"] = 1422,
    ["ZandalariTroll-Male-Head"] = 1415,
    ["ZandalariTroll-Male-Legs"] = 1424,
    ["ZandalariTroll-Male-Robe"] = 1426,
    ["ZandalariTroll-Male-Shoulder"] = 1416,
    ["ZandalariTroll-Male-Shoulder-Alt"] = 1417,
    ["ZandalariTroll-Male-Tabard"] = 1420,
    ["ZandalariTroll-Male-Waist"] = 1423,
    ["ZandalariTroll-Male-Wrist"] = 1421,
}

slot_override = {
    -- Cloth
    -- appearance 21971
    [106545] = "Shoulder-Alt", -- Orunai Shoulderpads
    [106578] = "Shoulder-Alt", -- Gordunni Shoulderpads
    [112610] = "Shoulder-Alt", -- Steamburst Mantle
    [114271] = "Shoulder-Alt", -- Firefly mantle
    -- appearance 21620
    [106479] = "Shoulder-Alt", -- Iyun Shoulderpads
    [106512] = "Shoulder-Alt", -- Mandragoran Shoulderpads
    [107317] = "Shoulder-Alt", -- Karabor Sage Mantle
    [112086] = "Shoulder-Alt", -- Windburnt Pauldrons
    [106162] = "Shoulder-Alt", -- Frostwolf Wind-Talker Mantle
    -- appearance 21962
    [106413] = "Shoulder-Alt", -- Lunarglow Shoulderpads
    [106446] = "Shoulder-Alt", -- Anchorite Shoulderpads
    [112531] = "Shoulder-Alt", -- Auchenai Keeper Mantle
    -- Leather
    -- [] = "Shoulder-Alt", --
    -- Mail
    [7718] = "Shoulder-Alt", -- Herod's Shoulder
    [122356] = "Shoulder-Alt", -- Champion Herod's Shoulder
    [88271] = "Shoulder-Alt", -- Harlan's Shoulders
    -- Plate
    [140617] = "Shoulder-Alt", -- Rakeesh's Pauldron
    -- backpacks:
    [174361] = "Back-Backpack", -- Black Dragonscale Backpack
    [180939] = "Back-Backpack", -- Mantle of the Forgemaster's Dark Blades
    [180940] = "Back-Backpack", -- Ebony Crypt Keeper's Mantle
    [180941] = "Back-Backpack", -- Kael's Dark Sinstone Chain
    [181286] = "Back-Backpack", -- Halo of the Selfless
    [181287] = "Back-Backpack", -- Halo of the Reverent
    [181288] = "Back-Backpack", -- Halo of the Harmonious
    [181289] = "Back-Backpack", -- Halo of the Discordant
    [181290] = "Back-Backpack", -- Harmonious Sigil of the Archon
    [181291] = "Back-Backpack", -- Selfless Sigil of the Archon
    [181292] = "Back-Backpack", -- Discordant Sigil of the Archon
    [181293] = "Back-Backpack", -- Reverent Sigil of the Archon
    [181294] = "Back-Backpack", -- Harmonious Wings of the Ascended
    [181295] = "Back-Backpack", -- Selfless Wings of the Ascended
    [181296] = "Back-Backpack", -- Discordant Wings of the Ascended
    [181297] = "Back-Backpack", -- Reverent Wings of the Ascended
    [181301] = "Back-Backpack", -- Faewoven Branches
    [181302] = "Back-Backpack", -- Spirit Tender's Branches
    [181303] = "Back-Backpack", -- Night Courtier's Branches
    [181304] = "Back-Backpack", -- Winterwoven Branches
    [181305] = "Back-Backpack", -- Faewoven Bulb
    [181306] = "Back-Backpack", -- Spirit Tender's Bulb
    [181308] = "Back-Backpack", -- Winterwoven Bulb
    [181309] = "Back-Backpack", -- Faewoven Pack
    [181310] = "Back-Backpack", -- Spirit Tender's Pack
    [181312] = "Back-Backpack", -- Winterwoven Pack
    [181800] = "Back-Backpack", -- Standard of the Blackhound Warband
    [181801] = "Back-Backpack", -- Standard of the Necrolords
    [181802] = "Back-Backpack", -- Standard of Death's Chosen
    [181803] = "Back-Backpack", -- Bladesworn Battle Standard
    [181804] = "Back-Backpack", -- Trophy of the Reborn Bonelord
    [181805] = "Back-Backpack", -- Osteowings of the Necrolords
    [181806] = "Back-Backpack", -- Regrown Osteowings
    [181807] = "Back-Backpack", -- Barbarous Osteowings
    [181808] = "Back-Backpack", -- Death Fetish
    [181809] = "Back-Backpack", -- Tomalin's Seasoning Crystal
    [181810] = "Back-Backpack", -- Phylactery of the Dead Conniver
    [181811] = "Back-Backpack", -- Beckoner's Shadowy Crystal
    [183705] = "Back-Backpack", -- Mantle of Crimson Blades
    [183706] = "Back-Backpack", -- Mantle of Court Blades
    [183707] = "Back-Backpack", -- Mantle of Burnished Blades
    [183708] = "Back-Backpack", -- Glittering Gold Sinstone Chain
    [183709] = "Back-Backpack", -- Bronze-Bound Sinstone
    [183710] = "Back-Backpack", -- Burnished Sinstone Chain
    [183711] = "Back-Backpack", -- Burnished Crypt Keeper's Mantle
    [183712] = "Back-Backpack", -- Gleaming Crypt Keeper's Mantle
    [183713] = "Back-Backpack", -- Kassir's Crypt Mantle
    [184154] = "Back-Backpack", -- Grungy Containment Pack
    [184156] = "Back-Backpack", -- Pristine Containment Pack
}

local function checkboxGetValue(self) return AppearanceTooltip.db[self.key] end
local function checkboxSetChecked(self) self:SetChecked(self:GetValue()) end
local function checkboxSetValue(self, checked) AppearanceTooltip.db[self.key] = checked end
local function checkboxOnClick(self)
    local checked = self:GetChecked()
    PlaySound(checked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
    self:SetValue(checked)
end
local function checkboxOnEnter(self)
    if ( self.tooltipText ) then
        GameTooltip:SetOwner(self, self.tooltipOwnerPoint or "ANCHOR_RIGHT")
        GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
    end
    if ( self.tooltipRequirement ) then
        GameTooltip:AddLine(self.tooltipRequirement, 1.0, 1.0, 1.0, true)
        GameTooltip:Show()
    end
end

local function newCheckbox(parent, key, label, description, getValue, setValue)
    local check = CreateFrame("CheckButton", "AppearanceTooltipOptionsCheck" .. key, parent, "InterfaceOptionsCheckButtonTemplate")

    check.key = key
    check.GetValue = getValue or checkboxGetValue
    check.SetValue = setValue or checkboxSetValue
    check:SetScript('OnShow', checkboxSetChecked)
    check:SetScript("OnClick", checkboxOnClick)
    check:SetScript("OnEnter", checkboxOnEnter)
    check:SetScript("OnLeave", GameTooltip_Hide)
    check.label = _G[check:GetName() .. "Text"]
    check.label:SetText(label)
    check.tooltipText = label
    check.tooltipRequirement = description
    return check
end

local function newDropdown(parent, key, description, values)
    local dropdown = CreateFrame("Frame", "AppearanceTooltipOptions" .. key .. "Dropdown", parent, "UIDropDownMenuTemplate")
    dropdown.key = key
    dropdown:HookScript("OnShow", function()
        if not dropdown.initialize then
            UIDropDownMenu_Initialize(dropdown, function(frame)
                for k, v in pairs(values) do
                    local info = UIDropDownMenu_CreateInfo()
                    info.text = v
                    info.value = k
                    info.func = function(self)
                        AppearanceTooltip.db[key] = self.value
                        UIDropDownMenu_SetSelectedValue(dropdown, self.value)
                    end
                    UIDropDownMenu_AddButton(info)
                end
            end)
            UIDropDownMenu_SetSelectedValue(dropdown, AppearanceTooltip.db[key])
        end
    end)
    dropdown:HookScript("OnEnter", function(self)
        if not self.isDisabled then
            GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
            GameTooltip:SetText(description, nil, nil, nil, nil, true)
        end
    end)
    dropdown:HookScript("OnLeave", GameTooltip_Hide)
    return dropdown
end

local function newFontString(parent, text, template,  ...)
    local label = parent:CreateFontString(nil, nil, template or 'GameFontHighlight')
    label:SetPoint(...)
    label:SetText(text)

    return label
end

local function newBox(parent, title, height)
    local boxBackdrop = {
        bgFile = [[Interface\ChatFrame\ChatFrameBackground]], tile = true, tileSize = 16,
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]], edgeSize = 16,
        insets = {left = 4, right = 4, top = 4, bottom = 4},
    }

    local box = CreateFrame('Frame', nil, parent, "BackdropTemplate")
    box:SetBackdrop(boxBackdrop)
    box:SetBackdropBorderColor(.3, .3, .3)
    box:SetBackdropColor(.1, .1, .1, .5)

    box:SetHeight(height)
    box:SetPoint('LEFT', 12, 0)
    box:SetPoint('RIGHT', -12, 0)

    if title then
        box.Title = newFontString(box, title, nil, 'BOTTOMLEFT', box, 'TOPLEFT', 6, 0)
    end

    return box
end

-- and the actual config now

do
    local panel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
    panel:Hide()
    panel:SetAllPoints()
    panel.name = "|cff8080ff[幻化]|r预览增强"

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(panel.name)

    local subText = panel:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
    subText:SetMaxLines(3)
    subText:SetNonSpaceWrap(true)
    subText:SetJustifyV('TOP')
    subText:SetJustifyH('LEFT')
    subText:SetPoint('TOPLEFT', title, 'BOTTOMLEFT', 0, -8)
    subText:SetPoint('RIGHT', -32, 0)
    subText:SetText("以下设置便于你更好的使用幻化鼠标提示框插件")

local dressed = newCheckbox(panel, 'dressed', '穿衣状态', "Show the model wearing your current outfit, apart from the previewed item")
local uncover = newCheckbox(panel, 'uncover', '不显示已预览缓存', "Remove clothes that would hide the item you're trying to preview")
local mousescroll = newCheckbox(panel, 'mousescroll', '鼠标滚轮旋转', "Use the mousewheel to rotate the model in the tooltip")
local spin = newCheckbox(panel, 'spin', '旋转模型', "Constantly spin the model while it's displayed")
local notifyKnown = newCheckbox(panel, 'notifyKnown', '提示是否已收藏', "Display a label showing whether you know the item appearance already")
local currentClass = newCheckbox(panel, 'currentClass', '仅限当前角色', "Only show previews on items that the current character can collect")
local byComparison = newCheckbox(panel, 'byComparison', '在对比框显示', "If the comparison tooltip is shown where the preview would want to be, show next to it (this makes it *much* less likely you'll have the preview overlap your cursor)")
local tokens = newCheckbox(panel, 'tokens', '可预览套装', "Show previews for the items which various tokens can be turned in for when mousing over the token")
    local alerts = newCheckbox(panel, 'alerts', '弹窗提示你获得的新幻化', "Show an alert popup for every new appearance that you learn (like the ones that otherwise only show when you buy something at the Trading Post)")

local zoomWorn = newCheckbox(panel, 'zoomWorn', '仅显示该装备部位', "Zoom in on the part of your model which wears the item")
local zoomHeld = newCheckbox(panel, 'zoomHeld', '不保持手持状态', "Zoom in on the held item being previewed, without seeing your character")
local zoomMasked = newCheckbox(panel, 'zoomMasked', '放大时屏蔽模型', "Hide the details of your player model while you're zoomed (like the transmog wardrobe does)")

local modifier = newDropdown(panel, 'modifier', "设置组合功能键", {
    Alt = "Alt",
    Ctrl = "Ctrl",
    Shift = "Shift",
    None = " X ",
})
UIDropDownMenu_SetWidth(modifier, 100)

local anchor = newDropdown(panel, 'anchor', "附着在提示框的某一侧，取决于它在屏幕的位置。", {
    vertical = "↑ / ↓",
    horizontal = "← / →",
})
UIDropDownMenu_SetWidth(anchor, 100)
--local modelBox = newBox(panel, "自定义模型种族", 48)
--local customModel = newCheckbox(modelBox, 'customModel', '使用不同的模型', "Instead of your current character, use a specific race/gender")
--local customRaceDropdown = newDropdown(modelBox, 'modelRace', "选择你要的种族模型", {
	--[0]	= "Pet",
--	[1] = "人类",
--	[2] = "兽人",
--	[3] = "矮人",
--	[4] = "暗夜精灵",
--	[5] = "亡灵",
--	[6] = "牛头人",
--	[7] = "侏儒",
--	[8] = "巨魔",
--	[9] = "地精",
--	[10] = "血精灵",
--	[11] = "德莱尼",
--	[22] = "狼人",
--	[24] = "熊猫人",
--	[27] = "夜之子",
--	[28] = "至高岭牛头人",
--	[29] = "虚空精灵",
--	[30] = "光铸德莱尼",
--	[31] = "赞达拉巨魔",
--	[32] = "库尔提拉斯人",
--	[34] = "黑铁矮人",
--	[35] = "狐人",
--	[36] = "玛格汉兽人",
--	[37] = "机械侏儒",
--})
--UIDropDownMenu_SetWidth(customRaceDropdown, 100)
--local customGenderDropdown = newDropdown(modelBox, 'modelGender', "选择你要的性别", {
--    [0] = "男",
--    [1] = "女",
--})
--UIDropDownMenu_SetWidth(customGenderDropdown, 100)

    -- And put them together:

    zoomWorn:SetPoint("TOPLEFT", subText, "BOTTOMLEFT", 0, -8)
    zoomHeld:SetPoint("TOPLEFT", zoomWorn, "BOTTOMLEFT", 0, -4)
    zoomMasked:SetPoint("TOPLEFT", zoomHeld, "BOTTOMLEFT", 0, -4)

    dressed:SetPoint("TOPLEFT", zoomMasked, "BOTTOMLEFT", 0, -4)
    uncover:SetPoint("TOPLEFT", dressed, "BOTTOMLEFT", 0, -4)
    tokens:SetPoint("TOPLEFT", uncover, "BOTTOMLEFT", 0, -4)
    notifyKnown:SetPoint("TOPLEFT", tokens, "BOTTOMLEFT", 0, -4)
    alerts:SetPoint("TOPLEFT", notifyKnown, "BOTTOMLEFT", 0, -4)
    currentClass:SetPoint("TOPLEFT", alerts, "BOTTOMLEFT", 0, -4)
    mousescroll:SetPoint("TOPLEFT", currentClass, "BOTTOMLEFT", 0, -4)
    spin:SetPoint("TOPLEFT", mousescroll, "BOTTOMLEFT", 0, -4)

    local modifierLabel = newFontString(panel, "设置组合功能键:", nil, 'TOPLEFT', spin, 'BOTTOMLEFT', 0, -10)
    modifier:SetPoint("LEFT", modifierLabel, "RIGHT", 4, -2)

    local anchorLabel = newFontString(panel, "附着于:", nil, 'TOPLEFT', modifierLabel, 'BOTTOMLEFT', 0, -16)
    anchor:SetPoint("LEFT", anchorLabel, "RIGHT", 4, -2)

    byComparison:SetPoint("TOPLEFT", anchorLabel, "BOTTOMLEFT", 0, -10)

    -- modelBox:SetPoint("TOP", byComparison, "BOTTOM", 0, -20)
    -- customModel:SetPoint("LEFT", modelBox, 12, 0)
    -- customRaceDropdown:SetPoint("LEFT", customModel.Text, "RIGHT", 12, -2)
    -- customGenderDropdown:SetPoint("TOPLEFT", customRaceDropdown, "TOPRIGHT", 4, 0)

    -- InterfaceOptions_AddCategory(panel)
    local category, layout = Settings.RegisterCanvasLayoutCategory(panel, panel.name, panel.name)
    category.ID = panel.name
    Settings.RegisterAddOnCategory(category)
end

-- Overlay config

do
    local panel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
    panel:Hide()
    panel:SetAllPoints()
    panel.name = "强化显示"
    panel.parent = "|cff8080ff[幻化]|r预览增强"

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(panel.name)

    local subText = panel:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
    subText:SetMaxLines(3)
    subText:SetNonSpaceWrap(true)
    subText:SetJustifyV('TOP')
    subText:SetJustifyH('LEFT')
    subText:SetPoint('TOPLEFT', title, 'BOTTOMLEFT', 0, -8)
    subText:SetPoint('RIGHT', -32, 0)
    subText:SetText("这些选项让你可以控制幻化预览在界面的不同位置时的显示方式")

    local bagicon = CreateAtlasMarkup("transmog-icon-hidden")
    local othercharicon = CreateAtlasMarkup("mailbox")

    local show = panel:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
    show:SetText(("显示 %s 图标表示未知物品，显示 %s 图标表示当前角色无法习得的未知物品："):format(bagicon, othercharicon))

    local bags = newCheckbox(panel, 'bags', '在背包中', ("对于外观未知的物品，在背包中的物品上显示%s图标。支持内置背包、Baggins、Bagnon和Inventorian。"):format(bagicon))
    local bags_unbound = newCheckbox(panel, 'bags_unbound', '...仅限非灵魂绑定物品', "灵魂绑定的物品要么已经学会，要么无法发送给其他角色")
    local merchant = newCheckbox(panel, 'merchant', '在商人处', ("对于外观未知的物品，在商人窗口的物品上显示%s图标。"):format(bagicon))
    local loot = newCheckbox(panel, 'loot', '在拾取框体中', ("对于外观未知的物品，在拾取框体的物品上显示%s图标。"):format(bagicon))
    local encounterjournal = newCheckbox(panel, 'encounterjournal', '在地下城手册中', ("对于外观未知的物品，在地下城手册的战利品部分显示%s图标。"):format(bagicon))
    local setjournal = newCheckbox(panel, 'setjournal', '在套装外观中', ("在套装列表中显示已收集/需要的套装物品数量"))

    show:SetPoint("TOPLEFT", subText, "BOTTOMLEFT", 0, -8)
    bags:SetPoint("TOPLEFT", show, "BOTTOMLEFT", 0, -8)
    bags_unbound:SetPoint("TOPLEFT", bags, "BOTTOMLEFT", 8, -4)
    merchant:SetPoint("TOPLEFT", bags_unbound, "BOTTOMLEFT", -8, -4)
    loot:SetPoint("TOPLEFT", merchant, "BOTTOMLEFT", 0, -4)
    encounterjournal:SetPoint("TOPLEFT", loot, "BOTTOMLEFT", 0, -4)
    setjournal:SetPoint("TOPLEFT", encounterjournal, "BOTTOMLEFT", 0, -4)

    local category = Settings.GetCategory(panel.parent)
    local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, panel, panel.name, panel.name)
    subcategory.ID = panel.name
end

-- Slash handler
SlashCmdList.APPEARANCETOOLTIP = function(msg)
    Settings.OpenToCategory("|cff8080ff[幻化]|r预览增强")
end
SLASH_APPEARANCETOOLTIP1 = "/appearancetooltip"
SLASH_APPEARANCETOOLTIP2 = "/aptip"


local LAI = LibStub("LibAppropriateItems-1.0")

-- minor compat:
local IsDressableItem = _G.IsDressableItem or C_Item.IsDressableItemByID
local IsUsableItem = _G.IsUsableItem or C_Item.IsUsableItem

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...) if f[event] then return f[event](f, ...) end end)
local hooks = {}
function f:RegisterAddonHook(addon, callback)
    if C_AddOns.IsAddOnLoaded(addon) then
        xpcall(callback, geterrorhandler())
    else
        hooks[addon] = callback
    end
end
function f:ADDON_LOADED(addon)
    if hooks[addon] then
        xpcall(hooks[addon], geterrorhandler())
        hooks[addon] = nil
    end
end
f:RegisterEvent("ADDON_LOADED")

local function PrepareItemButton(button, point, offsetx, offsety)
    if button.appearancetooltipoverlay then
        return
    end

    local overlayFrame = CreateFrame("FRAME", nil, button)
    overlayFrame:SetAllPoints()
    button.appearancetooltipoverlay = overlayFrame

    -- need the sublevel to make sure we're above overlays for e.g. azerite gear
    local sublevel = 4
    if button.IconOverlay then
        sublevel = select(2, button.IconOverlay:GetDrawLayer())
    end

    local background = overlayFrame:CreateTexture(nil, "OVERLAY", nil, sublevel)
    background:SetSize(12, 12)
    background:SetPoint(point or 'BOTTOMLEFT', offsetx or 0, offsety or 0)
    background:SetColorTexture(0, 0, 0, 0.4)

    button.appearancetooltipoverlay.icon = overlayFrame:CreateTexture(nil, "OVERLAY", nil, sublevel + 1)
    button.appearancetooltipoverlay.icon:SetSize(16, 16)
    button.appearancetooltipoverlay.icon:SetPoint("CENTER", background, "CENTER")
    button.appearancetooltipoverlay.icon:SetAtlas("transmog-icon-hidden")

    button.appearancetooltipoverlay.iconInappropriate = overlayFrame:CreateTexture(nil, "OVERLAY", nil, sublevel + 1)
    button.appearancetooltipoverlay.iconInappropriate:SetSize(14, 14)
    button.appearancetooltipoverlay.iconInappropriate:SetPoint("CENTER", background, "CENTER")
    button.appearancetooltipoverlay.iconInappropriate:SetAtlas("mailbox")
    button.appearancetooltipoverlay.iconInappropriate:SetRotation(1.7 * math.pi)
    -- button.appearancetooltipoverlay.iconInappropriate:SetVertexColor(0, 1, 1)

    overlayFrame:Hide()
end
local function IsRelevantItem(link)
    if not link then return end
    if AppearanceTooltip.db.learnable then
        local itemID = C_Item.GetItemInfoInstant(link)
        if itemID then
            if C_ToyBox and C_ToyBox.GetToyInfo(itemID) then
                return true
            end
            if C_MountJournal and C_MountJournal.GetMountFromItem(itemID) then
                return true
            end
        end
    end
    return IsDressableItem(link)
end
local function OverlayShouldApplyToItem(link, hasAppearance, appearanceFromOtherItem, probablyEnsemble)
    local appropriateItem = LAI:IsAppropriate(link) or probablyEnsemble
    return (not hasAppearance or appearanceFromOtherItem) and
        (not AppearanceTooltip.db.currentClass or appropriateItem) and
        IsRelevantItem(link) and
        (AppearanceTooltip.CanTransmogItem(link) or probablyEnsemble)
end
local function UpdateOverlay(button, link, ...)
    if not link then
        if button.appearancetooltipoverlay then
            button.appearancetooltipoverlay:Hide()
        end
        return false
    end
    local hasAppearance, appearanceFromOtherItem, probablyEnsemble = AppearanceTooltip.PlayerHasAppearance(link)
    -- AppearanceTooltip.Debug("Considering item", link, hasAppearance, appearanceFromOtherItem, appropriateItem, probablyEnsemble)
    if OverlayShouldApplyToItem(link, hasAppearance, appearanceFromOtherItem, probablyEnsemble) then
        PrepareItemButton(button, ...)
        button.appearancetooltipoverlay.icon:Hide()
        button.appearancetooltipoverlay.iconInappropriate:Hide()
        if LAI:IsAppropriate(link) or probablyEnsemble then
            button.appearancetooltipoverlay.icon:Show()
            if appearanceFromOtherItem then
                -- blue eye
                button.appearancetooltipoverlay.icon:SetVertexColor(0, 1, 1)
            else
                -- regular purple trasmog-eye
                button.appearancetooltipoverlay.icon:SetVertexColor(1, 1, 1)
            end
        else
            -- mail icon
            button.appearancetooltipoverlay.iconInappropriate:Show()
        end
        button.appearancetooltipoverlay:Show()
        return true
    elseif button.appearancetooltipoverlay then
        button.appearancetooltipoverlay:Hide()
    end
    return false
end

local function UpdateButtonFromItem(button, item)
    if button.appearancetooltipoverlay then button.appearancetooltipoverlay:Hide() end
    if not AppearanceTooltip.db.bags then
        return
    end
    if (not item) or item:IsItemEmpty() then
        return
    end
    item:ContinueOnItemLoad(function()
        local link = item:GetItemLink()
        local isBound = item:IsItemInPlayersControl() and C_Item.IsBound(item:GetItemLocation())
        if not AppearanceTooltip.db.bags_unbound or not isBound then
            UpdateOverlay(button, link)
        end
    end)
end

local function UpdateContainerButton(button, bag, slot)
    local item = Item:CreateFromBagAndSlot(bag, slot or button:GetID())
    UpdateButtonFromItem(button, item)
end

if _G.ContainerFrame_Update then
    hooksecurefunc("ContainerFrame_Update", function(container)
        local bag = container:GetID()
        local name = container:GetName()
        for i = 1, container.size, 1 do
            local button = _G[name .. "Item" .. i]
            UpdateContainerButton(button, bag)
        end
    end)
else
    local update = function(frame)
        for _, itemButton in frame:EnumerateValidItems() do
            UpdateContainerButton(itemButton, itemButton:GetBagID(), itemButton:GetID())
        end
    end
    -- can't use ContainerFrameUtil_EnumerateContainerFrames because it depends on the combined bags setting
    hooksecurefunc(ContainerFrameCombinedBags, "UpdateItems", update)
    for _, frame in ipairs((ContainerFrameContainer or UIParent).ContainerFrames) do
        hooksecurefunc(frame, "UpdateItems", update)
    end
end

hooksecurefunc("BankFrameItemButton_Update", function(button)
    if not button.isBag then
        UpdateContainerButton(button, -1)
    end
end)

-- Merchant frame

hooksecurefunc("MerchantFrame_Update", function()
    local limit, infoFunc
    if MerchantFrame.selectedTab == 1 then
        limit = MERCHANT_ITEMS_PER_PAGE
        infoFunc = GetMerchantItemLink
    else
        limit = BUYBACK_ITEMS_PER_PAGE
        infoFunc = GetBuybackItemLink
    end
    for i = 1, limit do
        local frame = _G["MerchantItem"..i.."ItemButton"]
        if frame then
            if frame.appearancetooltipoverlay then frame.appearancetooltipoverlay:Hide() end
            if not AppearanceTooltip.db.merchant then
                return
            end
            local link = infoFunc(frame:GetID())
            if link then
                UpdateOverlay(frame, link)
            end
        end
    end
end)

-- Loot frame

if _G.LootFrame_UpdateButton then
    hooksecurefunc("LootFrame_UpdateButton", function(index)
        local button = _G["LootButton"..index]
        if not button then return end
        if button.appearancetooltipoverlay then button.appearancetooltipoverlay:Hide() end
        if not AppearanceTooltip.db.loot then return end
        if button:IsEnabled() and button.slot then
            local link = GetLootSlotLink(button.slot)
            if link then
                UpdateOverlay(button, link)
            end
        end
    end)
else
    local function handleSlot(frame)
        if not frame.Item then return end
        if frame.Item.appearancetooltipoverlay then frame.Item.appearancetooltipoverlay:Hide() end
        if not AppearanceTooltip.db.loot then return end
        local data = frame:GetElementData()
        if not (data and data.slotIndex) then return end
        local link = GetLootSlotLink(data.slotIndex)
        if link then
            UpdateOverlay(frame.Item, link)
        end
    end
    LootFrame.ScrollBox:RegisterCallback("OnUpdate", function(...)
        LootFrame.ScrollBox:ForEachFrame(handleSlot)
    end)
end

-- Encounter Journal frame

f:RegisterAddonHook("Blizzard_EncounterJournal", function()
    local function handleSlot(frame)
        if frame.appearancetooltipoverlay then frame.appearancetooltipoverlay:Hide() end
        if not AppearanceTooltip.db.encounterjournal then return end
        if frame:IsShown() then
            local data = frame:GetElementData()
            local itemInfo = data.index and C_EncounterJournal.GetLootInfoByIndex(data.index)
            -- DevTools_Dump(itemInfo)
            if itemInfo then
                UpdateOverlay(frame, itemInfo.link, "TOPLEFT", 5, -4)
            end
        end
    end
    EncounterJournal.encounter.info.LootContainer.ScrollBox:RegisterCallback("OnUpdate", function(...)
        EncounterJournal.encounter.info.LootContainer.ScrollBox:ForEachFrame(handleSlot)
    end)
    -- initial load:
    hooksecurefunc("EncounterJournal_LootCallback", function(itemID)
        local scrollBox = EncounterJournal.encounter.info.LootContainer.ScrollBox
        local button = scrollBox:FindFrameByPredicate(function(button)
            return button.itemID == itemID
        end);
        if button then
            handleSlot(button)
        end
    end)
end)

-- Sets list

f:RegisterAddonHook("Blizzard_Collections", function()
    local function setCompletion(setID)
        local have, need = 0, 0
        for _, appearance in pairs(C_TransmogSets.GetSetPrimaryAppearances(setID)) do
            need = need + 1
            if appearance.collected then
                have = have + 1
            end
        end
        return have, need
    end
    local function setSort(a, b)
        return a.uiOrder < b.uiOrder
    end
    local function buildSetText(setID, separator)
        separator = separator or "\n"
        local variants = C_TransmogSets.GetVariantSets(setID)
        if type(variants) ~= "table" then return "" end
        table.insert(variants, C_TransmogSets.GetSetInfo(setID))
        table.sort(variants, setSort)
        -- local text = setID -- debug
        local text = ""
        for _, set in ipairs(variants) do
            local have, need = setCompletion(set.setID)
            text = text .. AppearanceTooltip.ColorTextByCompletion((GENERIC_FRACTION_STRING):format(have, need), have / need) .. separator
        end
        return string.sub(text, 1, -#separator)
    end
    local function makeOverlay(parent)
       local overlay = CreateFrame("Frame", nil, parent)
       overlay.text = overlay:CreateFontString(nil, "OVERLAY", "GameFontNormalTiny")
       overlay:SetAllPoints()
       -- overlay.text:SetPoint("TOPRIGHT", -2, -2)
       overlay.text:SetPoint("BOTTOMRIGHT", -2, 2)
       overlay:Show()
       return overlay
    end
    if WardrobeCollectionFrame.SetsCollectionFrame.ScrollFrame then
        -- pre-dragonflight
        local function update(self)
            local offset = HybridScrollFrame_GetOffset(self)
            local buttons = self.buttons
            for i = 1, #buttons do
                local button = buttons[i]
                if button.appearancetooltipoverlay then button.appearancetooltipoverlay.text:SetText("") end
                if AppearanceTooltip.db.setjournal and button:IsShown() then
                    local setID = button.setID
                    if not button.appearancetooltipoverlay then
                        button.appearancetooltipoverlay = makeOverlay(button)
                    end
                    button.appearancetooltipoverlay.text:SetText(buildSetText(setID))
                end
            end
        end
        hooksecurefunc(WardrobeCollectionFrame.SetsCollectionFrame.ScrollFrame, "Update", update)
        hooksecurefunc(WardrobeCollectionFrame.SetsCollectionFrame.ScrollFrame, "update", update)
    else
        local function handleSlot(frame)
            if frame.appearancetooltipoverlay then frame.appearancetooltipoverlay.text:SetText("") end
            if AppearanceTooltip.db.setjournal and frame:IsShown() then
                local data = frame:GetElementData()
                local setID = data.setID
                if not frame.appearancetooltipoverlay then
                    frame.appearancetooltipoverlay = makeOverlay(frame)
                end
                frame.appearancetooltipoverlay.text:SetText(buildSetText(setID, " "))
            end
        end
        WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBox:RegisterCallback("OnUpdate", function(...)
            WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBox:ForEachFrame(handleSlot)
        end)
    end
end)



-- SilverDragon
f:RegisterAddonHook("SilverDragon", function()
    if not (SilverDragon and SilverDragon.RegisterCallback) then
        -- Geniunely unsure what'd cause this, but see #11 on github
        return
    end
    SilverDragon.RegisterCallback("AppearanceTooltip", "LootWindowOpened", function(_, window)
        AppearanceTooltip.RegisterTooltip(_G["SilverDragonLootTooltip"])
        if window and window.buttons and #window.buttons then
            for i, button in ipairs(window.buttons) do
                UpdateOverlay(button, button:GetItem())
            end
        end
    end)
end)

-- Baganator
f:RegisterAddonHook("Baganator", function()
    Baganator.API.RegisterCornerWidget("|cff8080ff[幻化]|r预览增强", "appearancetooltip",
        -- onUpdate
        function(cornerFrame, details)
            if details.itemLink and (not AppearanceTooltip.db.bags_unbound or not details.isBound) then
                -- todo: a puchased ensemble will be bound and so won't show here...
                return UpdateOverlay(cornerFrame, details.itemLink)
            end
            return false
        end,
        -- onInit
        function(itemButton)
            local frame = CreateFrame("Frame", nil, itemButton)
            frame:SetSize(6, 6)
            PrepareItemButton(frame, "CENTER", 0, 0)
            return frame
        end,
        {default_position = "bottom_left", priority = 1}
    )
end)
EventRegistry:RegisterFrameEventAndCallback("TRANSMOG_COLLECTION_SOURCE_ADDED", function(_, itemModifiedAppearanceID)
    if not AppearanceTooltip.db.alerts then
        return
    end
    if PerksProgramFrame and PerksProgramFrame:IsShown() then
        -- Trading Post, and core UI handles showing this
        return
    end
    if C_ContentTracking and C_ContentTracking.IsTracking(Enum.ContentTrackingType.Appearance, itemModifiedAppearanceID) then
        -- Boss loot, generally
        -- print("Blocked toast: contenttracking")
        return
    end
    NewCosmeticAlertFrameSystem:AddAlert(itemModifiedAppearanceID)
end, "|cff8080ff[幻化]|r预览增强")
