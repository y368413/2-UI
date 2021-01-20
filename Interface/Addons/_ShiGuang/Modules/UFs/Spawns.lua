local _, ns = ...
local M, R, U, I = unpack(ns)

local oUF = ns.oUF or oUF
local UF = M:GetModule("UnitFrames")
local format, tostring = string.format, tostring

-- Units
local function SetUnitFrameSize(self, unit)
	local width = R.db["UFs"][unit.."Width"]
	local height = R.db["UFs"][unit.."Height"] + R.db["UFs"][unit.."PowerHeight"] + R.mult
	self:SetSize(width, height)
end

local function CreatePlayerStyle(self)
	self.mystyle = "player"
	--UF:CreateCastBar(self)
	UF:CreateQuestSync(self)
	--if R.db["UFs"]["Castbars"] then
		--UF:ReskinMirrorBars()
		--UF:ReskinTimerTrakcer(self)
	--end
	--if R.db["UFs"]["ClassPower"] and not R.db["Nameplate"]["ShowPlayerPlate"] then
		--UF:CreateClassPower(self)
		--UF:StaggerBar(self)
	--end
	if not R.db["Misc"]["ExpRep"] then UF:CreateExpRepBar(self) end
	--if R.db["UFs"]["PlayerDebuff"] then UF:CreateDebuffs(self) end
	if R.db["UFs"]["SwingBar"] then UF:CreateSwing(self) end
	if R.db["UFs"]["QuakeTimer"] then UF:CreateQuakeTimer(self) end
end

local function CreateTargetStyle(self)
	self.mystyle = "target"
	--UF:CreateCastBar(self)
end

local function CreateFocusStyle(self)
	self.mystyle = "focus"
	SetUnitFrameSize(self, "Focus")

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreatePowerText(self)
	UF:CreateCastBar(self)
	UF:CreateRaidMark(self)
	UF:CreateIcons(self)
	UF:CreatePrediction(self)
	UF:CreateAuras(self)
end

local function CreateFocusTargetStyle(self)
	self.mystyle = "focustarget"
	SetUnitFrameSize(self, "Pet")

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreateRaidMark(self)
end

local function CreateBossStyle(self)
	self.mystyle = "boss"
	SetUnitFrameSize(self, "Boss")

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreatePowerText(self)
	UF:CreateCastBar(self)
	UF:CreateRaidMark(self)
	UF:CreateAltPower(self)
	UF:CreateBuffs(self)
	UF:CreateDebuffs(self)
	UF:CreateClickSets(self)
end

local function CreateArenaStyle(self)
	self.mystyle = "arena"
	SetUnitFrameSize(self, "Boss")

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreateCastBar(self)
	UF:CreateRaidMark(self)
	UF:CreateBuffs(self)
	UF:CreateDebuffs(self)
	UF:CreatePVPClassify(self)
end

local function CreateRaidStyle(self)
	self.mystyle = "raid"
	self.Range = {
		insideAlpha = 1, outsideAlpha = .4,
	}

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreateRaidMark(self)
	UF:CreateIcons(self)
	UF:CreateTargetBorder(self)
	UF:CreateRaidIcons(self)
	UF:CreatePrediction(self)
	UF:CreateClickSets(self)
	UF:CreateRaidDebuffs(self)
	UF:CreateThreatBorder(self)
	UF:CreateAuras(self)
	UF:CreateBuffIndicator(self)
end

local function CreatePartyStyle(self)
	self.isPartyFrame = true
	CreateRaidStyle(self)
	UF:InterruptIndicator(self)
	UF:CreatePartyAltPower(self)
end

local function CreatePartyPetStyle(self)
	self.mystyle = "raid"
	self.isPartyPet = true
	self.Range = {
		insideAlpha = 1, outsideAlpha = .4,
	}

	UF:CreateHeader(self)
	UF:CreateHealthBar(self)
	UF:CreateHealthText(self)
	UF:CreatePowerBar(self)
	UF:CreateRaidMark(self)
	UF:CreateTargetBorder(self)
	UF:CreatePrediction(self)
	UF:CreateClickSets(self)
	UF:CreateThreatBorder(self)
end

-- Spawns
function UF:OnLogin()
	local horizonRaid = R.db["UFs"]["HorizonRaid"]
	local horizonParty = R.db["UFs"]["HorizonParty"]
	local numGroups = R.db["UFs"]["NumGroups"]
	local scale = R.db["UFs"]["SimpleRaidScale"]/10
	local raidWidth, raidHeight = R.db["UFs"]["RaidWidth"], R.db["UFs"]["RaidHeight"]
	local reverse = R.db["UFs"]["ReverseRaid"]
	local showPartyFrame = R.db["UFs"]["PartyFrame"]
	local partyWidth, partyHeight = R.db["UFs"]["PartyWidth"], R.db["UFs"]["PartyHeight"]
	local showPartyPetFrame = R.db["UFs"]["PartyPetFrame"]
	local petWidth, petHeight = R.db["UFs"]["PartyPetWidth"], R.db["UFs"]["PartyPetHeight"]
	local showTeamIndex = R.db["UFs"]["ShowTeamIndex"]
	local showSolo = R.db["UFs"]["ShowSolo"]

	if R.db["Nameplate"]["Enable"] then
		UF:SetupCVars()
		UF:BlockAddons()
		UF:CreateUnitTable()
		UF:CreatePowerUnitTable()
		UF:CheckExplosives()
		UF:AddInterruptInfo()
		UF:UpdateGroupRoles()
		UF:QuestIconCheck()
		UF:RefreshPlateOnFactionChanged()

		oUF:RegisterStyle("Nameplates", UF.CreatePlates)
		oUF:SetActiveStyle("Nameplates")
		oUF:SpawnNamePlates("oUF_NPs", UF.PostUpdatePlates)
	end

	if R.db["Nameplate"]["ShowPlayerPlate"] then
		oUF:RegisterStyle("PlayerPlate", UF.CreatePlayerPlate)
		oUF:SetActiveStyle("PlayerPlate")
		local plate = oUF:Spawn("player", "oUF_PlayerPlate", true)
		plate.mover = M.Mover(plate, U["PlayerPlate"], "PlayerPlate", R.UFs.PlayerPlate)
	end

	-- Default Clicksets for RaidFrame
	UF:DefaultClickSets()
		oUF:RegisterStyle("Player", CreatePlayerStyle)
		oUF:RegisterStyle("Target", CreateTargetStyle)
		if (ShiGuangPerDB["BHT"] == true) then
		oUF:RegisterStyle("Focus", CreateFocusStyle)
		oUF:RegisterStyle("FocusTarget", CreateFocusTargetStyle)
		end
		-- Loader
		oUF:SetActiveStyle("Player")
		local player = oUF:Spawn("player", "oUF_Player")
		oUF:SetActiveStyle("Target")
		local target = oUF:Spawn("target", "oUF_Target")

		if (ShiGuangPerDB["BHT"] == true) then
		oUF:SetActiveStyle("Focus")
		local focus = oUF:Spawn("focus", "oUF_Focus")
		M.Mover(focus, U["FocusUF"], "FocusUF", R.UFs.FocusPos)

		oUF:SetActiveStyle("FocusTarget")
		local focustarget = oUF:Spawn("focustarget", "oUF_FocusTarget")
		M.Mover(focustarget, U["FotUF"], "FotUF", {"TOPLEFT", oUF_Focus, "TOPRIGHT", 5, 0})
		end

		oUF:RegisterStyle("Boss", CreateBossStyle)
		oUF:SetActiveStyle("Boss")
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES do
			boss[i] = oUF:Spawn("boss"..i, "oUF_Boss"..i)
			local moverWidth, moverHeight = boss[i]:GetWidth(), boss[i]:GetHeight()+8
			if i == 1 then
				boss[i].mover = M.Mover(boss[i], U["BossFrame"]..i, "Boss1", {"TOPRIGHT", UIParent, "TOPRIGHT", -16, -250}, moverWidth, moverHeight)
			else
				boss[i].mover = M.Mover(boss[i], U["BossFrame"]..i, "Boss"..i, {"TOP", boss[i-1], "BOTTOM", 0, -26}, moverWidth, moverHeight)
			end
		end
		if R.db["UFs"]["Arena"] then
			oUF:RegisterStyle("Arena", CreateArenaStyle)
			oUF:SetActiveStyle("Arena")
			local arena = {}
			for i = 1, 5 do
				arena[i] = oUF:Spawn("arena"..i, "oUF_Arena"..i)
				arena[i]:SetPoint("TOPLEFT", boss[i].mover)
			end
		end

		UF:UpdateTextScale()
	if R.db["UFs"]["RaidFrame"] then
		UF:AddClickSetsListener()
		UF:UpdateCornerSpells()

		-- Hide Default RaidFrame
		if CompactRaidFrameManager_SetSetting then
			CompactRaidFrameManager_SetSetting("IsShown", "0")
			UIParent:UnregisterEvent("GROUP_ROSTER_UPDATE")
			CompactRaidFrameManager:UnregisterAllEvents()
			CompactRaidFrameManager:SetParent(M.HiddenFrame)
		end

		-- Group Styles
		local partyMover
		if showPartyFrame then
			UF:SyncWithZenTracker()
			UF:UpdatePartyWatcherSpells()

			oUF:RegisterStyle("Party", CreatePartyStyle)
			oUF:SetActiveStyle("Party")

			local xOffset, yOffset = 5, 5
			local partyFrameHeight = partyHeight + R.db["UFs"]["PartyPowerHeight"] + R.mult
			local moverWidth = horizonParty and (partyWidth*5+xOffset*4) or partyWidth
			local moverHeight = horizonParty and partyFrameHeight or (partyFrameHeight*5+yOffset*4)
			local groupingOrder = horizonParty and "TANK,HEALER,DAMAGER,NONE" or "NONE,DAMAGER,HEALER,TANK"

			local party = oUF:SpawnHeader("oUF_Party", nil, "solo,party",
			"showPlayer", true,
			"showSolo", showSolo,
			"showParty", true,
			"showRaid", false,
			"xoffset", xOffset,
			"yOffset", yOffset,
			"groupingOrder", groupingOrder,
			"groupBy", "ASSIGNEDROLE",
			"sortMethod", "NAME",
			"point", horizonParty and "LEFT" or "BOTTOM",
			"columnAnchorPoint", "LEFT",
			"oUF-initialConfigFunction", ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
			]]):format(partyWidth, partyFrameHeight))

			local partyMover = M.Mover(party, U["PartyFrame"], "PartyFrame", {"TOPLEFT", UIParent, 310, -120}, moverWidth, moverHeight)
			party:ClearAllPoints()
			party:SetPoint("BOTTOMLEFT", partyMover)

			if showPartyPetFrame then
				oUF:RegisterStyle("PartyPet", CreatePartyPetStyle)
				oUF:SetActiveStyle("PartyPet")

				local petFrameHeight = petHeight + R.db["UFs"]["PartyPetPowerHeight"] + R.mult
				local petMoverWidth = horizonParty and (petWidth*5+xOffset*4) or petWidth
				local petMoverHeight = horizonParty and petFrameHeight or (petFrameHeight*5+yOffset*4)

				local partyPet = oUF:SpawnHeader("oUF_PartyPet", nil, "solo,party",
				"showPlayer", true,
				"showSolo", showSolo,
				"showParty", true,
				"showRaid", false,
				"xoffset", xOffset,
				"yOffset", yOffset,
				"point", horizonParty and "LEFT" or "BOTTOM",
				"columnAnchorPoint", "LEFT",
				"oUF-initialConfigFunction", ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
				self:SetAttribute("unitsuffix", "pet")
				]]):format(petWidth, petFrameHeight))

				local moverAnchor = horizonParty and {"TOPLEFT", partyMover, "BOTTOMLEFT", 0, -20} or {"BOTTOMRIGHT", partyMover, "BOTTOMLEFT", -10, 0}
				local petMover = M.Mover(partyPet, U["PartyPetFrame"], "PartyPetFrame", moverAnchor, petMoverWidth, petMoverHeight)
				partyPet:ClearAllPoints()
				partyPet:SetPoint("BOTTOMLEFT", petMover)
			end
		end

		oUF:RegisterStyle("Raid", CreateRaidStyle)
		oUF:SetActiveStyle("Raid")

		local raidMover
		if R.db["UFs"]["SimpleMode"] then
			local unitsPerColumn = R.db["UFs"]["SMUnitsPerColumn"]
			local maxColumns = M:Round(numGroups*5 / unitsPerColumn)

			local function CreateGroup(name, i)
				local group = oUF:SpawnHeader(name, nil, "solo,party,raid",
				"showPlayer", true,
				"showSolo", showSolo and not showPartyFrame,
				"showParty", not showPartyFrame,
				"showRaid", true,
				"xoffset", 5,
				"yOffset", -5,
				"groupFilter", tostring(i),
				"maxColumns", maxColumns,
				"unitsPerColumn", unitsPerColumn,
				"columnSpacing", 5,
				"point", "TOP",
				"columnAnchorPoint", "LEFT",
				"oUF-initialConfigFunction", ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
				]]):format(100*scale, 20*scale))
				return group
			end

			local groupFilter
			if numGroups == 4 then
				groupFilter = "1,2,3,4"
			elseif numGroups == 5 then
				groupFilter = "1,2,3,4,5"
			elseif numGroups == 6 then
				groupFilter = "1,2,3,4,5,6"
			elseif numGroups == 7 then
				groupFilter = "1,2,3,4,5,6,7"
			elseif numGroups == 8 then
				groupFilter = "1,2,3,4,5,6,7,8"
			end

			local group = CreateGroup("oUF_Raid", groupFilter)
			local moverWidth = (100*scale*maxColumns + 5*(maxColumns-1))
			local moverHeight = 25*scale*unitsPerColumn + 5*(unitsPerColumn-1)
			raidMover = M.Mover(group, U["RaidFrame"], "RaidFrame", {"TOPLEFT", UIParent, 3, -26}, moverWidth, moverHeight)

			local groupByTypes = {
				[1] = {"1,2,3,4,5,6,7,8", "GROUP", "INDEX"},
				[2] = {"DEATHKNIGHT,WARRIOR,DEMONHUNTER,ROGUE,MONK,PALADIN,DRUID,SHAMAN,HUNTER,PRIEST,MAGE,WARLOCK", "CLASS", "NAME"},
				[3] = {"TANK,HEALER,DAMAGER,NONE", "ASSIGNEDROLE", "NAME"},
			}
			function UF:UpdateSimpleModeHeader()
				local groupByIndex = R.db["UFs"]["SMGroupByIndex"]
				group:SetAttribute("groupingOrder", groupByTypes[groupByIndex][1])
				group:SetAttribute("groupBy", groupByTypes[groupByIndex][2])
				group:SetAttribute("sortMethod", groupByTypes[groupByIndex][3])
			end
			UF:UpdateSimpleModeHeader()
		else
			local raidFrameHeight = raidHeight + R.db["UFs"]["RaidPowerHeight"] + R.mult

			local function CreateGroup(name, i)
				local group = oUF:SpawnHeader(name, nil, "solo,party,raid",
				"showPlayer", true,
				"showSolo", showSolo and not showPartyFrame,
				"showParty", not showPartyFrame,
				"showRaid", true,
				"xoffset", 5,
				"yOffset", -5,
				"groupFilter", tostring(i),
				"groupingOrder", "1,2,3,4,5,6,7,8",
				"groupBy", "GROUP",
				"sortMethod", "INDEX",
				"maxColumns", 1,
				"unitsPerColumn", 5,
				"columnSpacing", 5,
				"point", horizonRaid and "LEFT" or "TOP",
				"columnAnchorPoint", "LEFT",
				"oUF-initialConfigFunction", ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
				]]):format(raidWidth, raidFrameHeight))
				return group
			end

			local groups = {}
			for i = 1, numGroups do
				groups[i] = CreateGroup("oUF_Raid"..i, i)
				if i == 1 then
					if horizonRaid then
						raidMover = M.Mover(groups[i], U["RaidFrame"], "RaidFrame", {"BOTTOMLEFT", UIParent, 3, 160}, (raidWidth+5)*5-5, (raidFrameHeight+(showTeamIndex and 25 or 5))*numGroups - (showTeamIndex and 25 or 5))
						if reverse then
							groups[i]:ClearAllPoints()
							groups[i]:SetPoint("BOTTOMLEFT", raidMover)
						end
					else
						raidMover = M.Mover(groups[i], U["RaidFrame"], "RaidFrame", {"BOTTOMLEFT", UIParent, 3, 160}, (raidWidth+5)*numGroups-5, (raidFrameHeight+5)*5-5)
						if reverse then
							groups[i]:ClearAllPoints()
							groups[i]:SetPoint("TOPRIGHT", raidMover)
						end
					end
				else
					if horizonRaid then
						if reverse then
							groups[i]:SetPoint("BOTTOMLEFT", groups[i-1], "TOPLEFT", 0, showTeamIndex and 20 or 5)
						else
							groups[i]:SetPoint("TOPLEFT", groups[i-1], "BOTTOMLEFT", 0, showTeamIndex and -20 or -5)
						end
					else
						if reverse then
							groups[i]:SetPoint("TOPRIGHT", groups[i-1], "TOPLEFT", -5, 0)
						else
							groups[i]:SetPoint("TOPLEFT", groups[i-1], "TOPRIGHT", 5, 0)
						end
					end
				end

				if showTeamIndex then
					local parent = _G["oUF_Raid"..i.."UnitButton1"]
					local teamIndex = M.CreateFS(parent, 12, format(GROUP_NUMBER, i))
					teamIndex:ClearAllPoints()
					teamIndex:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 0, 5)
					teamIndex:SetTextColor(.6, .8, 1)
				end
			end
		end

		UF:UpdateRaidHealthMethod()

		if R.db["UFs"]["SpecRaidPos"] then
			local function UpdateSpecPos(event, ...)
				local unit, _, spellID = ...
				if (event == "UNIT_SPELLCAST_SUCCEEDED" and unit == "player" and spellID == 200749) or event == "ON_LOGIN" then
					local specIndex = GetSpecialization()
					if not specIndex then return end

					if not R.db["Mover"]["RaidPos"..specIndex] then
						R.db["Mover"]["RaidPos"..specIndex] = {"TOPLEFT", "UIParent", "TOPLEFT", 3, -26}
					end
					if raidMover then
						raidMover:ClearAllPoints()
						raidMover:SetPoint(unpack(R.db["Mover"]["RaidPos"..specIndex]))
					end

					if not R.db["Mover"]["PartyPos"..specIndex] then
						R.db["Mover"]["PartyPos"..specIndex] = {"TOPLEFT", "UIParent", "TOPLEFT", 310, -120}
					end
					if partyMover then
						partyMover:ClearAllPoints()
						partyMover:SetPoint(unpack(R.db["Mover"]["PartyPos"..specIndex]))
					end
				end
			end
			UpdateSpecPos("ON_LOGIN")
			M:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", UpdateSpecPos)

			if raidMover then
				raidMover:HookScript("OnDragStop", function()
					local specIndex = GetSpecialization()
					if not specIndex then return end
					R.db["Mover"]["RaidPos"..specIndex] = R.db["Mover"]["RaidFrame"]
				end)
			end
			if partyMover then
				partyMover:HookScript("OnDragStop", function()
					local specIndex = GetSpecialization()
					if not specIndex then return end
					R.db["Mover"]["PartyPos"..specIndex] = R.db["Mover"]["PartyFrame"]
				end)
			end
		end
	end
end