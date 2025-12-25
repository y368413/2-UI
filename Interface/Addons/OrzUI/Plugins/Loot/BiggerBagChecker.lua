--## Version: v1.5.0-alpha2 ## Author: KyrosKrane Sylvanblade
local issecretvalue = _G[issecretvalue] or function (...) return false end
local  BBC = {}

local criteria =
{
	["Cursed Swabby Helmet"] = 1,
	["Warped Warning Sign"] = 2,
	["Giant Purse of Timeless Coins"] = 3,
	["Crystal of Insanity"] = 4,
	["Battle Horn"] = 5,
	["Forager's Gloves"] = 6,
	["Big Bag of Herbs"] = 7,
	["Overgrown Lilypad"] = 8,
	["Hardened Shell"] = 9,
	["Bubbling Pi'jiu Brew"] = 10,
	["Thick Pi'jiu Brew"] = 11,
	["Misty Pi'jiu Brew"] = 12,
	["Warning Sign"] = 13,
	["Ash-Covered Horn"] = 14,
	["Cauterizing Core"] = 15,
	["Captain Zvezdan's Lost Leg"] = 16,
	["Cursed Talisman"] = 17,
	["Golden Moss"] = 18,
	["Strange Glowing Mushroom"] = 19,
	["Eternal Kiln"] = 20,
	["Jadefire Spirit"] = 21,
	["Sunset Stone"] = 22,
	["Ashen Stone"] = 23,
	["Blizzard Stone"] = 24,
	["Rain Stone"] = 25,
	["Blackflame Daggers"] = 26,
	["Falling Flame"] = 27,
	["Ordon Death Chime"] = 28,
	["Blazing Sigil of Ordos"] = 29,
	["Ordon Ceremonial Robes"] = 30,
	["Rime of the Time-Lost Mariner"] = 31,
	["Scuttler's Shell"] = 32,
	["Partially-Digested Meal"] = 33,
	["Swarmling of Gu'chi"] = 34,
	["Sticky Silkworm Goo"] = 35,
	["Faintly-Glowing Herb"] = 36,
	["Condensed Jademist"] = 37,
	["Windfeather Plume"] = 38,
	["Quivering Firestorm Egg"] = 39,
	["Reins of the Thundering Onyx Cloud Serpent"] = 40,
	["Pristine Stalker Hide"] = 41,
	["Glinting Pile of Stone"] = 42,
	["Odd Polished Stone"] = 43,
	["Glowing Blue Ash"] = 44,
	["Glowing Green Ash"] = 45,
	["Bonkers"] = 46,
	["Gulp Froglet"] = 47,
	["Spineclaw Crab"] = 48,
	["Skunky Alemental"] = 49,
	["Ominous Flame"] = 50,
	["Jademist Dancer"] = 51,
	["Death Adder Hatchling"] = 52,
	["Dandelion Frolicker"] = 53,
	["Ruby Droplet"] = 54,
	["Azure Crane Chick"] = 55,
	["Ashleaf Spriteling"] = 56
}

local mob =
{
	-- Old Rares
	["Blackhoof"] = 51059,
	["Sulik'shor"] = 50339,
	["Sele'na"] = 50766,
	["Nessos the Oracle"] = 50789,
	["Korda Torros"] = 50332,
	["Krol the Blade"] = 50356,
	-------------------------
	-- -- Timless Isle -- --
	------------------------
	-- -- --  Rare 	-- -- --
	["Emerald Gander"] = 73158,
	["Chelon"] = 72045,
	["Great Turtle Furyshell"] = 73161,
	["Archiereus of Flame (Sanctuary)"] = 73174,
	["Archiereus of Flame (Summoned)"] = 73666,
	["Watcher Osu"] = 73170,
	["Champion of the Black Flame"] = 73171,
	["Spelurk"] = 71864,
	["Rattleskew"] = 72048,
	["Leafmender"] = 73277,
	["Cinderfall"] = 73175,
	["Karkanos"]  = 72193,
	["Golganarr"] = 72970,
	["Spirit of Jadefire"] = 72769,
	["Rock Moss"] = 73157,
	["Zhu-Gon the Sour"] = 71919,
	["Bufo"] = 72775,
	["Garnia"] = 73282,
	["Jakur of Ordon"] = 73169,
	["Urdur the Cauterizer"] = 73173,
	["Flintlord Gairan"] = 73172,
	["Imperial Python"] = 73163,
	["Tsavo'ka"]  = 72808,
	["Cranegnasher"] = 72049,
	["Huolon"] = 73167,
	["Zesqua"] = 72245,
	["Dread Ship Vazuvius"] = 73281,
	["Monstrous Spineclaw"] = 73166,
	["Gu'chi the Swarmbringer"] = 72909,
	-- -- -- Normal -- -- --
	["Ancient Spineclaw"] = 72766,
	["Brilliant Windfeather"] = 72762,
	["Ordon Candlekeeper"] = 72875,
	["Gulp Frog"] = 72777,
	["Burning Berserker"] = 72895,
	["Ashleaf Sprite"] = 72877,
	["High Priest of Ordos"] = 72898,
	["Ordon Fire-Watcher"] = 72894,
	["Eternal Kilnmaster"] = 72896,
	["Blazebound Chanter"] = 72897,
	["Spectral Windwalker"] = 73021,
	["Molten Guardian"] = 72888,
	["Jademist Dancer"] = 72767,
	["Cursed Hozen Swabby"] = 71920,
	["Eroded Cliffdweller"] = 72809,
	["Foreboding Flame"] = 73162,
	["Spectral Mistweaver"] = 73025,
	["Death Adder"] = 72841,
	["Primal Stalker"] = 72805,
	["Crimsonscale Firestorm"] = 72876,
	["Spotted Swarmer"] = 72908,
	["Damp Shambler"] = 72771,
	["Spectral Brewmaster"] = 73018,
	["Ordon Oathguard"] = 72892,
	["Scary Sprite"] = 71826,
	["Nice Sprite"] = 71823
}

local color =
{
	["gray"] = "|cff9d9d9d",
	["white"] = "|cffffffff",
	["green"] = "|cff1eff00",
	["blue"] = "|cff0070dd",
	["violet"] = "|cffa335ee",
	["beige"] = "|cffe6cc80",
	["gold"] = "|cffffd200",
	["yellow"] = "|cfffbfb1f",
	["red"] = "|cffff0000",

	-- Not used here
	["orange"] = "|cffff8000",
}

local BiggerBagAchievementNum = 8728 -- the internal achievement ID for Bigger Bag

local TimelessTooltipHeadlinePrinted -- tells us if we started adding to a tooltip

---------------------------------------------

local L = {}

function BBC.updateLocale(loc)
	for k,v in pairs(loc) do
		if v == true then
			L[k] = k
		else
			L[k] = v
		end
	end
end

local function headline()
	GameTooltip:AddLine(color["gold"]..L["Going To Need A Bigger Bag"],1,1,1)
	TimelessTooltipHeadlinePrinted = true
end


local function addItem(item, itemcolor, criteriaNum, percent)
	-- In rare cases, where a lot is happening in game, it's possible to get here without some of the parameters. I don't know how it happens in game.
	-- So just in case, do some sanity checks on the passed in parameters, and just exit if they're invalid. This prevents a nasty in game error.
	if not item or not itemcolor or not criteriaNum or not percent then return end

	-- also make sure the game isn't doing something secret squirrely with the values
	if issecretvalue(item) or issecretvalue(itemcolor) or issecretvalue(criteriaNum) or issecretvalue(percent) then return end

	local _ , _ , Completed = GetAchievementCriteriaInfo(BiggerBagAchievementNum, criteriaNum);

	if not TimelessTooltipHeadlinePrinted then
		headline()
	end

	if Completed then
		GameTooltip:AddDoubleLine(color["gold"]  .. "(" .. L["completed"] .. ") " .. itemcolor .. "["..item.."]", color["beige"] .. "("..percent.."%)")
	else
		GameTooltip:AddDoubleLine(color["red"]   .. "(" .. L["missing"] ..   ") " .. itemcolor .. "["..item.."]", color["beige"] .. "("..percent.."%)")
	end
	GameTooltip:Show()
end

---------------------------------------------

local function checkObjects(...)
	-- passed-in arguments are the components (including lines of text) in the tooltip.

	local ObjectFound = ""
	local LineFound = false

	-- Mark that we haven't yet printed a headline
	TimelessTooltipHeadlinePrinted = false


	-- loop through each line of text in the tooltip
	for i = 1, select("#", ...) do
		-- check if this component is a text line
		local region = select(i, ...)
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText()

			if not issecretvalue(text) and text ~= nil then

				-- determine what object was found.
				if text == L["Crane Nest"] or text == L["Eerie Crystal"] or text == L["Sunken Treasure"] or text == L["Timeless Chest"] or text == L["Conspicuously Empty Shell"] then
					ObjectFound = text
				end

				-- parse lines to see if the correct tooltip line is already added
				if		string.find(text, L["Azure Crane Chick"]) ~= nil
					or	string.find(text, L["Crystal of Insanity"]) ~= nil
					or	string.find(text, L["Cursed Swabby Helmet"]) ~= nil
					or	string.find(text, L["Bonkers"]) ~= nil
					or	string.find(text, L["Hardened Shell"]) ~= nil
					then
						LineFound = true
						break -- we have an item and its line; no point continuing to loop.

						-- Debugging note: There may be an issue here if another addon inserts the text above into a tooltip. If you ever get strangeness about detecting objects, check for conflicting addons.
				end
			end -- if text is not nil
		end -- if region
	end -- for

	-- if an object was found and a matching tooltip line is not found, then add line.
	if ObjectFound ~= "" and not LineFound then
		-- We need to add the tooltip line for the found item.

		if ObjectFound == L["Crane Nest"] then
			addItem(L["Azure Crane Chick"],color["blue"],criteria["Azure Crane Chick"],3)
		elseif ObjectFound == L["Eerie Crystal"] then
			addItem(L["Crystal of Insanity"], color["blue"], criteria["Crystal of Insanity"],3)    -- 3%
		elseif ObjectFound == L["Sunken Treasure"] then
			addItem(L["Cursed Swabby Helmet"],color["blue"],criteria["Cursed Swabby Helmet"],67)
		elseif ObjectFound == L["Timeless Chest"] then
			addItem(L["Bonkers"],color["blue"],criteria["Bonkers"],1.5)
		elseif ObjectFound == L["Conspicuously Empty Shell"] then
			addItem(L["Hardened Shell"], color["blue"], criteria["Hardened Shell"], 1.7 )  	-- 1.7%
		end -- check each item

	end -- if need to add line

end -- function

GameTooltip:HookScript("OnShow", function()
	checkObjects(GameTooltip:GetRegions())
end)

GameTooltip:HookScript("OnUpdate", function()
	checkObjects(GameTooltip:GetRegions())
end)

---------------------------------------------


local f = CreateFrame("frame")
f:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
f:SetScript("OnEvent", function()
	TimelessTooltipHeadlinePrinted = false

	if GameTooltip:IsVisible() and not UnitIsPlayer("mouseover") and not C_PetBattles.IsInBattle() then
		local mouseover_guid = UnitGUID("mouseover")
		
		-- Rarely, the function fails to return a value. No point in continuing if so.
		if not mouseover_guid then return end

		-- Also bail out if the returned value is somehow secret.
		if issecretvalue(mouseover_guid) then return end

		local _, _, _, _, _, npcIDStr, _ = strsplit("-", mouseover_guid)
		local npcID = tonumber(npcIDStr)
		if npcID == mob["Brilliant Windfeather"] then
			addItem(L["Windfeather Plume"], color["green"], criteria["Windfeather Plume"], 8 ) -- 8%
		elseif npcID == mob["Emerald Gander"] then
			addItem(L["Windfeather Plume"], color["green"], criteria["Windfeather Plume"], 50 ) -- 50%
		elseif npcID == mob["Blackhoof"] then
			addItem(L["Battle Horn"], color["blue"], criteria["Battle Horn"], 20 ) -- 20%
		elseif npcID == mob["Ordon Candlekeeper"] then
			addItem(L["Battle Horn"], color["blue"], criteria["Battle Horn"], 0.5 ) -- 0.5%
		elseif npcID == mob["Sulik'shor"] then
			addItem(L["Crystal of Insanity"], color["blue"], criteria["Crystal of Insanity"],10)    -- 10%
		elseif npcID == mob["Sele'na"] then
			-- Note that Overgrown Lilypad (the item) was changed to Wilted Lilypad when WoD launched. The criteria still states Overgrown Lilypad though.
			addItem(L["Wilted Lilypad"],color["gray"],criteria["Overgrown Lilypad"],20)  -- 20%
		-- As per a GM note, the Wilited Lilypad only drops from Sele'na.
		--elseif npcID == mob["Gulp Frog"] then
		--	addItem(L["Wilted Lilypad"],color["gray"],criteria["Overgrown Lilypad"],1.2)  -- 1.2%
		elseif npcID == mob["Nessos the Oracle"] then
			addItem(L["Hardened Shell"], color["blue"], criteria["Hardened Shell"], 26 )  	-- 26%
		elseif npcID == mob["Great Turtle Furyshell"] then
			addItem(L["Hardened Shell"], color["blue"], criteria["Hardened Shell"], 1.7 )  	-- 1.7%
		elseif npcID == mob["Chelon"] then
			addItem(L["Hardened Shell"], color["blue"], criteria["Hardened Shell"], 1.3 )  	-- 1.3%
		elseif npcID == mob["Korda Torros"] then
			addItem(L["Forager's Gloves"], color["blue"], criteria["Forager's Gloves"], 10 )		-- 10%
		elseif npcID == mob["Burning Berserker"] then
			addItem(L["Big Bag of Herbs"], color["blue"], criteria["Big Bag of Herbs"], 0.9 )	-- 0.9%
			addItem(L["Forager's Gloves"], color["blue"], criteria["Forager's Gloves"], 0.8 )		-- 0.8%
		elseif npcID == mob["Ashleaf Sprite"] then
			addItem(L["Big Bag of Herbs"], color["blue"], criteria["Big Bag of Herbs"], 1 )	-- 1%
			addItem(L["Faintly-Glowing Herb"], color["green"], criteria["Faintly-Glowing Herb"], 10 ) -- 10%
		elseif npcID == mob["Krol the Blade"] then
			addItem(L["Elixir of Ancient Knowledge"], color["blue"], criteria["Elixir of Ancient Knowledge"], 10 ) -- 10%
		elseif npcID == mob["Archiereus of Flame (Summoned)"] or npcID == mob["Archiereus of Flame (Sanctuary)"] then
			addItem(L["Elixir of Ancient Knowledge"], color["blue"], criteria["Elixir of Ancient Knowledge"], 2 ) -- 2%
		elseif npcID == mob["High Priest of Ordos"] then
			addItem(L["Ash-Covered Horn"], color["blue"], criteria["Ash-Covered Horn"], 1.1)	-- 1.1%
		elseif npcID == mob["Watcher Osu"] then
			addItem(L["Ordon Ceremonial Robes"], color["blue"], criteria["Ordon Ceremonial Robes"], 2 )	--2%
			addItem(L["Ashen Stone"], color["blue"], criteria["Ashen Stone"], 0.9 )	-- 0.9%
		elseif npcID == mob["Champion of the Black Flame"] then
			addItem(L["Blackflame Daggers"], color["blue"], criteria["Blackflame Daggers"], 1.1 )		-- 1.1%
			addItem(L["Big Bag of Herbs"], color["blue"], criteria["Big Bag of Herbs"], 6.0 )	-- 6%
		elseif npcID == mob["Blazebound Chanter"] then
			addItem(L["Ordon Ceremonial Robes"], color["blue"], criteria["Ordon Ceremonial Robes"], 0.8 ) -- 0.8%
			addItem(L["Blizzard Stone"], color["blue"], criteria["Blizzard Stone"], 0.4 )		--0.4%
		elseif npcID == mob["Leafmender"] then
			addItem(L["Ashleaf Spriteling"], color["blue"], criteria["Ashleaf Spriteling"], 3 )
			addItem(L["Faintly-Glowing Herb"], color["green"], criteria["Faintly-Glowing Herb"], 50 )
		elseif npcID == mob["Scary Sprite"] or npcID == mob["Nice Sprite"] then
			addItem(L["Dandelion Frolicker"], color["blue"], criteria["Dandelion Frolicker"], 0.1 )
		elseif npcID == mob["Molten Guardian"] then
			addItem(L["Cauterizing Core"], color["blue"], criteria["Cauterizing Core"], 1.8 ) -- 1.8%
		elseif npcID == mob["Eternal Kilnmaster"] then
			addItem(L["Eternal Kiln"], color["blue"], criteria["Eternal Kiln"], 0.4 )
			addItem(L["Blazing Sigil of Ordos"], color["green"], criteria["Blazing Sigil of Ordos"], 1.7 )
		elseif npcID == mob["Spelurk"] then
			addItem(L["Cursed Talisman"], color["green"], criteria["Cursed Talisman"], 0.9 )
		elseif npcID == mob["Zhu-Gon the Sour"] then
			addItem(L["Skunky Alemental"], color["blue"], criteria["Skunky Alemental"], 3)
		elseif npcID == mob["Garnia"] then
			addItem(L["Ruby Droplet"], color["blue"], criteria["Ruby Droplet"], 3 )
		elseif npcID == mob["Bufo"] then
			addItem(L["Gulp Froglet"], color["blue"], criteria["Gulp Froglet"], 3 )
		elseif npcID == mob["Ordon Oathguard"] then
			addItem(L["Warped Warning Sign"], color["green"], criteria["Warped Warning Sign"], 5 )
		elseif npcID == mob["Jakur of Ordon"]  then
			addItem(L["Warning Sign"], color["blue"], criteria["Warning Sign"], 1 )
		elseif npcID == mob["Ordon Fire-Watcher"] then
			addItem(L["Ordon Ceremonial Robes"], color["blue"], criteria["Ordon Ceremonial Robes"], 0.9 )
			addItem(L["Blazing Sigil of Ordos"], color["green"], criteria["Blazing Sigil of Ordos"], 1.3 ) 		-- 1.3%
		elseif npcID == mob["Rattleskew"] then
			addItem(L["Captain Zvezdan's Lost Leg"], color["violet"], criteria["Captain Zvezdan's Lost Leg"], 3.4 )
		elseif npcID == mob["Spectral Windwalker"] then
			addItem(L["Bubbling Pi'jiu Brew"], color["green"], criteria["Bubbling Pi'jiu Brew"], 7.7 )  -- 7.66%
		elseif npcID == mob["Urdur the Cauterizer"] then
			addItem(L["Ordon Ceremonial Robes"], color["blue"], criteria["Ordon Ceremonial Robes"], 2 )
			addItem(L["Sunset Stone"], color["blue"], criteria["Sunset Stone"], 3.1 )
		elseif npcID == mob["Spectral Mistweaver"] then
			addItem(L["Misty Pi'jiu Brew"], color["green"], criteria["Misty Pi'jiu Brew"], 7.8 )
		elseif npcID == mob["Spectral Brewmaster"] then
			addItem(L["Thick Pi'jiu Brew"], color["green"], criteria["Thick Pi'jiu Brew"], 7.7 )
		elseif npcID == mob["Damp Shambler"] then
			addItem(L["Strange Glowing Mushroom"], color["green"], criteria["Strange Glowing Mushroom"], 47)
		elseif npcID == mob["Gu'chi the Swarmbringer"] then
			addItem(L["Swarmling of Gu'chi"], color["blue"], criteria["Swarmling of Gu'chi"], 3 )
			addItem(L["Sticky Silkworm Goo"], color["green"], criteria["Sticky Silkworm Goo"], 47 )
		elseif npcID == mob["Spotted Swarmer"] then
			addItem(L["Sticky Silkworm Goo"], color["green"], criteria["Sticky Silkworm Goo"], 1.9 )
		elseif npcID == mob["Cranegnasher"] then
			addItem(L["Pristine Stalker Hide"], color["blue"], criteria["Pristine Stalker Hide"], 1.9 )
		elseif npcID == mob["Tsavo'ka"] then
			addItem(L["Pristine Stalker Hide"], color["blue"], criteria["Pristine Stalker Hide"], 1.9 )
		elseif npcID == mob["Primal Stalker"]  then
			addItem(L["Pristine Stalker Hide"], color["blue"], criteria["Pristine Stalker Hide"], 0.9 )
		elseif npcID == mob["Death Adder"] then
			addItem(L["Partially-Digested Meal"], color["blue"], criteria["Partially-Digested Meal"], 2 )
		elseif npcID == mob["Imperial Python"]  then
			addItem(L["Death Adder Hatchling"], color["green"], criteria["Death Adder Hatchling"], 3 )
			addItem(L["Partially-Digested Meal"], color["blue"], criteria["Partially-Digested Meal"], 2 )
		elseif npcID == mob["Huolon"] then
			addItem(L["Reins of the Thundering Onyx Cloud Serpent"], color["violet"], criteria["Reins of the Thundering Onyx Cloud Serpent"], 1 )
			addItem(L["Quivering Firestorm Egg"], color["white"], criteria["Quivering Firestorm Egg"], 23 )
		elseif npcID == mob["Crimsonscale Firestorm"] then
			addItem(L["Quivering Firestorm Egg"], color["white"], criteria["Quivering Firestorm Egg"], 7 )
		elseif npcID == mob["Cinderfall"] then
			addItem(L["Falling Flame"], color["blue"], criteria["Falling Flame"], 2.1 )
			addItem(L["Glowing Blue Ash"], color["blue"], criteria["Glowing Blue Ash"], 1.9 )
		elseif npcID == mob["Jademist Dancer"] then
			addItem(L["Jademist Dancer"], color["blue"], criteria["Jademist Dancer"], 0.5 )
			addItem(L["Condensed Jademist"], color["green"], criteria["Condensed Jademist"], 8 )
		elseif npcID == mob["Karkanos"] then
			addItem(L["Giant Purse of Timeless Coins"], color["white"], criteria["Giant Purse of Timeless Coins"], 23.8 )
		elseif npcID == mob["Golganarr"] then
			addItem(L["Odd Polished Stone"], color["blue"], criteria["Odd Polished Stone"], 23 )
			addItem(L["Glinting Pile of Stone"], color["blue"], criteria["Glinting Pile of Stone"], 2 )
		elseif npcID == mob["Eroded Cliffdweller"] then
			addItem(L["Glinting Pile of Stone"], color["blue"], criteria["Glinting Pile of Stone"], 0.9 )
			addItem(L["Odd Polished Stone"], color["blue"], criteria["Odd Polished Stone"], 0.4 )
		elseif npcID == mob["Foreboding Flame"] then
			addItem(L["Glowing Blue Ash"], color["blue"], criteria["Glowing Blue Ash"], 0.9 )
			addItem(L["Ominous Flame"], color["blue"], criteria["Ominous Flame"], 0.5)
		elseif npcID == mob["Spirit of Jadefire"] then
			addItem(L["Glowing Green Ash"], color["blue"], criteria["Glowing Green Ash"], 2.1 )
			addItem(L["Jadefire Spirit"], color["blue"], criteria["Jadefire Spirit"], 2.1 )
		elseif npcID == mob["Rock Moss"] then
			addItem(L["Golden Moss"], color["blue"], criteria["Golden Moss"] , 3 )
			addItem(L["Strange Glowing Mushroom"], color["green"], criteria["Strange Glowing Mushroom"], 51 )
		elseif npcID == mob["Dread Ship Vazuvius"] then
			addItem(L["Rime of the Time-Lost Mariner"], color["blue"], criteria["Rime of the Time-Lost Mariner"], 14 )
		elseif npcID == mob["Monstrous Spineclaw"] then
			addItem(L["Spineclaw Crab"], color["blue"], criteria["Spineclaw Crab"], 1.8 )
			addItem(L["Scuttler's Shell"], color["green"], criteria["Scuttler's Shell"], 45 )
		elseif npcID == mob["Ancient Spineclaw"] then
			addItem(L["Scuttler's Shell"], color["green"], criteria["Scuttler's Shell"], 10 )
		elseif npcID == mob["Flintlord Gairan"] then
			addItem(L["Ordon Death Chime"], color["violet"], criteria["Ordon Death Chime"], 2.5)
		elseif npcID == mob["Zesqua"] then
			addItem(L["Rain Stone"], color["blue"], criteria["Rain Stone"], 1 )
		end
	end
end)


if GetLocale() == "zhCN" then
	BBC.updateLocale(
{
	["Going To Need A Bigger Bag"] = "需要一个大背包",
	--
	["Cursed Swabby Helmet"] = "受诅咒的水手头盔",
	["Warped Warning Sign"] = "扭曲的警告标志",
	["Giant Purse of Timeless Coins"] = "一大包永恒铸币",
	["Crystal of Insanity"] = "狂乱水晶",
	["Battle Horn"] = "战斗号角",
	["Elixir of Ancient Knowledge"] = "远古知识药剂",
	["Forager's Gloves"] = "劫匪的手套",
	["Big Bag of Herbs"] = "一大袋草药",
	["Big Bag of Herbs (Old)"] = "一大袋草药(旧)",
	["Wilted Lilypad"] = "过度生长的睡莲",
	["Hardened Shell"] = "硬化之壳",
	["Bubbling Pi'jiu Brew"] = "气泡老啤酒",
	["Thick Pi'jiu Brew"] = "馥郁老啤酒",
	["Misty Pi'jiu Brew"] = "薄雾老啤酒",
	["Warning Sign"] = "警告标志",
	["Ash-Covered Horn"] = "蒙尘号角",
	["Cauterizing Core"] = "炽灼之核",
	["Captain Zvezdan's Lost Leg"] = "扎维兹坦船长遗失的小腿",
	["Cursed Talisman"] = "被诅咒的护符",
	["Golden Moss"] = "金苔藓",
	["Strange Glowing Mushroom"] = "发光的怪蘑菇",
	["Eternal Kiln"] = "永恒炭炉",
	["Jadefire Spirit"] = "玉火焰灵",
	["Sunset Stone"] = "夕阳之石",
	["Ashen Stone"] = "灰烬之石",
	["Blizzard Stone"] = "风雪之石",
	["Rain Stone"] = "降雨之石",
	["Blackflame Daggers"] = "黑火匕首",
	["Falling Flame"] = "坠落之焰",
	["Ordon Death Chime"] = "斡耳朵死亡之钟",
	["Blazing Sigil of Ordos"] = "斡耳朵斯的炽燃之印",
	["Ordon Ceremonial Robes"] = "斡耳朵仪式长袍",
	["Rime of the Time-Lost Mariner"] = "迷时水手结晶",
	["Scuttler's Shell"] = "钳爪蟹壳",
	["Partially-Digested Meal"] = "消化了一半的肉",
	["Swarmling of Gu'chi"] = "古赤的蚕宝宝",
	["Sticky Silkworm Goo"] = "黏糊糊的蚕虫黏液",
	["Faintly-Glowing Herb"] = "微微发光的草药",
	["Condensed Jademist"] = "浓缩的翠雾",
	["Windfeather Plume"] = "风翎鹤羽",
	["Quivering Firestorm Egg"] = "颤动的风火龙蛋",
	["Reins of the Thundering Onyx Cloud Serpent"] = "雷霆玛瑙云端翔龙缰绳",
	["Pristine Stalker Hide"] = "新鲜的追猎者之皮",
	["Glinting Pile of Stone"] = "一堆闪亮的石头",
	["Odd Polished Stone"] = "古怪的抛光石",
	["Glowing Blue Ash"] = "发光的蓝色灰烬",
	["Glowing Green Ash"] = "发光的绿色灰烬",
	["Bonkers"] = "邦卡斯",
	["Gulp Froglet"] = "幼年巨口蛙",
	["Spineclaw Crab"] = "钳爪小螃蟹",
	["Skunky Alemental"] = "酒灵臭臭",
	["Ominous Flame"] = "不祥焰灵",
	["Jademist Dancer"] = "翠雾舞者",
	["Death Adder Hatchling"] = "致死小蝰蛇",
	["Dandelion Frolicker"] = "菊苣嬉闹者",
	["Ruby Droplet"] = "红玉小水滴",
	["Azure Crane Chick"] = "天青雏鹤",
	["Ashleaf Spriteling"] = "灰叶小林精",
	---
	["Crane Nest"] = "鹤巢",
	["Eerie Crystal"] = "神秘的水晶",
	["Sunken Treasure"] = "沉没的宝箱",
	["Timeless Chest"] = "永恒宝箱",
	["Conspicuously Empty Shell"] = true, -- @TODO: Get translation
	---
	["missing"] = "缺少",
	["completed"] = "已完成",
}
)


elseif GetLocale() == "zhTW" then
	BBC.updateLocale(
{
	["Going To Need A Bigger Bag"] = "需要更大的袋子",
	--
	["Cursed Swabby Helmet"] = "受詛咒的潛水者頭盔",
	["Warped Warning Sign"] = "歪斜的警告標誌",
	["Giant Purse of Timeless Coins"] = "永恆硬幣大型錢袋",
	["Crystal of Insanity"] = "精神錯亂水晶",
	["Battle Horn"] = "戰鬥號角",
	["Elixir of Ancient Knowledge"] = "遠古知識藥劑",
	["Forager's Gloves"] = "強奪者手套",
	["Big Bag of Herbs"] = "一大袋藥草",
	["Big Bag of Herbs (Old)"] = "一大袋藥草(舊)",
	["Wilted Lilypad"] = "巨大的睡蓮葉",
	["Hardened Shell"] = "強化硬殼",
	["Bubbling Pi'jiu Brew"] = "泡沫老埤周啤酒",
	["Thick Pi'jiu Brew"] = "濃醇老埤周啤酒",
	["Misty Pi'jiu Brew"] = "混濁老埤周啤酒",
	["Warning Sign"] = "警告標誌",
	["Ash-Covered Horn"] = "覆著灰燼的角",
	["Cauterizing Core"] = "灼焚之核",
	["Captain Zvezdan's Lost Leg"] = "船長伊斯斐丹的斷腿",
	["Cursed Talisman"] = "被詛咒的咒符",
	["Golden Moss"] = "黃金苔",
	["Strange Glowing Mushroom"] = "奇怪的發光蘑菇",
	["Eternal Kiln"] = "永恆窯爐",
	["Jadefire Spirit"] = "碧火精靈",
	["Sunset Stone"] = "日落之石",
	["Ashen Stone"] = "塵暴之石",
	["Blizzard Stone"] = "暴雪之石",
	["Rain Stone"] = "暴雨之石",
	["Blackflame Daggers"] = "黑焰匕首",
	["Falling Flame"] = "流火之焰",
	["Ordon Death Chime"] = "歐朵獻祭風鈴",
	["Blazing Sigil of Ordos"] = "歐朵斯熾火法印",
	["Ordon Ceremonial Robes"] = "歐朵儀祭長袍",
	["Rime of the Time-Lost Mariner"] = "驚懼水手之歌",
	["Scuttler's Shell"] = "螃蟹殼",
	["Partially-Digested Meal"] = "消化了一半的餐食",
	["Swarmling of Gu'chi"] = "古奇的蟲群",
	["Sticky Silkworm Goo"] = "蠶的黏液",
	["Faintly-Glowing Herb"] = "閃著微光的藥草",
	["Condensed Jademist"] = "凝結碧霧",
	["Windfeather Plume"] = "風鶴之雨",
	["Quivering Firestorm Egg"] = "顫動的火焰風暴之蛋",
	["Reins of the Thundering Onyx Cloud Serpent"] = "雷霆黑曜雲蛟韁繩",
	["Pristine Stalker Hide"] = "原始潛獵者皮革",
	["Glinting Pile of Stone"] = "一堆閃爍的石頭",
	["Odd Polished Stone"] = "光滑的怪石子",
	["Glowing Blue Ash"] = "發光的藍色灰燼",
	["Glowing Green Ash"] = "發光的綠色灰燼",
	["Bonkers"] = "嚎怪",
	["Gulp Froglet"] = "小咕嚕蛙",
	["Spineclaw Crab"] = "虎鉗蟹",
	["Skunky Alemental"] = "惡臭酒元素",
	["Ominous Flame"] = "不祥之焰",
	["Jademist Dancer"] = "碧霧舞者",
	["Death Adder Hatchling"] = "死亡奎蛇寶寶",
	["Dandelion Frolicker"] = "蒲公英小妖",
	["Ruby Droplet"] = "小晶紅水靈",
	["Azure Crane Chick"] = "小蒼藍鶴",
	["Ashleaf Spriteling"] = "小灰葉妖精",
	---
	["Crane Nest"] = "鶴巢",
	["Eerie Crystal"] = "神秘的水晶",
	["Sunken Treasure"] = "水下寶藏",
	["Timeless Chest"] = "永恆寶箱",
	["Conspicuously Empty Shell"] = true, -- @TODO: Get translation
	----
	["missing"] = "缺少",
	["completed"] = "已完成",
}
)
else

BBC.updateLocale(
{
	["Going To Need A Bigger Bag"] = true,
	--
	["Cursed Swabby Helmet"] = true,
	["Warped Warning Sign"] = true,
	["Giant Purse of Timeless Coins"] = true,
	["Crystal of Insanity"] = true,
	["Battle Horn"] = true,
	["Elixir of Ancient Knowledge"] = true,
	["Forager's Gloves"] = true,
	["Big Bag of Herbs"] = true,
	["Big Bag of Herbs (Old)"] = true,
	["Wilted Lilypad"] = true,
	["Hardened Shell"] = true,
	["Bubbling Pi'jiu Brew"] = true,
	["Thick Pi'jiu Brew"] = true,
	["Misty Pi'jiu Brew"] = true,
	["Warning Sign"] = true,
	["Ash-Covered Horn"] = true,
	["Cauterizing Core"] = true,
	["Captain Zvezdan's Lost Leg"] = true,
	["Cursed Talisman"] = true,
	["Golden Moss"] = true,
	["Strange Glowing Mushroom"] = true,
	["Eternal Kiln"] = true,
	["Jadefire Spirit"] = true,
	["Sunset Stone"] = true,
	["Ashen Stone"] = true,
	["Blizzard Stone"] = true,
	["Rain Stone"] = true,
	["Blackflame Daggers"] = true,
	["Falling Flame"] = true,
	["Ordon Death Chime"] = true,
	["Blazing Sigil of Ordos"] = true,
	["Ordon Ceremonial Robes"] = true,
	["Rime of the Time-Lost Mariner"] = true,
	["Scuttler's Shell"] = true,
	["Partially-Digested Meal"] = true,
	["Swarmling of Gu'chi"] = true,
	["Sticky Silkworm Goo"] = true,
	["Faintly-Glowing Herb"] = true,
	["Condensed Jademist"] = true,
	["Windfeather Plume"] = true,
	["Quivering Firestorm Egg"] = true,
	["Reins of the Thundering Onyx Cloud Serpent"] = true,
	["Pristine Stalker Hide"] = true,
	["Glinting Pile of Stone"] = true,
	["Odd Polished Stone"] = true,
	["Glowing Blue Ash"] = true,
	["Glowing Green Ash"] = true,
	["Bonkers"] = true,
	["Gulp Froglet"] = true,
	["Spineclaw Crab"] = true,
	["Skunky Alemental"] = true,
	["Ominous Flame"] = true,
	["Jademist Dancer"] = true,
	["Death Adder Hatchling"] = true,
	["Dandelion Frolicker"] = true,
	["Ruby Droplet"] = true,
	["Azure Crane Chick"] = true,
	["Ashleaf Spriteling"] = true,
	---
	["Crane Nest"] = true,
	["Eerie Crystal"] = true,
	["Sunken Treasure"] = true,
	["Timeless Chest"] = true,
	["Conspicuously Empty Shell"] = true,
	---
	["completed"] = "Done",
	["missing"] = "Need",
}
)
end