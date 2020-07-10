----------------------------------------------------------------------------------------
--	Show item level for weapons and armor in merchant
----------------------------------------------------------------------------------------
hooksecurefunc("MerchantFrame_UpdateMerchantInfo", function()
	local numItems = GetMerchantNumItems()
	for i = 1, MERCHANT_ITEMS_PER_PAGE do
		local index = (MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE + i
		if index > numItems then return end
		local button = _G["MerchantItem"..i.."ItemButton"]
		if button and button:IsShown() then
			if not button.text then
				button.text = button:CreateFontString(nil, "OVERLAY", "SystemFont_Outline_Small")
				button.text:SetPoint("TOPLEFT", 1, -1)
				button.text:SetTextColor(1, 1, 0)
			else
				button.text:SetText("")
			end
			local itemLink = GetMerchantItemLink(index)
			if itemLink then
				local _, _, quality, itemlevel, _, _, _, _, _, _, _, itemClassID = GetItemInfo(itemLink)
				if (itemlevel and itemlevel > 1) and (quality and quality > 1) and (itemClassID == LE_ITEM_CLASS_WEAPON or itemClassID == LE_ITEM_CLASS_ARMOR) then
					button.text:SetText(itemlevel)
				end
			end
		end
	end
end)
----------------------------------------------------------------------------------------
-- Learn all available skills(TrainAll by SDPhantom)
----------------------------------------------------------------------------------------
local TrainAll = CreateFrame("Frame")
TrainAll:RegisterEvent("ADDON_LOADED")
TrainAll:SetScript("OnEvent", function(_, _, addon)
	if addon == "Blizzard_TrainerUI" then
		local cost, num
		local button = CreateFrame("Button", "ClassTrainerTrainAllButton", ClassTrainerFrame, "UIPanelButtonTemplate")
		button:SetText(ALL..LEARN )
		button:SetPoint("TOPRIGHT", ClassTrainerTrainButton, "TOPLEFT", 0, 0)
		button:SetWidth(min(88, button:GetTextWidth() + 21))
		button:SetScript("OnEnter", function()
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
			GameTooltip:SetText(AVAILABLE..": "..num.."\n"..COSTS_LABEL.." "..GetMoneyString(cost))
		end)
		button:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
		button:SetScript("OnClick", function()
			for i = 1, GetNumTrainerServices() do
				if select(2, GetTrainerServiceInfo(i)) == "available" then
					BuyTrainerService(i)
				end
			end
		end)
		hooksecurefunc("ClassTrainerFrame_Update", function()
			num, cost = 0, 0
			for i = 1, GetNumTrainerServices() do
				if select(2, GetTrainerServiceInfo(i)) == "available" then
					num = num + 1
					cost = cost + GetTrainerServiceCost(i)
				end
			end
			button:SetEnabled(num > 0)
		end)
	end
end)

----------------------------------------------------------------------------------------
--	Enchantment scroll on TradeSkill frame(OneClickEnchantScroll by Sara.Festung)
----------------------------------------------------------------------------------------
local OneClickEnchantScroll = CreateFrame("Frame")
OneClickEnchantScroll:RegisterEvent("ADDON_LOADED")
OneClickEnchantScroll:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TradeSkillUI" and not IsAddOnLoaded("OneClickEnchantScroll") then
		local button = CreateFrame("Button", "TradeSkillCreateScrollButton", TradeSkillFrame, "MagicButtonTemplate")
		button:SetPoint("TOPRIGHT", TradeSkillFrame.DetailsFrame.CreateButton, "TOPLEFT")
		button:SetScript("OnClick", function()
			C_TradeSkillUI.CraftRecipe(TradeSkillFrame.DetailsFrame.selectedRecipeID)
			UseItemByName(38682)
		end)

		hooksecurefunc(TradeSkillFrame.DetailsFrame, "RefreshButtons", function(self)
			if C_TradeSkillUI.IsTradeSkillGuild() or C_TradeSkillUI.IsNPCCrafting() or C_TradeSkillUI.IsTradeSkillLinked() then
				button:Hide()
			else
				local recipeInfo = self.selectedRecipeID and C_TradeSkillUI.GetRecipeInfo(self.selectedRecipeID)
				if recipeInfo and recipeInfo.alternateVerb then
					local _, _, _, _, _, parentSkillLineID = C_TradeSkillUI.GetTradeSkillLine()
					if parentSkillLineID == 333 then
						button:Show()
						local numCreateable = recipeInfo.numAvailable
						local numScrollsAvailable = GetItemCount(38682)
						button:SetText("& ("..numScrollsAvailable..")")
						 if numScrollsAvailable == 0 then
							numCreateable = 0
						end
						if numCreateable > 0 then
							button:Enable()
						else
							button:Disable()
						end
					else
						button:Hide()
					end
				else
					button:Hide()
				end
			end
		end)
	end
end)
----------------------------------------------------------------------------------------
--	One-click Milling, Prospecting and Disenchanting(Molinari by p3lim)
----------------------------------------------------------------------------------------
local button = CreateFrame("Button", "OneClickMPD", UIParent, "SecureActionButtonTemplate, AutoCastShineTemplate")
button:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
button:RegisterEvent("PLAYER_LOGIN")

local herbs = {
	-- http://www.wowhead.com/spell=51005/milling#milled-from:0+1+17-20
	[765] = true,		-- Silverleaf
	[785] = true,		-- Mageroyal
	[2447] = true,		-- Peacebloom
	[2449] = true,		-- Earthroot
	[2450] = true,		-- Briarthorn
	[2452] = true,		-- Swiftthistle
	[2453] = true,		-- Bruiseweed
	[3355] = true,		-- Wild Steelbloom
	[3356] = true,		-- Kingsblood
	[3357] = true,		-- Liferoot
	[3358] = true,		-- Khadgar's Whisker
	[3369] = true,		-- Grave Moss
	[3818] = true,		-- Fadeleaf
	[3819] = true,		-- Dragon's Teeth
	[3820] = true,		-- Stranglekelp
	[3821] = true,		-- Goldthorn
	[4625] = true,		-- Firebloom
	[8831] = true,		-- Purple Lotus
	[8836] = true,		-- Arthas' Tears
	[8838] = true,		-- Sungrass
	[8839] = true,		-- Blindweed
	[8845] = true,		-- Ghost Mushroom
	[8846] = true,		-- Gromsblood
	[13463] = true,		-- Dreamfoil
	[13464] = true,		-- Golden Sansam
	[13465] = true,		-- Mountain Silversage
	[13466] = true,		-- Sorrowmoss
	[13467] = true,		-- Icecap
	[22785] = true,		-- Felweed
	[22786] = true,		-- Dreaming Glory
	[22787] = true,		-- Ragveil
	[22789] = true,		-- Terocone
	[22790] = true,		-- Ancient Lichen
	[22791] = true,		-- Netherbloom
	[22792] = true,		-- Nightmare Vine
	[22793] = true,		-- Mana Thistle
	[36901] = true,		-- Goldclover
	[36903] = true,		-- Adder's Tongue
	[36904] = true,		-- Tiger Lily
	[36905] = true,		-- Lichbloom
	[36906] = true,		-- Icethorn
	[36907] = true,		-- Talandra's Rose
	[37921] = true,		-- Deadnettle
	[39969] = true,		-- Fire Seed
	[39970] = true,		-- Fire Leaf
	[52983] = true,		-- Cinderbloom
	[52984] = true,		-- Stormvine
	[52985] = true,		-- Azshara's Veil
	[52986] = true,		-- Heartblossom
	[52987] = true,		-- Twilight Jasmine
	[52988] = true,		-- Whiptail
	[72234] = true,		-- Green Tea Leaf
	[72235] = true,		-- Silkweed
	[72237] = true,		-- Rain Poppy
	[79010] = true,		-- Snow Lily
	[79011] = true,		-- Fool's Cap
	[89639] = true,		-- Desecrated Herb
	[109124] = true,	-- Frostweed
	[109125] = true,	-- Fireweed
	[109126] = true,	-- Gorgrond Flytrap
	[109127] = true,	-- Starflower
	[109128] = true,	-- Nagrand Arrowbloom
	[109129] = true,	-- Talador Orchid
	[124101] = true,	-- Aethril
	[124102] = true,	-- Dreamleaf
	[124103] = true,	-- Foxflower
	[124104] = true,	-- Fjarnskaggl
	[124105] = true,	-- Starlight Rose
	[124106] = true,	-- Felwort
	[128304] = true,	-- Yseralline Seed
	[151565] = true,	-- Astral Glory
	[152511] = true,	-- Sea Stalk
	[152509] = true,	-- Siren's Pollen
	[152508] = true,	-- Winter's Kiss
	[152507] = true,	-- Akunda's Bite
	[152506] = true,	-- Star Moss
	[152505] = true,	-- Riverbud
	[152510] = true,	-- Anchor Weed
	[168487] = true,	-- Zin'anthid
}

local ores = {
	-- http://www.wowhead.com/spell=31252/prospecting#prospected-from:0+1+17-20
	[2770] = true,		-- Copper Ore
	[2771] = true,		-- Tin Ore
	[2772] = true,		-- Iron Ore
	[3858] = true,		-- Mithril Ore
	[10620] = true,		-- Thorium Ore
	[23424] = true,		-- Fel Iron Ore
	[23425] = true,		-- Adamantite Ore
	[36909] = true,		-- Cobalt Ore
	[36910] = true,		-- Titanium Ore
	[36912] = true,		-- Saronite Ore
	[52183] = true,		-- Pyrite Ore
	[52185] = true,		-- Elementium Ore
	[53038] = true,		-- Obsidium Ore
	[72092] = true,		-- Ghost Iron Ore
	[72093] = true,		-- Kyparite
	[72094] = true,		-- Black Trillium Ore
	[72103] = true,		-- White Trillium Ore
	[123918] = true,	-- Leystone Ore
	[123919] = true,	-- Felslate
	[151564] = true,	-- Empyrium
	[152579] = true,	-- Storm Silver Ore
	[152512] = true,	-- Monelite Ore
	[152513] = true,	-- Platinum Ore
	[155830] = true,	-- Runic Core, BfA Jewelcrafting Quest
	[168185] = true,	-- Osmenite Ore
}

function button:PLAYER_LOGIN()
	local milling, prospect, disenchanter, rogue

	if IsSpellKnown(51005) then
		milling = true
	end

	if IsSpellKnown(31252) then
		prospect = true
	end

	if IsSpellKnown(13262) then
		disenchanter = true
	end

	if IsSpellKnown(1804) then
		rogue = ITEM_MIN_SKILL:gsub("%%s",  GetSpellInfo(1809)):gsub("%%d", "%(.*%)")
	end

	GameTooltip:HookScript("OnTooltipSetItem", function(self)
		local _, link = self:GetItem()

		if link and not InCombatLockdown() and IsAltKeyDown() and not (AuctionFrame and AuctionFrame:IsShown()) then
			local itemID = GetItemInfoFromHyperlink(link)
			if not itemID then return end
			local spell, r, g, b
			if milling and GetItemCount(itemID) >= 5 and herbs[itemID] then
				spell, r, g, b = GetSpellInfo(51005), 0.5, 1, 0.5
			elseif prospect and GetItemCount(itemID) >= 5 and ores[itemID] then
				spell, r, g, b = GetSpellInfo(31252), 1, 0.33, 0.33
			elseif disenchanter then
				local _, _, itemRarity, _, _, _, _, _, _, _, _, class, subClass = GetItemInfo(link)
				if not (class == LE_ITEM_CLASS_WEAPON or class == LE_ITEM_CLASS_ARMOR or (class == 3 and subClass == 11)) or not (itemRarity and (itemRarity > 1 and (itemRarity < 5 or itemRarity == 6))) then return end
				spell, r, g, b = GetSpellInfo(13262), 0.5, 0.5, 1
			elseif rogue then
				for index = 1, self:NumLines() do
					if string.match(_G["GameTooltipTextLeft"..index]:GetText() or "", rogue) then
						spell, r, g, b = GetSpellInfo(1804), 0, 1, 1
					end
				end
			end

			local bag, slot = GetMouseFocus():GetParent(), GetMouseFocus()
			if spell and GetContainerItemLink(bag:GetID(), slot:GetID()) == link then
				button:SetAttribute("macrotext", string.format("/cast %s\n/use %s %s", spell, bag:GetID(), slot:GetID()))
				button:SetAllPoints(slot)
				button:Show()
				AutoCastShine_AutoCastStart(button, r, g, b)
			end
		end
	end)

	self:SetFrameStrata("TOOLTIP")
	self:SetAttribute("*type1", "macro")
	self:SetScript("OnLeave", self.MODIFIER_STATE_CHANGED)

	self:RegisterEvent("MODIFIER_STATE_CHANGED")
	self:Hide()

	for _, sparks in pairs(self.sparkles) do
		sparks:SetHeight(sparks:GetHeight() * 3)
		sparks:SetWidth(sparks:GetWidth() * 3)
	end
end

function button:MODIFIER_STATE_CHANGED(key)
	if not self:IsShown() and not key and key ~= "LALT" and key ~= "RALT" then return end

	if InCombatLockdown() then
		self:SetAlpha(0)
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		self:ClearAllPoints()
		self:SetAlpha(1)
		self:Hide()
		AutoCastShine_AutoCastStop(self)
	end
end

function button:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:MODIFIER_STATE_CHANGED()
end
-------------------------------------------------------------------------------------------------------MerchantFilterButtons
local MerchantFrame = _G.MerchantFrame
local GetMerchantFilter = _G.GetMerchantFilter
local UnitFactionGroup = _G.UnitFactionGroup
local GameToolTip = _G.GameToolTip
local UnitClass = _G.UnitClass
local GetNumSpecializations = _G.GetNumSpecializations
local GetSpecializationInfo = _G.GetSpecializationInfo
local SetPushed,Buttons

local spacing = 36
local alltexture,allcoord
do
	if UnitFactionGroup("player") == "Neutral" and select(2,UnitClass("player")) == "MONK" then
		alltexture = "Interface\\Glues\\AccountUpgrade\\upgrade-panda"
		allcoord = {0,1,0,1}
	else
		alltexture = "Interface\\COMMON\\icon-"..strlower(UnitFactionGroup("player"))
		allcoord = {0.25,0.75,0.2,0.8}
	end
end

local function BuildButtons()
	Buttons = {
		["ALL"] = {
			text = ALL,
			texture = alltexture,
			coord = allcoord,
			filter = LE_LOOT_FILTER_ALL,
			x = -60
		},
		["BOE"] = {
			text = ITEM_BIND_ON_EQUIP,
			texture = "Interface\\Buttons\\UI-GroupLoot-Coin-Up",
			coord = {0.1,0.9,0.1,0.9},
			filter = LE_LOOT_FILTER_BOE,
			x = -(spacing) - 60,
			y = 2
		},
		["CLASS"] = {
			text = select(1,UnitClass("player")),
			texture = "Interface\\WorldStateFrame\\ICONS-CLASSES",
			coord = CLASS_ICON_TCOORDS[select(2,UnitClass("player"))],
			filter = LE_LOOT_FILTER_CLASS,
			x = -(spacing*2) - 60
		}
	}

	for i = 1, GetNumSpecializations() do
		local arg1, name, arg3, icon = GetSpecializationInfo(i);
		Buttons["SPEC"..i] = {}
		Buttons["SPEC"..i].text = name;
		Buttons["SPEC"..i].texture = icon;
		Buttons["SPEC"..i].filter = LE_LOOT_FILTER_SPEC1 + i - 1;
		Buttons["SPEC"..i].coord = {0.1,0.9,0.1,0.9};
		Buttons["SPEC"..i].x = (-(spacing)*(i+2))-60;
	end
	
	SetPushed = function(Filter)
		for k,v in pairs(Buttons) do
			local button = _G["MFB_"..k]
			if Filter == v.filter or Filter == LE_LOOT_FILTER_ALL then
				SetDesaturation(_G["MFB_"..k.."_Overlay"], 0)
			else
				SetDesaturation(_G["MFB_"..k.."_Overlay"], 1)			
			end
			if Filter == v.filter then
				--button.Flash.flasher:Play()				
				button:SetButtonState("PUSHED", 1)
			else
				--if button.Flash.flasher:IsPlaying() then
					--button.Flash.flasher:Stop()
				--end
				button:SetButtonState("NORMAL")
			end
		end	
	end
	for k,v in pairs(Buttons) do
		local button = CreateFrame("Button","MFB_"..k,MerchantFrame,"MainMenuBarMicroButton")
		button.text = v.text
		button:SetPoint("TOPLEFT",MerchantFrame,"TOPRIGHT",-4,v.x)
		button:SetScript("OnEnter",function()
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
			GameTooltip:AddLine(v.text);
			GameTooltip:Show();
		end)
		button:SetScript("OnLeave",function() GameTooltip:Hide(); end)
		button:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Up");
		button:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Down");
		button:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight");
		button.overlay = button:CreateTexture("MFB_"..k.."_Overlay","OVERLAY")
		button.overlay:SetSize(18,20)
		button.overlay:SetPoint("TOP",button,"TOP",0,(-15-(v.y or 0)))
		button.overlay:SetTexture(v.texture)
		button.overlay:SetTexCoord(unpack(v.coord))
		button.Flash.flasher = button.Flash:CreateAnimationGroup()
		local fade1 = button.Flash.flasher:CreateAnimation("Alpha")
		fade1:SetDuration(0.5)
		fade1:SetToAlpha(1)
		fade1:SetOrder(1)
		local fade2 = button.Flash.flasher:CreateAnimation("Alpha")
		fade2:SetDuration(0.5)
		fade2:SetFromAlpha(1)
		fade2:SetOrder(2)
		button.Flash:SetAlpha(0)
		button.Flash:Show()
		button:SetScript("OnClick",function(self,button)
			MerchantFrame_SetFilter(MerchantFrame,v.filter)
			SetPushed(GetMerchantFilter())			
		end)
	end
end

local MerchantFilterButtons = CreateFrame("frame")
MerchantFilterButtons:RegisterEvent("PLAYER_ENTERING_WORLD")
MerchantFilterButtons:RegisterEvent("MERCHANT_FILTER_ITEM_UPDATE")
MerchantFilterButtons:SetScript("OnEvent", function(self,event)
	if event == "PLAYER_ENTERING_WORLD" then
		MerchantFrame_SetFilter(MerchantFrame, GetMerchantFilter())
		self:UnregisterEvent(event)
		MerchantFrameLootFilter:Hide()
		BuildButtons()
	elseif event == "MERCHANT_FILTER_ITEM_UPDATE" then
		SetPushed(GetMerchantFilter())
	end
end)
MerchantFrame:HookScript("OnShow", function() MerchantFrame_SetFilter(MerchantFrame, GetMerchantFilter()) SetPushed(GetMerchantFilter()) end)