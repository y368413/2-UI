local _, ns = ...
local M, R, U, I = unpack(ns)
local RewardIcons_DisableBountyColors = false

local GetCurrentMapID, tonumber, format, floor, pairs = 
      function() return WorldMapFrame:GetMapID() or 0 end, tonumber, format, floor, pairs
local IsQuestComplete, IsQuestCriteriaForBounty = C_QuestLog.IsComplete, C_QuestLog.IsQuestCriteriaForBounty
local function GetCurrencyInfo(id)
	local data = C_CurrencyInfo.GetCurrencyInfo(id)
	return data.name, nil, data.iconFileID
end
local function GetQuestTagInfo(id)
	local data = C_QuestLog.GetQuestTagInfo(id)
	return data.tagID, data.tagName, data.worldQuestType, data.quality, data.isElite, data.tradeskillLineID, data.displayExpiration
end
local function WorldQuestList_IsAzeriteItemAtMaxLevel()
	return C_AzeriteItem.IsAzeriteItemAtMaxLevel()
end

local GetNumQuestLogRewardCurrencies, GetQuestLogRewardCurrencyInfo = GetNumQuestLogRewardCurrencies, GetQuestLogRewardCurrencyInfo
if not GetNumQuestLogRewardCurrencies then
	local reward_cache = {}
	local function GetData(questID)
		local data = reward_cache[questID]
		local t = GetTime()
		if not data or t > data.expTime then
			data = C_QuestLog.GetQuestRewardCurrencies(questID)
			data.expTime = t + 5
		end
		return data
	end
	function GetNumQuestLogRewardCurrencies(questID)
		local data = GetData(questID)
		return #data
	end
	function GetQuestLogRewardCurrencyInfo(i, questID)
		local data = GetData(questID)[i]
		if not data then
			return
		end
		return data.name, data.texture, data.baseRewardAmount, data.currencyID
		--data.totalRewardAmount
	end
end

local WorldQuestList_QuestIDtoMapID = {}
local CacheQuestItemReward = {}
local CacheIsAnimaItem = {}
	local list = {
		[1579] = 2164,
		[1598] = 2163,
		
		[1600] = 2157,
		[1595] = 2156,
		[1597] = 2103,
		[1596] = 2158,
		
		[1599] = 2159,
		[1593] = 2160,
		[1594] = 2162,
		[1592] = 2161,

		[1738] = 2373,
		[1739] = 2400,
		[1740] = 2391,
		[1742] = 2391,

		[1804] = 2407,
		[1805] = 2410,
		[1806] = 2465,
		[1807] = 2413,

		[1837] = 2445,
		[1838] = 2449,
		[1839] = 2453,
		[1840] = 2460,
		[1841] = 2455,
		[1842] = 2446,
		[1843] = 2461,
		[1844] = 2457,
		[1845] = 2450,
		[1846] = 2459,
		[1847] = 2458,
		[1848] = 2452,
		[1849] = 2448,
		[1850] = 2454,
		[1851] = 2456,
		[1852] = 2451,
		[1853] = 2447,

		[1907] = 2470,

		[1982] = 2478,

		[2106] = 2510,
		[2031] = 2507,
		[2108] = 2503,
		[2109] = 2511,

		[2420] = 2568,

		[2819] = 2615,
		[2652] = 2574,
 
		[2903] = 2600,
		[3004] = 2607,
		[3003] = 2605,
		[3002] = 2601,
		[2897] = 2590,
		[2899] = 2570,
	}
do
	local prevTime = 0
	local prevRes
	function WorldQuestList_GetCallingQuests()
		local nowTime = GetTime()
		if (nowTime - prevTime < 15) and prevRes then
			return unpack(prevRes)
		end
		prevTime = nowTime
		prevRes = {}
		for i=1,C_QuestLog.GetNumQuestLogEntries() do
			local questID = C_QuestLog.GetQuestIDForLogIndex(i)
			if questID ~= 0 and C_QuestLog.IsQuestCalling(questID) then
				prevRes[#prevRes+1] = questID
			end
		end
		return unpack(prevRes)
	end
end

local SlotToIcon = {
	["INVTYPE_HEAD"]="transmog-nav-slot-head",
	["INVTYPE_NECK"]="Warlock-ReadyShard",
	["INVTYPE_SHOULDER"]="transmog-nav-slot-shoulder",
	["INVTYPE_CHEST"]="transmog-nav-slot-chest",
	["INVTYPE_WAIST"]="transmog-nav-slot-waist",
	["INVTYPE_LEGS"]="transmog-nav-slot-legs",
	["INVTYPE_FEET"]="transmog-nav-slot-feet",
	["INVTYPE_WRIST"]="transmog-nav-slot-wrist",
	["INVTYPE_HAND"]="transmog-nav-slot-hands", 
	["INVTYPE_FINGER"]="Warlock-ReadyShard", 
	["INVTYPE_TRINKET"]="Warlock-ReadyShard",
	["INVTYPE_CLOAK"]="transmog-nav-slot-back",	
	["INVTYPE_WEAPON"]="transmog-nav-slot-mainhand",
	["INVTYPE_2HWEAPON"]="transmog-nav-slot-mainhand",
	["INVTYPE_RANGED"]="transmog-nav-slot-mainhand",
	["INVTYPE_RANGEDRIGHT"]="transmog-nav-slot-mainhand",
	["INVTYPE_WEAPONMAINHAND"]="transmog-nav-slot-mainhand", 
	["INVTYPE_SHIELD"]="transmog-nav-slot-secondaryhand",
	["INVTYPE_WEAPONOFFHAND"]="transmog-nav-slot-secondaryhand",
	[select(3,C_Item.GetItemInfoInstant(141265))] = "Warlock-ReadyShard",
	}
local GENERAL_MAPS = {	--1: continent A, 2: azeroth, 3: argus, 4: continent B
	[947] = 2,
	[875] = 1,
	[876] = 1,
	[619] = 4,
	[905] = 3,
	[994] = 3,
	[572] = 4,
	[113] = 4,
	[424] = 4,
	[12] = 4,
	[13] = 4,
	[101] = 4,
	[1550] = 1,
	[1978] = 1,
	[2274] = 1,
}
local LE = {
	LE_QUEST_TAG_TYPE_INVASION = Enum.QuestTagType.Invasion,
	LE_QUEST_TAG_TYPE_DUNGEON = Enum.QuestTagType.Dungeon,
	LE_QUEST_TAG_TYPE_RAID = Enum.QuestTagType.Raid,
	LE_WORLD_QUEST_QUALITY_RARE = Enum.WorldQuestQuality.Rare,
	LE_WORLD_QUEST_QUALITY_EPIC = Enum.WorldQuestQuality.Epic,
	LE_QUEST_TAG_TYPE_PVP = Enum.QuestTagType.PvP,
	LE_QUEST_TAG_TYPE_PET_BATTLE = Enum.QuestTagType.PetBattle,
	LE_QUEST_TAG_TYPE_PROFESSION = Enum.QuestTagType.Profession,
	LE_ITEM_QUALITY_COMMON = Enum.WorldQuestQuality.Common,
	LE_QUEST_TAG_TYPE_FACTION_ASSAULT = Enum.QuestTagType.FactionAssault,
	LE_QUEST_TAG_TYPE_THREAT = Enum.QuestTagType.Threat,
	BAG_ITEM_QUALITY_COLORS = BAG_ITEM_QUALITY_COLORS,
	ITEM_SPELL_TRIGGER_ONUSE = ITEM_SPELL_TRIGGER_ONUSE,
	ITEM_BIND_ON_EQUIP = ITEM_BIND_ON_EQUIP,
	ARTIFACT_POWER = ARTIFACT_POWER,
	AZERITE = GetCurrencyInfo(1553),
	ORDER_RESOURCES_NAME_LEGION = GetCurrencyInfo(1220),
	ORDER_RESOURCES_NAME_BFA = GetCurrencyInfo(1560),
}

	function WorldQuestList_IsShadowlandsZone(mapID)
		mapID = mapID or GetCurrentMapID()
		if mapID >= 1525 and mapID < 2022 and mapID ~= 1978 then
			return true
		else
			return false
		end
	end

	function WorldQuestList_IsDragonflightZone(mapID)
		mapID = mapID or GetCurrentMapID()
		if mapID >= 2022 or mapID == 1978 then
			return true
		else
			return false
		end
	end
	

function WorldQuestList_IsAzeriteItemAtMaxLevel()
	return C_AzeriteItem.IsAzeriteItemAtMaxLevel()
end
  
function WorldQuestList_IsFactionCurrency(currencyID)
	if list[currencyID or 0] then
		return true
		elseif C_CurrencyInfo.GetFactionGrantedByCurrency(currencyID) then
			return true
	else
		return false
	end
end  
local function HookOnEnter(self)
	self.pinFrameLevelType = "PIN_FRAME_LEVEL_TOPMOST"
	self:ApplyFrameLevel()
end
local function HookOnLeave(self)
	self.pinFrameLevelType = "PIN_FRAME_LEVEL_WORLD_QUEST"
	self:ApplyFrameLevel()
end

	local function CreateMapTextOverlay(mapFrame,pinName)
		local mapCanvas = mapFrame:GetCanvas()
		local textsFrame = CreateFrame("Frame",nil,mapCanvas)
		textsFrame:SetPoint("TOPLEFT")
		textsFrame:SetSize(1,1)
		textsFrame:SetFrameLevel(10000)
		local textsTable = {}
		textsTable.s = 1
		local prevScale = nil
		textsFrame:SetScript("OnUpdate",function(self)
			local nowScale = mapCanvas:GetScale()
			if nowScale ~= prevScale then
				local pins = mapFrame.pinPools[pinName]
				if pins then
					local scaleFactor,startScale,endScale
					for obj in mapFrame:EnumeratePinsByTemplate("WorldMap_WorldQuestPinTemplate") do
						scaleFactor = obj.scaleFactor
						startScale = obj.startScale
						endScale = obj.endScale
						break
					end
					local scale
					if startScale and startScale and endScale then
						local parentScaleFactor = 1.0 / mapFrame:GetCanvasScale()
						scale = parentScaleFactor * Lerp(startScale, endScale, Saturate(scaleFactor * mapFrame:GetCanvasZoomPercent()))
					else
						scale = 1
					end
					if scale then
						scale = scale * mapFrame:GetGlobalPinScale()
						for i=1,#textsTable do
							textsTable[i]:SetScale(scale)
						end
					end
					textsTable.s = scale or 1
				end
			end
		end)
		textsTable.f = textsFrame
		textsTable.c = mapCanvas
		return textsTable
	end
	local WorldMapFrame_TextTable = CreateMapTextOverlay(WorldMapFrame,"WorldMap_WorldQuestPinTemplate")
	local UpdateFrameLevelFunc = function(self) 
		if not self.obj:IsVisible() then
			self:Hide()
		elseif self.obj then 
			local lvl = self.obj:GetFrameLevel()
			if self.frLvl ~= lvl then
				self:SetFrameLevel(lvl)
				self.frLvl = lvl
			end
		end
	end

	local function AddText(table,obj,num,text)
		num = num + 1
		local t = table[num]
		if not t then
			t = CreateFrame("Frame",nil,table.c)
			t:SetSize(1,1)
			t.t = t:CreateFontString(nil,"OVERLAY","GameFontWhite")
			t.t:SetPoint("CENTER")
			t:SetScale(table.s)
			t:SetScript("OnUpdate",UpdateFrameLevelFunc)
			table[num] = t
		end
		  t.obj = obj:GetParent()
			t.t:SetFont(STANDARD_TEXT_FONT,12,"OUTLINE")
			t.t:SetTextColor(1,1,1,1)
		t:SetPoint("CENTER",obj,0,0)
		t.t:SetText(text)
		if not t:IsShown() then
			t:Show()
		end	
		return num
	end

function WorldQuestList_WQIcons_AddIcons(frame,pinName)
	local RewardIcons_Size = R.db["Misc"]["WorldQusetRewardIconsSize"]
		frame = frame or WorldMapFrame
		local pins = frame.pinPools[pinName or "WorldMap_WorldQuestPinTemplate"]
		if pins then
			local isWorldMapFrame = frame == WorldMapFrame
			local isRibbonDisabled = isWorldMapFrame and GENERAL_MAPS[GetCurrentMapID()]
			local tCount = 0
			local bountyMapID = frame:GetMapID() or 0
			if bountyMapID == 1014 then bountyMapID = 876 
			elseif bountyMapID == 1011 then bountyMapID = 875 end
			local bounties = C_QuestLog.GetBountiesForMapID(bountyMapID) or {}
			for _,bountyData in pairs(bounties) do
				local t = C_TaskQuest.GetQuestTimeLeftMinutes(bountyData.questID) or 0
				if t < 1440 then
					bountyData.lowTime = true
				elseif t < 2880 then
					bountyData.middleTime = true
				end
				if IsQuestComplete(bountyData.questID) or t == 0 then
					bountyData.completed = true
				end
			end
			local mapsToHighlightCallings = {}
			do
				local p = 1
				local questID = WorldQuestList_GetCallingQuests()
				while questID do
					local mapID, worldQuests, worldQuestsElite, dungeons, treasures = C_QuestLog.GetQuestAdditionalHighlights(questID)
					if mapID and mapID ~= 0 then
						local callingData = {questID = questID, mapID = mapID, worldQuests = worldQuests, worldQuestsElite = worldQuestsElite, dungeons = dungeons, treasures = treasures}

						local t = C_TaskQuest.GetQuestTimeLeftMinutes(questID) or 0
						if t < 1440 then
							callingData.lowTime = true
						elseif t < 2880 then
							callingData.middleTime = true
						end
						if IsQuestComplete(questID) or t == 0 then
							callingData.completed = true
						end

						--mapsToHighlightCallings[mapID] = callingData
						mapsToHighlightCallings[#mapsToHighlightCallings+1] = callingData
					end
					p = p + 1
					questID = select(p,WorldQuestList_GetCallingQuests())
				end
			end
			if isWorldMapFrame then
				if not WorldMapFrame_TextTable.f:IsShown() then
					WorldMapFrame_TextTable.f:Show()
				end
			end
			local warMode = C_PvP.IsWarModeDesired()
			local warModeBonus = C_PvP.GetWarModeRewardBonus() / 100 + 1
			for obj in frame:EnumeratePinsByTemplate("WorldMap_WorldQuestPinTemplate") do
				local icon = obj.WQL_rewardIcon
				--obj.BountyRing:Hide()
				if obj.questID then
					if not icon then
						icon = obj:CreateTexture(nil,"ARTWORK")
						obj.WQL_rewardIcon = icon
						icon:SetPoint("CENTER",0,0)
						icon:SetSize(RewardIcons_Size,RewardIcons_Size)
						local Border = obj:CreateTexture(nil, 'OVERLAY', nil, 1)
						Border:SetPoint('CENTER', 0, 0)
						Border:SetAtlas('worldquest-emissary-ring')
						Border:SetSize(RewardIcons_Size, RewardIcons_Size)
						obj.Border = Border
						--[[local Bounty = obj:CreateTexture(nil, 'OVERLAY', nil, 2)
						Bounty:SetSize(RewardIcons_Size, RewardIcons_Size)
						Bounty:SetAtlas('QuestNormal')
						Bounty:SetPoint('CENTER', 23, 0)
						obj.BountyRing = Bounty]]
						local iconWMask = obj:CreateTexture(nil,"ARTWORK")
						obj.WQL_rewardIconWMask = iconWMask
						iconWMask:SetPoint("CENTER",0,0)
						iconWMask:SetSize(RewardIcons_Size,RewardIcons_Size)
						iconWMask:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
						
						local ribbon = obj:CreateTexture(nil,"BACKGROUND")
						obj.WQL_rewardRibbon = ribbon
						ribbon:SetPoint("TOP",obj,"BOTTOM",0,18)
						ribbon:SetSize(RewardIcons_Size*2,RewardIcons_Size)
						--ribbon:SetAtlas("UI-Frame-Neutral-Ribbon")
						
						if not isWorldMapFrame then
							local ribbonText = obj:CreateFontString(nil,"BORDER","GameFontWhite")
							obj.WQL_rewardRibbonText = ribbonText
							local a1,a2 = ribbonText:GetFont()
							ribbonText:SetFont(a1,12)
							ribbonText:SetPoint("CENTER",ribbon,0,0)
							ribbonText:SetTextColor(0,0,0,1)
						end
						
						local iconTopRight = obj:CreateTexture(nil,"OVERLAY")
						obj.WQL_iconTopRight = iconTopRight
						iconTopRight:SetPoint("CENTER",obj,"TOPRIGHT",0,0)
						iconTopRight:SetSize(RewardIcons_Size*0.7,RewardIcons_Size*0.7)
						iconTopRight.SIZE_MOD = 0.7
						
						obj:HookScript("OnEnter",HookOnEnter)
						obj:HookScript("OnLeave",HookOnLeave)

						obj.WQL_BountyRing_defSize = obj.BountyRing and obj.BountyRing:GetSize()
					end
					local tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex, displayTimeLeft = GetQuestTagInfo(obj.questID)
					
					local iconAtlas,iconTexture,iconVirtual,iconGray = nil
					local ajustSize,ajustMask = 0
					local amount,amountIcon,amountColor = 0
					-- money
					local money = GetQuestLogRewardMoney(obj.questID)
					if money > 0 then
						iconAtlas = "Auctioneer"
						amount = floor(money / 10000 * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and warModeBonus or 1))
					end
					-- currency
					for i = 1, GetNumQuestLogRewardCurrencies(obj.questID) do
						local name, texture, numItems, currencyID = GetQuestLogRewardCurrencyInfo(i, obj.questID)
						if not numItems or numItems <= 0 then

						elseif currencyID == 1508 or currencyID == 1533 or currencyID == 1721 then	--Veiled Argunite, Wakening Essence, Prismatic Manapearl
							iconTexture = texture
							ajustMask = true
							ajustSize = 8
							amount = floor(numItems * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							if not (currencyID == 1717 or currencyID == 1716) then
								break
							end
						elseif currencyID == 1553 then	--azerite
							--iconAtlas = "Islands-AzeriteChest"
							iconAtlas = "AzeriteReady"
							amount = floor(numItems * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							ajustSize = 5
							iconTexture, ajustMask = nil
							if WorldQuestList_IsAzeriteItemAtMaxLevel() then
								iconGray = true
							end
							break
						elseif currencyID == 1220 or currencyID == 1560 then	--OR
							iconAtlas = "legionmission-icon-currency"
							ajustSize = 5
							amount = floor(numItems * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							iconTexture, ajustMask = nil
							break
						elseif currencyID == 2003 then
							iconTexture = texture
							ajustMask = true
							ajustSize = 5
							amount = floor(numItems * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							break
						elseif currencyID == 2408 or currencyID == 2245 or currencyID == 2706 or currencyID == 2815 or currencyID == 3008 then
							iconTexture = texture
							ajustMask = true
							ajustSize = 8
							amount = floor(numItems * (warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							break
						elseif WorldQuestList_IsFactionCurrency(currencyID or 0) then
							iconAtlas = "poi-workorders"
							amount = numItems
							amountIcon = texture
							ajustSize, iconTexture, ajustMask = 0
							break
						end
					end
					-- item
					if GetNumQuestLogRewards(obj.questID) > 0 then
						local name,icon,numItems,quality,_,itemID = GetQuestLogRewardInfo(1,obj.questID)
						if itemID then
							local itemLevel = select(4,C_Item.GetItemInfo(itemID)) or 0
							if itemLevel > 60 or (itemLevel > 40 and not WorldQuestList_IsShadowlandsZone(bountyMapID)) then
								iconAtlas = "Banker"
								amount = 0
								--iconAtlas = "ChallengeMode-icon-chest"
								
								local itemLink = CacheQuestItemReward[obj.questID]
								if not itemLink then
									local tooltipData = C_TooltipInfo.GetQuestLogItem("reward", 1, obj.questID)
									if tooltipData then
										itemLink = tooltipData.hyperlink
									end

									CacheQuestItemReward[obj.questID] = itemLink
								end
								if itemLink then
									itemLevel = select(4,C_Item.GetItemInfo(itemLink))
									if itemLevel then
										amount = itemLevel
										if quality and quality > 1 then
											--local colorTable = BAG_ITEM_QUALITY_COLORS[quality]
											--amountColor = format("|cff%02x%02x%02x",colorTable.r * 255,colorTable.g * 255,colorTable.b * 255)
										end
									end
								end
								local itemSubType,inventorySlot = select(3,C_Item.GetItemInfoInstant(itemID))
								if inventorySlot and SlotToIcon[inventorySlot] then
									iconAtlas = SlotToIcon[inventorySlot]
									ajustSize = iconAtlas == "Warlock-ReadyShard" and 0 or 10
								elseif itemSubType and SlotToIcon[itemSubType] then
									iconAtlas = SlotToIcon[itemSubType]
									ajustSize = iconAtlas == "Warlock-ReadyShard" and 0 or 10
								end
							end
							if itemID == 124124 or itemID == 151568 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
								if numItems then
									amount = numItems
								end
							elseif itemID == 152960 or itemID == 152957 then
								iconAtlas = "poi-workorders"
							elseif itemID == 163857 or itemID == 143559 or itemID == 141920 or itemID == 152668 or itemID == 209839 or itemID == 209837 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
								if itemID == 152668 and numItems and numItems > 1 then
									amount = numItems
								end
							elseif itemID == 169480 then
								iconAtlas = SlotToIcon.INVTYPE_CHEST
								ajustSize = 10
							elseif itemID == 169479 then
								iconAtlas = SlotToIcon.INVTYPE_HEAD
								ajustSize = 10
							elseif itemID == 169477 then
								iconAtlas = SlotToIcon.INVTYPE_WAIST
								ajustSize = 10
							elseif itemID == 169484 then
								iconAtlas = SlotToIcon.INVTYPE_SHOULDER
								ajustSize = 10
							elseif itemID == 169478 then
								iconAtlas = SlotToIcon.INVTYPE_WRIST
								ajustSize = 10
							elseif itemID == 169482 then
								iconAtlas = SlotToIcon.INVTYPE_LEGS
								ajustSize = 10
							elseif itemID == 169481 then
								iconAtlas = SlotToIcon.INVTYPE_CLOAK
								ajustSize = 10
							elseif itemID == 169483 then
								iconAtlas = SlotToIcon.INVTYPE_FEET
								ajustSize = 10
							elseif itemID == 169485 then
								iconAtlas = SlotToIcon.INVTYPE_HAND
								ajustSize = 10
							elseif itemID == 229899 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
							elseif itemID == 226264 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
							elseif itemID == 198048 or itemID == 198056 or itemID == 198058 or itemID == 198059 or itemID == 204673 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
								amount = itemID == 198048 and "I" or itemID == 198056 and "II" or itemID == 198058 and "III" or itemID == 204673 and "V" or "IV"
							elseif itemID == 228339 or itemID == 228338 then
								iconTexture = icon
								ajustMask = true
								ajustSize = 4
								amount = itemID == 228338 and "I" or itemID == 228339 and "II" or "III" 
							end
							
							if CacheIsAnimaItem[itemID] then
								iconTexture = 613397
								ajustMask = true
								ajustSize = 10
								amount = numItems * CacheIsAnimaItem[itemID]
								if warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) then
									local bonus = floor(amount * (warModeBonus - 1) + .5)
									--if CacheIsAnimaItem[itemID] <= 35 then
										bonus = bonus - bonus % 3
									--else
									--	bonus = bonus - bonus % 5
									--end
									amount = amount + bonus
								end
							elseif select(2,C_Item.GetItemInfoInstant(itemID)) == MISCELLANEOUS then
								local tooltipData = C_TooltipInfo.GetQuestLogItem("reward", 1, obj.questID)
								if tooltipData then
									local isAnima
									for j=2, #tooltipData.lines do
										local tooltipLine = tooltipData.lines[j]
										local text = tooltipLine.leftText
										if text and text:find(WORLD_QUEST_REWARD_FILTERS_ANIMA.."|r$") then
											isAnima = 1
										elseif text and isAnima and text:find("^"..LE.ITEM_SPELL_TRIGGER_ONUSE) then
											local num = text:gsub("(%d+)[ %.,]+(%d+)","%1%2"):match("%d+")
											isAnima = tonumber(num or "") or 1
											break
										end 
									end
									if isAnima then
										if isAnima ~= 1 then
											CacheIsAnimaItem[itemID] = isAnima
										end
										iconTexture = 613397
										ajustMask = true
										ajustSize = 10
										amount = numItems * isAnima
										if warMode and C_QuestLog.QuestCanHaveWarModeBonus(obj.questID) then
											local bonus = floor(amount * (warModeBonus - 1) + .5)
											--if isAnima <= 35 then
												bonus = bonus - bonus % 3
											--else
											--	bonus = bonus - bonus % 5
											--end
											amount = amount + bonus
										end
									end
								end
							end

							if worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE then
								iconVirtual = true
								amountIcon = icon
								amount = numItems
							elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_DUNGEON or worldQuestType == LE.LE_QUEST_TAG_TYPE_RAID then
								iconVirtual = true
								amountIcon = icon
								amount = itemLevel or numItems								
							end
						end
					end
					
					if worldQuestType == LE.LE_QUEST_TAG_TYPE_DUNGEON then
						iconAtlas,iconTexture = nil
					elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_RAID then
						iconAtlas,iconTexture = nil
					end
					if worldQuestType == LE.LE_QUEST_TAG_TYPE_PVP then
						if obj.WQL_iconTopRight.curr ~= "worldquest-icon-pvp-ffa" then
							obj.WQL_iconTopRight:SetSize(RewardIcons_Size+3,RewardIcons_Size+3)
							obj.WQL_iconTopRight:SetAtlas("worldquest-icon-pvp-ffa")
							obj.WQL_iconTopRight.curr = "worldquest-icon-pvp-ffa"
						end
					elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_PET_BATTLE and (iconTexture or iconAtlas) then
						if obj.WQL_iconTopRight.curr ~= "worldquest-icon-petbattle" then
							obj.WQL_iconTopRight:SetSize(RewardIcons_Size,RewardIcons_Size)
							obj.WQL_iconTopRight:SetAtlas("worldquest-icon-petbattle")
							obj.WQL_iconTopRight.curr = "worldquest-icon-petbattle"
						end
					elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_PROFESSION then
						if obj.WQL_iconTopRight.curr ~= "worldquest-icon-engineering" then
							obj.WQL_iconTopRight:SetSize(RewardIcons_Size,RewardIcons_Size)
							obj.WQL_iconTopRight:SetAtlas("worldquest-icon-engineering")
							obj.WQL_iconTopRight.curr = "worldquest-icon-engineering"
						end
					elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_INVASION then
						if obj.WQL_iconTopRight.curr ~= "worldquest-icon-burninglegion" then
							obj.WQL_iconTopRight:SetSize(RewardIcons_Size,RewardIcons_Size)
							obj.WQL_iconTopRight:SetAtlas("worldquest-icon-burninglegion")
							obj.WQL_iconTopRight.curr = "worldquest-icon-burninglegion"
						end
					elseif worldQuestType == LE.LE_QUEST_TAG_TYPE_FACTION_ASSAULT  then
						local icon = UnitFactionGroup("player") == "Alliance" and "worldquest-icon-horde" or "worldquest-icon-alliance"
						if obj.WQL_iconTopRight.curr ~= icon then
							obj.WQL_iconTopRight:SetSize(RewardIcons_Size+3,RewardIcons_Size+3)
							obj.WQL_iconTopRight:SetAtlas(icon)
							obj.WQL_iconTopRight.curr = icon
						end
					else
						if obj.WQL_iconTopRight.curr then
							obj.WQL_iconTopRight:SetSize(RewardIcons_Size,RewardIcons_Size)
							obj.WQL_iconTopRight:SetTexture()
							obj.WQL_iconTopRight.curr = nil
						end						
					end
										
					if iconTexture or iconAtlas or iconVirtual then
						if not iconVirtual then
							local res_size = (RewardIcons_Size+ajustSize) * 0.5
							icon:SetSize(res_size,res_size)
							obj.WQL_rewardIconWMask:SetSize(res_size,res_size)
							if iconTexture then
								if ajustMask then
									if obj.WQL_rewardIconWMask.curr ~= iconTexture then
										obj.WQL_rewardIconWMask:SetTexture(iconTexture)
										obj.WQL_rewardIconWMask.curr = iconTexture
									end
									if icon.curr then
										icon:SetTexture()
										icon.curr = nil
									end
								else
									if obj.WQL_rewardIconWMask.curr then
										obj.WQL_rewardIconWMask:SetTexture()
										obj.WQL_rewardIconWMask.curr = nil
									end
									if icon.curr ~= iconTexture then
										icon:SetTexture(iconTexture)
										icon.curr = iconTexture
										if iconGray then
											icon:SetDesaturated(true)
										else
											icon:SetDesaturated(false)
										end
									end
								end
							else
								if obj.WQL_rewardIconWMask.curr then
									obj.WQL_rewardIconWMask:SetTexture()
									obj.WQL_rewardIconWMask.curr = nil
								end
								if icon.curr ~= iconAtlas then
									icon:SetAtlas(iconAtlas)
									icon.curr = iconAtlas
									if iconGray then
										icon:SetDesaturated(true)
									else
										icon:SetDesaturated(false)
									end
								end
							end
							if obj.Display then
								obj.Display.Icon:SetTexture()
								obj.WQL_rewardIcon:SetParent(obj.Display.Icon:GetParent())
								obj.WQL_rewardIcon:SetDrawLayer("OVERLAY",5)
								obj.WQL_rewardIconWMask:SetParent(obj.Display.Icon:GetParent())
								obj.WQL_rewardIconWMask:SetDrawLayer("OVERLAY",5)
							end
						else
							if obj.WQL_rewardIconWMask.curr then
								obj.WQL_rewardIconWMask:SetTexture()
								obj.WQL_rewardIconWMask.curr = nil
							end
							if icon.curr then
								icon:SetTexture()
								icon.curr = nil
							end
						end
						if ((type(amount)=="number" and amount > 0) or type(amount) == "string") and not isRibbonDisabled then
							if not obj.WQL_rewardRibbon:IsShown() then obj.WQL_rewardRibbon:Show() end
								if not isWorldMapFrame then
									obj.WQL_rewardRibbonText:SetFont(STANDARD_TEXT_FONT,12,"OUTLINE")
									obj.WQL_rewardRibbonText:SetTextColor(1,1,1,1)
								end
								obj.WQL_rewardRibbon:SetAlpha(1)
							if not isWorldMapFrame then
								obj.WQL_rewardRibbonText:SetText((amountIcon and "|T"..amountIcon..":0|t" or "")..(amountColor or "")..amount)
							end
							obj.WQL_rewardRibbon:SetWidth( ((#tostring(amount) + (amountIcon and 1.5 or 0)) * RewardIcons_Size * 2) * 0.6 )

							obj.TimeLowFrame:SetPoint("CENTER",-8,-8)
							if isWorldMapFrame then
								tCount = AddText(WorldMapFrame_TextTable,obj.WQL_rewardRibbon,tCount,(amountIcon and "|T"..amountIcon..":0|t" or "")..(amountColor or "")..amount)							
							end
						elseif obj.WQL_rewardRibbon:IsShown() then
							obj.WQL_rewardRibbon:Hide()
							if not isWorldMapFrame then
								obj.WQL_rewardRibbonText:SetText("")
							end
							obj.TimeLowFrame:SetPoint("CENTER",8,-8)				
						end				
					else
						if obj.WQL_rewardIconWMask.curr then
							obj.WQL_rewardIconWMask:SetTexture()
							obj.WQL_rewardIconWMask.curr = nil
						end
						if icon.curr then
							icon:SetTexture()
							icon.curr = nil
						end
						if obj.WQL_rewardRibbon:IsShown() then
							obj.WQL_rewardRibbon:Hide()
							if not isWorldMapFrame then
								obj.WQL_rewardRibbonText:SetText("")
							end
							obj.TimeLowFrame:SetPoint("CENTER",8,-8)
						end
					end
					obj.WQL_questID = obj.questID

					if obj.BountyRing then
					obj.BountyRing:SetVertexColor(1,1,1)
					--obj.BountyRing:SetAtlas('QuestNormal')
					--obj.BountyRing:SetSize(RewardIcons_Size, RewardIcons_Size)
					--obj.BountyRing:SetPoint('CENTER', 22, 0)
					obj.BountyRing:SetSize(obj.WQL_BountyRing_defSize,obj.WQL_BountyRing_defSize)
					obj.BountyRing.WQL_color = 4
					if not RewardIcons_DisableBountyColors then
						obj.BountyRing:Hide()
						for _,bountyData in pairs(bounties) do
							if IsQuestCriteriaForBounty(obj.questID, bountyData.questID) and not bountyData.completed then
								obj.BountyRing:SetSize(RewardIcons_Size*2.5,RewardIcons_Size*2.5)
								obj.BountyRing:Show()
								if bountyData.lowTime and obj.BountyRing.WQL_color > 1 then
									obj.BountyRing:SetVertexColor(1,0,0)
									obj.BountyRing.WQL_color = 1
								elseif bountyData.middleTime and obj.BountyRing.WQL_color > 2 then
									obj.BountyRing:SetVertexColor(1,.5,0)
									obj.BountyRing.WQL_color = 2
								elseif not bountyData.lowTime and not bountyData.middleTime and obj.BountyRing.WQL_color > 3 then
									obj.BountyRing:SetVertexColor(.3,1,.3)
									obj.BountyRing.WQL_color = 3
									end
								end
							end
							local mapID = WorldQuestList_QuestIDtoMapID[obj.questID or 0]
							if mapID then
								for i=1,#mapsToHighlightCallings do
									local callingData = mapsToHighlightCallings[i]
									if callingData and callingData.mapID == mapID and (callingData.worldQuests or (callingData.worldQuestsElite and isElite)) and not callingData.completed then
										obj.BountyRing:SetSize(RewardIcons_Size*2.5,RewardIcons_Size*2.5)
										obj.BountyRing:Show()
										if callingData.lowTime and obj.BountyRing.WQL_color > 1 then
											obj.BountyRing:SetVertexColor(1,0,0)
											obj.BountyRing.WQL_color = 1
										elseif callingData.middleTime and obj.BountyRing.WQL_color > 2 then
											obj.BountyRing:SetVertexColor(1,.5,0)
											obj.BountyRing.WQL_color = 2
										elseif not callingData.lowTime and not callingData.middleTime and obj.BountyRing.WQL_color > 3 then
											obj.BountyRing:SetVertexColor(.3,1,.3)
											obj.BountyRing.WQL_color = 3
										end
								end
							end
						end
					end
			end
				else
				if obj.WQL_rewardIcon then
					if obj.WQL_rewardIconWMask.curr then
						obj.WQL_rewardIconWMask:SetTexture()
						obj.WQL_rewardIconWMask.curr = nil
					end
					if obj.WQL_rewardIcon.curr then
						obj.WQL_rewardIcon:SetTexture()
						obj.WQL_rewardIcon.curr = nil
					end
					if obj.WQL_iconTopRight.curr then
						obj.WQL_iconTopRight:SetTexture()
						obj.WQL_iconTopRight.curr = nil
					end
					obj.WQL_rewardRibbon:Hide()
					if not isWorldMapFrame then
						obj.WQL_rewardRibbonText:SetText("")
					end
					obj.TimeLowFrame:SetPoint("CENTER",8,-8)
						if obj.BountyRing then
					obj.BountyRing:SetSize(obj.WQL_BountyRing_defSize,obj.WQL_BountyRing_defSize)
					obj.BountyRing:SetVertexColor(1,1,1)
					end
					--obj.BountyRing:SetAtlas('QuestNormal')
					--obj.BountyRing:SetSize(RewardIcons_Size, RewardIcons_Size)
					--obj.BountyRing:SetPoint('CENTER', 23, 0)
				end
				obj.WQL_questID = nil
				end
			end
			if isWorldMapFrame then
				for i=tCount+1,#WorldMapFrame_TextTable do
					WorldMapFrame_TextTable[i]:Hide()
				end
			end

		elseif frame == WorldMapFrame then
			for i=1,#WorldMapFrame_TextTable do
				WorldMapFrame_TextTable[i]:Hide()
			end
		end

		WorldQuestList_WQUpdateWMIcons(frame)
	end

function WorldQuestList_WQUpdateWMIcons(frame)
		frame = frame or WorldMapFrame
		local isEnabled = false
		if frame.EnumeratePinsByTemplate then
			local currNum, questsNum = 0
			if isEnabled then
				for i = 1, C_QuestLog.GetNumQuestLogEntries() do
					local info = C_QuestLog.GetInfo(i)
					if info.questID and not C_QuestLog.IsComplete(info.questID) and not info.isHeader then
						if not questsNum then
							questsNum = {}
						end
						currNum = currNum + 1
						questsNum[info.questID] = currNum
					end
				end
			end
			for obj in frame:EnumeratePinsByTemplate("QuestPinTemplate") do
				if not obj.Display then

				elseif questsNum and questsNum[obj.questID] then
					--obj.Display.Icon:SetTexture()
					obj.Display.Icon:SetAlpha(0)
					if not obj.Display.WQL_Text then
						obj.Display.WQL_Text = obj:CreateFontString(nil,"OVERLAY","GameFontNormal")
						local a1,a2 = obj.Display.WQL_Text:GetFont()
						obj.Display.WQL_Text:SetFont(a1,12,"OUTLINE")
						obj.Display.WQL_Text:SetPoint("CENTER",0,0)
					end
					obj.Display.WQL_Text:SetText(questsNum[obj.questID])
					obj.Display.WQL_Text:Show()
				elseif obj.Display.WQL_Text then
					obj.Display.Icon:SetAlpha(1)
					obj.Display.WQL_Text:Hide()
				end
			end
			for obj in QuestScrollFrame.Contents.buttonPool:EnumerateActive() do
				if not obj.Display then

				elseif obj.questID and questsNum and questsNum[obj.questID] then
					--obj.Display.Icon:SetTexture()
					obj.Display.Icon:SetAlpha(0)
					if not obj.Display.WQL_Text then
						obj.Display.WQL_Text = obj:CreateFontString(nil,"OVERLAY","GameFontNormal")
						local a1,a2 = obj.Display.WQL_Text:GetFont()
						obj.Display.WQL_Text:SetFont(a1,12,"OUTLINE")
						obj.Display.WQL_Text:SetPoint("CENTER",0,0)
					end
					obj.Display.WQL_Text:SetText(questsNum[obj.questID])
					obj.Display.WQL_Text:Show()
				elseif obj.Display and obj.Display.WQL_Text then
					obj.Display.Icon:SetAlpha(1)
					obj.Display.WQL_Text:Hide()
				end
			end
		end
end


WorldMapFrame:RegisterCallback("WorldQuestsUpdate", function()
	WorldQuestList_WQIcons_AddIcons()
end)

local WQIcons_FlightMapLoad = CreateFrame("Frame")
WQIcons_FlightMapLoad:RegisterEvent("ADDON_LOADED")
WQIcons_FlightMapLoad:SetScript("OnEvent",function (self, event, arg)
	if arg == "Blizzard_FlightMap" then
		self:UnregisterAllEvents()
		FlightMapFrame:RegisterCallback("WorldQuestsUpdate", function()
			WorldQuestList_WQIcons_AddIcons(FlightMapFrame,"FlightMap_WorldQuestPinTemplate")
		end, self)
	end
end)


--[[ Icons size on map
local defScaleFactor, defStartScale, defEndScale = 1, 1, 1
if WorldMap_WorldQuestPinMixin then
	local f = CreateFrame("Frame")
	f.SetScalingLimits = function(_,scaleFactor, startScale, endScale) 
		defScaleFactor = scaleFactor or defScaleFactor
		defStartScale = startScale or defStartScale
		defEndScale = endScale or defEndScale
	end
	pcall(function() WorldMap_WorldQuestPinMixin.OnLoad(f) end)
end

function WorldQuestList_WQIcons_UpdateScale()
	local pins = WorldMapFrame.pinPools["WorldMap_WorldQuestPinTemplate"]
	if pins then
		local startScale, endScale = defStartScale, defEndScale
		local generalMap = GENERAL_MAPS[GetCurrentMapID()]
		local scaleFactor = 1
		if not generalMap then
			startScale, endScale = defStartScale, defEndScale
		elseif generalMap == 2 then
			--startScale, endScale = 0.15, 0.2
			startScale, endScale = .8, .8
			scaleFactor = scaleFactor * (WorldMapFrame:IsMaximized() and 1.25 or 1)
		elseif generalMap == 4 then
			startScale, endScale = .8, .8
			--startScale, endScale = 0.3, 0.425
			scaleFactor = scaleFactor * (WorldMapFrame:IsMaximized() and 1.25 or 1)
		else
			--startScale, endScale = 0.35, 0.425
			startScale, endScale = 1, 1
			scaleFactor = scaleFactor * (WorldMapFrame:IsMaximized() and 1.25 or 1)
		end
		startScale, endScale = startScale * scaleFactor, endScale * scaleFactor
	
		for obj in WorldMapFrame:EnumeratePinsByTemplate("WorldMap_WorldQuestPinTemplate") do
			--scaleFactor, startScale, endScale
			if obj.startScale ~= startScale or obj.endScale ~= endScale then
				obj:SetScalingLimits(1, startScale, endScale)
				if obj:GetMap() and obj:GetMap().ScrollContainer.zoomLevels then	--fix unk error in 8.3
					obj:ApplyCurrentScale()
				end
			end
		end
	end
end

WorldMapFrame:RegisterCallback("WorldQuestsUpdate", function()
	WorldQuestList_WQIcons_UpdateScale()
end)]]