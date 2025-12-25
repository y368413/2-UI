-- List of (localized) messages for faction increases ## Author: Atair ## Version: 1.2.4
-- Note: We don't set faction for reputation decreases, because if this happens there's usually a second faction with an increase, so we pick the latter.
local factionIncreaseStrings = {
    FACTION_STANDING_INCREASED,
    FACTION_STANDING_INCREASED_ACCOUNT_WIDE,
    FACTION_STANDING_INCREASED_ACH_BONUS,
    FACTION_STANDING_INCREASED_ACH_BONUS_ACCOUNT_WIDE,
    FACTION_STANDING_INCREASED_BONUS,
    FACTION_STANDING_INCREASED_DOUBLE_BONUS,
    FACTION_STANDING_INCREASED_GENERIC,
    FACTION_STANDING_INCREASED_GENERIC_ACCOUNT_WIDE
};

local isRussian = GetLocale() == "ruRU";


function ReputationWatcher_OnLoad(self)
    self.factionStandings = {};
    self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
    self:RegisterEvent("VARIABLES_LOADED");
end


function ReputationWatcher_OnEvent(self, event, ...)
    if event == "CHAT_MSG_COMBAT_FACTION_CHANGE" then
        ReputationWather_OnFactionChangedMessage(self, ...);
    elseif event == "VARIABLES_LOADED" then
        ReputationWatcher_InitializeFactionStandings(self);
    end
end


function ReputationWather_OnFactionChangedMessage(self, message)
    -- Check whether the reputation bar has to be shown
    if C_Reputation.GetWatchedFactionData() == nil then
        -- The reputation bar is not show => count visible bars.
        local visible = 0;
        if StatusTrackingBarManager.bars then
            for _, bar in ipairs(StatusTrackingBarManager.bars) do
                if bar:ShouldBeVisible() then
                    visible = visible + 1;
                    if visible == 2 then
                        -- There are already two (maximum) other bars visible.
                        -- We do not want to force one of them (e.g. the experience bar) out by making the reputation bar visible, so we abort here.
                        -- Nevertheless, the user can opt to watch any faction manually in ReputationFrame/ReputationDetailFrame and the next reputation gain will cause a faction update on the afterwards visible reputation bar.
                        return;
                    end
                end
            end
        end
    end

    -- Extracting faction name from the event message
    local faction;
    for _, string in ipairs(factionIncreaseStrings) do
        faction = ReputationWatcher_TryGetFaction(message, string);
        if faction then
            if faction == GUILD then
                faction = nil;
            end
            break;
        end
    end

    -- Scan factions
    local changedIndex, foundIndex;
    for i = 1, C_Reputation.GetNumFactions() do
        local factionData = C_Reputation.GetFactionDataByIndex(i);

        if factionData then
            if ReputationWatcher_UpdateFactionStanding(self, factionData) then
                -- Reputation changed until last scan, use this faction if none can be determined from the event message
                changedIndex = i;
            end

            -- Compare faction name against faction name from list, and in case of Russian also against its grammar case as used in the message
            if (faction and not foundIndex and (factionData.name == faction or isRussian and format("|3-7(%s)", factionData.name) == faction)) then
                if C_Reputation.IsFactionActive(i) and not factionData.isWatched then
                    -- This is the faction name from the event message
                    foundIndex = i;
                end
            end
        end
    end

    -- Set watched faction
    local index = foundIndex or changedIndex;
    if index then
        C_Reputation.SetWatchedFactionByIndex(index);
    end
end


function ReputationWatcher_InitializeFactionStandings(self)
    -- Save collapsed faction header states
    local collapsed = {};
    for i = 1, C_Reputation.GetNumFactions() do
        local factionData = C_Reputation.GetFactionDataByIndex(i);
        if factionData and factionData.isHeader and factionData.isCollapsed then
            table.insert(collapsed, factionData.factionID, true);
        end
    end

    C_Reputation.ExpandAllFactionHeaders();

    -- Scan factions, save standings, and reset collapsed header states
    for i = C_Reputation.GetNumFactions(), 1, -1 do
        local factionData = C_Reputation.GetFactionDataByIndex(i);
        if factionData then
            ReputationWatcher_UpdateFactionStanding(self, factionData);
            if collapsed[factionData.factionID] then
                C_Reputation.CollapseFactionHeader(i);
            end
        end
    end
end


function ReputationWatcher_TryGetFaction(message, factionString)
    -- Escape all "magic characters" (except %) in case of modifications to the global string by another addon
    local pattern = string.gsub(factionString, "[%^%$%(%)%.%[%]%*%+%-%?]", "%%%0");

    -- Replace digit format placeholder by search pattern for amount, i.e. %d => %d+
    pattern = string.gsub(pattern, "%%d", "%%d+");

    -- Replace float format placeholder by search pattern for bonus, i.e. %.1f => %%.1f => %d+%.%d
    pattern = string.gsub(pattern, "%%%%%.1f", "%%d+%%.%%d");

    -- Replace string format placeholder by capturing search pattern for faction name, i.e. %s => (.+)
    if isRussian then
        -- Additionally remove Russian grammer case prefix "|3-7" since it is not contained in the message
        pattern = string.gsub(pattern, "|3%-7%(%%s%)", "(.+)");
    else
        pattern = string.gsub(pattern, "%%s", "(.+)");
    end

    return strmatch(message, pattern);
end


function ReputationWatcher_UpdateFactionStanding(self, factionData)
    local factionID = factionData.factionID;

    -- Find stored faction data or create it
    local factionInfo = self.factionStandings[factionID];
    local factionType, friendshipData, isNew;
    if factionInfo then
        factionType = factionInfo.type;
    else
        -- Find faction type, i.e major, standard, or friendship
        friendshipData = C_GossipInfo.GetFriendshipReputation(factionID);
        if friendshipData and friendshipData.friendshipFactionID > 0 then
            factionType = "friendship";
        elseif C_Reputation.IsMajorFaction(factionID) then
            factionType = "major";
        else
            factionType = "standard";
        end
        factionInfo = { type = factionType };
        self.factionStandings[factionID] = factionInfo;
        isNew = true;
    end

    -- Get current faction standing
    local isCapped, current, min, max, standing;
    if factionType == "friendship" then
        if not friendshipData then
            friendshipData = C_GossipInfo.GetFriendshipReputation(factionID);
        end
        isCapped = friendshipData.nextThreshold == nil;
        if not isCapped then
            current, min, max = friendshipData.standing, friendshipData.reactionThreshold, friendshipData.nextThreshold;
        end
    elseif factionType == "major" then
        isCapped = C_MajorFactions.HasMaximumRenown(factionID);
        if not isCapped then
            local majorData = C_MajorFactions.GetMajorFactionData(factionID);
            if majorData then
                current, min, max = majorData.renownReputationEarned, 0, majorData.renownLevelThreshold;
            end
        end
    else
        isCapped = factionData.reaction == MAX_REPUTATION_REACTION;
        if not isCapped then
            current, min, max = factionData.currentStanding, factionData.currentReactionThreshold, factionData.nextReactionThreshold;
        end
    end
    if isCapped then
        standing = "max";
    else
        standing = tostring(min) .. "/" .. tostring(current) .. "/" .. tostring(max);
    end

    -- Compare current and previous standings
    if standing == factionInfo.standing then
        return false; -- unchanged
    end
    factionInfo.standing = standing;
    return not isNew; -- changed
end
