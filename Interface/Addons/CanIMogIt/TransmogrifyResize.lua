--## Version: 1.5  ## Author: Eskiso
local TransmogrifyResize = CreateFrame("Frame");
TransmogrifyResize:RegisterEvent("TRANSMOGRIFY_OPEN")
--TransmogrifyResize:RegisterAllEvents();

TransmogrifyResize:SetScript("OnEvent", function(self,event, ...)
    if event == "TRANSMOGRIFY_OPEN" then
        -- print("Improving Transmog window...")
        ResizeTransmogrify();
    end  
end)

local isAddedResize = false

function ResizeTransmogrify(frameWidth, frameHeight)
    if frameWidth == nil then
        frameWidth = GetScreenWidth() - 460;   -- 1462
    end
    
    if frameHeight == nil then
        frameHeight = GetScreenHeight() - 240; -- 841
    end
    local modelSceneWidth = frameWidth - 662; -- 800
    local modelSceneHeight = frameHeight - 111; -- 730
    if WardrobeFrame ~= nil then
        WardrobeFrame:SetWidth(frameWidth);
        WardrobeFrame:SetHeight(frameHeight);
        WardrobeTransmogFrame.ModelScene:SetWidth(modelSceneWidth);
        WardrobeTransmogFrame:SetWidth(modelSceneWidth);
        WardrobeTransmogFrame:SetHeight(modelSceneHeight);
        WardrobeTransmogFrame.ModelScene:SetHeight(modelSceneHeight);
        WardrobeTransmogFrame.Inset.BG:SetWidth(modelSceneWidth);
        WardrobeTransmogFrame.Inset.BG:SetHeight(modelSceneHeight);
        WardrobeTransmogFrame.HeadButton:SetPoint("LEFT", WardrobeTransmogFrame.ModelScene,"LEFT", 15, 100);
        WardrobeTransmogFrame.HandsButton:SetPoint("TOPRIGHT", WardrobeTransmogFrame.ModelScene,"TOPRIGHT", -15, 0);
        WardrobeTransmogFrame.MainHandButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", -50, 15);
        WardrobeTransmogFrame.SecondaryHandButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 50, 15);
        WardrobeTransmogFrame.MainHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 100, 20);
        WardrobeTransmogFrame.SecondaryHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 100, 20);
        WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:SetPoint("LEFT", WardrobeTransmogFrame.ModelScene,"TOPRIGHT", 50, -200);
        WardrobeFrame:ClearAllPoints();
        WardrobeFrame:SetPoint("CENTER", UIParent ,"CENTER",0,0);

        if isAddedResize == false then
            local resizeButton = CreateFrame("Button", nil, WardrobeFrame)
            resizeButton:SetSize(16, 16)
            resizeButton:SetPoint("BOTTOMRIGHT")
            resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
            resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
            resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
             
            resizeButton:SetScript("OnMouseDown", function(self, button)
                WardrobeFrame:SetResizable(true)
                WardrobeFrame:StartSizing("BOTTOMRIGHT")
                WardrobeFrame:SetUserPlaced(true)

            end)
             
            resizeButton:SetScript("OnMouseUp", function(self, button)
                WardrobeFrame:StopMovingOrSizing()
                local newWidth = WardrobeFrame:GetWidth()
                local newHeight = WardrobeFrame:GetHeight()
                ResizeTransmogrify(newWidth, newHeight);

            end)
            isAddedResize = true
        end

    else
        print("TransmogrifyResize: Event occured but no Wardrobe found.")
    end
    -- WardrobeFrame:SetUserPlaced(true);
end


