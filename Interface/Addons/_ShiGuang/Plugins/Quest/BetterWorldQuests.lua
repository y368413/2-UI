local parentMaps = {
	-- list of all continents and their sub-zones that have world quests
	[1550] = { -- Shadowlands
		[1525] = true, -- Revendreth
		[1533] = true, -- Bastion
		[1536] = true, -- Maldraxxus
		[1565] = true, -- Ardenwald
	},
	[619] = { -- Broken Isles
		[630] = true, -- Azsuna
		[641] = true, -- Val'sharah
		[650] = true, -- Highmountain
		[634] = true, -- Stormheim
		[680] = true, -- Suramar
		[627] = true, -- Dalaran
		[790] = true, -- Eye of Azshara (world version)
		[646] = true, -- Broken Shore
	},
	[994] = { -- Argus (our modified one, the original ID is 905)
		[830] = true, -- Krokuun
		[885] = true, -- Antoran Wastes
		[882] = true, -- Mac'Aree
	},
	[875] = { -- Zandalar
		[862] = true, -- Zuldazar
		[864] = true, -- Vol'Dun
		[863] = true, -- Nazmir
	},
	[876] = { -- Kul Tiras
		[895] = true, -- Tiragarde Sound
		[896] = true, -- Drustvar
		[942] = true, -- Stormsong Valley
	},
	[13] = { -- Eastern Kingdoms
		[14] = true, -- Arathi Highlands (Warfronts)
	},
	[12] = { -- Kalimdor
		[62] = true, -- Darkshore (Warfronts)
	},
}
local factionAssaultAtlasName = UnitFactionGroup('player') == 'Horde' and 'worldquest-icon-horde' or 'worldquest-icon-alliance'

local function AdjustedMapID(mapID)
	-- this will replace the Argus map ID with the one used by the taxi UI, since one of the
	-- features of this addon is replacing the Argus map art with the taxi UI one
	return mapID == 905 and 994 or mapID
end

-- create a new data provider that will display the world quests on zones from the list above,
-- based on WorldQuestDataProviderMixin
local DataProvider = CreateFromMixins(WorldQuestDataProviderMixin)
DataProvider:SetMatchWorldMapFilters(true)
DataProvider:SetUsesSpellEffect(true)
DataProvider:SetCheckBounties(true)
DataProvider:SetMarkActiveQuests(true)

function DataProvider:GetPinTemplate()
	-- we use our own copy of the WorldMap_WorldQuestPinTemplate template to avoid interference
	return 'BetterWorldQuestPinTemplate'
end

function DataProvider:ShouldShowQuest(questInfo)
	local questID = questInfo.questId
	if(self.focusedQuestID or self:IsQuestSuppressed(questID)) then
		return false
	else
		-- returns true if the given quest is a world quest on one of the maps in our list
		local mapID = AdjustedMapID(self:GetMap():GetMapID())
		local questMapID = questInfo.mapID
		if(mapID == questMapID or (parentMaps[mapID] and parentMaps[mapID][questMapID])) then
			return HaveQuestData(questID) and QuestUtils_IsQuestWorldQuest(questID)
		end
	end
end

function DataProvider:RefreshAllData()
	-- map is updated, draw world quest pins
	local pinsToRemove = {}
	for questID in next, self.activePins do
		-- mark all pins for removal
		pinsToRemove[questID] = true
	end

	local Map = self:GetMap()
	local mapID = AdjustedMapID(Map:GetMapID())

	local quests = mapID and C_TaskQuest.GetQuestsForPlayerByMapID(mapID)
	if(quests) then
		for _, questInfo in next, quests do
			if(self:ShouldShowQuest(questInfo) and self:DoesWorldQuestInfoPassFilters(questInfo)) then
				local questID = questInfo.questId
				pinsToRemove[questID] = nil -- unmark the pin for removal

				local Pin = self.activePins[questID]
				if(Pin) then
					-- update existing pin
					Pin:RefreshVisuals()
					Pin:SetPosition(questInfo.x, questInfo.y)

					if(self.pingPin and self.pingPin:IsAttachedToQuest(questID)) then
						self.pingPin:SetScalingLimits(1, 1, 1)
						self.pingPin:SetPosition(questInfo.x, questInfo.y)
					end
				else
					-- create a new pin
					self.activePins[questID] = self:AddWorldQuest(questInfo)
				end
			end
		end
	end

	for questID in next, pinsToRemove do
		-- iterate and remove all pins marked for removal
		if(self.pingPin and self.pingPin:IsAttachedToQuest(questID)) then
			self.pingPin:Stop()
		end

		Map:RemovePin(self.activePins[questID])
		self.activePins[questID] = nil
	end

	-- trigger callbacks like WorldQuestDataProviderMixin.RefreshAllData does
	Map:TriggerEvent('WorldQuestUpdate', Map:GetNumActivePinsByTemplate(self:GetPinTemplate()))
end

WorldMapFrame:AddDataProvider(DataProvider)

BetterWorldQuestPinMixin = CreateFromMixins(WorldMap_WorldQuestPinMixin)
function BetterWorldQuestPinMixin:OnLoad()
	WorldQuestPinMixin.OnLoad(self)

	-- create any extra widgets we need if they don't already exist
	local Border = self:CreateTexture(nil, 'OVERLAY', nil, 1)
	Border:SetPoint('CENTER', 0, -3)
	Border:SetAtlas('worldquest-emissary-ring')
	Border:SetSize(72, 72)
	self.Border = Border

	-- create the indicator on a subframe so highlights don't overlap
	local Indicator = CreateFrame('Frame', nil, self):CreateTexture(nil, 'OVERLAY', nil, 2)
	Indicator:SetPoint('CENTER', self, -19, 19)
	Indicator:SetSize(44, 44)
	self.Indicator = Indicator

	local Bounty = self:CreateTexture(nil, 'OVERLAY', nil, 2)
	Bounty:SetSize(44, 44)
	Bounty:SetAtlas('QuestNormal')
	Bounty:SetPoint('CENTER', 22, 0)
	self.Bounty = Bounty

	-- make sure the tracked check mark doesn't appear underneath any of our widgets
	self.TrackedCheck:SetDrawLayer('OVERLAY', 3)
end

local function IsParentMap(mapID)
	return not not parentMaps[AdjustedMapID(mapID)]
end

function BetterWorldQuestPinMixin:RefreshVisuals()
	WorldMap_WorldQuestPinMixin.RefreshVisuals(self)

	-- update scale
	if(IsParentMap(self:GetMap():GetMapID())) then
		self:SetScalingLimits(1, 0.3, 0.5)
	else
		self:SetScalingLimits(1, 0.425, 0.425)
	end

	-- hide frames we don't want to use
	self.BountyRing:Hide()

	-- set texture to the item/currency/value it rewards
	local questID = self.questID
	if(GetNumQuestLogRewards(questID) > 0) then
		local _, texture, _, quality = GetQuestLogRewardInfo(1, questID)
		SetPortraitToTexture(self.Texture, texture)
		self.Texture:SetSize(self:GetSize())
	elseif(GetNumQuestLogRewardCurrencies(questID) > 0) then
		local _, texture = GetQuestLogRewardCurrencyInfo(1, questID)
		SetPortraitToTexture(self.Texture, texture)
		self.Texture:SetSize(self:GetSize())
	elseif(GetQuestLogRewardMoney(questID) > 0) then
		SetPortraitToTexture(self.Texture, [[Interface\Icons\inv_misc_coin_01]])
		self.Texture:SetSize(self:GetSize())
	end

	-- update our own widgets
	local bountyQuestID = self.dataProvider:GetBountyQuestID()
		self.Bounty:SetShown(bountyQuestID and C_QuestLog.IsQuestCriteriaForBounty(questID, bountyQuestID))

	local Indicator = self.Indicator
	local _, worldQuestType, professionID
		_, _, worldQuestType, _, _, professionID = C_QuestLog.GetQuestTagInfo(questID)

	if(worldQuestType == LE_QUEST_TAG_TYPE_PVP) then
		self.Indicator:SetAtlas('Warfronts-BaseMapIcons-Empty-Barracks-Minimap')
		self.Indicator:SetSize(58, 58)
		self.Indicator:Show()
	else
		self.Indicator:SetSize(44, 44)
		if(worldQuestType == LE_QUEST_TAG_TYPE_PET_BATTLE) then
			self.Indicator:SetAtlas('WildBattlePetCapturable')
			self.Indicator:Show()
		elseif(worldQuestType == LE_QUEST_TAG_TYPE_PROFESSION) then
			self.Indicator:SetAtlas(WORLD_QUEST_ICONS_BY_PROFESSION[professionID])
			self.Indicator:Show()
		elseif(worldQuestType == LE_QUEST_TAG_TYPE_DUNGEON) then
			self.Indicator:SetAtlas('Dungeon')
			self.Indicator:Show()
		elseif(worldQuestType == LE_QUEST_TAG_TYPE_RAID) then
			self.Indicator:SetAtlas('Raid')
			self.Indicator:Show()
		elseif(worldQuestType == LE_QUEST_TAG_TYPE_INVASION) then
			self.Indicator:SetAtlas('worldquest-icon-burninglegion')
			self.Indicator:Show()
		elseif(worldQuestType == LE_QUEST_TAG_TYPE_FACTION_ASSAULT) then
			self.Indicator:SetAtlas(factionAssaultAtlasName)
			self.Indicator:SetSize(38, 38)
			self.Indicator:Show()
		else
			self.Indicator:Hide()
		end
	end
end

-- we need to remove the default data provider mixin
for provider in next, WorldMapFrame.dataProviders do
	if(provider.GetPinTemplate and provider.GetPinTemplate() == 'WorldMap_WorldQuestPinTemplate') then
		WorldMapFrame:RemoveDataProvider(provider)
	end
end


local BetterWorldQuests = {}

local function IsPointInTriangle(x, y, p)
	local b1 = ((x - p[2].x) * (p[1].y - p[2].y) - (p[1].x - p[2].x) * (y - p[2].y)) < 0
	local b2 = ((x - p[3].x) * (p[2].y - p[3].y) - (p[2].x - p[3].x) * (y - p[3].y)) < 0
	local b3 = ((x - p[1].x) * (p[3].y - p[1].y) - (p[3].x - p[1].x) * (y - p[1].y)) < 0

	return ((b1 == b2) and (b2 == b3))
end

local function GetMapData(mapID)
	-- the last two returns are approximated offsets for the highlight texture, from center
	if(mapID == 882) then
		return 'MacAree_Highlight', 0, 120, mapID
	elseif(mapID == 885) then
		return 'AntoranWastes_Highlight', -300, -200, mapID
	elseif(mapID == 830) then
		return 'Krokuun_Highlight', 350, -100, mapID
	end
end

local V = CreateVector2D
local zonePoints = {
	-- custom triangle points to make up an approximated area for each Argus sub-zone on
	-- our "custom" Argus map art
	[885] = {V(0.09, 0.99), V(0.26, 0.30), V(0.50, 0.99)}, -- Antoran Wastes
	[882] = {V(0.15, 0.01), V(0.75, 0.01), V(0.50, 0.70)}, -- Mac'Aree
	[830] = {V(0.82, 0.25), V(0.99, 0.99), V(0.50, 0.99)}, -- Krokuun
}

function BetterWorldQuests.GetZoneInfoAtPosition(cX, cY)
	for mapID, points in next, zonePoints do
		if(IsPointInTriangle(cX, cY, points)) then
			return GetMapData(mapID)
		end
	end
end

local DIFF_DESC = WORLD_MAP_WILDBATTLEPET_LEVEL .. '%s(%s-%s)' .. FONT_COLOR_CODE_CLOSE
local SAME_DESC = WORLD_MAP_WILDBATTLEPET_LEVEL .. '%s(%s)' .. FONT_COLOR_CODE_CLOSE

function BetterWorldQuests.GetZoneDescription(mapID)
	-- Argus sub-zones doesn't have player level recommendations, so just return pet battle info
	-- this is pretty much a copy-paste from AreaLabelFrameMixin.OnUpdate
	local _, _, _, _, locked = C_PetJournal.GetPetLoadOutInfo(1) -- TODO: cache
	if(not locked and GetCVarBool('showTamers')) then -- TODO: cache
		local _, _, petMinLevel, petMaxLevel = C_Map.GetMapLevels(mapID)
		if(petMinLevel and petMaxLevel and petMinLevel > 0 and petMaxLevel > 0) then
			local teamLevel = C_PetJournal.GetPetTeamAverageLevel() -- TODO: cache
			local color
			if(teamLevel) then
				if(teamLevel < petMinLevel) then
					color = GetRelativeDifficultyColor(teamLevel, petMinLevel + 2)
				elseif(teamLevel > petMaxLevel) then
					color = GetRelativeDifficultyColor(teamLevel, petMaxLevel)
				else
					color = QuestDifficultyColors.difficult
				end
			else
				color = QuestDifficultyColors.header
			end

			if(petMinLevel ~= petMaxLevel) then
				return DIFF_DESC:format(ConvertRGBtoColorString(color), petMinLevel, petMaxLevel)
			else
				return SAME_DESC:format(ConvertRGBtoColorString(color), petMaxLevel)
			end
		end
	end

	-- empty for no pet battles
	return ''
end

-- cache map data to avoid calling API every time
local zoneNames = {
	[882] = C_Map.GetMapInfo(882).name,
	[885] = C_Map.GetMapInfo(885).name,
	[830] = C_Map.GetMapInfo(830).name,
}

function BetterWorldQuests.GetZoneName(mapID)
	return zoneNames[mapID]
end


local tiles = {}
do
	-- create tiles based on map ID 994, an alternative art set for Argus used in the taxi UI,
	-- which are drawn one level above the original map canvas
	-- method is based on MapCanvasDetailLayerMixin.RefreshDetailTiles
	local textures = C_Map.GetMapArtLayerTextures(994, 1)
	local layer = C_Map.GetMapArtLayers(994)[1]
	local tileSize = 70 -- we can't use the tile size provided by GetMapArtLayers, it's too big

	for col = 1, math.ceil(layer.layerHeight / layer.tileHeight) do
		for row = 1, math.ceil(layer.layerWidth / layer.tileWidth) do
			local Tile = WorldMapFrame:GetCanvas():CreateTexture(nil, 'BACKGROUND', -7)
			Tile:SetSize(tileSize, tileSize)
			Tile:SetPoint('TOPLEFT', tileSize * (row - 1), -tileSize * (col - 1))
			Tile:SetTexture(textures[#tiles + 1], nil, nil, 'TRILINEAR')
			Tile:SetAlpha(0)

			tiles[#tiles + 1] = Tile
		end
	end
end

-- data providers are typically used for pins, but can just as well be used for anything on the map
local ArgusCanvas = CreateFromMixins(MapCanvasDataProviderMixin)
function ArgusCanvas:RefreshAllData()
	-- this method triggers when there is a map change
	local shouldShow = self:GetMap():GetMapID() == 905
	for _, Tile in next, tiles do
		Tile:SetAlpha(shouldShow and 1 or 0)
	end
end

WorldMapFrame:AddDataProvider(ArgusCanvas)


-- move the bounties so they don't overlap the sub-zones
local TOPRIGHT = LE_MAP_OVERLAY_DISPLAY_LOCATION_TOP_RIGHT
hooksecurefunc(WorldMapFrame, 'SetOverlayFrameLocation', function(Map, overlayFrame, location)
	if(Map:GetMapID() == 905 and overlayFrame.AreBountiesAvailable and location ~= TOPRIGHT) then
		Map:SetOverlayFrameLocation(overlayFrame, TOPRIGHT)
	end
end)


local GetZoneInfoAtPosition = select(2, ...).GetZoneInfoAtPosition

local function UpdateHighlight(Pin)
	-- update highlight based on custom data when hovering over a sub-zone
	local Map = Pin:GetMap()
	if(Map:GetMapID() == 905) then
		local atlas, offsetX, offsetY = GetZoneInfoAtPosition(Map:GetNormalizedCursorPosition())
		if(atlas) then
			local Texture = Pin.HighlightTexture
			Texture:ClearAllPoints()
			Texture:SetPoint('CENTER', offsetX, offsetY)
			Texture:SetAtlas(atlas)
			Texture:Show()
		else
			Pin.HighlightTexture:Hide()
		end
	end
end

for provider in next, WorldMapFrame.dataProviders do
	if(provider.pin and provider.pin:GetFrameLevelType() == 'PIN_FRAME_LEVEL_MAP_HIGHLIGHT') then
		hooksecurefunc(provider.pin, 'Refresh', UpdateHighlight)
	end
end


local GetZoneInfoAtPosition = select(2, ...).GetZoneInfoAtPosition

-- override navigation so we can use our custom sub-zone positions
function WorldMapFrame:NavigateToCursor()
	if(self:GetMapID() == 905) then
		local _, _, _, mapID = GetZoneInfoAtPosition(self:GetNormalizedCursorPosition())
		if(mapID) then
			-- for some reason the NavigateToMap method doesn't work
			self:SetMapID(mapID)
			self:RefreshDetailLayers()
		end
	else
		-- let the default handler run
		MapCanvasMixin.NavigateToCursor(self)
	end
end


-- display group members on the map
local function UpdateGroupMembers(self)
	local Map = self:GetMap()
	if(Map:GetMapID() == 905) then
		if(C_Map.GetMapDisplayInfo(994)) then
			self:Hide()
		else
			self:SetUiMapID(994)
			self:Show()

			if(self.dataProvider:ShouldShowUnit('player')) then
				self:StartPlayerPing(2, 0.25)
			end
		end
	end
end

for provider in next, WorldMapFrame.dataProviders do
	if(provider.ShouldShowUnit) then
		hooksecurefunc(provider.pin, 'OnMapChanged', UpdateGroupMembers)
	end
end


-- display Greater Invasion Points on the map
local function UpdatePOIs(self)
	local Map = self:GetMap()
	if(Map:GetMapID() == 905) then
		self:RemoveAllData()

		for _, id in next, C_AreaPoiInfo.GetAreaPOIForMap(994) do
			local info = C_AreaPoiInfo.GetAreaPOIInfo(994, id)
			if(info and info.atlasName == 'poi-rift2') then
				Map:AcquirePin(self:GetPinTemplate(), info)
			end
		end
	end
end

for provider in next, WorldMapFrame.dataProviders do
	if(provider.GetPinTemplate and provider:GetPinTemplate() == 'AreaPOIPinTemplate') then
		hooksecurefunc(provider, 'RefreshAllData', UpdatePOIs)
	end
end


local GetZoneInfoAtPosition = BetterWorldQuests.GetZoneInfoAtPosition
local GetZoneDescription = BetterWorldQuests.GetZoneDescription
local GetZoneName = BetterWorldQuests.GetZoneName

local function AreaLabelOnUpdate(self)
	local Map = self.dataProvider:GetMap()
	local mapID = Map:GetMapID()
	if(mapID == 905) then
		-- update title on Argus sub-zones
		local _, _, _, zoneMapID = GetZoneInfoAtPosition(Map:GetNormalizedCursorPosition())
		if(zoneMapID) then
			self:SetLabel(MAP_AREA_LABEL_TYPE.AREA_NAME, GetZoneName(zoneMapID), GetZoneDescription(zoneMapID))
		else
			self:ClearLabel(MAP_AREA_LABEL_TYPE.AREA_NAME)
		end

		self:EvaluateLabels()
	else
		-- let the default handler run
		AreaLabelFrameMixin.OnUpdate(self)
	end
end

for provider in next, WorldMapFrame.dataProviders do
	if(provider.setAreaLabelCallback) then
		provider.Label:SetScript('OnUpdate', AreaLabelOnUpdate)
	end
end


-- display the Vindicaar the player is on, just so it doesn't look like the player is floating in mid-air
local faction = UnitFactionGroup('player') -- players don't just change faction willy nilly, cache it
local function UpdateVindicaar(self)
	local Map = self:GetMap()
	if(Map:GetMapID() == 905) then
		self:RemoveAllData()

		if(NumTaxiNodes() == 0) then
			-- only show if we're not viewing taxi destinations
			for _, info in next, C_TaxiMap.GetTaxiNodesForMap(994) do
				if(self:ShouldShowTaxiNode(faction, info)) then
					if(info.textureKitPrefix and info.textureKitPrefix:find('Vindicaar') and info.atlasName == 'TaxiNode_Neutral') then
						Map:AcquirePin('FlightPointPinTemplate', info) -- TODO: SetSize(39, 42)
					end
				end
			end
		end
	end
end

for provider in next, WorldMapFrame.dataProviders do
	if(provider.ShouldShowTaxiNode) then
		hooksecurefunc(provider, 'RefreshAllData', UpdateVindicaar)

		-- hide the Vindicaar when opening a taxi map
		provider:RegisterEvent('TAXIMAP_OPENED')
		provider.OnEvent = UpdateVindicaar
	end
end


local pins = {}

local ARGUS = 905

local function OnDataRefreshed(self)
	local Map = self:GetMap()
	if(Map:GetMapID() == ARGUS) then
		local taxiNodes = C_TaxiMap.GetAllTaxiNodes(ARGUS)
		for index, taxiNodeData in next, taxiNodes do
			local Pin = Map:AcquirePin('FlightMap_FlightPointPinTemplate')
			self.slotIndexToPin[taxiNodeData.slotIndex] = Pin

			Pin:SetPosition(taxiNodeData.position:GetXY())
			Pin.taxiNodeData = taxiNodeData
			Pin.owner = self
			Pin.linkedPins = {}
			Pin:SetFlightPathStyle(taxiNodeData.textureKitPrefix, taxiNodeData.state)
			Pin:UpdatePinSize(taxiNodeData.state)
			Pin:UseFrameLevelType('PIN_FRAME_LEVEL_TOPMOST')
			Pin:SetShown(taxiNodeData.state ~= Enum.FlightPathState.Unreachable)
		end
	end
end

local function Inject()
	for provider in next, WorldMapFrame.dataProviders do
		if(provider.AddFlightNode) then
			hooksecurefunc(provider, 'RefreshAllData', OnDataRefreshed)
			return
		end
	end
end

if(IsAddOnLoaded('WorldFlightMap')) then
	Inject()
else
	local Handler = CreateFrame('Frame')
	Handler:RegisterEvent('ADDON_LOADED')
	Handler:SetScript('OnEvent', function(self, event, addOnName)
		if(addOnName == 'WorldFlightMap') then
			Inject()
			self:UnregisterEvent(event)
		end
	end)
end
