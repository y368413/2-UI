local _, ns = ...
local M, R, U, I = unpack(ns)
local UF = M:GetModule("UnitFrames")

local _G = getfenv(0)
local strmatch, tonumber, pairs, unpack, rad = string.match, tonumber, pairs, unpack, math.rad
local UnitThreatSituation, UnitIsTapDenied, UnitPlayerControlled, UnitIsUnit = UnitThreatSituation, UnitIsTapDenied, UnitPlayerControlled, UnitIsUnit
local UnitReaction, UnitIsConnected, UnitIsPlayer, UnitSelectionColor = UnitReaction, UnitIsConnected, UnitIsPlayer, UnitSelectionColor
local GetInstanceInfo, UnitClassification, UnitExists, InCombatLockdown = GetInstanceInfo, UnitClassification, UnitExists, InCombatLockdown
local C_Scenario_GetInfo, C_Scenario_GetStepInfo, C_MythicPlus_GetCurrentAffixes = C_Scenario.GetInfo, C_Scenario.GetStepInfo, C_MythicPlus.GetCurrentAffixes
local UnitGUID, GetPlayerInfoByGUID, Ambiguate = UnitGUID, GetPlayerInfoByGUID, Ambiguate
local SetCVar, UIFrameFadeIn, UIFrameFadeOut = SetCVar, UIFrameFadeIn, UIFrameFadeOut
local IsInRaid, IsInGroup, UnitName, UnitHealth, UnitHealthMax = IsInRaid, IsInGroup, UnitName, UnitHealth, UnitHealthMax
local GetNumGroupMembers, GetNumSubgroupMembers, UnitGroupRolesAssigned = GetNumGroupMembers, GetNumSubgroupMembers, UnitGroupRolesAssigned
local C_NamePlate_GetNamePlateForUnit = C_NamePlate.GetNamePlateForUnit
local GetSpellCooldown, GetTime = GetSpellCooldown, GetTime
local UnitNameplateShowsWidgetsOnly = UnitNameplateShowsWidgetsOnly
local INTERRUPTED = INTERRUPTED

-- Init
function UF:PlateInsideView()
	if R.db["Nameplate"]["InsideView"] then
		SetCVar("nameplateOtherTopInset", .05)
		SetCVar("nameplateOtherBottomInset", .08)
	else
		SetCVar("nameplateOtherTopInset", -1)
		SetCVar("nameplateOtherBottomInset", -1)
	end
end

function UF:UpdatePlateScale()
	SetCVar("namePlateMinScale", R.db["Nameplate"]["MinScale"])
	SetCVar("namePlateMaxScale", R.db["Nameplate"]["MinScale"])
end

function UF:UpdatePlateAlpha()
	SetCVar("nameplateMinAlpha", R.db["Nameplate"]["MinAlpha"])
	SetCVar("nameplateMaxAlpha", R.db["Nameplate"]["MinAlpha"])
end

function UF:UpdatePlateSpacing()
	SetCVar("nameplateOverlapV", R.db["Nameplate"]["VerticalSpacing"])
end

function UF:UpdateClickableSize()
	if InCombatLockdown() then return end
	C_NamePlate.SetNamePlateEnemySize(R.db["Nameplate"]["PlateWidth"]*MaoRUIDB["UIScale"], R.db["Nameplate"]["PlateHeight"]*MaoRUIDB["UIScale"]+40)
	C_NamePlate.SetNamePlateFriendlySize(R.db["Nameplate"]["PlateWidth"]*MaoRUIDB["UIScale"], R.db["Nameplate"]["PlateHeight"]*MaoRUIDB["UIScale"]+40)
end

function UF:SetupCVars()
	UF:PlateInsideView()
	SetCVar("nameplateOverlapH", .8)
	UF:UpdatePlateSpacing()
	UF:UpdatePlateAlpha()
	SetCVar("nameplateSelectedAlpha", 1)
	SetCVar("showQuestTrackingTooltips", 1)

	UF:UpdatePlateScale()
	--SetCVar("nameplateSelectedScale", 1)
	--SetCVar("nameplateLargerScale", 1)

	SetCVar("nameplateShowSelf", 0)
	SetCVar("nameplateResourceOnTarget", 0)
	M.HideOption(InterfaceOptionsNamesPanelUnitNameplatesPersonalResource)
	M.HideOption(InterfaceOptionsNamesPanelUnitNameplatesPersonalResourceOnEnemy)

	UF:UpdateClickableSize()
	hooksecurefunc(NamePlateDriverFrame, "UpdateNamePlateOptions", UF.UpdateClickableSize)
end

function UF:BlockAddons()
	if not DBM or not DBM.Nameplate then return end

	function DBM.Nameplate:SupportedNPMod()
		return true
	end

	local function showAurasForDBM(_, _, _, spellID)
		if not tonumber(spellID) then return end
		if not R.WhiteList[spellID] then
			R.WhiteList[spellID] = true
		end
	end
	hooksecurefunc(DBM.Nameplate, "Show", showAurasForDBM)
end

-- Elements
local customUnits = {}
function UF:CreateUnitTable()
	wipe(customUnits)
	if not R.db["Nameplate"]["CustomUnitColor"] then return end
	M.CopyTable(R.CustomUnits, customUnits)
	M.SplitList(customUnits, R.db["Nameplate"]["UnitList"])
end

local showPowerList = {}
function UF:CreatePowerUnitTable()
	wipe(showPowerList)
	M.CopyTable(R.ShowPowerList, showPowerList)
	M.SplitList(showPowerList, R.db["Nameplate"]["ShowPowerList"])
end

function UF:UpdateUnitPower()
	local unitName = self.unitName
	local npcID = self.npcID
	local shouldShowPower = showPowerList[unitName] or showPowerList[npcID]
	if shouldShowPower then
		self.powerText:Show()
	else
		self.powerText:Hide()
	end
end

-- Off-tank threat color
local groupRoles, isInGroup = {}
local function refreshGroupRoles()
	local isInRaid = IsInRaid()
	isInGroup = isInRaid or IsInGroup()
	wipe(groupRoles)

	if isInGroup then
		local numPlayers = (isInRaid and GetNumGroupMembers()) or GetNumSubgroupMembers()
		local unit = (isInRaid and "raid") or "party"
		for i = 1, numPlayers do
			local index = unit..i
			if UnitExists(index) then
				groupRoles[UnitName(index)] = UnitGroupRolesAssigned(index)
			end
		end
	end
end

local function resetGroupRoles()
	isInGroup = IsInRaid() or IsInGroup()
	wipe(groupRoles)
end

function UF:UpdateGroupRoles()
	refreshGroupRoles()
	M:RegisterEvent("GROUP_ROSTER_UPDATE", refreshGroupRoles)
	M:RegisterEvent("GROUP_LEFT", resetGroupRoles)
end

function UF:CheckTankStatus(unit)
	local index = unit.."target"
	local unitRole = isInGroup and UnitExists(index) and not UnitIsUnit(index, "player") and groupRoles[UnitName(index)] or "NONE"
	if unitRole == "TANK" and I.Role == "Tank" then
		self.feedbackUnit = index
		self.isOffTank = true
	else
		self.feedbackUnit = "player"
		self.isOffTank = false
	end
end

-- Update unit color
function UF:UpdateColor(_, unit)
	if not unit or self.unit ~= unit then return end

	local element = self.Health
	local name = self.unitName
	local npcID = self.npcID
	local isCustomUnit = customUnits[name] or customUnits[npcID]
	local isPlayer = self.isPlayer
	local isFriendly = self.isFriendly
	local status = self.feedbackUnit and UnitThreatSituation(self.feedbackUnit, unit) or false -- just in case
	local customColor = R.db["Nameplate"]["CustomColor"]
	local secureColor = R.db["Nameplate"]["SecureColor"]
	local transColor = R.db["Nameplate"]["TransColor"]
	local insecureColor = R.db["Nameplate"]["InsecureColor"]
	local revertThreat = R.db["Nameplate"]["DPSRevertThreat"]
	local offTankColor = R.db["Nameplate"]["OffTankColor"]
	local executeRatio = R.db["Nameplate"]["ExecuteRatio"]
	local healthPerc = UnitHealth(unit) / (UnitHealthMax(unit) + .0001) * 100
	local r, g, b

	if not UnitIsConnected(unit) then
		r, g, b = .7, .7, .7
	else
		if isCustomUnit then
			r, g, b = customColor.r, customColor.g, customColor.b
		elseif isPlayer and isFriendly then
			if R.db["Nameplate"]["FriendlyCC"] then
				r, g, b = M.UnitColor(unit)
			else
				r, g, b = .3, .3, 1
			end
		elseif isPlayer and (not isFriendly) and R.db["Nameplate"]["HostileCC"] then
			r, g, b = M.UnitColor(unit)
		elseif UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
			r, g, b = .6, .6, .6
		else
			r, g, b = UnitSelectionColor(unit, true)
			if status and (R.db["Nameplate"]["TankMode"] or I.Role == "Tank") then
				if status == 3 then
					if I.Role ~= "Tank" and revertThreat then
						r, g, b = insecureColor.r, insecureColor.g, insecureColor.b
					else
						if self.isOffTank then
							r, g, b = offTankColor.r, offTankColor.g, offTankColor.b
						else
							r, g, b = secureColor.r, secureColor.g, secureColor.b
						end
					end
				elseif status == 2 or status == 1 then
					r, g, b = transColor.r, transColor.g, transColor.b
				elseif status == 0 then
					if I.Role ~= "Tank" and revertThreat then
						r, g, b = secureColor.r, secureColor.g, secureColor.b
					else
						r, g, b = insecureColor.r, insecureColor.g, insecureColor.b
					end
				end
			end
		end
	end

	if r or g or b then
		element:SetStatusBarColor(r, g, b)
	end

	if isCustomUnit or (not R.db["Nameplate"]["TankMode"] and I.Role ~= "Tank") then
		if status and status == 3 then
			self.ThreatIndicator:SetBackdropBorderColor(1, 0, 0)
			self.ThreatIndicator:Show()
		elseif status and (status == 2 or status == 1) then
			self.ThreatIndicator:SetBackdropBorderColor(1, 1, 0)
			self.ThreatIndicator:Show()
		else
			self.ThreatIndicator:Hide()
		end
	else
		self.ThreatIndicator:Hide()
	end

	if executeRatio > 0 and healthPerc <= executeRatio then
		self.nameText:SetTextColor(1, 0, 0)
	else
		self.nameText:SetTextColor(1, 1, 1)
	end
end

function UF:UpdateThreatColor(_, unit)
	if unit ~= self.unit then return end

	UF.CheckTankStatus(self, unit)
	UF.UpdateColor(self, _, unit)
end

function UF:CreateThreatColor(self)
	local threatIndicator = M.CreateSD(self, 3, true)
	threatIndicator:SetOutside(self.Health.backdrop, 3, 3)
	threatIndicator:Hide()

	self.ThreatIndicator = threatIndicator
	self.ThreatIndicator.Override = UF.UpdateThreatColor
end

-- Target indicator
function UF:UpdateTargetChange()
	local element = self.TargetIndicator
	if R.db["Nameplate"]["TargetIndicator"] == 1 then return end

	if UnitIsUnit(self.unit, "target") and not UnitIsUnit(self.unit, "player") then
		element:Show()
	else
		element:Hide()
	end
end

function UF:UpdateTargetIndicator()
	local style = R.db["Nameplate"]["TargetIndicator"]
	local element = self.TargetIndicator
	local isNameOnly = self.isNameOnly
	if style == 1 then
		element:Hide()
	else
		if style == 2 then
			element.TopArrow:Show()
			element.LeftArrow:Hide()
			element.RightArrow:Hide()
			element.Glow:Hide()
			element.nameGlow:Hide()
		elseif style == 3 then
			element.TopArrow:Hide()
			element.LeftArrow:Show()
			element.RightArrow:Show()
			element.Glow:Hide()
			element.nameGlow:Hide()
		elseif style == 4 then
			element.TopArrow:Hide()
			element.LeftArrow:Hide()
			element.RightArrow:Hide()
			if isNameOnly then
				element.Glow:Hide()
				element.nameGlow:Show()
			else
				element.Glow:Show()
				element.nameGlow:Hide()
			end
		elseif style == 5 then
			element.TopArrow:Show()
			element.LeftArrow:Hide()
			element.RightArrow:Hide()
			if isNameOnly then
				element.Glow:Hide()
				element.nameGlow:Show()
			else
				element.Glow:Show()
				element.nameGlow:Hide()
			end
		elseif style == 6 then
			element.TopArrow:Hide()
			element.LeftArrow:Show()
			element.RightArrow:Show()
			if isNameOnly then
				element.Glow:Hide()
				element.nameGlow:Show()
			else
				element.Glow:Show()
				element.nameGlow:Hide()
			end
		end
		element:Show()
	end
end

function UF:AddTargetIndicator(self)
	local frame = CreateFrame("Frame", nil, self)
	frame:SetAllPoints()
	frame:SetFrameLevel(0)
	frame:Hide()

	frame.TopArrow = frame:CreateTexture(nil, "BACKGROUND", nil, -6)
	frame.TopArrow:SetSize(52, 52)
	frame.TopArrow:SetTexture(I.arrowTex)
	frame.TopArrow:SetVertexColor(1, 0, 0, 1)
	frame.TopArrow:SetPoint("BOTTOM", frame, "TOP", 0, 21)
	
	frame.LeftArrow = frame:CreateTexture(nil, "BACKGROUND", nil, -6)
	frame.LeftArrow:SetSize(36, 36)
	frame.LeftArrow:SetTexture(I.arrowTex)
	frame.LeftArrow:SetVertexColor(1, 0, 0, 1)
	frame.LeftArrow:SetPoint("RIGHT", frame, "LEFT", -1, 0)
	frame.LeftArrow:SetRotation(rad(90))
	
	frame.RightArrow = frame:CreateTexture(nil, "BACKGROUND", nil, -6)
	frame.RightArrow:SetSize(36, 36)
	frame.RightArrow:SetTexture(I.arrowTex)
	frame.RightArrow:SetVertexColor(1, 0, 0, 1)
	frame.RightArrow:SetPoint("LEFT", frame, "RIGHT", 1, 0)
	frame.RightArrow:SetRotation(rad(-90))

	frame.Glow = M.CreateSD(frame, 6, true)
	frame.Glow:SetOutside(self.Health.backdrop, 5, 5)
	frame.Glow:SetBackdropBorderColor(1, 1, 1)
	frame.Glow:SetFrameLevel(0)

	frame.nameGlow = frame:CreateTexture(nil, "BACKGROUND", nil, -5)
	frame.nameGlow:SetSize(150, 80)
	frame.nameGlow:SetTexture("Interface\\GLUES\\Models\\UI_Draenei\\GenericGlow64")
	frame.nameGlow:SetVertexColor(0, .6, 1)
	frame.nameGlow:SetBlendMode("ADD")
	frame.nameGlow:SetPoint("CENTER", self, "BOTTOM")

	self.TargetIndicator = frame
	self:RegisterEvent("PLAYER_TARGET_CHANGED", UF.UpdateTargetChange, true)
	UF.UpdateTargetIndicator(self)
end

-- Quest progress
local isInInstance
local function CheckInstanceStatus()
	isInInstance = IsInInstance()
end

function UF:QuestIconCheck()
	if not R.db["Nameplate"]["QuestIndicator"] then return end

	CheckInstanceStatus()
	M:RegisterEvent("PLAYER_ENTERING_WORLD", CheckInstanceStatus)
end

function UF:UpdateQuestUnit(_, unit)
	if not R.db["Nameplate"]["QuestIndicator"] then return end
	if isInInstance then
		self.questIcon:Hide()
		self.questCount:SetText("")
		return
	end

	unit = unit or self.unit

	local isLootQuest, questProgress
	M.ScanTip:SetOwner(UIParent, "ANCHOR_NONE")
	M.ScanTip:SetUnit(unit)

	for i = 2, M.ScanTip:NumLines() do
		local textLine = _G["NDui_ScanTooltipTextLeft"..i]
		local text = textLine:GetText()
		if textLine and text then
			local r, g, b = textLine:GetTextColor()
			if r > .99 and g > .82 and b == 0 then
				if isInGroup and text == I.MyName or not isInGroup then
					isLootQuest = true

					local questLine = _G["NDui_ScanTooltipTextLeft"..(i+1)]
					local questText = questLine:GetText()
					if questLine and questText then
						local current, goal = strmatch(questText, "(%d+)/(%d+)")
						local progress = strmatch(questText, "(%d+)%%")
						if current and goal then
							current = tonumber(current)
							goal = tonumber(goal)
							if current == goal then
								isLootQuest = nil
							elseif current < goal then
								questProgress = goal - current
								break
							end
						elseif progress then
							progress = tonumber(progress)
							if progress == 100 then
								isLootQuest = nil
							elseif progress < 100 then
								questProgress = 100 - progress
								--break -- lower priority on progress
							end
						end
					end
				end
			end
		end
	end

	if questProgress then
		self.questCount:SetText(questProgress)
		--self.questIcon:SetTexture("Interface/WorldMap/UI-WorldMap-QuestIcon")		--self.questIcon:SetAtlas(I.objectTex)
		--self.questIcon:SetTexCoord(0, 0.56, 0.5, 1)
		--self.questIcon:Show()
	else
		self.questCount:SetText("")
		if isLootQuest then
			self.questIcon:SetAtlas('Banker')			--self.questIcon:SetAtlas(I.questTex)
			self.questIcon:Show()
		else
			self.questIcon:Hide()
		end
	end
end

function UF:AddQuestIcon(self)
	if not R.db["Nameplate"]["QuestIndicator"] then return end

	local qicon = self:CreateTexture(nil, "OVERLAY", nil, 2)
	qicon:SetPoint("RIGHT", self, "LEFT", 0, 0)
	qicon:SetSize(26, 26)
	--qicon:SetAtlas(I.questTex)
	qicon:SetTexture("Interface/WorldMap/UI-WorldMap-QuestIcon")
	qicon:SetTexCoord(0, 0.56, 0.5, 1)
	qicon:Hide()
	--local count = M.CreateFS(self, 18, "", nil, "LEFT", 0, 0)
	local count = self:CreateFontString(nil, 'OVERLAY')
	count:SetPoint("RIGHT", qicon, "LEFT", 2, 2)
	count:SetShadowOffset(1, -1)
	count:SetFont("Interface\\AddOns\\_ShiGuang\\Media\\Fonts\\Infinity.ttf", 16, "OUTLINE")
	count:SetTextColor(1,.82,0)

	self.questIcon = qicon
	self.questCount = count
	self:RegisterEvent("QUEST_LOG_UPDATE", UF.UpdateQuestUnit, true)
end

-- Dungeon progress, AngryKeystones required
function UF:AddDungeonProgress(self)
	if not R.db["Nameplate"]["AKSProgress"] then return end
	--self.progressText = M.CreateFS(self, 16, "", false, "LEFT", 0, 0)
	self.progressText = self:CreateFontString(nil, 'OVERLAY')
	self.progressText:SetPoint("LEFT", self, "RIGHT", 5, 0)
	self.progressText:SetShadowOffset(1, -1)
	self.progressText:SetFont("Interface\\AddOns\\_ShiGuang\\Media\\Fonts\\Pixel.ttf", 14, "OUTLINE")
end

local cache = {}
function UF:UpdateDungeonProgress(unit)
	if not self.progressText or not AngryKeystones_Data then return end
	if unit ~= self.unit then return end
	self.progressText:SetText("")

	local name, _, _, _, _, _, _, _, _, scenarioType = C_Scenario_GetInfo()
	if scenarioType == LE_SCENARIO_TYPE_CHALLENGE_MODE then
		local npcID = self.npcID
		local info = AngryKeystones_Data.progress[npcID]
		if info then
			local numCriteria = select(3, C_Scenario_GetStepInfo())
			local total = cache[name]
			if not total then
				for criteriaIndex = 1, numCriteria do
					local _, _, _, _, totalQuantity, _, _, _, _, _, _, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(criteriaIndex)
					if isWeightedProgress then
						cache[name] = totalQuantity
						total = cache[name]
						break
					end
				end
			end

			local value, valueCount
			for amount, count in pairs(info) do
				if not valueCount or count > valueCount or (count == valueCount and amount < value) then
					value = amount
					valueCount = count
				end
			end

			if value and total then
				self.progressText:SetText(format("+%.2f", value/total*100))
			end
		end
	end
end

-- Unit classification
local classify = {
	rare = {"Interface\\MINIMAP\\ObjectIcons", .391, .487, .644, .74},  --rare = {1, 1, 1, true},
	elite = {"Interface\\MINIMAP\\Minimap_skull_elite", 0, 1, 0, 1},	--elite = {1, 1, 1},
	rareelite = {"Interface\\MINIMAP\\ObjectIcons", .754, .875, .624, .749},	--rareelite = {1, .1, .1},
	worldboss = {"Interface\\MINIMAP\\ObjectIcons", .879, 1, .754, .879},	  --worldboss = {0, 1, 0},
}

function UF:AddCreatureIcon(self)
	local iconFrame = CreateFrame("Frame", nil, self)
	iconFrame:SetAllPoints()
	iconFrame:SetFrameLevel(self:GetFrameLevel() + 2)

	local icon = iconFrame:CreateTexture(nil, "ARTWORK")
	--icon:SetAtlas("VignetteKill")
	icon:SetPoint("RIGHT", self, "LEFT", 0, 0)
	icon:SetSize(21, 21)
	icon:Hide()

	self.ClassifyIndicator = icon
end

function UF:UpdateUnitClassify(unit)
	if self.ClassifyIndicator then
		local class = UnitClassification(unit)
	  local level = UnitLevel(unit)
		if (not self.isNameOnly) and class and classify[class] then
			local tex, r, g, b, desature = unpack(classify[class])
			--self.ClassifyIndicator:SetVertexColor(r, g, b)
			--self.ClassifyIndicator:SetDesaturated(desature)
			
			if level and level < UnitLevel("player") then  -- or level == -1
			    if class == elite then
			        self.ClassifyIndicator:Hide()
			    end
			else    
			    self.ClassifyIndicator:SetTexture(tex)
		      self.ClassifyIndicator:SetTexCoord(r, g, b, desature)
		      self.ClassifyIndicator:Show()
			end
		else
			self.ClassifyIndicator:Hide()
		end
	end
end

-- Scale plates for explosives
local hasExplosives
local id = 120651
function UF:UpdateExplosives(event, unit)
	if not hasExplosives or unit ~= self.unit then return end

	local npcID = self.npcID
	if event == "NAME_PLATE_UNIT_ADDED" and npcID == id then
		self:SetScale(MaoRUIDB["UIScale"]*1.25)
	elseif event == "NAME_PLATE_UNIT_REMOVED" then
		self:SetScale(MaoRUIDB["UIScale"])
	end
end

local function checkInstance()
	local name, _, instID = GetInstanceInfo()
	if name and instID == 8 then
		hasExplosives = true
	else
		hasExplosives = false
	end
end

local function checkAffixes(event)
	local affixes = C_MythicPlus_GetCurrentAffixes()
	if not affixes then return end
	if affixes[3] and affixes[3].id == 13 then
		checkInstance()
		M:RegisterEvent(event, checkInstance)
		M:RegisterEvent("CHALLENGE_MODE_START", checkInstance)
	end
	M:UnregisterEvent(event, checkAffixes)
end

function UF:CheckExplosives()
	if not R.db["Nameplate"]["ExplosivesScale"] then return end

	M:RegisterEvent("PLAYER_ENTERING_WORLD", checkAffixes)
end

-- Mouseover indicator
function UF:IsMouseoverUnit()
	if not self or not self.unit then return end

	if self:IsVisible() and UnitExists("mouseover") then
		return UnitIsUnit("mouseover", self.unit)
	end
	return false
end

function UF:UpdateMouseoverShown()
	if not self or not self.unit then return end

	if self:IsShown() and UnitIsUnit("mouseover", self.unit) then
		self.HighlightIndicator:Show()
		self.HighlightUpdater:Show()
	else
		self.HighlightUpdater:Hide()
	end
end

function UF:MouseoverIndicator(self)
	local highlight = CreateFrame("Frame", nil, self.Health)
	highlight:SetAllPoints(self)
	highlight:Hide()
	local texture = highlight:CreateTexture(nil, "ARTWORK")
	texture:SetPoint("BOTTOM", self, "BOTTOM", 0, 0)
	texture:SetSize(R.db["Nameplate"]["PlateWidth"]+8, R.db["Nameplate"]["PlateHeight"]+8)
	texture:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\UFs\\hlglow")
	texture:SetTexCoord(0, 1, 1, 0)
	texture:SetVertexColor(1, 1, 0)

	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", UF.UpdateMouseoverShown, true)

	local f = CreateFrame("Frame", nil, self)
	f:SetScript("OnUpdate", function(_, elapsed)
		f.elapsed = (f.elapsed or 0) + elapsed
		if f.elapsed > .1 then
			if not UF.IsMouseoverUnit(self) then
				f:Hide()
			end
			f.elapsed = 0
		end
	end)
	f:HookScript("OnHide", function()
		highlight:Hide()
	end)

	self.HighlightIndicator = highlight
	self.HighlightUpdater = f
end

-- WidgetContainer
function UF:AddWidgetContainer(self)
	local widgetContainer = CreateFrame("Frame", nil, self, "UIWidgetContainerTemplate")
	widgetContainer:SetPoint("TOP", self.Castbar, "BOTTOM", 0, 0)
	widgetContainer:SetScale(1/MaoRUIDB["UIScale"]) -- need reviewed
	widgetContainer:Hide()

	self.WidgetContainer = widgetContainer
end

-- Interrupt info on castbars
local guidToPlate = {}
function UF:UpdateCastbarInterrupt(...)
	local _, eventType, _, sourceGUID, sourceName, _, _, destGUID = ...
	if eventType == "SPELL_INTERRUPT" and destGUID and sourceName and sourceName ~= "" then
		local nameplate = guidToPlate[destGUID]
		if nameplate and nameplate.Castbar then
			local _, class = GetPlayerInfoByGUID(sourceGUID)
			local r, g, b = M.ClassColor(class)
			local color = M.HexRGB(r, g, b)
			local sourceName = Ambiguate(sourceName, "short")
			nameplate.Castbar.Text:SetText(INTERRUPTED.." > "..color..sourceName)
			nameplate.Castbar.Time:SetText("")
		end
	end
end

function UF:AddInterruptInfo()
	M:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.UpdateCastbarInterrupt)
end

-- Create Nameplates
local platesList = {}
function UF:CreatePlates()
	self.mystyle = "nameplate"
	self:SetSize(R.db["Nameplate"]["PlateWidth"], R.db["Nameplate"]["PlateHeight"])
	self:SetPoint("CENTER")
	self:SetScale(MaoRUIDB["UIScale"])

	local health = CreateFrame("StatusBar", nil, self)
	health:SetAllPoints()
	health:SetStatusBarTexture(I.normTex)
	--health.backdrop = M.SetBD(health) -- don't mess up with libs
  M.CreateTex(health)
  M.CreateSD(health, 3)
	M:SmoothBar(health)

	self.Health = health
	self.Health.UpdateColor = UF.UpdateColor

	local title = M.CreateFS(self, R.db["Nameplate"]["NameTextSize"]-1)
	title:ClearAllPoints()
	title:SetPoint("TOP", self, "BOTTOM", 0, -10)
	title:Hide()
	self:Tag(title, "[npctitle]")
	self.npcTitle = title

	UF:CreateHealthText(self)
	UF:CreateCastBar(self)
	UF:CreateRaidMark(self)
	UF:CreatePrediction(self)
	UF:CreateAuras(self)
	UF:CreatePVPClassify(self)
	UF:CreateThreatColor(self)

	self.powerText = M.CreateFS(self, 21)
	self.powerText:ClearAllPoints()
	self.powerText:SetPoint("TOP", self.Castbar, "BOTTOM", 0, -3)
	self:Tag(self.powerText, "[nppp]")

	UF:AddWidgetContainer(self)
	UF:MouseoverIndicator(self)
	UF:AddTargetIndicator(self)
	UF:AddCreatureIcon(self)
	UF:AddQuestIcon(self)
	UF:AddDungeonProgress(self)

	platesList[self] = self:GetName()
end

-- Classpower on target nameplate
local isTargetClassPower
function UF:UpdateClassPowerAnchor()
	if not isTargetClassPower then return end

	local bar = _G.oUF_ClassPowerBar
	local nameplate = C_NamePlate_GetNamePlateForUnit("target")
	if nameplate then
		bar:SetParent(nameplate.unitFrame)
		bar:SetScale(.85)
		bar:ClearAllPoints()
		bar:SetPoint("TOP", nameplate.unitFrame, "BOTTOM", 0, 1)  --.nameText
		bar:Show()
	else
		bar:Hide()
	end
end

function UF:UpdateTargetClassPower()
	local bar = _G.oUF_ClassPowerBar
	local playerPlate = _G.oUF_PlayerPlate
	if not bar or not playerPlate then return end

	if R.db["Nameplate"]["NameplateClassPower"] then
		isTargetClassPower = true
		UF:UpdateClassPowerAnchor()
	else
		isTargetClassPower = false
		bar:SetParent(playerPlate.Health)
		bar:ClearAllPoints()
		bar:SetPoint("BOTTOMLEFT", playerPlate.Health, "TOPLEFT", 0, 3)
		bar:Show()
	end
end

function UF:UpdateNameplateAuras()
	local element = self.Auras
	if R.db["Nameplate"]["ShowPlayerPlate"] and R.db["Nameplate"]["NameplateClassPower"] then
		element:SetPoint("BOTTOMLEFT", self.nameText, "TOPLEFT", 0, 10 + _G.oUF_ClassPowerBar:GetHeight())
	else
		element:SetPoint("BOTTOMLEFT", self.nameText, "TOPLEFT", 0, 5)
	end
	element.numTotal = R.db["Nameplate"]["maxAuras"]
	element.size = R.db["Nameplate"]["AuraSize"]
	element.showDebuffType = R.db["Nameplate"]["ColorBorder"]
	element:SetWidth(self:GetWidth())
	element:SetHeight((element.size + element.spacing) * 2)
	element:ForceUpdate()
end

function UF:RefreshNameplats()
	for nameplate in pairs(platesList) do
		nameplate:SetSize(R.db["Nameplate"]["PlateWidth"], R.db["Nameplate"]["PlateHeight"])
		nameplate.nameText:SetFont(I.Font[1], R.db["Nameplate"]["NameTextSize"], I.Font[3])
		nameplate.npcTitle:SetFont(I.Font[1], R.db["Nameplate"]["NameTextSize"]-1, I.Font[3])
		nameplate.Castbar.Time:SetFont(I.Font[1], R.db["Nameplate"]["NameTextSize"], I.Font[3])
		nameplate.Castbar.Text:SetFont(I.Font[1], R.db["Nameplate"]["NameTextSize"], I.Font[3])
		nameplate.healthValue:SetFont(I.Font[1], R.db["Nameplate"]["HealthTextSize"], I.Font[3])
		nameplate.healthValue:UpdateTag()
		UF.UpdateNameplateAuras(nameplate)
		UF.UpdateTargetIndicator(nameplate)
		UF.UpdateTargetChange(nameplate)
	end
	UF:UpdateClickableSize()
end

function UF:RefreshAllPlates()
	if R.db["Nameplate"]["ShowPlayerPlate"] then
		UF:ResizePlayerPlate()
	end
	UF:RefreshNameplats()
end

local DisabledElements = {
	"Health", "Castbar", "HealPredictionAndAbsorb", "PvPClassificationIndicator", "ThreatIndicator"
}
function UF:UpdatePlateByType()
	local name = self.nameText
	local hpval = self.healthValue
	local title = self.npcTitle
	local raidtarget = self.RaidTargetIndicator
	local classify = self.ClassifyIndicator
	local questIcon = self.questIcon

	name:SetShown(not self.widgetsOnly)
	name:ClearAllPoints()
	raidtarget:ClearAllPoints()

	if self.isNameOnly then
		for _, element in pairs(DisabledElements) do
			if self:IsElementEnabled(element) then
				self:DisableElement(element)
			end
		end

		name:SetJustifyH("CENTER")
		self:Tag(name, "[nplevel][color][name]")
		name:UpdateTag()
		name:SetPoint("CENTER", self, "BOTTOM")
		hpval:Hide()
		title:Show()

		raidtarget:SetPoint("TOP", title, "BOTTOM", 0, -5)
		raidtarget:SetParent(self)
		classify:Hide()
		if questIcon then questIcon:SetPoint("LEFT", name, "RIGHT", -1, 0) end
	else
		for _, element in pairs(DisabledElements) do
			if not self:IsElementEnabled(element) then
				self:EnableElement(element)
			end
		end

		name:SetJustifyH("LEFT")
		self:Tag(name, "[nplevel][name]")
		name:UpdateTag()
		name:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 5)
		name:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, 5)
		hpval:Show()
		title:Hide()

		raidtarget:SetPoint("RIGHT", self, "LEFT", -3, 0)
		raidtarget:SetParent(self.Health)
		classify:Show()
		if questIcon then questIcon:SetPoint("LEFT", self, "RIGHT", -1, 0) end
	end

	UF.UpdateTargetIndicator(self)
end

function UF:RefreshPlateType(unit)
	self.reaction = UnitReaction(unit, "player")
	self.isFriendly = self.reaction and self.reaction >= 5
	self.isNameOnly = R.db["Nameplate"]["NameOnlyMode"] and self.isFriendly or self.widgetsOnly or false

	if self.previousType == nil or self.previousType ~= self.isNameOnly then
		UF.UpdatePlateByType(self)
		self.previousType = self.isNameOnly
	end
end

function UF:OnUnitFactionChanged(unit)
	local nameplate = C_NamePlate_GetNamePlateForUnit(unit, issecure())
	local unitFrame = nameplate and nameplate.unitFrame
	if unitFrame and unitFrame.unitName then
		UF.RefreshPlateType(unitFrame, unit)
	end
end

function UF:RefreshPlateOnFactionChanged()
	M:RegisterEvent("UNIT_FACTION", UF.OnUnitFactionChanged)
end

function UF:PostUpdatePlates(event, unit)
	if not self then return end

	if event == "NAME_PLATE_UNIT_ADDED" then
		self.unitName = UnitName(unit)
		self.unitGUID = UnitGUID(unit)
		if self.unitGUID then
			guidToPlate[self.unitGUID] = self
		end
		self.isPlayer = UnitIsPlayer(unit)
		self.npcID = M.GetNPCID(self.unitGUID)
		self.widgetsOnly = UnitNameplateShowsWidgetsOnly(unit)
		self.WidgetContainer:RegisterForWidgetSet(UnitWidgetSet(unit), M.Widget_DefaultLayout, nil, unit)

		UF.RefreshPlateType(self, unit)
	elseif event == "NAME_PLATE_UNIT_REMOVED" then
		if self.unitGUID then
			guidToPlate[self.unitGUID] = nil
		end
		self.npcID = nil
		self.WidgetContainer:UnregisterForWidgetSet()
	end

	if event ~= "NAME_PLATE_UNIT_REMOVED" then
		UF.UpdateUnitPower(self)
		UF.UpdateTargetChange(self)
		UF.UpdateQuestUnit(self, event, unit)
		UF.UpdateUnitClassify(self, unit)
		UF.UpdateDungeonProgress(self, unit)
		UF:UpdateClassPowerAnchor()
	end
	UF.UpdateExplosives(self, event, unit)
end

-- Player Nameplate
local auras = M:GetModule("Auras")

function UF:PlateVisibility(event)
	local alpha = R.db["Nameplate"]["PPFadeoutAlpha"]
	if (event == "PLAYER_REGEN_DISABLED" or InCombatLockdown()) and UnitIsUnit("player", self.unit) then
		UIFrameFadeIn(self.Health, .3, self.Health:GetAlpha(), 1)
		UIFrameFadeIn(self.Health.bg, .3, self.Health.bg:GetAlpha(), 1)
		UIFrameFadeIn(self.Power, .3, self.Power:GetAlpha(), 1)
		UIFrameFadeIn(self.Power.bg, .3, self.Power.bg:GetAlpha(), 1)
	else
		UIFrameFadeOut(self.Health, 2, self.Health:GetAlpha(), alpha)
		UIFrameFadeOut(self.Health.bg, 2, self.Health.bg:GetAlpha(), alpha)
		UIFrameFadeOut(self.Power, 2, self.Power:GetAlpha(), alpha)
		UIFrameFadeOut(self.Power.bg, 2, self.Power.bg:GetAlpha(), alpha)
	end
end

function UF:ResizePlayerPlate()
	local plate = _G.oUF_PlayerPlate
	if plate then
		local barWidth = R.db["Nameplate"]["PPWidth"]
		local barHeight = R.db["Nameplate"]["PPBarHeight"]
		local healthHeight = R.db["Nameplate"]["PPHealthHeight"]
		local powerHeight = R.db["Nameplate"]["PPPowerHeight"]

		plate:SetSize(barWidth, healthHeight + powerHeight + R.mult)
		plate.mover:SetSize(barWidth, healthHeight + powerHeight + R.mult)
		plate.Health:SetHeight(healthHeight)
		plate.Power:SetHeight(powerHeight)

		local bars = plate.ClassPower or plate.Runes
		if bars then
			local classpowerWidth = R.db["Nameplate"]["NameplateClassPower"] and R.db["Nameplate"]["PlateWidth"] or barWidth
			_G.oUF_ClassPowerBar:SetSize(classpowerWidth, barHeight)
			local max = bars.__max
			for i = 1, max do
				bars[i]:SetHeight(barHeight)
				bars[i]:SetWidth((classpowerWidth - (max-1)*R.margin) / max)
			end
		end
		if plate.Stagger then
			plate.Stagger:SetHeight(barHeight)
		end
		if plate.lumos then
			local iconSize = (barWidth+2*R.mult - R.margin*4)/5
			for i = 1, 5 do
				plate.lumos[i]:SetSize(iconSize, iconSize)
			end
		end
		if plate.dices then
			local offset = R.db["Nameplate"]["NameplateClassPower"] and R.margin or (R.margin*2 + barHeight)
			local size = (barWidth - 10)/6
			for i = 1, 6 do
				local dice = plate.dices[i]
				dice:SetSize(size, size)
				if i == 1 then
					dice:SetPoint("BOTTOMLEFT", plate.Health, "TOPLEFT", 0, offset)
				end
			end
		end
	end
end

function UF:CreatePlayerPlate()
	self.mystyle = "PlayerPlate"
	self:EnableMouse(false)
	local healthHeight, powerHeight = R.db["Nameplate"]["PPHealthHeight"], R.db["Nameplate"]["PPPowerHeight"]
	self:SetSize(R.db["Nameplate"]["PPWidth"], healthHeight + powerHeight + R.mult)

	UF:CreateHealthBar(self)
	UF:CreatePowerBar(self)
	UF:CreateClassPower(self)
	UF:StaggerBar(self)
	if R.db["Auras"]["ClassAuras"] then auras:CreateLumos(self) end

	local textFrame = CreateFrame("Frame", nil, self.Power)
	textFrame:SetAllPoints()
	textFrame:SetFrameLevel(self:GetFrameLevel() + 5)
	self.powerText = M.CreateFS(textFrame, 14)
	self:Tag(self.powerText, "[pppower]")
	UF:TogglePlatePower()

	UF:CreateGCDTicker(self)
	UF:UpdateTargetClassPower()
	UF:TogglePlateVisibility()
end

function UF:TogglePlatePower()
	local plate = _G.oUF_PlayerPlate
	if not plate then return end

	plate.powerText:SetShown(R.db["Nameplate"]["PPPowerText"])
end

function UF:TogglePlateVisibility()
	local plate = _G.oUF_PlayerPlate
	if not plate then return end

	if R.db["Nameplate"]["PPFadeout"] then
		plate:RegisterEvent("UNIT_EXITED_VEHICLE", UF.PlateVisibility)
		plate:RegisterEvent("UNIT_ENTERED_VEHICLE", UF.PlateVisibility)
		plate:RegisterEvent("PLAYER_REGEN_ENABLED", UF.PlateVisibility, true)
		plate:RegisterEvent("PLAYER_REGEN_DISABLED", UF.PlateVisibility, true)
		plate:RegisterEvent("PLAYER_ENTERING_WORLD", UF.PlateVisibility, true)
		UF.PlateVisibility(plate)
	else
		plate:UnregisterEvent("UNIT_EXITED_VEHICLE", UF.PlateVisibility)
		plate:UnregisterEvent("UNIT_ENTERED_VEHICLE", UF.PlateVisibility)
		plate:UnregisterEvent("PLAYER_REGEN_ENABLED", UF.PlateVisibility)
		plate:UnregisterEvent("PLAYER_REGEN_DISABLED", UF.PlateVisibility)
		plate:UnregisterEvent("PLAYER_ENTERING_WORLD", UF.PlateVisibility)
		UF.PlateVisibility(plate, "PLAYER_REGEN_DISABLED")
	end
end

function UF:UpdateGCDTicker()
	local start, duration = GetSpellCooldown(61304)
	if start > 0 and duration > 0 then
		if self.duration ~= duration then
			self:SetMinMaxValues(0, duration)
			self.duration = duration
		end
		self:SetValue(GetTime() - start)
		self.spark:Show()
	else
		self.spark:Hide()
	end
end

function UF:CreateGCDTicker(self)
	local ticker = CreateFrame("StatusBar", nil, self.Power)
	ticker:SetFrameLevel(self:GetFrameLevel() + 3)
	ticker:SetStatusBarTexture(I.normTex)
	ticker:GetStatusBarTexture():SetAlpha(0)
	ticker:SetAllPoints()

	local spark = ticker:CreateTexture(nil, "OVERLAY")
	spark:SetTexture(I.sparkTex)
	spark:SetBlendMode("ADD")
	spark:SetPoint("TOPLEFT", ticker:GetStatusBarTexture(), "TOPRIGHT", -10, 10)
	spark:SetPoint("BOTTOMRIGHT", ticker:GetStatusBarTexture(), "BOTTOMRIGHT", 10, -10)
	ticker.spark = spark

	ticker:SetScript("OnUpdate", UF.UpdateGCDTicker)
	self.GCDTicker = ticker

	UF:ToggleGCDTicker()
end

function UF:ToggleGCDTicker()
	local plate = _G.oUF_PlayerPlate
	local ticker = plate and plate.GCDTicker
	if not ticker then return end

	ticker:SetShown(R.db["Nameplate"]["PPGCDTicker"])
end