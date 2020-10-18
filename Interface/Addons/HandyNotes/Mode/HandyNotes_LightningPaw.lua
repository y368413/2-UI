-- ## Author: Voidiver
local LightningPaw = {}
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
--local Paw = HandyNotes:NewModule("HandyNotes_LightningPaw", "AceEvent-3.0", "AceHook-3.0", "AceConsole-3.0")
local Paw = HandyNotes:NewModule("HandyNotes_LightningPaw")
local Icon_Grass = "Interface\\GLUES\\Models\\UI_PandarenCharacterSelect\\PandaCharSel_Grass02"

--- ------------------------------------------------------------
--> 
--- ------------------------------------------------------------

local Data = {
	[47] = {
		[24167153] = {
			["title"] = "",
			["cont"] = false,
			["icon"] = 1,
			["desc"] = "",
		},
		[15943386] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[15245876] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[15154935] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[40787383] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[25774145] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[25233487] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[30234139] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[30085748] = {
			["title"] = "",
			["cont"] = false,
			["icon"] = 1,
			["desc"] = "",
		},
		[25987734] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[36536358] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[34725337] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[17083620] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[25853746] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[22782872] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[15715318] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[18393562] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[29594323] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[27423943] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[12405505] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[35555909] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[31935976] = {
			["title"] = "",
			["cont"] = false,
			["icon"] = 1,
			["desc"] = "",
		},
		[23697695] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[16635453] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[28587459] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[28925665] = {
			["title"] = "",
			["cont"] = false,
			["icon"] = 1,
			["desc"] = "",
		},
		[18402631] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[14045696] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[14975584] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[12805617] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[13425822] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[24223967] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[22987330] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[13413488] = {
			["title"] = "",
			["cont"] = false,
			["icon"] = 1,
			["desc"] = "",
		},
		[16276009] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[37187605] = {
			["title"] = "",
			["cont"] = false,
			["icon"] = 1,
			["desc"] = "",
		},
		[23725035] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[28444316] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[30393752] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[33316980] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
		[18863652] = {
			["cont"] = false,
			["icon"] = 1,
			["title"] = "",
			["desc"] = "",
		},
	},
}

--- ------------------------------------------------------------
--> 
--- ------------------------------------------------------------

local locale = GetLocale()
local L = {}
if (locale == "zhCN") then
	L["电爪"] = "电爪"
	L["图标外观设置"] = "图标外观设置"
	L["比例"] = "大小"
	L["图标的比例"] = "图标的大小缩放比例"
	L["透明度"] = "透明度"
	L["图标的透明度"] = "图标的透明度"
	L["草丛"] = "草丛"
elseif (locale == "zhTW") then
	L["电爪"] = "閃爪"
	L["图标外观设置"] = "圖示外觀設定"
	L["比例"] = "大小"
	L["图标的比例"] = "圖示的大小"
	L["透明度"] = "透明度"
	L["图标的透明度"] = "圖示的透明度"
	L["草丛"] = "草叢"
else
	L["电爪"] = "Lightning Paw"
	L["图标外观设置"] = "These settings control the look and feel of the icon."
	L["比例"] = "Icon Scale"
	L["图标的比例"] = "The scale of the icons"
	L["透明度"] = "Icon Alpha"
	L["图标的透明度"] = "The alpha transparency of the icons"
	L["草丛"] = "草丛"
end

--- ------------------------------------------------------------
--> 
--- ------------------------------------------------------------

local PawHandler = {}

function PawHandler:OnEnter(mapFile, coord)
	local tooltip = GameTooltip
	if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	local title = L["草丛"]
	tooltip:SetText(title)
	tooltip:Show()
end

function PawHandler:OnLeave(mapFile, coord)
		GameTooltip:Hide()
end

do
	local function iterFunc(t, prestate)
		if not t then return end

		local state, value = next(t, prestate)
		while state do
			if value then
				return state, nil, Icon_Grass, Paw.db.profile.icon_scale, Paw.db.profile.icon_alpha
			end

			state, value = next(t, state)
		end
	end

	function PawHandler: GetNodes2(mapID, minimap)
		return iterFunc, Data[mapID]
	end
end

--- ------------------------------------------------------------
--> 
--- ------------------------------------------------------------

local options = {
	type = "group",
	name = L["电爪"],
	desc = L["电爪"],
	get = function(info) return Paw.db.profile[info.arg] end,
	set = function(info, v)
		Paw.db.profile[info.arg] = v
		Paw:SendMessage("HandyNotes_NotifyUpdate", "Paw")
	end,
	args = {
		desc = {
			name = L["图标外观设置"],
			type = "description",
			order = 0,
		},
		icon_scale = {
			type = "range",
			name = L["比例"],
			desc = L["图标的比例"],
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 10,
		},
		icon_alpha = {
			type = "range",
			name = L["透明度"],
			desc = L["图标的透明度"],
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 20,
		},
	},
}

function Paw:OnInitialize()
	local defaults = {
		profile = {
			icon_scale = 1.0,
			icon_alpha = 0.75,
		},
	}
	self.db = LibStub("AceDB-3.0"):New("HandyNotes_LightningPawDB", defaults, "Default")
	HandyNotes:RegisterPluginDB("LightningPaw", PawHandler, options)
end