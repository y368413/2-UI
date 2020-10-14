
local CCIconsFrame = CreateFrame("Frame")
local Database = {
	-- Death Knight
	[115001] = 6, -- Remorseless Winter
	-- Warrior
	[132168] = 4, -- Shockwave	
	-- Monk
	[119381] = 5, -- Leg Sweep
	[120086] = 3.5, -- Fists of Fury
	-- Shaman
	[118905] = 5, -- Static Charge (Capacitor Totem)
	-- Druid
	-- Rogue
	-- Mage
	-- Dragon's Breath
	-- Ring of Frost
	-- Warlock
	-- Priest
	-- Paladin
	-- Hunter
	[117526] = 5, -- Binding Shot
	-- Racials
	[20549] = 2, -- War Stomp
	[25046] = 2, -- Arcane Torrent (Energy)
	[28730] = 2, -- Arcane Torrent (Mana)
	[50613] = 2, -- Arcane Torrent (Runic Power)
	[69179] = 2, -- Arcane Torrent (Rage)
	[80483] = 2, -- Arcane Torrent (Focus)
	[129597] = 2, -- Arcane Torrent (Chi)
	-- Professions
	[67890] = 3, -- Cobalt Frag Bomb (Engineering)
}

local Backdrop = {
	bgFile = "Interface\\Buttons\\WHITE8X8",
	insets = {top = 0, left = 0, bottom = 0, right = 0},
}

local CheckInstance = function(self)
	local InInstance, InstanceType = IsInInstance()
	if (InInstance and InstanceType == "party") then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	else
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end

local OnMouseUp = function(self, button)
	if self.Locked then return end	
	if (button == "RightButton") then
		self:ClearAllPoints()
		self:SetPoint("CENTER", UIParent, "CENTER", 0, -120)
	end
end

local IconFrame = CreateFrame("Frame", "CCIconsFrame", UIParent, "BackdropTemplate")
IconFrame:SetPoint("CENTER", UIParent, "CENTER", 0, -120)
IconFrame:SetWidth(43)
IconFrame:SetHeight(43)
IconFrame:SetBackdrop(Backdrop)
IconFrame:SetBackdropColor(0, 0, 0)
IconFrame:Hide()
IconFrame:SetMovable(true)
IconFrame:SetUserPlaced(true)
IconFrame:SetScript("OnDragStart", IconFrame.StartMoving)
IconFrame:SetScript("OnDragStop", IconFrame.StopMovingOrSizing)
IconFrame:SetScript("OnMouseUp", OnMouseUp)
IconFrame.Locked = true
IconFrame.Alpha = 1

IconFrame.Icon = IconFrame:CreateTexture(nil, "ARTWORK")
IconFrame.Icon:SetPoint("TOPLEFT", IconFrame, 1, -1)
IconFrame.Icon:SetPoint("BOTTOMRIGHT", IconFrame, -1, 1)
IconFrame.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

IconFrame.Text = IconFrame:CreateFontString(nil, "OVERLAY")
IconFrame.Text:SetFont("Interface\\Addons\\_ShiGuang\\Media\\Fonts\\Loli.ttf", 16, "OUTLINE")
IconFrame.Text:SetPoint("TOP", IconFrame, "BOTTOM", 0, -5)

IconFrame.CD = CreateFrame("Cooldown", "CCIconsCooldown", IconFrame, "CooldownFrameTemplate")
IconFrame.CD:SetPoint("TOPLEFT", IconFrame, 1, -1)
IconFrame.CD:SetPoint("BOTTOMRIGHT", IconFrame, -1, 1)

local NumRegions = IconFrame.CD:GetNumRegions()

for i = 1, NumRegions do
	local Region = select(i, IconFrame.CD:GetRegions())
	if Region.GetText then
		Region:SetFont("Interface\\Addons\\_ShiGuang\\Media\\Fonts\\Loli.ttf", 18, "OUTLINE")
		Region:SetPoint("CENTER", 1, 0)
		Region:SetTextColor(1, 1, 1)
	end 
end

local OnUpdate = function(self, elapsed)
	self.Alpha = (self.Alpha - elapsed * 1.8)
	self:SetAlpha(self.Alpha)
	if (self.Alpha <= 0) then
		self:SetScript("OnUpdate", nil)
		self:Hide()
		self:SetAlpha(1)
		self.Alpha = 1
	end
end

function CCIconsFrame:PLAYER_ENTERING_WORLD()
	CheckInstance(self)
end

function CCIconsFrame:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, hide, sourceguid, sourcename, sourceflags, sourcerf, destguid, destname, destflags, destrf, id, name)
	if (event == "SPELL_AURA_APPLIED") and Database[id] then
		IconFrame.Icon:SetTexture(GetSpellTexture(id))
		IconFrame.Text:SetText(name)
		IconFrame.CD:SetCooldown(GetTime(), Database[id])
		if (not IconFrame:IsVisible()) then IconFrame:Show() end
		if IconFrame:GetScript("OnUpdate") then
			IconFrame:SetScript("OnUpdate", nil)
			IconFrame:SetAlpha(1)
			IconFrame.Alpha = 1
		end
	elseif (event == "SPELL_AURA_REMOVED") and Database[id] then
		if IconFrame:IsVisible() then
			IconFrame:SetScript("OnUpdate", OnUpdate)
		end
	end
end

CCIconsFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
CCIconsFrame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

local SlashHandler = function(cmd)
	if (cmd == "move") then
		if IconFrame.Locked then
			IconFrame:EnableMouse(true)
			IconFrame:RegisterForDrag("LeftButton")
			IconFrame.Text:SetText("Move me!")
			IconFrame.Icon:SetTexture("Interface\\ICONS\\inv_misc_bearcubbrown")
			IconFrame:Show()
			IconFrame.Locked = false
		else
			IconFrame:EnableMouse(false)
			IconFrame:Hide()
			IconFrame.Text:SetText("")
			IconFrame.Icon:SetTexture("")
			IconFrame.Locked = true
		end
	end
end

SLASH_CCICONS1 = "/cci"
SlashCmdList["CCICONS"] = SlashHandler