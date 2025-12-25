--## Version: 1.3.00
local BOEIconFrame = CreateFrame("Frame", "BOEIconFrame", UIParent, "BackdropTemplate");
local BarrelsFrame = CreateFrame("Frame");
local Buttons = {};
local SkullMarker = 8;
local CurrentMarker = SkullMarker;
local UsedMarkers = {};
local FrameShown = false;
local IsOnWorldQuest = false;
local BarrelQuests = {[45068]=true,[45069]=true,[45070]=true,[45071]=true,[45072]=true,};
local TexturePath = "Interface\\TargetingFrame\\UI-RaidTargetingIcons.blp";

local function AddButton(index, parent)
	Buttons[index] = CreateFrame("CheckButton", "Radio" .. index, BOEIconFrame, "UICheckButtonTemplate");
	local texture 	 = Buttons[index]:CreateTexture("BarrelsOEasyTarget" .. index);
	
	Buttons[index]:ClearAllPoints();
	Buttons[index]:SetWidth(32);
	Buttons[index]:SetHeight(32);
	Buttons[index]:SetFrameStrata("FULLSCREEN_DIALOG");
	
	if index < 9 then
		texture:SetTexture(TexturePath);
		texture:SetWidth(32);
		texture:SetHeight(32);
		texture:SetPoint("TOPRIGHT", Buttons[index], "TOPRIGHT", 30, 0);
	end
	
	if parent ~= nil then
		Buttons[index]:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -25);
	else
		Buttons[index]:SetPoint("BOTTOM", Buttons[index + 1], "BOTTOM", 0, -40);
	end
	
	if index > 4 then
			texture:SetTexCoord((0.25 * (index - 5)), (0.25 * (index - 4)), 0.25, 0.5);
	else
		texture:SetTexCoord((0.25 * (index - 1)), (0.25 * index), 0, 0.25);
	end

	Buttons[index]:SetScript("OnClick", function(self)
		local checkedIndex = 0;
	
		if self:GetChecked() then
			checkedIndex = self:GetName():sub(6);
		end
		
		for i = 1, 9 do
			Buttons[i]:SetChecked(false);
		end
		
		if checkedIndex ~= nil and tonumber(checkedIndex) ~= nil then
			Buttons[tonumber(checkedIndex)]:SetChecked(true);
		end
	end);
end

local function ToggleFrame()
	if not InCombatLockdown() then
		FrameShown = not FrameShown;
		
		if FrameShown then
			BOEIconFrame:Show();
		else
			print("Temporarily hiding the marker frame, type /boe hide to permanently disable it or /boe show to restore it.");
			BOEIconFrame:Hide();
		end
	end
end

BarrelsFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
BarrelsFrame:RegisterEvent("QUEST_ACCEPTED");
BarrelsFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
BarrelsFrame:RegisterEvent("QUEST_REMOVED");

BOEIconFrame:SetBackdrop({
      bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
      edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
      tile=1, tileSize=20, edgeSize=20, 
      insets={left=5, right=5, top=5, bottom=5}
})

BOEIconFrame:SetWidth(85)
BOEIconFrame:SetHeight(390)
BOEIconFrame:SetPoint("CENTER", UIParent)
BOEIconFrame:EnableMouse(true)
BOEIconFrame:SetMovable(true)
BOEIconFrame:RegisterForDrag("LeftButton")
BOEIconFrame:SetFrameStrata("FULLSCREEN_DIALOG")
BOEIconFrame:Hide()
BOEIconFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
BOEIconFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
BOEIconFrame:SetScript("OnMouseDown", BOEIconFrame.StartMoving)
BOEIconFrame:SetScript("OnMouseUp",	function(self, button)
					self:StopMovingOrSizing();
				    local from, _, to, x, y = self:GetPoint();
					BarrelsOEasyFrom = from;
					BarrelsOEasyTo = to;
					BarrelsOEasyX = x;
					BarrelsOEasyY = y;
					end);

					BOEIconFrame.Close = CreateFrame("Button", "BarrelsOEasyClose", BOEIconFrame, "UIPanelCloseButton")
BOEIconFrame.Close:SetWidth(25)
BOEIconFrame.Close:SetHeight(25)
BOEIconFrame.Close:SetPoint("TOPRIGHT", -3, -3)
BOEIconFrame.Close:SetScript("OnClick", function(self) ToggleFrame() end)

AddButton(9, BOEIconFrame);
AddButton(8);
AddButton(7);
AddButton(6);
AddButton(5);
AddButton(4);
AddButton(3);
AddButton(2);
AddButton(1);

BarrelsFrame:SetScript("OnEvent", function(self,event,arg1,arg2)
	if event == "PLAYER_ENTERING_WORLD" then
		if ShiGuangDB.BarrelsOEasyShowFrame == nil then
			ShiGuangDB.BarrelsOEasyShowFrame = true;
			local from, _, to, x, y = self:GetPoint();
			BarrelsOEasyFrom = from;
			BarrelsOEasyTo = to;
			BarrelsOEasyX = x;
			BarrelsOEasyY = y;
		end
		
		if ShiGuangDB.BarrelsOEasyShowMessageCount == nil then
			ShiGuangDB.BarrelsOEasyShowMessageCount = 0;
		end
		
		local questLogCount = C_QuestLog.GetNumQuestLogEntries();

		for i = 1, questLogCount do
			local title, _, _, _, _, _, _, questID = C_QuestLog.GetInfo(i);
			if BarrelQuests[questID] then
				self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
				CurrentMarker = SkullMarker;
				IsOnWorldQuest = true;
				
				if ShiGuangDB.BarrelsOEasyShowFrame then
					BOEIconFrame:Show();
					FrameShown = true;
				end
			end
		end
		
		if BarrelsOEasyX ~= nil and BarrelsOEasyY ~= nil then
			BOEIconFrame:ClearAllPoints();
			BOEIconFrame:SetPoint(BarrelsOEasyFrom, UIParent, BarrelsOEasyTo, BarrelsOEasyX, BarrelsOEasyY);
		end
	elseif event == "QUEST_ACCEPTED" then
		if (arg1 and BarrelQuests[arg1]) or (arg2 and BarrelQuests[arg2]) then
			IsOnWorldQuest = true;
			
			if IsInGroup() then
				RaidNotice_AddMessage(RaidWarningFrame, "Warning, being in a group will cause BarrelsOEasy's marks to clear after each round.", ChatTypeInfo["SYSTEM"]);
				DEFAULT_CHAT_FRAME:AddMessage("Warning, being in a group will cause BarrelsOEasy's marks to clear after each round.", 1.0, 0.0, 0.0, ChatTypeInfo["RAID_WARNING"], 5);
			end
			
			if ShiGuangDB.BarrelsOEasyShowMessageCount < 5 then
				RaidNotice_AddMessage(RaidWarningFrame, "Please start the first round, so that the barrels can be marked after they stop moving.", ChatTypeInfo["RAID_WARNING"]);
				ShiGuangDB.BarrelsOEasyShowMessageCount = ShiGuangDB.BarrelsOEasyShowMessageCount + 1;
			end
			 
			if ShiGuangDB.BarrelsOEasyShowFrame then
				BOEIconFrame:Show();
				FrameShown = true;
			end
			
			self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
			CurrentMarker = SkullMarker;
		end
	elseif event == "QUEST_REMOVED" then
		if (arg1 and BarrelQuests[arg1]) or (arg2 and BarrelQuests[arg2]) then
			BOEIconFrame:Hide();
			IsOnWorldQuest = false;
			FrameShown = false;
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

SLASH_BarrelsOEasy1 = "/barrels";
SLASH_BarrelsOEasy2 = "/boe";

function SlashCmdList.BarrelsOEasy(command)
	if command == nil then
		return;
	end
	
	local lowered = command:lower();
	
	if lowered == "hide" then
		FrameShown = false;
		print("Permanently hiding the marker frame, type /boe show to re-enable it.");
		ShiGuangDB.BarrelsOEasyShowFrame = false;
		BOEIconFrame:Hide();
	elseif lowered == "show" then
		FrameShown = true;
		ShiGuangDB.BarrelsOEasyShowFrame = true;
		BOEIconFrame:Show();
	end
end