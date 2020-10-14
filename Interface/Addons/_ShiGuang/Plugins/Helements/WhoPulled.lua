WhoPulled_GUIDs = {};
WhoPulled_MobToPlayer = {};
WhoPulled_LastMob = "";
WhoPulled_PetsToMaster = {};
WhoPulled_Msg = "%r >>%p<< 开怪 %e!!!";
WhoPulled_MobList = {
	"87320",
	"94515", "90284", "90435", "92142", "92144", "92146", "90378", "90199", "90316", "92330", "89890", "93068", "90269", "91305", "91331", -- 地狱火堡垒
	"109943", "109331", "110378", "99929", "108879", "108829", "110321", "107023", "108678", "106981", "106982", "106984", "112350", -- 破碎群岛
	"102672","105304", "106087", "100497", "102679", "102683", "102682", "102681", "104636", "103769", -- 翡翠梦魇
};

function WhoPulled_ClearPulledList() wipe(WhoPulled_GUIDs); end

function WhoPulled_PullBlah(wplayer,enemy)
	local _, _, _, _, _, MobID = strsplit("-", enemy[1]);
	if (GetNumGroupMembers() > 0) and  MobID then
		if(not UnitIsDead("player") and not WhoPulled_GUIDs[enemy[1]]) then
			WhoPulled_GUIDs[enemy[1]] = true;
			WhoPulled_MobToPlayer[enemy[2]] = wplayer;
			WhoPulled_LastMob = enemy[2];
			local i;
			i = 1;
			for i=1, #WhoPulled_MobList do
				if strlower(WhoPulled_MobList[i]) == strlower(MobID) then
					--if(UnitInRaid("player") and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player"))) then
						--WhoPulled_RaidWarning(enemy[2]);
					--else
						WhoPulled_Me(enemy[2]);
					--end
					break;
				end
				i = i+1;
			end
		end
	end
end

function WhoPulled_GetPetOwner(pet)
	if(WhoPulled_PetsToMaster[pet]) then return WhoPulled_PetsToMaster[pet]; end
	if(UnitInRaid("player")) then
		for i=1,40,1 do
			if(UnitGUID("raidpet"..i) == pet) then return UnitName("raid"..i); end
		end
	else
		if(UnitGUID("pet") == pet) then return UnitName("player"); end
		for i=1,5,1 do
			if(UnitGUID("partypet"..i) == pet) then return UnitName("party"..i); end
		end
	end
	return "Unknown";
end

function WhoPulled_ScanForPets()
	if(UnitInRaid("player")) then
		for i=1,39,1 do
			if(UnitExists("raidpet"..i)) then WhoPulled_PetsToMaster[UnitGUID("raidpet"..i)] = UnitName("raid"..i); end
		end
	else
		if(UnitExists("pet")) then WhoPulled_PetsToMaster[UnitGUID("pet")] = UnitName("player"); end
		for i=1,4,1 do
			if(UnitExists("partypet"..i)) then WhoPulled_PetsToMaster[UnitGUID("partypet"..i)] = UnitName("party"..i); end
		end
	end
end

function WhoPulled_IgnoreddSpell(spell)
	if(spell == 137619) then return true; end
	return false;
end

function WhoPulled_CheckWho(...)
	local time,event,hidecaster,sguid,sname,sflags,sraidflags,dguid,dname,dflags,draidflags,arg1,arg2,arg3,itype;

	time,event,hidecaster,sguid,sname,sflags,sraidflags,dguid,dname,dflags,draidflags,arg1,arg2,arg3 = select(1, ...);
	if(dname and sname and dname ~= sname and not string.find(event,"_RESURRECT") and not string.find(event,"_CREATE") and (string.find(event,"SWING") or string.find(event,"RANGE") or string.find(event,"SPELL"))) then
		if(not string.find(event,"_SUMMON")) then
			if(bit.band(sflags,COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 and bit.band(dflags,COMBATLOG_OBJECT_TYPE_NPC) ~= 0) then
				--A player is attacking a mob
				if(not WhoPulled_IgnoreddSpell(arg1)) then
					WhoPulled_PullBlah(sname,{dguid,dname});
				end
			elseif(bit.band(dflags,COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 and bit.band(sflags,COMBATLOG_OBJECT_TYPE_NPC) ~= 0) then
				--A mob is attacking a player (stepped onto, perhaps?)
				WhoPulled_PullBlah(dname,{sguid,sname});
			elseif(bit.band(sflags,COMBATLOG_OBJECT_CONTROL_PLAYER) ~= 0 and bit.band(dflags,COMBATLOG_OBJECT_TYPE_NPC) ~= 0) then
				--Player's pet attacks a mob
				local pullname;
				pname = WhoPulled_GetPetOwner(sguid);
				if(pname == "Unknown") then pullname = sname.." (宠物)";
				else pullname = pname;
				end
				WhoPulled_PullBlah(pullname,{dguid,dname});
			elseif(bit.band(sflags,COMBATLOG_OBJECT_CONTROL_PLAYER) ~= 0 and bit.band(sflags,COMBATLOG_OBJECT_TYPE_NPC) ~= 0) then
				--Mob attacks a player's pet
				local pullname;
				pname = WhoPulled_GetPetOwner(dguid);
				if(pname == "Unknown") then pullname = dname.." (宠物)";
				else pullname = pname;
				end
				WhoPulled_PullBlah(pullname,{sguid,sname});
			end
		else
	 	--Record summon
		WhoPulled_PetsToMaster[dguid] = sname;
		end
	end
end

function WhoPulled_SendMsg(chat,enemy)
	local msg,player,wprole,role;
	if enemy == "" then enemy = WhoPulled_LastMob; end
	player = WhoPulled_MobToPlayer[enemy];
	wprole = UnitGroupRolesAssigned(player);
	if(wprole == "TANK") then role = "坦克"; else role = ">>>"; end
	if player then
		msg = WhoPulled_Msg:gsub("%%r",role);
		msg = msg:gsub("%%p",player);
		msg = msg:gsub("%%e",enemy);
		if(chat == "ECHO") then
			DEFAULT_CHAT_FRAME:AddMessage(msg);
		else
			SendChatMessage(msg,chat);
		end
	end
end

function WhoPulled_Say(enemy)
	WhoPulled_SendMsg("SAY",enemy);
end
function WhoPulled_Yell(enemy)
	WhoPulled_SendMsg("YELL",enemy);
end
function WhoPulled_Raid(enemy) -- needs check if in a raid
	WhoPulled_SendMsg("RAID",enemy);
end
function WhoPulled_Party(enemy) -- needs checks to force /i if not in a real party, and default chat frame if not in a party at all
	WhoPulled_SendMsg("PARTY",enemy);
end
function WhoPulled_BG(enemy) -- needs check if in a bg
	WhoPulled_SendMsg("BATTLEGROUND",enemy);
end
function WhoPulled_Guild(enemy) -- needs check if in a guild
	WhoPulled_SendMsg("GUILD",enemy);
end
function WhoPulled_Officer(enemy) -- needs check if in a guild and if officer chat is available (if such check is even possible)
	WhoPulled_SendMsg("OFFICER",enemy);
end
function WhoPulled_RaidWarning(enemy) -- needs check if in a raid
	WhoPulled_SendMsg("RAID_WARNING",enemy);
end
function WhoPulled_Me(enemy)
	WhoPulled_SendMsg("ECHO",enemy);
end

local WhoPulledFrame = CreateFrame("FRAME");
WhoPulledFrame:Hide()
WhoPulledFrame:SetSize(140, 210)
WhoPulledFrame:SetPoint("TOPLEFT",1, 1)
WhoPulledFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
WhoPulledFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
WhoPulledFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
WhoPulledFrame:RegisterEvent("RAID_INSTANCE_WELCOME");
WhoPulledFrame:SetScript("OnEvent",function(self, event, ...)
	if(event=="COMBAT_LOG_EVENT_UNFILTERED")then
		WhoPulled_CheckWho(...);
	elseif(event == "PLAYER_REGEN_ENABLED") then
		WhoPulled_ClearPulledList();
	elseif(event == "GROUP_ROSTER_UPDATE") then
		WhoPulled_ScanForPets();
	elseif(event == "RAID_INSTANCE_WELCOME") then
		WhoPulled_ScanForPets();
	end
end);