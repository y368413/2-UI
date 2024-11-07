------------------------------------------ 显示未战斗过的宠物战斗
--  This HandyNotes_PetDailies was heavily inspired by  --
--    HandyNotes_SummerFestival         --
--  by Ethan Centaurai                  --
------------------------------------------


-- declaration
local PetDailies = {}
PetDailies.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1, icon_alpha = 0.8 } }

-- upvalues
local _G = getfenv(0)
--quest #, optional achievement progress index, text, icon
local point_format = "(%d+)\.([0-9]+):(.+):(.+):(.+):(.*)";

local GameTooltip = _G.GameTooltip
local GetQuestLogIndexByID = _G.C_QuestLog.GetLogIndexForQuestID
local GetQuestLogLeaderBoard = _G.GetQuestLogLeaderBoard
local IsQuestFlaggedCompleted = _G.C_QuestLog.IsQuestFlaggedCompleted
local GetAchievementCriteriaInfo = _G.GetAchievementCriteriaInfo
local GetAchievementInfo = _G.GetAchievementInfo
--local GetGameTime = _G.GetGameTime
--local GetQuestsCompleted = _G.GetQuestsCompleted
local gsub = _G.string.gsub
local IsControlKeyDown = _G.IsControlKeyDown
local LibStub = _G.LibStub
local next = _G.next
local UIParent = _G.UIParent
local WorldMapButton = _G.WorldMapButton
local WorldMapTooltip = _G.WorldMapTooltip

local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local points = PetDailies.points
local ADVENTURE = 9069
local ARGUS = 12088
local FAMILY = 12100
local FAMILYALL = {12089,12091,12092,12093,12094,12095,12096,12097,12098,12099 }
local BATTLER = 13279
local BATTLERALL = {13270, 13271, 13272, 13273, 13274, 13275, 13277, 13278, 13280, 13281 }
local NUISANCES = 13626
local MINIONS = 13625
local ABHORRENT = 14881
local EXORCIST = 14879
local EXORCISTALL = {14868, 14869, 14870, 14871, 14872, 14873, 14874, 14875, 14876, 14877 }

local playerfaction = UnitFactionGroup("PLAYER")
local function showhorde()
    return playerfaction == "Horde"
end

local function showally()
    return playerfaction == "Alliance"
end


local function IsAdventure( questID )
	return (questID == ADVENTURE)
end

local function IsArgus( questID )
	return (questID == ARGUS)
end

local function IsNuisances( questID )
	return (questID == NUISANCES)
end
local function IsMinions( questID )
	return (questID == MINIONS)
end

local function IsFamily( questID )
	return (questID == FAMILY)
end

local function IsBattler( questID )
	return (questID == BATTLER)
end
local function IsExorcist( questID )
	return (questID == EXORCIST)
end
local function IsAbhorrent( questID )
	return (questID == ABHORRENT)
end

local function GetAchieveString(questID, questIndex, achieve)
	local extra = {}
	for _,j in ipairs(achieve) do
		local _,_,done = GetAchievementCriteriaInfo(j,questIndex)
		if (not done) then
			_,txt = GetAchievementInfo(j)
			table.insert(extra, txt)
		end
	end
	return extra
end

-- plugin handler for HandyNotes
local function infoFromCoord(uiMapID, coord)
	--mapFile = gsub(mapFile, "_terrain%d+$", "")
	local point = points[uiMapID] and points[uiMapID][coord]
	local extra = {}
	local nametag = ""

	if (point) then
		local qID,qSequence,tag,_,_ = point:match(point_format)
		nametag = tag
		if (IsBattler(qID + 0) and db.battler) then extra = GetAchieveString(qID,qSequence, BATTLERALL) end
		if (IsFamily(qID + 0) and db.family) then extra = GetAchieveString(qID,qSequence, FAMILYALL) end
	else
		nametag = "No info"
	end
	return nametag, extra
end

function PetDailies:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local text, extra = infoFromCoord(mapFile, coord)
	tooltip:SetText(text, 0,1,0)
	for i,j in ipairs(extra) do
		tooltip:AddLine(j, 1,0,0)
	end

	if TomTom then
		tooltip:AddLine("Right-click to set a waypoint.", 1, 1, 1)
		tooltip:AddLine("Control-Right-click to set waypoints to every battle.", 1, 1, 1)
	end

	tooltip:Show()
end

local function IsLogged(questID, questIndex)
    if (questIndex > 0 and not IsAdventure(questID) and not IsFamily(questID) and not IsBattler(questID)
			and not IsArgus(questID) and not IsNuisances(questID) and not IsMinions(questID)
			and not IsExorcist(questID) and not IsAbhorrent(questID)) then
        local q = GetQuestLogIndexByID(questID)
        return (q ~= nil and q > 0)
    else return true --shouldn't be logged so just say it is
    end
end

function PetDailies:IsComplete(questID, questIndex)
	if (questIndex > 0 and not IsAdventure(questID) and not IsFamily(questID) and not IsBattler(questID)
			and not IsArgus(questID) and not IsNuisances(questID) and not IsMinions(questID)
			and not IsExorcist(questID) and not IsAbhorrent(questID)) then
		if (IsLogged(questID, questIndex)) then
            local _,_,done = GetQuestLogLeaderBoard(questIndex,GetQuestLogIndexByID(questID))
            return done
        else return true
        end
	elseif (IsAdventure(questID) or IsFamily(questID) or IsBattler(questID) 
			or IsArgus(questID) or IsNuisances(questID) or IsMinions(questID)
			or IsExorcist(questID) or IsAbhorrent(questID)) then return false
	else return IsQuestFlaggedCompleted(questID)
	end

end


local function IsAdventureComplete(questID, questIndex)

	if (IsAdventure( questID ) and db.adv) then
		local _,_,done = GetAchievementCriteriaInfo(ADVENTURE,questIndex)
		return done
	else return true
	end
end

local function IsFamilyComplete(questID, questIndex)
	if (IsFamily( questID ) and db.family) then
		for _,j in ipairs(FAMILYALL) do
			local _,_,done = GetAchievementCriteriaInfo(j,questIndex)
			if (not done) then return false end
		end
		return true
	else return true
	end
end

local function IsArgusComplete(questID, questIndex)
	if (IsArgus( questID ) and db.argus) then
		local _,_,done = GetAchievementCriteriaInfo(ARGUS,questIndex)
		return done
	else return true
	end
end

local function IsMinionsComplete(questID, questIndex)
	if (IsMinions( questID ) and db.minions) then
		local _,_,done = GetAchievementCriteriaInfo(MINIONS,questIndex)
		return done
	else return true
	end
end

local function IsNuisancesComplete(questID, questIndex)
	if (IsNuisances( questID ) and db.nuisances) then
		local _,_,done = GetAchievementCriteriaInfo(NUISANCES,questIndex)
		return done
	else return true
	end
end

local function IsBattlerComplete(questID, questIndex)
	if (IsBattler( questID ) and db.battler) then
		for _,j in ipairs(BATTLERALL) do
			local _,_,done = GetAchievementCriteriaInfo(j,questIndex)
			if (not done) then return false end
		end
		return true
	else return true
	end
end

local function IsAbhorrentComplete(questID, questIndex)
	if (IsAbhorrent( questID ) and db.abhorrent) then
		local _,_,done = GetAchievementCriteriaInfo(ABHORRENT,questIndex)
		return done
	else return true
	end
end
local function IsExorcistComplete(questID, questIndex)
	if (IsExorcist( questID ) and db.exorcist) then
		for _,j in ipairs(EXORCISTALL) do
			local _,_,done = GetAchievementCriteriaInfo(j,questIndex)
			if (not done) then return false end
		end
		return true
	else return true
	end
end
local function IsCoin( coinReward )
    return (coinReward=="true")
end


local function MatchesFaction( faction )
    return ( (faction == "both") or (faction == "horde" and showhorde() or 
    	(faction == "alliance" and showally())) )
end

function PetDailies:ShouldBeShown( questStr )
--local function ShouldBeShown( questStr )
    local questID, questIndex, _, _, coinReward, faction = questStr:match(point_format)
	questID = tonumber(questID)
	questIndex = tonumber(questIndex)
    return IsLogged(questID, questIndex) -- true if it doesn't need to be logged or it is still in log
        and (db.completed or not PetDailies:IsComplete(questID, questIndex) -- true if you want to show complete or it's not complete
		and (not IsAdventure(questID) or not IsAdventureComplete(questID, questIndex)) -- true if it isn't the Adventure achievement or it isn't completed for Adventure
		and (not IsArgus(questID) or not IsArgusComplete(questID, questIndex)) -- true if it isn't the Argus achievement or it isn't completed for Argus
		and (not IsMinions(questID) or not IsMinionsComplete(questID, questIndex)) -- true if it isn't the Minions achievement or it isn't completed for Minions
		and (not IsNuisances(questID) or not IsNuisancesComplete(questID, questIndex)) -- true if it isn't the Nuisances achievement or it isn't completed for Nuisances
		and (not IsBattler(questID) or not IsBattlerComplete(questID, questIndex)) -- true if it isn't the Family Battler achievement or it isn't completed for Battler
		and (not IsAbhorrent(questID) or not IsAbhorrentComplete(questID, questIndex)) -- true if it isn't the Abhorrent achievement or it isn't completed for Abhorrent
		and (not IsExorcist(questID) or not IsExorcistComplete(questID, questIndex)) -- true if it isn't the Exorcist achievement or it isn't completed for Exorcist
		and (db.coins or not IsCoin(coinReward)) -- true if you want to show coins or it isn't a coin
        and (MatchesFaction(faction))) -- true if it is your faction or if it doesn't matter
    end

function PetDailies:OnLeave()
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local function createWaypoint(uiMapID, coord)
	local x, y = HandyNotes:getXY(coord)
	--local m = HandyNotes:GetMapFiletoMapID(mapFile)
	local text = infoFromCoord(uiMapID, coord)

	TomTom:AddWaypoint(uiMapID, x, y, { title = text })
	--TomTom:SetClosestWaypoint()
end

local function createAllWaypoints()
	for mapFile, coords in next, points do
		for coord, questStr in next, coords do
			if ( coord and PetDailies:ShouldBeShown(questStr) ) then
				createWaypoint(mapFile, coord)
			end
		end
	end
end

function PetDailies:OnClick(button, down, uMapID, coord)
	if TomTom and button == "RightButton" and not down then
		if IsControlKeyDown() then
			createAllWaypoints()
		else
			createWaypoint(uMapID, coord)
		end
	end
end

do
	local function iter(t, prestate)

		if not PetDailies.isEnabled then return nil end

		if not t then return nil end

		local state, value = next(t, prestate)

		while state do -- have we reached the end of this zone?
			local _, _, _, iconstr, _ = value:match(point_format)
			local icon = "interface\\icons\\"..iconstr
			if PetDailies:ShouldBeShown(value) then
				return state, mapFile, icon, db.icon_scale, db.icon_alpha
			end

			state, value = next(t, state) -- get next data
		end

		return nil, nil, nil, nil
	end

	local function iterCont(t, prestate)
		if not PetDailies.isEnabled then return nil end
		if not t then return nil end

		local zone = t.Z
		local uiMapID = t.C[zone]
		--local mapFile = HandyNotes:GetMapIDtoMapFile(t.C[zone])
		local state, value, data, cleanMapFile

		while uiMapID do
			--cleanMapFile = gsub(mapFile, "_terrain%d+$", "")
			data = points[uiMapID]

			if data then -- only if there is data for this zone
				state, value = next(data, prestate)

				while state do -- have we reached the end of this zone?
					local _, _,_, iconstr, _ = value:match(point_format)
					local icon = "interface\\icons\\"..iconstr
					if (PetDailies:ShouldBeShown(value)) then
						return state, uiMapID, icon, db.icon_scale, db.icon_alpha
					end

					state, value = next(data, state) -- get next data
				end
			end

			-- get next zone
			zone = next(t.C, zone)
			t.Z = zone
			uiMapID = t.C[zone]
			prestate = nil
		end
	end

	function PetDailies:GetNodes2(uiMapID, miniMap)
		local C = HandyNotes:GetContinentZoneList(uiMapID) -- Is this a continent?
		if C then
			local tbl = { C = C, Z = next(C) }
			return iterCont, tbl, nil
		else
			--mapFile = gsub(mapFile, "_terrain%d+$", "")
			return iter, points[uiMapID], nil
		end
	end
--	function PetDailies:GetNodes(mapFile)
--		print(mapFile)
--		local C = HandyNotes:GetContinentZoneList(mapFile) -- Is this a continent?
--
--		if C then
--			local tbl = { C = C, Z = next(C) }
--			return iterCont, tbl, nil
--		else
--			mapFile = gsub(mapFile, "_terrain%d+$", "")
--			return iter, points[mapFile], nil
--		end
--	end
end


-- config
local options = {
	type = "group",
	name = "Battle Pet Dailies",
	desc = "Battle Pet Daily locations.",
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		PetDailies:Refresh()
	end,
	args = {

		completed = {
			name = "Show completed",
			desc = "Show icons for pets you have defeated today.",
			type = "toggle",
			width = "full",
			arg = "completed",
			order = 1,
		},
		coins = {
			name = "Show coin rewards also",
			desc = "Show icons for pet tamers that only give coin rewards.",
			type = "toggle",
			width = "full",
			arg = "coins",
			order = 2,
		},
		adv = {
			name = "Show An Awfully Big Adventure",
			desc = "Show icons for pet tamers you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "adv",
			order = 3,
		},
		argus = {
			name = "Show Anomalous Animals of Argus",
			desc = "Show icons for pet tamers you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "argus",
			order = 3,
		},
		family = {
			name = "Show Family Fighter",
			desc = "Show icons for pet tamers you haven't defeated fully for this achievement.",
			type = "toggle",
			width = "full",
			arg = "family",
			order = 3,
		},
		battler = {
			name = "Show Family Battler",
			desc = "Show icons for pet tamers you haven't defeated fully for this achievement.",
			type = "toggle",
			width = "full",
			arg = "family",
			order = 4,
		},
		nuisances = {
			name = "Show Nautical Nuisances of Nazjatar",
			desc = "Show icons for pets you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "nuisances",
			order = 5,
		},
		minions = {
			name = "Show Mighty Minions of Mechagon",
			desc = "Show icons for pets you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "minions",
			order = 6,
		},
		exorcist = {
			name = "Show Family Exorcist",
			desc = "Show icons for pet tamers you haven't defeated fully for this achievement.",
			type = "toggle",
			width = "full",
			arg = "exorcist",
			order = 7,
		},
		abhorrent = {
			name = "Show Abhorrent Adversaries",
			desc = "Show icons for pets you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "abhorrent",
			order = 8,
		},
        desc = {
            name = "These settings control the look and feel of the icon.",
            type = "description",
            order = 9,
        },		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "Change the size of the icons.",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 10,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "Change the transparency of the icons.",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 11,
		},
	},
}

-- initialise
function PetDailies:OnEnable()
	self.isEnabled = true
	HandyNotes:RegisterPluginDB("PetDailies", self, options)

	db = LibStub("AceDB-3.0"):New("HandyNotes_PetDailiesDB", defaults, "Default").profile
end

function PetDailies:Refresh(_, _)
	self:SendMessage("HandyNotes_NotifyUpdate", "PetDailies")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(PetDailies, "HandyNotes_PetDailies", "AceEvent-3.0")


local HandyNotes_PetDailies = LibStub("AceAddon-3.0"):NewAddon("PetDailies", "AceConsole-3.0", "AceEvent-3.0")

function HandyNotes_PetDailies:handleSlashCommand(msg)
	if (msg) then
		if (msg == "list") then
			HandyNotes_PetDailies.ToggleList()
		end
	end
end

HandyNotes_PetDailies.defaults = { profile = { completed = false } }

function HandyNotes_PetDailies:OnInitialize()
	HandyNotes_PetDailies:RegisterChatCommand("pd","handleSlashCommand")
end


function HandyNotes_PetDailies:ToggleList()
	HandyNotes_PetDailies.UI:Show()
end

local function ParsePoint(id)
	local point_format = "(%d+)\.([0-9]+):(.+):(.+):(.+):(.*)";
	return id:match(point_format)
end

function HandyNotes_PetDailies:BuildData(group)
	local achieves = {
		[9069] = true,
		[12088] = true,
		[12100] = true,
		[13279] = true,
		[13626] = true,
		[13625] = true
	}
	local ADVENTURE = "9069"
	local ARGUS = "12088"
	local FAMILY = "12100"
	local BATTLER = "13279"
	local NUISANCES = "13626"
	local MINIONS = "13625"
	local points_db = HandyNotes_PetDailies.points
	local map = C_Map.GetBestMapForUnit("player")

	if (group == 1) then
		self.UI:AddToScroll(self.UI:CreateHeading(C_Map.GetMapInfo(534).name))

		for i, id in pairs(points_db[534]) do
			if PetDailies:ShouldBeShown(id) then
				self.UI:AddToScroll(self.UI:CreateScrollGroup(false, ParsePoint(id)))
			end

		end
	elseif (group == 2) then
		self.UI:AddToScroll(self.UI:CreateHeading(C_Map.GetMapInfo(map).name))

		for i, id in pairs(points_db[map]) do
			if PetDailies:ShouldBeShown(id) then
				self.UI:AddToScroll(self.UI:CreateScrollGroup(false,ParsePoint(id)))
			end

		end
	elseif (group == 3) then
		self.UI:AddToScroll(self.UI:CreateHeading(C_Map.GetMapInfo(map).name))
		local achieve = 0
		local newachieve = 1
		local idx = 1
		for i, id in pairs(points_db[map]) do
			if PetDailies:ShouldBeShown(id) then
				newachieve, idx = ParsePoint(id)
				newachieve = newachieve + 0
				if (achieves[newachieve] == true) then
					if (achieve ~= newachieve) then
						local _, txt = GetAchievementInfo(13279)
						self.UI:AddToScroll(self.UI:CreateHeading(txt))
					end
					self.UI:AddToScroll(self.UI:CreateScrollGroup(PetDailies:IsComplete(newachieve, idx+0), ParsePoint(id)))
				end
				achieve = newachieve
			end

		end

	end
end

HandyNotes_PetDailies.UI = HandyNotes_PetDailies:NewModule("UI", "AceEvent-3.0")
--HandyNotes_PetDailies.UI.PDUI = HandyNotes_PetDailies:GetModule("PDUI")

local AceGUI = LibStub("AceGUI-3.0")
--if not AceGUI then
--    print("no acegui")
--    return
--end

function HandyNotes_PetDailies.UI:OnInitialize()
    self.active_group = false
    self:Build(false)
end

function HandyNotes_PetDailies.UI:Build(withDB)
    local f = AceGUI:Create("Frame")
    f:SetTitle("Pet Dailies")
    f:SetWidth(400)
    f:SetHeight(500)
    f:SetLayout("Fill")
    tinsert(UISpecialFrames, f.frame:GetName())

    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    f:AddChild(container)

    local tabs = AceGUI:Create("TabGroup")
    tabs:SetTabs({
        {text = "All", value = 1},
        {text = "Zone", value = 2 },
        {text = "Achieves", value = 3}
    })
    tabs:SetFullWidth(true)
    tabs:SetCallback("OnGroupSelected", function (container, event, group) self:SelectGroup(container, group) end)
    container:AddChild(tabs)

    self.frame = f
    self.tabs = tabs
    if (withDB) then self:Show()
    else self.frame:Hide()
    end
end

function HandyNotes_PetDailies.UI:ReloadScroll(group)
    if self.scroll then
        self.scroll:ReleaseChildren()
        HandyNotes_PetDailies:BuildData(group)
    end
end

function HandyNotes_PetDailies.UI:Show(group)
    if group ~= nil then
        print("not nil")
    elseif self.active_group == false then
        print("no active")
        group = 1
    else
        print(self.active_group)
        group = self.active_group
    end

    self:SelectTab(group)
    self:ReloadScroll(group)
    self.frame:Show()
end

function HandyNotes_PetDailies.UI:SelectTab(group)
    self.tabs:SelectTab(group)
end

function HandyNotes_PetDailies.UI:SelectGroup(container, group)
    local ht = 500
 
    container:ReleaseChildren()
    self.active_group = group

    --self.frame.statusbar:Hide()
    --self:HideCheckButtons()
--    container:SetLayout("Flow")
    local optionscontainer = AceGUI:Create("SimpleGroup")
    optionscontainer:SetFullWidth(true)
    optionscontainer:SetHeight(ht*.3)
    optionscontainer:SetLayout("Flow")
    container:AddChild(optionscontainer)
    self.options = options
    
    local scrollcontainer = AceGUI:Create("SimpleGroup")
    scrollcontainer:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scrollcontainer:SetLayout("Fill")
    container:AddChild(scrollcontainer)
    
    local scroll = AceGUI:Create("ScrollFrame")
--    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    scrollcontainer:AddChild(scroll)
    self.scroll = scroll
  
    HandyNotes_PetDailies:BuildData(group)
end

function HandyNotes_PetDailies.UI:AddToScroll(f)
    self.scroll:AddChild(f)
end

function HandyNotes_PetDailies.UI:AddToFilter(f)
    self.filter:AddChild(f)
end

function HandyNotes_PetDailies.UI:CreateHeading(text)
    local heading = AceGUI:Create("Heading")
    heading:SetText(text)
    heading:SetFullWidth(true)

    return heading
end

function HandyNotes_PetDailies.UI:CreateScrollLabel(...)
    self:AddToScroll(self:CreateLabel(...))
end
function HandyNotes_PetDailies.UI:CreateDefScrollLabel(...)
    self:AddToScroll(self:CreateDefLabel(...))
end

function HandyNotes_PetDailies.UI:CreateFilterCheckbox(...)
    self:AddToFilter(self:CreateCheckbox(...))
end

function HandyNotes_PetDailies.UI:CreateScrollCheckbox(...)
    self:AddToScroll(self:CreateCheckbox(...))
end

function HandyNotes_PetDailies.UI:CreateFilterDropdown(...)
    self:AddToFilter(self:CreateDropdown(...))
end

function HandyNotes_PetDailies.UI:CreateLabel(text, icon, callbacks)
    local f = AceGUI:Create("WoWMeLabel")
    f:SetHighlight("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    f:SetFontObject(SystemFont_Shadow_Med1)
    f:SetPoint("Top", 10, 10)
    f:SetFullWidth(true)

    if text ~= nil then
        f:SetText(text)
    end
    if icon ~= nil then
        f:SetImage(icon)
        f:SetImageSize(20, 20)
    end

    self:AddCallbacks(f, callbacks)
    return f
end

function HandyNotes_PetDailies.UI:CreateDefLabel(text, icon, callbacks)
    local f = AceGUI:Create("WoWMeLabel")
    f:SetHighlight("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    f:SetFontObject(SystemFont_Shadow_Med1)
    f:SetPoint("Top", 10, 10)
    f:SetFullWidth(true)

    if text ~= nil then
        f:SetText(text)
    end
    if icon ~= nil then
        f:SetImage(icon)
        f:SetImageSize(20, 20)
    end

    self:AddCallbacks(f, callbacks)
    return f
end

function HandyNotes_PetDailies.UI:AddCallbacks(f, callbacks)
    if callbacks ~= nil then
        for i,v in pairs(callbacks) do
            f:SetCallback(i, v)
        end
    end
end

function HandyNotes_PetDailies.UI:CreateCheckbox(label, value, callbacks, max_lines, height, enabled)
    local f = AceGUI:Create("CheckBox")

    if label ~= nil then
        f:SetLabel(label)
    end
    if value ~= nil then
        f:SetValue(value)
    end
    if max_lines ~= nil then
        f.text:SetMaxLines(max_lines)
    end
    if height ~= nil then
        f:SetHeight(height)
    end
    if enabled ~= nil then
        f:SetDisabled(not enabled)
    end

    f:SetFullWidth(true)
    f:SetPoint("Top", 15, 15)
    self:AddCallbacks(f, callbacks)
    return f
end
    
function HandyNotes_PetDailies.UI:CreateButton(text)
    local f = AceGUI:Create("Button")
    f.frame:SetHeight(20)
    f:SetHeight(20)
    f:SetWidth(130)
    f:SetText(text)
--    f:ClearAllPoints()
--    f.buton("BOTTOMRIGHT", f.frame, "BOTTOMRIGHT", -30)
    f:SetCallback("OnClick", function () WayList:Map(id) end)
    return f
end

function HandyNotes_PetDailies.UI:CreateScrollButton( ... )
self:AddToScroll(self:CreateButton(...))
--    local xbutton = self:CreateButton("Set Waypoints", self.scroll)
--    xbutton:SetScript("OnClick", function () WayList:Map(id) end)
--    xbutton:SetWidth(25)
--    xbutton:ClearAllPoints()
--    xbutton:SetPoint("RIGHT")
end

function HandyNotes_PetDailies.UI:CreateDropdown(label, list, value, callbacks, multiselect, order)
    local f = AceGUI:Create("Dropdown")
    f:SetLabel(label)
    f:SetList(list, order)
    if multiselect ~= nil then
        f:SetMultiselect(multiselect)
    end
    f.label:ClearAllPoints()
    f.label:SetPoint("LEFT", 10, 15)
    f.dropdown:ClearAllPoints()
    f.dropdown:SetPoint("TOPLEFT",f.frame,"TOPLEFT",-10,-15)
    f.dropdown:SetPoint("BOTTOMRIGHT",f.frame,"BOTTOMRIGHT",17,0)
    if type(value) == "table" then
        for i = 1,#value do
            f:SetValue(value[i])
            f:SetItemValue(value[i], true)
        end
    else
        f:SetValue(value)
    end

    self:AddCallbacks(f, callbacks)
    return f
end

function HandyNotes_PetDailies.UI:CreateScrollGroup(iscomplete, _,_,tag,i_path,_)

    local l = AceGUI:Create("InteractiveLabel")
    l:SetText(tag)
    if (iscomplete) then l:SetColor(0,153,0) else l:SetColor(255,255,0) end
    l:SetFullWidth(true)
    --l:SetFont(12)
    l:SetImage("interface\\icons\\"..i_path)
    l:SetImageSize(25,25)
    return l

--    opts:SetLayout("Flow")
--    opts:SetWidth(350)
--    opts:ClearAllPoints()
--    opts:SetPoint("LEFT")
--
--    --local _, desc = GetAchievementInfo( id )
--
--    local icon = AceGUI:Create("Icon")
--    icon:SetImage("interface\\icons\\"..i_path)
--    icon:SetImageSize(25,25)--leftContainer.frame:GetWidth()-20, 249)
--    icon:SetDisabled(true)
--    opts:AddChild(icon)
--
--    local f = AceGUI:Create("Label")
--    --    f:SetHighlight("Interface\\QuestFrame\\UI-QuestTitleHighlight")
--    f:SetFontObject(SystemFont_Shadow_Med1)
--    f:SetPoint("LEFT")
--    --    f:SetHeight(15)
--    f:SetRelativeWidth(.9)
--    f:SetText(tag)
--    opts:AddChild( f )

--    local modelContainer = AceGUI:Create("InlineGroup")
--    modelContainer.frame:SetBackdropColor(1,1,1,0)
--    modelContainer:SetWidth(leftContainer.frame:GetWidth()-20)
--    modelContainer:SetHeight(249)
--    modelContainer:SetLayout("Flow")

--    local WayList = WoWMe:GetModule("WayList")
--    local btn = AceGUI:Create("Button")
--    btn:SetHeight(20)
--    btn:SetWidth(130)
--    btn:SetText("Set Waypoints")
--    btn:SetCallback("OnClick", function () WayList:SetWays(id) end)
--    btn:SetPoint("RIGHT")
--    opts:AddChild(btn)

--    return opts
end




local points = PetDailies.points


local ADVENTURE = "9069"
local ARGUS = "12088"
local FAMILY = "12100"
local BATTLER = "13279"
local NUISANCES = "13626"
local MINIONS = "13625"
local EXORCIST = "14879"
local ABHORRENT = "14881"
--local SHBATTLE = "14625"

--To find map id for points[mmm] = /run print(C_Map.GetBestMapForUnit("player"))

--Format: [xxxxyyyy] = "qqqqq.q:tooltip:icon:coin reward:horde or alliance or both"
--xxxx is the x waypoint coordinate as in 33.50
--yyyy is the y waypoint coordinate as in 33.50
--qqqqq.q is the quest id where the decimal portion is the series number if the quest must be in the quest log

-----------------
-- Shadowlands World Quests & Achievements--
-----------------
--Bastion
points[1533] = {
	[34806280] = EXORCIST..".9:Stratios:inv_misc_bag_33:false:both",
--	[34816281] = SHBATTLE..".15:Stratios:inv_misc_bag_33:false:both",
	[51405820] = EXORCIST..".7:Zolla:inv_misc_bag_33:false:both",
--	[51415821] = SHBATTLE..".14:Zolla:inv_misc_bag_33:false:both",
	--[36603180] = SHBATTLE..".16:Jawbone:inv_misc_bag_33:false:both",
	[54605620] = EXORCIST..".8:Thenia:inv_misc_bag_33:false:both",
--	[54615621] = SHBATTLE..".13:Thenia:inv_misc_bag_33:false:both",
	[52607420] = ABHORRENT..".1:Crystalsnap:inv_pet_batpetrevendreth_red:false:both",
	[25803080] = ABHORRENT..".7:Digallo:inv_pet_batpetrevendreth_red:false:both",
	[46604920] = ABHORRENT..".9:Kostos:inv_pet_batpetrevendreth_red:false:both",
}
--Maldraxxus
points[1536] = {
	[46805000] = EXORCIST..".6:Caregiver Maxamillian:inv_misc_bag_33:false:both",
--	[46815001] = SHBATTLE..".12:Caregiver Maxamillian:inv_misc_bag_33:false:both",
	[34005520] = EXORCIST..".4:Rotgut:inv_misc_bag_33:false:both",
--	[34015521] = SHBATTLE..".11:Rotgut:inv_misc_bag_33:false:both",
	[63204680] = EXORCIST..".5:Dundley Stickyfingers:inv_misc_bag_33:false:both",
--	[63214681] = SHBATTLE..".10:Dundley Stickyfingers:inv_misc_bag_33:false:both",
--	[54002800] = SHBATTLE..".9:Gorgemouth:inv_pet_achievement_pandaria:false:both",
	[61807180] = ABHORRENT..".8:Gelatinous:inv_pet_batpetrevendreth_red:false:both",
	[26602680] = ABHORRENT..".10:Glurp:inv_pet_batpetrevendreth_red:false:both",
}
--Revendreth
points[1525] = {
--	[25203800] = SHBATTLE..".8:Scorch:inv_misc_bag_33:false:both",
	[40005260] = EXORCIST..".1:Sylla:inv_misc_bag_33:false:both",
--	[40015261] = SHBATTLE..".7:Sylla:inv_pet_achievement_pandaria:false:both",
	[67606600] = EXORCIST..".2:Eyegor:inv_misc_bag_33:false:both",
--	[67616601] = SHBATTLE..".6:Eyegor:inv_misc_bag_33:false:both",
	[61204100] = EXORCIST..".3:Addius the Tormentor:inv_misc_bag_33:false:both",
--	[61214101] = SHBATTLE..".5:Addius the Tormentor:inv_pet_achievement_pandaria:false:both",
	[25602360] = ABHORRENT..".5:Sewer Creeper:inv_pet_batpetrevendreth_red:false:both",
	[52804160] = ABHORRENT..".6:The Countess:inv_pet_batpetrevendreth_red:false:both",
}
--Ardenweald
points[1565] = {
	[58205680] = EXORCIST..".10:Glitterdust:inv_misc_bag_33:false:both",
--	[58215681] = SHBATTLE..".4:Glitterdust:inv_misc_bag_33:false:both",
--	[40006440] = SHBATTLE..".3:Nightfang:inv_pet_achievement_pandaria:false:both",
	[51204400] = EXORCIST..".11:Faryl:inv_misc_bag_33:false:both",
--	[51214401] = SHBATTLE..".2:Faryl:inv_misc_bag_33:false:both",
--	[40202880] = SHBATTLE..".1:Rascal:inv_misc_bag_33:false:both",
	[26606200] = ABHORRENT..".3:Chittermaw:inv_pet_batpetrevendreth_red:false:both",
	[34204460] = ABHORRENT..".2:Briarpaw:inv_pet_batpetrevendreth_red:false:both",
	[49804160] = ABHORRENT..".4:Mistwing:inv_pet_batpetrevendreth_red:false:both",
}	

-- -- (Beasts of Fable Books)
--------------
-- Tanaan --
--------------
--Tanaan Jungle
points[534] = {
	[26143160] = "39157.0:Felsworn Sentry:inv_misc_bag_33:false:both",
	[15744444] = "39168.0:Bleakclaw:inv_misc_bag_33:false:both",
	[75453736] = "39173.0:Defiled Earth:inv_misc_bag_33:false:both",
	[57733734] = "39165.0:Direflame:inv_misc_bag_33:false:both",
	[54072983] = "39167.0:Dark Gazer:inv_misc_bag_33:false:both",
	[48073302] = "39172.0:Skrillix (Cave):inv_misc_bag_33:false:both",
	[48373547] = "39171.0:Netherfist:inv_misc_bag_33:false:both",
	[31373806] = "39162.0:Cursed Spirit:inv_misc_bag_33:false:both",
	[42237179] = "39166.0:Mirecroak:inv_misc_bag_33:false:both",
	[25047621] = "39161.0:Chaos Pup:inv_misc_bag_33:false:both",
	[44034572] = "39169.0:Vile Blood:inv_misc_bag_33:false:both",
	[43378444] = "39164.0:Tainted Mudclaw:inv_misc_bag_33:false:both",
	[53016521] = "39160.0:Corrupted Thundertail:inv_misc_bag_33:false:both",
	[55908076] = "39163.0:Felfly:inv_misc_bag_33:false:both",
	[47335278] = "39170.0:Dreadwalker:inv_misc_bag_33:false:both"
}

--------------
-- Pandaria --
--------------
--Dreadwastes
points[422] = {
	[26185027] = "32869.1:Gorespine:inv_misc_bag_cenarionherbbag:false:both",
	[26185028] = "32603.2:Gorespine:inv_misc_bag_cenarionherbbag:false:both",
	[61208760] = "32439.0:Flowing Pandaren Spirit:inv_pet_pandarenelemental:false:both",
	[61208761] = ADVENTURE..".15:Flowing Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[55003740] = "31957.0:Grand Master Shu:inv_misc_bag_cenarionherbbag:false:both",
	[55003741] = ADVENTURE..".41:Wastewalker Shu:inv_tailoring_elekkplushie:false:both",
}
--Krasarang
points[418] = {
	[37133351] = "32868.3:Skitterer Xia:inv_misc_bag_cenarionherbbag:false:both",
	[37133352] = "32603.10:Skitterer Xia:inv_misc_bag_cenarionherbbag:false:both",
	[65094274] = "31954.0:Grand Master Mo'ruk:inv_misc_bag_cenarionherbbag:false:both",
	[65094275] = ADVENTURE..".24:Mo'ruk:inv_tailoring_elekkplushie:false:both",
}
--KunLaiSummit
points[379] = {
	[35185617] = "32604.2:Kafi:inv_misc_bag_cenarionherbbag:false:both",
	[67878469] = "32604.3:Dos'Ryga:inv_misc_bag_cenarionherbbag:false:both",
	[35185618] = "32603.7:Kafi:inv_misc_bag_cenarionherbbag:false:both",
	[67878470] = "32603.8:Dos'Ryga:inv_misc_bag_cenarionherbbag:false:both",
	[64809360] = "32441.0:Thundering Pandaren Spirit:inv_pet_pandarenelemental_earth:false:both",
	[64809361] = ADVENTURE..".39:Thundering Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[35807361] = "31956.0:Grand Master Yon:inv_misc_bag_cenarionherbbag:false:both",
	[35807360] = ADVENTURE..".11:Courageous Yon:inv_tailoring_elekkplushie:false:both",
}
--TheJadeForest
points[371] = {
	[48427096] = "32604.1:Ka'wi the Gorger:inv_misc_bag_cenarionherbbag:false:both",
	[57042912] = "32604.4:Nitun:inv_misc_bag_cenarionherbbag:false:both",
	[48427097] = "32603.1:Ka'wi the Gorger:inv_misc_bag_cenarionherbbag:false:both",
	[57042913] = "32603.9:Nitun:inv_misc_bag_cenarionherbbag:false:both",
	[28803600] = "32440.0:Whispering Pandaren Spirit:inv_pet_pandarenelemental_air:false:both",
	[28803601] = ADVENTURE..".42:Whispering Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[48005400] = "31953.0:Grand Master Hyuna:inv_misc_bag_cenarionherbbag:false:both",
	[48005401] = ADVENTURE..".19:Hyuna of the Shrines:inv_tailoring_elekkplushie:false:both",
}
--TownlongSteppes
points[388] = {
	[72267978] = "32869.3:Ti'un the Wanderer:inv_misc_bag_cenarionherbbag:false:both",
	[72267979] = "32603.9:Ti'un the Wanderer:inv_misc_bag_cenarionherbbag:false:both",
	[57004220] = "32434.0:Burning Pandaren Spirit:inv_pet_pandarenelemental_fire:false:both",
	[57004221] = ADVENTURE..".8:Burning Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[36205220] = "31991.0:Grand Master Zusshi:inv_misc_bag_cenarionherbbag:false:both",
	[36205221] = ADVENTURE..".32:Seeker Zusshi:inv_tailoring_elekkplushie:false:both",
}
--Vale of Eternal Blossoms
points[390] = {
	[11007100] = "32869.2:No-No:inv_misc_bag_cenarionherbbag:false:both",
	[11007101] = "32603.3:No-No:inv_misc_bag_cenarionherbbag:false:both",
	[31207420] = "31958.0:Grand Master Aki:inv_misc_bag_cenarionherbbag:false:both",
	[31207421] = ADVENTURE..".1:Aki the Chosen:inv_tailoring_elekkplushie:false:both",
}
--ValleyoftheFourWinds88
points[376] = {
	[25297854] = "32868.1:Greyhoof:inv_misc_bag_cenarionherbbag:false:both",
	[40544367] = "32868.2:Lucky Yi:inv_misc_bag_cenarionherbbag:false:both",
	[25297855] = "32603.4:Greyhoof:inv_misc_bag_cenarionherbbag:false:both",
	[40544368] = "32603.5:Lucky Yi:inv_misc_bag_cenarionherbbag:false:both",
	[46004360] = "31955.0:Grand Master Nishi:inv_misc_bag_cenarionherbbag:false:both",
	[46004361] = ADVENTURE..".14:Farmer Nishi:inv_tailoring_elekkplushie:false:both",
}

--Other Bags
--Winterspring
points[83] = {
	[65606440] =	"31909.0:Stone Cold Trixxy:inv_misc_bag_cenarionherbbag:false:both",
	[65606441] =	ADVENTURE..".34:Stone Cold Trixxy:inv_tailoring_elekkplushie:false:both",
}
--Uldum
points[249] = {
	[56604180] =	"31971.0:Obalis:inv_misc_bag_cenarionherbbag:false:both",
	[56604181] =	ADVENTURE..".29:Obalis:inv_tailoring_elekkplushie:false:both",
}
--IcecrownGlacier
points[118] = {
	[77401960] =	"31935.0:Major Payne:inv_misc_bag_cenarionherbbag:false:both",
	[77401961] =	ADVENTURE..".23:Major Payne:inv_tailoring_elekkplushie:false:both",
}
--ShadowmoonValley
points[104] = {
	[30404180] =	"31926.0:Blood Master Antari:inv_misc_bag_cenarionherbbag:false:both",
	[30404181] =	ADVENTURE..".5:Bloodknight Antari:inv_tailoring_elekkplushie:false:both",
}
--DeadwindPass
points[42] = {
	[40207640] =	"31916.0:Lydia Accoste:inv_misc_bag_cenarionherbbag:false:both",
	[40207641] =	ADVENTURE..".22:Lydia Accoste:inv_tailoring_elekkplushie:false:both",
}
--TimelessIsle
points[554] = {
	[34805960] =	"33137.0:Celestial Tournament:inv_misc_trinketpanda_07:false:both",
	[34805964] =	ADVENTURE..".4:Blingtron 4000:inv_tailoring_elekkplushie:false:both",
	[34805969] =	ADVENTURE..".9:Chen Stormstout:inv_tailoring_elekkplushie:false:both",
	[34805963] =	ADVENTURE..".13:Dr. Ion Goldbloom:inv_tailoring_elekkplushie:false:both",
	[34805961] =	ADVENTURE..".21:Lorewalker Cho:inv_tailoring_elekkplushie:false:both",
	[34805962] =	ADVENTURE..".33:Shademaster Kiryn:inv_tailoring_elekkplushie:false:both",
	[34805965] =	ADVENTURE..".35:Sully \"The Pickle\" McLeary:inv_tailoring_elekkplushie:false:both",
	[34805967] =	ADVENTURE..".37:Taran Zhu:inv_tailoring_elekkplushie:false:both",
	[34805966] =	ADVENTURE..".43:Wise Mari:inv_tailoring_elekkplushie:false:both",
	[34805968] =	ADVENTURE..".44:Wrathion:inv_tailoring_elekkplushie:false:both",
}
--CelestialChallenge
points[571] = {
	[40005640] =	ADVENTURE..".4:Blingtron 4000:inv_tailoring_elekkplushie:false:both",
	[40405660] =	ADVENTURE..".9:Chen Stormstout:inv_tailoring_elekkplushie:false:both",
	[40205620] =	ADVENTURE..".13:Dr. Ion Goldbloom:inv_tailoring_elekkplushie:false:both",
	[40005260] =	ADVENTURE..".21:Lorewalker Cho:inv_tailoring_elekkplushie:false:both",
	[37805720] =	ADVENTURE..".33:Shademaster Kiryn:inv_tailoring_elekkplushie:false:both",
	[37805721] =	ADVENTURE..".35:Sully \"The Pickle\" McLeary:inv_tailoring_elekkplushie:false:both",
	[40005261] =	ADVENTURE..".37:Taran Zhu:inv_tailoring_elekkplushie:false:both",
	[40005262] =	ADVENTURE..".43:Wise Mari:inv_tailoring_elekkplushie:false:both",
	[37805722] =	ADVENTURE..".44:Wrathion:inv_tailoring_elekkplushie:false:both"
}
--Northern Barrens
points[10] = {
	[38806820] =    "45539.0:Wailing Caverns Dungeon:inv_misc_bag_bigbagofenchantments:false:both",
	[63603580] = 	"45083.0:Crysa:inv_misc_bag_12:false:both",
	[58605300] = 	"31819.0:Dagra the Fierce:inv_misc_coin_01:true:horde",
}
--Westfall
points[52] = {
	[41407120] = 	"46292.0:Pet Challenge Deadmines:timelesscoin-bloody:false:both",
	--starting Alliance only coin rewards
	[60801860] = 	"31780.0:Old MacDonald:inv_misc_coin_01:true:alliance",
}
--Elwynn Forest
points[37] = {
	[41608360] = 	"31693.0:Julia Stevens:inv_misc_coin_02:true:alliance",
}
--Redridge Mountains
points[49] = {
	[33205260] = 	"31781.0:Lindsay:inv_misc_coin_01:true:alliance",
}
--Duskwood
points[47] = {
	[19804480] = 	"31850.0:Eric Davidson:inv_misc_coin_01:true:alliance",
}
--Northern Stranglethorn
points[50] = {
	[46004040] = 	"31852.0:Steven Lisbane:inv_misc_coin_01:true:alliance",
}
--TheCapeOfStranglethorn
points[210] = {
	[51407320] = 	"31851.0:Bill Buckler:inv_misc_coin_01:true:alliance",
}
--Hinterlands
points[26] = {
	[62805460] = 	"31910.0:David Kosse:inv_misc_coin_01:true:alliance",
}
--EasternPlaguelands
points[23] = {
	[67005240] = 	"31911.0:Deiza Plaguehorn:inv_misc_coin_01:true:alliance",
}
--Dun Morogh
points[30] = {
	[31407160] = 	"54186.0:Pet Challenge Gnomeregan:inv_misc_enggizmos_35:false:both"
}
points[27] = {
	[30003500] = 	"54186.0:Pet Challenge Gnomeregan:inv_misc_enggizmos_35:false:both"
}
--Searing Gorge
points[32] = {
	[35402780] = 	"31912.0:Kortas Darkhammer:inv_misc_coin_01:true:alliance",
}
--SwampOfSorrows
points[51] = {
	[76604140] = 	"31913.0:Everessa:inv_misc_coin_01:true:alliance",
}
--Burning Steppes
points[36] = {
	[25604760] = 	"31914.0:Durin Darkhammer:inv_misc_coin_01:true:alliance",
}

--Starting Horde only coin rewards
--Durotar
points[1] = {
	[43802880] = 	"31818.0:Zunta:inv_misc_coin_02:true:horde",
}
--Ashenvale
points[63] = {
	[20202960] = 	"31854.0:Analynn:inv_misc_coin_01:true:horde",
}
--Stonetalon
points[65] = {
	[59607160] = 	"31862.0:Zonya the Sadist:inv_misc_coin_01:true:horde",
}
--Desolace
points[66] = {
	[57204580] = 	"31872.0:Merda Stronghoof:inv_misc_coin_01:true:horde",
}
--SouthernBarrens
points[199] = {
	[39607920] = 	"31904.0:Cassandra Kaboom:inv_misc_coin_01:true:horde",
}
--Feralas
points[69] = {
	[59604960] = 	"31871.0:Traitor Gluk:inv_misc_coin_01:true:horde",
}
--Dustwallow
points[70] = {
	[53807480] = 	"31905.0:Grazzle the Great:inv_misc_coin_01:true:horde",
}
--ThousandNeedles
points[64] = {
	[31803280] = 	"31906.0:Kela Grimtotem:inv_misc_coin_01:true:horde",
}
--Felwood
points[77] = {
	[40005660] = 	"31907.0:Zoltan:inv_misc_coin_01:true:horde",
}
--Moonglade
points[80] = {
	[46006040] = 	"31908.0:Elena Flutterfly:inv_misc_coin_01:true:horde",
}
--Starting coin rewards for both
--Hellfire
points[100] = {
	[64404920] = 	"31922.0:Nicki Tinytech:inv_misc_coin_01:true:both",
	[64404921] =	ADVENTURE..".28:Nicki Tinytech:inv_tailoring_elekkplushie:false:both",
}
--Zangarmarsh
points[102] = {
	[17205040] = 	"31923.0:Ras'an:inv_misc_coin_01:true:both",
	[17205041] =	ADVENTURE..".31:Ras'an:inv_tailoring_elekkplushie:false:both",
}
--Nagrand
points[107] = {
	[61004940] = 	"31924.0:Narrok:inv_misc_coin_01:true:both",
	[61004941] =	ADVENTURE..".26:Narrok:inv_tailoring_elekkplushie:false:both",
}
--ShattrathCity
points[111] = {
	[59007000] = 	"31925.0:Morulu The Elder:inv_misc_coin_01:true:both",
	[59007001] =	ADVENTURE..".25:Morulu the Elder:inv_tailoring_elekkplushie:false:both",
}
--Deepholm
points[207] = {
	[49805700] = 	"31973.0:Bordin Steadyfist:inv_misc_coin_01:true:both",
	[49805701] =	ADVENTURE..".6:Bordin Steadyfist:inv_tailoring_elekkplushie:false:both",
}
--Hyjal
points[198] = {
	[61403280] = 	"31972.0:Brok:inv_misc_coin_01:true:both",
	[61403281] =	ADVENTURE..".7:Brok:inv_tailoring_elekkplushie:false:both",
}
--TwilightHighlands
points[241] = {
	[56605680] = 	"31974.0:Goz Banefury:inv_misc_coin_01:true:both",
	[56605681] =	ADVENTURE..".17:Goz Banefury:inv_tailoring_elekkplushie:false:both",
}
--HowlingFjord
points[117] = {
	[28603380] = 	"31931.0:Beegle Blastfuse:inv_misc_coin_01:true:both",
	[28603381] =	ADVENTURE..".3:Beegle Blastfuse:inv_tailoring_elekkplushie:false:both",
}
--ZulDrak
points[121] = {
	[13206680] = 	"31934.0:Gutretch:inv_misc_coin_01:true:both",
	[13206681] =	ADVENTURE..".18:Gutretch:inv_tailoring_elekkplushie:false:both",
}
--CrystalsongForest
points[127] = {
	[50205900] = 	"31932.0:Nearly Headless Jacob:inv_misc_coin_01:true:both",
	[50205901] =	ADVENTURE..".27:Nearly Headless Jacob:inv_tailoring_elekkplushie:false:both",
}
--Dragonblight
points[115] = {
	[59007700] = 	"31933.0:Okrut Dragonwaste:inv_misc_coin_01:true:both",
	[59007701] =	ADVENTURE..".30:Okrut Dragonwaste:inv_tailoring_elekkplushie:false:both",
}
--Tokens
points[539] = {
	[50003120] =	"37203.0:Ashlei:achievement_guildperk_honorablemention:false:both",
	[50003121] =	ADVENTURE..".2:Ashlei:inv_tailoring_elekkplushie:false:both",

}
--SpiresOfArak
points[542] = {
	[46204540] =	"37207.0:Vesharr:achievement_guildperk_honorablemention:false:both",
	[46204541] =	ADVENTURE..".40:Vesharr:inv_tailoring_elekkplushie:false:both",
}
--Talador
points[535] = {
	[49008040] =	"37208.0:Taralune:achievement_guildperk_honorablemention:false:both",
	[49008041] =	ADVENTURE..".36:Taralune:inv_tailoring_elekkplushie:false:both",
}
--NagrandDraenor
points[550] = {
	[56200980] =	"37206.0:Tarr the Terrible:achievement_guildperk_honorablemention:false:both",
	[56200981] =	ADVENTURE..".38:Tarr the Terrible:inv_tailoring_elekkplushie:false:both",
}
--FrostfireRidge88
points[525] = {
	[68606460] =	"37205.0:Gargra:achievement_guildperk_honorablemention:false:both",
	[68606461] =	ADVENTURE..".16:Gargra:inv_tailoring_elekkplushie:false:both",
}
--Gorgrond
points[543] = {
	[51007060] =	"37201.0:Cymre Brightblade:achievement_guildperk_honorablemention:false:both",
	[51007061] =	ADVENTURE..".12:Cymre Brightblade:inv_tailoring_elekkplushie:false:both",
}
--Garrison Alliance
points[579] = {
	[28803920] = "36483.0:Battle Pet Roundup:achievement_guildperk_honorablemention:false:both",
	[29904040] = "38299.0:Erris the Collector:inv_misc_bag_22:false:both",
}
--Frostwall
points[590] = {
	[32404240] = "36483.0:Battle Pet Roundup:achievement_guildperk_honorablemention:false:horde",
	[33604240] = "38299.0:Kura Thunderhoof:inv_misc_bag_22:false:horde",
}
--Azsuna
points[630] = {
	[49504530] = "40310.0:Shipwrecked Captive (Sternfathom's Journal):achievement_guildperk_honorablemention:false:both",
}
--DarkmoonFaireIsland
points[407] = {
	[47206260] ="32175.0:Jeremy Feasel:Inv_misc_bag_felclothbag:false:both",
	[47206261] =ADVENTURE..".20:Jeremy Feasel:inv_tailoring_elekkplushie:false:both",
	[47406220] = "36471.0:Christoph VonFeasel:inv_misc_bag_31:false:both",
	[47406221] = ADVENTURE..".10:Christoph VonFeasel:inv_tailoring_elekkplushie:false:both",
}
--Krokuun
points[830] = {
	[66807270] = ARGUS..".1:Ruinhoof:icon_podlinggold:false:both",
	[66807271] = FAMILY..".1:Ruinhoof:inv_argustalbukmount_felred:false:both",
	[51506380] = ARGUS..".2:Foulclaw:icon_podlinggold:false:both",
	[51506381] = FAMILY..".2:Foulclaw:inv_argustalbukmount_felred:false:both",
	[43005200] = ARGUS..".3:Baneglow:icon_podlinggold:false:both",
	[43005201] = FAMILY..".3:Baneglow:inv_argustalbukmount_felred:false:both",
	[58003000] = ARGUS..".4:Retch:icon_podlinggold:false:both",
	[58053001] = FAMILY..".4:Retch:inv_argustalbukmount_felred:false:both",
	[30005850] = ARGUS..".5:Deathscreech:icon_podlinggold:false:both",
	[30005851] = FAMILY..".5:Deathscreech:inv_argustalbukmount_felred:false:both",
	[40006600] = ARGUS..".6:Gnasher:icon_podlinggold:false:both",
	[40006601] = FAMILY..".6:Gnasher:inv_argustalbukmount_felred:false:both"
}
--Antoran Wastes
points[885] = {
	[51604140] = ARGUS..".13:Watcher:icon_podlinggold:false:both",
	[51604141] = FAMILY..".13:Watcher:inv_argustalbukmount_felred:false:both",
	[56605430] = ARGUS..".14:Bloat:icon_podlinggold:false:both",
	[56605431] = FAMILY..".14:Bloat:inv_argustalbukmount_felred:false:both",
	[56102870] = ARGUS..".15:Earseeker:icon_podlinggold:false:both",
	[56102871] = FAMILY..".15:Earseeker:inv_argustalbukmount_felred:false:both",
	[64006590] = ARGUS..".16:Pilfer:icon_podlinggold:false:both",
	[64006591] = FAMILY..".16:Pilfer:inv_argustalbukmount_felred:false:both",
	[76607410] = ARGUS..".17:Minixis:icon_podlinggold:false:both",
	[76607411] = FAMILY..".17:Minixis:inv_argustalbukmount_felred:false:both",
	[59904030] = ARGUS..".18:One-of-Many:icon_podlinggold:false:both",
	[59904031] = FAMILY..".18:One-of-Many:inv_argustalbukmount_felred:false:both"
}
--ArgusMacAree
points[882] = {
	[67604390] = ARGUS..".7:Bucky:icon_podlinggold:false:both",
	[67604391] = FAMILY..".7:Bucky:inv_argustalbukmount_felred:false:both",
	[69705190] = ARGUS..".8:Snozz:icon_podlinggold:false:both",
	[69705191] = FAMILY..".8:Snozz:inv_argustalbukmount_felred:false:both",
	[60007110] = ARGUS..".9:Gloamwing:icon_podlinggold:false:both",
	[60007111] = FAMILY..".9:Gloamwing:inv_argustalbukmount_felred:false:both",
	[36005410] = ARGUS..".10:Shadeflicker:icon_podlinggold:false:both",
	[36005411] = FAMILY..".10:Shadeflicker:inv_argustalbukmount_felred:false:both",
	[31903120] = ARGUS..".11:Corrupted Blood of Argus:icon_podlinggold:false:both",
	[31903121] = FAMILY..".11:Corrupted Blood of Argus:inv_argustalbukmount_felred:false:both",
	[74703620] = ARGUS..".12:Mar'cuus:icon_podlinggold:false:both",
	[74703621] = FAMILY..".12:Mar'cuus:inv_argustalbukmount_felred:false:both"
}
--Drustvar
points[896] = {
	[21406640] = BATTLER..".1:Captain Hermes:inv_komododragon_gilaorange:false:both",
	[63605960] = BATTLER..".3:Dilbert McClint:inv_komododragon_gilaorange:false:both",
	[38203860] = BATTLER..".4:Fizzie Sparkwhistle:inv_komododragon_gilaorange:false:both",
	[61001760] = BATTLER..".5:Michael Skarn:inv_komododragon_gilaorange:false:both",
}
--Stromsong Valley
points[942] = {
	[77202900] = BATTLER..".7:Leana Darkwind:inv_komododragon_gilaorange:false:both",
	[36603360] = BATTLER..".2:Eddie Fixit:inv_komododragon_gilaorange:false:both",
	[65005080] = BATTLER..".6:Ellie Vern:inv_komododragon_gilaorange:false:both",
}
--Tiragarde Sound
points[895] = {
	[86203860] = BATTLER..".8:Kwint:inv_komododragon_gilaorange:false:both",
	[59603320] = BATTLER..".9:Delia Hanako:inv_komododragon_gilaorange:false:both",
	[67601280] = BATTLER..".10:Burly:inv_komododragon_gilaorange:false:both",
}
--Zuldazar
points[862] = {
	[70602960] = BATTLER..".17:Karaga:inv_komododragon_gilaorange:false:both",
	[48403500] = BATTLER..".18:Talia Sparkbrow:inv_komododragon_gilaorange:false:both",
	[50602400] = BATTLER..".19:Zujal:inv_komododragon_gilaorange:false:both",
}
--Nazmir
points[863] = {
	[72804860] = BATTLER..".11:Lozu:inv_komododragon_gilaorange:false:both",
	[43003880] = BATTLER..".13:Korval Darkbeard:inv_komododragon_gilaorange:false:both",
	[36005460] = BATTLER..".12:Grady Prett:inv_komododragon_gilaorange:false:both",
}
--Vol'dun
points[864] = {
	[26605480] = BATTLER..".15:Sizzik:inv_komododragon_gilaorange:false:both",
	[45004640] = BATTLER..".16:Kusa:inv_komododragon_gilaorange:false:both",
	[57004900] = BATTLER..".14:Keeyo:inv_komododragon_gilaorange:false:both",
}

--Nazjatar
points[1355]= {
	[34702740] = NUISANCES..".1:Prince Wiggletail:inv_seasnail_bluepink:false:both",
	[71905110] = NUISANCES..".2:Chomp:inv_seasnail_bluepink:false:both",
	[58304810] = NUISANCES..".3:Silence:inv_seasnail_bluepink:false:both",
	[42201400] = NUISANCES..".4:Shadowspike Lurker:inv_seasnail_bluepink:false:both",
	[50605030] = NUISANCES..".5:Pearlhusk Crawler:inv_seasnail_bluepink:false:both",
	[51307500] = NUISANCES..".6:Elderspawn of Nalaada:inv_seasnail_bluepink:false:both",
	[29604970] = NUISANCES..".7:Ravenous Scalespawn:inv_seasnail_bluepink:false:both",
	[56400810] = NUISANCES..".8:Mindshackle:inv_seasnail_bluepink:false:both",
	[46602800] = NUISANCES..".9:Kelpstone:inv_seasnail_bluepink:false:both",
	[37501670] = NUISANCES..".10:Voltgorger:inv_seasnail_bluepink:false:both",
	[59102660] = NUISANCES..".11:Frenzied Knifefang:inv_seasnail_bluepink:false:both",
	[28102670] = NUISANCES..".12:Giant Opaline Conch:inv_seasnail_bluepink:false:both"
}

--Mechagon
points[1462] = {
	[64706460] = MINIONS..".1:Gnomefeaster:inv_mechanicalprairiedog_black:false:both",
	[60704650] = MINIONS..".2:Sputtertube:inv_mechanicalprairiedog_black:false:both",
	[60605690] = MINIONS..".3:Goldenbot XD:inv_mechanicalprairiedog_black:false:both",
	[59205090] = MINIONS..".4:Creakclank:inv_mechanicalprairiedog_black:false:both",
	[65405770] = MINIONS..".5:CK-9:inv_mechanicalprairiedog_black:false:both",
	[51104540] = MINIONS..".6:Unit 35:inv_mechanicalprairiedog_black:false:both",
	[39504010] = MINIONS..".7:Unit 6:inv_mechanicalprairiedog_black:false:both",
	[72107290] = MINIONS..".8:Unit 17:inv_mechanicalprairiedog_black:false:both"
}


HandyNotes_PetDailies.points = points