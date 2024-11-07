local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local pairs, unpack, tinsert, select = pairs, unpack, tinsert, select
local GetSpellBookItemInfo = C_SpellBook and C_SpellBook.GetSpellBookItemInfo or GetSpellBookItemInfo
local IsPlayerSpell, UseItemByName = IsPlayerSpell, UseItemByName
local GetProfessions, GetProfessionInfo = GetProfessions, GetProfessionInfo
local PlayerHasToy, C_ToyBox_GetToyInfo = PlayerHasToy, C_ToyBox.GetToyInfo
local C_TradeSkillUI_GetRecipeInfo, C_TradeSkillUI_GetTradeSkillLine = C_TradeSkillUI.GetRecipeInfo, C_TradeSkillUI.GetTradeSkillLine
local C_TradeSkillUI_GetOnlyShowSkillUpRecipes, C_TradeSkillUI_SetOnlyShowSkillUpRecipes = C_TradeSkillUI.GetOnlyShowSkillUpRecipes, C_TradeSkillUI.SetOnlyShowSkillUpRecipes
local C_TradeSkillUI_GetOnlyShowMakeableRecipes, C_TradeSkillUI_SetOnlyShowMakeableRecipes = C_TradeSkillUI.GetOnlyShowMakeableRecipes, C_TradeSkillUI.SetOnlyShowMakeableRecipes

local BOOKTYPE_PROFESSION = BOOKTYPE_PROFESSION or 0
local RUNEFORGING_ID = 53428
local PICK_LOCK = 1804
local CHEF_HAT = 134020
local THERMAL_ANVIL = 87216
local tabList = {}

local onlyPrimary = {
	[171] = true, -- Alchemy
	[182] = true, -- Herbalism
	[186] = true, -- Mining
	[202] = true, -- Engineering
	[356] = true, -- Fishing
	[393] = true, -- Skinning
}

function MISC:UpdateProfessions()
	local prof1, prof2, _, fish, cook = GetProfessions()
	local profs = {prof1, prof2, fish, cook}

	if I.MyClass == "DEATHKNIGHT" then
		MISC:TradeTabs_Create(RUNEFORGING_ID)
	elseif I.MyClass == "ROGUE" and IsPlayerSpell(PICK_LOCK) then
		MISC:TradeTabs_Create(PICK_LOCK)
	end

	local isCook
	for _, prof in pairs(profs) do
		local _, _, _, _, numSpells, spelloffset, skillLine = GetProfessionInfo(prof)
		if skillLine == 185 then isCook = true end

		numSpells = onlyPrimary[skillLine] and 1 or numSpells
		if numSpells > 0 then
			for i = 1, numSpells do
				local slotID = i + spelloffset
				if not C_SpellBook.IsSpellBookItemPassive(slotID, BOOKTYPE_PROFESSION) then
					local spellID = GetSpellBookItemInfo(slotID, BOOKTYPE_PROFESSION).spellID
					if i == 1 then
						MISC:TradeTabs_Create(spellID)
					else
						MISC:TradeTabs_Create(spellID)
					end
				end
			end
		end
	end

	if isCook and PlayerHasToy(CHEF_HAT) then
		MISC:TradeTabs_Create(nil, CHEF_HAT)
	end
	if C_Item.GetItemCount(THERMAL_ANVIL) > 0 then
		MISC:TradeTabs_Create(nil, nil, THERMAL_ANVIL)
	end
end

function MISC:TradeTabs_Update()
	for _, tab in pairs(tabList) do
		local spellID = tab.spellID
		local itemID = tab.itemID

		if spellID and C_Spell.IsCurrentSpell(spellID) then
			tab:SetChecked(true)
			tab.cover:Show()
		else
			tab:SetChecked(false)
			tab.cover:Hide()
		end

		local start, duration
		if itemID then
			start, duration = C_Item.GetItemCooldown(itemID)
		else
			local cooldownInfo = C_Spell.GetSpellCooldown(spellID)
			start = cooldownInfo and cooldownInfo.startTime
			duration = cooldownInfo and cooldownInfo.duration
		end
		if start and duration and duration > 1.5 then
			tab.CD:SetCooldown(start, duration)
		end
	end
end

local index = 1
function MISC:TradeTabs_Create(spellID, toyID, itemID)
	local name, _, texture
	if toyID then
		_, name, texture = C_ToyBox_GetToyInfo(toyID)
	elseif itemID then
		name, texture = C_Item.GetItemNameByID(itemID), C_Item.GetItemIconByID(itemID)
	else
		name, texture = C_Spell.GetSpellName(spellID), C_Spell.GetSpellTexture(spellID)
	end
	if not name then return end -- precaution

	local tab = CreateFrame("CheckButton", nil, ProfessionsFrame, "SecureActionButtonTemplate")
	tab:SetSize(32, 32)
	tab.tooltip = name
	tab.spellID = spellID
	tab.itemID = toyID or itemID
	tab.type = (toyID and "toy") or (itemID and "item") or "spell"
	tab:RegisterForClicks("AnyUp", "AnyDown")
	if spellID == 818 then -- cooking fire
		tab:SetAttribute("type", "macro")
		tab:SetAttribute("macrotext", "/cast [@player]"..name)
	else
		tab:SetAttribute("type", tab.type)
		tab:SetAttribute(tab.type, spellID or name)
	end
	tab:SetNormalTexture(texture)
	tab:SetHighlightTexture(I.bdTex)
	tab:GetHighlightTexture():SetVertexColor(1, 1, 1, .25)
	tab:Show()

	tab.CD = CreateFrame("Cooldown", nil, tab, "CooldownFrameTemplate")
	tab.CD:SetAllPoints()

	tab.cover = CreateFrame("Frame", nil, tab)
	tab.cover:SetAllPoints()
	tab.cover:EnableMouse(true)

	tab:SetPoint("TOPLEFT", ProfessionsFrame, "TOPRIGHT", 3, -index*42)
	tinsert(tabList, tab)
	index = index + 1
end

function MISC:TradeTabs_FilterIcons()
	local buttonList = {
		[1] = {"Atlas:bags-greenarrow", TRADESKILL_FILTER_HAS_SKILL_UP, C_TradeSkillUI_GetOnlyShowSkillUpRecipes, C_TradeSkillUI_SetOnlyShowSkillUpRecipes},
		[2] = {"Interface\\RAIDFRAME\\ReadyCheck-Ready", CRAFT_IS_MAKEABLE, C_TradeSkillUI_GetOnlyShowMakeableRecipes, C_TradeSkillUI_SetOnlyShowMakeableRecipes},
	}

	local function filterClick(self)
		local value = self.__value
		if value[3]() then
			value[4](false)
			M.SetBorderColor(self.bg)
		else
			value[4](true)
			self.bg:SetBackdropBorderColor(1, .8, 0)
		end
	end

	local buttons = {}
	for index, value in pairs(buttonList) do
		local bu = CreateFrame("Button", nil, ProfessionsFrame.CraftingPage.RecipeList, "BackdropTemplate")
		bu:SetSize(22, 22)
		bu:SetPoint("BOTTOMRIGHT", ProfessionsFrame.CraftingPage.RecipeList.FilterDropdown, "TOPRIGHT", -(index-1)*26 + 7, 10)
		M.PixelIcon(bu, value[1], true)
		M.AddTooltip(bu, "ANCHOR_TOP", value[2])
		bu.__value = value
		bu:SetScript("OnClick", filterClick)

		buttons[index] = bu
	end

	local function updateFilterStatus()
		for index, value in pairs(buttonList) do
			if value[3]() then
				buttons[index].bg:SetBackdropBorderColor(1, .8, 0)
			else
				M.SetBorderColor(buttons[index].bg)
			end
		end
	end
	M:RegisterEvent("TRADE_SKILL_LIST_UPDATE", updateFilterStatus)
end

local init
function MISC:TradeTabs_OnLoad()
	init = true

	MISC:UpdateProfessions()

	MISC:TradeTabs_Update()
	M:RegisterEvent("TRADE_SKILL_SHOW", MISC.TradeTabs_Update)
	M:RegisterEvent("TRADE_SKILL_CLOSE", MISC.TradeTabs_Update)
	M:RegisterEvent("CURRENT_SPELL_CAST_CHANGED", MISC.TradeTabs_Update)
	MISC:TradeTabs_FilterIcons()

	M:UnregisterEvent("PLAYER_REGEN_ENABLED", MISC.TradeTabs_OnLoad)
end

local function LoadTradeTabs()
	if init then return end
	if InCombatLockdown() then
		M:RegisterEvent("PLAYER_REGEN_ENABLED", MISC.TradeTabs_OnLoad)
	else
		MISC:TradeTabs_OnLoad()
	end
end

function MISC:TradeTabs()
	if not R.db["Misc"]["TradeTabs"] then return end
	if ProfessionsFrame then
		ProfessionsFrame:HookScript("OnShow", LoadTradeTabs)
	else
		M:RegisterEvent("ADDON_LOADED", function(_, addon)
			if addon == "Blizzard_Professions" then
				LoadTradeTabs()
			end
		end)
	end
end
MISC:RegisterMisc("TradeTabs", MISC.TradeTabs)