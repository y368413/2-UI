_G["BINDING_HEADER_COVENANTFORGE"] = "CovenantForge"
_G["BINDING_NAME_COVENANTFORGE_BINDING_TOGGLE_SOULBINDS"] = "    Toggle Soulbind Viewer"
local CovenantForge = {}
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

CovenantForge.Weights ={
	["Pre Raid"]={
		[255] ={{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-5,-5,-5,-3,-5,-7,-11,},{"Strength of the Pack",0,43,39,53,58,66,76,78,},{"Enfeebled Mark",0,58,63,71,82,83,93,98,},{"Pointed Courage (Kleia)",135,0,0,0,0,0,0,0,},{"Stinging Strike",0,38,37,38,51,45,51,62,},{"Deadly Tandem",0,21,21,21,28,35,34,35,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",60,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",72,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,2,1,-2,-2,4,2,-3,},{"Strength of the Pack",0,43,52,58,59,67,77,82,},{"Stinging Strike",0,37,39,42,41,50,51,52,},{"Deadly Tandem",0,22,27,27,35,40,40,44,},{"Empowered Release",0,44,45,47,41,49,43,45,},{"Built for War (Draven)",110,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",107,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",79,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",69,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",51,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-4,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",10,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",37,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-3,5,2,0,3,-5,4,},{"Spirit Attunement",0,65,72,66,70,77,77,71,},{"Deadly Tandem",0,23,30,33,33,36,40,35,},{"Stinging Strike",0,37,41,43,50,57,55,67,},{"Strength of the Pack",0,50,54,61,75,73,84,92,},{"Wild Hunt Tactics (Korayn)",87,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",4,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",125,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",182,0,0,0,0,0,0,0,},{"First Strike (Korayn)",27,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",3,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",55,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",90,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,3,2,0,-3,3,4,2,},{"Strength of the Pack",0,46,50,56,67,69,76,82,},{"Stinging Strike",0,37,42,49,56,59,60,58,},{"Deadly Tandem",0,29,27,35,39,44,45,50,},{"Necrotic Barrage",0,9,13,15,17,22,21,23,},{"Forgeborne Reveries (Heirmir)",90,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",13,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",27,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",75,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",66,0,0,0,0,0,0,0,},},},
		[262] ={{{"Power",1,145,158,171,184,200,213,226,},{"Pyroclastic Shock",0,31,38,41,43,47,52,61,},{"High Voltage",0,13,15,14,22,23,24,23,},{"Shake the Foundations",0,4,2,9,10,1,4,4,},{"Elysian Dirge",0,40,35,40,40,42,47,42,},{"Combat Meditation (Pelagos)",89,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",10,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",45,0,0,0,0,0,0,0,},{"Call of Flame",0,68,65,72,78,73,76,79,},{"Pointed Courage (Kleia)",148,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,8,11,5,10,10,3,8,},{"High Voltage",0,12,13,24,15,11,10,17,},{"Shake the Foundations",0,1,9,-4,9,6,2,1,},{"Pyroclastic Shock",0,34,40,40,44,46,45,48,},{"Call of Flame",0,64,73,73,76,77,80,76,},{"Built for War (Draven)",150,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",113,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",71,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",75,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",34,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",5,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",29,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",82,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,27,28,29,36,43,28,36,},{"Pyroclastic Shock",0,33,32,40,41,39,48,53,},{"High Voltage",0,13,15,13,12,16,9,8,},{"Social Butterfly (Dreamweaver)",54,0,0,0,0,0,0,0,},{"Shake the Foundations",0,0,-2,0,0,-8,4,0,},{"Field of Blossoms (Dreamweaver)",90,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",164,0,0,0,0,0,0,0,},{"First Strike (Korayn)",8,0,0,0,0,0,0,0,},{"Call of Flame",0,65,65,69,71,64,67,78,},{"Grove Invigoration (Niya)",107,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",6,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",1,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",112,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,27,24,27,30,32,46,38,},{"High Voltage",0,17,23,22,27,25,19,29,},{"Pyroclastic Shock",0,32,34,37,42,43,43,48,},{"Shake the Foundations",0,4,5,3,10,9,8,9,},{"Gnashing Chompers (Emeni)",4,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",87,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",28,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",85,0,0,0,0,0,0,0,},{"Call of Flame",0,83,84,80,85,86,85,86,},{"Forgeborne Reveries (Heirmir)",128,0,0,0,0,0,0,0,},},},
		[62] ={{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,10,2,10,15,9,9,4,},{"Ire of the Ascended",0,58,70,76,88,86,99,100,},{"Pointed Courage (Kleia)",172,0,0,0,0,0,0,0,},{"Nether Precision",0,23,23,22,28,29,36,32,},{"Arcane Prodigy",0,26,32,28,21,66,63,65,},{"Combat Meditation (Pelagos)",97,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",14,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",39,0,0,0,0,0,0,0,},{"Magi's Brand",0,63,75,88,93,96,104,109,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,4,3,12,3,4,10,3,},{"Magi's Brand",0,74,77,86,93,102,108,111,},{"Nether Precision",0,22,30,29,36,40,39,43,},{"Superior Tactics (Draven)",4,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",11,0,0,0,0,0,0,0,},{"Arcane Prodigy",0,50,38,46,50,83,84,82,},{"Siphoned Malice",0,71,59,67,75,80,87,98,},{"Thrill Seeker (Nadjia)",50,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",51,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",71,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",93,0,0,0,0,0,0,0,},{"Built for War (Draven)",155,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",118,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,1,7,2,-2,7,-10,-1,},{"Magi's Brand",0,78,84,80,89,102,101,122,},{"Nether Precision",0,12,20,25,25,28,35,37,},{"Discipline of the Grove",0,37,51,50,79,87,89,101,},{"Niya's Tools: Herbs (Niya)",-8,0,0,0,0,0,0,0,},{"Arcane Prodigy",0,36,31,35,31,31,34,26,},{"Niya's Tools: Poison (Niya)",-3,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",158,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",138,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",61,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",28,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",62,0,0,0,0,0,0,0,},{"First Strike (Korayn)",0,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Artifice of the Archmage",0,4,8,1,8,6,10,11,},{"Gift of the Lich",0,45,42,51,49,60,58,61,},{"Nether Precision",0,26,24,33,34,39,41,38,},{"Arcane Prodigy",0,36,45,45,36,76,85,78,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",118,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",116,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",133,0,0,0,0,0,0,0,},{"Magi's Brand",0,75,76,84,88,90,103,111,},},},
		[263] ={{{"Power",1,145,158,171,184,200,213,226,},{"Chilled to the Core",0,15,17,14,26,13,14,29,},{"Unruly Winds",0,30,31,34,26,41,30,42,},{"Bron's Call to Action (Mikanikos)",89,0,0,0,0,0,0,0,},{"Elysian Dirge",0,16,28,31,31,33,36,45,},{"Magma Fist",0,20,25,18,18,17,24,16,},{"Combat Meditation (Pelagos)",115,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Focused Lightning",0,10,25,28,40,41,52,55,},{"Pointed Courage (Kleia)",159,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,16,23,20,17,17,22,24,},{"Chilled to the Core",0,24,37,29,27,33,36,30,},{"Magma Fist",0,27,21,24,24,22,29,29,},{"Refined Palate (Theotar)",95,0,0,0,0,0,0,0,},{"Unruly Winds",0,48,33,41,54,48,41,50,},{"Focused Lightning",0,33,38,41,49,59,58,63,},{"Wasteland Propriety (Theotar)",51,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",113,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",94,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",89,0,0,0,0,0,0,0,},{"Built for War (Draven)",134,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",35,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,23,11,20,27,29,19,30,},{"Chilled to the Core",0,28,21,21,22,26,27,32,},{"Niya's Tools: Burrs (Niya)",179,0,0,0,0,0,0,0,},{"First Strike (Korayn)",44,0,0,0,0,0,0,0,},{"Magma Fist",0,32,32,24,26,24,30,24,},{"Grove Invigoration (Niya)",184,0,0,0,0,0,0,0,},{"Unruly Winds",0,47,45,37,40,42,48,55,},{"Wild Hunt Tactics (Korayn)",116,0,0,0,0,0,0,0,},{"Focused Lightning",0,28,30,33,47,51,52,68,},{"Niya's Tools: Poison (Niya)",9,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",6,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",122,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",66,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,19,17,25,23,22,21,28,},{"Chilled to the Core",0,26,23,26,26,29,26,28,},{"Unruly Winds",0,33,38,42,46,34,47,39,},{"Forgeborne Reveries (Heirmir)",109,0,0,0,0,0,0,0,},{"Magma Fist",0,23,21,18,25,26,26,22,},{"Plaguey's Preemptive Strike (Marileth)",25,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",63,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",92,0,0,0,0,0,0,0,},{"Focused Lightning",0,18,28,40,43,52,45,62,},},},
		[64] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ire of the Ascended",0,51,63,67,74,72,86,89,},{"Unrelenting Cold",0,29,32,26,28,35,34,38,},{"Pointed Courage (Kleia)",130,0,0,0,0,0,0,0,},{"Shivering Core",0,2,-2,1,4,5,7,3,},{"Ice Bite",0,70,66,74,81,94,98,115,},{"Combat Meditation (Pelagos)",76,0,0,0,0,0,0,0,},{"Icy Propulsion",0,171,185,206,229,248,276,293,},{"Bron's Call to Action (Mikanikos)",44,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",9,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Siphoned Malice",0,64,65,74,78,86,86,99,},{"Unrelenting Cold",0,38,35,40,42,43,46,48,},{"Shivering Core",0,3,-1,12,3,6,12,11,},{"Ice Bite",0,76,84,97,101,112,114,119,},{"Built for War (Draven)",133,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",120,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",57,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",73,0,0,0,0,0,0,0,},{"Icy Propulsion",0,191,211,238,263,295,320,347,},{"Soothing Shade (Theotar)",73,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",4,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",29,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",59,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Discipline of the Grove",0,1,5,3,2,-4,-3,0,},{"Unrelenting Cold",0,28,27,34,37,38,36,43,},{"Shivering Core",0,0,4,2,3,8,2,-2,},{"Ice Bite",0,65,76,82,86,94,100,106,},{"Wild Hunt Tactics (Korayn)",121,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Icy Propulsion",0,176,198,223,241,271,292,318,},{"Field of Blossoms (Dreamweaver)",0,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",0,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",36,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",190,0,0,0,0,0,0,0,},{"First Strike (Korayn)",19,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Gift of the Lich",0,22,33,22,25,30,36,33,},{"Unrelenting Cold",0,23,29,32,34,36,38,39,},{"Forgeborne Reveries (Heirmir)",97,0,0,0,0,0,0,0,},{"Ice Bite",0,63,65,76,84,90,97,103,},{"Shivering Core",0,-1,-6,4,-6,0,-2,1,},{"Icy Propulsion",0,165,188,209,235,259,282,304,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",101,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",39,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",25,0,0,0,0,0,0,0,},},},
		[66] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,38,48,50,60,64,62,68,},{"Punish the Guilty",0,47,52,56,59,56,69,74,},{"Vengeful Shock",0,31,36,41,43,47,51,55,},{"Combat Meditation (Pelagos)",87,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",107,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",19,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",106,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,80,90,99,101,113,114,122,},{"Punish the Guilty",0,49,59,54,60,70,69,73,},{"Vengeful Shock",0,10,20,22,31,29,34,47,},{"Built for War (Draven)",95,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-6,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",9,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",52,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",103,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",72,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",86,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",60,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,-2,2,-2,-4,-2,-1,-1,},{"Punish the Guilty",0,47,56,55,61,64,68,74,},{"Vengeful Shock",0,29,31,34,38,41,45,49,},{"Wild Hunt Tactics (Korayn)",93,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",7,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",-5,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",14,0,0,0,0,0,0,0,},{"First Strike (Korayn)",35,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",177,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-3,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",46,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,28,30,33,37,35,35,45,},{"Punish the Guilty",0,53,55,61,62,69,69,82,},{"Vengeful Shock",0,30,33,41,41,49,42,49,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",72,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",25,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",10,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",38,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",68,0,0,0,0,0,0,0,},},},
		[256] ={{{"Power",1,145,158,171,184,200,213,226,},{"Courageous Ascension",0,49,56,60,61,66,69,77,},{"Exaltation",0,-4,-1,-1,-1,-1,0,0,},{"Swift Penitence",0,27,30,32,41,36,40,44,},{"Pain Transformation",0,2,-1,-2,2,1,3,2,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",79,0,0,0,0,0,0,0,},{"Shining Radiance",0,-1,0,-1,0,4,1,2,},{"Combat Meditation (Pelagos)",-1,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",51,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Shattered Perceptions",0,4,2,3,2,4,4,3,},{"Swift Penitence",0,29,36,36,44,45,51,54,},{"Refined Palate (Theotar)",4,0,0,0,0,0,0,0,},{"Exaltation",0,4,0,6,2,5,3,3,},{"Wasteland Propriety (Theotar)",6,0,0,0,0,0,0,0,},{"Pain Transformation",0,2,2,5,3,2,1,3,},{"Shining Radiance",0,3,2,4,6,2,0,4,},{"Built for War (Draven)",64,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",13,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",3,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",57,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",31,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",5,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fae Fermata",0,2,-1,5,2,2,-1,2,},{"Swift Penitence",0,33,37,36,40,43,47,50,},{"Exaltation",0,2,3,1,5,4,0,3,},{"Wild Hunt Tactics (Korayn)",46,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",2,0,0,0,0,0,0,0,},{"Pain Transformation",0,4,4,3,1,4,4,2,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Shining Radiance",0,2,2,4,2,1,1,3,},{"Niya's Tools: Burrs (Niya)",196,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",3,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",28,0,0,0,0,0,0,0,},{"First Strike (Korayn)",15,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Festering Transfusion",0,1,2,3,2,3,1,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},{"Exaltation",0,3,2,1,2,2,-1,3,},{"Swift Penitence",0,30,36,38,45,42,47,52,},{"Pain Transformation",0,4,2,2,1,2,2,4,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",35,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",50,0,0,0,0,0,0,0,},{"Shining Radiance",0,0,5,1,2,4,5,3,},{"Lead by Example (Emeni)",2,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",5,0,0,0,0,0,0,0,},},},
		[70] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,98,114,119,126,145,153,167,},{"Truth's Wake",0,23,25,20,28,29,32,26,},{"Combat Meditation (Pelagos)",130,0,0,0,0,0,0,0,},{"Templar's Vindication",0,126,136,165,169,189,190,209,},{"Expurgation",0,92,97,108,119,124,133,139,},{"Virtuous Command",0,125,130,151,157,176,185,195,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",151,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",64,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,75,83,96,110,110,112,126,},{"Truth's Wake",0,28,27,20,28,24,32,31,},{"Expurgation",0,89,100,102,117,122,133,140,},{"Dauntless Duelist (Nadjia)",105,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",66,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",76,0,0,0,0,0,0,0,},{"Templar's Vindication",0,133,150,158,176,178,197,198,},{"Virtuous Command",0,114,124,136,147,159,171,184,},{"Soothing Shade (Theotar)",84,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",10,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",23,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",95,0,0,0,0,0,0,0,},{"Built for War (Draven)",112,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,22,16,22,21,24,29,32,},{"Truth's Wake",0,15,14,14,15,17,18,24,},{"Expurgation",0,85,94,98,109,119,119,137,},{"Virtuous Command",0,114,122,142,144,160,171,181,},{"Social Butterfly (Dreamweaver)",43,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",113,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-3,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",76,0,0,0,0,0,0,0,},{"Templar's Vindication",0,133,142,152,171,184,197,207,},{"Niya's Tools: Burrs (Niya)",173,0,0,0,0,0,0,0,},{"First Strike (Korayn)",18,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-7,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",119,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,13,13,11,10,12,21,15,},{"Truth's Wake",0,9,16,24,22,24,27,24,},{"Templar's Vindication",0,119,135,146,156,163,182,193,},{"Expurgation",0,85,95,96,108,113,121,135,},{"Plaguey's Preemptive Strike (Marileth)",11,0,0,0,0,0,0,0,},{"Virtuous Command",0,103,109,124,134,143,149,159,},{"Forgeborne Reveries (Heirmir)",74,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",63,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",39,0,0,0,0,0,0,0,},},},
		[72] ={{{"Power",1,145,158,171,184,200,213,226,},{"Piercing Verdict",0,18,27,33,29,37,32,36,},{"Depths of Insanity",0,37,43,43,44,47,50,49,},{"Vicious Contempt",0,26,21,23,30,38,33,42,},{"Ashen Juggernaut",0,68,76,79,89,94,101,113,},{"Combat Meditation (Pelagos)",104,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",144,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",67,0,0,0,0,0,0,0,},{"Hack and Slash",0,24,18,29,27,33,33,28,},},{{"Power",1,145,158,171,184,200,213,226,},{"Harrowing Punishment",0,11,13,16,16,15,14,24,},{"Depths of Insanity",0,30,33,44,45,-797,50,47,},{"Refined Palate (Theotar)",106,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,65,72,77,85,100,102,108,},{"Dauntless Duelist (Nadjia)",98,0,0,0,0,0,0,0,},{"Vicious Contempt",0,27,23,35,34,30,-789,40,},{"Thrill Seeker (Nadjia)",92,0,0,0,0,0,0,0,},{"Hack and Slash",0,23,13,23,27,19,27,33,},{"Soothing Shade (Theotar)",84,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",24,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-845,0,0,0,0,0,0,0,},{"Built for War (Draven)",107,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,18,17,22,25,30,34,34,},{"Ashen Juggernaut",0,71,82,82,97,100,109,112,},{"Grove Invigoration (Niya)",131,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",88,0,0,0,0,0,0,0,},{"Depths of Insanity",0,40,45,48,49,56,53,59,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Vicious Contempt",0,28,29,27,39,35,45,48,},{"Field of Blossoms (Dreamweaver)",90,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",170,0,0,0,0,0,0,0,},{"First Strike (Korayn)",24,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",3,0,0,0,0,0,0,0,},{"Hack and Slash",0,27,17,29,31,26,31,34,},{"Social Butterfly (Dreamweaver)",48,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Veteran's Repute",0,43,56,55,67,57,63,71,},{"Depths of Insanity",0,39,44,46,48,53,51,57,},{"Ashen Juggernaut",0,71,78,89,91,102,116,119,},{"Forgeborne Reveries (Heirmir)",74,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-3,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",-1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",14,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",83,0,0,0,0,0,0,0,},{"Vicious Contempt",0,31,27,31,32,36,42,40,},{"Hack and Slash",0,31,24,29,29,33,36,35,},},},
		[578] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,46,43,51,55,59,61,66,},{"Soul Furnace",0,18,25,19,25,26,32,35,},{"Bron's Call to Action (Mikanikos)",45,0,0,0,0,0,0,0,},{"Growing Inferno",0,27,24,28,30,37,34,40,},{"Combat Meditation (Pelagos)",77,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",98,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,21,23,24,28,30,29,27,},{"Soul Furnace",0,14,21,25,19,24,29,30,},{"Exacting Preparation (Nadjia)",17,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",31,0,0,0,0,0,0,0,},{"Growing Inferno",0,23,24,27,34,32,36,37,},{"Soothing Shade (Theotar)",40,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",42,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",61,0,0,0,0,0,0,0,},{"Built for War (Draven)",64,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",37,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",100,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,33,33,33,36,42,48,51,},{"Soul Furnace",0,17,24,27,25,25,26,31,},{"Grove Invigoration (Niya)",73,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",35,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",75,0,0,0,0,0,0,0,},{"First Strike (Korayn)",37,0,0,0,0,0,0,0,},{"Growing Inferno",0,26,26,28,37,34,40,40,},{"Niya's Tools: Burrs (Niya)",153,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",54,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",51,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",69,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,0,7,6,14,16,17,18,},{"Soul Furnace",0,11,15,24,20,25,25,27,},{"Growing Inferno",0,23,24,27,29,32,34,37,},{"Plaguey's Preemptive Strike (Marileth)",12,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",30,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",0,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",48,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",43,0,0,0,0,0,0,0,},},},
		[265] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,7,-5,-7,-4,-3,2,4,},{"Corrupting Leer",0,15,15,19,18,19,30,18,},{"Cold Embrace",0,93,97,108,114,132,128,142,},{"Rolling Agony",0,28,28,29,22,32,23,24,},{"Pointed Courage (Kleia)",161,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",149,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",11,0,0,0,0,0,0,0,},{"Focused Malignancy",0,154,156,181,188,218,229,243,},{"Bron's Call to Action (Mikanikos)",30,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,45,47,49,56,55,58,62,},{"Corrupting Leer",0,-42,-35,-42,-35,-36,-22,-22,},{"Focused Malignancy",0,126,139,148,164,174,185,200,},{"Cold Embrace",0,86,94,98,112,114,124,125,},{"Rolling Agony",0,13,16,19,17,24,18,20,},{"Thrill Seeker (Nadjia)",86,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",51,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",104,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",96,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",8,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",47,0,0,0,0,0,0,0,},{"Built for War (Draven)",137,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,44,53,63,66,66,77,81,},{"Corrupting Leer",0,-1,-5,-5,-3,0,5,-2,},{"Cold Embrace",0,94,100,106,119,119,132,148,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Focused Malignancy",0,141,149,171,184,196,209,216,},{"Field of Blossoms (Dreamweaver)",104,0,0,0,0,0,0,0,},{"Rolling Agony",0,11,20,13,18,18,14,17,},{"Niya's Tools: Burrs (Niya)",185,0,0,0,0,0,0,0,},{"First Strike (Korayn)",0,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",4,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",56,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",145,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",114,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,47,52,59,69,69,18,83,},{"Corrupting Leer",0,9,12,10,22,26,25,23,},{"Cold Embrace",0,92,91,104,111,122,123,131,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",54,0,0,0,0,0,0,0,},{"Rolling Agony",0,21,21,6,2,6,8,20,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",86,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",107,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",23,0,0,0,0,0,0,0,},{"Focused Malignancy",0,127,147,156,161,178,186,202,},},},
		[577] ={{{"Power",1,145,158,171,184,200,213,226,},{"Repeat Decree",0,15,25,28,31,40,38,39,},{"Relentless Onslaught",0,49,57,62,65,75,86,76,},{"Serrated Glaive",0,2,3,5,5,3,3,4,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Dancing with Fate",0,4,7,16,7,13,7,9,},{"Growing Inferno",0,66,74,79,82,87,95,103,},{"Combat Meditation (Pelagos)",72,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",125,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",79,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Increased Scrutiny",0,-10,-7,0,-11,-5,-7,-2,},{"Growing Inferno",0,55,70,72,87,83,93,101,},{"Relentless Onslaught",0,45,49,57,61,71,76,81,},{"Serrated Glaive",0,1,0,0,-1,1,2,3,},{"Dancing with Fate",0,-1,0,-1,9,10,10,8,},{"Refined Palate (Theotar)",128,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",41,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",13,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",2,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",104,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",67,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",45,0,0,0,0,0,0,0,},{"Built for War (Draven)",104,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Unnatural Malice",0,32,25,36,33,37,42,39,},{"Growing Inferno",0,59,64,73,78,92,94,104,},{"Niya's Tools: Herbs (Niya)",-3,0,0,0,0,0,0,0,},{"Relentless Onslaught",0,46,49,49,65,73,70,77,},{"Niya's Tools: Poison (Niya)",-2,0,0,0,0,0,0,0,},{"Dancing with Fate",0,10,-1,4,7,2,7,7,},{"Serrated Glaive",0,-3,6,13,1,4,6,4,},{"Niya's Tools: Burrs (Niya)",187,0,0,0,0,0,0,0,},{"First Strike (Korayn)",17,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",35,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",73,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",97,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",113,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brooding Pool",0,8,14,24,36,42,51,60,},{"Relentless Onslaught",0,51,56,67,65,77,82,87,},{"Growing Inferno",0,74,71,83,82,94,104,113,},{"Gnashing Chompers (Emeni)",-2,0,0,0,0,0,0,0,},{"Dancing with Fate",0,6,9,1,10,10,7,17,},{"Serrated Glaive",0,8,7,7,5,8,11,4,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",114,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",56,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",79,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},},},
		[253] ={{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,28,27,28,28,27,32,42,},{"Ferocious Appetite",0,-7,-5,1,1,13,14,10,},{"One With the Beast",0,17,31,37,39,50,59,64,},{"Enfeebled Mark",0,84,90,90,104,114,123,121,},{"Hammer of Genesis (Mikanikos)",13,0,0,0,0,0,0,0,},{"Echoing Call",0,5,-6,1,2,1,-3,3,},{"Combat Meditation (Pelagos)",122,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",51,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",128,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,13,18,19,24,20,25,20,},{"Empowered Release",0,20,25,18,25,21,20,25,},{"Ferocious Appetite",0,-9,-5,-4,-7,8,5,3,},{"Echoing Call",0,0,2,-8,-7,-5,-3,-3,},{"One With the Beast",0,15,18,26,36,41,45,61,},{"Built for War (Draven)",110,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",115,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",65,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",60,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-7,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",-1,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",34,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",55,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,33,46,36,39,40,47,42,},{"Ferocious Appetite",0,-20,-20,-12,-18,-14,-4,-2,},{"One With the Beast",0,10,27,30,43,50,63,64,},{"Echoing Call",0,4,4,7,5,11,6,12,},{"Spirit Attunement",0,73,68,76,85,72,79,88,},{"Wild Hunt Tactics (Korayn)",71,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",109,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",182,0,0,0,0,0,0,0,},{"First Strike (Korayn)",12,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",6,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",131,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",52,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",7,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,24,22,24,23,29,32,32,},{"Ferocious Appetite",0,1,4,3,2,8,11,18,},{"One With the Beast",0,17,27,29,42,47,57,62,},{"Necrotic Barrage",0,12,9,23,16,20,23,26,},{"Echoing Call",0,-1,8,9,0,2,3,1,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",66,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",21,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",75,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",96,0,0,0,0,0,0,0,},},},
		[258] ={{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,142,144,154,158,154,164,162,},{"Haunting Apparitions",0,65,68,66,69,69,81,101,},{"Courageous Ascension",0,76,78,79,96,95,103,113,},{"Rabid Shadows",0,15,24,24,28,29,42,26,},{"Mind Devourer",0,81,81,83,93,87,92,101,},{"Combat Meditation (Pelagos)",231,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",190,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",49,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,137,143,155,154,155,169,170,},{"Haunting Apparitions",0,57,63,75,78,63,88,100,},{"Rabid Shadows",0,11,25,29,32,32,40,37,},{"Shattered Perceptions",0,25,22,20,24,15,34,33,},{"Exacting Preparation (Nadjia)",13,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-9,0,0,0,0,0,0,0,},{"Mind Devourer",0,75,78,87,82,93,96,92,},{"Built for War (Draven)",147,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",116,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",73,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",80,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",80,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",43,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,153,155,163,162,172,177,183,},{"Fae Fermata",0,0,-8,-4,-8,-4,-11,-6,},{"Rabid Shadows",0,9,29,30,30,25,36,32,},{"Haunting Apparitions",0,61,65,84,80,70,91,105,},{"Wild Hunt Tactics (Korayn)",120,0,0,0,0,0,0,0,},{"Mind Devourer",0,81,95,94,90,94,85,97,},{"Niya's Tools: Poison (Niya)",-12,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",123,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",170,0,0,0,0,0,0,0,},{"First Strike (Korayn)",7,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-10,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",52,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",147,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,143,151,160,161,160,166,172,},{"Haunting Apparitions",0,57,73,79,85,70,98,106,},{"Festering Transfusion",0,42,55,49,53,57,47,54,},{"Mind Devourer",0,92,89,95,99,99,107,106,},{"Rabid Shadows",0,27,43,39,47,51,48,49,},{"Forgeborne Reveries (Heirmir)",121,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",76,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",14,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",121,0,0,0,0,0,0,0,},},},
		[266] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,0,-5,-7,-6,-7,-4,-2,},{"Borne of Blood",0,73,73,85,92,95,103,108,},{"Fel Commando",0,54,59,58,68,71,76,88,},{"Tyrant's Soul",0,52,61,63,63,70,77,81,},{"Pointed Courage (Kleia)",138,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,45,40,43,41,52,56,54,},{"Bron's Call to Action (Mikanikos)",36,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",99,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,27,33,24,30,31,29,39,},{"Fel Commando",0,58,66,71,75,87,90,98,},{"Borne of Blood",0,79,80,89,96,103,110,122,},{"Tyrant's Soul",0,62,69,70,73,80,77,79,},{"Exacting Preparation (Nadjia)",12,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,37,47,48,55,55,63,69,},{"Dauntless Duelist (Nadjia)",97,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",55,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",46,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",77,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",48,0,0,0,0,0,0,0,},{"Built for War (Draven)",118,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",5,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,28,33,41,35,39,45,43,},{"Fel Commando",0,66,62,71,73,80,87,99,},{"Borne of Blood",0,70,82,85,98,103,105,118,},{"Tyrant's Soul",0,61,67,75,82,79,81,96,},{"Niya's Tools: Burrs (Niya)",167,0,0,0,0,0,0,0,},{"First Strike (Korayn)",10,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",2,0,0,0,0,0,0,0,},{"Carnivorous Stalkers",0,43,43,50,51,60,58,62,},{"Niya's Tools: Poison (Niya)",5,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",104,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",120,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",58,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",30,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,41,45,49,52,64,10,59,},{"Carnivorous Stalkers",0,41,42,48,53,53,62,59,},{"Borne of Blood",0,61,74,73,88,101,98,110,},{"Fel Commando",0,53,59,67,79,78,84,91,},{"Tyrant's Soul",0,66,61,68,71,76,88,86,},{"Plaguey's Preemptive Strike (Marileth)",4,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",95,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-7,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",55,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",39,0,0,0,0,0,0,0,},},},
		[104] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,14,12,12,14,14,17,20,},{"Savage Combatant",0,67,78,81,91,96,101,103,},{"Unchecked Aggression",0,50,53,61,64,66,69,72,},{"Bron's Call to Action (Mikanikos)",133,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",71,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",95,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,23,27,33,36,33,37,37,},{"Savage Combatant",0,79,86,97,101,107,113,120,},{"Wasteland Propriety (Theotar)",42,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,68,74,82,86,94,94,104,},{"Soothing Shade (Theotar)",44,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",40,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",42,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",72,0,0,0,0,0,0,0,},{"Built for War (Draven)",70,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",4,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",15,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,55,57,65,68,74,79,80,},{"Savage Combatant",0,59,67,70,73,85,88,92,},{"Grove Invigoration (Niya)",96,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",31,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",45,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-2,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",73,0,0,0,0,0,0,0,},{"Unchecked Aggression",0,41,45,49,52,59,62,66,},{"Niya's Tools: Burrs (Niya)",183,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",83,0,0,0,0,0,0,0,},{"First Strike (Korayn)",34,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,28,34,35,39,47,48,50,},{"Savage Combatant",0,55,67,70,80,86,93,97,},{"Unchecked Aggression",0,50,55,61,64,72,73,75,},{"Plaguey's Preemptive Strike (Marileth)",10,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",45,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-3,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",21,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",54,0,0,0,0,0,0,0,},},},
		[103] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,-30,-21,-18,-18,-17,-13,-10,},{"Incessant Hunter",0,23,25,24,28,33,26,30,},{"Hammer of Genesis (Mikanikos)",9,0,0,0,0,0,0,0,},{"Taste for Blood",0,65,64,77,84,93,98,99,},{"Bron's Call to Action (Mikanikos)",53,0,0,0,0,0,0,0,},{"Sudden Ambush",0,61,74,71,79,83,93,97,},{"Pointed Courage (Kleia)",164,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",154,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,50,48,58,62,71,67,74,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,27,41,39,40,49,56,55,},{"Taste for Blood",0,59,62,74,79,86,93,101,},{"Incessant Hunter",0,19,24,25,27,34,30,34,},{"Dauntless Duelist (Nadjia)",108,0,0,0,0,0,0,0,},{"Built for War (Draven)",105,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",75,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",67,0,0,0,0,0,0,0,},{"Sudden Ambush",0,62,69,74,83,81,85,98,},{"Refined Palate (Theotar)",56,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",82,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,43,52,60,62,63,70,72,},{"Superior Tactics (Draven)",0,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",21,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,74,75,87,81,94,106,104,},{"Taste for Blood",0,82,93,98,110,120,123,132,},{"Incessant Hunter",0,20,33,34,29,33,37,40,},{"Sudden Ambush",0,65,73,82,91,92,95,103,},{"Carnivorous Instinct",0,60,68,64,76,83,87,93,},{"Niya's Tools: Poison (Niya)",5,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",158,0,0,0,0,0,0,0,},{"First Strike (Korayn)",21,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",3,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",180,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",131,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",63,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",59,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,39,34,43,43,48,59,61,},{"Incessant Hunter",0,19,19,20,22,25,29,32,},{"Taste for Blood",0,55,65,64,74,72,84,83,},{"Forgeborne Reveries (Heirmir)",88,0,0,0,0,0,0,0,},{"Sudden Ambush",0,60,67,78,81,83,89,103,},{"Plaguey's Preemptive Strike (Marileth)",14,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",96,0,0,0,0,0,0,0,},{"Carnivorous Instinct",0,45,35,48,54,60,56,67,},{"Lead by Example (Emeni)",34,0,0,0,0,0,0,0,},},},
		[259] ={{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,45,51,53,63,61,73,82,},{"Poisoned Katar",0,2,4,0,3,4,0,5,},{"Reverberation",0,43,47,53,55,54,69,73,},{"Maim, Mangle",0,32,32,40,45,38,43,50,},{"Pointed Courage (Kleia)",155,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",98,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",36,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,56,53,57,61,73,74,77,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,40,51,56,63,61,67,75,},{"Poisoned Katar",0,0,0,0,0,-5,7,0,},{"Lashing Scars",0,41,50,44,50,56,55,57,},{"Thrill Seeker (Nadjia)",76,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,52,48,63,58,59,69,78,},{"Built for War (Draven)",108,0,0,0,0,0,0,0,},{"Maim, Mangle",0,31,41,37,49,52,47,55,},{"Dauntless Duelist (Nadjia)",102,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",92,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",75,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",33,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",4,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",40,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,46,63,61,66,69,76,73,},{"Well-Placed Steel",0,63,68,72,77,79,85,89,},{"Maim, Mangle",0,39,44,45,55,55,50,57,},{"Septic Shock",0,33,35,41,48,55,58,61,},{"Poisoned Katar",0,17,10,9,5,9,-1,9,},{"Field of Blossoms (Dreamweaver)",117,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",1,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",198,0,0,0,0,0,0,0,},{"First Strike (Korayn)",24,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",141,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",61,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",117,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",113,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,45,46,54,59,64,65,70,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",54,0,0,0,0,0,0,0,},{"Sudden Fractures",0,32,38,40,47,51,55,58,},{"Well-Placed Steel",0,52,48,58,61,64,76,76,},{"Maim, Mangle",0,31,38,31,42,42,49,46,},{"Poisoned Katar",0,-1,2,-2,-1,0,-5,1,},{"Forgeborne Reveries (Heirmir)",81,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",8,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",104,0,0,0,0,0,0,0,},},},
		[267] ={{{"Power",1,145,158,171,184,200,213,226,},{"Soul Tithe",0,1,-2,4,3,1,-2,3,},{"Duplicitous Havoc",0,0,13,-1,-5,-6,6,4,},{"Ashen Remains",0,40,30,40,48,52,60,61,},{"Infernal Brand",0,26,34,35,39,39,48,52,},{"Pointed Courage (Kleia)",143,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",119,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",8,0,0,0,0,0,0,0,},{"Combusting Engine",0,34,42,42,44,54,58,56,},{"Bron's Call to Action (Mikanikos)",35,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Catastrophic Origin",0,38,26,31,30,41,38,44,},{"Combusting Engine",0,43,52,50,55,58,55,56,},{"Refined Palate (Theotar)",65,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,5,4,2,4,5,4,2,},{"Ashen Remains",0,46,49,56,56,63,68,73,},{"Dauntless Duelist (Nadjia)",113,0,0,0,0,0,0,0,},{"Infernal Brand",0,41,42,42,42,49,56,59,},{"Exacting Preparation (Nadjia)",22,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",1,0,0,0,0,0,0,0,},{"Built for War (Draven)",137,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",74,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",89,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",47,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Soul Eater",0,20,26,27,27,29,35,39,},{"Combusting Engine",0,41,41,35,49,50,56,57,},{"Duplicitous Havoc",0,3,-4,-8,-5,-5,1,-4,},{"Niya's Tools: Poison (Niya)",-6,0,0,0,0,0,0,0,},{"Ashen Remains",0,41,48,47,50,55,52,64,},{"Infernal Brand",0,32,35,39,34,45,44,52,},{"Wild Hunt Tactics (Korayn)",99,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",45,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",123,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-8,0,0,0,0,0,0,0,},{"First Strike (Korayn)",9,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",164,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",80,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fatal Decimation",0,36,36,50,50,58,8,62,},{"Combusting Engine",0,36,40,46,51,52,55,66,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",79,0,0,0,0,0,0,0,},{"Duplicitous Havoc",0,3,3,1,-2,-2,-4,-5,},{"Ashen Remains",0,40,56,53,59,62,66,74,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",67,0,0,0,0,0,0,0,},{"Infernal Brand",0,33,32,43,39,40,45,47,},{"Plaguey's Preemptive Strike (Marileth)",23,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",100,0,0,0,0,0,0,0,},},},
		[250] ={{{"Power",1,145,158,171,184,200,213,226,},{"Proliferation",0,47,54,56,51,57,60,60,},{"Debilitating Malady",0,1,6,4,2,1,2,1,},{"Bron's Call to Action (Mikanikos)",46,0,0,0,0,0,0,0,},{"Withering Plague",0,17,20,22,21,20,26,27,},{"Combat Meditation (Pelagos)",61,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",94,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Impenetrable Gloom",0,9,7,14,10,14,14,10,},{"Debilitating Malady",0,-2,-3,-3,1,-3,3,-2,},{"Wasteland Propriety (Theotar)",26,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",1,0,0,0,0,0,0,0,},{"Withering Plague",0,12,12,14,18,14,15,25,},{"Refined Palate (Theotar)",93,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",31,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",53,0,0,0,0,0,0,0,},{"Built for War (Draven)",62,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",42,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Withering Ground",0,42,49,52,58,62,65,71,},{"Debilitating Malady",0,0,2,1,0,3,1,0,},{"Grove Invigoration (Niya)",58,0,0,0,0,0,0,0,},{"Withering Plague",0,14,18,15,21,22,20,25,},{"Niya's Tools: Herbs (Niya)",21,0,0,0,0,0,0,0,},{"First Strike (Korayn)",15,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",184,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",2,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",56,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",63,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",31,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Brutal Grasp",0,13,11,15,11,19,18,19,},{"Debilitating Malady",0,1,2,3,6,1,4,1,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",47,0,0,0,0,0,0,0,},{"Withering Plague",0,21,20,19,25,27,31,35,},{"Plaguey's Preemptive Strike (Marileth)",11,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",39,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",48,0,0,0,0,0,0,0,},},},
		[254] ={{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,28,33,45,37,44,56,64,},{"Enfeebled Mark",0,96,106,110,123,124,137,143,},{"Pointed Courage (Kleia)",164,0,0,0,0,0,0,0,},{"Deadly Chain",0,-1,1,3,8,2,0,5,},{"Sharpshooter's Focus",0,46,45,44,56,56,62,61,},{"Bron's Call to Action (Mikanikos)",44,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,11,2,7,6,3,9,12,},{"Hammer of Genesis (Mikanikos)",14,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",168,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,16,21,27,42,45,47,56,},{"Brutal Projectiles",0,-3,8,11,8,-4,4,3,},{"Empowered Release",0,50,48,45,45,51,45,52,},{"Deadly Chain",0,2,0,-5,7,2,4,2,},{"Sharpshooter's Focus",0,44,38,37,43,51,53,50,},{"Built for War (Draven)",116,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",119,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",68,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",64,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",77,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",8,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",26,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",31,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,21,30,27,36,44,47,51,},{"Spirit Attunement",0,75,81,82,82,93,93,97,},{"Sharpshooter's Focus",0,40,42,40,43,49,49,64,},{"Wild Hunt Tactics (Korayn)",152,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-2,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",149,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,3,-2,3,3,5,3,1,},{"Niya's Tools: Burrs (Niya)",167,0,0,0,0,0,0,0,},{"First Strike (Korayn)",12,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",4,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",50,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",201,0,0,0,0,0,0,0,},{"Deadly Chain",0,-2,-2,1,-3,-4,-5,-3,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,29,34,43,42,54,58,68,},{"Sharpshooter's Focus",0,40,40,52,53,57,59,60,},{"Plaguey's Preemptive Strike (Marileth)",40,0,0,0,0,0,0,0,},{"Necrotic Barrage",0,37,31,40,43,45,44,54,},{"Brutal Projectiles",0,7,11,13,11,3,13,6,},{"Deadly Chain",0,3,10,7,8,3,3,4,},{"Forgeborne Reveries (Heirmir)",101,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",8,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",106,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",69,0,0,0,0,0,0,0,},},},
		[260] ={{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,123,134,142,155,173,181,195,},{"Triple Threat",0,38,41,50,49,59,59,74,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Reverberation",0,52,48,47,59,69,72,67,},{"Pointed Courage (Kleia)",154,0,0,0,0,0,0,0,},{"Sleight of Hand",0,42,54,49,64,59,64,75,},{"Combat Meditation (Pelagos)",93,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",100,0,0,0,0,0,0,0,},{"Ambidexterity",0,1,-1,6,1,3,3,1,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,122,131,145,161,170,186,202,},{"Triple Threat",0,35,41,48,55,51,57,58,},{"Lashing Scars",0,43,46,50,63,67,63,63,},{"Thrill Seeker (Nadjia)",72,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",28,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",0,0,0,0,0,0,0,0,},{"Sleight of Hand",0,50,46,49,58,63,69,69,},{"Built for War (Draven)",126,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",107,0,0,0,0,0,0,0,},{"Ambidexterity",0,-7,-6,-5,1,-14,-9,-6,},{"Refined Palate (Theotar)",112,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",47,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",71,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,140,141,151,171,178,193,209,},{"Septic Shock",0,35,43,42,56,53,60,68,},{"Triple Threat",0,44,51,53,65,59,65,72,},{"Field of Blossoms (Dreamweaver)",77,0,0,0,0,0,0,0,},{"Sleight of Hand",0,45,54,63,66,63,75,87,},{"Niya's Tools: Burrs (Niya)",236,0,0,0,0,0,0,0,},{"First Strike (Korayn)",27,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",119,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",8,0,0,0,0,0,0,0,},{"Ambidexterity",0,15,10,4,6,0,6,10,},{"Social Butterfly (Dreamweaver)",64,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",114,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",118,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,120,126,144,156,174,178,198,},{"Triple Threat",0,38,48,48,38,54,59,66,},{"Sudden Fractures",0,29,32,40,41,44,55,48,},{"Forgeborne Reveries (Heirmir)",96,0,0,0,0,0,0,0,},{"Sleight of Hand",0,53,46,54,60,56,63,67,},{"Gnashing Chompers (Emeni)",3,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",54,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",18,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",94,0,0,0,0,0,0,0,},{"Ambidexterity",0,4,1,-3,6,0,2,5,},},},
		[71] ={{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,46,48,53,61,65,72,75,},{"Crash the Ramparts",0,55,58,69,69,83,91,83,},{"Bron's Call to Action (Mikanikos)",49,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,73,90,95,100,105,118,124,},{"Piercing Verdict",0,13,19,17,26,22,24,30,},{"Combat Meditation (Pelagos)",98,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,2,-10,1,8,-3,-1,2,},{"Hammer of Genesis (Mikanikos)",2,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",132,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,39,44,45,46,53,64,60,},{"Crash the Ramparts",0,57,72,63,78,87,89,95,},{"Ashen Juggernaut",0,75,84,90,97,107,104,118,},{"Dauntless Duelist (Nadjia)",110,0,0,0,0,0,0,0,},{"Built for War (Draven)",103,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",65,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",87,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",78,0,0,0,0,0,0,0,},{"Harrowing Punishment",0,17,18,15,20,18,23,25,},{"Merciless Bonegrinder",0,-4,-5,9,2,1,0,2,},{"Superior Tactics (Draven)",0,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",19,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-4,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,5,15,17,24,29,34,30,},{"Crash the Ramparts",0,53,57,64,68,72,81,83,},{"Ashen Juggernaut",0,82,85,94,99,106,117,126,},{"Merciless Bonegrinder",0,-2,-13,-6,-7,0,-1,-6,},{"Social Butterfly (Dreamweaver)",43,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",106,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",72,0,0,0,0,0,0,0,},{"Mortal Combo",0,35,46,55,48,57,61,73,},{"Niya's Tools: Burrs (Niya)",157,0,0,0,0,0,0,0,},{"First Strike (Korayn)",11,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-6,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",76,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,48,52,56,60,64,71,73,},{"Crash the Ramparts",0,58,62,69,68,81,88,87,},{"Plaguey's Preemptive Strike (Marileth)",16,0,0,0,0,0,0,0,},{"Veteran's Repute",0,44,46,46,53,59,64,68,},{"Ashen Juggernaut",0,87,90,104,112,123,130,130,},{"Gnashing Chompers (Emeni)",-5,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",4,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",69,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",72,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,-5,-7,1,0,0,5,3,},},},
		[73] ={{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,-3,-9,-6,-5,-4,-3,-9,},{"Piercing Verdict",0,12,16,17,18,19,17,20,},{"Ashen Juggernaut",0,13,12,19,16,15,18,16,},{"Bron's Call to Action (Mikanikos)",56,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",145,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",101,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,8,3,4,3,3,4,1,},{"Harrowing Punishment",0,13,10,8,12,14,7,12,},{"Ashen Juggernaut",0,26,25,26,33,33,35,35,},{"Dauntless Duelist (Nadjia)",76,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",5,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",12,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",101,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",47,0,0,0,0,0,0,0,},{"Built for War (Draven)",82,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",117,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",1,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,11,17,22,26,21,27,33,},{"Show of Force",0,-7,2,-2,-2,-1,0,-3,},{"Ashen Juggernaut",0,8,18,18,17,19,20,23,},{"Wild Hunt Tactics (Korayn)",74,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",35,0,0,0,0,0,0,0,},{"First Strike (Korayn)",18,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",138,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-4,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",58,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-2,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",167,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,-4,-3,2,-4,-2,-2,-1,},{"Veteran's Repute",0,29,34,37,41,44,41,49,},{"Ashen Juggernaut",0,13,16,19,21,18,20,22,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",56,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",56,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",-1,0,0,0,0,0,0,0,},},},
		[102] ={{{"Power",1,145,158,171,184,200,213,226,},{"Deep Allegiance",0,-1,-4,-8,-5,-1,-7,-1,},{"Precise Alignment",0,33,34,34,46,49,39,63,},{"Bron's Call to Action (Mikanikos)",60,0,0,0,0,0,0,0,},{"Umbral Intensity",0,40,46,46,60,55,62,64,},{"Stellar Inspiration",0,24,27,27,34,46,33,35,},{"Combat Meditation (Pelagos)",184,0,0,0,0,0,0,0,},{"Fury of the Skies",0,60,71,70,80,85,85,88,},{"Pointed Courage (Kleia)",151,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",10,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Endless Thirst",0,67,69,70,81,85,87,95,},{"Stellar Inspiration",0,32,27,34,25,42,36,38,},{"Refined Palate (Theotar)",64,0,0,0,0,0,0,0,},{"Fury of the Skies",0,64,64,72,72,81,93,98,},{"Built for War (Draven)",159,0,0,0,0,0,0,0,},{"Precise Alignment",0,39,36,43,57,61,72,85,},{"Wasteland Propriety (Theotar)",82,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",87,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",90,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",20,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",122,0,0,0,0,0,0,0,},{"Umbral Intensity",0,50,53,56,56,55,63,63,},},{{"Power",1,145,158,171,184,200,213,226,},{"Conflux of Elements",0,108,116,121,129,146,159,167,},{"Stellar Inspiration",0,34,37,37,39,46,42,47,},{"Wild Hunt Tactics (Korayn)",130,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",6,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",98,0,0,0,0,0,0,0,},{"Fury of the Skies",0,60,70,72,82,87,87,99,},{"Niya's Tools: Herbs (Niya)",3,0,0,0,0,0,0,0,},{"Umbral Intensity",0,38,55,46,53,63,62,58,},{"Grove Invigoration (Niya)",255,0,0,0,0,0,0,0,},{"Precise Alignment",0,8,7,10,11,15,29,30,},{"Social Butterfly (Dreamweaver)",53,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",171,0,0,0,0,0,0,0,},{"First Strike (Korayn)",8,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Evolved Swarm",0,44,51,59,64,57,69,85,},{"Precise Alignment",0,29,42,40,36,38,34,50,},{"Plaguey's Preemptive Strike (Marileth)",17,0,0,0,0,0,0,0,},{"Umbral Intensity",0,34,45,46,40,55,53,61,},{"Stellar Inspiration",0,26,34,27,34,39,41,37,},{"Fury of the Skies",0,58,60,63,71,83,87,100,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",120,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",29,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",82,0,0,0,0,0,0,0,},},},
		[261] ={{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,59,66,68,75,78,88,92,},{"Deeper Daggers",0,43,53,61,74,65,78,71,},{"Reverberation",0,63,65,75,82,93,85,99,},{"Hammer of Genesis (Mikanikos)",8,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",81,0,0,0,0,0,0,0,},{"Planned Execution",0,69,70,75,81,95,96,99,},{"Stiletto Staccato",0,62,73,82,105,105,100,103,},{"Combat Meditation (Pelagos)",100,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",179,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,48,57,68,69,71,88,86,},{"Lashing Scars",0,56,49,50,67,78,74,77,},{"Thrill Seeker (Nadjia)",70,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,38,44,71,94,96,90,80,},{"Built for War (Draven)",131,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",122,0,0,0,0,0,0,0,},{"Deeper Daggers",0,48,50,52,70,63,81,75,},{"Refined Palate (Theotar)",87,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",70,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",58,0,0,0,0,0,0,0,},{"Planned Execution",0,64,62,69,76,88,96,92,},{"Exacting Preparation (Nadjia)",38,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,51,48,51,59,67,69,76,},{"Septic Shock",0,29,38,41,44,55,57,79,},{"Stiletto Staccato",0,27,26,44,81,81,90,84,},{"Planned Execution",0,56,70,66,87,81,97,101,},{"Field of Blossoms (Dreamweaver)",81,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",135,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",0,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",172,0,0,0,0,0,0,0,},{"First Strike (Korayn)",10,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",117,0,0,0,0,0,0,0,},{"Deeper Daggers",0,42,43,53,50,54,61,67,},{"Social Butterfly (Dreamweaver)",45,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",107,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,55,54,56,61,78,83,87,},{"Deeper Daggers",0,38,44,52,59,53,78,75,},{"Sudden Fractures",0,26,43,29,38,44,41,57,},{"Stiletto Staccato",0,41,44,69,89,97,87,82,},{"Gnashing Chompers (Emeni)",-5,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",64,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",21,0,0,0,0,0,0,0,},{"Planned Execution",0,62,64,70,75,79,93,88,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",98,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",99,0,0,0,0,0,0,0,},},},
		[269] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,63,68,61,69,69,68,74,},{"Coordinated Offensive",0,3,13,3,0,-3,1,-3,},{"Calculated Strikes",0,3,2,2,-8,-3,-2,-2,},{"Inner Fury",0,21,26,28,28,37,38,43,},{"Xuen's Bond",0,36,44,48,40,44,50,54,},{"Pointed Courage (Kleia)",156,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",143,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",0,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",89,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,45,43,54,52,62,68,72,},{"Calculated Strikes",0,0,-6,5,4,4,3,5,},{"Inner Fury",0,32,32,36,39,45,52,55,},{"Dauntless Duelist (Nadjia)",71,0,0,0,0,0,0,0,},{"Built for War (Draven)",113,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,4,7,5,3,0,4,3,},{"Xuen's Bond",0,38,47,43,49,50,46,54,},{"Thrill Seeker (Nadjia)",51,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",66,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",70,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",57,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",24,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,4,1,1,9,6,10,8,},{"Grove Invigoration (Niya)",167,0,0,0,0,0,0,0,},{"Calculated Strikes",0,-2,-7,-6,-2,-7,-8,-2,},{"Inner Fury",0,24,31,32,30,35,35,37,},{"Coordinated Offensive",0,-1,-6,-8,7,1,4,-4,},{"Xuen's Bond",0,32,35,37,37,44,58,53,},{"Wild Hunt Tactics (Korayn)",63,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",86,0,0,0,0,0,0,0,},{"First Strike (Korayn)",18,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",179,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",49,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",33,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,66,66,68,78,89,96,105,},{"Calculated Strikes",0,8,9,-3,2,0,8,-2,},{"Coordinated Offensive",0,7,9,3,4,3,9,-1,},{"Inner Fury",0,32,36,33,46,48,45,52,},{"Xuen's Bond",0,35,38,32,35,44,44,46,},{"Forgeborne Reveries (Heirmir)",91,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",80,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",8,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",89,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",5,0,0,0,0,0,0,0,},},},
		[268] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,34,28,34,33,36,32,35,},{"Walk with the Ox",0,135,137,151,150,156,163,173,},{"Scalding Brew",0,8,12,12,18,14,15,18,},{"Bron's Call to Action (Mikanikos)",85,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",63,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",99,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,24,24,24,32,34,38,36,},{"Walk with the Ox",0,141,146,147,156,161,172,178,},{"Scalding Brew",0,13,8,13,20,17,19,20,},{"Exacting Preparation (Nadjia)",7,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",37,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",110,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",28,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",61,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",34,0,0,0,0,0,0,0,},{"Built for War (Draven)",67,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",18,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,9,7,11,7,7,9,11,},{"Walk with the Ox",0,146,148,149,162,166,164,168,},{"Grove Invigoration (Niya)",99,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",43,0,0,0,0,0,0,0,},{"First Strike (Korayn)",23,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",31,0,0,0,0,0,0,0,},{"Scalding Brew",0,16,15,14,13,18,19,27,},{"Niya's Tools: Burrs (Niya)",159,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",47,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",32,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",57,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,59,67,72,79,89,92,97,},{"Walk with the Ox",0,138,145,149,154,158,168,172,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",54,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",12,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",49,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Scalding Brew",0,14,16,15,19,18,25,18,},{"Forgeborne Reveries (Heirmir)",52,0,0,0,0,0,0,0,},},},
		[63] ={{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,75,81,94,99,109,112,118,},{"Ire of the Ascended",0,67,70,79,79,86,97,99,},{"Bron's Call to Action (Mikanikos)",55,0,0,0,0,0,0,0,},{"Flame Accretion",0,7,24,21,30,28,32,38,},{"Pointed Courage (Kleia)",102,0,0,0,0,0,0,0,},{"Infernal Cascade",0,240,259,289,306,341,359,382,},{"Master Flame",0,3,8,7,5,10,-3,9,},{"Combat Meditation (Pelagos)",155,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",11,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,73,84,81,94,109,111,114,},{"Flame Accretion",0,12,21,20,26,36,41,43,},{"Refined Palate (Theotar)",39,0,0,0,0,0,0,0,},{"Infernal Cascade",0,257,280,306,328,355,374,411,},{"Master Flame",0,1,-8,-3,-3,-2,1,0,},{"Siphoned Malice",0,40,46,48,57,60,64,72,},{"Exacting Preparation (Nadjia)",22,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-6,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",110,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",103,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",66,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",65,0,0,0,0,0,0,0,},{"Built for War (Draven)",141,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,81,84,89,101,106,114,115,},{"Flame Accretion",0,17,16,24,30,33,38,41,},{"Infernal Cascade",0,267,288,314,341,373,395,421,},{"Discipline of the Grove",0,81,86,92,94,96,85,79,},{"Social Butterfly (Dreamweaver)",55,0,0,0,0,0,0,0,},{"Master Flame",0,7,3,1,11,3,7,5,},{"Niya's Tools: Burrs (Niya)",184,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",9,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",6,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",112,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",88,0,0,0,0,0,0,0,},{"First Strike (Korayn)",11,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",43,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Controlled Destruction",0,66,73,79,88,98,104,109,},{"Infernal Cascade",0,242,269,301,313,340,363,396,},{"Master Flame",0,-5,-6,1,0,-7,-7,-7,},{"Flame Accretion",0,9,18,17,20,24,33,37,},{"Gift of the Lich",0,6,2,9,0,8,5,11,},{"Gnashing Chompers (Emeni)",-8,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",99,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",36,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",9,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",106,0,0,0,0,0,0,0,},},},
	},
	["T26"]={
		[73] ={{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,6,13,6,3,4,1,2,},{"Piercing Verdict",0,32,35,34,38,40,49,55,},{"Ashen Juggernaut",0,37,39,43,50,52,51,57,},{"Bron's Call to Action (Mikanikos)",92,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",243,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",177,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",18,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,-1,7,3,8,8,4,-1,},{"Harrowing Punishment",0,14,20,23,14,19,22,13,},{"Ashen Juggernaut",0,45,50,54,54,66,62,68,},{"Dauntless Duelist (Nadjia)",125,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",20,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",106,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",76,0,0,0,0,0,0,0,},{"Built for War (Draven)",127,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",175,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,27,36,43,44,54,55,56,},{"Show of Force",0,-2,-4,0,8,0,5,-1,},{"Ashen Juggernaut",0,35,39,34,45,38,54,61,},{"Wild Hunt Tactics (Korayn)",125,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",65,0,0,0,0,0,0,0,},{"First Strike (Korayn)",42,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",199,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-1,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",90,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",3,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",258,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Show of Force",0,-5,10,-4,1,1,5,-4,},{"Veteran's Repute",0,52,58,65,74,78,78,84,},{"Ashen Juggernaut",0,37,39,41,44,47,57,58,},{"Plaguey's Preemptive Strike (Marileth)",27,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",89,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",92,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",0,0,0,0,0,0,0,0,},},},
		[261] ={{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,79,84,94,100,101,123,125,},{"Deeper Daggers",0,75,75,92,90,91,121,111,},{"Reverberation",0,78,93,104,101,118,122,136,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",96,0,0,0,0,0,0,0,},{"Planned Execution",0,85,94,115,102,118,130,136,},{"Stiletto Staccato",0,95,111,123,129,140,140,137,},{"Combat Meditation (Pelagos)",126,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",236,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,66,81,92,95,102,105,113,},{"Lashing Scars",0,71,72,76,88,99,96,92,},{"Thrill Seeker (Nadjia)",108,0,0,0,0,0,0,0,},{"Stiletto Staccato",0,71,84,127,137,130,131,124,},{"Built for War (Draven)",194,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",191,0,0,0,0,0,0,0,},{"Deeper Daggers",0,70,76,82,97,84,106,110,},{"Refined Palate (Theotar)",98,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",89,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",87,0,0,0,0,0,0,0,},{"Planned Execution",0,74,103,117,119,131,129,141,},{"Exacting Preparation (Nadjia)",62,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",7,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,64,71,85,93,102,104,98,},{"Septic Shock",0,41,69,61,83,72,95,106,},{"Stiletto Staccato",0,56,48,95,133,120,107,112,},{"Planned Execution",0,77,101,104,117,122,142,149,},{"Field of Blossoms (Dreamweaver)",99,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",204,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",1,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",239,0,0,0,0,0,0,0,},{"First Strike (Korayn)",20,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",161,0,0,0,0,0,0,0,},{"Deeper Daggers",0,67,70,75,77,85,91,109,},{"Social Butterfly (Dreamweaver)",81,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",153,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Perforated Veins",0,75,64,81,95,90,106,119,},{"Deeper Daggers",0,69,72,84,85,86,96,103,},{"Sudden Fractures",0,42,49,47,65,63,65,65,},{"Stiletto Staccato",0,72,86,102,131,128,116,106,},{"Gnashing Chompers (Emeni)",-1,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",87,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",26,0,0,0,0,0,0,0,},{"Planned Execution",0,94,87,93,106,125,125,130,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",141,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",139,0,0,0,0,0,0,0,},},},
		[66] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,55,78,77,83,78,88,90,},{"Punish the Guilty",0,65,78,83,98,103,115,117,},{"Vengeful Shock",0,7,18,27,30,30,39,52,},{"Bron's Call to Action (Mikanikos)",158,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",112,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",168,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,127,128,138,161,167,190,185,},{"Punish the Guilty",0,69,83,87,100,99,109,123,},{"Wasteland Propriety (Theotar)",98,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",16,0,0,0,0,0,0,0,},{"Vengeful Shock",0,13,2,16,14,25,28,42,},{"Refined Palate (Theotar)",96,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",77,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",139,0,0,0,0,0,0,0,},{"Built for War (Draven)",151,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",99,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",0,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,-1,5,3,0,0,-4,-6,},{"Punish the Guilty",0,71,78,88,104,107,104,110,},{"Grove Invigoration (Niya)",16,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",55,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",0,0,0,0,0,0,0,0,},{"First Strike (Korayn)",45,0,0,0,0,0,0,0,},{"Vengeful Shock",0,-2,13,14,20,15,29,39,},{"Niya's Tools: Burrs (Niya)",272,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",-3,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",5,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",137,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,27,32,42,43,46,58,57,},{"Punish the Guilty",0,70,80,85,98,106,114,114,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",105,0,0,0,0,0,0,0,},{"Vengeful Shock",0,4,12,10,21,30,27,38,},{"Plaguey's Preemptive Strike (Marileth)",23,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",54,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",9,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",106,0,0,0,0,0,0,0,},},},
		[70] ={{{"Power",1,145,158,171,184,200,213,226,},{"Ringing Clarity",0,138,153,163,185,207,212,230,},{"Truth's Wake",0,28,22,24,25,36,41,37,},{"Combat Meditation (Pelagos)",170,0,0,0,0,0,0,0,},{"Templar's Vindication",0,191,211,215,251,270,285,300,},{"Expurgation",0,134,151,164,184,191,204,211,},{"Virtuous Command",0,196,218,226,248,274,286,302,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",216,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",85,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Hallowed Discernment",0,105,113,132,135,151,171,168,},{"Truth's Wake",0,36,31,38,42,45,33,33,},{"Expurgation",0,140,168,182,177,205,216,239,},{"Dauntless Duelist (Nadjia)",161,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",87,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",89,0,0,0,0,0,0,0,},{"Templar's Vindication",0,196,221,241,249,279,295,305,},{"Virtuous Command",0,185,207,225,231,245,272,285,},{"Soothing Shade (Theotar)",117,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",15,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",46,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",131,0,0,0,0,0,0,0,},{"Built for War (Draven)",171,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"The Long Summer",0,44,42,43,39,52,50,50,},{"Truth's Wake",0,28,32,24,31,34,39,52,},{"Expurgation",0,142,158,165,190,200,216,228,},{"Virtuous Command",0,186,202,227,234,266,286,298,},{"Social Butterfly (Dreamweaver)",74,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",172,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",6,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",120,0,0,0,0,0,0,0,},{"Templar's Vindication",0,199,231,251,263,287,295,320,},{"Niya's Tools: Burrs (Niya)",252,0,0,0,0,0,0,0,},{"First Strike (Korayn)",28,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",4,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",167,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Righteous Might",0,21,21,32,14,20,29,24,},{"Truth's Wake",0,28,24,21,22,29,30,35,},{"Templar's Vindication",0,190,201,224,241,257,274,305,},{"Expurgation",0,135,145,155,176,189,206,215,},{"Plaguey's Preemptive Strike (Marileth)",26,0,0,0,0,0,0,0,},{"Virtuous Command",0,171,183,198,220,241,251,262,},{"Forgeborne Reveries (Heirmir)",114,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",96,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-3,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",69,0,0,0,0,0,0,0,},},},
		[269] ={{{"Power",1,145,158,171,184,200,213,226,},{"Strike with Clarity",0,82,74,91,95,111,91,112,},{"Coordinated Offensive",0,-2,-8,-11,-9,-2,-7,2,},{"Calculated Strikes",0,-10,-11,-9,3,-7,-19,-12,},{"Inner Fury",0,32,31,27,36,41,42,50,},{"Xuen's Bond",0,22,37,37,46,41,47,58,},{"Pointed Courage (Kleia)",206,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",206,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",-1,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",112,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Imbued Reflections",0,56,72,81,84,80,106,107,},{"Calculated Strikes",0,14,6,9,-3,-5,1,3,},{"Inner Fury",0,45,46,44,52,64,59,69,},{"Dauntless Duelist (Nadjia)",101,0,0,0,0,0,0,0,},{"Built for War (Draven)",155,0,0,0,0,0,0,0,},{"Coordinated Offensive",0,3,4,2,10,-10,-2,-3,},{"Xuen's Bond",0,63,48,61,67,69,74,77,},{"Thrill Seeker (Nadjia)",62,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",73,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",104,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",76,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",32,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Way of the Fae",0,15,22,8,25,23,26,24,},{"Grove Invigoration (Niya)",239,0,0,0,0,0,0,0,},{"Calculated Strikes",0,8,9,4,0,17,4,10,},{"Inner Fury",0,38,39,58,65,60,62,70,},{"Coordinated Offensive",0,8,2,4,-2,10,4,2,},{"Xuen's Bond",0,57,50,57,72,68,80,82,},{"Wild Hunt Tactics (Korayn)",106,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",4,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",132,0,0,0,0,0,0,0,},{"First Strike (Korayn)",21,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",263,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",69,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",51,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bone Marrow Hops",0,82,84,99,109,116,117,143,},{"Calculated Strikes",0,-1,-4,12,0,0,15,2,},{"Coordinated Offensive",0,1,10,1,12,5,3,12,},{"Inner Fury",0,43,38,50,53,61,59,69,},{"Xuen's Bond",0,41,44,48,47,56,67,63,},{"Forgeborne Reveries (Heirmir)",133,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",113,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",28,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",118,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",8,0,0,0,0,0,0,0,},},},
		[253] ={{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,41,31,33,47,41,44,36,},{"Ferocious Appetite",0,-3,6,9,6,9,23,16,},{"One With the Beast",0,25,42,60,59,85,78,95,},{"Enfeebled Mark",0,112,122,134,140,164,166,176,},{"Hammer of Genesis (Mikanikos)",19,0,0,0,0,0,0,0,},{"Echoing Call",0,4,7,6,7,-4,7,8,},{"Combat Meditation (Pelagos)",154,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",77,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",196,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,26,43,36,21,32,47,43,},{"Empowered Release",0,42,36,38,36,40,41,45,},{"Ferocious Appetite",0,0,6,17,17,19,15,22,},{"Echoing Call",0,9,8,7,10,0,0,0,},{"One With the Beast",0,29,37,49,60,70,92,99,},{"Built for War (Draven)",160,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",166,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",105,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",87,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",16,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",-5,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",49,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",80,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,27,23,22,30,34,40,46,},{"Ferocious Appetite",0,-37,-34,-34,-37,-25,-28,-24,},{"One With the Beast",0,10,29,36,51,68,68,84,},{"Echoing Call",0,-3,-2,3,4,3,-1,3,},{"Spirit Attunement",0,87,98,103,94,107,111,109,},{"Wild Hunt Tactics (Korayn)",78,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",157,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",252,0,0,0,0,0,0,0,},{"First Strike (Korayn)",15,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",2,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",184,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",65,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-8,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Bloodletting",0,40,27,24,37,27,39,40,},{"Ferocious Appetite",0,-7,-11,-2,7,2,13,16,},{"One With the Beast",0,20,18,36,56,71,68,77,},{"Necrotic Barrage",0,9,11,21,12,29,17,38,},{"Echoing Call",0,-2,0,6,1,-8,-7,-5,},{"Gnashing Chompers (Emeni)",-10,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",66,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",28,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",107,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",126,0,0,0,0,0,0,0,},},},
		[263] ={{{"Power",1,145,158,171,184,200,213,226,},{"Elysian Dirge",0,34,49,43,46,66,58,64,},{"Unruly Winds",0,61,59,56,62,64,66,66,},{"Magma Fist",0,35,35,41,39,40,41,54,},{"Focused Lightning",0,46,38,64,63,69,75,90,},{"Chilled to the Core",0,27,41,40,53,60,38,39,},{"Pointed Courage (Kleia)",258,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",170,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",156,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",18,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,7,25,17,28,27,15,31,},{"Unruly Winds",0,57,62,56,61,63,68,72,},{"Thrill Seeker (Nadjia)",123,0,0,0,0,0,0,0,},{"Chilled to the Core",0,38,34,35,49,36,51,52,},{"Magma Fist",0,28,29,34,41,42,32,40,},{"Refined Palate (Theotar)",105,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",132,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",166,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",58,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",71,0,0,0,0,0,0,0,},{"Focused Lightning",0,39,44,53,60,83,78,72,},{"Built for War (Draven)",202,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,32,46,37,45,45,34,37,},{"Magma Fist",0,34,41,34,43,39,51,45,},{"Unruly Winds",0,52,53,60,54,63,71,70,},{"Chilled to the Core",0,41,34,45,38,47,59,44,},{"Wild Hunt Tactics (Korayn)",168,0,0,0,0,0,0,0,},{"Focused Lightning",0,54,45,41,52,65,70,80,},{"Niya's Tools: Poison (Niya)",-5,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",150,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",259,0,0,0,0,0,0,0,},{"First Strike (Korayn)",56,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-1,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",106,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",257,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,20,25,23,32,40,28,37,},{"Focused Lightning",0,30,59,51,66,65,84,88,},{"Plaguey's Preemptive Strike (Marileth)",38,0,0,0,0,0,0,0,},{"Magma Fist",0,42,31,40,32,44,46,42,},{"Unruly Winds",0,44,63,60,69,54,74,67,},{"Chilled to the Core",0,41,39,47,47,37,37,48,},{"Forgeborne Reveries (Heirmir)",158,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",8,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",80,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",159,0,0,0,0,0,0,0,},},},
		[254] ={{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,42,42,63,60,83,81,83,},{"Enfeebled Mark",0,129,128,163,163,170,188,193,},{"Pointed Courage (Kleia)",246,0,0,0,0,0,0,0,},{"Deadly Chain",0,4,3,1,-3,-1,-1,-3,},{"Sharpshooter's Focus",0,59,71,75,73,90,96,95,},{"Bron's Call to Action (Mikanikos)",88,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,-1,7,8,22,5,7,12,},{"Hammer of Genesis (Mikanikos)",21,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",260,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,43,49,61,62,78,89,94,},{"Brutal Projectiles",0,19,21,12,10,13,17,16,},{"Empowered Release",0,74,84,91,90,80,94,79,},{"Deadly Chain",0,8,11,1,0,11,11,4,},{"Sharpshooter's Focus",0,61,70,64,77,73,100,87,},{"Built for War (Draven)",170,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",199,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",124,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",88,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",132,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",8,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",47,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",51,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,45,32,55,59,61,81,85,},{"Spirit Attunement",0,115,124,121,125,129,123,136,},{"Sharpshooter's Focus",0,46,54,76,75,82,88,92,},{"Wild Hunt Tactics (Korayn)",210,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",5,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",189,0,0,0,0,0,0,0,},{"Brutal Projectiles",0,-4,4,1,12,6,14,13,},{"Niya's Tools: Burrs (Niya)",266,0,0,0,0,0,0,0,},{"First Strike (Korayn)",22,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",8,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",81,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",309,0,0,0,0,0,0,0,},{"Deadly Chain",0,0,-6,3,0,-8,-4,-4,},},{{"Power",1,145,158,171,184,200,213,226,},{"Powerful Precision",0,34,40,60,61,78,81,97,},{"Sharpshooter's Focus",0,59,65,68,76,88,87,85,},{"Plaguey's Preemptive Strike (Marileth)",44,0,0,0,0,0,0,0,},{"Necrotic Barrage",0,34,52,47,46,78,49,71,},{"Brutal Projectiles",0,7,3,2,14,23,22,19,},{"Deadly Chain",0,5,3,8,2,5,0,9,},{"Forgeborne Reveries (Heirmir)",148,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",6,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",169,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",95,0,0,0,0,0,0,0,},},},
		[262] ={{{"Power",1,145,158,171,184,200,213,226,},{"Pyroclastic Shock",0,28,36,48,51,38,50,63,},{"High Voltage",0,2,-2,-5,6,16,3,11,},{"Shake the Foundations",0,-11,-18,-6,-13,-18,-17,-15,},{"Elysian Dirge",0,29,33,48,44,43,51,53,},{"Combat Meditation (Pelagos)",109,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",5,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",48,0,0,0,0,0,0,0,},{"Call of Flame",0,76,64,76,76,77,88,86,},{"Pointed Courage (Kleia)",211,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lavish Harvest",0,19,15,9,14,14,13,12,},{"High Voltage",0,22,14,22,18,16,20,21,},{"Shake the Foundations",0,5,21,2,8,10,1,3,},{"Pyroclastic Shock",0,49,47,42,62,60,73,71,},{"Call of Flame",0,88,90,91,95,97,102,107,},{"Built for War (Draven)",220,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",181,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",98,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",99,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",45,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-1,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",25,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",90,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Essential Extraction",0,39,39,37,49,34,40,41,},{"Pyroclastic Shock",0,39,58,52,49,66,66,76,},{"High Voltage",0,11,14,16,14,13,15,27,},{"Social Butterfly (Dreamweaver)",77,0,0,0,0,0,0,0,},{"Shake the Foundations",0,2,9,1,-4,-1,-7,-14,},{"Field of Blossoms (Dreamweaver)",124,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",236,0,0,0,0,0,0,0,},{"First Strike (Korayn)",21,0,0,0,0,0,0,0,},{"Call of Flame",0,79,85,92,99,91,93,101,},{"Grove Invigoration (Niya)",157,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-1,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",2,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",166,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Tumbling Waves",0,21,15,36,23,23,35,40,},{"High Voltage",0,4,20,10,14,1,6,24,},{"Pyroclastic Shock",0,27,33,28,38,32,49,47,},{"Shake the Foundations",0,-6,0,4,-10,-7,-3,-4,},{"Gnashing Chompers (Emeni)",-9,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",99,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",27,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",114,0,0,0,0,0,0,0,},{"Call of Flame",0,93,96,94,93,97,106,99,},{"Forgeborne Reveries (Heirmir)",167,0,0,0,0,0,0,0,},},},
		[255] ={{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,11,6,-1,12,12,6,11,},{"Strength of the Pack",0,67,67,81,90,107,112,133,},{"Enfeebled Mark",0,95,107,108,122,131,137,145,},{"Pointed Courage (Kleia)",207,0,0,0,0,0,0,0,},{"Stinging Strike",0,67,74,81,85,84,89,96,},{"Deadly Tandem",0,35,47,49,52,53,66,67,},{"Hammer of Genesis (Mikanikos)",14,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",112,0,0,0,0,0,0,0,},{"Combat Meditation (Pelagos)",115,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-10,-3,-6,-10,-4,-11,-19,},{"Strength of the Pack",0,48,54,75,78,87,92,102,},{"Stinging Strike",0,41,39,55,55,64,77,77,},{"Deadly Tandem",0,22,17,37,41,41,44,42,},{"Empowered Release",0,57,56,59,50,60,63,68,},{"Built for War (Draven)",148,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",145,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",92,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",64,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",61,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-11,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",6,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",36,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,7,3,6,6,2,8,-5,},{"Spirit Attunement",0,86,89,94,100,106,101,112,},{"Deadly Tandem",0,39,47,48,49,51,57,71,},{"Stinging Strike",0,52,61,69,83,80,90,87,},{"Strength of the Pack",0,65,77,89,94,115,128,137,},{"Wild Hunt Tactics (Korayn)",127,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",4,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",175,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",259,0,0,0,0,0,0,0,},{"First Strike (Korayn)",30,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-4,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",66,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",124,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Flame Infusion",0,-3,-9,-9,4,-4,4,1,},{"Strength of the Pack",0,64,69,84,82,102,117,118,},{"Stinging Strike",0,53,55,64,69,73,78,85,},{"Deadly Tandem",0,38,35,46,51,57,56,67,},{"Necrotic Barrage",0,13,15,29,27,31,35,30,},{"Forgeborne Reveries (Heirmir)",122,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",26,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",122,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",69,0,0,0,0,0,0,0,},},},
		[260] ={{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,173,185,202,215,237,257,270,},{"Reverberation",0,64,60,84,75,91,86,87,},{"Sleight of Hand",0,63,70,79,72,95,92,94,},{"Ambidexterity",0,-4,9,-8,13,9,-8,2,},{"Triple Threat",0,57,65,74,86,70,85,104,},{"Combat Meditation (Pelagos)",129,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",1,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",138,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",232,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,179,197,211,220,256,273,298,},{"Sleight of Hand",0,73,87,74,80,98,104,101,},{"Lashing Scars",0,65,73,77,79,98,94,91,},{"Triple Threat",0,57,70,77,84,95,94,110,},{"Ambidexterity",0,13,7,15,8,8,13,7,},{"Wasteland Propriety (Theotar)",77,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",100,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",55,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",1,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",188,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",133,0,0,0,0,0,0,0,},{"Built for War (Draven)",180,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",115,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,171,190,198,221,242,258,271,},{"Sleight of Hand",0,60,69,64,88,91,82,92,},{"Septic Shock",0,31,33,48,54,62,67,75,},{"Triple Threat",0,52,65,76,74,87,82,97,},{"Ambidexterity",0,11,1,-7,-3,-1,0,8,},{"Wild Hunt Tactics (Korayn)",168,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",109,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",322,0,0,0,0,0,0,0,},{"First Strike (Korayn)",31,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-5,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",155,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",77,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",154,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Count the Odds",0,154,176,197,199,219,254,261,},{"Sudden Fractures",0,35,34,43,55,57,48,63,},{"Forgeborne Reveries (Heirmir)",127,0,0,0,0,0,0,0,},{"Sleight of Hand",0,59,65,49,75,83,98,95,},{"Triple Threat",0,44,51,57,62,80,76,86,},{"Ambidexterity",0,-9,2,1,4,0,-13,-3,},{"Plaguey's Preemptive Strike (Marileth)",24,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",123,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-9,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",68,0,0,0,0,0,0,0,},},},
		[72] ={{{"Power",1,145,158,171,184,200,213,226,},{"Piercing Verdict",0,40,35,46,42,50,54,62,},{"Depths of Insanity",0,54,57,51,76,69,78,86,},{"Vicious Contempt",0,39,39,46,21,43,54,58,},{"Ashen Juggernaut",0,112,109,117,135,144,148,171,},{"Combat Meditation (Pelagos)",138,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",227,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",4,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",86,0,0,0,0,0,0,0,},{"Hack and Slash",0,29,34,40,36,40,43,53,},},{{"Power",1,145,158,171,184,200,213,226,},{"Harrowing Punishment",0,22,34,18,30,29,38,41,},{"Depths of Insanity",0,59,69,74,58,71,81,82,},{"Refined Palate (Theotar)",115,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,106,121,132,140,145,157,169,},{"Dauntless Duelist (Nadjia)",172,0,0,0,0,0,0,0,},{"Vicious Contempt",0,49,44,54,63,59,71,60,},{"Thrill Seeker (Nadjia)",150,0,0,0,0,0,0,0,},{"Hack and Slash",0,35,42,34,36,32,41,49,},{"Soothing Shade (Theotar)",111,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-3,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",51,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",4,0,0,0,0,0,0,0,},{"Built for War (Draven)",155,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,27,19,37,36,42,38,49,},{"Ashen Juggernaut",0,109,117,120,136,144,148,177,},{"Grove Invigoration (Niya)",177,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",140,0,0,0,0,0,0,0,},{"Depths of Insanity",0,55,67,73,66,74,83,90,},{"Niya's Tools: Poison (Niya)",1,0,0,0,0,0,0,0,},{"Vicious Contempt",0,39,43,56,54,54,65,58,},{"Field of Blossoms (Dreamweaver)",128,0,0,0,0,0,0,0,},{"Niya's Tools: Burrs (Niya)",224,0,0,0,0,0,0,0,},{"First Strike (Korayn)",35,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-1,0,0,0,0,0,0,0,},{"Hack and Slash",0,29,43,49,46,51,59,53,},{"Social Butterfly (Dreamweaver)",78,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Veteran's Repute",0,68,80,89,95,87,101,114,},{"Depths of Insanity",0,67,83,76,78,86,86,92,},{"Ashen Juggernaut",0,122,132,142,146,166,170,181,},{"Forgeborne Reveries (Heirmir)",115,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",5,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",6,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",22,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",130,0,0,0,0,0,0,0,},{"Vicious Contempt",0,48,49,53,64,66,62,70,},{"Hack and Slash",0,52,37,53,61,52,60,67,},},},
		[256] ={{{"Power",1,145,158,171,184,200,213,226,},{"Courageous Ascension",0,76,80,88,93,103,107,112,},{"Exaltation",0,3,2,3,4,0,0,0,},{"Swift Penitence",0,40,46,51,50,59,65,66,},{"Pain Transformation",0,2,5,-5,-4,3,2,3,},{"Hammer of Genesis (Mikanikos)",-1,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",107,0,0,0,0,0,0,0,},{"Shining Radiance",0,3,-3,3,1,3,0,-1,},{"Combat Meditation (Pelagos)",-2,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",80,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Shattered Perceptions",0,0,-4,0,-3,0,0,1,},{"Swift Penitence",0,44,52,56,60,63,65,72,},{"Refined Palate (Theotar)",-1,0,0,0,0,0,0,0,},{"Exaltation",0,-5,1,-3,-4,1,-3,-1,},{"Wasteland Propriety (Theotar)",-1,0,0,0,0,0,0,0,},{"Pain Transformation",0,-2,5,1,2,-1,1,-2,},{"Shining Radiance",0,3,-1,0,2,0,-2,1,},{"Built for War (Draven)",92,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",9,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-4,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",69,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",42,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",-1,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Fae Fermata",0,-3,-4,-5,-1,-5,-2,-5,},{"Swift Penitence",0,44,47,50,55,58,70,68,},{"Exaltation",0,-4,-2,-2,-2,-4,-1,0,},{"Wild Hunt Tactics (Korayn)",62,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",-1,0,0,0,0,0,0,0,},{"Pain Transformation",0,-2,-4,-6,-5,-4,-6,0,},{"Niya's Tools: Poison (Niya)",-2,0,0,0,0,0,0,0,},{"Shining Radiance",0,-3,-3,2,-5,-7,-6,-6,},{"Niya's Tools: Burrs (Niya)",289,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",-6,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",0,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",33,0,0,0,0,0,0,0,},{"First Strike (Korayn)",11,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Festering Transfusion",0,1,2,-2,-2,1,-1,1,},{"Plaguey's Preemptive Strike (Marileth)",14,0,0,0,0,0,0,0,},{"Exaltation",0,3,-2,3,-2,2,1,0,},{"Swift Penitence",0,44,51,57,59,59,68,70,},{"Pain Transformation",0,-2,-2,0,-2,0,-1,-2,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",47,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",77,0,0,0,0,0,0,0,},{"Shining Radiance",0,4,3,-1,-1,2,-3,-1,},{"Lead by Example (Emeni)",0,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",1,0,0,0,0,0,0,0,},},},
		[258] ={{{"Power",1,145,158,171,184,200,213,226,},{"Rabid Shadows",0,22,54,54,43,66,64,62,},{"Haunting Apparitions",0,94,101,123,126,111,141,143,},{"Courageous Ascension",0,96,95,111,108,127,131,139,},{"Mind Devourer",0,97,100,96,96,112,102,109,},{"Dissonant Echoes",0,194,201,221,221,221,245,232,},{"Combat Meditation (Pelagos)",316,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",6,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",75,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",275,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,214,228,244,232,242,251,271,},{"Rabid Shadows",0,27,35,46,50,51,44,56,},{"Shattered Perceptions",0,37,40,46,47,49,52,56,},{"Haunting Apparitions",0,102,120,122,131,113,153,158,},{"Wasteland Propriety (Theotar)",75,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",148,0,0,0,0,0,0,0,},{"Mind Devourer",0,94,91,96,108,99,113,125,},{"Dauntless Duelist (Nadjia)",183,0,0,0,0,0,0,0,},{"Built for War (Draven)",243,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",34,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",5,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",131,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",102,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,229,240,261,244,258,274,279,},{"Rabid Shadows",0,29,39,45,43,54,37,63,},{"Fae Fermata",0,-6,5,1,-4,-4,0,-2,},{"Social Butterfly (Dreamweaver)",81,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",9,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",152,0,0,0,0,0,0,0,},{"Haunting Apparitions",0,101,108,130,134,114,172,176,},{"Grove Invigoration (Niya)",244,0,0,0,0,0,0,0,},{"Mind Devourer",0,97,113,105,107,115,113,119,},{"Niya's Tools: Burrs (Niya)",249,0,0,0,0,0,0,0,},{"First Strike (Korayn)",17,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-1,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",167,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Dissonant Echoes",0,213,204,223,223,238,256,262,},{"Festering Transfusion",0,63,57,78,65,78,72,74,},{"Rabid Shadows",0,23,39,39,31,49,37,57,},{"Haunting Apparitions",0,102,98,101,120,108,147,147,},{"Mind Devourer",0,90,100,112,103,106,100,122,},{"Forgeborne Reveries (Heirmir)",164,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",22,0,0,0,0,0,0,0,},{"Gnashing Chompers (Emeni)",-9,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",107,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",145,0,0,0,0,0,0,0,},},},
		[259] ={{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,78,76,77,87,98,100,113,},{"Maim, Mangle",0,44,55,50,65,60,78,76,},{"Well-Placed Steel",0,77,78,86,98,93,110,112,},{"Reverberation",0,44,63,74,72,74,76,79,},{"Combat Meditation (Pelagos)",148,0,0,0,0,0,0,0,},{"Hammer of Genesis (Mikanikos)",9,0,0,0,0,0,0,0,},{"Poisoned Katar",0,-10,10,11,-3,-4,-4,4,},{"Pointed Courage (Kleia)",233,0,0,0,0,0,0,0,},{"Bron's Call to Action (Mikanikos)",56,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,60,72,69,73,93,92,97,},{"Maim, Mangle",0,41,48,57,53,60,70,70,},{"Lashing Scars",0,42,48,58,68,56,66,79,},{"Poisoned Katar",0,-3,-9,-13,-10,-10,2,-6,},{"Well-Placed Steel",0,61,66,73,89,88,87,103,},{"Exacting Preparation (Nadjia)",33,0,0,0,0,0,0,0,},{"Superior Tactics (Draven)",-15,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",96,0,0,0,0,0,0,0,},{"Dauntless Duelist (Nadjia)",163,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",99,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",50,0,0,0,0,0,0,0,},{"Built for War (Draven)",150,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",107,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,59,66,62,72,82,85,92,},{"Maim, Mangle",0,23,45,51,49,69,60,69,},{"Well-Placed Steel",0,74,74,88,94,104,112,109,},{"Septic Shock",0,30,40,33,46,55,61,73,},{"Grove Invigoration (Niya)",140,0,0,0,0,0,0,0,},{"Poisoned Katar",0,-13,-1,-6,-2,-5,-9,-2,},{"Niya's Tools: Burrs (Niya)",265,0,0,0,0,0,0,0,},{"First Strike (Korayn)",23,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",-14,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",174,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",125,0,0,0,0,0,0,0,},{"Social Butterfly (Dreamweaver)",66,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",139,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Lethal Poisons",0,78,82,89,91,96,94,101,},{"Maim, Mangle",0,52,44,59,61,67,67,74,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",147,0,0,0,0,0,0,0,},{"Well-Placed Steel",0,71,85,93,89,114,113,118,},{"Forgeborne Reveries (Heirmir)",126,0,0,0,0,0,0,0,},{"Sudden Fractures",0,53,62,61,70,70,67,76,},{"Poisoned Katar",0,-1,1,3,13,9,-9,-1,},{"Gnashing Chompers (Emeni)",-6,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",88,0,0,0,0,0,0,0,},{"Plaguey's Preemptive Strike (Marileth)",29,0,0,0,0,0,0,0,},},},
		[71] ={{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,91,104,104,113,124,128,144,},{"Crash the Ramparts",0,102,101,114,128,134,142,148,},{"Bron's Call to Action (Mikanikos)",73,0,0,0,0,0,0,0,},{"Ashen Juggernaut",0,136,149,158,176,181,192,214,},{"Piercing Verdict",0,31,30,32,35,40,45,50,},{"Combat Meditation (Pelagos)",152,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,2,13,0,6,9,5,13,},{"Hammer of Genesis (Mikanikos)",17,0,0,0,0,0,0,0,},{"Pointed Courage (Kleia)",227,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,71,70,77,86,97,103,118,},{"Crash the Ramparts",0,89,117,113,131,127,153,155,},{"Ashen Juggernaut",0,115,130,133,138,160,176,177,},{"Dauntless Duelist (Nadjia)",162,0,0,0,0,0,0,0,},{"Built for War (Draven)",148,0,0,0,0,0,0,0,},{"Thrill Seeker (Nadjia)",81,0,0,0,0,0,0,0,},{"Refined Palate (Theotar)",94,0,0,0,0,0,0,0,},{"Soothing Shade (Theotar)",105,0,0,0,0,0,0,0,},{"Harrowing Punishment",0,35,30,20,29,31,27,32,},{"Merciless Bonegrinder",0,-9,11,-4,3,0,10,-8,},{"Superior Tactics (Draven)",5,0,0,0,0,0,0,0,},{"Exacting Preparation (Nadjia)",22,0,0,0,0,0,0,0,},{"Wasteland Propriety (Theotar)",-8,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Destructive Reverberations",0,26,33,33,32,47,46,57,},{"Crash the Ramparts",0,97,95,101,108,124,137,154,},{"Ashen Juggernaut",0,139,137,150,153,165,182,200,},{"Merciless Bonegrinder",0,-5,13,1,9,12,9,7,},{"Social Butterfly (Dreamweaver)",82,0,0,0,0,0,0,0,},{"Grove Invigoration (Niya)",175,0,0,0,0,0,0,0,},{"Field of Blossoms (Dreamweaver)",126,0,0,0,0,0,0,0,},{"Mortal Combo",0,86,98,101,110,121,129,143,},{"Niya's Tools: Burrs (Niya)",223,0,0,0,0,0,0,0,},{"First Strike (Korayn)",48,0,0,0,0,0,0,0,},{"Niya's Tools: Herbs (Niya)",1,0,0,0,0,0,0,0,},{"Wild Hunt Tactics (Korayn)",138,0,0,0,0,0,0,0,},{"Niya's Tools: Poison (Niya)",3,0,0,0,0,0,0,0,},},{{"Power",1,145,158,171,184,200,213,226,},{"Mortal Combo",0,82,96,102,108,123,129,134,},{"Crash the Ramparts",0,92,110,119,127,138,138,157,},{"Plaguey's Preemptive Strike (Marileth)",34,0,0,0,0,0,0,0,},{"Veteran's Repute",0,74,77,81,86,88,112,108,},{"Ashen Juggernaut",0,134,155,161,178,196,202,225,},{"Gnashing Chompers (Emeni)",11,0,0,0,0,0,0,0,},{"Lead by Example (Emeni)",5,0,0,0,0,0,0,0,},{"Heirmir's Arsenal: Marrowed Gemstone (Heirmir)",134,0,0,0,0,0,0,0,},{"Forgeborne Reveries (Heirmir)",109,0,0,0,0,0,0,0,},{"Merciless Bonegrinder",0,1,8,-10,6,2,2,-1,},},},
	},
}


--	///////////////////////////////////////////////////////////////////////////////////////////
--
--	 
--	Author: SLOKnightfall

--	Version: V1.1.1

--  SavedVariables: CovenantForgeDB

--	///////////////////////////////////////////////////////////////////////////////////////////

CovenantForge = LibStub("AceAddon-3.0"):NewAddon(CovenantForge, "CovenantForge", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")
local AceGUI = LibStub("AceGUI-3.0")
CovenantForge.Frame = LibStub("AceGUI-3.0")
CovenantForge.Init = {}

local playerInv_DB
local Profile
local playerNme
local realmName
local playerClass, classID,_
local viewed_spec
local Profile

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
end


function optionHandler:Getter(info)
	return CovenantForge.Profile[info[#info]]
end




local options = {
	name = "CovenantForge",
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
					order = 1.2,
					name = "Show Soulbind Name",
					type = "toggle",
					width = 1.3,
					arg = "ShowSoulbindNames",
				},

				ShowNodeNames = {
					order = 1.2,
					name = "Show Node Ability Names",
					type = "toggle",
					width = 1.3,
					arg = "ShowNodeNames",
				},

				ShowAsPercent = {
					order = 1.2,
					name = "Show Weight as Percent",
					type = "toggle",
					width = 1.3,
					arg = "ShowAsPercent",
				},
			},
		},
	},

}

local defaults = {
	profile = {
				['*'] = true,
			},
}


---Ace based CovenantForge initilization
function CovenantForge:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("CovenantForgeDB", defaults, true)
	CovenantForge.Profile = self.db.profile
	options.args.profiles  = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	LibStub("AceConfigRegistry-3.0"):ValidateOptionsTable(options, "CovenantForge")
	LibStub("AceConfig-3.0"):RegisterOptionsTable("CovenantForge", options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("CovenantForge", "CovenantForge")
	--self.db.RegisterCallback(OmegaMap, "OnProfileChanged", "RefreshConfig")
	--self.db.RegisterCallback(OmegaMap, "OnProfileCopied", "RefreshConfig")
	--self.db.RegisterCallback(OmegaMap, "OnProfileReset", "RefreshConfig")



	CovenantForge:RegisterEvent("ADDON_LOADED", "EventHandler" )

end

function CovenantForge:EventHandler(event, arg1 )
	if event == "ADDON_LOADED" and arg1 == "Blizzard_Soulbinds" then 
		CovenantForge:Hook(SoulbindViewer, "Open", function()  C_Timer.After(.05, function() CovenantForge:Update() end) end , true)
		C_Timer.After(.05, function() CovenantForge.Init:CreateSoulbindFrames() end)
		CovenantForge:UnregisterEvent("ADDON_LOADED")
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
}

function CovenantForge:OnEnable()
	CovenantForge:BuildWeightData()
	local spec = GetSpecialization()
	viewed_spec = GetSpecializationInfo(spec)
end

local CLASS_SPECS ={{71,72,73},{65,66,70},{253,254,255},{259,260,261},{256,257,258},{250,251,252},{262,263,264},{62,63,64},{265,266,267},{268,269,270},{102,103,104,105},{577,578}}

function CovenantForge.Init:CreateSoulbindFrames()
	local frame = CreateFrame("Frame", "CovForge_events", SoulbindViewer)
	
	frame:SetScript("OnShow", function() FrameUtil.RegisterFrameForEvents(frame, SoulbindConduitNodeEvents) end)
	frame:SetScript("OnHide", function() FrameUtil.UnregisterFrameForEvents(frame, SoulbindConduitNodeEvents) end)
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
		--local soulbindID = button:GetSoulbindID()
		--f.soulbindName:SetText(C_Soulbinds.GetSoulbindData(soulbindID).name)
		--local nodeTotal, conduitTotal = CovenantForge:GetSoulbindWeight(soulbindID)
		--f.soulbindWeight:SetText(nodeTotal + conduitTotal .. "["..nodeTotal.."]" )
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
	dropdown:SetCallback("OnValueChanged", function(self,event, key) viewed_spec = key; CovenantForge:Update() end)

	local f = CreateFrame("Frame", "CovForge_WeightTotal", SoulbindViewer, "CovenantForge_WeightTotalTemplate")
	CovenantForge.CovForge_WeightTotalFrame = f
	f:Show()
	f:ClearAllPoints()
	f:SetPoint("BOTTOM",SoulbindViewer.ActivateSoulbindButton,"BOTTOM", 0, 25)

	CovenantForge:Hook(SoulbindViewer, "UpdateCommitConduitsButton", function()CovenantForge.CovForge_WeightTotalFrame:SetShown(not SoulbindViewer.CommitConduitsButton:IsShown()) end, true)
	--CovenantForge.CovForge_WeightTotalFrame:SetShown(not SoulbindViewer.CommitConduitsButton:IsShown())
	CovenantForge:Update()
end


--Updates Weight Values & Names
function CovenantForge:Update()
	local spec = GetSpecialization()
	local specID, specName = GetSpecializationInfo(spec)
	local curentsoulbindID = Soulbinds.GetOpenSoulbindID() or C_Soulbinds.GetActiveSoulbindID();


	for buttonIndex, button in ipairs(SoulbindViewer.SelectGroup.buttonGroup:GetButtons()) do
		local f = button.ForgeInfo
		local soulbindID = button:GetSoulbindID()
		f.soulbindName:SetText(C_Soulbinds.GetSoulbindData(soulbindID).name)
		local selectedTotal, unlockedTotal, nodeMax, conduitMax = CovenantForge:GetSoulbindWeight(soulbindID)
		--local nodeTotal, conduitTotal, selectedTotal, unlockedConduitTotal = CovenantForge:GetSoulbindWeight(soulbindID)
		--local totalValue = selectedNodeTotal + selectedConduitTotal
		f.soulbindWeight:SetText(selectedTotal .. "("..nodeMax+conduitMax..")" )

		if curentsoulbindID == soulbindID then 
			--CovenantForge.CovForge_WeightTotalFrame.Weight:SetText("Base: %s/%s\nCurrent: %s/%s":format(unlockedMax, nodeMax, selectedNodeTotal + selectedConduitTotal, conduitMax + unlockedMax))
		
			CovenantForge.CovForge_WeightTotalFrame.Weight:SetText("Current: "..selectedTotal.."/"..unlockedTotal.."\nMax Possible:"..nodeMax+conduitMax)
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
				local name = GetSpellInfo(spellID)
				local rank = conduit:GetConduitRank()
				local itemLevel = C_Soulbinds.GetConduitItemLevel(conduitID, rank)
				weight = CovenantForge:GetWeightData(conduitID, viewed_spec)
				f.Name:SetText(name)
			else
				f.Name:SetText("")
			end
		else
			local spellID =  nodeFrame.spell:GetSpellID()
			local name = GetSpellInfo(spellID) or ""
			f.Name:SetText(name)
			weight = CovenantForge:GetTalentWeight(spellID, viewed_spec)
		end

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

			f.Value:SetText(weight)
		else
			f.Value:SetText("")
		end
	end

	for conduitType, conduitData in ipairs(SoulbindViewer.ConduitList:GetLists()) do
		for conduitButton in SoulbindViewer.ConduitList.ScrollBox.ScrollTarget.Lists[conduitType].pool:EnumerateActive() do
			conduitButton.ItemLevel:SetText(conduitItemLevel);
			local conduitID = conduitButton.conduitData.conduitID
			local conduitItemLevel = conduitButton.conduitData.conduitItemLevel
			local weight = CovenantForge:GetWeightData(conduitID, viewed_spec, itemLevel)
			local percent = CovenantForge:GetWeightPercent(weight)

			if weight ~=0 then 
				if CovenantForge.Profile.ShowAsPercent then 
					if percent > 0 then 
						conduitButton.ItemLevel:SetText(conduitItemLevel..GREEN_FONT_COLOR_CODE.." (+"..percent.."%)");
					elseif percent < 0 then 
						conduitButton.ItemLevel:SetText(conduitItemLevel..RED_FONT_COLOR_CODE.." ("..percent.."%)");
					end
				else
					if weight > 0 then 
						conduitButton.ItemLevel:SetText(conduitItemLevel..GREEN_FONT_COLOR_CODE.." (+"..weight..")");
					elseif weight < 0 then 
						conduitButton.ItemLevel:SetText(conduitItemLevel..RED_FONT_COLOR_CODE.." ("..weight..")");
					end
				end
			else 
				conduitButton.ItemLevel:SetText(conduitItemLevel);
			end
		end
	end

	CovenantForge.CovForge_WeightTotalFrame:SetShown(not SoulbindViewer.CommitConduitsButton:IsShown())
end


local Weights = {}
local ilevel = {}

function CovenantForge:BuildWeightData()
	local spec = GetSpecialization()
	local specID, specName = GetSpecializationInfo(spec)
	local _, _, classID = UnitClass("player")
	local covenantID = C_Covenants.GetActiveCovenantID();
	local classSpecs = CLASS_SPECS[classID]
	if CovenantForge.Weights["Pre Raid"][specID] then 
		for i,spec in ipairs(classSpecs) do
			local data = CovenantForge.Weights["Pre Raid"][spec][covenantID]
			Weights[spec] =  {}
			for i=2, #data do
				local conduitData = data[i]
				local name = string.gsub(conduitData[1],' %(.+%)',"")
				local ilevel ={}
				for index = 2, #conduitData do
					local ilevelData = data[1][index]
					ilevel[ilevelData] = conduitData[index]
				end
				Weights[spec][name] = ilevel
			end

		end
	end
end


function CovenantForge:GetWeightData(conduitID, specID)
	if not CovenantForge.Conduits[conduitID] or not Weights[specID] then return 0 end
	local soulbindName = CovenantForge.Conduits[conduitID][1]
	--if soulbindName == "Rejuvenating Wind" then return 31 end
	local collectionData  = C_Soulbinds.GetConduitCollectionData(conduitID)
	local conduitItemLevel = collectionData.conduitItemLevel

	if Weights[specID][soulbindName] then 
		local weight = Weights[specID][soulbindName][conduitItemLevel]
		return weight
	end

	return 0
end


function CovenantForge:GetTalentWeight(spellID, specID)
	--if spellID == 320658 then return 51 end
	if not CovenantForge.Soulbinds[spellID] or not Weights[specID] then return 0 end
	local name = CovenantForge.Soulbinds[spellID]
	if Weights[specID][name] then 
		local weight = Weights[specID][name][1]
		return weight
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
		--	print(data.parentNodeIDs[1])
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
		local selectedTable
		local unlockedTable
		

		local parentNode = parentNodeTable[data.ID]
		local parentData = parentNodeData[parentNode]
		local parentWeight = 0
		
		
		if conduitID == 0 then
			weight = CovenantForge:GetTalentWeight(spellID, viewed_spec)

			maxTable = maxNodeWeights
		else
			weight = CovenantForge:GetWeightData(conduitID, viewed_spec)

			maxTable = maxConduitWeights
		end

		if parentData and parentData.conduitID == 0 then
				parentWeight = CovenantForge:GetTalentWeight(parentData.spellID, viewed_spec)
				parentRow[parentData.row] = true
		elseif parentData then 
			parentWeight = CovenantForge:GetWeightData(parentData.conduitID, viewed_spec)
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
	local percent = weight/WEIGHT_BASE

	 --return percent>=0 and math.floor(percent+0.5) or math.ceil(percent-0.5)
 return  tonumber(string.format("%.2f", percent))
end
--[[
	local spec = GetSpecialization()
	local specID, specName = GetSpecializationInfo(spec)
	local className, classFile, classID = UnitClass("player")
	local covenantID = C_Covenants.GetActiveCovenantID();
	local classSpecs = specID[classID]
	for i,spec in ipairs(classSpecs) do

	--CovenantForge.Weights["Pre Raid"][specID][covenantID]
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

