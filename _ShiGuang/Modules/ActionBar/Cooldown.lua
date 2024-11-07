local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:RegisterModule("Cooldown")

local pairs, format, floor, strfind = pairs, format, floor, strfind
local GetTime, GetActionCooldown, tonumber = GetTime, GetActionCooldown, tonumber

local FONT_SIZE = 19
local MIN_DURATION = 2.5                    -- the minimum duration to show cooldown text for
local MIN_SCALE = 0.5                       -- the minimum scale we want to show cooldown counts at, anything below this will be hidden
local ICON_SIZE = 36
local hideNumbers, active, hooked = {}, {}, {}

local day, hour, minute = 86400, 3600, 60
function module.FormattedTimer(s, modRate)
	if s >= day then
		return format("%d"..I.MyColor.."d", s/day + .5), s%day
	elseif s > hour then
		return format("%d"..I.MyColor.."h", s/hour + .5), s%hour
	elseif s >= minute then
		if s < R.db["Actionbar"]["MmssTH"] then
			return format("%d:%.2d", s/minute, s%minute), s - floor(s)
		else
			return format("%d"..I.MyColor.."m", s/minute + .5), s%minute
		end
	else
		local colorStr = (s < 3 and "|cffff0000") or (s < 10 and "|cffffff00") or "|cffcccc33"
		if s < R.db["Actionbar"]["TenthTH"] then
			return format(colorStr.."%.1f|r", s), (s - format("%.1f", s)) / modRate
		else
			return format(colorStr.."%d|r", s + .5), (s - floor(s)) / modRate
		end
	end
end

function module:StopTimer()
	self.enabled = nil
	self:Hide()
end

function module:ForceUpdate()
	self.nextUpdate = 0
	self:Show()
end

function module:OnSizeChanged(width, height)
	local fontScale = M:Round((width+height)/2) / ICON_SIZE
	if fontScale == self.fontScale then return end
	self.fontScale = fontScale

	if fontScale < MIN_SCALE then
		self:Hide()
	else
		M.SetFontSize(self.text, fontScale * FONT_SIZE)
		self.text:SetShadowColor(0, 0, 0, 0)

		if self.enabled then
			module.ForceUpdate(self)
		end
	end
end

function module:TimerOnUpdate(elapsed)
	if self.nextUpdate > 0 then
		self.nextUpdate = self.nextUpdate - elapsed
	else
		local passTime = GetTime() - self.start
		local remain = passTime >= 0 and ((self.duration - passTime) / self.modRate) or self.duration
		if remain > 0 then
			local getTime, nextUpdate = module.FormattedTimer(remain, self.modRate)
			self.text:SetText(getTime)
			self.nextUpdate = nextUpdate
		else
			module.StopTimer(self)
		end
	end
end

function module:ScalerOnSizeChanged(...)
	module.OnSizeChanged(self.timer, ...)
end

function module:OnCreate()
	local scaler = CreateFrame("Frame", nil, self)
	scaler:SetAllPoints(self)

	local timer = CreateFrame("Frame", nil, scaler)
	timer:Hide()
	timer:SetAllPoints(scaler)
	timer:SetScript("OnUpdate", module.TimerOnUpdate)
	scaler.timer = timer

	local text = timer:CreateFontString(nil, "BACKGROUND")
	text:SetPoint("CENTER", 1, 0)
	text:SetJustifyH("CENTER")
	timer.text = text

	module.OnSizeChanged(timer, scaler:GetSize())
	scaler:SetScript("OnSizeChanged", module.ScalerOnSizeChanged)

	self.timer = timer
	return timer
end

function module:StartTimer(start, duration, modRate)
	if self:IsForbidden() then return end
	if self.noCooldownCount or hideNumbers[self] then return end

	local frameName = self.GetName and self:GetName()
	if R.db["Actionbar"]["OverrideWA"] and frameName and strfind(frameName, "WeakAuras") then
		self.noCooldownCount = true
		return
	end

	local parent = self:GetParent()
	start = tonumber(start) or 0
	duration = tonumber(duration) or 0
	modRate = tonumber(modRate) or 1

	if start > 0 and duration > MIN_DURATION then
		local timer = self.timer or module.OnCreate(self)
		timer.start = start
		timer.duration = duration
		timer.modRate = modRate
		timer.enabled = true
		timer.nextUpdate = 0

		-- wait for blizz to fix itself
		local charge = parent and parent.chargeCooldown
		local chargeTimer = charge and charge.timer
		if chargeTimer and chargeTimer ~= timer then
			module.StopTimer(chargeTimer)
		end

		if timer.fontScale and timer.fontScale >= MIN_SCALE then
			timer:Show()
		end
	elseif self.timer then
		module.StopTimer(self.timer)
	end

	-- hide cooldown flash if barFader enabled
	if parent and parent.__faderParent then
		if self:GetEffectiveAlpha() > 0 then
			self:Show()
		else
			self:Hide()
		end
	end
end

function module:HideCooldownNumbers()
	hideNumbers[self] = true
	if self.timer then module.StopTimer(self.timer) end
end

function module:CooldownOnShow()
	active[self] = true
end

function module:CooldownOnHide()
	active[self] = nil
end

local function shouldUpdateTimer(self, start)
	local timer = self.timer
	if not timer then
		return true
	end
	return timer.start ~= start
end

function module:CooldownUpdate()
	local button = self:GetParent()
	local start, duration, _, modRate = GetActionCooldown(button.action)

	if shouldUpdateTimer(self, start) then
		module.StartTimer(self, start, duration, modRate)
	end
end

function module:ActionbarUpateCooldown()
	for cooldown in pairs(active) do
		module.CooldownUpdate(cooldown)
	end
end

function module:RegisterActionButton()
	local cooldown = self.cooldown
	if not hooked[cooldown] then
		cooldown:HookScript("OnShow", module.CooldownOnShow)
		cooldown:HookScript("OnHide", module.CooldownOnHide)

		hooked[cooldown] = true
	end
end

function module:OnLogin()
	if not R.db["Actionbar"]["Cooldown"] then return end

	local cooldownIndex = getmetatable(ActionButton1Cooldown).__index
	hooksecurefunc(cooldownIndex, "SetCooldown", module.StartTimer)

	hooksecurefunc("CooldownFrame_SetDisplayAsPercentage", module.HideCooldownNumbers)

	M:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", module.ActionbarUpateCooldown)

	if _G["ActionBarButtonEventsFrame"].frames then
		for _, frame in pairs(_G["ActionBarButtonEventsFrame"].frames) do
			module.RegisterActionButton(frame)
		end
	end
	hooksecurefunc(ActionBarButtonEventsFrameMixin, "RegisterFrame", module.RegisterActionButton)

	-- Hide Default Cooldown
	SetCVar("countdownForCooldowns", 0)
end

--[[------------Fivecombo-----------------------------------------------
local OverlayedSpellID = {};
OverlayedSpellID["ROGUE"] = {
	408,   --Éö»÷
	1943,  --¸îÁÑ
	2098,  --´Ì¹Ç
	5171,  --ÇÐ¸î
	8647,  --ÆÆ¼×
	26679, --ÖÂÃüÍ¶ÖÀ
	32645, --¶¾ÉË
	73651, --»Ö¸´
	193316,
	195452,
	196819,
	199804,
	206237,
};
OverlayedSpellID["DRUID"] = {
	1079,   --¸îÁÑ
	22568,  --¸îËé
	22570,  --Ð×ÃÍËºÒ§
	52610,  --Ò°ÂùÅØÏø
};

local function IsOverlayedSpell(spellID)
	local _, class = UnitClass("player");
	if (not OverlayedSpellID[class]) then return false end
	for i, id in ipairs(OverlayedSpellID[class]) do
		if (id == spellID) then
			return true;
		end
	end
	return false;
end
local function comboEventFrame_OnUpdate(self, elapsed)
	local countTime = self.countTime - elapsed;
	if (countTime <= 0) then
		local parent = self:GetParent();
		local points = UnitPower("player", Enum.PowerType.ComboPoints)
		local maxPoints = UnitPowerMax("player", Enum.PowerType.ComboPoints)
		if (self.isAlert and points ~= maxPoints) then
			self:SetScript("OnUpdate", nil);
			M.HideOverlayGlow(parent);
			self.countTime = 0;
		end
		self.countTime = TOOLTIP_UPDATE_TIME;
	end
end

hooksecurefunc(ActionBarButtonEventsFrameMixin, "RegisterFrame", function(self, elapsed)
	if (self.comboEventFrame) then return end
	self.comboEventFrame = CreateFrame("Frame", nil, self);
	self.comboEventFrame.countTime = 0;
	self.comboEventFrame:RegisterEvent("UNIT_POWER_UPDATE");
	self.comboEventFrame:RegisterEvent('UNIT_POWER_FREQUENT')
	self.comboEventFrame:RegisterEvent('UNIT_MAXPOWER')
	self.comboEventFrame:SetScript("OnEvent", function(self, event, ...)
	local parent = self:GetParent();
	local spellType, id, subType  = GetActionInfo(parent.action);
	-- Èç¹ûÊÇÏµÍ³×ÔÉíµÄÌáÊ¾£¬¾Í²»ÔÙ´¦Àí
	if ( spellType == "spell" and IsSpellOverlayed(id) ) then
		return;
	elseif (spellType == "macro") then
		local _, _, spellId = GetMacroSpell(id);
		if ( spellId and IsSpellOverlayed(spellId) ) then
			return;
		end		
	end
	if UnitPower("player", Enum.PowerType.ComboPoints) == UnitPowerMax("player", Enum.PowerType.ComboPoints) then		
		if ( spellType == "spell" and IsOverlayedSpell(id) ) then
			M.ShowOverlayGlow(parent);
			self.isAlert = true;
			self:SetScript("OnUpdate", comboEventFrame_OnUpdate);
		elseif ( spellType == "macro" ) then
			local _, _, spellId = GetMacroSpell(id);
			if ( spellId and IsOverlayedSpell(spellId) ) then
				M.ShowOverlayGlow(parent);
				self.isAlert = true;
				self:SetScript("OnUpdate", comboEventFrame_OnUpdate);
			else
				M.HideOverlayGlow(parent);
			end
		else
			M.HideOverlayGlow(parent);
		end
	else
		M.HideOverlayGlow(parent);
	end	
  end);
end)]]