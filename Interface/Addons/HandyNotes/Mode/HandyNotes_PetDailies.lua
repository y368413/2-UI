
------------------------------------------
--  This addon was heavily inspired by  --
--    HandyNotes_SummerFestival         --
--  by Ethan Centaurai                  --
------------------------------------------


-- declaration
local HandyNotes_PetDailies = {}
HandyNotes_PetDailies.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }

-- upvalues
local _G = getfenv(0)
--quest #, optional achievement progress index, text, icon
local point_format = "(%d+)\.([0-9]+):(.+):(.+):(.+):(.*)";

local GameTooltip = _G.GameTooltip
local GetQuestLogIndexByID = _G.GetQuestLogIndexByID
local GetQuestLogLeaderBoard = _G.GetQuestLogLeaderBoard
local IsQuestFlaggedCompleted = _G.IsQuestFlaggedCompleted
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

local points = HandyNotes_PetDailies.points
local ADVENTURE = 9069
local ARGUS = 12088
local FAMILY = 12100
local FAMILYALL = {12089,12091,12092,12093,12094,12095,12096,12097,12098,12099 }
local BATTLER = 13279
local BATTLERALL = {13270, 13271, 13272, 13273, 13274, 13275, 13277, 13278, 13280, 13281 }
local NUISANCES = 13626
local MINIONS = 13625

local playerfaction = UnitFactionGroup("PLAYER")
local function showhorde()
    return playerfaction == "Horde"
end

local function showally()
    return playerfaction == "Alliance"
end



---- check
--local setEnabled = false
--local function CheckEventActive()
--	local _, month, day, year = CalendarGetDate()
--	local curMonth, curYear = CalendarGetMonth()
--	local monthOffset = -12 * (curYear - year) + month - curMonth
--	local numEvents = CalendarGetNumDayEvents(monthOffset, day)
--
--	for i=1, numEvents do
--		local _, eventHour, _, eventType, state, _, texture = CalendarGetDayEvent(monthOffset, day, i)
--
--		if texture == 235548 or texture == 235447 or texture == 235446 then
--			if state == "ONGOING" then
--				setEnabled = true
--			else
--				local hour = GetGameTime()
--
--				if state == "END" and hour <= eventHour or state == "START" and hour >= eventHour then
--					setEnabled = true
--				else
--					setEnabled = false
--				end
--			end
--		end
--	end
--end


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

function HandyNotes_PetDailies:OnEnter(mapFile, coord)
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
			and not IsArgus(questID) and not IsNuisances(questID) and not IsMinions(questID)) then
        if (GetQuestLogIndexByID(questID) > 0) then return true
        else return false
        end
    else return true --shouldn't be logged so just say it is
    end
end

local function IsComplete(questID, questIndex)

	if (questIndex > 0 and not IsAdventure(questID) and not IsFamily(questID) and not IsBattler(questID)
			and not IsArgus(questID) and not IsNuisances(questID) and not IsMinions(questID)) then
		if (IsLogged(questID, questIndex)) then
            local _,_,done = GetQuestLogLeaderBoard(questIndex,GetQuestLogIndexByID(questID))
            return done
        else return true
        end
	elseif (IsAdventure(questID) or IsFamily(questID) or IsArgus(questID) or IsBattler(questID) or IsNuisances(questID)
			or IsMinions(questID)) then return false
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

local function IsCoin( coinReward )
    return (coinReward=="true")
end


local function MatchesFaction( faction )
    return ( (faction == "both") or (faction == "horde" and showhorde() or (faction == "alliance" and showally())) )
end

local function ShouldBeShown( questStr )
    local questID, questIndex, _, _, coinReward, faction = questStr:match(point_format)
	questID = tonumber(questID)
	questIndex = tonumber(questIndex)
    return IsLogged(questID, questIndex) -- true if it doesn't need to be logged or it is still in log
        and (db.completed or not IsComplete(questID, questIndex) -- true if you want to show complete or it's not complete
		and (not IsAdventure(questID) or not IsAdventureComplete(questID, questIndex)) -- true if it isn't the Adventure achievement or it isn't completed for Adventure
		and (not IsArgus(questID) or not IsArgusComplete(questID, questIndex)) -- true if it isn't the Argus achievement or it isn't completed for Argus
		and (not IsMinions(questID) or not IsMinionsComplete(questID, questIndex)) -- true if it isn't the Minions achievement or it isn't completed for Minions
		and (not IsNuisances(questID) or not IsNuisancesComplete(questID, questIndex)) -- true if it isn't the Nuisances achievement or it isn't completed for Nuisances
		and (not IsBattler(questID) or not IsBattlerComplete(questID, questIndex)) -- true if it isn't the Family Battler achievement or it isn't completed for Battler
		and (db.coins or not IsCoin(coinReward)) -- true if you want to show coins or it isn't a coin
        and (MatchesFaction(faction))) -- true if it is your faction or if it doesn't matter
    end

function HandyNotes_PetDailies:OnLeave()
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
			if ( coord and ShouldBeShown(questStr) ) then
				createWaypoint(mapFile, coord)
			end
		end
	end
end

function HandyNotes_PetDailies:OnClick(button, down, uMapID, coord)
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

		if not HandyNotes_PetDailies.isEnabled then return nil end

		if not t then return nil end

		local state, value = next(t, prestate)

		while state do -- have we reached the end of this zone?
			local _, _, _, iconstr, _ = value:match(point_format)
			local icon = "interface\\icons\\"..iconstr
			if ShouldBeShown(value) then
				return state, mapFile, icon, db.icon_scale, db.icon_alpha
			end

			state, value = next(t, state) -- get next data
		end

		return nil, nil, nil, nil
	end

	local function iterCont(t, prestate)
		if not HandyNotes_PetDailies.isEnabled then return nil end
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
					if (ShouldBeShown(value)) then
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

	function HandyNotes_PetDailies:GetNodes2(uiMapID, miniMap)
		local C = HandyNotes:GetContinentZoneList(uiMapID) -- Is this a continent?
		if C then
			local tbl = { C = C, Z = next(C) }
			return iterCont, tbl, nil
		else
			--mapFile = gsub(mapFile, "_terrain%d+$", "")
			return iter, points[uiMapID], nil
		end
	end
--	function HandyNotes_PetDailies:GetNodes(mapFile)
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
		HandyNotes_PetDailies:Refresh()
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
			desc = "Show icons for pet tamers you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "nuisances",
			order = 5,
		},
		minions = {
			name = "Show Mighty Minions of Mechagon",
			desc = "Show icons for pet tamers you haven't defeated for this achievement.",
			type = "toggle",
			width = "full",
			arg = "minions",
			order = 6,
		},
        desc = {
            name = "These settings control the look and feel of the icon.",
            type = "description",
            order = 7,
        },		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "Change the size of the icons.",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 8,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "Change the transparency of the icons.",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 9,
		},
	},
}

-- initialise
function HandyNotes_PetDailies:OnEnable()
	self.isEnabled = true

--	local HereBeDragons = LibStub("HereBeDragons-1.0", true)
--	if not HereBeDragons then
--		HandyNotes:Print("Your installed copy of HandyNotes is out of date and the Pet Dailies plug-in will not work correctly.  Please update HandyNotes to version 1.4.0 or newer.")
--		return
--	end

--	local _, month, _, year = CalendarGetDate()
--	CalendarSetAbsMonth(month, year)

	HandyNotes:RegisterPluginDB("HandyNotes_PetDailies", self, options)

	db = LibStub("AceDB-3.0"):New("HandyNotes_PetDailiesDB", defaults, "Default").profile
end

function HandyNotes_PetDailies:Refresh(_, _)
	self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_PetDailies")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(HandyNotes_PetDailies, "HandyNotes_PetDailies", "AceEvent-3.0")


local ADVENTURE = "9069"
local ARGUS = "12088"
local FAMILY = "12100"
local BATTLER = "13279"
local NUISANCES = "13626"
local MINIONS = "13625"

--To find map id for points[mmm] = /run print(C_Map.GetBestMapForUnit("player"))

--Format: [xxxxyyyy] = "qqqqq.q:tooltip:icon:coin reward:horde or alliance or both"
--xxxx is the x waypoint coordinate as in 33.50
--yyyy is the y waypoint coordinate as in 33.50
--qqqqq.q is the quest id where the decimal portion is the series number if the quest must be in the quest log
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
	[61208761] = "9069.15:Flowing Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[55003740] = "31957.0:Grand Master Shu:inv_misc_bag_cenarionherbbag:false:both",
	[55003741] = "9069.41:Wastewalker Shu:inv_tailoring_elekkplushie:false:both",
}
--Krasarang
points[418] = {
	[37133351] = "32868.3:Skitterer Xia:inv_misc_bag_cenarionherbbag:false:both",
	[37133352] = "32603.10:Skitterer Xia:inv_misc_bag_cenarionherbbag:false:both",
	[65094274] = "31954.0:Grand Master Mo'ruk:inv_misc_bag_cenarionherbbag:false:both",
	[65094275] = "9069.24:Mo'ruk:inv_tailoring_elekkplushie:false:both",
}
--KunLaiSummit
points[379] = {
	[35185617] = "32604.2:Kafi:inv_misc_bag_cenarionherbbag:false:both",
	[67878469] = "32604.3:Dos'Ryga:inv_misc_bag_cenarionherbbag:false:both",
	[35185618] = "32603.7:Kafi:inv_misc_bag_cenarionherbbag:false:both",
	[67878470] = "32603.8:Dos'Ryga:inv_misc_bag_cenarionherbbag:false:both",
	[64809360] = "32441.0:Thundering Pandaren Spirit:inv_pet_pandarenelemental_earth:false:both",
	[64809361] = "9069.39:Thundering Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[35807361] = "31956.0:Grand Master Yon:inv_misc_bag_cenarionherbbag:false:both",
	[35807360] = "9069.11:Courageous Yon:inv_tailoring_elekkplushie:false:both",
}
--TheJadeForest
points[371] = {
	[48427096] = "32604.1:Ka'wi the Gorger:inv_misc_bag_cenarionherbbag:false:both",
	[57042912] = "32604.4:Nitun:inv_misc_bag_cenarionherbbag:false:both",
	[48427097] = "32603.1:Ka'wi the Gorger:inv_misc_bag_cenarionherbbag:false:both",
	[57042913] = "32603.9:Nitun:inv_misc_bag_cenarionherbbag:false:both",
	[28803600] = "32440.0:Whispering Pandaren Spirit:inv_pet_pandarenelemental_air:false:both",
	[28803601] = "9069.42:Whispering Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[48005400] = "31953.0:Grand Master Hyuna:inv_misc_bag_cenarionherbbag:false:both",
	[48005401] = "9069.19:Hyuna of the Shrines:inv_tailoring_elekkplushie:false:both",
}
--TownlongSteppes
points[388] = {
	[72267978] = "32869.3:Ti'un the Wanderer:inv_misc_bag_cenarionherbbag:false:both",
	[72267979] = "32603.9:Ti'un the Wanderer:inv_misc_bag_cenarionherbbag:false:both",
	[57004220] = "32434.0:Burning Pandaren Spirit:inv_pet_pandarenelemental_fire:false:both",
	[57004221] = "9069.8:Burning Pandaren Spirit:inv_tailoring_elekkplushie:false:both",
	[36205220] = "31991.0:Grand Master Zusshi:inv_misc_bag_cenarionherbbag:false:both",
	[36205221] = "9069.32:Seeker Zusshi:inv_tailoring_elekkplushie:false:both",
}
--Vale of Eternal Blossoms
points[390] = {
	[11007100] = "32869.2:No-No:inv_misc_bag_cenarionherbbag:false:both",
	[11007101] = "32603.3:No-No:inv_misc_bag_cenarionherbbag:false:both",
	[31207420] = "31958.0:Grand Master Aki:inv_misc_bag_cenarionherbbag:false:both",
	[31207421] = "9069.1:Aki the Chosen:inv_tailoring_elekkplushie:false:both",
}
--ValleyoftheFourWinds88
points[376] = {
	[25297854] = "32868.1:Greyhoof:inv_misc_bag_cenarionherbbag:false:both",
	[40544367] = "32868.2:Lucky Yi:inv_misc_bag_cenarionherbbag:false:both",
	[25297855] = "32603.4:Greyhoof:inv_misc_bag_cenarionherbbag:false:both",
	[40544368] = "32603.5:Lucky Yi:inv_misc_bag_cenarionherbbag:false:both",
	[46004360] = "31955.0:Grand Master Nishi:inv_misc_bag_cenarionherbbag:false:both",
	[46004361] = "9069.14:Farmer Nishi:inv_tailoring_elekkplushie:false:both",
}

--Other Bags
--Winterspring
points[83] = {
	[65606440] =	"31909.0:Stone Cold Trixxy:inv_misc_bag_cenarionherbbag:false:both",
	[65606441] =	"9069.34:Stone Cold Trixxy:inv_tailoring_elekkplushie:false:both",
}
--Uldum
points[249] = {
	[56604180] =	"31971.0:Obalis:inv_misc_bag_cenarionherbbag:false:both",
	[56604181] =	"9069.29:Obalis:inv_tailoring_elekkplushie:false:both",
}
--IcecrownGlacier
points[118] = {
	[77401960] =	"31935.0:Major Payne:inv_misc_bag_cenarionherbbag:false:both",
	[77401961] =	"9069.23:Major Payne:inv_tailoring_elekkplushie:false:both",
}
--ShadowmoonValley
points[539] = {
	[30404180] =	"31926.0:Blood Master Antari:inv_misc_bag_cenarionherbbag:false:both",
	[30404181] =	"9069.5:Bloodknight Antari:inv_tailoring_elekkplushie:false:both",
}
--DeadwindPass
points[42] = {
	[40207640] =	"31916.0:Lydia Accoste:inv_misc_bag_cenarionherbbag:false:both",
	[40207641] =	"9069.22:Lydia Accoste:inv_tailoring_elekkplushie:false:both",
}
--TimelessIsle
points[554] = {
	[34805960] =	"33137.0:Celestial Tournament:inv_misc_trinketpanda_07:false:both",
	[34805964] =	"9069.4:Blingtron 4000:inv_tailoring_elekkplushie:false:both",
	[34805969] =	"9069.9:Chen Stormstout:inv_tailoring_elekkplushie:false:both",
	[34805963] =	"9069.13:Dr. Ion Goldbloom:inv_tailoring_elekkplushie:false:both",
	[34805961] =	"9069.21:Lorewalker Cho:inv_tailoring_elekkplushie:false:both",
	[34805962] =	"9069.33:Shademaster Kiryn:inv_tailoring_elekkplushie:false:both",
	[34805965] =	"9069.35:Sully \"The Pickle\" McLeary:inv_tailoring_elekkplushie:false:both",
	[34805967] =	"9069.37:Taran Zhu:inv_tailoring_elekkplushie:false:both",
	[34805966] =	"9069.43:Wise Mari:inv_tailoring_elekkplushie:false:both",
	[34805968] =	"9069.44:Wrathion:inv_tailoring_elekkplushie:false:both",
}
--CelestialChallenge
points[571] = {
	[40005640] =	"9069.4:Blingtron 4000:inv_tailoring_elekkplushie:false:both",
	[40405660] =	"9069.9:Chen Stormstout:inv_tailoring_elekkplushie:false:both",
	[40205620] =	"9069.13:Dr. Ion Goldbloom:inv_tailoring_elekkplushie:false:both",
	[40005260] =	"9069.21:Lorewalker Cho:inv_tailoring_elekkplushie:false:both",
	[37805720] =	"9069.33:Shademaster Kiryn:inv_tailoring_elekkplushie:false:both",
	[37805721] =	"9069.35:Sully \"The Pickle\" McLeary:inv_tailoring_elekkplushie:false:both",
	[40005261] =	"9069.37:Taran Zhu:inv_tailoring_elekkplushie:false:both",
	[40005262] =	"9069.43:Wise Mari:inv_tailoring_elekkplushie:false:both",
	[37805722] =	"9069.44:Wrathion:inv_tailoring_elekkplushie:false:both"
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
	[64404921] =	"9069.28:Nicki Tinytech:inv_tailoring_elekkplushie:false:both",
}
--Zangarmarsh
points[102] = {
	[17205040] = 	"31923.0:Ras'an:inv_misc_coin_01:true:both",
	[17205041] =	"9069.31:Ras'an:inv_tailoring_elekkplushie:false:both",
}
--Nagrand
points[107] = {
	[61004940] = 	"31924.0:Narrok:inv_misc_coin_01:true:both",
	[61004941] =	"9069.26:Narrok:inv_tailoring_elekkplushie:false:both",
}
--ShattrathCity
points[111] = {
	[59007000] = 	"31925.0:Morulu The Elder:inv_misc_coin_01:true:both",
	[59007001] =	"9069.25:Morulu the Elder:inv_tailoring_elekkplushie:false:both",
}
--Deepholm
points[207] = {
	[49805700] = 	"31973.0:Bordin Steadyfist:inv_misc_coin_01:true:both",
	[49805701] =	"9069.6:Bordin Steadyfist:inv_tailoring_elekkplushie:false:both",
}
--Hyjal
points[198] = {
	[61403280] = 	"31972.0:Brok:inv_misc_coin_01:true:both",
	[61403281] =	"9069.7:Brok:inv_tailoring_elekkplushie:false:both",
}
--TwilightHighlands
points[241] = {
	[56605680] = 	"31974.0:Goz Banefury:inv_misc_coin_01:true:both",
	[56605681] =	"9069.17:Goz Banefury:inv_tailoring_elekkplushie:false:both",
}
--HowlingFjord
points[117] = {
	[28603380] = 	"31931.0:Beegle Blastfuse:inv_misc_coin_01:true:both",
	[28603381] =	"9069.3:Beegle Blastfuse:inv_tailoring_elekkplushie:false:both",
}
--ZulDrak
points[121] = {
	[13206680] = 	"31934.0:Gutretch:inv_misc_coin_01:true:both",
	[13206681] =	"9069.18:Gutretch:inv_tailoring_elekkplushie:false:both",
}
--CrystalsongForest
points[127] = {
	[50205900] = 	"31932.0:Nearly Headless Jacob:inv_misc_coin_01:true:both",
	[50205901] =	"9069.27:Nearly Headless Jacob:inv_tailoring_elekkplushie:false:both",
}
--Dragonblight
points[115] = {
	[59007700] = 	"31933.0:Okrut Dragonwaste:inv_misc_coin_01:true:both",
	[59007701] =	"9069.30:Okrut Dragonwaste:inv_tailoring_elekkplushie:false:both",
}
--Tokens
points[539] = {
	[50003120] =	"37203.0:Ashlei:achievement_guildperk_honorablemention:false:both",
	[50003121] =	"9069.2:Ashlei:inv_tailoring_elekkplushie:false:both",

}
--SpiresOfArak
points[542] = {
	[46204540] =	"37207.0:Vesharr:achievement_guildperk_honorablemention:false:both",
	[46204541] =	"9069.40:Vesharr:inv_tailoring_elekkplushie:false:both",
}
--Talador
points[535] = {
	[49008040] =	"37208.0:Taralune:achievement_guildperk_honorablemention:false:both",
	[49008041] =	"9069.36:Taralune:inv_tailoring_elekkplushie:false:both",
}
--NagrandDraenor
points[550] = {
	[56200980] =	"37206.0:Tarr the Terrible:achievement_guildperk_honorablemention:false:both",
	[56200981] =	"9069.38:Tarr the Terrible:inv_tailoring_elekkplushie:false:both",
}
--FrostfireRidge88
points[525] = {
	[68606460] =	"37205.0:Gargra:achievement_guildperk_honorablemention:false:both",
	[68606461] =	"9069.16:Gargra:inv_tailoring_elekkplushie:false:both",
}
--Gorgrond
points[543] = {
	[51007060] =	"37201.0:Cymre Brightblade:achievement_guildperk_honorablemention:false:both",
	[51007061] =	"9069.12:Cymre Brightblade:inv_tailoring_elekkplushie:false:both",
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
	[47206261] ="9069.20:Jeremy Feasel:inv_tailoring_elekkplushie:false:both",
	[47406220] = "36471.0:Christoph VonFeasel:inv_misc_bag_31:false:both",
	[47406221] = "9069.10:Christoph VonFeasel:inv_tailoring_elekkplushie:false:both",
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