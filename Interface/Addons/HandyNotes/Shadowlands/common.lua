-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local HANDYNOTES_SHADOWLANDS, shadowlands = ...
local Class = shadowlands.Class
local Group = shadowlands.Group
local L = shadowlands.locale

local Map = shadowlands.Map

local Item  = shadowlands.reward.Item
local Mount = shadowlands.reward.Mount
local Pet = shadowlands.reward.Pet
local Reward = shadowlands.reward.Reward
local Toy = shadowlands.reward.Toy
local Transmog = shadowlands.reward.Transmog

-------------------------------------------------------------------------------

shadowlands.expansion = 9

-------------------------------------------------------------------------------
------------------------------------ ICONS ------------------------------------
-------------------------------------------------------------------------------

local ICONS = "Interface\\Addons\\"..HANDYNOTES_SHADOWLANDS.."\\artwork\\icons"
local function Icon(name) return ICONS..'\\'..name..'.blp' end

shadowlands.icons.cov_sigil_ky = {Icon('covenant_kyrian'), nil}
shadowlands.icons.cov_sigil_nl = {Icon('covenant_necrolord'), nil}
shadowlands.icons.cov_sigil_nf = {Icon('covenant_nightfae'), nil}
shadowlands.icons.cov_sigil_vn = {Icon('covenant_venthyr'), nil}

-------------------------------------------------------------------------------
---------------------------------- CALLBACKS ----------------------------------
-------------------------------------------------------------------------------

shadowlands.addon:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', function ()
    -- Listen for aura applied/removed events so we can refresh when the player
    -- enters and exits the rift in Korthia and the Maw
    local _,e,_,_,_,_,_,_,t,_,_,s  = CombatLogGetCurrentEventInfo()
    if (e == 'SPELL_AURA_APPLIED' or e == 'SPELL_AURA_REMOVED') and
        t == UnitName('player') and (s == 352795 or s == 354870) then
        C_Timer.After(1, function() shadowlands.addon:Refresh() end)
    end
end)

shadowlands.addon:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED', function (...)
    -- Watch for a spellcast event that signals the kitten was pet.
    -- https://www.wowhead.com/spell=321337/petting
    -- Watch for a spellcast event for collecting a shard
    -- https://shadowlands.wowhead.com/spell=335400/collecting
    local _, source, _, spellID = ...
    if source == 'player' and (spellID == 321337 or spellID == 335400) then
        C_Timer.After(1, function() shadowlands.addon:Refresh() end)
    end
end)

-------------------------------------------------------------------------------
------------------------------ CALLING TREASURES ------------------------------
-------------------------------------------------------------------------------

-- Add reward information to Blizzard's vignette treasures for callings

local GILDED_WADER = Pet({item=180866, id=2938}) -- Gilded Wader

local BLEAKWOOD_CHEST = { Pet({item=180592, id=2901}) } -- Trapped Stonefiend
local BROKEN_SKYWARD_BELL = { GILDED_WADER, Toy({item=184415}) } -- Soothing Vesper
local DECAYED_HUSK = {
    Transmog({item=179593, slot=L["cloth"]}), -- Darkreach Mask
    Transmog({item=179594, slot=L["leather"]}), -- Witherscorn Guise
}
local GILDED_CHEST = { Toy({item=184418}) } -- Acrobatic Steward
local HIDDEN_HOARD = { GILDED_WADER }
local HUNT_SHADEHOUNDS = { Mount({item=184167, id=1304}) } -- Mawsworn Soulhunter
local SECRET_TREASURE = { Pet({item=180589, id=2894}) } -- Burdened Soul
local SILVER_STRONGBOX = { GILDED_WADER }
local SLIME_COATED_CRATE = {
    Pet({item=181262, id=2952}), -- Bubbling Pustule
    Toy({item=184447}) -- Kevin's Party Supplies
}
local SPOUTING_GROWTH = { Pet({item=181173, id=2949}) } -- Skittering Venomspitter

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

local vignetteHandled = false

hooksecurefunc(GameTooltip, 'Show', function(self)
    if vignetteHandled then return end
    local owner = self:GetOwner()
    if owner and owner.vignetteID then
        local rewards = VIGNETTES[owner.vignetteID]
        if rewards and #rewards > 0 then
            self:AddLine(' ') -- add blank line before rewards
            for i, reward in ipairs(rewards) do
                if reward:IsEnabled() then
                    reward:Render(self)
                end
            end
            vignetteHandled = true
            self:Show()
       end
    end
end)

hooksecurefunc(GameTooltip, 'ClearLines', function(self)
    vignetteHandled = false
end)

-------------------------------------------------------------------------------
---------------------------------- COVENANTS ----------------------------------
-------------------------------------------------------------------------------

shadowlands.covenants = {
    KYR = { id = 1, icon = 'cov_sigil_ky' },
    VEN = { id = 2, icon = 'cov_sigil_vn' },
    FAE = { id = 3, icon = 'cov_sigil_nf' },
    NEC = { id = 4, icon = 'cov_sigil_nl' }
}

local function ProcessCovenant (node)
    if node.covenant == nil then return end
    local data = C_Covenants.GetCovenantData(node.covenant.id)

    -- Add covenant sigil to top-right corner of tooltip
    node.rlabel = shadowlands.GetIconLink(node.covenant.icon, 13)

    if not node._covenantProcessed then
        local subl = shadowlands.color.Orange(string.format(L["covenant_required"], data.name))
        node.sublabel = node.sublabel and subl..'\n'..node.sublabel or subl
        node._covenantProcessed = true
    end
end

function Reward:GetCategoryIcon()
    return self.covenant and shadowlands.GetIconPath(self.covenant.icon)
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

shadowlands.groups.ANIMA_SHARD = Group('anima_shard', 'crystal_b', {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.BLESSINGS = Group('blessings', 1022951, {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.BONUS_BOSS = Group('bonus_boss', 'peg_rd', {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.CARRIAGE = Group('carriages', 'horseshoe_g', {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.DREDBATS = Group('dredbats', 'flight_point_g', {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.FAERIE_TALES = Group('faerie_tales', 355498, {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.FUGITIVES = Group('fugitives', 236247, {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.GRAPPLES = Group('grapples', 'peg_bk', {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.HYMNS = Group('hymns', 'scroll', {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.INQUISITORS = Group('inquisitors', 3528307, {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.INVASIVE_MAWSHROOM = Group('invasive_mawshroom', 134534, {defaults=shadowlands.GROUP_HIDDEN75})
shadowlands.groups.KORTHIA_SHARED = Group('korthia_dailies', 1506458, {defaults=shadowlands.GROUP_HIDDEN75})
shadowlands.groups.MAW_LORE = Group('maw_lore', 'chest_gy')
shadowlands.groups.MAWSWORN_CACHE = Group('mawsworn_cache', 3729814, {defaults=shadowlands.GROUP_HIDDEN75})
shadowlands.groups.NEST_MATERIALS = Group('nest_materials', 136064, {defaults=shadowlands.GROUP_HIDDEN75})
shadowlands.groups.NILGANIHMAHT_MOUNT = Group('nilganihmaht', 1391724, {defaults=shadowlands.GROUP_HIDDEN75})
shadowlands.groups.STYGIA_NEXUS = Group('stygia_nexus', 'peg_gn', {defaults=shadowlands.GROUP_HIDDEN75})
shadowlands.groups.RIFTSTONE = Group('riftstone', 'portal_bl')
shadowlands.groups.RIFTBOUND_CACHE = Group('riftbound_cache', 'chest_bk', {defaults=shadowlands.GROUP_ALPHA75})
shadowlands.groups.RIFT_HIDDEN_CACHE = Group('rift_hidden_cache', 'chest_bk', {defaults=shadowlands.GROUP_ALPHA75})
shadowlands.groups.RIFT_PORTAL = Group('rift_portal', 'portal_gy')
shadowlands.groups.SINRUNNER = Group('sinrunners', 'horseshoe_o', {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.SLIME_CAT = Group('slime_cat', 3732497, {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.STYGIAN_CACHES = Group('stygian_caches', 'chest_nv', {defaults=shadowlands.GROUP_HIDDEN})
shadowlands.groups.VESPERS = Group('vespers', 3536181, {defaults=shadowlands.GROUP_HIDDEN})

shadowlands.groups.ANIMA_VESSEL = Group('anima_vessel', 'chest_tl', {
    defaults=shadowlands.GROUP_ALPHA75,
    IsEnabled=function (self)
        -- Anima vessels and caches cannot be seen until the "Vault Anima Tracker"
        -- upgrade is purchased from the Death's Advance quartermaster
        if not C_QuestLog.IsQuestFlaggedCompleted(64061) then return false end
        return Group.IsEnabled(self)
    end
})

shadowlands.groups.RELIC = Group('relic', 'star_chest_b', {
    defaults=shadowlands.GROUP_ALPHA75,
    IsEnabled=function (self)
        -- Relics cannot be collected until the quest "What Must Be Found" is completed
        if not C_QuestLog.IsQuestFlaggedCompleted(64506) then return false end
        return Group.IsEnabled(self)
    end
})

-------------------------------------------------------------------------------
------------------------------------ MAPS -------------------------------------
-------------------------------------------------------------------------------

local SLMap = Class('ShadowlandsMap', Map)

function SLMap:Prepare ()
    Map.Prepare(self)
    for coord, node in pairs(self.nodes) do
        -- Update rlabel and sublabel for covenant-restricted nodes
        ProcessCovenant(node)
    end
end

shadowlands.Map = SLMap

-------------------------------------------------------------------------------

local RiftMap = Class('RiftMap', SLMap)

function RiftMap:Prepare()
    SLMap.Prepare(self)

    self.rifted = false
    for i, spellID in ipairs{352795, 354870} do
        if AuraUtil.FindAuraByName(GetSpellInfo(spellID), 'player') then
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

shadowlands.RiftMap = RiftMap

-------------------------------------------------------------------------------
--------------------------------- REQUIREMENTS --------------------------------
-------------------------------------------------------------------------------

local Venari = Class('Venari', shadowlands.requirement.Requirement)

function Venari:Initialize(quest)
    self.text = L["venari_upgrade"]
    self.quest = quest
end

function Venari:IsMet()
    return C_QuestLog.IsQuestFlaggedCompleted(self.quest)
end

shadowlands.requirement.Venari = Venari

-------------------------------------------------------------------------------
----------------------------- RELIC RESEARCH ITEMS ----------------------------
-------------------------------------------------------------------------------

shadowlands.relics = {
    relic_fragment = Item({item=186685, status=L["num_research"]:format(1)}) -- relic fragment
}