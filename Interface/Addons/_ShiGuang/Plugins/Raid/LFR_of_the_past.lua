--## Author: Hizuro ## Version: 1.7.2-release
local LFRofthepast = {};
LFRofthepast.npcID = {};
LFRofthepast.npcs = {};

function LFRofthepast.load_data()
	local Alliance = UnitFactionGroup("player")=="Alliance";
	local npc_wod = {94870,582,33.2,37.2,5,"LFR"};
	local npc_bfa = {177193,1161,74.21,13.53,7,"LFR"};
	local theramores_fall = 543;
	if not Alliance then
		npc_wod[2],npc_wod[3],npc_wod[4] = 590,41.5,47.0;
		npc_bfa[1],npc_bfa[2],npc_bfa[3],npc_bfa[4] = 177208,1165,68.62,30.27;
		theramores_fall = 542;
	end

	-- {<npcis>, <zoneid>, <posX>, <posY>, <expansionNumber>, <instanceType>}
	-- expansionNumber is for _G["EXPANSION_NAME"..<expansionNumber>]
	LFRofthepast.npcs = {
		-- cata
		{80675,74,63.1,27.3,3,"LFR"},
		-- mop
		{80633,390,83.16,30.56,4,"LFR"}, -- lfr
		{78709,390,82.95,30.38,4,"SZN",addTo=2,order=2}, -- szenarios
		{78777,390,83.05,30.48,4,"SZHC",addTo=2,order=3}, -- hc szenarios
		-- WoD, lfr (same npc id and different location for alliance and horde)
		npc_wod,
		-- legion
		{111246,627,63.6,55.6,6,"LFR"},
		-- bfa
		npc_bfa,
		-- shadowlands
		{205959,1670,41.4,71.41,8,"LFR"},
	};

	LFRofthepast.instance2bosses = {
		-- cata
		[416]={1,2,3,4},[417]={5,6,7,8},
		-- mop
		[527]={1,2,3},[528]={4,5,6}, -- 1
		[529]={1,2,3},[530]={4,5,6}, -- 2
		[526]={1,2,3,4},
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
		[1731]={1,2,3},[1732]={4,5,6},[1733]={7,8}, -- Uldir
		[1945]={1,2,3},[1946]={4,5,6},[1947]={7,8,9}, -- dazar'alor // alliance
		[1948]={1,2,3},[1949]={4,5,6},[1950]={7,8,9}, -- dazar'alor // horde
		[1951]={1,2}, -- tiegel der stürme
		[2009]={1,3,2},[2010]={4,5,6},[2011]={7,8}, -- eternal palace
		[2036]={1,3,2},[2037]={4,6,5,7},[2038]={8,9,10},[2039]={11,12}, -- ny'alotha
		-- sl
		[2090]={2,4,6},[2091]={3,5,7},[2092]={1,8,9},[2096]={10}, -- castle nathria
		[2221]={1,2,3},[2222]={4,5,6},[2223]={7,8,9},[2224]={10}, -- Sanctum of Domination 9.1.0
		[2291]={2,4,7},[2292]={1,3,5,6},[2293]={8,9,10},[2294]={11}, -- Sepulcher of the First Ones 9.2.0
		-- df
	};

	LFRofthepast.instance2bossesAlt = {
		[2090]={1,2,3},[2091]={1,2,3},[2092]={1,2,3},[2096]={1}, -- castle nathria
	}

	-- hide subtitle for szenario and single wing lfr
	LFRofthepast.noSubtitle = {
		[78709]=true,
		[78777]=true,
		[80633] = {[526]=true},
	};

	LFRofthepast.gossipOptionsOrderIndexOffset = {
		-- [<npcID>] = <number>
		-- cata
		[80675] = 1, -- lfr, working
		-- mop
		[78709] = 0, -- szenarios
		[78777] = 0, -- heroic szenarios
		[80633] = 0, -- lfr, working
		-- wod
		[94870] = 1, -- lfr, working
		-- legion
		[111246] = 1, -- lfr, working
		-- bfa
		[177193] = false,
		-- sl
		[205959] = 0,
	}

	LFRofthepast.gossip2instance = {
		-- [<npcID>] = { <instanceIDs> }
		-- or [<npcID>] = { [<gossipOptionID>] = <instanceIDs> }
		-- cata
		[80675] = {[42612]=416,[42613]=417}, -- lfr
		-- mop
		[78709] = { -- szenarios
			[42511]=492,[42512]=499,[42513]=504,[42514]=511,[42515]=517,[42516]=539,[42517]=theramores_fall,
			[42518]=593,[42519]=586,[42520]=589,[42521]=595 --[[horde]],[42522]=590 --[[ally]],[42523]=588,
			[42524]=624,[42525]=625,[42526]=637
		},
		[78777] = { -- heroic szenarios
			[42573]=652,[42574]=647,[42575]=649,[42576]=646,[42577]=639,[42578]=648,
		},
		[80633] = { -- lfr
			[42620]=527,[42621]=528,[42622]=529,[42623]=530,[42624]=526,[42625]=610,[42626]=611,[42627]=612,[42628]=613,[42629]=716,[42630]=717,[42631]=724,[42632]=725
		},
		-- wod
		[94870] = { -- lfr
			[44390]=849,[44391]=850,[44392]=851,[44393]=847,[44394]=846,[44395]=848,[44396]=823,[44397]=982,[44398]=983,[44399]=984,[44400]=985,[44401]=986
		},
		-- legion
		[111246] = { -- lfr
			[37110]=1287,[37111]=1288,[37112]=1289,[37113]=1290,[37114]=1291,[37115]=1292,[37116]=1293,[37117]=1411,
			[37118]=1494,[37119]=1495,[37120]=1496,[37121]=1497,[37122]=1610,[37123]=1611,[37124]=1612,[37125]=1613
		},
		-- bfa
		[npc_bfa[1]] = { -- lfr
			[52303]=1731,[52304]=1732,[52305]=1733, -- uldir
			[52306]=1948,[52307]=1949,[52308]=1950, -- dazar'alor (horde)
			[52309]=1945,[52310]=1946,[52311]=1947, -- dazar'alor (alliance)
			[52312]=1951, -- Crucible of Storms
			[52313]=2009,[52314]=2010,[52315]=2011, -- The Eternal Palace
			[52316]=2036,[52317]=2037,[52318]=2038, -- ny'alotha
		},
		-- sl
		[205959] = {
			[110020]=2090,[110037]=2091,[110036]=2092,[110035]=2096, -- castle nathria 9.0
			[110034]=2221,[110033]=2222,[110032]=2223,[110031]=2224, -- Sanctum of Domination 9.1.0
			[110030]=2291,[110029]=2292,[110028]=2293,[110027]=2294, -- Sepulcher of the First Ones 9.2.0
		},
	};
	LFRofthepast.idx2gossipOptionID = {
		[80675] = {42612,42613}, -- lfr
		-- mop
		[78709] = { -- szenarios
			42511,42512,42513,42514,42515,42516,42517,
			42518,42519,42520,42522,42523,
			42524,42525,42526
		},
		[78777] = { -- heroic szenarios
			42573,42574,42575,42576,42577,42578,
		},
		[80633] = { -- lfr
			42620,42621,42622,42623,42624,42625,42626,42627,42628,42629,42630,42631,42632
		},
		-- wod
		[94870] = { -- lfr
			44390,44391,44392,44393,44394,44395,44396,44397,44398,44399,44400,44401
		},
		-- legion
		[111246] = { -- lfr
			37110,37111,37112,37113,37114,37115,37116,37117,
			37118,37119,37120,37121,37122,37123,37124,37125
		},
		-- bfa
		[npc_bfa[1]] = { -- lfr
			52303,52304,52305, -- uldir
			52309,52310,52311, -- dazar'alor (alliance)
			52312, -- Crucible of Storms
			52313,52314,52315, -- The Eternal Palace
			52316,52317,52318, -- ny'alotha
		},
		[205959] = {
			110020,110037,110036,110035, -- castle nathria
			110034,110033,110032,110031, -- Sanctum of Domination 9.1.0
			110030,110029,110028,110027, -- Sepulcher of the First Ones 9.2.0
		},
	}
	if not Alliance then
		LFRofthepast.idx2gossipOptionID[78709][11]=42521
		-- dazar'alor (horde)
		LFRofthepast.idx2gossipOptionID[npc_bfa[1]][4]=52306
		LFRofthepast.idx2gossipOptionID[npc_bfa[1]][5]=52307
		LFRofthepast.idx2gossipOptionID[npc_bfa[1]][6]=52308
	end

	LFRofthepast.lfrID = {
		416,417, -- cata 2
		527,528,529,530,526,610,611,612,613,716,717,724,725, -- mop
		849,850,851,847,846,848,823,982,983,984,985,986, -- wod
		1287,1288,1289,1411,1290,1291,1292,1293,1494,1495,1496,1497,1610,1611,1612,1613, -- legion
		1731,1732,1733, 1945,1946,1947, 1948,1949,1950, 1951, 2009,2010,2011, 2036,2037,2038, -- bfa
		2090,2091,2092,2096,2221,2222,2223,2224,2291,2292,2293,2294, -- sl
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
				local spell = C_Spell.GetSpellInfo(224869);
				local _,target = strsplit(HEADER_COLON,spell.name,2);
				if target then
					mapInfo.name = target:trim(); -- replace "Dalaran" by "Dalaran - Broken Isles"
				end
			end
			LFRofthepast.npcs[i].zoneName = mapInfo.name;
		end
	end
end
local buttons,hookedButton,NPC_ID,db = {},{};
local iconTexCoords,killedEncounter,BossKillQueryUpdate,UpdateInstanceInfoLock = {},{},false,false;
local LC = LibStub("LibColors-1.0");
local C = LC.color;
LC.colorset({
	["ltyellow"]	= "fff569",
	["dkyellow"]	= "ffcc00",
	["ltorange"]	= "ff9d6a",
	["dkorange"]	= "905d0a",
	["ltred"]		= "ff8080",
	["ltred2"]		= "ff4040",
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
local skull = "|T337496:12:12:0:0:32:32:0:16:0:16|t ";
local GossipTextPattern = {};
do
	local colors = {enemy="dkred",enemyClear="dkgreen",enemyDarkBG="ltred2",enemyClearDarkBG="green"}
	for k,v in pairs(colors)do
		GossipTextPattern[k] = "%s\n"..skull..C(v,"%d/%d");
	end
end
GossipTextPattern.raidWing = " "..C("dkgray","|| %s");
GossipTextPattern.raidWingDarkBG = " "..C("gray","|| %s");
GossipTextPattern.raidWingImmersion = "%1$s\n"..C("gray","%4$s").."\n"..skull..C("ltred2","%2$d/%3$d");
GossipTextPattern.raidWingImmersionClear = "%1$s\n"..C("gray","%4$s").."\n"..skull..C("green","%2$d/%3$d");

------------------------------------------------
-- GameTooltip to get localized names and other informations
LFRofthepast.scanTT = CreateFrame("GameTooltip","LFRofthepast_ScanTT",UIParent,"GameTooltipTemplate");
LFRofthepast.scanTT:SetScale(0.0001); LFRofthepast.scanTT:SetAlpha(0); LFRofthepast.scanTT:Hide();
-- unset script functions shipped by GameTooltipTemplate to prevent errors
for _,v in ipairs({"OnLoad","OnHide","OnTooltipSetDefaultAnchor","OnTooltipCleared"})do LFRofthepast.scanTT:SetScript(v,nil); end

function LFRofthepast.scanTT:GetStringRegions(dataFunction,...)
	if type(self[dataFunction])~="function" then return false; end

	LFRofthepast.scanTT:SetOwner(UIParent,"ANCHOR_NONE");
	self[dataFunction](self,...);
	LFRofthepast.scanTT:Show();

	local regions,strs = {LFRofthepast.scanTT:GetRegions()},{};
	for i=1,#regions do
		if (regions[i]~=nil) and (regions[i]:GetObjectType()=="FontString") then
			local str = strtrim(regions[i]:GetText() or "");
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
	local faction = (UnitFactionGroup("player") or "neutral"):lower();
	if isNeutral then
		return faction=="neutral";
	end
	return faction;
end

local function GetInstanceDataByID(instanceID)
	local data = {
		groupName = false,
		instanceID = instanceID,
		instanceInfo = {},
		numEncounters = {0,0},
		encounters = {}
	};
	local info = {};
	info.name, info.typeID, info.subtypeID, info.minLevel, info.maxLevel, info.recLevel, info.minRecLevel, info.maxRecLevel, info.expansionLevel,
	info.groupID, info.textureFilename, info.difficulty, info.maxPlayers, info.description, info.isHoliday, info.bonusRepAmount, info.minPlayers,
	info.isTimeWalker, info.name2, info.minGearLevel, info.isScalingDungeon, info.lfgMapID = GetLFGDungeonInfo(instanceID);
	data.instanceInfo = info;

	if data.instanceInfo.name~=data.instanceInfo.name2 then
		data.groupName = data.instanceInfo.name2;
	end
	local bossIndexes = {};
	if LFRofthepast.instance2bosses[instanceID] then
		bossIndexes = LFRofthepast.instance2bosses[instanceID];
		data.numEncounters[2] = #LFRofthepast.instance2bosses[instanceID];
	else
		data.numEncounters[2] = GetLFGDungeonNumEncounters(instanceID) or 0;
		for i=1, data.numEncounters[2] do
			tinsert(bossIndexes,i);
		end
	end
	for _,i in ipairs(bossIndexes) do
		local boss, _, isKilled = GetLFGDungeonEncounterInfo(instanceID,i);
		local n = (data.instanceInfo.name2 or data.instanceInfo.name).."-"..data.instanceInfo.difficulty;
		if not isKilled and killedEncounter[n] and killedEncounter[n][boss] then
			isKilled = true;
		end
		if isKilled then
			data.numEncounters[1] = data.numEncounters[1] + 1;
			tinsert(data.encounters,boss);
		end
	end
	return data;
end

local function RequestRaidInfoUpdate()
	if BossKillQueryUpdate then
		RequestRaidInfo();
	end
end

local function ScanSavedInstances()
	for index=1, (GetNumSavedInstances()) do
		local instanceName, _, instanceReset, instanceDifficulty, _, _, _, _, _, _, _, encounterProgress = GetSavedInstanceInfo(index);
		if (instanceDifficulty==7 or instanceDifficulty==17) and encounterProgress>0 and instanceReset>0 then
			local encounters,strs = {},LFRofthepast.scanTT:GetStringRegions("SetInstanceLockEncountersComplete",index);
			if strs then
				for i=2, #strs, 2 do
					encounters[strs[i]] = strs[i+1]==BOSS_DEAD;
				end
				killedEncounter[instanceName.."-"..instanceDifficulty] = encounters;
			end
		end
	end
	UpdateInstanceInfoLock = false;
end

local function GetEncounterStatus(instanceID)
	local encounter,num = {},GetLFGDungeonNumEncounters(instanceID);
	local _, _, _, _, _, _, _, _, _, _, _, difficulty, _, _, _, _, _, _, name2 = GetLFGDungeonInfo(instanceID);
	local instanceTag = name2.."-"..difficulty;
	for i=1, num do
		local boss, _, isKilled = GetLFGDungeonEncounterInfo(instanceID,i);
		if not isKilled and killedEncounter[instanceTag] and killedEncounter[instanceTag][boss] then
			isKilled = true;
		end
		tinsert(encounter,{boss,isKilled});
	end
	return encounter;
end

local function UpdateNpcID()
	local id,_ = UnitGUID("npc");
	if id then
		_,_,_,_,_,id = strsplit('-',id);
	end
	NPC_ID = tonumber(id);
end

local instanceGroupsBuild = false;
local InstanceGroups = setmetatable({},{
	__index = function(t,k)
		if not instanceGroupsBuild then -- build group list
			local current;
			for i=1, #LFRofthepast.lfrID do
				local name, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, name2 = GetLFGDungeonInfo(LFRofthepast.lfrID[i])
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
	if not (NPC_ID and LFRofthepast.gossip2instance[NPC_ID]) then return end
	local data
	if ImmersionFrame then
		data = self.data;
	elseif self.GetElementData then
		local option = self.GetElementData()
		if option.info and option.info.instanceID then
			data = GetInstanceDataByID(option.info.instanceID);
		elseif LFRofthepast.gossip2instance[NPC_ID] and LFRofthepast.gossip2instance[NPC_ID][option.info.gossipOptionID] then
			data = GetInstanceDataByID(LFRofthepast.gossip2instance[NPC_ID][option.info.gossipOptionID]);
		else
			data = GetInstanceDataByID(option.index);
		end
	end
	if not data then
		return
	end
	-- prepare instance encounter list
	local bosses = {};
	if LFRofthepast.instance2bosses[data.instanceID] then
		bosses = LFRofthepast.instance2bosses[data.instanceID];
	else
		local numBosses = GetLFGDungeonNumEncounters(data.instanceID) or 0;
		for i=1, numBosses do
			tinsert(bosses,i);
		end
	end

	if data.instanceInfo.description=="" and #bosses==0 then
		return; -- don't display tooltip without more than the title (instance name)
	end

	-- set anchoring and ownership of the tooltip
	GameTooltip:SetOwner(self,"ANCHOR_NONE");
	if ImmersionFrame then
		GameTooltip:SetPoint("RIGHT",self,"LEFT",-4,0)
	else
		GameTooltip:SetPoint("LEFT",GossipFrame,"RIGHT");
	end

	local showID = "";
	if false then -- TODO: Add db option to show instance id
		showID = " " .. C("ltblue","("..data.instanceID..")");
	end

	-- instance name
	GameTooltip:AddLine(data.instanceInfo.name.. showID);

	-- instance group name (for raids splitted into multible lfr instances)
	local noSubtitle = (type(LFRofthepast.noSubtitle[NPC_ID])=="table" and LFRofthepast.noSubtitle[NPC_ID][data.instanceID]==true) or LFRofthepast.noSubtitle[NPC_ID]==true;
	if (not noSubtitle) and data.instanceInfo.name~=data.instanceInfo.name2 then
		GameTooltip:AddLine(C("gray",data.instanceInfo.name2));
		end

		-- instance description
	if data.instanceInfo.description and data.instanceInfo.description~="" then
		GameTooltip:AddLine(data.instanceInfo.description,1,1,1,1);
		end

	-- instance encounter list
	if #bosses>0 then
		for i=1, #bosses do
			local boss, _, isKilled = GetLFGDungeonEncounterInfo(data.instanceID,bosses[i]);
			local n = (data.instanceInfo.name2 or data.instanceInfo.name).."-"..data.instanceInfo.difficulty;
			if not isKilled and killedEncounter[n] and killedEncounter[n][boss] then
				isKilled = true;
			end
			GameTooltip:AddDoubleLine(C("ltblue",boss),isKilled and C("red",BOSS_DEAD) or C("green",BOSS_ALIVE));
		end
	end

	GameTooltip:Show();
end

local function buttonHook_OnLeave()
	GameTooltip:Hide();
end

hooksecurefunc(GossipOptionButtonMixin, "Setup", function(self, optionInfo)
	if not hookedButton[self] then
		hookedButton[self] = true;
		self:HookScript("OnEnter",buttonHook_OnEnter);
		self:HookScript("OnLeave",buttonHook_OnLeave);
	end
	if optionInfo.name:match("T337496:12:12:0:0:32:32:0:16:0:16") and optionInfo.icon==1502548 then
		self.Icon:SetTexCoord(0.15,0.85,0.15,0.85); -- make raid icon a little bit bigger
	else
		self.Icon:SetTexCoord(0,1,0,1);
	end
end);

GossipFrame:HookScript("OnShow",function(self)
	UpdateNpcID();
	if not (NPC_ID and LFRofthepast.npcID[NPC_ID] and GossipFrame.gossipOptions) then
		return
	end

	wipe(buttons);
	wipe(iconTexCoords);
	ScanSavedInstances();

	-- update options before layout gossip buttons; very smart. ;-) Thanks at fuba82.
	for i,option in ipairs(GossipFrame.gossipOptions) do
		local index,data;
		if LFRofthepast.gossip2instance[NPC_ID] and LFRofthepast.gossip2instance[NPC_ID][option.gossipOptionID] then
			index = option.gossipOptionID;
		else
			index = option.orderIndex + (LFRofthepast.gossipOptionsOrderIndexOffset[NPC_ID] or 0);
		end
		if LFRofthepast.gossip2instance[NPC_ID][index] then
			data = GetInstanceDataByID(LFRofthepast.gossip2instance[NPC_ID][index] or 0);
		end
		if data then
			option.nameOrig = option.name;
			option.instanceID = LFRofthepast.gossip2instance[NPC_ID][index];

			local noSubtitle = (type(LFRofthepast.noSubtitle[NPC_ID])=="table" and LFRofthepast.noSubtitle[NPC_ID][option.instanceID]==true) or LFRofthepast.noSubtitle[NPC_ID]==true;

			-- replace gossip icon (interface/minimap/raid)
			option.icon = 1502548;

			-- replcae gossip text
			if data.numEncounters[2]==0 then
				option.name = data.instanceInfo.name; -- mostly for szenarios
			else
				local dark = "DarkBG";  -- or ""
				local clear = data.numEncounters[1]==data.numEncounters[2] and "Clear" or "";
				local pattern = GossipTextPattern["enemy"..clear..dark];
				if (not noSubtitle) and data.instanceInfo.name~=data.instanceInfo.name2 then
					pattern = pattern .. GossipTextPattern["raidWing"..dark];
				end
				option.name = pattern:format(
					data.instanceInfo.name, -- instance wing name
					data.numEncounters[1], -- encounters killed this week
					data.numEncounters[2], -- number of encounters of the wing
					data.instanceInfo.name2
				);
			end
		end
	end
end);

GossipFrame:HookScript("OnHide",function()
	for icon, texCoord in pairs(iconTexCoords)do
		icon:SetTexCoord(unpack(texCoord));
		iconTexCoords[icon]=nil;
	end
end);

local function OnImmersionShow()
	wipe(buttons);
	wipe(iconTexCoords);
	UpdateNpcID();
	if not (NPC_ID and LFRofthepast.npcID[NPC_ID] and not IsControlKeyDown()) then
		return;
	end
	ScanSavedInstances();
	local updated,instanceID,buttonID,gossipOptionID = false;
	for i,button in ipairs(ImmersionFrame.TitleButtons.Buttons)do
		updated,instanceID,buttonID,gossipOptionID = false;
		if button:IsShown() and button.type=="Gossip" then
			buttonID = button.idx
			if button.gossipOptionID then
				gossipOptionID = button.gossipOptionID
			elseif LFRofthepast.idx2gossipOptionID[NPC_ID] and #LFRofthepast.idx2gossipOptionID[NPC_ID]>0 then
				gossipOptionID = LFRofthepast.idx2gossipOptionID[NPC_ID][buttonID]
			end
			if gossipOptionID then
				instanceID = LFRofthepast.gossip2instance[NPC_ID][gossipOptionID];
			end
			if instanceID then
				local data = GetInstanceDataByID(instanceID)
				button.data = data;
				local noSubtitle = (type(LFRofthepast.noSubtitle[NPC_ID])=="table" and LFRofthepast.noSubtitle[NPC_ID][instanceID]==true) or LFRofthepast.noSubtitle[NPC_ID]==true;
				-- gossip text replacement
				if data.numEncounters[2]==0 then
					button:SetText(data.instanceInfo.name)
				else
					local clear = data.numEncounters[1]==data.numEncounters[2] and "Clear" or "";
					local pattern = GossipTextPattern["enemy"..clear.."DarkBG"];
					if (not noSubtitle) and data.instanceInfo.name~=data.instanceInfo.name2 then
						pattern = GossipTextPattern["raidWingImmersion"..clear];
					end
					button:SetFormattedText(
						pattern,
						data.instanceInfo.name, -- name of instance wing
						data.numEncounters[1], -- killed  encounters
						data.numEncounters[2], -- number of encounters in this wing
						data.instanceInfo.name2 -- raid name
					)
				end

				-- gossip icon replacement
				iconTexCoords[button.Icon] = {button.Icon:GetTexCoord()};
				button.Icon:SetTexture(1502548); -- interface\\minimap\\raid
				button.Icon:SetTexCoord(0.20,0.80,0.20,0.80);

				if not hookedButton["button"..buttonID] then
					local fnc = (button:GetScript("OnEnter")==nil and "Set" or "Hook") .. "Script";
					button[fnc](button,"OnEnter",buttonHook_OnEnter);
					button[fnc](button,"OnLeave",buttonHook_OnLeave);
					hookedButton["button"..buttonID] = true;
				end
				buttons[buttonID] = data;
			end
		end
	end
end

local function ImmersionFrame_GossipShow()
	C_Timer.After(0.1,OnImmersionShow);
end

local function ImmersionFrame_OnHide()
	for icon, texCoord in pairs(iconTexCoords)do
		icon:SetTexCoord(unpack(texCoord));
		iconTexCoords[icon]=nil;
	end
end

----------------------------------------------------
-- create into tooltip for raids
local function GetEncounterInfo(instanceID,encounters,encounterIndex)
	return encounters[encounterIndex] or (LFRofthepast.instance2bossesAlt[instanceID] and LFRofthepast.instance2bossesAlt[instanceID][encounterIndex] and encounters[LFRofthepast.instance2bossesAlt[instanceID][encounterIndex]]) or false;
end

local function CreateEncounterTooltip(parent, append)
	if --[[IsInstance() or]] IsInRaid() then
		local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID, instanceGroupSize = GetInstanceInfo()
		if not (difficultyID==7 or difficultyID==17) then return end
		local data = InstanceGroups[instanceName];
		if data then
			if not append then
				GameTooltip:SetOwner(parent,"ANCHOR_NONE");
				local point,relPoint,y,rectLeft,rectBottom = "TOP","BOTTOM",-5,parent:GetRect();
				if GetScreenHeight()/2>rectBottom then
					point,relPoint,y = "BOTTOM","TOP",5
				end
				GameTooltip:SetPoint(point,parent,relPoint,0,y);
			end
			GameTooltip:SetText(instanceName);
			GameTooltip:AddLine(difficultyName,1,1,1);

			for i=1, #data do
				GameTooltip:AddLine(" ");
				GameTooltip:AddLine(C("ltblue",data[i][2]));

				local encounter = GetEncounterStatus(data[i][1]);
				local i2b = LFRofthepast.instance2bosses[data[i][1]];
				--local more = IsControlKeyDown();
				local encList = i2b or encounter
				for e=1, #encList do
					local enc = GetEncounterInfo(data[i][1],encList,encList[b])
				end
				if i2b then -- lfr
					for b=1, #i2b do
						local enc = GetEncounterInfo(data[i][1],encounter,i2b[b])
						GameTooltip:AddDoubleLine("|Tinterface/questtypeicons:14:14:0:0:128:64:0:18:36:54|t "..enc[1],enc[2] and C("red",BOSS_DEAD) or C("green",BOSS_ALIVE));
					end
				else -- normal raid
					for b=1, #encounter do
						local enc = GetEncounterInfo(data[i][1],encounter,b)
					end
				end
				if enc then
					GameTooltip:AddDoubleLine("|Tinterface/questtypeicons:14:14:0:0:128:64:0:18:36:54|t "..enc[1],enc[2] and C("red",BOSS_DEAD) or C("green",BOSS_ALIVE));
				end
			end

			GameTooltip:Show();
			if append then
				return true;
			end
		end
	end
end

-- QueueStatusFrame hook to add tooltip to the QueueStatusFrame tooltip
QueueStatusFrame:HookScript("OnShow",function(parent)
	--if db.profile.queueStatusFrameETT then
		CreateEncounterTooltip(parent);
	--end
end);

QueueStatusFrame:HookScript("OnHide",function(parent)
	GameTooltip:Hide();
end);

------------------------------------------------------ event frame
local LFRofthepastFrame = CreateFrame("frame");
LFRofthepastFrame:SetScript("OnEvent",function(self,event,...)
	if not LFRofthepast.faction(true) and (event=="PLAYER_LOGIN" or event=="NEUTRAL_FACTION_SELECT_RESULT") then
		RequestRaidInfo();
		LFRofthepast.load_data();
	elseif event=="BOSS_KILL" then
		BossKillQueryUpdate=true;
		C_Timer.After(0.16,RequestRaidInfoUpdate);
	elseif event=="UPDATE_INSTANCE_INFO" then
		BossKillQueryUpdate=false;
		if not UpdateInstanceInfoLock then
			UpdateInstanceInfoLock = true;
			C_Timer.After(0.3,ScanSavedInstances);
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