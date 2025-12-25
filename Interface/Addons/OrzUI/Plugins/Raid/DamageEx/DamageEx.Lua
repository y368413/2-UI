--*******************************************************
--*          正式服11.1 /怀旧服WLK              		       *
--*  更新日期：2025.05.12                            		       *
--*  更新内容：							       *
--*		1、优化了重叠处理的调整速度，顺畅一点；	*
--*		2、连击点/真气的显示改为用事件处理		*
--*******************************************************
local dex_lastani = 1;
local dex_bottom = 0;
local dex_petbottom = 0
local DEX_MAXANI = 20;
local DEX_TEXTSIZE = 22;
local DEX_OUTLINE = "";
local DEX_FONTNAME = DEX_FontList[1];
local DEX_SHADOW = 2;

local AniRunTime = 1
local AOEEnd = 0.1

local unitList = {};

local infoFont = 26
local infoFontHit = 35
local ifSize = {500, 150}
local fontType = "Fonts\\ARKai_T.TTF"
local infoP1 = {"BOTTOM", DEX_TEXT, "CENTER",-150, -150}
local frames = {}
local fadeTime = 3
local frameMaxLine = 3
local DEX_OverHeal = 0

local HitPoints = 0
local PlayerW = nil
local currentSpec = nil
local PlayerTelenid = nil

DEX_ReflectSpellID = 0
DEX_ReflectFromID = 0
DEX_ReflectTimer = 0

DEX_ANI_UID = -9999999

DEX_DAMAGE_TYPE_AOESPELL = -1
DEX_DAMAGE_TYPE_AOEDOT = -2
DEX_DAMAGE_TYPE_AOESHIELD = -3
DEX_DAMAGE_TYPE_AOEHEALTH = -4
DEX_DAMAGE_TYPE_HIT = 0
DEX_DAMAGE_TYPE_SPELL = 1
DEX_DAMAGE_TYPE_PERIODIC = 2
DEX_DAMAGE_TYPE_HEALTH = 3
DEX_DAMAGE_TYPE_BEATTACK = 4
DEX_DAMAGE_TYPE_HONOR = 5
DEX_DAMAGE_TYPE_MANA = 6
DEX_DAMAGE_TYPE_ENVTYPE = 7
DEX_DAMAGE_TYPE_PET = 4096

DEX_MOVTYP_NORMAL = 0;
DEX_MOVTYP_AOE = 1;
DEX_MOVTYP_PET = 2;
DEX_MOVTYP_OTHER = 3;
DEX_MOVTYP_NONE = 99;
DEX_MOVTYP_ATTACK = 4
DEX_MOVTYP_HEALTH = 5

DEX_HEX_LIST = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","f"}

local DEX_critFlag = 0;
local DEX_logFlag = 1;

local amount, school, resisted, blocked, absorbed, critical, glancing, crushing, Blocked
local spellId, spellName, spellSchool, missType, powerType, extraAmount, environmentalType, extraSpellId, extraSpellName, extraSpellSchool, auraType
local missType, IsOldServer, GameVersion

local dexType,dexText,dexSpell,dexCrit
local playerGUID, petGUID, targetGUID, vehicleGUID

local DEX_CritFix = {
	{y = 99999,uid = 0,aid = 1},
	{y = 99999,uid = 0,aid = 1},
}

local DEX_MovTypOther_TimerSlot = {0,0,0,0,0}

local TimeTmp = {
		["NT"] = 0,
		["AT"] = 0,
		["HT"] = 0,
		["PT"] = 0,
	}
local DataTmpHealth = {
		["damage"] = 0,
		["spell"] = "",
		["damagetype"] = 0,
		["crit"] = 0,
		["iscurTarget"] = false,
		["coerciveShowSpell"] = false,
		["TargetGUID"] = "",
		["TargetName"] = "",
		["HitType"] = 0,
		["spellid"] = 0,
		["StartTime"] = 0,
		["OverDamage"] = 0,
		["Frame"] = nil,
	}
local DataTmpSpell = {
		["damage"] = 0,
		["spell"] = "",
		["damagetype"] = 0,
		["crit"] = 0,
		["iscurTarget"] = false,
		["coerciveShowSpell"] = false,
		["TargetGUID"] = "",
		["TargetName"] = "",
		["HitType"] = 0,
		["spellid"] = 0,
		["StartTime"] = 0,
		["OverDamage"] = 0,
		["Frame"] = nil,
	}
local DataTmpDot = {
		["damage"] = 0,
		["spell"] = "",
		["damagetype"] = 0,
		["crit"] = 0,
		["iscurTarget"] = false,
		["coerciveShowSpell"] = false,
		["TargetGUID"] = "",
		["TargetName"] = "",
		["HitType"] = 0,
		["spellid"] = 0,
		["StartTime"] = 0,
		["OverDamage"] = 0,
		["Frame"] = nil,
	}
local DataTmpShield = {
		["damage"] = 0,
		["spell"] = "",
		["damagetype"] = 0,
		["crit"] = 0,
		["iscurTarget"] = false,
		["coerciveShowSpell"] = false,
		["TargetGUID"] = "",
		["TargetName"] = "",
		["HitType"] = 0,
		["spellid"] = 0,
		["StartTime"] = 0,
		["OverDamage"] = 0,
		["Frame"] = nil,
	}
local environmentalTypeText = {
	Drowning = ACTION_ENVIRONMENTAL_DAMAGE_DROWNING,
	Falling = ACTION_ENVIRONMENTAL_DAMAGE_FALLING,
	Fatigue = ACTION_ENVIRONMENTAL_DAMAGE_FATIGUE,
	Fire = ACTION_ENVIRONMENTAL_DAMAGE_FIRE,
	Lava = ACTION_ENVIRONMENTAL_DAMAGE_LAVA,
	Slime = ACTION_ENVIRONMENTAL_DAMAGE_SLIME,
}

local DEX_PREFIXES = {
		["SWING"] = 1,
		["RANGE"] = 4,
		["SPELL"] = 4,
		["SPELL_PERIODIC"] = 4,
		["ENVIRONMENTAL"] = 2,
		["DAMAGE"] = 4,
		["SPELL_BUILDING"] = 4,
	}

local DEX_FONTEFF = {
		{ol = "",shadowOff = 1},
		{ol = "OUTLINE",shadowOff = 0},
		{ol = "OUTLINE",shadowOff = 2},
		{ol = "THICKOUTLINE",shadowOff = 0},
		{ol = "THICKOUTLINE",shadowOff = 2},
	}

local dex_AniData = {
		["aniText1"] = {},					-- These are structures that define the animation data
		["aniText2"] = {},
		["aniText3"] = {},
		["aniText4"] = {},
		["aniText5"] = {},
		["aniText6"] = {},					-- These are structures that define the animation data
		["aniText7"] = {},
		["aniText8"] = {},
		["aniText9"] = {},
		["aniText10"] = {},
		["aniText11"] = {},					-- These are structures that define the animation data
		["aniText12"] = {},
		["aniText13"] = {},
		["aniText14"] = {},
		["aniText15"] = {},
		["aniText16"] = {},					-- These are structures that define the animation data
		["aniText17"] = {},
		["aniText18"] = {},
		["aniText19"] = {},
		["aniText20"] = {},
}
local CFG = {
	["DEX_Enable"] = 1,
	["DEX_ShowWithMess"] = 0,
	["DEX_ShowDamagePet"] = 1,
	["DEX_PetPosX"] = 0,
	["DEX_PetPosY"] = 0,
	["DEX_NumberFormat"] = 1,
	["DEX_ShowHit"] = 0,
	["DEX_ShowHitX"] = 0,
	["DEX_ShowHitY"] = 0,
	["DEX_ShowInterrupt"] = 1,
	["DEX_ShowInterruptCrit"] = 1,
	["DEX_ShowCurrentOnly"] = 0,
	["DEX_ShowDamage"] = 1,
	["DEX_ShowDamagePeriodic"] = 1,
	["DEX_ShowDamageShield"] = 1,
	["DEX_ShowBlockNumber"] = 0,
	["DEX_ShowSpellName"] = 1,
	["DEX_ShowNameOnCrit"] = 1,
	["DEX_ShowNameOnMiss"] = 1,
	["DEX_ShowSpellIcon"] = 0,
	["DEX_ShowSpellIconOnCrit"] = 1,
	["DEX_ShowDamageIconOnCrit"] = 1,
	["DEX_UniteSpell"] = 1,
	["DEX_ShowDamageWoW"] = 0,
	["DEX_ShowCritIcon"] = 1,
	["DEX_ShowDamageSpellName"] = 1,
	["DEX_ShowDamageNameOnCrit"] = 1,
	["DEX_ShowDamageSpellIcon"] = 1,
	["DEX_ShowDamageSpellIconOnCrit"] = 1,
	["DEX_ShowDebuff"] = 1,	
	["DEX_BeAttackPosX"] = 0,
	["DEX_BeAttackPosY"] = 0,
	["DEX_ShowDamageType"] = 1,
	["DEX_ShowDamageHealth"] = 1,
	["DEX_ShowOwnHealth"] = 1,
	["DEX_ShowOverHeal"] = 0,
	["DEX_ShowBuff"] = 1,	
	["DEX_ShowHealthSpellName"] = 1,
	["DEX_ShowHealthNameOnCrit"] = 1,
	["DEX_ShowHealthSpellIcon"] = 1,
	["DEX_ShowHealthSpellIconOnCrit"] = 0,
	["DEX_ShowHealthCritIcon"] = 0,
	["DEX_HealthPosX"] = 0,
	["DEX_HealthPosY"] = 0,
	["DEX_ShowHealthType"] = 1,
	["DEX_Speed"] = 80,
	["DEX_PosX"] = 280,
	["DEX_PosY"] = 230,
	["DEX_FontSize"] = 21,
	["DEX_Font"] = 2,
	["DEX_OutLine"] = 1,
	["DEX_ColorPet"] = {1,0.6,0},
	["DEX_ColorPetSe"] = {0.85,0.85,0},
	["DEX_ColorNormal"] = {1,1,1},
	["DEX_ColorNormalSe"] = {0.78,0.8,1},
	["DEX_ColorSkill"] = {1,1,0},
	["DEX_ColorSkillSe"] = {1,0.24,0},
	["DEX_ColorPeriodic"] = {1,0.3,1},
	["DEX_ColorPeriodicSe"] = {1,0,1},
	["DEX_ColorHealth"] = {0,1,0},
	["DEX_ColorHealthSe"] = {0,0.85,0},
	["DEX_ColorSpec"] = {0.85,0.85,0},
	["DEX_ColorSpecSe"] = {1,1,1},
	["DEX_ColorMana"] = {0,0,1},
	["DEX_ColorManaSe"] = {0.3,0.3,1},
	["DEX_ColorAttack"] = {1,0.3,1},
	["DEX_ColorAttackSe"] = {1,0,1},
	["DEX_ColorMode"] = 3,
	["DEX_LOGLINE"] = 10,
	["DEX_LOGTIME"] = 10,
	["DEX_FrameLevel"] = 2,
	["DEX_AOETime"] = 7,
	["DEX_IconSize"] = 3,
	["DEX_State"] = 0,
	["DEX_NoCombatHeal"] = 0,
	["DEX_AdjustTime"] = 0,
	["DEX_RandomCrit"] = 0,
	["DEX_CritX"] = 0,
	["DEX_CritY"] = 0,
	["DEX_HealthFull"] = 1,
	["DEX_OverDamage"] = 0,
	["DEX_BaseFrame"] = 0,
	["DEX_GameEnable"] = 0,
	["DEX_Circle"] = 0,
}

DEXPlayer = nil;
DEX_DEFAULT_CFG = {
	["DEX_Enable"] = 1,
	["DEX_ShowWithMess"] = 0,
	["DEX_ShowDamagePet"] = 1,
	["DEX_PetPosX"] = 0,
	["DEX_PetPosY"] = 0,
	["DEX_NumberFormat"] = 1,
	["DEX_ShowHit"] = 0,
	["DEX_ShowHitX"] = 0,
	["DEX_ShowHitY"] = 0,
	["DEX_ShowInterrupt"] = 1,
	["DEX_ShowInterruptCrit"] = 1,
	["DEX_ShowCurrentOnly"] = 0,
	["DEX_ShowDamage"] = 1,
	["DEX_ShowDamagePeriodic"] = 1,
	["DEX_ShowDamageShield"] = 1,
	["DEX_ShowBlockNumber"] = 0,
	["DEX_ShowSpellName"] = 1,
	["DEX_ShowNameOnCrit"] = 1,
	["DEX_ShowNameOnMiss"] = 1,
	["DEX_ShowSpellIcon"] = 0,
	["DEX_ShowSpellIconOnCrit"] = 1,
	["DEX_ShowDamageIconOnCrit"] = 1,
	["DEX_UniteSpell"] = 1,
	["DEX_ShowDamageWoW"] = 0,
	["DEX_ShowCritIcon"] = 1,
	["DEX_ShowDamageSpellName"] = 1,
	["DEX_ShowDamageNameOnCrit"] = 1,
	["DEX_ShowDamageSpellIcon"] = 1,
	["DEX_ShowDamageSpellIconOnCrit"] = 1,
	["DEX_ShowDebuff"] = 1,	
	["DEX_BeAttackPosX"] = 0,
	["DEX_BeAttackPosY"] = 0,
	["DEX_ShowDamageType"] = 1,
	["DEX_ShowDamageHealth"] = 1,
	["DEX_ShowOwnHealth"] = 1,
	["DEX_ShowOverHeal"] = 0,
	["DEX_ShowBuff"] = 1,	
	["DEX_ShowHealthSpellName"] = 1,
	["DEX_ShowHealthNameOnCrit"] = 1,
	["DEX_ShowHealthSpellIcon"] = 1,
	["DEX_ShowHealthSpellIconOnCrit"] = 0,
	["DEX_ShowHealthCritIcon"] = 0,
	["DEX_HealthPosX"] = 0,
	["DEX_HealthPosY"] = 0,
	["DEX_ShowHealthType"] = 1,
	["DEX_Speed"] = 80,
	["DEX_PosX"] = 280,
	["DEX_PosY"] = 230,
	["DEX_FontSize"] = 21,
	["DEX_Font"] = 2,
	["DEX_OutLine"] = 1,
	["DEX_ColorPet"] = {1,0.6,0},
	["DEX_ColorPetSe"] = {0.85,0.85,0},
	["DEX_ColorNormal"] = {1,1,1},
	["DEX_ColorNormalSe"] = {0.78,0.8,1},
	["DEX_ColorSkill"] = {1,1,0},
	["DEX_ColorSkillSe"] = {1,0.24,0},
	["DEX_ColorPeriodic"] = {1,0.3,1},
	["DEX_ColorPeriodicSe"] = {1,0,1},
	["DEX_ColorHealth"] = {0,1,0},
	["DEX_ColorHealthSe"] = {0,0.85,0},
	["DEX_ColorSpec"] = {0.85,0.85,0},
	["DEX_ColorSpecSe"] = {1,1,1},
	["DEX_ColorMana"] = {0,0,1},
	["DEX_ColorManaSe"] = {0.3,0.3,1},
	["DEX_ColorAttack"] = {1,0.3,1},
	["DEX_ColorAttackSe"] = {1,0,1},
	["DEX_ColorMode"] = 3,
	["DEX_LOGLINE"] = 10,
	["DEX_LOGTIME"] = 10,
	["DEX_FrameLevel"] = 2,
	["DEX_AOETime"] = 7,
	["DEX_IconSize"] = 3,
	["DEX_State"] = 0,
	["DEX_NoCombatHeal"] = 0,
	["DEX_AdjustTime"] = 0,
	["DEX_RandomCrit"] = 0,
	["DEX_CritX"] = 0,
	["DEX_CritY"] = 0,
	["DEX_HealthFull"] = 1,
	["DEX_OverDamage"] = 0,
	["DEX_BaseFrame"] = 0,
	["DEX_GameEnable"] = 0,
	["DEX_Circle"] = 0,
}

local GetSpellInfo = GetSpellInfo or function(spellID)
	if IsOldServer then
	    local name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(spellID)
	    return {
        	name = name,
	        rank = rank,
        	iconID = icon,
	        originalIconID = originalIcon,
        	castTime = castTime,
	        minRange = minRange,
        	maxRange = maxRange,
	        spellID = spellID
	    }
	else
		if not spellID then
			return nil;
		end
		local SPELLID = nil
		if type(spellID) ~= "string" then
			if tostring(spellID) == nil then
				return nil;
			else
				SPELLID = tostring(spellID)
			end
		else
			SPELLID = spellID
		end
		local spellInfo = C_Spell.GetSpellInfo(SPELLID);
		if spellInfo then
			return spellInfo.name, nil, spellInfo.iconID, spellInfo.castTime, spellInfo.minRange, spellInfo.maxRange, spellInfo.spellID, spellInfo.originalIconID;
		else
			return nil;
		end
	end
end

DEX_DISPELLED_FILTER = {}

--野德和盗贼连击点信息框
local function CreateHitFrame(name, justify, fontType,fontSize, framesize, point)
	local frame = CreateFrame("ScrollingMessageFrame", name, DEX_TEXT)

	frame:SetSpacing(3)
	frame:SetMaxLines(1)
	frame:SetSize(unpack(framesize))
	frame:SetFadeDuration(0.2)
	frame:SetJustifyH(justify)
	frame:SetTimeVisible(fadeTime)
	frame:SetFont(fontType, fontSize, "OUTLINE")
	frame:SetPoint(unpack(point))
	frame:SetInsertMode("top")

	return frame
end

local function TimeTmpReset()
	TimeTmp.NT = 0
	TimeTmp.AT = 0
	TimeTmp.HT = 0
	TimeTmp.PT = 0
end

--function DEX_Debug(msg)
	--DEFAULT_CHAT_FRAME:AddMessage("|cff10ff00"..msg.."|r");
--end

function DEX_OnLoad(self)
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("UNIT_PET");
	self:RegisterEvent("UNIT_ENTERED_VEHICLE");			--进入载具
	self:RegisterEvent("UNIT_EXITING_VEHICLE");			--离开载具
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("PLAYER_REGEN_ENABLED");		--离开战斗
	self:RegisterEvent("PLAYER_REGEN_DISABLED");		--进入战斗
	self:RegisterEvent("UNIT_POWER_UPDATE");			--连击点等
	if IsOldServer then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	end
	self:RegisterEvent("NAME_PLATE_UNIT_ADDED");
	self:RegisterEvent("NAME_PLATE_UNIT_REMOVED");
end

function DEX_Init(self)
	DEXPlayer = DEX_Config_GetPlayer();
	--DEX_Debug(DEX_Version);

	SlashCmdList["DEX"] = DEX_showMenu;
	SLASH_DEX1 = "/dex";

	if(myAddOnsList) then
		myAddOnsList.DEX = {
			name = "Damage Text",
			description = "DamageEx",
			version = DEX_Version,
			frame = "DEX_TEXT",
			optionsframe = "DEXOptions",
			category = MYADDONS_CATEGORY_COMBAT
		};
	end

	-- Add my options frame to the global UI panel list
	UIPanelWindows["DEXOptions"] = {area = "center", pushable = 0};

	IsOldServer= CheckVersion(60000)

	DEX_aniInit();
	DEX_OnOptionCheck("DEX_Enable", DEX_Get("DEX_Enable") == 1)
end

--比对版本，判断怀旧服/正式服
function CheckVersion(VersionNumber)
	GameVersion = select(4, GetBuildInfo())
	if tonumber(GameVersion) then
		if tonumber(GameVersion) < VersionNumber then
			return true
		else
			return false
		end
	else
		return false
	end
end

function DEX_OnOptionCheck(name, checked)
	if name == "DEX_Enable" then
		local registered = DEX_TEXT:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED")
		if checked and not registered then
			DEX_TEXT:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		elseif not checked and registered then
			DEX_TEXT:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end
end

function DEX_Reset()
	DEX_hideMenu();
	DEX_Config_NewPlayer()
	DEXPlayer = DEX_Config_GetPlayer();
	DEX_showMenu();
end

function DEX_Config_GetPlayer()
	if (DEX_SAVE == nil) then
		DEX_Config_NewPlayer()
	end
	return DEX_SAVE
end

--Set up a default config
function DEX_Config_NewPlayer()
	DEX_SAVE = nil
	DEX_SAVE = DEX_clone(DEX_DEFAULT_CFG);
end
function DEX_Get(option)
	if (DEXPlayer ~= nil) and (DEXPlayer[option] ~= nil) then
		return DEXPlayer[option];
	else
		return DEX_DEFAULT_CFG[option];
	end
end

function DEX_Set(option, newVal)
	if (DEXPlayer ~= nil) then
		if ( option ) then
			DEXPlayer[option] = newVal;
		end
	end
end

function DEX_clone(t)
  local new = {};
  local i, v = next(t, nil);
  while i do
  	if type(v)=="table" then
  		v=DEX_clone(v);
  	end
    new[i] = v;
    i, v = next(t, i);
  end
  return new;
end

function DEX_ProcBlock()
	if DEX_Get("DEX_ShowBlockNumber") ~= 1 then return;end
--修正格档、吸收、减伤等
	if resisted then								--抵抗-
		Blocked = DEX_TXT_RESISTED
	elseif blocked and DEX_Get("DEX_ShowBlockNumber") == 1 then
		Blocked = DEX_TXT_BLOCKED				--格挡+
	elseif absorbed then
		Blocked = DEX_TXT_ABSORBED				--吸收<
	elseif glancing then
--		dexText = dexText..">"..getglobal("DEFLECT");	--偏斜>
		Blocked = DEX_TXT_GLANCING
	elseif crushing then
		Blocked = DEX_TXT_CRUSH;				--碾压/
	else
		Blocked = nil;
	end
	return
end

function DEX_OnEvent(self, event, ...)
	if event == "VARIABLES_LOADED" then
		IsOldServer= CheckVersion(60000)
		DEX_Init(self);
	elseif event == "PLAYER_LOGIN" then
		playerGUID = UnitGUID("player")
		petGUID = UnitGUID("pet")
		vehicleGUID = UnitGUID("vehicle")
		IsOldServer= CheckVersion(60000)
		DEX_aniInit();
	elseif event == "UNIT_PET" then
		if "player" == ... then
			petGUID = UnitGUID("pet")
		end
	elseif event == "NAME_PLATE_UNIT_ADDED" then
		local unitID = ...;
		if unitID ~= nil then
			if UnitGUID(unitID) ~= nil then
				unitList[UnitGUID(unitID)] = C_NamePlate.GetNamePlateForUnit(unitID, issecure());
			end
		end
	elseif event == "NAME_PLATE_UNIT_REMOVED" then
		local unitID = ...;
		if unitID ~= nil then
			if UnitGUID(unitID) ~= nil then
				unitList[UnitGUID(unitID)] = nil;
			end
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		DEX_aniInit()
		if DEX_Get("DEX_State") == 1 and DEX_Get("DEX_ShowWithMess") ~= 1 and  DEX_Get("DEX_Enable") == 1 then
			DEX_AddText("进入战斗","",DEX_DAMAGE_TYPE_HONOR,1,true,false,"","","Begin",nil,GetTime(),0)
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		if DEX_Get("DEX_State") == 1 and DEX_Get("DEX_ShowWithMess") ~= 1 and  DEX_Get("DEX_Enable") == 1 then
			DEX_AddText("离开战斗","",DEX_DAMAGE_TYPE_HONOR,1,true,false,"","","End",nil,GetTime(),0)
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		targetGUID = UnitGUID("target")
	elseif event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITING_VEHICLE" then
		vehicleGUID = UnitGUID("vehicle")
	elseif event == "UNIT_POWER_UPDATE" then
		Power_Update();
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		DEX_ProcessCombatLog(CombatLogGetCurrentEventInfo())
	end
end
function Power_Update()
	if UnitAffectingCombat("player") then
		if DEX_Get("DEX_ShowHit") == 1 then
			if PlayerW == DEX_ROGUEID or (PlayerW == DEX_DRUIDID and PlayerTelenid == DEX_DRUIDFERAL) then
				HitPoints = UnitPower("player", 4);    --野德和盗贼连击点
			elseif PlayerW == DEX_MONKID and PlayerTelenid == DEX_MONKIDWINWALKER  and not IsOldServer then
				HitPoints = UnitPower("player", 12);    --武僧真气
			elseif PlayerW == DEX_DK then
				HitPoints = UnitPower("player", 5);	--DK符文
				HitPoints = 0						--DK符文数量不会变
			else
				HitPoints = 0
			end
			if HitPoints > 0 then
				if PlayerW == DEX_MONKID then
					frames["HitInformation"]:AddMessage(HitPoints..DEX_CHI, 1, 1, 0)
				elseif PlayerW == DEX_DK then
					frames["HitInformation"]:AddMessage(HitPoints..DEX_RUNES, 1, 1, 0)
				else
					frames["HitInformation"]:AddMessage(HitPoints..DEX_COMBOPOINTS, 1, 1, 0)
				end
			else
				frames["HitInformation"]:AddMessage("", 1, 1, 0)
			end
		end
	end
end

function HPSTATE()
	local hp = 0
	if vehicleGUID == nil then
		hp = UnitHealth("player") / UnitHealthMax("player") * 100
	else
		hp = UnitHealth("vehicle") / UnitHealthMax("vehicle") * 100
	end
	if hp < 100 and not UnitIsDeadOrGhost("player") then
		return false
	else
		return true
	end
end

function DEX_ProcessCombatLog(timeStamp, flag, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
	if DEX_Get("DEX_Enable") == 0  then
		return				--没有打开战斗显示
	end
	if type(flag) ~= "string" then
		return -- should never happen but just in case..
	end
	local prefixes, suffixes = strmatch(flag, "(.-)_(.+)")
	if not prefixes or not suffixes then
		return -- should never happen either, who knows..
	end
	if strsub(suffixes,1,8) == "PERIODIC" then
		prefixes = prefixes.."_PERIODIC"
		suffixes = strsub(suffixes,10)
	end
		--增加对建筑物造成的伤害
	if strsub(suffixes,1,8) == "BUILDING" then
		prefixes = prefixes.."_BUILDING"
		suffixes = strsub(suffixes,10)
	end
	if not UnitAffectingCombat("player") and (DEX_Get("DEX_NoCombatHeal") ~= 1) then
		if suffixes == "AURA_APPLIED" and (destGUID == playerGUID or destGUID == vehicleGUID) then
			return
		elseif suffixes == "HEAL" then
			return
		end
	end
                    --增加受到伤害
	local ISPLAYER = sourceGUID == playerGUID or sourceGUID == vehicleGUID;
-- or CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE);
	local ISTARGETPLAYER = destGUID == playerGUID or destGUID == vehicleGUID;      --判断受到伤害
	local ISPET = sourceGUID == petGUID  or CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET);
		--载具伤害特别处理
	if ISPET and sourceGUID == vehicleGUID then
		ISPET = false
	end
			--缺血治疗
	if suffixes == "HEAL" and HPSTATE() and ISTARGETPLAYER and DEX_Get("DEX_HealthFull") == 1 then
		return
	end

	local CombatTime = GetTime()

	if not ISPLAYER and not ISPET and not ISTARGETPLAYER then
		return -- irrelevant combat data, ignore
	end

	if DEX_Get("DEX_ShowDamageWoW") == 0 and ISTARGETPLAYER  then
			return -- 不处理受到的伤害
	end


	if ISPET and DEX_Get("DEX_ShowDamagePet") == 0 then
		return
	end
	local ISTARGET = destGUID == targetGUID
	if (not ISTARGET or (ISTARGETPLAYER and sourceGUID ~= targetGUID)) and DEX_Get("DEX_ShowCurrentOnly") == 1 then
		return
	end

	if suffixes == "HEAL" and destGUID == playerGUID and DEX_Get("DEX_ShowOwnHealth") ~= 1 then
		return
	end
	if suffixes == "HEAL" and DEX_Get("DEX_ShowDamageHealth") ~= 1 then
		return
	end
	
	--锚定战斗单位
	if DEX_Get("DEX_BaseFrame") == 1 then
		if destGUID == nil then
			return
		end
		Nameplate = unitList[destGUID];
		if Nameplate == nil then
			if UnitTokenFromGUID(destGUID) ~= nil then
				Nameplate = C_NamePlate.GetNamePlateForUnit(UnitTokenFromGUID(destGUID), issecure())
				if Nameplate ~= nil then
					unitList[destGUID] = Nameplate
				else
					if ISTARGETPLAYER and not ISPET then
						Nameplate = C_NamePlate.GetNamePlateForUnit("player", issecure())
					else
						Nameplate = C_NamePlate.GetNamePlateForUnit("target", issecure())
					end
				end
			else
				if ISTARGETPLAYER and not ISPET then
					Nameplate = C_NamePlate.GetNamePlateForUnit("player", issecure())
				else
					Nameplate = C_NamePlate.GetNamePlateForUnit("target", issecure())
				end
			end
		end
	end
	--数据开始处理
	spellName = ""
	spellId = nil
	spellScholl = ""
	amount = 0
	dexType = nil
	dexText = "0"
	dexSpell = ""
	dexCrit = 0
	DEX_OverHeal = 0
	Blocked = nil;

	if  (ISPLAYER or ISPET) and not ISTARGETPLAYER then
		if DEX_Get("DEX_ShowDamage") == 0 and suffixes ~= "INTERRUPT" then
			return
		end
		if suffixes == "INTERRUPT" and DEX_Get("DEX_ShowInterrupt") == 0 then
			return
		end
		if prefixes == "ENVIRONMENTAL" then		--不应该有的
			return
		end
		if flag == "SPELL_EXTRA_ATTACKS" then
			spellId, spellName, spellSchool,amount = select(1,...)
			if type(spellId) == "string" then
				spellId = nil
			end
			if spellId ~= nil then
				if select(1,GetSpellInfo(spellId))~=nil then 
					spellName = select(1,GetSpellInfo(spellId))
				end
			end
			if ISPLAYER then
				dexText = tostring(amount)
				dexType = DEX_DAMAGE_TYPE_HIT
				DEX_AddText(dexText,"",dexType,0,true,false,destGUID,destName,suffixes,spellId,CombatTime,DEX_OverHeal,Nameplate)
				return
			end
		end
		if flag == "SPELL_MISSED" then
			missType = select(4,...);
			dexText = getglobal(missType)
			if missType == "REFLECT" then
				if spellId then
					DEX_ReflectSpellID = select(1,...)
					DEX_ReflectFromID = sourceGUID
					DEX_ReflectTimer = GetTime()
				else
					dexType = DEX_DAMAGE_TYPE_HIT
					DEX_AddText(dexText,"",dexType,0,true,false,destGUID,destName,suffixes,spellId,CombatTime,DEX_OverHeal,Nameplate)
					return
				end
			end
		end

		if DEX_ReflectSpellID ~= 0 then
			if GetTime() - DEX_ReflectTimer < 1 then
				if destGUID == sourceGUID and sourceGUID == DEX_ReflectFromID then
					spellId, spellName, spellSchool = select(1,...)
					if type(spellId) == "string" then
						spellId = nil
					end
					if spellId ~= nil then
						if select(1,GetSpellInfo(spellId))~=nil then 
							spellName = select(1,GetSpellInfo(spellId))
						end
					end
					if spellId and DEX_ReflectSpellID == spellId then
						local fromTarget = false
						if destGUID == UnitGUID("target") then fromTarget = true;end
						dexType = DEX_DAMAGE_TYPE_HIT
						if flag == "SPELL_DAMAGE" then
							amount,overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(4,...);
							DEX_AddText(amount..DEX_TXT_REFLECT,spellName,DEX_DAMAGE_TYPE_SPELL,critical,true,destGUID,destName,suffixes, spellId,CombatTime,DEX_OverHeal,Nameplate)
							DEX_ReflectSpellID = 0
							return
						end
						if flag == "SPELL_MISSED" then
							missType = select(4,...)
							DEX_AddText(getglobal(missType)..DEX_TXT_REFLECT,spellName,DEX_DAMAGE_TYPE_SPELL,0,true,destGUID,destName,suffixes,spellId,CombatTime,DEX_OverHeal,Nameplate)
							DEX_ReflectSpellID = 0
							return
						end
					end
				end
			else
				DEX_ReflectSpellID = 0
			end
		end

		--DEX_Debug(flag);
		spellId, spellName, spellSchool = ...
		if type(spellId) == "string" then
			spellId = nil
		end
		if spellId ~= nil then
			if select(1,GetSpellInfo(spellId))~=nil then 
				spellName = select(1,GetSpellInfo(spellId))
			end
		end

		if suffixes == "DAMAGE" then

			amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(DEX_PREFIXES[prefixes],...);
			dexText = tostring(amount)
			if tonumber(overDamage) and DEX_Get("DEX_OverDamage") == 1 then
				DEX_OverHeal = tonumber(overDamage)
			end
			if critical then dexCrit = 1;end
			if prefixes == "SWING" then
				dexType = DEX_DAMAGE_TYPE_HIT
			elseif prefixes == "RANGE" then
				dexType = DEX_DAMAGE_TYPE_HIT
			elseif prefixes == "SPELL"then
				dexType = DEX_DAMAGE_TYPE_SPELL
				dexSpell = spellName
			elseif prefixes == "SPELL_PERIODIC" then
				if DEX_Get("DEX_ShowDamagePeriodic") == 0 then return;end
				dexType = DEX_DAMAGE_TYPE_PERIODIC
				dexSpell = spellName
			elseif prefixes == "SPELL_BUILDING" then
				dexType = DEX_DAMAGE_TYPE_SPELL
				dexSpell = spellName
			else
				return
			end
			DEX_ProcBlock()

		elseif suffixes == "MISSED" then
			missType = select(DEX_PREFIXES[prefixes],...);
			dexText = getglobal(missType)
			if prefixes == "SWING" then
				dexType = DEX_DAMAGE_TYPE_HIT
			elseif prefixes == "RANGE" then
				dexType = DEX_DAMAGE_TYPE_HIT
			elseif prefixes == "SPELL"then
				dexType = DEX_DAMAGE_TYPE_SPELL
				dexSpell = spellName
			elseif prefixes == "SPELL_PERIODIC" then
				if DEX_Get("DEX_ShowDamagePeriodic") == 0 then return;end
				dexType = DEX_DAMAGE_TYPE_PERIODIC
				dexSpell = spellName
			end

		elseif suffixes == "SHIELD_MISSED" then
			missType = select(4,...);
			dexText = getglobal(missType)
			if prefixes == "DAMAGE" then
				dexType = DEX_DAMAGE_TYPE_SPELL
				dexSpell = spellName
			end

		elseif suffixes == "HEAL"  then
			if not UnitAffectingCombat("player") and spellId == nil then
				return
			end
			amount, overDamage, _, critical = select(DEX_PREFIXES[prefixes],...);
			if not tonumber(amount) then
				return
			end
			dexText = amount
			if tonumber(overDamage) and DEX_Get("DEX_OverDamage") == 1 then
				DEX_OverHeal = overDamage
			end
			if critical and prefixes == "SPELL" and spellId ~= 143924 then dexCrit = 1;end		--Modify Heal Spell Critical,排除汲取效果
			--dexCrit = critical
			dexType = DEX_DAMAGE_TYPE_HEALTH
			if prefixes ~= "SWING" then
				dexSpell = spellName
			end

		elseif suffixes == "INTERRUPT" then 
			if DEX_Get("DEX_ShowInterrupt") == 1 then			-- Add Show Interupt Switch
				extraSpellId, extraSpellName, extraSpellSchool = select(DEX_PREFIXES[prefixes],...);
				dexText = DEX_TXT_INTERUPT
				dexSpell = extraSpellName
				if GetNumSubgroupMembers() > 0 then
					SendChatMessage("打断了"..destName.."的"..dexSpell,"EMOTE")
				end
				if DEX_Get("DEX_ShowInterruptCrit") == 1 then dexCrit = 1;end
				dexType = DEX_DAMAGE_TYPE_HONOR
			else
				return
			end  
		elseif suffixes == "DRAIN" or suffixes == "LEECH" then
			amount,powerType,extraAmount = select(DEX_PREFIXES[prefixes],...)
			dexText = amount
			dexSpell = spellName
			if extraAmount ~= -2 then
				dexType = DEX_DAMAGE_TYPE_MANA
			else
				dexType = DEX_DAMAGE_TYPE_SPELL
			end

		elseif suffixes == "SHIELD" and DEX_Get("DEX_ShowDamageShield") == 1 then
			amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(4,...)
			if prefixes == "DAMAGE" then
				dexType = DEX_DAMAGE_TYPE_SPELL
				dexText = amount
				dexSpell = spellName
				DEX_ProcBlock()
			else
				return
			end
		elseif suffixes == "SPLIT" then
			if prefixes == "DAMAGE" then
				amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(DEX_PREFIXES[prefixes],...)
				dexText = tostring(amount)
				if critical then dexCrit = 1;end
				dexType = DEX_DAMAGE_TYPE_SPELL
				dexSpell = spellName
				DEX_ProcBlock()
			else
				return
			end
		--驅散
		elseif suffixes == "DISPEL" then
			extraSpellID,extraSpellName,extraSpellSchool,auraType = select(DEX_PREFIXES[prefixes],...)
			if DEX_DISPELLED_FILTER[extraSpellName] then
				return
			end
			dexCrit = 1
			dexSpell = extraSpellName
			dexType = DEX_DAMAGE_TYPE_HONOR
			dexText = DEX_TXT_DISPELLED

		--偷取
		elseif suffixes == "STOLEN" then
			extraSpellID,extraSpellName,extraSpellSchool = select(DEX_PREFIXES[prefixes],...)
			dexCrit = 1
			dexType = DEX_DAMAGE_TYPE_HONOR
			dexText = DEX_TXT_STOLEN
			dexSpell = extraSpellName
		else
			return
		end

		if dexType then
			if ISPET then
				if dexType == DEX_DAMAGE_TYPE_HEALTH then
					return
				end
				dexType = DEX_DAMAGE_TYPE_PET
			end
		end

		if  dexType ~= DEX_DAMAGE_TYPE_PET then
			DEX_AddText(dexText,dexSpell,dexType,dexCrit,true,false,destGUID,destName,suffixes,spellId,CombatTime,DEX_OverHeal,Nameplate)
			return
		end

	elseif ISTARGETPLAYER and not ISPET then
		if DEX_Get("DEX_ShowDamageWoW") == 0 and suffixes ~= "AURA_APPLIED" and suffixes ~= "HEAL" then
			return
		end
		dexType = DEX_DAMAGE_TYPE_BEATTACK
		if flag == "SPELL_EXTRA_ATTACKS" then
			spellId, spellName, spellSchool,amount = select(1,...)
			if type(spellId) == "string" then
				spellId = nil
			end
			if spellId ~= nil then
				if select(1,GetSpellInfo(spellId))~=nil then 
					spellName = select(1,GetSpellInfo(spellId))
				end
			end
			dexText = tostring(amount)
			DEX_AddText(dexText,"",dexType,0,true,false,destGUID,destName,suffixes,spellId,CombatTime,DEX_OverHeal,Nameplate)
			return
		end
		if flag == "SPELL_MISSED" then
			missType = select(4,...);
			dexText = getglobal(missType)
			if missType == "REFLECT" then
				if spellId then
					DEX_ReflectSpellID = select(1,...)
					DEX_ReflectFromID = sourceGUID
					DEX_ReflectTimer = GetTime()
				else
					DEX_AddText(dexText,"",dexType,0,true,false,destGUID,destName,suffixes,spellId,CombatTime,DEX_OverHeal,Nameplate)
					return
				end
			end
		end

		if DEX_ReflectSpellID ~= 0 then
			if GetTime() - DEX_ReflectTimer < 1 then
				if sourceGUID == DEX_ReflectFromID then
					spellId, spellName, spellSchool = select(1,...)
					if type(spellId) == "string" then
						spellId = nil
					end
					if spellId ~= nil then
						if select(1,GetSpellInfo(spellId))~=nil then 
							spellName = select(1,GetSpellInfo(spellId))
						end
					end
					if spellId and DEX_ReflectSpellID == spellId then
						local fromTarget = false
						if destGUID == playerGUID then fromTarget = true;end
						if flag == "SPELL_DAMAGE" then
							amount,overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(4,...);
							DEX_AddText(amount..DEX_TXT_REFLECT,dexType,0,true,destGUID,destName,suffixes,spellId,CombatTime,DEX_OverHeal,Nameplate)
							DEX_ReflectSpellID = 0
							return
						end
						if flag == "SPELL_MISSED"  then
							missType = select(4,...)
							DEX_AddText(getglobal(missType)..DEX_TXT_REFLECT,spellName,dexType,0,true,destGUID,destName,suffixes,spellId,CombatTime,DEX_OverHeal,Nameplate)
							DEX_ReflectSpellID = 0
							return
						end
					end
				end
			else
				DEX_ReflectSpellID = 0
			end
		end

		--DEX_Debug(flag);
		spellId, spellName, spellSchool = ...
		if type(spellId) == "string" and prefixes ~= "ENVIRONMENTAL" then
			spellId = nil
		end
		if spellId ~= nil and prefixes ~= "ENVIRONMENTAL" then
			if select(1,GetSpellInfo(spellId))~=nil then 
				spellName = select(1,GetSpellInfo(spellId))
			end
		end

		if suffixes == "DAMAGE" then

			amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(DEX_PREFIXES[prefixes],...);
			dexText = tostring(amount)
			if critical then dexCrit = 1;end

			if prefixes == "SPELL" or prefixes == "SPELL_PERIODIC" or prefixes == "RANGE" then
				dexSpell = spellName
				DEX_ProcBlock()
			elseif prefixes == "SWING" then
				spellId = nil
				dexSpell = ""
				DEX_ProcBlock()
			elseif prefixes == "ENVIRONMENTAL" then
					if spellId ~= "Drowning" and spellId ~= "Falling" and spellId ~= "Fatigue" and spellId ~= "Fire" and spellId ~= "Lava" and spellId ~= "Slime" then
						return
					else
						dexSpell = environmentalTypeText[spellId]
						spellId = nil
						dexType = DEX_DAMAGE_TYPE_ENVTYPE
					end
			else
				return
			end

		elseif suffixes == "MISSED" then
			missType = select(DEX_PREFIXES[prefixes],...);
			dexText = getglobal(missType)
			if prefixes == "SPELL" or prefixes == "SPELL_PERIODIC" then
				dexSpell = spellName
			end

		elseif suffixes == "SHIELD_MISSED" then
			missType = select(4,...);
			dexText = getglobal(missType)
			dexSpell = spellName

		elseif suffixes == "HEAL"  then
			if not UnitAffectingCombat("player") and spellId == nil then
				return
			end
			amount, overDamage, _, critical = select(DEX_PREFIXES[prefixes],...);
			if not tonumber(amount) then
				return
			end
			dexText = amount
			if tonumber(overDamage) and DEX_Get("DEX_OverDamage") == 1 then
				DEX_OverHeal = overDamage
			end
			if critical and prefixes == "SPELL" and spellId ~= 143924 then dexCrit = 1;end		--Modify Heal Spell Critical,排除汲取效果
			--dexCrit = critical
			dexType = DEX_DAMAGE_TYPE_HEALTH
			if prefixes ~= "SWING" then
				dexSpell = spellName
			end

		elseif suffixes == "INTERRUPT" then 
			if DEX_Get("DEX_ShowInterrupt") == 1 then			-- Add Show Interupt Switch
				extraSpellId, extraSpellName, extraSpellSchool = select(DEX_PREFIXES[prefixes],...);
				dexSpell = extraSpellName
				dexText = DEX_TXT_INTERUPT
				if DEX_Get("DEX_ShowInterruptCrit") == 1 then dexCrit = 1;end
			else
				dexText = ""
			end  
		elseif suffixes == "DRAIN" or suffixes == "LEECH" then
			amount,powerType,extraAmount = select(DEX_PREFIXES[prefixes],...)
			dexText = amount
			dexSpell = spellName

		elseif suffixes == "SHIELD" and DEX_Get("DEX_ShowDamageShield") == 1 then
			amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(4,...)
			if prefixes == "DAMAGE" then
				dexText = amount
				dexSpell = spellName
				DEX_ProcBlock()
			else
				return
			end

		elseif suffixes == "SPLIT" then
			if prefixes == "DAMAGE" then
				amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(DEX_PREFIXES[prefixes],...)
				dexText = tostring(amount)
				if critical then dexCrit = 1;end
				dexSpell = spellName
				DEX_ProcBlock()
			else
				return
			end
		--驅散
		elseif suffixes == "DISPEL" then
			extraSpellID,extraSpellName,extraSpellSchool,auraType = select(DEX_PREFIXES[prefixes],...)
			if DEX_DISPELLED_FILTER[extraSpellName] then
				return
			end
			dexSpell = extraSpellName
			dexText = DEX_TXT_DISPELLED
			dexCrit = 1;

		--偷取
		elseif suffixes == "STOLEN" then
			extraSpellID,extraSpellName,extraSpellSchool = select(DEX_PREFIXES[prefixes],...)
			dexSpell = extraSpellName
			dexText = DEX_TXT_STOLEN
			dexCrit = 1;

		elseif suffixes == "AURA_APPLIED" then
			if DEX_Get("DEX_ShowBuff") == 0 and DEX_Get("DEX_ShowDeBuff") ==0 then
				return
			end
			spellId, spellName, spellSchool,amount = select(1,...)
			if not UnitAffectingCombat("player") and amount == "BUFF" then
				return
			end
			if type(spellId) == "string" then
				return
			end
			if ISPLAYER and amount == "BUFF" and DEX_Get("DEX_ShowBuff") == 1 and DEX_Get("DEX_ShowDamageHealth") == 1 then
				dexSpell = spellName
				dexType = DEX_DAMAGE_TYPE_HEALTH
			elseif sourceGUID == targetGUID and amount == "DEBUFF" and DEX_Get("DEX_ShowDeBuff") ==1 and DEX_Get("DEX_ShowDamageWoW") == 1 then
				dexSpell = spellName
			else
				return
			end 
			dexCrit = 0;
		else
			return
		end

		if  dexType ~= DEX_DAMAGE_TYPE_PET then
			DEX_AddText(dexText,dexSpell,dexType,dexCrit,true,false,destGUID,destName,suffixes,spellId,CombatTime,DEX_OverHeal,Nameplate)
		end

	end

	if  dexType == DEX_DAMAGE_TYPE_PET and tonumber(dexText) then
		DEX_AddText(dexText,dexSpell,dexType,dexCrit,false,false,destGUID,destName,suffixes,spellId,CombatTime,DEX_OverHeal,Nameplate)
	end
end

function DEX_GameUpdate(self)
	if DEX_Get("DEX_RandomCrit") == 1 and DEX_Get("DEX_BaseFrame") == 0 then
		AniRunTime = 0.5;
	elseif DEX_Get("DEX_BaseFrame") == 1 then
		AniRunTime = 0.6;
	else
		AniRunTime = 1
	end
	dex_bottom = 99999;
	dex_petbottom = 99999;
	if DEX_Get("DEX_UniteSpell") == 1 then
		if DataTmpHealth.StartTime > 0 and GetTime() - DataTmpHealth.StartTime >= AOEEnd then
			DEX_AddText("","",DEX_DAMAGE_TYPE_AOEHEALTH,0,true,false,"","","DAMAGE",0,0,0,nil)
		elseif not UnitAffectingCombat("player") and DEX_Get("DEX_NoCombatHeal") == 1 then
			if DataTmpHealth.StartTime == 0 then
				DataTmpHealth.StartTime = GetTime()
			end
		end
		if DataTmpSpell.StartTime > 0 and GetTime() - DataTmpSpell.StartTime >= AOEEnd then
			DEX_AddText("","",DEX_DAMAGE_TYPE_AOESPELL,0,true,false,"","","DAMAGE",0,0,0,nil)
		end
		if DataTmpDot.StartTime > 0 and GetTime() - DataTmpDot.StartTime >= AOEEnd then
			DEX_AddText("","",DEX_DAMAGE_TYPE_AOEDOT,0,true,false,"","","DAMAGE",0,0,0,nil)
		end
		if DataTmpShield.StartTime > 0 and GetTime() - DataTmpShield.StartTime >= AOEEnd then
			DEX_AddText("","",DEX_DAMAGE_TYPE_AOESHIELD,0,true,false,"","","DAMAGE",0,0,0,nil)
		end
	end
	if DEX_Get("DEX_ShowWithMess") == 0 then
		for key, value in pairs(dex_AniData) do
			if (value.Active == true) then
				DEX_doAni(value);
			end
		end
	else
		for key, value in pairs(dex_AniData) do
			if (value.Active == true) then
				DEX_doLog(value);
			end
		end
	end
end

function DEX_RefressBottom(ani)
	if ani.moveTyp == DEX_MOVTYP_NORMAL then
		if ani.posY < dex_bottom then dex_bottom = ani.posY;end
	end
	if ani.moveTyp == DEX_MOVTYP_PET then
		if ani.posY < dex_petbottom then dex_petbottom = ani.posY;end
	end

	if ani.moveTyp == DEX_MOVTYP_HEALTH then
		if ani.posY < dex_bottom then dex_bottom = ani.posY;end
	end
	if ani.moveTyp == DEX_MOVTYP_ATTACK then
		if ani.posY < dex_bottom then dex_bottom = ani.posY;end
	end

end

function DEX_doLog(ani)
	local Logthetime = GetTime() - ani.starttime;
	if Logthetime < DEX_Get("DEX_LOGTIME") and Logthetime >= 0 then
		ani.FObject:SetAlpha(1);
	else
		if Logthetime < DEX_Get("DEX_LOGTIME") + 3 then
			ani.FObject:SetAlpha(1 - (Logthetime - DEX_Get("DEX_LOGTIME")) / 3);
		else
			DEX_aniReset(ani);
		end
	end
end

function DEX_GetMovTypOtherPosY()
	local i
	local t = GetTime()
	for i = 1,5 do
		if DEX_MovTypOther_TimerSlot[i] == 0 or t - DEX_MovTypOther_TimerSlot[i] > 1 then
			DEX_MovTypOther_TimerSlot[i] = t
			return (i - 1) * (DEX_Get("DEX_FontSize") + 20) - 15
		end
	end
	DEX_MovTypOther_TimerSlot[1] = t
	return -20
end

function DEX_SetColor(colorHitType)
	local color = {1,1,1};
	local colorSe = {1,1,1};
	if colorHitType == -5 then
		color = {1,0,0};
		colorSe = {1,0,0};
	elseif colorHitType == -6 then
		color = {0,1,0};
		colorSe = {0,1,0};
	elseif colorHitType == DEX_DAMAGE_TYPE_BEATTACK or colorHitType == DEX_DAMAGE_TYPE_ENVTYPE then
		color = DEX_Get("DEX_ColorAttack");
		colorSe = DEX_Get("DEX_ColorAttackSe");
	elseif colorHitType == DEX_DAMAGE_TYPE_HIT then
		color = DEX_Get("DEX_ColorNormal");
		colorSe = DEX_Get("DEX_ColorNormalSe");
	elseif colorHitType == DEX_DAMAGE_TYPE_SPELL then
		color = DEX_Get("DEX_ColorSkill");
		colorSe = DEX_Get("DEX_ColorSkillSe");
	elseif colorHitType == DEX_DAMAGE_TYPE_PERIODIC then
		if DEX_Get("DEX_ShowDamagePeriodic") == 0 then return;end
		color = DEX_Get("DEX_ColorPeriodic");
		colorSe = DEX_Get("DEX_ColorPeriodicSe");
	elseif colorHitType == DEX_DAMAGE_TYPE_HEALTH then
		if DEX_Get("DEX_ShowDamageHealth") == 0 then return;end
		color = DEX_Get("DEX_ColorHealth");
		colorSe = DEX_Get("DEX_ColorHealthSe");
	elseif colorHitType == DEX_DAMAGE_TYPE_PET then
		if DEX_Get("DEX_ShowDamagePet") == 0 then return;end
		color = DEX_Get("DEX_ColorPet");
		colorSe = DEX_Get("DEX_ColorPetSe");
	elseif colorHitType == DEX_DAMAGE_TYPE_HONOR then
		color = DEX_Get("DEX_ColorSpec");
		colorSe = DEX_Get("DEX_ColorSpecSe");
	elseif colorHitType == DEX_DAMAGE_TYPE_MANA then
		color = DEX_Get("DEX_ColorMana");
		colorSe = DEX_Get("DEX_ColorManaSe");
	else
		color = DEX_Get("DEX_ColorSkill");
		colorSe = DEX_Get("DEX_ColorSkillSe");
	end
	return color,colorSe
end

function cubic_bezier(t, p0, p1, p2, p3)
    local u = 1 - t
    return u*u*u*p0 + 3*u*u*t*p1 + 3*u*t*t*p2 + t*t*t*p3
end
function GetPos(time1, radius)
	local progress = 0
    
	progress = math.min(time1 / AniRunTime, 1)
        
        -- 使用缓动函数计算当前角度（三次贝塞尔缓动）
	local angle = cubic_bezier(progress, 90, 180 * 0.25 -90,  180 * 0.75 - 90, -90)
        -- 坐标计算（Y轴取反适配屏幕坐标系）
        local rad = math.rad(angle)
        local x = radius * math.cos(rad)
       	local y = -radius * math.sin(rad)  -- Y轴取反
	return x, y
end

function DEX_doAni(ani)
	if DEX_Get("DEX_ShowWithMess") == 1 then
		return
	end
	local Showicon,Showiconcrit,Showname,Shownamecrit,Shownamemiss,Showcriticon = 0, 0, 0, 0, 0, 0
	local SetPos = "CENTER"
	local showcolor,showcolorSe = DEX_SetColor(ani.lastupdate)
	local setalpha = 0;
	local thetime = GetTime() - ani.starttime;
	if thetime < ani.TheTime and thetime > 0 then

		DEX_SetFontSize(ani,DEX_Get("DEX_FontSize"));
		if thetime < 0.1 then
			setalpha = thetime * 10;
		elseif thetime < 1 then
			setalpha = 1;
		else
			setalpha = 1 - (thetime - 1) * 2;
		end
		if DEX_Get("DEX_RandomCrit") == 1 and DEX_Get("DEX_BaseFrame") == 0 then
			ani.moveTyp = DEX_MOVTYP_NONE
			ani.critTyp = 1
			ani.zoom = 1.35;
		end
		if ani.moveTyp == DEX_MOVTYP_NORMAL then
			if DEX_Get("DEX_Circle") == 1 then
				ani.posX, ani.posY = GetPos(thetime, -300)
				ani.posY = ani.posY * -1
			else
				ani.posY = thetime * DEX_Get("DEX_Speed") * 2.5 + ani.baseY;
			end
			ani.posYbak = ani.posY;
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_AOE then
			ani.posY = thetime * DEX_Get("DEX_Speed") * 2.5 + ani.baseY;
			ani.posYbak = ani.posY;
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_OTHER then
			ani.posX = sin(thetime / 2.1 * 180) * 30 + 75;
		elseif ani.moveTyp == DEX_MOVTYP_ATTACK then
			ani.posY = thetime * DEX_Get("DEX_Speed") * 2.5 + ani.baseY + DEX_Get("DEX_BeAttackPosY");
			if DEX_Get("DEX_ShowDamageType") == 1 and DEX_Get("DEX_Circle") == 0 then
				SetPos = "LEFT"
				ani.posX = (acos((ani.TheTime - thetime)/2) / 30) * DEX_Get("DEX_Speed")+ DEX_Get("DEX_BeAttackPosX");
			else
				if (DEX_Get("DEX_BeAttackPosX") ~= 0 and DEX_Get("DEX_BeAttackPosY") == 0) or DEX_Get("DEX_Circle") == 1 then
					ani.posX, ani.posY = GetPos(thetime, DEX_Get("DEX_BeAttackPosX"))
					if DEX_Get("DEX_BeAttackPosX") < 0 then
						ani.posY = ani.posY * -1
					end
				else
					if DEX_Get("DEX_BeAttackPosX") > 0 then
						ani.posX = DEX_Get("DEX_Speed") * cos(thetime / 2 * DEX_Get("DEX_Speed")) + DEX_Get("DEX_BeAttackPosX");
					else
						ani.posX = DEX_Get("DEX_BeAttackPosX") - DEX_Get("DEX_Speed") * cos(thetime / 2 * DEX_Get("DEX_Speed"));
					end
				end
			end
			ani.posYbak = ani.posY;
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_HEALTH then
			ani.posY = thetime * DEX_Get("DEX_Speed") * 2.5 + ani.baseY + DEX_Get("DEX_HealthPosY");
			if DEX_Get("DEX_ShowHealthType") == 1 and DEX_Get("DEX_Circle") == 0 then
				SetPos = "RIGHT"
				ani.posX = DEX_Get("DEX_HealthPosX") - (acos((ani.TheTime - thetime)/2) / 35) * DEX_Get("DEX_Speed");
			else
				if (DEX_Get("DEX_HealthPosX") ~= 0 and DEX_Get("DEX_HealthPosY") == 0) or DEX_Get("DEX_Circle") ==1 then
					ani.posX, ani.posY = GetPos(thetime,DEX_Get("DEX_HealthPosX"))
					if DEX_Get("DEX_HealthPosX") < 0 then
						ani.posY = ani.posY * -1
					end
				else
					if DEX_Get("DEX_HealthPosX") > 0 then
						ani.posX = DEX_Get("DEX_Speed") * cos(thetime / 2 * DEX_Get("DEX_Speed")) + DEX_Get("DEX_HealthPosX");
					else
						ani.posX = DEX_Get("DEX_HealthPosX") - DEX_Get("DEX_Speed") * cos(thetime / 2 * DEX_Get("DEX_Speed"));
					end
				end
			end
			ani.posYbak = ani.posY;
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_PET then
			if DEX_Get("DEX_Circle") == 1 then
				ani.posX, ani.posY = GetPos(thetime, -300)
				ani.posY = ani.posY * -1
			else
				ani.posY = thetime * DEX_Get("DEX_Speed") * 2.5 + ani.baseY + DEX_Get("DEX_PetPosY");
			end
			ani.posYbak = ani.posY;
			ani.posX = DEX_Get("DEX_PetPosX");
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_NONE then
			if ani.HitType == "Begin" then
				ani.posY = DEX_TEXTSIZE * 5;
				showcolor,showcolorSe = DEX_SetColor(-5)
			elseif ani.HitType == "End" then
				ani.posY = DEX_TEXTSIZE * 4;
				showcolor,showcolorSe = DEX_SetColor(-6)
			end
		end

		if ani.crit == 1 then
			local baseSize = DEX_TEXTSIZE + 4 + ani.critId * 2;
			if DEX_Get("DEX_AdjustTime") == 1 and ani.moveTyp ~= DEX_MOVTYP_NONE then
				if ani.critTyp == 0 then
					if thetime < 0.1 then
						ani.height = DEX_TEXTSIZE * ani.zoom;
					elseif thetime < 0.60 then
						ani.height = (1 - (thetime - 0.1) / 0.5) * DEX_TEXTSIZE * ani.zoom + DEX_TEXTSIZE;
					elseif ani.height ~= baseSize then
						ani.height = baseSize;
						DEX_SetFontSize(ani,ani.height);
					end
				elseif ani.critTyp == 1 then
					if thetime < 0.2 then
						ani.height = baseSize * thetime / 0.2 + baseSize * ani.zoom;
					elseif thetime < 0.7 then
						ani.height = baseSize * ani.zoom * (1 - (thetime - 0.2) / 0.5) + baseSize;
					elseif ani.height ~= baseSize then
						ani.height = baseSize;
						DEX_SetFontSize(ani,ani.height);
					end
				end
			else
				if ani.critTyp == 0 then
					if thetime < 0.05 then
						ani.height = DEX_TEXTSIZE * ani.zoom;
					elseif thetime < 0.30 then
						ani.height = (1 - (thetime - 0.05) / 0.25) * DEX_TEXTSIZE * ani.zoom + DEX_TEXTSIZE;
					elseif ani.height ~= baseSize then
						ani.height = baseSize;
						DEX_SetFontSize(ani,ani.height);
					end
				elseif ani.critTyp == 1 then
					if thetime < 0.1 then
						ani.height = baseSize * thetime / 0.1 + baseSize * ani.zoom;
					elseif thetime < 0.35 then
						ani.height = baseSize * ani.zoom * (1 - (thetime - 0.1) / 0.25) + baseSize;
					elseif ani.height ~= baseSize then
						ani.height = baseSize;
						DEX_SetFontSize(ani,ani.height);
					end
				end
			end
			if thetime < 0.2 then
				setalpha = thetime * 2.5 + 0.5
			end
		end
		if setalpha < 0 then
			setalpha = 0
		end
		if setalpha > 1 then
			setalpha = 1
		end

		if ani.lastupdate == DEX_DAMAGE_TYPE_BEATTACK or ani.lastupdate == DEX_DAMAGE_TYPE_ENVTYPE then
			Showicon = DEX_Get("DEX_ShowDamageSpellIcon");
			if Showicon == 1 then
				Showiconcrit = DEX_Get("DEX_ShowDamageSpellIconOnCrit");
			else
				Showiconcrit = 0
			end
			Showname = DEX_Get("DEX_ShowDamageSpellName");
			if Showname == 1 then
				Shownamecrit = DEX_Get("DEX_ShowDamageNameOnCrit");
				Showcriticon = DEX_Get("DEX_ShowCritIcon");
			else
				Shownamecrit = 0
				Showcriticon = 0
			end
			Shownamemiss = 0
		elseif ani.lastupdate == DEX_DAMAGE_TYPE_HEALTH then
			Showicon = DEX_Get("DEX_ShowHealthSpellIcon");
			if Showicon == 1 then
				Showiconcrit = DEX_Get("DEX_ShowHealthSpellIconOnCrit");
			else
				Showiconcrit = 0
			end
			Showname = DEX_Get("DEX_ShowHealthSpellName");
			if Showname == 1 then
				Shownamecrit = DEX_Get("DEX_ShowHealthNameOnCrit");
				Showcriticon = DEX_Get("DEX_ShowHealthCritIcon");
			else
				Shownamecrit = 0
				Showcriticon = 0
			end
			Shownamemiss = 0
		elseif ani.lastupdate == DEX_DAMAGE_TYPE_PET then
			Showicon = 0
			Showiconcrit = 0
			Showname = 0
			Shownamecrit = 0
			Shownamemiss = 0
			Showcriticon = 0
		else
			Showicon = DEX_Get("DEX_ShowSpellIcon");
			if Showicon == 1 then
				Showiconcrit = DEX_Get("DEX_ShowSpellIconOnCrit");
			else
				Showiconcrit = 0
			end
			Showname = DEX_Get("DEX_ShowSpellName");
			if Showname == 1 then
				Shownamecrit = DEX_Get("DEX_ShowNameOnCrit");
				Shownamemiss = DEX_Get("DEX_ShowNameOnMiss");
				Showcriticon = DEX_Get("DEX_ShowDamageIconOnCrit");
			else
				Shownamecrit = 0
				Shownamemiss = 0
				Showcriticon = 0
			end
		end
		ani.FObject:ClearAllPoints()
		if DEX_Get("DEX_BaseFrame") == 1 and ani.Frame ~= nil then
			ani.FObject:SetPoint(SetPos, ani.Frame, "TOP", ani.posX, ani.posY);
		else
			ani.FObject:SetPoint(SetPos, "UIParent", "CENTER", ani.posX + DEX_Get("DEX_PosX"), ani.posY + DEX_Get("DEX_PosY"));
		end
		ani.FObject:SetTextHeight(ani.height);
		ani.FObject:SetTextColor(showcolor[1], showcolor[2], showcolor[3]);
		if ani.setalpha == 1 then
			setalpha = 0
		end
		ani.FObject:SetAlpha(setalpha);
	ani.FObject:SetText(DEX_BuildText(ani.delay,ani.destbak,ani.crit,ani.HitType,ani.lastupdate,showcolor,showcolorSe,Showicon,Showiconcrit,Showname,Shownamecrit,Shownamemiss,Showcriticon,ani.Extra,ani.spellbak))
	else
		if thetime >= ani.TheTime then DEX_aniClear(ani);end
	end
end

function DEX_aniClear(ani)
	if ani.crit == 1 then
		if ani.critId < DEX_critFlag then DEX_critFlag = ani.critId;end
	end
	DEX_aniReset(ani);
end

function DEX_BuildText(damage,spell,IsCrit,HitType,IsdexType,BTcolor,BTcolorSe,showicon,showiconcrit,showname,shownamecrit,shownamemiss,showcriticon,overHealth,IsBlocked)
	if HitType == "End" or HitType == "Begin" then
		return damage;
	end
	local overFlag = false

	if DEX_Get("DEX_NumberFormat") == 1 and tonumber(damage) then
			damage = amount_format(damage)
	else
		if DEX_Get("DEX_NumberFormat") == 0 and tonumber(damage) then
			damage = number_format(damage,",")
		end
	end
	if IsBlocked ~= nil then
		damage = damage.." "..IsBlocked
		overFlag = false
	else
		if DEX_Get("DEX_NumberFormat") == 1 and tonumber(overHealth) > 0 and tonumber(overHealth) then
			if tonumber(overHealth) > 0 then
				overFlag = true
			end
			overHealth = amount_format(overHealth)
		else
			if DEX_Get("DEX_NumberFormat") == 0 and tonumber(overHealth) then
				if tonumber(overHealth) > 0 then
					overFlag = true
				end
				overHealth = number_format(overHealth,",")
			end
		end
	end
	damage = trim(damage);
	if overFlag then
		overHealth = trim(overHealth);
		damage = string.format("%s%s%s",damage, "↑", overHealth);
	end
	if IsdexType == DEX_DAMAGE_TYPE_ENVTYPE then
		damage = string.format("%s%s", damage, spell)
		return damage
	end
	local SpellName = nil
	if select(1,GetSpellInfo(spell)) ~= nil then 
		SpellName = select(1,GetSpellInfo(spell))
	else
		if spell ~= nil then
			SpellName = spell
		else
			SpellName = " "
		end
	end
	if damage == "" and showname ~= 1 then 
		if SpellName then
			damage = SpellName
		else
			damage = " "
		end
	end
	if HitType == "AURA_APPLIED" and showname ~=1 then
		showicon = 1
		showiconcrit = 0
	end
	if showname ~= 1 and showicon ~= 1 then 
		if HitType == "INTERRUPT" then
			if DEX_Get("DEX_ShowInterruptCrit") == 1 then
				if DEX_Get("DEX_ColorMode") == 1 then
					return string.format("%s%s", damage, SpellName)
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage,BTcolor,BTcolorSe)..SpellName
				else
					return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..SpellName.."|r"
				end	
			else
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage,BTcolor,BTcolorSe)
				else
					return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3]).."|r"
				end	
			end
		end
	end
	if showicon == 1 then
		if showiconcrit == 1 and IsCrit ~=1 then
			return damage
		end
		local icons = ""
		local iconsize = DEX_TEXTSIZE/(DEX_Get("DEX_IconSize")/5);
		if select(3,GetSpellInfo(spell)) ~= nil then 
			icons ="|T"..select(3,GetSpellInfo(spell))..":"..(iconsize / 2.5).."|t";
		else
			if DEX_Get("DEX_ColorMode") == 1 then
				if showname == 1 then 
					if shownamecrit == 1 then
						if IsCrit == 1 then
							return string.format("%s%s", damage, SpellName)
						else
							return damage
						end
					elseif shownamemiss == 1 then
						if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
							return string.format("%s%s", damage, SpellName)
						else
							return damage
						end
					else
						return string.format("%s%s", damage, SpellName)
					end
				else
					return damage
				end
			elseif DEX_Get("DEX_ColorMode") == 3 then
				if showname == 1 then 
					if shownamecrit == 1 then
						if IsCrit == 1 then
							return DEX_TranTxt(damage,BTcolor,BTcolorSe)..SpellName
						else
							return DEX_TranTxt(damage,BTcolor,BTcolorSe)
						end
					elseif shownamemiss == 1 then
						if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
							return DEX_TranTxt(damage,BTcolor,BTcolorSe)..SpellName
						else
							return DEX_TranTxt(damage,BTcolor,BTcolorSe)
						end
					else
						return DEX_TranTxt(damage,BTcolor,BTcolorSe)..SpellName
					end
				else
					return DEX_TranTxt(damage,BTcolor,BTcolorSe)
				end
			else
				if showname == 1 then 
					if shownamecrit == 1 then
						if IsCrit == 1 then
							return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..SpellName.."|r"
						else
							return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3]).."|r"
						end
					elseif shownamemiss == 1 then
						if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
							return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..SpellName.."|r"
						else
							return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3]).."|r"
						end
					else
						return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..SpellName.."|r"
					end
				else
					return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3]).."|r"
				end
			end	
		end
		if DEX_Get("DEX_ColorMode") == 1 then
			if HitType == "INTERRUPT" then
				if DEX_Get("DEX_ShowInterruptCrit") == 1 then
					return damage.." "..icons..SpellName
				end
			end
			if showname == 1 then 
				if shownamecrit == 1 then
					if IsCrit == 1 then
						if showcriticon == 1 then
							return damage.." "..icons
						else
							return damage.." "..icons..SpellName
						end
					else
						return damage.." "..icons
					end
				elseif shownamemiss == 1 then
					if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
						return damage.." "..icons..SpellName
					else
						return damage.." "..icons
					end
				else
					return damage.." "..icons..SpellName
				end
			else
				if HitType == "AURA_APPLIED" then
					return icons
				else
					return damage.." "..icons
				end
			end
		elseif DEX_Get("DEX_ColorMode") == 3 then
			if HitType == "INTERRUPT" then
				if DEX_Get("DEX_ShowInterruptCrit") == 1 then
					return DEX_TranTxt(damage.." ",BTcolor,BTcolorSe)..icons..SpellName
				end
			end
			if showname == 1 then 
				if shownamecrit == 1 then
					if IsCrit == 1 then
						if showcriticon ==1 then
							return DEX_TranTxt(damage.." ",BTcolor,BTcolorSe)..icons
						else
							return DEX_TranTxt(damage.." ",BTcolor,BTcolorSe)..icons..SpellName
						end
					else
						return DEX_TranTxt(damage.." ",BTcolor,BTcolorSe)..icons
					end
				elseif shownamemiss == 1 then
					if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
						return DEX_TranTxt(damage.." ",BTcolor,BTcolorSe)..icons..SpellName
					else
						return DEX_TranTxt(damage.." ",BTcolor,BTcolorSe)..icons
					end
				else
					return DEX_TranTxt(damage.." ",BTcolor,BTcolorSe)..icons..SpellName
				end
			else
				if HitType == "AURA_APPLIED" then
					return icons
				else
					return DEX_TranTxt(damage.." ",BTcolor,BTcolorSe)..icons
				end
			end
		else
			if HitType == "INTERRUPT" then
				if DEX_Get("DEX_ShowInterruptCrit") == 1 then
					return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons..SpellName.."|r"
				end
			end
			if showname == 1 then 
				if shownamecrit == 1 then
					if IsCrit == 1 then
						if showcriticon ==1 then
							return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons.."|r"
						else
							return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons..SpellName.."|r"
						end
					else
						return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons.."|r"
					end
				elseif shownamemiss == 1 then
					if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
						return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons..SpellName.."|r"
					else
						return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons.."|r"
					end
				else
					return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons..SpellName.."|r"
				end
			else
				if HitType == "AURA_APPLIED" then
					return DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons.."|r"
				else
					return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons.."|r"
				end
			end
		end
	end
	if showname ~= 1 then 
		if DEX_Get("DEX_ColorMode") == 1 then
			if HitType == "INTERRUPT" then
				if DEX_Get("DEX_ShowInterruptCrit") == 1 then
					return damage..SpellName
				end
			end
			return damage
		elseif DEX_Get("DEX_ColorMode") == 3 then
			if HitType == "INTERRUPT" then
				if DEX_Get("DEX_ShowInterruptCrit") == 1 then
					return DEX_TranTxt(damage,BTcolor,BTcolorSe)..SpellName
				end
			end
			return DEX_TranTxt(damage,BTcolor,BTcolorSe)
		else
			if HitType == "INTERRUPT" then
				if DEX_Get("DEX_ShowInterruptCrit") == 1 then
					return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..SpellName.."|r"
				end
			elseif HitType == "AURA_APPLIED" then
					return " "
			end
			return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3]).."|r"
		end	
	else
		local icons = ""
		local iconsize = DEX_TEXTSIZE/(DEX_Get("DEX_IconSize")/5);
		if select(3,GetSpellInfo(spell)) ~= nil then 
			icons ="|T"..select(3,GetSpellInfo(spell))..":"..(iconsize / 2.5).."|t";
		end
		if HitType == "INTERRUPT" then
			if DEX_Get("DEX_ShowInterruptCrit") == 1 then
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage.." "..SpellName
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage.." "..SpellName,BTcolor,BTcolorSe)
				else
					return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..SpellName.."|r"
				end	
			end
		elseif HitType == "AURA_APPLIED" then
			return icons
		end
		if shownamecrit == 1 then
			if IsCrit == 1 then
				if showcriticon == 1 then
					if DEX_Get("DEX_ColorMode") == 1 then
						return damage.." "..icons
					elseif DEX_Get("DEX_ColorMode") == 3 then
						return DEX_TranTxt(damage.." ",BTcolor,BTcolorSe)..icons
					else
						return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons.."|r"
					end	
				else
					if DEX_Get("DEX_ColorMode") == 1 then
						return damage.." "..SpellName
					elseif DEX_Get("DEX_ColorMode") == 3 then
						return DEX_TranTxt(damage.." "..SpellName,BTcolor,BTcolorSe)
					else
						return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..SpellName.."|r"
					end	
				end
			else
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage,BTcolor,BTcolorSe)
				else
					return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3]).."|r"
				end	
			end
		elseif shownamemiss == 1 then
			if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage.." "..SpellName
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage.." "..SpellName,BTcolor,BTcolorSe)
				else
					return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..SpellName.."|r"
				end	
			else
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage,BTcolor,BTcolorSe)
				else
					return damage..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3]).."|r"
				end
			end
		else
			if showcriticon == 1 and IsCrit == 1 then
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage.." "..icons
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage.." ",BTcolor,BTcolorSe)..icons
				else
					return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..icons.."|r"
				end	
			else
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage.." "..SpellName
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage.." "..SpellName,BTcolor,BTcolorSe)
				else
					return damage.." "..DEX_ColorFlip(BTcolorSe[1],BTcolorSe[2],BTcolorSe[3])..SpellName.."|r"
				end	
			end
		end
	end
end

local function DiffSpell(spell1,spell2)
	local name1, name2 = nil
	if select(1,GetSpellInfo(spell1))~=nil then 
		name1 = select(1,GetSpellInfo(spell1))
		if select(1,GetSpellInfo(spell2))~=nil then 
			name2 = select(1,GetSpellInfo(spell2))
			if name1 == name2 then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function DEX_AddText(damage,spell,damagetype,crit,iscurTarget,coerciveShowSpell,TargetGUID,TargetName,AOEHitType,SpellID,combattime,OverKill,BascFrame,...)
	if ((AOEHitType == "DAMAGE" and (damagetype == DEX_DAMAGE_TYPE_SPELL or damagetype == DEX_DAMAGE_TYPE_PERIODIC or damagetype == DEX_DAMAGE_TYPE_AOESPELL or damagetype == DEX_DAMAGE_TYPE_AOEDOT or damagetype == DEX_DAMAGE_TYPE_AOESHIELD  or damagetype == DEX_DAMAGE_TYPE_AOEHEALTH))  or (AOEHitType == "SHIELD" and damagetype == DEX_DAMAGE_TYPE_SPELL)) and SpellID ~= nil and DEX_Get("DEX_UniteSpell") == 1 and (DEX_Get("DEX_ShowBlockNumber") == 0 or (DEX_Get("DEX_ShowBlockNumber") == 1 and Blocked == nil)) then

		if damagetype == DEX_DAMAGE_TYPE_AOESPELL then
			if DataTmpSpell.spellid ~= 0 then
				DataTmpSpell.StartTime = GetTime()
				DEX_AddTextDo(DataTmpSpell.damage,DataTmpSpell.spell,DataTmpSpell.damagetype,DataTmpSpell.crit,DataTmpSpell.iscurTarget,DataTmpSpell.coerciveShowSpell,DataTmpSpell.TargetGUID,DataTmpSpell.TargetName,DataTmpSpell.HitType,DataTmpSpell.spellid,DataTmpSpell.StartTime,DataTmpSpell.OverDamage,DataTmpSpell.Frame)
				DataTmpSpell.damage = 0
				DataTmpSpell.spell = ""
				DataTmpSpell.damagetype = 0
				DataTmpSpell.crit = 0
				DataTmpSpell.iscurTarget = false
				DataTmpSpell.coerciveShowSpell = false
				DataTmpSpell.TargetGUID = ""
				DataTmpSpell.TargetName = ""
				DataTmpSpell.HitType = ""
				DataTmpSpell.spellid = 0
				DataTmpSpell.StartTime = 0
				DataTmpSpell.OverDamage = 0
				DataTmpSpell.Frame = nil
			end
			return
		elseif damagetype == DEX_DAMAGE_TYPE_AOEDOT then
			if DataTmpDot.spellid ~= 0 then
				DataTmpDot.StartTime = GetTime()
				DEX_AddTextDo(DataTmpDot.damage,DataTmpDot.spell,DataTmpDot.damagetype,DataTmpDot.crit,DataTmpDot.iscurTarget,DataTmpDot.coerciveShowSpell,DataTmpDot.TargetGUID,DataTmpDot.TargetName,DataTmpDot.HitType,DataTmpDot.spellid,DataTmpDot.StartTime,DataTmpDot.OverDamage,DataTmpDot.Frame)
				DataTmpDot.damage = 0
				DataTmpDot.spell = ""
				DataTmpDot.damagetype = 0
				DataTmpDot.crit = 0
				DataTmpDot.iscurTarget = false
				DataTmpDot.coerciveShowSpell = false
				DataTmpDot.TargetGUID = ""
				DataTmpDot.TargetName = ""
				DataTmpDot.HitType = ""
				DataTmpDot.spellid = 0
				DataTmpDot.StartTime = 0
				DataTmpDot.OverDamage = 0
				DataTmpDot.Frame = nil
			end
			return
		elseif damagetype == DEX_DAMAGE_TYPE_AOEShield then
			if DataTmpShield.spellid ~= 0 then
				DataTmpShield.StartTime = GetTime()
				DEX_AddTextDo(DataTmpShield.damage,DataTmpShield.spell,DataTmpShield.damagetype,DataTmpShield.crit,DataTmpShield.iscurTarget,DataTmpShield.coerciveShowSpell,DataTmpShield.TargetGUID,DataTmpShield.TargetName,DataTmpShield.HitType,DataTmpShield.spellid,DataTmpShield.StartTime,DataTmpShield.OverDamage,DataTmpShield.Frame)
				DataTmpShield.damage = 0
				DataTmpShield.spell = ""
				DataTmpShield.damagetype = 0
				DataTmpShield.crit = 0
				DataTmpShield.iscurTarget = false
				DataTmpShield.coerciveShowSpell = false
				DataTmpShield.TargetGUID = ""
				DataTmpShield.TargetName = ""
				DataTmpShield.HitType = ""
				DataTmpShield.spellid = 0
				DataTmpShield.StartTime = 0
				DataTmpShield.OverDamage = 0
				DataTmpShield.Frame = nil
			end
			return
		elseif damagetype == DEX_DAMAGE_TYPE_AOEHEALTH then
			if DataTmpHealth.spellid ~= 0 then
				DataTmpHealth.StartTime = GetTime()
				DEX_AddTextDo(DataTmpHealth.damage,DataTmpHealth.spell,DataTmpHealth.damagetype,DataTmpHealth.crit,DataTmpHealth.iscurTarget,DataTmpHealth.coerciveShowSpell,DataTmpHealth.TargetGUID,DataTmpHealth.TargetName,DataTmpHealth.HitType,DataTmpHealth.spellid,DataTmpHealth.StartTime,DataTmpHealth.OverDamage,DataTmpHealth.Frame)
				DataTmpHealth.damage = 0
				DataTmpHealth.spell = ""
				DataTmpHealth.damagetype = 0
				DataTmpHealth.crit = 0
				DataTmpHealth.iscurTarget = false
				DataTmpHealth.coerciveShowSpell = false
				DataTmpHealth.TargetGUID = ""
				DataTmpHealth.TargetName = ""
				DataTmpHealth.HitType = ""
				DataTmpHealth.spellid = 0
				DataTmpHealth.StartTime = 0
				DataTmpHealth.OverDamage = 0
				DataTmpHealth.Frame = nil
			end
			return
		end
		if damagetype == DEX_DAMAGE_TYPE_SPELL then
			if DataTmpSpell.spellid == 0 then
				DataTmpSpell.damage = tonumber(damage)
				DataTmpSpell.spell = spell
				DataTmpSpell.damagetype =damagetype
				if crit == 1 then
					DataTmpSpell.crit = crit
				end
				if tonumber(OverKill) and tonumber(OverKill) > 0  then
					DataTmpSpell.OverDamage = tonumber(OverKill)
				end
				DataTmpSpell.iscurTarget = iscurTarget
				DataTmpSpell.coerciveShowSpell = coerciveShowSpell
				DataTmpSpell.TargetGUID = TargetGUID
				DataTmpSpell.TargetName = TargetName
				DataTmpSpell.HitType = AOEHitType
				DataTmpSpell.spellid = SpellID
				DataTmpSpell.StartTime = combattime
				DataTmpSpell.Frame = BascFrame
			else
				if DiffSpell(DataTmpSpell.spellid,SpellID) then
					DataTmpSpell.damage = DataTmpSpell.damage + tonumber(damage)
					if crit == 1 then
						DataTmpSpell.crit = crit
					end
					if tonumber(OverKill) and tonumber(OverKill) > 0  then
						DataTmpSpell.OverDamage = DataTmpSpell.OverDamage + tonumber(OverKill)
					end
					DataTmpSpell.Frame = BascFrame
					return
				else
					DataTmpSpell.StartTime = GetTime()
					DEX_AddTextDo(DataTmpSpell.damage,DataTmpSpell.spell,DataTmpSpell.damagetype,DataTmpSpell.crit,DataTmpSpell.iscurTarget,DataTmpSpell.coerciveShowSpell,DataTmpSpell.TargetGUID,DataTmpSpell.TargetName,DataTmpSpell.HitType,DataTmpSpell.spellid,DataTmpSpell.StartTime,DataTmpSpell.OverDamage,DataTmpSpell.Frame)
					DataTmpSpell.damage = tonumber(damage)
					DataTmpSpell.spell = spell
					DataTmpSpell.damagetype = damagetype
					DataTmpSpell.crit = 0
					if crit == 1 then
						DataTmpSpell.crit = crit
					end
					DataTmpSpell.iscurTarget = iscurTarget
					DataTmpSpell.coerciveShowSpell = coerciveShowSpell
					DataTmpSpell.TargetGUID = TargetGUID
					DataTmpSpell.TargetName = TargetName
					DataTmpSpell.HitType = AOEHitType
					DataTmpSpell.spellid = SpellID
					DataTmpSpell.StartTime = combattime
					if tonumber(OverKill) and tonumber(OverKill) > 0  then
						DataTmpSpell.OverDamage = tonumber(OverKill)
					end
					DataTmpSpell.Frame = BascFrame
				end
			end
		elseif damagetype == DEX_DAMAGE_TYPE_PERIODIC then
			if DataTmpDot.spellid == 0 then
				DataTmpDot.damage = tonumber(damage)
				DataTmpDot.spell = spell
				DataTmpDot.damagetype = damagetype
				if crit == 1 then
					DataTmpDot.crit = crit
				end
				DataTmpDot.iscurTarget = iscurTarget
				DataTmpDot.coerciveShowSpell = coerciveShowSpell
				DataTmpDot.TargetGUID = TargetGUID
				DataTmpDot.TargetName = TargetName
				DataTmpDot.HitType = AOEHitType
				DataTmpDot.spellid = SpellID
				DataTmpDot.StartTime = combattime
				if tonumber(OverKill) and tonumber(OverKill) > 0  then
					DataTmpDot.OverDamage = tonumber(OverKill)
				end
				DataTmpDot.Frame = BascFrame
			else
				if DiffSpell(DataTmpDot.spellid,SpellID) then
					DataTmpDot.damage = DataTmpDot.damage + tonumber(damage)
					if crit == 1 then
						DataTmpDot.crit = crit
					end
					if tonumber(OverKill) and tonumber(OverKill) > 0  then
						DataTmpDot.OverDamage = DataTmpDot.OverDamage + tonumber(OverKill)
					end
					DataTmpDot.Frame = BascFrame
					return
				else
					DataTmpDot.StartTime = GetTime()
					DEX_AddTextDo(DataTmpDot.damage,DataTmpDot.spell,DataTmpDot.damagetype,DataTmpDot.crit,DataTmpDot.iscurTarget,DataTmpDot.coerciveShowSpell,DataTmpDot.TargetGUID,DataTmpDot.TargetName,DataTmpDot.HitType,DataTmpDot.spellid,DataTmpDot.StartTime,DataTmpDot.OverDamage,DataTmpDot.Frame)
					DataTmpDot.damage = tonumber(damage)
					DataTmpDot.spell = spell
					DataTmpDot.damagetype = damagetype
					DataTmpDot.crit = 0
					if crit == 1 then
						DataTmpDot.crit = crit
					end
					DataTmpDot.iscurTarget = iscurTarget
					DataTmpDot.coerciveShowSpell = coerciveShowSpell
					DataTmpDot.TargetGUID = TargetGUID
					DataTmpDot.TargetName = TargetName
					DataTmpDot.HitType = AOEHitType
					DataTmpDot.spellid = SpellID
					DataTmpDot.StartTime = combattime
					if tonumber(OverKill) and tonumber(OverKill) > 0  then
						DataTmpDot.OverDamage = tonumber(OverKill)
					end
					DataTmpDot.Frame = BascFrame
				end
			end
		elseif damagetype == DEX_DAMAGE_TYPE_HEALTH then
			if DataTmpHealth.spellid == 0 then
				DataTmpHealth.damage = tonumber(damage)
				DataTmpHealth.spell = spell
				DataTmpHealth.damagetype =damagetype
				if crit == 1 then
					DataTmpHealth.crit = crit
				end
				DataTmpHealth.iscurTarget = iscurTarget
				DataTmpHealth.coerciveShowSpell = coerciveShowSpell
				DataTmpHealth.TargetGUID = TargetGUID
				DataTmpHealth.TargetName = TargetName
				DataTmpHealth.HitType = AOEHitType
				DataTmpHealth.spellid = SpellID
				DataTmpHealth.StartTime = combattime
				if tonumber(OverKill) and tonumber(OverKill) > 0  then
					DataTmpHealth.OverDamage = tonumber(OverKill)
				end
				DataTmpHealth.Frame = BascFrame
			else
				if DiffSpell(DataTmpHealth.spellid,SpellID) then
					DataTmpHealth.damage = DataTmpHealth.damage + tonumber(damage)
					if crit == 1 then
						DataTmpHealth.crit = crit
					end
					if tonumber(OverKill) and tonumber(OverKill) > 0  then
						DataTmpHealth.OverDamage = DataTmpHealth.OverDamage + tonumber(OverKill)
					end
					DataTmpHealth.Frame = BascFrame
					return
				else
					DataTmpHealth.StartTime = GetTime()
					DEX_AddTextDo(DataTmpHealth.damage,DataTmpHealth.spell,DataTmpHealth.damagetype,DataTmpHealth.crit,DataTmpHealth.iscurTarget,DataTmpHealth.coerciveShowSpell,DataTmpHealth.TargetGUID,DataTmpHealth.TargetName,DataTmpHealth.HitType,DataTmpHealth.spellid,DataTmpHealth.StartTime,DataTmpHealth.OverDamage,DataTmpHealth.Frame)
					DataTmpHealth.damage = tonumber(damage)
					DataTmpHealth.spell = spell
					DataTmpHealth.damagetype = damagetype
					DataTmpHealth.crit = 0
					if crit == 1 then
						DataTmpHealth.crit = crit
					end
					DataTmpHealth.iscurTarget = iscurTarget
					DataTmpHealth.coerciveShowSpell = coerciveShowSpell
					DataTmpHealth.TargetGUID = TargetGUID
					DataTmpHealth.TargetName = TargetName
					DataTmpHealth.HitType = AOEHitType
					DataTmpHealth.spellid = SpellID
					DataTmpHealth.StartTime = combattime
					if tonumber(OverKill) and tonumber(OverKill) > 0  then
						DataTmpHealth.OverDamage = tonumber(OverKill)
					end
					DataTmpHealth.Frame = BascFrame
				end
			end
		else
			if DataTmpShield.spellid == 0 then
				DataTmpShield.damage = tonumber(damage)
				DataTmpShield.spell = spell
				DataTmpShield.damagetype =damagetype
				if crit == 1 then
					DataTmpShield.crit = crit
				end
				DataTmpShield.iscurTarget = iscurTarget
				DataTmpShield.coerciveShowSpell = coerciveShowSpell
				DataTmpShield.TargetGUID = TargetGUID
				DataTmpShield.TargetName = TargetName
				DataTmpShield.HitType = AOEHitType
				DataTmpShield.spellid = SpellID
				DataTmpShield.StartTime = combattime
				if tonumber(OverKill) and tonumber(OverKill) > 0  then
					DataTmpShield.OverDamage = tonumber(OverKill)
				end
				DataTmpShield.Frame = BascFrame
			else
				if DiffSpell(DataTmpShield.spellid,SpellID) then
					DataTmpShield.damage = DataTmpShield.damage + tonumber(damage)
					if crit == 1 then
						DataTmpShield.crit = crit
					end
					if tonumber(OverKill) and tonumber(OverKill) > 0  then
						DataTmpShield.OverDamage = DataTmpShield.OverDamage + tonumber(OverKill)
					end
					DataTmpShield.Frame = BascFrame
					return
				else
					DataTmpShield.StartTime = GetTime()
					DEX_AddTextDo(DataTmpShield.damage,DataTmpShield.spell,DataTmpShield.damagetype,DataTmpShield.crit,DataTmpShield.iscurTarget,DataTmpShield.coerciveShowSpell,DataTmpShield.TargetGUID,DataTmpShield.TargetName,DataTmpShield.HitType,DataTmpShield.spellid,DataTmpShield.StartTime,DataTmpShield.OverDamage,DataTmpShield.Frame)
					DataTmpShield.damage = tonumber(damage)
					DataTmpShield.spell = spell
					DataTmpShield.damagetype = damagetype
					DataTmpShield.crit = 0
					if crit == 1 then
						DataTmpShield.crit = crit
					end
					DataTmpShield.iscurTarget = iscurTarget
					DataTmpShield.coerciveShowSpell = coerciveShowSpell
					DataTmpShield.TargetGUID = TargetGUID
					DataTmpShield.TargetName = TargetName
					DataTmpShield.HitType = AOEHitType
					DataTmpShield.spellid = SpellID
					DataTmpShield.StartTime = combattime
					if tonumber(OverKill) and tonumber(OverKill) > 0  then
						DataTmpShield.OverDamage = tonumber(OverKill)
					end
					DataTmpShield.Frame = BascFrame
				end
			end
		end
	else
		DEX_AddTextDo(damage,spell,damagetype,crit,iscurTarget,coerciveShowSpell,TargetGUID,TargetName,AOEHitType,SpellID,combattime,OverKill,BascFrame)
	end
end

function TimeCheck(time1,time2,movetype)
	if time1 == 0 or DEX_Get("DEX_ShowWithMess") == 1 or DEX_Get("DEX_RandomCrit") == 1 or DEX_Get("DEX_AdjustTime") == 0 then
		return time2
	end
	local time3 = 0
	if (time2 - time1) < (DEX_TEXTSIZE + 10)/(2.5 * DEX_Get("DEX_Speed")) then
		time3 = (DEX_TEXTSIZE + 10)/(2.5 * DEX_Get("DEX_Speed")) - (time2 - time1);
	end
	if time3 > 0  then
		if movetype == DEX_MOVTYP_ATTACK then
			for key, value in pairs(dex_AniData) do
				if value.Active and value.starttime>0 and value.moveTyp == DEX_MOVTYP_ATTACK then
					dex_AniData[key].starttime = value.starttime - time3;
					dex_AniData[key].TheTime = value.TheTime + time3;
				end
			end
		elseif movetype == DEX_MOVTYP_HEALTH then
			for key, value in pairs(dex_AniData) do
				if value.Active and value.starttime>0 and value.moveTyp == DEX_MOVTYP_HEALTH then
					dex_AniData[key].starttime = value.starttime - time3;
					dex_AniData[key].TheTime = value.TheTime + time3;
				end
			end
		elseif movetype == DEX_MOVTYP_PET then
			for key, value in pairs(dex_AniData) do
				if value.Active and value.starttime>0 and value.moveTyp == DEX_MOVTYP_PET then
					dex_AniData[key].starttime = value.starttime - time3;
					dex_AniData[key].TheTime = value.TheTime + time3;
				end
			end
		else
			for key, value in pairs(dex_AniData) do
				if value.Active and value.starttime>0 and value.moveTyp == DEX_MOVTYP_NORMAL then
					dex_AniData[key].starttime = value.starttime - time3;
					dex_AniData[key].TheTime = value.TheTime + time3;
				end
			end
		end
	end
	return time2
end

function DEX_AddTextDo(Dodamage,DoSpell,Dodamagetype,DoCrit,DoIscurTarget,DoCoerciveShowSpell,DoTargetGUID,DoTargetName,DoHitType,DoSpellID,DoCombattime,OverData,BaseFrame,...)
	if DoSpell and (Dodamage == "0" or (tonumber(Dodamage) and tonumber(Dodamage) == 0)) then
		Dodamage = ""
	end
	if DoSpell == nil and Dodamage == nil then
		return
	end
	if DoSpell == nil then DoSpell = "";end
	if Dodamage == nil then Dodamage = "";end
	if DEX_Get("DEX_ShowWithMess") == 1 then
		local Maxline = DEX_Get("DEX_LOGLINE");
		local anitmp;
		local TDcolor,TDcolorSe = DEX_SetColor(Dodamagetype)
		for i = 1,10 do
			anitmp = dex_AniData["aniText"..i];
			anitmp.posY = anitmp.posY + DEX_Get("DEX_FontSize");
			anitmp.FObject:SetPoint("CENTER", "UIParent", "CENTER", anitmp.posX + DEX_Get("DEX_PosX"), anitmp.posY + DEX_Get("DEX_PosY"));
		end
		anitmp = dex_AniData["aniText"..dex_lastani];
		DEX_aniReset(anitmp);
		anitmp.starttime = GetTime();
		anitmp.Active = true;
		anitmp.posY = 0;
		anitmp.posX = 0;
		anitmp.FObject:ClearAllPoints()
		if DEX_Get("DEX_NumberFormat") == 1 and (tonumber(Dodamage) or string.find(Dodamage,"-")) then
			if string.find(Dodamage,"-") then
				local healstart = string.sub(Dodamage, 1 , string.find(Dodamage,"-") - 1)
				local healend = string.sub(Dodamage, string.find(Dodamage,"-") + 1, string.len(Dodamage))
				if Dodamagetype == DEX_DAMAGE_TYPE_HEALTH then
					Dodamage = amount_format(healstart).."("..amount_format(healend)..")"
				elseif Dodamagetype == DEX_DAMAGE_TYPE_BEATTACK  then
					Dodamage = amount_format(healstart).."("..amount_format(healend)..")"
				else
					Dodamage = amount_format(healstart).."("..amount_format(healend)..")"
				end
			else
				if Dodamagetype == DEX_DAMAGE_TYPE_HEALTH and DEX_Get("DEX_ShowOverHeal") == 1 and tonumber(DEX_OverHeal) then
					if tonumber(Dodamage) then
						Dodamage = tonumber(Dodamage) - tonumber(DEX_OverHeal);
					end
					DEX_OverHeal = amount_format(DEX_OverHeal);
				end
				Dodamage = amount_format(Dodamage);
			end
		else
			if Dodamagetype == DEX_DAMAGE_TYPE_HEALTH and DEX_Get("DEX_ShowOverHeal") == 1 and tonumber(DEX_OverHeal) then
				if tonumber(Dodamage) then
					Dodamage = tonumber(Dodamage) - tonumber(DEX_OverHeal);
				end
				if DEX_Get("DEX_NumberFormat") == 0 then
					DEX_OverHeal = number_format(DEX_OverHeal,",")
				end
			end
			if DEX_Get("DEX_NumberFormat") == 0 and tonumber(Dodamage) then
				Dodamage = number_format(Dodamage,",")
			end
		end

		Dodamage = trim(Dodamage)
		if overHeal ~= nil and tonumber(overHeal) then
			if tonumber(overHeal) >0 then
				overHealth = trim(overHeal);
				Dodamage = string.format("%s%s%s",Dodamage, "↑", overHeal);
			end
		end


		if DoCrit == 1 then Dodamage = DEX_TXT_CRIT..Dodamage; end
		anitmp.FObject:SetText(Dodamage.." "..DoSpell);
		anitmp.FObject:SetAlpha(1);
		anitmp.FObject:SetTextColor(TDcolor[1], TDcolor[2], TDcolor[3]);
		anitmp.FObject:SetPoint("CENTER", "UIParent", "CENTER", anitmp.posX + DEX_Get("DEX_PosX"), anitmp.posY + DEX_Get("DEX_PosY"));
		dex_lastani = dex_lastani + 1;
		if dex_lastani > DEX_Get("DEX_LOGLINE") then
			dex_lastani = 1
		end
		return
	end

	local ani = dex_AniData["aniText"..dex_lastani]
	DEX_aniReset(ani)
	ani.Active = true
	ani.height = DEX_TEXTSIZE;
	ani.crit = DoCrit;
	ani.spellbak = Blocked;
	ani.uid = DEX_ANI_UID
	ani.Frame = BaseFrame;
	if DoCombattime == nil then
		ani.starttime = GetTime()
	else
		ani.starttime = DoCombattime	
	end
	ani.TheTime = AniRunTime;
	ani.Extra = 0
	ani.destbak = DoSpell
	if not DoIscurTarget and  Dodamagetype ~= DEX_DAMAGE_TYPE_PET and ani.moveTyp ~= DEX_MOVTYP_AOE then
		ani.moveTyp = DEX_MOVTYP_OTHER
		ani.posY = DEX_GetMovTypOtherPosY()
		ani.posYbak = ani.posY
	end

	if (DoHitType == "DAMAGE" or DoHitType == "SHIELD" or DoHitType == "DISPEL" or DoHitType == "STOLEN" or DoHitType == "MISSED" or DoHitType == "SPELL_MISSED") and (Dodamagetype ~= DEX_DAMAGE_TYPE_PET and Dodamagetype ~= DEX_DAMAGE_TYPE_BEATTACK and Dodamagetype ~= DEX_DAMAGE_TYPE_HEALTH and Dodamagetype ~= DEX_DAMAGE_TYPE_ENVTYPE) then
		ani.moveTyp = DEX_MOVTYP_NORMAL
		ani.starttime = TimeCheck(TimeTmp.NT,ani.starttime,DEX_MOVTYP_NORMAL)
		TimeTmp.NT = ani.starttime
		if DEX_Get("DEX_RandomCrit") == 1 then
			if DEX_Get("DEX_CritX") == 0 then
				ani.posX = DEX_Get("DEX_CritX");
			else
				if DEX_Get("DEX_CritX") > 0 then
					ani.posX = random(abs(DEX_Get("DEX_CritX")))
				else
					ani.posX = random(abs(DEX_Get("DEX_CritX"))) * -1
				end
			end
			if DEX_Get("DEX_CritY") == 0 then
				ani.posY = DEX_Get("DEX_CritY");
			else
				if DEX_Get("DEX_CritY") > 0 then
					ani.posY = random(abs(DEX_Get("DEX_CritY")))
				else
					ani.posY = random(abs(DEX_Get("DEX_CritY"))) * -1
				end
			end
		end
		if tonumber(OverData) and DEX_Get("DEX_OverDamage") == 1 and Blocked == nil then
			ani.Extra = tonumber(OverData)
			if tonumber(Dodamage) and (tonumber(Dodamage) >= tonumber(OverData)) then
				Dodamage = tonumber(Dodamage) - tonumber(OverData);
			end
		end
	end

	if Dodamagetype == DEX_DAMAGE_TYPE_PET then
		ani.moveTyp = DEX_MOVTYP_PET;
		if dex_petbottom - ani.baseY < ani.height + 2 then
			local fixY = ani.height + 2 + ani.baseY - dex_petbottom;
			local anitmp;
			for i = 1,DEX_MAXANI do
				anitmp = dex_AniData["aniText"..i];
				if i ~= dex_lastani and anitmp.Active and anitmp.moveTyp == DEX_MOVTYP_PET then
					anitmp.baseY = anitmp.baseY + fixY;
				end
			end
		end
		if DEX_Get("DEX_Circle") == 1 then
			ani.starttime = TimeCheck(TimeTmp.NT,ani.starttime,DEX_MOVTYP_NORMAL)
			TimeTmp.NT = ani.starttime
		else
			ani.starttime = TimeCheck(TimeTmp.PT,ani.starttime,DEX_MOVTYP_PET)
			TimeTmp.PT = ani.starttime
		end
		if DEX_Get("DEX_RandomCrit") == 1 then
			if DEX_Get("DEX_PetPosX") == 0 then
				ani.posX = DEX_Get("DEX_PetPosX");
			else
				if DEX_Get("DEX_PetPosX") > 0 then
					ani.posX = random(abs(DEX_Get("DEX_PetPosX")))
				else
					ani.posX = random(abs(DEX_Get("DEX_PetPosX"))) * -1
				end
			end
			if DEX_Get("DEX_PetPosY") == 0 then
				ani.posY = DEX_Get("DEX_PetPosY");
			else
				if DEX_Get("DEX_PetPosY") > 0 then
					ani.posY = random(abs(DEX_Get("DEX_PetPosY")))
				else
					ani.posY = random(abs(DEX_Get("DEX_PetPosY"))) * -1
				end
			end
		end
		if tonumber(OverData) and DEX_Get("DEX_OverDamage") == 1 and Blocked == nil then
			ani.Extra = tonumber(OverData)
			if tonumber(Dodamage) and (tonumber(Dodamage) >= tonumber(OverData)) then
				Dodamage = tonumber(Dodamage) - tonumber(OverData);
			end
		end
	end

	if Dodamagetype == DEX_DAMAGE_TYPE_HONOR then
		ani.critTyp = 1
		ani.zoom = 1.35;
		ani.moveTyp = DEX_MOVTYP_NONE;
	end

	if Dodamagetype == DEX_DAMAGE_TYPE_BEATTACK or Dodamagetype == DEX_DAMAGE_TYPE_ENVTYPE then
		if DEX_Get("DEX_BeAttackPosY") == 0 and DEX_Get("DEX_BeAttackPosX") == 0 and DEX_Get("DEX_Circle") == 0 then
			ani.moveTyp = DEX_MOVTYP_NORMAL
			ani.starttime = TimeCheck(TimeTmp.NT,ani.starttime,DEX_MOVTYP_NORMAL)
			TimeTmp.NT = ani.starttime
		else
			ani.moveTyp = DEX_MOVTYP_ATTACK
			if DEX_Get("DEX_Circle") == 1 then
				ani.starttime = TimeCheck(TimeTmp.HT,ani.starttime,DEX_MOVTYP_HEALTH)
				TimeTmp.HT = ani.starttime
			else
				ani.starttime = TimeCheck(TimeTmp.AT,ani.starttime,DEX_MOVTYP_ATTACK)
				TimeTmp.AT = ani.starttime
			end
		end
		if DEX_Get("DEX_RandomCrit") == 1 then
			if DEX_Get("DEX_BeAttackPosX") == 0 then
				ani.posX = DEX_Get("DEX_BeAttackPosX");
			else
				if DEX_Get("DEX_BeAttackPosX") > 0 then
					ani.posX = random(abs(DEX_Get("DEX_BeAttackPosX")))
				else
					ani.posX = random(abs(DEX_Get("DEX_BeAttackPosX"))) * -1
				end
			end
			if DEX_Get("DEX_BeAttackPosY") == 0 then
				ani.posY = DEX_Get("DEX_BeAttackPosY");
			else
				if DEX_Get("DEX_BeAttackPosY") > 0 then
					ani.posY = random(abs(DEX_Get("DEX_BeAttackPosY")))
				else
					ani.posY = random(abs(DEX_Get("DEX_BeAttackPosY"))) * -1
				end
			end
		end
		if tonumber(OverData) and DEX_Get("DEX_OverDamage") == 1 and Blocked == nil then
			ani.Extra = tonumber(OverData)
			if tonumber(Dodamage) and (tonumber(Dodamage) >= tonumber(OverData)) then
				Dodamage = tonumber(Dodamage) - tonumber(OverData);
			end
		end
	end
	if Dodamagetype == DEX_DAMAGE_TYPE_HEALTH then
		if DEX_Get("DEX_HealthPosY") == 0 and DEX_Get("DEX_HealthPosX") == 0 and DEX_Get("DEX_Circle") == 0 then
			ani.moveTyp = DEX_MOVTYP_NORMAL
			ani.starttime = TimeCheck(TimeTmp.NT,ani.starttime,DEX_MOVTYP_NORMAL)
			TimeTmp.NT = ani.starttime
		else
			ani.moveTyp = DEX_MOVTYP_HEALTH
			ani.starttime = TimeCheck(TimeTmp.HT,ani.starttime,DEX_MOVTYP_HEALTH)
			TimeTmp.HT = ani.starttime
		end
		if DEX_Get("DEX_RandomCrit") == 1 then
			if DEX_Get("DEX_HealthPosX") == 0 then
				ani.posX = DEX_Get("DEX_HealthPosX");
			else
				if DEX_Get("DEX_HealthPosX") > 0 then
					ani.posX = random(abs(DEX_Get("DEX_HealthPosX")))
				else
					ani.posX = random(abs(DEX_Get("DEX_HealthPosX"))) * -1
				end
			end
			if DEX_Get("DEX_HealthPosY") == 0 then
				ani.posY = DEX_Get("DEX_HealthPosY");
			else
				if DEX_Get("DEX_HealthPosY") > 0 then
					ani.posY = random(abs(DEX_Get("DEX_HealthPosY")))
				else
					ani.posY = random(abs(DEX_Get("DEX_HealthPosY"))) * -1
				end
			end
		end
		if DEX_Get("DEX_ShowOverHeal") == 1 and tonumber(OverData)  and Blocked == nil then
			ani.Extra = tonumber(OverData)
			if tonumber(Dodamage) and (tonumber(Dodamage) >= tonumber(OverData)) then
				Dodamage = tonumber(Dodamage) - tonumber(OverData);
				if Dodamage <= 0 and DEX_Get("DEX_HealthFull") == 1 then
					ani.Active = false;
				end
			end
		end
	end
	if ani.crit == 1 then
		if Dodamagetype ~= DEX_DAMAGE_TYPE_PET then
			if DoSpell == "" then
				ani.zoom = 2;
			else
				ani.zoom = 1.6;
			end
		else
			ani.zoom = 1.5;
		end
		if DEX_Get("DEX_ShowSpellName") == 1 and DEX_Get("DEX_ShowNameOnCrit") == 1 and DoSpell ~= "" then
			ani.zoom = 1.8;
		else
			ani.critTyp = 1;
		end
		if Dodamagetype ~= DEX_DAMAGE_TYPE_PET then
			ani.critId = DEX_critFlag;
			ani.posYbak = ani.posY;

			DEX_critFlag = DEX_critFlag + 1;
			if DEX_critFlag > 3 then DEX_critFlag = 0;end
		end
	end

	ani.delay = Dodamage
	ani.lastupdate = Dodamagetype
	if DoHitType == "INTERRUPT" or DoHitType == "DISPEL" or DoHitType == "STOLEN" then
		if tonumber(extraSpellId) then
			ani.destbak = tonumber(extraSpellId)
		else
			ani.destbak = nil
		end
	elseif Dodamagetype ~= DEX_DAMAGE_TYPE_ENVTYPE then
		if tonumber(DoSpellID) then
			ani.destbak = tonumber(DoSpellID)
		else
			ani.destbak = nil
		end
	end
	if (DoHitType == "DAMAGE" and Dodamagetype == DEX_DAMAGE_TYPE_HIT)  or (Dodamagetype == DEX_DAMAGE_TYPE_BEATTACK and DoSpellID == nil) or (DoSpellID == nil and Dodamagetype ~= DEX_DAMAGE_TYPE_ENVTYPE) then
		ani.destbak = nil
	end

	ani.HitType = DoHitType
	if Dodamagetype == DEX_DAMAGE_TYPE_HIT and DoSpellID ~= 0 then
		ani.moveTyp = DEX_MOVTYP_NORMAL
	end
	DEX_RefressBottom(ani);
	DEX_ANI_UID = DEX_ANI_UID + 1
	dex_lastani = dex_lastani + 1;
	if dex_lastani > DEX_MAXANI then
		dex_lastani = tonumber(DEX_Get("DEX_LOGLINE")) * tonumber(DEX_Get("DEX_ShowWithMess")) + 1;
	end
end

function DEX_aniInit()
	DEX_OUTLINE = DEX_FONTEFF[DEX_Get("DEX_OutLine")].ol
	dex_lastani = 1

	DEX_FONTNAME = DEX_FontList[DEX_Get("DEX_Font") or 1]

	DEX_SHADOW = DEX_FONTEFF[DEX_Get("DEX_OutLine")].shadowOff

	DEX_TEXTSIZE = DEX_Get("DEX_FontSize");
	DEX_Set_WOWDamage()	--打开或关闭自带战斗信息
	for key, value in pairs(dex_AniData) do
		value.FObject = getglobal("DEX"..key);
		DEX_aniReset(value);
	end
	local Framelevel = DEX_Get("DEX_FrameLevel");
	if Framelevel == 1 then
		DEX_TEXT:SetFrameStrata("WORLD")
	elseif Framelevel == 2 then
		DEX_TEXT:SetFrameStrata("BACKGROUND")
	elseif Framelevel == 3 then
		DEX_TEXT:SetFrameStrata("LOW")
	elseif Framelevel == 4 then
		DEX_TEXT:SetFrameStrata("MEDIUM")
	elseif Framelevel == 5 then
		DEX_TEXT:SetFrameStrata("HIGH")
	elseif Framelevel == 6 then
		DEX_TEXT:SetFrameStrata("DIALOG")
	elseif Framelevel == 7 then
		DEX_TEXT:SetFrameStrata("FULLSCREEN")
	elseif Framelevel == 8 then
		DEX_TEXT:SetFrameStrata("FULLSCREEN_DIALOG")
	elseif Framelevel == 9 then
		DEX_TEXT:SetFrameStrata("TOOLTIP")
	else
		DEX_TEXT:SetFrameStrata("BACKGROUND")
	end
	if DEX_Get("DEX_Enable") == 1 then
		PlayerW = select(1, UnitClass("player"));                --检测玩家职业
		if IsOldServer then 
			if PlayerW == DEX_DRUIDID and GetActiveTalentGroup() == 2 then
				PlayerTelenid = DEX_DRUIDFERAL;
			end
		else
			currentSpec = GetSpecialization()
			if currentSpec ~= nil then
				 _,PlayerTelenid, _, _, _, _ = GetSpecializationInfo(currentSpec)
			end
		end
	end
	unitList = {}
	TimeTmpReset()
	DataTmpSpell.StartTime = 0
	DataTmpDot.StartTime = 0
	DataTmpShield.StartTime = 0
	DataTmpSpell.spellid = 0
	DataTmpShield.spellid = 0
	DataTmpDot.spellid = 0
	DataTmpHealth.spellid = 0
	DataTmpHealth.StartTime = 0
	AOEEnd = DEX_Get("DEX_AOETime") / 10
	infoFontHit = DEX_Get("DEX_FontSize")
	infoP1 = {"BOTTOM", DEX_TEXT, "CENTER", DEX_Get("DEX_PosX") + DEX_Get("DEX_ShowHitX"), DEX_Get("DEX_PosY") + DEX_Get("DEX_ShowHitY")}
	frames["HitInformation"] = CreateHitFrame("HitInformation", "CENTER", DEX_FontList[DEX_Get("DEX_Font")], DEX_Get("DEX_FontSize"), ifSize, infoP1)
	return
end

function DEX_aniReset(aniData)
	aniData.Active = false;
	aniData.crit = 0;
	aniData.starttime = 0;
	aniData.moveTyp = DEX_MOVTYP_NORMAL;
	aniData.critId = 0;
	aniData.critTyp = 0;
	aniData.posY = 0;
	aniData.posX = 0;
	aniData.posYbak = 0;
	aniData.zoom = 0;
	aniData.baseY = 0;
	aniData.alpha = 0;
	aniData.height = DEX_TEXTSIZE;
	aniData.delay = "";
	aniData.lastupdate = "";
	aniData.Extra = 0;
	aniData.spellbak = nil;
	aniData.damagebak = 0;
	aniData.destbak = nil;
	aniData.HitType = "";
	aniData.Frame = nil;
	aniData.TheTime = 0;

	DEX_SetFontSize(aniData,DEX_TEXTSIZE)
	aniData.FObject:SetText("");
	aniData.FObject:SetTextHeight(aniData.height);
	aniData.FObject:SetAlpha(aniData.alpha);
	aniData.FObject:SetPoint("CENTER", "UIParent", "CENTER", aniData.posX, aniData.posY);
end

function DEX_Set_WOWDamage()
	if DEX_Get("DEX_GameEnable") == 1 then
		SetCVar("floatingCombatTextCombatDamage", 1);
		SetCVar("floatingCombatTextCombatHealing", 1);
		SetCVar("floatingCombatTextPetMeleeDamage", 1)   	 --寵物對目標傷害
		SetCVar("floatingCombatTextPetSpellDamage", 1)   	 --寵物對目標傷害
	else
		SetCVar("floatingCombatTextCombatDamage", 0);
		SetCVar("floatingCombatTextCombatHealing", 0);
		SetCVar("floatingCombatTextPetMeleeDamage", 0)   	 --寵物對目標傷害
		SetCVar("floatingCombatTextPetSpellDamage", 0)   	 --寵物對目標傷害
	end
end

function DEX_SetFontSize(ani,size)
	ani.FObject:SetFont(DEX_FONTNAME, size,DEX_OUTLINE);
	ani.FObject:SetShadowOffset(DEX_SHADOW,-DEX_SHADOW);
end

function DEX_ToDec(a)
	local i = 0;
	while a - i > 1 do
		i = i + 1;
	end
	return i;
end
function DEX_ToHEX(a)
	if a < 0 then a = 0;end
	if a > 1 then a = 1;end
	local b = a * 256;
	return ""..DEX_HEX_LIST[DEX_ToDec(b / 16) + 1]..DEX_HEX_LIST[ DEX_ToDec( ( b / 16 - DEX_ToDec(b / 16) ) * 16 ) + 1];
end
function DEX_ColorFlip(r,g,b)
	return "|cff"..DEX_ToHEX(r)..DEX_ToHEX(g)..DEX_ToHEX(b);
end

function DEX_TranTxt(txt,rgb1,rgb2)
	local tc = string.len(txt)
	local i
	local c = 0
	for i = 1,tc do
		if string.byte(txt,i,i) ~= nil then
			if string.byte(txt,i,i) < 128 then
				if string.byte(txt,i,i) ~= 32 then c = c + 1;end
			else
				c = c + 1
				i = i + 2
			end
		end
	end

	if c < 2 then return txt;end
	local re = ""
	local w = 1
	local rs,gs,bs
	rs = (rgb2[1] - rgb1[1]) / (c - 1)
	gs = (rgb2[2] - rgb1[2]) / (c - 1)
	bs = (rgb2[3] - rgb1[3]) / (c - 1)

	for i = 1,c + 1 do
		if w > 1 then
			w = w - 1
		else
			if string.byte(txt,i) ~= nil then
				if string.byte(txt,i) < 128 then
					w = 1
				else
					w = 3
				end
				re = re..DEX_ColorFlip(rgb1[1] + rs * (i - 1),rgb1[2] + gs * (i - 1),rgb1[3] + bs * (i - 1))..string.sub(txt,i,i + w - 1).."|r"
			end
		end
	end
	return re
end


function number_format(num,deperator)  
    local str1 =""  
    local str = tostring(num)  
    local strLen = string.len(str)  
          
    if deperator == nil then  
        deperator = ","  
    end  
    deperator = tostring(deperator)  
          
    for i=1,strLen do  
        str1 = string.char(string.byte(str,strLen+1 - i)) .. str1  
        if math.fmod(i,3) == 0 then  
            --下一个数 还有  
            if strLen - i ~= 0 then  
                str1 = ","..str1  
            end  
        end  
    end  
    return str1  
end 

--格式化数字:以W和E为单位 @author:Farever
function amount_format(num)
	local strReturn =""
	local str = tostring(num)
	local strLen = string.len(str)

	if strLen > 0 then
		local number = tonumber(num)
		--trans to number successfully
		if number then
			if number < 9999 then
				strReturn = number
			elseif number < 99999999 then
				strReturn = string.format("%.1f万",number / 10000)
			elseif number < 99999999999 then
				strReturn = string.format("%.2f亿",number / 100000000)
			end
		--if nil : fail to trans to number
		else
			strReturn = num
		end
	end
	return strReturn
end

function trim(input)
	return (string.gsub(input, "^%s*(.-)%s*$", "%1"))
end