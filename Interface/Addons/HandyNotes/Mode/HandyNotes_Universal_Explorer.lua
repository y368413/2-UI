local UniversalExplorer	= {}
UniversalExplorer.version	= "10.0.2.1"

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon("UniversalExplorer", "AceEvent-3.0")
	UniversalExplorer.HL		= HL
	UniversalExplorer.icon		= "Interface\\Addons\\HandyNotes\\Icons\\ExplorerCoord"
---------------------------------------------------------------------------------------------------
--	Plugin Handlers to HandyNotes
---------------------------------------------------------------------------------------------------
local	HLHandler = {}
local	tip = {}
local	info = {}
local	menutitle
	UniversalExplorer.points = {}
local	horizontal_line	= CreateAtlasMarkup ("Timer-Fill", 275, 1)

local db
local defaults = {
    profile = {
	icon_scale = 1.0,
        icon_alpha = 1.0,
    },
}


local options = {
    type = "group",
    name = "UniversalExplorer",
    desc = "UniversalExplorer",
    get = function(info) return db[info[#info]] end,
    set = function(info, v)
        db[info[#info]] = v
        HL:SendMessage("HandyNotes_NotifyUpdate", "UniversalExplorer")
    end,
    args = {
        desc = {
            name = "These settings control the look and feel of the icon.",
            type = "description",
            order = 0,
        },
        icon_scale = {
            type = "range",
            name = "Icon Scale",
            desc = "The scale of the icons",
            min = 0.25, max = 2, step = 0.01,
            arg = "icon_scale",
            order = 10,
        },
        icon_alpha = {
            type = "range",
            name = "Icon Alpha",
            desc = "The alpha transparency of the icons",
            min = 0, max = 1, step = 0.01,
            arg = "icon_alpha",
            order = 20,
        },

    },
}
---------------------------------------------------------------------------------------------------
--	Plugin Functions
---------------------------------------------------------------------------------------------------

	------------------------------------------
	--	Create TomTom Way Point
	------------------------------------------
	local function addTomTomWaypoint(button, uiMapID, coord)
		if TomTom then
			local x, y = HandyNotes:getXY(coord)
			TomTom:AddWaypoint(uiMapID, x, y, {
				title = tip.title,
				persistent = nil,
				minimap = true,
				world = true
			})
		end
	end
	------------------------------------------
	--	Create Blizzard Way Point
	------------------------------------------

	local function addBlizzardWaypoint(button, uMapID, coord)
	    local x, y = HandyNotes:getXY(coord)
	    local parentMapID = C_Map.GetMapInfo(uMapID)["parentMapID"]
	    if (not C_Map.CanSetUserWaypointOnMap(uMapID)) then
		local wx, wy = HBD:GetWorldCoordinatesFromZone(x, y, uMapID)
		uMapID = parentMapID
		x, y = HBD:GetZoneCoordinatesFromWorld(wx, wy, parentMapID)
	    end

	    C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(uMapID, x, y))
	    C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	end
	------------------------------------------
	--	Hide Note
	------------------------------------------
	local function hideNode ( button , uiMapID , coord )
		UniversalExplorer.hidden[uiMapID][coord] = true
	end
	------------------------------------------
	--	Close Context Menu 
	------------------------------------------
	local function closeAllDropdowns ()
		CloseDropDownMenus (1)
	end

	------------------------------------------
	--	Create Context Menu
	------------------------------------------
	do
		local currentMapID , currentCoord = nil , nil
		local function generateMenu ( button , level )
		      if ( not level ) then return end

		      wipe ( info )
		      if ( level == 1 ) then
			 ------------------------------------------
			 --	Create Context Menu Title
			 ------------------------------------------
			 info.isTitle		= 1
			 info.text		= "|cff3399ff" .. "HandyNotes Universal Explorer" .. "|r" .. "|cffFFFFFF " ..  UniversalExplorer.version  .. "|r"
			 info.notCheckable	= 1
			 UIDropDownMenu_AddButton ( info , level )
			 wipe ( info )

			 ------------------------------------------
			 --	Create Blizzard Waypoint Menu item
			 ------------------------------------------
			 info.text		= "Create Blizzard Waypoint"
			 info.notCheckable	= 1
			 info.func		= addBlizzardWaypoint
			 info.arg1		= currentMapID
			 info.arg2		= currentCoord
			 UIDropDownMenu_AddButton ( info , level )
			 wipe ( info )
			 ------------------------------------------
			 --	Create TomTom Waypoint Menu item
			 ------------------------------------------
		         if (C_AddOns.IsAddOnLoaded("TomTom")) then
			    info.text		= "Create TomTom Waypoint"
			    info.notCheckable	= 1
			    info.func		= addTomTomWaypoint
			    info.arg1		= currentMapID
			    info.arg2		= currentCoord
			    UIDropDownMenu_AddButton ( info , level )
			    wipe ( info )
			 end
		--[[	
			 ------------------------------------------
			 --	Hide Node
			 ------------------------------------------
			 info.text         = "Hide node"
			 info.notCheckable = 1
			 info.func         = hideNode
			 info.arg1 = currentMapID
			 info.arg2 = currentCoord
			 UIDropDownMenu_AddButton ( info , level )
			 wipe ( info )
		]]--
			 ------------------------------------------
			 --	Close Menu
			 ------------------------------------------
			 info.text		= "Close"
			 info.notCheckable	= 1
			 info.func		= closeAllDropdowns
			 info.arg1		= currentMapID
			 info.arg2		= currentCoord

			 UIDropDownMenu_AddButton ( info , level )
			 wipe ( info )
		      end
		end
		------------------------------------------
		--	Initialize Context Menu
		------------------------------------------
		local HL_Dropdown = CreateFrame("Frame", "HandyNotes_UniversalExplorerDropdownMenu")
		HL_Dropdown.displayMode = "MENU"
		HL_Dropdown.initialize = generateMenu
		------------------------------------------
		--	Initialize Context Menu
		------------------------------------------
		function HLHandler:OnClick(button, down, uiMapID, coord)
			 currentMapID , currentCoord = uiMapID , coord
		         local point = UniversalExplorer.points[currentMapID] and UniversalExplorer.points[currentMapID][currentCoord]
		         if button == "RightButton" and not down then
 			    ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
		         end
		end
	end

	------------------------------------------
	--	Create Pin Pint
	------------------------------------------
	do
	    local function iter ( t , prestate )
		
		  if not t then return nil end
		  
		  local state, value = next ( t , prestate )
		  
		  while state do
			if value then
			   ------------------------------------------
			   --	Create Icon
			   ------------------------------------------
			   local icon, alpha, scale
			   scale = (value.scale or 1) * db.icon_scale
			   alpha = (value.alpha or 1) * db.icon_alpha
			   
				if value.achievement then
					local criteriaCompleted = select(3,
						GetAchievementCriteriaInfoByID(value.achievement, value.criteria)) or nil
					local criteriaString = select(1, GetAchievementCriteriaInfoByID(value.achievement, value.criteria)) or
					nil

					-- if (UnitName("player") ~= select(6, GetAchievementCriteriaInfoByID(value.achievement, value.criteria))) then
					-- 	if not criteriaCompleted then
					-- 		icon = UniversalExplorer.icon
					-- 	end
					-- end
					icon = UniversalExplorer.icon
				end
			   ------------------------------------------
			   --	Get next data
			   ------------------------------------------
			   return state, nil, icon, scale, alpha
			end
			state , value = next ( t , state )
		  end
		  return nil, nil, nil, nil
	    end
	    ------------------------------------------
	    --	Get Nodes
	    ------------------------------------------
	    function HLHandler:GetNodes2(uiMapID, minimap)
		return iter, UniversalExplorer.points[uiMapID], nil
	    end

	end

	------------------------------------------
	--	Create Tooltip
	------------------------------------------
	function HLHandler:OnEnter(uiMapID, coord)
		local tooltip = GameTooltip
		if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
			tooltip:SetOwner(self, "ANCHOR_LEFT")
		else
			tooltip:SetOwner(self, "ANCHOR_RIGHT")
		end

		local value = UniversalExplorer.points[uiMapID][coord]
		if not value then return nil end
		if value.achievement then

			tip.x = tonumber ( string.sub(coord, 1, 4) ) / 100
			tip.y = tonumber ( string.sub(coord, 5, 8) ) / 100

			tip.cirteriaid		= value.criteria
			tip.cirteriaidText	= WrapTextInColorCode ( " id: " .. value.criteria .."" , "ff" .. "FFCC00" )
			tip.cirteria		= select(1, GetAchievementCriteriaInfoByID(value.achievement, value.criteria))


			tip.achievementid	= value.achievement
			tip.achievementidText	= WrapTextInColorCode ( " id: " .. value.achievement .."" , "ff" .. "FFFFFF" )
			tip.achievement		= select(2, GetAchievementInfo(value.achievement))

			tip.description		= value.description or "Revealing the covered areas of the world map."
			
			tip.coord		= value.coord or tip.x .. "," .. tip.y
			
			tip.note		= value.note
			tip.source		= value.source or "Wowhead"
			tip.thanks		= value.thanks or "Tykes"



		end
		------------------------------------------------------------------------------------
		if tip.cirteriaid then 
			if ( value.criteria == 0) then tip.cirteria = value.criteriaName end
			
			if tip.coord then 
				tooltip : AddDoubleLine ( tip.cirteria , tip.coord , 0.2 , 0.6 , 1 , 1 , 1 , 1 )
			else
				tooltip : AddLine	( tip.cirteria , 0.2, 0.6, 1, true)
			end
			
			tooltip : AddLine	(horizontal_line)
			
			if tip.achievement then 
				tooltip:AddLine (tip.achievement  , 0.2 , 0.6 , 1 )
			end	

			if tip.description then 
				--tooltip:AddLine (" ")
				tooltip:AddLine(tip.description .. " ", 1, 1, 1, true)
			end
			tooltip : AddLine	(" ")
			tooltip : AddLine	("Right click to open menu")
		
			tooltip : AddLine	(horizontal_line)
			tooltip : AddDoubleLine ("|cffFFFFFFAchievement id:|r " .. tip.achievementid, ( value.criteria == 0 ) and "" or "|cffFFFFFFCriteria id:|r " .. tip.cirteriaid)
			--tooltip : AddLine (" ")
			if tip.source then
				tooltip : AddDoubleLine ( "Source:" , tip.source , 1 , 1 , 1 , 0.2 , 0.6 , 1 )
			end					
			if tip.thanks then
				tooltip : AddDoubleLine ( "Thanks to:" , tip.thanks , 1 , 1 , 1  )
			end
		end
		tooltip:Show()

	end
---------------------------------------------------------------------------------------------------
--	Plugin initialization, enabling and disabling
---------------------------------------------------------------------------------------------------

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_UniversalExplorerDB", defaults)
    db = self.db.profile
    UniversalExplorer.hidden = self.db.char.hidden
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("UniversalExplorer", HLHandler, options)
end

function HLHandler:OnLeave(uiMapId, coord)
	GameTooltip:Hide()
end


----------------------------------------------------------------------------------------------------
-- Eastern Kingdoms Explorer Points						AchievementID: 42 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- Explore Arathi Highlands Points				       AchievementID: 761 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[14] = {  
		[18003100] = {  achievement = 761, criteria = 962,},	-- Circle of West Binding
		[26002900] = {  achievement = 761, criteria = 963,},	-- Northfold Manor
		[28004500] = {  achievement = 761, criteria = 2044,},	-- Boulder'gor
		[13003600] = {  achievement = 761, criteria = 964,},	-- Galen's Fall
		[19006200] = {  achievement = 761, criteria = 965,},	-- Stromgarde Keep
		[24008100] = {  achievement = 761, criteria = 966,},	-- Faldir's Cove
		[29005900] = {  achievement = 761, criteria = 967,},	-- Circle of Inner Binding
		[39008900] = {  achievement = 761, criteria = 968,},	-- Thandol Span
		[49007800] = {  achievement = 761, criteria = 969,},	-- Boulderfist Hall
		[40004700] = {  achievement = 761, criteria = 970,},	-- Refuge Pointe
		[47005200] = {  achievement = 761, criteria = 971,},	-- Circle of Outer Binding
		[60007300] = {  achievement = 761, criteria = 972,},	-- Witherbark Village
		[56005800] = {  achievement = 761, criteria = 973,},	-- Go'Shek Farm
		[50004000] = {  achievement = 761, criteria = 974,},	-- Dabyrie's Farmstead
		[58003500] = {  achievement = 761, criteria = 975,},	-- Circle of East Binding
		[69003600] = {  achievement = 761, criteria = 976,},	-- Hammerfall
	}
	--------------------------------------------------------------------------------------------
	-- Explore Badlands Points					       AchievementID: 765 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[15] = {  
		[70004600] = {  achievement = 765, criteria = 1014,},	-- Lethlor Ravine
		[45005800] = {  achievement = 765, criteria = 1016,},	-- Agmond's End
		[43001100] = {  achievement = 765, criteria = 1017,},	-- Uldaman
		[15006600] = {  achievement = 765, criteria = 1018,},	-- Camp Cagg
		[36005100] = {  achievement = 765, criteria = 1020,},	-- Scar of the Worldbreaker
		[26004500] = {  achievement = 765, criteria = 1021,},	-- The Dustbowl
		[40002700] = {  achievement = 765, criteria = 1023,},	-- Angor Fortress
		[59002000] = {  achievement = 765, criteria = 1027,},	-- Camp Kosh
		[51004900] = {  achievement = 765, criteria = 16092,},	-- Bloodwatcher Point
		[16004400] = {  achievement = 765, criteria = 16093,},	-- New Kargath
	}
	--------------------------------------------------------------------------------------------
	-- Explore Blasted Lands Points					       AchievementID: 766 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[17] = {  
		[41001400] = {  achievement = 766, criteria = 1028,},	-- Dreadmaul Hold
		[52001500] = {  achievement = 766, criteria = 1029,},	-- Nethergarde Supply Camps
		[61001600] = {  achievement = 766, criteria = 1030,},	-- Nethergarde Keep
		[59002900] = {  achievement = 766, criteria = 1031,},	-- Serpent's Coil
		[54005300] = {  achievement = 766, criteria = 1032,},	-- The Dark Portal
		[37002800] = {  achievement = 766, criteria = 1033,},	-- Altar of Storms
		[46003900] = {  achievement = 766, criteria = 1034,},	-- Dreadmaul Post
		[32004600] = {  achievement = 766, criteria = 1035,},	-- The Tainted Scar
		[44002600] = {  achievement = 766, criteria = 1036,},	-- Rise of the Defiler
		[69003600] = {  achievement = 766, criteria = 14165,},	-- Shattershore
		[50007200] = {  achievement = 766, criteria = 14166,},	-- Sunveil Excursion
		[44008600] = {  achievement = 766, criteria = 14167,},	-- Surwich
		[66007100] = {  achievement = 766, criteria = 14168,},	-- The Red Reaches
		[34007300] = {  achievement = 766, criteria = 14169,},	-- The Tainted Forest
	}
	--------------------------------------------------------------------------------------------
	-- Explore Tirisfal Glades Points				       AchievementID: 768 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[18] = {  
		[32006400] = {  achievement = 768, criteria = 1037,},	-- Deathknell
		[38004900] = {  achievement = 768, criteria = 1038,},	-- Solliden Farmstead
		[46003300] = {  achievement = 768, criteria = 1039,},	-- Agamand Mills
		[45006600] = {  achievement = 768, criteria = 1041,},	-- Nightmare Vale
		[53005700] = {  achievement = 768, criteria = 1042,},	-- Cold Hearth Manor
		[61005100] = {  achievement = 768, criteria = 1043,},	-- Brill
		[58003600] = {  achievement = 768, criteria = 1044,},	-- Garren's Haunt
		[68004600] = {  achievement = 768, criteria = 1046,},	-- Brightwater Lake
		[75006000] = {  achievement = 768, criteria = 1047,},	-- Balnir Farmstead
		[79005500] = {  achievement = 768, criteria = 1048,},	-- Crusader Outpost
		[79002700] = {  achievement = 768, criteria = 1049,},	-- Scarlet Watch Post
		[86004600] = {  achievement = 768, criteria = 1051,},	-- Venomweb Vale
		[62006900] = {  achievement = 768, criteria = 1045,},	-- Ruins of Lordaeron
		[83003200] = {  achievement = 768, criteria = 14153,},	-- Scarlet Monastery Entrance
		[83007000] = {  achievement = 768, criteria = 14154,},	-- The Bulwark
		[44005300] = {  achievement = 768, criteria = 14155,},	-- Calston Estate
	}
	--------------------------------------------------------------------------------------------
	-- Explore Silverpine Forest Points				       AchievementID: 769 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[21] = {  
		[45007600] = {  achievement = 769, criteria = 1053,},	-- The Battlefront
		[54003400] = {  achievement = 769, criteria = 1054,},	-- The Decrepit Fields
		[50006800] = {  achievement = 769, criteria = 1055,},	-- The Forsaken Front
		[35001400] = {  achievement = 769, criteria = 1056,},	-- The Skittering Dark
		[38002700] = {  achievement = 769, criteria = 1057,},	-- North Tide's Beachhead
		[67002800] = {  achievement = 769, criteria = 1058,},	-- Fenris Isle
		[53002500] = {  achievement = 769, criteria = 1059,},	-- Valgan's Field
		[44004100] = {  achievement = 769, criteria = 1060,},	-- The Sepulcher
		[56004700] = {  achievement = 769, criteria = 1061,},	-- Deep Elem Mine
		[45005100] = {  achievement = 769, criteria = 1062,},	-- Olsen's Farthing
		[61006300] = {  achievement = 769, criteria = 1063,},	-- Ambermill
		[44006700] = {  achievement = 769, criteria = 1064,},	-- Shadowfang Keep
		[57001000] = {  achievement = 769, criteria = 1065,},	-- Forsaken High Command
		[34002000] = {  achievement = 769, criteria = 14160,},	-- North Tide's Run
		[44002000] = {  achievement = 769, criteria = 14159,},	-- Forsaken Rear Guard
	}
	--------------------------------------------------------------------------------------------
	-- Explore Western Plaguelands Points				       AchievementID: 770 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[22] = {  
		[60007300] = {  achievement = 770, criteria = 1068,},	-- Darrowmere Lake
		[69007400] = {  achievement = 770, criteria = 1069,},	-- Caer Darrow
		[50007700] = {  achievement = 770, criteria = 1070,},	-- Sorrow Hill
		[44006800] = {  achievement = 770, criteria = 1071,},	-- Andorhal
		[28005800] = {  achievement = 770, criteria = 1072,},	-- The Bulwark
		[37005600] = {  achievement = 770, criteria = 1073,},	-- Felstone Field
		[46005200] = {  achievement = 770, criteria = 1074,},	-- Dalson's Farm
		[53006700] = {  achievement = 770, criteria = 1075,},	-- The Writhing Haunt
		[48003300] = {  achievement = 770, criteria = 1076,},	-- Northridge Lumber Camp
		[45001700] = {  achievement = 770, criteria = 1077,},	-- Hearthglen
		[54004600] = {  achievement = 770, criteria = 14170,},	-- Redpine Dell
		[62005700] = {  achievement = 770, criteria = 1078,},	-- Gahrron's Withering
		[65004100] = {  achievement = 770, criteria = 1079,},	-- The Weeping Cave
		[70004800] = {  achievement = 770, criteria = 1080,},	-- Thondroril River
	}
	--------------------------------------------------------------------------------------------
	-- Explore Eastern Plaguelands Points				       AchievementID: 771 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[23] = {  
		[07006400] = {  achievement = 771, criteria = 1081,},	-- Thondroril River
		[23006700] = {  achievement = 771, criteria = 1082,},	-- The Marris Stead
		[24007800] = {  achievement = 771, criteria = 1083,},	-- The Undercroft
		[35006800] = {  achievement = 771, criteria = 1084,},	-- Crown Guard Tower
		[35004600] = {  achievement = 771, criteria = 1085,},	-- The Fungal Vale
		[34008300] = {  achievement = 771, criteria = 1086,},	-- Darrowshire
		[69005600] = {  achievement = 771, criteria = 1087,},	-- Pestilent Scar
		[55006200] = {  achievement = 771, criteria = 1088,},	-- Corin's Crossing
		[56007400] = {  achievement = 771, criteria = 1089,},	-- Lake Mereldar
		[76007500] = {  achievement = 771, criteria = 1090,},	-- Tyr's Hand
		[75005300] = {  achievement = 771, criteria = 1091,},	-- Light's Hope Chapel
		[49006500] = {  achievement = 771, criteria = 1092,},	-- The Infectis Scar
		[78003700] = {  achievement = 771, criteria = 1093,},	-- The Noxious Glade
		[62004200] = {  achievement = 771, criteria = 1094,},	-- Eastwall Tower
		[46004300] = {  achievement = 771, criteria = 1095,},	-- Blackwood Lake
		[65002700] = {  achievement = 771, criteria = 1096,},	-- Northdale
		[64001200] = {  achievement = 771, criteria = 1097,},	-- Zul'Mashar
		[50002000] = {  achievement = 771, criteria = 1098,},	-- Northpass Tower
		[48001300] = {  achievement = 771, criteria = 1099,},	-- Quel'Lithien Lodge
		[12002700] = {  achievement = 771, criteria = 1100,},	-- Terrordale
		[29002600] = {  achievement = 771, criteria = 1101,},	-- Plaguewood
		[27001000] = {  achievement = 771, criteria = 1102,},	-- Stratholme
		[88007300] = {  achievement = 771, criteria = 8749,},	-- Ruins of the Scarlet Enclave
	}
	--------------------------------------------------------------------------------------------
	-- Explore Hillsbrad Foothills Points				       AchievementID: 772 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[25] = {  
		[35007400] = {  achievement = 772, criteria = 1103,},	-- Azurelode Mine
		[34007400] = {  achievement = 772, criteria = 15106,},	-- Brazie Farmstead
		[50004700] = {  achievement = 772, criteria = 1104,},	-- Corrahn's Dagger
		[52002300] = {  achievement = 772, criteria = 1105,},	-- Crushridge Hold
		[68003000] = {  achievement = 772, criteria = 15119,},	-- Chillwind Point
		[30003700] = {  achievement = 772, criteria = 1106,},	-- Dalaran Crater
		[44000900] = {  achievement = 772, criteria = 1107,},	-- Dandred's Fold
		[45005700] = {  achievement = 772, criteria = 1108,},	-- Darrow Hill
		[62008400] = {  achievement = 772, criteria = 1109,},	-- Dun Garok
		[68006000] = {  achievement = 772, criteria = 1110,},	-- Durnholde Keep
		[51003100] = {  achievement = 772, criteria = 1111,},	-- Gallows' Corner
		[39004800] = {  achievement = 772, criteria = 1112,},	-- Gavin's Naze
		[43003800] = {  achievement = 772, criteria = 1113,},	-- Growless Cave
		[40001800] = {  achievement = 772, criteria = 15107,},	-- Misty Shore
		[58007300] = {  achievement = 772, criteria = 15108,},	-- Nethander Stead
		[26008600] = {  achievement = 772, criteria = 15109,},	-- Purgation Isle
		[43003000] = {  achievement = 772, criteria = 15110,},	-- Ruins of Alterac
		[48007000] = {  achievement = 772, criteria = 15114,},	-- Ruins of Southshore
		[48001900] = {  achievement = 772, criteria = 15111,},	-- Slaughter Hollow
		[55003700] = {  achievement = 772, criteria = 15112,},	-- Sofera's Naze
		[30006300] = {  achievement = 772, criteria = 15113,},	-- Southpoint Gate
		[58002400] = {  achievement = 772, criteria = 15115,},	-- Strahnbrad
		[55004700] = {  achievement = 772, criteria = 15116,},	-- Tarren Mill
		[44005000] = {  achievement = 772, criteria = 15117,},	-- The Headland
		[37006000] = {  achievement = 772, criteria = 1114,},	-- The Sludge Fields
		[51001400] = {  achievement = 772, criteria = 15118,},	-- The Uplands
	}
	--------------------------------------------------------------------------------------------
	-- Explore The Hinterlands Points				       AchievementID: 773 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[26] = {  
		[12004600] = {  achievement = 773, criteria = 1115,},	-- Aerie Peak
		[24003600] = {  achievement = 773, criteria = 1116,},	-- Plaguemist Ravine
		[22005700] = {  achievement = 773, criteria = 1117,},	-- Zun'watha
		[32004600] = {  achievement = 773, criteria = 1118,},	-- Quel'Danil Lodge
		[34007100] = {  achievement = 773, criteria = 1119,},	-- Shadra'Alor
		[41005900] = {  achievement = 773, criteria = 1120,},	-- Valorwind Lake
		[46004000] = {  achievement = 773, criteria = 1121,},	-- Agol'watha
		[49005000] = {  achievement = 773, criteria = 1122,},	-- The Creeping Ruin
		[48006800] = {  achievement = 773, criteria = 1123,},	-- The Altar of Zul
		[63002600] = {  achievement = 773, criteria = 1124,},	-- Seradane
		[58004100] = {  achievement = 773, criteria = 1125,},	-- Skulk Rock
		[72005300] = {  achievement = 773, criteria = 1126,},	-- Shaol'watha
		[63007300] = {  achievement = 773, criteria = 1127,},	-- Jintha'Alor
		[76005900] = {  achievement = 773, criteria = 1128,},	-- The Overlook Cliffs
	}
	--------------------------------------------------------------------------------------------
	-- Explore Dun Morogh Points					       AchievementID: 627 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[27] = {  
		[42006600] = {  achievement = 627, criteria = 502,},	-- Coldridge Pass
		[35007100] = {  achievement = 627, criteria = 14148,},	-- Coldridge Valley
		[58005900] = {  achievement = 627, criteria = 14149,},	-- Frostmane Front
		[33003800] = {  achievement = 627, criteria = 14150,},	-- New Tinkertown
		[77002500] = {  achievement = 627, criteria = 14151,},	-- Ironforge Airfield
		[48003800] = {  achievement = 627, criteria = 504,},	-- Shimmer Ridge
		[53005000] = {  achievement = 627, criteria = 505,},	-- Kharanos
		[65005700] = {  achievement = 627, criteria = 507,},	-- The Tundrid Hills
		[71004800] = {  achievement = 627, criteria = 508,},	-- Amberstill Ranch
		[83005100] = {  achievement = 627, criteria = 509,},	-- Helm's Bed Lake
		[76005600] = {  achievement = 627, criteria = 510,},	-- Gol'Bolar Quarry
		[88004000] = {  achievement = 627, criteria = 511,},	-- North Gate Outpost
		[33004900] = {  achievement = 627, criteria = 512,},	-- Frostmane Hold
		[41004000] = {  achievement = 627, criteria = 517,},	-- Iceflow Lake
		[58003600] = {  achievement = 627, criteria = 519,},	-- Gates of Ironforge
	}
	--------------------------------------------------------------------------------------------
	-- Explore Searing Gorge Points					       AchievementID: 774 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[32] = {  
		[22003700] = {  achievement = 774, criteria = 1129,},	-- Firewatch Ridge
		[48005200] = {  achievement = 774, criteria = 1130,},	-- The Cauldron
		[20008000] = {  achievement = 774, criteria = 1131,},	-- Blackchar Cave
		[60007100] = {  achievement = 774, criteria = 1132,},	-- The Sea of Cinders
		[65005800] = {  achievement = 774, criteria = 1134,},	-- Grimesilt Dig Site
		[72002800] = {  achievement = 774, criteria = 1135,},	-- Dustfire Valley
		[36002700] = {  achievement = 774, criteria = 15120,},	-- Thorium Point
		[36008500] = {  achievement = 774, criteria = 15121,},	-- Blackrock Mountain
	}
	--------------------------------------------------------------------------------------------
	-- Explore Burning Steppes Points				       AchievementID: 775 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[36] = {  
		[69004200] = {  achievement = 775, criteria = 1136,},	-- Dreadmaul Rock
		[73006600] = {  achievement = 775, criteria = 1137,},	-- Morgan's Vigil
		[75005200] = {  achievement = 775, criteria = 1138,},	-- Terror Wing Path
		[66007300] = {  achievement = 775, criteria = 1139,},	-- Blackrock Pass
		[55003800] = {  achievement = 775, criteria = 1140,},	-- Ruins of Thaurissan
		[36005300] = {  achievement = 775, criteria = 1141,},	-- Black Tooth Hovel
		[32003600] = {  achievement = 775, criteria = 1142,},	-- Blackrock Stronghold
		[19006500] = {  achievement = 775, criteria = 1143,},	-- The Whelping Downs
		[09002900] = {  achievement = 775, criteria = 1144,},	-- Altar of Storms
		[20003500] = {  achievement = 775, criteria = 1145,},	-- Blackrock Mountain
	}
	--------------------------------------------------------------------------------------------
	-- Explore Elwynn Forest Points					       AchievementID: 776 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[37] = {  
		[48004100] = {  achievement = 776, criteria = 1146,},	-- Northshire Valley
		[24007600] = {  achievement = 776, criteria = 14147,},	-- Westbrook Garrison
		[42006500] = {  achievement = 776, criteria = 1147,},	-- Goldshire
		[38008100] = {  achievement = 776, criteria = 1148,},	-- Fargodeep Mine
		[48008600] = {  achievement = 776, criteria = 1151,},	-- Jerod's Landing
		[64007100] = {  achievement = 776, criteria = 1152,},	-- Tower of Azora
		[69008000] = {  achievement = 776, criteria = 1153,},	-- Brackwell Pumpkin Patch
		[82006700] = {  achievement = 776, criteria = 1154,},	-- Eastvale Logging Camp
		[84008000] = {  achievement = 776, criteria = 1155,},	-- Ridgepoint Tower
		[52006600] = {  achievement = 776, criteria = 1156,},	-- Crystal Lake
		[74005200] = {  achievement = 776, criteria = 1157,},	-- Stone Cairn Lake
	}
	--------------------------------------------------------------------------------------------
	-- Explore Deadwind Pass Points					       AchievementID: 777 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[42] = {  
		[45004400] = {  achievement = 777, criteria = 1158,},	-- Deadman's Crossing
		[58006700] = {  achievement = 777, criteria = 1159,},	-- The Vice
		[45007300] = {  achievement = 777, criteria = 1160,},	-- Karazhan
	}
	--------------------------------------------------------------------------------------------
	-- Explore Duskwood Points					       AchievementID: 778 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[47] = {  
		[09004600] = {  achievement = 778, criteria = 1161,},	-- The Hushed Bank
		[21006900] = {  achievement = 778, criteria = 1162,},	-- Addle's Stead
		[19005600] = {  achievement = 778, criteria = 1163,},	-- Raven Hill
		[19004100] = {  achievement = 778, criteria = 1164,},	-- Raven Hill Cemetery
		[35007300] = {  achievement = 778, criteria = 1165,},	-- Vul'Gol Ogre Mound
		[47004000] = {  achievement = 778, criteria = 1166,},	-- Twilight Grove
		[49007300] = {  achievement = 778, criteria = 1167,},	-- The Yorgen Farmstead
		[65003800] = {  achievement = 778, criteria = 1168,},	-- Brightwood Grove
		[64007100] = {  achievement = 778, criteria = 1169,},	-- The Rotting Orchard
		[79006900] = {  achievement = 778, criteria = 1170,},	-- Tranquil Gardens Cemetery
		[74004700] = {  achievement = 778, criteria = 1171,},	-- Darkshire
		[77003600] = {  achievement = 778, criteria = 1172,},	-- Manor Mistmantle
		[56001600] = {  achievement = 778, criteria = 1173,},	-- The Darkened Bank
	}
	--------------------------------------------------------------------------------------------
	-- Explore Loch Modan Points					       AchievementID: 779 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[48] = {  
		[49004400] = {  achievement = 779, criteria = 1176,},	-- The Loch
		[48001200] = {  achievement = 779, criteria = 1174,},	-- Stonewrought Dam
		[70002600] = {  achievement = 779, criteria = 1175,},	-- Mo'grosh Stronghold
		[34002000] = {  achievement = 779, criteria = 1177,},	-- Silver Stream Mine
		[19001700] = {  achievement = 779, criteria = 1178,},	-- North Gate Pass
		[82006300] = {  achievement = 779, criteria = 1179,},	-- The Farstrider Lodge
		[68006300] = {  achievement = 779, criteria = 1180,},	-- Ironband's Excavation Site
		[36006200] = {  achievement = 779, criteria = 1181,},	-- Grizzlepaw Ridge
		[35004700] = {  achievement = 779, criteria = 1182,},	-- Thelsamar
		[32007800] = {  achievement = 779, criteria = 1183,},	-- Stonesplinter Valley
		[21007400] = {  achievement = 779, criteria = 1184,},	-- Valley of Kings
	}
	--------------------------------------------------------------------------------------------
	-- Explore Redridge Mountains Points				       AchievementID: 780 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[49] = {  
		[27004200] = {  achievement = 780, criteria = 1185,},	-- Lakeshire
		[40005200] = {  achievement = 780, criteria = 1188,},	-- Lake Everstill
		[18006200] = {  achievement = 780, criteria = 1186,},	-- Three Corners
		[38006700] = {  achievement = 780, criteria = 1187,},	-- Lakeridge Highway
		[25002300] = {  achievement = 780, criteria = 1189,},	-- Redridge Canyons
		[48004000] = {  achievement = 780, criteria = 1191,},	-- Alther's Mill
		[68005400] = {  achievement = 780, criteria = 1192,},	-- Stonewatch Falls
		[65007100] = {  achievement = 780, criteria = 1193,},	-- Render's Valley
		[35001500] = {  achievement = 780, criteria = 1190,},	-- Render's Camp
		[60005000] = {  achievement = 780, criteria = 1194,},	-- Stonewatch Keep
		[67003900] = {  achievement = 780, criteria = 1195,},	-- Galardell Valley
		[78006200] = {  achievement = 780, criteria = 14161,},	-- Shalewind Canyon
		[52005500] = {  achievement = 780, criteria = 14162,},	-- Camp Everstill
	}
	--------------------------------------------------------------------------------------------
	-- Explore Northern Stranglethorn Points			       AchievementID: 781 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[50] = {  
		[38005000] = {  achievement = 781, criteria = 1198,},	-- Grom'gol Base Camp
		[60005500] = {  achievement = 781, criteria = 14062,},	-- Balia'mah Ruins
		[64004000] = {  achievement = 781, criteria = 14063,},	-- Bambala
		[51006500] = {  achievement = 781, criteria = 14064,},	-- Fort Livingston
		[19002400] = {  achievement = 781, criteria = 14066,},	-- Zuuldaia Ruins
		[44002300] = {  achievement = 781, criteria = 1197,},	-- Nesingwary's Expedition
		[47001100] = {  achievement = 781, criteria = 1199,},	-- Rebel Camp
		[59002000] = {  achievement = 781, criteria = 1200,},	-- Kurzen's Compound
		[42003900] = {  achievement = 781, criteria = 1216,},	-- Kal'ai Ruins
		[46005300] = {  achievement = 781, criteria = 1212,},	-- Mizjah Ruins
		[66005100] = {  achievement = 781, criteria = 1213,},	-- Mosh'Ogg Ogre Mound
		[52003500] = {  achievement = 781, criteria = 1215,},	-- Lake Nazferiti
		[34003600] = {  achievement = 781, criteria = 1217,},	-- Bal'lal Ruins
		[27005000] = {  achievement = 781, criteria = 1218,},	-- The Vile Reef
		[26002000] = {  achievement = 781, criteria = 1220,},	-- Ruins of Zul'Kunda
		[82003000] = {  achievement = 781, criteria = 1222,},	-- Zul'Gurub
	}
	--------------------------------------------------------------------------------------------
	-- Explore Swamp of Sorrows Points				       AchievementID: 782 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[51] = {  
		[15003700] = {  achievement = 782, criteria = 1224,},	-- Misty Valley
		[28003300] = {  achievement = 782, criteria = 1225,},	-- The Harborage
		[21005000] = {  achievement = 782, criteria = 1226,},	-- Splinterspear Junction
		[41003900] = {  achievement = 782, criteria = 1227,},	-- The Shifting Mire
		[47005400] = {  achievement = 782, criteria = 1228,},	-- Stonard
		[69005300] = {  achievement = 782, criteria = 1229,},	-- Pool of Tears
		[69007400] = {  achievement = 782, criteria = 1230,},	-- Stagalbog
		[83003900] = {  achievement = 782, criteria = 1231,},	-- Sorrowmurk
		[72001400] = {  achievement = 782, criteria = 1232,},	-- Bogpaddle
		[86002400] = {  achievement = 782, criteria = 1233,},	-- Misty Reed Strand
		[18006600] = {  achievement = 782, criteria = 14163,},	-- Purespring Cavern
		[68003600] = {  achievement = 782, criteria = 14164,},	-- Marshtide Watch
	}
	--------------------------------------------------------------------------------------------
	-- Explore Westfall Points					       AchievementID: 802 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[52] = {  
		[56005000] = {  achievement = 802, criteria = 1248,},	-- Sentinel Hill
		[54003100] = {  achievement = 802, criteria = 1249,},	-- Saldean's Farm
		[51002100] = {  achievement = 802, criteria = 1250,},	-- Furlbrow's Pumpkin Farm
		[58001700] = {  achievement = 802, criteria = 1251,},	-- The Jansen Stead
		[44002400] = {  achievement = 802, criteria = 1252,},	-- Jangolode Mine
		[45003500] = {  achievement = 802, criteria = 1253,},	-- The Molsen Farm
		[61005900] = {  achievement = 802, criteria = 1255,},	-- The Dead Acre
		[41006600] = {  achievement = 802, criteria = 1256,},	-- Moonbrook
		[38005200] = {  achievement = 802, criteria = 1257,},	-- Alexston Farmstead
		[34007000] = {  achievement = 802, criteria = 1258,},	-- Demont's Place
		[44008000] = {  achievement = 802, criteria = 1260,},	-- The Dagger Hills
		[38004200] = {  achievement = 802, criteria = 14156,},	-- The Raging Chasm
		[61007200] = {  achievement = 802, criteria = 1261,},	-- The Dust Plains
	}
	--------------------------------------------------------------------------------------------
	-- Explore Wetlands Points					       AchievementID: 841 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[56] = {  
		[10005600] = {  achievement = 841, criteria = 1262,},	-- Menethil Harbor
		[25004700] = {  achievement = 841, criteria = 1263,},	-- Black Channel Marsh
		[18003700] = {  achievement = 841, criteria = 1264,},	-- Bluegill Marsh
		[35004800] = {  achievement = 841, criteria = 1265,},	-- Whelgar's Excavation Site
		[28003200] = {  achievement = 841, criteria = 1266,},	-- Sundown Marsh
		[32002200] = {  achievement = 841, criteria = 1267,},	-- Saltspray Glen
		[43002600] = {  achievement = 841, criteria = 1268,},	-- Ironbeard's Tomb
		[47001600] = {  achievement = 841, criteria = 1269,},	-- Dun Modr
		[48004800] = {  achievement = 841, criteria = 1270,},	-- Angerfang Encampment
		[51006200] = {  achievement = 841, criteria = 1271,},	-- Thelgen Rock
		[57004100] = {  achievement = 841, criteria = 1272,},	-- Greenwarden's Grove
		[60005600] = {  achievement = 841, criteria = 1273,},	-- Mosshide Fen
		[60002700] = {  achievement = 841, criteria = 1274,},	-- Direforge Hill
		[48007700] = {  achievement = 841, criteria = 14157,},	-- Dun Algaz
		[58007000] = {  achievement = 841, criteria = 14158,},	-- Slabchisel's Survey
		[69003700] = {  achievement = 841, criteria = 1275,},	-- Raptor Ridge
	}
	--------------------------------------------------------------------------------------------
	-- Explore Eversong Woods Points				       AchievementID: 859 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[94] = {  
		[34002300] = {  achievement = 859, criteria = 1508,},	-- Sunstrider Isle
		[44004100] = {  achievement = 859, criteria = 1509,},	-- Ruins of Silvermoon
		[35005800] = {  achievement = 859, criteria = 1510,},	-- West Sanctum
		[32007000] = {  achievement = 859, criteria = 1511,},	-- Sunsail Anchorage
		[44005300] = {  achievement = 859, criteria = 1512,},	-- North Sanctum
		[53007000] = {  achievement = 859, criteria = 1513,},	-- East Sanctum
		[60006200] = {  achievement = 859, criteria = 1514,},	-- Farstrider Retreat
		[54005500] = {  achievement = 859, criteria = 1515,},	-- Stillwhisper Pond
		[68004700] = {  achievement = 859, criteria = 1516,},	-- Duskwither Grounds
		[44007100] = {  achievement = 859, criteria = 1517,},	-- Fairbreeze Village
		[59007200] = {  achievement = 859, criteria = 1518,},	-- The Living Wood
		[72007500] = {  achievement = 859, criteria = 1519,},	-- Tor'Watha
		[36008600] = {  achievement = 859, criteria = 1520,},	-- The Scorched Grove
		[57004100] = {  achievement = 859, criteria = 1521,},	-- Silvermoon City
		[72004500] = {  achievement = 859, criteria = 1522,},	-- Azurebreeze Coast
		[64007000] = {  achievement = 859, criteria = 1523,},	-- Elrendar Falls
		[33007800] = {  achievement = 859, criteria = 1524,},	-- Goldenbough Pass
		[66007400] = {  achievement = 859, criteria = 1525,},	-- Lake Elrendar
		[44008500] = {  achievement = 859, criteria = 1526,},	-- Runestone Falithas
		[55008400] = {  achievement = 859, criteria = 1527,},	-- Runestone Shan'dor
		[38007300] = {  achievement = 859, criteria = 1528,},	-- Saltheril's Haven
		[23007500] = {  achievement = 859, criteria = 1529,},	-- Golden Strand
		[65005300] = {  achievement = 859, criteria = 1530,},	-- Thuron's Livery
		[27005900] = {  achievement = 859, criteria = 1531,},	-- Tranquil Shore
		[62008000] = {  achievement = 859, criteria = 1532,},	-- Zeb'Watha
	}
	--------------------------------------------------------------------------------------------
	-- Explore Ghostlands Points					       AchievementID: 858 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[95] = {  
		[46003300] = {  achievement = 858, criteria = 1504,},		-- Tranquillien
		[61001200] = {  achievement = 858, criteria = 1505,},		-- Suncrown Village
		[26001500] = {  achievement = 858, criteria = 1506,},		-- Goldenmist Village
		[19004300] = {  achievement = 858, criteria = 1507,},		-- Windrunner Village
		[33003500] = {  achievement = 858, criteria = 1536,},		-- Sanctum of the Moon
		[55004800] = {  achievement = 858, criteria = 1537,},		-- Sanctum of the Sun
		[79002100] = {  achievement = 858, criteria = 1538,},		-- Dawnstar Spire
		[72003100] = {  achievement = 858, criteria = 1539,},		-- Farstrider Enclave
		[40004900] = {  achievement = 858, criteria = 1540,},		-- Howling Ziggurat
		[33008000] = {  achievement = 858, criteria = 1541,},		-- Deatholme
		[65006100] = {  achievement = 858, criteria = 1542,},		-- Zeb'Nowa
		[76006400] = {  achievement = 858, criteria = 1543,},		-- Amani Pass
		[13005500] = {  achievement = 858, criteria = 1544,},		-- Windrunner Spire
		[34004700] = {  achievement = 858, criteria = 1545,},		-- Bleeding Ziggurat
		[48001300] = {  achievement = 858, criteria = 1546,},		-- Elrendar Crossing
		[47007800] = {  achievement = 858, criteria = 1548,},		-- Thalassian Pass
	}
	--------------------------------------------------------------------------------------------
	-- Explore Isle of Quel'Danas Points				       AchievementID: 868 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[122] = {  
		[41003200] = {  achievement = 868, criteria = 0, criteriaName = "Dawnstar Village",},		-- Dawnstar Village
		[63004800] = {  achievement = 868, criteria = 0, criteriaName = "Greengill Coast",},		-- Greengill Coast
		[60003000] = {  achievement = 868, criteria = 0, criteriaName = "Magisters' Terrace",},		-- Magisters' Terrace
		[54003300] = {  achievement = 868, criteria = 0, criteriaName = "Sun's Reach Harbor",},		-- Sun's Reach Harbor
		[40004500] = {  achievement = 868, criteria = 0, criteriaName = "Sunwell Plateau",},		-- Sunwell Plateau
		[53008400] = {  achievement = 868, criteria = 0, criteriaName = "The Dead Scar",},		-- The Dead Scar
	}
	--------------------------------------------------------------------------------------------
	-- Explore Cape of Stranglethorn Points				      AchievementID: 4995 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[210] = {  
		[42007100] = {  achievement = 4995, criteria = 14050,},	-- Booty Bay
		[63003000] = {  achievement = 4995, criteria = 14051,},	-- Crystalvein Mine
		[47002600] = {  achievement = 4995, criteria = 14052,},	-- Gurubashi Arena
		[35003200] = {  achievement = 4995, criteria = 14053,},	-- Hardwrench Hideaway
		[60008200] = {  achievement = 4995, criteria = 14054,},	-- Jaquero Isle
		[50005600] = {  achievement = 4995, criteria = 14055,},	-- Mistvale Valley
		[41005000] = {  achievement = 4995, criteria = 14056,},	-- Nek'mani Wellspring
		[62004300] = {  achievement = 4995, criteria = 14057,},	-- Ruins of Aboraz
		[53003100] = {  achievement = 4995, criteria = 14058,},	-- Ruins of Jubuwal
		[49007800] = {  achievement = 4995, criteria = 14061,},	-- Shore
	}


----------------------------------------------------------------------------------------------------
-- Kalimdor Explorer Points						        AchievementID: 43 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- Explore Durotar Points					       AchievementID: 728 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[1] = { 		-- Explore Durotar: 728
		[43006500] = { achievement = 728, criteria = 822,},	-- Valley of Trials
		[50007900] = { achievement = 728, criteria = 14086,},	-- Northwatch Foothold
		[40004000] = { achievement = 728, criteria = 14087,},	-- Southfury Watershed
		[55007400] = { achievement = 728, criteria = 823,},	-- Sen'jin Village
		[62008100] = { achievement = 728, criteria = 825,},	-- Echo Isles
		[57005700] = { achievement = 728, criteria = 826,},	-- Tiragarde Keep
		[53004300] = { achievement = 728, criteria = 827,},	-- Razor Hill
		[46004900] = { achievement = 728, criteria = 828,},	-- Razormane Grounds
		[40002600] = { achievement = 728, criteria = 829,},	-- Thunder Ridge
		[53002300] = { achievement = 728, criteria = 830,},	-- Drygulch Ravine
		[54001300] = { achievement = 728, criteria = 831,},	-- Skull Rock
		[45000700] = { achievement = 728, criteria = 832,},	-- Orgrimmar
	}
	--------------------------------------------------------------------------------------------
	-- Explore Mulgore Points					       AchievementID: 736 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[7] = { 
		[45007700] = { achievement = 736, criteria = 903,},	-- Red Cloud Mesa
		[34006200] = { achievement = 736, criteria = 904,},	-- Palemane Rock
		[49005800] = { achievement = 736, criteria = 914,},	-- Bloodhoof Village
		[53006600] = { achievement = 736, criteria = 905,},	-- Winterhoof Water Well
		[61006700] = { achievement = 736, criteria = 906,},	-- The Rolling Plains
		[62004800] = { achievement = 736, criteria = 907,},	-- The Venture Co. Mine
		[53004700] = { achievement = 736, criteria = 908,},	-- Ravaged Caravan
		[49003500] = { achievement = 736, criteria = 916,},	-- The Golden Plains
		[44004500] = { achievement = 736, criteria = 909,},	-- Thunderhorn Water Well
		[32004800] = { achievement = 736, criteria = 910,},	-- Bael'dun Digsite
		[60002100] = { achievement = 736, criteria = 912,},	-- Red Rocks
		[52001100] = { achievement = 736, criteria = 913,},	-- Windfury Ridge
		[42001400] = { achievement = 736, criteria = 915,},	-- Wildmane Water Well
	}
	--------------------------------------------------------------------------------------------
	-- Explore Northern Barrens Points					       AchievementID: 750 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[10] = { 
		[66001200] = { achievement = 750, criteria = 917,},	-- Boulder Lode Mine
		[40267495] = { achievement = 750, criteria = 14078, source = "CurseForge", thanks = "Spitebobels", },	-- Lushwater Oasis
		[42001500] = { achievement = 750, criteria = 14079,},	-- The Mor'shan Rampart
		[57961950] = { achievement = 750, criteria = 918, source = "CurseForge", thanks = "Spitebobels", },		-- The Sludge Fen
		[36004500] = { achievement = 750, criteria = 920,},	-- Dreadmist Peak
		[27593168] = { achievement = 750, criteria = 921, source = "CurseForge", thanks = "Spitebobels", },		-- The Dry Hills
		[53004100] = { achievement = 750, criteria = 922,},	-- The Forgotten Pools
		[53844104] = { achievement = 750, criteria = 924, source = "CurseForge", thanks = "Spitebobels", },		-- Grol'dom Farm
		[67703916] = { achievement = 750, criteria = 925, source = "CurseForge", thanks = "Slick1342", },		-- Far Watch Post
		[49005800] = { achievement = 750, criteria = 926,},	-- Thorn Hill
		[67007200] = { achievement = 750, criteria = 927,},	-- The Crossroads
		[70008900] = { achievement = 750, criteria = 928,},	-- The Stagnant Oasis
		[55008000] = { achievement = 750, criteria = 929,},	-- Ratchet
		[68657071] = { achievement = 750, criteria = 930, source = "CurseForge", thanks = "Slick1342", },		-- The Merchant Coast
	}
	--------------------------------------------------------------------------------------------
	-- Explore Teldrassil Points					       AchievementID: 842 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[57] = { 
		[58003600] = { achievement = 842, criteria = 1299,},	-- Shadowglen
		[50203836] = { achievement = 842, criteria = 14088, source = "CurseForge", thanks = "Slick1342", },	-- The Cleft
		[51003800] = { achievement = 842, criteria = 14089,},	-- Dolanaar
		[55005200] = { achievement = 842, criteria = 1300,},	-- Ban'ethil Hollow
		[44006700] = { achievement = 842, criteria = 1302,},	-- Gnarlpine Hold
		[53006000] = { achievement = 842, criteria = 1303,},	-- Lake Al'Ameth
		[42005700] = { achievement = 842, criteria = 1304,},	-- Pools of Arlithrien
		[64005000] = { achievement = 842, criteria = 1305,},	-- Starbreeze Village
		[39002900] = { achievement = 842, criteria = 1306,},	-- The Oracle Glade
		[44003500] = { achievement = 842, criteria = 1307,},	-- Wellspring Lake
		[30004900] = { achievement = 842, criteria = 1308,},	-- Darnassus
		[55009100] = { achievement = 842, criteria = 1309,},	-- Rut'theran Village
	}
	--------------------------------------------------------------------------------------------
	-- Explore Darkshore Points					       AchievementID: 844 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[62] = { 	-- Explore Darkshore: 844
		[38004200] = { achievement = 844, criteria = 1314,},	-- Ruins of Auberdine
		[70001900] = { achievement = 844, criteria = 14090,},	-- Shatterspear Vale
		[62000900] = { achievement = 844, criteria = 14091,},	-- Shatterspear War Camp
		[42007000] = { achievement = 844, criteria = 14092,},	-- Wildbend River
		[43003900] = { achievement = 844, criteria = 14093,},	-- Withering Thicket
		[61002000] = { achievement = 844, criteria = 1315,},	-- Ruins of Mathystra
		[43005300] = { achievement = 844, criteria = 1318,},	-- The Eye of the Vortex
		[43005800] = { achievement = 844, criteria = 1319,},	-- Ameth'Aran
		[50001800] = { achievement = 844, criteria = 1320,},	-- Lor'danel
		[32008400] = { achievement = 844, criteria = 1321,},	-- Nazj'vel
		[40008500] = { achievement = 844, criteria = 1322,},	-- The Master's Glaive
	}
	--------------------------------------------------------------------------------------------
	-- Explore Ashenvale Points					       AchievementID: 845 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[63] = { 
		[13002500] = { achievement = 845, criteria = 1323,},	-- The Zoram Strand
		[26002200] = { achievement = 845, criteria = 14094,},	-- Orendil's Retreat
		[50006600] = { achievement = 845, criteria = 14095,},	-- Silverwind Refuge
		[50004800] = { achievement = 845, criteria = 14096,},	-- Thunder Peak
		[20004000] = { achievement = 845, criteria = 1324,},	-- Lake Falathim
		[27003600] = { achievement = 845, criteria = 1325,},	-- Maestra's Post
		[36003300] = { achievement = 845, criteria = 1326,},	-- Thistlefur Village
		[21005300] = { achievement = 845, criteria = 1327,},	-- The Shrine of Aessina
		[36005000] = { achievement = 845, criteria = 1329,},	-- Astranaar
		[34007000] = { achievement = 845, criteria = 1331,},	-- The Ruins of Stardust
		[53003800] = { achievement = 845, criteria = 1333,},	-- The Howling Vale
		[61005000] = { achievement = 845, criteria = 1334,},	-- Raynewood Retreat
		[66008100] = { achievement = 845, criteria = 1335,},	-- Fallen Sky Lake
		[73006100] = { achievement = 845, criteria = 1336,},	-- Splintertree Post
		[80004900] = { achievement = 845, criteria = 1337,},	-- Satyrnaar
		[92003800] = { achievement = 845, criteria = 1338,},	-- Bough Shadow
		[87005700] = { achievement = 845, criteria = 1339,},	-- Warsong Lumber Camp
		[84007100] = { achievement = 845, criteria = 1340,},	-- Felfire Hill
	}
	--------------------------------------------------------------------------------------------
	-- Explore Thousand Needles Points				       AchievementID: 846 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[64] = { 
		[31002100] = { achievement = 846, criteria = 1341,},	-- The Great Lift
		[48002600] = { achievement = 846, criteria = 14099,},	-- Razorfen Downs
		[67008500] = { achievement = 846, criteria = 14100,},	-- Sunken Dig Site
		[90008300] = { achievement = 846, criteria = 14101,},	-- Southsea Holdfast
		[54006100] = { achievement = 846, criteria = 14102,},	-- The Twilight Withering
		[31005800] = { achievement = 846, criteria = 14103,},	-- Twilight Bulwark
		[13001100] = { achievement = 846, criteria = 14104,},	-- Westreach Summit
		[34003800] = { achievement = 846, criteria = 1342,},	-- Darkcloud Pinnacle
		[45005000] = { achievement = 846, criteria = 1344,},	-- Freewind Post
		[88004800] = { achievement = 846, criteria = 1345,},	-- Splithoof Heights
		[78007200] = { achievement = 846, criteria = 1347,},	-- The Shimmering Deep
		[11003600] = { achievement = 846, criteria = 1349,},	-- Highperch
	}
	--------------------------------------------------------------------------------------------
	-- Explore Stonetalon Mountains Points				       AchievementID: 847 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[65] = { 
		[41003900] = { achievement = 847, criteria = 1350,},	-- Battlescar Valley
		[66006500] = { achievement = 847, criteria = 14105,},	-- Krom'gar Fortress
		[48007600] = { achievement = 847, criteria = 14106,},	-- Ruins of Eldre'thar
		[38003200] = { achievement = 847, criteria = 14107,},	-- Thal'darah Overlook
		[76007600] = { achievement = 847, criteria = 14108,},	-- Unearthed Grounds
		[57007300] = { achievement = 847, criteria = 14109,},	-- Webwinder Hollow
		[58005700] = { achievement = 847, criteria = 14110,},	-- Windshear Hold
		[45003200] = { achievement = 847, criteria = 1351,},	-- Cliffwalker Post
		[70009100] = { achievement = 847, criteria = 1352,},	-- Malaka'jin
		[58006600] = { achievement = 847, criteria = 1353,},	-- Webwinder Path
		[63008700] = { achievement = 847, criteria = 1354,},	-- Boulderslide Ravine
		[75008600] = { achievement = 847, criteria = 1355,},	-- Greatwood Vale
		[68005100] = { achievement = 847, criteria = 1356,},	-- Windshear Crag
		[49006100] = { achievement = 847, criteria = 1357,},	-- Sun Rock Retreat
		[32006800] = { achievement = 847, criteria = 1358,},	-- The Charred Vale
		[51004500] = { achievement = 847, criteria = 1359,},	-- Mirkfallon Lake
		[41002200] = { achievement = 847, criteria = 1360,},	-- Stonetalon Peak
	}
	--------------------------------------------------------------------------------------------
	-- Explore Desolace Points					       AchievementID: 848 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[66] = { 
		[54001000] = { achievement = 848, criteria = 1365,},	-- Tethris Aran
		[36007100] = { achievement = 848, criteria = 14111,},	-- Thargad's Camp
		[65001000] = { achievement = 848, criteria = 1366,},	-- Nijel's Point
		[76002200] = { achievement = 848, criteria = 1367,},	-- Sargeron
		[54002500] = { achievement = 848, criteria = 1368,},	-- Thunder Axe Fortress
		[56004900] = { achievement = 848, criteria = 1373,},	-- Cenarion Wildlands
		[74004600] = { achievement = 848, criteria = 1374,},	-- Magram Territory
		[29000900] = { achievement = 848, criteria = 1375,},	-- Ranazjar Isle
		[33005500] = { achievement = 848, criteria = 1376,},	-- Valley of Spears
		[51005900] = { achievement = 848, criteria = 1377,},	-- Kodo Graveyard
		[24007000] = { achievement = 848, criteria = 1378,},	-- Shadowprey Village
		[37008600] = { achievement = 848, criteria = 1379,},	-- Gelkis Village
		[52007800] = { achievement = 848, criteria = 1380,},	-- Coven
		[71007300] = { achievement = 848, criteria = 1381,},	-- Shok'Thokar
		[79007900] = { achievement = 848, criteria = 1382,},	-- Shadowbreak Ravine
		[37003200] = { achievement = 848, criteria = 1383,},	-- Slitherblade Shore
	}
	--------------------------------------------------------------------------------------------
	-- Explore Feralas Points					       AchievementID: 849 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[69] = { 
		[83004100] = { achievement = 849, criteria = 1395,},	-- Lower Wilds
		[28004900] = { achievement = 849, criteria = 1371,},	-- Ruins of Feathermoon
		[46002000] = { achievement = 849, criteria = 1372,},	-- The Twin Colossals
		[39003600] = { achievement = 849, criteria = 1384,},	-- The Forgotten Coast
		[59004100] = { achievement = 849, criteria = 1385,},	-- Dire Maul
		[55005700] = { achievement = 849, criteria = 1386,},	-- Feral Scar Vale
		[58007200] = { achievement = 849, criteria = 1388,},	-- Ruins of Isildien
		[75006200] = { achievement = 849, criteria = 1389,},	-- The Writhing Deep
		[75004300] = { achievement = 849, criteria = 1390,},	-- Camp Mojache
		[70003800] = { achievement = 849, criteria = 1391,},	-- Grimtotem Compound
		[77003400] = { achievement = 849, criteria = 1392,},	-- Gordunni Outpost
		[64005900] = { achievement = 849, criteria = 1393,},	-- Darkmist Ruins
		[45004900] = { achievement = 849, criteria = 1394,},	-- Feathermoon Stronghold
	}
	--------------------------------------------------------------------------------------------
	-- Explore Dustwallow Marsh Points				       AchievementID: 850 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[70] = { 
		[66004900] = { achievement = 850, criteria = 1361,},	-- Theramore Isle
		[41001100] = { achievement = 850, criteria = 14112,},	-- Blackhoof Village
		[46004700] = { achievement = 850, criteria = 14113,},	-- Direhorn Post
		[41007400] = { achievement = 850, criteria = 14114,},	-- Mudsprocket
		[29004800] = { achievement = 850, criteria = 14115,},	-- Shady Rest Inn
		[61002100] = { achievement = 850, criteria = 1362,},	-- Dreadmurk Shore
		[36003100] = { achievement = 850, criteria = 1363,},	-- Brackenwall Village
		[52007700] = { achievement = 850, criteria = 1397,},	-- Wyrmbog
		[75001800] = { achievement = 850, criteria = 1398,},	-- Alcaz Island
	}
	--------------------------------------------------------------------------------------------
	-- Explore Tanaris Points					       AchievementID: 851 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[71] = { 
		[51002900] = { achievement = 851, criteria = 1405,},	-- Gadgetzan
		[40002800] = { achievement = 851, criteria = 1406,},	-- Sandsorrow Watch
		[37007800] = { achievement = 851, criteria = 1407,},	-- Valley of the Watchers
		[72004700] = { achievement = 851, criteria = 1414,},	-- Lost Rigger Cove
		[45004100] = { achievement = 851, criteria = 1416,},	-- Abyssal Sands
		[52004600] = { achievement = 851, criteria = 1417,},	-- Broken Pillar
		[34004600] = { achievement = 851, criteria = 1418,},	-- The Noxious Lair
		[40005500] = { achievement = 851, criteria = 1419,},	-- Dunemaul Compound
		[68005400] = { achievement = 851, criteria = 1420,},	-- Southbreak Shore
		[54006700] = { achievement = 851, criteria = 1421,},	-- The Gaping Chasm
		[47006400] = { achievement = 851, criteria = 1422,},	-- Eastmoon Ruins
		[53009100] = { achievement = 851, criteria = 1423,},	-- Land's End Beach
		[40007100] = { achievement = 851, criteria = 1424,},	-- Southmoon Ruins
		[31006500] = { achievement = 851, criteria = 1426,},	-- Thistleshrub Valley
		[39001900] = { achievement = 851, criteria = 1427,},	-- Zul'Farrak
		[63005000] = { achievement = 851, criteria = 1428,},	-- Caverns of Time
	}
	--------------------------------------------------------------------------------------------
	-- Explore Azshara Points					       AchievementID: 852 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[76] = { 
		[20005600] = { achievement = 852, criteria = 1409,},	-- Gallywix Pleasure Palace
		[45005000] = { achievement = 852, criteria = 1410,},	-- The Shattered Strand
		[58005100] = { achievement = 852, criteria = 1411,},	-- Bilgewater Harbor
		[57001200] = { achievement = 852, criteria = 1412,},	-- Bitter Reaches
		[80003100] = { achievement = 852, criteria = 1429,},	-- Tower of Eldara
		[71003300] = { achievement = 852, criteria = 1430,},	-- Ruins of Arkkoran
		[50002700] = { achievement = 852, criteria = 1432,},	-- Darnassian Base Camp
		[43007500] = { achievement = 852, criteria = 1433,},	-- The Secret Lab
		[25003800] = { achievement = 852, criteria = 1434,},	-- Bear's Head
		[38003000] = { achievement = 852, criteria = 1435,},	-- Blackmaw Hold
		[24008000] = { achievement = 852, criteria = 1436,},	-- Orgrimmar Rear Gate
		[34005300] = { achievement = 852, criteria = 1438,},	-- Ruins of Eldarath
		[68006900] = { achievement = 852, criteria = 1439,},	-- Southridge Beach
		[64008100] = { achievement = 852, criteria = 1440,},	-- Ravencrest Monument
		[35007400] = { achievement = 852, criteria = 1441,},	-- Lake Mennar
		[58009000] = { achievement = 852, criteria = 1442,},	-- The Ruined Reaches
		[50008200] = { achievement = 852, criteria = 1443,},	-- Storm Cliffs
	}
	--------------------------------------------------------------------------------------------
	-- Explore Felwood Points					       AchievementID: 853 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[77] = { 
		[61001100] = { achievement = 853, criteria = 1401,},	-- Felpaw Village
		[62002600] = { achievement = 853, criteria = 1402,},	-- Talonbranch Glade
		[49002500] = { achievement = 853, criteria = 1403,},	-- Irontree Woods
		[43001800] = { achievement = 853, criteria = 1404,},	-- Jadefire Run
		[42004000] = { achievement = 853, criteria = 1444,},	-- Shatter Scar Vale
		[41004800] = { achievement = 853, criteria = 1445,},	-- Bloodvenom Falls
		[37006000] = { achievement = 853, criteria = 1446,},	-- Jaedenar
		[40007400] = { achievement = 853, criteria = 1447,},	-- Ruins of Constellas
		[41008400] = { achievement = 853, criteria = 1448,},	-- Jadefire Glen
		[51008000] = { achievement = 853, criteria = 1449,},	-- Emerald Sanctuary
		[48009100] = { achievement = 853, criteria = 1450,},	-- Deadwood Village
		[54008900] = { achievement = 853, criteria = 1451,},	-- Morlos'Aran
	}
	--------------------------------------------------------------------------------------------
	-- Explore Un'Goro Crater Points				       AchievementID: 854 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[78] = { 
		[51005000] = { achievement = 854, criteria = 1453,},	-- Fire Plume Ridge
		[63001700] = { achievement = 854, criteria = 14119,},	-- Rock
		[55006200] = { achievement = 854, criteria = 14120,},	-- Marshal's Stand
		[43004100] = { achievement = 854, criteria = 14121,},	-- Mossy Pile
		[69003400] = { achievement = 854, criteria = 14122,},	-- Roiling Gardens
		[30003700] = { achievement = 854, criteria = 14123,},	-- Screaming Reaches
		[30005400] = { achievement = 854, criteria = 1454,},	-- Golakka Hot Springs
		[33007000] = { achievement = 854, criteria = 1455,},	-- Terror Run
		[50007900] = { achievement = 854, criteria = 1456,},	-- The Slithering Scar
		[69006000] = { achievement = 854, criteria = 1457,},	-- The Marshlands
		[80004000] = { achievement = 854, criteria = 1458,},	-- Ironstone Plateau
		[50002500] = { achievement = 854, criteria = 1459,},	-- Lakkari Tar Pits
	}
	--------------------------------------------------------------------------------------------
	-- Explore Moonglade Points					       AchievementID: 855 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[80] = { 
		[55005500] = { achievement = 855, criteria = 1464,},	-- Lake Elune'ara
		[48003900] = { achievement = 855, criteria = 14116,},	-- Nighthaven
		[36004100] = { achievement = 855, criteria = 14117,},	-- Shrine of Remulos
		[66005500] = { achievement = 855, criteria = 14118,},	-- Stormrage Barrow Dens
	}
	--------------------------------------------------------------------------------------------
	-- Explore Silithus Points					       AchievementID: 856 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[81] = { 
		[30001600] = { achievement = 856, criteria = 1460,},	-- The Crystal Vale
		[64004900] = { achievement = 856, criteria = 1462,},	-- Southwind Village
		[54003400] = { achievement = 856, criteria = 1463,},	-- Cenarion Hold
		[31005400] = { achievement = 856, criteria = 1468,},	-- Hive'Zora
		[60007200] = { achievement = 856, criteria = 1469,},	-- Hive'Regal
		[35008000] = { achievement = 856, criteria = 1470,},	-- The Scarab Wall
		[49002300] = { achievement = 856, criteria = 1472,},	-- Hive'Ashi
		[79001900] = { achievement = 856, criteria = 15122,},	-- Valor's Rest
	}
	--------------------------------------------------------------------------------------------
	-- Explore Winterspring Points					       AchievementID: 857 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[83] = { 
		[30003700] = { achievement = 857, criteria = 1473,},	-- Frostfire Hot Springs
		[36005600] = { achievement = 857, criteria = 1474,},	-- Timbermaw Post
		[50005500] = { achievement = 857, criteria = 1475,},	-- Lake Kel'Theril
		[49004000] = { achievement = 857, criteria = 1476,},	-- Starfall Village
		[55006400] = { achievement = 857, criteria = 1477,},	-- Mazthoril
		[59004900] = { achievement = 857, criteria = 1478,},	-- Everlook
		[64007600] = { achievement = 857, criteria = 1481,},	-- Owl Wing Thicket
		[66005500] = { achievement = 857, criteria = 1482,},	-- Ice Thistle Hills
		[66004600] = { achievement = 857, criteria = 1483,},	-- Winterfall Village
		[64002800] = { achievement = 857, criteria = 1484,},	-- The Hidden Grove
		[46001800] = { achievement = 857, criteria = 1485,},	-- Frostsaber Rock
		[60008600] = { achievement = 857, criteria = 1479,},	-- Frostwhisper Gorge
	}
	--------------------------------------------------------------------------------------------
	-- Explore Azuremyst Isle Points				       AchievementID: 860 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[97] = { 
		[77004300] = { achievement = 860, criteria = 1552,},	-- Ammen Vale
		[62005400] = { achievement = 860, criteria = 1553,},	-- Ammen Ford
		[49005000] = { achievement = 860, criteria = 1554,},	-- Azure Watch
		[26006600] = { achievement = 860, criteria = 1555,},	-- Bristlelimb Village
		[58001700] = { achievement = 860, criteria = 1556,},	-- Emberglade
		[47000500] = { achievement = 860, criteria = 1557,},	-- Fairbridge Strand
		[59006800] = { achievement = 860, criteria = 1558,},	-- Geezle's Camp
		[52004200] = { achievement = 860, criteria = 1559,},	-- Moongraze Woods
		[46007100] = { achievement = 860, criteria = 1560,},	-- Odesyus' Landing
		[37005900] = { achievement = 860, criteria = 1561,},	-- Pod Cluster
		[53006100] = { achievement = 860, criteria = 1562,},	-- Pod Wreckage
		[34001200] = { achievement = 860, criteria = 1563,},	-- Silting Shore
		[13008000] = { achievement = 860, criteria = 1564,},	-- Silvermyst Isle
		[45002000] = { achievement = 860, criteria = 1565,},	-- Stillpine Hold
		[31004000] = { achievement = 860, criteria = 1566,},	-- The Exodar
		[21005400] = { achievement = 860, criteria = 1567,},	-- Valaar's Berth
		[32007700] = { achievement = 860, criteria = 1568,},	-- Wrathscale Point
	}
	--------------------------------------------------------------------------------------------
	-- Explore Bloodmyst Isle Points				       AchievementID: 861 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[106] = { 
		[17002800] = { achievement = 861, criteria = 1573,},	-- Amberweb Pass
		[40003300] = { achievement = 861, criteria = 1574,},	-- Axxarien
		[80002600] = { achievement = 861, criteria = 1588,},	-- The Bloodcursed Reef
		[38002000] = { achievement = 861, criteria = 1589,},	-- The Bloodwash
		[66004900] = { achievement = 861, criteria = 1590,},	-- The Crimson Reach
		[31008700] = { achievement = 861, criteria = 1575,},	-- Blacksilt Shore
		[46004500] = { achievement = 861, criteria = 1576,},	-- Bladewood
		[85005100] = { achievement = 861, criteria = 1577,},	-- Bloodcurse Isle
		[54005500] = { achievement = 861, criteria = 1578,},	-- Blood Watch
		[66007800] = { achievement = 861, criteria = 1579,},	-- Bristlelimb Enclave
		[62008900] = { achievement = 861, criteria = 1580,},	-- Kessel's Crossing
		[51007600] = { achievement = 861, criteria = 1581,},	-- Middenvale
		[42008400] = { achievement = 861, criteria = 1582,},	-- Mystwood
		[38007900] = { achievement = 861, criteria = 1583,},	-- Nazzivian
		[55003500] = { achievement = 861, criteria = 1584,},	-- Ragefeather Ridge
		[61004400] = { achievement = 861, criteria = 1585,},	-- Ruins of Loreth'Aran
		[73002000] = { achievement = 861, criteria = 1586,},	-- Talon Stand
		[25004200] = { achievement = 861, criteria = 1587,},	-- Tel'athion's Camp
		[39006100] = { achievement = 861, criteria = 2104,},	-- The Cryo-Core
		[29003600] = { achievement = 861, criteria = 1591,},	-- The Foul Pool
		[34002300] = { achievement = 861, criteria = 1592,},	-- The Hidden Reef
		[57008100] = { achievement = 861, criteria = 1593,},	-- The Lost Fold
		[18005100] = { achievement = 861, criteria = 1594,},	-- The Vector Coil
		[53001600] = { achievement = 861, criteria = 1595,},	-- The Warp Piston
		[74000900] = { achievement = 861, criteria = 1596,},	-- Veridian Point
		[30004500] = { achievement = 861, criteria = 1597,},	-- Vindicator's Rest
		[69006700] = { achievement = 861, criteria = 1598,},	-- Wrathscale Lair
		[71001600] = { achievement = 861, criteria = 1599,},	-- Wyrmscar Island
	}
	--------------------------------------------------------------------------------------------
	-- Explore Southern Barrens Points				      AchievementID: 4996 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[199] = { 
		[49008500] = { achievement = 4996, criteria = 14067,},	-- Bael Modan
		[45006900] = { achievement = 4996, criteria = 14068,},	-- Battlescar
		[49004900] = { achievement = 4996, criteria = 14069,},	-- Forward Command
		[42007700] = { achievement = 4996, criteria = 14070,},	-- Frazzlecraz Motherlode
		[38001300] = { achievement = 4996, criteria = 14071,},	-- Honor's Stand
		[39002000] = { achievement = 4996, criteria = 14072,},	-- Hunter's Hill
		[66004700] = { achievement = 4996, criteria = 14073,},	-- Northwatch Hold
		[41009400] = { achievement = 4996, criteria = 14074,},	-- Razorfen Kraul
		[44005100] = { achievement = 4996, criteria = 14075,},	-- Ruins of Taurajo
		[45003500] = { achievement = 4996, criteria = 14076,},	-- The Overgrowth
		[41004600] = { achievement = 4996, criteria = 14077,},	-- Vendetta Point
	}
	
	----------------------------------------------------------------------------------------------------
-- Outland Explorer Points						        AchievementID: 45 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- Explore Hellfire Peninsula Points				       AchievementID: 862 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[100] = { 
		[86005000] = { achievement = 862, criteria = 1631, source = "CurseForge", thanks="Bubalazzy", },	-- The Stair of Destiny
		[54008300] = { achievement = 862, criteria = 1606,},	-- Expedition Armory
		[27006100] = { achievement = 862, criteria = 1607,},	-- Falcon Watch
		[47005200] = { achievement = 862, criteria = 1608,},	-- Hellfire Citadel
		[55006400] = { achievement = 862, criteria = 1609,},	-- Honor Hold
		[31002800] = { achievement = 862, criteria = 1626,},	-- Mag'har Post
		[40003400] = { achievement = 862, criteria = 1627,},	-- Pools of Aggonar
		[14006000] = { achievement = 862, criteria = 1628,},	-- Ruins of Sha'naar
		[23004000] = { achievement = 862, criteria = 1629,},	-- Temple of Telhamat
		[69005200] = { achievement = 862, criteria = 1630,},	-- The Legion Front
		[55003700] = { achievement = 862, criteria = 1632,},	-- Thrallmar
		[61001800] = { achievement = 862, criteria = 1633,},	-- Throne of Kil'jaeden
		[68007500] = { achievement = 862, criteria = 1634,},	-- Zeth'Gor
		[27007900] = { achievement = 862, criteria = 1635,},	-- Den of Haal'esh
		[14004200] = { achievement = 862, criteria = 1636,},	-- Fallen Sky Ridge
		[78007200] = { achievement = 862, criteria = 1638,},	-- Void Ridge
		[46008400] = { achievement = 862, criteria = 1639,},	-- The Warp Fields
		[64003200] = { achievement = 862, criteria = 1641,},	-- Forge Camp: Mageddon
	}
	--------------------------------------------------------------------------------------------
	-- Explore Zangarmarsh Points					       AchievementID: 863 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[102] = { 
		[78006400] = { achievement = 863, criteria = 1611,},	-- Cenarion Refuge
		[18002100] = { achievement = 863, criteria = 1610,},	-- Ango'rosh Grounds
		[46006400] = { achievement = 863, criteria = 1612,},	-- Feralfen Village
		[32003800] = { achievement = 863, criteria = 1613,},	-- Hewn Bog
		[22004000] = { achievement = 863, criteria = 1647,},	-- Marshlight Lake
		[28006300] = { achievement = 863, criteria = 1648,},	-- Quagg Ridge
		[68004900] = { achievement = 863, criteria = 1649,},	-- Telredor
		[81003900] = { achievement = 863, criteria = 1650,},	-- The Dead Mire
		[58006300] = { achievement = 863, criteria = 1651,},	-- The Lagoon
		[47005000] = { achievement = 863, criteria = 1652,},	-- Twin Spire Ruins
		[82008300] = { achievement = 863, criteria = 1653,},	-- Umbrafen Village
		[18004900] = { achievement = 863, criteria = 1654,},	-- Sporeggar
		[18000700] = { achievement = 863, criteria = 1655,},	-- Ango'rosh Stronghold
		[61004100] = { achievement = 863, criteria = 1656,},	-- Bloodscale Grounds
		[44002500] = { achievement = 863, criteria = 1657,},	-- Orebor Harborage
		[15006100] = { achievement = 863, criteria = 1658,},	-- The Spawning Glen
		[31005000] = { achievement = 863, criteria = 1659,},	-- Zabra'jin
		[70008200] = { achievement = 863, criteria = 1667,},	-- Darkcrest Shore
	}
	--------------------------------------------------------------------------------------------
	-- Explore Shadowmoon Valley Points				       AchievementID: 864 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[104] = { 
		[45002800] = { achievement = 864, criteria = 1614,},	-- Coilskar Point
		[45006800] = { achievement = 864, criteria = 1615,},	-- Eclipse Point
		[22003800] = { achievement = 864, criteria = 1616,},	-- Legion Hold
		[70008500] = { achievement = 864, criteria = 1617,},	-- Netherwing Ledge
		[29002800] = { achievement = 864, criteria = 1668,},	-- Shadowmoon Village
		[72004300] = { achievement = 864, criteria = 1669,},	-- The Black Temple
		[40004100] = { achievement = 864, criteria = 1670,},	-- The Deathforge
		[50004400] = { achievement = 864, criteria = 1671,},	-- The Hand of Gul'dan
		[59004800] = { achievement = 864, criteria = 1672,},	-- Warden's Cage
		[35005700] = { achievement = 864, criteria = 1673,},	-- Wildhammer Stronghold
		[61002800] = { achievement = 864, criteria = 1674,},	-- Altar of Sha'tar
		[29005400] = { achievement = 864, criteria = 1675,},	-- Illidari Point
		[63005800] = { achievement = 864, criteria = 1679,},	-- Netherwing Fields
	}
	--------------------------------------------------------------------------------------------
	-- Explore Blade's Edge Mountains Points			       AchievementID: 865 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[105] = { 
		[51001500] = { achievement = 865, criteria = 1618,},	-- Bash'ir Landing
		[70003600] = { achievement = 865, criteria = 1619,},	-- Bladed Gulch
		[41005200] = { achievement = 865, criteria = 1620,},	-- Bladespire Hold
		[55002600] = { achievement = 865, criteria = 1621,},	-- Bloodmaul Camp
		[45007800] = { achievement = 865, criteria = 1688,},	-- Bloodmaul Outpost
		[80002800] = { achievement = 865, criteria = 1689,},	-- Broken Wilds
		[53004400] = { achievement = 865, criteria = 1690,},	-- Circle of Blood
		[63006500] = { achievement = 865, criteria = 1691,},	-- Death's Door
		[74004100] = { achievement = 865, criteria = 1692,},	-- Forge Camp: Anger
		[29008100] = { achievement = 865, criteria = 1693,},	-- Forge Camp: Terror
		[36004000] = { achievement = 865, criteria = 1694,},	-- Forge Camp: Wrath
		[40002000] = { achievement = 865, criteria = 1695,},	-- Grishnath
		[66002200] = { achievement = 865, criteria = 1696,},	-- Gruul's Lair
		[52007400] = { achievement = 865, criteria = 1697,},	-- Jagged Ridge
		[74006300] = { achievement = 865, criteria = 1698,},	-- Mok'Nathal Village
		[33002500] = { achievement = 865, criteria = 1699,},	-- Raven's Wood
		[60007100] = { achievement = 865, criteria = 1700, source = "CurseForge", thanks="Bubalazzy", },	-- Razor Ridge
		[61003800] = { achievement = 865, criteria = 1701,},	-- Ruuan Weald
		[73002000] = { achievement = 865, criteria = 1702,},	-- Skald
		[37006500] = { achievement = 865, criteria = 1703,},	-- Sylvanaar
		[63001100] = { achievement = 865, criteria = 1704,},	-- Crystal Spine
		[51005700] = { achievement = 865, criteria = 1705,},	-- Thunderlord Stronghold
		[36007600] = { achievement = 865, criteria = 1706,},	-- Veil Lashh
		[65003100] = { achievement = 865, criteria = 2238,},	-- Veil Ruuan
		[74007300] = { achievement = 865, criteria = 1707,},	-- Vekhaar Stand
		[30005900] = { achievement = 865, criteria = 1708,},	-- Vortex Summit
	}
	--------------------------------------------------------------------------------------------
	-- Explore Nagrand Points					       AchievementID: 866 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[107] = { 
		[19005100] = { achievement = 866, criteria = 1622,},	-- Forge Camp: Fear
		[56003600] = { achievement = 866, criteria = 1623,},	-- Garadar
		[42004400] = { achievement = 866, criteria = 1624,},	-- Halaa
		[69008100] = { achievement = 866, criteria = 1625,},	-- Kil'sorrow Fortress
		[46001900] = { achievement = 866, criteria = 1713,},	-- Laughing Skull Ruins
		[36007100] = { achievement = 866, criteria = 1714,},	-- Spirit Fields
		[31004300] = { achievement = 866, criteria = 1715,},	-- Sunspring Post
		[54007000] = { achievement = 866, criteria = 1716,},	-- Telaar
		[65005600] = { achievement = 866, criteria = 1717,},	-- The Ring of Trials
		[60002300] = { achievement = 866, criteria = 1718,},	-- Throne of the Elements
		[26002100] = { achievement = 866, criteria = 1719,},	-- Warmaul Hill
		[76006400] = { achievement = 866, criteria = 1720,},	-- Burning Blade Ruins
		[62006400] = { achievement = 866, criteria = 1721,},	-- Clan Watch
		[24003600] = { achievement = 866, criteria = 1722,},	-- Forge Camp: Hate
		[49005600] = { achievement = 866, criteria = 1723,},	-- Southwind Cleft
		[09004100] = { achievement = 866, criteria = 1724,},	-- The Twilight Ridge
		[72003800] = { achievement = 866, criteria = 1725,},	-- Windyreed Pass
		[73005300] = { achievement = 866, criteria = 1726,},	-- Windyreed Village
		[34002000] = { achievement = 866, criteria = 1727,},	-- Zangar Ridge
	}
	--------------------------------------------------------------------------------------------
	-- Explore Terokkar Forest Points				       AchievementID: 867 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[108] = { 
		[19006800] = { achievement = 867, criteria = 1603,},	-- Bleeding Hollow Ruins
		[57005400] = { achievement = 867, criteria = 4940,},	-- Allerian Stronghold
		[43002200] = { achievement = 867, criteria = 1604,},	-- Cenarion Thicket
		[71003700] = { achievement = 867, criteria = 1605,},	-- Firewing Point
		[39004000] = { achievement = 867, criteria = 1729,},	-- Grangol'var Village
		[49004500] = { achievement = 867, criteria = 1731,},	-- Stonebreaker Hold
		[53003000] = { achievement = 867, criteria = 1732,},	-- Tuurem
		[29002300] = { achievement = 867, criteria = 1733,},	-- Shattrath City
		[58004000] = { achievement = 867, criteria = 1734,},	-- Raastok Glade
		[22001100] = { achievement = 867, criteria = 1735,},	-- The Barrier Hills
		[55001800] = { achievement = 867, criteria = 1736, source = "CurseForge", thanks="Bubalazzy", },		-- Razorthorn Shelf
		[67005200] = { achievement = 867, criteria = 1737,},	-- Bonechewer Ruins
		[34007200] = { achievement = 867, criteria = 1738,},	-- Auchenai Grounds
		[43005300] = { achievement = 867, criteria = 1739,},	-- Carrion Hill
		[37005100] = { achievement = 867, criteria = 1740,},	-- Refugee Caravan
		[39006500] = { achievement = 867, criteria = 1741,},	-- Ring of Observance
		[31005300] = { achievement = 867, criteria = 1742,},	-- Shadow Tomb
		[43007700] = { achievement = 867, criteria = 1743,},	-- Derelict Caravan
		[26005400] = { achievement = 867, criteria = 1745,},	-- Veil Rhaze
		[49006500] = { achievement = 867, criteria = 1746,},	-- Writhing Mound
		[68008200] = { achievement = 867, criteria = 1747,},	-- Skettis
	}
	--------------------------------------------------------------------------------------------
	-- Explore Netherstorm Points					       AchievementID: 843 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[109] = { 
		[33006500] = { achievement = 843, criteria = 1310,},	-- Area 52
		[23007100] = { achievement = 843, criteria = 1311,},	-- Manaforge B'naar
		[48008300] = { achievement = 843, criteria = 1312,},	-- Manaforge Coruu
		[59006700] = { achievement = 843, criteria = 1313,},	-- Manaforge Duro
		[26004000] = { achievement = 843, criteria = 1762,},	-- Manaforge Ara
		[61004000] = { achievement = 843, criteria = 1763,},	-- Manaforge Ultris
		[54002200] = { achievement = 843, criteria = 1764,},	-- Ruins of Farahlon
		[76006500] = { achievement = 843, criteria = 1765,},	-- Tempest Keep
		[30007700] = { achievement = 843, criteria = 1766,},	-- The Heap
		[39007400] = { achievement = 843, criteria = 1767,},	-- Arklon Ruins
		[71003900] = { achievement = 843, criteria = 1768,},	-- Celestial Ridge
		[57008700] = { achievement = 843, criteria = 1770,},	-- Kirin'Var Village
		[49001800] = { achievement = 843, criteria = 1771,},	-- Netherstone
		[33005400] = { achievement = 843, criteria = 1772,},	-- Ruins of Enkaat
		[56007800] = { achievement = 843, criteria = 1773,},	-- Sunfury Hold
		[44003500] = { achievement = 843, criteria = 1775,},	-- The Stormspire
		[21005500] = { achievement = 843, criteria = 1776,},	-- Gyro-Plank Bridge
		[45001000] = { achievement = 843, criteria = 1777,},	-- Eco-Dome Farfield
		[55004300] = { achievement = 843, criteria = 1778,},	-- Ethereum Staging Grounds
		[30001500] = { achievement = 843, criteria = 1779,},	-- Socrethar's Seat
		[37002800] = { achievement = 843, criteria = 1780,},	-- Forge Base: Oblivion
		[45005300] = { achievement = 843, criteria = 1781,},	-- Eco-Dome Midrealm
	}
	
	----------------------------------------------------------------------------------------------------
-- Northrend Explorer Points						        AchievementID: 45 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- Explore Howling Fjord Points					      AchievementID: 1263 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[117] = { 	-- Explore Howling Fjord: 1263
		[29006200] = { achievement = 1263, criteria = 4136,},	-- Kamagua
		[57003600] = { achievement = 1263, criteria = 4137,},	-- Cauldros Isle
		[48001000] = { achievement = 1263, criteria = 4138,},	-- Camp Winterhoof
		[26002400] = { achievement = 1263, criteria = 4139,},	-- Apothecary Camp
		[77002900] = { achievement = 1263, criteria = 4140,},	-- Vengeance Landing
		[31002600] = { achievement = 1263, criteria = 4141,},	-- Steel Gate
		[34007800] = { achievement = 1263, criteria = 4142,},	-- Scalawag Point
		[68005400] = { achievement = 1263, criteria = 4143,},	-- Nifflevar
		[36001100] = { achievement = 1263, criteria = 4144,},	-- Gjalerbron
		[39005000] = { achievement = 1263, criteria = 4146,},	-- Ember Clutch
		[68002500] = { achievement = 1263, criteria = 4147,},	-- Giant's Run
		[61001600] = { achievement = 1263, criteria = 4148,},	-- Fort Wildervar
		[78004700] = { achievement = 1263, criteria = 4149,},	-- Ivald's Ruin
		[49005400] = { achievement = 1263, criteria = 4150,},	-- Halgrind
		[52006700] = { achievement = 1263, criteria = 4151,},	-- New Agamand
		[44003300] = { achievement = 1263, criteria = 4152,},	-- Skorn
		[54001700] = { achievement = 1263, criteria = 4153,},	-- The Twisted Glade
		[58004600] = { achievement = 1263, criteria = 4154,},	-- Utgarde Keep
		[30004200] = { achievement = 1263, criteria = 4155,},	-- Westguard Keep
		[74007000] = { achievement = 1263, criteria = 4157,},	-- Baelgun's Excavation Site
		[66004000] = { achievement = 1263, criteria = 4158,},	-- Baleheim
	}
	--------------------------------------------------------------------------------------------
	-- Explore Borean Tundra Points					      AchievementID: 1264 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[114] = { 
		[86002400] = { achievement = 1264, criteria = 4122,},	-- Temple City of En'kilah
		[49002500] = { achievement = 1264, criteria = 4123,},	-- Steeljaw's Caravan
		[46007800] = { achievement = 1264, criteria = 4124,},	-- Riplash Strand
		[65004800] = { achievement = 1264, criteria = 4125,},	-- Kaskala
		[31005300] = { achievement = 1264, criteria = 4126,},	-- Garrosh's Landing
		[83004400] = { achievement = 1264, criteria = 4127,},	-- Death's Stand
		[27002600] = { achievement = 1264, criteria = 4128,},	-- Coldarra
		[51001000] = { achievement = 1264, criteria = 4129,},	-- Bor'gorok Outpost
		[46003300] = { achievement = 1264, criteria = 4130,},	-- Amber Ledge
		[42005400] = { achievement = 1264, criteria = 4131,},	-- Warsong Hold
		[56007000] = { achievement = 1264, criteria = 4132,},	-- Valiance Keep
		[66002800] = { achievement = 1264, criteria = 4134,},	-- The Geyser Fields
		[75001600] = { achievement = 1264, criteria = 4135,},	-- The Dens of the Dying
	}
	--------------------------------------------------------------------------------------------
	-- Explore Dragonblight Points					      AchievementID: 1265 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[115] = { 
		[55003400] = { achievement = 1265, criteria = 4159,},	-- Galakrond's Rest
		[40006700] = { achievement = 1265, criteria = 4160,},	-- Lake Indu'le
		[39003200] = { achievement = 1265, criteria = 4162,},	-- Obsidian Dragonshrine
		[70007600] = { achievement = 1265, criteria = 4163,},	-- New Hearthglen
		[88004500] = { achievement = 1265, criteria = 4164,},	-- Naxxramas
		[83002700] = { achievement = 1265, criteria = 4165,},	-- Light's Trust
		[25004100] = { achievement = 1265, criteria = 4166,},	-- Icemist Village
		[63007300] = { achievement = 1265, criteria = 4167,},	-- Emerald Dragonshrine
		[50001800] = { achievement = 1265, criteria = 4168,},	-- Coldwind Heights
		[38001900] = { achievement = 1265, criteria = 4170,},	-- Angrathar the Wrath Gate
		[36004700] = { achievement = 1265, criteria = 4171,},	-- Agmar's Hammer
		[60005500] = { achievement = 1265, criteria = 4172,},	-- Wyrmrest Temple
		[14004800] = { achievement = 1265, criteria = 4173,},	-- Westwind Refugee Camp
		[76006100] = { achievement = 1265, criteria = 4174,},	-- Venomspite
		[82007000] = { achievement = 1265, criteria = 4175,},	-- The Forgotten Shore
		[60001800] = { achievement = 1265, criteria = 4176,},	-- The Crystal Vice
		[73002600] = { achievement = 1265, criteria = 4177,},	-- Scarlet Point
	}
	--------------------------------------------------------------------------------------------
	-- Explore Grizzly Hills Points					      AchievementID: 1266 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[116] = { 
		[21006400] = { achievement = 1266, criteria = 4178,},	-- Conquest Hold
		[17002400] = { achievement = 1266, criteria = 4179,},	-- Drak'Tharon Keep
		[71002600] = { achievement = 1266, criteria = 4180,},	-- Drakil'jin Ruins
		[77005900] = { achievement = 1266, criteria = 4181,},	-- Dun Argol
		[16004800] = { achievement = 1266, criteria = 4182,},	-- Granite Springs
		[49004400] = { achievement = 1266, criteria = 4183,},	-- Grizzlemaw
		[48005900] = { achievement = 1266, criteria = 4184,},	-- Rage Fang Shrine
		[67001500] = { achievement = 1266, criteria = 4185,},	-- Thor Modan
		[14008500] = { achievement = 1266, criteria = 4186,},	-- Venture Bay
		[29007400] = { achievement = 1266, criteria = 4187,},	-- Voldrune
		[30005800] = { achievement = 1266, criteria = 4188,},	-- Amberpine Lodge
		[35003800] = { achievement = 1266, criteria = 4189,},	-- Blue Sky Logging Grounds
		[65004500] = { achievement = 1266, criteria = 4190,},	-- Camp Oneqwah
	}
	--------------------------------------------------------------------------------------------
	-- Explore Zul'Drak Points					      AchievementID: 1267 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[121] = { 
		[83001800] = { achievement = 1267, criteria = 4192,},	-- Gundrak
		[41007700] = { achievement = 1267, criteria = 4193,},	-- Drak'Sotra Fields
		[47005700] = { achievement = 1267, criteria = 4194,},	-- Ampitheater of Anguish
		[40004000] = { achievement = 1267, criteria = 4195,},	-- Altar of Sseratus
		[53003500] = { achievement = 1267, criteria = 4196,},	-- Altar of Rhunok
		[77005800] = { achievement = 1267, criteria = 4197,},	-- Altar of Quetz'lun
		[72004500] = { achievement = 1267, criteria = 4198,},	-- Altar of Mam'toth
		[63006900] = { achievement = 1267, criteria = 4199,},	-- Altar of Har'koa
		[59005700] = { achievement = 1267, criteria = 4200,},	-- Zim'Torga
		[21007600] = { achievement = 1267, criteria = 4201,},	-- Zeramas
		[28004600] = { achievement = 1267, criteria = 4202,},	-- Voltarus
		[16005800] = { achievement = 1267, criteria = 4203,},	-- Thrym's End
		[31007400] = { achievement = 1267, criteria = 4204,},	-- Light's Breach
		[61007700] = { achievement = 1267, criteria = 4205,},	-- Kolramas
	}
	--------------------------------------------------------------------------------------------
	-- Explore Sholazar Basin Points				      AchievementID: 1268 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[119] = { 
		[48006400] = { achievement = 1268, criteria = 4206,},	-- River's Heart
		[46002600] = { achievement = 1268, criteria = 4207,},	-- The Savage Thicket
		[36007500] = { achievement = 1268, criteria = 4208,},	-- The Mosslight Pillar
		[80005500] = { achievement = 1268, criteria = 4209,},	-- Makers' Overlook
		[28003900] = { achievement = 1268, criteria = 4210,},	-- Makers' Perch
		[33005200] = { achievement = 1268, criteria = 4211,},	-- The Suntouched Pillar
		[53005600] = { achievement = 1268, criteria = 4212,},	-- Rainspeaker Canopy
		[66005900] = { achievement = 1268, criteria = 4213,},	-- The Lifeblood Pillar
		[73003600] = { achievement = 1268, criteria = 4214,},	-- The Avalanche
		[49003800] = { achievement = 1268, criteria = 4215,},	-- The Glimmering Pillar
		[24008000] = { achievement = 1268, criteria = 4217,},	-- Kartak's Hold
		[23003300] = { achievement = 1268, criteria = 4218,},	-- The Stormwright's Shelf
	}
	--------------------------------------------------------------------------------------------
	-- Explore Storm Peaks Points					      AchievementID: 1269 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[120] = { 
		[48006900] = { achievement = 1269, criteria = 5843,},	-- Brunnhildar Village
		[33003900] = { achievement = 1269, criteria = 5844,},	-- Narvir's Cradle
		[64005900] = { achievement = 1269, criteria = 5845,},	-- Dun Niffelem
		[34006800] = { achievement = 1269, criteria = 5846,},	-- Bor's Breath
		[25006100] = { achievement = 1269, criteria = 5847,},	-- Valkyrion
		[52004900] = { achievement = 1269, criteria = 5848,},	-- Terrace of the Makers
		[34008500] = { achievement = 1269, criteria = 5849,},	-- Sparksocket Minefield
		[40005700] = { achievement = 1269, criteria = 5850,},	-- Engine of the Makers
		[64004600] = { achievement = 1269, criteria = 5851,},	-- Temple of Life
		[41001800] = { achievement = 1269, criteria = 5852,},	-- Ulduar
		[71004900] = { achievement = 1269, criteria = 5853,},	-- Thunderfall
		[33005800] = { achievement = 1269, criteria = 5854,},	-- Temple of Storms
		[27004100] = { achievement = 1269, criteria = 5855,},	-- Snowdrift Plains
		[45008100] = { achievement = 1269, criteria = 5856,},	-- Garm's Bane
		[28007400] = { achievement = 1269, criteria = 5857,},	-- Frosthold
		[24005000] = { achievement = 1269, criteria = 5858,},	-- Nidavelir
	}
	--------------------------------------------------------------------------------------------
	-- Explore Icecrown Points					      AchievementID: 1270 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[118] = { 
		[64004500] = { achievement = 1270, criteria = 5859,},	-- The Bombardment
		[54008700] = { achievement = 1270, criteria = 5860,},	-- Icecrown Citadel
		[09004400] = { achievement = 1270, criteria = 5861,},	-- Onslaught Harbor
		[69006600] = { achievement = 1270, criteria = 5862,},	-- The Broken Front
		[34006800] = { achievement = 1270, criteria = 5863,},	-- The Fleshwerks
		[53003400] = { achievement = 1270, criteria = 5864,},	-- Aldur'thar: The Desolation Gate
		[74003900] = { achievement = 1270, criteria = 5865,},	-- Sindragosa's Fall
		[33002700] = { achievement = 1270, criteria = 5866,},	-- Valhalas
		[84007200] = { achievement = 1270, criteria = 5867, source = "CurseForge", thanks="Bubalazzy", },	-- Valley of Echoes
		[56005600] = { achievement = 1270, criteria = 5868,},	-- Ymirheim
		[44005400] = { achievement = 1270, criteria = 5869,},	-- The Conflagration
		[48006900] = { achievement = 1270, criteria = 5871,},	-- Corp'rethar: The Horror Gate
		[29003700] = { achievement = 1270, criteria = 5872,},	-- Jotunheim
		[78005500] = { achievement = 1270, criteria = 5873,},	-- Scourgeholme
		[43002200] = { achievement = 1270, criteria = 5874,},	-- The Shadow Vault
	}
	--------------------------------------------------------------------------------------------
	-- Explore Crystalsong Forest Points				      AchievementID: 1457 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[127] = { 
		[26006400] = { achievement = 1457, criteria = 5290,},	-- The Azure Front
		[16001300] = { achievement = 1457, criteria = 5291,},	-- The Decrepit Flow
		[76004800] = { achievement = 1457, criteria = 5292,},	-- Sunreaver's Command
		[45004500] = { achievement = 1457, criteria = 5293,},	-- Forlorn Woods
		[74008100] = { achievement = 1457, criteria = 5294,},	-- Windrunner's Overlook
		[13003400] = { achievement = 1457, criteria = 5295,},	-- The Great Tree
		[14004300] = { achievement = 1457, criteria = 5296,},	-- Violet Stand
		[73006300] = { achievement = 1457, criteria = 5297,},	-- The Unbound Thicket
	}
	
	----------------------------------------------------------------------------------------------------
-- Cataclysm Explorer Points						      AchievementID: 4868 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- Explore Hyjal Points						      AchievementID: 4863 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[198] = { 
		[22433801] = { achievement = 4863, criteria = 13795,},	-- Rim of the World
		[43822775] = { achievement = 4863, criteria = 16089,},	-- The Circle of Cinders
		[19505010] = { achievement = 4863, criteria = 13796,},	-- Ashen Lake
		[76146344] = { achievement = 4863, criteria = 13797,},	-- Darkwhisper Gorge
		[72027442] = { achievement = 4863, criteria = 13799,},	-- Gates of Sothann
		[62892400] = { achievement = 4863, criteria = 13800,},	-- Nordrassil
		[32947058] = { achievement = 4863, criteria = 13801,},	-- Sethria's Roost
		[29123287] = { achievement = 4863, criteria = 13802,},	-- Shrine of Goldrinn
		[39185841] = { achievement = 4863, criteria = 13803,},	-- The Flamewake
		[50445298] = { achievement = 4863, criteria = 13804,},	-- The Scorched Plain
		[50777353] = { achievement = 4863, criteria = 13805,},	-- The Throne of Flame
		}
	--------------------------------------------------------------------------------------------
	-- Explore Deepholm Points					      AchievementID: 4864 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[207] = { 
		[62005900] = { achievement = 4864, criteria = 13780,},	-- Deathwing's Fall
		[26003300] = { achievement = 4864, criteria = 15123,},	-- Needlerock Chasm
		[22004800] = { achievement = 4864, criteria = 15124,},	-- Needlerock Slag
		[26007000] = { achievement = 4864, criteria = 15125,},	-- Stonehearth
		[56007600] = { achievement = 4864, criteria = 15126,},	-- Storm's Fury Wreckage
		[49004900] = { achievement = 4864, criteria = 15127,},	-- Temple of Earth
		[41001800] = { achievement = 4864, criteria = 15128,},	-- The Pale Roost
		[56001300] = { achievement = 4864, criteria = 15129,},	-- Therazane's Throne
		[35008200] = { achievement = 4864, criteria = 15130,},	-- The Quaking Fields
		[68007800] = { achievement = 4864, criteria = 15131,},	-- Twilight Overlook
		[39006900] = { achievement = 4864, criteria = 15132,},	-- Masters' Gate
		[72004100] = { achievement = 4864, criteria = 15133,},	-- Crimson Expanse
		}
	--------------------------------------------------------------------------------------------
	-- Explore Twilight Highlands Points				      AchievementID: 4866 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[241] = { 
		[54004100] = { achievement = 4866, criteria = 15139,},	-- Bloodgulch
		[50005600] = { achievement = 4866, criteria = 15140,},	-- Crucible of Carnage
		[47007700] = { achievement = 4866, criteria = 15141,},	-- Crushblow
		[25003700] = { achievement = 4866, criteria = 15142,},	-- Dragonmaw Pass
		[75005700] = { achievement = 4866, criteria = 15143,},	-- Dragonmaw Port
		[46005300] = { achievement = 4866, criteria = 15144,},	-- Dunwald Ruins
		[61005600] = { achievement = 4866, criteria = 15145,},	-- Firebeard's Patrol
		[36003500] = { achievement = 4866, criteria = 15146,},	-- Glopgut's Hollow
		[62004600] = { achievement = 4866, criteria = 15147,},	-- Gorshak War Camp
		[21005500] = { achievement = 4866, criteria = 15148,},	-- Grim Batol
		[78007500] = { achievement = 4866, criteria = 15149,},	-- Highbank
		[54006300] = { achievement = 4866, criteria = 15150,},	-- Highland Forest
		[39002100] = { achievement = 4866, criteria = 15151,},	-- Humboldt Conflagration
		[57001800] = { achievement = 4866, criteria = 15152,},	-- Kirthaven
		[57008100] = { achievement = 4866, criteria = 15153,},	-- Obsidian Forest
		[44001400] = { achievement = 4866, criteria = 15154,},	-- Ruins of Drakgor
		[70004100] = { achievement = 4866, criteria = 15155,},	-- Slithering Cove
		[59003000] = { achievement = 4866, criteria = 15156,},	-- The Black Breach
		[37003900] = { achievement = 4866, criteria = 15157,},	-- The Gullet
		[76001600] = { achievement = 4866, criteria = 15158,},	-- The Krazzworks
		[40004600] = { achievement = 4866, criteria = 15159,},	-- The Twilight Breach
		[47002800] = { achievement = 4866, criteria = 15160,},	-- Thundermar
		[71007100] = { achievement = 4866, criteria = 15161,},	-- Twilight Shore
		[28002500] = { achievement = 4866, criteria = 15162,},	-- Vermillion Redoubt
		[42005800] = { achievement = 4866, criteria = 15163,},	-- Victor's Point
		[29004800] = { achievement = 4866, criteria = 15164,},	-- Wyrms' Bend
		[50001400] = { achievement = 4866, criteria = 15165,},	-- The Maw of Madness
		}
	--------------------------------------------------------------------------------------------
	-- Explore Uldum Points						      AchievementID: 4865 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[249] = { 	-- Explore Uldum: 4865
		[54005100] = { achievement = 4865, criteria = 15166,},	-- Akhenet Fields
		[42007100] = { achievement = 4865, criteria = 15167,},	-- Cradle of the Ancients
		[64001800] = { achievement = 4865, criteria = 15169,},	-- Khartut's Tomb
		[62007300] = { achievement = 4865, criteria = 15170,},	-- Lost City of the Tol'vir
		[48003800] = { achievement = 4865, criteria = 15171,},	-- Mar'at
		[67004100] = { achievement = 4865, criteria = 15172,},	-- Nahom
		[50008100] = { achievement = 4865, criteria = 15173,},	-- Neferset City
		[39002300] = { achievement = 4865, criteria = 15174,},	-- Obelisk of the Moon
		[64002900] = { achievement = 4865, criteria = 15175,},	-- Obelisk of the Stars
		[45005800] = { achievement = 4865, criteria = 15176,},	-- Obelisk of the Sun
		[40004100] = { achievement = 4865, criteria = 15177,},	-- Orsis
		[54003300] = { achievement = 4865, criteria = 15178,},	-- Ramkahen
		[45001400] = { achievement = 4865, criteria = 15179,},	-- Ruins of Ahmtul
		[32006200] = { achievement = 4865, criteria = 15180,},	-- Ruins of Ammon
		[22006100] = { achievement = 4865, criteria = 15181,},	-- Schnottz's Landing
		[60004100] = { achievement = 4865, criteria = 15182,},	-- Tahret Grounds
		[33003100] = { achievement = 4865, criteria = 15183,},	-- Temple of Uldum
		[83005600] = { achievement = 4865, criteria = 15184,},	-- The Cursed Landing
		[71002100] = { achievement = 4865, criteria = 15185,},	-- The Gate of Unending Cycles
		[72005000] = { achievement = 4865, criteria = 15168,},	-- Tombs of the Precursors
		[72006200] = { achievement = 4865, criteria = 15186,},	-- The Trail of Devastation
		[54004200] = { achievement = 4865, criteria = 15187,},	-- Vir'naal Dam
		}
	--------------------------------------------------------------------------------------------
	-- Explore Vashj'ir / Kelp'thar Points				      AchievementID: 4825 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[201] = { 
		[40003000] = { achievement = 4825, criteria = 14138,},	-- Legion's Fate 
		[51002800] = { achievement = 4825, criteria = 14137,},	-- Seafarer's Tomb
		[52005100] = { achievement = 4825, criteria = 14135,},	-- Gurboggle's Ledge
		[60004600] = { achievement = 4825, criteria = 14139,},	-- Skeletal Reef
		[60005800] = { achievement = 4825, criteria = 14134,},	-- Gnaws' Boneyard
		[58007800] = { achievement = 4825, criteria = 14136,},	-- The Clutch
		}
	--------------------------------------------------------------------------------------------
	-- Explore Vashj'ir / Abyssal Depths Points			      AchievementID: 4825 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[204] = { 
		[47002400] = { achievement = 4825, criteria = 14132,},	-- The Scalding Chasm 
		[43002600] = { achievement = 4825, criteria = 14127,},	-- Deepfin Ridge
		[57003300] = { achievement = 4825, criteria = 14131,},	-- Seabrush
 		[43005000] = { achievement = 4825, criteria = 14126,},	-- Underlight Canyon 
		[35005200] = { achievement = 4825, criteria = 14130,},	-- L'Ghorek 
		[33007300] = { achievement = 4825, criteria = 14124,},	-- Abandoned Reef
		[70003000] = { achievement = 4825, criteria = 14125,},	-- Abyssal Breach
		[55006700] = { achievement = 4825, criteria = 14129,},	-- Korthun's End
		}
	--------------------------------------------------------------------------------------------
	-- Explore Vashj'ir / Shimmering Expanse Points			      AchievementID: 4825 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[205] = { 
		[50507640] = { achievement = 4825, criteria = 14140,},	-- Beth'more Ridge
		[49002200] = { achievement = 4825, criteria = 14144,},	-- Shimmering Grotto  
		[50004120] = { achievement = 4825, criteria = 14145,},	-- Silver Tide Hollow
		[48004700] = { achievement = 4825, criteria = 14133,},	-- Glimmeringdeep Gorge
		[51004800] = { achievement = 4825, criteria = 14141,},	-- Nespirah
		[66004500] = { achievement = 4825, criteria = 14142,},	-- Ruins of Thelserai Temple
		[35007800] = { achievement = 4825, criteria = 14143,},	-- Ruins of Vashj'ir
		}
		
		----------------------------------------------------------------------------------------------------
-- Pandaria Explorer Points						      AchievementID: 6974 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- Explore Jade Forest Points					      AchievementID: 6351 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[371] = { 
		[41002100] = { achievement = 6351, criteria = 20088,},	-- Tian Monastery
		[48004500] = { achievement = 6351, criteria = 20087,},	-- Dawn's Blossom
		[52009100] = { achievement = 6351, criteria = 20089,},	-- Dreamer's Pavillion
		[50002600] = { achievement = 6351, criteria = 20090,},	-- Emperor's Omen
		[58008000] = { achievement = 6351, criteria = 20091,},	-- Pearl Lake
		[25004800] = { achievement = 6351, criteria = 20092,},	-- Grookin Hill
		[46002900] = { achievement = 6351, criteria = 20094,},	-- Greenstone Quarry
		[40007300] = { achievement = 6351, criteria = 20095,},	-- Nectarbreeze Orchard
		[25003700] = { achievement = 6351, criteria = 20096,},	-- Camp Nooka Nooka
		[40001300] = { achievement = 6351, criteria = 20097,},	-- Terrace of Ten Thunders
		[47006000] = { achievement = 6351, criteria = 20098,},	-- Serpent's Heart
		[52008200] = { achievement = 6351, criteria = 20099,},	-- Slingtail Pits
		[57005700] = { achievement = 6351, criteria = 20100,},	-- Temple of the Jade Serpent
		[57004400] = { achievement = 6351, criteria = 20101,},	-- The Arboretum
		[46009000] = { achievement = 6351, criteria = 20102,},	-- Garrosh'ar Point
		[65003000] = { achievement = 6351, criteria = 20103,},	-- Windward Isle
		[29001300] = { achievement = 6351, criteria = 22165,},	-- Honeydew Village
	}
	--------------------------------------------------------------------------------------------
	-- Explore Valley of the Four Winds Points			      AchievementID: 6969 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[376] = { 
		[51007700] = { achievement = 6969, criteria = 20105,},	-- Winds' Edge
		[13007600] = { achievement = 6969, criteria = 20106,},	-- Dustback Gorge
		[56003600] = { achievement = 6969, criteria = 20107,},	-- Gilded Fan
		[51006300] = { achievement = 6969, criteria = 20108,},	-- The Imperial Granary
		[54004600] = { achievement = 6969, criteria = 20109,},	-- Halfhill
		[18005500] = { achievement = 6969, criteria = 20110,},	-- Stoneplow
		[31003000] = { achievement = 6969, criteria = 20111,},	-- Kunzen Village
		[68004300] = { achievement = 6969, criteria = 20112,},	-- Mudmug's Place
		[18008100] = { achievement = 6969, criteria = 20113,},	-- Nesingwary Safari
		[16003500] = { achievement = 6969, criteria = 20114,},	-- Paoquan Hollow
		[60002700] = { achievement = 6969, criteria = 20115,},	-- Pools of Purity
		[70006500] = { achievement = 6969, criteria = 20116,},	-- Rumbling Terrace
		[63005700] = { achievement = 6969, criteria = 20117,},	-- Silken Fields
		[25004300] = { achievement = 6969, criteria = 20118,},	-- Singing Marshes
		[34007000] = { achievement = 6969, criteria = 20119,},	-- Stormstout Brewery
		[39003900] = { achievement = 6969, criteria = 20120,},	-- The Heartland
		[75002500] = { achievement = 6969, criteria = 22138,},	-- Thunderfoot Ranch
		[80004100] = { achievement = 6969, criteria = 22139,},	-- Zhu's Descent
	}
	--------------------------------------------------------------------------------------------
	-- Explore Kun-Lai Summit Points				      AchievementID: 6976 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[379] = { 
		[72009100] = { achievement = 6976, criteria = 20146,},	-- Binan Village
		[44008600] = { achievement = 6976, criteria = 20147,},	-- Firebough Nook
		[55009100] = { achievement = 6976, criteria = 20148,},	-- Gate of the August Celestials
		[75001300] = { achievement = 6976, criteria = 20149,},	-- Isle of Reckoning
		[35006500] = { achievement = 6976, criteria = 20150,},	-- Kota Peak
		[59007200] = { achievement = 6976, criteria = 20151,},	-- Mogujia
		[45005100] = { achievement = 6976, criteria = 20152,},	-- Mount Neverest
		[68007300] = { achievement = 6976, criteria = 20153,},	-- Muskpaw Ranch
		[49004000] = { achievement = 6976, criteria = 20154,},	-- Peak of Serenity
		[34004700] = { achievement = 6976, criteria = 20155,},	-- Shado-Pan Monastery
		[68004800] = { achievement = 6976, criteria = 20156,},	-- Temple of the White Tiger
		[47006700] = { achievement = 6976, criteria = 20157,},	-- The Burlap Trail
		[57004700] = { achievement = 6976, criteria = 20158,},	-- Valley of Emperors
		[62002900] = { achievement = 6976, criteria = 20159,},	-- Zouchin Village
	}
	--------------------------------------------------------------------------------------------
	-- Explore Townlong Steppes Points					      AchievementID: 6977 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[388] = { 
		[76008200] = { achievement = 6977, criteria = 20160,},	-- Gao-Ran Battlefront
		[56005600] = { achievement = 6977, criteria = 20161,},	-- Kri'vess
		[54007800] = { achievement = 6977, criteria = 20162,},	-- Rensai's Watchpost
		[41006300] = { achievement = 6977, criteria = 20163,},	-- Niuzao Temple
		[67004700] = { achievement = 6977, criteria = 20164,},	-- Fire Camp Osu
		[84007200] = { achievement = 6977, criteria = 20165,},	-- Hatred's Vice
		[48007000] = { achievement = 6977, criteria = 20166,},	-- Shado-Pan Garrison
		[29002700] = { achievement = 6977, criteria = 20167,},	-- Shan'ze Dao
		[45008600] = { achievement = 6977, criteria = 20168,},	-- Sik'vess
		[22005200] = { achievement = 6977, criteria = 22167,},	-- Sra'vess
		[66006500] = { achievement = 6977, criteria = 20169,},	-- The Sumprushes
	}
	--------------------------------------------------------------------------------------------
	-- Explore Vale of Eternal Blossoms Points			      AchievementID: 6979 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[390] = { 
		[29003700] = { achievement = 6979, criteria = 20320,},	-- Ruins of Guo-Lai
		[38007300] = { achievement = 6979, criteria = 20321,},	-- Mistfall Village
		[80003400] = { achievement = 6979, criteria = 20322,},	-- Mogu'shan Palace
		[21007100] = { achievement = 6979, criteria = 20323,},	-- Setting Sun Garrison
		[46001600] = { achievement = 6979, criteria = 20324,},	-- The Golden Stair
		[86006500] = { achievement = 6979, criteria = 20325,},	-- Shrine of Seven Stars
		[56004300] = { achievement = 6979, criteria = 20326,},	-- The Golden Pagoda
		[47007200] = { achievement = 6979, criteria = 20327,},	-- Tu Shen Burial Ground
		[62002000] = { achievement = 6979, criteria = 20328,},	-- Shrine of Two Moons
		[41004600] = { achievement = 6979, criteria = 20329,},	-- Whitepetal Lake
		[17004500] = { achievement = 6979, criteria = 20330,},	-- The Five Sisters
	}
	--------------------------------------------------------------------------------------------
	-- Explore Krasarang Wilds Points				      AchievementID: 6975 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[418] = { 
		[67004400] = { achievement = 6975, criteria = 20130,},	-- Anglers Wharf
		[33007000] = { achievement = 6975, criteria = 20131,},	-- Cradle of Chi-ji
		[64003100] = { achievement = 6975, criteria = 20132,},	-- Dojani River
		[29003800] = { achievement = 6975, criteria = 20133,},	-- Fallsong Village
		[82002600] = { achievement = 6975, criteria = 20134,},	-- Krasarang Cove
		[70002200] = { achievement = 6975, criteria = 20135,},	-- The Krasari Ruins
		[41007500] = { achievement = 6975, criteria = 20136,},	-- Nayeli Lagoon
		[40003300] = { achievement = 6975, criteria = 20137,},	-- Crane Wing Refuge
		[55003400] = { achievement = 6975, criteria = 20138,},	-- Ruins of Dojan
		[24004500] = { achievement = 6975, criteria = 20139,},	-- Ruins of Korja
		[40005500] = { achievement = 6975, criteria = 20140,},	-- Temple of the Red Crane
		[46003800] = { achievement = 6975, criteria = 20141,},	-- The Deepwild
		[21003500] = { achievement = 6975, criteria = 20142,},	-- The Forbidden Jungle
		[16005600] = { achievement = 6975, criteria = 20143,},	-- The South Isles
		[47009000] = { achievement = 6975, criteria = 20144,},	-- Unga Ingoo
		[77001000] = { achievement = 6975, criteria = 20145,},	-- Zhu's Watch
	}
	--------------------------------------------------------------------------------------------
	-- Explore Dread Wastes Points					      AchievementID: 6978 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[422] = {  
	-- Source: https://www.wowhead.com/achievement = 6978/explore-dread-wastes#comments
		[40003400] = { achievement = 6978, criteria = 20963,},	-- Heart of Fear
		[55003500] = { achievement = 6978, criteria = 20964,},	-- Klaxxi'vess
		[57001700] = { achievement = 6978, criteria = 20965,},	-- Kypari Vor
		[59005700] = { achievement = 6978, criteria = 20966,},	-- Kypari Zar
		[38001800] = { achievement = 6978, criteria = 20967, source = "CurseForge", thanks = "Bluduz",},	-- Rikkitum Village
		[56007000] = { achievement = 6978, criteria = 20968,},	-- Soggy's Gambrle
		[70002500] = { achievement = 6978, criteria = 20969,},	-- Terrace of Gurthan
		[39006500] = { achievement = 6978, criteria = 20970,},	-- The Briny Muck
		[47003500] = { achievement = 6978, criteria = 20971,},	-- The Clutches of Shek'zeer
		[50001100] = { achievement = 6978, criteria = 20972,},	-- The Sunset Brewgarden
		[66004400] = { achievement = 6978, criteria = 20973,},	-- Writhingwood
		[30007500] = { achievement = 6978, criteria = 20974,},	-- Zan'vess
	}


----------------------------------------------------------------------------------------------------
-- Draenor Explorer Points						      AchievementID: 8935 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- Explore Frostfire Ridge Points				      AchievementID: 8937 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[525] = { 
		[30004100] = { achievement = 8937, criteria = 26734,},	-- Bladespire Citadel
		[41701980] = { achievement = 8937, criteria = 26735,},	-- Bloodmaul Stronghold
		[82506040] = { achievement = 8937, criteria = 26736,},	-- Bones of Agurak
		[58303140] = { achievement = 8937, criteria = 26737,},	-- Colossal's Fall
		[44603120] = { achievement = 8937, criteria = 26738,},	-- Daggermaw Ravine
		[31202350] = { achievement = 8937, criteria = 26739,},	-- Frostwind Crag
		[65404730] = { achievement = 8937, criteria = 26740,},	-- Grimfrost Hill
		[59905850] = { achievement = 8937, criteria = 26741,},	-- Grom'gar
		[82005740] = { achievement = 8937, criteria = 26742,},	-- Iron Siegeworks
		[74706120] = { achievement = 8937, criteria = 26743,},	-- Iron Waystation
		[68003200] = { achievement = 8937, criteria = 26744,},	-- Magnarok
		[46405220] = { achievement = 8937, criteria = 26745,},	-- Stonefang Outpost
		[48704680] = { achievement = 8937, criteria = 26746,},	-- The Boneslag
		[52204550] = { achievement = 8937, criteria = 26747,},	-- The Cracking Plains
		[23405410] = { achievement = 8937, criteria = 26748,},	-- Wor'gol
	}
	--------------------------------------------------------------------------------------------
	-- Explore Talador Points					      AchievementID: 8940 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[535] = { 
		[75404320] = { achievement = 8940, criteria = 26192,},	-- Aruuna
		[49706060] = { achievement = 8940, criteria = 26193,},	-- Auchindoun
		[62105020] = { achievement = 8940, criteria = 26194,},	-- Duskfall Island
		[42205810] = { achievement = 8940, criteria = 26195,},	-- Court of Souls
		[68702230] = { achievement = 8940, criteria = 26196,},	-- Fort Wrynn
		[67906860] = { achievement = 8940, criteria = 26197,},	-- Gordal Fortress
		[35707010] = { achievement = 8940, criteria = 26198,},	-- Gul'rok
		[66501030] = { achievement = 8940, criteria = 26199,},	-- The Path of Glory
		[51402620] = { achievement = 8940, criteria = 26200,},	-- Orunai Coast
		[77705550] = { achievement = 8940, criteria = 26201,},	-- Anchorite's Sojourn
		[49703510] = { achievement = 8940, criteria = 26202,},	-- Shattrath City
		[46508900] = { achievement = 8940, criteria = 26203,},	-- Telmor
		[58606510] = { achievement = 8940, criteria = 26204,},	-- Tomb of Lights
		[58603950] = { achievement = 8940, criteria = 26205,},	-- Tuurem
		[78602790] = { achievement = 8940, criteria = 26206,},	-- Zangarra
	}
	--------------------------------------------------------------------------------------------
	-- Explore Shadowmoon Valley Points				      AchievementID: 8938 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[539] = { 
		[38804270] = { achievement = 8938, criteria = 26698,},	-- Anguish Fortress
		[58407900] = { achievement = 8938, criteria = 26699,},	-- Darktide Roost
		[58502820] = { achievement = 8938, criteria = 26700,},	-- Elodor
		[47204140] = { achievement = 8938, criteria = 26701,},	-- Embaari Village
		[36802780] = { achievement = 8938, criteria = 26704,},	-- Gloomshade Grove
		[22702950] = { achievement = 8938, criteria = 26705,},	-- Gul'var
		[71404680] = { achievement = 8938, criteria = 26706,},	-- Karabor
		[41405800] = { achievement = 8938, criteria = 26708,},	-- Shaz'gul
		[58005990] = { achievement = 8938, criteria = 26709,},	-- The Shimmer Moor
		[46806990] = { achievement = 8938, criteria = 26710,},	-- Socrethar's Rise
		[41108020] = { achievement = 8938, criteria = 26712,},	-- Isle of Shadows
	}
	--------------------------------------------------------------------------------------------
	-- Explore Spires of Arak Points				      AchievementID: 8941 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[542] = { 
		[50901260] = { achievement = 8941, criteria = 26754,},	-- Skettis
		[61602460] = { achievement = 8941, criteria = 26755,},	-- Howling Crag
		[36504440] = { achievement = 8941, criteria = 26756,},	-- The Writhing Mire
		[61007030] = { achievement = 8941, criteria = 26757,},	-- Pinchwhistle Gearworks
		[57905520] = { achievement = 8941, criteria = 26758,},	-- Veil Zekk
		[44802410] = { achievement = 8941, criteria = 26759,},	-- Veil Akraz
		[41605880] = { achievement = 8941, criteria = 26760,},	-- Southport
		[47405260] = { achievement = 8941, criteria = 26762,},	-- Windswept Terrace
		[50504690] = { achievement = 8941, criteria = 26763,},	-- Terrace of Dawn
		[60804510] = { achievement = 8941, criteria = 26764,},	-- Sethekk Hollow
		[30902910] = { achievement = 8941, criteria = 26765,},	-- Bladefist Hold
		[39904960] = { achievement = 8941, criteria = 26766,},	-- Admiral Taylor's Garrison
		[72204030] = { achievement = 8941, criteria = 26767,},	-- Lost Veil Anzu
		[56508640] = { achievement = 8941, criteria = 26769,},	-- Pinchwhistle Point
		[53805130] = { achievement = 8941, criteria = 26770,},	-- Ravenskar
		[49005560] = { achievement = 8941, criteria = 26771,},	-- Bloodmane Valley
		[41304590] = { achievement = 8941, criteria = 26772,},	-- Axefall
	}
	--------------------------------------------------------------------------------------------
	-- Explore Gorgrond Points					      AchievementID: 8939 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[543] = { 
		[50507780] = { achievement = 8939, criteria = 26691,},	-- Bastion Rise
		[45407080] = { achievement = 8939, criteria = 26692,},	-- Beaswatch
		[55603350] = { achievement = 8939, criteria = 26693,},	-- Grimrail Depot
		[54906350] = { achievement = 8939, criteria = 26695,},	-- Crimson Fen
		[41407400] = { achievement = 8939, criteria = 26696,},	-- Deadgrin
		[54504470] = { achievement = 8939, criteria = 26697,},	-- Everbloom Wilds
		[44807680] = { achievement = 8939, criteria = 26703,},	-- Evermorn Springs
		[48204270] = { achievement = 8939, criteria = 26707,},	-- Gronn Canyon
		[52305970] = { achievement = 8939, criteria = 26711,},	-- Highpass
		[61305120] = { achievement = 8939, criteria = 26713,},	-- Iyun Weald
		[43006650] = { achievement = 8939, criteria = 26714,},	-- Stonemaul Arena
		[57806550] = { achievement = 8939, criteria = 26715,},	-- Tangleheart
		[43402070] = { achievement = 8939, criteria = 26716,},	-- The Iron Approach
		[47403830] = { achievement = 8939, criteria = 0,},	-- The Pit
	}
	--------------------------------------------------------------------------------------------
	-- Explore Nagrand Points					      AchievementID: 8942 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[550] = { 
		[38005010] = { achievement = 8942, criteria = 26719,},	-- Ancestral Grounds
		[76206840] = { achievement = 8942, criteria = 26721,},	-- Gates of Grommashar
		[84706040] = { achievement = 8942, criteria = 26722,},	-- Hallvalor
		[25801960] = { achievement = 8942, criteria = 26723,},	-- Highmaul Harbor
		[41606940] = { achievement = 8942, criteria = 26724,},	-- Ironfist Harbor
		[51904770] = { achievement = 8942, criteria = 26725,},	-- Lok-rath
		[80406730] = { achievement = 8942, criteria = 26726,},	-- Mar'gok's Overwatch
		[42704140] = { achievement = 8942, criteria = 26727,},	-- Mok'gol Watchpost
		[47006080] = { achievement = 8942, criteria = 26728,},	-- Oshu'gun
		[69206420] = { achievement = 8942, criteria = 26729,},	-- Telaar
		[55901520] = { achievement = 8942, criteria = 26730,},	-- The Ring of Blood
		[80705230] = { achievement = 8942, criteria = 26731,},	-- The Ring of Trials
		[73002060] = { achievement = 8942, criteria = 26732,},	-- Throne of the Elements
		[85402650] = { achievement = 8942, criteria = 26733,},	-- Zangar Shore
	}
	--------------------------------------------------------------------------------------------
	-- Explore Tanaan Jungle Points					     AchievementID: 10260 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[534] = { 
		[73106900] = { achievement = 10260, criteria = 28661,},	-- Zeth'Kur
		[17106480] = { achievement = 10260, criteria = 28662,},	-- Rangari Refuge
		[54707640] = { achievement = 10260, criteria = 28663,},	-- Fang'rila
		[52504680] = { achievement = 10260, criteria = 28664,},	-- The Fel Forge
		[46205310] = { achievement = 10260, criteria = 28665,},	-- Hellfire Citadel
		[11705710] = { achievement = 10260, criteria = 28666,},	-- The Iron Front
		[40804040] = { achievement = 10260, criteria = 28667,},	-- Ironhold Harbor
		[56302700] = { achievement = 10260, criteria = 28668,},	-- Throne of Kil'jaeden
		[24503980] = { achievement = 10260, criteria = 28669,},	-- Ruins of Kra'nak
		[56905530] = { achievement = 10260, criteria = 28670,},	-- Lion's Watch
		[45006840] = { achievement = 10260, criteria = 28671,},	-- Zorammarsh
		[30606460] = { achievement = 10260, criteria = 28672,},	-- Temple of Sha'naar
		[59304960] = { achievement = 10260, criteria = 28673,},	-- Vol'mar
		[25704790] = { achievement = 10260, criteria = 28674,},	-- Zeth'Gol
	}
	
	----------------------------------------------------------------------------------------------------
-- Broken Isles Explorer Points						     AchievementID: 11188 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- Explore Azsuna Points					     AchievementID: 10665 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[630] = {  	-- Explore Azsuna: 10665
		[39605020] = {  achievement = 10665, criteria = 32710,},	-- Faronaar
		[65802790] = {  achievement = 10665, criteria = 32711,},	-- Felblaze Ingress
		[60603490] = {  achievement = 10665, criteria = 32712,},	-- The Greenway
		[46807310] = {  achievement = 10665, criteria = 32713,},	-- Isle of the Watchers
		[41403900] = {  achievement = 10665, criteria = 32714,},	-- Llothien Highlands
		[48001360] = {  achievement = 10665, criteria = 32715,},	-- Lost Orchard
		[55704140] = {  achievement = 10665, criteria = 32716,},	-- Nar'thalas
		[53805890] = {  achievement = 10665, criteria = 32717,},	-- Oceanus Cove
		[65604900] = {  achievement = 10665, criteria = 32718,},	-- Ruined Sanctum
		[57106480] = {  achievement = 10665, criteria = 32719,},	-- Temple of Lights
		[52701680] = {  achievement = 10665, criteria = 32720,},	-- Ley-Ruins of Zarkhenar
		}
	--------------------------------------------------------------------------------------------
	-- Explore Stormheim Points					     AchievementID: 10668 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[634] = {  
		[47204480] = {  achievement = 10668, criteria = 32721,},	-- Aggramar's Vault
		[33903470] = {  achievement = 10668, criteria = 32722,},	-- Blackbeak Overlook
		[55607360] = {  achievement = 10668, criteria = 32723,},	-- Dreadwake's Landing
		[75205480] = {  achievement = 10668, criteria = 32724,},	-- Dreyrgrot
		[72006000] = {  achievement = 10668, criteria = 32725,},	-- Greywatch
		[65506220] = {  achievement = 10668, criteria = 32726,},	-- Gates of Valor
		[73403970] = {  achievement = 10668, criteria = 32727,},	-- Haustvald
		[44306450] = {  achievement = 10668, criteria = 32728,},	-- Hrydshal
		[38802040] = {  achievement = 10668, criteria = 32729,},	-- Maw/Cove of Nashal
		[80105920] = {  achievement = 10668, criteria = 32730,},	-- Morheim
		[44903700] = {  achievement = 10668, criteria = 32731,},	-- Nastrondir
		[69902200] = {  achievement = 10668, criteria = 32732,},	-- Watchman's Rock
		[71505010] = {  achievement = 10668, criteria = 32733,},	-- The Runewood
		[77800670] = {  achievement = 10668, criteria = 32734,},	-- Shield's Rest
		[65706260] = {  achievement = 10668, criteria = 32735,},	-- Skold-Ashil
		[59103120] = {  achievement = 10668, criteria = 32736,},	-- Storm's Reach
		[51405700] = {  achievement = 10668, criteria = 32738,},	-- Talonrest
		[58004440] = {  achievement = 10668, criteria = 32739,},	-- Tideskorn Harbor
		[60405110] = {  achievement = 10668, criteria = 32740,},	-- Valdisdall
		[34505130] = {  achievement = 10668, criteria = 32741,},	-- Weeping Bluffs
		}
	--------------------------------------------------------------------------------------------
	-- Explore Val'sharah Points					     AchievementID: 10666 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[641] = {  
		[67605640] = {  achievement = 10666, criteria = 32683,},	-- Andutalah
		[38805180] = {  achievement = 10666, criteria = 32684,},	-- Black Rook Hold
		[42405860] = {  achievement = 10666, criteria = 32685,},	-- Bradensbrook
		[44203040] = {  achievement = 10666, criteria = 32686,},	-- The Dreamgrove
		[25506650] = {  achievement = 10666, criteria = 32687,},	-- Gloaming Reef
		[51906400] = {  achievement = 10666, criteria = 32688,},	-- Grove of Cenarius
		[54607300] = {  achievement = 10666, criteria = 32689,},	-- Lorlathil
		[71603910] = {  achievement = 10666, criteria = 32690,},	-- Mistvale
		[61207310] = {  achievement = 10666, criteria = 32691,},	-- Moonclaw Vale
		[61103110] = {  achievement = 10666, criteria = 32692,},	-- Shala'nir
		[47308510] = {  achievement = 10666, criteria = 32693,},	-- Smolderhide Thicket
		[54105540] = {  achievement = 10666, criteria = 32694,},	-- Temple of Elune
		[47906960] = {  achievement = 10666, criteria = 32695,},	-- Thas'talah
		}
	--------------------------------------------------------------------------------------------
	-- Explore Highmountain Points					     AchievementID: 10667 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[650] = {  
		[43003350] = {  achievement = 10667, criteria = 32696,},	-- Bloodhunt Highlands
		[29303340] = {  achievement = 10667, criteria = 32697,},	-- Blind Marshlands
		[46007400] = {  achievement = 10667, criteria = 32698,},	-- Frosthoof Watch
		[55608390] = {  achievement = 10667, criteria = 32699,},	-- Ironhorn Enclave
		[27305460] = {  achievement = 10667, criteria = 32700,},	-- Nightwatcher's Perch 
		[43105170] = {  achievement = 10667, criteria = 32701,},	-- Pinerock Basin
		[38906780] = {  achievement = 10667, criteria = 32702,},	-- Riverbend
		[56402180] = {  achievement = 10667, criteria = 32703,},	-- Rockaway Shallows
		[43700870] = {  achievement = 10667, criteria = 32704,},	-- Shipwreck Cove
		[52604480] = {  achievement = 10667, criteria = 32705,},	-- Skyhorn
		[58706470] = {  achievement = 10667, criteria = 32706,},	-- Stonehoof Watch
		[35606360] = {  achievement = 10667, criteria = 32707,},	-- Sylvan Falls
		[46206140] = {  achievement = 10667, criteria = 32708,},	-- Thunder Totem
		[35204570] = {  achievement = 10667, criteria = 32709,},	-- Trueshot Lodge
		}
	--------------------------------------------------------------------------------------------
	-- Explore Suramar Points					      AchievementID: 10669 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[680] = {  
		[30404230] = {  achievement = 10669, criteria = 32780,},	-- Ambervale
		[64004200] = {  achievement = 10669, criteria = 32781,},	-- Crimson Thicket
		[19504520] = {  achievement = 10669, criteria = 32782,},	-- Falanaar
		[34307480] = {  achievement = 10669, criteria = 32783,},	-- Felsoul Hold
		[47305040] = {  achievement = 10669, criteria = 32784,},	-- The Grand Pomenade
		[71505110] = {  achievement = 10669, criteria = 32785,},	-- Jandvik
		[38102290] = {  achievement = 10669, criteria = 32786,},	-- Moon Guard Stronghold
		[34903100] = {  achievement = 10669, criteria = 32787,},	-- Moonwhisper Gulch
		[35005000] = {  achievement = 10669, criteria = 32788, source = "CurseForge", thanks = "Bubalazzy", },	-- Ruins of Elun'eth
		[46105980] = {  achievement = 10669, criteria = 32789,},	-- Suramar City
		[42203550] = {  achievement = 10669, criteria = 32790,},	-- Tel'anor
		}
	--------------------------------------------------------------------------------------------
	-- Explore Argus / Krokuun Points				     AchievementID: 12069 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[830] = {  
		[58905980] = {  achievement = 12069, criteria = 37573,},	-- Annihilan Pits
		[61404490] = {  achievement = 12069, criteria = 37578,},	-- Nath'raxas Hold
		[61206240] = {  achievement = 12069, criteria = 37579,},	-- Petrified Forest
		[42405870] = {  achievement = 12069, criteria = 37583,},	-- Shattered Fields 
		}
	--------------------------------------------------------------------------------------------
	-- Explore Argus / Antoran Wastes Points			     AchievementID: 12069 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[885] = {  
		[68103230] = {  achievement = 12069, criteria = 37575,},	-- Defiled Path
		[64805520] = {  achievement = 12069, criteria = 37576,},	-- Felfire Armory
		[70105870] = {  achievement = 12069, criteria = 37585,},	-- Terminus
		}
	--------------------------------------------------------------------------------------------
	-- Explore Argus / Mac'Aree Points				     AchievementID: 12069 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[882] = {  
		[57005360] = {  achievement = 12069, criteria = 37574,},	-- Conservatory of the Arcane
		[48807000] = {  achievement = 12069, criteria = 37580,},	-- Ruins of Oronaar
		[49706610] = {  achievement = 12069, criteria = 37581,},	-- Azurelight Square
		[38105250] = {  achievement = 12069, criteria = 37582,},	-- Shadowguard Incursion
		[55008040] = {  achievement = 12069, criteria = 37584,},	-- Triumvirate's End
		[29746423] = {  achievement = 12069, criteria = 37586,},	-- Arinor Gardens
	}
	
	----------------------------------------------------------------------------------------------------
-- Battle for Azeroth Explorer Points					     AchievementID: 12988 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- Explore Zuldazar Points					     AchievementID: 12559 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[862] = { 
		[43693910] = { achievement = 12559, criteria = 41731, thanks = "Varenne",},	-- Atal'Dazar
		[78703872] = { achievement = 12559, criteria = 41734, thanks = "Varenne",},	-- Atal'Gral
		[59251877] = { achievement = 12559, criteria = 41735, thanks = "Varenne",},	-- Blood Gate
		[59214163] = { achievement = 12559, criteria = 41737, thanks = "Varenne",},	-- Dazar'alor
		[72356627] = { achievement = 12559, criteria = 41738, thanks = "Varenne",},	-- Dreadpearl Shallows
		[49722655] = { achievement = 12559, criteria = 41740, thanks = "Varenne",},	-- Garden of the Loa
		[69303163] = { achievement = 12559, criteria = 41741, thanks = "Varenne",},	-- Savagelands
		[61112688] = { achievement = 12559, criteria = 41743, thanks = "Varenne",},	-- The Sliver
		[59387795] = { achievement = 12559, criteria = 41744, thanks = "Varenne",},	-- Tusk Isle
		[77624991] = { achievement = 12559, criteria = 41746, thanks = "Varenne",},	-- Talanji's Rebuke
		[45267065] = { achievement = 12559, criteria = 41747, thanks = "Varenne",},	-- Xibala
		[74072068] = { achievement = 12559, criteria = 41749, thanks = "Varenne",},	-- Zeb'ahari
	}
	--------------------------------------------------------------------------------------------
	-- Explore Nazmir Points					     AchievementID: 12561 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[863] = { 
		[37007339] = { achievement = 12561, criteria = 41526, thanks = "Varenne",},	-- Primal Wetlands
		[51615968] = { achievement = 12561, criteria = 41527, thanks = "Varenne",},	-- Heart of Darkness
		[42828327] = { achievement = 12561, criteria = 41528, thanks = "Varenne",},	-- The Rivermarsh
		[39533352] = { achievement = 12561, criteria = 41530, thanks = "Varenne",},	-- The Necropolis
		[30924630] = { achievement = 12561, criteria = 41534, thanks = "Varenne",},	-- Zalamar
		[61662999] = { achievement = 12561, criteria = 41531, thanks = "Varenne",},	-- Torga's Rest
		[65144021] = { achievement = 12561, criteria = 41529, thanks = "Varenne",},	-- Nazwatha
		[63606121] = { achievement = 12561, criteria = 41532, thanks = "Varenne",},	-- Zal'amak
		[71924990] = { achievement = 12561, criteria = 41533, thanks = "Varenne",},	-- The Frogmarsh
	}
	--------------------------------------------------------------------------------------------
	-- Explore Vol'dun Points					     AchievementID: 12560 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[864] = { 
		[44925899] = { achievement = 12560, criteria = 41592, thanks = "Varenne",},	-- Atul'Aman
		[62842679] = { achievement = 12560, criteria = 41593, thanks = "Varenne",},	-- Darkwood Shoal
		[33037682] = { achievement = 12560, criteria = 41594, thanks = "Varenne",},	-- Port of Zem'lan
		[43578794] = { achievement = 12560, criteria = 41595, thanks = "Varenne",},	-- Redrock Harbor
		[39153428] = { achievement = 12560, criteria = 41596, thanks = "Varenne",},	-- Shatterstone Harbor
		[51943305] = { achievement = 12560, criteria = 41597, thanks = "Varenne",},	-- Slithering Gulch
		[53198949] = { achievement = 12560, criteria = 41599, thanks = "Varenne",},	-- Temple of Akunda
		[29205124] = { achievement = 12560, criteria = 41600, thanks = "Varenne",},	-- Terrace of the Devoted
		[43444980] = { achievement = 12560, criteria = 41601, thanks = "Varenne",},	-- The Bone Pit
		[57134145] = { achievement = 12560, criteria = 41602, thanks = "Varenne",},	-- The Brine Basin
		[24046645] = { achievement = 12560, criteria = 41603, thanks = "Varenne",},	-- The Cracked Coast
		[61632133] = { achievement = 12560, criteria = 41604, thanks = "Varenne",},	-- Tortaka Refuge
		[42886142] = { achievement = 12560, criteria = 41605, thanks = "Varenne",},	-- Whistlebloom Oasis
	}
	--------------------------------------------------------------------------------------------
	-- Explore Tiragarde Sound Points				     AchievementID: 12556 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[895] = { 
		[41142680] = { achievement = 12556, criteria = 41799, thanks = "Varenne",},	-- Anglepoint Wharf
		[67153001] = { achievement = 12556, criteria = 41801, thanks = "Varenne",},	-- Boralus
		[71901751] = { achievement = 12556, criteria = 41802, thanks = "Varenne",},	-- Fernwood Ridge
		[76978244] = { achievement = 12556, criteria = 41803, thanks = "Varenne",},	-- Freehold
		[52592867] = { achievement = 12556, criteria = 41804, thanks = "Varenne",},	-- Norwington Estate
		[35502898] = { achievement = 12556, criteria = 41805, thanks = "Varenne",},	-- Krakenbane Cove
		[63966215] = { achievement = 12556, criteria = 41807, thanks = "Varenne",},	-- Abandoned Junkheap
		[76406349] = { achievement = 12556, criteria = 41808, thanks = "Varenne",},	-- Kennings Lodge
		[87127677] = { achievement = 12556, criteria = 41809, thanks = "Varenne",},	-- The Wailing Tideway
		[56016046] = { achievement = 12556, criteria = 41810, thanks = "Varenne",},	-- Vigil Hill
		[42081653] = { achievement = 12556, criteria = 41811, thanks = "Varenne",},	-- Waning Glacier
	}
	--------------------------------------------------------------------------------------------
	-- Explore Drustvar Points					     AchievementID: 12556 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[896] = { 
		[36764889] = { achievement = 12557, criteria = 41685, thanks = "Varenne",},	-- Arom's Stand
		[61194473] = { achievement = 12557, criteria = 41686, thanks = "Varenne",},	-- Barrowknoll Cemetery
		[64943158] = { achievement = 12557, criteria = 41687, thanks = "Varenne",},	-- Carver's Harbor
		[28482742] = { achievement = 12557, criteria = 41688, thanks = "Varenne",},	-- Corlain
		[25515410] = { achievement = 12557, criteria = 41689, thanks = "Varenne",},	-- Crimson Forest
		[56973390] = { achievement = 12557, criteria = 41690, thanks = "Varenne",},	-- Fallhaven
		[67466731] = { achievement = 12557, criteria = 41691, thanks = "Varenne",},	-- Fletcher's Hollow
		[58996666] = { achievement = 12557, criteria = 41692, thanks = "Varenne",},	-- Gol Koval
		[44763744] = { achievement = 12557, criteria = 41693, thanks = "Varenne",},	-- Highroad Pass
		[19360883] = { achievement = 12557, criteria = 41694, thanks = "Varenne",},	-- Western Watch
		[50417313] = { achievement = 12557, criteria = 41695, thanks = "Varenne",},	-- Iceveil Glacier
		[33781326] = { achievement = 12557, criteria = 41696, thanks = "Varenne",},	-- Waycrest Manor
	}
	--------------------------------------------------------------------------------------------
	-- Explore Stormsong Valley Points				     AchievementID: 12558 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[942] = { 
		[56796934] = { achievement = 12558, criteria = 40978, thanks = "Varenne",},	-- Brennadam
		[47467246] = { achievement = 12558, criteria = 40979, thanks = "Varenne",},	-- Briarback Kraul
		[63706427] = { achievement = 12558, criteria = 40980, thanks = "Varenne",},	-- Mariner's Strand
		[49533510] = { achievement = 12558, criteria = 40981, thanks = "Varenne",},	-- Warfang Hold
		[44395236] = { achievement = 12558, criteria = 40982, thanks = "Varenne",},	-- Deadwash
		[36295052] = { achievement = 12558, criteria = 40983, thanks = "Varenne",},	-- Fort Daelin
		[62764096] = { achievement = 12558, criteria = 40984, thanks = "Varenne",},	-- Sagehold
		[78202667] = { achievement = 12558, criteria = 40985, thanks = "Varenne",},	-- Shrine of the Storm
		[29746423] = { achievement = 12558, criteria = 40986, thanks = "Varenne",},	-- Millstone Hamlet
	}
	--------------------------------------------------------------------------------------------
	-- Explore Nazjatar Points					     AchievementID: 13712 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[1355] = { 
		[28604070] = { achievement = 13712, criteria = 46048, thanks = "Varenne",},	-- Ashen Strand
		[61502480] = { achievement = 13712, criteria = 46049, thanks = "Varenne",},	-- Azsh'ari Terrace
		[57505010] = { achievement = 13712, criteria = 46050, thanks = "Varenne",},	-- Coral Forest
		[66202640] = { achievement = 13712, criteria = 46051, thanks = "Varenne",},	-- Deepcoil Tunnels
		[48304850] = { achievement = 13712, criteria = 46052, thanks = "Varenne",},	-- Dragon's Teeth Basin
		[78204490] = { achievement = 13712, criteria = 46053, thanks = "Varenne",},	-- The Drowned Market
		[78803370] = { achievement = 13712, criteria = 46054, thanks = "Varenne",},	-- Elun'alor Temple
		[51601520] = { achievement = 13712, criteria = 46055, thanks = "Varenne",},	-- Gate of the Queen
		[48303540] = { achievement = 13712, criteria = 46056, thanks = "Varenne",},	-- Gorgonian Overlook
		[43106090] = { achievement = 13712, criteria = 46057, thanks = "Varenne",},	-- The Hanging Reef
		[64204230] = { achievement = 13712, criteria = 46058, thanks = "Varenne",},	-- Kal'methir
		[60101560] = { achievement = 13712, criteria = 46059, thanks = "Varenne",},	-- Shirakess Repository
		[38107410] = { achievement = 13712, criteria = 46060, thanks = "Varenne",},	-- Spears of Azshara
		[43104110] = { achievement = 13712, criteria = 46061, thanks = "Varenne",},	-- Zanj'ir Wash
		[38102870] = { achievement = 13712, criteria = 46062, thanks = "Varenne",},	-- Zanj'ir Terrace
		[73203170] = { achievement = 13712, criteria = 46063, thanks = "Varenne",},	-- Zin-Azshari
	}
	--------------------------------------------------------------------------------------------
	-- Explore Mechagon Island Points				     AchievementID: 13776 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[1462] = { 
		[73172923] = { achievement = 13776, criteria = 45991, thanks = "Varenne",},	-- Rustbolt
		[84963476] = { achievement = 13776, criteria = 46041, thanks = "Varenne",},	-- Sparkweaver Point
		[60475423] = { achievement = 13776, criteria = 46043, thanks = "Varenne",},	-- Junkwatt Depot
		[69904011] = { achievement = 13776, criteria = 46042, thanks = "Varenne",},	-- The Heaps
		[65703257] = { achievement = 13776, criteria = 46044, thanks = "Varenne",},	-- Scrapbone Den
		[33196758] = { achievement = 13776, criteria = 46047, thanks = "Varenne",},	-- Western Spray
		[69845848] = { achievement = 13776, criteria = 46045, thanks = "Varenne",},	-- The Outflow
		[49473771] = { achievement = 13776, criteria = 46046, thanks = "Varenne",},	-- The Fleeting Forrest
	}
	
	----------------------------------------------------------------------------------------------------
-- Shadowlands Explorer Points						     AchievementID: 15388 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- Explore Ardenweald Points					     AchievementID: 14304 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[1565] = {
		[61263441] = { achievement = 14304 , criteria = 48543, thanks = "Varenne",},	-- Dusty Burrows
		[31003443] = { achievement = 14304 , criteria = 48544, thanks = "Varenne",},	-- The Stalks
		[64811983] = { achievement = 14304 , criteria = 48545, thanks = "Varenne",},	-- Starlit Overlook
		[52365972] = { achievement = 14304 , criteria = 48546, thanks = "Varenne",},	-- Shimmerbough
		[24946095] = { achievement = 14304 , criteria = 48547, thanks = "Varenne",},	-- Tirna Scithe
		[60235340] = { achievement = 14304 , criteria = 48548, thanks = "Varenne",},	-- Hibernal Hollow
		[47985136] = { achievement = 14304 , criteria = 48549, thanks = "Varenne",},	-- Heart of the Forest
		[53517442] = { achievement = 14304 , criteria = 48550, thanks = "Varenne",},	-- Gormhive
		[51193372] = { achievement = 14304 , criteria = 48551, thanks = "Varenne",},	-- Glitterfall Basin
		[66375570] = { achievement = 14304 , criteria = 48552, thanks = "Varenne",},	-- Tirna Noch
		[35546643] = { achievement = 14304 , criteria = 48553, thanks = "Varenne",},	-- Darkreach
		[72832756] = { achievement = 14304 , criteria = 48554, thanks = "Varenne",},	-- Crumbled Ridge
		[36612949] = { achievement = 14304 , criteria = 48555, thanks = "Varenne",},	-- Gossamer Cliffs
	}
	--------------------------------------------------------------------------------------------
	-- Explore Bastion Points					     AchievementID: 14303 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[1533] = {	
		[45847954] = { achievement = 14303 , criteria = 48532, thanks = "Varenne",},	-- Vestribule of Eternity
		[61224387] = { achievement = 14303 , criteria = 48533, thanks = "Varenne",},	-- Temple of Humility
		[62157360] = { achievement = 14303 , criteria = 48534, thanks = "Varenne",},	-- Purity's Pinnacle
		[51414947] = { achievement = 14303 , criteria = 48535, thanks = "Varenne",},	-- Firstborne's Bounty
		[49885752] = { achievement = 14303 , criteria = 48536, thanks = "Varenne",},	-- The Mnemonic Locus
		[50792101] = { achievement = 14303 , criteria = 48537, thanks = "Varenne",},	-- The Eternal Forge
		[58282882] = { achievement = 14303 , criteria = 48538, thanks = "Varenne",},	-- Elysian Hold
		[27592836] = { achievement = 14303 , criteria = 48539, thanks = "Varenne",},	-- Citadel of Loyalty
		[38005919] = { achievement = 14303 , criteria = 48540, thanks = "Varenne",},	-- Temple of Courage
		[54908232] = { achievement = 14303 , criteria = 48541, thanks = "Varenne",},	-- Aspirant's Crucible
		[46916346] = { achievement = 14303 , criteria = 48542, thanks = "Varenne",},	-- Agthia's Repose
	}
	--------------------------------------------------------------------------------------------
	-- Explore Maldraxxus Points					     AchievementID: 14305 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[1536] = {	
		[49774613] = { achievement = 14305 , criteria = 50085, thanks = "Varenne",},	-- Theater of Pain
		[27993688] = { achievement = 14305 , criteria = 50086, thanks = "Varenne",},	-- The Stitchyard
		[39165540] = { achievement = 14305 , criteria = 50087, thanks = "Varenne",},	-- The Spearhead
		[43312904] = { achievement = 14305 , criteria = 50088, thanks = "Varenne",},	-- Sepulcher of Knowledge
		[50466782] = { achievement = 14305 , criteria = 50089, thanks = "Varenne",},	-- Seat of the Primus
		[59687193] = { achievement = 14305 , criteria = 50091, thanks = "Varenne",},	-- House of Plagues
		[34547728] = { achievement = 14305 , criteria = 50092, thanks = "Varenne",},	-- House of the Chosen
		[63613619] = { achievement = 14305 , criteria = 50093, thanks = "Varenne",},	-- House of Rituals
		[54611638] = { achievement = 14305 , criteria = 50094, thanks = "Varenne",},	-- House of Eyes
		[30022836] = { achievement = 14305 , criteria = 50095, thanks = "Varenne",},	-- House of Constructs
		[65044842] = { achievement = 14305 , criteria = 50096, thanks = "Varenne",},	-- Glutharn's Decay
		[54673240] = { achievement = 14305 , criteria = 50097, thanks = "Varenne",},	-- Forgotten Wounds
		[29695934] = { achievement = 14305 , criteria = 50098, thanks = "Varenne",},	-- Burning Thicket
	}
	--------------------------------------------------------------------------------------------
	-- Explore Revendreth Points					     AchievementID: 14306 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[1525] = {	
		[72896582] = { achievement = 14306 , criteria = 48556, thanks = "Varenne",},	-- Caretaker's Manor
		[75263741] = { achievement = 14306 , criteria = 48557, thanks = "Varenne",},	-- Archivam
		[61237429] = { achievement = 14306 , criteria = 48558, thanks = "Varenne",},	-- Witherfall Ruin
		[66985880] = { achievement = 14306 , criteria = 48559, thanks = "Varenne",},	-- The Endmire
		[65953242] = { achievement = 14306 , criteria = 48560, thanks = "Varenne",},	-- Catacombs of Regret
		[61133879] = { achievement = 14306 , criteria = 48561, thanks = "Varenne",},	-- Old Gate
		[51087841] = { achievement = 14306 , criteria = 48562, thanks = "Varenne",},	-- The Night Market
		[43027136] = { achievement = 14306 , criteria = 48563, thanks = "Varenne",},	-- The Banewood
		[46575951] = { achievement = 14306 , criteria = 48564, thanks = "Varenne",},	-- Stalker's Lodge
		[49295058] = { achievement = 14306 , criteria = 48565, thanks = "Varenne",},	-- Chalice District
		[55083633] = { achievement = 14306 , criteria = 48566, thanks = "Varenne",},	-- Redelav District
		[40948022] = { achievement = 14306 , criteria = 48567, thanks = "Varenne",},	-- Dredhollow
		[29175002] = { achievement = 14306 , criteria = 48568, thanks = "Varenne",},	-- Ember Ward
		[45875086] = { achievement = 14306 , criteria = 48569, thanks = "Varenne",},	-- Darkwall Tower
		[45204559] = { achievement = 14306 , criteria = 48570, thanks = "Varenne",},	-- Court of the Harvesters
		[43543423] = { achievement = 14306 , criteria = 48571, thanks = "Varenne",},	-- Dominance Gate
		[21605517] = { achievement = 14306 , criteria = 48572, thanks = "Varenne",},	-- The Shrouded Asylum
		[25992886] = { achievement = 14306 , criteria = 48573, thanks = "Varenne",},	-- Dominance Keep
	}
	--------------------------------------------------------------------------------------------
	-- The Maw							     AchievementID: 14663 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[1543] = {	
		[23853667] = { achievement = 14663 , criteria = 49501, thanks = "Varenne",},	-- Calcis
		[42864312] = { achievement = 14663 , criteria = 49502, thanks = "Varenne",},	-- Cocyrus
		[16914943] = { achievement = 14663 , criteria = 49503, thanks = "Varenne",},	-- Crucible of the Damned
		[55196209] = { achievement = 14663 , criteria = 49504, thanks = "Varenne",},	-- Desmotaeron
		[31373372] = { achievement = 14663 , criteria = 49505, thanks = "Varenne",},	-- Gorgoa: River of Souls
		[47008086] = { achievement = 14663 , criteria = 49506, thanks = "Varenne",},	-- Marrow's Coppice
		[32886654] = { achievement = 14663 , criteria = 49507, thanks = "Varenne",},	-- Perdition Hold
		[33242161] = { achievement = 14663 , criteria = 49508, thanks = "Varenne",},	-- Planes of Torment
		[62506685] = { achievement = 14663 , criteria = 49509, thanks = "Varenne",},	-- Ravener's Lament
		[23156838] = { achievement = 14663 , criteria = 49510, thanks = "Varenne",},	-- The Altar of Domination
		[49576330] = { achievement = 14663 , criteria = 49511, thanks = "Varenne",},	-- The Beastwarrens
		[38784131] = { achievement = 14663 , criteria = 49512, thanks = "Varenne",},	-- Zovaal's Cauldron
	}
	--------------------------------------------------------------------------------------------
	-- Korthia							     AchievementID: 15053 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[1961] = {
	-- Source: https://www.wowhead.com/achievement=15053/explore-korthia
		[40115298] = { achievement = 15053, criteria = 52092, thanks = "Varenne",},	-- Estuary of Awakening
		[60812408] = { achievement = 15053, criteria = 52094, thanks = "Varenne",},	-- Keeper's Respite
		[57272249] = { achievement = 15053, criteria = 52096, thanks = "Varenne",},	-- Sanctuary of Guidance
		[54965391] = { achievement = 15053, criteria = 52098, thanks = "Varenne",},	-- Seeker's Quorum
		[30215507] = { achievement = 15053, criteria = 52100, thanks = "Varenne",},	-- Windswept Aerie
		[35053494] = { achievement = 15053, criteria = 52093, thanks = "Varenne",},	-- Hope's Ascent
		[53513101] = { achievement = 15053, criteria = 52095, thanks = "Varenne",},	-- Mauler's Outlook
		[61843097] = { achievement = 15053, criteria = 52097, thanks = "Varenne",},	-- Scholar's Den
		[49666462] = { achievement = 15053, criteria = 52099, thanks = "Varenne",},	-- Vault of Secrets
	}
	--------------------------------------------------------------------------------------------
	-- Zereth Mortis						     AchievementID: 15224 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[1970] = {
		[38006300] = { achievement = 15224, criteria = 52855, thanks = "Sipder2",},	-- The Great Veldt
		[40004100] = { achievement = 15224, criteria = 52857, thanks = "Sipder2",},	-- Terrace of Formation
		[57303150] = { achievement = 15224, criteria = 52859, thanks = "Sipder2",},	-- Deserted Overlook
		[59002200] = { achievement = 15224, criteria = 52861, thanks = "Sipder2",},	-- The Dread Portal
		[40007200] = { achievement = 15224, criteria = 52863, thanks = "Sipder2",},	-- Genesis Fields
		[59005100] = { achievement = 15224, criteria = 52865, thanks = "Sipder2",},	-- Pilgrim's Grace
		[66003600] = { achievement = 15224, criteria = 52867, thanks = "Sipder2",},	-- Arrangement Index
		[51002900] = { achievement = 15224, criteria = 52869, thanks = "Sipder2",},	-- Resonant Peaks
		[34006800] = { achievement = 15224, criteria = 52854, thanks = "Sipder2",},	-- Haven
		[36004300] = { achievement = 15224, criteria = 52856, thanks = "Sipder2",},	-- Faith's Repose
		[44008700] = { achievement = 15224, criteria = 52858, thanks = "Sipder2",},	-- Catalyst Gardens
		[52007200] = { achievement = 15224, criteria = 52860, thanks = "Sipder2",},	-- Dimensional Falls
		[46006400] = { achievement = 15224, criteria = 52862, thanks = "Sipder2",},	-- Provis Fauna
		[41003100] = { achievement = 15224, criteria = 52864, thanks = "Sipder2",},	-- Zovaal's Grasp
		[54004700] = { achievement = 15224, criteria = 52866, thanks = "Sipder2",},	-- Plain of Actualization
		[56008400] = { achievement = 15224, criteria = 52868, thanks = "Sipder2",},	-- Lexical Glade
		[27005300] = { achievement = 15224, criteria = 52588, thanks = "Sipder2",},	-- Path of Inception
	}
	
	----------------------------------------------------------------------------------------------------
-- Dragon Isles Explorer Points						     AchievementID: 16761 --
----------------------------------------------------------------------------------------------------

	--------------------------------------------------------------------------------------------
	-- The Waking Shores						     AchievementID: 16400 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[2022] = {  
	-- Source: https://www.wowhead.com/achievement = 16400/explore-the-waking-shores
		[70624430] = {  achievement = 16400, criteria = 55876,	note="(70.62 44.30)", },	-- Dragonheart Outpost
		[78753372] = {  achievement = 16400, criteria = 55886,	note="(78.75 33.72)", },	-- Wild Coast
		[66173709] = {  achievement = 16400, criteria = 55884,	note="(66.17 37.09)", },	-- Scalecracker Keep
		[55042453] = {  achievement = 16400, criteria = 55879,	note="(55.04 24.53)", },	-- Life-Binder Conservatory
		[50634687] = {  achievement = 16400, criteria = 55882,	note="(50.63 46.87)", },	-- Overflowing Rapids
		[74275670] = {  achievement = 16400, criteria = 55885,	note="(74.27 56.70)", },	-- Skytop Observatory
		[56696585] = {  achievement = 16400, criteria = 55883,	note="(56.69 65.85)", },	-- Ruby Life Pools
		[43486662] = {  achievement = 16400, criteria = 55880,	note="(43.48 66.62)", },	-- Obsidian Bulwark
		[29175923] = {  achievement = 16400, criteria = 55881,	note="(29.17 59.23)", },	-- Obsidian Citadel
		[17558868] = {  achievement = 16400, criteria = 55875,	note="(17.55 88.68)", },	-- Apex Canopy
		[40368331] = {  achievement = 16400, criteria = 55877,	note="(40.36 83.31)", },	-- Wild Preserve
		[55958226] = {  achievement = 16400, criteria = 55878,	note="(55.95 82.26)", },	-- Frostflash Assault

	}

	--------------------------------------------------------------------------------------------
	-- Ohn'ahran Plains						     AchievementID: 16457 --
	--------------------------------------------------------------------------------------------
	UniversalExplorer.points[2023] = {  
	-- Source: https://www.wowhead.com/achievement = 16457/explore-the-ohnahran-plains
		[19574934] = {  achievement = 16457, criteria = 55434,	note="(19.57 49.34)", },	-- Ancient Bough
		[46224152] = {  achievement = 16457, criteria = 55435,	note="(46.22 41.52)", },	-- Broadhoof Outpost
		[65992530] = {  achievement = 16457, criteria = 55436,	note="(65.99 25.30)", },	-- Emberwatch
		[29534865] = {  achievement = 16457, criteria = 55437,	note="(29.53 48.65)", },	-- Emerald Gardens
		[71697907] = {  achievement = 16457, criteria = 55438,	note="(71.69 79.07)", },	-- Forkriver Crossing
		[62824132] = {  achievement = 16457, criteria = 55439,	note="(62.82 41.32)", },	-- Maruukai
		[31873701] = {  achievement = 16457, criteria = 55440,	note="(31.87 37.01)", },	-- Nokhudon Hold
		[73964019] = {  achievement = 16457, criteria = 55441,	note="(73.96 40.19)", },	-- Horn of Drusahl
		[84743693] = {  achievement = 16457, criteria = 55442,	note="(84.74 36.93)", },	-- Rusza'thar Reach
		[40386099] = {  achievement = 16457, criteria = 55443,	note="(40.38 60.99)", },	-- Teerakai
		[84302732] = {  achievement = 16457, criteria = 55444,	note="(84.30 27.32)", },	-- Mirewood Fen
		[61306698] = {  achievement = 16457, criteria = 55445,	note="(61.30 66.98)", },	-- Windsong Rise
	}

	--------------------------------------------------------------------------------------------
	-- The Azure Span
	--------------------------------------------------------------------------------------------
UniversalExplorer.points[2024] = {  

	-- Source: https://www.wowhead.com/achievement = 16460/explore-the-azure-span

		[46683984] = {  achievement = 16460, criteria = 55450,	note="(46.68 39.84)", },	-- Camp Antonidas
		[38796273] = {  achievement = 16460, criteria = 55451,	note="(38.79 62.73)", },	-- Azure Archives
		[34913372] = {  achievement = 16460, criteria = 55452,	note="(34.91 33.72)", },	-- Big Tree Hills
		[12843278] = {  achievement = 16460, criteria = 55453,	note="(12.84 32.78)", },	-- Brackenhide Hollow
		[63395854] = {  achievement = 16460, criteria = 55454,	note="(63.39 58.54)", },	-- Camp Nowhere
		[49132272] = {  achievement = 16460, criteria = 55455,	note="(49.13 22.72)", },	-- Cobalt Assembly
		[13184896] = {  achievement = 16460, criteria = 55456,	note="(13.18 48.96)", },	-- Iskaara
		[54135050] = {  achievement = 16460, criteria = 55457,	note="(54.13 50.50)", },	-- Snowhide Den
		[65371633] = {  achievement = 16460, criteria = 55458,	note="(65.37 16.33)", },	-- Theron's Watch
		[19112374] = {  achievement = 16460, criteria = 55459,	note="(19.11 23.74)", },	-- Three-Falls Lookout
		[77563090] = {  achievement = 16460, criteria = 55460,	note="(77.56 30.90)", },	-- Vakthros

	}

	-------------------------------------------------------------------------------
	-- Thaldrazsus
	-------------------------------------------------------------------------------
UniversalExplorer.points[2025] = {  

	-- Source: https://www.wowhead.com/achievement = 16518/explore-thaldrazsus

		[41445676] = {  achievement = 16518, criteria = 55635,	note="(41.44 56.76)", },	-- Valdrakken
		[59955932] = {  achievement = 16518, criteria = 55636,	note="(59.95 59.32)", },	-- Tyrhold
		[51096723] = {  achievement = 16518, criteria = 55637,	note="(51.09 67.23)", },	-- Gelikyr Post
		[37588404] = {  achievement = 16518, criteria = 55638,	note="(37.58 84.04)", },	-- South Hold Gate
		[60008204] = {  achievement = 16518, criteria = 55639,	note="(60.00 82.04)", },	-- Temporal Conflux
		[58244261] = {  achievement = 16518, criteria = 55640,	note="(58.24 42.61)", },	-- Algeth'ar Academy
		[72555629] = {  achievement = 16518, criteria = 55641,	note="(72.55 56.29)", },	-- Vault of the Incarnates
		[62141867] = {  achievement = 16518, criteria = 55643,	note="(62.14 18.67)", },	-- Veiled Ossuary

	}
	-------------------------------------------------------------------------------
	-- The Forbidden Reach / No Data Yet
	-------------------------------------------------------------------------------
UniversalExplorer.points[2118] = {  

	-- Source: https://www.wowhead.com/achievement = 16452/explore-the-forbidden-reach

		[44106180] = {  achievement = 16452, criteria = 55420,	note="(44.1 , 61.8)", },	-- The Old Weyrn Grounds
		[70206440] = {  achievement = 16452, criteria = 55421,	note="(70.2 , 64.4)", },	-- Caldera of the Menders
		[36603270] = {  achievement = 16452, criteria = 55422,	note="(36.6 , 32.7)", },	-- Stormsunder Crater
		[56802800] = {  achievement = 16452, criteria = 55423,	note="(56.8 , 28.0)", },	-- Froststone Vault

	}
--}