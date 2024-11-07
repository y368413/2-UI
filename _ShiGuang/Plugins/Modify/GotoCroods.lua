-- 输入坐标标记位置
local WayPointPositionButton = CreateFrame("Button", "WayPointPositionButton", WorldMapFrame.BorderFrame, "UIPanelButtonTemplate")
WayPointPositionButton:SetWidth(50)
WayPointPositionButton:SetHeight(18)
WayPointPositionButton:SetText("定位")
WayPointPositionButton:SetPoint("TOPRIGHT", WorldMapFrame.BorderFrame, "TOPRIGHT", -90, -2)
WayPointPositionButton:SetScript("OnShow", function() WayPointContainer:Close() end)

-- 设置目标位置
function WayPointPositionButton:SetWayPoint(desX, desY)
    local currentViewMapID = WorldMapFrame:GetMapID()
    if C_Map.CanSetUserWaypointOnMap(currentViewMapID) then
        local point = UiMapPoint.CreateFromCoordinates(currentViewMapID, desX / 100, desY / 100)
        C_Map.SetUserWaypoint(point)
        C_SuperTrack.SetSuperTrackedUserWaypoint(true);
    else
        print("|cFFFF0000当前地图无法标记！|r")
    end
end

-- 点击定位按钮
function WayPointPositionButton.OnClick(widget, button, down)
    if button == "RightButton" then
        C_Map.ClearUserWaypoint()
        C_SuperTrack.SetSuperTrackedUserWaypoint(false);
        return
    end
    local currentViewMapID = WorldMapFrame:GetMapID()
    if not C_Map.CanSetUserWaypointOnMap(currentViewMapID) then
        print("|cFFFF0000当前地图无法标记！|r")
        return
    end
    if WayPointContainer then
        if WayPointContainer:IsShown() then
            local xl = WayPointContainer.CoordX:GetText():len()
            local yl = WayPointContainer.CoordY:GetText():len()
            if xl ~= 0 and yl ~= 0 then
                local x = WayPointContainer.CoordX:GetNumber()
                local y = WayPointContainer.CoordY:GetNumber()
                WayPointPositionButton:SetWayPoint(x, y)
            end
            WayPointContainer:Close()
        else
            WayPointContainer:Show()
            WayPointContainer.CoordX:SetFocus()
        end
    end
end
WayPointPositionButton:SetScript("OnClick", WayPointPositionButton.OnClick)

local WayPointContainer = CreateFrame("Frame", "WayPointContainer", WorldMapFrame)
WayPointContainer:SetFrameStrata("DIALOG")
WayPointContainer:SetPoint("RIGHT", WayPointPositionButton, "LEFT", 0, -1)
WayPointContainer:SetWidth(100)
WayPointContainer:SetHeight(25)

function WayPointContainer:Close()
    WayPointContainer.CoordX:SetText("")
    WayPointContainer.CoordX:ClearFocus()
    WayPointContainer.CoordY:SetText("")
    WayPointContainer.CoordY:ClearFocus()
    WayPointContainer:Hide()
end

-- 输入tab
local function OnCoordTabPressed(editBox)
    if editBox == WayPointContainer.CoordX then
        WayPointContainer.CoordX:ClearFocus()
        WayPointContainer.CoordY:SetFocus()
    else
        WayPointContainer.CoordY:ClearFocus()
        WayPointContainer.CoordX:SetFocus()
    end
end

-- 输入回车
local function OnCoordEnterPressed(editBox)
    if editBox == WayPointContainer.CoordX then
        if editBox:GetText():len() ~= 0 then
            WayPointContainer.CoordX:ClearFocus()
            WayPointContainer.CoordY:SetFocus()
        end
    else
        if WayPointContainer.CoordX:GetText():len() ~= 0 and
            WayPointContainer.CoordY:GetText():len() ~= 0 then
            local x = WayPointContainer.CoordX:GetNumber()
            local y = WayPointContainer.CoordY:GetNumber()
            WayPointPositionButton:SetWayPoint(x, y)
            WayPointContainer:Close()
        elseif WayPointContainer.CoordY:GetText():len() ~= 0 and
            WayPointContainer.CoordX:GetText():len() == 0 then
            WayPointContainer.CoordY:ClearFocus()
            WayPointContainer.CoordX:SetFocus()
        end
    end
end

WayPointContainer.CoordY = CreateFrame("EditBox", "WayPointCoordY", WayPointContainer, "InputBoxTemplate")
WayPointContainer.CoordY:SetAutoFocus(false)
WayPointContainer.CoordY:SetSize(30, 20)
WayPointContainer.CoordY:SetNumeric(true)
WayPointContainer.CoordY:SetMaxLetters(2)
WayPointContainer.CoordY:SetPoint("LEFT", WayPointContainer, "CENTER", 0, 0)
WayPointContainer.CoordY:SetScript("OnTabPressed", OnCoordTabPressed)
WayPointContainer.CoordY:SetScript("OnEnterPressed", OnCoordEnterPressed)

WayPointContainer.CoordX = CreateFrame("EditBox", "WayPointCoordX", WayPointContainer, "InputBoxTemplate")
WayPointContainer.CoordX:SetAutoFocus(false)
WayPointContainer.CoordX:SetSize(30, 20)
WayPointContainer.CoordX:SetNumeric(true)
WayPointContainer.CoordX:SetMaxLetters(2)
WayPointContainer.CoordX:SetPoint("RIGHT", WayPointContainer, "CENTER", -6, 0)
WayPointContainer.CoordX:SetScript("OnTabPressed", OnCoordTabPressed)
WayPointContainer.CoordX:SetScript("OnEnterPressed", OnCoordEnterPressed)

WayPointContainer:Hide()