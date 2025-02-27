local _, Skada = ...
Skada:AddLoadableModule("CC", nil, function(Skada, L)
	if Skada.db.profile.modulesBlocked.CC then return end

	local mod = Skada:NewModule(L["CC breakers"])

	-- CC spell IDs shamelessly stolen from Recount - thanks!
	local CCId = {

			-- | Deamon Hunter
			[217832] = true,	-- | Imprison			max  1 min

			-- | Death Knight
			[111673] = true,	-- | Control Undead		max  5 min

			-- | Druid
			[339]    = true,	-- | Entangling Roots		max 30 sec	
			[2637]   = true,	-- | Hibernate			max 40 sec

			-- | Evoker
			[360806]   = true,	-- | Sleep Walk			max 20 sec	! Disorientation

			-- | Hunter
			[187650] = true,	-- | Freezing Trap		max  1 min
			[268501] = true,	-- | Wyvern Sting		max 30 sec				Survival

			-- | Mage
			[61305]  = true,	-- | Polymorph Black Cat	max  1 min
			[28272]  = true,	-- | Polymorph Pig
			[61721]  = true,	-- | Polymorph Rabbit
			[118]    = true,	-- | Polymorph Sheep
			[61780]  = true,	-- | Polymorph Turkey
			[28271]  = true,	-- | Polymorph Turtle

			-- | Monk
			[115078] = true,	-- | Paralyse			max  1 min

			-- | Paladin
			[20066] = true,		-- | Repentance			max  1 min

			-- | Priest
			[9484]	 = true,	-- | Shackle Undead		max 50 sec

			-- | Rogue
			[2094]	 = true,	-- | Blind			max 18 sec	! Disorientation
			[6770]   = true,	-- | Sap			max  1 min

			-- | Shaman
			[51514]  = true,	-- | Hex			max  1 min

			-- | Warlock
			[710]	 = true,	-- | Banisch			max 30 sec
			[5782]	 = true,	-- | Fear			max 20 sec	! Disorientation
			[5484]	 = true,	-- | Howl of Terror		max 20 sec	! Disorientation
			[119909] = true,	-- | Seduction			max 30 sec	! Disorientation	Sayaad

			-- | Warrior 
			[275338] = true,	-- | Menace			max 15 sec

	             }

	local function log_ccbreak(set, srcGUID, srcName)
		-- Fetch the player.
		local player = Skada:get_player(set, srcGUID, srcName)
		if player then
			-- Add to player count.
			player.ccbreaks = player.ccbreaks + 1

			-- Add to set count.
			set.ccbreaks = set.ccbreaks + 1
		end
	end

	local function SpellAuraBroken(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		local spellId, spellName, extraSpellId, extraSpellName

		if eventtype == "SPELL_AURA_BROKEN" then
			spellId, spellName = ...
		else
			spellId, spellName, _, extraSpellId, extraSpellName = ...
		end

		if CCId[spellId] then

			-- Fix up pets.
			local petid = srcGUID
			local petname = srcName
			srcGUID, srcName = Skada:FixMyPets(srcGUID, srcName)

			-- Log CC break.
			log_ccbreak(Skada.current, srcGUID, srcName)
			log_ccbreak(Skada.total, srcGUID, srcName)

			-- Optional announce
			local inInstance, instanceType = IsInInstance()
			if Skada.db.profile.modules.ccannounce and IsInRaid() and UnitInRaid(srcName) and not (instanceType == "pvp") then

				-- Ignore main tanks?
				if Skada.db.profile.modules.ccignoremaintanks then

					-- Loop through our raid and return if src is a main tank.
					for i = 1, 40 do
						local name, _, _, _, _, class, _, _, _, role, _ = GetRaidRosterInfo(i)
						if name == srcName and role == "maintank" then
							return
						end
					end

				end

				-- Prettify pets.
				if petid ~= srcGUID then
					srcName = petname.." ("..srcName..")"
				end

				-- Go ahead and announce it.
				if extraSpellName then
					local spellLink = C_Spell.GetSpellLink(extraSpellId) or ""
					SendChatMessage(string.format(L["%s on %s removed by %s's %s"], spellName, dstName, srcName, spellLink), "RAID")
				else
					SendChatMessage(string.format(L["%s on %s removed by %s"], spellName, dstName, srcName), "RAID")
				end

			end

		end
	end

	function mod:OnEnable()
		mod.metadata = {showspots = true, icon = "Interface\\Icons\\Spell_magic_polymorphrabbit"}

		Skada:RegisterForCL(SpellAuraBroken, 'SPELL_AURA_BROKEN', {src_is_interesting = true})
		Skada:RegisterForCL(SpellAuraBroken, 'SPELL_AURA_BROKEN_SPELL', {src_is_interesting = true})

		Skada:AddMode(self)
	end

	function mod:OnDisable()
		Skada:RemoveMode(self)
	end

	function mod:AddToTooltip(set, tooltip)
		GameTooltip:AddDoubleLine(L["CC breaks"], set.ccbreaks, 1, 1, 1)
	end

	function mod:GetSetSummary(set)
		return set.ccbreaks
	end

	-- Called by Skada when a new player is added to a set.
	function mod:AddPlayerAttributes(player)
		if not player.ccbreaks then
			player.ccbreaks = 0
		end
	end

	-- Called by Skada when a new set is created.
	function mod:AddSetAttributes(set)
		if not set.ccbreaks then
			set.ccbreaks = 0
		end
	end

	function mod:Update(win, set)
		local max = 0
		local nr = 1
		for i, player in ipairs(set.players) do
			if player.ccbreaks > 0 then

				local d = win.dataset[nr] or {}
				win.dataset[nr] = d

				d.value = player.ccbreaks
				d.label = player.name
				d.valuetext = tostring(player.ccbreaks)
				d.id = player.id
				d.class = player.class
				d.role = player.role
				if player.ccbreaks > max then
					max = player.ccbreaks
				end

				nr = nr + 1
			end
		end

		win.metadata.maxvalue = max
	end

	local opts = {
		ccoptions = {
			type = "group",
			name = L["CC"],
			args = {

				announce = {
					type = "toggle",
					name = L["Announce CC breaking to party"],
					get = function() return Skada.db.profile.modules.ccannounce end,
					set = function() Skada.db.profile.modules.ccannounce = not Skada.db.profile.modules.ccannounce end,
					order = 1,
				},

				ignoremaintanks = {
					type = "toggle",
					name = L["Ignore Main Tanks"],
					get = function() return Skada.db.profile.modules.ccignoremaintanks end,
					set = function() Skada.db.profile.modules.ccignoremaintanks = not Skada.db.profile.modules.ccignoremaintanks end,
					order = 2,
				},

			},
		}
	}

	function mod:OnInitialize()
		-- Add our options.
		table.insert(Skada.options.plugins, opts)
	end
end)
