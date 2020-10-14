local _, ns = ...
local M, R, U, I = unpack(ns)

local bit_band, bit_bor = bit.band, bit.bor
local COMBATLOG_OBJECT_AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE or 0x00000001
local GetSpecialization, GetSpecializationInfo = GetSpecialization, GetSpecializationInfo

I.Version = GetAddOnMetadata("_ShiGuang", "Version")
I.Support = GetAddOnMetadata("_ShiGuang", "X-Support")
I.Client = GetLocale()
I.ScreenWidth, I.ScreenHeight = GetPhysicalScreenSize()
I.isNewPatch = select(4, GetBuildInfo()) > 90000 -- keep it for future purpose

-- Deprecated
LE_ITEM_QUALITY_POOR = Enum.ItemQuality.Poor
LE_ITEM_QUALITY_COMMON = Enum.ItemQuality.Common
LE_ITEM_QUALITY_UNCOMMON = Enum.ItemQuality.Uncommon
LE_ITEM_QUALITY_RARE = Enum.ItemQuality.Rare
LE_ITEM_QUALITY_EPIC = Enum.ItemQuality.Epic
LE_ITEM_QUALITY_LEGENDARY = Enum.ItemQuality.Legendary
LE_ITEM_QUALITY_ARTIFACT = Enum.ItemQuality.Artifact
LE_ITEM_QUALITY_HEIRLOOM = Enum.ItemQuality.Heirloom

-- Colors
I.MyName = UnitName("player")
I.MyRealm = GetRealmName()
I.MyClass = select(2, UnitClass("player"))
I.MyFaction = UnitFactionGroup("player")
I.ClassList = {}
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	I.ClassList[v] = k
end
I.ClassColors = {}
local colors = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
for class, value in pairs(colors) do
	I.ClassColors[class] = {}
	I.ClassColors[class].r = value.r
	I.ClassColors[class].g = value.g
	I.ClassColors[class].b = value.b
	I.ClassColors[class].colorStr = value.colorStr
end
I.r, I.g, I.b = I.ClassColors[I.MyClass].r, I.ClassColors[I.MyClass].g, I.ClassColors[I.MyClass].b
I.MyColor = format("|cff%02x%02x%02x", I.r*255, I.g*255, I.b*255)
I.InfoColor = "|cff99ccff"
I.GreyColor = "|cff7b8489"  --cff808080
I.QualityColors = {}
local qualityColors = BAG_ITEM_QUALITY_COLORS
for index, value in pairs(qualityColors) do
	I.QualityColors[index] = {r = value.r, g = value.g, b = value.b}
end
I.QualityColors[-1] = {r = 0, g = 0, b = 0}
I.QualityColors[LE_ITEM_QUALITY_POOR] = {r = .61, g = .61, b = .61}
I.QualityColors[LE_ITEM_QUALITY_COMMON] = {r = 0, g = 0, b = 0}

-- Fonts
I.Font = {STANDARD_TEXT_FONT, 12, "OUTLINE"}
I.LineString = I.GreyColor.."---------------"

-- Textures
local Media = "Interface\\Addons\\_ShiGuang\\Media\\"
I.bdTex = "Interface\\ChatFrame\\ChatFrameBackground"
I.glowTex = Media.."glowTex"
I.normTex = Media.."normTex"
I.gradTex = Media.."gradTex"
I.flatTex = Media.."flatTex"
I.bgTex = Media.."bgTex"
I.arrowTex = Media.."Modules\\Raid\\Arrow"  --"Interface\\BUTTONS\\UI-MicroStream-Red.blp"
I.MicroTex = Media.."Hutu\\"
I.rolesTex = Media.."UI-LFG-ICON-ROLES"
I.chatLogo = Media.."2UI.blp"
I.logoTex = Media.."2UI.blp"
I.ArrowUp = Media.."Modules\\Raid\\ArrowLarge"
I.mailTex = "Interface\\Minimap\\Tracking\\Mailbox"
I.gearTex = "Interface\\WorldMap\\Gear_64"
I.eyeTex = "Interface\\Minimap\\Raid_Icon"		-- blue: \\Dungeon_Icon
I.garrTex = "Interface\\HelpFrame\\HelpIcon-ReportLag"
I.copyTex = "Interface\\Buttons\\UI-GuildButton-PublicNote-Up"
I.binTex = "Interface\\HelpFrame\\ReportLagIcon-Loot"
I.questTex = "adventureguide-microbutton-alert"
I.objectTex = "Warfronts-BaseMapIcons-Horde-Barracks-Minimap"
I.creditTex = "Interface\\HelpFrame\\HelpIcon-KnowledgeBase"
I.newItemFlash = "Interface\\Cooldown\\star4"
I.sparkTex = "Interface\\CastingBar\\UI-CastingBar-Spark"
I.TexCoord = {.08, .92, .08, .92}
I.textures = {
	normal		= Media.."ActionBar\\gloss",
	flash		= Media.."ActionBar\\flash",
	pushed		= Media.."ActionBar\\pushed",
}
I.LeftButton = " |TInterface\\TUTORIALFRAME\\UI-TUTORIAL-FRAME:13:11:0:-1:512:512:12:66:230:307|t "
I.RightButton = " |TInterface\\TUTORIALFRAME\\UI-TUTORIAL-FRAME:13:11:0:-1:512:512:12:66:333:410|t "
I.ScrollButton = " |TInterface\\TUTORIALFRAME\\UI-TUTORIAL-FRAME:13:11:0:-1:512:512:12:66:127:204|t "
I.AFKTex = "|T"..FRIENDS_TEXTURE_AFK..":14:14:0:0:16:16:1:15:1:15|t"
I.DNDTex = "|T"..FRIENDS_TEXTURE_DND..":14:14:0:0:16:16:1:15:1:15|t"

-- Flags
function I:IsMyPet(flags)
	return bit_band(flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0
end
I.PartyPetFlags = bit_bor(COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PET)
I.RaidPetFlags = bit_bor(COMBATLOG_OBJECT_AFFILIATION_RAID, COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PET)

-- RoleUpdater
local function CheckRole()
	local tree = GetSpecialization()
	if not tree then return end
	local _, _, _, _, role, stat = GetSpecializationInfo(tree)
	if role == "TANK" then
		I.Role = "Tank"
	elseif role == "HEALER" then
		I.Role = "Healer"
	elseif role == "DAMAGER" then
		if stat == 4 then	--1力量，2敏捷，4智力
			I.Role = "Caster"
		else
			I.Role = "Melee"
		end
	end
end
M:RegisterEvent("PLAYER_LOGIN", CheckRole)
M:RegisterEvent("PLAYER_TALENT_UPDATE", CheckRole)

-- Raidbuff Checklist
I.BuffList = {
	[1] = {		-- 合剂
		--251836,	-- 敏捷238
		--251837,	-- 智力238
		--251838,	-- 耐力238
		--251839,	-- 力量238
		298836,	-- 敏捷360
		298837,	-- 智力360
		298839,	-- 耐力360
		298841,	-- 力量360

		307166,	-- 大锅
		307185,	-- 通用合剂
		307187,	-- 耐力合剂
	},
	[2] = {     -- 进食充分
		104273, -- 250敏捷，BUFF名一致
	},
	[3] = {     -- 10%智力
		1459,
		264760,
	},
	[4] = {     -- 10%耐力
		21562,
		264764,
	},
	[5] = {     -- 10%攻强
		6673,
		264761,
	},
	[6] = {     -- 符文
		270058,
	},
}

-- Reminder Buffs Checklist
I.ReminderBuffs = {
	MAGE = {
		{	spells = {	-- 奥术魔宠
				[210126] = true,
			},
			depend = 205022,
			spec = 1,
			combat = true,
			instance = true,
			pvp = true,
		},
		{	spells = {	-- 奥术智慧
				[1459] = true,
			},
			depend = 1459,
			instance = true,
		},
	},
	PRIEST = {
		{	spells = {	-- 真言术耐
				[21562] = true,
			},
			depend = 21562,
			instance = true,
		},
	},
	WARRIOR = {
		{	spells = {	-- 战斗怒吼
				[6673] = true,
			},
			depend = 6673,
			instance = true,
		},
	},
	SHAMAN = {
		{	spells = {
				[192106] = true,	-- 闪电之盾
				[974] = true,		-- 大地之盾
				[52127] = true,		-- 水之护盾
			},
			depend = 192106,
			combat = true,
			instance = true,
			pvp = true,
		},
		{	spells = {
				[33757] = true,		-- 风怒武器
			},
			depend = 33757,
			combat = true,
			instance = true,
			pvp = true,
			weaponIndex = 1,
			spec = 2,
		},
		{	spells = {
				[318038] = true,	-- 火舌武器
			},
			depend = 318038,
			combat = true,
			instance = true,
			pvp = true,
			weaponIndex = 2,
			spec = 2,
		},
	},
	ROGUE = {
		{	spells = {	-- 伤害类毒药
				[2823] = true,		-- 致命药膏
				[8679] = true,		-- 致伤药膏
				[315584] = true,	-- 速效药膏
			},
			combat = true,
			instance = true,
			pvp = true,
		},
		{	spells = {	-- 效果类毒药
				[3408] = true,		-- 减速药膏
				[5761] = true,		-- 迟钝药膏
			},
			pvp = true,
		},
	},
}
