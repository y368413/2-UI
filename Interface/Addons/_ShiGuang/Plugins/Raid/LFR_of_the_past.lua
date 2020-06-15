

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
local buttons,hookedButton,NPC_ID = {},{},{},(UnitGUID("target"));
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
			GameTooltip:AddLine("|cFFA0A0A0"..buttons[buttonID].instance[name2].."|r");
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

local function raidButton(button,icon,data)
	icon:SetTexture("interface\\minimap\\raid");
	iconTexCoords[icon] = {icon:GetTexCoord()};
	icon:SetTexCoord(0.20,0.80,0.20,0.80);
	local label = data.instance[name].."\n|Tinterface\\lfgframe\\ui-lfg-icon-heroic:12:12:0:0:32:32:0:16:0:16|t ".."|cFF800000".._G.GENERIC_FRACTION_STRING:format(data.numEncounters[1],data.numEncounters[2]).."|r";
	if data.instance[name]~=data.instance[name2] then
		label = label .. " || ".. "|cFF404040"..data.instance[name2].."|r";
	end
	button:SetText(label);
end

local function szenarioButton(button,icon,data)
	icon:SetTexture("interface\\minimap\\dungeon");
	iconTexCoords[icon] = {icon:GetTexCoord()};
	icon:SetTexCoord(0.20,0.80,0.20,0.80);
	local label = {data.instance[name]};
	if data.instance[difficulty]==1 then
		tinsert(label,"|cFF000088".." ("..PLAYER_DIFFICULTY2..")".."|r");
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