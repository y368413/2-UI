--## Version: v79  ## Author: Kemayo
local AppearanceTooltip = {}
local GetScreenWidth = GetScreenWidth
local GetScreenHeight = GetScreenHeight
local setDefaults, db

local LAT = LibStub("LibArmorToken-1.0", true)
local LAI = LibStub("LibAppropriateItems-1.0")

if GetLocale() == "zhCN" then
  AppearanceTooltipLocal = "|cff8080ff[幻化]|r预览增强";
elseif GetLocale() == "zhTW" then
  AppearanceTooltipLocal = "|cff8080ff[幻化]|r预览增强";
else
  AppearanceTooltipLocal = "Appearance Tooltip";
end

-- minor compat:
local IsDressableItem = _G.IsDressableItem or C_Item.IsDressableItemByID
local issecretvalue = _G.issecretvalue or function() return false end
local isanyvaluesecret = function(...)
    for i=1, select("#", ...) do
        if issecretvalue((select(i, ...))) then
            return true
        end
    end
    return false
end
local function PlayerHasTransmogByItemInfo(itemLinkOrID)
    -- Cata classic is specifically missing C_TransmogCollection.PlayerHasTransmogByItemInfo
    if C_TransmogCollection.PlayerHasTransmogByItemInfo then
        return C_TransmogCollection.PlayerHasTransmogByItemInfo(itemLinkOrID)
    end
    local itemID = C_Item.GetItemInfoInstant(itemLinkOrID)
    if itemID then
        -- this is a bit worse, because of items with varying appearances based on the link-details
        -- but because this path should only be hit in classic, we should be fine
        return C_TransmogCollection.PlayerHasTransmog(itemID)
    end
end

AppearanceTooltip.CLASSIC = WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE -- rolls forward
AppearanceTooltip.CLASSICERA = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC -- forever vanilla

local tooltip = CreateFrame("Frame", "AppearanceTooltipTooltip", UIParent, "TooltipBorderedFrameTemplate")
tooltip:SetClampedToScreen(true)
tooltip:SetFrameStrata("TOOLTIP")
tooltip:SetSize(280, 380)
tooltip:Hide()

tooltip:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
tooltip:RegisterEvent("ADDON_LOADED")
tooltip:RegisterEvent("PLAYER_LOGIN")

function tooltip:ADDON_LOADED(addon)
    if addon ~= "OrzUI" then return end

    _G["AppearanceTooltipDB"] = setDefaults(_G["AppearanceTooltipDB"] or {}, {
        modifier = "None", -- or "Alt", "Ctrl", "Shift"
        mousescroll = true, -- scrolling mouse rotates model
        rotate = true, -- turn the model slightly, so it's not face-on to the camera
        spin = false, -- constantly spin the model
        zoomWorn = true, -- zoom in on the item in question
        zoomHeld = true, -- zoom in on weapons
        zoomMasked = false, -- use the transmog mask while zoomed
        dressed = true, -- whether the model should be wearing your current outfit, or be naked
        dressed_ensemble = false, -- as above, but specifically for ensembles
        uncover = true, -- remove clothing to expose the previewed item
        customModel = false, -- use a model other than your current class, and if so:
        modelRace = 7, -- raceid (1:human)
        modelGender = 1, -- 0:male, 1:female
        notifyKnown = true, -- show text explaining the transmog state of the item previewed
        currentClass = false, -- only show for items the current class can transmog
        anchor = "vertical", -- vertical / horizontal
        byComparison = true, -- whether to show by the comparison, or fall back to vertical if needed
        tokens = true, -- try to preview tokens?
        learnable = true, -- show for other learnable items (toys, mounts, pets)
        bags = true,
        bags_unbound = true,  --AppearanceTooltip.CLASSIC,
        merchant = true,
        loot = true,
        encounterjournal = true,
        setjournal = true,
        alerts = true,
    })
    db = _G["AppearanceTooltipDB"]
    AppearanceTooltip.db = db

    -- Dressing up custom models is broken currently, so force-disable this. Test it occasionally to see if it gets fixed.
    db.customModel = false

    self:UnregisterEvent("ADDON_LOADED")
end

function tooltip:PLAYER_LOGIN()
    for _, model in pairs(tooltip.models) do
        if model.SetUnit then
            model:SetUnit("player")
        end
    end
    C_CVar.SetCVar("missingTransmogSourceInItemTooltips", "1")
end

local function scrollActiveModel(amount)
    if not (tooltip.activeModel and tooltip.activeModel:IsVisible()) then
        return
    end
    if tooltip.activeModel.GetActiveCamera then
        local camera = tooltip.activeModel:GetActiveCamera()
        local mode = ORBIT_CAMERA_MOUSE_MODE_YAW_ROTATION
        local snapToValue = false
        camera:HandleMouseMovement(mode, amount, snapToValue)
    else
        tooltip.activeModel:SetFacing(tooltip.activeModel:GetFacing() + amount)
    end
    return true
end

do
    local scrollup = CreateFrame("Button", "AppearanceTooltipScrollUpButton", tooltip)
    scrollup:SetScript("OnClick", function(self, button, down)
        scrollActiveModel(0.3)
    end)
    scrollup:RegisterForClicks("AnyDown", "AnyUp")
    local scrolldown = CreateFrame("Button", "AppearanceTooltipScrollDownButton", tooltip)
    scrolldown:SetScript("OnClick", function(self, button, down)
        scrollActiveModel(-0.3)
    end)

    local function ClearBindings()
        if InCombatLockdown() then return end
        ClearOverrideBindings(tooltip)
    end

    function tooltip:UpdateMouseBinding(event, unit)
        if InCombatLockdown() then return end
        if db.mousescroll and (event ~= "PLAYER_REGEN_DISABLED") and tooltip:IsVisible() then
            SetOverrideBindingClick(tooltip, true, "MOUSEWHEELUP", scrollup:GetName())
            SetOverrideBindingClick(tooltip, true, "MOUSEWHEELDOWN", scrolldown:GetName())
        else
            ClearOverrideBindings(tooltip)
        end
    end

    local frame = CreateFrame("Frame", nil, tooltip)
    frame:SetScript("OnShow", tooltip.UpdateMouseBinding)
    frame:SetScript("OnHide", ClearBindings)

    frame:SetScript("OnEvent", tooltip.UpdateMouseBinding)
    frame:RegisterEvent("PLAYER_REGEN_ENABLED")
    frame:RegisterEvent("PLAYER_REGEN_DISABLED")
end

do
    local function makeModel(frameType, template)
        local model = CreateFrame(frameType, nil, tooltip, template)
        model:SetFrameLevel(1)
        model:SetScript("OnShow", function()
            -- This is mostly in service of avoiding secret-spread
            model:ClearAllPoints()
            model:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 5, -5)
            model:SetPoint("BOTTOMRIGHT", tooltip, "BOTTOMRIGHT", -5, 5)
        end)

        return model
    end
    local function makeDressUpModel()
        local model = makeModel("DressUpModel")
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
    local function makeModelScene()
        return makeModel("ModelScene", "NoCameraControlModelSceneMixinTemplate")
    end
    tooltip.models = {
        FullBody = makeDressUpModel(),
        Zoomed = makeDressUpModel(),
        Weapon = makeDressUpModel(),
        Mount = makeModelScene(),
        Pet = makeModelScene(),
        Decor = makeModelScene(),
    }
end

local modelLabel = tooltip:CreateFontString(nil, "OVERLAY", "GameFontNormal")
modelLabel:SetWordWrap(true)
modelLabel:SetTextColor(0.5333, 0.6666, 0.9999, 0.9999)
modelLabel:SetPoint("BOTTOMLEFT", tooltip, "BOTTOMLEFT", 6, 12)
modelLabel:SetPoint("BOTTOMRIGHT", tooltip, "BOTTOMRIGHT", -6, 12)
modelLabel:Show()

local classwarning = tooltip:CreateFontString(nil, "OVERLAY", "GameFontRed")
classwarning:SetWordWrap(true)
classwarning:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 6, -12)
classwarning:SetPoint("TOPRIGHT", tooltip, "TOPRIGHT", -6, -12)
-- ITEM_WRONG_CLASS = "That item can't be used by players of your class!"
-- STAT_USELESS_TOOLTIP = "|cff808080Provides no benefit for your class|r"
classwarning:SetText(ITEM_WRONG_CLASS)
classwarning:Show()

-- Ye showing:
local function GetTooltipItem(tip)
    if _G.C_TooltipInfo then
        -- getdisplayeditem attempts this comparison...
        local primaryInfo = tip:GetPrimaryTooltipInfo();
        if issecretvalue(primaryInfo and primaryInfo.tooltipData and primaryInfo.tooltipData.type and primaryInfo.tooltipData.type) then
            return
        end
    end
    return tip:GetItem()
end
do
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
    tooltip:ClearAllPoints()
    if our_point and owner_point then
        tooltip:SetPoint(our_point, owner, owner_point)
    else
        -- TODO: could fall back somewhere instead?
        tooltip:Hide()
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
        if not (x and y) or issecretvalue(x) then
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
                    local c1x, c2x = comparisonTooltip1:GetCenter(), comparisonTooltip2:GetCenter()
                    if issecretvalue(c1x) then
                        outermostComparisonShown = nil
                    elseif c1x > c2x then
                        -- 1 is right of 2
                        outermostComparisonShown = biasLeft and comparisonTooltip2 or comparisonTooltip1
                    else
                        -- 1 is left of 2
                        outermostComparisonShown = biasLeft and comparisonTooltip1 or comparisonTooltip2
                    end
                else
                    outermostComparisonShown = comparisonTooltip1:IsShown() and comparisonTooltip1 or comparisonTooltip2
                end
                if outermostComparisonShown then
                    local outerx = (outermostComparisonShown:GetCenter() or 0) * (outermostComparisonShown:GetEffectiveScale() or 1)
                    local ownerx = (owner:GetCenter() or 0) * (owner:GetEffectiveScale() or 1)
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
            anchor ~= "vertical" and
            not isanyvaluesecret(owner:GetLeft(), tooltip:GetWidth()) and (
                (primary == "left" and (owner:GetLeft() - tooltip:GetWidth()) < 0)
                or (primary == "right" and (owner:GetRight() + tooltip:GetWidth() > GetScreenWidth()))
            )
        then
            return self:ComputeTooltipAnchors(originalOwner, "vertical")
        end
        -- AppearanceTooltip.Debug("ComputeTooltipAnchors", owner:GetName(), primary, secondary)
        return owner, unpack(points[primary][secondary])
    end
end

local spinner = CreateFrame("Frame", nil, tooltip);
spinner:Hide()
spinner:SetScript("OnUpdate", function(self, elapsed)
    if not scrollActiveModel(elapsed) then
        self:Hide()
    end
end)

local hider = CreateFrame("Frame")
hider:Hide()
local shouldHide = function(owner)
    if not owner then return true end
    if not owner:IsShown() then return true end
    if not GetTooltipItem(owner) then return true end
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
        -- Testing note: the absolute worst-case is Trophy of the Crusade (47242)
        local found
        local counts = {}
        local counts_known = {}
        for itemid, tclass, relevant, variants in LAT:IterateItemsForToken(link) do
            local itemLinkOrID = itemid
            for _, variant in ipairs(variants or {false}) do
                if variant then
                    itemLinkOrID = LAT:GetBareLinkForItem(itemid, variant)
                end
                found = found or itemLinkOrID
                if relevant then
                    found = itemLinkOrID -- make *sure* the item shown is a relevant one, if one exists

                    AddItemToTooltip(itemLinkOrID, for_tooltip, tclass == class and class_colored or tclass)
                else
                    counts[tclass] = (counts[tclass] or 0) + 1
                    counts_known[tclass] = (counts_known[tclass] or 0) + (AppearanceTooltip.PlayerHasAppearance(itemLinkOrID) and 1 or 0)
                end
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

    if tooltip.item == id or (db.modifier and not self.modifiers[db.modifier]()) then
        return
    end
    local slot, _, _, classID, subclassID, _, _, setID = select(9, C_Item.GetItemInfo(id))
    tooltip.item = id

    local appropriateItem = LAI:IsAppropriate(id)

    for _, model in pairs(tooltip.models) do
        model:Hide()
    end

    if self.slot_facings[slot] and IsDressableItem(id) and (not db.currentClass or appropriateItem) then
        local model, cameraID
        local isHeld = self.slot_held[slot]
        local shouldZoom = (db.zoomWorn and not isHeld) or (db.zoomHeld and isHeld)
        local dressed = db.dressed
        if slot == "INVTYPE_NON_EQUIP_IGNORE" then
            dressed = db.dressed_ensemble
        end
        local appearanceID = AppearanceTooltip.GetTransmogInfo(link)

        if shouldZoom then
            cameraID = appearanceID and C_TransmogCollection.GetAppearanceCameraID(appearanceID)
            -- Classic Era always returns 0, in which case a non-truthy value gets better results:
            if cameraID == 0 then cameraID = nil end
        end

        if cameraID then
            if isHeld then
                model = tooltip.models.Weapon
            else
                model = tooltip.models.Zoomed
                model:SetUseTransmogSkin(db.zoomMasked and slot ~= "INVTYPE_HEAD")
                self:ResetModel(model, dressed)
            end
            model.cameraID = cameraID
            Model_ApplyUICamera(model, cameraID)
            -- ApplyUICamera locks the animation, but...
            model:SetAnimation(0, 0)
        else
            model = tooltip.models.FullBody

            self:ResetModel(model, dressed)
        end
        tooltip.activeModel = model
        model:Show()

        if not cameraID then
            model:SetFacing(self.slot_facings[slot] - (db.rotate and 0.5 or 0))
        end

        self:ShowTooltip(for_tooltip)

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

        -- Finally set the item onto the model
        if isHeld and shouldZoom then
            if appearanceID then
                model:SetItemAppearance(appearanceID)
            else
                model:SetItem(id)
            end
        else
            model:TryOn(link)
        end
    elseif _G.HOUSING_DECOR_OWNED_COUNT_FORMAT and classID == Enum.ItemClass.Housing and subclassID == Enum.ItemHousingSubclass.Decor then
        -- see: Blizzard_HousingModelPreview
        local decorInfo = C_HousingCatalog.GetCatalogEntryInfoByItem(id, true)
        if decorInfo and decorInfo.asset then
            local modelScene = tooltip.models.Decor
            local modelSceneID = decorInfo.uiModelSceneID or Constants.HousingCatalogConsts.HOUSING_CATALOG_DECOR_MODELSCENEID_DEFAULT
            local forceSceneChange = true
            modelScene:TransitionToModelSceneID(modelSceneID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_DISCARD, forceSceneChange)
            local actor = modelScene:GetActorByTag("decor");
            if actor then
                actor:SetPreferModelCollisionBounds(true)
                actor:SetModelByFileID(decorInfo.asset)
            end
            modelScene:Show()

            tooltip.activeModel = modelScene

            self:ShowTooltip(for_tooltip)
        end
    elseif C_MountJournal and C_MountJournal.GetMountFromItem and classID == Enum.ItemClass.Miscellaneous and subclassID == Enum.ItemMiscellaneousSubclass.Mount then
        -- see: DressUpFrames.lua
        local mountID = C_MountJournal.GetMountFromItem(id)
        if mountID then
            local creatureDisplayID, _, _, isSelfMount, _, modelSceneID, animID, spellVisualKitID, disablePlayerMountPreview = C_MountJournal.GetMountInfoExtraByID(mountID)
            if creatureDisplayID then
                local modelScene = tooltip.models.Mount
                modelScene:ClearScene()
                modelScene:SetViewInsets(0, 0, 0, 0)
                local forceEvenIfSame = true
                modelScene:TransitionToModelSceneID(modelSceneID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_DISCARD, forceEvenIfSame)

                local mountActor = modelScene:GetActorByTag("unwrapped")
                if mountActor then
                    mountActor:SetModelByCreatureDisplayID(creatureDisplayID)
                end
                if (isSelfMount) then
                    mountActor:SetAnimationBlendOperation(Enum.ModelBlendOperation.None)
                    mountActor:SetAnimation(618) -- MountSelfIdle
                else
                    mountActor:SetAnimationBlendOperation(Enum.ModelBlendOperation.Anim)
                    mountActor:SetAnimation(0)
                end
                modelScene:AttachPlayerToMount(mountActor, animID, isSelfMount, disablePlayerMountPreview)
                modelScene:Show()

                tooltip.activeModel = modelScene

                self:ShowTooltip(for_tooltip)
            end
        end
    elseif C_PetJournal and C_PetJournal.GetPetInfoByItemID and classID == Enum.ItemClass.Miscellaneous and subclassID == Enum.ItemMiscellaneousSubclass.CompanionPet then
        -- see: DressUpFrames.lua
        local displayID, petID = select(12, C_PetJournal.GetPetInfoByItemID(id))
        if displayID and petID then
            local modelScene = tooltip.models.Pet
            local _, loadoutModelSceneID = C_PetJournal.GetPetModelSceneInfoBySpeciesID(petID)
            modelScene:ClearScene()
            modelScene:SetViewInsets(0, 0, 50, 0)
            modelScene:TransitionToModelSceneID(loadoutModelSceneID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_DISCARD, true)

            local battlePetActor = modelScene:GetActorByTag("pet")
            if battlePetActor then
                battlePetActor:SetModelByCreatureDisplayID(displayID, true)
                battlePetActor:SetAnimationBlendOperation(Enum.ModelBlendOperation.None)
            end

            tooltip.activeModel = modelScene

            modelScene:Show()
            self:ShowTooltip(for_tooltip)
        end
    else
        tooltip:Hide()
    end

    classwarning:Hide()
    modelLabel:Hide()

    local label = {}
    if db.notifyKnown then
        local hasAppearance, appearanceFromOtherItem, probablyEnsemble = AppearanceTooltip.PlayerHasAppearance(link)

        if not AppearanceTooltip.CanTransmogItem(link) and not probablyEnsemble then
            table.insert(label, "|c00ffff00" .. TRANSMOGRIFY_INVALID_DESTINATION .. "|r")
        else
            if hasAppearance then
                if appearanceFromOtherItem then
                    table.insert(label, "|TInterface\\RaidFrame\\ReadyCheck-Ready:0|t " .. (TRANSMOGRIFY_TOOLTIP_ITEM_UNKNOWN_APPEARANCE_KNOWN):gsub(', ', ',\n'))
                else
                    table.insert(label, "|TInterface\\RaidFrame\\ReadyCheck-Ready:0|t " .. TRANSMOGRIFY_TOOLTIP_APPEARANCE_KNOWN)
                end
            else
                table.insert(label, "|TInterface\\RaidFrame\\ReadyCheck-NotReady:0|t |cffff0000" .. TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN .. "|r")
            end
            classwarning:SetShown(not appropriateItem and not probablyEnsemble)
        end
    end
    if token then
        table.insert(label, (string.gsub(link, "[%[%]]", "")))
    end
    if setID then
        local setName = C_Item.GetItemSetInfo(setID)
        if setName then
            table.insert(label, ITEM_SET_BONUS:format(setName))
        end
    end
    if #label > 0 then
        modelLabel:SetText(string.join("\n", unpack(label)))
        modelLabel:Show()
    end
end
function AppearanceTooltip:ShowTooltip(for_tooltip)
    tooltip:SetParent(for_tooltip)
    tooltip:Show()
    tooltip.owner = for_tooltip

    positioner:Show()
    spinner:SetShown(db.spin)
end

function AppearanceTooltip:HideItem()
    hider:Show()
end

function AppearanceTooltip:ResetModel(model, dressed)
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
    model[dressed and "Dress" or "Undress"](model)
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
    INVTYPE_NON_EQUIP_IGNORE = {AppearanceTooltip.SLOT_TABARD},
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

AppearanceTooltip.slot_held = {
    INVTYPE_2HWEAPON = true,
    INVTYPE_WEAPON = true,
    INVTYPE_WEAPONMAINHAND = true,
    INVTYPE_WEAPONOFFHAND = true,
    INVTYPE_RANGED = true,
    INVTYPE_RANGEDRIGHT = true,
    INVTYPE_HOLDABLE = true,
    INVTYPE_SHIELD = true,
}

AppearanceTooltip.modifiers = {
    Shift = IsShiftKeyDown,
    Ctrl = IsControlKeyDown,
    Alt = IsAltKeyDown,
    None = function() return true end,
}

-- Utility fun

--/dump C_Transmog.CanTransmogItem(C_Item.GetItemInfoInstant(""))
--/dump C_TransmogCollection.GetSourceInfo(select(2, C_TransmogCollection.GetItemInfo("")))
function AppearanceTooltip.CanTransmogItem(itemLink)
    local itemID = C_Item.GetItemInfoInstant(itemLink)
    if itemID then
        if C_Transmog.CanTransmogItem then
            local canBeChanged, noChangeReason, canBeSource, noSourceReason = C_Transmog.CanTransmogItem(itemID)
            return canBeSource, noSourceReason
        else
            -- Midnight; it *seems* that anything which this function returns
            -- data for is usable as a transmog source now. Checked on
            -- Warglaive of Azzinoth (32837) which returns nil.
            -- 2026/1/23: Apart from Legion artifacts, but they've always been
            -- weird and might be bugged at the moment anyway.
            if AppearanceTooltip.GetTransmogInfo(itemLink) then
                return true
            end
            -- sometimes this doesn't return info for valid items, but
            -- anything you have the transmog for *must* be transmoggable...
            if PlayerHasTransmogByItemInfo(itemLink) then
                return true
            end
        end
    end
    return nil, 'NO_ITEM'
end

local brokenItems = {
    -- itemid : {appearanceid, sourceid}
    [253520] = {21670, 298859}, -- Enclave Aspirant's Hatchet
    [153267] = {21670, 90806}, -- Enclave Aspirant's Hatchet
    [153268] = {25124, 90807}, -- Enclave Aspirant's Axe
    [153316] = {25123, 90885}, -- Praetor's Ornamental Edge
}
function AppearanceTooltip.GetTransmogInfo(itemLinkOrID)
    local appearanceID, sourceID = C_TransmogCollection.GetItemInfo(itemLinkOrID)
    if appearanceID then
        return appearanceID, sourceID
    end
    local itemID = C_Item.GetItemInfoInstant(itemLinkOrID)
    if itemID then
        -- sometimes the link won't actually give us an appearance, but itemID will
        -- e.g. mythic Drape of Iron Sutures from Shadowmoon Burial Grounds
        appearanceID, sourceID = C_TransmogCollection.GetItemInfo(itemID)
        if appearanceID then
            return appearanceID, sourceID
        end
        if brokenItems[itemID] then
            -- ...and there's a few that just need to be hardcoded
            return unpack(brokenItems[itemID])
        end
    end
end
-- /dump C_TransmogCollection.GetAppearanceSourceInfo(select(2, C_TransmogCollection.GetItemInfo("")))
-- /dump C_TransmogCollection.GetAppearanceInfoBySource(select(2, C_TransmogCollection.GetItemInfo("")))
function AppearanceTooltip.PlayerHasAppearance(itemLinkOrID)
    -- hasAppearance, appearanceFromOtherItem
    local itemID, _, _, _, _, classID, subclassID = C_Item.GetItemInfoInstant(itemLinkOrID)
    if not itemID then return end
    local probablyEnsemble = IsDressableItem(itemID) and not C_Item.IsEquippableItem(itemID)
    if probablyEnsemble then
        -- TODO: Enum.TooltipDataLineType.LearnTransmogSet  is Coming Soon ("with setID arg")
        -- *not* ERR_COSMETIC_KNOWN which is "Item Known"
        return AppearanceTooltip.CheckTooltipFor(itemID, ITEM_SPELL_KNOWN), false, true
    end
    if db.learnable then
        if classID == Enum.ItemClass.Miscellaneous and subclassID == Enum.ItemMiscellaneousSubclass.Mount then
            if AppearanceTooltip.CLASSICERA then return GetItemCount(itemID, true) > 0 end
            local mountID = C_MountJournal and C_MountJournal.GetMountFromItem(itemID)
            return mountID and (select(11, C_MountJournal.GetMountInfoByID(mountID))), false, true
        end
        if C_ToyBox and C_ToyBox.GetToyInfo(itemID)  then
            return PlayerHasToy(itemID), false, true
        end
        if classID == Enum.ItemClass.Miscellaneous and subclassID == Enum.ItemMiscellaneousSubclass.CompanionPet then
            if AppearanceTooltip.CLASSICERA then return GetItemCount(itemID, true) > 0 end
            local petID = C_PetJournal and select(13, C_PetJournal.GetPetInfoByItemID(itemID))
            return petID and C_PetJournal.GetNumCollectedInfo(petID) > 0, false, true
        end
        if _G.HOUSING_DECOR_OWNED_COUNT_FORMAT and classID == Enum.ItemClass.Housing and subclassID == Enum.ItemHousingSubclass.Decor then
            -- not that this should be possible, but:
            if AppearanceTooltip.CLASSICERA then return GetItemCount(itemID, true) > 0 end
            local pattern = HOUSING_DECOR_OWNED_COUNT_FORMAT:gsub("([%(%)])", "%%%1"):gsub("%%d", "(%%d+)")
            local info = C_TooltipInfo.GetItemByID(itemID)
            if info then
                for _, line in ipairs(info.lines) do
                    if line.type == Enum.TooltipDataLineType.None and line.leftText and string.match(line.leftText, pattern) then
                        return true, false, true
                    end
                end
            end
            return false, false, true
        end
    end
    local appearanceID, sourceID = AppearanceTooltip.GetTransmogInfo(itemLinkOrID)
    if not appearanceID then
        if PlayerHasTransmogByItemInfo(itemLinkOrID) then
            -- avoid more detailed checks if possible; we don't do
            -- this *first* because it sometimes gets it wrong with items
            -- that have variants based on link bonuses
            return true, false
        end
        return
    end
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

function AppearanceTooltip.Print(...) print(AppearanceTooltipLocal, ...) end

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
    local check = CreateFrame("CheckButton", "AppearanceTooltipOptionsCheck" .. key, parent, "OptionsBaseCheckButtonTemplate")

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

local function button_onenter(self)
    GameTooltip:SetOwner(self, "ANCHOR_NONE")
    ContainerFrameItemButton_CalculateItemTooltipAnchors(self, GameTooltip)

    local link = self:GetItemLink()
    if link then
        GameTooltip:SetHyperlink(self:GetItemLink())
    else
        GameTooltip:AddLine(RETRIEVING_ITEM_INFO, 1, 0, 0)
    end

    GameTooltip:Show()
end
local function makeItemButton(parent)
    local button = CreateFrame(AppearanceTooltip.CLASSIC and "BUTTON" or "ItemButton", nil, parent, AppearanceTooltip.CLASSIC and "ItemButtonTemplate" or nil)
    -- classic
    if not button.SetItem then
        function button:SetItem(item)
            local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subclassID = C_Item.GetItemInfoInstant(item)
            if itemID then
                self.itemID = itemID
                SetItemButtonTexture(button, icon)
            end
        end
        function button:GetItemID()
            return self.itemID
        end
        function button:GetItemLink()
            return select(2, C_Item.GetItemInfo(self.itemID))
        end
    end
    button:SetScript("OnEnter", button_onenter)
    button:SetScript("OnLeave", GameTooltip_Hide)
    return button
end

-- and the actual config now

local categoryID

-- local demoButtons = {}
local function refresh(_, value)
    AppearanceTooltip.RefreshOverlayFrames()
    -- for itemID, button in pairs(demoButtons) do
    --     AppearanceTooltip.CleanButton(button)
    --     AppearanceTooltip.UpdateButtonFromItem(button, Item:CreateFromItemID(itemID), "character")
    -- end
end

do
    local panel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
    panel:Hide()
    panel:SetAllPoints()
    panel.name = AppearanceTooltipLocal

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

local dressed = newCheckbox(panel, 'dressed', '穿衣状态', "显示穿着你当前装备的模型，而不是预览的物品")
    local dressed_ensemble = newCheckbox(panel, 'dressed_ensemble', '穿戴装备（套装）', "如上所述，但专门用于套装")
local uncover = newCheckbox(panel, 'uncover', '不显示已预览缓存', "移除可能遮挡你要预览物品的衣物")
local mousescroll = newCheckbox(panel, 'mousescroll', '鼠标滚轮旋转', "使用鼠标滚轮旋转提示框中的模型")
local spin = newCheckbox(panel, 'spin', '旋转模型', "显示时持续旋转模型")
local notifyKnown = newCheckbox(panel, 'notifyKnown', '提示是否已收藏', "显示标签表明你是否已经拥有该物品外观")
local currentClass = newCheckbox(panel, 'currentClass', '仅限当前角色', "只在当前角色可收集的物品上显示预览")
local byComparison = newCheckbox(panel, 'byComparison', '在对比框显示', "如果对比提示框显示在预览想要显示的位置，则显示在其旁边（这使得预览覆盖你的光标的概率大大降低）")
local tokens = newCheckbox(panel, 'tokens', '可预览套装', "当鼠标悬停在代币上时，显示各种代币可兑换物品的预览")
    local alerts = newCheckbox(panel, 'alerts', '弹窗提示你获得的新幻化', "每当你学会新外观时显示弹出提醒（就像你在交易站购买东西时显示的那种）")

local zoomWorn = newCheckbox(panel, 'zoomWorn', '仅显示该装备部位', "放大显示模型穿该物品的部分")
local zoomHeld = newCheckbox(panel, 'zoomHeld', '不保持手持状态', "放大预览手持物品，不显示你的角色")
local zoomMasked = newCheckbox(panel, 'zoomMasked', '放大时屏蔽模型', "放大时隐藏玩家模型的细节（像幻化衣柜一样）")

    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        -- C_TransmogCollection.GetAppearanceCameraID doesn't return anything useful in Classic Era
        zoomWorn:SetEnabled(false)
        zoomMasked:SetEnabled(false)
    end

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
    dressed_ensemble:SetPoint("TOPLEFT", dressed, "BOTTOMLEFT", 0, -4)
    uncover:SetPoint("TOPLEFT", dressed_ensemble, "BOTTOMLEFT", 0, -4)
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

    local demo = CreateFrame("Frame", nil, panel)
    demo:SetPoint("TOPRIGHT", panel, 0, -20)
    demo:SetPoint("RIGHT", panel)
    demo:SetWidth(43)
    demo:SetScript("OnShow", function(self)
        local previousButton
        for _, itemLinkOrID in ipairs(AppearanceTooltip.CLASSIC and {19019, 19364, 10328, 11122, 23192, 7997, 14047} or {120978, 185060, 253346, 260411, 86079, 257547, 44168, 93031, 248934}) do
            local button = makeItemButton(self)
            if not previousButton then
                button:SetPoint("TOPRIGHT")
            else
                button:SetPoint("TOPRIGHT", previousButton, "BOTTOMRIGHT", 0, 2)
            end
            button:SetItem(itemLinkOrID)
            local item
            if type(itemLinkOrID) == "string" then
                item = Item:CreateFromItemLink(itemLinkOrID)
            else
                item = Item:CreateFromItemID(itemLinkOrID)
            end
            AppearanceTooltip.UpdateButtonFromItem(button, item)
            -- demoButtons[itemLinkOrID] = button
            previousButton = button
        end
        self:SetScript("OnShow", nil)
    end)

    local category, layout = Settings.RegisterCanvasLayoutCategory(panel, panel.name, panel.name)
    Settings.RegisterAddOnCategory(category)
    categoryID = category:GetID()
end

-- Overlay config

do
    local panel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
    panel:Hide()
    panel:SetAllPoints()
    panel.name = "强化显示"
    panel.parent = categoryID

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

    local bagicon = CreateAtlasMarkup("bags-icon-addslots")  --transmog-icon-hidden
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
    local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, panel, panel.name)
end

-- Slash handler
SlashCmdList.APPEARANCETOOLTIP = function(msg)
    if categoryID then
        Settings.OpenToCategory(categoryID)
    end
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

AppearanceTooltip.overlayFrames = {}

function AppearanceTooltip.RefreshOverlayFrames()
    for button in pairs(AppearanceTooltip.overlayFrames) do
        AppearanceTooltip.PrepareItemButton(button)
    end
end

function AppearanceTooltip:SetIconAppearance(icon, link, hasAppearance, appearanceFromOtherItem, probablyEnsemble)
    if LAI:IsAppropriate(link) or probablyEnsemble then
        -- this character can use it
        icon:SetSize(16, 16)
        icon:SetAtlas("bags-icon-addslots")   --CosmeticIconFrame     --transmog-icon-hidden
        icon:SetRotation(0)

        icon.background:SetSize(12, 12)

        if appearanceFromOtherItem then
            -- blue eye
            icon:SetVertexColor(0, 1, 1)
        else
            -- regular purple trasmog-eye
            icon:SetVertexColor(1, 1, 1)
        end
    else
        -- mail icon
        icon:SetSize(12, 12)
        icon:SetAtlas("mailbox")
        icon:SetRotation(1.7 * math.pi)
        icon:SetVertexColor(1, 1, 1)
        -- icon:SetVertexColor(0, 1, 1)
    end
end

local function PrepareItemButton(button, point, offsetx, offsety)
    if button.appearancetooltipoverlay then
        return
    end

    local overlayFrame = CreateFrame("FRAME", nil, button)
    AppearanceTooltip.overlayFrames[button] = overlayFrame
    overlayFrame:SetAllPoints()
    button.appearancetooltipoverlay = overlayFrame

    -- need the sublevel to make sure we're above overlays for e.g. azerite gear
    local sublevel = 4
    if button.IconOverlay then
        sublevel = select(2, button.IconOverlay:GetDrawLayer())
    end

    local icon = overlayFrame:CreateTexture(nil, "OVERLAY", nil, sublevel + 1)
    icon:SetPoint(point or 'TOPLEFT', offsetx or -5, offsety or 5)
    icon:SetScale(1.5)
    overlayFrame.icon = icon

    local background = overlayFrame:CreateTexture(nil, "OVERLAY", nil, sublevel)
    background:SetPoint("CENTER", icon, "CENTER")
    background:SetColorTexture(0, 0, 0, 1)

    local mask = overlayFrame:CreateMaskTexture()
    mask:SetAllPoints(background)
    --mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    mask:SetTexture("Interface/AddOns/OrzUI/Media/backdrop")
    background:AddMaskTexture(mask)

    icon.background = background

    overlayFrame:Hide()
end
AppearanceTooltip.PrepareItemButton = PrepareItemButton

local function IsRelevantItem(link)
    if not link then return end
    if AppearanceTooltip.db.learnable then
        local itemID, _, _, _, _, classID, subclassID = C_Item.GetItemInfoInstant(link)
        if itemID then
            if C_ToyBox and C_ToyBox.GetToyInfo(itemID) then
                return true
            end
            if classID == Enum.ItemClass.Miscellaneous and subclassID == Enum.ItemMiscellaneousSubclass.Mount then
                -- if C_MountJournal and C_MountJournal.GetMountFromItem(itemID) then
                return true
            end
            if classID == Enum.ItemClass.Miscellaneous and subclassID == Enum.ItemMiscellaneousSubclass.CompanionPet then
                -- local petID = C_PetJournal and C_PetJournal.GetPetInfoByItemID and select(13, C_PetJournal.GetPetInfoByItemID(itemID))
                -- if petID then
                return true
            end
            if _G.HOUSING_DECOR_OWNED_COUNT_FORMAT and classID == Enum.ItemClass.Housing and subclassID == Enum.ItemHousingSubclass.Decor then
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
        AppearanceTooltip:SetIconAppearance(button.appearancetooltipoverlay.icon, link, hasAppearance, appearanceFromOtherItem, probablyEnsemble)
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
AppearanceTooltip.UpdateButtonFromItem = UpdateButtonFromItem

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

-- Main bank frame, bankbags are covered by containerframe above
if _G.BankFrameItemButton_Update then
    -- pre-11.2.0 bank
    hooksecurefunc("BankFrameItemButton_Update", function(button)
        if not button.isBag then
            UpdateContainerButton(button, -1)
        end
    end)
end

do
    local function hookBankPanel(panel)
        if not panel then return end
        local update = function(frame)
            for itemButton in frame:EnumerateValidItems() do
                UpdateContainerButton(itemButton, itemButton:GetBankTabID(), itemButton:GetContainerSlotID())
            end
        end
        -- Initial load and switching tabs
        hooksecurefunc(panel, "GenerateItemSlotsForSelectedTab", update)
        -- Moving items
        hooksecurefunc(panel, "RefreshAllItemsForSelectedTab", update)
    end
    hookBankPanel(_G.BankPanel) -- added in 11.2.0
    hookBankPanel(_G.AccountBankPanel) -- removed in 11.2.0
end

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
        -- AppearanceTooltip.Debug("LootFrame_UpdateButton", button:IsEnabled(), button.slot, button.slot and GetLootSlotLink(button.slot))
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



--[[ Butsu
f:RegisterAddonHook("Butsu", function()
    hooksecurefunc(Butsu, "LOOT_OPENED", function(self, event, autoloot)
        if not self:IsShown() then return end
        local items = GetNumLootItems()
        if items > 0 then
            for i=1, items do
                local slot = _G["ButsuSlot" .. i]
                if slot and slot.appearancetooltipoverlay then slot.appearancetooltipoverlay:Hide() end
                if AppearanceTooltip.db.loot then
                    local link = GetLootSlotLink(i)
                    if slot and link then
                        UpdateOverlay(slot, link, "RIGHT", -6)
                    end
                end
            end
        end
    end)
end)]]
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
    Baganator.API.RegisterCornerWidget("appearancetooltip", "appearancetooltip",
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
            frame:SetSize(12, 12)
            PrepareItemButton(frame, "CENTER", 0, 0)
            return frame
        end,
        {default_position = "bottom_left", priority = 1}
    )
end)

EventRegistry:RegisterFrameEventAndCallback("TRANSMOG_COLLECTION_SOURCE_ADDED", function(_, itemModifiedAppearanceID)
    if not _G.NewCosmeticAlertFrameSystem then
        return
    end
    -- print("TRANSMOG_COLLECTION_SOURCE_ADDED", itemModifiedAppearanceID, C_ContentTracking.IsTracking(Enum.ContentTrackingType.Appearance, itemModifiedAppearanceID))
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
end, "appearancetooltip")