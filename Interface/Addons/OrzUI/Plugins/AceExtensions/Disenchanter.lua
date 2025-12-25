--## Version: v1.13.8 ## Author: GonzoInc
Disenchanter = LibStub("AceAddon-3.0"):NewAddon("Disenchanter", "AceEvent-3.0");

local name = "Disenchanter";
local version = "v1.13.8"
local itemID
local expacID
local iType
local itemLink
local iQuality
local iCosmetic = false

function Disenchanter:OnInitialize()
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_LOGIN")
    --f:SetScript("OnEvent", function(_, event)
        --if event == "PLAYER_LOGIN" then
            --print(name, version, "- loaded")
        --end
    --end
    --)
end

--[[AddonCompartmentFrame:RegisterAddon({
    text = "|cFF7FFFD4Disenchanter|r",
    icon = "Interface\\AddOns\\Disenchanter\\Textures\\DIS_Logo",
    notCheckable = true,
    func = function()
        print("|cFF7FFFD4Disenchanter|r by: |cFFE6CC80Gonzo Inc", version)
    end,
})]]

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item,
        function(self)
            if self ~= GameTooltip then return end
            itemName, itemLink = self:GetItem()

            if itemLink ~= nil then
                itemID = tonumber(strmatch(itemLink, "item:(%d+):"))

                iType = select(6, GetItemInfo(tostring(itemLink)))
                expacID = select(15, GetItemInfo(tostring(itemLink)))
                iQuality = select(3, GetItemInfo(tostring(itemLink)))

                if (iType ~= nil) and (expacID ~= nil) then

                    -- check it item is a cosmetic
                    local iSubType = select(7, GetItemInfo(tostring(itemLink)))

                    -- split it out since API returns a damn string instead of a table....
                    if (strsplit(" " , iSubType, 1 ) == ITEM_COSMETIC ) then  --COSMETIC 
                        iCosmetic = true
                    end

                    self:AddLine(ExpansionText(expacID), 1, 1, 1, 1)  --"|cFFFFFFFF"..EXPANSION_FILTER_TEXT..": ".. 
                    if ((iType == ARMOR  or iType == WEAPON ) and not iCosmetic) then
                        --self:AddLine("\n|cFF7FFFD4------ Disenchanter ------", 1, 1, 1, 1)
                        --self:AddLine("|cFFFFFFFF"..QUALITY..": ".. ItemQuality(iQuality), 1, 1, 1, 1)
                        if iQuality >=2  and iQuality <=4 then
                            mats = getExpansionMaterials(expacID,iQuality)
                            if mats ~= nil then
                                --self:AddLine("|cFF7FFFD4"..ITEM_DISENCHANT_ANY_SKILL..": ", 1, 1, 1, 1)  -- Disenchants into: \n
                                for i, matID in pairs(mats) do
                                    if matID ~= nil then

                                        iTexture = select(10, GetItemInfo(tostring(matID)))
                                        if iTexture == nil then iTexture = "" end

                                        matString = select(1,GetItemInfo(tostring(matID)))
                                        if matString == nil then matString = "" end

                                        iQ = select(3, GetItemInfo(tostring(matID)))
                                        if iQ ~= nil then
                                            local r, g, b, hex = GetItemQualityColor(iQ)
                                        else
                                            local r, g, b, hex = {1,1,1,"ffffff"}
                                        end

                                        self:AddLine("|cFF7FFFD4"..ITEM_DISENCHANT_ANY_SKILL..":" .. "|T"..iTexture..":0|t " .. matString, r, g, b, 1)
                                    end
                                end
                            end
                        end
                        --self:AddLine(" ", nil, nil, nil, 0)
                    end
                end
            end
        end
)


--- Mapping of the expansions to the expansionId

function ExpansionText(expId)
    local eText
    if (expId == 0) then
        eText = "|cFFE6CC80"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME0  --Classic
    elseif (expId == 1) then
        eText = "|cFF1EFF00"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME1  --The Burning Crusades"
    elseif (expId == 2) then
        eText = "|cFF66ccff"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME2  --Wraith of the Lich King"
    elseif (expId == 3) then
        eText = "|cFFff3300"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME3  --Cataclysm"
    elseif (expId == 4) then
        eText = "|cFF00FF96"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME4  --Mists of Pandaria"
    elseif (expId == 5) then
        eText = "|cFFff8C1A"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME5  --Warlords of Draenor"
    elseif (expId == 6) then
        eText = "|cFFA335EE"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME6  --Legion"
    elseif (expId == 7) then
        eText = "|cFFFF7D0A"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME7  --Battle of Azeroth"
    elseif (expId == 8) then
        eText = "|cFFE6CC80"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME8  --Shadowlands"
    elseif (expId == 9) then
        eText = "|cFFA0A0A0"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME9  --Dragonflight"
    elseif (expId == 10) then
        eText = "|cFFffc045"..EXPANSION_FILTER_TEXT..": "..EXPANSION_NAME10  --The War Within"
    end

    return eText
end


--- mapping of the item quality

function ItemQuality(itemID)
    local eText
    if (itemID == 0) then
        eText = "|cFFFFFFFF"..ITEM_QUALITY0_DESC --Poor"
    elseif (itemID == 1) then
        eText = "|cFFFFFFFF"..ITEM_QUALITY1_DESC --Common"
    elseif (itemID == 2) then
        eText = "|cFF1EFF00"..ITEM_QUALITY2_DESC --Uncommon"
    elseif (itemID == 3) then
        eText = "|cFF0070DD"..ITEM_QUALITY3_DESC --Rare"
    elseif (itemID == 4) then
        eText = "|cFFA335EE"..ITEM_QUALITY4_DESC --Epic"
    elseif (itemID == 5) then
        eText = "|cFFFF8000"..ITEM_QUALITY5_DESC --Legendary"
    elseif (itemID == 6) then
        eText = "|cFFE6CC80"..ITEM_QUALITY6_DESC --Artifact"
    elseif (itemID == 7) then
        eText = "|cFF00CCFF"..ITEM_QUALITY7_DESC --Heirloom"
    elseif (itemID == 8) then
        eText = "|cFF00CCFF"..ITEM_QUALITY8_DESC --WoToken"
    end

    return eText
end

local mats

-- Enchanting reagents
-- Classic
--- uncommon
local LMAGIC = 10938
local GMAGIC = 10939
local STRANGE = 10940 --
--- rare
local LETERNAL = 16202
local SBRILLIANT = 14343
local ILLUSION = 16204
--- epic
local RILLUSION = 156930
local LBRILLIANT = 14344
local GETERNAL = 16203


-- Burning Crusade
--- uncommon
local ARCANE = 22445
local LPLANAR = 22447
--- rare
local GPLANAR = 22446
local SPRISMATIC = 22448
--- epic
local LPRISMATIC = 22449
local VOID = 22450


-- Wrath
--- uncommon
local INFINITE = 34054
local LCOSMIC = 34056
--- rare
local SDREAM_SHARD = 34053
local GCOSMIC = 34055
--- epic
local DREAM_SHARD = 34052
local ABYSS = 34057


-- Cata
--- uncommon
local HYPNOTIC = 52555
local LCELESTIAL = 52718
--- rare
local GCELESTIAL = 52719 -- And Uncommon
local SHEAVENLY_SHARD = 52720
--- epic
local HEAVENLY_SHARD = 52721
local MAELSTROM = 52722

-- Mists
--- uncommon
local ETHERAL = 74247
local SETHERAL = 74252
--- rare
local SPIRIT = 74249
local MYSTERIOUS = 74250
--- epic
local SHA_CRYSTAL = 74248

-- Warlords
--- uncommon
local DRAENIC = 109693
--- rare
local SLUMINOUS = 115502
local LUMINOUS = 111245
--- epic
local TEMPORAL = 113588
local FRACTEMPORAL = 115504

-- Legion
--- uncommon
local ARKHANA	= 124440
--- rare
local LEYLIGHT_SHARD = 124441
--- epic
local CHAOS_CRYSTAL = 124442

-- Battle
--- uncommon
local GLOOMDUST = 152875
--- rare
local UMBRASHARD = 152876
--- epic
local VEILEDCRYSTAL = 152877

-- Shadowlands
--- uncommon
local SOULDUSTNEW = 172230
--- rare
local SACREDSHARD = 172231
--- epic
local ETERNALCRYS = 172232

-- Dragonflight
--- uncommon
local CHROMATICDUST = 194123
--- rare
local VIBRANTSHARD = 194124
--- epic
local RESONANTCRY = 200113

-- The War Within
--- uncommon
local STORMDUST = 219946
--- rare
local GLEAMINGSHARD = 219949
--- epic
local REFULGENTCRYSTAL = 219952



--- No Longer In Game
--local NEXUS = 20725
--local LRADIANT = 11178
--local LGLOWING = 11139
--local LGLIMMERING = 11084
--local SRADIANT = 11177
--local SGLOWING = 11138
--local SGLIMMERING = 10978
--local GNETHER = 11175
--local GMYSTIC = 11135
--local GASTRAL = 11082
--local LNETHER = 11174
--local LMYSTIC = 11134
--local LASTRAL = 10998
--local DREAM = 11176
--local VISION = 11137
--local SOUL = 11083
--local SHA_FRAGMENT = 105718
--local BLOOD_SARGERAS = 124124
--local EXPULSOM = 152668

function getExpansionMaterials(expID, iQuality)

    if (expID == nil) or (iQuality == nil) then
        return mats{};
    end

    -- Classic Mats
    if (expID == 0) then
        if (iQuality == 2 ) then --Uncommon
            mats = { LMAGIC, GMAGIC, STRANGE }
        elseif (iQuality == 3 ) then --rare
            mats = { LETERNAL, SBRILLIANT, ILLUSION }
        elseif (iQuality == 4 ) then --epic
            mats = { RILLUSION, LBRILLIANT, GETERNAL }
        end
        return mats
    end

    -- TBC Mats
    if (expID == 1) then
        if (iQuality == 2 ) then --Uncommon
            mats = { ARCANE, LPLANAR, GPLANAR }
        elseif (iQuality == 3 ) then --rare
            mats = { SPRISMATIC, LPRISMATIC }
        elseif (iQuality == 4 ) then --epic
            mats = { VOID }
        end
        return mats
    end

    -- WOTLK Mats
    if (expID == 2) then
        if (iQuality == 2 ) then --Uncommon
            mats = { INFINITE, LCOSMIC, GCOSMIC }
        elseif (iQuality == 3 ) then --rare
            mats = { SDREAM_SHARD, DREAM_SHARD }
        elseif (iQuality == 4 ) then --epic
            mats = { ABYSS }
        end
        return mats
    end

    -- CATA Mats
    if (expID == 3) then
        if (iQuality == 2 ) then --Uncommon
            mats = { HYPNOTIC, LCELESTIAL, GCELESTIAL }
        elseif (iQuality == 3 ) then --rare
            mats = { SHEAVENLY_SHARD, HEAVENLY_SHARD }
        elseif (iQuality == 4 ) then --epic
            mats = { MAELSTROM }
        end
        return mats
    end

    -- MISTS Mats
    if (expID == 4) then
        if (iQuality == 2 ) then --Uncommon
            mats = { SPIRIT, MYSTERIOUS }
        elseif (iQuality == 3 ) then --rare
            mats = { ETHERAL, SETHERAL }
        elseif (iQuality == 4 ) then --epic
            mats = { SHA_CRYSTAL }
        end
        return mats
    end

    -- WOD Mats
    if (expID == 5) then
        if (iQuality == 2 ) then --Uncommon
            mats = { DRAENIC }
        elseif (iQuality == 3 ) then --rare
            mats = { SLUMINOUS, LUMINOUS }
        elseif (iQuality == 4 ) then --epic
            mats = { TEMPORAL, FRACTEMPORAL }
        end
        return mats
    end

    -- Legion Mats
    if (expID == 6) then
        if (iQuality == 2 ) then --Uncommon
            mats = { ARKHANA }
        elseif (iQuality == 3 ) then --rare
            mats = { LEYLIGHT_SHARD }
        elseif (iQuality == 4 ) then --epic
            mats = { CHAOS_CRYSTAL }
        end
        return mats
    end

    -- BOA Mats
    if (expID == 7) then
        if (iQuality == 2 ) then --Uncommon
            mats = { GLOOMDUST }
        elseif (iQuality == 3 ) then --rare
            mats = { UMBRASHARD }
        elseif (iQuality == 4 ) then --epic
            mats = { VEILEDCRYSTAL }
        end
        return mats
    end

    --Shadowlands Mats
    if (expID == 8) then
        if (iQuality == 2 ) then --Uncommon
            mats = { SOULDUSTNEW }
        elseif (iQuality == 3 ) then --rare
            mats = { SACREDSHARD }
        elseif (iQuality == 4 ) then --epic
            mats = { ETERNALCRYS }
        end
        return mats
    end

    --Dragonflight Mats
    if (expID == 9) then
        if (iQuality == 2 ) then --Uncommon
            mats = { CHROMATICDUST }
        elseif (iQuality == 3 ) then --rare
            mats = { VIBRANTSHARD }
        elseif (iQuality == 4 ) then --epic
            mats = { RESONANTCRY }
        end
        return mats
    end

    --TWW Mats
    if (expID == 10) then
        if (iQuality == 2 ) then --Uncommon
            mats = { STORMDUST }
        elseif (iQuality == 3 ) then --rare
            mats = { GLEAMINGSHARD }
        elseif (iQuality == 4 ) then --epic
            mats = { REFULGENTCRYSTAL }
        end
        return mats
    end

end