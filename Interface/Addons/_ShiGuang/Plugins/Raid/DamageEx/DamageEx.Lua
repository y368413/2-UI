--**********************************
-- *2025.02.25日更新春节特别版  *
--**********************************
local dex_lastani = 1;
local dex_bottom = 0;
local dex_petbottom = 0
local DEX_MAXANI = 30;
local DEX_TEXTSIZE = 22;
local DEX_OUTLINE = "";
local DEX_FONTNAME = DEX_FontList[1];
local DEX_SHADOW = 2;
local DEX_logLine = 10;
local DEX_logTime = 10;

local AniRunTime = 1.5
local EndTime, EndTime1 = 0, 0
local AOEEnd = 0.7

local ISTARGETPLAYER;
local ISVEHICLE
local infoFont = 26
local infoFontHit = 35
local ifSize = {500, 150}
local fontType = "Fonts\\ARKai_T.TTF"
local infoP1 = {"BOTTOM", DEX_TEXT, "CENTER",-150, -150}
local frames = {}
local fadeTime = 1
local frameMaxLine = 3

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
DEX_DAMAGE_TYPE_PET = 4096
DEX_DAMAGE_TYPE_HONOR = 5
DEX_DAMAGE_TYPE_MANA = 6
DEX_DAMAGE_TYPE_BEATTACK = 4

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

local amount, school, resisted, blocked, absorbed, critical, glancing, crushing
local spellId, spellName, spellSchool, missType, powerType, extraAmount, environmentalType, extraSpellId, extraSpellName, extraSpellSchool, auraType
local missType

local dexType,dexText,dexSpell,dexCrit
local playerGUID, petGUID, targetGUID

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
	}

local DEX_PREFIXES = {
		["SWING"] = 1,
		["RANGE"] = 4,
		["SPELL"] = 4,
		["SPELL_PERIODIC"] = 4,
		["ENVIRONMENTAL"] = 2,
		["DAMAGE"] = 4,
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
		["aniText21"] = {},
		["aniText22"] = {},
		["aniText23"] = {},
		["aniText24"] = {},
		["aniText25"] = {},
		["aniText26"] = {},
		["aniText27"] = {},
		["aniText28"] = {},
		["aniText29"] = {},
		["aniText30"] = {},
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
	["DEX_UniteSpell"] = 1,
	["DEX_ShowDamageWoW"] = 0,
	["DEX_ShowDamageSpellName"] = 1,
	["DEX_ShowDamageNameOnCrit"] = 1,
	["DEX_ShowDamageIconOnCrit"] = 1,
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
	["DEX_ShowHealthSpellIconOnCrit"] = 1,
	["DEX_HealthPosX"] = 0,
	["DEX_HealthPosY"] = 0,
	["DEX_ShowHealthType"] = 1,
	["DEX_Speed"] = 120,
	["DEX_PosX"] = 280,
	["DEX_PosY"] = 230,
	["DEX_FontSize"] = 21,
	["DEX_Font"] = 2,
	["DEX_OutLine"] = 1,
	["DEX_ColorPet"] = {1,0.6,0},
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
}

local GetSpellInfo = GetSpellInfo or function(spellID)
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
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("PLAYER_REGEN_ENABLED");		--离开战斗
	self:RegisterEvent("PLAYER_REGEN_DISABLED");		--进入战斗
	DEX_Set_WOWDamage();
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

	DEX_aniInit();
	DEX_staticInit();
	DEX_OnOptionCheck("DEX_Enable", DEX_Get("DEX_Enable") == 1)

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

function DEX_ProcBlock(thetype)
	if DEX_Get("DEX_ShowBlockNumber") ~= 1 then return;end
--修正格档、吸收、减伤等
	if not tonumber(dexText) or string.find(dexText,"-") then
		if DEX_Get("DEX_NumberFormat") == 1 then
			if string.find(dexText,"-") then
				local healstart = string.sub(dexText, 1 , string.find(dexText,"-") - 1)
				if thetype == "DAMAGE" or thetype == "SHIELD" then
					dexText = healstart
				else
					dexText = amount_format(healstart)
				end
				return
			else
				if thetype == "DAMAGE" or thetype == "SHIELD" then
					dexText = "0"
				else
					dexText = amount_format(dexText)
				end
				return
			end
			local healend = ""
			if resisted then								--抵抗
				healend = "(抵抗"..amount_format(resisted)..")"
			elseif blocked then								--格挡
				healend = "(格挡"..amount_format(blocked)..")"
			elseif absorbed then							--吸收
				healend = "(吸收"..amount_format(absorbed)..")"
			elseif glancing then							--偏斜
				healend = "(偏斜"..amount_format(getglobal("DEFLECT"))..")"
			elseif crushing then								--碾压
				healend = "(碾压)"
			end
			if thetype == "DAMAGE" or thetype == "SHIELD" then
				if resisted then
					dexText = tonumber(dexText) - tonumber(resisted)
				end
			else
				dexText = dexText..healend
			end
		else
			if thetype == "DAMAGE" or thetype == "SHIELD" then
				if resisted then
					dexText = tonumber(dexText) - tonumber(resisted)
				else
					return
				end
			else
				if resisted then								--抵抗
					dexText = dexText.."-"..resisted
				elseif blocked then
					dexText = dexText.."-"..blocked				--格挡
				elseif absorbed then
					dexText = dexText.."-"..absorbed				--吸收
				elseif glancing then
					dexText = dexText.." "..getglobal("DEFLECT");		--偏斜
				elseif crushing then
					dexText = dexText.." "..DEX_TXT_CRUSH;		--碾压
				end
			end
		end
	end
end

function DEX_OnEvent(self, event, ...)
	if event == "VARIABLES_LOADED" then
		DEX_Init(self);
	elseif event == "PLAYER_LOGIN" then

		playerGUID = UnitGUID("player")
		petGUID = UnitGUID("pet")
	elseif event == "UNIT_PET" then
		if "player" == ... then
			petGUID = UnitGUID("pet")
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		local Framelevel = DEX_Get("DEX_FrameLevel")
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
		DEX_aniInit()
		DEX_staticInit()
		PlayerW = select(1, UnitClass("player"));                --检测玩家职业
		currentSpec = GetSpecialization()
		if currentSpec ~= nil then
			 _,PlayerTelenid, _, _, _, _ = GetSpecializationInfo(currentSpec)
		end
		TimeTmpReset()
		EndTime = 0
		EndTime1 = 0
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
		infoP1 = {"BOTTOM", UIParent, "CENTER", DEX_Get("DEX_PosX") + DEX_Get("DEX_ShowHitX"), DEX_Get("DEX_PosY") + DEX_Get("DEX_ShowHitY")}
		frames["HitInformation"] = CreateHitFrame("HitInformation", "CENTER", DEX_FontList[DEX_Get("DEX_Font")], DEX_Get("DEX_FontSize"), ifSize, infoP1)
		if DEX_Get("DEX_State") == 1 then
			DEX_AddText("进入战斗","",DEX_DAMAGE_TYPE_HONOR,1,true,false,"","","Begin",0,0)
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		EndTime = GetTime()
		if DEX_Get("DEX_State") == 1 then
			DEX_AddText("离开战斗","",DEX_DAMAGE_TYPE_HONOR,1,true,false,"","","End",0,0)
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		targetGUID = UnitGUID("target")
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		DEX_ProcessCombatLog(CombatLogGetCurrentEventInfo())
	end
end

function DEX_ProcessCombatLog(timeStamp, flag, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlag, destRaidFlags, ...)
	if not DEX_Get("DEX_Enable")  then
		return				--没有打开战斗显示
	end
	if not UnitAffectingCombat("player") and DEX_Get("DEX_NoCombatHeal") ~= 1 then
		if EndTime > 0 then
			if EndTime1 - EndTime > AniRunTime then
				DEX_aniInit()
				EndTime = 0
				EneTime1 = 0
				DataTmpSpell.StartTime = 0
				DataTmpDot.StartTime = 0
				DataTmpShield.StartTime = 0
				DataTmpHealth.StartTime = 0
				return
			else
				EndTime1 = GetTime()
			end
		else
			return
		end
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

	if not UnitAffectingCombat("player") and DEX_Get("DEX_NoCombatHeal") == 1 and suffixes ~= "HEAL" then
		return
	end

	local ISPLAYER = sourceGUID == playerGUID

	ISTARGETPLAYER = playerGUID == destGUID;      --判断受到伤害
	local isVehicle = UnitGUID("vehicle") == sourceGUID;      --判断载具伤害
	ISVEHICLE = isVehicle									--判断载具伤害
	local ISPET = sourceGUID == petGUID or CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET)
	-- or CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE)			--Modify big bug

	local CombatTime = GetTime()

	if DEX_Get("DEX_ShowDamageWoW") == 0 and ISTARGETPLAYER then
			return -- 不处理受到的伤害
	end

	if not ISPLAYER and not ISPET and not ISTARGETPLAYER and not isVehicle then                    --增加受到伤害及载具输出
		return -- irrelevant combat data, ignore
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
	if suffixes == "AURA_APPLIED" and destGUID == playerGUID and (DEX_Get("DEX_ShowBuff") ~= 1 and DEX_Get("DEX_ShowDeBuff") ~= 1) then
		return
	end
	
	if UnitAffectingCombat("player") then
		if DEX_Get("DEX_ShowHit") == 1 then
			if PlayerW == "潜行者" or (PlayerW == "德鲁伊" and PlayerTelenid == "野性") then
				HitPoints = UnitPower("player", 4);    --野德和盗贼连击点
			elseif PlayerW == "武僧" and PlayerTelenid == "踏风" then	--武僧真气提示
				HitPoints = UnitPower("player", 12);    --武僧真气
			else
				HitPoints = 0
			end
			if HitPoints > 0 then
				if PlayerW == "武僧" then
					frames["HitInformation"]:AddMessage(HitPoints.."真气", 1, 1, 0)
				else
					frames["HitInformation"]:AddMessage(HitPoints.."连击", 1, 1, 0)
				end
			else
				frames["HitInformation"]:AddMessage("", 1, 1, 0)
			end
		end
	end

--数据开始处理
	spellName = ""
	spellId = nil
	spellScholl = ""
	amount = 0
	spellId, spellName, spellSchool = ...
	if type(spellId) == "string" then
		spellId = nil
	end
	if select(1,GetSpellInfo(spellId))~=nil then 
		spellName = select(1,GetSpellInfo(spellId))
	end

	if  (ISPLAYER or ISVEHICLE or ISPET) and not ISTARGETPLAYER then
		if DEX_Get("DEX_ShowDamage") ~= 1 and suffixes ~= "INTERRUPT" then
			return
		end
		if suffixes == "INTERRUPT" and DEX_Get("DEX_ShowInterrupt") ~= 1 then
			return
		end
		if flag == "SPELL_EXTRA_ATTACKS" then
			spellId, spellName, spellSchool,amount = select(1,...)
			if type(spellId) == "string" then
				spellId = nil
			end
			if select(1,GetSpellInfo(spellId))~=nil then 
				spellName = select(1,GetSpellInfo(spellId))
			end
			if ISPLAYER then
				dexText = tostring(amount)
				dexType = DEX_DAMAGE_TYPE_HIT
				DEX_AddText(dexText,"",dexType,0,true,false,destGUID,destName,suffixes,spellId,CombatTime)
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
					DEX_AddText(dexText,"",dexType,0,true,false,destGUID,destName,suffixes,spellId,CombatTime)
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
					if select(1,GetSpellInfo(spellId))~=nil then 
						spellName = select(1,GetSpellInfo(spellId))
					end
					if spellId and DEX_ReflectSpellID == spellId then
						local fromTarget = false
						if destGUID == UnitGUID("target") then fromTarget = true;end
						dexType = DEX_DAMAGE_TYPE_HIT
						if flag == "SPELL_DAMAGE" then
							amount,overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(4,...);
							DEX_AddText(amount..DEX_TXT_REFLECT,spellName,DEX_DAMAGE_TYPE_SPELL,critical,true,destGUID,destName,suffixes, spellId,CombatTime)
							DEX_ReflectSpellID = 0
							return
						end
						if flag == "SPELL_MISSED" then
							missType = select(4,...)
							DEX_AddText(getglobal(missType)..DEX_TXT_REFLECT,spellName,DEX_DAMAGE_TYPE_SPELL,0,true,destGUID,destName,suffixes,spellId,CombatTime)
							DEX_ReflectSpellID = 0
							return
						end
					end
				end
			else
				DEX_ReflectSpellID = 0
			end
		end

		dexType = nil
		dexText = "0"
		dexSpell = ""
		dexCrit = 0
		spellId = nil

		--DEX_Debug(flag);
		spellId, spellName, spellSchool = ...
		if type(spellId) == "string" then
			spellId = nil
		end
		if select(1,GetSpellInfo(spellId))~=nil then 
			spellName = select(1,GetSpellInfo(spellId))
		end

		if suffixes == "DAMAGE" then

			amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(DEX_PREFIXES[prefixes],...);
			dexText = tostring(amount)
			if critical then dexCrit = 1;end
			if prefixes == "SWING" then
				dexType = DEX_DAMAGE_TYPE_HIT
			elseif prefixes == "RANGE" then
				dexType = DEX_DAMAGE_TYPE_HIT
			elseif prefixes == "SPELL"then
				dexType = DEX_DAMAGE_TYPE_SPELL
				dexSpell = spellName
			elseif prefixes == "SPELL_PERIODIC" then
				dexType = DEX_DAMAGE_TYPE_PERIODIC
				dexSpell = spellName
			end
			DEX_ProcBlock(suffixes)

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
			dexText = amount
			DEX_OverHeal = overDamage
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
				DEX_ProcBlock(suffixes)
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
				DEX_ProcBlock(suffixes)
			else
				return
			end
		--驅散
		elseif suffixes == "DISPEL" then
			extraSpellID,extraSpellName,extraSpellSchool,auraType = select(DEX_PREFIXES[prefixes],...)
			if DEX_DISPELLED_FILTER[extraSpellName] then
				return
			end

			dexType = DEX_DAMAGE_TYPE_HONOR
			dexText = DEX_TXT_DISPELLED

		--偷取
		elseif suffixes == "STOLEN" then
			extraSpellID,extraSpellName,extraSpellSchool = select(DEX_PREFIXES[prefixes],...)
			dexType = DEX_DAMAGE_TYPE_HONOR
			dexText = DEX_TXT_STOLEN
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
			DEX_AddText(dexText,dexSpell,dexType,dexCrit,true,false,destGUID,destName,suffixes,spellId,CombatTime)
		end

	elseif ISTARGETPLAYER and not ISPET then
		if DEX_Get("DEX_ShowDamageWoW") ~= 1 and suffixes ~= "AURA_APPLIED" and suffixes ~= "HEAL" then
			return
		end
		dexType = DEX_DAMAGE_TYPE_BEATTACK
		if flag == "SPELL_EXTRA_ATTACKS" then
			spellId, spellName, spellSchool,amount = select(1,...)
			if type(spellId) == "string" then
				spellId = nil
			end
			if select(1,GetSpellInfo(spellId))~=nil then 
				spellName = select(1,GetSpellInfo(spellId))
			end
			dexText = tostring(amount)
			DEX_AddText(dexText,"",dexType,0,true,false,destGUID,destName,suffixes,spellId,CombatTime)
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
					DEX_AddText(dexText,"",dexType,0,true,false,destGUID,destName,suffixes,spellId,CombatTime)
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
					if select(1,GetSpellInfo(spellId))~=nil then 
						spellName = select(1,GetSpellInfo(spellId))
					end
					if spellId and DEX_ReflectSpellID == spellId then
						local fromTarget = false
						if destGUID == playerGUID then fromTarget = true;end
						if flag == "SPELL_DAMAGE" then
							amount,overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(4,...);
							DEX_AddText(amount..DEX_TXT_REFLECT,dexType,0,true,destGUID,destName,suffixes,spellId,CombatTime)
							DEX_ReflectSpellID = 0
							return
						end
						if flag == "SPELL_MISSED"  then
							missType = select(4,...)
							DEX_AddText(getglobal(missType)..DEX_TXT_REFLECT,spellName,dexType,0,true,destGUID,destName,suffixes,spellId,CombatTime)
							DEX_ReflectSpellID = 0
							return
						end
					end
				end
			else
				DEX_ReflectSpellID = 0
			end
		end

		dexText = "0"
		dexSpell = ""
		dexCrit = 0
		spellId = nil

		--DEX_Debug(flag);
		spellId, spellName, spellSchool = ...
		if type(spellId) == "string" then
			spellId = nil
		end

		if suffixes == "DAMAGE" then

			amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(DEX_PREFIXES[prefixes],...);
			dexText = tostring(amount)
			if critical then dexCrit = 1;end

			if prefixes == "SPELL" or prefixes == "SPELL_PERIODIC" then
				dexSpell = spellName
			elseif prefixes == "SWING" or prefixes == "RANGE" then
				spellId = nil
				dexSpell = ""
			else
				return
			end
			DEX_ProcBlock("")

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
			dexText = amount
			DEX_OverHeal = overDamage
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
				DEX_ProcBlock(suffixes)
			else
				return
			end

		elseif suffixes == "SPLIT" then
			if prefixes == "DAMAGE" then
				amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(DEX_PREFIXES[prefixes],...)
				dexText = tostring(amount)
				if critical then dexCrit = 0;end
				dexSpell = spellName
				DEX_ProcBlock(suffixes)
			else
				return
			end
		--驅散
		elseif suffixes == "DISPEL" then
			extraSpellID,extraSpellName,extraSpellSchool,auraType = select(DEX_PREFIXES[prefixes],...)
			if DEX_DISPELLED_FILTER[extraSpellName] then
				return
			end
			dexText = DEX_TXT_DISPELLED

		--偷取
		elseif suffixes == "STOLEN" then
			extraSpellID,extraSpellName,extraSpellSchool = select(DEX_PREFIXES[prefixes],...)
			dexText = DEX_TXT_STOLEN

		elseif suffixes == "AURA_APPLIED" then
			if DEX_Get("DEX_ShowBuff") ~= 1 and DEX_Get("DEX_ShowDeBuff") ~=1 then
				return
			end
			spellId, spellName, spellSchool,amount = select(1,...)
			if type(spellId) == "string" then
				spellId = nil
			end
			if ISPLAYER and amount == "BUFF" and DEX_Get("DEX_ShowBuff") == 1 then
				dexSpell = spellName
				dexType = DEX_DAMAGE_TYPE_HEALTH
			elseif sourceGUID == targetGUID and amount == "DEBUFF" and DEX_Get("DEX_ShowDeBuff") ==1 then
				dexSpell = spellName
			else
				return
			end 
		else
			return
		end

		if  dexType ~= DEX_DAMAGE_TYPE_PET then
			DEX_AddText(dexText,dexSpell,dexType,dexCrit,true,false,destGUID,destName,suffixes,spellId,CombatTime)
		end

	end

	if  dexType == DEX_DAMAGE_TYPE_PET then
		DEX_AddText(dexText,dexSpell,dexType,dexCrit,false,false,destGUID,destName,suffixes,spellId,CombatTime)
	end
end

function DEX_GameUpdate(self)
	dex_bottom = 99999;
	dex_petbottom = 99999;
	if DataTmpHealth.StartTime > 0 and GetTime() - DataTmpHealth.StartTime > AOEEnd then
		DEX_AddText("","",DEX_DAMAGE_TYPE_AOEHEALTH,0,true,false,"","","DAMAGE",0,0)
	elseif not UnitAffectingCombat("player") and DEX_Get("DEX_NoCombatHeal") == 1 then
		if DataTmpHealth.StartTime == 0 then
			DataTmpHealth.StartTime = GetTime()
		end
	end
	if DataTmpSpell.StartTime > 0 and GetTime() - DataTmpSpell.StartTime > AOEEnd then
		DEX_AddText("","",DEX_DAMAGE_TYPE_AOESPELL,0,true,false,"","","DAMAGE",0,0)
	end
	if DataTmpDot.StartTime > 0 and GetTime() - DataTmpDot.StartTime > AOEEnd then
		DEX_AddText("","",DEX_DAMAGE_TYPE_AOEDOT,0,true,false,"","","DAMAGE",0,0)
	end
	if DataTmpShield.StartTime > 0 and GetTime() - DataTmpShield.StartTime > AOEEnd then
		DEX_AddText("","",DEX_DAMAGE_TYPE_AOESHIELD,0,true,false,"","","DAMAGE",0,0)
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
	local thetime = GetTime() - ani.starttime;
	if thetime < DEX_logTime and thetime >= 0 then
		ani.FObject:SetAlpha(1);
	else
		if thetime < DEX_logTime + 3 then
			ani.FObject:SetAlpha(1 - (thetime - DEX_logTime) / 3);
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

function DEX_SetColor(HitType)
	local color = {1,1,1};
	local colorSe = {1,1,1};
	if HitType == DEX_DAMAGE_TYPE_BEATTACK then
		color = DEX_Get("DEX_ColorAttack");
		colorSe = DEX_Get("DEX_ColorAttackSe");
	elseif HitType == DEX_DAMAGE_TYPE_HIT then
		color = DEX_Get("DEX_ColorNormal");
		colorSe = DEX_Get("DEX_ColorNormalSe");
	elseif HitType == DEX_DAMAGE_TYPE_SPELL then
		color = DEX_Get("DEX_ColorSkill");
		colorSe = DEX_Get("DEX_ColorSkillSe");
	elseif HitType == DEX_DAMAGE_TYPE_PERIODIC then
		if DEX_Get("DEX_ShowDamagePeriodic") ~= 1 then return;end
		color = DEX_Get("DEX_ColorPeriodic");
		colorSe = DEX_Get("DEX_ColorPeriodicSe");
	elseif HitType == DEX_DAMAGE_TYPE_HEALTH then
		if DEX_Get("DEX_ShowDamageHealth") ~= 1 then return;end
		color = DEX_Get("DEX_ColorHealth");
		colorSe = DEX_Get("DEX_ColorHealthSe");
	elseif HitType == DEX_DAMAGE_TYPE_PET then
		if DEX_Get("DEX_ShowDamagePet") ~= 1 then return;end
		color = DEX_Get("DEX_ColorPet");
		colorSe = color;
	elseif HitType == DEX_DAMAGE_TYPE_HONOR then
		color = DEX_Get("DEX_ColorSpec");
		colorSe = DEX_Get("DEX_ColorSpecSe");
	elseif HitType == DEX_DAMAGE_TYPE_MANA then
		color = DEX_Get("DEX_ColorMana");
		colorSe = DEX_Get("DEX_ColorManaSe");
	end
	return color,colorSe
end

function DEX_doAni(ani)
	if DEX_Get("DEX_ShowWithMess") == 1 then
		return
	end
	local Showicon,Showiconcrit,Showname,Shownamecrit,Shownamemiss,Showcriticon = 0, 0, 0, 0, 0,0
	local SetPos = "CENTER"
	local color,colorSe = DEX_SetColor(ani.lastupdate)
	local thetime = GetTime() - ani.starttime;
	local setalpha = 0
	if thetime <= AniRunTime and thetime > 0 then

		DEX_SetFontSize(ani,DEX_Get("DEX_FontSize"));

		if thetime < 0.1 then
			setalpha = thetime * 10;
		elseif thetime < 1 then
			setalpha = 1;
		else
			setalpha = 1 - (thetime - 1) * 2;
		end
		if ani.moveTyp == DEX_MOVTYP_NORMAL then
			ani.posY = thetime * DEX_Get("DEX_Speed") * 2.5 * ani.Extra + ani.baseY;
			ani.posYbak = ani.posY;
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_AOE then
			ani.posX = ani.Extra
			ani.posY = thetime * DEX_Get("DEX_Speed") * 2.5 * ani.Extra + ani.baseY;
			ani.posYbak = ani.posY;
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_OTHER then
			ani.posX = sin(thetime / 2.1 * 180) * 30 + 75;
		elseif ani.moveTyp == DEX_MOVTYP_ATTACK then
			ani.posY = thetime * DEX_Get("DEX_Speed") * 2.5 * ani.Extra + ani.baseY + DEX_Get("DEX_BeAttackPosY");
			if DEX_Get("DEX_ShowDamageType") == 1 then
				SetPos = "LEFT"
				ani.posX = (acos((AniRunTime - thetime)/2) / 30) * DEX_Get("DEX_Speed")+ DEX_Get("DEX_BeAttackPosX");
			else
				if DEX_Get("DEX_BeAttackPosX") > 0 then
					ani.posX = DEX_Get("DEX_Speed") * cos(thetime / 2 * DEX_Get("DEX_Speed")) + DEX_Get("DEX_BeAttackPosX");
				else
					ani.posX = DEX_Get("DEX_BeAttackPosX") - DEX_Get("DEX_Speed") * cos(thetime / 2 * DEX_Get("DEX_Speed"));
				end
			end
			ani.posYbak = ani.posY;
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_HEALTH then
			ani.posY = thetime * DEX_Get("DEX_Speed") * 2.5 * ani.Extra + ani.baseY + DEX_Get("DEX_HealthPosY");
			if DEX_Get("DEX_ShowHealthType") == 1 then
				SetPos = "RIGHT"
				ani.posX = DEX_Get("DEX_HealthPosX") - (acos((AniRunTime - thetime)/2) / 35) * DEX_Get("DEX_Speed");
			else
				if DEX_Get("DEX_HealthPosX") > 0 then
					ani.posX = DEX_Get("DEX_Speed") * cos(thetime / 2 * DEX_Get("DEX_Speed")) + DEX_Get("DEX_HealthPosX");
				else
					ani.posX = DEX_Get("DEX_HealthPosX") - DEX_Get("DEX_Speed") * cos(thetime / 2 * DEX_Get("DEX_Speed"));
				end
			end
			ani.posYbak = ani.posY;
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_PET then
			ani.posY = thetime * DEX_Get("DEX_Speed") * 2.5 * ani.Extra + ani.baseY + DEX_Get("DEX_PetPosY");
			ani.posYbak = ani.posY;
			ani.posX = DEX_Get("DEX_PetPosX");
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_NONE then
			if ani.HitType == "Begin" then
				ani.posY = DEX_TEXTSIZE * 5;
			elseif ani.HitType == "End" then
				ani.posY = DEX_TEXTSIZE * 4;
			end
		end

		if ani.crit == 1 then
			local baseSize = DEX_TEXTSIZE + 4 + ani.critId * 2;
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

		if ani.lastupdate == DEX_DAMAGE_TYPE_BEATTACK then
			Showicon = DEX_Get("DEX_ShowDamageSpellIcon")
			if Showicon == 1 then
				Showiconcrit = DEX_Get("DEX_ShowDamageSpellIconOnCrit")
			else
				Showiconcrit = 0
			end
			Showname = DEX_Get("DEX_ShowDamageSpellName")
			if Showname == 1 then
				Shownamecrit = DEX_Get("DEX_ShowDamageNameOnCrit")
			else
				Shownamecrit = 0
			end
			Shownamemiss = 0
			Showcriticon = 0
		elseif ani.lastupdate == DEX_DAMAGE_TYPE_HEALTH then
			Showicon = DEX_Get("DEX_ShowHealthSpellIcon")
			if Showicon == 1 then
				Showiconcrit = DEX_Get("DEX_ShowHealthSpellIconOnCrit")
			else
				Showiconcrit = 0
			end
			Showname = DEX_Get("DEX_ShowHealthSpellName")
			if Showname == 1 then
				Shownamecrit = DEX_Get("DEX_ShowHealthNameOnCrit")
			else
				Shownamecrit = 0
			end
			Shownamemiss = 0
			Showcriticon = 0
		elseif ani.lastupdate == DEX_DAMAGE_TYPE_PET then
			Showicon = 0
			Showiconcrit = 0
			Showname = 0
			Shownamecrit = 0
			Shownamemiss = 0
			Showcriticon = 0
		else
			Showicon = DEX_Get("DEX_ShowSpellIcon")
			if Showicon == 1 then
				Showiconcrit = DEX_Get("DEX_ShowSpellIconOnCrit")
			else
				Showiconcrit = 0
			end
			Showname = DEX_Get("DEX_ShowSpellName")
			if Showname == 1 then
				Shownamecrit = DEX_Get("DEX_ShowNameOnCrit")
				Shownamemiss = DEX_Get("DEX_ShowNameOnMiss")
				Showcriticon = DEX_Get("DEX_ShowDamageIconOnCrit")
			else
				Shownamecrit = 0
				Shownamemiss = 0
				Showcriticon = 0
			end
		end
		ani.FObject:ClearAllPoints()
		ani.FObject:SetPoint(SetPos, "UIParent", "CENTER", ani.posX + DEX_Get("DEX_PosX"), ani.posY + DEX_Get("DEX_PosY"));
		ani.FObject:SetTextHeight(ani.height);
		ani.FObject:SetTextColor(color[1], color[2], color[3]);
		if ani.setalpha == 1 then
			setalpha = 0
		end
		ani.FObject:SetAlpha(setalpha);
		ani.FObject:SetText(DEX_BuildText(ani.delay,ani.destbak,ani.crit,ani.HitType,ani.lastupdate,color,colorSe,Showicon,Showiconcrit,Showname,Shownamecrit,Shownamemiss,Showcriticon))
	else
		if thetime >= AniRunTime then DEX_aniClear(ani);end
	end
end

function DEX_aniClear(ani)
	if ani.crit == 1 then
		if ani.critId < DEX_critFlag then DEX_critFlag = ani.critId;end
	end
	DEX_aniReset(ani);
end

function DEX_BuildText(damage,spell,IsCrit,HitType,IsdexType,color,colorSe,showicon,showiconcrit,showname,shownamecrit,shownamemiss,showcriticon)
	if DEX_Get("DEX_NumberFormat") == 1 and (tonumber(damage) or string.find(damage,"-")) then
		if string.find(damage,"-") then
			local healstart = string.sub(damage, 1 , string.find(damage,"-") - 1)
			local healend = string.sub(damage, string.find(damage,"-") + 1, string.len(damage))
			if IsdexType == DEX_DAMAGE_TYPE_HEALTH then
				damage = amount_format(healstart).."("..amount_format(healend)..")"
			elseif IsdexType == DEX_DAMAGE_TYPE_BEATTACK  then
				damage = amount_format(healstart).."("..amount_format(healend)..")"
			else
				damage = amount_format(healstart).."("..amount_format(healend)..")"
			end
		else
			damage = amount_format(damage)
		end
	end
	damage = trim(damage)
	local SpellName = nil
	if select(1,GetSpellInfo(spell))~=nil then 
		SpellName = select(1,GetSpellInfo(spell))
	else
		SpellName = ""
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
					return damage..SpellName
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage,color,colorSe)..SpellName
				else
					return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..SpellName.."|r"
				end	
			else
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage,color,colorSe)
				else
					return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3]).."|r"
				end	
			end
		end
	end
	if showicon == 1 then
		if showiconcrit == 1 and IsCrit ~=1 then
			return damage
		end
		local icons = ""
		local iconsize = DEX_TEXTSIZE/(DEX_Get("DEX_IconSize")/6);
		if select(3,GetSpellInfo(spell))~=nil then 
			icons ="|T"..select(3,GetSpellInfo(spell))..":"..(iconsize / 2.5).."|t";
		else
			if DEX_Get("DEX_ColorMode") == 1 then
				if showname == 1 then 
					if shownamecrit == 1 then
						if IsCrit == 1 then
							return damage..SpellName
						else
							return damage
						end
					elseif shownamemiss == 1 then
						if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
							return damage..SpellName
						else
							return damage
						end
					else
						return damage..SpellName
					end
				else
					return damage
				end
			elseif DEX_Get("DEX_ColorMode") == 3 then
				if showname == 1 then 
					if shownamecrit == 1 then
						if IsCrit == 1 then
							return DEX_TranTxt(damage,color,colorSe)..SpellName
						else
							return DEX_TranTxt(damage,color,colorSe)
						end
					elseif shownamemiss == 1 then
						if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
							return DEX_TranTxt(damage,color,colorSe)..SpellName
						else
							return DEX_TranTxt(damage,color,colorSe)
						end
					else
						return DEX_TranTxt(damage,color,colorSe)..SpellName
					end
				else
					return DEX_TranTxt(damage,color,colorSe)
				end
			else
				if showname == 1 then 
					if shownamecrit == 1 then
						if IsCrit == 1 then
							return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..SpellName.."|r"
						else
							return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3]).."|r"
						end
					elseif shownamemiss == 1 then
						if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
							return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..SpellName.."|r"
						else
							return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3]).."|r"
						end
					else
						return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..SpellName.."|r"
					end
				else
					return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3]).."|r"
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
					return DEX_TranTxt(damage.." ",color,colorSe)..icons..SpellName
				end
			end
			if showname == 1 then 
				if shownamecrit == 1 then
					if IsCrit == 1 then
						if showcriticon ==1 then
							return DEX_TranTxt(damage.." ",color,colorSe)..icons
						else
							return DEX_TranTxt(damage.." ",color,colorSe)..icons..SpellName
						end
					else
						return DEX_TranTxt(damage.." ",color,colorSe)..icons
					end
				elseif shownamemiss == 1 then
					if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
						return DEX_TranTxt(damage.." ",color,colorSe)..icons..SpellName
					else
						return DEX_TranTxt(damage.." ",color,colorSe)..icons
					end
				else
					return DEX_TranTxt(damage.." ",color,colorSe)..icons..SpellName
				end
			else
				if HitType == "AURA_APPLIED" then
					return icons
				else
					return DEX_TranTxt(damage.." ",color,colorSe)..icons
				end
			end
		else
			if HitType == "INTERRUPT" then
				if DEX_Get("DEX_ShowInterruptCrit") == 1 then
					return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons..SpellName.."|r"
				end
			end
			if showname == 1 then 
				if shownamecrit == 1 then
					if IsCrit == 1 then
						if showcriticon ==1 then
							return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons.."|r"
						else
							return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons..SpellName.."|r"
						end
					else
						return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons.."|r"
					end
				elseif shownamemiss == 1 then
					if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
						return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons..SpellName.."|r"
					else
						return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons.."|r"
					end
				else
					return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons..SpellName.."|r"
				end
			else
				if HitType == "AURA_APPLIED" then
					return DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons.."|r"
				else
					return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons.."|r"
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
					return DEX_TranTxt(damage,color,colorSe)..SpellName
				end
			end
			return DEX_TranTxt(damage,color,colorSe)
		else
			if HitType == "INTERRUPT" then
				if DEX_Get("DEX_ShowInterruptCrit") == 1 then
					return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..SpellName.."|r"
				end
			end
			return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3]).."|r"
		end	
	else
		local icons = ""
		local iconsize = DEX_TEXTSIZE/(DEX_Get("DEX_IconSize")/5);
		if select(3,GetSpellInfo(spell))~=nil then 
			icons ="|T"..select(3,GetSpellInfo(spell))..":"..(iconsize / 2.5).."|t";
		end
		if HitType == "INTERRUPT" then
			if DEX_Get("DEX_ShowInterruptCrit") == 1 then
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage.." "..SpellName
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage.." "..SpellName,color,colorSe)
				else
					return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..SpellName.."|r"
				end	
			end
		end
		if shownamecrit == 1 then
			if IsCrit == 1 then
				if showcriticon == 1 then
					if DEX_Get("DEX_ColorMode") == 1 then
						return damage.." "..icons
					elseif DEX_Get("DEX_ColorMode") == 3 then
						return DEX_TranTxt(damage.." "..icons,color,colorSe)
					else
						return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons.."|r"
					end	
				else
					if DEX_Get("DEX_ColorMode") == 1 then
						return damage.." "..SpellName
					elseif DEX_Get("DEX_ColorMode") == 3 then
						return DEX_TranTxt(damage.." "..SpellName,color,colorSe)
					else
						return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..SpellName.."|r"
					end	
				end
			else
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage,color,colorSe)
				else
					return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3]).."|r"
				end	
			end
		elseif shownamemiss == 1 then
			if HitType == "SHIELD_MISSED" or HitType == "MISSED" then
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage.." "..SpellName
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage.." "..SpellName,color,colorSe)
				else
					return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..SpellName.."|r"
				end	
			else
				if DEX_Get("DEX_ColorMode") == 1 then
					return damage
				elseif DEX_Get("DEX_ColorMode") == 3 then
					return DEX_TranTxt(damage,color,colorSe)
				else
					return damage..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3]).."|r"
				end	
			end
		else
			if DEX_Get("DEX_ColorMode") == 1 then
				return damage.." "..SpellName
			elseif DEX_Get("DEX_ColorMode") == 3 then
				return DEX_TranTxt(damage.." "..SpellName,color,colorSe)
			else
				return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..SpellName.."|r"
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

function DEX_AddText(damage,spell,damagetype,crit,iscurTarget,coerciveShowSpell,TargetGUID,TargetName,HitType,SpellID,combattime,...)
	if ((HitType == "DAMAGE" and (damagetype == DEX_DAMAGE_TYPE_SPELL or damagetype == DEX_DAMAGE_TYPE_PERIODIC or damagetype == DEX_DAMAGE_TYPE_AOESPELL or damagetype == DEX_DAMAGE_TYPE_AOEDOT or damagetype == DEX_DAMAGE_TYPE_AOESHIELD  or damagetype == DEX_DAMAGE_TYPE_AOEHEALTH))  or (HitType == "SHIELD" and damagetype == DEX_DAMAGE_TYPE_SPELL)) and SpellID ~= nil and DEX_Get("DEX_UniteSpell") == 1 then
		if damagetype == DEX_DAMAGE_TYPE_AOESPELL then
			if DataTmpSpell.spellid ~= 0 then
				DEX_AddTextDo(DataTmpSpell.damage,DataTmpSpell.spell,DataTmpSpell.damagetype,DataTmpSpell.crit,DataTmpSpell.iscurTarget,DataTmpSpell.coerciveShowSpell,DataTmpSpell.TargetGUID,DataTmpSpell.TargetName,DataTmpSpell.HitType,DataTmpSpell.spellid,DataTmpSpell.StartTime)
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
			end
			return
		elseif damagetype == DEX_DAMAGE_TYPE_AOEDOT then
			if DataTmpDot.spellid ~= 0 then
				DEX_AddTextDo(DataTmpDot.damage,DataTmpDot.spell,DataTmpDot.damagetype,DataTmpDot.crit,DataTmpDot.iscurTarget,DataTmpDot.coerciveShowSpell,DataTmpDot.TargetGUID,DataTmpDot.TargetName,DataTmpDot.HitType,DataTmpDot.spellid,DataTmpDot.StartTime)
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
			end
			return
		elseif damagetype == DEX_DAMAGE_TYPE_AOEShield then
			if DataTmpShield.spellid ~= 0 then
				DEX_AddTextDo(DataTmpShield.damage,DataTmpShield.spell,DataTmpShield.damagetype,DataTmpShield.crit,DataTmpShield.iscurTarget,DataTmpShield.coerciveShowSpell,DataTmpShield.TargetGUID,DataTmpShield.TargetName,DataTmpShield.HitType,DataTmpShield.spellid,DataTmpShield.StartTime)
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
			end
			return
		elseif damagetype == DEX_DAMAGE_TYPE_AOEHEALTH then
			if DataTmpHealth.spellid ~= 0 then
				DEX_AddTextDo(DataTmpHealth.damage,DataTmpHealth.spell,DataTmpHealth.damagetype,DataTmpHealth.crit,DataTmpHealth.iscurTarget,DataTmpHealth.coerciveShowSpell,DataTmpHealth.TargetGUID,DataTmpHealth.TargetName,DataTmpHealth.HitType,DataTmpHealth.spellid,DataTmpHealth.StartTime)
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
				DataTmpSpell.iscurTarget = iscurTarget
				DataTmpSpell.coerciveShowSpell = coerciveShowSpell
				DataTmpSpell.TargetGUID = TargetGUID
				DataTmpSpell.TargetName = TargetName
				DataTmpSpell.HitType = HitType
				DataTmpSpell.spellid = SpellID
				DataTmpSpell.StartTime = combattime
			else
				if DiffSpell(DataTmpSpell.spellid,SpellID) then
					DataTmpSpell.damage = DataTmpSpell.damage + tonumber(damage)
					if crit == 1 then
						DataTmpSpell.crit = crit
					end
					return
				else
					DataTmpSpell.StartTime = GetTime()
	DEX_AddTextDo(DataTmpSpell.damage,DataTmpSpell.spell,DataTmpSpell.damagetype,DataTmpSpell.crit,DataTmpSpell.iscurTarget,DataTmpSpell.coerciveShowSpell,DataTmpSpell.TargetGUID,DataTmpSpell.TargetName,DataTmpSpell.HitType,DataTmpSpell.spellid,DataTmpSpell.StartTime)
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
					DataTmpSpell.HitType = HitType
					DataTmpSpell.spellid = SpellID
					DataTmpSpell.StartTime = combattime
				end
			end
		elseif damagetype == DEX_DAMAGE_TYPE_PERIODIC then
			if DataTmpDot.spellid == 0 then
				DataTmpDot.damage = tonumber(damage)
				DataTmpDot.spell = spell
				DataTmpDot.damagetype =damagetype
				if crit == 1 then
					DataTmpDot.crit = crit
				end
				DataTmpDot.iscurTarget = iscurTarget
				DataTmpDot.coerciveShowSpell = coerciveShowSpell
				DataTmpDot.TargetGUID = TargetGUID
				DataTmpDot.TargetName = TargetName
				DataTmpDot.HitType = HitType
				DataTmpDot.spellid = SpellID
				DataTmpDot.StartTime = combattime
			else
				if DiffSpell(DataTmpDot.spellid,SpellID) then
					DataTmpDot.damage = DataTmpDot.damage + tonumber(damage)
					if crit == 1 then
						DataTmpDot.crit = crit
					end
					return
				else
					DataTmpDot.StartTime = GetTime()
					DEX_AddTextDo(DataTmpDot.damage,DataTmpDot.spell,DataTmpDot.damagetype,DataTmpDot.crit,DataTmpDot.iscurTarget,DataTmpDot.coerciveShowSpell,DataTmpDot.TargetGUID,DataTmpDot.TargetName,DataTmpDot.HitType,DataTmpDot.spellid,DataTmpDot.StartTime)
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
					DataTmpDot.HitType = HitType
					DataTmpDot.spellid = SpellID
					DataTmpDot.StartTime = combattime
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
				DataTmpHealth.HitType = HitType
				DataTmpHealth.spellid = SpellID
				DataTmpHealth.StartTime = combattime
			else
				if DiffSpell(DataTmpHealth.spellid,SpellID) then
					DataTmpHealth.damage = DataTmpHealth.damage + tonumber(damage)
					if crit == 1 then
						DataTmpHealth.crit = crit
					end
					return
				else
					DataTmpHealth.StartTime = GetTime()
					DEX_AddTextDo(DataTmpHealth.damage,DataTmpHealth.spell,DataTmpHealth.damagetype,DataTmpHealth.crit,DataTmpHealth.iscurTarget,DataTmpHealth.coerciveShowSpell,DataTmpHealth.TargetGUID,DataTmpHealth.TargetName,DataTmpHealth.HitType,DataTmpHealth.spellid,DataTmpHealth.StartTime)
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
					DataTmpHealth.HitType = HitType
					DataTmpHealth.spellid = SpellID
					DataTmpHealth.StartTime = combattime
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
				DataTmpShield.HitType = HitType
				DataTmpShield.spellid = SpellID
				DataTmpShield.StartTime = combattime
			else
				if DiffSpell(DataTmpShield.spellid,SpellID) then
					DataTmpShield.damage = DataTmpShield.damage + tonumber(damage)
					if crit == 1 then
						DataTmpShield.crit = crit
					end
					return
				else
					DataTmpShield.StartTime = GetTime()
					DEX_AddTextDo(DataTmpShield.damage,DataTmpShield.spell,DataTmpShield.damagetype,DataTmpShield.crit,DataTmpShield.iscurTarget,DataTmpShield.coerciveShowSpell,DataTmpShield.TargetGUID,DataTmpShield.TargetName,DataTmpShield.HitType,DataTmpShield.spellid,DataTmpShield.StartTime)
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
					DataTmpShield.HitType = HitType
					DataTmpShield.spellid = SpellID
					DataTmpShield.StartTime = combattime
				end
			end
		end
	else
		DEX_AddTextDo(damage,spell,damagetype,crit,iscurTarget,coerciveShowSpell,TargetGUID,TargetName,HitType,SpellID,combattime)
	end
end

function TimeCheck(time1,time2,movetype)
	if time1 == 0 or DEX_Get("DEX_ShowWithMess") == 1 or DEX_Get("DEX_UniteSpell") ~= 1 or DEX_Get("DEX_AdjustTime") ~= 1 then
		return time2
	end
	local time3 = 0
	if movetype == DEX_MOVTYP_ATTACK then
		if DEX_Get("DEX_ShowDamageType") == 1 then
			if (time2 - time1) < (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed")) then
				time3 = time1 + (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed"))
			else
				time3 = time2
			end
		else
			if (time2 - time1) < (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed")) then
				time3 = time1 + (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed"))
			else
				time3 = time2
			end
		end
	elseif movetype == DEX_MOVTYP_HEALTH then
		if DEX_Get("DEX_ShowHealthType") == 1 then
			if (time2 - time1) < (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed")) then
				time3 = time1 + (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed"))
			else
				time3 = time2
			end
		else
			if (time2 - time1) < (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed")) then
				time3 = time1 + (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed"))
			else
				time3 = time2
			end
		end
	elseif movetype == DEX_MOVTYP_PET then
		if (time2 - time1) < (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed")) then
			time3 = time1 + (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed"))
		else
			time3 = time2
		end
	else
		if (time2 - time1) < (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed")) then
			time3 = time1 + (DEX_TEXTSIZE + 2)/(2.5 * DEX_Get("DEX_Speed"))
		else
			time3 = time2
		end
	end
	if (GetTime() - time3) <0 and abs(GetTime() - time3) >= AniRunTime * 2 and DEX_Get("DEX_AdjustTime") == 1 then
		if movetype == DEX_MOVTYP_ATTACK then
			for key, value in pairs(dex_AniData) do
				if value.Active and value.starttime>0 and GetTime() - value.starttime < AniRunTime * 2 and value.moveTyp == DEX_MOVTYP_ATTACK then
					dex_AniData[key].starttime = value.starttime + (GetTime() - time3);
					if GetTime() - value.starttime < AniRunTime then
						dex_AniData[key].alpha = 1;
					end
				end
			end
		elseif movetype == DEX_MOVTYP_HEALTH then
			for key, value in pairs(dex_AniData) do
				if value.Active and value.starttime>0 and GetTime() - value.starttime < AniRunTime * 2 and value.moveTyp == DEX_MOVTYP_HEALTH then
					dex_AniData[key].starttime = value.starttime + (GetTime() - time3);
					if GetTime() - value.starttime < AniRunTime then
						dex_AniData[key].alpha = 1;
					end
				end
			end
		elseif movetype == DEX_MOVTYP_PET then
			for key, value in pairs(dex_AniData) do
				if value.Active and value.starttime>0 and GetTime() - value.starttime < AniRunTime * 2 and value.moveTyp == DEX_MOVTYP_PET then
					dex_AniData[key].starttime = value.starttime + (GetTime() - time3);
					if GetTime() - value.starttime < AniRunTime then
						dex_AniData[key].alpha = 1;
					end
				end
			end
		else
			for key, value in pairs(dex_AniData) do
				if value.Active and value.starttime>0 and GetTime() - value.starttime < AniRunTime * 2 and value.moveTyp == DEX_MOVTYP_NORMAL then
					dex_AniData[key].starttime = value.starttime + (GetTime() - time3);
					if GetTime() - value.starttime < AniRunTime then
						dex_AniData[key].alpha = 1;
					end
				end
			end
		end
		return time2
	end
	return time3
end

function DEX_AddTextDo(damage,spell,damagetype,crit,iscurTarget,coerciveShowSpell,TargetGUID,TargetName,HitType,SpellID,combattime,...)
	if spell and (damage == "0" or (tonumber(damage) and tonumber(damage) == 0)) then
		damage = ""
	end
	if spell == nil and damage == nil then
		return
	end
	if spell == nil then spell = "";end
	if damage == nil then damage = "";end

	if DEX_Get("DEX_ShowWithMess") == 1 then
		local Maxline = DEX_logLine;
		local anitmp;
		local color,colorSe = DEX_SetColor(damagetype)
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
		if DEX_Get("DEX_NumberFormat") == 1 and (tonumber(damage) or string.find(damage,"-")) then
			if string.find(damage,"-") then
				local healstart = string.sub(damage, 1 , string.find(damage,"-") - 1)
				local healend = string.sub(damage, string.find(damage,"-") + 1, string.len(damage))
				if damagetype == DEX_DAMAGE_TYPE_HEALTH then
					damage = amount_format(healstart).."("..amount_format(healend)..")"
				elseif damagetype == DEX_DAMAGE_TYPE_BEATTACK  then
					damage = amount_format(healstart).."("..amount_format(healend)..")"
				else
					damage = amount_format(healstart).."("..amount_format(healend)..")"
				end
			else
				damage = amount_format(damage)
			end
		end
		if crit == 1 then damage = DEX_TXT_CRIT..damage; end
		anitmp.FObject:SetText(damage.." "..spell);
		anitmp.FObject:SetAlpha(1);
		anitmp.FObject:SetTextColor(color[1], color[2], color[3]);
		anitmp.FObject:SetPoint("CENTER", "UIParent", "CENTER", anitmp.posX + DEX_Get("DEX_PosX"), anitmp.posY + DEX_Get("DEX_PosY"));
		dex_lastani = dex_lastani + 1;
		if dex_lastani > DEX_logLine then
			dex_lastani = 1
		end
		return
	end

	local ani = dex_AniData["aniText"..dex_lastani]
	DEX_aniReset(ani)
	ani.Active = true
	ani.height = DEX_TEXTSIZE;
	ani.crit = crit;
	ani.uid = DEX_ANI_UID
	ani.starttime = combattime
	ani.Extra = 1

	if not iscurTarget and  damagetype ~= DEX_DAMAGE_TYPE_PET and ani.moveTyp ~= DEX_MOVTYP_AOE then
		ani.moveTyp = DEX_MOVTYP_OTHER
		ani.posY = DEX_GetMovTypOtherPosY()
		ani.posYbak = ani.posY
	end

	if (HitType == "DAMAGE" or HitType == "SHIELD" or HitType == "DISPEL" or HitType == "STOLEN" or HitType == "MISSED" or HitType == "SPELL_MISSED") and (damagetype ~= DEX_DAMAGE_TYPE_PET and damagetype ~= DEX_DAMAGE_TYPE_BEATTACK and damagetype ~= DEX_DAMAGE_TYPE_HEALTH) then
		ani.moveTyp = DEX_MOVTYP_NORMAL
		ani.starttime = TimeCheck(TimeTmp.NT,ani.starttime,DEX_MOVTYP_NORMAL)
		TimeTmp.NT = ani.starttime
	end

	if damagetype == DEX_DAMAGE_TYPE_PET then
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
		ani.starttime = TimeCheck(TimeTmp.PT,ani.starttime,DEX_MOVTYP_PET)
		TimeTmp.PT = ani.starttime
	end

	if damagetype == DEX_DAMAGE_TYPE_HONOR then
		ani.critTyp = 1
		ani.zoom = 1.35;
		ani.moveTyp = DEX_MOVTYP_NONE;
	end

	if damagetype == DEX_DAMAGE_TYPE_BEATTACK then
		if DEX_Get("DEX_BeAttackPosY") == 0 and DEX_Get("DEX_BeAttackPosX") == 0 then
			ani.moveTyp = DEX_MOVTYP_NORMAL
			ani.starttime = TimeCheck(TimeTmp.NT,ani.starttime,DEX_MOVTYP_NORMAL)
			TimeTmp.NT = ani.starttime
		else
			ani.moveTyp = DEX_MOVTYP_ATTACK
			ani.starttime = TimeCheck(TimeTmp.AT,ani.starttime,DEX_MOVTYP_ATTACK)
			TimeTmp.AT = ani.starttime
		end
	end
	if damagetype == DEX_DAMAGE_TYPE_HEALTH then
		if DEX_Get("DEX_HealthPosY") == 0 and DEX_Get("DEX_HealthPosX") == 0 then
			ani.moveTyp = DEX_MOVTYP_NORMAL
			ani.starttime = TimeCheck(TimeTmp.NT,ani.starttime,DEX_MOVTYP_NORMAL)
			TimeTmp.NT = ani.starttime
		else
			ani.moveTyp = DEX_MOVTYP_HEALTH
			ani.starttime = TimeCheck(TimeTmp.HT,ani.starttime,DEX_MOVTYP_HEALTH)
			TimeTmp.HT = ani.starttime
		end
	end
	if ani.crit == 1 then
		if damagetype ~= DEX_DAMAGE_TYPE_PET then
			if spell == "" then
				ani.zoom = 2;
			else
				ani.zoom = 0.6;
			end
		else
			ani.zoom = 1.5;
		end
		if DEX_Get("DEX_ShowSpellName") == 1 and DEX_Get("DEX_ShowNameOnCrit") == 1 and spell ~= "" then
			ani.zoom = 0.8;
		else
			ani.critTyp = 1;
		end
		if damagetype ~= DEX_DAMAGE_TYPE_PET then
			ani.critId = DEX_critFlag;
			ani.posYbak = ani.posY;

			DEX_critFlag = DEX_critFlag + 1;
			if DEX_critFlag > 3 then DEX_critFlag = 0;end
		end
	end

	ani.delay = damage
	ani.spellbak = spell
	ani.lastupdate = damagetype
	if HitType == "INTERRUPT" or HitType == "DISPEL" or HitType == "STOLEN" then
		if tonumber(extraSpellId) then
			ani.destbak = tonumber(extraSpellId)
		else
			ani.destbak = nil
		end
		ani.spellbak = extraSpellName
	else
		if tonumber(SpellID) then
			ani.destbak = tonumber(SpellID)
		else
			ani.destbak = nil
		end
	end
	if (HitType == "DAMAGE" and damagetype == DEX_DAMAGE_TYPE_HIT)  or (damagetype == DEX_DAMAGE_TYPE_BEATTACK and SpellID == nil) or SpellID == nil then
		ani.destbak = nil
		ani.spellbak = ""
	end

	ani.HitType = HitType
	if damagetype == DEX_DAMAGE_TYPE_HIT and SpellID ~= 0 then
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
	for key, value in pairs(dex_AniData) do
		value.FObject = getglobal("DEX"..key);
		DEX_aniReset(value);
	end
	DEX_Set_WOWDamage();
end

function DEX_staticInit()
	DEX_logLine = DEX_Get("DEX_LOGLINE");
	DEX_logTime = DEX_Get("DEX_LOGTIME");
end

function DEX_aniReset(aniData)
	aniData.Active = false;
	aniData.crit = false;
	aniData.starttime = 0
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
	aniData.spellbak = "";
	aniData.damagebak = 0;
	aniData.destbak = 0;
	aniData.HitType = "";

	DEX_SetFontSize(aniData,DEX_TEXTSIZE)
	aniData.FObject:SetText("");
	aniData.FObject:SetTextHeight(aniData.height);
	aniData.FObject:SetAlpha(aniData.alpha);
	aniData.FObject:SetPoint("CENTER", "UIParent", "CENTER", aniData.posX, aniData.posY);
end

function DEX_SetFontSize(ani,size)
	ani.FObject:SetFont(DEX_FONTNAME, size,DEX_OUTLINE);
	ani.FObject:SetShadowOffset(DEX_SHADOW,-DEX_SHADOW);
end

function DEX_Set_WOWDamage()
	if DEX_Get("DEX_Enable") == 1 then
		SetCVar("floatingCombatTextCombatDamage", 0);
		SetCVar("floatingCombatTextCombatHealing", 0);
		SetCVar("floatingCombatTextPetMeleeDamage", 0)   	 --寵物對目標傷害
		SetCVar("floatingCombatTextPetSpellDamage", 0)   	 --寵物對目標傷害
	else
		SetCVar("floatingCombatTextCombatDamage", 1);
		SetCVar("floatingCombatTextCombatHealing", 1);
		SetCVar("floatingCombatTextPetMeleeDamage", 1)   	 --寵物對目標傷害
		SetCVar("floatingCombatTextPetSpellDamage", 1)   	 --寵物對目標傷害
	end
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