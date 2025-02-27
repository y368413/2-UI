local _, Skada = ...
Skada:AddLoadableModule("Dispels", nil, function(Skada, L)
	if Skada.db.profile.modulesBlocked.Dispels then return end

	local mod = Skada:NewModule(L["Dispels"])


	local function log_dispel(set, dispel)

		local player = Skada:get_player(set, dispel.playerid, dispel.playername)

		if player then

			player.dispels = player.dispels + 1
			set.dispels    = set.dispels    + 1
		end
	end




	local function log_interrupt(set, interrupt)

		local player = Skada:get_player(set, interrupt.playerid, interrupt.playername)

		if player then

			player.interrupts = player.interrupts + 1
			set.interrupts    = set.interrupts    + 1
		end
	end


	local dispel = {}


	local function SpellDispel(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)

		local spellId, spellName, spellSchool, sextraSpellId, sextraSpellName, sextraSchool, auraType = ...

		dispel.playerid       = srcGUID
		dispel.playername     = srcName
		dispel.spellid        = spellId
		dispel.spellname      = spellName
		dispel.extraspellid   = sextraSpellId
		dispel.extraspellname = sextraSpellName

		log_dispel(Skada.current, dispel)
		log_dispel(Skada.total  , dispel)
	end
 



	local function SpellInterrupt(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)

		local spellId, spellName, spellSchool, sextraSpellId, sextraSpellName, sextraSchool = ...

		dispel.playerid       = srcGUID
		dispel.playername     = srcName
		dispel.spellid        = spellId
		dispel.spellname      = spellName
		dispel.extraspellid   = sextraSpellId
		dispel.extraspellname = sextraSpellName

		Skada:FixPets(dispel)

		log_interrupt(Skada.current, dispel)
		log_interrupt(Skada.total  , dispel)
	end




	function mod:Update(win, set)

		local max = 0
		local nr  = 1

		for i, player in ipairs(set.players) do

			if player.dispels > 0 then

				local d         = win.dataset[nr] or {}
				win.dataset[nr] = d

				d.value		= player.dispels
				d.label		= player.name
				d.class		= player.class

				d.role		= player.role
				d.id		= player.id
				d.valuetext	= tostring(player.dispels)

				if player.dispels > max then max = player.dispels end

				nr = nr + 1
			end
		end

		win.metadata.maxvalue = max
	end




	function mod:OnEnable()

		mod.metadata = {showspots = true, icon = "Interface\\Icons\\Ability_priest_focusedwill"}

		Skada:RegisterForCL(SpellDispel   , 'SPELL_STOLEN'   , {src_is_interesting = true})
		Skada:RegisterForCL(SpellDispel   , 'SPELL_DISPEL'   , {src_is_interesting = true})
		Skada:RegisterForCL(SpellInterrupt, 'SPELL_INTERRUPT', {src_is_interesting = true})

		Skada:AddMode(self)
	end




	function mod:OnDisable()

		Skada:RemoveMode(self)
	end




	function mod:AddToTooltip(set, tooltip)

		GameTooltip:AddDoubleLine(L["Dispels"], set.dispels, 1, 1, 1)
	end




	function mod:AddPlayerAttributes(player)

		if not player.dispels    then player.dispels    = 0 end
		if not player.interrupts then player.interrupts = 0 end
	end




	function mod:AddSetAttributes(set)

		if not set.dispels    then set.dispels    = 0 end
		if not set.interrupts then set.interrupts = 0 end
	end




	function mod:GetSetSummary(set)

		return set.dispels
	end


end)
