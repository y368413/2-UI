local RewardIcons_DisableBountyColors = false
local RewardIcons_Size = 36

local GetCurrentMapID, tonumber, C_TaskQuest, tinsert, abs, time, HaveQuestData, QuestUtils_IsQuestWorldQuest, bit, format, floor, pairs = 
      function() return WorldMapFrame:GetMapID() or 0 end, tonumber, C_TaskQuest, tinsert, abs, time, HaveQuestData, QuestUtils_IsQuestWorldQuest, bit, format, floor, pairs
local IsQuestComplete, IsQuestCriteriaForBounty = C_QuestLog.IsComplete, C_QuestLog.IsQuestCriteriaForBounty

local function GetCurrencyInfo(id)
	local data = C_CurrencyInfo.GetCurrencyInfo(id)
	return data.name, nil, data.iconFileID
end

local function GetQuestTagInfo(id)
	local data = C_QuestLog.GetQuestTagInfo(id)
	return data.tagID, data.tagName, data.worldQuestType, data.quality, data.isElite, data.tradeskillLineID, data.displayExpiration
end

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
	[select(3,GetItemInfoInstant(141265))] = "Warlock-ReadyShard",
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
		if mapID >= 1525 then
			return true
		else
			return false
		end
	end
	
local inspectScantip = CreateFrame("GameTooltip", "WorldmapRewardIconWorldQuestListInspectScanningTooltip", nil, "GameTooltipTemplate")
      inspectScantip:SetOwner(UIParent, "ANCHOR_NONE")
  
function WorldQuestList_IsFactionCurrency(currencyID)
	if list[currencyID or 0] then
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
					for obj,_ in pairs(pins.activeObjects) do
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
			t.t:SetFont(STANDARD_TEXT_FONT,23,"OUTLINE")
			t.t:SetTextColor(1,1,1,1)
		t:SetPoint("CENTER",obj,0,0)
		t.t:SetText(text)
		if not t:IsShown() then
			t:Show()
		end	
		return num
	end


function WorldQuestList_WQIcons_AddIcons(frame,pinName)
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
				if IsQuestComplete(bountyData.questID) then
					bountyData.completed = true
				end
			end
			local mapsToHighlightCallings = {}
			do
				local p = 1
				local questID = WorldQuestList_GetCallingQuests()
				while questID do
					local mapID = C_QuestLog.GetQuestAdditionalHighlights(questID)
					if mapID and mapID ~= 0 then
						local callingData = {questID = questID}

						local t = C_TaskQuest.GetQuestTimeLeftMinutes(questID) or 0
						if t < 1440 then
							callingData.lowTime = true
						elseif t < 2880 then
							callingData.middleTime = true
						end
						if IsQuestComplete(questID) then
							callingData.completed = true
						end

						mapsToHighlightCallings[mapID] = callingData
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
			for obj,_ in pairs(pins.activeObjects) do
				local icon = obj.WQL_rewardIcon
				obj.BountyRing:Hide()
				if obj.questID then
					if not icon then
						icon = obj:CreateTexture(nil,"ARTWORK")
						obj.WQL_rewardIcon = icon
						icon:SetPoint("CENTER",0,0)
						icon:SetSize(RewardIcons_Size,RewardIcons_Size)
						local Border = obj:CreateTexture(nil, 'OVERLAY', nil, 1)
						Border:SetPoint('CENTER', 0, -3)
						Border:SetAtlas('worldquest-emissary-ring')
						Border:SetSize(RewardIcons_Size+32, RewardIcons_Size+32)
						obj.Border = Border
						local Bounty = obj:CreateTexture(nil, 'OVERLAY', nil, 2)
						Bounty:SetSize(RewardIcons_Size, RewardIcons_Size)
						Bounty:SetAtlas('QuestNormal')
						Bounty:SetPoint('CENTER', 23, 0)
						obj.BountyRing = Bounty
						local iconWMask = obj:CreateTexture(nil,"ARTWORK")
						iconWMask:SetPoint("CENTER",0,0)
						iconWMask:SetSize(RewardIcons_Size,RewardIcons_Size)
						iconWMask:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
						obj.WQL_rewardIconWMask = iconWMask
						
						local ribbon = obj:CreateTexture(nil,"BACKGROUND")
						obj.WQL_rewardRibbon = ribbon
						ribbon:SetPoint("TOP",obj,"BOTTOM",3,21)
						ribbon:SetSize(RewardIcons_Size+21,RewardIcons_Size)
						--ribbon:SetAtlas("UI-Frame-Neutral-Ribbon")
						
						if not isWorldMapFrame then
							local ribbonText = obj:CreateFontString(nil,"BORDER","GameFontWhite")
							obj.WQL_rewardRibbonText = ribbonText
							ribbonText:SetFont(ribbonText:GetFont(),23)
							ribbonText:SetPoint("CENTER",ribbon,0,-1)
							ribbonText:SetTextColor(0,0,0,1)
						end
						
						local Indicator = CreateFrame('Frame', nil, obj):CreateTexture(nil, 'OVERLAY', nil, 2)
						Indicator:SetPoint('CENTER', obj, -19, 19)
						Indicator:SetSize(RewardIcons_Size,RewardIcons_Size)
						obj.WQL_iconTopRight = Indicator
						
						obj:HookScript("OnEnter",HookOnEnter)
						obj:HookScript("OnLeave",HookOnLeave)

						--obj.WQL_BountyRing_defSize = obj.BountyRing:GetSize()
					end
					local tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex, displayTimeLeft = GetQuestTagInfo(obj.questID)
					
					local iconAtlas,iconTexture,iconVirtual,iconGray = nil
					local ajustSize,ajustMask = 0
					local amount,amountIcon,amountColor = 0
					-- money
					local money = GetQuestLogRewardMoney(obj.questID)
					if money > 0 then
						iconAtlas = "Auctioneer"
						amount = floor(money / 10000 * (warMode and C_QuestLog.QuestHasWarModeBonus(obj.questID) and warModeBonus or 1))
					end
					-- currency
					for i = 1, GetNumQuestLogRewardCurrencies(obj.questID) do
						local name, texture, numItems, currencyID = GetQuestLogRewardCurrencyInfo(i, obj.questID)
						if currencyID == 1508 or currencyID == 1533 or currencyID == 1721 then	--Veiled Argunite, Wakening Essence, Prismatic Manapearl
							iconTexture = texture
							ajustMask = true
							ajustSize = 8
							amount = floor(numItems * (warMode and C_QuestLog.QuestHasWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							if not (currencyID == 1717 or currencyID == 1716) then
								break
							end
						elseif currencyID == 1553 then	--azerite
							--iconAtlas = "Islands-AzeriteChest"
							iconAtlas = "AzeriteReady"
							amount = floor(numItems * (warMode and C_QuestLog.QuestHasWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							ajustSize = 5
							iconTexture, ajustMask = nil
							--if WorldQuestList_IsAzeriteItemAtMaxLevel() then
								--iconGray = true
							--end
							break
						elseif currencyID == 1220 or currencyID == 1560 then	--OR
							iconAtlas = "legionmission-icon-currency"
							ajustSize = 5
							amount = floor(numItems * (warMode and C_QuestLog.QuestHasWarModeBonus(obj.questID) and C_CurrencyInfo.DoesWarModeBonusApply(currencyID) and warModeBonus or 1))
							iconTexture, ajustMask = nil
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
							local itemLevel = select(4,GetItemInfo(itemID)) or 0
							if itemLevel > 60 or (itemLevel > 40 and not WorldQuestList_IsShadowlandsZone(bountyMapID)) then
								iconAtlas = "Banker"
								amount = 0
								--iconAtlas = "ChallengeMode-icon-chest"
								
								local itemLink = CacheQuestItemReward[obj.questID]
								if not itemLink then
									inspectScantip:SetQuestLogItem("reward", 1, obj.questID)
									itemLink = select(2,inspectScantip:GetItem())
									inspectScantip:ClearLines()
									
									CacheQuestItemReward[obj.questID] = itemLink
								end
								if itemLink then
									itemLevel = select(4,GetItemInfo(itemLink))
									if itemLevel then
										amount = itemLevel
										if quality and quality > 1 then
											--local colorTable = BAG_ITEM_QUALITY_COLORS[quality]
											--amountColor = format("|cff%02x%02x%02x",colorTable.r * 255,colorTable.g * 255,colorTable.b * 255)
										end
									end
								end
								local itemSubType,inventorySlot = select(3,GetItemInfoInstant(itemID))
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
							elseif itemID == 163857 or itemID == 143559 or itemID == 141920 or itemID == 152668 then
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
							end
							
							if CacheIsAnimaItem[itemID] then
								iconTexture = 613397
								ajustMask = true
								ajustSize = 10
								amount = numItems * CacheIsAnimaItem[itemID]
							elseif select(2,GetItemInfoInstant(itemID)) == MISCELLANEOUS then
								inspectScantip:SetQuestLogItem("reward", 1, obj.questID)
								local isAnima
								for j=2, inspectScantip:NumLines() do
									local tooltipLine = _G["WorldmapRewardIconWorldQuestListInspectScanningTooltipTextLeft"..j]								                       	
									local text = tooltipLine:GetText()
									if text and text:find(ANIMA.."|r$") then
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
								end
								inspectScantip:ClearLines()
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
							icon:SetSize(RewardIcons_Size+ajustSize,RewardIcons_Size+ajustSize)
							obj.WQL_rewardIconWMask:SetSize(RewardIcons_Size+ajustSize,RewardIcons_Size+ajustSize)
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
							obj.Texture:SetTexture()
						end
						if amount > 0 and not isRibbonDisabled then
							if not obj.WQL_rewardRibbon:IsShown() then obj.WQL_rewardRibbon:Show() end
								if not isWorldMapFrame then
									obj.WQL_rewardRibbonText:SetFont(STANDARD_TEXT_FONT,23,"OUTLINE")
									obj.WQL_rewardRibbonText:SetTextColor(1,1,1,1)
								end
								obj.WQL_rewardRibbon:SetAlpha(1)
							if not isWorldMapFrame then
								obj.WQL_rewardRibbonText:SetText((amountIcon and "|T"..amountIcon..":0|t" or "")..(amountColor or "")..amount)
							end
							obj.WQL_rewardRibbon:SetWidth( (#tostring(amount) + (amountIcon and 1.5 or 0)) * 21 + RewardIcons_Size )
							obj.TimeLowFrame:SetPoint("CENTER",-21,-8)
							if isWorldMapFrame then
								tCount = AddText(WorldMapFrame_TextTable,obj.WQL_rewardRibbon,tCount,(amountIcon and "|T"..amountIcon..":0|t" or "")..(amountColor or "")..amount)							
							end
						elseif obj.WQL_rewardRibbon:IsShown() then obj.WQL_rewardRibbon:Hide()
							obj.TimeLowFrame:SetPoint("CENTER",-16,-16)				
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
							obj.TimeLowFrame:SetPoint("CENTER",-16,-16)
						end
					end
					obj.WQL_questID = obj.questID

					obj.BountyRing:SetVertexColor(1,1,1)
					obj.BountyRing:SetAtlas('QuestNormal')
					obj.BountyRing:SetSize(RewardIcons_Size, RewardIcons_Size)
					obj.BountyRing:SetPoint('CENTER', 22, 0)
					--obj.BountyRing:SetSize(obj.WQL_BountyRing_defSize,obj.WQL_BountyRing_defSize)
					obj.BountyRing.WQL_color = 4
					if not RewardIcons_DisableBountyColors then
						obj.BountyRing:Hide()
						for _,bountyData in pairs(bounties) do
							if IsQuestCriteriaForBounty(obj.questID, bountyData.questID) and not bountyData.completed then
								obj.BountyRing:SetSize(RewardIcons_Size+8,RewardIcons_Size+8)
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
					end
				end
			end
			if isWorldMapFrame then
				for i=tCount+1,#WorldMapFrame_TextTable do
					WorldMapFrame_TextTable[i]:Hide()
				end
			end
			for _,obj in pairs(pins.inactiveObjects) do
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
					obj.TimeLowFrame:SetPoint("CENTER",-16,-16)
					--obj.BountyRing:SetSize(obj.WQL_BountyRing_defSize,obj.WQL_BountyRing_defSize)
					obj.BountyRing:SetVertexColor(1,1,1)
					obj.BountyRing:SetAtlas('QuestNormal')
					obj.BountyRing:SetSize(RewardIcons_Size, RewardIcons_Size)
					obj.BountyRing:SetPoint('CENTER', 23, 0)
				end
				obj.WQL_questID = nil
			end
		elseif frame == WorldMapFrame then
			for i=1,#WorldMapFrame_TextTable do
				WorldMapFrame_TextTable[i]:Hide()
			end
		end
	end

WorldMapFrame:RegisterCallback("WorldQuestsUpdate", function()
	WorldQuestList_WQIcons_AddIcons()
end, WorldMapFrame)
local WQIcons_FlightMapLoad = CreateFrame("Frame")
WQIcons_FlightMapLoad:RegisterEvent("ADDON_LOADED")
WQIcons_FlightMapLoad:SetScript("OnEvent",function (self, event, arg)
	if arg == "Blizzard_FlightMap" then
		self:UnregisterAllEvents()
		FlightMapFrame:RegisterCallback("WorldQuestsUpdate", function() WorldQuestList_WQIcons_AddIcons(FlightMapFrame,"FlightMap_WorldQuestPinTemplate") end, self)
	end
end)


--- Icons size on map

local defScaleFactor, defStartScale, defEndScale = 1, 0.425, 0.425
if WorldMap_WorldQuestPinMixin then
	local f = CreateFrame("Frame")
	f.SetScalingLimits = function(_,scaleFactor, startScale, endScale) 
		defScaleFactor = scaleFactor or defScaleFactor
		defStartScale = startScale or defStartScale
		defEndScale = endScale or defEndScale
	end
	pcall(function() WorldMap_WorldQuestPinMixin.OnLoad(f) end)
end

--[[function WorldQuestList_WQIcons_UpdateScale()
	local pins = WorldMapFrame.pinPools["WorldMap_WorldQuestPinTemplate"]
	if pins then
		local startScale, endScale = defStartScale, defEndScale
		local generalMap = GENERAL_MAPS[GetCurrentMapID()]
		local scaleFactor = 1
		if not generalMap then
			startScale, endScale = defStartScale, defEndScale
		elseif generalMap == 2 then
			startScale, endScale = 0.15, 0.2
			scaleFactor = scaleFactor * (WorldMapFrame:IsMaximized() and 1.25 or 1)
		elseif generalMap == 4 then
			startScale, endScale = 0.3, 0.425
			scaleFactor = scaleFactor * (WorldMapFrame:IsMaximized() and 1.25 or 1)
		else
			startScale, endScale = 0.35, 0.425
			scaleFactor = scaleFactor * (WorldMapFrame:IsMaximized() and 1.25 or 1)
		end
		startScale, endScale = startScale * scaleFactor, endScale * scaleFactor
	
		for obj,_ in pairs(pins.activeObjects) do
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
end, WorldMapFrame)]]
---------------------------------------------------------------------------------------------------------	WorldMapQuestBountyCount Thanks WorldQuestTab
WorldMapQuestBountyCount = {}
function WorldMapQuestBountyCount:OnLoad()
    self.bountyCounterPool = CreateFramePool("FRAME", self, "BountyCounterTemplate");
    
	-- Auto emisarry when clicking on one of the buttons
	local bountyBoard = WorldMapFrame.overlayFrames[4];
	self.bountyBoard = bountyBoard;
	
	hooksecurefunc(bountyBoard, "OnTabClick", function(self, tab) 
		if (not MaoRUIPerDB["Misc"]["WorldQusetRewardIcons"] or tab.isEmpty) then return; end
		WRWorldQuestFrame.autoEmisarryId = bountyBoard.bounties[tab.bountyIndex];
	end, self)
	
	hooksecurefunc(bountyBoard, "RefreshSelectedBounty", function() 
		if (MaoRUIPerDB["Misc"]["WorldQusetRewardIcons"]) then
			self:UpdateBountyCounters();
		end
	end)
		
	-- Slight offset the tabs to make room for the counters
	hooksecurefunc(bountyBoard, "AnchorBountyTab", function(self, tab) 
		if (not MaoRUIPerDB["Misc"]["WorldQusetRewardIcons"]) then return end
		local point, relativeTo, relativePoint, x, y = tab:GetPoint(1);
		tab:SetPoint(point, relativeTo, relativePoint, x, y + 2);
	end)
end
		
function WorldMapQuestBountyCount:UpdateBountyCounters()
	self.bountyCounterPool:ReleaseAll();
	if (not MaoRUIPerDB["Misc"]["WorldQusetRewardIcons"]) then return end
	if (not self.bountyInfo) then
		self.bountyInfo = {};
	end
	for tab, v in pairs(self.bountyBoard.bountyTabPool.activeObjects) do
		self:AddBountyCountersToTab(tab);
	end
end

function WorldMapQuestBountyCount:RepositionBountyTabs()
	for tab, v in pairs(self.bountyBoard.bountyTabPool.activeObjects) do
		self.bountyBoard:AnchorBountyTab(tab);
	end
end

function WorldMapQuestBountyCount:AddBountyCountersToTab(tab)
	local bountyData = self.bountyBoard.bounties[tab.bountyIndex];
	
	if (bountyData) then
		local progress, goal = self.bountyBoard:CalculateBountySubObjectives(bountyData);
		if (progress == goal) then return end;
		
		-- Counters
		local offsetAngle = 32;
		local startAngle = 270;
		
		-- position of first counter
		startAngle = startAngle - offsetAngle * (goal -1) /2
		
		for i=1, goal do
			local counter = self.bountyCounterPool:Acquire();

			local x = cos(startAngle) * 16;
			local y = sin(startAngle) * 16;
			counter:SetPoint("CENTER", tab.Icon, "CENTER", x, y);
			counter:SetParent(tab);
			counter:Show();
			
			-- Light nr of completed
			if i <= progress then
				counter.icon:SetTexCoord(0, 0.5, 0, 0.5);
				counter.icon:SetVertexColor(1, 1, 1, 1);
				counter.icon:SetDesaturated(false);
			else
				counter.icon:SetTexCoord(0, 0.5, 0, 0.5);
				counter.icon:SetVertexColor(0.75, 0.75, 0.75, 1);
				counter.icon:SetDesaturated(true);
			end

			-- Offset next counter
			startAngle = startAngle + offsetAngle;
		end
	end
end
--QuestMapFrame:HookScript("OnLoad", function() WorldMapQuestBountyCount:OnLoad() end)