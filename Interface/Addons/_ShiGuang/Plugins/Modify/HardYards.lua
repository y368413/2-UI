-- Globals ----------
HardYards_min, HardYards_max = 0, 0

-- Localisation Optimisation - Lua ----------------------------------
local modf, random, gmatch, lower, match, sub, tonumber, tostring  = math.modf, random, string.gmatch, string.lower, string.match, string.sub, tonumber, tostring

-- Preset Ranges ----------------
local hy_rangeItems = {
	35278,	-- 80:	Reinforced Net
	41265,	-- 70:	Eyesore Blaster
	32825,	-- 60:	Soul Cannon, 34111/34121 Trained Rock Falcon
	116139,	-- 50:	Haunting Memento
	23836,	-- 45:	Wrangling Rope
	44114,  -- 40:	Old Spices, 44228 Baby Spice, 90888 Foot Ball, 90883 The Pigskin, 28767 The Decapitator, 109167 Findle's Loot-A-Rang
	24501,	-- 35:	Gordawg's Boulder
	32960,	-- 30:	Elekk Dispersion Ray, 21713 Elune's Candle, 85231 Bag of Clams, 9328 Super Snapper FX, 7734 Six Demon Bag
	4,	-- 28:	Follow
	86567,	-- 25:	Yaungol Wind Chime, 13289 Egan's Blaster
	10645,	-- 20:	Gnomish Death Ray
	46722,	-- 15:	Grol'dom Net, 56184 Duarn's Net, 31129 Blackwhelp Net, 1251 Linen Bandage
	40551,	-- 10:	Gore Bladder, 34913 Highmesa's Cleansing Seeds, 21267 Toasting Goblet, 32321 Sparrowhawk Net
	33278,	-- 8:	Burning Torch, 2 Trading
	3,	-- 7:	Dueling
	63427,	-- 6:	Worgsaw
	37727,	-- 5:	Ruby Acorn, 36771 Sturdy Crates
}

local hy_rangeMax = { "80", "70", "60", "50", "45", "40", "35", "30", "28", "25", "20", "15", "10", "8", "7", "6", "5"}
local hy_rangeMin = { "70.1", "60.1", "50.1", "45.1", "40.1", "35.1", "30.1", "28.1", "25.1", "20.1", "15.1", "10.1", "8.1", "7.1", "6.1", "5.1", "0"}

local hy_rangeAlt = {
	["32825"] = 37887, 	-- 60: Seeds of Nature's Wrath
	["32698"] = 23836,	-- 45: Goblin Rocket Launcher
	["44114"] = 34471,	-- 40: Vial of the Sunwell
	["24501"] = 18904,	-- 35: Zorbin's Ultra-Shrinker
	["32960"] = 34191,	-- 30: Handful of Snowflakes
	["86567"] = 31463,	-- 25: Zezzak's Shard (F NPC/P)
	["10645"] = 21519,	-- 20: Mistletoe (F NPC/P)
	["46722"] = 33069,	-- 15: Sturdy Rope
	["40551"] = 42441,	-- 10: Bouldercrag's Bomb
	["33278"] = 34368,	-- 8:  Attuned Crystal Cores
}

-- Colour Scheme ----------------
local hy_colour_X11Brown		= "\124cFFA52A2A"	-- Error messages
local hy_colour_X11Peru			= "\124cFFCD853F"	-- Debug messages
local hy_colour_numbers			= "\124cFFF4A460"	-- Highlight and warning messages
local hy_colour_arrows			= "\124cFFDEB887"	-- Plain text
local hy_colour_label			= "\124cFFD2691E"	-- HardYards chat line prefix
local hy_range = ""
--========================================================================================================================================--
local function HardYards_SetSize()
	HardYards.rangeText:SetTextHeight(ShiGuangPerDB.HardYardssize)
	HardYards.rangeText:ClearAllPoints()
	HardYards.rangeText:SetPoint("CENTER", ShiGuangPerDB.HardYardssize/30, -(ShiGuangPerDB.HardYardssize/10))
end

local function SetLocalsFromDB(databaseEntity)
	if (databaseEntity == "arrows") then
		hy_colour_arrows = "\124c".. format("FF%02x%02x%02x",  ShiGuangPerDB.HardYardsarrows.r * 255, ShiGuangPerDB.HardYardsarrows.g * 255, ShiGuangPerDB.HardYardsarrows.b * 255)
	elseif (databaseEntity == "numbers") then
		hy_colour_numbers = "\124c".. format("FF%02x%02x%02x", ShiGuangPerDB.HardYardsnumbers.r * 255, ShiGuangPerDB.HardYardsnumbers.g * 255, ShiGuangPerDB.HardYardsnumbers.b * 255)
	elseif (databaseEntity == "label") then
		hy_colour_label = "\124c".. format("FF%02x%02x%02x", ShiGuangPerDB.HardYardslabel.r * 255, ShiGuangPerDB.HardYardslabel.g * 255, ShiGuangPerDB.HardYardslabel.b * 255)
	end
end

local function ColourPicker(databaseEntity)
	ColorPickerFrame.originalColours = { ShiGuangPerDB[ databaseEntity ].r, ShiGuangPerDB[ databaseEntity ].g, ShiGuangPerDB[ databaseEntity ].b }
	ColorPickerFrame.func = function()
		local rNew, gNew, bNew = ColorPickerFrame:GetColorRGB()
		local mult = 10 ^ (3 or 0)
		ShiGuangPerDB[ databaseEntity ].r, ShiGuangPerDB[ databaseEntity ].g, ShiGuangPerDB[ databaseEntity ].b = rNew, gNew, bNew
		ShiGuangPerDB[ databaseEntity ].r = modf(ShiGuangPerDB[databaseEntity].r * mult + ((ShiGuangPerDB[databaseEntity].r < 0 and -1) or 1) * 0.5) / mult
		ShiGuangPerDB[ databaseEntity ].g = modf(ShiGuangPerDB[databaseEntity].g * mult + ((ShiGuangPerDB[databaseEntity].g < 0 and -1) or 1) * 0.5) / mult
		ShiGuangPerDB[ databaseEntity ].b = modf(ShiGuangPerDB[databaseEntity].b * mult + ((ShiGuangPerDB[databaseEntity].b < 0 and -1) or 1) * 0.5) / mult
		SetLocalsFromDB(databaseEntity)
	end
	if (ShiGuangPerDB[ databaseEntity ].r == 0) and (ShiGuangPerDB[ databaseEntity ].g == 0) and (ShiGuangPerDB[ databaseEntity ].b == 0) then
		ColorPickerFrame:SetColorRGB(0.004, 0.004, 0.004)
	else
		ColorPickerFrame:SetColorRGB(ShiGuangPerDB[ databaseEntity ].r, ShiGuangPerDB[ databaseEntity ].g, ShiGuangPerDB[ databaseEntity ].b)
	end
	ColorPickerFrame.cancelFunc = function()
		ShiGuangPerDB[ databaseEntity ].r, ShiGuangPerDB[ databaseEntity ].g, ShiGuangPerDB[ databaseEntity ].b = unpack(ColorPickerFrame.originalColours)
		SetLocalsFromDB(databaseEntity)
	end
	ColorPickerFrame:Show()
end

local function DoTheHardYards(unitID, actualTarget)
	local missed, furthest, result = 0, 0, false
	for i=1,#hy_rangeItems do
		result = false
		if hy_rangeItems[i] < 10 then
			result = CheckInteractDistance(unitID, hy_rangeItems[i]) or 0
		else
			result = IsItemInRange(hy_rangeItems[i], unitID)
		end
		if (result == nil) then
			local v = tostring(hy_rangeItems[i])
			if hy_rangeAlt[v] then
				if hy_rangeAlt[v] < 10 then
					result = CheckInteractDistance(unitID, hy_rangeAlt[v]) or 0
				else
					result = IsItemInRange(hy_rangeAlt[v], unitID)
				end
			end
		end
		if result == true then
			furthest = i
			missed = 0
		elseif result == nil then
			missed = i
		else
			break
		end
	end

	if furthest == #hy_rangeMax then
		hy_range = hy_colour_numbers.. ""
		if (actualTarget == true) then
			HardYards_min = 0
			HardYards_max = 5
		end
	elseif furthest > 0 then
		if missed > 0 then
			hy_range = hy_colour_numbers.. hy_rangeMin[ missed ].. hy_colour_arrows.. " - ".. hy_colour_numbers.. hy_rangeMax[ furthest ]
			if (actualTarget == true) then
				HardYards_min = tonumber(hy_rangeMin[ missed ])
				HardYards_max = tonumber(hy_rangeMax[ furthest ])
			end
		else
			hy_range = hy_colour_numbers.. hy_rangeMin[ furthest ].. hy_colour_arrows.. " - ".. hy_colour_numbers.. hy_rangeMax[ furthest ]
			if (actualTarget == true) then
				HardYards_min = tonumber(hy_rangeMin[ furthest ])
				HardYards_max = tonumber(hy_rangeMax[ furthest ])
			end
		end
	elseif missed > 0 then
		hy_range = hy_colour_numbers.. hy_rangeMin[ missed ].. hy_colour_arrows.. " - ".. hy_colour_numbers.. "80+"
		if (actualTarget == true) then
			HardYards_min = tonumber(hy_rangeMin[ missed ])
			HardYards_max = -1
		end
	else
		hy_range = hy_colour_numbers.. "80+"
		if (actualTarget == true) then
			HardYards_min = -1
			HardYards_max = -1
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------
local HardYards = CreateFrame("Frame", "HardYards", UIParent)
HardYards:RegisterEvent("PLAYER_LOGIN")
HardYards:SetScript("OnEvent", function(self, event)
	if (event == "PLAYER_LOGIN") then
	if (ShiGuangPerDB.HardYardsshow == nil)		then 	ShiGuangPerDB.HardYardsshow	=	true 	end
	if (ShiGuangPerDB.HardYardsarrows == nil)	then 	ShiGuangPerDB.HardYardsarrows	=	{} 	end	-- X11BurlyWood DEB887
	if (ShiGuangPerDB.HardYardsarrows.r == nil)	then 	ShiGuangPerDB.HardYardsarrows.r	=	0.87 	end
	if (ShiGuangPerDB.HardYardsarrows.g == nil)	then 	ShiGuangPerDB.HardYardsarrows.g	=	0.72 	end
	if (ShiGuangPerDB.HardYardsarrows.b == nil)	then 	ShiGuangPerDB.HardYardsarrows.b	=	0.53 	end
	if (ShiGuangPerDB.HardYardsnumbers == nil)	then 	ShiGuangPerDB.HardYardsnumbers	=	{} 	end	-- X11SandyBrown F4A460
	if (ShiGuangPerDB.HardYardsnumbers.r == nil)	then 	ShiGuangPerDB.HardYardsnumbers.r	=	0.96 	end
	if (ShiGuangPerDB.HardYardsnumbers.g == nil)	then 	ShiGuangPerDB.HardYardsnumbers.g	=	0.64 	end
	if (ShiGuangPerDB.HardYardsnumbers.b == nil)	then 	ShiGuangPerDB.HardYardsnumbers.b	=	0.38 	end
	if (ShiGuangPerDB.HardYardslabel == nil)		then 	ShiGuangPerDB.HardYardslabel	=	{} 	end	-- X11Chocolate D2691E
	if (ShiGuangPerDB.HardYardslabel.r == nil)	then 	ShiGuangPerDB.HardYardslabel.r	=	0.82 	end
	if (ShiGuangPerDB.HardYardslabel.g == nil)	then 	ShiGuangPerDB.HardYardslabel.g	=	0.41 	end
	if (ShiGuangPerDB.HardYardslabel.b == nil)	then 	ShiGuangPerDB.HardYardslabel.b	=	0.12 	end
	if (ShiGuangPerDB.HardYardssize == nil)		then 	ShiGuangPerDB.HardYardssize	=	26 	end

	SetLocalsFromDB("arrows")
	SetLocalsFromDB("numbers")
	SetLocalsFromDB("label")

	HardYards:SetFrameStrata("BACKGROUND")
	HardYards:SetClampedToScreen(true)
	HardYards:EnableMouse(false)
	HardYards:SetMovable(true)
	HardYards:ClearAllPoints()
	if ShiGuangPerDB.HardYardsx and ShiGuangPerDB.HardYardsy then
		HardYards:SetPoint("TOPLEFT", ShiGuangPerDB.HardYardsx, -(UIParent:GetHeight() - ShiGuangPerDB.HardYardsy))
	else
		HardYards:SetPoint("CENTER", 0, -(UIParent:GetHeight() / 3))
	end

	HardYards:SetScript("OnMouseDown", function(self, button)
		if (button == "LeftButton") and IsShiftKeyDown() then	self:StartMoving() end
	end)
	HardYards:SetScript("OnMouseUp", function(self)
		self:StopMovingOrSizing()
		ShiGuangPerDB.HardYardsx = HardYards:GetLeft()
		ShiGuangPerDB.HardYardsy = HardYards:GetTop()
	end)

	HardYards.rangeText = HardYards:CreateFontString(nil, "OVERLAY")
	HardYards.rangeText:SetFont("Interface\\AddOns\\_ShiGuang\\Media\\Fonts\\Pixel.ttf", 32, "THICKOUTLINE")  -- "Fonts\\FRIZQT__.TTF", 42, "THICKOUTLINE" 
	HardYards_SetSize()

	faction = UnitFactionGroup("player")
	end
end)
HardYards:SetScript("OnUpdate", function()
	if UnitExists("target") then
		DoTheHardYards("target", true)
		if (ShiGuangPerDB.HardYardsshow == true) then
			HardYards.rangeText:SetText(hy_range)
			HardYards.rangeText:SetTextColor(nil,nil,nil,1)
			HardYards:SetSize(HardYards.rangeText:GetWidth()*1.2, HardYards.rangeText:GetHeight()*1.3)
		end
	else
		if HardYards.rangeText then
		  HardYards.rangeText:SetTextColor(nil,nil,nil,0)
		else
		  return
		end
	end
end)

--------------------------------------------------------------------------------------------------------------------------------------------
SLASH_HardYards1 = "/hardyards"
--------------------------------------------------------------------------------------------------------------------------------------------
SlashCmdList[ "HardYards" ] = function(options)
	local firstParm, firstParm3, secondParm, secondParm3, thirdParm, thirdParm3, fourthParm, fourthParm3
	for v in gmatch(options, "%S+") do
		v = lower(v)
		if not firstParm3 then
			firstParm = v
			firstParm3 = sub(v,1,3)
		elseif not secondParm3 then
			secondParm = v
			secondParm3 = sub(v,1,3)
		elseif not thirdParm3 then
			thirdParm = v
			thirdParm3 = sub(v,1,3)
		else
			fourthParm = v
			fourthParm3 = sub(v,1,3)
			break
		end
	end
	if (firstParm3 == "?") or (firstParm3 == nil) then
		print("|cffCCCC88[菜单]|r距离显示 设置命令行:\n"..
		  hy_colour_X11SandyBrown.. "/hy arr\124r = 设置“ <-> ”的颜色\n"..
			hy_colour_X11SandyBrown.. "size n\124r = 设置大小(0-100). 栗子: '/hy siz 43'\n"..
			hy_colour_X11SandyBrown.."show / hide\124r  = 开关距离显示\n")
	elseif (firstParm3 == "arr") then
		if (secondParm3 == "def") then
			ShiGuangPerDB.HardYardsarrows.r, ShiGuangPerDB.HardYardsarrows.g, ShiGuangPerDB.HardYardsarrows.b = 0.87, 0.72, 0.53
			SetLocalsFromDB("arrows")
		else
			ColourPicker("arrows")
		end
	elseif (firstParm3 == "siz") then
		local size = tonumber(secondParm3) or 0
		if (size >= 5) and (size <= 100) then
			ShiGuangPerDB.HardYardssize = size
			HardYards_SetSize()
		else
			DEFAULT_CHAT_FRAME:AddMessage("\124".. HardYards_TITLE.. "\124cFFDEB887".. hy_colour_X11SandyBrown.. "<错误>: ".. hy_colour_X11BurlyWood.. "设置数值必须是0-100之间任意数值".. "\124r")
		end
	elseif (firstParm3 == "hid") then
		ShiGuangPerDB.HardYardsshow = false
		HardYards.rangeText:SetTextColor(nil,nil,nil,0)
	elseif (firstParm3 == "sho") then
		ShiGuangPerDB.HardYardsshow = true
	end
end
