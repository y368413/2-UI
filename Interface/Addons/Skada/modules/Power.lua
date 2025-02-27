local _, Skada = ...
Skada:AddLoadableModule("Power", nil, function(Skada, L)
	if Skada.db.profile.modulesBlocked.Power then return end

	local mod = Skada:NewModule("power gains")


	-- | PowerTypes				    Description
	local MANA		=  0		-- | Mage, Priest(Heals), Monk(Heal), Shaman(Heal)
	local RAGE		=  1		-- | Druid(Tank), Warrior
	local FOCUS		=  2		-- | Hunter
	local ENERGY		=  3		-- | Druid(MDD), Monk(Tank), Rouge
	local COMBO		=  4		-- | Druid(MDD), Rouge
	local RUNIC		=  6		-- | Deathknight
	local SHARDS		=  7		-- | Warlock
	local LUNAR		=  8		-- | Druid(Tank, RDD)
	local HOLY		=  9		-- | Paldin
	local MAELSTROM		= 11		-- | Shaman(RDD)
	local CHI		= 12		-- | Monk(DD)
	local INSANE		= 13		-- | Priest(DD)
	local CHARGES		= 16		-- | Mage(Arcane)
	local PAIN		= 17		-- | Daemonhunter

	local function log_gain(set, gain)
		-- Get the player from set.
		local player = Skada:get_player(set, gain.playerid, gain.playername)
		if player then
			-- Make sure power type exists.
			if not player.power[gain.type] then
				player.power[gain.type] = {spells = {}, amount = 0}
			end

			-- Make sure set power type exists.
			if not set.power[gain.type] then
				set.power[gain.type] = 0
			end

			-- Add to player total.
			player.power[gain.type].amount = player.power[gain.type].amount + gain.amount

			-- Also add to set total gain.
			set.power[gain.type] = set.power[gain.type] + gain.amount

			-- Create spell if it does not exist.
			if not player.power[gain.type].spells[gain.spellid] then
				player.power[gain.type].spells[gain.spellid] = 0
			end

			player.power[gain.type].spells[gain.spellid] = player.power[gain.type].spells[gain.spellid] + gain.amount
		end
	end

	local gain = {}

	local function SpellEnergize(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		-- Healing
		local spellId, spellName, spellSchool, samount, overEnergize, powerType = ...

		gain.playerid = srcGUID
		gain.playername = srcName
		gain.spellid = spellId
		gain.spellname = spellName
		gain.amount = samount
		gain.overenergize = overEnergize
		gain.type = tonumber(powerType)

		Skada:FixPets(gain)
		log_gain(Skada.current, gain)
		log_gain(Skada.total, gain)
	end

	-- Prototypes for the modes
	local basemod = {}
	local basemod_mt = { __index = basemod }

	local playermod = {}
	local playermod_mt = { __index = playermod }

	function basemod:Create(power, modename, playermodename, modeicon)
		local pmode = {
			metadata = {},
			name = playermodename
		}
		setmetatable(pmode, playermod_mt)

		local instance = {
			playermod = pmode,
			metadata = {
				showspots = true,
				click1 = pmode,
				icon = modeicon
			},
			name = modename
		}
		instance.power = power
		pmode.power = power

		setmetatable(instance, basemod_mt)
		return instance
	end

	function basemod:GetName()
		return self.name
	end

	function basemod:Update(win, set)
		local nr = 1
		local max = 0

		for i, player in ipairs(set.players) do
			if player.power[self.power] then

				local d = win.dataset[nr] or {}
				win.dataset[nr] = d

				d.id = player.id
				d.label = player.name
				d.value = player.power[self.power].amount
				if self.power == MANA then
					d.valuetext = Skada:FormatNumber(player.power[self.power].amount)
				else
					d.valuetext = player.power[self.power].amount
				end
				d.class = player.class
				d.role = player.role

				if player.power[self.power].amount > max then
					max = player.power[self.power].amount
				end

				nr = nr + 1
			end
		end

		win.metadata.maxvalue = max
	end

	function basemod:AddToTooltip(set, tooltip)
	end

	function basemod:GetSetSummary(set)
		return Skada:FormatNumber(set.power[self.power] or 0)
	end

	function playermod:GetName()
		return self.name
	end

	function playermod:Enter(win, id, label)
		self.playerid = id
		self.title = label
	end

	-- Detail view of a player.
	function playermod:Update(win, set)
		-- View spells for this player.

		-- View spells for this player.

		local player = Skada:find_player(set, self.playerid)
		local nr = 1
		local max = 0

		if player then

			for spellid, amount in pairs(player.power[self.power].spells) do

				-- =====================================
				-- | API   : C_Spell.GetSpellInfo      |
				-- | valid : + 11.0.0 / 4.4.1 / 1.15.4 |
				-- =====================================
				local spellInfo  = C_Spell.GetSpellInfo(spellid)

				-- | Returns nil if spell is not found
				if spellInfo then

					local name       = spellInfo.name
					local icon       = spellInfo.iconID

					-- =====================================
					-- | API   : C_Spell.GetSpellPowerCost |
					-- | valid : + 11.0.0 / 4.4.1 / 1.15.4 |
					-- =====================================
					local spellPower = C_Spell.GetSpellPowerCost(spellid)

					-- | May return nil if spell is not found or has no resource costs
					if spellPower then

						local powerType  = spellPower.type
	
						local d          = win.dataset[nr] or {}
						win.dataset[nr]  = d

						d.id		 = spellid
						d.label		 = name
						d.value		 = amount


						if self.power == MANA then

							d.valuetext = Skada:FormatNumber(amount) .. (" (%02.1f%%)"):format(amount / player.power[self.power].amount * 100)
						else

							d.valuetext = amount .. (" (%02.1f%%)"):format(amount / player.power[self.power].amount * 100)
						end


						d.icon    = icon
						d.spellid = spellid


						if amount > max then max = amount end


						nr = nr + 1
					end
				end

			end
		end

		win.metadata.hasicon  = true
		win.metadata.maxvalue = max
	end


	--  | local variables PowerTypes
	local chargesmod = basemod:Create(CHARGES,   L["Charges gained"],     L["Charges gain sources"],     "Interface\\Icons\\Spell_arcane_arcane01")
	local chimod     = basemod:Create(CHI,       L["Chi gained"],         L["Chi gain sources"],         "Interface\\Icons\\Ability_hunter_markedfordeath")
	local combomod   = basemod:Create(COMBO,     L["Combo gained"],       L["Combo gain sources"],       "Interface\\Icons\\Ability_rogue_rupture")
	local energymod  = basemod:Create(ENERGY,    L["Energy gained"],      L["Energy gain sources"],      "Interface\\Icons\\Ability_rogue_sprint")
	local focusmod   = basemod:Create(FOCUS,     L["Focus gained"],       L["Focus gain sources"],       "Interface\\Icons\\Ability_hunter_focusedaim")
	local holymod    = basemod:Create(HOLY,      L["Holy power gained"],  L["Holy power gain sources"],  "Interface\\Icons\\Ability_paladin_beaconoflight")
	local insanemod  = basemod:Create(INSANE,    L["Insane gained"],      L["Insane gain sources"],      "Interface\\Icons\\Ability_priest_darkarchangel")
	local lunarmod   = basemod:Create(LUNAR,     L["Lunar gained"],       L["Lunar gain sources"],       "Interface\\Icons\\Spell_nature_starfall")
	local maelmod    = basemod:Create(MAELSTROM, L["Maelstrom gained"],   L["Maelstrom gain sources"],   "Interface\\Icons\\Inv_misc_ancient_mana")
	local manamod    = basemod:Create(MANA,      L["Mana gained"],        L["Mana gain spell list"],     "Interface\\Icons\\Inv_misc_ancient_mana")
	local painmod    = basemod:Create(PAIN,      L["Pain gained"],        L["Pain gain sources"],        "Interface\\Icons\\Ability_demonhunter_felblade")
	local ragemod    = basemod:Create(RAGE,      L["Rage gained"],        L["Rage gain sources"],        "Interface\\Icons\\Ability_warrior_rampage")
	local runicmod   = basemod:Create(RUNIC,     L["Runic power gained"], L["Runic power gain sources"], "Interface\\Icons\\Ability_deathknight_runicimpowerment")
	local shardsmod  = basemod:Create(SHARDS,    L["Shards gained"],      L["Shards gain sources"],      "Interface\\Icons\\inv_misc_gem_amethyst_02")

	function mod:OnEnable()
		Skada:RegisterForCL(SpellEnergize, 'SPELL_ENERGIZE', {src_is_interesting = true})
		Skada:RegisterForCL(SpellEnergize, 'SPELL_PERIODIC_ENERGIZE', {src_is_interesting = true})

		Skada:AddMode(chargesmod, L["Power gains"])
		Skada:AddMode(chimod,     L["Power gains"])
		Skada:AddMode(combomod,   L["Power gains"])
		Skada:AddMode(energymod,  L["Power gains"])
		Skada:AddMode(focusmod,   L["Power gains"])
		Skada:AddMode(holymod,    L["Power gains"])
		Skada:AddMode(insanemod,  L["Power gains"])
		Skada:AddMode(lunarmod,   L["Power gains"])
		Skada:AddMode(maelmod,    L["Power gains"])
		Skada:AddMode(manamod,    L["Power gains"])
		Skada:AddMode(painmod,    L["Power gains"])
		Skada:AddMode(ragemod,    L["Power gains"])
		Skada:AddMode(runicmod,   L["Power gains"])
		Skada:AddMode(shardsmod,  L["Power gains"])
	end

	function mod:OnDisable()

		Skada:RemoveMode(chargesmod)
		Skada:RemoveMode(chimod)
		Skada:RemoveMode(combomod)
		Skada:RemoveMode(energymod)
		Skada:RemoveMode(focusmod)
		Skada:RemoveMode(holymod)
		Skada:RemoveMode(insanemod)
		Skada:RemoveMode(lunarmod)
		Skada:RemoveMode(maelmod)
		Skada:RemoveMode(manamod)
		Skada:RemoveMode(painmod)
		Skada:RemoveMode(ragemod)
		Skada:RemoveMode(runicmod)
		Skada:RemoveMode(shardsmod)
	end

	-- Called by Skada when a new player is added to a set.
	function manamod:AddPlayerAttributes(player)
		if not player.power then
			player.power = {}
		end
	end

	-- Called by Skada when a new set is created.
	function manamod:AddSetAttributes(set)
		if not set.power then
			set.power = {}
		end
	end
end)
