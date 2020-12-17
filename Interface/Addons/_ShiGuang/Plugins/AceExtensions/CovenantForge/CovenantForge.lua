--	///////////////////////////////////////////////////////////////////////////////////////////	 
--	Author: SLOKnightfall
--	Version: V1.4.1
--	SavedVariables: CovenantForgeDB, CovenantForgeSavedPaths, CovenantForgeWeights
--	///////////////////////////////////////////////////////////////////////////////////////////

if GetLocale() == "zhCN" then
  CovenantForgeLocal = "|cffe6cc80[心能]|r评分数值";
elseif GetLocale() == "zhTW" then
  CovenantForgeLocal = "|cffe6cc80[心能]|r评分数值";
else
  CovenantForgeLocal = "CovenantForge";
end

_G["BINDING_HEADER_COVENANTFORGE"] = CovenantForgeLocal
_G["BINDING_NAME_COVENANTFORGE_BINDING_TOGGLE_SOULBINDS"] = "    Toggle Soulbind Viewer"

local CovenantForge = LibStub("AceAddon-3.0"):NewAddon("CovenantForge", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")
local AceGUI = LibStub("AceGUI-3.0")
CovenantForge.Frame = LibStub("AceGUI-3.0")
CovenantForge.Init = {}

CovenantForge.Conduits ={
	[5]={ "Stalwart Guardian", 334993, 2, {72,71,73,},},
	[7]={ "Brutal Vitality", 335010, 2, {72,71,73,},},
	[8]={ "Inspiring Presence", 335034, 0, {72,71,73,},},
	[9]={ "Safeguard", 335196, 0, {72,71,73,},},
	[10]={ "Fueled by Violence", 347213, 2, {73,},},
	[11]={ "Ashen Juggernaut", 335232, 1, {72,71,73,},},
	[12]={ "Crash the Ramparts", 335242, 1, {71,},},
	[13]={ "Cacophonous Roar", 335250, 0, {72,71,73,},},
	[14]={ "Merciless Bonegrinder", 335260, 1, {71,},},
	[15]={ "Harm Denial", 336379, 2, {268,270,269,},},
	[16]={ "Inner Fury", 336452, 1, {269,},},
	[17]={ "Unrelenting Cold", 336460, 1, {64,},},
	[18]={ "Shivering Core", 336472, 1, {64,},},
	[19]={ "Calculated Strikes", 336526, 1, {269,},},
	[20]={ "Icy Propulsion", 336522, 1, {64,},},
	[21]={ "Ice Bite", 336569, 1, {64,},},
	[22]={ "Coordinated Offensive", 336598, 1, {269,},},
	[23]={ "Winter's Protection", 336613, 0, {62,63,64,},},
	[24]={ "Xuen's Bond", 336616, 1, {269,},},
	[25]={ "Grounding Breath", 336632, 2, {268,270,269,},},
	[26]={ "Flow of Time", 336636, 0, {62,63,64,},},
	[27]={ "Indelible Victory", 336191, 2, {72,71,73,},},
	[28]={ "Jade Bond", 336773, 1, {270,},},
	[29]={ "Grounding Surge", 336777, 0, {62,63,64,},},
	[30]={ "Infernal Cascade", 336821, 1, {63,},},
	[31]={ "Resplendent Mist", 336812, 1, {270,},},
	[32]={ "Master Flame", 336852, 1, {63,},},
	[33]={ "Fortifying Ingredients", 336853, 2, {268,270,269,},},
	[34]={ "Arcane Prodigy", 336873, 1, {62,},},
	[35]={ "Lingering Numbness", 336884, 0, {268,270,269,},},
	[36]={ "Nether Precision", 336886, 1, {62,},},
	[37]={ "Dizzying Tumble", 336890, 0, {268,270,269,},},
	[38]={ "Discipline of the Grove", 336992, 1, {62,63,64,},},
	[39]={ "Gift of the Lich", 336999, 1, {62,63,64,},},
	[40]={ "Ire of the Ascended", 337058, 1, {62,63,64,},},
	[41]={ "Swift Transference", 337078, 0, {268,270,269,},},
	[42]={ "Tumbling Technique", 337084, 0, {268,270,269,},},
	[43]={ "Siphoned Malice", 337087, 1, {62,63,64,},},
	[44]={ "Rising Sun Revival", 337099, 1, {270,},},
	[45]={ "Cryo-Freeze", 337123, 2, {62,63,64,},},
	[46]={ "Scalding Brew", 337119, 1, {268,},},
	[47]={ "Celestial Effervescence", 337134, 2, {268,},},
	[48]={ "Diverted Energy", 337136, 2, {62,63,64,},},
	[49]={ "Unnerving Focus", 337154, 2, {73,},},
	[50]={ "Depths of Insanity", 337162, 1, {72,},},
	[51]={ "Magi's Brand", 337192, 1, {62,},},
	[52]={ "Hack and Slash", 337214, 1, {72,},},
	[53]={ "Flame Accretion", 337224, 1, {63,},},
	[54]={ "Nourishing Chi", 337241, 1, {270,},},
	[55]={ "Artifice of the Archmage", 337240, 1, {62,},},
	[56]={ "Evasive Stride", 337250, 2, {268,},},
	[57]={ "Walk with the Ox", 337264, 1, {268,},},
	[58]={ "Incantation of Swiftness", 337275, 0, {62,63,64,},},
	[59]={ "Strike with Clarity", 337286, 1, {268,270,269,},},
	[60]={ "Bone Marrow Hops", 337295, 1, {268,270,269,},},
	[61]={ "Tempest Barrier", 337293, 2, {62,63,64,},},
	[62]={ "Imbued Reflections", 337301, 1, {268,270,269,},},
	[63]={ "Way of the Fae", 337303, 1, {268,270,269,},},
	[64]={ "Vicious Contempt", 337302, 1, {72,},},
	[65]={ "Eternal Hunger", 337381, 1, {252,},},
	[66]={ "Translucent Image", 337662, 2, {258,256,257,},},
	[67]={ "Move with Grace", 337678, 0, {258,256,257,},},
	[68]={ "Chilled Resilience", 337704, 0, {250,251,252,},},
	[69]={ "Clear Mind", 337707, 0, {258,256,257,},},
	[70]={ "Spirit Drain", 337705, 0, {250,251,252,},},
	[71]={ "Charitable Soul", 337715, 2, {258,256,257,},},
	[72]={ "Light's Inspiration", 337748, 2, {258,256,257,},},
	[73]={ "Power Unto Others", 337762, 0, {258,256,257,},},
	[74]={ "Reinforced Shell", 337764, 2, {250,251,252,},},
	[75]={ "Shining Radiance", 337778, 1, {256,},},
	[76]={ "Pain Transformation", 337786, 1, {256,},},
	[77]={ "Exaltation", 337790, 1, {256,},},
	[78]={ "Lasting Spirit", 337811, 1, {257,},},
	[79]={ "Accelerated Cold", 337822, 1, {251,},},
	[80]={ "Withering Plague", 337884, 1, {250,},},
	[81]={ "Swift Penitence", 337891, 1, {256,},},
	[82]={ "Focused Mending", 337914, 1, {257,},},
	[83]={ "Eradicating Blow", 337934, 1, {251,},},
	[84]={ "Resonant Words", 337947, 1, {257,},},
	[85]={ "Mental Recovery", 337954, 0, {258,256,257,},},
	[86]={ "Blood Bond", 337957, 2, {250,},},
	[87]={ "Courageous Ascension", 337966, 1, {258,256,257,},},
	[88]={ "Hardened Bones", 337972, 2, {250,251,252,},},
	[89]={ "Embrace Death", 337980, 1, {252,},},
	[90]={ "Festering Transfusion", 337979, 1, {258,256,257,},},
	[91]={ "Everfrost", 337988, 1, {251,},},
	[92]={ "Astral Protection", 337964, 2, {262,264,263,},},
	[93]={ "Refreshing Waters", 337974, 2, {262,264,263,},},
	[94]={ "Vital Accretion", 337981, 2, {262,264,263,},},
	[95]={ "Thunderous Paws", 338033, 0, {262,264,263,},},
	[96]={ "Totemic Surge", 338042, 0, {262,264,263,},},
	[97]={ "Crippling Hex", 338054, 0, {262,264,263,},},
	[98]={ "Spiritual Resonance", 338048, 0, {262,264,263,},},
	[99]={ "Fleeting Wind", 338089, 0, {250,251,252,},},
	[100]={ "Pyroclastic Shock", 345594, 1, {262,},},
	[101]={ "Fae Fermata", 338305, 1, {258,256,257,},},
	[102]={ "High Voltage", 338131, 1, {262,},},
	[103]={ "Shake the Foundations", 338252, 1, {262,},},
	[104]={ "Call of Flame", 338303, 1, {262,},},
	[105]={ "Shattered Perceptions", 338315, 1, {258,256,257,},},
	[106]={ "Unending Grip", 338311, 0, {250,251,252,},},
	[107]={ "Haunting Apparitions", 338319, 1, {258,},},
	[108]={ "Insatiable Appetite", 338330, 2, {250,251,252,},},
	[109]={ "Unruly Winds", 338318, 1, {263,},},
	[110]={ "Focused Lightning", 338322, 1, {263,},},
	[111]={ "Magma Fist", 338331, 1, {263,},},
	[112]={ "Chilled to the Core", 338325, 1, {263,},},
	[113]={ "Mind Devourer", 338332, 1, {258,},},
	[114]={ "Rabid Shadows", 338338, 1, {258,},},
	[115]={ "Dissonant Echoes", 338342, 1, {258,},},
	[116]={ "Holy Oration", 338345, 1, {257,},},
	[117]={ "Embrace of Earth", 338329, 1, {264,},},
	[118]={ "Swirling Currents", 338339, 1, {264,},},
	[119]={ "Heavy Rainfall", 338343, 1, {264,},},
	[120]={ "Nature's Focus", 338346, 1, {264,},},
	[121]={ "Meat Shield", 338435, 2, {250,},},
	[122]={ "Unleashed Frenzy", 338492, 1, {251,},},
	[123]={ "Debilitating Malady", 338516, 1, {250,},},
	[124]={ "Convocation of the Dead", 338553, 1, {252,},},
	[125]={ "Lingering Plague", 338566, 1, {252,},},
	[126]={ "Impenetrable Gloom", 338628, 1, {250,251,252,},},
	[127]={ "Brutal Grasp", 338651, 1, {250,251,252,},},
	[128]={ "Proliferation", 338664, 1, {250,251,252,},},
	[129]={ "Divine Call", 338741, 2, {65,66,70,},},
	[130]={ "Fel Defender", 338671, 2, {577,581,},},
	[131]={ "Viscous Ink", 338682, 2, {577,581,},},
	[132]={ "Shattered Restoration", 338793, 2, {577,581,},},
	[133]={ "Shielding Words", 338787, 2, {65,66,70,},},
	[134]={ "Felfire Haste", 338799, 0, {577,581,},},
	[135]={ "Ravenous Consumption", 338835, 0, {577,581,},},
	[137]={ "Enfeebled Mark", 339018, 1, {253,254,255,},},
	[138]={ "Demonic Parole", 339048, 0, {577,581,},},
	[139]={ "Empowered Release", 339059, 1, {253,254,255,},},
	[140]={ "Spirit Attunement", 339109, 1, {253,254,255,},},
	[141]={ "Golden Path", 339114, 2, {65,66,70,},},
	[142]={ "Pure Concentration", 339124, 0, {65,66,70,},},
	[143]={ "Necrotic Barrage", 339129, 1, {253,254,255,},},
	[144]={ "Fel Celerity", 339130, 0, {265,266,267,},},
	[145]={ "Lost in Darkness", 339149, 0, {577,581,},},
	[146]={ "Elysian Dirge", 339182, 1, {262,264,263,},},
	[147]={ "Tumbling Waves", 339186, 1, {262,264,263,},},
	[148]={ "Essential Extraction", 339183, 1, {262,264,263,},},
	[149]={ "Lavish Harvest", 339185, 1, {262,264,263,},},
	[150]={ "Relentless Onslaught", 339151, 1, {577,},},
	[151]={ "Dancing with Fate", 339228, 1, {577,},},
	[152]={ "Serrated Glaive", 339230, 1, {577,},},
	[153]={ "Growing Inferno", 339231, 1, {577,581,},},
	[154]={ "Piercing Verdict", 339259, 1, {72,71,73,},},
	[157]={ "Markman's Advantage", 339264, 2, {253,254,255,},},
	[158]={ "Veteran's Repute", 339265, 1, {72,71,73,},},
	[159]={ "Light's Barding", 339268, 0, {65,66,70,},},
	[160]={ "Resolute Barrier", 339272, 2, {265,266,267,},},
	[161]={ "Wrench Evil", 339292, 0, {65,66,70,},},
	[162]={ "Accrued Vitality", 339282, 2, {265,266,267,},},
	[163]={ "Echoing Blessings", 339316, 0, {65,66,70,},},
	[164]={ "Expurgation", 339371, 1, {70,},},
	[165]={ "Harrowing Punishment", 339370, 1, {72,71,73,},},
	[166]={ "Harmony of the Tortollan", 339377, 2, {253,254,255,},},
	[167]={ "Truth's Wake", 339374, 1, {70,},},
	[168]={ "Shade of Terror", 339379, 0, {265,266,267,},},
	[169]={ "Mortal Combo", 339386, 1, {71,},},
	[170]={ "Rejuvenating Wind", 339399, 2, {253,254,255,},},
	[171]={ "Demonic Momentum", 339411, 0, {265,266,267,},},
	[172]={ "Soul Furnace", 339423, 1, {581,},},
	[173]={ "Resilience of the Hunter", 339459, 2, {253,254,255,},},
	[174]={ "Corrupting Leer", 339455, 1, {265,},},
	[175]={ "Reversal of Fortune", 339495, 0, {253,254,255,},},
	[176]={ "Templar's Vindication", 339531, 1, {70,},},
	[177]={ "Enkindled Spirit", 339570, 1, {65,},},
	[178]={ "Cheetah's Vigor", 339558, 0, {253,254,255,},},
	[179]={ "Demon Muzzle", 339587, 2, {581,},},
	[180]={ "Roaring Fire", 339644, 2, {581,},},
	[181]={ "Tactical Retreat", 339651, 0, {253,254,255,},},
	[182]={ "Virtuous Command", 339518, 1, {70,},},
	[183]={ "Ferocious Appetite", 339704, 1, {253,},},
	[184]={ "Resplendent Light", 339712, 1, {65,},},
	[185]={ "One With the Beast", 339750, 1, {253,},},
	[186]={ "Show of Force", 339818, 1, {73,},},
	[187]={ "Repeat Decree", 339895, 1, {577,581,},},
	[188]={ "Sharpshooter's Focus", 339920, 1, {254,},},
	[189]={ "Brutal Projectiles", 339924, 1, {254,},},
	[190]={ "Destructive Reverberations", 339939, 1, {72,71,73,},},
	[191]={ "Disturb the Peace", 339948, 0, {72,71,73,},},
	[192]={ "Deadly Chain", 339973, 1, {254,},},
	[193]={ "Focused Light", 339984, 1, {65,},},
	[194]={ "Untempered Dedication", 339987, 1, {65,},},
	[195]={ "Vengeful Shock", 340006, 1, {66,},},
	[196]={ "Punish the Guilty", 340012, 1, {66,},},
	[197]={ "Resolute Defender", 340023, 2, {66,},},
	[198]={ "Increased Scrutiny", 340028, 1, {577,581,},},
	[199]={ "Powerful Precision", 340033, 1, {254,},},
	[200]={ "Brooding Pool", 340063, 1, {577,581,},},
	[201]={ "Rolling Agony", 339481, 1, {265,},},
	[202]={ "Focused Malignancy", 339500, 1, {265,},},
	[203]={ "Cold Embrace", 339576, 1, {265,},},
	[204]={ "Borne of Blood", 339578, 1, {266,},},
	[205]={ "Carnivorous Stalkers", 339656, 1, {266,},},
	[206]={ "Tyrant's Soul", 339766, 1, {266,},},
	[207]={ "Fel Commando", 339845, 1, {266,},},
	[208]={ "Duplicitous Havoc", 339890, 1, {267,},},
	[209]={ "Royal Decree", 340030, 2, {66,},},
	[210]={ "The Long Summer", 340185, 1, {65,66,70,},},
	[211]={ "Ashen Remains", 339892, 1, {267,},},
	[212]={ "Combusting Engine", 339896, 1, {267,},},
	[213]={ "Righteous Might", 340192, 1, {65,66,70,},},
	[214]={ "Infernal Brand", 340041, 1, {267,},},
	[215]={ "Hallowed Discernment", 340212, 1, {65,66,70,},},
	[216]={ "Ringing Clarity", 340218, 1, {65,66,70,},},
	[217]={ "Soul Tithe", 340229, 1, {265,266,267,},},
	[218]={ "Fatal Decimation", 340268, 1, {265,266,267,},},
	[219]={ "Catastrophic Origin", 340316, 1, {265,266,267,},},
	[220]={ "Soul Eater", 340348, 1, {265,266,267,},},
	[221]={ "Kilrogg's Cunning", 58081, 0, {265,266,267,},},
	[222]={ "Diabolic Bloodstone", 340562, 2, {265,266,267,},},
	[223]={ "Echoing Call", 340876, 1, {253,},},
	[224]={ "Strength of the Pack", 341222, 1, {255,},},
	[225]={ "Reverberation", 341264, 1, {259,260,261,},},
	[226]={ "Stinging Strike", 341246, 1, {255,},},
	[227]={ "Sudden Fractures", 341272, 1, {259,260,261,},},
	[228]={ "Septic Shock", 341309, 1, {259,260,261,},},
	[229]={ "Lashing Scars", 341310, 1, {259,260,261,},},
	[230]={ "Nimble Fingers", 341311, 2, {259,260,261,},},
	[231]={ "Recuperator", 341312, 2, {259,260,261,},},
	[232]={ "Cloaked in Shadows", 341529, 2, {259,260,261,},},
	[233]={ "Quick Decisions", 341531, 0, {259,260,261,},},
	[234]={ "Fade to Nothing", 341532, 0, {259,260,261,},},
	[235]={ "Rushed Setup", 341534, 0, {259,260,261,},},
	[236]={ "Prepared for All", 341535, 0, {259,260,261,},},
	[237]={ "Poisoned Katar", 341536, 1, {259,},},
	[238]={ "Well-Placed Steel", 341537, 1, {259,},},
	[239]={ "Maim, Mangle", 341538, 1, {259,},},
	[240]={ "Lethal Poisons", 341539, 1, {259,},},
	[241]={ "Triple Threat", 341540, 1, {260,},},
	[242]={ "Ambidexterity", 341542, 1, {260,},},
	[243]={ "Sleight of Hand", 341543, 1, {260,},},
	[244]={ "Count the Odds", 341546, 1, {260,},},
	[245]={ "Deeper Daggers", 341549, 1, {261,},},
	[246]={ "Planned Execution", 341556, 1, {261,},},
	[247]={ "Stiletto Staccato", 341559, 1, {261,},},
	[248]={ "Perforated Veins", 341567, 1, {261,},},
	[249]={ "Controlled Destruction", 341325, 1, {63,},},
	[250]={ "Withering Ground", 341344, 1, {250,251,252,},},
	[251]={ "Deadly Tandem", 341350, 1, {255,},},
	[252]={ "Flame Infusion", 341399, 1, {255,},},
	[253]={ "Bloodletting", 341440, 1, {253,},},
	[254]={ "Tough as Bark", 340529, 2, {102,103,104,105,},},
	[255]={ "Ursine Vigor", 340540, 2, {102,103,104,105,},},
	[256]={ "Innate Resolve", 340543, 2, {102,103,104,105,},},
	[257]={ "Tireless Pursuit", 340545, 0, {102,103,104,105,},},
	[258]={ "Born Anew", 341280, 0, {102,103,104,105,},},
	[259]={ "Front of the Pack", 341450, 0, {102,103,104,105,},},
	[260]={ "Born of the Wilds", 341451, 0, {102,103,104,105,},},
	[261]={ "Stellar Inspiration", 340720, 1, {102,},},
	[262]={ "Precise Alignment", 340706, 1, {102,},},
	[263]={ "Fury of the Skies", 340708, 1, {102,},},
	[264]={ "Umbral Intensity", 340719, 1, {102,},},
	[265]={ "Taste for Blood", 340682, 1, {103,},},
	[266]={ "Incessant Hunter", 340686, 1, {103,},},
	[267]={ "Sudden Ambush", 340694, 1, {103,},},
	[268]={ "Carnivorous Instinct", 340705, 1, {103,},},
	[269]={ "Unchecked Aggression", 340552, 1, {104,},},
	[270]={ "Savage Combatant", 340609, 1, {104,},},
	[271]={ "Well-Honed Instincts", 340553, 2, {104,},},
	[272]={ "Layered Mane", 340605, 2, {104,},},
	[273]={ "Unstoppable Growth", 340549, 1, {105,},},
	[274]={ "Flash of Clarity", 340616, 1, {105,},},
	[275]={ "Floral Recycling", 340621, 1, {105,},},
	[276]={ "Ready for Anything", 340550, 1, {105,},},
	[277]={ "Deep Allegiance", 341378, 1, {102,103,104,105,},},
	[278]={ "Evolved Swarm", 341447, 1, {102,103,104,105,},},
	[279]={ "Conflux of Elements", 341446, 1, {102,103,104,105,},},
	[280]={ "Endless Thirst", 341383, 1, {102,103,104,105,},},
	[281]={ "Unnatural Malice", 344358, 1, {577,581,},},
	[282]={ "Ambuscade", 346747, 0, {253,254,255,},},
}

CovenantForge.Weights ={
	["PreRaid"]={
		[255] ={{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,3,3,1,-7,0,1,0,},{"Enfeebled Mark",0,68,65,72,82,93,92,100,},{"Strength of the Pack",0,45,48,50,63,70,76,84,},{"Stinging Strike",0,33,43,40,49,48,56,61,},{"Combat Meditation (50% Extend) (Pelagos)",58,0,0,0,0,0,0,0,},{"Deadly Tandem",0,18,28,31,27,30,32,34,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",76,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",48,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",62,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",22,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",82,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",133,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,5,0,2,-7,-5,2,-5,},{"Strength of the Pack",0,40,48,52,58,66,70,81,},{"Stinging Strike",0,34,41,36,47,41,53,58,},{"Deadly Tandem",0,23,22,28,29,35,37,31,},{"Empowered Release",0,44,40,42,45,44,46,45,},{"Built for War (Draven)",112,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",107,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",72,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",60,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",47,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",105,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",13,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",39,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,8,6,-1,6,2,6,6,},{"Spirit Attunement",0,70,73,73,77,85,78,80,},{"Deadly Tandem",0,23,27,26,39,36,41,47,},{"Stinging Strike",0,42,46,46,58,58,65,62,},{"Strength of the Pack",0,53,59,62,66,79,83,93,},{"Wild Hunt Tactics (Korayn)",90,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",156,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",123,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",183,0,0,0,0,0,0,0,},{"First Strike (Korayn)",24,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",4,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",46,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",88,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-4,-6,0,-5,-4,-3,-2,},{"Strength of the Pack",0,38,40,51,60,65,74,76,},{"Necrotic Barrage",0,10,14,17,11,17,17,19,},{"Lead by Example (2 Allies) (Emeni)",53,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",25,0,0,0,0,0,0,0,},{"Stinging Strike",0,36,39,51,44,45,54,53,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",67,0,0,0,0,0,0,0,},{"Deadly Tandem",0,17,29,30,35,38,39,44,},{"Forgeborne Reveries (Heirmir)",85,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",83,0,0,0,0,0,0,0,},},},
		[262] ={{{"Power",1,145,158,171,184,200,213,226,},{"Elysian Dirge",0,24,27,22,26,31,35,36,},{"Pyroclastic Shock",0,28,19,26,36,38,42,43,},{"Shake the Foundations",0,-5,2,4,-1,-8,-5,-7,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",72,0,0,0,0,0,0,0,},{"Call of Flame",0,58,59,65,62,63,69,63,},{"Combat Meditation (50% Extend) (Pelagos)",50,0,0,0,0,0,0,0,},{"High Voltage",0,-3,6,-1,4,5,10,2,},{"Combat Meditation (Never Extend) (Pelagos)",30,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",37,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",25,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",81,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",146,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,2,2,3,7,10,7,1,},{"High Voltage",0,5,13,9,9,15,11,11,},{"Shake the Foundations",0,1,2,6,-4,2,8,2,},{"Pyroclastic Shock",0,30,31,28,39,49,39,42,},{"Call of Flame",0,72,64,63,73,72,78,74,},{"Built for War (Draven)",149,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",121,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",62,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",66,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",29,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",93,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",19,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",78,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,28,41,29,30,35,33,38,},{"Pyroclastic Shock",0,32,39,31,38,51,53,56,},{"High Voltage",0,7,4,6,11,6,10,9,},{"Social Butterfly (Dreamweaver)",52,0,0,0,0,0,0,0,},{"Shake the Foundations",0,-5,2,-3,-2,-4,1,-3,},{"Field of Blossoms (Dreamweaver)",79,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",174,0,0,0,0,0,0,0,},{"First Strike (Korayn)",17,0,0,0,0,0,0,0,},{"Call of Flame",0,65,72,72,67,66,71,78,},{"Grove Invigoration (Niya)",110,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-4,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",126,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",116,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,25,30,30,24,26,31,35,},{"High Voltage",0,15,16,13,17,22,13,22,},{"Shake the Foundations",0,7,0,-2,10,0,0,2,},{"Pyroclastic Shock",0,29,33,42,42,45,40,34,},{"Lead by Example (4 Allies) (Emeni)",106,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",70,0,0,0,0,0,0,0,},{"Call of Flame",0,75,80,74,87,82,76,85,},{"Gnashing Chompers (Emeni)",2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",26,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",82,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",39,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",121,0,0,0,0,0,0,0,},},},
		[62] ={{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,13,6,8,6,8,15,14,},{"Magi's Brand",0,68,79,80,92,95,102,110,},{"Pointed Courage (3 Allies) (Kleia)",102,0,0,0,0,0,0,0,},{"Ire of the Ascended",0,62,82,76,89,97,100,103,},{"Arcane Prodigy",0,31,36,34,37,70,68,75,},{"Combat Meditation (Always Extend) (Pelagos)",101,0,0,0,0,0,0,0,},{"Nether Precision",0,27,25,26,29,39,32,33,},{"Combat Meditation (50% Extend) (Pelagos)",95,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",53,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",174,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",25,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",36,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",39,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,5,3,1,0,7,2,6,},{"Magi's Brand",0,62,68,76,85,91,106,103,},{"Nether Precision",0,23,24,20,34,37,25,37,},{"Superior Tactics (Draven)",48,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",21,0,0,0,0,0,0,0,},{"Arcane Prodigy",0,45,56,40,49,85,90,83,},{"Siphoned Malice",0,51,58,65,76,74,89,78,},{"Thrill Seeker (Nadjia)",39,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",44,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",68,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",92,0,0,0,0,0,0,0,},{"Built for War (Draven)",148,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",114,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,-1,5,0,6,4,-1,8,},{"Magi's Brand",0,76,76,89,98,102,103,113,},{"Nether Precision",0,20,20,22,26,35,33,39,},{"Discipline of the Grove",0,14,48,65,72,89,97,93,},{"Niya's Tools: Herbs (Niya)",-8,0,0,0,0,0,0,0,},{"Arcane Prodigy",0,29,29,33,37,31,25,31,},{"Niya's Tools: Poison (Niya)",80,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",158,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",148,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",72,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",22,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",58,0,0,0,0,0,0,0,},{"First Strike (Korayn)",5,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,-2,-1,0,1,-4,2,-5,},{"Gift of the Lich",0,33,40,47,40,50,59,60,},{"Nether Precision",0,25,19,27,25,22,32,36,},{"Arcane Prodigy",0,42,27,39,31,69,77,79,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",10,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",98,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",111,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",188,0,0,0,0,0,0,0,},{"Magi's Brand",0,65,75,77,88,87,94,101,},{"Lead by Example (2 Allies) (Emeni)",124,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",70,0,0,0,0,0,0,0,},},},
		[263] ={{{"Power",1,145,158,171,184,200,213,226,},{"Elysian Dirge",0,22,28,29,37,37,37,38,},{"Chilled to the Core",0,15,18,18,18,33,21,25,},{"Combat Meditation (50% Extend) (Pelagos)",97,0,0,0,0,0,0,0,},{"Focused Lightning",0,14,21,31,33,39,52,54,},{"Combat Meditation (Always Extend) (Pelagos)",119,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",66,0,0,0,0,0,0,0,},{"Magma Fist",0,14,19,17,22,20,20,15,},{"Bron's Call to Action (Mikanikos)",94,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",27,0,0,0,0,0,0,0,},{"Unruly Winds",0,27,38,33,40,42,40,40,},{"Pointed Courage (3 Allies) (Kleia)",90,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",163,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,12,19,19,15,25,12,20,},{"Chilled to the Core",0,27,30,34,35,37,27,30,},{"Magma Fist",0,25,21,26,25,26,31,30,},{"Refined Palate (Theotar)",96,0,0,0,0,0,0,0,},{"Unruly Winds",0,37,42,40,42,42,47,51,},{"Focused Lightning",0,28,30,41,48,49,57,62,},{"Wasteland Propriety (Theotar)",51,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",93,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",113,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",90,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",80,0,0,0,0,0,0,0,},{"Built for War (Draven)",136,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",37,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,14,7,18,19,16,14,20,},{"Chilled to the Core",0,15,16,20,18,19,27,17,},{"Niya's Tools: Burrs (Niya)",165,0,0,0,0,0,0,0,},{"First Strike (Korayn)",36,0,0,0,0,0,0,0,},{"Magma Fist",0,13,10,25,10,15,20,11,},{"Grove Invigoration (Niya)",172,0,0,0,0,0,0,0,},{"Unruly Winds",0,33,26,36,38,37,40,39,},{"Wild Hunt Tactics (Korayn)",106,0,0,0,0,0,0,0,},{"Focused Lightning",0,20,27,28,38,33,44,48,},{"Niya's Tools: Poison (Niya)",131,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-2,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",110,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",54,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,16,15,23,24,26,35,36,},{"Chilled to the Core",0,32,32,33,26,30,34,34,},{"Unruly Winds",0,39,42,41,48,45,44,50,},{"Forgeborne Reveries (Heirmir)",117,0,0,0,0,0,0,0,},{"Magma Fist",0,28,25,31,25,26,40,47,},{"Plaguey's Preemptive Strike (Marileth)",33,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",8,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",90,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",68,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",111,0,0,0,0,0,0,0,},{"Focused Lightning",0,27,38,36,50,49,63,65,},{"Lead by Example (0 Allies) (Emeni)",45,0,0,0,0,0,0,0,},},},
		[64] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ire of the Ascended",0,48,59,59,65,71,87,91,},{"Unrelenting Cold",0,29,33,35,33,30,39,38,},{"Shivering Core",0,0,0,1,3,1,-5,3,},{"Ice Bite",0,72,70,80,89,97,96,109,},{"Combat Meditation (Always Extend) (Pelagos)",71,0,0,0,0,0,0,0,},{"Icy Propulsion",0,168,191,214,224,247,269,290,},{"Combat Meditation (Never Extend) (Pelagos)",40,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",28,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",72,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",126,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",46,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",54,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Siphoned Malice",0,47,61,60,73,80,85,84,},{"Unrelenting Cold",0,20,30,30,35,33,41,44,},{"Shivering Core",0,-3,-6,-7,2,-9,3,-1,},{"Ice Bite",0,72,74,79,89,103,105,119,},{"Built for War (Draven)",131,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",107,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",57,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",68,0,0,0,0,0,0,0,},{"Icy Propulsion",0,189,208,239,256,291,316,341,},{"Soothing Shade (Theotar)",67,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",65,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",19,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",55,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Discipline of the Grove",0,-6,-12,-6,-5,-7,-8,-11,},{"Unrelenting Cold",0,25,24,23,32,26,27,35,},{"Shivering Core",0,-11,-2,-6,-3,-3,-7,-8,},{"Ice Bite",0,61,66,66,76,88,87,93,},{"Wild Hunt Tactics (Korayn)",105,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",97,0,0,0,0,0,0,0,},{"Icy Propulsion",0,170,191,214,239,255,278,314,},{"Field of Blossoms (Dreamweaver)",-9,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-5,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",27,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",185,0,0,0,0,0,0,0,},{"First Strike (Korayn)",8,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",39,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Gift of the Lich",0,22,24,24,30,32,31,33,},{"Shivering Core",0,1,2,2,3,-1,-3,0,},{"Unrelenting Cold",0,24,25,34,34,39,36,42,},{"Forgeborne Reveries (Heirmir)",102,0,0,0,0,0,0,0,},{"Ice Bite",0,73,72,76,87,93,98,102,},{"Icy Propulsion",0,168,191,211,234,254,281,304,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",44,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-4,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",146,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",103,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",60,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",15,0,0,0,0,0,0,0,},},},
		[66] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,59,56,63,70,71,75,82,},{"Punish the Guilty",0,43,51,59,64,64,77,77,},{"Vengeful Shock",0,35,46,42,46,47,49,55,},{"Hammer of Genesis (Mikanikos)",25,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",92,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",22,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",53,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",115,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",69,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",71,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",110,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,82,90,101,105,109,126,130,},{"Punish the Guilty",0,48,51,58,67,71,70,80,},{"Vengeful Shock",0,37,37,45,44,47,57,57,},{"Built for War (Draven)",94,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",13,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",52,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",92,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",66,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",83,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",68,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,5,6,12,13,12,16,14,},{"Punish the Guilty",0,40,47,56,57,61,68,73,},{"Vengeful Shock",0,31,30,37,35,41,44,43,},{"Wild Hunt Tactics (Korayn)",97,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",5,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",81,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",90,0,0,0,0,0,0,0,},{"First Strike (Korayn)",37,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",177,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-2,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",39,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,21,23,28,28,32,34,36,},{"Punish the Guilty",0,44,52,53,60,64,69,75,},{"Vengeful Shock",0,30,28,32,36,35,40,38,},{"Lead by Example (0 Allies) (Emeni)",17,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",15,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",59,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",49,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",26,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",62,0,0,0,0,0,0,0,},},},
		[70] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,108,117,122,132,145,159,165,},{"Expurgation",0,84,92,98,110,121,127,136,},{"Truth's Wake",0,18,19,28,25,20,20,26,},{"Virtuous Command",0,122,136,145,164,175,179,200,},{"Pointed Courage (5 Allies) (Kleia)",148,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",9,0,0,0,0,0,0,0,},{"Templar's Vindication",0,106,120,134,143,145,166,178,},{"Combat Meditation (Always Extend) (Pelagos)",128,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",101,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",68,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",29,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",91,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",66,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,70,80,83,87,95,111,113,},{"Truth's Wake",0,16,8,15,19,22,13,21,},{"Expurgation",0,83,88,105,106,115,123,139,},{"Dauntless Duelist (Nadjia)",107,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",57,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",74,0,0,0,0,0,0,0,},{"Templar's Vindication",0,114,109,132,130,152,161,162,},{"Virtuous Command",0,102,116,127,136,152,164,173,},{"Soothing Shade (Theotar)",76,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-9,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",13,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",88,0,0,0,0,0,0,0,},{"Built for War (Draven)",110,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,24,23,18,31,31,33,32,},{"Truth's Wake",0,13,17,20,22,27,30,26,},{"Expurgation",0,90,93,108,108,123,129,137,},{"Virtuous Command",0,118,131,134,151,164,179,192,},{"Social Butterfly (Dreamweaver)",52,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",112,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",3,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",69,0,0,0,0,0,0,0,},{"Templar's Vindication",0,118,122,135,148,162,165,187,},{"Niya's Tools: Burrs (Niya)",174,0,0,0,0,0,0,0,},{"First Strike (Korayn)",9,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",125,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,17,22,28,23,23,27,25,},{"Expurgation",0,89,99,109,109,120,130,136,},{"Plaguey's Preemptive Strike (Marileth)",21,0,0,0,0,0,0,0,},{"Virtuous Command",0,105,118,130,142,149,165,173,},{"Truth's Wake",0,24,22,31,33,29,29,35,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",80,0,0,0,0,0,0,0,},{"Templar's Vindication",0,103,118,132,152,152,163,169,},{"Forgeborne Reveries (Heirmir)",84,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",70,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",46,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",25,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},},},
		[72] ={{{"Power",1,145,158,171,184,200,213,226,},{"Piercing Verdict",0,21,22,31,28,33,24,32,},{"Depths of Insanity",0,35,33,31,36,43,44,50,},{"Ashen Juggernaut",0,60,73,86,88,89,104,110,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",104,0,0,0,0,0,0,0,},{"Hack and Slash",0,15,17,23,28,34,34,41,},{"Bron's Call to Action (Mikanikos)",66,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",24,0,0,0,0,0,0,0,},{"Vicious Contempt",0,25,22,22,32,34,43,37,},{"Pointed Courage (3 Allies) (Kleia)",91,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",150,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",60,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",77,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Harrowing Punishment",0,10,16,13,9,15,17,24,},{"Depths of Insanity",0,33,30,40,46,44,51,51,},{"Refined Palate (Theotar)",111,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,70,74,84,-364,99,101,113,},{"Dauntless Duelist (Nadjia)",110,0,0,0,0,0,0,0,},{"Vicious Contempt",0,28,28,39,36,42,42,46,},{"Thrill Seeker (Nadjia)",88,0,0,0,0,0,0,0,},{"Hack and Slash",0,19,16,22,17,23,25,28,},{"Soothing Shade (Theotar)",74,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",29,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-2,0,0,0,0,0,0,0,},{"Built for War (Draven)",104,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,14,22,24,23,26,31,34,},{"Ashen Juggernaut",0,68,81,84,90,96,107,114,},{"Grove Invigoration (Niya)",130,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",91,0,0,0,0,0,0,0,},{"Depths of Insanity",0,39,44,42,49,50,50,55,},{"Niya's Tools: Poison (Niya)",-4,0,0,0,0,0,0,0,},{"Vicious Contempt",0,25,31,34,34,37,41,45,},{"Field of Blossoms (Dreamweaver)",88,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",165,0,0,0,0,0,0,0,},{"First Strike (Korayn)",19,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-2,0,0,0,0,0,0,0,},{"Hack and Slash",0,26,22,23,27,39,31,34,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Veteran's Repute",0,47,55,58,54,62,71,75,},{"Depths of Insanity",0,41,49,42,58,56,62,63,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",87,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,79,86,92,101,102,115,123,},{"Forgeborne Reveries (Heirmir)",76,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",1,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",1,0,0,0,0,0,0,0,},{"Vicious Contempt",0,37,36,38,44,37,42,46,},{"Hack and Slash",0,29,29,28,33,41,39,42,},{"Lead by Example (0 Allies) (Emeni)",1,0,0,0,0,0,0,0,},},},
		[578] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,39,45,50,54,57,63,64,},{"Soul Furnace",0,14,18,20,23,25,26,26,},{"Pointed Courage (5 Allies) (Kleia)",91,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",58,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",19,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",49,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",48,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",60,0,0,0,0,0,0,0,},{"Growing Inferno",0,24,24,31,32,38,35,39,},{"Combat Meditation (Always Extend) (Pelagos)",77,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,24,29,29,30,34,36,34,},{"Soul Furnace",0,19,24,26,26,28,29,31,},{"Exacting Preparation (Nadjia)",17,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",35,0,0,0,0,0,0,0,},{"Growing Inferno",0,27,32,30,37,40,42,46,},{"Soothing Shade (Theotar)",44,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",39,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",71,0,0,0,0,0,0,0,},{"Built for War (Draven)",62,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",43,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",105,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,30,32,34,37,40,41,42,},{"Soul Furnace",0,14,19,16,18,23,23,28,},{"Grove Invigoration (Niya)",63,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",32,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",79,0,0,0,0,0,0,0,},{"First Strike (Korayn)",34,0,0,0,0,0,0,0,},{"Growing Inferno",0,25,25,27,29,33,31,33,},{"Niya's Tools: Burrs (Niya)",150,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",45,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",46,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",69,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,2,3,10,8,13,16,22,},{"Soul Furnace",0,8,16,18,19,23,25,27,},{"Lead by Example (0 Allies) (Emeni)",13,0,0,0,0,0,0,0,},{"Growing Inferno",0,19,26,27,27,35,36,36,},{"Lead by Example (2 Allies) (Emeni)",29,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",45,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",6,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-8,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",50,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",38,0,0,0,0,0,0,0,},},},
		[265] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,-1,-1,-1,-1,0,-2,-1,},{"Cold Embrace",0,91,95,106,113,127,133,138,},{"Corrupting Leer",0,16,16,24,27,17,19,24,},{"Focused Malignancy",0,150,166,178,200,208,222,241,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",140,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",112,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",79,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",29,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",33,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",157,0,0,0,0,0,0,0,},{"Rolling Agony",0,23,25,26,21,36,22,23,},{"Pointed Courage (3 Allies) (Kleia)",93,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,39,51,54,49,53,59,62,},{"Corrupting Leer",0,-44,-39,-39,-37,-38,-28,-20,},{"Focused Malignancy",0,127,133,152,167,184,191,202,},{"Cold Embrace",0,94,87,99,106,113,125,137,},{"Rolling Agony",0,22,23,11,19,14,19,22,},{"Thrill Seeker (Nadjia)",89,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",56,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",110,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",93,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",4,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",18,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",46,0,0,0,0,0,0,0,},{"Built for War (Draven)",138,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,50,59,59,63,63,71,78,},{"Corrupting Leer",0,-6,-7,0,-9,1,-5,0,},{"Cold Embrace",0,82,90,109,114,127,129,142,},{"Niya's Tools: Poison (Niya)",4,0,0,0,0,0,0,0,},{"Focused Malignancy",0,140,147,163,172,187,211,223,},{"Field of Blossoms (Dreamweaver)",112,0,0,0,0,0,0,0,},{"Rolling Agony",0,13,10,10,12,19,11,9,},{"Niya's Tools: Burrs (Niya)",177,0,0,0,0,0,0,0,},{"First Strike (Korayn)",3,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",0,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",55,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",155,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",118,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,56,56,70,63,72,20,78,},{"Corrupting Leer",0,14,15,15,19,19,24,30,},{"Cold Embrace",0,83,96,103,115,121,124,139,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",86,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",115,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",4,0,0,0,0,0,0,0,},{"Rolling Agony",0,13,12,2,12,11,12,13,},{"Lead by Example (4 Allies) (Emeni)",80,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},{"Focused Malignancy",0,134,142,152,168,176,193,198,},{"Lead by Example (2 Allies) (Emeni)",58,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",29,0,0,0,0,0,0,0,},},},
		[577] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,21,17,31,31,31,41,48,},{"Growing Inferno",0,68,72,77,86,96,100,102,},{"Relentless Onslaught",0,62,67,63,78,84,91,94,},{"Dancing with Fate",0,7,8,13,13,11,9,10,},{"Serrated Glaive",0,0,0,-1,6,5,8,8,},{"Combat Meditation (Always Extend) (Pelagos)",82,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",58,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",38,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",32,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",77,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",135,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",80,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,-1,-6,1,-1,-10,2,-5,},{"Growing Inferno",0,63,65,72,76,90,86,98,},{"Relentless Onslaught",0,58,58,64,66,70,89,91,},{"Serrated Glaive",0,1,-2,0,2,1,-3,-3,},{"Dancing with Fate",0,0,6,7,8,13,5,6,},{"Refined Palate (Theotar)",123,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",38,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",12,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",79,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",106,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",60,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",55,0,0,0,0,0,0,0,},{"Built for War (Draven)",107,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,36,33,37,44,51,42,49,},{"Growing Inferno",0,73,74,84,88,86,100,104,},{"Niya's Tools: Herbs (Niya)",0,0,0,0,0,0,0,0,},{"Relentless Onslaught",0,57,58,70,78,85,89,95,},{"Niya's Tools: Poison (Niya)",160,0,0,0,0,0,0,0,},{"Dancing with Fate",0,7,12,11,8,14,10,19,},{"Serrated Glaive",0,15,1,10,5,6,1,6,},{"Niya's Tools: Burrs (Niya)",197,0,0,0,0,0,0,0,},{"First Strike (Korayn)",15,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",53,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",93,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",103,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",119,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,2,11,21,28,38,48,66,},{"Relentless Onslaught",0,61,64,65,76,81,85,95,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",104,0,0,0,0,0,0,0,},{"Serrated Glaive",0,4,11,4,10,-2,11,3,},{"Gnashing Chompers (Emeni)",-8,0,0,0,0,0,0,0,},{"Dancing with Fate",0,-1,4,6,11,5,9,6,},{"Growing Inferno",0,63,65,82,88,97,98,102,},{"Lead by Example (2 Allies) (Emeni)",57,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",35,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",84,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",87,0,0,0,0,0,0,0,},},},
		[253] ={{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,12,21,21,31,30,23,36,},{"Ferocious Appetite",0,-9,-6,-3,1,5,5,9,},{"One With the Beast",0,15,24,28,37,45,54,63,},{"Enfeebled Mark",0,77,86,83,105,107,116,121,},{"Hammer of Genesis (Mikanikos)",7,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",114,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",75,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",101,0,0,0,0,0,0,0,},{"Echoing Call",0,0,-1,-3,3,-3,-4,-4,},{"Pointed Courage (1 Ally) (Kleia)",29,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",79,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",126,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",48,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,22,26,25,26,33,30,36,},{"Empowered Release",0,30,27,27,30,26,28,25,},{"Ferocious Appetite",0,1,5,1,1,8,12,13,},{"Echoing Call",0,7,4,6,7,3,3,6,},{"One With the Beast",0,19,27,38,45,52,62,66,},{"Built for War (Draven)",116,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",118,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",67,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",76,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",7,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",10,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",43,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",67,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,35,29,28,36,37,29,42,},{"Ferocious Appetite",0,-28,-26,-18,-19,-18,-15,-7,},{"One With the Beast",0,18,14,27,34,55,61,63,},{"Echoing Call",0,-1,3,1,5,11,4,4,},{"Spirit Attunement",0,63,67,68,72,78,84,84,},{"Wild Hunt Tactics (Korayn)",55,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",109,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",178,0,0,0,0,0,0,0,},{"First Strike (Korayn)",7,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",123,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",127,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-5,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,11,21,18,22,27,20,20,},{"Necrotic Barrage",0,10,6,10,12,17,13,20,},{"Echoing Call",0,-8,-5,-3,-4,1,-8,-3,},{"Lead by Example (2 Allies) (Emeni)",50,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",28,0,0,0,0,0,0,0,},{"One With the Beast",0,7,13,30,32,37,45,49,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",75,0,0,0,0,0,0,0,},{"Ferocious Appetite",0,-7,-10,-1,-2,-2,-4,7,},{"Gnashing Chompers (Emeni)",-4,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",76,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",83,0,0,0,0,0,0,0,},},},
		[258] ={{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,132,136,142,152,157,151,163,},{"Courageous Ascension",0,62,78,84,84,99,97,114,},{"Rabid Shadows",0,12,21,21,18,28,39,30,},{"Mind Devourer",0,56,53,54,58,57,64,66,},{"Haunting Apparitions",0,56,67,68,75,61,88,90,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",226,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",178,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",32,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",51,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",112,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",195,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",199,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,142,146,149,161,172,163,174,},{"Haunting Apparitions",0,69,75,81,82,75,106,99,},{"Rabid Shadows",0,18,32,37,36,38,46,42,},{"Shattered Perceptions",0,24,31,37,40,42,36,36,},{"Exacting Preparation (Nadjia)",19,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",7,0,0,0,0,0,0,0,},{"Mind Devourer",0,70,62,74,69,74,62,68,},{"Built for War (Draven)",147,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",118,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",86,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",91,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",99,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",47,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,142,148,159,153,163,171,180,},{"Fae Fermata",0,-8,-6,-8,-1,-5,-3,-1,},{"Rabid Shadows",0,10,18,32,27,27,27,29,},{"Haunting Apparitions",0,66,66,76,77,74,93,105,},{"Wild Hunt Tactics (Korayn)",118,0,0,0,0,0,0,0,},{"Mind Devourer",0,54,57,64,69,60,56,74,},{"Niya's Tools: Poison (Niya)",-4,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",115,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",159,0,0,0,0,0,0,0,},{"First Strike (Korayn)",2,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-10,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",54,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",155,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,136,144,148,151,163,164,176,},{"Festering Transfusion",0,38,51,48,50,53,45,51,},{"Mind Devourer",0,56,58,62,64,70,69,71,},{"Haunting Apparitions",0,68,69,79,71,73,102,99,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",118,0,0,0,0,0,0,0,},{"Rabid Shadows",0,9,20,29,29,36,41,41,},{"Forgeborne Reveries (Heirmir)",109,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",7,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",101,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",70,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",38,0,0,0,0,0,0,0,},},},
		[266] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,-6,2,-6,-5,-5,-5,-3,},{"Fel Commando",0,57,62,70,77,78,82,87,},{"Tyrant's Soul",0,56,67,67,73,72,75,88,},{"Borne of Blood",0,74,75,86,87,102,103,111,},{"Carnivorous Stalkers",0,37,40,47,51,51,59,59,},{"Bron's Call to Action (Mikanikos)",32,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",28,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",103,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",138,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",83,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",66,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",77,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,22,30,26,30,30,29,31,},{"Fel Commando",0,55,66,69,77,84,93,93,},{"Borne of Blood",0,78,80,90,98,99,108,121,},{"Tyrant's Soul",0,60,64,70,77,78,78,86,},{"Exacting Preparation (Nadjia)",16,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,42,46,47,51,54,63,63,},{"Dauntless Duelist (Nadjia)",94,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",51,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",41,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",76,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",50,0,0,0,0,0,0,0,},{"Built for War (Draven)",118,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,25,27,33,34,35,40,45,},{"Fel Commando",0,55,65,68,72,79,87,91,},{"Borne of Blood",0,72,75,84,95,104,106,115,},{"Tyrant's Soul",0,63,68,70,71,77,84,81,},{"Niya's Tools: Burrs (Niya)",170,0,0,0,0,0,0,0,},{"First Strike (Korayn)",6,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,40,44,43,53,62,60,59,},{"Niya's Tools: Poison (Niya)",2,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",103,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",113,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",45,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",31,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,46,45,54,62,58,14,66,},{"Fel Commando",0,56,64,66,73,84,88,96,},{"Tyrant's Soul",0,62,67,73,72,73,82,86,},{"Borne of Blood",0,69,79,80,93,102,109,109,},{"Plaguey's Preemptive Strike (Marileth)",5,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",69,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,46,45,52,48,59,62,73,},{"Forgeborne Reveries (Heirmir)",100,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",91,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",33,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",47,0,0,0,0,0,0,0,},},},
		[104] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,13,11,4,14,12,13,16,},{"Savage Combatant",0,67,69,78,85,95,96,103,},{"Pointed Courage (5 Allies) (Kleia)",94,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,45,49,56,60,65,64,72,},{"Pointed Courage (3 Allies) (Kleia)",50,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",16,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",131,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",51,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",70,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",42,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,27,32,32,33,32,38,41,},{"Savage Combatant",0,77,88,93,104,107,112,121,},{"Wasteland Propriety (Theotar)",40,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,67,79,79,85,92,100,99,},{"Soothing Shade (Theotar)",46,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",38,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",42,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",73,0,0,0,0,0,0,0,},{"Built for War (Draven)",68,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",5,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",17,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,55,58,63,66,71,77,87,},{"Savage Combatant",0,61,65,73,83,87,89,98,},{"Grove Invigoration (Niya)",104,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",33,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",42,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-3,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",75,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,40,37,48,52,58,63,66,},{"Niya's Tools: Burrs (Niya)",182,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",92,0,0,0,0,0,0,0,},{"First Strike (Korayn)",38,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,33,41,41,53,52,55,57,},{"Savage Combatant",0,71,74,79,83,91,98,104,},{"Lead by Example (4 Allies) (Emeni)",35,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",16,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,56,63,64,69,76,79,77,},{"Plaguey's Preemptive Strike (Marileth)",15,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",29,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",60,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",57,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},},},
		[103] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,-11,-14,-11,-15,-4,-9,-1,},{"Taste for Blood",0,68,78,82,90,101,104,111,},{"Bron's Call to Action (Mikanikos)",61,0,0,0,0,0,0,0,},{"Incessant Hunter",0,28,34,33,34,35,44,42,},{"Sudden Ambush",0,72,72,81,87,101,102,107,},{"Pointed Courage (5 Allies) (Kleia)",171,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",25,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",133,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",107,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",47,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",112,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",150,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,55,64,68,68,77,81,84,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,29,30,39,44,41,46,44,},{"Taste for Blood",0,58,66,69,76,87,90,92,},{"Incessant Hunter",0,17,20,25,20,27,25,34,},{"Dauntless Duelist (Nadjia)",101,0,0,0,0,0,0,0,},{"Built for War (Draven)",104,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",68,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",63,0,0,0,0,0,0,0,},{"Sudden Ambush",0,50,61,64,75,81,90,88,},{"Refined Palate (Theotar)",58,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",83,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,48,36,47,53,66,55,64,},{"Superior Tactics (Draven)",-6,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",11,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,62,61,73,78,82,86,101,},{"Taste for Blood",0,77,79,95,100,107,117,125,},{"Incessant Hunter",0,20,16,24,24,28,24,37,},{"Sudden Ambush",0,63,63,76,80,78,86,94,},{"Carnivorous Instinct",0,51,53,58,71,74,75,87,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",157,0,0,0,0,0,0,0,},{"First Strike (Korayn)",11,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",169,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",121,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",64,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",52,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,40,38,45,50,54,58,65,},{"Incessant Hunter",0,30,25,23,27,31,32,32,},{"Taste for Blood",0,60,66,80,83,83,90,87,},{"Sudden Ambush",0,69,80,78,85,98,99,107,},{"Lead by Example (4 Allies) (Emeni)",60,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",93,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",110,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",23,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,50,41,56,61,62,70,73,},{"Lead by Example (0 Allies) (Emeni)",22,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",49,0,0,0,0,0,0,0,},},},
		[259] ={{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,48,52,53,59,62,73,69,},{"Maim, Mangle",0,35,35,46,43,51,49,60,},{"Bron's Call to Action (Mikanikos)",41,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",86,0,0,0,0,0,0,0,},{"Poisoned Katar",0,-4,0,0,-2,-2,2,3,},{"Combat Meditation (Never Extend) (Pelagos)",63,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,51,58,59,69,74,72,83,},{"Combat Meditation (Always Extend) (Pelagos)",104,0,0,0,0,0,0,0,},{"Reverberation",0,37,50,47,51,62,63,67,},{"Pointed Courage (1 Ally) (Kleia)",31,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",91,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",152,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,51,57,56,58,60,68,68,},{"Maim, Mangle",0,33,36,44,46,47,52,61,},{"Lashing Scars",0,40,47,53,47,47,56,51,},{"Poisoned Katar",0,4,-1,-1,-1,-4,-3,2,},{"Refined Palate (Theotar)",98,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,41,54,59,59,66,71,79,},{"Exacting Preparation (Nadjia)",31,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",113,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",109,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",73,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",41,0,0,0,0,0,0,0,},{"Built for War (Draven)",109,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",66,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,47,56,54,64,67,70,78,},{"Maim, Mangle",0,37,42,47,45,53,55,65,},{"Wild Hunt Tactics (Korayn)",100,0,0,0,0,0,0,0,},{"Poisoned Katar",0,8,8,5,6,11,5,4,},{"Niya's Tools: Poison (Niya)",172,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,57,60,62,75,82,83,96,},{"Niya's Tools: Burrs (Niya)",192,0,0,0,0,0,0,0,},{"First Strike (Korayn)",12,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",130,0,0,0,0,0,0,0,},{"Septic Shock",0,29,35,40,49,59,53,68,},{"Grove Invigoration (Niya)",111,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",101,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",59,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,45,50,57,60,67,68,75,},{"Well-Placed Steel",0,44,51,55,66,74,78,79,},{"Poisoned Katar",0,0,-2,0,1,-2,-3,-4,},{"Forgeborne Reveries (Heirmir)",86,0,0,0,0,0,0,0,},{"Maim, Mangle",0,28,35,35,47,46,48,46,},{"Sudden Fractures",0,34,40,42,47,54,57,54,},{"Lead by Example (4 Allies) (Emeni)",77,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",13,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",59,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",35,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",103,0,0,0,0,0,0,0,},},},
		[267] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,-3,1,3,-3,-7,0,0,},{"Duplicitous Havoc",0,-9,-3,-6,-8,-4,-6,-5,},{"Ashen Remains",0,34,41,52,45,52,55,63,},{"Combat Meditation (Always Extend) (Pelagos)",109,0,0,0,0,0,0,0,},{"Infernal Brand",0,25,30,38,41,36,46,41,},{"Hammer of Genesis (Mikanikos)",3,0,0,0,0,0,0,0,},{"Combusting Engine",0,33,39,48,51,48,56,56,},{"Combat Meditation (50% Extend) (Pelagos)",90,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",63,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",26,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",30,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",85,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",141,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,23,32,34,28,38,30,38,},{"Combusting Engine",0,38,42,49,52,58,59,56,},{"Refined Palate (Theotar)",57,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,0,-1,1,0,-2,2,2,},{"Ashen Remains",0,36,47,47,48,62,60,61,},{"Dauntless Duelist (Nadjia)",105,0,0,0,0,0,0,0,},{"Infernal Brand",0,36,34,36,39,41,49,48,},{"Exacting Preparation (Nadjia)",13,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Built for War (Draven)",129,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",78,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",80,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",46,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,25,26,27,33,36,38,39,},{"Combusting Engine",0,36,44,40,50,49,53,62,},{"Duplicitous Havoc",0,-5,1,-3,5,-10,-2,-2,},{"Niya's Tools: Poison (Niya)",4,0,0,0,0,0,0,0,},{"Ashen Remains",0,45,48,45,55,59,64,61,},{"Infernal Brand",0,25,39,34,38,41,44,50,},{"Wild Hunt Tactics (Korayn)",104,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",125,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",3,0,0,0,0,0,0,0,},{"First Strike (Korayn)",21,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",166,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",85,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,51,44,53,62,60,14,63,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",76,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,3,2,8,-1,2,8,2,},{"Ashen Remains",0,52,55,56,64,63,75,77,},{"Lead by Example (4 Allies) (Emeni)",103,0,0,0,0,0,0,0,},{"Infernal Brand",0,30,33,45,41,49,50,55,},{"Forgeborne Reveries (Heirmir)",101,0,0,0,0,0,0,0,},{"Combusting Engine",0,43,41,49,62,61,59,69,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",71,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",32,0,0,0,0,0,0,0,},},},
		[250] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,49,48,52,60,62,64,65,},{"Debilitating Malady",0,0,6,1,3,4,3,6,},{"Withering Plague",0,17,17,19,22,21,22,27,},{"Bron's Call to Action (Mikanikos)",44,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",37,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",53,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",60,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",5,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",58,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",97,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",20,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,11,12,10,13,14,12,14,},{"Debilitating Malady",0,1,5,1,-3,3,2,3,},{"Wasteland Propriety (Theotar)",21,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",-1,0,0,0,0,0,0,0,},{"Withering Plague",0,14,18,17,22,19,17,18,},{"Refined Palate (Theotar)",96,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",35,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",58,0,0,0,0,0,0,0,},{"Built for War (Draven)",63,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",1,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",43,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,43,45,48,51,56,61,62,},{"Debilitating Malady",0,2,-1,1,0,-4,2,1,},{"Grove Invigoration (Niya)",59,0,0,0,0,0,0,0,},{"Withering Plague",0,13,19,18,20,17,21,22,},{"Niya's Tools: Herbs (Niya)",20,0,0,0,0,0,0,0,},{"First Strike (Korayn)",17,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",180,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",53,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",64,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",27,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,12,12,15,16,16,16,16,},{"Debilitating Malady",0,6,2,3,2,2,4,3,},{"Lead by Example (0 Allies) (Emeni)",23,0,0,0,0,0,0,0,},{"Withering Plague",0,16,19,23,22,26,25,32,},{"Plaguey's Preemptive Strike (Marileth)",9,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",47,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",48,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",38,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",55,0,0,0,0,0,0,0,},},},
		[254] ={{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,22,27,32,41,44,48,61,},{"Brutal Projectiles",0,-1,5,2,2,10,2,4,},{"Enfeebled Mark",0,91,96,110,124,127,128,151,},{"Sharpshooter's Focus",0,34,41,39,51,49,55,58,},{"Deadly Chain",0,-3,3,-5,-3,3,-9,1,},{"Combat Meditation (50% Extend) (Pelagos)",136,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",164,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",99,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",48,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",32,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",161,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",95,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,15,24,29,32,38,47,46,},{"Brutal Projectiles",0,3,-4,-3,0,4,7,-4,},{"Empowered Release",0,41,41,36,44,46,37,42,},{"Deadly Chain",0,-15,-4,-6,-1,-7,-2,-5,},{"Sharpshooter's Focus",0,25,30,41,45,42,45,57,},{"Built for War (Draven)",112,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",114,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",65,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",57,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",78,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-6,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",22,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",30,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,24,28,30,40,50,49,51,},{"Spirit Attunement",0,94,91,102,111,109,112,118,},{"Sharpshooter's Focus",0,33,40,42,49,52,52,55,},{"Wild Hunt Tactics (Korayn)",146,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",124,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",159,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,1,-3,-3,0,5,9,-5,},{"Niya's Tools: Burrs (Niya)",154,0,0,0,0,0,0,0,},{"First Strike (Korayn)",10,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",52,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",207,0,0,0,0,0,0,0,},{"Deadly Chain",0,-8,-3,-11,-2,-6,-3,-1,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,26,35,44,39,54,60,61,},{"Necrotic Barrage",0,30,32,30,39,43,52,48,},{"Brutal Projectiles",0,9,12,6,6,1,6,19,},{"Deadly Chain",0,6,7,9,1,5,14,8,},{"Lead by Example (2 Allies) (Emeni)",66,0,0,0,0,0,0,0,},{"Sharpshooter's Focus",0,49,42,47,52,61,64,57,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",111,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",98,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",41,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",40,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",105,0,0,0,0,0,0,0,},},},
		[260] ={{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,125,149,156,169,186,195,203,},{"Sleight of Hand",0,44,39,49,57,57,63,63,},{"Reverberation",0,45,44,45,53,57,61,71,},{"Ambidexterity",0,1,4,-2,4,0,-10,-5,},{"Combat Meditation (Never Extend) (Pelagos)",40,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",69,0,0,0,0,0,0,0,},{"Triple Threat",0,33,41,39,54,60,59,55,},{"Combat Meditation (Always Extend) (Pelagos)",96,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",26,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",87,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",145,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-1,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",109,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,127,140,156,175,189,204,211,},{"Sleight of Hand",0,42,43,52,61,67,65,73,},{"Lashing Scars",0,41,55,57,60,58,60,68,},{"Triple Threat",0,33,47,45,53,51,63,69,},{"Ambidexterity",0,1,-1,-4,-4,-5,-1,2,},{"Wasteland Propriety (Theotar)",44,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",70,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",37,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",107,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",119,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",114,0,0,0,0,0,0,0,},{"Built for War (Draven)",131,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",82,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,130,145,162,174,194,206,221,},{"Sleight of Hand",0,58,58,59,65,72,74,73,},{"Septic Shock",0,27,36,41,53,52,65,64,},{"Triple Threat",0,44,51,55,55,54,66,69,},{"Ambidexterity",0,2,4,0,4,-2,-3,4,},{"Wild Hunt Tactics (Korayn)",120,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",94,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",226,0,0,0,0,0,0,0,},{"First Strike (Korayn)",19,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",197,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",123,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",63,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",108,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,116,136,144,161,177,190,197,},{"Lead by Example (0 Allies) (Emeni)",30,0,0,0,0,0,0,0,},{"Sleight of Hand",0,36,39,44,58,57,59,62,},{"Plaguey's Preemptive Strike (Marileth)",12,0,0,0,0,0,0,0,},{"Sudden Fractures",0,25,28,29,29,34,48,36,},{"Forgeborne Reveries (Heirmir)",92,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",73,0,0,0,0,0,0,0,},{"Ambidexterity",0,-5,-8,-4,-1,-5,2,-2,},{"Triple Threat",0,37,33,46,41,48,64,59,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",84,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-6,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",49,0,0,0,0,0,0,0,},},},
		[71] ={{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,54,53,58,67,70,69,81,},{"Ashen Juggernaut",0,96,104,110,116,130,144,151,},{"Piercing Verdict",0,17,25,23,32,28,29,34,},{"Crash the Ramparts",0,34,44,39,43,52,56,57,},{"Merciless Bonegrinder",0,2,0,-6,4,7,5,4,},{"Hammer of Genesis (Mikanikos)",12,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",99,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",78,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",130,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",59,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",27,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",63,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",79,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,31,43,39,34,43,53,56,},{"Crash the Ramparts",0,18,27,25,33,32,32,47,},{"Ashen Juggernaut",0,96,116,122,129,142,150,163,},{"Dauntless Duelist (Nadjia)",104,0,0,0,0,0,0,0,},{"Built for War (Draven)",106,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",55,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",83,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",67,0,0,0,0,0,0,0,},{"Harrowing Punishment",0,19,25,27,22,29,22,29,},{"Merciless Bonegrinder",0,-4,-5,-9,-3,-3,-1,-1,},{"Superior Tactics (Draven)",-3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",5,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-8,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,4,13,15,19,21,18,34,},{"Crash the Ramparts",0,33,43,43,37,42,48,55,},{"Ashen Juggernaut",0,88,101,113,117,133,132,147,},{"Merciless Bonegrinder",0,1,5,6,2,-4,0,-1,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",128,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",77,0,0,0,0,0,0,0,},{"Mortal Combo",0,52,49,56,66,64,77,73,},{"Niya's Tools: Burrs (Niya)",156,0,0,0,0,0,0,0,},{"First Strike (Korayn)",25,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",2,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",84,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-2,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,50,53,60,66,73,75,82,},{"Ashen Juggernaut",0,108,123,123,138,141,158,171,},{"Veteran's Repute",0,48,61,59,70,74,77,77,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",72,0,0,0,0,0,0,0,},{"Crash the Ramparts",0,36,42,41,48,47,55,57,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",15,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",3,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",2,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",0,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",78,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,1,-1,2,0,-4,4,-4,},},},
		[73] ={{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,3,3,2,2,8,4,6,},{"Piercing Verdict",0,10,14,8,12,16,22,18,},{"Ashen Juggernaut",0,19,19,19,22,26,28,25,},{"Bron's Call to Action (Mikanikos)",61,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",10,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",103,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",111,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",61,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",141,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",80,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",17,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,1,1,2,4,5,4,10,},{"Harrowing Punishment",0,11,11,12,10,16,16,12,},{"Ashen Juggernaut",0,22,27,28,32,33,31,40,},{"Dauntless Duelist (Nadjia)",74,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",2,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",8,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",109,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",52,0,0,0,0,0,0,0,},{"Built for War (Draven)",70,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",103,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-1,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,14,18,25,25,27,29,38,},{"Show of Force",0,-3,0,-4,1,-3,1,0,},{"Ashen Juggernaut",0,15,16,19,17,17,19,22,},{"Wild Hunt Tactics (Korayn)",65,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",32,0,0,0,0,0,0,0,},{"First Strike (Korayn)",23,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",137,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",51,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",2,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",151,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,0,3,-3,3,1,5,5,},{"Veteran's Repute",0,29,36,35,40,38,40,46,},{"Ashen Juggernaut",0,19,19,21,25,23,24,28,},{"Plaguey's Preemptive Strike (Marileth)",16,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",5,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",54,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",5,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",5,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",-2,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",50,0,0,0,0,0,0,0,},},},
		[102] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,-8,-7,-2,-7,-8,-5,-9,},{"Stellar Inspiration",0,25,24,30,29,36,36,42,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Precise Alignment",0,27,34,31,40,39,39,47,},{"Umbral Intensity",0,38,32,44,44,51,49,65,},{"Combat Meditation (Always Extend) (Pelagos)",176,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",166,0,0,0,0,0,0,0,},{"Fury of the Skies",0,48,54,62,69,76,84,95,},{"Combat Meditation (Never Extend) (Pelagos)",152,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",54,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",80,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",149,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",26,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,60,72,77,83,92,93,106,},{"Stellar Inspiration",0,26,28,28,36,35,42,44,},{"Refined Palate (Theotar)",66,0,0,0,0,0,0,0,},{"Fury of the Skies",0,59,71,75,81,84,95,99,},{"Built for War (Draven)",152,0,0,0,0,0,0,0,},{"Precise Alignment",0,43,42,41,53,66,70,87,},{"Wasteland Propriety (Theotar)",90,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",83,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",88,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",2,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",30,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",120,0,0,0,0,0,0,0,},{"Umbral Intensity",0,48,52,57,60,65,83,62,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,105,111,123,136,147,150,168,},{"Stellar Inspiration",0,28,27,41,39,48,48,51,},{"Wild Hunt Tactics (Korayn)",131,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",100,0,0,0,0,0,0,0,},{"Fury of the Skies",0,62,67,68,83,92,99,92,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Umbral Intensity",0,41,44,48,49,53,59,71,},{"Grove Invigoration (Niya)",250,0,0,0,0,0,0,0,},{"Precise Alignment",0,-1,-5,6,12,17,18,21,},{"Social Butterfly (Dreamweaver)",44,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",168,0,0,0,0,0,0,0,},{"First Strike (Korayn)",9,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,50,57,60,65,69,78,76,},{"Precise Alignment",0,33,50,48,39,52,50,58,},{"Plaguey's Preemptive Strike (Marileth)",20,0,0,0,0,0,0,0,},{"Stellar Inspiration",0,30,28,31,35,39,45,48,},{"Gnashing Chompers (Emeni)",13,0,0,0,0,0,0,0,},{"Fury of the Skies",0,61,71,67,87,81,96,94,},{"Umbral Intensity",0,42,43,48,49,63,68,58,},{"Forgeborne Reveries (Heirmir)",126,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",52,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",32,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",96,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",25,0,0,0,0,0,0,0,},},},
		[261] ={{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,51,49,64,65,74,87,86,},{"Reverberation",0,59,64,66,71,87,84,96,},{"Hammer of Genesis (Mikanikos)",-5,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",97,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",73,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",59,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",72,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,55,66,78,100,100,101,96,},{"Pointed Courage (1 Ally) (Kleia)",30,0,0,0,0,0,0,0,},{"Deeper Daggers",0,48,53,62,66,60,70,80,},{"Pointed Courage (3 Allies) (Kleia)",103,0,0,0,0,0,0,0,},{"Planned Execution",0,55,62,69,80,85,89,93,},{"Pointed Courage (5 Allies) (Kleia)",168,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,60,64,66,66,72,93,85,},{"Lashing Scars",0,54,56,66,75,70,76,88,},{"Thrill Seeker (Nadjia)",74,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,43,52,77,106,95,86,88,},{"Built for War (Draven)",144,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",131,0,0,0,0,0,0,0,},{"Deeper Daggers",0,55,63,68,69,75,73,85,},{"Refined Palate (Theotar)",92,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",66,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",69,0,0,0,0,0,0,0,},{"Planned Execution",0,64,75,80,83,97,97,106,},{"Exacting Preparation (Nadjia)",40,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",160,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,60,60,71,71,79,76,96,},{"Septic Shock",0,35,52,58,56,66,77,86,},{"Stiletto Staccato",0,43,34,50,85,100,90,88,},{"Planned Execution",0,70,79,77,90,94,109,117,},{"Field of Blossoms (Dreamweaver)",93,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",142,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",154,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",187,0,0,0,0,0,0,0,},{"First Strike (Korayn)",14,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",119,0,0,0,0,0,0,0,},{"Deeper Daggers",0,48,59,61,59,74,73,78,},{"Social Butterfly (Dreamweaver)",63,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",113,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,53,63,58,71,65,77,89,},{"Sudden Fractures",0,30,40,44,47,55,59,57,},{"Deeper Daggers",0,45,59,56,64,60,71,84,},{"Stiletto Staccato",0,43,51,72,96,100,88,72,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",103,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",23,0,0,0,0,0,0,0,},{"Planned Execution",0,62,72,75,79,93,86,100,},{"Lead by Example (2 Allies) (Emeni)",63,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",42,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",96,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",104,0,0,0,0,0,0,0,},},},
		[269] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,69,68,73,72,74,70,73,},{"Inner Fury",0,26,26,25,25,30,33,37,},{"Calculated Strikes",0,3,-3,-10,-9,-3,-4,-6,},{"Combat Meditation (Never Extend) (Pelagos)",72,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,-5,-8,-5,-5,-7,1,0,},{"Xuen's Bond",0,36,38,33,42,43,46,49,},{"Hammer of Genesis (Mikanikos)",7,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",107,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",82,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",15,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",85,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",148,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",125,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,51,55,61,64,66,70,76,},{"Calculated Strikes",0,6,-4,9,7,7,5,-1,},{"Inner Fury",0,29,40,28,52,47,48,56,},{"Dauntless Duelist (Nadjia)",75,0,0,0,0,0,0,0,},{"Built for War (Draven)",118,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,7,6,4,5,-2,7,5,},{"Xuen's Bond",0,36,44,48,52,52,51,62,},{"Thrill Seeker (Nadjia)",45,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",68,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",71,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",60,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",22,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",117,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,8,0,12,11,3,4,6,},{"Grove Invigoration (Niya)",172,0,0,0,0,0,0,0,},{"Calculated Strikes",0,-3,-6,-10,-9,-8,-4,-1,},{"Inner Fury",0,24,28,32,34,37,41,42,},{"Coordinated Offensive",0,0,-3,-5,-5,-2,-4,-5,},{"Xuen's Bond",0,36,32,45,42,46,52,58,},{"Wild Hunt Tactics (Korayn)",69,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",142,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",90,0,0,0,0,0,0,0,},{"First Strike (Korayn)",29,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",175,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",49,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",22,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,51,58,62,72,77,84,90,},{"Calculated Strikes",0,-3,-11,-8,-10,-6,-3,3,},{"Inner Fury",0,26,29,33,33,40,37,41,},{"Coordinated Offensive",0,1,0,-7,-3,-3,-6,-5,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",40,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",75,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",90,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",4,0,0,0,0,0,0,0,},{"Xuen's Bond",0,23,21,19,29,34,34,41,},{"Lead by Example (4 Allies) (Emeni)",108,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",77,0,0,0,0,0,0,0,},},},
		[268] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,33,32,30,36,38,34,38,},{"Walk with the Ox",0,299,313,329,341,356,359,377,},{"Scalding Brew",0,14,16,16,16,17,25,25,},{"Bron's Call to Action (Mikanikos)",103,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",65,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",24,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",34,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",109,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",66,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",50,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,26,38,37,40,37,42,47,},{"Walk with the Ox",0,280,293,300,322,331,349,361,},{"Scalding Brew",0,19,17,21,23,21,31,27,},{"Built for War (Draven)",74,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",37,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",17,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",44,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",53,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",70,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",22,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",120,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,14,10,15,7,14,13,17,},{"Walk with the Ox",0,280,292,301,311,329,336,349,},{"Scalding Brew",0,9,18,20,18,16,22,21,},{"Wild Hunt Tactics (Korayn)",64,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",68,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",39,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",41,0,0,0,0,0,0,0,},{"First Strike (Korayn)",23,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",165,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",116,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",68,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,70,75,82,89,92,99,104,},{"Walk with the Ox",0,291,299,320,326,341,355,359,},{"Scalding Brew",0,7,11,15,13,16,17,20,},{"Lead by Example (0 Allies) (Emeni)",21,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-3,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",2,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",66,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",42,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",50,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",68,0,0,0,0,0,0,0,},},},
		[63] ={{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,74,80,88,90,102,107,111,},{"Flame Accretion",0,-9,4,4,5,16,20,27,},{"Pointed Courage (3 Allies) (Kleia)",59,0,0,0,0,0,0,0,},{"Ire of the Ascended",0,60,66,63,80,83,86,92,},{"Bron's Call to Action (Mikanikos)",57,0,0,0,0,0,0,0,},{"Infernal Cascade",0,231,256,277,303,342,356,372,},{"Master Flame",0,-1,-3,-7,-3,-3,8,0,},{"Pointed Courage (1 Ally) (Kleia)",14,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",149,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",125,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",100,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",88,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-9,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,76,75,82,92,97,109,103,},{"Flame Accretion",0,11,9,17,18,23,28,35,},{"Refined Palate (Theotar)",36,0,0,0,0,0,0,0,},{"Infernal Cascade",0,250,278,312,334,360,381,408,},{"Master Flame",0,1,-4,-10,-6,-6,-3,-1,},{"Siphoned Malice",0,41,48,48,49,59,65,71,},{"Exacting Preparation (Nadjia)",17,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",44,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",105,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",93,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",66,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",61,0,0,0,0,0,0,0,},{"Built for War (Draven)",139,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,73,84,82,96,99,105,113,},{"Flame Accretion",0,6,5,16,20,25,32,31,},{"Infernal Cascade",0,261,284,311,341,364,390,415,},{"Discipline of the Grove",0,77,86,91,90,87,81,69,},{"Social Butterfly (Dreamweaver)",52,0,0,0,0,0,0,0,},{"Master Flame",0,4,-2,5,1,3,-3,1,},{"Niya's Tools: Burrs (Niya)",181,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",114,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",112,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",80,0,0,0,0,0,0,0,},{"First Strike (Korayn)",1,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",37,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,72,74,78,95,95,111,112,},{"Lead by Example (4 Allies) (Emeni)",164,0,0,0,0,0,0,0,},{"Infernal Cascade",0,244,272,295,328,350,378,403,},{"Master Flame",0,1,-2,0,-9,-8,-3,2,},{"Flame Accretion",0,0,7,11,16,21,29,40,},{"Gift of the Lich",0,9,6,10,6,8,6,13,},{"Lead by Example (0 Allies) (Emeni)",62,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",96,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",32,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",9,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",103,0,0,0,0,0,0,0,},},},
	},
	["T26"]={
		[255] ={{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-5,-5,-3,5,4,-5,7,},{"Enfeebled Mark",0,103,93,103,110,120,130,136,},{"Strength of the Pack",0,58,62,86,92,101,111,120,},{"Stinging Strike",0,56,60,61,81,84,85,86,},{"Combat Meditation (50% Extend) (Pelagos)",87,0,0,0,0,0,0,0,},{"Deadly Tandem",0,34,37,54,54,48,56,52,},{"Hammer of Genesis (Mikanikos)",-5,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",105,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",59,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",91,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",28,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",113,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",200,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-3,-8,-9,2,-10,-5,-3,},{"Strength of the Pack",0,43,69,76,92,94,92,117,},{"Stinging Strike",0,46,57,67,62,77,79,77,},{"Deadly Tandem",0,32,37,39,40,43,57,52,},{"Empowered Release",0,59,67,57,61,63,61,63,},{"Built for War (Draven)",154,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",148,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",97,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",77,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",65,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",136,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",17,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",52,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-3,1,-2,-2,3,-3,1,},{"Spirit Attunement",0,97,100,102,105,119,109,108,},{"Deadly Tandem",0,38,34,48,52,46,48,61,},{"Stinging Strike",0,57,65,71,72,74,80,93,},{"Strength of the Pack",0,72,81,89,88,108,123,130,},{"Wild Hunt Tactics (Korayn)",135,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",218,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",172,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",265,0,0,0,0,0,0,0,},{"First Strike (Korayn)",28,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",58,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",128,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,11,-5,11,3,14,5,4,},{"Strength of the Pack",0,64,80,91,96,95,114,116,},{"Necrotic Barrage",0,24,21,22,28,33,41,37,},{"Lead by Example (2 Allies) (Emeni)",80,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",58,0,0,0,0,0,0,0,},{"Stinging Strike",0,54,63,69,70,72,93,90,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",115,0,0,0,0,0,0,0,},{"Deadly Tandem",0,34,47,56,52,56,67,68,},{"Forgeborne Reveries (Heirmir)",126,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",29,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",109,0,0,0,0,0,0,0,},},},
		[262] ={{{"Power",1,145,158,171,184,200,213,226,},{"Elysian Dirge",0,55,52,51,48,57,73,67,},{"Pyroclastic Shock",0,46,48,58,75,55,65,75,},{"Shake the Foundations",0,-6,-6,8,1,7,9,9,},{"Hammer of Genesis (Mikanikos)",8,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",107,0,0,0,0,0,0,0,},{"Call of Flame",0,78,88,88,81,92,105,97,},{"Combat Meditation (50% Extend) (Pelagos)",97,0,0,0,0,0,0,0,},{"High Voltage",0,15,9,24,28,7,23,24,},{"Combat Meditation (Never Extend) (Pelagos)",52,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",68,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",45,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",140,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",222,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,-11,-2,3,0,-12,-10,-7,},{"High Voltage",0,7,0,12,16,11,-1,15,},{"Shake the Foundations",0,1,-9,-5,-16,-15,-21,-1,},{"Pyroclastic Shock",0,44,42,43,48,41,63,57,},{"Call of Flame",0,75,88,80,81,85,77,89,},{"Built for War (Draven)",206,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",165,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",88,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",92,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",34,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",125,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",29,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",84,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,32,19,29,36,31,38,34,},{"Pyroclastic Shock",0,47,43,42,56,58,55,67,},{"High Voltage",0,2,14,6,11,1,10,6,},{"Social Butterfly (Dreamweaver)",71,0,0,0,0,0,0,0,},{"Shake the Foundations",0,-11,-11,-18,-9,-10,-5,0,},{"Field of Blossoms (Dreamweaver)",114,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",242,0,0,0,0,0,0,0,},{"First Strike (Korayn)",15,0,0,0,0,0,0,0,},{"Call of Flame",0,82,82,87,77,81,90,96,},{"Grove Invigoration (Niya)",135,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-12,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",178,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",155,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,34,36,45,53,54,38,53,},{"High Voltage",0,31,40,23,32,36,28,34,},{"Shake the Foundations",0,3,18,12,4,15,21,20,},{"Pyroclastic Shock",0,42,52,52,45,58,55,78,},{"Lead by Example (4 Allies) (Emeni)",157,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",136,0,0,0,0,0,0,0,},{"Call of Flame",0,119,108,112,112,120,121,113,},{"Gnashing Chompers (Emeni)",6,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",42,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",114,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",72,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",173,0,0,0,0,0,0,0,},},},
		[62] ={{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,-3,6,8,5,6,4,7,},{"Combat Meditation (Never Extend) (Pelagos)",71,0,0,0,0,0,0,0,},{"Nether Precision",0,26,23,27,39,39,48,59,},{"Arcane Prodigy",0,97,99,95,93,136,139,141,},{"Pointed Courage (3 Allies) (Kleia)",149,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-4,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",107,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",48,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",46,0,0,0,0,0,0,0,},{"Magi's Brand",0,92,114,115,123,139,157,164,},{"Pointed Courage (5 Allies) (Kleia)",237,0,0,0,0,0,0,0,},{"Ire of the Ascended",0,83,92,107,108,108,126,147,},{"Combat Meditation (50% Extend) (Pelagos)",72,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,16,28,13,21,29,29,24,},{"Nether Precision",0,49,56,52,58,67,60,69,},{"Arcane Prodigy",0,135,152,146,146,183,172,193,},{"Magi's Brand",0,112,128,142,144,149,161,180,},{"Built for War (Draven)",231,0,0,0,0,0,0,0,},{"Siphoned Malice",0,81,97,100,104,117,134,136,},{"Soothing Shade (Theotar)",105,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",66,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",96,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",44,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",181,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",136,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",74,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,9,14,12,18,22,25,21,},{"Arcane Prodigy",0,-3,-13,-3,7,-9,-1,-2,},{"Field of Blossoms (Dreamweaver)",58,0,0,0,0,0,0,0,},{"Discipline of the Grove",0,-13,23,64,97,124,141,142,},{"Wild Hunt Tactics (Korayn)",248,0,0,0,0,0,0,0,},{"Nether Precision",0,50,56,55,66,75,62,70,},{"Niya's Tools: Poison (Niya)",139,0,0,0,0,0,0,0,},{"Magi's Brand",0,134,148,150,158,171,185,196,},{"Niya's Tools: Burrs (Niya)",225,0,0,0,0,0,0,0,},{"First Strike (Korayn)",25,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",17,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",113,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",101,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,10,10,8,20,4,-1,7,},{"Nether Precision",0,24,36,31,57,43,54,69,},{"Arcane Prodigy",0,106,113,108,106,145,148,153,},{"Gift of the Lich",0,60,63,69,72,81,83,87,},{"Magi's Brand",0,107,111,122,136,157,158,161,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",179,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",172,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",214,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",286,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",110,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",21,0,0,0,0,0,0,0,},},},
		[263] ={{{"Power",1,145,158,171,184,200,213,226,},{"Elysian Dirge",0,40,42,46,39,45,53,52,},{"Unruly Winds",0,48,33,60,59,60,68,68,},{"Combat Meditation (50% Extend) (Pelagos)",129,0,0,0,0,0,0,0,},{"Magma Fist",0,31,31,26,21,31,28,30,},{"Chilled to the Core",0,34,35,32,35,32,29,33,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",166,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",80,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",148,0,0,0,0,0,0,0,},{"Focused Lightning",0,20,40,41,56,67,58,69,},{"Pointed Courage (1 Ally) (Kleia)",41,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",163,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",259,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,16,15,11,12,12,16,20,},{"Unruly Winds",0,57,51,66,57,49,77,66,},{"Thrill Seeker (Nadjia)",121,0,0,0,0,0,0,0,},{"Chilled to the Core",0,31,40,36,42,41,36,40,},{"Magma Fist",0,34,23,31,38,33,35,29,},{"Refined Palate (Theotar)",107,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",111,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",164,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",144,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",46,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",55,0,0,0,0,0,0,0,},{"Focused Lightning",0,35,35,67,62,66,80,95,},{"Built for War (Draven)",198,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,47,49,46,48,38,45,30,},{"Magma Fist",0,33,42,41,30,36,38,51,},{"Unruly Winds",0,63,50,68,69,81,70,72,},{"Chilled to the Core",0,34,52,52,42,49,44,41,},{"Wild Hunt Tactics (Korayn)",164,0,0,0,0,0,0,0,},{"Focused Lightning",0,39,49,55,66,64,86,96,},{"Niya's Tools: Poison (Niya)",194,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",153,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",267,0,0,0,0,0,0,0,},{"First Strike (Korayn)",78,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",10,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",91,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",269,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,22,28,24,25,29,34,51,},{"Focused Lightning",0,34,46,53,74,71,78,89,},{"Plaguey's Preemptive Strike (Marileth)",35,0,0,0,0,0,0,0,},{"Magma Fist",0,26,32,42,41,36,36,33,},{"Unruly Winds",0,43,50,62,57,76,59,67,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",160,0,0,0,0,0,0,0,},{"Chilled to the Core",0,40,45,48,32,43,41,53,},{"Forgeborne Reveries (Heirmir)",153,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",132,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",90,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",44,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",6,0,0,0,0,0,0,0,},},},
		[64] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ire of the Ascended",0,66,77,88,96,103,109,129,},{"Unrelenting Cold",0,25,37,40,31,45,50,56,},{"Shivering Core",0,-3,-2,-1,-4,6,4,-7,},{"Ice Bite",0,91,89,108,117,126,129,140,},{"Combat Meditation (Always Extend) (Pelagos)",96,0,0,0,0,0,0,0,},{"Icy Propulsion",0,287,326,386,458,530,595,686,},{"Combat Meditation (Never Extend) (Pelagos)",51,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",23,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",87,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",129,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",61,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",60,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-6,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Siphoned Malice",0,68,79,91,104,101,116,133,},{"Unrelenting Cold",0,26,44,41,40,44,52,60,},{"Shivering Core",0,-6,-2,-7,4,6,-7,2,},{"Ice Bite",0,91,119,119,120,135,144,157,},{"Built for War (Draven)",198,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",164,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",82,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",128,0,0,0,0,0,0,0,},{"Icy Propulsion",0,326,400,480,540,619,701,797,},{"Soothing Shade (Theotar)",104,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",55,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",31,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",80,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Discipline of the Grove",0,0,-3,-5,-2,3,-2,-5,},{"Unrelenting Cold",0,35,35,48,53,51,48,56,},{"Shivering Core",0,-9,-8,3,-1,0,-6,-7,},{"Ice Bite",0,95,101,108,112,124,133,147,},{"Wild Hunt Tactics (Korayn)",175,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",150,0,0,0,0,0,0,0,},{"Icy Propulsion",0,307,364,431,502,579,661,747,},{"Field of Blossoms (Dreamweaver)",21,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-2,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",76,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",264,0,0,0,0,0,0,0,},{"First Strike (Korayn)",24,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",80,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Gift of the Lich",0,45,35,45,43,50,50,54,},{"Shivering Core",0,12,10,8,12,10,5,0,},{"Unrelenting Cold",0,38,53,45,56,57,63,65,},{"Forgeborne Reveries (Heirmir)",151,0,0,0,0,0,0,0,},{"Ice Bite",0,88,110,117,128,134,146,150,},{"Icy Propulsion",0,307,352,419,495,575,654,732,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",42,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",193,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",147,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",80,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",37,0,0,0,0,0,0,0,},},},
		[66] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,56,67,73,84,85,93,96,},{"Punish the Guilty",0,72,72,75,84,88,97,107,},{"Pointed Courage (5 Allies) (Kleia)",162,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",92,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",160,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",69,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",86,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",24,0,0,0,0,0,0,0,},{"Vengeful Shock",0,38,49,55,60,63,67,78,},{"Combat Meditation (Always Extend) (Pelagos)",104,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-4,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,127,137,150,166,178,171,206,},{"Punish the Guilty",0,74,80,100,95,98,113,120,},{"Wasteland Propriety (Theotar)",102,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",19,0,0,0,0,0,0,0,},{"Vengeful Shock",0,50,63,61,63,76,73,89,},{"Refined Palate (Theotar)",105,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",84,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",150,0,0,0,0,0,0,0,},{"Built for War (Draven)",152,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",90,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",6,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,14,15,18,21,26,11,31,},{"Punish the Guilty",0,70,90,88,102,101,115,117,},{"Grove Invigoration (Niya)",136,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",60,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",9,0,0,0,0,0,0,0,},{"First Strike (Korayn)",55,0,0,0,0,0,0,0,},{"Vengeful Shock",0,48,60,59,67,69,75,81,},{"Niya's Tools: Burrs (Niya)",272,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",113,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",145,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,36,44,46,47,55,56,57,},{"Punish the Guilty",0,77,85,101,97,103,109,116,},{"Lead by Example (0 Allies) (Emeni)",24,0,0,0,0,0,0,0,},{"Vengeful Shock",0,44,53,58,59,66,74,78,},{"Lead by Example (2 Allies) (Emeni)",57,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",71,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",37,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",9,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",100,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",104,0,0,0,0,0,0,0,},},},
		[70] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,139,164,172,191,199,226,240,},{"Expurgation",0,134,144,163,175,184,208,210,},{"Truth's Wake",0,29,32,32,31,33,48,29,},{"Virtuous Command",0,190,211,224,244,275,288,311,},{"Pointed Courage (5 Allies) (Kleia)",205,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-1,0,0,0,0,0,0,0,},{"Templar's Vindication",0,147,166,187,212,219,240,263,},{"Combat Meditation (Always Extend) (Pelagos)",176,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",132,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",91,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",25,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",123,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",101,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,106,93,119,135,137,153,145,},{"Truth's Wake",0,18,18,24,28,33,31,38,},{"Expurgation",0,135,140,165,178,191,208,217,},{"Dauntless Duelist (Nadjia)",162,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",83,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",69,0,0,0,0,0,0,0,},{"Templar's Vindication",0,157,167,182,199,225,247,246,},{"Virtuous Command",0,167,196,211,226,247,251,271,},{"Soothing Shade (Theotar)",101,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-8,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",24,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",128,0,0,0,0,0,0,0,},{"Built for War (Draven)",160,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,32,31,26,42,32,36,41,},{"Truth's Wake",0,26,17,25,25,40,36,34,},{"Expurgation",0,129,158,163,176,204,210,233,},{"Virtuous Command",0,187,203,222,240,255,279,293,},{"Social Butterfly (Dreamweaver)",67,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",166,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",95,0,0,0,0,0,0,0,},{"Templar's Vindication",0,167,175,204,217,229,251,276,},{"Niya's Tools: Burrs (Niya)",249,0,0,0,0,0,0,0,},{"First Strike (Korayn)",29,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-1,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",172,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,21,31,34,29,32,41,24,},{"Expurgation",0,142,160,178,184,196,215,217,},{"Plaguey's Preemptive Strike (Marileth)",25,0,0,0,0,0,0,0,},{"Virtuous Command",0,176,192,195,213,236,256,275,},{"Truth's Wake",0,32,32,35,29,43,37,44,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",107,0,0,0,0,0,0,0,},{"Templar's Vindication",0,163,174,190,211,232,243,264,},{"Forgeborne Reveries (Heirmir)",119,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",101,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",69,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",44,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",5,0,0,0,0,0,0,0,},},},
		[72] ={{{"Power",1,145,158,171,184,200,213,226,},{"Piercing Verdict",0,30,37,41,42,50,46,52,},{"Depths of Insanity",0,54,65,60,68,65,61,84,},{"Ashen Juggernaut",0,117,131,132,142,156,171,186,},{"Hammer of Genesis (Mikanikos)",9,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",170,0,0,0,0,0,0,0,},{"Hack and Slash",0,35,60,55,60,57,60,70,},{"Bron's Call to Action (Mikanikos)",102,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",49,0,0,0,0,0,0,0,},{"Vicious Contempt",0,43,50,51,57,56,60,78,},{"Pointed Courage (3 Allies) (Kleia)",142,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",234,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",114,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",153,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Harrowing Punishment",0,14,17,19,27,24,29,22,},{"Depths of Insanity",0,41,40,48,52,63,47,65,},{"Refined Palate (Theotar)",103,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,106,115,135,135,142,158,170,},{"Dauntless Duelist (Nadjia)",167,0,0,0,0,0,0,0,},{"Vicious Contempt",0,33,45,43,-587,54,58,66,},{"Thrill Seeker (Nadjia)",134,0,0,0,0,0,0,0,},{"Hack and Slash",0,25,36,30,32,32,34,42,},{"Soothing Shade (Theotar)",104,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",5,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",50,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",6,0,0,0,0,0,0,0,},{"Built for War (Draven)",154,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,21,27,27,36,32,44,53,},{"Ashen Juggernaut",0,108,118,145,143,153,165,180,},{"Grove Invigoration (Niya)",190,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",137,0,0,0,0,0,0,0,},{"Depths of Insanity",0,54,60,63,62,81,79,80,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Vicious Contempt",0,47,35,40,47,62,61,75,},{"Field of Blossoms (Dreamweaver)",123,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",239,0,0,0,0,0,0,0,},{"First Strike (Korayn)",33,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",5,0,0,0,0,0,0,0,},{"Hack and Slash",0,49,44,45,55,59,57,62,},{"Social Butterfly (Dreamweaver)",87,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Veteran's Repute",0,67,78,86,90,94,85,105,},{"Depths of Insanity",0,53,63,64,73,63,74,83,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",134,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,122,130,145,151,163,177,188,},{"Forgeborne Reveries (Heirmir)",112,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-6,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",26,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",6,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",-4,0,0,0,0,0,0,0,},{"Vicious Contempt",0,36,46,44,55,65,58,65,},{"Hack and Slash",0,30,48,57,58,64,60,67,},{"Lead by Example (0 Allies) (Emeni)",0,0,0,0,0,0,0,0,},},},
		[578] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,59,64,72,70,80,90,92,},{"Soul Furnace",0,26,28,30,35,32,44,39,},{"Pointed Courage (5 Allies) (Kleia)",130,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",79,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",18,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",63,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",70,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",92,0,0,0,0,0,0,0,},{"Growing Inferno",0,32,39,42,51,50,59,55,},{"Combat Meditation (Always Extend) (Pelagos)",112,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,22,31,31,30,30,35,31,},{"Soul Furnace",0,13,26,28,37,30,29,32,},{"Exacting Preparation (Nadjia)",8,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",42,0,0,0,0,0,0,0,},{"Growing Inferno",0,29,37,43,34,42,52,53,},{"Soothing Shade (Theotar)",50,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",42,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",93,0,0,0,0,0,0,0,},{"Built for War (Draven)",82,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",53,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",114,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,50,45,54,61,62,64,70,},{"Soul Furnace",0,23,26,30,33,36,41,49,},{"Grove Invigoration (Niya)",99,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",50,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",112,0,0,0,0,0,0,0,},{"First Strike (Korayn)",56,0,0,0,0,0,0,0,},{"Growing Inferno",0,32,37,43,46,45,53,55,},{"Niya's Tools: Burrs (Niya)",226,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",66,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",70,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",100,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,-2,9,14,24,26,29,42,},{"Soul Furnace",0,32,31,32,41,36,47,48,},{"Lead by Example (0 Allies) (Emeni)",34,0,0,0,0,0,0,0,},{"Growing Inferno",0,41,40,46,53,58,53,64,},{"Lead by Example (2 Allies) (Emeni)",49,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",65,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",24,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",72,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",69,0,0,0,0,0,0,0,},},},
		[265] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,2,6,-2,6,-14,1,-7,},{"Cold Embrace",0,140,155,163,172,198,205,214,},{"Corrupting Leer",0,34,32,44,30,31,47,52,},{"Focused Malignancy",0,215,239,253,270,303,323,344,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",203,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",161,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",113,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",25,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",43,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",256,0,0,0,0,0,0,0,},{"Rolling Agony",0,26,27,32,25,25,25,27,},{"Pointed Courage (3 Allies) (Kleia)",147,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,49,56,54,58,59,69,66,},{"Corrupting Leer",0,-66,-62,-63,-55,-55,-49,-38,},{"Focused Malignancy",0,183,189,206,239,258,272,292,},{"Cold Embrace",0,128,144,146,160,169,189,198,},{"Rolling Agony",0,14,9,15,13,18,24,7,},{"Thrill Seeker (Nadjia)",116,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",60,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",150,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",113,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",17,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",55,0,0,0,0,0,0,0,},{"Built for War (Draven)",191,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,79,98,96,102,97,102,123,},{"Corrupting Leer",0,7,20,11,8,20,22,14,},{"Cold Embrace",0,161,164,175,182,199,207,228,},{"Niya's Tools: Poison (Niya)",12,0,0,0,0,0,0,0,},{"Focused Malignancy",0,197,230,243,263,278,308,330,},{"Field of Blossoms (Dreamweaver)",173,0,0,0,0,0,0,0,},{"Rolling Agony",0,30,20,23,18,16,29,26,},{"Niya's Tools: Burrs (Niya)",278,0,0,0,0,0,0,0,},{"First Strike (Korayn)",20,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",18,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",91,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",220,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",179,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,70,76,90,79,89,17,94,},{"Corrupting Leer",0,20,23,21,23,33,46,50,},{"Cold Embrace",0,129,136,160,166,180,193,212,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",132,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",149,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-3,0,0,0,0,0,0,0,},{"Rolling Agony",0,15,13,3,6,13,6,17,},{"Lead by Example (4 Allies) (Emeni)",108,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",25,0,0,0,0,0,0,0,},{"Focused Malignancy",0,169,197,214,240,236,269,288,},{"Lead by Example (2 Allies) (Emeni)",80,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",52,0,0,0,0,0,0,0,},},},
		[577] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,41,41,44,43,52,63,60,},{"Relentless Onslaught",0,110,104,122,131,153,160,177,},{"Serrated Glaive",0,-3,-12,-10,6,-2,-4,-5,},{"Growing Inferno",0,97,98,119,122,135,134,157,},{"Hammer of Genesis (Mikanikos)",15,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",119,0,0,0,0,0,0,0,},{"Dancing with Fate",0,10,9,17,11,13,13,15,},{"Combat Meditation (50% Extend) (Pelagos)",92,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",62,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",106,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",131,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",225,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",53,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,-34,-31,-19,-11,-24,-14,-19,},{"Relentless Onslaught",0,105,116,122,133,138,156,161,},{"Serrated Glaive",0,9,5,4,6,-11,-1,4,},{"Growing Inferno",0,98,85,109,114,133,143,151,},{"Built for War (Draven)",143,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",159,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",141,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",83,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",135,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",28,0,0,0,0,0,0,0,},{"Dancing with Fate",0,12,17,11,8,4,19,14,},{"Wasteland Propriety (Theotar)",71,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",101,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,42,40,51,51,50,56,71,},{"Relentless Onslaught",0,98,115,132,141,137,157,171,},{"Growing Inferno",0,92,104,122,120,128,136,151,},{"Serrated Glaive",0,27,17,22,19,25,26,18,},{"Niya's Tools: Poison (Niya)",224,0,0,0,0,0,0,0,},{"Dancing with Fate",0,13,11,22,16,22,22,21,},{"Field of Blossoms (Dreamweaver)",129,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",172,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",271,0,0,0,0,0,0,0,},{"First Strike (Korayn)",51,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",9,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",77,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",123,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,17,12,32,45,58,71,79,},{"Dancing with Fate",0,-1,8,13,12,12,16,14,},{"Relentless Onslaught",0,113,124,130,129,163,155,180,},{"Serrated Glaive",0,0,-10,-9,4,-7,-12,-6,},{"Growing Inferno",0,97,103,115,126,132,147,156,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",172,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-5,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",109,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",126,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",84,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",35,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",49,0,0,0,0,0,0,0,},},},
		[253] ={{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,31,31,31,36,37,46,44,},{"Ferocious Appetite",0,-12,-4,-2,10,14,13,5,},{"One With the Beast",0,23,34,43,67,70,77,89,},{"Enfeebled Mark",0,102,124,130,132,151,158,180,},{"Hammer of Genesis (Mikanikos)",12,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",162,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",103,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",134,0,0,0,0,0,0,0,},{"Echoing Call",0,3,3,14,-4,4,1,14,},{"Pointed Courage (1 Ally) (Kleia)",39,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",116,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",184,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",83,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,30,23,26,37,36,33,37,},{"Empowered Release",0,31,40,35,24,35,44,35,},{"Ferocious Appetite",0,-4,-3,-1,3,7,14,4,},{"Echoing Call",0,-1,-7,-9,-2,1,-2,-8,},{"One With the Beast",0,26,28,47,57,76,74,93,},{"Built for War (Draven)",165,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",165,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",86,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",96,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-2,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",1,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",42,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",69,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,31,38,38,49,43,44,45,},{"Ferocious Appetite",0,-23,-41,-24,-28,-14,-15,-21,},{"One With the Beast",0,19,38,42,60,81,77,97,},{"Echoing Call",0,7,5,8,7,-3,-2,16,},{"Spirit Attunement",0,96,101,109,118,107,112,128,},{"Wild Hunt Tactics (Korayn)",84,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",159,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",257,0,0,0,0,0,0,0,},{"First Strike (Korayn)",14,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",188,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",190,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",78,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-2,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,42,40,42,47,44,51,58,},{"Necrotic Barrage",0,22,33,37,33,37,41,39,},{"Echoing Call",0,11,9,24,13,13,13,17,},{"Lead by Example (2 Allies) (Emeni)",101,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",65,0,0,0,0,0,0,0,},{"One With the Beast",0,27,41,58,66,75,84,95,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",119,0,0,0,0,0,0,0,},{"Ferocious Appetite",0,7,14,8,18,26,30,39,},{"Gnashing Chompers (Emeni)",8,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",33,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",130,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",134,0,0,0,0,0,0,0,},},},
		[258] ={{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,200,204,226,222,248,244,246,},{"Courageous Ascension",0,102,110,126,124,144,147,159,},{"Rabid Shadows",0,15,29,24,53,55,60,46,},{"Mind Devourer",0,78,83,79,92,89,91,92,},{"Haunting Apparitions",0,84,85,94,114,99,130,138,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",332,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",266,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",35,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",60,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",159,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",265,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",299,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,213,224,247,223,258,258,274,},{"Haunting Apparitions",0,87,89,113,128,100,152,149,},{"Rabid Shadows",0,21,38,44,42,45,54,66,},{"Shattered Perceptions",0,37,25,36,48,45,51,52,},{"Exacting Preparation (Nadjia)",20,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-11,0,0,0,0,0,0,0,},{"Mind Devourer",0,88,87,100,96,92,104,108,},{"Built for War (Draven)",224,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",166,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",123,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",94,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",130,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",58,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,234,231,249,259,264,282,289,},{"Fae Fermata",0,-2,-4,-16,-13,-8,5,-6,},{"Rabid Shadows",0,23,40,34,48,54,48,58,},{"Haunting Apparitions",0,99,115,123,126,115,152,161,},{"Wild Hunt Tactics (Korayn)",174,0,0,0,0,0,0,0,},{"Mind Devourer",0,94,107,103,101,99,112,109,},{"Niya's Tools: Poison (Niya)",-3,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",184,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",233,0,0,0,0,0,0,0,},{"First Strike (Korayn)",9,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-6,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",82,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",227,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,227,224,227,243,254,259,278,},{"Festering Transfusion",0,79,73,81,78,77,95,88,},{"Mind Devourer",0,84,100,110,106,109,103,112,},{"Haunting Apparitions",0,94,109,124,133,118,145,180,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",164,0,0,0,0,0,0,0,},{"Rabid Shadows",0,14,44,42,55,51,64,68,},{"Forgeborne Reveries (Heirmir)",175,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-4,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",11,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",161,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",118,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",54,0,0,0,0,0,0,0,},},},
		[266] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,-6,-14,-14,-5,-10,-13,-6,},{"Fel Commando",0,83,94,87,105,112,126,129,},{"Combat Meditation (Never Extend) (Pelagos)",74,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",209,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,77,84,83,105,103,117,119,},{"Carnivorous Stalkers",0,52,62,65,79,78,78,82,},{"Pointed Courage (1 Ally) (Kleia)",35,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",123,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",119,0,0,0,0,0,0,0,},{"Borne of Blood",0,87,99,111,114,127,148,157,},{"Bron's Call to Action (Mikanikos)",47,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",103,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-5,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,23,31,24,34,33,45,30,},{"Fel Commando",0,81,92,101,98,109,122,115,},{"Carnivorous Stalkers",0,59,53,60,65,71,78,77,},{"Built for War (Draven)",159,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,81,84,84,92,107,111,114,},{"Wasteland Propriety (Theotar)",53,0,0,0,0,0,0,0,},{"Borne of Blood",0,95,112,122,136,151,154,166,},{"Thrill Seeker (Nadjia)",27,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",2,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",125,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",40,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",86,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-11,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,31,35,44,41,44,49,49,},{"Fel Commando",0,79,87,100,103,120,130,137,},{"Social Butterfly (Dreamweaver)",61,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-2,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,50,65,72,73,69,88,89,},{"Tyrant's Soul",0,87,97,95,112,111,128,128,},{"Grove Invigoration (Niya)",141,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",133,0,0,0,0,0,0,0,},{"Borne of Blood",0,105,112,128,134,155,163,179,},{"Niya's Tools: Burrs (Niya)",211,0,0,0,0,0,0,0,},{"First Strike (Korayn)",12,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-5,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",38,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,50,71,67,71,79,12,85,},{"Lead by Example (0 Allies) (Emeni)",48,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,81,99,90,119,112,115,121,},{"Carnivorous Stalkers",0,58,58,71,78,83,87,98,},{"Gnashing Chompers (Emeni)",-8,0,0,0,0,0,0,0,},{"Fel Commando",0,81,104,104,110,119,133,134,},{"Borne of Blood",0,98,113,114,115,150,152,152,},{"Lead by Example (4 Allies) (Emeni)",129,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",2,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",137,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",44,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",87,0,0,0,0,0,0,0,},},},
		[104] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,14,13,13,15,8,15,16,},{"Savage Combatant",0,90,102,116,126,134,148,154,},{"Pointed Courage (5 Allies) (Kleia)",139,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,58,64,72,78,81,89,95,},{"Pointed Courage (3 Allies) (Kleia)",85,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",24,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",188,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",81,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",103,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-2,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",62,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,29,28,32,35,39,40,37,},{"Savage Combatant",0,105,113,135,133,146,155,165,},{"Wasteland Propriety (Theotar)",45,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,85,90,89,104,106,114,119,},{"Soothing Shade (Theotar)",62,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",36,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",59,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",94,0,0,0,0,0,0,0,},{"Built for War (Draven)",93,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-12,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",9,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,80,82,93,102,102,105,121,},{"Savage Combatant",0,99,103,110,112,132,133,145,},{"Grove Invigoration (Niya)",155,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",55,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",66,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",109,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,55,68,74,76,94,82,86,},{"Niya's Tools: Burrs (Niya)",274,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",129,0,0,0,0,0,0,0,},{"First Strike (Korayn)",50,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,46,43,51,52,66,66,72,},{"Savage Combatant",0,89,97,104,113,126,137,149,},{"Lead by Example (4 Allies) (Emeni)",44,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",22,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,74,67,82,89,97,110,107,},{"Plaguey's Preemptive Strike (Marileth)",14,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",35,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",77,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",79,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-7,0,0,0,0,0,0,0,},},},
		[103] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,-29,-22,-30,-17,-16,-14,-14,},{"Taste for Blood",0,100,102,105,125,124,149,154,},{"Bron's Call to Action (Mikanikos)",82,0,0,0,0,0,0,0,},{"Incessant Hunter",0,32,30,40,41,41,47,52,},{"Sudden Ambush",0,105,111,118,132,142,145,158,},{"Pointed Courage (5 Allies) (Kleia)",258,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-1,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",174,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",140,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",53,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",162,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",208,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,77,79,94,88,101,114,124,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,64,66,86,74,92,92,101,},{"Taste for Blood",0,94,103,120,125,142,152,158,},{"Incessant Hunter",0,31,44,41,45,50,54,47,},{"Dauntless Duelist (Nadjia)",165,0,0,0,0,0,0,0,},{"Built for War (Draven)",168,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",107,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",107,0,0,0,0,0,0,0,},{"Sudden Ambush",0,113,108,113,130,141,141,155,},{"Refined Palate (Theotar)",60,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",111,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,78,86,94,84,97,111,113,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",46,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,96,113,110,116,130,140,151,},{"Taste for Blood",0,123,142,148,166,181,191,205,},{"Incessant Hunter",0,40,43,46,42,50,60,63,},{"Sudden Ambush",0,91,116,121,131,142,146,154,},{"Carnivorous Instinct",0,80,90,89,98,111,122,119,},{"Niya's Tools: Poison (Niya)",12,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",230,0,0,0,0,0,0,0,},{"First Strike (Korayn)",25,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",18,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",232,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",200,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",102,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",93,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,47,62,73,67,72,66,88,},{"Incessant Hunter",0,20,22,24,28,35,45,41,},{"Taste for Blood",0,76,99,95,103,116,122,137,},{"Sudden Ambush",0,98,100,124,121,132,142,150,},{"Lead by Example (4 Allies) (Emeni)",87,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",114,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",159,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",6,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,69,72,72,73,88,84,93,},{"Lead by Example (0 Allies) (Emeni)",28,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",51,0,0,0,0,0,0,0,},},},
		[259] ={{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,80,74,71,91,112,114,111,},{"Maim, Mangle",0,43,50,59,63,72,70,79,},{"Poisoned Katar",0,-7,-2,-9,3,-8,5,6,},{"Reverberation",0,54,72,75,73,73,90,85,},{"Pointed Courage (3 Allies) (Kleia)",143,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,76,77,78,98,105,113,121,},{"Hammer of Genesis (Mikanikos)",9,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",139,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",115,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",79,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",44,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",231,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",51,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,69,62,80,86,87,102,106,},{"Maim, Mangle",0,46,55,56,54,60,72,73,},{"Lashing Scars",0,58,53,63,75,73,79,82,},{"Poisoned Katar",0,-6,-6,-6,-2,-1,0,-8,},{"Well-Placed Steel",0,72,74,74,86,91,98,101,},{"Exacting Preparation (Nadjia)",39,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",171,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",98,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",168,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",89,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",68,0,0,0,0,0,0,0,},{"Built for War (Draven)",154,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",106,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,69,71,75,91,96,101,118,},{"Maim, Mangle",0,46,52,49,59,60,71,80,},{"Well-Placed Steel",0,71,85,89,96,110,120,117,},{"Septic Shock",0,37,40,39,56,67,62,83,},{"Grove Invigoration (Niya)",156,0,0,0,0,0,0,0,},{"Poisoned Katar",0,5,-6,-4,2,4,1,-7,},{"Niya's Tools: Burrs (Niya)",277,0,0,0,0,0,0,0,},{"First Strike (Korayn)",29,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",225,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",184,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",117,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",73,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",149,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,67,62,78,81,85,100,104,},{"Maim, Mangle",0,37,53,52,58,66,64,72,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",141,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,68,76,69,84,103,111,104,},{"Forgeborne Reveries (Heirmir)",121,0,0,0,0,0,0,0,},{"Poisoned Katar",0,-2,-6,-4,-3,-12,0,-2,},{"Lead by Example (0 Allies) (Emeni)",41,0,0,0,0,0,0,0,},{"Sudden Fractures",0,42,48,57,65,63,71,72,},{"Lead by Example (4 Allies) (Emeni)",107,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-7,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",72,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",25,0,0,0,0,0,0,0,},},},
		[267] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,-13,-15,-10,-23,-5,-16,-2,},{"Duplicitous Havoc",0,-15,-10,-7,-7,-16,-7,-9,},{"Ashen Remains",0,57,62,61,60,84,86,91,},{"Combat Meditation (Always Extend) (Pelagos)",150,0,0,0,0,0,0,0,},{"Infernal Brand",0,39,42,43,52,47,54,62,},{"Hammer of Genesis (Mikanikos)",-7,0,0,0,0,0,0,0,},{"Combusting Engine",0,32,38,41,52,57,59,69,},{"Combat Meditation (50% Extend) (Pelagos)",120,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",82,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",26,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",37,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",121,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",235,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,39,39,46,53,44,54,51,},{"Combusting Engine",0,45,54,51,65,57,68,77,},{"Refined Palate (Theotar)",66,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,7,-1,0,2,-2,4,13,},{"Ashen Remains",0,71,71,83,80,84,101,102,},{"Dauntless Duelist (Nadjia)",156,0,0,0,0,0,0,0,},{"Infernal Brand",0,48,49,44,66,64,67,72,},{"Exacting Preparation (Nadjia)",25,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-7,0,0,0,0,0,0,0,},{"Built for War (Draven)",189,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",102,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",113,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",71,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,35,39,52,62,64,66,68,},{"Combusting Engine",0,60,65,73,71,79,75,94,},{"Duplicitous Havoc",0,4,5,-1,15,5,5,5,},{"Niya's Tools: Poison (Niya)",5,0,0,0,0,0,0,0,},{"Ashen Remains",0,76,77,90,82,96,115,114,},{"Infernal Brand",0,52,53,59,72,73,69,74,},{"Wild Hunt Tactics (Korayn)",160,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",75,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",185,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",2,0,0,0,0,0,0,0,},{"First Strike (Korayn)",36,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",227,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",128,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,69,73,83,81,98,13,88,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",122,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,0,-9,-7,-5,7,9,7,},{"Ashen Remains",0,79,78,84,100,98,107,122,},{"Lead by Example (4 Allies) (Emeni)",142,0,0,0,0,0,0,0,},{"Infernal Brand",0,48,63,60,52,66,79,81,},{"Forgeborne Reveries (Heirmir)",155,0,0,0,0,0,0,0,},{"Combusting Engine",0,43,48,70,69,71,69,68,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",24,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",102,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",61,0,0,0,0,0,0,0,},},},
		[250] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,71,68,72,75,86,85,92,},{"Debilitating Malady",0,0,-1,0,1,0,1,4,},{"Withering Plague",0,16,22,20,28,26,30,42,},{"Bron's Call to Action (Mikanikos)",70,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",52,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",68,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",85,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",3,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",76,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",135,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",29,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,16,22,22,15,22,19,22,},{"Debilitating Malady",0,6,8,8,7,5,8,11,},{"Wasteland Propriety (Theotar)",40,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",6,0,0,0,0,0,0,0,},{"Withering Plague",0,25,29,31,31,45,41,41,},{"Refined Palate (Theotar)",109,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",56,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",101,0,0,0,0,0,0,0,},{"Built for War (Draven)",91,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",4,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",66,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,63,70,71,79,79,89,98,},{"Debilitating Malady",0,4,11,9,10,15,6,13,},{"Grove Invigoration (Niya)",85,0,0,0,0,0,0,0,},{"Withering Plague",0,28,32,34,33,41,43,42,},{"Niya's Tools: Herbs (Niya)",28,0,0,0,0,0,0,0,},{"First Strike (Korayn)",34,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",270,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",7,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",92,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",90,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",60,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,18,17,20,22,22,24,23,},{"Debilitating Malady",0,5,4,5,7,4,1,2,},{"Lead by Example (0 Allies) (Emeni)",29,0,0,0,0,0,0,0,},{"Withering Plague",0,35,29,38,42,41,45,47,},{"Plaguey's Preemptive Strike (Marileth)",15,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",73,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",83,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",53,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",80,0,0,0,0,0,0,0,},},},
		[254] ={{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,27,49,51,58,69,74,82,},{"Brutal Projectiles",0,11,16,1,9,11,1,13,},{"Enfeebled Mark",0,124,144,156,169,181,191,208,},{"Sharpshooter's Focus",0,59,61,64,84,80,91,94,},{"Deadly Chain",0,6,7,-5,1,-5,-7,-11,},{"Combat Meditation (50% Extend) (Pelagos)",218,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",11,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",257,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",162,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",87,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",44,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",251,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",158,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,31,39,45,55,68,72,78,},{"Brutal Projectiles",0,6,3,4,3,-2,14,5,},{"Empowered Release",0,76,64,61,70,58,83,79,},{"Deadly Chain",0,9,-7,-4,-3,-1,2,5,},{"Sharpshooter's Focus",0,54,52,61,73,77,81,89,},{"Built for War (Draven)",158,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",176,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",98,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",74,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",128,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",30,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",46,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,40,40,58,61,79,100,93,},{"Spirit Attunement",0,146,149,148,157,158,162,167,},{"Sharpshooter's Focus",0,67,67,64,71,77,86,98,},{"Wild Hunt Tactics (Korayn)",206,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",195,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",215,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,16,17,-3,8,9,14,12,},{"Niya's Tools: Burrs (Niya)",261,0,0,0,0,0,0,0,},{"First Strike (Korayn)",34,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-5,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",94,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",315,0,0,0,0,0,0,0,},{"Deadly Chain",0,10,7,-1,4,4,7,10,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,37,61,43,62,73,83,98,},{"Necrotic Barrage",0,45,38,54,60,47,58,55,},{"Brutal Projectiles",0,10,18,16,17,5,8,18,},{"Deadly Chain",0,9,6,16,7,8,8,13,},{"Lead by Example (2 Allies) (Emeni)",83,0,0,0,0,0,0,0,},{"Sharpshooter's Focus",0,58,54,64,71,85,84,90,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",152,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",135,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",43,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",54,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",136,0,0,0,0,0,0,0,},},},
		[260] ={{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,177,194,212,231,243,273,297,},{"Sleight of Hand",0,60,75,71,79,88,92,100,},{"Reverberation",0,65,59,73,84,79,91,94,},{"Ambidexterity",0,0,11,-11,-6,3,-3,1,},{"Hammer of Genesis (Mikanikos)",-1,0,0,0,0,0,0,0,},{"Triple Threat",0,59,53,58,73,80,85,88,},{"Bron's Call to Action (Mikanikos)",142,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",130,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",221,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",86,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",64,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",46,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",140,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,182,205,212,233,241,268,288,},{"Sleight of Hand",0,58,58,67,73,83,99,100,},{"Triple Threat",0,57,54,62,60,80,91,94,},{"Ambidexterity",0,0,3,3,8,-7,0,11,},{"Built for War (Draven)",177,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",188,0,0,0,0,0,0,0,},{"Lashing Scars",0,56,67,69,67,78,82,88,},{"Wasteland Propriety (Theotar)",75,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",50,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",173,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",100,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",124,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",97,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,177,197,202,235,251,273,284,},{"Sleight of Hand",0,67,70,55,75,79,95,100,},{"Septic Shock",0,32,41,38,54,59,65,77,},{"Triple Threat",0,43,54,59,67,69,82,93,},{"Grove Invigoration (Niya)",138,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",308,0,0,0,0,0,0,0,},{"First Strike (Korayn)",33,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",156,0,0,0,0,0,0,0,},{"Ambidexterity",0,-4,-8,-13,-3,-11,1,-11,},{"Niya's Tools: Poison (Niya)",254,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",119,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",82,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",172,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,172,184,211,228,243,275,273,},{"Triple Threat",0,43,47,56,64,77,84,92,},{"Sudden Fractures",0,42,47,46,50,38,60,59,},{"Lead by Example (2 Allies) (Emeni)",69,0,0,0,0,0,0,0,},{"Ambidexterity",0,-5,3,-6,-5,8,-5,11,},{"Gnashing Chompers (Emeni)",-11,0,0,0,0,0,0,0,},{"Sleight of Hand",0,67,65,72,79,77,93,90,},{"Plaguey's Preemptive Strike (Marileth)",33,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",102,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",39,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",127,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",133,0,0,0,0,0,0,0,},},},
		[71] ={{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,75,74,84,103,103,112,117,},{"Ashen Juggernaut",0,153,167,186,206,222,244,249,},{"Piercing Verdict",0,22,22,22,27,37,37,33,},{"Crash the Ramparts",0,48,58,51,60,74,77,75,},{"Merciless Bonegrinder",0,5,-6,-10,-9,-2,-12,-5,},{"Hammer of Genesis (Mikanikos)",11,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",133,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",112,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",218,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",69,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",40,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",83,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",133,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,59,51,64,78,80,94,81,},{"Crash the Ramparts",0,39,40,55,36,48,62,62,},{"Ashen Juggernaut",0,186,199,231,234,239,265,274,},{"Dauntless Duelist (Nadjia)",173,0,0,0,0,0,0,0,},{"Built for War (Draven)",156,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",93,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",100,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",101,0,0,0,0,0,0,0,},{"Harrowing Punishment",0,40,38,38,49,54,43,55,},{"Merciless Bonegrinder",0,-4,-6,-2,-11,6,2,0,},{"Superior Tactics (Draven)",6,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",19,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-7,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,7,12,9,21,30,27,34,},{"Crash the Ramparts",0,42,52,63,69,71,81,80,},{"Ashen Juggernaut",0,149,175,191,204,210,235,253,},{"Merciless Bonegrinder",0,1,1,-1,-6,-10,-2,-2,},{"Social Butterfly (Dreamweaver)",74,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",168,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",127,0,0,0,0,0,0,0,},{"Mortal Combo",0,82,78,86,97,101,109,123,},{"Niya's Tools: Burrs (Niya)",214,0,0,0,0,0,0,0,},{"First Strike (Korayn)",31,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",4,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",135,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,73,80,92,107,107,112,118,},{"Ashen Juggernaut",0,179,192,216,226,253,273,286,},{"Veteran's Repute",0,72,88,96,102,111,111,134,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",122,0,0,0,0,0,0,0,},{"Crash the Ramparts",0,54,65,70,70,72,85,86,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",12,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",-11,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",-7,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",2,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",114,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,1,-4,1,1,-6,-5,-4,},},},
		[73] ={{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,-4,-4,-6,-2,-2,0,-4,},{"Piercing Verdict",0,8,9,16,20,22,26,27,},{"Ashen Juggernaut",0,23,27,29,29,37,39,42,},{"Bron's Call to Action (Mikanikos)",77,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",164,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",155,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",88,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",201,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",113,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",32,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,-3,4,6,8,5,2,3,},{"Harrowing Punishment",0,18,13,17,15,17,20,14,},{"Ashen Juggernaut",0,40,43,52,54,53,65,65,},{"Dauntless Duelist (Nadjia)",119,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",14,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",110,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",77,0,0,0,0,0,0,0,},{"Built for War (Draven)",111,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",149,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",0,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,37,32,40,47,45,57,58,},{"Show of Force",0,-2,0,-2,-1,1,-4,-1,},{"Ashen Juggernaut",0,28,28,26,33,37,41,49,},{"Wild Hunt Tactics (Korayn)",97,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",58,0,0,0,0,0,0,0,},{"First Strike (Korayn)",42,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",192,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-2,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",84,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-3,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",227,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,5,-3,2,3,1,3,4,},{"Veteran's Repute",0,44,44,48,61,57,65,63,},{"Ashen Juggernaut",0,27,31,44,41,44,51,51,},{"Plaguey's Preemptive Strike (Marileth)",26,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",1,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",72,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",7,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",3,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",81,0,0,0,0,0,0,0,},},},
		[102] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,42,49,50,46,61,72,65,},{"Stellar Inspiration",0,52,49,52,58,71,66,74,},{"Hammer of Genesis (Mikanikos)",28,0,0,0,0,0,0,0,},{"Precise Alignment",0,-16,-15,8,7,4,20,41,},{"Umbral Intensity",0,61,75,84,75,99,107,102,},{"Combat Meditation (Always Extend) (Pelagos)",258,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",257,0,0,0,0,0,0,0,},{"Fury of the Skies",0,89,100,108,114,129,136,140,},{"Combat Meditation (Never Extend) (Pelagos)",223,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",102,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",148,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",236,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",51,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,82,91,91,112,119,118,123,},{"Stellar Inspiration",0,20,25,48,40,45,59,58,},{"Refined Palate (Theotar)",55,0,0,0,0,0,0,0,},{"Fury of the Skies",0,81,80,107,104,104,124,131,},{"Built for War (Draven)",230,0,0,0,0,0,0,0,},{"Precise Alignment",0,6,15,19,25,38,60,61,},{"Wasteland Propriety (Theotar)",100,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",107,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",115,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-7,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",20,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",180,0,0,0,0,0,0,0,},{"Umbral Intensity",0,54,67,66,73,88,89,101,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,125,139,164,166,190,207,220,},{"Stellar Inspiration",0,49,52,54,61,55,64,85,},{"Wild Hunt Tactics (Korayn)",184,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-8,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",125,0,0,0,0,0,0,0,},{"Fury of the Skies",0,86,98,99,126,114,135,129,},{"Niya's Tools: Herbs (Niya)",-9,0,0,0,0,0,0,0,},{"Umbral Intensity",0,51,63,73,73,83,100,92,},{"Grove Invigoration (Niya)",353,0,0,0,0,0,0,0,},{"Precise Alignment",0,35,39,23,23,28,38,61,},{"Social Butterfly (Dreamweaver)",75,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",240,0,0,0,0,0,0,0,},{"First Strike (Korayn)",17,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,80,72,83,88,98,110,122,},{"Precise Alignment",0,3,14,-4,27,35,11,24,},{"Plaguey's Preemptive Strike (Marileth)",13,0,0,0,0,0,0,0,},{"Stellar Inspiration",0,31,39,40,50,39,55,63,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Fury of the Skies",0,76,96,89,102,119,107,125,},{"Umbral Intensity",0,60,66,78,71,86,78,88,},{"Forgeborne Reveries (Heirmir)",184,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",67,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",50,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",121,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",38,0,0,0,0,0,0,0,},},},
		[261] ={{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,73,92,99,104,103,113,125,},{"Reverberation",0,88,95,104,103,115,116,134,},{"Hammer of Genesis (Mikanikos)",8,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",134,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",98,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",77,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",106,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,88,97,121,146,121,134,122,},{"Pointed Courage (1 Ally) (Kleia)",48,0,0,0,0,0,0,0,},{"Deeper Daggers",0,80,77,80,82,99,104,113,},{"Pointed Courage (3 Allies) (Kleia)",157,0,0,0,0,0,0,0,},{"Planned Execution",0,87,94,103,112,117,131,136,},{"Pointed Courage (5 Allies) (Kleia)",255,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,76,69,85,82,101,114,117,},{"Lashing Scars",0,71,73,80,98,92,102,108,},{"Thrill Seeker (Nadjia)",94,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,78,84,118,136,124,108,111,},{"Built for War (Draven)",192,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",186,0,0,0,0,0,0,0,},{"Deeper Daggers",0,67,74,84,96,97,113,114,},{"Refined Palate (Theotar)",105,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",94,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",90,0,0,0,0,0,0,0,},{"Planned Execution",0,94,104,100,107,119,139,134,},{"Exacting Preparation (Nadjia)",41,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",228,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,39,71,69,80,94,93,97,},{"Septic Shock",0,40,44,60,69,74,90,103,},{"Stiletto Staccato",0,47,67,99,123,105,114,98,},{"Planned Execution",0,77,95,102,118,123,122,154,},{"Field of Blossoms (Dreamweaver)",108,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",191,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",198,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",241,0,0,0,0,0,0,0,},{"First Strike (Korayn)",20,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",171,0,0,0,0,0,0,0,},{"Deeper Daggers",0,55,71,64,81,81,100,100,},{"Social Butterfly (Dreamweaver)",77,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",141,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,64,89,97,104,103,110,111,},{"Sudden Fractures",0,47,56,52,67,69,72,74,},{"Deeper Daggers",0,68,75,76,93,92,106,108,},{"Stiletto Staccato",0,83,92,122,128,131,117,105,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",151,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",5,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",37,0,0,0,0,0,0,0,},{"Planned Execution",0,86,99,104,121,129,133,143,},{"Lead by Example (2 Allies) (Emeni)",91,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",57,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",139,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",142,0,0,0,0,0,0,0,},},},
		[269] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,112,96,105,100,109,110,104,},{"Inner Fury",0,37,39,42,44,59,56,60,},{"Calculated Strikes",0,2,-3,1,0,3,7,21,},{"Combat Meditation (Never Extend) (Pelagos)",138,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,5,-8,6,1,3,11,4,},{"Xuen's Bond",0,55,54,46,63,66,72,74,},{"Hammer of Genesis (Mikanikos)",18,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",172,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",129,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",41,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",119,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",208,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",212,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,60,74,79,81,97,102,108,},{"Calculated Strikes",0,6,5,4,14,7,3,5,},{"Inner Fury",0,52,48,55,65,66,64,74,},{"Dauntless Duelist (Nadjia)",111,0,0,0,0,0,0,0,},{"Built for War (Draven)",156,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,17,10,6,8,14,5,1,},{"Xuen's Bond",0,65,67,68,74,77,84,74,},{"Thrill Seeker (Nadjia)",70,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",70,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",97,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",93,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",43,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",142,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,6,4,15,10,8,15,4,},{"Grove Invigoration (Niya)",245,0,0,0,0,0,0,0,},{"Calculated Strikes",0,-6,4,2,-4,-7,-3,-1,},{"Inner Fury",0,35,42,40,49,50,56,61,},{"Coordinated Offensive",0,-4,-4,-8,-3,-1,0,-6,},{"Xuen's Bond",0,41,53,65,61,58,66,74,},{"Wild Hunt Tactics (Korayn)",98,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",206,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",128,0,0,0,0,0,0,0,},{"First Strike (Korayn)",30,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",260,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",71,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",32,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,78,86,94,107,112,123,131,},{"Calculated Strikes",0,-2,-4,-5,-1,0,-5,-8,},{"Inner Fury",0,48,43,42,53,60,63,68,},{"Coordinated Offensive",0,6,-8,1,-2,8,-5,-1,},{"Gnashing Chompers (Emeni)",2,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",48,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",106,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",119,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",9,0,0,0,0,0,0,0,},{"Xuen's Bond",0,36,34,36,58,45,53,56,},{"Lead by Example (4 Allies) (Emeni)",145,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",99,0,0,0,0,0,0,0,},},},
		[268] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,39,39,43,50,50,49,48,},{"Walk with the Ox",0,334,359,368,376,394,417,419,},{"Scalding Brew",0,10,18,22,24,27,20,34,},{"Bron's Call to Action (Mikanikos)",146,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",15,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",21,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",100,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",80,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",53,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",86,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",147,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,38,52,54,53,56,68,63,},{"Walk with the Ox",0,329,349,367,371,388,404,423,},{"Scalding Brew",0,18,32,28,32,31,30,33,},{"Built for War (Draven)",106,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",72,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",125,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",36,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",33,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",105,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",33,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",58,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,22,22,20,18,14,21,17,},{"Walk with the Ox",0,318,332,345,358,375,389,405,},{"Scalding Brew",0,28,26,34,36,29,23,34,},{"Wild Hunt Tactics (Korayn)",107,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",175,0,0,0,0,0,0,0,},{"First Strike (Korayn)",41,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",244,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",65,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",78,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",90,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,80,88,87,109,106,130,130,},{"Walk with the Ox",0,344,346,367,377,392,410,417,},{"Scalding Brew",0,16,19,21,23,27,33,37,},{"Lead by Example (2 Allies) (Emeni)",63,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",98,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",72,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",13,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-5,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",94,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",30,0,0,0,0,0,0,0,},},},
		[63] ={{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,90,104,114,118,116,137,137,},{"Master Flame",0,0,-8,-3,-7,-1,-8,-20,},{"Combat Meditation (Never Extend) (Pelagos)",156,0,0,0,0,0,0,0,},{"Ire of the Ascended",0,77,88,73,91,91,115,114,},{"Infernal Cascade",0,392,430,481,513,556,595,643,},{"Bron's Call to Action (Mikanikos)",84,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",207,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",18,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",69,0,0,0,0,0,0,0,},{"Flame Accretion",0,-28,-29,-17,-12,-22,-12,-9,},{"Pointed Courage (5 Allies) (Kleia)",122,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-6,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",222,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,81,103,110,98,126,142,146,},{"Infernal Cascade",0,398,446,478,526,566,611,654,},{"Siphoned Malice",0,61,64,66,77,78,85,95,},{"Master Flame",0,-1,-1,-11,-1,2,-6,-10,},{"Flame Accretion",0,-48,-34,-36,-28,-22,-29,-13,},{"Built for War (Draven)",168,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",149,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",32,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",95,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",44,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",21,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",75,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",81,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,102,106,116,137,135,152,147,},{"Master Flame",0,7,6,5,-8,9,9,4,},{"Infernal Cascade",0,420,484,529,566,617,655,699,},{"Niya's Tools: Poison (Niya)",168,0,0,0,0,0,0,0,},{"Discipline of the Grove",0,154,157,175,187,182,169,177,},{"Wild Hunt Tactics (Korayn)",175,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",62,0,0,0,0,0,0,0,},{"Flame Accretion",0,-47,-50,-41,-51,-22,-26,-19,},{"Niya's Tools: Burrs (Niya)",277,0,0,0,0,0,0,0,},{"First Strike (Korayn)",14,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",77,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",86,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-4,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,103,107,115,130,136,152,150,},{"Master Flame",0,6,-2,4,-2,3,5,0,},{"Lead by Example (0 Allies) (Emeni)",104,0,0,0,0,0,0,0,},{"Gift of the Lich",0,21,19,28,29,28,12,24,},{"Infernal Cascade",0,420,468,521,555,597,639,684,},{"Forgeborne Reveries (Heirmir)",155,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",45,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",2,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",235,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",159,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",53,0,0,0,0,0,0,0,},{"Flame Accretion",0,-32,-25,-22,-24,-9,-14,-3,},},},
	},
}

CovenantForge.BaseValues ={
	["PreRaid"]={
		[255] ={3500,3468,3538,3483,},
		[262] ={4048,4053,4123,4166,},
		[62] ={4054,4035,4067,3976,},
		[263] ={4098,4130,4206,4147,},
		[64] ={3450,3622,3385,3430,},
		[66] ={2763,3105,2931,2852,},
		[70] ={3485,3758,3556,3500,},
		[72] ={3322,3535,3338,3270,},
		[578] ={2168,2183,2245,2123,},
		[265] ={3838,3491,3814,3695,},
		[577] ={3397,3533,3494,3491,},
		[253] ={3685,3623,3785,3685,},
		[258] ={4141,4120,4029,4155,},
		[266] ={3468,3443,3490,3548,},
		[104] ={2233,2230,2397,2418,},
		[103] ={3551,3485,3729,3493,},
		[259] ={3540,3538,3512,3483,},
		[267] ={3511,3481,3541,3621,},
		[250] ={2128,2104,2017,2111,},
		[254] ={3833,3713,3926,3841,},
		[260] ={4119,4078,4029,4016,},
		[71] ={3307,3758,3350,3292,},
		[73] ={2308,2385,2333,2242,},
		[102] ={4090,4019,4194,4016,},
		[261] ={4325,4243,4232,4205,},
		[269] ={3929,3664,3720,3717,},
		[268] ={2863,2729,2706,2743,},
		[63] ={3631,3670,3626,3575,},
	},
	["T26"]={
		[255] ={5190,5157,5246,5163,},
		[262] ={5979,5998,6103,6144,},
		[62] ={5989,5915,6073,5885,},
		[263] ={6152,6204,6279,6237,},
		[64] ={5169,5380,5073,5145,},
		[66] ={4244,4741,4466,4347,},
		[70] ={5244,5630,5350,5259,},
		[72] ={5161,5533,5190,5116,},
		[578] ={3291,3324,3402,3210,},
		[265] ={5757,5386,5680,5542,},
		[577] ={5041,5267,5173,5205,},
		[253] ={5456,5383,5586,5438,},
		[258] ={6241,6205,6063,6249,},
		[266] ={5165,5131,5199,5276,},
		[104] ={3430,3418,3624,3699,},
		[103] ={5466,5372,5659,5396,},
		[259] ={5386,5398,5357,5311,},
		[267] ={5246,5202,5318,5422,},
		[250] ={3385,3327,3270,3343,},
		[254] ={5753,5605,5868,5734,},
		[260] ={6054,6011,5952,5914,},
		[71] ={5046,5745,5100,5040,},
		[73] ={3565,3716,3590,3458,},
		[102] ={6200,6047,6257,6132,},
		[261] ={6363,6239,6229,6183,},
		[269] ={5822,5431,5508,5477,},
		[268] ={4187,4041,4007,4058,},
		[63] ={5500,5513,5556,5382,},
	},
}

CovenantForge.Soulbinds ={
	[336472] = "Shivering Core",
	[326514] = "Forgeborne Reveries",
	[336852] = "Master Flame",
	[336460] = "Unrelenting Cold",
	[326512] = "Runeforged Spurs",
	[322721] = "Grove Invigoration",
	[337162] = "Depths of Insanity",
	[331612] = "Sparkling Driftglobe Core",
	[328258] = "Ever Forward",
	[339377] = "Harmony of the Tortollan",
	[338330] = "Insatiable Appetite",
	[338516] = "Debilitating Malady",
	[339558] = "Cheetah's Vigor",
	[339129] = "Necrotic Barrage",
	[339374] = "Truth's Wake",
	[341532] = "Fade to Nothing",
	[341450] = "Front of the Pack",
	[336821] = "Infernal Cascade",
	[338329] = "Embrace of Earth",
	[336239] = "Soothing Shade",
	[331610] = "Charged Additive",
	[338787] = "Shielding Words",
	[347213] = "Fueled by Violence",
	[338342] = "Dissonant Echoes",
	[340041] = "Infernal Brand",
	[338332] = "Mind Devourer",
	[336773] = "Jade Bond",
	[339228] = "Dancing with Fate",
	[340268] = "Fatal Decimation",
	[339182] = "Elysian Dirge",
	[337891] = "Swift Penitence",
	[336569] = "Ice Bite",
	[339576] = "Cold Embrace",
	[339973] = "Deadly Chain",
	[331611] = "Soulsteel Clamps",
	[320662] = "Niya's Tools: Herbs",
	[339411] = "Demonic Momentum",
	[340033] = "Powerful Precision",
	[340348] = "Soul Eater",
	[337134] = "Celestial Effervescence",
	[337240] = "Artifice of the Archmage",
	[329779] = "Bearer's Pursuit",
	[337058] = "Ire of the Ascended",
	[339268] = "Light's Barding",
	[339500] = "Focused Malignancy",
	[340543] = "Innate Resolve",
	[337286] = "Strike with Clarity",
	[337301] = "Imbued Reflections",
	[339924] = "Brutal Projectiles",
	[341650] = "Emeni's Ambulatory Flesh",
	[339231] = "Growing Inferno",
	[338671] = "Fel Defender",
	[337264] = "Walk with the Ox",
	[336999] = "Gift of the Lich",
	[331576] = "Agent of Chaos",
	[341446] = "Conflux of Elements",
	[331586] = "Thrill Seeker",
	[329791] = "Valiant Strikes",
	[319211] = "Soothing Voice",
	[341531] = "Quick Decisions",
	[339186] = "Tumbling Waves",
	[341440] = "Bloodletting",
	[332756] = "Expedition Leader",
	[325068] = "Face Your Foes",
	[338345] = "Holy Oration",
	[341447] = "Evolved Swarm",
	[319210] = "Social Butterfly",
	[323095] = "Ultimate Form",
	[341280] = "Born Anew",
	[339712] = "Resplendent Light",
	[336379] = "Harm Denial",
	[336140] = "Watch the Shoes!",
	[340218] = "Ringing Clarity",
	[341383] = "Endless Thirst",
	[339578] = "Borne of Blood",
	[337790] = "Exaltation",
	[341537] = "Well-Placed Steel",
	[329781] = "Resonant Accolades",
	[340616] = "Flash of Clarity",
	[336812] = "Resplendent Mist",
	[337123] = "Cryo-Freeze",
	[337954] = "Mental Recovery",
	[339114] = "Golden Path",
	[326509] = "Heirmir's Arsenal: Ravenous Pendant",
	[338346] = "Nature's Focus",
	[324441] = "Hearth Kidneystone",
	[339183] = "Essential Extraction",
	[340549] = "Unstoppable Growth",
	[338131] = "High Voltage",
	[340719] = "Umbral Intensity",
	[340562] = "Diabolic Bloodstone",
	[340686] = "Incessant Hunter",
	[333935] = "Hammer of Genesis",
	[340720] = "Stellar Inspiration",
	[337972] = "Hardened Bones",
	[337957] = "Blood Bond",
	[342156] = "Lead by Example",
	[331726] = "Regenerating Materials",
	[341272] = "Sudden Fractures",
	[338664] = "Proliferation",
	[337884] = "Withering Plague",
	[337293] = "Tempest Barrier",
	[338435] = "Meat Shield",
	[337302] = "Vicious Contempt",
	[344358] = "Unnatural Malice",
	[335010] = "Brutal Vitality",
	[339264] = "Markman's Advantage",
	[337678] = "Move with Grace",
	[336452] = "Inner Fury",
	[338033] = "Thunderous Paws",
	[341399] = "Flame Infusion",
	[320659] = "Niya's Tools: Burrs",
	[339890] = "Duplicitous Havoc",
	[340063] = "Brooding Pool",
	[338799] = "Felfire Haste",
	[338651] = "Brutal Grasp",
	[338303] = "Call of Flame",
	[320668] = "Nature's Splendor",
	[338338] = "Rabid Shadows",
	[341543] = "Sleight of Hand",
	[336147] = "Leisurely Gait",
	[339939] = "Destructive Reverberations",
	[340159] = "Service In Stone",
	[337295] = "Bone Marrow Hops",
	[340012] = "Punish the Guilty",
	[332753] = "Superior Tactics",
	[336890] = "Dizzying Tumble",
	[341546] = "Count the Odds",
	[336636] = "Flow of Time",
	[339149] = "Lost in Darkness",
	[338319] = "Haunting Apparitions",
	[323079] = "Kevin's Keyring",
	[325073] = "Get In Formation",
	[337811] = "Lasting Spirit",
	[341451] = "Born of the Wilds",
	[319973] = "Built for War",
	[323921] = "Emeni's Magnificent Skin",
	[325601] = "Hold the Line",
	[341310] = "Lashing Scars",
	[339370] = "Harrowing Punishment",
	[337778] = "Shining Radiance",
	[341311] = "Nimble Fingers",
	[346747] = "Ambuscade",
	[336616] = "Xuen's Bond",
	[339292] = "Wrench Evil",
	[341344] = "Withering Ground",
	[336613] = "Winter's Protection",
	[340553] = "Well-Honed Instincts",
	[338054] = "Crippling Hex",
	[338331] = "Magma Fist",
	[337981] = "Vital Accretion",
	[338682] = "Viscous Ink",
	[339518] = "Virtuous Command",
	[339265] = "Veteran's Repute",
	[334066] = "Mentorship",
	[339920] = "Sharpshooter's Focus",
	[336522] = "Icy Propulsion",
	[323916] = "Sulfuric Emission",
	[340006] = "Vengeful Shock",
	[339948] = "Disturb the Peace",
	[340540] = "Ursine Vigor",
	[331579] = "Friends in Low Places",
	[339987] = "Untempered Dedication",
	[338318] = "Unruly Winds",
	[340605] = "Layered Mane",
	[337154] = "Unnerving Focus",
	[338492] = "Unleashed Frenzy",
	[323918] = "Gristled Toes",
	[340552] = "Unchecked Aggression",
	[328266] = "Combat Meditation",
	[337084] = "Tumbling Technique",
	[341540] = "Triple Threat",
	[337250] = "Evasive Stride",
	[337662] = "Translucent Image",
	[337119] = "Scalding Brew",
	[340682] = "Taste for Blood",
	[340028] = "Increased Scrutiny",
	[340545] = "Tireless Pursuit",
	[340185] = "The Long Summer",
	[339531] = "Templar's Vindication",
	[338042] = "Totemic Surge",
	[337947] = "Resonant Words",
	[340694] = "Sudden Ambush",
	[337099] = "Rising Sun Revival",
	[338339] = "Swirling Currents",
	[339984] = "Focused Light",
	[336247] = "Life of the Party",
	[58081] = "Kilrogg's Cunning",
	[338089] = "Fleeting Wind",
	[339386] = "Mortal Combo",
	[339818] = "Show of Force",
	[337078] = "Swift Transference",
	[341222] = "Strength of the Pack",
	[339124] = "Pure Concentration",
	[339018] = "Enfeebled Mark",
	[339495] = "Reversal of Fortune",
	[338252] = "Shake the Foundations",
	[329786] = "Road of Trials",
	[323090] = "Plaguey's Preemptive Strike",
	[339587] = "Demon Muzzle",
	[341559] = "Stiletto Staccato",
	[334993] = "Stalwart Guardian",
	[338048] = "Spiritual Resonance",
	[337822] = "Accelerated Cold",
	[336853] = "Fortifying Ingredients",
	[319213] = "Empowered Chrysalis",
	[336632] = "Grounding Breath",
	[337705] = "Spirit Drain",
	[338628] = "Impenetrable Gloom",
	[338741] = "Divine Call",
	[337275] = "Incantation of Swiftness",
	[341312] = "Recuperator",
	[335260] = "Merciless Bonegrinder",
	[340229] = "Soul Tithe",
	[337241] = "Nourishing Chi",
	[339423] = "Soul Furnace",
	[337087] = "Siphoned Malice",
	[341549] = "Deeper Daggers",
	[339845] = "Fel Commando",
	[340529] = "Tough as Bark",
	[336245] = "Token of Appreciation",
	[336526] = "Calculated Strikes",
	[333950] = "Bron's Call to Action",
	[336777] = "Grounding Surge",
	[339230] = "Serrated Glaive",
	[331577] = "Fancy Footwork",
	[331609] = "Forgelite Filter",
	[337224] = "Flame Accretion",
	[341309] = "Septic Shock",
	[341529] = "Cloaked in Shadows",
	[339379] = "Shade of Terror",
	[339259] = "Piercing Verdict",
	[339644] = "Roaring Fire",
	[335196] = "Safeguard",
	[338566] = "Lingering Plague",
	[341534] = "Rushed Setup",
	[340212] = "Hallowed Discernment",
	[328263] = "Cleansed Vestments",
	[340030] = "Royal Decree",
	[338343] = "Heavy Rainfall",
	[320687] = "Swift Patrol",
	[341350] = "Deadly Tandem",
	[337966] = "Courageous Ascension",
	[339481] = "Rolling Agony",
	[320658] = "Stay on the Move",
	[338315] = "Shattered Perceptions",
	[339651] = "Tactical Retreat",
	[332754] = "Hold Your Ground",
	[337764] = "Reinforced Shell",
	[342270] = "Run Without Tiring",
	[339272] = "Resolute Barrier",
	[339459] = "Resilience of the Hunter",
	[339895] = "Repeat Decree",
	[339151] = "Relentless Onslaught",
	[339371] = "Expurgation",
	[339185] = "Lavish Harvest",
	[339048] = "Demonic Parole",
	[341538] = "Maim, Mangle",
	[339399] = "Rejuvenating Wind",
	[337748] = "Light's Inspiration",
	[340023] = "Resolute Defender",
	[323081] = "Plagueborn Cleansing Slime",
	[319978] = "Enduring Gloom",
	[337974] = "Refreshing Waters",
	[340550] = "Ready for Anything",
	[338835] = "Ravenous Consumption",
	[336191] = "Indelible Victory",
	[345594] = "Pyroclastic Shock",
	[335250] = "Cacophonous Roar",
	[340706] = "Precise Alignment",
	[337762] = "Power Unto Others",
	[341536] = "Poisoned Katar",
	[341556] = "Planned Execution",
	[339896] = "Combusting Engine",
	[340609] = "Savage Combatant",
	[340876] = "Echoing Call",
	[341567] = "Perforated Veins",
	[337786] = "Pain Transformation",
	[319214] = "Faerie Dust",
	[337715] = "Charitable Soul",
	[339455] = "Corrupting Leer",
	[336886] = "Nether Precision",
	[341378] = "Deep Allegiance",
	[341325] = "Controlled Destruction",
	[337934] = "Eradicating Blow",
	[338325] = "Chilled to the Core",
	[338793] = "Shattered Restoration",
	[339766] = "Tyrant's Soul",
	[326507] = "Resourceful Fleshcrafting",
	[336184] = "Exquisite Ingredients",
	[319216] = "Somnambulist",
	[340621] = "Floral Recycling",
	[319191] = "Field of Blossoms",
	[340316] = "Catastrophic Origin",
	[341246] = "Stinging Strike",
	[337303] = "Way of the Fae",
	[335242] = "Crash the Ramparts",
	[338305] = "Fae Fermata",
	[331580] = "Exacting Preparation",
	[329777] = "Phial of Patience",
	[337192] = "Magi's Brand",
	[341535] = "Prepared for All",
	[341542] = "Ambidexterity",
	[337214] = "Hack and Slash",
	[339130] = "Fel Celerity",
	[332755] = "Unbreakable Body",
	[336884] = "Lingering Numbness",
	[337979] = "Festering Transfusion",
	[341539] = "Lethal Poisons",
	[325066] = "Wild Hunt Tactics",
	[338322] = "Focused Lightning",
	[329778] = "Pointed Courage",
	[326513] = "Bonesmith's Satchel",
	[341264] = "Reverberation",
	[326504] = "Serrated Spaulders",
	[337136] = "Diverted Energy",
	[331584] = "Dauntless Duelist",
	[328265] = "Bond of Friendship",
	[337964] = "Astral Protection",
	[340705] = "Carnivorous Instinct",
	[337707] = "Clear Mind",
	[339109] = "Spirit Attunement",
	[339750] = "One With the Beast",
	[326572] = "Heirmir's Arsenal: Marrowed Gemstone",
	[325069] = "First Strike",
	[335034] = "Inspiring Presence",
	[319983] = "Wasteland Propriety",
	[329784] = "Cleansing Rites",
	[325067] = "Horn of the Wild Hunt",
	[323089] = "Travel with Bloop",
	[329776] = "Ascendant Phial",
	[336243] = "Refined Palate",
	[338311] = "Unending Grip",
	[319217] = "Podtender",
	[339316] = "Echoing Blessings",
	[339892] = "Ashen Remains",
	[324440] = "Cartilaginous Legs",
	[338553] = "Convocation of the Dead",
	[323091] = "Ooz's Frictionless Coating",
	[339570] = "Enkindled Spirit",
	[336873] = "Arcane Prodigy",
	[337914] = "Focused Mending",
	[323919] = "Gnashing Chompers",
	[325072] = "Vorkai Sharpening Techniques",
	[339656] = "Carnivorous Stalkers",
	[320660] = "Niya's Tools: Poison",
	[339704] = "Ferocious Appetite",
	[337988] = "Everfrost",
	[337381] = "Eternal Hunger",
	[323074] = "Volatile Solvent",
	[336992] = "Discipline of the Grove",
	[325065] = "Wild Hunt's Charge",
	[339059] = "Empowered Release",
	[337980] = "Embrace Death",
	[340708] = "Fury of the Skies",
	[326511] = "Heirmir's Arsenal: Gorestompers",
	[328261] = "Focusing Mantra",
	[339282] = "Accrued Vitality",
	[340192] = "Righteous Might",
	[331725] = "Resilient Plumage",
	[328257] = "Let Go of the Past",
	[336598] = "Coordinated Offensive",
	[335232] = "Ashen Juggernaut",
	[319982] = "Move As One",
	[337704] = "Chilled Resilience",
	[331582] = "Familiar Predicaments",
}


local playerInv_DB
local Profile
local playerNme
local realmName
local playerClass, classID,_
local viewed_spec
CovenantForge.conduitList = {}
local CONDUIT_RANKS = {
	[1] = C_Soulbinds.GetConduitItemLevel(0, 1),
	[2] = C_Soulbinds.GetConduitItemLevel(0, 2),
	[3] = C_Soulbinds.GetConduitItemLevel(0, 3),
	[4] = C_Soulbinds.GetConduitItemLevel(0, 4),
	[5] = C_Soulbinds.GetConduitItemLevel(0, 5),
	[6] = C_Soulbinds.GetConduitItemLevel(0, 6),
	[7] = C_Soulbinds.GetConduitItemLevel(0, 7),
	[8] = C_Soulbinds.GetConduitItemLevel(0, 8),
}

local DB_Defaults = {
	char_defaults = {
		profile = {
			item = {},
			set = {},
			extraset = {},
			outfits = {},
			lastTransmogOutfitIDSpec = {},
			listUpdate = false,
		}
	},
}
local WEIGHT_BASE = 37.75

--ACE3 Option Handlers
local optionHandler = {}
function optionHandler:Setter(info, value)
	CovenantForge.Profile[info[#info]] = value
	if SoulbindViewer:IsShown() then
		CovenantForge:Update()
	end
end


function optionHandler:Getter(info)
	return CovenantForge.Profile[info[#info]]
end

local options = {
	name = CovenantForgeLocal,
	handler = optionHandler,
	get = "Getter",
	set = "Setter",
	type = 'group',
	childGroups = "tab",
	inline = true,
	args = {
		settings={
			name = "Options",
			type = "group",
			inline = false,
			order = 0,
			args = {
				Options_Header = {
					order = 1,
					name = "General Options",
					type = "header",
					width = "full",
				},
				
				ShowSoulbindNames = {
					order = 3,
					name = "Show Soulbind Name",
					type = "toggle",
					width = "full",
					arg = "ShowSoulbindNames",
				},

				ShowNodeNames = {
					order = 3.1,
					name = "Show Node Ability Names",
					type = "toggle",
					width = "full",
					arg = "ShowNodeNames",
				},
				ShowWeights = {
					order = 4,
					name = "Show Weights",
					type = "toggle",
					width = "full",
					arg = "ShowWeights",
				},
				HideZeroValues = {
					order = 5,
					name = "Hide Weight Values That Are 0",
					type = "toggle",
					width = "full",
					arg = "ShowWeights",
				},

				ShowAsPercent = {
					order = 4,
					name = "Show Weight as Percent",
					type = "toggle",
					width = "full",
					arg = "ShowAsPercent",
				},

				disableFX = {
					order = 5.1,
					name = "Disable FX",
					width = "full",
					type = "toggle",
				},

				ShowTooltipRank = {
					order = 6,
					name = "Show Conduit Rank on Tooltip",
					type = "toggle",
					width = "full",
				},
			},
		},
	},
}

local defaults = {
	profile = {
				['*'] = true,
				disableFX = false,
			},
}

local pathDefaults = {
	char ={
		paths = {},
		selectedProfile = 1,
	},
}

local weightDefaults = {
	class ={
		weights = {},
		base = {},
	},
}

---Ace based CovenantForge initilization
function CovenantForge:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("CovenantForgeDB", defaults, true)
	self.savedPathdb = LibStub("AceDB-3.0"):New("CovenantForgeSavedPaths", pathDefaults, true)
	self.weightdb = LibStub("AceDB-3.0"):New("CovenantForgeWeights", weightDefaults, true)

	CovenantForge.Profile = self.db.profile
	options.args.profiles  = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.weights  = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.weightdb)
	options.args.weights.name = "Weights"
	LibStub("AceConfigRegistry-3.0"):ValidateOptionsTable(options, "CovenantForge")
	LibStub("AceConfig-3.0"):RegisterOptionsTable("CovenantForge", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("CovenantForge", CovenantForgeLocal)
	--self.db.RegisterCallback(OmegaMap, "OnProfileChanged", "RefreshConfig")
	--self.db.RegisterCallback(OmegaMap, "OnProfileCopied", "RefreshConfig")
	--self.db.RegisterCallback(OmegaMap, "OnProfileReset", "RefreshConfig")



	CovenantForge:RegisterEvent("ADDON_LOADED", "EventHandler" )

end

function CovenantForge:EventHandler(event, arg1 )
	if event == "ADDON_LOADED" and arg1 == "Blizzard_Soulbinds" and C_Covenants.GetActiveCovenantID() ~= 0 then 
		C_Timer.After(0, function() CovenantForge.Init:CreateSoulbindFrames() end)

		self:SecureHook(SoulbindViewer, "Open", function()  C_Timer.After(.05, function() CovenantForge:Update() end) end , true)
			--CovenantForge:Hook(ConduitListConduitButtonMixin, "Init", "ConduitRank", true)
		self:SecureHook(SoulbindViewer, "SetSheenAnimationsPlaying", "StopAnimationFX")
		self:SecureHook(SoulbindTreeNodeLinkMixin, "SetState", "StopNodeFX")
		self:UnregisterEvent("ADDON_LOADED")
	elseif event == "COVENANT_CHOSEN" then 
		CovenantForge:EventHandler("ADDON_LOADED", "Blizzard_Soulbinds")
		CovenantForge:OnEnable()
		self:UnregisterEvent("ADDON_LOADED")
	end

end

local SoulbindConduitNodeEvents =
{
	"SOULBIND_CONDUIT_INSTALLED",
	"SOULBIND_CONDUIT_UNINSTALLED",
	"SOULBIND_PENDING_CONDUIT_CHANGED",
	"SOULBIND_CONDUIT_COLLECTION_UPDATED",
	"SOULBIND_CONDUIT_COLLECTION_REMOVED",
	"SOULBIND_CONDUIT_COLLECTION_CLEARED",
	"PLAYER_SPECIALIZATION_CHANGED",
	"SOULBIND_NODE_LEARNED",
	"SOULBIND_PATH_CHANGED",
	"SOULBIND_ACTIVATED",
}

function CovenantForge:OnEnable()
	--If not part of a covenant wait until one is chosen
	if C_Covenants.GetActiveCovenantID() == 0 then
		CovenantForge:RegisterEvent("COVENANT_CHOSEN", "EventHandler" )
		return 
	end
	CovenantForge:BuildWeightData()
	CovenantForge:GetClassConduits()
	local spec = GetSpecialization()
	CovenantForge.viewed_spec = GetSpecializationInfo(spec)

	self:SecureHookScript(GameTooltip, "OnTooltipSetItem", "GenerateToolip")
	self:SecureHookScript(ItemRefTooltip, "OnTooltipSetItem", "GenerateToolip")
	self:SecureHookScript(EmbeddedItemTooltip,"OnTooltipSetItem", "GenerateToolip")

		hooksecurefunc(GameTooltip, "SetQuestItem", function(tooltip)
		CovenantForge:GenerateToolip(tooltip)
	end)


	hooksecurefunc(GameTooltip, "SetQuestLogItem", function(tooltip)
		CovenantForge:GenerateToolip(tooltip)
	end)
end

local CLASS_SPECS ={{71,72,73},{65,66,70},{253,254,255},{259,260,261},{256,257,258},{250,251,252},{262,263,264},{62,63,64},{265,266,267},{268,270,69},{102,103,104,105},{577,578}}
local currentTab = 1
local scroll
local scrollcontainer
function CovenantForge.Init:CreateSoulbindFrames()
	local frame = CreateFrame("Frame", "CovForge_events", SoulbindViewer)
	
	frame:SetScript("OnShow", function() FrameUtil.RegisterFrameForEvents(frame, SoulbindConduitNodeEvents) end)
	frame:SetScript("OnHide", function() FrameUtil.UnregisterFrameForEvents(frame, SoulbindConduitNodeEvents ); currentTab = 1 end)
	frame:SetScript("OnEvent", CovenantForge.Update)
	--frame:Show()
	FrameUtil.RegisterFrameForEvents(frame, SoulbindConduitNodeEvents);
	local covenantID = C_Covenants.GetActiveCovenantID();
	--local soulbindID = C_Soulbinds.GetActiveSoulbindID();

	local spec = GetSpecialization()
	local specID, specName = GetSpecializationInfo(spec)
	--local soulbindData = C_Soulbinds.GetSoulbindData(1).name;

	--SoulbindViewer.SelectGroup
	for buttonIndex, button in ipairs(SoulbindViewer.SelectGroup.buttonGroup:GetButtons()) do
		CovenantForge:Hook(button, "OnSelected", function() CovenantForge:Update() end , true)

		local f = CreateFrame("Frame", "CovForge_Souldbind"..buttonIndex, button, "CovenantForge_SoulbindInfoTemplate")
		button.ForgeInfo = f
	end

	for buttonIndex, nodeFrame in pairs(SoulbindViewer.Tree:GetNodes()) do
		local f = CreateFrame("Frame", "CovForge_Conduit"..buttonIndex, nodeFrame, "CovenantForge_ConduitInfoTemplate")
		nodeFrame.ForgeInfo = f
	end

	local _, _, classID = UnitClass("player")
	local classSpecs = CLASS_SPECS[classID]
	local dropdownList = {}
	for index,ID in ipairs(classSpecs) do
		local specID, specName = GetSpecializationInfo(index)
		dropdownList[ID] = specName
	end

	--Spec Selection Dropdown
	local frame = AceGUI:Create("SimpleGroup")
	frame.frame:SetParent(SoulbindViewer)
	frame:SetHeight(20)
	frame:SetWidth(125)
	frame:SetPoint("TOP",SoulbindViewer,"TOP", 105, -33)
	frame:SetLayout("Fill")
	local dropdown = AceGUI:Create("Dropdown")
	frame:AddChild(dropdown)
	dropdown:SetList(dropdownList)
	local spec = GetSpecialization()
	local specID = GetSpecializationInfo(spec)
	dropdown:SetValue(specID)
	dropdown:SetCallback("OnValueChanged", function(self,event, key) CovenantForge.viewed_spec = key; CovenantForge:Update() end)

	local f = CreateFrame("Frame", "CovForge_WeightTotal", SoulbindViewer, "CovenantForge_WeightTotalTemplate")
	CovenantForge.CovForge_WeightTotalFrame = f
	f:Show()
	f:ClearAllPoints()
	f:SetPoint("BOTTOM",SoulbindViewer.ActivateSoulbindButton,"BOTTOM", 0, 25)

	CovenantForge:Hook(SoulbindViewer, "UpdateCommitConduitsButton", function()CovenantForge.CovForge_WeightTotalFrame:SetShown(not SoulbindViewer.CommitConduitsButton:IsShown()) end, true)
	--CovenantForge.CovForge_WeightTotalFrame:SetShown(not SoulbindViewer.CommitConduitsButton:IsShown())
	CovenantForge:Update()

	f = CreateFrame("Frame", "CovForge_PathStorage", SoulbindViewer, "CovenantForge_PathStorageTemplate")
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", SoulbindViewer.ConduitList, "TOPLEFT", 10, 0)
	f:SetPoint("BOTTOMRIGHT", SoulbindViewer.ConduitList, "BOTTOMRIGHT" , 10, -40)
	CovenantForge.PathStorageFrame = f
	f.Background:SetDesaturated(true)
	f.Background:SetAlpha(0.3)
	local covenantData = C_Covenants.GetCovenantData(C_Covenants.GetActiveCovenantID());
	f.Background:SetAtlas(("ui-frame-%schoice-cardparchment"):format(covenantData.textureKit))
	f:Hide()

	CovenantForge.PathStorageFrame.TabList = {}
	local DefaultsTab = CreateFrame("CheckButton", "$parentTab1", SoulbindViewer, "CovenantForge_TabTemplate", 1)
   -- PathTab:SetSize(50,50)
	DefaultsTab:SetPoint("TOPRIGHT", SoulbindViewer, "TOPRIGHT", 30, -20)
	DefaultsTab.tooltip = "Learned Conduits"
	DefaultsTab:Show()
	DefaultsTab.TabardEmblem:SetTexture("Interface/ICONS/Ability_Monk_EssenceFont")
	DefaultsTab.tabIndex = 1
	DefaultsTab:SetChecked(true)
	table.insert(CovenantForge.PathStorageFrame.TabList ,DefaultsTab )


	local PathTab = CreateFrame("CheckButton", "$parentTab2", SoulbindViewer, "CovenantForge_TabTemplate", 1)
   -- PathTab:SetSize(50,50)
	PathTab:SetPoint("TOPRIGHT", DefaultsTab, "BOTTOMRIGHT", 0, -20)
	PathTab.tooltip = "Saved Paths"
	PathTab:Show()
	PathTab.TabardEmblem:SetTexture("Interface/ICONS/Ability_Druid_FocusedGrowth")
	PathTab.tabIndex = 2
	table.insert(CovenantForge.PathStorageFrame.TabList,PathTab )

	local ConduitTab = CreateFrame("CheckButton", "$parentTab3", SoulbindViewer, "CovenantForge_TabTemplate", 1)
   -- PathTab:SetSize(50,50)
	ConduitTab:SetPoint("TOPRIGHT", PathTab, "BOTTOMRIGHT", 0, -20)
	ConduitTab.tooltip = "Avaiable Conduits"
	ConduitTab:Show()
	ConduitTab.TabardEmblem:SetTexture("Interface/ICONS/70_inscription_steamy_romance_novel_kit")
	ConduitTab.tabIndex = 3
	table.insert(CovenantForge.PathStorageFrame.TabList,ConduitTab )

	local WeightsTab = CreateFrame("CheckButton", "$parentTab4", SoulbindViewer, "CovenantForge_TabTemplate", 1)
   -- PathTab:SetSize(50,50)
	WeightsTab:SetPoint("TOPRIGHT", ConduitTab, "BOTTOMRIGHT", 0, -20)
	WeightsTab.tooltip = "Weights"
	WeightsTab:Show()
	WeightsTab.TabardEmblem:SetTexture("Interface/ICONS/INV_Stone_WeightStone_06.blp")
	WeightsTab.tabIndex = 4
	table.insert(CovenantForge.PathStorageFrame.TabList,WeightsTab )

	scrollcontainer = AceGUI:Create("SimpleGroup") -- "InlineGroup" is also good
	scrollcontainer.frame:SetParent(CovenantForge.PathStorageFrame)
	scrollcontainer:ClearAllPoints()
	scrollcontainer:SetPoint("TOPLEFT", CovenantForge.PathStorageFrame,"TOPLEFT", 0, -55)
	scrollcontainer:SetPoint("BOTTOMRIGHT", CovenantForge.PathStorageFrame,"BOTTOMRIGHT", -15,15)
	scrollcontainer:SetFullWidth(true)
	scrollcontainer:SetFullHeight(true) -- probably?
	scrollcontainer:SetLayout("Fill")
	CovenantForge.scrollcontainer = scrollcontainer

	f:SetScript("OnHide", function() scrollcontainer:ReleaseChildren() end)
	f:SetScript("OnShow", function() CovenantForge:UpdateSavedPathsList() end)

	CovenantForge:UpdateSavedPathsList()
	if CovenantForge.ElvUIDelay then 
		CovenantForge.ElvUIDelay()
		ElvUIDelay = nil
	end

	frame = AceGUI:Create("SimpleGroup")
	frame.frame:SetParent(SoulbindViewer)
	frame:SetHeight(25)
	frame:SetWidth(25)
	frame:SetPoint("BOTTOMRIGHT",SoulbindViewer.ConduitList,"BOTTOMLEFT", -10, -40)
	local icon = AceGUI:Create("Icon") 
	icon:SetImage("Interface/Buttons/UI-OptionsButton")
	icon:SetHeight(20)
	icon:SetWidth(25)
	icon:SetImageSize(20,20)
	icon:SetCallback("OnClick", function() LibStub("AceConfigDialog-3.0"):Open("CovenantForge") end)
	frame:AddChild(icon)
end


function CovenantForgeSavedTab_OnClick(self)
	local currentTab = self.tabIndex
	for i, tab in ipairs(CovenantForge.PathStorageFrame.TabList) do
		tab:SetChecked(currentTab == i)
	end

	if currentTab == 1 then
		CovenantForge.PathStorageFrame:Hide()
		SoulbindViewer.ConduitList:Show()
	elseif currentTab == 2 then
		CovenantForge.PathStorageFrame:Show()
		SoulbindViewer.ConduitList:Hide()
		CovenantForge.PathStorageFrame.EditBox:Show()
		CovenantForge.PathStorageFrame.CreateButton:Show()
		CovenantForge.PathStorageFrame.Title:SetText("Saved Paths")
		CovenantForge:UpdateSavedPathsList()
	elseif currentTab == 3 then
		CovenantForge.PathStorageFrame:Show()
		SoulbindViewer.ConduitList:Hide()
		CovenantForge.PathStorageFrame.EditBox:Hide()
		CovenantForge.PathStorageFrame.CreateButton:Hide()
		CovenantForge.PathStorageFrame.Title:SetText("Conduits")
		CovenantForge:UpdateConduitList()
	elseif currentTab == 4 then
		CovenantForge.PathStorageFrame:Show()
		SoulbindViewer.ConduitList:Hide()
		CovenantForge.PathStorageFrame.EditBox:Hide()
		CovenantForge.PathStorageFrame.CreateButton:Hide()
		CovenantForge.PathStorageFrame.Title:SetText("Weights")
		CovenantForge:UpdateWeightList()
	end
end

local filterValue = 1
local filteredList = CovenantForge.conduitList
function CovenantForge:UpdateConduitList()
	if not SoulbindViewer or (SoulbindViewer and not SoulbindViewer:IsShown()) or
 		not CovenantForge.scrollcontainer then return end

 	local filter = {"All", 	Soulbinds.GetConduitName(0),Soulbinds.GetConduitName(1),Soulbinds.GetConduitName(2), "Soulbinds"}

	scrollcontainer:ReleaseChildren()
	scrollcontainer:SetPoint("TOPLEFT", CovenantForge.PathStorageFrame,"TOPLEFT", 0, -25)

	scroll = AceGUI:Create("ScrollFrame")
	scroll:SetLayout("Flow") -- probably?
	scrollcontainer:AddChild(scroll)

	dropdown = AceGUI:Create("Dropdown")
	dropdown:SetFullWidth(false)
	dropdown:SetWidth(200)
	scroll:AddChild(dropdown)
	dropdown:SetList(filter)
	dropdown:SetValue(filterValue)
	dropdown:SetCallback("OnValueChanged", 
		function(self,event, key) 
			--print("SDF")
			filterValue = key; 
			if key == 1 then 
				filteredList = CovenantForge.conduitList
			else 
				filteredList = {CovenantForge.conduitList[key-2]}
			end
			CovenantForge:UpdateConduitList()
		end)

	for i, typedata in pairs(filteredList) do
		local index = i
		if #filteredList == 1 then 
			index = filterValue - 2
		end
		local collectionData = C_Soulbinds.GetConduitCollection(index)

		local topHeading = AceGUI:Create("Heading") 
		topHeading:SetRelativeWidth(1)
		topHeading:SetHeight(5)
		local bottomHeading = AceGUI:Create("Heading") 
		bottomHeading:SetRelativeWidth(1)
		bottomHeading:SetHeight(5)

		local label = AceGUI:Create("Label") 
			label:SetText(Soulbinds.GetConduitName(index))
			local atlas = Soulbinds.GetConduitEmblemAtlas(index);
			--label:SetImage(icon)
			label:SetImage("Interface/Buttons/UI-OptionsButton")

			label.image:SetAtlas(atlas)
			label:SetFontObject(GameFontHighlightLarge)

			--label.image.imageshown = true
			label:SetImageSize(30,30)
			label:SetRelativeWidth(1)
			scroll:AddChild(topHeading)
			scroll:AddChild(label)
			scroll:AddChild(bottomHeading)

		for i, data in pairs(typedata) do
			for _,spec in ipairs(data[4]) do
				if CovenantForge.viewed_spec == spec then 
					local name = data[1]
					local type = Soulbinds.GetConduitName(data[3])
					local spellID = data[2]
					local desc = GetSpellDescription(spellID)
					local _,_, icon = GetSpellInfo(spellID)
					local titleColor = ORANGE_FONT_COLOR_CODE
					for _, data in ipairs(collectionData) do
						local c_spellID = C_Soulbinds.GetConduitSpellID(data.conduitID, data.conduitRank)
						if c_spellID == spellID then 
							titleColor = GREEN_FONT_COLOR_CODE
							break
						end
					end
					local weight = CovenantForge:GetConduitWeight(CovenantForge.viewed_spec, i)
					if weight then
						if weight > 0 then
							if CovenantForge.Profile.ShowAsPercent then 
								weight = CovenantForge:GetWeightPercent(weight).."%"
							end
							weight = GREEN_FONT_COLOR_CODE.."(+"..weight..")"
						elseif weight < 0 then
							if CovenantForge.Profile.ShowAsPercent then 
								weight = CovenantForge:GetWeightPercent(weight).."%"
							end
							weight = RED_FONT_COLOR_CODE.."("..weight..")"
						else
							weight = ""
						end
					end

					local text = ("%s-%s (%s)-\n%s%s %s\n "):format(titleColor, name, type, GRAY_FONT_COLOR_CODE,desc,weight)
					local label = AceGUI:Create("Label") 
					label:SetText(text)
					label:SetImage(icon)
					label:SetFont("Fonts\\FRIZQT__.TTF", 12)
					label:SetImageSize(30,30)
					label:SetRelativeWidth(1)
					scroll:AddChild(label)
				end
			end
		end


	end
		if filterValue == 1 or filterValue == 5 then 
		local topHeading = AceGUI:Create("Heading") 
		topHeading:SetRelativeWidth(1)
		topHeading:SetHeight(5)
		scroll:AddChild(topHeading)

		local label = AceGUI:Create("Label") 
		label:SetText("Soulbinds")

		local covenantData = C_Covenants.GetCovenantData(C_Covenants.GetActiveCovenantID());
		label:SetImage("Interface/Buttons/UI-OptionsButton")
		label.image:SetAtlas(("CovenantChoice-Celebration-%sSigil"):format(covenantData.textureKit))
		label:SetFontObject(GameFontHighlightLarge)

		--label.image.imageshown = true
		label:SetImageSize(30,30)
		label:SetRelativeWidth(1)
		label:SetHeight(5)
		scroll:AddChild(label)

		topHeading = AceGUI:Create("Heading") 
		topHeading:SetRelativeWidth(1)
		topHeading:SetHeight(5)
		scroll:AddChild(topHeading)

		local powers = CovenantForge.powers
		for soulbindID, sb_powers in pairs(powers) do
			local soulbind_data = C_Soulbinds.GetSoulbindData(soulbindID)
			for i, spellID in pairs(sb_powers) do
				local name = soulbind_data.name..": "..GetSpellInfo(spellID) or ""
				local desc = GetSpellDescription(spellID)
				local _,_, icon = GetSpellInfo(spellID)
				local titleColor = ORANGE_FONT_COLOR_CODE

				local weight = CovenantForge:GetTalentWeight(CovenantForge.viewed_spec, spellID)
				if weight then
					if weight > 0 then
						if CovenantForge.Profile.ShowAsPercent then 
							weight = CovenantForge:GetWeightPercent(weight).."%"
						end
						weight = GREEN_FONT_COLOR_CODE.."(+"..weight..")"
					elseif weight < 0 then
						if CovenantForge.Profile.ShowAsPercent then 
							weight = CovenantForge:GetWeightPercent(weight).."%"
						end
						weight = RED_FONT_COLOR_CODE.."("..weight..")"
					else
						weight = ""
					end
				end

				local text = ("%s-%s-\n%s%s %s\n "):format(titleColor, name, GRAY_FONT_COLOR_CODE,desc,weight)
				local label = AceGUI:Create("Label") 
				label:SetText(text)
				label:SetImage(icon)
				label:SetFont("Fonts\\FRIZQT__.TTF", 12)
				label:SetImageSize(30,30)
				label:SetRelativeWidth(1)
				scroll:AddChild(label)
			end
		end
	end
end


--Updates Weight Values & Names
function CovenantForge:Update()
	local curentsoulbindID = Soulbinds.GetOpenSoulbindID() or C_Soulbinds.GetActiveSoulbindID();

	for buttonIndex, button in ipairs(SoulbindViewer.SelectGroup.buttonGroup:GetButtons()) do
		local f = button.ForgeInfo 
		if not f then 
			f = CreateFrame("Frame", "CovForge_Souldbind"..buttonIndex, button, "CovenantForge_SoulbindInfoTemplate")
			button.ForgeInfo = f
		end

		local soulbindID = button:GetSoulbindID()
		f.soulbindName:SetText(C_Soulbinds.GetSoulbindData(soulbindID).name)

		local selectedTotal, unlockedTotal, nodeMax, conduitMax
		if CovenantForge.Profile.ShowWeights then
			if buttonIndex == C_Soulbinds.GetActiveSoulbindID() then
				f.soulbindWeight:ClearAllPoints()
				f.soulbindWeight:SetPoint("BOTTOMLEFT", 0, 45)
				f.soulbindWeight:SetPoint("BOTTOMRIGHT")
			else 
				f.soulbindWeight:ClearAllPoints()
				f.soulbindWeight:SetPoint("BOTTOMLEFT", 0, 25)
				f.soulbindWeight:SetPoint("BOTTOMRIGHT")
			end 
			f.soulbindWeight:Show()
			selectedTotal, unlockedTotal, nodeMax, conduitMax = CovenantForge:GetSoulbindWeight(soulbindID)
			f.soulbindWeight:SetText(selectedTotal .. "("..nodeMax + conduitMax..")" )
		else
			f.soulbindWeight:Hide()

		end

		if curentsoulbindID == soulbindID and CovenantForge.Profile.ShowWeights then 
			CovenantForge.CovForge_WeightTotalFrame.Weight:Show()
			CovenantForge.CovForge_WeightTotalFrame.Weight:SetText(selectedTotal.."/"..unlockedTotal.."\nMax:"..(nodeMax + conduitMax))
		elseif curentsoulbindID == soulbindID and not CovenantForge.Profile.ShowWeights then 
			CovenantForge.CovForge_WeightTotalFrame.Weight:Hide()
		end
	end

	for buttonIndex, nodeFrame in pairs(SoulbindViewer.Tree:GetNodes()) do
		local f = nodeFrame.ForgeInfo
		if not f then       
			f = CreateFrame("Frame", "CovForge_Conduit"..buttonIndex, nodeFrame, "CovenantForge_ConduitInfoTemplate")
			nodeFrame.ForgeInfo = f
		end

		f.Name:SetText("")
		if nodeFrame.Emblem then 
			nodeFrame.Emblem:ClearAllPoints()
			nodeFrame.Emblem:SetPoint("TOP", 0,16)
			nodeFrame.EmblemBg:ClearAllPoints()
			nodeFrame.EmblemBg:SetPoint("TOP", 0,16)
			f.Name:ClearAllPoints()
			f.Name:SetPoint("TOP",0, 21)
		end

		local name, weight
		if nodeFrame:IsConduit() then
			local conduit = nodeFrame:GetConduit()
			local conduitID = conduit:GetConduitID()
			if conduit and conduitID > 0  then
				local spellID = CovenantForge.Conduits[conduitID][2]
				name = GetSpellInfo(spellID)
				--local rank = conduit:GetConduitRank()
				--local itemLevel = C_Soulbinds.GetConduitItemLevel(conduitID, rank)
				weight = CovenantForge:GetConduitWeight(CovenantForge.viewed_spec, conduitID)
			else
				name = ""
			end
		else
			local spellID =  nodeFrame.spell:GetSpellID()
			name = GetSpellInfo(spellID) or ""
			weight = CovenantForge:GetTalentWeight(CovenantForge.viewed_spec, spellID)
		end
		f.Name:SetText(name)

		if weight and weight ~= 0 then 
			local sign = "+"
			if weight > 0 then 
				f.Value:SetTextColor(0,1,0)
			elseif weight < 0 then 
				f.Value:SetTextColor(1,0,0)
				sign = ""
			end

			if CovenantForge.Profile.ShowAsPercent then 
				weight = sign..CovenantForge:GetWeightPercent(weight).."%"
			end
		elseif weight and weight == 0 and CovenantForge.Profile.HideZeroValues then 
			weight = ""
		end
		if CovenantForge.Profile.ShowWeights then
			f.Value:Show()
			f.Value:SetText(weight or "")
		else
			f.Value:Hide()
		end
	end

	for conduitType, conduitData in ipairs(SoulbindViewer.ConduitList:GetLists()) do
		for conduitButton in SoulbindViewer.ConduitList.ScrollBox.ScrollTarget.Lists[conduitType].pool:EnumerateActive() do
			local conduitID = conduitButton.conduitData.conduitID
			local conduitItemLevel = conduitButton.conduitData.conduitItemLevel
			local conduitRank = conduitButton.conduitData.conduitRank

			local ilevelText = conduitItemLevel.."(Rank"..conduitRank..")"
			local weight = CovenantForge:GetConduitWeight(CovenantForge.viewed_spec, conduitID)
			local percent = CovenantForge:GetWeightPercent(weight)

			if CovenantForge.Profile.ShowWeights and weight ~=0 then 
				if CovenantForge.Profile.ShowAsPercent then 
					if percent > 0 then 
						conduitButton.ItemLevel:SetText(ilevelText..GREEN_FONT_COLOR_CODE.." (+"..percent.."%)");
					elseif percent < 0 then 
						conduitButton.ItemLevel:SetText(ilevelText..RED_FONT_COLOR_CODE.." ("..percent.."%)");
					end
				else
					if weight > 0 then 
						conduitButton.ItemLevel:SetText(ilevelText..GREEN_FONT_COLOR_CODE.." (+"..weight..")");
					elseif weight < 0 then 
						conduitButton.ItemLevel:SetText(ilevelText..RED_FONT_COLOR_CODE.." ("..weight..")");
					end
				end
			else 
				conduitButton.ItemLevel:SetText(ilevelText);
			end
		end
	end

	CovenantForge.CovForge_WeightTotalFrame:SetShown(not SoulbindViewer.CommitConduitsButton:IsShown())

	if CovenantForge.PathStorageFrame and CovenantForge.PathStorageFrame:IsShown() then 
		CovenantForgeSavedTab_OnClick({["tabIndex"] = currentTab})
	end
	if CovenantForge.PathStorageFrame and CovenantForge.PathStorageFrame:IsShown() and currentTab == 2 then
		CovenantForge:UpdateConduitList()
	end

	if CovenantForge.PathStorageFrame and CovenantForge.PathStorageFrame:IsShown() and currentTab == 3 then
		CovenantForge:UpdateWeightList()
	end
end


function CovenantForge:GenerateToolip(tooltip)
	if not self.Profile.ShowTooltipRank then return end

	local name, itemLink = tooltip:GetItem()
	if not name then return end

	if C_Soulbinds.IsItemConduitByItemInfo(itemLink) then
		local itemLevel = select(4, GetItemInfo(itemLink))

		for rank, level in pairs(CONDUIT_RANKS) do
			if itemLevel == level then
				self:ConduitTooltip_Rank(tooltip, rank);
			end
		end
	end
end


local ItemLevelPattern = gsub(ITEM_LEVEL, "%%d", "(%%d+)")
function CovenantForge:ConduitTooltip_Rank(tooltip, rank, row)
	local text, level
	local textLeft = tooltip.textLeft
	if not textLeft then
		local tooltipName = tooltip:GetName()
		textLeft = setmetatable({}, { __index = function(t, i)
			local line = _G[tooltipName .. "TextLeft" .. i]
			t[i] = line
			return line
		end })
		tooltip.textLeft = textLeft
	end

	if row and _G[tooltip:GetName() .. "TextLeft" .. 1] then
		local colormarkup = DARKYELLOW_FONT_COLOR:GenerateHexColorMarkup() 
		local line = textLeft[1]
		text = _G[tooltip:GetName() .. "TextLeft" .. 1]:GetText() or ""
		line:SetFormattedText(colormarkup.."Row %d: |r%s", row, text)
	end

	for i = 3, 5 do
		if _G[tooltip:GetName() .. "TextLeft" .. i] then
			local line = textLeft[i]
			text = _G[tooltip:GetName() .. "TextLeft" .. i]:GetText() or ""
			level = string.match(text, ItemLevelPattern)
			if (level) then
				line:SetFormattedText("%s (Rank %d)", text, rank);
				return ;
			end
		end
	end
end


function CovenantForge:StopAnimationFX(viewer)
	if self.Profile.disableFX then
		viewer.ForgeSheen.Anim:SetPlaying(false);
		viewer.BackgroundSheen1.Anim:SetPlaying(false);
		viewer.BackgroundSheen2.Anim:SetPlaying(false);
		viewer.GridSheen.Anim:SetPlaying(false);
		viewer.BackgroundRuneLeft.Anim:SetPlaying(false);
		viewer.BackgroundRuneRight.Anim:SetPlaying(false);
		viewer.ConduitList.Fx.ChargeSheen.Anim:SetPlaying(false);

		for buttonIndex, button in ipairs(SoulbindViewer.SelectGroup.buttonGroup:GetButtons()) do
			button.ModelScene.NewAlert:Hide();
			button.ModelScene.Highlight2.Pulse:Stop();
			button.ModelScene.Highlight3.Pulse:Stop();
			button.ModelScene.Dark.Pulse:Stop();
			button:GetFxModelScene():ClearEffects();
			button.ModelScene:SetPaused(true)
		end
	end
end


function CovenantForge:StopNodeFX(viewer)
	if self.Profile.disableFX then
		viewer.FlowAnim1:Stop();
		viewer.FlowAnim2:Stop();
		viewer.FlowAnim3:Stop();
		viewer.FlowAnim4:Stop();
		viewer.FlowAnim5:Stop();
		viewer.FlowAnim6:Stop();
	end
end


function CovenantForge:GetClassConduits()
	local className, classFile, classID = UnitClass("player")
	local classSpecs = CLASS_SPECS[classID]
	
	for i, data in pairs(CovenantForge.Conduits) do
		local valid = false
		for i, spec in ipairs(classSpecs) do
			if valid then break end

			for i, con_spec in ipairs(data[4]) do
				if spec == con_spec then 
					valid = true
					break
				end
			end
		end

		if valid then 
			local type = data[3]
			CovenantForge.conduitList[type] = CovenantForge.conduitList[type] or {}
			CovenantForge.conduitList[type][i] = data
		end
	end
end

--Sets Slash Command to load macro
CovenantForge:RegisterChatCommand("CFLoad", function(arg) CovenantForge:MacroLoad(arg) end)


--[[

	for i,spec in ipairs(classSpecs) do

	--CovenantForge.Weights["PreRaid"][specID][covenantID]
end

end 

function CovenantForge:GetConduitInfo(name)
	for i, data in pairs(CovenantForge.Conduits) do
	CovenantForge.Conduits ={
	[5]={ "Stalwart Guardian", 334993, 2, {72,71,73,},},

end

	self.conduitData = conduitData;
	self.conduit = SoulbindConduitMixin_Create(conduitData.conduitID, conduitData.conduitRank);

	local itemID = conduitData.conduitItemID;
	local item = Item:CreateFromItemID(itemID);
	local itemCallback = function()
		self.ConduitName:SetSize(150, 30);
		self.ConduitName:SetText(item:GetItemName());
		self.ConduitName:SetHeight(self.ConduitName:GetStringHeight());
		
		local yOffset = self.ConduitName:GetNumLines() > 1 and -6 or 0;
		self.ConduitName:ClearAllPoints();
		self.ConduitName:SetPoint("BOTTOMLEFT", self.Icon, "RIGHT", 10, yOffset);
		self.ConduitName:SetWidth(150);

		self.ItemLevel:SetPoint("TOPLEFT", self.ConduitName, "BOTTOMLEFT", 0, 0);
		self.ItemLevel:SetText(conduitData.conduitItemLevel);



]]


--  ///////////////////////////////////////////////////////////////////////////////////////////
--
--   
--  Author: SLOKnightfall

--  

--

--  ///////////////////////////////////////////////////////////////////////////////////////////


local function SortNodes(data)
	local sortedNodes = {}
	for _, nodes in pairs(data) do table.insert(sortedNodes, nodes) end
	table.sort(sortedNodes, function(a,b) return a.row < b.row end)
	return sortedNodes
end


local function GetPathData()
	local pathData = {}
	local icon, _
	for i, nodeFrame in pairs(SoulbindViewer.Tree:GetNodes()) do
		local node = nodeFrame.node
		if node.state == 3 then 
			pathData[node.ID] = {
				state = node.state,
				icon = node.icon,
				row = node.row,
				conduitID = node.conduitID,
				spellID = node.spellID,
			}

			if node.row == 1 then 
				icon = node.icon
				local spellID = C_Soulbinds.GetConduitSpellID(node.conduitID, node.conduitRank)
				_,_, icon = GetSpellInfo(spellID)
				--else
				--_, _, icon = GetSpellInfo(node.spellID)
				--end
			end
		end
	end
	return pathData, icon
end


function CovenantForge:PathTooltip(parent, index)
	if not CovenantForge.savedPathdb.char.paths[index] then return end

	local data = CovenantForge.savedPathdb.char.paths[index]
	local covenantData = C_Covenants.GetCovenantData(data.covenantID)
	local soulbindData = C_Soulbinds.GetSoulbindData(data.soulbindID)
	local r,g,b = COVENANT_COLORS[data.covenantID]:GetRGB()

	GameTooltip:SetOwner(parent.frame, "ANCHOR_RIGHT")

	GameTooltip:AddLine(("%s - %s"):format(covenantData.name, soulbindData.name),r,g,b)
	GameTooltip:AddLine(" ")

	 local pathList = SortNodes(data.data)

		for i, pathEntry in ipairs(pathList) do
			if pathEntry.conduitID > 0 then
				local collectionData = C_Soulbinds.GetConduitCollectionData(pathEntry.conduitID)
				local quality = C_Soulbinds.GetConduitQuality(collectionData.conduitID, collectionData.conduitRank)
				local spellID = C_Soulbinds.GetConduitSpellID(collectionData.conduitID, collectionData.conduitRank)
				local name = GetSpellInfo(spellID)
				--local desc = GetSpellDescription(spellID)
				local colormarkup = DARKYELLOW_FONT_COLOR:GenerateHexColorMarkup()
				GameTooltip:AddLine(string.format(colormarkup.."Row %d: |r%s - Rank:%s |cffffffff(%s)|r",i, name, collectionData.conduitRank,Soulbinds.GetConduitName(collectionData.conduitType)), unpack({ITEM_QUALITY_COLORS[quality].color:GetRGB()}))
				--GameTooltip:AddLine(string.format("Rank:%s", collectionData.conduitRank, unpack({ITEM_QUALITY_COLORS[quality].color:GetRGB()})))
				--GameTooltip:AddLine(desc, nil, nil, nil, true)
				--GameTooltip:AddLine(" ")
			else
				local spellID = pathEntry.spellID
				local name = GetSpellInfo(spellID)
				local desc = GetSpellDescription(spellID)

				GameTooltip:AddLine(string.format("Row %d: |cffffffff%s|r", i, name))
			  --  GameTooltip:AddLine(string.format("Rank:%s", name, unpack({ITEM_QUALITY_COLORS[quality].color:GetRGB()})))
				--GameTooltip:AddLine(desc, nil, nil, nil, true)
				--GameTooltip:AddLine(" ")
			end
		end
	GameTooltip:Show()
end


function CovenantForge:ShowNodeTooltip(parent, data)
	if not data then return end

	GameTooltip:SetOwner(parent.frame, "ANCHOR_RIGHT")

	if data.conduitID > 0 then
		local collectionData = C_Soulbinds.GetConduitCollectionData(data.conduitID)
		local quality = C_Soulbinds.GetConduitQuality(collectionData.conduitID, collectionData.conduitRank)
		local spellID = C_Soulbinds.GetConduitSpellID(collectionData.conduitID, collectionData.conduitRank)
		local name = GetSpellInfo(spellID)
		--local desc = GetSpellDescription(spellID)
		local colormarkup = DARKYELLOW_FONT_COLOR:GenerateHexColorMarkup()
		GameTooltip:SetConduit(data.conduitID, collectionData.conduitRank)
		CovenantForge:ConduitTooltip_Rank(GameTooltip, collectionData.conduitRank, data.row + 1)
	else
		local spellID = data.spellID
		local name = GetSpellInfo(spellID)
		local desc = GetSpellDescription(spellID)
		GameTooltip:AddLine(string.format("Row %d: |cffffffff%s|r", data.row + 1 , name))
		GameTooltip:AddLine(desc, nil, nil, nil, true)
	end
		
	GameTooltip:Show()
end


function CovenantForge:SavePath()
	local covenantID = C_Covenants.GetActiveCovenantID()
	local soulbindID = SoulbindViewer:GetOpenSoulbindID()
	local pathData, icon  = GetPathData()

	local Path = {
		icon = icon,
		covenantID = covenantID,
		soulbindID =  soulbindID,
		data = pathData,    
	}

	return Path
end


function CovenantForge:DeletePath(index)
	table.remove(CovenantForge.savedPathdb.char.paths, index)
	CovenantForge:UpdateSavedPathsList()
end


function CovenantForge:LoadPath(index, macro)
	local pathData = CovenantForge.savedPathdb.char.paths[index]

	if not pathData then return end
	if not C_Soulbinds.CanSwitchActiveSoulbindTreeBranch() then
		print(SOULBIND_NODE_UNSELECTED)
		return
	end

	local covenantData = C_Covenants.GetCovenantData(pathData.covenantID)
	local soulbindIDs = covenantData.soulbindIDs
	local soulbindID = pathData.soulbindID

	local currentSoulbindId = SoulbindViewer:GetOpenSoulbindID()
	local currentSoulbindData = C_Soulbinds.GetSoulbindData(currentSoulbindId)

	if not C_Soulbinds.CanModifySoulbind() then
		for nodeID, pathData in pairs(pathData.data) do
			local currentNode = C_Soulbinds.GetNode(nodeID)
			if currentNode.conduitID ~= pathData.conduitID then
				print("Requires the Forge of Bonds to modify.")
				return
			end
		end
	end

	if currentSoulbindId ~= soulbindID then
		SoulbindViewer.SelectGroup.buttonGroup:SelectAtIndex(tIndexOf(soulbindIDs, soulbindID))
	end
	
	if C_Soulbinds.GetActiveSoulbindID() ~= soulbindID and macro then
		C_Soulbinds.ActivateSoulbind(soulbindID)
	elseif C_Soulbinds.GetActiveSoulbindID() ~= soulbindID then
		SoulbindViewer:OnActivateSoulbindClicked()
	end

	for i, node in pairs(currentSoulbindData.tree.nodes) do
		if C_Soulbinds.IsNodePendingModify(node.ID) then
			C_Soulbinds.UnmodifyNode(node.ID)
			C_Soulbinds.UnmodifyNode(node.ID)
		end
	end

	for nodeID, pathData in pairs(pathData.data) do
		local currentNode = C_Soulbinds.GetNode(nodeID)

		if C_Soulbinds.IsNodePendingModify(nodeID) then
			C_Soulbinds.UnmodifyNode(nodeID)
			C_Soulbinds.UnmodifyNode(nodeID)
		end

		if currentNode.conduitID ~= pathData.conduitID then
			C_Soulbinds.ModifyNode(nodeID, pathData.conduitID, 0)
		end

		if pathData.state == 3 then
			C_Soulbinds.SelectNode(nodeID)
		end
	end

	if C_Soulbinds.HasAnyPendingConduits() then
		SoulbindViewer:OnCommitConduitsClicked()
	end

	print(("Saved Path %s has been loaded."):format(pathData.name))
end


function CovenantForge:MacroLoad(pathName)
	local isfound = false
	for i, data in ipairs(CovenantForge.savedPathdb.char.paths) do
		if data.name == pathName then
			isfound = i
			break
		end
	end

	if not isfound then return false end
	CovenantForge:LoadPath(isfound, true)
end


--Saved Path Popup Menu
function CovenantForge:ShowPopup(popup, index)
	if popup == "COVENANTFORGE_UPDATEPATHPOPUP" then 
		StaticPopupSpecial_Show(CovenantForge_SavedPathEditFrame)
		local data = CovenantForge.savedPathdb.char.paths[index]
		CovenantForge_SavedPathEditFrame.EditBox:SetText(data.name)
		CovenantForge_SavedPathEditFrame.pathIndex = index
	elseif popup == "COVENANTFORGE_UPDATEWEIGHTPOPUP" then 
		StaticPopupSpecial_Show(CovenantForge_WeightsEditFrame)
	end
end


function CovenantForge:ClosePopups()
	StaticPopupSpecial_Hide(CovenantForge_SavedPathEditFrame)
	StaticPopupSpecial_Hide(CovenantForge_WeightsEditFrame)
end


CovenantForge_SavedPathEditFrameMixin = {}
function CovenantForge_SavedPathEditFrameMixin:OnDelete()
	CovenantForge:DeletePath(self.pathIndex)
	CovenantForge:ClosePopups()
end


local function CheckNames(name)
	if string.len(name) <= 0 then return false end

	for i, data in ipairs(CovenantForge.savedPathdb.char.paths) do
		if name == data.name then 
			return false
		end
	end
	return true
end


function CovenantForge_SavedPathEditFrameMixin:OnAccept()
	local data = CovenantForge.savedPathdb.char.paths[self.pathIndex]
	local name = CovenantForge_SavedPathEditFrame.EditBox:GetText()
	if CheckNames(name) then 
		data.name = CovenantForge_SavedPathEditFrame.EditBox:GetText()
		CovenantForge:UpdateSavedPathsList()
		CovenantForge:ClosePopups()
	else
		print("Name Already Exists")
	end
end


function CovenantForge_SavedPathEditFrameMixin:OnUpdate()
	local name = CovenantForge.savedPathdb.char.paths[self.pathIndex].name
	CovenantForge.savedPathdb.char.paths[self.pathIndex] = CovenantForge:SavePath()
	CovenantForge.savedPathdb.char.paths[self.pathIndex].name = name
	CovenantForge:UpdateSavedPathsList()
	CovenantForge:ClosePopups()
end


CovenantForge_SavedPathMixin = {}
function CovenantForge_SavedPathMixin:OnClick()
   if not CheckNames(self:GetParent().EditBox:GetText()) then return end

	local Path = CovenantForge:SavePath()
	Path.name = self:GetParent().EditBox:GetText(),
	table.insert(CovenantForge.savedPathdb.char.paths, Path)
	CovenantForge:UpdateSavedPathsList()
end


function CovenantForge:UpdateSavedPathsList()
	if not SoulbindViewer or (SoulbindViewer and not SoulbindViewer:IsShown()) or
 		not CovenantForge.savedPathdb.char.paths or not CovenantForge.scrollcontainer then return end

	local scrollcontainer = CovenantForge.scrollcontainer
	scrollcontainer:ReleaseChildren()
	scrollcontainer:SetPoint("TOPLEFT", CovenantForge.PathStorageFrame,"TOPLEFT", 0, -55)
	scroll = AceGUI:Create("ScrollFrame")
	scroll:SetLayout("Flow") -- probably?
	scrollcontainer:AddChild(scroll)

	for i, data in ipairs(CovenantForge.savedPathdb.char.paths) do
		local soulbindData = C_Soulbinds.GetSoulbindData(data.soulbindID)
		local container = AceGUI:Create("SimpleGroup") 
		container:SetLayout("Fill")

		local topHeading = AceGUI:Create("Heading") 
		topHeading:SetRelativeWidth(1)
		topHeading:SetHeight(5)
		scroll:AddChild(topHeading)
		--container:AddChild(topHeading)
		local InteractiveLabel = AceGUI:Create("InteractiveLabel")
		InteractiveLabel:SetText(soulbindData.name..": "..data.name.."\n \n  \n  \n  \n ")
		InteractiveLabel:SetJustifyH("TOP")
		InteractiveLabel.label:SetPoint("TOP", container.frame, "TOP", 0 ,10)
		InteractiveLabel.label:SetHeight(InteractiveLabel.label:GetStringHeight())
		--InteractiveLabel:SetImage(data.icon)
		InteractiveLabel:SetImage(data.icon)
		InteractiveLabel:SetImageSize(1,35)
		InteractiveLabel:SetHeight(35)
		InteractiveLabel.image:ClearAllPoints()
		--InteractiveLabel.image:SetPoint("LEFT",-999)
		InteractiveLabel.image:SetAlpha(0)
		InteractiveLabel:SetRelativeWidth(1)
		--InteractiveLabel:SetPoint("CENTER")
		InteractiveLabel:SetCallback("OnClick", function() CovenantForge:LoadPath(i) end)
		InteractiveLabel:SetCallback("OnEnter", function() CovenantForge:PathTooltip(InteractiveLabel, i) end)
		InteractiveLabel:SetCallback("OnLeave", function() GameTooltip:Hide() end)

		local UpdateButton =  AceGUI:Create("Icon") 
		UpdateButton:SetImage("Interface/Buttons/UI-OptionsButton")
		UpdateButton:SetImageSize(15,15)
		UpdateButton:SetHeight(18)
		UpdateButton:SetWidth(18)

		UpdateButton:SetCallback("OnClick", function()
				if (not StaticPopup_Visible("COVENANTFORGE_UPDATEPATHPOPUP")) then
				CovenantForge:ShowPopup("COVENANTFORGE_UPDATEPATHPOPUP", i)
				end  end)
		UpdateButton:SetCallback("OnEnter", function() GameTooltip:SetOwner(UpdateButton.frame, "ANCHOR_RIGHT"); GameTooltip:AddLine("Options"); GameTooltip:Show() end)
		UpdateButton:SetCallback("OnLeave", function() GameTooltip:Hide() end)
		UpdateButton:SetRelativeWidth(.1)
		UpdateButton.index = i


		container:AddChild(InteractiveLabel)
		container:AddChild(UpdateButton)

		UpdateButton:ClearAllPoints()
		UpdateButton.frame:SetPoint("TOPRIGHT",container.frame,"TOPRIGHT", 0, 5)
		UpdateButton.frame:SetFrameLevel(200)

		container:SetHeight(35)
		container:SetFullWidth(true)
		--scroll:AddChild(container)
		container:SetAutoAdjustHeight(false)

		--container = AceGUI:Create("SimpleGroup") 
		--container:SetLayout("Flow")
		--container:SetFullWidth(true)
		--container:SetHeight(30)
		--container:SetAutoAdjustHeight(false)
		local sortedNodes = SortNodes(data.data)
		local index = 0
		for id, data in pairs(sortedNodes) do
			local nodeIcon = AceGUI:Create("Icon")
			if data.conduitID > 0 then 
				local spellID = C_Soulbinds.GetConduitSpellID(data.conduitID, 1)
				local _,_, icon = GetSpellInfo(spellID)
				nodeIcon:SetImage(icon)
			else
				local _,_, icon = GetSpellInfo(data.spellID)
				nodeIcon:SetImage(icon)
			end
			nodeIcon:SetImageSize(25,25)
			nodeIcon:SetWidth(26)
			nodeIcon:SetCallback("OnClick", function() CovenantForge:LoadPath(i) end)
			nodeIcon:SetCallback("OnEnter", function() CovenantForge:ShowNodeTooltip(nodeIcon, data) end)
			nodeIcon:SetCallback("OnLeave", function() GameTooltip:Hide() end)
			container:AddChild(nodeIcon)
			nodeIcon.frame:SetPoint("BOTTOMLEFT", container.frame, "BOTTOMLEFT", 26 * index, -7)
			nodeIcon.frame:SetFrameLevel(200)
			index = index + 1
		end
		scroll:AddChild(container)
	end
end




--  ///////////////////////////////////////////////////////////////////////////////////////////
--
--   
--  Author: SLOKnightfall

--  

--

--  ///////////////////////////////////////////////////////////////////////////////////////////

local playerInv_DB
local Profile
local playerNme
local realmName
local playerClass, classID,_
local conduitList = {}

local CONDUIT_RANKS = {
	[1] = C_Soulbinds.GetConduitItemLevel(0, 1),
	[2] = C_Soulbinds.GetConduitItemLevel(0, 2),
	[3] = C_Soulbinds.GetConduitItemLevel(0, 3),
	[4] = C_Soulbinds.GetConduitItemLevel(0, 4),
	[5] = C_Soulbinds.GetConduitItemLevel(0, 5),
	[6] = C_Soulbinds.GetConduitItemLevel(0, 6),
	[7] = C_Soulbinds.GetConduitItemLevel(0, 7),
	[8] = C_Soulbinds.GetConduitItemLevel(0, 8),
}


local WEIGHT_BASE = 37.75
local CLASS_SPECS ={{71,72,73},{65,66,70},{253,254,255},{259,260,261},{256,257,258},{250,251,252},{262,263,264},{62,63,64},{265,266,267},{268,270,269},{102,103,104,105},{577,578}}

local WeightProfiles = {}
local ProfileTable = {}
local Weights = {}
local BaseValue = {}
local ilevels = {}
local ilevelData = {}
local powers = {}


local function GetSoulbindPowers()
	local covenantData = C_Covenants.GetCovenantData(C_Covenants.GetActiveCovenantID())
	local soulbinds = covenantData.soulbindIDs
	for _, soulbindID in pairs(soulbinds) do
		local soulbindData = C_Soulbinds.GetSoulbindData(soulbindID)
		local tree = soulbindData.tree.nodes
		local soulbindPowers = {}
		for index, data in ipairs(tree) do
			if data.conduitID == 0 and data.spellID ~= 0 then 
				--if data.spellID == 0 then print(index) end
				table.insert(soulbindPowers, data.spellID)
			end
		end
		powers[soulbindID] = soulbindPowers
	end

	CovenantForge.powers = powers
end


local function SelectProfile(index)
	if not WeightProfiles[index] then  SelectProfile(1) end
	Weights = WeightProfiles[index].weights
	BaseValue = WeightProfiles[index].base
	CovenantForge.savedPathdb.char.selectedProfile = index
	CovenantForge:UpdateWeightList()
end


local defaultindex = 0
function CovenantForge:BuildWeightData()
	wipe(WeightProfiles)
	wipe(ProfileTable)
	defaultindex = 0
	GetSoulbindPowers()
	local spec = GetSpecialization()
	local specID, specName = GetSpecializationInfo(spec)
	local _, _, classID = UnitClass("player")
	local covenantID = C_Covenants.GetActiveCovenantID();
	local classSpecs = CLASS_SPECS[classID]
	for profile, weightData in pairs(CovenantForge.Weights) do
		local Weights = {}
		local baseValue = {} 
		for i,spec in ipairs(classSpecs) do
			if CovenantForge.Weights[profile][spec] then 
				local data = CovenantForge.Weights[profile][spec][covenantID]
				Weights[spec] =  {}
				for i=2, #data do
					local conduitData = data[i]
					local name = string.gsub(conduitData[1],' %(.+%)',"")
					local ilevel ={}
					for index = 2, #conduitData do
						local ilevelData = data[1][index]
						ilevels[index - 1 ] = ilevelData
						ilevel[ilevelData] = conduitData[index]
					end
					Weights[spec][name] = ilevel
					baseValue[spec] = CovenantForge.BaseValues[profile][spec][covenantID]
				end
			end
		end
		table.insert(WeightProfiles, {["name"] = profile, ["weights"]= Weights, ["base"] = baseValue })
		table.insert(ProfileTable, profile)
		defaultindex = defaultindex + 1
	end

	local profileList = self.weightdb.class.weights or {}
	for profile, weightData in pairs(profileList) do
		local baseValue = self.weightdb.class.base[profile]
		table.insert(WeightProfiles, {["name"] = profile, ["weights"]= weightData, ["base"] = baseValue})
		table.insert(ProfileTable, profile)
	end

	local selectedProfile = CovenantForge.savedPathdb.char.selectedProfile
	SelectProfile(selectedProfile)
end


function CovenantForge:GetConduitWeight(specID, conduitID)
	local profile = CovenantForge.savedPathdb.char.selectedProfile
	if not CovenantForge.Conduits[conduitID] or not Weights[specID] then return 0 end
	local soulbindName = CovenantForge.Conduits[conduitID][1]
	--if soulbindName == "Rejuvenating Wind" then return 31 end
	local collectionData  = C_Soulbinds.GetConduitCollectionData(conduitID)
	local conduitItemLevel = collectionData and collectionData.conduitItemLevel or 145

	if Weights[specID][soulbindName] then 
		local weight = Weights[specID][soulbindName][conduitItemLevel]
		return weight or 0
	end

	return 0
end


function CovenantForge:GetTalentWeight(specID, spellID)
	--if spellID == 320658 then return 51 end
	if not CovenantForge.Soulbinds[spellID] or not Weights[specID] then return 0 end

	local name = CovenantForge.Soulbinds[spellID]
	if Weights[specID][name] then 
		local weight = Weights[specID][name][1]
		return weight or 0
	end

	return 0
end


local function BuildTreeData(tree)
	local parentNodeTable = {}
	local parentNodeData = {}
	for i, data in ipairs(tree) do
		parentNodeData[data.ID] = data
		local parentNodeIDs = data.parentNodeIDs
		if #parentNodeIDs == 1  and data.row ~= 0 then 
			parentNodeTable[data.ID] = data.parentNodeIDs[1]
		end
	end
	return parentNodeTable, parentNodeData
end


function CovenantForge:GetSoulbindWeight(soulbindID)
	local data = C_Soulbinds.GetSoulbindData(soulbindID)
	local tree = data.tree.nodes
	local parentNodeTable, parentNodeData = BuildTreeData(tree) 

	local selectedWeight = {}
	local unlockedWeights = {}
	local maxNodeWeights = {}
	local maxConduitWeights = {}
	local parentRow = {}

	for i, data in ipairs(tree) do
		local row = data.row  --RowID starts at 0
		local conduitID = data.conduitID
		local spellID = data.spellID
		local state = data.state
		local weight
		local maxTable

		local parentNode = parentNodeTable[data.ID]
		local parentData = parentNodeData[parentNode]
		local parentWeight = 0
		
		if conduitID == 0 then
			weight = CovenantForge:GetTalentWeight(CovenantForge.viewed_spec, spellID)

			maxTable = maxNodeWeights
		else
			weight = CovenantForge:GetConduitWeight(CovenantForge.viewed_spec, conduitID)

			maxTable = maxConduitWeights
		end

		if parentData and parentData.conduitID == 0 then
				parentWeight = CovenantForge:GetTalentWeight(CovenantForge.viewed_spec, parentData.spellID) or 0
				parentRow[parentData.row] = true
		elseif parentData then 
			parentWeight = CovenantForge:GetConduitWeight(CovenantForge.viewed_spec, parentData.conduitID) or 0
			parentRow[parentData.row] = true
		end

		if weight and state == 3 then
			selectedWeight[row] = weight
		end

		unlockedWeights[row] = unlockedWeights[row] or 0
		if weight and state ~= 0 and  weight + parentWeight >= unlockedWeights[row] then
			unlockedWeights[row] = weight + parentWeight 
		end

		maxTable[row] = maxTable[row] or 0
		if weight and weight + parentWeight  >= maxTable[row] then
			maxTable[row] = weight + parentWeight 
		end
	end

	for i, data in pairs(parentRow)do
		if i ~=0 then 
			maxNodeWeights[i] = 0
			unlockedWeights[i] = 0
			maxConduitWeights[i] = 0
		end
	end

	local selectedTotal = 0
	for i, value in pairs(selectedWeight) do
		selectedTotal = selectedTotal + value
	end

	local unlockedTotal = 0
	for i, value in pairs(unlockedWeights) do
		unlockedTotal = unlockedTotal + value
	end

	local nodeMax = 0
	for i, value in pairs(maxNodeWeights) do
		nodeMax = nodeMax + value
	end

	local conduitMax = 0
	for i, value in pairs(maxConduitWeights) do
		conduitMax = conduitMax + value
	end

	return selectedTotal, unlockedTotal, nodeMax, conduitMax
end


function CovenantForge:GetWeightPercent(weight)
	if not weight then return 0 end
	--local percent = weight/WEIGHT_BASE
	BaseValue[CovenantForge.viewed_spec] = BaseValue[CovenantForge.viewed_spec] or 100
	local templateDPS = BaseValue[CovenantForge.viewed_spec]
	local formula = 100 * ((templateDPS + weight) / templateDPS - 1)
	return  tonumber(string.format("%.2f", formula))
end


local function CreateNewWeightProfile(name)
	local profileList = CovenantForge.weightdb.class.weights
	local baseValue = CovenantForge.weightdb.class.base
	local _, _, classID = UnitClass("player")
	local covenantID = C_Covenants.GetActiveCovenantID();
	local classSpecs = CLASS_SPECS[classID]
	if not profileList[name] then 
		profileList[name] = {}
		baseValue[name] = {}
		for _, specID in ipairs(classSpecs) do
			profileList[name][specID] = {{},{},{}}
			baseValue[name][specID] = 100
		end
	end
	CovenantForge:BuildWeightData()
	CovenantForge:UpdateWeightList()
end


local function CopyWeightProfile(name)
	local profileList = CovenantForge.weightdb.class.weights
	local baseValue = CovenantForge.weightdb.class.base
	local selectedProfile = CovenantForge.savedPathdb.char.selectedProfile
	local selectedName = WeightProfiles[selectedProfile].name
	local weights = CopyTable(Weights)
	local base = CopyTable(BaseValue)
	profileList[name] = weights

	table.insert(WeightProfiles, {["name"] = name, ["weights"]= weights, ["base"] = base })
	table.insert(ProfileTable, name)
	CovenantForge:UpdateWeightList()
end


local function DeleteWeightProfile(name)
	local profileList = CovenantForge.weightdb.class.weights
	local baseValue = CovenantForge.weightdb.class.base
	profileList[name] = nil
	baseValue[name] = nil
	SelectProfile(1)
	CovenantForge:BuildWeightData()
	CovenantForge:UpdateWeightList()
	CovenantForge.Update()
end

local function UpdateWeightData(name, ilevel, value)
--Weights[specID][name]
	Weights[tonumber(CovenantForge.viewed_spec)] = Weights[tonumber(CovenantForge.viewed_spec)] or {}
	Weights[tonumber(CovenantForge.viewed_spec)][name] = Weights[tonumber(CovenantForge.viewed_spec)][name] or {}
	Weights[tonumber(CovenantForge.viewed_spec)][name][tonumber(ilevel)] = tonumber(value)
	CovenantForge:UpdateWeightList()
	CovenantForge.Update()
end

local function UpdatePercentData(value)
	BaseValue[tonumber(CovenantForge.viewed_spec)] = tonumber(value)
	CovenantForge:UpdateWeightList()
	CovenantForge.Update()
end


local filterValue = 1
local filteredList = CovenantForge.conduitList
function CovenantForge:UpdateWeightList()
	if not SoulbindViewer or (SoulbindViewer and not SoulbindViewer:IsShown()) or
 		not CovenantForge.scrollcontainer then return end	

 	local filter = {"All", 	Soulbinds.GetConduitName(0),Soulbinds.GetConduitName(1),Soulbinds.GetConduitName(2), "Soulbinds"}
	local scrollcontainer = CovenantForge.scrollcontainer
	scrollcontainer:ReleaseChildren()
	scrollcontainer:SetPoint("TOPLEFT", CovenantForge.PathStorageFrame,"TOPLEFT", 0, -25)

	local selectedProfile = CovenantForge.savedPathdb.char.selectedProfile
	local weights = WeightProfiles[selectedProfile].weights
	local baseValue = WeightProfiles[selectedProfile].base

	scroll = AceGUI:Create("ScrollFrame")
	scroll:SetLayout("Flow") -- probably?
	scrollcontainer:AddChild(scroll)

	local dropdown = AceGUI:Create("Dropdown")
	dropdown:SetFullWidth(false)
	dropdown:SetWidth(200)
	scroll:AddChild(dropdown)
	dropdown:SetList(ProfileTable)
	dropdown:SetValue(selectedProfile)
	dropdown:SetCallback("OnValueChanged", 
		function(self,event, key) 
			SelectProfile(key)
			CovenantForge:Update()
		end)


	local icon = AceGUI:Create("Icon") 
	icon:SetImage("Interface/Buttons/UI-OptionsButton")
	icon:SetHeight(20)
	icon:SetWidth(25)
	icon:SetImageSize(20,20)
	icon:SetCallback("OnClick", function() CovenantForge:OpenBarDropDown(icon.frame) end)

	scroll:AddChild(icon)

	dropdown = AceGUI:Create("Dropdown")
	dropdown:SetFullWidth(false)
	dropdown:SetWidth(125)
	dropdown:SetList(filter)
	dropdown:SetValue(filterValue)
	dropdown:SetCallback("OnValueChanged", 
		function(self,event, key) 
			filterValue = key; 
			if key == 1 then 
				filteredList = CovenantForge.conduitList
			else 
				filteredList = {CovenantForge.conduitList[key-2]}
			end
			CovenantForge:UpdateWeightList()
		end)
	scroll:AddChild(dropdown)

	local editbox = AceGUI:Create("EditBox")
	editbox:SetLabel("Percent Value")
	editbox:SetWidth(80)
	editbox:SetHeight(40)
	editbox.editbox:SetTextInsets(0,-5, 0, 0)
	editbox.button:ClearAllPoints()
	editbox.button:SetPoint("LEFT", editbox.frame, "RIGHT", 0 , -8)
	editbox:SetDisabled(CovenantForge.savedPathdb.char.selectedProfile <= defaultindex)
	editbox:SetCallback("OnEnterPressed", function(self,event, key) 
		UpdatePercentData(key)
	end)

	local basedata = (baseValue[CovenantForge.viewed_spec])
	if basedata then 
		editbox:SetText(basedata)
	end
	scroll:AddChild(editbox)

	for i, typedata in pairs(filteredList) do
		local index = i
		if #filteredList == 1 then 
			index = filterValue - 2
		end
		local collectionData = C_Soulbinds.GetConduitCollection(index)

		local topHeading = AceGUI:Create("Heading") 
		topHeading:SetRelativeWidth(1)
		topHeading:SetHeight(5)
		local bottomHeading = AceGUI:Create("Heading") 
		bottomHeading:SetRelativeWidth(1)
		bottomHeading:SetHeight(5)

		local label = AceGUI:Create("Label") 
			label:SetText(Soulbinds.GetConduitName(index))
			--Bit of a hack as Ace doesn't have a set atlas function. 
			local atlas = Soulbinds.GetConduitEmblemAtlas(index);
			--Sets a base image to trigger ACE stuff
			label:SetImage("Interface/Buttons/UI-OptionsButton")
			--Manually sets the image frame to atlas value
			label.image:SetAtlas(atlas)
			label:SetFontObject(GameFontHighlightLarge)
			label:SetImageSize(30,30)
			label:SetRelativeWidth(1)
			scroll:AddChild(topHeading)
			scroll:AddChild(label)

		for i, data in pairs(typedata) do
			local name = data[1]
			local type = Soulbinds.GetConduitName(data[3])
			local spellID = data[2]
			local desc = GetSpellDescription(spellID)
			local _,_, icon = GetSpellInfo(spellID)
			local titleColor = ORANGE_FONT_COLOR_CODE
			for i, data in ipairs(collectionData) do
				local c_spellID = C_Soulbinds.GetConduitSpellID(data.conduitID, data.conduitRank)
				if c_spellID == spellID then 
					titleColor = GREEN_FONT_COLOR_CODE
					break
				end
			end
			
			local container = AceGUI:Create("SimpleGroup") 
			container:SetLayout("Flow")
			container:SetFullWidth(true)
			container:SetHeight(20)

			local text = ("%s-%s (%s)-"):format(titleColor, name, type, GRAY_FONT_COLOR_CODE,desc,weight)
			local Icon = AceGUI:Create("Label") 
			Icon:SetText(text)
			Icon:SetImage(icon)
			--icon:SetFont("Fonts\\FRIZQT__.TTF", 12)
			Icon:SetImageSize(20,20)
			Icon:SetFullWidth(true)
			Icon:SetHeight(20)
			--icon:SetRelativeWidth(1)
			container:AddChild(Icon)


			local ileveldata = (weights[CovenantForge.viewed_spec] and weights[CovenantForge.viewed_spec][name])
			for i, data in pairs(ilevels) do
				if i ~= 1 then 
					local editbox = AceGUI:Create("EditBox")
					editbox:SetLabel(data)
					editbox:SetWidth(50)
					editbox:SetHeight(40)
					editbox.editbox:SetTextInsets(0,-5, 0, 0)
					editbox.button:ClearAllPoints()
					editbox.button:SetPoint("LEFT", editbox.frame, "RIGHT", 0 , -8)
					editbox:SetDisabled(CovenantForge.savedPathdb.char.selectedProfile <= defaultindex)
					editbox:SetCallback("OnEnterPressed", function(self,event, key) 
						UpdateWeightData(name, data, key)
					end)

					if ileveldata then 
						editbox:SetText(ileveldata[data] or 0)
					end
					container:AddChild(editbox)
				end
			end
			local topHeading = AceGUI:Create("Heading") 
			topHeading:SetRelativeWidth(1)
			topHeading:SetHeight(5)
			scroll:AddChild(topHeading)
			scroll:AddChild(container)
		end
	end
	if filterValue == 1 or filterValue == 5 then 
		local topHeading = AceGUI:Create("Heading") 
		topHeading:SetRelativeWidth(1)
		topHeading:SetHeight(5)

		local label = AceGUI:Create("Label") 
		label:SetText("Soulbinds")

		local covenantData = C_Covenants.GetCovenantData(C_Covenants.GetActiveCovenantID())
		label:SetImage("Interface/Buttons/UI-OptionsButton")
		label.image:SetAtlas(("CovenantChoice-Celebration-%sSigil"):format(covenantData.textureKit))

		label:SetFontObject(GameFontHighlightLarge)

		--label.image.imageshown = true
		label:SetImageSize(30,30)
		label:SetRelativeWidth(1)
		label:SetHeight(5)
		scroll:AddChild(topHeading)
		scroll:AddChild(label)
		for soulbindID, sb_powers in pairs(powers) do
			local soulbind_data = C_Soulbinds.GetSoulbindData(soulbindID)
			for i, spellID in pairs(sb_powers) do
				local spellname = GetSpellInfo(spellID)
				local name = soulbind_data.name..": "..spellname or ""
				local desc = GetSpellDescription(spellID)
				local _,_, icon = GetSpellInfo(spellID)
				local titleColor = ORANGE_FONT_COLOR_CODE
				local container = AceGUI:Create("SimpleGroup") 
				container:SetLayout("Flow")
				container:SetFullWidth(true)
				container:SetHeight(20)

				local text = ("%s-%s-"):format(titleColor, name)
				local Icon = AceGUI:Create("Label") 
				Icon:SetText(text)
				Icon:SetImage(icon)
				--icon:SetFont("Fonts\\FRIZQT__.TTF", 12)
				Icon:SetImageSize(20,20)
				Icon:SetFullWidth(true)
				Icon:SetHeight(20)
				--icon:SetRelativeWidth(1)
				container:AddChild(Icon)
					--scroll:AddChild(container)

				local ileveldata = (weights[CovenantForge.viewed_spec] and  weights[CovenantForge.viewed_spec][spellname])

				local editbox = AceGUI:Create("EditBox")
				--editbox:SetLabel(data)
				editbox:SetWidth(50)
				editbox:SetHeight(40)
				editbox.button:ClearAllPoints()
				editbox.button:SetPoint("LEFT", editbox.frame, "RIGHT", 0 , -8)
				editbox:SetDisabled(CovenantForge.savedPathdb.char.selectedProfile <= defaultindex)
					editbox:SetCallback("OnEnterPressed", function(self,event, key) 
						UpdateWeightData(spellname, 1, key)
					end)

				if ileveldata then 
					editbox:SetText(ileveldata[1] or 0)
				end
				container:AddChild(editbox)
		
				local topHeading = AceGUI:Create("Heading") 
				topHeading:SetRelativeWidth(1)
				topHeading:SetHeight(5)
				scroll:AddChild(topHeading)
				scroll:AddChild(container)
			end
		end
	end
end


local function Faded(self)
	self:Release()
end

local function FadeMenu(self)
	local fadeInfo = {}
	fadeInfo.mode = "OUT"
	fadeInfo.timeToFade = 0.1
	fadeInfo.finishedFunc = Faded
	fadeInfo.finishedArg1 = self
	UIFrameFade(self, fadeInfo)
end

--local LD = LibStub("LibDropdown-1.0")
local action
function CovenantForge:OpenBarDropDown(myframe, index)
	-- adopted from BulkMail
	-- release if if already shown
	local barmenuframe
	barmenuframe = barmenuframe and barmenuframe:Release()
	local baropts = {
		type = 'group',
		args = {
			details = {
				order = 10,
				name = "Create New Blank Profile",
				type = "execute",
				func = function(name)
						action = CreateNewWeightProfile
						if (not StaticPopup_Visible("COVENANTFORGE_UPDATEWEIGHTPOPUP")) then
							CovenantForge:ShowPopup("COVENANTFORGE_UPDATEWEIGHTPOPUP", i)
						end
						FadeMenu(barmenuframe)

				end,
			},
			graph = {
				order = 20,
				name = "Copy Current Profile",
				type = "execute",
				func = function(name)
					action = CopyWeightProfile
					if (not StaticPopup_Visible("COVENANTFORGE_UPDATEWEIGHTPOPUP")) then
						CovenantForge:ShowPopup("COVENANTFORGE_UPDATEWEIGHTPOPUP", i)
					end
						FadeMenu(barmenuframe)
				end,
			},
			addgraph = {
				order = 30,
				name = "Delete Current Profile",
				type = "execute",
				func = function(name)
					DeleteWeightProfile(ProfileTable[CovenantForge.savedPathdb.char.selectedProfile])
					FadeMenu(barmenuframe)

				end,
				disabled = function() return CovenantForge.savedPathdb.char.selectedProfile <= defaultindex end
				--me.AddCombatantToGraphWrapper,
			},
		}
	}

	barmenuframe = barmenuframe --or LD:OpenAce3Menu(baropts)
	barmenuframe:SetClampedToScreen(true)
	barmenuframe:SetAlpha(1.0)
	barmenuframe:Show()

	local leftPos = myframe:GetLeft() -- Elsia: Side code adapted from Mirror
	local rightPos = myframe:GetRight()
	local side
	local oside
	if not rightPos then
		rightPos = 0
	end
	if not leftPos then
		leftPos = 0
	end

	local rightDist = GetScreenWidth() - rightPos

	if leftPos and rightDist < leftPos then
		side = "TOPLEFT"
		oside = "TOPRIGHT"
	else
		side = "TOPRIGHT"
		oside = "TOPLEFT"
	end

	barmenuframe:ClearAllPoints()
	barmenuframe:SetPoint(oside, myframe, side, 0, 0)
	--barmenuframe:SetFrameLevel(myframe:GetFrameLevel() + 9)
end


CovenantForge_WeightsEditFrameMixin = {}

function CovenantForge_WeightsEditFrameMixin:OnAccept()
local text = self.EditBox:GetText()
--print(text)
action(text)
action = nil
CovenantForge:ClosePopups()
end