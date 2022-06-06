--## Author: Hizuro ## Version: 1.3.5-release
local LFRofthepast = {};
LFRofthepast.npcID = {};
LFRofthepast.npcs = {};

function LFRofthepast.load_data()
	local faction = LFRofthepast.faction(); --UnitFactionGroup("player")=="Alliance";

	local npc_wod = {94870,582,33.2,37.2,5,"LFR"};
	local npc_bfa = {177193,1161,74.21,13.53,7,"LFR"};
	if faction=="horde" then
		npc_wod[2],npc_wod[3],npc_wod[4] = 590,41.5,47.0;
		npc_bfa[1],npc_bfa[2],npc_bfa[3],npc_bfa[4] = 177208,1165,68.62,30.27;
	end

	-- {<npcis>, <zoneid>, <posX>, <posY>, <expansionNumber>, <instanceType>}
	-- expansionNumber is for _G["EXPANSION_NAME"..<expansionNumber>]
	LFRofthepast.npcs = {
		-- cata
		{80675,74,63.1,27.3,3,"LFR"},
		-- mop
		--{78709,390,82.95,30.38,4,"SZN"}, -- szenarios
		--{78777,390,83.05,30.48,4,"SZHC"}, -- hc szenarios
		{80633,390,83.16,30.56,4,"LFR"}, -- lfr
		-- WoD, lfr (same npc id and different location for alliance and horde)
		npc_wod,
		-- legion
		{111246,627,63.6,55.6,6,"LFR"},		--{31439,627,63.6,55.6,6,"LFR"},
		-- bfa
		npc_bfa
	};

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
		[1610]={1,2,4},[1611]={5,3,6},[1612]={7,8,9},[1613]={10,11}, -- 5
		-- bfa
		[1731]={1,2,4},[1732]={3,5,6},[1733]={7,8}, -- Uldir
		[1945]={1,2,3},[1946]={4,5,6},[1947]={7,8}, -- dazar'alor // alliance
		[1948]={1,2,3},[1949]={4,5,6},[1950]={7,8}, -- dazar'alor // horde
		[1951]={1,2}, -- tiegel der stürme
		[2009]={1,3,2},[2010]={4,5,6},[2011]={7,8}, -- eternal palace
		[2036]={1,3,2},[2037]={4,6,5,7},[2038]={8,9,10},[2039]={11,12}, -- ny'alotha
		-- sl
		--[2090]={2,3,4},[2091]={5,6,7},[2092]={1,8,9},[2096]={10}, -- castle nathria
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
		[npc_bfa[1]] = {1731,1732,1733, 1945,1946,1947, --[[1948,1949,1950,]] 1951, 2009,2010,2011,2036, 2037,2038,2039},
		-- sl
		--[] = {2090,2091,2092,2096},

	};

	if faction=="horde" then
		LFRofthepast.gossip2instance[npc_bfa[1]][4] = 1948;
		LFRofthepast.gossip2instance[npc_bfa[1]][5] = 1949;
		LFRofthepast.gossip2instance[npc_bfa[1]][6] = 1950;
	end

	LFRofthepast.lfrID = {
		416,417, -- cata 2
		527,528,529,530,526,610,611,612,613,716,717,724,725, -- mop
		849,850,851,847,846,848,823,982,983,984,985,986, -- wod
		1287,1288,1289,1411,1290,1291,1292,1293,1494,1495,1496,1497,1610,1611,1612,1613, -- legion
		1731,1732,1733,1945,1946,1947,1948,1949,1950,1951,2009,2010,2011,2036,2037,2038,2039, -- bfa
		-- 2090,2091,2092,2096, -- sl
	}

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
	[1610]={1,2,4},[1611]={5,3,6},[1612]={7,8,9},[1613]={10,11}, -- 5
	-- bfa
	--[1731]={1,2,4},[1732]={3,5,6},[1733]={7,8}, -- Uldir
	--[1945]={1,2,3},[1946]={4,5,6},[1947]={7,8}, -- dazar'alor
	-- eternal palace
	-- ny'alotha
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
	[31439] = {1287,1288,1289,1290,1291,1292,1293,1411,1494,1495,1496,1497,1610,1611,1612,1613}, -- Old Dalaran
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
local buttons,hookedButton,died,NPC_ID,db = {},{},{},false,(UnitGUID("target"));
local name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, texture = 1,2,3,4,5,6,7,8,9,10,11; -- GetLFGDungeonInfo
local difficulty, maxPlayers, description, isHoliday, bonusRepAmount, minPlayers, isTimeWalker, name2, minGearLevel = 12,13,14,15,16,17,18,19,20; -- GetLFGDungeonInfo
local iconTexCoords,killedEncounter,BossKillQueryUpdate,UpdateInstanceInfoLock,currentInstance = {},{},false,false,{};

------------------------------------------------
-- GameTooltip to get localized names and other informations
LFRofthepast.scanTT = CreateFrame("GameTooltip","LFRofthepast_ScanTT",UIParent,"GameTooltipTemplate");
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
			local str = (regions[i]:GetText() or ""):trim();
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
	if not (NPC_ID and self.type=="Gossip") then return end
	local buttonID = self:GetID();
	if buttonID and buttons[buttonID] then
		GameTooltip:SetOwner(self,"ANCHOR_NONE");
		GameTooltip:SetPoint("LEFT",GossipFrame,"RIGHT");

		local showID = "";
		if false then
			showID = " " .. "|cFF69ccf0".."("..buttons[buttonID].instanceID..")".."|r";
		end

		-- instance name
		GameTooltip:AddLine(buttons[buttonID].instance[name].. showID);

		-- instance group name (for raids splitted into multible lfr instances)
		if not LFRofthepast.noSubtitle[NPC_ID] and buttons[buttonID].instance[name]~=buttons[buttonID].instance[name2] then
			GameTooltip:AddLine("|cFFA0A0A0"..buttons[buttonID].instance[name2].."|r");
		end

		-- instance description
		if buttons[buttonID].instance[description] and buttons[buttonID].instance[description]~="" then
			GameTooltip:AddLine(buttons[buttonID].instance[description],1,1,1,1);
		end

		-- instance encounter list
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
				GameTooltip:AddDoubleLine("|cFF69ccf0"..boss.."|r",isKilled and "|cFFff8080"..BOSS_DEAD.."|r" or "|cFF80ff80"..BOSS_ALIVE.."|r");
			end
		end
		GameTooltip:Show();
	end
end

local function buttonHook_OnLeave()
	if not NPC_ID then return end
	GameTooltip:Hide();
end

local function OnGossipShow()
	wipe(buttons); wipe(iconTexCoords);
	local id,_ = UnitGUID("npc");
	if id then
		_,_,_,_,_,id = strsplit('-',id);
		id = tonumber(id);
	end
	if id and LFRofthepast.npcID[id] and not IsControlKeyDown() then
		ScanSavedInstances();
		NPC_ID = id;
		local Buttons = {};
		if GossipFrame.buttons then
			Buttons = GossipFrame.buttons;
		end
		for i,button in ipairs(Buttons)do
			if button:IsShown() and button.type=="Gossip" then
				local buttonID = button:GetID()
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
						data.numEncounters[2] = GetLFGDungeonNumEncounters(instanceID);
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
					local showID = "";
					if false then
						showID = " " .. "|cFF69ccf0".."("..instanceID..")".."|r";
					end

						-- gossip text replacement
						button:SetText(data.instance[name]..showID.."\n".."|Tinterface\\lfgframe\\ui-lfg-icon-heroic:12:12:0:0:32:32:0:16:0:16|t ".. "|cFF404040"..data.instance[name2].."|r");  --.."|cFF800000".._G.GENERIC_FRACTION_STRING:format(data.numEncounters[1],data.numEncounters[2])).."|r".. " || "
						-- gossip icon replacement
						iconTexCoords[button.Icon] = {button.Icon:GetTexCoord()};
						button.Icon:SetTexture("interface\\minimap\\raid");
						button.Icon:SetTexCoord(0.20,0.80,0.20,0.80);
						button:Resize();
					if not hookedButton["button"..buttonID] then
						button:HookScript("OnEnter",buttonHook_OnEnter);
						button:HookScript("OnLeave",buttonHook_OnLeave);
						hookedButton["button"..buttonID] = true;
					end
					buttons[buttonID] = data;
				end
			end
		end
	end
end

hooksecurefunc("GossipFrameUpdate",OnGossipShow)

local function OnGossipHide()
	for icon, texCoord in pairs(iconTexCoords)do
		icon:SetTexCoord(unpack(texCoord));
		iconTexCoords[icon]=nil;
	end
end

GossipFrame:HookScript("OnHide",OnGossipHide);

------------------------------------------------------ create into tooltip for raids

local function CreateEncounterTooltip(parent)
	if --[[IsInstance() or]] IsInRaid() then
		local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID, instanceGroupSize = GetInstanceInfo()
		if not (difficultyID==7 or difficultyID==17) then return end
		local data = InstanceGroups[instanceName];
		if data then
			GameTooltip:SetOwner(parent,"ANCHOR_NONE");
			GameTooltip:SetPoint("TOP",parent,"BOTTOM");
			GameTooltip:SetText(instanceName);
			GameTooltip:AddLine(difficultyName,1,1,1);

			for i=1, #data do
				GameTooltip:AddLine(" ");
				GameTooltip:AddLine("|cFF69ccf0"..data[i][2].."|r");

				local encounter = GetEncounterStatus(data[i][1]);
				local i2b = LFRofthepast.instance2bosses[data[i][1]];
				local more = IsControlKeyDown();
				if i2b then -- lfr
					for b=1, #i2b do
						GameTooltip:AddDoubleLine("|Tinterface/questtypeicons:14:14:0:0:128:64:0:18:36:54|t "..encounter[i2b[b]][1],encounter[i2b[b]][2] and "|cFFff8080"..BOSS_DEAD.."|r" or "|cFF80ff80"..BOSS_ALIVE.."|r");
					end
				else -- normal raid
					for b=1, #encounter do
						GameTooltip:AddDoubleLine("|Tinterface/questtypeicons:14:14:0:0:128:64:0:18:36:54|t "..encounter[b][1],encounter[b][2] and "|cFFff8080"..BOSS_DEAD.."|r" or "|cFF80ff80"..BOSS_ALIVE.."|r");
					end
				end
			end

			GameTooltip:Show();
		end
	end
end

-- QueueStatusFrame hook to add tooltip to the QueueStatusFrame tooltip
QueueStatusFrame:HookScript("OnShow",function(parent)
		CreateEncounterTooltip(parent);
end);

QueueStatusFrame:HookScript("OnHide",function(parent)
	GameTooltip:Hide();
end);

------------------------------------------------------ event frame
local LFRofthepastFrame = CreateFrame("frame");
LFRofthepastFrame:SetScript("OnEvent",function(self,event,...)
	if event=="ADDON_LOADED" then
		if addon==... then
			character = (UnitName("player")).."-"..realm;
		end
	elseif not LFRofthepast.faction(true) and (event=="PLAYER_LOGIN" or event=="NEUTRAL_FACTION_SELECT_RESULT") then
		RequestRaidInfo();
		LFRofthepast.load_data();
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