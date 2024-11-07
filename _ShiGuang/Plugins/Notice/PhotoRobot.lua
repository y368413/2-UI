-- PhotoRobot v0.3.9
-- Buff/Debuff monitor for default and custom unitframes
-- Written by OUGHT updated by Sauerkraut
-- Based on PortraitTimers by Killakhan
-- SetNormalTexture
local PhotoRobot = {}

PhotoRobot.spellDB = {
	-- Interrupts
	"1766", -- Kick (Rogue)
	"2139", -- Counterspell (Mage)
	"6552", -- Pummel (Warrior)
	"19647", -- Spell Lock (Warlock)
	"47528", -- Mind Freeze (Death Knight)
	"57994", -- Wind Shear (Shaman)
	"91802", -- Shambling Rush (Death Knight)
	"96231", -- Rebuke (Paladin)
	"106839", -- Skull Bash (Feral)
	"115781", -- Optical Blast (Warlock)
	"116705", -- Spear Hand Strike (Monk)
	"132409", -- Spell Lock (Warlock)
	"147362", -- Countershot (Hunter)
	"171138", -- Shadow Lock (Warlock)
	"183752", -- Consume Magic (Demon Hunter)
	"187707", -- Muzzle (Hunter)
	"212619", -- Call Felhunter (Warlock)
	"231665", -- Avengers Shield (Paladin)

	-- Death Knight

	"47476", -- Strangulate
	"48707", -- Anti-Magic Shell
	"48265", -- Death's Advance
	"48792", -- Icebound Fortitude
	"81256", -- Dancing Rune Weapon
	"51271", -- Pillar of Frost
	"55233", -- Vampiric Blood
	"77606", -- Dark Simulacrum
	"91797", -- Monstrous Blow
	"91800", -- Gnaw
	"108194", -- Asphyxiate
	"221562", -- Asphyxiate (Blood)
	"152279", -- Breath of Sindragosa
	"194679", -- Rune Tap
	"194844", -- Bonestorm
	"204080", -- Frostbite
	"206977", -- Blood Mirror
	"207127", -- Hungering Rune Weapon
	"207167", -- Blinding Sleet
	"207171", -- Winter is Coming
	"207256", -- Obliteration
	"207289", -- Unholy Frenzy
	"207319", -- Corpse Shield
	"212332", -- Smash
	"212337", -- Powerful Smash
	"212552", -- Wraith Walk
	"219809", -- Tombstone
	"223929", -- Necrotic Wound

	-- Demon Hunter

	"179057", -- Chaos Nova
	"187827", -- Metamorphosis
	"188499", -- Blade Dance
	"188501", -- Spectral Sight
	"204490", -- Sigil of Silence
	"205629", -- Demonic Trample
	"205630", -- Illidan's Grasp
	"206649", -- Eye of Leotheras
	"207685", -- Sigil of Misery
	"207810", -- Nether Bond
	"211048", -- Chaos Blades
	"211881", -- Fel Eruption
	"212800", -- Blur
	"196555", -- Netherwalk
	"218256", -- Empower Wards
	"221527", -- Imprison (Detainment Honor Talent)
	"217832", -- Imprison (Baseline Undispellable)
	"227225", -- Soul Barrier

	-- Druid

	"99", -- Incapacitating Roar
	"339", -- Entangling Roots
	"740", -- Tranquility
	"1850", -- Dash
	"252216", -- Tiger Dash
	"2637", -- Hibernate
	"5211", -- Mighty Bash
	"5217", -- Tiger's Fury
	"22812", -- Barkskin
	"22842", -- Frenzied Regeneration
	"29166", -- Innervate
	"33891", -- Incarnation: Tree of Life
	"45334", -- Wild Charge
	"61336", -- Survival Instincts
	"81261", -- Solar Beam
	"102342", -- Ironbark
	"102359", -- Mass Entanglement
	"279642", -- Lively Spirit
	"102543", -- Incarnation: King of the Jungle
	"102558", -- Incarnation: Guardian of Ursoc
	"102560", -- Incarnation: Chosen of Elune
	"106951", -- Berserk
	"155835", -- Bristling Fur
	"192081", -- Ironfur
	"163505", -- Rake
	"194223", -- Celestial Alignment
	"200851", -- Rage of the Sleeper
	"202425", -- Warrior of Elune
	"204399", -- Earthfury
	"204437", -- Lightning Lasso

	"209749", -- Faerie Swarm (Slow/Disarm)
	"209753", -- Cyclone
	"33786", -- Cyclone
	"22570", -- Maim
	"203123", -- Maim
	"236025", -- Enraged Maim (Feral Honor Talent)
	"236696", -- Thorns (PvP Talent)

	-- Hunter

	"136", -- Mend Pet
	"3355", -- Freezing Trap
	"203340", -- Diamond Ice (Survival Honor Talent)
	"5384", -- Feign Death
	"19386", -- Wyvern Sting
	"19574", -- Bestial Wrath
	"19577", -- Intimidation
	"24394", -- Intimidation
	"53480", -- Roar of Sacrifice (Hunter Pet Skill)
	"117526", -- Binding Shot
	"131894", -- A Murder of Crows (Beast Mastery, Marksmanship)
	"206505", -- A Murder of Crows (Survival)
	"186265", -- Aspect of the Turtle
	"186289", -- Aspect of the Eagle
	"238559", -- Bursting Shot
	"186387", -- Bursting Shot
	"193526", -- Trueshot
	"193530", -- Aspect of the Wild
	"199483", -- Camouflage
	"202914", -- Spider Sting (Armed)
	"202933", -- Spider Sting (Silenced)
	"233022", -- Spider Sting (Silenced)
	"209790", -- Freezing Arrow
	"209997", -- Play Dead
	"213691", -- Scatter Shot
	"272682", -- Master's Call

	-- Mage

	"66", -- Invisibility
	"110959", -- Greater Invisibility
	"118", -- Polymorph
	"28271", -- Polymorph Turtle
	"28272", -- Polymorph Pig
	"61025", -- Polymorph Serpent
	"61305", -- Polymorph Black Cat
	"61721", -- Polymorph Rabbit
	"61780", -- Polymorph Turkey
	"126819", -- Polymorph Porcupine
	"161353", -- Polymorph Polar Bear Cub
	"161354", -- Polymorph Monkey
	"161355", -- Polymorph Penguin
	"161372", -- Polymorph Peacock
	"277787", -- Polymorph Direhorn
	"277792", -- Polymorph Bumblebee
	"122", -- Frost Nova
	"33395", -- Freeze
	"11426", -- Ice Barrier
	"12042", -- Arcane Power
	"12051", -- Evocation
	"12472", -- Icy Veins
	"198144", -- Ice Form
	"31661", -- Dragon's Breath
	"45438", -- Ice Block
	"41425", -- Hypothermia
	"80353", -- Time Warp
	"82691", -- Ring of Frost
	"108839", -- Ice Floes
	"157997", -- Ice Nova
	"190319", -- Combustion
	"198111", -- Temporal Shield
	"198158", -- Mass Invisibility
	"198064", -- Prismatic Cloak
	"198065", -- Prismatic Cloak
	"205025", -- Presence of Mind
	"228600", -- Glacial Spike Root

	-- Monk

	"115078", -- Paralysis
	"115080", -- Touch of Death
	"115203", -- Fortifying Brew (Brewmaster)
	"201318", -- Fortifying Brew (Windwalker Honor Talent)
	"243435", -- Fortifying Brew (Mistweaver)
	"116706", -- Disable
	"116849", -- Life Cocoon
	"119381", -- Leg Sweep
	"122278", -- Dampen Harm
	"122470", -- Touch of Karma
	"122783", -- Diffuse Magic
	"137639", -- Storm, Earth, and Fire
	"198909", -- Song of Chi-Ji
	"201325", -- Zen Meditation
	"115176", -- Zen Meditation
	"202162", -- Guard
	"202274", -- Incendiary Brew
	"216113", -- Way of the Crane
	"232055", -- Fists of Fury
	"120086", -- Fists of Fury
	"233759", -- Grapple Weapon

	-- Paladin

	"498", -- Divine Protection
	"642", -- Divine Shield
	"853", -- Hammer of Justice
	"1022", -- Blessing of Protection
	"204018", -- Blessing of Spellwarding
	"1044", -- Blessing of Freedom
	"6940", -- Blessing of Sacrifice
	"199448", -- Blessing of Sacrifice (Ultimate Sacrifice Honor Talent)
	"20066", -- Repentance
	"31821", -- Aura Mastery
	"31850", -- Ardent Defender
	"31884", -- Avenging Wrath (Protection/Retribution)
	"31842", -- Avenging Wrath (Holy)
	"216331", -- Avenging Crusader (Holy Honor Talent)
	"231895", -- Crusade (Retribution Talent)
	"31935", -- Avenger's Shield
	"86659", -- Guardian of Ancient Kings
	"212641", -- Guardian of Ancient Kings (Glyphed)
	"228049", -- Guardian of the Forgotten Queen
	"105809", -- Holy Avenger
	"115750", -- Blinding Light
	"105421", -- Blinding Light
	"152262", -- Seraphim
	"184662", -- Shield of Vengeance
	"204150", -- Aegis of Light
	"205191", -- Eye for an Eye
	"210256", -- Blessing of Sanctuary
	"210294", -- Divine Favor
	"215652", -- Shield of Virtue


	-- Priest

	"586", -- Fade
	"213602", -- Greater Fade
	"605", -- Mind Control
	"8122", -- Psychic Scream
	"9484", -- Shackle Undead
	"10060", -- Power Infusion
	"15487", -- Silence
	"199683", -- Last Word
	"33206", -- Pain Suppression
	"47536", -- Rapture
	"47585", -- Dispersion
	"47788", -- Guardian Spirit
	"64044", -- Psychic Horror
	"64843", -- Divine Hymn
	"81782", -- Power Word: Barrier
	"271466", -- Luminous Barrier (Disc Talent)
	"87204", -- Sin and Punishment
	"193223", -- Surrender to Madness
	"194249", -- Voidform
	"196762", -- Inner Focus
	"197268", -- Ray of Hope
	"197862", -- Archangel
	"197871", -- Dark Archangel
	"200183", -- Apotheosis
	"200196", -- Holy Word: Chastise
	"200200", -- Holy Word: Chastise (Stun)
	"205369", -- Mind Bomb
	"226943", -- Mind Bomb (Disorient)
	"213610", -- Holy Ward
	"215769", -- Spirit of Redemption
	"221660", -- Holy Concentration

	-- Rogue

	"408", -- Kidney Shot
	"1330", -- Garrote - Silence
	"1776", -- Gouge
	"1833", -- Cheap Shot
	"1966", -- Feint
	"2094", -- Blind
	"199743", -- Parley
	"5277", -- Evasion
	"6770", -- Sap
	"13750", -- Adrenaline Rush
	"31224", -- Cloak of Shadows
	"51690", -- Killing Spree
	"79140", -- Vendetta
	"121471", -- Shadow Blades
	"199754", -- Riposte
	"199804", -- Between the Eyes
	"207736", -- Shadowy Duel
	"212183", -- Smoke Bomb

	-- Shaman

	"2825", -- Bloodlust
	"32182", -- Heroism
	"51514", -- Hex
	"196932", -- Voodoo Totem
	"210873", -- Hex (Compy)
	"211004", -- Hex (Spider)
	"211010", -- Hex (Snake)
	"211015", -- Hex (Cockroach)
	"269352", -- Hex (Skeletal Hatchling)
	"277778", -- Hex (Zandalari Tendonripper)
	"277784", -- Hex (Wicker Mongrel)
	"79206", -- Spiritwalker's Grace 60 * OTHER
	"108281", -- Ancestral Guidance
	"16166", -- Elemental Mastery
	"64695", -- Earthgrab Totem
	"77505", -- Earthquake (Stun)
	"98008", -- Spirit Link Totem
	"108271", -- Astral Shift
	"210918", -- Ethereal Form
	"114050", -- Ascendance (Elemental)
	"114051", -- Ascendance (Enhancement)
	"114052", -- Ascendance (Restoration)
	"118345", -- Pulverize
	"118905", -- Static Charge
	"197214", -- Sundering
	"204293", -- Spirit Link
	"204366", -- Thundercharge
	"204945", -- Doom Winds
	"260878", -- Spirit Wolf
	"8178", -- Grounding
	"255016", -- Grounding
	"204336", -- Grounding
	"34079", -- Grounding

	-- Warlock

	"710", -- Banish
	"5484", -- Howl of Terror
	"6358", -- Seduction
	"115268", -- Mesmerize
	"6789", -- Mortal Coil
	"20707", -- Soulstone
	"22703", -- Infernal Awakening
	"30283", -- Shadowfury
	"89751", -- Felstorm
	"115831", -- Wrathstorm
	"89766", -- Axe Toss
	"104773", -- Unending Resolve
	"108416", -- Dark Pact
	"113860", -- Dark Soul: Misery (Affliction)
	"113858", -- Dark Soul: Instability (Demonology)
	"118699", -- Fear
	"130616", -- Fear (Glyph of Fear)
	"171017", -- Meteor Strike
	"196098", -- Soul Harvest
	"196364", -- Unstable Affliction (Silence)
	"212284", -- Firestone
	"212295", -- Nether Ward


	-- Warrior

	"871", -- Shield Wall
	"1719", -- Recklessness
	"5246", -- Intimidating Shout
	"12975", -- Last Stand
	"18499", -- Berserker Rage
	"23920", -- Spell Reflection
	"213915", -- Mass Spell Reflection
	"216890", -- Spell Reflection (Arms, Fury)
	"46968", -- Shockwave
	"97462", -- Rallying Cry
	"105771", -- Charge (Warrior)
	"107574", -- Avatar
	"118038", -- Die by the Sword
	"132169", -- Storm Bolt
	"184364", -- Enraged Regeneration
	"197690", -- Defensive Stance
	"213871", -- Bodyguard
	"227847", -- Bladestorm (Arms)
	"46924", -- Bladestorm (Fury)
	"152277", -- Ravager
	"228920", -- Ravager
	"236077", -- Disarm
	"236236", -- Disarm

	-- Other

	"20549", -- War Stomp
	"107079", -- Quaking Palm
	"129597", -- Arcane Torrent
	"25046", -- Arcane Torrent
	"28730", -- Arcane Torrent
	"50613", -- Arcane Torrent
	"69179", -- Arcane Torrent
	"80483", -- Arcane Torrent
	"155145", -- Arcane Torrent
	"202719", -- Arcane Torrent
	"202719", -- Arcane Torrent
	"232633", -- Arcane Torrent
	"192001", -- Drink
	"167152", -- Refreshment
	"256948", -- Spatial Rift
	"255654", --Bull Rush
	"294127", -- Gladiator's Maledict

	-- Legacy (may be deprecated)

	"178858", -- Contender (Draenor Garrison Ability)

	-- Special
	--"6788" = { type = "special", nounitFrames = true, noraidFrames = true }, -- Weakened Soul
}


function PhotoRobot.CreateConfig()

	PhotoRobot.panel = CreateFrame("Frame", "PhotoRobotpanel", UIParent)
	PhotoRobot.panel.name = PHOTOROBOT_PhotoRobot
	InterfaceOptions_AddCategory(PhotoRobot.panel)

	PhotoRobot.title = PhotoRobot.panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	PhotoRobot.title:SetPoint("TOPLEFT", 16, -16)
	PhotoRobot.title:SetText(PHOTOROBOT_Config)

	PhotoRobot.subtitle = PhotoRobot.panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	PhotoRobot.subtitle:SetPoint("TOPLEFT", PhotoRobot.title, "BOTTOMLEFT", 0, -8)
	PhotoRobot.subtitle:SetNonSpaceWrap(true)
	PhotoRobot.subtitle:SetText("v 0.3.10")
	PhotoRobot.subtitle:SetTextColor(1, 1, 1, 0.5)
	
	----------------------------------
	-- panel 2 start
	----------------------------------
	
	PhotoRobot.checkbox3 = CreateFrame("CheckButton", "PhotoRobotcheckbox3", PhotoRobot.panel, "ChatConfigCheckButtonTemplate")
	PhotoRobot.checkbox3:SetPoint("TOPLEFT", PhotoRobot.subtitle, "BOTTOMLEFT", 10, -21)
	_G[PhotoRobot.checkbox3:GetName().."Text"]:SetText(PHOTOROBOT_EnableonPlayerFrame)
	_G[PhotoRobot.checkbox3:GetName().."Text"]:SetPoint("LEFT", PhotoRobot.checkbox3, "RIGHT", 3, 1)
	PhotoRobot.checkbox3.tooltip = PHOTOROBOT_onPlayerFrame
	PhotoRobot.checkbox3:SetScript("OnClick", function(self, button, down)
		if PhotoRobot.checkbox3:GetChecked() then
			PhotoRobot.db.ShowOnPlayerAuras = true
		else
			PhotoRobot.db.ShowOnPlayerAuras = false
		end
	end)
	
	--[[PhotoRobot.checkbox1 = CreateFrame("CheckButton", "PhotoRobotcheckbox1", p1, "ChatConfigCheckButtonTemplate")
	PhotoRobot.checkbox1:SetPoint("TOPLEFT", PhotoRobot.checkbox3, "BOTTOMLEFT", 0, -5)
	_G[PhotoRobot.checkbox1:GetName().."Text"]:SetText(PHOTOROBOT_onPartyFrames)
	_G[PhotoRobot.checkbox1:GetName().."Text"]:SetPoint("LEFT", PhotoRobot.checkbox1, "RIGHT", 3, 1)
	PhotoRobot.checkbox1.tooltip = PHOTOROBOT_PartyFramesdisplay
	PhotoRobot.checkbox1:Show()
	PhotoRobot.checkbox1:SetScript("OnClick", function(self, button, down)
		if PhotoRobot.checkbox1:GetChecked() then
			PhotoRobot.db.ShowOnPartyAuras = true
		else
			PhotoRobot.db.ShowOnPartyAuras = false
		end
	end)
	
	PhotoRobot.checkbox2 = CreateFrame("CheckButton", "PhotoRobotcheckbox2", p1, "ChatConfigCheckButtonTemplate")
	PhotoRobot.checkbox2:SetPoint("TOPLEFT", PhotoRobot.checkbox1, "BOTTOMLEFT", 15, -5)
	_G[PhotoRobot.checkbox2:GetName().."Text"]:SetText(PHOTOROBOT_inArena)
	_G[PhotoRobot.checkbox2:GetName().."Text"]:SetPoint("LEFT", PhotoRobot.checkbox2, "RIGHT", 3, 1)
	PhotoRobot.checkbox2.tooltip = PHOTOROBOT_BlzPartyFramesdisplay
	PhotoRobot.checkbox2:Hide()
	PhotoRobot.checkbox2:SetScript("OnClick", function(self, button, down)
		if PhotoRobot.checkbox2:GetChecked() then
			PhotoRobot.db.ShowOnPartyFrames = true
		else
			PhotoRobot.db.ShowOnPartyFrames = false
		end
	end)
	
	PhotoRobot.checkbox4 = CreateFrame("CheckButton", "PhotoRobotcheckbox4", p1, "ChatConfigCheckButtonTemplate")
	PhotoRobot.checkbox4:SetPoint("TOPLEFT", PhotoRobot.checkbox1, "BOTTOMLEFT", 0, -35)
	_G[PhotoRobot.checkbox4:GetName().."Text"]:SetText(PHOTOROBOT_onArenaFrames)
	_G[PhotoRobot.checkbox4:GetName().."Text"]:SetPoint("LEFT", PhotoRobot.checkbox4, "RIGHT", 3, 1)
	PhotoRobot.checkbox4.tooltip = PHOTOROBOT_ArenaFramesdisplay
	PhotoRobot.checkbox4:SetScript("OnClick", function(self, button, down)
		if PhotoRobot.checkbox4:GetChecked() then
			PhotoRobot.db.ShowOnArenaAuras = true
		else
			PhotoRobot.db.ShowOnArenaAuras = false
		end
	end)]]
	----------------------------------
	-- panel 2 end
	----------------------------------	
	----------------------------------
	-- panel 1 start
	----------------------------------
	local p1 = PhotoRobot.panel

	PhotoRobot.dropdown1 = CreateFrame("Frame", "PhotoRobotdropdown1", PhotoRobot.panel, "UIDropDownMenuTemplate")
	PhotoRobot.dropdown1:SetPoint("TOPLEFT", PhotoRobot.checkbox3, "BOTTOMLEFT", -10, -30)
	PhotoRobot.dropdown1:SetWidth(40)
	PhotoRobot.dropdown1.font = PhotoRobot.dropdown1:CreateFontString("PhotoRobotdropdownFont", "ARTWORK", "GameFontNormalSmall")
	PhotoRobot.dropdown1.font:SetPoint("BOTTOMLEFT", PhotoRobot.dropdown1, "TOPLEFT", 20, 0)
	PhotoRobot.dropdown1.font:SetText(PHOTOROBOT_FontSize)
	_G[PhotoRobot.dropdown1:GetName().."Button"]:SetScript("OnClick", function(self, button, down)
		  Lib_ToggleDropDownMenu(1, nil, PhotoRobot.dropdown1, self:GetName(), -100 ,0)
	end)

	local info = {}

	function PhotoRobot.dropdown1.initialize(self, level)
		if not level then return end
		wipe(info)
		if level == 1 then
			PhotoRobot.CreateMenu(info)
		end
	end

	function PhotoRobot.OnClickFunc(button, arg1, arg2, checked)
		PhotoRobot.db.fontSize = arg1
		local newfont, size = _G[arg2]:GetFont()
		PhotoRobot.testFont:SetFont(newfont, size, "OUTLINE")
		PhotoRobot.testFont2:SetFont(newfont, size/1.3, "OUTLINE")
		PhotoRobot.arenaTextureFrame.font:SetFont(newfont, size/1.3, "OUTLINE")
		-- print("selected " .. arg1, arg2)
		Lib_UIDropDownMenu_SetText(PhotoRobot.dropdown1, arg1)
	end	
		
	function PhotoRobot.CreateMenu(info)
		for k, v in pairs(PhotoRobot.fontsDB) do
			info.text = k
			info.isTitle = nil
			info.notCheckable = nil
			info.func = PhotoRobot.OnClickFunc
			info.arg1 = k
			info.arg2 = v
			info.fontObject = PhotoRobot[k]
			info.checked = PhotoRobot.isCurrent(k)
			Lib_UIDropDownMenu_AddButton(info)
		end
	end	

	function PhotoRobot.isCurrent(font)
		if PhotoRobot.db.fontSize == font then
			return true
		else
			return false
		end
	end

	PhotoRobot.texture = p1:CreateTexture()
	PhotoRobot.texture:SetTexture("Interface\\Icons\\Spell_Holy_SealOfValor")
	PhotoRobot.texture:SetPoint("LEFT", PhotoRobot.dropdown1, "RIGHT", 200, 0)
	
	PhotoRobot.testFont = p1:CreateFontString(nil, "ARTWORK")
	PhotoRobot.testFont:SetPoint("CENTER", PhotoRobot.texture, "CENTER")
	local newfont, size = _G[PhotoRobot.fontsDB[PhotoRobot.db.fontSize]]:GetFont()
	PhotoRobot.testFont:SetFont(newfont, size, "OUTLINE")
	PhotoRobot.testFont:SetText("8.2")
	PhotoRobot.testFont:SetTextColor(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb, PhotoRobot.db.a)

	PhotoRobot.texture2 = p1:CreateTexture()
	PhotoRobot.texture2:SetTexture("Interface\\Icons\\Spell_Shadow_NetherCloak")
	PhotoRobot.texture2:SetPoint("LEFT", PhotoRobot.texture, "RIGHT", 0, 0)
	PhotoRobot.texture2:SetHeight(40)
	PhotoRobot.texture2:SetWidth(40)
	
	PhotoRobot.testFont2 = p1:CreateFontString(nil, "ARTWORK")
	PhotoRobot.testFont2:SetPoint("CENTER", PhotoRobot.texture2, "CENTER")
	local newfont, size = _G[PhotoRobot.fontsDB[PhotoRobot.db.fontSize]]:GetFont()
	PhotoRobot.testFont2:SetFont(newfont, size/1.3, "OUTLINE")
	PhotoRobot.testFont2:SetText("4.9")
	PhotoRobot.testFont2:SetTextColor(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb, PhotoRobot.db.a)
	
	PhotoRobot.colorButton = CreateFrame("Button", nil, p1, "OptionsBaseCheckButtonTemplate")
	local frame = PhotoRobot.colorButton
	frame:SetPoint("TOPLEFT", PhotoRobot.dropdown1, "BOTTOMLEFT", 20, -10)
	frame:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight")
	frame:SetScript("OnClick", function(self)
		PhotoRobot.ShowColorPicker(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb, PhotoRobot.myColorCallback);
	end)
	
	frame.texture = frame:CreateTexture(nil, "OVERLAY")
	frame.texture:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
	frame.texture:SetTexture(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb)
	frame.texture:SetPoint("CENTER", frame, "CENTER")
	frame.texture:SetHeight(frame:GetHeight()/2)
	frame.texture:SetWidth(frame:GetHeight()/2)

	frame.text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	frame.text:SetPoint("LEFT", frame, "RIGHT")
	frame.text:SetText(PHOTOROBOT_FontColor)
	frame.text:SetTextColor(1, 1, 1)
	
	p1.checkbox1 = CreateFrame("CheckButton", "PhotoRobotp1_checkbox1", p1, "ChatConfigCheckButtonTemplate")
	p1.checkbox1:SetPoint("TOPLEFT", PhotoRobot.colorButton, "BOTTOMLEFT", 0, -5)
	_G[p1.checkbox1:GetName().."Text"]:SetText(PHOTOROBOT_ShowDecimals)
	_G[p1.checkbox1:GetName().."Text"]:SetPoint("LEFT",  p1.checkbox1, "RIGHT", 3, 1)
	p1.checkbox1.tooltip = PHOTOROBOT_displayonframes
	p1.checkbox1:Show()
	p1.checkbox1:SetScript("OnClick", function(self, button, down)
		if  p1.checkbox1:GetChecked() then
			PhotoRobot.db.showDecimals = true
			PhotoRobot.testFont:SetText("8.2")
			PhotoRobot.testFont2:SetText("4.9")
			PhotoRobot.arenaTextureFrame.font:SetText("2.7")
		else
			PhotoRobot.testFont:SetText("8")
			PhotoRobot.testFont2:SetText("4")
			PhotoRobot.arenaTextureFrame.font:SetText("2")
			PhotoRobot.db.showDecimals = false
		end
	end)
	
	p1.font = p1:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	p1.font:SetPoint("TOPLEFT", p1.checkbox1, "BOTTOMLEFT", 5, -30)
	p1.font:SetText(PHOTOROBOT_FontPosition)
	p1.font:SetTextColor(1, 1, 1)
	
	function PhotoRobot.Text_SetPoint(self)
		local id, parent = self:GetID(), "CENTER"
		if id == 1 then
			parent = "CENTER"
		elseif id == 2 then
			parent = "TOP"
		elseif id == 3 then
			parent = "BOTTOM"
		elseif id == 4 then
			parent = "RIGHT"
		elseif id == 5 then
			parent = "LEFT"
		end
		PhotoRobot.UpdateFontParent(parent)
		PhotoRobot.db.fontParent = parent
	end
	
	for i = 1, 5 do
		local button = CreateFrame("Button", "pt_btn"..i, p1, "UIPanelButtonTemplate")
		button:SetHeight(25)
		button:SetWidth(25)
		button:SetID(i)
		button:SetScript("OnClick", PhotoRobot.Text_SetPoint)
	end

	pt_btn1:SetPoint("LEFT", p1.font, "RIGHT", 50, 0)
	pt_btn2:SetPoint("BOTTOM", pt_btn1, "TOP")
	pt_btn3:SetPoint("TOP", pt_btn1, "BOTTOM")
	pt_btn4:SetPoint("LEFT", pt_btn1, "RIGHT")
	pt_btn5:SetPoint("RIGHT", pt_btn1, "LEFT")

	PhotoRobot.slider1 = CreateFrame("Slider", "PhotoRobotslider1", p1, "OptionsSliderTemplate")
	PhotoRobot.slider1:SetPoint("TOPLEFT", p1.font, "BOTTOMLEFT", 0, -70)
	_G[PhotoRobot.slider1:GetName().."Text"]:SetText(PHOTOROBOT_ArenaFrameScale .. string.format("%.0f", PhotoRobot.db.arenaFrameScale*100).."%")
	PhotoRobot.slider1.tooltipText = PHOTOROBOT_DragtosetScale
	_G[PhotoRobot.slider1:GetName().."Low"]:SetText("100%")
	_G[PhotoRobot.slider1:GetName().."High"]:SetText("200%")
	PhotoRobot.slider1:SetWidth(155)
	PhotoRobot.slider1:SetMinMaxValues(1, 2)
	PhotoRobot.slider1:SetValue(PhotoRobot.db.arenaFrameScale)
	PhotoRobot.slider1:SetValueStep(0.1)
	PhotoRobot.slider1:SetScript("OnValueChanged", function(self, value)
		PhotoRobot.db.arenaFrameScale = value
		_G[PhotoRobot.slider1:GetName().."Text"]:SetText(PHOTOROBOT_ArenaFrameScale .. string.format("%.0f", value*100).."%")
		PhotoRobot.arenaTextureFrame:SetScale(value)
	end)
	
	PhotoRobot.arenaTextureFrame = CreateFrame("Frame", nil, p1)
	PhotoRobot.arenaTextureFrame.tex = PhotoRobot.arenaTextureFrame:CreateTexture(nil, "OVERLAY")
	PhotoRobot.arenaTextureFrame.tex:SetTexture("Interface\\ArenaEnemyFrame\\UI-ArenaTargetingFrame")
	PhotoRobot.arenaTextureFrame.tex:SetTexCoord(0, 0.796, 0, 0.5)
	PhotoRobot.arenaTextureFrame.tex:SetPoint("TOPLEFT", PhotoRobot.slider1, "BOTTOMLEFT", 20, -10)
	PhotoRobot.arenaTextureFrame.tex:SetWidth(102)
	PhotoRobot.arenaTextureFrame.tex:SetHeight(32)
	PhotoRobot.arenaTextureFrame.port = PhotoRobot.arenaTextureFrame:CreateTexture(nil, "ARTWORK")
	SetPortraitToTexture(PhotoRobot.arenaTextureFrame.port, "Interface\\Icons\\Ability_Rogue_KidneyShot")
	PhotoRobot.arenaTextureFrame.port:SetPoint("RIGHT", PhotoRobot.arenaTextureFrame.tex, "RIGHT", -2, 0)
	PhotoRobot.arenaTextureFrame.port:SetWidth(25)
	PhotoRobot.arenaTextureFrame.port:SetHeight(25)
	
	PhotoRobot.numberFrame = CreateFrame("Frame", nil, p1)
	PhotoRobot.numberFrame:SetFrameStrata("DIALOG")
	PhotoRobot.arenaTextureFrame.font = PhotoRobot.numberFrame:CreateFontString(nil, "OVERLAY")
	PhotoRobot.arenaTextureFrame.font:SetPoint("CENTER", PhotoRobot.arenaTextureFrame.port, "CENTER")
	local newfont, size = _G[PhotoRobot.fontsDB[PhotoRobot.db.fontSize]]:GetFont()
	PhotoRobot.arenaTextureFrame.font:SetFont(newfont, size/1.3, "OUTLINE")
	PhotoRobot.arenaTextureFrame.font:SetText("2.7")
	PhotoRobot.arenaTextureFrame.font:SetTextColor(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb, PhotoRobot.db.a)
	
	----------------------------------
	-- panel 1 end
	----------------------------------
end

local defaults = {
	ShowOnArenaAuras = false,
	ShowOnPlayerAuras = true,
	ShowOnPartyFrames = false,
	ShowOnPartyAuras = false,
	fontSize = "Small",
	PhotoRobotr = 1.0,
	PhotoRobotg = 1.0,
	PhotoRobotb = 1.0,
	PhotoRobota = 1.0,
	arenaFrameScale = 1,
	showDecimals = true,
	fontParent = "CENTER",
}

PhotoRobot.fontsDB = {
	["Normal"] = "GameFontNormalLarge",
	["Small"] = "GameFontNormal",
	["Large"] = "GameFontNormalHuge",
}

PhotoRobot.f = CreateFrame("Frame", "PhotoRobotmainFrame", UIParent)

-- main update frames
PhotoRobot.TargetFrame = CreateFrame("Frame", "PhotoRobot_TargetFrame", UIParent)
local tFrame = PhotoRobot.TargetFrame
tFrame:SetWidth(1)
tFrame:SetHeight(1)
tFrame:SetFrameStrata("DIALOG")
PhotoRobot.FocusFrame = CreateFrame("Frame", "PhotoRobot_FocusFrame", UIParent)
local fFrame = PhotoRobot.FocusFrame
fFrame:SetWidth(1)
fFrame:SetHeight(1)
fFrame:SetFrameStrata("DIALOG")
PhotoRobot.PlayerFrame = CreateFrame("Frame", "PhotoRobot_PlayerFrame", UIParent)
local pFrame = PhotoRobot.PlayerFrame
pFrame:SetWidth(1)
pFrame:SetHeight(1)
pFrame:SetFrameStrata("DIALOG")
for i = 1, 4 do
	PhotoRobot["PartyFrame"..i] = CreateFrame("Frame", "PhotoRobot_PartyFrame"..i, UIParent)
	local frame = PhotoRobot["PartyFrame"..i]
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("DIALOG")
	-- print("created " .. frame:GetName())
end
for i = 1, 5 do
	PhotoRobot["ArenaFrame"..i] = CreateFrame("Frame", "PhotoRobot_ArenaFrame"..i, UIParent)
	local frame = PhotoRobot["ArenaFrame"..i]
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("DIALOG")
	-- print("created " .. frame:GetName())
end

PhotoRobot.f:SetScript("OnEvent", function(self, event, ...) 
	  if (ShiGuangPerDB["BHT"] == false) and PhotoRobot[event] then 
		 return PhotoRobot[event](PhotoRobot, event, ...) 
	  end 
end)

PhotoRobot.f:RegisterEvent("PLAYER_LOGIN")
PhotoRobot.f:RegisterEvent("PLAYER_ENTERING_WORLD")
PhotoRobot.f:RegisterEvent("ADDON_LOADED")
PhotoRobot.f:RegisterEvent("ARENA_OPPONENT_UPDATE")

-- event functions
function PhotoRobot:PLAYER_ENTERING_WORLD(event, ...)
  if ShiGuangPerDB["BHT"] == true then return end 
	--[[local _, instance = IsInInstance() I don't know why this block is added, I try to solve by brute force
	local parent
	if instance == "raid" then
		PhotoRobot.f:UnregisterEvent("UNIT_AURA")
		PhotoRobot.f:UnregisterEvent("PLAYER_TARGET_CHANGED")
		PhotoRobot.f:UnregisterEvent("PLAYER_FOCUS_CHANGED")
		PhotoRobot.f:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		tFrame:SetScript("OnUpdate", nil)
		tFrame:Hide()
		fFrame:SetScript("OnUpdate", nil)
		fFrame:Hide()
		for i = 1, 4 do
			local frame = PhotoRobot["PartyFrame"..i]
			frame:Hide()
			frame:SetScript("OnUpdate", nil)
		end
	else]]
		PhotoRobot.f:RegisterEvent("UNIT_AURA")      
		PhotoRobot.f:RegisterEvent("PLAYER_TARGET_CHANGED")
		PhotoRobot.f:RegisterEvent("PLAYER_FOCUS_CHANGED")
		--PhotoRobot.f:RegisterEvent("PARTY_MEMBERS_CHANGED")
	--end

		self.CreateAuraIcons("PhotoRobotTargetTexture", TargetFrame.portrait, TargetFrame, tFrame)
		self.CreateAuraIcons("PhotoRobotFocusTexture", FocusFrame.portrait, FocusFrame, fFrame)
		self.CreateAuraIcons("PhotoRobotPlayerTexture", PlayerFrame.portrait, PlayerFrame, pFrame)
		-- if self.db.ShowOnPartyFrames then
			-- self.f:RegisterEvent("PARTY_MEMBERS_CHANGED")
		-- end
		for i = 1, 4 do
			local frame = _G["PartyMemberFrame"..i]
			if frame then
				self.CreateAuraIcons("PhotoRobotPartyTexture"..i, frame.portrait, frame, self["PartyFrame"..i])
			end
		end
		--self.checkbox2:Show()
end

function PhotoRobot:ARENA_OPPONENT_UPDATE(event, unit, status)
  if ShiGuangPerDB["BHT"] == true then return end 
	if (unit == "arena1" or unit == "arena2" or unit == "arena3" or unit == "arena4" or unit == "arena5") and status == "seen" then
		-- print("found unit: " .. unit)

	end
end

function PhotoRobot:PARTY_MEMBERS_CHANGED(event)
  if ShiGuangPerDB["BHT"] == true then return end 
	-- show blizzard frames
	if self.db.ShowOnPartyFrames then
		local _, instance = IsInInstance()
		if instance == "arena" then
			-- print("in arena")
			for i = 1, 4 do
				local unit = "party"..i
				if UnitExists(unit) then
					PhotoRobot.UpdatePartyFrames(_G["PartyMemberFrame"..i])
				end
			end
		end
	end
end

function PhotoRobot:UNIT_AURA(event, unit)
  if ShiGuangPerDB["BHT"] == true then return end 
	--print("UNIT_AURA " .. unit)
	if unit == "target" or unit == "focus" then 
		PhotoRobot.CheckAuras(unit)
	end
	if PhotoRobot.db.ShowOnArenaAuras and (ArenaEnemyFrame1 or ArenaEnemyFrame2 or ArenaEnemyFrame3 or ArenaEnemyFrame4 or ArenaEnemyFrame5) then
		if unit == "arena1" or unit == "arena2" or unit == "arena3" or unit == "arena4" or unit == "arena5" then 
			PhotoRobot.CheckAuras(unit)
		end
	end
	if PhotoRobot.db.ShowOnPartyAuras then
		if unit == "party1" or unit == "party2" or unit == "party3" or unit == "party4" then
				if (unit == "party1" and (PartyMemberFrame1:IsVisible())) or
					(unit == "party2" and (PartyMemberFrame2:IsVisible())) or
					(unit == "party3" and (PartyMemberFrame3:IsVisible())) or
					(unit == "party4" and (PartyMemberFrame4:IsVisible())) then
					PhotoRobot.CheckAuras(unit)
				end
		end
	end
	if PhotoRobot.db.ShowOnPlayerAuras then
		if unit == "player" then
			PhotoRobot.CheckAuras(unit)
		end
	end
end


function PhotoRobot:PLAYER_TARGET_CHANGED(event)
  if ShiGuangPerDB["BHT"] == true then return end 
	tFrame.auras = {}
	--PhotoRobot.SetPortraitTexture(tFrame, nil)
	if UnitExists("target") then
		PhotoRobot.CheckAuras("target")
	else
		tFrame:Hide()
	end
end


function PhotoRobot:PLAYER_FOCUS_CHANGED(event)
  if ShiGuangPerDB["BHT"] == true then return end 
	fFrame.auras = {}
	if UnitExists("focus") then
		PhotoRobot.CheckAuras("focus")
	else
		fFrame:Hide()
	end
end


function PhotoRobot:ADDON_LOADED(event, addon)
	if (ShiGuangPerDB["BHT"] == false) and addon == "_ShiGuang" then
		--if not PhotoRobotDB then PhotoRobotDB = {} end
		self.db = self.CopyDefaults(defaults, ShiGuangPerDB)
		
		self.CreateConfig()
		UIDropDownMenu_SetText(self.dropdown1, self.db.fontSize)
		self.colorButton.texture:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
		self.colorButton.texture:SetTexture(self.db.PhotoRobotr, self.db.PhotoRobotg, self.db.PhotoRobotb)
		--self.checkbox1:SetChecked(self.db.ShowOnPartyAuras)
		--self.checkbox2:SetChecked(self.db.ShowOnPartyFrames)
		self.checkbox3:SetChecked(self.db.ShowOnPlayerAuras)
		--self.checkbox4:SetChecked(self.db.ShowOnArenaAuras)
		self.panel.checkbox1:SetChecked(self.db.showDecimals)
		self.slider1:SetValue(self.db.arenaFrameScale)
		self.arenaTextureFrame:SetScale(self.db.arenaFrameScale)

		self.UpdateConfigDecimals(self.db.showDecimals)
		self.UpdateFontParent(self.db.fontParent)
		self.f:UnregisterEvent("ADDON_LOADED")
	elseif addon == "Blizzard_ArenaUI" then
		for i = 1, 5 do
			local frame = _G["ArenaEnemyFrame"..i]
			local petFrame = _G["ArenaEnemyFrame"..i.."PetFrame"]
			if frame and petFrame then
				self.CreateAuraIcons("PhotoRobotArenaTexture"..i, frame.classPortrait, frame, PhotoRobot["ArenaFrame"..i])
				frame:SetScale(PhotoRobot.db.arenaFrameScale)
				petFrame:SetScale(PhotoRobot.db.arenaFrameScale)
			end
		end
	end
end

function PhotoRobot.UpdateFontParent(parent)
	PhotoRobot.testFont:ClearAllPoints()
	PhotoRobot.testFont2:ClearAllPoints()
	PhotoRobot.arenaTextureFrame.font:ClearAllPoints()
	PhotoRobot.testFont:SetPoint(parent, PhotoRobot.texture, parent)
	PhotoRobot.testFont2:SetPoint(parent, PhotoRobot.texture2, parent)
	PhotoRobot.arenaTextureFrame.font:SetPoint(parent, PhotoRobot.arenaTextureFrame.port, parent)
end

function PhotoRobot.UpdateConfigDecimals(checked)
	if checked == true then
		PhotoRobot.testFont:SetText("8.2")
		PhotoRobot.testFont2:SetText("4.9")
		PhotoRobot.arenaTextureFrame.font:SetText("2.7")	
	else
		PhotoRobot.testFont:SetText("8")
		PhotoRobot.testFont2:SetText("4")
		PhotoRobot.arenaTextureFrame.font:SetText("2")
	end
end

function PhotoRobot.UpdatePartyFrames(self)
	local id = self:GetID();
	if ( GetPartyMember(id) ) then
		self:Show();
		
		UnitFrame_Update(self);
		
		local masterIcon = _G[self:GetName().."MasterIcon"];
		local lootMethod;
		local lootMaster;
		lootMethod, lootMaster = GetLootMethod();
		if ( id == lootMaster ) then
			masterIcon:Show();
		else
			masterIcon:Hide();
		end
	else
		self:Hide();
	end
	PartyMemberFrame_UpdatePet(self);
	PartyMemberFrame_UpdatePvPStatus(self);
	RefreshDebuffs(self, "party"..id, nil, nil, true);
	PartyMemberFrame_UpdateVoiceStatus(self);
	PartyMemberFrame_UpdateReadyCheck(self);
	PartyMemberFrame_UpdateOnlineStatus(self);
	PartyMemberFrame_UpdatePhasingDisplay(self);
	UpdatePartyMemberBackground();
	-- print("created " .. self:GetName())
end

function PhotoRobot.CopyDefaults(src, dst)
	if not src then return { } end
	if not dst then dst = { } end
	for k, v in pairs(src) do
		if type(v) == "table" then
			dst[k] = PhotoRobot.CopyDefaults(v, dst[k])
		elseif type(v) ~= type(dst[k]) then
			dst[k] = v
		end
	end
	return dst
end


function PhotoRobot.CreateAuraIcons(name, portrait, parent, frame)
	if frame.auraIcon or not (parent and portrait) then return end
	frame.auraIcon = parent:CreateTexture(name, "OVERlAY")
	frame.auraIcon:SetPoint("CENTER", portrait)
	frame.auraIcon:SetAllPoints(portrait)
	if not frame.font then
		PhotoRobot.CreateFontStrings(name .. "_Font", frame)
	end

	if not frame.auras then 
		frame.auras = {} 
	end

	--print("Created " .. frame.auraIcon:GetName())
	--SetPortraitToTexture(frame.auraIcon, "Interface\\Icons\\spell_holy_divineprotection")
	--frame.auraIcon:SetTexture("Interface\\Icons\\spell_holy_divineprotection")
	--PhotoRobot.SetPortraitTexture(frame, "Interface\\AddOns\\PortraitTimers\\Coolface")
end

function PhotoRobot.CreateFontStrings(name, frame)
	local fontString
	for k, v in pairs(PhotoRobot.fontsDB) do
		if k == PhotoRobot.db.fontSize then
			-- print(k, v)
			fontString = v
		end
	end
	frame.font = frame:CreateFontString(name, "OVERLAY")
	-- frame.font:ClearAllPoints()
	frame.font:SetPoint(PhotoRobot.db.fontParent, frame.auraIcon, PhotoRobot.db.fontParent)
	
	local newfont, size = _G[fontString]:GetFont()
	frame.font:SetFont(newfont, size, "OUTLINE")
	frame.font:SetText("")
	frame.font:SetTextColor(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb, PhotoRobot.db.PhotoRobota)
	-- print("Created " .. frame.font:GetName())
end

function PhotoRobot.SetFontSize(newFont, frame)
	if frame.font then
		local outlineFont, size = _G[newFont]:GetFont()
		frame.font:SetTextColor(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb, PhotoRobot.db.PhotoRobota)
		if frame:GetName():find("Party") or frame:GetName():find("Arena") then
			frame.font:SetFont(outlineFont, size/1.3, "OUTLINE")
		else
			frame.font:SetFont(outlineFont, size, "OUTLINE")
		end
	end
end

function PhotoRobot.HideAll(unit)
	--print("hide frame " .. unit)
	local frame = PhotoRobot.GetUnitFrame(unit)
	if not frame then return end
	frame:Hide()
	if frame.auraIcon then
		frame.auraIcon:Hide()
	end
	if frame.font then
		frame.font:SetText("")
	end
	frame.auras = {}
end

-- Makes list of all auras on unit
function PhotoRobot.ListAuras(unit)
	local auras = {}
	local i
	i = 1
	repeat
		--print(unit .. ' ' .. i)
		local name, texture, _, _, _, eTime = UnitBuff(unit, i)							
		if (name ~= nil) then
			table.insert(auras, {	["name"] = name, 
									["texture"] = texture, 
									["eTime"] = eTime - GetTime()})
		end
		i = i+1
	until (name == nil)

	i = 1
	repeat
		local name, texture, _, _, _, eTime = UnitDebuff(unit, i)							
		if (name ~= nil) then
			table.insert(auras, {	["name"] = name, 
									["texture"] = texture, 
									["eTime"] = eTime - GetTime()})
		end
		i = i+1
	until (name == nil)

	--[[for i = 1, #auras do	
		print(auras[i].name)
	end	]]

	return auras
end

-- Checks trackable and adds new auras
function PhotoRobot.CheckAuras(unit)
	--print("check aura " .. unit)
	local auras = {}
	local auCheck = PhotoRobot.ListAuras(unit)

	for idx, spellID in ipairs(PhotoRobot.spellDB) do
		local spell = C_Spell.GetSpellInfo(spellID)
		if (spell ~= nil) then
			--print("checking aura " .. spellID .. " on " .. unit)
			for i = 1, #auCheck do						
				if (auCheck[i].name == spell) then
					--print((tTime - GetTime()) .. " sec")
					table.insert(auras, 
					{	
						["spell"] = auCheck[i].name, 
						["texture"] = auCheck[i].texture, 
						["eTime"] = auCheck[i].eTime,
					})
					--print("Adding in auras " .. spellID)
				end
				i = i+1
			end
		end
	end
	--[[for i, au in ipairs(auras) do
		print(i.. ". " .. au.spell)
	end]]

	if (auras ~= nil) and (#auras > 0) then	
		local frame = PhotoRobot.GetUnitFrame(unit)
		for i, au in ipairs(auras) do
			flag = false
			if (#frame.auras > 0) then
				for j, fau in  ipairs(frame.auras) do
					if (au.spell == fau.spell) then 
						flag = true 
					end
				end
			end
			if not flag then
				--print("Found aura " .. au.spell .. " on " .. unit .. ", expires in " .. au.eTime .. " seconds.")
				--if not au.unit then print("Unit is NIL!!! Galactics in danger!!!") end
				PhotoRobot.SetAura(unit, au.spell, au.texture, au.eTime)
			end
		end
	else
	 PhotoRobot.HideAll(unit)
	end
end -- func

-- Updates current aura
function PhotoRobot.UpdateAura(auCheck, aura)
	local res = nil
	local flag = false
	--print(#auCheck)
	for i = 1, #auCheck do	
		if (flag ~= true) and (auCheck[i].name == aura.spell) then
			res = auCheck[i].eTime
			flag = true
			--print("Updated aura " .. auCheck[i].name .. ", expires in " .. res .. " seconds.")
		end
	end
	return res
end

-- Checks trackable auras and updates time in it
function PhotoRobot.UpdateAuras(frame, auras)
	--print("check aura " .. unit)
	local auCheck = PhotoRobot.ListAuras(frame)
	local res = nil
	if auras == nil then 
		--print("Auras = NIL!!! Galactics in danger!!!")
		return 
	end
	local n = #auras 
	for i = 1, n do
		res = PhotoRobot.UpdateAura(auCheck, auras[i])
		if res ~= nil then
			auras[i].time = res
		else
			--print("Aura has broken!")
			auras[i].time = 0
		end
	end
end -- func

function PhotoRobot.SetPortraitTexture(frame, texture)
	if not frame then return end
	SetPortraitToTexture(frame.auraIcon, texture)
end

function PhotoRobot.SetFormattedText(time)
	if PhotoRobot.db.showDecimals then
		return string.format("%.1f", time)
	else
		return string.format("%.0f", time)
	end
end

function PhotoRobot.CompareSpells(t1, t2)
	--print("Comparing "..t1.spell.." and "..t2.spell)
	for i, sp in ipairs(PhotoRobot.spellDB)
	do
		local spell = C_Spell.GetSpellInfo(sp)
		if (spell == t1.spell) then
			--print(sp.." won!")
			return false
		elseif (spell == t2.spell) then
			--print(sp.." won!")
			return true
		end
	end
	return false
end



function PhotoRobot.SetAura(unit, spell, texture, eTime)
	local frame = PhotoRobot.GetUnitFrame(unit)
	if not frame then return end
	if not frame.auraIcon then return end

	for idx, au in ipairs(frame.auras) do
		if spell == au.spell then return end
	end

	--print("Attempting to change texture of " ..unit .. " to " .. texture);
	--PhotoRobot.SetPortraitTexture(frame, texture)
	--PhotoRobot.SetFontSize(PhotoRobot.fontsDB[PhotoRobot.db.fontSize], frame)
	--frame.font:SetText(PhotoRobot.SetFormattedText(eTime-GetTime()))
	--frame.font:ClearAllPoints()
	--frame.font:SetPoint(PhotoRobot.db.fontParent, frame.auraIcon, PhotoRobot.db.fontParent)

	table.insert(frame.auras, {})
	local i = #frame.auras
	frame.auras[i].spell = spell;
	frame.auras[i].texture = texture
	frame.auras[i].time = eTime
	frame.name = unit
	--print("Adding " .. spell .. " to auras at " .. i .. " position \n Sorting...");
	table.sort(frame.auras, PhotoRobot.CompareSpells)

	--[[for idx, au in ipairs(frame.auras) do
		print(idx .. ". " .. au.spell);
	end]]

	frame.first = true
	frame:Show()
	frame.auraIcon:Show()

	frame:SetScript("OnUpdate", PhotoRobot.UpdateTimer)
end

function PhotoRobot.UpdateTimer(self, elapsed)
	-- emergency timer
	if (self.tick == nil) then self.tick = 0.4 end
	self.check = false
	self.tick = self.tick - elapsed
	if (self.tick <= 0) then
		self.tick = 0.4
		self.check = true
		--print(self)
	end

	local expired = {}
	--local chAuras = PhotoRobot.ListAuras(self.name)
	local c = #self.auras
	if c == 0 then return end
	for i = 1, c do
		self.auras[i].time = self.auras[i].time - elapsed
		if self.auras[i].time <= 0 then 
			table.insert(expired, i) 
			--print("|c00FF0000" .. self.auras[i].spell .. " expired!|r")
		end
		if self.check then -- emergency handler
			--print("Checking!")
			--[[local flag = false
			for j = 1, #chAuras do
				if chAuras[j].name == self.auras[i].spell then
					flag = true	
				end
			end
			if not flag then 
				table.insert(expired, i) 
				--print("|c00FF0000" .. self.auras[i].spell .. " broken!|r")
			end]]
			PhotoRobot.UpdateAuras(self.name, self.auras)
		end
	end

	if #expired > 0 then
		for i = #expired, 1, -1 do
			table.remove(self.auras, expired[i])
		end
		--[[for idx, au in ipairs(self.auras) do
			print(idx .. ". " .. au.spell);
		end]]
		table.sort(self.auras, PhotoRobot.CompareSpells)
	end
		
	--[[for idx, au in ipairs(self.auras) do
		print(idx .. ". " .. au.spell);
	end]]

	if #self.auras == 0 then 
		--print("Hiding all #1");
		PhotoRobot.HideAll(self.name)
		return
	end
	local cur = self.auras[#self.auras]
	--print("Ticking " .. cur.spell .. ", unit " .. self.name .. ", time left " .. cur.time);
	if not self.first then 
		if cur.time > 0 and UnitExists(self.name) and self:IsVisible() then
			PhotoRobot.SetPortraitTexture(self, cur.texture)	
			self.font:SetText(PhotoRobot.SetFormattedText(cur.time))
		else			
			--[[print(cur.time > 0)
			print(UnitExists(cur.name))
			print(self:IsVisible())]]
			table.remove(self.auras)
			if #self.auras == 0 then 
				--print("Hiding all #2")
				PhotoRobot.HideAll(self.name)
			end
		end
	end
	self.first = false
end


function PhotoRobot.GetUnitFrame(unit)
	local frame
	if unit == "target" then
		frame = tFrame
	elseif unit == "focus" then
		frame = fFrame
	elseif unit == "player" then
		frame = pFrame
	elseif unit == "party1" then
		frame = PhotoRobot.PartyFrame1
	elseif unit == "party2" then
		frame = PhotoRobot.PartyFrame2
	elseif unit == "party3" then
		frame = PhotoRobot.PartyFrame3
	elseif unit == "party4" then
		frame = PhotoRobot.PartyFrame4
	elseif unit == "arena1" then
		frame = PhotoRobot.ArenaFrame1
	elseif unit == "arena2" then
		frame = PhotoRobot.ArenaFrame2
	elseif unit == "arena3" then
		frame = PhotoRobot.ArenaFrame3
	elseif unit == "arena4" then
		frame = PhotoRobot.ArenaFrame4
	elseif unit == "arena5" then
		frame = PhotoRobot.ArenaFrame5
	end	
	return frame
end

function PhotoRobot.ShowColorPicker(r, g, b, changedCallback)
	ColorPickerFrame.opacity  = 1
	ColorPickerFrame.hasOpacity = false
	ColorPickerFrame.previousValues = {r,g,b}
	ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = 
	changedCallback, changedCallback, changedCallback;
	ColorPickerFrame:Hide(); -- Need to run the OnShow handler.
	ColorPickerFrame:Show();
end

function PhotoRobot.myColorCallback(restore)
	local newR, newG, newB
	if restore then -- canel
		newR, newG, newB = unpack(restore);
	else
		newR, newG, newB = ColorPickerFrame:GetColorRGB();
	end
	PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb = newR, newG, newB
	PhotoRobot.colorButton.texture:SetTexture(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb)
	PhotoRobot.testFont:SetTextColor(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb, PhotoRobot.db.PhotoRobota)
	PhotoRobot.testFont2:SetTextColor(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb, PhotoRobot.db.PhotoRobota)
	PhotoRobot.arenaTextureFrame.font:SetTextColor(PhotoRobot.db.PhotoRobotr, PhotoRobot.db.PhotoRobotg, PhotoRobot.db.PhotoRobotb, PhotoRobot.db.PhotoRobota)
end