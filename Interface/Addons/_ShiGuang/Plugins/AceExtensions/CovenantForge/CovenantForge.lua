--	///////////////////////////////////////////////////////////////////////////////////////////	 
--	Author: SLOKnightfall
--	Version: V1.7
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
		[252] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,45,43,48,58,48,52,53,},{"Embrace Death",0,38,43,56,57,58,60,66,},{"Eternal Hunger",0,126,132,148,140,153,156,160,},{"Convocation of the Dead",0,48,44,59,61,70,79,75,},{"Pointed Courage (3 Allies) (Kleia)",129,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",29,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",191,0,0,0,0,0,0,0,},{"Lingering Plague",0,29,32,33,36,32,44,39,},{"Combat Meditation (Never Extend) (Pelagos)",115,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",83,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",49,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",202,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",159,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,13,8,17,10,20,23,23,},{"Embrace Death",0,33,42,46,52,56,57,61,},{"Eternal Hunger",0,112,133,138,141,149,147,146,},{"Soothing Shade (Theotar)",106,0,0,0,0,0,0,0,},{"Convocation of the Dead",0,27,46,42,50,66,77,87,},{"Dauntless Duelist (Nadjia)",98,0,0,0,0,0,0,0,},{"Lingering Plague",0,26,24,29,27,25,32,36,},{"Thrill Seeker (Nadjia)",75,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",70,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-5,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",-5,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",47,0,0,0,0,0,0,0,},{"Built for War (Draven)",143,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,21,29,31,27,27,34,39,},{"Eternal Hunger",0,120,134,139,137,146,146,155,},{"Embrace Death",0,37,45,44,49,56,63,60,},{"Field of Blossoms (Dreamweaver)",41,0,0,0,0,0,0,0,},{"Convocation of the Dead",0,26,33,36,42,53,60,59,},{"Wild Hunt Tactics (Korayn)",70,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",147,0,0,0,0,0,0,0,},{"First Strike (Korayn)",24,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Lingering Plague",0,21,32,33,31,33,31,27,},{"Grove Invigoration (Niya)",103,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",64,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,15,25,22,16,17,25,30,},{"Embrace Death",0,38,50,42,45,53,58,59,},{"Eternal Hunger",0,118,130,142,145,154,150,155,},{"Convocation of the Dead",0,39,44,46,49,78,74,77,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",89,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",21,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",162,0,0,0,0,0,0,0,},{"Lingering Plague",0,33,27,21,29,27,38,30,},{"Lead by Example (2 Allies) (Emeni)",113,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",58,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",102,0,0,0,0,0,0,0,},},},
		[578] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,39,44,46,52,54,64,64,},{"Soul Furnace",0,15,19,22,26,24,28,31,},{"Pointed Courage (5 Allies) (Kleia)",96,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",56,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",21,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",49,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",47,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",61,0,0,0,0,0,0,0,},{"Growing Inferno",0,26,24,32,29,35,33,37,},{"Combat Meditation (Always Extend) (Pelagos)",79,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,23,28,29,35,33,33,35,},{"Soul Furnace",0,18,25,28,21,29,29,30,},{"Exacting Preparation (Nadjia)",21,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",32,0,0,0,0,0,0,0,},{"Growing Inferno",0,28,27,33,34,39,37,43,},{"Soothing Shade (Theotar)",43,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",43,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",63,0,0,0,0,0,0,0,},{"Built for War (Draven)",64,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",44,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",104,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,31,34,38,40,43,45,49,},{"Soul Furnace",0,17,19,20,25,25,32,27,},{"Grove Invigoration (Niya)",68,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",28,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",81,0,0,0,0,0,0,0,},{"First Strike (Korayn)",38,0,0,0,0,0,0,0,},{"Growing Inferno",0,27,34,30,34,32,43,41,},{"Niya's Tools: Burrs (Niya)",150,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",43,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",52,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",70,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,9,16,11,17,18,21,30,},{"Soul Furnace",0,22,23,24,25,27,33,30,},{"Lead by Example (0 Allies) (Emeni)",18,0,0,0,0,0,0,0,},{"Growing Inferno",0,24,28,37,35,35,40,43,},{"Lead by Example (2 Allies) (Emeni)",34,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",46,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",14,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",2,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",56,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",51,0,0,0,0,0,0,0,},},},
		[70] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,105,119,122,131,141,150,164,},{"Expurgation",0,87,99,104,103,119,132,130,},{"Truth's Wake",0,16,13,18,23,19,19,24,},{"Virtuous Command",0,118,134,142,162,167,178,194,},{"Pointed Courage (5 Allies) (Kleia)",140,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",10,0,0,0,0,0,0,0,},{"Templar's Vindication",0,109,116,137,140,149,169,171,},{"Combat Meditation (Always Extend) (Pelagos)",125,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",103,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",76,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",29,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",89,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",63,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,73,78,81,95,113,111,108,},{"Truth's Wake",0,17,17,14,16,21,26,22,},{"Expurgation",0,82,88,97,113,112,124,135,},{"Dauntless Duelist (Nadjia)",104,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",52,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",65,0,0,0,0,0,0,0,},{"Templar's Vindication",0,114,114,125,134,149,159,172,},{"Virtuous Command",0,105,115,132,142,158,158,169,},{"Soothing Shade (Theotar)",72,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",16,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",88,0,0,0,0,0,0,0,},{"Built for War (Draven)",106,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,29,24,28,29,30,32,32,},{"Truth's Wake",0,15,14,25,23,25,29,29,},{"Expurgation",0,90,100,109,111,131,132,150,},{"Virtuous Command",0,117,126,143,154,161,176,188,},{"Social Butterfly (Dreamweaver)",45,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",109,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",6,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",78,0,0,0,0,0,0,0,},{"Templar's Vindication",0,115,125,143,155,163,173,193,},{"Niya's Tools: Burrs (Niya)",177,0,0,0,0,0,0,0,},{"First Strike (Korayn)",14,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",8,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",121,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,15,16,21,14,24,26,23,},{"Expurgation",0,89,91,108,109,115,133,132,},{"Plaguey's Preemptive Strike (Marileth)",13,0,0,0,0,0,0,0,},{"Virtuous Command",0,109,114,132,140,144,159,176,},{"Truth's Wake",0,21,22,23,23,30,26,37,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",72,0,0,0,0,0,0,0,},{"Templar's Vindication",0,113,120,133,138,148,159,179,},{"Forgeborne Reveries (Heirmir)",79,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",68,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",45,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",28,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},},},
		[72] ={{{"Power",1,145,158,171,184,200,213,226,},{"Piercing Verdict",0,21,22,31,28,33,24,32,},{"Depths of Insanity",0,35,33,31,36,43,44,50,},{"Ashen Juggernaut",0,60,73,86,88,89,104,110,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",104,0,0,0,0,0,0,0,},{"Hack and Slash",0,15,17,23,28,34,34,41,},{"Bron's Call to Action (Mikanikos)",66,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",24,0,0,0,0,0,0,0,},{"Vicious Contempt",0,25,22,22,32,34,43,37,},{"Pointed Courage (3 Allies) (Kleia)",91,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",150,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",60,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",77,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Harrowing Punishment",0,10,16,13,9,15,17,24,},{"Depths of Insanity",0,33,30,40,46,44,51,51,},{"Refined Palate (Theotar)",111,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,70,74,84,-364,99,101,113,},{"Dauntless Duelist (Nadjia)",110,0,0,0,0,0,0,0,},{"Vicious Contempt",0,28,28,39,36,42,42,46,},{"Thrill Seeker (Nadjia)",88,0,0,0,0,0,0,0,},{"Hack and Slash",0,19,16,22,17,23,25,28,},{"Soothing Shade (Theotar)",74,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",29,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-2,0,0,0,0,0,0,0,},{"Built for War (Draven)",104,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,14,22,24,23,26,31,34,},{"Ashen Juggernaut",0,68,81,84,90,96,107,114,},{"Grove Invigoration (Niya)",130,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",91,0,0,0,0,0,0,0,},{"Depths of Insanity",0,39,44,42,49,50,50,55,},{"Niya's Tools: Poison (Niya)",-4,0,0,0,0,0,0,0,},{"Vicious Contempt",0,25,31,34,34,37,41,45,},{"Field of Blossoms (Dreamweaver)",88,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",165,0,0,0,0,0,0,0,},{"First Strike (Korayn)",19,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-2,0,0,0,0,0,0,0,},{"Hack and Slash",0,26,22,23,27,39,31,34,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Veteran's Repute",0,47,55,58,54,62,71,75,},{"Depths of Insanity",0,41,49,42,58,56,62,63,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",87,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,79,86,92,101,102,115,123,},{"Forgeborne Reveries (Heirmir)",76,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",1,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",1,0,0,0,0,0,0,0,},{"Vicious Contempt",0,37,36,38,44,37,42,46,},{"Hack and Slash",0,29,29,28,33,41,39,42,},{"Lead by Example (0 Allies) (Emeni)",1,0,0,0,0,0,0,0,},},},
		[577] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,22,19,27,30,35,29,41,},{"Growing Inferno",0,60,62,72,78,87,92,95,},{"Relentless Onslaught",0,54,60,67,79,81,83,92,},{"Dancing with Fate",0,-1,6,3,7,3,-1,12,},{"Serrated Glaive",0,-3,-2,-8,-8,-2,-2,0,},{"Combat Meditation (Always Extend) (Pelagos)",79,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",59,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",32,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",24,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",79,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",123,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",3,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",67,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,-4,0,-7,0,-3,0,-2,},{"Growing Inferno",0,72,72,82,88,94,98,102,},{"Relentless Onslaught",0,59,74,75,77,88,92,104,},{"Serrated Glaive",0,3,10,3,0,3,6,2,},{"Dancing with Fate",0,8,11,9,11,17,15,14,},{"Refined Palate (Theotar)",135,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",41,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",23,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",83,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",104,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",63,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",57,0,0,0,0,0,0,0,},{"Built for War (Draven)",112,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,28,38,32,39,35,47,48,},{"Growing Inferno",0,64,65,72,82,87,99,102,},{"Niya's Tools: Herbs (Niya)",7,0,0,0,0,0,0,0,},{"Relentless Onslaught",0,54,61,65,75,80,81,91,},{"Niya's Tools: Poison (Niya)",163,0,0,0,0,0,0,0,},{"Dancing with Fate",0,8,8,0,7,10,8,13,},{"Serrated Glaive",0,9,-6,6,0,-1,2,5,},{"Niya's Tools: Burrs (Niya)",183,0,0,0,0,0,0,0,},{"First Strike (Korayn)",20,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",45,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",88,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",90,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",112,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,13,22,23,32,41,49,61,},{"Relentless Onslaught",0,64,59,72,78,78,93,99,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",109,0,0,0,0,0,0,0,},{"Serrated Glaive",0,8,8,0,11,6,8,10,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Dancing with Fate",0,3,6,5,4,8,9,9,},{"Growing Inferno",0,71,79,81,93,96,106,108,},{"Lead by Example (2 Allies) (Emeni)",68,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",36,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",20,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",91,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",97,0,0,0,0,0,0,0,},},},
		[104] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,13,11,4,14,12,13,16,},{"Savage Combatant",0,67,69,78,85,95,96,103,},{"Pointed Courage (5 Allies) (Kleia)",94,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,45,49,56,60,65,64,72,},{"Pointed Courage (3 Allies) (Kleia)",50,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",16,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",131,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",51,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",70,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",42,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,27,32,32,33,32,38,41,},{"Savage Combatant",0,77,88,93,104,107,112,121,},{"Wasteland Propriety (Theotar)",40,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,67,79,79,85,92,100,99,},{"Soothing Shade (Theotar)",46,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",38,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",42,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",73,0,0,0,0,0,0,0,},{"Built for War (Draven)",68,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",5,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",17,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,55,58,63,66,71,77,87,},{"Savage Combatant",0,61,65,73,83,87,89,98,},{"Grove Invigoration (Niya)",104,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",33,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",42,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-3,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",75,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,40,37,48,52,58,63,66,},{"Niya's Tools: Burrs (Niya)",182,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",92,0,0,0,0,0,0,0,},{"First Strike (Korayn)",38,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,33,41,41,53,52,55,57,},{"Savage Combatant",0,71,74,79,83,91,98,104,},{"Lead by Example (4 Allies) (Emeni)",35,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",16,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,56,63,64,69,76,79,77,},{"Plaguey's Preemptive Strike (Marileth)",15,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",29,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",60,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",57,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},},},
		[265] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,-1,-1,-1,-1,0,-2,-1,},{"Cold Embrace",0,91,95,106,113,127,133,138,},{"Corrupting Leer",0,16,16,24,27,17,19,24,},{"Focused Malignancy",0,150,166,178,200,208,222,241,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",140,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",112,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",79,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",29,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",33,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",157,0,0,0,0,0,0,0,},{"Rolling Agony",0,23,25,26,21,36,22,23,},{"Pointed Courage (3 Allies) (Kleia)",93,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,39,51,54,49,53,59,62,},{"Corrupting Leer",0,-44,-39,-39,-37,-38,-28,-20,},{"Focused Malignancy",0,127,133,152,167,184,191,202,},{"Cold Embrace",0,94,87,99,106,113,125,137,},{"Rolling Agony",0,22,23,11,19,14,19,22,},{"Thrill Seeker (Nadjia)",89,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",56,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",110,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",93,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",4,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",18,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",46,0,0,0,0,0,0,0,},{"Built for War (Draven)",138,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,50,59,59,63,63,71,78,},{"Corrupting Leer",0,-6,-7,0,-9,1,-5,0,},{"Cold Embrace",0,82,90,109,114,127,129,142,},{"Niya's Tools: Poison (Niya)",4,0,0,0,0,0,0,0,},{"Focused Malignancy",0,140,147,163,172,187,211,223,},{"Field of Blossoms (Dreamweaver)",112,0,0,0,0,0,0,0,},{"Rolling Agony",0,13,10,10,12,19,11,9,},{"Niya's Tools: Burrs (Niya)",177,0,0,0,0,0,0,0,},{"First Strike (Korayn)",3,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",0,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",55,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",155,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",118,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,56,56,70,63,72,20,78,},{"Corrupting Leer",0,14,15,15,19,19,24,30,},{"Cold Embrace",0,83,96,103,115,121,124,139,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",86,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",115,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",4,0,0,0,0,0,0,0,},{"Rolling Agony",0,13,12,2,12,11,12,13,},{"Lead by Example (4 Allies) (Emeni)",80,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},{"Focused Malignancy",0,134,142,152,168,176,193,198,},{"Lead by Example (2 Allies) (Emeni)",58,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",29,0,0,0,0,0,0,0,},},},
		[103] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,-11,-14,-11,-15,-4,-9,-1,},{"Taste for Blood",0,68,78,82,90,101,104,111,},{"Bron's Call to Action (Mikanikos)",61,0,0,0,0,0,0,0,},{"Incessant Hunter",0,28,34,33,34,35,44,42,},{"Sudden Ambush",0,72,72,81,87,101,102,107,},{"Pointed Courage (5 Allies) (Kleia)",171,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",25,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",133,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",107,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",47,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",112,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",150,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,55,64,68,68,77,81,84,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,29,30,39,44,41,46,44,},{"Taste for Blood",0,58,66,69,76,87,90,92,},{"Incessant Hunter",0,17,20,25,20,27,25,34,},{"Dauntless Duelist (Nadjia)",101,0,0,0,0,0,0,0,},{"Built for War (Draven)",104,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",68,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",63,0,0,0,0,0,0,0,},{"Sudden Ambush",0,50,61,64,75,81,90,88,},{"Refined Palate (Theotar)",58,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",83,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,48,36,47,53,66,55,64,},{"Superior Tactics (Draven)",-6,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",11,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,62,61,73,78,82,86,101,},{"Taste for Blood",0,77,79,95,100,107,117,125,},{"Incessant Hunter",0,20,16,24,24,28,24,37,},{"Sudden Ambush",0,63,63,76,80,78,86,94,},{"Carnivorous Instinct",0,51,53,58,71,74,75,87,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",157,0,0,0,0,0,0,0,},{"First Strike (Korayn)",11,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",169,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",121,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",64,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",52,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,40,38,45,50,54,58,65,},{"Incessant Hunter",0,30,25,23,27,31,32,32,},{"Taste for Blood",0,60,66,80,83,83,90,87,},{"Sudden Ambush",0,69,80,78,85,98,99,107,},{"Lead by Example (4 Allies) (Emeni)",60,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",93,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",110,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",23,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,50,41,56,61,62,70,73,},{"Lead by Example (0 Allies) (Emeni)",22,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",49,0,0,0,0,0,0,0,},},},
		[253] ={{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,12,21,21,31,30,23,36,},{"Ferocious Appetite",0,-9,-6,-3,1,5,5,9,},{"One With the Beast",0,15,24,28,37,45,54,63,},{"Enfeebled Mark",0,77,86,83,105,107,116,121,},{"Hammer of Genesis (Mikanikos)",7,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",114,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",75,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",101,0,0,0,0,0,0,0,},{"Echoing Call",0,0,-1,-3,3,-3,-4,-4,},{"Pointed Courage (1 Ally) (Kleia)",29,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",79,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",126,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",48,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,22,26,25,26,33,30,36,},{"Empowered Release",0,30,27,27,30,26,28,25,},{"Ferocious Appetite",0,1,5,1,1,8,12,13,},{"Echoing Call",0,7,4,6,7,3,3,6,},{"One With the Beast",0,19,27,38,45,52,62,66,},{"Built for War (Draven)",116,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",118,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",67,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",76,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",7,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",10,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",43,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",67,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,35,29,28,36,37,29,42,},{"Ferocious Appetite",0,-28,-26,-18,-19,-18,-15,-7,},{"One With the Beast",0,18,14,27,34,55,61,63,},{"Echoing Call",0,-1,3,1,5,11,4,4,},{"Spirit Attunement",0,63,67,68,72,78,84,84,},{"Wild Hunt Tactics (Korayn)",55,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",109,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",178,0,0,0,0,0,0,0,},{"First Strike (Korayn)",7,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",123,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",127,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-5,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,11,21,18,22,27,20,20,},{"Necrotic Barrage",0,10,6,10,12,17,13,20,},{"Echoing Call",0,-8,-5,-3,-4,1,-8,-3,},{"Lead by Example (2 Allies) (Emeni)",50,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",28,0,0,0,0,0,0,0,},{"One With the Beast",0,7,13,30,32,37,45,49,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",75,0,0,0,0,0,0,0,},{"Ferocious Appetite",0,-7,-10,-1,-2,-2,-4,7,},{"Gnashing Chompers (Emeni)",-4,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",76,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",83,0,0,0,0,0,0,0,},},},
		[258] ={{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,136,142,147,154,164,157,167,},{"Courageous Ascension",0,71,80,84,92,101,106,104,},{"Rabid Shadows",0,27,26,31,39,37,42,40,},{"Mind Devourer",0,55,60,66,75,71,66,73,},{"Haunting Apparitions",0,66,67,71,83,84,87,104,},{"Hammer of Genesis (Mikanikos)",8,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",245,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",181,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",38,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",42,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",122,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",195,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",210,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,144,149,150,166,167,175,175,},{"Haunting Apparitions",0,69,76,85,87,95,101,107,},{"Rabid Shadows",0,27,35,39,39,39,43,41,},{"Shattered Perceptions",0,33,41,35,37,45,35,48,},{"Exacting Preparation (Nadjia)",25,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",1,0,0,0,0,0,0,0,},{"Mind Devourer",0,65,68,62,68,77,80,76,},{"Built for War (Draven)",149,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",120,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",82,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",87,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",99,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",45,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,154,153,156,163,175,169,179,},{"Fae Fermata",0,-5,-9,-3,-11,-19,-3,-5,},{"Rabid Shadows",0,5,25,31,32,29,28,33,},{"Haunting Apparitions",0,64,79,80,86,87,98,109,},{"Wild Hunt Tactics (Korayn)",121,0,0,0,0,0,0,0,},{"Mind Devourer",0,57,58,68,71,65,76,77,},{"Niya's Tools: Poison (Niya)",-10,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",129,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",165,0,0,0,0,0,0,0,},{"First Strike (Korayn)",8,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",4,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",62,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",155,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,165,158,165,172,169,178,189,},{"Festering Transfusion",0,54,55,56,58,61,72,65,},{"Mind Devourer",0,73,69,81,79,83,85,81,},{"Haunting Apparitions",0,82,84,93,89,102,104,116,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",126,0,0,0,0,0,0,0,},{"Rabid Shadows",0,19,38,44,46,46,50,54,},{"Forgeborne Reveries (Heirmir)",122,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",8,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",32,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",118,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",89,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",49,0,0,0,0,0,0,0,},},},
		[266] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,-6,2,-6,-5,-5,-5,-3,},{"Fel Commando",0,57,62,70,77,78,82,87,},{"Tyrant's Soul",0,56,67,67,73,72,75,88,},{"Borne of Blood",0,74,75,86,87,102,103,111,},{"Carnivorous Stalkers",0,37,40,47,51,51,59,59,},{"Bron's Call to Action (Mikanikos)",32,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",28,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",103,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",138,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",83,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",66,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",77,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,22,30,26,30,30,29,31,},{"Fel Commando",0,55,66,69,77,84,93,93,},{"Borne of Blood",0,78,80,90,98,99,108,121,},{"Tyrant's Soul",0,60,64,70,77,78,78,86,},{"Exacting Preparation (Nadjia)",16,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,42,46,47,51,54,63,63,},{"Dauntless Duelist (Nadjia)",94,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",51,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",41,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",76,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",50,0,0,0,0,0,0,0,},{"Built for War (Draven)",118,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,25,27,33,34,35,40,45,},{"Fel Commando",0,55,65,68,72,79,87,91,},{"Borne of Blood",0,72,75,84,95,104,106,115,},{"Tyrant's Soul",0,63,68,70,71,77,84,81,},{"Niya's Tools: Burrs (Niya)",170,0,0,0,0,0,0,0,},{"First Strike (Korayn)",6,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,40,44,43,53,62,60,59,},{"Niya's Tools: Poison (Niya)",2,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",103,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",113,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",45,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",31,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,46,45,54,62,58,14,66,},{"Fel Commando",0,56,64,66,73,84,88,96,},{"Tyrant's Soul",0,62,67,73,72,73,82,86,},{"Borne of Blood",0,69,79,80,93,102,109,109,},{"Plaguey's Preemptive Strike (Marileth)",5,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",69,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,46,45,52,48,59,62,73,},{"Forgeborne Reveries (Heirmir)",100,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",91,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",33,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",47,0,0,0,0,0,0,0,},},},
		[102] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,-8,-7,-2,-7,-8,-5,-9,},{"Stellar Inspiration",0,25,24,30,29,36,36,42,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Precise Alignment",0,27,34,31,40,39,39,47,},{"Umbral Intensity",0,38,32,44,44,51,49,65,},{"Combat Meditation (Always Extend) (Pelagos)",176,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",166,0,0,0,0,0,0,0,},{"Fury of the Skies",0,48,54,62,69,76,84,95,},{"Combat Meditation (Never Extend) (Pelagos)",152,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",54,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",80,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",149,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",26,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,60,72,77,83,92,93,106,},{"Stellar Inspiration",0,26,28,28,36,35,42,44,},{"Refined Palate (Theotar)",66,0,0,0,0,0,0,0,},{"Fury of the Skies",0,59,71,75,81,84,95,99,},{"Built for War (Draven)",152,0,0,0,0,0,0,0,},{"Precise Alignment",0,43,42,41,53,66,70,87,},{"Wasteland Propriety (Theotar)",90,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",83,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",88,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",2,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",30,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",120,0,0,0,0,0,0,0,},{"Umbral Intensity",0,48,52,57,60,65,83,62,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,105,111,123,136,147,150,168,},{"Stellar Inspiration",0,28,27,41,39,48,48,51,},{"Wild Hunt Tactics (Korayn)",131,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",100,0,0,0,0,0,0,0,},{"Fury of the Skies",0,62,67,68,83,92,99,92,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Umbral Intensity",0,41,44,48,49,53,59,71,},{"Grove Invigoration (Niya)",250,0,0,0,0,0,0,0,},{"Precise Alignment",0,-1,-5,6,12,17,18,21,},{"Social Butterfly (Dreamweaver)",44,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",168,0,0,0,0,0,0,0,},{"First Strike (Korayn)",9,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,50,57,60,65,69,78,76,},{"Precise Alignment",0,33,50,48,39,52,50,58,},{"Plaguey's Preemptive Strike (Marileth)",20,0,0,0,0,0,0,0,},{"Stellar Inspiration",0,30,28,31,35,39,45,48,},{"Gnashing Chompers (Emeni)",13,0,0,0,0,0,0,0,},{"Fury of the Skies",0,61,71,67,87,81,96,94,},{"Umbral Intensity",0,42,43,48,49,63,68,58,},{"Forgeborne Reveries (Heirmir)",126,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",52,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",32,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",96,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",25,0,0,0,0,0,0,0,},},},
		[63] ={{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,74,80,88,90,102,107,111,},{"Flame Accretion",0,-9,4,4,5,16,20,27,},{"Pointed Courage (3 Allies) (Kleia)",59,0,0,0,0,0,0,0,},{"Ire of the Ascended",0,60,66,63,80,83,86,92,},{"Bron's Call to Action (Mikanikos)",57,0,0,0,0,0,0,0,},{"Infernal Cascade",0,231,256,277,303,342,356,372,},{"Master Flame",0,-1,-3,-7,-3,-3,8,0,},{"Pointed Courage (1 Ally) (Kleia)",14,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",149,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",125,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",100,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",88,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-9,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,76,75,82,92,97,109,103,},{"Flame Accretion",0,11,9,17,18,23,28,35,},{"Refined Palate (Theotar)",36,0,0,0,0,0,0,0,},{"Infernal Cascade",0,250,278,312,334,360,381,408,},{"Master Flame",0,1,-4,-10,-6,-6,-3,-1,},{"Siphoned Malice",0,41,48,48,49,59,65,71,},{"Exacting Preparation (Nadjia)",17,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",44,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",105,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",93,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",66,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",61,0,0,0,0,0,0,0,},{"Built for War (Draven)",139,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,73,84,82,96,99,105,113,},{"Flame Accretion",0,6,5,16,20,25,32,31,},{"Infernal Cascade",0,261,284,311,341,364,390,415,},{"Discipline of the Grove",0,77,86,91,90,87,81,69,},{"Social Butterfly (Dreamweaver)",52,0,0,0,0,0,0,0,},{"Master Flame",0,4,-2,5,1,3,-3,1,},{"Niya's Tools: Burrs (Niya)",181,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",114,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",112,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",80,0,0,0,0,0,0,0,},{"First Strike (Korayn)",1,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",37,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,72,74,78,95,95,111,112,},{"Lead by Example (4 Allies) (Emeni)",164,0,0,0,0,0,0,0,},{"Infernal Cascade",0,244,272,295,328,350,378,403,},{"Master Flame",0,1,-2,0,-9,-8,-3,2,},{"Flame Accretion",0,0,7,11,16,21,29,40,},{"Gift of the Lich",0,9,6,10,6,8,6,13,},{"Lead by Example (0 Allies) (Emeni)",62,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",96,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",32,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",9,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",103,0,0,0,0,0,0,0,},},},
		[259] ={{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,50,57,67,58,73,75,74,},{"Maim, Mangle",0,48,48,44,51,53,56,57,},{"Bron's Call to Action (Mikanikos)",38,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",88,0,0,0,0,0,0,0,},{"Poisoned Katar",0,9,11,4,10,7,15,10,},{"Combat Meditation (Never Extend) (Pelagos)",68,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",13,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,55,70,74,76,78,83,94,},{"Combat Meditation (Always Extend) (Pelagos)",111,0,0,0,0,0,0,0,},{"Reverberation",0,47,51,57,64,67,65,73,},{"Pointed Courage (1 Ally) (Kleia)",38,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",100,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",161,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,46,47,50,60,65,67,77,},{"Maim, Mangle",0,33,33,34,50,54,52,52,},{"Lashing Scars",0,35,47,40,49,52,49,59,},{"Poisoned Katar",0,-5,-5,-4,-3,2,5,2,},{"Refined Palate (Theotar)",95,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,42,51,56,55,62,72,73,},{"Exacting Preparation (Nadjia)",29,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",109,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",108,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",81,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",31,0,0,0,0,0,0,0,},{"Built for War (Draven)",114,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",74,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,43,51,45,57,69,62,69,},{"Maim, Mangle",0,30,29,38,40,45,41,50,},{"Wild Hunt Tactics (Korayn)",102,0,0,0,0,0,0,0,},{"Poisoned Katar",0,3,-2,-5,0,-2,-3,2,},{"Niya's Tools: Poison (Niya)",161,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,57,60,62,70,66,73,86,},{"Niya's Tools: Burrs (Niya)",195,0,0,0,0,0,0,0,},{"First Strike (Korayn)",13,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",132,0,0,0,0,0,0,0,},{"Septic Shock",0,28,33,35,42,45,52,56,},{"Grove Invigoration (Niya)",116,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",102,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",51,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,48,51,61,61,64,73,73,},{"Well-Placed Steel",0,48,57,71,65,69,78,81,},{"Poisoned Katar",0,-3,1,-1,8,5,2,2,},{"Forgeborne Reveries (Heirmir)",82,0,0,0,0,0,0,0,},{"Maim, Mangle",0,35,32,39,49,50,47,52,},{"Sudden Fractures",0,35,40,45,58,48,54,61,},{"Lead by Example (4 Allies) (Emeni)",83,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",6,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",63,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",37,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",106,0,0,0,0,0,0,0,},},},
		[267] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,-3,1,3,-3,-7,0,0,},{"Duplicitous Havoc",0,-9,-3,-6,-8,-4,-6,-5,},{"Ashen Remains",0,34,41,52,45,52,55,63,},{"Combat Meditation (Always Extend) (Pelagos)",109,0,0,0,0,0,0,0,},{"Infernal Brand",0,25,30,38,41,36,46,41,},{"Hammer of Genesis (Mikanikos)",3,0,0,0,0,0,0,0,},{"Combusting Engine",0,33,39,48,51,48,56,56,},{"Combat Meditation (50% Extend) (Pelagos)",90,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",63,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",26,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",30,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",85,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",141,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,23,32,34,28,38,30,38,},{"Combusting Engine",0,38,42,49,52,58,59,56,},{"Refined Palate (Theotar)",57,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,0,-1,1,0,-2,2,2,},{"Ashen Remains",0,36,47,47,48,62,60,61,},{"Dauntless Duelist (Nadjia)",105,0,0,0,0,0,0,0,},{"Infernal Brand",0,36,34,36,39,41,49,48,},{"Exacting Preparation (Nadjia)",13,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Built for War (Draven)",129,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",78,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",80,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",46,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,25,26,27,33,36,38,39,},{"Combusting Engine",0,36,44,40,50,49,53,62,},{"Duplicitous Havoc",0,-5,1,-3,5,-10,-2,-2,},{"Niya's Tools: Poison (Niya)",4,0,0,0,0,0,0,0,},{"Ashen Remains",0,45,48,45,55,59,64,61,},{"Infernal Brand",0,25,39,34,38,41,44,50,},{"Wild Hunt Tactics (Korayn)",104,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",125,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",3,0,0,0,0,0,0,0,},{"First Strike (Korayn)",21,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",166,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",85,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,51,44,53,62,60,14,63,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",76,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,3,2,8,-1,2,8,2,},{"Ashen Remains",0,52,55,56,64,63,75,77,},{"Lead by Example (4 Allies) (Emeni)",103,0,0,0,0,0,0,0,},{"Infernal Brand",0,30,33,45,41,49,50,55,},{"Forgeborne Reveries (Heirmir)",101,0,0,0,0,0,0,0,},{"Combusting Engine",0,43,41,49,62,61,59,69,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",71,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",32,0,0,0,0,0,0,0,},},},
		[250] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,49,48,52,60,62,64,65,},{"Debilitating Malady",0,0,6,1,3,4,3,6,},{"Withering Plague",0,17,17,19,22,21,22,27,},{"Bron's Call to Action (Mikanikos)",44,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",37,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",53,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",60,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",5,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",58,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",97,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",20,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,11,12,10,13,14,12,14,},{"Debilitating Malady",0,1,5,1,-3,3,2,3,},{"Wasteland Propriety (Theotar)",21,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",-1,0,0,0,0,0,0,0,},{"Withering Plague",0,14,18,17,22,19,17,18,},{"Refined Palate (Theotar)",96,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",35,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",58,0,0,0,0,0,0,0,},{"Built for War (Draven)",63,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",1,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",43,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,43,45,48,51,56,61,62,},{"Debilitating Malady",0,2,-1,1,0,-4,2,1,},{"Grove Invigoration (Niya)",59,0,0,0,0,0,0,0,},{"Withering Plague",0,13,19,18,20,17,21,22,},{"Niya's Tools: Herbs (Niya)",20,0,0,0,0,0,0,0,},{"First Strike (Korayn)",17,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",180,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",53,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",64,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",27,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,12,12,15,16,16,16,16,},{"Debilitating Malady",0,6,2,3,2,2,4,3,},{"Lead by Example (0 Allies) (Emeni)",23,0,0,0,0,0,0,0,},{"Withering Plague",0,16,19,23,22,26,25,32,},{"Plaguey's Preemptive Strike (Marileth)",9,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",47,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",48,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",38,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",55,0,0,0,0,0,0,0,},},},
		[254] ={{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,22,27,32,41,44,48,61,},{"Brutal Projectiles",0,-1,5,2,2,10,2,4,},{"Enfeebled Mark",0,91,96,110,124,127,128,151,},{"Sharpshooter's Focus",0,34,41,39,51,49,55,58,},{"Deadly Chain",0,-3,3,-5,-3,3,-9,1,},{"Combat Meditation (50% Extend) (Pelagos)",136,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",164,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",99,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",48,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",32,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",161,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",95,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,15,24,29,32,38,47,46,},{"Brutal Projectiles",0,3,-4,-3,0,4,7,-4,},{"Empowered Release",0,41,41,36,44,46,37,42,},{"Deadly Chain",0,-15,-4,-6,-1,-7,-2,-5,},{"Sharpshooter's Focus",0,25,30,41,45,42,45,57,},{"Built for War (Draven)",112,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",114,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",65,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",57,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",78,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-6,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",22,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",30,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,24,28,30,40,50,49,51,},{"Spirit Attunement",0,94,91,102,111,109,112,118,},{"Sharpshooter's Focus",0,33,40,42,49,52,52,55,},{"Wild Hunt Tactics (Korayn)",146,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",124,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",159,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,1,-3,-3,0,5,9,-5,},{"Niya's Tools: Burrs (Niya)",154,0,0,0,0,0,0,0,},{"First Strike (Korayn)",10,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",52,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",207,0,0,0,0,0,0,0,},{"Deadly Chain",0,-8,-3,-11,-2,-6,-3,-1,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,26,35,44,39,54,60,61,},{"Necrotic Barrage",0,30,32,30,39,43,52,48,},{"Brutal Projectiles",0,9,12,6,6,1,6,19,},{"Deadly Chain",0,6,7,9,1,5,14,8,},{"Lead by Example (2 Allies) (Emeni)",66,0,0,0,0,0,0,0,},{"Sharpshooter's Focus",0,49,42,47,52,61,64,57,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",111,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",98,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",41,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",40,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",105,0,0,0,0,0,0,0,},},},
		[260] ={{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,135,150,145,166,179,192,216,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Reverberation",0,40,50,60,55,62,63,70,},{"Triple Threat",0,43,50,54,57,61,64,72,},{"Sleight of Hand",0,53,54,59,62,65,70,73,},{"Combat Meditation (Always Extend) (Pelagos)",98,0,0,0,0,0,0,0,},{"Ambidexterity",0,0,6,7,5,9,0,5,},{"Combat Meditation (50% Extend) (Pelagos)",67,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",107,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",98,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",156,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",49,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",25,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,133,146,163,172,189,199,214,},{"Triple Threat",0,45,51,59,62,62,60,76,},{"Lashing Scars",0,48,53,64,56,71,64,66,},{"Thrill Seeker (Nadjia)",82,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",41,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",102,0,0,0,0,0,0,0,},{"Sleight of Hand",0,46,53,66,67,69,76,80,},{"Built for War (Draven)",128,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",124,0,0,0,0,0,0,0,},{"Ambidexterity",0,2,4,2,8,4,5,3,},{"Refined Palate (Theotar)",113,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",41,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",78,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,124,135,156,176,183,200,219,},{"Septic Shock",0,26,26,34,36,45,52,51,},{"Triple Threat",0,39,46,51,43,55,61,66,},{"Field of Blossoms (Dreamweaver)",81,0,0,0,0,0,0,0,},{"Sleight of Hand",0,44,48,65,58,68,66,70,},{"Niya's Tools: Burrs (Niya)",224,0,0,0,0,0,0,0,},{"First Strike (Korayn)",21,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",122,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",192,0,0,0,0,0,0,0,},{"Ambidexterity",0,-2,-3,3,2,-5,-2,0,},{"Social Butterfly (Dreamweaver)",58,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",111,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",112,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,124,135,142,157,171,191,204,},{"Triple Threat",0,38,40,50,53,49,51,65,},{"Sudden Fractures",0,22,28,40,35,31,33,40,},{"Lead by Example (4 Allies) (Emeni)",67,0,0,0,0,0,0,0,},{"Sleight of Hand",0,39,51,49,53,57,62,66,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",86,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",95,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",45,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",25,0,0,0,0,0,0,0,},{"Ambidexterity",0,6,1,0,-1,-8,-4,3,},},},
		[71] ={{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,54,53,58,67,70,69,81,},{"Ashen Juggernaut",0,96,104,110,116,130,144,151,},{"Piercing Verdict",0,17,25,23,32,28,29,34,},{"Crash the Ramparts",0,34,44,39,43,52,56,57,},{"Merciless Bonegrinder",0,2,0,-6,4,7,5,4,},{"Hammer of Genesis (Mikanikos)",12,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",99,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",78,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",130,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",59,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",27,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",63,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",79,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,31,43,39,34,43,53,56,},{"Crash the Ramparts",0,18,27,25,33,32,32,47,},{"Ashen Juggernaut",0,96,116,122,129,142,150,163,},{"Dauntless Duelist (Nadjia)",104,0,0,0,0,0,0,0,},{"Built for War (Draven)",106,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",55,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",83,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",67,0,0,0,0,0,0,0,},{"Harrowing Punishment",0,19,25,27,22,29,22,29,},{"Merciless Bonegrinder",0,-4,-5,-9,-3,-3,-1,-1,},{"Superior Tactics (Draven)",-3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",5,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-8,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,4,13,15,19,21,18,34,},{"Crash the Ramparts",0,33,43,43,37,42,48,55,},{"Ashen Juggernaut",0,88,101,113,117,133,132,147,},{"Merciless Bonegrinder",0,1,5,6,2,-4,0,-1,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",128,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",77,0,0,0,0,0,0,0,},{"Mortal Combo",0,52,49,56,66,64,77,73,},{"Niya's Tools: Burrs (Niya)",156,0,0,0,0,0,0,0,},{"First Strike (Korayn)",25,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",2,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",84,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-2,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,50,53,60,66,73,75,82,},{"Ashen Juggernaut",0,108,123,123,138,141,158,171,},{"Veteran's Repute",0,48,61,59,70,74,77,77,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",72,0,0,0,0,0,0,0,},{"Crash the Ramparts",0,36,42,41,48,47,55,57,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",15,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",3,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",2,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",0,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",78,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,1,-1,2,0,-4,4,-4,},},},
		[73] ={{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,3,3,2,2,8,4,6,},{"Piercing Verdict",0,10,14,8,12,16,22,18,},{"Ashen Juggernaut",0,19,19,19,22,26,28,25,},{"Bron's Call to Action (Mikanikos)",61,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",10,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",103,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",111,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",61,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",141,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",80,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",17,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,1,1,2,4,5,4,10,},{"Harrowing Punishment",0,11,11,12,10,16,16,12,},{"Ashen Juggernaut",0,22,27,28,32,33,31,40,},{"Dauntless Duelist (Nadjia)",74,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",2,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",8,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",109,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",52,0,0,0,0,0,0,0,},{"Built for War (Draven)",70,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",103,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-1,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,14,18,25,25,27,29,38,},{"Show of Force",0,-3,0,-4,1,-3,1,0,},{"Ashen Juggernaut",0,15,16,19,17,17,19,22,},{"Wild Hunt Tactics (Korayn)",65,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",32,0,0,0,0,0,0,0,},{"First Strike (Korayn)",23,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",137,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",51,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",2,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",151,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,0,3,-3,3,1,5,5,},{"Veteran's Repute",0,29,36,35,40,38,40,46,},{"Ashen Juggernaut",0,19,19,21,25,23,24,28,},{"Plaguey's Preemptive Strike (Marileth)",16,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",5,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",54,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",5,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",5,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",-2,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",50,0,0,0,0,0,0,0,},},},
		[268] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,31,37,35,40,31,44,36,},{"Walk with the Ox",0,308,315,329,342,361,367,384,},{"Scalding Brew",0,14,15,25,20,23,24,27,},{"Bron's Call to Action (Mikanikos)",106,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",13,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",71,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",25,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",38,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",108,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",66,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",59,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,23,21,26,33,33,35,29,},{"Walk with the Ox",0,273,286,305,311,326,338,352,},{"Scalding Brew",0,13,16,8,19,16,17,15,},{"Built for War (Draven)",66,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",34,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",10,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",35,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",43,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",60,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",13,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",111,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,5,5,8,7,5,15,12,},{"Walk with the Ox",0,271,291,298,310,325,334,345,},{"Scalding Brew",0,8,13,13,20,15,16,14,},{"Wild Hunt Tactics (Korayn)",62,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",64,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",35,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",40,0,0,0,0,0,0,0,},{"First Strike (Korayn)",16,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",156,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",107,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",68,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,72,78,87,89,92,104,113,},{"Walk with the Ox",0,291,310,322,329,345,360,367,},{"Scalding Brew",0,11,10,14,16,18,21,17,},{"Lead by Example (0 Allies) (Emeni)",25,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",4,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",70,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",47,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",53,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",68,0,0,0,0,0,0,0,},},},
		[261] ={{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,61,64,67,68,79,91,95,},{"Reverberation",0,56,70,80,84,81,92,99,},{"Hammer of Genesis (Mikanikos)",-2,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",103,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",77,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",52,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",70,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,67,64,79,107,109,100,91,},{"Pointed Courage (1 Ally) (Kleia)",35,0,0,0,0,0,0,0,},{"Deeper Daggers",0,49,54,61,69,65,70,77,},{"Pointed Courage (3 Allies) (Kleia)",110,0,0,0,0,0,0,0,},{"Planned Execution",0,64,71,79,86,87,95,97,},{"Pointed Courage (5 Allies) (Kleia)",171,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,62,70,78,72,94,92,104,},{"Lashing Scars",0,60,62,84,73,79,90,101,},{"Thrill Seeker (Nadjia)",79,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,51,57,91,111,110,96,89,},{"Built for War (Draven)",156,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",150,0,0,0,0,0,0,0,},{"Deeper Daggers",0,66,72,71,77,81,92,93,},{"Refined Palate (Theotar)",99,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",78,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",73,0,0,0,0,0,0,0,},{"Planned Execution",0,76,85,82,96,104,107,112,},{"Exacting Preparation (Nadjia)",54,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",174,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,40,54,69,56,65,80,77,},{"Septic Shock",0,29,37,42,44,59,72,77,},{"Stiletto Staccato",0,34,30,46,75,90,79,75,},{"Planned Execution",0,65,65,78,80,81,97,100,},{"Field of Blossoms (Dreamweaver)",70,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",137,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",155,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",174,0,0,0,0,0,0,0,},{"First Strike (Korayn)",8,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",118,0,0,0,0,0,0,0,},{"Deeper Daggers",0,39,48,53,48,57,69,71,},{"Social Butterfly (Dreamweaver)",56,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",101,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,47,47,59,65,64,68,86,},{"Sudden Fractures",0,36,30,33,30,41,50,47,},{"Deeper Daggers",0,42,48,43,56,57,67,61,},{"Stiletto Staccato",0,40,40,63,87,94,79,67,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",100,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-5,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",14,0,0,0,0,0,0,0,},{"Planned Execution",0,53,63,79,80,75,91,89,},{"Lead by Example (2 Allies) (Emeni)",57,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",26,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",82,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",95,0,0,0,0,0,0,0,},},},
		[269] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,76,64,73,73,74,79,73,},{"Inner Fury",0,17,20,23,28,31,37,31,},{"Calculated Strikes",0,-6,-6,-8,-12,-4,-3,-6,},{"Combat Meditation (Never Extend) (Pelagos)",79,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,-2,-1,-8,-3,-8,-4,-9,},{"Xuen's Bond",0,41,37,36,40,47,52,53,},{"Hammer of Genesis (Mikanikos)",15,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",99,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",85,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",31,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",85,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",154,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",128,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,55,59,64,68,69,76,78,},{"Calculated Strikes",0,12,11,9,9,11,15,9,},{"Inner Fury",0,38,42,43,45,46,55,53,},{"Dauntless Duelist (Nadjia)",77,0,0,0,0,0,0,0,},{"Built for War (Draven)",118,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,9,12,8,7,7,12,12,},{"Xuen's Bond",0,50,55,47,54,60,57,71,},{"Thrill Seeker (Nadjia)",63,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",82,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",71,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",71,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",30,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",127,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,6,8,11,4,12,12,12,},{"Grove Invigoration (Niya)",176,0,0,0,0,0,0,0,},{"Calculated Strikes",0,-2,-8,-1,0,-5,3,1,},{"Inner Fury",0,26,27,27,29,37,42,37,},{"Coordinated Offensive",0,-5,-4,-2,1,-3,-6,-3,},{"Xuen's Bond",0,31,40,39,40,47,47,51,},{"Wild Hunt Tactics (Korayn)",69,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",144,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",87,0,0,0,0,0,0,0,},{"First Strike (Korayn)",19,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",177,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",51,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",30,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,49,59,75,79,82,90,106,},{"Calculated Strikes",0,-8,1,0,2,-1,-8,-4,},{"Inner Fury",0,35,29,34,36,41,38,40,},{"Coordinated Offensive",0,1,-8,-1,3,2,-4,-1,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",38,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",85,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",88,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",3,0,0,0,0,0,0,0,},{"Xuen's Bond",0,23,24,38,35,35,36,47,},{"Lead by Example (4 Allies) (Emeni)",109,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",76,0,0,0,0,0,0,0,},},},
		[251] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,45,44,50,56,54,63,57,},{"Accelerated Cold",0,82,92,90,87,100,103,114,},{"Pointed Courage (3 Allies) (Kleia)",125,0,0,0,0,0,0,0,},{"Eradicating Blow",0,18,27,28,21,22,27,33,},{"Combat Meditation (Always Extend) (Pelagos)",171,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",123,0,0,0,0,0,0,0,},{"Everfrost",0,83,94,93,112,113,123,127,},{"Bron's Call to Action (Mikanikos)",55,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",44,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",194,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",81,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,19,23,31,35,31,48,52,},{"Hammer of Genesis (Mikanikos)",3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,7,9,3,6,11,6,8,},{"Accelerated Cold",0,57,67,65,70,77,84,91,},{"Thrill Seeker (Nadjia)",54,0,0,0,0,0,0,0,},{"Eradicating Blow",0,16,11,14,12,15,21,26,},{"Everfrost",0,70,87,87,90,102,110,118,},{"Refined Palate (Theotar)",57,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,19,25,25,36,37,42,44,},{"Soothing Shade (Theotar)",81,0,0,0,0,0,0,0,},{"Built for War (Draven)",121,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",0,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",-7,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",65,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",108,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,32,30,32,40,34,37,42,},{"Eradicating Blow",0,26,22,33,36,45,34,31,},{"Accelerated Cold",0,87,95,109,111,114,123,120,},{"Wild Hunt Tactics (Korayn)",141,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",46,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",14,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",179,0,0,0,0,0,0,0,},{"First Strike (Korayn)",39,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",9,0,0,0,0,0,0,0,},{"Everfrost",0,82,98,103,116,112,120,139,},{"Grove Invigoration (Niya)",93,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",68,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,33,44,43,52,58,61,62,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,15,16,5,3,20,11,13,},{"Eradicating Blow",0,16,22,16,17,27,22,25,},{"Accelerated Cold",0,78,79,87,98,94,98,111,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",113,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,18,21,24,35,35,44,41,},{"Plaguey's Preemptive Strike (Marileth)",16,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",141,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",100,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",91,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",43,0,0,0,0,0,0,0,},{"Everfrost",0,84,86,91,97,112,117,124,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},},},
		[66] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,57,58,67,66,73,81,81,},{"Punish the Guilty",0,55,52,59,66,68,71,82,},{"Pointed Courage (5 Allies) (Kleia)",118,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",68,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",113,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",54,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",74,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",24,0,0,0,0,0,0,0,},{"Vengeful Shock",0,35,42,47,49,52,55,54,},{"Combat Meditation (Always Extend) (Pelagos)",94,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",27,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,81,82,98,100,105,119,124,},{"Punish the Guilty",0,42,44,51,58,60,63,72,},{"Wasteland Propriety (Theotar)",66,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",8,0,0,0,0,0,0,0,},{"Vengeful Shock",0,30,29,36,41,48,40,50,},{"Refined Palate (Theotar)",86,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",46,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",95,0,0,0,0,0,0,0,},{"Built for War (Draven)",91,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",60,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",1,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,11,9,15,10,16,22,14,},{"Punish the Guilty",0,48,53,58,58,69,71,75,},{"Grove Invigoration (Niya)",97,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",49,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",8,0,0,0,0,0,0,0,},{"First Strike (Korayn)",41,0,0,0,0,0,0,0,},{"Vengeful Shock",0,31,34,39,45,44,53,51,},{"Niya's Tools: Burrs (Niya)",178,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",80,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",105,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,24,22,31,29,35,36,38,},{"Punish the Guilty",0,49,49,54,57,60,66,72,},{"Lead by Example (0 Allies) (Emeni)",15,0,0,0,0,0,0,0,},{"Vengeful Shock",0,26,29,33,33,40,39,43,},{"Lead by Example (2 Allies) (Emeni)",30,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",46,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",19,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",59,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",62,0,0,0,0,0,0,0,},},},
	},
	["T26"]={
		[255] ={{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-5,-6,-11,-4,-10,-7,-16,},{"Enfeebled Mark",0,81,86,102,106,114,111,140,},{"Strength of the Pack",0,56,70,68,83,96,113,124,},{"Stinging Strike",0,52,50,63,68,77,87,90,},{"Combat Meditation (50% Extend) (Pelagos)",73,0,0,0,0,0,0,0,},{"Deadly Tandem",0,35,29,36,45,38,43,46,},{"Hammer of Genesis (Mikanikos)",8,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",97,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",63,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",88,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",29,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",102,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",198,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,6,6,8,9,-1,3,1,},{"Strength of the Pack",0,69,75,88,88,93,113,126,},{"Stinging Strike",0,55,59,70,82,82,79,87,},{"Deadly Tandem",0,42,51,48,53,50,64,67,},{"Empowered Release",0,65,71,72,74,65,61,84,},{"Built for War (Draven)",151,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",163,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",103,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",73,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",76,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",149,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",20,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",54,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-3,-9,-3,-8,-2,-2,-4,},{"Spirit Attunement",0,89,97,100,98,108,105,115,},{"Deadly Tandem",0,38,42,50,52,46,59,61,},{"Stinging Strike",0,58,60,67,66,78,92,91,},{"Strength of the Pack",0,65,71,90,98,107,117,123,},{"Wild Hunt Tactics (Korayn)",116,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",218,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",173,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",253,0,0,0,0,0,0,0,},{"First Strike (Korayn)",22,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-8,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",72,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",119,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,5,1,-5,1,-1,-2,3,},{"Strength of the Pack",0,60,65,84,75,95,101,118,},{"Necrotic Barrage",0,22,13,22,18,23,28,38,},{"Lead by Example (2 Allies) (Emeni)",80,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",42,0,0,0,0,0,0,0,},{"Stinging Strike",0,48,75,68,75,69,82,85,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",101,0,0,0,0,0,0,0,},{"Deadly Tandem",0,32,32,44,39,48,62,59,},{"Forgeborne Reveries (Heirmir)",124,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",28,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",115,0,0,0,0,0,0,0,},},},
		[262] ={{{"Power",1,145,158,171,184,200,213,226,},{"Elysian Dirge",0,33,37,42,52,46,60,57,},{"Pyroclastic Shock",0,31,41,46,53,62,77,69,},{"Shake the Foundations",0,-3,2,0,-7,8,-8,-4,},{"Hammer of Genesis (Mikanikos)",-2,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",108,0,0,0,0,0,0,0,},{"Call of Flame",0,91,83,83,86,97,93,100,},{"Combat Meditation (50% Extend) (Pelagos)",76,0,0,0,0,0,0,0,},{"High Voltage",0,13,16,12,14,5,19,18,},{"Combat Meditation (Never Extend) (Pelagos)",49,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",60,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",49,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",119,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",212,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,-1,-13,-19,2,8,0,1,},{"High Voltage",0,7,2,9,11,12,18,7,},{"Shake the Foundations",0,2,-9,-2,0,-8,-6,-1,},{"Pyroclastic Shock",0,36,45,45,51,56,69,83,},{"Call of Flame",0,82,80,73,77,82,88,89,},{"Built for War (Draven)",217,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",177,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",79,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",95,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",38,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",136,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",21,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",84,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,42,54,52,48,45,41,50,},{"Pyroclastic Shock",0,52,54,71,61,84,90,79,},{"High Voltage",0,27,25,33,27,27,25,35,},{"Social Butterfly (Dreamweaver)",79,0,0,0,0,0,0,0,},{"Shake the Foundations",0,13,17,13,3,5,15,12,},{"Field of Blossoms (Dreamweaver)",127,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",250,0,0,0,0,0,0,0,},{"First Strike (Korayn)",36,0,0,0,0,0,0,0,},{"Call of Flame",0,97,97,98,107,96,100,111,},{"Grove Invigoration (Niya)",156,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-1,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",199,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",183,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,3,21,19,31,31,26,19,},{"High Voltage",0,9,16,7,15,1,7,4,},{"Shake the Foundations",0,0,-6,-4,-13,-7,-13,-10,},{"Pyroclastic Shock",0,25,28,25,38,42,47,29,},{"Lead by Example (4 Allies) (Emeni)",137,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",111,0,0,0,0,0,0,0,},{"Call of Flame",0,86,88,87,93,81,88,105,},{"Gnashing Chompers (Emeni)",-10,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",26,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",99,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",44,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",162,0,0,0,0,0,0,0,},},},
		[62] ={{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,22,25,12,29,17,20,27,},{"Combat Meditation (Never Extend) (Pelagos)",79,0,0,0,0,0,0,0,},{"Nether Precision",0,44,57,43,61,53,55,59,},{"Arcane Prodigy",0,104,112,98,110,142,152,151,},{"Pointed Courage (3 Allies) (Kleia)",165,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",18,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",113,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",62,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",52,0,0,0,0,0,0,0,},{"Magi's Brand",0,116,126,137,139,155,166,167,},{"Pointed Courage (5 Allies) (Kleia)",260,0,0,0,0,0,0,0,},{"Ire of the Ascended",0,91,106,107,122,134,146,145,},{"Combat Meditation (50% Extend) (Pelagos)",85,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,19,8,18,11,7,10,20,},{"Nether Precision",0,38,43,47,48,59,41,64,},{"Arcane Prodigy",0,120,130,129,119,163,158,169,},{"Magi's Brand",0,114,114,140,139,157,160,166,},{"Built for War (Draven)",218,0,0,0,0,0,0,0,},{"Siphoned Malice",0,90,86,102,97,113,114,132,},{"Soothing Shade (Theotar)",98,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",54,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",80,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",25,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",184,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",140,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",72,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,8,11,6,21,11,-1,17,},{"Arcane Prodigy",0,-4,-10,-12,-18,-5,-10,-2,},{"Field of Blossoms (Dreamweaver)",53,0,0,0,0,0,0,0,},{"Discipline of the Grove",0,-31,21,63,82,108,128,143,},{"Wild Hunt Tactics (Korayn)",239,0,0,0,0,0,0,0,},{"Nether Precision",0,29,52,42,52,61,58,61,},{"Niya's Tools: Poison (Niya)",124,0,0,0,0,0,0,0,},{"Magi's Brand",0,114,140,142,152,167,169,181,},{"Niya's Tools: Burrs (Niya)",207,0,0,0,0,0,0,0,},{"First Strike (Korayn)",18,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-4,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",112,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",90,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,20,16,17,26,15,25,24,},{"Nether Precision",0,49,50,47,60,71,66,68,},{"Arcane Prodigy",0,107,122,109,102,150,143,154,},{"Gift of the Lich",0,60,77,81,90,97,86,104,},{"Magi's Brand",0,118,138,138,145,161,170,187,},{"Gnashing Chompers (Emeni)",14,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",183,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",174,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",219,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",308,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",130,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",41,0,0,0,0,0,0,0,},},},
		[263] ={{{"Power",1,145,158,171,184,200,213,226,},{"Elysian Dirge",0,35,35,52,55,51,49,64,},{"Unruly Winds",0,41,47,47,65,70,72,46,},{"Combat Meditation (50% Extend) (Pelagos)",123,0,0,0,0,0,0,0,},{"Magma Fist",0,31,26,39,40,35,37,44,},{"Chilled to the Core",0,32,31,37,36,41,40,39,},{"Hammer of Genesis (Mikanikos)",7,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",169,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",95,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",134,0,0,0,0,0,0,0,},{"Focused Lightning",0,32,44,50,60,71,77,81,},{"Pointed Courage (1 Ally) (Kleia)",53,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",143,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",245,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,10,14,19,15,27,19,20,},{"Unruly Winds",0,52,58,56,49,62,67,70,},{"Thrill Seeker (Nadjia)",132,0,0,0,0,0,0,0,},{"Chilled to the Core",0,34,38,37,42,42,44,39,},{"Magma Fist",0,22,31,34,31,30,33,32,},{"Refined Palate (Theotar)",101,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",106,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",158,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",150,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",47,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",63,0,0,0,0,0,0,0,},{"Focused Lightning",0,39,52,60,73,68,88,86,},{"Built for War (Draven)",181,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,34,14,35,34,37,23,27,},{"Magma Fist",0,25,38,31,38,27,41,30,},{"Unruly Winds",0,43,48,45,46,50,71,62,},{"Chilled to the Core",0,35,51,28,28,25,45,37,},{"Wild Hunt Tactics (Korayn)",146,0,0,0,0,0,0,0,},{"Focused Lightning",0,32,33,50,66,60,72,83,},{"Niya's Tools: Poison (Niya)",199,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",150,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",247,0,0,0,0,0,0,0,},{"First Strike (Korayn)",51,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-2,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",93,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",236,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,18,28,37,29,31,36,37,},{"Focused Lightning",0,32,38,53,55,74,73,103,},{"Plaguey's Preemptive Strike (Marileth)",39,0,0,0,0,0,0,0,},{"Magma Fist",0,18,34,31,30,29,34,31,},{"Unruly Winds",0,47,48,65,58,57,59,62,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",152,0,0,0,0,0,0,0,},{"Chilled to the Core",0,45,33,42,34,48,45,45,},{"Forgeborne Reveries (Heirmir)",142,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",120,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",71,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",52,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-14,0,0,0,0,0,0,0,},},},
		[64] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ire of the Ascended",0,73,96,102,119,128,138,135,},{"Unrelenting Cold",0,43,31,44,46,49,57,57,},{"Shivering Core",0,-10,-2,9,-2,-3,-1,0,},{"Ice Bite",0,90,119,121,127,148,153,163,},{"Combat Meditation (Always Extend) (Pelagos)",95,0,0,0,0,0,0,0,},{"Icy Propulsion",0,324,360,424,495,577,657,730,},{"Combat Meditation (Never Extend) (Pelagos)",54,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",31,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",94,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",158,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",71,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",84,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",15,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Siphoned Malice",0,78,76,96,105,108,125,128,},{"Unrelenting Cold",0,47,43,38,52,52,61,53,},{"Shivering Core",0,4,-3,-7,-1,-8,2,2,},{"Ice Bite",0,107,117,119,142,139,165,166,},{"Built for War (Draven)",204,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",161,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",77,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",128,0,0,0,0,0,0,0,},{"Icy Propulsion",0,348,425,526,595,651,728,823,},{"Soothing Shade (Theotar)",114,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",57,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",33,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",92,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Discipline of the Grove",0,-1,-7,-6,11,-3,2,-2,},{"Unrelenting Cold",0,41,38,37,41,48,41,52,},{"Shivering Core",0,1,-8,-7,-11,-5,-3,-10,},{"Ice Bite",0,95,107,118,126,137,149,158,},{"Wild Hunt Tactics (Korayn)",186,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",143,0,0,0,0,0,0,0,},{"Icy Propulsion",0,334,386,452,538,620,702,790,},{"Field of Blossoms (Dreamweaver)",11,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-10,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",70,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",264,0,0,0,0,0,0,0,},{"First Strike (Korayn)",12,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",83,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Gift of the Lich",0,23,18,25,29,40,29,32,},{"Shivering Core",0,-14,-13,-11,-16,-12,-12,-22,},{"Unrelenting Cold",0,25,26,36,38,42,50,50,},{"Forgeborne Reveries (Heirmir)",137,0,0,0,0,0,0,0,},{"Ice Bite",0,86,97,100,114,127,139,145,},{"Icy Propulsion",0,315,354,430,521,592,677,748,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",30,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-13,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",203,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",138,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",66,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",20,0,0,0,0,0,0,0,},},},
		[252] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,34,47,52,45,62,49,70,},{"Embrace Death",0,45,41,46,59,61,68,77,},{"Eternal Hunger",0,156,167,181,189,185,200,201,},{"Convocation of the Dead",0,54,55,72,88,99,106,99,},{"Pointed Courage (3 Allies) (Kleia)",154,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",206,0,0,0,0,0,0,0,},{"Lingering Plague",0,27,18,20,20,30,30,27,},{"Combat Meditation (Never Extend) (Pelagos)",120,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",91,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",44,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",262,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",149,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,10,23,29,31,25,31,22,},{"Embrace Death",0,58,62,66,82,75,66,90,},{"Eternal Hunger",0,172,179,199,184,210,205,215,},{"Soothing Shade (Theotar)",130,0,0,0,0,0,0,0,},{"Convocation of the Dead",0,72,71,90,100,79,94,107,},{"Dauntless Duelist (Nadjia)",135,0,0,0,0,0,0,0,},{"Lingering Plague",0,38,31,33,39,31,39,51,},{"Thrill Seeker (Nadjia)",107,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",72,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",2,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",-6,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",94,0,0,0,0,0,0,0,},{"Built for War (Draven)",187,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,20,23,26,12,37,41,46,},{"Eternal Hunger",0,164,180,189,190,201,211,204,},{"Embrace Death",0,45,50,64,69,68,73,78,},{"Field of Blossoms (Dreamweaver)",64,0,0,0,0,0,0,0,},{"Convocation of the Dead",0,48,63,61,66,77,85,90,},{"Wild Hunt Tactics (Korayn)",89,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-4,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",228,0,0,0,0,0,0,0,},{"First Strike (Korayn)",10,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-5,0,0,0,0,0,0,0,},{"Lingering Plague",0,38,27,33,28,29,36,45,},{"Grove Invigoration (Niya)",103,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",79,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,18,41,28,26,24,29,34,},{"Embrace Death",0,65,64,66,71,72,84,88,},{"Eternal Hunger",0,178,194,198,191,212,216,219,},{"Convocation of the Dead",0,75,90,83,98,93,106,97,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",153,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",9,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",33,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",193,0,0,0,0,0,0,0,},{"Lingering Plague",0,34,22,31,42,30,42,37,},{"Lead by Example (2 Allies) (Emeni)",128,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",60,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",165,0,0,0,0,0,0,0,},},},
		[578] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,53,68,71,79,80,85,96,},{"Soul Furnace",0,29,29,27,36,34,36,44,},{"Pointed Courage (5 Allies) (Kleia)",136,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",75,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",19,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",61,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",69,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",98,0,0,0,0,0,0,0,},{"Growing Inferno",0,34,45,41,42,46,52,58,},{"Combat Meditation (Always Extend) (Pelagos)",117,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-6,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,27,32,40,43,45,45,41,},{"Soul Furnace",0,26,38,30,37,38,44,43,},{"Exacting Preparation (Nadjia)",20,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",44,0,0,0,0,0,0,0,},{"Growing Inferno",0,42,40,43,55,52,61,66,},{"Soothing Shade (Theotar)",60,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",61,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",97,0,0,0,0,0,0,0,},{"Built for War (Draven)",97,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",55,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",100,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,44,55,49,59,61,64,76,},{"Soul Furnace",0,25,35,39,26,38,41,48,},{"Grove Invigoration (Niya)",121,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",114,0,0,0,0,0,0,0,},{"First Strike (Korayn)",59,0,0,0,0,0,0,0,},{"Growing Inferno",0,30,42,42,43,49,57,58,},{"Niya's Tools: Burrs (Niya)",225,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",75,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",73,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",94,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,3,16,13,22,30,27,34,},{"Soul Furnace",0,28,28,36,34,36,38,40,},{"Lead by Example (0 Allies) (Emeni)",24,0,0,0,0,0,0,0,},{"Growing Inferno",0,40,38,47,51,51,59,56,},{"Lead by Example (2 Allies) (Emeni)",50,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",66,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",24,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-7,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",77,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",66,0,0,0,0,0,0,0,},},},
		[70] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,165,167,187,201,225,227,252,},{"Expurgation",0,142,153,167,176,195,215,220,},{"Truth's Wake",0,30,24,26,27,36,34,45,},{"Virtuous Command",0,210,226,242,266,288,306,327,},{"Pointed Courage (5 Allies) (Kleia)",217,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",5,0,0,0,0,0,0,0,},{"Templar's Vindication",0,172,173,202,220,239,243,260,},{"Combat Meditation (Always Extend) (Pelagos)",187,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",152,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",103,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",44,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",129,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",106,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,104,117,117,132,152,156,167,},{"Truth's Wake",0,24,41,43,39,48,37,49,},{"Expurgation",0,145,155,173,193,205,226,236,},{"Dauntless Duelist (Nadjia)",176,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",105,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",82,0,0,0,0,0,0,0,},{"Templar's Vindication",0,171,180,197,220,238,250,274,},{"Virtuous Command",0,181,200,223,240,257,283,299,},{"Soothing Shade (Theotar)",112,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",28,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",129,0,0,0,0,0,0,0,},{"Built for War (Draven)",162,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,50,70,78,83,76,89,81,},{"Truth's Wake",0,35,28,37,31,32,36,50,},{"Expurgation",0,156,147,180,185,206,219,228,},{"Virtuous Command",0,192,220,251,258,281,303,325,},{"Social Butterfly (Dreamweaver)",85,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",170,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",3,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",84,0,0,0,0,0,0,0,},{"Templar's Vindication",0,177,188,216,233,246,262,276,},{"Niya's Tools: Burrs (Niya)",265,0,0,0,0,0,0,0,},{"First Strike (Korayn)",38,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-8,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",138,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,18,29,31,28,39,28,39,},{"Expurgation",0,144,150,183,186,200,211,223,},{"Plaguey's Preemptive Strike (Marileth)",25,0,0,0,0,0,0,0,},{"Virtuous Command",0,184,198,218,236,254,270,287,},{"Truth's Wake",0,26,37,32,37,31,41,42,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",105,0,0,0,0,0,0,0,},{"Templar's Vindication",0,162,179,200,212,232,244,261,},{"Forgeborne Reveries (Heirmir)",121,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",103,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",77,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",47,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",12,0,0,0,0,0,0,0,},},},
		[72] ={{{"Power",1,145,158,171,184,200,213,226,},{"Piercing Verdict",0,50,42,62,52,53,63,69,},{"Depths of Insanity",0,66,61,72,65,74,76,81,},{"Ashen Juggernaut",0,137,139,148,167,174,186,203,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",186,0,0,0,0,0,0,0,},{"Hack and Slash",0,42,56,46,65,71,68,74,},{"Bron's Call to Action (Mikanikos)",102,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",54,0,0,0,0,0,0,0,},{"Vicious Contempt",0,53,55,59,63,76,76,78,},{"Pointed Courage (3 Allies) (Kleia)",158,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",268,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",125,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",159,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Harrowing Punishment",0,32,23,35,33,36,30,37,},{"Depths of Insanity",0,50,-675,62,61,64,66,60,},{"Refined Palate (Theotar)",129,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,129,138,142,153,168,175,201,},{"Dauntless Duelist (Nadjia)",192,0,0,0,0,0,0,0,},{"Vicious Contempt",0,52,52,63,75,70,69,77,},{"Thrill Seeker (Nadjia)",136,0,0,0,0,0,0,0,},{"Hack and Slash",0,30,33,40,35,49,59,57,},{"Soothing Shade (Theotar)",129,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",219,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",45,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",14,0,0,0,0,0,0,0,},{"Built for War (Draven)",172,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,10,31,23,30,35,37,38,},{"Ashen Juggernaut",0,114,137,148,147,169,176,191,},{"Grove Invigoration (Niya)",204,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",143,0,0,0,0,0,0,0,},{"Depths of Insanity",0,53,50,59,63,74,75,87,},{"Niya's Tools: Poison (Niya)",197,0,0,0,0,0,0,0,},{"Vicious Contempt",0,38,43,40,46,58,62,66,},{"Field of Blossoms (Dreamweaver)",125,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",213,0,0,0,0,0,0,0,},{"First Strike (Korayn)",24,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-10,0,0,0,0,0,0,0,},{"Hack and Slash",0,34,42,45,58,54,63,47,},{"Social Butterfly (Dreamweaver)",80,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Veteran's Repute",0,74,72,87,97,106,111,121,},{"Depths of Insanity",0,63,73,80,67,71,87,99,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",133,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,137,152,155,180,190,195,212,},{"Forgeborne Reveries (Heirmir)",128,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",19,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",5,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",2,0,0,0,0,0,0,0,},{"Vicious Contempt",0,50,60,65,66,67,72,77,},{"Hack and Slash",0,45,53,61,60,59,74,80,},{"Lead by Example (0 Allies) (Emeni)",7,0,0,0,0,0,0,0,},},},
		[577] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,34,37,47,55,54,59,53,},{"Relentless Onslaught",0,113,121,131,152,170,178,192,},{"Serrated Glaive",0,-10,-5,-1,-8,-21,-10,-10,},{"Growing Inferno",0,93,103,118,125,137,147,146,},{"Hammer of Genesis (Mikanikos)",10,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",127,0,0,0,0,0,0,0,},{"Dancing with Fate",0,11,4,5,15,7,2,15,},{"Combat Meditation (50% Extend) (Pelagos)",96,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",50,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",99,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",132,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",217,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",54,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,-35,-30,-24,-18,-31,-27,-23,},{"Relentless Onslaught",0,120,127,134,149,168,180,186,},{"Serrated Glaive",0,-5,9,5,-3,-2,-5,0,},{"Growing Inferno",0,99,109,122,127,130,153,155,},{"Built for War (Draven)",149,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",165,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",131,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",94,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",127,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",16,0,0,0,0,0,0,0,},{"Dancing with Fate",0,13,14,6,15,7,14,19,},{"Wasteland Propriety (Theotar)",70,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",108,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,31,34,36,50,52,65,62,},{"Relentless Onslaught",0,115,123,142,148,165,171,191,},{"Growing Inferno",0,89,103,118,120,134,139,145,},{"Serrated Glaive",0,16,24,9,14,3,12,14,},{"Niya's Tools: Poison (Niya)",235,0,0,0,0,0,0,0,},{"Dancing with Fate",0,2,9,15,11,9,10,12,},{"Field of Blossoms (Dreamweaver)",133,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",170,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",273,0,0,0,0,0,0,0,},{"First Strike (Korayn)",46,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-1,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",71,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",139,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,15,36,52,67,70,92,103,},{"Dancing with Fate",0,17,14,-1,4,28,19,20,},{"Relentless Onslaught",0,129,137,158,171,188,206,199,},{"Serrated Glaive",0,-3,4,2,6,5,-1,5,},{"Growing Inferno",0,108,121,129,147,150,159,181,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",183,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",5,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",134,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",140,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",108,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",43,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",61,0,0,0,0,0,0,0,},},},
		[104] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,14,16,11,13,15,20,16,},{"Savage Combatant",0,100,111,119,121,133,142,158,},{"Pointed Courage (5 Allies) (Kleia)",138,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,61,68,78,70,82,93,100,},{"Pointed Courage (3 Allies) (Kleia)",80,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",27,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",195,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",78,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",101,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",61,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,35,37,42,43,46,52,53,},{"Savage Combatant",0,124,126,139,151,158,175,180,},{"Wasteland Propriety (Theotar)",50,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,98,101,105,115,115,126,135,},{"Soothing Shade (Theotar)",66,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",51,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",61,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",113,0,0,0,0,0,0,0,},{"Built for War (Draven)",104,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",11,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",23,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,73,79,84,93,101,107,110,},{"Savage Combatant",0,98,98,107,121,119,134,146,},{"Grove Invigoration (Niya)",149,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",57,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",64,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",2,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",106,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,48,65,71,72,79,89,95,},{"Niya's Tools: Burrs (Niya)",278,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",122,0,0,0,0,0,0,0,},{"First Strike (Korayn)",42,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,49,48,56,59,62,68,71,},{"Savage Combatant",0,96,103,108,120,140,139,149,},{"Lead by Example (4 Allies) (Emeni)",47,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",12,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,67,72,81,90,100,103,106,},{"Plaguey's Preemptive Strike (Marileth)",20,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",31,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",76,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",82,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},},},
		[265] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,0,23,-3,1,0,14,7,},{"Cold Embrace",0,147,145,170,169,189,206,214,},{"Corrupting Leer",0,25,33,32,42,35,49,50,},{"Focused Malignancy",0,228,235,261,276,302,327,356,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",210,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",165,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",112,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",51,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",50,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",257,0,0,0,0,0,0,0,},{"Rolling Agony",0,29,30,15,19,22,21,27,},{"Pointed Courage (3 Allies) (Kleia)",160,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,48,60,64,72,71,74,80,},{"Corrupting Leer",0,-56,-60,-51,-51,-42,-36,-36,},{"Focused Malignancy",0,180,215,231,244,259,275,300,},{"Cold Embrace",0,134,145,149,154,164,183,201,},{"Rolling Agony",0,12,26,14,16,28,15,18,},{"Thrill Seeker (Nadjia)",122,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",70,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",155,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",112,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-10,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",20,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",57,0,0,0,0,0,0,0,},{"Built for War (Draven)",196,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,55,69,78,79,87,89,98,},{"Corrupting Leer",0,-9,-4,3,3,4,2,1,},{"Cold Embrace",0,136,146,151,175,191,193,210,},{"Niya's Tools: Poison (Niya)",-19,0,0,0,0,0,0,0,},{"Focused Malignancy",0,181,209,227,247,261,283,314,},{"Field of Blossoms (Dreamweaver)",131,0,0,0,0,0,0,0,},{"Rolling Agony",0,6,-7,3,6,11,9,-7,},{"Niya's Tools: Burrs (Niya)",252,0,0,0,0,0,0,0,},{"First Strike (Korayn)",3,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-13,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",66,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",207,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",155,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,68,68,80,97,88,23,113,},{"Corrupting Leer",0,17,25,35,47,43,35,37,},{"Cold Embrace",0,127,141,160,160,176,184,216,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",124,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",165,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Rolling Agony",0,18,12,-1,2,11,24,26,},{"Lead by Example (4 Allies) (Emeni)",117,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",19,0,0,0,0,0,0,0,},{"Focused Malignancy",0,192,185,211,225,251,270,271,},{"Lead by Example (2 Allies) (Emeni)",75,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",51,0,0,0,0,0,0,0,},},},
		[103] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,-15,-28,-7,-14,5,-6,-20,},{"Taste for Blood",0,119,130,128,152,150,180,180,},{"Bron's Call to Action (Mikanikos)",100,0,0,0,0,0,0,0,},{"Incessant Hunter",0,18,32,34,36,41,44,54,},{"Sudden Ambush",0,117,126,126,141,157,152,170,},{"Pointed Courage (5 Allies) (Kleia)",283,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",166,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",140,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",64,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",181,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",202,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,88,91,102,115,120,126,123,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,61,73,73,88,91,90,103,},{"Taste for Blood",0,115,118,128,147,161,164,180,},{"Incessant Hunter",0,30,30,34,39,46,52,49,},{"Dauntless Duelist (Nadjia)",173,0,0,0,0,0,0,0,},{"Built for War (Draven)",167,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",95,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",122,0,0,0,0,0,0,0,},{"Sudden Ambush",0,107,116,111,130,145,148,154,},{"Refined Palate (Theotar)",75,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",111,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,79,91,100,110,109,117,137,},{"Superior Tactics (Draven)",-7,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",37,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,103,115,131,142,139,160,177,},{"Taste for Blood",0,126,138,147,186,196,196,226,},{"Incessant Hunter",0,10,16,21,29,24,31,29,},{"Sudden Ambush",0,103,113,93,120,136,152,153,},{"Carnivorous Instinct",0,83,97,99,116,128,122,136,},{"Niya's Tools: Poison (Niya)",-19,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",221,0,0,0,0,0,0,0,},{"First Strike (Korayn)",10,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-4,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",249,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",204,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",113,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",77,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,67,60,72,79,87,86,98,},{"Incessant Hunter",0,31,29,31,45,36,36,40,},{"Taste for Blood",0,108,107,133,129,137,163,175,},{"Sudden Ambush",0,113,113,127,146,145,160,170,},{"Lead by Example (4 Allies) (Emeni)",74,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",138,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",181,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",29,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,81,87,90,110,106,114,122,},{"Lead by Example (0 Allies) (Emeni)",25,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",48,0,0,0,0,0,0,0,},},},
		[253] ={{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,32,19,17,37,16,39,28,},{"Ferocious Appetite",0,-25,-14,-13,5,11,8,-3,},{"One With the Beast",0,7,23,30,47,69,57,87,},{"Enfeebled Mark",0,99,115,126,131,141,158,158,},{"Hammer of Genesis (Mikanikos)",-1,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",144,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",99,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",128,0,0,0,0,0,0,0,},{"Echoing Call",0,-7,-13,-9,-9,-11,1,-3,},{"Pointed Courage (1 Ally) (Kleia)",42,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",115,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",183,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",57,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,26,28,25,34,35,33,36,},{"Empowered Release",0,31,31,38,26,33,35,29,},{"Ferocious Appetite",0,-2,-13,-1,10,17,16,23,},{"Echoing Call",0,0,-2,7,-9,-4,-2,-14,},{"One With the Beast",0,22,36,46,56,58,79,80,},{"Built for War (Draven)",164,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",157,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",93,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",95,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",0,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",55,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",73,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,42,42,38,50,49,51,58,},{"Ferocious Appetite",0,-33,-25,-26,-20,-16,-17,-16,},{"One With the Beast",0,19,34,47,72,75,79,94,},{"Echoing Call",0,11,17,8,0,1,14,15,},{"Spirit Attunement",0,95,99,102,110,111,117,116,},{"Wild Hunt Tactics (Korayn)",89,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",155,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",258,0,0,0,0,0,0,0,},{"First Strike (Korayn)",13,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",192,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",182,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",74,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-6,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,33,35,45,43,36,46,43,},{"Necrotic Barrage",0,25,24,32,38,41,31,44,},{"Echoing Call",0,10,11,7,20,9,5,4,},{"Lead by Example (2 Allies) (Emeni)",94,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",51,0,0,0,0,0,0,0,},{"One With the Beast",0,28,36,59,55,73,75,88,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",118,0,0,0,0,0,0,0,},{"Ferocious Appetite",0,0,4,4,9,27,23,24,},{"Gnashing Chompers (Emeni)",2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",36,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",121,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",135,0,0,0,0,0,0,0,},},},
		[258] ={{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,219,228,226,241,235,256,277,},{"Courageous Ascension",0,113,136,129,127,155,160,164,},{"Rabid Shadows",0,16,28,24,44,43,43,47,},{"Mind Devourer",0,134,138,152,153,161,159,168,},{"Haunting Apparitions",0,101,108,116,139,169,166,172,},{"Hammer of Genesis (Mikanikos)",7,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",311,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",229,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",50,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",52,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",176,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",308,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",278,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,232,251,258,278,279,300,315,},{"Haunting Apparitions",0,124,128,152,157,173,176,190,},{"Rabid Shadows",0,24,51,46,59,66,77,71,},{"Shattered Perceptions",0,39,50,49,50,52,69,66,},{"Exacting Preparation (Nadjia)",27,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",13,0,0,0,0,0,0,0,},{"Mind Devourer",0,152,157,172,177,191,187,192,},{"Built for War (Draven)",236,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",204,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",135,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",102,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",150,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",77,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,252,257,282,282,287,296,311,},{"Fae Fermata",0,-8,-10,-17,0,-15,-8,-16,},{"Rabid Shadows",0,34,48,48,65,56,57,69,},{"Haunting Apparitions",0,124,149,155,163,177,199,210,},{"Wild Hunt Tactics (Korayn)",194,0,0,0,0,0,0,0,},{"Mind Devourer",0,160,149,159,176,180,169,189,},{"Niya's Tools: Poison (Niya)",-10,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",185,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",227,0,0,0,0,0,0,0,},{"First Strike (Korayn)",16,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-4,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",104,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",268,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,236,247,268,275,284,290,300,},{"Festering Transfusion",0,79,60,79,80,86,76,91,},{"Mind Devourer",0,164,158,170,168,184,184,190,},{"Haunting Apparitions",0,120,128,146,160,168,190,201,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",186,0,0,0,0,0,0,0,},{"Rabid Shadows",0,32,51,53,58,58,53,70,},{"Forgeborne Reveries (Heirmir)",186,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-8,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",22,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",190,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",129,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",72,0,0,0,0,0,0,0,},},},
		[266] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,7,3,12,4,5,12,7,},{"Fel Commando",0,95,107,114,115,129,137,148,},{"Combat Meditation (Never Extend) (Pelagos)",80,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",224,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,95,95,104,111,108,121,121,},{"Carnivorous Stalkers",0,65,73,80,80,86,88,101,},{"Pointed Courage (1 Ally) (Kleia)",44,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",134,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",136,0,0,0,0,0,0,0,},{"Borne of Blood",0,110,124,129,143,145,163,174,},{"Bron's Call to Action (Mikanikos)",62,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",111,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",21,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,34,26,34,27,32,40,35,},{"Fel Commando",0,75,82,90,96,109,128,131,},{"Carnivorous Stalkers",0,43,60,64,74,70,73,84,},{"Built for War (Draven)",164,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,85,85,95,99,101,112,113,},{"Wasteland Propriety (Theotar)",61,0,0,0,0,0,0,0,},{"Borne of Blood",0,96,117,123,135,141,150,159,},{"Thrill Seeker (Nadjia)",29,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",-4,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",123,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",42,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",77,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-7,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,36,48,42,46,42,54,50,},{"Fel Commando",0,84,84,98,113,116,123,138,},{"Social Butterfly (Dreamweaver)",67,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-1,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,52,60,66,80,79,81,85,},{"Tyrant's Soul",0,91,94,92,122,115,120,133,},{"Grove Invigoration (Niya)",132,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",146,0,0,0,0,0,0,0,},{"Borne of Blood",0,110,110,126,144,139,155,173,},{"Niya's Tools: Burrs (Niya)",217,0,0,0,0,0,0,0,},{"First Strike (Korayn)",5,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",1,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",36,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,54,53,57,66,69,16,82,},{"Lead by Example (0 Allies) (Emeni)",49,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,87,95,109,105,114,124,116,},{"Carnivorous Stalkers",0,52,67,74,73,81,82,96,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Fel Commando",0,84,95,113,110,122,121,141,},{"Borne of Blood",0,97,108,121,138,132,148,160,},{"Lead by Example (4 Allies) (Emeni)",125,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",10,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",148,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",57,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",88,0,0,0,0,0,0,0,},},},
		[102] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,33,37,23,27,42,39,49,},{"Stellar Inspiration",0,42,40,41,48,46,60,50,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Precise Alignment",0,80,82,92,82,99,102,95,},{"Umbral Intensity",0,58,82,81,84,92,89,102,},{"Combat Meditation (Always Extend) (Pelagos)",268,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",228,0,0,0,0,0,0,0,},{"Fury of the Skies",0,87,88,89,108,105,128,133,},{"Combat Meditation (Never Extend) (Pelagos)",197,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",92,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",133,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",244,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",62,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,97,104,100,108,131,117,141,},{"Stellar Inspiration",0,34,57,44,52,50,67,60,},{"Refined Palate (Theotar)",72,0,0,0,0,0,0,0,},{"Fury of the Skies",0,91,93,100,112,125,130,139,},{"Built for War (Draven)",220,0,0,0,0,0,0,0,},{"Precise Alignment",0,69,70,85,66,82,87,96,},{"Wasteland Propriety (Theotar)",109,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",108,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",126,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",2,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",35,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",177,0,0,0,0,0,0,0,},{"Umbral Intensity",0,63,65,96,101,93,97,113,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,131,139,166,161,182,188,201,},{"Stellar Inspiration",0,48,48,54,55,60,63,66,},{"Wild Hunt Tactics (Korayn)",187,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-5,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",111,0,0,0,0,0,0,0,},{"Fury of the Skies",0,85,93,108,110,123,124,141,},{"Niya's Tools: Herbs (Niya)",-6,0,0,0,0,0,0,0,},{"Umbral Intensity",0,67,64,68,77,83,94,99,},{"Grove Invigoration (Niya)",350,0,0,0,0,0,0,0,},{"Precise Alignment",0,38,55,63,75,76,84,106,},{"Social Butterfly (Dreamweaver)",77,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",252,0,0,0,0,0,0,0,},{"First Strike (Korayn)",25,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,71,73,85,102,98,118,123,},{"Precise Alignment",0,15,29,27,44,40,72,72,},{"Plaguey's Preemptive Strike (Marileth)",13,0,0,0,0,0,0,0,},{"Stellar Inspiration",0,23,34,29,43,63,55,43,},{"Gnashing Chompers (Emeni)",-3,0,0,0,0,0,0,0,},{"Fury of the Skies",0,82,93,105,103,122,128,128,},{"Umbral Intensity",0,54,64,82,66,75,95,97,},{"Forgeborne Reveries (Heirmir)",171,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",78,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",50,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",136,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",23,0,0,0,0,0,0,0,},},},
		[63] ={{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,88,104,97,128,124,143,151,},{"Master Flame",0,1,-6,-12,1,-5,1,-5,},{"Combat Meditation (Never Extend) (Pelagos)",161,0,0,0,0,0,0,0,},{"Ire of the Ascended",0,77,83,79,99,98,111,110,},{"Infernal Cascade",0,357,404,443,500,541,572,623,},{"Bron's Call to Action (Mikanikos)",85,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",201,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",28,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",70,0,0,0,0,0,0,0,},{"Flame Accretion",0,-4,6,7,-2,19,15,19,},{"Pointed Courage (5 Allies) (Kleia)",126,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",7,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",234,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,97,104,113,122,141,140,151,},{"Infernal Cascade",0,389,418,465,516,547,590,615,},{"Siphoned Malice",0,70,64,74,86,95,104,107,},{"Master Flame",0,3,3,-2,5,9,8,-3,},{"Flame Accretion",0,-1,0,17,19,31,24,26,},{"Built for War (Draven)",179,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",176,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",44,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",92,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",56,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",26,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",99,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",75,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,97,109,130,127,139,153,156,},{"Master Flame",0,10,10,17,5,0,7,11,},{"Infernal Cascade",0,404,458,498,539,581,631,667,},{"Niya's Tools: Poison (Niya)",171,0,0,0,0,0,0,0,},{"Discipline of the Grove",0,135,156,178,188,181,164,179,},{"Wild Hunt Tactics (Korayn)",182,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",66,0,0,0,0,0,0,0,},{"Flame Accretion",0,10,14,17,13,22,34,35,},{"Niya's Tools: Burrs (Niya)",273,0,0,0,0,0,0,0,},{"First Strike (Korayn)",12,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",96,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",75,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",12,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,104,122,123,129,151,162,171,},{"Master Flame",0,10,6,12,2,12,16,25,},{"Lead by Example (0 Allies) (Emeni)",109,0,0,0,0,0,0,0,},{"Gift of the Lich",0,35,42,29,30,40,41,38,},{"Infernal Cascade",0,412,443,481,521,559,601,651,},{"Forgeborne Reveries (Heirmir)",164,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",59,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",20,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",250,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",169,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",70,0,0,0,0,0,0,0,},{"Flame Accretion",0,20,20,31,27,40,44,40,},},},
		[259] ={{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,73,86,93,110,112,124,111,},{"Reverberation",0,68,68,80,97,90,91,102,},{"Maim, Mangle",0,51,62,76,65,90,87,103,},{"Poisoned Katar",0,2,12,5,7,6,5,8,},{"Pointed Courage (5 Allies) (Kleia)",259,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,85,92,113,105,120,122,138,},{"Combat Meditation (Never Extend) (Pelagos)",90,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",50,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",162,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",148,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",119,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",53,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,73,81,83,82,97,119,113,},{"Poisoned Katar",0,-4,0,-21,-16,-9,-13,0,},{"Lashing Scars",0,57,64,71,76,81,78,81,},{"Thrill Seeker (Nadjia)",109,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,72,76,89,95,103,119,121,},{"Built for War (Draven)",167,0,0,0,0,0,0,0,},{"Maim, Mangle",0,37,45,60,57,67,86,94,},{"Dauntless Duelist (Nadjia)",170,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",105,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",102,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",48,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",191,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",67,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,78,89,87,103,107,102,117,},{"Well-Placed Steel",0,87,92,103,116,116,121,146,},{"Maim, Mangle",0,53,60,65,64,73,85,80,},{"Septic Shock",0,45,37,60,58,69,79,93,},{"Poisoned Katar",0,2,-8,-2,7,9,-1,0,},{"Field of Blossoms (Dreamweaver)",137,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",236,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",272,0,0,0,0,0,0,0,},{"First Strike (Korayn)",23,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",188,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",80,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",171,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",165,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,66,80,91,94,105,106,121,},{"Sudden Fractures",0,56,60,52,73,68,82,80,},{"Well-Placed Steel",0,78,88,93,101,119,120,137,},{"Maim, Mangle",0,47,50,65,60,68,83,90,},{"Poisoned Katar",0,-10,11,-1,-7,4,-3,0,},{"Lead by Example (4 Allies) (Emeni)",126,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",162,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",131,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-3,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",22,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",72,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",57,0,0,0,0,0,0,0,},},},
		[267] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,3,1,19,4,8,15,3,},{"Infernal Brand",0,51,50,51,60,66,87,82,},{"Ashen Remains",0,73,92,87,94,114,108,120,},{"Combusting Engine",0,50,58,68,72,71,88,95,},{"Duplicitous Havoc",0,8,2,1,-1,4,3,-6,},{"Combat Meditation (Always Extend) (Pelagos)",185,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",135,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",104,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",42,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",159,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",250,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",22,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",40,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,37,34,46,41,48,51,52,},{"Infernal Brand",0,34,36,41,43,53,59,71,},{"Duplicitous Havoc",0,-1,-8,9,-11,-2,-7,-18,},{"Combusting Engine",0,52,47,53,57,58,72,72,},{"Exacting Preparation (Nadjia)",14,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",0,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",159,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",111,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",67,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",116,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",56,0,0,0,0,0,0,0,},{"Built for War (Draven)",197,0,0,0,0,0,0,0,},{"Ashen Remains",0,70,75,95,95,100,109,115,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,45,42,53,49,63,68,69,},{"Infernal Brand",0,50,56,50,64,84,66,67,},{"Social Butterfly (Dreamweaver)",76,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,-11,14,18,5,-5,3,6,},{"Ashen Remains",0,75,85,89,110,108,113,124,},{"Combusting Engine",0,51,61,61,67,86,81,88,},{"Niya's Tools: Burrs (Niya)",231,0,0,0,0,0,0,0,},{"First Strike (Korayn)",28,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",15,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",5,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",188,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",128,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",161,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,45,61,72,75,84,8,80,},{"Infernal Brand",0,35,46,38,51,60,67,70,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",116,0,0,0,0,0,0,0,},{"Combusting Engine",0,56,55,61,58,64,69,71,},{"Duplicitous Havoc",0,-12,-4,-3,6,-7,-2,-14,},{"Ashen Remains",0,73,93,93,111,111,116,128,},{"Forgeborne Reveries (Heirmir)",168,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",2,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",133,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",102,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",54,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},},},
		[250] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,74,84,84,89,90,93,100,},{"Debilitating Malady",0,11,12,10,7,9,-1,2,},{"Withering Plague",0,35,43,37,40,53,50,58,},{"Bron's Call to Action (Mikanikos)",83,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",59,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",86,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",102,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",11,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",98,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",160,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",34,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,18,24,21,20,26,30,35,},{"Debilitating Malady",0,5,3,11,7,13,11,8,},{"Wasteland Propriety (Theotar)",47,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",7,0,0,0,0,0,0,0,},{"Withering Plague",0,36,37,41,42,47,49,56,},{"Refined Palate (Theotar)",107,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",68,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",109,0,0,0,0,0,0,0,},{"Built for War (Draven)",107,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",2,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",64,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,54,59,60,73,76,79,92,},{"Debilitating Malady",0,-3,-2,2,-1,-5,1,-3,},{"Grove Invigoration (Niya)",77,0,0,0,0,0,0,0,},{"Withering Plague",0,28,29,37,39,47,44,47,},{"Niya's Tools: Herbs (Niya)",15,0,0,0,0,0,0,0,},{"First Strike (Korayn)",28,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",257,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",90,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",77,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",56,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,17,23,20,19,26,23,23,},{"Debilitating Malady",0,1,4,-2,6,11,1,0,},{"Lead by Example (0 Allies) (Emeni)",35,0,0,0,0,0,0,0,},{"Withering Plague",0,41,40,48,50,54,56,55,},{"Plaguey's Preemptive Strike (Marileth)",11,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",5,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",78,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",90,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",66,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",87,0,0,0,0,0,0,0,},},},
		[254] ={{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,20,31,36,59,66,72,73,},{"Brutal Projectiles",0,1,4,3,6,-1,3,-5,},{"Enfeebled Mark",0,122,122,140,149,170,180,180,},{"Sharpshooter's Focus",0,51,64,66,73,82,78,92,},{"Deadly Chain",0,-7,-1,-3,-2,-2,-1,0,},{"Combat Meditation (50% Extend) (Pelagos)",195,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",15,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",236,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",157,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",77,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",48,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",234,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",136,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,30,40,46,54,62,75,77,},{"Brutal Projectiles",0,6,9,-1,6,6,9,10,},{"Empowered Release",0,72,70,63,71,74,77,76,},{"Deadly Chain",0,-1,3,-6,4,1,-4,11,},{"Sharpshooter's Focus",0,46,44,55,63,70,69,77,},{"Built for War (Draven)",156,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",159,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",89,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",70,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",128,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-19,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",23,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",44,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,29,36,43,47,66,72,70,},{"Spirit Attunement",0,133,133,134,147,155,155,171,},{"Sharpshooter's Focus",0,51,60,62,80,70,89,76,},{"Wild Hunt Tactics (Korayn)",209,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",194,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",185,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,-1,3,-1,-3,2,4,10,},{"Niya's Tools: Burrs (Niya)",259,0,0,0,0,0,0,0,},{"First Strike (Korayn)",25,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-2,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",62,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",301,0,0,0,0,0,0,0,},{"Deadly Chain",0,-14,-5,0,0,3,-4,-13,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,32,48,55,55,71,85,90,},{"Necrotic Barrage",0,28,37,49,54,50,54,62,},{"Brutal Projectiles",0,11,17,21,15,2,9,12,},{"Deadly Chain",0,6,4,8,5,-5,-5,3,},{"Lead by Example (2 Allies) (Emeni)",95,0,0,0,0,0,0,0,},{"Sharpshooter's Focus",0,56,58,68,75,70,74,88,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",145,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",128,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",12,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",46,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",49,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",132,0,0,0,0,0,0,0,},},},
		[260] ={{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,219,234,264,295,301,327,354,},{"Hammer of Genesis (Mikanikos)",12,0,0,0,0,0,0,0,},{"Reverberation",0,67,63,64,73,82,88,102,},{"Triple Threat",0,49,48,59,66,79,72,76,},{"Sleight of Hand",0,70,70,74,78,73,91,93,},{"Combat Meditation (Always Extend) (Pelagos)",128,0,0,0,0,0,0,0,},{"Ambidexterity",0,-5,-9,-4,7,1,-7,-7,},{"Combat Meditation (50% Extend) (Pelagos)",99,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",133,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",147,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",230,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",66,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",53,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,192,231,253,289,288,316,334,},{"Triple Threat",0,44,58,55,59,66,76,81,},{"Lashing Scars",0,63,59,80,78,73,85,87,},{"Thrill Seeker (Nadjia)",99,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",51,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",156,0,0,0,0,0,0,0,},{"Sleight of Hand",0,68,61,75,87,78,87,88,},{"Built for War (Draven)",166,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",171,0,0,0,0,0,0,0,},{"Ambidexterity",0,3,-3,-3,0,-5,-7,-6,},{"Refined Palate (Theotar)",130,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",68,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",105,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,208,225,243,268,285,315,332,},{"Septic Shock",0,27,42,50,54,69,59,70,},{"Triple Threat",0,36,55,49,43,65,60,86,},{"Field of Blossoms (Dreamweaver)",108,0,0,0,0,0,0,0,},{"Sleight of Hand",0,45,61,71,84,83,87,86,},{"Niya's Tools: Burrs (Niya)",325,0,0,0,0,0,0,0,},{"First Strike (Korayn)",10,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",170,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",287,0,0,0,0,0,0,0,},{"Ambidexterity",0,-13,-7,2,-5,1,-10,-6,},{"Social Butterfly (Dreamweaver)",71,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",151,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",167,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,194,225,246,276,298,320,345,},{"Triple Threat",0,52,64,65,64,70,82,89,},{"Sudden Fractures",0,37,43,42,51,53,73,75,},{"Lead by Example (4 Allies) (Emeni)",103,0,0,0,0,0,0,0,},{"Sleight of Hand",0,67,54,75,73,84,114,105,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",150,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",138,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",9,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",35,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",74,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",44,0,0,0,0,0,0,0,},{"Ambidexterity",0,-4,2,4,-7,-1,5,10,},},},
		[71] ={{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,97,95,105,118,125,134,142,},{"Ashen Juggernaut",0,155,183,200,211,227,250,257,},{"Piercing Verdict",0,23,33,36,40,42,36,46,},{"Crash the Ramparts",0,56,61,67,65,83,78,99,},{"Merciless Bonegrinder",0,2,-9,2,-5,-2,0,-6,},{"Hammer of Genesis (Mikanikos)",15,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",151,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",123,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",235,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",74,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",50,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",93,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",134,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,64,57,73,82,89,83,94,},{"Crash the Ramparts",0,32,47,55,52,54,49,55,},{"Ashen Juggernaut",0,177,202,218,231,258,282,285,},{"Dauntless Duelist (Nadjia)",177,0,0,0,0,0,0,0,},{"Built for War (Draven)",179,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",75,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",76,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",111,0,0,0,0,0,0,0,},{"Harrowing Punishment",0,31,29,43,39,46,43,44,},{"Merciless Bonegrinder",0,-11,-12,8,-18,-8,-12,-21,},{"Superior Tactics (Draven)",198,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",31,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,21,23,30,31,41,43,52,},{"Crash the Ramparts",0,58,60,65,77,84,79,88,},{"Ashen Juggernaut",0,168,178,194,212,224,248,267,},{"Merciless Bonegrinder",0,3,0,2,-1,7,1,5,},{"Social Butterfly (Dreamweaver)",91,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",199,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",126,0,0,0,0,0,0,0,},{"Mortal Combo",0,93,98,106,118,125,133,156,},{"Niya's Tools: Burrs (Niya)",226,0,0,0,0,0,0,0,},{"First Strike (Korayn)",45,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",8,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",147,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",190,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,99,96,104,123,133,134,147,},{"Ashen Juggernaut",0,177,208,219,238,251,270,287,},{"Veteran's Repute",0,95,93,105,111,120,136,136,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",127,0,0,0,0,0,0,0,},{"Crash the Ramparts",0,52,60,64,79,81,86,84,},{"Gnashing Chompers (Emeni)",-7,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",31,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",-6,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",-6,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",-3,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",124,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,1,-9,-5,-2,-2,0,-7,},},},
		[73] ={{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,-6,-1,-6,-1,-3,-7,1,},{"Piercing Verdict",0,25,25,26,32,30,37,34,},{"Pointed Courage (5 Allies) (Kleia)",161,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",99,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",30,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",92,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",132,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",186,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,27,31,27,38,39,40,43,},{"Combat Meditation (Always Extend) (Pelagos)",220,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",11,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,1,-7,3,-5,-1,1,9,},{"Harrowing Punishment",0,12,12,20,11,18,20,16,},{"Wasteland Propriety (Theotar)",-1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",12,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,39,41,49,56,58,61,58,},{"Soothing Shade (Theotar)",160,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",111,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",71,0,0,0,0,0,0,0,},{"Built for War (Draven)",124,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-2,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",121,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,39,39,51,40,50,53,60,},{"Show of Force",0,2,1,8,3,6,11,9,},{"Social Butterfly (Dreamweaver)",72,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",3,0,0,0,0,0,0,0,},{"First Strike (Korayn)",46,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",200,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,30,37,36,39,34,48,47,},{"Field of Blossoms (Dreamweaver)",90,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",5,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",124,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",260,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,-12,-11,-2,-8,-12,-9,-11,},{"Veteran's Repute",0,44,53,49,63,73,77,75,},{"Lead by Example (0 Allies) (Emeni)",-10,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",-10,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",-4,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",11,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,13,26,33,34,37,45,42,},{"Forgeborne Reveries (Heirmir)",80,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",74,0,0,0,0,0,0,0,},},},
		[268] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,40,45,41,51,47,46,46,},{"Walk with the Ox",0,191,208,220,208,228,231,244,},{"Scalding Brew",0,16,35,28,32,35,35,30,},{"Hammer of Genesis (Mikanikos)",29,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",145,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",28,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",86,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",90,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",67,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",42,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",145,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,32,35,40,47,52,45,55,},{"Walk with the Ox",0,185,197,197,206,215,225,228,},{"Scalding Brew",0,18,16,22,22,25,31,32,},{"Built for War (Draven)",98,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",32,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",95,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",34,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",21,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",120,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",49,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",40,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,13,11,18,18,25,23,27,},{"Walk with the Ox",0,176,181,189,190,195,209,212,},{"Scalding Brew",0,17,23,28,28,38,33,32,},{"Wild Hunt Tactics (Korayn)",101,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",50,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",108,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",98,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",150,0,0,0,0,0,0,0,},{"First Strike (Korayn)",46,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",240,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",64,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,5,12,11,12,9,9,12,},{"Walk with the Ox",0,215,220,231,226,246,248,260,},{"Scalding Brew",0,24,31,24,27,37,34,37,},{"Lead by Example (0 Allies) (Emeni)",37,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",74,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",96,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",19,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",7,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",70,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",90,0,0,0,0,0,0,0,},},},
		[261] ={{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,61,82,78,88,107,121,126,},{"Reverberation",0,74,87,94,103,105,123,124,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",140,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",108,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",73,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",92,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,88,87,123,138,130,134,127,},{"Pointed Courage (1 Ally) (Kleia)",48,0,0,0,0,0,0,0,},{"Deeper Daggers",0,72,81,79,90,79,112,113,},{"Pointed Courage (3 Allies) (Kleia)",146,0,0,0,0,0,0,0,},{"Planned Execution",0,85,99,98,117,116,123,134,},{"Pointed Courage (5 Allies) (Kleia)",245,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,69,85,85,97,107,109,120,},{"Lashing Scars",0,64,78,68,86,92,92,111,},{"Thrill Seeker (Nadjia)",88,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,67,94,124,121,131,111,112,},{"Built for War (Draven)",178,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",188,0,0,0,0,0,0,0,},{"Deeper Daggers",0,64,77,93,104,103,107,109,},{"Refined Palate (Theotar)",98,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",86,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",94,0,0,0,0,0,0,0,},{"Planned Execution",0,82,86,110,110,117,125,128,},{"Exacting Preparation (Nadjia)",59,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",232,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,73,77,83,94,90,98,110,},{"Septic Shock",0,41,48,70,78,96,101,116,},{"Stiletto Staccato",0,57,60,100,124,124,104,112,},{"Planned Execution",0,89,105,108,109,133,144,143,},{"Field of Blossoms (Dreamweaver)",102,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",193,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",219,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",242,0,0,0,0,0,0,0,},{"First Strike (Korayn)",26,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",169,0,0,0,0,0,0,0,},{"Deeper Daggers",0,68,84,80,84,86,90,110,},{"Social Butterfly (Dreamweaver)",79,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",137,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,69,68,95,91,102,100,102,},{"Sudden Fractures",0,41,44,50,50,57,66,59,},{"Deeper Daggers",0,60,71,65,87,97,96,90,},{"Stiletto Staccato",0,66,68,103,127,129,100,85,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",134,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-15,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",34,0,0,0,0,0,0,0,},{"Planned Execution",0,77,93,106,97,107,112,128,},{"Lead by Example (2 Allies) (Emeni)",84,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",52,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",117,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",135,0,0,0,0,0,0,0,},},},
		[269] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,94,101,101,107,105,111,116,},{"Inner Fury",0,38,39,40,39,39,50,45,},{"Calculated Strikes",0,-9,3,-8,2,-2,-1,8,},{"Combat Meditation (Never Extend) (Pelagos)",137,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,161,171,202,215,233,247,268,},{"Xuen's Bond",0,35,29,36,48,41,61,63,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",168,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",121,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",33,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",124,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",209,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",215,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,43,49,60,67,64,78,82,},{"Calculated Strikes",0,-13,-15,-15,-13,-3,0,1,},{"Inner Fury",0,33,41,43,43,58,38,64,},{"Dauntless Duelist (Nadjia)",106,0,0,0,0,0,0,0,},{"Built for War (Draven)",140,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,135,148,154,166,187,206,229,},{"Xuen's Bond",0,49,49,61,61,71,68,71,},{"Thrill Seeker (Nadjia)",73,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",68,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",96,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",76,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",19,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",156,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,19,20,22,19,16,31,26,},{"Grove Invigoration (Niya)",261,0,0,0,0,0,0,0,},{"Calculated Strikes",0,-3,3,10,-1,0,5,2,},{"Inner Fury",0,40,53,65,71,71,69,51,},{"Coordinated Offensive",0,144,167,178,182,202,229,236,},{"Xuen's Bond",0,66,71,74,73,76,85,95,},{"Wild Hunt Tactics (Korayn)",111,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",217,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",141,0,0,0,0,0,0,0,},{"First Strike (Korayn)",41,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",250,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",86,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",54,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,-1,-3,-6,-3,-6,0,-16,},{"Calculated Strikes",0,-1,-1,3,-5,-2,-8,-7,},{"Inner Fury",0,35,47,49,55,56,59,62,},{"Coordinated Offensive",0,150,175,184,200,229,238,240,},{"Gnashing Chompers (Emeni)",8,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",49,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",108,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",128,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",20,0,0,0,0,0,0,0,},{"Xuen's Bond",0,40,45,51,51,53,63,73,},{"Lead by Example (4 Allies) (Emeni)",148,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",105,0,0,0,0,0,0,0,},},},
		[251] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,79,69,85,84,82,96,91,},{"Accelerated Cold",0,106,104,111,123,129,141,139,},{"Pointed Courage (3 Allies) (Kleia)",183,0,0,0,0,0,0,0,},{"Eradicating Blow",0,28,30,29,40,32,36,42,},{"Combat Meditation (Always Extend) (Pelagos)",239,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",179,0,0,0,0,0,0,0,},{"Everfrost",0,124,148,148,168,174,193,202,},{"Bron's Call to Action (Mikanikos)",65,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",62,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",272,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",104,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,19,34,48,47,57,67,74,},{"Hammer of Genesis (Mikanikos)",16,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,12,26,14,25,10,20,24,},{"Accelerated Cold",0,70,87,94,105,105,112,106,},{"Thrill Seeker (Nadjia)",79,0,0,0,0,0,0,0,},{"Eradicating Blow",0,19,29,32,24,35,26,43,},{"Everfrost",0,129,127,130,151,160,174,197,},{"Refined Palate (Theotar)",68,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,29,22,41,41,44,67,70,},{"Soothing Shade (Theotar)",133,0,0,0,0,0,0,0,},{"Built for War (Draven)",180,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",-10,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",100,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",169,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,22,23,30,31,23,29,52,},{"Eradicating Blow",0,30,16,37,30,34,33,42,},{"Accelerated Cold",0,102,103,111,121,116,139,161,},{"Wild Hunt Tactics (Korayn)",190,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",50,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-5,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",247,0,0,0,0,0,0,0,},{"First Strike (Korayn)",17,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-1,0,0,0,0,0,0,0,},{"Everfrost",0,127,135,152,169,168,176,197,},{"Grove Invigoration (Niya)",121,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",81,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,34,38,39,48,50,67,73,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,10,16,15,23,24,31,28,},{"Eradicating Blow",0,14,27,22,37,44,41,34,},{"Accelerated Cold",0,100,102,104,134,130,129,148,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",171,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,17,22,38,29,43,53,60,},{"Plaguey's Preemptive Strike (Marileth)",20,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",204,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",143,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",135,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",74,0,0,0,0,0,0,0,},{"Everfrost",0,125,133,141,157,162,185,198,},{"Gnashing Chompers (Emeni)",-8,0,0,0,0,0,0,0,},},},
		[66] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,68,70,78,88,97,94,105,},{"Punish the Guilty",0,77,78,88,101,104,113,118,},{"Pointed Courage (5 Allies) (Kleia)",182,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",103,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",173,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",70,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",96,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",31,0,0,0,0,0,0,0,},{"Vengeful Shock",0,55,63,67,80,77,79,89,},{"Combat Meditation (Always Extend) (Pelagos)",120,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",11,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,116,133,138,150,161,181,189,},{"Punish the Guilty",0,65,83,93,96,102,116,118,},{"Wasteland Propriety (Theotar)",96,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",17,0,0,0,0,0,0,0,},{"Vengeful Shock",0,54,65,59,71,71,73,76,},{"Refined Palate (Theotar)",97,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",86,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",142,0,0,0,0,0,0,0,},{"Built for War (Draven)",137,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",88,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",2,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,16,17,6,22,17,23,17,},{"Punish the Guilty",0,81,78,83,96,101,111,117,},{"Grove Invigoration (Niya)",129,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",57,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",2,0,0,0,0,0,0,0,},{"First Strike (Korayn)",42,0,0,0,0,0,0,0,},{"Vengeful Shock",0,48,51,58,64,73,66,72,},{"Niya's Tools: Burrs (Niya)",262,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",115,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-5,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",158,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,28,24,34,34,36,47,42,},{"Punish the Guilty",0,75,79,72,85,101,111,112,},{"Lead by Example (0 Allies) (Emeni)",18,0,0,0,0,0,0,0,},{"Vengeful Shock",0,38,46,46,56,47,64,69,},{"Lead by Example (2 Allies) (Emeni)",37,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",65,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-6,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",93,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",102,0,0,0,0,0,0,0,},},},
	},
}

CovenantForge.BaseValues ={
	["PreRaid"]={
		[255] ={3500,3468,3538,3483,},
		[262] ={4048,4053,4123,4166,},
		[62] ={4054,4035,4067,3976,},
		[263] ={4098,4130,4206,4147,},
		[64] ={3450,3622,3385,3430,},
		[252] ={4380,4451,4345,4474,},
		[578] ={2169,2184,2241,2117,},
		[70] ={3487,3756,3553,3502,},
		[72] ={3322,3535,3338,3270,},
		[577] ={3402,3527,3497,3488,},
		[104] ={2233,2230,2397,2418,},
		[265] ={3838,3491,3814,3695,},
		[103] ={3551,3485,3729,3493,},
		[253] ={3685,3623,3785,3685,},
		[258] ={4135,4118,4025,4142,},
		[266] ={3468,3443,3490,3548,},
		[102] ={4090,4019,4194,4016,},
		[63] ={3631,3670,3626,3575,},
		[259] ={3534,3538,3518,3481,},
		[267] ={3511,3481,3541,3621,},
		[250] ={2128,2104,2017,2111,},
		[254] ={3833,3713,3926,3841,},
		[260] ={4073,4032,3990,3975,},
		[71] ={3307,3758,3350,3292,},
		[73] ={2308,2385,2333,2242,},
		[268] ={2860,2738,2709,2740,},
		[261] ={4322,4236,4241,4213,},
		[269] ={3929,3659,3718,3714,},
		[251] ={3902,3925,3863,3890,},
		[66] ={2761,3110,2927,2852,},
	},
	["T26"]={
		[255] ={5194,5148,5247,5169,},
		[262] ={5981,5996,6084,6165,},
		[62] ={5981,5935,6082,5884,},
		[263] ={5776,5826,5941,5868,},
		[64] ={5574,5809,5476,5572,},
		[252] ={6162,6219,6092,6241,},
		[578] ={3322,3347,3433,3243,},
		[70] ={5265,5647,5393,5275,},
		[72] ={5663,6075,5705,5603,},
		[577] ={5401,5643,5534,5571,},
		[104] ={3452,3443,3650,3702,},
		[265] ={5766,5383,5711,5550,},
		[103] ={5834,5751,6198,5738,},
		[253] ={5463,5383,5584,5444,},
		[258] ={6697,6603,6553,6673,},
		[266] ={5152,5131,5199,5275,},
		[102] ={5985,5967,6117,6050,},
		[63] ={5474,5478,5515,5344,},
		[259] ={5883,5895,5853,5797,},
		[267] ={5426,5409,5527,5633,},
		[250] ={3538,3483,3472,3498,},
		[254] ={5585,5450,5715,5575,},
		[260] ={6174,6058,6002,5968,},
		[71] ={5291,5960,5345,5297,},
		[73] ={3751,3902,3771,3655,},
		[268] ={3950,3800,3780,3816,},
		[261] ={6364,6238,6225,6191,},
		[269] ={6074,5660,5732,5725,},
		[251] ={5835,5827,5812,5820,},
		[66] ={4365,4874,4591,4483,},
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
					local spellID = data[2]
					local name = GetSpellInfo(spellID) or data[1]
					local type = Soulbinds.GetConduitName(data[3])
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
					label:SetFont(GameFontNormal:GetFont(), 12)
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
				label:SetFont(GameFontNormal:GetFont(), 12)
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
			local spellID = data[2]
			local name = GetSpellInfo(spellID) or data[1]
			local type = Soulbinds.GetConduitName(data[3])
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