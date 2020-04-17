local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local TimelessIsle_RareElites = LibStub("AceAddon-3.0"):NewAddon("TimelessIsle_RareElites", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
--TimelessIsle_RareElites = HandyNotes:NewModule("TimelessIsle_RareElites", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes")
local db
local iconDefault = "Interface\\MINIMAP\\Minimap_skull_normal"

TimelessIsle_RareElites.nodes = { }
local nodes = TimelessIsle_RareElites.nodes

nodes["TimelessIsle"] = { }

nodes["TimelessIsle"][35005200] = { "35170", L["EmeralGander"].." \124cff1eff00\124Hitem:104287:0:0:0:0:0:0:0:0:0:0\124h["..L["EmeralGanderDrop"].."]\124h\124r\n"..L["IronfurSteelhorn"].." \124cff1eff00\124Hitem:89770:0:0:0:0:0:0:0:0:0:0\124h["..L["IronfurSteelhornDrop"].."]\124h\124r\n"..L["ImperialPython"].." \124cff0070dd\124Hitem:104161:0:0:0:0:0:0:0:0\124h["..L["ImperialPythonDrop"].."]\124h\124r\n", L["EmeralGanderInfo"]}
nodes["TimelessIsle"][24805500] = { "35171", L["GreatTurtleFuryshell"].." \124cff0070dd\124Hitem:86584:0:0:0:0:0:0:0:0:0:0\124h["..L["GreatTurtleFuryshellDrop"].."]\124h\124r\n", L["GreatTurtleFuryshellInfo"] }
nodes["TimelessIsle"][38007500] = { "35172", L["GuchiSwarmbringer"].." \124cff0070dd\124Hitem:104291:0:0:0:0:0:0:0:0:0:0\124h["..L["GuchiSwarmbringerDrop"].."]\124h\124r\n", L["GuchiSwarmbringerInfo"] }
nodes["TimelessIsle"][47008700] = { "35173", L["Zesqua"].." \124cff0070dd\124Hitem:104303:0:0:0:0:0:0:0:0:0:0\124h["..L["ZesquaDrop"].."]\124h\124r\n", L["ZesquaInfo"] }
nodes["TimelessIsle"][37557731] = { "35174", L["ZhuGonSour"].." \124cff0070dd\124Hitem:104167:0:0:0:0:0:0:0:0:0:0\124h["..L["ZhuGonSourDrop"].."]\124h\124r\n", L["ZhuGonSourInfo"] }
nodes["TimelessIsle"][34088384] = { "35175", L["Karkanos"].." \124cffffffff\124Hitem:104035:0:0:0:0:0:0:0:0:0:0\124h["..L["KarkanosDrop"].."]\124h\124r\n", L["KarkanosInfo"] }
nodes["TimelessIsle"][25063598] = { "35176", L["Chelon"].." \124cff0070dd\124Hitem:86584:0:0:0:0:0:0:0:0:0:0\124h["..L["ChelonDrop"].."]\124h\124r\n", L["ChelonInfo"] }
nodes["TimelessIsle"][59004880] = { "35177", L["Spelurk"].." \124cff1eff00\124Hitem:104320:0:0:0:0:0:0:0:0:0:0\124h["..L["SpelurkDrop"].."]\124h\124r\n", L["SpelurkInfo"] }
nodes["TimelessIsle"][43896989] = { "35178", L["Cranegnasher"].." \124cff0070dd\124Hitem:104268:0:0:0:0:0:0:0:0:0:0\124h["..L["CranegnasherDrop"].."]\124h\124r\n", L["CranegnasherInfo"] }
nodes["TimelessIsle"][54094240] = { "35179", L["Rattleskew"].." \124cffa335ee\124Hitem:104321:0:0:0:0:0:0:0:0:0:0\124h["..L["RattleskewDrop"].."]\124h\124r\n", L["RattleskewInfo"] }
nodes["TimelessIsle"][50008700] = { "35180", L["MonstrousSpineclaw"].." \124cff0070dd\124Hitem:104168:0:0:0:0:0:0:0:0:0:0\124h["..L["MonstrousSpineclawDrop"].."]\124h\124r\n", L["MonstrousSpineclawInfo"] }
nodes["TimelessIsle"][44003900] = { "35181", L["SpiritJadefire"].." \124cff0070dd\124Hitem:104258:0:0:0:0:0:0:0:0:0:0\124h["..L["SpiritJadefireDrop"].."]\124h\124r\n \124cff0070dd\124Hitem:104307:0:0:0:0:0:0:0:0:0:0\124h["..L["SpiritJadefireDrop2"].."]\124h\124r\n", L["SpiritJadefireInfo"] }
nodes["TimelessIsle"][67004300] = { "35182", L["Leafmender"].." \124cff0070dd\124Hitem:104156:0:0:0:0:0:0:0:0:0:0\124h["..L["LeafmenderDrop"].."]\124h\124r\n", L["LeafmenderInfo"] }
nodes["TimelessIsle"][65006500] = { "35183", L["Bufo"].." \124cff0070dd\124Hitem:104169:0:0:0:0:0:0:0:0:0:0\124h["..L["BufoDrop"].."]\124h\124r\n", L["BufoInfo"] }
nodes["TimelessIsle"][64002700] = { "35204", L["Garnia"].." \124cff0070dd\124Hitem:104159:0:0:0:0:0:0:0:0\124h["..L["GarniaDrop"].."]\124h\124r\n", L["GarniaInfo"] } 
nodes["TimelessIsle"][54094240] = { "35205", L["Tsavoka"].." \124cff0070dd\124Hitem:104268:0:0:0:0:0:0:0:0:0:0\124h["..L["TsavokaDrop"].."]\124h\124r\n", L["TsavokaInfo"] }
nodes["TimelessIsle"][71588185] = { "35207", L["Stinkbraid"], L["StinkbraidInfo"] }
nodes["TimelessIsle"][46003100] = { "35208", L["RockMoss"].." \124cff0070dd\124Hitem:104313:0:0:0:0:0:0:0:0:0:0\124h["..L["RockMossDrop"].."]\124h\124r\n", L["RockMossInfo"] }
nodes["TimelessIsle"][57007200] = { "35209", L["WatcherOsu"].." \124cff0070dd\124Hitem:104305:0:0:0:0:0:0:0:0\124h["..L["WatcherOsuDrop"].."]\124h\124r\n", L["WatcherOsuInfo"] }
nodes["TimelessIsle"][52008100] = { "35210", L["JakurOrdon"].." \124cff0070dd\124Hitem:104331:0:0:0:0:0:0:0:0:0:0\124h["..L["JakurOrdonDrop"].."]\124h\124r\n", L["JakurOrdonInfo"] }
nodes["TimelessIsle"][66204050] = { "35211", L["ChampionBlackFlame"].." \124cff0070dd\124Hitem:104302:0:0:0:0:0:0:0:0\124h["..L["ChampionBlackFlameDrop"].."]\124h\124r\n \124cff0070dd\124Hitem:87219:0:0:0:0:0:0:0:0:0:0\124h["..L["ChampionBlackFlameDrop2"].."]\124h\124r\n", L["ChampionBlackFlameInfo"] } 
nodes["TimelessIsle"][53005200] = { "35212", L["Cinderfall"].." \124cff0070dd\124Hitem:104299:0:0:0:0:0:0:0:0:0:0\124h["..L["CinderfallDrop"].."]\124h\124r\n", L["CinderfallInfo"] } 
nodes["TimelessIsle"][43002500] = { "35213", L["UrdurCauterizer"].." \124cff0070dd\124Hitem:104306:0:0:0:0:0:0:0:0:0:0\124h["..L["UrdurCauterizerDrop"].."]\124h\124r\n", L["UrdurCauterizerInfo"] }
nodes["TimelessIsle"][44003400] = { "35214", L["FlintlordGairan"].." \124cffa335ee\124Hitem:104298:0:0:0:0:0:0:0:0\124h["..L["FlintlordGairanDrop"].."]\124h\124r\n", L["FlintlordGairanInfo"] } 
nodes["TimelessIsle"][64106390] = { "35215", L["Huolon"].." \124cffa335ee\124Hitem:104269:0:0:0:0:0:0:0:0:0:0\124h["..L["HuolonDrop"].."]\124h\124r\n", L["HuolonInfo"] } 
nodes["TimelessIsle"][62506350] = { "35216", L["Golganarr"].." \124cff0070dd\124Hitem:104262:0:0:0:0:0:0:0:0:0:0\124h["..L["GolganarrDrop"].."]\124h\124r\n \124cff0070dd\124Hitem:104263:0:0:0:0:0:0:0:0:0:0\124h["..L["GolganarrDrop2"].."]\124h\124r\n", L["GolganarrInfo"] } 
nodes["TimelessIsle"][19005800] = { "35217", L["Evermaw"].." \124cffffffff\124Hitem:104115:0:0:0:0:0:0:0:0\124h["..L["EvermawDrop"].."]\124h\124r\n", L["EvermawInfo"] } 
nodes["TimelessIsle"][28802450] = { "35218", L["DreadShipVazuvius"].." \124cff0070dd\124Hitem:104294:0:0:0:0:0:0:0:0\124h["..L["DreadShipVazuviusDrop"].."]\124h\124r\n", L["DreadShipVazuviusInfo"] } 
nodes["TimelessIsle"][34403250] = { "35219", L["ArchiereusFlame"].."\124cff0070dd\124Hitem:86574:0:0:0:0:0:0:0:0:0:0\124h["..L["ArchiereusFlameDrop"].."]\124h\124r\n", L["ArchiereusFlameInfo"] } 
nodes["TimelessIsle"][61008860] = { "35219", L["Rattleskew"].."\n\124cffa335ee\124Hitem:104321:0:0:0:0:0:0:0:0:0:0\124h["..L["RattleskewDrop"].."]\124h\124r\n\124cff1eff00\124Hitem:104219:0:0:0:0:0:0:0:0:0:0\124h["..L["RattleskewDrop2"].."]\124h\124r\n", L["RattleskewInfo"] } 


--[[ function TimelessIsle_RareElites:OnEnable()
end

function TimelessIsle_RareElites:OnDisable()
end ]]--

--local handler = {}


function TimelessIsle_RareElites:OnEnter(mapFile, coord) -- Copied from handynotes
    if (not nodes[mapFile][coord]) then return end
	
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	tooltip:SetText(nodes[mapFile][coord][2])
	if (nodes[mapFile][coord][3] ~= nil) then
	 tooltip:AddLine(nodes[mapFile][coord][3], nil, nil, nil, true)
	end
	tooltip:Show()
end

function TimelessIsle_RareElites:OnLeave(mapFile, coord)
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local options = {
 type = "group",
 name = "TimelessIsle_RareElites",
 desc = L["OptionsDescription"],
 get = function(info) return db[info.arg] end,
 set = function(info, v) db[info.arg] = v; TimelessIsle_RareElites:Refresh() end,
 args = {
  desc = {
   name = L["OptionsArgsDescription"],
   type = "description",
   order = 0,
  },
  icon_scale = {
   type = "range",
   name = L["OptionsIconScaleName"],
   desc = L["OptionsIconScaleDescription"],
   min = 0.25, max = 2, step = 0.01,
   arg = "icon_scale",
   order = 10,
  },
  icon_alpha = {
   type = "range",
   name = L["OptionsIconAlphaName"],
   desc = L["OptionsIconAlphaDescription"],
   min = 0, max = 1, step = 0.01,
   arg = "icon_alpha",
   order = 20,
  },

 },
}

function TimelessIsle_RareElites:OnInitialize()
 local defaults = {
  profile = {
   icon_scale = 1.5,
   icon_alpha = 1.0,
   alwaysshow = false,
  },
 }
 db = LibStub("AceDB-3.0"):New("TimelessIsle_RareElitesDB", defaults, true).profile
 self:RegisterEvent("PLAYER_ENTERING_WORLD", "WorldEnter")
end

function TimelessIsle_RareElites:WorldEnter()
 self:UnregisterEvent("PLAYER_ENTERING_WORLD")

 --self:RegisterEvent("WORLD_MAP_UPDATE", "Refresh")
 --self:RegisterEvent("LOOT_CLOSED", "Refresh")

 --self:Refresh()
 self:ScheduleTimer("RegisterWithHandyNotes", 10)
end

function TimelessIsle_RareElites:RegisterWithHandyNotes()
do
	local function iter(t, prestate)
		if not t then return nil end
		local state, value = next(t, prestate)
		while state do
			    -- questid, chest type, quest name, icon
			    if (value[1] and (not IsQuestFlaggedCompleted(value[1]) or db.alwaysshow)) then
				 --print(state)
				 local icon = value[4] or iconDefault
				 return state, nil, icon, db.icon_scale, db.icon_alpha
				end
			state, value = next(t, state)
		end
	end
	function TimelessIsle_RareElites:GetNodes(mapFile, isMinimapUpdate, dungeonLevel)
		return iter, nodes[mapFile], nil
	end
end
 HandyNotes:RegisterPluginDB("TimelessIsle_RareElites", self, options)
 self:RegisterBucketEvent({ "LOOT_CLOSED" }, 2, "Refresh")
 self:Refresh()
end
 

function TimelessIsle_RareElites:Refresh()
 self:SendMessage("HandyNotes_NotifyUpdate", "TimelessIsle_RareElites")
end