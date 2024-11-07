local SkullMarker = 8;
local CurrentMarker = SkullMarker;
local UsedMarkers = {};
local IsOnWorldQuest = false;
local BarrelQuests = {[45068]=true,[45069]=true,[45070]=true,[45071]=true,[45072]=true,};

local BarrelsFrame = CreateFrame("Frame");
BarrelsFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
BarrelsFrame:RegisterEvent("QUEST_ACCEPTED");
BarrelsFrame:RegisterEvent("QUEST_REMOVED");
BarrelsFrame:SetScript("OnEvent", function(self,event,arg1,arg2)
	if event == "PLAYER_ENTERING_WORLD" then
		if BarrelsOEasyShowMessageCount == nil then
			BarrelsOEasyShowMessageCount = 0;
		end
		local questLogCount = C_QuestLog.GetNumQuestLogEntries();
		for i = 1, questLogCount do
			local title, _, _, _, _, _, _, questID = C_QuestLog.GetInfo(i);
			if BarrelQuests[questID] then
				self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
				CurrentMarker = SkullMarker;
				IsOnWorldQuest = true;
				
				if BarrelsOEasyShowFrame then
					BOEIconFrame:Show();
				end
			end
		end
	elseif event == "QUEST_ACCEPTED" then
		if (arg1 and BarrelQuests[arg1]) or (arg2 and BarrelQuests[arg2]) then
			IsOnWorldQuest = true;
			
			if IsInGroup() then
				RaidNotice_AddMessage(RaidWarningFrame, "啊噢.你在队伍里会导致欢乐桶插件抽风", ChatTypeInfo["SYSTEM"]);
				DEFAULT_CHAT_FRAME:AddMessage("Sorry，在队伍你会导致每次点击欢乐桶后，标记都会因为刷新而消失.", 1.0, 0.0, 0.0, ChatTypeInfo["RAID_WARNING"], 6);
			end
			
			if BarrelsOEasyShowMessageCount < 5 then
				RaidNotice_AddMessage(RaidWarningFrame, "请开始第一轮,小桶子运动完才能开始标记。", ChatTypeInfo["RAID_WARNING"])
				BarrelsOEasyShowMessageCount = BarrelsOEasyShowMessageCount + 1;
			end
			self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
			CurrentMarker = SkullMarker;
		end
	elseif event == "QUEST_REMOVED" then
		if (arg1 and BarrelQuests[arg1]) or (arg2 and BarrelQuests[arg2]) then
			self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
			CurrentMarker = SkullMarker;
		end
	elseif event == "UPDATE_MOUSEOVER_UNIT" then
		local guid = UnitGUID("mouseover");	
		if guid ~= nil then
			local _,_,_,_,_,id,_ = strsplit("-", guid)
			if id == "115947" then
				if not UsedMarkers[guid] then
					UsedMarkers[guid] = CurrentMarker;
					CurrentMarker = CurrentMarker - 1;
					if CurrentMarker == 0 then
						CurrentMarker = SkullMarker;
					end
				end
					if GetRaidTargetIndex("mouseover") ~= UsedMarkers[guid] then
					SetRaidTarget("mouseover", UsedMarkers[guid]);
				end
			end
		end
	end
end)