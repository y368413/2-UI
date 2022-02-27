-- Using the Combuctor way to retrieve names, namespaces and stuff
local MODULE, moduleData =  ...
local ADDON, Addon = MODULE:match("[^_]+"), _G[MODULE:match("[^_]+")]
local Module = Combuctor:NewModule("RequiredLevel", Addon)

local Unfit = LibStub('Unfit-1.0')

-- Lua API
local _G = _G
local string_find = string.find
local string_gsub = string.gsub
local string_match = string.match
local tonumber = tonumber

-- WoW API
local CreateFrame = _G.CreateFrame
local GetItemInfo = _G.GetItemInfo
local GetSpellInfo = _G.GetSpellInfo
local GetProfessions = _G.GetProfessions
local GetProfessionInfo = _G.GetProfessionInfo
local UnitLevel = _G.UnitLevel

local SpellBook_GetSpellBookSlot = _G.SpellBook_GetSpellBookSlot


-- WoW Strings
local ITEM_MIN_SKILL = _G.ITEM_MIN_SKILL
local ITEM_SPELL_KNOWN = _G.ITEM_SPELL_KNOWN
local LE_ITEM_CLASS_RECIPE = _G.LE_ITEM_CLASS_RECIPE
local LE_ITEM_RECIPE_BOOK = _G.LE_ITEM_RECIPE_BOOK


local locale = GetLocale()




-- Very cool trick by MunkDev: https://www.wowinterface.com/forums/showthread.php?p=325688#post325688
local function StopLastSound()
  -- Play some sound to get a handle.
  local _, handle = PlaySound(SOUNDKIT[next(SOUNDKIT)], "SFX", false)
  if handle then
    -- print("muting sound", handle)
    -- Stop this sound and the previous.
    StopSound(handle-1)
    StopSound(handle)
  end
end



-- For Classic there is no GetProfessions() so we have to scan the spell book for
-- spells indicating that a profession was learned.
local professionSpells = nil
if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
  
  -- For the SpellButton frames to be available even before the SpellBook has been opened by a player,
  -- I need to open it silently.
  local learnedSpellEventFrame = CreateFrame("Frame")
  learnedSpellEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
  -- Listening to LEARNED_SPELL_IN_TAB should not be necessary, because SpellBookFrame itself
  -- listens to it and calls SpellBookFrame_Update() then.
  learnedSpellEventFrame:SetScript("OnEvent", function()
  
        -- Calling SpellBookFrame_Update() would be enough, but it spreads taint over the spellbook.
        -- ToggleSpellBook() ToggleSpellBook() is also not possible for some reason.
        -- But SpellBookFrame:Show() SpellBookFrame:Hide() works.
        if not SpellBookFrame:IsShown() then
          SpellBookFrame:Show()
          StopLastSound()
          SpellBookFrame:Hide()
          StopLastSound()
        end
        
        -- -- For testing:
        -- for i = 1, 24 do
          -- if _G["SpellButton" .. i] then
            -- print(i, _G["SpellButton" .. i])
            -- local slot, slotType, slotID = SpellBook_GetSpellBookSlot(_G["SpellButton" .. i])
            -- if slot then
              -- print(slot, slotType, slotID)
            -- end
          -- end
        -- end
    end)

  -- This table maps spell IDs (as returned by SpellBook_GetSpellBookSlot())
  -- e.g. https://classic.wowhead.com/spell=818/basic-campfire
  -- to profession subclassID (as returned by GetItemInfo()).
  -- https://wowpedia.fandom.com/wiki/ItemType#9:_Recipe
  -- Thus, you can check if the player knows a certain profession, which does not
  -- seem to be possible otherwise in Classic, where there is no GetProfessions().
  professionSpells = {

     [2108] = 1, -- Leatherworking Apprentice
     [3104] = 1, -- Leatherworking Journeyman
     [3811] = 1, -- Leatherworking Expert
    [10662] = 1, -- Leatherworking Artisan
    [32549] = 1, -- Leatherworking Master (BC)

     [3908] = 2, -- Tailoring Apprentice
     [3909] = 2, -- Tailoring Journeyman
     [3910] = 2, -- Tailoring Expert
    [12180] = 2, -- Tailoring Artisan
    [26790] = 2, -- Tailoring Master (BC)

     [4036] = 3, -- Engineering Apprentice
     [4037] = 3, -- Engineering Journeyman
     [4038] = 3, -- Engineering Expert
    [12656] = 3, -- Engineering Artisan
    [30350] = 3, -- Engineering Master (BC)

     [2018] = 4, -- Blacksmithing Apprentice
     [3100] = 4, -- Blacksmithing Journeyman
     [3538] = 4, -- Blacksmithing Expert
     [9785] = 4, -- Blacksmithing Artisan
    [29844] = 4, -- Blacksmithing Master (BC)

      [818] = 5, -- Basic Campfire (Cooking)

     [2259] = 6, -- Alchemy Apprentice
     [3101] = 6, -- Alchemy Journeyman
     [3464] = 6, -- Alchemy Expert
    [11611] = 6, -- Alchemy Artisan
    [28596] = 6, -- Alchemy Master (BC)

     [3273] = 7, -- First Aid Apprentice
     [3274] = 7, -- First Aid Journeyman
     [7924] = 7, -- First Aid Expert
    [10846] = 7, -- First Aid Artisan
    [27028] = 7, -- First Aid Master (BC)

     [7411] = 8, -- Enchanting Apprentice
     [7412] = 8, -- Enchanting Journeyman
     [7413] = 8, -- Enchanting Expert
    [13920] = 8, -- Enchanting Artisan
    [28029] = 8, -- Enchanting Master (BC)

     [7620] = 9, -- Fishing Apprentice
     [7731] = 9, -- Fishing Journeyman
     [7732] = 9, -- Fishing Expert
    [18248] = 9, -- Fishing Artisan
    [33095] = 9, -- Fishing Master (BC)

    [25229] = 10, -- Jewelcrafting Apprentice
    [25230] = 10, -- Jewelcrafting Journeyman
    [28894] = 10, -- Jewelcrafting Expert
    [28895] = 10, -- Jewelcrafting Artisan
    [28897] = 10, -- Jewelcrafting Master (BC)

    -- No Inscription as of BCC.

    -- We are only interested in professions with recipes
    -- so no gathering skills here!
  }

end



-- Retrieve an itemSlot's plugin container.
local GetPluginContainter = function(itemSlot)
  local name = itemSlot:GetName() .. "RequiredLevelFrame"
  local frame = _G[name]
  if (not frame) then
    -- Adding an extra layer to get it above glow and border textures.
    frame = CreateFrame("Frame", name, itemSlot)
    frame:SetAllPoints()
  end
  return frame
end




-- Cache of ItemBind texts (Goldpaw's Combuctor_BoE).
local Cache_ItemBind = {}
local Cache_GetItemBind = function(itemSlot)
  local goldpawFrame = _G[itemSlot:GetName().."ExtraInfoFrame"]
  if goldpawFrame then
    for _, child in ipairs({goldpawFrame:GetRegions()}) do
      if child:IsObjectType("FontString") then
        local text = child:GetText()
        if text == "BoE" or text == "BoU" then
          Cache_ItemBind[itemSlot] = child
          return Cache_ItemBind[itemSlot]
        end
      end
    end
  end
end




-- Cache of RequiredLevel texts.
local Cache_RequiredLevel = {}
local Cache_GetRequiredLevel = function(itemSlot)

  -- Using standard blizzard fonts here
  local RequiredLevel = GetPluginContainter(itemSlot):CreateFontString()
  RequiredLevel:SetDrawLayer("ARTWORK", 1)
  RequiredLevel:SetPoint("BOTTOM", 0, -5)
  RequiredLevel:SetTextColor(.95, .05, .95)

  Cache_RequiredLevel[itemSlot] = RequiredLevel

  return RequiredLevel
end


-- Tooltip used for scanning.
local scannerTooltip = CreateFrame("GameTooltip", "CombuctorRequiredLevelScannerTooltip", nil, "GameTooltipTemplate")
scannerTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

local bankButtonIdOffset = BankButtonIDToInvSlotID(1) - 1

-- Function to set the tooltip to the current item.
local SetTooltip = function(itemSlot)

  -- Clear the tooltip.
  scannerTooltip:ClearLines()

  if not itemSlot.info.cached then

    if itemSlot:GetBag() == -1 then
      -- SetBagItem() does not work for bank slots. So we use this instead.
      -- (Thanks to p3lim: https://www.wowinterface.com/forums/showthread.php?p=331883)
      scannerTooltip:SetInventoryItem('player', itemSlot:GetID() + bankButtonIdOffset)
    else
      scannerTooltip:SetBagItem(itemSlot:GetBag(), itemSlot:GetID())
    end

    -- If the above fails for some reason, we will do SetHyperlink(), too.
    if scannerTooltip:NumLines() > 0 then return end

  end

  -- The above will fail for cached items; like bank slots while not
  -- at the bank or bags of other characters. In this case we use
  -- SetHyperlink(), which may sometimes not capture all stats of itemSlot
  -- of which there are different versions.
  scannerTooltip:SetHyperlink(itemSlot:GetItem())

end



local ItemNeedsLockpicking = function(itemSlot)

  SetTooltip(itemSlot)

  -- Get the localised name for Lockpicking.
  local localisedLockpicking = GetSpellInfo(1809)

  -- https://www.lua.org/pil/20.2.html
  -- "%s?%%.-s%s" matches both " %s " (EN), "%s " (FR) and " %1$s " (DE) in ITEM_MIN_SKILL.
  -- "%(%%.-d%)%s?" matches both "(%d)" (EN), "(%d) " (FR) and "(%2$d)" (DE) in ITEM_MIN_SKILL.
  searchPattern = string_gsub(string_gsub("^" .. ITEM_MIN_SKILL .. "$", "%s?%%.-s%s", ".-" .. localisedLockpicking .. ".-%%s"), "%(%%.-d%)%s?", "%%((%%d+)%%)%%s?")

  -- Tooltip and scanning by Phanx (https://www.wowinterface.com/forums/showthread.php?p=270331#post270331)
  for i = scannerTooltip:NumLines(), 2, -1 do
    local line = _G[scannerTooltip:GetName().."TextLeft"..i]
    if line then
      local msg = line:GetText()
      if msg then
        if string_find(msg, searchPattern) then
          local requiredSkill = string_match(msg, searchPattern)
          local _, g = line:GetTextColor()
          return true, (tonumber(g) < 0.2), requiredSkill
        end
      end
    end
  end

end



-- Function to return if the character has a certain profession.
-- For "Book" recipes we have to scan the tooltip
-- in order to extract and return the profession name.
-- 
-- For testing we allow the function call with itemId only and itemSlot == nil.
local CharacterHasProfession = function(itemSlot, itemId)

  if not itemId then
    -- We could also use the item link returned by itemSlot:GetItem() as
    -- the argument for GetItemInfo() but we need itemId to check for
    -- items with special treatment.
    itemId = tonumber(string_match(itemSlot:GetItem(), "^.-:(%d+):"))
  end
  
  local _, _, _, _, _, _, itemSubType, _, _, _, _, _, itemSubTypeId = GetItemInfo(itemId)


  -- For Classic there is no GetProfessions() so we have to scan the spell book for
  -- spells indicating that a profession was learned.
  if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then

    for i = 1, 24 do
      if _G["SpellButton" .. i] then
        local slot, slotType, slotID = SpellBook_GetSpellBookSlot(_G["SpellButton" .. i])
        if slot then
          -- print(slot, slotType, slotID, GetSpellBookItemName(slot, SpellBookFrame.bookType))
          if professionSpells[slotID] == itemSubTypeId then
            return true, itemSubType
          end
        end
      end
    end

    return false, nil
  end


  -- "Design: Mass Prospect Empyrium" (152726) is falsely identified with itemSubType == "Inscription".
  -- And for books we cannot get the profession at all, which is why we have to scan the tooltip.
  if itemId == 152726 or itemSubTypeId == LE_ITEM_RECIPE_BOOK then

    if itemSlot then
      SetTooltip(itemSlot)
    else
      -- If this was called for testing with itemId only.
      scannerTooltip:ClearLines()
      scannerTooltip:SetHyperlink("item:" .. itemId .. ":0:0:0:0:0:0:0")
    end

    -- Cannot do "for .. in ipairs", because if one profession is missing,
    -- the iteration would stop...
    local professionList = {}
    professionList[1], professionList[2], professionList[3], professionList[4], professionList[5] = GetProfessions()
    for i = 1, 5 do
      if professionList[i] then

        local professionName = GetProfessionInfo(professionList[i])

        -- https://www.lua.org/pil/20.2.html
        -- "%s?%%.-s%s" matches both " %s " (EN), "%s " (FR) and " %1$s " (DE) in ITEM_MIN_SKILL.
        -- "%(%%.-d%)%s?" matches both "(%d)" (EN), "(%d) " (FR) and "(%2$d)" (DE) in ITEM_MIN_SKILL.
        searchPattern = string_gsub(string_gsub("^" .. ITEM_MIN_SKILL .. "$", "%s?%%.-s%s", ".-" .. professionName .. ".-%%s"), "%(%%.-d%)%s?", ".-")

        -- Tooltip and scanning by Phanx (https://www.wowinterface.com/forums/showthread.php?p=270331#post270331)
        for i = scannerTooltip:NumLines(), 2, -1 do
          local line = _G[scannerTooltip:GetName().."TextLeft"..i]
          if line then
            local msg = line:GetText()
            if msg then
              if string_find(msg, searchPattern) then
                return true, professionName
              end
            end
          end
        end

      end
    end

    -- Check if this is a book without any profession.
    -- Like e.g. "Rockin' Rollin' Racer Pack" (187560).
    -- (searchPattern is the same as above but with .- instead of professionName) 
    searchPattern = string_gsub(string_gsub("^" .. ITEM_MIN_SKILL .. "$", "%s?%%.-s%s", ".-%%s"), "%(%%.-d%)%s?", ".-")
    for i = scannerTooltip:NumLines(), 2, -1 do
      local line = _G[scannerTooltip:GetName().."TextLeft"..i]
      if line then
        local msg = line:GetText()
        if msg then
          -- This book actually has a profession, which the character does not know.
          if string_find(msg, searchPattern) then
            return false, nil
          end
        end
      end
    end

    -- This book has no profession.
    return true, nil

  -- For all other recipes, itemSubType is also the profession name.
  else
    -- Cannot do "for .. in ipairs", because if one profession is missing,
    -- the iteration would stop...
    local professionList = {}
    professionList[1], professionList[2], professionList[3], professionList[4], professionList[5] = GetProfessions()
    for i = 1, 5 do
      if professionList[i] then
        if itemSubType == GetProfessionInfo(professionList[i]) then
          return true, itemSubType
        end
      end
    end

    return false, nil
  end

end



-- expansionPrefixes:
-- Define here what should be printed before the skill level of recipes.
moduleData.EP_VANILLA =  "1"
moduleData.EP_BC =       "2"
moduleData.EP_WRATH =    "3"
moduleData.EP_CATA =     "4"
moduleData.EP_PANDARIA = "5"
moduleData.EP_WOD =      "6"
moduleData.EP_LEGION =   "7"
moduleData.EP_BFA =      "8"
moduleData.EP_SL =       "9"



-- Input:   professionName  : The localised profession name to search for.
--          itemSlot        : The current itemSlot; needed to set tooltip.
-- Output:  alreadyKnown    : True if recipe is already known.
--          notEnoughSkill  : True if character does not have enough profession skill.
--          expansionPrefix : Prefix depending on the recipe's WoW expansion.
--          requiredSkill   : Required profession skill to learn recipe.
local ReadRecipeTooltip = function(professionName, itemSlot)

  SetTooltip(itemSlot)

  -- https://www.lua.org/pil/20.2.html
  local searchPattern = nil
  local searchOnlySkillPattern = nil

  -- If the locale is not known, just search for the required skill and ignore the expansion.
  -- The same, if we are in Classic or BCC, because there were no expansion specific profession levels then.
  if not moduleData.itemMinSkillString[locale] or not moduleData.expansionIdentifierToVersionNumber[locale]
      or WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
    searchOnlySkillPattern = "^.*%((%d+)%).*$"
  else
    -- ITEM_MIN_SKILL = "Requires %s (%d)"
    -- ...must be turned into: "^Requires%s(.*)%s?" .. localisedItemMinSkill .. "%s%((%d+)%)$"
    -- But watch out: For different locales the order of words is different (see below)!

    -- Need %%%%s here, because this string will be inserted twice.
    local localisedItemMinSkill = string_gsub(string_gsub(string_gsub(moduleData.itemMinSkillString[locale], " ", "%%%%s?"), "e", "(.*)"), "p", professionName)

    -- "%s?%%.-s%s" matches both " %s " (EN), "%s " (FR) and " %1$s " (DE) in ITEM_MIN_SKILL.
    -- "%(%%.-d%)%s?" matches both "(%d)" (EN), "(%d) " (FR) and "(%2$d)" (DE) in ITEM_MIN_SKILL.
    searchPattern = string_gsub(string_gsub("^" .. ITEM_MIN_SKILL .. "$", "%s?%%.-s%s", "%%s?" .. localisedItemMinSkill .. "%%s"), "%(%%.-d%)%s?", "%%((%%d+)%%)%%s?")
  end

  -- Tooltip and scanning by Phanx (https://www.wowinterface.com/forums/showthread.php?p=270331#post270331)

  -- In classic we have to search from top to bottom, because the "Requires ingredients (amount)" line
  -- is further below, which also matches our regular expression.
  local start = scannerTooltip:NumLines()
  local stop = 2
  local incr = -1
  if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
    start = 2
    stop = scannerTooltip:NumLines()
    incr = 1
  end

  for i = start, stop, incr do
    local line = _G[scannerTooltip:GetName().."TextLeft"..i]
    if line then
      local msg = line:GetText()
      if msg then

        if msg == ITEM_SPELL_KNOWN then
          -- If the recipe is already known, we are not interested in its required skill level!
          return true, nil, nil, nil

        elseif searchPattern and string_find(msg, searchPattern) then

          local expansionIdentifier, requiredSkill = string_match(msg, searchPattern)
          -- Trim trailing blank space if any.
          expansionIdentifier = string_gsub(expansionIdentifier, "^(.-)%s$", "%1")

          -- Check if recipe can be learned, i.e. text is not red.
          local _, g = line:GetTextColor()

          -- Check if the expansionIdentifier is actually known.
          local expansionPrefix = moduleData.expansionIdentifierToVersionNumber[locale][expansionIdentifier]
          if not expansionPrefix then
            print ("Combuctor_RequiredLevel (ERROR): Could not find", expansionIdentifier, "for", locale)
            expansionPrefix = "?"
          end

          return false, (tonumber(g) < 0.2), expansionPrefix .. ".", requiredSkill

        elseif searchOnlySkillPattern and string_find(msg, searchOnlySkillPattern) then
          local requiredSkill = string_match(msg, searchOnlySkillPattern)
          -- Check if recipe can be learned, i.e. text is not red.
          local _, g = line:GetTextColor()
          return false, (tonumber(g) < 0.2), "", requiredSkill
        end
      end
    end
  end

  -- We may actually reach here if a non-recipe item swaps slots with a recipe item.
  return nil, nil, nil, nil

end



local PostUpdateButton = function(itemSlot)

  local itemLink = itemSlot:GetItem()
  if itemLink then
  
    local item = Item:CreateFromItemLink(itemLink)
    if not item:IsItemEmpty() then
      item:ContinueOnItemLoad(function()

        -- Locked items should always be greyed out.
        if itemSlot.info.locked then
          local buttonIconTexture = _G[itemSlot:GetName().."IconTexture"]
          buttonIconTexture:SetVertexColor(1,1,1)
          buttonIconTexture:SetDesaturated(1)
        end

        -- Retrieve or create this itemSlot's RequiredLevel text.
        local RequiredLevel = Cache_RequiredLevel[itemSlot] or Cache_GetRequiredLevel(itemSlot)
        -- Got to set a default font.
        RequiredLevel:SetFont("Fonts\\ARIALN.TTF", 14, "OUTLINE")

        -- Get some blizzard info about the current item.
        local _, _, _, _, itemMinLevel, _, itemSubType, _, _, _, _, itemTypeId, itemSubTypeId = GetItemInfo(itemLink)


        -- Get Goldpaw's "BoE" text and hide it, if it exists.
        -- It will be shown later if not replaced by "required level" text.
        local ItemBind = nil
        if _G[itemSlot:GetName().."ExtraInfoFrame"] then
          ItemBind = Cache_ItemBind[itemSlot] or Cache_GetItemBind(itemSlot)
          if ItemBind then ItemBind:Hide() end
        end


        -- Check for Junkboxes and Lockboxes (Miscellaneous Junk).
        if itemTypeId == 15 and itemSubTypeId == 0 then
          local itemNeedsLockpicking, notEnoughSkill, requiredSkill = ItemNeedsLockpicking(itemSlot)

          if itemNeedsLockpicking then
            if notEnoughSkill then

              RequiredLevel:SetFont("Fonts\\ARIALN.TTF", 12, "OUTLINE")
              RequiredLevel:SetText(requiredSkill)

              if not itemSlot.info.locked then
                local buttonIconTexture = _G[itemSlot:GetName().."IconTexture"]
                buttonIconTexture:SetVertexColor(1,.3,.3)
                buttonIconTexture:SetDesaturated(1)
              end
              return
            end
          end
        end


        if itemMinLevel then
          if itemMinLevel > UnitLevel("player") then

            if not Unfit:IsItemUnusable(itemLink) then
              RequiredLevel:SetText(itemMinLevel)
              if not itemSlot.info.locked then
                local buttonIconTexture = _G[itemSlot:GetName().."IconTexture"]
                buttonIconTexture:SetVertexColor(1,.3,.3)
                buttonIconTexture:SetDesaturated(1)
              end
            else
              if ItemBind then ItemBind:Show() end
            end
            return
          end
        end

        -- LE_ITEM_CLASS_RECIPE by Kanegasi (https://www.wowinterface.com/forums/showthread.php?p=330514#post330514)
        if itemTypeId == LE_ITEM_CLASS_RECIPE then

          -- For almost all recipes, itemSubType is also the profession name.
          -- https://wow.gamepedia.com/ItemType
          -- However, for "Book" recipes we have to extract the profession name from
          -- the tooltip. We do this at the same time as checking if the player has
          -- the profession at all. Thus, we only have to scan the tooltip for the professions
          -- the player has.
          local hasProfession, professionName = CharacterHasProfession(itemSlot)

          if not hasProfession then
            if ItemBind then ItemBind:Show() end
            RequiredLevel:SetText("")
            if Addon.sets.glowUnusable then
              r, g, b = RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b
              itemSlot.IconBorder:SetTexture(id and C_ArtifactUI.GetRelicInfoByItemID(id) and 'Interface\\Artifacts\\RelicIconFrame' or 'Interface\\Common\\WhiteIconFrame')
              itemSlot.IconBorder:SetVertexColor(r, g, b)
              itemSlot.IconBorder:SetShown(r)
              itemSlot.IconGlow:SetVertexColor(r, g, b, Addon.sets.glowAlpha)
              itemSlot.IconGlow:SetShown(r)
            end
            return
          end
          
          if not professionName then
            -- print("This was a book without profession!")
            return
          end

          -- Scan tooltip. (Not checking for itemSubTypeId != LE_ITEM_RECIPE_BOOK here because of efficiency.)
          local alreadyKnown, notEnoughSkill, expansionPrefix, requiredSkill = ReadRecipeTooltip(professionName, itemSlot)

          if alreadyKnown then
            if ItemBind then ItemBind:Show() end
            RequiredLevel:SetText("")
            if not itemSlot.info.locked then
              local buttonIconTexture = _G[itemSlot:GetName().."IconTexture"]
              buttonIconTexture:SetVertexColor(.4,.4,.4)
              buttonIconTexture:SetDesaturated(1)
            end
            return
          end

          if notEnoughSkill then

            RequiredLevel:SetFont("Fonts\\ARIALN.TTF", 12, "OUTLINE")
            RequiredLevel:SetText(expansionPrefix .. requiredSkill)

            if not itemSlot.info.locked then
              local buttonIconTexture = _G[itemSlot:GetName().."IconTexture"]
              buttonIconTexture:SetVertexColor(1,.3,.3)
              buttonIconTexture:SetDesaturated(1)
            end
            return
          end

          -- Recipe is actually learnable.
          if ItemBind then ItemBind:Show() end
          RequiredLevel:SetText("")
          if not itemSlot.info.locked then
            local buttonIconTexture = _G[itemSlot:GetName().."IconTexture"]
            buttonIconTexture:SetVertexColor(1,1,1)
            buttonIconTexture:SetDesaturated(nil)
          end
          return
        end

        -- Any other item.
        if ItemBind then ItemBind:Show() end
        RequiredLevel:SetText("")
        if not itemSlot.info.locked then
          local buttonIconTexture = _G[itemSlot:GetName().."IconTexture"]
          buttonIconTexture:SetVertexColor(1,1,1)
          buttonIconTexture:SetDesaturated(nil)
        end
      end)
    end
  else
    if Cache_RequiredLevel[itemSlot] then
      Cache_RequiredLevel[itemSlot]:SetText("")
    end
  end
end



local PostUpdateButtonWrapper = function(itemSlot)

  -- Hide the goldpawFrame until after PostUpdateButton has had a chance
  -- to hide the "BoE" text in it.
  local goldpawFrame = _G[itemSlot:GetName().."ExtraInfoFrame"]
  if goldpawFrame then goldpawFrame:Hide() end
  PostUpdateButton(itemSlot)
  if goldpawFrame then goldpawFrame:Show() end

end

local item = Combuctor.ItemSlot or Combuctor.Item
if item then

  if item.Update then
    hooksecurefunc(item, "Update", PostUpdateButtonWrapper)
  end

  -- Needed because otherwise UpdateUpgradeIcon will reset the VertexColor.
  if item.UpdateUpgradeIcon then
    hooksecurefunc(item, "UpdateUpgradeIcon", PostUpdateButtonWrapper)
  end

  -- Needed to set the VertexColor in time, when BAG_UPDATE_COOLDOWN is triggered.
  if item.UpdateCooldown then
    hooksecurefunc(item, "UpdateCooldown", PostUpdateButtonWrapper)
  end

  -- Needed to keep the frame of unusable recipes.
  if item.OnEnter then
    hooksecurefunc(item, "OnEnter", PostUpdateButtonWrapper)
  end
  if item.OnLeave then
    hooksecurefunc(item, "OnLeave", PostUpdateButtonWrapper)
  end

  -- Needed to keep the desaturation.
  if item.SetLocked then
    hooksecurefunc(item, "SetLocked", PostUpdateButtonWrapper)
  end

end


-- The %s in _G.ITEM_MIN_SKILL = "Requires %s (%d)" is replaced
-- by an expansion identifier and the profession name.
-- But the order depends on the locale.
-- e: expansion identifier
-- p: profession name
moduleData.itemMinSkillString = {
  ["enUS"] = "e p",
  ["enGB"] = "e p",
  ["deDE"] = "p e",
  ["frFR"] = "p e",
  ["itIT"] = "p e",
  ["esES"] = "p e",
  ["esMX"] = "p e",
}

moduleData.expansionIdentifierToVersionNumber = {
  ["enUS"] = {
    [""] =                      moduleData.EP_VANILLA,
    ["Outland"] =               moduleData.EP_BC,
    ["Northrend"] =             moduleData.EP_WRATH,
    ["Cataclysm"] =             moduleData.EP_CATA,
    ["Pandaria"] =              moduleData.EP_PANDARIA,
    ["Draenor"] =               moduleData.EP_WOD,
    ["Legion"] =                moduleData.EP_LEGION,
    ["Zandalari"] =             moduleData.EP_BFA,
    ["Kul Tiran"] =             moduleData.EP_BFA,
    ["Shadowlands"] =           moduleData.EP_SL,
  },
  ["enGB"] = {
    [""] =                      moduleData.EP_VANILLA,
    ["Outland"] =               moduleData.EP_BC,
    ["Northrend"] =             moduleData.EP_WRATH,
    ["Cataclysm"] =             moduleData.EP_CATA,
    ["Pandaria"] =              moduleData.EP_PANDARIA,
    ["Draenor"] =               moduleData.EP_WOD,
    ["Legion"] =                moduleData.EP_LEGION,
    ["Zandalari"] =             moduleData.EP_BFA,
    ["Kul Tiran"] =             moduleData.EP_BFA,
    ["Shadowlands"] =           moduleData.EP_SL,
  },
  ["deDE"] = {
    [""] =                      moduleData.EP_VANILLA,
    ["der Scherbenwelt"] =      moduleData.EP_BC,
    ["von Nordend"] =           moduleData.EP_WRATH,
    ["des Kataklysmus"] =       moduleData.EP_CATA,
    ["von Pandaria"] =          moduleData.EP_PANDARIA,
    ["von Draenor"] =           moduleData.EP_WOD,
    ["der Verheerten Inseln"] = moduleData.EP_LEGION,
    ["von Zandalar"] =          moduleData.EP_BFA,
    ["von Kul Tiras"] =         moduleData.EP_BFA,
    ["der Schattenlande"] =     moduleData.EP_SL,
  },
  ["frFR"] = {
    [""] =                      moduleData.EP_VANILLA,
    ["de l’Outreterre"] =       moduleData.EP_BC,
    ["du Norfendre"] =          moduleData.EP_WRATH,
    ["de Cataclysm"] =          moduleData.EP_CATA,
    ["de Pandarie"] =           moduleData.EP_PANDARIA,
    ["de Draenor"] =            moduleData.EP_WOD,
    ["de Legion"] =             moduleData.EP_LEGION,
    ["de Zandalar"] =           moduleData.EP_BFA,
    ["de Kul Tiras"] =          moduleData.EP_BFA,
    ["d’Ombreterre"] =          moduleData.EP_SL,
  },
  ["itIT"] = {
    [""] =                      moduleData.EP_VANILLA,
    ["delle Terre Esterne"] =   moduleData.EP_BC,
    ["di Nordania"] =           moduleData.EP_WRATH,
    ["di Cataclysm"] =          moduleData.EP_CATA,
    ["di Pandaria"] =           moduleData.EP_PANDARIA,
    ["di Draenor"] =            moduleData.EP_WOD,
    ["di Legion"] =             moduleData.EP_LEGION,
    ["di Zandalar"] =           moduleData.EP_BFA,
    ["di Kul Tiras"] =          moduleData.EP_BFA,
    ["di Shadowlands"] =        moduleData.EP_SL,
  },
  ["esES"] = {
    [""] =                      moduleData.EP_VANILLA,
    ["de Terrallende"] =        moduleData.EP_BC,
    ["de Rasganorte"] =         moduleData.EP_WRATH,
    ["de Cataclysm"] =          moduleData.EP_CATA,
    ["de Pandaria"] =           moduleData.EP_PANDARIA,
    ["de Draenor"] =            moduleData.EP_WOD,
    ["de Legion"] =             moduleData.EP_LEGION,
    ["Zandalari"] =             moduleData.EP_BFA,
    ["de Kul Tiras"] =          moduleData.EP_BFA,
    ["de Shadowlands"] =        moduleData.EP_SL,
  },
  ["esMX"] = {
    [""] =                      moduleData.EP_VANILLA,
    ["de Terrallende"] =        moduleData.EP_BC,
    ["de Rasganorte"] =         moduleData.EP_WRATH,
    ["de Cataclysm"] =          moduleData.EP_CATA,
    ["de Pandaria"] =           moduleData.EP_PANDARIA,
    ["de Draenor"] =            moduleData.EP_WOD,
    ["de Legion"] =             moduleData.EP_LEGION,
    ["Zandalari"] =             moduleData.EP_BFA,
    ["de Kul Tiras"] =          moduleData.EP_BFA,
    ["de Shadowlands"] =        moduleData.EP_SL,
  },
  
  
  -- Check these items to create more locales...
  -- Outland:     https://www.wowhead.com/item=34126/recipe-shoveltusk-soup
  -- Northrend:   https://www.wowhead.com/item=43036/recipe-dragonfin-filet
  -- Cataclysm:   https://www.wowhead.com/item=62800/recipe-seafood-magnifique-feast
  -- Pandaria:    https://www.wowhead.com/item=74658/recipe-spicy-vegetable-chips
  -- Draenor:     https://www.wowhead.com/item=116347/recipe-burnished-leather-bag
  -- Legion:      https://www.wowhead.com/item=133830/recipe-lavish-suramar-feast
  -- Zandalari:   https://www.wowhead.com/spell=265817/zandalari-cooking
  -- Kul Tiran:   https://www.wowhead.com/spell=264646/kul-tiran-cooking
  -- Shadowlands: https://www.wowhead.com/spell=309831/shadowlands-cooking


}