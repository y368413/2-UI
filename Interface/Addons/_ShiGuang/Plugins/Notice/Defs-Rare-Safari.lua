--[[ ## Author: Defective  ## Version: 80300.5 ]]

local DRS = CreateFrame("Frame", "DRSMainMenuFrame", UIParent)
DRS:SetShown(false)

--[[ data structure
rareTable[guid].nameplate = unitToken
rareTable[guid].raidmarker = raidMarkerIndex
rareTable[guid].unitname = unitName
rareTable[guid].x = vignettePosition.x
rareTable[guid].y = vignettePosition.y
rareTable[defGUID].vignette = true
rareTable[fakeGUID].yell = true
rareTable[fakeGUID].emote = true
rareTable[defGUID].unittype = type
rareTable[DRS.AlertFrame2.unitguid].donotshow = true
rareTable[fakeGUID].lastseen = GetServerTime()
rareTable[DRS.AlertFrame1.unitguid].health = floor((UnitHealth(unitTarget) / UnitHealthMax(unitTarget)) * 100)
rareTable[chatGuid].chatsender = sender
]]
local blacklistedCreatures = {135181, 138694, 151787, 152671, 152729, 152736, 153088}
local blacklistedObjects = {}
local rareTable = {}
local lookupTable = {}

local sqrt2 = sqrt(2) -- stuff to help texcoord mumbo jumbo later
local rads45 = 0.25*(math.pi)
local rads135 = 0.75*(math.pi)
local rads225 = 1.25*(math.pi)
local cos, sin = math.cos, math.sin

local namePlateScanMounts = {-- [npcID] = mount spellID, itemID (if required or nil if not), chat window message
	[65090] = "300150\a\a122674\aTake Selfie with Fabious for mount.", -- Fabious
	[162681] = "316493\a161128\a\aFeed Seaside Leafy Greens Mix to Elusive Quickhoof for mount.", --Elusive Quickhoof
	}
local mountIDs

local function corner(r)
	return 0.5+cos(r)/sqrt2, 0.5+sin(r)/sqrt2
end

local function MakeAlertFrame(guid)
	local f = CreateFrame("Button", nil, UIParent)
	f.unitguid = guid
	f:SetPoint("TOP",UIParent,"TOP",0,-26)
	f:SetSize(260, 26)
	f:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", insets = {left = 3, right = 3, top = 3, bottom = 3}, tileSize = 16, tile = true, edgeFile = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\BlinkHealthText\\2px_glow.blp", edgeSize = 16})
	f:SetBackdropBorderColor(0.5, 0.5, 0.5)
	f:SetShown(false)
	f:EnableMouse(true)
	f.MacroBtn = CreateFrame("Button", nil, f, "InsecureActionButtonTemplate")
	f.MacroBtn:SetAttribute("type", "macro")
	f.MacroBtn:SetAttribute("macrotext", [[/dance]])
	f.MacroBtn:SetSize(23, 23)
	f.MacroBtn:SetPoint("LEFT", f, "LEFT", 6, 0)
	f.MacroBtn.texture = f.MacroBtn:CreateTexture(nil,"OVERLAY")
	f.MacroBtn.texture:SetAllPoints(true)
	f:SetScript("OnClick",
		function(self)
			rareTable[self.unitguid].donotshow = true
			local x = self.unitguid
			C_Timer.After(300, function() rareTable[x] = nil end)
			self:Hide()
		end)
	f.fontString = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	f.fontString:SetPoint("LEFT", 31, 0)
	f.fontString:SetText(rareTable[guid].unitname or "Def's Rare Safari")
	--f.fontString2 = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	--f.fontString2:SetPoint("RIGHT", -60, 0)
	f.fontString3 = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	f.fontString3:SetPoint("RIGHT", -12, 0)
	f.fontString4 = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	f.fontString4:SetPoint("RIGHT", -31, 0)
	f:SetScript("OnShow",
		function (self)
			self.fontString3:Hide()
			if self.unitguid then
				if (rareTable[self.unitguid].unittype == "Creature") then
					self.MacroBtn.texture:SetTexture("Interface\\MINIMAP\\Minimap_skull_elite.blp")
					self.MacroBtn:SetAttribute("macrotext", "/target "..rareTable[self.unitguid].unitname)
				elseif (rareTable[self.unitguid].unittype == "GameObject") then
					self.MacroBtn.texture:SetTexture("Interface\\MINIMAP\\Minimap_chest_elite.blp")  -- Icons\\inv_misc_chest_azerite.blp  or  Worldmap\\TreasureChest_64.blp
					self.MacroBtn:SetAttribute("macrotext", "/dance")
				else
					self.MacroBtn.texture:SetTexture(134400)
					self.MacroBtn:SetAttribute("macrotext", "/dance")
				end
				self.fontString:SetText(rareTable[self.unitguid].unitname or "Def's Rare Safari")
				self.uiMapID = C_Map.GetBestMapForUnit("player") --1462
				if self.uiMapID then
					local position = C_Map.GetPlayerMapPosition(self.uiMapID, "player")
					if rareTable[self.unitguid].x and rareTable[self.unitguid].y and position and position.x and position.y then
						self.Arrow:Show()
					else
						self.Arrow:Hide()
						--self.fontString2:Hide()
						self.fontString4:Hide()
					end
				else
					self.Arrow:Hide()
					--self.fontString2:Hide()
					self.fontString4:Hide()
				end
			else
				self.MacroBtn.texture:SetTexture(134400)
				self.fontString:SetText("Def's Rare Safari")
				self.Arrow:Hide()
				--self.fontString2:Hide()
				self.fontString4:Hide()
			end
		end)
	f.Arrow = CreateFrame("Frame", nil, f)
	f.Arrow:SetPoint("RIGHT", f, "RIGHT", 0, -3)
	f.Arrow:SetSize(31, 31)
	f.Arrow.texture = f.Arrow:CreateTexture(nil,"OVERLAY")
	f.Arrow.texture:SetAllPoints(true)
	f.Arrow.texture:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\Raid\\Arrow.blp")
	f.Arrow.texture:SetRotation(rad(180))
	f.Arrow:SetScript("OnUpdate",
		function(self, elapsed)
			self.TimeSinceLastUpdate = ((self.TimeSinceLastUpdate or 0) + elapsed)
			if (self.TimeSinceLastUpdate > .05) then
				self.TimeSinceLastUpdate = 0
				if f.unitguid and rareTable[f.unitguid] and rareTable[f.unitguid].nameplate then
					--f.fontString2:Hide()
					f.fontString4:Hide()
					self:Hide()
				elseif f.unitguid and rareTable[f.unitguid] and rareTable[f.unitguid].x and rareTable[f.unitguid].y then
					local position = C_Map.GetPlayerMapPosition(f.uiMapID, "player")
					if position and position.x and position.y then
						local player = GetPlayerFacing()
						if not player then
							return
						end
						local dy = -rareTable[f.unitguid].y + position.y
						local dx = rareTable[f.unitguid].x - position.x
						local angle = math.rad(atan2(dy, dx)) - (math.pi/2) - player
						local ULx,ULy = corner(angle+rads225)
						local LLx,LLy = corner(angle+rads135)
						local URx,URy = corner(angle-rads45)
						local LRx,LRy = corner(angle+rads45)
						self.texture:SetTexCoord(ULx,ULy,LLx,LLy,URx,URy,LRx,LRy) -- https://wow.gamepedia.com/Applying_affine_transformations_using_SetTexCoord
						local playerContinentID, playerWorldPosition = C_Map.GetWorldPosFromMapPos(f.uiMapID, CreateVector2D(position.x, position.y))
						local targetContinentID, targetWorldPosition = C_Map.GetWorldPosFromMapPos(f.uiMapID, CreateVector2D(rareTable[f.unitguid].x, rareTable[f.unitguid].y))
						local distance
						if (playerContinentID == targetContinentID) then
							local x = abs(playerWorldPosition.x - targetWorldPosition.x)
							local y = abs(playerWorldPosition.y - targetWorldPosition.y)
							distance = sqrt(x*x + y*y)
							distance = floor(distance)
							f.fontString4:SetText(distance)
							f.fontString4:Show()
						else
							f.fontString4:Hide()
						end
						if (distance <= 40) then
							self.texture:SetVertexColor(0,1,0)
						elseif (distance <= 250) then
							self.texture:SetVertexColor(1,1,1)
						else
							self.texture:SetVertexColor(1,0,0)
						--else
							--self.texture:SetVertexColor(.5,.5,1) -- brown
						end
						--if rareTable[f.unitguid].lastseen then
							--local timeDifference = GetServerTime() - rareTable[f.unitguid].lastseen
							--f.fontString2:SetText(SecondsToTime(timeDifference))
							--f.fontString2:Show()
						--else
							--f.fontString2:Hide()
						--end
						
					else
						--f.fontString2:Hide()
						self:Hide()
					end
				else
					self:Hide()
					--f.fontString2:Hide()
					f.fontString4:Hide()
				end
			end
		end)
	f:Show()
	return f
end

--DRS.AlertFrame1.Portrait = CreateFrame("PlayerModel", nil, DRS.AlertFrame1)
--DRS.AlertFrame1.Portrait:SetFrameStrata("FULLSCREEN")
--DRS.AlertFrame1.Portrait:SetPoint("CENTER", DRS.AlertFrame1, "CENTER", -70, 0)
--DRS.AlertFrame1.Portrait:SetSize(50, 50)
--DRS.AlertFrame1.Portrait.texture = DRS.AlertFrame1.Portrait:CreateTexture(nil,"OVERLAY")
--DRS.AlertFrame1.Portrait.texture:SetAllPoints(true)

local soundThrottleTime = 0
local function PlaySoundAlert(guid)
	local timestamp = GetServerTime()
	if ((timestamp - soundThrottleTime) >= 10) then
		soundThrottleTime = timestamp
		--PlaySoundFile(567275)
		PlaySound(18192)
	end
end

local function AcquireAlertFrame(guid)
	if rareTable[guid].donotshow or DRS.AlertFrame1 and DRS.AlertFrame1.unitguid and (DRS.AlertFrame1.unitguid == guid) or DRS.AlertFrame2 and DRS.AlertFrame2.unitguid and (DRS.AlertFrame2.unitguid == guid) or DRS.AlertFrame3 and DRS.AlertFrame3.unitguid and (DRS.AlertFrame3.unitguid == guid) then
		return
	elseif not DRS.AlertFrame1 then
		PlaySoundAlert(guid)
		PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Dadongda.ogg", "Master")
		DRS.AlertFrame1 = MakeAlertFrame(guid)
		DRS.AlertFrame1:SetMovable(true)
		DRS.AlertFrame1:SetClampedToScreen(true)
		DRS.AlertFrame1:RegisterForDrag("LeftButton")
		DRS.AlertFrame1:SetScript("OnDragStart",
			function(self)
				--if not self.isLocked then
					self:StartMoving()
				--end
			end)
		DRS.AlertFrame1:SetScript("OnDragStop",
			function(self)
				self:StopMovingOrSizing()
				local _
				ShiGuangDB[500], _, ShiGuangDB[501], ShiGuangDB[502], ShiGuangDB[503] = DRS.AlertFrame1:GetPoint(1)
			end)
		if ShiGuangDB[500] and ShiGuangDB[501] and ShiGuangDB[502] and ShiGuangDB[503] then
			DRS.AlertFrame1:ClearAllPoints()
			DRS.AlertFrame1:SetPoint(ShiGuangDB[500] or "TOP", UIParent,  ShiGuangDB[501] or "TOP", ShiGuangDB[502] or 0, ShiGuangDB[503] or -26)
		end
	elseif not DRS.AlertFrame1:IsShown() then
		PlaySoundAlert(guid)
		PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Dadongda.ogg", "Master")
		DRS.AlertFrame1.unitguid = guid
		DRS.AlertFrame1:Show()
		if rareTable[guid].x and rareTable[guid].y then
			DRS.AlertFrame1.Arrow:Show()
		else
			DRS.AlertFrame1.Arrow:Hide()
			DRS.AlertFrame1.fontString4:Hide()
		end
	elseif not DRS.AlertFrame2 and not (DRS.AlertFrame1.unitguid == guid) then
		PlaySoundAlert(guid)
		PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Dadongda.ogg", "Master")
		DRS.AlertFrame2 = MakeAlertFrame(guid)
		DRS.AlertFrame2:ClearAllPoints()
		DRS.AlertFrame2:SetPoint("TOP", DRS.AlertFrame1, "BOTTOM", 0, -8)
	elseif not DRS.AlertFrame2:IsShown() and not (DRS.AlertFrame1.unitguid == guid) then
		PlaySoundAlert(guid)
		PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Dadongda.ogg", "Master")
		DRS.AlertFrame2.unitguid = guid
		DRS.AlertFrame2:Show()
		if rareTable[guid].x and rareTable[guid].y then
			DRS.AlertFrame2.Arrow:Show()
		else
			DRS.AlertFrame2.Arrow:Hide()
			DRS.AlertFrame2.fontString4:Hide()
		end
	elseif not DRS.AlertFrame3 and not (DRS.AlertFrame1.unitguid == guid) and not (DRS.AlertFrame2.unitguid == guid) then
		PlaySoundAlert(guid)
		PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Dadongda.ogg", "Master")
		DRS.AlertFrame3 = MakeAlertFrame(guid)
		DRS.AlertFrame3:ClearAllPoints()
		DRS.AlertFrame3:SetPoint("TOP", DRS.AlertFrame2, "BOTTOM", 0, -8)
	elseif not DRS.AlertFrame3:IsShown() and not (DRS.AlertFrame1.unitguid == guid) and not (DRS.AlertFrame2.unitguid == guid) then
		PlaySoundAlert(guid)
		PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Dadongda.ogg", "Master")
		DRS.AlertFrame3.unitguid = guid
		DRS.AlertFrame3:Show()
		if rareTable[guid].x and rareTable[guid].y then
			DRS.AlertFrame3.Arrow:Show()
		else
			DRS.AlertFrame3.Arrow:Hide()
			DRS.AlertFrame3.fontString4:Hide()
		end	
	elseif (rareTable[guid].unittype == "Creature") and DRS.AlertFrame1:IsShown() and DRS.AlertFrame1.unitguid and rareTable[DRS.AlertFrame1.unitguid] and (rareTable[DRS.AlertFrame1.unitguid].unittype == "GameObject") and DRS.AlertFrame2:IsShown() and DRS.AlertFrame2.unitguid and not (DRS.AlertFrame2.unitguid == guid) and DRS.AlertFrame3:IsShown() and DRS.AlertFrame3.unitguid and not (DRS.AlertFrame3.unitguid == guid) then
		PlaySoundAlert(guid)
		PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Dadongda.ogg", "Master")
		DRS.AlertFrame1.unitguid = guid
		DRS.AlertFrame1.fontString:SetText(rareTable[guid].unitname or "Def's Rare Safari")
		DRS.AlertFrame1.MacroBtn:SetAttribute("macrotext", "/target "..rareTable[guid].unitname)
		DRS.AlertFrame1:Show()
		if rareTable[guid].x and rareTable[guid].y then
			DRS.AlertFrame1.Arrow:Show()
		else
			DRS.AlertFrame1.Arrow:Hide()
			DRS.AlertFrame1.fontString4:Hide()
		end
	elseif (rareTable[guid].unittype == "Creature") and DRS.AlertFrame2 and DRS.AlertFrame2:IsShown() and DRS.AlertFrame2.unitguid and rareTable[DRS.AlertFrame2.unitguid] and (rareTable[DRS.AlertFrame2.unitguid].unittype == "GameObject") and DRS.AlertFrame1:IsShown() and DRS.AlertFrame1.unitguid and not (DRS.AlertFrame1.unitguid == guid) and DRS.AlertFrame3:IsShown() and DRS.AlertFrame3.unitguid and not (DRS.AlertFrame3.unitguid == guid) then
		PlaySoundAlert(guid)
		PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Dadongda.ogg", "Master")
		DRS.AlertFrame2.unitguid = guid
		DRS.AlertFrame2.fontString:SetText(rareTable[guid].unitname or "Def's Rare Safari")
		DRS.AlertFrame2.MacroBtn:SetAttribute("macrotext", "/target "..rareTable[guid].unitname)
		DRS.AlertFrame2:Show()
		if rareTable[guid].x and rareTable[guid].y then
			DRS.AlertFrame2.Arrow:Show()
		else
			DRS.AlertFrame2.Arrow:Hide()
			DRS.AlertFrame2.fontString4:Hide()
		end
		DRS.AlertFrame2.MacroBtn.texture:SetTexture("Interface\\MINIMAP\\Minimap_skull_elite.blp")
	elseif (rareTable[guid].unittype == "Creature") and DRS.AlertFrame3 and DRS.AlertFrame3:IsShown() and DRS.AlertFrame3.unitguid and rareTable[DRS.AlertFrame3.unitguid] and (rareTable[DRS.AlertFrame3.unitguid].unittype == "GameObject") and DRS.AlertFrame1:IsShown() and DRS.AlertFrame1.unitguid and not (DRS.AlertFrame1.unitguid == guid) and DRS.AlertFrame2:IsShown() and DRS.AlertFrame2.unitguid and not (DRS.AlertFrame2.unitguid == guid) then
		PlaySoundAlert(guid)
		PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\Dadongda.ogg", "Master")
		DRS.AlertFrame3.unitguid = guid
		DRS.AlertFrame3.fontString:SetText(rareTable[guid].unitname or "Def's Rare Safari")
		DRS.AlertFrame3.MacroBtn:SetAttribute("macrotext", "/target "..rareTable[guid].unitname)
		DRS.AlertFrame3:Show()
		if rareTable[guid].x and rareTable[guid].y then
			DRS.AlertFrame3.Arrow:Show()
		else
			DRS.AlertFrame3.Arrow:Hide()
			DRS.AlertFrame3.fontString4:Hide()
		end
		DRS.AlertFrame3.MacroBtn.texture:SetTexture("Interface\\MINIMAP\\Minimap_skull_elite.blp")
	elseif (DRS.AlertFrame1.unitguid == guid) and rareTable[guid].vignette and not rareTable[guid].nameplate then
		if rareTable[guid].x and rareTable[guid].y then
			DRS.AlertFrame1.Arrow:Show()
		else
			DRS.AlertFrame1.Arrow:Hide()
			DRS.AlertFrame1.fontString4:Hide()
		end
	elseif (DRS.AlertFrame2.unitguid == guid) and rareTable[guid].vignette and not rareTable[guid].nameplate then
		if rareTable[guid].x and rareTable[guid].y then
			DRS.AlertFrame2.Arrow:Show()
		else
			DRS.AlertFrame2.Arrow:Hide()
			DRS.AlertFrame2.fontString4:Hide()
		end
	elseif (DRS.AlertFrame3.unitguid == guid) and rareTable[guid].vignette and not rareTable[guid].nameplate then
		if rareTable[guid].x and rareTable[guid].y then
			DRS.AlertFrame3.Arrow:Show()
		else
			DRS.AlertFrame3.Arrow:Hide()
			DRS.AlertFrame3.fontString4:Hide()
		end
	end
end

local function RemoveAlertFrame(guid)
	if DRS.AlertFrame1 and DRS.AlertFrame1:IsShown() and (DRS.AlertFrame1.unitguid == guid) then
		DRS.AlertFrame1.Arrow:Hide()
		DRS.AlertFrame1:Hide()
		DRS.AlertFrame1.unitguid = nil
		if DRS.AlertFrame2 and DRS.AlertFrame2:IsShown() then
			DRS.AlertFrame1.unitguid = DRS.AlertFrame2.unitguid
			DRS.AlertFrame1.fontString:SetText(rareTable[DRS.AlertFrame1.unitguid].unitname or "Def's Rare Safari")
			DRS.AlertFrame1.MacroBtn:SetAttribute("macrotext", "/target "..rareTable[DRS.AlertFrame1.unitguid].unitname)
			DRS.AlertFrame1:Show()
			if rareTable[DRS.AlertFrame1.unitguid].x and rareTable[DRS.AlertFrame1.unitguid].y then
				DRS.AlertFrame1.Arrow:Show()
			else
				DRS.AlertFrame1.Arrow:Hide()
			end
			if (rareTable[DRS.AlertFrame1.unitguid].unittype == "Creature") then
				DRS.AlertFrame1.MacroBtn.texture:SetTexture("Interface\\MINIMAP\\Minimap_skull_elite.blp")
			elseif (rareTable[DRS.AlertFrame1.unitguid].unittype == "GameObject") then
				DRS.AlertFrame1.MacroBtn.texture:SetTexture("Interface\\MINIMAP\\Minimap_chest_elite.blp")
			else
				DRS.AlertFrame1.MacroBtn.texture:SetTexture(134400)
			end
			DRS.AlertFrame2.Arrow:Hide()
			DRS.AlertFrame2:Hide()
			DRS.AlertFrame2.unitguid = nil
			if DRS.AlertFrame3 and DRS.AlertFrame3:IsShown() then
				DRS.AlertFrame2.unitguid = DRS.AlertFrame3.unitguid
				DRS.AlertFrame2.fontString:SetText(rareTable[DRS.AlertFrame2.unitguid].unitname or "Def's Rare Safari")
				DRS.AlertFrame2.MacroBtn:SetAttribute("macrotext", "/target "..rareTable[DRS.AlertFrame2.unitguid].unitname)
				DRS.AlertFrame2:Show()
				if rareTable[DRS.AlertFrame2.unitguid].x and rareTable[DRS.AlertFrame2.unitguid].y then
					DRS.AlertFrame2.Arrow:Show()
				else
					DRS.AlertFrame2.Arrow:Hide()
				end
				if (rareTable[DRS.AlertFrame2.unitguid].unittype == "Creature") then
					DRS.AlertFrame2.MacroBtn.texture:SetTexture("Interface\\MINIMAP\\Minimap_skull_elite.blp")
				elseif (rareTable[DRS.AlertFrame2.unitguid].unittype == "GameObject") then
					DRS.AlertFrame2.MacroBtn.texture:SetTexture("Interface\\MINIMAP\\Minimap_chest_elite.blp")
				else
					DRS.AlertFrame2.MacroBtn.texture:SetTexture(134400)
				end
				DRS.AlertFrame3.Arrow:Hide()
				DRS.AlertFrame3:Hide()
				DRS.AlertFrame3.unitguid = nil
			end
		end
		for k in pairs(rareTable) do
			if (k ~= guid) and (rareTable[k].unittype == "Creature") then
				AcquireAlertFrame(k)
				return
			end
		end
		for k in pairs(rareTable) do
			if (k ~= guid) and (rareTable[k].unittype == "GameObject") then
				AcquireAlertFrame(k)
				return
			end
		end
	elseif DRS.AlertFrame2 and DRS.AlertFrame2:IsShown() and (DRS.AlertFrame2.unitguid == guid) then
		DRS.AlertFrame2.Arrow:Hide()
		DRS.AlertFrame2:Hide()
		DRS.AlertFrame2.unitguid = nil
		if DRS.AlertFrame3 and DRS.AlertFrame3:IsShown() then
			DRS.AlertFrame2.unitguid = DRS.AlertFrame3.unitguid
			DRS.AlertFrame2.fontString:SetText(rareTable[DRS.AlertFrame2.unitguid].unitname or "Def's Rare Safari")
			DRS.AlertFrame2.MacroBtn:SetAttribute("macrotext", "/target "..rareTable[DRS.AlertFrame2.unitguid].unitname)
			DRS.AlertFrame2:Show()
			if rareTable[DRS.AlertFrame2.unitguid].x and rareTable[DRS.AlertFrame2.unitguid].y then
				DRS.AlertFrame2.Arrow:Show()
			else
				DRS.AlertFrame2.Arrow:Hide()
			end
			if (rareTable[DRS.AlertFrame2.unitguid].unittype == "Creature") then
				DRS.AlertFrame2.MacroBtn.texture:SetTexture("Interface\\MINIMAP\\Minimap_skull_elite.blp")
			elseif (rareTable[DRS.AlertFrame2.unitguid].unittype == "GameObject") then
				DRS.AlertFrame2.MacroBtn.texture:SetTexture("Interface\\MINIMAP\\Minimap_chest_elite.blp")
			else
				DRS.AlertFrame2.MacroBtn.texture:SetTexture(134400)
			end
			DRS.AlertFrame3.Arrow:Hide()
			DRS.AlertFrame3:Hide()
			DRS.AlertFrame3.unitguid = nil
		end
		for k in pairs(rareTable) do
			if (k ~= guid) and (rareTable[k].unittype == "Creature") then
				AcquireAlertFrame(k)
				return
			end
		end
		for k in pairs(rareTable) do
			if (k ~= guid) and (rareTable[k].unittype == "GameObject") then
				AcquireAlertFrame(k)
				return
			end
		end
	elseif DRS.AlertFrame3 and DRS.AlertFrame3:IsShown() and (DRS.AlertFrame3.unitguid == guid) then
		DRS.AlertFrame3.Arrow:Hide()
		DRS.AlertFrame3:Hide()
		DRS.AlertFrame3.unitguid = nil
		for k in pairs(rareTable) do
			if (k ~= guid) and (rareTable[k].unittype == "Creature") then
				AcquireAlertFrame(k)
				return
			end
		end
		for k in pairs(rareTable) do
			if (k ~= guid) and (rareTable[k].unittype == "GameObject") then
				AcquireAlertFrame(k)
				return
			end
		end
	end
end

local function SendAddonMessageToPartyGuild(guid, remove)
	-- local chatUiMapID, chatGuid, chatRaidmarker, chatUnitname, chatX, chatY, chatHealth, chatLastseen = strsplit("\a",text)
	--[[local uiMapID = C_Map.GetBestMapForUnit("player")
	local chatString = strjoin("\a", uiMapID, defGUID, (rareTable[defGUID].raidmarker or nil), rareTable[defGUID].unitName, (rareTable[defGUID].x or nil), (rareTable[defGUID].y or nil), (rareTable[defGUID].health or nil), rareTable[defGUID].lastseen, remove)
	C_ChatInfo.SendAddonMessage("Def's RS", chatString, "PARTY")]]
	--C_ChatInfo.SendAddonMessage("Def's RS", chatString, "GUILD")
end

local function RemoveNamePlate(unitToken)
	for k in pairs(rareTable) do
		if rareTable[k].nameplate and (rareTable[k].nameplate == unitToken) then
			--print("RemoveNamePlate")
			if rareTable[k].vignette then
				--print("RemoveNamePlate1")
				rareTable[k].nameplate = nil
				break
			else
				SendAddonMessageToPartyGuild(k, true)
				RemoveAlertFrame(k)
				--print("RemoveNamePlate2")
				rareTable[k] = nil
				break
			end
		end
	end
end

local npcIDToQuestID = {
	-- Mechagon
	[151934] = "55512\a0.52\a0.40", -- Arachnoid Harvester
	[150394] = "55546\a0.48\a0.45", -- Armored Vaultbot
	[151308] = "55539\a0.53\a0.31", -- Boggac Skullbash
	[153200] = "55857\a0.51\a0.50\aBoilburn", -- Boilburn
	[152001] = "55537\a0.65\a0.27", -- Bonepicker
	[154739] = "56368\a0.66\a0.58\aCaustic Mechaslime", -- Caustic Mechaslime
	[152570] = "55812\a0.82\a0.20", -- Crazed Trogg
	[151569] = "55514", -- Deepwater Maw
	[150342] = "55814\a0.63\a0.25\aEarthbreaker Gulroc", -- Earthbreaker Gulroc
	[154153] = "56207", -- Enforcer KX-T57
	[151202] = "55513\a0.65\a0.51", -- Foul Manifestation
	[151884] = "55367", -- Fungarian Furor
	[153228] = "55852", -- Gear Checker Cogstar (spawns randomly)
	[153205] = "55855\a0.59\a0.67\aGemicide", -- Gemicide
	[154701] = "56367\a0.72\a0.53\aGorged Gear-Cruncher", -- Gorged Gear-Cruncher
	[151684] = "55399", -- Jawbreaker
	[152007] = "55369\a0.42\a0.40", -- Killsaw
	[151933] = "55544\a0.60\a0.42", -- Malfunctioning Beastbot
	[151124] = "55207\a0.57\a0.52", -- Mechagonian Nullifier
	[151672] = "55386", -- Mecharantula
	[151627] = "55859\a0.60\a0.60", -- Mr. Fixthis
	[153206] = "55853\a0.56\a0.36\aOl' Big Tusk", -- Ol' Big Tusk
	[151296] = "55515\a0.56\a0.39", -- OOX-Avenger/MG
	[152764] = "55856\a0.57\a0.62", -- Oxidized Leachbeast
	[151702] = "55405", -- Paol Pondwader
	[150575] = "55368", -- Rumblerocks
	[152182] = "55811", -- Rustfeather
	[155583] = "56737", -- Scrapclaw
	[150937] = "55545\a0.19\a0.80", -- Seaspit
	[153000] = "55810\a0.83\a0.21", -- Sparkqueen P'Emp
	[153226] = "55854\a0.25\a0.77", -- Steel Singer Freza
	[155060] = "56419\a0.80\a0.20", -- The Doppel Gang
	[152113] = "55858\a0.68\a0.48\aThe Kleptoboss", -- The Kleptoboss
	[154225] = "56182\a0.55\a0.60", -- The Rusty Prince
	[151625] = "55364\a0.72\a0.50", -- The Scrap King
	[151940] = "55538\a0.59\a0.24", -- Uncle T'Rogg
	[150394] = "55546\a0.57\a0.48", -- Vaultbot
	-- Nazjatar
	[152323] = "55671\a0.29\a0.28", -- King Gakula
	}

local YellsToNpcID = {
	-- Mechagon
	["Arachnoid Harvester"] = 151934,
	["Boggac Skullbash"] = 151308,
	["Gear Checker Cogstar"] = 153228,
	["Mechagonian Nullifier"] = 151124,
	["OOX-Avenger/MG"] = 151296,
	["Razak Ironsides"] = 153000,
	["Seaspit"] = 150937,
	["The Rusty Prince"] = 154225,
	["The Scrap King"] = 151625,
	["Uncle T'Rogg"] = 151940,
	-- Nazjatar
	["King Gakula"] = 152323,
}
	
local EmotesToNpcID = {
	--Mechagon
	["TR28"] = 153206, -- Ol' Big Tusk
	["TR35"] = 150342, -- Earthbreaker Gulroc
	["CC61"] = 154701, -- Gorged Gear-Cruncher
	["CC73"] = 154739, -- Caustic Mechaslime
	["CC88"] = 152113, -- The Kleptoboss
	["JD41"] = 153200, -- Boilburn
	["JD99"] = 153205, -- Gemicide
}
	
--[[/run for k,v in pairs({Arachnoid=55512,Rustfeather=55811,Soundless=56298}) do print(format("%s: %s", k, IsQuestFlaggedCompleted(v) and "\124cFFFF0000Completed\124r" or "\124cFF00FF00Not Completed\124r")) end
]]--/dump IsQuestFlaggedCompleted(55811)
local function ChatEmote(...)
	local uiMapID = C_Map.GetBestMapForUnit("player")
	if uiMapID and (uiMapID == 1462) then
		local message, playerName = ...
		if playerName and (playerName == "Drill Rig") then
			for k,v in pairs(EmotesToNpcID) do
				if strfind(message, k) then
					for i in pairs(rareTable) do
						local type, npcID = strsplit("\a", i)
						if (type == "Creature") and (npcID == v) then -- exit out if npcID already in rareTable
							return
						end
					end
					local questID, x, y, name = strsplit("\a",npcIDToQuestID[v])
					if not IsQuestFlaggedCompleted(questID) then
						local fakeGUID = strjoin("\a","Creature",v)
						if rareTable[fakeGUID] and rareTable[fakeGUID].donotshow then
							return
						elseif not rareTable[fakeGUID] or not rareTable[fakeGUID].nameplate and not rareTable[fakeGUID].vignette then
							rareTable[fakeGUID] = rareTable[fakeGUID] or {}
							rareTable[fakeGUID].unitname = name
							rareTable[fakeGUID].unittype = "Creature"
							rareTable[fakeGUID].emote = true
							rareTable[fakeGUID].lastseen = GetServerTime()
							rareTable[fakeGUID].x = x
							rareTable[fakeGUID].y = y
							AcquireAlertFrame(fakeGUID)
							SendAddonMessageToPartyGuild(fakeGUID)
							C_Timer.After(80,
								function()
									if rareTable[fakeGUID] and rareTable[fakeGUID].emote then
										RemoveAlertFrame(fakeGUID)
										rareTable[fakeGUID] = nil
									end
								end)
							return
						end
					end
				end
			end
		end
	end
end

local function ChatMessageAddon(text,channel,sender)
	local chatUiMapID, chatGuid, chatRaidmarker, chatUnitname, chatX, chatY, chatHealth, chatLastseen, remove = strsplit("\a",text)
	local uiMapID = C_Map.GetBestMapForUnit("player")
	if (uiMapID == chatUiMapID) then
		rareTable[chatGuid] = rareTable[chatGuid] or {}
		rareTable[chatGuid].raidmarker = chatRaidmarker
		rareTable[chatGuid].unitname = chatUnitname
		rareTable[chatGuid].x = chatX
		rareTable[chatGuid].y = chatY
		rareTable[chatGuid].health = chatHealth
		rareTable[chatGuid].lastseen = chatLastseen
		rareTable[chatGuid].chatsender = sender
	end
	--[[
	rareTable[guid].nameplate = unitToken
	rareTable[guid].raidmarker = raidMarkerIndex
	rareTable[guid].unitname = unitName
	rareTable[guid].x = vignettePosition.x
	rareTable[guid].y = vignettePosition.y
	rareTable[defGUID].vignette = true
	rareTable[fakeGUID].yell = true
	rareTable[fakeGUID].emote = true
	rareTable[defGUID].unittype = type
	rareTable[DRS.AlertFrame2.unitguid].donotshow = true
	rareTable[fakeGUID].lastseen = GetServerTime()
	rareTable[DRS.AlertFrame1.unitguid].health = floor((UnitHealth(unitTarget) / UnitHealthMax(unitTarget)) * 100)
	rareTable[chatGuid].chatsender = sender
	]]
end

local function ChatYell(...)
	local uiMapID = C_Map.GetBestMapForUnit("player")
	if uiMapID and (uiMapID == 1462) then
		local _, playerName = ...
		if playerName then
			--print(playerName)
			for k,v in pairs(YellsToNpcID) do
				if (playerName == k) then
					for i in pairs(rareTable) do
						local type, npcID = strsplit("\a", i)
						if (type == "Creature") and (npcID == v) then -- exit out if npcID already in rareTable
							return
						end
					end
					local questID, x, y = strsplit("\a",npcIDToQuestID[v])
					if not IsQuestFlaggedCompleted(questID) then
						local fakeGUID = strjoin("\a","Creature",v)
						if rareTable[fakeGUID] and rareTable[fakeGUID].donotshow then
							return
						elseif not rareTable[fakeGUID] or not rareTable[fakeGUID].nameplate and not rareTable[fakeGUID].vignette then
							rareTable[fakeGUID] = rareTable[fakeGUID] or {}
							rareTable[fakeGUID].unitname = playerName
							if (playerName == "Razak Ironsides") then
								rareTable[fakeGUID].unitname = "Sparkqueen P'Emp"
							end
							rareTable[fakeGUID].yell = true
							rareTable[fakeGUID].unittype = "Creature"
							rareTable[fakeGUID].lastseen = GetServerTime()
							rareTable[fakeGUID].x = x
							rareTable[fakeGUID].y = y
							AcquireAlertFrame(fakeGUID)
							SendAddonMessageToPartyGuild(fakeGUID)
							C_Timer.After(65,
								function()
									if rareTable[fakeGUID] and rareTable[fakeGUID].yell then
										RemoveAlertFrame(fakeGUID)
										rareTable[fakeGUID] = nil
									end
								end)
							return
						end
					end
				end
			end
		end
	end
end

local function NamePlateHealth(unitTarget)
	if DRS.AlertFrame1 and DRS.AlertFrame1:IsShown() and DRS.AlertFrame1.unitguid and (rareTable[DRS.AlertFrame1.unitguid].nameplate == unitTarget) then
		rareTable[DRS.AlertFrame1.unitguid].health = floor((UnitHealth(unitTarget) / UnitHealthMax(unitTarget)) * 100)
		DRS.AlertFrame1.fontString3:SetText(rareTable[DRS.AlertFrame1.unitguid].health.." %")
		--[[if rareTable[DRS.AlertFrame1.unitguid].health > 50 then
			DRS.AlertFrame1.fontString3:SetText(rareTable[DRS.AlertFrame1.unitguid].health.." %|r")
		elseif rareTable[DRS.AlertFrame1.unitguid].health > 25
			DRS.AlertFrame1.fontString3:SetText(rareTable[DRS.AlertFrame1.unitguid].health.." %|r")
		else
			DRS.AlertFrame1.fontString3:SetText(rareTable[DRS.AlertFrame1.unitguid].health.." %|r")
		end]]
		DRS.AlertFrame1.fontString3:Show()
		SendAddonMessageToPartyGuild(DRS.AlertFrame1.unitguid)
	elseif DRS.AlertFrame2 and DRS.AlertFrame2:IsShown() and DRS.AlertFrame2.unitguid and (rareTable[DRS.AlertFrame2.unitguid].nameplate == unitTarget) then
		rareTable[DRS.AlertFrame2.unitguid].health = floor((UnitHealth(unitTarget) / UnitHealthMax(unitTarget)) * 100)
		DRS.AlertFrame2.fontString3:SetText(rareTable[DRS.AlertFrame2.unitguid].health.." %")
		DRS.AlertFrame2.fontString3:Show()
		SendAddonMessageToPartyGuild(DRS.AlertFrame2.unitguid)
	elseif DRS.AlertFrame3 and DRS.AlertFrame3:IsShown() and DRS.AlertFrame3.unitguid and (rareTable[DRS.AlertFrame3.unitguid].nameplate == unitTarget) then
		rareTable[DRS.AlertFrame3.unitguid].health = floor((UnitHealth(unitTarget) / UnitHealthMax(unitTarget)) * 100)
		DRS.AlertFrame3.fontString3:SetText(rareTable[DRS.AlertFrame3.unitguid].health.." %")
		DRS.AlertFrame3.fontString3:Show()
		SendAddonMessageToPartyGuild(DRS.AlertFrame3.unitguid)
	elseif (unitTarget == "target") then
		local guid = UnitGUID("target")
		local type, _, _, _, _, npcID = strsplit("-", guid)
		if (type == "Vehicle") and (npcID == "151623") then -- The Scrap King
			type = "Creature"
			npcID = "151625"
		end
		if (type == "Creature") then
			local defGUID = strjoin("\a",type,npcID)
			if DRS.AlertFrame1 and DRS.AlertFrame1:IsShown() and DRS.AlertFrame1.unitguid and (DRS.AlertFrame1.unitguid == defGUID) then
				rareTable[DRS.AlertFrame1.unitguid].health = floor((UnitHealth(unitTarget) / UnitHealthMax(unitTarget)) * 100)
				DRS.AlertFrame1.fontString3:SetText(rareTable[DRS.AlertFrame1.unitguid].health.." %")
				DRS.AlertFrame1.fontString3:Show()
				SendAddonMessageToPartyGuild(DRS.AlertFrame1.unitguid)
			elseif DRS.AlertFrame2 and DRS.AlertFrame2:IsShown() and DRS.AlertFrame2.unitguid and (DRS.AlertFrame2.unitguid == defGUID) then
				rareTable[DRS.AlertFrame2.unitguid].health = floor((UnitHealth(unitTarget) / UnitHealthMax(unitTarget)) * 100)
				DRS.AlertFrame2.fontString3:SetText(rareTable[DRS.AlertFrame2.unitguid].health.." %")
				DRS.AlertFrame2.fontString3:Show()
				SendAddonMessageToPartyGuild(DRS.AlertFrame2.unitguid)
			elseif DRS.AlertFrame3 and DRS.AlertFrame3:IsShown() and DRS.AlertFrame3.unitguid and (DRS.AlertFrame3.unitguid == defGUID) then
				rareTable[DRS.AlertFrame3.unitguid].health = floor((UnitHealth(unitTarget) / UnitHealthMax(unitTarget)) * 100)
				DRS.AlertFrame3.fontString3:SetText(rareTable[DRS.AlertFrame3.unitguid].health.." %")
				DRS.AlertFrame3.fontString3:Show()
				SendAddonMessageToPartyGuild(DRS.AlertFrame3.unitguid)
			end
		end
	end
	--[[self.texture:SetVertexColor(0,1,0)
					elseif (distance < .12) then
						self.texture:SetVertexColor(1,1,1)
					else
						self.texture:SetVertexColor(1,0,0)]]
end

local function ScanNameplates(unitToken)
	local guid = UnitGUID(unitToken)
	--print(unitToken)
	local type, _, _, _, _, npcID = strsplit("-", guid)
	--[[if (npcID == "151623") then
		print("type is "..type.." npcID is "..npcID)
	end]]
	if (type == "Vehicle") and (npcID == "151623") then -- The Scrap King
		type = "Creature"
		npcID = "151625"
	end
	if type == "Creature" then
		--print(unitToken.." is "..npcID)
		local classification = UnitClassification(unitToken)
		local npcIDnumber = tonumber(npcID)
		if namePlateScanMounts[npcIDnumber] then
			print(npcIDnumber.." SPOTTED")
			local tSpellID, tItemID, tToyItemID, tChatOutput = strsplit("\a",namePlateScanMounts[npcIDnumber])
			if (tItemID ~= "") then
				tItemID = tonumber(tItemID)
				if (GetItemCount(tItemID) <= 0) then
					return
				end
			end
			if (tToyItemID ~= "") then
				tToyItemID = tonumber(tToyItemID)
				if PlayerHasToy(tToyItemID) == false then
					return
				end
			end
			if not mountIDs then
				mountIDs = C_MountJournal.GetMountIDs()
			end
			tSpellID = tonumber(tSpellID)
			for i = 1, #mountIDs do
				local _, spellID, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountIDs[i])
				if (spellID == namePlateScanMounts[npcIDnumber]) and (isCollected == true) then
					return
				elseif (tChatOutput ~= "") then
					print(tChatOutput)
					tChatOutput = ""
					namePlateScanMounts[npcIDnumber] = strjoin("\a", tSpellID, tItemID, tToyItemID, tChatOutput)
				end
			end
		end
		if (classification == "rareelite") or (classification == "rare") or namePlateScanMounts[npcIDnumber] or (npcID == "151159") and not IsQuestFlaggedCompleted(55515) --[[OOX-Fleetfoot/MG for OOX-Avenger/MG]] then
			if (npcID == "151623") then
				--print("type is "..type.." npcID is "..npcID.." classification is "..classification)
			end
			for i = 1, #blacklistedCreatures do
				if (npcIDnumber == blacklistedCreatures[i]) then
					--print("blacklisted "..npcID)
					return
				end
			end
			
			--[[
			-- Arachnoid Harvester fix
			if (npcID and npcID == 154342) then
					npcID = 151934
				end
			]]
			local defGUID = strjoin("\a",type,npcID)
			if rareTable[defGUID] and rareTable[defGUID].donotshow then
				return
			end
			rareTable[defGUID] = rareTable[defGUID] or {}
			rareTable[defGUID].nameplate = unitToken
			rareTable[defGUID].unittype = type
			--print("type = "..type.." npcID = "..npcID.." unitToken = "..unitToken)
			if rareTable[defGUID].yell then
				rareTable[defGUID].yell = nil
			end
			if rareTable[defGUID].emote then
				rareTable[defGUID].emote = nil
			end
			local raidMarkerIndex = GetRaidTargetIndex(unitToken)
			if raidMarkerIndex then
				rareTable[defGUID].raidmarker = raidMarkerIndex
			else
				for i = 1, 8 do
					local raiderMarkerIndexUsed
					for k in pairs(rareTable) do
						if rareTable[k] and rareTable[k].raidmarker and (rareTable[k].raidmarker == i) then
							raiderMarkerIndexUsed = true
							break
						end
					end
					if not raiderMarkerIndexUsed then
						rareTable[defGUID].raidmarker = i
						SetRaidTarget(unitToken,i)
						break
					end
				end
			end
			if not rareTable[defGUID].lastseen then
				rareTable[defGUID].lastseen = GetServerTime()
			end
			local unitName = UnitName(unitToken)
			rareTable[defGUID].unitname = unitName
			lookupTable[defGUID] = unitName --===============================================
			AcquireAlertFrame(defGUID)
			SendAddonMessageToPartyGuild(defGUID)
		end
	end
end

local function ScanVignette(vignetteGUID)
	local VignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteGUID)
	if VignetteInfo and VignetteInfo.objectGUID then
		local type, _, _, _, _, npcID = strsplit("-", VignetteInfo.objectGUID)
		--print(npcID)
		if (type == "Creature") then
			for i = 1, #blacklistedCreatures do
				if (tonumber(npcID) == blacklistedCreatures[i]) then
					--print("blacklisted "..npcID)
					return
				end
			end
			if (tonumber(npcID) == 151933) then -- Malfunctioning Beastbot
				return
			end
		elseif (type == "GameObject") then
			for i = 1, #blacklistedObjects do
				if (tonumber(npcID) == blacklistedObjects[i]) then
					--print("blacklisted "..npcID)
					return
				end
			end
			if (tonumber(npcID) == 325626) and (GetItemCount(174765) < 1) and (GetItemCount(174764) < 6) then -- Amathet Reliquary
				return
			elseif (tonumber(npcID) == 335703) and (GetItemCount(174768) < 1) and (GetItemCount(174758) < 6) then -- Black Empire Coffer
				return
			elseif (tonumber(npcID) == 339243) and (GetItemCount(174761) < 1) and (GetItemCount(174756) < 6) then -- Infested Strongbox
				return
			elseif (tonumber(npcID) == 341469) and (GetItemCount(174766) < 1) and (GetItemCount(174760) < 6) then -- Ambered Coffer
				return
			end
		elseif (type == "Vehicle") and (npcID == "151623") then -- The Scrap King
			type = "Creature"
			npcID = "151625"
		end
		if (type == "Creature") or (type == "GameObject") then
			local defGUID = strjoin("\a",type,npcID)
			--print("1")
			if not rareTable[defGUID] or not rareTable[defGUID].donotshow then
				--print("2")
				if not lookupTable[defGUID] then
					local uiMapID = C_Map.GetBestMapForUnit("player")
					--if uiMapID == 1355 then
						--print("type is "..(type or "unknown").." -- "..(VignetteInfo.name or "unknown").." is "..(npcID or "unknown"))--======================================
					--end
					lookupTable[defGUID] = VignetteInfo.name --===============================================
				end
				rareTable[defGUID] = rareTable[defGUID] or {}
				rareTable[defGUID].unittype = type
				rareTable[defGUID].unitname = VignetteInfo.name
				rareTable[defGUID].vignette = VignetteInfo.objectGUID
				if rareTable[defGUID].yell then
					rareTable[defGUID].yell = nil
				end
				if rareTable[defGUID].emote then
					rareTable[defGUID].emote = nil
				end
				if not rareTable[defGUID].lastseen then
					rareTable[defGUID].lastseen = GetServerTime()
				end
				local uiMapID = C_Map.GetBestMapForUnit("player")
				if uiMapID then
					local vignettePosition = C_VignetteInfo.GetVignettePosition(vignetteGUID, uiMapID)
					if vignettePosition then
						if (vignettePosition and (vignettePosition.x ~= 0) and (vignettePosition.y ~= 0)) then
							rareTable[defGUID].x = vignettePosition.x
							rareTable[defGUID].y = vignettePosition.y
						end
					end
				end
				AcquireAlertFrame(defGUID)
				if (type == "Creature") then
					SendAddonMessageToPartyGuild(defGUID)
				end
			end
		end
	end
	--[[
	string = vignetteGUID
	string = objectGUID
	string = name
	bool = isDead
	bool = onWorldMap
	bool = onMinimap
	bool = isUnique
	bool = inFogOfWar
	string = atlasName
	bool = hasTooltip
	Enum.VignetteType = type (0 = Normal, 1 = PvpBounty)
	number = rewardQuestID
	]]
end

local function ScanAllVignettes()
	--print("007")
	local vignetteGUIDs = C_VignetteInfo.GetVignettes()
	if vignetteGUIDs then
		for i in pairs(vignetteGUIDs) do
			local VignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteGUIDs[i])
			if VignetteInfo and VignetteInfo.objectGUID then
				--print("0")
				ScanVignette(vignetteGUIDs[i])
			end
		end
		for k in pairs(rareTable) do
			if rareTable[k].vignette then
				local x
				for i in pairs(vignetteGUIDs) do
					local VignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteGUIDs[i])
					if VignetteInfo and VignetteInfo.objectGUID then
						if (rareTable[k].vignette == VignetteInfo.objectGUID) then
							x = true
							break
						else
							local type, _, _, _, _, npcID = strsplit("-", VignetteInfo.objectGUID)
							if (type == "Vehicle") and (npcID == "151623") then -- The Scrap King
								type = "Creature"
								npcID = "151625"
								x = true
								break
							elseif (type == "Creature") or (type == "GameObject") then
								local defGUID = strjoin("\a",type,npcID)
								if (k == defGUID) then
									x = true
									break
								end
							end
						end
					end
				end
				if not x then
					if not rareTable[k].donotshow then
						if rareTable[k].nameplate then
							--print("removeVignette1")
							rareTable[k].vignette = nil
						else
							SendAddonMessageToPartyGuild(k, true)
							--print("removeVignette2")
							RemoveAlertFrame(k)
							rareTable[k] = nil
						end
					end
				end
			end
		end
	else
		for k in pairs(rareTable) do
			if not rareTable[k].donotshow then
				if rareTable[k].vignette then
					SendAddonMessageToPartyGuild(k, true)
					--print("removeVignette3")
					RemoveAlertFrame(k)
					rareTable[k] = nil
				end
			end
		end
	end
end

local function RareSafariZoneControl()
	local _, instanceType, _, _, _, _, _, instanceMapID = GetInstanceInfo()
	if (instanceMapID == 1718) then
		--print("Def's Rare Safari = ON-1")
		rareTable = {}
		if DRS.AlertFrame1 then
			DRS.AlertFrame1.Arrow:Hide()
			DRS.AlertFrame1:Hide()
			DRS.AlertFrame1.unitguid = nil
		end
		if DRS.AlertFrame2 then
			DRS.AlertFrame2.Arrow:Hide()
			DRS.AlertFrame2:Hide()
			DRS.AlertFrame2.unitguid = nil
		end
		if DRS.AlertFrame3 then
			DRS.AlertFrame3.Arrow:Hide()
			DRS.AlertFrame3:Hide()
			DRS.AlertFrame3.unitguid = nil
		end
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
		DRS:UnregisterEvent("QUEST_COMPLETE")
		DRS:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		DRS:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED")
		DRS:UnregisterEvent("VIGNETTES_UPDATED")
		DRS:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		local function DelayedMapUI()
			local _, _, _, _, _, _, _, instanceMapID = GetInstanceInfo()
			if (instanceMapID == 1718) then
				DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE") -- No emotes in Nazjatar
				DRS:RegisterEvent("CHAT_MSG_MONSTER_YELL")
				DRS:RegisterEvent("NAME_PLATE_UNIT_ADDED")
				DRS:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
				DRS:RegisterEvent("UNIT_HEALTH_FREQUENT")
				DRS:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
				DRS:RegisterEvent("VIGNETTES_UPDATED")
				DRS:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
				ScanAllVignettes()
			end
		end
		C_Timer.After(5, DelayedMapUI)
	elseif (instanceMapID == 1642) then -- Zandalar
		--print("Def's Rare Safari = OFF-2")
		rareTable = {}
		if DRS.AlertFrame1 then
			DRS.AlertFrame1.Arrow:Hide()
			DRS.AlertFrame1:Hide()
			DRS.AlertFrame1.unitguid = nil
		end
		if DRS.AlertFrame2 then
			DRS.AlertFrame2.Arrow:Hide()
			DRS.AlertFrame2:Hide()
			DRS.AlertFrame2.unitguid = nil
		end
		if DRS.AlertFrame3 then
			DRS.AlertFrame3.Arrow:Hide()
			DRS.AlertFrame3:Hide()
			DRS.AlertFrame3.unitguid = nil
		end
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
		DRS:UnregisterEvent("QUEST_COMPLETE")
		DRS:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		DRS:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED")
		DRS:UnregisterEvent("VIGNETTES_UPDATED")
		DRS:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		local function DelayedMapUI()
			local uiMapID = C_Map.GetBestMapForUnit("player")
			if not uiMapID then
				C_Timer.After(5, DelayedMapUI)
			elseif (uiMapID == 864) then -- Vol'dun
				DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
				DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
				DRS:RegisterEvent("NAME_PLATE_UNIT_ADDED")
				DRS:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
				DRS:UnregisterEvent("UNIT_HEALTH_FREQUENT")
				DRS:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED")
				DRS:UnregisterEvent("VIGNETTES_UPDATED")
				DRS:RegisterEvent("ZONE_CHANGED_NEW_AREA")
				--ScanAllVignettes()
			else
				--print("Def's Rare Safari = OFF-3")
				rareTable = {}
				if DRS.AlertFrame1 then
					DRS.AlertFrame1.Arrow:Hide()
					DRS.AlertFrame1:Hide()
					DRS.AlertFrame1.unitguid = nil
				end
				if DRS.AlertFrame2 then
					DRS.AlertFrame2.Arrow:Hide()
					DRS.AlertFrame2:Hide()
					DRS.AlertFrame2.unitguid = nil
				end
				if DRS.AlertFrame3 then
					DRS.AlertFrame3.Arrow:Hide()
					DRS.AlertFrame3:Hide()
					DRS.AlertFrame3.unitguid = nil
				end
				DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
				DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
				DRS:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
				DRS:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
				DRS:UnregisterEvent("QUEST_COMPLETE")
				DRS:UnregisterEvent("UNIT_HEALTH_FREQUENT")
				DRS:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED")
				DRS:UnregisterEvent("VIGNETTES_UPDATED")
				DRS:RegisterEvent("ZONE_CHANGED_NEW_AREA")
			end
		end
		C_Timer.After(5, DelayedMapUI)
	elseif (instanceMapID == 1643) then
		--print("Def's Rare Safari = OFF-2")
		rareTable = {}
		if DRS.AlertFrame1 then
			DRS.AlertFrame1.Arrow:Hide()
			DRS.AlertFrame1:Hide()
			DRS.AlertFrame1.unitguid = nil
		end
		if DRS.AlertFrame2 then
			DRS.AlertFrame2.Arrow:Hide()
			DRS.AlertFrame2:Hide()
			DRS.AlertFrame2.unitguid = nil
		end
		if DRS.AlertFrame3 then
			DRS.AlertFrame3.Arrow:Hide()
			DRS.AlertFrame3:Hide()
			DRS.AlertFrame3.unitguid = nil
		end
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
		DRS:UnregisterEvent("QUEST_COMPLETE")
		DRS:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		DRS:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED")
		DRS:UnregisterEvent("VIGNETTES_UPDATED")
		DRS:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		local function DelayedMapUI()
			local uiMapID = C_Map.GetBestMapForUnit("player")
			if not uiMapID then
				C_Timer.After(5, DelayedMapUI)
			elseif (uiMapID == 1462) or (uiMapID == 1499) then -- 1499 is some building map.
				--print("Def's Rare Safari = ON-4")
				DRS:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
				DRS:RegisterEvent("CHAT_MSG_MONSTER_YELL")
				DRS:RegisterEvent("NAME_PLATE_UNIT_ADDED")
				DRS:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
				DRS:RegisterEvent("UNIT_HEALTH_FREQUENT")
				DRS:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
				DRS:RegisterEvent("VIGNETTES_UPDATED")
				DRS:RegisterEvent("ZONE_CHANGED_NEW_AREA")
				ScanAllVignettes()
			else
				--print("Def's Rare Safari = OFF-3")
				rareTable = {}
				if DRS.AlertFrame1 then
					DRS.AlertFrame1.Arrow:Hide()
					DRS.AlertFrame1:Hide()
					DRS.AlertFrame1.unitguid = nil
				end
				if DRS.AlertFrame2 then
					DRS.AlertFrame2.Arrow:Hide()
					DRS.AlertFrame2:Hide()
					DRS.AlertFrame2.unitguid = nil
				end
				if DRS.AlertFrame3 then
					DRS.AlertFrame3.Arrow:Hide()
					DRS.AlertFrame3:Hide()
					DRS.AlertFrame3.unitguid = nil
				end
				DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
				DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
				DRS:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
				DRS:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
				DRS:UnregisterEvent("QUEST_COMPLETE")
				DRS:UnregisterEvent("UNIT_HEALTH_FREQUENT")
				DRS:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED")
				DRS:UnregisterEvent("VIGNETTES_UPDATED")
				DRS:RegisterEvent("ZONE_CHANGED_NEW_AREA")
			end
		end
		C_Timer.After(5, DelayedMapUI)
	elseif (instanceMapID == 1) or (instanceMapID == 2241) then
		--print("Def's Rare Safari = ON-1")
		rareTable = {}
		if DRS.AlertFrame1 then
			DRS.AlertFrame1.Arrow:Hide()
			DRS.AlertFrame1:Hide()
			DRS.AlertFrame1.unitguid = nil
		end
		if DRS.AlertFrame2 then
			DRS.AlertFrame2.Arrow:Hide()
			DRS.AlertFrame2:Hide()
			DRS.AlertFrame2.unitguid = nil
		end
		if DRS.AlertFrame3 then
			DRS.AlertFrame3.Arrow:Hide()
			DRS.AlertFrame3:Hide()
			DRS.AlertFrame3.unitguid = nil
		end
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
		DRS:UnregisterEvent("QUEST_COMPLETE")
		DRS:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		DRS:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED")
		DRS:UnregisterEvent("VIGNETTES_UPDATED")
		DRS:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		local function DelayedMapUI()
			local _, _, _, _, _, _, _, instanceMapID = GetInstanceInfo()
			if (instanceMapID == 2241) then
				DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE") -- No emotes in Uldum
				DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
				DRS:RegisterEvent("NAME_PLATE_UNIT_ADDED")
				DRS:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
				DRS:RegisterEvent("UNIT_HEALTH_FREQUENT")
				DRS:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
				DRS:RegisterEvent("VIGNETTES_UPDATED")
				DRS:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
				ScanAllVignettes()
			end
		end
		C_Timer.After(5, DelayedMapUI)
	elseif (instanceMapID == 870) then
		--print("Def's Rare Safari = ON-1")
		rareTable = {}
		if DRS.AlertFrame1 then
			DRS.AlertFrame1.Arrow:Hide()
			DRS.AlertFrame1:Hide()
			DRS.AlertFrame1.unitguid = nil
		end
		if DRS.AlertFrame2 then
			DRS.AlertFrame2.Arrow:Hide()
			DRS.AlertFrame2:Hide()
			DRS.AlertFrame2.unitguid = nil
		end
		if DRS.AlertFrame3 then
			DRS.AlertFrame3.Arrow:Hide()
			DRS.AlertFrame3:Hide()
			DRS.AlertFrame3.unitguid = nil
		end
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
		DRS:UnregisterEvent("QUEST_COMPLETE")
		DRS:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		DRS:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED")
		DRS:UnregisterEvent("VIGNETTES_UPDATED")
		DRS:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		local function DelayedMapUI()
			local _, _, _, _, _, _, _, instanceMapID = GetInstanceInfo()
			if (instanceMapID == 870) then
				local uiMapID = C_Map.GetBestMapForUnit("player")
				if not uiMapID then
					C_Timer.After(5, DelayedMapUI)
				elseif (uiMapID == 1530) then
					DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE") -- No emotes in Uldum
					DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
					DRS:RegisterEvent("NAME_PLATE_UNIT_ADDED")
					DRS:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
					DRS:RegisterEvent("UNIT_HEALTH_FREQUENT")
					DRS:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
					DRS:RegisterEvent("VIGNETTES_UPDATED")
					DRS:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
					ScanAllVignettes()
				end
			end
		end
		C_Timer.After(5, DelayedMapUI)
	else
		--print("Def's Rare Safari = OFF-5")
		rareTable = {}
		if DRS.AlertFrame1 then
			DRS.AlertFrame1.Arrow:Hide()
			DRS.AlertFrame1:Hide()
			DRS.AlertFrame1.unitguid = nil
		end
		if DRS.AlertFrame2 then
			DRS.AlertFrame2.Arrow:Hide()
			DRS.AlertFrame2:Hide()
			DRS.AlertFrame2.unitguid = nil
		end
		if DRS.AlertFrame3 then
			DRS.AlertFrame3.Arrow:Hide()
			DRS.AlertFrame3:Hide()
			DRS.AlertFrame3.unitguid = nil
		end
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
		DRS:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
		DRS:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
		DRS:UnregisterEvent("QUEST_COMPLETE")
		DRS:UnregisterEvent("UNIT_HEALTH_FREQUENT")
		DRS:UnregisterEvent("VIGNETTE_MINIMAP_UPDATED")
		DRS:UnregisterEvent("VIGNETTES_UPDATED")
		DRS:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
	end
end

--[[
For players: Player-[server ID]-[player UID] (Example: "Player-976-0002FD64")
For creatures, pets, objects, and vehicles: [Unit type]-0-[server ID]-[instance ID]-[zone UID]-[ID]-[Spawn UID] (Example: "Creature-0-976-0-11-31146-000136DF91")
Unit Type Names: "Creature", "Pet", "GameObject", and "Vehicle"
For vignettes: Vignette-0-[server ID]-[instance ID]-[zone UID]-0-[spawn UID] (Example: "Vignette-0-970-1116-7-0-0017CAE465" for rare mob Sulfurious) 
]]

DRS:SetScript("OnEvent",function(self,event,...)
	if not MaoRUIPerDB["Misc"]["RareAlerter"] then return end
	if (event=="ADDON_LOADED") then
	--[[elseif event=="CHAT_MSG_BN_WHISPER" or event=="CHAT_MSG_COMMUNITIES_CHANNEL" or event=="CHAT_MSG_GUILD" or event=="CHAT_MSG_INSTANCE_CHAT" or event=="CHAT_MSG_INSTANCE_CHAT_LEADER" or event=="CHAT_MSG_OFFICER"or event=="CHAT_MSG_PARTY" or event=="CHAT_MSG_PARTY_LEADER" or event=="CHAT_MSG_RAID" or event=="CHAT_MSG_RAID_LEADER" or event=="CHAT_MSG_WHISPER" then
		local _,_,_,_,_,_,_,_,_,_,_,guid,bnSenderID=...
		ChatMessageSounds(event,guid,bnSenderID)
	elseif event=="COMBAT_LOG_EVENT_UNFILTERED" then
		local pGUID = UnitGUID("player")
		local _,event,_,_,sourceName,_,_,destGUID,_,_,_,spellID=CombatLogGetCurrentEventInfo()
		if spellID==6770 and destGUID==pGUID and (event=="SPELL_AURA_APPLIED" or event=="SPELL_AURA_REFRESH") then
			SendChatMessage("{rt8} "..(GetSpellLink(6770) or "Sapped").." {rt8}","SAY")
			if sourceName then print((GetSpellLink(6770) or "Sapped").." -- "..sourceName) end
		end]]
	elseif (event == "CHAT_MSG_ADDON") then
		local prefix, text, channel, sender = ...
		if (prefix == "Def's RS") then
			ChatMessageAddon(text,channel,sender)
		end
		--"prefix", "text", "channel", "sender", "target", zoneChannelID, localID, "name", instanceID
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
		ChatEmote(...)
	elseif (event == "CHAT_MSG_MONSTER_YELL") then
		ChatYell(...)
	elseif (event == "NAME_PLATE_UNIT_ADDED") then
		local unitToken = ...
		--tinsert(nameplatesInUse,unitToken)
		--print("NAME_PLATE_UNIT_ADDED "..unitToken)
		ScanNameplates(unitToken)
	elseif (event == "NAME_PLATE_UNIT_REMOVED") then
		local unitToken = ...
		RemoveNamePlate(unitToken)
		--print("NAME_PLATE_UNIT_REMOVED "..unitToken)
	elseif (event == "VIGNETTE_MINIMAP_UPDATED") then
		local vignetteGUID--[[, onMinimap]] = ...
		--print("VIGNETTE_MINIMAP_UPDATED")
		ScanVignette(vignetteGUID)
		--print(vignetteGUID)
		--print(onMinimap)
	elseif (event == "VIGNETTES_UPDATED") then
		--print("VIGNETTES_UPDATED")
		ScanAllVignettes()
	elseif (event == "PLAYER_ENTERING_WORLD") then
		local isInitialLogin, isReloadingUi = ...
		if isInitialLogin or isReloadingUi then
			--[[_, _, _, tocversion = GetBuildInfo()
			if (tocversion >= 80100) then
				retail = true
				GetCVar, SetCVar = C_CVar.GetCVar, C_CVar.SetCVar
			end]]
			--C_ChatInfo.RegisterAddonMessagePrefix("Def's RS")
		end -- END isInitialLogin or isReloadingUi
		if isInitialLogin then
			ShiGuangDB = ShiGuangDB or {-->1 to 499 for settings, 500-1000 for data
				[500] = nil, -- point
				[501] = nil, -- relativePoint
				[502] = nil, -- offsetX
				[503] = nil, -- offsetY
				}
			--MaoRUIPerDB = MaoRUIPerDB or {-->1 to 499 for settings, 500-1000 for data
				--[1] = nil,
				--[2] = nil,
				--}
		end -- END isInitialLogin
		RareSafariZoneControl()
		--if isInitialLogin or isReloadingUi then
		--end -- END isInitialLogin or isReloadingUi
	elseif event=="SAVED_VARIABLES_TOO_LARGE" then
		local addOnName=...
		if addOnName=="_ShiGuang" then
			self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		end
	elseif (event == "UNIT_HEALTH_FREQUENT") then
		local unitTarget = ...
		NamePlateHealth(unitTarget)
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		RareSafariZoneControl()
	end end)
--DRS:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")--======================================
DRS:RegisterEvent("PLAYER_ENTERING_WORLD")
DRS:RegisterEvent("SAVED_VARIABLES_TOO_LARGE")