-- HandyNotes Worldmap Button by fuba

local function SetIconTooltip(IsRev)
	if not WorldMapTooltip then return end
	WorldMapTooltip:Hide();
	WorldMapTooltip:SetOwner(HandyNotesWorldMapButton, "ANCHOR_BOTTOMLEFT");
	if HandyNotes:IsEnabled() then
		WorldMapTooltip:AddLine(HIDE..EMBLEM_SYMBOL, nil, nil, nil, nil, 1 );
	else
		WorldMapTooltip:AddLine(SHOW_MAP..ALL..EMBLEM_SYMBOL, nil, nil, nil, nil, 1 );
	end
	WorldMapTooltip:Show();
end

local HandyNotesWorldMapButton = CreateFrame("Button", "HandyNotesWorldMapButton", WorldMapFrame.BorderFrame, "UIPanelButtonTemplate");
HandyNotesWorldMapButton:ClearAllPoints();
HandyNotesWorldMapButton:SetPoint("TOPRIGHT",-68,0);
HandyNotesWorldMapButton:SetSize(24, 24);
HandyNotesWorldMapButton:SetText("*");
HandyNotesWorldMapButton:RegisterForClicks("AnyUp");
HandyNotesWorldMapButton:SetScript("OnEnter", function(self, motion) SetIconTooltip(false); end);
HandyNotesWorldMapButton:SetScript("OnLeave", function(self, motion) if WorldMapTooltip then WorldMapTooltip:Hide(); end end);
HandyNotesWorldMapButton:SetScript("OnClick", function(self)
	local db = LibStub("AceDB-3.0"):New("HandyNotesDB", defaults).profile;
	if HandyNotes:IsEnabled() then
		db.enabled = false
		HandyNotes:Disable();
	else
		db.enabled = true
		HandyNotes:Enable();
	end
	SetIconTooltip(false);
end);