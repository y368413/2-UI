local _, ns = ...
local M, R, U, I = unpack(ns)
--[[----------------------------------------------------------------------------
	AzeritePowerWeights

	Helps you pick the best Azerite powers on your gear for your class and spec.

	(c) 2018 -
	Sanex @ EU-Arathor / ahak @ Curseforge
----------------------------------------------------------------------------]]--
local n = {}

-- 8.3 Powers for every Class and Spec
local sourceData = {
	["center"] = {
		["spellID"] = 263978,
		["icon"] = 2065624,
		["name"] = "Azerite Empowered",
		["azeritePowerID"] = 13,
	},
	["class"] = {
		{
			[73] = {
				{
					["spellID"] = 272824,
					["icon"] = 136105,
					["name"] = "Deafening Crash",
					["azeritePowerID"] = 118,
				}, -- [1]
				{
					["spellID"] = 279172,
					["icon"] = 1377132,
					["name"] = "Bloodsport",
					["azeritePowerID"] = 177,
				}, -- [2]
				{
					["spellID"] = 287377,
					["icon"] = 254108,
					["name"] = "Bastion of Might",
					["azeritePowerID"] = 237,
				}, -- [3]
				{
					["spellID"] = 278760,
					["icon"] = 132353,
					["name"] = "Callous Reprisal",
					["azeritePowerID"] = 440,
				}, -- [4]
				{
					["spellID"] = 278765,
					["icon"] = 942783,
					["name"] = "Iron Fortress",
					["azeritePowerID"] = 441,
				}, -- [5]
				{
					["spellID"] = 277636,
					["icon"] = 134951,
					["name"] = "Brace for Impact",
					["azeritePowerID"] = 450,
				}, -- [6]
			},
			[71] = {
				{
					["spellID"] = 288452,
					["icon"] = 236317,
					["name"] = "Striking the Anvil",
					["azeritePowerID"] = 121,
				}, -- [1]
				{
					["spellID"] = 273409,
					["icon"] = 236303,
					["name"] = "Gathering Storm",
					["azeritePowerID"] = 174,
				}, -- [2]
				{
					["spellID"] = 275529,
					["icon"] = 236314,
					["name"] = "Test of Might",
					["azeritePowerID"] = 226,
				}, -- [3]
				{
					["spellID"] = 277639,
					["icon"] = 132223,
					["name"] = "Seismic Wave",
					["azeritePowerID"] = 433,
				}, -- [4]
				{
					["spellID"] = 278751,
					["icon"] = 132340,
					["name"] = "Crushing Assault",
					["azeritePowerID"] = 434,
				}, -- [5]
				{
					["spellID"] = 278752,
					["icon"] = 464973,
					["name"] = "Lord of War",
					["azeritePowerID"] = 435,
				}, -- [6]
			},
			[72] = {
				{
					["spellID"] = 288056,
					["icon"] = 132344,
					["name"] = "Unbridled Ferocity",
					["azeritePowerID"] = 119,
				}, -- [1]
				{
					["spellID"] = 273409,
					["icon"] = 236303,
					["name"] = "Gathering Storm",
					["azeritePowerID"] = 174,
				}, -- [2]
				{
					["spellID"] = 288080,
					["icon"] = 236276,
					["name"] = "Cold Steel, Hot Blood",
					["azeritePowerID"] = 176,
				}, -- [3]
				{
					["spellID"] = 275632,
					["icon"] = 132352,
					["name"] = "Pulverizing Blows",
					["azeritePowerID"] = 229,
				}, -- [4]
				{
					["spellID"] = 278757,
					["icon"] = 136110,
					["name"] = "Simmering Rage",
					["azeritePowerID"] = 437,
				}, -- [5]
				{
					["spellID"] = 278758,
					["icon"] = 132147,
					["name"] = "Reckless Flurry",
					["azeritePowerID"] = 438,
				}, -- [6]
				{
					["spellID"] = 277638,
					["icon"] = 458972,
					["name"] = "Infinite Fury",
					["azeritePowerID"] = 451,
				}, -- [7]
			},
		}, -- [1]
		{
			[70] = {
				{
					["spellID"] = 272898,
					["icon"] = 135875,
					["name"] = "Avenger's Might",
					["azeritePowerID"] = 125,
				}, -- [1]
				{
					["spellID"] = 278617,
					["icon"] = 135897,
					["name"] = "Relentless Inquisitor",
					["azeritePowerID"] = 154,
				}, -- [2]
				{
					["spellID"] = 273473,
					["icon"] = 1360757,
					["name"] = "Expurgation",
					["azeritePowerID"] = 187,
				}, -- [3]
				{
					["spellID"] = 275496,
					["icon"] = 135959,
					["name"] = "Indomitable Justice",
					["azeritePowerID"] = 235,
				}, -- [4]
				{
					["spellID"] = 278593,
					["icon"] = 135917,
					["name"] = "Grace of the Justicar",
					["azeritePowerID"] = 393,
				}, -- [5]
				{
					["spellID"] = 286229,
					["icon"] = 135878,
					["name"] = "Light's Decree",
					["azeritePowerID"] = 396,
				}, -- [6]
				{
					["spellID"] = 286390,
					["icon"] = 236263,
					["name"] = "Empyrean Power",
					["azeritePowerID"] = 453,
				}, -- [7]
				{
					["spellID"] = 277675,
					["icon"] = 1603010,
					["name"] = "Judicious Defense",
					["azeritePowerID"] = 454,
				}, -- [8]
			},
			[65] = {
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [1]
				{
					["spellID"] = 272898,
					["icon"] = 135875,
					["name"] = "Avenger's Might",
					["azeritePowerID"] = 125,
				}, -- [2]
				{
					["spellID"] = 287268,
					["icon"] = 1360764,
					["name"] = "Glimmer of Light",
					["azeritePowerID"] = 139,
				}, -- [3]
				{
					["spellID"] = 273513,
					["icon"] = 135907,
					["name"] = "Moment of Compassion",
					["azeritePowerID"] = 188,
				}, -- [4]
				{
					["spellID"] = 275463,
					["icon"] = 236254,
					["name"] = "Divine Revelations",
					["azeritePowerID"] = 233,
				}, -- [5]
				{
					["spellID"] = 275496,
					["icon"] = 135959,
					["name"] = "Indomitable Justice",
					["azeritePowerID"] = 235,
				}, -- [6]
				{
					["spellID"] = 278593,
					["icon"] = 135917,
					["name"] = "Grace of the Justicar",
					["azeritePowerID"] = 393,
				}, -- [7]
				{
					["spellID"] = 278594,
					["icon"] = 461859,
					["name"] = "Breaking Dawn",
					["azeritePowerID"] = 394,
				}, -- [8]
				{
					["spellID"] = 277674,
					["icon"] = 135972,
					["name"] = "Radiant Incandescence",
					["azeritePowerID"] = 452,
				}, -- [9]
				{
					["spellID"] = 277675,
					["icon"] = 1603010,
					["name"] = "Judicious Defense",
					["azeritePowerID"] = 454,
				}, -- [10]
			},
			[66] = {
				{
					["spellID"] = 272898,
					["icon"] = 135875,
					["name"] = "Avenger's Might",
					["azeritePowerID"] = 125,
				}, -- [1]
				{
					["spellID"] = 272976,
					["icon"] = 135943,
					["name"] = "Bulwark of Light",
					["azeritePowerID"] = 133,
				}, -- [2]
				{
					["spellID"] = 278605,
					["icon"] = 135874,
					["name"] = "Soaring Shield",
					["azeritePowerID"] = 150,
				}, -- [3]
				{
					["spellID"] = 287126,
					["icon"] = 135981,
					["name"] = "Righteous Conviction",
					["azeritePowerID"] = 189,
				}, -- [4]
				{
					["spellID"] = 275477,
					["icon"] = 236265,
					["name"] = "Inner Light",
					["azeritePowerID"] = 234,
				}, -- [5]
				{
					["spellID"] = 275496,
					["icon"] = 135959,
					["name"] = "Indomitable Justice",
					["azeritePowerID"] = 235,
				}, -- [6]
				{
					["spellID"] = 278593,
					["icon"] = 135917,
					["name"] = "Grace of the Justicar",
					["azeritePowerID"] = 393,
				}, -- [7]
				{
					["spellID"] = 278609,
					["icon"] = 133176,
					["name"] = "Inspiring Vanguard",
					["azeritePowerID"] = 395,
				}, -- [8]
				{
					["spellID"] = 277675,
					["icon"] = 1603010,
					["name"] = "Judicious Defense",
					["azeritePowerID"] = 454,
				}, -- [9]
			},
		}, -- [2]
		{
			[255] = {
				{
					["spellID"] = 272717,
					["icon"] = 132176,
					["name"] = "Serrated Jaws",
					["azeritePowerID"] = 107,
				}, -- [1]
				{
					["spellID"] = 272742,
					["icon"] = 451164,
					["name"] = "Wildfire Cluster",
					["azeritePowerID"] = 110,
				}, -- [2]
				{
					["spellID"] = 273283,
					["icon"] = 1033905,
					["name"] = "Latent Poison",
					["azeritePowerID"] = 163,
				}, -- [3]
				{
					["spellID"] = 274590,
					["icon"] = 136067,
					["name"] = "Venomous Fangs",
					["azeritePowerID"] = 213,
				}, -- [4]
				{
					["spellID"] = 287093,
					["icon"] = 236186,
					["name"] = "Dire Consequences",
					["azeritePowerID"] = 365,
				}, -- [5]
				{
					["spellID"] = 277653,
					["icon"] = 2065565,
					["name"] = "Blur of Talons",
					["azeritePowerID"] = 371,
				}, -- [6]
				{
					["spellID"] = 278532,
					["icon"] = 132214,
					["name"] = "Wilderness Survival",
					["azeritePowerID"] = 372,
				}, -- [7]
				{
					["spellID"] = 288570,
					["icon"] = 132210,
					["name"] = "Primeval Intuition",
					["azeritePowerID"] = 373,
				}, -- [8]
			},
			[254] = {
				{
					["spellID"] = 264198,
					["icon"] = 461115,
					["name"] = "In The Rhythm",
					["azeritePowerID"] = 36,
				}, -- [1]
				{
					["spellID"] = 287707,
					["icon"] = 132212,
					["name"] = "Surging Shots",
					["azeritePowerID"] = 162,
				}, -- [2]
				{
					["spellID"] = 274444,
					["icon"] = 132329,
					["name"] = "Unerring Vision",
					["azeritePowerID"] = 212,
				}, -- [3]
				{
					["spellID"] = 277651,
					["icon"] = 135130,
					["name"] = "Steady Aim",
					["azeritePowerID"] = 368,
				}, -- [4]
				{
					["spellID"] = 278530,
					["icon"] = 132330,
					["name"] = "Rapid Reload",
					["azeritePowerID"] = 369,
				}, -- [5]
				{
					["spellID"] = 278531,
					["icon"] = 878211,
					["name"] = "Focused Fire",
					["azeritePowerID"] = 370,
				}, -- [6]
			},
			[253] = {
				{
					["spellID"] = 272717,
					["icon"] = 132176,
					["name"] = "Serrated Jaws",
					["azeritePowerID"] = 107,
				}, -- [1]
				{
					["spellID"] = 273262,
					["icon"] = 132127,
					["name"] = "Haze of Rage",
					["azeritePowerID"] = 161,
				}, -- [2]
				{
					["spellID"] = 274441,
					["icon"] = 132133,
					["name"] = "Dance of Death",
					["azeritePowerID"] = 211,
				}, -- [3]
				{
					["spellID"] = 287093,
					["icon"] = 236186,
					["name"] = "Dire Consequences",
					["azeritePowerID"] = 365,
				}, -- [4]
				{
					["spellID"] = 279806,
					["icon"] = 136074,
					["name"] = "Primal Instincts",
					["azeritePowerID"] = 366,
				}, -- [5]
				{
					["spellID"] = 278529,
					["icon"] = 2058007,
					["name"] = "Feeding Frenzy",
					["azeritePowerID"] = 367,
				}, -- [6]
				{
					["spellID"] = 278530,
					["icon"] = 132330,
					["name"] = "Rapid Reload",
					["azeritePowerID"] = 369,
				}, -- [7]
			},
		}, -- [3]
		{
			[260] = {
				{
					["spellID"] = 272935,
					["icon"] = 1373908,
					["name"] = "Deadshot",
					["azeritePowerID"] = 129,
				}, -- [1]
				{
					["spellID"] = 288979,
					["icon"] = 132350,
					["name"] = "Keep Your Wits About You",
					["azeritePowerID"] = 180,
				}, -- [2]
				{
					["spellID"] = 275846,
					["icon"] = 132336,
					["name"] = "Snake Eyes",
					["azeritePowerID"] = 239,
				}, -- [3]
				{
					["spellID"] = 278675,
					["icon"] = 1373910,
					["name"] = "Paradise Lost",
					["azeritePowerID"] = 410,
				}, -- [4]
				{
					["spellID"] = 278676,
					["icon"] = 135610,
					["name"] = "Ace Up Your Sleeve",
					["azeritePowerID"] = 411,
				}, -- [5]
				{
					["spellID"] = 277676,
					["icon"] = 136206,
					["name"] = "Brigand's Blitz",
					["azeritePowerID"] = 446,
				}, -- [6]
			},
			[261] = {
				{
					["spellID"] = 286121,
					["icon"] = 237532,
					["name"] = "Replicating Shadows",
					["azeritePowerID"] = 124,
				}, -- [1]
				{
					["spellID"] = 273418,
					["icon"] = 1373907,
					["name"] = "Night's Vengeance",
					["azeritePowerID"] = 175,
				}, -- [2]
				{
					["spellID"] = 275896,
					["icon"] = 1373912,
					["name"] = "Blade In The Shadows",
					["azeritePowerID"] = 240,
				}, -- [3]
				{
					["spellID"] = 278681,
					["icon"] = 236279,
					["name"] = "The First Dance",
					["azeritePowerID"] = 413,
				}, -- [4]
				{
					["spellID"] = 278683,
					["icon"] = 252272,
					["name"] = "Inevitability",
					["azeritePowerID"] = 414,
				}, -- [5]
				{
					["spellID"] = 277673,
					["icon"] = 132090,
					["name"] = "Perforate",
					["azeritePowerID"] = 445,
				}, -- [6]
			},
			[259] = {
				{
					["spellID"] = 273007,
					["icon"] = 132304,
					["name"] = "Double Dose",
					["azeritePowerID"] = 136,
				}, -- [1]
				{
					["spellID"] = 273488,
					["icon"] = 132287,
					["name"] = "Twist the Knife",
					["azeritePowerID"] = 181,
				}, -- [2]
				{
					["spellID"] = 286573,
					["icon"] = 458726,
					["name"] = "Nothing Personal",
					["azeritePowerID"] = 249,
				}, -- [3]
				{
					["spellID"] = 277679,
					["icon"] = 132302,
					["name"] = "Scent of Blood",
					["azeritePowerID"] = 406,
				}, -- [4]
				{
					["spellID"] = 287649,
					["icon"] = 236273,
					["name"] = "Echoing Blades",
					["azeritePowerID"] = 407,
				}, -- [5]
				{
					["spellID"] = 278666,
					["icon"] = 132297,
					["name"] = "Shrouded Suffocation",
					["azeritePowerID"] = 408,
				}, -- [6]
			},
		}, -- [4]
		{
			[257] = {
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [1]
				{
					["spellID"] = 272780,
					["icon"] = 135907,
					["name"] = "Permeating Glow",
					["azeritePowerID"] = 114,
				}, -- [2]
				{
					["spellID"] = 273313,
					["icon"] = 237541,
					["name"] = "Blessed Sanctuary",
					["azeritePowerID"] = 165,
				}, -- [3]
				{
					["spellID"] = 275602,
					["icon"] = 135943,
					["name"] = "Prayerful Litany",
					["azeritePowerID"] = 228,
				}, -- [4]
				{
					["spellID"] = 277681,
					["icon"] = 135913,
					["name"] = "Everlasting Light",
					["azeritePowerID"] = 400,
				}, -- [5]
				{
					["spellID"] = 278645,
					["icon"] = 135944,
					["name"] = "Word of Mending",
					["azeritePowerID"] = 401,
				}, -- [6]
				{
					["spellID"] = 287336,
					["icon"] = 135937,
					["name"] = "Promise of Deliverance",
					["azeritePowerID"] = 402,
				}, -- [7]
			},
			[258] = {
				{
					["spellID"] = 272788,
					["icon"] = 237565,
					["name"] = "Searing Dialogue",
					["azeritePowerID"] = 115,
				}, -- [1]
				{
					["spellID"] = 288340,
					["icon"] = 135978,
					["name"] = "Thought Harvester",
					["azeritePowerID"] = 166,
				}, -- [2]
				{
					["spellID"] = 275541,
					["icon"] = 136202,
					["name"] = "Depth of the Shadows",
					["azeritePowerID"] = 227,
				}, -- [3]
				{
					["spellID"] = 275722,
					["icon"] = 237298,
					["name"] = "Whispers of the Damned",
					["azeritePowerID"] = 236,
				}, -- [4]
				{
					["spellID"] = 277682,
					["icon"] = 458229,
					["name"] = "Spiteful Apparitions",
					["azeritePowerID"] = 403,
				}, -- [5]
				{
					["spellID"] = 278659,
					["icon"] = 136163,
					["name"] = "Death Throes",
					["azeritePowerID"] = 404,
				}, -- [6]
				{
					["spellID"] = 278661,
					["icon"] = 1386549,
					["name"] = "Chorus of Insanity",
					["azeritePowerID"] = 405,
				}, -- [7]
			},
			[256] = {
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [1]
				{
					["spellID"] = 272775,
					["icon"] = 135936,
					["name"] = "Moment of Repose",
					["azeritePowerID"] = 113,
				}, -- [2]
				{
					["spellID"] = 273307,
					["icon"] = 237545,
					["name"] = "Weal and Woe",
					["azeritePowerID"] = 164,
				}, -- [3]
				{
					["spellID"] = 275541,
					["icon"] = 136202,
					["name"] = "Depth of the Shadows",
					["azeritePowerID"] = 227,
				}, -- [4]
				{
					["spellID"] = 287355,
					["icon"] = 135922,
					["name"] = "Sudden Revelation",
					["azeritePowerID"] = 397,
				}, -- [5]
				{
					["spellID"] = 278629,
					["icon"] = 237567,
					["name"] = "Contemptuous Homily",
					["azeritePowerID"] = 398,
				}, -- [6]
				{
					["spellID"] = 278643,
					["icon"] = 1386546,
					["name"] = "Enduring Luminescence",
					["azeritePowerID"] = 399,
				}, -- [7]
			},
		}, -- [5]
		{
			[252] = {
				{
					["spellID"] = 288417,
					["icon"] = 348276,
					["name"] = "Magus of the Dead",
					["azeritePowerID"] = 109,
				}, -- [1]
				{
					["spellID"] = 273088,
					["icon"] = 136144,
					["name"] = "Bone Spike Graveyard",
					["azeritePowerID"] = 140,
				}, -- [2]
				{
					["spellID"] = 286832,
					["icon"] = 342913,
					["name"] = "Helchains",
					["azeritePowerID"] = 142,
				}, -- [3]
				{
					["spellID"] = 274081,
					["icon"] = 1129420,
					["name"] = "Festermight",
					["azeritePowerID"] = 199,
				}, -- [4]
				{
					["spellID"] = 275929,
					["icon"] = 136145,
					["name"] = "Harrowing Decay",
					["azeritePowerID"] = 244,
				}, -- [5]
				{
					["spellID"] = 278482,
					["icon"] = 879926,
					["name"] = "Cankerous Wounds",
					["azeritePowerID"] = 350,
				}, -- [6]
				{
					["spellID"] = 278489,
					["icon"] = 136133,
					["name"] = "Last Surprise",
					["azeritePowerID"] = 351,
				}, -- [7]
			},
			[251] = {
				{
					["spellID"] = 272718,
					["icon"] = 135372,
					["name"] = "Icy Citadel",
					["azeritePowerID"] = 108,
				}, -- [1]
				{
					["spellID"] = 273093,
					["icon"] = 237520,
					["name"] = "Latent Chill",
					["azeritePowerID"] = 141,
				}, -- [2]
				{
					["spellID"] = 287283,
					["icon"] = 1580450,
					["name"] = "Frostwhelp's Indignation",
					["azeritePowerID"] = 198,
				}, -- [3]
				{
					["spellID"] = 275917,
					["icon"] = 135833,
					["name"] = "Echoing Howl",
					["azeritePowerID"] = 242,
				}, -- [4]
				{
					["spellID"] = 278480,
					["icon"] = 135305,
					["name"] = "Killer Frost",
					["azeritePowerID"] = 346,
				}, -- [5]
				{
					["spellID"] = 278487,
					["icon"] = 538770,
					["name"] = "Frozen Tempest",
					["azeritePowerID"] = 347,
				}, -- [6]
			},
			[250] = {
				{
					["spellID"] = 272684,
					["icon"] = 132155,
					["name"] = "Deep Cuts",
					["azeritePowerID"] = 106,
				}, -- [1]
				{
					["spellID"] = 273088,
					["icon"] = 136144,
					["name"] = "Bone Spike Graveyard",
					["azeritePowerID"] = 140,
				}, -- [2]
				{
					["spellID"] = 274057,
					["icon"] = 237517,
					["name"] = "Marrowblood",
					["azeritePowerID"] = 197,
				}, -- [3]
				{
					["spellID"] = 289339,
					["icon"] = 135338,
					["name"] = "Bloody Runeblade",
					["azeritePowerID"] = 243,
				}, -- [4]
				{
					["spellID"] = 278479,
					["icon"] = 135277,
					["name"] = "Eternal Rune Weapon",
					["azeritePowerID"] = 348,
				}, -- [5]
				{
					["spellID"] = 278484,
					["icon"] = 1376745,
					["name"] = "Bones of the Damned",
					["azeritePowerID"] = 349,
				}, -- [6]
			},
		}, -- [6]
		{
			[263] = {
				{
					["spellID"] = 263786,
					["icon"] = 538565,
					["name"] = "Astral Shift",
					["azeritePowerID"] = 17,
				}, -- [1]
				{
					["spellID"] = 272992,
					["icon"] = 236289,
					["name"] = "Primal Primer",
					["azeritePowerID"] = 137,
				}, -- [2]
				{
					["spellID"] = 273461,
					["icon"] = 136086,
					["name"] = "Strength of Earth",
					["azeritePowerID"] = 179,
				}, -- [3]
				{
					["spellID"] = 275388,
					["icon"] = 237443,
					["name"] = "Lightning Conduit",
					["azeritePowerID"] = 223,
				}, -- [4]
				{
					["spellID"] = 278697,
					["icon"] = 136028,
					["name"] = "Natural Harmony",
					["azeritePowerID"] = 416,
				}, -- [5]
				{
					["spellID"] = 278719,
					["icon"] = 132314,
					["name"] = "Roiling Storm",
					["azeritePowerID"] = 420,
				}, -- [6]
				{
					["spellID"] = 277666,
					["icon"] = 451167,
					["name"] = "Ancestral Resonance",
					["azeritePowerID"] = 447,
				}, -- [7]
				{
					["spellID"] = 277671,
					["icon"] = 136048,
					["name"] = "Synapse Shock",
					["azeritePowerID"] = 448,
				}, -- [8]
				{
					["spellID"] = 287768,
					["icon"] = 136046,
					["name"] = "Thunderaan's Fury",
					["azeritePowerID"] = 530,
				}, -- [9]
			},
			[264] = {
				{
					["spellID"] = 263786,
					["icon"] = 538565,
					["name"] = "Astral Shift",
					["azeritePowerID"] = 17,
				}, -- [1]
				{
					["spellID"] = 263792,
					["icon"] = 136015,
					["name"] = "Lightningburn",
					["azeritePowerID"] = 24,
				}, -- [2]
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [3]
				{
					["spellID"] = 272978,
					["icon"] = 237582,
					["name"] = "Volcanic Lightning",
					["azeritePowerID"] = 135,
				}, -- [4]
				{
					["spellID"] = 272989,
					["icon"] = 136042,
					["name"] = "Soothing Waters",
					["azeritePowerID"] = 138,
				}, -- [5]
				{
					["spellID"] = 287300,
					["icon"] = 237590,
					["name"] = "Turn of the Tide",
					["azeritePowerID"] = 191,
				}, -- [6]
				{
					["spellID"] = 275488,
					["icon"] = 135127,
					["name"] = "Swelling Stream",
					["azeritePowerID"] = 224,
				}, -- [7]
				{
					["spellID"] = 278697,
					["icon"] = 136028,
					["name"] = "Natural Harmony",
					["azeritePowerID"] = 416,
				}, -- [8]
				{
					["spellID"] = 278713,
					["icon"] = 252995,
					["name"] = "Surging Tides",
					["azeritePowerID"] = 422,
				}, -- [9]
				{
					["spellID"] = 278715,
					["icon"] = 237586,
					["name"] = "Spouting Spirits",
					["azeritePowerID"] = 423,
				}, -- [10]
				{
					["spellID"] = 277666,
					["icon"] = 451167,
					["name"] = "Ancestral Resonance",
					["azeritePowerID"] = 447,
				}, -- [11]
				{
					["spellID"] = 277671,
					["icon"] = 136048,
					["name"] = "Synapse Shock",
					["azeritePowerID"] = 448,
				}, -- [12]
				{
					["spellID"] = 277658,
					["icon"] = 136037,
					["name"] = "Overflowing Shores",
					["azeritePowerID"] = 449,
				}, -- [13]
				{
					["spellID"] = 279829,
					["icon"] = 451169,
					["name"] = "Igneous Potential",
					["azeritePowerID"] = 457,
				}, -- [14]
			},
			[262] = {
				{
					["spellID"] = 263786,
					["icon"] = 538565,
					["name"] = "Astral Shift",
					["azeritePowerID"] = 17,
				}, -- [1]
				{
					["spellID"] = 263792,
					["icon"] = 136015,
					["name"] = "Lightningburn",
					["azeritePowerID"] = 24,
				}, -- [2]
				{
					["spellID"] = 272978,
					["icon"] = 237582,
					["name"] = "Volcanic Lightning",
					["azeritePowerID"] = 135,
				}, -- [3]
				{
					["spellID"] = 273448,
					["icon"] = 136026,
					["name"] = "Lava Shock",
					["azeritePowerID"] = 178,
				}, -- [4]
				{
					["spellID"] = 275381,
					["icon"] = 135790,
					["name"] = "Echo of the Elementals",
					["azeritePowerID"] = 222,
				}, -- [5]
				{
					["spellID"] = 278697,
					["icon"] = 136028,
					["name"] = "Natural Harmony",
					["azeritePowerID"] = 416,
				}, -- [6]
				{
					["spellID"] = 286949,
					["icon"] = 136025,
					["name"] = "Tectonic Thunder",
					["azeritePowerID"] = 417,
				}, -- [7]
				{
					["spellID"] = 277666,
					["icon"] = 451167,
					["name"] = "Ancestral Resonance",
					["azeritePowerID"] = 447,
				}, -- [8]
				{
					["spellID"] = 277671,
					["icon"] = 136048,
					["name"] = "Synapse Shock",
					["azeritePowerID"] = 448,
				}, -- [9]
				{
					["spellID"] = 279829,
					["icon"] = 451169,
					["name"] = "Igneous Potential",
					["azeritePowerID"] = 457,
				}, -- [10]
			},
		}, -- [7]
		{
			[64] = {
				{
					["spellID"] = 272968,
					["icon"] = 612394,
					["name"] = "Packed Ice",
					["azeritePowerID"] = 132,
				}, -- [1]
				{
					["spellID"] = 288164,
					["icon"] = 236209,
					["name"] = "Flash Freeze",
					["azeritePowerID"] = 170,
				}, -- [2]
				{
					["spellID"] = 279854,
					["icon"] = 2126034,
					["name"] = "Glacial Assault",
					["azeritePowerID"] = 225,
				}, -- [3]
				{
					["spellID"] = 277663,
					["icon"] = 135846,
					["name"] = "Tunnel of Ice",
					["azeritePowerID"] = 379,
				}, -- [4]
				{
					["spellID"] = 278541,
					["icon"] = 135844,
					["name"] = "Whiteout",
					["azeritePowerID"] = 380,
				}, -- [5]
				{
					["spellID"] = 278542,
					["icon"] = 135838,
					["name"] = "Frigid Grasp",
					["azeritePowerID"] = 381,
				}, -- [6]
			},
			[63] = {
				{
					["spellID"] = 272932,
					["icon"] = 135810,
					["name"] = "Flames of Alacrity",
					["azeritePowerID"] = 128,
				}, -- [1]
				{
					["spellID"] = 288755,
					["icon"] = 460698,
					["name"] = "Wildfire",
					["azeritePowerID"] = 168,
				}, -- [2]
				{
					["spellID"] = 274596,
					["icon"] = 135807,
					["name"] = "Blaster Master",
					["azeritePowerID"] = 215,
				}, -- [3]
				{
					["spellID"] = 277656,
					["icon"] = 135808,
					["name"] = "Trailing Embers",
					["azeritePowerID"] = 376,
				}, -- [4]
				{
					["spellID"] = 278538,
					["icon"] = 135812,
					["name"] = "Duplicative Incineration",
					["azeritePowerID"] = 377,
				}, -- [5]
				{
					["spellID"] = 278539,
					["icon"] = 236218,
					["name"] = "Firemind",
					["azeritePowerID"] = 378,
				}, -- [6]
			},
			[62] = {
				{
					["spellID"] = 270669,
					["icon"] = 136096,
					["name"] = "Arcane Pummeling",
					["azeritePowerID"] = 88,
				}, -- [1]
				{
					["spellID"] = 286027,
					["icon"] = 135732,
					["name"] = "Equipoise",
					["azeritePowerID"] = 127,
				}, -- [2]
				{
					["spellID"] = 273326,
					["icon"] = 136075,
					["name"] = "Brain Storm",
					["azeritePowerID"] = 167,
				}, -- [3]
				{
					["spellID"] = 274594,
					["icon"] = 236205,
					["name"] = "Arcane Pressure",
					["azeritePowerID"] = 214,
				}, -- [4]
				{
					["spellID"] = 278536,
					["icon"] = 135730,
					["name"] = "Galvanizing Spark",
					["azeritePowerID"] = 374,
				}, -- [5]
				{
					["spellID"] = 278537,
					["icon"] = 136116,
					["name"] = "Explosive Echo",
					["azeritePowerID"] = 375,
				}, -- [6]
			},
		}, -- [8]
		{
			[266] = {
				{
					["spellID"] = 272944,
					["icon"] = 136181,
					["name"] = "Shadow's Bite",
					["azeritePowerID"] = 130,
				}, -- [1]
				{
					["spellID"] = 273523,
					["icon"] = 236296,
					["name"] = "Umbral Blaze",
					["azeritePowerID"] = 190,
				}, -- [2]
				{
					["spellID"] = 275395,
					["icon"] = 2032610,
					["name"] = "Explosive Potential",
					["azeritePowerID"] = 231,
				}, -- [3]
				{
					["spellID"] = 278737,
					["icon"] = 535592,
					["name"] = "Demonic Meteor",
					["azeritePowerID"] = 428,
				}, -- [4]
				{
					["spellID"] = 287059,
					["icon"] = 237561,
					["name"] = "Baleful Invocation",
					["azeritePowerID"] = 429,
				}, -- [5]
				{
					["spellID"] = 276007,
					["icon"] = 460856,
					["name"] = "Excoriate",
					["azeritePowerID"] = 443,
				}, -- [6]
				{
					["spellID"] = 279878,
					["icon"] = 2065628,
					["name"] = "Supreme Commander",
					["azeritePowerID"] = 458,
				}, -- [7]
			},
			[267] = {
				{
					["spellID"] = 287637,
					["icon"] = 134075,
					["name"] = "Chaos Shards",
					["azeritePowerID"] = 131,
				}, -- [1]
				{
					["spellID"] = 275425,
					["icon"] = 135817,
					["name"] = "Flashpoint",
					["azeritePowerID"] = 232,
				}, -- [2]
				{
					["spellID"] = 278747,
					["icon"] = 1380866,
					["name"] = "Rolling Havoc",
					["azeritePowerID"] = 431,
				}, -- [3]
				{
					["spellID"] = 278748,
					["icon"] = 135789,
					["name"] = "Chaotic Inferno",
					["azeritePowerID"] = 432,
				}, -- [4]
				{
					["spellID"] = 277644,
					["icon"] = 236291,
					["name"] = "Crashing Chaos",
					["azeritePowerID"] = 444,
				}, -- [5]
				{
					["spellID"] = 279909,
					["icon"] = 135807,
					["name"] = "Bursting Flare",
					["azeritePowerID"] = 460,
				}, -- [6]
			},
			[265] = {
				{
					["spellID"] = 272891,
					["icon"] = 237564,
					["name"] = "Wracking Brilliance",
					["azeritePowerID"] = 123,
				}, -- [1]
				{
					["spellID"] = 273521,
					["icon"] = 537517,
					["name"] = "Inevitable Demise",
					["azeritePowerID"] = 183,
				}, -- [2]
				{
					["spellID"] = 275372,
					["icon"] = 136228,
					["name"] = "Cascading Calamity",
					["azeritePowerID"] = 230,
				}, -- [3]
				{
					["spellID"] = 278721,
					["icon"] = 136139,
					["name"] = "Sudden Onset",
					["azeritePowerID"] = 425,
				}, -- [4]
				{
					["spellID"] = 278727,
					["icon"] = 1416161,
					["name"] = "Dreadful Calling",
					["azeritePowerID"] = 426,
				}, -- [5]
				{
					["spellID"] = 289364,
					["icon"] = 136230,
					["name"] = "Pandemic Invocation",
					["azeritePowerID"] = 442,
				}, -- [6]
			},
		}, -- [9]
		{
			[269] = {
				{
					["spellID"] = 287055,
					["icon"] = 606548,
					["name"] = "Fury of Xuen",
					["azeritePowerID"] = 117,
				}, -- [1]
				{
					["spellID"] = 273291,
					["icon"] = 642415,
					["name"] = "Sunrise Technique",
					["azeritePowerID"] = 184,
				}, -- [2]
				{
					["spellID"] = 288634,
					["icon"] = 1381297,
					["name"] = "Glory of the Dawn",
					["azeritePowerID"] = 388,
				}, -- [3]
				{
					["spellID"] = 279918,
					["icon"] = 627606,
					["name"] = "Open Palm Strikes",
					["azeritePowerID"] = 389,
				}, -- [4]
				{
					["spellID"] = 278577,
					["icon"] = 606551,
					["name"] = "Pressure Point",
					["azeritePowerID"] = 390,
				}, -- [5]
				{
					["spellID"] = 286585,
					["icon"] = 607849,
					["name"] = "Dance of Chi-Ji",
					["azeritePowerID"] = 391,
				}, -- [6]
			},
			[270] = {
				{
					["spellID"] = 287829,
					["icon"] = 611418,
					["name"] = "Secret Infusion",
					["azeritePowerID"] = 76,
				}, -- [1]
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [2]
				{
					["spellID"] = 273291,
					["icon"] = 642415,
					["name"] = "Sunrise Technique",
					["azeritePowerID"] = 184,
				}, -- [3]
				{
					["spellID"] = 273328,
					["icon"] = 775461,
					["name"] = "Overflowing Mists",
					["azeritePowerID"] = 185,
				}, -- [4]
				{
					["spellID"] = 275975,
					["icon"] = 627487,
					["name"] = "Misty Peaks",
					["azeritePowerID"] = 248,
				}, -- [5]
				{
					["spellID"] = 277667,
					["icon"] = 627485,
					["name"] = "Burst of Life",
					["azeritePowerID"] = 385,
				}, -- [6]
				{
					["spellID"] = 279875,
					["icon"] = 1360978,
					["name"] = "Font of Life",
					["azeritePowerID"] = 386,
				}, -- [7]
				{
					["spellID"] = 278576,
					["icon"] = 1020466,
					["name"] = "Uplifted Spirits",
					["azeritePowerID"] = 387,
				}, -- [8]
				{
					["spellID"] = 288634,
					["icon"] = 1381297,
					["name"] = "Glory of the Dawn",
					["azeritePowerID"] = 388,
				}, -- [9]
			},
			[268] = {
				{
					["spellID"] = 272792,
					["icon"] = 615339,
					["name"] = "Boiling Brew",
					["azeritePowerID"] = 116,
				}, -- [1]
				{
					["spellID"] = 273464,
					["icon"] = 1500803,
					["name"] = "Staggering Strikes",
					["azeritePowerID"] = 186,
				}, -- [2]
				{
					["spellID"] = 275892,
					["icon"] = 133701,
					["name"] = "Fit to Burst",
					["azeritePowerID"] = 238,
				}, -- [3]
				{
					["spellID"] = 285958,
					["icon"] = 1360979,
					["name"] = "Straight, No Chaser",
					["azeritePowerID"] = 382,
				}, -- [4]
				{
					["spellID"] = 278569,
					["icon"] = 611419,
					["name"] = "Training of Niuzao",
					["azeritePowerID"] = 383,
				}, -- [5]
				{
					["spellID"] = 278571,
					["icon"] = 642416,
					["name"] = "Elusive Footwork",
					["azeritePowerID"] = 384,
				}, -- [6]
			},
		}, -- [10]
		{
			[103] = {
				{
					["spellID"] = 279524,
					["icon"] = 236149,
					["name"] = "Blood Mist",
					["azeritePowerID"] = 111,
				}, -- [1]
				{
					["spellID"] = 273338,
					["icon"] = 132122,
					["name"] = "Untamed Ferocity",
					["azeritePowerID"] = 169,
				}, -- [2]
				{
					["spellID"] = 273344,
					["icon"] = 236169,
					["name"] = "Masterful Instincts",
					["azeritePowerID"] = 171,
				}, -- [3]
				{
					["spellID"] = 274424,
					["icon"] = 132242,
					["name"] = "Jungle Fury",
					["azeritePowerID"] = 209,
				}, -- [4]
				{
					["spellID"] = 275906,
					["icon"] = 451161,
					["name"] = "Twisted Claws",
					["azeritePowerID"] = 241,
				}, -- [5]
				{
					["spellID"] = 276021,
					["icon"] = 132134,
					["name"] = "Iron Jaws",
					["azeritePowerID"] = 247,
				}, -- [6]
				{
					["spellID"] = 278509,
					["icon"] = 132152,
					["name"] = "Gushing Lacerations",
					["azeritePowerID"] = 358,
				}, -- [7]
				{
					["spellID"] = 279527,
					["icon"] = 236305,
					["name"] = "Wild Fleshrending",
					["azeritePowerID"] = 359,
				}, -- [8]
			},
			[104] = {
				{
					["spellID"] = 269379,
					["icon"] = 136096,
					["name"] = "Long Night",
					["azeritePowerID"] = 51,
				}, -- [1]
				{
					["spellID"] = 279552,
					["icon"] = 1378702,
					["name"] = "Layered Mane",
					["azeritePowerID"] = 112,
				}, -- [2]
				{
					["spellID"] = 273344,
					["icon"] = 236169,
					["name"] = "Masterful Instincts",
					["azeritePowerID"] = 171,
				}, -- [3]
				{
					["spellID"] = 275906,
					["icon"] = 451161,
					["name"] = "Twisted Claws",
					["azeritePowerID"] = 241,
				}, -- [4]
				{
					["spellID"] = 289314,
					["icon"] = 571585,
					["name"] = "Burst of Savagery",
					["azeritePowerID"] = 251,
				}, -- [5]
				{
					["spellID"] = 279527,
					["icon"] = 236305,
					["name"] = "Wild Fleshrending",
					["azeritePowerID"] = 359,
				}, -- [6]
				{
					["spellID"] = 278510,
					["icon"] = 132091,
					["name"] = "Gory Regeneration",
					["azeritePowerID"] = 360,
				}, -- [7]
				{
					["spellID"] = 278511,
					["icon"] = 132136,
					["name"] = "Guardian's Wrath",
					["azeritePowerID"] = 361,
				}, -- [8]
			},
			[105] = {
				{
					["spellID"] = 269379,
					["icon"] = 136096,
					["name"] = "Long Night",
					["azeritePowerID"] = 51,
				}, -- [1]
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [2]
				{
					["spellID"] = 287251,
					["icon"] = 236153,
					["name"] = "Early Harvest",
					["azeritePowerID"] = 120,
				}, -- [3]
				{
					["spellID"] = 279778,
					["icon"] = 134914,
					["name"] = "Grove Tending",
					["azeritePowerID"] = 172,
				}, -- [4]
				{
					["spellID"] = 274432,
					["icon"] = 136081,
					["name"] = "Autumn Leaves",
					["azeritePowerID"] = 210,
				}, -- [5]
				{
					["spellID"] = 278505,
					["icon"] = 236216,
					["name"] = "High Noon",
					["azeritePowerID"] = 356,
				}, -- [6]
				{
					["spellID"] = 278515,
					["icon"] = 136085,
					["name"] = "Rampant Growth",
					["azeritePowerID"] = 362,
				}, -- [7]
				{
					["spellID"] = 278513,
					["icon"] = 134157,
					["name"] = "Waking Dream",
					["azeritePowerID"] = 363,
				}, -- [8]
				{
					["spellID"] = 279642,
					["icon"] = 136048,
					["name"] = "Lively Spirit",
					["azeritePowerID"] = 364,
				}, -- [9]
			},
			[102] = {
				{
					["spellID"] = 269379,
					["icon"] = 136096,
					["name"] = "Long Night",
					["azeritePowerID"] = 51,
				}, -- [1]
				{
					["spellID"] = 272871,
					["icon"] = 136060,
					["name"] = "Streaking Stars",
					["azeritePowerID"] = 122,
				}, -- [2]
				{
					["spellID"] = 273367,
					["icon"] = 136096,
					["name"] = "Power of the Moon",
					["azeritePowerID"] = 173,
				}, -- [3]
				{
					["spellID"] = 287773,
					["icon"] = 135730,
					["name"] = "Arcanic Pulsar",
					["azeritePowerID"] = 200,
				}, -- [4]
				{
					["spellID"] = 276152,
					["icon"] = 135753,
					["name"] = "Dawning Sun",
					["azeritePowerID"] = 250,
				}, -- [5]
				{
					["spellID"] = 278505,
					["icon"] = 236216,
					["name"] = "High Noon",
					["azeritePowerID"] = 356,
				}, -- [6]
				{
					["spellID"] = 278507,
					["icon"] = 236168,
					["name"] = "Lunar Shrapnel",
					["azeritePowerID"] = 357,
				}, -- [7]
				{
					["spellID"] = 279642,
					["icon"] = 136048,
					["name"] = "Lively Spirit",
					["azeritePowerID"] = 364,
				}, -- [8]
			},
		}, -- [11]
		{
			[577] = {
				{
					["spellID"] = 279581,
					["icon"] = 1305149,
					["name"] = "Revolving Blades",
					["azeritePowerID"] = 126,
				}, -- [1]
				{
					["spellID"] = 273231,
					["icon"] = 1305156,
					["name"] = "Furious Gaze",
					["azeritePowerID"] = 159,
				}, -- [2]
				{
					["spellID"] = 273236,
					["icon"] = 1344649,
					["name"] = "Infernal Armor",
					["azeritePowerID"] = 160,
				}, -- [3]
				{
					["spellID"] = 288754,
					["icon"] = 1305157,
					["name"] = "Chaotic Transformation",
					["azeritePowerID"] = 220,
				}, -- [4]
				{
					["spellID"] = 275934,
					["icon"] = 1097741,
					["name"] = "Seething Power",
					["azeritePowerID"] = 245,
				}, -- [5]
				{
					["spellID"] = 278493,
					["icon"] = 1305152,
					["name"] = "Thirsting Blades",
					["azeritePowerID"] = 352,
				}, -- [6]
				{
					["spellID"] = 278500,
					["icon"] = 463286,
					["name"] = "Eyes of Rage",
					["azeritePowerID"] = 353,
				}, -- [7]
			},
			[581] = {
				{
					["spellID"] = 272983,
					["icon"] = 1344647,
					["name"] = "Revel in Pain",
					["azeritePowerID"] = 134,
				}, -- [1]
				{
					["spellID"] = 273236,
					["icon"] = 1344649,
					["name"] = "Infernal Armor",
					["azeritePowerID"] = 160,
				}, -- [2]
				{
					["spellID"] = 275350,
					["icon"] = 1344645,
					["name"] = "Rigid Carapace",
					["azeritePowerID"] = 221,
				}, -- [3]
				{
					["spellID"] = 288878,
					["icon"] = 615099,
					["name"] = "Hour of Reaping",
					["azeritePowerID"] = 246,
				}, -- [4]
				{
					["spellID"] = 278502,
					["icon"] = 1344652,
					["name"] = "Cycle of Binding",
					["azeritePowerID"] = 354,
				}, -- [5]
				{
					["spellID"] = 278501,
					["icon"] = 1344648,
					["name"] = "Essence Sever",
					["azeritePowerID"] = 355,
				}, -- [6]
			},
		}, -- [12]
	},
	["defensive"] = {
		{
			{
				["spellID"] = 280023,
				["icon"] = 132351,
				["name"] = "Moment of Glory",
				["azeritePowerID"] = 476,
			}, -- [1]
			{
				["spellID"] = 280128,
				["icon"] = 132342,
				["name"] = "Bury the Hatchet",
				["azeritePowerID"] = 477,
			}, -- [2]
			{
				["spellID"] = 288641,
				["icon"] = 132126,
				["name"] = "Intimidating Presence",
				["azeritePowerID"] = 554,
			}, -- [3]
		}, -- [1]
		{
			{
				["spellID"] = 274388,
				["icon"] = 524354,
				["name"] = "Stalwart Protector",
				["azeritePowerID"] = 206,
			}, -- [1]
			{
				["spellID"] = 280017,
				["icon"] = 1360759,
				["name"] = "Gallant Steed",
				["azeritePowerID"] = 471,
			}, -- [2]
			{
				["spellID"] = 287729,
				["icon"] = 135928,
				["name"] = "Empyreal Ward",
				["azeritePowerID"] = 538,
			}, -- [3]
		}, -- [2]
		{
			{
				["spellID"] = 274355,
				["icon"] = 132199,
				["name"] = "Shellshock",
				["azeritePowerID"] = 203,
			}, -- [1]
			{
				["spellID"] = 280014,
				["icon"] = 132293,
				["name"] = "Duck and Cover",
				["azeritePowerID"] = 469,
			}, -- [2]
			{
				["spellID"] = 287938,
				["icon"] = 1014024,
				["name"] = "Nature's Salve",
				["azeritePowerID"] = 543,
			}, -- [3]
		}, -- [3]
		{
			{
				["spellID"] = 274692,
				["icon"] = 132307,
				["name"] = "Footpad",
				["azeritePowerID"] = 217,
			}, -- [1]
			{
				["spellID"] = 280020,
				["icon"] = 136177,
				["name"] = "Shrouded Mantle",
				["azeritePowerID"] = 473,
			}, -- [2]
			{
				["spellID"] = 288079,
				["icon"] = 132301,
				["name"] = "Lying In Wait",
				["azeritePowerID"] = 548,
			}, -- [3]
		}, -- [4]
		{
			{
				["spellID"] = 274366,
				["icon"] = 135994,
				["name"] = "Sanctum",
				["azeritePowerID"] = 204,
			}, -- [1]
			{
				["spellID"] = 280018,
				["icon"] = 136066,
				["name"] = "Twist Magic",
				["azeritePowerID"] = 472,
			}, -- [2]
			{
				["spellID"] = 287717,
				["icon"] = 463835,
				["name"] = "Death Denied",
				["azeritePowerID"] = 537,
			}, -- [3]
		}, -- [5]
		{
			{
				["spellID"] = 280010,
				["icon"] = 136120,
				["name"] = "Runic Barrier",
				["azeritePowerID"] = 201,
			}, -- [1]
			{
				["spellID"] = 280011,
				["icon"] = 237561,
				["name"] = "March of the Damned",
				["azeritePowerID"] = 465,
			}, -- [2]
			{
				["spellID"] = 288424,
				["icon"] = 237525,
				["name"] = "Cold Hearted",
				["azeritePowerID"] = 549,
			}, -- [3]
		}, -- [6]
		{
			{
				["spellID"] = 274412,
				["icon"] = 538565,
				["name"] = "Serene Spirit",
				["azeritePowerID"] = 207,
			}, -- [1]
			{
				["spellID"] = 280021,
				["icon"] = 136095,
				["name"] = "Pack Spirit",
				["azeritePowerID"] = 474,
			}, -- [2]
			{
				["spellID"] = 287774,
				["icon"] = 133439,
				["name"] = "Ancient Ankh Talisman",
				["azeritePowerID"] = 539,
			}, -- [3]
		}, -- [7]
		{
			{
				["spellID"] = 274379,
				["icon"] = 135991,
				["name"] = "Eldritch Warding",
				["azeritePowerID"] = 205,
			}, -- [1]
			{
				["spellID"] = 280015,
				["icon"] = 135736,
				["name"] = "Cauterizing Blink",
				["azeritePowerID"] = 468,
			}, -- [2]
			{
				["spellID"] = 288121,
				["icon"] = 135754,
				["name"] = "Quick Thinking",
				["azeritePowerID"] = 546,
			}, -- [3]
		}, -- [8]
		{
			{
				["spellID"] = 274418,
				["icon"] = 538745,
				["name"] = "Lifeblood",
				["azeritePowerID"] = 208,
			}, -- [1]
			{
				["spellID"] = 280022,
				["icon"] = 136169,
				["name"] = "Desperate Power",
				["azeritePowerID"] = 475,
			}, -- [2]
			{
				["spellID"] = 287822,
				["icon"] = 136183,
				["name"] = "Terror of the Mind",
				["azeritePowerID"] = 531,
			}, -- [3]
		}, -- [9]
		{
			{
				["spellID"] = 274762,
				["icon"] = 606546,
				["name"] = "Strength of Spirit",
				["azeritePowerID"] = 218,
			}, -- [1]
			{
				["spellID"] = 280016,
				["icon"] = 642414,
				["name"] = "Sweep the Leg",
				["azeritePowerID"] = 470,
			}, -- [2]
			{
				["spellID"] = 289322,
				["icon"] = 574574,
				["name"] = "Exit Strategy",
				["azeritePowerID"] = 566,
			}, -- [3]
		}, -- [10]
		{
			{
				["spellID"] = 274813,
				["icon"] = 136080,
				["name"] = "Reawakening",
				["azeritePowerID"] = 219,
			}, -- [1]
			{
				["spellID"] = 280013,
				["icon"] = 136097,
				["name"] = "Ursoc's Endurance",
				["azeritePowerID"] = 467,
			}, -- [2]
			{
				["spellID"] = 287803,
				["icon"] = 135879,
				["name"] = "Switch Hitter",
				["azeritePowerID"] = 540,
			}, -- [3]
		}, -- [11]
		{
			{
				["spellID"] = 274344,
				["icon"] = 1305158,
				["name"] = "Soulmonger",
				["azeritePowerID"] = 202,
			}, -- [1]
			{
				["spellID"] = 280012,
				["icon"] = 828455,
				["name"] = "Burning Soul",
				["azeritePowerID"] = 466,
			}, -- [2]
			{
				["spellID"] = 288973,
				["icon"] = 1392554,
				["name"] = "Thrive in Chaos",
				["azeritePowerID"] = 564,
			}, -- [3]
		}, -- [12]
		["common"] = {
			{
				["spellID"] = 268594,
				["icon"] = 538536,
				["name"] = "Longstrider",
				["azeritePowerID"] = 14,
			}, -- [1]
			{
				["spellID"] = 263962,
				["icon"] = 1769069,
				["name"] = "Resounding Protection",
				["azeritePowerID"] = 15,
			}, -- [2]
			{
				["spellID"] = 268599,
				["icon"] = 237395,
				["name"] = "Vampiric Speed",
				["azeritePowerID"] = 44,
			}, -- [3]
			{
				["spellID"] = 268437,
				["icon"] = 1387707,
				["name"] = "Impassive Visage",
				["azeritePowerID"] = 83,
			}, -- [4]
			{
				["spellID"] = 268595,
				["icon"] = 651746,
				["name"] = "Bulwark of the Masses",
				["azeritePowerID"] = 84,
			}, -- [5]
			{
				["spellID"] = 268596,
				["icon"] = 1686575,
				["name"] = "Gemhide",
				["azeritePowerID"] = 85,
			}, -- [6]
			{
				["spellID"] = 268435,
				["icon"] = 646669,
				["name"] = "Azerite Fortification",
				["azeritePowerID"] = 86,
			}, -- [7]
			{
				["spellID"] = 268600,
				["icon"] = 413591,
				["name"] = "Self Reliance",
				["azeritePowerID"] = 87,
			}, -- [8]
		},
	},
	["role"] = {
		["healer"] = {
			{
				["spellID"] = 267880,
				["icon"] = 463526,
				["name"] = "Woundbinder",
				["azeritePowerID"] = 19,
			}, -- [1]
			{
				["spellID"] = 267883,
				["icon"] = 413576,
				["name"] = "Savior",
				["azeritePowerID"] = 42,
			}, -- [2]
			{
				["spellID"] = 267882,
				["icon"] = 970412,
				["name"] = "Concentrated Mending",
				["azeritePowerID"] = 103,
			}, -- [3]
			{
				["spellID"] = 267884,
				["icon"] = 236832,
				["name"] = "Bracing Chill",
				["azeritePowerID"] = 104,
			}, -- [4]
			{
				["spellID"] = 267886,
				["icon"] = 133020,
				["name"] = "Ephemeral Recovery",
				["azeritePowerID"] = 105,
			}, -- [5]
			{
				["spellID"] = 267889,
				["icon"] = 135905,
				["name"] = "Blessed Portents",
				["azeritePowerID"] = 463,
			}, -- [6]
		},
		["tank"] = {
			{
				["spellID"] = 267671,
				["icon"] = 1029596,
				["name"] = "Winds of War",
				["azeritePowerID"] = 43,
			}, -- [1]
			{
				["spellID"] = 267683,
				["icon"] = 1129419,
				["name"] = "Azerite Veins",
				["azeritePowerID"] = 89,
			}, -- [2]
			{
				["spellID"] = 271536,
				["icon"] = 134978,
				["name"] = "Crystalline Carapace",
				["azeritePowerID"] = 98,
			}, -- [3]
			{
				["spellID"] = 271540,
				["icon"] = 645224,
				["name"] = "Ablative Shielding",
				["azeritePowerID"] = 99,
			}, -- [4]
			{
				["spellID"] = 271546,
				["icon"] = 136031,
				["name"] = "Strength in Numbers",
				["azeritePowerID"] = 100,
			}, -- [5]
			{
				["spellID"] = 271557,
				["icon"] = 1323035,
				["name"] = "Shimmering Haven",
				["azeritePowerID"] = 101,
			}, -- [6]
		},
		["nonhealer"] = {
			{
				["spellID"] = 263984,
				["icon"] = 1029585,
				["name"] = "Elemental Whirl",
				["azeritePowerID"] = 21,
			}, -- [1]
			{
				["spellID"] = 266180,
				["icon"] = 252174,
				["name"] = "Overwhelming Power",
				["azeritePowerID"] = 30,
			}, -- [2]
			{
				["spellID"] = 266937,
				["icon"] = 132109,
				["name"] = "Gutripper",
				["azeritePowerID"] = 31,
			}, -- [3]
			{
				["spellID"] = 266936,
				["icon"] = 646670,
				["name"] = "Azerite Globules",
				["azeritePowerID"] = 462,
			}, -- [4]
		},
		["common"] = {
			{
				["spellID"] = 264108,
				["icon"] = 538560,
				["name"] = "Blood Siphon",
				["azeritePowerID"] = 18,
			}, -- [1]
			{
				["spellID"] = 267665,
				["icon"] = 236166,
				["name"] = "Lifespeed",
				["azeritePowerID"] = 20,
			}, -- [2]
			{
				["spellID"] = 263987,
				["icon"] = 237589,
				["name"] = "Heed My Call",
				["azeritePowerID"] = 22,
			}, -- [3]
			{
				["spellID"] = 267879,
				["icon"] = 132565,
				["name"] = "On My Way",
				["azeritePowerID"] = 38,
			}, -- [4]
			{
				["spellID"] = 279899,
				["icon"] = 514016,
				["name"] = "Unstable Flames",
				["azeritePowerID"] = 459,
			}, -- [5]
			{
				["spellID"] = 279926,
				["icon"] = 2065623,
				["name"] = "Earthlink",
				["azeritePowerID"] = 461,
			}, -- [6]
			{
				["spellID"] = 317137,
				["icon"] = 839910,
				["name"] = "Heart of Darkness",
				["azeritePowerID"] = 582,
			}, -- [7]
		},
	},
	["raid"] = {
		{
			["spellID"] = 280555,
			["icon"] = 2000853,
			["name"] = "Archive of the Titans",
			["azeritePowerID"] = 483,
		}, -- [1]
		{
			["spellID"] = 280559,
			["icon"] = 136039,
			["name"] = "Laser Matrix",
			["azeritePowerID"] = 485,
		}, -- [2]
		{
			["spellID"] = 288802,
			["icon"] = 895888,
			["name"] = "Bonded Souls",
			["azeritePowerID"] = 560,
		}, -- [3]
		{
			["spellID"] = 288749,
			["icon"] = 2442247,
			["name"] = "Seductive Power",
			["azeritePowerID"] = 561,
		}, -- [4]
		{
			["spellID"] = 288953,
			["icon"] = 1778226,
			["name"] = "Treacherous Covenant",
			["azeritePowerID"] = 562,
		}, -- [5]
		{
			["spellID"] = 303008,
			["icon"] = 1698701,
			["name"] = "Undulating Tides",
			["azeritePowerID"] = 575,
		}, -- [6]
		{
			["spellID"] = 303007,
			["icon"] = 136159,
			["name"] = "Loyal to the End",
			["azeritePowerID"] = 576,
		}, -- [7]
		{
			["spellID"] = 303006,
			["icon"] = 1391778,
			["name"] = "Arcane Heart",
			["azeritePowerID"] = 577,
		}, -- [8]
	},
	["zone"] = {
		{
			["spellID"] = 280710,
			["icon"] = 135885,
			["name"] = "Champion of Azeroth",
			["azeritePowerID"] = 82,
		}, -- [1]
		{
			["spellID"] = 273150,
			["icon"] = 135780,
			["name"] = "Ruinous Bolt",
			["azeritePowerID"] = 156,
		}, -- [2]
		{
			["spellID"] = 273790,
			["icon"] = 2011133,
			["name"] = "Rezan's Fury",
			["azeritePowerID"] = 157,
		}, -- [3]
		{
			["spellID"] = 273682,
			["icon"] = 132299,
			["name"] = "Meticulous Scheming",
			["azeritePowerID"] = 192,
		}, -- [4]
		{
			["spellID"] = 273823,
			["icon"] = 1778229,
			["name"] = "Blightborne Infusion",
			["azeritePowerID"] = 193,
		}, -- [5]
		{
			["spellID"] = 273834,
			["icon"] = 840409,
			["name"] = "Filthy Transfusion",
			["azeritePowerID"] = 194,
		}, -- [6]
		{
			["spellID"] = 273829,
			["icon"] = 463858,
			["name"] = "Secrets of the Deep",
			["azeritePowerID"] = 195,
		}, -- [7]
		{
			["spellID"] = 280429,
			["icon"] = 796638,
			["name"] = "Swirling Sands",
			["azeritePowerID"] = 196,
		}, -- [8]
		{
			["spellID"] = 280402,
			["icon"] = 1698701,
			["name"] = "Tidal Surge",
			["azeritePowerID"] = 478,
		}, -- [9]
		{
			["spellID"] = 280284,
			["icon"] = 135642,
			["name"] = "Dagger in the Back",
			["azeritePowerID"] = 479,
		}, -- [10]
		{
			["spellID"] = 280407,
			["icon"] = 463568,
			["name"] = "Blood Rite",
			["azeritePowerID"] = 480,
		}, -- [11]
		{
			["spellID"] = 280410,
			["icon"] = 132193,
			["name"] = "Incite the Pack",
			["azeritePowerID"] = 481,
		}, -- [12]
		{
			["spellID"] = 280380,
			["icon"] = 839983,
			["name"] = "Thunderous Blast",
			["azeritePowerID"] = 482,
		}, -- [13]
		{
			["spellID"] = 281514,
			["icon"] = 2032578,
			["name"] = "Unstable Catalyst",
			["azeritePowerID"] = 504,
		}, -- [14]
		{
			["spellID"] = 281841,
			["icon"] = 1029595,
			["name"] = "Tradewinds",
			["azeritePowerID"] = 505,
		}, -- [15]
		{
			["spellID"] = 287467,
			["icon"] = 135900,
			["name"] = "Shadow of Elune",
			["azeritePowerID"] = 521,
		}, -- [16]
		{
			["spellID"] = 287604,
			["icon"] = 874580,
			["name"] = "Ancients' Bulwark",
			["azeritePowerID"] = 522,
		}, -- [17]
		{
			["spellID"] = 287631,
			["icon"] = 463547,
			["name"] = "Apothecary's Concoctions",
			["azeritePowerID"] = 523,
		}, -- [18]
		{
			["spellID"] = 287662,
			["icon"] = 2357388,
			["name"] = "Endless Hunger",
			["azeritePowerID"] = 526,
		}, -- [19]
		{
			["spellID"] = 300168,
			["icon"] = 2115322,
			["name"] = "Person-Computer Interface",
			["azeritePowerID"] = 568,
		}, -- [20]
		{
			["spellID"] = 300170,
			["icon"] = 134377,
			["name"] = "Clockwork Heart",
			["azeritePowerID"] = 569,
		}, -- [21]
	},
	["profession"] = {
		{
			["spellID"] = 280163,
			["icon"] = 463515,
			["name"] = "Barrage Of Many Bombs",
			["azeritePowerID"] = 498,
		}, -- [1]
		{
			["spellID"] = 280168,
			["icon"] = 134427,
			["name"] = "Ricocheting Inflatable Pyrosaw",
			["azeritePowerID"] = 499,
		}, -- [2]
		{
			["spellID"] = 280174,
			["icon"] = 1320373,
			["name"] = "Synaptic Spark Capacitor",
			["azeritePowerID"] = 500,
		}, -- [3]
		{
			["spellID"] = 280178,
			["icon"] = 133873,
			["name"] = "Relational Normalization Gizmo",
			["azeritePowerID"] = 501,
		}, -- [4]
		{
			["spellID"] = 280181,
			["icon"] = 1336885,
			["name"] = "Personal Absorb-o-Tron",
			["azeritePowerID"] = 502,
		}, -- [5]
		{
			["spellID"] = 280172,
			["icon"] = 514950,
			["name"] = "Auto-Self-Cauterizer",
			["azeritePowerID"] = 503,
		}, -- [6]
	},
	["pvp"] = {
		{
			["spellID"] = 280577,
			["icon"] = 1028980,
			["name"] = "Glory in Battle",
			["azeritePowerID"] = 486,
		}, -- [1]
		{
			["spellID"] = 280579,
			["icon"] = 1035504,
			["name"] = "Retaliatory Fury",
			["azeritePowerID"] = 487,
		}, -- [2]
		{
			["spellID"] = 280582,
			["icon"] = 236646,
			["name"] = "Battlefield Focus",
			["azeritePowerID"] = 488,
		}, -- [3]
		{
			["spellID"] = 280598,
			["icon"] = 236560,
			["name"] = "Sylvanas' Resolve",
			["azeritePowerID"] = 489,
		}, -- [4]
		{
			["spellID"] = 280580,
			["icon"] = 236324,
			["name"] = "Combined Might",
			["azeritePowerID"] = 490,
		}, -- [5]
		{
			["spellID"] = 280581,
			["icon"] = 136003,
			["name"] = "Collective Will",
			["azeritePowerID"] = 491,
		}, -- [6]
		{
			["spellID"] = 280623,
			["icon"] = 1028984,
			["name"] = "Liberator's Might",
			["azeritePowerID"] = 492,
		}, -- [7]
		{
			["spellID"] = 280624,
			["icon"] = 236478,
			["name"] = "Last Gift",
			["azeritePowerID"] = 493,
		}, -- [8]
		{
			["spellID"] = 280627,
			["icon"] = 132486,
			["name"] = "Battlefield Precision",
			["azeritePowerID"] = 494,
		}, -- [9]
		{
			["spellID"] = 280628,
			["icon"] = 1042294,
			["name"] = "Anduin's Dedication",
			["azeritePowerID"] = 495,
		}, -- [10]
		{
			["spellID"] = 280625,
			["icon"] = 2022762,
			["name"] = "Stronger Together",
			["azeritePowerID"] = 496,
		}, -- [11]
		{
			["spellID"] = 280626,
			["icon"] = 236344,
			["name"] = "Stand As One",
			["azeritePowerID"] = 497,
		}, -- [12]
		{
			["spellID"] = 287818,
			["icon"] = 236310,
			["name"] = "Fight or Flight",
			["azeritePowerID"] = 541,
		}, -- [13]
	}
}
n.sourceData = sourceData
-- 8.3 Azerite Essences
local essenceData = {
	["common"] = {
		{
			["essenceID"] = 4,
			["name"] = "Worldvein Resonance",
			["icon"] = 1830317,
		}, -- [1]
		{
			["essenceID"] = 12,
			["name"] = "The Crucible of Flame",
			["icon"] = 3015740,
		}, -- [2]
		{
			["essenceID"] = 15,
			["name"] = "Ripple in Space",
			["icon"] = 2967109,
		}, -- [3]
		{
			["essenceID"] = 22,
			["name"] = "Vision of Perfection",
			["icon"] = 3015743,
		}, -- [4]
		{
			["essenceID"] = 27,
			["name"] = "Memory of Lucid Dreams",
			["icon"] = 2967104,
		}, -- [5]
		{
			["essenceID"] = 32,
			["name"] = "Conflict and Strife",
			["icon"] = 3015742,
		}, -- [6]
		{
			["essenceID"] = 37,
			["name"] = "The Formless Void",
			["icon"] = 3193845,
		}, -- [7]
	},
	["tank"] = {
		{
			["essenceID"] = 2,
			["name"] = "Azeroth's Undying Gift",
			["icon"] = 2967107,
		}, -- [1]
		{
			["essenceID"] = 3,
			["name"] = "Sphere of Suppression",
			["icon"] = 2065602,
		}, -- [2]
		{
			["essenceID"] = 7,
			["name"] = "Anima of Life and Death",
			["icon"] = 2967105,
		}, -- [3]
		{
			["essenceID"] = 13,
			["name"] = "Nullification Dynamo",
			["icon"] = 3015741,
		}, -- [4]
		{
			["essenceID"] = 25,
			["name"] = "Aegis of the Deep",
			["icon"] = 2967110,
		}, -- [5]
		{
			["essenceID"] = 33,
			["name"] = "Touch of the Everlasting",
			["icon"] = 3193847,
		}, -- [6]
		{
			["essenceID"] = 34,
			["name"] = "Strength of the Warden",
			["icon"] = 3193846,
		}, -- [7]
	},
	["healer"] = {
		{
			["essenceID"] = 16,
			["name"] = "Unwavering Ward",
			["icon"] = 3193842,
		}, -- [1]
		{
			["essenceID"] = 17,
			["name"] = "The Ever-Rising Tide",
			["icon"] = 2967108,
		}, -- [2]
		{
			["essenceID"] = 18,
			["name"] = "Artifice of Time",
			["icon"] = 2967112,
		}, -- [3]
		{
			["essenceID"] = 19,
			["name"] = "The Well of Existence",
			["icon"] = 516796,
		}, -- [4]
		{
			["essenceID"] = 20,
			["name"] = "Life-Binder's Invocation",
			["icon"] = 2967106,
		}, -- [5]
		{
			["essenceID"] = 21,
			["name"] = "Vitality Conduit",
			["icon"] = 2967100,
		}, -- [6]
		{
			["essenceID"] = 24,
			["name"] = "Spirit of Preservation",
			["icon"] = 2967101,
		}, -- [7]
	},
	["damager"] = {
		{
			["essenceID"] = 5,
			["name"] = "Essence of the Focusing Iris",
			["icon"] = 2967111,
		}, -- [1]
		{
			["essenceID"] = 6,
			["name"] = "Purification Protocol",
			["icon"] = 2967103,
		}, -- [2]
		{
			["essenceID"] = 14,
			["name"] = "Condensed Life-Force",
			["icon"] = 2967113,
		}, -- [3]
		{
			["essenceID"] = 23,
			["name"] = "Blood of the Enemy",
			["icon"] = 2032580,
		}, -- [4]
		{
			["essenceID"] = 28,
			["name"] = "The Unbound Force",
			["icon"] = 2967102,
		}, -- [5]
		{
			["essenceID"] = 35,
			["name"] = "Breath of the Dying",
			["icon"] = 3193844,
		}, -- [6]
		{
			["essenceID"] = 36,
			["name"] = "Spark of Inspiration",
			["icon"] = 3193843,
		}, -- [7]
	}
}
n.essenceData = essenceData

-- Default Scales Data
--[[
local defaultName = U["DefaultScaleName_Default"]
local defensiveName = U["DefaultScaleName_Defensive"]
local offensiveName = U["DefaultScaleName_Offensive"]
local defaultNameTable = {
	--[defaultName] = true,
	[defensiveName] = true,
	[offensiveName] = true
}
]]
local defaultName = "Default"
local defensiveName = "Defensive"
local offensiveName = "Offensive"
local defaultNameTable = {
	[defaultName] = U["DefaultScaleName_Default"],
	[defensiveName] = U["DefaultScaleName_Defensive"],
	[offensiveName] = U["DefaultScaleName_Offensive"]
}
n.defaultNameTable = defaultNameTable
local defaultScalesData = {}
n.defaultScalesData = defaultScalesData

local function insertDefaultScalesData(scaleName, classIndex, specNum, powerScales, essenceScales, timestamp)
	defaultScalesData[#defaultScalesData + 1] = {
		scaleName,
		classIndex,
		specNum,
		powerScales,
		essenceScales,
		timestamp
	}
end

do
		insertDefaultScalesData(defaultName, 12, 1, { -- Havoc Demon Hunter
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 74500 - 83001 (avg 78758), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[561] = 2.59, -- Seductive Power
			[42] = 0.08, -- Savior
			[461] = 0.95, -- Earthlink
			[159] = 10, -- Furious Gaze
			[482] = 3.14, -- Thunderous Blast
			[541] = 1.2, -- Fight or Flight
			[196] = 4.8, -- Swirling Sands
			[569] = 5.91, -- Clockwork Heart
			[156] = 2.39, -- Ruinous Bolt
			[18] = 1.03, -- Blood Siphon
			[195] = 2.94, -- Secrets of the Deep
			[480] = 4.44, -- Blood Rite
			[478] = 3.72, -- Tidal Surge
			[192] = 3.45, -- Meticulous Scheming
			[44] = 0.02, -- Vampiric Speed
			[459] = 2.01, -- Unstable Flames
			[101] = 0.05, -- Shimmering Haven
			[157] = 3.89, -- Rezan's Fury
			[496] = 1.25, -- Stronger Together
			[494] = 4.1, -- Battlefield Precision
			[503] = 0.02, -- Auto-Self-Cauterizer
			[43] = 0.03, -- Winds of War
			[493] = 1.48, -- Last Gift
			[499] = 1.55, -- Ricocheting Inflatable Pyrosaw
			[560] = 2.32, -- Bonded Souls
			[19] = 0.03, -- Woundbinder
			[85] = 0.07, -- Gemhide
			[20] = 2.2, -- Lifespeed
			[194] = 3.13, -- Filthy Transfusion
			[505] = 2.75, -- Tradewinds
			[577] = 3.46, -- Arcane Heart
			[502] = 0.04, -- Personal Absorb-o-Tron
			[87] = 0.03, -- Self Reliance
			[481] = 2.5, -- Incite the Pack
			[582] = 5.37, -- Heart of Darkness
			[22] = 1.68, -- Heed My Call
			[84] = 0.07, -- Bulwark of the Masses
			[485] = 3.26, -- Laser Matrix
			[21] = 1.9, -- Elemental Whirl
			[479] = 4.09, -- Dagger in the Back
			[492] = 3.97, -- Liberator's Might
			[575] = 6.22, -- Undulating Tides
			[99] = 0.02, -- Ablative Shielding
			[500] = 2.01, -- Synaptic Spark Capacitor
			[104] = 0.02, -- Bracing Chill
			[193] = 5.67, -- Blightborne Infusion
			[504] = 2.68, -- Unstable Catalyst
			[562] = 4.61, -- Treacherous Covenant
			[31] = 1.98, -- Gutripper
			[220] = 3.74, -- Chaotic Transformation
			[353] = 5.1, -- Eyes of Rage
			[86] = 0.02, -- Azerite Fortification
			[495] = 2.88, -- Anduin's Dedication
			[523] = 3.21, -- Apothecary's Concoctions
			[30] = 3.33, -- Overwhelming Power
			[497] = 0.73, -- Stand As One
			[352] = 4.75, -- Thirsting Blades
			[89] = 0.06, -- Azerite Veins
			[100] = 0.04, -- Strength in Numbers
			[126] = 3.81, -- Revolving Blades
			[38] = 1.69, -- On My Way
			[521] = 4.55, -- Shadow of Elune
			[483] = 3.2, -- Archive of the Titans
			[15] = 0.07, -- Resounding Protection
			[462] = 1.18, -- Azerite Globules
			[526] = 5.78, -- Endless Hunger
			[498] = 2.46, -- Barrage Of Many Bombs
			[202] = 0.05, -- Soulmonger
			[576] = 1.88, -- Loyal to the End
			[14] = 0.05, -- Longstrider
			[245] = 3.21, -- Seething Power
			[82] = 5.42, -- Champion of Azeroth
			[501] = 4.13, -- Relational Normalization Gizmo
			[522] = 5.83, -- Ancients' Bulwark
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 69800 - 80702 (avg 77387), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[36] = { 1.27, 1.23 }, -- Spark of Inspiration
			[12] = { 5.33, 2.11 }, -- The Crucible of Flame
			[35] = { 10, 4.49 }, -- Breath of the Dying
			[4] = { 3.63, 0.82 }, -- Worldvein Resonance
			[32] = { 0, 2.14 }, -- Conflict and Strife
			[27] = { 2.37, 1.33 }, -- Memory of Lucid Dreams
			[5] = { 7.51, 4.12 }, -- Essence of the Focusing Iris
			[37] = { 2.3, 2.35 }, -- The Formless Void
			[28] = { 4.43, 1.8 }, -- The Unbound Force
			[6] = { 4.8, 2.03 }, -- Purification Protocol
			[22] = { 5.65, 0 }, -- Vision of Perfection
			[14] = { 6.25, 2.36 }, -- Condensed Life-Force
			[23] = { 5.48, 2.72 }, -- Blood of the Enemy
			[15] = { 2.74, 0 }, -- Ripple in Space
		}, 1584093600)

		insertDefaultScalesData(offensiveName, 12, 2, { -- Vengeance Demon Hunter
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 13202 - 16103 (avg 13769), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[504] = 3.05, -- Unstable Catalyst
			[157] = 6.3, -- Rezan's Fury
			[20] = 1.92, -- Lifespeed
			[196] = 5.73, -- Swirling Sands
			[482] = 5.2, -- Thunderous Blast
			[100] = 0.01, -- Strength in Numbers
			[582] = 5.93, -- Heart of Darkness
			[485] = 5.2, -- Laser Matrix
			[560] = 1.91, -- Bonded Souls
			[526] = 6.93, -- Endless Hunger
			[480] = 4.04, -- Blood Rite
			[569] = 6.5, -- Clockwork Heart
			[522] = 7.1, -- Ancients' Bulwark
			[246] = 0.07, -- Hour of Reaping
			[541] = 1.32, -- Fight or Flight
			[577] = 2.21, -- Arcane Heart
			[497] = 0.94, -- Stand As One
			[479] = 4.61, -- Dagger in the Back
			[499] = 2.46, -- Ricocheting Inflatable Pyrosaw
			[521] = 4.05, -- Shadow of Elune
			[38] = 1.91, -- On My Way
			[483] = 3.83, -- Archive of the Titans
			[496] = 1.57, -- Stronger Together
			[463] = 0.04, -- Blessed Portents
			[503] = 0.02, -- Auto-Self-Cauterizer
			[30] = 2.98, -- Overwhelming Power
			[568] = 0.02, -- Person-Computer Interface
			[156] = 3.69, -- Ruinous Bolt
			[85] = 0.04, -- Gemhide
			[105] = 0.03, -- Ephemeral Recovery
			[83] = 0.03, -- Impassive Visage
			[98] = 0.57, -- Crystalline Carapace
			[492] = 4.08, -- Liberator's Might
			[500] = 3.32, -- Synaptic Spark Capacitor
			[193] = 6.96, -- Blightborne Infusion
			[466] = 0.04, -- Burning Soul
			[523] = 5.19, -- Apothecary's Concoctions
			[501] = 4.32, -- Relational Normalization Gizmo
			[194] = 5, -- Filthy Transfusion
			[22] = 2.66, -- Heed My Call
			[31] = 3.16, -- Gutripper
			[82] = 6.32, -- Champion of Azeroth
			[461] = 1.19, -- Earthlink
			[498] = 3.92, -- Barrage Of Many Bombs
			[481] = 3.29, -- Incite the Pack
			[478] = 6.16, -- Tidal Surge
			[192] = 5.26, -- Meticulous Scheming
			[495] = 3.32, -- Anduin's Dedication
			[18] = 1.4, -- Blood Siphon
			[561] = 3.72, -- Seductive Power
			[459] = 2.61, -- Unstable Flames
			[575] = 10, -- Undulating Tides
			[462] = 1.92, -- Azerite Globules
			[505] = 3.59, -- Tradewinds
			[493] = 1.9, -- Last Gift
			[86] = 0.04, -- Azerite Fortification
			[195] = 3.36, -- Secrets of the Deep
			[562] = 5.19, -- Treacherous Covenant
			[494] = 6.51, -- Battlefield Precision
			[21] = 2.17, -- Elemental Whirl
			[576] = 2.41, -- Loyal to the End
			[160] = 0.04, -- Infernal Armor
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 12703 - 14403 (avg 13684), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[12] = { 10, 2.9 }, -- The Crucible of Flame
			[22] = { 2.5, 0.76 }, -- Vision of Perfection
			[34] = { 0.03, 0 }, -- Strength of the Warden
			[25] = { 0.96, 1.02 }, -- Aegis of the Deep
			[37] = { 2.37, 2.27 }, -- The Formless Void
			[7] = { 5.12, 1.55 }, -- Anima of Life and Death
			[4] = { 3.48, 0.89 }, -- Worldvein Resonance
			[15] = { 3.28, 0 }, -- Ripple in Space
			[27] = { 1.65, 1.36 }, -- Memory of Lucid Dreams
			[32] = { 2.1, 2.13 }, -- Conflict and Strife
			[3] = { 3.84, 3.83 }, -- Sphere of Suppression
		}, 1584093600)

		insertDefaultScalesData(offensiveName, 6, 1, { -- Blood Death Knight
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 18402 - 21602 (avg 19678), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[38] = 2.28, -- On My Way
			[481] = 3.4, -- Incite the Pack
			[157] = 6.4, -- Rezan's Fury
			[83] = 0.03, -- Impassive Visage
			[99] = 0.05, -- Ablative Shielding
			[492] = 4.65, -- Liberator's Might
			[103] = 0.05, -- Concentrated Mending
			[504] = 2.88, -- Unstable Catalyst
			[561] = 3.93, -- Seductive Power
			[483] = 3.68, -- Archive of the Titans
			[105] = 0.05, -- Ephemeral Recovery
			[568] = 0.01, -- Person-Computer Interface
			[459] = 2.69, -- Unstable Flames
			[521] = 4.37, -- Shadow of Elune
			[195] = 3.14, -- Secrets of the Deep
			[193] = 7.91, -- Blightborne Infusion
			[522] = 8.07, -- Ancients' Bulwark
			[156] = 3.57, -- Ruinous Bolt
			[348] = 2.97, -- Eternal Rune Weapon
			[523] = 5.19, -- Apothecary's Concoctions
			[494] = 6.35, -- Battlefield Precision
			[31] = 3.09, -- Gutripper
			[582] = 6.35, -- Heart of Darkness
			[22] = 2.84, -- Heed My Call
			[461] = 1.14, -- Earthlink
			[100] = 0.06, -- Strength in Numbers
			[21] = 2.25, -- Elemental Whirl
			[140] = 0.74, -- Bone Spike Graveyard
			[192] = 5.39, -- Meticulous Scheming
			[194] = 5.16, -- Filthy Transfusion
			[505] = 3.58, -- Tradewinds
			[18] = 1.28, -- Blood Siphon
			[560] = 2.15, -- Bonded Souls
			[501] = 4.29, -- Relational Normalization Gizmo
			[485] = 5.24, -- Laser Matrix
			[479] = 4.57, -- Dagger in the Back
			[349] = 0.49, -- Bones of the Damned
			[577] = 2.07, -- Arcane Heart
			[196] = 6.55, -- Swirling Sands
			[526] = 8.14, -- Endless Hunger
			[500] = 3.13, -- Synaptic Spark Capacitor
			[85] = 0.07, -- Gemhide
			[482] = 5.17, -- Thunderous Blast
			[498] = 4.11, -- Barrage Of Many Bombs
			[106] = 1.7, -- Deep Cuts
			[493] = 1.96, -- Last Gift
			[499] = 2.46, -- Ricocheting Inflatable Pyrosaw
			[569] = 7.55, -- Clockwork Heart
			[495] = 3.24, -- Anduin's Dedication
			[496] = 1.57, -- Stronger Together
			[30] = 3.2, -- Overwhelming Power
			[87] = 0.14, -- Self Reliance
			[541] = 1.26, -- Fight or Flight
			[43] = 0.11, -- Winds of War
			[82] = 6.59, -- Champion of Azeroth
			[562] = 4.94, -- Treacherous Covenant
			[462] = 1.8, -- Azerite Globules
			[104] = 0.03, -- Bracing Chill
			[478] = 5.86, -- Tidal Surge
			[575] = 10, -- Undulating Tides
			[480] = 4.34, -- Blood Rite
			[497] = 0.85, -- Stand As One
			[243] = 4.38, -- Bloody Runeblade
			[13] = 0.02, -- Azerite Empowered
			[576] = 2.42, -- Loyal to the End
			[98] = 0.67, -- Crystalline Carapace
			[20] = 1.91, -- Lifespeed
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 17803 - 20201 (avg 19512), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[12] = { 10, 2.87 }, -- The Crucible of Flame
			[37] = { 2.31, 2.22 }, -- The Formless Void
			[25] = { 1.19, 1.13 }, -- Aegis of the Deep
			[27] = { 4.84, 3.08 }, -- Memory of Lucid Dreams
			[32] = { 2.49, 2.44 }, -- Conflict and Strife
			[3] = { 4.21, 4.14 }, -- Sphere of Suppression
			[15] = { 3.61, 0.07 }, -- Ripple in Space
			[7] = { 4.9, 1.84 }, -- Anima of Life and Death
			[33] = { 0.04, 0.09 }, -- Touch of the Everlasting
			[4] = { 3.69, 0.86 }, -- Worldvein Resonance
			[22] = { 0.44, 0.03 }, -- Vision of Perfection
		}, 1584093600)

		insertDefaultScalesData(defaultName, 6, 2, { -- Frost Death Knight
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 64602 - 72300 (avg 67977), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[30] = 4.26, -- Overwhelming Power
			[242] = 4.19, -- Echoing Howl
			[196] = 7.37, -- Swirling Sands
			[494] = 4.97, -- Battlefield Precision
			[575] = 7.7, -- Undulating Tides
			[577] = 5.83, -- Arcane Heart
			[501] = 5.63, -- Relational Normalization Gizmo
			[569] = 7.88, -- Clockwork Heart
			[495] = 4.85, -- Anduin's Dedication
			[485] = 3.88, -- Laser Matrix
			[459] = 2.98, -- Unstable Flames
			[31] = 2.47, -- Gutripper
			[156] = 2.63, -- Ruinous Bolt
			[561] = 4.21, -- Seductive Power
			[461] = 1.64, -- Earthlink
			[198] = 3.77, -- Frostwhelp's Indignation
			[108] = 5.05, -- Icy Citadel
			[481] = 5.77, -- Incite the Pack
			[21] = 2.85, -- Elemental Whirl
			[576] = 4.24, -- Loyal to the End
			[463] = 0.04, -- Blessed Portents
			[482] = 3.95, -- Thunderous Blast
			[496] = 2.02, -- Stronger Together
			[522] = 9.94, -- Ancients' Bulwark
			[141] = 4.79, -- Latent Chill
			[582] = 8.3, -- Heart of Darkness
			[38] = 2.75, -- On My Way
			[194] = 3.9, -- Filthy Transfusion
			[549] = 0.01, -- Cold Hearted
			[18] = 2.35, -- Blood Siphon
			[500] = 2.52, -- Synaptic Spark Capacitor
			[19] = 0.1, -- Woundbinder
			[480] = 5.63, -- Blood Rite
			[479] = 5.11, -- Dagger in the Back
			[526] = 10, -- Endless Hunger
			[22] = 2.06, -- Heed My Call
			[465] = 0.03, -- March of the Damned
			[346] = 4.08, -- Killer Frost
			[504] = 4.32, -- Unstable Catalyst
			[462] = 1.43, -- Azerite Globules
			[347] = 5.36, -- Frozen Tempest
			[560] = 2.8, -- Bonded Souls
			[478] = 4.54, -- Tidal Surge
			[105] = 0.05, -- Ephemeral Recovery
			[493] = 3.2, -- Last Gift
			[20] = 2.66, -- Lifespeed
			[195] = 4.83, -- Secrets of the Deep
			[497] = 1.23, -- Stand As One
			[523] = 3.86, -- Apothecary's Concoctions
			[82] = 8.44, -- Champion of Azeroth
			[192] = 5.75, -- Meticulous Scheming
			[43] = 0.04, -- Winds of War
			[193] = 8.69, -- Blightborne Infusion
			[201] = 0.05, -- Runic Barrier
			[505] = 6.24, -- Tradewinds
			[502] = 0.05, -- Personal Absorb-o-Tron
			[541] = 1.75, -- Fight or Flight
			[562] = 7.59, -- Treacherous Covenant
			[42] = 0.03, -- Savior
			[498] = 2.96, -- Barrage Of Many Bombs
			[499] = 1.79, -- Ricocheting Inflatable Pyrosaw
			[483] = 5.49, -- Archive of the Titans
			[521] = 5.54, -- Shadow of Elune
			[89] = 0.01, -- Azerite Veins
			[157] = 4.86, -- Rezan's Fury
			[492] = 5.29, -- Liberator's Might
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 60603 - 69803 (avg 66323), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[32] = { 6.39, 2.73 }, -- Conflict and Strife
			[14] = { 5.61, 2.28 }, -- Condensed Life-Force
			[37] = { 3.08, 3.09 }, -- The Formless Void
			[28] = { 5.03, 2.25 }, -- The Unbound Force
			[23] = { 7.85, 1.87 }, -- Blood of the Enemy
			[27] = { 8.87, 4.83 }, -- Memory of Lucid Dreams
			[36] = { 0.9, 0.93 }, -- Spark of Inspiration
			[5] = { 7.79, 4.02 }, -- Essence of the Focusing Iris
			[15] = { 3.43, 0 }, -- Ripple in Space
			[12] = { 5.35, 2.05 }, -- The Crucible of Flame
			[35] = { 10, 4.4 }, -- Breath of the Dying
			[4] = { 5.52, 1.07 }, -- Worldvein Resonance
			[22] = { 2.55, 0 }, -- Vision of Perfection
			[6] = { 5.08, 2.04 }, -- Purification Protocol
		}, 1584180000)

		insertDefaultScalesData(defaultName, 6, 3, { -- Unholy Death Knight
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 24000 - 27602 (avg 24998), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[493] = 2.72, -- Last Gift
			[499] = 2.27, -- Ricocheting Inflatable Pyrosaw
			[192] = 5.76, -- Meticulous Scheming
			[18] = 1.85, -- Blood Siphon
			[38] = 2.68, -- On My Way
			[577] = 2.94, -- Arcane Heart
			[505] = 4.9, -- Tradewinds
			[576] = 3.37, -- Loyal to the End
			[103] = 0.04, -- Concentrated Mending
			[498] = 3.78, -- Barrage Of Many Bombs
			[21] = 2.65, -- Elemental Whirl
			[462] = 1.72, -- Azerite Globules
			[541] = 1.77, -- Fight or Flight
			[500] = 2.54, -- Synaptic Spark Capacitor
			[492] = 5.05, -- Liberator's Might
			[481] = 4.64, -- Incite the Pack
			[526] = 9.62, -- Endless Hunger
			[478] = 4.84, -- Tidal Surge
			[193] = 8.77, -- Blightborne Infusion
			[522] = 9.64, -- Ancients' Bulwark
			[244] = 5.77, -- Harrowing Decay
			[199] = 10, -- Festermight
			[562] = 7.94, -- Treacherous Covenant
			[31] = 2.78, -- Gutripper
			[15] = 0.03, -- Resounding Protection
			[483] = 5.37, -- Archive of the Titans
			[497] = 1.14, -- Stand As One
			[569] = 8.79, -- Clockwork Heart
			[461] = 1.73, -- Earthlink
			[560] = 2.87, -- Bonded Souls
			[503] = 0.03, -- Auto-Self-Cauterizer
			[496] = 1.74, -- Stronger Together
			[582] = 7.63, -- Heart of Darkness
			[523] = 4.67, -- Apothecary's Concoctions
			[195] = 4.92, -- Secrets of the Deep
			[82] = 7.62, -- Champion of Azeroth
			[142] = 4.59, -- Helchains
			[459] = 3.07, -- Unstable Flames
			[351] = 2.54, -- Last Surprise
			[501] = 5.09, -- Relational Normalization Gizmo
			[22] = 2.46, -- Heed My Call
			[194] = 4.74, -- Filthy Transfusion
			[157] = 5.67, -- Rezan's Fury
			[479] = 6.13, -- Dagger in the Back
			[30] = 3.57, -- Overwhelming Power
			[575] = 9.26, -- Undulating Tides
			[561] = 4.67, -- Seductive Power
			[485] = 4.67, -- Laser Matrix
			[568] = 0.04, -- Person-Computer Interface
			[109] = 6.49, -- Magus of the Dead
			[494] = 5.83, -- Battlefield Precision
			[196] = 7.44, -- Swirling Sands
			[350] = 3.7, -- Cankerous Wounds
			[156] = 2.6, -- Ruinous Bolt
			[20] = 2.31, -- Lifespeed
			[521] = 4.63, -- Shadow of Elune
			[480] = 4.69, -- Blood Rite
			[482] = 4.93, -- Thunderous Blast
			[495] = 4.89, -- Anduin's Dedication
			[504] = 4.53, -- Unstable Catalyst
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 22701 - 25504 (avg 24543), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[36] = { 0.8, 0.79 }, -- Spark of Inspiration
			[35] = { 10, 4.7 }, -- Breath of the Dying
			[27] = { 4.7, 2.94 }, -- Memory of Lucid Dreams
			[37] = { 2.84, 2.76 }, -- The Formless Void
			[5] = { 8.3, 3.18 }, -- Essence of the Focusing Iris
			[12] = { 6, 1.93 }, -- The Crucible of Flame
			[15] = { 3.54, 0 }, -- Ripple in Space
			[4] = { 5.25, 0.92 }, -- Worldvein Resonance
			[32] = { 2.35, 2.15 }, -- Conflict and Strife
			[14] = { 6, 2.53 }, -- Condensed Life-Force
			[23] = { 5.55, 1.16 }, -- Blood of the Enemy
			[6] = { 5.1, 2.03 }, -- Purification Protocol
			[28] = { 5.02, 2.02 }, -- The Unbound Force
		}, 1584180000)

		insertDefaultScalesData(defaultName, 11, 1, { -- Balance Druid
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 17501 - 21500 (avg 18437), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[173] = 2.18, -- Power of the Moon
			[498] = 2.14, -- Barrage Of Many Bombs
			[526] = 6.37, -- Endless Hunger
			[560] = 1.96, -- Bonded Souls
			[20] = 1.86, -- Lifespeed
			[541] = 1, -- Fight or Flight
			[494] = 3.39, -- Battlefield Precision
			[561] = 2.66, -- Seductive Power
			[31] = 1.59, -- Gutripper
			[485] = 2.73, -- Laser Matrix
			[497] = 0.61, -- Stand As One
			[500] = 1.66, -- Synaptic Spark Capacitor
			[523] = 2.82, -- Apothecary's Concoctions
			[459] = 2.03, -- Unstable Flames
			[569] = 6.53, -- Clockwork Heart
			[496] = 1.24, -- Stronger Together
			[157] = 3.36, -- Rezan's Fury
			[479] = 3.54, -- Dagger in the Back
			[483] = 3.29, -- Archive of the Titans
			[250] = 3.19, -- Dawning Sun
			[576] = 3, -- Loyal to the End
			[156] = 1.78, -- Ruinous Bolt
			[18] = 1.51, -- Blood Siphon
			[21] = 2.02, -- Elemental Whirl
			[522] = 6.27, -- Ancients' Bulwark
			[504] = 2.66, -- Unstable Catalyst
			[192] = 4.7, -- Meticulous Scheming
			[38] = 1.65, -- On My Way
			[462] = 0.96, -- Azerite Globules
			[196] = 5.06, -- Swirling Sands
			[521] = 3.65, -- Shadow of Elune
			[493] = 2.3, -- Last Gift
			[30] = 2.71, -- Overwhelming Power
			[193] = 6.17, -- Blightborne Infusion
			[478] = 3.01, -- Tidal Surge
			[577] = 3.32, -- Arcane Heart
			[82] = 5.76, -- Champion of Azeroth
			[495] = 2.93, -- Anduin's Dedication
			[200] = 10, -- Arcanic Pulsar
			[461] = 0.92, -- Earthlink
			[501] = 3.61, -- Relational Normalization Gizmo
			[195] = 2.89, -- Secrets of the Deep
			[122] = 3.58, -- Streaking Stars
			[562] = 4.6, -- Treacherous Covenant
			[22] = 1.5, -- Heed My Call
			[499] = 1.22, -- Ricocheting Inflatable Pyrosaw
			[575] = 5.57, -- Undulating Tides
			[482] = 2.93, -- Thunderous Blast
			[364] = 3, -- Lively Spirit
			[480] = 3.64, -- Blood Rite
			[356] = 1.5, -- High Noon
			[582] = 5.43, -- Heart of Darkness
			[481] = 3.91, -- Incite the Pack
			[492] = 3.68, -- Liberator's Might
			[194] = 2.94, -- Filthy Transfusion
			[505] = 4.29, -- Tradewinds
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 17001 - 18801 (avg 18143), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[36] = { 0.9, 0.9 }, -- Spark of Inspiration
			[5] = { 6.54, 3.94 }, -- Essence of the Focusing Iris
			[35] = { 8.3, 4.47 }, -- Breath of the Dying
			[4] = { 3.63, 0.86 }, -- Worldvein Resonance
			[6] = { 4.06, 2 }, -- Purification Protocol
			[37] = { 2.69, 2.7 }, -- The Formless Void
			[28] = { 4.61, 2.83 }, -- The Unbound Force
			[15] = { 2.26, 0 }, -- Ripple in Space
			[32] = { 10, 2.56 }, -- Conflict and Strife
			[12] = { 3.77, 1.97 }, -- The Crucible of Flame
			[22] = { 5.81, 2.13 }, -- Vision of Perfection
			[27] = { 4.82, 2.72 }, -- Memory of Lucid Dreams
			[23] = { 5.3, 1.59 }, -- Blood of the Enemy
			[14] = { 6, 2.37 }, -- Condensed Life-Force
		}, 1584180000)

		insertDefaultScalesData(defaultName, 11, 2, { -- Feral Druid
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 23901 - 27516 (avg 25056), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[89] = 0.06, -- Azerite Veins
			[43] = 0.02, -- Winds of War
			[196] = 4.8, -- Swirling Sands
			[481] = 3.45, -- Incite the Pack
			[99] = 0.05, -- Ablative Shielding
			[31] = 1.54, -- Gutripper
			[111] = 2.83, -- Blood Mist
			[493] = 1.98, -- Last Gift
			[359] = 4.05, -- Wild Fleshrending
			[502] = 0.06, -- Personal Absorb-o-Tron
			[521] = 2.82, -- Shadow of Elune
			[461] = 0.87, -- Earthlink
			[526] = 5.5, -- Endless Hunger
			[576] = 2.52, -- Loyal to the End
			[575] = 4.89, -- Undulating Tides
			[577] = 3.13, -- Arcane Heart
			[103] = 0.08, -- Concentrated Mending
			[38] = 1.62, -- On My Way
			[18] = 1.39, -- Blood Siphon
			[86] = 0.09, -- Azerite Fortification
			[483] = 3.08, -- Archive of the Titans
			[193] = 5.93, -- Blightborne Infusion
			[19] = 0.03, -- Woundbinder
			[85] = 0.01, -- Gemhide
			[42] = 0.04, -- Savior
			[462] = 0.92, -- Azerite Globules
			[522] = 5.52, -- Ancients' Bulwark
			[501] = 2.97, -- Relational Normalization Gizmo
			[219] = 0.03, -- Reawakening
			[562] = 4.13, -- Treacherous Covenant
			[459] = 2.07, -- Unstable Flames
			[21] = 1.61, -- Elemental Whirl
			[496] = 1.15, -- Stronger Together
			[157] = 3.13, -- Rezan's Fury
			[104] = 0.07, -- Bracing Chill
			[358] = 3.09, -- Gushing Lacerations
			[561] = 2.3, -- Seductive Power
			[540] = 0.05, -- Switch Hitter
			[478] = 3.17, -- Tidal Surge
			[541] = 0.89, -- Fight or Flight
			[156] = 1.81, -- Ruinous Bolt
			[82] = 5.04, -- Champion of Azeroth
			[194] = 2.4, -- Filthy Transfusion
			[30] = 2.1, -- Overwhelming Power
			[169] = 1.7, -- Untamed Ferocity
			[100] = 0.06, -- Strength in Numbers
			[495] = 2.61, -- Anduin's Dedication
			[173] = 0.04, -- Power of the Moon
			[498] = 1.98, -- Barrage Of Many Bombs
			[492] = 3.3, -- Liberator's Might
			[500] = 1.7, -- Synaptic Spark Capacitor
			[485] = 2.61, -- Laser Matrix
			[171] = 0.06, -- Masterful Instincts
			[560] = 1.32, -- Bonded Souls
			[192] = 3.38, -- Meticulous Scheming
			[497] = 0.65, -- Stand As One
			[463] = 0.01, -- Blessed Portents
			[582] = 4.68, -- Heart of Darkness
			[247] = 1.14, -- Iron Jaws
			[22] = 1.4, -- Heed My Call
			[499] = 1.23, -- Ricocheting Inflatable Pyrosaw
			[569] = 5.47, -- Clockwork Heart
			[494] = 3.03, -- Battlefield Precision
			[505] = 3.64, -- Tradewinds
			[98] = 0.05, -- Crystalline Carapace
			[479] = 3.22, -- Dagger in the Back
			[84] = 0.05, -- Bulwark of the Masses
			[523] = 2.51, -- Apothecary's Concoctions
			[482] = 2.56, -- Thunderous Blast
			[195] = 2.59, -- Secrets of the Deep
			[467] = 0.1, -- Ursoc's Endurance
			[209] = 10, -- Jungle Fury
			[20] = 1.4, -- Lifespeed
			[504] = 2.38, -- Unstable Catalyst
			[480] = 2.86, -- Blood Rite
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 22402 - 25700 (avg 24423), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[37] = { 2.34, 2.39 }, -- The Formless Void
			[36] = { 0.73, 0.63 }, -- Spark of Inspiration
			[32] = { 10, 2.19 }, -- Conflict and Strife
			[14] = { 4.59, 2.14 }, -- Condensed Life-Force
			[23] = { 4.76, 0.98 }, -- Blood of the Enemy
			[12] = { 4.85, 1.82 }, -- The Crucible of Flame
			[28] = { 3.73, 1.76 }, -- The Unbound Force
			[5] = { 7.7, 2.81 }, -- Essence of the Focusing Iris
			[22] = { 2.5, 0.92 }, -- Vision of Perfection
			[15] = { 2.55, 0 }, -- Ripple in Space
			[35] = { 8.94, 3.89 }, -- Breath of the Dying
			[27] = { 2.91, 2.19 }, -- Memory of Lucid Dreams
			[4] = { 4.11, 0.89 }, -- Worldvein Resonance
			[6] = { 4.4, 1.79 }, -- Purification Protocol
		}, 1584180000)

		insertDefaultScalesData(offensiveName, 11, 3, { -- Guardian Druid
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6301 - 9602 (avg 6957), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[498] = 4.03, -- Barrage Of Many Bombs
			[503] = 0.13, -- Auto-Self-Cauterizer
			[501] = 4.95, -- Relational Normalization Gizmo
			[14] = 0.01, -- Longstrider
			[251] = 6.04, -- Burst of Savagery
			[192] = 6.16, -- Meticulous Scheming
			[462] = 1.92, -- Azerite Globules
			[459] = 3.05, -- Unstable Flames
			[495] = 3.8, -- Anduin's Dedication
			[219] = 0.03, -- Reawakening
			[84] = 0.01, -- Bulwark of the Masses
			[582] = 7.54, -- Heart of Darkness
			[540] = 0.08, -- Switch Hitter
			[575] = 10, -- Undulating Tides
			[562] = 6.23, -- Treacherous Covenant
			[44] = 0.05, -- Vampiric Speed
			[103] = 0.09, -- Concentrated Mending
			[505] = 5.55, -- Tradewinds
			[560] = 2.36, -- Bonded Souls
			[18] = 2.11, -- Blood Siphon
			[461] = 1.36, -- Earthlink
			[42] = 0.01, -- Savior
			[101] = 0.01, -- Shimmering Haven
			[171] = 0.06, -- Masterful Instincts
			[87] = 0.13, -- Self Reliance
			[478] = 6.4, -- Tidal Surge
			[526] = 8.34, -- Endless Hunger
			[569] = 7.95, -- Clockwork Heart
			[496] = 1.77, -- Stronger Together
			[98] = 0.88, -- Crystalline Carapace
			[15] = 0.09, -- Resounding Protection
			[497] = 1.17, -- Stand As One
			[521] = 4.84, -- Shadow of Elune
			[31] = 3.08, -- Gutripper
			[360] = 0.1, -- Gory Regeneration
			[196] = 7.2, -- Swirling Sands
			[85] = 0.03, -- Gemhide
			[494] = 6.35, -- Battlefield Precision
			[21] = 2.64, -- Elemental Whirl
			[359] = 1.75, -- Wild Fleshrending
			[541] = 1.57, -- Fight or Flight
			[157] = 6.23, -- Rezan's Fury
			[576] = 3.48, -- Loyal to the End
			[482] = 5.25, -- Thunderous Blast
			[499] = 2.42, -- Ricocheting Inflatable Pyrosaw
			[463] = 0.05, -- Blessed Portents
			[577] = 3.08, -- Arcane Heart
			[485] = 5.26, -- Laser Matrix
			[13] = 0.04, -- Azerite Empowered
			[522] = 8.47, -- Ancients' Bulwark
			[195] = 4.01, -- Secrets of the Deep
			[481] = 5.13, -- Incite the Pack
			[193] = 8.78, -- Blightborne Infusion
			[38] = 2.36, -- On My Way
			[22] = 2.87, -- Heed My Call
			[20] = 2.35, -- Lifespeed
			[561] = 4.56, -- Seductive Power
			[500] = 3.54, -- Synaptic Spark Capacitor
			[361] = 4.59, -- Guardian's Wrath
			[483] = 4.67, -- Archive of the Titans
			[504] = 3.63, -- Unstable Catalyst
			[194] = 5.33, -- Filthy Transfusion
			[241] = 3.79, -- Twisted Claws
			[100] = 0.09, -- Strength in Numbers
			[480] = 4.76, -- Blood Rite
			[492] = 5.27, -- Liberator's Might
			[479] = 4.43, -- Dagger in the Back
			[523] = 5.06, -- Apothecary's Concoctions
			[156] = 3.85, -- Ruinous Bolt
			[82] = 7.8, -- Champion of Azeroth
			[493] = 2.97, -- Last Gift
			[30] = 3.67, -- Overwhelming Power
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6601 - 7101 (avg 6792), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[15] = { 3.41, 0.06 }, -- Ripple in Space
			[25] = { 1.44, 1.48 }, -- Aegis of the Deep
			[22] = { 1.38, 0.01 }, -- Vision of Perfection
			[12] = { 9.08, 3.45 }, -- The Crucible of Flame
			[2] = { 0.05, 0.01 }, -- Azeroth's Undying Gift
			[7] = { 6.16, 3.07 }, -- Anima of Life and Death
			[13] = { 0, 0.13 }, -- Nullification Dynamo
			[37] = { 3.5, 3.46 }, -- The Formless Void
			[27] = { 0.92, 0.66 }, -- Memory of Lucid Dreams
			[4] = { 4.05, 1.19 }, -- Worldvein Resonance
			[3] = { 6.57, 6.4 }, -- Sphere of Suppression
			[32] = { 10, 3.1 }, -- Conflict and Strife
			[33] = { 0.05, 0 }, -- Touch of the Everlasting
		}, 1584180000)

		insertDefaultScalesData(defaultName, 3, 1, { -- Beast Mastery Hunter
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 15302 - 18500 (avg 16248), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[561] = 2.91, -- Seductive Power
			[560] = 1.69, -- Bonded Souls
			[485] = 2.56, -- Laser Matrix
			[482] = 2.59, -- Thunderous Blast
			[502] = 0.05, -- Personal Absorb-o-Tron
			[582] = 4.66, -- Heart of Darkness
			[366] = 6.23, -- Primal Instincts
			[89] = 0.12, -- Azerite Veins
			[576] = 2.57, -- Loyal to the End
			[480] = 3.39, -- Blood Rite
			[497] = 0.81, -- Stand As One
			[365] = 5.3, -- Dire Consequences
			[493] = 2, -- Last Gift
			[18] = 1.44, -- Blood Siphon
			[568] = 0.02, -- Person-Computer Interface
			[195] = 3.44, -- Secrets of the Deep
			[501] = 3.66, -- Relational Normalization Gizmo
			[85] = 0.02, -- Gemhide
			[459] = 1.77, -- Unstable Flames
			[38] = 1.37, -- On My Way
			[100] = 0.03, -- Strength in Numbers
			[84] = 0.06, -- Bulwark of the Masses
			[211] = 10, -- Dance of Death
			[496] = 1.15, -- Stronger Together
			[483] = 3.82, -- Archive of the Titans
			[504] = 2.95, -- Unstable Catalyst
			[367] = 3.17, -- Feeding Frenzy
			[156] = 1.9, -- Ruinous Bolt
			[577] = 0.98, -- Arcane Heart
			[479] = 3.38, -- Dagger in the Back
			[494] = 3.17, -- Battlefield Precision
			[562] = 5.17, -- Treacherous Covenant
			[82] = 4.85, -- Champion of Azeroth
			[523] = 2.54, -- Apothecary's Concoctions
			[193] = 4.66, -- Blightborne Infusion
			[505] = 3.83, -- Tradewinds
			[499] = 1.27, -- Ricocheting Inflatable Pyrosaw
			[30] = 2.57, -- Overwhelming Power
			[500] = 1.69, -- Synaptic Spark Capacitor
			[521] = 3.43, -- Shadow of Elune
			[498] = 1.93, -- Barrage Of Many Bombs
			[462] = 0.95, -- Azerite Globules
			[21] = 1.73, -- Elemental Whirl
			[503] = 0.01, -- Auto-Self-Cauterizer
			[104] = 0.02, -- Bracing Chill
			[157] = 3.21, -- Rezan's Fury
			[196] = 4.04, -- Swirling Sands
			[492] = 3.14, -- Liberator's Might
			[526] = 4.72, -- Endless Hunger
			[461] = 1.17, -- Earthlink
			[569] = 5.13, -- Clockwork Heart
			[478] = 3.09, -- Tidal Surge
			[194] = 2.26, -- Filthy Transfusion
			[541] = 1.2, -- Fight or Flight
			[103] = 0.02, -- Concentrated Mending
			[161] = 5.64, -- Haze of Rage
			[192] = 4.41, -- Meticulous Scheming
			[481] = 3.58, -- Incite the Pack
			[20] = 1.69, -- Lifespeed
			[495] = 3.28, -- Anduin's Dedication
			[575] = 4.98, -- Undulating Tides
			[98] = 0.02, -- Crystalline Carapace
			[31] = 1.55, -- Gutripper
			[107] = 3.64, -- Serrated Jaws
			[522] = 4.71, -- Ancients' Bulwark
			[22] = 1.39, -- Heed My Call
			[203] = 0.06, -- Shellshock
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 13901 - 16702 (avg 15636), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[6] = { 4.88, 1.98 }, -- Purification Protocol
			[5] = { 6.52, 3.91 }, -- Essence of the Focusing Iris
			[35] = { 10, 4.44 }, -- Breath of the Dying
			[23] = { 2.67, 0.52 }, -- Blood of the Enemy
			[22] = { 1.93, 0.66 }, -- Vision of Perfection
			[15] = { 3.24, 0 }, -- Ripple in Space
			[32] = { 2.03, 2.03 }, -- Conflict and Strife
			[37] = { 3.27, 3.4 }, -- The Formless Void
			[12] = { 5.65, 2.01 }, -- The Crucible of Flame
			[4] = { 5.39, 1.14 }, -- Worldvein Resonance
			[27] = { 0.75, 0.81 }, -- Memory of Lucid Dreams
			[28] = { 4.17, 1.26 }, -- The Unbound Force
			[36] = { 0.88, 1 }, -- Spark of Inspiration
			[14] = { 3.55, 2.36 }, -- Condensed Life-Force
		}, 1584180000)

		insertDefaultScalesData(defaultName, 3, 2, { -- Marksmanship Hunter
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 51500 - 59502 (avg 55722), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[18] = 1.59, -- Blood Siphon
			[192] = 6.07, -- Meticulous Scheming
			[560] = 2.39, -- Bonded Souls
			[104] = 0.08, -- Bracing Chill
			[369] = 0.02, -- Rapid Reload
			[82] = 6.21, -- Champion of Azeroth
			[561] = 2.48, -- Seductive Power
			[368] = 2.08, -- Steady Aim
			[212] = 6.52, -- Unerring Vision
			[193] = 6.23, -- Blightborne Infusion
			[480] = 4.93, -- Blood Rite
			[478] = 3.66, -- Tidal Surge
			[461] = 1.07, -- Earthlink
			[469] = 0.01, -- Duck and Cover
			[501] = 4.51, -- Relational Normalization Gizmo
			[541] = 1.22, -- Fight or Flight
			[492] = 4.35, -- Liberator's Might
			[522] = 6.09, -- Ancients' Bulwark
			[156] = 2.31, -- Ruinous Bolt
			[523] = 3.02, -- Apothecary's Concoctions
			[103] = 0.01, -- Concentrated Mending
			[157] = 3.7, -- Rezan's Fury
			[101] = 0.06, -- Shimmering Haven
			[483] = 3.48, -- Archive of the Titans
			[36] = 10, -- In The Rhythm
			[162] = 4.94, -- Surging Shots
			[494] = 3.49, -- Battlefield Precision
			[463] = 0.01, -- Blessed Portents
			[89] = 0.01, -- Azerite Veins
			[84] = 0.03, -- Bulwark of the Masses
			[577] = 3.6, -- Arcane Heart
			[497] = 0.71, -- Stand As One
			[38] = 1.74, -- On My Way
			[496] = 1.49, -- Stronger Together
			[526] = 6, -- Endless Hunger
			[194] = 3.01, -- Filthy Transfusion
			[504] = 2.77, -- Unstable Catalyst
			[493] = 2.25, -- Last Gift
			[575] = 5.54, -- Undulating Tides
			[495] = 3.04, -- Anduin's Dedication
			[505] = 4.09, -- Tradewinds
			[485] = 2.88, -- Laser Matrix
			[576] = 2.93, -- Loyal to the End
			[13] = 0.09, -- Azerite Empowered
			[569] = 6.9, -- Clockwork Heart
			[481] = 3.88, -- Incite the Pack
			[44] = 0.06, -- Vampiric Speed
			[521] = 4.83, -- Shadow of Elune
			[195] = 3.12, -- Secrets of the Deep
			[20] = 2.73, -- Lifespeed
			[22] = 1.49, -- Heed My Call
			[30] = 3.67, -- Overwhelming Power
			[15] = 0.11, -- Resounding Protection
			[370] = 6.29, -- Focused Fire
			[203] = 0.03, -- Shellshock
			[85] = 0.02, -- Gemhide
			[482] = 2.9, -- Thunderous Blast
			[479] = 3.97, -- Dagger in the Back
			[500] = 2.13, -- Synaptic Spark Capacitor
			[21] = 2.17, -- Elemental Whirl
			[100] = 0.04, -- Strength in Numbers
			[498] = 2.26, -- Barrage Of Many Bombs
			[462] = 0.99, -- Azerite Globules
			[31] = 1.68, -- Gutripper
			[196] = 5.09, -- Swirling Sands
			[568] = 0.02, -- Person-Computer Interface
			[459] = 2.18, -- Unstable Flames
			[499] = 1.36, -- Ricocheting Inflatable Pyrosaw
			[562] = 4.75, -- Treacherous Covenant
			[582] = 6.2, -- Heart of Darkness
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 50600 - 56501 (avg 54753), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[5] = { 9.32, 5.83 }, -- Essence of the Focusing Iris
			[36] = { 1.52, 1.45 }, -- Spark of Inspiration
			[14] = { 5.1, 2.63 }, -- Condensed Life-Force
			[12] = { 5.32, 2.6 }, -- The Crucible of Flame
			[22] = { 5.45, 1.41 }, -- Vision of Perfection
			[28] = { 4.43, 2.48 }, -- The Unbound Force
			[6] = { 4.86, 2.19 }, -- Purification Protocol
			[4] = { 4.14, 1.01 }, -- Worldvein Resonance
			[15] = { 2.44, 0 }, -- Ripple in Space
			[27] = { 1.41, 0.85 }, -- Memory of Lucid Dreams
			[32] = { 2.52, 2.54 }, -- Conflict and Strife
			[37] = { 3.13, 3.04 }, -- The Formless Void
			[35] = { 10, 4.97 }, -- Breath of the Dying
			[23] = { 5.3, 1.56 }, -- Blood of the Enemy
		}, 1584180000)

		insertDefaultScalesData(defaultName, 3, 3, { -- Survival Hunter
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 44601 - 51503 (avg 47694), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[101] = 0.03, -- Shimmering Haven
			[523] = 4.79, -- Apothecary's Concoctions
			[100] = 0.03, -- Strength in Numbers
			[82] = 9.03, -- Champion of Azeroth
			[196] = 7.79, -- Swirling Sands
			[84] = 0.04, -- Bulwark of the Masses
			[30] = 5.29, -- Overwhelming Power
			[372] = 9.1, -- Wilderness Survival
			[562] = 7.57, -- Treacherous Covenant
			[493] = 2.89, -- Last Gift
			[192] = 8.02, -- Meticulous Scheming
			[497] = 1.15, -- Stand As One
			[461] = 1.71, -- Earthlink
			[213] = 4.42, -- Venomous Fangs
			[38] = 2.73, -- On My Way
			[20] = 3.49, -- Lifespeed
			[500] = 2.85, -- Synaptic Spark Capacitor
			[541] = 1.68, -- Fight or Flight
			[479] = 5.91, -- Dagger in the Back
			[521] = 7.19, -- Shadow of Elune
			[561] = 4.21, -- Seductive Power
			[83] = 0.02, -- Impassive Visage
			[575] = 9.04, -- Undulating Tides
			[576] = 3.72, -- Loyal to the End
			[42] = 0.11, -- Savior
			[582] = 8.64, -- Heart of Darkness
			[18] = 2, -- Blood Siphon
			[195] = 4.84, -- Secrets of the Deep
			[501] = 6.5, -- Relational Normalization Gizmo
			[193] = 9.31, -- Blightborne Infusion
			[495] = 4.79, -- Anduin's Dedication
			[365] = 5.38, -- Dire Consequences
			[203] = 0.07, -- Shellshock
			[85] = 0.04, -- Gemhide
			[459] = 3.37, -- Unstable Flames
			[373] = 9.46, -- Primeval Intuition
			[21] = 3.31, -- Elemental Whirl
			[492] = 6.1, -- Liberator's Might
			[483] = 5.24, -- Archive of the Titans
			[480] = 7.17, -- Blood Rite
			[496] = 2.18, -- Stronger Together
			[560] = 3.56, -- Bonded Souls
			[499] = 2.21, -- Ricocheting Inflatable Pyrosaw
			[163] = 6.16, -- Latent Poison
			[485] = 4.57, -- Laser Matrix
			[462] = 1.65, -- Azerite Globules
			[577] = 5.46, -- Arcane Heart
			[498] = 3.6, -- Barrage Of Many Bombs
			[156] = 3.28, -- Ruinous Bolt
			[522] = 9.35, -- Ancients' Bulwark
			[526] = 9.54, -- Endless Hunger
			[478] = 5.45, -- Tidal Surge
			[481] = 4.95, -- Incite the Pack
			[494] = 5.7, -- Battlefield Precision
			[482] = 4.79, -- Thunderous Blast
			[22] = 2.47, -- Heed My Call
			[371] = 8.81, -- Blur of Talons
			[86] = 0.04, -- Azerite Fortification
			[504] = 4.39, -- Unstable Catalyst
			[194] = 4.57, -- Filthy Transfusion
			[157] = 5.68, -- Rezan's Fury
			[19] = 0.07, -- Woundbinder
			[502] = 0.09, -- Personal Absorb-o-Tron
			[569] = 10, -- Clockwork Heart
			[110] = 2.36, -- Wildfire Cluster
			[31] = 2.8, -- Gutripper
			[505] = 5.38, -- Tradewinds
			[107] = 3.57, -- Serrated Jaws
			[105] = 0.05, -- Ephemeral Recovery
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 42107 - 48705 (avg 46708), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[22] = { 3.87, 0.9 }, -- Vision of Perfection
			[15] = { 2.69, 0 }, -- Ripple in Space
			[32] = { 2.27, 2.21 }, -- Conflict and Strife
			[23] = { 4.52, 1.15 }, -- Blood of the Enemy
			[4] = { 4.13, 0.99 }, -- Worldvein Resonance
			[6] = { 4.55, 1.99 }, -- Purification Protocol
			[28] = { 4.45, 2.12 }, -- The Unbound Force
			[37] = { 2.65, 2.72 }, -- The Formless Void
			[27] = { 6.89, 2.25 }, -- Memory of Lucid Dreams
			[5] = { 8.21, 4.5 }, -- Essence of the Focusing Iris
			[36] = { 1.06, 1.05 }, -- Spark of Inspiration
			[12] = { 5.2, 2.07 }, -- The Crucible of Flame
			[14] = { 4.78, 2.36 }, -- Condensed Life-Force
			[35] = { 10, 4.51 }, -- Breath of the Dying
		}, 1584180000)

		insertDefaultScalesData(defaultName, 8, 1, { -- Arcane Mage
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 23902 - 28400 (avg 25583), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[38] = 2.58, -- On My Way
			[461] = 1.67, -- Earthlink
			[196] = 6.79, -- Swirling Sands
			[194] = 3.76, -- Filthy Transfusion
			[192] = 3.64, -- Meticulous Scheming
			[375] = 0.02, -- Explosive Echo
			[492] = 5.9, -- Liberator's Might
			[577] = 4.95, -- Arcane Heart
			[503] = 0.04, -- Auto-Self-Cauterizer
			[575] = 6.76, -- Undulating Tides
			[22] = 1.95, -- Heed My Call
			[522] = 9.15, -- Ancients' Bulwark
			[157] = 4.6, -- Rezan's Fury
			[569] = 8.05, -- Clockwork Heart
			[562] = 7.14, -- Treacherous Covenant
			[103] = 0.04, -- Concentrated Mending
			[480] = 5.06, -- Blood Rite
			[193] = 8.24, -- Blightborne Infusion
			[498] = 2.83, -- Barrage Of Many Bombs
			[478] = 4.36, -- Tidal Surge
			[13] = 0.09, -- Azerite Empowered
			[485] = 3.56, -- Laser Matrix
			[479] = 4.84, -- Dagger in the Back
			[82] = 9.55, -- Champion of Azeroth
			[15] = 0.07, -- Resounding Protection
			[502] = 0.08, -- Personal Absorb-o-Tron
			[481] = 4.52, -- Incite the Pack
			[541] = 1.56, -- Fight or Flight
			[483] = 4.82, -- Archive of the Titans
			[30] = 4.15, -- Overwhelming Power
			[505] = 4.98, -- Tradewinds
			[214] = 2.54, -- Arcane Pressure
			[31] = 2.04, -- Gutripper
			[501] = 5.23, -- Relational Normalization Gizmo
			[468] = 0.06, -- Cauterizing Blink
			[14] = 0.04, -- Longstrider
			[526] = 9.05, -- Endless Hunger
			[561] = 3.61, -- Seductive Power
			[496] = 1.95, -- Stronger Together
			[44] = 0.07, -- Vampiric Speed
			[497] = 1.05, -- Stand As One
			[459] = 2.84, -- Unstable Flames
			[462] = 1.38, -- Azerite Globules
			[521] = 5.02, -- Shadow of Elune
			[205] = 0.04, -- Eldritch Warding
			[18] = 1.97, -- Blood Siphon
			[101] = 0.12, -- Shimmering Haven
			[88] = 5.47, -- Arcane Pummeling
			[167] = 2.73, -- Brain Storm
			[482] = 3.66, -- Thunderous Blast
			[21] = 2.96, -- Elemental Whirl
			[499] = 1.69, -- Ricocheting Inflatable Pyrosaw
			[493] = 2.69, -- Last Gift
			[42] = 0.01, -- Savior
			[494] = 4.21, -- Battlefield Precision
			[20] = 4.46, -- Lifespeed
			[89] = 0.05, -- Azerite Veins
			[495] = 4.47, -- Anduin's Dedication
			[127] = 10, -- Equipoise
			[560] = 3.21, -- Bonded Souls
			[523] = 3.91, -- Apothecary's Concoctions
			[99] = 0.15, -- Ablative Shielding
			[582] = 6.75, -- Heart of Darkness
			[500] = 2.46, -- Synaptic Spark Capacitor
			[504] = 4.07, -- Unstable Catalyst
			[576] = 3.6, -- Loyal to the End
			[374] = 6.3, -- Galvanizing Spark
			[156] = 3.04, -- Ruinous Bolt
			[83] = 0.05, -- Impassive Visage
			[105] = 0.07, -- Ephemeral Recovery
			[19] = 0.02, -- Woundbinder
			[195] = 4.58, -- Secrets of the Deep
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 24203 - 28306 (avg 25713), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[12] = { 5.32, 2.62 }, -- The Crucible of Flame
			[22] = { 1.36, 0 }, -- Vision of Perfection
			[6] = { 4.14, 2.2 }, -- Purification Protocol
			[4] = { 7.19, 1.24 }, -- Worldvein Resonance
			[5] = { 10, 6.3 }, -- Essence of the Focusing Iris
			[32] = { 3.01, 3.1 }, -- Conflict and Strife
			[35] = { 9.29, 4.93 }, -- Breath of the Dying
			[28] = { 3.25, 2.32 }, -- The Unbound Force
			[23] = { 4.26, 1.2 }, -- Blood of the Enemy
			[36] = { 1.72, 1.65 }, -- Spark of Inspiration
			[27] = { 2.87, 1.64 }, -- Memory of Lucid Dreams
			[37] = { 3.73, 3.84 }, -- The Formless Void
			[15] = { 2.66, 0.05 }, -- Ripple in Space
			[14] = { 6.81, 2.63 }, -- Condensed Life-Force
		}, 1584180000)

		insertDefaultScalesData(defaultName, 8, 2, { -- Fire Mage
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 28601 - 33802 (avg 30454), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[483] = 3.66, -- Archive of the Titans
			[168] = 6.63, -- Wildfire
			[526] = 7.28, -- Endless Hunger
			[493] = 2.1, -- Last Gift
			[82] = 6.15, -- Champion of Azeroth
			[89] = 0.01, -- Azerite Veins
			[461] = 1.11, -- Earthlink
			[30] = 3.16, -- Overwhelming Power
			[582] = 6.26, -- Heart of Darkness
			[99] = 0.03, -- Ablative Shielding
			[494] = 4.28, -- Battlefield Precision
			[21] = 2.28, -- Elemental Whirl
			[521] = 4.25, -- Shadow of Elune
			[522] = 7.34, -- Ancients' Bulwark
			[13] = 0.02, -- Azerite Empowered
			[499] = 1.69, -- Ricocheting Inflatable Pyrosaw
			[541] = 1.31, -- Fight or Flight
			[502] = 0.1, -- Personal Absorb-o-Tron
			[44] = 0.1, -- Vampiric Speed
			[479] = 4.49, -- Dagger in the Back
			[193] = 7.77, -- Blightborne Infusion
			[576] = 2.56, -- Loyal to the End
			[376] = 2.92, -- Trailing Embers
			[560] = 2.01, -- Bonded Souls
			[157] = 4.26, -- Rezan's Fury
			[485] = 3.38, -- Laser Matrix
			[38] = 2.15, -- On My Way
			[103] = 0.03, -- Concentrated Mending
			[42] = 0.12, -- Savior
			[468] = 0.06, -- Cauterizing Blink
			[503] = 0.03, -- Auto-Self-Cauterizer
			[495] = 3.1, -- Anduin's Dedication
			[463] = 0.05, -- Blessed Portents
			[568] = 0.07, -- Person-Computer Interface
			[101] = 0.03, -- Shimmering Haven
			[562] = 5.16, -- Treacherous Covenant
			[482] = 3.68, -- Thunderous Blast
			[205] = 0.05, -- Eldritch Warding
			[378] = 4.42, -- Firemind
			[481] = 3.29, -- Incite the Pack
			[105] = 0.12, -- Ephemeral Recovery
			[498] = 2.79, -- Barrage Of Many Bombs
			[377] = 3.87, -- Duplicative Incineration
			[86] = 0.04, -- Azerite Fortification
			[43] = 0.01, -- Winds of War
			[98] = 0.04, -- Crystalline Carapace
			[480] = 4.32, -- Blood Rite
			[492] = 4.25, -- Liberator's Might
			[575] = 6.86, -- Undulating Tides
			[504] = 2.97, -- Unstable Catalyst
			[14] = 0.08, -- Longstrider
			[128] = 3.59, -- Flames of Alacrity
			[22] = 1.9, -- Heed My Call
			[20] = 2.04, -- Lifespeed
			[459] = 2.57, -- Unstable Flames
			[87] = 0.04, -- Self Reliance
			[577] = 3.24, -- Arcane Heart
			[194] = 3.34, -- Filthy Transfusion
			[104] = 0.06, -- Bracing Chill
			[478] = 4.22, -- Tidal Surge
			[462] = 1.24, -- Azerite Globules
			[501] = 4.25, -- Relational Normalization Gizmo
			[18] = 1.38, -- Blood Siphon
			[192] = 4.23, -- Meticulous Scheming
			[156] = 2.65, -- Ruinous Bolt
			[561] = 2.81, -- Seductive Power
			[505] = 3.75, -- Tradewinds
			[496] = 1.48, -- Stronger Together
			[196] = 6.4, -- Swirling Sands
			[195] = 3.29, -- Secrets of the Deep
			[19] = 0.06, -- Woundbinder
			[215] = 4.19, -- Blaster Master
			[523] = 3.6, -- Apothecary's Concoctions
			[31] = 2.05, -- Gutripper
			[497] = 0.81, -- Stand As One
			[500] = 2.38, -- Synaptic Spark Capacitor
			[83] = 0.01, -- Impassive Visage
			[569] = 10, -- Clockwork Heart
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 27700 - 31104 (avg 29874), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[37] = { 1.78, 1.76 }, -- The Formless Void
			[36] = { 0.67, 0.61 }, -- Spark of Inspiration
			[4] = { 3.3, 0.65 }, -- Worldvein Resonance
			[27] = { 10, 5.12 }, -- Memory of Lucid Dreams
			[32] = { 1.6, 1.69 }, -- Conflict and Strife
			[15] = { 2.33, 0.02 }, -- Ripple in Space
			[6] = { 3.6, 1.51 }, -- Purification Protocol
			[35] = { 6.39, 3.33 }, -- Breath of the Dying
			[28] = { 3.22, 1.56 }, -- The Unbound Force
			[14] = { 4.22, 1.76 }, -- Condensed Life-Force
			[12] = { 3.61, 1.58 }, -- The Crucible of Flame
			[23] = { 2.42, 1.01 }, -- Blood of the Enemy
			[22] = { 1.48, 0 }, -- Vision of Perfection
			[5] = { 5.65, 2.51 }, -- Essence of the Focusing Iris
		}, 1584180000)

		insertDefaultScalesData(defaultName, 8, 3, { -- Frost Mage
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 27305 - 32801 (avg 28975), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[99] = 0.02, -- Ablative Shielding
			[481] = 4.22, -- Incite the Pack
			[194] = 2.31, -- Filthy Transfusion
			[21] = 1.76, -- Elemental Whirl
			[89] = 0.07, -- Azerite Veins
			[85] = 0.05, -- Gemhide
			[561] = 2.79, -- Seductive Power
			[170] = 10, -- Flash Freeze
			[31] = 1.28, -- Gutripper
			[482] = 2.17, -- Thunderous Blast
			[156] = 1.63, -- Ruinous Bolt
			[15] = 0.02, -- Resounding Protection
			[381] = 2.83, -- Frigid Grasp
			[541] = 1.28, -- Fight or Flight
			[132] = 2.47, -- Packed Ice
			[497] = 0.86, -- Stand As One
			[480] = 2.99, -- Blood Rite
			[495] = 3.39, -- Anduin's Dedication
			[459] = 1.8, -- Unstable Flames
			[196] = 3.66, -- Swirling Sands
			[103] = 0.07, -- Concentrated Mending
			[14] = 0.04, -- Longstrider
			[493] = 2.55, -- Last Gift
			[562] = 5.1, -- Treacherous Covenant
			[577] = 2.61, -- Arcane Heart
			[195] = 3.36, -- Secrets of the Deep
			[569] = 5.3, -- Clockwork Heart
			[104] = 0.02, -- Bracing Chill
			[500] = 1.43, -- Synaptic Spark Capacitor
			[492] = 3.06, -- Liberator's Might
			[462] = 0.74, -- Azerite Globules
			[485] = 2.1, -- Laser Matrix
			[87] = 0.02, -- Self Reliance
			[501] = 3.41, -- Relational Normalization Gizmo
			[494] = 2.29, -- Battlefield Precision
			[560] = 1.55, -- Bonded Souls
			[18] = 1.66, -- Blood Siphon
			[496] = 1.25, -- Stronger Together
			[499] = 0.98, -- Ricocheting Inflatable Pyrosaw
			[546] = 0.05, -- Quick Thinking
			[20] = 1.4, -- Lifespeed
			[192] = 2.77, -- Meticulous Scheming
			[504] = 3.03, -- Unstable Catalyst
			[43] = 0.06, -- Winds of War
			[505] = 4.53, -- Tradewinds
			[576] = 2.93, -- Loyal to the End
			[582] = 4.56, -- Heart of Darkness
			[521] = 3.08, -- Shadow of Elune
			[522] = 4.49, -- Ancients' Bulwark
			[22] = 1.11, -- Heed My Call
			[84] = 0.04, -- Bulwark of the Masses
			[157] = 2.58, -- Rezan's Fury
			[463] = 0.03, -- Blessed Portents
			[225] = 2.38, -- Glacial Assault
			[498] = 1.66, -- Barrage Of Many Bombs
			[468] = 0.05, -- Cauterizing Blink
			[479] = 2.66, -- Dagger in the Back
			[82] = 4.69, -- Champion of Azeroth
			[380] = 2.57, -- Whiteout
			[205] = 0.08, -- Eldritch Warding
			[19] = 0.05, -- Woundbinder
			[483] = 3.64, -- Archive of the Titans
			[575] = 3.98, -- Undulating Tides
			[461] = 1.19, -- Earthlink
			[526] = 4.43, -- Endless Hunger
			[98] = 0.09, -- Crystalline Carapace
			[100] = 0.01, -- Strength in Numbers
			[502] = 0.03, -- Personal Absorb-o-Tron
			[101] = 0.1, -- Shimmering Haven
			[478] = 2.54, -- Tidal Surge
			[193] = 3.84, -- Blightborne Infusion
			[13] = 0.07, -- Azerite Empowered
			[523] = 2.06, -- Apothecary's Concoctions
			[44] = 0.09, -- Vampiric Speed
			[379] = 2.87, -- Tunnel of Ice
			[38] = 1.29, -- On My Way
			[568] = 0.1, -- Person-Computer Interface
			[30] = 2.3, -- Overwhelming Power
			[105] = 0.04, -- Ephemeral Recovery
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 26601 - 30303 (avg 28498), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[23] = { 3.8, 1.05 }, -- Blood of the Enemy
			[5] = { 6.31, 5.13 }, -- Essence of the Focusing Iris
			[15] = { 2.75, 0.09 }, -- Ripple in Space
			[22] = { 5.03, 1.23 }, -- Vision of Perfection
			[35] = { 8.28, 5.25 }, -- Breath of the Dying
			[12] = { 2.6, 2.49 }, -- The Crucible of Flame
			[27] = { 10, 6.31 }, -- Memory of Lucid Dreams
			[28] = { 3.73, 2.18 }, -- The Unbound Force
			[32] = { 2.92, 2.85 }, -- Conflict and Strife
			[37] = { 4.68, 4.67 }, -- The Formless Void
			[36] = { 1.26, 1.26 }, -- Spark of Inspiration
			[4] = { 5.64, 1.75 }, -- Worldvein Resonance
			[14] = { 6.42, 2.71 }, -- Condensed Life-Force
			[6] = { 3.83, 2.47 }, -- Purification Protocol
		}, 1584180000)

		insertDefaultScalesData(offensiveName, 10, 1, { -- Brewmaster Monk
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 14503 - 18201 (avg 15260), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[479] = 4.65, -- Dagger in the Back
			[461] = 0.86, -- Earthlink
			[14] = 0.04, -- Longstrider
			[196] = 5.07, -- Swirling Sands
			[478] = 6.01, -- Tidal Surge
			[541] = 0.91, -- Fight or Flight
			[116] = 1.29, -- Boiling Brew
			[38] = 1.47, -- On My Way
			[504] = 2.38, -- Unstable Catalyst
			[194] = 5.2, -- Filthy Transfusion
			[21] = 1.53, -- Elemental Whirl
			[493] = 1.49, -- Last Gift
			[192] = 2.15, -- Meticulous Scheming
			[18] = 1.06, -- Blood Siphon
			[576] = 1.79, -- Loyal to the End
			[480] = 1.84, -- Blood Rite
			[156] = 3.77, -- Ruinous Bolt
			[83] = 0.1, -- Impassive Visage
			[482] = 5.41, -- Thunderous Blast
			[526] = 5.42, -- Endless Hunger
			[499] = 2.46, -- Ricocheting Inflatable Pyrosaw
			[575] = 10, -- Undulating Tides
			[218] = 0.05, -- Strength of Spirit
			[104] = 0.03, -- Bracing Chill
			[497] = 0.69, -- Stand As One
			[193] = 6.13, -- Blightborne Infusion
			[462] = 1.75, -- Azerite Globules
			[20] = 0.99, -- Lifespeed
			[577] = 4.12, -- Arcane Heart
			[43] = 0.04, -- Winds of War
			[501] = 2.42, -- Relational Normalization Gizmo
			[582] = 4.5, -- Heart of Darkness
			[383] = 3.55, -- Training of Niuzao
			[22] = 2.61, -- Heed My Call
			[31] = 3.01, -- Gutripper
			[496] = 1.05, -- Stronger Together
			[494] = 6.84, -- Battlefield Precision
			[157] = 6.17, -- Rezan's Fury
			[470] = 0.01, -- Sweep the Leg
			[505] = 2.69, -- Tradewinds
			[498] = 3.94, -- Barrage Of Many Bombs
			[523] = 5.26, -- Apothecary's Concoctions
			[483] = 3.06, -- Archive of the Titans
			[13] = 0.17, -- Azerite Empowered
			[562] = 3.93, -- Treacherous Covenant
			[463] = 0.03, -- Blessed Portents
			[495] = 2.38, -- Anduin's Dedication
			[101] = 0.08, -- Shimmering Haven
			[500] = 3.07, -- Synaptic Spark Capacitor
			[85] = 0.01, -- Gemhide
			[82] = 4.36, -- Champion of Azeroth
			[561] = 2.86, -- Seductive Power
			[30] = 1.36, -- Overwhelming Power
			[521] = 1.76, -- Shadow of Elune
			[560] = 1.15, -- Bonded Souls
			[195] = 2.57, -- Secrets of the Deep
			[569] = 4.68, -- Clockwork Heart
			[384] = 2.8, -- Elusive Footwork
			[459] = 2.09, -- Unstable Flames
			[99] = 0.02, -- Ablative Shielding
			[481] = 2.5, -- Incite the Pack
			[522] = 5.37, -- Ancients' Bulwark
			[19] = 0.02, -- Woundbinder
			[492] = 3.07, -- Liberator's Might
			[485] = 5.05, -- Laser Matrix
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 14106 - 15502 (avg 15108), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[3] = { 2.89, 2.85 }, -- Sphere of Suppression
			[15] = { 3.21, 0 }, -- Ripple in Space
			[22] = { 0.01, 0 }, -- Vision of Perfection
			[25] = { 0.84, 0.91 }, -- Aegis of the Deep
			[32] = { 2.02, 1.88 }, -- Conflict and Strife
			[4] = { 2.63, 0.71 }, -- Worldvein Resonance
			[12] = { 10, 3.72 }, -- The Crucible of Flame
			[7] = { 3.94, 1.54 }, -- Anima of Life and Death
			[37] = { 2.15, 2.21 }, -- The Formless Void
		}, 1584180000)

		insertDefaultScalesData(defaultName, 10, 3, { -- Windwalker Monk
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 19900 - 22601 (avg 20879), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[193] = 7.56, -- Blightborne Infusion
			[101] = 0.13, -- Shimmering Haven
			[582] = 6.96, -- Heart of Darkness
			[521] = 4.48, -- Shadow of Elune
			[157] = 4.98, -- Rezan's Fury
			[481] = 4.74, -- Incite the Pack
			[218] = 0.12, -- Strength of Spirit
			[105] = 0.08, -- Ephemeral Recovery
			[541] = 1.61, -- Fight or Flight
			[87] = 0.09, -- Self Reliance
			[561] = 3.77, -- Seductive Power
			[526] = 8.67, -- Endless Hunger
			[20] = 2.27, -- Lifespeed
			[31] = 2.43, -- Gutripper
			[103] = 0.08, -- Concentrated Mending
			[575] = 7.73, -- Undulating Tides
			[100] = 0.14, -- Strength in Numbers
			[117] = 10, -- Fury of Xuen
			[480] = 4.38, -- Blood Rite
			[502] = 0.16, -- Personal Absorb-o-Tron
			[18] = 1.92, -- Blood Siphon
			[22] = 2.28, -- Heed My Call
			[493] = 2.71, -- Last Gift
			[184] = 4.98, -- Sunrise Technique
			[485] = 4.02, -- Laser Matrix
			[494] = 4.93, -- Battlefield Precision
			[156] = 3.13, -- Ruinous Bolt
			[389] = 7.71, -- Open Palm Strikes
			[478] = 5.11, -- Tidal Surge
			[496] = 1.84, -- Stronger Together
			[479] = 5.12, -- Dagger in the Back
			[463] = 0.11, -- Blessed Portents
			[30] = 3.37, -- Overwhelming Power
			[577] = 3.61, -- Arcane Heart
			[500] = 2.82, -- Synaptic Spark Capacitor
			[462] = 1.6, -- Azerite Globules
			[83] = 0.26, -- Impassive Visage
			[89] = 0.02, -- Azerite Veins
			[82] = 7.3, -- Champion of Azeroth
			[98] = 0.22, -- Crystalline Carapace
			[566] = 0.12, -- Exit Strategy
			[391] = 5.24, -- Dance of Chi-Ji
			[576] = 3.41, -- Loyal to the End
			[194] = 3.85, -- Filthy Transfusion
			[459] = 2.64, -- Unstable Flames
			[482] = 4.13, -- Thunderous Blast
			[522] = 8.61, -- Ancients' Bulwark
			[505] = 5.03, -- Tradewinds
			[499] = 2, -- Ricocheting Inflatable Pyrosaw
			[492] = 4.63, -- Liberator's Might
			[501] = 5, -- Relational Normalization Gizmo
			[13] = 0.25, -- Azerite Empowered
			[498] = 3.3, -- Barrage Of Many Bombs
			[390] = 6.07, -- Pressure Point
			[504] = 3.52, -- Unstable Catalyst
			[560] = 2.35, -- Bonded Souls
			[42] = 0.12, -- Savior
			[483] = 4.42, -- Archive of the Titans
			[497] = 1.01, -- Stand As One
			[14] = 0.02, -- Longstrider
			[195] = 4.13, -- Secrets of the Deep
			[568] = 0.08, -- Person-Computer Interface
			[21] = 2.59, -- Elemental Whirl
			[569] = 8.34, -- Clockwork Heart
			[86] = 0.12, -- Azerite Fortification
			[388] = 5.97, -- Glory of the Dawn
			[99] = 0.15, -- Ablative Shielding
			[461] = 1.41, -- Earthlink
			[44] = 0.06, -- Vampiric Speed
			[38] = 2.61, -- On My Way
			[43] = 0.05, -- Winds of War
			[192] = 5.39, -- Meticulous Scheming
			[84] = 0.06, -- Bulwark of the Masses
			[495] = 3.98, -- Anduin's Dedication
			[196] = 6.2, -- Swirling Sands
			[523] = 3.93, -- Apothecary's Concoctions
			[562] = 6.23, -- Treacherous Covenant
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 17902 - 22202 (avg 20515), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[5] = { 5.95, 2.01 }, -- Essence of the Focusing Iris
			[14] = { 3.85, 1.53 }, -- Condensed Life-Force
			[32] = { 10, 1.59 }, -- Conflict and Strife
			[35] = { 7.31, 2.9 }, -- Breath of the Dying
			[6] = { 4.15, 1.36 }, -- Purification Protocol
			[22] = { 1.01, 1.11 }, -- Vision of Perfection
			[28] = { 3.65, 1.14 }, -- The Unbound Force
			[23] = { 3.81, 0.77 }, -- Blood of the Enemy
			[37] = { 1.72, 1.69 }, -- The Formless Void
			[27] = { 0.26, 0.02 }, -- Memory of Lucid Dreams
			[12] = { 4.28, 1.41 }, -- The Crucible of Flame
			[4] = { 3.4, 0.62 }, -- Worldvein Resonance
			[15] = { 2.67, 0.02 }, -- Ripple in Space
			[36] = { 0.56, 0.55 }, -- Spark of Inspiration
		}, 1584180000)

		insertDefaultScalesData(offensiveName, 2, 2, { -- Protection Paladin
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 117400 - 132901 (avg 128644), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[83] = 0.01, -- Impassive Visage
			[471] = 0.05, -- Gallant Steed
			[462] = 1.93, -- Azerite Globules
			[526] = 6.92, -- Endless Hunger
			[478] = 5.65, -- Tidal Surge
			[235] = 3.24, -- Indomitable Justice
			[454] = 0.13, -- Judicious Defense
			[21] = 2.14, -- Elemental Whirl
			[538] = 0.12, -- Empyreal Ward
			[582] = 6.07, -- Heart of Darkness
			[502] = 0.05, -- Personal Absorb-o-Tron
			[30] = 3.32, -- Overwhelming Power
			[498] = 4.11, -- Barrage Of Many Bombs
			[395] = 8.64, -- Inspiring Vanguard
			[459] = 2.7, -- Unstable Flames
			[82] = 6.28, -- Champion of Azeroth
			[157] = 6.26, -- Rezan's Fury
			[577] = 3.72, -- Arcane Heart
			[499] = 2.55, -- Ricocheting Inflatable Pyrosaw
			[522] = 6.94, -- Ancients' Bulwark
			[568] = 0.08, -- Person-Computer Interface
			[541] = 1.25, -- Fight or Flight
			[493] = 2.03, -- Last Gift
			[523] = 5.19, -- Apothecary's Concoctions
			[479] = 4.52, -- Dagger in the Back
			[150] = 1.94, -- Soaring Shield
			[393] = 0.13, -- Grace of the Justicar
			[521] = 4.56, -- Shadow of Elune
			[482] = 5.38, -- Thunderous Blast
			[206] = 0.05, -- Stalwart Protector
			[44] = 0.05, -- Vampiric Speed
			[15] = 0.07, -- Resounding Protection
			[234] = 1.68, -- Inner Light
			[194] = 5.11, -- Filthy Transfusion
			[22] = 2.9, -- Heed My Call
			[85] = 0.11, -- Gemhide
			[84] = 0.05, -- Bulwark of the Masses
			[503] = 0.01, -- Auto-Self-Cauterizer
			[492] = 4.55, -- Liberator's Might
			[569] = 6.81, -- Clockwork Heart
			[87] = 0.01, -- Self Reliance
			[505] = 3.58, -- Tradewinds
			[575] = 10, -- Undulating Tides
			[500] = 2.99, -- Synaptic Spark Capacitor
			[125] = 2.97, -- Avenger's Might
			[576] = 2.48, -- Loyal to the End
			[100] = 0.2, -- Strength in Numbers
			[105] = 0.18, -- Ephemeral Recovery
			[463] = 0.03, -- Blessed Portents
			[104] = 0.1, -- Bracing Chill
			[101] = 0.07, -- Shimmering Haven
			[156] = 3.43, -- Ruinous Bolt
			[461] = 1.12, -- Earthlink
			[501] = 4.45, -- Relational Normalization Gizmo
			[562] = 5.47, -- Treacherous Covenant
			[485] = 5.23, -- Laser Matrix
			[14] = 0.15, -- Longstrider
			[495] = 3.38, -- Anduin's Dedication
			[103] = 0.05, -- Concentrated Mending
			[196] = 6.11, -- Swirling Sands
			[133] = 0.08, -- Bulwark of Light
			[497] = 0.84, -- Stand As One
			[494] = 6.48, -- Battlefield Precision
			[19] = 0.13, -- Woundbinder
			[18] = 1.4, -- Blood Siphon
			[504] = 3.19, -- Unstable Catalyst
			[13] = 0.06, -- Azerite Empowered
			[561] = 3.18, -- Seductive Power
			[98] = 0.55, -- Crystalline Carapace
			[192] = 5.93, -- Meticulous Scheming
			[99] = 0.12, -- Ablative Shielding
			[560] = 2.36, -- Bonded Souls
			[496] = 1.55, -- Stronger Together
			[193] = 7.48, -- Blightborne Infusion
			[20] = 2.13, -- Lifespeed
			[43] = 0.17, -- Winds of War
			[38] = 2.08, -- On My Way
			[483] = 3.88, -- Archive of the Titans
			[480] = 4.48, -- Blood Rite
			[195] = 3.56, -- Secrets of the Deep
			[481] = 3.39, -- Incite the Pack
			[31] = 3.12, -- Gutripper
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 116802 - 131102 (avg 128260), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[37] = { 3.06, 3.23 }, -- The Formless Void
			[25] = { 1.28, 1.27 }, -- Aegis of the Deep
			[2] = { 0.02, 0.15 }, -- Azeroth's Undying Gift
			[32] = { 2.75, 2.79 }, -- Conflict and Strife
			[34] = { 0, 0.08 }, -- Strength of the Warden
			[7] = { 2.6, 0.03 }, -- Anima of Life and Death
			[33] = { 0.06, 0 }, -- Touch of the Everlasting
			[4] = { 5.1, 1.08 }, -- Worldvein Resonance
			[22] = { 5.18, 2.6 }, -- Vision of Perfection
			[15] = { 3.41, 0 }, -- Ripple in Space
			[27] = { 1.09, 0.73 }, -- Memory of Lucid Dreams
			[13] = { 0.15, 0 }, -- Nullification Dynamo
			[3] = { 6.08, 6.12 }, -- Sphere of Suppression
			[12] = { 10, 3.57 }, -- The Crucible of Flame
		}, 1584180000)

		insertDefaultScalesData(defaultName, 2, 3, { -- Retribution Paladin
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 29000 - 33800 (avg 30939), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[196] = 4.7, -- Swirling Sands
			[481] = 3.72, -- Incite the Pack
			[526] = 6.07, -- Endless Hunger
			[541] = 1.16, -- Fight or Flight
			[569] = 6.11, -- Clockwork Heart
			[31] = 2.02, -- Gutripper
			[485] = 3.44, -- Laser Matrix
			[499] = 1.63, -- Ricocheting Inflatable Pyrosaw
			[156] = 2.26, -- Ruinous Bolt
			[482] = 3.56, -- Thunderous Blast
			[478] = 3.65, -- Tidal Surge
			[493] = 2.19, -- Last Gift
			[194] = 3.73, -- Filthy Transfusion
			[38] = 1.66, -- On My Way
			[22] = 1.85, -- Heed My Call
			[235] = 3.52, -- Indomitable Justice
			[480] = 3.45, -- Blood Rite
			[105] = 0.03, -- Ephemeral Recovery
			[496] = 1.34, -- Stronger Together
			[483] = 3.67, -- Archive of the Titans
			[453] = 4.69, -- Empyrean Power
			[459] = 1.97, -- Unstable Flames
			[521] = 3.57, -- Shadow of Elune
			[30] = 2.59, -- Overwhelming Power
			[87] = 0.01, -- Self Reliance
			[187] = 4.99, -- Expurgation
			[561] = 3.42, -- Seductive Power
			[494] = 4.15, -- Battlefield Precision
			[500] = 1.95, -- Synaptic Spark Capacitor
			[498] = 2.73, -- Barrage Of Many Bombs
			[501] = 3.68, -- Relational Normalization Gizmo
			[461] = 1.09, -- Earthlink
			[20] = 1.76, -- Lifespeed
			[504] = 2.81, -- Unstable Catalyst
			[82] = 5.41, -- Champion of Azeroth
			[582] = 5.2, -- Heart of Darkness
			[98] = 0.03, -- Crystalline Carapace
			[576] = 2.78, -- Loyal to the End
			[492] = 3.48, -- Liberator's Might
			[21] = 1.84, -- Elemental Whirl
			[396] = 10, -- Light's Decree
			[192] = 4.64, -- Meticulous Scheming
			[523] = 3.5, -- Apothecary's Concoctions
			[193] = 5.62, -- Blightborne Infusion
			[125] = 4.64, -- Avenger's Might
			[18] = 1.48, -- Blood Siphon
			[505] = 3.97, -- Tradewinds
			[560] = 1.99, -- Bonded Souls
			[101] = 0.01, -- Shimmering Haven
			[562] = 5.1, -- Treacherous Covenant
			[195] = 3.36, -- Secrets of the Deep
			[577] = 3.63, -- Arcane Heart
			[479] = 4.51, -- Dagger in the Back
			[522] = 6.07, -- Ancients' Bulwark
			[462] = 1.27, -- Azerite Globules
			[157] = 4.32, -- Rezan's Fury
			[154] = 5.63, -- Relentless Inquisitor
			[497] = 0.74, -- Stand As One
			[103] = 0.02, -- Concentrated Mending
			[538] = 0.05, -- Empyreal Ward
			[575] = 6.79, -- Undulating Tides
			[495] = 3.21, -- Anduin's Dedication
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 28301 - 32001 (avg 30467), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[22] = { 8.55, 2.89 }, -- Vision of Perfection
			[36] = { 0.83, 0.84 }, -- Spark of Inspiration
			[23] = { 3.89, 0.53 }, -- Blood of the Enemy
			[12] = { 6, 2.36 }, -- The Crucible of Flame
			[32] = { 2.24, 2.34 }, -- Conflict and Strife
			[4] = { 5.02, 0.97 }, -- Worldvein Resonance
			[37] = { 2.76, 2.78 }, -- The Formless Void
			[6] = { 5.11, 2.26 }, -- Purification Protocol
			[14] = { 6.51, 2.78 }, -- Condensed Life-Force
			[27] = { 4.45, 2.71 }, -- Memory of Lucid Dreams
			[28] = { 4.52, 1.78 }, -- The Unbound Force
			[35] = { 10, 5.16 }, -- Breath of the Dying
			[5] = { 7.5, 3.5 }, -- Essence of the Focusing Iris
		}, 1584180000)

		insertDefaultScalesData(defaultName, 4, 1, { -- Assassination Rogue
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 19200 - 23300 (avg 20200), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[87] = 0.1, -- Self Reliance
			[194] = 4.44, -- Filthy Transfusion
			[577] = 4.76, -- Arcane Heart
			[136] = 8.49, -- Double Dose
			[492] = 5.69, -- Liberator's Might
			[498] = 3.55, -- Barrage Of Many Bombs
			[483] = 5.89, -- Archive of the Titans
			[463] = 0.18, -- Blessed Portents
			[495] = 5.04, -- Anduin's Dedication
			[31] = 2.64, -- Gutripper
			[496] = 2.19, -- Stronger Together
			[502] = 0.1, -- Personal Absorb-o-Tron
			[560] = 3, -- Bonded Souls
			[503] = 0.15, -- Auto-Self-Cauterizer
			[569] = 9.63, -- Clockwork Heart
			[459] = 3.51, -- Unstable Flames
			[217] = 0.07, -- Footpad
			[38] = 2.85, -- On My Way
			[105] = 0.04, -- Ephemeral Recovery
			[480] = 5.68, -- Blood Rite
			[193] = 9.71, -- Blightborne Infusion
			[521] = 5.59, -- Shadow of Elune
			[541] = 1.94, -- Fight or Flight
			[103] = 0.09, -- Concentrated Mending
			[522] = 10, -- Ancients' Bulwark
			[85] = 0.1, -- Gemhide
			[479] = 5.77, -- Dagger in the Back
			[481] = 5.04, -- Incite the Pack
			[473] = 0.11, -- Shrouded Mantle
			[505] = 5.62, -- Tradewinds
			[89] = 0.1, -- Azerite Veins
			[482] = 4.76, -- Thunderous Blast
			[84] = 0.12, -- Bulwark of the Masses
			[19] = 0.11, -- Woundbinder
			[485] = 4.51, -- Laser Matrix
			[195] = 5.14, -- Secrets of the Deep
			[21] = 3.04, -- Elemental Whirl
			[13] = 0.15, -- Azerite Empowered
			[98] = 0.17, -- Crystalline Carapace
			[493] = 3.04, -- Last Gift
			[43] = 0.08, -- Winds of War
			[478] = 4.91, -- Tidal Surge
			[408] = 1.33, -- Shrouded Suffocation
			[568] = 0.14, -- Person-Computer Interface
			[494] = 5.7, -- Battlefield Precision
			[156] = 3.07, -- Ruinous Bolt
			[504] = 4.72, -- Unstable Catalyst
			[101] = 0.02, -- Shimmering Haven
			[500] = 2.66, -- Synaptic Spark Capacitor
			[501] = 5.74, -- Relational Normalization Gizmo
			[14] = 0.2, -- Longstrider
			[181] = 6.74, -- Twist the Knife
			[562] = 7.81, -- Treacherous Covenant
			[86] = 0.04, -- Azerite Fortification
			[42] = 0.11, -- Savior
			[15] = 0.09, -- Resounding Protection
			[30] = 4.14, -- Overwhelming Power
			[462] = 1.77, -- Azerite Globules
			[192] = 5.42, -- Meticulous Scheming
			[523] = 4.48, -- Apothecary's Concoctions
			[83] = 0.01, -- Impassive Visage
			[18] = 2.25, -- Blood Siphon
			[157] = 5.52, -- Rezan's Fury
			[20] = 2.59, -- Lifespeed
			[44] = 0.21, -- Vampiric Speed
			[406] = 3.64, -- Scent of Blood
			[99] = 0.21, -- Ablative Shielding
			[100] = 0.09, -- Strength in Numbers
			[561] = 4.64, -- Seductive Power
			[582] = 8.17, -- Heart of Darkness
			[461] = 1.79, -- Earthlink
			[526] = 9.98, -- Endless Hunger
			[196] = 8.07, -- Swirling Sands
			[407] = 0.04, -- Echoing Blades
			[548] = 0.14, -- Lying In Wait
			[82] = 8.56, -- Champion of Azeroth
			[575] = 8.84, -- Undulating Tides
			[497] = 1.42, -- Stand As One
			[22] = 2.55, -- Heed My Call
			[499] = 2.14, -- Ricocheting Inflatable Pyrosaw
			[576] = 3.68, -- Loyal to the End
			[249] = 10, -- Nothing Personal
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 18000 - 20801 (avg 19784), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[14] = { 5.34, 2.26 }, -- Condensed Life-Force
			[28] = { 5.3, 2.4 }, -- The Unbound Force
			[36] = { 0.83, 0.86 }, -- Spark of Inspiration
			[32] = { 2.33, 2.43 }, -- Conflict and Strife
			[37] = { 2.7, 2.81 }, -- The Formless Void
			[35] = { 10, 4.13 }, -- Breath of the Dying
			[23] = { 5.64, 1.82 }, -- Blood of the Enemy
			[4] = { 5.86, 1.01 }, -- Worldvein Resonance
			[27] = { 8.18, 4.32 }, -- Memory of Lucid Dreams
			[6] = { 4.95, 1.9 }, -- Purification Protocol
			[5] = { 7.81, 3.48 }, -- Essence of the Focusing Iris
			[15] = { 3.76, 0.07 }, -- Ripple in Space
			[22] = { 4.49, 0.81 }, -- Vision of Perfection
			[12] = { 5.79, 1.89 }, -- The Crucible of Flame
		}, 1584180000)

		insertDefaultScalesData(defaultName, 4, 2, { -- Outlaw Rogue
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 35000 - 42602 (avg 37633), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[492] = 5.25, -- Liberator's Might
			[501] = 5.56, -- Relational Normalization Gizmo
			[239] = 3.73, -- Snake Eyes
			[505] = 3.8, -- Tradewinds
			[180] = 4.22, -- Keep Your Wits About You
			[193] = 8.17, -- Blightborne Infusion
			[479] = 6.16, -- Dagger in the Back
			[577] = 3.74, -- Arcane Heart
			[522] = 9.01, -- Ancients' Bulwark
			[582] = 7.13, -- Heart of Darkness
			[560] = 2.78, -- Bonded Souls
			[21] = 2.62, -- Elemental Whirl
			[494] = 5.77, -- Battlefield Precision
			[500] = 3.02, -- Synaptic Spark Capacitor
			[192] = 6.89, -- Meticulous Scheming
			[38] = 2.48, -- On My Way
			[576] = 2.53, -- Loyal to the End
			[523] = 4.79, -- Apothecary's Concoctions
			[562] = 6.55, -- Treacherous Covenant
			[411] = 7.45, -- Ace Up Your Sleeve
			[195] = 4.31, -- Secrets of the Deep
			[31] = 2.73, -- Gutripper
			[569] = 7.48, -- Clockwork Heart
			[497] = 0.87, -- Stand As One
			[498] = 3.59, -- Barrage Of Many Bombs
			[156] = 2.98, -- Ruinous Bolt
			[541] = 1.51, -- Fight or Flight
			[30] = 4.24, -- Overwhelming Power
			[157] = 5.67, -- Rezan's Fury
			[461] = 1.38, -- Earthlink
			[481] = 3.6, -- Incite the Pack
			[410] = 3.47, -- Paradise Lost
			[495] = 4.2, -- Anduin's Dedication
			[504] = 3.54, -- Unstable Catalyst
			[194] = 4.5, -- Filthy Transfusion
			[462] = 1.55, -- Azerite Globules
			[499] = 2.13, -- Ricocheting Inflatable Pyrosaw
			[480] = 5.65, -- Blood Rite
			[493] = 2.02, -- Last Gift
			[196] = 6.78, -- Swirling Sands
			[496] = 1.77, -- Stronger Together
			[20] = 2.44, -- Lifespeed
			[482] = 4.57, -- Thunderous Blast
			[129] = 6.59, -- Deadshot
			[483] = 4.94, -- Archive of the Titans
			[478] = 5.52, -- Tidal Surge
			[18] = 1.23, -- Blood Siphon
			[561] = 3.65, -- Seductive Power
			[22] = 2.44, -- Heed My Call
			[459] = 2.88, -- Unstable Flames
			[521] = 5.64, -- Shadow of Elune
			[575] = 9.2, -- Undulating Tides
			[82] = 7.79, -- Champion of Azeroth
			[526] = 9.02, -- Endless Hunger
			[485] = 4.66, -- Laser Matrix
			[446] = 10, -- Brigand's Blitz
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 32801 - 38400 (avg 36623), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[23] = { 2.9, 1.08 }, -- Blood of the Enemy
			[6] = { 4.7, 1.74 }, -- Purification Protocol
			[32] = { 1.95, 1.83 }, -- Conflict and Strife
			[5] = { 6.6, 3.22 }, -- Essence of the Focusing Iris
			[15] = { 2.64, 0 }, -- Ripple in Space
			[14] = { 5.05, 2.07 }, -- Condensed Life-Force
			[12] = { 5.7, 1.75 }, -- The Crucible of Flame
			[22] = { 4.61, 2.29 }, -- Vision of Perfection
			[4] = { 3.36, 0.64 }, -- Worldvein Resonance
			[28] = { 3.77, 1.26 }, -- The Unbound Force
			[27] = { 5.58, 4.19 }, -- Memory of Lucid Dreams
			[36] = { 0.7, 0.63 }, -- Spark of Inspiration
			[37] = { 2.01, 2.05 }, -- The Formless Void
			[35] = { 10, 4.08 }, -- Breath of the Dying
		}, 1584180000)

		insertDefaultScalesData(defaultName, 4, 3, { -- Subtlety Rogue
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 23600 - 27014 (avg 24954), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[498] = 2.01, -- Barrage Of Many Bombs
			[493] = 1.41, -- Last Gift
			[541] = 0.91, -- Fight or Flight
			[521] = 2.99, -- Shadow of Elune
			[104] = 0.05, -- Bracing Chill
			[501] = 2.99, -- Relational Normalization Gizmo
			[560] = 1.47, -- Bonded Souls
			[86] = 0.05, -- Azerite Fortification
			[483] = 2.57, -- Archive of the Titans
			[526] = 4.94, -- Endless Hunger
			[480] = 3.01, -- Blood Rite
			[459] = 1.62, -- Unstable Flames
			[445] = 1.67, -- Perforate
			[82] = 4.19, -- Champion of Azeroth
			[101] = 0.01, -- Shimmering Haven
			[19] = 0.06, -- Woundbinder
			[105] = 0.01, -- Ephemeral Recovery
			[523] = 2.51, -- Apothecary's Concoctions
			[500] = 1.68, -- Synaptic Spark Capacitor
			[124] = 1.48, -- Replicating Shadows
			[414] = 3.74, -- Inevitability
			[240] = 3.91, -- Blade In The Shadows
			[569] = 5.06, -- Clockwork Heart
			[497] = 0.62, -- Stand As One
			[568] = 0.02, -- Person-Computer Interface
			[30] = 2.33, -- Overwhelming Power
			[577] = 2.13, -- Arcane Heart
			[485] = 2.48, -- Laser Matrix
			[582] = 4.03, -- Heart of Darkness
			[196] = 3.83, -- Swirling Sands
			[192] = 2.96, -- Meticulous Scheming
			[496] = 1.05, -- Stronger Together
			[22] = 1.37, -- Heed My Call
			[478] = 3.02, -- Tidal Surge
			[13] = 0.04, -- Azerite Empowered
			[43] = 0.02, -- Winds of War
			[18] = 0.93, -- Blood Siphon
			[175] = 3.56, -- Night's Vengeance
			[156] = 1.84, -- Ruinous Bolt
			[479] = 3.29, -- Dagger in the Back
			[413] = 10, -- The First Dance
			[494] = 3.05, -- Battlefield Precision
			[194] = 2.34, -- Filthy Transfusion
			[83] = 0.04, -- Impassive Visage
			[20] = 1.45, -- Lifespeed
			[195] = 2.31, -- Secrets of the Deep
			[504] = 2.07, -- Unstable Catalyst
			[461] = 0.89, -- Earthlink
			[99] = 0.07, -- Ablative Shielding
			[503] = 0.02, -- Auto-Self-Cauterizer
			[462] = 0.93, -- Azerite Globules
			[482] = 2.45, -- Thunderous Blast
			[38] = 1.38, -- On My Way
			[21] = 1.53, -- Elemental Whirl
			[463] = 0.04, -- Blessed Portents
			[193] = 4.44, -- Blightborne Infusion
			[562] = 3.63, -- Treacherous Covenant
			[522] = 4.95, -- Ancients' Bulwark
			[505] = 2.56, -- Tradewinds
			[492] = 2.89, -- Liberator's Might
			[495] = 2.33, -- Anduin's Dedication
			[561] = 1.97, -- Seductive Power
			[575] = 4.77, -- Undulating Tides
			[89] = 0.04, -- Azerite Veins
			[481] = 2.4, -- Incite the Pack
			[157] = 3.14, -- Rezan's Fury
			[31] = 1.42, -- Gutripper
			[44] = 0.01, -- Vampiric Speed
			[499] = 1.08, -- Ricocheting Inflatable Pyrosaw
			[576] = 1.76, -- Loyal to the End
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 22602 - 25405 (avg 24471), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[37] = { 2.08, 2.09 }, -- The Formless Void
			[6] = { 4.87, 1.79 }, -- Purification Protocol
			[36] = { 0.74, 0.74 }, -- Spark of Inspiration
			[23] = { 4.46, 1 }, -- Blood of the Enemy
			[15] = { 3.33, 0.05 }, -- Ripple in Space
			[14] = { 5.1, 2.02 }, -- Condensed Life-Force
			[32] = { 1.93, 2 }, -- Conflict and Strife
			[27] = { 7.53, 5.17 }, -- Memory of Lucid Dreams
			[35] = { 10, 3.91 }, -- Breath of the Dying
			[22] = { 3.38, 0.82 }, -- Vision of Perfection
			[12] = { 5.85, 1.83 }, -- The Crucible of Flame
			[28] = { 4.18, 1.32 }, -- The Unbound Force
			[4] = { 4.69, 0.79 }, -- Worldvein Resonance
			[5] = { 7.37, 3.26 }, -- Essence of the Focusing Iris
		}, 1584266400)

		insertDefaultScalesData(defaultName, 7, 1, { -- Elemental Shaman
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 54801 - 61922 (avg 58286), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[457] = 10, -- Igneous Potential
			[103] = 0.03, -- Concentrated Mending
			[561] = 3.43, -- Seductive Power
			[104] = 0.07, -- Bracing Chill
			[526] = 7.49, -- Endless Hunger
			[98] = 0.07, -- Crystalline Carapace
			[86] = 0.12, -- Azerite Fortification
			[582] = 6.18, -- Heart of Darkness
			[480] = 4.91, -- Blood Rite
			[541] = 1.39, -- Fight or Flight
			[157] = 4.61, -- Rezan's Fury
			[482] = 3.67, -- Thunderous Blast
			[521] = 4.8, -- Shadow of Elune
			[463] = 0.06, -- Blessed Portents
			[522] = 7.56, -- Ancients' Bulwark
			[539] = 0.07, -- Ancient Ankh Talisman
			[20] = 2.2, -- Lifespeed
			[194] = 3.97, -- Filthy Transfusion
			[502] = 0.04, -- Personal Absorb-o-Tron
			[494] = 4.23, -- Battlefield Precision
			[569] = 7.4, -- Clockwork Heart
			[568] = 0.11, -- Person-Computer Interface
			[15] = 0.1, -- Resounding Protection
			[474] = 0.03, -- Pack Spirit
			[195] = 4.14, -- Secrets of the Deep
			[459] = 3.03, -- Unstable Flames
			[14] = 0.01, -- Longstrider
			[478] = 4.37, -- Tidal Surge
			[42] = 0.07, -- Savior
			[492] = 4.79, -- Liberator's Might
			[479] = 5, -- Dagger in the Back
			[83] = 0.04, -- Impassive Visage
			[496] = 1.64, -- Stronger Together
			[44] = 0.11, -- Vampiric Speed
			[416] = 8.17, -- Natural Harmony
			[13] = 0.02, -- Azerite Empowered
			[483] = 4.58, -- Archive of the Titans
			[82] = 6.38, -- Champion of Azeroth
			[87] = 0.09, -- Self Reliance
			[493] = 1.46, -- Last Gift
			[156] = 2.83, -- Ruinous Bolt
			[196] = 6.55, -- Swirling Sands
			[461] = 1.45, -- Earthlink
			[178] = 3.97, -- Lava Shock
			[498] = 2.88, -- Barrage Of Many Bombs
			[497] = 0.85, -- Stand As One
			[448] = 3.88, -- Synapse Shock
			[85] = 0.04, -- Gemhide
			[207] = 0.11, -- Serene Spirit
			[21] = 2.17, -- Elemental Whirl
			[18] = 1.02, -- Blood Siphon
			[30] = 3.55, -- Overwhelming Power
			[22] = 2.01, -- Heed My Call
			[576] = 1.94, -- Loyal to the End
			[447] = 4.7, -- Ancestral Resonance
			[222] = 2.96, -- Echo of the Elementals
			[495] = 3.96, -- Anduin's Dedication
			[481] = 2.27, -- Incite the Pack
			[499] = 1.72, -- Ricocheting Inflatable Pyrosaw
			[577] = 4.63, -- Arcane Heart
			[501] = 4.83, -- Relational Normalization Gizmo
			[575] = 7.06, -- Undulating Tides
			[504] = 3.65, -- Unstable Catalyst
			[500] = 2.48, -- Synaptic Spark Capacitor
			[31] = 2.12, -- Gutripper
			[193] = 7.88, -- Blightborne Infusion
			[38] = 2.12, -- On My Way
			[505] = 2.46, -- Tradewinds
			[562] = 6.35, -- Treacherous Covenant
			[523] = 3.97, -- Apothecary's Concoctions
			[462] = 1.33, -- Azerite Globules
			[192] = 6.1, -- Meticulous Scheming
			[485] = 3.53, -- Laser Matrix
			[560] = 2.41, -- Bonded Souls
			[89] = 0.05, -- Azerite Veins
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 53400 - 59701 (avg 57174), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[22] = { 5, 1.55 }, -- Vision of Perfection
			[5] = { 8.71, 4.45 }, -- Essence of the Focusing Iris
			[6] = { 5.08, 2.37 }, -- Purification Protocol
			[27] = { 2.07, 1.29 }, -- Memory of Lucid Dreams
			[14] = { 6.45, 2.81 }, -- Condensed Life-Force
			[37] = { 3.42, 3.45 }, -- The Formless Void
			[23] = { 5.8, 1.17 }, -- Blood of the Enemy
			[28] = { 4.97, 2.97 }, -- The Unbound Force
			[36] = { 1.17, 1.12 }, -- Spark of Inspiration
			[4] = { 5.48, 1.19 }, -- Worldvein Resonance
			[12] = { 5.26, 2.76 }, -- The Crucible of Flame
			[15] = { 3.04, 0 }, -- Ripple in Space
			[32] = { 9.12, 2.65 }, -- Conflict and Strife
			[35] = { 10, 5.21 }, -- Breath of the Dying
		}, 1584266400)

		insertDefaultScalesData(defaultName, 7, 2, { -- Enhancement Shaman
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 29004 - 35400 (avg 32223), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[31] = 2.02, -- Gutripper
			[103] = 0.08, -- Concentrated Mending
			[447] = 6.87, -- Ancestral Resonance
			[498] = 2.74, -- Barrage Of Many Bombs
			[495] = 3.48, -- Anduin's Dedication
			[192] = 5, -- Meticulous Scheming
			[21] = 2.18, -- Elemental Whirl
			[223] = 2.15, -- Lightning Conduit
			[496] = 1.5, -- Stronger Together
			[13] = 0.03, -- Azerite Empowered
			[462] = 1.2, -- Azerite Globules
			[522] = 6.67, -- Ancients' Bulwark
			[504] = 3.2, -- Unstable Catalyst
			[195] = 3.46, -- Secrets of the Deep
			[569] = 6.28, -- Clockwork Heart
			[157] = 4.07, -- Rezan's Fury
			[15] = 0.08, -- Resounding Protection
			[30] = 2.94, -- Overwhelming Power
			[497] = 0.82, -- Stand As One
			[568] = 0.03, -- Person-Computer Interface
			[562] = 5.47, -- Treacherous Covenant
			[86] = 0.03, -- Azerite Fortification
			[485] = 3.35, -- Laser Matrix
			[541] = 1.3, -- Fight or Flight
			[207] = 0.11, -- Serene Spirit
			[416] = 8.46, -- Natural Harmony
			[196] = 5.24, -- Swirling Sands
			[582] = 5.77, -- Heart of Darkness
			[179] = 3.83, -- Strength of Earth
			[501] = 4.12, -- Relational Normalization Gizmo
			[420] = 10, -- Roiling Storm
			[156] = 2.02, -- Ruinous Bolt
			[100] = 0.12, -- Strength in Numbers
			[480] = 3.93, -- Blood Rite
			[505] = 4.24, -- Tradewinds
			[479] = 4.32, -- Dagger in the Back
			[482] = 3.36, -- Thunderous Blast
			[560] = 2.2, -- Bonded Souls
			[194] = 3.35, -- Filthy Transfusion
			[22] = 1.76, -- Heed My Call
			[448] = 0.01, -- Synapse Shock
			[483] = 3.81, -- Archive of the Titans
			[493] = 2.28, -- Last Gift
			[104] = 0.04, -- Bracing Chill
			[193] = 6.16, -- Blightborne Infusion
			[478] = 3.43, -- Tidal Surge
			[19] = 0.01, -- Woundbinder
			[461] = 1.26, -- Earthlink
			[459] = 2.22, -- Unstable Flames
			[576] = 2.8, -- Loyal to the End
			[577] = 3.34, -- Arcane Heart
			[481] = 4, -- Incite the Pack
			[20] = 1.89, -- Lifespeed
			[14] = 0.01, -- Longstrider
			[38] = 1.97, -- On My Way
			[500] = 1.92, -- Synaptic Spark Capacitor
			[492] = 3.86, -- Liberator's Might
			[530] = 7.4, -- Thunderaan's Fury
			[521] = 4.08, -- Shadow of Elune
			[499] = 1.6, -- Ricocheting Inflatable Pyrosaw
			[82] = 5.95, -- Champion of Azeroth
			[43] = 0.04, -- Winds of War
			[526] = 6.82, -- Endless Hunger
			[575] = 6.48, -- Undulating Tides
			[523] = 3.37, -- Apothecary's Concoctions
			[503] = 0.01, -- Auto-Self-Cauterizer
			[137] = 1.47, -- Primal Primer
			[494] = 4.23, -- Battlefield Precision
			[18] = 1.54, -- Blood Siphon
			[561] = 3.35, -- Seductive Power
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 26802 - 32704 (avg 31116), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[14] = { 6.24, 2.61 }, -- Condensed Life-Force
			[35] = { 10, 4.9 }, -- Breath of the Dying
			[4] = { 5.16, 1.06 }, -- Worldvein Resonance
			[22] = { 1.92, 0.37 }, -- Vision of Perfection
			[12] = { 5.49, 2.15 }, -- The Crucible of Flame
			[6] = { 4.94, 2.15 }, -- Purification Protocol
			[28] = { 4.63, 2.08 }, -- The Unbound Force
			[32] = { 6.33, 2.45 }, -- Conflict and Strife
			[37] = { 2.99, 2.95 }, -- The Formless Void
			[15] = { 3.2, 0.02 }, -- Ripple in Space
			[36] = { 0.82, 0.84 }, -- Spark of Inspiration
			[27] = { 2.59, 1.65 }, -- Memory of Lucid Dreams
			[5] = { 7.57, 3.87 }, -- Essence of the Focusing Iris
			[23] = { 7.66, 3.53 }, -- Blood of the Enemy
		}, 1584266400)

		insertDefaultScalesData(offensiveName, 7, 3, { -- Restoration Shaman
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 90600 - 107003 (avg 100925), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[501] = 3.87, -- Relational Normalization Gizmo
			[157] = 4.23, -- Rezan's Fury
			[582] = 4.14, -- Heart of Darkness
			[478] = 4.02, -- Tidal Surge
			[496] = 1.02, -- Stronger Together
			[577] = 3.47, -- Arcane Heart
			[499] = 1.48, -- Ricocheting Inflatable Pyrosaw
			[82] = 4.29, -- Champion of Azeroth
			[561] = 2.21, -- Seductive Power
			[462] = 1.16, -- Azerite Globules
			[22] = 1.72, -- Heed My Call
			[423] = 0.01, -- Spouting Spirits
			[497] = 0.61, -- Stand As One
			[526] = 5.96, -- Endless Hunger
			[495] = 2.56, -- Anduin's Dedication
			[156] = 2.64, -- Ruinous Bolt
			[569] = 5.08, -- Clockwork Heart
			[416] = 5.4, -- Natural Harmony
			[447] = 1.54, -- Ancestral Resonance
			[14] = 0.04, -- Longstrider
			[482] = 3.44, -- Thunderous Blast
			[480] = 4.3, -- Blood Rite
			[38] = 1.64, -- On My Way
			[195] = 2.52, -- Secrets of the Deep
			[31] = 1.9, -- Gutripper
			[541] = 0.9, -- Fight or Flight
			[89] = 0.02, -- Azerite Veins
			[575] = 6.51, -- Undulating Tides
			[522] = 5.92, -- Ancients' Bulwark
			[30] = 3.16, -- Overwhelming Power
			[492] = 3.58, -- Liberator's Might
			[192] = 2.53, -- Meticulous Scheming
			[448] = 2.74, -- Synapse Shock
			[500] = 2.24, -- Synaptic Spark Capacitor
			[457] = 10, -- Igneous Potential
			[191] = 0.01, -- Turn of the Tide
			[87] = 0.05, -- Self Reliance
			[193] = 4.94, -- Blightborne Infusion
			[494] = 3.96, -- Battlefield Precision
			[483] = 2.86, -- Archive of the Titans
			[20] = 2.12, -- Lifespeed
			[498] = 2.61, -- Barrage Of Many Bombs
			[560] = 2.08, -- Bonded Souls
			[104] = 0.01, -- Bracing Chill
			[562] = 4.08, -- Treacherous Covenant
			[461] = 0.8, -- Earthlink
			[485] = 3.17, -- Laser Matrix
			[523] = 3.79, -- Apothecary's Concoctions
			[43] = 0.05, -- Winds of War
			[479] = 4.77, -- Dagger in the Back
			[504] = 2.26, -- Unstable Catalyst
			[194] = 3.76, -- Filthy Transfusion
			[21] = 1.39, -- Elemental Whirl
			[196] = 3.81, -- Swirling Sands
			[521] = 4.27, -- Shadow of Elune
			[459] = 1.85, -- Unstable Flames
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 94401 - 104101 (avg 100010), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[28] = { 3.13, 3.13 }, -- The Unbound Force
			[12] = { 10, 5.35 }, -- The Crucible of Flame
			[23] = { 1.32, 1.15 }, -- Blood of the Enemy
			[32] = { 3.51, 3.51 }, -- Conflict and Strife
			[15] = { 3.66, 0 }, -- Ripple in Space
			[35] = { 7.86, 7.86 }, -- Breath of the Dying
			[36] = { 1.58, 1.58 }, -- Spark of Inspiration
			[4] = { 3.82, 1.24 }, -- Worldvein Resonance
			[5] = { 6.77, 6.71 }, -- Essence of the Focusing Iris
			[14] = { 4.19, 4.11 }, -- Condensed Life-Force
			[37] = { 3.56, 3.51 }, -- The Formless Void
			[6] = { 3.44, 3.38 }, -- Purification Protocol
		}, 1584266400)

		insertDefaultScalesData(defaultName, 9, 1, { -- Affliction Warlock
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 82901 - 94201 (avg 88377), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[582] = 7.59, -- Heart of Darkness
			[560] = 3.21, -- Bonded Souls
			[479] = 5.47, -- Dagger in the Back
			[20] = 2.84, -- Lifespeed
			[82] = 7.63, -- Champion of Azeroth
			[462] = 1.52, -- Azerite Globules
			[123] = 5.14, -- Wracking Brilliance
			[569] = 8.03, -- Clockwork Heart
			[426] = 4.08, -- Dreadful Calling
			[192] = 6.85, -- Meticulous Scheming
			[30] = 4.51, -- Overwhelming Power
			[502] = 0.05, -- Personal Absorb-o-Tron
			[526] = 8.8, -- Endless Hunger
			[21] = 2.88, -- Elemental Whirl
			[459] = 2.83, -- Unstable Flames
			[480] = 5.96, -- Blood Rite
			[31] = 2.51, -- Gutripper
			[575] = 8.28, -- Undulating Tides
			[461] = 1.18, -- Earthlink
			[503] = 0.04, -- Auto-Self-Cauterizer
			[478] = 4.65, -- Tidal Surge
			[482] = 4.33, -- Thunderous Blast
			[498] = 3.34, -- Barrage Of Many Bombs
			[493] = 2.73, -- Last Gift
			[494] = 5.52, -- Battlefield Precision
			[183] = 5.89, -- Inevitable Demise
			[505] = 4.89, -- Tradewinds
			[501] = 5.38, -- Relational Normalization Gizmo
			[495] = 3.41, -- Anduin's Dedication
			[483] = 3.77, -- Archive of the Titans
			[230] = 10, -- Cascading Calamity
			[496] = 1.89, -- Stronger Together
			[481] = 4.41, -- Incite the Pack
			[442] = 4.72, -- Pandemic Invocation
			[522] = 8.8, -- Ancients' Bulwark
			[562] = 5.5, -- Treacherous Covenant
			[425] = 3.74, -- Sudden Onset
			[576] = 3.42, -- Loyal to the End
			[521] = 5.9, -- Shadow of Elune
			[504] = 3.18, -- Unstable Catalyst
			[157] = 5.25, -- Rezan's Fury
			[194] = 4.43, -- Filthy Transfusion
			[577] = 5.8, -- Arcane Heart
			[208] = 0.03, -- Lifeblood
			[193] = 8.12, -- Blightborne Infusion
			[500] = 2.55, -- Synaptic Spark Capacitor
			[83] = 0.05, -- Impassive Visage
			[485] = 4.22, -- Laser Matrix
			[523] = 4.23, -- Apothecary's Concoctions
			[195] = 3.56, -- Secrets of the Deep
			[38] = 2.52, -- On My Way
			[13] = 0.07, -- Azerite Empowered
			[22] = 2.27, -- Heed My Call
			[492] = 5.23, -- Liberator's Might
			[85] = 0.08, -- Gemhide
			[568] = 0.05, -- Person-Computer Interface
			[196] = 6.72, -- Swirling Sands
			[561] = 3, -- Seductive Power
			[497] = 0.86, -- Stand As One
			[86] = 0.04, -- Azerite Fortification
			[18] = 1.89, -- Blood Siphon
			[541] = 1.19, -- Fight or Flight
			[156] = 2.94, -- Ruinous Bolt
			[499] = 1.92, -- Ricocheting Inflatable Pyrosaw
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 78500 - 90200 (avg 86741), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[32] = { 2.42, 2.39 }, -- Conflict and Strife
			[23] = { 6.92, 1.95 }, -- Blood of the Enemy
			[12] = { 5.81, 2.2 }, -- The Crucible of Flame
			[4] = { 2.78, 0.7 }, -- Worldvein Resonance
			[14] = { 5.65, 2.45 }, -- Condensed Life-Force
			[15] = { 2.66, 0 }, -- Ripple in Space
			[22] = { 1.88, 3.36 }, -- Vision of Perfection
			[35] = { 10, 4.62 }, -- Breath of the Dying
			[28] = { 4.94, 2.23 }, -- The Unbound Force
			[37] = { 2.19, 2.17 }, -- The Formless Void
			[27] = { 2.16, 0.95 }, -- Memory of Lucid Dreams
			[6] = { 5.09, 2.04 }, -- Purification Protocol
			[36] = { 1.07, 1 }, -- Spark of Inspiration
			[5] = { 9.55, 4.44 }, -- Essence of the Focusing Iris
		}, 1584266400)

		insertDefaultScalesData(defaultName, 9, 2, { -- Demonology Warlock
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 58001 - 65602 (avg 60955), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[18] = 1.79, -- Blood Siphon
			[483] = 4.45, -- Archive of the Titans
			[462] = 1.16, -- Azerite Globules
			[526] = 8.23, -- Endless Hunger
			[156] = 2.81, -- Ruinous Bolt
			[82] = 7.19, -- Champion of Azeroth
			[494] = 3.44, -- Battlefield Precision
			[492] = 5.11, -- Liberator's Might
			[478] = 4.1, -- Tidal Surge
			[190] = 3.73, -- Umbral Blaze
			[495] = 4.08, -- Anduin's Dedication
			[485] = 3.37, -- Laser Matrix
			[498] = 2.57, -- Barrage Of Many Bombs
			[83] = 0.04, -- Impassive Visage
			[103] = 0.04, -- Concentrated Mending
			[19] = 0.04, -- Woundbinder
			[85] = 0.01, -- Gemhide
			[30] = 3.65, -- Overwhelming Power
			[38] = 2.54, -- On My Way
			[541] = 1.46, -- Fight or Flight
			[157] = 4.55, -- Rezan's Fury
			[505] = 4.65, -- Tradewinds
			[522] = 8.36, -- Ancients' Bulwark
			[194] = 4.05, -- Filthy Transfusion
			[100] = 0.02, -- Strength in Numbers
			[582] = 6.79, -- Heart of Darkness
			[500] = 2.09, -- Synaptic Spark Capacitor
			[429] = 10, -- Baleful Invocation
			[231] = 5.11, -- Explosive Potential
			[130] = 2.6, -- Shadow's Bite
			[459] = 3.05, -- Unstable Flames
			[504] = 3.5, -- Unstable Catalyst
			[521] = 5.51, -- Shadow of Elune
			[43] = 0.04, -- Winds of War
			[575] = 6.56, -- Undulating Tides
			[22] = 1.78, -- Heed My Call
			[461] = 1.39, -- Earthlink
			[193] = 8.44, -- Blightborne Infusion
			[496] = 1.86, -- Stronger Together
			[577] = 2.41, -- Arcane Heart
			[195] = 4.02, -- Secrets of the Deep
			[501] = 5.27, -- Relational Normalization Gizmo
			[42] = 0.01, -- Savior
			[31] = 1.93, -- Gutripper
			[21] = 2.6, -- Elemental Whirl
			[560] = 2.33, -- Bonded Souls
			[480] = 5.57, -- Blood Rite
			[482] = 3.46, -- Thunderous Blast
			[463] = 0.02, -- Blessed Portents
			[475] = 0.02, -- Desperate Power
			[562] = 6.38, -- Treacherous Covenant
			[428] = 4.24, -- Demonic Meteor
			[15] = 0.02, -- Resounding Protection
			[208] = 0.01, -- Lifeblood
			[499] = 1.62, -- Ricocheting Inflatable Pyrosaw
			[497] = 1.16, -- Stand As One
			[196] = 6.34, -- Swirling Sands
			[44] = 0.03, -- Vampiric Speed
			[458] = 4.16, -- Supreme Commander
			[481] = 4.18, -- Incite the Pack
			[20] = 2.11, -- Lifespeed
			[479] = 4.99, -- Dagger in the Back
			[569] = 7.04, -- Clockwork Heart
			[523] = 3.8, -- Apothecary's Concoctions
			[192] = 7.15, -- Meticulous Scheming
			[576] = 3.09, -- Loyal to the End
			[493] = 2.42, -- Last Gift
			[561] = 3.36, -- Seductive Power
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 56301 - 62000 (avg 59939), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[5] = { 8.8, 3.94 }, -- Essence of the Focusing Iris
			[14] = { 6.81, 2.82 }, -- Condensed Life-Force
			[12] = { 5.67, 3.03 }, -- The Crucible of Flame
			[35] = { 10, 5.14 }, -- Breath of the Dying
			[22] = { 8.2, 4.52 }, -- Vision of Perfection
			[27] = { 5.11, 3.04 }, -- Memory of Lucid Dreams
			[15] = { 2.97, 0.07 }, -- Ripple in Space
			[37] = { 3.66, 3.78 }, -- The Formless Void
			[4] = { 6.29, 1.34 }, -- Worldvein Resonance
			[6] = { 5.26, 2.33 }, -- Purification Protocol
			[32] = { 3.22, 3.27 }, -- Conflict and Strife
			[36] = { 1.32, 1.25 }, -- Spark of Inspiration
			[28] = { 6.61, 3.22 }, -- The Unbound Force
			[23] = { 5.73, 0.45 }, -- Blood of the Enemy
		}, 1584266400)

		insertDefaultScalesData(defaultName, 9, 3, { -- Destruction Warlock
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 68803 - 76903 (avg 72867), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[568] = 0.12, -- Person-Computer Interface
			[13] = 0.13, -- Azerite Empowered
			[478] = 5.08, -- Tidal Surge
			[157] = 5.84, -- Rezan's Fury
			[502] = 0.01, -- Personal Absorb-o-Tron
			[498] = 3.5, -- Barrage Of Many Bombs
			[18] = 2.34, -- Blood Siphon
			[98] = 0.19, -- Crystalline Carapace
			[83] = 0.19, -- Impassive Visage
			[480] = 7.24, -- Blood Rite
			[504] = 3.89, -- Unstable Catalyst
			[562] = 7.06, -- Treacherous Covenant
			[131] = 6.15, -- Chaos Shards
			[526] = 9.93, -- Endless Hunger
			[195] = 4.68, -- Secrets of the Deep
			[15] = 0.05, -- Resounding Protection
			[505] = 5.83, -- Tradewinds
			[501] = 6.57, -- Relational Normalization Gizmo
			[575] = 8.6, -- Undulating Tides
			[531] = 0.16, -- Terror of the Mind
			[44] = 0.17, -- Vampiric Speed
			[444] = 5.61, -- Crashing Chaos
			[431] = 0.01, -- Rolling Havoc
			[99] = 0.13, -- Ablative Shielding
			[85] = 0.05, -- Gemhide
			[432] = 6.63, -- Chaotic Inferno
			[104] = 0.11, -- Bracing Chill
			[494] = 5.08, -- Battlefield Precision
			[463] = 0.14, -- Blessed Portents
			[523] = 4.65, -- Apothecary's Concoctions
			[84] = 0.05, -- Bulwark of the Masses
			[500] = 2.65, -- Synaptic Spark Capacitor
			[31] = 2.78, -- Gutripper
			[459] = 3.35, -- Unstable Flames
			[105] = 0.08, -- Ephemeral Recovery
			[460] = 6.52, -- Bursting Flare
			[479] = 6.29, -- Dagger in the Back
			[42] = 0.15, -- Savior
			[156] = 3.42, -- Ruinous Bolt
			[561] = 4, -- Seductive Power
			[232] = 7.43, -- Flashpoint
			[100] = 0.09, -- Strength in Numbers
			[14] = 0.13, -- Longstrider
			[38] = 2.9, -- On My Way
			[86] = 0.16, -- Azerite Fortification
			[208] = 0.01, -- Lifeblood
			[481] = 5.31, -- Incite the Pack
			[192] = 7.83, -- Meticulous Scheming
			[499] = 2.08, -- Ricocheting Inflatable Pyrosaw
			[482] = 4.5, -- Thunderous Blast
			[560] = 3.69, -- Bonded Souls
			[461] = 1.69, -- Earthlink
			[30] = 5.27, -- Overwhelming Power
			[483] = 4.9, -- Archive of the Titans
			[503] = 0.13, -- Auto-Self-Cauterizer
			[497] = 1.07, -- Stand As One
			[576] = 4.21, -- Loyal to the End
			[496] = 2.31, -- Stronger Together
			[89] = 0.18, -- Azerite Veins
			[541] = 1.81, -- Fight or Flight
			[196] = 8.05, -- Swirling Sands
			[20] = 3.35, -- Lifespeed
			[194] = 4.86, -- Filthy Transfusion
			[21] = 3.32, -- Elemental Whirl
			[521] = 7.18, -- Shadow of Elune
			[493] = 2.89, -- Last Gift
			[492] = 6.39, -- Liberator's Might
			[569] = 7.91, -- Clockwork Heart
			[193] = 9.9, -- Blightborne Infusion
			[577] = 6.83, -- Arcane Heart
			[82] = 8.92, -- Champion of Azeroth
			[485] = 4.27, -- Laser Matrix
			[22] = 2.52, -- Heed My Call
			[87] = 0.16, -- Self Reliance
			[475] = 0.27, -- Desperate Power
			[103] = 0.11, -- Concentrated Mending
			[582] = 8.95, -- Heart of Darkness
			[462] = 1.68, -- Azerite Globules
			[522] = 10, -- Ancients' Bulwark
			[19] = 0.07, -- Woundbinder
			[495] = 4.49, -- Anduin's Dedication
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 66000 - 74203 (avg 71875), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[5] = { 7.48, 4.28 }, -- Essence of the Focusing Iris
			[27] = { 8.19, 1.92 }, -- Memory of Lucid Dreams
			[32] = { 2.28, 2.38 }, -- Conflict and Strife
			[28] = { 2.98, 1.67 }, -- The Unbound Force
			[22] = { 10, 4.21 }, -- Vision of Perfection
			[37] = { 2.4, 2.39 }, -- The Formless Void
			[23] = { 3.42, 0.83 }, -- Blood of the Enemy
			[35] = { 7.33, 3.94 }, -- Breath of the Dying
			[4] = { 3.44, 0.9 }, -- Worldvein Resonance
			[36] = { 1.06, 1.09 }, -- Spark of Inspiration
			[15] = { 1.97, 0.03 }, -- Ripple in Space
			[12] = { 3.81, 2.19 }, -- The Crucible of Flame
			[6] = { 3.5, 1.78 }, -- Purification Protocol
			[14] = { 4.46, 2.06 }, -- Condensed Life-Force
		}, 1584266400)

		insertDefaultScalesData(defaultName, 1, 1, { -- Arms Warrior
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 14903 - 18803 (avg 15805), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[226] = 10, -- Test of Might
			[99] = 0.07, -- Ablative Shielding
			[174] = 3.08, -- Gathering Storm
			[562] = 5.66, -- Treacherous Covenant
			[22] = 2.04, -- Heed My Call
			[577] = 4.29, -- Arcane Heart
			[501] = 4.13, -- Relational Normalization Gizmo
			[42] = 0.01, -- Savior
			[192] = 5.1, -- Meticulous Scheming
			[121] = 4.76, -- Striking the Anvil
			[462] = 1.26, -- Azerite Globules
			[434] = 6.34, -- Crushing Assault
			[504] = 3.21, -- Unstable Catalyst
			[193] = 6.12, -- Blightborne Infusion
			[30] = 3.08, -- Overwhelming Power
			[493] = 2.71, -- Last Gift
			[21] = 2.03, -- Elemental Whirl
			[433] = 3.07, -- Seismic Wave
			[478] = 3.13, -- Tidal Surge
			[86] = 0.06, -- Azerite Fortification
			[19] = 0.03, -- Woundbinder
			[498] = 2.85, -- Barrage Of Many Bombs
			[485] = 3.48, -- Laser Matrix
			[477] = 0.05, -- Bury the Hatchet
			[492] = 3.86, -- Liberator's Might
			[541] = 1.45, -- Fight or Flight
			[98] = 0.02, -- Crystalline Carapace
			[499] = 1.73, -- Ricocheting Inflatable Pyrosaw
			[480] = 4.16, -- Blood Rite
			[435] = 2.9, -- Lord of War
			[104] = 0.05, -- Bracing Chill
			[505] = 4.94, -- Tradewinds
			[521] = 4.14, -- Shadow of Elune
			[194] = 3.44, -- Filthy Transfusion
			[20] = 1.98, -- Lifespeed
			[461] = 1.21, -- Earthlink
			[85] = 0.01, -- Gemhide
			[582] = 5.8, -- Heart of Darkness
			[44] = 0.07, -- Vampiric Speed
			[497] = 0.89, -- Stand As One
			[18] = 1.85, -- Blood Siphon
			[89] = 0.04, -- Azerite Veins
			[569] = 6.21, -- Clockwork Heart
			[523] = 3.39, -- Apothecary's Concoctions
			[495] = 3.61, -- Anduin's Dedication
			[459] = 2.11, -- Unstable Flames
			[103] = 0.06, -- Concentrated Mending
			[31] = 2.18, -- Gutripper
			[196] = 5.03, -- Swirling Sands
			[522] = 5.72, -- Ancients' Bulwark
			[483] = 4.23, -- Archive of the Titans
			[156] = 1.92, -- Ruinous Bolt
			[500] = 1.67, -- Synaptic Spark Capacitor
			[494] = 4.33, -- Battlefield Precision
			[87] = 0.03, -- Self Reliance
			[100] = 0.07, -- Strength in Numbers
			[502] = 0.01, -- Personal Absorb-o-Tron
			[496] = 1.34, -- Stronger Together
			[157] = 4.22, -- Rezan's Fury
			[576] = 3.34, -- Loyal to the End
			[481] = 4.66, -- Incite the Pack
			[195] = 3.73, -- Secrets of the Deep
			[101] = 0.06, -- Shimmering Haven
			[575] = 7.04, -- Undulating Tides
			[560] = 2.56, -- Bonded Souls
			[482] = 3.71, -- Thunderous Blast
			[13] = 0.02, -- Azerite Empowered
			[479] = 4.35, -- Dagger in the Back
			[38] = 1.65, -- On My Way
			[82] = 6.14, -- Champion of Azeroth
			[561] = 3.81, -- Seductive Power
			[43] = 0.06, -- Winds of War
			[526] = 5.82, -- Endless Hunger
			[463] = 0.06, -- Blessed Portents
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 13803 - 16101 (avg 15333), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[28] = { 4.35, 2.12 }, -- The Unbound Force
			[12] = { 5.57, 2.12 }, -- The Crucible of Flame
			[22] = { 0.02, 0.08 }, -- Vision of Perfection
			[35] = { 9.6, 5.03 }, -- Breath of the Dying
			[15] = { 3.31, 0.04 }, -- Ripple in Space
			[32] = { 2.08, 2.07 }, -- Conflict and Strife
			[36] = { 0.97, 0.93 }, -- Spark of Inspiration
			[5] = { 7.89, 3.85 }, -- Essence of the Focusing Iris
			[4] = { 5.28, 1.07 }, -- Worldvein Resonance
			[27] = { 10, 3.89 }, -- Memory of Lucid Dreams
			[37] = { 3.01, 3.02 }, -- The Formless Void
			[6] = { 5.02, 2.3 }, -- Purification Protocol
			[14] = { 6.3, 2.72 }, -- Condensed Life-Force
			[23] = { 4.92, 1.32 }, -- Blood of the Enemy
		}, 1584266400)

		insertDefaultScalesData(defaultName, 1, 2, { -- Fury Warrior
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 16501 - 20702 (avg 17461), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[196] = 5.1, -- Swirling Sands
			[18] = 1.76, -- Blood Siphon
			[104] = 0.07, -- Bracing Chill
			[174] = 0.01, -- Gathering Storm
			[495] = 3.01, -- Anduin's Dedication
			[480] = 2.84, -- Blood Rite
			[505] = 4.54, -- Tradewinds
			[86] = 0.02, -- Azerite Fortification
			[101] = 0.05, -- Shimmering Haven
			[87] = 0.03, -- Self Reliance
			[481] = 4.21, -- Incite the Pack
			[84] = 0.03, -- Bulwark of the Masses
			[498] = 3.32, -- Barrage Of Many Bombs
			[502] = 0.03, -- Personal Absorb-o-Tron
			[15] = 0.02, -- Resounding Protection
			[31] = 2.44, -- Gutripper
			[562] = 4.66, -- Treacherous Covenant
			[21] = 1.9, -- Elemental Whirl
			[437] = 4.78, -- Simmering Rage
			[44] = 0.09, -- Vampiric Speed
			[462] = 1.45, -- Azerite Globules
			[157] = 4.9, -- Rezan's Fury
			[105] = 0.04, -- Ephemeral Recovery
			[560] = 1.77, -- Bonded Souls
			[119] = 5.94, -- Unbridled Ferocity
			[103] = 0.09, -- Concentrated Mending
			[438] = 5.38, -- Reckless Flurry
			[229] = 3.88, -- Pulverizing Blows
			[22] = 2.28, -- Heed My Call
			[82] = 5.56, -- Champion of Azeroth
			[499] = 2.08, -- Ricocheting Inflatable Pyrosaw
			[195] = 3.18, -- Secrets of the Deep
			[569] = 6.07, -- Clockwork Heart
			[575] = 8.09, -- Undulating Tides
			[478] = 3.62, -- Tidal Surge
			[554] = 0.08, -- Intimidating Presence
			[500] = 2.03, -- Synaptic Spark Capacitor
			[43] = 0.05, -- Winds of War
			[85] = 0.05, -- Gemhide
			[451] = 3.33, -- Infinite Fury
			[568] = 0.07, -- Person-Computer Interface
			[89] = 0.11, -- Azerite Veins
			[459] = 2.27, -- Unstable Flames
			[504] = 2.65, -- Unstable Catalyst
			[561] = 3.24, -- Seductive Power
			[476] = 0.01, -- Moment of Glory
			[99] = 0.04, -- Ablative Shielding
			[492] = 3.33, -- Liberator's Might
			[83] = 0.04, -- Impassive Visage
			[494] = 5.01, -- Battlefield Precision
			[503] = 0.07, -- Auto-Self-Cauterizer
			[193] = 5.89, -- Blightborne Infusion
			[497] = 0.73, -- Stand As One
			[576] = 3.05, -- Loyal to the End
			[176] = 10, -- Cold Steel, Hot Blood
			[463] = 0.05, -- Blessed Portents
			[194] = 3.45, -- Filthy Transfusion
			[483] = 3.48, -- Archive of the Titans
			[100] = 0.03, -- Strength in Numbers
			[501] = 3.17, -- Relational Normalization Gizmo
			[192] = 3.77, -- Meticulous Scheming
			[526] = 5.52, -- Endless Hunger
			[38] = 1.6, -- On My Way
			[485] = 4.07, -- Laser Matrix
			[20] = 1.38, -- Lifespeed
			[496] = 1.31, -- Stronger Together
			[30] = 2.07, -- Overwhelming Power
			[14] = 0.03, -- Longstrider
			[479] = 4.12, -- Dagger in the Back
			[461] = 1.1, -- Earthlink
			[493] = 2.47, -- Last Gift
			[156] = 2.27, -- Ruinous Bolt
			[521] = 2.91, -- Shadow of Elune
			[477] = 0.02, -- Bury the Hatchet
			[541] = 1.25, -- Fight or Flight
			[482] = 3.97, -- Thunderous Blast
			[98] = 0.11, -- Crystalline Carapace
			[13] = 0.02, -- Azerite Empowered
			[523] = 3.26, -- Apothecary's Concoctions
			[577] = 3, -- Arcane Heart
			[522] = 5.55, -- Ancients' Bulwark
			[582] = 5.05, -- Heart of Darkness
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 15700 - 18001 (avg 17216), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[22] = { 2.34, 0.78 }, -- Vision of Perfection
			[23] = { 1.35, 1.4 }, -- Blood of the Enemy
			[27] = { 5.32, 2.3 }, -- Memory of Lucid Dreams
			[5] = { 5.78, 2.61 }, -- Essence of the Focusing Iris
			[32] = { 1.96, 1.98 }, -- Conflict and Strife
			[4] = { 3.52, 0.91 }, -- Worldvein Resonance
			[6] = { 4.89, 2.67 }, -- Purification Protocol
			[36] = { 0.61, 0.61 }, -- Spark of Inspiration
			[15] = { 1.97, 0.03 }, -- Ripple in Space
			[12] = { 4.69, 2.5 }, -- The Crucible of Flame
			[28] = { 2, 0.77 }, -- The Unbound Force
			[37] = { 2.48, 2.52 }, -- The Formless Void
			[14] = { 6.02, 3.09 }, -- Condensed Life-Force
			[35] = { 10, 5.91 }, -- Breath of the Dying
		}, 1584266400)

		insertDefaultScalesData(offensiveName, 1, 3, { -- Protection Warrior
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 101800 - 116201 (avg 110843), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[22] = 2.71, -- Heed My Call
			[18] = 1.21, -- Blood Siphon
			[83] = 0.07, -- Impassive Visage
			[494] = 6.05, -- Battlefield Precision
			[492] = 4.5, -- Liberator's Might
			[485] = 5.09, -- Laser Matrix
			[575] = 10, -- Undulating Tides
			[441] = 2.01, -- Iron Fortress
			[462] = 1.79, -- Azerite Globules
			[440] = 1.2, -- Callous Reprisal
			[30] = 3.5, -- Overwhelming Power
			[502] = 0.01, -- Personal Absorb-o-Tron
			[38] = 2.03, -- On My Way
			[523] = 4.34, -- Apothecary's Concoctions
			[577] = 3.97, -- Arcane Heart
			[480] = 4.75, -- Blood Rite
			[504] = 3.06, -- Unstable Catalyst
			[501] = 4.48, -- Relational Normalization Gizmo
			[481] = 3.4, -- Incite the Pack
			[498] = 4.11, -- Barrage Of Many Bombs
			[500] = 2.62, -- Synaptic Spark Capacitor
			[497] = 0.73, -- Stand As One
			[195] = 3.44, -- Secrets of the Deep
			[237] = 4.94, -- Bastion of Might
			[482] = 5.12, -- Thunderous Blast
			[192] = 6.09, -- Meticulous Scheming
			[569] = 7.06, -- Clockwork Heart
			[461] = 1.17, -- Earthlink
			[196] = 6.14, -- Swirling Sands
			[560] = 2.71, -- Bonded Souls
			[156] = 3.02, -- Ruinous Bolt
			[521] = 4.73, -- Shadow of Elune
			[450] = 4.43, -- Brace for Impact
			[562] = 5.32, -- Treacherous Covenant
			[561] = 3.35, -- Seductive Power
			[522] = 7.18, -- Ancients' Bulwark
			[82] = 6.49, -- Champion of Azeroth
			[42] = 0.04, -- Savior
			[505] = 3.71, -- Tradewinds
			[493] = 1.85, -- Last Gift
			[118] = 1.8, -- Deafening Crash
			[576] = 2.52, -- Loyal to the End
			[193] = 7.45, -- Blightborne Infusion
			[541] = 1.19, -- Fight or Flight
			[21] = 2.27, -- Elemental Whirl
			[459] = 2.52, -- Unstable Flames
			[20] = 2.23, -- Lifespeed
			[526] = 7.18, -- Endless Hunger
			[496] = 1.5, -- Stronger Together
			[582] = 6.35, -- Heart of Darkness
			[499] = 2.34, -- Ricocheting Inflatable Pyrosaw
			[157] = 6.09, -- Rezan's Fury
			[479] = 3.88, -- Dagger in the Back
			[31] = 2.82, -- Gutripper
			[98] = 0.24, -- Crystalline Carapace
			[483] = 3.89, -- Archive of the Titans
			[495] = 3.32, -- Anduin's Dedication
			[194] = 5.23, -- Filthy Transfusion
			[478] = 5.09, -- Tidal Surge
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 102103 - 114102 (avg 110633), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 15.03.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[37] = { 3.37, 3.47 }, -- The Formless Void
			[4] = { 4.28, 1.18 }, -- Worldvein Resonance
			[25] = { 1.51, 1.48 }, -- Aegis of the Deep
			[22] = { 8.49, 5.52 }, -- Vision of Perfection
			[32] = { 3.27, 3.3 }, -- Conflict and Strife
			[27] = { 2.4, 0.91 }, -- Memory of Lucid Dreams
			[12] = { 10, 3.89 }, -- The Crucible of Flame
			[7] = { 3.88, 0 }, -- Anima of Life and Death
			[3] = { 7.79, 7.79 }, -- Sphere of Suppression
			[15] = { 4.31, 0 }, -- Ripple in Space
		}, 1584266400)

		insertDefaultScalesData(defensiveName, 12, 2, { -- Vengeance Demon Hunter (TMI)
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 13402 - 14882 (avg 13793), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 16.03.2020, Metric: Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[22] = 6.23, -- Heed My Call
			[38] = 1.7, -- On My Way
			[461] = 2.93, -- Earthlink
			[98] = 5.94, -- Crystalline Carapace
			[576] = 6.01, -- Loyal to the End
			[521] = 5.94, -- Shadow of Elune
			[523] = 1.35, -- Apothecary's Concoctions
			[560] = 2.24, -- Bonded Souls
			[193] = 0.67, -- Blightborne Infusion
			[221] = 3.88, -- Rigid Carapace
			[564] = 3.62, -- Thrive in Chaos
			[21] = 2.36, -- Elemental Whirl
			[18] = 4.13, -- Blood Siphon
			[479] = 4.42, -- Dagger in the Back
			[562] = 7.36, -- Treacherous Covenant
			[86] = 0.42, -- Azerite Fortification
			[84] = 4.75, -- Bulwark of the Masses
			[43] = 2.54, -- Winds of War
			[196] = 1.33, -- Swirling Sands
			[101] = 4.65, -- Shimmering Haven
			[194] = 1.53, -- Filthy Transfusion
			[30] = 2.49, -- Overwhelming Power
			[19] = 3.83, -- Woundbinder
			[483] = 3.26, -- Archive of the Titans
			[569] = 6.23, -- Clockwork Heart
			[496] = 10, -- Stronger Together
			[499] = 3.03, -- Ricocheting Inflatable Pyrosaw
			[582] = 4.89, -- Heart of Darkness
			[103] = 7.95, -- Concentrated Mending
			[89] = 3.75, -- Azerite Veins
			[504] = 1.62, -- Unstable Catalyst
			[20] = 0.57, -- Lifespeed
			[502] = 4.98, -- Personal Absorb-o-Tron
			[160] = 0.37, -- Infernal Armor
			[459] = 3.64, -- Unstable Flames
			[492] = 4.7, -- Liberator's Might
			[498] = 4.94, -- Barrage Of Many Bombs
			[505] = 4.12, -- Tradewinds
			[202] = 3.23, -- Soulmonger
			[100] = 6.54, -- Strength in Numbers
			[481] = 3.61, -- Incite the Pack
			[85] = 0.87, -- Gemhide
			[31] = 0.22, -- Gutripper
			[495] = 4.39, -- Anduin's Dedication
			[157] = 1.53, -- Rezan's Fury
			[480] = 1.47, -- Blood Rite
			[522] = 2, -- Ancients' Bulwark
			[354] = 4.29, -- Cycle of Binding
			[577] = 1.9, -- Arcane Heart
			[42] = 3.34, -- Savior
			[497] = 3.02, -- Stand As One
			[463] = 0.11, -- Blessed Portents
			[561] = 0.72, -- Seductive Power
			[575] = 2.37, -- Undulating Tides
			[104] = 1.12, -- Bracing Chill
			[355] = 9.15, -- Essence Sever
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 13402 - 14057 (avg 13727), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 16.03.2020, Metric: Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[4] = { 0, 0.08 }, -- Worldvein Resonance
			[3] = { 0.01, 0 }, -- Sphere of Suppression
			[27] = { 6.17, 4.73 }, -- Memory of Lucid Dreams
			[7] = { 10, 3.96 }, -- Anima of Life and Death
			[25] = { 0, 8.36 }, -- Aegis of the Deep
			[12] = { 2.5, 5.22 }, -- The Crucible of Flame
			[37] = { 0.86, 6.73 }, -- The Formless Void
			[22] = { 2.3, 3.08 }, -- Vision of Perfection
			[32] = { 1.44, 0 }, -- Conflict and Strife
			[2] = { 9.84, 0 }, -- Azeroth's Undying Gift
			[15] = { 0.23, 4.26 }, -- Ripple in Space
			[13] = { 2.57, 0 }, -- Nullification Dynamo
		}, 1584352800)

		insertDefaultScalesData(defensiveName, 11, 3, { -- Guardian Druid (TMI)
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6501 - 7101 (avg 6824), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 16.03.2020, Metric: Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[101] = 7.34, -- Shimmering Haven
			[86] = 4.76, -- Azerite Fortification
			[84] = 5.62, -- Bulwark of the Masses
			[496] = 4.32, -- Stronger Together
			[526] = 0.67, -- Endless Hunger
			[156] = 3.62, -- Ruinous Bolt
			[13] = 0.3, -- Azerite Empowered
			[500] = 6.65, -- Synaptic Spark Capacitor
			[98] = 2.96, -- Crystalline Carapace
			[521] = 4.34, -- Shadow of Elune
			[83] = 2.83, -- Impassive Visage
			[196] = 9.79, -- Swirling Sands
			[20] = 0.89, -- Lifespeed
			[504] = 2.33, -- Unstable Catalyst
			[85] = 6.92, -- Gemhide
			[219] = 1.64, -- Reawakening
			[195] = 5.6, -- Secrets of the Deep
			[505] = 2.69, -- Tradewinds
			[112] = 9.36, -- Layered Mane
			[502] = 1.58, -- Personal Absorb-o-Tron
			[482] = 1.92, -- Thunderous Blast
			[576] = 4.27, -- Loyal to the End
			[14] = 4.9, -- Longstrider
			[241] = 2.82, -- Twisted Claws
			[561] = 3.57, -- Seductive Power
			[492] = 7.75, -- Liberator's Might
			[480] = 2.4, -- Blood Rite
			[21] = 7.03, -- Elemental Whirl
			[15] = 0.53, -- Resounding Protection
			[171] = 1.24, -- Masterful Instincts
			[577] = 2.13, -- Arcane Heart
			[31] = 4.08, -- Gutripper
			[495] = 0.45, -- Anduin's Dedication
			[479] = 1.4, -- Dagger in the Back
			[194] = 10, -- Filthy Transfusion
			[569] = 2.2, -- Clockwork Heart
			[575] = 0.85, -- Undulating Tides
			[503] = 1.13, -- Auto-Self-Cauterizer
			[157] = 2.7, -- Rezan's Fury
			[82] = 4.39, -- Champion of Azeroth
			[100] = 5.44, -- Strength in Numbers
			[360] = 4.89, -- Gory Regeneration
			[42] = 4.64, -- Savior
			[251] = 4.7, -- Burst of Savagery
			[462] = 1.24, -- Azerite Globules
			[359] = 4.02, -- Wild Fleshrending
			[467] = 1.34, -- Ursoc's Endurance
			[501] = 8.48, -- Relational Normalization Gizmo
			[560] = 9.63, -- Bonded Souls
			[499] = 7.28, -- Ricocheting Inflatable Pyrosaw
			[19] = 1.32, -- Woundbinder
			[361] = 3.63, -- Guardian's Wrath
			[193] = 4.03, -- Blightborne Infusion
			[523] = 6.67, -- Apothecary's Concoctions
			[104] = 3.34, -- Bracing Chill
			[497] = 4.36, -- Stand As One
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6600 - 7103 (avg 6829), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 16.03.2020, Metric: Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[32] = { 3.29, 0.48 }, -- Conflict and Strife
			[22] = { 3.28, 10 }, -- Vision of Perfection
			[7] = { 0, 2.9 }, -- Anima of Life and Death
			[34] = { 4.22, 9.05 }, -- Strength of the Warden
			[2] = { 0, 8.02 }, -- Azeroth's Undying Gift
			[27] = { 3.72, 0 }, -- Memory of Lucid Dreams
			[12] = { 2.23, 3.97 }, -- The Crucible of Flame
			[15] = { 0.24, 6.46 }, -- Ripple in Space
			[33] = { 4.94, 9.59 }, -- Touch of the Everlasting
			[4] = { 5.97, 5.29 }, -- Worldvein Resonance
			[25] = { 2.56, 0 }, -- Aegis of the Deep
			[37] = { 0, 6.48 }, -- The Formless Void
		}, 1584352800)

		insertDefaultScalesData(defensiveName, 10, 1, { -- Brewmaster Monk (TMI)
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 15003 - 16739 (avg 15487), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 16.03.2020, Metric: Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[496] = 3.33, -- Stronger Together
			[503] = 5.58, -- Auto-Self-Cauterizer
			[104] = 0.29, -- Bracing Chill
			[21] = 3.86, -- Elemental Whirl
			[43] = 3.32, -- Winds of War
			[459] = 1.9, -- Unstable Flames
			[86] = 2.94, -- Azerite Fortification
			[87] = 1.28, -- Self Reliance
			[22] = 4.97, -- Heed My Call
			[504] = 4.3, -- Unstable Catalyst
			[83] = 6.31, -- Impassive Visage
			[521] = 7.97, -- Shadow of Elune
			[156] = 4.66, -- Ruinous Bolt
			[462] = 4.08, -- Azerite Globules
			[186] = 0.8, -- Staggering Strikes
			[498] = 6.17, -- Barrage Of Many Bombs
			[382] = 2.53, -- Straight, No Chaser
			[499] = 0.83, -- Ricocheting Inflatable Pyrosaw
			[482] = 1.3, -- Thunderous Blast
			[523] = 6.04, -- Apothecary's Concoctions
			[560] = 6.05, -- Bonded Souls
			[582] = 5.27, -- Heart of Darkness
			[85] = 0.54, -- Gemhide
			[561] = 1.34, -- Seductive Power
			[463] = 1.68, -- Blessed Portents
			[575] = 6.07, -- Undulating Tides
			[20] = 5.07, -- Lifespeed
			[497] = 4.51, -- Stand As One
			[492] = 2.79, -- Liberator's Might
			[82] = 2.66, -- Champion of Azeroth
			[383] = 5.27, -- Training of Niuzao
			[485] = 1.98, -- Laser Matrix
			[196] = 1.33, -- Swirling Sands
			[568] = 1.84, -- Person-Computer Interface
			[42] = 6.67, -- Savior
			[562] = 2.27, -- Treacherous Covenant
			[44] = 6.46, -- Vampiric Speed
			[494] = 1.76, -- Battlefield Precision
			[18] = 2.45, -- Blood Siphon
			[480] = 4.42, -- Blood Rite
			[479] = 3.84, -- Dagger in the Back
			[384] = 6.06, -- Elusive Footwork
			[99] = 3.81, -- Ablative Shielding
			[194] = 3.73, -- Filthy Transfusion
			[541] = 6.85, -- Fight or Flight
			[501] = 7.62, -- Relational Normalization Gizmo
			[105] = 1.91, -- Ephemeral Recovery
			[522] = 6.09, -- Ancients' Bulwark
			[238] = 0.92, -- Fit to Burst
			[576] = 10, -- Loyal to the End
			[577] = 7.32, -- Arcane Heart
			[192] = 1.07, -- Meticulous Scheming
			[116] = 1.8, -- Boiling Brew
			[481] = 3.28, -- Incite the Pack
			[15] = 6.45, -- Resounding Protection
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 15101 - 15701 (avg 15398), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 16.03.2020, Metric: Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[37] = { 2.11, 5.07 }, -- The Formless Void
			[27] = { 4.05, 1.66 }, -- Memory of Lucid Dreams
			[12] = { 10, 0 }, -- The Crucible of Flame
			[2] = { 2.54, 0.82 }, -- Azeroth's Undying Gift
			[32] = { 0, 4.53 }, -- Conflict and Strife
			[34] = { 0, 5.83 }, -- Strength of the Warden
			[33] = { 0, 4.64 }, -- Touch of the Everlasting
			[4] = { 7.66, 0 }, -- Worldvein Resonance
			[13] = { 0.88, 3.66 }, -- Nullification Dynamo
			[7] = { 1.92, 3.86 }, -- Anima of Life and Death
			[25] = { 7.73, 0.55 }, -- Aegis of the Deep
		}, 1584352800)

		insertDefaultScalesData(defensiveName, 2, 2, { -- Protection Paladin (TMI)
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 129400 - 131701 (avg 130648), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 16.03.2020, Metric: Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[14] = 4.13, -- Longstrider
			[560] = 1.54, -- Bonded Souls
			[498] = 2.88, -- Barrage Of Many Bombs
			[31] = 2.87, -- Gutripper
			[195] = 6.5, -- Secrets of the Deep
			[44] = 5.18, -- Vampiric Speed
			[503] = 2.97, -- Auto-Self-Cauterizer
			[575] = 1.55, -- Undulating Tides
			[21] = 1.23, -- Elemental Whirl
			[522] = 5.81, -- Ancients' Bulwark
			[568] = 3.22, -- Person-Computer Interface
			[103] = 4.82, -- Concentrated Mending
			[82] = 10, -- Champion of Azeroth
			[150] = 0.37, -- Soaring Shield
			[85] = 4.14, -- Gemhide
			[206] = 1.76, -- Stalwart Protector
			[502] = 1.98, -- Personal Absorb-o-Tron
			[20] = 1.44, -- Lifespeed
			[30] = 1.87, -- Overwhelming Power
			[38] = 3.8, -- On My Way
			[499] = 4.89, -- Ricocheting Inflatable Pyrosaw
			[485] = 4.19, -- Laser Matrix
			[105] = 3.05, -- Ephemeral Recovery
			[492] = 1.84, -- Liberator's Might
			[462] = 1.07, -- Azerite Globules
			[496] = 6.41, -- Stronger Together
			[125] = 3.4, -- Avenger's Might
			[98] = 3.8, -- Crystalline Carapace
			[500] = 5.42, -- Synaptic Spark Capacitor
			[194] = 4.92, -- Filthy Transfusion
			[495] = 3.4, -- Anduin's Dedication
			[497] = 6.4, -- Stand As One
			[13] = 4.3, -- Azerite Empowered
			[84] = 6.07, -- Bulwark of the Masses
			[235] = 7.42, -- Indomitable Justice
			[561] = 8.17, -- Seductive Power
			[189] = 2.26, -- Righteous Conviction
			[393] = 0.33, -- Grace of the Justicar
			[19] = 2.05, -- Woundbinder
			[562] = 5.32, -- Treacherous Covenant
			[454] = 1.68, -- Judicious Defense
			[494] = 2.25, -- Battlefield Precision
			[42] = 3.24, -- Savior
			[43] = 2.1, -- Winds of War
			[521] = 0.8, -- Shadow of Elune
			[569] = 0.45, -- Clockwork Heart
			[86] = 2.7, -- Azerite Fortification
			[99] = 0.62, -- Ablative Shielding
			[87] = 7.43, -- Self Reliance
			[15] = 0.68, -- Resounding Protection
			[234] = 2.16, -- Inner Light
			[576] = 2.6, -- Loyal to the End
			[483] = 1.97, -- Archive of the Titans
			[538] = 3.61, -- Empyreal Ward
			[463] = 2.61, -- Blessed Portents
			[157] = 8.57, -- Rezan's Fury
			[395] = 1.67, -- Inspiring Vanguard
			[478] = 2.4, -- Tidal Surge
			[133] = 3.11, -- Bulwark of Light
			[582] = 1.41, -- Heart of Darkness
			[18] = 4.89, -- Blood Siphon
			[479] = 4.16, -- Dagger in the Back
			[461] = 0.23, -- Earthlink
			[577] = 5.42, -- Arcane Heart
			[459] = 1.9, -- Unstable Flames
			[493] = 3.29, -- Last Gift
			[471] = 7.46, -- Gallant Steed
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 129900 - 131801 (avg 130795), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 16.03.2020, Metric: Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[13] = { 7.99, 7.66 }, -- Nullification Dynamo
			[7] = { 1.74, 5.47 }, -- Anima of Life and Death
			[27] = { 2, 6.65 }, -- Memory of Lucid Dreams
			[34] = { 2.03, 6.57 }, -- Strength of the Warden
			[4] = { 0.32, 1.5 }, -- Worldvein Resonance
			[32] = { 10, 5.69 }, -- Conflict and Strife
			[22] = { 4.27, 5.1 }, -- Vision of Perfection
			[2] = { 0.12, 0.79 }, -- Azeroth's Undying Gift
			[37] = { 3.6, 3.58 }, -- The Formless Void
			[12] = { 3.34, 1.43 }, -- The Crucible of Flame
			[15] = { 1.91, 0.64 }, -- Ripple in Space
			[25] = { 7.55, 4.62 }, -- Aegis of the Deep
			[33] = { 9.87, 2.5 }, -- Touch of the Everlasting
			[3] = { 1.29, 3.12 }, -- Sphere of Suppression
		}, 1584352800)

		insertDefaultScalesData(defensiveName, 1, 3, { -- Protection Warrior (TMI)
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 111202 - 114200 (avg 112765), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 16.03.2020, Metric: Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[44] = 3.73, -- Vampiric Speed
			[500] = 3.34, -- Synaptic Spark Capacitor
			[476] = 5.26, -- Moment of Glory
			[541] = 1.86, -- Fight or Flight
			[482] = 9.33, -- Thunderous Blast
			[193] = 5.96, -- Blightborne Infusion
			[105] = 1.74, -- Ephemeral Recovery
			[526] = 0.96, -- Endless Hunger
			[480] = 1.03, -- Blood Rite
			[31] = 7.51, -- Gutripper
			[19] = 0.27, -- Woundbinder
			[577] = 8.61, -- Arcane Heart
			[157] = 1.59, -- Rezan's Fury
			[483] = 2.07, -- Archive of the Titans
			[83] = 1.55, -- Impassive Visage
			[560] = 0.3, -- Bonded Souls
			[481] = 4.55, -- Incite the Pack
			[503] = 2.39, -- Auto-Self-Cauterizer
			[576] = 4.51, -- Loyal to the End
			[177] = 3.65, -- Bloodsport
			[86] = 0.56, -- Azerite Fortification
			[101] = 6.15, -- Shimmering Haven
			[194] = 1.09, -- Filthy Transfusion
			[497] = 2.52, -- Stand As One
			[461] = 5.05, -- Earthlink
			[192] = 3.63, -- Meticulous Scheming
			[498] = 0.11, -- Barrage Of Many Bombs
			[485] = 1.16, -- Laser Matrix
			[495] = 0.94, -- Anduin's Dedication
			[582] = 1.77, -- Heart of Darkness
			[13] = 3.18, -- Azerite Empowered
			[494] = 0.38, -- Battlefield Precision
			[478] = 2.21, -- Tidal Surge
			[562] = 3.27, -- Treacherous Covenant
			[84] = 2.95, -- Bulwark of the Masses
			[104] = 10, -- Bracing Chill
			[98] = 0.91, -- Crystalline Carapace
			[569] = 2.99, -- Clockwork Heart
			[87] = 1.9, -- Self Reliance
			[43] = 2.92, -- Winds of War
			[499] = 2.51, -- Ricocheting Inflatable Pyrosaw
			[441] = 0.15, -- Iron Fortress
			[477] = 4.27, -- Bury the Hatchet
			[459] = 1.7, -- Unstable Flames
			[463] = 5.34, -- Blessed Portents
			[82] = 1.3, -- Champion of Azeroth
			[554] = 1.91, -- Intimidating Presence
			[15] = 1.39, -- Resounding Protection
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 111900 - 113601 (avg 112725), Target Error: 0.05, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 16.03.2020, Metric: Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[37] = { 0, 3.26 }, -- The Formless Void
			[27] = { 0, 3.89 }, -- Memory of Lucid Dreams
			[2] = { 4.38, 4.21 }, -- Azeroth's Undying Gift
			[4] = { 5.69, 0 }, -- Worldvein Resonance
			[34] = { 0, 2.43 }, -- Strength of the Warden
			[25] = { 5.2, 0 }, -- Aegis of the Deep
			[3] = { 0, 3.62 }, -- Sphere of Suppression
			[7] = { 7.68, 10 }, -- Anima of Life and Death
			[32] = { 2.44, 3.55 }, -- Conflict and Strife
			[12] = { 3.96, 6.33 }, -- The Crucible of Flame
			[15] = { 1.94, 3.1 }, -- Ripple in Space
			[22] = { 0, 2.74 }, -- Vision of Perfection
			[33] = { 2.22, 9.01 }, -- Touch of the Everlasting
		}, 1584352800)

		insertDefaultScalesData(defaultName, 5, 3, { -- Shadow Priest
			-- Shadow Priest by WarcraftPriests (https://warcraftpriests.com/)
			-- https://github.com/WarcraftPriests/bfa-shadow-priest/blob/master/azerite-traits/AzeritePowerWeights_AS.md
			-- First Imported: 03.09.2018, Updated: 16.03.2020
			[575] = 5.08,
			[405] = 4.93,
			[193] = 4.79,
			[236] = 4.52,
			[82] = 4.45,
			[522] = 4.25,
			[196] = 4.25,
			[526] = 4.22,
			[582] = 4.08,
			[569] = 3.78,
			[192] = 3.73,
			[479] = 3.47,
			[501] = 3.35,
			[488] = 3.33,
			[157] = 3.11,
			[505] = 2.95,
			[486] = 2.94,
			[480] = 2.93,
			[521] = 2.92,
			[481] = 2.75,
			[482] = 2.73,
			[577] = 2.69,
			[523] = 2.66,
			[194] = 2.62,
			[504] = 2.61,
			[478] = 2.43,
			[404] = 2.38,
			[403] = 2.35,
			[195] = 2.33,
			[489] = 2.26,
			[30] = 2.23,
			[498] = 2.07,
			[459] = 1.66,
			[31] = 1.57,
			[487] = 1.57,
			[156] = 1.49,
			[21] = 1.46,
			[22] = 1.38,
			[500] = 1.29,
			[499] = 1.25,
			[38] = 1.22,
			[18] = 1.12,
			[490] = 1.11,
			[166] = 1.06,
			[491] = 1.02,
			[462] = 0.91,
			[541] = 0.89,
			[461] = 0.77,
			[13] = 0.4,
		}, {
		}, 1584352800)

		insertDefaultScalesData(defensiveName, 6, 1, { -- Blood Death Knight
			-- Blood Death Knight by Acherus
			-- https://github.com/ahakola/AzeritePowerWeights/pull/3
			-- First Imported: 07.09.2019, Updated: 07.09.2019
			[560] = 2.25,
			[243] = 2.5,
			[481] = 5.85,
			[196] = 3.81,
			[193] = 4.12,
			[461] = 0.72,
			[496] = 1.05,
			[43] = 0.11,
			[83] = 10,
			[349] = 1,
			[197] = 0.3,
			[495] = 1.99,
			[82] = 6.03,
			[15] = 10,
			[348] = 2,
			[18] = 5.65,
			[526] = 3.6,
			[577] = 0.92,
			[561] = 4.22,
			[30] = 3.86,
			[192] = 5.2,
			[505] = 6.41,
			[501] = 4.85,
			[493] = 3.5,
			[521] = 4.16,
			[497] = 0.9,
			[459] = 1.6,
			[195] = 2.38,
			[201] = 0.04,
			[106] = 3.85,
			[492] = 3.38,
			[21] = 1.77,
			[480] = 3.98,
			[140] = 2.69,
			[485] = 0.06,
			[44] = 3,
			[498] = 0.08,
			[19] = 0.06,
			[504] = 2.8,
			[20] = 2.2,
			[541] = 0.91,
			[562] = 3.78,
			[479] = 0.01,
			[569] = 4.52,
			[522] = 3.34,
			[38] = 0.81,
			[22] = 0.05,
			[576] = 4.35,
			[483] = 3.04,
			[104] = 0.13,
		}, {
			[32] = { 0.71, 3.7 },
			[3] = { 1.2, 0.5 },
			[7] = { 0.7, 0.3 },
			[4] = { 0.69, 0.48 },
			[25] = { 0.36, 2.5 },
			[12] = { 3, 1.7 },
			[2] = { 1.2, 0.03 },
			[22] = { 0.4, 0 },
			[15] = { 0.56, 0 },
			[27] = { 1.5, 0.7 },
		}, 1584352800)


		insertDefaultScalesData(defaultName, 10, 2, { -- Mistweaver Monk

		}, {})

		insertDefaultScalesData(defaultName, 11, 4, { -- Restoration Druid

		}, {})

		insertDefaultScalesData(defaultName, 2, 1, { -- Holy Paladin

		}, {})

		insertDefaultScalesData(defaultName, 5, 1, { -- Discipline Priest

		}, {})

		insertDefaultScalesData(defaultName, 5, 2, { -- Holy Priest

		}, {})

		insertDefaultScalesData(defaultName, 7, 3, { -- Restoration Shaman

		}, {})

end

local tankSpecs = {
	[1] = 3, -- Protection Warrior
	[2] = 2, -- Protection Paladin
	[6] = 1, -- Blood Death Knight
	[10] = 1, -- Brewmaster Monk
	[11] = 3, -- Guardian Druid
	[12] = 2 -- Vengeance Demon Hunter
}

-- Default ScaleSets for Class and Spec Combinations
local function GetDefaultScaleSet(classID, specNum)
	if (classID) and (specNum) then
		if tankSpecs[classID] == specNum then -- Tank Case
			return "D/"..classID.."/"..specNum.."/"..defensiveName
		else -- Generic Case
			return "D/"..classID.."/"..specNum.."/"..defaultName
		end
	end
end

n.GetDefaultScaleSet = GetDefaultScaleSet

--#EOF

--[[----------------------------------------------------------------------------
	AzeritePowerWeights

	Helps you pick the best Azerite powers on your gear for your class and spec.

	(c) 2018 -
	Sanex @ EU-Arathor / ahak @ Curseforge
----------------------------------------------------------------------------]]--
local AceGUI = LibStub("AceGUI-3.0")

-- Scale Viewer/Editor Frame
local function CreateUI(...)
	-- Main Frame
	local frame = AceGUI:Create("Frame")
	frame:SetLayout("Fill")
	frame:SetTitle(format(U["ScaleWeightEditor_Title"], "AzeritePowerWeights"))
	frame:SetStatusText("")
	--frame:SetWidth(474)
	frame:SetWidth(540)
	frame:SetHeight(484)
	frame.frame:SetMinResize(474, 484)
	frame:Hide()

	-- Scales List
	local treeGroup = AceGUI:Create("TreeGroup")
	treeGroup:SetFullWidth(true)
	treeGroup:SetFullHeight(true)
	treeGroup:SetLayout("Fill")

	frame:AddChild(treeGroup)
	n.treeGroup = treeGroup

	-- Content Area
	local scalesScroll = AceGUI:Create("ScrollFrame")
	scalesScroll:SetLayout("Flow")

	treeGroup:AddChild(scalesScroll)
	n.scalesScroll = scalesScroll

	return frame
end

n.CreateUI = CreateUI


-- PopUp Frame
local popupOpenAlready = false
local function CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	local function _closePopUp(widget)
		widget.frame:GetParent().obj:Hide()
	end

	if popupOpenAlready then -- Check if we have popup open already...
		--print("AzeritePowerWeights", "POPUP JAMMERED!")
		return
	end

	local height = 100
	local frame = AceGUI:Create("Window")
	frame:SetTitle(titleText)
	frame:SetWidth(350)
	frame:SetHeight(height)
	frame:EnableResize(false)
	frame:SetLayout("Flow")
	frame:SetCallback("OnClose", function(widget)
		--print("RELEASED!")
		AceGUI:Release(widget)
		popupOpenAlready = false
	end)

	--frame.frame:SetToplevel()
	frame.frame:Raise()

	local text = AceGUI:Create("Label")
	text:SetFullWidth(true)
	text:SetFontObject(GameFontHighlight)
	text:SetText(descriptionText)
	text:SetJustifyH("CENTER")
	frame:AddChild(text)

	local topLine = AceGUI:Create("Heading")
	topLine:SetFullWidth(true)
	frame:AddChild(topLine)

	local edit, multiEdit
	if mode == "MassImport" then
		multiEdit = AceGUI:Create("MultiLineEditBox")
		multiEdit:SetFullWidth(true)
		multiEdit:DisableButton(true)
		multiEdit:SetText("")
		multiEdit:SetLabel("")
		multiEdit:SetNumLines(4)
		multiEdit:SetFocus()
		multiEdit:SetCallback("OnEnterPressed", callbackFunction or _closePopUp)
		frame:AddChild(multiEdit)
	else
		edit = AceGUI:Create("EditBox")
		edit:SetFullWidth(true)
		edit:DisableButton(true)
		edit:SetText("")
		edit:SetFocus()
		edit:SetCallback("OnEnterPressed", callbackFunction or _closePopUp)
		frame:AddChild(edit)
	end

	local bottomLine = AceGUI:Create("Heading")
	bottomLine:SetFullWidth(true)
	frame:AddChild(bottomLine)

	if mode == "Import" then -- Import
		local accept = AceGUI:Create("Button")
		accept:SetRelativeWidth(.5)
		accept:SetText(_G.ACCEPT)
		accept:SetCallback("OnClick", callbackFunction or _closePopUp)
		frame:AddChild(accept)

		local close = AceGUI:Create("Button")
		close:SetRelativeWidth(.5)
		close:SetText(_G.CANCEL)
		close:SetCallback("OnClick", _closePopUp)
		frame:AddChild(close)

		edit:SetCallback("OnTextChanged", function(widget, callback, text)
			edit:SetUserData("importString", text)
			accept:SetUserData("importString", text)
		end)
		-- Make sure we get return even if the text doesn't change
		edit:SetUserData("importString", editboxText)
		accept:SetUserData("importString", editboxText)

	elseif mode == "MassImport" then -- Mass Import
		local accept = AceGUI:Create("Button")
		accept:SetRelativeWidth(.5)
		accept:SetText(_G.ACCEPT)
		accept:SetCallback("OnClick", callbackFunction or _closePopUp)
		frame:AddChild(accept)

		local close = AceGUI:Create("Button")
		close:SetRelativeWidth(.5)
		close:SetText(_G.CANCEL)
		close:SetCallback("OnClick", _closePopUp)
		frame:AddChild(close)

		multiEdit:SetCallback("OnTextChanged", function(widget, callback, text)
			multiEdit:SetUserData("importString", text)
			accept:SetUserData("importString", text)
		end)
		-- Make sure we get return even if the text doesn't change
		multiEdit:SetUserData("importString", editboxText)
		accept:SetUserData("importString", editboxText)

	elseif mode == "Create" then -- Create
		local accept = AceGUI:Create("Button")
		accept:SetRelativeWidth(.5)
		accept:SetText(_G.ACCEPT)
		accept:SetCallback("OnClick", callbackFunction or _closePopUp)
		frame:AddChild(accept)

		local close = AceGUI:Create("Button")
		close:SetRelativeWidth(.5)
		close:SetText(_G.CANCEL)
		close:SetCallback("OnClick", _closePopUp)
		frame:AddChild(close)

		local classTable, specTable, orderTable = {}, {}, {}
		local classIconsFile = "Interface\\Glues\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES"
		--local classIconsFile = "Interface\\TargetingFrame\\UI-Classes-Circles"
		for i = 1, _G.MAX_CLASSES do
			local classDisplayName, classTag = GetClassInfo(i)
			local c = _G.RAID_CLASS_COLORS[classTag]
			local left, right, top, bottom = unpack(_G.CLASS_ICON_TCOORDS[classTag])
			local classIcon = ("|T%s:18:18:0:0:256:256:%d:%d:%d:%d|t"):format(classIconsFile, left*256, right*256, top*256, bottom*256)
			classTable[i] = ("  %s |c%s%s|r  "):format(classIcon, c.colorStr, classDisplayName)
		end

		local classDropdown = AceGUI:Create("Dropdown")
		classDropdown:SetRelativeWidth(.5)
		classDropdown:SetList(classTable)
		frame:AddChild(classDropdown, edit)

		local specDropdown = AceGUI:Create("Dropdown")
		specDropdown:SetRelativeWidth(.5)
		specDropdown:SetList(specTable)
		frame:AddChild(specDropdown, edit)

		edit:SetCallback("OnTextChanged", function(widget, callback, text)
			classDropdown:SetUserData("nameString", text)
			specDropdown:SetUserData("nameString", text)
			edit:SetUserData("nameString", text)
			accept:SetUserData("nameString", text)
		end)
		classDropdown:SetCallback("OnValueChanged", function(widget, callback, key)
			wipe(specTable)
			wipe(orderTable)
			local value
			for i = 1, GetNumSpecializationsForClassID(key) do
				local specID, name, _, iconID = GetSpecializationInfoForClassID(key, i)
				specTable[specID] = ("  |T%d:18|t %s  "):format(iconID, name)
				orderTable[i] = specID
				if not value then
					value = specID
				end
			end
			specDropdown:SetList(specTable, orderTable)
			specDropdown:SetValue(value)

			classDropdown:SetUserData("classID", key)
			specDropdown:SetUserData("classID", key)
			edit:SetUserData("classID", key)
			accept:SetUserData("classID", key)

			classDropdown:SetUserData("specID", value)
			specDropdown:SetUserData("specID", value)
			edit:SetUserData("specID", value)
			accept:SetUserData("specID", value)
		end)
		specDropdown:SetCallback("OnValueChanged", function(widget, callback, key)
			classDropdown:SetUserData("specID", key)
			specDropdown:SetUserData("specID", key)
			edit:SetUserData("specID", key)
			accept:SetUserData("specID", key)
		end)
		-- Make sure we get return even if the text doesn't change
		classDropdown:SetUserData("nameString", editboxText)
		specDropdown:SetUserData("nameString", editboxText)
		edit:SetUserData("nameString", editboxText)
		accept:SetUserData("nameString", editboxText)
		--classDropdown:SetValue(1) -- Warrior
		--specDropdown:SetValue(71) -- Arms

	elseif mode == "Export" then -- Export
		local close = AceGUI:Create("Button")
		close:SetFullWidth(true)
		close:SetText(_G.CLOSE)
		close:SetCallback("OnClick", _closePopUp)
		frame:AddChild(close)

		edit:SetText(editboxText)
		edit:HighlightText()
		edit:SetCallback("OnTextChanged", function(widget, callback, text)
			edit:SetText(editboxText)
			edit:HighlightText()
		end)

	elseif mode == "Rename" then -- Rename
		local accept = AceGUI:Create("Button")
		accept:SetRelativeWidth(.5)
		accept:SetText(_G.ACCEPT)
		accept:SetCallback("OnClick", callbackFunction or _closePopUp)
		frame:AddChild(accept)

		local close = AceGUI:Create("Button")
		close:SetRelativeWidth(.5)
		close:SetText(_G.CANCEL)
		close:SetCallback("OnClick", _closePopUp)
		frame:AddChild(close)

		edit:SetText(editboxText)
		edit:HighlightText()
		edit:SetCallback("OnTextChanged", function(widget, callback, text)
			edit:SetUserData("renameString", text)
			accept:SetUserData("renameString", text)
		end)
		-- Make sure we get return even if the text doesn't change
		edit:SetUserData("renameString", editboxText)
		accept:SetUserData("renameString", editboxText)

	elseif mode == "Delete" then -- Delete
		local accept = AceGUI:Create("Button")
		accept:SetRelativeWidth(.5)
		accept:SetText(_G.ACCEPT)
		accept:SetCallback("OnClick", callbackFunction or _closePopUp)
		frame:AddChild(accept)

		local close = AceGUI:Create("Button")
		close:SetRelativeWidth(.5)
		close:SetText(_G.CANCEL)
		close:SetCallback("OnClick", _closePopUp)
		frame:AddChild(close)

		edit:SetText(editboxText)
		edit:SetDisabled(true)

	end

	-- Resize frame to fit all elements
	local total, odd = 0, true
	for _, e in pairs(frame.children) do
		local h = e.frame.height or e.frame:GetHeight()
		local w = e.frame.width or e.frame:GetWidth()
		if w < 245 then -- FullWidth elements are 326 pixels wide, half width ~163 pixels
			if odd then -- Count only every other half width element to the total height
				total = total + h + 3
				odd = false
			else
				odd = true
			end
		else
			total = total + h + 3
		end
		--print(">>", h, w, odd, total)
	end

	while frame.content:GetHeight() < total do
		height = height + 1
		frame:SetHeight(height)
	end

	popupOpenAlready = true
end

n.CreatePopUp = CreatePopUp

--#EOF

--[[----------------------------------------------------------------------------
	AzeritePowerWeights

	Helps you pick the best Azerite powers on your gear for your class and spec.

	(c) 2018 -
	Sanex @ EU-Arathor / ahak @ Curseforge
----------------------------------------------------------------------------]]--
-- Libs
local ACD = LibStub("AceConfigDialog-3.0")
local ACR = LibStub("AceConfigRegistry-3.0")
local AceGUI = LibStub("AceGUI-3.0")

-- Default DB settings
local dbVersion = 3
local dbDefaults = {
	customScales = {},
	char = {},
	dbVersion = dbVersion
}
local charDefaults = { -- Remember to update the ticket-tool when changing this
	debug = false,
	enableTraits = true,
	enableEssences = true,
	onlyOwnClassDefaults = true,
	onlyOwnClassCustoms = false,
	importingCanUpdate = true,
	defensivePowers = true,
	rolePowers = true,
	rolePowersNoOffRolePowers = true,
	zonePowers = true,
	professionPowers = false,
	pvpPowers = false,
	addILvlToScore = true,
	scaleByAzeriteEmpowered = false,
	addPrimaryStatToScore = false,
	relativeScore = false,
	showOnlyUpgrades = false,
	showTooltipLegend = false,
	outlineScores = true,
	preferBiSMarjor = true,
	specScales = {},
	tooltipScales = {}
}

-- Slots for Azerite Gear
local azeriteSlots = {
	[1] = true, -- Head
	[3] = true, -- Shoulder
	[5] = true -- Chest
}

-- Weight Editor
local importVersion = 2

-- Score Strings
local reallyBigNumber = 2^31 - 1 -- 2147483647, go over this and errors are thrown
local activeTStrings, activeEStrings = {}, {} -- Pointers of score strings in use are save in this table
local scoreData = {} -- Current active scales are saved to this table
-- 8.2 Azerite Essences
local essenceScoreData = {}

-- Pointers and Eventframe
local customScales, cfg
local db, lastOpenScale
local playerClassID, playerSpecID
local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
	return self[event] and self[event](self, event, ...)
end)
f:RegisterEvent("ADDON_LOADED")


local function Print(text, ...)
	if text then
		if text:match("%%[dfqs%d%.]") then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffcc00AzeritePowerWeights:|r " .. format(text, ...))
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffcc00AzeritePowerWeights:|r " .. strjoin(" ", text, tostringall(...)))
		end
	end
end

local function initDB(db, defaults) -- This function copies values from one table into another:
	if type(db) ~= "table" then db = {} end
	if type(defaults) ~= "table" then return db end
	for k, v in pairs(defaults) do
		if type(v) == "table" then
			db[k] = initDB(db[k], v)
		elseif type(v) ~= type(db[k]) then
			db[k] = v
		end
	end
	return db
end

local function shallowcopy(orig) -- http://lua-users.org/wiki/CopyTable
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

local function _isInteger(number)
	return number == floor(number)
end

local function _getDecimals(number)
	local num, decimals = strsplit(".", tostring(number))
	return decimals and strlen(decimals) or 0
end

local function _activeSpec() -- Get current active spec for scoreData population etc.
	local currentSpec = GetSpecialization()
	if currentSpec then
		local specID = GetSpecializationInfo(currentSpec)
		if specID then
			playerSpecID = specID
		end
	end
end

local traitStack, essenceStack = {}, {}
local function _populateWeights() -- Populate scoreData with active spec's scale
	if not playerSpecID then return end -- No playerSpecID yet, return
	local scaleKey = cfg.specScales[playerSpecID].scaleID
	local groupSet, classID, specNum, scaleName = strsplit("/", scaleKey)
	if groupSet and classID and specNum and scaleName then
		classID = tonumber(classID)
		specNum = tonumber(specNum)
		for _, dataSet in ipairs(groupSet == "C" and customScales or n.defaultScalesData) do
			if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specNum then
				wipe(scoreData)
				local scoreCount = 0
				for k, v in pairs(dataSet[4]) do
					scoreData[k] = v
					scoreCount = scoreCount + 1
				end
				traitStack.loading = scoreCount
				-- 8.2 Azerite Essences
				wipe(essenceScoreData)
				local essenceCount = 0
				for k, v in pairs(dataSet[5]) do
					essenceScoreData[k] = v
					essenceCount = essenceCount + 1
				end
				essenceStack.loading = essenceCount
				if n.guiContainer then
					n.guiContainer:SetStatusText(format(U["WeightEditor_CurrentScale"], groupSet == "D" and (n.defaultNameTable[scaleName] or cfg.specScales[playerSpecID].scaleName) or cfg.specScales[playerSpecID].scaleName))
				end
				return
			end
		end
	else
	end
end

local AcquireString, ReleaseString
do
	local string_cache = {}

	function AcquireString(parent, text)
		local string

		if #string_cache > 0 then
			string = tremove(string_cache)
		else
			string = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		end

		local fontName, fontHeight, fontFlags = string:GetFont()
		if cfg.outlineScores then
			string:SetFont(fontName, fontHeight, "OUTLINE")
		else
			string:SetFont(fontName, fontHeight, "")
		end

		string:Show()
		string:SetPoint("CENTER", parent)
		string:SetText(text)
		f:SetFrameStrata("HIGH") -- parent:GetFrameStrata() returns MEDIUM after a while for some reason?

		return string
	end

	function ReleaseString(string)
		string:SetText("")
		string:Hide()
		string:ClearAllPoints()

		string_cache[#string_cache + 1] = string
	end
end -- StringPool

-- Delay function
local lock
local function delayedUpdate()
	if not lock then
		lock = true
		C_Timer.After(0, f.UpdateValues) -- Wait until next frame
	end
end

-- Scale weight editor related functions
local function _customSort(a, b)
	if a.value and b.value then -- Sorting Tree
		if a.text ~= b.text then
			return a.text < b.text
		else
			return a.value < b.value
		end
	else -- Sorting Custom Scales save-table
		if a[1] ~= b[1] then
			return a[1] < b[1]
		elseif a[2] ~= b[2] then
			return a[2] < b[2]
		else
			return a[3] < a[3]
		end
	end
end

local pvpPairs = { -- Used for Exporting/Importing. These powers have same effects, but are different powers
	-- Horde
	[486] = 6,
	[487] = 6,
	[488] = 6,
	[489] = 6,
	[490] = 6,
	[491] = 6,

	-- Alliance
	[492] = -6,
	[493] = -6,
	[494] = -6,
	[495] = -6,
	[496] = -6,
	[497] = -6
}
local function insertCustomScalesData(scaleName, classIndex, specID, powerData, essenceData, scaleMode) -- Insert into table
	local t, e = {}, {}
	if powerData and powerData ~= "" then -- String to table
		for _, weight in pairs({ strsplit(",", powerData) }) do
			local azeritePowerID, value = strsplit("=", strtrim(weight))
			azeritePowerID = tonumber(azeritePowerID) or nil
			value = tonumber(value) or nil

			if azeritePowerID and value and value > 0 then
				value = value > reallyBigNumber and reallyBigNumber or value
				t[azeritePowerID] = value
				if pvpPairs[azeritePowerID] then -- Mirror PvP Powers for both factions
					t[azeritePowerID + pvpPairs[azeritePowerID]] = value
				end
			end
		end
	end

	-- 8.2 Azerite Essences
	if essenceData and essenceData ~= "" then -- String to table
		for _, weight in pairs({ strsplit(",", essenceData) }) do
			local essenceID, valuePair = strsplit("=", strtrim(weight))
			if essenceID and valuePair then
				local majorValue, minorValue = strsplit("/", strtrim(valuePair))
				essenceID = tonumber(essenceID) or nil
				majorValue = tonumber(majorValue) or nil
				minorValue = tonumber(minorValue) or nil

				if essenceID and (majorValue or minorValue) and (majorValue > 0 or minorValue > 0) then
					majorValue = majorValue and (majorValue > reallyBigNumber and reallyBigNumber or majorValue) or 0
					minorValue = minorValue and (minorValue > reallyBigNumber and reallyBigNumber or minorValue) or 0
					e[essenceID] = { majorValue, minorValue }
				end
			end
		end
	end

	local updated = false
	-- Check if we have scale with same name already and update it
	for key, dataSet in ipairs(customScales) do
		if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classIndex and dataSet[3] == specID then
			dataSet[4] = t
			-- 8.2 Azerite Essences
			--dataSet[5] = time() -- Timestamp
			--dataSet[6] = 2 -- Set scaleMode to 2 (Only Imports should update scales)
			dataSet[5] = e
			dataSet[6] = time() -- Timestamp
			dataSet[7] = 2 -- Set scaleMode to 2 (Only Imports should update scales)
			updated = true
			break
		end
	end

	-- Create new scale if we didn't find existing set
	if not updated then
		customScales[#customScales + 1] = {
			scaleName,
			classIndex,
			specID,
			t,
			e,
			time(), -- Timestamp
			scaleMode -- Set scaleMode either 1 (Created) or 2 (Imported)
		}
	end

	sort(customScales, _customSort)

	return updated -- Return info if we created new or updated old
end

local function _buildTree(t)
	local t = {}

	t[1] = {
		value = 1,
		text = U["ScalesList_CustomGroupName"],
		disabled = true,
		children = {}
	}
	t[2] = {
		value = 2,
		text = U["ScalesList_DefaultGroupName"],
		disabled = true,
		children = {}
	}

	playerClassID = playerClassID or select(3, UnitClass("player"))

	for _, dataSet in ipairs(customScales) do
		local classDisplayName, classTag, classID = GetClassInfo(dataSet[2])
		local specID, name, description, iconID, role, class = GetSpecializationInfoByID(dataSet[3])
		local c = _G.RAID_CLASS_COLORS[classTag]

		--if (dataSet) then
		if (dataSet) and ((cfg.onlyOwnClassCustoms and classID == playerClassID) or (not cfg.onlyOwnClassCustoms)) then -- Hide custom scales of other classes if enabled
			t[1].children[#t[1].children + 1] = {
				value = "C/"..dataSet[2].."/"..dataSet[3].."/"..dataSet[1],
				text = ("|c%s%s|r"):format(c.colorStr, dataSet[1]),
				icon = iconID
			}
		end
	end

	sort(t[1].children, _customSort)
	tinsert(t[1].children, 1, { -- Make sure Create New/Import is the first item on the list
		value = "AzeritePowerWeightsImport",
		text = U["ScalesList_CreateImportText"],
		icon = 134400
	})

	for _, dataSet in ipairs(n.defaultScalesData) do
		local classDisplayName, classTag, classID = GetClassInfo(dataSet[2])
		local specID, name, description, iconID, role, isRecommended, isAllowed = GetSpecializationInfoForClassID(classID, dataSet[3])
		local c = _G.RAID_CLASS_COLORS[classTag]

		local scaleName = (n.defaultNameTable[ dataSet[1] ] and n.defaultNameTable[ dataSet[1] ] ~= U["DefaultScaleName_Default"]) and classDisplayName .. " - " .. name .. " (" .. n.defaultNameTable[ dataSet[1] ] .. ")" or classDisplayName .. " - " .. name
		if (dataSet) and ((cfg.onlyOwnClassDefaults and classID == playerClassID) or (not cfg.onlyOwnClassDefaults)) then
			t[2].children[#t[2].children + 1] = {
				value = "D/"..dataSet[2].."/"..dataSet[3].."/"..dataSet[1],
				text = ("|c%s%s|r"):format(c.colorStr, scaleName),
				icon = iconID
			}
		end
	end

	return t
end

local function _SelectGroup(widget, callback, group)
	local dataGroup, scaleKey = strsplit("\001", group)

	if dataGroup and not scaleKey then
		scaleKey = dataGroup
	end

	local groupSet, classID, specNum, scaleName = strsplit("/", scaleKey, 4) -- Fixes the non-selectable scales if the scalename includes a slash-sign ('/') [Issue #46, https://www.curseforge.com/wow/addons/azeritepowerweights/issues/46]

	if scaleKey == "AzeritePowerWeightsImport" then -- Create New / Import
		n:CreateImportGroup(n.scalesScroll)
	else -- Scaleset
		classID = tonumber(classID)
		specNum = tonumber(specNum)
	
		if groupSet == "C" then -- Custom Scales

			for _, dataSet in ipairs(customScales) do
				if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specNum then
					n:CreateWeightEditorGroup(true, n.scalesScroll, dataSet, scaleKey, cfg.specScales[playerSpecID].scaleID == scaleKey, classID, specNum, nil) -- specNum is actually specID here, nil is mode

					break
				end
			end

		elseif groupSet == "D" then -- Default Scales

			for _, dataSet in ipairs(n.defaultScalesData) do
				if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specNum then
					local classDisplayName, classTag, classID = GetClassInfo(dataSet[2])
					local specID, name, description, iconID, role, isRecommended, isAllowed = GetSpecializationInfoForClassID(classID, dataSet[3])

					n:CreateWeightEditorGroup(false, n.scalesScroll, dataSet, scaleKey, cfg.specScales[playerSpecID].scaleID == scaleKey, classID, specID, nil) -- nil is mode

					break
				end
			end

		else -- ???
		end
	end

	delayedUpdate()
end

local function _enableScale(powerWeights, essenceWeights, scaleKey)
	wipe(scoreData)
	local scoreCount = 0
	for k, v in pairs(powerWeights) do
		scoreData[k] = v
		scoreCount = scoreCount + 1
	end
	traitStack.loading = scoreCount
	-- 8.2 Azerite Essences
	wipe(essenceScoreData)
	local essenceCount = 0
	for k, v in pairs(essenceWeights) do
		essenceScoreData[k] = v
		essenceCount = essenceCount + 1
	end
	essenceStack.loading = essenceCount

	local groupSet, _, _, scaleName = strsplit("/", scaleKey)
	n.guiContainer:SetStatusText(format(U["WeightEditor_CurrentScale"], groupSet == "D" and (n.defaultNameTable[scaleName] or scaleName) or scaleName))

	cfg.specScales[playerSpecID].scaleID = scaleKey
	cfg.specScales[playerSpecID].scaleName = scaleName
	n.treeGroup:SelectByValue(cfg.specScales[playerSpecID].scaleID)
end

local function _checkForNameCollisions(nameString, previousName, classID, specID)
	local collision = true
	local testName = nameString
	local c = 1
	while collision == true do
		collision = false
		for key, dataSet in ipairs(customScales) do
			if (dataSet) and dataSet[1] == testName and dataSet[2] == classID and dataSet[3] == specID then
				collision = true
				testName = ("%s (%d)"):format(nameString, c)
				c = c + 1

				if previousName and testName == previousName then -- Earlier name had (x) in it and we hit the same number, don't increase it
					collision = false
				end

				break
			end
		end
	end

	return testName
end

local function _exportScale(powerWeights, essenceWeights, scaleName, classID, specID) -- Create export string and show export popup
	local template = "( %s:%d:\"%s\":%d:%d:%s:%s )"
	local t, e = {}, {}
	local isHorde = UnitFactionGroup("player") == "Horde"
	for k, v in pairs(powerWeights) do
		if type(tonumber(v)) == "number" and tonumber(v) > 0 then
			if pvpPairs[tonumber(k)] then
				if isHorde and pvpPairs[tonumber(k)] > 0 then -- Horde player and Horde power
					t[#t + 1] = k.."="..v
				elseif not isHorde and pvpPairs[tonumber(k)] < 0 then -- Alliance player and Alliance power
					t[#t + 1] = k.."="..v
				end
			else
				t[#t + 1] = k.."="..v
			end
		end
	end
	sort(t)
	for k, v in pairs(essenceWeights) do
		e[#e + 1] = k.."="..(v[1] or 0).."/"..(v[2] or 0)
	end

	local exportString = format(template, "AzeritePowerWeights", importVersion, scaleName, classID, specID, #t > 0 and " "..strjoin(", ", unpack(t)) or "", #e > 0 and " "..strjoin(", ", unpack(e)) or "")

	--CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	n.CreatePopUp("Export", U["ExportPopup_Title"], format(U["ExportPopup_Desc"], NORMAL_FONT_COLOR_CODE .. scaleName .. FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE, FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE, FONT_COLOR_CODE_CLOSE), exportString)
end

local importStack = {}
local function _importScale(importMode) -- Show import popup and parse input
	local template = "^%s*%(%s*" .. "AzeritePowerWeights" .. "%s*:%s*(%d+)%s*:%s*\"([^\"]+)\"%s*:%s*(%d+)%s*:%s*(%d+)%s*:%s*(.+)%s*:%s*(.+)%s*%)%s*$"
	wipe(importStack)

	local callbackFunction = function(widget, callback, ...)
		local function _saveString(importString, version)
			importStack[#importStack + 1] = ("Version: %s"):format(tostring(version))
			importStack[#importStack + 1] = importString

			if version and version == 1 then
				template = "^%s*%(%s*" .. "AzeritePowerWeights" .. "%s*:%s*(%d+)%s*:%s*\"([^\"]+)\"%s*:%s*(%d+)%s*:%s*(%d+)%s*:%s*(.+)%s*%)%s*$"
			end
			local startPos, endPos, stringVersion, scaleName, classID, specID, powerWeights, essenceWeights = strfind(importString, template)

			importStack[#importStack + 1] = ("startPos: %s, endPos: %s, stringVersion: %s, scaleName: %s, classID: %s, specID: %s"):format(tostring(startPos), tostring(endPos), tostring(stringVersion), tostring(scaleName), tostring(classID), tostring(specID))
			importStack[#importStack + 1] = ("powerWeights: %s"):format(tostring(powerWeights))
			importStack[#importStack + 1] = ("essenceWeights: %s"):format(tostring(essenceWeights))

			stringVersion = tonumber(stringVersion) or 0
			scaleName = scaleName or U["ScaleName_Unnamed"]
			powerWeights = powerWeights or ""
			essenceWeights = essenceWeights or ""
			classID = tonumber(classID) or nil
			specID = tonumber(specID) or nil

			if stringVersion == 0 then -- Try to find string version if we didn't find it previously
				startPos, endPos, stringVersion = strfind(importString, "^%s*%(%s*" .. "AzeritePowerWeights" .. "%s*:%s*(%d+)%s*:.*%)%s*$")
				stringVersion = tonumber(stringVersion) or 0

				importStack[#importStack + 1] = ("Fixed stringVersion: %s"):format(tostring(stringVersion))
			end

			if (not cfg.importingCanUpdate) or (version and version > 0) then -- No updating for you, get collision free name
				scaleName = _checkForNameCollisions(scaleName, false, classID, specID)
			end

			if (version and stringVersion < version) or (not version and stringVersion < importVersion) then -- String version is old and not supported
				importStack[#importStack + 1] = ("String version is old: %s / %s / %s"):format(tostring(stringVersion), tostring(importVersion), tostring(version))
				if not version then
					importStack[#importStack + 1] = "-> First retry...\n"
					Print(U["ImportPopup_Error_OldStringRetry"])
					_saveString(importString, (importVersion - 1))
				elseif version > 1 then
					importStack[#importStack + 1] = "-> Still retrying...\n"
					_saveString(importString, (version - 1))
				else
					importStack[#importStack + 1] = "-> Too old or malformed, can't figure this out...\n> END"
					Print(U["ImportPopup_Error_OldStringVersion"])
				end
			elseif type(classID) ~= "number" or classID < 1 or type(specID) ~= "number" or specID < 1 then -- No class or no spec, this really shouldn't happen ever
				importStack[#importStack + 1] = ("Problem with classID %s or specID %s, bailing out...\n> END"):format(tostring(classID), tostring(specID))
				Print(U["ImportPopup_Error_MalformedString"])
			else -- Everything seems to be OK
				importStack[#importStack + 1] = "Everything seems to be OK"
				local result = insertCustomScalesData(scaleName, classID, specID, powerWeights, essenceWeights, 2) -- Set scaleMode 2 for Imported

				-- Rebuild Tree
				n.treeGroup.tree = _buildTree(n.treeGroup.tree)
				n.treeGroup:SelectByValue("C/"..classID.."/"..specID.."/"..scaleName)
				n.treeGroup:RefreshTree(true)

				if result then -- Updated old scale
					importStack[#importStack + 1] = "- Updated old scale.\n> END"
					Print(U["ImportPopup_UpdatedScale"], scaleName)
					-- Update the scores just incase if it is the scale actively in use
					_populateWeights()
					delayedUpdate()
				else -- Created new
					importStack[#importStack + 1] = "- Created new scale\n> END"
					Print(U["ImportPopup_CreatedNewScale"], scaleName)
				end
			end
		end

		local input = widget:GetUserData("importString") or ""

		if importMode then
			local t = { strsplit("\r\n", input) }
			if #t > 0 then
				for k, v in pairs(t) do
					if v then -- Let's make sure there is something
						_saveString(v)
					end
				end
			else
				Print(U["ImportPopup_Error_MalformedString"])
			end

		else
			_saveString(input)
		end

		widget.frame:GetParent().obj:Hide()
	end

	--CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	if importMode then -- Mass Import
		importStack[#importStack + 1] = "=== MassImport"
		n.CreatePopUp("MassImport", U["MassImportPopup_Title"], format(U["MassImportPopup_Desc"], NORMAL_FONT_COLOR_CODE, FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE .. _G.ACCEPT .. FONT_COLOR_CODE_CLOSE), "", callbackFunction)
	else -- Import
		importStack[#importStack + 1] = "=== Import"
	n.CreatePopUp("Import", U["ImportPopup_Title"], format(U["ImportPopup_Desc"], NORMAL_FONT_COLOR_CODE, FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE .. _G.ACCEPT .. FONT_COLOR_CODE_CLOSE), "", callbackFunction)
	end
end

local function _createScale() -- Show create popup and parse input
	local callbackFunction = function(widget, callback, ...)
		local classID = widget:GetUserData("classID")
		local specID = widget:GetUserData("specID")
		local nameString = widget:GetUserData("nameString")

		if not nameString or nameString == "" then
			nameString = U["ScaleName_Unnamed"]
		end
		if not classID then
			classID = 1 -- Warrior
			specID = 71 -- Arms
		end

		local scaleName = _checkForNameCollisions(nameString, false, classID, specID)

		if scaleName then
			local result = insertCustomScalesData(scaleName, classID, specID, nil, nil, 1) -- Set scaleMode 1 for Created

			-- Rebuild Tree
			n.treeGroup.tree = _buildTree(n.treeGroup.tree)
			n.treeGroup:SelectByValue("C/"..classID.."/"..specID.."/"..scaleName)
			n.treeGroup:RefreshTree(true)


			if result then -- Updated old instead of creating new, which should never happen
				Print(U["CreatePopup_Error_UnknownError, scaleName"])
			else -- Expected result
				Print(U["CreatePopup_Error_CreatedNewScale, scaleName"])
			end
		end


		widget.frame:GetParent().obj:Hide()
	end

	--CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	n.CreatePopUp("Create", U["CreatePopup_Title"], format(U["CreatePopup_Desc"], NORMAL_FONT_COLOR_CODE .. _G.ACCEPT .. FONT_COLOR_CODE_CLOSE), "", callbackFunction)
end

local function _renameScale(scaleName, classID, specID, isCurrentScales) -- Show rename popup and check for name collisions
	local callbackFunction = function(widget, callback, ...)
		local renameString = widget:GetUserData("renameString")

		if not renameString or renameString == "" then
			renameString = U["ScaleName_Unnamed"]
		end

		if renameString ~= scaleName then -- Check if name actually changed
			local finalName = _checkForNameCollisions(renameString, scaleName, classID, specID)

			local scaleWeights, essenceWeights
			for key, dataSet in ipairs(customScales) do
				if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specID then

					dataSet[1] = finalName
					scaleWeights = dataSet[4]
					-- 8.2 Azerite Essences
					essenceWeights = dataSet[5]

					break
				end
			end

			Print(U["RenamePopup_RenamedScale"], scaleName, finalName)

			n.treeGroup.tree = _buildTree(n.treeGroup.tree)
			n.treeGroup:SelectByValue("C/"..classID.."/"..specID.."/"..finalName)
			n.treeGroup:RefreshTree(true)

			if isCurrentScales and scaleWeights then
				_enableScale(scaleWeights, essenceWeights, "C/"..classID.."/"..specID.."/"..finalName)
			end

			-- Check if we have to rename scaleKeys for other tooltips
			for realmName, realmData in pairs(db.char) do
				for charName, charData in pairs(realmData) do
					if charData.tooltipScales and #charData.tooltipScales > 0 then
						for i, tooltipData in ipairs(charData.tooltipScales) do
							if tooltipData.scaleName == scaleName and tooltipData.scaleID == "C/"..classID.."/"..specID.."/"..scaleName then -- Found character with same scale, update scaleKey
								tooltipData.scaleID = "C/"..classID.."/"..specID.."/"..finalName
								tooltipData.scaleName = finalName
							end
						end
					end
				end
			end

			-- Check if we have to rename scaleKeys for other characters using same scale
			for realmName, realmData in pairs(db.char) do
				for charName, charData in pairs(realmData) do
					for spec, specData in pairs(charData.specScales) do
						if spec == specID and specData.scaleName == scaleName and specData.scaleID == "C/"..classID.."/"..specID.."/"..scaleName then -- Found character with same scale, update scaleKey
							specData.scaleID = "C/"..classID.."/"..specID.."/"..finalName
							specData.scaleName = finalName
						end
					end
				end
			end
		end

		widget.frame:GetParent().obj:Hide()
	end

	--CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	n.CreatePopUp("Rename", U["RenamePopup_Title"], format(U["RenamePopup_Desc"], NORMAL_FONT_COLOR_CODE .. scaleName .. FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE .. _G.ACCEPT .. FONT_COLOR_CODE_CLOSE), scaleName, callbackFunction)
end

local function _deleteScale(scaleName, classID, specID, isCurrentScales) -- Show delete popup and remove scale
	local callbackFunction = function(widget, callback, ...)
		local index
		-- Find where in the table scaleKey to be removed is
		for key, dataSet in ipairs(customScales) do
			if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specID then
				index = key
				break
			end
		end

		-- Remove without breaking the indexing
		tremove(customScales, index)
		Print(U["DeletePopup_DeletedScale"], scaleName)

		n.treeGroup.tree = _buildTree(n.treeGroup.tree)
		n.treeGroup:SelectByValue("AzeritePowerWeightsImport")
		n.treeGroup:RefreshTree(true)

		-- If removed scaleKey was in use, revert back to default option
		if isCurrentScales then
			local specNum = GetSpecialization()
			playerClassID = playerClassID or select(3, UnitClass("player"))
			local scaleKey = n.GetDefaultScaleSet(playerClassID, specNum)
			local _, _, _, defaultScaleName = strsplit("/", scaleKey)
			
			for _, dataSet in ipairs(n.defaultScalesData) do
				if (dataSet) and dataSet[1] == defaultScaleName and dataSet[2] == playerClassID and dataSet[3] == specNum then
					_enableScale(dataSet[4], dataSet[5], scaleKey)

					break
				end
			end

			Print(U["DeletePopup_DeletedDefaultScale"])
		end

		-- Check if this scale was in tooltips
		for realmName, realmData in pairs(db.char) do
			for charName, charData in pairs(realmData) do
				if charData.tooltipScales and #charData.tooltipScales > 0 then
					for i = #charData.tooltipScales, 1 , -1 do -- Go backwards to prevent holes and errors
						local tooltipData = charData.tooltipScales[i]
						if tooltipData.scaleName == scaleName and tooltipData.scaleID == "C/"..classID.."/"..specID.."/"..scaleName then -- Found character with same scale, remove scaleKey
							tremove(charData.tooltipScales, i)
						end
					end
				end
			end
		end

		-- Check if someone used this scale and remove it so they can revert back to default on their next login
		for realmName, realmData in pairs(db.char) do
			for charName, charData in pairs(realmData) do
				for spec, specData in pairs(charData.specScales) do
					if spec == specID and specData.scaleName == scaleName and specData.scaleID == "C/"..classID.."/"..specID.."/"..scaleName then -- Found character with same scale, remove scaleKey
						charData.specScales[spec] = nil
					end
				end
			end
		end

		widget.frame:GetParent().obj:Hide()
	end

	--CreatePopUp(mode, titleText, descriptionText, editboxText, callbackFunction)
	n.CreatePopUp("Delete", U["DeletePopup_Title"], format(U["DeletePopup_Desc"], NORMAL_FONT_COLOR_CODE .. scaleName .. FONT_COLOR_CODE_CLOSE, NORMAL_FONT_COLOR_CODE .. _G.ACCEPT .. FONT_COLOR_CODE_CLOSE), U["DeletePopup_Warning"], callbackFunction)
end

function n:CreateImportGroup(container)
	container:ReleaseChildren()

	local version = AceGUI:Create("Label")
	version:SetText(" 8.3.10")
	version:SetJustifyH("RIGHT")
	version:SetFullWidth(true)
	container:AddChild(version)

	local title = AceGUI:Create("Heading")
	title:SetText(U["ScalesList_CreateImportText"])
	title:SetFullWidth(true)
	container:AddChild(title)

	local newButton = AceGUI:Create("Button")
	newButton:SetText(U["WeightEditor_CreateNewText"])
	newButton:SetFullWidth(true)
	newButton:SetCallback("OnClick", function()
		-- Call _createScale
		_createScale()
	end)
	container:AddChild(newButton)

	local importButton = AceGUI:Create("Button")
	importButton:SetText(U["WeightEditor_ImportText"])
	importButton:SetFullWidth(true)
	importButton:SetCallback("OnClick", function()
		-- Call _importScale
		_importScale()
	end)
	container:AddChild(importButton)

	local massImportButton = AceGUI:Create("Button")
	massImportButton:SetText(U["WeightEditor_MassImportText"])
	massImportButton:SetFullWidth(true)
	massImportButton:SetCallback("OnClick", function()
		-- Call _importScale
		_importScale(true)
	end)
	container:AddChild(massImportButton)

	local line = AceGUI:Create("Heading")
	line:SetFullWidth(true)
	container:AddChild(line)

	lastOpenScale = "AzeritePowerWeightsImport"
end

function n:CreateWeightEditorGroup(isCustomScale, container, dataSet, scaleKey, isCurrentScales, classID, specID, mode)
	local classDisplayName = GetClassInfo(dataSet[2])
	local _, specName = GetSpecializationInfoForClassID(classID, dataSet[3])
	local titleText = isCustomScale and dataSet[1] or ("%s - %s (%s)"):format(classDisplayName, specName, dataSet[1])
	local powerWeights = dataSet[4]
	-- 8.2 Azerite Essences
	local essenceWeights = dataSet[5]
	local currentMode = mode or ((_G.AzeriteEssenceUI and _G.AzeriteEssenceUI:IsShown()) and 1 or 0)

	container:ReleaseChildren()

	local title = AceGUI:Create("Heading")
	title:SetText(titleText)
	title:SetFullWidth(true)
	container:AddChild(title)

	local useButton = AceGUI:Create("Button")
	if isCurrentScales then
		useButton:SetText(GRAY_FONT_COLOR_CODE .. U["WeightEditor_EnableScaleText"] .. FONT_COLOR_CODE_CLOSE)
	else
		useButton:SetText(U["WeightEditor_EnableScaleText"])
	end
	useButton:SetRelativeWidth(.5)
	useButton:SetDisabled(isCurrentScales)
	useButton:SetCallback("OnClick", function()
		-- Call _enableScale
		_enableScale(powerWeights, essenceWeights, scaleKey)
	end)
	container:AddChild(useButton)

	local exportButton = AceGUI:Create("Button")
	exportButton:SetText(U["WeightEditor_ExportText"])
	exportButton:SetRelativeWidth(.5)
	exportButton:SetCallback("OnClick", function()
		-- Call _exportScale
		_exportScale(powerWeights, essenceWeights, titleText, classID, specID)
	end)
	container:AddChild(exportButton)

	if isCustomScale then
		local renameButton = AceGUI:Create("Button")
		renameButton:SetText(U["WeightEditor_RenameText"])
		renameButton:SetRelativeWidth(.5)
		renameButton:SetCallback("OnClick", function()
			-- Call _renameScale
			_renameScale(titleText, classID, specID, isCurrentScales)
		end)
		container:AddChild(renameButton)

		local deleteButton = AceGUI:Create("Button")
		deleteButton:SetText(U["WeightEditor_DeleteText"])
		deleteButton:SetRelativeWidth(.5)
		deleteButton:SetCallback("OnClick", function()
			-- Call _deleteScale
			_deleteScale(titleText, classID, specID, isCurrentScales)
		end)
		container:AddChild(deleteButton)
	end

	-- Tooltip start
	local tooltipCheckbox = AceGUI:Create("CheckBox")
	tooltipCheckbox:SetLabel(U["WeightEditor_TooltipText"])
	--tooltipCheckbox:SetFullWidth(true)
	tooltipCheckbox:SetRelativeWidth(.5)
	tooltipCheckbox:SetValue(false)
	tooltipCheckbox:SetCallback("OnValueChanged", function(widget, callback, checked)
		if checked == true then
			local groupSet, _, _, thisScaleName = strsplit("/", scaleKey)
			cfg.tooltipScales[#cfg.tooltipScales + 1] = {
				scaleID = scaleKey,
				--scaleName = thisScaleName
				scaleName = groupSet == "D" and (n.defaultNameTable[thisScaleName] or thisScaleName) or thisScaleName
			}
		else
			if #cfg.tooltipScales > 0 then
				for i = #cfg.tooltipScales, 1, -1 do -- Just to make sure if for any erroneous reason, there are multiple copies of same scale, they all get removed.
					local v = cfg.tooltipScales[i]
					if v.scaleID == scaleKey then
						tremove(cfg.tooltipScales, i)
					end
				end
			end
		end
		widget:SetValue(checked)
	end)
	container:AddChild(tooltipCheckbox)

	for _, v in ipairs(cfg.tooltipScales) do
		if v.scaleID == scaleKey then
			tooltipCheckbox:SetValue(true)
			break -- No need to iterate more
		end
	end
	-- Tooltip end

	local modeButton = AceGUI:Create("Button")
	modeButton:SetText(currentMode == 1 and U["WeightEditor_ModeToTraits"] or U["WeightEditor_ModeToEssences"])
	modeButton:SetRelativeWidth(.5)
	modeButton:SetCallback("OnClick", function()
		-- Change Mode
		n:CreateWeightEditorGroup(isCustomScale, container, dataSet, scaleKey, isCurrentScales, classID, specID, currentMode == 1 and 0 or 1)
	end)
	container:AddChild(modeButton)

	-- Timestamp start
	local timestampText = AceGUI:Create("Label")
	container:AddChild(timestampText)

	local function _updateTimestamp()
		-- dataSet[5] == timestamp
		-- dataSet[6] = scaleMode: 0 = Default/Updated, 1 = Created, 2 = Imported
		-- 8.2 Azerite Essences
		-- timestamp 5->6, scaleMode 6->7
		if dataSet[7] == 1 then
			timestampText:SetText(format(U["WeightEditor_TimestampText_Created"], date("%Y.%m.%d", (dataSet[6] or 0))))
		elseif dataSet[7] == 2 then
			timestampText:SetText(format(U["WeightEditor_TimestampText_Imported"], date("%Y.%m.%d", (dataSet[6] or 0))))
		else -- dataSet[6] 0, Default or Updated
			timestampText:SetText(format(U["WeightEditor_TimestampText_Updated"], date("%Y.%m.%d", (dataSet[6] or 0))))
		end
	end

	_updateTimestamp()
	-- Timestamp end

	local spacer = AceGUI:Create("Label")
	spacer:SetText(" \n ")
	spacer:SetFullWidth(true)
	container:AddChild(spacer)

	local isHorde = UnitFactionGroup("player") == "Horde"
	local roleBits = 0x0
	local BIT_DAMAGER = 0x1
	local BIT_TANK = 0x2
	local BIT_HEALER = 0x4
	for i = 1, GetNumSpecializationsForClassID(classID) do
		local spec, _, _, _, role = GetSpecializationInfoForClassID(classID, i)
		if spec and ((cfg.rolePowersNoOffRolePowers and spec == specID) or (not cfg.rolePowersNoOffRolePowers)) then -- Check if only powers suitable for the spec
			if role == "DAMAGER" then
				roleBits = bit.bor(roleBits, BIT_DAMAGER)
			elseif role == "TANK" then
				roleBits = bit.bor(roleBits, BIT_TANK)
			elseif role == "HEALER" then
				roleBits = bit.bor(roleBits, BIT_HEALER)
			end
		end
	end

	local e = {}
	local c = 1

	local function _saveValue(widget, callback, text)
		local value = tonumber(text) or 0
		value = value > reallyBigNumber and reallyBigNumber or value
		local pointer = widget:GetUserData("dataPointer")
		local pairPointer = widget:GetUserData("pairPointer")
		-- Save to DB
		powerWeights[pointer] = value
		widget:SetText(text == "" and "" or (value and value or ""))
		AceGUI:ClearFocus()
		if pairPointer then
			powerWeights[pairPointer] = value
		end
		if isCurrentScales then
			-- Update visible numbers
			scoreData[pointer] = value
			delayedUpdate()
		end

		-- Update scaleMode and timestamp
		-- 8.2 Azerite Essences
		--dataSet[5] = time()
		--dataSet[6] = 0
		dataSet[6] = time()
		dataSet[7] = 0
		_updateTimestamp()
	end

	local function _saveEssenceValue(widget, callback, text)
		local value = tonumber(text) or 0
		value = value > reallyBigNumber and reallyBigNumber or value
		local pointer = widget:GetUserData("essencePointer")
		local major = widget:GetUserData("essenceMajor")
		-- Save to DB
		essenceWeights[pointer] = essenceWeights[pointer] or {}
		if major then
			essenceWeights[pointer][1] = value
		else
			essenceWeights[pointer][2] = value
		end
		widget:SetText(text == "" and "" or (value and value or ""))
		AceGUI:ClearFocus()

		if isCurrentScales then
			-- Update visible numbers
			essenceScoreData[pointer] = essenceScoreData[pointer] or {}
			if major then
				essenceScoreData[pointer][1] = value
			else
				essenceScoreData[pointer][2] = value
			end
			delayedUpdate()
		end

		-- Update scaleMode and timestamp
		dataSet[6] = time()
		dataSet[7] = 0
		_updateTimestamp()
	end

	if currentMode == 0 then -- _G.AzeriteEmpoweredItemUI and _G.AzeriteEmpoweredItemUI:IsShown() or both UIs hidden
		-- Class Powers title
		local classTitle = AceGUI:Create("Heading")
		classTitle:SetText(U["PowersTitles_Class"])
		classTitle:SetFullWidth(true)
		container:AddChild(classTitle)

		-- Center Power
		local cname = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(n.sourceData.center.azeritePowerID).spellID)
		e[c] = AceGUI:Create("EditBox")
		e[c]:SetLabel(format("  |T%d:18|t %s", n.sourceData.center.icon, cname or n.sourceData.center.name))
		e[c]:SetText(powerWeights[n.sourceData.center.azeritePowerID] or "")
		e[c]:SetRelativeWidth(.5)
		if isCustomScale then
			e[c]:SetUserData("dataPointer", n.sourceData.center.azeritePowerID)
			e[c]:SetCallback("OnEnterPressed", _saveValue)
		else
			e[c]:SetDisabled(true)
		end
		container:AddChild(e[c])
		c = c + 1

		-- Class Powers
		for i, powerData in ipairs(n.sourceData.class[classID][specID]) do
			local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
			e[c] = AceGUI:Create("EditBox")
			e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
			e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
			e[c]:SetRelativeWidth(.5)
			if isCustomScale then
				e[c]:SetUserData("dataPointer", n.sourceData.class[classID][specID][i].azeritePowerID)
				e[c]:SetCallback("OnEnterPressed", _saveValue)
			else
				e[c]:SetDisabled(true)
			end
			container:AddChild(e[c])
			c = c + 1
		end

		if cfg.defensivePowers then
			local defTitle = AceGUI:Create("Heading")
			defTitle:SetText(U["PowersTitles_Defensive"])
			defTitle:SetFullWidth(true)
			container:AddChild(defTitle)

			-- Defensive Powers
			for i, powerData in ipairs(n.sourceData.defensive[classID]) do
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.defensive[classID][i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
			for i, powerData in ipairs(n.sourceData.defensive.common) do
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.defensive.common[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end

		if cfg.rolePowers then
			local roleTitle = AceGUI:Create("Heading")
			roleTitle:SetText(U["PowersTitles_Role"])
			roleTitle:SetFullWidth(true)
			container:AddChild(roleTitle)

			-- Role Powers
			for i, powerData in ipairs(n.sourceData.role.common) do
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0:3:::64:16:16:64:0:16|t" -- Tank, DPS & Healer
				e[c]:SetLabel(format("  %s |T%d:18|t %s", roleIcon, powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.role.common[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end

			-- Non-Healer Powers
			if bit.band(roleBits, bit.bor(BIT_DAMAGER, BIT_TANK)) ~= 0 then
				for i, powerData in ipairs(n.sourceData.role.nonhealer) do
					local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
					e[c] = AceGUI:Create("EditBox")
					local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0:2:::64:16:16:48:0:16|t" -- Tank & DPS
					e[c]:SetLabel(format("  %s |T%d:18|t %s", roleIcon, powerData.icon, name or powerData.name))
					e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
					e[c]:SetRelativeWidth(.5)
					if isCustomScale then
						e[c]:SetUserData("dataPointer", n.sourceData.role.nonhealer[i].azeritePowerID)
						e[c]:SetCallback("OnEnterPressed", _saveValue)
					else
						e[c]:SetDisabled(true)
					end
					container:AddChild(e[c])
					c = c + 1
				end
			end
			-- Tank Powers
			if bit.band(roleBits, BIT_TANK) ~= 0 then
				for i, powerData in ipairs(n.sourceData.role.tank) do
					local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
					e[c] = AceGUI:Create("EditBox")
					local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0::::64:16:32:48:0:16|t" -- Tank
					e[c]:SetLabel(format("  %s |T%d:18|t %s", roleIcon, powerData.icon, name or powerData.name))
					e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
					e[c]:SetRelativeWidth(.5)
					if isCustomScale then
						e[c]:SetUserData("dataPointer", n.sourceData.role.tank[i].azeritePowerID)
						e[c]:SetCallback("OnEnterPressed", _saveValue)
					else
						e[c]:SetDisabled(true)
					end
					container:AddChild(e[c])
					c = c + 1
				end
			end
			-- Healer Powers
			if bit.band(roleBits, BIT_HEALER) ~= 0 then
				for i, powerData in ipairs(n.sourceData.role.healer) do
					local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
					e[c] = AceGUI:Create("EditBox")
					local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0::::64:16:48:64:0:16|t" -- Healer
					e[c]:SetLabel(format("  %s |T%d:18|t %s", roleIcon, powerData.icon, name or powerData.name))
					e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
					e[c]:SetRelativeWidth(.5)
					if isCustomScale then
						e[c]:SetUserData("dataPointer", n.sourceData.role.healer[i].azeritePowerID)
						e[c]:SetCallback("OnEnterPressed", _saveValue)
					else
						e[c]:SetDisabled(true)
					end
					container:AddChild(e[c])
					c = c + 1
				end
			end
		end

		if cfg.zonePowers then
			local zoneTitle = AceGUI:Create("Heading")
			zoneTitle:SetText(U["PowersTitles_Zone"])
			zoneTitle:SetFullWidth(true)
			container:AddChild(zoneTitle)

			-- Raid Powers
			for i, powerData in ipairs(n.sourceData.raid) do
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t*%s*", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.raid[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
			-- Zone Powers
			-- 8.0:
			local startPoint = 1
			local endPoint = 15
			for i = startPoint, endPoint do
				local powerData = n.sourceData.zone[i]
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.zone[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
			-- Different Zone traits for Alliance and Horde in 8.1
			local tidesStart = isHorde and 18 or 16
			local tidesEnd = isHorde and 19 or 17
			for i = tidesStart, tidesEnd do
				local powerData = n.sourceData.zone[i]
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.zone[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
			-- 8.2 ->
			for i = 20, #n.sourceData.zone do
				local powerData = n.sourceData.zone[i]
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.zone[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end

		if cfg.professionPowers then
			local professionTitle = AceGUI:Create("Heading")
			professionTitle:SetText(U["PowersTitles_Profession"])
			professionTitle:SetFullWidth(true)
			container:AddChild(professionTitle)

			-- Profession Powers
			for i, powerData in ipairs(n.sourceData.profession) do
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.profession[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end

		if cfg.pvpPowers then
			local pvpTitle = AceGUI:Create("Heading")
			pvpTitle:SetText(U["PowersTitles_PvP"])
			pvpTitle:SetFullWidth(true)
			container:AddChild(pvpTitle)

			-- PvP Powers
			-- 8.0:
			local startPoint = isHorde and 1 or 7
			local endPoint = isHorde and 6 or 12
			for i = startPoint, endPoint do
				local powerData = n.sourceData.pvp[i]
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.pvp[i].azeritePowerID)
					e[c]:SetUserData("pairPointer", n.sourceData.pvp[i].pair)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
			-- 8.1:
			for i = 13, #n.sourceData.pvp do
				local powerData = n.sourceData.pvp[i]
				local name = GetSpellInfo(C_AzeriteEmpoweredItem.GetPowerInfo(powerData.azeritePowerID).spellID)
				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  |T%d:18|t %s", powerData.icon, name or powerData.name))
				e[c]:SetText(powerWeights[powerData.azeritePowerID] or "")
				e[c]:SetRelativeWidth(.5)
				if isCustomScale then
					e[c]:SetUserData("dataPointer", n.sourceData.pvp[i].azeritePowerID)
					e[c]:SetCallback("OnEnterPressed", _saveValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end
		traitStack.editor = #e or 0
	elseif currentMode == 1 then -- _G.AzeriteEssenceUI and _G.AzeriteEssenceUI:IsShown()
		local topLine = AceGUI:Create("Heading")
		topLine:SetFullWidth(true)
		container:AddChild(topLine)

		for i, essenceData in ipairs(n.essenceData.common) do
			local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0:3:::64:16:16:64:0:16|t" -- Tank, DPS & Healer
			local essenceTitle = AceGUI:Create("Heading")
			essenceTitle:SetText(format("|T%d:18|t %s", essenceData.icon, essenceData.name))
			essenceTitle:SetRelativeWidth(.5)
			container:AddChild(essenceTitle)

			e[c] = AceGUI:Create("EditBox")
			e[c]:SetLabel(format("  %s %s", roleIcon, U["WeightEditor_Major"]))
			e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][1] or "")
			e[c]:SetRelativeWidth(.25)
			if isCustomScale then
				e[c]:SetUserData("essencePointer", n.essenceData.common[i].essenceID)
				e[c]:SetUserData("essenceMajor", true)
				e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
			else
				e[c]:SetDisabled(true)
			end
			container:AddChild(e[c])
			c = c + 1

			e[c] = AceGUI:Create("EditBox")
			e[c]:SetLabel(format("  %s %s", roleIcon, U["WeightEditor_Minor"]))
			e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][2] or "")
			e[c]:SetRelativeWidth(.25)
			if isCustomScale then
				e[c]:SetUserData("essencePointer", n.essenceData.common[i].essenceID)
				e[c]:SetUserData("essenceMajor", false)
				e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
			else
				e[c]:SetDisabled(true)
			end
			container:AddChild(e[c])
			c = c + 1
		end

		-- Tank Powers
		if bit.band(roleBits, BIT_TANK) ~= 0 then
			for i, essenceData in ipairs(n.essenceData.tank) do
				local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0::::64:16:32:48:0:16|t" -- Tank
				local essenceTitle = AceGUI:Create("Heading")
				essenceTitle:SetText(format("|T%d:18|t %s", essenceData.icon, essenceData.name))
				essenceTitle:SetRelativeWidth(.5)
				container:AddChild(essenceTitle)

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, U["WeightEditor_Major"]))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][1] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.tank[i].essenceID)
					e[c]:SetUserData("essenceMajor", true)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, U["WeightEditor_Minor"]))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][2] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.tank[i].essenceID)
					e[c]:SetUserData("essenceMajor", false)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end
		-- Healer Powers
		if bit.band(roleBits, BIT_HEALER) ~= 0 then
			for i, essenceData in ipairs(n.essenceData.healer) do
				local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0::::64:16:48:64:0:16|t" -- Healer
				local essenceTitle = AceGUI:Create("Heading")
				essenceTitle:SetText(format("|T%d:18|t %s", essenceData.icon, essenceData.name))
				essenceTitle:SetRelativeWidth(.5)
				container:AddChild(essenceTitle)

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, U["WeightEditor_Major"]))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][1] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.healer[i].essenceID)
					e[c]:SetUserData("essenceMajor", true)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, U["WeightEditor_Minor"]))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][2] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.healer[i].essenceID)
					e[c]:SetUserData("essenceMajor", false)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end
		-- DPS Powers
		if bit.band(roleBits, BIT_DAMAGER) ~= 0 then
			for i, essenceData in ipairs(n.essenceData.damager) do
				local roleIcon = "|TInterface\\LFGFrame\\LFGRole:0::::64:16:16:32:0:16|t" -- Damager
				local essenceTitle = AceGUI:Create("Heading")
				essenceTitle:SetText(format("|T%d:18|t %s", essenceData.icon, essenceData.name))
				essenceTitle:SetRelativeWidth(.5)
				container:AddChild(essenceTitle)

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, U["WeightEditor_Major"]))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][1] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.damager[i].essenceID)
					e[c]:SetUserData("essenceMajor", true)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1

				e[c] = AceGUI:Create("EditBox")
				e[c]:SetLabel(format("  %s %s", roleIcon, U["WeightEditor_Minor"]))
				e[c]:SetText(essenceWeights[essenceData.essenceID] and essenceWeights[essenceData.essenceID][2] or "")
				e[c]:SetRelativeWidth(.25)
				if isCustomScale then
					e[c]:SetUserData("essencePointer", n.essenceData.damager[i].essenceID)
					e[c]:SetUserData("essenceMajor", false)
					e[c]:SetCallback("OnEnterPressed", _saveEssenceValue)
				else
					e[c]:SetDisabled(true)
				end
				container:AddChild(e[c])
				c = c + 1
			end
		end
		essenceStack.editor = #e or 0
	end
	
	local line = AceGUI:Create("Heading")
	line:SetFullWidth(true)
	container:AddChild(line)

	lastOpenScale = scaleKey
end

local function _toggleEditorUI(widget, handler, button, down)
	if not n.guiContainer then return end

	n.guiContainer:ClearAllPoints()
	--if _G.AzeriteEmpoweredItemUI and _G.AzeriteEmpoweredItemUI:IsShown() then
	if widget == n.TenableButton then
		n.guiContainer:SetPoint("TOPLEFT", _G.AzeriteEmpoweredItemUI, "TOPRIGHT", 10, 0)
		n.guiContainer:SetPoint("BOTTOMLEFT", _G.AzeriteEmpoweredItemUI, "BOTTOMRIGHT", 10, 0)
	--elseif _G.AzeriteEssenceUI and _G.AzeriteEssenceUI:IsShown() then
	elseif widget == n.EenableButton then
		n.guiContainer:SetPoint("TOPLEFT", _G.AzeriteEssenceUI, "TOPRIGHT", 10, 0)
		n.guiContainer:SetPoint("BOTTOMLEFT", _G.AzeriteEssenceUI, "BOTTOMRIGHT", 10, 0)
	else
		n.guiContainer:SetPoint("CENTER", _G.UIParent)
	end

	if n.guiContainer:IsShown() then
		n.guiContainer:Hide()
	else
		n.guiContainer:Show()
	end
end

-- Hook and Init functions
local function _setupStringAndEnableButton() -- Move string and enableButton between AzeriteEmpoweredItemUI and AzeriteEssenceUI
	C_Timer.After(0, function() -- Fire on next frame instead of current frame
		if cfg.enableTraits and _G.AzeriteEmpoweredItemUI and _G.AzeriteEmpoweredItemUI:IsShown() then
			if not n.Tstring then
				local s = AcquireString(_G.AzeriteEmpoweredItemUI, "")

				local scale = _G.AzeriteEmpoweredItemUI:GetEffectiveScale() or 1
				local fontName, fontHeight, fontFlags = s:GetFont()
				s:SetFont(fontName, fontHeight * scale, "")

				s:SetJustifyH("LEFT")
				s:SetJustifyV("TOP")
				n.Tstring = s
			end

			if _G.AzeriteEmpoweredItemUIPortrait:IsShown() then -- Default UI etc. who show Portrait
				n.Tstring:SetPoint("TOPLEFT", _G.AzeriteEmpoweredItemUI.ClipFrame.BackgroundFrame, 10, -50)
			else -- ElvUI etc. who hides Portrait
				n.Tstring:SetPoint("TOPLEFT", _G.AzeriteEmpoweredItemUI.ClipFrame.BackgroundFrame, 10, -10)
			end
			n.Tstring:Show()

			n.TenableButton:SetPoint("BOTTOMLEFT", _G.AzeriteEmpoweredItemUI, "BOTTOMLEFT", 10, 10)
			n.TenableButton.frame:SetParent(_G.AzeriteEmpoweredItemUI.ClipFrame.BackgroundFrame) -- Fix enableButton hiding behind AzeriteEmpoweredItemUI elements with ElvUI if the AzeriteUI skinning is disabled.
			n.TenableButton.frame:Show()
		else
			if n.Tstring then
				n.Tstring:Hide()
			end
			n.TenableButton.frame:Hide()
		end
		
		if cfg.enableEssences and _G.AzeriteEssenceUI and _G.AzeriteEssenceUI:IsShown() then
			if not n.Estring then
				local s = AcquireString(_G.AzeriteEssenceUI, "")

				local scale = _G.AzeriteEssenceUI:GetEffectiveScale() or 1
				local fontName, fontHeight, fontFlags = s:GetFont()
				s:SetFont(fontName, fontHeight * scale, "")

				s:SetJustifyH("LEFT")
				s:SetJustifyV("TOP")
				n.Estring = s
			end

			if ElvUI and ElvUI[3] and ElvUI[3].skins and ElvUI[3].skins.blizzard and ElvUI[3].skins.blizzard.AzeriteEssence then -- ElvUI etc. who hides Portrait
				n.Estring:SetPoint("TOPLEFT", _G.AzeriteEssenceUI.LeftInset, 10, -10)
			else -- Default UI etc. who show Portrait
				n.Estring:SetPoint("TOPLEFT", _G.AzeriteEssenceUI.LeftInset, 10, -50)
			end
			n.Estring:Show()

			n.EenableButton:SetPoint("BOTTOMLEFT", _G.AzeriteEssenceUI, "BOTTOMLEFT", 10, 10)
			n.EenableButton.frame:SetParent(_G.AzeriteEssenceUI.LeftInset)
			n.EenableButton.frame:Show()
		else
			if n.Estring then
				n.Estring:Hide()
			end
			n.EenableButton.frame:Hide()

			--return
		end
	end)
end

function f:HookAzeriteUI() -- Set Parents and Anchors
	if not playerSpecID then return end -- No playerSpecID yet, return
	self:InitUI()

	_setupStringAndEnableButton()

	_G.AzeriteEmpoweredItemUI:HookScript("OnHide", function() -- Hide strings on frame hide
		while #activeTStrings > 0 do
			local s = tremove(activeTStrings)
			ReleaseString(s)
		end

		if n.guiContainer then
			n.scalesScroll:ReleaseChildren()
			lastOpenScale = nil
			f:RefreshConfig()

			n.guiContainer:Hide()
			if n.Tstring then
				n.Tstring:Hide()
			end
			n.TenableButton.frame:Hide()
		end
	end)
end

function f:HookAzeriteEssenceUI() -- Set Parents and Anchors for the 8.2 AzeriteEssenceUI
	if not playerSpecID then return end -- No playerSpecID yet, return
	self:InitUI()

	_setupStringAndEnableButton()

	_G.AzeriteEssenceUI:HookScript("OnHide", function() -- Hide strings on frame hide
		while #activeEStrings > 0 do
			local s = tremove(activeEStrings)
			ReleaseString(s)
		end

		if n.guiContainer then
			n.scalesScroll:ReleaseChildren()
			lastOpenScale = nil
			f:RefreshConfig()

			n.guiContainer:Hide()
			if n.Estring then
				n.Estring:Hide()
			end
			n.EenableButton.frame:Hide()
		end
	end)
end

local initDone
function f:InitUI() -- Build UI and set up some initial data
	if initDone then return end
	initDone = true


	-- Enable Buttons
	local TenableButton = AceGUI:Create("Button")
	--enableButton:SetPoint("BOTTOMLEFT", _G.AzeriteEmpoweredItemUI, "BOTTOMLEFT", 10, 10)
	TenableButton:SetText("AzeritePowerWeights")
	TenableButton:SetAutoWidth(true)
	TenableButton:SetCallback("OnClick", _toggleEditorUI)
	n.TenableButton = TenableButton

	local EenableButton = AceGUI:Create("Button")
	EenableButton:SetText("AzeritePowerWeights")
	EenableButton:SetAutoWidth(true)
	EenableButton:SetCallback("OnClick", _toggleEditorUI)
	n.EenableButton = EenableButton

	-- Editor GUI
	n.guiContainer = n.CreateUI()
	--n.guiContainer:SetPoint("TOPLEFT", _G.AzeriteEmpoweredItemUI, "TOPRIGHT", 10, 0)
	--n.guiContainer:SetPoint("BOTTOMLEFT", _G.AzeriteEmpoweredItemUI, "BOTTOMRIGHT", 10, 0)

	-- TreeGroup Hacks for QoL
	n.treeGroup:SetCallback("OnGroupSelected", _SelectGroup)
	n.treeGroup.tree = _buildTree(n.treeGroup.tree)
	local statusTable = {}
	for i = 1, #n.treeGroup.tree do
		statusTable[#statusTable + 1] = true
	end
	n.treeGroup:SetStatusTable({
		groups = statusTable,
		treesizable = false,
		selected = ("%d\001%s"):format(1, "AzeritePowerWeightsImport")
	}) -- Expand groups

	-- Content Area
	n:CreateImportGroup(n.scalesScroll)

	-- Check if we have spec
	if not (playerSpecID and cfg and cfg.specScales[playerSpecID] and cfg.specScales[playerSpecID].scaleID) then
		_activeSpec()
	end
	-- Populate scoreData
	_populateWeights()
end

function f:UpdateValues() -- Update scores
	lock = nil
	if not (_G.AzeriteEmpoweredItemUI or _G.AzeriteEssenceUI) then return end

	-- TRAITS
	if cfg.enableTraits and _G.AzeriteEmpoweredItemUI and _G.AzeriteEmpoweredItemUI:IsShown() then
		local currentScore, currentPotential, maxScore, currentLevel, maxLevel, midTrait = 0, 0, 0, 0, 0, 0
		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		if azeriteItemLocation then
			currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
		end

		-- Update score strings and calculate current score
		while #activeTStrings > 0 do
			local s = tremove(activeTStrings)
			ReleaseString(s)
		end

		-- Calculate maxScore for the item
		local allTierInfo = _G.AzeriteEmpoweredItemUI.azeriteItemDataSource:GetAllTierInfo()
		if not allTierInfo then
			local itemID = _G.AzeriteEmpoweredItemUI.azeriteItemDataSource:GetItem():GetItemID()
			if not itemID then return end
			allTierInfo = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(itemID)
		end

		--[[
			Dump: value=C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(158041)
			[1]={
				[1]={
					azeritePowerIDs={
						[1]=195,
						[2]=186,
						[3]=385,
						[4]=184
					},
					unlockLevel=10
				},
				[2]={
					azeritePowerIDs={
						[1]=218,
						[2]=83
					},
					unlockLevel=15
				},
				[3]={
					azeritePowerIDs={
						[1]=13
					},
					unlockLevel=20
				}
			}
		]]

		local tierMaximumInfo = {} -- Keep track of best trait for every tier
		for tierIndex, tierInfo in ipairs(allTierInfo) do
			local maximum, tierMaximum = 0, 0
			local scoreTmp = "> Tier " .. tierIndex .. ":"
			for _, azeritePowerID in ipairs(tierInfo.azeritePowerIDs) do
				local score = 0
				local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(azeritePowerID)
				if powerInfo then
					score = scoreData[powerInfo.azeritePowerID] or scoreData[powerInfo.spellID] or 0
				end

				if maximum < score then
					maximum = score
					tierMaximumInfo[tierIndex] = score -- Get best score for tier instead of azeritePowerID
				end
				if tierInfo.unlockLevel <= currentLevel and tierMaximum < score then
					tierMaximum = score
				end
				scoreTmp = scoreTmp .. " " .. (azeritePowerID or "?") .. ":" .. (scoreData[powerInfo.azeritePowerID] or "!") .. ":" .. (scoreData[azeritePowerID] or "!")
			end

			maxScore = maxScore + maximum
			currentPotential = currentPotential + tierMaximum
			if maxLevel < tierInfo.unlockLevel then
				maxLevel = tierInfo.unlockLevel
			end
		end

		-- Update scores on the traits
		traitStack.scoreData = traitStack.scoreData or {}
		wipe(traitStack.scoreData)

		local container = _G.AzeriteEmpoweredItemUI.ClipFrame.PowerContainerFrame
		local children = { container:GetChildren() }
		local frameTmp = "> Frames:"
		for _, frame in ipairs(children) do
			if frame and frame:IsShown() then

				local score = 0
				local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(frame.azeritePowerID)
				if powerInfo then
					score = scoreData[powerInfo.azeritePowerID] or scoreData[powerInfo.spellID] or 0
				end

				if frame.isSelected == true then
					currentScore = currentScore + score

					if powerInfo.azeritePowerID == 13 then -- Middle
						midTrait = midTrait + 1
					end
				end

				local tier = frame:GetTierIndex()
				if currentLevel < frame.unlockLevel then
					score = GRAY_FONT_COLOR_CODE .. score .. FONT_COLOR_CODE_CLOSE
				elseif tier and tierMaximumInfo[tier] == score then -- Best score for tier
					score = ITEM_QUALITY_COLORS[7].hex .. score .. FONT_COLOR_CODE_CLOSE
				end

				if not C_AzeriteEmpoweredItem.IsPowerAvailableForSpec(frame.azeritePowerID, playerSpecID) then -- Recolor unusable powers
					score = RED_FONT_COLOR_CODE .. score .. FONT_COLOR_CODE_CLOSE
				end
				frameTmp = frameTmp .. " " .. (frame.azeritePowerID or "?") .. ":" .. (scoreData[powerInfo.azeritePowerID] or "!") .. ":" .. (scoreData[frame.azeritePowerID] or "!")
				local s = AcquireString(frame, score)
				activeTStrings[#activeTStrings + 1] = s

				if powerInfo then
					traitStack.scoreData[#traitStack.scoreData + 1] = ("%s = %s"):format(tostring(powerInfo.azeritePowerID), tostring(score))
				end
			end
		end

		-- Update the string
		if currentLevel >= maxLevel then
			midTrait = midTrait + 1 -- 0 = Middle is locked, 1 = Middle is open, 2 = Middle is open and selected
			if midTrait == 1 then
			end
		else
		end

		local effectiveILvl = _G.AzeriteEmpoweredItemUI.azeriteItemDataSource:GetItem():GetCurrentItemLevel()
		if cfg.addILvlToScore and effectiveILvl then
			local middleTraitValue = midTrait == 1 and 5 or 0
			if cfg.scaleByAzeriteEmpowered then
				local azeriteEmpoweredWeight = scoreData and scoreData[13] or 0
				effectiveILvl = effectiveILvl / 5 * azeriteEmpoweredWeight -- Azerite Empowered is +5ilvl
				middleTraitValue = middleTraitValue / 5 * azeriteEmpoweredWeight
			end

			currentScore = currentScore + effectiveILvl + middleTraitValue
			currentPotential = currentPotential + effectiveILvl + middleTraitValue
			maxScore = maxScore + effectiveILvl + (midTrait == 2 and 0 or middleTraitValue)
		end

		local stats = GetItemStats(_G.AzeriteEmpoweredItemUI.azeriteItemDataSource:GetItem():GetItemLink())
		if cfg.addPrimaryStatToScore and stats then
			local statScore = stats["ITEM_MOD_AGILITY_SHORT"] or stats["ITEM_MOD_INTELLECT_SHORT"] or stats["ITEM_MOD_STRENGTH_SHORT"] or 0

			currentScore = currentScore + statScore
			currentPotential = currentPotential + statScore
			maxScore = maxScore + statScore
		end

		-- Integer or Float?
		local cS, cP, mS
		if _isInteger(currentScore) and _isInteger(currentPotential) and _isInteger(maxScore) then
			cS, cP, mS = currentScore, currentPotential, maxScore
		else
			local decimals = max(_getDecimals(currentScore), _getDecimals(currentPotential), _getDecimals(maxScore))
			cS = (currentScore == 0 and "%d" or ("%%.%df"):format(decimals)):format(currentScore)
			cP = (currentPotential == 0 and "%d" or ("%%.%df"):format(decimals)):format(currentPotential)
			mS = (maxScore == 0 and "%d" or ("%%.%df"):format(decimals)):format(maxScore)
		end

		local baseScore = format(U["PowersScoreString"], cS, cP, mS, currentLevel, maxLevel)

		local groupSet, _, _, scaleName = strsplit("/", cfg.specScales[playerSpecID].scaleID)

		if n.Tstring then
			n.Tstring:SetText(format("%s\n%s", NORMAL_FONT_COLOR_CODE .. ((groupSet == "D" and (n.defaultNameTable[scaleName] or cfg.specScales[playerSpecID].scaleName) or cfg.specScales[playerSpecID].scaleName) or U["ScaleName_Unknown"]) .. FONT_COLOR_CODE_CLOSE, baseScore))
		else
			delayedUpdate()
		end

		traitStack.scoreData.current = cS
		traitStack.scoreData.potential = cP
		traitStack.scoreData.maximum = mS

	end
	-- ESSENCES
	if cfg.enableEssences and _G.AzeriteEssenceUI and _G.AzeriteEssenceUI:IsShown() then -- 8.2 Azerite Essences
		-- Update score strings and calculate current score
		while #activeEStrings > 0 do
			local s = tremove(activeEStrings)
			ReleaseString(s)
		end

		essenceStack.scoreData = essenceStack.scoreData or {}
		wipe(essenceStack.scoreData)

		local essences = C_AzeriteEssence.GetEssences()
		local maxMajors, maxMinors = {}, {}
		local potMajors, potMinors = {}, {}
		for i = 1, #essences do
			--[[
				[8]={
					valid=true,
					name="Nullification Dynamo",
					ID=13,
					icon=3015741,
					unlocked=false,
					rank=0
				},
			]]--
			local essence = essences[i]
			if essenceScoreData[essence.ID] then
				if essence.valid then
					maxMajors[essence.ID] = essenceScoreData[essence.ID][1] or 0
					maxMinors[essence.ID] = essenceScoreData[essence.ID][2] or 0

					if essence.unlocked then
						potMajors[essence.ID] = essenceScoreData[essence.ID][1] or 0
						potMinors[essence.ID] = essenceScoreData[essence.ID][2] or 0
					end
				end

				local majorS = essenceScoreData[essence.ID][1] or 0
				local minorS = essenceScoreData[essence.ID][2] or 0
				local combinedS = majorS + minorS
				if not essence.unlocked then
					majorS = GRAY_FONT_COLOR_CODE .. majorS .. FONT_COLOR_CODE_CLOSE
					minorS = GRAY_FONT_COLOR_CODE .. minorS .. FONT_COLOR_CODE_CLOSE
					combinedS = GRAY_FONT_COLOR_CODE .. combinedS .. FONT_COLOR_CODE_CLOSE
				end

				essenceStack.scoreData[#essenceStack.scoreData + 1] = ("%s = %s (%s/%s)"):format(tostring(essence.ID), tostring(combinedS), tostring(majorS), tostring(minorS))
			end
		end


		local milestones = C_AzeriteEssence.GetMilestones()
		local slots = 0
		for i = #milestones, 1, -1 do
			if milestones[i].ID == 119 and milestones[i].unlocked == true then -- Major + 3 minor
				slots = 4
				break
			elseif milestones[i].ID == 117 and milestones[i].unlocked == true then -- Major + 2 Minor
				slots = 3
				break
			elseif milestones[i].ID == 116 and milestones[i].unlocked == true then -- Major + Minor
				slots = 2
				break
			elseif milestones[i].ID == 115 and milestones[i].unlocked == true then -- Major
				slots = 1
				break
			end
		end

		essenceStack.math = essenceStack.math or {}
		wipe(essenceStack.math)

		-- Calculate the best combination for essences
		local finalEssenceScores = finalEssenceScores or {}
		for iterator = 1, 3 do
			essenceStack.math[#essenceStack.math + 1] = ("Iteration %d:\n   ---------------"):format(iterator)

			-- Copy the essence scores so we don't mess up with the original results tainting later iterations
			local tempMaxMajors = shallowcopy(maxMajors)
			local tempMaxMinors = shallowcopy(maxMinors)
			local tempPotMajors = shallowcopy(potMajors)
			local tempPotMinors = shallowcopy(potMinors)

			-- Sort functions
			local function maxMajorSort(a, b) -- Sort from largest to the smallest score
				return ((tempMaxMajors[a] or 0) + (tempMaxMinors[a] or 0)) > ((tempMaxMajors[b] or 0) + (tempMaxMinors[b] or 0))
			end
			local function maxMinorSort(a, b) -- Sort from smallest to the largest score
				return (tempMaxMinors[a] or 0) < (tempMaxMinors[b] or 0)
			end

			local function potMajorSort(a, b) -- Sort from largest to the smallest score
				return ((tempPotMajors[a] or 0) + (tempPotMinors[a] or 0)) > ((tempPotMajors[b] or 0) + (tempPotMinors[b] or 0))
			end
			local function potMinorSort(a, b) -- Sort from smallest to the largest score
				return (tempPotMinors[a] or 0) < (tempPotMinors[b] or 0)
			end

			-- Find Maximum score
			-- Find best Major score
			local maxMajorIDs = {}
			for essenceID in pairs(tempMaxMajors) do
				maxMajorIDs[#maxMajorIDs + 1] = essenceID
			end

			sort(maxMajorIDs, maxMajorSort)
			local maxMajorID = tremove(maxMajorIDs, iterator) -- Remove Nth element
			local tempMax = ((tempMaxMajors[maxMajorID] or 0) + (tempMaxMinors[maxMajorID] or 0))
			local maxScore = tempMax

			essenceStack.math[#essenceStack.math + 1] = ("MAX Major: %s + %s = %s (%d)"):format(tostring(tempMax-(tempMaxMinors[maxMajorID] or 0)), tostring(tempMaxMinors[maxMajorID]), tostring(tempMax), maxMajorID)

			if tempMaxMinors[maxMajorID] then
				tempMaxMinors[maxMajorID] = nil -- Remove the top Major score's minor score
			end

			-- Find top 3 maximum Minor scores from the rest by putting them into table and sorting them and picking first 3
			local maxMinorIDs = {}
			for essenceID in pairs(tempMaxMinors) do
				maxMinorIDs[#maxMinorIDs + 1] = essenceID
			end

			sort(maxMinorIDs, maxMinorSort)
			essenceStack.math[#essenceStack.math + 1] = "MinorMax:"
			for _, val in ipairs(tempMaxMinors) do
				essenceStack.math[#essenceStack.math] = essenceStack.math[#essenceStack.math] .. (" %s"):format(tostring(val))
			end

			local firstMaxID = tremove(maxMinorIDs)
			local secondMaxID = tremove(maxMinorIDs)
			local thirdMaxID = tremove(maxMinorIDs)

			local firstMax = tempMaxMinors[firstMaxID] or 0
			local secondMax = tempMaxMinors[secondMaxID] or 0
			local thirdMax = tempMaxMinors[thirdMaxID] or 0

			maxScore = maxScore + firstMax + secondMax + thirdMax -- Doing work for 8.3 already

			essenceStack.math[#essenceStack.math + 1] = ("MAX Minor: %s / %s / %s (%d - %d - %d)"):format(tostring(firstMax), tostring(secondMax), tostring(thirdMax), firstMaxID, secondMaxID, thirdMaxID)
			essenceStack.math[#essenceStack.math + 1] = ("MAX Score: %s"):format(tostring(maxScore))

			-- Find Potential score
			-- Find best Major score
			local potMajorIDs = {}
			for essenceID in pairs(tempPotMajors) do
				potMajorIDs[#potMajorIDs + 1] = essenceID
			end

			sort(potMajorIDs, potMajorSort)
			local potMajorID = tremove(potMajorIDs, iterator) -- Remove Nth element
			local tempPot = ((tempPotMajors[potMajorID] or 0) + (tempPotMinors[potMajorID] or 0))
			local currentPotential = tempPot

			essenceStack.math[#essenceStack.math + 1] = ("POT Major: %s + %s = %s (%d)"):format(tostring(tempPot-(tempPotMinors[potMajorID] or 0)), tostring(tempPotMinors[potMajorID]), tostring(tempPot), potMajorID)

			if tempPotMinors[potMajorID] then
				tempPotMinors[potMajorID] = nil -- Remove the top Major score's minor score
			end

			-- Find top 3 potential Minor scores from the rest by putting them into table and sorting them and picking first 3
			local potMinorIDs = {}
			for essenceID in pairs(tempPotMinors) do
				potMinorIDs[#potMinorIDs + 1] = essenceID
			end

			sort(potMinorIDs, potMinorSort)
			essenceStack.math[#essenceStack.math + 1] = "MinorPot:"
			for _, val in ipairs(tempPotMinors) do
				essenceStack.math[#essenceStack.math] = essenceStack.math[#essenceStack.math] .. (" %s"):format(tostring(val))
			end

			local firstPotID = tremove(potMinorIDs)
			local secondPotID = tremove(potMinorIDs)
			local thirdPotID = tremove(potMinorIDs)

			local firstPot = tempPotMinors[firstPotID] or 0
			local secondPot = tempPotMinors[secondPotID] or 0
			local thirdPot = tempPotMinors[thirdPotID] or 0

			if slots == 1 then
				--currentPotential = currentPotential -- Previously set Major slot's score
			elseif slots == 2 then
				currentPotential = currentPotential + firstPot
			elseif slots == 3 then
				currentPotential = currentPotential + firstPot + secondPot
			elseif slots == 4 then -- 8.3
				currentPotential = currentPotential + firstPot + secondPot + thirdPot
			else -- Slots == 0
				currentPotential = 0
			end

			essenceStack.math[#essenceStack.math + 1] = ("POT Minor: %s / %s / %s (%d - %d - %d)"):format(tostring(firstPot), tostring(secondPot), tostring(thirdPot), firstPotID, secondPotID, thirdPotID)
			essenceStack.math[#essenceStack.math + 1] = ("POT Score: %s (%d)\n   ---------------"):format(tostring(currentPotential), slots)

			finalEssenceScores[iterator] = {
				maxScore, -- 1
				--[[
				maxMajorID, -- 2
				firstMaxID, -- 3
				secondMaxID, -- 4
				thirdMaxID, -- 5
				]]--
				currentPotential, -- 6, 2
				potMajorID, -- 7, 3
				firstPotID, -- 8, 4
				secondPotID, -- 9, 5
				thirdPotID, -- 10, 6
				tempPot, -- 11, 7
				firstPot, -- 12, 8
				secondPot, -- 13, 9
				thirdPot -- 14, 10
			}
		end

		local currentScore, currentPotential, maxScore = 0, 0, 0
		local maxID, potID = 1, 1

		if cfg.preferBiSMarjor then -- Prefer BiS Major essence
			maxScore = finalEssenceScores[1][1]
			currentPotential = finalEssenceScores[1][2]
		else -- Check if we can get better score with non-BiS Major essence
			if finalEssenceScores[1][1] > finalEssenceScores[2][1] and finalEssenceScores[1][1] > finalEssenceScores[3][1] then
				maxID = 1
				maxScore = finalEssenceScores[1][1]
			elseif finalEssenceScores[2][1] > finalEssenceScores[1][1] and finalEssenceScores[2][1] > finalEssenceScores[3][1] then
				maxID = 2
				maxScore = finalEssenceScores[2][1]
			else
				maxID = 3
				maxScore = finalEssenceScores[3][1]
			end

			if finalEssenceScores[1][2] > finalEssenceScores[2][2] and finalEssenceScores[1][2] > finalEssenceScores[3][2] then
				potID = 1
				currentPotential = finalEssenceScores[1][2]
			elseif finalEssenceScores[2][2] > finalEssenceScores[1][2] and finalEssenceScores[2][2] > finalEssenceScores[3][2] then
				potID = 2
				currentPotential = finalEssenceScores[2][2]
			else
				potID = 3
				currentPotential = finalEssenceScores[3][2]
			end
		end
		essenceStack.math[#essenceStack.math + 1] = ("FINAL Score: %s / %s (%d / %d) - %s"):format(tostring(currentPotential), tostring(maxScore), potID, maxID, tostring(cfg.preferBiSMarjor))

		--[[
			maxScore: 10.5 10.5 7 3.5 25
			maxScore: 17.5 4 3
			currentPotential: 9 9 5 4 27
			currentPotential: 9 2 1 1
			currentScore: 7 7
		]]--

		-- Draw scores on the Essences inside the scroll-frame
		--[[
			AzeriteEssenceInfo
			Key			Type
			-------------------
			ID			number
			name		string
			rank		number
			unlocked	bool
			valid		bool
			icon		number
		]]--
		local container = _G.AzeriteEssenceUI.EssenceList.ScrollChild
		local children = { container:GetChildren() }
		for _, frame in ipairs(children) do
			if frame and frame:IsShown() then -- There are 13 buttons, but you can fit only 12 on the screen at any given time or you end up with numbers hovering under or over the frame

				if frame.essenceID then
					local majorScore, minorScore = 0, 0

					local essenceInfo = C_AzeriteEssence.GetEssenceInfo(frame.essenceID)
					if essenceInfo then

						if essenceScoreData[essenceInfo.ID] then
							majorScore = essenceScoreData[essenceInfo.ID][1] or 0
							minorScore = essenceScoreData[essenceInfo.ID][2] or 0
						end
					end

					local isBiSMajor, isBiSMinor = false, false
					if not frame.majorString then
						--frame.majorString = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
						frame.majorString = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
						frame.majorString:SetPoint("TOPRIGHT", -2, -5)
					end
					--if finalEssenceScores[potID][3] == essenceInfo.ID then -- BiS Major
					if finalEssenceScores[potID][7] == (majorScore + minorScore) then -- BiS Major score
						isBiSMajor = true
					end
					frame.majorString:SetText(majorScore)

					if not frame.minorString then
						--frame.minorString = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
						frame.minorString = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
						frame.minorString:SetPoint("BOTTOMRIGHT", -2, 5)
					end
					--if finalEssenceScores[potID][4] == essenceInfo.ID or finalEssenceScores[potID][5] == essenceInfo.ID then -- or finalEssenceScores[potID][6] == essenceInfo.ID then -- BiS Minor
					if finalEssenceScores[potID][8] == minorScore or finalEssenceScores[potID][9] == minorScore or finalEssenceScores[potID][10] == minorScore then -- BiS Minor score
						isBiSMinor = true
					end
					frame.minorString:SetText(minorScore)

					if essenceInfo then
						if not essenceInfo.valid then -- Not valid
							frame.majorString:SetText(RED_FONT_COLOR_CODE .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
							frame.minorString:SetText(RED_FONT_COLOR_CODE .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						elseif not essenceInfo.unlocked then -- Locked
							frame.majorString:SetText(GRAY_FONT_COLOR_CODE .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
							frame.minorString:SetText(GRAY_FONT_COLOR_CODE .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						elseif isBiSMajor then -- BiS Major
							frame.majorString:SetText(ITEM_QUALITY_COLORS[5].hex .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
							frame.minorString:SetText(ITEM_QUALITY_COLORS[5].hex .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						elseif isBiSMinor then -- BiS Minor
							--frame.majorString:SetText(ITEM_QUALITY_COLORS[7].hex .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
							frame.minorString:SetText(ITEM_QUALITY_COLORS[7].hex .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						end
					end
					--[[
					if essenceInfo and not essenceInfo.valid then
						frame.majorString:SetText(RED_FONT_COLOR_CODE .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						frame.minorString:SetText(RED_FONT_COLOR_CODE .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
					elseif essenceInfo and not essenceInfo.unlocked then
						frame.majorString:SetText(GRAY_FONT_COLOR_CODE .. frame.majorString:GetText() .. FONT_COLOR_CODE_CLOSE)
						frame.minorString:SetText(GRAY_FONT_COLOR_CODE .. frame.minorString:GetText() .. FONT_COLOR_CODE_CLOSE)
					end
					]]--

				end

			end
		end

		-- Draw scores for the Essences in the main view of the UI
		local frameTmp = "> Frames:"
		essenceStack.scoreData[#essenceStack.scoreData + 1] = "---"
		for _, slotFrame in ipairs(_G.AzeriteEssenceUI.Slots) do
			local score = 0

			local essenceID = C_AzeriteEssence.GetMilestoneEssence(slotFrame.milestoneID)
			if essenceID then
				if essenceScoreData[essenceID] then
					if slotFrame.isMajorSlot then -- Major Slot
						--score = (essenceScoreData[essenceID][1] or 0) + (essenceScoreData[essenceID][2] or 0)
						-- Show Major/Minor values instead of combined value in the UI
						score = (essenceScoreData[essenceID][1] or 0) .. "\n" .. (essenceScoreData[essenceID][2] or 0)
						currentScore = currentScore + (essenceScoreData[essenceID][1] or 0) + (essenceScoreData[essenceID][2] or 0)
					else -- Minor Slot
						score = essenceScoreData[essenceID][2] or 0
						currentScore = currentScore + score
					end
				end

				--currentScore = currentScore + score

				essenceStack.scoreData[#essenceStack.scoreData + 1] = ("%s = %s/%s"):format(tostring(essenceID), string.gsub(tostring(score), "\n", " - "), tostring(slotFrame.isMajorSlot))
			end

			frameTmp = frameTmp .. " " .. (slotFrame.milestoneID or "?") .. " " .. (slotFrame.requiredLevel or "?") .. " " .. (slotFrame.slot or "?") .. " " .. (slotFrame.swirlScale or "?") .. " " .. tostring(slotFrame.canUnlock) .. " " .. tostring(slotFrame.isDraggable) .. " " .. tostring(slotFrame.isMajorSlot) .. " " .. tostring(slotFrame.unlocked)

			if slotFrame.unlocked then
				local s = AcquireString(slotFrame, score)
				activeEStrings[#activeEStrings + 1] = s
			end
		end

		--n.string:SetText("Cool")
		local currentLevel = _G.AzeriteEssenceUI.powerLevel or 0
		local maxLevel = milestones[#milestones].requiredLevel or 0

		-- Integer or Float?
		local cS, cP, mS
		if _isInteger(currentScore) and _isInteger(currentPotential) and _isInteger(maxScore) then
			cS, cP, mS = currentScore, currentPotential, maxScore
		else
			local decimals = max(_getDecimals(currentScore), _getDecimals(currentPotential), _getDecimals(maxScore))
			cS = (currentScore == 0 and "%d" or ("%%.%df"):format(decimals)):format(currentScore)
			cP = (currentPotential == 0 and "%d" or ("%%.%df"):format(decimals)):format(currentPotential)
			mS = (maxScore == 0 and "%d" or ("%%.%df"):format(decimals)):format(maxScore)
		end

		local baseScore = format(U["PowersScoreString"], cS, cP, mS, currentLevel, maxLevel)
		local groupSet, _, _, scaleName = strsplit("/", cfg.specScales[playerSpecID].scaleID)

		if n.Estring then
			n.Estring:SetText(format("%s\n%s", NORMAL_FONT_COLOR_CODE .. ((groupSet == "D" and (n.defaultNameTable[scaleName] or cfg.specScales[playerSpecID].scaleName) or cfg.specScales[playerSpecID].scaleName) or U["ScaleName_Unknown"]) .. FONT_COLOR_CODE_CLOSE, baseScore))
		else
			delayedUpdate()
		end

		essenceStack.scoreData.current = cS
		essenceStack.scoreData.potential = cP
		essenceStack.scoreData.maximum = mS
		essenceStack.scoreData.slots = slots
	end
end

-- Item Tooltip & Hook - Hacked together and probably could be done better
local azeriteEmpoweredItemLocation = ItemLocation:CreateEmpty()
local itemEquipLocToSlot = {
	["INVTYPE_HEAD"] = 1,
	["INVTYPE_SHOULDER"] = 3,
	["INVTYPE_CHEST"] = 5,
	["INVTYPE_ROBE"] = 5
}

local function _getGearScore(dataPointer, itemEquipLoc)
	local currentLevel, maxLevel = 0, 0
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if azeriteItemLocation then
		currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
	end

	local itemLink = GetInventoryItemLink("player", itemEquipLoc)

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		local equipLocation = ItemLocation:CreateFromEquipmentSlot(itemEquipLoc)
		local allTierInfo = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(itemLink)

		local currentScore, currentPotential, maxScore, midTrait = 0, 0, 0, 0
		for tierIndex, tierInfo in ipairs(allTierInfo) do
			local maximum, tierMaximum = 0, 0
			for _, azeritePowerID in ipairs(tierInfo.azeritePowerIDs) do
				local score = 0
				local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(azeritePowerID)
				if powerInfo then
					score = dataPointer[powerInfo.azeritePowerID] or dataPointer[powerInfo.spellID] or 0

					if equipLocation:HasAnyLocation() and C_AzeriteEmpoweredItem.IsPowerSelected(equipLocation, powerInfo.azeritePowerID) then
						currentScore = currentScore + score

						if powerInfo.azeritePowerID == 13 then -- Middle
							midTrait = midTrait + 1
						end
					end
				end
				
				if maximum < score then
					maximum = score
				end
				if tierInfo.unlockLevel <= currentLevel and tierMaximum < score then
					tierMaximum = score
				end
			end

			maxScore = maxScore + maximum
			currentPotential = currentPotential + tierMaximum
			if maxLevel < tierInfo.unlockLevel then
				maxLevel = tierInfo.unlockLevel
			end
		end

		if currentLevel >= maxLevel then
			midTrait = midTrait + 1 -- 0 = Middle is locked, 1 = Middle is open, 2 = Middle is open and selected
			if midTrait == 1 then
			end
		else
		end

		return currentScore, currentPotential, maxScore, itemLink, midTrait
	end

	return 0, 0, 0, itemLink, 0
end

local tooltipTable = {}
local function _updateTooltip(tooltip, itemLink)
	local currentLevel, maxLevel = 0, 0
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
	if azeriteItemLocation then
		currentLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
	end

	--if not tooltipTable.itemLink or tooltipTable.itemLink ~= itemLink then
		wipe(tooltipTable)
		tooltipTable.itemLink = itemLink
		tooltipTable.currentLevel = currentLevel
		tooltipTable.scores = {}
	--end
	local allTierInfo = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(itemLink)

	local currentScore, currentPotential, maxScore, scaleInfo, midTrait = {}, {}, {}, {}, {}
	for i, tooltipScale in ipairs(cfg.tooltipScales) do
		currentScore[i] = 0
		currentPotential[i] = 0
		maxScore[i] = 0
		scaleInfo[i] = {}
		midTrait[i] = 0

		tooltipTable[i] = tooltipTable[i] or {}
		tooltipTable[i].tooltipScale = tooltipScale.scaleID

		local dataPointer
		local groupSet, classID, specNum, scaleName = strsplit("/", tooltipScale.scaleID)
		if groupSet and classID and specNum and scaleName then
			classID = tonumber(classID)
			specNum = tonumber(specNum)
			for _, dataSet in ipairs(groupSet == "C" and customScales or n.defaultScalesData) do
				if (dataSet) and dataSet[1] == scaleName and dataSet[2] == classID and dataSet[3] == specNum then
					dataPointer = dataSet[4]

					scaleInfo[i].class = classID
					if groupSet == "C" then
						local _, specName, _, iconID = GetSpecializationInfoByID(specNum)
						scaleInfo[i].icon = iconID
					else
						local _, specName, _, iconID = GetSpecializationInfoForClassID(classID, specNum)
						scaleInfo[i].icon = iconID
					end

					break
				end
			end
		end

		if dataPointer then
			for tierIndex, tierInfo in ipairs(allTierInfo) do

				tooltipTable[i][tierIndex] = tooltipTable[i][tierIndex] or {}
				tooltipTable[i][tierIndex].unlockLevel = tooltipTable[i][tierIndex].unlockLevel or tierInfo.unlockLevel

				local maximum, tierMaximum = 0, 0
				for _, azeritePowerID in ipairs(tierInfo.azeritePowerIDs) do
					local score = 0
					local powerInfo = C_AzeriteEmpoweredItem.GetPowerInfo(azeritePowerID)
					if powerInfo then
						score = dataPointer[powerInfo.azeritePowerID] or dataPointer[powerInfo.spellID] or 0

						tooltipTable[i][tierIndex][powerInfo.azeritePowerID] = score
						if azeriteEmpoweredItemLocation:HasAnyLocation() and C_AzeriteEmpoweredItem.IsPowerSelected(azeriteEmpoweredItemLocation, powerInfo.azeritePowerID) then
							currentScore[i] = currentScore[i] + score

							tooltipTable[i][tierIndex][powerInfo.azeritePowerID] = ">" .. score .. "<"
							if powerInfo.azeritePowerID == 13 then -- Middle
								midTrait[i] = midTrait[i] + 1
							end
						else
						end
					end
					
					if maximum < score then
						maximum = score
					end
					if tierInfo.unlockLevel <= currentLevel and tierMaximum < score then
						tierMaximum = score
					end
				end
				maxScore[i] = maxScore[i] + maximum
				currentPotential[i] = currentPotential[i] + tierMaximum
				if maxLevel < tierInfo.unlockLevel then
					maxLevel = tierInfo.unlockLevel
				end
			end
		end

		if currentLevel >= maxLevel then
			midTrait[i] = midTrait[i] + 1 -- 0 = Middle is locked, 1 = Middle is open, 2 = Middle is open and selected
			if midTrait[i] == 1 then
			end
		else
		end
		tooltipTable.scores[i] = tooltipTable.scores[i] or {}
		tooltipTable.scores[i].traitScore = currentScore[i]
		tooltipTable.scores[i].traitPotential = currentPotential[i]
		tooltipTable.scores[i].traitMax = maxScore[i]

		local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
		local effectiveILvl = GetDetailedItemLevelInfo(itemLink)
		if cfg.addILvlToScore and effectiveILvl then
			local middleTraitValue = midTrait[i] == 1 and 5 or 0
			if cfg.scaleByAzeriteEmpowered then
				local azeriteEmpoweredWeight = dataPointer and dataPointer[13] or 0
				effectiveILvl = effectiveILvl / 5 * azeriteEmpoweredWeight -- Azerite Empowered is +5ilvl
				middleTraitValue = middleTraitValue / 5 * azeriteEmpoweredWeight
			end

			currentScore[i] = currentScore[i] + effectiveILvl + middleTraitValue
			currentPotential[i] = currentPotential[i] + effectiveILvl + middleTraitValue
			maxScore[i] = maxScore[i] + effectiveILvl + (midTrait[i] == 2 and 0 or middleTraitValue)
			tooltipTable.scores[i].midTrait = midTrait[i]
			tooltipTable.scores[i].middleTraitValue = middleTraitValue
			tooltipTable.scores[i].ilvlScore = currentScore[i]
			tooltipTable.scores[i].ilvlPotential = currentPotential[i]
			tooltipTable.scores[i].ilvlMax = maxScore[i]
		end

		tooltipTable.scores.effectiveILvl = effectiveILvl
		local stats = GetItemStats(itemLink)
		if cfg.addPrimaryStatToScore and stats then
			local statScore = stats["ITEM_MOD_AGILITY_SHORT"] or stats["ITEM_MOD_INTELLECT_SHORT"] or stats["ITEM_MOD_STRENGTH_SHORT"] or 0

			currentScore[i] = currentScore[i] + statScore
			currentPotential[i] = currentPotential[i] + statScore
			maxScore[i] = maxScore[i] + statScore
			tooltipTable.scores[i].statAmount = statScore
			tooltipTable.scores[i].statScore = currentScore[i]
			tooltipTable.scores[i].statPotential = currentPotential[i]
			tooltipTable.scores[i].statMax = maxScore[i]
		end

		if cfg.relativeScore and dataPointer then
			local equippedScore, equippedPotential, equippedMax, equippedItemLink, equippedMidTrait = _getGearScore(dataPointer, itemEquipLocToSlot[itemEquipLoc])

			local equippedEffectiveILvl = GetDetailedItemLevelInfo(equippedItemLink)
			tooltipTable.equippedItemLink = equippedItemLink
			tooltipTable.equippedEffectiveILvl = equippedEffectiveILvl
			tooltipTable.scores[i].relTraitScore = equippedScore
			tooltipTable.scores[i].relTraitPotential = equippedPotential
			tooltipTable.scores[i].relTraitMax = equippedMax
			if cfg.addILvlToScore and equippedEffectiveILvl then
				local middleTraitValue = equippedMidTrait == 1 and 5 or 0
				if cfg.scaleByAzeriteEmpowered then
					local azeriteEmpoweredWeight = dataPointer and dataPointer[13] or 0
					equippedEffectiveILvl = equippedEffectiveILvl / 5 * azeriteEmpoweredWeight -- Azerite Empowered is +5ilvl
					middleTraitValue = middleTraitValue / 5 * azeriteEmpoweredWeight
				end

				equippedScore = equippedScore + equippedEffectiveILvl + middleTraitValue
				equippedPotential = equippedPotential + equippedEffectiveILvl + middleTraitValue
				equippedMax = equippedMax + equippedEffectiveILvl + (equippedMidTrait == 2 and 0 or middleTraitValue)
				tooltipTable.scores[i].relMidTrait = equippedMidTrait
				tooltipTable.scores[i].relMiddleTraitValue = middleTraitValue
				tooltipTable.scores[i].relIlvlScore = equippedScore
				tooltipTable.scores[i].relIlvlPotential = equippedPotential
				tooltipTable.scores[i].relIlvlMax = equippedMax
			end

			local equippedStats = GetItemStats(equippedItemLink)
			if cfg.addPrimaryStatToScore and equippedStats then
				local statScore = equippedStats["ITEM_MOD_AGILITY_SHORT"] or equippedStats["ITEM_MOD_INTELLECT_SHORT"] or equippedStats["ITEM_MOD_STRENGTH_SHORT"] or 0
				equippedScore = equippedScore + statScore
				equippedPotential = equippedPotential + statScore
				equippedMax = equippedMax + statScore
				tooltipTable.scores[i].relStatAmount = statScore
				tooltipTable.scores[i].relStatScore = equippedScore
				tooltipTable.scores[i].relStatPotential = equippedPotential
				tooltipTable.scores[i].relStatMax = equippedMax
			end

			currentScore[i] = equippedScore == 0 and 0 or floor((currentScore[i] / equippedScore - 1) * 100 + .5)
			currentPotential[i] = equippedPotential == 0 and 0 or floor((currentPotential[i] / equippedPotential - 1) * 100 + .5)
			maxScore[i] = equippedMax == 0 and 0 or floor((maxScore[i] / equippedMax - 1) * 100 + .5)
		end
	end

	local tooltipLine = ""
	if cfg.showTooltipLegend then
		tooltipLine = tooltipLine .. HIGHLIGHT_FONT_COLOR_CODE .. U["ItemToolTip_Legend"] .. FONT_COLOR_CODE_CLOSE .. "\n"
	end
	local showTooltipLine = false

	for i = 1, #maxScore do
		if scaleInfo[i].class then
			local _, classTag = GetClassInfo(scaleInfo[i].class)
			local c = _G.RAID_CLASS_COLORS[classTag]

			local string = "|T%d:0|t |c%s%s|r: "
			if cfg.relativeScore then -- Relative score
				string = string .. ("%s%%d%s%s"):format(currentScore[i] < 0 and RED_FONT_COLOR_CODE or GREEN_FONT_COLOR_CODE .. "+", "%%", FONT_COLOR_CODE_CLOSE)
				string = string .. " / "
				string = string .. ("%s%%d%s%s"):format(currentPotential[i] < 0 and RED_FONT_COLOR_CODE or GREEN_FONT_COLOR_CODE .. "+", "%%", FONT_COLOR_CODE_CLOSE)
				string = string .. " / "
				string = string .. ("%s%%d%s%s"):format(maxScore[i] < 0 and RED_FONT_COLOR_CODE or GREEN_FONT_COLOR_CODE .. "+", "%%", FONT_COLOR_CODE_CLOSE)
			elseif _isInteger(currentScore[i]) and _isInteger(currentPotential[i]) and _isInteger(maxScore[i]) then -- All integers
				string = string .. "%d / %d / %d"
			else -- There are some floats
				local decimals = max(_getDecimals(currentScore[i]), _getDecimals(currentPotential[i]), _getDecimals(maxScore[i]))
				--string = string .. ("%%.%df / %%.%df / %%.%df"):format(decimals, decimals, decimals)
				string = string .. (currentScore[i] == 0 and "%d" or ("%%.%df"):format(decimals))
				string = string .. " / "
				string = string .. (currentPotential[i] == 0 and "%d" or ("%%.%df"):format(decimals))
				string = string .. " / "
				string = string .. (maxScore[i] == 0 and "%d" or ("%%.%df"):format(decimals))
			end

	tooltipLine = tooltipLine .. format(U["ItemToolTip_AzeriteLevel"], currentLevel, maxLevel) .. "\n"
			if not cfg.showOnlyUpgrades or cfg.showOnlyUpgrades and (currentScore[i] > 0 or currentPotential[i] > 0 or maxScore[i] > 0) then
				--tooltip:AddLine(format(string, scaleInfo[i].icon, c.colorStr, cfg.tooltipScales[i].scaleName, currentScore[i], currentPotential[i], maxScore[i]),  1, 1, 1)
				tooltipLine = tooltipLine .. format(string, scaleInfo[i].icon, c.colorStr, cfg.tooltipScales[i].scaleName, currentScore[i], currentPotential[i], maxScore[i])
				showTooltipLine = true
			end
		end
	end

	if showTooltipLine then
		tooltip:AddLine(tooltipLine)
	end
	tooltip:Show() -- Make updates visible
end

-- Item from bags
hooksecurefunc(GameTooltip, "SetBagItem", function(self, ...) -- This can be called 4-5 times per second
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local bag, slot = ...
	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		azeriteEmpoweredItemLocation = ItemLocation:CreateFromBagAndSlot(bag, slot)

		_updateTooltip(self, itemLink)
	end
end)

-- Equipped item
hooksecurefunc(GameTooltip, "SetInventoryItem", function(self, ...) -- This can be called 4-5 times per second
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local unit, equipLoc = ... -- player 1 nil true
	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		azeriteEmpoweredItemLocation = ItemLocation:CreateFromEquipmentSlot(equipLoc)

		_updateTooltip(self, itemLink)
	end
end)

-- Any other item, EJ etc.
hooksecurefunc(GameTooltip, "SetHyperlink", function(self, ...)
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		_updateTooltip(self, itemLink)
	end
end)

-- Vendor item (https://wow.gamepedia.com/Widget_API)
hooksecurefunc(GameTooltip, "SetMerchantItem", function(self, ...) -- ... = merchantSlot
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		--azeriteEmpoweredItemLocation = ItemLocation:CreateFromBagAndSlot(bag, slot) -- WTH have I been thinking or have I just been copy&pasting?

		_updateTooltip(self, itemLink)
	end
end)

-- Comparison tooltip for Vendor items (https://www.townlong-yak.com/framexml/27602/GameTooltip.lua#490)
hooksecurefunc(GameTooltip.shoppingTooltips[1], "SetCompareItem", function(self, ...) -- ... = ShoppingTooltip2, GameTooltip
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
		azeriteEmpoweredItemLocation = ItemLocation:CreateFromEquipmentSlot(itemEquipLocToSlot[itemEquipLoc])

		_updateTooltip(self, itemLink)
	end
end)

-- Comparison tooltip for WQ items (https://github.com/phanx-wow/PhanxBorder/blob/master/Blizzard.lua#L205)
-- WorldmapTooltip is being deprecated in 8.1.5. GameTooltip should be used instead. (https://www.wowinterface.com/forums/showthread.php?t=56964)
--[[
hooksecurefunc(WorldMapCompareTooltip1, "SetCompareItem", function(self, ...) -- ... = WorldMapCompareTooltip2, WorldMapTooltipTooltip
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink)
		azeriteEmpoweredItemLocation = ItemLocation:CreateFromEquipmentSlot(itemEquipLocToSlot[itemEquipLoc])

		_updateTooltip(self, itemLink)
	end
end)
]]

-- World Quest rewards (https://www.townlong-yak.com/framexml/27547/GameTooltip.lua#925)
hooksecurefunc("EmbeddedItemTooltip_SetItemByQuestReward", function(self, questLogIndex, questID)
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local iName, itemTexture, quantity, quality, isUsable, itemID = GetQuestLogRewardInfo(questLogIndex, questID)
	--[[if not itemID or type(itemID) ~= "number" then return end
	local itemName, itemLink = GetItemInfo(itemID)
	if not itemName then return end]]

	-- Fix for GetItemInfo(itemID) returning the base item instead of the properly upgraded item for better geared characters.
	-- This also fixes the missing rings (3 rings vs 5 rings) from calculations for those items.
	if not (iName and itemTexture) then return end
	local itemName, itemLink = self.Tooltip:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		--[[local item = Item:CreateFromItemLink(itemLink) -- Try to cache the item for real itemlevel
		item:ContinueOnItemLoad(function()
			_updateTooltip(self.Tooltip, itemLink)
		end)]]
		_updateTooltip(self.Tooltip, itemLink)
	end
end)

GameTooltip:HookScript("OnHide", function()
	azeriteEmpoweredItemLocation:Clear()
end)

-- Quest rewards (https://www.townlong-yak.com/framexml/27602/QuestInfo.lua#964)
hooksecurefunc(GameTooltip, "SetQuestItem", function(self, ...) -- ... = type, ID
	if not cfg or not cfg.tooltipScales then return end
	if #cfg.tooltipScales == 0 then return end -- Not tracking any scales for tooltip
	--if azeriteEmpoweredItemLocation:HasAnyLocation() then return end

	local itemName, itemLink = self:GetItem()
	if not itemName then return end

	if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemLink) then
		_updateTooltip(self, itemLink)
	end
end)


-- Event functions
function f:ADDON_LOADED(event, addon)
	if addon == "_ShiGuang" then
		AzeritePowerWeightsDB = initDB(AzeritePowerWeightsDB, dbDefaults)
		db = AzeritePowerWeightsDB

		local playerName = UnitName("player")
		local playerRealm = GetRealmName()

		if db.dbVersion == 1 then -- Changing default-setting for all users because the old system wasn't clear enough for some users.
			for rName, rData in pairs(db.char) do
				for pName, pData in pairs(rData) do
					db.char[rName][pName].rolePowersNoOffRolePowers = false
				end
			end
			db.dbVersion = 2
		end

		if db.dbVersion == 2 then -- Add Azerite Essences to the Custom-scales
			for _, scale in pairs(db.customScales) do
				if type(scale[5]) ~= "table" then -- Old scale, update it with inserting Essence-table and bumping everything else down a notch
					tinsert(scale, 5, {})
				end
			end
			db.dbVersion = 3
		end

		db.char[playerRealm] = db.char[playerRealm] or {}
		db.char[playerRealm][playerName] = initDB(db.char[playerRealm][playerName], charDefaults)

		customScales = db.customScales
		cfg = db.char[playerRealm][playerName]

		self:RegisterEvent("PLAYER_LOGIN")
		self:RegisterEvent("AZERITE_ITEM_POWER_LEVEL_CHANGED")
		self:RegisterEvent("AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED")
		self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
		self:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", "player")

		playerClassID = select(3, UnitClass("player"))
		for i = 1, GetNumSpecializationsForClassID(playerClassID) do
			local specID = GetSpecializationInfoForClassID(playerClassID, i)
			if
				not cfg.specScales[specID]
			or
				-- Localized Default-scalenames were causing issues, trying to revert those to normal state
				(cfg.specScales[specID].scaleName == U["DefaultScaleName_Default"] or
				cfg.specScales[specID].scaleName == U["DefaultScaleName_Defensive"] or
				cfg.specScales[specID].scaleName == U["DefaultScaleName_Offensive"])
			or
				-- More checks for the above
				(select(3, strmatch(cfg.specScales[specID].scaleID, "D/(%d+)/(%d+)/(.+)")) == U["DefaultScaleName_Default"] or
				select(3, strmatch(cfg.specScales[specID].scaleID, "D/(%d+)/(%d+)/(.+)")) == U["DefaultScaleName_Defensive"] or
				select(3, strmatch(cfg.specScales[specID].scaleID, "D/(%d+)/(%d+)/(.+)")) == U["DefaultScaleName_Offensive"])
			then

				local scaleKey = n.GetDefaultScaleSet(playerClassID, i)
				local _, _, _, defaultScaleName = strsplit("/", scaleKey)

				cfg.specScales[specID] = {
					scaleID = scaleKey,
					scaleName = defaultScaleName
				}
			end
		end

		--self:CreateOptions()

	elseif addon == "Blizzard_AzeriteUI" then
		-- Hook 'em & Cook 'em
		hooksecurefunc(_G.AzeriteEmpoweredItemUI, "UpdateTiers", delayedUpdate)
		--hooksecurefunc(_G.AzeriteEmpoweredItemUI, "Refresh", delayedUpdate)
		hooksecurefunc(_G.AzeriteEmpoweredItemUI, "OnItemSet", delayedUpdate)
		C_Timer.After(0, function() -- Fire on next frame instead of current frame
			delayedUpdate()
			_G.AzeriteEmpoweredItemUI:HookScript("OnShow", function()
				_setupStringAndEnableButton()
				delayedUpdate()
			end)
		end)
		self:HookAzeriteUI()

	elseif addon == "Blizzard_AzeriteEssenceUI" then
		-- Hook 'em & Cook 'em
		hooksecurefunc(_G.AzeriteEssenceUI, "RefreshMilestones", delayedUpdate)
		--hooksecurefunc(_G.AzeriteEssenceUI.EssenceList, "Update", delayedUpdate)
		hooksecurefunc(_G.AzeriteEssenceUI.EssenceList, "Refresh", delayedUpdate)
		--hooksecurefunc(_G.AzeriteEssenceUI.EssenceList, "CalculateScrollOffset", delayedUpdate)

		C_Timer.After(0, function() -- Fire on next frame instead of current frame
			delayedUpdate()
			_G.AzeriteEssenceUI:HookScript("OnShow", function()
				_setupStringAndEnableButton()
				delayedUpdate()
			end)
		end)
		self:HookAzeriteEssenceUI()
	end
end

function f:PLAYER_LOGIN(event)
	_activeSpec()

	if _G.AzeriteEmpoweredItemUI then
		self:HookAzeriteUI()
	end
end

function f:AZERITE_ITEM_POWER_LEVEL_CHANGED(event)
	delayedUpdate()
end

function f:AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED(event)
	delayedUpdate()
end

function f:PLAYER_EQUIPMENT_CHANGED(event, equipmentSlot, hasCurrent)
	if not azeriteSlots[equipmentSlot] then return end
	delayedUpdate()
end

function f:PLAYER_SPECIALIZATION_CHANGED(event, ...)
	_activeSpec()

	if _G.AzeriteEmpoweredItemUI then
		_populateWeights()
	end

	delayedUpdate()
end

-- Config
function f:RefreshConfig()
	delayedUpdate()
	if n.treeGroup and n.treeGroup.tree then
		n.treeGroup.tree = _buildTree(n.treeGroup.tree)
		n.treeGroup:RefreshTree(true)

		local lastExists;
		for _, v in ipairs(n.treeGroup.tree) do
			if v.value == lastOpenScale then
				lastExists = true
			end
		end

		n.treeGroup:SelectByValue(lastExists and lastOpenScale or "AzeritePowerWeightsImport")
	end
end

-- Slash
SLASH_AZERITEPOWERWEIGHTS1 = "/azerite"
if U["Slash_Command"] and U["Slash_Command"] ~= "/azerite" then
	SLASH_AZERITEPOWERWEIGHTS2 = U["Slash_Command"]
end

local SlashHandlers = {
	["reset"] = function()
		wipe(AzeritePowerWeightsDB)

		f:ADDON_LOADED("ADDON_LOADED", "AzeritePowerWeights")
		if n.treeGroup and n.treeGroup.tree then
			n.treeGroup.tree = _buildTree(n.treeGroup.tree)
			n.treeGroup:SelectByValue("AzeritePowerWeightsImport")
			n.treeGroup:RefreshTree(true)
		end
		--ReloadUI()
	end,
	["ticket"] = function()
		local text = ("%s %s/%d/%s (%s)\nSettings: Locale: %s"):format("AzeritePowerWeights", "8.3.10", C_CVar.GetCVar("scriptErrors"), cfg.specScales[playerSpecID].scaleName or U["ScaleName_Unknown"], cfg.specScales[playerSpecID].scaleID)
		--local first = true
		local skip = {
			["enableTraits"] = false,
			["enableEssences"] = false,
			["onlyOwnClassDefaults"] = false,
			["onlyOwnClassCustoms"] = false,
			["importingCanUpdate"] = true,
			["defensivePowers"] = false,
			["rolePowers"] = false,
			["rolePowersNoOffRolePowers"] = false,
			["zonePowers"] = false,
			["professionPowers"] = false,
			["pvpPowers"] = false,
			["addILvlToScore"] = true,
			["scaleByAzeriteEmpowered"] = true,
			["addPrimaryStatToScore"] = true,
			["relativeScore"] = true,
			["showOnlyUpgrades"] = true,
			["showTooltipLegend"] = true,
			["outlineScores"] = true,
			["preferBiSMarjor"] = false,
			["specScales"] = true,
			["tooltipScales"] = true
		}
		for key, _ in pairs(charDefaults) do
			if not skip[key] then
				--if first then
					--first = false
					--text = text .. ("%s: %s"):format(key, tostring(cfg[key]))
				--else
					text = text .. (", %s: %s"):format(key, tostring(cfg[key]))
				--end
			end
		end
		if n.Tstring then
			text = text .. ("\nTString: %s, %s"):format(tostring(select(2, n.Tstring:GetPoint()):GetParent():GetParent():GetName()), tostring(n.Tstring:IsShown()))
			text = text .. ("\nTButton: %s, %s, %s/%s, %s/%s"):format(tostring(n.TenableButton.frame:GetParent():GetParent():GetName() or n.TenableButton.frame:GetParent():GetParent():GetParent():GetName()), tostring(n.TenableButton.frame:IsShown()), tostring(n.TenableButton.frame:GetFrameStrata()), tostring(n.TenableButton.frame:GetParent():GetFrameStrata()), tostring(n.TenableButton.frame:GetFrameLevel()), tostring(n.TenableButton.frame:GetParent():GetFrameLevel()))
		else
			text = text .. ("\nNo Tstring / TButton")
		end
		if n.Estring then
			text = text .. ("\nEString: %s, %s"):format(tostring(select(2, n.Estring:GetPoint()):GetParent():GetName()), tostring(n.Estring:IsShown()))
			text = text .. ("\nEButton: %s, %s, %s/%s, %s/%s"):format(tostring(n.EenableButton.frame:GetParent():GetParent():GetName() or n.EenableButton.frame:GetParent():GetParent():GetParent():GetName()), tostring(n.EenableButton.frame:IsShown()), tostring(n.EenableButton.frame:GetFrameStrata()), tostring(n.EenableButton.frame:GetParent():GetFrameStrata()), tostring(n.EenableButton.frame:GetFrameLevel()), tostring(n.EenableButton.frame:GetParent():GetFrameLevel()))
		else
			text = text .. ("\nNo Estring / EButton")
		end
		text = text .. ("\nTrait Scores:\nLoaded: %s, Editor: %s"):format(tostring(traitStack.loading), tostring(traitStack.editor))
		if traitStack.scoreData then
			text = text .. ("\nC/P/M: %s / %s / %s"):format(tostring(traitStack.scoreData.current), tostring(traitStack.scoreData.potential), tostring(traitStack.scoreData.maximum))
			text = text .. "\nNumbers:"
			for _, v in ipairs(traitStack.scoreData) do
				if string.find(v, RED_FONT_COLOR_CODE) then
					v = v .. "R"
				elseif string.find(v, GRAY_FONT_COLOR_CODE) then
					v = v .. "G"
				end

				text = text .. ("\n   %s"):format(tostring(v))
			end
		end
		text = text .. ("\nEssence Scores:\nLoaded: %s, Editor: %s"):format(tostring(essenceStack.loading), tostring(essenceStack.editor))
		if essenceStack.scoreData then
			text = text .. ("\nC/P/M/Slots: %s / %s / %s / %s"):format(tostring(essenceStack.scoreData.current), tostring(essenceStack.scoreData.potential), tostring(essenceStack.scoreData.maximum), tostring(essenceStack.scoreData.slots))
			text = text .. "\nNumbers:"
			for _, v in ipairs(essenceStack.scoreData) do
				if string.find(v, RED_FONT_COLOR_CODE) then
					v = v .. "R"
				elseif string.find(v, GRAY_FONT_COLOR_CODE) then
					v = v .. "G"
				end

				text = text .. ("\n   %s"):format(tostring(v))
			end
		end

		if essenceStack.math then
			text = text .. "\nEssence Math:"
			for _, v in ipairs(essenceStack.math) do
				text = text .. ("\n   %s"):format(tostring(v))
			end
		end

	end,
	["tt"] = function(...) -- Get tooltip stuff
		local text = string.format("> START\n- - - - - - - - - -\nVer. %s\nClass/Spec: %s / %s\nScale: %s (%s)\n- - - - - - - - - -\n", "8.3.10", playerClassID, playerSpecID, cfg.specScales[playerSpecID].scaleName or U["ScaleName_Unknown"], cfg.specScales[playerSpecID].scaleID)

		text = text .. string.format("Score settings:\naddILvlToScore: %s\nscaleByAzeriteEmpowered: %s\naddPrimaryStatToScore: %s\nrelativeScore: %s\nshowOnlyUpgrades: %s\nshowTooltipLegend: %s\n- - - - - - - - - -\n", tostring(cfg.addILvlToScore), tostring(cfg.scaleByAzeriteEmpowered), tostring(cfg.addPrimaryStatToScore), tostring(cfg.relativeScore), tostring(cfg.showOnlyUpgrades), tostring(cfg.showTooltipLegend))

		if tooltipTable.itemLink then
			local _, id = strsplit(":", tooltipTable.itemLink)
			local itemID = tonumber(id) or -1

			text = text .. string.format("HoA level: %s\n\nTooltip:\nItem: %s (%s)\nItemlink: %s\nEffective ilvl: %d\nTraits and scores:\n", tooltipTable.currentLevel or "", tooltipTable.itemLink or "", itemID, string.gsub(tooltipTable.itemLink or "", "\124", "\124\124"), tooltipTable.scores and tooltipTable.scores.effectiveILvl or -1)

			for i, v in ipairs(tooltipTable) do
				text = text .. string.format("> Scale %d: %s\n", i, v.tooltipScale)

				for tierIndex, w in ipairs(v) do
					text = text .. string.format("   T%d (%d):\n     ", tierIndex, w.unlockLevel or -1)

					for azeritePowerID, score in pairs(w) do
						if type(azeritePowerID) == "number" then -- skip "unlockLevel"
							text = text .. string.format(" %d = %s ", azeritePowerID, tostring(score or -1))
						end
					end

					text = text .. "\n"
				end

				if tooltipTable.scores then
					text = text .. string.format("\nTrait Score: %s / %s / %s\n\n" , tostring(tooltipTable.scores[i].traitScore or ""), tostring(tooltipTable.scores[i].traitPotential or ""), tostring(tooltipTable.scores[i].traitMax or ""))

					if cfg.addILvlToScore then
						text = text .. string.format("Ilvl Score: %s / %s / %s\nMiddle Trait: %s (%d)\n\n" , tostring(tooltipTable.scores[i].ilvlScore or ""), tostring(tooltipTable.scores[i].ilvlPotential or ""), tostring(tooltipTable.scores[i].ilvlMax or ""), tostring(tooltipTable.scores[i].middleTraitValue or ""), tooltipTable.scores[i].midTrait or -1)
					end

					if cfg.addPrimaryStatToScore then
						text = text .. string.format("Stat Score: %s / %s / %s\nStat value: %d\n\n" , tostring(tooltipTable.scores[i].statScore or ""), tostring(tooltipTable.scores[i].statPotential or ""), tostring(tooltipTable.scores[i].statMax or ""), tooltipTable.scores[i].statAmount or -1)
					end
				end
			end
			text = text .. "- - - - - - - - - -\n"
		end

		if tooltipTable.equippedItemLink then
			if tooltipTable.itemLink and tooltipTable.itemLink ~= tooltipTable.equippedItemLink then
				local _, eid = strsplit(":", tooltipTable.equippedItemLink)
				local eItemID = tonumber(eid) or -1

				text = text .. string.format("Equipped for relative scores:\nItem: %s (%s)\nItemlink: %s\nEffective ilvl: %d\nTraits and scores:\n", tooltipTable.equippedItemLink or "", eItemID, string.gsub(tooltipTable.equippedItemLink or "", "\124", "\124\124"), tooltipTable.equippedEffectiveILvl or -1)

				for i, v in ipairs(tooltipTable) do
					text = text .. string.format("> Scale %d: %s\n", i, v.tooltipScale)

					if tooltipTable.scores then
						text = text .. string.format("Trait Score: %s / %s / %s\n\n" , tostring(tooltipTable.scores[i].relTraitScore or ""), tostring(tooltipTable.scores[i].relTraitPotential or ""), tostring(tooltipTable.scores[i].relTraitMax or ""))

						if cfg.addILvlToScore then
							text = text .. string.format("Ilvl Score: %s / %s / %s\nMiddle Trait: %s (%d)\n\n" , tostring(tooltipTable.scores[i].relIlvlScore or ""), tostring(tooltipTable.scores[i].relIlvlPotential or ""), tostring(tooltipTable.scores[i].relIlvlMax or ""), tostring(tooltipTable.scores[i].relMiddleTraitValue or ""), tooltipTable.scores[i].relMidTrait or -1)
						end

						if cfg.addPrimaryStatToScore then
							text = text .. string.format("Stat Score: %s / %s / %s\nStat value: %d\n\n" , tostring(tooltipTable.scores[i].relStatScore or ""), tostring(tooltipTable.scores[i].relStatPotential or ""), tostring(tooltipTable.scores[i].relStatMax or ""), tooltipTable.scores[i].relStatAmount or -1)
						end
					end
				end
			elseif not tooltipTable.itemLink then
				text = text .. "Equipped for relative scores:\nItem: Not found!\n"
			else
				text = text .. "Equipped for relative scores:\nItem: Same as in tooltip!\n"
			end

			text = text .. "- - - - - - - - - -\n"
		end

		text = text .. "> END"

	end,
	["is"] = function()
		local text = string.join("\n", ("> START\nVer. %s"):format("8.3.10"), unpack(importStack))
	end,
	["bang"] = function(...)
		local number = tonumber(...)
		Print("Bang:", number)
	end,
	["data"] = function()
		Print("Data check start")
		local numSpecs = {
			--		Base count		Healing
			--			TMI/Heal Off		Missing
			[1] =	3	+	1	-	0	-	0, -- Warrior (+1 for TMI)
			[2] =	3	+	1	-	1	-	0, -- Paladin (+1 for TMI, -1 for Holy)
			[3] =	3	+	0	-	0	-	0, -- Hunter
			[4] =	3	+	0	-	0	-	0, -- Rogue
			[5] =	3	+	0	-	2	-	0, -- Priest (-1 for Disc, -1 for Holy)
			[6] =	3	+	1	-	0	-	0, -- Death Knight (+1 for TMI)
			[7] =	3	+	1	-	1	-	0, -- Shaman (+1 for Resto Off, -1 for Resto)
			[8] =	3	+	0	-	0	-	0, -- Mage
			[9] =	3	+	0	-	0	-	0, -- Warlock
			[10] =	3	+	1	-	1	-	0, -- Monk (+1 for TMI, -1 for MW)
			[11] =	4	+	1	-	1	-	0, -- Druid (+1 for TMI, -1 for Resto)
			[12] =	2	+	1	-	0	-	0, -- Demon Hunter (+1 for TMI)
		}
		local emptySpecs = 6
		for _, v in ipairs(n.defaultScalesData) do
			if next(v[4]) or next(v[5]) then -- Check for not empty scales
				numSpecs[v[2]] = numSpecs[v[2]] - 1
			else
				emptySpecs = emptySpecs - 1
			end
		end
		for k, v in ipairs(numSpecs) do
			if v ~= 0 then
				Print("!!!", k, v)
			end
		end
		if emptySpecs ~= 0 then
			Print("Empty specs:", emptySpecs)
		end
		Print("Data check end")
	end,
	["test"] = function(...) -- To test new features
		Print("TEST")
	end,
}

local shouldKnowAboutConfig
SlashCmdList["AZERITEPOWERWEIGHTS"] = function(text)
	local command, params = strsplit(" ", text, 2)

	if SlashHandlers[command] then
		SlashHandlers[command](params)
	else
		if not shouldKnowAboutConfig then
			Print(U["Slash_RemindConfig"], "AzeritePowerWeights")
			shouldKnowAboutConfig = true
		end
		if not n.guiContainer then
			if not _G.AzeriteEmpoweredItemUI then
				local loaded, reason = LoadAddOn("Blizzard_AzeriteUI")
				if loaded then
					_toggleEditorUI()
				else
					Print(U["Slash_Error_Unkown"])
				end
			end
		else
			_toggleEditorUI()
		end
	end
end

--#EOF
