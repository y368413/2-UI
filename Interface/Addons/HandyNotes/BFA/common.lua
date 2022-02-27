-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local _, BattleForAzeroth = ...
local L = BattleForAzeroth.locale

local Class = BattleForAzeroth.Class
local Group = BattleForAzeroth.Group
local Map = BattleForAzeroth.Map

local Node = BattleForAzeroth.node.Node
local Quest = BattleForAzeroth.node.Quest
local Achievement = BattleForAzeroth.reward.Achievement

-------------------------------------------------------------------------------

BattleForAzeroth.expansion = 8

-------------------------------------------------------------------------------

BattleForAzeroth.groups.ASSAULT_EVENT = Group('assault_events', 'peg_yw')
BattleForAzeroth.groups.BOW_TO_YOUR_MASTERS = Group('bow_to_your_masters', 1850548, {
    defaults = BattleForAzeroth.GROUP_HIDDEN,
    faction = 'Horde'
})
BattleForAzeroth.groups.BRUTOSAURS =
    Group('brutosaurs', 1881827, {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.CARVED_IN_STONE = Group('carved_in_stone', 134424,
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.CATS_NAZJ = Group('cats_nazj', 454045)
BattleForAzeroth.groups.COFFERS = Group('coffers', 'star_chest_g')
BattleForAzeroth.groups.DAILY_CHESTS = Group('daily_chests', 'chest_bl',
    {defaults = BattleForAzeroth.GROUP_ALPHA75})
BattleForAzeroth.groups.DRUST_FACTS = Group('drust_facts', 2101971,
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.DUNE_RIDER = Group('dune_rider', 134962, {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.EMBER_RELICS = Group('ember_relics', 514016, {
    defaults = BattleForAzeroth.GROUP_HIDDEN,
    faction = 'Alliance'
})
BattleForAzeroth.groups.GET_HEKD = Group('get_hekd', 1604165, {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.HONEYBACKS = Group('honeybacks', 2066005,
    {defaults = BattleForAzeroth.GROUP_HIDDEN, faction = 'Alliance'})
BattleForAzeroth.groups.HOPPIN_SAD = Group('hoppin_sad', 804969, {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.LIFE_FINDS_A_WAY = Group('life_finds_a_way', 236192,
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.LOCKED_CHEST = Group('locked_chest', 'chest_gy',
    {defaults = BattleForAzeroth.GROUP_ALPHA75})
BattleForAzeroth.groups.MECH_CHEST = Group('mech_chest', 'chest_rd',
    {defaults = BattleForAzeroth.GROUP_ALPHA75})
BattleForAzeroth.groups.MISC_NAZJ = Group('misc_nazj', 528288)
BattleForAzeroth.groups.MUSHROOM_HARVEST = Group('mushroom_harvest', 1869654,
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.PAKU_TOTEMS = Group('paku_totems', 'flight_point_y',
    {defaults = BattleForAzeroth.GROUP_HIDDEN, faction = 'Horde'})
BattleForAzeroth.groups.PRISMATICS = Group('prismatics', 'crystal_p',
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.RECRIG = Group('recrig', 'peg_bl')
BattleForAzeroth.groups.SAUSAGE_SAMPLER = Group('sausage_sampler', 133200, {
    defaults = BattleForAzeroth.GROUP_HIDDEN,
    faction = 'Alliance'
})
BattleForAzeroth.groups.SCAVENGER_OF_THE_SANDS = Group('scavenger_of_the_sands', 135725,
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.SECRET_SUPPLY = Group('secret_supplies', 'star_chest_b',
    {defaults = BattleForAzeroth.GROUP_HIDDEN75})
BattleForAzeroth.groups.SHANTY_RAID = Group('shanty_raid', 1500866,
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.SLIMES_NAZJ = Group('slimes_nazj', 132107)
BattleForAzeroth.groups.SQUIRRELS = Group('squirrels', 237182,
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.SUPPLY = Group('supplies', 'star_chest_g',
    {defaults = BattleForAzeroth.GROUP_HIDDEN75})
BattleForAzeroth.groups.TALES_OF_DE_LOA = Group('tales_of_de_loa', 1875083,
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.THREE_SHEETS = Group('three_sheets', 135999,
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.TIDESAGE_LEGENDS = Group('tidesage_legends', 1500881,
    {defaults = BattleForAzeroth.GROUP_HIDDEN})
BattleForAzeroth.groups.UPRIGHT_CITIZENS = Group('upright_citizens', 516667, {
    defaults = BattleForAzeroth.GROUP_HIDDEN,
    faction = 'Alliance'
})
BattleForAzeroth.groups.VISIONS_BUFFS = Group('visions_buffs', 132183)
BattleForAzeroth.groups.VISIONS_CHEST = Group('visions_chest', 'chest_gy')
BattleForAzeroth.groups.VISIONS_CRYSTALS = Group('visions_crystals', 'crystal_o')
BattleForAzeroth.groups.VISIONS_MAIL = Group('visions_mail', 'envelope')
BattleForAzeroth.groups.VISIONS_MISC = Group('visions_misc', 2823166)

-------------------------------------------------------------------------------
---------------------------------- CALLBACKS ----------------------------------
-------------------------------------------------------------------------------

-- Listen for aura applied/removed events so we can refresh when the player
-- enters and exits the alternate future
BattleForAzeroth.addon:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', function()
    local _, e, _, _, _, _, _, _, t, _, _, s = CombatLogGetCurrentEventInfo()
    if (e == 'SPELL_AURA_APPLIED' or e == 'SPELL_AURA_REMOVED') and t ==
        UnitName('player') and s == 296644 then
        C_Timer.After(1, function() BattleForAzeroth.addon:Refresh() end)
    end
end)

BattleForAzeroth.addon:RegisterEvent('QUEST_ACCEPTED', function(_, _, id)
    if id == 56540 then
        BattleForAzeroth.Debug('Vale assaults unlock detected')
        C_Timer.After(1, function() BattleForAzeroth.addon:Refresh() end)
    end
end)

BattleForAzeroth.addon:RegisterEvent('QUEST_WATCH_UPDATE', function(_, index)
    local info = C_QuestLog.GetInfo(index)
    if info and info.questID == 56376 then
        BattleForAzeroth.Debug('Uldum assaults unlock detected')
        C_Timer.After(1, function() BattleForAzeroth.addon:Refresh() end)
    end
end)

BattleForAzeroth.addon:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED', function(...)
    -- Watch for a spellcast event that signals a ravenous slime was fed
    -- https://www.wowhead.com/spell=293775/schleimphage-feeding-tracker
    local _, source, _, spellID = ...
    if source == 'player' and spellID == 293775 then
        C_Timer.After(1, function() BattleForAzeroth.addon:Refresh() end)
    end
end)

-------------------------------------------------------------------------------
-------------------------------- TIMED EVENTS ---------------------------------
-------------------------------------------------------------------------------

local TimedEvent = Class('TimedEvent', Quest, {
    icon = 'peg_yw',
    scale = 2,
    group = BattleForAzeroth.groups.ASSAULT_EVENT,
    note = ''
})

function TimedEvent:PrerequisiteCompleted()
    -- Timed events that are not active today return nil here
    return C_TaskQuest.GetQuestTimeLeftMinutes(self.quest[1])
end

BattleForAzeroth.node.TimedEvent = TimedEvent

-------------------------------------------------------------------------------
------------------------------ WAR SUPPLY CRATES ------------------------------
-------------------------------------------------------------------------------

-- quest = 53640 (50 conquest looted for today)

BattleForAzeroth.node.Supply = Class('Supply', Node, {
    icon = 'star_chest_g',
    scale = 1.5,
    label = L['supply_chest'],
    rlabel = BattleForAzeroth.GetIconLink('war_mode_swords', 16),
    note = L['supply_chest_note'],
    requires = BattleForAzeroth.requirement.WarMode,
    rewards = {Achievement({id = 12572})},
    group = BattleForAzeroth.groups.SUPPLY
})

BattleForAzeroth.node.SecretSupply = Class('SecretSupply', BattleForAzeroth.node.Supply, {
    icon = 'star_chest_b',
    group = BattleForAzeroth.groups.SECRET_SUPPLY,
    label = L['secret_supply_chest'],
    note = L['secret_supply_chest_note']
})

BattleForAzeroth.node.Coffer = Class('Coffer', Node, {
    icon = 'star_chest_g',
    scale = 1.5,
    group = BattleForAzeroth.groups.COFFERS
})

-------------------------------------------------------------------------------
----------------------------- VISIONS ASSAULT MAP -----------------------------
-------------------------------------------------------------------------------

local VisionsMap = Class('VisionsMap', Map)

function VisionsMap:Prepare()
    Map.Prepare(self)
    self.assault = self.GetAssault()
    self.phased = self.assault ~= nil
end

function VisionsMap:CanDisplay(node, coord, minimap)
    local assault = node.assault
    if assault then
        assault = type(assault) == 'number' and {assault} or assault
        for i = 1, #assault + 1, 1 do
            if i > #assault then return false end
            if assault[i] == self.assault then break end
        end
    end

    return Map.CanDisplay(self, node, coord, minimap)
end

BattleForAzeroth.VisionsMap = VisionsMap

-------------------------------------------------------------------------------
-------------------------------- WARFRONT MAP ---------------------------------
-------------------------------------------------------------------------------

local WarfrontMap = Class('WarfrontMap', Map)

function WarfrontMap:CanDisplay(node, coord, minimap)
    -- Disable nodes that are not available when the other faction controls
    if node.controllingFaction then
        local state = C_ContributionCollector.GetState(self.collector)
        local faction = (state == 1 or state == 2) and 'Alliance' or 'Horde'
        if faction ~= node.controllingFaction then return false end
    end
    return Map.CanDisplay(self, node, coord, minimap)
end

BattleForAzeroth.WarfrontMap = WarfrontMap