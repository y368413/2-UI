--## Author: Mekanot  ## Version: 1.0
Skada:AddLoadableModule("AvoidableDamageTaken", nil, function(Skada, L)
	if Skada.db.profile.modulesBlocked.AvoidableDamageTaken then return end

	local INFO_LENGTH_MAX = 60;

	-- {
	--  {
	--   <encounterId>,
	--   {
	--    {
	--     spellId1, blnIgnoreOnTank, blnIgnoreOnHealer, blnIgnoreOnDps, info
	--    },
	--    {
	--     spellId2, blnIgnoreOnTank, blnIgnoreOnHealer, blnIgnoreOnDps, info
	--    }
	--   }
	--  }
	-- }
	BOSS_ENCOUNTER = {
		-- ************************************************
		-- * Ny'alotha ************************************
		-- ************************************************
		{
			2329, -- Wrathion, the Black Emperor
			{
				305978, -- Searing Breath http://www.wowhead.com/spell=305978
				true, false, false,
				"It should hit tanks only."
			},
			{
				306794, -- Molten Eruption http://www.wowhead.com/spell=306794
				false, false, false,
				"After all the Scorching Blister zones have detonated, the boss will immediately cast Molten Eruption which causes lava to erupt from the ground and hit anyone within 3 yards. Just move away to avoid taking damage."
			},
			{
				307974, -- Tail Swipe http://www.wowhead.com/spell=307974
				false, false, false,
				"Don't stand on Wrathion's tail, since he will cast Claque-queue, hitting everyone standing by the tail and knocking them back."
			},
			{
				313959, -- Scorching Blister https://www.wowhead.com/spell=313959
				false, false, false,
				"Unsoaked blisters explode and deal damage to anyone within 20 yards. Either move far away from unsoaked blisters or soak them."
			},
			{
				307053, -- Lava Pools https://www.wowhead.com/spell=307053
				false, false, false,
				"Lava Pools are pools of lava on the ground formed from unbroken shards. Stay out of the pools to avoid damage."
			},
			{
				314373, -- Dark Ambush https://www.wowhead.com/spell=314373
				false, false, false,
				"Assassins strike from the shadows with Sombre embuscade. Expose them so they cannot use this ability."
			}
		},
		{
			2327, -- Maut
			{
				307545, -- Shadow Claws https://www.wowhead.com/spell=307545
				true, false, false,
				"It should hit tanks only."
			},
			{
				307399, -- Shadow Wounds https://www.wowhead.com/spell=307399
				true, false, false,
				"It should hit tanks only."
			},
			{
				305663, -- Black Wings https://www.wowhead.com/spell=305663
				false, false, false,
				"Maut does a 40 yard conal attack called Black Wings. Move out of the way to avoid being hit."
			},
			{
				307773, -- Stygian Annihilation https://www.wowhead.com/spell=307773
				false, false, false,
				"Maut does an enormous raidwide shadow damage hit called Stygian Annihilation. Stand in the Devoured Abyss pools to avoid taking damage from it."
			}
		},
		{
			2334, -- Prophet Skitra
			{
				307977, -- Shadow Shock https://www.wowhead.com/spell=307977
				true, false, false,
				"It should hit tanks only."
			},
			{
				307864, -- Mindquake https://www.wowhead.com/spell=307864
				false, false, false,
				"Killing the wrong illusion of Skitra by mistake results in Mindquake, heavy raidwide damage."
			},
			{
				313215, -- Surging Images https://www.wowhead.com/spell=313215
				false, false, false,
				"Illusions of the Prophet spawn and move across the arena. Being too close to one will result in being hit by Surging Images. These images can be rooted and controlled. After 30 seconds, the Intangible Illusion buff will fall off, and then they can be killed."
			}
		},
		{
			2328, -- Dark Inquisitor Xanesh
			{
				311551, -- Abyssal Strike https://www.wowhead.com/spell=311551
				true, false, false,
				"It should hit tanks only."
			},
			{
				311369, -- Torment https://www.wowhead.com/spell=311369
				false, false, false,
				"Queen Azshara spews Tourment bolts that need to be dodged."
			},
			{
				311383, -- Torment https://www.wowhead.com/spell=311383
				false, false, false,
				"Queen Azshara spews Tourment bolts that need to be dodged."
			},
			{
				313258, -- Void Ritual https://www.wowhead.com/spell=313258
				false, false, false,
				"Three people must participate in the Void Ritual to become Voidwoken. Otherwise the entire raid will take massive raidwide damage, which is shown here."
			},
			{
				309654, -- Revile https://www.wowhead.com/spell=309654
				false, false, false,
				"If an orb hits a non-Voidwoken player, this will result in everyone taking Revile damage. Make sure only Voidwoken players are doing the orb handling."
			},
			{
				306876, -- Dark Collapse https://www.wowhead.com/spell=306876
				false, false, false,
				"If an orb hits an obelisk, a Dark Collapse is triggered. This collapse damage will be massively buffed by each additional collapse that happens and also causes the boss to attack more quickly for 30 seconds following the collapse."
			},
			{
				305575, -- Ritual Field https://www.wowhead.com/spell=305575
				false, false, false,
				"If a player gets too close to an obelisk, they take damage from the field around it."
			},
			{
				312110, -- Void Prison https://www.wowhead.com/spell=312110
				false, false, false,
				"If a player gets too close to Azshara's prison, it will trigger Void Prison damage."
			}
		},
		{
			2333, -- The Hivemind
			{
				313652, -- Mind-Numbing Nova https://www.wowhead.com/spell=313652
				false, false, false,
				"Set up an interrupt rotation for Ka'zir's Mind-Numbing Nova Icon Mind-Numbing Nova."
			},
			{
				310385, -- Acid Spray https://www.wowhead.com/spell=310385
				false, false, false,
				"Acidic Aqir are adds that spray acid that needs to be avoided."
			},
			{
				313672, -- Acid Pool https://www.wowhead.com/spell=313672
				false, false, false,
				"Acid Aqir leave behind pools of acid where they die. Standing in the pools deals ticking damage."
			},
			{
				307968, -- Nullification Blast https://www.wowhead.com/spell=307968
				false, false, false,
				"Tek'ris does a conal Nullification Blast that needs to be dodged. Anyone hit is afflicted by Nullification, which absorbs healing for 6 seconds."
			}
		},
		{
			2335, -- Shad'har the Insatiable
			{
				307471, -- Crush https://www.wowhead.com/spell=307471
				true, false, false,
				"It should hit tanks only."
			},
			{
				307472, -- Dissolve https://www.wowhead.com/spell=307472
				true, false, false,
				"It should hit tanks only."
			},
			{
				306930, -- Entropic Breath https://www.wowhead.com/spell=306930
				false, false, false,
				"The breath from the boss in P2. It is a conal attack that can be avoided, so move out of the way."
			},
			{
				307945, -- Umbral Eruption https://www.wowhead.com/spell=307945
				false, false, false,
				"The Volatile Slurry erupts, and the eruption will hit everyone within 4 yards. Players can move to avoid these eruptions."
			},
			{
				309704, -- Caustic Coating https://www.wowhead.com/spell=309704
				false, false, false,
				"Any player who stands in this water will take high ticking damage every second via Caustic Coating"
			}
		},
		{
			2343, -- Drest'agath
			{
				310277, -- https://www.wowhead.com/spell=310277
				true, false, false,
				"It should hit tanks only."
			},
			{
				308995, -- Reality Tear https://www.wowhead.com/spell=308995
				false, false, false,
				"Tentacle of Drest'Agath cast Reality Tear spawning a moving zone that deals large damage to players caught"
			},
			{
				310406, -- Void Glare https://www.wowhead.com/spell=310406
				false, false, false,
				"Beam targeted at a random player that deals massive damage. Cast by both the boss and any eye of Drest'Agath adds."
			},
			{
				310090, -- Spine Eruption https://www.wowhead.com/spell=310090
				false, false, false,
				"Upon reaching 100 Agony, Drest'agath begins Throes of Agony. Maw of Drest'agath writhes in agony, releasing random sized rings of spines that inflict massive physical damage."
			},
			{
				310082, -- Spine Eruption https://www.wowhead.com/spell=310082
				false, false, false,
				"Upon reaching 100 Agony, Drest'agath begins Throes of Agony. Maw of Drest'agath writhes in agony, releasing random sized rings of spines that inflict massive physical damage."
			},
			{
				310083, -- Spine Eruption https://www.wowhead.com/spell=310083
				false, false, false,
				"Upon reaching 100 Agony, Drest'agath begins Throes of Agony. Maw of Drest'agath writhes in agony, releasing random sized rings of spines that inflict massive physical damage."
			},
			{
				308956, -- Falling Gore https://www.wowhead.com/spell=308956
				false, false, false,
				"Upon reaching 100 Agony, Drest'agath begins Throes of Agony. Eye of Drest'agath cast Errant Blast spawning zones around the room that deal large shadow damage to anyone within them."
			}
		},
		{
			2345, -- Il'gynoth, Corruption Reborn
			{
				309961, -- Eye of N'Zoth https://www.wowhead.com/spell=309961
				true, false, false,
				"A beam directed at the tank deadling a burst of shadow damage and applies a debuff that increases this damage by 75% per stacks."
			},
			{
				310322, -- Morass of Corruption https://www.wowhead.com/spell=310322
				false, false, false,
				"The boss cast Corruptor's gaze that spawn zones that last permanently and inflicts shadow damage and silences."
			},
			{
				312486, -- Recurring Nightmare https://www.wowhead.com/spell=312486
				false, false, false,
				"Blood of Ny'alotha's melee attacks leave behind lingering corruption in the target, inflicting Shadow damage every 2 sec for 40 sec."
			}
		},
		{
			2336, -- Vexiona
			{
				307297, -- Twilight Breath https://www.wowhead.com/spell=307297
				true, false, false;
				"Face Twilight Breath away from other players."
			},
			{
				307359, -- Despair https://www.wowhead.com/spell=307359
				true, false, false,
				"It should hit tanks only."
			},
			{
				307421, -- Annihilation https://www.wowhead.com/spell=307421
				true, false, false,
				"Tanks must face Void Ascendant's Annihilation beam away from other players."
			},
			{
				309774, -- Annihilation https://www.wowhead.com/spell=309774
				false, false, false,
				"Player should cast Annihilation beam away from other players."
			},
			{
				307218, -- Twilight Decimator https://www.wowhead.com/spell=307218
				false, false, false,
				"Keep an eye on the boss and dodge her Twilight Decimator breath as she swoops across one lane of the room."
			},
			{
				307250, -- Twilight Decimator https://www.wowhead.com/spell=307250
				false, false, false,
				"Keep an eye on the boss and dodge her Twilight Decimator breath as she swoops across one lane of the room."
			},
			{
				307177, -- Void Bolt https://www.wowhead.com/spell=307177
				false, false, false,
				"Spellbound Ritualist's Void Bolt should be interrupted"
			},
			{
				315932, -- Brutal Smash https://www.wowhead.com/spell=315932
				false, false, false,
				"Iron-Willed Enforcers cast  Brutal Smash, which is a small aoe ability that deals large amounts of physical damage, and stuns anyone hit."
			}
		},
		{
			2331, -- Ra-den the Despoiled
			{
				313213, -- Decaying Strike https://www.wowhead.com/spell=313213
				true, false, false,
				"It should hit tanks only."
			},
			{
				306819, -- Nullifying Strike https://www.wowhead.com/spell=306819
				true, false, false,
				"It should hit tanks only."
			},
			{
				312975, -- Extinguished Soul https://www.wowhead.com/spell=312975
				false, false, false,
				"Anyone healed to full while under the effects of Unleashed Nightmare is killed instantly by Extinguished Soul."
			},
			{
				306637, -- Unstable Void Burst https://www.wowhead.com/spell=306637
				false, false, false,
				"Unstable Void Burst occurs if an Unstable Void missile is not properly soaked. Five missiles need to be soaked per Unstable Void."
			},
			{
				310005, -- Void Eruption https://www.wowhead.com/spell=310005
				false, false, false,
				"Void Eruption occurs in P2. The eruptions hit anyone within 12 yards of them, so give them a wide berth."
			}
		},
		{
			2337, -- Carapace of N'Zoth
			{
				315947, -- Mandible Slam https://www.wowhead.com/spell=315947
				true, false, false,
				"It should hit tanks only."
			},
			{
				315954, -- Black Scar https://www.wowhead.com/spell=315954
				true, false, false,
				"It should hit tanks only."
			},
			{
				307131, -- Growth-Covered Tentacle https://www.wowhead.com/spell=307131
				false, false, false,
				"Avoid the Growth-Covered Tentacle shadowy slam location and then kill the Horrific Hemorrhages!"
			},
			{
				317165, -- Regenerative Expulsion https://www.wowhead.com/spell=317165
				false, false, false,
				"The cyst casts Regenerative Explosion, dealing high damage to all players within 15 yards whilst healing itself back to full."
			},
			{
				307044, -- Nightmare Antibody https://www.wowhead.com/spell=307044
				true, false, false,
				"Successful melee attacks sap the target's potency, inflicting Shadow damage, decreasing haste and reducing their movement speed. This effect stacks."
			},
			{
				315878, -- Occipital Blast https://www.wowhead.com/spell=315878
				false, false, false,
				"Beam that drains sanity and deals massive damage."
			},
			{
				317627, -- Infinite Void Infinite Darkness https://www.wowhead.com/spell=317627
				false, false, false,
				"When boos cast Infinite Darkness it spawns growing shadow zone that deals shadow damage to enemies within it. This effect stacks."
			}
		},
		{
			2344, -- N'Zoth, the Corruptor
			{
				316711, -- Mindwrack https://www.wowhead.com/spell=316711
				true, false, false,
				"It should hit tanks only."
			},
			{
				309713, -- Void Lash https://www.wowhead.com/spell=309713
				true, false, false,
				"It should hit tanks only."
			},
			{
				309702, -- Void Lash https://www.wowhead.com/spell=309702
				true, false, false,
				"It should hit tanks only."
			},
			{
				309991, -- Anguish https://www.wowhead.com/spell=309991
				false, false, false,
				"Dark zones that deals large damage, slows and drains sanity to players who stand within it."
			},
			{
				313400, -- Corrupted Mind https://www.wowhead.com/spell=313400
				false, false, false,
				"Interrupt Tentacles casting the Corrupted Minds. Dispel any Corrupted Mind debuffs that accidentally go through."
			},
			{
				318688, -- Corrupted Viscera https://www.wowhead.com/spell=318688
				false, false, false,
				"Red zone that deals shadow damage and drains sanity to players hit by the debris from a tentacle death."
			},
			{
				313793, -- Flames of Insanity https://www.wowhead.com/spell=313793
				false, false, false,
				"During the first Mind Realm in phase two, dodge the red swirly Flames of Insanity circles."
			},
			{
				315715, -- Contempt https://www.wowhead.com/spell=315715
				false, false, false,
				"During the second Mind Realm in phase two, avoid excessive movement when afflicted with Tread Lightly."
			},
			{
				318976, -- Stupefying Glare https://www.wowhead.com/spell=318976
				false, false, false,
				"In phase 3 Eyes cast cast a beam that shoud be avoided."
			},
			{
				313610, -- https://www.wowhead.com/spell=313610
				false, false, false,
				"Players who become Servants of N'zoth should be interrupted and killed as soon as possible."
			}
		}
		-- ************************************************
		-- ************************************************
		-- ************************************************
	};

	local currentEncounter = nil;

	local avoidableFrame = CreateFrame("FRAME", "avoidableFrame");
	avoidableFrame:RegisterEvent("ENCOUNTER_START");
	avoidableFrame:RegisterEvent("ENCOUNTER_END");
	local function eventHandler(self, event, ...)
		local encounterID, encounterName, difficultyID, raidSize = ...
		local szDifficulty = "unknown difficulty " .. difficultyID;
		if 0 == difficultyID then szDifficulty = "not in an Instance";
		elseif 1 == difficultyID then szDifficulty = "party (Normal)";
		elseif 2 == difficultyID then szDifficulty = "party	(Heroic)";
		elseif 3 == difficultyID then szDifficulty = "raid (10 Player)";
		elseif 4 == difficultyID then szDifficulty = "raid (25 Player)";
		elseif 5 == difficultyID then szDifficulty = "raid (10 Player (Heroic))";
		elseif 6 == difficultyID then szDifficulty = "raid (25 Player (Heroic))";
		elseif 7 == difficultyID then szDifficulty = "raid (Legacy LFRs)";
		elseif 8 == difficultyID then szDifficulty = "party (Mythic Keystone)";
		elseif 9 == difficultyID then szDifficulty = "raid (40 Player)";
		elseif 11 == difficultyID then szDifficulty = "Heroic Scenario";
		elseif 12 == difficultyID then szDifficulty = "Normal Scenario";
		elseif 14 == difficultyID then szDifficulty = "raid (Normal)";
		elseif 15 == difficultyID then szDifficulty = "raid (Heroic)";
		elseif 16 == difficultyID then szDifficulty = "raid (Mythic)";
		elseif 17 == difficultyID then szDifficulty = "raid (Looking For Raid";
		elseif 18 == difficultyID then szDifficulty = "raid (Event)";
		elseif 19 == difficultyID then szDifficulty = "party (Event)";
		elseif 20 == difficultyID then szDifficulty = "Event Scenario";
		elseif 23 == difficultyID then szDifficulty = "party (Mythic)";
		elseif 24 == difficultyID then szDifficulty = "party (Timewalking)";
		elseif 25 == difficultyID then szDifficulty = "World PvP Scenario";
		elseif 29 == difficultyID then szDifficulty = "PvEvP Scenario";
		elseif 30 == difficultyID then szDifficulty = "scenario (Event)";
		elseif 32 == difficultyID then szDifficulty = "World PvP Scenario";
		elseif 33 == difficultyID then szDifficulty = "raid (Timewalking)";
		elseif 34 == difficultyID then szDifficulty = "PvP";
		elseif 38 == difficultyID then szDifficulty = "scenario (Normal)";
		elseif 39 == difficultyID then szDifficulty = "scenario (Heroic)";
		elseif 40 == difficultyID then szDifficulty = "scenario (Mythic)";
		elseif 45 == difficultyID then szDifficulty = "scenario (PvP)";
		elseif 147 == difficultyID then szDifficulty = "scenario (Normal)";
		elseif 149 == difficultyID then szDifficulty = "scenario (Heroic)";
		elseif 151 == difficultyID then szDifficulty = "raid (Looking For Raid (Timewalking))";
		elseif 152 == difficultyID then szDifficulty = "scenario (Visions of N'Zoth)";
		elseif 153 == difficultyID then szDifficulty = "scenario (Teeming Island)";
		end	
		if "ENCOUNTER_START" == event then
			local iCounter;
			for iCounter = 1, table.getn(BOSS_ENCOUNTER) do
				if encounterID == BOSS_ENCOUNTER[iCounter][1] then
					currentEncounter = BOSS_ENCOUNTER[iCounter];
					break;
				end
			end
			local szEncounterFound = "";
			if nil ~= currentEncounter then
				szEncounterFound = " *";
			end
			print(">>> encounter start: " .. encounterName .. " (" .. encounterID .. ") " .. szDifficulty .. " - " .. raidSize .. szEncounterFound);
		else
			if "ENCOUNTER_END" == event then
				currentEncounter = nil;
				local _, _, _, _, status = ...
				local szStatus = "Success";
				if 0 == status then
					szStatus = "Wipe";
				end
				print("<<< encounter end: " .. encounterName .. " (" .. encounterID .. ") " .. szDifficulty .. " - " .. raidSize .. " / " .. szStatus);
			end
	 	end
	end
	avoidableFrame:SetScript("OnEvent", eventHandler);

	local avoidableDamageTakenModule = Skada:NewModule(L["Avoidable damage taken"])
	local lstAvdDmgSpells = Skada:NewModule(L["List of avoidable damaging spells"])
	local dmgAvdSpells = Skada:NewModule(L["Damage taken by avoidable spell"])
	local lstDmgPlayerAvdSpells = Skada:NewModule(L["List of damaged players by avoidable spells"])

	local function isSpellCounted(spellId, destName)
		local blnCounted = false;
		if nil ~= currentEncounter then
			local iCounter;
			for iCounter = 2, table.getn(currentEncounter) do
				local curSpellId = currentEncounter[iCounter][1];
				if curSpellId == spellId then
					local blnIgnoreTank = currentEncounter[iCounter][2];
					local blnIgnoreHeal = currentEncounter[iCounter][3];
					local blnIgnoreDps = currentEncounter[iCounter][4];
					if blnIgnoreTank or blnIgnoreHeal or blnIgnoreDps then
						local unitRole = UnitGroupRolesAssigned(destName);
						if ("TANK" == unitRole and blnIgnoreTank) or ("HEALER" == unitRole and blnIgnoreHeal) or ("DAMAGER" == unitRole and blnIgnoreDps) then
							blnCounted = false;
						else
							blnCounted = true;
						end
					else
						blnCounted = true;
					end
				end
			end
		end
		return blnCounted;
	end

	local function log_avoidable_damage_taken(set, avoidableDmg)
		-- Get the player.
		local player = Skada:get_player(set, avoidableDmg.playerid, avoidableDmg.playername)
		if player then
			-- Also add to set total damage taken.
			set.avoidabledamagetaken = set.avoidabledamagetaken + avoidableDmg.amount

			-- Add spell to player if it does not exist.
			if not player.avoidabledamagetakenspells[avoidableDmg.spellname] or not player.avoidabledamagetakenspells[avoidableDmg.spellname]['absorbed'] then
				player.avoidabledamagetakenspells[avoidableDmg.spellname] = {id = avoidableDmg.spellid, name = avoidableDmg.spellname, damage = 0, totalhits = 0, min = nil, max = nil, crushing = 0, glancing = 0, resisted = 0, critical = 0, absorbed = 0, blocked = 0, school = avoidableDmg.school}
			end

			-- Add to player total damage.
			player.avoidabledamagetaken = player.avoidabledamagetaken + avoidableDmg.amount

			-- Get the spell from player.
			local spell = player.avoidabledamagetakenspells[avoidableDmg.spellname]
			spell.id = avoidableDmg.spellid
			spell.damage = spell.damage + avoidableDmg.amount

			if spell.max == nil or avoidableDmg.amount > spell.max then
				spell.max = avoidableDmg.amount
			end

			if avoidableDmg.crushing then
				spell.crushing = spell.crushing + 1
			end

			if avoidableDmg.blocked then
				spell.blocked = spell.blocked + avoidableDmg.blocked
			end

			if avoidableDmg.absorbed then
				spell.absorbed = spell.absorbed + avoidableDmg.absorbed
			end

			if avoidableDmg.critical then
				spell.critical = spell.critical + 1
			end

			if avoidableDmg.resisted then
				spell.resisted = spell.resisted + avoidableDmg.resisted
			end

			if avoidableDmg.glancing then
				spell.glancing = spell.glancing + 1
			end

			if (spell.min == nil or avoidableDmg.amount < spell.min) then
				spell.min = avoidableDmg.amount
			end
			spell.totalhits = (spell.totalhits or 0) + 1

		end
	end

	local avoidableDmg = {}

	local function AvoidableSpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		local spellId, spellName, spellSchool, samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing, soffhand, _ = ...
		if isSpellCounted(spellId, dstName) then
			avoidableDmg.playerid = dstGUID
			avoidableDmg.playername = dstName
			avoidableDmg.spellid = spellId
			avoidableDmg.spellname = spellName
			avoidableDmg.amount = samount
			avoidableDmg.blocked = sblocked
			avoidableDmg.absorbed = sabsorbed
			avoidableDmg.critical = scritical
			avoidableDmg.resisted = sresisted
			avoidableDmg.glancing = sglancing
			avoidableDmg.crushing = scrushing
			avoidableDmg.offhand = soffhand
			avoidableDmg.school = sschool

			log_avoidable_damage_taken(Skada.current, avoidableDmg)
			log_avoidable_damage_taken(Skada.total, avoidableDmg)
		end
	end

	local function AvoidableSwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		-- White melee.
		local samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing, soffhand, _ = ...
		if isSpellCounted(spellId, dstName) then
			avoidableDmg.playerid = dstGUID
			avoidableDmg.playername = dstName
			avoidableDmg.spellid = 6603
			avoidableDmg.spellname = L["Attack"]
			avoidableDmg.amount = samount
			avoidableDmg.blocked = sblocked
			avoidableDmg.absorbed = sabsorbed
			avoidableDmg.critical = scritical
			avoidableDmg.resisted = sresisted
			avoidableDmg.glancing = sglancing
			avoidableDmg.crushing = scrushing
			avoidableDmg.offhand = soffhand
			avoidableDmg.school = 0x01

			log_avoidable_damage_taken(Skada.current, avoidableDmg)
			log_avoidable_damage_taken(Skada.total, avoidableDmg)
		end
	end

	function dmgAvdSpells:Update(win,set)
		local max = 0

		-- Aggregate the data.
		local tmp = {}
		for i, player in ipairs(set.players) do
			if player.avoidabledamagetaken > 0 then
				for name, spell in pairs(player.avoidabledamagetakenspells) do
					if not tmp[name] then
						tmp[name] = {id = spell.id, damage = spell.damage, school = spell.school}
					else
						tmp[name].damage = tmp[name].damage + spell.damage
					end
				end
			end
		end

		local nr = 1
		for name, spell in pairs(tmp) do
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d

			d.label = name
			d.value = spell.damage
			d.valuetext = Skada:FormatNumber(spell.damage)..(" (%02.1f%%)"):format(spell.damage / set.avoidabledamagetaken * 100)
			d.id = name
			local _, _, icon = GetSpellInfo(spell.id)
			d.icon = icon
      if spell.school then
        d.spellschool = spell.school
      end
        
			d.spellid = spell.id

			if spell.damage > max then
				max = spell.damage
			end
			nr = nr + 1
		end
		win.metadata.maxvalue = max
	end

	function lstDmgPlayerAvdSpells:Enter(win, id, label)
		lstDmgPlayerAvdSpells.spellname = id
		lstDmgPlayerAvdSpells.title = label.." "..L["targets"]
	end

	function lstDmgPlayerAvdSpells:Update(win, set)
		local max = 0

		local nr = 1
		for i, player in ipairs(set.players) do
			if player.avoidabledamagetaken > 0 and player.avoidabledamagetakenspells[self.spellname] then
				local d = win.dataset[nr] or {}
				win.dataset[nr] = d

				d.label = player.name
				d.value = player.avoidabledamagetakenspells[self.spellname].damage
				d.valuetext = Skada:FormatNumber(player.avoidabledamagetakenspells[self.spellname].damage)
				d.id = player.id
				d.class = player.class
				d.role = player.role

				if player.avoidabledamagetakenspells[self.spellname].damage > max then
					max = player.avoidabledamagetakenspells[self.spellname].damage
				end
				nr = nr + 1
			end
		end

		win.metadata.maxvalue = max
	end

	function avoidableDamageTakenModule:Update(win, set)
		local max = 0

		local nr = 1
		for i, player in ipairs(set.players) do
			if player.avoidabledamagetaken > 0 then
				local d = win.dataset[nr] or {}
				win.dataset[nr] = d

				local totaltime = Skada:PlayerActiveTime(set, player)
				local dtps = player.avoidabledamagetaken / math.max(1,totaltime)

				d.label = player.name
				d.value = player.avoidabledamagetaken

				d.valuetext = Skada:FormatValueText(
												Skada:FormatNumber(player.avoidabledamagetaken), self.metadata.columns.Damage,
												string.format("%02.1f", dtps), self.metadata.columns.DTPS,
												string.format("%02.1f%%", player.avoidabledamagetaken / set.avoidabledamagetaken * 100), self.metadata.columns.Percent
											)
				d.id = player.id
				d.class = player.class
				d.role = player.role

				if player.avoidabledamagetaken > max then
					max = player.avoidabledamagetaken
				end
				nr = nr + 1
			end
		end

		win.metadata.maxvalue = max
	end

	function lstAvdDmgSpells:Enter(win, id, label)
		lstAvdDmgSpells.playerid = id
		lstAvdDmgSpells.title = label..L["'s Avoidable damage taken"]
	end

	-- Detail view of a player.
	function lstAvdDmgSpells:Update(win, set)
		-- View spells for this player.

		local player = Skada:find_player(set, self.playerid)

		local nr = 1
		if player then
			local max = 0
			for spellname, spell in pairs(player.avoidabledamagetakenspells) do

				local d = win.dataset[nr] or {}
				win.dataset[nr] = d

				d.label = spellname
				d.value = spell.damage
				local _, _, icon = GetSpellInfo(spell.id)
				d.icon = icon
				d.id = spellname
				d.spellid = spell.id
				d.valuetext = Skada:FormatNumber(spell.damage)..(" (%02.1f%%)"):format(spell.damage / player.avoidabledamagetaken * 100)
        if spell.school then
          d.spellschool = spell.school
        end

				max = math.max(max, spell.damage)
				nr = nr + 1
			end

			-- Sort the possibly changed bars.
			win.metadata.maxvalue = max
		end
	end

local function formatUpToX(s, x, indent)
	x = x or 79
	indent = indent or ""
	local t = {""}
	local function cleanse(s) return s:gsub("@x%d%d%d",""):gsub("@r","") end
	for prefix, word, suffix, newline in s:gmatch("([ \t]*)(%S*)([ \t]*)(\n?)") do
		if #(cleanse(t[#t])) + #prefix + #cleanse(word) > x and #t > 0 then
			table.insert(t, word..suffix) -- add new element
		else -- add to the last element
			t[#t] = t[#t]..prefix..word..suffix
		end
		if #newline > 0 then table.insert(t, "") end
	end
	return indent..table.concat(t, "\n"..indent)
end

	-- Tooltip for a specific spell.
	local function playerspell_tooltip(win, id, label, tooltip)
		local player = Skada:find_player(win:get_selected_set(), lstAvdDmgSpells.playerid)
		if player then
			local spell = player.avoidabledamagetakenspells[label]
			if spell then
				tooltip:AddLine(player.name.." - "..label)
        if spell.school then
          local c = _G.CombatLog_Color_ColorArrayBySchool(spell.school)
          if c then
            tooltip:AddLine(GetSchoolString(spell.school), c.r, c.g, c.b)
          end
        end
          
				tooltip:AddDoubleLine(L["Hit"]..":", spell.totalhits, 255,255,255,255,255,255)
				if spell.critical > 0 then
					tooltip:AddDoubleLine(L["Critical"]..":", spell.critical, 255,255,255,255,255,255)
				end
				if spell.glancing > 0 then
					tooltip:AddDoubleLine(L["Glancing"]..":", spell.glancing, 255,255,255,255,255,255)
				end
				if spell.crushing > 0 then
					tooltip:AddDoubleLine(L["Crushing"]..":", spell.crushing, 255,255,255,255,255,255)
				end
				if spell.max and spell.min then
					tooltip:AddDoubleLine(L["Minimum hit:"], Skada:FormatNumber(spell.min), 255,255,255,255,255,255)
					tooltip:AddDoubleLine(L["Maximum hit:"], Skada:FormatNumber(spell.max), 255,255,255,255,255,255)
				end
				tooltip:AddDoubleLine(L["Average hit:"], Skada:FormatNumber(spell.damage / spell.totalhits), 255,255,255,255,255,255)
				if spell.blocked > 0 then
					tooltip:AddDoubleLine(L["Blocked"]..":", Skada:FormatNumber(spell.blocked), 255,255,255,255,255,255)
				end
				if spell.resisted > 0 then
					tooltip:AddDoubleLine(L["Resisted"]..":", Skada:FormatNumber(spell.resisted), 255,255,255,255,255,255)
				end
				if spell.absorbed > 0 then
					tooltip:AddDoubleLine(L["Absorbed"]..":", Skada:FormatNumber(spell.absorbed), 255,255,255,255,255,255)
				end
				if nil ~= currentEncounter then
					local iCounter;
					for iCounter = 2, table.getn(currentEncounter) do
						local curSpellId = currentEncounter[iCounter][1];
						if curSpellId == spell.id then
							local info = currentEncounter[iCounter][5];
							if nil ~= info then
								tooltip:AddLine(formatUpToX(info, INFO_LENGTH_MAX, ""))
							end
						end
					end
				else
					-- full scan (encounter not active)
					local iCounterEncounter;
					local bspellFound = false;
					for iCounterEncounter = 1, table.getn(BOSS_ENCOUNTER) do
						if false == bspellFound then
							local tempEncounter = BOSS_ENCOUNTER[iCounterEncounter];
							local iCounter;
							for iCounter = 2, table.getn(tempEncounter) do
								local curSpellId = tempEncounter[iCounter][1];
								if curSpellId == spell.id then
									bspellFound = true;
									local info = tempEncounter[iCounter][5];
									if nil ~= info then
										tooltip:AddLine(formatUpToX(info, INFO_LENGTH_MAX, ""))
									end
								end
							end
						end
					end
				end
			end
		end
	end

	function avoidableDamageTakenModule:OnEnable()
		lstAvdDmgSpells.metadata 		= {tooltip = playerspell_tooltip}
		avoidableDamageTakenModule.metadata 			= {click1 = lstAvdDmgSpells, showspots = true, columns = {Damage = true, DTPS = true, Percent = true}, icon = "Interface\\Icons\\Inv_shield_06"}
		dmgAvdSpells.metadata	= {click1 = lstDmgPlayerAvdSpells, showspots = true, icon = "Interface\\Icons\\Inv_shield_07"}
		Skada:RegisterForCL(AvoidableSpellDamage, 'SPELL_DAMAGE', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(AvoidableSpellDamage, 'SPELL_PERIODIC_DAMAGE', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(AvoidableSpellDamage, 'SPELL_BUILDING_DAMAGE', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(AvoidableSpellDamage, 'RANGE_DAMAGE', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(AvoidableSwingDamage, 'SWING_DAMAGE', {dst_is_interesting_nopets = true})
		Skada:AddMode(self, L["Damage"])
		Skada:AddMode(dmgAvdSpells, L["Damage"])
	end

	function avoidableDamageTakenModule:OnDisable()
		Skada:RemoveMode(self)
	end

	-- Called by Skada when a new player is added to a set.
	function avoidableDamageTakenModule:AddPlayerAttributes(player)
		if not player.avoidabledamagetaken then
			player.avoidabledamagetaken = 0
			player.avoidabledamagetakenspells = {}
		end
	end

	-- Called by Skada when a new set is created.
	function avoidableDamageTakenModule:AddSetAttributes(set)
		if not set.avoidabledamagetaken then
			set.avoidabledamagetaken = 0
		end
	end

	function avoidableDamageTakenModule:GetSetSummary(set)
		return Skada:FormatNumber(set.avoidabledamagetaken)
	end
end)

