local _, ns = ...
local _, R = unpack(ns)

R.CoolDownData = {
	-- Shaman | ÈøÂú
	[108280] = 180,		-- ÖÎÁÆÖ®³±Í¼ÌÚ
	[114052] = 180,		-- ÉýÌÚ(ÖÎÁÆ)
	[98008] = 180,		-- Áé»êÁ´½ÓÍ¼ÌÚ
	[192077] = 120,		-- ¿ñ·çÍ¼ÌÚ
	-- Druid | µÂÂ³ÒÁ
	[740] = 180,		-- Äþ¾², ÓÐÌì¸³120
	[33891] = 180,		-- »¯Éí£ºÉúÃüÖ®Ê÷
	[106898] = 120,		-- ¿ñ±¼Å­ºð
	-- Monk | ÎäÉ®
	[198644] = 180,		-- Öìº×³à¾«
	[115310] = 180,		-- »¹»êÊõ
	-- ¶ÓÎé´ò¶Ï
	[1766] = 15, -- Kick (Rogue)
	[2139] = 24, -- Counterspell (Mage)
	[6552] = 15, -- Pummel (Warrior)
	[19647] = 15, -- Spell Lock (Warlock)
	[47528] = 15, -- Mind Freeze (Death Knight)
	[57994] = 12, -- Wind Shear (Shaman)
	[91802] = 12, -- Shambling Rush (Death Knight)
	[96231] = 15, -- Rebuke (Paladin)
	[106839] = 15, -- Skull Bash (Feral)
	[115781] = 15, -- Optical Blast (Warlock)
	[116705] = 15, -- Spear Hand Strike (Monk)
	[132409] = 24, -- Spell Lock (Warlock With Sacrifice)
	[147362] = 24, -- Counter Shot (Hunter)
	[171138] = 24, -- Countershot (Hunter)
	[183752] = 15, -- Disrupt
	[187707] = 15, -- Muzzle
	[212619] = 15, -- Call Felhunter (Warlock)
	[231665] = 15, -- Avengers Shield (Paladin)
	
	--[15487] = 45, -- Silence
	--[78675] = 60, -- Solar Beam
	--[119910] = 24,  -- Spell Lock  (With pet)
	
}

R.RaidSpells = {
	-- Battle resurrection
		[20484] = 600,	-- Rebirth
		[61999] = 600,	-- Raise Ally
		[20707] = 600,	-- Soulstone
		[345130] = 600,	-- Disposable Spectrophasic Reanimator
		-- Heroism
		[32182] = 300,	-- Heroism
		[2825] = 300,	-- Bloodlust
		[80353] = 300,	-- Time Warp
		[264667] = 300,	-- Primal Rage [Hunter's pet]
		-- Healing
		[633] = 600,	-- Lay on Hands
		[740] = 180,	-- Tranquility
		[115310] = 180,	-- Revival
		[64843] = 180,	-- Divine Hymn
		[108280] = 180,	-- Healing Tide Totem
		[15286] = 120,	-- Vampiric Embrace
		[108281] = 120,	-- Ancestral Guidance
		-- Defense
		[207399] = 300,	-- Ancestral Protection Totem
		[62618] = 180,	-- Power Word: Barrier
		[33206] = 180,	-- Pain Suppression
		[47788] = 180,	-- Guardian Spirit
		[31821] = 180,	-- Aura Mastery
		[98008] = 180,	-- Spirit Link Totem
		[97462] = 180,	-- Rallying Cry
		[196718] = 180,	-- Darkness
		[51052] = 120,	-- Anti-Magic Zone
		[116849] = 120,	-- Life Cocoon
		[6940] = 120,	-- Blessing of Sacrifice
		[102342] = 90,	-- Ironbark
		-- Other
		[106898] = 120,	-- Stampeding Roar
		[192077] = 120,	-- Wind Rush Totem
}
R.enemy_spells = {
	-- Interrupts and Silences
	[57994] = 12, -- Wind Shear
	[47528] = 15,	 -- Mind Freeze
		[183752] = 15,	-- Disrupt
	[106839] = 15,	-- Skull Bash
		[187707] = 15,	-- Muzzle
	[116705] = 15,	-- Spear Hand Strike
	[96231] = 15,	-- Rebuke
	[1766] = 15,	-- Kick
	[6552] = 15,	-- Pummel
	[147362] = 24,	-- Counter Shot
	[2139] = 24,	-- Counterspell
	[19647] = 24,	-- Spell Lock
	[115781] = 24,	-- Optical Blast
	[15487] = 45,	-- Silence
	[47476] = 60,	-- Strangulate
	[78675] = 60,	-- Solar Beam
		-- Crowd Controls
		[20066] = 15,	-- Repentance
		[51514] = 20,	-- Hex
		[187650] = 25,	-- Freezing Trap
		[115078] = 30,	-- Paralysis
		[8122] = 30,		-- Psychic Scream
		[107570] = 30,	-- Storm Bolt
		[5484] = 40,		-- Howl of Terror
		[30283] = 45,	-- Shadowfury
		[108194] = 45,	-- Asphyxiate
		[113724] = 45,	-- Ring of Frost
		[64044] = 45,	-- Psychic Horror
		[6789] = 45,		-- Mortal Coil
		[119381] = 50,	-- Leg Sweep
		[853] = 60,		-- Hammer of Justice
		-- Defense abilities
		[48707] = 60,	-- Anti-Magic Shell
		[46924] = 60,	-- Bladestorm
		[49039] = 120,	-- Lichborne
		[31224] = 120,	-- Cloak of Shadows
		[47585] = 120,	-- Dispersion
		[1856] = 120,	-- Vanish
		[7744] = 120,	-- Will of the Forsaken (Racial)
		[186265] = 180,	-- Aspect of the Turtle
		[33206] = 180,	-- Pain Suppression
}
	
R.pulse_ignored_spells = {
	--GetSpellInfo(spellID),	-- Spell name
}