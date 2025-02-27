--[[
                                ----o----(||)----oo----(||)----o----

                                     Adorable Raptor Hatchlings

                                     v2.06 - 25th December 2024
                                Copyright (C) Taraezor / Chris Birch
                                         All Rights Reserved
								
                                ----o----(||)----oo----(||)----o----
]]

local AdorableRaptorHatchlings = {}
AdorableRaptorHatchlings.db = {}
-- From Data.lua
AdorableRaptorHatchlings.points, AdorableRaptorHatchlings.textures, AdorableRaptorHatchlings.scaling = {}, {}, {}
-- Purple theme
AdorableRaptorHatchlings.colour = {}
AdorableRaptorHatchlings.colour.prefix	= "\124cFF8258FA"
AdorableRaptorHatchlings.colour.highlight = "\124cFFB19EFF"
AdorableRaptorHatchlings.colour.plaintext = "\124cFF819FF7"

local defaults = { profile = { iconScale = 2.5, iconAlpha = 1, showCoords = true,
								hidePetLimit = 3, iconChoice = 9 } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetSubZoneText = _G.GetSubZoneText
local IsControlKeyDown = _G.IsControlKeyDown
local IsIndoors = _G.IsIndoors
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local next = _G.next

local HandyNotes = _G.HandyNotes

AdorableRaptorHatchlings.version = 110007 --GetBuildInfo()

-- Clarify what's going on here:
-- Map IDs: The nests were added in WotLK
-- WotLK Classic: Use 14xx series mapIDs but original pre-Cata coordinates
-- Classic Cataclysm+: Use 14xx series mapIDs but Retail coordinates
-- Retail: Use Retail mapIDs and Retail coordinates
-- The Barrens (W) coordinates are different to Northern Barrens (R)
-- The Wetlands implementation between (W) and (R) is also different
-- So here: Differentiating between Retail and Classic. Later, further differentiate between WotLK and Cata+
AdorableRaptorHatchlings.kalimdor = (AdorableRaptorHatchlings.version < 60000) and 1414 or 12
AdorableRaptorHatchlings.easternKingdom = (AdorableRaptorHatchlings.version < 60000) and 1415 or 13
AdorableRaptorHatchlings.dalaran = (AdorableRaptorHatchlings.version < 60000) and 125 or 125
AdorableRaptorHatchlings.dustwallowMarsh = (AdorableRaptorHatchlings.version < 60000) and 1445 or 70
AdorableRaptorHatchlings.barrens = (AdorableRaptorHatchlings.version < 60000) and 1413 or 10
AdorableRaptorHatchlings.unGoroCrater = (AdorableRaptorHatchlings.version < 60000) and 1449 or 78
AdorableRaptorHatchlings.wetlands = (AdorableRaptorHatchlings.version < 60000) and 1437 or 56
continents[AdorableRaptorHatchlings.kalimdor] = true
continents[AdorableRaptorHatchlings.easternKingdom] = true
-- Initially, the Azeroth map did not populate correctly when testing 4.4.0 Classic
--     Here Be Dragons plugin problem? Watch for this at Classic Pandaria launch
continents[ 947 ] = true -- Azeroth

-- Localisation
AdorableRaptorHatchlings.locale = GetLocale()
local L = {}
setmetatable( L, { __index = function( L, key ) return key end } )
local realm = GetNormalizedRealmName() -- On a fresh login this will return null
AdorableRaptorHatchlings.oceania = { AmanThul = true, Barthilas = true, Caelestrasz = true, DathRemar = true,
			Dreadmaul = true, Frostmourne = true, Gundrak = true, JubeiThos = true, 
			Khazgoroth = true, Nagrand = true, Saurfang = true, Thaurissan = true,
			Yojamba = true, Remulos = true, Arugal = true, Felstriker = true,
			Penance = true, Shadowstrike = true, Maladath = true, }			
if AdorableRaptorHatchlings.oceania[realm] then
	AdorableRaptorHatchlings.locale = "enGB"
end

if AdorableRaptorHatchlings.locale == "zhCN" then
	L["Character"] = "角色"
	L["Account"] = "账号"
	L["Completed"] = "已完成"
	L["Not Completed"] = "未完成"
	L["Options"] = "选项"
	L["Map Pin Size"] = "地图图钉的大小"
	L["The Map Pin Size"] = "地图图钉的大小"
	L["Map Pin Alpha"] = "地图图钉的透明度"
	L["The alpha transparency of the map pins"] = "地图图钉的透明度"
	L["Show Coordinates"] = "显示坐标"
	L["Show Coordinates Description"] = "在世界地图和迷你地图上的工具提示中" ..AdorableRaptorHatchlings.colour.highlight .."显示坐标"
	L["Map Pin Selections"] = "地图图钉选择"
	L["Gold"] = "金子"
	L["Red"] = "红"
	L["Blue"] = "蓝"
	L["Green"] = "绿色"
	L["Ring"] = "戒指"
	L["Cross"] = "叉"
	L["Diamond"] = "钻石"
	L["Frost"] = "冰霜"
	L["Cogwheel"] = "齿轮"
	L["White"] = "白色"
	L["Purple"] = "紫色"
	L["Yellow"] = "黄色"
	L["Grey"] = "灰色"
	L["Mana Orb"] = "法力球"
	L["Phasing"] = "同步"
	L["Raptor egg"] = "迅猛龙蛋"
	L["Stars"] = "星星"
	L["Screw"] = "拧"
	L["Notes"] = "笔记"
	L["Left"] = "左"
	L["Right"] = "右"
	L["Try later"] = "目前不可能。稍后再试"

elseif AdorableRaptorHatchlings.locale == "zhTW" then
	L["Character"] = "角色"
	L["Account"] = "賬號"
	L["Completed"] = "完成"
	L["Not Completed"] = "未完成"
	L["Options"] = "選項"
	L["Map Pin Size"] = "地圖圖釘的大小"
	L["The Map Pin Size"] = "地圖圖釘的大小"
	L["Map Pin Alpha"] = "地圖圖釘的透明度"
	L["The alpha transparency of the map pins"] = "地圖圖釘的透明度"
	L["Show Coordinates"] = "顯示坐標"
	L["Show Coordinates Description"] = "在世界地圖和迷你地圖上的工具提示中" ..AdorableRaptorHatchlings.colour.highlight .."顯示坐標"
	L["Map Pin Selections"] = "地圖圖釘選擇"
	L["Gold"] = "金子"
	L["Red"] = "紅"
	L["Blue"] = "藍"
	L["Green"] = "綠色"
	L["Ring"] = "戒指"
	L["Cross"] = "叉"
	L["Diamond"] = "钻石"
	L["Frost"] = "霜"
	L["Cogwheel"] = "齒輪"
	L["White"] = "白色"
	L["Purple"] = "紫色"
	L["Yellow"] = "黃色"
	L["Grey"] = "灰色"
	L["Mana Orb"] = "法力球"
	L["Phasing"] = "同步"
	L["Raptor egg"] = "迅猛龍蛋"
	L["Stars"] = "星星"
	L["Screw"] = "擰"
	L["Notes"] = "筆記"
	L["Left"] = "左"
	L["Right"] = "右"
	L["Try later"] = "目前不可能。稍後再試"

else
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
	L["Try later"] = "Not possible at this time. Try later"
	if AdorableRaptorHatchlings.locale == "enUS" then
		L["Grey"] = "Gray"
	end
end

if AdorableRaptorHatchlings.locale == "zhCN" then
	L["AddOn Description"] = AdorableRaptorHatchlings.colour.highlight .."帮助您找到" ..AdorableRaptorHatchlings.colour.prefix .."可爱的迅猛龙宝"
		..AdorableRaptorHatchlings.colour.highlight .."巢穴."
	L["Adorable Raptor Hatchling"] = "可爱的迅猛龙宝"
	L["Adorable Raptor Hatchlings"] = "可爱的迅猛龙宝"
	L["Always show"] = "始终显示"
	L["Cave Entrance"] = "洞入口"
	L["Dart's Nest"] = "达尔特的巢"
	L["Darting Hatchling"] = "小达尔特"
	L["Deviate Hatchling"] = "变异幼龙"
	L["Hatchling"] = "幼体"
	L["Leaping Hatchling"] = "小塔克"
	L["Less than the Maximum"] = "小于最大值"
	L["Obsidian Hatchling"] = "黑曜石幼龙"
	L["One is enough"] = "一个就够了"
	L["Raptor Ridge"] = "恐龙岭"
	L["Ravasaur Hatchling"] = "暴掠幼龙"
	L["Ravasaur Matriarch's Nest"] = "暴掠龙女王的巢"
	L["Razormaw Hatchling"] = "刺喉幼龙"
	L["Razormaw Matriarch's Nest"] = "刺喉雌龙的巢"
	L["Show/Hide Pins"] = "显示/隐藏图钉"
	L["Takk's Nest"] = "塔克的巢"
	L["Under the foliage"] = "在树叶下"
	L["Veer to the right"] = "当你进入洞穴时向右转。\n从右侧进入巢穴"
	
elseif AdorableRaptorHatchlings.locale == "zhTW" then
	L["AddOn Description"] = AdorableRaptorHatchlings.colour.highlight .."幫助您找到" ..AdorableRaptorHatchlings.colour.prefix .."可愛的迅猛龍寶"
		..AdorableRaptorHatchlings.colour.highlight .."巢穴."
	L["Adorable Raptor Hatchling"] = "可愛的迅猛龍寶"
	L["Adorable Raptor Hatchlings"] = "可愛的迅猛龍寶"
	L["Always show"] = "始終顯示"
	L["Cave Entrance"] = "洞入口"
	L["Dart's Nest"] = "達爾特的巢"
	L["Darting Hatchling"] = "小達爾特"
	L["Deviate Hatchling"] = "變異幼龍"
	L["Hatchling"] = "幼體"
	L["Leaping Hatchling"] = "小塔克"
	L["Less than the Maximum"] = "小於最大值"
	L["Obsidian Hatchling"] = "黑曜石幼龍"
	L["One is enough"] = "一個就夠了"
	L["Raptor Ridge"] = "恐龍嶺"
	L["Ravasaur Hatchling"] = "暴掠幼龍"
	L["Ravasaur Matriarch's Nest"] = "暴掠龍女王的巢"
	L["Razormaw Hatchling"] = "刺喉幼龍"
	L["Razormaw Matriarch's Nest"] = "刺喉雌龍的巢"
	L["Show/Hide Pins"] = "顯示/隱藏圖釘"
	L["Takk's Nest"] = "塔克的巢"
	L["Under the foliage"] = "在樹葉下"
	L["Veer to the right"] = "當你進入洞穴時向右轉。\n從右側進入巢穴"
	
else
	L["AddOn Description"] = AdorableRaptorHatchlings.colour.highlight .."Helps you find the nests of the "
		..AdorableRaptorHatchlings.colour.prefix .."adorable raptor hatchlings"	
	L["Veer to the right"] = "Veer to the right as you enter the cave.\nAccess the nest from the right side"
end

-- Plugin handler for HandyNotes
function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local pin = AdorableRaptorHatchlings.points[ mapFile ] and AdorableRaptorHatchlings.points[ mapFile ][ coord ]

	GameTooltip:SetText( AdorableRaptorHatchlings.colour.prefix ..L[ pin.title ] )
	GameTooltip:AddLine( AdorableRaptorHatchlings.colour.highlight ..L[ pin.petName ] )
	local numColl, limitColl = C_PetJournal.GetNumCollectedInfo( pin.speciesID )
	GameTooltip:AddLine( AdorableRaptorHatchlings.colour.plaintext .." (" ..numColl .."/" ..limitColl ..")" )
	GameTooltip:AddTexture( pin.petTexture, { width=32, height=32 } )
	if pin.tip then GameTooltip:AddLine( "\n" ..AdorableRaptorHatchlings.colour.plaintext ..L[ pin.tip ] ) end
	
	if AdorableRaptorHatchlings.db.showCoords == true then
		local mX, mY = HandyNotes:getXY(coord)
		mX, mY = mX*100, mY*100
		GameTooltip:AddLine( AdorableRaptorHatchlings.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
	end

	GameTooltip:Show()
end

function pluginHandler:OnLeave()
	GameTooltip:Hide()
end

local function PassPetCheck( pin )

	if AdorableRaptorHatchlings.db then
		if AdorableRaptorHatchlings.db.hidePetLimit > 1 then
			local numColl, limitColl = C_PetJournal.GetNumCollectedInfo( pin.speciesID )
			if numColl then
				if numColl >= 1 then
					if AdorableRaptorHatchlings.db.hidePetLimit == 2 then
						return false
					end
					if numColl >= limitColl then
						return false
					end
				end
			end
		end
	end	
	return true
end

do
    local bucket = CreateFrame("Frame")
    bucket.elapsed = 0
    bucket:SetScript("OnUpdate", function(self, elapsed)
        self.elapsed = self.elapsed + elapsed
        if self.elapsed > 1.5 then
            self.elapsed = 0
			local insideCave = ( GetSubZoneText() == L[ "Raptor Ridge" ] and IsIndoors() ) and true or false
			if AdorableRaptorHatchlings.insideCave == nil then
				AdorableRaptorHatchlings.insideCave = insideCave
			elseif AdorableRaptorHatchlings.insideCave ~= insideCave then
				AdorableRaptorHatchlings.insideCave = insideCave
				pluginHandler:Refresh()
			end
        end
    end)

	if AdorableRaptorHatchlings.insideCave == nil then
		AdorableRaptorHatchlings.insideCave = ( GetSubZoneText() == L[ "Raptor Ridge" ] and IsIndoors() ) and true or false
	end

	local function iterator(t, prev)
		if not t then return end
		local coord, v = next(t, prev)
		while coord do
			if v and PassPetCheck( v ) then
				-- Wetlands special: Show the cave entrance if outside the cave, otherwise show the actual location once inside the cave
				if v.title == L[ "Razormaw Matriarch's Nest" ] then
					if AdorableRaptorHatchlings.insideCave == true then
						if (AdorableRaptorHatchlings.version < 40000) then
							if (v.version == "W") then
								return coord, nil, AdorableRaptorHatchlings.textures[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconScale * AdorableRaptorHatchlings.scaling[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconAlpha
							end
						elseif (v.version == "R") then
							return coord, nil, AdorableRaptorHatchlings.textures[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconScale * AdorableRaptorHatchlings.scaling[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconAlpha
						end
					elseif v.version == "E" then
						return coord, nil, AdorableRaptorHatchlings.textures[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconScale * AdorableRaptorHatchlings.scaling[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconAlpha
					end
				elseif ( (v.version == "R") or (v.version == "W") ) then
					if (AdorableRaptorHatchlings.version < 40000) then
						if (v.version == "W") then
							return coord, nil, AdorableRaptorHatchlings.textures[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconScale * AdorableRaptorHatchlings.scaling[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconAlpha
						end
					elseif (v.version == "R") then
						return coord, nil, AdorableRaptorHatchlings.textures[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconScale * AdorableRaptorHatchlings.scaling[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconAlpha
					end
				else
					return coord, nil, AdorableRaptorHatchlings.textures[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconScale * AdorableRaptorHatchlings.scaling[AdorableRaptorHatchlings.db.iconChoice], AdorableRaptorHatchlings.db.iconAlpha
				end
			end
			coord, v = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		AdorableRaptorHatchlings.mapID = mapID
		return iterator, AdorableRaptorHatchlings.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> Adorable Raptor Hatchlings options
AdorableRaptorHatchlings.options = {
	type = "group",
	name = L["Adorable Raptor Hatchlings"],
	desc = L["AddOn Description"],
	get = function(info) return AdorableRaptorHatchlings.db[info[#info]] end,
	set = function(info, v)
		AdorableRaptorHatchlings.db[info[#info]] = v
		pluginHandler:Refresh()
	end,
	args = {
		options = {
			type = "group",
			-- Add a " " to force this to be before the first group. HN arranges alphabetically on local language
			name = " " ..L["Options"],
			inline = true,
			args = {
				iconScale = {
					type = "range",
					name = L["Map Pin Size"],
					desc = L["The Map Pin Size"],
					min = 1, max = 4, step = 0.1,
					arg = "iconScale",
					order = 1,
				},
				iconAlpha = {
					type = "range",
					name = L["Map Pin Alpha"],
					desc = L["The alpha transparency of the map pins"],
					min = 0, max = 1, step = 0.01,
					arg = "iconAlpha",
					order = 2,
				},
				hidePetLimit = {
					type = "range",
					name = L["Show/Hide Pins"],
					desc = "1 = " ..L["Always show"] .."\n2 = " ..L["One is enough"] .."\n3 = " ..L["Less than the Maximum"],
					min = 1, max = 3, step = 1,
					arg = "hidePetLimit",
					order = 3,
				},
				showCoords = {
					name = L["Show Coordinates"],
					desc = L["Show Coordinates Description"] 
							..AdorableRaptorHatchlings.colour.highlight .."\n(xx.xx,yy.yy)",
					type = "toggle",
					width = "full",
					arg = "showCoords",
					order = 4,
				},
			},
		},
		icon = {
			type = "group",
			name = L["Map Pin Selections"],
			inline = true,
			args = {
				iconChoice = {
					type = "range",
					name = L["Hatchling"],
					desc = "1 = " ..L["White"] .."\n2 = " ..L["Purple"] .."\n3 = " ..L["Red"] .."\n4 = " 
							..L["Yellow"] .."\n5 = " ..L["Green"] .."\n6 = " ..L["Grey"] .."\n7 = " ..L["Mana Orb"]
							.."\n8 = " ..L["Phasing"] .."\n9 = " ..L["Raptor egg"] .."\n10 = " ..L["Stars"],
					min = 1, max = 10, step = 1,
					arg = "iconChoice",
					order = 10,
				},
			},
		},
		notes = {
			type = "group",
			name = L["Notes"],
			inline = true,
			args = {
				noteMenu = { type = "description", name = "A shortcut to open this panel is via the Minimap AddOn"
					.." menu, which is immediately below the Calendar icon. Just click your mouse\n\n", order = 20, },
				separator1 = { type = "header", name = "", order = 21, },
				noteChat = { type = "description", name = "Chat command shortcuts are also supported.\n\n"
					..NORMAL_FONT_COLOR_CODE .."/arh" ..HIGHLIGHT_FONT_COLOR_CODE .." - Show this panel\n",
					order = 22, },
			},
		},
	},
}

function HandyNotes_AdorableRaptorHatchlings_OnAddonCompartmentClick( addonName, buttonName )
	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "AdorableRaptorHatchlings" )
 end

function HandyNotes_AdorableRaptorHatchlings_OnAddonCompartmentEnter( ... )
	GameTooltip:SetOwner( MinimapCluster or AddonCompartmentFrame, "ANCHOR_LEFT" )	
	GameTooltip:AddLine( AdorableRaptorHatchlings.colour.prefix ..L["Adorable Raptor Hatchlings"] )
	--GameTooltip:AddLine( AdorableRaptorHatchlings.colour.highlight .." " )
	GameTooltip:AddDoubleLine( AdorableRaptorHatchlings.colour.highlight ..L["Left"] .."/" ..L["Right"], AdorableRaptorHatchlings.colour.plaintext ..L["Options"] )
	GameTooltip:Show()
end

function HandyNotes_AdorableRaptorHatchlings_OnAddonCompartmentLeave( ... )
	GameTooltip:Hide()
end

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then return end
	
	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			if ( map.mapID == 11 ) or ( map.mapID == 279 ) then -- Retail Wailing Caverns excess Continent pins
			else
				local coords = AdorableRaptorHatchlings.points[map.mapID]
				if coords then
					for coord, criteria in next, coords do
						local mx, my = HandyNotes:getXY(coord)
						local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
						if cx and cy then
							AdorableRaptorHatchlings.points[continentMapID] = AdorableRaptorHatchlings.points[continentMapID] or {}
							AdorableRaptorHatchlings.points[continentMapID][HandyNotes:getCoord(cx, cy)] = criteria
						end
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB("AdorableRaptorHatchlings", pluginHandler, AdorableRaptorHatchlings.options)
	AdorableRaptorHatchlings.db = LibStub("AceDB-3.0"):New("HandyNotes_AdorableRaptorHatchlingsDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "AdorableRaptorHatchlings")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_AdorableRaptorHatchlingsDB", "AceEvent-3.0")

SLASH_AdorableRaptorHatchlings1 = "/arh"

local function Slash( options )

	Settings.OpenToCategory( "HandyNotes" )
	LibStub( "AceConfigDialog-3.0" ):SelectGroup( "HandyNotes", "plugins", "AdorableRaptorHatchlings" )
	if ( AdorableRaptorHatchlings.version >= 100000 ) then
		print( AdorableRaptorHatchlings.colour.prefix .."ARH: " ..AdorableRaptorHatchlings.colour.highlight .."Try the Minimap AddOn Menu (below the Calendar)" )
	end
end

SlashCmdList[ "AdorableRaptorHatchlings" ] = function( options ) Slash( options ) end

local points = AdorableRaptorHatchlings.points
local textures = AdorableRaptorHatchlings.textures
local scaling = AdorableRaptorHatchlings.scaling

points[AdorableRaptorHatchlings.dalaran] = { -- Dalaran
	[58853897] = { title="Breanni", petName="Obsidian Hatchling", speciesID=236, petTexture=132253 },
}

points[AdorableRaptorHatchlings.dustwallowMarsh] = { -- Dustwallow Marsh
	[46511716] = { title="Dart's Nest", petName="Darting Hatchling", speciesID=232, petTexture=132193 },
	[47981907] = { title="Dart's Nest", petName="Darting Hatchling", speciesID=232, petTexture=132193 },
	[48011426] = { title="Dart's Nest", petName="Darting Hatchling", speciesID=232, petTexture=132193 },
	[49171736] = { title="Dart's Nest", petName="Darting Hatchling", speciesID=232, petTexture=132193 },
}

points[AdorableRaptorHatchlings.barrens] = { -- Barrens (WotLK Classic or Northern Barrens (Retail) or Hybrid (Classic Cata Prelaunch)
	[58450828] = { title="Takk's Nest", petName="Leaping Hatchling", speciesID=235, petTexture=132253, version="W" }, 
	[59470851] = { title="Takk's Nest", petName="Leaping Hatchling", speciesID=235, petTexture=132253, version="W" },
	[60281011] = { title="Takk's Nest", petName="Leaping Hatchling", speciesID=235, petTexture=132253, version="W" },
	[60711330] = { title="Takk's Nest", petName="Leaping Hatchling", speciesID=235, petTexture=132253, version="W" },
	[60951976] = { title="Takk's Nest", petName="Leaping Hatchling", speciesID=235, petTexture=132253, version="R" },
	[62762018] = { title="Takk's Nest", petName="Leaping Hatchling", speciesID=235, petTexture=132253, version="R" },
	[64172300] = { title="Takk's Nest", petName="Leaping Hatchling", speciesID=235, petTexture=132253, version="R" },
	[64942860] = { title="Takk's Nest", petName="Leaping Hatchling", speciesID=235, petTexture=132253, version="R" },

	[38966932] = { title="Deviate Guardians & Ravagers", petName="Deviate Hatchling", speciesID=233, petTexture=132193, version="R",
					tip="Wailing Caverns dungeon.\n1 in 3500 chance" },
	[46003645] = { title="Deviate Guardians & Ravagers", petName="Deviate Hatchling", speciesID=233, petTexture=132193, version="W",
					tip="Wailing Caverns dungeon.\n1 in 3500 chance" },
}

AdorableRaptorHatchlings.sandCrawler = "In the sandy beach area.\n1 in 250 chance"

points[ AdorableRaptorHatchlings.classicCata and 1434 or 50 ] = { -- Northern Stranglethorn
	[47503220] = { title="Tsul'Kalu", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip="1 in 250 chance"  },
}

points[ 224 ] = { -- Stranglethorn Vale
	[40608546] = { title="Southern Sand Crawler", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip=AdorableRaptorHatchlings.sandCrawler  },
	[43498094] = { title="Southern Sand Crawler", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip=AdorableRaptorHatchlings.sandCrawler  },
	[45285215] = { title="Verifonix", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip="1 in 125 chance"  },
	[46567347] = { title="Southern Sand Crawler", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip=AdorableRaptorHatchlings.sandCrawler  },
	[46926618] = { title="Silverback Patriarch", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip="1 in 1000 chance"  },
	[48542134] = { title="Tsul'Kalu", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip="1 in 250 chance"  },
}

points[ 210 ] = { -- The Cape of Stranglethorn
	[45408290] = { title="Southern Sand Crawler", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip=AdorableRaptorHatchlings.sandCrawler },
	[50207540] = { title="Southern Sand Crawler", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip=AdorableRaptorHatchlings.sandCrawler  },
	[53172759] = { title="Verifonix", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip="1 in 125 chance"  },
	[55306300] = { title="Southern Sand Crawler", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip=AdorableRaptorHatchlings.sandCrawler  },
	[55905090] = { title="Silverback Patriarch", petName="Razzashi Hatchling", speciesID=239, petTexture=132193, tip="1 in 1000 chance"  },
}

points[AdorableRaptorHatchlings.unGoroCrater] = {	-- Un'Goro Crater
	[62067336] = { title="Ravasaur Matriarch's Nest", petName="Ravasaur Hatchling", speciesID=237, petTexture=132253, tip="Under the foliage" }, -- Classic matches
	[62096523] = { title="Ravasaur Matriarch's Nest", petName="Ravasaur Hatchling", speciesID=237, petTexture=132253 },
	[62976308] = { title="Ravasaur Matriarch's Nest", petName="Ravasaur Hatchling", speciesID=237, petTexture=132253, tip="Under the foliage" }, -- Classic matches
	[68836679] = { title="Ravasaur Matriarch's Nest", petName="Ravasaur Hatchling", speciesID=237, petTexture=132253, tip="Under the foliage" },
	[68956106] = { title="Ravasaur Matriarch's Nest", petName="Ravasaur Hatchling", speciesID=237, petTexture=132253, tip="Under the foliage" }, -- Classic matches
}

points[ 11 ] = { -- Wailing Caverns
	[53607050] = { title="Deviate Guardians & Ravagers", petName="Deviate Hatchling", speciesID=233, petTexture=132193, version="R",
					tip="Wailing Caverns dungeon.\n1 in 500 chance" },
}
points[ 279 ] = { -- Wailing Caverns
	[37704020] = { title="Deviate Guardians & Ravagers", petName="Deviate Hatchling", speciesID=233, petTexture=132193, version="R",
					tip="1 in 500 chance to drop from a\nDeviate Guardian or Ravager" },
}

-- A code hack will differentiate between the two. The first is for general use, the others are for inside the cave
points[AdorableRaptorHatchlings.wetlands] = {	-- Wetlands
	[69373491] = { title="Razormaw Matriarch's Nest", petName="Razormaw Hatchling", speciesID=238, petTexture=132193, version="E", tip="Cave entrance, Raptor Ridge" },
	[70032916] = { title="Razormaw Matriarch's Nest", petName="Razormaw Hatchling", speciesID=238, petTexture=132193, version="R", tip="Veer to the right" },
	[70082914] = { title="Razormaw Matriarch's Nest", petName="Razormaw Hatchling", speciesID=238, petTexture=132193, version="W", tip="Veer to the right" },
	[71103096] = { title="Razormaw Matriarch's Nest", petName="Razormaw Hatchling", speciesID=238, petTexture=132193, version="W", tip="Between two rocks" },
	[67633063] = { title="Razormaw Matriarch's Nest", petName="Razormaw Hatchling", speciesID=238, petTexture=132193, version="W" },
	[69073142] = { title="Razormaw Matriarch's Nest", petName="Razormaw Hatchling", speciesID=238, petTexture=132193, version="W" }, -- Best estimate
}

AdorableRaptorHatchlings.gundrak = "1 in 1000 chance to drop\nfrom a Gundrak Raptor"

points[ 121 ] = { -- Zul'drak
	[71502250] = { title="Gundrak Raptors", petName="Gundrak Hatchling", speciesID=234, petTexture=132253, tip=AdorableRaptorHatchlings.gundrak },
	[75003850] = { title="Gundrak Raptors", petName="Gundrak Hatchling", speciesID=234, petTexture=132253, tip=AdorableRaptorHatchlings.gundrak },
	[78501350] = { title="Gundrak Raptors", petName="Gundrak Hatchling", speciesID=234, petTexture=132253, tip=AdorableRaptorHatchlings.gundrak },
	[79004000] = { title="Gundrak Raptors", petName="Gundrak Hatchling", speciesID=234, petTexture=132253, tip=AdorableRaptorHatchlings.gundrak },
	[81503150] = { title="Gundrak Raptors", petName="Gundrak Hatchling", speciesID=234, petTexture=132253, tip=AdorableRaptorHatchlings.gundrak },
	[87002850] = { title="Gundrak Raptors", petName="Gundrak Hatchling", speciesID=234, petTexture=132253, tip=AdorableRaptorHatchlings.gundrak },
}

-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing. I've copied my scaling factors from my old AddOn
-- in order to homogenise the sizes. I should also allow for non-uniform origin placement as well as adjust the x,y offsets
textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
textures[3] = "Interface\\Common\\Indicator-Red"
textures[4] = "Interface\\Common\\Indicator-Yellow"
textures[5] = "Interface\\Common\\Indicator-Green"
textures[6] = "Interface\\Common\\Indicator-Gray"
textures[7] = "Interface\\Common\\Friendship-ManaOrb"	
textures[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
textures[9] = "Interface\\Store\\Category-icon-pets"
textures[10] = "Interface\\Store\\Category-icon-featured"

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.65
scaling[8] = 0.62
scaling[9] = 0.75
scaling[10] = 0.75