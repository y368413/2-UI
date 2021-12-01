local Skada = Skada
--local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local mod = Skada:NewModule("Stagger")
local modDetails = Skada:NewModule("Stagger details")


local lang='zh'
local labels={
}
if lang == 'zh' then
    labels.stdm = '>> 醉拳减伤 <<'
    labels.dt = '承受伤害'
    labels.stin = '醉拳吸收'
    labels.stout = '醉拳消除'
    labels.taken = '醉拳承受'
    labels.pb = '活血酒'
    labels.pb_a = '活血酒(平均)'
    labels.qs = '迅饮'
    labels.others = "其他(脱战, t20, 醉拳池中, ...)"
    labels.duration = "醉拳时间"
    labels.freeze = "锁定时间"
    labels.tickmax = "最高醉拳伤害"
elseif lang == 'en' then
    labels.stdm = 'DM of Stagger'
    labels.dt = 'Damage Taken'
    labels.stin = "Damage Staggered"
    labels.stout = 'Stagger Clean'
    labels.taken = "Stagger Taken"
    labels.pb = "Purified_brew"
    labels.pb_a = "Purified_brew (average)"
    labels.qs = "Purified_quicksip"
    labels.others = "others(leave combat, tier20, staggering, ...)"
    labels.duration = "Stagger Duration"
    labels.freeze = "Freeze Duration"
    labels.tickmax = "Tick (max)"
end

local function printspell(i,onespell)
    if onespell then
        print(i,onespell[1],onespell[2])
    else
        print('{}')
    end

end

local function getSetDuration(set)
      if set.time > 0 then
            return set.time
      else
            local endtime = set.endtime
            if not endtime then
                  endtime = time()
            end
            return endtime - set.starttime
      end
end


local tick = {}
local function logStaggerTick(set, tick, isCurrent)
      local player = Skada:get_player(set, tick.dstGUID, tick.dstName)
      if player then
            player.stagger.taken = player.stagger.taken + tick.samount
            player.stagger.tickCount = player.stagger.tickCount + 1
            if player.stagger.tickMax < tick.samount then
                  player.stagger.tickMax = tick.samount
            end
            if isCurrent then
                  if player.stagger.lastTickTime then
                        local timeSinceLastTick = tick.timestamp - player.stagger.lastTickTime
                        player.stagger.duration = player.stagger.duration + timeSinceLastTick
                        if timeSinceLastTick > 60 then
                        elseif timeSinceLastTick > 2 then
                              player.stagger.freezeDuration = player.stagger.freezeDuration + (timeSinceLastTick - 0.5)
                        end
                  end
                  if tick.remainingStagger > 0 then
                        player.stagger.lastTickTime = tick.timestamp
                        --printdebug(tick.dstName.."'s stagger tick for "..tick.samount.." ("..tick.remainingStagger.." remains)")
                  else
                        player.stagger.lastTickTime = nil
                  end
            end
      end
end

local purify = {}
local function logStaggerPurify(set, purify)
      local player = Skada:get_player(set, purify.srcGUID, purify.srcName)
      if player then
            player.stagger.purified = player.stagger.purified + purify.samount
            player.stagger.purifyCount = player.stagger.purifyCount + 1
            if player.stagger.purifyMax < purify.samount then
                  player.stagger.purifyMax = purify.samount
            end
      end
end

local function proc_st_tick(timestamp,dstGUID,dstName,samount,sabsorbed,srcName,srcGUID,isabsorb)
    local player = Skada:get_player(Skada.current, dstGUID, dstName)
    stvar = player.stagger
    tick.timestamp = timestamp
    tick.dstGUID = dstGUID
    tick.dstName = dstName
    tick.samount = samount
    tick.remainingStagger = UnitStagger(dstName)
    --print(samount,sabsorbed,sschool)
    logStaggerTick(Skada.current, tick, true)
    logStaggerTick(Skada.total, tick, false)


    if sabsorbed then
        if player.stagger.tickMax < samount+sabsorbed then
              player.stagger.tickMax = samount+sabsorbed
        end
        playertotal = Skada:get_player(Skada.total, dstGUID, dstName)
        if playertotal.stagger.tickMax < samount+sabsorbed then
            playertotal.stagger.tickMax = samount+sabsorbed
        end
    end
end

local function log_stabsorb(set, samount, dstGUID, dstName)
    -- Stagger absorbs
    local player = Skada:get_player(set, dstGUID, dstName)
    player.stagger.absorbed = player.stagger.absorbed + samount
end

local function log_da(set, samount, dstGUID, dstName)
    -- Stagger absorbs
    local player = Skada:get_player(set, dstGUID, dstName)
    player.stagger.dt = player.stagger.dt + samount
end

local function log_dt(set, dmg, isCurrent)
    local player = Skada:get_player(set, dmg.dstGUID, dmg.dstName)
    if player then
        player.stagger.dt = player.stagger.dt + dmg.samount
    end
end

local tick = {}
local function SpellAbsorbed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
    local chk = ...
    local spellId, spellName, spellSchool, aGUID, aName, aFlags, aRaidFlags, aspellId, aspellName, aspellSchool, aAmount


    if type(chk) == "number" then
        -- Spell event
        spellId, spellName, spellSchool, aGUID, aName, aFlags, aRaidFlags, aspellId, aspellName, aspellSchool, aAmount = ...
        -- print(spellId,spellName,aspellId,aspellName)

        if spellId == 124255 then
        --if nil then
            proc_st_tick(timestamp,dstGUID,dstName,aAmount,0,srcName,srcGUID,1)
        end

        log_da(Skada.current, aAmount,  dstGUID, dstName)
        log_da(Skada.total, aAmount,  dstGUID, dstName)

        if aspellId ~= 115069 then
            return
        end
        if aAmount then
            log_stabsorb(Skada.current, aAmount,  dstGUID, dstName)
            log_stabsorb(Skada.total, aAmount, dstGUID, dstName)
        end
    else
        -- Swing event
        aGUID, aName, aFlags, aRaidFlags, aspellId, aspellName, aspellSchool, aAmount = ...

        log_da(Skada.current, aAmount,  dstGUID, dstName)
        log_da(Skada.total, aAmount,  dstGUID, dstName)

        if aspellId ~= 115069 then
            return
        end
        if aAmount then
            log_stabsorb(Skada.current, aAmount, dstGUID, dstName)
            log_stabsorb(Skada.total, aAmount, dstGUID, dstName)
        end
    end
end

last = 0
sttaken = 0

local dmg = {}
local function SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
    local spellId, spellName, spellSchool, samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing = ...

    if spellId == 124255 then -- Stagger damage
        proc_st_tick(timestamp,dstGUID,dstName,samount,sabsorbed,srcName,srcGUID)
    else
        dmg.timestamp = timestamp
        dmg.dstGUID = dstGUID
        dmg.dstName = dstName
        dmg.samount = samount

        log_dt(Skada.current, dmg, true)
        log_dt(Skada.total, dmg, false)
    end
end

stpury = 0
local function SpellCast(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
    return
    --[[
    local spellId, spellName, spellSchool = ...
    local player = Skada:get_player(Skada.current, srcGUID, srcName)
    local stvar = player.stagger
    if spellId == 119582 then -- Purifying brew
        table.insert(stvar.spellhistory,{'pb',1})
        printdebug('##cast pb','stpool',player.stagger.stpool,'unitst',UnitStagger(srcName))
    elseif spellId == 115308 then
        table.insert(stvar.spellhistory,{'isb',1})
    end
    ]]
end

function mod:OnEnable()
      mod.metadata = {showspots = false, click1 = modDetails}
      modDetails.metadata = {showspots = false, ordersort = true}
      

    Skada:RegisterForCL(SpellDamage, 'SPELL_DAMAGE', {dst_is_interesting_nopets = true})
    Skada:RegisterForCL(SpellDamage, 'SPELL_PERIODIC_DAMAGE', {dst_is_interesting_nopets = true})
    Skada:RegisterForCL(SpellDamage, 'SPELL_BUILDING_DAMAGE', {dst_is_interesting_nopets = true})
    Skada:RegisterForCL(SpellDamage, 'RANGE_DAMAGE', {dst_is_interesting_nopets = true})

    -- Skada:RegisterForCL(SwingDamage, 'SWING_DAMAGE', {dst_is_interesting_nopets = true})

    --  Skada:RegisterForCL(SpellDamage, 'SPELL_PERIODIC_DAMAGE', {src_is_interesting = true, dst_is_interesting_nopets = false})
      Skada:RegisterForCL(SpellCast, 'SPELL_CAST_SUCCESS', {src_is_interesting = true, dst_is_interesting_nopets = false})
      Skada:RegisterForCL(SpellAbsorbed, 'SPELL_ABSORBED', {dst_is_interesting = true})

      Skada:AddMode(self, "Stagger")
end

function mod:OnDisable()
      Skada:RemoveMode(self)
end

function modDetails:Enter(win, id, label)
      modDetails.playerid = id
      modDetails.title = label.."'s Stagger"
end

local function nextDataset(win, context)
      context.index = context.index or 1

      local dataset = win.dataset[context.index] or {}
      dataset.id = context.index
      win.dataset[context.index] = dataset

      context.index = context.index + 1
      return dataset
end

function modDetails:Update(win, set)
      local player = Skada:find_player(set, self.playerid)
      if player then
            local playerStagger = player.stagger
            local staggerabsorbed = playerStagger.absorbed
            local damageStaggered = staggerabsorbed
            if damageStaggered == 0 then
                  return
            end

            local setDuration = getSetDuration(set)
            local datasetContext = {}


        -- dmg taken
            local dt = nextDataset(win, datasetContext)
            dt.label = labels.dt
            dt.valuetext = Skada:FormatNumber(playerStagger.dt)
            dt.value = 1

        -- dmg staggered
            local staggered = nextDataset(win, datasetContext)
            staggered.label = labels.stin
            staggered.valuetext = Skada:FormatNumber(damageStaggered)
            --staggered.value = 1
            staggered.value = damageStaggered/ playerStagger.dt

        --[[
        -- stagger taken
            local staggerTaken = nextDataset(win, datasetContext)
            staggerTaken.label = labels.taken
            staggerTaken.valuetext = Skada:FormatNumber(playerStagger.taken)..(" (%02.1f%%)"):format(playerStagger.taken / damageStaggered * 100)
            staggerTaken.value = playerStagger.taken / playerStagger.dt
            ]]

        -- stagger clean
            local staggerTaken = nextDataset(win, datasetContext)
            stclean = damageStaggered - playerStagger.taken
            staggerTaken.label = labels.stout
            staggerTaken.valuetext = Skada:FormatNumber(stclean) .. '/' .. Skada:FormatNumber(damageStaggered) .. (" (%02.1f%%)"):format(stclean / damageStaggered * 100)
            staggerTaken.value = stclean / playerStagger.dt


        -- stagger dm
            sdm = damageStaggered - playerStagger.taken
            local staggered = nextDataset(win, datasetContext)
            staggered.label = labels.stdm
            staggered.valuetext = Skada:FormatNumber(sdm) .. '/' .. Skada:FormatNumber(playerStagger.dt) .. (" (%02.1f%%)"):format(sdm / playerStagger.dt * 100)
            --staggered.value = 1
            staggered.value = sdm / playerStagger.dt


        -- duration
            if setDuration > 0 and playerStagger.duration > 0 then
                  local staggerDuration = nextDataset(win, datasetContext)
                  staggerDuration.label = labels.duration
                  staggerDuration.valuetext = ("%02.1fs"):format(playerStagger.duration)
                  staggerDuration.value = playerStagger.duration / setDuration
                  
          -- freeze
                  if playerStagger.freezeDuration > 2 then
                        local freezeDuration = nextDataset(win, datasetContext)
                        freezeDuration.label = labels.freeze
                        freezeDuration.valuetext = ("%02.1fs"):format(playerStagger.freezeDuration)..(" (%02.1f%%)"):format(playerStagger.freezeDuration / playerStagger.duration * 100)
                        freezeDuration.value = playerStagger.freezeDuration / setDuration
                  end
            end

        -- tick max
            local tickMax = nextDataset(win, datasetContext)
            tickMax.label = labels.tickmax
            tickMax.valuetext = Skada:FormatNumber(playerStagger.tickMax)
            tickMax.value = playerStagger.tickMax / damageStaggered

            win.metadata.maxvalue = 1
      end
end

function mod:AddPlayerAttributes(player, set)
    if not player.stagger then
        player.stagger = {
            dt = 0,

            purified_quicksip = 0,
            purified_quicksip_static = 0,

            absorbed = 0,
            dtb4st = 0,
            stpool = 0,
            stpool_static = 0,

            pbrate = -1,
            spellhistory = {},

            taken = 0,
            purified = 0,
            purified_static = 0,
            purifyCount = 0,
            purifyMax = 0,

            lastTickTime = nil,
            tickMax = 0,
            tickCount = 0,

            duration = 0,
            freezeDuration = 0,
        }
    end          
end

function mod:GetSetSummary(set)
    local totalPurified = 0
    for i, player in ipairs(set.players) do
        if player.stagger then
            totalPurified = totalPurified + player.stagger.purified
        end
    end
    return "(purified) "..Skada:FormatNumber(totalPurified)
end

function mod:Update(win, set)
    local nr = 1
    local max = 0

    for i, player in ipairs(set.players) do
        if player.stagger then
            local value = player.stagger.absorbed
            if value > 0 then
                local d = win.dataset[nr] or {}
                win.dataset[nr] = d

                d.id = player.id
                d.label = player.name
                d.value = value
                d.valuetext = Skada:FormatNumber(value)
                d.class = player.class
                d.role = player.role

                if max < value then
                      max = value
                end
            end
            nr = nr + 1
        end
    end
    win.metadata.maxvalue = max
end
