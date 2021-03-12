local _, ns = ...
local M, R, U, I = unpack(ns)

local oUF = ns.oUF or oUF
local UF = M:RegisterModule("UnitFrames")
local AURA = M:GetModule("Auras")

local format, floor = string.format, math.floor
local pairs, next = pairs, next
local UnitFrame_OnEnter, UnitFrame_OnLeave = UnitFrame_OnEnter, UnitFrame_OnLeave

-- Custom colors
oUF.colors.smooth = {1, 0, 0, .85, .8, .45, .1, .1, .1}

local function ReplacePowerColor(name, index, color)
	oUF.colors.power[name] = color
	oUF.colors.power[index] = oUF.colors.power[name]
end
ReplacePowerColor("MANA", 0, {0, .4, 1})
ReplacePowerColor("SOUL_SHARDS", 7, {.58, .51, .79})
ReplacePowerColor("HOLY_POWER", 9, {.88, .88, .06})
ReplacePowerColor("CHI", 12, {0, 1, .59})
ReplacePowerColor("ARCANE_CHARGES", 16, {.41, .8, .94})

-- Various values
local function retVal(self, val1, val2, val3, val4, val5)
	local mystyle = self.mystyle
	if mystyle == "player" or mystyle == "target" then
		return val1
	elseif mystyle == "focus" then
		return val2
	elseif mystyle == "boss" or mystyle == "arena" then
		return val3
	else
		if mystyle == "nameplate" and val5 then
			return val5
		else
			return val4
		end
	end
end

-- Elements
local function UF_OnEnter(self)
	UnitFrame_OnEnter(self)
	self.Highlight:Show()
end

local function UF_OnLeave(self)
	UnitFrame_OnLeave(self)
	self.Highlight:Hide()
end

function UF:CreateHeader(self)
	local hl = self:CreateTexture(nil, "OVERLAY")
	hl:SetAllPoints()
	hl:SetTexture("Interface\\PETBATTLES\\PetBattle-SelectedPetGlow")
	hl:SetTexCoord(0, 1, .5, 1)
	hl:SetVertexColor(.6, .6, .6)
	hl:SetBlendMode("ADD")
	hl:Hide()
	self.Highlight = hl

	self:RegisterForClicks("AnyUp")
	self:HookScript("OnEnter", UF_OnEnter)
	self:HookScript("OnLeave", UF_OnLeave)
end

local function UpdateHealthColorByIndex(health, index)
	health.colorClass = (index == 2)
	health.colorReaction = (index == 2)
	if health.SetColorTapping then
		health:SetColorTapping(index == 2)
	else
		health.colorTapping = (index == 2)
	end
	if health.SetColorDisconnected then
		health:SetColorDisconnected(index == 2)
	else
		health.colorDisconnected = (index == 2)
	end
	health.colorSmooth = (index == 3)
	if index == 1 then
		health:SetStatusBarColor(.1, .1, .1)
		health.bg:SetVertexColor(.6, .6, .6)
	end
end

function UF:UpdateHealthBarColor(self, force)
	local health = self.Health
	local mystyle = self.mystyle
	if mystyle == "PlayerPlate" then
		health.colorHealth = true
	elseif mystyle == "raid" then
		UpdateHealthColorByIndex(health, R.db["UFs"]["RaidHealthColor"])
	else
		UpdateHealthColorByIndex(health, R.db["UFs"]["HealthColor"])
	end

	if force then
		health:ForceUpdate()
	end
end

function UF:CreateHealthBar(self)
	local mystyle = self.mystyle
	local health = CreateFrame("StatusBar", nil, self)
	health:SetPoint("TOPLEFT", self)
	health:SetPoint("TOPRIGHT", self)
	local healthHeight
	if mystyle == "PlayerPlate" then
		healthHeight = R.db["Nameplate"]["PPHealthHeight"]
	elseif mystyle == "raid" then
		if self.isPartyFrame then
			healthHeight = R.db["UFs"]["PartyHeight"]
		elseif self.isPartyPet then
			healthHeight = R.db["UFs"]["PartyPetHeight"]
		elseif R.db["UFs"]["SimpleMode"] then
			local scale = R.db["UFs"]["SimpleRaidScale"]/10
			healthHeight = 20*scale - 2*scale - R.mult
		else
			healthHeight = R.db["UFs"]["RaidHeight"]
		end
	else
		healthHeight = retVal(self, R.db["UFs"]["PlayerHeight"], R.db["UFs"]["FocusHeight"], R.db["UFs"]["BossHeight"], R.db["UFs"]["PetHeight"])
	end
	health:SetHeight(healthHeight)
	health:SetStatusBarTexture(I.normTex)
	health:SetStatusBarColor(.1, .1, .1)
	health:SetFrameLevel(self:GetFrameLevel() - 2)
	health.backdrop = M.SetBD(health, 0) -- don't mess up with libs
	health.shadow = health.backdrop.__shadow
	M:SmoothBar(health)

	local bg = health:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetTexture(I.bdTex)
	bg:SetVertexColor(.6, .6, .6)
	bg.multiplier = .25

	self.Health = health
	self.Health.bg = bg

	UF:UpdateHealthBarColor(self)
end

function UF:UpdateRaidHealthMethod()
	for _, frame in pairs(oUF.objects) do
		if frame.mystyle == "raid" then
			frame:SetHealthUpdateMethod(R.db["UFs"]["FrequentHealth"])
			frame:SetHealthUpdateSpeed(R.db["UFs"]["HealthFrequency"])
			frame.Health:ForceUpdate()
		end
	end
end

function UF:CreateHealthText(self)
	local mystyle = self.mystyle
	local textFrame = CreateFrame("Frame", nil, self)
	textFrame:SetAllPoints(self.Health)

	local name = M.CreateFS(textFrame, retVal(self, 13, 12, 12, 12, R.db["Nameplate"]["NameTextSize"]), "", false, "LEFT", 3, 0)
	name:SetJustifyH("LEFT")
	if mystyle == "raid" then
		name:SetWidth(self:GetWidth()*.95)
		name:ClearAllPoints()
		if self.isPartyPet then
			name:SetWidth(self:GetWidth()*.55)
			name:SetPoint("LEFT", 3, -1)
		elseif R.db["UFs"]["SimpleMode"] and not self.isPartyFrame then
			name:SetPoint("LEFT", 4, 0)
		elseif R.db["UFs"]["RaidBuffIndicator"] then
			name:SetJustifyH("CENTER")
			if R.db["UFs"]["RaidHPMode"] ~= 1 then
				name:SetPoint("TOP", 0, -3)
			else
				name:SetPoint("CENTER")
			end
		else
			name:SetPoint("TOPLEFT", 2, -2)
		end
		name:SetScale(R.db["UFs"]["RaidTextScale"])
	elseif mystyle == "nameplate" then
		name:SetWidth(self:GetWidth()*.85)
		name:ClearAllPoints()
		name:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 3, 6)
	else
		name:SetWidth(self:GetWidth()*.55)
	end

	if mystyle == "focus" then
		self:Tag(name, "[color][name][afkdnd]")
	elseif mystyle == "nameplate" then
		self:Tag(name, "[nplevel][name]")
	elseif mystyle == "arena" then
		self:Tag(name, "[arenaspec] [color][name]")
	elseif mystyle == "raid" and R.db["UFs"]["SimpleMode"] and R.db["UFs"]["ShowTeamIndex"] and not self.isPartyPet and not self.isPartyFrame then
		self:Tag(name, "[group].[color][name]")
	else
		self:Tag(name, "[color][name]")
	end

	local hpval = M.CreateFS(textFrame, retVal(self, 14, 13, 13, 13, R.db["Nameplate"]["HealthTextSize"]), "", false, "RIGHT", -3, 0)
	if mystyle == "raid" then
		self:Tag(hpval, "[raidhp]")
		if self.isPartyPet then
			hpval:SetPoint("RIGHT", -3, -1)
			self:Tag(hpval, "[hp]")
		elseif R.db["UFs"]["SimpleMode"] and not self.isPartyFrame then
			hpval:SetPoint("RIGHT", -4, 0)
		elseif R.db["UFs"]["RaidBuffIndicator"] then
			hpval:ClearAllPoints()
			hpval:SetPoint("BOTTOM", 0, 1)
			hpval:SetJustifyH("CENTER")
		else
			hpval:SetPoint("RIGHT", -3, -7)
		end
		hpval:SetScale(R.db["UFs"]["RaidTextScale"])
	elseif mystyle == "nameplate" then
		hpval:SetPoint("RIGHT", self, 0, 8)
		self:Tag(hpval, "[nphp]")
	else
		self:Tag(hpval, "[hp]")
	end

	self.nameText = name
	self.healthValue = hpval
end

function UF:UpdateRaidNameText()
	for _, frame in pairs(oUF.objects) do
		if frame.mystyle == "raid" and not frame.isPartyPet then
			local name = frame.nameText
			name:ClearAllPoints()
			if R.db["UFs"]["SimpleMode"] and not frame.isPartyFrame then
				name:SetPoint("LEFT", 4, 0)
			elseif R.db["UFs"]["RaidBuffIndicator"] then
				name:SetJustifyH("CENTER")
				if R.db["UFs"]["RaidHPMode"] ~= 1 then
					name:SetPoint("TOP", 0, -3)
				else
					name:SetPoint("CENTER")
				end
			else
				name:SetPoint("TOPLEFT", 2, -2)
			end
			frame.healthValue:UpdateTag()
		end
	end
end

local function UpdatePowerColorByIndex(power, index)
	power.colorPower = (index == 2)
	power.colorClass = (index ~= 2)
	power.colorReaction = (index ~= 2)
	if power.SetColorTapping then
		power:SetColorTapping(index ~= 2)
	else
		power.colorTapping = (index ~= 2)
	end
	if power.SetColorDisconnected then
		power:SetColorDisconnected(index ~= 2)
	else
		power.colorDisconnected = (index ~= 2)
	end
end

function UF:UpdatePowerBarColor(self, force)
	local power = self.Power
	local mystyle = self.mystyle
	if mystyle == "PlayerPlate" then
		power.colorPower = true
	elseif mystyle == "raid" then
		UpdatePowerColorByIndex(power, R.db["UFs"]["RaidHealthColor"])
	else
		UpdatePowerColorByIndex(power, R.db["UFs"]["HealthColor"])
	end

	if force then
		power:ForceUpdate()
	end
end

local frequentUpdateCheck = {
	["player"] = true,
	["target"] = true,
	["focus"] = true,
	["PlayerPlate"] = true,
}
function UF:CreatePowerBar(self)
	local mystyle = self.mystyle
	local power = CreateFrame("StatusBar", nil, self)
	power:SetStatusBarTexture(I.normTex)
	power:SetPoint("BOTTOMLEFT", self)
	power:SetPoint("BOTTOMRIGHT", self)
	local powerHeight
	if mystyle == "PlayerPlate" then
		powerHeight = R.db["Nameplate"]["PPPowerHeight"]
	elseif mystyle == "raid" then
		if self.isPartyFrame then
			powerHeight = R.db["UFs"]["PartyPowerHeight"]
		elseif self.isPartyPet then
			powerHeight = R.db["UFs"]["PartyPetPowerHeight"]
		elseif R.db["UFs"]["SimpleMode"] then
			powerHeight = 2*R.db["UFs"]["SimpleRaidScale"]/10
		else
			powerHeight = R.db["UFs"]["RaidPowerHeight"]
		end
	else
		powerHeight = retVal(self, R.db["UFs"]["PlayerPowerHeight"], R.db["UFs"]["FocusPowerHeight"], R.db["UFs"]["BossPowerHeight"], R.db["UFs"]["PetPowerHeight"])
	end
	power:SetHeight(powerHeight)
	power:SetFrameLevel(self:GetFrameLevel() - 2)
	power.backdrop = M.CreateBDFrame(power, 0)
	M:SmoothBar(power)

	if self.Health.shadow then
		self.Health.shadow:SetPoint("BOTTOMRIGHT", power.backdrop, R.mult+3, -R.mult-3)
	end

	local bg = power:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetTexture(I.normTex)
	bg.multiplier = .25

	self.Power = power
	self.Power.bg = bg

	power.frequentUpdates = frequentUpdateCheck[mystyle]
	UF:UpdatePowerBarColor(self)
end

function UF:CreatePowerText(self)
	local textFrame = CreateFrame("Frame", nil, self)
	textFrame:SetAllPoints(self.Power)

	local ppval = M.CreateFS(textFrame, retVal(self, 13, 12, 12, 12), "", false, "RIGHT", -3, 2)
	local mystyle = self.mystyle
	if mystyle == "raid" then
		ppval:SetScale(R.db["UFs"]["RaidTextScale"])
	elseif mystyle == "focus" then
		ppval:SetPoint("RIGHT", -3, R.db["UFs"]["FocusPowerOffset"])
	end
	self:Tag(ppval, "[color][power]")
	self.powerText = ppval
end

local textScaleFrames = {
	["player"] = true,
	["target"] = true,
	["focus"] = true,
	["pet"] = true,
	["focustarget"] = true,
	["boss"] = true,
	["arena"] = true,
}
function UF:UpdateTextScale()
	local scale = R.db["UFs"]["UFTextScale"]
	for _, frame in pairs(oUF.objects) do
		local style = frame.mystyle
		if style and textScaleFrames[style] then
			--frame.nameText:SetScale(scale)
			--frame.healthValue:SetScale(scale)
			if frame.powerText then frame.powerText:SetScale(scale) end
			local castbar = frame.Castbar
			if castbar then
				castbar.Text:SetScale(scale)
				castbar.Time:SetScale(scale)
				if castbar.Lag then castbar.Lag:SetScale(scale) end
			end
		end
	end
end

function UF:UpdateRaidTextScale()
	local scale = R.db["UFs"]["RaidTextScale"]
	for _, frame in pairs(oUF.objects) do
		if frame.mystyle == "raid" then
			frame.nameText:SetScale(scale)
			frame.healthValue:SetScale(scale)
			if frame.powerText then frame.powerText:SetScale(scale) end
		end
	end
end


local roleTexCoord = {
	["TANK"] = {.5, .75, 0, 1},
	["HEALER"] = {.75, 1, 0, 1},
	["DAMAGER"] = {.25, .5, 0, 1},
}
local function postUpdateRole(element, role)
	if element:IsShown() then
		element:SetTexCoord(unpack(roleTexCoord[role]))
	end
end

function UF:CreateIcons(self)
	local mystyle = self.mystyle
	local phase = CreateFrame("Frame", nil, self)
	phase:SetSize(22, 2)
	phase:SetPoint("TOP", self.Health, 0, 12)
	phase:SetFrameLevel(5)
	phase:EnableMouse(true)
	local icon = phase:CreateTexture(nil, "OVERLAY")
	icon:SetAllPoints()
	phase.Icon = icon
	self.PhaseIndicator = phase

	local ri = self:CreateTexture(nil, "OVERLAY")
	if mystyle == "raid" then
		ri:SetPoint("TOPRIGHT", self, 5, 5)
	else
		ri:SetPoint("TOPRIGHT", self, 0, 8)
	end
	ri:SetSize(12, 12)
	ri:SetTexture("Interface\\LFGFrame\\LFGROLE")
	ri.PostUpdate = postUpdateRole
	self.GroupRoleIndicator = ri

	local li = self:CreateTexture(nil, "OVERLAY")
	li:SetPoint("TOPLEFT", self, 0, 8)
	li:SetSize(12, 12)
	self.LeaderIndicator = li

	local ai = self:CreateTexture(nil, "OVERLAY")
	ai:SetPoint("TOPLEFT", self, 0, 8)
	ai:SetSize(12, 12)
	self.AssistantIndicator = ai
end

function UF:CreateRaidMark(self)
	local mystyle = self.mystyle
	local ri = self:CreateTexture(nil, "OVERLAY")
	if mystyle == "raid" then
		ri:SetPoint("TOP", self, 0, 10)
	elseif mystyle == "nameplate" then
		ri:SetPoint("RIGHT", self, "LEFT", -3, 0)
		ri:SetParent(self.Health)
	else
		ri:SetPoint("TOPRIGHT", self, "TOPRIGHT", -30, 10)
	end
	local size = retVal(self, 16, 13, 12, 12, 32)
	ri:SetSize(size, size)
	self.RaidTargetIndicator = ri
end

local function createBarMover(bar, text, value, anchor)
	local mover = M.Mover(bar, text, value, anchor, bar:GetHeight()+bar:GetWidth()+3, bar:GetHeight()+3)
	bar:ClearAllPoints()
	bar:SetPoint("RIGHT", mover)
	bar.mover = mover
end

function UF:CreateCastBar(self)
	local mystyle = self.mystyle
	if mystyle ~= "nameplate" and not R.db["UFs"]["Castbars"] then return end

	local cb = CreateFrame("StatusBar", "oUF_Castbar"..mystyle, self)
	cb:SetHeight(31)
	cb:SetWidth(self:GetWidth() - 21)
	M.CreateSB(cb, true, .2, .8, 1)

	if mystyle == "focus" then
		cb:SetFrameLevel(10)
		cb:SetSize(R.db["UFs"]["FocusCBWidth"], R.db["UFs"]["FocusCBHeight"])
		createBarMover(cb, U["Focus Castbar"], "FocusCB", R.UFs.Focuscb)
	elseif mystyle == "boss" or mystyle == "arena" then
		cb:SetPoint("TOPRIGHT", self.Power, "BOTTOMRIGHT", 0, -8)
		cb:SetSize(self:GetWidth(), 10)
	elseif mystyle == "nameplate" then
		cb:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -2)
		cb:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -2)
		cb:SetHeight(self:GetHeight())
	end

	local timer = M.CreateFS(cb, retVal(self, 12, 12, 12, 12, R.db["Nameplate"]["NameTextSize"]-2), "10", false, "RIGHT", -2, 0)
	local name = M.CreateFS(cb, retVal(self, 12, 12, 12, 12, R.db["Nameplate"]["NameTextSize"]-1), "10", false, "LEFT", 2, 0)
	name:SetPoint("RIGHT", timer, "LEFT", -6, 0)
	name:SetJustifyH("LEFT")

	if mystyle ~= "boss" and mystyle ~= "arena" then
		cb.Icon = cb:CreateTexture(nil, "ARTWORK")
		cb.Icon:SetSize(cb:GetHeight(), cb:GetHeight())
		cb.Icon:SetPoint("BOTTOMRIGHT", cb, "BOTTOMLEFT", -3, 0)
		cb.Icon:SetTexCoord(unpack(I.TexCoord))
		M.SetBD(cb.Icon)
	end

	if mystyle == "nameplate" then
		name:SetPoint("LEFT", cb, 6, -3)
		timer:SetPoint("RIGHT", cb, 0, -3)

		local shield = cb:CreateTexture(nil, "OVERLAY")
		shield:SetAtlas("nameplates-InterruptShield")
		shield:SetSize(21, 21)
		shield:SetPoint("CENTER", cb, 21, -3)  --"CENTER", 0, -5
		cb.Shield = shield

		local iconSize = self:GetHeight()*2 + 3
		cb.Icon:SetSize(iconSize, iconSize)
		cb.Icon:SetPoint("BOTTOMRIGHT", cb, "BOTTOMLEFT", -1, 0)
		cb.timeToHold = .5

		cb.glowFrame = M.CreateGlowFrame(cb, iconSize)
		cb.glowFrame:SetPoint("CENTER", cb.Icon)

		local spellTarget = M.CreateFS(cb, R.db["Nameplate"]["NameTextSize"]+3)
		spellTarget:ClearAllPoints()
		spellTarget:SetJustifyH("LEFT")
		spellTarget:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -2)
		cb.spellTarget = spellTarget
	end

	--if mystyle == "nameplate" or mystyle == "boss" or mystyle == "arena" then
		cb.decimal = "%.1f"
	--else
		--cb.decimal = "%.2f"
	--end

	cb.Time = timer
	cb.Text = name
	cb.OnUpdate = M.OnCastbarUpdate
	cb.PostCastStart = M.PostCastStart
	cb.PostCastUpdate = M.PostCastUpdate
	cb.PostCastStop = M.PostCastStop
	cb.PostCastFail = M.PostCastFailed
	cb.PostCastInterruptible = M.PostUpdateInterruptible

	self.Castbar = cb
end

local function reskinTimerBar(bar)
	bar:SetSize(280, 15)
	M.StripTextures(bar)

	local statusbar = _G[bar:GetName().."StatusBar"]
	if statusbar then
		statusbar:SetAllPoints()
		statusbar:SetStatusBarTexture(I.normTex)
	else
		bar:SetStatusBarTexture(I.normTex)
	end

	M.SetBD(bar)
end

function UF:ReskinMirrorBars()
	local previous
	for i = 1, 3 do
		local bar = _G["MirrorTimer"..i]
		reskinTimerBar(bar)

		if previous then
			bar:SetPoint("TOP", previous, "BOTTOM", 0, -5)
		end
		previous = bar
	end
end

function UF:ReskinTimerTrakcer(self)
	local function updateTimerTracker()
		for _, timer in pairs(TimerTracker.timerList) do
			if timer.bar and not timer.bar.styled then
				reskinTimerBar(timer.bar)

				timer.bar.styled = true
			end
		end
	end
	self:RegisterEvent("START_TIMER", updateTimerTracker, true)
end

-- Auras Relevant
function UF.PostCreateIcon(element, button)
	local fontSize = element.fontSize or element.size*.6
	local parentFrame = CreateFrame("Frame", nil, button)
	parentFrame:SetAllPoints()
	parentFrame:SetFrameLevel(button:GetFrameLevel() + 3)
	button.count = M.CreateFS(parentFrame, fontSize, "", false, "BOTTOMRIGHT", 6, -3)
	button.cd:SetReverse(true)
	local needShadow = true
	if element.__owner.mystyle == "raid" and not R.db["UFs"]["RaidBuffIndicator"] then
		needShadow = false
	end
	button.iconbg = M.ReskinIcon(button.icon, needShadow)

	button.HL = button:CreateTexture(nil, "HIGHLIGHT")
	button.HL:SetColorTexture(1, 1, 1, .25)
	button.HL:SetAllPoints()

	button.overlay:SetTexture(nil)
	button.stealable:SetAtlas("bags-newitem")
	button:HookScript("OnMouseDown", AURA.RemoveSpellFromIgnoreList)

	if element.disableCooldown then button.timer = M.CreateFS(button, 12, "") end
end

local filteredStyle = {
	["target"] = true,
	["nameplate"] = true,
	["boss"] = true,
	["arena"] = true,
}

function UF.PostUpdateIcon(element, _, button, _, _, duration, expiration, debuffType)
	if duration then button.iconbg:Show() end

	local style = element.__owner.mystyle
	if style == "nameplate" then
		button:SetSize(element.size, element.size)  --element.size - 4
	else
		button:SetSize(element.size, element.size)
	end

	if button.isDebuff and filteredStyle[style] and not button.isPlayer then
		button.icon:SetDesaturated(true)
	else
		button.icon:SetDesaturated(false)
	end

	if style == "raid" and R.db["UFs"]["RaidBuffIndicator"] then
		button.iconbg:SetBackdropBorderColor(1, 0, 0)
	elseif element.showDebuffType and button.isDebuff then
		local color = oUF.colors.debuff[debuffType] or oUF.colors.debuff.none
		button.iconbg:SetBackdropBorderColor(color[1], color[2], color[3])
	else
		button.iconbg:SetBackdropBorderColor(0, 0, 0)
	end

	if element.disableCooldown then
		if duration and duration > 0 then
			button.expiration = expiration
			button:SetScript("OnUpdate", M.CooldownOnUpdate)
			button.timer:Show()
		else
			button:SetScript("OnUpdate", nil)
			button.timer:Hide()
		end
	end
end

local function bolsterPreUpdate(element)
	element.bolster = 0
	element.bolsterIndex = nil
end

local function bolsterPostUpdate(element)
	if not element.bolsterIndex then return end
	for _, button in pairs(element) do
		if button == element.bolsterIndex then
			button.count:SetText(element.bolster)
			return
		end
	end
end

function UF.PostUpdateGapIcon(_, _, icon)
	if icon.iconbg and icon.iconbg:IsShown() then
		icon.iconbg:Hide()
	end
end

function UF.CustomFilter(element, unit, button, name, _, _, _, _, _, caster, isStealable, _, spellID, _, _, _, nameplateShowAll)
	local style = element.__owner.mystyle
	if name and spellID == 209859 then
		element.bolster = element.bolster + 1
		if not element.bolsterIndex then
			element.bolsterIndex = button
			return true
		end
	elseif style == "raid" then
		if R.db["UFs"]["RaidBuffIndicator"] then
			return R.RaidBuffs["ALL"][spellID] or MaoRUIDB["RaidAuraWatch"][spellID]
		else
			return (button.isPlayer or caster == "pet") and UF.CornerSpells[spellID] or R.RaidBuffs["ALL"][spellID] or R.RaidBuffs["WARNING"][spellID]
		end
	elseif style == "nameplate" or style == "boss" or style == "arena" then
		if element.__owner.isNameOnly then
			return MaoRUIDB["NameplateFilter"][1][spellID] or R.WhiteList[spellID]
		elseif MaoRUIDB["NameplateFilter"][2][spellID] or R.BlackList[spellID] then
			return false
		elseif element.showStealableBuffs and isStealable and not UnitIsPlayer(unit) then
			return true
		elseif MaoRUIDB["NameplateFilter"][1][spellID] or R.WhiteList[spellID] then
			return true
		else
			local auraFilter = R.db["Nameplate"]["AuraFilter"]
			return (auraFilter == 3 and nameplateShowAll) or (auraFilter ~= 1 and (caster == "player" or caster == "pet" or caster == "vehicle"))
		end
	elseif (element.onlyShowPlayer and button.isPlayer) or (not element.onlyShowPlayer and name) then
		return true
	end
end

local function auraIconSize(w, n, s)
	return (w-(n-1)*s)/n
end

function UF:CreateAuras(self)
	local mystyle = self.mystyle
	local bu = CreateFrame("Frame", nil, self)
	bu:SetFrameLevel(self:GetFrameLevel() + 2)
	bu.gap = true
	bu.initialAnchor = "TOPLEFT"
	bu["growth-y"] = "DOWN"
	bu.spacing = 3
	if mystyle == "focus" then
		bu:SetPoint("TOPLEFT", self.Power, "BOTTOMLEFT", 0, -10)
		bu.numBuffs = 0
		bu.numDebuffs = 14
		bu.iconsPerRow = 7
	elseif mystyle == "raid" then
		if R.db["UFs"]["RaidBuffIndicator"] then
			bu.initialAnchor = "LEFT"
			bu:SetPoint("LEFT", self, 15, 0)
			bu.size = 18*R.db["UFs"]["SimpleRaidScale"]/10
			bu.numTotal = 1
			bu.disableCooldown = true
		else
			bu:SetPoint("BOTTOMLEFT", self.Health)
			bu.numTotal = R.db["UFs"]["SimpleMode"] and not self.isPartyFrame and 0 or 6
			bu.iconsPerRow = 6
			bu.spacing = 2
		end
		bu.gap = false
		bu.disableMouse = R.db["UFs"]["AurasClickThrough"]
	elseif mystyle == "nameplate" then
		bu.initialAnchor = "BOTTOMLEFT"
		bu["growth-y"] = "UP"
		--if R.db["Nameplate"]["ShowPlayerPlate"] and R.db["Nameplate"]["NameplateClassPower"] then
			--bu:SetPoint("BOTTOMLEFT", self.nameText, "TOPLEFT", 0, 10 + _G.oUF_ClassPowerBar:GetHeight())
		--else
			bu:SetPoint("BOTTOMLEFT", self.nameText, "TOPLEFT", 0, 5)
		--end
		bu.numTotal = R.db["Nameplate"]["maxAuras"]
		bu.size = R.db["Nameplate"]["AuraSize"]
		bu.showDebuffType = R.db["Nameplate"]["ColorBorder"]
		bu.gap = false
		bu.disableMouse = true
	end

	local width = self:GetWidth()
	local maxAuras = bu.numTotal or bu.numBuffs + bu.numDebuffs
	local maxLines = bu.iconsPerRow and floor(maxAuras/bu.iconsPerRow + .5) or 2
	bu.size = bu.iconsPerRow and auraIconSize(width, bu.iconsPerRow, bu.spacing) or bu.size
	bu:SetWidth(width)
	bu:SetHeight((bu.size + bu.spacing) * maxLines)

	bu.showStealableBuffs = true
	bu.CustomFilter = UF.CustomFilter
	bu.PostCreateIcon = UF.PostCreateIcon
	bu.PostUpdateIcon = UF.PostUpdateIcon
	bu.PostUpdateGapIcon = UF.PostUpdateGapIcon
	bu.PreUpdate = bolsterPreUpdate
	bu.PostUpdate = bolsterPostUpdate

	self.Auras = bu
end

function UF:CreateBuffs(self)
	local bu = CreateFrame("Frame", nil, self)
	bu:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 5)
	bu.initialAnchor = "BOTTOMLEFT"
	bu["growth-x"] = "RIGHT"
	bu["growth-y"] = "UP"
	bu.num = 6
	bu.spacing = 3
	bu.iconsPerRow = 6
	bu.onlyShowPlayer = false

	local width = self:GetWidth()
	bu.size = auraIconSize(width, bu.iconsPerRow, bu.spacing)
	bu:SetWidth(self:GetWidth())
	bu:SetHeight((bu.size + bu.spacing) * floor(bu.num/bu.iconsPerRow + .5))

	bu.showStealableBuffs = true
	bu.PostCreateIcon = UF.PostCreateIcon
	bu.PostUpdateIcon = UF.PostUpdateIcon

	self.Buffs = bu
end

function UF:CreateDebuffs(self)
	local mystyle = self.mystyle
	local bu = CreateFrame("Frame", nil, self)
	bu.spacing = 3
	bu.initialAnchor = "TOPRIGHT"
	bu["growth-x"] = "LEFT"
	bu["growth-y"] = "DOWN"
	if mystyle == "boss" or mystyle == "arena" then
		bu:SetPoint("TOPRIGHT", self, "TOPLEFT", -5, 0)
		bu.num = 10
		bu.iconsPerRow = 5
		bu.CustomFilter = UF.CustomFilter
	end

	local width = self:GetWidth()
	bu.size = auraIconSize(width, bu.iconsPerRow, bu.spacing)
	bu:SetWidth(self:GetWidth())
	bu:SetHeight((bu.size + bu.spacing) * floor(bu.num/bu.iconsPerRow + .5))

	bu.PostCreateIcon = UF.PostCreateIcon
	bu.PostUpdateIcon = UF.PostUpdateIcon

	self.Debuffs = bu
end

-- Class Powers
local barWidth, barHeight = unpack(R.UFs.BarSize)

function UF.PostUpdateClassPower(element, cur, max, diff, powerType, chargedIndex)
	if not cur or cur == 0 then
		for i = 1, 6 do
			element[i].bg:Hide()
		end
	else
		for i = 1, max do
			element[i].bg:Show()
		end
	end

	if diff then
		for i = 1, max do
			element[i]:SetWidth((barWidth - (max-1)*R.margin)/max)
		end
		for i = max + 1, 6 do
			element[i].bg:Hide()
		end
	end

	element.thisColor = cur == max and 1 or 2
	if not element.prevColor or element.prevColor ~= element.thisColor then
		local r, g, b = 1, 0, 0
		if element.thisColor == 2 then
			local color = element.__owner.colors.power[powerType]
			r, g, b = color[1], color[2], color[3]
		end
		for i = 1, #element do
			element[i]:SetStatusBarColor(r, g, b)
		end
		element.prevColor = element.thisColor
	end

	if chargedIndex and chargedIndex ~= element.thisCharge then
		local bar = element[chargedIndex]
		element.chargeStar:SetParent(bar)
		element.chargeStar:SetPoint("CENTER", bar)
		element.chargeStar:Show()
		element.thisCharge = chargedIndex
	else
		element.chargeStar:Hide()
		element.thisCharge = nil
	end
end

function UF:OnUpdateRunes(elapsed)
	local duration = self.duration + elapsed
	self.duration = duration
	self:SetValue(duration)

	if self.timer then
		local remain = self.runeDuration - duration
		if remain > 0 then
			self.timer:SetText(M.FormatTime(remain))
		else
			self.timer:SetText(nil)
		end
	end
end

function UF.PostUpdateRunes(element, runemap)
	for index, runeID in next, runemap do
		local rune = element[index]
		local start, duration, runeReady = GetRuneCooldown(runeID)
		if rune:IsShown() then
			if runeReady then
				rune:SetAlpha(1)
				rune:SetScript("OnUpdate", nil)
				if rune.timer then rune.timer:SetText(nil) end
			elseif start then
				rune:SetAlpha(.6)
				rune.runeDuration = duration
				rune:SetScript("OnUpdate", UF.OnUpdateRunes)
			end
		end
	end
end

function UF:CreateClassPower(self)
	if self.mystyle == "PlayerPlate" then
		barWidth = R.db["Nameplate"]["NameplateClassPower"] and R.db["Nameplate"]["PlateWidth"] or R.db["Nameplate"]["PPWidth"]
		barHeight = R.db["Nameplate"]["PPBarHeight"]
		R.UFs.BarPoint = {"BOTTOMLEFT", self, "TOPLEFT", 0, 3}
	end

	local bar = CreateFrame("Frame", "oUF_ClassPowerBar", self.Health)
	bar:SetSize(barWidth, barHeight)
	bar:SetPoint(unpack(R.UFs.BarPoint))

	local bars = {}
	for i = 1, 6 do
		bars[i] = CreateFrame("StatusBar", nil, bar)
		bars[i]:SetHeight(barHeight)
		bars[i]:SetWidth((barWidth - 5*R.margin) / 6)
		bars[i]:SetStatusBarTexture(I.normTex)
		bars[i]:SetFrameLevel(self:GetFrameLevel() + 5)
		M.SetBD(bars[i], 0)
		if i == 1 then
			bars[i]:SetPoint("BOTTOMLEFT")
		else
			bars[i]:SetPoint("LEFT", bars[i-1], "RIGHT", R.margin, 0)
		end

		bars[i].bg = bar:CreateTexture(nil, "BACKGROUND")
		bars[i].bg:SetAllPoints(bars[i])
		bars[i].bg:SetTexture(I.normTex)
		bars[i].bg.multiplier = .25

		if I.MyClass == "DEATHKNIGHT" and R.db["UFs"]["RuneTimer"] then
			bars[i].timer = M.CreateFS(bars[i], 13, "")
		end
	end

	if I.MyClass == "DEATHKNIGHT" then
		bars.colorSpec = true
		bars.sortOrder = "asc"
		bars.PostUpdate = UF.PostUpdateRunes
		bars.__max = 6
		self.Runes = bars
	else
		local chargeStar = bar:CreateTexture()
		chargeStar:SetAtlas("VignetteKill")
		chargeStar:SetSize(24, 24)
		chargeStar:Hide()
		bars.chargeStar = chargeStar

		bars.PostUpdate = UF.PostUpdateClassPower
		self.ClassPower = bars
	end
end

function UF:StaggerBar(self)
	if I.MyClass ~= "MONK" then return end

	local stagger = CreateFrame("StatusBar", nil, self.Health)
	stagger:SetSize(barWidth, barHeight)
	stagger:SetPoint(unpack(R.UFs.BarPoint))
	stagger:SetStatusBarTexture(I.normTex)
	stagger:SetFrameLevel(self:GetFrameLevel() + 5)
	M.SetBD(stagger, 0)

	local bg = stagger:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetTexture(I.normTex)
	bg.multiplier = .25

	local text = M.CreateFS(stagger, 13)
	text:SetPoint("CENTER", stagger, "TOP")
	self:Tag(text, "[monkstagger]")

	self.Stagger = stagger
	self.Stagger.bg = bg
end

function UF.PostUpdateAltPower(element, _, cur, _, max)
	if cur and max then
		local perc = floor((cur/max)*100)
		if perc < 35 then
			element:SetStatusBarColor(0, 1, 0)
		elseif perc < 70 then
			element:SetStatusBarColor(1, 1, 0)
		else
			element:SetStatusBarColor(1, 0, 0)
		end
	end
end

function UF:CreateAltPower(self)
	local bar = CreateFrame("StatusBar", nil, self)
	bar:SetStatusBarTexture(I.normTex)
	bar:SetPoint("TOPLEFT", self.Power, "BOTTOMLEFT", 0, -3)
	bar:SetPoint("TOPRIGHT", self.Power, "BOTTOMRIGHT", 0, -3)
	bar:SetHeight(2)
	M.SetBD(bar, 0)

	local text = M.CreateFS(bar, 14, "")
	text:SetJustifyH("CENTER")
	self:Tag(text, "[altpower]")

	self.AlternativePower = bar
	self.AlternativePower.PostUpdate = UF.PostUpdateAltPower
end

function UF:CreateExpRepBar(self)
	local bar = CreateFrame("StatusBar", nil, self)
	bar:SetPoint("TOPLEFT", self, "TOPRIGHT", 5, 0)
	bar:SetPoint("BOTTOMRIGHT", self.Power, "BOTTOMRIGHT", 10, 0)
	bar:SetOrientation("VERTICAL")
	M.CreateSB(bar)

	local rest = CreateFrame("StatusBar", nil, bar)
	rest:SetAllPoints(bar)
	rest:SetStatusBarTexture(I.normTex)
	rest:SetStatusBarColor(0, .4, 1, .6)
	rest:SetFrameLevel(bar:GetFrameLevel() - 1)
	rest:SetOrientation("VERTICAL")
	bar.restBar = rest

	M:GetModule("Misc"):SetupScript(bar)
end

function UF:CreatePrediction(self)
	local mhpb = self:CreateTexture(nil, "BORDER", nil, 5)
	mhpb:SetWidth(1)
	mhpb:SetTexture(I.normTex)
	mhpb:SetVertexColor(0, 1, .5, .5)

	local ohpb = self:CreateTexture(nil, "BORDER", nil, 5)
	ohpb:SetWidth(1)
	ohpb:SetTexture(I.normTex)
	ohpb:SetVertexColor(0, 1, 0, .5)

	local abb = self:CreateTexture(nil, "BORDER", nil, 5)
	abb:SetWidth(1)
	abb:SetTexture(I.normTex)
	abb:SetVertexColor(.66, 1, 1, .7)

	local abbo = self:CreateTexture(nil, "ARTWORK", nil, 1)
	abbo:SetAllPoints(abb)
	abbo:SetTexture("Interface\\RaidFrame\\Shield-Overlay", true, true)
	abbo.tileSize = 32

	local oag = self:CreateTexture(nil, "ARTWORK", nil, 1)
	oag:SetWidth(15)
	oag:SetTexture("Interface\\RaidFrame\\Shield-Overshield")
	oag:SetBlendMode("ADD")
	oag:SetAlpha(.7)
	oag:SetPoint("TOPLEFT", self.Health, "TOPRIGHT", -5, 2)
	oag:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMRIGHT", -5, -2)

	local hab = CreateFrame("StatusBar", nil, self)
	hab:SetPoint("TOPLEFT", self.Health)
	hab:SetPoint("BOTTOMRIGHT", self.Health:GetStatusBarTexture())
	hab:SetReverseFill(true)
	hab:SetStatusBarTexture(I.normTex)
	hab:SetStatusBarColor(0, .5, .8, .5)

	local ohg = self:CreateTexture(nil, "ARTWORK", nil, 1)
	ohg:SetWidth(15)
	ohg:SetTexture("Interface\\RaidFrame\\Absorb-Overabsorb")
	ohg:SetBlendMode("ADD")
	ohg:SetAlpha(.5)
	ohg:SetPoint("TOPRIGHT", self.Health, "TOPLEFT", 5, 2)
	ohg:SetPoint("BOTTOMRIGHT", self.Health, "BOTTOMLEFT", 5, -2)

	self.HealPredictionAndAbsorb = {
		myBar = mhpb,
		otherBar = ohpb,
		absorbBar = abb,
		absorbBarOverlay = abbo,
		overAbsorbGlow = oag,
		healAbsorbBar = hab,
		overHealAbsorbGlow = ohg,
		maxOverflow = 1,
	}
end

function UF.PostUpdateAddPower(element, cur, max)
	if element.Text and max > 0 then
		local perc = cur/max * 100
		if perc == 100 then
			perc = ""
			element:SetAlpha(0)
		else
			perc = format("%d%%", perc)
			element:SetAlpha(1)
		end
		element.Text:SetText(perc)
	end
end

function UF:CreateAddPower(self)
	local bar = CreateFrame("StatusBar", nil, self)
	bar:SetPoint("TOPLEFT", self.Power, "BOTTOMLEFT", 0, -3)
	bar:SetPoint("TOPRIGHT", self.Power, "BOTTOMRIGHT", 0, -3)
	bar:SetHeight(4)
	bar:SetStatusBarTexture(I.normTex)
	M.SetBD(bar, 0)
	bar.colorPower = true

	local bg = bar:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetTexture(I.normTex)
	bg.multiplier = .25
	local text = M.CreateFS(bar, 12, "", false, "CENTER", 1, -3)

	self.AdditionalPower = bar
	self.AdditionalPower.bg = bg
	self.AdditionalPower.Text = text
	self.AdditionalPower.PostUpdate = UF.PostUpdateAddPower
	self.AdditionalPower.displayPairs = {
		["DRUID"] = {
			[1] = true,
			[3] = true,
			[8] = true,
		},
		["SHAMAN"] = {
			[11] = true,
		},
		["PRIEST"] = {
			[13] = true,
		}
	}
end

function UF:CreateSwing(self)
	--if not R.db["UFs"]["Castbars"] then return end

	local bar = CreateFrame("StatusBar", nil, self)
	local width = R.db["UFs"]["PlayerCBWidth"] - R.db["UFs"]["PlayerCBHeight"] - 5
	bar:SetSize(width, 3)
	createBarMover(bar, U["UFs SwingBar"], "Swing", {"CENTER", UIParent, "CENTER", 0, -250})
	--bar:SetPoint("TOP", self.Castbar.mover, "BOTTOM", 0, -3)

	local two = CreateFrame("StatusBar", nil, bar)
	two:Hide()
	two:SetAllPoints()
	M.CreateSB(two, true, .8, .8, .8)

	local main = CreateFrame("StatusBar", nil, bar)
	main:Hide()
	main:SetAllPoints()
	M.CreateSB(main, true, .8, .8, .8)

	local off = CreateFrame("StatusBar", nil, bar)
	off:Hide()
	off:SetPoint("TOPLEFT", bar, "BOTTOMLEFT", 0, -3)
	off:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 0, -6)
	M.CreateSB(off, true, .8, .8, .8)

	if R.db["UFs"]["SwingTimer"] then
		bar.Text = M.CreateFS(bar, 11, "")
		bar.TextMH = M.CreateFS(main, 11, "")
		bar.TextOH = M.CreateFS(off, 11, "", false, "CENTER", 1, -5)
	end

	self.Swing = bar
	self.Swing.Twohand = two
	self.Swing.Mainhand = main
	self.Swing.Offhand = off
	self.Swing.hideOoc = true
end

function UF:CreateQuakeTimer(self)
	--if not R.db["UFs"]["Castbars"] then return end

	local bar = CreateFrame("StatusBar", nil, self)
	bar:SetSize(R.db["UFs"]["PlayerCBWidth"], R.db["UFs"]["PlayerCBHeight"])
	M.CreateSB(bar, true, 0, 1, 0)
	bar:Hide()

	bar.SpellName = M.CreateFS(bar, 12, "", false, "LEFT", 2, 0)
	bar.Text = M.CreateFS(bar, 12, "", false, "RIGHT", -2, 0)
	createBarMover(bar, U["QuakeTimer"], "QuakeTimer", {"BOTTOM", UIParent, "BOTTOM", 0, 200})

	local icon = bar:CreateTexture(nil, "ARTWORK")
	icon:SetSize(bar:GetHeight(), bar:GetHeight())
	icon:SetPoint("RIGHT", bar, "LEFT", -3, 0)
	M.ReskinIcon(icon, true)
	bar.Icon = icon

	self.QuakeTimer = bar
end

function UF:CreatePVPClassify(self)
    local bu = self:CreateTexture(nil, "ARTWORK")
    bu:SetSize(30, 30)
	bu:SetPoint("LEFT", self, "RIGHT", 5, -2)

	self.PvPClassificationIndicator = bu
end

local function updatePartySync(self)
	local hasJoined = C_QuestSession.HasJoined()
	if(hasJoined) then
		self.QuestSyncIndicator:Show()
	else
		self.QuestSyncIndicator:Hide()
	end
end

function UF:CreateQuestSync(self)
	local sync = self:CreateTexture(nil, "OVERLAY")
	sync:SetPoint("CENTER", self, "BOTTOMLEFT", 16, 0)
	sync:SetSize(28, 28)
	sync:SetAtlas("QuestSharing-DialogIcon")
	sync:Hide()

	self.QuestSyncIndicator = sync
	self:RegisterEvent("QUEST_SESSION_LEFT", updatePartySync, true)
	self:RegisterEvent("QUEST_SESSION_JOINED", updatePartySync, true)
	self:RegisterEvent("PLAYER_ENTERING_WORLD", updatePartySync, true)
end