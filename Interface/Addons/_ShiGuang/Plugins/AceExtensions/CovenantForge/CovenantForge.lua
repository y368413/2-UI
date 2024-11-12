﻿--	///////////////////////////////////////////////////////////////////////////////////////////	 
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
	[157]={ "Marksman's Advantage", 339264, 2, {253,254,255,},},
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
	[203]={ "Withering Bolt", 339576, 1, {265,},},
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
	[283]={ "Condensed Anima Sphere", 357888, 2, {62,63,64,65,66,70,71,72,73,102,103,104,105,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,577,581,},},
	[284]={ "Adaptive Armor Fragment", 357902, 1, {66,73,104,581,268,250,},},
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
		[255] ={{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,0,2,2,-6,10,7,5,},{"Enfeebled Mark",0,93,105,108,117,127,136,150,},{"Strength of the Pack",0,73,67,83,98,118,115,127,},{"Stinging Strike",0,60,63,68,72,80,90,97,},{"Combat Meditation (50% Extend) (Pelagos)",93,0,0,0,0,0,0,0,},{"Deadly Tandem",0,41,35,41,53,67,64,66,},{"Hammer of Genesis (Mikanikos)",8,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",112,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",67,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",85,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",32,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",126,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",211,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,2,7,2,9,7,-1,12,},{"Strength of the Pack",0,69,66,86,96,104,105,125,},{"Stinging Strike",0,57,63,63,83,83,78,81,},{"Deadly Tandem",0,55,37,42,50,55,55,54,},{"Empowered Release",0,120,121,145,144,142,142,150,},{"Built for War (Draven)",168,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",170,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",127,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",81,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",86,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",155,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",81,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",51,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-1,2,-7,11,-2,1,-2,},{"Spirit Attunement",0,93,102,102,98,108,120,120,},{"Deadly Tandem",0,35,44,44,53,51,51,63,},{"Stinging Strike",0,63,64,61,82,71,88,84,},{"Strength of the Pack",0,67,84,93,101,98,128,135,},{"Wild Hunt Tactics (Korayn)",166,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",218,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",180,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",252,0,0,0,0,0,0,0,},{"First Strike (Korayn)",23,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",0,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",79,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",127,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-6,-5,-9,-5,-4,1,-1,},{"Strength of the Pack",0,51,72,73,87,98,113,124,},{"Necrotic Barrage",0,14,20,18,26,16,19,32,},{"Lead by Example (2 Allies) (Emeni)",85,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",33,0,0,0,0,0,0,0,},{"Stinging Strike",0,45,55,55,67,84,88,75,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",118,0,0,0,0,0,0,0,},{"Deadly Tandem",0,39,32,39,51,52,62,54,},{"Forgeborne Reveries (Heirmir)",130,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-7,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",26,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",116,0,0,0,0,0,0,0,},},},
		[262] ={{{"Power",1,145,158,171,184,200,213,226,},{"Elysian Dirge",0,64,53,71,71,67,81,79,},{"Pyroclastic Shock",0,48,45,54,55,86,72,80,},{"Shake the Foundations",0,7,16,12,3,4,2,3,},{"Hammer of Genesis (Mikanikos)",24,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",121,0,0,0,0,0,0,0,},{"Call of Flame",0,92,92,86,83,106,102,107,},{"Combat Meditation (50% Extend) (Pelagos)",86,0,0,0,0,0,0,0,},{"High Voltage",0,29,23,21,18,30,35,31,},{"Combat Meditation (Never Extend) (Pelagos)",64,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",64,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",58,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",154,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",244,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,6,11,3,-1,10,6,11,},{"High Voltage",0,16,16,23,21,22,15,24,},{"Shake the Foundations",0,9,0,-1,-2,2,2,5,},{"Pyroclastic Shock",0,42,39,47,55,65,64,64,},{"Call of Flame",0,73,90,84,90,88,96,102,},{"Built for War (Draven)",209,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",175,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",88,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",93,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",62,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",139,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",87,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",91,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,57,52,61,62,73,64,59,},{"Pyroclastic Shock",0,46,55,62,57,72,75,72,},{"High Voltage",0,3,19,18,21,20,18,23,},{"Social Butterfly (Dreamweaver)",72,0,0,0,0,0,0,0,},{"Shake the Foundations",0,8,-5,-7,5,-6,2,1,},{"Field of Blossoms (Dreamweaver)",140,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",246,0,0,0,0,0,0,0,},{"First Strike (Korayn)",19,0,0,0,0,0,0,0,},{"Call of Flame",0,75,87,81,80,92,96,85,},{"Grove Invigoration (Niya)",140,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",2,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",192,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",186,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,28,35,35,38,60,52,48,},{"High Voltage",0,12,18,31,18,23,21,33,},{"Shake the Foundations",0,-1,-6,-10,9,3,-3,9,},{"Pyroclastic Shock",0,50,41,40,43,53,44,53,},{"Lead by Example (4 Allies) (Emeni)",148,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",123,0,0,0,0,0,0,0,},{"Call of Flame",0,98,98,102,99,97,103,116,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",40,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",109,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",61,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",173,0,0,0,0,0,0,0,},},},
		[62] ={{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,4,15,8,1,-5,1,6,},{"Combat Meditation (Never Extend) (Pelagos)",159,0,0,0,0,0,0,0,},{"Nether Precision",0,32,34,40,48,26,43,44,},{"Arcane Prodigy",0,-206,-228,-219,-230,-216,-232,-205,},{"Pointed Courage (3 Allies) (Kleia)",175,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",3,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",237,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",64,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",61,0,0,0,0,0,0,0,},{"Magi's Brand",0,123,131,151,159,166,176,185,},{"Pointed Courage (5 Allies) (Kleia)",265,0,0,0,0,0,0,0,},{"Ire of the Ascended",0,269,300,323,356,379,404,429,},{"Combat Meditation (50% Extend) (Pelagos)",200,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,16,8,9,11,10,11,7,},{"Nether Precision",0,57,41,65,68,78,81,74,},{"Arcane Prodigy",0,273,273,266,255,295,292,305,},{"Magi's Brand",0,81,94,105,102,126,121,146,},{"Built for War (Draven)",229,0,0,0,0,0,0,0,},{"Siphoned Malice",0,78,90,109,105,118,124,129,},{"Soothing Shade (Theotar)",115,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",58,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",69,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",97,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",179,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",93,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",72,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,10,25,20,23,17,22,21,},{"Arcane Prodigy",0,121,122,132,124,146,146,152,},{"Field of Blossoms (Dreamweaver)",63,0,0,0,0,0,0,0,},{"Discipline of the Grove",0,67,68,69,63,57,83,94,},{"Wild Hunt Tactics (Korayn)",204,0,0,0,0,0,0,0,},{"Nether Precision",0,56,61,62,76,69,80,81,},{"Niya's Tools: Poison (Niya)",154,0,0,0,0,0,0,0,},{"Magi's Brand",0,86,124,120,126,135,145,155,},{"Niya's Tools: Burrs (Niya)",238,0,0,0,0,0,0,0,},{"First Strike (Korayn)",23,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",4,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",120,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",79,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,6,10,14,20,17,17,18,},{"Nether Precision",0,48,56,54,74,66,84,89,},{"Arcane Prodigy",0,32,28,33,27,93,97,85,},{"Gift of the Lich",0,45,54,43,65,59,55,62,},{"Magi's Brand",0,93,92,118,126,138,138,137,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",126,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",174,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",190,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",275,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",112,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",22,0,0,0,0,0,0,0,},},},
		[263] ={{{"Power",1,145,158,171,184,200,213,226,},{"Elysian Dirge",0,49,45,56,62,53,72,64,},{"Unruly Winds",0,44,47,48,37,48,42,55,},{"Combat Meditation (50% Extend) (Pelagos)",160,0,0,0,0,0,0,0,},{"Magma Fist",0,172,190,178,188,212,211,208,},{"Chilled to the Core",0,29,24,28,17,26,33,29,},{"Hammer of Genesis (Mikanikos)",16,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",215,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",113,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",164,0,0,0,0,0,0,0,},{"Focused Lightning",0,33,48,46,43,57,77,74,},{"Pointed Courage (1 Ally) (Kleia)",58,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",168,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",294,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,11,13,16,20,15,34,27,},{"Unruly Winds",0,44,42,50,47,48,53,64,},{"Thrill Seeker (Nadjia)",126,0,0,0,0,0,0,0,},{"Chilled to the Core",0,23,27,36,50,33,32,30,},{"Magma Fist",0,178,189,191,187,204,225,232,},{"Refined Palate (Theotar)",98,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",132,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",177,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",177,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",114,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",69,0,0,0,0,0,0,0,},{"Focused Lightning",0,26,51,39,52,48,72,93,},{"Built for War (Draven)",201,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,29,34,32,36,35,49,41,},{"Magma Fist",0,168,166,178,182,186,204,202,},{"Unruly Winds",0,36,42,35,35,38,41,42,},{"Chilled to the Core",0,3,31,14,26,29,19,20,},{"Wild Hunt Tactics (Korayn)",194,0,0,0,0,0,0,0,},{"Focused Lightning",0,34,44,44,41,63,64,65,},{"Niya's Tools: Poison (Niya)",173,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",140,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",220,0,0,0,0,0,0,0,},{"First Strike (Korayn)",50,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-11,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",97,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",288,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,30,27,36,41,27,43,46,},{"Focused Lightning",0,28,31,44,51,61,68,83,},{"Plaguey's Preemptive Strike (Marileth)",27,0,0,0,0,0,0,0,},{"Magma Fist",0,171,179,179,194,190,214,217,},{"Unruly Winds",0,31,33,42,53,56,47,66,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",160,0,0,0,0,0,0,0,},{"Chilled to the Core",0,30,30,20,23,37,18,42,},{"Forgeborne Reveries (Heirmir)",148,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",124,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",81,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",57,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",8,0,0,0,0,0,0,0,},},},
		[64] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ire of the Ascended",0,89,98,107,114,126,138,146,},{"Unrelenting Cold",0,35,42,44,48,45,62,67,},{"Shivering Core",0,7,4,-4,0,5,0,-6,},{"Ice Bite",0,103,114,117,135,144,152,165,},{"Combat Meditation (Always Extend) (Pelagos)",109,0,0,0,0,0,0,0,},{"Icy Propulsion",0,328,382,442,521,597,687,770,},{"Combat Meditation (Never Extend) (Pelagos)",54,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",25,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",96,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",143,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",90,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",86,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",12,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Siphoned Malice",0,82,76,94,102,103,123,135,},{"Unrelenting Cold",0,43,49,46,63,59,77,77,},{"Shivering Core",0,9,14,-2,6,13,14,12,},{"Ice Bite",0,125,137,148,150,174,184,184,},{"Built for War (Draven)",215,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",189,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",100,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",147,0,0,0,0,0,0,0,},{"Icy Propulsion",0,384,456,563,624,702,782,867,},{"Soothing Shade (Theotar)",121,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",64,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",97,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",89,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Discipline of the Grove",0,-16,-10,-9,-7,-5,-4,1,},{"Unrelenting Cold",0,40,30,41,34,54,52,55,},{"Shivering Core",0,-16,-13,-3,2,-6,-5,3,},{"Ice Bite",0,105,100,117,119,134,149,167,},{"Wild Hunt Tactics (Korayn)",192,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",142,0,0,0,0,0,0,0,},{"Icy Propulsion",0,342,396,472,568,645,729,823,},{"Field of Blossoms (Dreamweaver)",18,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-18,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",73,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",262,0,0,0,0,0,0,0,},{"First Strike (Korayn)",17,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",75,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Gift of the Lich",0,47,42,46,55,56,59,60,},{"Shivering Core",0,2,-3,-1,-9,0,-9,-9,},{"Unrelenting Cold",0,33,49,35,51,53,45,57,},{"Forgeborne Reveries (Heirmir)",153,0,0,0,0,0,0,0,},{"Ice Bite",0,91,111,116,134,144,152,162,},{"Icy Propulsion",0,306,358,445,531,608,689,784,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",42,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-4,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",231,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",158,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",89,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",46,0,0,0,0,0,0,0,},},},
		[252] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,62,70,67,75,82,69,81,},{"Embrace Death",0,47,51,66,63,77,79,84,},{"Eternal Hunger",0,171,187,191,201,196,211,222,},{"Convocation of the Dead",0,61,85,70,100,113,126,135,},{"Pointed Courage (3 Allies) (Kleia)",171,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",26,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",207,0,0,0,0,0,0,0,},{"Lingering Plague",0,26,25,35,43,31,39,42,},{"Combat Meditation (Never Extend) (Pelagos)",123,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",106,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",66,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",269,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",168,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,24,24,16,24,31,42,21,},{"Embrace Death",0,42,66,60,74,74,87,79,},{"Eternal Hunger",0,182,170,200,203,207,220,231,},{"Soothing Shade (Theotar)",123,0,0,0,0,0,0,0,},{"Convocation of the Dead",0,65,78,81,96,99,129,134,},{"Dauntless Duelist (Nadjia)",145,0,0,0,0,0,0,0,},{"Lingering Plague",0,37,33,24,33,48,47,36,},{"Thrill Seeker (Nadjia)",104,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",72,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",195,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",164,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",83,0,0,0,0,0,0,0,},{"Built for War (Draven)",202,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,24,39,45,38,30,45,50,},{"Eternal Hunger",0,173,172,192,192,206,214,224,},{"Embrace Death",0,55,65,76,79,86,94,87,},{"Field of Blossoms (Dreamweaver)",74,0,0,0,0,0,0,0,},{"Convocation of the Dead",0,50,55,61,63,73,90,101,},{"Wild Hunt Tactics (Korayn)",222,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",204,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",232,0,0,0,0,0,0,0,},{"First Strike (Korayn)",29,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-12,0,0,0,0,0,0,0,},{"Lingering Plague",0,29,39,49,43,42,36,61,},{"Grove Invigoration (Niya)",114,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",97,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,16,13,16,20,17,31,28,},{"Embrace Death",0,52,44,55,66,77,77,84,},{"Eternal Hunger",0,168,174,178,196,198,213,212,},{"Convocation of the Dead",0,54,67,78,91,97,114,116,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",172,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-3,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",33,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",188,0,0,0,0,0,0,0,},{"Lingering Plague",0,30,14,32,29,24,40,36,},{"Lead by Example (2 Allies) (Emeni)",129,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",52,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",141,0,0,0,0,0,0,0,},},},
		[578] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,29,34,40,46,46,48,52,},{"Soul Furnace",0,26,30,32,37,36,36,43,},{"Pointed Courage (5 Allies) (Kleia)",141,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",81,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",32,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",61,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",73,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",98,0,0,0,0,0,0,0,},{"Growing Inferno",0,35,34,43,41,52,56,52,},{"Combat Meditation (Always Extend) (Pelagos)",121,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",7,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,17,31,31,37,38,41,34,},{"Soul Furnace",0,25,29,27,30,32,35,40,},{"Exacting Preparation (Nadjia)",42,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",32,0,0,0,0,0,0,0,},{"Growing Inferno",0,37,29,42,45,48,51,50,},{"Soothing Shade (Theotar)",61,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",50,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",96,0,0,0,0,0,0,0,},{"Built for War (Draven)",82,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",50,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",99,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,49,50,55,56,68,68,69,},{"Soul Furnace",0,26,28,32,30,34,41,46,},{"Grove Invigoration (Niya)",120,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",51,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",122,0,0,0,0,0,0,0,},{"First Strike (Korayn)",53,0,0,0,0,0,0,0,},{"Growing Inferno",0,36,39,38,45,55,56,60,},{"Niya's Tools: Burrs (Niya)",232,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",76,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",69,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",105,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,5,14,21,27,31,38,47,},{"Soul Furnace",0,32,26,29,40,40,44,47,},{"Lead by Example (0 Allies) (Emeni)",49,0,0,0,0,0,0,0,},{"Growing Inferno",0,40,44,50,49,55,58,61,},{"Lead by Example (2 Allies) (Emeni)",79,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",120,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",77,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",73,0,0,0,0,0,0,0,},},},
		[70] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,311,342,371,385,424,463,505,},{"Expurgation",0,148,162,176,201,207,213,243,},{"Truth's Wake",0,41,33,41,40,51,47,62,},{"Virtuous Command",0,172,187,217,232,246,256,275,},{"Pointed Courage (5 Allies) (Kleia)",221,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",10,0,0,0,0,0,0,0,},{"Templar's Vindication",0,197,217,233,260,284,299,320,},{"Combat Meditation (Always Extend) (Pelagos)",283,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",247,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",225,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",46,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",134,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",134,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,97,109,110,128,130,147,155,},{"Truth's Wake",0,32,47,44,55,56,52,47,},{"Expurgation",0,159,158,178,195,217,231,238,},{"Dauntless Duelist (Nadjia)",172,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",78,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",60,0,0,0,0,0,0,0,},{"Templar's Vindication",0,188,209,241,249,258,278,315,},{"Virtuous Command",0,155,162,179,195,212,232,241,},{"Soothing Shade (Theotar)",110,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",6,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",69,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",134,0,0,0,0,0,0,0,},{"Built for War (Draven)",167,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,69,64,64,78,79,80,91,},{"Truth's Wake",0,27,37,39,42,45,46,53,},{"Expurgation",0,171,161,186,196,229,245,260,},{"Virtuous Command",0,154,192,198,204,231,253,259,},{"Social Butterfly (Dreamweaver)",69,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",172,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",2,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",53,0,0,0,0,0,0,0,},{"Templar's Vindication",0,191,218,238,263,275,292,314,},{"Niya's Tools: Burrs (Niya)",256,0,0,0,0,0,0,0,},{"First Strike (Korayn)",9,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",123,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,23,27,18,20,31,22,41,},{"Expurgation",0,147,161,186,198,221,228,236,},{"Plaguey's Preemptive Strike (Marileth)",40,0,0,0,0,0,0,0,},{"Virtuous Command",0,154,170,183,197,214,226,241,},{"Truth's Wake",0,32,38,52,47,49,56,50,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",120,0,0,0,0,0,0,0,},{"Templar's Vindication",0,210,214,236,251,274,286,302,},{"Forgeborne Reveries (Heirmir)",139,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",59,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",39,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",19,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},},},
		[72] ={{{"Power",1,145,158,171,184,200,213,226,},{"Piercing Verdict",0,40,38,57,51,55,58,61,},{"Depths of Insanity",0,59,68,76,75,85,88,102,},{"Ashen Juggernaut",0,127,155,164,180,185,196,217,},{"Hammer of Genesis (Mikanikos)",5,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",195,0,0,0,0,0,0,0,},{"Hack and Slash",0,48,61,51,63,68,78,79,},{"Bron's Call to Action (Mikanikos)",97,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",46,0,0,0,0,0,0,0,},{"Vicious Contempt",0,44,52,52,53,63,75,77,},{"Pointed Courage (3 Allies) (Kleia)",164,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",268,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",133,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",162,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Harrowing Punishment",0,17,22,26,26,33,27,21,},{"Depths of Insanity",0,72,72,92,91,85,92,97,},{"Refined Palate (Theotar)",96,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,120,133,143,155,160,185,187,},{"Dauntless Duelist (Nadjia)",191,0,0,0,0,0,0,0,},{"Vicious Contempt",0,37,50,55,48,53,70,72,},{"Thrill Seeker (Nadjia)",125,0,0,0,0,0,0,0,},{"Hack and Slash",0,44,46,42,50,41,57,55,},{"Soothing Shade (Theotar)",144,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",224,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",113,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",76,0,0,0,0,0,0,0,},{"Built for War (Draven)",174,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,36,36,45,45,58,62,58,},{"Ashen Juggernaut",0,144,151,177,185,195,205,232,},{"Grove Invigoration (Niya)",248,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",163,0,0,0,0,0,0,0,},{"Depths of Insanity",0,67,90,95,97,97,98,102,},{"Niya's Tools: Poison (Niya)",214,0,0,0,0,0,0,0,},{"Vicious Contempt",0,59,67,72,74,72,89,80,},{"Field of Blossoms (Dreamweaver)",138,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",252,0,0,0,0,0,0,0,},{"First Strike (Korayn)",58,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",133,0,0,0,0,0,0,0,},{"Hack and Slash",0,52,61,76,73,78,85,85,},{"Social Butterfly (Dreamweaver)",90,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Veteran's Repute",0,75,84,93,106,119,117,122,},{"Depths of Insanity",0,65,62,66,75,84,72,88,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",129,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,133,145,158,162,180,190,207,},{"Forgeborne Reveries (Heirmir)",127,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-11,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",36,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",136,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",98,0,0,0,0,0,0,0,},{"Vicious Contempt",0,34,43,39,51,65,73,84,},{"Hack and Slash",0,41,50,60,52,67,70,73,},{"Lead by Example (0 Allies) (Emeni)",48,0,0,0,0,0,0,0,},},},
		[577] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,22,24,24,21,31,35,27,},{"Growing Inferno",0,92,114,126,131,133,154,159,},{"Relentless Onslaught",0,94,107,122,132,127,142,167,},{"Dancing with Fate",0,5,21,11,6,17,17,22,},{"Serrated Glaive",0,-7,-7,-7,-5,-6,-6,-1,},{"Combat Meditation (Never Extend) (Pelagos)",59,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",50,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",142,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",92,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",135,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",229,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-6,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",103,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,-27,-37,-15,-13,-13,-10,-11,},{"Growing Inferno",0,103,107,123,138,135,148,157,},{"Relentless Onslaught",0,95,110,115,130,138,143,150,},{"Wasteland Propriety (Theotar)",70,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",104,0,0,0,0,0,0,0,},{"Serrated Glaive",0,-5,-7,-9,6,-5,-13,-4,},{"Dauntless Duelist (Nadjia)",190,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",95,0,0,0,0,0,0,0,},{"Dancing with Fate",0,14,13,4,14,0,13,20,},{"Exacting Preparation (Nadjia)",113,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",145,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",88,0,0,0,0,0,0,0,},{"Built for War (Draven)",169,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,49,56,46,71,62,70,68,},{"Growing Inferno",0,100,121,121,137,141,169,165,},{"Niya's Tools: Burrs (Niya)",268,0,0,0,0,0,0,0,},{"First Strike (Korayn)",48,0,0,0,0,0,0,0,},{"Relentless Onslaught",0,109,109,113,144,145,157,164,},{"Niya's Tools: Herbs (Niya)",7,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",231,0,0,0,0,0,0,0,},{"Dancing with Fate",0,21,15,18,20,10,28,17,},{"Field of Blossoms (Dreamweaver)",154,0,0,0,0,0,0,0,},{"Serrated Glaive",0,4,-10,-6,-2,5,-8,8,},{"Social Butterfly (Dreamweaver)",89,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",186,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",148,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,21,38,56,72,90,97,110,},{"Relentless Onslaught",0,102,118,134,137,156,159,169,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Growing Inferno",0,113,114,132,150,165,162,179,},{"Dancing with Fate",0,12,14,15,16,19,18,20,},{"Lead by Example (4 Allies) (Emeni)",222,0,0,0,0,0,0,0,},{"Serrated Glaive",0,-1,-7,-6,-3,7,-8,7,},{"Forgeborne Reveries (Heirmir)",130,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",162,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",37,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",154,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",90,0,0,0,0,0,0,0,},},},
		[104] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,25,36,36,41,32,27,36,},{"Savage Combatant",0,109,122,127,136,144,153,162,},{"Pointed Courage (5 Allies) (Kleia)",148,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,72,79,81,94,93,104,108,},{"Pointed Courage (3 Allies) (Kleia)",97,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",31,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",204,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",86,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",105,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",19,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",63,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,51,47,62,65,70,78,79,},{"Savage Combatant",0,119,119,136,151,151,163,177,},{"Wasteland Propriety (Theotar)",50,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,91,98,103,107,118,129,129,},{"Soothing Shade (Theotar)",70,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",38,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",53,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",102,0,0,0,0,0,0,0,},{"Built for War (Draven)",97,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-4,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",46,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,67,77,85,89,105,104,117,},{"Savage Combatant",0,88,93,114,113,119,128,137,},{"Grove Invigoration (Niya)",142,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",50,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",59,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-2,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",107,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,66,71,71,78,82,92,87,},{"Niya's Tools: Burrs (Niya)",276,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",120,0,0,0,0,0,0,0,},{"First Strike (Korayn)",40,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,51,58,58,63,69,78,75,},{"Savage Combatant",0,105,113,121,130,139,144,149,},{"Lead by Example (4 Allies) (Emeni)",54,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",22,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,69,80,87,91,107,108,117,},{"Plaguey's Preemptive Strike (Marileth)",23,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",34,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",92,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",88,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},},},
		[265] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,-5,0,-10,-2,-3,-5,0,},{"Cold Embrace",0,143,151,173,182,204,200,224,},{"Corrupting Leer",0,28,20,38,30,43,53,47,},{"Focused Malignancy",0,205,247,258,280,306,323,344,},{"Hammer of Genesis (Mikanikos)",11,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",197,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",144,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",113,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",36,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",55,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",261,0,0,0,0,0,0,0,},{"Rolling Agony",0,11,17,1,10,2,17,25,},{"Pointed Courage (3 Allies) (Kleia)",160,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,84,78,77,82,74,89,97,},{"Corrupting Leer",0,-1,4,6,-2,4,16,10,},{"Focused Malignancy",0,202,222,247,271,283,304,318,},{"Cold Embrace",0,144,151,164,172,196,205,215,},{"Rolling Agony",0,4,14,19,26,22,13,17,},{"Thrill Seeker (Nadjia)",103,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",53,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",169,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",128,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",0,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",82,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",110,0,0,0,0,0,0,0,},{"Built for War (Draven)",200,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,74,78,87,95,104,119,101,},{"Corrupting Leer",0,0,21,17,17,23,31,31,},{"Cold Embrace",0,151,166,173,194,202,223,223,},{"Niya's Tools: Poison (Niya)",14,0,0,0,0,0,0,0,},{"Focused Malignancy",0,216,228,251,284,306,318,345,},{"Field of Blossoms (Dreamweaver)",178,0,0,0,0,0,0,0,},{"Rolling Agony",0,16,24,32,23,30,29,38,},{"Niya's Tools: Burrs (Niya)",274,0,0,0,0,0,0,0,},{"First Strike (Korayn)",25,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",16,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",106,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",265,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",191,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,63,89,91,108,89,113,124,},{"Corrupting Leer",0,31,35,37,32,37,38,53,},{"Cold Embrace",0,151,153,161,175,194,191,220,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",134,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",155,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Rolling Agony",0,15,6,1,9,19,20,30,},{"Lead by Example (4 Allies) (Emeni)",134,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",49,0,0,0,0,0,0,0,},{"Focused Malignancy",0,179,207,224,233,248,279,292,},{"Lead by Example (2 Allies) (Emeni)",92,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",48,0,0,0,0,0,0,0,},},},
		[103] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,-26,-13,-7,-7,-6,-9,-17,},{"Taste for Blood",0,117,130,124,136,146,166,182,},{"Bron's Call to Action (Mikanikos)",116,0,0,0,0,0,0,0,},{"Incessant Hunter",0,28,17,34,29,29,39,43,},{"Sudden Ambush",0,120,127,141,147,160,163,187,},{"Pointed Courage (5 Allies) (Kleia)",289,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",15,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",158,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",123,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",48,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",184,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",195,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,77,84,103,105,115,122,145,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,135,158,166,174,193,212,227,},{"Taste for Blood",0,113,133,139,148,158,181,189,},{"Incessant Hunter",0,43,45,43,41,48,55,59,},{"Dauntless Duelist (Nadjia)",196,0,0,0,0,0,0,0,},{"Built for War (Draven)",185,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",111,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",133,0,0,0,0,0,0,0,},{"Sudden Ambush",0,119,131,135,166,176,174,184,},{"Refined Palate (Theotar)",79,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",127,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,97,99,102,117,120,136,151,},{"Superior Tactics (Draven)",228,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",166,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,115,118,146,145,150,164,180,},{"Taste for Blood",0,150,150,167,189,199,207,244,},{"Incessant Hunter",0,13,20,24,32,20,47,28,},{"Sudden Ambush",0,114,131,132,141,148,165,179,},{"Carnivorous Instinct",0,101,109,113,120,129,155,150,},{"Niya's Tools: Poison (Niya)",188,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",218,0,0,0,0,0,0,0,},{"First Strike (Korayn)",6,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",3,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",280,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",208,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",138,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",96,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,81,92,108,119,129,130,135,},{"Incessant Hunter",0,13,19,13,33,15,30,32,},{"Taste for Blood",0,94,107,122,125,148,137,158,},{"Sudden Ambush",0,126,141,155,171,180,186,190,},{"Lead by Example (4 Allies) (Emeni)",75,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",136,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",177,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-6,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",19,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,53,71,73,74,94,78,98,},{"Lead by Example (0 Allies) (Emeni)",23,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",58,0,0,0,0,0,0,0,},},},
		[253] ={{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,22,22,24,30,26,41,36,},{"Ferocious Appetite",0,-37,-29,-19,-16,9,9,-4,},{"One With the Beast",0,21,27,30,53,61,86,99,},{"Enfeebled Mark",0,97,127,129,144,155,178,172,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",164,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",102,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",129,0,0,0,0,0,0,0,},{"Echoing Call",0,-12,-10,-8,-3,-6,-15,1,},{"Pointed Courage (1 Ally) (Kleia)",40,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",111,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",197,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",69,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,10,18,20,24,27,25,32,},{"Empowered Release",0,101,103,112,112,127,126,124,},{"Ferocious Appetite",0,-16,-29,-25,-13,-5,-4,3,},{"Echoing Call",0,-8,-15,-8,-6,-12,-11,-14,},{"One With the Beast",0,18,24,47,68,65,70,89,},{"Built for War (Draven)",170,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",174,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",99,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",100,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-9,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",54,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",57,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",74,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,51,52,47,55,60,58,66,},{"Ferocious Appetite",0,-65,-69,-67,-44,-43,-49,-44,},{"One With the Beast",0,20,40,48,60,73,88,110,},{"Echoing Call",0,1,4,9,6,17,7,12,},{"Spirit Attunement",0,103,114,108,118,130,134,129,},{"Wild Hunt Tactics (Korayn)",178,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",149,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",250,0,0,0,0,0,0,0,},{"First Strike (Korayn)",17,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",197,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",206,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",88,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",6,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,19,32,33,32,33,37,42,},{"Necrotic Barrage",0,25,16,28,23,31,39,33,},{"Echoing Call",0,-2,-5,3,2,0,-4,-3,},{"Lead by Example (2 Allies) (Emeni)",93,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",49,0,0,0,0,0,0,0,},{"One With the Beast",0,13,27,46,62,67,87,97,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",142,0,0,0,0,0,0,0,},{"Ferocious Appetite",0,-26,-20,-10,-5,5,2,16,},{"Gnashing Chompers (Emeni)",-4,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",36,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",131,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",131,0,0,0,0,0,0,0,},},},
		[258] ={{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,246,257,258,278,287,305,316,},{"Courageous Ascension",0,118,118,128,136,162,151,169,},{"Rabid Shadows",0,83,152,177,167,198,212,215,},{"Mind Devourer",0,135,142,149,142,155,152,160,},{"Haunting Apparitions",0,117,142,145,166,169,188,203,},{"Hammer of Genesis (Mikanikos)",16,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",243,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",179,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",54,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",71,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",178,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",299,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",225,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,281,287,303,315,323,344,336,},{"Haunting Apparitions",0,147,170,180,179,195,219,233,},{"Rabid Shadows",0,109,175,202,187,219,236,249,},{"Shattered Perceptions",0,49,54,69,57,73,78,91,},{"Exacting Preparation (Nadjia)",122,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",20,0,0,0,0,0,0,0,},{"Mind Devourer",0,152,147,164,172,157,170,185,},{"Built for War (Draven)",262,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",214,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",156,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",81,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",179,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",89,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,294,283,308,312,323,326,346,},{"Fae Fermata",0,-8,-5,-2,-16,2,-7,-15,},{"Rabid Shadows",0,90,155,175,180,192,218,220,},{"Haunting Apparitions",0,139,153,163,181,193,220,210,},{"Wild Hunt Tactics (Korayn)",208,0,0,0,0,0,0,0,},{"Mind Devourer",0,131,117,128,127,134,141,153,},{"Niya's Tools: Poison (Niya)",-8,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",174,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",235,0,0,0,0,0,0,0,},{"First Strike (Korayn)",8,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-4,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",100,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",282,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,272,292,301,315,329,336,335,},{"Festering Transfusion",0,65,89,65,71,81,78,85,},{"Mind Devourer",0,142,148,149,152,169,160,172,},{"Haunting Apparitions",0,127,146,172,162,185,188,219,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",192,0,0,0,0,0,0,0,},{"Rabid Shadows",0,107,167,193,197,221,222,242,},{"Forgeborne Reveries (Heirmir)",199,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",38,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",223,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",141,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",90,0,0,0,0,0,0,0,},},},
		[266] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,4,1,0,-11,5,1,-2,},{"Fel Commando",0,99,100,103,114,128,134,145,},{"Pointed Courage (5 Allies) (Kleia)",238,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,93,114,106,111,114,133,130,},{"Carnivorous Stalkers",0,78,77,85,82,83,97,103,},{"Borne of Blood",0,124,127,136,149,165,175,190,},{"Pointed Courage (3 Allies) (Kleia)",146,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",86,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",52,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",147,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",126,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",93,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",14,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,50,54,59,51,55,58,63,},{"Fel Commando",0,102,114,124,115,136,139,148,},{"Refined Palate (Theotar)",47,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",120,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",83,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",141,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,101,94,110,107,123,130,136,},{"Carnivorous Stalkers",0,79,76,100,101,109,105,118,},{"Borne of Blood",0,121,139,145,157,161,184,188,},{"Soothing Shade (Theotar)",114,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",62,0,0,0,0,0,0,0,},{"Built for War (Draven)",194,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",8,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,38,42,39,41,45,50,52,},{"Fel Commando",0,77,107,96,110,124,124,137,},{"Grove Invigoration (Niya)",142,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,92,92,86,109,99,111,109,},{"Borne of Blood",0,110,132,125,142,145,163,185,},{"Carnivorous Stalkers",0,57,61,74,77,73,92,113,},{"Niya's Tools: Burrs (Niya)",204,0,0,0,0,0,0,0,},{"First Strike (Korayn)",9,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",73,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-4,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-1,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",192,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",175,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,54,67,76,75,86,84,96,},{"Fel Commando",0,82,86,110,116,123,144,139,},{"Carnivorous Stalkers",0,72,73,85,78,99,109,107,},{"Tyrant's Soul",0,95,107,98,107,127,125,130,},{"Borne of Blood",0,112,116,122,150,152,157,180,},{"Gnashing Chompers (Emeni)",10,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",135,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",55,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",3,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",130,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",198,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",104,0,0,0,0,0,0,0,},},},
		[102] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,14,12,20,8,27,31,29,},{"Stellar Inspiration",0,45,43,50,51,49,55,60,},{"Hammer of Genesis (Mikanikos)",11,0,0,0,0,0,0,0,},{"Precise Alignment",0,63,57,69,57,59,71,69,},{"Umbral Intensity",0,57,71,87,83,76,102,92,},{"Combat Meditation (Always Extend) (Pelagos)",264,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",225,0,0,0,0,0,0,0,},{"Fury of the Skies",0,80,91,104,114,122,145,138,},{"Combat Meditation (Never Extend) (Pelagos)",196,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",101,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",141,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",227,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",44,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,141,164,167,178,204,215,215,},{"Stellar Inspiration",0,34,53,66,56,50,59,74,},{"Refined Palate (Theotar)",75,0,0,0,0,0,0,0,},{"Fury of the Skies",0,86,101,105,107,121,134,148,},{"Built for War (Draven)",227,0,0,0,0,0,0,0,},{"Precise Alignment",0,52,54,66,74,79,83,107,},{"Wasteland Propriety (Theotar)",115,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",97,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",130,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",2,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",90,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",172,0,0,0,0,0,0,0,},{"Umbral Intensity",0,64,78,75,85,99,104,114,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,127,138,142,153,167,176,197,},{"Stellar Inspiration",0,48,42,57,68,54,62,66,},{"Wild Hunt Tactics (Korayn)",181,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-9,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",116,0,0,0,0,0,0,0,},{"Fury of the Skies",0,88,101,94,122,131,134,143,},{"Niya's Tools: Herbs (Niya)",-7,0,0,0,0,0,0,0,},{"Umbral Intensity",0,62,71,75,84,87,90,90,},{"Grove Invigoration (Niya)",335,0,0,0,0,0,0,0,},{"Precise Alignment",0,38,36,42,54,63,81,73,},{"Social Butterfly (Dreamweaver)",80,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",254,0,0,0,0,0,0,0,},{"First Strike (Korayn)",31,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,57,85,81,99,105,111,112,},{"Precise Alignment",0,-20,-14,0,-4,24,38,60,},{"Plaguey's Preemptive Strike (Marileth)",24,0,0,0,0,0,0,0,},{"Stellar Inspiration",0,28,35,46,39,36,54,59,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Fury of the Skies",0,90,87,104,111,117,131,132,},{"Umbral Intensity",0,62,63,77,74,74,82,91,},{"Forgeborne Reveries (Heirmir)",183,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",73,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",48,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",128,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",35,0,0,0,0,0,0,0,},},},
		[63] ={{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,93,94,119,121,133,133,146,},{"Master Flame",0,2,7,9,0,-6,-2,0,},{"Combat Meditation (Never Extend) (Pelagos)",151,0,0,0,0,0,0,0,},{"Ire of the Ascended",0,84,85,90,109,125,115,129,},{"Infernal Cascade",0,425,468,504,545,593,631,679,},{"Bron's Call to Action (Mikanikos)",86,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",192,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",25,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",80,0,0,0,0,0,0,0,},{"Flame Accretion",0,-2,5,6,-1,8,15,18,},{"Pointed Courage (5 Allies) (Kleia)",117,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",14,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",238,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,99,97,121,126,132,144,147,},{"Infernal Cascade",0,440,476,534,556,612,658,704,},{"Siphoned Malice",0,56,74,85,86,97,107,106,},{"Master Flame",0,-5,-1,4,-11,-19,-9,-4,},{"Flame Accretion",0,-14,-10,-7,-4,2,14,4,},{"Built for War (Draven)",183,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",167,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",48,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",99,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",10,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",82,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",91,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",86,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,107,102,122,138,139,155,156,},{"Master Flame",0,4,9,-3,12,3,2,0,},{"Infernal Cascade",0,472,507,548,598,662,695,729,},{"Niya's Tools: Poison (Niya)",65,0,0,0,0,0,0,0,},{"Discipline of the Grove",0,195,216,227,235,256,259,278,},{"Wild Hunt Tactics (Korayn)",193,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",82,0,0,0,0,0,0,0,},{"Flame Accretion",0,7,19,4,5,22,29,24,},{"Niya's Tools: Burrs (Niya)",280,0,0,0,0,0,0,0,},{"First Strike (Korayn)",18,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",79,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",85,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",4,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,95,110,118,125,150,139,160,},{"Master Flame",0,-2,-2,-1,17,0,-5,-1,},{"Lead by Example (0 Allies) (Emeni)",98,0,0,0,0,0,0,0,},{"Gift of the Lich",0,17,30,19,32,42,44,32,},{"Infernal Cascade",0,451,496,541,584,634,674,725,},{"Forgeborne Reveries (Heirmir)",160,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",32,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-6,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",233,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",169,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",70,0,0,0,0,0,0,0,},{"Flame Accretion",0,0,11,12,19,15,31,22,},},},
		[259] ={{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,76,78,85,88,100,110,115,},{"Reverberation",0,53,76,76,86,89,96,100,},{"Maim, Mangle",0,72,81,88,106,105,118,121,},{"Poisoned Katar",0,-1,-12,-4,-13,4,-2,6,},{"Pointed Courage (5 Allies) (Kleia)",271,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,90,105,104,118,125,149,152,},{"Combat Meditation (Never Extend) (Pelagos)",89,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",35,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",183,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-11,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",168,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",135,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",44,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,92,97,98,128,134,128,144,},{"Poisoned Katar",0,18,9,-2,13,13,10,10,},{"Lashing Scars",0,210,217,231,239,239,252,263,},{"Thrill Seeker (Nadjia)",138,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,97,108,122,132,134,143,149,},{"Built for War (Draven)",215,0,0,0,0,0,0,0,},{"Maim, Mangle",0,92,99,117,128,127,138,153,},{"Dauntless Duelist (Nadjia)",219,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",105,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",126,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",133,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",220,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",112,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,67,76,92,82,91,100,112,},{"Well-Placed Steel",0,92,104,112,125,129,155,134,},{"Maim, Mangle",0,66,79,76,105,99,102,109,},{"Septic Shock",0,48,47,51,49,58,56,66,},{"Poisoned Katar",0,-17,-13,-18,-4,-3,-15,-15,},{"Field of Blossoms (Dreamweaver)",175,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",214,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",259,0,0,0,0,0,0,0,},{"First Strike (Korayn)",7,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",219,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",83,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",197,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",184,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,66,76,81,80,99,105,113,},{"Sudden Fractures",0,79,106,109,114,142,129,147,},{"Well-Placed Steel",0,83,107,105,107,118,135,153,},{"Maim, Mangle",0,75,74,95,88,100,104,101,},{"Poisoned Katar",0,-8,-9,-10,-11,-5,-13,-8,},{"Lead by Example (4 Allies) (Emeni)",138,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",185,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",139,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-9,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",19,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",107,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",64,0,0,0,0,0,0,0,},},},
		[267] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,-12,-2,-4,-14,-3,-3,-5,},{"Infernal Brand",0,40,52,52,59,59,62,76,},{"Ashen Remains",0,73,75,91,87,96,118,117,},{"Combusting Engine",0,68,56,61,66,63,69,82,},{"Duplicitous Havoc",0,6,-4,-1,3,3,-12,-1,},{"Combat Meditation (Always Extend) (Pelagos)",178,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",141,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",93,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",45,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",155,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",254,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",48,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,59,55,54,61,59,68,64,},{"Infernal Brand",0,52,54,51,72,68,69,90,},{"Duplicitous Havoc",0,0,1,2,9,1,13,-7,},{"Combusting Engine",0,58,74,69,83,79,82,85,},{"Exacting Preparation (Nadjia)",88,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",17,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",196,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",113,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",84,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",135,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",78,0,0,0,0,0,0,0,},{"Built for War (Draven)",221,0,0,0,0,0,0,0,},{"Ashen Remains",0,84,90,90,110,122,123,126,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,44,59,57,53,58,58,59,},{"Infernal Brand",0,42,53,53,66,63,74,83,},{"Social Butterfly (Dreamweaver)",88,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,-6,-1,3,-1,-5,-11,8,},{"Ashen Remains",0,76,86,93,102,106,124,122,},{"Combusting Engine",0,50,61,73,73,79,79,99,},{"Niya's Tools: Burrs (Niya)",225,0,0,0,0,0,0,0,},{"First Strike (Korayn)",20,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",1,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",195,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",143,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",208,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,83,70,78,86,96,91,109,},{"Infernal Brand",0,47,64,63,70,69,76,80,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",143,0,0,0,0,0,0,0,},{"Combusting Engine",0,57,71,80,66,75,95,89,},{"Duplicitous Havoc",0,8,-1,2,3,7,-8,-5,},{"Ashen Remains",0,91,104,111,115,126,139,155,},{"Forgeborne Reveries (Heirmir)",182,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",4,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",165,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",106,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",69,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",36,0,0,0,0,0,0,0,},},},
		[250] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,91,91,93,101,99,106,107,},{"Debilitating Malady",0,4,5,5,3,0,9,3,},{"Withering Plague",0,35,44,45,48,51,53,54,},{"Bron's Call to Action (Mikanikos)",82,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",57,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",83,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",100,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",8,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",88,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",151,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",29,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,8,8,17,18,16,14,17,},{"Debilitating Malady",0,3,-8,6,0,4,-5,3,},{"Wasteland Propriety (Theotar)",38,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",81,0,0,0,0,0,0,0,},{"Withering Plague",0,32,24,38,37,40,49,34,},{"Refined Palate (Theotar)",93,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",59,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",91,0,0,0,0,0,0,0,},{"Built for War (Draven)",89,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",39,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",61,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,41,58,65,70,78,77,83,},{"Debilitating Malady",0,-7,-12,-6,-6,0,-2,-5,},{"Grove Invigoration (Niya)",76,0,0,0,0,0,0,0,},{"Withering Plague",0,26,22,35,38,40,47,41,},{"Niya's Tools: Herbs (Niya)",20,0,0,0,0,0,0,0,},{"First Strike (Korayn)",10,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",253,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",65,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",100,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",74,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",44,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,12,8,17,17,17,17,13,},{"Debilitating Malady",0,-2,-1,-2,-2,-1,4,7,},{"Lead by Example (0 Allies) (Emeni)",32,0,0,0,0,0,0,0,},{"Withering Plague",0,36,35,32,48,45,47,55,},{"Plaguey's Preemptive Strike (Marileth)",11,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-4,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",72,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",87,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",58,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",74,0,0,0,0,0,0,0,},},},
		[254] ={{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,43,51,48,48,62,72,89,},{"Brutal Projectiles",0,25,20,27,25,28,34,24,},{"Enfeebled Mark",0,129,146,154,178,177,203,204,},{"Sharpshooter's Focus",0,58,63,66,82,82,88,98,},{"Deadly Chain",0,2,-2,-1,0,3,1,-3,},{"Combat Meditation (50% Extend) (Pelagos)",214,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",24,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",266,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",172,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",86,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",47,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",228,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",140,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,26,40,41,52,54,67,79,},{"Brutal Projectiles",0,25,11,11,28,24,24,25,},{"Empowered Release",0,120,128,130,138,136,144,151,},{"Deadly Chain",0,-14,-2,-12,-2,-6,-2,-6,},{"Sharpshooter's Focus",0,41,56,53,73,64,74,86,},{"Built for War (Draven)",163,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",175,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",96,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",57,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",129,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",78,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",41,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,28,38,44,51,67,81,76,},{"Spirit Attunement",0,101,104,110,121,118,135,135,},{"Sharpshooter's Focus",0,59,62,73,77,79,80,96,},{"Wild Hunt Tactics (Korayn)",220,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",182,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",192,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,12,25,20,29,31,22,22,},{"Niya's Tools: Burrs (Niya)",238,0,0,0,0,0,0,0,},{"First Strike (Korayn)",32,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-5,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",70,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",294,0,0,0,0,0,0,0,},{"Deadly Chain",0,-9,3,-6,-5,-5,-8,-7,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,30,36,58,51,73,65,79,},{"Necrotic Barrage",0,37,31,44,38,50,57,48,},{"Brutal Projectiles",0,20,14,28,19,22,27,36,},{"Deadly Chain",0,-2,1,-9,9,-10,-3,-9,},{"Lead by Example (2 Allies) (Emeni)",96,0,0,0,0,0,0,0,},{"Sharpshooter's Focus",0,54,53,64,75,80,81,86,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",140,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",139,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",42,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",45,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",132,0,0,0,0,0,0,0,},},},
		[260] ={{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,219,250,277,291,328,351,354,},{"Sleight of Hand",0,67,75,75,88,101,104,114,},{"Reverberation",0,64,76,75,92,81,89,94,},{"Ambidexterity",0,13,6,-2,2,10,-5,3,},{"Hammer of Genesis (Mikanikos)",5,0,0,0,0,0,0,0,},{"Triple Threat",0,42,55,57,73,66,71,80,},{"Bron's Call to Action (Mikanikos)",148,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",132,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",243,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",91,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",71,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",54,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",138,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,228,252,271,296,335,342,376,},{"Sleight of Hand",0,62,83,87,91,86,108,98,},{"Triple Threat",0,41,57,65,66,73,80,88,},{"Ambidexterity",0,-11,5,16,2,-1,-9,-3,},{"Built for War (Draven)",176,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",186,0,0,0,0,0,0,0,},{"Lashing Scars",0,137,158,158,169,166,192,189,},{"Wasteland Propriety (Theotar)",81,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",95,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",176,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",98,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",127,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",92,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,219,237,261,280,310,333,345,},{"Sleight of Hand",0,70,60,77,87,88,90,103,},{"Septic Shock",0,38,46,48,47,57,57,63,},{"Triple Threat",0,37,48,58,58,57,70,80,},{"Grove Invigoration (Niya)",141,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",321,0,0,0,0,0,0,0,},{"First Strike (Korayn)",22,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",162,0,0,0,0,0,0,0,},{"Ambidexterity",0,-14,-3,1,-3,-1,-12,-10,},{"Niya's Tools: Poison (Niya)",288,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",121,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",73,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",167,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,212,243,256,284,300,314,350,},{"Triple Threat",0,40,45,53,62,64,75,85,},{"Sudden Fractures",0,56,74,74,96,103,104,114,},{"Lead by Example (2 Allies) (Emeni)",65,0,0,0,0,0,0,0,},{"Ambidexterity",0,1,-9,-1,-4,1,6,3,},{"Gnashing Chompers (Emeni)",-11,0,0,0,0,0,0,0,},{"Sleight of Hand",0,65,69,74,81,87,98,97,},{"Plaguey's Preemptive Strike (Marileth)",33,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",90,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",24,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",132,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",143,0,0,0,0,0,0,0,},},},
		[71] ={{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,91,106,103,115,132,144,151,},{"Ashen Juggernaut",0,168,170,198,217,229,255,257,},{"Piercing Verdict",0,28,28,36,39,37,44,48,},{"Crash the Ramparts",0,57,51,65,74,71,77,78,},{"Merciless Bonegrinder",0,-5,3,-16,-9,-9,5,-13,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",168,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",134,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",244,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",75,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",47,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",93,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",136,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,69,78,87,84,92,96,101,},{"Crash the Ramparts",0,50,49,60,52,70,65,65,},{"Ashen Juggernaut",0,190,200,228,244,254,279,300,},{"Dauntless Duelist (Nadjia)",187,0,0,0,0,0,0,0,},{"Built for War (Draven)",175,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",93,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",83,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",113,0,0,0,0,0,0,0,},{"Harrowing Punishment",0,44,43,47,44,33,57,62,},{"Merciless Bonegrinder",0,5,-2,1,-7,1,3,12,},{"Superior Tactics (Draven)",213,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",87,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",66,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,4,4,13,16,21,18,41,},{"Crash the Ramparts",0,52,43,50,64,66,69,87,},{"Ashen Juggernaut",0,149,164,186,209,217,246,244,},{"Merciless Bonegrinder",0,-15,-10,-7,-4,-14,-11,-9,},{"Social Butterfly (Dreamweaver)",70,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",192,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",138,0,0,0,0,0,0,0,},{"Mortal Combo",0,78,88,105,113,124,139,144,},{"Niya's Tools: Burrs (Niya)",217,0,0,0,0,0,0,0,},{"First Strike (Korayn)",41,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-12,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",141,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",184,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,103,116,115,130,125,148,159,},{"Ashen Juggernaut",0,173,198,215,222,241,261,272,},{"Veteran's Repute",0,81,90,98,109,109,114,124,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",137,0,0,0,0,0,0,0,},{"Crash the Ramparts",0,58,64,60,80,79,90,93,},{"Gnashing Chompers (Emeni)",2,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",47,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",125,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",94,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",54,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",130,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,4,5,4,-3,8,12,7,},},},
		[73] ={{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,12,17,22,27,25,34,31,},{"Piercing Verdict",0,20,27,33,30,31,34,44,},{"Ashen Juggernaut",0,29,32,37,41,40,49,52,},{"Bron's Call to Action (Mikanikos)",90,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",3,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",168,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",72,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",59,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",90,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",30,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",92,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,19,19,17,12,19,20,18,},{"Harrowing Punishment",0,19,23,15,17,21,14,13,},{"Ashen Juggernaut",0,60,61,65,76,81,80,87,},{"Superior Tactics (Draven)",4,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",48,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",65,0,0,0,0,0,0,0,},{"Built for War (Draven)",113,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",126,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",104,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",72,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",29,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,19,27,31,34,35,37,38,},{"Show of Force",0,25,26,27,22,30,35,30,},{"Ashen Juggernaut",0,38,40,39,38,44,41,50,},{"Wild Hunt Tactics (Korayn)",111,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",58,0,0,0,0,0,0,0,},{"First Strike (Korayn)",35,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",192,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-6,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",105,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",74,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,22,20,23,22,36,34,40,},{"Veteran's Repute",0,44,58,52,65,69,78,81,},{"Ashen Juggernaut",0,37,35,44,45,48,54,55,},{"Lead by Example (2 Allies) (Emeni)",57,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",86,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",21,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",34,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",82,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",60,0,0,0,0,0,0,0,},},},
		[268] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,48,50,49,45,53,60,57,},{"Walk with the Ox",0,189,203,204,220,236,243,245,},{"Scalding Brew",0,19,21,28,31,29,31,37,},{"Hammer of Genesis (Mikanikos)",-4,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",139,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",21,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",79,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",80,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",60,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",37,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",136,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,37,46,36,56,56,65,60,},{"Walk with the Ox",0,204,219,227,224,245,246,255,},{"Scalding Brew",0,20,27,28,27,34,36,30,},{"Built for War (Draven)",92,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",37,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",92,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",32,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",45,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",130,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",43,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",43,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,15,10,9,15,19,18,14,},{"Walk with the Ox",0,178,188,199,213,223,226,235,},{"Scalding Brew",0,25,26,30,27,37,28,43,},{"Wild Hunt Tactics (Korayn)",108,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",50,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",89,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",90,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",101,0,0,0,0,0,0,0,},{"First Strike (Korayn)",51,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",247,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",67,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,58,69,73,75,75,87,91,},{"Walk with the Ox",0,204,219,230,240,253,258,271,},{"Scalding Brew",0,30,31,28,36,33,34,39,},{"Lead by Example (0 Allies) (Emeni)",38,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",70,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",87,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",22,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",64,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",95,0,0,0,0,0,0,0,},},},
		[261] ={{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,64,82,81,92,85,102,117,},{"Reverberation",0,66,76,80,106,98,105,122,},{"Hammer of Genesis (Mikanikos)",-10,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",126,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",95,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",70,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",83,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,62,84,104,108,105,110,100,},{"Pointed Courage (1 Ally) (Kleia)",41,0,0,0,0,0,0,0,},{"Deeper Daggers",0,57,66,75,72,74,89,101,},{"Pointed Courage (3 Allies) (Kleia)",138,0,0,0,0,0,0,0,},{"Planned Execution",0,85,93,84,106,113,120,137,},{"Pointed Courage (5 Allies) (Kleia)",232,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,69,79,99,105,100,120,122,},{"Lashing Scars",0,158,172,176,189,186,198,210,},{"Thrill Seeker (Nadjia)",88,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,54,76,101,118,101,92,102,},{"Built for War (Draven)",182,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",184,0,0,0,0,0,0,0,},{"Deeper Daggers",0,82,84,100,91,110,116,115,},{"Refined Palate (Theotar)",82,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",98,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",105,0,0,0,0,0,0,0,},{"Planned Execution",0,109,110,122,130,129,150,160,},{"Exacting Preparation (Nadjia)",113,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",227,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,74,79,84,91,103,108,116,},{"Septic Shock",0,75,62,69,85,78,81,101,},{"Stiletto Staccato",0,66,50,87,114,120,111,98,},{"Planned Execution",0,104,115,130,139,140,165,165,},{"Field of Blossoms (Dreamweaver)",121,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",183,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",233,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",261,0,0,0,0,0,0,0,},{"First Strike (Korayn)",28,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",176,0,0,0,0,0,0,0,},{"Deeper Daggers",0,69,79,81,95,86,98,99,},{"Social Butterfly (Dreamweaver)",86,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",154,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,51,67,77,76,83,95,108,},{"Sudden Fractures",0,54,70,63,67,84,94,97,},{"Deeper Daggers",0,60,56,66,79,89,91,85,},{"Stiletto Staccato",0,56,75,91,103,104,94,82,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",151,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-8,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",24,0,0,0,0,0,0,0,},{"Planned Execution",0,86,104,103,107,130,126,146,},{"Lead by Example (2 Allies) (Emeni)",84,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",41,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",122,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",130,0,0,0,0,0,0,0,},},},
		[269] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,127,132,123,127,133,125,140,},{"Inner Fury",0,35,43,38,54,48,58,64,},{"Calculated Strikes",0,3,1,1,-9,5,-8,-9,},{"Combat Meditation (Never Extend) (Pelagos)",146,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,170,194,207,221,240,258,266,},{"Xuen's Bond",0,16,13,11,21,27,36,53,},{"Hammer of Genesis (Mikanikos)",13,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",182,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",125,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",38,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",133,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",217,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",217,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,66,84,90,96,113,106,122,},{"Calculated Strikes",0,-2,2,6,6,-5,-1,0,},{"Inner Fury",0,35,50,46,47,56,54,58,},{"Dauntless Duelist (Nadjia)",99,0,0,0,0,0,0,0,},{"Built for War (Draven)",145,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,140,145,163,176,203,209,225,},{"Xuen's Bond",0,65,66,71,73,85,85,74,},{"Thrill Seeker (Nadjia)",82,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",64,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",93,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",88,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",81,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",157,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,1,4,17,14,18,11,12,},{"Grove Invigoration (Niya)",256,0,0,0,0,0,0,0,},{"Calculated Strikes",0,-4,-1,-15,-8,5,2,-12,},{"Inner Fury",0,25,32,46,50,42,54,63,},{"Coordinated Offensive",0,123,148,155,164,185,208,220,},{"Xuen's Bond",0,54,48,65,65,66,77,80,},{"Wild Hunt Tactics (Korayn)",173,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",208,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",151,0,0,0,0,0,0,0,},{"First Strike (Korayn)",47,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",253,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",67,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",46,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,42,49,49,52,56,72,71,},{"Calculated Strikes",0,-5,-4,0,-1,-17,-4,1,},{"Inner Fury",0,40,42,37,53,60,59,63,},{"Coordinated Offensive",0,144,157,177,185,197,223,239,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",55,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",105,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",111,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",21,0,0,0,0,0,0,0,},{"Xuen's Bond",0,47,32,35,52,65,53,64,},{"Lead by Example (4 Allies) (Emeni)",152,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",97,0,0,0,0,0,0,0,},},},
		[251] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,81,87,95,96,96,102,103,},{"Accelerated Cold",0,95,110,122,119,124,144,146,},{"Pointed Courage (3 Allies) (Kleia)",194,0,0,0,0,0,0,0,},{"Eradicating Blow",0,26,30,34,36,37,36,45,},{"Combat Meditation (Always Extend) (Pelagos)",257,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",183,0,0,0,0,0,0,0,},{"Everfrost",0,153,174,178,202,214,228,232,},{"Bron's Call to Action (Mikanikos)",70,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",65,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",297,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",108,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,37,32,44,53,61,63,70,},{"Hammer of Genesis (Mikanikos)",22,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,23,13,18,17,29,26,24,},{"Accelerated Cold",0,77,95,103,105,109,119,135,},{"Thrill Seeker (Nadjia)",81,0,0,0,0,0,0,0,},{"Eradicating Blow",0,25,28,40,24,30,37,44,},{"Everfrost",0,151,170,182,196,195,210,223,},{"Refined Palate (Theotar)",86,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,42,32,51,53,60,73,74,},{"Soothing Shade (Theotar)",131,0,0,0,0,0,0,0,},{"Built for War (Draven)",197,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",193,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",294,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",68,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",173,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,18,28,24,35,26,32,25,},{"Eradicating Blow",0,13,23,25,32,42,34,45,},{"Accelerated Cold",0,103,103,109,117,132,142,152,},{"Wild Hunt Tactics (Korayn)",209,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",57,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",212,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",245,0,0,0,0,0,0,0,},{"First Strike (Korayn)",17,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-20,0,0,0,0,0,0,0,},{"Everfrost",0,148,165,156,177,205,216,228,},{"Grove Invigoration (Niya)",112,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",82,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,27,34,48,48,46,52,63,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,20,22,19,33,22,30,40,},{"Eradicating Blow",0,23,23,35,36,51,36,39,},{"Accelerated Cold",0,113,113,112,131,134,153,156,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",180,0,0,0,0,0,0,0,},{"Unleashed Frenzy",0,39,36,49,52,56,67,69,},{"Plaguey's Preemptive Strike (Marileth)",33,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",240,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",143,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",156,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",83,0,0,0,0,0,0,0,},{"Everfrost",0,157,168,171,199,207,222,235,},{"Gnashing Chompers (Emeni)",7,0,0,0,0,0,0,0,},},},
		[66] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,58,68,77,80,86,88,100,},{"Punish the Guilty",0,72,75,81,100,93,100,117,},{"Vengeful Shock",0,48,57,58,68,71,82,81,},{"Hammer of Genesis (Mikanikos)",10,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",112,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",26,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",62,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",163,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",104,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",88,0,0,0,0,0,0,0,},{"Pointed Courage (5 Allies) (Kleia)",165,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,120,128,139,149,164,175,181,},{"Punish the Guilty",0,68,87,109,99,104,120,125,},{"Vengeful Shock",0,51,57,67,74,74,85,99,},{"Built for War (Draven)",142,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",72,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",82,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",144,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",102,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",98,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",91,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,14,25,21,34,28,25,38,},{"Punish the Guilty",0,79,84,85,97,105,107,135,},{"Vengeful Shock",0,50,61,69,73,78,76,90,},{"Wild Hunt Tactics (Korayn)",153,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",11,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",121,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",140,0,0,0,0,0,0,0,},{"First Strike (Korayn)",34,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",274,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",68,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,36,35,33,42,40,52,49,},{"Punish the Guilty",0,79,82,84,95,105,111,118,},{"Vengeful Shock",0,43,51,53,63,63,75,82,},{"Lead by Example (0 Allies) (Emeni)",19,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",28,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",106,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-3,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",67,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",46,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",110,0,0,0,0,0,0,0,},},},
	},
	["T27"]={
		[255] ={{{"Power",1,200,213,226,239,252,265,278,},{"Flame Infusion",0,-6,-3,-6,-9,0,-11,11,},{"Deadly Tandem",0,193,198,224,219,228,244,243,},{"Enfeebled Mark",0,209,255,238,289,289,308,325,},{"Strength of the Pack",0,139,129,135,152,163,185,191,},{"Effusive Anima Accelerator (Mikanikos)",261,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",-6,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",44,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",138,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",407,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",269,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",112,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",70,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",255,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",212,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",136,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",178,0,0,0,0,0,0,0,},{"Stinging Strike",0,259,273,285,306,336,351,362,},{"Newfound Resolve (Pelagos)",124,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Flame Infusion",0,-7,-19,2,-17,-18,-12,-26,},{"Deadly Tandem",0,256,283,301,334,342,366,367,},{"Empowered Release",0,166,170,180,175,193,194,216,},{"Thrill Seeker (Nadjia)",242,0,0,0,0,0,0,0,},{"Battlefield Presence (Draven)",72,0,0,0,0,0,0,0,},{"Stinging Strike",0,215,211,254,254,274,276,272,},{"Built for War (Draven)",326,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",189,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",196,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",386,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",261,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",92,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",242,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",239,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",112,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",166,0,0,0,0,0,0,0,},{"Strength of the Pack",0,72,85,101,107,129,100,139,},{"Soothing Shade (Theotar)",195,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",74,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Flame Infusion",0,19,20,26,40,9,6,24,},{"Deadly Tandem",0,172,177,217,206,209,242,239,},{"Spirit Attunement",0,120,148,149,138,162,151,168,},{"Strength of the Pack",0,139,135,162,178,173,209,220,},{"Stinging Strike",0,265,288,293,324,339,356,365,},{"Wild Hunt Tactics (Korayn)",304,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",445,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",250,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",322,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",310,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",-13,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",353,0,0,0,0,0,0,0,},{"First Strike (Korayn)",32,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",43,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",152,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",56,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Flame Infusion",0,-11,-3,-1,17,8,2,16,},{"Deadly Tandem",0,173,195,205,197,230,226,225,},{"Necrotic Barrage",0,100,95,126,130,138,116,124,},{"Gnashing Chompers (Emeni)",8,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",242,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",216,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",179,0,0,0,0,0,0,0,},{"Stinging Strike",0,260,282,297,326,312,353,368,},{"Lead by Example (2 Allies) (Emeni)",141,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",234,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",91,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",38,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",100,0,0,0,0,0,0,0,},{"Strength of the Pack",0,103,105,134,149,150,160,159,},{"Lead by Example (4 Allies) (Emeni)",210,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",96,0,0,0,0,0,0,0,},},},
		[262] ={{{"Power",1,200,213,226,239,252,265,278,},{"Elysian Dirge",0,120,113,116,121,135,136,145,},{"Call of Flame",0,159,165,166,171,168,171,185,},{"Pyroclastic Shock",0,108,140,140,139,136,134,173,},{"Shake the Foundations",0,27,19,0,14,-3,13,11,},{"Effusive Anima Accelerator (Mikanikos)",225,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",-2,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",41,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",152,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",398,0,0,0,0,0,0,0,},{"High Voltage",0,50,38,27,48,46,49,55,},{"Soulglow Spectrometer (Mikanikos)",279,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",184,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",90,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",212,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",146,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",146,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",113,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",161,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",5,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Lavish Harvest",0,30,15,13,29,19,22,29,},{"Call of Flame",0,135,162,176,168,169,172,180,},{"Battlefield Presence (Draven)",101,0,0,0,0,0,0,0,},{"Built for War (Draven)",441,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",268,0,0,0,0,0,0,0,},{"Shake the Foundations",0,17,9,1,10,13,4,24,},{"Party Favors (Crit) (Theotar)",194,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",238,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",291,0,0,0,0,0,0,0,},{"Pyroclastic Shock",0,117,133,120,136,147,145,145,},{"Wasteland Propriety (Theotar)",59,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",238,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",194,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",142,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",167,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",172,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",126,0,0,0,0,0,0,0,},{"High Voltage",0,57,47,42,31,44,52,14,},{"Refined Palate (Theotar)",111,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Essential Extraction",0,79,92,87,93,85,80,97,},{"Call of Flame",0,130,163,169,162,165,184,169,},{"Pyroclastic Shock",0,116,109,122,115,136,135,148,},{"Wild Hunt Tactics (Korayn)",282,0,0,0,0,0,0,0,},{"Shake the Foundations",0,11,5,3,-15,15,-9,3,},{"Dream Delver (Dreamweaver)",265,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",279,0,0,0,0,0,0,0,},{"High Voltage",0,20,33,62,34,22,43,27,},{"Grove Invigoration (Niya)",243,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",-30,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",328,0,0,0,0,0,0,0,},{"First Strike (Korayn)",51,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",128,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",36,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",9,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",273,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Tumbling Waves",0,65,65,61,58,88,72,81,},{"Call of Flame",0,179,173,196,183,186,181,190,},{"Pyroclastic Shock",0,105,132,112,129,139,149,152,},{"Shake the Foundations",0,7,6,1,-6,-4,1,12,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",169,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",75,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",103,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",12,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",87,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",11,0,0,0,0,0,0,0,},{"High Voltage",0,25,14,40,31,34,52,40,},{"Lead by Example (4 Allies) (Emeni)",210,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",384,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",159,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",9,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",264,0,0,0,0,0,0,0,},},},
		[62] ={{{"Power",1,200,213,226,239,252,265,278,},{"Artifice of the Archmage",0,12,16,4,10,-1,9,1,},{"Magi's Brand",0,190,194,208,225,245,242,264,},{"Arcane Prodigy",0,749,738,742,814,793,804,842,},{"Effusive Anima Accelerator (Mikanikos)",149,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",40,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",116,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",382,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",247,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",89,0,0,0,0,0,0,0,},{"Nether Precision",0,57,65,56,63,59,64,87,},{"Ire of the Ascended",0,208,229,238,249,267,279,285,},{"Better Together (Pelagos)",76,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",217,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",141,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",197,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",154,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",1,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",26,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",134,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Artifice of the Archmage",0,0,19,18,16,9,1,10,},{"Magi's Brand",0,218,240,258,257,290,301,297,},{"Arcane Prodigy",0,1197,1221,1212,1243,1242,1237,1226,},{"Battlefield Presence (Draven)",86,0,0,0,0,0,0,0,},{"Nether Precision",0,67,75,98,95,104,112,111,},{"Built for War (Draven)",429,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",250,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",174,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",201,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",40,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",234,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",121,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",102,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",184,0,0,0,0,0,0,0,},{"Siphoned Malice",0,288,302,330,349,361,374,384,},{"Fatal Flaw (Nadjia)",82,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",100,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",260,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",165,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Artifice of the Archmage",0,4,33,9,17,21,21,24,},{"Magi's Brand",0,238,252,263,286,297,318,342,},{"Arcane Prodigy",0,355,340,360,365,362,351,343,},{"Dream Delver (Dreamweaver)",272,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",95,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",310,0,0,0,0,0,0,0,},{"Nether Precision",0,85,84,92,91,111,102,121,},{"Niya's Tools: Poison (Niya)",236,0,0,0,0,0,0,0,},{"Discipline of the Grove",0,7,77,133,180,222,236,225,},{"Grove Invigoration (Niya)",183,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",-2,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",314,0,0,0,0,0,0,0,},{"First Strike (Korayn)",32,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",7,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",21,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",128,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Artifice of the Archmage",0,-1,1,6,25,23,-4,3,},{"Magi's Brand",0,157,191,197,218,235,234,233,},{"Arcane Prodigy",0,945,934,949,980,986,976,991,},{"Gift of the Lich",0,40,52,53,46,40,53,64,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",186,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",64,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",241,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",193,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",414,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",111,0,0,0,0,0,0,0,},{"Nether Precision",0,63,57,83,79,73,84,102,},{"Carver's Eye (Heirmir)",28,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-4,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",202,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",313,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",142,0,0,0,0,0,0,0,},},},
		[263] ={{{"Power",1,200,213,226,239,252,265,278,},{"Elysian Dirge",0,79,94,95,110,101,102,106,},{"Chilled to the Core",0,38,71,33,42,36,45,54,},{"Combat Meditation (50% Extend) (Pelagos)",197,0,0,0,0,0,0,0,},{"Unruly Winds",0,60,65,60,83,91,95,98,},{"Valiant Strikes (Kleia)",1,0,0,0,0,0,0,0,},{"Magma Fist",0,258,275,255,293,284,300,320,},{"Spear of the Archon (Kleia)",31,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",172,0,0,0,0,0,0,0,},{"Focused Lightning",0,67,89,91,115,152,138,151,},{"Pointed Courage (3 Allies) (Kleia)",466,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",290,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",214,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",100,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",246,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",115,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",115,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",180,0,0,0,0,0,0,0,},{"Effusive Anima Accelerator (Mikanikos)",224,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Lavish Harvest",0,56,49,30,37,38,49,45,},{"Chilled to the Core",0,58,60,57,56,78,46,52,},{"Dauntless Duelist (Nadjia)",303,0,0,0,0,0,0,0,},{"Magma Fist",0,264,277,300,308,300,331,328,},{"Battlefield Presence (Draven)",101,0,0,0,0,0,0,0,},{"Unruly Winds",0,58,91,87,75,105,100,98,},{"Party Favors (Primary) (Theotar)",241,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",121,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",246,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",301,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",273,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",218,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",152,0,0,0,0,0,0,0,},{"Focused Lightning",0,114,96,121,137,130,173,188,},{"Soothing Shade (Theotar)",214,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",188,0,0,0,0,0,0,0,},{"Built for War (Draven)",359,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",200,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",121,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Essential Extraction",0,76,73,88,79,104,107,123,},{"Chilled to the Core",0,54,47,55,52,68,42,53,},{"Magma Fist",0,252,279,271,282,317,314,306,},{"Wild Hunt Tactics (Korayn)",267,0,0,0,0,0,0,0,},{"Unruly Winds",0,71,62,92,76,76,80,83,},{"Dream Delver (Dreamweaver)",257,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",350,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",384,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",2,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",327,0,0,0,0,0,0,0,},{"First Strike (Korayn)",65,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Focused Lightning",0,73,86,96,108,135,138,148,},{"Social Butterfly (Dreamweaver)",132,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",59,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",269,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Tumbling Waves",0,69,55,70,63,73,86,88,},{"Chilled to the Core",0,63,51,74,57,51,58,58,},{"Unruly Winds",0,84,84,87,89,100,93,108,},{"Magma Fist",0,273,283,272,308,302,302,326,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",249,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",102,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",57,0,0,0,0,0,0,0,},{"Focused Lightning",0,90,116,125,132,158,168,160,},{"Plaguey's Preemptive Strike (Marileth)",81,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-11,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",189,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",127,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",393,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",133,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",15,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",228,0,0,0,0,0,0,0,},},},
		[64] ={{{"Power",1,200,213,226,239,252,265,278,},{"Ire of the Ascended",0,209,242,241,245,296,306,309,},{"Ice Bite",0,227,241,244,260,290,322,321,},{"Effusive Anima Accelerator (Mikanikos)",163,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",53,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",104,0,0,0,0,0,0,0,},{"Unrelenting Cold",0,97,107,119,121,111,126,130,},{"Pointed Courage (3 Allies) (Kleia)",275,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",246,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",150,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",98,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",158,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",137,0,0,0,0,0,0,0,},{"Icy Propulsion",0,880,991,1109,1224,1370,1515,1651,},{"Combat Meditation (Never Extend) (Pelagos)",84,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",70,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",35,0,0,0,0,0,0,0,},{"Shivering Core",0,8,9,8,11,17,11,3,},{"Combat Meditation (50% Extend) (Pelagos)",111,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",20,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Siphoned Malice",0,161,174,211,216,221,233,252,},{"Ice Bite",0,240,242,266,285,301,304,336,},{"Unrelenting Cold",0,88,100,109,101,112,109,120,},{"Battlefield Presence (Draven)",86,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",254,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",116,0,0,0,0,0,0,0,},{"Shivering Core",0,-2,6,4,10,0,9,11,},{"Dauntless Duelist (Nadjia)",265,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",110,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",83,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",110,0,0,0,0,0,0,0,},{"Icy Propulsion",0,995,1119,1243,1349,1509,1659,1786,},{"Soothing Shade (Theotar)",201,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",153,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",38,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",235,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",231,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",140,0,0,0,0,0,0,0,},{"Built for War (Draven)",420,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Discipline of the Grove",0,-2,-3,-9,-4,18,-12,-13,},{"Ice Bite",0,188,227,238,257,257,281,305,},{"Unrelenting Cold",0,88,81,93,100,108,109,113,},{"Niya's Tools: Poison (Niya)",211,0,0,0,0,0,0,0,},{"Shivering Core",0,-1,-1,7,-6,4,-8,1,},{"Dream Delver (Dreamweaver)",243,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",59,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",-15,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",357,0,0,0,0,0,0,0,},{"First Strike (Korayn)",-2,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Icy Propulsion",0,958,1059,1196,1325,1465,1611,1742,},{"Bonded Hearts (Niya)",-1,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",106,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",114,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",269,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Gift of the Lich",0,76,82,89,90,114,109,118,},{"Ice Bite",0,206,234,241,248,263,295,301,},{"Unrelenting Cold",0,75,76,102,103,98,120,111,},{"Shivering Core",0,2,-5,-3,-4,-18,-7,-18,},{"Forgeborne Reveries (Heirmir)",234,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",67,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",63,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",-15,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",600,0,0,0,0,0,0,0,},{"Icy Propulsion",0,880,999,1121,1258,1401,1552,1710,},{"Carver's Eye (Heirmir)",9,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",8,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",350,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",113,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",223,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",82,0,0,0,0,0,0,0,},},},
		[252] ={{{"Power",1,200,213,226,239,252,265,278,},{"Proliferation",0,114,118,132,125,142,142,148,},{"Lingering Plague",0,66,65,52,88,88,68,79,},{"Convocation of the Dead",0,203,215,218,228,225,253,231,},{"Effusive Anima Accelerator (Mikanikos)",200,0,0,0,0,0,0,0,},{"Eternal Hunger",0,288,313,331,333,347,358,364,},{"Valiant Strikes (Kleia)",21,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",46,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",167,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",483,0,0,0,0,0,0,0,},{"Embrace Death",0,106,130,136,144,163,142,161,},{"Bron's Call to Action (Mikanikos)",215,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",283,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",143,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",96,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",221,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",169,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",9,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",155,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",276,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Impenetrable Gloom",0,56,55,56,67,66,65,69,},{"Lingering Plague",0,79,83,66,72,61,73,63,},{"Eternal Hunger",0,292,321,326,326,348,374,371,},{"Soothing Shade (Theotar)",198,0,0,0,0,0,0,0,},{"Battlefield Presence (Draven)",115,0,0,0,0,0,0,0,},{"Built for War (Draven)",370,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",231,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",139,0,0,0,0,0,0,0,},{"Convocation of the Dead",0,175,191,219,235,226,253,265,},{"Party Favors (Crit) (Theotar)",232,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",271,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",290,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",88,0,0,0,0,0,0,0,},{"Embrace Death",0,133,120,148,149,131,157,159,},{"Party Favors (Versatility) (Theotar)",286,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",274,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",228,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",174,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",125,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Withering Ground",0,54,71,70,90,71,88,102,},{"Lingering Plague",0,64,70,66,67,76,73,69,},{"Bonded Hearts (Niya)",27,0,0,0,0,0,0,0,},{"Convocation of the Dead",0,128,174,166,182,182,191,207,},{"Eternal Hunger",0,316,317,331,350,349,357,363,},{"Wild Hunt Tactics (Korayn)",287,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",129,0,0,0,0,0,0,0,},{"Embrace Death",0,105,119,128,138,143,161,171,},{"Niya's Tools: Poison (Niya)",300,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",158,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",7,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",312,0,0,0,0,0,0,0,},{"First Strike (Korayn)",48,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-5,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",159,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",165,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Brutal Grasp",0,37,32,60,49,52,68,59,},{"Lingering Plague",0,58,48,72,64,61,63,48,},{"Eternal Hunger",0,310,311,313,334,337,363,375,},{"Embrace Death",0,123,103,125,122,135,148,161,},{"Convocation of the Dead",0,179,188,213,216,207,230,244,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",254,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",60,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",221,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",157,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",275,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",81,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",15,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",117,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-14,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",245,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",161,0,0,0,0,0,0,0,},},},
		[578] ={{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,36,39,49,53,51,53,52,},{"Growing Inferno",0,157,163,188,198,199,211,225,},{"Effusive Anima Accelerator (Mikanikos)",249,0,0,0,0,0,0,0,},{"Repeat Decree",0,72,54,72,64,77,82,97,},{"Soul Furnace",0,55,68,67,78,67,82,88,},{"Spear of the Archon (Kleia)",26,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",251,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",156,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",47,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",35,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",134,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",40,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",97,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",85,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",8,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",103,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",83,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",-3,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,47,39,51,45,53,51,63,},{"Built for War (Draven)",128,0,0,0,0,0,0,0,},{"Soul Furnace",0,59,55,61,68,62,71,69,},{"Refined Palate (Theotar)",101,0,0,0,0,0,0,0,},{"Increased Scrutiny",0,26,22,25,33,39,25,32,},{"Party Favors (Primary) (Theotar)",78,0,0,0,0,0,0,0,},{"Growing Inferno",0,149,156,172,175,185,211,210,},{"Wasteland Propriety (Theotar)",79,0,0,0,0,0,0,0,},{"Battlefield Presence (Draven)",48,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",102,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",160,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",148,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",71,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",73,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",80,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",85,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",85,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",128,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,29,57,52,47,51,58,76,},{"Growing Inferno",0,142,157,179,180,189,205,223,},{"Wild Hunt Tactics (Korayn)",152,0,0,0,0,0,0,0,},{"Soul Furnace",0,59,54,66,69,71,80,81,},{"Dream Delver (Dreamweaver)",172,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",145,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",99,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",268,0,0,0,0,0,0,0,},{"First Strike (Korayn)",57,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",131,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",80,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",27,0,0,0,0,0,0,0,},{"Unnatural Malice",0,62,64,73,80,75,78,93,},{"Niya's Tools: Poison (Niya)",101,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",148,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,46,54,38,42,46,49,51,},{"Growing Inferno",0,156,171,184,189,200,217,212,},{"Forgeborne Reveries (Heirmir)",75,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",54,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",258,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",41,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",6,0,0,0,0,0,0,0,},{"Soul Furnace",0,47,60,68,62,80,79,77,},{"Plaguey's Preemptive Strike (Marileth)",37,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-6,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",105,0,0,0,0,0,0,0,},{"Brooding Pool",0,40,44,60,56,72,89,80,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",135,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",134,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",-7,0,0,0,0,0,0,0,},},},
		[70] ={{{"Power",1,200,213,226,239,252,265,278,},{"Ringing Clarity",0,609,663,703,765,808,844,882,},{"Virtuous Command",0,461,478,505,537,567,602,626,},{"Expurgation",0,461,501,527,560,608,623,668,},{"Effusive Anima Accelerator (Mikanikos)",250,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",5,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",14,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",106,0,0,0,0,0,0,0,},{"Truth's Wake",0,66,65,80,65,81,92,91,},{"Templar's Vindication",0,364,383,424,451,468,477,526,},{"Pointed Courage (3 Allies) (Kleia)",340,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",259,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",100,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",89,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",387,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",340,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",11,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",94,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",120,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",280,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Hallowed Discernment",0,187,190,220,214,228,242,264,},{"Virtuous Command",0,256,292,316,322,340,358,372,},{"Party Favors (Primary) (Theotar)",194,0,0,0,0,0,0,0,},{"Expurgation",0,449,501,520,558,601,625,661,},{"Wasteland Propriety (Theotar)",152,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",239,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",231,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",35,0,0,0,0,0,0,0,},{"Battlefield Presence (Draven)",65,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",196,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-7,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",86,0,0,0,0,0,0,0,},{"Truth's Wake",0,51,75,80,64,80,92,103,},{"Thrill Seeker (Nadjia)",113,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",130,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",160,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",151,0,0,0,0,0,0,0,},{"Templar's Vindication",0,314,333,360,376,426,451,466,},{"Built for War (Draven)",287,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"The Long Summer",0,119,114,137,116,119,140,132,},{"Virtuous Command",0,299,309,333,363,393,421,430,},{"Expurgation",0,501,533,584,604,633,680,721,},{"Grove Invigoration (Niya)",173,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",238,0,0,0,0,0,0,0,},{"Templar's Vindication",0,340,350,391,403,414,470,471,},{"Niya's Tools: Poison (Niya)",5,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",18,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",359,0,0,0,0,0,0,0,},{"First Strike (Korayn)",7,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",102,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",37,0,0,0,0,0,0,0,},{"Truth's Wake",0,76,70,79,82,90,74,91,},{"Niya's Tools: Herbs (Niya)",-9,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",174,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",213,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Righteous Might",0,71,66,73,83,78,82,93,},{"Virtuous Command",0,312,338,346,385,379,411,418,},{"Expurgation",0,515,528,568,607,661,669,703,},{"Lead by Example (4 Allies) (Emeni)",130,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",171,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",194,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",107,0,0,0,0,0,0,0,},{"Truth's Wake",0,95,96,110,113,108,121,118,},{"Pustule Eruption (Emeni)",34,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",390,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",71,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",38,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",122,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",93,0,0,0,0,0,0,0,},{"Templar's Vindication",0,353,393,424,437,460,477,499,},{"Gnashing Chompers (Emeni)",26,0,0,0,0,0,0,0,},},},
		[72] ={{{"Power",1,200,213,226,239,252,265,278,},{"Piercing Verdict",0,91,98,102,103,111,123,118,},{"Vicious Contempt",0,112,139,131,142,158,171,181,},{"Ashen Juggernaut",0,319,324,362,374,386,431,437,},{"Depths of Insanity",0,188,199,222,236,243,239,264,},{"Hack and Slash",0,124,135,119,146,146,159,145,},{"Effusive Anima Accelerator (Mikanikos)",287,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",31,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",183,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",511,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",264,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",73,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",118,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",254,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",149,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",239,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",174,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",19,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",162,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",54,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Harrowing Punishment",0,70,88,70,68,68,93,78,},{"Vicious Contempt",0,97,81,85,80,108,81,93,},{"Battlefield Presence (Draven)",112,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,272,277,311,333,327,371,393,},{"Depths of Insanity",0,289,325,338,359,348,377,399,},{"Hack and Slash",0,136,125,133,129,161,154,169,},{"Wasteland Propriety (Theotar)",127,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",293,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",381,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",324,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",151,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",320,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",349,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",171,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",202,0,0,0,0,0,0,0,},{"Built for War (Draven)",410,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",188,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",260,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",254,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Destructive Reverberations",0,93,121,117,129,145,142,143,},{"Vicious Contempt",0,83,131,110,133,146,149,172,},{"Ashen Juggernaut",0,286,309,340,367,368,388,424,},{"Depths of Insanity",0,165,227,230,213,225,229,261,},{"Hack and Slash",0,90,118,125,126,130,140,137,},{"Wild Hunt Tactics (Korayn)",199,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",306,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",324,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",8,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",330,0,0,0,0,0,0,0,},{"First Strike (Korayn)",68,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",179,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",127,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",20,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",266,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",319,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Veteran's Repute",0,158,179,185,212,206,215,249,},{"Vicious Contempt",0,87,114,121,141,117,153,153,},{"Ashen Juggernaut",0,292,309,318,334,363,392,409,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",214,0,0,0,0,0,0,0,},{"Hack and Slash",0,111,117,108,133,117,143,161,},{"Depths of Insanity",0,169,181,196,201,199,225,236,},{"Forgeborne Reveries (Heirmir)",193,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",5,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",213,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",23,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-11,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",186,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",128,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",63,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",77,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",96,0,0,0,0,0,0,0,},},},
		[577] ={{{"Power",1,200,213,226,239,252,265,278,},{"Repeat Decree",0,-54,-40,-53,-42,-40,-34,-33,},{"Growing Inferno",0,232,253,259,298,305,306,329,},{"Relentless Onslaught",0,289,325,346,372,382,398,439,},{"Serrated Glaive",0,-47,-74,-46,-60,-41,-65,-50,},{"Effusive Anima Accelerator (Mikanikos)",264,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",13,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",39,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",146,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",380,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",288,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",166,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",255,0,0,0,0,0,0,0,},{"Dancing with Fate",0,12,14,20,16,4,9,28,},{"Combat Meditation (50% Extend) (Pelagos)",184,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",97,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",104,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",16,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",149,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",114,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Increased Scrutiny",0,49,67,47,60,61,64,61,},{"Growing Inferno",0,236,246,276,272,284,326,328,},{"Relentless Onslaught",0,309,342,355,362,396,415,455,},{"Serrated Glaive",0,-55,-39,-31,-37,-43,-50,-27,},{"Battlefield Presence (Draven)",102,0,0,0,0,0,0,0,},{"Built for War (Draven)",312,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",192,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",101,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",275,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",138,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",267,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",230,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",151,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",248,0,0,0,0,0,0,0,},{"Dancing with Fate",0,9,19,19,11,20,0,2,},{"Thrill Seeker (Nadjia)",167,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",205,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",124,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",208,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Unnatural Malice",0,95,98,111,122,109,133,128,},{"Growing Inferno",0,224,223,259,262,290,311,322,},{"Serrated Glaive",0,-76,-46,-67,-77,-59,-74,-68,},{"Relentless Onslaught",0,300,317,322,357,384,411,447,},{"Dream Delver (Dreamweaver)",271,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",302,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",343,0,0,0,0,0,0,0,},{"Dancing with Fate",0,-14,-9,3,-18,-2,-2,1,},{"Grove Invigoration (Niya)",296,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",-12,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",397,0,0,0,0,0,0,0,},{"First Strike (Korayn)",72,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-19,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",124,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",44,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",261,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Brooding Pool",0,123,121,158,186,201,234,260,},{"Growing Inferno",0,234,235,289,297,286,306,342,},{"Relentless Onslaught",0,314,339,359,365,392,434,454,},{"Serrated Glaive",0,-57,-73,-57,-56,-59,-51,-55,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",196,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",93,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",192,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",7,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",415,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",120,0,0,0,0,0,0,0,},{"Dancing with Fate",0,2,6,9,10,8,-18,-8,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",307,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",220,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",72,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",24,0,0,0,0,0,0,0,},},},
		[104] ={{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,52,54,72,62,79,79,77,},{"Unchecked Aggression",0,159,171,185,193,208,216,239,},{"Light the Path (Kleia)",105,0,0,0,0,0,0,0,},{"Effusive Anima Accelerator (Mikanikos)",289,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",30,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",84,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",274,0,0,0,0,0,0,0,},{"Savage Combatant",0,171,184,200,202,217,229,251,},{"Better Together (Pelagos)",50,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",139,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",65,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",196,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",119,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",101,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",8,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",190,0,0,0,0,0,0,0,},{"Deep Allegiance",0,44,48,65,62,77,64,85,},{"Valiant Strikes (Kleia)",10,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,49,53,61,71,75,71,65,},{"Battlefield Presence (Draven)",56,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,199,205,226,228,251,264,277,},{"Built for War (Draven)",163,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",100,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",84,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",138,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",141,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",2,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",182,0,0,0,0,0,0,0,},{"Endless Thirst",0,114,123,139,138,147,160,163,},{"Superior Tactics (Draven)",10,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",69,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",95,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",68,0,0,0,0,0,0,0,},{"Savage Combatant",0,190,188,215,227,238,251,266,},{"Wasteland Propriety (Theotar)",90,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",154,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,57,61,69,68,67,68,76,},{"Unchecked Aggression",0,128,143,154,157,169,185,189,},{"Wild Hunt Tactics (Korayn)",187,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",169,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",147,0,0,0,0,0,0,0,},{"Savage Combatant",0,150,156,165,177,177,195,214,},{"Conflux of Elements",0,144,146,160,163,169,186,201,},{"First Strike (Korayn)",65,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",11,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",303,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",47,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",196,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-4,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",210,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",86,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,50,57,70,64,78,80,66,},{"Forgeborne Reveries (Heirmir)",104,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,175,188,193,206,225,238,252,},{"Mnemonic Equipment (Heirmir)",52,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",227,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",16,0,0,0,0,0,0,0,},{"Savage Combatant",0,158,170,168,197,214,211,229,},{"Carver's Eye (Heirmir)",6,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",57,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-10,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",49,0,0,0,0,0,0,0,},{"Evolved Swarm",0,90,104,108,106,125,112,125,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",149,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",229,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",31,0,0,0,0,0,0,0,},},},
		[265] ={{{"Power",1,200,213,226,239,252,265,278,},{"Soul Tithe",0,-10,4,-16,-12,-9,-8,-7,},{"Withering Bolt",0,584,629,662,698,746,777,818,},{"Effusive Anima Accelerator (Mikanikos)",208,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",3,0,0,0,0,0,0,0,},{"Focused Malignancy",0,136,147,161,166,198,194,195,},{"Pointed Courage (1 Ally) (Kleia)",126,0,0,0,0,0,0,0,},{"Rolling Agony",0,71,53,61,78,76,56,43,},{"Soulglow Spectrometer (Mikanikos)",256,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",63,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",81,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",125,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",188,0,0,0,0,0,0,0,},{"Corrupting Leer",0,-56,-57,-49,-42,-45,-34,-31,},{"Combat Meditation (Never Extend) (Pelagos)",119,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",5,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",146,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",214,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",43,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",382,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Catastrophic Origin",0,173,174,194,204,221,236,244,},{"Withering Bolt",0,463,499,548,576,594,626,670,},{"Corrupting Leer",0,11,10,21,4,27,17,-10,},{"Fatal Flaw (Nadjia)",108,0,0,0,0,0,0,0,},{"Rolling Agony",0,44,51,51,47,46,57,61,},{"Battlefield Presence (Draven)",82,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",240,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",148,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",196,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",252,0,0,0,0,0,0,0,},{"Focused Malignancy",0,141,165,171,171,191,194,208,},{"Dauntless Duelist (Nadjia)",241,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",63,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",227,0,0,0,0,0,0,0,},{"Built for War (Draven)",400,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",14,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",87,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",196,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",154,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Soul Eater",0,184,166,187,200,232,228,242,},{"Withering Bolt",0,542,587,618,655,695,724,767,},{"Corrupting Leer",0,6,5,3,3,-2,7,-1,},{"Rolling Agony",0,52,59,67,40,72,58,62,},{"Wild Hunt Tactics (Korayn)",254,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",431,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-9,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",343,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",1,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",365,0,0,0,0,0,0,0,},{"First Strike (Korayn)",22,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",15,0,0,0,0,0,0,0,},{"Focused Malignancy",0,150,152,182,170,186,193,202,},{"Social Butterfly (Dreamweaver)",135,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",73,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",226,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Fatal Decimation",0,154,149,157,182,198,204,194,},{"Withering Bolt",0,603,651,675,734,785,813,863,},{"Corrupting Leer",0,-110,-105,-94,-111,-104,-111,-104,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",196,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",97,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",234,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",60,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",403,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",94,0,0,0,0,0,0,0,},{"Focused Malignancy",0,113,122,137,136,157,153,159,},{"Carver's Eye (Heirmir)",10,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",85,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-4,0,0,0,0,0,0,0,},{"Rolling Agony",0,44,93,66,75,38,46,88,},{"Lead by Example (4 Allies) (Emeni)",258,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",175,0,0,0,0,0,0,0,},},},
		[103] ={{{"Power",1,200,213,226,239,252,265,278,},{"Deep Allegiance",0,-42,-4,-19,-20,-4,14,43,},{"Carnivorous Instinct",0,167,181,201,163,194,210,214,},{"Sudden Ambush",0,91,99,120,131,130,137,143,},{"Effusive Anima Accelerator (Mikanikos)",286,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",9,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",159,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",457,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",260,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",174,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",83,0,0,0,0,0,0,0,},{"Taste for Blood",0,220,237,257,287,290,312,331,},{"Incessant Hunter",0,62,55,69,73,67,66,92,},{"Combat Meditation (Always Extend) (Pelagos)",324,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",109,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",252,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",223,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",20,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",192,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",28,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Endless Thirst",0,201,211,237,228,242,266,296,},{"Carnivorous Instinct",0,173,188,180,164,207,202,194,},{"Battlefield Presence (Draven)",99,0,0,0,0,0,0,0,},{"Taste for Blood",0,254,248,257,289,320,311,336,},{"Built for War (Draven)",330,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",232,0,0,0,0,0,0,0,},{"Incessant Hunter",0,75,71,88,74,94,102,110,},{"Wasteland Propriety (Theotar)",164,0,0,0,0,0,0,0,},{"Sudden Ambush",0,125,139,129,133,146,144,158,},{"Party Favors (Crit) (Theotar)",256,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",268,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",257,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",94,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",236,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",235,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",169,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",144,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",283,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",180,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Conflux of Elements",0,235,254,255,300,289,317,337,},{"Carnivorous Instinct",0,186,190,204,204,202,232,234,},{"Taste for Blood",0,315,298,337,360,365,406,407,},{"Grove Invigoration (Niya)",465,0,0,0,0,0,0,0,},{"Sudden Ambush",0,116,115,117,142,120,145,161,},{"Incessant Hunter",0,54,66,60,70,69,79,85,},{"Dream Delver (Dreamweaver)",301,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",304,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",304,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",150,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",307,0,0,0,0,0,0,0,},{"First Strike (Korayn)",4,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",5,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",128,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",115,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",290,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Evolved Swarm",0,182,196,220,230,233,247,255,},{"Carnivorous Instinct",0,164,165,186,177,186,196,194,},{"Taste for Blood",0,227,219,228,263,275,276,283,},{"Sudden Ambush",0,132,126,146,148,149,146,173,},{"Lead by Example (4 Allies) (Emeni)",118,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",238,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",203,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",262,0,0,0,0,0,0,0,},{"Incessant Hunter",0,45,41,59,59,58,78,63,},{"Kevin's Oozeling (Marileth)",256,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",48,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",3,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",77,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-5,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",75,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",52,0,0,0,0,0,0,0,},},},
		[253] ={{{"Power",1,200,213,226,239,252,265,278,},{"Bloodletting",0,89,115,128,116,118,121,125,},{"Echoing Call",0,8,16,25,38,17,35,36,},{"Enfeebled Mark",0,190,219,241,250,272,297,321,},{"Ferocious Appetite",0,-36,-53,-27,-30,-6,17,46,},{"Valiant Strikes (Kleia)",1,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",32,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",117,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",326,0,0,0,0,0,0,0,},{"One With the Beast",0,118,128,146,152,180,204,212,},{"Soulglow Spectrometer (Mikanikos)",226,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",60,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",247,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",98,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",182,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",138,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",9,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",111,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",56,0,0,0,0,0,0,0,},{"Effusive Anima Accelerator (Mikanikos)",258,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Bloodletting",0,86,87,86,87,96,86,107,},{"Echoing Call",0,11,8,14,-1,0,13,16,},{"Empowered Release",0,412,428,424,436,443,452,494,},{"Thrill Seeker (Nadjia)",133,0,0,0,0,0,0,0,},{"Ferocious Appetite",0,35,45,40,75,79,75,85,},{"Battlefield Presence (Draven)",96,0,0,0,0,0,0,0,},{"Built for War (Draven)",319,0,0,0,0,0,0,0,},{"One With the Beast",0,132,134,162,170,186,210,236,},{"Party Favors (Primary) (Theotar)",213,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",76,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",160,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",198,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",277,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",74,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",246,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-10,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",56,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",137,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",124,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Bloodletting",0,114,119,107,112,119,126,131,},{"Echoing Call",0,41,53,40,48,49,45,58,},{"Spirit Attunement",0,150,153,188,189,179,194,212,},{"One With the Beast",0,118,131,158,174,181,205,218,},{"Wild Hunt Tactics (Korayn)",231,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",127,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",300,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",291,0,0,0,0,0,0,0,},{"Ferocious Appetite",0,23,27,42,49,60,49,68,},{"Grove Invigoration (Niya)",283,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",5,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",123,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",41,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",7,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",327,0,0,0,0,0,0,0,},{"First Strike (Korayn)",24,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Bloodletting",0,118,133,131,138,127,137,138,},{"Echoing Call",0,26,36,22,22,35,60,38,},{"Necrotic Barrage",0,56,53,68,62,77,84,89,},{"Ferocious Appetite",0,52,65,53,83,92,103,124,},{"One With the Beast",0,103,116,154,167,188,193,227,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",183,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",50,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",186,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",132,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",112,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",200,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",60,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",6,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",102,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",195,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-4,0,0,0,0,0,0,0,},},},
		[258] ={{{"Power",1,200,213,226,239,252,265,278,},{"Dissonant Echoes",0,295,305,301,330,353,354,384,},{"Rabid Shadows",0,249,278,317,321,326,356,356,},{"Effusive Anima Accelerator (Mikanikos)",349,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",3,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",69,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",163,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",484,0,0,0,0,0,0,0,},{"Courageous Ascension",0,259,270,292,309,323,272,348,},{"Haunting Apparitions",0,246,274,293,299,315,330,341,},{"Soulglow Spectrometer (Mikanikos)",274,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",126,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",117,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",431,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",137,0,0,0,0,0,0,0,},{"Mind Devourer",0,173,187,202,201,203,221,246,},{"Combat Meditation (50% Extend) (Pelagos)",362,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",298,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",172,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",3,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Dissonant Echoes",0,304,295,288,337,335,348,349,},{"Rabid Shadows",0,299,312,314,349,363,370,406,},{"Shattered Perceptions",0,89,90,81,105,98,122,102,},{"Battlefield Presence (Draven)",86,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",285,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",105,0,0,0,0,0,0,0,},{"Mind Devourer",0,184,190,187,205,217,213,233,},{"Party Favors (Crit) (Theotar)",249,0,0,0,0,0,0,0,},{"Haunting Apparitions",0,259,299,326,338,342,350,396,},{"Refined Palate (Theotar)",75,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",252,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-5,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",93,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",249,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",271,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",201,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",127,0,0,0,0,0,0,0,},{"Built for War (Draven)",451,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",331,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Dissonant Echoes",0,289,322,332,328,362,347,367,},{"Rabid Shadows",0,290,316,333,355,358,389,418,},{"Fae Fermata",0,-15,-8,4,38,20,-5,2,},{"Wild Hunt Tactics (Korayn)",266,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",260,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",371,0,0,0,0,0,0,0,},{"Haunting Apparitions",0,317,312,346,367,377,414,443,},{"Niya's Tools: Poison (Niya)",2,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",430,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",8,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",359,0,0,0,0,0,0,0,},{"First Strike (Korayn)",4,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",11,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",131,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",41,0,0,0,0,0,0,0,},{"Mind Devourer",0,187,190,199,208,207,207,244,},},{{"Power",1,200,213,226,239,252,265,278,},{"Dissonant Echoes",0,298,315,330,331,349,360,380,},{"Rabid Shadows",0,294,299,322,354,365,394,411,},{"Festering Transfusion",0,92,120,113,116,113,123,111,},{"Mind Devourer",0,179,184,204,209,206,197,229,},{"Kevin's Oozeling (Marileth)",483,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",111,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",270,0,0,0,0,0,0,0,},{"Haunting Apparitions",0,270,297,298,325,346,366,395,},{"Mnemonic Equipment (Heirmir)",80,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",271,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",72,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",43,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-11,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",288,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",214,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",106,0,0,0,0,0,0,0,},},},
		[266] ={{{"Power",1,200,213,226,239,252,265,278,},{"Soul Tithe",0,-5,-10,4,9,3,-6,4,},{"Fel Commando",0,134,153,175,178,194,209,226,},{"Borne of Blood",0,340,352,377,409,434,444,464,},{"Effusive Anima Accelerator (Mikanikos)",189,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",46,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",156,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",273,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,158,186,192,208,217,221,246,},{"Pointed Courage (3 Allies) (Kleia)",455,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",129,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",85,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",343,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",119,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",9,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,257,266,281,314,305,310,320,},{"Combat Meditation (Never Extend) (Pelagos)",182,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",279,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",39,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",121,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Catastrophic Origin",0,57,53,58,78,95,85,92,},{"Fel Commando",0,150,164,163,177,162,180,195,},{"Battlefield Presence (Draven)",76,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",187,0,0,0,0,0,0,0,},{"Borne of Blood",0,381,392,452,442,473,512,529,},{"Wasteland Propriety (Theotar)",157,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",218,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",278,0,0,0,0,0,0,0,},{"Tyrant's Soul",0,258,265,260,288,282,291,327,},{"Party Favors (Versatility) (Theotar)",233,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",237,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",79,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,167,172,192,206,230,229,242,},{"Thrill Seeker (Nadjia)",179,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",139,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",70,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",213,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",248,0,0,0,0,0,0,0,},{"Built for War (Draven)",335,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Soul Eater",0,7,1,0,-10,21,11,-5,},{"Fel Commando",0,150,158,169,171,192,211,203,},{"Borne of Blood",0,384,403,429,458,508,517,536,},{"Tyrant's Soul",0,254,254,265,289,302,299,308,},{"Carnivorous Stalkers",0,174,185,182,205,233,222,236,},{"Wild Hunt Tactics (Korayn)",431,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",48,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",671,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",120,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",74,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",249,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",3,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",717,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",-7,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",303,0,0,0,0,0,0,0,},{"First Strike (Korayn)",29,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Fatal Decimation",0,-4,4,-13,-27,-9,-4,-7,},{"Fel Commando",0,143,160,154,183,174,193,203,},{"Borne of Blood",0,367,392,416,463,474,506,552,},{"Carnivorous Stalkers",0,163,184,195,224,208,233,238,},{"Tyrant's Soul",0,239,275,268,284,271,293,289,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",374,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",12,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",427,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-14,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",599,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",27,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",39,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",233,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",288,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",87,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",180,0,0,0,0,0,0,0,},},},
		[102] ={{{"Power",1,200,213,226,239,252,265,278,},{"Deep Allegiance",0,99,96,91,103,95,112,91,},{"Umbral Intensity",0,123,120,123,132,141,161,160,},{"Stellar Inspiration",0,75,83,80,90,89,94,96,},{"Combat Meditation (50% Extend) (Pelagos)",268,0,0,0,0,0,0,0,},{"Effusive Anima Accelerator (Mikanikos)",320,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",-3,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",360,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",220,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",129,0,0,0,0,0,0,0,},{"Fury of the Skies",0,140,160,163,168,177,204,208,},{"Combat Meditation (Always Extend) (Pelagos)",300,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",113,0,0,0,0,0,0,0,},{"Precise Alignment",0,319,348,343,359,368,367,387,},{"Combat Meditation (Never Extend) (Pelagos)",239,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",5,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",125,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",31,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",82,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",119,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Endless Thirst",0,1068,1148,1227,1303,1392,1449,1541,},{"Umbral Intensity",0,126,137,141,161,182,194,182,},{"Stellar Inspiration",0,60,77,88,84,108,101,108,},{"Fury of the Skies",0,170,191,212,215,236,252,261,},{"Battlefield Presence (Draven)",74,0,0,0,0,0,0,0,},{"Precise Alignment",0,307,376,378,372,374,419,440,},{"Built for War (Draven)",434,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",258,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",241,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",211,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",270,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",35,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-27,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",91,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",152,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",40,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",244,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",225,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",243,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Conflux of Elements",0,190,194,203,232,243,255,269,},{"Umbral Intensity",0,101,144,129,132,142,142,159,},{"Stellar Inspiration",0,128,127,126,130,155,151,178,},{"Fury of the Skies",0,151,181,189,187,215,220,228,},{"Wild Hunt Tactics (Korayn)",233,0,0,0,0,0,0,0,},{"Precise Alignment",0,255,261,281,300,296,370,366,},{"Dream Delver (Dreamweaver)",220,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",242,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",4,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",412,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-17,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",90,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",98,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",-23,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",288,0,0,0,0,0,0,0,},{"First Strike (Korayn)",27,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Evolved Swarm",0,125,131,150,145,162,171,187,},{"Umbral Intensity",0,113,121,120,129,137,136,163,},{"Stellar Inspiration",0,79,99,80,96,85,98,114,},{"Fury of the Skies",0,154,156,177,168,197,189,215,},{"Precise Alignment",0,267,239,261,302,319,314,355,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",164,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",79,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",224,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",-3,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",34,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",23,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",64,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",4,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",64,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",47,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",169,0,0,0,0,0,0,0,},},},
		[63] ={{{"Power",1,200,213,226,239,252,265,278,},{"Controlled Destruction",0,199,199,222,219,244,247,275,},{"Flame Accretion",0,-53,-11,-35,-24,2,10,-7,},{"Ire of the Ascended",0,178,189,208,233,229,263,268,},{"Infernal Cascade",0,552,602,654,675,714,769,813,},{"Hammer of Genesis (Mikanikos)",-17,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",3,0,0,0,0,0,0,0,},{"Master Flame",0,-14,-7,-7,-16,-14,-10,-5,},{"Pointed Courage (3 Allies) (Kleia)",237,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",72,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",212,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",181,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",126,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",56,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",-7,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",111,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",125,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",247,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",104,0,0,0,0,0,0,0,},{"Effusive Anima Accelerator (Mikanikos)",210,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Controlled Destruction",0,211,228,232,243,283,271,291,},{"Flame Accretion",0,16,35,45,33,37,41,70,},{"Siphoned Malice",0,218,245,250,272,287,318,328,},{"Master Flame",0,-27,-2,-7,11,0,5,2,},{"Refined Palate (Theotar)",53,0,0,0,0,0,0,0,},{"Infernal Cascade",0,628,647,691,749,783,836,882,},{"Fatal Flaw (Nadjia)",67,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",122,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",104,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",96,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",217,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",152,0,0,0,0,0,0,0,},{"Battlefield Presence (Draven)",85,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",256,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",168,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",201,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",233,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",251,0,0,0,0,0,0,0,},{"Built for War (Draven)",388,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Controlled Destruction",0,212,206,233,244,262,278,289,},{"Flame Accretion",0,0,1,3,4,19,38,16,},{"Infernal Cascade",0,634,660,709,746,801,837,896,},{"Discipline of the Grove",0,185,207,214,224,259,257,269,},{"Master Flame",0,-2,-2,-4,9,-17,-21,-17,},{"Niya's Tools: Poison (Niya)",160,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",2,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",166,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",22,0,0,0,0,0,0,0,},{"First Strike (Korayn)",1,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",373,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-9,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",119,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",100,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",255,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",255,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Controlled Destruction",0,206,215,224,238,241,266,289,},{"Flame Accretion",0,-8,5,23,23,41,33,50,},{"Gift of the Lich",0,9,34,56,33,48,54,46,},{"Master Flame",0,-15,-22,-9,3,-5,-6,-1,},{"Lead by Example (4 Allies) (Emeni)",344,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",-14,0,0,0,0,0,0,0,},{"Infernal Cascade",0,612,653,702,754,784,850,886,},{"Kevin's Oozeling (Marileth)",460,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",138,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",41,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",122,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",90,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-6,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",72,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",231,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",244,0,0,0,0,0,0,0,},},},
		[259] ={{{"Power",1,200,213,226,239,252,265,278,},{"Lethal Poisons",0,136,152,156,150,176,171,176,},{"Maim, Mangle",0,117,125,107,126,125,143,140,},{"Reverberation",0,130,139,153,171,172,172,188,},{"Poisoned Katar",0,-8,-6,-7,3,-3,4,-3,},{"Well-Placed Steel",0,164,171,178,195,210,216,216,},{"Valiant Strikes (Kleia)",-1,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",39,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",261,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",85,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",201,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",468,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",104,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",19,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",90,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",178,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",86,0,0,0,0,0,0,0,},{"Effusive Anima Accelerator (Mikanikos)",249,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",153,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",142,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Lethal Poisons",0,150,159,182,177,191,203,221,},{"Maim, Mangle",0,125,129,152,145,142,187,181,},{"Lashing Scars",0,517,516,551,579,566,575,605,},{"Built for War (Draven)",366,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",204,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",130,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",308,0,0,0,0,0,0,0,},{"Poisoned Katar",0,8,3,10,4,1,-10,15,},{"Party Favors (Crit) (Theotar)",253,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",304,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",313,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",116,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,160,187,184,204,213,237,234,},{"Party Favors (Versatility) (Theotar)",261,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",215,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",167,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",164,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",247,0,0,0,0,0,0,0,},{"Battlefield Presence (Draven)",91,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Lethal Poisons",0,137,152,163,160,179,173,186,},{"Maim, Mangle",0,127,133,131,149,170,151,165,},{"Septic Shock",0,118,117,127,145,134,155,157,},{"Wild Hunt Tactics (Korayn)",257,0,0,0,0,0,0,0,},{"Poisoned Katar",0,2,26,17,21,20,27,20,},{"Well-Placed Steel",0,193,194,216,219,247,232,260,},{"Dream Delver (Dreamweaver)",284,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",416,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",323,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",249,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",132,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",359,0,0,0,0,0,0,0,},{"First Strike (Korayn)",24,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",313,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",156,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",45,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Lethal Poisons",0,130,139,172,160,160,174,195,},{"Maim, Mangle",0,112,126,117,122,136,144,147,},{"Sudden Fractures",0,138,152,158,178,195,197,196,},{"Mnemonic Equipment (Heirmir)",84,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",284,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,157,178,186,190,209,228,231,},{"Forgeborne Reveries (Heirmir)",200,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",204,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",189,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",76,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",28,0,0,0,0,0,0,0,},{"Poisoned Katar",0,12,-17,2,-15,8,4,0,},{"Plaguey's Preemptive Strike (Marileth)",93,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",191,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",149,0,0,0,0,0,0,0,},},},
		[267] ={{{"Power",1,200,213,226,239,252,265,278,},{"Soul Tithe",0,-11,7,-15,-2,-26,-28,7,},{"Infernal Brand",0,98,111,116,117,130,118,161,},{"Duplicitous Havoc",0,-6,-14,-8,-12,-2,-9,2,},{"Effusive Anima Accelerator (Mikanikos)",249,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",-14,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",27,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",116,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",415,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",237,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",99,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",256,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",137,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",197,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",85,0,0,0,0,0,0,0,},{"Ashen Remains",0,226,241,260,283,285,307,320,},{"Combat Meditation (Never Extend) (Pelagos)",142,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",17,0,0,0,0,0,0,0,},{"Combusting Engine",0,137,148,157,156,188,176,191,},{"Light the Path (Kleia)",158,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Catastrophic Origin",0,111,125,132,142,143,167,168,},{"Infernal Brand",0,107,104,101,113,142,134,141,},{"Ashen Remains",0,237,252,272,272,304,336,340,},{"Battlefield Presence (Draven)",58,0,0,0,0,0,0,0,},{"Built for War (Draven)",395,0,0,0,0,0,0,0,},{"Combusting Engine",0,137,132,166,164,170,177,189,},{"Party Favors (Primary) (Theotar)",246,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",193,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,-20,-16,-2,-24,-19,-23,-16,},{"Party Favors (Haste) (Theotar)",263,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",244,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",63,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",218,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-19,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",71,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",177,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",179,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",121,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",102,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Soul Eater",0,141,132,154,165,163,194,182,},{"Infernal Brand",0,106,109,127,131,139,138,158,},{"Duplicitous Havoc",0,-14,-6,-6,-10,4,-8,-5,},{"Niya's Tools: Poison (Niya)",-4,0,0,0,0,0,0,0,},{"Ashen Remains",0,239,260,275,299,308,336,364,},{"Wild Hunt Tactics (Korayn)",253,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",236,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",4,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",10,0,0,0,0,0,0,0,},{"First Strike (Korayn)",20,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",366,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",309,0,0,0,0,0,0,0,},{"Combusting Engine",0,148,171,162,176,201,197,208,},{"Social Butterfly (Dreamweaver)",103,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",68,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",344,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Fatal Decimation",0,135,136,164,178,183,189,200,},{"Infernal Brand",0,96,119,116,111,133,137,161,},{"Duplicitous Havoc",0,-12,-13,-13,-5,-12,-9,6,},{"Kevin's Oozeling (Marileth)",428,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",103,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",195,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",62,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",256,0,0,0,0,0,0,0,},{"Combusting Engine",0,135,154,127,178,192,183,195,},{"Pustule Eruption (Emeni)",95,0,0,0,0,0,0,0,},{"Ashen Remains",0,263,287,295,306,339,352,382,},{"Carver's Eye (Heirmir)",33,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",87,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",249,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",185,0,0,0,0,0,0,0,},},},
		[250] ={{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,49,65,65,81,84,76,82,},{"Withering Plague",0,74,85,80,103,107,117,107,},{"Effusive Anima Accelerator (Mikanikos)",243,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",26,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",90,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",264,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",165,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",132,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",44,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",129,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",63,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",110,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",10,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",95,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",4,0,0,0,0,0,0,0,},{"Debilitating Malady",0,6,12,9,8,12,10,0,},{"Combat Meditation (Never Extend) (Pelagos)",83,0,0,0,0,0,0,0,},{"Proliferation",0,149,150,154,162,167,191,189,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,56,36,45,56,53,65,73,},{"Withering Plague",0,62,72,80,82,92,99,104,},{"Party Favors (Crit) (Theotar)",117,0,0,0,0,0,0,0,},{"Impenetrable Gloom",0,18,21,29,29,33,26,29,},{"Battlefield Presence (Draven)",56,0,0,0,0,0,0,0,},{"Built for War (Draven)",156,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",99,0,0,0,0,0,0,0,},{"Debilitating Malady",0,1,5,0,-7,-2,3,1,},{"Wasteland Propriety (Theotar)",62,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",166,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",112,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",136,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",40,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",92,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",91,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",83,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",86,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",127,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,38,60,59,59,60,65,72,},{"Debilitating Malady",0,6,6,0,15,8,6,15,},{"Withering Ground",0,118,113,130,134,143,152,160,},{"Withering Plague",0,74,83,83,86,92,115,106,},{"Social Butterfly (Dreamweaver)",74,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",160,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",144,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",127,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",104,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",3,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",344,0,0,0,0,0,0,0,},{"First Strike (Korayn)",24,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",10,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",33,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",133,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,44,37,53,57,62,60,61,},{"Debilitating Malady",0,-4,-8,-3,0,6,11,9,},{"Mnemonic Equipment (Heirmir)",43,0,0,0,0,0,0,0,},{"Brutal Grasp",0,24,26,35,32,35,35,44,},{"Withering Plague",0,72,96,103,105,97,112,117,},{"Pustule Eruption (Emeni)",174,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",158,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",38,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",20,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-3,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",70,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",123,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",115,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",92,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",43,0,0,0,0,0,0,0,},},},
		[254] ={{{"Power",1,200,213,226,239,252,265,278,},{"Powerful Precision",0,109,98,150,135,154,178,162,},{"Deadly Chain",0,13,-1,5,10,-5,1,-4,},{"Valiant Strikes (Kleia)",7,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",141,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",417,0,0,0,0,0,0,0,},{"Enfeebled Mark",0,356,382,404,423,432,457,518,},{"Soulglow Spectrometer (Mikanikos)",301,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",66,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",117,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",411,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",132,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",358,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",289,0,0,0,0,0,0,0,},{"Sharpshooter's Focus",0,132,160,146,164,166,179,199,},{"Hammer of Genesis (Mikanikos)",16,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",160,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",37,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,49,52,56,54,49,68,78,},{"Effusive Anima Accelerator (Mikanikos)",300,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Powerful Precision",0,103,110,111,131,139,139,155,},{"Deadly Chain",0,-8,5,-19,-7,-4,18,12,},{"Empowered Release",0,228,246,268,257,276,274,255,},{"Thrill Seeker (Nadjia)",161,0,0,0,0,0,0,0,},{"Battlefield Presence (Draven)",101,0,0,0,0,0,0,0,},{"Built for War (Draven)",353,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",214,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",82,0,0,0,0,0,0,0,},{"Sharpshooter's Focus",0,131,112,124,124,156,153,162,},{"Party Favors (Crit) (Theotar)",224,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",265,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",289,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",85,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",269,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-8,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",115,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",212,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",158,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,26,37,26,54,57,47,70,},},{{"Power",1,200,213,226,239,252,265,278,},{"Powerful Precision",0,116,120,111,137,159,158,162,},{"Deadly Chain",0,3,-5,-2,13,2,-12,6,},{"Spirit Attunement",0,166,175,185,176,185,187,177,},{"Brutal Projectiles",0,25,34,59,56,44,60,48,},{"Sharpshooter's Focus",0,147,139,158,174,185,184,176,},{"Wild Hunt Tactics (Korayn)",337,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",290,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",414,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",283,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",470,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",-21,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",346,0,0,0,0,0,0,0,},{"First Strike (Korayn)",12,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",8,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",108,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",105,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Powerful Precision",0,108,139,136,132,165,163,175,},{"Deadly Chain",0,-10,0,-2,2,9,16,-13,},{"Necrotic Barrage",0,78,86,77,98,104,107,118,},{"Sharpshooter's Focus",0,148,153,149,144,167,163,177,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",231,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",82,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",227,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",164,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,45,56,40,63,63,56,74,},{"Kevin's Oozeling (Marileth)",253,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",41,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",95,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",233,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",153,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",13,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",75,0,0,0,0,0,0,0,},},},
		[260] ={{{"Power",1,200,213,226,239,252,265,278,},{"Count the Odds",0,459,513,532,583,606,667,693,},{"Sleight of Hand",0,116,142,142,163,181,173,182,},{"Reverberation",0,103,127,142,137,150,179,166,},{"Valiant Strikes (Kleia)",-22,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",24,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",435,0,0,0,0,0,0,0,},{"Ambidexterity",0,-1,-13,-18,-10,12,-23,-4,},{"Triple Threat",0,107,95,102,124,125,134,158,},{"Better Together (Pelagos)",61,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",143,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",126,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",87,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",116,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",181,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",135,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",203,0,0,0,0,0,0,0,},{"Effusive Anima Accelerator (Mikanikos)",318,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",279,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Count the Odds",0,487,532,562,626,673,711,720,},{"Sleight of Hand",0,178,174,161,178,200,193,199,},{"Lashing Scars",0,266,275,304,329,315,339,346,},{"Built for War (Draven)",333,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",203,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",145,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",279,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",117,0,0,0,0,0,0,0,},{"Ambidexterity",0,13,21,2,18,6,14,6,},{"Party Favors (Crit) (Theotar)",200,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",265,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",322,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",279,0,0,0,0,0,0,0,},{"Triple Threat",0,106,103,140,146,149,161,166,},{"Soothing Shade (Theotar)",178,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",167,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",130,0,0,0,0,0,0,0,},{"Battlefield Presence (Draven)",111,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",149,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Count the Odds",0,457,492,528,559,587,660,666,},{"Sleight of Hand",0,135,142,150,168,165,167,182,},{"Septic Shock",0,69,80,76,90,104,118,114,},{"Wild Hunt Tactics (Korayn)",244,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",285,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",302,0,0,0,0,0,0,0,},{"Ambidexterity",0,-17,-8,-21,-6,-26,12,-7,},{"Niya's Tools: Poison (Niya)",395,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",198,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",173,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",409,0,0,0,0,0,0,0,},{"First Strike (Korayn)",15,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",279,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",119,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",21,0,0,0,0,0,0,0,},{"Triple Threat",0,86,120,112,111,127,127,140,},},{{"Power",1,200,213,226,239,252,265,278,},{"Count the Odds",0,475,490,537,592,614,664,706,},{"Sleight of Hand",0,134,163,155,178,177,191,196,},{"Sudden Fractures",0,102,119,132,139,154,151,160,},{"Mnemonic Equipment (Heirmir)",87,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",226,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",185,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",227,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",67,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",18,0,0,0,0,0,0,0,},{"Ambidexterity",0,-2,-26,15,3,-20,11,8,},{"Triple Threat",0,85,106,107,103,133,126,138,},{"Plaguey's Preemptive Strike (Marileth)",76,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-12,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",104,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",173,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",157,0,0,0,0,0,0,0,},},},
		[71] ={{{"Power",1,200,213,226,239,252,265,278,},{"Mortal Combo",0,428,456,485,527,547,589,604,},{"Piercing Verdict",0,53,62,66,91,73,85,85,},{"Ashen Juggernaut",0,87,86,92,93,123,101,129,},{"Effusive Anima Accelerator (Mikanikos)",214,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",-10,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",18,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",148,0,0,0,0,0,0,0,},{"Crash the Ramparts",0,229,251,257,281,290,323,311,},{"Soulglow Spectrometer (Mikanikos)",262,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,-5,-2,-16,-1,6,-4,-1,},{"Better Together (Pelagos)",77,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",247,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",213,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",127,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",12,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",191,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",94,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",111,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",462,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Mortal Combo",0,420,466,475,494,548,590,610,},{"Harrowing Punishment",0,9,23,6,29,27,35,25,},{"Battlefield Presence (Draven)",92,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,83,95,98,105,116,93,120,},{"Wasteland Propriety (Theotar)",58,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,14,1,24,-1,2,7,8,},{"Party Favors (Haste) (Theotar)",320,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",85,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",279,0,0,0,0,0,0,0,},{"Crash the Ramparts",0,226,243,257,293,283,324,340,},{"Party Favors (Crit) (Theotar)",241,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",320,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",105,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",182,0,0,0,0,0,0,0,},{"Built for War (Draven)",341,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",206,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",288,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",166,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",185,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Destructive Reverberations",0,61,71,98,82,88,123,119,},{"Mortal Combo",0,457,471,502,537,562,591,626,},{"Ashen Juggernaut",0,95,99,106,120,101,117,135,},{"Merciless Bonegrinder",0,25,19,4,6,10,4,-6,},{"Wild Hunt Tactics (Korayn)",254,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",292,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",389,0,0,0,0,0,0,0,},{"Crash the Ramparts",0,236,256,283,296,317,328,343,},{"Niya's Tools: Poison (Niya)",303,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",349,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",11,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",322,0,0,0,0,0,0,0,},{"First Strike (Korayn)",53,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",10,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",136,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",49,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Mortal Combo",0,443,480,500,536,564,605,636,},{"Veteran's Repute",0,195,186,207,224,230,248,259,},{"Ashen Juggernaut",0,109,116,103,108,126,131,135,},{"Merciless Bonegrinder",0,14,10,28,20,19,16,9,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",198,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",106,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",16,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",97,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",55,0,0,0,0,0,0,0,},{"Crash the Ramparts",0,268,265,301,307,329,346,353,},{"Plaguey's Preemptive Strike (Marileth)",88,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",256,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",7,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",214,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",174,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",235,0,0,0,0,0,0,0,},},},
		[73] ={{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,54,65,63,65,81,75,86,},{"Ashen Juggernaut",0,57,72,73,85,92,78,92,},{"Piercing Verdict",0,44,53,46,59,61,74,75,},{"Effusive Anima Accelerator (Mikanikos)",199,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",29,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",94,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",264,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",157,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",127,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",35,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",118,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",69,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",98,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",71,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",5,0,0,0,0,0,0,0,},{"Show of Force",0,44,40,48,42,50,47,47,},{"Light the Path (Kleia)",92,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",4,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,46,69,57,69,61,81,97,},{"Battlefield Presence (Draven)",65,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,90,90,100,110,103,119,113,},{"Harrowing Punishment",0,12,23,28,17,15,27,36,},{"Party Favors (Crit) (Theotar)",130,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",155,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",168,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",118,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",170,0,0,0,0,0,0,0,},{"Show of Force",0,39,36,37,39,33,28,42,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",76,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",107,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",86,0,0,0,0,0,0,0,},{"Built for War (Draven)",183,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",84,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",120,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",29,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,52,61,62,55,74,77,76,},{"Ashen Juggernaut",0,65,68,79,80,85,98,90,},{"Destructive Reverberations",0,59,66,65,74,80,81,89,},{"Wild Hunt Tactics (Korayn)",148,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",170,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",156,0,0,0,0,0,0,0,},{"Show of Force",0,35,52,43,49,47,55,61,},{"Grove Invigoration (Niya)",163,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",59,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",257,0,0,0,0,0,0,0,},{"First Strike (Korayn)",28,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",2,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",89,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",29,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,57,60,69,84,78,80,76,},{"Ashen Juggernaut",0,75,85,83,83,102,98,102,},{"Mnemonic Equipment (Heirmir)",68,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",116,0,0,0,0,0,0,0,},{"Veteran's Repute",0,97,90,115,115,127,129,130,},{"Lead by Example (0 Allies) (Emeni)",47,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",22,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",53,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",175,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",2,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",118,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",80,0,0,0,0,0,0,0,},{"Show of Force",0,47,57,59,58,65,72,71,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",125,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",8,0,0,0,0,0,0,0,},},},
		[268] ={{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,54,49,51,54,70,62,59,},{"Strike with Clarity",0,116,108,118,109,117,128,130,},{"Combat Meditation (Always Extend) (Pelagos)",106,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",103,0,0,0,0,0,0,0,},{"Walk with the Ox",0,663,679,711,734,773,793,817,},{"Valiant Strikes (Kleia)",6,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",40,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",309,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",205,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",43,0,0,0,0,0,0,0,},{"Scalding Brew",0,56,52,63,57,73,68,69,},{"Combat Meditation (Never Extend) (Pelagos)",58,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",18,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",83,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",143,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",252,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",59,0,0,0,0,0,0,0,},{"Effusive Anima Accelerator (Mikanikos)",128,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,31,45,46,40,60,50,61,},{"Walk with the Ox",0,624,655,678,706,717,743,766,},{"Superior Tactics (Draven)",59,0,0,0,0,0,0,0,},{"Imbued Reflections",0,79,77,99,82,82,96,107,},{"Exacting Preparation (Nadjia)",71,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",99,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",197,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",177,0,0,0,0,0,0,0,},{"Battlefield Presence (Draven)",59,0,0,0,0,0,0,0,},{"Scalding Brew",0,37,35,42,47,49,41,59,},{"Fatal Flaw (Nadjia)",74,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",91,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",68,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",145,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",54,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",88,0,0,0,0,0,0,0,},{"Built for War (Draven)",134,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",138,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,42,43,39,50,58,65,54,},{"Scalding Brew",0,53,57,47,46,49,65,65,},{"Way of the Fae",0,28,18,24,13,33,43,19,},{"Grove Invigoration (Niya)",134,0,0,0,0,0,0,0,},{"Walk with the Ox",0,587,613,643,658,679,709,733,},{"Social Butterfly (Dreamweaver)",87,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",134,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",325,0,0,0,0,0,0,0,},{"First Strike (Korayn)",66,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",101,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",90,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",-8,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",159,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",187,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",196,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,30,49,44,52,45,52,51,},{"Lead by Example (0 Allies) (Emeni)",41,0,0,0,0,0,0,0,},{"Walk with the Ox",0,572,603,624,652,671,699,717,},{"Scalding Brew",0,32,44,38,47,62,44,62,},{"Carver's Eye (Heirmir)",-3,0,0,0,0,0,0,0,},{"Bone Marrow Hops",0,181,194,203,221,216,239,245,},{"Plaguey's Preemptive Strike (Marileth)",59,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",514,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",118,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",171,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",91,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",201,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",51,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",78,0,0,0,0,0,0,0,},},},
		[261] ={{{"Power",1,200,213,226,239,252,265,278,},{"Perforated Veins",0,178,188,195,231,230,271,269,},{"Stiletto Staccato",0,169,179,218,250,254,301,321,},{"Reverberation",0,155,170,182,191,196,201,210,},{"Effusive Anima Accelerator (Mikanikos)",182,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",13,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",54,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",148,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",422,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",279,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",68,0,0,0,0,0,0,0,},{"Deeper Daggers",0,251,252,275,284,274,317,340,},{"Planned Execution",0,177,184,201,215,222,244,250,},{"Combat Meditation (50% Extend) (Pelagos)",150,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",102,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",15,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",113,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",164,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",163,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",195,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Perforated Veins",0,176,170,196,222,239,248,264,},{"Stiletto Staccato",0,250,304,312,320,296,306,326,},{"Lashing Scars",0,524,539,551,573,593,630,650,},{"Deeper Daggers",0,263,294,304,319,335,346,369,},{"Planned Execution",0,174,178,192,188,229,242,244,},{"Battlefield Presence (Draven)",112,0,0,0,0,0,0,0,},{"Built for War (Draven)",341,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",146,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",257,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",163,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",215,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",295,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",101,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",254,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",150,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",159,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",149,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",217,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",257,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Perforated Veins",0,181,172,200,200,228,219,247,},{"Stiletto Staccato",0,150,164,177,191,237,262,321,},{"Septic Shock",0,110,112,116,124,142,156,169,},{"Wild Hunt Tactics (Korayn)",253,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",283,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",305,0,0,0,0,0,0,0,},{"Planned Execution",0,174,177,209,204,234,242,252,},{"Grove Invigoration (Niya)",222,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",172,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",322,0,0,0,0,0,0,0,},{"First Strike (Korayn)",-11,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",281,0,0,0,0,0,0,0,},{"Deeper Daggers",0,214,227,256,266,290,309,309,},{"Social Butterfly (Dreamweaver)",129,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",264,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",46,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Perforated Veins",0,164,165,166,182,224,238,226,},{"Stiletto Staccato",0,156,181,183,213,232,274,292,},{"Sudden Fractures",0,74,110,103,123,107,116,128,},{"Mnemonic Equipment (Heirmir)",83,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",216,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",190,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",160,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",284,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",68,0,0,0,0,0,0,0,},{"Deeper Daggers",0,228,237,248,263,283,287,295,},{"Planned Execution",0,155,165,205,189,200,220,239,},{"Carver's Eye (Heirmir)",-5,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",52,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-22,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",143,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",185,0,0,0,0,0,0,0,},},},
		[269] ={{{"Power",1,200,213,226,239,252,265,278,},{"Strike with Clarity",0,121,129,120,122,127,131,132,},{"Xuen's Bond",0,112,138,134,153,153,161,177,},{"Inner Fury",0,89,72,82,73,85,96,82,},{"Effusive Anima Accelerator (Mikanikos)",204,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",27,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",128,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",394,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",247,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",188,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",66,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",272,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",232,0,0,0,0,0,0,0,},{"Calculated Strikes",0,2,-6,2,-14,-13,-12,6,},{"Coordinated Offensive",0,349,360,373,406,419,453,481,},{"Hammer of Genesis (Mikanikos)",-11,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",135,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",77,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",7,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",172,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Imbued Reflections",0,138,144,165,186,186,209,217,},{"Xuen's Bond",0,133,163,149,180,177,180,180,},{"Inner Fury",0,63,76,97,80,92,95,93,},{"Battlefield Presence (Draven)",120,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,262,289,304,307,339,346,363,},{"Built for War (Draven)",265,0,0,0,0,0,0,0,},{"Calculated Strikes",0,11,0,14,5,1,15,-1,},{"Party Favors (Primary) (Theotar)",163,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",123,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",180,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",175,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",239,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",63,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",200,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",218,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",95,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",107,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",124,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",75,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Way of the Fae",0,23,32,24,30,26,42,42,},{"Xuen's Bond",0,136,150,175,177,181,181,196,},{"Inner Fury",0,81,72,77,89,95,93,131,},{"Wild Hunt Tactics (Korayn)",262,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,256,259,298,301,317,351,365,},{"Dream Delver (Dreamweaver)",198,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",322,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",267,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",313,0,0,0,0,0,0,0,},{"Calculated Strikes",0,14,2,4,5,-14,-11,9,},{"Wild Hunt Strategem (Korayn)",119,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",283,0,0,0,0,0,0,0,},{"First Strike (Korayn)",73,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",214,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",103,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",68,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Bone Marrow Hops",0,254,270,270,305,317,332,330,},{"Xuen's Bond",0,130,130,145,149,150,174,178,},{"Inner Fury",0,83,105,91,99,92,116,121,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",293,0,0,0,0,0,0,0,},{"Mnemonic Equipment (Heirmir)",72,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",250,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",441,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",92,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",25,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,303,312,332,335,370,392,408,},{"Plaguey's Preemptive Strike (Marileth)",132,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",14,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",224,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",161,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",158,0,0,0,0,0,0,0,},{"Calculated Strikes",0,22,19,12,19,13,-3,-8,},},},
		[251] ={{{"Power",1,200,213,226,239,252,265,278,},{"Proliferation",0,152,156,180,162,183,186,194,},{"Unleashed Frenzy",0,268,292,317,340,357,372,378,},{"Accelerated Cold",0,194,210,253,293,317,328,342,},{"Effusive Anima Accelerator (Mikanikos)",251,0,0,0,0,0,0,0,},{"Everfrost",0,299,345,353,366,389,426,447,},{"Pointed Courage (1 Ally) (Kleia)",180,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",518,0,0,0,0,0,0,0,},{"Eradicating Blow",0,130,134,141,155,157,168,178,},{"Bron's Call to Action (Mikanikos)",88,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",102,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",375,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",130,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",286,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",61,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",197,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",22,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",177,0,0,0,0,0,0,0,},{"Spear of the Archon (Kleia)",49,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",289,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Impenetrable Gloom",0,19,6,15,32,24,31,38,},{"Unleashed Frenzy",0,244,267,284,301,328,343,374,},{"Battlefield Presence (Draven)",95,0,0,0,0,0,0,0,},{"Eradicating Blow",0,113,106,112,130,143,139,157,},{"Everfrost",0,282,309,333,371,360,396,410,},{"Wasteland Propriety (Theotar)",94,0,0,0,0,0,0,0,},{"Party Favors (Crit) (Theotar)",239,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",226,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",248,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",84,0,0,0,0,0,0,0,},{"Built for War (Draven)",350,0,0,0,0,0,0,0,},{"Accelerated Cold",0,174,176,227,210,262,285,282,},{"Party Favors (Versatility) (Theotar)",236,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",227,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",431,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",187,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",142,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",210,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",167,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Withering Ground",0,41,35,62,62,73,66,72,},{"Unleashed Frenzy",0,264,277,316,310,333,357,381,},{"Accelerated Cold",0,188,211,234,260,291,312,334,},{"Wild Hunt Tactics (Korayn)",273,0,0,0,0,0,0,0,},{"Eradicating Blow",0,129,134,144,154,170,162,166,},{"Everfrost",0,321,336,343,367,397,416,457,},{"Field of Blossoms (Dreamweaver)",129,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",328,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",191,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",8,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",330,0,0,0,0,0,0,0,},{"First Strike (Korayn)",16,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",3,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",137,0,0,0,0,0,0,0,},{"Bonded Hearts (Niya)",28,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",263,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Brutal Grasp",0,30,27,45,36,28,41,47,},{"Unleashed Frenzy",0,233,277,265,303,321,331,354,},{"Accelerated Cold",0,164,191,221,213,280,283,301,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",245,0,0,0,0,0,0,0,},{"Everfrost",0,289,323,327,356,374,409,430,},{"Eradicating Blow",0,92,114,113,120,125,140,138,},{"Mnemonic Equipment (Heirmir)",68,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",221,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",199,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",250,0,0,0,0,0,0,0,},{"Lead by Example (0 Allies) (Emeni)",119,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",36,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",118,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",296,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",202,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},},},
		[66] ={{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,52,55,66,60,73,79,75,},{"Vengeful Shock",0,104,104,118,116,130,135,143,},{"Punish the Guilty",0,117,131,141,157,173,185,189,},{"Spear of the Archon (Kleia)",11,0,0,0,0,0,0,0,},{"Pointed Courage (3 Allies) (Kleia)",269,0,0,0,0,0,0,0,},{"Soulglow Spectrometer (Mikanikos)",176,0,0,0,0,0,0,0,},{"Ringing Clarity",0,118,140,135,135,162,169,184,},{"Bron's Call to Action (Mikanikos)",243,0,0,0,0,0,0,0,},{"Combat Meditation (Always Extend) (Pelagos)",154,0,0,0,0,0,0,0,},{"Newfound Resolve (Pelagos)",61,0,0,0,0,0,0,0,},{"Combat Meditation (50% Extend) (Pelagos)",115,0,0,0,0,0,0,0,},{"Better Together (Pelagos)",35,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},{"Valiant Strikes (Kleia)",-13,0,0,0,0,0,0,0,},{"Light the Path (Kleia)",116,0,0,0,0,0,0,0,},{"Pointed Courage (1 Ally) (Kleia)",80,0,0,0,0,0,0,0,},{"Effusive Anima Accelerator (Mikanikos)",249,0,0,0,0,0,0,0,},{"Combat Meditation (Never Extend) (Pelagos)",73,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,85,92,82,92,87,94,104,},{"Vengeful Shock",0,107,116,117,145,143,142,166,},{"Soothing Shade (Theotar)",137,0,0,0,0,0,0,0,},{"Punish the Guilty",0,126,145,153,159,162,182,189,},{"Battlefield Presence (Draven)",74,0,0,0,0,0,0,0,},{"Built for War (Draven)",253,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",149,0,0,0,0,0,0,0,},{"Hallowed Discernment",0,261,274,285,315,330,342,361,},{"Party Favors (Crit) (Theotar)",161,0,0,0,0,0,0,0,},{"Party Favors (Haste) (Theotar)",255,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",97,0,0,0,0,0,0,0,},{"Party Favors (Versatility) (Theotar)",192,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-20,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",78,0,0,0,0,0,0,0,},{"Fatal Flaw (Nadjia)",109,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",124,0,0,0,0,0,0,0,},{"Party Favors (Primary) (Theotar)",150,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",228,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,67,77,74,89,80,81,110,},{"Wild Hunt Tactics (Korayn)",191,0,0,0,0,0,0,0,},{"Dream Delver (Dreamweaver)",201,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",219,0,0,0,0,0,0,0,},{"Punish the Guilty",0,133,151,161,170,177,187,181,},{"Vengeful Shock",0,112,108,110,122,131,144,151,},{"The Long Summer",0,44,54,59,54,63,67,75,},{"Bonded Hearts (Niya)",29,0,0,0,0,0,0,0,},{"Wild Hunt Strategem (Korayn)",43,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",399,0,0,0,0,0,0,0,},{"First Strike (Korayn)",22,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",15,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",100,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-8,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",186,0,0,0,0,0,0,0,},},{{"Power",1,200,213,226,239,252,265,278,},{"Adaptive Armor Fragment",0,68,76,90,100,86,93,102,},{"Punish the Guilty",0,135,153,156,187,172,192,205,},{"Vengeful Shock",0,109,108,115,128,128,137,139,},{"Mnemonic Equipment (Heirmir)",71,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",146,0,0,0,0,0,0,0,},{"Kevin's Oozeling (Marileth)",312,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",85,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",5,0,0,0,0,0,0,0,},{"Lead by Example (4 Allies) (Emeni)",103,0,0,0,0,0,0,0,},{"Lead by Example (2 Allies) (Emeni)",66,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",170,0,0,0,0,0,0,0,},{"Carver's Eye (Heirmir)",16,0,0,0,0,0,0,0,},{"Righteous Might",0,66,81,70,73,93,86,97,},{"Lead by Example (0 Allies) (Emeni)",43,0,0,0,0,0,0,0,},{"Pustule Eruption (Emeni)",-4,0,0,0,0,0,0,0,},},},
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
		[255] ={5389,5592,5456,5425,},
		[262] ={6103,6105,6262,6258,},
		[62] ={6419,6003,5614,5820,},
		[263] ={6465,6494,6630,6597,},
		[64] ={5817,6032,5697,5868,},
		[252] ={6157,6201,6152,6236,},
		[578] ={3380,3408,3489,3411,},
		[70] ={5716,5975,5749,5891,},
		[72] ={5842,6221,5864,5779,},
		[577] ={5728,5970,5882,5926,},
		[104] ={3441,3456,3616,3835,},
		[265] ={5794,5642,5783,5572,},
		[103] ={5963,5905,6333,6124,},
		[253] ={5748,5910,5890,5792,},
		[258] ={6567,6724,6742,6781,},
		[266] ={5404,5388,5456,5543,},
		[102] ={6004,5962,6083,6185,},
		[63] ={5728,5795,5769,5654,},
		[259] ={6482,6722,6497,6694,},
		[267] ={5702,5689,5794,5935,},
		[250] ={3531,3458,3463,3466,},
		[254] ={5785,5927,5836,5873,},
		[260] ={6232,6237,6068,6219,},
		[71] ={5515,6159,5577,5443,},
		[73] ={3618,3897,3638,3534,},
		[268] ={3899,3759,3691,3776,},
		[261] ={6303,6289,6142,6269,},
		[269] ={6030,5600,5627,5601,},
		[251] ={6218,6203,6167,6209,},
		[66] ={4408,4891,4628,4563,},
	},
	["T27"]={
		[255] ={9337,9376,9319,9451,},
		[262] ={9201,9141,9407,9362,},
		[62] ={8383,9045,8728,8066,},
		[263] ={9656,9676,9833,9799,},
		[64] ={8519,8881,8360,8607,},
		[252] ={9315,9398,9335,9439,},
		[578] ={5656,5661,5751,5637,},
		[70] ={8341,8170,7855,8055,},
		[72] ={8630,10354,8597,8500,},
		[577] ={9094,9387,9402,9488,},
		[104] ={6390,6200,6491,6774,},
		[265] ={8349,8011,8545,8286,},
		[103] ={8794,8660,9256,9026,},
		[253] ={8274,9200,8467,8432,},
		[258] ={9156,9407,9304,9490,},
		[266] ={9057,9043,9003,9009,},
		[102] ={7368,9064,7512,7604,},
		[63] ={8636,8939,8720,8564,},
		[259] ={9142,9899,9100,9480,},
		[267] ={8669,8583,8753,8966,},
		[250] ={5623,5519,5547,5525,},
		[254] ={9240,9471,9180,9255,},
		[260] ={9799,9846,9515,9893,},
		[71] ={9427,9438,9454,9266,},
		[73] ={5580,5808,5547,5401,},
		[268] ={7103,6644,6583,6776,},
		[261] ={9903,10421,9728,9968,},
		[269] ={9277,8630,8628,8676,},
		[251] ={9180,9050,9113,9143,},
		[66] ={6603,7404,6960,6836,},
	},
}

CovenantForge.Soulbinds ={
	[336472] = "Shivering Core",
	[352786] = "Dream Delver",
	[326514] = "Forgeborne Reveries",
	[336852] = "Master Flame",
	[352186] = "Soulglow Spectrometer",
	[326512] = "Runeforged Spurs",
	[322721] = "Grove Invigoration",
	[337162] = "Depths of Insanity",
	[331612] = "Sparkling Driftglobe Core",
	[352805] = "Wild Hunt Strategem",
	[328258] = "Ever Forward",
	[352782] = "Cunning Dreams",
	[339377] = "Harmony of the Tortollan",
	[328265] = "Bond of Friendship",
	[338516] = "Debilitating Malady",
	[339558] = "Cheetah's Vigor",
	[339129] = "Necrotic Barrage",
	[352110] = "Kevin's Oozeling",
	[341532] = "Fade to Nothing",
	[341450] = "Front of the Pack",
	[336821] = "Infernal Cascade",
	[338329] = "Embrace of Earth",
	[336239] = "Soothing Shade",
	[331610] = "Charged Additive",
	[338787] = "Shielding Words",
	[352109] = "Undulating Maneuvers",
	[347213] = "Fueled by Violence",
	[351747] = "It's Always Tea Time",
	[338342] = "Dissonant Echoes",
	[340041] = "Infernal Brand",
	[338332] = "Mind Devourer",
	[336773] = "Jade Bond",
	[339228] = "Dancing with Fate",
	[351147] = "Path of the Devoted",
	[340268] = "Fatal Decimation",
	[339182] = "Elysian Dirge",
	[352365] = "Regenerative Stone Skin",
	[337891] = "Swift Penitence",
	[336569] = "Ice Bite",
	[339973] = "Deadly Chain",
	[331611] = "Soulsteel Clamps",
	[320662] = "Niya's Tools: Herbs",
	[350935] = "Waking Bone Breastplate",
	[339411] = "Demonic Momentum",
	[340033] = "Powerful Precision",
	[340348] = "Soul Eater",
	[337134] = "Celestial Effervescence",
	[337240] = "Artifice of the Archmage",
	[329779] = "Bearer's Pursuit",
	[337058] = "Ire of the Ascended",
	[339268] = "Light's Barding",
	[325069] = "First Strike",
	[340543] = "Innate Resolve",
	[337286] = "Strike with Clarity",
	[337301] = "Imbued Reflections",
	[339924] = "Brutal Projectiles",
	[341650] = "Emeni's Ambulatory Flesh",
	[351489] = "Hope Springs Eternal",
	[339231] = "Growing Inferno",
	[351750] = "Party Favors",
	[351146] = "Better Together",
	[337264] = "Walk with the Ox",
	[336999] = "Gift of the Lich",
	[331576] = "Agent of Chaos",
	[341446] = "Conflux of Elements",
	[331586] = "Thrill Seeker",
	[329791] = "Valiant Strikes",
	[319211] = "Soothing Voice",
	[352502] = "Survivor's Rally",
	[339186] = "Tumbling Waves",
	[341440] = "Bloodletting",
	[332756] = "Expedition Leader",
	[325068] = "Face Your Foes",
	[338345] = "Holy Oration",
	[341447] = "Evolved Swarm",
	[319210] = "Social Butterfly",
	[323095] = "Ultimate Form",
	[325072] = "Vorkai Sharpening Techniques",
	[339712] = "Resplendent Light",
	[336379] = "Harm Denial",
	[336140] = "Watch the Shoes!",
	[340218] = "Ringing Clarity",
	[320660] = "Niya's Tools: Poison",
	[339578] = "Borne of Blood",
	[337790] = "Exaltation",
	[341537] = "Well-Placed Steel",
	[329781] = "Resonant Accolades",
	[357888] = "Condensed Anima Sphere",
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
	[351149] = "Newfound Resolve",
	[351094] = "Pustule Eruption",
	[357902] = "Adaptive Armor Fragment",
	[337678] = "Move with Grace",
	[336452] = "Inner Fury",
	[338033] = "Thunderous Paws",
	[341399] = "Flame Infusion",
	[352417] = "Battlefield Presence",
	[320659] = "Niya's Tools: Burrs",
	[336616] = "Xuen's Bond",
	[339890] = "Duplicitous Havoc",
	[339292] = "Wrench Evil",
	[352501] = "Called Shot",
	[341344] = "Withering Ground",
	[352800] = "Vorkai Ambush",
	[338799] = "Felfire Haste",
	[339576] = "Withering Bolt",
	[338651] = "Brutal Grasp",
	[336613] = "Winter's Protection",
	[338303] = "Call of Flame",
	[340553] = "Well-Honed Instincts",
	[339370] = "Harrowing Punishment",
	[337981] = "Vital Accretion",
	[338682] = "Viscous Ink",
	[320668] = "Nature's Splendor",
	[338338] = "Rabid Shadows",
	[341543] = "Sleight of Hand",
	[336147] = "Leisurely Gait",
	[339939] = "Destructive Reverberations",
	[339518] = "Virtuous Command",
	[339265] = "Veteran's Repute",
	[340006] = "Vengeful Shock",
	[340540] = "Ursine Vigor",
	[339987] = "Untempered Dedication",
	[340159] = "Service In Stone",
	[338318] = "Unruly Winds",
	[337295] = "Bone Marrow Hops",
	[336460] = "Unrelenting Cold",
	[337154] = "Unnerving Focus",
	[344358] = "Unnatural Malice",
	[338492] = "Unleashed Frenzy",
	[340012] = "Punish the Guilty",
	[332753] = "Superior Tactics",
	[336890] = "Dizzying Tumble",
	[319214] = "Faerie Dust",
	[341546] = "Count the Odds",
	[336636] = "Flow of Time",
	[341378] = "Deep Allegiance",
	[341549] = "Deeper Daggers",
	[352415] = "Intimidation Tactics",
	[325073] = "Get In Formation",
	[337811] = "Lasting Spirit",
	[341451] = "Born of the Wilds",
	[340552] = "Unchecked Aggression",
	[323921] = "Emeni's Magnificent Skin",
	[325601] = "Hold the Line",
	[319191] = "Field of Blossoms",
	[352187] = "Reactive Retrofitting",
	[326507] = "Resourceful Fleshcrafting",
	[339845] = "Fel Commando",
	[337084] = "Tumbling Technique",
	[339374] = "Truth's Wake",
	[337778] = "Shining Radiance",
	[341311] = "Nimble Fingers",
	[352188] = "Effusive Anima Accelerator",
	[346747] = "Ambuscade",
	[341540] = "Triple Threat",
	[337662] = "Translucent Image",
	[337764] = "Reinforced Shell",
	[340550] = "Ready for Anything",
	[352108] = "Viscous Trail",
	[340545] = "Tireless Pursuit",
	[338054] = "Crippling Hex",
	[340185] = "The Long Summer",
	[339531] = "Templar's Vindication",
	[340682] = "Taste for Blood",
	[339259] = "Piercing Verdict",
	[338339] = "Swirling Currents",
	[334066] = "Mentorship",
	[339920] = "Sharpshooter's Focus",
	[335250] = "Cacophonous Roar",
	[323916] = "Sulfuric Emission",
	[337078] = "Swift Transference",
	[339948] = "Disturb the Peace",
	[341309] = "Septic Shock",
	[331579] = "Friends in Low Places",
	[341222] = "Strength of the Pack",
	[338319] = "Haunting Apparitions",
	[340605] = "Layered Mane",
	[341559] = "Stiletto Staccato",
	[334993] = "Stalwart Guardian",
	[338048] = "Spiritual Resonance",
	[352779] = "Waking Dreams",
	[328266] = "Combat Meditation",
	[337705] = "Spirit Drain",
	[341542] = "Ambidexterity",
	[340229] = "Soul Tithe",
	[337250] = "Evasive Stride",
	[339423] = "Soul Furnace",
	[337087] = "Siphoned Malice",
	[338628] = "Impenetrable Gloom",
	[340028] = "Increased Scrutiny",
	[337980] = "Embrace Death",
	[341556] = "Planned Execution",
	[339481] = "Rolling Agony",
	[338042] = "Totemic Surge",
	[339230] = "Serrated Glaive",
	[340694] = "Sudden Ambush",
	[337099] = "Rising Sun Revival",
	[337119] = "Scalding Brew",
	[339984] = "Focused Light",
	[336247] = "Life of the Party",
	[58081] = "Kilrogg's Cunning",
	[338089] = "Fleeting Wind",
	[339386] = "Mortal Combo",
	[339818] = "Show of Force",
	[335196] = "Safeguard",
	[341534] = "Rushed Setup",
	[339124] = "Pure Concentration",
	[340030] = "Royal Decree",
	[339495] = "Reversal of Fortune",
	[338252] = "Shake the Foundations",
	[329786] = "Road of Trials",
	[323090] = "Plaguey's Preemptive Strike",
	[339587] = "Demon Muzzle",
	[341531] = "Quick Decisions",
	[329784] = "Cleansing Rites",
	[320658] = "Stay on the Move",
	[337822] = "Accelerated Cold",
	[336853] = "Fortifying Ingredients",
	[319213] = "Empowered Chrysalis",
	[336632] = "Grounding Breath",
	[337947] = "Resonant Words",
	[337979] = "Festering Transfusion",
	[338741] = "Divine Call",
	[338331] = "Magma Fist",
	[352503] = "Bonded Hearts",
	[335260] = "Merciless Bonegrinder",
	[339272] = "Resolute Barrier",
	[337241] = "Nourishing Chi",
	[339459] = "Resilience of the Hunter",
	[339895] = "Repeat Decree",
	[339151] = "Relentless Onslaught",
	[339399] = "Rejuvenating Wind",
	[340529] = "Tough as Bark",
	[336245] = "Token of Appreciation",
	[336526] = "Calculated Strikes",
	[333950] = "Bron's Call to Action",
	[336777] = "Grounding Surge",
	[337974] = "Refreshing Waters",
	[331577] = "Fancy Footwork",
	[331609] = "Forgelite Filter",
	[337224] = "Flame Accretion",
	[341312] = "Recuperator",
	[341529] = "Cloaked in Shadows",
	[339379] = "Shade of Terror",
	[338835] = "Ravenous Consumption",
	[339644] = "Roaring Fire",
	[345594] = "Pyroclastic Shock",
	[338566] = "Lingering Plague",
	[341383] = "Endless Thirst",
	[340212] = "Hallowed Discernment",
	[328263] = "Cleansed Vestments",
	[340706] = "Precise Alignment",
	[338343] = "Heavy Rainfall",
	[320687] = "Swift Patrol",
	[341350] = "Deadly Tandem",
	[337966] = "Courageous Ascension",
	[337762] = "Power Unto Others",
	[341536] = "Poisoned Katar",
	[338315] = "Shattered Perceptions",
	[339651] = "Tactical Retreat",
	[332754] = "Hold Your Ground",
	[352373] = "Fatal Flaw",
	[342270] = "Run Without Tiring",
	[341567] = "Perforated Veins",
	[337786] = "Pain Transformation",
	[340705] = "Carnivorous Instinct",
	[336886] = "Nether Precision",
	[339371] = "Expurgation",
	[339185] = "Lavish Harvest",
	[339048] = "Demonic Parole",
	[341538] = "Maim, Mangle",
	[339264] = "Marksman's Advantage",
	[337748] = "Light's Inspiration",
	[340023] = "Resolute Defender",
	[323081] = "Plagueborn Cleansing Slime",
	[319978] = "Enduring Gloom",
	[337192] = "Magi's Brand",
	[339149] = "Lost in Darkness",
	[336884] = "Lingering Numbness",
	[336191] = "Indelible Victory",
	[341539] = "Lethal Poisons",
	[341310] = "Lashing Scars",
	[340616] = "Flash of Clarity",
	[338330] = "Insatiable Appetite",
	[337275] = "Incantation of Swiftness",
	[351491] = "Light the Path",
	[339896] = "Combusting Engine",
	[340609] = "Savage Combatant",
	[340876] = "Echoing Call",
	[323079] = "Kevin's Keyring",
	[336522] = "Icy Propulsion",
	[351748] = "Life is but an Appetizer",
	[337715] = "Charitable Soul",
	[339455] = "Corrupting Leer",
	[319973] = "Built for War",
	[339704] = "Ferocious Appetite",
	[325065] = "Wild Hunt's Charge",
	[337934] = "Eradicating Blow",
	[338325] = "Chilled to the Core",
	[338793] = "Shattered Restoration",
	[339766] = "Tyrant's Soul",
	[336184] = "Exquisite Ingredients",
	[319216] = "Somnambulist",
	[340621] = "Floral Recycling",
	[351488] = "Spear of the Archon",
	[352806] = "Hunt's Exhilaration",
	[340316] = "Catastrophic Origin",
	[341246] = "Stinging Strike",
	[337303] = "Way of the Fae",
	[352366] = "Nimble Steps",
	[338305] = "Fae Fermata",
	[331580] = "Exacting Preparation",
	[335242] = "Crash the Ramparts",
	[341280] = "Born Anew",
	[341535] = "Prepared for All",
	[337214] = "Hack and Slash",
	[337988] = "Everfrost",
	[339130] = "Fel Celerity",
	[332755] = "Unbreakable Body",
	[337964] = "Astral Protection",
	[351093] = "Resilient Stitching",
	[337381] = "Eternal Hunger",
	[325066] = "Wild Hunt Tactics",
	[338322] = "Focused Lightning",
	[329778] = "Pointed Courage",
	[326513] = "Bonesmith's Satchel",
	[341264] = "Reverberation",
	[326504] = "Serrated Spaulders",
	[337136] = "Diverted Energy",
	[331584] = "Dauntless Duelist",
	[350936] = "Mnemonic Equipment",
	[331582] = "Familiar Predicaments",
	[339500] = "Focused Malignancy",
	[337707] = "Clear Mind",
	[339109] = "Spirit Attunement",
	[339750] = "One With the Beast",
	[339570] = "Enkindled Spirit",
	[350899] = "Carver's Eye",
	[335034] = "Inspiring Presence",
	[319983] = "Wasteland Propriety",
	[329777] = "Phial of Patience",
	[325067] = "Horn of the Wild Hunt",
	[323089] = "Travel with Bloop",
	[338671] = "Fel Defender",
	[336243] = "Refined Palate",
	[338311] = "Unending Grip",
	[326572] = "Heirmir's Arsenal: Marrowed Gemstone",
	[340063] = "Brooding Pool",
	[329776] = "Ascendant Phial",
	[324440] = "Cartilaginous Legs",
	[338553] = "Convocation of the Dead",
	[323091] = "Ooz's Frictionless Coating",
	[323918] = "Gristled Toes",
	[336873] = "Arcane Prodigy",
	[337914] = "Focused Mending",
	[323919] = "Gnashing Chompers",
	[319217] = "Podtender",
	[339656] = "Carnivorous Stalkers",
	[339018] = "Enfeebled Mark",
	[339059] = "Empowered Release",
	[339892] = "Ashen Remains",
	[339316] = "Echoing Blessings",
	[352405] = "Sinful Preservation",
	[336992] = "Discipline of the Grove",
	[336598] = "Coordinated Offensive",
	[341325] = "Controlled Destruction",
	[323074] = "Volatile Solvent",
	[340708] = "Fury of the Skies",
	[351089] = "Sole Slough",
	[328261] = "Focusing Mantra",
	[339282] = "Accrued Vitality",
	[340192] = "Righteous Might",
	[331725] = "Resilient Plumage",
	[328257] = "Let Go of the Past",
	[335010] = "Brutal Vitality",
	[335232] = "Ashen Juggernaut",
	[326511] = "Heirmir's Arsenal: Gorestompers",
	[337704] = "Chilled Resilience",
	[319982] = "Move As One",
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
			name = "选项",
			type = "group",
			inline = false,
			order = 0,
			args = {
				Options_Header = {
					order = 1,
					name = "常规选项",
					type = "header",
					width = "full",
				},
				
				ShowSoulbindNames = {
					order = 3,
					name = "显示羁绊名称",
					type = "toggle",
					width = "full",
					arg = "ShowSoulbindNames",
				},

				ShowNodeNames = {
					order = 3.1,
					name = "显示节点名称",
					type = "toggle",
					width = "full",
					arg = "ShowNodeNames",
				},
				ShowWeights = {
					order = 4,
					name = "显示评分",
					type = "toggle",
					width = "full",
					arg = "ShowWeights",
				},
				HideZeroValues = {
					order = 5,
					name = "隐藏0评分的项",
					type = "toggle",
					width = "full",
					arg = "ShowWeights",
				},

				ShowAsPercent = {
					order = 4,
					name = "评分显示为百分比",
					type = "toggle",
					width = "full",
					arg = "ShowAsPercent",
				},

				disableFX = {
					order = 5.1,
					name = "禁用FX",
					width = "full",
					type = "toggle",
				},

				ShowTooltipRank = {
					order = 6,
					name = "提示中显示羁绊等级",
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
	options.args.weights.name = "评分"
	LibStub("AceConfigRegistry-3.0"):ValidateOptionsTable(options, "CovenantForge")
	LibStub("AceConfig-3.0"):RegisterOptionsTable("CovenantForge", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("CovenantForge", CovenantForgeLocal)
	--self.db.RegisterCallback(OmegaMap, "OnProfileChanged", "RefreshConfig")
	--self.db.RegisterCallback(OmegaMap, "OnProfileCopied", "RefreshConfig")
	--self.db.RegisterCallback(OmegaMap, "OnProfileReset", "RefreshConfig")



	CovenantForge:RegisterEvent("ADDON_LOADED", "EventHandler" )
	CovenantForge:RegisterEvent("PLAYER_LEVEL_UP", "EventHandler" )

end

function CovenantForge:EventHandler(event, arg1 )
	if event == "ADDON_LOADED" and arg1 == "Blizzard_Soulbinds" and C_Covenants.GetActiveCovenantID() ~= 0 and UnitLevel("player") == 60 then 
		C_Timer.After(0, function() CovenantForge.Init:CreateSoulbindFrames() end)

		self:SecureHook(SoulbindViewer, "Open", function()  C_Timer.After(.05, function() CovenantForge:Update() end) end , true)
			--CovenantForge:Hook(ConduitListConduitButtonMixin, "Init", "ConduitRank", true)
		self:SecureHook(SoulbindViewer, "SetSheenAnimationsPlaying", "StopAnimationFX")
		self:SecureHook(SoulbindTreeNodeLinkMixin, "SetState", "StopNodeFX")
		self:UnregisterEvent("ADDON_LOADED")
	elseif (event == "COVENANT_CHOSEN" and UnitLevel("player") == 60) or (event == "PLAYER_LEVEL_UP" and arg1 == 60 and C_Covenants.GetActiveCovenantID() ~= 0) then
		if C_AddOns.IsAddOnLoaded("Blizzard_Soulbinds") then 
			C_Timer.After(0, function() CovenantForge.Init:CreateSoulbindFrames() end)

			self:SecureHook(SoulbindViewer, "Open", function()  C_Timer.After(.05, function() CovenantForge:Update() end) end , true)
				--CovenantForge:Hook(ConduitListConduitButtonMixin, "Init", "ConduitRank", true)
			self:SecureHook(SoulbindViewer, "SetSheenAnimationsPlaying", "StopAnimationFX")
			self:SecureHook(SoulbindTreeNodeLinkMixin, "SetState", "StopNodeFX")
			self:UnregisterEvent("ADDON_LOADED")
		else
			CovenantForge:EventHandler("ADDON_LOADED", "Blizzard_Soulbinds")
			CovenantForge:OnEnable()
			self:UnregisterEvent("ADDON_LOADED")
			self:UnregisterEvent("PLAYER_LEVEL_UP")
		end
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

	for buttonIndex, nodeFrame in ipairs(SoulbindViewer.Tree:GetNodes()) do
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
	DefaultsTab.tooltip = "现有导灵器"
	DefaultsTab:Show()
	DefaultsTab.TabardEmblem:SetTexture("Interface/ICONS/Ability_Monk_EssenceFont")
	DefaultsTab.tabIndex = 1
	DefaultsTab:SetChecked(true)
	table.insert(CovenantForge.PathStorageFrame.TabList ,DefaultsTab )


	local PathTab = CreateFrame("CheckButton", "$parentTab2", SoulbindViewer, "CovenantForge_TabTemplate", 1)
   -- PathTab:SetSize(50,50)
	PathTab:SetPoint("TOPRIGHT", DefaultsTab, "BOTTOMRIGHT", 0, -20)
	PathTab.tooltip = "保存配置"
	PathTab:Show()
	PathTab.TabardEmblem:SetTexture("Interface/ICONS/Ability_Druid_FocusedGrowth")
	PathTab.tabIndex = 2
	table.insert(CovenantForge.PathStorageFrame.TabList,PathTab )

	local ConduitTab = CreateFrame("CheckButton", "$parentTab3", SoulbindViewer, "CovenantForge_TabTemplate", 1)
   -- PathTab:SetSize(50,50)
	ConduitTab:SetPoint("TOPRIGHT", PathTab, "BOTTOMRIGHT", 0, -20)
	ConduitTab.tooltip = "可用导灵器"
	ConduitTab:Show()
	ConduitTab.TabardEmblem:SetTexture("Interface/ICONS/70_inscription_steamy_romance_novel_kit")
	ConduitTab.tabIndex = 3
	table.insert(CovenantForge.PathStorageFrame.TabList,ConduitTab )

	local WeightsTab = CreateFrame("CheckButton", "$parentTab4", SoulbindViewer, "CovenantForge_TabTemplate", 1)
   -- PathTab:SetSize(50,50)
	WeightsTab:SetPoint("TOPRIGHT", ConduitTab, "BOTTOMRIGHT", 0, -20)
	WeightsTab.tooltip = "评分"
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
		CovenantForge.PathStorageFrame.Title:SetText("保存配置")
		CovenantForge:UpdateSavedPathsList()
	elseif currentTab == 3 then
		CovenantForge.PathStorageFrame:Show()
		SoulbindViewer.ConduitList:Hide()
		CovenantForge.PathStorageFrame.EditBox:Hide()
		CovenantForge.PathStorageFrame.CreateButton:Hide()
		CovenantForge.PathStorageFrame.Title:SetText("导灵器")
		CovenantForge:UpdateConduitList()
	elseif currentTab == 4 then
		CovenantForge.PathStorageFrame:Show()
		SoulbindViewer.ConduitList:Hide()
		CovenantForge.PathStorageFrame.EditBox:Hide()
		CovenantForge.PathStorageFrame.CreateButton:Hide()
		CovenantForge.PathStorageFrame.Title:SetText("评分")
		CovenantForge:UpdateWeightList()
	end
end

local filterValue = 1
local filteredList = CovenantForge.conduitList
function CovenantForge:UpdateConduitList()
	if not SoulbindViewer or (SoulbindViewer and not SoulbindViewer:IsShown()) or
 		not CovenantForge.scrollcontainer then return end

 	local filter = {"全部", 	Soulbinds.GetConduitName(0),Soulbinds.GetConduitName(1),Soulbinds.GetConduitName(2), "羁绊"}

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
					local name = C_Spell.GetSpellInfo(spellID) or data[1]
					local type = Soulbinds.GetConduitName(data[3])
					local desc = GetSpellDescription(spellID)
					local _,_, icon = C_Spell.GetSpellInfo(spellID)
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
		label:SetText("羁绊")

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
				local name = soulbind_data.name..": "..C_Spell.GetSpellInfo(spellID) or ""
				local desc = GetSpellDescription(spellID)
				local _,_, icon = C_Spell.GetSpellInfo(spellID)
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
				name = C_Spell.GetSpellInfo(spellID)
				--local rank = conduit:GetConduitRank()
				--local itemLevel = C_Soulbinds.GetConduitItemLevel(conduitID, rank)
				weight = CovenantForge:GetConduitWeight(CovenantForge.viewed_spec, conduitID)
			else
				name = ""
			end
		else
			local spellID =  nodeFrame.spell:GetSpellID()
			name = C_Spell.GetSpellInfo(spellID) or ""
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




	for conduitType, conduitData in SoulbindViewer.ConduitList.ScrollBox:EnumerateFrames() do
		for conduitButton in conduitData.pool:EnumerateActive() do
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
				_,_, icon = C_Spell.GetSpellInfo(spellID)
				--else
				--_, _, icon = C_Spell.GetSpellInfo(node.spellID)
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
				local name = C_Spell.GetSpellInfo(spellID)
				--local desc = GetSpellDescription(spellID)
				local colormarkup = DARKYELLOW_FONT_COLOR:GenerateHexColorMarkup()
				GameTooltip:AddLine(string.format(colormarkup.."Row %d: |r%s - Rank:%s |cffffffff(%s)|r",i, name, collectionData.conduitRank,Soulbinds.GetConduitName(collectionData.conduitType)), unpack({ITEM_QUALITY_COLORS[quality].color:GetRGB()}))
				--GameTooltip:AddLine(string.format("Rank:%s", collectionData.conduitRank, unpack({ITEM_QUALITY_COLORS[quality].color:GetRGB()})))
				--GameTooltip:AddLine(desc, nil, nil, nil, true)
				--GameTooltip:AddLine(" ")
			else
				local spellID = pathEntry.spellID
				local name = C_Spell.GetSpellInfo(spellID)
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
		local name = C_Spell.GetSpellInfo(spellID)
		--local desc = GetSpellDescription(spellID)
		local colormarkup = DARKYELLOW_FONT_COLOR:GenerateHexColorMarkup()
		GameTooltip:SetConduit(data.conduitID, collectionData.conduitRank)
		CovenantForge:ConduitTooltip_Rank(GameTooltip, collectionData.conduitRank, data.row + 1)
	else
		local spellID = data.spellID
		local name = C_Spell.GetSpellInfo(spellID)
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
		UpdateButton:SetCallback("OnEnter", function() GameTooltip:SetOwner(UpdateButton.frame, "ANCHOR_RIGHT"); GameTooltip:AddLine("选项"); GameTooltip:Show() end)
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
				local _,_, icon = C_Spell.GetSpellInfo(spellID)
				nodeIcon:SetImage(icon)
			else
				local _,_, icon = C_Spell.GetSpellInfo(data.spellID)
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

 	local filter = {"全部", 	Soulbinds.GetConduitName(0),Soulbinds.GetConduitName(1),Soulbinds.GetConduitName(2), "羁绊"}
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
			local name = C_Spell.GetSpellInfo(spellID) or data[1]
			local type = Soulbinds.GetConduitName(data[3])
			local desc = GetSpellDescription(spellID)
			local _,_, icon = C_Spell.GetSpellInfo(spellID)
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
		label:SetText("羁绊")

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
				local spellname = C_Spell.GetSpellInfo(spellID)
				local name = soulbind_data.name..": "..spellname or ""
				local desc = GetSpellDescription(spellID)
				local _,_, icon = C_Spell.GetSpellInfo(spellID)
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