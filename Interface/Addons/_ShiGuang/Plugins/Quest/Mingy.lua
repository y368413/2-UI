----------------------------------------## Version: 1.3.1-- Mingy by Sonaza-- http://sonaza.com----------------------------------------
local Mingy = {
	Frame = nil,
	RewardButton = nil,
	RewardIndex = nil,
	QuestRewardsNum = 0,
	QuestRewardRarity = 0,
};

function Mingy:Initialize()
	if (ShiGuangDB.MingyAutoComplete == nil) then ShiGuangDB.MingyAutoComplete = false end
	Mingy.Frame:RegisterEvent("QUEST_ITEM_UPDATE");
	Mingy.Frame:RegisterEvent("QUEST_COMPLETE");
	Mingy.Frame:RegisterEvent("QUEST_FINISHED");
	Mingy.Frame:RegisterEvent("QUEST_DETAIL");
	--Mingy.RewardButton	= CreateFrame("button", nil, UIParent, "UIPanelButtonTemplate");
	--Mingy.RewardButton:SetWidth(120);
	--Mingy.RewardButton:SetHeight(22);
	--Mingy.RewardButton:SetPoint("BOTTOMRIGHT", "QuestFrame", "BOTTOMRIGHT", -6, 4);
	--Mingy.RewardButton:SetText("选最贵的");
	--Mingy.RewardButton:SetScript("OnClick", Mingy.ChooseReward);
	--Mingy.RewardButton:SetFrameStrata("DIALOG");
	--Mingy.RewardButton:Hide();
end

function Mingy:Load()
	
	Mingy.Frame	= CreateFrame("Frame");
	Mingy.Frame:SetScript("OnEvent", Mingy.EventHandler);
	
	Mingy.Frame:RegisterEvent("ADDON_LOADED");
	
end

function Mingy:ChooseReward()
	if(Mingy.QuestRewardsNum <= 1) then return; end
	local itemFrame	= _G["QuestInfoRewardsFrameQuestInfoItem" .. Mingy.RewardIndex];	
	QuestInfoFrame.itemChoice			= Mingy.RewardIndex;
	QuestFrameRewardPanel.itemChoice	= Mingy.RewardIndex;
	-- GetQuestReward(QuestFrameRewardPanel.itemChoice);
	QuestInfoItemHighlight:SetPoint("TOPLEFT", itemFrame, "TOPLEFT", -8, 7);
	QuestInfoItemHighlight:Show();
end

function Mingy:ScanRewards(event)
	if(Mingy.QuestRewardsNum > 1) then
		local failed = false;
		local rewardIndex;
		for rewardIndex = 1, Mingy.QuestRewardsNum do						
			local rewardLink	= GetQuestItemLink("choice", rewardIndex);		
			if(rewardLink == nil) then			
				failed = true;			
			else			
				local _, _, rarity, _, _, _, _, _, _, _, goldValue = GetItemInfo(rewardLink);	
				-- Choose only items that are common, uncommon or rare
				if(rarity <= 4) then
					if(Mingy.QuestRewardRarity <= rarity) then
						Mingy.QuestRewardRarity = rarity;
					end				
					if(goldValue >= Mingy.HighestGold) then
						Mingy.HighestGold		= goldValue;
						Mingy.HighestItemLink	= rewardLink;
						Mingy.HighestIndex		= rewardIndex;
					end
				end		
			-- Mingy.QuestRewards[rewardIndex] = rewardLink;
			end
		end	
		if(not failed and Mingy.HighestIndex > 0 and Mingy.HighestGold > 0) then	
			Mingy.RewardIndex = Mingy.HighestIndex;
			--Mingy.RewardButton:Show();	
			local rewardTextFrame = QuestInfoRewardsFrame.ItemChooseText;		
			rewardTextFrame:SetText(Mingy.HighestItemLink .. " " .. Mingy:FormatGoldText(Mingy.HighestGold) .. "|n|n" .. rewardTextFrame:GetText());
			if (ShiGuangDB.MingyAutoComplete == true) then				
			 	Mingy:ChooseReward();			
			 	button	= _G["QuestFrameCompleteQuestButton"];
			 	if(button) then button:Click() end			
		 end			
		end
	else	
		--Mingy.RewardButton:Hide();	
	end
end

function Mingy:EventHandler(event, ...)
	local arg1, arg2, arg3 = ...;
	if (event == "ADDON_LOADED") then
		Mingy:Initialize();
	end
	if (event == "QUEST_ITEM_UPDATE" and Mingy.RewardIndex == nil) then
		Mingy:ScanRewards(event);
	end
	if event == "QUEST_COMPLETE" then	
		Mingy.HighestGold, Mingy.HighestItemLink, Mingy.HighestIndex = 0, 0, 0;
		Mingy.RewardIndex = nil;		
		Mingy.QuestRewardsNum	= GetNumQuestChoices();		
		Mingy:ScanRewards(event);	
	end
	--if(event == "QUEST_FINISHED" or event == "QUEST_DETAIL") then		
		--Mingy.RewardButton:Hide();		
	--end
end
Mingy:Load();

function Mingy:FormatGoldText(money)
	local gold = floor(money / 10000);
	local silver = floor((money - gold * 10000) / 100);
	local copper = mod(money, 100);	
	if(gold > 0) then
		return format(GOLD_AMOUNT_TEXTURE.." "..SILVER_AMOUNT_TEXTURE.." "..COPPER_AMOUNT_TEXTURE, gold, 0, 0, silver, 0, 0, copper, 0, 0);
	elseif(silver > 0) then
		return format(SILVER_AMOUNT_TEXTURE.." "..COPPER_AMOUNT_TEXTURE, silver, 0, 0, copper, 0, 0);
	else
		return format(COPPER_AMOUNT_TEXTURE, copper, 0, 0);
	end
end

--[[
local frame = CreateFrame("FRAME", "GreedyQuester", UIParent)
frame:RegisterEvent("QUEST_COMPLETE")
frame:SetScript("OnEvent", function() 
  local max, max_index = 0, 0
  for x=1,GetNumQuestChoices() do 
    local item = GetQuestItemLink("choice", x)
    if item then
      local price = select(11, GetItemInfo(item))
      if price > max then
        max, max_index = price, x
      end
    end
  end
  local button = _G["QuestInfoItem"..max_index]
  if button then button:Click() end
end)]]