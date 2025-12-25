local _, Skada = ...
Skada:AddLoadableModule("Threat", nil, function(Skada, L)
	if Skada.db.profile.modulesBlocked.Threat then return end

	local mod = Skada:NewModule(L["Threat"])
	local media = LibStub("LibSharedMedia-3.0")
	local format = string.format
	local time = time
	local UnitExists = UnitExists
	local UnitName = UnitName
	local UnitIsFriend = UnitIsFriend
	local UnitDetailedThreatSituation = UnitDetailedThreatSituation
	local PlaySoundFile = PlaySoundFile
	local CreateFrame = CreateFrame
	local UIParent = UIParent
	local WorldFrame = WorldFrame
	local InCombatLockdown = InCombatLockdown
	local random = math.random
	local tinsert = table.insert

	local last_warn = 0
	local dataset_index = 1

	-- Find the best target to track threat on
	local function find_threat_target()
		if UnitExists("target") and not UnitIsFriend("player", "target") then
			return "target"
		elseif Skada.db.profile.modules.threatfocustarget then
			if UnitExists("focus") and not UnitIsFriend("player", "focus") then
				return "focus"
			elseif UnitExists("focustarget") and not UnitIsFriend("player", "focustarget") then
				return "focustarget"
			end
		end
		if UnitExists("target") and UnitIsFriend("player", "target") and UnitExists("targettarget") and not UnitIsFriend("player", "targettarget") then
			return "targettarget"
		end
		return nil
	end

	-- Format threat values for display
	local function format_threat(value)
		value = tonumber(value) or 0
		if value >= 100000 then
			return format("%.1fk", value / 100000)
		end
		return format("%d", value / 100)
	end

	-- Calculate TPS (Threat Per Second)
	local function calculate_tps(threat_value)
		if not Skada.current then return "0" end
		local total_time = time() - Skada.current.starttime
		return format_threat(threat_value / math.max(1, total_time))
	end

	-- Add unit's threat data to the dataset
	local function add_threat_data(win, unit, target)
		if not unit or not UnitExists(unit) then return end

		local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation(unit, target)
		if not threatpct then return end

		local d = win.dataset[dataset_index] or {}
		win.dataset[dataset_index] = d

		d.id = unit
		d.label = UnitName(unit)
		d.class = select(2, UnitClass(unit))
		d.role = UnitGroupRolesAssigned(unit)
		d.isTanking = isTanking
		d.value = Skada.db.profile.modules.threatraw and threatvalue or threatpct
		d.threat = threatvalue
		d.tps = calculate_tps(threatvalue)

		dataset_index = dataset_index + 1
		return d.value
	end

	-- Check if we should warn the player about threat
	local function check_threat_warning(self, data, maxvalue)
		if not data or time() - last_warn <= 2 then return end

		if data.label == UnitName("player") then
			local treshold = Skada.db.profile.modules.threattreshold or 100
			local percent = data.value
			if Skada.db.profile.modules.threatraw then
				-- Convert raw threat to percentage for warning check
				percent = (data.value / maxvalue) * 100
			end

			if percent >= treshold and
				(not data.isTanking or not Skada.db.profile.modules.notankwarnings) then
				if Skada.db.profile.modules.threatflash then
					self:Flash()
				end
				if Skada.db.profile.modules.threatshake then
					self:Shake()
				end
				if Skada.db.profile.modules.threatsound then
					PlaySoundFile(media:Fetch("sound", Skada.db.profile.modules.threatsoundname))
				end
				last_warn = time()
			end
		end
	end

	function mod:Update(win, set)
		local target = find_threat_target()
		if not target then
			win.metadata.title = self:GetName()
			return
		end

		win.metadata.title = UnitName(target)
		dataset_index = 1

		local max_value = 0
		local type, count = Skada:GetGroupTypeAndCount()

		-- Add group members and their pets
		if count > 0 then
			for i = 1, count do
				local unit = format("%s%d", type, i)
				local value = add_threat_data(win, unit, target)
				if value then max_value = math.max(max_value, value) end

				-- Check pet
				local pet = format("%s%dpet", type, i)
				value = add_threat_data(win, pet, target)
				if value then max_value = math.max(max_value, value) end
			end
		end

		-- Add player and pet if not in raid
		if type ~= "raid" then
			local value = add_threat_data(win, "player", target)
			if value then max_value = math.max(max_value, value) end

			value = add_threat_data(win, "pet", target)
			if value then max_value = math.max(max_value, value) end
		end

		win.metadata.maxvalue = Skada.db.profile.modules.threatraw and max_value or 100

		-- Format display values and check warnings
		for i, data in ipairs(win.dataset) do
			if data.id then
				if data.threat and data.threat > 0 then
					local percent = (data.value / win.metadata.maxvalue) * 100
					d.valuetext	= Skada:FormatValueText(
						data,
						format_threat(data.threat),
						self.metadata.columns.Threat,
						data.tps,
						self.metadata.columns.TPS,
						format("%.1f%%", percent),
						self.metadata.columns.Percent
					)
					check_threat_warning(self, data, win.metadata.maxvalue)
				else
					data.id = nil
				end
			end
		end
	end

	function mod:OnEnable()
		self.metadata = {
			showspots = true,
			wipestale = true,
			columns = {
				Threat = true,
				TPS = true,
				Percent = true
			},
			icon = "Interface\\Icons\\Ability_warrior_challange"
		}

		Skada:AddFeed(L["Threat: Personal Threat"], function()
			if Skada.current and UnitExists("target") then
				local _, _, threatpct = UnitDetailedThreatSituation("player", "target")
				if threatpct then
					return format("%.1f%%", threatpct)
				end
			end
		end)

		Skada:AddMode(self)
	end

	function mod:OnDisable()
		Skada:RemoveMode(self)
	end

	-- Create options table
	local opts = {
		threatoptions = {
			type = "group",
			name = L["Threat"],
			args = {
				warnings = {
					type = "group",
					name = L["Threat warning"],
					inline = true,
					order = 1,
					args = {
						flash = {
							type = "toggle",
							name = L["Flash screen"],
							desc = L["This will cause the screen to flash as a threat warning."],
							get = function() return Skada.db.profile.modules.threatflash end,
							set = function(_, val) Skada.db.profile.modules.threatflash = val end,
							order = 1,
						},
						shake = {
							type = "toggle",
							name = L["Shake screen"],
							desc = L["This will cause the screen to shake as a threat warning."],
							get = function() return Skada.db.profile.modules.threatshake end,
							set = function(_, val) Skada.db.profile.modules.threatshake = val end,
							order = 2,
						},
						playsound = {
							type = "toggle",
							name = L["Play sound"],
							desc = L["This will play a sound as a threat warning."],
							get = function() return Skada.db.profile.modules.threatsound end,
							set = function(_, val) Skada.db.profile.modules.threatsound = val end,
							order = 3,
						},
						sound = {
							type = "select",
							dialogControl = "LSM30_Sound",
							name = L["Threat sound"],
							desc = L
							["The sound that will be played when your threat percentage reaches a certain point."],
							values = AceGUIWidgetLSMlists.sound,
							get = function() return Skada.db.profile.modules.threatsoundname end,
							set = function(_, val) Skada.db.profile.modules.threatsoundname = val end,
							order = 4,
						},
						threshold = {
							type = "range",
							name = L["Threat threshold"],
							desc = L["When your threat reaches this level, relative to tank, warnings are shown."],
							min = 0,
							max = 130,
							step = 1,
							get = function() return Skada.db.profile.modules.threattreshold end,
							set = function(_, val) Skada.db.profile.modules.threattreshold = val end,
							order = 5,
						},
						notankwarnings = {
							type = "toggle",
							name = L["Do not warn while tanking"],
							get = function() return Skada.db.profile.modules.notankwarnings end,
							set = function(_, val) Skada.db.profile.modules.notankwarnings = val end,
							order = 6,
						},
					},
				},
				rawthreat = {
					type = "toggle",
					name = L["Show raw threat"],
					desc = L["Shows raw threat percentage relative to tank instead of modified for range."],
					get = function() return Skada.db.profile.modules.threatraw end,
					set = function(_, val) Skada.db.profile.modules.threatraw = val end,
					order = 2,
				},
				focustarget = {
					type = "toggle",
					name = L["Use focus target"],
					desc = L["Shows threat on focus target, or focus target's target, when available."],
					get = function() return Skada.db.profile.modules.threatfocustarget end,
					set = function(_, val) Skada.db.profile.modules.threatfocustarget = val end,
					order = 3,
				},
			},
		}
	}

	function mod:OnInitialize()
		table.insert(Skada.options.plugins, opts)
	end

	-- Flash frame implementation from Omen
	function mod:Flash()
		if not self.FlashFrame then
			local flasher = CreateFrame("Frame", "SkadaThreatFlashFrame")
			flasher:SetToplevel(true)
			flasher:SetFrameStrata("FULLSCREEN_DIALOG")
			flasher:SetAllPoints(UIParent)
			flasher:EnableMouse(false)
			flasher:Hide()
			flasher.texture = flasher:CreateTexture(nil, "BACKGROUND")
			flasher.texture:SetTexture("Interface\\FullScreenTextures\\LowHealth")
			flasher.texture:SetAllPoints(UIParent)
			flasher.texture:SetBlendMode("ADD")
			flasher:SetScript("OnShow", function(self)
				self.elapsed = 0
				self:SetAlpha(0)
			end)
			flasher:SetScript("OnUpdate", function(self, elapsed)
				elapsed = self.elapsed + elapsed
				if elapsed < 2.6 then
					local alpha = elapsed % 1.3
					if alpha < 0.15 then
						self:SetAlpha(alpha/0.15)
					elseif alpha < 0.9 then
						self:SetAlpha(math.max(0, 1 - ((alpha - 0.15) / 0.6)))
					else
						self:SetAlpha(0)
					end
				else
					self:Hide()
				end
				self.elapsed = elapsed
			end)
			self.FlashFrame = flasher
		end

		self.FlashFrame:Show()
	end

	-- Shake frame implementation from Omen
	function mod:Shake()
		local shaker = self.ShakerFrame
		if not shaker then
			shaker = CreateFrame("Frame", "SkadaThreatShaker", UIParent)
			shaker:Hide()
			shaker:SetScript("OnUpdate", function(self, elapsed)
				elapsed = self.elapsed + elapsed
				local x, y = 0, 0 -- Resets to original position if we're supposed to stop.
				if elapsed >= 0.8 then
					self:Hide()
				else
					x, y = random(-8, 8), random(-8, 8)
				end
				if WorldFrame:IsProtected() and InCombatLockdown() then
					if not shaker.fail then
						shaker.fail = true
					end
					self:Hide()
				else
					WorldFrame:ClearAllPoints()
					for i = 1, #self.originalPoints do
						local v = self.originalPoints[i]
						WorldFrame:SetPoint(v[1], v[2], v[3], v[4] + x, v[5] + y)
					end
				end
				self.elapsed = elapsed
			end)
			shaker:SetScript("OnShow", function(self)
				-- Store old worldframe positions, we need them all, people have frame modifiers for it
				if not self.originalPoints then
					self.originalPoints = {}
					for i = 1, WorldFrame:GetNumPoints() do
						tinsert(self.originalPoints, {WorldFrame:GetPoint(i)})
					end
				end
				self.elapsed = 0
			end)
			self.ShakerFrame = shaker
		end

		shaker:Show()
	end
end)
