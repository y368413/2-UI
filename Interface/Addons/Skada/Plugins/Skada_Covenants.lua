--## Author: Toenak  ## Version: 1.2.1

local SkadaCovenants = {}
SkadaCovenants.utils = {}

function SkadaCovenants.utils:isEmpty(table)
    for _, _ in pairs(table) do
        return false
    end
    return true
end

function SkadaCovenants.utils:isNumeric(x)
    if tonumber(x) ~= nil then
        return true
    end
    return false
end

function SkadaCovenants.utils:split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result
end

function SkadaCovenants.utils:splitName(name)
    local result = SkadaCovenants.utils:split(name, '-')
    return result[1], result[2]
end 

function SkadaCovenants.utils:splitMessage(msg)
    local result = SkadaCovenants.utils:split(msg, ':')
    return result[1], result[2], result[3]
end

function SkadaCovenants.utils:splitAskMessage(msg)
    local result = SkadaCovenants.utils:split(msg, ':')
    return result[1], result[2]
end

function SkadaCovenants.utils:splitCommand(msg)
    local result = SkadaCovenants.utils:split(msg, ' ')
    return result[1], result[2]
end

SkadaCovenants.spellMaps = {}
SkadaCovenants.spellMaps.utilityMap = {
    [324739] = 1,
    [177278] = 1,
    [300728] = 4,
    [310143] = 3,
    [300728] = 2,
}

SkadaCovenants.spellMaps.abilityMap = {
    ["DEATHKNIGHT"] = {
        [315443] = 4,
        [312202] = 1,
        [311648] = 2,
        [324128] = 3,
    },
    ["DEMONHUNTER"] = {
        [306830] = 1,
        [329554] = 4,
        [323639] = 3,
        [317009] = 2,
    }, 
    ["DRUID"] = {
        [338142] = 1,
        [326462] = 1,
        [326446] = 1,
        [338035] = 1,
        [338018] = 1,
        [338411] = 1,
        [326434] = 1,
        [325727] = 4,
        [323764] = 3,
        [323546] = 2,
    },
    ["HUNTER"] = {
        [308491] = 1,
        [325028] = 4,
        [328231] = 3,
        [324149] = 2,
    },
    ["MAGE"] = {
        [307443] = 1,
        [324220] = 4,
        [314791] = 3,
        [314793] = 2,
    },
    ["MONK"] = {
        [310454] = 1,
        [325216] = 4,
        [327104] = 3,
        [326860] = 2,
    },
    ["PALADIN"] = {
        [304971] = 1,
        [328204] = 4,
        [328282] = 3,
        [328620] = 3,
        [328622] = 3,
        [328281] = 3,
        [316958] = 2,
    },
    ["PRIEST"] = {
        [325013] = 1,
        [324724] = 4,
        [327661] = 3,
        [323673] = 2,
    },
    ["ROGUE"] = {
        [323547] = 1,
        [328547] = 4,
        [328305] = 3,
        [323654] = 2,
    },
    ["SHAMAN"] = {
        [324519] = 1,
        [324386] = 1,
        [326059] = 4,
        [328923] = 3,
        [320674] = 2,
    },
    ["WARLOCK"] = {
        [312321] = 1,
        [325289] = 4,
        [325640] = 3,
        [321792] = 2,
    },
    ["WARRIOR"] = {
        [307865] = 1,
        [324143] = 4,
        [325886] = 3,
        [330334] = 2,
        [317349] = 2,
        [317488] = 2,
        [330325] = 2,
    },
}

SkadaCovenants.oribos = {}

local oribos = SkadaCovenants.oribos
oribos.emptyCovenants = {}
oribos.covenants = {}

function oribos:getCovenantIcon(covenantID)
    if covenantID > 0 and covenantID < 5 then
        local covenantMap = {
            [1] = "kyrian",
            [2] = "venthyr",
            [3] = "night_fae",
            [4] = "necrolord",
        }

        return "|T".."Interface\\AddOns\\Skada\\media\\"..covenantMap[covenantID]..".tga:"..DCovenant["iconSize"]..":"..DCovenant["iconSize"].."|t"
    end

    return ""
end

function oribos:fillCovenants()
    local numGroupMembers = GetNumGroupMembers()
    for groupindex = 1, numGroupMembers do
        local name = GetRaidRosterInfo(groupindex)

        if name and not oribos.covenants[name] and not oribos.emptyCovenants[name]then
            oribos.emptyCovenants[name] = 0
            oribos:askCovenantInfo(name)
        end
    end
end

function oribos:addCovenantForPlayer(covenantID, playerName, playerClass)
    if covenantID then 
        local playerData = {}
        playerData.covenantID = covenantID
        playerData.class = playerClass
        oribos.covenants[playerName] = playerData
        oribos.emptyCovenants[playerName] = nil
    end
end

function oribos:askCovenantInfo(playerName)
    local message = SkadaCovenants.askMessage..":"..playerName
    C_ChatInfo.SendAddonMessage(SkadaCovenants.addonPrefix, message, "RAID")
end

function oribos:sendCovenantInfo(playerName)
    if playerName and oribos.covenants[playerName] then 
        local message = playerName..":"..oribos.covenants[playerName].covenantID..":"..oribos.covenants[playerName].class
        C_ChatInfo.SendAddonMessage(SkadaCovenants.addonPrefix, message, "RAID")
    end 
end

function oribos:hasPlayerWithEmptyCovenant()
    return not SkadaCovenants.utils:isEmpty(oribos.emptyCovenants)
end

-- Loggers
function oribos:logNewPlayer(covenantID, playerName, playerClass, spellID)
    if DCovenantLog and covenantID and playerName ~= UnitName("player") and not oribos.covenants[playerName] then
        local coloredName = "|CFFe5a472Details_Covenants|r"
        local _, _, _, classColor = GetClassColor(playerClass)
        local byMessage = ""

        if spellID then
            local link = GetSpellLink(spellID)
            byMessage = " (by spell: "..link..")"
        end

        print(coloredName.." covenant defined: "..oribos:getCovenantIcon(covenantID).." |C"..classColor..playerName.."|r"..byMessage)
    end
end

function oribos:log()
    print("|CFFe5a472Details_Covenants|r List of logged characters:")

    for key, data in pairs(oribos.covenants) do
        local _, _, _, classColor = GetClassColor(data.class)
        print(oribos:getCovenantIcon(data.covenantID).." |C"..classColor..key.."|r")
    end
end

function oribos:logParty()
    local numGroupMembers = GetNumGroupMembers()
    if numGroupMembers > 0 then 
        print("|CFFe5a472Details_Covenants|r Party covenants:")

        for groupindex = 1, numGroupMembers do
            local name = GetRaidRosterInfo(groupindex)

            local playerData = oribos.covenants[name]
            if name and playerData then
                local _, _, _, classColor = GetClassColor(playerData.class)
                print(oribos:getCovenantIcon(playerData.covenantID).." |C"..classColor..name.."|r")
            end  
        end
    else 
        print("|CFFe5a472Details_Covenants|r You are not currently in group.")
    end 
end


-- Public 
_G.Oribos = {}
local publicOribos = _G.Oribos

function publicOribos:getCovenantIconForPlayer(playerName)
    local covenantData = oribos.covenants[playerName]

    if covenantData and covenantData.covenantID then
        return oribos:getCovenantIcon(covenantData.covenantID)
    else
        return ""
    end 
end

local oribos = _G.Oribos

function SkadaCovenants:replaceSkadaImplmentation()
    if _G.Skada then
        _G.Skada.get_player = function(self, set, playerid, playername)
            local covenantPrefix = ""
            local covenantSuffix = ""

            if DCovenant["iconAlign"] == "right" then
                covenantSuffix = " "..oribos:getCovenantIconForPlayer(playername)
            else 
                covenantPrefix = oribos:getCovenantIconForPlayer(playername).." "
            end 
            
            -- Add player to set if it does not exist.
            local player = Skada:find_player(set, playerid)

            if not player then
                -- If we do not supply a playername (often the case in submodes), we can not create an entry.
                if not playername then
                    return
                end

                local _, playerClass = UnitClass(playername)
                local playerRole = UnitGroupRolesAssigned(playername)
                player = {id = playerid, class = playerClass, role = playerRole, name = playername, first = time(), ["time"] = 0}

                -- Tell each mode to apply its needed attributes.
                for i, mode in ipairs(_G.Skada:GetModes(nil)) do
                    if mode.AddPlayerAttributes ~= nil then
                        mode:AddPlayerAttributes(player, set)
                    end
                end

                -- Strip realm name
                -- This is done after module processing due to cross-realm names messing with modules (death log for example, which needs to do UnitHealthMax on the playername).
                local player_name, realm = string.split("-", playername, 2)
                player.name = covenantPrefix..(player_name or playername)..covenantSuffix

                tinsert(set.players, player)
            end

            if player.name == UNKNOWN and playername ~= UNKNOWN then -- fixup players created before we had their info
                local player_name, realm = string.split("-", playername, 2)
                player.name = covenantPrefix..(player_name or playername)..covenantSuffix
                local _, playerClass = UnitClass(playername)
                local playerRole = UnitGroupRolesAssigned(playername)
                player.class = playerClass
                player.role = playerRole
            end


            -- The total set clears out first and last timestamps.
            if not player.first then
                player.first = time()
            end

            -- Mark now as the last time player did something worthwhile.
            player.last = time()
            changed = true
            return player
        end
    end  
end


SkadaCovenants.addonPrefix = "DCOribos"
SkadaCovenants.askMessage = "ASK"
DCovenant = {
    ["iconSize"] = 21,
}
DCovenantLog = false --默认关闭目标是哪个盟约的在频道里提示

local isAsked = false

local playerName = UnitName("player")
local realmName = ""

local frame = CreateFrame("FRAME", "DetailsCovenantFrame");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");

local function registerCombatEvent()
    if SkadaCovenants.oribos:hasPlayerWithEmptyCovenant() then 
        frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    else
        frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    end
end

local function updateGroupRoster()
    SkadaCovenants.oribos:fillCovenants()

    registerCombatEvent()
end

local function init()
    local _, playerClass = UnitClass("player")
    realmName = GetNormalizedRealmName()
    SkadaCovenants.oribos:addCovenantForPlayer(C_Covenants.GetActiveCovenantID(), UnitName("player"), playerClass)

    frame:RegisterEvent("GROUP_ROSTER_UPDATE");
    frame:RegisterEvent("CHAT_MSG_ADDON")
    C_ChatInfo.RegisterAddonMessagePrefix(SkadaCovenants.addonPrefix)

    updateGroupRoster()
end

local function eventHandler(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subevent, _, sourceGUID, sourceName = CombatLogGetCurrentEventInfo()

        if SkadaCovenants.oribos:hasPlayerWithEmptyCovenant() and SkadaCovenants.oribos.emptyCovenants[sourceName] then
            if subevent == "SPELL_CAST_SUCCESS" then
                local _, englishClass = GetPlayerInfoByGUID(sourceGUID)
                local classAbilityMap = SkadaCovenants.spellMaps.abilityMap[englishClass]

                if classAbilityMap then
                    local spellID = select(12, CombatLogGetCurrentEventInfo())
                    local covenantIDByAbility = classAbilityMap[spellID]
                    local covenantIDByUtility = SkadaCovenants.spellMaps.utilityMap[spellID]

                    SkadaCovenants.oribos:logNewPlayer(covenantIDByAbility, sourceName, englishClass, spellID)
                    SkadaCovenants.oribos:addCovenantForPlayer(covenantIDByAbility, sourceName, englishClass)

                    SkadaCovenants.oribos:logNewPlayer(covenantIDByUtility, sourceName, englishClass, spellID)
                    SkadaCovenants.oribos:addCovenantForPlayer(covenantIDByUtility, sourceName, englishClass)
                    registerCombatEvent()
                end
            end
        end
    elseif event == "GROUP_ROSTER_UPDATE" then
        updateGroupRoster()
    elseif event == "CHAT_MSG_ADDON" then
        local prefix, messageText, _, sender = ...

        if prefix == SkadaCovenants.addonPrefix then
            if string.match(messageText, SkadaCovenants.askMessage) then
                local _, askForName = SkadaCovenants.utils:splitMessage(messageText)

                if string.match(askForName, playerName) then 
                    SkadaCovenants.oribos:sendCovenantInfo(playerName)
                end 
            elseif SkadaCovenants.oribos:hasPlayerWithEmptyCovenant() then
                local senderName, senderRealm = SkadaCovenants.utils:splitName(sender)
                if senderName ~= playerName then
                    local name, covenantID, playerClass = SkadaCovenants.utils:splitMessage(messageText)

                    if realmName ~= senderRealm then
                        name = name.."-"..senderRealm
                    end

                    SkadaCovenants.oribos:logNewPlayer(tonumber(covenantID), name, playerClass)
                    SkadaCovenants.oribos:addCovenantForPlayer(tonumber(covenantID), name, playerClass)
                end
            end
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        init()
        SkadaCovenants:replaceSkadaImplmentation()
        frame:UnregisterEvent("PLAYER_ENTERING_WORLD");
    end
end

frame:SetScript("OnEvent", eventHandler);


local coloredName = "|CFFe5a472Details_Covenants|r"
SLASH_DETAILSCOVENANT1, SLASH_DETAILSCOVENANT2 = '/SkadaCovenants', '/dcovenants';

local function colorOption(value) 
    return value == true and "|CFF9fd78aon|r" or "|CFFd77c7aoff|r"
end

local function commandLineHandler(msg, editBox)
    if string.match(msg, "icon ") then
        local _, numberValue = SkadaCovenants.utils:splitCommand(msg)
        if SkadaCovenants.utils:isNumeric(numberValue) then 
            local size = tonumber(numberValue)
            if size > 10 and size < 48 then 
                DCovenant["iconSize"] = math.floor(size / 2) * 2
                print(coloredName.." icon size has been set to: |CFF9fd78a"..DCovenant["iconSize"].."|r")
            else
                print("|CFFd77c7aError:|r Please enter value between |CFF9fd78a10|r and |CFF9fd78a48|r") 
            end 
        else
            print("|CFFd77c7aError:|r Please enter value between |CFF9fd78a10|r and |CFF9fd78a48|r") 
        end 
    elseif msg == "chat on" then
        DCovenantLog = true
        print(coloredName.." chat logs is "..colorOption(true))
    elseif msg == "chat off" then
        DCovenantLog = false
        print(coloredName.." chat logs is "..colorOption(false))
    elseif msg == "log all" then
        SkadaCovenants.oribos:log()
    elseif msg == "log group" or msg == "log" then
        SkadaCovenants.oribos:logParty()
    elseif string.match(msg, "align") then
        local _, alignValue = SkadaCovenants.utils:splitCommand(msg)
        if alignValue == "left" or alignValue == "right" then
            DCovenant["iconAlign"] = alignValue
            print(coloredName.." align of covenant icon has been set to: |CFF9fd78a"..DCovenant["iconAlign"].."|r")
        else 
            print("|CFFd77c7aError:|r Please enter one of value |CFF9fd78aleft|r or |CFF9fd78aright|r") 
        end
    elseif string.match(msg, "ignore") then 
        if _G._detalhes then
            local _, ignoreValue = SkadaCovenants.utils:splitCommand(msg)
            if ignoreValue == "on" or ignoreValue == "off" then
                if ignoreValue == "on" then
                    _G._detalhes.ignore_nicktag = false
                    DCovenant["detailsIgnoreNickname"] = true
                else 
                    DCovenant["detailsIgnoreNickname"] = false
                end

                print(coloredName.." Details! nicknames ignore is "..colorOption(DCovenant["detailsIgnoreNickname"]))
            else 
                print("|CFFd77c7aError:|r Please enter one of value "..colorOption(true).." or "..colorOption(false)) 
            end
        else 
            print("|CFFd77c7aError:|r You don't have Details!")
        end
    else 
        local coloredCommand = "  |CFFc0a7c7/SkadaCovenants|r |CFFf3ce87"
        local currentChatOption = colorOption(DCovenantLog)
        local currentAlignOption = DCovenant["iconAlign"]

        if not currentAlignOption then
            currentAlignOption = "left"
        end  

        local ignoreCommand = ""
        if _G._detalhes then
            local currentNicknameOption = colorOption(DCovenant["detailsIgnoreNickname"])
            ignoreCommand = "\n"..coloredCommand.."ignore [on | off]:|r ignore Details! nicknames (currently: "..currentNicknameOption..")"
        end 

        print(coloredName.." usage info:\n"..coloredCommand.."icon [number]:|r change size of icons (currently: |CFF9fd78a"..DCovenant["iconSize"].."|r)\n"..coloredCommand.."chat [on | off]:|r log a new character's covenant to chat (currently: "..currentChatOption..")\n"..coloredCommand.."log [all | group]:|r prints all collected data or just for your party/raid".."\n"..coloredCommand.."align [left | right]:|r change align of covenant icon (currently: |CFF9fd78a"..currentAlignOption.."|r)"..ignoreCommand)
    end
end
SlashCmdList["DETAILSCOVENANT"] = commandLineHandler;
