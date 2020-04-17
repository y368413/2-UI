-- HandyNotes Worldmap Button by fuba
--Version: 80205.01-Release ## Author: fuba
local HandyNotesWorldMapButtonFrame = CreateFrame("Frame");
local HandyNotesWorldMapButton = CreateFrame("Button", "HandyNotesWorldMapButtonFrame", WorldMapFrame.BorderFrame, "UIPanelButtonTemplate");
HandyNotesWorldMapButton:ClearAllPoints();
HandyNotesWorldMapButton:SetPoint("TOPRIGHT",-68,0);
HandyNotesWorldMapButton:SetSize(24, 24);
HandyNotesWorldMapButton:SetText("*");
HandyNotesWorldMapButton:RegisterForClicks("AnyUp");

function SetIconTooltip(IsRev)
  WorldMapTooltip:Hide();
  WorldMapTooltip:SetOwner(HandyNotesWorldMapButton, "ANCHOR_BOTTOMLEFT");
  if HandyNotes:IsEnabled() then
    WorldMapTooltip:AddLine(HIDE..EMBLEM_SYMBOL, nil, nil, nil, nil, 1 );
  else
    WorldMapTooltip:AddLine(SHOW_MAP..ALL..EMBLEM_SYMBOL, nil, nil, nil, nil, 1 );
  end
  WorldMapTooltip:Show();
end

local function btnOnClick(self)
  local db = LibStub("AceDB-3.0"):New("HandyNotesDB", defaults).profile;
  if HandyNotes:IsEnabled() then
    db.enabled = false
    HandyNotes:Disable();
  else
    db.enabled = true
    HandyNotes:Enable();
  end
  SetIconTooltip(false);
 end

HandyNotesWorldMapButton:SetScript("OnClick", btnOnClick);
HandyNotesWorldMapButton:SetScript("OnEnter", function(self, motion) SetIconTooltip(false); end);
HandyNotesWorldMapButton:SetScript("OnLeave", function(self, motion) WorldMapTooltip:Hide(); end);
HandyNotesWorldMapButtonFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
HandyNotesWorldMapButtonFrame:RegisterEvent("ADDON_LOADED")
HandyNotesWorldMapButtonFrame:SetScript("OnEvent", function(self, event, ...)
  if (event == "PLAYER_ENTERING_WORLD") then
        HandyNotesWorldMapButton:Show();
  end
  -- Move the MapsterOptionsButton by the Width of HandyNotesWorldMapButtonFrame to prevent overlap
  if event == "ADDON_LOADED" then
    if (MapsterOptionsButton) and (not MapsterOptionsButton.MovedByHandyNotesWorldMapButton) then
      point, relativeTo, relativePoint, xOfs, yOfs = MapsterOptionsButton:GetPoint()
      MapsterOptionsButton:ClearAllPoints();
      MapsterOptionsButton:SetPoint(point, relativeTo, relativePoint, xOfs - HandyNotesWorldMapButton:GetWidth() - 5, yOfs);
      HandyNotesWorldMapButtonFrame:UnregisterEvent("ADDON_LOADED");
      MapsterOptionsButton.MovedByHandyNotesWorldMapButton = true;
    end
  end
end)