--## Author: Kreolix ## Version: 0.1
local CMH = {}

local DataTables = {}
DataTables.EffectType = {
    [0] = "仅适用于技能17",
    [1] = "击杀",
    [2] = "治愈",
    [3] = "击杀",
    [4] = "治愈",
    [7] = "DoT",
    [8] = "HoT",
    [9] = "嘲讽",
    [10] = "失去目标",
    [11] = "施于伤害倍数",
    [12] = "施于伤害倍数",
    [13] = "接受伤害倍数",
    [14] = "接受伤害倍数",
    [15] = "反射",
    [16] = "反射",
    [18] = "最大治疗倍数",
    [19] = "造成额外伤害",
    [20] = "额外受到伤害"
}

DataTables.EffectTypeEnum = {
    ["Unknown_0"] = 0,
    ["Damage"] = 1,
    ["Heal"] = 2,
    ["Damage_2"] = 3,
    ["Heal_2"] = 4,
    ["DoT"] = 7,
    ["HoT"] = 8,
    ["Taunt"] = 9,
    ["Untargetable"] = 10,
    ["DamageDealtMultiplier"] = 11,
    ["DamageDealtMultiplier_2"] = 12,
    ["DamageTakenMultiplier"] = 13,
    ["DamageTakenMultiplier_2"] = 14,
    ["Reflect"] = 15,
    ["Reflect_2"] = 16,
    ["MaxHPMultiplier"] = 18,
    ["AdditionalDamageDealt"] = 19,
    ["AdditionalTakenDamage"] = 20,
	["Died"] = 100,
	["ApplyAura"] = 105,
	["RemoveAura"] = 110
}

DataTables.TargetTypeEnum = {
    ["lastTarget"] = 0,
    ["self"] = 1,
    ["adjacentAlly"] = 2,
    ["closestEnemy"] = 3,
    ["furthestEnemy"] = 5,
    ["allAllies"] = 6,
    ["allEnemies"] = 7,
    ["allAdjacentAllies"] = 8,
    ["allAdjacentEnemies"] = 9,
    ["closestAllyCone"] = 10,
    ["closestEnemyCone"] = 11,
    ["closestEnemyLine"] = 13,
    ["frontLineAllies"] = 14,
    ["frontLineEnemies"] = 15,
    ["backLineAllies"] = 16,
    ["backLineEnemies"] = 17,
    ["randomEnemy_2"] = 19, -- ?
    ["randomEnemy"] = 20,
    ["randomAlly"] = 21,
    ["allAllies_2"] = 22,
    ["allAllies_3"] = 23,
    ["unknown"] = 24,
}

DataTables.EffectFlags = {
    [1] = "USE_ATTACK_FOR_POINTS",
    [2] = "EXTRA_INITIAL_PERIOD",
    [3] = "1+2"
}

DataTables.UnknownTargetType = {0, 24}

DataTables.TargetPriorityByType = {
    [1] = { -- self
        [0] = {0},
        [1] = {1},
        [2] = {2},
        [3] = {3},
        [4] = {4},
        [5] = {5},
        [6] = {6},
        [7] = {7},
        [8] = {8},
        [9] = {9},
        [10] = {10},
        [11] = {11},
        [12] = {12}
    },
    [2] = { -- adjacent ally
        [0] = {2, 3, 1, 4, 0},
        [1] = {0, 3, 4, 2, 1},
        [2] = {0, 3, 1, 4, 2},
        [3] = {2, 0, 1, 4, 3},
        [4] = {3, 1, 2, 0, 4},
        [5] = {9, 6, 10, 7, 11, 8, 12, 5}, -- not sure
        [6] = {5, 10, 7, 9, 11, 8, 12, 6}, -- not sure
        [7] = {6, 8, 11, 10, 12, 5, 9, 7}, -- not sure
        [8] = {7, 12, 10, 6, 11, 5, 9, 8}, -- not sure
        [9] = {5, 6, 10, 7, 11, 8, 12, 9}, -- not sure
        [10] = {6, 11, 9, 5, 7, 8, 12, 10}, -- not sure
        [11] = {10, 7, 12, 6, 8, 5, 9, 11}, -- not sure
        [12] = {8, 11, 7, 10, 6, 9, 5, 12} -- not sure
    },
    [3] =  { -- closest enemy
        [0] = {5, 6, 10, 7, 9, 11, 8, 12},
        [1] = {6, 7, 11, 8, 10, 12, 5, 9},
        [2] = {5, 6, 9, 10, 7, 11, 8, 12},
        [3] = {6, 7, 5, 10, 11, 8, 9, 12}, -- not sure
        [4] = {7, 8, 6, 11, 10, 12, 5, 9}, -- not sure
        [5] = {2, 0, 3, 1, 4},
        [6] = {2, 3, 0, 4, 1},
        [7] = {3, 4, 2, 0, 1},
        [8] = {4, 3, 1, 2, 0}, -- not sure
        [9] = {2, 3, 0, 1, 4},
        [10] = {2, 3, 4, 0, 1},
        [11] = {2, 3, 4, 0, 1},
        [12] = {3, 4, 1, 2, 0} -- not sure
    },
    [5] = { -- furthest enemy
        [0] = {12, 8, 9, 11, 10, 5, 7, 6},
        [1] = {9, 5, 10, 12, 11, 6, 8, 7}, -- not sure
        [2] = {12, 8, 11, 7, 9, 10, 5, 6},
        [3] = {9, 12, 5, 8, 10, 11, 6, 7},
        [4] = {9, 5, 10, 6, 11, 12, 7, 8},
        [5] = {4, 1, 3, 0, 2}, -- not sure
        [6] = {4, 1, 0, 2, 3},
        [7] = {2, 0, 1, 3, 4},
        [8] = {2, 0, 1, 3, 4},
        [9] = {4, 1, 0, 3, 2}, -- not sure
        [10] = {1, 0, 4, 2, 3}, -- not sure
        [11] = {0, 2, 1, 3, 4}, -- not sure
        [12] = {2, 0, 1, 3, 4} -- not sure
    }
}

-- adjacent allies indexes
DataTables.AdjacentAllies = {
    [0] = {2, 3, 1},
    [1] = {0, 3, 4},
    [2] = {0, 3},
    [3] = {0, 1, 2, 4},
    [4] = {1, 3},
    [5] = {6, 9, 10},
    [6] = {5, 9, 10, 11, 7},
    [7] = {6, 10, 11, 12, 8},
    [8] = {7, 11, 12},
    [9] = {5, 6, 10},
    [10] = {5, 6, 7, 9, 11},
    [11] = {6, 7, 8, 10, 12},
    [12] = {7, 8, 11}
}

DataTables.AdjacentEnemies = {
	[0] = {
		["blockerUnits"] = {5, 6},
		["aliveBlockerUnitGroup"] = {5, 6},
		["deadBlockerUnitGroup"] = {5, 7, 9, 10, 11},
		["aloneUnits"] = {8, 12}
	},
	[1] = {
		["blockerUnits"] = {7},
		["aliveBlockerUnitGroup"] = {6, 7},
		["deadBlockerUnitGroup"] = {6, 8, 10, 11, 12},
		["aloneUnits"] = {5, 9}
	},
	[2] = {
		["blockerUnits"] = {5, 6},
		["aliveBlockerUnitGroup"] = {5, 6},
		["deadBlockerUnitGroup"] = {7, 9, 10, 11},
		["aloneUnits"] = {8, 12}
	},
	[3] = {
		["blockerUnits"] = {6, 7},
		["aliveBlockerUnitGroup"] = {6, 7},
		["deadBlockerUnitGroup"] = {5, 7, 9, 10, 11},
		["aloneUnits"] = {8, 12}
	},
	[4] = {
		["blockerUnits"] = {7, 8},
		["aliveBlockerUnitGroup"] = {7, 8},
		["deadBlockerUnitGroup"] = {6, 10, 11, 12},
		["aloneUnits"] = {5, 9}
	},
	-- try to make more target for unproven data. Better predict false lose than false win
	[5] = {
		["blockerUnits"] = {2},
		["aliveBlockerUnitGroup"] = {2},
		["deadBlockerUnitGroup"] = {{0, 3}, {1, 4}},
		["aloneUnits"] = {}
	},
	[6] = {
		["blockerUnits"] = {2, 3},
		["aliveBlockerUnitGroup"] = {2, 3}, -- proved
		["deadBlockerUnitGroup"] = {0, 1, 2},
		["aloneUnits"] = {}
	}
	-- 6 -> 2,3. 7 -> 3,4.
	,
	[7] = {
		["blockerUnits"] = {3, 4},
		["aliveBlockerUnitGroup"] = {3, 4}, -- proved
		["deadBlockerUnitGroup"] = {0, 1, 2},
		["aloneUnits"] = {}
	},
	[8] = {
		["blockerUnits"] = {4},
		["aliveBlockerUnitGroup"] = {4},
		["deadBlockerUnitGroup"] = {{1, 3}, {0, 2}},
		["aloneUnits"] = {}
	},
	[9] = {
		["blockerUnits"] = {2},
		["aliveBlockerUnitGroup"] = {2},
		["deadBlockerUnitGroup"] = {{0, 3}, {1, 4}},
		["aloneUnits"] = {}
	},
	[10] = {
		["blockerUnits"] = {2, 3},
		["aliveBlockerUnitGroup"] = {2, 3},
		["deadBlockerUnitGroup"] = {0, 1, 2},
		["aloneUnits"] = {}
	}
	-- 6 -> 2,3. 7 -> 3,4.
	,
	[11] = {
		["blockerUnits"] = {3, 4},
		["aliveBlockerUnitGroup"] = {3, 4},
		["deadBlockerUnitGroup"] = {0, 1, 2},
		["aloneUnits"] = {}
	},
	[12] = {
		["blockerUnits"] = {4},
		["aliveBlockerUnitGroup"] = {4},
		["deadBlockerUnitGroup"] = {{1, 3}, {0, 2}},
		["aloneUnits"] = {}
	}
}

--TODO: test it
-- garrMission.ID = 2224
DataTables.ConeAllies = {
    [0] = {0},
    [1] = {1},
    [2] = {2},
    [3] = {3},
    [4] = {4},
    [5] = {5},
    [6] = {6},
    [7] = {7},
    [8] = {8},
    [9] = {9},
    [10] = {10},
    [11] = {11},
    [12] = {12}
}

-- key = main target, value = all targets
DataTables.ConeEnemies = {
    [0] = {0},
    [1] = {1},
    [2] = {2, 0},
    [3] = {3, 0, 1},
    [4] = {4, 1},
    [5] = {5, 9, 10},
    [6] = {6, 9, 10, 11},
    [7] = {7, 10, 11, 12},
    [8] = {8, 11, 12},
    [9] = {9},
    [10] = {10},
    [11] = {11},
    [12] = {12}
}

-- key = main target, value = all targets
DataTables.LineEnemies = {
    [0] = {0},
    [1] = {1},
    [2] = {2},
    [3] = {3},
    [4] = {4},
    [5] = {5, 9},
    [6] = {6, 10},
    [7] = {7, 11},
    [8] = {8, 12},
    [9] = {9},
    [10] = {10},
    [11] = {11},
    [12] = {12}
}

DataTables.startsOnCooldownSpells = {2, 68, 84, 85, 118, 139, 144, 152, 158, 163, 172, 181, 186, 228, 244, 247, 250, 254, 282, 285, 296}

-- Attack type isn't match with unit role
-- key = combatantID, value = attackType
DataTables.UnusualAttackType = {
	-- melee
	[1288] = 15, [3684889] = 15,
	-- ranged_physical
	[1323] = 11, [1324] = 11, [3852840] = 11, [3852830] = 11, [3852829] = 11, [3852831] = 11, [3852834] = 11,
	[3852908] = 11, [3580935] = 11,
	-- ranged_magic
	[175299] = 11, [3852909] = 11, [3852843] = 11, [3852835] = 11, [3583223] = 11,
	[3856480] = 11, [3921251] = 11, [175948] = 11,
	-- heal_support
	[3517256] = 11, [1212] = 11, [1258] = 11, [1311] = 11, [3852839] = 11, [3852877] = 11, [3852848] = 11,
	[3852889] = 11, [3485232] = 11, [165562] = 11, [3684894] = 11, [3852627] = 11
}

-- key - spellID, value - list of skill's effect ordered by EffectIndex
DataTables.SpellEffects = {
	[1] = {
		[1] = {
			['Points'] = 350,
			['SpellID'] = 1,
			['EffectIndex'] = 0,
			['TargetType'] = 24,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 1
		}
	},
	[2] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 2,
			['EffectIndex'] = 0,
			['TargetType'] = 22,
			['Period'] = 2,
			['Flags'] = 1,
			['Effect'] = 19,
			['ID'] = 2
		},
		[2] = {
			['Points'] = 1,
			['SpellID'] = 2,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 4,
			['ID'] = 120
		}
	},
	[3] = {
		[1] = {
			['Points'] = 45.2,
			['SpellID'] = 3,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 2,
			['ID'] = 3
		},
		[2] = {
			['Points'] = 90.4,
			['SpellID'] = 3,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 1,
			['ID'] = 4
		}
	},
	[4] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 4,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 7
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 4,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 8
		}
	},
	[5] = {
		[1] = {
			['Points'] = 0.1,
			['SpellID'] = 5,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 9
		}
	},
	[6] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 6,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 10
		}
	},
	[7] = {
		[1] = {
			['Points'] = 0.1,
			['SpellID'] = 7,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 11
		}
	},
	[8] = {
		[1] = {
			['Points'] = 10,
			['SpellID'] = 8,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 12
		}
	},
	[9] = {
		[1] = {
			['Points'] = 0.05,
			['SpellID'] = 9,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 4,
			['ID'] = 13
		}
	},
	[10] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 10,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 3,
			['ID'] = 14
		},
		[2] = {
			['Points'] = 0.03,
			['SpellID'] = 10,
			['EffectIndex'] = 1,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 7,
			['ID'] = 15
		},
		[3] = {
			['Points'] = 0.01,
			['SpellID'] = 10,
			['EffectIndex'] = 2,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 8,
			['ID'] = 16
		}
	},
	[11] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 11,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 17
		}
	},
	[12] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 12,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 18
		}
	},
	[13] = {
		[1] = {
			['Points'] = 10,
			['SpellID'] = 13,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 2,
			['ID'] = 19
		}
	},
	[14] = {
		[1] = {
			['Points'] = 0.1,
			['SpellID'] = 14,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 20
		}
	},
	[15] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 15,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 21
		}
	},
	[16] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 16,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 22
		}
	},
	[17] = {
		[1] = {
			['Points'] = 0.1,
			['SpellID'] = 17,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 23
		},
		[2] = {
			['Points'] = 1,
			['SpellID'] = 17,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 2,
			['ID'] = 24
		}
	},
	[18] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 18,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 26
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 18,
			['EffectIndex'] = 1,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 27
		},
		[3] = {
			['Points'] = 0.2,
			['SpellID'] = 18,
			['EffectIndex'] = 2,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 28
		}
	},
	[19] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 19,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 29
		}
	},
	[20] = {
		[1] = {
			['Points'] = 0.7,
			['SpellID'] = 20,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 30
		}
	},
	[21] = {
		[1] = {
			['Points'] = 0.15,
			['SpellID'] = 21,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 8,
			['ID'] = 31
		}
	},
	[22] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 22,
			['EffectIndex'] = 0,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 32
		},
		[2] = {
			['Points'] = 0.1,
			['SpellID'] = 22,
			['EffectIndex'] = 1,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 33
		}
	},
	[23] = {
		[1] = {
			['Points'] = 11,
			['SpellID'] = 23,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 10,
			['ID'] = 34
		},
		[2] = {
			['Points'] = 0.1,
			['SpellID'] = 23,
			['EffectIndex'] = 1,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 7,
			['ID'] = 92
		}
	},
	[24] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 24,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 35
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 24,
			['EffectIndex'] = 1,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 36
		}
	},
	[25] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 25,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 37
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 25,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 12,
			['ID'] = 38
		}
	},
	[26] = {
		[1] = {
			['Points'] = 0.25,
			['SpellID'] = 26,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 39
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 26,
			['EffectIndex'] = 1,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 18,
			['ID'] = 40
		}
	},
	[27] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 27,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 41
		}
	},
	[28] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 28,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 42
		}
	},
	[29] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 29,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 43
		}
	},
	[30] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 30,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 44
		}
	},
	[31] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 31,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 45
		}
	},
	[32] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 32,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 46
		}
	},
	[33] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 33,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 47
		}
	},
	[34] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 34,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 48
		}
	},
	[35] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 35,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 49
		}
	},
	[36] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 36,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 50
		}
	},
	[37] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 37,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 51
		}
	},
	[38] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 38,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 52
		}
	},
	[39] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 39,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 53
		}
	},
	[40] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 40,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 54
		}
	},
	[41] = {
		[1] = {
			['Points'] = 0.25,
			['SpellID'] = 41,
			['EffectIndex'] = 0,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 55
		}
	},
	[42] = {
		[1] = {
			['Points'] = 0.1,
			['SpellID'] = 42,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 16,
			['ID'] = 56
		}
	},
	[43] = {
		[1] = {
			['Points'] = 0.25,
			['SpellID'] = 43,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 57
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 43,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 58
		}
	},
	[44] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 44,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 59
		},
		[2] = {
			['Points'] = 0.25,
			['SpellID'] = 44,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 60
		}
	},
	[45] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 45,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 61
		},
		[2] = {
			['Points'] = 0.25,
			['SpellID'] = 45,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 62
		}
	},
	[46] = {
		[1] = {
			['Points'] = -0.1,
			['SpellID'] = 46,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 63
		},
		[2] = {
			['Points'] = -0.1,
			['SpellID'] = 46,
			['EffectIndex'] = 1,
			['TargetType'] = 16,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 64
		}
	},
	[47] = {
		[1] = {
			['Points'] = -0.2,
			['SpellID'] = 47,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 65
		}
	},
	[48] = {
		[1] = {
			['Points'] = 0,
			['SpellID'] = 48,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 10,
			['ID'] = 66
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 48,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 67
		}
	},
	[49] = {
		[1] = {
			['Points'] = 0.33,
			['SpellID'] = 49,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 68
		}
	},
	[50] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 50,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 69
		}
	},
	[51] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 51,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 70
		}
	},
	[52] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 52,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 71
		}
	},
	[53] = {
		[1] = {
			['Points'] = 0.1,
			['SpellID'] = 53,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 2,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 72
		},
		[2] = {
			['Points'] = -0.2,
			['SpellID'] = 53,
			['EffectIndex'] = 1,
			['TargetType'] = 7,
			['Period'] = 2,
			['Flags'] = 1,
			['Effect'] = 12,
			['ID'] = 73
		}
	},
	[54] = {
		[1] = {
			['Points'] = 0.45,
			['SpellID'] = 54,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 74
		},
		[2] = {
			['Points'] = 0.45,
			['SpellID'] = 54,
			['EffectIndex'] = 1,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 75
		}
	},
	[55] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 55,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 76
		}
	},
	[56] = {
		[1] = {
			['Points'] = 1.25,
			['SpellID'] = 56,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 77
		}
	},
	[57] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 57,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 78
		}
	},
	[58] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 58,
			['EffectIndex'] = 0,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 79
		}
	},
	[59] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 59,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 80
		}
	},
	[60] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 60,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 81
		}
	},
	[61] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 61,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 82
		}
	},
	[62] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 62,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 83
		}
	},
	[63] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 63,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 84
		},
		[2] = {
			['Points'] = -0.2,
			['SpellID'] = 63,
			['EffectIndex'] = 1,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 85
		}
	},
	[64] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 64,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 86
		}
	},
	[65] = {
		[1] = {
			['Points'] = 0.65,
			['SpellID'] = 65,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 87
		}
	},
	[66] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 66,
			['EffectIndex'] = 0,
			['TargetType'] = 13,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 88
		}
	},
	[67] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 67,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 89
		}
	},
	[68] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 68,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 90
		},
		[2] = {
			['Points'] = -0.8,
			['SpellID'] = 68,
			['EffectIndex'] = 1,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 91
		}
	},
	[69] = {
		[1] = {
			['Points'] = 50,
			['SpellID'] = 69,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 2,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 95
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 69,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 2,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 96
		},
		[3] = {
			['Points'] = 50,
			['SpellID'] = 69,
			['EffectIndex'] = 2,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 1,
			['ID'] = 97
		},
		[4] = {
			['Points'] = 0.2,
			['SpellID'] = 69,
			['EffectIndex'] = 3,
			['TargetType'] = 0,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 3,
			['ID'] = 98
		}
	},
	[71] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 71,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 2,
			['ID'] = 99
		}
	},
	[72] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 72,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 100
		},
		[2] = {
			['Points'] = 0.3,
			['SpellID'] = 72,
			['EffectIndex'] = 1,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 101
		}
	},
	[73] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 73,
			['EffectIndex'] = 0,
			['TargetType'] = 13,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 102
		}
	},
	[74] = {
		[1] = {
			['Points'] = -0.4,
			['SpellID'] = 74,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 103
		},
		[2] = {
			['Points'] = -0.4,
			['SpellID'] = 74,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 104
		}
	},
	[75] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 75,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 105
		}
	},
	[76] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 76,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 106
		}
	},
	[77] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 77,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 19,
			['ID'] = 107
		}
	},
	[78] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 78,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 108
		}
	},
	[79] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 79,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 109
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 79,
			['EffectIndex'] = 1,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 110
		}
	},
	[80] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 80,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 111
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 80,
			['EffectIndex'] = 1,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 112
		}
	},
	[81] = {
		[1] = {
			['Points'] = 3,
			['SpellID'] = 81,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 15,
			['ID'] = 113
		}
	},
	[82] = {
		[1] = {
			['Points'] = 0.25,
			['SpellID'] = 82,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 16,
			['ID'] = 114
		}
	},
	[83] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 83,
			['EffectIndex'] = 0,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 115
		}
	},
	[84] = {
		[1] = {
			['Points'] = -1,
			['SpellID'] = 84,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 116
		}
	},
	[85] = {
		[1] = {
			['Points'] = -50,
			['SpellID'] = 85,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 117
		}
	},
	[86] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 86,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 118
		}
	},
	[87] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 87,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 119
		}
	},
	[88] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 88,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 121
		},
		[2] = {
			['Points'] = 0.4,
			['SpellID'] = 88,
			['EffectIndex'] = 1,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 123
		}
	},
	[89] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 89,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 1,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 124
		}
	},
	[90] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 90,
			['EffectIndex'] = 0,
			['TargetType'] = 8,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 125
		}
	},
	[91] = {
		[1] = {
			['Points'] = -0.6,
			['SpellID'] = 91,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 11,
			['ID'] = 126
		}
	},
	[92] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 92,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 1,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 127
		}
	},
	[93] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 93,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 128
		},
		[2] = {
			['Points'] = 0.8,
			['SpellID'] = 93,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 129
		}
	},
	[94] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 94,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 1,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 130
		}
	},
	[95] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 95,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 131
		},
		[2] = {
			['Points'] = 0.3,
			['SpellID'] = 95,
			['EffectIndex'] = 1,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 132
		}
	},
	[96] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 96,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 133
		},
		[2] = {
			['Points'] = -0.2,
			['SpellID'] = 96,
			['EffectIndex'] = 1,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 134
		}
	},
	[97] = {
		[1] = {
			['Points'] = 0.9,
			['SpellID'] = 97,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 135
		}
	},
	[98] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 98,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 136
		}
	},
	[99] = {
		[1] = {
			['Points'] = 1.4,
			['SpellID'] = 99,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 137
		}
	},
	[100] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 100,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 138
		}
	},
	[101] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 101,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 139
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 101,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 140
		}
	},
	[102] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 102,
			['EffectIndex'] = 0,
			['TargetType'] = 13,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 141
		}
	},
	[103] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 103,
			['EffectIndex'] = 0,
			['TargetType'] = 22,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 142
		}
	},
	[104] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 104,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 2,
			['ID'] = 143
		},
		[2] = {
			['Points'] = -0.1,
			['SpellID'] = 104,
			['EffectIndex'] = 1,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 144
		}
	},
	[105] = {
		[1] = {
			['Points'] = -0.1,
			['SpellID'] = 105,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 145
		}
	},
	[106] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 106,
			['EffectIndex'] = 0,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 146
		}
	},
	[107] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 107,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 147
		},
		[2] = {
			['Points'] = 0.3,
			['SpellID'] = 107,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 3,
			['Effect'] = 20,
			['ID'] = 148
		}
	},
	[108] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 108,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 149
		},
		[2] = {
			['Points'] = 0.1,
			['SpellID'] = 108,
			['EffectIndex'] = 1,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 2,
			['Effect'] = 18,
			['ID'] = 150
		}
	},
	[109] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 109,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 16,
			['ID'] = 151
		}
	},
	[110] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 110,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 152
		}
	},
	[111] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 111,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 153
		}
	},
	[112] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 112,
			['EffectIndex'] = 0,
			['TargetType'] = 8,
			['Period'] = 0,
			['Flags'] = 3,
			['Effect'] = 19,
			['ID'] = 154
		}
	},
	[113] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 113,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 155
		}
	},
	[114] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 114,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 2,
			['ID'] = 156
		}
	},
	[115] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 115,
			['EffectIndex'] = 0,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 157
		}
	},
	[116] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 116,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 158
		}
	},
	[117] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 117,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 159
		}
	},
	[118] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 118,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 160
		}
	},
	[119] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 119,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 161
		}
	},
	[120] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 120,
			['EffectIndex'] = 0,
			['TargetType'] = 20,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 12,
			['ID'] = 162
		}
	},
	[121] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 121,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 12,
			['ID'] = 163
		}
	},
	[122] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 122,
			['EffectIndex'] = 0,
			['TargetType'] = 21,
			['Period'] = 3,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 164
		}
	},
	[123] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 123,
			['EffectIndex'] = 0,
			['TargetType'] = 14,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 165
		}
	},
	[124] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 124,
			['EffectIndex'] = 0,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 166
		}
	},
	[125] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 125,
			['EffectIndex'] = 0,
			['TargetType'] = 20,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 167
		},
		[2] = {
			['Points'] = -0.5,
			['SpellID'] = 125,
			['EffectIndex'] = 1,
			['TargetType'] = 0,
			['Period'] = 1,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 168
		}
	},
	[126] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 126,
			['EffectIndex'] = 0,
			['TargetType'] = 14,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 169
		}
	},
	[127] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 127,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 170
		}
	},
	[128] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 128,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 171
		}
	},
	[129] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 129,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 172
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 129,
			['EffectIndex'] = 1,
			['TargetType'] = 6,
			['Period'] = 1,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 173
		}
	},
	[130] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 130,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 16,
			['ID'] = 174
		}
	},
	[131] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 131,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 175
		}
	},
	[132] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 132,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 176
		},
		[2] = {
			['Points'] = -0.25,
			['SpellID'] = 132,
			['EffectIndex'] = 1,
			['TargetType'] = 15,
			['Period'] = 1,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 177
		}
	},
	[133] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 133,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 178
		},
		[2] = {
			['Points'] = 0.75,
			['SpellID'] = 133,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 179
		}
	},
	[134] = {
		[1] = {
			['Points'] = 0.25,
			['SpellID'] = 134,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 14,
			['ID'] = 180
		}
	},
	[135] = {
		[1] = {
			['Points'] = 3,
			['SpellID'] = 135,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 181
		}
	},
	[136] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 136,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 3,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 182
		}
	},
	[137] = {
		[1] = {
			['Points'] = 0.25,
			['SpellID'] = 137,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 183
		}
	},
	[138] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 138,
			['EffectIndex'] = 0,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 184
		}
	},
	[139] = {
		[1] = {
			['Points'] = 4,
			['SpellID'] = 139,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 185
		}
	},
	[140] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 140,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 186
		},
		[2] = {
			['Points'] = -0.1,
			['SpellID'] = 140,
			['EffectIndex'] = 1,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 187
		}
	},
	[141] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 141,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 188
		}
	},
	[142] = {
		[1] = {
			['Points'] = 0.7,
			['SpellID'] = 142,
			['EffectIndex'] = 0,
			['TargetType'] = 10,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 189
		}
	},
	[143] = {
		[1] = {
			['Points'] = 0.25,
			['SpellID'] = 143,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 2,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 190
		}
	},
	[144] = {
		[1] = {
			['Points'] = -0.75,
			['SpellID'] = 144,
			['EffectIndex'] = 0,
			['TargetType'] = 22,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 191
		}
	},
	[145] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 145,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 192
		}
	},
	[146] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 146,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 193
		}
	},
	[147] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 147,
			['EffectIndex'] = 0,
			['TargetType'] = 22,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 194
		}
	},
	[148] = {
		[1] = {
			['Points'] = 1.25,
			['SpellID'] = 148,
			['EffectIndex'] = 0,
			['TargetType'] = 14,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 195
		}
	},
	[149] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 149,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 196
		}
	},
	[150] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 150,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 197
		}
	},
	[151] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 151,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 198
		}
	},
	[152] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 152,
			['EffectIndex'] = 0,
			['TargetType'] = 22,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 199
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 152,
			['EffectIndex'] = 1,
			['TargetType'] = 22,
			['Period'] = 1,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 200
		}
	},
	[153] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 153,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 201
		}
	},
	[154] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 154,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 16,
			['ID'] = 202
		}
	},
	[155] = {
		[1] = {
			['Points'] = -0.75,
			['SpellID'] = 155,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 203
		}
	},
	[156] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 156,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 204
		}
	},
	[157] = {
		[1] = {
			['Points'] = 0.8,
			['SpellID'] = 157,
			['EffectIndex'] = 0,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 205
		}
	},
	[158] = {
		[1] = {
			['Points'] = 3,
			['SpellID'] = 158,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 206
		}
	},
	[159] = {
		[1] = {
			['Points'] = -0.25,
			['SpellID'] = 159,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 2,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 207
		}
	},
	[160] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 160,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 208
		}
	},
	[161] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 161,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 209
		},
		[2] = {
			['Points'] = 0.25,
			['SpellID'] = 161,
			['EffectIndex'] = 1,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 210
		}
	},
	[162] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 162,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 211
		}
	},
	[163] = {
		[1] = {
			['Points'] = 4,
			['SpellID'] = 163,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 212
		}
	},
	[164] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 164,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 3,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 213
		}
	},
	[165] = {
		[1] = {
			['Points'] = 3,
			['SpellID'] = 165,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 214
		}
	},
	[166] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 166,
			['EffectIndex'] = 0,
			['TargetType'] = 21,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 215
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 166,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 216
		}
	},
	[167] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 167,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 217
		}
	},
	[168] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 168,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 218
		}
	},
	[169] = {
		[1] = {
			['Points'] = 0.65,
			['SpellID'] = 169,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 219
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 169,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 3,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 220
		}
	},
	[170] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 170,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 221
		}
	},
	[171] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 171,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 222
		}
	},
	[172] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 172,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 223
		},
		[2] = {
			['Points'] = -0.5,
			['SpellID'] = 172,
			['EffectIndex'] = 1,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 224
		}
	},
	[173] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 173,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 225
		},
		[2] = {
			['Points'] = -0.25,
			['SpellID'] = 173,
			['EffectIndex'] = 1,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 226
		}
	},
	[174] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 174,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 16,
			['ID'] = 227
		}
	},
	[175] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 175,
			['EffectIndex'] = 0,
			['TargetType'] = 19,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 228
		}
	},
	[176] = {
		[1] = {
			['Points'] = 0.25,
			['SpellID'] = 176,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 229
		}
	},
	[177] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 177,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 230
		}
	},
	[178] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 178,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 231
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 178,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 232
		}
	},
	[179] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 179,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 233
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 179,
			['EffectIndex'] = 1,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 234
		}
	},
	[180] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 180,
			['EffectIndex'] = 0,
			['TargetType'] = 20,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 235
		}
	},
	[181] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 181,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 236
		}
	},
	[182] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 182,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 237
		}
	},
	[183] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 183,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 238
		}
	},
	[184] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 184,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 239
		}
	},
	[185] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 185,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 240
		}
	},
	[186] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 186,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 241
		}
	},
	[187] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 187,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 2,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 242
		}
	},
	[188] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 188,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 243
		},
		[2] = {
			['Points'] = -0.5,
			['SpellID'] = 188,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 244
		}
	},
	[189] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 189,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 245
		}
	},
	[190] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 190,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 246
		}
	},
	[191] = {
		[1] = {
			['Points'] = 0.2,
			['SpellID'] = 191,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 1,
			['ID'] = 247
		},
		[2] = {
			['Points'] = 0.1,
			['SpellID'] = 191,
			['EffectIndex'] = 1,
			['TargetType'] = 6,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 2,
			['ID'] = 248
		}
	},
	[192] = {
		[1] = {
			['Points'] = 1.6,
			['SpellID'] = 192,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 249
		}
	},
	[193] = {
		[1] = {
			['Points'] = 3,
			['SpellID'] = 193,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 250
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 193,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 251
		}
	},
	[194] = {
		[1] = {
			['Points'] = 0.4,
			['SpellID'] = 194,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 19,
			['ID'] = 252
		},
		[2] = {
			['Points'] = -0.2,
			['SpellID'] = 194,
			['EffectIndex'] = 1,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 14,
			['ID'] = 253
		},
		[3] = {
			['Points'] = 0.2,
			['SpellID'] = 194,
			['EffectIndex'] = 2,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 254
		}
	},
	[195] = {
		[1] = {
			['Points'] = 0.8,
			['SpellID'] = 195,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 1,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 255
		}
	},
	[196] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 196,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 256
		},
		[2] = {
			['Points'] = 0.9,
			['SpellID'] = 196,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 257
		},
		[3] = {
			['Points'] = 0.6,
			['SpellID'] = 196,
			['EffectIndex'] = 2,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 258
		},
		[4] = {
			['Points'] = 0.3,
			['SpellID'] = 196,
			['EffectIndex'] = 3,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 259
		}
	},
	[197] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 197,
			['EffectIndex'] = 0,
			['TargetType'] = 8,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 260
		}
	},
	[198] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 198,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 13,
			['ID'] = 261
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 198,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 16,
			['ID'] = 262
		}
	},
	[199] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 199,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 263
		}
	},
	[200] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 200,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 264
		},
		[2] = {
			['Points'] = -0.5,
			['SpellID'] = 200,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 1,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 265
		}
	},
	[201] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 201,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 266
		}
	},
	[202] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 202,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 9,
			['ID'] = 267
		}
	},
	[203] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 203,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 268
		}
	},
	[204] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 204,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 269
		},
		[2] = {
			['Points'] = -0.5,
			['SpellID'] = 204,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 2,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 270
		}
	},
	[205] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 205,
			['EffectIndex'] = 0,
			['TargetType'] = 14,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 271
		}
	},
	[206] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 206,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 272
		}
	},
	[207] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 207,
			['EffectIndex'] = 0,
			['TargetType'] = 13,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 273
		}
	},
	[208] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 208,
			['EffectIndex'] = 0,
			['TargetType'] = 21,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 9,
			['ID'] = 274
		}
	},
	[209] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 209,
			['EffectIndex'] = 0,
			['TargetType'] = 21,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 275
		}
	},
	[210] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 210,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 276
		}
	},
	[211] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 211,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 277
		}
	},
	[212] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 212,
			['EffectIndex'] = 0,
			['TargetType'] = 19,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 278
		}
	},
	[213] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 213,
			['EffectIndex'] = 0,
			['TargetType'] = 10,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 279
		}
	},
	[214] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 214,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 280
		}
	},
	[215] = {
		[1] = {
			['Points'] = 3,
			['SpellID'] = 215,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 281
		}
	},
	[216] = {
		[1] = {
			['Points'] = 3,
			['SpellID'] = 216,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 10,
			['ID'] = 282
		}
	},
	[217] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 217,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 283
		}
	},
	[218] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 218,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 284
		}
	},
	[219] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 219,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 285
		},
		[2] = {
			['Points'] = -0.5,
			['SpellID'] = 219,
			['EffectIndex'] = 1,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 286
		}
	},
	[220] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 220,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 287
		}
	},
	[221] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 221,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 10,
			['ID'] = 288
		}
	},
	[222] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 222,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 289
		},
		[2] = {
			['Points'] = 0.3,
			['SpellID'] = 222,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 2,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 290
		}
	},
	[223] = {
		[1] = {
			['Points'] = 0.1,
			['SpellID'] = 223,
			['EffectIndex'] = 0,
			['TargetType'] = 23,
			['Period'] = 1,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 291
		}
	},
	[224] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 224,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 292
		}
	},
	[225] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 225,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 293
		}
	},
	[226] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 226,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 294
		}
	},
	[227] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 227,
			['EffectIndex'] = 0,
			['TargetType'] = 20,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 3,
			['ID'] = 295
		}
	},
	[228] = {
		[1] = {
			['Points'] = 10,
			['SpellID'] = 228,
			['EffectIndex'] = 0,
			['TargetType'] = 23,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 296
		}
	},
	[229] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 229,
			['EffectIndex'] = 0,
			['TargetType'] = 21,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 297
		}
	},
	[230] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 230,
			['EffectIndex'] = 0,
			['TargetType'] = 24,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 298
		}
	},
	[231] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 231,
			['EffectIndex'] = 0,
			['TargetType'] = 20,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 299
		}
	},
	[232] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 232,
			['EffectIndex'] = 0,
			['TargetType'] = 20,
			['Period'] = 3,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 300
		}
	},
	[233] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 233,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 301
		}
	},
	[234] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 234,
			['EffectIndex'] = 0,
			['TargetType'] = 21,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 302
		}
	},
	[235] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 235,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 303
		}
	},
	[236] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 236,
			['EffectIndex'] = 0,
			['TargetType'] = 6,
			['Period'] = 2,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 304
		}
	},
	[237] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 237,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 305
		}
	},
	[238] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 238,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 9,
			['ID'] = 306
		}
	},
	[239] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 239,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 307
		}
	},
	[240] = {
		[1] = {
			['Points'] = 0.25,
			['SpellID'] = 240,
			['EffectIndex'] = 0,
			['TargetType'] = 13,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 308
		}
	},
	[241] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 241,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 309
		},
		[2] = {
			['Points'] = -0.5,
			['SpellID'] = 241,
			['EffectIndex'] = 1,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 310
		}
	},
	[242] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 242,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 311
		},
		[2] = {
			['Points'] = 0.75,
			['SpellID'] = 242,
			['EffectIndex'] = 1,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 312
		}
	},
	[243] = {
		[1] = {
			['Points'] = 0,
			['SpellID'] = 243,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 9,
			['ID'] = 313
		},
		[2] = {
			['Points'] = -0.5,
			['SpellID'] = 243,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 314
		}
	},
	[244] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 244,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 19,
			['ID'] = 315
		},
		[2] = {
			['Points'] = 0.3,
			['SpellID'] = 244,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 20,
			['ID'] = 316
		},
		[3] = {
			['Points'] = 0.3,
			['SpellID'] = 244,
			['EffectIndex'] = 2,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 317
		}
	},
	[245] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 245,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 318
		}
	},
	[246] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 246,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 319
		}
	},
	[247] = {
		[1] = {
			['Points'] = 0.1,
			['SpellID'] = 247,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 320
		},
		[2] = {
			['Points'] = 0.2,
			['SpellID'] = 247,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 321
		}
	},
	[248] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 248,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 322
		},
		[2] = {
			['Points'] = 0.15,
			['SpellID'] = 248,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 1,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 323
		}
	},
	[249] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 249,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 324
		},
		[2] = {
			['Points'] = -0.5,
			['SpellID'] = 249,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 325
		}
	},
	[250] = {
		[1] = {
			['Points'] = 0.8,
			['SpellID'] = 250,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 326
		}
	},
	[251] = {
		[1] = {
			['Points'] = -0.2,
			['SpellID'] = 251,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 327
		}
	},
	[252] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 252,
			['EffectIndex'] = 0,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 328
		},
		[2] = {
			['Points'] = 0.25,
			['SpellID'] = 252,
			['EffectIndex'] = 1,
			['TargetType'] = 9,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 329
		}
	},
	[253] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 253,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 330
		}
	},
	[254] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 254,
			['EffectIndex'] = 0,
			['TargetType'] = 22,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 16,
			['ID'] = 331
		}
	},
	[255] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 255,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 332
		}
	},
	[256] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 256,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 333
		}
	},
	[257] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 257,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 10,
			['ID'] = 334
		}
	},
	[258] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 258,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 335
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 258,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 3,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 336
		}
	},
	[259] = {
		[1] = {
			['Points'] = 0.3,
			['SpellID'] = 259,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 3,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 337
		}
	},
	[260] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 260,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 3,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 338
		}
	},
	[261] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 261,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 339
		}
	},
	[262] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 262,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 340
		}
	},
	[263] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 263,
			['EffectIndex'] = 0,
			['TargetType'] = 11,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 341
		}
	},
	[264] = {
		[1] = {
			['Points'] = 3,
			['SpellID'] = 264,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 342
		}
	},
	[265] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 265,
			['EffectIndex'] = 0,
			['TargetType'] = 13,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 343
		}
	},
	[266] = {
		[1] = {
			['Points'] = 10,
			['SpellID'] = 266,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 344
		}
	},
	[267] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 267,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 345
		}
	},
	[268] = {
		[1] = {
			['Points'] = -0.3,
			['SpellID'] = 268,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 346
		}
	},
	[269] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 269,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 347
		}
	},
	[270] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 270,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 348
		}
	},
	[271] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 271,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 349
		}
	},
	[272] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 272,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 350
		}
	},
	[273] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 273,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 351
		}
	},
	[274] = {
		[1] = {
			['Points'] = 1.2,
			['SpellID'] = 274,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 352
		}
	},
	[275] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 275,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 353
		}
	},
	[276] = {
		[1] = {
			['Points'] = 0.25,
			['SpellID'] = 276,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 354
		},
		[2] = {
			['Points'] = 0.5,
			['SpellID'] = 276,
			['EffectIndex'] = 1,
			['TargetType'] = 5,
			['Period'] = 3,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 355
		}
	},
	[277] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 277,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 356
		}
	},
	[278] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 278,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 357
		}
	},
	[279] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 279,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 358
		}
	},
	[280] = {
		[1] = {
			['Points'] = 2.5,
			['SpellID'] = 280,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 359
		}
	},
	[281] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 281,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 3,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 360
		}
	},
	[282] = {
		[1] = {
			['Points'] = 10,
			['SpellID'] = 282,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 361
		}
	},
	[283] = {
		[1] = {
			['Points'] = 0.75,
			['SpellID'] = 283,
			['EffectIndex'] = 0,
			['TargetType'] = 13,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 362
		}
	},
	[284] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 284,
			['EffectIndex'] = 0,
			['TargetType'] = 22,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 363
		}
	},
	[285] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 285,
			['EffectIndex'] = 0,
			['TargetType'] = 7,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 364
		}
	},
	[286] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 286,
			['EffectIndex'] = 0,
			['TargetType'] = 2,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 12,
			['ID'] = 365
		}
	},
	[287] = {
		[1] = {
			['Points'] = -0.5,
			['SpellID'] = 287,
			['EffectIndex'] = 0,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 366
		}
	},
	[288] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 288,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 367
		}
	},
	[289] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 289,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 3,
			['Flags'] = 3,
			['Effect'] = 7,
			['ID'] = 368
		}
	},
	[290] = {
		[1] = {
			['Points'] = 1.5,
			['SpellID'] = 290,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 3,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 369
		}
	},
	[291] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 291,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 3,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 370
		}
	},
	[292] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 292,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 371
		},
		[2] = {
			['Points'] = 0.75,
			['SpellID'] = 292,
			['EffectIndex'] = 1,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 372
		}
	},
	[293] = {
		[1] = {
			['Points'] = 0.6,
			['SpellID'] = 293,
			['EffectIndex'] = 0,
			['TargetType'] = 15,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 373
		}
	},
	[294] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 294,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 374
		}
	},
	[295] = {
		[1] = {
			['Points'] = 0.5,
			['SpellID'] = 295,
			['EffectIndex'] = 0,
			['TargetType'] = 3,
			['Period'] = 2,
			['Flags'] = 0,
			['Effect'] = 14,
			['ID'] = 375
		}
	},
	[296] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 296,
			['EffectIndex'] = 0,
			['TargetType'] = 17,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 376
		}
	},
	[297] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 297,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 377
		},
		[2] = {
			['Points'] = 0.3,
			['SpellID'] = 297,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 378
		}
	},
	[298] = {
		[1] = {
			['Points'] = 1,
			['SpellID'] = 298,
			['EffectIndex'] = 0,
			['TargetType'] = 21,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 379
		},
		[2] = {
			['Points'] = 0.3,
			['SpellID'] = 298,
			['EffectIndex'] = 1,
			['TargetType'] = 1,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 4,
			['ID'] = 380
		}
	},
	[299] = {
		[1] = {
			['Points'] = 2,
			['SpellID'] = 299,
			['EffectIndex'] = 0,
			['TargetType'] = 5,
			['Period'] = 0,
			['Flags'] = 1,
			['Effect'] = 3,
			['ID'] = 381
		}
	},
	[300] = {
		[1] = {
			['Points'] = 0.05,
			['SpellID'] = 300,
			['EffectIndex'] = 0,
			['TargetType'] = 23,
			['Period'] = 1,
			['Flags'] = 1,
			['Effect'] = 7,
			['ID'] = 383
		}
	},
	[301] = {
		[1] = {
			['Points'] = 0.1,
			['SpellID'] = 301,
			['EffectIndex'] = 0,
			['TargetType'] = 20,
			['Period'] = 0,
			['Flags'] = 0,
			['Effect'] = 3,
			['ID'] = 384
		}
	}
}

CMH.DataTables = DataTables

local hooksecurefunc = _G["hooksecurefunc"]

MissionHelper = CreateFrame("Frame", "MissionHelper", UIParent)
MissionHelper.isLoaded = false

function MissionHelper:ADDON_LOADED(event, addon)
    if addon == "Blizzard_GarrisonUI" then
        if self.isLoaded then return end
        hooksecurefunc(_G["CovenantMissionFrame"], "SetupTabs", self.hookSetupTabs)
        self.isLoaded = true
    end
end

function MissionHelper:hookShowMission(...)
    --print('hook show mission')
    MissionHelper:clearFrames()
    MissionHelper.missionHelperFrame:Show()
    local isCompletedMission = CovenantMissionFrame:GetMissionPage().missionInfo == nil
    local board = MissionHelper:simulateFight(isCompletedMission)
    MissionHelper:showResult(board)
    return ...
end

local function setBoard(isCalcRandom)
    local missionPage = CovenantMissionFrame:GetMissionPage()
    --TODO: always show health
    missionPage.Board:ShowHealthValues()
    local board = CMH.Board:new(missionPage, isCalcRandom)
    MissionHelper.missionHelperFrame.board = board
    return board
end

function MissionHelper:simulateFight(isCalcRandom)
    if isCalcRandom == nil then isCalcRandom = true end

    local board = setBoard(isCalcRandom)
    board:simulate()

    board.CombatLog = CMH.Board.CombatLog
    board.HiddenCombatLog = CMH.Board.HiddenCombatLog
    board.CombatLogEvents = CMH.Board.CombatLogEvents
    return board

    --[[ TODO: board after fight
        HP after fight = CovenantMissionFrame.MissionComplete.Board.framesByBoardIndex.HealthBar.health
    --]]
end

function MissionHelper:findBestDisposition()
    local missionPage = CovenantMissionFrame:GetMissionPage()
    local metaBoard = CMH.MetaBoard:new(missionPage, false)

    MissionHelper:clearBoard(missionPage)
    MissionHelper.missionHelperFrame.board = metaBoard:findBestDisposition()

    for _, unit in pairs(MissionHelper.missionHelperFrame.board.units) do
        if unit.boardIndex < 5 then
            local followerInfo = C_Garrison.GetFollowerInfo(unit.followerGUID)
            followerInfo.autoCombatSpells = C_Garrison.GetFollowerAutoCombatSpells(unit.followerGUID, followerInfo.level);
            CovenantMissionFrame:AssignFollowerToMission(missionPage.Board:GetFrameByBoardIndex(unit.boardIndex), followerInfo)
        end
    end

    MissionHelper:showResult(MissionHelper.missionHelperFrame.board)
end

function MissionHelper:showResult(board)
    --print('hook show result')
    local combatLogMessageFrame = MissionHelper.missionHelperFrame.combatLogFrame.CombatLogMessageFrame
    local combat_log = false and CMH.Board.HiddenCombatLog or CMH.Board.CombatLog

    MissionHelper:setResultHeader(board:constructResultString())
    MissionHelper:setResultInfo(board:getMyTeam())
    for _, text in ipairs(combat_log) do MissionHelper:AddCombatLogMessage(text) end
    MissionHelper:AddCombatLogMessage(board:constructResultString())

    if CovenantMissionFrame:GetMissionPage().missionInfo ~= nil then -- open mission, not completed
        if board.hasRandomSpells then
            MissionHelper:showPredictButton()
            MissionHelper:hideBestDispositionButton()
        else
            MissionHelper:hidePredictButton()
            MissionHelper:showBestDispositionButton()
        end
    else
        MissionHelper:hidePredictButton()
        MissionHelper:hideBestDispositionButton()
    end

    combatLogMessageFrame.ScrollBar:SetMinMaxValues(0, combatLogMessageFrame:GetNumMessages())
    combatLogMessageFrame:SetScrollOffset(
            math.max(
                    combatLogMessageFrame:GetNumMessages() - math.floor(combatLogMessageFrame:GetNumVisibleLines() / 2),
                    0))
end

function MissionHelper:hookShowRewardScreen(...)
    --print('hook show reward screen')
    local board = MissionHelper.missionHelperFrame.board
    if board.hasRandomSpells then
        return
    end

    board.blizzardLog = _G["CovenantMissionFrame"].MissionComplete.autoCombatResult.combatLog
    -- TODO: fix it
    -- my events log cleared somewhere. run it another time to compare blizz and my log
    --board:simulate()
    --board.CombatLogEvents = CMH.Board.CombatLogEvents
    board.compareLogs = MissionHelper:compareLogs(board.CombatLogEvents, board.blizzardLog)
end

function MissionHelper:clearBoard(missionPage)
    for followerFrame in missionPage.Board:EnumerateFollowers() do
		local followerGUID = followerFrame:GetFollowerGUID();
		if followerGUID then
			C_Garrison.RemoveFollowerFromMission(missionPage.missionInfo.missionID, followerGUID, followerFrame.boardIndex)
            followerFrame:SetEmpty()
		end
	end
end

function MissionHelper:hookCloseMission(...)
    --print('hook close mission')
    MissionHelper:clearFrames()
    MissionHelper.missionHelperFrame:Hide()
    return ...
end

local function registerHook(...)
    hooksecurefunc(_G["CovenantMissionFrame"], "InitiateMissionCompletion", MissionHelper.hookShowMission)
    hooksecurefunc(_G["CovenantMissionFrame"], "UpdateAllyPower", MissionHelper.hookShowMission)
    hooksecurefunc(_G["CovenantMissionFrame"].MissionComplete, "ShowRewardsScreen", MissionHelper.hookShowRewardScreen)
    hooksecurefunc(_G["CovenantMissionFrame"], "CloseMission", MissionHelper.hookCloseMission)
    hooksecurefunc(_G["CovenantMissionFrame"], "CloseMissionComplete", MissionHelper.hookCloseMission)
    hooksecurefunc(_G["CovenantMissionFrame"], "Hide", MissionHelper.hookCloseMission)
end

function MissionHelper:hookSetupTabs(...)
    registerHook(...)
    MissionHelper:editDefaultFrame(...)
    MissionHelper:createMissionHelperFrame(...)

    return ...
end

function MissionHelper:updateText(frame, newText)
    frame:AddMessage(newText)
end

MissionHelper:RegisterEvent("ADDON_LOADED")
MissionHelper:SetScript("OnEvent", MissionHelper.ADDON_LOADED)

function CMH:log(msg)
    table.insert(CMH.Board.CombatLog, msg)
    table.insert(CMH.Board.HiddenCombatLog, msg)
end

function CMH:debug_log(msg)
    table.insert(CMH.Board.HiddenCombatLog, msg)
end


local SIMULATE_ITERATIONS = 100
local MAX_ROUNDS = 100
local MAX_RANDOM_ROUNDS = 50
local LVL_UP_ICON = "|TInterface\\petbattles\\battlebar-abilitybadge-strong-small:0|t"
local SKULL_ICON = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t"

local Board = {Errors = {}, CombatLog = {}, HiddenCombatLog = {}, CombatLogEvents = {}}
local TargetTypeEnum, EffectTypeEnum = CMH.DataTables.TargetTypeEnum, CMH.DataTables.EffectTypeEnum

local function arrayForPrint(array)
    if not array then
        for _, text in ipairs(CMH.Board.CombatLog) do print(text) end
        return 'EMPTY ARRAY'
    end
    local result = ''
    for _, e in pairs(array) do
        result = result .. tostring(e) .. ', '
    end
    return result
end

local function copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return res
end

local function isAura(effectType)
    return effectType >= EffectTypeEnum.DoT and effectType <= EffectTypeEnum.AdditionalTakenDamage
end

function Board:new(missionPage, isCalcRandom)
    local newObj = {
        units = {},
        hasRandomSpells = false,
        probability = 100,
        isMissionOver = false,
        isEmpty = true,
        initialAlliesHP = 0,
        initialEnemiesHP = 0,
        isCalcRandom = isCalcRandom,
        max_rounds = MAX_ROUNDS,
        baseXP = 0,
        winXP = 0,
        --missionPage = missionPage,
    }
    local isCompletedMission = (missionPage.missionInfo == nil)
    local missionInfo = isCompletedMission and _G["CovenantMissionFrame"].MissionComplete.currentMission or missionPage.missionInfo

    newObj.missionID = missionInfo.missionID
    newObj.baseXP = missionInfo.xp
    newObj.winXP = newObj.baseXP
    for _, reward in pairs (missionInfo.rewards) do
        if reward.followerXP then
            newObj.winXP = newObj.winXP + reward.followerXP
        end
    end

    -- set enemy's units
    local enemies = C_Garrison.GetMissionCompleteEncounters(newObj.missionID)
    for i = 1, #enemies do
        local enemyUnit = CMH.Unit:new(enemies[i])
        --SELECTED_CHAT_FRAME:AddMessage("enemyUnitName = " .. enemyUnit.name)
        newObj.units[enemyUnit.boardIndex] = enemyUnit
        newObj.initialEnemiesHP = newObj.initialEnemiesHP + enemyUnit.currentHealth
    end

    --set my team
    -- If completed mission have < 5 followers, "empty" frames isn't empty actually.
    -- It saved from last completed mission.
    local framesByBoardIndex, boardIndexes = {}, {}
    if isCompletedMission then
        -- completed mission
        for _, follower in pairs(_G["CovenantMissionFrame"].MissionComplete.followerGUIDToInfo) do
            table.insert(boardIndexes, follower.boardIndex)
        end
        framesByBoardIndex = _G["CovenantMissionFrame"].MissionComplete.Board.framesByBoardIndex
    else
        boardIndexes = {0, 1, 2, 3, 4}
        framesByBoardIndex = missionPage.Board.framesByBoardIndex
    end

    for _, boardIndex in pairs(boardIndexes) do
        local follower = framesByBoardIndex[boardIndex]
        local info = follower.info
        if info then
            info.boardIndex = follower.boardIndex
            info.maxHealth = info.autoCombatantStats.maxHealth
            info.health = info.autoCombatantStats.currentHealth
            info.attack = info.autoCombatantStats.attack
            info.isAutoTroop = info.isAutoTroop ~= nil and info.isAutoTroop or (info.quality == 0)
            info.followerGUID = follower:GetFollowerGUID()
            local XPToLvlUp = 0
            if info.isAutoTroop then
                info.isLoseLvlUp = false
                info.isWinLvlUp = false
            else
                XPToLvlUp = isCompletedMission and info.maxXP - info.currentXP or info.levelXP - info.xp
                info.isLoseLvlUp = XPToLvlUp < newObj.baseXP
                info.isWinLvlUp = XPToLvlUp < newObj.winXP
            end
            if info.autoCombatSpells == nil then info.autoCombatSpells = follower.autoCombatSpells end
            local myUnit = CMH.Unit:new(info)
            --SELECTED_CHAT_FRAME:AddMessage("myUnitName = " .. myUnit.name)
            newObj.units[follower.boardIndex] = myUnit
            newObj.isEmpty = false
            if myUnit.isAutoTroop == false then newObj.initialAlliesHP = newObj.initialAlliesHP + myUnit.currentHealth end
        end
    end

    self.__index = self
    setmetatable(newObj, self)
    newObj:setHasRandomSpells()
    if self.hasRandomSpells then self.max_rounds = MAX_RANDOM_ROUNDS end
    return newObj
end

function Board:simulate()
    if self.isEmpty then return end

    if self.hasRandomSpells and self.isCalcRandom then
        local new_board = {}
        local win_count = 0
        for i = 1, SIMULATE_ITERATIONS do
            new_board = copy(self)
            new_board:fight()
            if new_board:isWin() then win_count = win_count + 1 end
            CMH.Board.CombatLog = {}
            CMH.Board.HiddenCombatLog = {}
            CMH.Board.CombatLogEvents = {}
        end
        self.probability = math.floor(100 * win_count/SIMULATE_ITERATIONS)
    elseif self.hasRandomSpells then
        return
    end

   self:fight()
end

function Board:fight()
    local round = 1
    while self.isMissionOver == false and round < self.max_rounds do
        CMH:log('\n')
        CMH:log("|c0000FF33回合 " .. round .. "|r")
        MissionHelper:addRound()
        local turnOrder = self:getTurnOrder()

        local removed_effects = self:manageBuffsFromDeadUnits()
        local enemy_turn = false
        for _, boardIndex in pairs(turnOrder) do
            CMH:debug_log('turn for index ' .. boardIndex)
            if boardIndex > 4 and enemy_turn == false then
                enemy_turn = true
                CMH:log('\n')
            end
            self:makeUnitAction(round, boardIndex)
        end
        -- unit can die by DoT, but I don't check it inside makeUnitAction
        self.isMissionOver = self:checkMissionOver()
        round = round + 1
    end
end

function Board:setHasRandomSpells()
    for _, unit in pairs(self.units) do
        for _, spell in pairs(unit.spells) do
            for _, effect in pairs(spell.effects) do
                if effect.TargetType == TargetTypeEnum.randomEnemy or effect.TargetType == TargetTypeEnum.randomEnemy_2
                    or effect.TargetType == TargetTypeEnum.randomAlly then
                        self.hasRandomSpells = true
                        return
                end
            end
        end
    end

    self.hasRandomSpells = false
end

--- If one team dead, mission over
function Board:checkMissionOver()
    local isMyTeamAlive = false
    for i = 0, 4 do
        if self:isUnitAlive(i) then
            isMyTeamAlive = true
            break
        end
    end

    local isEnemyTeamAlive = false
    for i = 5, 12 do
        if self:isUnitAlive(i) then
            isEnemyTeamAlive = true
            break
        end
    end

    return not (isMyTeamAlive and isEnemyTeamAlive)
end

function Board:isUnitAlive(boardIndex)
    local unit = self.units[boardIndex]
    if unit then
        return unit:isAlive()
    end
    return false
end

function Board:isTargetableUnit(boardIndex)
    return self:isUnitAlive(boardIndex) and not self.units[boardIndex].untargetable
end

function Board:getTargetableUnits()
    local result = {}
    for i = 0, 12 do
        table.insert(result, i, self:isTargetableUnit(i) and true or false)
    end
    CMH:debug_log("targetableUnits -> " .. arrayForPrint(result))
    return result
end

function Board:getTurnOrder()
    local order = {}
    local sort_table = {}
    for i = 0, 4 do
        if self:isUnitAlive(i) then table.insert(sort_table, self.units[i]) end
    end
    table.sort(sort_table, function (a, b) return (a.currentHealth > b.currentHealth) end)

    for _, unit in pairs(sort_table) do
        table.insert(order, unit.boardIndex)
    end

    sort_table = {}
    for i = 5, 12 do
        if self:isUnitAlive(i) then table.insert(sort_table, self.units[i]) end
    end
    table.sort(sort_table, function (a, b) return (a.currentHealth > b.currentHealth) end)

    for _, unit in pairs(sort_table) do
        table.insert(order, unit.boardIndex)
    end

    CMH:debug_log("turn order -> " .. arrayForPrint(order))
    return order
end

function Board:makeUnitAction(round, boardIndex)
    if self.isMissionOver then return end
    local unit = self.units[boardIndex]
    if not unit:isAlive() then return end

    local targetIndexes, aliveUnits, lastTargetType

    unit:decreaseSpellsCooldown()
    self:manageAppliedBuffs(unit)

    for _, spell in pairs(unit:getAvailableSpells()) do
        if self.isMissionOver then break end
        CMH:debug_log("Spell: " .. spell.name .. ' (' .. #spell.effects .. ')')
        lastTargetType = -1

        for _, effect in pairs(spell.effects) do
            targetIndexes = self:getTargetIndexes(unit, effect.TargetType, lastTargetType, targetIndexes)
            CMH:debug_log("Effect: " .. effect.Effect .. ', TargetType: ' .. effect.TargetType)
            CMH:debug_log("targetIndexes -> " .. arrayForPrint(targetIndexes))

            local targetInfo = {}
            for _, targetIndex in pairs(targetIndexes) do
                local eventTargetInfo = unit:castSpellEffect(self.units[targetIndex], effect, spell, false)
                table.insert(targetInfo, eventTargetInfo)
            end
            MissionHelper:addEvent(spell.ID, isAura(effect.Effect) and EffectTypeEnum.ApplyAura or effect.Effect, boardIndex, targetInfo)

            for _, info in pairs(targetInfo) do
                self:onUnitTakeDamage(spell.ID, boardIndex, info)
            end

            if effect.TargetType ~= TargetTypeEnum.lastTarget then lastTargetType = effect.TargetType end
        end

        unit:startSpellCooldown(spell.ID)

        -- auto attack always has 1 effect and 1 target, so i can check it after cycle
        if #targetIndexes > 0 and spell:isAutoAttack() then
            local targetUnit = self.units[targetIndexes[1]]
            -- dead unit can reflect ...
            if targetUnit.reflect > 0 then
                local eventTargetInfo = targetUnit:castSpellEffect(unit, {Effect = CMH.DataTables.EffectTypeEnum.Reflect, ID = -1}, {}, true)
                MissionHelper:addEvent(spell.ID, CMH.DataTables.EffectTypeEnum.Reflect, targetUnit.boardIndex, {eventTargetInfo})
                self:onUnitTakeDamage(spell.ID, targetUnit.boardIndex, eventTargetInfo)
            end
        end
    end
end

function Board:manageAppliedBuffs(sourceUnit)
    local removed_buffs = {}
    for _, unit in pairs(self.units) do
        if unit:isAlive() then
            local unit_removed_buffs = unit:manageBuffs(sourceUnit)
            for _, buff in pairs(unit_removed_buffs) do
                table.insert(removed_buffs, buff)
            end
        end
    end

    return removed_buffs
end

function Board:manageBuffsFromDeadUnits()
    local removed_buffs = {}
    for _, unit in pairs(self.units) do
        if not self:isUnitAlive(unit.boardIndex) then
            local unit_removed_buffs = self:manageAppliedBuffs(unit)
            for _, buff in pairs(unit_removed_buffs) do
                table.insert(removed_buffs, buff)
            end
        end
    end
end

function Board:onUnitTakeDamage(spellID, casterBoardIndex, eventTargetInfo)
    if eventTargetInfo.newHealth == 0 then
        MissionHelper:addEvent(spellID, CMH.DataTables.EffectTypeEnum.Died, casterBoardIndex, {eventTargetInfo})
        CMH:log(string.format('|cFFFF7700 %s 击杀 %s |r', self.units[casterBoardIndex].name, self.units[eventTargetInfo.boardIndex].name))
        self.isMissionOver = self:checkMissionOver()
    end
end

function Board:getTotalLostHP(isWin)
    local restHP = 0
    local _start, _end, startHP = 0, 4, self.initialAlliesHP
    if not isWin then _start, _end, startHP = 5, 12, self.initialEnemiesHP end
    for i = _start, _end do
        if self.units[i] and self.units[i].isAutoTroop == false then
            if self.units[i].isWinLvlUp then
                restHP = restHP + self.units[i].maxHealth
            elseif self:isUnitAlive(i) then
                restHP = restHP + self.units[i].currentHealth
            end
        end
    end

    return startHP - restHP
end

function Board:getMyTeam()
    local function constructString(unit, isWin)
        local result = unit.name .. '. HP = ' .. unit.currentHealth .. '/' .. unit.maxHealth .. '\n'
        --result = unit.isWinLvlUp and result .. ' (Level Up)\n' or result .. '\n'
        if (isWin and unit.isWinLvlUp) or (not isWin and unit.isLoseLvlUp) then result = LVL_UP_ICON .. result end
        if unit.currentHealth == 0 then result = SKULL_ICON .. result end
        return '    ' .. result
    end

    if self.hasRandomSpells and self.isCalcRandom == false then
        return "有随机能力，无法自动模拟，请点击【预测】按钮检查结果。"
    end

    local isWin = self:isWin()
    local lostHP = self:getTotalLostHP(true)
    local loseOrGain = lostHP >= 0 and '失去' or '收到'
    local warningText = self.hasRandomSpells and "|cFFFF0000有随机能力，实际的剩余生命可能与预测的不同|r\n" or ''

    local text = ''
    for i = 0, 4 do
        if self.units[i] then
            text = text .. constructString(self.units[i], isWin)
        end
    end
    text = string.format("%s我方队伍:\n%s \n\n总计 %s HP = %s", warningText, text, loseOrGain, math.abs(lostHP))

    return text
end

function Board:constructResultString()
    if self.isEmpty then
        return '添加伙伴'
    elseif self.hasRandomSpells and self.isCalcRandom == false then
        return ''
    elseif not self.isMissionOver then
        return string.format('|cFFFF0000超过100回合，谁胜谁输，全看天命|r', self.max_rounds)
    end

    local result = self:isWin()
    if self.probability == 100 and result then
        return '|cFF00FF00 预测结果: 胜利 |r'
    elseif self.probability == 0 or (result == false and self.probability == 100) then
        return '|cFFFF0000 预测结果: 失败 |r'
    else
        return string.format('|cFFFF7700 预测结果: 胜利 (~%s%%) |r', self.probability)
    end
end

function Board:isWin()
    for _, unit in pairs(self.units) do
        if unit:isAlive() then
            if unit.boardIndex > 4 then return false else return true
            end
        end
    end
end

function Board:getTargetIndexes(unit, targetType, lastTargetType, lastTargetIndexes)
    -- update targets if skill has different effects target type
    if lastTargetType ~= targetType and targetType ~= TargetTypeEnum.lastTarget then
        local aliveUnits = self:getTargetableUnits()
        return CMH.TargetManager:getTargetIndexes(unit.boardIndex, targetType, aliveUnits, unit.tauntedBy)
    else
        return lastTargetIndexes
    end
end

CMH.Board = Board


local BlizzEventType, EffectType = Enum.GarrAutoMissionEventType, CMH.DataTables.EffectTypeEnum
local CombatLogEvents = {}


local function getBlizzardEventType(effectType, spellID)
    if spellID == 11 then
        return BlizzEventType.MeleeDamage -- 0
    elseif spellID == 15 then
        return BlizzEventType.RangeDamage -- 1
    elseif effectType == EffectType.Damage or effectType == EffectType.Damage_2 then
        return BlizzEventType.SpellMeleeDamage -- or EventType.SpellRangeDamage?  2
    elseif effectType == EffectType.DoT then
        return BlizzEventType.PeriodicDamage -- 5
    elseif effectType == EffectType.Heal or effectType == EffectType.Heal_2 then
        return BlizzEventType.Heal -- 4
    elseif effectType == EffectType.HoT then
        return BlizzEventType.PeriodicHeal -- 6
    elseif effectType == EffectType.Died then
        return BlizzEventType.Died -- 9
    elseif effectType == EffectType.RemoveAura then
        return BlizzEventType.RemoveAura -- 8
    else
        return BlizzEventType.ApplyAura -- 7
    end
end


function MissionHelper:addRound()
    table.insert(CombatLogEvents, {events = {}})
    --print('round ' .. #CombatLogEvents)
end

function MissionHelper:addEvent(spellID, effectType, casterBoardIndex, targetInfo)
    table.insert(CombatLogEvents[#CombatLogEvents].events, {
                casterBoardIndex = casterBoardIndex,
                spellID = spellID,
                type = getBlizzardEventType(effectType, spellID),
                targetInfo = targetInfo
            })
    --print('event ' .. #CombatLogEvents[#CombatLogEvents].events)
end

CMH.Board.CombatLogEvents = CombatLogEvents

local Spell = {}
function Spell:new(autoCombatSpell)
    local newObj = {}
    --SELECTED_CHAT_FRAME:AddMessage('autoCombatSpellID: ' .. autoCombatSpell.autoCombatSpellID)
    newObj.ID = autoCombatSpell.autoCombatSpellID
    newObj.name = autoCombatSpell.name
    newObj.duration = autoCombatSpell.duration
    newObj.cooldown = autoCombatSpell.cooldown
    newObj.currentCooldown = self:isStartsOnCooldown(newObj.ID) and newObj.cooldown or 0
    --CMH:debug_log('currentCooldown: ' .. newObj.currentCooldown .. ' duration = ' .. tostring(newObj.duration))
    self.__index = self
    setmetatable(newObj, self)
    newObj:setEffects()

    return newObj
end

function Spell:isStartsOnCooldown(spellID)
    for _, ID in ipairs(CMH.DataTables.startsOnCooldownSpells) do
        if ID == spellID then return true end
    end

    return false
end

function Spell:setEffects()
    local effects = CMH.DataTables.SpellEffects[self.ID]
    if effects then
        self.effects = effects
    else
        -- TODO: add logs/warnings
        self.effects = {}
    end
end

function Spell:isAvailable()
    return self.currentCooldown == 0
end

function Spell:startCooldown()
    self.currentCooldown = self.cooldown + 1
end

function Spell:decreaseCooldown()
    if self.currentCooldown > 0 then
        self.currentCooldown = self.currentCooldown - 1
    end
end

function Spell:isAutoAttack()
    return self.ID == 11 or self.ID == 15
end

local Buff = {}
function Buff:new(effect, effectBaseValue, sourceIndex, duration, name)
    local newBuff = {}
    for k,v in pairs(effect) do
        newBuff[k] = v
    end
    newBuff.Period = math.max(newBuff.Period - 1, 0)
    newBuff.currentPeriod = math.max(newBuff.Period, 0)
    newBuff.baseValue = effectBaseValue
    newBuff.sourceIndex = sourceIndex
    newBuff.duration = duration
    newBuff.name = name
    self.__index = self
    return setmetatable(newBuff, self)
end

function Buff:decreaseRestTime()
    self.duration = math.max(self.duration - 1, 0)
    self.currentPeriod = self.currentPeriod == 0 and self.Period or math.max(self.currentPeriod - 1, 0)
    return self.duration
end

CMH.Spell = Spell
CMH.Buff = Buff

local TargetManager = {}
local TargetTypeEnum = CMH.DataTables.TargetTypeEnum

local function getTargetPriority(sourceIndex, targetType, mainTarget)
    local targets = CMH.DataTables.TargetPriorityByType[targetType][sourceIndex]
    if mainTarget ~= nil then table.insert(targets, 1, mainTarget) end
    return targets
end

local function getMainTarget(priority, boardUnits)
    for _, unitIndex in pairs(priority) do
        if boardUnits[unitIndex] then return unitIndex end
    end
end

local function getSelfTarget(sourceIndex, targetType, boardUnits) return {sourceIndex} end

local function getSimpleTarget(sourceIndex, targetType, boardUnits, mainTarget)
    -- adjacent ally, closest enemy, furthest enemy
    local priority
    if mainTarget ~= nil and (targetType == TargetTypeEnum.closestEnemy or targetType == TargetTypeEnum.furthestEnemy) then return {mainTarget} end
    priority = getTargetPriority(sourceIndex, targetType)
    mainTarget = getMainTarget(priority, boardUnits)
    return {mainTarget}
end

local function getAllAllies(sourceIndex, targetType, boardUnits)
    local targets = {}
    if sourceIndex <=4 then
            for i = 0, 4 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        else
            for i = 5, 12 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        end
    return targets
end

local function getAllEnemies(sourceIndex, targetType, boardUnits)
    local targets = {}
    if sourceIndex <=4 then
            for i = 5, 12 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        else
            for i = 0, 4 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        end
    return targets
end

local function getAllAdjacentAllies(sourceIndex, targetType, boardUnits)
    local targets = {}
    local adjacentTargets = CMH.DataTables.AdjacentAllies[sourceIndex]
    for i = 1, #adjacentTargets do
        if boardUnits[adjacentTargets[i]] then
            table.insert(targets, adjacentTargets[i])
        end
    end
    return targets
end

local function getAllAdjacentEnemies(sourceIndex, targetType, boardUnits, mainTarget)
    -- TODO: if taunt?
    local targets = {}
    local targetInfo = CMH.DataTables.AdjacentEnemies[sourceIndex]
    local aliveBlockerUnit = getMainTarget(targetInfo.blockerUnits, boardUnits)

    if aliveBlockerUnit ~= nil then
        for _, boardIndex in ipairs(targetInfo.aliveBlockerUnitGroup) do
            if boardUnits[boardIndex] then table.insert(targets, boardIndex) end
        end
    else
        -- one cleave group
        if type(targetInfo.deadBlockerUnitGroup[1]) == 'number' then
            for _, boardIndex in ipairs(targetInfo.deadBlockerUnitGroup) do
                if boardUnits[boardIndex] then table.insert(targets, boardIndex) end
            end

            --many cleave groups
        elseif type(targetInfo.deadBlockerUnitGroup[1]) == 'table' then
            for _, group in ipairs(targetInfo.deadBlockerUnitGroup) do
                for _, boardIndex in ipairs(group) do
                    if boardUnits[boardIndex] then table.insert(targets, boardIndex) end
                    if #targets > 0 then return targets end
                end
            end
        end
    end

    if #targets == 0 then
        local singleTarget = getMainTarget(targetInfo.aloneUnits, boardUnits)
        if singleTarget ~= nil then table.insert(targets, singleTarget) end
    end

    return targets
end

local function getClosestAllyCone(sourceIndex, targetType, boardUnits, mainTarget)
    local targets = {}
    mainTarget = getSimpleTarget(sourceIndex, TargetTypeEnum.closestEnemy, boardUnits, mainTarget)[1]
    if mainTarget == nil then return {} end
    local coneTargets = CMH.DataTables.ConeAllies[mainTarget]
    for i = 1, #coneTargets do
        if boardUnits[coneTargets[i]] then
            table.insert(targets, coneTargets[i])
        end
    end
    return targets
end

local function getClosestEnemyCone(sourceIndex, targetType, boardUnits, mainTarget)
    local targets = {}
    mainTarget = getSimpleTarget(sourceIndex, TargetTypeEnum.closestEnemy, boardUnits, mainTarget)[1]
    if mainTarget == nil then return {} end
    local coneTargets = CMH.DataTables.ConeEnemies[mainTarget]
    for i = 1, #coneTargets do
        if boardUnits[coneTargets[i]] then
            table.insert(targets, coneTargets[i])
        end
    end
    return targets
end

local function getClosestEnemyLine(sourceIndex, targetType, boardUnits, mainTarget)
    local targets = {}
    mainTarget = getSimpleTarget(sourceIndex, TargetTypeEnum.closestEnemy, boardUnits, mainTarget)[1]
    if mainTarget == nil then return {} end
    local lineTargets = CMH.DataTables.LineEnemies[mainTarget]
    for i = 1, #lineTargets do
        if boardUnits[lineTargets[i]] then
            table.insert(targets, lineTargets[i])
        end
    end
    return targets
end

local function getAllMeleeAllies(sourceIndex, targetType, boardUnits)
    local targets = {}
    if sourceIndex <= 4 then
        for i = 2, 4 do
            if boardUnits[i] then
                table.insert(targets, i)
            end
        end
        if #targets == 0 then
            for i = 0, 1 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        end

    else
        for i = 5, 8 do
            if boardUnits[i] then
                table.insert(targets, i)
            end
        end
        if #targets == 0 then
            for i = 9, 12 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        end
    end

    return targets
end

local function getAllMeleeEnemies(sourceIndex, targetType, boardUnits, mainTarget)
    local targets = {}
    if sourceIndex <= 4 then
        for i = 5, 8 do
            if boardUnits[i] then
                table.insert(targets, i)
            end
        end
        if #targets == 0 then
            for i = 9, 12 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        end

    else
        for i = 2, 4 do
            if boardUnits[i] then
                table.insert(targets, i)
            end
        end
        if #targets == 0 then
            for i = 0, 1 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        end
    end

    if mainTarget ~= nil then table.insert(targets, 1, mainTarget) end
    return targets
end

local function getAllRangedAllies(sourceIndex, targetType, boardUnits, mainTarget)
    local targets = {}
    if sourceIndex <= 4 then
        for i = 0, 1 do
            if boardUnits[i] then
                table.insert(targets, i)
            end
        end
        if #targets == 0 then
            for i = 2, 4 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        end

    else
        for i = 9, 12 do
            if boardUnits[i] then
                table.insert(targets, i)
            end
        end
        if #targets == 0 then
            for i = 5, 8 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        end
    end

    return targets
end

local function getAllRangedEnemies(sourceIndex, targetType, boardUnits, mainTarget)
    local targets = {}
    if sourceIndex <= 4 then
        for i = 9, 12 do
            if boardUnits[i] then
                table.insert(targets, i)
            end
        end
        if #targets == 0 then
            for i = 5, 8 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        end

    else
        for i = 0, 1 do
            if boardUnits[i] then
                table.insert(targets, i)
            end
        end
        if #targets == 0 then
            for i = 2, 4 do
                if boardUnits[i] then
                    table.insert(targets, i)
                end
            end
        end
    end

    if mainTarget ~= nil then table.insert(targets, 1, mainTarget) end
    return targets
end

local function notImplemented(sourceIndex, targetType, boardUnits, mainTarget)
    -- TODO: logs
    return {sourceIndex}
end

local function getRandomEnemy(sourceIndex, targetType, boardUnits, mainTarget)
    if mainTarget ~= nil then return {mainTarget} end
    local targets = {}
    for i, v in ipairs(boardUnits) do
        if (sourceIndex <= 4 and i > 4 and v == true) or (sourceIndex > 4 and i <= 4 and v == true) then table.insert(targets, i) end
    end

    if #targets == 0 then return {} end
    return {targets[random(#targets)]}
end

local function getRandomAlly(sourceIndex, targetType, boardUnits, mainTarget)
    local targets = {}
    for i, v in ipairs(boardUnits) do
        if (sourceIndex <= 4 and i <= 4 and v == true) or (sourceIndex > 4 and i > 4 and v == true) then table.insert(targets, i) end
    end

    if #targets == 0 then return {} end
    return {targets[random(#targets)]}
end

local function getEnvAllAllies(sourceIndex, targetType, boardUnits, mainTarget)
    return {0, 1, 2, 3, 4}
end

local function getEnvAllEnemies(sourceIndex, targetType, boardUnits, mainTarget)
    return {5, 6, 7, 8, 9, 10, 11, 12}
end

local function getAlliesExpectSelf(sourceIndex, targetType, boardUnits, mainTarget)
    local targets = {}
    if sourceIndex <=4 then
            for i = 0, 4 do
                if boardUnits[i] and i ~= sourceIndex then
                    table.insert(targets, i)
                end
            end
        else
            for i = 5, 12 do
                if boardUnits[i] and i ~= sourceIndex then
                    table.insert(targets, i)
                end
            end
        end
    return targets
end

local FunctionTable = {
    [0] = notImplemented,
    [1] = getSelfTarget,
    [2] = getSimpleTarget,
    [3] = getSimpleTarget,
    [5] = getSimpleTarget,
    [6] = getAllAllies,
    [7] = getAllEnemies,
    [8] = getAllAdjacentAllies,
    [9] = getAllAdjacentEnemies,
    [10] = getClosestAllyCone,
    [11] = getClosestEnemyCone,
    [13] = getClosestEnemyLine,
    [14] = getAllMeleeAllies,
    [15] = getAllMeleeEnemies,
    [16] = getAllRangedAllies,
    [17] = getAllRangedEnemies,
    [19] = getRandomEnemy,
    [20] = getRandomEnemy,
    [21] = getRandomAlly,
    [22] = getAlliesExpectSelf,
    [23] = getEnvAllAllies,
    [24] = getEnvAllEnemies
}

function TargetManager:getTargetIndexes(sourceIndex, targetType, boardUnits, mainTarget)
    local func = FunctionTable[targetType]
    return func(sourceIndex, targetType, boardUnits, mainTarget)
end

CMH.TargetManager = TargetManager
local Unit = {}
local EffectTypeEnum, EffectType = CMH.DataTables.EffectTypeEnum, CMH.DataTables.EffectType

local function isDamageEffect(effect, isAppliedBuff)
    return effect.Effect == EffectTypeEnum.Damage
            or effect.Effect == EffectTypeEnum.Damage_2
            or (
                (effect.Effect == EffectTypeEnum.DoT or effect.Effect == EffectTypeEnum.Reflect or effect.Effect == EffectTypeEnum.Reflect_2)
                and isAppliedBuff == true
            )
end

function Unit:new(blizzardUnitInfo)
    local newObj = {
        -- use for unusual attack only, blizz dont store combatantID in mission's tables
        ID = blizzardUnitInfo.garrFollowerID ~= nil and blizzardUnitInfo.garrFollowerID
                or blizzardUnitInfo.portraitFileDataID or blizzardUnitInfo.portraitIconID,
        followerGUID = blizzardUnitInfo.followerGUID,
        name = blizzardUnitInfo.name,
        maxHealth = blizzardUnitInfo.maxHealth,
        currentHealth = blizzardUnitInfo.health,
        attack = blizzardUnitInfo.attack,
        isAutoTroop = blizzardUnitInfo.isAutoTroop,
        boardIndex = blizzardUnitInfo.boardIndex,
        role = blizzardUnitInfo.role,
        tauntedBy = nil,
        untargetable = false,
        reflect = 0,
        isLoseLvlUp = blizzardUnitInfo.isLoseLvlUp,
        isWinLvlUp = blizzardUnitInfo.isWinLvlUp,
        buffs = {}
    }

    self.__index = self
    setmetatable(newObj, self)
    newObj:setSpells(blizzardUnitInfo.autoCombatSpells)


    return newObj
end

function Unit:getAttackType()
    if CMH.DataTables.UnusualAttackType[self.ID] ~= nil then
        return CMH.DataTables.UnusualAttackType[self.ID]
    elseif self.role == 1 or self.role == 5 then -- melee and tank
        return 11
    else
        return 15
    end
end

function Unit:setSpells(autoCombatSpells)
    self.spells = {}
    -- auto attack is spell
    local autoAttack = {
        autoCombatSpellID = self:getAttackType(),
        name = 'Auto Attack',
        duration = 0,
        cooldown = 0,
        flags = 0
    }
    local autoAttackSpell = CMH.Spell:new(autoAttack)
    table.insert(self.spells, autoAttackSpell)

    for _, autoCombatSpell in pairs(autoCombatSpells) do
        --broken spells
        if autoCombatSpell.autoCombatSpellID ~= 91 and autoCombatSpell.autoCombatSpellID ~= 109 and autoCombatSpell.autoCombatSpellID ~= 122 then
            table.insert(self.spells, CMH.Spell:new(autoCombatSpell))
        end
    end
end

function Unit:isAlive()
    return self.currentHealth > 0
end

function Unit:getEffectBaseValue(effect)
    --isn't work in game
    if effect.Effect == EffectTypeEnum.DamageDealtMultiplier then
        return 0
    elseif effect.Effect == EffectTypeEnum.DamageDealtMultiplier_2
            or effect.Effect == EffectTypeEnum.DamageTakenMultiplier
            or effect.Effect == EffectTypeEnum.DamageTakenMultiplier_2
            or effect.Effect == EffectTypeEnum.Reflect then
                return effect.Points
    elseif effect.Flags == 1 or effect.Flags == 3 then
        return math.floor(effect.Points * self.attack)
    else
        return effect.Points
    end
end

function Unit:calculateEffectValue(targetUnit, effect)
    local value
    if effect.Effect == EffectTypeEnum.Reflect or effect.Effect == EffectTypeEnum.Reflect_2 then
        value = self.reflect
    elseif effect.Flags == 0 or effect.Flags == 2 then
        value = math.floor(effect.Points * targetUnit.maxHealth)
    else
        value = math.floor(effect.Points * self.attack)
    end

    if isDamageEffect(effect, true) then
        local multiplier, positive_multiplier = self:getDamageMultiplier(targetUnit)
        value = multiplier * (value + self:getAdditionalDamage(targetUnit))
    end

    return math.max(math.floor(value + .00000000001), 0)
end

function Unit:manageDoTHoT(sourceUnit, buff, isInitialPeriod)
    if isInitialPeriod == nil then isInitialPeriod = false end
    --CMH:log(string.format('sourceUnit = %s, duration = %s, period = %s',
      --          tostring(sourceUnit.boardIndex), tostring(buff.duration), tostring(buff.currentPeriod)))
    if (buff.Effect == EffectTypeEnum.DoT or buff.Effect == EffectTypeEnum.HoT) and (buff.currentPeriod == 0 or isInitialPeriod) then
        sourceUnit:castSpellEffect(self, buff, {}, true)
    end
end

function Unit:applyBuff(targetUnit, effect, effectBaseValue, duration, name)
    table.insert(targetUnit.buffs, CMH.Buff:new(effect, effectBaseValue, self.boardIndex, duration, name))
    if effect.Effect == EffectTypeEnum.Taunt then
        targetUnit.tauntedBy = self.boardIndex
    elseif effect.Effect == EffectTypeEnum.Untargetable then
        targetUnit.untargetable = true
    elseif effect.Effect == EffectTypeEnum.Reflect or effect.Effect == EffectTypeEnum.Reflect_2 then
        targetUnit.reflect = effectBaseValue
    end

    -- extra initial period
    if effect.Flags == 2 or effect.Flags == 3 then
        targetUnit:manageDoTHoT(self, effect, true)
    end
end

function Unit:getDamageMultiplier(targetUnit)
    local buffs = {}
    local multiplier, positive_multiplier = 1, 1
    for _, buff in pairs(self.buffs) do
        if buff.Effect == EffectTypeEnum.DamageDealtMultiplier or buff.Effect == EffectTypeEnum.DamageDealtMultiplier_2 then
            CMH:debug_log(string.format('self buff. effect = %s, baseValue = %s, spellID = %s, source = %s ',
                    CMH.DataTables.EffectType[buff.Effect], buff.baseValue, buff.SpellID, buff.sourceIndex))
            if buffs[buff.SpellID] == nil then
                buffs[buff.SpellID] = buff.baseValue
            else
                buffs[buff.SpellID] = buffs[buff.SpellID] + buff.baseValue
            end
        end
    end

    for _, buff in pairs(targetUnit.buffs) do
        if buff.Effect == EffectTypeEnum.DamageTakenMultiplier or buff.Effect == EffectTypeEnum.DamageTakenMultiplier_2 then
            CMH:debug_log('target buff ' .. CMH.DataTables.EffectType[buff.Effect] .. ' ' .. buff.baseValue)
            if buffs[buff.SpellID] == nil then
                buffs[buff.SpellID] = buff.baseValue
            else
                buffs[buff.SpellID] = buffs[buff.SpellID] + buff.baseValue
            end
        end
    end

    for _, value in pairs(buffs) do
        multiplier = multiplier * (1 + value)
        if value > 0 then positive_multiplier = positive_multiplier * (1 + value) end
    end

    if multiplier ~= 1 then CMH:debug_log('damage multiplier = ' .. multiplier .. ' pos. multiplier = ' .. positive_multiplier) end
    return math.max(multiplier, 0), positive_multiplier
end

function Unit:getAdditionalDamage(targetUnit)
    local result = 0
    for _, buff in pairs(self.buffs) do
        if buff.Effect == EffectTypeEnum.AdditionalDamageDealt then
            result = result + buff.baseValue
        end
    end

    for _, buff in pairs(targetUnit.buffs) do
        if buff.Effect == EffectTypeEnum.AdditionalTakenDamage then
            result = result + buff.baseValue
        end
    end
    if result ~= 0 then CMH:debug_log('additional damage = ' .. result) end
    return result
end

function Unit:castSpellEffect(targetUnit, effect, spell, isAppliedBuff)
    local oldTargetHP = targetUnit.currentHealth
    local value = 0
    local color = (isAppliedBuff == false and spell:isAutoAttack()) and '00FFFFFF' or '0066CCFF'

    -- deal damage
    if isDamageEffect(effect, isAppliedBuff) then
        value = self:calculateEffectValue(targetUnit, effect)
        targetUnit.currentHealth = math.max(0, targetUnit.currentHealth - value)
        CMH:log(string.format('|c%s%s %s %s for %s. (HP %s -> %s)|r',
            color, self.name, EffectType[effect.Effect], targetUnit.name, value, oldTargetHP, targetUnit.currentHealth))

    -- heal
    elseif effect.Effect == EffectTypeEnum.Heal or effect.Effect == EffectTypeEnum.Heal_2
            or (effect.Effect == EffectTypeEnum.HoT and isAppliedBuff == true) then
        value = self:calculateEffectValue(targetUnit, effect)
        targetUnit.currentHealth = math.min(targetUnit.maxHealth, targetUnit.currentHealth + value)
        CMH:log(string.format('|c%s%s %s %s for %s. (HP %s -> %s)|r',
            color, self.name, EffectType[effect.Effect], targetUnit.name, value, oldTargetHP, targetUnit.currentHealth))

    -- Maximum health multiplier
    elseif effect.Effect == EffectTypeEnum.MaxHPMultiplier then
        value = self:calculateEffectValue(targetUnit, effect)
        targetUnit.maxHealth = targetUnit.maxHealth + value
        CMH:log(string.format('|c%s%s %s %s for %s|r',
            color, self.name, EffectType[effect.Effect], targetUnit.name, value))
    else
        value = self:getEffectBaseValue(effect)
        self:applyBuff(targetUnit, effect, value, spell.duration, spell.name)
        CMH:log(string.format('|c%s%s %s %s (%s)|r',
            color, self.name, '使用 ' .. EffectType[effect.Effect], targetUnit.name, value))
    end

    return {
        boardIndex = targetUnit.boardIndex,
        maxHealth = targetUnit.maxHealth,
        oldHealth = oldTargetHP,
        newHealth = targetUnit.currentHealth,
        points = value
    }
end

function Unit:getAvailableSpells()
    -- Return autoAttack's and all spell's effects
    local result = {}

    for _, spell in pairs(self.spells) do
        if spell:isAvailable() then table.insert(result, spell) end
    end

    return result
end

function Unit:startSpellCooldown(spellID)
    --CMH:log('Start Cooldown. SpellID = ' .. spellID .. '. name = ' .. type(spellID))
    for _, spell in ipairs(self.spells) do
        if spell.ID == spellID then
            spell:startCooldown()
            break
        end
    end
end

function Unit:decreaseSpellsCooldown()
    for _, spell in pairs(self.spells) do spell:decreaseCooldown() end
end

function Unit:manageBuffs(sourceUnit)
    local i = 1
    local removed_buffs = {}
    --if #self.buffs > 0 then CMH:debug_log('unit = ' .. self.boardIndex .. ' buffs = ' .. #self.buffs) end
    while i <= #self.buffs do
        local buff = self.buffs[i]
        if buff.sourceIndex == sourceUnit.boardIndex then
            CMH:debug_log('targetUnit = ' .. self.boardIndex ..
                    ' buff effect = ' .. buff.Effect .. ' duration = ' .. tostring(buff.duration) ..
                    ' period = ' .. tostring(buff.currentPeriod))
            self:manageDoTHoT(sourceUnit, buff, false)
            buff:decreaseRestTime()
        end

        if buff.sourceIndex == sourceUnit.boardIndex and buff.duration == 0 then
            table.insert(removed_buffs, {
                buff = buff,
                targetBoardIndex = self.boardIndex,
            })
            CMH:log(string.format('|c000088CC%s 去除 %s 来自 %s|r',
                    tostring(sourceUnit.name), tostring(buff.name), tostring(self.name)))
            table.remove(self.buffs, i)
            if buff.Effect == EffectTypeEnum.Taunt then
                self.tauntedBy = nil
            elseif buff.Effect == EffectTypeEnum.Untargetable then
                self.untargetable = false
            elseif buff.Effect == EffectTypeEnum.Reflect or buff.Effect == EffectTypeEnum.Reflect_2 then
                self.reflect = 0
            end
        else
            i = i + 1
        end
    end

    return removed_buffs
end

CMH.Unit = Unit
local MetaBoard = {}
CMH.MetaBoard = MetaBoard

local function copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return res
end

local function get_subs(numbers)
    local result = {}
    if #numbers == 2 then return {{numbers[1], numbers[2]}, {numbers[2], numbers[1]}} end

    for i, number in pairs(numbers) do
        local new_numbers = {}
        for _, n in pairs(numbers) do if n ~= number then table.insert(new_numbers, n) end end
        local tmp = get_subs(new_numbers)
        for _, v in pairs(tmp) do
            table.insert(v, 1, number)
            table.insert(result, v)
        end
    end

    return result
end

function MetaBoard:new(missionPage, isCalcRandom)
    local newObj = {
        baseBoard = CMH.Board:new(missionPage, isCalcRandom)
    }
    self.__index = self
    setmetatable(newObj, self)

    return newObj
end

function MetaBoard:findBestDisposition()
    local bestBoard, bestLostHP = {}, 9999999
    for board in self:findBestDispositionIterator() do
        board:simulate()
        local lostHP = board:getTotalLostHP(board:isWin())
        if board:isWin() then
            if lostHP < bestLostHP then
                bestLostHP = lostHP
                bestBoard = board
            end
        end

        CMH.Board.CombatLog = {}
        CMH.Board.HiddenCombatLog = {}
        CMH.Board.CombatLogEvents = {}
    end

    return next(bestBoard) ~= nil and bestBoard or self.baseBoard
end

function MetaBoard:findBestDispositionIterator()
    -- unique subs only
    local hash = {}
    local numbers = {}
    local subs = get_subs({0, 1, 2, 3, 4})

    return function ()
        for _, sub in ipairs(subs) do
            local unitIDs = ''

            for _, boardIndex in ipairs(sub) do
                    unitIDs = self.baseBoard.units[boardIndex] == nil and unitIDs .. '-1|' or unitIDs .. self.baseBoard.units[boardIndex].ID .. '|'
            end

            if not hash[unitIDs] then
                --print(unitIDs)
                --print(table.concat(sub, ';'))
                hash[unitIDs] = true

                local newBoard = copy(self.baseBoard)
                for newIndex, oldIndex in ipairs(sub) do
                    if self.baseBoard.units[oldIndex] ~= nil then
                        -- newIndex starts from 1
                        newBoard.units[newIndex-1] = copy(self.baseBoard.units[oldIndex])
                        newBoard.units[newIndex-1].boardIndex = newIndex-1
                        --print(newIndex-1 .. ', ' .. oldIndex .. ': ' .. newBoard.units[newIndex-1].name)
                    else
                        newBoard.units[newIndex-1] = nil
                    end
                end
                newBoard.isCalcRandom = false
                return newBoard
            end
        end
        return nil
    end
end

local MissionHelper = _G["MissionHelper"]

local MAX_FRAME_WIDTH = 500
local PADDING = 20
local RESULT_HEADER_WIDTH = 300
local RESULT_HEADER_HEIGHT = 30
local RESULT_INFO_HEIGHT = 160
local SCROLL_BAR_WIDTH = 10
local PREDICT_BUTTON_WIDTH = 80
local PREDICT_BUTTON_HEIGHT = 30

local function hideCorners(frame)
    frame.BaseFrameTopLeft:Hide()
    frame.BaseFrameTopRight:Hide()
    frame.BaseFrameBottomLeft:Hide()
    frame.BaseFrameBottomRight:Hide()
end

local function hideBaseCorners(frame)
    frame.RaisedFrameEdges.BaseFrameTopLeftCorner:Hide()
    frame.RaisedFrameEdges.BaseFrameTopRightCorner:Hide()
    frame.RaisedFrameEdges.BaseFrameBottomLeftCorner:Hide()
    frame.RaisedFrameEdges.BaseFrameBottomRightCorner:Hide()
end

local function createMainFrame()
    local mainFrameWidth = math.min(
            GetScreenWidth() * UIParent:GetEffectiveScale() - (CovenantMissionFrame:GetRight() * CovenantMissionFrame:GetEffectiveScale()) - PADDING,
            MAX_FRAME_WIDTH
    )
    local frame  = CreateFrame("Frame", "missionHelperFrame", _G["CovenantMissionFrame"], "CovenantMissionBaseFrameTemplate") -- GarrisonUITemplate/BasicFrameTemplate
        _G["MissionHelper"].missionHelperFrame = frame
        frame:SetPoint("TOPLEFT", CovenantMissionFrame, "TOPRIGHT")
        frame:SetClampedToScreen(true)
        frame:SetSize(mainFrameWidth, CovenantMissionFrame:GetHeight())
        frame:EnableMouse(true)
        frame:EnableMouseWheel(true)
        frame.BaseFrameBackground:SetAtlas('adventures-missions-bg-02', false)
        hideCorners(frame)

    -- move frame
    frame:SetMovable(true)
    frame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and (IsShiftKeyDown()) and not self.isMoving then
            self:StartMoving();
            self.isMoving = true;
        end
    end)

    frame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and (IsShiftKeyDown()) and self.isMoving then
            self:StopMovingOrSizing();
            self.isMoving = false;
        end
    end)

    return frame
end

local function createResultHeader(main_frame)
    local resultHeader = CreateFrame("Frame", nil, main_frame)
    main_frame.resultHeader = resultHeader
        resultHeader:SetPoint("TOP", main_frame, "TOP", 0, -PADDING)
        resultHeader:SetSize(RESULT_HEADER_WIDTH, RESULT_HEADER_HEIGHT)
        resultHeader.BaseFrameBackground = resultHeader:CreateTexture()
        resultHeader.BaseFrameBackground:SetAtlas("adventures_mission_materialframe")
        resultHeader.BaseFrameBackground:SetAllPoints(resultHeader)

    resultHeader.text = resultHeader:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        resultHeader.text:SetPoint("CENTER")
        resultHeader.text:SetJustifyH("CENTER")
        resultHeader.text:SetJustifyV("CENTER")

    return resultHeader
end

local function createPredictButton(resultInfoFrame)
    local function onClick()
        MissionHelper:showResult(MissionHelper:simulateFight(true))
    end

    local predictButton = CreateFrame("Button", nil, resultInfoFrame, "UIPanelButtonTemplate")
    resultInfoFrame.predictButton = predictButton
        predictButton:SetSize(PREDICT_BUTTON_WIDTH, PREDICT_BUTTON_HEIGHT)
        predictButton:SetPoint("BOTTOMRIGHT", resultInfoFrame, "BOTTOMRIGHT", -PADDING, PADDING)
        predictButton:SetText('预测')
        predictButton:SetScript('onClick', onClick)
        predictButton:Hide()
end

local function createBestDispositionButton(resultInfoFrame)
    local function onClick()
        MissionHelper:findBestDisposition()
    end

    local function onEnter(buttonFrame)
        GameTooltip:SetOwner(buttonFrame, "ANCHOR_TOPLEFT")
        GameTooltip_AddNormalLine(GameTooltip, "优化伙伴置，减少生命损失")
        GameTooltip_AddColoredLine(GameTooltip, "只优化调整台上的伙伴位置", RED_FONT_COLOR)
        GameTooltip:SetPoint("TOPLEFT", buttonFrame, "BOTTOMRIGHT", 0, 0);
        GameTooltip:Show()
    end

    local function onLeave()
        GameTooltip_Hide()
    end

    local BestDispositionButton = CreateFrame("Button", nil, resultInfoFrame, "UIPanelButtonTemplate")
    resultInfoFrame.BestDispositionButton = BestDispositionButton
        BestDispositionButton:SetSize(PREDICT_BUTTON_WIDTH, PREDICT_BUTTON_HEIGHT)
        BestDispositionButton:SetPoint("BOTTOMRIGHT", resultInfoFrame, "BOTTOMRIGHT", -2*PADDING - PREDICT_BUTTON_WIDTH, PADDING)
        BestDispositionButton:SetText('优化位置')
        BestDispositionButton:SetScript('onClick', onClick)
        BestDispositionButton:SetScript('onEnter', onEnter)
        BestDispositionButton:SetScript('onLeave', onLeave)
        BestDispositionButton:Hide()
end

local function createResultInfo(mainFrame)
    local resultInfo = CreateFrame("Frame", nil, mainFrame, "CovenantMissionBaseFrameTemplate")
    mainFrame.resultInfo = resultInfo
        resultInfo:SetSize(mainFrame:GetWidth() - 2*PADDING, RESULT_INFO_HEIGHT)
        resultInfo:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", PADDING, -(RESULT_HEADER_HEIGHT + 1.5*PADDING))
        hideBaseCorners(resultInfo)
        hideCorners(resultInfo)

    resultInfo.text = resultInfo:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        resultInfo.text:SetSize(resultInfo:GetWidth() - 2*PADDING , resultInfo:GetHeight() - PADDING)
        resultInfo.text:SetPoint("TOPLEFT", PADDING, -PADDING)
        resultInfo.text:SetJustifyH("LEFT")
        resultInfo.text:SetJustifyV("TOP")

    createBestDispositionButton(resultInfo)
    createPredictButton(resultInfo)

    return resultInfo
end

local function createScrollingMessageFrame(mainFrame, combatLogFrame)
    local messageFrame = CreateFrame("ScrollingMessageFrame", "missionHelperMessageFrame", combatLogFrame)
    combatLogFrame.CombatLogMessageFrame = messageFrame
        messageFrame:SetFontObject(GameFontNormal)
        messageFrame:SetSize(mainFrame:GetWidth() - 5*PADDING, mainFrame:GetHeight() - 300)
        messageFrame:SetPoint("TOPLEFT", PADDING, -PADDING)
        messageFrame:SetJustifyH("LEFT")
        messageFrame:SetJustifyV("TOP")
        --messageFrame:SetHyperlinksEnabled(true)
        messageFrame:SetFading(false)
        messageFrame:SetMaxLines(20000)
        --messageFrame:ScrollToTop()
    return messageFrame
end

local function createScrollBar(mainFrame, combatLogFrame)
    local scrollBar = CreateFrame("Slider", "missionHelperScrollBar", combatLogFrame, "OribosScrollBarTemplate")
    combatLogFrame.CombatLogMessageFrame.ScrollBar = scrollBar
        scrollBar:SetPoint("TOPRIGHT", combatLogFrame, "TOPRIGHT", -SCROLL_BAR_WIDTH, -30)
        scrollBar:SetSize(SCROLL_BAR_WIDTH, mainFrame:GetHeight() - 320)
        scrollBar:SetFrameLevel(combatLogFrame:GetFrameLevel() + 1)
        scrollBar:SetMinMaxValues(0, 100)
        scrollBar:SetValueStep(5)

    scrollBar:SetScript("OnValueChanged", function(self, value)
        MissionHelper.missionHelperFrame.combatLogFrame.CombatLogMessageFrame:SetScrollOffset(select(2, self:GetMinMaxValues()) - value)
    end)

    scrollBar:SetValue(select(2, scrollBar:GetMinMaxValues()))

    return scrollBar
end

local function createCombatLogFrame(mainFrame, resultInfo)
    local frame_height = mainFrame:GetHeight() - (RESULT_HEADER_HEIGHT + RESULT_INFO_HEIGHT + 3.5*PADDING)
    local combatLogFrame = CreateFrame("Frame", "missionHelperCombatLogFrame", mainFrame, "CovenantMissionBaseFrameTemplate")
    mainFrame.combatLogFrame = combatLogFrame
    combatLogFrame:SetPoint("TOPLEFT", resultInfo, "BOTTOMLEFT", 0, -PADDING/2)
    combatLogFrame:SetSize(mainFrame:GetWidth() - 2*PADDING, frame_height)
    combatLogFrame.BaseFrameBackground:SetAtlas('adventures-missions-bg-01', false)
    hideCorners(combatLogFrame)
    hideBaseCorners(combatLogFrame)

    createScrollingMessageFrame(mainFrame, combatLogFrame)
    createScrollBar(mainFrame, combatLogFrame)
    return combatLogFrame
end

function MissionHelper:createMissionHelperFrame(...)

    local mainFrame = createMainFrame()
    local resultHeader = createResultHeader(mainFrame)
    local resultInfo = createResultInfo(mainFrame)
    local combatLogFrame = createCombatLogFrame(mainFrame, resultInfo)

    mainFrame:SetScript("OnMouseWheel", function(self, delta)
        local cur_val = mainFrame.combatLogFrame.CombatLogMessageFrame.ScrollBar:GetValue()
        local min_val, max_val = mainFrame.combatLogFrame.CombatLogMessageFrame.ScrollBar:GetMinMaxValues()

        if delta < 0 and cur_val < max_val then
            cur_val = math.min(max_val, cur_val + 5)
            mainFrame.combatLogFrame.CombatLogMessageFrame.ScrollBar:SetValue(cur_val)
        elseif delta > 0 and cur_val > min_val then
            cur_val = math.max(min_val, cur_val - 5)
            mainFrame.combatLogFrame.CombatLogMessageFrame.ScrollBar:SetValue(cur_val)
        end
    end)

    mainFrame:Hide()
    MissionHelper.missionHelperFrame = mainFrame
    return mainFrame

end

function MissionHelper:editDefaultFrame(...)
    CovenantMissionFrame:ClearAllPoints()
    CovenantMissionFrame:SetPoint("CENTER", UIParent, "CENTER", -300, 0)
    if CovenantMissionFrame:GetLeft() < PADDING then
        CovenantMissionFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT",
                PADDING * CovenantMissionFrame:GetEffectiveScale(), CovenantMissionFrame:GetBottom())
    end
end

function MissionHelper:clearFrames()
    MissionHelper.missionHelperFrame.combatLogFrame.CombatLogMessageFrame:Clear()
    MissionHelper.missionHelperFrame.combatLogFrame.CombatLogMessageFrame.ScrollBar:SetMinMaxValues(0, 10)
    MissionHelper.missionHelperFrame.combatLogFrame.CombatLogMessageFrame:SetScrollOffset(0)
    MissionHelper:setResultHeader('')
    MissionHelper:setResultInfo('')
    MissionHelper:hidePredictButton()
    CMH.Board.CombatLog = {}
    CMH.Board.HiddenCombatLog = {}
    CMH.Board.CombatLogEvents = {}

end

function MissionHelper:setResultHeader(message)
    MissionHelper.missionHelperFrame.resultHeader.text:SetText(message)
end

function MissionHelper:setResultInfo(message)
    MissionHelper.missionHelperFrame.resultInfo.text:SetText(message)
end

function MissionHelper:AddCombatLogMessage(message)
    MissionHelper.missionHelperFrame.combatLogFrame.CombatLogMessageFrame:AddMessage(message)
end

function MissionHelper:hidePredictButton()
    MissionHelper.missionHelperFrame.resultInfo.predictButton:Hide()
end

function MissionHelper:showPredictButton()
    MissionHelper.missionHelperFrame.resultInfo.predictButton:Show()
end

function MissionHelper:hideBestDispositionButton()
    MissionHelper.missionHelperFrame.resultInfo.BestDispositionButton:Hide()
end

function MissionHelper:showBestDispositionButton()
    MissionHelper.missionHelperFrame.resultInfo.BestDispositionButton:Show()
end

local MissionHelper = _G["MissionHelper"]

local eventFields = {"casterBoardIndex", "spellID", "type"}
local targetFields = {"boardIndex", "maxHealth", "oldHealth", "newHealth", "points"}


function MissionHelper:compareLogs(myLog, blizzLog)
    local checks = {}
    checks["equalsRoundCount"] = (#myLog == #blizzLog)
    for round = 1, math.min(#myLog, #blizzLog) do
        local roundTable = {}
        checks["round" .. round] = roundTable
        roundTable["equalsEventCount"] = (#myLog[round].events == #blizzLog[round].events)

        for event = 1, math.min(#myLog[round].events, #blizzLog[round].events) do
            local eventTable = {}
            roundTable["event" .. event] = eventTable
            local myEvent, blizzEvent = myLog[round].events[event], blizzLog[round].events[event]
            eventTable["equalsTargetCount"] = (#myEvent.targetInfo == #blizzEvent.targetInfo)
            eventTable["equalsCasterBoardIndex"] = (myEvent.casterBoardIndex == blizzEvent.casterBoardIndex)
            eventTable["equalsSpellID"] = (myEvent.spellID == blizzEvent.spellID)

            -- I'm not differ melee spell and range spell. It actually doesn't matter.
            if (myEvent.type == Enum.GarrAutoMissionEventType.SpellMeleeDamage) or (myEvent.type == Enum.GarrAutoMissionEventType.SpellRangeDamage) then
                eventTable["equalsType"] = (blizzEvent.type == Enum.GarrAutoMissionEventType.SpellMeleeDamage or blizzEvent.type == Enum.GarrAutoMissionEventType.SpellRangeDamage)
            -- TODO: Check carefully and fix it. Now just ignore that
            elseif (myEvent.type == Enum.GarrAutoMissionEventType.PeriodicDamage or myEvent.type == Enum.GarrAutoMissionEventType.PeriodicHeal)
                    and blizzEvent.type == Enum.GarrAutoMissionEventType.ApplyAura then
                eventTable["equalsType"] = true
            -- TODO: Check carefully and fix it. Now just ignore that
            elseif (blizzEvent.type == Enum.GarrAutoMissionEventType.PeriodicDamage or blizzEvent.type == Enum.GarrAutoMissionEventType.PeriodicHeal)
                    and myEvent.type == Enum.GarrAutoMissionEventType.ApplyAura then
                eventTable["equalsType"] = true
            else
                eventTable["equalsType"] = (myEvent.type == blizzEvent.type)
            end

            for _, field in pairs(eventFields) do
                eventTable[field] = (myEvent[field] == blizzEvent[field]) and myEvent[field] or tostring(myEvent[field]) .. '|' .. tostring(blizzEvent[field])
            end

            --print(string.format('%s, %s'), round, event)
            for target = 1, math.min(#myEvent.targetInfo, #blizzEvent.targetInfo) do
                local target_table = {}
                eventTable["target" .. target] = target_table
                local myTarget, blizzTarget = myEvent.targetInfo[target], blizzEvent.targetInfo[target]
                target_table["equalsBoardIndex"] = (myTarget.boardIndex == blizzTarget.boardIndex)
                -- blizz may not save maxHP
                target_table["equalsMaxHealth"] = ((myTarget.maxHealth == blizzTarget.maxHealth) or (myTarget.maxHealth ~= 0 and blizzTarget.maxHealth == 0))
                target_table["equalsOldHealth"] = (myTarget.oldHealth == blizzTarget.oldHealth)
                target_table["equalsNewHealth"] = (myTarget.newHealth == blizzTarget.newHealth)

                -- blizzard don't save aura's points, but I do.
                if myEvent.type == Enum.GarrAutoMissionEventType.ApplyAura and blizzEvent.type == Enum.GarrAutoMissionEventType.ApplyAura and blizzTarget.points == nil then
                    target_table["equalsPoints"] = true
                else
                    target_table["equalsPoints"] = (myTarget.points == blizzTarget.points)
                end

                for _, field in pairs(targetFields) do
                    target_table[field] = (myTarget[field] == blizzTarget[field]) and myTarget[field] or tostring(myTarget[field]) .. '|' .. tostring(blizzTarget[field])
                end

                eventTable["equalsTarget" .. target] = target_table["equalsBoardIndex"] and target_table["equalsBoardIndex"]
                        and target_table["equalsMaxHealth"] and target_table["equalsOldHealth"] and target_table["equalsNewHealth"] and target_table["equalsPoints"]
            end

            if #myEvent.targetInfo < #blizzEvent.targetInfo then
                for i = #myEvent.targetInfo + 1, #blizzEvent.targetInfo do eventTable['BlizzTarget' .. i] = blizzEvent.targetInfo[i] end
            elseif #myEvent.targetInfo > #blizzEvent.targetInfo then
                for i = #blizzEvent.targetInfo + 1, #myEvent.targetInfo do eventTable['MyTarget' .. i] = myEvent.targetInfo[i] end
            end
        end

        if #myLog[round].events < #blizzLog[round].events then
                for i = #myLog[round].events + 1, #blizzLog[round].events do roundTable['BlizzEvent' .. i] = blizzLog[round].events[i] end
            elseif #myLog[round].events > #blizzLog[round].events then
                for i = #blizzLog[round].events + 1, #myLog[round].events do roundTable['MyEvent' .. i] = myLog[round].events[i] end
            end

    end

    return checks
end

--[[
function MissionHelper:showFalseValueOnly(tbl, path)
    path = path or '/'
    for i = 1, #tbl do
        if type(tbl[i]) == 'bool' and tbl[i] == false then

        end
    end
end
--]]
