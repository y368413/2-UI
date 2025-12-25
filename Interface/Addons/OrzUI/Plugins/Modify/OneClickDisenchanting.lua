----------------------------------------------------------------------------------------
--	One-click Milling, Prospecting and Disenchanting(Molinari by p3lim)
----------------------------------------------------------------------------------------
local TEMPLATES = {
	'SecureActionButtonTemplate',
	'SecureHandlerAttributeTemplate',
	'SecureHandlerEnterLeaveTemplate',
}

local button = CreateFrame("Button", "OneClickMPD", UIParent, table.concat(TEMPLATES, ','))
button:RegisterForClicks("AnyUp", "AnyDown")  --"RightButtonUp", "RightButtonDown"
button:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
button:RegisterEvent("PLAYER_LOGIN")

local herbs = {	--草药 --millable研磨 51005
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
	[168583] = true,	-- Widowbloom
	[168586] = true,	-- Rising Glory
	[168589] = true,	-- Marrowroot
	[169701] = true,	-- Deathblossom
	[170554] = true,	-- Vigil's Torch
	[171315] = true,	-- Nightshade
	[187699] = true,	-- First Flower
	[191460] = true, 	-- Hochenblume
	[191461] = true, 	-- Hochenblume
	[191462] = true, 	-- Hochenblume
	[191464] = true, 	-- Saxifrage
	[191465] = true, 	-- Saxifrage
	[191466] = true, 	-- Saxifrage
	[191467] = true, 	-- Bubble Poppy
	[191468] = true, 	-- Bubble Poppy
	[191469] = true, 	-- Bubble Poppy
	[191470] = true, 	-- Writhebark
	[191471] = true, 	-- Writhebark
	[191472] = true, 	-- Writhebark
	[200061] = true, 	-- Prismatic Leaper
	[210796] = true, 	-- Mycobloom
	[210797] = true, 	-- Mycobloom
	[210798] = true, 	-- Mycobloom
	[210799] = true, 	-- Luredrop
	[210800] = true, 	-- Luredrop
	[210801] = true, 	-- Luredrop
	[210802] = true, 	-- Orbinid
	[210803] = true, 	-- Orbinid
	[210804] = true, 	-- Orbinid
	[210805] = true, 	-- Blessing Blossom
	[210806] = true, 	-- Blessing Blossom
	[210807] = true, 	-- Blessing Blossom
	[220141] = true, 	-- Specular Rainbowfish
	
}

local ores = {	--矿 --prospectable选矿
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
	[152512] = true,	-- Monelite Ore
	[152513] = true,	-- Platinum Ore
	[151564] = true,	-- Empyrium
	[152579] = true,	-- Storm Silver Ore
	[155830] = true,	-- Runic Core, BfA Jewelcrafting Quest
	[168185] = true,	-- Osmenite Ore
	[171828] = true,	-- Laestrite
	[171829] = true,	-- Solenium
	[171830] = true,	-- Oxxein
	[171831] = true,	-- Phaedrum
	[171832] = true,	-- Sinvyr
	[171833] = true,	-- Elethium
	[187700] = true,	-- Progenium Ore
	[188658] = true, 	-- Draconium Ore
	[189143] = true, 	-- Draconium Ore
	[190311] = true, 	-- Draconium Ore
	[190312] = true, 	-- Khaz'gorite Ore
	[190313] = true, 	-- Khaz'gorite Ore
	[190314] = true, 	-- Khaz'gorite Ore
	[190394] = true, 	-- Serevite Ore
	[190395] = true, 	-- Serevite Ore
	[190396] = true, 	-- Serevite Ore
	[192880] = true, 	-- Crumbled Stone
	[194545] = true, 	-- Prismatic Ore
	[199344] = true, 	-- Magma Thresher
	[210930] = true, 	-- Bismuth
	[210931] = true, 	-- Bismuth
	[210932] = true, 	-- Bismuth
	[210933] = true, 	-- Aqirite
	[210934] = true, 	-- Aqirite
	[210935] = true, 	-- Aqirite
	[210936] = true, 	-- Ironclaw Ore
	[210937] = true, 	-- Ironclaw Ore
	[210938] = true, 	-- Ironclaw Ore
	[210939] = true, 	-- Null Stone
	[213398] = true, 	-- Handful of Pebbles

}

local enchantingItems = {	--附魔 --disenchantable分解
	-- Legion enchanting quest line
	[137195] = true, -- Highmountain Armor
	[137221] = true, -- Enchanted Raven Sigil
	[137286] = true, -- Fel-Crusted Rune
	-- Shadowlands profession world quests
	[182021] = true, -- Antique Kyrian Javelin
	[182043] = true, -- Antique Necromancer's Staff
	[182067] = true, -- Antique Duelist's Rapier
	[181991] = true, -- Antique Stalker's Bow
	-- Dragonflight profession items
	-- https://www.wowhead.com/items?filter=104;0;amount+of+magical+power+can+be+sensed+from+within
	[200479] = true, -- Sophic Amalgamation --Molinari\data\disenchantable.lua
	[200939] = true, -- Chromatic Pocketwatch
	[200940] = true, -- Everflowing Inkwell
	[200941] = true, -- Seal of Order
	[200942] = true, -- Vibrant Emulsion
	[200943] = true, -- Whispering Band
	[200945] = true, -- Valiant Hammer
	[200946] = true, -- Thunderous Blade
	[200947] = true, -- Carving of Awakening
	-- https://www.wowhead.com/items?filter=104;0;Disenchant+to+gain+Enchanting+knowledge
	[190336] = true, -- Thrumming Powerstone
	[198694] = true, -- Enriched Earthen Shard
	[198798] = true, -- Flashfrozen Scroll
	[198800] = true, -- Fractured Titanic Sphere
	[198689] = true, -- Stormbound Horn
	[198799] = true, -- Forgotten Arcane Tome
	[198675] = true, -- Lava-Infused Seed
	[201360] = true, -- Glimmer of Order
	[201358] = true, -- Glimmer of Air
	[201357] = true, -- Glimmer of Frost
	[201359] = true, -- Glimmer of Earth
	[201356] = true, -- Glimmer of Fire
	[204990] = true, -- Lava-Drenched Shadow Crystal
	[204999] = true, -- Shimmering Aqueous Orb
	[205001] = true, -- Resonating Arcane Crystal
	[210228] = true, -- Pure Dream Water
	[210231] = true, -- Everburning Core
	[210234] = true, -- Essence of Dreams
	
}

--todo 选矿 194709，5块；碾碎 201926，3枚
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
		rogue = ITEM_MIN_SKILL:gsub("%%s", C_Spell.GetSpellName(1809)):gsub("%%d", "%(.*%)")
	end

	local function OnTooltipSetUnit(self, data)
		if self ~= GameTooltip or self:IsForbidden() then return end
		local _, link = TooltipUtil.GetDisplayedItem(self)

		if link and not InCombatLockdown() and IsAltKeyDown() and not (AuctionHouseFrame and AuctionHouseFrame:IsShown()) then
			local itemID = GetItemInfoFromHyperlink(link)
			if not itemID then return end
			local spell, r, g, b
			if milling and GetItemCount(itemID) >= 5 and herbs[itemID] then
				spell, r, g, b = C_Spell.GetSpellName(51005), 0.5, 1, 0.5
			elseif prospect and GetItemCount(itemID) >= 5 and ores[itemID] then
				spell, r, g, b = C_Spell.GetSpellName(31252), 1, 0.33, 0.33
			elseif disenchanter then
				if enchantingItems[itemID] then
					spell, r, g, b = C_Spell.GetSpellName(13262), 0.5, 0.5, 1
				else
					local _, _, quality, _, _, _, _, _, _, _, _, class, subClass = C_Item.GetItemInfo(link)
					if quality and ((quality >= Enum.ItemQuality.Uncommon and quality <= Enum.ItemQuality.Epic)
						and C_Item.GetItemInventoryTypeByID(itemID) ~= Enum.InventoryType.IndexBodyType
						and (class == Enum.ItemClass.Weapon
							or (class == Enum.ItemClass.Armor and subClass ~= Enum.ItemClass.Cosmetic)
							or (class == Enum.ItemClass.Gem and subClass == 11)
							or class == Enum.ItemClass.Profession)) then
						spell, r, g, b = C_Spell.GetSpellName(13262), 0.5, 0.5, 1
					end
				end
			elseif rogue then
				for index = 1, self:NumLines() do
					if string.match(_G["GameTooltipTextLeft"..index]:GetText() or "", rogue) then
						spell, r, g, b = C_Spell.GetSpellName(1804), 0, 1, 1
					end
				end
			end

			--[[if data.guid then
				local location = C_Item.GetItemLocation(data.guid)
				if location and location:IsBagAndSlot() then
					local bagID, slotID = location:GetBagAndSlot()
					if spell and C_Container.GetContainerItemLink(bagID, slotID) == link then
						button:SetAttribute("macrotext", string.format("/cast %s\n/use %s %s", spell, bagID, slotID))
						local slot = self:GetOwner()
						button:SetPoint("TOPLEFT", slot, "TOPLEFT", 2, 0)
						button:SetPoint("BOTTOMRIGHT", slot, "BOTTOMRIGHT", 2, 0)
						button:Show()
						--StartSparkles(button, r, g, b)
					end
				end
			end]]

			local mouseFoci = GetMouseFoci()
			local bag, slot
			if mouseFoci and mouseFoci[1] then
				bag = mouseFoci[1]:GetParent()
				slot = mouseFoci[1]
			end
			if spell and C_Container.GetContainerItemLink(bag:GetID(), slot:GetID()) == link then
				button:SetAttribute("macrotext", string.format("/cast %s\n/use %s %s", spell, bag:GetID(), slot:GetID()))
				button:SetAllPoints(slot)
				button:Show()
			end
		end
	end

	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetUnit)

	self:SetFrameStrata("TOOLTIP")
	self:SetAttribute("*type2", "macro")   -- type1 左键
	self:SetScript("OnLeave", self.MODIFIER_STATE_CHANGED)

	self:RegisterEvent("MODIFIER_STATE_CHANGED")
	self:Hide()
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
		
		--StopSparkles(self)
		 -- 修改 Glow 纹理的大小设置
		local Glow = button:CreateTexture(nil, 'ARTWORK')
		Glow:SetPoint('CENTER')
		Glow:SetAtlas('UI-HUD-ActionBar-Proc-Loop-Flipbook')
		Glow:SetDesaturated(true) -- it's normally yellow, can't color that

        local width, height = self:GetSize()
        Glow:SetSize(width * 1.4, height * 1.4)  -- 设置为与按钮相同的大小

		local Animation = button:CreateAnimationGroup()
		Animation:SetLooping('REPEAT')

		local FlipBook = Animation:CreateAnimation('FlipBook')
		FlipBook:SetTarget(Glow)
		FlipBook:SetDuration(1)
		FlipBook:SetFlipBookColumns(5)
		FlipBook:SetFlipBookRows(6)
		FlipBook:SetFlipBookFrames(30)

		function SetColor(color)
			Glow:SetVertexColor(color:GetRGB())
			-- need to adjust the size too
			local width, height = self:GetSize()
			Glow:SetSize(width * 1.4, height * 1.4)
		end

		button:HookScript('OnShow', function()
			Animation:Play()
		end)

		button:HookScript('OnHide', function()
			Animation:Stop()
		end)
	end
end

function button:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:MODIFIER_STATE_CHANGED()
end