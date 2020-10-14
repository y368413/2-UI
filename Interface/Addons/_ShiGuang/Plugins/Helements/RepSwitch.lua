--## Author: Ne0nguy  ## Version: 8.3.0.21
RepSwitch = {};
RepSwitch.lastupdate = 0;
RepSwitch.lastamount = 0;
RepSwitch.frame = CreateFrame("Frame", nil, UIParent);
RepSwitch.frame:RegisterEvent("COMBAT_TEXT_UPDATE");
RepSwitch.frame:SetScript("OnEvent", function(_, event, arg1)
	if(event == "COMBAT_TEXT_UPDATE" and arg1 == "FACTION") then
		if (select(4, GetBuildInfo()) < 80000) or (UnitLevel("player") == 120) then
			local faction, amount = GetCurrentCombatTextEventInfo()
			--print(faction);
			if (faction ~= "Guild") then
				if (amount > RepSwitch.lastamount) or (time() > RepSwitch.lastupdate) then
					for i=1,GetNumFactions() do
						if faction == GetFactionInfo(i) then
							--print(i);
							SetWatchedFactionIndex(i);
						end
					end
				end
				RepSwitch.lastamount = amount;
				RepSwitch.lastupdate = time();
			end
		end
	end
end);