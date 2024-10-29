-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, Shadowlands = ...
local Class = Shadowlands.Class
local Group = Shadowlands.Group
local L = Shadowlands.locale

local Map = Shadowlands.Map

local Collectible = Shadowlands.node.Collectible

local Achievement = Shadowlands.reward.Achievement
local Mount = Shadowlands.reward.Mount
local Pet = Shadowlands.reward.Pet
local Reward = Shadowlands.reward.Reward
local Toy = Shadowlands.reward.Toy
local Transmog = Shadowlands.reward.Transmog

-------------------------------------------------------------------------------

Shadowlands.expansion = 9

-------------------------------------------------------------------------------
------------------------------------ ICONS ------------------------------------
-------------------------------------------------------------------------------

local ICONS = "Interface\\Addons\\HandyNotes\\Icons\\artwork\\icons"
local GLOWS = "Interface\\Addons\\HandyNotes\\Icons\\artwork\\glows"
local function Icon(name) return ICONS .. '\\' .. name .. '.blp' end
local function Glow(name) return GLOWS .. '\\' .. name .. '.blp' end

Shadowlands.icons.cov_sigil_ky = {Icon('covenant_kyrian'), nil}
Shadowlands.icons.cov_sigil_nl = {Icon('covenant_necrolord'), nil}
Shadowlands.icons.cov_sigil_nf = {Icon('covenant_nightfae'), nil}
Shadowlands.icons.cov_sigil_vn = {Icon('covenant_venthyr'), nil}
Shadowlands.icons.tormentor = {Icon('tormentor'), Glow('tormentor')}

-------------------------------------------------------------------------------
---------------------------------- CALLBACKS ----------------------------------
-------------------------------------------------------------------------------

Shadowlands.addon:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', function()
    -- Listen for aura applied/removed events so we can refresh when the player
    -- enters and exits the rift in Korthia and the Maw
    local _, e, _, _, _, _, _, _, t, _, _, s = CombatLogGetCurrentEventInfo()
    if (e == 'SPELL_AURA_APPLIED' or e == 'SPELL_AURA_REMOVED') and t ==
        UnitName('player') and (s == 352795 or s == 354870) then
        C_Timer.After(1, function() Shadowlands.addon:Refresh() end)
    end
end)

Shadowlands.addon:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED', function(...)
    -- Watch for a spellcast event that signals the kitten was pet.
    -- https://www.wowhead.com/spell=321337/petting
    -- Watch for a spellcast event for collecting a shard
    -- https://Shadowlands.wowhead.com/spell=335400/collecting
    local _, source, _, spellID = ...
    if source == 'player' and (spellID == 321337 or spellID == 335400) then
        C_Timer.After(1, function() Shadowlands.addon:Refresh() end)
    end
end)

-------------------------------------------------------------------------------
------------------------------ CALLING TREASURES ------------------------------
-------------------------------------------------------------------------------

-- Add reward information to Blizzard's vignette treasures for callings

local GILDED_WADER = Pet({item = 180866, id = 2938}) -- Gilded Wader

local BLEAKWOOD_CHEST = {Pet({item = 180592, id = 2901})} -- Trapped Stonefiend
local BROKEN_SKYWARD_BELL = {GILDED_WADER, Toy({item = 184415})} -- Soothing Vesper
local DECAYED_HUSK = {
    Transmog({item = 179593, slot = L['cloth']}), -- Darkreach Mask
    Transmog({item = 179594, slot = L['leather']}) -- Witherscorn Guise
}
local GILDED_CHEST = {Toy({item = 184418})} -- Acrobatic Steward
local HIDDEN_HOARD = {GILDED_WADER}
local HUNT_SHADEHOUNDS = {Mount({item = 184167, id = 1304})} -- Mawsworn Soulhunter
local SECRET_TREASURE = {Pet({item = 180589, id = 2894})} -- Burdened Soul
local SILVER_STRONGBOX = {GILDED_WADER}
local SLIME_COATED_CRATE = {
    Pet({item = 181262, id = 2952}), -- Bubbling Pustule
    Toy({item = 184447}) -- Kevin's Party Supplies
}
local SPOUTING_GROWTH = {Pet({item = 181173, id = 2949})} -- Skittering Venomspitter

local VIGNETTES = {
    [4173] = SECRET_TREASURE,
    [4174] = SECRET_TREASURE,
    [4175] = SECRET_TREASURE,
    [4176] = SECRET_TREASURE,
    [4177] = SECRET_TREASURE,
    [4178] = SECRET_TREASURE,
    [4179] = SECRET_TREASURE,
    [4180] = SECRET_TREASURE,
    [4181] = SECRET_TREASURE,
    [4182] = SECRET_TREASURE,
    [4202] = SPOUTING_GROWTH,
    [4212] = BLEAKWOOD_CHEST,
    [4214] = GILDED_CHEST,
    [4217] = DECAYED_HUSK,
    [4218] = DECAYED_HUSK,
    [4219] = DECAYED_HUSK,
    [4220] = DECAYED_HUSK,
    [4221] = DECAYED_HUSK,
    [4239] = BROKEN_SKYWARD_BELL,
    [4240] = BROKEN_SKYWARD_BELL,
    [4241] = BROKEN_SKYWARD_BELL,
    [4242] = BROKEN_SKYWARD_BELL,
    [4243] = BROKEN_SKYWARD_BELL,
    [4263] = SILVER_STRONGBOX,
    [4264] = SILVER_STRONGBOX,
    [4265] = SILVER_STRONGBOX,
    [4266] = SILVER_STRONGBOX,
    [4267] = SILVER_STRONGBOX,
    [4268] = SILVER_STRONGBOX,
    [4269] = SILVER_STRONGBOX,
    [4270] = SILVER_STRONGBOX,
    [4271] = SILVER_STRONGBOX,
    [4272] = SILVER_STRONGBOX,
    [4273] = SILVER_STRONGBOX,
    [4275] = BROKEN_SKYWARD_BELL,
    [4276] = HIDDEN_HOARD,
    [4277] = HIDDEN_HOARD,
    [4278] = HIDDEN_HOARD,
    [4279] = HIDDEN_HOARD,
    [4280] = HIDDEN_HOARD,
    [4281] = HIDDEN_HOARD,
    [4362] = SPOUTING_GROWTH,
    [4363] = SPOUTING_GROWTH,
    [4366] = SLIME_COATED_CRATE,
    [4460] = HUNT_SHADEHOUNDS,
    [4577] = SILVER_STRONGBOX
}

hooksecurefunc(VignettePinMixin, 'OnMouseEnter', function(self)
    if self and self.vignetteInfo and self.vignetteInfo.vignetteID then
        local vignetteID = self.vignetteInfo.vignetteID
        if VIGNETTES[vignetteID] then
            --GameTooltip:AddLine(' ')
            for i, reward in ipairs(VIGNETTES[vignetteID]) do
                if reward:IsEnabled() then
                    reward:Render(GameTooltip)
                end
            end
            GameTooltip:Show()
        end
    end
end)

-------------------------------------------------------------------------------
---------------------------------- COVENANTS ----------------------------------
-------------------------------------------------------------------------------

Shadowlands.covenants = {
    KYR = {id = 1, icon = 'cov_sigil_ky', assault = 63824},
    VEN = {id = 2, icon = 'cov_sigil_vn', assault = 63822},
    FAE = {id = 3, icon = 'cov_sigil_nf', assault = 63823},
    NEC = {id = 4, icon = 'cov_sigil_nl', assault = 63543}
}

local function ProcessCovenant(node)
    local covenant = node.covenant or node.assault
    if not covenant then return end
    if node._covenantProcessed then return end

    local name = C_Covenants.GetCovenantData(covenant.id).name
    local str = node.covenant and L['covenant_required'] or
                    L['cov_assault_only']
    local subl = Shadowlands.color.Orange(string.format(str, name))
    local ricon = Shadowlands.GetIconLink(covenant.icon, 13)

    -- not compatible with rlabel getters
    if not node.getters.rlabel then
        node.rlabel = node.rlabel and node.rlabel .. ' ' .. ricon or ricon
    end
    node.sublabel = node.sublabel and subl .. '\n' .. node.sublabel or subl
    node._covenantProcessed = true
end

function Reward:GetCategoryIcon()
    return self.covenant and Shadowlands.GetIconPath(self.covenant.icon)
end

function Reward:IsObtainable()
    if self.covenant then
        if self.covenant.id ~= C_Covenants.GetActiveCovenantID() then
            return false
        end
    end
    return true
end

-------------------------------------------------------------------------------
----------------------------------- GROUPS ------------------------------------
-------------------------------------------------------------------------------

Shadowlands.groups.ANIMA_SHARD = Group('anima_shard', 'crystal_b',
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.BLESSINGS = Group('blessings', 1022951, {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.BONUS_BOSS = Group('bonus_boss', 'peg_rd',
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.CARRIAGE = Group('carriages', 'horseshoe_g',
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.CODE_CREATURE = Group('code_creature', 348545,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.CONCORDANCES = Group('concordances', 4238797,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.COVENANT_ASSAULTS = Group('covenant_assaults', 236352,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.CRYPT_COUTURE = Group('crypt_couture', 237274,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.CRYPT_KICKER = Group('crypt_kicker', 236399,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.DREDBATS = Group('dredbats', 'flight_point_g',
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.ECHOED_JIROS = Group('echoed_jiros', 'peg_gn',
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.EXILE_TALES = Group('exile_tales', 4072784,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.FAERIE_TALES = Group('faerie_tales', 355498,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.FUGITIVES = Group('fugitives', 236247, {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.GRAPPLES = Group('grapples', 'peg_bk', {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.HELGARDE_CACHE = Group('helgarde_cache', 'chest_gy',
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.HYMNS = Group('hymns', 'scroll', {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.INQUISITORS = Group('inquisitors', 3528307,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.INVASIVE_MAWSHROOM = Group('invasive_mawshroom', 134534,
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.KORTHIA_SHARED = Group('korthia_dailies', 1506458,
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.MAWSWORN_BLACKGUARD = Group('mawsworn_blackguard', 236173,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.MAWSWORN_CACHE = Group('mawsworn_cache', 3729814,
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.MAWSWORN_SUPPLY_CACHE = Group('mawsworn_supply_cache', 'chest_bk',
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.NEST_MATERIALS = Group('nest_materials', 136064,
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.NILGANIHMAHT_MOUNT = Group('nilganihmaht', 1391724,
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.PROTO_MATERIALS = Group('proto_materials', 838813,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.PROTOFORM_SCHEMATICS = Group('protoform_schematics', 4217590,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.PUZZLE_CACHE = Group('puzzle_caches', 'star_chest_g',
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.RIFT_HIDDEN_CACHE = Group('rift_hidden_cache', 'chest_bk',
    {defaults = Shadowlands.GROUP_ALPHA75})
Shadowlands.groups.RIFT_PORTAL = Group('rift_portal', 'portal_gy')
Shadowlands.groups.RIFTBOUND_CACHE = Group('riftbound_cache', 'chest_bk',
    {defaults = Shadowlands.GROUP_ALPHA75})
Shadowlands.groups.RIFTSTONE = Group('riftstone', 'portal_bl')
Shadowlands.groups.SHROUDED_CYPHER = Group('shrouded_cyphers', 'chest_pp',
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.SINRUNNER = Group('sinrunners', 'horseshoe_o',
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.SLIME_CAT = Group('slime_cat', 3732497, {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.SQUIRRELS = Group('squirrels', 237182, {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.STYGIAN_CACHES = Group('stygian_caches', 'chest_nv',
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.STYGIA_NEXUS = Group('stygia_nexus', 'peg_gn',
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.VESPERS = Group('vespers', 3536181, {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.WILD_HUNTING = Group('wild_hunting', 1604164,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.WILDSEED_SPIRITS = Group('wildseed_spirits', 895888,
    {defaults = Shadowlands.GROUP_HIDDEN})
Shadowlands.groups.ZERETH_CACHE = Group('zereth_caches', 3950362,
    {defaults = Shadowlands.GROUP_HIDDEN75})
Shadowlands.groups.ZOVAAL_VAULT = Group('zovault', 'star_chest_g',
    {defaults = Shadowlands.GROUP_ALPHA75})

Shadowlands.groups.ANIMA_VESSEL = Group('anima_vessel', 'chest_tl', {
    defaults = Shadowlands.GROUP_ALPHA75,
    IsEnabled = function(self)
        -- Anima vessels and caches cannot be seen until the "Vault Anima Tracker"
        -- upgrade is purchased from the Death's Advance quartermaster
        if not C_QuestLog.IsQuestFlaggedCompleted(64061) then
            return false
        end
        return Group.IsEnabled(self)
    end
})

Shadowlands.groups.BROKEN_MIRROR = Group('broken_mirror', 3854020, {
    defaults = Shadowlands.GROUP_ALPHA75,
    IsEnabled = function(self)
        -- Broken mirrors are Venthyr-only (might have completed the quest and then swapped covenants)
        if C_Covenants.GetActiveCovenantID() ~= 2 then return false end
        -- Broken mirrors cannot be accessed until the quest "Repair and Restore" is completed
        if not C_QuestLog.IsQuestFlaggedCompleted(59740) then
            return false
        end
        return Group.IsEnabled(self)
    end
})

Shadowlands.groups.RELIC = Group('relic', 'star_chest_b', {
    defaults = Shadowlands.GROUP_ALPHA75,
    IsEnabled = function(self)
        -- Relics cannot be collected until the quest "What Must Be Found" is completed
        if not C_QuestLog.IsQuestFlaggedCompleted(64506) then
            return false
        end
        return Group.IsEnabled(self)
    end
})

Shadowlands.groups.CORELESS_AUTOMA = Group('coreless_automa', 4327618, {
    defaults = Shadowlands.GROUP_HIDDEN,
    IsEnabled = function(self)
        -- Coreless automa cannot be controlled by Pocopoc until the quest "Core Control" is complete
        if not C_QuestLog.IsQuestFlaggedCompleted(65700) then
            return false
        end
        return Group.IsEnabled(self)
    end
})

Shadowlands.groups.SAFARI = Group('safari', 3046536, {defaults = Shadowlands.GROUP_HIDDEN})

-------------------------------------------------------------------------------
--------------------------------- SOULSHAPES ----------------------------------
-------------------------------------------------------------------------------

local Soulshape = Class('Soulshape', Collectible, {
    covenant = Shadowlands.covenants.FAE,
    IsEnabled = function(self)
        if C_Covenants.GetActiveCovenantID() ~= Shadowlands.covenants.FAE.id then
            return false
        end
        return Collectible.IsEnabled(self)
    end
})

Shadowlands.node.Soulshape = Soulshape

-------------------------------------------------------------------------------
------------------ TO ALL THE SQUIRRELS I'VE LOVED AND LOST -------------------
-------------------------------------------------------------------------------

local Squirrel = Class('Squirrel', Collectible, {
    group = Shadowlands.groups.SQUIRRELS,
    icon = 237182,
    note = L['squirrels_note']
})

Shadowlands.node.Squirrel = Squirrel

-------------------------------------------------------------------------------
------------------------------------ MAPS -------------------------------------
-------------------------------------------------------------------------------

local SLMap = Class('ShadowlandsMap', Map)

function SLMap:Prepare()
    Map.Prepare(self)
    for coord, node in pairs(self.nodes) do
        -- Update rlabel and sublabel for covenant-restricted nodes
        ProcessCovenant(node)
    end
end

Shadowlands.Map = SLMap

-------------------------------------------------------------------------------

local RiftMap = Class('RiftMap', SLMap)

function RiftMap:Prepare()
    SLMap.Prepare(self)

    self.rifted = false
    for i, spellID in ipairs {352795, 354870} do
        if AuraUtil.FindAuraByName(Shadowlands.api.GetSpellInfo(spellID), 'player') then
            self.rifted = true
        end
    end
end

function RiftMap:CanDisplay(node, coord, minimap)
    -- check node's rift availability (nil=no, 1=yes, 2=both)
    if self.rifted and not node.rift then return false end
    if not self.rifted and node.rift == 1 then return false end
    return SLMap.CanDisplay(self, node, coord, minimap)
end

Shadowlands.RiftMap = RiftMap

-------------------------------------------------------------------------------
--------------------------------- REQUIREMENTS --------------------------------
-------------------------------------------------------------------------------

local Venari = Class('Venari', Shadowlands.requirement.Requirement)

function Venari:Initialize(quest)
    self.text = L['venari_upgrade']
    self.quest = quest
end

function Venari:IsMet() return C_QuestLog.IsQuestFlaggedCompleted(self.quest) end

Shadowlands.requirement.Venari = Venari

-------------------------------------------------------------------------------
------------------------------------ SAFARI -----------------------------------
-------------------------------------------------------------------------------

local Safari = Class('Safari', Collectible,
    {icon = 'paw_g', group = Shadowlands.groups.SAFARI})

Shadowlands.node.Safari = {
    AnimatedCruor = Class('AnimatedCruor', Safari, {
        id = 175023,
        rewards = {
            Achievement({id = 14867, criteria = 50923, oneline = true}),
            Pet({id = 3051})
        }
    }),
    BleakSkitterer = Class('BleakSkitterer', Safari, {
        id = 175022,
        rewards = {
            Achievement({id = 14867, criteria = 50926, oneline = true}),
            Pet({id = 3050})
        }
    }),
    Clutch = Class('Clutch', Safari, {
        id = 172130,
        rewards = {
            Achievement({id = 14867, criteria = 50922, oneline = true}),
            Pet({id = 2950})
        }
    }),
    CopperfurKit = Class('CopperfurKit', Safari, {
        id = 171702,
        rewards = {
            Achievement({id = 14867, criteria = 50916, oneline = true}),
            Pet({id = 2936})
        }
    }),
    Crawbat = Class('Crawbat', Safari, {
        id = 176024,
        rewards = {
            Achievement({id = 14867, criteria = 51096, oneline = true}),
            Pet({id = 3083})
        }
    }),
    DecayGrub = Class('DecayGrub', Safari, {
        id = 176020,
        rewards = {
            Achievement({id = 14867, criteria = 51094, oneline = true}),
            Pet({id = 3081})
        }
    }),
    DeepwoodLeaper = Class('DeepwoodLeaper', Safari, {
        id = 173590,
        rewards = {
            Achievement({id = 14867, criteria = 50921, oneline = true}),
            Pet({id = 3021})
        }
    }),
    DuskyDredwingPup = Class('DuskyDredwingPup', Safari, {
        id = 171149,
        rewards = {
            Achievement({id = 14867, criteria = 50907, oneline = true}),
            Pet({id = 2902})
        }
    }),
    FledglingTeroclaw = Class('FledglingTeroclaw', Safari, {
        id = 171567,
        rewards = {
            Achievement({id = 14867, criteria = 50911, oneline = true}),
            Pet({id = 2926})
        }
    }),
    FlutteringGlimmerfly = Class('FlutteringGlimmerfly', Safari, {
        id = 171664,
        rewards = {
            Achievement({id = 14867, criteria = 50913, oneline = true}),
            Pet({id = 2927})
        }
    }),
    GlimmerpoolHatchling = Class('GlimmerpoolHatchling', Safari, {
        id = 171670,
        rewards = {
            Achievement({id = 14867, criteria = 50917, oneline = true}),
            Pet({id = 2930})
        }
    }),
    GormRootstinger = Class('GormRootstinger', Safari, {
        id = 171229,
        rewards = {
            Achievement({id = 14867, criteria = 50919, oneline = true}),
            Pet({id = 2919})
        }
    }),
    LostSoul = Class('LostSoul', Safari, {
        id = 171123,
        rewards = {
            Achievement({id = 14867, criteria = 50906, oneline = true}),
            Pet({id = 2895})
        }
    }),
    MireCreeper = Class('MireCreeper', Safari, {
        id = 173555,
        rewards = {
            Achievement({id = 14867, criteria = 50909, oneline = true}),
            Pet({id = 3014})
        }
    }),
    NecroraySpawnling = Class('NecroraySpawnling', Safari, {
        id = 175024,
        rewards = {
            Achievement({id = 14867, criteria = 50924, oneline = true}),
            Pet({id = 3052})
        }
    }),
    PulsatingMaggot = Class('PulsatingMaggot', Safari, {
        id = 175021,
        rewards = {
            Achievement({id = 14867, criteria = 50925, oneline = true}),
            Pet({id = 3049})
        }
    }),
    RosetippedSpiderling = Class('RosetippedSpiderling', Safari, {
        id = 173506,
        rewards = {
            Achievement({id = 14867, criteria = 50910, oneline = true}),
            Pet({id = 3007})
        }
    }),
    RustfurKit = Class('RustfurKit', Safari, {
        id = 171703,
        rewards = {
            Achievement({id = 14867, criteria = 50915, oneline = true}),
            Pet({id = 2937})
        }
    }),
    Starmoth = Class('Starmoth', Safari, {
        id = 176021,
        rewards = {
            Achievement({id = 14867, criteria = 51095, oneline = true}),
            Pet({id = 3082})
        }
    }),
    TranquilWader = Class('TranquilWader', Safari, {
        id = 171228,
        rewards = {
            Achievement({id = 14867, criteria = 50920, oneline = true}),
            Pet({id = 2924})
        }
    }),
    VerdantKit = Class('VerdantKit', Safari, {
        id = 176019,
        rewards = {
            Achievement({id = 14867, criteria = 51093, oneline = true}),
            Pet({id = 3080})
        }
    }),
    VibrantGlimmerfly = Class('VibrantGlimmerfly', Safari, {
        id = 171668,
        rewards = {
            Achievement({id = 14867, criteria = 50912, oneline = true}),
            Pet({id = 2929})
        }
    }),
    WaderChick = Class('WaderChick', Safari, {
        id = 171712,
        rewards = {
            Achievement({id = 14867, criteria = 50914, oneline = true}),
            Pet({id = 2939})
        }
    }),
    WildEtherwyrm = Class('WildEtherwyrm', Safari, {
        id = 171666,
        rewards = {
            Achievement({id = 14867, criteria = 50918, oneline = true}),
            Pet({id = 2943})
        }
    }),
    WitheringCreeper = Class('WitheringCreeper', Safari, {
        id = 173556,
        rewards = {
            Achievement({id = 14867, criteria = 50908, oneline = true}),
            Pet({id = 3015})
        }
    })
}
