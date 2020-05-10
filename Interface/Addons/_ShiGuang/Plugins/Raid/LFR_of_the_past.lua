
local MAJOR, MINOR = "LibColors-1.0", 107
local lib = LibStub:NewLibrary(MAJOR, MINOR)
local _G,string,match,tonumber,rawset,type = _G,string,match,tonumber,rawset,type
local hex = "%02x";

if not lib then return end

lib.num2hex = function(num)
	return hex:format( (tonumber(num) or 0)*255 );
end

lib.colorTable2HexCode = function(cT)
	local _ = lib.num2hex;
	return _(cT[4] or cT["a"] or 1).._(cT[1] or cT["r"] or 1).._(cT[2] or cT["g"] or 1).._(cT[3] or cT["b"] or 1);
end

lib.hexCode2ColorTable = function(colorStr)
	local codes = {string.sub(colorStr,3,4), string.sub(colorStr,5,6), string.sub(colorStr,7,8), string.sub(colorStr,1,2)};
	for i,v in pairs(codes) do
		v = string.format("%d","0x"..v);
		if v~=0 then
			codes[i] = ((100/255) * v) / 100;
		end
	end
	return codes;
end

lib.colorset = setmetatable({},{
	__index=function(t,k)
		if k:find("^%x+$") then
			return k;
		end
		return "ffffffff"; -- fallback color
	end,
	__call=function(t,a,b)
		assert(type(a)=="string" or type(a)=="table","Usage: lib.colorset(<string|table>[, <string>])");

		if type(a)=="table" then
			for i,v in pairs(a) do
				if type(i)=="string" and (type(v)=="string" or type(v)=="table") then
					lib.colorset(i,v);
				end
			end
			return;
		end

		if type(b)=="table" then
			b = lib.colorTable2HexCode(b);
		end

		if type(b)=="string" then
			rawset(t,a,strrep("f",8-strlen(b))..b);
			return;
		end
		return;
	end
})

lib.color = function(reqColor, str)
	local Str,color = tostring(str);
	assert(type(reqColor)=="string" or type(reqColor)=="table","Usage: lib.color(<string|table>[, <string>])")

	-- empty string don't need color
	if Str=="" then
		return "";
	end

	-- convert table to string
	if type(reqColor)=="table" then
		reqColor = lib.colorTable2HexCode(reqColor)

	-- or replace special color keywords
	elseif reqColor=="playerclass" then
		reqColor = UnitName("player")
	end

	-- get color code from lib.colorset
	color = lib.colorset[reqColor:lower()]

	if not color:find("^%x+$") then
		color = lib.colorset.white;
	end

	 -- return color as color table
	if str=="colortable" then
		return lib.hexCode2ColorTable(color)
	end

	-- return string with color or color code
	return (str==nil and color) or ("|c%s%s|r"):format(color, Str)
end

lib.getNames = function(pattern)
	local names,_ = {}
	for name,_ in pairs(lib.colorset) do
		if pattern==nil or (pattern~=nil and name:match(pattern)) then
			tinsert(names,name)
		end
	end
	return names
end

do --[[ basic set of colors ]]
	local tmp = {
		-- basic colors
		yellow = "ffff00",
		orange = "ff8000",
		red    = "ff0000",
		violet = "ff00ff",
		blue   = "0000ff",
		cyan   = "00ffff",
		green  = "00ff00",
		black  = "000000",
		gray   = "808080",
		white  = "ffffff",
		-- wow money colors
		money_gold   = "ffd700",
		money_silver = "eeeeef",
		money_copper = "f0a55f",
	};

	-- add class names with english and localized names
	for n, c in pairs(CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS) do
		tmp[n:lower()] = c.colorStr;
		if LOCALIZED_CLASS_NAMES_MALE[n] then
			tmp[LOCALIZED_CLASS_NAMES_MALE[n]:lower()] = c.colorStr;
		end
		if LOCALIZED_CLASS_NAMES_FEMALE[n] then
			tmp[LOCALIZED_CLASS_NAMES_FEMALE[n]:lower()] = c.colorStr;
		end
	end

	-- add item quality colors [currently from -1 to 7]
	for i,v in pairs(_G.ITEM_QUALITY_COLORS) do
		tmp["quality"..i] = v;
		if (_G["ITEM_QUALITY"..i.."_DESC"]) then
			tmp[_G["ITEM_QUALITY"..i.."_DESC"]:lower()] = v;
		end
	end

	lib.colorset(tmp)
end

--[[ space for more colors later... ]]



local LFRofthepast = {};
LFRofthepast.npcID = {};
LFRofthepast.npcs = {};

function LFRofthepast.npcs_update()
	local faction = LFRofthepast.faction(); --UnitFactionGroup("player")=="Alliance";

	-- {<npcis>, <zoneid>, <posX>, <posY>, <expansionNumber>, <instanceType>}
	-- expansionNumber is for _G["EXPANSION_NAME"..<expansionNumber>]
	LFRofthepast.npcs = {
		-- cata
		{80675,74,63.1,27.3,3,"LFR",imgs={"cata1","cata2","cata3","cata4"}},
		-- mop
		--{78709,390,82.95,30.38,4,"SZN"}, -- szenarios
		--{78777,390,83.05,30.48,4,"SZHC"}, -- hc szenarios
		{80633,390,83.16,30.56,4,"LFR",imgs={"mop1","mop2","mop3"}}, -- lfr
		-- WoD, lfr (same npc id and different location for alliance and horde)
		faction=="alliance"
			and {94870,582,33.2,37.2,5,"LFR",imgs={"wod1_"..faction,"wod2_"..faction,"wod3_"..faction}}
			or {94870,590,41.5,47.0,5,"LFR",imgs={"wod1_"..faction,"wod2_"..faction,"wod3_"..faction}},
		-- legion
		{111246,627,63.6,55.6,6,"LFR",imgs={"legion1","legion2","legion3"}},
		-- bfa
		-- {00000,0000,0,0,7,"LFR"}, -- coming soon // 8.1 ?
	};

	wipe(LFRofthepast.npcID);

	for i=1, #LFRofthepast.npcs do
		local strs = LFRofthepast.scanTT:GetStringRegions("SetHyperlink","unit:Creature-0-0-0-0-"..LFRofthepast.npcs[i][1].."-0");
		LFRofthepast.npcID[LFRofthepast.npcs[i][1]]=1;
		if strs[1] and strs[1]~="" then
			LFRofthepast.npcs[i][1] = strs[1];  --L["NPC"..LFRofthepast.npcs[i][1]]
		end

		local mapInfo = C_Map.GetMapInfo(LFRofthepast.npcs[i][2]);
		if mapInfo then
			if mapInfo.name == DUNGEON_FLOOR_DALARANCITY1 then
				local spell = GetSpellInfo(224869);
				local _,target = strsplit(HEADER_COLON,spell,2);
				if target then
					mapInfo.name = target:trim(); -- replace "Dalaran" by "Dalaran - Broken Isles"
				end
			end
			LFRofthepast.npcs[i].zoneName = mapInfo.name;
		end
	end
end

LFRofthepast.instance2bosses = {
	-- cata
	[416]={1,2,3,4},[417]={5,6,7,8},
	-- mop
	[527]={1,2,3},[528]={4,5,6}, -- 1
	[529]={1,2,3},[530]={4,5,6}, -- 2
	[610]={1,2,3},[611]={4,5,6},[612]={7,8,9},[613]={10,11,12}, -- 3
	[716]={1,2,4},[717]={5,6,7,8},[724]={9,10,11},[725]={12,13,14}, -- 4
	-- wod
	[849]={1,2,3},[850]={4,5,6},[851]={7},  -- 1
	[847]={1,2,7},[846]={3,8,5},[848]={4,6,9},[823]={10}, -- 2
	[982]={1,2,3},[983]={4,5,6},[984]={7,8,11},[985]={9,10,12},[986]={13}, -- 3
	-- legion
	[1287]={1,5,3},[1288]={2,4,6},[1289]={7}, -- 1
	[1290]={1,2,3},[1291]={4,8,6},[1292]={5,7,9},[1293]={10}, -- 2
	[1411]={1,2,3}, -- 3
	[1494]={1,3,5},[1495]={2,4,6},[1496]={7,8},[1497]={9}, -- 4
	[1610]={1,2,3},[1611]={4,5,6},[1612]={7,8,9},[1613]={10,11}, -- 5
	-- bfa
	--[1731]={1,2,3},[1732]={4,5,6},[1733]={7,8}, -- Uldir
	--[1945]={1,2,3},[1946]={4,5,6},[1947]={7,8}, -- dazar'alor
	-- eternal palace
	-- ?
};

LFRofthepast.noSubtitle = { -- by npc id
	[78709]=1,
	[78777]=1,
};

LFRofthepast.gossip2instance = {
	-- [<npcID>] = { <instanceIDs> }
	-- cata
	[80675] = {416,417}, -- lfr
	-- mop
	[78709] = {492,499,504,511,517,539,542,593,586,589,590,588,624,625,637}, -- szenarios (not lfr but usefull for somebody ^_^)
	[78777] = {652,647,649,646,639,648}, -- heroic szenarios (not lfr but usefull for somebody ^_^)
	[80633] = {527,528,529,530,526,610,611,612,613,716,717,724,725}, -- lfr
	-- wod
	[94870] = {849,850,851,847,846,848,823,982,983,984,985,986}, -- lfr
	-- legion
	[111246] = {1287,1288,1289,1290,1291,1292,1293,1411,1494,1495,1496,1497,1610,1611,1612,1613}, -- lfr
	-- bfa
	--[0] = {1731,1732,1733,1945,1946,1947,1951},
};

LFRofthepast.lfrID = {
	416,417, -- cata
	527,528,529,530,526,610,611,612,613,716,717,724,725, -- mop
	849,850,851,847,846,848,823,982,983,984,985,986, -- wod
	1287,1288,1289,1411,1290,1291,1292,1293,1494,1495,1496,1497,1610,1611,1612,1613, -- legion
	-- 1731,1732,1733,1945,1946,1947,1951, -- bfa

}



-- bosskill tracking das am mittwoch zurückgesetzt wird.
-- broker und optionpanel seite mit namen und orten wo die npcs zu finden sind.
local realm,character,faction = GetRealmName();
local buttons,hookedButton,died,NPC_ID = {},{},{},false,(UnitGUID("target"));
local name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, texture = 1,2,3,4,5,6,7,8,9,10,11; -- GetLFGDungeonInfo
local difficulty, maxPlayers, description, isHoliday, bonusRepAmount, minPlayers, isTimeWalker, name2, minGearLevel = 12,13,14,15,16,17,18,19,20; -- GetLFGDungeonInfo
local iconTexCoords,killedEncounter,BossKillQueryUpdate,UpdateInstanceInfoLock,currentInstance = {},{},false,false,{};
local pat = {
	RAID_INSTANCE_WELCOME = _G.RAID_INSTANCE_WELCOME_LOCKED:gsub("%%s","(.*)"),
	RAID_INSTANCE_WELCOME_LOCKED = _G.RAID_INSTANCE_WELCOME_LOCKED:gsub("%%s","(.*)")
};

local LC = LibStub("LibColors-1.0");
local C = LC.color;
LC.colorset({
	["ltyellow"]	= "fff569",
	["dkyellow"]	= "ffcc00",
	["ltorange"]	= "ff9d6a",
	["dkorange"]	= "905d0a",
	["ltred"]		= "ff8080",
	["dkred"]		= "800000",
	["violet"]		= "f000f0",
	["ltviolet"]	= "f060f0",
	["dkviolet"]	= "800080",
	["ltblue"]		= "69ccf0",
	["dkblue"]		= "000088",
	["dailyblue"]	= "00b3ff",
	["ltcyan"]		= "80ffff",
	["dkcyan"]		= "008080",
	["ltgreen"]		= "80ff80",
	["dkgreen"]		= "00aa00",
	["dkgray"]		= "404040",
	["gray2"]		= "A0A0A0",
	["ltgray"]		= "b0b0b0",
	["gold"]		= "ffd700",
	["silver"]		= "eeeeef",
	["copper"]		= "f0a55f",
	["unknown"]		= "ee0000",
});

local bossIs = {
	--dead="|Tinterface/minimap/ObjectIconsAtlas: |t "..C("gray","%s"),
	--alive="|Tinterface\\lfgframe\\ui-lfg-icon-heroic:12:12:0:0:32:32:0:16:0:16|t "..C("ltyellow","%s")
	dead="|Tinterface/questtypeicons:18:18:0:0:128:64:108:126:18:36|t"..C("gray","%s"),
	alive="|Tinterface/questtypeicons:18:18:0:0:128:64:0:18:36:54|t"..C("ltyellow","%s")
}

do
	local colors = {"0099ff","00ff00","ff6060","44ffff","ffff00","ff8800","ff44ff","ffffff"};
	local function colorize(...)
		local t,c,a1 = {tostringall(...)},1,...;
		if type(a1)=="boolean" then tremove(t,1); end
		if a1~=false then
			tinsert(t,1,"|cff0099ff"..((a1==true and "LFRotp") or (a1=="||" and "||") or "_ShiGuang").."|r"..(a1~="||" and HEADER_COLON or ""));
			c=2;
		end
		for i=c, #t do
			if not t[i]:find("\124c") then
				t[i],c = "|cff"..colors[c]..t[i].."|r", c<#colors and c+1 or 1;
			end
		end
		return unpack(t);
	end
end

------------------------------------------------
-- GameTooltip to get localized names and other informations

LFRofthepast.scanTT = CreateFrame("GameTooltip","_ShiGuang_ScanTT",UIParent,"GameTooltipTemplate");
LFRofthepast.scanTT:SetScale(0.0001); LFRofthepast.scanTT:SetAlpha(0); LFRofthepast.scanTT:Hide();
-- unset script functions shipped by GameTooltipTemplate to prevent errors
for _,v in ipairs({"OnLoad","OnHide","OnTooltipAddMoney","OnTooltipSetDefaultAnchor","OnTooltipCleared"})do LFRofthepast.scanTT:SetScript(v,nil); end

function LFRofthepast.scanTT:GetStringRegions(dataFunction,...)
	if type(self[dataFunction])~="function" then return false; end

	LFRofthepast.scanTT:SetOwner(UIParent,"ANCHOR_NONE");
	self[dataFunction](self,...);
	LFRofthepast.scanTT:Show();

	local regions,strs = {LFRofthepast.scanTT:GetRegions()},{};
	for i=1,#regions do
		if (regions[i]~=nil) and (regions[i]:GetObjectType()=="FontString") then
			str = (regions[i]:GetText() or ""):trim();
			if str~="" then
				tinsert(strs,str);
			end
		end
	end

	LFRofthepast.scanTT:Hide();
	return strs;
end

------------------------------------------------

function LFRofthepast.faction(isNeutral)
	faction = (UnitFactionGroup("player") or "neutral"):lower();
	if isNeutral then
		return faction=="neutral";
	end
	return faction;
end

local function IsInstance()
	local _, _, difficulty = GetInstanceInfo();
	return difficulty==7 or difficulty==17;
end

local function RequestRaidInfoUpdate()
	if BossKillQueryUpdate then
		RequestRaidInfo();
	end
end

local function ScanSavedInstances()
	for index=1, (GetNumSavedInstances()) do
		local tmp, instanceName, _, instanceReset, instanceDifficulty, _, _, _, isRaid, _, difficultyName, numEncounters, encounterProgress = {}, GetSavedInstanceInfo(index);
		if (instanceDifficulty==7 or instanceDifficulty==17) and encounterProgress>0 and instanceReset>0 then
			local encounters,strs = {},LFRofthepast.scanTT:GetStringRegions("SetInstanceLockEncountersComplete",index);
			for i=2, #strs, 2 do
				encounters[strs[i]] = strs[i+1]==BOSS_DEAD;
			end
			killedEncounter[instanceName.."-"..instanceDifficulty] = encounters;
		end
	end
	UpdateInstanceInfoLock = false;
end

local function GetEncounterStatus(instanceID)
	local encounter,num = {},GetLFGDungeonNumEncounters(instanceID);
	local instanceInfo = {GetLFGDungeonInfo(instanceID)};
	local instanceTag = instanceInfo[name2].."-"..instanceInfo[difficulty];
	for i=1, num do
		local boss, _, isKilled = GetLFGDungeonEncounterInfo(instanceID,i);
		if not isKilled and killedEncounter[instanceTag] and killedEncounter[instanceTag][boss] then
			isKilled = true;
		end
		tinsert(encounter,{boss,isKilled});
	end
	return encounter;
end

local instanceGroupsBuild = false;
local InstanceGroups = setmetatable({},{
	__index = function(t,k)
		if not instanceGroupsBuild then -- build group list
			local current;
			for i=1, #LFRofthepast.lfrID do
				local name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, textureFilename, difficulty, maxPlayers, description, isHoliday, bonusRepAmount, minPlayers, isTimeWalker, name2, minGearLevel = GetLFGDungeonInfo(LFRofthepast.lfrID[i])
				if not rawget(t,name2) then
					rawset(t,name2,{});
					if name2==k then
						current = t[name2];
					end
				end
				tinsert(t[name2],{LFRofthepast.lfrID[i],name});
			end
			instanceGroupsBuild = true;
			return current or false;
		end
		return false;
	end
});

------------------------------------------------------- GossipFrame entries

local function buttonHook_OnEnter(self)
	if not NPC_ID then return end

	local buttonID = self:GetID();
	if buttonID and buttons[buttonID] then
		GameTooltip:SetOwner(self,"ANCHOR_NONE");
		GameTooltip:SetPoint("LEFT",GossipFrame,"RIGHT");

		-- instance name
		GameTooltip:AddLine(buttons[buttonID].instance[name]);

		-- instance group name (for raids splitted into multible lfr instances)
		if not LFRofthepast.noSubtitle[NPC_ID] and buttons[buttonID].instance[name]~=buttons[buttonID].instance[name2] then
			GameTooltip:AddLine(C("gray",buttons[buttonID].instance[name2]));
		end

		-- instance description
		if buttons[buttonID].instance[description] and buttons[buttonID].instance[description]~="" then
			GameTooltip:AddLine(buttons[buttonID].instance[description],1,1,1,1);
		end

		-- instance encounter list
		--	tinsert(bossIndexes,i);
		--end
		local bosses = {};
		if LFRofthepast.instance2bosses[buttons[buttonID].instanceID] then
			bosses = LFRofthepast.instance2bosses[buttons[buttonID].instanceID];
		else
			local numBosses = GetLFGDungeonNumEncounters(buttons[buttonID].instanceID) or 0;
			for i=1, numBosses do
				tinsert(bosses,i);
			end
		end

		if #bosses>0 then
			for i=1, #bosses do
				local boss, _, isKilled = GetLFGDungeonEncounterInfo(buttons[buttonID].instanceID,bosses[i]);
				local n = (buttons[buttonID].instance[name2] or buttons[buttonID].instance[name]).."-"..buttons[buttonID].instance[difficulty];
				if not isKilled and killedEncounter[n] and killedEncounter[n][boss] then
					isKilled = true;
				end
				GameTooltip:AddDoubleLine(C("ltblue",boss),isKilled and C("red",BOSS_DEAD) or C("green",BOSS_ALIVE));
			end
		end
		GameTooltip:Show();
	end
end

local function buttonHook_OnLeave()
	if not NPC_ID then return end
	GameTooltip:Hide();
end

local function raidButton(button,icon,data)
	icon:SetTexture("interface\\minimap\\raid");
	iconTexCoords[icon] = {icon:GetTexCoord()};
	icon:SetTexCoord(0.20,0.80,0.20,0.80);
	local label = data.instance[name].."\n|Tinterface\\lfgframe\\ui-lfg-icon-heroic:12:12:0:0:32:32:0:16:0:16|t "..C("dkred",_G.GENERIC_FRACTION_STRING:format(data.numEncounters[1],data.numEncounters[2]));
	if data.instance[name]~=data.instance[name2] then
		label = label .. " || ".. C("dkgray",data.instance[name2]);
	end
	button:SetText(label);
end

local function szenarioButton(button,icon,data)
	icon:SetTexture("interface\\minimap\\dungeon");
	iconTexCoords[icon] = {icon:GetTexCoord()};
	icon:SetTexCoord(0.20,0.80,0.20,0.80);
	local label = {data.instance[name]};
	if data.instance[difficulty]==1 then
		tinsert(label,C("dkblue"," ("..PLAYER_DIFFICULTY2..")"));
	end
	button:SetText(table.concat(label,"\n"));
end

GossipFrame:HookScript("OnHide",function()
	for icon, texCoord in pairs(iconTexCoords)do
		icon:SetTexCoord(unpack(texCoord));
	end
end);

GossipFrame:HookScript("OnEvent",function(self,event)
	if event=="GOSSIP_SHOW" then
		wipe(buttons); wipe(iconTexCoords);
		local id,_ = UnitGUID("npc");
		if id then
			_,_,_,_,_,id = strsplit('-',id);
			id = tonumber(id);
		end
		if id and LFRofthepast.npcID[id] and not IsControlKeyDown() then
			ScanSavedInstances();
			NPC_ID = id;
			local index,button,icon = 1,_G["GossipTitleButton1"],_G["GossipTitleButton1GossipIcon"];
			while button and button:IsShown() do
				local buttonID,text = button:GetID(),button:GetText();
				local instanceID
				if LFRofthepast.gossip2instance[NPC_ID] and #LFRofthepast.gossip2instance[NPC_ID]>0 then
					instanceID = LFRofthepast.gossip2instance[NPC_ID][buttonID];
				end
				if id and instanceID then
					local data = {
						groupName = false,
						instanceID = instanceID,
						instance = {GetLFGDungeonInfo(instanceID)},
						numEncounters = {0,0},
						encounters = {}
					};
					if data.instance[name]~=data.instance[name2] then
						data.groupName = data.instance[name2];
					end
					local bossIndexes = {};
					if LFRofthepast.instance2bosses[instanceID] then
						bossIndexes = LFRofthepast.instance2bosses[instanceID];
						data.numEncounters[2] = #LFRofthepast.instance2bosses[instanceID];
					else
						data.numEncounters[2] = GetLFGDungeonNumEncounters(instanceID)
						for i=1, data.numEncounters[2] do
							tinsert(bossIndexes,i);
						end
					end
					for _,i in ipairs(bossIndexes) do
						local boss, _, isKilled = GetLFGDungeonEncounterInfo(instanceID,i);
						local n = (data.instance[name2] or data.instance[name]).."-"..data.instance[difficulty];
						if not isKilled and killedEncounter[n] and killedEncounter[n][boss] then
							isKilled = true;
						end
						if isKilled then
							data.numEncounters[1] = data.numEncounters[1] + 1;
							tinsert(data.encounters,boss);
						end
					end
					-- get encounter status
					if data.instance[typeID]==1 and data.instance[subtypeID]==4 then
						szenarioButton(button,icon,data);
					else
						raidButton(button,icon,data);
					end
					buttons[buttonID] = data;
					GossipResize(button);
				end

				if not hookedButton["button"..index] then
					button:HookScript("OnEnter",buttonHook_OnEnter);
					button:HookScript("OnLeave",buttonHook_OnLeave);
					hookedButton["button"..index] = true;
				end
				index = index + 1;
				button = _G["GossipTitleButton"..index];
				if button then
					icon = _G["GossipTitleButton"..index.."GossipIcon"];
				end
			end
		end
	end
end);

------------------------------------------------------ event frame
local LFRofthepastFrame = CreateFrame("frame");
LFRofthepastFrame:SetScript("OnEvent",function(self,event,...)
	if event == "ADDON_LOADED" and addon == "_ShiGuang" then
		self:UnregisterEvent("ADDON_LOADED");
	elseif not LFRofthepast.faction(true) and (event=="PLAYER_LOGIN" or event=="NEUTRAL_FACTION_SELECT_RESULT") then
		RequestRaidInfo();
		LFRofthepast.npcs_update();
	elseif event=="BOSS_KILL" then
		local encounterID,name = ...;
		BossKillQueryUpdate=true;
		C_Timer.After(0.16,RequestRaidInfoUpdate);
	elseif event=="UPDATE_INSTANCE_INFO" then
		BossKillQueryUpdate=false;
		if not UpdateInstanceInfoLock then
			UpdateInstanceInfoLock = true;
			C_Timer.After(0.3,ScanSavedInstances);
		end
	elseif event=="RAID_INSTANCE_WELCOME" then
		local dungeonName,lockExpireTime,locked,extended = ...;
		currentInstance.name = dungeonName;
		currentInstance.parts = false;
		currentInstance.isLFR = false;
		if dungeonName:find(PLAYER_DIFFICULTY3) then
			for k,v in pairs(InstanceGroups)do
				if dungeonName:find("^"..k) then
					currentInstance.parts = v;
					break;
				end
			end
			currentInstance.isLFR = true;
		end
	end
end);
LFRofthepastFrame:RegisterEvent("ADDON_LOADED");
LFRofthepastFrame:RegisterEvent("PLAYER_LOGIN");
LFRofthepastFrame:RegisterEvent("NEUTRAL_FACTION_SELECT_RESULT");
LFRofthepastFrame:RegisterEvent("BOSS_KILL");
LFRofthepastFrame:RegisterEvent("UPDATE_INSTANCE_INFO");
LFRofthepastFrame:RegisterEvent("RAID_INSTANCE_WELCOME");

-- function XXXXXX(id) local num = GetLFGDungeonNumEncounters(id); for i=1, num do local boss, _, isKilled = GetLFGDungeonEncounterInfo(id,i); print(id,i,boss); end end