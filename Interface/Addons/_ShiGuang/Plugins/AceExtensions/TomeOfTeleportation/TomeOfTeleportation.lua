--## Author: Remeen  4.0

-- Tome of Teleportation by Remeen.

-- TODO:
-- More Battle for Azeroth items
-- Improve speed

-- Low priority:
-- Proper options dialog
-- Special case strings start with number to force them to be sorted first.
TeleporterHearthString = "0 Hearth"
TeleporterRecallString = "1 Astral Recall"
TeleporterFlightString = "2 Flight Master"

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local icon = LibStub("LibDBIcon-1.0")
local dataobj = ldb:NewDataObject("TomeTele", {
	label = TOMEOFTELEPORTATIONTITLE, 
	type = "data source", 
	icon = "Interface\\Icons\\Spell_arcane_portalshattrath",  --Interface\\Icons\\Spell_Arcane_TeleportDalaran
	text = "Teleport"
})

local TeleporterParentFrame = nil
local CastSpell = nil
local ItemSlot = nil
local OldItems = {}
local RemoveItem = {}
local ButtonSettings = {}
local IsVisible = false
local NeedUpdate = false
local OpenTime = 0
local ShouldNotBeEquiped = {}
local ShouldBeEquiped = {}
local EquipTime = 0
local CustomizeSpells = false
local RemoveIconOffset = 0
local ShowIconOffset = 0
local SortUpIconOffset = 0
local SortDownIconOffset = 0
local AddItemButton = nil
local AddSpellButton = nil

_G["BINDING_HEADER_TOMEOFTELEPORTATION"] = TOMEOFTELEPORTATIONTITLE
_G["BINDING_NAME_TOMEOFTELEPORTATIONSHOW"] = "    "..TOMEOFTELEPORTATIONTITLE

local InvTypeToSlot = 
{	
	["INVTYPE_HEAD"] = 1,
	["INVTYPE_NECK"] = 2,
	["INVTYPE_SHOULDER"] = 3,
	["INVTYPE_BODY"] = 4,
	["INVTYPE_CHEST"] = 5,
	["INVTYPE_ROBE"] = 5,
	["INVTYPE_WAIST"] = 6,
	["INVTYPE_LEGS"] = 7,
	["INVTYPE_FEET"] = 8,
	["INVTYPE_WRIST"] = 9,
	["INVTYPE_HAND"] = 10,
	["INVTYPE_FINGER"] = 11,
	["INVTYPE_TRINKET"] = 13,
	["INVTYPE_CLOAK"] = 15,
	["INVTYPE_2HWEAPON"] = 16,
	["INVTYPE_WEAPONMAINHAND"] = 16,
	["INVTYPE_TABARD"] = 19
}


local ST_Item = 1
local ST_Spell = 2
local ST_Challenge = 3

local SortByDestination = 1
local SortByType = 2
local SortCustom = 3

local DefaultOptions = 
{
	["scale"] = 1.2, 
	["buttonHeight"] = 26,
	["buttonWidth"] = 128,
	["labelHeight"] = 16,
	["maximumHeight"] = 520,
	["fontHeight"] = 10,
	["buttonInset"] = 12,
	["background"] = "Interface/DialogFrame/UI-DialogBox-Gold-Background",
	["edge"] = "Interface/DialogFrame/UI-DialogBox-Border",
	["backgroundR"] = 0,
	["backgroundG"] = 0,
	["backgroundB"] = 0,
	["backgroundA"] = 0.8,
	["buttonFont"] = GameFontNormal:GetFont(),
	["buttonBackground"] = "Interface/Tooltips/UI-Tooltip-Background",
	["buttonTileSize"] = 16,
	["readyColourR"] = 0,
	["readyColourG"] = 0.6,
	["readyColourB"] = 0,
	["unequipedColourR"] = 1,
	["unequipedColourG"] = 0,
	["unequipedColourB"] = 0,
	["cooldownColourR"] = 1,
	["cooldownColourG"] = 0.7,
	["cooldownColourB"] = 0,
	["disabledColourR"] = 0.5,
	["disabledColourG"] = 0.5,
	["disabledColourB"] = 0.5,
	["sortUpIcon"] = "Interface/Icons/misc_arrowlup",
	["sortDownIcon"] = "Interface/Icons/misc_arrowdown",
	["showButtonIcon"] = "Interface/Icons/levelupicon-lfd",
	["removeButtonIcon"] = "Interface/Icons/INV_Misc_Bone_Skull_03"
}
	
function TeleporterCreateSpell(id, dest)
	local spell = {}
	spell.spellId = id
	spell.spellType = ST_Spell
	spell.zone = dest
	return spell
end

function TeleporterCreateItem(id, dest)
	local spell = {}
	spell.spellId = id
	spell.spellType = ST_Item
	spell.zone = dest
	return spell
end

function TeleporterCreateChallengeSpell(id, dest)
	local spell = {}
	spell.spellId = id
	spell.spellType = ST_Challenge
	spell.zone = dest
	return spell
end

function TeleporterCreateConditionalItem(id, condition, dest)
	local spell = {}
	spell.spellId = id
	spell.spellType = ST_Item
	spell.condition = condition
	spell.zone = dest
	return spell
end

function TeleporterCreateConditionalSpell(id, condition, dest)
	local spell = {}
	spell.spellId = id
	spell.spellType = ST_Spell
	spell.condition = condition
	spell.zone = dest
	return spell
end

function TeleporterCreateConditionalConsumable(id, condition, dest)
	local spell = {}
	spell.spellId = id
	spell.spellType = ST_Item
	spell.condition = condition
	spell.zone = dest
	spell.consumable = true
	return spell
end

function TeleporterCreateConsumable(id, dest)
	local spell = {}
	spell.spellId = id
	spell.spellType = ST_Item
	spell.zone = dest
	spell.consumable = true
	return spell
end

---------------------------------------------------------------

local NameToIdCache = nil

local function BuildNameToIdCache()
	NameToIdCache = {}
	for id, t in pairs(TomeOfTele_Cache) do
		NameToIdCache[t[1]] = id
	end
end

local function GetCachedItemInfo(itemId)
	if NameToIdCache == nil then
		BuildNameToIdCache()
	end
	
	if NameToIdCache[itemId] ~= nil then
		itemId = NameToIdCache[itemId]
	end

	if TomeOfTele_Cache[itemId] then
		local t = TomeOfTele_Cache[itemId]
		return t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8], t[9], t[10], t[11], t[12], t[13], t[14], t[15], t[16], t[17]
	else
		print("Tome of Teleportation: item " .. itemId .. " is missing from the cache. Report a bug.")
		return GetItemInfo(itemId)
	end
end
	
-- [Orignal spell ID] = { Alt spell ID, Buff }
-- Currently unused
local SpellBuffs = 
{
	--[126892] = { 126896, 126896 }	-- Zen Pilgrimage / Zen Pilgrimage: Return
}

local TeleporterSpells = {}

local function GetOption(option)
	local value = nil
		if ShiGuangPerDB then
			value = ShiGuangPerDB[option]
		end
	
	if value == nil then
			return DefaultOptions[option]
	else
		return value
	end
end


local function GetScale()
	return GetOption("scale") * UIParent:GetEffectiveScale()
end

local function GetScaledOption(option)
	return GetOption(option) * GetScale()
end

local function SetOption(option, value)
		ShiGuangPerDB[option] = value
end


local function GetOptionId(spell)
	return spell.spellId .. "." .. spell.zone
end

function Teleporter_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" then
		local loadedAddon = ...
		if string.upper(loadedAddon) == string.upper("_ShiGuang") then
			Teleporter_OnAddonLoaded()			
		end
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		local player, guid, spell = ...
		if player == "player" then
			if GetSpellInfo(spell) == CastSpell then
				TeleporterClose()
			end
		end
	elseif event == "UNIT_INVENTORY_CHANGED" then
		if IsVisible then
			TeleporterUpdateAllButtons()
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		-- Can't close while in combat due to secure buttons, so disable Esc key
		if TeleporterParentFrame then
			local frameIndex = TeleporterFindInSpecialFrames()
			if frameIndex then
				tremove(UISpecialFrames,frameIndex);
			end
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		if TeleporterParentFrame then
			if not TeleporterFindInSpecialFrames() then
				tinsert(UISpecialFrames,TeleporterParentFrame:GetName());
			end
		end
	elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" or event == "ZONE_CHANGED_INDOORS" then
		TeleporterCheckItemsWereEquiped()
	end
end

function TeleporterFindInSpecialFrames()
	for i,f in ipairs(UISpecialFrames) do
		if f == TeleporterParentFrame:GetName() then
			return i
		end
	end
	return nil
end

local function RebuildSpellList()
	TeleporterSpells = {}
	for i,spell in ipairs(TeleporterDefaultSpells) do
		tinsert(TeleporterSpells, spell)
	end
	
	local extraSpells = GetOption("extraSpells")
	if extraSpells then		
		for id,dest in pairs(extraSpells) do
			local spell = TeleporterCreateSpell(id,dest)
			spell.isCustom = true
			tinsert(TeleporterSpells, spell)
		end
	end
	
	local extraItems = GetOption("extraItems")
	if extraItems then
		for id,dest in pairs(extraItems) do
			local spell = TeleporterCreateItem(id,dest)
			spell.isCustom = true
			tinsert(TeleporterSpells, spell)
		end
	end
end

function Teleporter_OnLoad() 
	SlashCmdList["TELEPORTER"] = TeleporterFunction
	SLASH_TELEPORTER1 = "/tomeofteleport"
	SLASH_TELEPORTER2 = "/tele"	

	SlashCmdList["TELEPORTEREQUIP"] = TeleporterEquipSlashCmdFunction
	SLASH_TELEPORTEREQUIP1 = "/teleporterequip"

	SlashCmdList["TELEPORTERUSEITEM"] = TeleporterUseItemSlashCmdFunction
	SLASH_TELEPORTERUSEITEM1 = "/teleporteruseitem"

	SlashCmdList["TELEPORTERCASTSPELL"] = TeleporterCastSpellSlashCmdFunction
	SLASH_TELEPORTERCASTSPELL1 = "/teleportercastspell"

	SlashCmdList["TELEPORTERCREATEMACRO"] = TeleporterCreateMacroSlashCmdFunction
	SLASH_TELEPORTERCREATEMACRO1 = "/teleportercreatemacro"
end 

local function SavePosition()
	local points = {}
	for i = 1,TeleporterParentFrame:GetNumPoints(),1 do
		tinsert(points,{TeleporterParentFrame:GetPoint(i)})
	end
	SetOption("points", points)
end


local function Refresh()
	if IsVisible then 
		TeleporterClose()
		TeleporterOpenFrame()
	end
end

local TeleporterMenu = nil
local TeleporterOptionsMenu = nil

local function SortSpells(spell1, spell2, sortType)
	local spellId1 = spell1.spellId
	local spellId2 = spell2.spellId
	local spellName1 = spell1.spellName
	local spellName2 = spell2.spellName
	local spellType1 = spell1.spellType
	local spellType2 = spell2.spellType
	local zone1 = spell1.zone
	local zone2 = spell2.zone
	
	local so = GetOption("sortOrder")
	
	if sortType == SortCustom then
		local optId1 = GetOptionId(spell1)
		local optId2 = GetOptionId(spell2)
		-- New spells always sort last - not ideal, but makes it easier to have a deterministic sort.
		if so[optId1] and so[optId2] then
			return so[optId1] < so[optId2]			
		elseif so[optId1] then
			return true
		elseif so[optId2] then
			return false
		end
	elseif sortType == SortByType then
		if spellType1 ~= spellType2 then
			return spellType1 < spellType2
		end
	end
		
	if zone1 ~= zone2 then
		return zone1 < zone2
	end
	
	return spellName1 < spellName2
end

local function SetupSpells()
	for index, spell in ipairs(TeleporterSpells) do		
		if spell.spellType == ST_Item then
			spell.spellName = GetCachedItemInfo( spell.spellId )
		else
			spell.spellName = GetSpellInfo( spell.spellId)
		end
		
		if not spell.spellName then
			spell.spellName = "<Loading>"
		end
		
		spell.isItem = spell.spellType == ST_Item
	end
end

local function GetSortedFavourites(favourites)
	SetupSpells()
	
	local sorted = {}
	local index = 1

	for spellId, isItem in pairs(favourites) do
		for i,spell in ipairs(TeleporterSpells) do
			if spell.spellId == spellId then
				sorted[index] = spell
				index = index + 1
				break
			end
		end		
	end
	
	local sortType = GetOption("sort")
	table.sort(sorted, function(a,b) return SortSpells(a, b, sortType) end)
	
	return sorted
end

function TeleporterItemMustBeEquipped(item)
	if IsEquippableItem( item ) then
		return not IsEquippedItem ( item )
	else
		return false
	end
end

local function IsSpellVisible(spell)
	local showSpells = GetOption("showSpells")
	local visible = showSpells[GetOptionId(spell)]
	if visible ~= nil then
		return visible
	else
		return true
	end
end

function TeleporterUpdateButton(button)
	if UnitAffectingCombat("player") then return end

	local settings = ButtonSettings[button]
	local isItem = settings.isItem
	
	local item = settings.spellName
	local cooldownbar = settings.cooldownbar
	local cooldownString = settings.cooldownString
	local itemId = settings.spellId
	local countString = settings.countString
	local toySpell = settings.toySpell
	local spell = settings.spell
	local onCooldown = false
	local buttonInset = GetScaledOption("buttonInset")
	
	if item then
		local cooldownStart, cooldownDuration
		if isItem then
			cooldownStart, cooldownDuration = GetItemCooldown(itemId)
		else
			cooldownStart, cooldownDuration = GetSpellCooldown(itemId)
		end

		if cooldownStart and cooldownStart > 0 then
			if GetTime() < cooldownStart then
				-- Long cooldowns seem to be reported incorrectly after a server reset.  Looks like the
				-- time is taken from a 32 bit unsigned int.
				cooldownStart = cooldownStart - 4294967.295
			end

			onCooldown = true
			local durationRemaining = cooldownDuration - ( GetTime() - cooldownStart )
			
			local parentWidth = button:GetWidth()
			local inset = 8
			cooldownbar:SetWidth( inset + ( parentWidth - inset ) * durationRemaining / cooldownDuration )
			
			if durationRemaining > 3600 then
				cooldownString:SetText(string.format("%.0fh", durationRemaining / 3600))
			elseif durationRemaining > 60 then
				cooldownString:SetText(string.format("%.0fm", durationRemaining / 60))
			else
				cooldownString:SetText(string.format("%.0fs", durationRemaining))
			end
			
			cooldownbar:SetBackdropColor(1, 1, 1, 1)
		else			
			cooldownString:SetText("")
			cooldownbar:SetWidth( 1 )
			cooldownbar:SetBackdropColor(0, 0, 0, 0)
		end		
		
		cooldownString:SetPoint("TOPLEFT",button,"TOPRIGHT",-cooldownString:GetStringWidth()*1.1-buttonInset-2,-buttonInset)
		cooldownString:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-buttonInset - 2,6)
		
		if countString and isItem then
			countString:SetText(GetItemCount(itemId, false, true))
		end

		if CustomizeSpells then
			local alpha = 1
			if not IsSpellVisible(spell) then
				alpha = 0.5
			end
			button.backdrop:SetBackdropColor(GetOption("disabledColourR"), GetOption("disabledColourG"), GetOption("disabledColourB"), alpha)
			button:SetAttribute("macrotext1", nil)
		elseif isItem and TeleporterItemMustBeEquipped( item ) then 
			button.backdrop:SetBackdropColor(GetOption("unequipedColourR"), GetOption("unequipedColourG"), GetOption("unequipedColourB"), 1)

			button:SetAttribute(
				"macrotext1",
				"/teleporterequip " .. item)
		elseif onCooldown then
			if cooldownDuration >2 then
				button.backdrop:SetBackdropColor(GetOption("cooldownColourR"), GetOption("cooldownColourG"), GetOption("cooldownColourB"), 1)
			else
				button.backdrop:SetBackdropColor(GetOption("readyColourR"), GetOption("readyColourG"), GetOption("readyColourB"), 1)
			end
			button:SetAttribute(
				"macrotext1",
				"/script print( \"" .. item .. " is currently on cooldown.\")")
		else
			button.backdrop:SetBackdropColor(GetOption("readyColourR"), GetOption("readyColourG"), GetOption("readyColourB"), 1)
			
			if toySpell then		
				button:SetAttribute(
					"macrotext1",
					"/teleportercastspell " .. toySpell .. "\n" ..
					"/cast " .. item .. "\n" )
			elseif isItem then
				button:SetAttribute(
					"macrotext1",
					"/teleporteruseitem " .. item .. "\n" ..
					"/use " .. item .. "\n" )
			else
				button:SetAttribute(
					"macrotext1",
					"/teleportercastspell " .. item .. "\n" ..
					"/cast " .. item .. "\n" )
			end
		end

		button:SetAttribute(
			"ctrl-macrotext1",
			"/teleportercreatemacro " .. item )
	end
end

function TeleporterUpdateAllButtons()	
	for button, settings in pairs(ButtonSettings) do
		TeleporterUpdateButton( button )
	end
end

function TeleporterShowItemTooltip( item, button )
	local _,link = GetCachedItemInfo(item)
	if link then
		GameTooltip:SetOwner(button, "ANCHOR_BOTTOMRIGHT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
end

function TeleporterShowSpellTooltip( item, button )
	local link = GetSpellLink(item)
	if link then
		GameTooltip:SetOwner(button, "ANCHOR_BOTTOMRIGHT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
end

local function ApplyResort()
	local newSo = {}
	
	for index, spell in ipairs(TeleporterSpells) do		
		local optId = GetOptionId(spell)
		newSo[optId] = index
	end
		
	SetOption("sortOrder", newSo)
end

local function RebuildCustomSort()
	SetupSpells()
	local oldSo = GetOption("sortOrder")
	
	table.sort(TeleporterSpells, function(a, b) return SortSpells(a, b, SortCustom) end)
	
	ApplyResort()
end

local function OnClickShow(spell)
	local showSpells = GetOption("showSpells")
	showSpells[GetOptionId(spell)] = not IsSpellVisible(spell)
end



local function CanUseSpell(spell)
	local spellId = spell.spellId
	local spellType = spell.spellType
	local isItem = (spellType == ST_Item)
	local condition = spell.condition
	local consumable = spell.consumable
	local itemTexture = nil
	
	local haveSpell = false
	local haveToy = false
	local toyUsable =  C_ToyBox.IsToyUsable(spellId)
	-- C_ToyBox.IsToyUsable returns nil if the toy hasn't been loaded yet.
	if toyUsable == nil then		
		toyUsable = true
	end
	if isItem then
		haveToy = PlayerHasToy(spellId) and toyUsable
		haveSpell = GetItemCount( spellId ) > 0 or haveToy
	else
		haveSpell = IsSpellKnown( spellId )
	end
	
	if condition and not CustomizeSpells then
		if not condition() then
			haveSpell = false
		end
	end
	
	-- Uncomment this to test all items.
	--haveSpell = true
	
	if GetOption("hideItems") and spellType == ST_Item then
		haveSpell = false
	end
	
	if GetOption("hideConsumable") and consumable then
		haveSpell = false
	end
	
	if GetOption("hideSpells") and spellType == ST_Spell then
		haveSpell = false
	end
	
	if GetOption("hideChallenge") and spellType == ST_Challenge then
		haveSpell = false
	end
	
	if not CustomizeSpells and not IsSpellVisible(spell) then
		haveSpell = false
	end
	
	return haveSpell
end


local function OnClickSortUp(spell)
	RebuildCustomSort()
	
	local so = GetOption("sortOrder")
	local id = GetOptionId(spell)	
	if so[id] and so[id] > 1 then
		local potentialPos = so[id] - 1
		while potentialPos > 0 do
			local spellToSwap = TeleporterSpells[potentialPos]
			TeleporterSpells[potentialPos] = spell
			TeleporterSpells[potentialPos+1] = spellToSwap
			if CanUseSpell(spellToSwap) then
				break
			end
			potentialPos = potentialPos - 1
		end
	end
	
	ApplyResort()
	
	Refresh()
end

local function OnClickSortDown(spell)
	RebuildCustomSort()
	
	local so = GetOption("sortOrder")
	local id = GetOptionId(spell)	
	if so[id] and so[id] < #TeleporterSpells then
		local potentialPos = so[id] + 1
		while potentialPos <= #TeleporterSpells do
			local spellToSwap = TeleporterSpells[potentialPos]
			TeleporterSpells[potentialPos] = spell
			TeleporterSpells[potentialPos-1] = spellToSwap
			if CanUseSpell(spellToSwap) then
				break
			end
			potentialPos = potentialPos + 1
		end
	end
	
	ApplyResort()
	
	Refresh()
end

local function OnClickRemove(spell)
	local dialogText = "Are you sure you want to remove " .. spell.spellName .. "?"
	
	StaticPopupDialogs["TELEPORTER_CONFIRM_REMOVE"] = 
	{
		text = dialogText,
		button1 = "Yes",
		button2 = "No",
		OnAccept = function() 
			if spell.spellType == ST_Item then
				GetOption("extraItems")[spell.spellId] = nil
			else
				GetOption("extraSpells")[spell.spellId] = nil
			end
			RebuildSpellList()
			Refresh()
		end,
		OnCancel = function() end,
		hideOnEscape = true
	}
	
	StaticPopup_Show("TELEPORTER_CONFIRM_REMOVE")
end

local function AddCustomizationIcon(existingIcon, buttonFrame, xOffset, yOffset, width, height, optionName, onClick, forceHidden)
	local iconObject = existingIcon
	if not iconObject then		
		iconObject = {}
		iconObject.icon = buttonFrame:CreateTexture(frameName)
		-- Invisible frame use for button notifications
		iconObject.frame = TeleporterCreateReusableFrame("Frame","TeleporterIconFrame",buttonFrame)	
	end
	
	if iconObject.icon then
		iconObject.icon:SetPoint("TOPRIGHT",buttonFrame,"TOPRIGHT", xOffset, yOffset)
		iconObject.icon:SetTexture(GetOption(optionName))
		
		iconObject.icon:SetWidth(width)
		iconObject.icon:SetHeight(height)
		
		iconObject.frame:SetPoint("TOPRIGHT",buttonFrame,"TOPRIGHT", xOffset, yOffset)
		iconObject.frame:SetWidth(width)
		iconObject.frame:SetHeight(height)
		
		if CustomizeSpells and not forceHidden then
			iconObject.icon:Show()
			iconObject.frame:Show()
		else
			iconObject.icon:Hide()
			iconObject.frame:Hide()
		end
		
		iconObject.frame:SetScript("OnMouseUp", onClick)	
	end
	
	return iconObject
end

local IsAdding = false

local function FinishAddingItem(dialog, isItem, id)
	IsAdding = false
	
	if isItem then
		local extraItems = GetOption("extraItems")
		if not extraItems then
			extraItems = {}
			SetOption("extraItems", extraItems)
		end
		extraItems[id] = dialog.editBox:GetText()
	else
		local extraSpells = GetOption("extraSpells")
		if not extraSpells then
			extraSpells = {}
			SetOption("extraSpells", extraSpells)
		end
		extraSpells[id] = dialog.editBox:GetText()
	end
	
	RebuildSpellList()
	Refresh()
end

local function ShowSelectDestinationUI(dialog, isItem)
	local id = dialog.editBox:GetText()
	local name
	if isItem then
		name = GetCachedItemInfo(id)
	else
		name = GetSpellInfo(id)
	end
	
	if name then
		local dialogText = "Adding " .. name .. ".\nWhat zone does it teleport to?"
		
		StaticPopupDialogs["TELEPORTER_ADDITEM_DEST"] = 
		{
			text = dialogText,
			button1 = "OK",
			button2 = "Cancel",
			OnAccept = function(dialog) FinishAddingItem(dialog, isItem, id) end,
			OnCancel = function() IsAdding = false; end,
			hideOnEscape = true,
			hasEditBox = true
		}
		
		StaticPopup_Show("TELEPORTER_ADDITEM_DEST")
	else
		local dialogText
		
		if isItem then
			dialogText = "Could not find an item with this ID."
		else
			dialogText = "Could not find a spell with this ID."
		end
		
		StaticPopupDialogs["TELEPORTER_ADDITEM_FAIL"] = 
		{
			text = dialogText,
			button1 = "OK",
			OnAccept = function() IsAdding = false; end,
			OnCancel = function() IsAdding = false; end,
			hideOnEscape = true
		}
		
		StaticPopup_Show("TELEPORTER_ADDITEM_FAIL")
	end
	
	
end

local function ShowAddItemUI(isItem)
	local dialogText
	
	if IsAdding then return end
	
	IsAdding = true
	
	if isItem then
		dialogText = "Enter the item ID. You can get this from wowhead.com."
	else
		dialogText = "Enter the spell ID. You can get this from wowhead.com."
	end
	
	StaticPopupDialogs["TELEPORTER_ADDITEM"] = 
	{
		text = dialogText,
		button1 = "OK",
		button2 = "Cancel",
		OnAccept = function(dialog) ShowSelectDestinationUI(dialog, isItem) end,
		OnCancel = function() IsAdding = false; end,
		hideOnEscape = true,
		hasEditBox = true
	}
	
	StaticPopup_Show("TELEPORTER_ADDITEM")
end

local function CreateMainFrame()
	TeleporterParentFrame = TeleporterFrame
	TeleporterParentFrame:SetFrameStrata("HIGH")		
	
	local buttonHeight = GetScaledOption("buttonHeight")
	local buttonWidth = GetScaledOption("buttonWidth")
	local labelHeight = GetScaledOption("labelHeight")
	local numColumns = 1
	local lastDest = nil
	local maximumHeight = GetScaledOption("maximumHeight")
	local fontHeight = GetScaledOption("fontHeight")
	local fontFile = GetOption("buttonFont")
	local fontFlags = nil 
	local buttonInset = GetOption("buttonInset")	
	
	TeleporterParentFrame:ClearAllPoints()
	local points = GetOption("points")
	if points then
		for i,pt in ipairs(points) do
			TeleporterParentFrame:SetPoint(pt[1], pt[2], pt[3], pt[4], pt[5])
		end
	else
		TeleporterParentFrame:SetPoint("RIGHT",-21,-43)
	end
				
	tinsert(UISpecialFrames,TeleporterParentFrame:GetName());
	--TeleporterParentFrame:SetScript( "OnHide", TeleporterClose )

	-- Title bar
	TeleporterParentFrame:RegisterForDrag("LeftButton")			
	TeleporterParentFrame:SetScript("OnDragStart", function() TeleporterParentFrame:StartMoving() end )
	TeleporterParentFrame:SetScript("OnDragStop", function() TeleporterParentFrame:StopMovingOrSizing(); SavePosition(); end )
	TeleporterParentFrame:EnableMouse(true)
	TeleporterParentFrame:SetMovable(true)
	
	-- Close button
	local closeButton = CreateFrame( "Button", "TeleporterCloseButton", TeleporterParentFrame, "UIPanelButtonTemplate" )
	closeButton:SetText( "X" )
	closeButton:SetPoint( "TOPRIGHT", TeleporterParentFrame, "TOPRIGHT", -buttonInset, -buttonInset )
	closeButton:SetWidth( buttonWidth )
	closeButton:SetHeight( buttonHeight )
	closeButton:SetScript( "OnClick", TeleporterClose )			
	
	
	AddItemButton = CreateFrame( "Button", "TeleporterAddItemButton", TeleporterParentFrame, "UIPanelButtonTemplate" )
	AddItemButton:SetText( "Add Item" )
	AddItemButton:SetPoint( "BOTTOMLEFT", TeleporterParentFrame, "BOTTOMLEFT", buttonInset, buttonInset )
	AddItemButton:SetScript( "OnClick", function() ShowAddItemUI(true) end )
	
	AddSpellButton = CreateFrame( "Button", "TeleporterAddSpellButton", TeleporterParentFrame, "UIPanelButtonTemplate" )
	AddSpellButton:SetText( "Add Spell" )
	AddSpellButton:SetPoint( "BOTTOMRIGHT", TeleporterParentFrame, "BOTTOMRIGHT", -buttonInset, buttonInset )
	AddSpellButton:SetScript( "OnClick", function() ShowAddItemUI(false) end )
end

local function GetRandomHearth(validSpells)
	local hearthSpells = {}
	for index, spell in ipairs(validSpells) do
		if spell.zone == TeleporterHearthString then
			tinsert(hearthSpells, spell.spellName)
		end
	end
	if  #hearthSpells > 0 then
		return hearthSpells[math.random(#hearthSpells)]
	else
		return nil
	end
end

local function FindValidSpells()
	local validSpells = {}
	
	for index, spell in ipairs(TeleporterSpells) do		
		local spellId = spell.spellId
		local spellType = spell.spellType
		local isItem = (spellType == ST_Item)
		local spellName = spell.spellName
		local isValidSpell = true
		
		spell.displayDestination = spell.zone
		if spell.zone == TeleporterHearthString or spell.zone == TeleporterRecallString then
			local bindLocation = GetBindLocation()
			if bindLocation then
				spell.displayDestination =  bindLocation 
			else
				spell.displayDestination = "Hearth"
			end
		end
					
		if spell.zone == TeleporterFlightString then
			spell.displayDestination = MINIMAP_TRACKING_FLIGHTMASTER
		end


		if isItem then
			_, _, _, _, _, _, _, _, _, spell.itemTexture = GetCachedItemInfo( spellId )
			if not spellName then
				isValidSpell = false
			end
		else
			_,_,spell.itemTexture = GetSpellInfo( spellId )
			if not spellName then
				isValidSpell = false
			end
		end
		
		local haveSpell = isValidSpell and CanUseSpell(spell)	

		spell.toySpell = nil
		if isItem then
			if PlayerHasToy(spellId) then
				spell.toySpell = GetItemSpell(spellId)
			end			
		end
		
		if haveSpell then
			tinsert(validSpells, spell)
		end
	end
	
	return validSpells
end

function TeleporterOpenFrame()

	if UnitAffectingCombat("player") then
		print( "Cannot use " .. TOMEOFTELEPORTATIONTITLE .. " while in combat." )
		return
	end
	
	if not ShiGuangPerDB["showSpells"] then ShiGuangPerDB["showSpells"] = {} end
	if not ShiGuangPerDB["sortOrder"] then ShiGuangPerDB["sortOrder"] = {} end
	
	if not IsVisible then		
		local buttonHeight = GetScaledOption("buttonHeight")
		local buttonWidth = GetScaledOption("buttonWidth")
		local labelHeight = GetScaledOption("labelHeight")
		local numColumns = 1
		local lastDest = nil
		local maximumHeight = GetScaledOption("maximumHeight")
		local fontHeight = GetScaledOption("fontHeight")
		local fontFile = GetOption("buttonFont")
		local fontFlags = nil 
		local buttonInset = GetOption("buttonInset")		
		
		IsVisible = true
		NeedUpdate = true
		OpenTime = GetTime()

		if TeleporterParentFrame == nil then
			CreateMainFrame()			
		end
		
		TeleporterParentFrame:SetBackdrop({bgFile = GetOption("background"), tile = false, insets = { left = buttonInset, right = buttonInset, top = buttonInset, bottom = buttonInset }});
		--TeleporterParentFrame:SetBackdropColor(GetOption("backgroundR"), GetOption("backgroundG"), GetOption("backgroundB"), GetOption("backgroundA"))
		
		-- UI scale may have changed, resize
		TeleporterCloseButton:SetWidth( buttonHeight )
		TeleporterCloseButton:SetHeight( buttonHeight )		
		TeleporterCloseButtonText:SetFont(fontFile, fontHeight, fontFlags)
		
		if TeleporterHelpString then
			TeleporterHelpString:SetFont(fontFile, fontHeight, fontFlags)
		end

		local minyoffset = -buttonInset - 10
		local yoffset = minyoffset
		local maxyoffset = -yoffset
		local xoffset = buttonInset

		ButtonSettings = {}
		
		SetupSpells()
		local SortType = GetOption("sort")
		if CustomizeSpells then
			SortType = SortCustom
		end
		table.sort(TeleporterSpells, function(a,b) return SortSpells(a, b, SortType) end)
		
		local validSpells = FindValidSpells()
		
		local onlyHearth = GetRandomHearth(validSpells)
		
		for index, spell in ipairs(validSpells) do
			local spellId = spell.spellId
			local spellType = spell.spellType
			local isItem = (spellType == ST_Item)
			local destination = spell.displayDestination
			local consumable = spell.consumable
			local spellName = spell.spellName
			local displaySpellName = spellName
			local itemTexture = spell.itemTexture
			local toySpell = spell.toySpell
			
			local haveSpell = true
			if spell.zone == TeleporterHearthString and GetOption("randomHearth") then
				if spellName ~= onlyHearth and not CustomizeSpells then
					haveSpell = false
				end
			end
			
			if haveSpell then
				-- Add extra column if needed
				local newColumn = false
				if -yoffset > maximumHeight then
					yoffset = minyoffset
					xoffset = xoffset + buttonWidth
					numColumns = numColumns + 1
					newColumn = true
				end		
				
				-- Title
				if newColumn or lastDest ~= destination then
					local destString = TeleporterCreateReusableFontString("TeleporterDL", TeleporterParentFrame, "GameFontNormalSmall")
					destString:SetFont(fontFile, fontHeight, fontFlags)
					destString:SetPoint("TOPLEFT", TeleporterParentFrame, "TOPLEFT", xoffset, yoffset)
					destString:SetPoint("BOTTOMRIGHT", TeleporterParentFrame, "TOPLEFT", buttonWidth + xoffset, yoffset - labelHeight)
					destString:SetText(destination)
					yoffset = yoffset - labelHeight
				end
				lastDest = destination	

				-- Main button
				local buttonFrame = TeleporterCreateReusableFrame("Button","TeleporterB",TeleporterParentFrame,"SecureActionButtonTemplate")
				--buttonFrame:SetFrameStrata("MEDIUM")
				buttonFrame:SetWidth(buttonWidth)
				buttonFrame:SetHeight(buttonHeight)
				buttonFrame:SetPoint("TOPLEFT",TeleporterParentFrame,"TOPLEFT",xoffset,yoffset)
				yoffset = yoffset - buttonHeight
				
				buttonFrame.backdrop = TeleporterCreateReusableFrame("Frame","TeleporterBD", buttonFrame,"BackdropTemplate")
				buttonFrame.backdrop:SetPoint("TOPLEFT",buttonFrame,"TOPLEFT",0,0)
				buttonFrame.backdrop:SetPoint("BOTTOMRIGHT",buttonFrame,"BOTTOMRIGHT",0,0)
				
				local buttonBorder = 4 * GetScale()
		
				buttonFrame.backdrop.backdropInfo = 
					{bgFile = GetOption("buttonBackground"), 
					--edgeFile = GetOption("buttonEdge"), 
					tile = true, tileSize = GetOption("buttonTileSize"), 
					--edgeSize = GetScaledOption("buttonEdgeSize"), 
					insets = { left = buttonBorder, right = buttonBorder, top = buttonBorder, bottom = buttonBorder }}
				buttonFrame.backdrop:ApplyBackdrop();
				
				buttonFrame:SetAttribute("type", "macro")
				buttonFrame:Show()

				if isItem then
					buttonFrame:SetScript(
						"OnEnter",
						function()
							TeleporterShowItemTooltip( spellName, buttonFrame )
						end )
				else
					buttonFrame:SetScript(
						"OnEnter",
						function()
							TeleporterShowSpellTooltip( spellName, buttonFrame )
						end )
				end

				buttonFrame:SetScript(
					"OnLeave",
					function()
						GameTooltip:Hide()
					end )

				-- Icon
				local iconOffsetX = 6 * GetScale()
				local iconOffsetY = -5 * GetScale()
				local iconW = 1
				local iconH = 1
				
				local teleicon = buttonFrame.TeleporterIcon
				if not teleicon then
					teleicon = buttonFrame.backdrop:CreateTexture(frameName)
					buttonFrame.TeleporterIcon = teleicon
				end
				
				if teleicon then
					teleicon:SetPoint("TOPLEFT",buttonFrame,"TOPLEFT", iconOffsetX, iconOffsetY)
					if itemTexture then
						iconW = buttonHeight - 10 * GetScale()
						iconH = buttonHeight - 10 * GetScale()
						teleicon:SetTexture(itemTexture)
					end
					
					teleicon:SetWidth(iconW)
					teleicon:SetHeight(iconH)
				end

				-- Cooldown bar
				local cooldownbar = TeleporterCreateReusableFrame( "Frame", "TeleporterCB", buttonFrame.backdrop, "BackdropTemplate" )
				--cooldownbar:SetFrameStrata("MEDIUM")
				cooldownbar:SetWidth(64)
				cooldownbar:SetHeight(buttonHeight)
				cooldownbar:SetPoint("TOPLEFT",buttonFrame,"TOPLEFT",0,0)
				cooldownbar.backdropInfo = {bgFile = "Interface/Tooltips/UI-Tooltip-Background",insets = { left = 4, right = 4, top = 3, bottom = 3 }}
				cooldownbar:ApplyBackdrop()

				-- Cooldown label
				local cooldownString = TeleporterCreateReusableFontString("TeleporterCL", cooldownbar, "GameFontNormalSmall")
				cooldownString:SetFont(fontFile, fontHeight, fontFlags)
				cooldownString:SetJustifyH("RIGHT")
				cooldownString:SetJustifyV("CENTER")
				cooldownString:SetPoint("TOPLEFT",buttonFrame,"TOPRIGHT",-50,-buttonInset - 2)
				cooldownString:SetPoint("BOTTOMRIGHT",buttonFrame,"BOTTOMRIGHT",-buttonInset - 2,6)
				
				-- Name label
				local nameString = TeleporterCreateReusableFontString("TeleporterSNL", cooldownbar, "GameFontNormalSmall")
				nameString:SetFont(fontFile, fontHeight, fontFlags)
				nameString:SetJustifyH("LEFT")
				nameString:SetJustifyV("CENTER")
				nameString:SetPoint("TOP",cooldownString,"TOPRIGHT",0,0)
				nameString:SetPoint("LEFT", buttonFrame, "TOPLEFT", iconOffsetX + iconW + 2, iconOffsetY - 1)
				if CustomizeSpells then
					nameString:SetPoint("BOTTOMRIGHT",cooldownString,"BOTTOMLEFT",-iconW * 4,0)
				else
					nameString:SetPoint("BOTTOMRIGHT",cooldownString,"BOTTOMLEFT",0,0)
				end
				nameString:SetText( displaySpellName )
				
				-- Count label
				local countString = nil
				if consumable then
					countString = TeleporterCreateReusableFontString("TeleporterCT", cooldownbar, "SystemFont_Outline_Small")
					countString:SetJustifyH("RIGHT")
					countString:SetJustifyV("CENTER")
					countString:SetPoint("TOPLEFT",cooldownbar,"TOPLEFT",iconOffsetX,iconOffsetY)
					countString:SetPoint("BOTTOMRIGHT", cooldownbar, "TOPLEFT", iconOffsetX + iconW, iconOffsetY - iconH - 2)
					countString:SetText("")
				end
			
				if -yoffset > maxyoffset then
					maxyoffset = -yoffset
				end
				
				RemoveIconOffset = -iconOffsetX - iconW * 3
				ShowIconOffset = -iconOffsetX - iconW * 2
				SortUpIconOffset = -iconOffsetX - iconW
				SortDownIconOffset = -iconOffsetX
				
				buttonFrame.RemoveIcon = AddCustomizationIcon(buttonFrame.RemoveIcon, buttonFrame, RemoveIconOffset, iconOffsetY, iconW, iconH, "removeButtonIcon", function() OnClickRemove(spell) end, not spell.isCustom)
				buttonFrame.ShowIcon = AddCustomizationIcon(buttonFrame.ShowIcon, buttonFrame, ShowIconOffset, iconOffsetY, iconW, iconH, "showButtonIcon", function() OnClickShow(spell) end)				
				buttonFrame.SortUpIcon = AddCustomizationIcon(buttonFrame.SortUpIcon, buttonFrame, SortUpIconOffset, iconOffsetY, iconW, iconH, "sortUpIcon", function() OnClickSortUp(spell) end)
				buttonFrame.SortDownIcon = AddCustomizationIcon(buttonFrame.SortDownIcon, buttonFrame, SortDownIconOffset, iconOffsetY, iconW, iconH, "sortDownIcon", function() OnClickSortDown(spell) end)
				
				local buttonSetting = { }	
				buttonSetting.isItem = isItem
				buttonSetting.spellName = spellName
				buttonSetting.cooldownbar = cooldownbar
				buttonSetting.cooldownString = cooldownString
				buttonSetting.spellId = spellId
				buttonSetting.countString = countString
				buttonSetting.toySpell = toySpell
				buttonSetting.spell = spell
				buttonSetting.spellType = spellType
				ButtonSettings[buttonFrame] = buttonSetting
			end
		end
		
		local helpTextHeight		
		
		if TeleporterHelpString then
			if numColumns == 1 then
				helpTextHeight = 40
			else
				helpTextHeight = 10
			end
			TeleporterHelpString:SetPoint("TOPLEFT", TeleporterParentFrame, "TOPLEFT", 4 + buttonInset, -maxyoffset - 3 )
			TeleporterHelpString:SetPoint("RIGHT", TeleporterParentFrame, "RIGHT", -buttonInset, 0)
			TeleporterHelpString:SetHeight( helpTextHeight )	
		else
			helpTextHeight = 0
		end
		
		local addRemoveButtonsHeight = 0
	
		if CustomizeSpells then
			if numColumns < 2 then
				numColumns = 2
			end
			
			AddItemButton:SetWidth((numColumns * buttonWidth) / 2)			
			AddSpellButton:SetWidth((numColumns * buttonWidth) / 2)			
			addRemoveButtonsHeight = buttonInset + buttonHeight
			
			AddItemButton:Show()
			AddSpellButton:Show()
		else
			AddItemButton:Hide()
			AddSpellButton:Hide()
		end
		
		TeleporterParentFrame:SetWidth(numColumns * buttonWidth + buttonInset * 2)
		TeleporterParentFrame:SetHeight(maxyoffset + buttonInset * 2 + 2 + helpTextHeight + addRemoveButtonsHeight)
		
	end

	TeleporterUpdateAllButtons()	
	TeleporterParentFrame:Show()
end


function TeleporterRestoreEquipment()
	ShouldNotBeEquiped = {}
	for slot,item in pairs(OldItems) do		
		ShouldNotBeEquiped[slot] = GetInventoryItemID("player", slot)
		ShouldBeEquiped[slot] = item
		RemoveItem[slot](item)
	end
	OldItems = {}
	EquipTime = GetTime()
end

function TeleporterCheckItemsWereEquiped()
	-- Sometimes equipping after casting fails. If that happens
	-- then try equipping after the next teleport.
	if GetTime() < EquipTime + 60 then 
		for slot, item in pairs(ShouldNotBeEquiped) do
			if IsEquippedItem ( item ) then
				RemoveItem[slot](ShouldBeEquiped[slot])
			end
		end
	end
	ShouldNotBeEquiped = {}
	ShouldBeEquiped = {}
end

function TeleporterClose()
	if IsVisible and UnitAffectingCombat("player") then
		print( "Sorry, cannot close " .. TOMEOFTELEPORTATIONTITLE .. " while in combat." )
	else
		if TeleporterParentFrame then
			TeleporterParentFrame:Hide()
			IsVisible = false
		end
		if TeleporterQuickMenuFrame then
			TeleporterQuickMenuFrame:Hide()
		end
	end
end

function TeleporterFunction()
		if IsVisible then
			TeleporterClose()
		else
			TeleporterOpenFrame()
		end	
end

local function PrepareUnequippedSlot(item, itemSlot)
	OldItems[ itemSlot ] = 0
	
	local inBag = 0
	for bagIdx = 1,NUM_BAG_SLOTS,1 do
		for slotIdx = 1, GetContainerNumSlots(bagIdx), 1 do
			local itemInBag = GetContainerItemID(bagIdx, slotIdx)
			if itemInBag then
				local bagItemName = GetCachedItemInfo(itemInBag)
				if bagItemName == item or itemInBag == item then
					inBag = bagIdx
				end
			end
		end
	end
	
	if inBag == 0 then
		RemoveItem[itemSlot] = function(newItem)
			PickupInventoryItem(itemSlot)
			PutItemInBackpack()
		end
	else
		RemoveItem[itemSlot] = function(newItem)
			PickupInventoryItem(itemSlot)
			PutItemInBag(inBag + 19)
		end
	end
end

function TeleporterEquipSlashCmdFunction( item )
	CastSpell = nil

	if not IsEquippedItem ( item ) then
		if IsEquippableItem( item ) then 
			local _, _, _, _, _, _, _, _,itemEquipLoc = GetCachedItemInfo(item)
			local itemSlot = InvTypeToSlot[ itemEquipLoc ]
			if itemSlot == nil then
				print( "Unrecognised equipable item type: " .. itemEquipLoc )
				return
			end
			local OldItem = GetInventoryItemID( "player", itemSlot )
			if OldItem then
				OldItems[ itemSlot ] = OldItem
				RemoveItem[itemSlot] = function(newItem)
					EquipItemByName( newItem, itemSlot )
				end
			else
				PrepareUnequippedSlot(item, itemSlot)				
			end
			EquipItemByName( item, itemSlot )
		end
	end
end

function TeleporterUseItemSlashCmdFunction( item )
	local spell = GetItemSpell( item )
	TeleporterCastSpellSlashCmdFunction( spell )
end

function TeleporterCastSpellSlashCmdFunction( spell )
	CastSpell = spell
end

function TeleporterCreateMacroSlashCmdFunction( spell )
	if spell then
		local macro
		local printEquipInfo = false

		if GetCachedItemInfo( spell ) then
			if IsEquippableItem( spell ) then
				macro =
					"#showtooltip " .. spell .. "\n" ..
					"/teleporterequip " .. spell .. "\n" ..
					"/teleporteruseitem " .. spell .. "\n" ..
					"/use " .. spell .. "\n"
				printEquipInfo = true
			else
				macro =
					"#showtooltip " .. spell .. "\n" ..
					"/use " .. spell .. "\n"
			end
		else
			macro =
				"#showtooltip " .. spell .. "\n" ..
				"/cast " .. spell .. "\n"
		end

		local macroName = "Use" .. string.gsub( spell, "[^%a%d]", "" )
		if GetMacroInfo( macroName ) then
			DeleteMacro( macroName )
		end
		CreateMacro( macroName, 1, macro, 1, 1 )

		local extraInstructions = ""
		if printEquipInfo then
			extraInstructions = "If the item is not equipped then the first click of the macro will equip it and the second click will use it."
		end
		print( "Created macro " .. macroName .. ". " .. extraInstructions )

		PickupMacro( macroName )
	end
end

function Teleporter_OnAddonLoaded()
	if TomeOfTele_Icon == nil then
		TomeOfTele_Icon = {}
	end
	
	icon:Register("TomeTele", dataobj, TomeOfTele_Icon)		
	RebuildSpellList()
	for index, spell in ipairs(TeleporterSpells) do		
		if (spell.spellType == ST_Item) then
			-- Query this early so it will be ready when we need it.
			C_ToyBox.IsToyUsable(spell.spellId)			
		end
	end
end

function Teleporter_OnUpdate()
	if IsVisible then	
		-- The first time the UI is opened toy ownership may be incorrect. Reopen once it's correct.
		if NeedUpdate then			
			-- Assume it's ready after 1 second.
			if GetTime() > OpenTime + 1 then
				--TeleporterClose()
				TeleporterOpenFrame()
				NeedUpdate = false
			end
		end
		TeleporterUpdateAllButtons()		
		
		--if not TeleporterParentFrame:IsVisible() then			
		--	TeleporterHideCreatedUI()
		--	IsVisible = false			
		--	TeleporterRestoreEquipment()
		--end
	end
end

function Teleporter_OnHide()
	TeleporterHideCreatedUI()
	IsVisible = false
	TeleporterRestoreEquipment()
end

-----------------------------------------------------------------------
-- UI reuse

local uiElements = {}
local numUIElements = {}

-- Returns frame,frameName.  if frame is null then the caller must create a new object with this name
function TeleporterFindOrAddUIElement( prefix, parentFrame )
	local fullPrefix = parentFrame:GetName() .. prefix

	local numElementsWithPrefix = numUIElements[ fullPrefix ]
	if not numElementsWithPrefix then
		numElementsWithPrefix = 0
	end

	local frameName = fullPrefix .. numElementsWithPrefix
	local oldFrame = getglobal( frameName )
	if oldFrame then
		oldFrame:Show()
	end

	tinsert(uiElements, frameName)

	numElementsWithPrefix = numElementsWithPrefix + 1
	numUIElements[ fullPrefix ] = numElementsWithPrefix	
	
	return oldFrame, frameName
end


function TeleporterCreateReusableFrame( frameType, prefix, parentFrame, inheritsFrame )
	local frame, frameName = TeleporterFindOrAddUIElement( prefix, parentFrame )

	if not frame then
		frame = CreateFrame( frameType, frameName, parentFrame, inheritsFrame )
	end	
	
	return frame
end

function TeleporterCreateReusableFontString( prefix, parentFrame, font )
	local frame, frameName = TeleporterFindOrAddUIElement( prefix, parentFrame )

	if not frame then
		frame = parentFrame:CreateFontString(frameName, nil, font)
	end	
	
	return frame
end

function TeleporterHideCreatedUI()
	for index, itemName in pairs( uiElements ) do		
		local item = getglobal(itemName)
		if item then
			item:Hide()
		end
	end
	numUIElements = {}
	uiElements = {}
end

--------- Isle of Thunder Weekly Check---- by Fluffies------DIY by y368413-------------------------------------------
local chest_icon = "|TInterface\\Icons\\Trade_Archaeology_ChestofTinyGlassAnimals:12|t "
local rare_icon = "|TInterface\\Icons\\Achievement_Boss_Archaedas:12|t "
local quest_icon = "|TInterface\\CURSOR\\QUEST:12|t "
local rare_name = EXAMPLE_TARGET_MONSTER.." ("..ITEM_QUALITY3_DESC..")"

-- string colors
local LIGHT_RED   = "|cffFF2020"
local LIGHT_GREEN = "|cff20FF20"
local LIGHT_BLUE  = "|cff00ddFF"
local ZONE_BLUE   = "|cff00aacc"
local GREY        = "|cff999999"
local COORD_GREY  = "|cffBBBBBB"
local GOLD        = "|cffffcc00"
local WHITE       = "|cffffffff"
local PINK        = "|cffFFaaaa"
local function AddColor(str,color) return color..(str or " ^-^ ").."|r" end

local function completedstring(arg)
 if C_QuestLog.IsQuestFlaggedCompleted(arg) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end

-------------------------------------------------------------
local bonus = {52834, 52838, 52835, 52839, 52837, 52840,}						--Order Resources(前3)  -Gold(中3)  --Orderhall(后1) 
local count = 0
for _, id in pairs(bonus) do if C_QuestLog.IsQuestFlaggedCompleted(id) then count = count + 1 end end
local function CheckCurrency()
	if count < 2 then return AddColor(count.." / 2",LIGHT_RED) elseif count >= 2 then return AddColor(count.." / 2",LIGHT_GREEN) end
end
local function TimeTravelFB()
 if C_QuestLog.IsQuestFlaggedCompleted(40168) or C_QuestLog.IsQuestFlaggedCompleted(40173) or C_QuestLog.IsQuestFlaggedCompleted(40786) or C_QuestLog.IsQuestFlaggedCompleted(45799) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function GarrisonInvade()
 if C_QuestLog.IsQuestFlaggedCompleted(37638) or C_QuestLog.IsQuestFlaggedCompleted(37639) or C_QuestLog.IsQuestFlaggedCompleted(37640) or C_QuestLog.IsQuestFlaggedCompleted(38482) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function LegionWolrdBoss()
 if C_QuestLog.IsQuestFlaggedCompleted(42270) or C_QuestLog.IsQuestFlaggedCompleted(42269) or C_QuestLog.IsQuestFlaggedCompleted(42779) or C_QuestLog.IsQuestFlaggedCompleted(43192) or IsQuestFlaggedCompleted(42819) or IsQuestFlaggedCompleted(43193) or IsQuestFlaggedCompleted(43513) or IsQuestFlaggedCompleted(43448) or IsQuestFlaggedCompleted(43512) or IsQuestFlaggedCompleted(43985) or IsQuestFlaggedCompleted(44287) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function TombWolrdBoss()
 if C_QuestLog.IsQuestFlaggedCompleted(46947) or C_QuestLog.IsQuestFlaggedCompleted(46948) or C_QuestLog.IsQuestFlaggedCompleted(46945) or C_QuestLog.IsQuestFlaggedCompleted(47061) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function ArgusWolrdBoss()
 if C_QuestLog.IsQuestFlaggedCompleted(38276) or C_QuestLog.IsQuestFlaggedCompleted(47461) or C_QuestLog.IsQuestFlaggedCompleted(47462) or C_QuestLog.IsQuestFlaggedCompleted(47463) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function CheckIslandweekly()
	local iwqID = C_IslandsQueue.GetIslandsWeeklyQuestID()
	local _, _, _, cur, max = GetQuestObjectiveInfo(iwqID, 1, false)
	if iwqID and UnitLevel("player") == 120 and C_QuestLog.IsQuestFlaggedCompleted(iwqID) then return AddColor(COMPLETE,LIGHT_RED) elseif iwqID and UnitLevel("player") == 120 then return AddColor(cur.." / "..max,LIGHT_GREEN) end
end
------------------------------------------------------------------------------------

function dataobj:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_NONE")
    GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
    GameTooltip:ClearLines()
    GameTooltip:AddDoubleLine(TITLEREADME)
    --GameTooltip:AddDoubleLine(ERR_QUEST_HAS_IN_PROGRESS,"|T".."Interface\\Addons\\_ShiGuang\\Media\\Modules\\MaoR-UI"..":32|t")
    GameTooltip:AddLine(" ")
    --GameTooltip:AddDoubleLine(quest_icon..AddColor("[|cffFFaaaa"..C_CurrencyInfo.GetCurrencyInfo(1580).."|r] ",GOLD), CheckCurrency())
    --GameTooltip:AddDoubleLine(quest_icon..AddColor(GetItemInfo(138019),LIGHT_BLUE), completedstring(44554))            --史诗钥石
    GameTooltip:AddDoubleLine(quest_icon..AddColor(GARRISON_LANDING_INVASION,LIGHT_BLUE), GarrisonInvade())
    --GameTooltip:AddDoubleLine(quest_icon..AddColor(PLAYER_DIFFICULTY_TIMEWALKER,LIGHT_BLUE), TimeTravelFB())   --TBC--WLK--CTM 
    --GameTooltip:AddDoubleLine(quest_icon..AddColor(GetItemInfo(132892),LIGHT_BLUE), completedstring(34774))            --布林顿 C_PetJournal.GetPetAbilityInfo(989)
    GameTooltip:AddLine(" ")
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("Legion  1/11 ",PINK), LegionWolrdBoss())
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("Tomb  1/4 ",PINK), TombWolrdBoss())
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("Argus  1/4 ",PINK), ArgusWolrdBoss())
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-暗影领主艾斯卡|cffffddFF(死爪)|r",ZONE_BLUE), completedstring(39287))
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-游侠将军|cffffddFF(泰罗菲斯特)|r",ZONE_BLUE), completedstring(39288))
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-攻城大师玛塔克|cffffddFF(末日之轮)|r",ZONE_BLUE), completedstring(39289))
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-暴君维哈里|cffffddFF(维金斯)|r",ZONE_BLUE), completedstring(39290)) 
   GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-鲁克玛",ZONE_BLUE), completedstring(37464)) 
   GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-怒之煞",ZONE_BLUE), completedstring(32099))
   GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-炮舰",ZONE_BLUE), completedstring(32098))
   GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-纳拉克",ZONE_BLUE), completedstring(32518))
   GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-乌达斯塔",ZONE_BLUE), completedstring(32519))
   GameTooltip:AddLine(" ")
   --GameTooltip:AddDoubleLine(quest_icon..AddColor(ISLANDS_HEADER,LIGHT_BLUE), CheckIslandweekly())
   --GameTooltip:AddLine(" ")
   GameTooltip:AddLine(chest_icon..AddColor(BOSS_DEAD,GOLD))
   for i = 1, GetNumSavedInstances() do
	   local name, id, _, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, level, total, progress = GetSavedInstanceInfo(i)
	   GameTooltip:AddDoubleLine(AddColor(name.."("..level..")",WHITE), locked and AddColor(progress.."/"..total, LIGHT_GREEN) or AddColor(" 0/0 ", LIGHT_RED))
   end
   GameTooltip:Show()
end

function dataobj:OnLeave()
    GameTooltip:Hide()
end

function dataobj:OnClick(button)
	TeleporterFunction()
	NeedUpdate = false
end

function TeleporterAddSpell(id, dest)
	TeleporterSpells[#TeleporterSpells + 1] = {spellId = id, spellType = ST_Spell, zone = dest}
end

function TeleporterAddItem(id, dest)
	TeleporterSpells[#TeleporterSpells + 1] = {spellId = id, spellType = ST_Item, zone = dest}
end
