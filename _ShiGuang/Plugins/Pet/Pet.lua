﻿--[[ Battle Pet Ability Tooltips ## Auhtor: Gello ## Version: 1.0.8 ]]

local tooltips = {}
local function init()
	for i=1,3 do
		table.insert(tooltips,CreateFrame("Frame",nil,PetBattlePrimaryUnitTooltip,"SharedPetBattleAbilityTooltipTemplate"))
	end
	PetBattlePrimaryUnitTooltip:HookScript("OnHide",function() for i=1,3 do tooltips[i]:Hide() end end)
end
local function list(self,owner,pet)
	local anchorTo = self
	local tooltip
	for ability=1,3 do
		tooltip = tooltips[ability]
		if C_PetBattles.GetAbilityInfo(owner,pet,ability) then
			PET_BATTLE_ABILITY_INFO.petOwner = owner
			PET_BATTLE_ABILITY_INFO.petIndex = pet
			PET_BATTLE_ABILITY_INFO.abilityID = nil
			PET_BATTLE_ABILITY_INFO.abilityIndex = ability
			SharedPetBattleAbilityTooltip_SetAbility(tooltip,PET_BATTLE_ABILITY_INFO)
			tooltip:ClearAllPoints()
			if ability>1 then
				tooltip:SetPoint("TOP",anchorTo,"BOTTOM")
			elseif owner==1 then
				tooltip:SetPoint("TOPLEFT",anchorTo,"TOPRIGHT")
			else
				tooltip:SetPoint("TOPRIGHT",anchorTo,"TOPLEFT")
			end
			tooltip:Show()
			anchorTo = tooltip
		else
			tooltip:Hide()
		end
	end
end

local BattlePetAbilityTooltips = CreateFrame("Frame")
BattlePetAbilityTooltips:SetScript("OnEvent",function(self,event,addon)
	if C_AddOns.IsAddOnLoaded("Blizzard_PetBattleUI") then
		init()
		hooksecurefunc("PetBattleUnitTooltip_UpdateForUnit",list)
		self:UnregisterEvent("ADDON_LOADED")
	end
end)
BattlePetAbilityTooltips:RegisterEvent("ADDON_LOADED")



--[[ Battle Pet Battle Stats ## Author: Gell o## Version: 1.0.10 ]]
local frame = CreateFrame("Frame")
frame.notSetUp = true
frame.texCoords = {Power={0,.5,0,.5}, Speed={0,.5,.5,1}, Health={.5,1,.5,1}}

-- PetBattleUI appears to load very early, but not guaranteed: check if loaded
-- at PLAYER_LOGIN to setup, and then watch for ADDON_LOADED until setup turns it off
frame:SetScript("OnEvent",function(self,event,...)
  if self.notSetUp and C_AddOns.IsAddOnLoaded("Blizzard_PetBattleUI") then
    self:SetUpWidgets() -- runs once when PetBattleUI known to be loaded
	elseif event=="PET_BATTLE_CLOSE" then
		PetBattleFrame.TopVersusText:SetPoint("TOP",PetBattleFrame,"TOP",0,-26)
		PetBattleFrame.TopVersusText:SetFontObject("GameFont_Gigantic")
		PetBattleFrame.TopVersusText:SetText(PET_BATTLE_UI_VS)
		if self.widgets.RoundTitle then self.widgets.RoundTitle:Hide() end
	else
		if event=="PET_BATTLE_PET_ROUND_RESULTS" then
            local roundNumber = (...)
                  round = roundNumber
			PetBattleFrame.TopVersusText:SetFontObject("Game36Font")
			PetBattleFrame.TopVersusText:SetPoint("TOP",PetBattleFrame,"TOP",0,-45)
			PetBattleFrame.TopVersusText:SetText(round)
			if not self.widgets.RoundTitle then
				self.widgets.RoundTitle = PetBattleFrame:CreateFontString(nil,"ARTWORK","GameFontNormal")
				self.widgets.RoundTitle:SetPoint("BOTTOM",PetBattleFrame.TopVersusText,"TOP",0,2)
				--self.widgets.RoundTitle:SetText("")
			end
			self.widgets.RoundTitle:Show()
		end
    self:UpdateWidgets() -- runs every other time (events registered in setup)
  end
end)
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

-- sets up a icon+text widget
-- parent: PetBattleFrame.ActiveAlly or PetBattleFrame.ActiveEnemy
-- widgetType: "Health" "Power" or "Speed"
-- anchor: the corner of the parent to anchor the top of the widget's icon
-- xoff: x-offset from the anchor
function frame:CreateWidget(parent,widgetType,anchor,xoff)
  local widget = CreateFrame("Frame",nil,parent)
  widget:SetSize(16,16)
  widget.icon = widget:CreateTexture(nil,"OVERLAY")
  widget.icon:SetAllPoints(true)
  widget.icon:SetTexture("Interface\\PetBattles\\PetBattle-StatIcons")
  if frame.texCoords[widgetType] then
    widget.icon:SetTexCoord(unpack(frame.texCoords[widgetType]))
  end
  widget.text = widget:CreateFontString(nil,"OVERLAY","GameFontHighlight")
  widget.text:SetFont("Interface\\Addons\\_ShiGuang\\Media\\Fonts\\Pixel.ttf", 16, "")
  widget.text:SetPoint("LEFT",widget.icon,"RIGHT",2,0)
  widget:SetPoint("TOP",parent,anchor,xoff,6)
  return widget
end

-- creates widgets and registers for events
function frame:SetUpWidgets()
  self.notSetUp = nil
  self.widgets = {}
  for i=1,2 do
    self.widgets[i] = {}
    local parent = i==1 and PetBattleFrame.ActiveAlly or PetBattleFrame.ActiveEnemy
    local anchor = i==1 and "BOTTOMRIGHT" or "BOTTOMLEFT"
    local offset = i==1 and -160 or -21
    self.widgets[i].Health = i==1 and self:CreateWidget(parent,"Health",anchor,offset+120) or self:CreateWidget(parent,"Health",anchor,offset+4)
    self.widgets[i].Power = i==1 and self:CreateWidget(parent,"Power",anchor,offset+60) or self:CreateWidget(parent,"Power",anchor,offset+80)
    self.widgets[i].Speed = i==1 and self:CreateWidget(parent,"Speed",anchor,offset+0) or self:CreateWidget(parent,"Speed",anchor,offset+138)
  end
  self:UnregisterEvent("ADDON_LOADED")
  self:RegisterEvent("PET_BATTLE_AURA_APPLIED")
  self:RegisterEvent("PET_BATTLE_AURA_CHANGED")
  self:RegisterEvent("PET_BATTLE_AURA_CANCELED")
  self:RegisterEvent("PET_BATTLE_HEALTH_CHANGED")
  self:RegisterEvent("PET_BATTLE_PET_CHANGED")
  self:RegisterEvent("PET_BATTLE_PET_ROUND_RESULTS")
  self:RegisterEvent("PET_BATTLE_CLOSE")
end

-- updates both ally and enemy active pet stats
function frame:UpdateWidgets()
  for i=1,2 do
    local pet = C_PetBattles.GetActivePet(i)
    local health = C_PetBattles.GetHealth(i,pet)
    local maxHealth = C_PetBattles.GetMaxHealth(i,pet)
    self.widgets[i].Health.text:SetText(format("%.1f%%",health*100/maxHealth))
    self.widgets[i].Power.text:SetText(C_PetBattles.GetPower(i,pet))
    self.widgets[i].Speed.text:SetText(C_PetBattles.GetSpeed(i,pet))
  end
end

--[[ Cloudy Pet Collected ## Author: Cloudyfa ## Version: 1.9 
--- Pet String Calculation ---
local function GetPetString(name)
	if (not name) or (name == '') then return end
	if (not CollectionsJournal) then CollectionsJournal_LoadUI() end

	local petString, petID, speciesID
	speciesID, petID = C_PetJournal.FindPetIDByName(name)

	if speciesID and (speciesID > 0) then
		if petID then
			local level = select(3, C_PetJournal.GetPetInfoByPetID(petID))
			local quality = select(5, C_PetJournal.GetPetStats(petID))

			local color = ITEM_QUALITY_COLORS[quality - 1].hex
			petString = color .. COLLECTED .. ' -' .. level .. '-|r'
		else
			local color = ITEM_QUALITY_COLORS[5].hex
			petString = color .. NOT_COLLECTED .. '|r'
		end
	end

	return petString
end
--- Set Pet Info ---
local function SetPetInfo(tooltip, name)
	local petString = GetPetString(name)
	if (not petString) then return end

	local petLine
	for i = 2, tooltip:NumLines() do
		local line = _G[tooltip:GetName() .. 'TextLeft' .. i]
		local text = line:GetText()

		if text then
			if (text == NOT_COLLECTED) or (text == UNIT_CAPTURABLE) or strfind(text, COLLECTED) then
				petLine = line
				break
			end
		end
	end

	if petLine then
		petLine:SetText(petString)
	else
		tooltip:AddLine(petString)
	end

	tooltip:Show()
end
--- Pet Battle Tooltip ---
hooksecurefunc('PetBattleUnitTooltip_UpdateForUnit', function(self, owner, index)
	if (owner == LE_BATTLE_PET_ENEMY) and C_PetBattles.IsWildBattle() then
		local petName = C_PetBattles.GetName(owner, index)
		local petString = GetPetString(petName)

		self.CollectedText:SetText(petString)
	end
end)
--- Pet Cage Tooltip ---
local function PetCageOnShow(self)
	local petName = self.Name and self.Name:GetText()
	local petString = GetPetString(petName)

	if petString then
		self.Owned:SetText(petString)

		if self.Delimiter then
			self:SetSize(260,164)
			self.Delimiter:ClearAllPoints()
		else
			self:SetSize(260,136)
		end

		self:Show()
	end
end
BattlePetTooltip:HookScript('OnUpdate', PetCageOnShow)
FloatingBattlePetTooltip:HookScript('OnUpdate', PetCageOnShow)
--- Pet Item Tooltip ---
local function OnTooltipSetItem(self)
	local name = self:GetItem()

	if name and (name ~= '') then
		SetPetInfo(self, name)
	end
end
GameTooltip:HookScript('OnTooltipSetItem', OnTooltipSetItem)
ItemRefTooltip:HookScript('OnTooltipSetItem', OnTooltipSetItem)
--- Pet Unit Tooltip ---
GameTooltip:HookScript('OnTooltipSetUnit', function(self)
	local _, unit = self:GetUnit()

	if unit and UnitIsWildBattlePet(unit) then
		local name = GetUnitName(unit)
		SetPetInfo(self, name)
	end
end)
--- Pet Minimap Tooltip ---
GameTooltip:HookScript('OnUpdate', function(self)
	if self:IsOwned(Minimap) then
		local line = _G[self:GetName() .. 'TextLeft1']
		local text = line:GetText()

		if (not text) or (text == '') then return end

		local lines = {text}
		if strfind(text, '\n') then
			lines = {strsplit('\n', text)}
		end

		for i = 1, #lines do
			local name = gsub(lines[i], '|T.-|t', '')

			local petString = GetPetString(name)
			if petString and (not UnitPlayerControlled(name)) then
				lines[i] = lines[i] .. '  ' .. petString
			end
		end

		text = table.concat(lines, '\n')

		line:SetText(text)
		self:Show()
	end
end)]]


--[[Pet Battle Announcer]]
-- This is the main function of the addon that will hook into pet battle event and play a sound
--hooksecurefunc("StaticPopupSpecial_Show",function(f)
    --if f == PetBattleQueueReadyFrame then
        --PlaySound("ReadyCheck") -- Here is the sound, it can be changed to any sound in wow.
    --end
--end)

--[[Pet map show]]
local Petmapshow = CreateFrame("Frame", nil, UIParent)
Petmapshow:RegisterEvent("PLAYER_ENTERING_WORLD")
Petmapshow:SetScript("OnEvent", function(self, event, ...)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		FRAMELOCK_STATES["PETBATTLES"]["MinimapCluster"]=""
		FRAMELOCK_STATES["PETBATTLES"]["WatchFrame"]=""
end)

--[[BattlePet Tooltip Plus]]
hooksecurefunc (_G, "BattlePetToolTip_Show",
  function(speciesID, ...)
      BattlePetTooltip:AddLine(" ")
      local petInfo = {C_PetJournal.GetPetInfoBySpeciesID(speciesID)}
      local colored = petInfo[5]:gsub("|n$", ""):gsub("|r", "|cffffffff") .. "|r"
      GameTooltip_AddNormalLine(BattlePetTooltip, colored, true)
  end
)