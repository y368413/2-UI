-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, Shadowlands = ...

local L = Shadowlands.locale
local Map = Shadowlands.Map

local Node = Shadowlands.node.Node

local Achievement = Shadowlands.reward.Achievement
local Item = Shadowlands.reward.Item
local Mount = Shadowlands.reward.Mount
local Pet = Shadowlands.reward.Pet
local Section = Shadowlands.reward.Section
local Spacer = Shadowlands.reward.Spacer
local Title = Shadowlands.reward.Title
local Toy = Shadowlands.reward.Toy
local Transmog = Shadowlands.reward.Transmog

local NIGHTFAE = Shadowlands.covenants.FAE

-------------------------------------------------------------------------------

local map = Map({id = 1911, settings = true})

-------------------------------------------------------------------------------
---------------------- TORGHAST, THE TOWER OF THE DAMNED ----------------------
-------------------------------------------------------------------------------

map.nodes[53284528] = Node({
    label = L['torghast_the_tower_of_the_damned'],
    sublabel = L['torghast_reward_sublabel'],
    note = L['torghast_boss_note'],
    icon = 3642306,
    scale = 1.5,
    rewards = {
        Transmog({item = 187027}), -- Skoldus' Shoulder Skewers
        Transmog({item = 187030}), -- Deathsworn Shoulderguards
        Transmog({item = 187031}), -- Towering Mantle of the Maw
        Transmog({item = 187032}), -- Spaulders of Prophetic Death
        Transmog({item = 187038}), -- Shoulders of Vehement Slicing
        Transmog({item = 187039}), -- Malleare's Stygian Pauldrons
        Transmog({item = 187040}), -- Twin-Scythe Spaulders
        Transmog({item = 187041}), -- Shoulders of Unbreakable Demise
        Transmog({item = 187042}), -- Occultist's Ornamental Gorget
        Transmog({item = 187043}), -- Spiked Citadel Shoulderguards
        Transmog({item = 187044}), -- Deathbringer's Epaulettes
        Transmog({item = 187045}), -- Veiled Tormentor's Mantle
        Transmog({item = 187046}), -- Pauldrons of Immaculate Laceration
        Transmog({item = 187096}), -- Adamant Vault Shoulderplates
        Transmog({item = 188686, slot = L['cloak']}), -- Burnished Soul Restraint
        Transmog({item = 188687, slot = L['cloak']}), -- Burnished Skull Crescent
        Transmog({item = 188688, slot = L['cloak']}), -- Burnished Eye Crescent
        Spacer(), Toy({item = 187075}), -- Box of Rattling Chains
        Spacer(), Section(L['torghast_soulshape_note']),
        Item({item = 189977, quest = 65509, covenant = NIGHTFAE}), -- Bat Soul
        Item({item = 189971, quest = 65504, covenant = NIGHTFAE}), -- Dragonhawk Soul
        Item({item = 189975, quest = 65507, covenant = NIGHTFAE}), -- Elekk Soul
        Item({item = 189987, quest = 65515, covenant = NIGHTFAE}), -- Pig Soul
        Item({item = 189976, quest = 65508, covenant = NIGHTFAE}), -- Tallstrider Soul
        Spacer(), Section(L['colossal_umbrahide_mawrat_note']),
        Mount({item = 188700, id = 1565}) -- Colossal Umbrahide Mawrat
    }
})

map.nodes[57284528] = Node({
    label = L['torghast_the_tower_of_the_damned'],
    sublabel = L['torghast_reward_sublabel'],
    note = L['torghast_vendor_note'],
    icon = 3642306,
    scale = 1.5,
    rewards = {
        Transmog({item = 187034, slot = L['cloak']}), -- Gilded Agony Cage
        Transmog({item = 187082, slot = L['cloak']}), -- Gilded Skull Crescent
        Transmog({item = 187083, slot = L['cloak']}), -- Gilded Eye Crescent
        Transmog({item = 187085}), -- Sterling Shoulder Skewers
        Transmog({item = 187086}), -- Deathsworn's Sterling Shoulderguards
        Transmog({item = 187087}), -- Sterling Impaler's Mantle
        Transmog({item = 187088}), -- Sterling Skullwing Shoulders
        Transmog({item = 187089}), -- Sterling Blade-Tipped Spaulders
        Transmog({item = 187090}), -- Sterling Wingblade Pauldrons
        Transmog({item = 187095}), -- Sterling Spiked Pauldrons
        Transmog({item = 187098}), -- Sterling Twin-Scythe Shoulders
        Transmog({item = 187099}), -- Sterling Fortress Spaulders
        Transmog({item = 187100}), -- Sterling Ornamental Mantle
        Transmog({item = 187101}) -- Sterling Shoulder-Shields
    }
})

map.nodes[55285000] = Node({
    label = L['torghast_the_tower_of_the_damned'],
    sublabel = L['torghast_reward_sublabel'],
    note = L['torghast_reward_note'],
    icon = 3642306,
    scale = 1.5,
    rewards = {
        Achievement({
            id = 14501,
            criteria = ({id = 49174, qty = true, suffix = L['phantasma_note']})
        }), -- Phanatical
        Achievement({
            id = 14773,
            criteria = ({
                id = 49953,
                qty = true,
                suffix = L['bloating_fodder_note']
            })
        }), -- Explosive Extermination
        Achievement({id = 14776}), -- For the Hoarder!
        Achievement({
            id = 15075,
            criteria = {
                52170, -- Karthazel
                52171, -- Sath'zuul
                52172 -- Vil'thras
            }
        }), -- Infiltrators
        Achievement({id = 15091}), -- A Taste of Perfection
        Achievement({
            id = 15092,
            criteria = {
                52203, -- Avenge me!
                52204, -- No Doubt
                52205, -- Rampage
                52206 -- Crowd Pleaser
            }
        }), -- Master of Torment
        Achievement({
            id = 15324,
            criteria = {
                52870, -- Flawless Master (Layer 16)
                52871, -- Adamant Vaults
                52872, -- Twisting Corridors: Layer 8
                52873, -- The Jailer's Gauntlet: Layer 4
                52874 -- Master of Torment
            }
        }), -- Tower Ranger
        Section(L['flawless_master_note']), Mount({item = 188736, id = 1564}), -- Colassal Soulshredder Mawrat
        Spacer(), Section(L['tower_ranger_note']),
        Title({id = 450, criteria = 15324, pattern = '{player}, {title}'}) -- %s, Tower Ranger
    }
})

-------------------------------------------------------------------------------
------------------------------- TORGHAST WINGS --------------------------------
-------------------------------------------------------------------------------

map.nodes[47731915] = Node({
    label = L['skoldus_hall'],
    sublabel = L['torghast_reward_sublabel'],
    icon = 3555135,
    scale = 1.5,
    rewards = {
        Achievement({id = 14810, criteria = 48160}), -- Terror of Torghast
        Achievement({
            id = 14498,
            criteria = {
                49162, -- Custodian Thonar
                49163 -- Warden Skoldus
            }
        }), -- Gatekeepers of Torghast
        Achievement({
            id = 14778,
            criteria = {
                49977, -- Maw Seeker Mount
                49991, -- Mawrat Harness
                49979, -- Warden's Authority
                49981, -- Pocketed Soulcage
                49982, -- Shackle Keys
                49985, -- Flamestarved Cinders
                49986, -- Glasswing Charm
                49989 -- Prisoner's Concord
            }
        }), -- Extremely Ravenous
        Achievement({id = 15322, criteria = 52847}), -- Flawless Master (Layer 16)
        Pet({item = 183117, id = 3028}), -- Severs
        Pet({item = 183191, id = 3029}), -- Maw Crawler
        Pet({item = 183192, id = 3032}), -- Frenzied Mawrat
        Pet({item = 183193, id = 3030}), -- Ashen Chomper
        Pet({item = 183194, id = 3033}) -- Maw Stalker
    }
}) -- Skoldus Hall

map.nodes[55191700] = Node({
    label = L['fracture_chambers'],
    sublabel = L['torghast_reward_sublabel'],
    icon = 3592448,
    scale = 1.5,
    rewards = {
        Achievement({id = 14810, criteria = 48161}), -- Terror of Torghast
        Achievement({
            id = 14498,
            criteria = {
                49164, -- Writhing Soulmass
                49165, -- Kosarus the Fallen
                49167 -- Gherus the Chained
            }
        }), -- Gatekeepers of Torghast
        Achievement({
            id = 14778,
            criteria = {
                49991, -- Mawrat Harness
                49979, -- Warden's Authority
                49985, -- Flamestarved Cinders
                49986, -- Glasswing Charm
                49987, -- Marrow Scooper
                49988, -- Skeletal Ward
                49989 -- Prisoner's Concord
            }
        }), -- Extremely Ravenous
        Achievement({id = 15322, criteria = 52848}) -- Flawless Master (Layer 16)
    }
}) -- Fracture Chambers

map.nodes[63001915] = Node({
    label = L['the_soulforges'],
    sublabel = L['torghast_reward_sublabel'],
    icon = 467102,
    scale = 1.5,
    rewards = {
        Achievement({id = 14810, criteria = 48162}), -- Terror of Torghast
        Achievement({
            id = 14498,
            criteria = {
                49159, -- Arch-Suppressor Laguas
                49161, -- Observer Zelgar
                49166, -- The Grand Malleare
                49168 -- Cellblock Sentinel
            }
        }), -- Gatekeepers of Torghast
        Achievement({
            id = 14778,
            criteria = {
                49977, -- Maw Seeker Mount
                49991, -- Mawrat Harness
                49979, -- Warden's Authority
                49981, -- Pocketed Soulcage
                49982, -- Shackle Keys
                49985, -- Flamestarved Cinders
                49986, -- Glasswing Charm
                49989 -- Prisoner's Concord
            }
        }), -- Extremely Ravenous
        Achievement({id = 15322, criteria = 52845}), -- Flawless Master (Layer 16)
        Pet({item = 183117, id = 3028}), -- Severs
        Pet({item = 183191, id = 3029}), -- Maw Crawler
        Pet({item = 183194, id = 3033}) -- Maw Stalker
    }
}) -- The Soulforges

map.nodes[73943537] = Node({
    label = L['coldheart_interstitia'],
    sublabel = L['torghast_reward_sublabel'],
    icon = 3552748,
    scale = 1.5,
    rewards = {
        Achievement({id = 14810, criteria = 48164}), -- Terror of Torghast
        Achievement({
            id = 14498,
            criteria = {
                49158, -- Dark Aspirant Corrus
                49516, -- Elder Longbranch
                49517 -- Decayspeaker
            }
        }), -- Gatekeepers of Torghast
        Achievement({
            id = 14778,
            criteria = {
                49974, -- Dark Armaments
                49977, -- Maw Seeker Mount
                49991, -- Mawrat Harness
                49979, -- Warden's Authority
                49981, -- Pocketed Soulcage
                49982, -- Shackle Keys
                49985, -- Flamestarved Cinders
                49986, -- Glasswing Charm
                49989 -- Prisoner's Concord
            }
        }), -- Extremely Ravenous
        Achievement({id = 15322, criteria = 52846}), -- Flawless Master (Layer 16)
        Pet({item = 183115, id = 3026}), -- Tower Deathroach
        Pet({item = 183116, id = 3027}) -- Hissing Deathroach
    }
}) -- Coldheart Interstitia

map.nodes[75474699] = Node({
    label = L['mortregar'],
    sublabel = L['torghast_reward_sublabel'],
    icon = 3586456,
    scale = 1.5,
    rewards = {
        Achievement({id = 14810, criteria = 48163}), -- Terror of Torghast
        Achievement({
            id = 14498,
            criteria = {
                49169, -- Warden of Souls
                49170, -- Binder Baritas
                49171, -- Maw of the Maw
                49515 -- Watchers of Death
            }
        }), -- Gatekeepers of Torghast
        Achievement({
            id = 14778,
            criteria = {
                49976, -- Deadsoul Hound Harness
                49991, -- Mawrat Harness
                49979, -- Warden's Authority
                49984, -- Purifier's Flame
                49985, -- Flamestarved Cinders
                49986, -- Glasswing Charm
                49989 -- Prisoner's Concord
            }
        }), -- Extremely Ravenous
        Achievement({id = 15322, criteria = 52844}), -- Flawless Master (Layer 16)
        Pet({item = 183195, id = 3034}) -- Torghast Lurker
    }
}) -- Mort'regar

map.nodes[73845861] = Node({
    label = L['the_upper_reaches'],
    sublabel = L['torghast_reward_sublabel'],
    icon = 522867,
    scale = 1.5,
    rewards = {
        Achievement({id = 14810, criteria = 48165}), -- Terror of Torghast
        Achievement({
            id = 14498,
            criteria = {
                49160, -- Goxul the Devourer
                49172, -- Synod
                49173 -- Patrician Cromwell
            }
        }), -- Gatekeepers of Torghast
        Achievement({
            id = 14778,
            criteria = {
                49991, -- Mawrat Harness
                49979, -- Warden's Authority
                49982, -- Shackle Keys
                49985, -- Flamestarved Cinders
                49986, -- Glasswing Charm
                49987, -- Marrow Scooper
                49988, -- Skeletal Ward
                49989 -- Prisoner's Concord
            }
        }), -- Extremely Ravenous
        Achievement({id = 15322, criteria = 52843}), -- Flawless Master (Layer 16)
        Pet({item = 183117, id = 3028}), -- Severs
        Pet({item = 183191, id = 3029}), -- Maw Crawler
        Pet({item = 183194, id = 3033}) -- Maw Stalker
    }
}) -- The Upper Reaches

-------------------------------------------------------------------------------
------------------------------- ADAMANT VAULTS --------------------------------
-------------------------------------------------------------------------------

map.nodes[62947482] = Node({
    label = L['adamant_vaults'],
    icon = 3853943,
    scale = 1.5,
    requires = Shadowlands.requirement.GarrisonTalent(1788),
    rewards = {
        Transmog({item = 187081, slot = L['cloak']}), -- Blackflame Skull Crescent
        Transmog({item = 187084, slot = L['cloak']}), -- Jailer's Eye Crescent
        Transmog({item = 187025, slot = L['cloak']}), -- Painbringer's Back-Prison
        Transmog({item = 187093}), -- Gilded Ornamental Mantle
        Transmog({item = 187092}), -- Gilded Shoulder-Shields
        Transmog({item = 187094}), -- Gilded Spike Fortresses
        Transmog({item = 187091}), -- Gilded Twin-Scythe Shoulders
        Spacer(), --
        Pet({item = 186549, id = 3130}), -- Gilded Darknight
        Toy({item = 187417}), -- Adamant Vaults Cell
        Item({item = 187148, quest = 64347}), -- Death-Bound Shard
        Item({item = 185049, quest = 63605, covenant = NIGHTFAE}), -- Sauolisk Soul
        Achievement({id = 15324, criteria = 52871}) -- Adamant Vaults
    }
}) -- Adamant Vaults

-------------------------------------------------------------------------------
----------------------------- TWISTING CORRIDORS ------------------------------
-------------------------------------------------------------------------------

map.nodes[55197712] = Node({
    label = L['twisting_corridors'],
    icon = 3717273,
    scale = 1.5,
    requires = Shadowlands.requirement.Quest(62836),
    rewards = {
        Section(L['torghast_layer2']), Pet({item = 183412, id = 3041}), -- Death Seeker
        Spacer(), Section(L['torghast_layer4']), Toy({item = 184223}), -- Helm of the Dominated
        Spacer(), Section(L['torghast_layer6']),
        Title({id = 438, criteria = 14568, pattern = '{title} {player}'}), -- Spirestalker %s
        Spacer(), Section(L['torghast_layer8']),
        Mount({item = 184166, id = 1442}), -- Corridor Creeper
        Achievement({id = 15324, criteria = 52872}) -- Twisting Cordidors: Layer 8
    }
}) -- Twisting Corridors

-------------------------------------------------------------------------------
---------------------------- THE JAILER'S GAUNTLET ----------------------------
-------------------------------------------------------------------------------

map.nodes[47447453] = Node({
    label = L['the_jailers_gauntlet'],
    note = L['the_jailers_gauntlet_note'],
    icon = 3717264,
    scale = 1.5,
    rewards = {
        Section(L['torghast_layer1']), Pet({item = 188679, id = 3221}), -- Lightless Tormentor
        Spacer(), Section(L['torghast_layer2']), Toy({item = 188952}), -- Dominated Heathstone
        Spacer(), Section(L['torghast_layer3']),
        Title({id = 449, criteria = 15253, pattern = '{title} {player}'}), -- Gauntlet Runner %s
        Spacer(), Section(L['torghast_layer4']),
        Mount({item = 188696, id = 1566}), -- Colossal Ebonclaw Mawrat
        Achievement({id = 15324, criteria = 52873}) -- The Jailer's Gauntlet: Layer 4
    }
}) -- The Jailer's Gauntlet

-------------------------------------------------------------------------------
--------------------------- THE BOX OF MANY THINGS ----------------------------
-------------------------------------------------------------------------------

map.nodes[36044728] = Node({
    label = L['the_box_of_many_things'],
    note = L['the_box_of_many_things_note'],
    icon = 4094821,
    scale = 1.5,
    requires = Shadowlands.requirement.Quest(64216),
    rewards = {
        Achievement({id = 15076}), -- The Box of Many Things
        Achievement({id = 15079}), -- Many, Many Things
        Achievement({id = 15080}), -- So Blessed
        Section(L['many_many_things_section']), Pet({item = 186551, id = 3132}) -- Mord'al Eveningstar
    }
}) -- The Box of Many Things

-------------------------------------------------------------------------------
------------------------------- THE RUNECARVER --------------------------------
-------------------------------------------------------------------------------

map.nodes[15786023] = Node({
    label = L['the_runecarver'],
    icon = 607854,
    scale = 1.5,
    rewards = {
        Achievement({id = 14754}), -- The Forgotten One
        Achievement({id = 14755}), -- Legendary Accord
        Achievement({
            id = 14795,
            criteria = ({
                id = 49892,
                qty = true,
                suffix = L['clearing_the_fog_suffix']
            }) -- Clearing the Fog
        })
    }
})
