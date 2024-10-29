local _, ns = ...
local M, R, U, I = unpack(ns)
local zrMM = {}

-- load config
zrMM.loader = CreateFrame("frame", nil, UIParent)
zrMM.loader:RegisterEvent("ADDON_LOADED")
zrMM.loader:SetScript("OnEvent", function(self, event, addon)
	if (addon == "_ShiGuang") then
		zrMM.loader:UnregisterEvent("ADDON_LOADED")
		zrMM:CreateButtonFrame()
	end
end)

function zrMM:border_gen(parent)
		local frame = parent:CreateTexture(nil, "BACKGROUND", nil, -8)
		frame:SetTexture("Interface\\Buttons\\WHITE8x8")
		frame:SetVertexColor(.03, .04, .05, 1)
		frame.protected = true
		return frame
	end

function zrMM:set_backdrop(frame, alpha)
	local border = 1.5  --((768 / select(2, GetPhysicalScreenSize())) / frame:GetEffectiveScale()) * 2
	alpha = alpha or 0.9
	local r, g, b, a = .08, .09, .11, 0.8

	if (not frame.zr_background) then
		frame.zr_background = frame:CreateTexture(nil, "BACKGROUND", nil, -7)
		frame.zr_background:SetTexture("Interface\\Buttons\\WHITE8x8")
		frame.zr_background:SetAllPoints()
		frame.zr_background:SetVertexColor(r, g, b, alpha)
		frame.zr_background.protected = true

		frame.t = zrMM:border_gen(frame)
		frame.t:SetPoint("BOTTOMLEFT", frame.zr_background, "TOPLEFT", -border, 0)
		frame.t:SetPoint("BOTTOMRIGHT", frame.zr_background, "TOPRIGHT", border, 0)

		frame.l = zrMM:border_gen(frame)
		frame.l:SetPoint("TOPRIGHT", frame.zr_background, "TOPLEFT", 0, border)
		frame.l:SetPoint("BOTTOMRIGHT", frame.zr_background, "BOTTOMLEFT", 0, -border)

		frame.r = zrMM:border_gen(frame)
		frame.r:SetPoint("TOPLEFT", frame.zr_background, "TOPRIGHT", 0, border)
		frame.r:SetPoint("BOTTOMLEFT", frame.zr_background, "BOTTOMRIGHT", 0, -border)

		frame.b = zrMM:border_gen(frame)
		frame.b:SetPoint("TOPLEFT", frame.zr_background, "BOTTOMLEFT", -border, 0)
		frame.b:SetPoint("TOPRIGHT", frame.zr_background, "BOTTOMRIGHT", border, 0)

		frame.border = frame:CreateTexture(nil, "BACKGROUND")
		frame.border:Hide()
		frame.border.SetVertexColor = function(self, r, g, b, a)
			frame.t:SetVertexColor(r, g, b, a)
			frame.b:SetVertexColor(r, g, b, a)
			frame.l:SetVertexColor(r, g, b, a)
			frame.r:SetVertexColor(r, g, b, a)
		end
	end

	frame.t:SetHeight(border)
	frame.b:SetHeight(border)
	frame.l:SetWidth(border)
	frame.r:SetWidth(border)
end

function zrMM:CreateButtonFrame()
    -- Button frame
    Minimap.buttonFrame = CreateFrame("frame", "zrButtonFrame", Minimap)
    Minimap.buttonFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    Minimap.buttonFrame:RegisterEvent("PLAYER_XP_UPDATE")
    Minimap.buttonFrame:RegisterEvent("PLAYER_LEVEL_UP")
    Minimap.buttonFrame:RegisterEvent("UPDATE_FACTION")
    -- Find and move buttons
    zrButtonFrame.frameTable = {}
    Minimap.ignoreFrames = {}
    local hideTextures = {}
    Minimap.manualTarget = {}
    local hideButtons = {}
    local numChildren = 0
	
    Minimap.manualTarget['CodexBrowserIcon'] = true                             
    Minimap.manualTarget['ZygorGuidesViewerMapIcon'] = true
    Minimap.manualTarget['PeggledMinimapIcon'] = true
    Minimap.manualTarget['EnxMiniMapIcon'] = true

    Minimap.ignoreFrames['zrButtonFrame'] = true
    Minimap.ignoreFrames['GameTimeFrame'] = true
    Minimap.ignoreFrames['MiniMapLFGFrame'] = true
    Minimap.ignoreFrames['BattlefieldMinimap'] = true
    Minimap.ignoreFrames['MinimapBackdrop'] = true
    Minimap.ignoreFrames["FeedbackUIButton"] = true
    Minimap.ignoreFrames["HelpOpenTicketButton"] = true
    Minimap.ignoreFrames["MiniMapBattlefieldFrame"] = true
    Minimap.ignoreFrames["GarrisonLandingPageMinimapButton"] = true
    Minimap.ignoreFrames["MinimapZoneTextButton"] = true
    Minimap.ignoreFrames['MinimapVoiceChatFrame'] = true
    Minimap.ignoreFrames['TimeManagerClockButton'] = true
    --Minimap.ignoreFrames['MiniMapTrackingFrame'] = true
    Minimap.ignoreFrames['MiniMapMailFrame'] = true
    Minimap.ignoreFrames['COHCMinimapButton'] = true
    Minimap.ignoreFrames['MinimapZoomIn'] = true
    Minimap.ignoreFrames['MinimapZoomOut'] = true
    --Minimap.ignoreFrames['MiniMapTrackingButton'] = true
    --Minimap.ignoreFrames['MiniMapTracking'] = true
    Minimap.ignoreFrames['MinimapCluster.Tracking'] = false
    Minimap.ignoreFrames['MinimapCluster.Tracking.Button'] = false
    Minimap.ignoreFrames['QueueStatusButton'] = true
    Minimap.ignoreFrames['QueueStatusMinimapButton'] = true
    Minimap.ignoreFrames['QueueStatusMinimapButtonDropDownButton'] = true
    Minimap.ignoreFrames['BaudErrorFrameMinimapButton'] = true

    --hideTextures['Interface\\Minimap\\MiniMap-TrackingBorder'] = true
    hideTextures['Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight'] = true
    hideTextures['Interface\\Minimap\\UI-Minimap-Background'] = true 
    hideTextures[136430] = true 
    hideTextures[136467] = true 
	
	zrMM.buttonPosChanged = true
	
	local function loadCustomButtons()
		local numbuttons = 0
		for i,v in pairs(R.db["Map"]["zrMMcustombuttons"]) do 
			numbuttons = numbuttons + 1
		end
		if numbuttons >= 0 then
			for k,v in pairs(R.db["Map"]["zrMMcustombuttons"]) do
				if Minimap.manualTarget[k] ~= nil then
					R.db["Map"]["zrMMcustombuttons"][k] = nil
				else
					Minimap.manualTarget[k] = v
				end
			end
		end
	end
	loadCustomButtons()
	
	function zrMM:AddMinimapButton(frame)
		local n = frame:GetName()
		if Minimap.manualTarget[n] == nil and zrButtonFrame.frameTable[n] == nil then
			Minimap.manualTarget[n] = true
			if R.db["Map"]["zrMMcustombuttons"][n] ~= true then
				R.db["Map"]["zrMMcustombuttons"][n] = true
			end
		end
	end
	
	function zrMM:RemoveMinimapButton(frame)
		local n = frame:GetName()
		if R.db["Map"]["zrMMcustombuttons"][n] ~= nil then
			R.db["Map"]["zrMMcustombuttons"][n] = nil
			Minimap.manualTarget[n] = nil
		end
	end

  function zrMM:MinimapButtonResizeMove()
    local last = nil
		local first = nil
		local buttonCount = 0

        hideButtons = {}
		
		if zrMM.buttonPosChanged == true then
			Minimap.buttonFrame:ClearAllPoints()
			if (R.db["Map"]["zrMMbuttonpos"] == 1) then
				Minimap.buttonFrame:SetSize(Minimap:GetWidth(),R.db["Map"]["zrMMbuttonsize"])
				Minimap.buttonFrame:SetPoint("BOTTOMLEFT", Minimap, "TOPLEFT", 2, 3)
			elseif (R.db["Map"]["zrMMbuttonpos"] == 4) then
				Minimap.buttonFrame:SetSize(R.db["Map"]["zrMMbuttonsize"],Minimap:GetHeight())
				Minimap.buttonFrame:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 3, -1)
			elseif (R.db["Map"]["zrMMbuttonpos"] == 2) then
				Minimap.buttonFrame:SetSize(Minimap:GetWidth(),R.db["Map"]["zrMMbuttonsize"])
				Minimap.buttonFrame:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", -3, -6)
			elseif (R.db["Map"]["zrMMbuttonpos"] == 3) then
				Minimap.buttonFrame:SetSize(R.db["Map"]["zrMMbuttonsize"],Minimap:GetHeight())
				Minimap.buttonFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -3, -1)		
			end
			zrMM.buttonPosChanged = false
		end

        for k, f in pairs(zrButtonFrame.frameTable) do
            f:SetWidth(R.db["Map"]["zrMMbuttonsize"])
            f:SetHeight(R.db["Map"]["zrMMbuttonsize"])
            f:ClearAllPoints()
            if (hideButtons[f:GetName()]) then
                f:Hide()
                f:SetAlpha(0)
            end
			if (f:IsShown()) then
				if (R.db["Map"]["zrMMbuttonpos"] == 1) then
					if (last) then
						if buttonCount == 9 then
							f:SetPoint("BOTTOMLEFT", first, "TOPLEFT", 0, R.db["Map"]["zrMMbordersize"]*2)
							buttonCount = 0
						else
							f:SetPoint("BOTTOMLEFT", last, "BOTTOMRIGHT", R.db["Map"]["zrMMbordersize"]*2, 0)     
						end
					else
						f:SetPoint("BOTTOMLEFT", Minimap.buttonFrame, "BOTTOMLEFT", -2, 0)
						first = f
					end
				elseif (R.db["Map"]["zrMMbuttonpos"] == 2) then
					if (last) then
						if buttonCount == 9 then
							f:SetPoint("TOPRIGHT", first, "BOTTOMRIGHT", 0, -R.db["Map"]["zrMMbordersize"]*2)
							buttonCount = 0
						else
							f:SetPoint("TOPRIGHT", last, "TOPLEFT", -R.db["Map"]["zrMMbordersize"]*2, 0)     
						end
					else
						f:SetPoint("TOPRIGHT", Minimap.buttonFrame, "TOPRIGHT", 2, 0)
						first = f
					end
				elseif (R.db["Map"]["zrMMbuttonpos"] == 4) then
					if (last) then
						if buttonCount == 9 then
							f:SetPoint("TOPLEFT", first, "TOPRIGHT", R.db["Map"]["zrMMbordersize"]*2, 0)
							buttonCount = 0
						else
							f:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -R.db["Map"]["zrMMbordersize"]*2)  
						end
					else
						f:SetPoint("TOPLEFT", Minimap.buttonFrame, "TOPLEFT", 0, 0)
						first = f
					end
				elseif (R.db["Map"]["zrMMbuttonpos"] == 3) then
					if (last) then
						if buttonCount == 9 then
							f:SetPoint("TOPRIGHT", first, "TOPLEFT", -R.db["Map"]["zrMMbordersize"]*2, 0)
							buttonCount = 0
						else
							f:SetPoint("TOPRIGHT", last, "BOTTOMRIGHT", 0, -R.db["Map"]["zrMMbordersize"]*2)        
						end
					else
						f:SetPoint("TOPRIGHT", Minimap.buttonFrame, "TOPRIGHT", 0, 0)
						first = f
					end
				end
				last = f
				buttonCount = buttonCount + 1
			end
        end
    end
    local function SkinButton(f)
        if (f.skinned) then return end
        f:SetScale(1)
        f:SetFrameStrata("MEDIUM")
        -- Skin textures
        local r = {f:GetRegions()}
        for o = 1, #r do
            if (r[o].GetTexture and r[o]:GetTexture()) then
                local tex = r[o]:GetTexture()
                r[o]:SetAllPoints(f)
                if (hideTextures[tex]) then
                    r[o]:Hide()
                elseif (not strfind(tex,"WHITE8x8")) then
                    local coord = table.concat({r[o]:GetTexCoord()})
                    --if (coord == "00011011") then
                        --r[o]:SetTexCoord(0.3, 0.7, 0.3, 0.7)
                        --if (n == "DugisOnOffButton") then
                            --r[o]:SetTexCoord(0.25, 0.75, 0.2, 0.7)
                        --end
                    --end
                end
            end
        end
        -- Create background
        zrMM:set_backdrop(f)
        f.skinned = true
    end
    
    local function MoveButtons()
        local c = {Minimap.buttonFrame:GetChildren()}
        local d = {Minimap:GetChildren()}
        if (#d ~= numChildren) then
            numChildren = #d
            zrButtonFrame.frameTable = {}
            for k, v in pairs(d) do table.insert(c,v) end
            local last = nil
            for i = 1, #c do
                local f = c[i]
                local n = f:GetName() or i;
                f.buttonindex = i
                if (f:IsShown() and not Minimap.ignoreFrames[n]) and ((Minimap.manualTarget[n] or f:GetName()) and (string.find(n, "LibDB") or string.find(n, "Button") or string.find(n, "Btn"))) then
                    SkinButton(f)
                    zrButtonFrame.frameTable[n] = f
                end
            end
        else
            for t, v in pairs(Minimap.manualTarget) do
				local f = _G[t]
                if (f) then
                    local n = f:GetName() or i;
                    if (f:IsShown()) then
                        SkinButton(f)
						if not zrButtonFrame.frameTable[n] then
                            zrButtonFrame.frameTable[n] = f
						end
                    else
					    if zrButtonFrame.frameTable[n] then
                            zrButtonFrame.frameTable[n] = f
						end
                    end
                end

            end
        end
        zrMM:MinimapButtonResizeMove()
    end
    local total = 0
    Minimap.buttonFrame:SetScript("OnEvent",function(self, event)
		  if (event == "MAIL_CLOSED") then MoveButtons() end
	  end)
    Minimap.buttonFrame:SetScript("OnUpdate", function(self, elapsed)
        total = total + elapsed
        if (total > 1) then total = 0 MoveButtons() end
    end)
end