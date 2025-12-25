		-------------------------------------------------
		-- Paragon Reputation 1.70 by Fail US-Ragnaros --
		-------------------------------------------------

		  --[[	  Special thanks to Ammako for
				  helping me with the vars and
				  the options.						]]--

local ParagonReputation = {}
local PR = ParagonReputation

--[questID] = data
PR.PARAGON_DATA = {
	
	--Legion
		[48976] = { -- Argussian Reach
			factionID = 2170,
			cache = 152922,
		}, 
		[46777] = { -- Armies of Legionfall
			factionID = 2045,
			cache = 152108,
			rewards = {
				{ -- Orphaned Felbat
					type = PET,
					itemID = 147841,
				},
			},
		},
		[48977] = { -- Army of the Light
			factionID = 2165,
			cache = 152923,
			rewards = {
				{ -- Avenging Felcrushed
					type = MOUNT,
					itemID = 153044,
					mountID = 985,
				},
				{ -- Blessed Felcrushed
					type = MOUNT,
					itemID = 153043,
					mountID = 984,
				},
				{ -- Glorious Felcrushed
					type = MOUNT,
					itemID = 153042,
					mountID = 983,
				},
				{ -- Holy Lightsphere
					type = TOY,
					itemID = 153182,
				},
			},
		},
		[46745] = { -- Court of Farondis
			factionID = 1900,
			cache = 152102,
			rewards = {
				{ -- Cloudwing Hippogryph
					type = MOUNT,
					itemID = 147806,
					mountID = 943,
				},
			},
		},
		[46747] = { -- Dreamweavers
			factionID = 1883,
			cache = 152103,
			rewards = {
				{ -- Wild Dreamrunner
					type = MOUNT,
					itemID = 147804,
					mountID = 942,
				},
			},
		},
		[46743] = { -- Highmountain Tribes
			factionID = 1828,
			cache = 152104,
			rewards = {
				{ -- Highmountain Elderhorn
					type = MOUNT,
					itemID = 147807,
					mountID = 941,
				},
			},
		},
		[46748] = { -- The Nightfallen
			factionID = 1859,
			cache = 152105,
			rewards = {
				{ -- Leywoven Flying Carpet
					type = MOUNT,
					itemID = 143764,
					mountID = 905,
				},
			},
		},
		[46749] = { -- The Wardens
			factionID = 1894,
			cache = 152107,
			rewards = {
				{ -- Sira's Extra Cloak
					type = TOY,
					itemID = 147843,
				},
			},
		},
		[46746] = { -- Valarjar
			factionID = 1948,
			cache = 152106,
			rewards = {
				{ -- Valarjar Stormwing
					type = MOUNT,
					itemID = 147805,
					mountID = 944,
				},
			},
		},
	
	--Battle for Azeroth
		--Neutral
		[54453] = { --Champions of Azeroth
			factionID = 2164,
			cache = 166298,
			rewards = {
				{ -- Azerite Firework Launcher
					type = TOY,
					itemID = 166877,
				},
			},
		},
		[58096] = { --Rajani
			factionID = 2415,
			cache = 174483,
			rewards = {
				{ -- Jade Defender
					type = PET,
					itemID = 174479,
				},
			},
		},
		[55348] = { --Rustbolt Resistance
			factionID = 2391,
			cache = 170061,
			rewards = {
				{ -- Blueprint: Microbot XD
					type = BINDING_HEADER_OTHER,
					itemID = 169171,
					questID = 55079,
				},
				{ -- Blueprint: Holographic Digitalization Relay
					type = BINDING_HEADER_OTHER,
					itemID = 168906,
					questID = 56086,
				},
				{ -- Blueprint: Rustbolt Resistance Insignia
					type = BINDING_HEADER_OTHER,
					itemID = 168494,
					questID = 55073,
				},
			},
		},
		[54451] = { --Tortollan Seekers
			factionID = 2163,
			cache = 166245,
			rewards = {
				{ -- Bowl of Glowing Pufferfish
					type = TOY,
					itemID = 166704,
				},
			},
		},
		[58097] = { --Uldum Accord
			factionID = 2417,
			cache = 174484,
			rewards = {
				{ -- Cursed Dune Watcher
					type = PET,
					itemID = 174481,
				},
			},
		},
		
		--Horde
		[54460] = { --Talanji's Expedition
			factionID = 2156,
			cache = 166282,
			rewards = {
				{ -- For da Blood God!
					type = TOY,
					itemID = 166308,
				},
				{ -- Pair of Tiny Bat Wings
					type = PET,
					itemID = 166716,
				},
			},
		},
		[54455] = { --The Honorbound
			factionID = 2157,
			cache = 166299,
			rewards = {
				{ -- Rallying War Banner
					type = TOY,
					itemID = 166879,
				},
			},
		},
		[53982] = { --The Unshackled
			factionID = 2373,
			cache = 169940,
			rewards = {
				{ -- Royal Snapdragon
					type = MOUNT,
					itemID = 169198,
					mountID = 1237,
				},
				{ -- Flopping Fish
					type = TOY,
					itemID = 170203,
				},
				{ -- Memento of the Deeps
					type = TOY,
					itemID = 170469,
				},
			},
		},
		[54461] = { --Voldunai
			factionID = 2158,
			cache = 166290,
			rewards = {
				{ -- Goldtusk Inn Breakfast Buffet
					type = TOY,
					itemID = 166703,
				},
				{ -- Meerah's Jukebox
					type = TOY,
					itemID = 166880,
				},
			},
		},
		[54462] = { --Zandalari Empire
			factionID = 2103,
			cache = 166292,
			rewards = {
				{ -- Warbeast Kraal Dinner Bell
					type = TOY,
					itemID = 166701,
				},
			},
		},
		
		--Alliance
		[54456] = { --Order of Embers
			factionID = 2161,
			cache = 166297,
			rewards = {
				{ -- Bewitching Tea Set
					type = TOY,
					itemID = 166808,
				},
				{ -- Cobalt Raven Hatchling
					type = PET,
					itemID = 166718,
				},
			},
		},
		[54458] = { --Proudmoore Admiralty
			factionID = 2160,
			cache = 166295,
			rewards = {
				{ -- Proudmoore Music Box
					type = TOY,
					itemID = 166702,
				},
				{ -- Albatross Feather
					type = PET,
					itemID = 166714,
				},
			},
		},
		[54457] = { --Storm's Wake
			factionID = 2162,
			cache = 166294,
			rewards = {
				{ -- Violet Abyssal Eel
					type = PET,
					itemID = 166719,
				},
			},
		},
		[54454] = { --The 7th Legion
			factionID = 2159,
			cache = 166300,
			rewards = {
				{ -- Rallying War Banner
					type = TOY,
					itemID = 166879,
				},
			},
		},
		[55976] = { --Waveblade Ankoan
			factionID = 2400,
			cache = 169939,
			rewards = {
				{ -- Royal Snapdragon
					type = MOUNT,
					itemID = 169198,
					mountID = 1237,
				},
				{ -- Flopping Fish
					type = TOY,
					itemID = 170203,
				},
				{ -- Memento of the Deeps
					type = TOY,
					itemID = 170469,
				},
			},
		},
	
	--Shadowlands
		[61100] = { --Court of Harvesters
			factionID = 2413,
			cache = 180648,
			rewards = {
				{ -- Stonewing Dredwing Pup
					type = PET,
					itemID = 180601,
				},
			},
		},
		[64012] = { --Death's Advance
			factionID = 2470,
			cache = 186650,
			rewards = {
				{ -- Beryl Shardhide
					type = MOUNT,
					itemID = 186644,
					mountID = 1455,
				},
				{ -- Fierce Razorwing
					type = MOUNT,
					itemID = 186649,
					mountID = 1508,
				},
				{ -- Mosscoated Hopper
					type = PET,
					itemID = 186541,
				},
			},
		},
		[64266] = { --The Archivist's Codex
			factionID = 2472,
			cache = 187028,
			rewards = {
				{ -- Tamed Mauler
					type = MOUNT,
					itemID = 186641,
					mountID = 1454,
				},
				{ -- Gnashtooth
					type = PET,
					itemID = 186538,
				},
			},
		},
		[61097] = { --The Ascended
			factionID = 2407,
			cache = 180647,
			rewards = {
				{ -- Malfunctioning Goliath Gauntlet
					type = TOY,
					itemID = 184396,
				},
				{ -- Mark of Purity
					type = TOY,
					itemID = 184435,
				},
				{ -- Larion Cub
					type = PET,
					itemID = 184399,
				},
			},
		},
		[64867] = { --The Enlightened
			factionID = 2478,
			cache = 187780,
			rewards = {
				{ -- Sphere of Enlightened Cogitation
					type = TOY,
					itemID = 190177,
				},
				{ -- Schematic: Russet Bufonoid
					type = BINDING_HEADER_OTHER,
					itemID = 189471,
					questID = 65394,
				},
				{ -- Enlightened Portal Research
					type = BINDING_HEADER_OTHER,
					itemID = 190234,
					questID = 65617,
				},
				{ -- Ray Soul
					type = BINDING_HEADER_OTHER,
					covenant = "|A:sanctumupgrades-nightfae-32x32:14:14:0:-1|a",
					itemID = 189973,
					questID = 65506,
				},
				{ -- Distinguished Blade of Cartel Al
					type = ITEM_COSMETIC,
					itemID = 190935,
				},
				{ -- Edge of the Enlightened
					type = ITEM_COSMETIC,
					itemID = 190937,
				},
				{ -- Standard of the Wandering Brokers
					type = ITEM_COSMETIC,
					itemID = 190934,
				},
				{ -- Walking Staff of the Enlightened Journey
					type = ITEM_COSMETIC,
					itemID = 190939,
				},
				{ -- Cape of the Regal Wanderer
					type = ITEM_COSMETIC,
					itemID = 190931,
				},
				{ -- Dark Shawl of the Enlightened
					type = ITEM_COSMETIC,
					itemID = 190930,
				},
				{ -- Ebony Protocloak
					type = ITEM_COSMETIC,
					itemID = 190929,
				},
				{ -- Majestic Oracle's Drape
					type = ITEM_COSMETIC,
					itemID = 190933,
				},
				{ -- Protohide Drape
					type = ITEM_COSMETIC,
					itemID = 190932,
				},
				{ -- Sandtails Drape
					type = ITEM_COSMETIC,
					itemID = 190928,
				},
			},
		},
		[61095] = { --The Undying Army
			factionID = 2410,
			cache = 180646,
			rewards = {
				{ -- Reins of the Colossal Slaughterclaw
					type = MOUNT,
					itemID = 182081,
					mountID = 1350,
				},
				{ -- Infested Arachnid Casing
					type = TOY,
					itemID = 184495,
				},
				{ -- Micromancer's Mystical Cowl
					type = PET,
					itemID = 181269,
				},
			},
		},
		[61098] = { --The Wild Hunt
			factionID = 2465,
			cache = 180649,
			rewards = {
				{ -- Amber Ardenmoth
					type = MOUNT,
					itemID = 183800,
					mountID = 1428,
				},
				{ -- Hungry Burrower
					type = PET,
					itemID = 180635,
				},
				{ -- Mammoth Soul
					type = BINDING_HEADER_OTHER,
					covenant = "|A:sanctumupgrades-nightfae-32x32:14:14:0:-1|a",
					itemID = 185054,
					questID = 63610,
				},
				{ -- Porcupine Soul
					type = BINDING_HEADER_OTHER,
					covenant = "|A:sanctumupgrades-nightfae-32x32:14:14:0:-1|a",
					itemID = 187870,
					questID = 64989,
				},
			},
		},
		[64267] = { --Ve'nari
			factionID = 2432,
			cache = 187029,
			rewards = {
				{ -- Soulbound Gloomcharger's Reins
					type = MOUNT,
					itemID = 186657,
					mountID = 1501,
				},
				{ -- Rook
					type = PET,
					itemID = 186552,
				},
			},
		},
	
	--Dragonflight
		[66156] = { -- Dragonscale Expedition
			factionID = 2507,
			cache = 199472,
		}, 
		[76425] = { -- Dream Wardens
			factionID = 2574,
			cache = 210992,
		},
		[66511] = { -- Iskaara Tuskarr
			factionID = 2511,
			cache = 199473,
		}, 
		[75290] = { -- Loamm Niffen
			factionID = 2564,
			cache = 204712,
		},
		[65606] = { -- Maruuk Centaur
			factionID = 2503,
			cache = 199474,
		}, 
		[71023] = { -- Valdrakken Accord
			factionID = 2510,
			cache = 199475,
		},
	
	--War Within
		[79219] = { -- Council of Dornogal
			factionID = 2590,
			cache = 225239,
		}, 
		[89515] = { -- Flame's Radiance
			factionID = 2688,
			cache = 239489,
		},
		[79218] = { -- Hallowfall Arathi
			factionID = 2570,
			cache = 225246,
		},
		[79220] = { -- The Assembly of the Deep
			factionID = 2594,
			cache = 225245,
		},
		[85109] = { -- The K'aresh Trust
			factionID = 2658,
			cache = 230032,
		},
		[85805] = { -- The Cartels of Undermine
			factionID = 2653,
			cache = 232463,
		},
			[85471] = { -- Gallagio Loyalty Rewards Club
				factionID = 2685,
				cache = 232463,
			},
			[85806] = { -- Bilgewater Cartel
				factionID = 2673,
				cache = 237132,
				rewards = {
					{ -- Bilgewater Bombardier
						type = MOUNT,
						itemID = 229957,
						mountID = 2295,
					},
				},
			},
			[85807] = { -- Blackwater Cartel
				factionID = 2675,
				cache = 237135,
				rewards = {
					{ -- Blackwater Bonecrusher
						type = MOUNT,
						itemID = 229937,
						mountID = 2274,
					},
				},
			},
			[85808] = { -- Darkfuse Solutions
				factionID = 2669,
				cache = 232465,
				rewards = {
					{ -- Bronze Goblin Waveshredder
						type = MOUNT,
						itemID = 233064,
						mountID = 2334,
					},
				},
			},
			[85809] = { -- Steamwheedle Cartel
				factionID = 2677,
				cache = 237134,
				rewards = {
					{ -- Steamwheedle Supplier
						type = MOUNT,
						itemID = 229943,
						mountID = 2281,
					},
				},
			},
			[85810] = { -- Venture Company
				factionID = 2671,
				cache = 237133,
				rewards = {
					{ -- Venture Co-ordinator
						type = MOUNT,
						itemID = 229951,
						mountID = 2289,
					},
				},
			},
		[79196] = { -- The Severed Threads
			factionID = 2600,
			cache = 225247,
		},
			[83739] = { -- The General
				factionID = 2605,
				cache = 226045,
			},
			[83740] = { -- The Vizier
				factionID = 2607,
				cache = 226100,
			},
			[83738] = { -- The Weaver
				factionID = 2601,
				cache = 226103,
			},
}

		-------------------------------------------------
		-- Paragon Reputation 1.70 by Fail US-Ragnaros --
		-------------------------------------------------

		  --[[	  Special thanks to Ammako for
				  helping me with the vars and
				  the options.						]]--


local LOCALE = GetLocale()
PR.L = {}

-- Chinese (Simplified) (Thanks dxlmike)
if LOCALE == "zhCN" then
	PR.L["PARAGON"] = "巅峰"
	PR.L["OPTIONDESC"] = "可以自定巅峰声望条的一些设定."
	PR.L["TOASTDESC"] = "切换获得巅峰奖励时是否弹出通知."
	PR.L["LABEL001"] = "声望条颜色"
	PR.L["LABEL002"] = "文字格式"
	PR.L["LABEL003"] = "弹出奖励通知"
	PR.L["BLUE"] = "巅峰蓝"
	PR.L["GREEN"] = "预设绿"
	PR.L["YELLOW"] = "中立黄"
	PR.L["ORANGE"] = "敌对橙"
	PR.L["RED"] = "淡红"
	PR.L["DEFICIT"] = "还需要多少声望"
	PR.L["SOUND"] = "音效通知"
	PR.L["ANCHOR"] = "锚点"

-- Chinese (Traditional) (Thanks gaspy10 & BNSSNB)
elseif LOCALE == "zhTW" then
	PR.L["PARAGON"] = "巅峰"
	PR.L["OPTIONDESC"] = "這些選項可讓你自訂巔峰聲望條的一些設定。"
	PR.L["TOASTDESC"] = "切換獲得巔峰聲望獎勵時的彈出式通知。"
	PR.L["LABEL001"] = "聲望條顏色"
	PR.L["LABEL002"] = "文字格式"
	PR.L["LABEL003"] = "彈出獎勵通知"
	PR.L["BLUE"] = "巔峰藍"
	PR.L["GREEN"] = "預設綠"
	PR.L["YELLOW"] = "中立黃"
	PR.L["ORANGE"] = "不友好橘"
	PR.L["RED"] = "淡紅色"
	PR.L["DEFICIT"] = "還需要多少聲望"
	PR.L["SOUND"] = "音效通知"
	PR.L["ANCHOR"] = "切換錨點"

-- English (DEFAULT)
else
	PR.L["PARAGON"] = "Paragon"
	PR.L["OPTIONDESC"] = "This options allow you to customize some settings of Paragon Reputation."
	PR.L["TOASTDESC"] = "Toggle a toast window that will warn you when you have a Paragon Reward."
	PR.L["LABEL001"] = "Bars Color"
	PR.L["LABEL002"] = "Text Format"
	PR.L["LABEL003"] = "Reward Toast"
	PR.L["BLUE"] = "Paragon Blue"
	PR.L["GREEN"] = "Default Green"
	PR.L["YELLOW"] = "Neutral Yellow"
	PR.L["ORANGE"] = "Unfriendly Orange"
	PR.L["RED"] = "Lightish Red"
	PR.L["DEFICIT"] = "Reputation Deficit"
	PR.L["SOUND"] = "Sound Warning"
	PR.L["ANCHOR"] = "Toggle Anchor"
	
end

		-------------------------------------------------
		-- Paragon Reputation 1.70 by Fail US-Ragnaros --
		-------------------------------------------------

		  --[[	  Special thanks to Ammako for
				  helping me with the vars and
				  the options.						]]--
local COLOR_CHECK_LIST = {"BLUE","GREEN","YELLOW","ORANGE","RED"}
local COLOR_CHECK_VALUE = {{0,.5,.9,1},{0,.6,.1,1},{.9,.7,0,1},{.75,.27,0,1},{1,.25,.62,1}}
local TEXT_CHECK_LIST = {"PARAGON","EXALTED","CURRENT","VALUE","DEFICIT"}

-- [Toast] Create Base Frame
local toast = CreateFrame("FRAME","ParagonReputation_Toast",UIParent)
toast:SetPoint("TOP",UIParent,"TOP",0,-160)
toast:SetWidth(302)
toast:SetHeight(70)
toast:SetMovable(true)
toast:SetUserPlaced(false)
toast:SetClampedToScreen(true)
toast:RegisterForDrag("LeftButton")
toast:SetScript("OnDragStart",toast.StartMoving)
toast:SetScript("OnDragStop",toast.StopMovingOrSizing)
toast:Hide()

-- [Toast] Create Background Texture
toast.texture = toast:CreateTexture(nil,"BACKGROUND")
toast.texture:SetPoint("TOPLEFT",toast,"TOPLEFT",-6,4)
toast.texture:SetPoint("BOTTOMRIGHT",toast,"BOTTOMRIGHT",4,-4)
toast.texture:SetTexture("Interface\\Garrison\\GarrisonToast")
toast.texture:SetTexCoord(0,.61,.33,.48)

-- [Toast] Create Title Text
toast.title = toast:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
toast.title:SetPoint("TOPLEFT",toast,"TOPLEFT",23,-10)
toast.title:SetWidth(260)
toast.title:SetHeight(16)
toast.title:SetJustifyV("TOP")
toast.title:SetJustifyH("LEFT")

-- [Toast] Create Description Text
toast.description = toast:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
toast.description:SetPoint("TOPLEFT",toast.title,"TOPLEFT",1,-23)
toast.description:SetWidth(258)
toast.description:SetHeight(32)
toast.description:SetJustifyV("TOP")
toast.description:SetJustifyH("LEFT")

-- [Toast] Create Reset Button
toast.reset = CreateFrame("Button",nil,toast,"UIPanelButtonTemplate")
toast.reset:SetPoint("BOTTOMLEFT",toast,"BOTTOMLEFT",5,6)
toast.reset:SetWidth(146)
toast.reset:SetScript("OnClick",function()
	PR:ResetButton()
end)

-- [Toast] Create Lock Button
toast.lock = CreateFrame("Button",nil,toast,"UIPanelButtonTemplate")
toast.lock:SetPoint("BOTTOMRIGHT",toast,"BOTTOMRIGHT", -5, 6)
toast.lock:SetWidth(146)
toast.lock:SetScript("OnClick",function()
	PlaySound(687,"Master")
	PR:LockButton()
end)

PR.toast = toast

-- [ADDON_LOADED] Set the AddOn on load.
local DB = {
	value = {0,.5,.9,1},
	color = "BLUE",
	text = "PARAGON",
	toast = false,
	sound = true,
	fade = 5,
	point = {"TOP","TOP",0,-160},
}
local vars = CreateFrame("FRAME")
vars:RegisterEvent("ADDON_LOADED")
vars:SetScript("OnEvent",function(self,event,name)
	if event == "ADDON_LOADED" and name == "OrzUI" then
		self:UnregisterEvent("ADDON_LOADED")
		if ParagonReputationDB == nil then
			ParagonReputationDB = DB
		else
			for key,value in pairs(DB) do
				if ParagonReputationDB[key] == nil then
					ParagonReputationDB[key] = value
				end
			end
		end
		PR.DB = ParagonReputationDB
		PR:SetToastPosition()
		PR:CreateOptions()
	end
end)

-- [Toast] Set Toast Position
function ParagonReputation:SetToastPosition()
	local point,relative,x,y = unpack(PR.DB.point)
	PR.toast:ClearAllPoints()
	PR.toast:SetPoint(point,UIParent,relative,x,y)
end

if GetLocale() == "zhCN" then
  ParagonReputationLocal = "|cffe6cc80[声望]|r样式定义";
elseif GetLocale() == "zhTW" then
  ParagonReputationLocal = "|cffe6cc80[声望]|r样式定义";
else
  ParagonReputationLocal = "ParagonReputation";
end

-- [AddOn Options] Create AddOn Options
function ParagonReputation:CreateOptions()

	-- [Interface Options] Create Options
	PR.options = CreateFrame("FRAME",nil)
	PR.options.name = ParagonReputationLocal
	
	local category = Settings.RegisterCanvasLayoutCategory(PR.options,PR.options.name)
	category.ID = PR.options.name
	Settings.RegisterAddOnCategory(category)
	--InterfaceOptions_AddCategory(PR.options)

	-- [Interface Options] Title
	PR.options.title = PR.options:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
	PR.options.title:SetPoint("TOPLEFT",16,-16)
	PR.options.title:SetText("|cff0088eeParagon|r Reputation |cff0088eev".."1.70".."|r")

	-- [Interface Options] Title Description
	PR.options.description1 = PR.options:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	PR.options.description1:SetPoint("TOPLEFT",PR.options.title,"BOTTOMLEFT",0,-2)
	PR.options.description1:SetText(PR.L["OPTIONDESC"])
	PR.options.description1:SetJustifyH("LEFT")
	PR.options.description1:SetWidth(592)

	-- [Interface Options] Color Label
	PR.options.label1 = PR.options:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
	PR.options.label1:SetPoint("TOPLEFT",PR.options.description1,"BOTTOMLEFT",0,-4)
	PR.options.label1:SetText(PR.L["LABEL001"])
	
	-- [Interface Options] Color Check
	local COLOR_CHECK_NAME = {PR.L["BLUE"],PR.L["GREEN"],PR.L["YELLOW"],PR.L["ORANGE"],PR.L["RED"]}
	for n=1,#COLOR_CHECK_LIST do
		PR.options["color"..n] = PR:CreateCheckButton(COLOR_CHECK_LIST[n],COLOR_CHECK_NAME[n],PR.DB.color,"COLOR")
		if n == 1 then
			PR.options["color"..n]:SetPoint("TOPLEFT",PR.options.label1,"BOTTOMLEFT",-4,2)
		else
			PR.options["color"..n]:SetPoint("TOPLEFT",PR.options["color"..n-1],"BOTTOMLEFT",0,10)
		end
		_G[PR.options["color"..n]:GetName().."Text"]:SetTextColor(unpack(COLOR_CHECK_VALUE[n]))
	end

	-- [Interface Options] Text Label
	PR.options.label2 = PR.options:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
	PR.options.label2:SetPoint("TOPLEFT",PR.options.label1,"TOPLEFT",210,0)
	PR.options.label2:SetText(PR.L["LABEL002"])
	
	-- [Interface Options] Text Check
	local TEXT_CHECK_NAME = {PR.L["PARAGON"].." |cffa0a0a0(0/10,000)|r",FACTION_STANDING_LABEL8.." |cffa0a0a0(0/10,000)|r","0 |cffa0a0a0(0/10,000)|r","0/10,000",PR.L["DEFICIT"]}
	for n=1,#TEXT_CHECK_LIST do
		PR.options["text"..n] = PR:CreateCheckButton(TEXT_CHECK_LIST[n],TEXT_CHECK_NAME[n],PR.DB.text,"TEXT")
		if n == 1 then
			PR.options["text"..n]:SetPoint("TOPLEFT",PR.options.label2,"BOTTOMLEFT",-4,2)
		else
			PR.options["text"..n]:SetPoint("TOPLEFT",PR.options["text"..n-1],"BOTTOMLEFT",0,10)
		end
	end
	
	-- [Interface Options] Toast Label
	PR.options.label3 = PR.options:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
	PR.options.label3:SetPoint("TOPLEFT",PR.options.label1,"BOTTOMLEFT",24,-112)
	PR.options.label3:SetText(PR.L["LABEL003"])
	
	-- [Interface Options] Toast Check
	PR.options.toast = CreateFrame("CheckButton",nil,PR.options,"ChatConfigCheckButtonTemplate")
	PR.options.toast:SetPoint("RIGHT",PR.options.label3,"LEFT",2,0)
	PR.options.toast:SetWidth(30)
	PR.options.toast:SetHeight(30)
	PR.options.toast:SetChecked(PR.DB.toast)
	PR.options.toast:SetScript("OnClick",function()
		PlaySound(687,"Master")
		PR.DB.toast = PR.options.toast:GetChecked()
	end)
	
	-- [Interface Options] Toast Description
	PR.options.description2 = PR.options:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	PR.options.description2:SetPoint("TOPLEFT",PR.options.label3, "BOTTOMLEFT",-24,-2)
	PR.options.description2:SetText(PR.L["TOASTDESC"])
	PR.options.description2:SetJustifyH("LEFT")
	PR.options.description2:SetWidth(592)
	
	-- [Interface Options] Toast Fade Duration
	PR.options.fade1 = PR.options:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	PR.options.fade1:SetPoint("TOPLEFT",PR.options.description2,"BOTTOMLEFT",63,-32.5)
	PR.options.fade1:SetText(PR.DB.fade.."s")
	PR.options.fade1:SetJustifyH("CENTER")
	PR.options.fade1:SetWidth(32)

	-- [Interface Options] Toast Fade Slider
	PR.options.fade2 = CreateFrame("Slider","ParagonReputation_FadeSlider",PR.options,"OptionsSliderTemplate")
	PR.options.fade2:ClearAllPoints()
	PR.options.fade2:SetPoint("TOPLEFT",PR.options.description2,"BOTTOMLEFT",4,-18)
	PR.options.fade2:SetMinMaxValues(3,10)
	PR.options.fade2:SetValue(PR.DB.fade)
	PR.options.fade2:SetValueStep(1)
	PR.options.fade2:SetObeyStepOnDrag(true)
	PR.options.fade2:SetOrientation("HORIZONTAL")
	_G[PR.options.fade2:GetName().."Low"]:SetText("3s")
	_G[PR.options.fade2:GetName().."High"]:SetText("10s")
	_G[PR.options.fade2:GetName().."Text"]:SetText(AUCTION_DURATION)
	PR.options.fade2.last = -1
	PR.options.fade2:SetScript("OnValueChanged",function(self,value)
		if value == self.last then return end
		self.last = value
		PlaySound(687,"Master")
		PR.DB.fade = value
		PR.options.fade1:SetText(PR.options.fade2:GetValue().."s")
	end)
	
	-- [Interface Options] Sound Check
	PR.options.sound = CreateFrame("CheckButton","ParagonReputation_CheckSound",PR.options,"ChatConfigCheckButtonTemplate")
	PR.options.sound:SetPoint("TOPLEFT",PR.options.description2,"BOTTOMLEFT",-3,-53)
	PR.options.sound:SetWidth(30)
	PR.options.sound:SetHeight(30)
	_G[PR.options.sound:GetName().."Text"]:SetText(PR.L["SOUND"])
	PR.options.sound:SetChecked(PR.DB.sound)
	PR.options.sound:SetScript("OnClick",function()
		PlaySound(687,"Master")
		PR.DB.sound = PR.options.sound:GetChecked()
	end)

	-- [Interface Options] Toggle Button
	PR.options.toggle = CreateFrame("Button",nil,PR.options,"UIPanelButtonTemplate")
	PR.options.toggle:SetPoint("TOPLEFT",PR.options.description2,"BOTTOMLEFT",208,-10)
	PR.options.toggle:SetText(PR.L["ANCHOR"])
	PR.options.toggle:SetWidth(192)
	PR.options.toggle:SetScript("OnClick",function()
		if PR.toast:IsVisible() then
			PR:LockButton()
		else
			HideUIPanel(SettingsPanel)
			PR.toast:Show()
			PR.toast:SetAlpha(1)
			PR.toast:EnableMouse(true)
			PR.toast.title:SetAlpha(1)
			PR.toast.title:SetText(MOVE_FRAME)
			PR.toast.description:SetAlpha(1)
			PR.toast.description:SetText("")
			PR.toast.lock:Show()
			PR.toast.lock:SetText(LOCK)
			PR.toast.reset:Show()
			PR.toast.reset:SetText(RESET_POSITION)
		end
	end)

	-- [Interface Options] Reset Button
	PR.options.reset = CreateFrame("Button",nil,PR.options,"UIPanelButtonTemplate")
	PR.options.reset:SetPoint("TOPLEFT", PR.options.description2,"BOTTOMLEFT", 208, -32)
	PR.options.reset:SetText(RESET_POSITION)
	PR.options.reset:SetWidth(192)
	PR.options.reset:SetScript("OnClick",function()
		PR:ResetButton()
	end)
end

function ParagonReputation:CreateCheckButton(name,text,db,class)
	local frame = CreateFrame("CheckButton","ParagonReputation_Check"..string.gsub(string.lower(name),"^%l",string.upper),PR.options,"ChatConfigCheckButtonTemplate")
	frame:SetSize(30,30)
	frame.class = class
	_G[frame:GetName().."Text"]:SetText(text)
	frame:SetChecked(name == db)
	frame:SetScript("OnClick",function(self)
		PR:SetCheck(self)
	end)
	return frame
end

function ParagonReputation:SetCheck(self)
	PlaySound(687,"Master")
	if self.class == "COLOR" then
		for n=1,#COLOR_CHECK_LIST do
			if self == PR.options["color"..n] then
				PR.DB.color = COLOR_CHECK_LIST[n]
				PR.DB.value = COLOR_CHECK_VALUE[n]
				self:SetChecked(true)
			else
				PR.options["color"..n]:SetChecked(false)
			end
		end
	elseif self.class == "TEXT" then
		for n=1,#TEXT_CHECK_LIST do
			if self == PR.options["text"..n] then
				PR.DB.text = TEXT_CHECK_LIST[n]
				self:SetChecked(true)
			else
				PR.options["text"..n]:SetChecked(false)
			end
		end
	end
end

function ParagonReputation:ResetButton()
	PlaySound(687,"Master")
	PR.DB.point = {"TOP","TOP",0,-160}
	PR:SetToastPosition()
end

function ParagonReputation:LockButton()
	local point,_,relative,x,y = PR.toast:GetPoint()
	PR.DB.point = {point,relative,x,y}
	Settings.OpenToCategory(PR.options.name)
	PR.toast:Hide()
	PR.toast.reset:Hide()
	PR.toast.lock:Hide()
	PR.toast.title:SetText("")
	PR.toast.description:SetText("")
	PR.toast:EnableMouse(false)
end
		-------------------------------------------------
		-- Paragon Reputation 1.70 by Fail US-Ragnaros --
		-------------------------------------------------

		  --[[	  Special thanks to Ammako for
				  helping me with the vars and
				  the options.						]]--

-- [Pet Rewards] Check if a Pet Reward is already owned.
local ParagonPetSearchTooltip = CreateFrame("GameTooltip","ParagonPetSearchTooltip",nil,"GameTooltipTemplate")
local function ParagonIsPetOwned(link)
	ParagonPetSearchTooltip:SetOwner(UIParent,"ANCHOR_NONE")
	ParagonPetSearchTooltip:SetHyperlink(link)
	for index=3,5 do
		local text = _G["ParagonPetSearchTooltipTextLeft"..index] and _G["ParagonPetSearchTooltipTextLeft"..index]:GetText()
		if text and string.find(text,"(%d)/(%d)") then
			return true
		end
	end
	return false
end

-- [GameTooltip] Add Paragon Rewards to the Tooltip.
local ParagonItemInfoReceivedQueue = {}
local function AddParagonRewardsToTooltip(self,tooltip,rewards)
	if rewards then
		for index,data in ipairs(rewards) do
			local name,link,quality,_,_,_,_,_,_,icon = C_Item.GetItemInfo(data.itemID)
			if name then
				local collected
				if data.type == MOUNT then
					collected = select(11,C_MountJournal.GetMountInfoByID(data.mountID))
				elseif data.type == PET and link then
					collected = ParagonIsPetOwned(link)
				elseif data.type == TOY then
					collected = PlayerHasToy(data.itemID)
				elseif data.type == ITEM_COSMETIC then
					collected = C_TransmogCollection.PlayerHasTransmogByItemInfo(data.itemID)
				elseif data.type == BINDING_HEADER_OTHER then
					collected = C_QuestLog.IsQuestFlaggedCompleted(data.questID)
				end
				tooltip:AddLine(string.format("|A:common-icon-%s:14:14|a |T%d:0|t %s %s",collected and "checkmark" or "redx",icon,name,data.covenant or "|cffffd000(|r|cffffffff"..data.type.."|r|cffffd000)|r"),ITEM_QUALITY_COLORS[quality].r,ITEM_QUALITY_COLORS[quality].g,ITEM_QUALITY_COLORS[quality].b)
			else
				tooltip:AddLine(ERR_TRAVEL_PASS_NO_INFO,1,0,0)
				ParagonItemInfoReceivedQueue[data.itemID] = self
			end
		end
	else
		tooltip:AddLine(VIDEO_OPTIONS_NONE,1,0,0)
	end
end

-- [GameTooltip] Show the GameTooltip with the Item Reward on mouseover. (Thanks Brudarek)
function ParagonReputation:Tooltip(self)
	if not self.questID or not PR.PARAGON_DATA[self.questID] or self.tooLowLevelForParagon then return end
	EmbeddedItemTooltip:ClearLines()
	EmbeddedItemTooltip:SetOwner(self,"ANCHOR_RIGHT")
	ReputationParagonFrame_SetupParagonTooltip(self)
	GameTooltip_SetBottomText(EmbeddedItemTooltip,REPUTATION_BUTTON_TOOLTIP_CLICK_INSTRUCTION,GREEN_FONT_COLOR)
	AddParagonRewardsToTooltip(self,EmbeddedItemTooltip,PR.PARAGON_DATA[self.questID].rewards)
	EmbeddedItemTooltip:AddLine(" ")
	EmbeddedItemTooltip:AddLine(string.format(ARCHAEOLOGY_COMPLETION,self.count))
	EmbeddedItemTooltip:AddLine(" ")
	EmbeddedItemTooltip:SetClampedToScreen(true)
	EmbeddedItemTooltip:Show()
end

local ACTIVE_TOAST = false
local WAITING_TOAST = {}

-- [Paragon Toast] Show the Paragon Toast if a Paragon Reward Quest is accepted.
function ParagonReputation:ShowToast(name,questID)
	ACTIVE_TOAST = true
	if PR.DB.sound then PlaySound(44295,"master",true) end
	PR.toast:EnableMouse(false)
	PR.toast.title:SetText(name)
	PR.toast.title:SetAlpha(0)
	PR.toast.description:SetAlpha(0)
	PR.toast.reset:Hide()
	PR.toast.lock:Hide()
	UIFrameFadeIn(PR.toast,.5,0,1)
	C_Timer.After(.5,function()
		UIFrameFadeIn(PR.toast.title,.5,0,1)
	end)
	C_Timer.After(.75,function()
		PR.toast.description:SetText(GetQuestLogCompletionText(C_QuestLog.GetLogIndexForQuestID(questID)))
		UIFrameFadeIn(PR.toast.description,.5,0,1)
	end)
	C_Timer.After(PR.DB.fade,function()
		UIFrameFadeOut(PR.toast,1,1,0)
	end)
	C_Timer.After(PR.DB.fade+1.25,function()
		PR.toast:Hide()
		ACTIVE_TOAST = false
		if #WAITING_TOAST > 0 then
			PR:WaitToast()
		end
	end)
end

-- [Paragon Toast] Get next Paragon Reward Quest if more than two are accepted at the same time.
function ParagonReputation:WaitToast()
	local name,questID = unpack(WAITING_TOAST[1])
	table.remove(WAITING_TOAST,1)
	PR:ShowToast(name,questID)
end

-- [Paragon Toast] Handle QUEST_ACCEPTED and GET_ITEM_INFO_RECEIVED events.
local events = CreateFrame("FRAME")
events:RegisterEvent("QUEST_ACCEPTED")
events:RegisterEvent("GET_ITEM_INFO_RECEIVED")
events:SetScript("OnEvent",function(self,event,arg1,arg2)
	if event == "QUEST_ACCEPTED" and PR.DB.toast and PR.PARAGON_DATA[arg1] then
		local data = C_Reputation.GetFactionDataByID(PR.PARAGON_DATA[arg1].factionID)
		if ACTIVE_TOAST then
			WAITING_TOAST[#WAITING_TOAST+1] = {data.name,arg1} --Toast is already active, put this info on the line.
		else
			PR:ShowToast(data.name,arg1)
		end
	elseif event == "GET_ITEM_INFO_RECEIVED" and arg2 and ParagonItemInfoReceivedQueue[arg1] then
		if ParagonItemInfoReceivedQueue[arg1]:IsMouseOver() and EmbeddedItemTooltip:GetOwner() == ParagonItemInfoReceivedQueue[arg1] then
			PR:Tooltip(ParagonItemInfoReceivedQueue[arg1])
		end
		ParagonItemInfoReceivedQueue[arg1] = nil
	end
end)

-- [Paragon Overlay] Create the Overlay for the Reputation Bar.
function ParagonReputation:CreateBarOverlay(bar)
	local overlay = CreateFrame("FRAME",nil,bar)
	overlay:SetAllPoints(bar)
	overlay:SetFrameLevel(bar:GetFrameLevel())
	overlay.bar = overlay:CreateTexture(nil,"ARTWORK",nil)
	local texture = bar:GetStatusBarTexture():GetTexture()
	bar.LeftTexture:SetDrawLayer("ARTWORK",1)
	bar.RightTexture:SetDrawLayer("ARTWORK",1)
	overlay.bar:SetTexture(texture == 136570 and "Interface\\TARGETINGFRAME\\UI-StatusBar" or texture)
	overlay.bar:SetPoint("TOP",overlay)
	overlay.bar:SetPoint("BOTTOM",overlay)
	overlay.bar:SetPoint("LEFT",overlay)
	overlay.edge = overlay:CreateTexture(nil,"ARTWORK",nil)
	overlay.edge:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	overlay.edge:SetPoint("CENTER",overlay.bar,"RIGHT")
	overlay.edge:SetBlendMode("ADD")
	overlay.edge:SetSize(38,38) --Arbitrary value, I hope there isn't an AddOn that skins the bar and the glow doesnt look right with this size.
	bar.ParagonOverlay = overlay
end

-- [Reputation Frame] Change the Reputation Bars accordingly.
local function UpdateBar(self)
	if not self.Content or not self.Content.ReputationBar then return end
	if self.factionID and C_Reputation.IsFactionParagon(self.factionID) then
		if not self.paragon_hook and self.ShowParagonRewardsTooltip then
			hooksecurefunc(self,"ShowParagonRewardsTooltip",function(_self)
				PR:Tooltip(_self)
			end)
			self.paragon_hook = true
		end
		local currentValue,threshold,rewardQuestID,hasRewardPending,tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(self.factionID)
		self.count = floor(currentValue/threshold)-(hasRewardPending and 1 or 0)
		self.questID = rewardQuestID
		self.tooLowLevelForParagon = tooLowLevelForParagon
		local r,g,b = PR.DB.value[1],PR.DB.value[2],PR.DB.value[3]
		local value = currentValue%threshold
		if hasRewardPending then
			self.Content.ParagonIcon.factionID = self.factionID
			self.Content.ParagonIcon:SetPoint("CENTER",self,"RIGHT",4,0)
			self.Content.ParagonIcon.Glow:SetShown(true)
			self.Content.ParagonIcon.Check:SetShown(true)
			self.Content.ParagonIcon:Show()
			-- If value is 0 we force it to 1 so we don't get 0 as result, math...
			local over = math.max(value,1)/threshold
			if not self.Content.ReputationBar.ParagonOverlay then PR:CreateBarOverlay(self.Content.ReputationBar) end
			self.Content.ReputationBar.ParagonOverlay:Show()
			self.Content.ReputationBar.ParagonOverlay.bar:SetWidth(self.Content.ReputationBar.ParagonOverlay:GetWidth()*over)
			self.Content.ReputationBar.ParagonOverlay.bar:SetVertexColor(r+.15,g+.15,b+.15)
			self.Content.ReputationBar.ParagonOverlay.edge:SetVertexColor(r+.25,g+.25,b+.25,(over > .05 and .75) or 0)
			value = value+threshold
		else
			self.Content.ParagonIcon:Hide()
			if self.Content.ReputationBar.ParagonOverlay then self.Content.ReputationBar.ParagonOverlay:Hide() end
		end
		self.Content.ReputationBar:SetMinMaxValues(0,threshold)
		self.Content.ReputationBar:SetValue(value)
		self.Content.ReputationBar:SetStatusBarColor(r,g,b)
		self.Content.ReputationBar.barProgressText = HIGHLIGHT_FONT_COLOR_CODE.." "..format(REPUTATION_PROGRESS_FORMAT,BreakUpLargeNumbers(value),BreakUpLargeNumbers(threshold))..FONT_COLOR_CODE_CLOSE
		if PR.DB.text == "PARAGON" then
			self.Content.ReputationBar.BarText:SetText(PR.L["PARAGON"])
			self.Content.ReputationBar.reputationStandingText = PR.L["PARAGON"]
		elseif PR.DB.text == "CURRENT"  then
			self.Content.ReputationBar.BarText:SetText(BreakUpLargeNumbers(value))
			self.Content.ReputationBar.reputationStandingText = BreakUpLargeNumbers(value)
		elseif PR.DB.text == "VALUE" then
			self.Content.ReputationBar.BarText:SetText(" "..BreakUpLargeNumbers(value).." / "..BreakUpLargeNumbers(threshold))
			self.Content.ReputationBar.reputationStandingText = (" "..BreakUpLargeNumbers(value).." / "..BreakUpLargeNumbers(threshold))
			self.Content.ReputationBar.barProgressText = nil
		elseif PR.DB.text == "DEFICIT" then
			if hasRewardPending then
				value = value-threshold
				self.Content.ReputationBar.BarText:SetText("+"..BreakUpLargeNumbers(value))
				self.Content.ReputationBar.reputationStandingText = "+"..BreakUpLargeNumbers(value)
			else
				value = threshold-value
				self.Content.ReputationBar.BarText:SetText(BreakUpLargeNumbers(value))
				self.Content.ReputationBar.reputationStandingText = BreakUpLargeNumbers(value)
			end
			self.Content.ReputationBar.barProgressText = nil
		end
	else
		self.count = nil
		self.questID = nil
		self.tooLowLevelForParagon = nil
		if self.Content.ReputationBar.ParagonOverlay then self.Content.ReputationBar.ParagonOverlay:Hide() end
	end
end

-- [Reputation Frame] Hook the Reputation Frame.
for _,children in ipairs({ReputationFrame.ScrollBox.ScrollTarget:GetChildren()}) do
	if children.Initialize then
		hooksecurefunc(children,"Initialize",function(self)
			UpdateBar(self)
		end)
	end
	UpdateBar(children)
end
hooksecurefunc(ReputationEntryMixin,"Initialize",function(self)
	UpdateBar(self)
end)
