﻿--[[
Written by: Hugh@Burning Blade-US and Simca@Malfurion-US

Special thanks to Nullberri, Ro, and Warla for helping at various points throughout the addon's development.
]]--

--GLOBALS: BPBID_Internal, BPBID_Options, GetBreedID_Battle, GetBreedID_Journal, SLASH_BATTLEPETBREEDID1, SLASH_BATTLEPETBREEDID2, SLASH_BATTLEPETBREEDID3

-- Get folder path and set addon namespace
local internal = {}

-- Give access to the internal namespace through a specified global variable
_G["BPBID_Internal"] = internal;

-- These global tables are used everywhere in the code and are absolutely required to be localized
local CPB = _G.C_PetBattles
local CPJ = _G.C_PetJournal

-- These basic lua functions are used in the calculating of breed IDs and must be localized due to the number and frequency of uses
local min = _G.math.min
local abs = _G.math.abs
local floor = _G.math.floor
local gsub = _G.gsub

-- These basic lua functions are used for Retrieving Breed Names
-- They're only used once but still important to localize due to the time sensitive nature of the task
local tostring = _G.tostring
local tonumber = _G.tonumber
local sub = _G.string.sub

-- Declare addon-wide cache variables
internal.cacheTime = true
internal.breedCache = {}
internal.speciesCache = {}
internal.resultsCache = {}
internal.rarityCache = {}

-- Declare addon-wide constant
internal.MAX_BREEDS = 10

-- Forward declaration of some simple hook status-check booleans
local PJHooked = false

-- Check if on future build or PTR to enable additional developer functions
local is_ptr = select(4, _G.GetBuildInfo()) ~= GetAddOnMetadata("HPetBattleAny", "Interface")

-- Takes in lots of information, returns Breed ID as a number (or an error), and the rarity as a number
function internal.CalculateBreedID(nSpeciesID, nQuality, nLevel, nMaxHP, nPower, nSpeed, wild, flying)
    
    -- Abandon ship! (if missing inputs)
    if (not nSpeciesID) or (not nQuality) or (not nMaxHP) or (not nPower) or (not nSpeed) then return "ERR" end
    
    -- Arrays are now initialized
    if (not BPBID_Arrays.BasePetStats) then BPBID_Arrays.InitializeArrays() end
    
    local breedID, nQL, minQuality, maxQuality
    
    -- Due to a Blizzard bug, some pets from tooltips will have quality = 0. this means we don't know what the quality is.
    -- So, we'll just test them all by adding another loop for rarity.
    -- This bug was fixed in Patch 5.2, but there is no harm in having this remain here.
    if (nQuality < 1) then
        nQuality = 2
        minQuality = 1
        if is_ptr then
            maxQuality = 6
        else
            maxQuality = 4
        end
    else
        minQuality = nQuality
        maxQuality = nQuality
    end
    
    -- End here and return "NEW" if species is new to the game (has unknown base stats)
    if not BPBID_Arrays.BasePetStats[nSpeciesID] then
        if ((BPBID_Options.Debug) and (not CPB.IsInBattle())) then
            print("Species " .. nSpeciesID .. " is completely unknown.")
        end
        return "NEW", nQuality, {"NEW"}
    end
    
    -- Localize base species stats and upconvert to avoid floating point errors (Blizzard could learn from this)
    local ihp = BPBID_Arrays.BasePetStats[nSpeciesID][1] * 10
    local ipower = BPBID_Arrays.BasePetStats[nSpeciesID][2] * 10
    local ispeed = BPBID_Arrays.BasePetStats[nSpeciesID][3] * 10
    
    -- Account for wild pet HP / Power reductions
    local wildHPFactor, wildPowerFactor = 1, 1
    if wild then
        wildHPFactor = 1.2
        wildPowerFactor = 1.25
    end
    
    -- Upconvert to avoid floating point errors
    local thp = nMaxHP * 100
    local tpower = nPower * 100
    local tspeed = nSpeed * 100
    
    -- Account for flying pet passive
    if flying then tspeed = tspeed / 1.5 end
    
    local trueresults = {}
    local lowest
    for i = minQuality, maxQuality do -- Accounting for BlizzBug with rarity
        nQL = BPBID_Arrays.RealRarityValues[i] * 20 * nLevel
        
        -- Higher level pets can never have duplicate breeds, so calculations can be less accurate and faster (they remain the same since version 0.7)
        nLevel = tonumber(nLevel)
        if (nLevel > 2) then
        
            -- Calculate diffs
            local diff3 = (abs(((ihp + 5) * nQL * 5 + 10000) / wildHPFactor - thp) / 5) + abs(((ipower + 5) * nQL) / wildPowerFactor - tpower) + abs(((ispeed + 5) * nQL) - tspeed)
            local diff4 = (abs((ihp * nQL * 5 + 10000) / wildHPFactor - thp) / 5) + abs(((ipower + 20) * nQL) / wildPowerFactor - tpower) + abs((ispeed * nQL) - tspeed)
            local diff5 = (abs((ihp * nQL * 5 + 10000) / wildHPFactor - thp) / 5) + abs((ipower * nQL) / wildPowerFactor - tpower) + abs(((ispeed + 20) * nQL) - tspeed)
            local diff6 = (abs(((ihp + 20) * nQL * 5 + 10000) / wildHPFactor - thp) / 5) + abs((ipower * nQL) / wildPowerFactor - tpower) + abs((ispeed * nQL) - tspeed)
            local diff7 = (abs(((ihp + 9) * nQL * 5 + 10000) / wildHPFactor - thp) / 5) + abs(((ipower + 9) * nQL) / wildPowerFactor - tpower) + abs((ispeed * nQL) - tspeed)
            local diff8 = (abs((ihp * nQL * 5 + 10000) / wildHPFactor - thp) / 5) + abs(((ipower + 9) * nQL) / wildPowerFactor - tpower) + abs(((ispeed + 9) * nQL) - tspeed)
            local diff9 = (abs(((ihp + 9) * nQL * 5 + 10000) / wildHPFactor - thp) / 5) + abs((ipower * nQL) / wildPowerFactor - tpower) + abs(((ispeed + 9) * nQL) - tspeed)
            local diff10 = (abs(((ihp + 4) * nQL * 5 + 10000) / wildHPFactor - thp) / 5) + abs(((ipower + 9) * nQL) / wildPowerFactor - tpower) + abs(((ispeed + 4) * nQL) - tspeed)
            local diff11 = (abs(((ihp + 4) * nQL * 5 + 10000) / wildHPFactor - thp) / 5) + abs(((ipower + 4) * nQL) / wildPowerFactor - tpower) + abs(((ispeed + 9) * nQL) - tspeed)
            local diff12 = (abs(((ihp + 9) * nQL * 5 + 10000) / wildHPFactor - thp) / 5) + abs(((ipower + 4) * nQL) / wildPowerFactor - tpower) + abs(((ispeed + 4) * nQL) - tspeed)
            
            -- Calculate min diff
            local current = min(diff3, diff4, diff5, diff6, diff7, diff8, diff9, diff10, diff11, diff12)
            
            if not lowest or current < lowest then
                lowest = current
                nQuality = i
                
                -- Determine breed from min diff
                if (lowest == diff3) then breedID = 3
                elseif (lowest == diff4) then breedID = 4
                elseif (lowest == diff5) then breedID = 5
                elseif (lowest == diff6) then breedID = 6
                elseif (lowest == diff7) then breedID = 7
                elseif (lowest == diff8) then breedID = 8
                elseif (lowest == diff9) then breedID = 9
                elseif (lowest == diff10) then breedID = 10
                elseif (lowest == diff11) then breedID = 11
                elseif (lowest == diff12) then breedID = 12
                else return "ERR-MIN", -1, {"ERR-MIN"} -- Should be impossible (keeping for debug)
                end
                
                trueresults[1] = breedID
            end
        
        -- Lowbie pets go here, the bane of my existance. calculations must be intense and logic loops numerous
        else
            -- Calculate diffs much more intensely. Round calculations with 10^-2 and math.floor. Also, properly devalue HP by dividing its absolute value by 5
            local diff3 = (abs((floor(((ihp + 5) * nQL * 5 + 10000) / wildHPFactor * 0.01 + 0.5) / 0.01) - thp) / 5) + abs((floor( ((ipower + 5) * nQL) / wildPowerFactor * 0.01 + 0.5) / 0.01) - tpower) + abs((floor( ((ispeed + 5) * nQL) * 0.01 + 0.5) / 0.01) - tspeed)
            local diff4 = (abs((floor((ihp * nQL * 5 + 10000) / wildHPFactor * 0.01 + 0.5) / 0.01) - thp) / 5) + abs((floor( ((ipower + 20) * nQL) / wildPowerFactor * 0.01 + 0.5) / 0.01) - tpower) + abs((floor( (ispeed * nQL) * 0.01 + 0.5) / 0.01) - tspeed)
            local diff5 = (abs((floor((ihp * nQL * 5 + 10000) / wildHPFactor * 0.01 + 0.5) / 0.01) - thp) / 5) + abs((floor( (ipower * nQL) / wildPowerFactor * 0.01 + 0.5) / 0.01) - tpower) + abs((floor( ((ispeed + 20) * nQL) * 0.01 + 0.5) / 0.01) - tspeed)
            local diff6 = (abs((floor(((ihp + 20) * nQL * 5 + 10000) / wildHPFactor * 0.01 + 0.5) / 0.01) - thp) / 5) + abs((floor( (ipower * nQL) / wildPowerFactor * 0.01 + 0.5) / 0.01) - tpower) + abs((floor( (ispeed * nQL) * 0.01 + 0.5) / 0.01) - tspeed)
            local diff7 = (abs((floor(((ihp + 9) * nQL * 5 + 10000) / wildHPFactor * 0.01 + 0.5) / 0.01) - thp) / 5) + abs((floor( ((ipower + 9) * nQL) / wildPowerFactor * 0.01 + 0.5) / 0.01) - tpower) + abs((floor( (ispeed * nQL) * 0.01 + 0.5) / 0.01) - tspeed)
            local diff8 = (abs((floor((ihp * nQL * 5 + 10000) / wildHPFactor * 0.01 + 0.5) / 0.01) - thp) / 5) + abs((floor( ((ipower + 9) * nQL) / wildPowerFactor * 0.01 + 0.5) / 0.01) - tpower) + abs((floor( ((ispeed + 9) * nQL) * 0.01 + 0.5) / 0.01) - tspeed)
            local diff9 = (abs((floor(((ihp + 9) * nQL * 5 + 10000) / wildHPFactor * 0.01 + 0.5) / 0.01) - thp) / 5) + abs((floor( (ipower * nQL) / wildPowerFactor * 0.01 + 0.5) / 0.01) - tpower) + abs((floor( ((ispeed + 9) * nQL) * 0.01 + 0.5) / 0.01) - tspeed)
            local diff10 = (abs((floor(((ihp + 4) * nQL * 5 + 10000) / wildHPFactor * 0.01 + 0.5) / 0.01) - thp) / 5) + abs((floor( ((ipower + 9) * nQL) / wildPowerFactor * 0.01 + 0.5) / 0.01) - tpower) + abs((floor( ((ispeed + 4) * nQL) * 0.01 + 0.5) / 0.01) - tspeed)
            local diff11 = (abs((floor(((ihp + 4) * nQL * 5 + 10000) / wildHPFactor * 0.01 + 0.5) / 0.01) - thp) / 5) + abs((floor( ((ipower + 4) * nQL) / wildPowerFactor * 0.01 + 0.5) / 0.01) - tpower) + abs((floor( ((ispeed + 9) * nQL) * 0.01 + 0.5) / 0.01) - tspeed)
            local diff12 = (abs((floor(((ihp + 9) * nQL * 5 + 10000) / wildHPFactor * 0.01 + 0.5) / 0.01) - thp) / 5) + abs((floor( ((ipower + 4) * nQL) / wildPowerFactor * 0.01 + 0.5) / 0.01) - tpower) + abs((floor( ((ispeed + 4) * nQL) * 0.01 + 0.5) / 0.01) - tspeed)
            
            -- Use custom replacement code for math.min to find duplicate breed possibilities
            local numberlist = { diff3, diff4, diff5, diff6, diff7, diff8, diff9, diff10, diff11, diff12 }
            local secondnumberlist = {}
            local resultslist = {}
            local numResults = 0
            local smallest
            
            -- If we know the breeds for species, use this series of logic statements to eliminate impossible breeds
            if (BPBID_Arrays.BreedsPerSpecies[nSpeciesID] and BPBID_Arrays.BreedsPerSpecies[nSpeciesID][1]) then
                
                -- This half of the table stores the diffs for the breeds that passed inspection 
                secondnumberlist[1] = {}
                -- This half of the table stores the number corresponding to the breeds that passed inspection since we can no longer rely on the index
                secondnumberlist[2] = {}
                
                -- "inspection" time! if the breed is not found in the array, it doesn't get passed on to secondnumberlist and is effectively discarded
                for q = 1, #BPBID_Arrays.BreedsPerSpecies[nSpeciesID] do
                    local currentbreed = BPBID_Arrays.BreedsPerSpecies[nSpeciesID][q]
                    -- Subtracting 2 from the breed to use it as an index (scale of 3-13 becomes 1-10)
                    secondnumberlist[1][q] = numberlist[currentbreed - 2]
                    secondnumberlist[2][q] = currentbreed
                end
                
                -- Find the smallest number out of the breeds left
                for x = 1, #secondnumberlist[2] do
                    -- If this breed is the closest to perfect we've seen, make it our only result (destroy all other results)
                    if (not smallest) or (secondnumberlist[1][x] < smallest) then 
                        smallest = secondnumberlist[1][x]
                        numResults = 1
                        resultslist = {}
                        resultslist[1] = secondnumberlist[2][x]
                    -- If we find a duplicate, add it to the list (but it can still be destroyed if better is found)
                    elseif (secondnumberlist[1][x] == smallest) then
                        numResults = numResults + 1
                        resultslist[numResults] = secondnumberlist[2][x]
                    end
                end
            
            -- If we don't know the species, use this series of logic statements to consider all possibilities
            else
                for y = 1, #numberlist do
                    -- If this breed is the closest to perfect we've seen, make it our only result (destroy all other results)
                    if (not smallest) or (numberlist[y] < smallest) then 
                        smallest = numberlist[y]
                        numResults = 1
                        resultslist = {}
                        resultslist[1] = y + 2
                    -- If we find a duplicate, add it to the list (but it can still be destroyed if better is found)
                    elseif (numberlist[y] == smallest) then
                        numResults = numResults + 1
                        resultslist[numResults] = y + 2
                    end
                end
            end
            
            -- Check to see if this is the smallest value reported out of all qualities (or if the quality is not in question)
            if not lowest or smallest < lowest then
                lowest = smallest
                nQuality = i
                
                trueresults = resultslist
                
                -- Set breedID to best suited breed (or ??? if matching breeds) (or ERR-BMN if error)
                if resultslist[2] then
                    breedID = "???"
                elseif resultslist[1] then
                    breedID = resultslist[1]
                else
                    return "ERR-BMN", -1, {"ERR-BMN"} -- Should be impossible (keeping for debug)
                end
                
                -- If something is perfectly accurate, there is no need to continue (obviously)
                if (smallest == 0) then break end
            end
        end
    end
    
    -- Debug section (to enable, you must manually set this value in-game using "/run BPBID_Options.Debug = true")
    if (BPBID_Options.Debug) and (not CPB.IsInBattle()) then
        if not (BPBID_Arrays.BreedsPerSpecies[nSpeciesID]) then
            print("Species " .. nSpeciesID .. ": Possible breeds unknown. Current Breed is " .. breedID .. ".")
        elseif (breedID ~= "???") then
            local exists = false
            for i = 1, #BPBID_Arrays.BreedsPerSpecies[nSpeciesID] do
                if (BPBID_Arrays.BreedsPerSpecies[nSpeciesID][i] == breedID) then exists = true end
            end
            if not (exists) then
                print("Species " .. nSpeciesID .. ": Current breed is outside the range of possible breeds. Current Breed is " .. breedID .. ".")
            end
        end
    end
    
    -- Return breed (or error)
    if breedID then
        return breedID, nQuality, trueresults
    else
        return "ERR-CAL", -1, {"ERR-CAL"} -- Should be impossible (keeping for debug)
    end
end

-- Match breedID to name, second number, double letter code (S/S), entire base+breed stats, or just base stats
function internal.RetrieveBreedName(breedID)
    -- Exit if no breedID found
    if not breedID then return "ERR-ELY" end -- Should be impossible (keeping for debug)
    
    -- Exit if error message found
    if (sub(tostring(breedID), 1, 3) == "ERR") or (tostring(breedID) == "???") or (tostring(breedID) == "NEW") then return breedID end
    
    local numberBreed = tonumber(breedID)
    
    if (BPBID_Options.format == 1) then -- Return single number
        return numberBreed
    elseif (BPBID_Options.format == 2) then -- Return two numbers
        return numberBreed .. "/" .. numberBreed + internal.MAX_BREEDS
    else -- Select correct letter breed
        if (numberBreed == 3) then
            return "B/B"
        elseif (numberBreed == 4) then
            return "P/P"
        elseif (numberBreed == 5) then
            return "S/S"
        elseif (numberBreed == 6) then
            return "H/H"
        elseif (numberBreed == 7) then
            return "H/P"
        elseif (numberBreed == 8) then
            return "P/S"
        elseif (numberBreed == 9) then
            return "H/S"
        elseif (numberBreed == 10) then
            return "P/B"
        elseif (numberBreed == 11) then
            return "S/B"
        elseif (numberBreed == 12) then
            return "H/B"
        else
            return "ERR-NAM" -- Should be impossible (keeping for debug)
        end
    end
end

-- Get information from pet journal and pass to calculation function
function GetBreedID_Journal(nPetID)
    if (nPetID) then
        -- Get information from pet journal
        local nHealth, nMaxHP, nPower, nSpeed, nQuality = CPJ.GetPetStats(nPetID)
        local nSpeciesID, _, nLevel = CPJ.GetPetInfoByPetID(nPetID);
        
        -- Pass to calculation function and then retrieve breed name
        return internal.RetrieveBreedName(internal.CalculateBreedID(nSpeciesID, nQuality, nLevel, nMaxHP, nPower, nSpeed, false, false))
    else
        return "ERR-PID" -- Should be impossible unless another addon calls it wrong (keeping for debug)
    end
end

-- Retrieve pre-determined Breed ID from cache for pet being moused over
function GetBreedID_Battle(self)
    if (self) then
        -- Determine index of internal.breedCache array. accepted values are 1-6 with 1-3 being your pets and 4-6 being enemy pets
        local offset = 0
        if (self.petOwner == 2) then offset = 3 end
        
        -- Get name for cached breedID/speciesID
        return internal.RetrieveBreedName(internal.breedCache[self.petIndex + offset])
    else
        return "ERR_SLF" -- Should be impossible unless another addon calls it wrong (keeping for debug)
    end
end

-- Get pet stats and breed at the start of battle before values change
function internal.CacheAllPets()
    for iOwner = 1, 2 do
        local IndexMax = CPB.GetNumPets(iOwner)
        for iIndex = 1, IndexMax do
            local nSpeciesID = CPB.GetPetSpeciesID(iOwner, iIndex)
            local nLevel = CPB.GetLevel(iOwner, iIndex)
            local nMaxHP = CPB.GetMaxHealth(iOwner, iIndex)
            local nPower = CPB.GetPower(iOwner, iIndex)
            local nSpeed = CPB.GetSpeed(iOwner, iIndex)
            local nQuality = CPB.GetBreedQuality(iOwner, iIndex)
            local wild = false
            local flying = false
            
            -- If pet is wild, add 20% hp to get the normal stat
            if (CPB.IsWildBattle() and iOwner == 2) then wild = true end
            
            -- Still have to account for flying passive apparently; can't get the stats snapshot before passive is applied
            if (CPB.GetPetType(iOwner, iIndex) == 3) then
                if (iOwner == 1) and ((CPB.GetHealth(iOwner, iIndex) / nMaxHP) > .5) then
                    flying = true
                elseif (iOwner == 2) then
                    flying = true
                end
            end
            
            -- Determine index of Cache arrays. accepted values are 1-6 with 1-3 being your pets and 4-6 being enemy pets
            local offset = 0
            if (iOwner == 2) then offset = 3 end
            
            -- Calculate breedID and store it in cache along with speciesID
            local breed, _, resultslist = internal.CalculateBreedID(nSpeciesID, nQuality, nLevel, nMaxHP, nPower, nSpeed, wild, flying)
            internal.breedCache[iIndex + offset] = breed
            internal.resultsCache[iIndex + offset] = resultslist
            internal.speciesCache[iIndex + offset] = nSpeciesID
            internal.rarityCache[iIndex + offset] = nQuality
            
            -- Debug section (to enable, you must manually set this value in-game using "/run BPBID_Options.Debug = true")
            if (BPBID_Options.Debug) then
                
                -- Checking for new pets or pets without breed data
                if (breed == "NEW") then
                    local wildnum, flyingnum = 1, 1
                    if wild then wildnum = 1.2 end
                    if flying then flyingnum = 1.5 end
                    print(string.format("NEW Species found; Owner #%i, Pet #%i, Wild status %s, SpeciesID %u, Base Stats %4.2f / %4.2f / %4.2f", iOwner, iIndex, wild and "true" or "false", nSpeciesID, ((nMaxHP * wildnum - 100) / 5) / (nLevel * (1 + (0.1 * (nQuality - 1)))), nPower / (nLevel * (1 + (0.1 * (nQuality - 1)))), (nSpeed / flyingnum) / (nLevel * (1 + (0.1 * (nQuality - 1))))))
                    if (breed ~= "NEW") then SELECTED_CHAT_FRAME:AddMessage("NEW Breed found: " .. breed) end
                elseif (breed ~= "???") and (sub(tostring(breed), 1, 3) ~= "ERR") then
                    local exists = false
                    if BPBID_Arrays.BreedsPerSpecies[nSpeciesID] then
                        for i = 1, #BPBID_Arrays.BreedsPerSpecies[nSpeciesID] do
                            if (BPBID_Arrays.BreedsPerSpecies[nSpeciesID][i] == breed) then exists = true end
                        end
                    end
                    if not (exists) then
                        local wildnum, flyingnum = 1, 1
                        if wild then wildnum = 1.2 end
                        if flying then flyingnum = 1.5 end
                        print(string.format("NEW Breed found for existing species; Owner #%i, Pet #%i, Wild status %s, SpeciesID %u, Base Stats %4.2f / %4.2f / %4.2f, Breed %s", iOwner, iIndex, wild and "true" or "false", nSpeciesID, ((nMaxHP * wildnum - 100) / 5) / (nLevel * (1 + (0.1 * (nQuality - 1)))), nPower / (nLevel * (1 + (0.1 * (nQuality - 1)))), (nSpeed / flyingnum) / (nLevel * (1 + (0.1 * (nQuality - 1)))), breed))
                    end
                end
                
                -- Checking if genders will ever be fixed
                if (CPB.GetStateValue(iOwner, iIndex, 78) ~= 0) then
                    print("HOLY !@#$ GENDERS ARE WORKING! This pet's gender is " .. CPB.GetStateValue(iOwner, iIndex, 78))
                end
            end
        end
    end
end

-- Display breed on PetJournal's ScrollFrame
local function BPBID_Hook_HSFUpdate(scrollFrame)
    -- Safety check AND make sure the user wants us here
    if (not ((scrollFrame == PetJournalListScrollFrame) or (scrollFrame == PetJournalEnhancedListScrollFrame))) or (not PetJournal:IsShown()) or (not BPBID_Options.Names.HSFUpdate) then return end
    
    -- Loop for all shown buttons
    for i = 1, #scrollFrame.buttons do
        
        -- Set specifics for this button
        local thisPet = scrollFrame.buttons[i]
        local petID = thisPet.petID
        
        -- Assure petID is not bogus
        if (petID ~= nil) then
            
            -- Get pet name to assure petID is not bogus
            local _, customName, _, _, _, _, _, name = CPJ.GetPetInfoByPetID(petID)
            if (name) then
                
                -- Get pet hex color
                local _, _, _, _, rarity = CPJ.GetPetStats(petID)
                local hex = ITEM_QUALITY_COLORS[rarity - 1].hex
                
                -- FONT DOWNSIZING ROUTINE HERE COULD USE SOME WORK
                
                -- If user doesn't want rarity coloring then use default
                if (not BPBID_Options.Names.HSFUpdateRarity) then hex = "|cffffd100" end
                    
                -- Display breed as part of the nickname if the pet has one, otherwise use the real name
                if (customName) then
                    thisPet.name:SetText(hex..customName.." ["..GetBreedID_Journal(petID).."]".."|r")
                    thisPet.subName:Show()
                    thisPet.subName:SetText(name)
                else
                    thisPet.name:SetText(hex..name.." ["..GetBreedID_Journal(petID).."]".."|r")
                    thisPet.subName:Hide()
                end
                
                -- Downside font if the name/breed gets chopped off
                if (thisPet.name:IsTruncated()) then
                    thisPet.name:SetFontObject("GameFontNormalSmall")
                else
                    thisPet.name:SetFontObject("GameFontNormal")
                end
            end
        end
    end
end

-- Create event handling frame and register event(s)
local BPBID_Events = CreateFrame("FRAME", "BPBID_Events")
BPBID_Events:RegisterEvent("ADDON_LOADED")
BPBID_Events:RegisterEvent("PLAYER_LOGIN")
BPBID_Events:RegisterEvent("PLAYER_CONTROL_LOST")
BPBID_Events:RegisterEvent("PET_BATTLE_OPENING_START")
BPBID_Events:RegisterEvent("PET_BATTLE_CLOSE")

-- OnEvent handler function
local function BPBID_Events_OnEvent(self, event, name, ...)
    if (event == "ADDON_LOADED") and (name == "HPetBattleAny") then
        -- Create saved variables if missing
        if (not BPBID_Options) then
            BPBID_Options = {}
        end
        
        -- Otherwise, none exists at all, so set to default
        if (not BPBID_Options.format) then
            BPBID_Options.format = 3
        end
        
        -- If the obsolete format choices exist, update them to defaults
        if (BPBID_Options.format == 4) or (BPBID_Options.format == 5) or (BPBID_Options.format == 6) then BPBID_Options.format = 3 end
        
        -- Set the rest of the defaults
        if not (BPBID_Options.Names) then
            BPBID_Options.Names = {}
            BPBID_Options.Names.PrimaryBattle = true -- In Battle (on primary pets for both owners)
            BPBID_Options.Names.BattleTooltip = true -- In PrimaryBattlePetUnitTooltip's header (in-battle tooltips)
            BPBID_Options.Names.BPT = true -- In BattlePetTooltip's header (items)
            BPBID_Options.Names.FBPT = true -- In FloatingBattlePetTooltip's header (chat links)
            BPBID_Options.Names.HSFUpdate = true -- In the Pet Journal scrolling frame
            BPBID_Options.Names.HSFUpdateRarity = true
            BPBID_Options.Names.PJT = true -- In the Pet Journal tooltip header
            BPBID_Options.Names.PJTRarity = false -- Color Pet Journal tooltip headers by rarity
            --BPBID_Options.Names.PetBattleTeams = true -- In the Pet Battle Teams window
            
            BPBID_Options.Tooltips = {}
            BPBID_Options.Tooltips.Enabled = true -- Enable Battle Pet BreedID Tooltips
            BPBID_Options.Tooltips.BattleTooltip = true -- In Battle (PrimaryBattlePetUnitTooltip)
            BPBID_Options.Tooltips.BPT = true -- On Items (BattlePetTooltip)
            BPBID_Options.Tooltips.FBPT = true -- On Chat Links (FloatingBattlePetTooltip)
            BPBID_Options.Tooltips.PJT = true -- In the Pet Journal (GameTooltip)
            --BPBID_Options.Tooltips.PetBattleTeams = true -- In Pet Battle Teams (PetBattleTeamsTooltip)
            
            BPBID_Options.Breedtip = {}
            BPBID_Options.Breedtip.Current = true -- Current pet's breed
            BPBID_Options.Breedtip.Possible = true -- Current pet's possible breeds
            BPBID_Options.Breedtip.SpeciesBase = false -- Pet species' base stats
            BPBID_Options.Breedtip.CurrentStats = false -- Current breed's base stats (level 1 Poor)
            BPBID_Options.Breedtip.AllStats = false -- All breed's base stats (level 1 Poor)
            BPBID_Options.Breedtip.CurrentStats25 = true -- Current breed's stats at level 25
            BPBID_Options.Breedtip.CurrentStats25Rare = true -- Always assume pet will be Rare at level 25
            BPBID_Options.Breedtip.AllStats25 = true -- All breeds' stats at level 25
            BPBID_Options.Breedtip.AllStats25Rare = true -- Always assume pet will be Rare at level 25
            
            BPBID_Options.BattleFontFix = false -- Test old Pet Battle rarity coloring
        end
        
        -- Set up new system for detecting manual changes added in v1.0.8
        if (BPBID_Options.ManualChange == nil) then
            BPBID_Options.ManualChange = false
        end
        
        -- Disable option unless user has manually changed it
        if (not BPBID_Options.ManualChange) or (BPBID_Options.ManualChange ~= GetAddOnMetadata("HPetBattleAny", "Version")) then
            BPBID_Options.BattleFontFix = false
        end
        
        -- If this addon loads after the Pet Journal
        if (PetJournalPetCardPetInfo) then
            
            -- Hook into the OnEnter script for the frame that calls GameTooltip in the Pet Journal
            PetJournalPetCardPetInfo:HookScript("OnEnter", internal.Hook_PJTEnter)
            PetJournalPetCardPetInfo:HookScript("OnLeave", internal.Hook_PJTLeave)
            
            -- Set boolean
            PJHooked = true
        end
        
        -- If this addon loads after ArkInventory
        if (ArkInventory) and (ArkInventory.TooltipBuildBattlepet) then
            
            -- Hook ArkInventory's Battle Pet tooltips
            hooksecurefunc(ArkInventory, "TooltipBuildBattlepet", internal.Hook_ArkInventory)
        end
    elseif (event == "ADDON_LOADED") and (name == "Blizzard_Collections") then
        -- If the Pet Journal loads on demand correctly (when the player opens it)
        if (PetJournalPetCardPetInfo) then
            
            -- Hook into the OnEnter script for the frame that calls GameTooltip in the Pet Journal
            PetJournalPetCardPetInfo:HookScript("OnEnter", internal.Hook_PJTEnter)
            PetJournalPetCardPetInfo:HookScript("OnLeave", internal.Hook_PJTLeave)
            
            -- Set boolean
            PJHooked = true
        end
    elseif (event == "ADDON_LOADED") and (name == "ArkInventory") then    
        -- If this addon loads before ArkInventory
        if (ArkInventory) and (ArkInventory.TooltipBuildBattlepet) then
            
            -- Hook ArkInventory's Battle Pet tooltips
            hooksecurefunc(ArkInventory, "TooltipBuildBattlepet", internal.Hook_ArkInventory)
        end
    elseif (event == "PLAYER_LOGIN") then
        -- Hook PJ PetCard here
        if (PetJournalPetCardPetInfo) and (not PJHooked) then
            
            -- Hook into the OnEnter script for the frame that calls GameTooltip in the Pet Journal
            PetJournalPetCardPetInfo:HookScript("OnEnter", internal.Hook_PJTEnter)
            PetJournalPetCardPetInfo:HookScript("OnLeave", internal.Hook_PJTLeave)
            
            -- Set boolean
            PJHooked = true
        end
        
        -- Check for presence of LibStub (pretty messy)
        if _G["LibStub"] then
            
            -- Access LibStub
            internal.LibStub = _G["LibStub"]
            
            -- Attempt to access LibExtraTip
            internal.LibExtraTip = internal.LibStub("LibExtraTip-1", true)
        end
    elseif (event == "PLAYER_CONTROL_LOST") then
        
        -- Set this boolean so internal.CacheAllPets() will fire
        internal.cacheTime = true
    elseif (event == "PET_BATTLE_OPENING_START") then
        
        -- Set this boolean so internal.CacheAllPets() will fire
        internal.cacheTime = false
    elseif (event == "PET_BATTLE_CLOSE") then
        
        -- Erase cache
        for i = 1, 6 do
            internal.breedCache[i] = 0
            internal.resultsCache[i] = false
            internal.speciesCache[i] = 0
            internal.rarityCache[i] = 0
        end
        
        -- Set this boolean so internal.CacheAllPets() will fire
        internal.cacheTime = true
    end
end

-- Set our event handler function
BPBID_Events:SetScript("OnEvent", BPBID_Events_OnEvent)

-- Hook non-tooltip functions (almost all other hooks are in BreedTooltips.lua)
hooksecurefunc("HybridScrollFrame_Update", BPBID_Hook_HSFUpdate)

-- Create slash commands
SLASH_BATTLEPETBREEDID1 = "/battlepetbreedID"
SLASH_BATTLEPETBREEDID2 = "/BPBID"
SLASH_BATTLEPETBREEDID3 = "/breedID"
SlashCmdList["BATTLEPETBREEDID"] = function(msg)
    InterfaceOptionsFrame:Show()
    InterfaceOptionsFrameTab2:Click()
    
    local i = 1
    local currAddon = "InterfaceOptionsFrameAddOnsButton" .. i
    while _G[currAddon] do
        if (_G[currAddon]:GetText() == BattlePetBreedIDOptionsName) then _G[currAddon]:Click() break end
        i = i + 1
        currAddon = "InterfaceOptionsFrameAddOnsButton" .. i
    end
end

--[[
BattlePetBreedID: Pet Data Module
Last Update: Patch 9.2.0 Live; 2022-03-29T10:02:14Z

If you would like a copy of this data in a different format for your own purposes or to be informed of future updates:
Contact MMOSimca / Simca@Malfurion - either through MMO-Champion, through CurseForge, or in-game

You may use this compiled data in any form for any purpose without my permission (though it'd be cool if you gave a shoutout somewhere). Ultimately, it's all property of Blizzard Entertainment anyway.
]]--

-- GLOBALS: BPBID_Arrays

-- Expose information globally
_G.BPBID_Arrays = {}

function BPBID_Arrays.InitializeArrays()

    -- DECLARATION
    BPBID_Arrays.RealRarityValues = {}
    BPBID_Arrays.BreedStats = {}
    BPBID_Arrays.BasePetStats = {}
    BPBID_Arrays.BreedsPerSpecies = {}


    -- RARITY VALUES
    BPBID_Arrays.RealRarityValues[1] = 0.5
    BPBID_Arrays.RealRarityValues[2] = 0.550000011920929
    BPBID_Arrays.RealRarityValues[3] = 0.600000023841858
    BPBID_Arrays.RealRarityValues[4] = 0.649999976158142
    BPBID_Arrays.RealRarityValues[5] = 0.699999988079071
    BPBID_Arrays.RealRarityValues[6] = 0.75


    -- BREED STATS
    BPBID_Arrays.BreedStats[3] = {0.5, 0.5, 0.5}
    BPBID_Arrays.BreedStats[4] = {0, 2, 0}
    BPBID_Arrays.BreedStats[5] = {0, 0, 2}
    BPBID_Arrays.BreedStats[6] = {2, 0, 0}
    BPBID_Arrays.BreedStats[7] = {0.9, 0.9, 0}
    BPBID_Arrays.BreedStats[8] = {0, 0.9, 0.9}
    BPBID_Arrays.BreedStats[9] = {0.9, 0, 0.9}
    BPBID_Arrays.BreedStats[10] = {0.4, 0.9, 0.4}
    BPBID_Arrays.BreedStats[11] = {0.4, 0.4, 0.9}
    BPBID_Arrays.BreedStats[12] = {0.9, 0.4, 0.4}


    -- BASE STATS
    BPBID_Arrays.BasePetStats[1] = false
    BPBID_Arrays.BasePetStats[2] = {10.5, 8, 9.5}
    BPBID_Arrays.BasePetStats[3] = false
    BPBID_Arrays.BasePetStats[4] = false
    BPBID_Arrays.BasePetStats[5] = false
    BPBID_Arrays.BasePetStats[6] = false
    BPBID_Arrays.BasePetStats[7] = false
    BPBID_Arrays.BasePetStats[8] = false
    BPBID_Arrays.BasePetStats[9] = false
    BPBID_Arrays.BasePetStats[10] = false
    BPBID_Arrays.BasePetStats[11] = false
    BPBID_Arrays.BasePetStats[12] = false
    BPBID_Arrays.BasePetStats[13] = false
    BPBID_Arrays.BasePetStats[14] = false
    BPBID_Arrays.BasePetStats[15] = false
    BPBID_Arrays.BasePetStats[16] = false
    BPBID_Arrays.BasePetStats[17] = false
    BPBID_Arrays.BasePetStats[18] = false
    BPBID_Arrays.BasePetStats[19] = false
    BPBID_Arrays.BasePetStats[20] = false
    BPBID_Arrays.BasePetStats[21] = false
    BPBID_Arrays.BasePetStats[22] = false
    BPBID_Arrays.BasePetStats[23] = false
    BPBID_Arrays.BasePetStats[24] = false
    BPBID_Arrays.BasePetStats[25] = false
    BPBID_Arrays.BasePetStats[26] = false
    BPBID_Arrays.BasePetStats[27] = false
    BPBID_Arrays.BasePetStats[28] = false
    BPBID_Arrays.BasePetStats[29] = false
    BPBID_Arrays.BasePetStats[30] = false
    BPBID_Arrays.BasePetStats[31] = false
    BPBID_Arrays.BasePetStats[32] = false
    BPBID_Arrays.BasePetStats[33] = false
    BPBID_Arrays.BasePetStats[34] = false
    BPBID_Arrays.BasePetStats[35] = false
    BPBID_Arrays.BasePetStats[36] = false
    BPBID_Arrays.BasePetStats[37] = false
    BPBID_Arrays.BasePetStats[38] = false
    BPBID_Arrays.BasePetStats[39] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[40] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[41] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[42] = {6.5, 9, 8.5}
    BPBID_Arrays.BasePetStats[43] = {7, 9, 8}
    BPBID_Arrays.BasePetStats[44] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[45] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[46] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[47] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[48] = false
    BPBID_Arrays.BasePetStats[49] = {9, 7, 8}
    BPBID_Arrays.BasePetStats[50] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[51] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[52] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[53] = false
    BPBID_Arrays.BasePetStats[54] = false
    BPBID_Arrays.BasePetStats[55] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[56] = {8.5, 9, 6.5}
    BPBID_Arrays.BasePetStats[57] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[58] = {7, 9, 8}
    BPBID_Arrays.BasePetStats[59] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[60] = false
    BPBID_Arrays.BasePetStats[61] = false
    BPBID_Arrays.BasePetStats[62] = false
    BPBID_Arrays.BasePetStats[63] = false
    BPBID_Arrays.BasePetStats[64] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[65] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[66] = false
    BPBID_Arrays.BasePetStats[67] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[68] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[69] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[70] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[71] = false
    BPBID_Arrays.BasePetStats[72] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[73] = false
    BPBID_Arrays.BasePetStats[74] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[75] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[76] = false
    BPBID_Arrays.BasePetStats[77] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[78] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[79] = false
    BPBID_Arrays.BasePetStats[80] = false
    BPBID_Arrays.BasePetStats[81] = false
    BPBID_Arrays.BasePetStats[82] = false
    BPBID_Arrays.BasePetStats[83] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[84] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[85] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[86] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[87] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[88] = false
    BPBID_Arrays.BasePetStats[89] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[90] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[91] = false
    BPBID_Arrays.BasePetStats[92] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[93] = {6.5, 9, 8.5}
    BPBID_Arrays.BasePetStats[94] = {7, 7, 10}
    BPBID_Arrays.BasePetStats[95] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[96] = false
    BPBID_Arrays.BasePetStats[97] = false
    BPBID_Arrays.BasePetStats[98] = false
    BPBID_Arrays.BasePetStats[99] = false
    BPBID_Arrays.BasePetStats[100] = false
    BPBID_Arrays.BasePetStats[101] = false
    BPBID_Arrays.BasePetStats[102] = false
    BPBID_Arrays.BasePetStats[103] = false
    BPBID_Arrays.BasePetStats[104] = false
    BPBID_Arrays.BasePetStats[105] = false
    BPBID_Arrays.BasePetStats[106] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[107] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[108] = false
    BPBID_Arrays.BasePetStats[109] = false
    BPBID_Arrays.BasePetStats[110] = false
    BPBID_Arrays.BasePetStats[111] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[112] = false
    BPBID_Arrays.BasePetStats[113] = false
    BPBID_Arrays.BasePetStats[114] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[115] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[116] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[117] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[118] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[119] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[120] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[121] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[122] = {8, 8.005, 8}
    BPBID_Arrays.BasePetStats[123] = false
    BPBID_Arrays.BasePetStats[124] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[125] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[126] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[127] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[128] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[129] = false
    BPBID_Arrays.BasePetStats[130] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[131] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[132] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[133] = false
    BPBID_Arrays.BasePetStats[134] = false
    BPBID_Arrays.BasePetStats[135] = false
    BPBID_Arrays.BasePetStats[136] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[137] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[138] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[139] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[140] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[141] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[142] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[143] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[144] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[145] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[146] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[147] = false
    BPBID_Arrays.BasePetStats[148] = false
    BPBID_Arrays.BasePetStats[149] = {7.5, 7, 9.5}
    BPBID_Arrays.BasePetStats[150] = false
    BPBID_Arrays.BasePetStats[151] = false
    BPBID_Arrays.BasePetStats[152] = false
    BPBID_Arrays.BasePetStats[153] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[154] = false
    BPBID_Arrays.BasePetStats[155] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[156] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[157] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[158] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[159] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[160] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[161] = false
    BPBID_Arrays.BasePetStats[162] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[163] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[164] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[165] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[166] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[167] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[168] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[169] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[170] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[171] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[172] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[173] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[174] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[175] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[176] = false
    BPBID_Arrays.BasePetStats[177] = false
    BPBID_Arrays.BasePetStats[178] = false
    BPBID_Arrays.BasePetStats[179] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[180] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[181] = false
    BPBID_Arrays.BasePetStats[182] = false
    BPBID_Arrays.BasePetStats[183] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[184] = false
    BPBID_Arrays.BasePetStats[185] = false
    BPBID_Arrays.BasePetStats[186] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[187] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[188] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[189] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[190] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[191] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[192] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[193] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[194] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[195] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[196] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[197] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[198] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[199] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[200] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[201] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[202] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[203] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[204] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[205] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[206] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[207] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[208] = false
    BPBID_Arrays.BasePetStats[209] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[210] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[211] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[212] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[213] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[214] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[215] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[216] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[217] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[218] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[219] = false
    BPBID_Arrays.BasePetStats[220] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[221] = false
    BPBID_Arrays.BasePetStats[222] = false
    BPBID_Arrays.BasePetStats[223] = false
    BPBID_Arrays.BasePetStats[224] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[225] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[226] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[227] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[228] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[229] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[230] = false
    BPBID_Arrays.BasePetStats[231] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[232] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[233] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[234] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[235] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[236] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[237] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[238] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[239] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[240] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[241] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[242] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[243] = {9, 9, 6}
    BPBID_Arrays.BasePetStats[244] = {8.5, 9, 6.5}
    BPBID_Arrays.BasePetStats[245] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[246] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[247] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[248] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[249] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[250] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[251] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[252] = false
    BPBID_Arrays.BasePetStats[253] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[254] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[255] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[256] = {8, 9, 7}
    BPBID_Arrays.BasePetStats[257] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[258] = {8.5, 9, 6.5}
    BPBID_Arrays.BasePetStats[259] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[260] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[261] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[262] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[263] = false
    BPBID_Arrays.BasePetStats[264] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[265] = {9.5, 8, 6.5}
    BPBID_Arrays.BasePetStats[266] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[267] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[268] = {8.5, 9, 6.5}
    BPBID_Arrays.BasePetStats[269] = false
    BPBID_Arrays.BasePetStats[270] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[271] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[272] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[273] = false
    BPBID_Arrays.BasePetStats[274] = false
    BPBID_Arrays.BasePetStats[275] = false
    BPBID_Arrays.BasePetStats[276] = false
    BPBID_Arrays.BasePetStats[277] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[278] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[279] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[280] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[281] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[282] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[283] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[284] = false
    BPBID_Arrays.BasePetStats[285] = {8, 9, 7}
    BPBID_Arrays.BasePetStats[286] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[287] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[288] = false
    BPBID_Arrays.BasePetStats[289] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[290] = false
    BPBID_Arrays.BasePetStats[291] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[292] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[293] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[294] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[295] = false
    BPBID_Arrays.BasePetStats[296] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[297] = {8, 9.5, 6.5}
    BPBID_Arrays.BasePetStats[298] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[299] = false
    BPBID_Arrays.BasePetStats[300] = false
    BPBID_Arrays.BasePetStats[301] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[302] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[303] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[304] = false
    BPBID_Arrays.BasePetStats[305] = false
    BPBID_Arrays.BasePetStats[306] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[307] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[308] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[309] = {6.5, 9, 8.5}
    BPBID_Arrays.BasePetStats[310] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[311] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[312] = false
    BPBID_Arrays.BasePetStats[313] = false
    BPBID_Arrays.BasePetStats[314] = false
    BPBID_Arrays.BasePetStats[315] = false
    BPBID_Arrays.BasePetStats[316] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[317] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[318] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[319] = {6.5, 9, 8.5}
    BPBID_Arrays.BasePetStats[320] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[321] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[322] = false
    BPBID_Arrays.BasePetStats[323] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[324] = false
    BPBID_Arrays.BasePetStats[325] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[326] = false
    BPBID_Arrays.BasePetStats[327] = false
    BPBID_Arrays.BasePetStats[328] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[329] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[330] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[331] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[332] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[333] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[334] = false
    BPBID_Arrays.BasePetStats[335] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[336] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[337] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[338] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[339] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[340] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[341] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[342] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[343] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[344] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[345] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[346] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[347] = {8, 8.75, 7.25}
    BPBID_Arrays.BasePetStats[348] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[349] = false
    BPBID_Arrays.BasePetStats[350] = false
    BPBID_Arrays.BasePetStats[351] = false
    BPBID_Arrays.BasePetStats[352] = false
    BPBID_Arrays.BasePetStats[353] = false
    BPBID_Arrays.BasePetStats[354] = false
    BPBID_Arrays.BasePetStats[355] = false
    BPBID_Arrays.BasePetStats[356] = false
    BPBID_Arrays.BasePetStats[357] = false
    BPBID_Arrays.BasePetStats[358] = false
    BPBID_Arrays.BasePetStats[359] = false
    BPBID_Arrays.BasePetStats[360] = false
    BPBID_Arrays.BasePetStats[361] = false
    BPBID_Arrays.BasePetStats[362] = false
    BPBID_Arrays.BasePetStats[363] = false
    BPBID_Arrays.BasePetStats[364] = false
    BPBID_Arrays.BasePetStats[365] = false
    BPBID_Arrays.BasePetStats[366] = false
    BPBID_Arrays.BasePetStats[367] = false
    BPBID_Arrays.BasePetStats[368] = false
    BPBID_Arrays.BasePetStats[369] = false
    BPBID_Arrays.BasePetStats[370] = false
    BPBID_Arrays.BasePetStats[371] = false
    BPBID_Arrays.BasePetStats[372] = false
    BPBID_Arrays.BasePetStats[373] = false
    BPBID_Arrays.BasePetStats[374] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[375] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[376] = false
    BPBID_Arrays.BasePetStats[377] = false
    BPBID_Arrays.BasePetStats[378] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[379] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[380] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[381] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[382] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[383] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[384] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[385] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[386] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[387] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[388] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[389] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[390] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[391] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[392] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[393] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[394] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[395] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[396] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[397] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[398] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[399] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[400] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[401] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[402] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[403] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[404] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[405] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[406] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[407] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[408] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[409] = {7, 8, 9}
    BPBID_Arrays.BasePetStats[410] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[411] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[412] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[413] = false
    BPBID_Arrays.BasePetStats[414] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[415] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[416] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[417] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[418] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[419] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[420] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[421] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[422] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[423] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[424] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[425] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[426] = false
    BPBID_Arrays.BasePetStats[427] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[428] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[429] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[430] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[431] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[432] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[433] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[434] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[435] = false
    BPBID_Arrays.BasePetStats[436] = false
    BPBID_Arrays.BasePetStats[437] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[438] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[439] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[440] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[441] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[442] = {9, 6.5, 8.5}
    BPBID_Arrays.BasePetStats[443] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[444] = false
    BPBID_Arrays.BasePetStats[445] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[446] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[447] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[448] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[449] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[450] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[451] = false
    BPBID_Arrays.BasePetStats[452] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[453] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[454] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[455] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[456] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[457] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[458] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[459] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[460] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[461] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[462] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[463] = {9, 9, 6}
    BPBID_Arrays.BasePetStats[464] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[465] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[466] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[467] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[468] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[469] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[470] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[471] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[472] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[473] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[474] = {6, 8, 10}
    BPBID_Arrays.BasePetStats[475] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[476] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[477] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[478] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[479] = {8, 6.5, 9.5}
    BPBID_Arrays.BasePetStats[480] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[481] = false
    BPBID_Arrays.BasePetStats[482] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[483] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[484] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[485] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[486] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[487] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[488] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[489] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[490] = false
    BPBID_Arrays.BasePetStats[491] = {7, 9, 8}
    BPBID_Arrays.BasePetStats[492] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[493] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[494] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[495] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[496] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[497] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[498] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[499] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[500] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[501] = false
    BPBID_Arrays.BasePetStats[502] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[503] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[504] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[505] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[506] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[507] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[508] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[509] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[510] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[511] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[512] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[513] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[514] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[515] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[516] = false
    BPBID_Arrays.BasePetStats[517] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[518] = {9, 8.5, 6.5}
    BPBID_Arrays.BasePetStats[519] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[520] = false
    BPBID_Arrays.BasePetStats[521] = {7, 9, 8}
    BPBID_Arrays.BasePetStats[522] = false
    BPBID_Arrays.BasePetStats[523] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[524] = false
    BPBID_Arrays.BasePetStats[525] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[526] = false
    BPBID_Arrays.BasePetStats[527] = false
    BPBID_Arrays.BasePetStats[528] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[529] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[530] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[531] = false
    BPBID_Arrays.BasePetStats[532] = {8.5, 9, 6.5}
    BPBID_Arrays.BasePetStats[533] = false
    BPBID_Arrays.BasePetStats[534] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[535] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[536] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[537] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[538] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[539] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[540] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[541] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[542] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[543] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[544] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[545] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[546] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[547] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[548] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[549] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[550] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[551] = false
    BPBID_Arrays.BasePetStats[552] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[553] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[554] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[555] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[556] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[557] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[558] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[559] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[560] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[561] = false
    BPBID_Arrays.BasePetStats[562] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[563] = false
    BPBID_Arrays.BasePetStats[564] = {9.5, 7.5, 7}
    BPBID_Arrays.BasePetStats[565] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[566] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[567] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[568] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[569] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[570] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[571] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[572] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[573] = {9, 7, 8}
    BPBID_Arrays.BasePetStats[574] = false
    BPBID_Arrays.BasePetStats[575] = false
    BPBID_Arrays.BasePetStats[576] = false
    BPBID_Arrays.BasePetStats[577] = false
    BPBID_Arrays.BasePetStats[578] = false
    BPBID_Arrays.BasePetStats[579] = false
    BPBID_Arrays.BasePetStats[580] = false
    BPBID_Arrays.BasePetStats[581] = false
    BPBID_Arrays.BasePetStats[582] = false
    BPBID_Arrays.BasePetStats[583] = false
    BPBID_Arrays.BasePetStats[584] = false
    BPBID_Arrays.BasePetStats[585] = false
    BPBID_Arrays.BasePetStats[586] = false
    BPBID_Arrays.BasePetStats[587] = false
    BPBID_Arrays.BasePetStats[588] = false
    BPBID_Arrays.BasePetStats[589] = false
    BPBID_Arrays.BasePetStats[590] = false
    BPBID_Arrays.BasePetStats[591] = false
    BPBID_Arrays.BasePetStats[592] = false
    BPBID_Arrays.BasePetStats[593] = false
    BPBID_Arrays.BasePetStats[594] = false
    BPBID_Arrays.BasePetStats[595] = false
    BPBID_Arrays.BasePetStats[596] = false
    BPBID_Arrays.BasePetStats[597] = false
    BPBID_Arrays.BasePetStats[598] = false
    BPBID_Arrays.BasePetStats[599] = false
    BPBID_Arrays.BasePetStats[600] = false
    BPBID_Arrays.BasePetStats[601] = false
    BPBID_Arrays.BasePetStats[602] = false
    BPBID_Arrays.BasePetStats[603] = false
    BPBID_Arrays.BasePetStats[604] = false
    BPBID_Arrays.BasePetStats[605] = false
    BPBID_Arrays.BasePetStats[606] = false
    BPBID_Arrays.BasePetStats[607] = false
    BPBID_Arrays.BasePetStats[608] = false
    BPBID_Arrays.BasePetStats[609] = false
    BPBID_Arrays.BasePetStats[610] = false
    BPBID_Arrays.BasePetStats[611] = false
    BPBID_Arrays.BasePetStats[612] = false
    BPBID_Arrays.BasePetStats[613] = false
    BPBID_Arrays.BasePetStats[614] = false
    BPBID_Arrays.BasePetStats[615] = false
    BPBID_Arrays.BasePetStats[616] = false
    BPBID_Arrays.BasePetStats[617] = false
    BPBID_Arrays.BasePetStats[618] = false
    BPBID_Arrays.BasePetStats[619] = false
    BPBID_Arrays.BasePetStats[620] = false
    BPBID_Arrays.BasePetStats[621] = false
    BPBID_Arrays.BasePetStats[622] = false
    BPBID_Arrays.BasePetStats[623] = false
    BPBID_Arrays.BasePetStats[624] = false
    BPBID_Arrays.BasePetStats[625] = false
    BPBID_Arrays.BasePetStats[626] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[627] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[628] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[629] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[630] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[631] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[632] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[633] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[634] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[635] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[636] = false
    BPBID_Arrays.BasePetStats[637] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[638] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[639] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[640] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[641] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[642] = false
    BPBID_Arrays.BasePetStats[643] = false
    BPBID_Arrays.BasePetStats[644] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[645] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[646] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[647] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[648] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[649] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[650] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[651] = false
    BPBID_Arrays.BasePetStats[652] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[653] = false
    BPBID_Arrays.BasePetStats[654] = false
    BPBID_Arrays.BasePetStats[655] = false
    BPBID_Arrays.BasePetStats[656] = false
    BPBID_Arrays.BasePetStats[657] = false
    BPBID_Arrays.BasePetStats[658] = false
    BPBID_Arrays.BasePetStats[659] = false
    BPBID_Arrays.BasePetStats[660] = false
    BPBID_Arrays.BasePetStats[661] = false
    BPBID_Arrays.BasePetStats[662] = false
    BPBID_Arrays.BasePetStats[663] = false
    BPBID_Arrays.BasePetStats[664] = false
    BPBID_Arrays.BasePetStats[665] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[666] = {8.5, 9, 6.5}
    BPBID_Arrays.BasePetStats[667] = false
    BPBID_Arrays.BasePetStats[668] = false
    BPBID_Arrays.BasePetStats[669] = false
    BPBID_Arrays.BasePetStats[670] = false
    BPBID_Arrays.BasePetStats[671] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[672] = false
    BPBID_Arrays.BasePetStats[673] = false
    BPBID_Arrays.BasePetStats[674] = false
    BPBID_Arrays.BasePetStats[675] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[676] = false
    BPBID_Arrays.BasePetStats[677] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[678] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[679] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[680] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[681] = false
    BPBID_Arrays.BasePetStats[682] = false
    BPBID_Arrays.BasePetStats[683] = false
    BPBID_Arrays.BasePetStats[684] = false
    BPBID_Arrays.BasePetStats[685] = false
    BPBID_Arrays.BasePetStats[686] = false
    BPBID_Arrays.BasePetStats[687] = false
    BPBID_Arrays.BasePetStats[688] = false
    BPBID_Arrays.BasePetStats[689] = false
    BPBID_Arrays.BasePetStats[690] = false
    BPBID_Arrays.BasePetStats[691] = false
    BPBID_Arrays.BasePetStats[692] = false
    BPBID_Arrays.BasePetStats[693] = false
    BPBID_Arrays.BasePetStats[694] = false
    BPBID_Arrays.BasePetStats[695] = false
    BPBID_Arrays.BasePetStats[696] = false
    BPBID_Arrays.BasePetStats[697] = false
    BPBID_Arrays.BasePetStats[698] = false
    BPBID_Arrays.BasePetStats[699] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[700] = false
    BPBID_Arrays.BasePetStats[701] = false
    BPBID_Arrays.BasePetStats[702] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[703] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[704] = false
    BPBID_Arrays.BasePetStats[705] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[706] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[707] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[708] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[709] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[710] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[711] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[712] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[713] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[714] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[715] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[716] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[717] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[718] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[719] = false
    BPBID_Arrays.BasePetStats[720] = false
    BPBID_Arrays.BasePetStats[721] = false
    BPBID_Arrays.BasePetStats[722] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[723] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[724] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[725] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[726] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[727] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[728] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[729] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[730] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[731] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[732] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[733] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[734] = false
    BPBID_Arrays.BasePetStats[735] = false
    BPBID_Arrays.BasePetStats[736] = false
    BPBID_Arrays.BasePetStats[737] = {6.5, 8, 9.5}
    BPBID_Arrays.BasePetStats[738] = false
    BPBID_Arrays.BasePetStats[739] = {7, 8, 9}
    BPBID_Arrays.BasePetStats[740] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[741] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[742] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[743] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[744] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[745] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[746] = {8.5, 9, 6.5}
    BPBID_Arrays.BasePetStats[747] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[748] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[749] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[750] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[751] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[752] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[753] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[754] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[755] = {9, 6.5, 8.5}
    BPBID_Arrays.BasePetStats[756] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[757] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[758] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[759] = false
    BPBID_Arrays.BasePetStats[760] = false
    BPBID_Arrays.BasePetStats[761] = false
    BPBID_Arrays.BasePetStats[762] = false
    BPBID_Arrays.BasePetStats[763] = false
    BPBID_Arrays.BasePetStats[764] = false
    BPBID_Arrays.BasePetStats[765] = false
    BPBID_Arrays.BasePetStats[766] = false
    BPBID_Arrays.BasePetStats[767] = false
    BPBID_Arrays.BasePetStats[768] = false
    BPBID_Arrays.BasePetStats[769] = false
    BPBID_Arrays.BasePetStats[770] = false
    BPBID_Arrays.BasePetStats[771] = false
    BPBID_Arrays.BasePetStats[772] = false
    BPBID_Arrays.BasePetStats[773] = false
    BPBID_Arrays.BasePetStats[774] = false
    BPBID_Arrays.BasePetStats[775] = false
    BPBID_Arrays.BasePetStats[776] = false
    BPBID_Arrays.BasePetStats[777] = false
    BPBID_Arrays.BasePetStats[778] = false
    BPBID_Arrays.BasePetStats[779] = false
    BPBID_Arrays.BasePetStats[780] = false
    BPBID_Arrays.BasePetStats[781] = false
    BPBID_Arrays.BasePetStats[782] = false
    BPBID_Arrays.BasePetStats[783] = false
    BPBID_Arrays.BasePetStats[784] = false
    BPBID_Arrays.BasePetStats[785] = false
    BPBID_Arrays.BasePetStats[786] = false
    BPBID_Arrays.BasePetStats[787] = false
    BPBID_Arrays.BasePetStats[788] = false
    BPBID_Arrays.BasePetStats[789] = false
    BPBID_Arrays.BasePetStats[790] = false
    BPBID_Arrays.BasePetStats[791] = false
    BPBID_Arrays.BasePetStats[792] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[793] = false
    BPBID_Arrays.BasePetStats[794] = false
    BPBID_Arrays.BasePetStats[795] = false
    BPBID_Arrays.BasePetStats[796] = false
    BPBID_Arrays.BasePetStats[797] = false
    BPBID_Arrays.BasePetStats[798] = false
    BPBID_Arrays.BasePetStats[799] = false
    BPBID_Arrays.BasePetStats[800] = {18, 8, 8}
    BPBID_Arrays.BasePetStats[801] = false
    BPBID_Arrays.BasePetStats[802] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[803] = false
    BPBID_Arrays.BasePetStats[804] = false
    BPBID_Arrays.BasePetStats[805] = false
    BPBID_Arrays.BasePetStats[806] = false
    BPBID_Arrays.BasePetStats[807] = false
    BPBID_Arrays.BasePetStats[808] = false
    BPBID_Arrays.BasePetStats[809] = false
    BPBID_Arrays.BasePetStats[810] = false
    BPBID_Arrays.BasePetStats[811] = false
    BPBID_Arrays.BasePetStats[812] = false
    BPBID_Arrays.BasePetStats[813] = false
    BPBID_Arrays.BasePetStats[814] = false
    BPBID_Arrays.BasePetStats[815] = false
    BPBID_Arrays.BasePetStats[816] = false
    BPBID_Arrays.BasePetStats[817] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[818] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[819] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[820] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[821] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[822] = false
    BPBID_Arrays.BasePetStats[823] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[824] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[825] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[826] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[827] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[828] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[829] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[830] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[831] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[832] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[833] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[834] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[835] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[836] = {7.5, 7, 9.5}
    BPBID_Arrays.BasePetStats[837] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[838] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[839] = false
    BPBID_Arrays.BasePetStats[840] = false
    BPBID_Arrays.BasePetStats[841] = false
    BPBID_Arrays.BasePetStats[842] = false
    BPBID_Arrays.BasePetStats[843] = false
    BPBID_Arrays.BasePetStats[844] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[845] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[846] = {6, 8, 10}
    BPBID_Arrays.BasePetStats[847] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[848] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[849] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[850] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[851] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[852] = false
    BPBID_Arrays.BasePetStats[853] = false
    BPBID_Arrays.BasePetStats[854] = false
    BPBID_Arrays.BasePetStats[855] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[856] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[857] = false
    BPBID_Arrays.BasePetStats[858] = false
    BPBID_Arrays.BasePetStats[859] = false
    BPBID_Arrays.BasePetStats[860] = false
    BPBID_Arrays.BasePetStats[861] = false
    BPBID_Arrays.BasePetStats[862] = false
    BPBID_Arrays.BasePetStats[863] = false
    BPBID_Arrays.BasePetStats[864] = false
    BPBID_Arrays.BasePetStats[865] = false
    BPBID_Arrays.BasePetStats[866] = false
    BPBID_Arrays.BasePetStats[867] = false
    BPBID_Arrays.BasePetStats[868] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[869] = false
    BPBID_Arrays.BasePetStats[870] = false
    BPBID_Arrays.BasePetStats[871] = false
    BPBID_Arrays.BasePetStats[872] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[873] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[874] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[875] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[876] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[877] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[878] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[879] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[880] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[881] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[882] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[883] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[884] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[885] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[886] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[887] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[888] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[889] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[890] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[891] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[892] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[893] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[894] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[895] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[896] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[897] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[898] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[899] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[900] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[901] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[902] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[903] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[904] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[905] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[906] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[907] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[908] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[909] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[910] = false
    BPBID_Arrays.BasePetStats[911] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[912] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[913] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[914] = false
    BPBID_Arrays.BasePetStats[915] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[916] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[917] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[918] = false
    BPBID_Arrays.BasePetStats[919] = false
    BPBID_Arrays.BasePetStats[920] = false
    BPBID_Arrays.BasePetStats[921] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[922] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[923] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[924] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[925] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[926] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[927] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[928] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[929] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[930] = false
    BPBID_Arrays.BasePetStats[931] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[932] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[933] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[934] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[935] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[936] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[937] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[938] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[939] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[940] = false
    BPBID_Arrays.BasePetStats[941] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[942] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[943] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[944] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[945] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[946] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[947] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[948] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[949] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[950] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[951] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[952] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[953] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[954] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[955] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[956] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[957] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[958] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[959] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[960] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[961] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[962] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[963] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[964] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[965] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[966] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[967] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[968] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[969] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[970] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[971] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[972] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[973] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[974] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[975] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[976] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[977] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[978] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[979] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[980] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[981] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[982] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[983] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[984] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[985] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[986] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[987] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[988] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[989] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[990] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[991] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[992] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[993] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[994] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[995] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[996] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[997] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[998] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[999] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1000] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1001] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1002] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1003] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1004] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1005] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1006] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1007] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1008] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1009] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1010] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1011] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1012] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1013] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[1014] = false
    BPBID_Arrays.BasePetStats[1015] = false
    BPBID_Arrays.BasePetStats[1016] = false
    BPBID_Arrays.BasePetStats[1017] = false
    BPBID_Arrays.BasePetStats[1018] = false
    BPBID_Arrays.BasePetStats[1019] = false
    BPBID_Arrays.BasePetStats[1020] = false
    BPBID_Arrays.BasePetStats[1021] = false
    BPBID_Arrays.BasePetStats[1022] = false
    BPBID_Arrays.BasePetStats[1023] = false
    BPBID_Arrays.BasePetStats[1024] = false
    BPBID_Arrays.BasePetStats[1025] = false
    BPBID_Arrays.BasePetStats[1026] = false
    BPBID_Arrays.BasePetStats[1027] = false
    BPBID_Arrays.BasePetStats[1028] = false
    BPBID_Arrays.BasePetStats[1029] = false
    BPBID_Arrays.BasePetStats[1030] = false
    BPBID_Arrays.BasePetStats[1031] = false
    BPBID_Arrays.BasePetStats[1032] = false
    BPBID_Arrays.BasePetStats[1033] = false
    BPBID_Arrays.BasePetStats[1034] = false
    BPBID_Arrays.BasePetStats[1035] = false
    BPBID_Arrays.BasePetStats[1036] = false
    BPBID_Arrays.BasePetStats[1037] = false
    BPBID_Arrays.BasePetStats[1038] = false
    BPBID_Arrays.BasePetStats[1039] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[1040] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1041] = false
    BPBID_Arrays.BasePetStats[1042] = {6.75, 10.5, 6.75}
    BPBID_Arrays.BasePetStats[1043] = false
    BPBID_Arrays.BasePetStats[1044] = false
    BPBID_Arrays.BasePetStats[1045] = false
    BPBID_Arrays.BasePetStats[1046] = false
    BPBID_Arrays.BasePetStats[1047] = false
    BPBID_Arrays.BasePetStats[1048] = false
    BPBID_Arrays.BasePetStats[1049] = false
    BPBID_Arrays.BasePetStats[1050] = false
    BPBID_Arrays.BasePetStats[1051] = false
    BPBID_Arrays.BasePetStats[1052] = false
    BPBID_Arrays.BasePetStats[1053] = false
    BPBID_Arrays.BasePetStats[1054] = false
    BPBID_Arrays.BasePetStats[1055] = false
    BPBID_Arrays.BasePetStats[1056] = false
    BPBID_Arrays.BasePetStats[1057] = false
    BPBID_Arrays.BasePetStats[1058] = false
    BPBID_Arrays.BasePetStats[1059] = false
    BPBID_Arrays.BasePetStats[1060] = false
    BPBID_Arrays.BasePetStats[1061] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1062] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1063] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1064] = false
    BPBID_Arrays.BasePetStats[1065] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1066] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1067] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1068] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[1069] = false
    BPBID_Arrays.BasePetStats[1070] = false
    BPBID_Arrays.BasePetStats[1071] = false
    BPBID_Arrays.BasePetStats[1072] = false
    BPBID_Arrays.BasePetStats[1073] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1074] = false
    BPBID_Arrays.BasePetStats[1075] = false
    BPBID_Arrays.BasePetStats[1076] = false
    BPBID_Arrays.BasePetStats[1077] = false
    BPBID_Arrays.BasePetStats[1078] = false
    BPBID_Arrays.BasePetStats[1079] = false
    BPBID_Arrays.BasePetStats[1080] = false
    BPBID_Arrays.BasePetStats[1081] = false
    BPBID_Arrays.BasePetStats[1082] = false
    BPBID_Arrays.BasePetStats[1083] = false
    BPBID_Arrays.BasePetStats[1084] = false
    BPBID_Arrays.BasePetStats[1085] = false
    BPBID_Arrays.BasePetStats[1086] = false
    BPBID_Arrays.BasePetStats[1087] = false
    BPBID_Arrays.BasePetStats[1088] = false
    BPBID_Arrays.BasePetStats[1089] = false
    BPBID_Arrays.BasePetStats[1090] = false
    BPBID_Arrays.BasePetStats[1091] = false
    BPBID_Arrays.BasePetStats[1092] = false
    BPBID_Arrays.BasePetStats[1093] = false
    BPBID_Arrays.BasePetStats[1094] = false
    BPBID_Arrays.BasePetStats[1095] = false
    BPBID_Arrays.BasePetStats[1096] = false
    BPBID_Arrays.BasePetStats[1097] = false
    BPBID_Arrays.BasePetStats[1098] = false
    BPBID_Arrays.BasePetStats[1099] = false
    BPBID_Arrays.BasePetStats[1100] = false
    BPBID_Arrays.BasePetStats[1101] = false
    BPBID_Arrays.BasePetStats[1102] = false
    BPBID_Arrays.BasePetStats[1103] = false
    BPBID_Arrays.BasePetStats[1104] = false
    BPBID_Arrays.BasePetStats[1105] = false
    BPBID_Arrays.BasePetStats[1106] = false
    BPBID_Arrays.BasePetStats[1107] = false
    BPBID_Arrays.BasePetStats[1108] = false
    BPBID_Arrays.BasePetStats[1109] = false
    BPBID_Arrays.BasePetStats[1110] = false
    BPBID_Arrays.BasePetStats[1111] = false
    BPBID_Arrays.BasePetStats[1112] = false
    BPBID_Arrays.BasePetStats[1113] = false
    BPBID_Arrays.BasePetStats[1114] = false
    BPBID_Arrays.BasePetStats[1115] = false
    BPBID_Arrays.BasePetStats[1116] = false
    BPBID_Arrays.BasePetStats[1117] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[1118] = false
    BPBID_Arrays.BasePetStats[1119] = false
    BPBID_Arrays.BasePetStats[1120] = false
    BPBID_Arrays.BasePetStats[1121] = false
    BPBID_Arrays.BasePetStats[1122] = false
    BPBID_Arrays.BasePetStats[1123] = false
    BPBID_Arrays.BasePetStats[1124] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1125] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1126] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1127] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1128] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1129] = {11.5, 15.5, 7.5}
    BPBID_Arrays.BasePetStats[1130] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1131] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1132] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1133] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1134] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1135] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1136] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1137] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1138] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1139] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1140] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1141] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1142] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1143] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1144] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1145] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1146] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1147] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1148] = false
    BPBID_Arrays.BasePetStats[1149] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1150] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1151] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1152] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1153] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1154] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1155] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1156] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1157] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1158] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1159] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1160] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1161] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1162] = {7, 9, 8}
    BPBID_Arrays.BasePetStats[1163] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[1164] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1165] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1166] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1167] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1168] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1169] = false
    BPBID_Arrays.BasePetStats[1170] = false
    BPBID_Arrays.BasePetStats[1171] = false
    BPBID_Arrays.BasePetStats[1172] = false
    BPBID_Arrays.BasePetStats[1173] = false
    BPBID_Arrays.BasePetStats[1174] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1175] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1176] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1177] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[1178] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1179] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1180] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1181] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1182] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1183] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1184] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[1185] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1186] = false
    BPBID_Arrays.BasePetStats[1187] = {11.625, 15.375, 7.625}
    BPBID_Arrays.BasePetStats[1188] = {11.375, 15.125, 7.75}
    BPBID_Arrays.BasePetStats[1189] = {11.875, 16, 7.25}
    BPBID_Arrays.BasePetStats[1190] = {11.125, 14.25, 7.875}
    BPBID_Arrays.BasePetStats[1191] = {12, 15.75, 7}
    BPBID_Arrays.BasePetStats[1192] = {11.625, 15, 7.375}
    BPBID_Arrays.BasePetStats[1193] = {11, 14.5, 7.5}
    BPBID_Arrays.BasePetStats[1194] = {11.25, 15.25, 7.875}
    BPBID_Arrays.BasePetStats[1195] = {11, 15, 8}
    BPBID_Arrays.BasePetStats[1196] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1197] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1198] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1199] = false
    BPBID_Arrays.BasePetStats[1200] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[1201] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1202] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1203] = false
    BPBID_Arrays.BasePetStats[1204] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1205] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[1206] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1207] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[1208] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1209] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1210] = false
    BPBID_Arrays.BasePetStats[1211] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1212] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1213] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1214] = false
    BPBID_Arrays.BasePetStats[1215] = false
    BPBID_Arrays.BasePetStats[1216] = false
    BPBID_Arrays.BasePetStats[1217] = false
    BPBID_Arrays.BasePetStats[1218] = false
    BPBID_Arrays.BasePetStats[1219] = false
    BPBID_Arrays.BasePetStats[1220] = false
    BPBID_Arrays.BasePetStats[1221] = false
    BPBID_Arrays.BasePetStats[1222] = false
    BPBID_Arrays.BasePetStats[1223] = false
    BPBID_Arrays.BasePetStats[1224] = false
    BPBID_Arrays.BasePetStats[1225] = false
    BPBID_Arrays.BasePetStats[1226] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1227] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1228] = {8, 8.25, 7.75}
    BPBID_Arrays.BasePetStats[1229] = {7.75, 8, 8.25}
    BPBID_Arrays.BasePetStats[1230] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[1231] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1232] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[1233] = {8.25, 8.5, 7.25}
    BPBID_Arrays.BasePetStats[1234] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[1235] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1236] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[1237] = {8, 8.25, 7.75}
    BPBID_Arrays.BasePetStats[1238] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1239] = false
    BPBID_Arrays.BasePetStats[1240] = false
    BPBID_Arrays.BasePetStats[1241] = false
    BPBID_Arrays.BasePetStats[1242] = false
    BPBID_Arrays.BasePetStats[1243] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1244] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1245] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1246] = false
    BPBID_Arrays.BasePetStats[1247] = {11, 16, 7}
    BPBID_Arrays.BasePetStats[1248] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[1249] = false
    BPBID_Arrays.BasePetStats[1250] = false
    BPBID_Arrays.BasePetStats[1251] = false
    BPBID_Arrays.BasePetStats[1252] = false
    BPBID_Arrays.BasePetStats[1253] = false
    BPBID_Arrays.BasePetStats[1254] = false
    BPBID_Arrays.BasePetStats[1255] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1256] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1257] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1258] = {8, 9, 7}
    BPBID_Arrays.BasePetStats[1259] = {9, 8, 8}
    BPBID_Arrays.BasePetStats[1260] = false
    BPBID_Arrays.BasePetStats[1261] = false
    BPBID_Arrays.BasePetStats[1262] = false
    BPBID_Arrays.BasePetStats[1263] = false
    BPBID_Arrays.BasePetStats[1264] = false
    BPBID_Arrays.BasePetStats[1265] = false
    BPBID_Arrays.BasePetStats[1266] = {8, 8.25, 7.75}
    BPBID_Arrays.BasePetStats[1267] = {11.25, 15.25, 7}
    BPBID_Arrays.BasePetStats[1268] = {9, 8.375, 6.625}
    BPBID_Arrays.BasePetStats[1269] = {8, 9.25, 6.75}
    BPBID_Arrays.BasePetStats[1270] = false
    BPBID_Arrays.BasePetStats[1271] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1272] = false
    BPBID_Arrays.BasePetStats[1273] = false
    BPBID_Arrays.BasePetStats[1274] = false
    BPBID_Arrays.BasePetStats[1275] = false
    BPBID_Arrays.BasePetStats[1276] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1277] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1278] = {8, 8.25, 7.25}
    BPBID_Arrays.BasePetStats[1279] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1280] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1281] = {8, 8.5, 8}
    BPBID_Arrays.BasePetStats[1282] = {8, 9.25, 6.75}
    BPBID_Arrays.BasePetStats[1283] = {8, 9.5, 6.5}
    BPBID_Arrays.BasePetStats[1284] = {9.25, 8, 6.75}
    BPBID_Arrays.BasePetStats[1285] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1286] = {7.875, 7.875, 8.25}
    BPBID_Arrays.BasePetStats[1287] = {8, 9, 7.25}
    BPBID_Arrays.BasePetStats[1288] = {9.5, 8, 6.5}
    BPBID_Arrays.BasePetStats[1289] = {8, 9.5, 7}
    BPBID_Arrays.BasePetStats[1290] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[1291] = {9.5, 8, 6.5}
    BPBID_Arrays.BasePetStats[1292] = {8, 8, 6.75}
    BPBID_Arrays.BasePetStats[1293] = {8, 7.5, 8}
    BPBID_Arrays.BasePetStats[1294] = false
    BPBID_Arrays.BasePetStats[1295] = {8, 8.75, 7}
    BPBID_Arrays.BasePetStats[1296] = {9.25, 8, 7}
    BPBID_Arrays.BasePetStats[1297] = {8, 8, 8.25}
    BPBID_Arrays.BasePetStats[1298] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1299] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1300] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1301] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1302] = false
    BPBID_Arrays.BasePetStats[1303] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[1304] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1305] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1306] = false
    BPBID_Arrays.BasePetStats[1307] = false
    BPBID_Arrays.BasePetStats[1308] = false
    BPBID_Arrays.BasePetStats[1309] = false
    BPBID_Arrays.BasePetStats[1310] = false
    BPBID_Arrays.BasePetStats[1311] = {11.25, 15.25, 7.375}
    BPBID_Arrays.BasePetStats[1312] = false
    BPBID_Arrays.BasePetStats[1313] = false
    BPBID_Arrays.BasePetStats[1314] = false
    BPBID_Arrays.BasePetStats[1315] = false
    BPBID_Arrays.BasePetStats[1316] = false
    BPBID_Arrays.BasePetStats[1317] = {11.25, 15.25, 6.75}
    BPBID_Arrays.BasePetStats[1318] = false
    BPBID_Arrays.BasePetStats[1319] = {11.25, 15.25, 7.35}
    BPBID_Arrays.BasePetStats[1320] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1321] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1322] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1323] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[1324] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1325] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1326] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1327] = false
    BPBID_Arrays.BasePetStats[1328] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1329] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1330] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1331] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1332] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1333] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[1334] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1335] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1336] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1337] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1338] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1339] = {13, 19.5, 5}
    BPBID_Arrays.BasePetStats[1340] = false
    BPBID_Arrays.BasePetStats[1341] = false
    BPBID_Arrays.BasePetStats[1342] = false
    BPBID_Arrays.BasePetStats[1343] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1344] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[1345] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1346] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1347] = false
    BPBID_Arrays.BasePetStats[1348] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1349] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[1350] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1351] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1352] = {48, 8, 6.5}
    BPBID_Arrays.BasePetStats[1353] = false
    BPBID_Arrays.BasePetStats[1354] = {12, 15.25, 7.35}
    BPBID_Arrays.BasePetStats[1355] = false
    BPBID_Arrays.BasePetStats[1356] = false
    BPBID_Arrays.BasePetStats[1357] = false
    BPBID_Arrays.BasePetStats[1358] = false
    BPBID_Arrays.BasePetStats[1359] = false
    BPBID_Arrays.BasePetStats[1360] = false
    BPBID_Arrays.BasePetStats[1361] = false
    BPBID_Arrays.BasePetStats[1362] = false
    BPBID_Arrays.BasePetStats[1363] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1364] = {8.3, 7.9, 7.8}
    BPBID_Arrays.BasePetStats[1365] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1366] = false
    BPBID_Arrays.BasePetStats[1367] = false
    BPBID_Arrays.BasePetStats[1368] = false
    BPBID_Arrays.BasePetStats[1369] = false
    BPBID_Arrays.BasePetStats[1370] = false
    BPBID_Arrays.BasePetStats[1371] = false
    BPBID_Arrays.BasePetStats[1372] = false
    BPBID_Arrays.BasePetStats[1373] = false
    BPBID_Arrays.BasePetStats[1374] = false
    BPBID_Arrays.BasePetStats[1375] = false
    BPBID_Arrays.BasePetStats[1376] = false
    BPBID_Arrays.BasePetStats[1377] = false
    BPBID_Arrays.BasePetStats[1378] = false
    BPBID_Arrays.BasePetStats[1379] = false
    BPBID_Arrays.BasePetStats[1380] = false
    BPBID_Arrays.BasePetStats[1381] = false
    BPBID_Arrays.BasePetStats[1382] = false
    BPBID_Arrays.BasePetStats[1383] = false
    BPBID_Arrays.BasePetStats[1384] = {8, 8.75, 7.25}
    BPBID_Arrays.BasePetStats[1385] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1386] = {8.125, 6.875, 9}
    BPBID_Arrays.BasePetStats[1387] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1388] = false
    BPBID_Arrays.BasePetStats[1389] = false
    BPBID_Arrays.BasePetStats[1390] = false
    BPBID_Arrays.BasePetStats[1391] = false
    BPBID_Arrays.BasePetStats[1392] = false
    BPBID_Arrays.BasePetStats[1393] = false
    BPBID_Arrays.BasePetStats[1394] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1395] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1396] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1397] = false
    BPBID_Arrays.BasePetStats[1398] = false
    BPBID_Arrays.BasePetStats[1399] = false
    BPBID_Arrays.BasePetStats[1400] = {6.5, 9, 8.5}
    BPBID_Arrays.BasePetStats[1401] = {7, 9, 8}
    BPBID_Arrays.BasePetStats[1402] = {8, 7.25, 8.75}
    BPBID_Arrays.BasePetStats[1403] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1404] = false
    BPBID_Arrays.BasePetStats[1405] = false
    BPBID_Arrays.BasePetStats[1406] = false
    BPBID_Arrays.BasePetStats[1407] = false
    BPBID_Arrays.BasePetStats[1408] = false
    BPBID_Arrays.BasePetStats[1409] = {23, 8, 6.25}
    BPBID_Arrays.BasePetStats[1410] = {13.32, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[1411] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1412] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1413] = false
    BPBID_Arrays.BasePetStats[1414] = false
    BPBID_Arrays.BasePetStats[1415] = false
    BPBID_Arrays.BasePetStats[1416] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1417] = false
    BPBID_Arrays.BasePetStats[1418] = false
    BPBID_Arrays.BasePetStats[1419] = false
    BPBID_Arrays.BasePetStats[1420] = {9, 8, 8}
    BPBID_Arrays.BasePetStats[1421] = false
    BPBID_Arrays.BasePetStats[1422] = false
    BPBID_Arrays.BasePetStats[1423] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1424] = {8, 8, 7.5}
    BPBID_Arrays.BasePetStats[1425] = false
    BPBID_Arrays.BasePetStats[1426] = {13, 8, 5.5}
    BPBID_Arrays.BasePetStats[1427] = {7.625, 7.875, 8.5}
    BPBID_Arrays.BasePetStats[1428] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1429] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1430] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1431] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1432] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1433] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1434] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1435] = {9, 8.5, 6.5}
    BPBID_Arrays.BasePetStats[1436] = false
    BPBID_Arrays.BasePetStats[1437] = false
    BPBID_Arrays.BasePetStats[1438] = false
    BPBID_Arrays.BasePetStats[1439] = false
    BPBID_Arrays.BasePetStats[1440] = false
    BPBID_Arrays.BasePetStats[1441] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1442] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1443] = {8, 8, 7.25}
    BPBID_Arrays.BasePetStats[1444] = {8, 8, 7.5}
    BPBID_Arrays.BasePetStats[1445] = false
    BPBID_Arrays.BasePetStats[1446] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1447] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1448] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1449] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1450] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1451] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1452] = false
    BPBID_Arrays.BasePetStats[1453] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1454] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1455] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1456] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1457] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1458] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1459] = false
    BPBID_Arrays.BasePetStats[1460] = false
    BPBID_Arrays.BasePetStats[1461] = false
    BPBID_Arrays.BasePetStats[1462] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1463] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1464] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1465] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1466] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1467] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1468] = {7.625, 8.25, 8.125}
    BPBID_Arrays.BasePetStats[1469] = {7.625, 8.25, 8.125}
    BPBID_Arrays.BasePetStats[1470] = {7.625, 8.25, 8.125}
    BPBID_Arrays.BasePetStats[1471] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1472] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1473] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[1474] = {8.625, 8, 7.375}
    BPBID_Arrays.BasePetStats[1475] = {8, 8, 7.5}
    BPBID_Arrays.BasePetStats[1476] = {8, 8, 7.5}
    BPBID_Arrays.BasePetStats[1477] = {8, 8, 7.5}
    BPBID_Arrays.BasePetStats[1478] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1479] = {13.625, 7.5, 9}
    BPBID_Arrays.BasePetStats[1480] = {23.5, 8, 7.375}
    BPBID_Arrays.BasePetStats[1481] = false
    BPBID_Arrays.BasePetStats[1482] = {14.25, 8, 7}
    BPBID_Arrays.BasePetStats[1483] = {6, 10, 8}
    BPBID_Arrays.BasePetStats[1484] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1485] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1486] = {23, 8, 5.5}
    BPBID_Arrays.BasePetStats[1487] = {16, 8.25, 7.25}
    BPBID_Arrays.BasePetStats[1488] = {16, 8, 7.5}
    BPBID_Arrays.BasePetStats[1489] = {15.5, 9.25, 6.75}
    BPBID_Arrays.BasePetStats[1490] = {14.25, 9.25, 8}
    BPBID_Arrays.BasePetStats[1491] = false
    BPBID_Arrays.BasePetStats[1492] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[1493] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1494] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1495] = {7.75, 7.75, 8.5}
    BPBID_Arrays.BasePetStats[1496] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1497] = {7.625, 8.25, 8.125}
    BPBID_Arrays.BasePetStats[1498] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1499] = {13.5, 9, 7}
    BPBID_Arrays.BasePetStats[1500] = {13.5, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1501] = {10, 7, 7}
    BPBID_Arrays.BasePetStats[1502] = {8, 8, 7.5}
    BPBID_Arrays.BasePetStats[1503] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1504] = {7.25, 7.25, 9.25}
    BPBID_Arrays.BasePetStats[1505] = {7.25, 8.75, 8}
    BPBID_Arrays.BasePetStats[1506] = {7.25, 8.75, 8}
    BPBID_Arrays.BasePetStats[1507] = {23, 10, 6}
    BPBID_Arrays.BasePetStats[1508] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1509] = {8, 8.75, 6.75}
    BPBID_Arrays.BasePetStats[1510] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1511] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1512] = false
    BPBID_Arrays.BasePetStats[1513] = false
    BPBID_Arrays.BasePetStats[1514] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1515] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1516] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1517] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1518] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1519] = {9.5, 9.75, 9.75}
    BPBID_Arrays.BasePetStats[1520] = false
    BPBID_Arrays.BasePetStats[1521] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1522] = false
    BPBID_Arrays.BasePetStats[1523] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1524] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1525] = false
    BPBID_Arrays.BasePetStats[1526] = false
    BPBID_Arrays.BasePetStats[1527] = false
    BPBID_Arrays.BasePetStats[1528] = false
    BPBID_Arrays.BasePetStats[1529] = false
    BPBID_Arrays.BasePetStats[1530] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1531] = {8.5, 7, 8.5}
    BPBID_Arrays.BasePetStats[1532] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1533] = {8.5, 9, 6.5}
    BPBID_Arrays.BasePetStats[1534] = false
    BPBID_Arrays.BasePetStats[1535] = false
    BPBID_Arrays.BasePetStats[1536] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1537] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1538] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1539] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1540] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1541] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1542] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1543] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[1544] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1545] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1546] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1547] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1548] = {9.5, 8, 6.5}
    BPBID_Arrays.BasePetStats[1549] = {7.25, 9.25, 7.5}
    BPBID_Arrays.BasePetStats[1550] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1551] = false
    BPBID_Arrays.BasePetStats[1552] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1553] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1554] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1555] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1556] = {9.25, 9.25, 5.5}
    BPBID_Arrays.BasePetStats[1557] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1558] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1559] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1560] = {8, 10.75, 8}
    BPBID_Arrays.BasePetStats[1561] = {8, 9.5, 8}
    BPBID_Arrays.BasePetStats[1562] = {8, 10, 8}
    BPBID_Arrays.BasePetStats[1563] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1564] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1565] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1566] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1567] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1568] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1569] = {9.75, 7.25, 7}
    BPBID_Arrays.BasePetStats[1570] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1571] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1572] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1573] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1574] = {7.5, 9.5, 7}
    BPBID_Arrays.BasePetStats[1575] = {7, 9, 8}
    BPBID_Arrays.BasePetStats[1576] = {6.75, 9.25, 8}
    BPBID_Arrays.BasePetStats[1577] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1578] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1579] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1580] = false
    BPBID_Arrays.BasePetStats[1581] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1582] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1583] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1584] = false
    BPBID_Arrays.BasePetStats[1585] = false
    BPBID_Arrays.BasePetStats[1586] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1587] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1588] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1589] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1590] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1591] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1592] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1593] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1594] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1595] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1596] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1597] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1598] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[1599] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[1600] = {7.5, 9.5, 7}
    BPBID_Arrays.BasePetStats[1601] = {6.75, 9.25, 8}
    BPBID_Arrays.BasePetStats[1602] = {6.75, 9.25, 8}
    BPBID_Arrays.BasePetStats[1603] = {7, 8, 9}
    BPBID_Arrays.BasePetStats[1604] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1605] = {8, 9.5, 6.5}
    BPBID_Arrays.BasePetStats[1606] = false
    BPBID_Arrays.BasePetStats[1607] = {8.625, 8, 7.375}
    BPBID_Arrays.BasePetStats[1608] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[1609] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1610] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1611] = false
    BPBID_Arrays.BasePetStats[1612] = false
    BPBID_Arrays.BasePetStats[1613] = false
    BPBID_Arrays.BasePetStats[1614] = false
    BPBID_Arrays.BasePetStats[1615] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1616] = false
    BPBID_Arrays.BasePetStats[1617] = false
    BPBID_Arrays.BasePetStats[1618] = false
    BPBID_Arrays.BasePetStats[1619] = false
    BPBID_Arrays.BasePetStats[1620] = false
    BPBID_Arrays.BasePetStats[1621] = false
    BPBID_Arrays.BasePetStats[1622] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1623] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1624] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1625] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1626] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1627] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1628] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1629] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1630] = false
    BPBID_Arrays.BasePetStats[1631] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1632] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1633] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1634] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1635] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1636] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1637] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1638] = false
    BPBID_Arrays.BasePetStats[1639] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[1640] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[1641] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1642] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1643] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1644] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1645] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1646] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1647] = {7.5, 9.5, 7}
    BPBID_Arrays.BasePetStats[1648] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1649] = {9, 8.5, 6.5}
    BPBID_Arrays.BasePetStats[1650] = false
    BPBID_Arrays.BasePetStats[1651] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1652] = {7.625, 7.875, 8.5}
    BPBID_Arrays.BasePetStats[1653] = {7.625, 7.875, 8.5}
    BPBID_Arrays.BasePetStats[1654] = {7.625, 7.875, 8.5}
    BPBID_Arrays.BasePetStats[1655] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1656] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1657] = false
    BPBID_Arrays.BasePetStats[1658] = false
    BPBID_Arrays.BasePetStats[1659] = false
    BPBID_Arrays.BasePetStats[1660] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1661] = {7.75, 7.75, 8.5}
    BPBID_Arrays.BasePetStats[1662] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1663] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1664] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1665] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[1666] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1667] = false
    BPBID_Arrays.BasePetStats[1668] = false
    BPBID_Arrays.BasePetStats[1669] = false
    BPBID_Arrays.BasePetStats[1670] = false
    BPBID_Arrays.BasePetStats[1671] = {11.75, 9.25, 8}
    BPBID_Arrays.BasePetStats[1672] = {8.5, 8.75, 6.75}
    BPBID_Arrays.BasePetStats[1673] = {10.5, 10.5, 8}
    BPBID_Arrays.BasePetStats[1674] = {8, 11.75, 9.25}
    BPBID_Arrays.BasePetStats[1675] = {9.25, 10.5, 9.25}
    BPBID_Arrays.BasePetStats[1676] = {9.25, 8, 11.75}
    BPBID_Arrays.BasePetStats[1677] = {10.5, 9.25, 9.25}
    BPBID_Arrays.BasePetStats[1678] = {9.25, 9.25, 10.5}
    BPBID_Arrays.BasePetStats[1679] = {8, 10.5, 10.5}
    BPBID_Arrays.BasePetStats[1680] = {11.75, 8, 9.25}
    BPBID_Arrays.BasePetStats[1681] = {10.5, 8, 10.5}
    BPBID_Arrays.BasePetStats[1682] = {9.665, 9.665, 9.665}
    BPBID_Arrays.BasePetStats[1683] = {8, 13, 8}
    BPBID_Arrays.BasePetStats[1684] = {9.25, 11.75, 8}
    BPBID_Arrays.BasePetStats[1685] = {8, 9.25, 11.75}
    BPBID_Arrays.BasePetStats[1686] = {13, 8, 8}
    BPBID_Arrays.BasePetStats[1687] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[1688] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[1689] = false
    BPBID_Arrays.BasePetStats[1690] = {7.25, 8.75, 8}
    BPBID_Arrays.BasePetStats[1691] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1692] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1693] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1694] = false
    BPBID_Arrays.BasePetStats[1695] = false
    BPBID_Arrays.BasePetStats[1696] = false
    BPBID_Arrays.BasePetStats[1697] = false
    BPBID_Arrays.BasePetStats[1698] = false
    BPBID_Arrays.BasePetStats[1699] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1700] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1701] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1702] = false
    BPBID_Arrays.BasePetStats[1703] = false
    BPBID_Arrays.BasePetStats[1704] = false
    BPBID_Arrays.BasePetStats[1705] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1706] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1707] = false
    BPBID_Arrays.BasePetStats[1708] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1709] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1710] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1711] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[1712] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1713] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1714] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1715] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1716] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1717] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1718] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1719] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[1720] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1721] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1722] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1723] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1724] = false
    BPBID_Arrays.BasePetStats[1725] = {8.25, 8.5, 7.25}
    BPBID_Arrays.BasePetStats[1726] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1727] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1728] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1729] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[1730] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1731] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1732] = false
    BPBID_Arrays.BasePetStats[1733] = false
    BPBID_Arrays.BasePetStats[1734] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1735] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1736] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1737] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1738] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1739] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1740] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1741] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1742] = {10.5, 10.5, 6.75}
    BPBID_Arrays.BasePetStats[1743] = {7.75, 7.75, 8.5}
    BPBID_Arrays.BasePetStats[1744] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1745] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[1746] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[1747] = false
    BPBID_Arrays.BasePetStats[1748] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1749] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1750] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1751] = {9, 8.5, 6.5}
    BPBID_Arrays.BasePetStats[1752] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1753] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[1754] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[1755] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[1756] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1757] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1758] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1759] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1760] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1761] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1762] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1763] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1764] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[1765] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[1766] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[1767] = false
    BPBID_Arrays.BasePetStats[1768] = false
    BPBID_Arrays.BasePetStats[1769] = false
    BPBID_Arrays.BasePetStats[1770] = {9, 8.5, 6.5}
    BPBID_Arrays.BasePetStats[1771] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1772] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1773] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[1774] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[1775] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1776] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[1777] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[1778] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[1779] = false
    BPBID_Arrays.BasePetStats[1780] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[1781] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[1782] = {8, 8.25, 7.75}
    BPBID_Arrays.BasePetStats[1783] = false
    BPBID_Arrays.BasePetStats[1784] = false
    BPBID_Arrays.BasePetStats[1785] = false
    BPBID_Arrays.BasePetStats[1786] = false
    BPBID_Arrays.BasePetStats[1787] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[1788] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1789] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[1790] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1791] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1792] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[1793] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1794] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1795] = {8.3, 7.9, 7.8}
    BPBID_Arrays.BasePetStats[1796] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1797] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1798] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1799] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1800] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1801] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1802] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1803] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1804] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1805] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1806] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1807] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1808] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1809] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1810] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1811] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1812] = false
    BPBID_Arrays.BasePetStats[1813] = false
    BPBID_Arrays.BasePetStats[1814] = false
    BPBID_Arrays.BasePetStats[1815] = {13, 9.25, 8}
    BPBID_Arrays.BasePetStats[1816] = {8, 8, 5.5}
    BPBID_Arrays.BasePetStats[1817] = {8, 8, 5.5}
    BPBID_Arrays.BasePetStats[1818] = {8, 8, 5.5}
    BPBID_Arrays.BasePetStats[1819] = false
    BPBID_Arrays.BasePetStats[1820] = false
    BPBID_Arrays.BasePetStats[1821] = false
    BPBID_Arrays.BasePetStats[1822] = false
    BPBID_Arrays.BasePetStats[1823] = false
    BPBID_Arrays.BasePetStats[1824] = false
    BPBID_Arrays.BasePetStats[1825] = false
    BPBID_Arrays.BasePetStats[1826] = false
    BPBID_Arrays.BasePetStats[1827] = false
    BPBID_Arrays.BasePetStats[1828] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[1829] = false
    BPBID_Arrays.BasePetStats[1830] = false
    BPBID_Arrays.BasePetStats[1831] = false
    BPBID_Arrays.BasePetStats[1832] = false
    BPBID_Arrays.BasePetStats[1833] = false
    BPBID_Arrays.BasePetStats[1834] = false
    BPBID_Arrays.BasePetStats[1835] = false
    BPBID_Arrays.BasePetStats[1836] = false
    BPBID_Arrays.BasePetStats[1837] = false
    BPBID_Arrays.BasePetStats[1838] = false
    BPBID_Arrays.BasePetStats[1839] = false
    BPBID_Arrays.BasePetStats[1840] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[1841] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[1842] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[1843] = {11.75, 8, 8}
    BPBID_Arrays.BasePetStats[1844] = false
    BPBID_Arrays.BasePetStats[1845] = false
    BPBID_Arrays.BasePetStats[1846] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1847] = {7.75, 8, 8.25}
    BPBID_Arrays.BasePetStats[1848] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1849] = {10.5, 9.25, 8}
    BPBID_Arrays.BasePetStats[1850] = {10.5, 8, 8}
    BPBID_Arrays.BasePetStats[1851] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1852] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1853] = {9.75, 7.25, 7}
    BPBID_Arrays.BasePetStats[1854] = false
    BPBID_Arrays.BasePetStats[1855] = {11.125, 14.25, 7.875}
    BPBID_Arrays.BasePetStats[1856] = false
    BPBID_Arrays.BasePetStats[1857] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1858] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[1859] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1860] = {9, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[1861] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1862] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1863] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[1864] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[1865] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[1866] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1867] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1868] = {8.5, 8, 8}
    BPBID_Arrays.BasePetStats[1869] = {8, 8.25, 7.75}
    BPBID_Arrays.BasePetStats[1870] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1871] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1872] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1873] = {8.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1874] = {8.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1875] = {8.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1876] = false
    BPBID_Arrays.BasePetStats[1877] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1878] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1879] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[1880] = {25.5, 10.5, 6}
    BPBID_Arrays.BasePetStats[1881] = {15.5, 10.5, 8}
    BPBID_Arrays.BasePetStats[1882] = {18, 9.25, 7}
    BPBID_Arrays.BasePetStats[1883] = {18, 9, 8}
    BPBID_Arrays.BasePetStats[1884] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1885] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1886] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1887] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1888] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1889] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1890] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1891] = {15.5, 10.5, 8}
    BPBID_Arrays.BasePetStats[1892] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1893] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1894] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1895] = {10.5, 9.25, 8}
    BPBID_Arrays.BasePetStats[1896] = {10.5, 9.25, 8}
    BPBID_Arrays.BasePetStats[1897] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1898] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1899] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1900] = false
    BPBID_Arrays.BasePetStats[1901] = false
    BPBID_Arrays.BasePetStats[1902] = false
    BPBID_Arrays.BasePetStats[1903] = {9.5, 8.5, -1.375}
    BPBID_Arrays.BasePetStats[1904] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1905] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1906] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1907] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1908] = false
    BPBID_Arrays.BasePetStats[1909] = false
    BPBID_Arrays.BasePetStats[1910] = false
    BPBID_Arrays.BasePetStats[1911] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1912] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[1913] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1914] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1915] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1916] = false
    BPBID_Arrays.BasePetStats[1917] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1918] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1919] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1920] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1921] = {8.25, 7.75, 8}
    BPBID_Arrays.BasePetStats[1922] = {7.75, 8, 8.25}
    BPBID_Arrays.BasePetStats[1923] = false
    BPBID_Arrays.BasePetStats[1924] = false
    BPBID_Arrays.BasePetStats[1925] = false
    BPBID_Arrays.BasePetStats[1926] = {8, 9, 7}
    BPBID_Arrays.BasePetStats[1927] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1928] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[1929] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1930] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1931] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1932] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[1933] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1934] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1935] = {7.75, 7.75, 8.5}
    BPBID_Arrays.BasePetStats[1936] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[1937] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1938] = {8, 8.25, 7.75}
    BPBID_Arrays.BasePetStats[1939] = {8, 8.25, 7.75}
    BPBID_Arrays.BasePetStats[1940] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[1941] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1942] = false
    BPBID_Arrays.BasePetStats[1943] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[1944] = false
    BPBID_Arrays.BasePetStats[1945] = false
    BPBID_Arrays.BasePetStats[1946] = false
    BPBID_Arrays.BasePetStats[1947] = false
    BPBID_Arrays.BasePetStats[1948] = false
    BPBID_Arrays.BasePetStats[1949] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1950] = false
    BPBID_Arrays.BasePetStats[1951] = false
    BPBID_Arrays.BasePetStats[1952] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1953] = {8, 7.75, 8.25}
    BPBID_Arrays.BasePetStats[1954] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1955] = {7, 9, 8}
    BPBID_Arrays.BasePetStats[1956] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[1957] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[1958] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1959] = {9, 7.625, 7.375}
    BPBID_Arrays.BasePetStats[1960] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1961] = {8.75, 7.75, 7.5}
    BPBID_Arrays.BasePetStats[1962] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1963] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1964] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1965] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[1966] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1967] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[1968] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[1969] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[1970] = false
    BPBID_Arrays.BasePetStats[1971] = {8.25, 8.5, 8.25}
    BPBID_Arrays.BasePetStats[1972] = {8.25, 8.25, 8.5}
    BPBID_Arrays.BasePetStats[1973] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[1974] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1975] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1976] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1977] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1978] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1979] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1980] = false
    BPBID_Arrays.BasePetStats[1981] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1982] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1983] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1984] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[1985] = false
    BPBID_Arrays.BasePetStats[1986] = false
    BPBID_Arrays.BasePetStats[1987] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1988] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1989] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1990] = {10.5, 10.5, 8}
    BPBID_Arrays.BasePetStats[1991] = {9, 9, 8}
    BPBID_Arrays.BasePetStats[1992] = {9, 9, 8}
    BPBID_Arrays.BasePetStats[1993] = {9, 9, 8}
    BPBID_Arrays.BasePetStats[1994] = {10.5, 10.5, 8}
    BPBID_Arrays.BasePetStats[1995] = {9.5, 9.5, 8}
    BPBID_Arrays.BasePetStats[1996] = {11.75, 11.75, 8}
    BPBID_Arrays.BasePetStats[1997] = {7.625, 8.25, 8.125}
    BPBID_Arrays.BasePetStats[1998] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[1999] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2000] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2001] = {8.5, 8.25, 7.25}
    BPBID_Arrays.BasePetStats[2002] = {9.5, 8, 6.5}
    BPBID_Arrays.BasePetStats[2003] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2004] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2005] = false
    BPBID_Arrays.BasePetStats[2006] = false
    BPBID_Arrays.BasePetStats[2007] = false
    BPBID_Arrays.BasePetStats[2008] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[2009] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2010] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2011] = {7.75, 8, 8.25}
    BPBID_Arrays.BasePetStats[2012] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2013] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2014] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2015] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2016] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2017] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[2018] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2019] = false
    BPBID_Arrays.BasePetStats[2020] = false
    BPBID_Arrays.BasePetStats[2021] = false
    BPBID_Arrays.BasePetStats[2022] = {8, 9.25, 6.75}
    BPBID_Arrays.BasePetStats[2023] = {8.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[2024] = {9, 8, 8}
    BPBID_Arrays.BasePetStats[2025] = {8.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2026] = {9, 8, 8}
    BPBID_Arrays.BasePetStats[2027] = {9, 8, 8}
    BPBID_Arrays.BasePetStats[2028] = {9, 8, 8}
    BPBID_Arrays.BasePetStats[2029] = false
    BPBID_Arrays.BasePetStats[2030] = false
    BPBID_Arrays.BasePetStats[2031] = {10.5, 10.5, 8}
    BPBID_Arrays.BasePetStats[2032] = {10.5, 9.25, 8}
    BPBID_Arrays.BasePetStats[2033] = {10.5, 10.5, 6.75}
    BPBID_Arrays.BasePetStats[2034] = false
    BPBID_Arrays.BasePetStats[2035] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2036] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2037] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2038] = {8, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[2039] = {8.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2040] = {8.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2041] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2042] = {7.75, 7.75, 8.5}
    BPBID_Arrays.BasePetStats[2043] = false
    BPBID_Arrays.BasePetStats[2044] = false
    BPBID_Arrays.BasePetStats[2045] = false
    BPBID_Arrays.BasePetStats[2046] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2047] = {8, 8.25, 7.75}
    BPBID_Arrays.BasePetStats[2048] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2049] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2050] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2051] = {7.75, 8.125, 8.125}
    BPBID_Arrays.BasePetStats[2052] = false
    BPBID_Arrays.BasePetStats[2053] = false
    BPBID_Arrays.BasePetStats[2054] = false
    BPBID_Arrays.BasePetStats[2055] = false
    BPBID_Arrays.BasePetStats[2056] = false
    BPBID_Arrays.BasePetStats[2057] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2058] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2059] = false
    BPBID_Arrays.BasePetStats[2060] = false
    BPBID_Arrays.BasePetStats[2061] = false
    BPBID_Arrays.BasePetStats[2062] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2063] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2064] = {8.25, 7.75, 8}
    BPBID_Arrays.BasePetStats[2065] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2066] = {8.75, 8.5, 8}
    BPBID_Arrays.BasePetStats[2067] = {7.5, 9, 9.5}
    BPBID_Arrays.BasePetStats[2068] = {9.5, 9.5, 6.5}
    BPBID_Arrays.BasePetStats[2069] = false
    BPBID_Arrays.BasePetStats[2070] = false
    BPBID_Arrays.BasePetStats[2071] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2072] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2073] = false
    BPBID_Arrays.BasePetStats[2074] = false
    BPBID_Arrays.BasePetStats[2075] = false
    BPBID_Arrays.BasePetStats[2076] = {8.25, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[2077] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[2078] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2079] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[2080] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[2081] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2082] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2083] = {8, 8.25, 7.75}
    BPBID_Arrays.BasePetStats[2084] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[2085] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[2086] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[2087] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2088] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[2089] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2090] = {7.75, 8, 8.25}
    BPBID_Arrays.BasePetStats[2091] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2092] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2093] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2094] = false
    BPBID_Arrays.BasePetStats[2095] = {11.25, 17.25, 9.75}
    BPBID_Arrays.BasePetStats[2096] = {10.75, 17.75, 9.75}
    BPBID_Arrays.BasePetStats[2097] = {11.75, 16.75, 7.75}
    BPBID_Arrays.BasePetStats[2098] = {12.5, 16, 8}
    BPBID_Arrays.BasePetStats[2099] = {12.25, 16.25, 9}
    BPBID_Arrays.BasePetStats[2100] = {11.75, 16.75, 8.25}
    BPBID_Arrays.BasePetStats[2101] = {11.5, 17, 8.5}
    BPBID_Arrays.BasePetStats[2102] = {11, 17.5, 9.5}
    BPBID_Arrays.BasePetStats[2103] = {12, 16.5, 7.5}
    BPBID_Arrays.BasePetStats[2104] = {12, 16.5, 8.25}
    BPBID_Arrays.BasePetStats[2105] = {11.25, 17.25, 7.25}
    BPBID_Arrays.BasePetStats[2106] = {12.25, 16.25, 8.75}
    BPBID_Arrays.BasePetStats[2107] = {10.5, 18, 10.5}
    BPBID_Arrays.BasePetStats[2108] = {11, 17.5, 7.25}
    BPBID_Arrays.BasePetStats[2109] = {11.5, 17, 7.75}
    BPBID_Arrays.BasePetStats[2110] = {12.5, 16, 7}
    BPBID_Arrays.BasePetStats[2111] = {13, 18, 5.5}
    BPBID_Arrays.BasePetStats[2112] = {12.75, 15.75, 6.5}
    BPBID_Arrays.BasePetStats[2113] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[2114] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[2115] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[2116] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2117] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[2118] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2119] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2120] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[2121] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2122] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2123] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2124] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2125] = false
    BPBID_Arrays.BasePetStats[2126] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2127] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2128] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2129] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2130] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[2131] = {8.25, 7.75, 8}
    BPBID_Arrays.BasePetStats[2132] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[2133] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2134] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2135] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[2136] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2137] = false
    BPBID_Arrays.BasePetStats[2138] = false
    BPBID_Arrays.BasePetStats[2139] = false
    BPBID_Arrays.BasePetStats[2140] = false
    BPBID_Arrays.BasePetStats[2141] = false
    BPBID_Arrays.BasePetStats[2142] = false
    BPBID_Arrays.BasePetStats[2143] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2144] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2145] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2146] = {7.625, 8.25, 8.125}
    BPBID_Arrays.BasePetStats[2147] = false
    BPBID_Arrays.BasePetStats[2148] = false
    BPBID_Arrays.BasePetStats[2149] = false
    BPBID_Arrays.BasePetStats[2150] = false
    BPBID_Arrays.BasePetStats[2151] = false
    BPBID_Arrays.BasePetStats[2152] = false
    BPBID_Arrays.BasePetStats[2153] = false
    BPBID_Arrays.BasePetStats[2154] = false
    BPBID_Arrays.BasePetStats[2155] = false
    BPBID_Arrays.BasePetStats[2156] = false
    BPBID_Arrays.BasePetStats[2157] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[2158] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[2159] = false
    BPBID_Arrays.BasePetStats[2160] = false
    BPBID_Arrays.BasePetStats[2161] = false
    BPBID_Arrays.BasePetStats[2162] = false
    BPBID_Arrays.BasePetStats[2163] = {7.75, 8, 8.25}
    BPBID_Arrays.BasePetStats[2164] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2165] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2166] = false
    BPBID_Arrays.BasePetStats[2167] = false
    BPBID_Arrays.BasePetStats[2168] = false
    BPBID_Arrays.BasePetStats[2169] = false
    BPBID_Arrays.BasePetStats[2170] = false
    BPBID_Arrays.BasePetStats[2171] = false
    BPBID_Arrays.BasePetStats[2172] = false
    BPBID_Arrays.BasePetStats[2173] = false
    BPBID_Arrays.BasePetStats[2174] = false
    BPBID_Arrays.BasePetStats[2175] = false
    BPBID_Arrays.BasePetStats[2176] = false
    BPBID_Arrays.BasePetStats[2177] = false
    BPBID_Arrays.BasePetStats[2178] = false
    BPBID_Arrays.BasePetStats[2179] = false
    BPBID_Arrays.BasePetStats[2180] = false
    BPBID_Arrays.BasePetStats[2181] = false
    BPBID_Arrays.BasePetStats[2182] = false
    BPBID_Arrays.BasePetStats[2183] = false
    BPBID_Arrays.BasePetStats[2184] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2185] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2186] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2187] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2188] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2189] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2190] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2191] = false
    BPBID_Arrays.BasePetStats[2192] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2193] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[2194] = {7.875, 8.25, 7.875}
    BPBID_Arrays.BasePetStats[2195] = {8, 7.875, 8.125}
    BPBID_Arrays.BasePetStats[2196] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2197] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2198] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2199] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2200] = {18, 6.75, 6.75}
    BPBID_Arrays.BasePetStats[2201] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2202] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2203] = {15.5, 6.75, 6.75}
    BPBID_Arrays.BasePetStats[2204] = {15.5, 6.75, 6.75}
    BPBID_Arrays.BasePetStats[2205] = {15.5, 6.75, 6.75}
    BPBID_Arrays.BasePetStats[2206] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2207] = false
    BPBID_Arrays.BasePetStats[2208] = {9.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[2209] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2210] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2211] = {10.5, 8, 8}
    BPBID_Arrays.BasePetStats[2212] = {10.5, 8, 8}
    BPBID_Arrays.BasePetStats[2213] = {33, 8, 8}
    BPBID_Arrays.BasePetStats[2214] = {33, 8, 8}
    BPBID_Arrays.BasePetStats[2215] = {33, 8, 8}
    BPBID_Arrays.BasePetStats[2216] = false
    BPBID_Arrays.BasePetStats[2217] = false
    BPBID_Arrays.BasePetStats[2218] = false
    BPBID_Arrays.BasePetStats[2219] = false
    BPBID_Arrays.BasePetStats[2220] = {9.25, 8, 9.25}
    BPBID_Arrays.BasePetStats[2221] = {9.25, 9.25, 5.5}
    BPBID_Arrays.BasePetStats[2222] = {9.25, 9.25, 9.25}
    BPBID_Arrays.BasePetStats[2223] = {8, 9.25, 9.25}
    BPBID_Arrays.BasePetStats[2224] = false
    BPBID_Arrays.BasePetStats[2225] = {8, 9.25, 9.25}
    BPBID_Arrays.BasePetStats[2226] = {8, 8, 10.5}
    BPBID_Arrays.BasePetStats[2227] = {10.5, 10.5, 8}
    BPBID_Arrays.BasePetStats[2228] = {10.5, 8, 10.5}
    BPBID_Arrays.BasePetStats[2229] = {10.5, 10.5, 8}
    BPBID_Arrays.BasePetStats[2230] = {5.5, 10.5, 10.5}
    BPBID_Arrays.BasePetStats[2231] = {9, 8, 9}
    BPBID_Arrays.BasePetStats[2232] = {8, 8.75, 9}
    BPBID_Arrays.BasePetStats[2233] = {9, 9.5, 7.25}
    BPBID_Arrays.BasePetStats[2234] = false
    BPBID_Arrays.BasePetStats[2235] = false
    BPBID_Arrays.BasePetStats[2236] = false
    BPBID_Arrays.BasePetStats[2237] = false
    BPBID_Arrays.BasePetStats[2238] = false
    BPBID_Arrays.BasePetStats[2239] = false
    BPBID_Arrays.BasePetStats[2240] = false
    BPBID_Arrays.BasePetStats[2241] = false
    BPBID_Arrays.BasePetStats[2242] = false
    BPBID_Arrays.BasePetStats[2243] = false
    BPBID_Arrays.BasePetStats[2244] = false
    BPBID_Arrays.BasePetStats[2245] = false
    BPBID_Arrays.BasePetStats[2246] = false
    BPBID_Arrays.BasePetStats[2247] = false
    BPBID_Arrays.BasePetStats[2248] = false
    BPBID_Arrays.BasePetStats[2249] = false
    BPBID_Arrays.BasePetStats[2250] = false
    BPBID_Arrays.BasePetStats[2251] = false
    BPBID_Arrays.BasePetStats[2252] = false
    BPBID_Arrays.BasePetStats[2253] = false
    BPBID_Arrays.BasePetStats[2254] = false
    BPBID_Arrays.BasePetStats[2255] = false
    BPBID_Arrays.BasePetStats[2256] = false
    BPBID_Arrays.BasePetStats[2257] = false
    BPBID_Arrays.BasePetStats[2258] = false
    BPBID_Arrays.BasePetStats[2259] = false
    BPBID_Arrays.BasePetStats[2260] = false
    BPBID_Arrays.BasePetStats[2261] = false
    BPBID_Arrays.BasePetStats[2262] = false
    BPBID_Arrays.BasePetStats[2263] = false
    BPBID_Arrays.BasePetStats[2264] = false
    BPBID_Arrays.BasePetStats[2265] = false
    BPBID_Arrays.BasePetStats[2266] = false
    BPBID_Arrays.BasePetStats[2267] = false
    BPBID_Arrays.BasePetStats[2268] = false
    BPBID_Arrays.BasePetStats[2269] = false
    BPBID_Arrays.BasePetStats[2270] = false
    BPBID_Arrays.BasePetStats[2271] = false
    BPBID_Arrays.BasePetStats[2272] = false
    BPBID_Arrays.BasePetStats[2273] = false
    BPBID_Arrays.BasePetStats[2274] = false
    BPBID_Arrays.BasePetStats[2275] = false
    BPBID_Arrays.BasePetStats[2276] = false
    BPBID_Arrays.BasePetStats[2277] = false
    BPBID_Arrays.BasePetStats[2278] = false
    BPBID_Arrays.BasePetStats[2279] = false
    BPBID_Arrays.BasePetStats[2280] = false
    BPBID_Arrays.BasePetStats[2281] = false
    BPBID_Arrays.BasePetStats[2282] = false
    BPBID_Arrays.BasePetStats[2283] = false
    BPBID_Arrays.BasePetStats[2284] = false
    BPBID_Arrays.BasePetStats[2285] = false
    BPBID_Arrays.BasePetStats[2286] = false
    BPBID_Arrays.BasePetStats[2287] = false
    BPBID_Arrays.BasePetStats[2288] = false
    BPBID_Arrays.BasePetStats[2289] = false
    BPBID_Arrays.BasePetStats[2290] = false
    BPBID_Arrays.BasePetStats[2291] = false
    BPBID_Arrays.BasePetStats[2292] = false
    BPBID_Arrays.BasePetStats[2293] = false
    BPBID_Arrays.BasePetStats[2294] = false
    BPBID_Arrays.BasePetStats[2295] = false
    BPBID_Arrays.BasePetStats[2296] = false
    BPBID_Arrays.BasePetStats[2297] = false
    BPBID_Arrays.BasePetStats[2298] = false
    BPBID_Arrays.BasePetStats[2299] = false
    BPBID_Arrays.BasePetStats[2300] = false
    BPBID_Arrays.BasePetStats[2301] = false
    BPBID_Arrays.BasePetStats[2302] = false
    BPBID_Arrays.BasePetStats[2303] = false
    BPBID_Arrays.BasePetStats[2304] = false
    BPBID_Arrays.BasePetStats[2305] = false
    BPBID_Arrays.BasePetStats[2306] = false
    BPBID_Arrays.BasePetStats[2307] = false
    BPBID_Arrays.BasePetStats[2308] = false
    BPBID_Arrays.BasePetStats[2309] = false
    BPBID_Arrays.BasePetStats[2310] = false
    BPBID_Arrays.BasePetStats[2311] = false
    BPBID_Arrays.BasePetStats[2312] = false
    BPBID_Arrays.BasePetStats[2313] = false
    BPBID_Arrays.BasePetStats[2314] = false
    BPBID_Arrays.BasePetStats[2315] = false
    BPBID_Arrays.BasePetStats[2316] = false
    BPBID_Arrays.BasePetStats[2317] = false
    BPBID_Arrays.BasePetStats[2318] = false
    BPBID_Arrays.BasePetStats[2319] = false
    BPBID_Arrays.BasePetStats[2320] = false
    BPBID_Arrays.BasePetStats[2321] = false
    BPBID_Arrays.BasePetStats[2322] = false
    BPBID_Arrays.BasePetStats[2323] = false
    BPBID_Arrays.BasePetStats[2324] = false
    BPBID_Arrays.BasePetStats[2325] = false
    BPBID_Arrays.BasePetStats[2326] = false
    BPBID_Arrays.BasePetStats[2327] = false
    BPBID_Arrays.BasePetStats[2328] = false
    BPBID_Arrays.BasePetStats[2329] = false
    BPBID_Arrays.BasePetStats[2330] = {9, 6.75, 9}
    BPBID_Arrays.BasePetStats[2331] = false
    BPBID_Arrays.BasePetStats[2332] = {8, 9, 9}
    BPBID_Arrays.BasePetStats[2333] = {9.5, 8, 8}
    BPBID_Arrays.BasePetStats[2334] = {8, 8, 9.5}
    BPBID_Arrays.BasePetStats[2335] = {8, 8.75, 8.75}
    BPBID_Arrays.BasePetStats[2336] = {8, 9.5, 8}
    BPBID_Arrays.BasePetStats[2337] = {18, 8, 8}
    BPBID_Arrays.BasePetStats[2338] = {8, 9.25, 9.25}
    BPBID_Arrays.BasePetStats[2339] = {8, 9.25, 9.25}
    BPBID_Arrays.BasePetStats[2340] = {8, 9.25, 9.25}
    BPBID_Arrays.BasePetStats[2341] = {9.75, 8, 9.25}
    BPBID_Arrays.BasePetStats[2342] = false
    BPBID_Arrays.BasePetStats[2343] = {8, 8.75, 9.25}
    BPBID_Arrays.BasePetStats[2344] = {8.75, 8, 9.25}
    BPBID_Arrays.BasePetStats[2345] = {8.75, 8, 9.25}
    BPBID_Arrays.BasePetStats[2346] = {8.375, 9.25, 8}
    BPBID_Arrays.BasePetStats[2347] = {8, 8.375, 9.25}
    BPBID_Arrays.BasePetStats[2348] = false
    BPBID_Arrays.BasePetStats[2349] = {58, 8, 13}
    BPBID_Arrays.BasePetStats[2350] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2351] = false
    BPBID_Arrays.BasePetStats[2352] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[2353] = {9, 9, 8}
    BPBID_Arrays.BasePetStats[2354] = {10, 8, 8}
    BPBID_Arrays.BasePetStats[2355] = {8, 3, 10.5}
    BPBID_Arrays.BasePetStats[2356] = {18, 8, 8.375}
    BPBID_Arrays.BasePetStats[2357] = {8.375, 8.375, 8.375}
    BPBID_Arrays.BasePetStats[2358] = {8.375, 8.375, 8.375}
    BPBID_Arrays.BasePetStats[2359] = {9.25, 8, 8.375}
    BPBID_Arrays.BasePetStats[2360] = {9.25, 8.75, 8.375}
    BPBID_Arrays.BasePetStats[2361] = {8.75, 8, 8.75}
    BPBID_Arrays.BasePetStats[2362] = false
    BPBID_Arrays.BasePetStats[2363] = {8.5, 8, 9}
    BPBID_Arrays.BasePetStats[2364] = {8, 8.75, 8.375}
    BPBID_Arrays.BasePetStats[2365] = {8.375, 8.75, 8.375}
    BPBID_Arrays.BasePetStats[2366] = {10.5, 8, 8}
    BPBID_Arrays.BasePetStats[2367] = {20.5, 8, 8}
    BPBID_Arrays.BasePetStats[2368] = {8.5, 8, 9.25}
    BPBID_Arrays.BasePetStats[2369] = false
    BPBID_Arrays.BasePetStats[2370] = {8.375, 9.25, 8}
    BPBID_Arrays.BasePetStats[2371] = {8, 8.75, 8.75}
    BPBID_Arrays.BasePetStats[2372] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2373] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2374] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2375] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2376] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[2377] = {8.75, 7.875, 7.375}
    BPBID_Arrays.BasePetStats[2378] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[2379] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[2380] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[2381] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2382] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[2383] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2384] = {7.75, 7.5, 8.75}
    BPBID_Arrays.BasePetStats[2385] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2386] = {8.75, 7.625, 7.625}
    BPBID_Arrays.BasePetStats[2387] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[2388] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[2389] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2390] = {8, 7.25, 8.75}
    BPBID_Arrays.BasePetStats[2391] = false
    BPBID_Arrays.BasePetStats[2392] = {7.625, 7.75, 8.625}
    BPBID_Arrays.BasePetStats[2393] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[2394] = {8.75, 7.625, 7.625}
    BPBID_Arrays.BasePetStats[2395] = {7.5, 8.75, 7.75}
    BPBID_Arrays.BasePetStats[2396] = false
    BPBID_Arrays.BasePetStats[2397] = {8, 7.25, 8.75}
    BPBID_Arrays.BasePetStats[2398] = {7.625, 7.625, 8.75}
    BPBID_Arrays.BasePetStats[2399] = {7.25, 8.375, 8.375}
    BPBID_Arrays.BasePetStats[2400] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2401] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[2402] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[2403] = {7.625, 8.75, 7.625}
    BPBID_Arrays.BasePetStats[2404] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2405] = {8, 8.25, 7.75}
    BPBID_Arrays.BasePetStats[2406] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2407] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[2408] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2409] = {8, 7.25, 8.75}
    BPBID_Arrays.BasePetStats[2410] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[2411] = {8.25, 7.25, 8.5}
    BPBID_Arrays.BasePetStats[2412] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2413] = {7.5, 8.75, 7.75}
    BPBID_Arrays.BasePetStats[2414] = {6.5, 8.75, 8.75}
    BPBID_Arrays.BasePetStats[2415] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2416] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[2417] = {7.25, 8.75, 8}
    BPBID_Arrays.BasePetStats[2418] = {8, 7.25, 8.75}
    BPBID_Arrays.BasePetStats[2419] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2420] = {7.625, 8.75, 7.625}
    BPBID_Arrays.BasePetStats[2421] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2422] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[2423] = {8.375, 8.375, 7.25}
    BPBID_Arrays.BasePetStats[2424] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2425] = {8.75, 7.625, 7.625}
    BPBID_Arrays.BasePetStats[2426] = {8, 7.25, 8.75}
    BPBID_Arrays.BasePetStats[2427] = {8.375, 8.375, 7.25}
    BPBID_Arrays.BasePetStats[2428] = {7.875, 8.25, 7.875}
    BPBID_Arrays.BasePetStats[2429] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[2430] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[2431] = {8, 7.5, 8.5}
    BPBID_Arrays.BasePetStats[2432] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[2433] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2434] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[2435] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[2436] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2437] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2438] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[2439] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[2440] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[2441] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2442] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2443] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[2444] = {8.5, 8.5, 7}
    BPBID_Arrays.BasePetStats[2445] = {8.75, 7.75, 7.5}
    BPBID_Arrays.BasePetStats[2446] = {8.165, 8.165, 7.67}
    BPBID_Arrays.BasePetStats[2447] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2448] = {7.5, 8.125, 8.375}
    BPBID_Arrays.BasePetStats[2449] = {8.375, 8.375, 7.25}
    BPBID_Arrays.BasePetStats[2450] = {8, 7.625, 8.375}
    BPBID_Arrays.BasePetStats[2451] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2452] = {8.125, 7.875, 8}
    BPBID_Arrays.BasePetStats[2453] = {8.625, 8.375, 7}
    BPBID_Arrays.BasePetStats[2454] = {8.625, 8.625, 6.75}
    BPBID_Arrays.BasePetStats[2455] = {7.75, 8.375, 7.875}
    BPBID_Arrays.BasePetStats[2456] = {8.125, 8.125, 7.75}
    BPBID_Arrays.BasePetStats[2457] = {7.75, 7.875, 8.375}
    BPBID_Arrays.BasePetStats[2458] = {8.375, 8, 7.625}
    BPBID_Arrays.BasePetStats[2459] = {8.375, 8, 7.625}
    BPBID_Arrays.BasePetStats[2460] = {7.875, 7.625, 8.5}
    BPBID_Arrays.BasePetStats[2461] = {8.125, 7.75, 8.125}
    BPBID_Arrays.BasePetStats[2462] = {7.75, 8.375, 7.875}
    BPBID_Arrays.BasePetStats[2463] = {7.5, 8.375, 8.125}
    BPBID_Arrays.BasePetStats[2464] = {7.875, 8.25, 7.875}
    BPBID_Arrays.BasePetStats[2465] = {7.875, 8.25, 7.875}
    BPBID_Arrays.BasePetStats[2466] = {7.75, 8.125, 8.125}
    BPBID_Arrays.BasePetStats[2467] = {7.875, 7.875, 8.25}
    BPBID_Arrays.BasePetStats[2468] = {8.25, 7.875, 7.875}
    BPBID_Arrays.BasePetStats[2469] = {7.75, 7.5, 8.75}
    BPBID_Arrays.BasePetStats[2470] = false
    BPBID_Arrays.BasePetStats[2471] = {8, 7.875, 8.125}
    BPBID_Arrays.BasePetStats[2472] = {8.75, 7.625, 7.625}
    BPBID_Arrays.BasePetStats[2473] = {7.875, 8, 8.125}
    BPBID_Arrays.BasePetStats[2474] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2475] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2476] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2477] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2478] = {8.375, 8, 7.625}
    BPBID_Arrays.BasePetStats[2479] = {8.375, 8, 7.625}
    BPBID_Arrays.BasePetStats[2480] = false
    BPBID_Arrays.BasePetStats[2481] = false
    BPBID_Arrays.BasePetStats[2482] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2483] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2484] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2485] = {9.25, 8.375, 8.375}
    BPBID_Arrays.BasePetStats[2486] = {10.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[2487] = {8, 8.375, 9.25}
    BPBID_Arrays.BasePetStats[2488] = {8, 6.25, 8}
    BPBID_Arrays.BasePetStats[2489] = {9, 9.25, 8}
    BPBID_Arrays.BasePetStats[2490] = {12.5, 9.25, 8}
    BPBID_Arrays.BasePetStats[2491] = false
    BPBID_Arrays.BasePetStats[2492] = {8, 8.25, 9.25}
    BPBID_Arrays.BasePetStats[2493] = {10.25, 8, 8.75}
    BPBID_Arrays.BasePetStats[2494] = {9.75, 8, 9.75}
    BPBID_Arrays.BasePetStats[2495] = {21.75, 10.25, 8}
    BPBID_Arrays.BasePetStats[2496] = {8.75, 9.25, 8}
    BPBID_Arrays.BasePetStats[2497] = {5.5, 8, 9.25}
    BPBID_Arrays.BasePetStats[2498] = {5.5, 8, 6.75}
    BPBID_Arrays.BasePetStats[2499] = {5.5, 8, 7}
    BPBID_Arrays.BasePetStats[2500] = {8, 8, 10.5}
    BPBID_Arrays.BasePetStats[2501] = {15.5, 9, 8}
    BPBID_Arrays.BasePetStats[2502] = {9.75, 9.25, 8}
    BPBID_Arrays.BasePetStats[2503] = {8.875, 8.875, 8}
    BPBID_Arrays.BasePetStats[2504] = {11.75, 8, 7}
    BPBID_Arrays.BasePetStats[2505] = false
    BPBID_Arrays.BasePetStats[2506] = false
    BPBID_Arrays.BasePetStats[2507] = false
    BPBID_Arrays.BasePetStats[2508] = false
    BPBID_Arrays.BasePetStats[2509] = false
    BPBID_Arrays.BasePetStats[2510] = false
    BPBID_Arrays.BasePetStats[2511] = false
    BPBID_Arrays.BasePetStats[2512] = false
    BPBID_Arrays.BasePetStats[2513] = false
    BPBID_Arrays.BasePetStats[2514] = false
    BPBID_Arrays.BasePetStats[2515] = false
    BPBID_Arrays.BasePetStats[2516] = false
    BPBID_Arrays.BasePetStats[2517] = false
    BPBID_Arrays.BasePetStats[2518] = false
    BPBID_Arrays.BasePetStats[2519] = false
    BPBID_Arrays.BasePetStats[2520] = false
    BPBID_Arrays.BasePetStats[2521] = false
    BPBID_Arrays.BasePetStats[2522] = false
    BPBID_Arrays.BasePetStats[2523] = false
    BPBID_Arrays.BasePetStats[2524] = false
    BPBID_Arrays.BasePetStats[2525] = {7.5, 8.25, 8.25}
    BPBID_Arrays.BasePetStats[2526] = {8.25, 7.75, 8}
    BPBID_Arrays.BasePetStats[2527] = {7.875, 8.25, 7.875}
    BPBID_Arrays.BasePetStats[2528] = {7.75, 8.125, 8.125}
    BPBID_Arrays.BasePetStats[2529] = {8.375, 7.875, 7.75}
    BPBID_Arrays.BasePetStats[2530] = {7.875, 7.75, 8.375}
    BPBID_Arrays.BasePetStats[2531] = {8.25, 7.625, 8.125}
    BPBID_Arrays.BasePetStats[2532] = {7.75, 8.375, 7.875}
    BPBID_Arrays.BasePetStats[2533] = {8.375, 8.125, 7.5}
    BPBID_Arrays.BasePetStats[2534] = {7.875, 7.875, 8.25}
    BPBID_Arrays.BasePetStats[2535] = {8.125, 8.375, 7.5}
    BPBID_Arrays.BasePetStats[2536] = false
    BPBID_Arrays.BasePetStats[2537] = {7.75, 7.75, 8.5}
    BPBID_Arrays.BasePetStats[2538] = {7.5, 8.375, 8.125}
    BPBID_Arrays.BasePetStats[2539] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[2540] = {7.625, 8.625, 7.75}
    BPBID_Arrays.BasePetStats[2541] = {7.625, 8.625, 7.75}
    BPBID_Arrays.BasePetStats[2542] = false
    BPBID_Arrays.BasePetStats[2543] = false
    BPBID_Arrays.BasePetStats[2544] = {8.375, 8.125, 7.5}
    BPBID_Arrays.BasePetStats[2545] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2546] = {7.625, 8.25, 8.125}
    BPBID_Arrays.BasePetStats[2547] = {8.375, 8.125, 7.5}
    BPBID_Arrays.BasePetStats[2548] = {8.625, 7.75, 7.625}
    BPBID_Arrays.BasePetStats[2549] = {8.125, 8.125, 7.75}
    BPBID_Arrays.BasePetStats[2550] = {7.75, 7.5, 8.75}
    BPBID_Arrays.BasePetStats[2551] = {8, 8.75, 7.25}
    BPBID_Arrays.BasePetStats[2552] = {7.75, 8.75, 7.5}
    BPBID_Arrays.BasePetStats[2553] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2554] = {7.75, 8.625, 7.625}
    BPBID_Arrays.BasePetStats[2555] = {7.625, 8.625, 7.75}
    BPBID_Arrays.BasePetStats[2556] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[2557] = {8.375, 7.625, 8}
    BPBID_Arrays.BasePetStats[2558] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2559] = {7.375, 8.625, 8}
    BPBID_Arrays.BasePetStats[2560] = {7.75, 7.875, 8.375}
    BPBID_Arrays.BasePetStats[2561] = {7.625, 8.875, 7.5}
    BPBID_Arrays.BasePetStats[2562] = {8.625, 7.75, 7.625}
    BPBID_Arrays.BasePetStats[2563] = {8.125, 8.125, 7.75}
    BPBID_Arrays.BasePetStats[2564] = {8.75, 7.625, 7.625}
    BPBID_Arrays.BasePetStats[2565] = {7.625, 7.625, 8.75}
    BPBID_Arrays.BasePetStats[2566] = {8.25, 7.25, 8.5}
    BPBID_Arrays.BasePetStats[2567] = {7.25, 8.25, 8.5}
    BPBID_Arrays.BasePetStats[2568] = {8.5, 7.5, 8}
    BPBID_Arrays.BasePetStats[2569] = {9.5, 7.25, 7.25}
    BPBID_Arrays.BasePetStats[2570] = false
    BPBID_Arrays.BasePetStats[2571] = false
    BPBID_Arrays.BasePetStats[2572] = false
    BPBID_Arrays.BasePetStats[2573] = false
    BPBID_Arrays.BasePetStats[2574] = false
    BPBID_Arrays.BasePetStats[2575] = {7.625, 8.75, 7.625}
    BPBID_Arrays.BasePetStats[2576] = {8.5, 8.75, 6.75}
    BPBID_Arrays.BasePetStats[2577] = {7.25, 7.25, 9.5}
    BPBID_Arrays.BasePetStats[2578] = {8.25, 9, 6.75}
    BPBID_Arrays.BasePetStats[2579] = {7.5, 8.75, 7.75}
    BPBID_Arrays.BasePetStats[2580] = {7.25, 7, 9.75}
    BPBID_Arrays.BasePetStats[2581] = {8.25, 9, 6.75}
    BPBID_Arrays.BasePetStats[2582] = {7.25, 9.75, 7}
    BPBID_Arrays.BasePetStats[2583] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[2584] = {7.75, 7.75, 8.5}
    BPBID_Arrays.BasePetStats[2585] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[2586] = {7.625, 7.625, 8.75}
    BPBID_Arrays.BasePetStats[2587] = {10.5, 6.25, 7.25}
    BPBID_Arrays.BasePetStats[2588] = false
    BPBID_Arrays.BasePetStats[2589] = {8, 9, 7}
    BPBID_Arrays.BasePetStats[2590] = {6.75, 8.625, 8.625}
    BPBID_Arrays.BasePetStats[2591] = {9.125, 8.375, 6.5}
    BPBID_Arrays.BasePetStats[2592] = {8, 9.25, 6.75}
    BPBID_Arrays.BasePetStats[2593] = {8, 6.25, 8}
    BPBID_Arrays.BasePetStats[2594] = {7.25, 8, 8.75}
    BPBID_Arrays.BasePetStats[2595] = {7.125, 8.125, 7.125}
    BPBID_Arrays.BasePetStats[2596] = {8.875, 8.875, 8}
    BPBID_Arrays.BasePetStats[2597] = {9.25, 8.5, 10.5}
    BPBID_Arrays.BasePetStats[2598] = {6.75, 9.25, 9.25}
    BPBID_Arrays.BasePetStats[2599] = {8, 6.25, 8}
    BPBID_Arrays.BasePetStats[2600] = {8, 9.375, 9.375}
    BPBID_Arrays.BasePetStats[2601] = {6.25, 6.75, 8}
    BPBID_Arrays.BasePetStats[2602] = {10.5, 10.5, 8}
    BPBID_Arrays.BasePetStats[2603] = {9.75, 9.75, 10.5}
    BPBID_Arrays.BasePetStats[2604] = false
    BPBID_Arrays.BasePetStats[2605] = {8.75, 8.75, 8.75}
    BPBID_Arrays.BasePetStats[2606] = {8, 9.25, 9.25}
    BPBID_Arrays.BasePetStats[2607] = {8, 9.75, 8}
    BPBID_Arrays.BasePetStats[2608] = {15.5, 9.25, 5.5}
    BPBID_Arrays.BasePetStats[2609] = {6.75, 5.5, 8}
    BPBID_Arrays.BasePetStats[2610] = false
    BPBID_Arrays.BasePetStats[2611] = {9.75, 9.75, 6.25}
    BPBID_Arrays.BasePetStats[2612] = {10.25, 8, 9.125}
    BPBID_Arrays.BasePetStats[2613] = {14.25, 8.75, 8.625}
    BPBID_Arrays.BasePetStats[2614] = false
    BPBID_Arrays.BasePetStats[2615] = false
    BPBID_Arrays.BasePetStats[2616] = false
    BPBID_Arrays.BasePetStats[2617] = false
    BPBID_Arrays.BasePetStats[2618] = false
    BPBID_Arrays.BasePetStats[2619] = false
    BPBID_Arrays.BasePetStats[2620] = false
    BPBID_Arrays.BasePetStats[2621] = {8.25, 8.5, 7.25}
    BPBID_Arrays.BasePetStats[2622] = false
    BPBID_Arrays.BasePetStats[2623] = {7.75, 8.125, 8.125}
    BPBID_Arrays.BasePetStats[2624] = false
    BPBID_Arrays.BasePetStats[2625] = false
    BPBID_Arrays.BasePetStats[2626] = false
    BPBID_Arrays.BasePetStats[2627] = false
    BPBID_Arrays.BasePetStats[2628] = false
    BPBID_Arrays.BasePetStats[2629] = false
    BPBID_Arrays.BasePetStats[2630] = false
    BPBID_Arrays.BasePetStats[2631] = false
    BPBID_Arrays.BasePetStats[2632] = false
    BPBID_Arrays.BasePetStats[2633] = false
    BPBID_Arrays.BasePetStats[2634] = false
    BPBID_Arrays.BasePetStats[2635] = false
    BPBID_Arrays.BasePetStats[2636] = false
    BPBID_Arrays.BasePetStats[2637] = false
    BPBID_Arrays.BasePetStats[2638] = {9.125, 6.25, 8.625}
    BPBID_Arrays.BasePetStats[2639] = false
    BPBID_Arrays.BasePetStats[2640] = false
    BPBID_Arrays.BasePetStats[2641] = false
    BPBID_Arrays.BasePetStats[2642] = false
    BPBID_Arrays.BasePetStats[2643] = false
    BPBID_Arrays.BasePetStats[2644] = false
    BPBID_Arrays.BasePetStats[2645] = {8, 8.1, 7.9}
    BPBID_Arrays.BasePetStats[2646] = {8.15, 8.15, 7.7}
    BPBID_Arrays.BasePetStats[2647] = {8.9, 8, 7.1}
    BPBID_Arrays.BasePetStats[2648] = {7.25, 8.45, 8.3}
    BPBID_Arrays.BasePetStats[2649] = {7.1, 8.7, 8.2}
    BPBID_Arrays.BasePetStats[2650] = {7.775, 7.775, 8.45}
    BPBID_Arrays.BasePetStats[2651] = {7.4, 8.3, 8.3}
    BPBID_Arrays.BasePetStats[2652] = {7.1, 8.45, 8.45}
    BPBID_Arrays.BasePetStats[2653] = {8.6, 8, 7.4}
    BPBID_Arrays.BasePetStats[2654] = false
    BPBID_Arrays.BasePetStats[2655] = false
    BPBID_Arrays.BasePetStats[2656] = false
    BPBID_Arrays.BasePetStats[2657] = {8.9, 8, 7.1}
    BPBID_Arrays.BasePetStats[2658] = {6.5, 8.9, 8.6}
    BPBID_Arrays.BasePetStats[2659] = {8.2, 8, 7.8}
    BPBID_Arrays.BasePetStats[2660] = {8.1, 8, 7.9}
    BPBID_Arrays.BasePetStats[2661] = {8.125, 8, 7.875}
    BPBID_Arrays.BasePetStats[2662] = {7.875, 8, 8.125}
    BPBID_Arrays.BasePetStats[2663] = {7.825, 8, 8.175}
    BPBID_Arrays.BasePetStats[2664] = {9, 8, 7}
    BPBID_Arrays.BasePetStats[2665] = {7.75, 8, 8.25}
    BPBID_Arrays.BasePetStats[2666] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[2667] = {7.9, 8.05, 8.05}
    BPBID_Arrays.BasePetStats[2668] = {7.85, 7.85, 8.3}
    BPBID_Arrays.BasePetStats[2669] = {8.3, 7.7, 8}
    BPBID_Arrays.BasePetStats[2670] = {7.825, 8.175, 8}
    BPBID_Arrays.BasePetStats[2671] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[2672] = {7.6, 8.4, 8}
    BPBID_Arrays.BasePetStats[2673] = {7.8, 8.2, 8}
    BPBID_Arrays.BasePetStats[2674] = {8.5, 7.25, 8.25}
    BPBID_Arrays.BasePetStats[2675] = {8.225, 7.7, 8.075}
    BPBID_Arrays.BasePetStats[2676] = {8.15, 8.15, 7.7}
    BPBID_Arrays.BasePetStats[2677] = {7.55, 8.9, 7.55}
    BPBID_Arrays.BasePetStats[2678] = {7.5, 8.875, 7.625}
    BPBID_Arrays.BasePetStats[2679] = false
    BPBID_Arrays.BasePetStats[2680] = {7.75, 8, 8.25}
    BPBID_Arrays.BasePetStats[2681] = {7.725, 8.275, 8}
    BPBID_Arrays.BasePetStats[2682] = {7.25, 7.875, 8.875}
    BPBID_Arrays.BasePetStats[2683] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[2684] = {8.875, 7.625, 7.5}
    BPBID_Arrays.BasePetStats[2685] = {7.8, 8.1, 8.1}
    BPBID_Arrays.BasePetStats[2686] = {8.375, 8, 7.625}
    BPBID_Arrays.BasePetStats[2687] = {8.875, 8, 7.125}
    BPBID_Arrays.BasePetStats[2688] = {8.6, 8, 7.4}
    BPBID_Arrays.BasePetStats[2689] = {7.5, 8.83, 7.67}
    BPBID_Arrays.BasePetStats[2690] = {7.505, 8.33, 8.165}
    BPBID_Arrays.BasePetStats[2691] = {7.325, 8.175, 8.5}
    BPBID_Arrays.BasePetStats[2692] = {8.075, 8.325, 7.6}
    BPBID_Arrays.BasePetStats[2693] = {8.15, 7.925, 7.925}
    BPBID_Arrays.BasePetStats[2694] = {7.5, 8.375, 8.125}
    BPBID_Arrays.BasePetStats[2695] = {7.55, 8.3, 8.15}
    BPBID_Arrays.BasePetStats[2696] = {8.165, 8.165, 7.67}
    BPBID_Arrays.BasePetStats[2697] = {8.275, 8.175, 7.55}
    BPBID_Arrays.BasePetStats[2698] = {8.25, 8.125, 7.625}
    BPBID_Arrays.BasePetStats[2699] = {8.15, 8.05, 7.8}
    BPBID_Arrays.BasePetStats[2700] = {7.85, 7.95, 8.2}
    BPBID_Arrays.BasePetStats[2701] = {8.325, 8.175, 7.5}
    BPBID_Arrays.BasePetStats[2702] = {8.075, 8.325, 7.6}
    BPBID_Arrays.BasePetStats[2703] = {9.125, 8.125, 6.75}
    BPBID_Arrays.BasePetStats[2704] = {8, 8.875, 7.125}
    BPBID_Arrays.BasePetStats[2705] = false
    BPBID_Arrays.BasePetStats[2706] = {8.675, 8, 7.325}
    BPBID_Arrays.BasePetStats[2707] = {8.425, 8, 7.575}
    BPBID_Arrays.BasePetStats[2708] = {7.875, 8.325, 7.8}
    BPBID_Arrays.BasePetStats[2709] = {7.8, 8.1, 8.1}
    BPBID_Arrays.BasePetStats[2710] = {6.75, 8, 9.25}
    BPBID_Arrays.BasePetStats[2711] = {8.15, 8, 7.85}
    BPBID_Arrays.BasePetStats[2712] = {7.85, 8, 8.15}
    BPBID_Arrays.BasePetStats[2713] = {8.075, 8, 7.925}
    BPBID_Arrays.BasePetStats[2714] = {8.05, 8.05, 7.9}
    BPBID_Arrays.BasePetStats[2715] = {7.625, 8.25, 8.125}
    BPBID_Arrays.BasePetStats[2716] = {8.25, 8.25, 7.5}
    BPBID_Arrays.BasePetStats[2717] = {8.45, 7.925, 7.625}
    BPBID_Arrays.BasePetStats[2718] = {8.6, 7.85, 7.55}
    BPBID_Arrays.BasePetStats[2719] = {8.175, 8.275, 7.55}
    BPBID_Arrays.BasePetStats[2720] = {7.125, 8.375, 8.5}
    BPBID_Arrays.BasePetStats[2721] = {7.625, 8.875, 7.5}
    BPBID_Arrays.BasePetStats[2722] = false
    BPBID_Arrays.BasePetStats[2723] = {9.75, 10.5, 8.5}
    BPBID_Arrays.BasePetStats[2724] = {10.75, 13.5, 8.75}
    BPBID_Arrays.BasePetStats[2725] = {10, 13.5, 7}
    BPBID_Arrays.BasePetStats[2726] = {10.5, 12.5, 6.75}
    BPBID_Arrays.BasePetStats[2727] = {11, 13, 9}
    BPBID_Arrays.BasePetStats[2728] = {10, 13.5, 9}
    BPBID_Arrays.BasePetStats[2729] = {11, 14, 8}
    BPBID_Arrays.BasePetStats[2730] = {11, 13.5, 8.1}
    BPBID_Arrays.BasePetStats[2731] = {11.5, 13.5, 9.5}
    BPBID_Arrays.BasePetStats[2732] = {10.75, 13, 8.625}
    BPBID_Arrays.BasePetStats[2733] = {10.5, 14, 6.5}
    BPBID_Arrays.BasePetStats[2734] = {10.75, 14, 9.25}
    BPBID_Arrays.BasePetStats[2735] = {10, 13, 8}
    BPBID_Arrays.BasePetStats[2736] = {10.75, 13.5, 6}
    BPBID_Arrays.BasePetStats[2737] = {11, 13, 7.25}
    BPBID_Arrays.BasePetStats[2738] = {11, 13.5, 7.75}
    BPBID_Arrays.BasePetStats[2739] = {11, 13.5, 7.5}
    BPBID_Arrays.BasePetStats[2740] = {10.5, 13.5, 5.75}
    BPBID_Arrays.BasePetStats[2741] = {10, 14, 6.25}
    BPBID_Arrays.BasePetStats[2742] = {10, 14, 5.5}
    BPBID_Arrays.BasePetStats[2743] = false
    BPBID_Arrays.BasePetStats[2744] = false
    BPBID_Arrays.BasePetStats[2745] = false
    BPBID_Arrays.BasePetStats[2746] = false
    BPBID_Arrays.BasePetStats[2747] = {9.125, 8.375, 6.5}
    BPBID_Arrays.BasePetStats[2748] = {6.75, 7.5, 9.75}
    BPBID_Arrays.BasePetStats[2749] = {6.75, 8.75, 8.5}
    BPBID_Arrays.BasePetStats[2750] = {6.375, 9.125, 8.5}
    BPBID_Arrays.BasePetStats[2751] = {8.75, 8.75, 8.75}
    BPBID_Arrays.BasePetStats[2752] = {8.75, 8.75, 8.75}
    BPBID_Arrays.BasePetStats[2753] = {7.625, 8.25, 8.125}
    BPBID_Arrays.BasePetStats[2754] = {7.125, 8.25, 8.625}
    BPBID_Arrays.BasePetStats[2755] = {8.375, 8.25, 7.375}
    BPBID_Arrays.BasePetStats[2756] = {9.125, 7.5, 7.375}
    BPBID_Arrays.BasePetStats[2757] = {7.125, 8.375, 8.5}
    BPBID_Arrays.BasePetStats[2758] = {7.125, 9.175, 7.7}
    BPBID_Arrays.BasePetStats[2759] = false
    BPBID_Arrays.BasePetStats[2760] = {7.125, 9.175, 7.7}
    BPBID_Arrays.BasePetStats[2761] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[2762] = {9.625, 7.125, 7.25}
    BPBID_Arrays.BasePetStats[2763] = {8.25, 8.125, 7.625}
    BPBID_Arrays.BasePetStats[2764] = false
    BPBID_Arrays.BasePetStats[2765] = {7.75, 8.625, 7.625}
    BPBID_Arrays.BasePetStats[2766] = {10.25, 6.875, 6.875}
    BPBID_Arrays.BasePetStats[2767] = {7.325, 8.45, 8.225}
    BPBID_Arrays.BasePetStats[2768] = {5.725, 7, 7}
    BPBID_Arrays.BasePetStats[2769] = {5.25, 6.25, 6.75}
    BPBID_Arrays.BasePetStats[2770] = {9.25, 6.5, 6.5}
    BPBID_Arrays.BasePetStats[2771] = {8, 8.375, 8}
    BPBID_Arrays.BasePetStats[2772] = {11.25, 5.75, 6.875}
    BPBID_Arrays.BasePetStats[2773] = false
    BPBID_Arrays.BasePetStats[2774] = {8, 8, 7}
    BPBID_Arrays.BasePetStats[2775] = false
    BPBID_Arrays.BasePetStats[2776] = {8.15, 7.575, 8.275}
    BPBID_Arrays.BasePetStats[2777] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[2778] = {8.375, 8, 7.625}
    BPBID_Arrays.BasePetStats[2779] = {7.25, 9.25, 7.5}
    BPBID_Arrays.BasePetStats[2780] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2781] = false
    BPBID_Arrays.BasePetStats[2782] = false
    BPBID_Arrays.BasePetStats[2783] = false
    BPBID_Arrays.BasePetStats[2784] = false
    BPBID_Arrays.BasePetStats[2785] = false
    BPBID_Arrays.BasePetStats[2786] = false
    BPBID_Arrays.BasePetStats[2787] = false
    BPBID_Arrays.BasePetStats[2788] = false
    BPBID_Arrays.BasePetStats[2789] = false
    BPBID_Arrays.BasePetStats[2790] = false
    BPBID_Arrays.BasePetStats[2791] = false
    BPBID_Arrays.BasePetStats[2792] = {8.725, 8.275, 7}
    BPBID_Arrays.BasePetStats[2793] = {7.25, 8.25, 8.5}
    BPBID_Arrays.BasePetStats[2794] = {7.25, 9, 7.75}
    BPBID_Arrays.BasePetStats[2795] = {7.825, 8.675, 7.5}
    BPBID_Arrays.BasePetStats[2796] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[2797] = {7.75, 8.25, 8}
    BPBID_Arrays.BasePetStats[2798] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2799] = {8, 7.25, 8}
    BPBID_Arrays.BasePetStats[2800] = {8.375, 7.25, 8.125}
    BPBID_Arrays.BasePetStats[2801] = {7.375, 8, 8}
    BPBID_Arrays.BasePetStats[2802] = {10, 8, 8.625}
    BPBID_Arrays.BasePetStats[2803] = {9.75, 6.25, 8.875}
    BPBID_Arrays.BasePetStats[2804] = {8, 6.75, 8.75}
    BPBID_Arrays.BasePetStats[2805] = {8.375, 6.25, 7.25}
    BPBID_Arrays.BasePetStats[2806] = {8.625, 6.25, 8.625}
    BPBID_Arrays.BasePetStats[2807] = {8.375, 6.75, 7}
    BPBID_Arrays.BasePetStats[2808] = {8.75, 8, 6.75}
    BPBID_Arrays.BasePetStats[2809] = {8.375, 7.6, 5.5}
    BPBID_Arrays.BasePetStats[2810] = {7.25, 8.875, 9}
    BPBID_Arrays.BasePetStats[2811] = {10, 7.625, 8.75}
    BPBID_Arrays.BasePetStats[2812] = {9.875, 8, 8.375}
    BPBID_Arrays.BasePetStats[2813] = false
    BPBID_Arrays.BasePetStats[2814] = {70.5, 8.75, 5.5}
    BPBID_Arrays.BasePetStats[2815] = {13, 9.75, 9.25}
    BPBID_Arrays.BasePetStats[2816] = {13, 8, 9.25}
    BPBID_Arrays.BasePetStats[2817] = {13, 8, 9.25}
    BPBID_Arrays.BasePetStats[2818] = {13, 8, 9.25}
    BPBID_Arrays.BasePetStats[2819] = {13, 9.5, 9.25}
    BPBID_Arrays.BasePetStats[2820] = {13, 10.25, 9.25}
    BPBID_Arrays.BasePetStats[2821] = {13, 9.125, 9.25}
    BPBID_Arrays.BasePetStats[2822] = {12.5, 10.25, 9.25}
    BPBID_Arrays.BasePetStats[2823] = {13, 9.75, 9.25}
    BPBID_Arrays.BasePetStats[2824] = false
    BPBID_Arrays.BasePetStats[2825] = false
    BPBID_Arrays.BasePetStats[2826] = false
    BPBID_Arrays.BasePetStats[2827] = false
    BPBID_Arrays.BasePetStats[2828] = false
    BPBID_Arrays.BasePetStats[2829] = false
    BPBID_Arrays.BasePetStats[2830] = false
    BPBID_Arrays.BasePetStats[2831] = false
    BPBID_Arrays.BasePetStats[2832] = {8.725, 8.775, 6.5}
    BPBID_Arrays.BasePetStats[2833] = {7.875, 8.675, 7.45}
    BPBID_Arrays.BasePetStats[2834] = {8.575, 8.425, 7}
    BPBID_Arrays.BasePetStats[2835] = {8.575, 7.575, 7.85}
    BPBID_Arrays.BasePetStats[2836] = {7.25, 8.925, 7.825}
    BPBID_Arrays.BasePetStats[2837] = {7.25, 8.925, 7.825}
    BPBID_Arrays.BasePetStats[2838] = {9.725, 8.275, 6}
    BPBID_Arrays.BasePetStats[2839] = {7.225, 9.775, 7}
    BPBID_Arrays.BasePetStats[2840] = {8.75, 7.375, 7.875}
    BPBID_Arrays.BasePetStats[2841] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2842] = {5.75, 9.125, 9.125}
    BPBID_Arrays.BasePetStats[2843] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[2844] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[2845] = {6.875, 9.125, 8}
    BPBID_Arrays.BasePetStats[2846] = {7.5, 8.575, 7.925}
    BPBID_Arrays.BasePetStats[2847] = {7.5, 8.575, 7.925}
    BPBID_Arrays.BasePetStats[2848] = {7.125, 9.625, 7.25}
    BPBID_Arrays.BasePetStats[2849] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[2850] = {5.75, 9.125, 9.125}
    BPBID_Arrays.BasePetStats[2851] = {8, 9.125, 6.875}
    BPBID_Arrays.BasePetStats[2852] = {10.275, 7, 6.725}
    BPBID_Arrays.BasePetStats[2853] = {6.75, 8.625, 8.625}
    BPBID_Arrays.BasePetStats[2854] = {19.25, 9.75, 9.75}
    BPBID_Arrays.BasePetStats[2855] = {17.75, 13.75, 5.25}
    BPBID_Arrays.BasePetStats[2856] = {16.75, 12.25, 10.75}
    BPBID_Arrays.BasePetStats[2857] = {20.25, 9.25, 8}
    BPBID_Arrays.BasePetStats[2858] = {16.25, 10.75, 8}
    BPBID_Arrays.BasePetStats[2859] = {15.75, 13.75, 3.75}
    BPBID_Arrays.BasePetStats[2860] = {15, 10.25, 9.25}
    BPBID_Arrays.BasePetStats[2861] = {21.25, 13.25, 8}
    BPBID_Arrays.BasePetStats[2862] = false
    BPBID_Arrays.BasePetStats[2863] = {7.375, 9.125, 7.5}
    BPBID_Arrays.BasePetStats[2864] = {6.75, 9.625, 7.625}
    BPBID_Arrays.BasePetStats[2865] = {6.75, 8.625, 8.625}
    BPBID_Arrays.BasePetStats[2866] = {6.75, 8.625, 8.625}
    BPBID_Arrays.BasePetStats[2867] = {6.75, 9.125, 8.125}
    BPBID_Arrays.BasePetStats[2868] = {9.125, 8.375, 6.5}
    BPBID_Arrays.BasePetStats[2869] = {6.75, 8.275, 8.975}
    BPBID_Arrays.BasePetStats[2870] = {6.75, 9.125, 8.125}
    BPBID_Arrays.BasePetStats[2871] = {108, 8, 8}
    BPBID_Arrays.BasePetStats[2872] = {8.575, 8.325, 7.1}
    BPBID_Arrays.BasePetStats[2873] = false
    BPBID_Arrays.BasePetStats[2874] = false
    BPBID_Arrays.BasePetStats[2875] = false
    BPBID_Arrays.BasePetStats[2876] = false
    BPBID_Arrays.BasePetStats[2877] = false
    BPBID_Arrays.BasePetStats[2878] = {7.375, 8.25, 8.375}
    BPBID_Arrays.BasePetStats[2879] = false
    BPBID_Arrays.BasePetStats[2880] = false
    BPBID_Arrays.BasePetStats[2881] = false
    BPBID_Arrays.BasePetStats[2882] = false
    BPBID_Arrays.BasePetStats[2883] = false
    BPBID_Arrays.BasePetStats[2884] = false
    BPBID_Arrays.BasePetStats[2885] = {7.5, 9, 7.5}
    BPBID_Arrays.BasePetStats[2886] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[2887] = {7.5, 7.5, 9}
    BPBID_Arrays.BasePetStats[2888] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[2889] = {8.5, 8.25, 7.25}
    BPBID_Arrays.BasePetStats[2890] = false
    BPBID_Arrays.BasePetStats[2891] = {7.5, 8.175, 8.325}
    BPBID_Arrays.BasePetStats[2892] = {8, 9, 7}
    BPBID_Arrays.BasePetStats[2893] = {7.5, 8.75, 7.75}
    BPBID_Arrays.BasePetStats[2894] = {7.75, 8.875, 7.375}
    BPBID_Arrays.BasePetStats[2895] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[2896] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[2897] = {7.675, 8.65, 7.675}
    BPBID_Arrays.BasePetStats[2898] = {8, 8.325, 7.675}
    BPBID_Arrays.BasePetStats[2899] = {7.625, 7.75, 8.625}
    BPBID_Arrays.BasePetStats[2900] = {7.625, 7.75, 8.625}
    BPBID_Arrays.BasePetStats[2901] = {7.625, 7.75, 8.625}
    BPBID_Arrays.BasePetStats[2902] = {7.55, 8.175, 8.275}
    BPBID_Arrays.BasePetStats[2903] = {7.55, 8.175, 8.275}
    BPBID_Arrays.BasePetStats[2904] = {7.55, 8.175, 8.275}
    BPBID_Arrays.BasePetStats[2905] = {7.375, 8.25, 8.375}
    BPBID_Arrays.BasePetStats[2906] = false
    BPBID_Arrays.BasePetStats[2907] = {7.375, 8.25, 8.375}
    BPBID_Arrays.BasePetStats[2908] = {7.925, 8.15, 7.925}
    BPBID_Arrays.BasePetStats[2909] = {7.925, 8.15, 7.925}
    BPBID_Arrays.BasePetStats[2910] = {7.675, 7.825, 8.5}
    BPBID_Arrays.BasePetStats[2911] = {7.675, 7.825, 8.5}
    BPBID_Arrays.BasePetStats[2912] = {7.675, 7.825, 8.5}
    BPBID_Arrays.BasePetStats[2913] = {7.675, 7.825, 8.5}
    BPBID_Arrays.BasePetStats[2914] = {7.425, 7.825, 8.75}
    BPBID_Arrays.BasePetStats[2915] = {7.425, 7.825, 8.75}
    BPBID_Arrays.BasePetStats[2916] = {7.85, 8.075, 8.075}
    BPBID_Arrays.BasePetStats[2917] = {7.85, 8.075, 8.075}
    BPBID_Arrays.BasePetStats[2918] = {7.85, 8.075, 8.075}
    BPBID_Arrays.BasePetStats[2919] = {7.5, 8.375, 8.125}
    BPBID_Arrays.BasePetStats[2920] = {7.5, 8.375, 8.125}
    BPBID_Arrays.BasePetStats[2921] = {7.5, 8.375, 8.125}
    BPBID_Arrays.BasePetStats[2922] = {7.425, 7.825, 8.75}
    BPBID_Arrays.BasePetStats[2923] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[2924] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[2925] = {7.925, 8.15, 7.925}
    BPBID_Arrays.BasePetStats[2926] = {7.925, 8.15, 7.925}
    BPBID_Arrays.BasePetStats[2927] = {7.625, 7.625, 8.75}
    BPBID_Arrays.BasePetStats[2928] = {7.625, 7.625, 8.75}
    BPBID_Arrays.BasePetStats[2929] = {7.625, 7.625, 8.75}
    BPBID_Arrays.BasePetStats[2930] = {9.25, 7.75, 7}
    BPBID_Arrays.BasePetStats[2931] = {9.25, 7.75, 7}
    BPBID_Arrays.BasePetStats[2932] = {9.25, 7.75, 7}
    BPBID_Arrays.BasePetStats[2933] = {7.375, 8.25, 8.375}
    BPBID_Arrays.BasePetStats[2934] = {7.375, 8.25, 8.375}
    BPBID_Arrays.BasePetStats[2935] = {7.375, 8.25, 8.375}
    BPBID_Arrays.BasePetStats[2936] = {7.375, 8.25, 8.375}
    BPBID_Arrays.BasePetStats[2937] = {7.375, 8.25, 8.375}
    BPBID_Arrays.BasePetStats[2938] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[2939] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[2940] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[2941] = {7.425, 7.825, 8.75}
    BPBID_Arrays.BasePetStats[2942] = {7.425, 7.825, 8.75}
    BPBID_Arrays.BasePetStats[2943] = {7.5, 8.325, 8.175}
    BPBID_Arrays.BasePetStats[2944] = {8, 8.75, 7.25}
    BPBID_Arrays.BasePetStats[2945] = {8.375, 8, 7.625}
    BPBID_Arrays.BasePetStats[2946] = {8.375, 8, 7.625}
    BPBID_Arrays.BasePetStats[2947] = {7.5, 8.175, 8.325}
    BPBID_Arrays.BasePetStats[2948] = {7.5, 8.175, 8.325}
    BPBID_Arrays.BasePetStats[2949] = {7.5, 8.175, 8.325}
    BPBID_Arrays.BasePetStats[2950] = {8, 8.375, 7.625}
    BPBID_Arrays.BasePetStats[2951] = false
    BPBID_Arrays.BasePetStats[2952] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2953] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2954] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[2955] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[2956] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[2957] = {8, 7.625, 8.375}
    BPBID_Arrays.BasePetStats[2958] = {8, 7.625, 8.375}
    BPBID_Arrays.BasePetStats[2959] = {7.75, 8.75, 7.5}
    BPBID_Arrays.BasePetStats[2960] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[2961] = {8, 8.75, 7.25}
    BPBID_Arrays.BasePetStats[2962] = {8.625, 8.375, 7}
    BPBID_Arrays.BasePetStats[2963] = {8.625, 8.375, 7}
    BPBID_Arrays.BasePetStats[2964] = {7.5, 8.375, 8.125}
    BPBID_Arrays.BasePetStats[2965] = {7.5, 8.175, 8.325}
    BPBID_Arrays.BasePetStats[2966] = {8.625, 8, 7.375}
    BPBID_Arrays.BasePetStats[2967] = {8.5, 8.25, 7.25}
    BPBID_Arrays.BasePetStats[2968] = {15.5, 6.875, 4.25}
    BPBID_Arrays.BasePetStats[2969] = {10.25, 6.875, 11.75}
    BPBID_Arrays.BasePetStats[2970] = {10.25, 10.75, 6.75}
    BPBID_Arrays.BasePetStats[2971] = {11.25, 8.75, 6.75}
    BPBID_Arrays.BasePetStats[2972] = {9.75, 8, 6.75}
    BPBID_Arrays.BasePetStats[2973] = {6.75, 10.5, 10.25}
    BPBID_Arrays.BasePetStats[2974] = {10.25, 9.75, 8}
    BPBID_Arrays.BasePetStats[2975] = {12.25, 9.75, 6.75}
    BPBID_Arrays.BasePetStats[2976] = {8, 8, 10.5}
    BPBID_Arrays.BasePetStats[2977] = {12.25, 11, 6.75}
    BPBID_Arrays.BasePetStats[2978] = {24.25, 13, 6.75}
    BPBID_Arrays.BasePetStats[2979] = {19.75, 13, 11.25}
    BPBID_Arrays.BasePetStats[2980] = {11.625, 9, 8}
    BPBID_Arrays.BasePetStats[2981] = {14.25, 14.25, 6.75}
    BPBID_Arrays.BasePetStats[2982] = {11.5, 11, 14}
    BPBID_Arrays.BasePetStats[2983] = {9.125, 9.75, 8.875}
    BPBID_Arrays.BasePetStats[2984] = {12.975, 11.75, 8}
    BPBID_Arrays.BasePetStats[2985] = {9.75, 13.75, 6.75}
    BPBID_Arrays.BasePetStats[2986] = {11, 11, 6.75}
    BPBID_Arrays.BasePetStats[2987] = {10.5, 11, 11.5}
    BPBID_Arrays.BasePetStats[2988] = {9.125, 8.5, 9.5}
    BPBID_Arrays.BasePetStats[2989] = {11.25, 9.125, 8}
    BPBID_Arrays.BasePetStats[2990] = {9.75, 9.75, 9.75}
    BPBID_Arrays.BasePetStats[2991] = {8, 12.9, 6.75}
    BPBID_Arrays.BasePetStats[2992] = {11, 9.25, 9.75}
    BPBID_Arrays.BasePetStats[2993] = {11.885, 8.625, 10.25}
    BPBID_Arrays.BasePetStats[2994] = {14.25, 9.75, 6.75}
    BPBID_Arrays.BasePetStats[2995] = false
    BPBID_Arrays.BasePetStats[2996] = {18, 8, 6.75}
    BPBID_Arrays.BasePetStats[2997] = false
    BPBID_Arrays.BasePetStats[2998] = {18, 10.5, 9.665}
    BPBID_Arrays.BasePetStats[2999] = {20.5, 8.875, 10.5}
    BPBID_Arrays.BasePetStats[3000] = {9.75, 11, 11.75}
    BPBID_Arrays.BasePetStats[3001] = {12, 9.75, 10.5}
    BPBID_Arrays.BasePetStats[3002] = {11.25, 9.125, 9.75}
    BPBID_Arrays.BasePetStats[3003] = {10.5, 10.25, 9.25}
    BPBID_Arrays.BasePetStats[3004] = {9.665, 9.11, 10.22}
    BPBID_Arrays.BasePetStats[3005] = {11.885, 11.885, 11.885}
    BPBID_Arrays.BasePetStats[3006] = {7.55, 8.175, 8.275}
    BPBID_Arrays.BasePetStats[3007] = {7.5, 8.175, 8.325}
    BPBID_Arrays.BasePetStats[3008] = {7.25, 7.5, 9.25}
    BPBID_Arrays.BasePetStats[3009] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[3010] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[3011] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[3012] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[3013] = {7.625, 8.375, 8}
    BPBID_Arrays.BasePetStats[3014] = {8.625, 8.25, 7.125}
    BPBID_Arrays.BasePetStats[3015] = {8.625, 8.25, 7.125}
    BPBID_Arrays.BasePetStats[3016] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[3017] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[3018] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[3019] = {8.75, 8, 7.25}
    BPBID_Arrays.BasePetStats[3020] = {7.425, 7.825, 8.75}
    BPBID_Arrays.BasePetStats[3021] = {7.425, 7.825, 8.75}
    BPBID_Arrays.BasePetStats[3022] = {7.425, 7.825, 8.75}
    BPBID_Arrays.BasePetStats[3023] = {7.425, 7.825, 8.75}
    BPBID_Arrays.BasePetStats[3024] = {8.625, 8.375, 7}
    BPBID_Arrays.BasePetStats[3025] = {8, 8.375, 7.625}
    BPBID_Arrays.BasePetStats[3026] = {9, 7.75, 7.25}
    BPBID_Arrays.BasePetStats[3027] = {9, 7.75, 7.25}
    BPBID_Arrays.BasePetStats[3028] = {7.25, 8.25, 8.5}
    BPBID_Arrays.BasePetStats[3029] = {7.25, 8.25, 8.5}
    BPBID_Arrays.BasePetStats[3030] = {7.675, 8.5, 7.825}
    BPBID_Arrays.BasePetStats[3031] = false
    BPBID_Arrays.BasePetStats[3032] = {7.675, 8.5, 7.825}
    BPBID_Arrays.BasePetStats[3033] = {8.375, 8.375, 7.25}
    BPBID_Arrays.BasePetStats[3034] = {7.325, 8.675, 8}
    BPBID_Arrays.BasePetStats[3035] = {7.85, 8.075, 8.075}
    BPBID_Arrays.BasePetStats[3036] = {7.375, 9.125, 7.5}
    BPBID_Arrays.BasePetStats[3037] = {8.325, 8.325, 7.35}
    BPBID_Arrays.BasePetStats[3038] = {9, 7.75, 7.25}
    BPBID_Arrays.BasePetStats[3039] = {7.675, 8.5, 7.825}
    BPBID_Arrays.BasePetStats[3040] = {7.25, 8.25, 8.5}
    BPBID_Arrays.BasePetStats[3041] = {9.11, 8.555, 6.335}
    BPBID_Arrays.BasePetStats[3042] = {8.5, 8.375, 7.125}
    BPBID_Arrays.BasePetStats[3043] = {7.025, 8.475, 8.5}
    BPBID_Arrays.BasePetStats[3044] = {7.85, 8.075, 8.075}
    BPBID_Arrays.BasePetStats[3045] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[3046] = {7.2, 8.275, 8.525}
    BPBID_Arrays.BasePetStats[3047] = {8, 7.625, 8.375}
    BPBID_Arrays.BasePetStats[3048] = false
    BPBID_Arrays.BasePetStats[3049] = {7.75, 8, 8.25}
    BPBID_Arrays.BasePetStats[3050] = {7.5, 8.175, 8.325}
    BPBID_Arrays.BasePetStats[3051] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[3052] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3053] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3054] = {7.25, 7.5, 9.25}
    BPBID_Arrays.BasePetStats[3055] = false
    BPBID_Arrays.BasePetStats[3056] = false
    BPBID_Arrays.BasePetStats[3057] = false
    BPBID_Arrays.BasePetStats[3058] = false
    BPBID_Arrays.BasePetStats[3059] = false
    BPBID_Arrays.BasePetStats[3060] = false
    BPBID_Arrays.BasePetStats[3061] = {8.5, 8.375, 7.125}
    BPBID_Arrays.BasePetStats[3062] = {8.5, 8.375, 7.125}
    BPBID_Arrays.BasePetStats[3063] = {7.825, 8.675, 7.5}
    BPBID_Arrays.BasePetStats[3064] = {7.825, 8.675, 7.5}
    BPBID_Arrays.BasePetStats[3065] = {7.825, 8.675, 7.5}
    BPBID_Arrays.BasePetStats[3066] = {7.8, 8.1, 8.1}
    BPBID_Arrays.BasePetStats[3067] = {7.25, 8.375, 8.375}
    BPBID_Arrays.BasePetStats[3068] = {13, 10.5, 5.5}
    BPBID_Arrays.BasePetStats[3069] = false
    BPBID_Arrays.BasePetStats[3070] = {12, 12, 8}
    BPBID_Arrays.BasePetStats[3071] = {12.5, 11.5, 7.5}
    BPBID_Arrays.BasePetStats[3072] = {14.5, 11, 8}
    BPBID_Arrays.BasePetStats[3073] = {13, 12, 7.75}
    BPBID_Arrays.BasePetStats[3074] = {12, 13, 8.25}
    BPBID_Arrays.BasePetStats[3075] = {14, 11.5, 8.5}
    BPBID_Arrays.BasePetStats[3076] = {15, 14, 6.5}
    BPBID_Arrays.BasePetStats[3077] = {13.5, 13.5, 9}
    BPBID_Arrays.BasePetStats[3078] = {15.5, 13, 7}
    BPBID_Arrays.BasePetStats[3079] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[3080] = {7.375, 8.25, 8.375}
    BPBID_Arrays.BasePetStats[3081] = {7.85, 8.075, 8.075}
    BPBID_Arrays.BasePetStats[3082] = {7.675, 7.825, 8.5}
    BPBID_Arrays.BasePetStats[3083] = {6.75, 8.625, 8.625}
    BPBID_Arrays.BasePetStats[3084] = false
    BPBID_Arrays.BasePetStats[3085] = false
    BPBID_Arrays.BasePetStats[3086] = false
    BPBID_Arrays.BasePetStats[3087] = false
    BPBID_Arrays.BasePetStats[3088] = false
    BPBID_Arrays.BasePetStats[3089] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3090] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3091] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3092] = {7.25, 7.75, 9}
    BPBID_Arrays.BasePetStats[3093] = false
    BPBID_Arrays.BasePetStats[3094] = false
    BPBID_Arrays.BasePetStats[3095] = false
    BPBID_Arrays.BasePetStats[3096] = false
    BPBID_Arrays.BasePetStats[3097] = {8.75, 7.625, 7.625}
    BPBID_Arrays.BasePetStats[3098] = {8.625, 8.375, 7}
    BPBID_Arrays.BasePetStats[3099] = {7.5, 8.325, 8.175}
    BPBID_Arrays.BasePetStats[3100] = {8.25, 8.65, 7.1}
    BPBID_Arrays.BasePetStats[3101] = {7.375, 8.25, 8.375}
    BPBID_Arrays.BasePetStats[3102] = {7.425, 7.825, 8.75}
    BPBID_Arrays.BasePetStats[3103] = {7.5, 8.325, 8.175}
    BPBID_Arrays.BasePetStats[3104] = {8.75, 7.625, 7.625}
    BPBID_Arrays.BasePetStats[3105] = {8.75, 8, 7.625}
    BPBID_Arrays.BasePetStats[3106] = {6.335, 9.11, 8.555}
    BPBID_Arrays.BasePetStats[3107] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3108] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[3109] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[3110] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[3111] = {7.1, 8.275, 8.625}
    BPBID_Arrays.BasePetStats[3112] = {7.1, 8.275, 8.625}
    BPBID_Arrays.BasePetStats[3113] = {7.1, 8.275, 8.625}
    BPBID_Arrays.BasePetStats[3114] = {8.625, 8.375, 7}
    BPBID_Arrays.BasePetStats[3115] = {8, 8.375, 7.625}
    BPBID_Arrays.BasePetStats[3116] = {7.5, 8.375, 8.125}
    BPBID_Arrays.BasePetStats[3117] = {7.5, 8.375, 8.125}
    BPBID_Arrays.BasePetStats[3118] = {7.675, 8.5, 7.825}
    BPBID_Arrays.BasePetStats[3119] = {7.25, 8.25, 8.5}
    BPBID_Arrays.BasePetStats[3120] = {8.375, 8.125, 7.5}
    BPBID_Arrays.BasePetStats[3121] = {8.375, 8.125, 7.5}
    BPBID_Arrays.BasePetStats[3122] = {8.375, 8.125, 7.5}
    BPBID_Arrays.BasePetStats[3123] = {9, 7.75, 7.25}
    BPBID_Arrays.BasePetStats[3124] = {9, 7.75, 7.25}
    BPBID_Arrays.BasePetStats[3125] = {8.375, 8.375, 7.25}
    BPBID_Arrays.BasePetStats[3126] = {8.375, 8.375, 7.25}
    BPBID_Arrays.BasePetStats[3127] = {8, 8.625, 8.625}
    BPBID_Arrays.BasePetStats[3128] = {8.25, 8.5, 7.25}
    BPBID_Arrays.BasePetStats[3129] = {7.875, 8.875, 7.25}
    BPBID_Arrays.BasePetStats[3130] = {8.75, 8.25, 7}
    BPBID_Arrays.BasePetStats[3131] = {8.75, 8.25, 7}
    BPBID_Arrays.BasePetStats[3132] = {8.75, 8.25, 7}
    BPBID_Arrays.BasePetStats[3133] = {8.75, 8.25, 7}
    BPBID_Arrays.BasePetStats[3134] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[3135] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[3136] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[3137] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[3138] = {7.625, 8, 8.375}
    BPBID_Arrays.BasePetStats[3139] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[3140] = {8.25, 8, 7.75}
    BPBID_Arrays.BasePetStats[3141] = {7.25, 7.5, 9.25}
    BPBID_Arrays.BasePetStats[3142] = false
    BPBID_Arrays.BasePetStats[3143] = false
    BPBID_Arrays.BasePetStats[3144] = false
    BPBID_Arrays.BasePetStats[3145] = false
    BPBID_Arrays.BasePetStats[3146] = false
    BPBID_Arrays.BasePetStats[3147] = false
    BPBID_Arrays.BasePetStats[3148] = false
    BPBID_Arrays.BasePetStats[3149] = false
    BPBID_Arrays.BasePetStats[3150] = false
    BPBID_Arrays.BasePetStats[3151] = false
    BPBID_Arrays.BasePetStats[3152] = false
    BPBID_Arrays.BasePetStats[3153] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3154] = false
    BPBID_Arrays.BasePetStats[3155] = {8.25, 8, 8}
    BPBID_Arrays.BasePetStats[3156] = {8.5, 8.5, 8.25}
    BPBID_Arrays.BasePetStats[3157] = false
    BPBID_Arrays.BasePetStats[3158] = {5.5, 9.5, 11.5}
    BPBID_Arrays.BasePetStats[3159] = false
    BPBID_Arrays.BasePetStats[3160] = false
    BPBID_Arrays.BasePetStats[3161] = false
    BPBID_Arrays.BasePetStats[3162] = false
    BPBID_Arrays.BasePetStats[3163] = false
    BPBID_Arrays.BasePetStats[3164] = false
    BPBID_Arrays.BasePetStats[3165] = false
    BPBID_Arrays.BasePetStats[3166] = false
    BPBID_Arrays.BasePetStats[3167] = false
    BPBID_Arrays.BasePetStats[3168] = false
    BPBID_Arrays.BasePetStats[3169] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[3170] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[3171] = {8.5, 8, 7.5}
    BPBID_Arrays.BasePetStats[3172] = {8, 8.5, 7.5}
    BPBID_Arrays.BasePetStats[3173] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[3174] = {7.825, 8.05, 8.125}
    BPBID_Arrays.BasePetStats[3175] = false
    BPBID_Arrays.BasePetStats[3176] = {7.825, 8.05, 8.125}
    BPBID_Arrays.BasePetStats[3177] = false
    BPBID_Arrays.BasePetStats[3178] = {7.825, 8.05, 8.125}
    BPBID_Arrays.BasePetStats[3179] = {9.5, 8, 6.5}
    BPBID_Arrays.BasePetStats[3180] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[3181] = {9, 7.5, 7.5}
    BPBID_Arrays.BasePetStats[3182] = false
    BPBID_Arrays.BasePetStats[3183] = false
    BPBID_Arrays.BasePetStats[3184] = false
    BPBID_Arrays.BasePetStats[3185] = false
    BPBID_Arrays.BasePetStats[3186] = false
    BPBID_Arrays.BasePetStats[3187] = false
    BPBID_Arrays.BasePetStats[3188] = {7.825, 8.675, 7.5}
    BPBID_Arrays.BasePetStats[3189] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[3190] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[3191] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[3192] = false
    BPBID_Arrays.BasePetStats[3193] = false
    BPBID_Arrays.BasePetStats[3194] = false
    BPBID_Arrays.BasePetStats[3195] = false
    BPBID_Arrays.BasePetStats[3196] = {7.825, 8.05, 8.125}
    BPBID_Arrays.BasePetStats[3197] = {7.95, 7.8, 8.25}
    BPBID_Arrays.BasePetStats[3198] = false
    BPBID_Arrays.BasePetStats[3199] = false
    BPBID_Arrays.BasePetStats[3200] = {7.75, 8.125, 8.125}
    BPBID_Arrays.BasePetStats[3201] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[3202] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[3203] = {7, 8.5, 8.5}
    BPBID_Arrays.BasePetStats[3204] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[3205] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[3206] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[3207] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[3208] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[3209] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[3210] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[3211] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3212] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3213] = {7.825, 8.05, 8.125}
    BPBID_Arrays.BasePetStats[3214] = {7.825, 8.05, 8.125}
    BPBID_Arrays.BasePetStats[3215] = {9.5, 8, 6.5}
    BPBID_Arrays.BasePetStats[3216] = {7.95, 7.8, 8.25}
    BPBID_Arrays.BasePetStats[3217] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[3218] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3219] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[3220] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3221] = {8.75, 8.25, 7}
    BPBID_Arrays.BasePetStats[3222] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[3223] = {7.95, 7.8, 8.25}
    BPBID_Arrays.BasePetStats[3224] = {7.5, 8.5, 8}
    BPBID_Arrays.BasePetStats[3225] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3226] = {8, 8, 8}
    BPBID_Arrays.BasePetStats[3227] = {9.5, 8, 6.5}
    BPBID_Arrays.BasePetStats[3228] = false
    BPBID_Arrays.BasePetStats[3229] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[3230] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[3231] = {7.75, 8.5, 7.75}
    BPBID_Arrays.BasePetStats[3232] = {8, 7, 9}
    BPBID_Arrays.BasePetStats[3233] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[3234] = {7.5, 8, 8.5}
    BPBID_Arrays.BasePetStats[3235] = {9.5, 8.5, 6}
    BPBID_Arrays.BasePetStats[3236] = false
    BPBID_Arrays.BasePetStats[3237] = {7.95, 7.8, 8.25}
    BPBID_Arrays.BasePetStats[3238] = false
    BPBID_Arrays.BasePetStats[3239] = false
    BPBID_Arrays.BasePetStats[3240] = false
    BPBID_Arrays.BasePetStats[3241] = false
    BPBID_Arrays.BasePetStats[3242] = false
    BPBID_Arrays.BasePetStats[3243] = false
    BPBID_Arrays.BasePetStats[3244] = false
    BPBID_Arrays.BasePetStats[3245] = false
    BPBID_Arrays.BasePetStats[3246] = {28, 8, -12}
    BPBID_Arrays.BasePetStats[3247] = {8, 8, 8}


    -- AVAILABLE BREEDS
    BPBID_Arrays.BreedsPerSpecies[1] = false
    BPBID_Arrays.BreedsPerSpecies[2] = false
    BPBID_Arrays.BreedsPerSpecies[3] = false
    BPBID_Arrays.BreedsPerSpecies[4] = false
    BPBID_Arrays.BreedsPerSpecies[5] = false
    BPBID_Arrays.BreedsPerSpecies[6] = false
    BPBID_Arrays.BreedsPerSpecies[7] = false
    BPBID_Arrays.BreedsPerSpecies[8] = false
    BPBID_Arrays.BreedsPerSpecies[9] = false
    BPBID_Arrays.BreedsPerSpecies[10] = false
    BPBID_Arrays.BreedsPerSpecies[11] = false
    BPBID_Arrays.BreedsPerSpecies[12] = false
    BPBID_Arrays.BreedsPerSpecies[13] = false
    BPBID_Arrays.BreedsPerSpecies[14] = false
    BPBID_Arrays.BreedsPerSpecies[15] = false
    BPBID_Arrays.BreedsPerSpecies[16] = false
    BPBID_Arrays.BreedsPerSpecies[17] = false
    BPBID_Arrays.BreedsPerSpecies[18] = false
    BPBID_Arrays.BreedsPerSpecies[19] = false
    BPBID_Arrays.BreedsPerSpecies[20] = false
    BPBID_Arrays.BreedsPerSpecies[21] = false
    BPBID_Arrays.BreedsPerSpecies[22] = false
    BPBID_Arrays.BreedsPerSpecies[23] = false
    BPBID_Arrays.BreedsPerSpecies[24] = false
    BPBID_Arrays.BreedsPerSpecies[25] = false
    BPBID_Arrays.BreedsPerSpecies[26] = false
    BPBID_Arrays.BreedsPerSpecies[27] = false
    BPBID_Arrays.BreedsPerSpecies[28] = false
    BPBID_Arrays.BreedsPerSpecies[29] = false
    BPBID_Arrays.BreedsPerSpecies[30] = false
    BPBID_Arrays.BreedsPerSpecies[31] = false
    BPBID_Arrays.BreedsPerSpecies[32] = false
    BPBID_Arrays.BreedsPerSpecies[33] = false
    BPBID_Arrays.BreedsPerSpecies[34] = false
    BPBID_Arrays.BreedsPerSpecies[35] = false
    BPBID_Arrays.BreedsPerSpecies[36] = false
    BPBID_Arrays.BreedsPerSpecies[37] = false
    BPBID_Arrays.BreedsPerSpecies[38] = false
    BPBID_Arrays.BreedsPerSpecies[39] = {11}
    BPBID_Arrays.BreedsPerSpecies[40] = {8}
    BPBID_Arrays.BreedsPerSpecies[41] = {4}
    BPBID_Arrays.BreedsPerSpecies[42] = {7}
    BPBID_Arrays.BreedsPerSpecies[43] = {3}
    BPBID_Arrays.BreedsPerSpecies[44] = {5}
    BPBID_Arrays.BreedsPerSpecies[45] = {3}
    BPBID_Arrays.BreedsPerSpecies[46] = {12}
    BPBID_Arrays.BreedsPerSpecies[47] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[48] = false
    BPBID_Arrays.BreedsPerSpecies[49] = {3}
    BPBID_Arrays.BreedsPerSpecies[50] = {11}
    BPBID_Arrays.BreedsPerSpecies[51] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[52] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[53] = false
    BPBID_Arrays.BreedsPerSpecies[54] = false
    BPBID_Arrays.BreedsPerSpecies[55] = {3, 5, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[56] = {8}
    BPBID_Arrays.BreedsPerSpecies[57] = {4}
    BPBID_Arrays.BreedsPerSpecies[58] = {8}
    BPBID_Arrays.BreedsPerSpecies[59] = {9}
    BPBID_Arrays.BreedsPerSpecies[60] = false
    BPBID_Arrays.BreedsPerSpecies[61] = false
    BPBID_Arrays.BreedsPerSpecies[62] = false
    BPBID_Arrays.BreedsPerSpecies[63] = false
    BPBID_Arrays.BreedsPerSpecies[64] = {9}
    BPBID_Arrays.BreedsPerSpecies[65] = {12}
    BPBID_Arrays.BreedsPerSpecies[66] = false
    BPBID_Arrays.BreedsPerSpecies[67] = {3, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[68] = {3, 6, 7}
    BPBID_Arrays.BreedsPerSpecies[69] = {3, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[70] = {3, 5, 12}
    BPBID_Arrays.BreedsPerSpecies[71] = false
    BPBID_Arrays.BreedsPerSpecies[72] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[73] = false
    BPBID_Arrays.BreedsPerSpecies[74] = {11}
    BPBID_Arrays.BreedsPerSpecies[75] = {5}
    BPBID_Arrays.BreedsPerSpecies[76] = false
    BPBID_Arrays.BreedsPerSpecies[77] = {3}
    BPBID_Arrays.BreedsPerSpecies[78] = {12}
    BPBID_Arrays.BreedsPerSpecies[79] = false
    BPBID_Arrays.BreedsPerSpecies[80] = false
    BPBID_Arrays.BreedsPerSpecies[81] = false
    BPBID_Arrays.BreedsPerSpecies[82] = false
    BPBID_Arrays.BreedsPerSpecies[83] = {8}
    BPBID_Arrays.BreedsPerSpecies[84] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[85] = {9}
    BPBID_Arrays.BreedsPerSpecies[86] = {7}
    BPBID_Arrays.BreedsPerSpecies[87] = {5}
    BPBID_Arrays.BreedsPerSpecies[88] = false
    BPBID_Arrays.BreedsPerSpecies[89] = {6}
    BPBID_Arrays.BreedsPerSpecies[90] = {7}
    BPBID_Arrays.BreedsPerSpecies[91] = false
    BPBID_Arrays.BreedsPerSpecies[92] = {3}
    BPBID_Arrays.BreedsPerSpecies[93] = {4}
    BPBID_Arrays.BreedsPerSpecies[94] = {5}
    BPBID_Arrays.BreedsPerSpecies[95] = {3}
    BPBID_Arrays.BreedsPerSpecies[96] = false
    BPBID_Arrays.BreedsPerSpecies[97] = false
    BPBID_Arrays.BreedsPerSpecies[98] = false
    BPBID_Arrays.BreedsPerSpecies[99] = false
    BPBID_Arrays.BreedsPerSpecies[100] = false
    BPBID_Arrays.BreedsPerSpecies[101] = false
    BPBID_Arrays.BreedsPerSpecies[102] = false
    BPBID_Arrays.BreedsPerSpecies[103] = false
    BPBID_Arrays.BreedsPerSpecies[104] = false
    BPBID_Arrays.BreedsPerSpecies[105] = false
    BPBID_Arrays.BreedsPerSpecies[106] = {10}
    BPBID_Arrays.BreedsPerSpecies[107] = {3}
    BPBID_Arrays.BreedsPerSpecies[108] = false
    BPBID_Arrays.BreedsPerSpecies[109] = false
    BPBID_Arrays.BreedsPerSpecies[110] = false
    BPBID_Arrays.BreedsPerSpecies[111] = {12}
    BPBID_Arrays.BreedsPerSpecies[112] = false
    BPBID_Arrays.BreedsPerSpecies[113] = false
    BPBID_Arrays.BreedsPerSpecies[114] = {12}
    BPBID_Arrays.BreedsPerSpecies[115] = {3}
    BPBID_Arrays.BreedsPerSpecies[116] = {12}
    BPBID_Arrays.BreedsPerSpecies[117] = {3}
    BPBID_Arrays.BreedsPerSpecies[118] = {3}
    BPBID_Arrays.BreedsPerSpecies[119] = {3}
    BPBID_Arrays.BreedsPerSpecies[120] = {3}
    BPBID_Arrays.BreedsPerSpecies[121] = {3}
    BPBID_Arrays.BreedsPerSpecies[122] = {5}
    BPBID_Arrays.BreedsPerSpecies[123] = false
    BPBID_Arrays.BreedsPerSpecies[124] = {3}
    BPBID_Arrays.BreedsPerSpecies[125] = {5}
    BPBID_Arrays.BreedsPerSpecies[126] = {10}
    BPBID_Arrays.BreedsPerSpecies[127] = {7}
    BPBID_Arrays.BreedsPerSpecies[128] = {3}
    BPBID_Arrays.BreedsPerSpecies[129] = false
    BPBID_Arrays.BreedsPerSpecies[130] = {3}
    BPBID_Arrays.BreedsPerSpecies[131] = {8}
    BPBID_Arrays.BreedsPerSpecies[132] = {6}
    BPBID_Arrays.BreedsPerSpecies[133] = false
    BPBID_Arrays.BreedsPerSpecies[134] = false
    BPBID_Arrays.BreedsPerSpecies[135] = false
    BPBID_Arrays.BreedsPerSpecies[136] = {3, 7, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[137] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[138] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[139] = {3, 8, 12}
    BPBID_Arrays.BreedsPerSpecies[140] = {3, 4, 12}
    BPBID_Arrays.BreedsPerSpecies[141] = {3, 6, 12}
    BPBID_Arrays.BreedsPerSpecies[142] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[143] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[144] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[145] = {3, 5, 6, 8}
    BPBID_Arrays.BreedsPerSpecies[146] = {3, 5, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[147] = false
    BPBID_Arrays.BreedsPerSpecies[148] = false
    BPBID_Arrays.BreedsPerSpecies[149] = {9}
    BPBID_Arrays.BreedsPerSpecies[150] = false
    BPBID_Arrays.BreedsPerSpecies[151] = false
    BPBID_Arrays.BreedsPerSpecies[152] = false
    BPBID_Arrays.BreedsPerSpecies[153] = {7}
    BPBID_Arrays.BreedsPerSpecies[154] = false
    BPBID_Arrays.BreedsPerSpecies[155] = {7}
    BPBID_Arrays.BreedsPerSpecies[156] = {3}
    BPBID_Arrays.BreedsPerSpecies[157] = {3}
    BPBID_Arrays.BreedsPerSpecies[158] = {3}
    BPBID_Arrays.BreedsPerSpecies[159] = {6}
    BPBID_Arrays.BreedsPerSpecies[160] = {4}
    BPBID_Arrays.BreedsPerSpecies[161] = false
    BPBID_Arrays.BreedsPerSpecies[162] = {10}
    BPBID_Arrays.BreedsPerSpecies[163] = {8}
    BPBID_Arrays.BreedsPerSpecies[164] = {3}
    BPBID_Arrays.BreedsPerSpecies[165] = {9}
    BPBID_Arrays.BreedsPerSpecies[166] = {7}
    BPBID_Arrays.BreedsPerSpecies[167] = {3, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[168] = {5}
    BPBID_Arrays.BreedsPerSpecies[169] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[170] = {7}
    BPBID_Arrays.BreedsPerSpecies[171] = {7}
    BPBID_Arrays.BreedsPerSpecies[172] = {10}
    BPBID_Arrays.BreedsPerSpecies[173] = {7}
    BPBID_Arrays.BreedsPerSpecies[174] = {3}
    BPBID_Arrays.BreedsPerSpecies[175] = {5}
    BPBID_Arrays.BreedsPerSpecies[176] = false
    BPBID_Arrays.BreedsPerSpecies[177] = false
    BPBID_Arrays.BreedsPerSpecies[178] = false
    BPBID_Arrays.BreedsPerSpecies[179] = {7}
    BPBID_Arrays.BreedsPerSpecies[180] = {7}
    BPBID_Arrays.BreedsPerSpecies[181] = false
    BPBID_Arrays.BreedsPerSpecies[182] = false
    BPBID_Arrays.BreedsPerSpecies[183] = {3}
    BPBID_Arrays.BreedsPerSpecies[184] = false
    BPBID_Arrays.BreedsPerSpecies[185] = false
    BPBID_Arrays.BreedsPerSpecies[186] = {3, 4, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[187] = {8}
    BPBID_Arrays.BreedsPerSpecies[188] = {6}
    BPBID_Arrays.BreedsPerSpecies[189] = {3}
    BPBID_Arrays.BreedsPerSpecies[190] = {6, 7, 12}
    BPBID_Arrays.BreedsPerSpecies[191] = {3}
    BPBID_Arrays.BreedsPerSpecies[192] = {9}
    BPBID_Arrays.BreedsPerSpecies[193] = {4}
    BPBID_Arrays.BreedsPerSpecies[194] = {3, 5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[195] = {5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[196] = {7}
    BPBID_Arrays.BreedsPerSpecies[197] = {8}
    BPBID_Arrays.BreedsPerSpecies[198] = {11}
    BPBID_Arrays.BreedsPerSpecies[199] = {10}
    BPBID_Arrays.BreedsPerSpecies[200] = {5}
    BPBID_Arrays.BreedsPerSpecies[201] = {7}
    BPBID_Arrays.BreedsPerSpecies[202] = {7}
    BPBID_Arrays.BreedsPerSpecies[203] = {12}
    BPBID_Arrays.BreedsPerSpecies[204] = {3}
    BPBID_Arrays.BreedsPerSpecies[205] = {7}
    BPBID_Arrays.BreedsPerSpecies[206] = {3, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[207] = {8}
    BPBID_Arrays.BreedsPerSpecies[208] = false
    BPBID_Arrays.BreedsPerSpecies[209] = {3}
    BPBID_Arrays.BreedsPerSpecies[210] = {5}
    BPBID_Arrays.BreedsPerSpecies[211] = {6}
    BPBID_Arrays.BreedsPerSpecies[212] = {3}
    BPBID_Arrays.BreedsPerSpecies[213] = {5}
    BPBID_Arrays.BreedsPerSpecies[214] = {3}
    BPBID_Arrays.BreedsPerSpecies[215] = {10}
    BPBID_Arrays.BreedsPerSpecies[216] = {3}
    BPBID_Arrays.BreedsPerSpecies[217] = {7}
    BPBID_Arrays.BreedsPerSpecies[218] = {4}
    BPBID_Arrays.BreedsPerSpecies[219] = false
    BPBID_Arrays.BreedsPerSpecies[220] = {9}
    BPBID_Arrays.BreedsPerSpecies[221] = false
    BPBID_Arrays.BreedsPerSpecies[222] = false
    BPBID_Arrays.BreedsPerSpecies[223] = false
    BPBID_Arrays.BreedsPerSpecies[224] = {10}
    BPBID_Arrays.BreedsPerSpecies[225] = {3}
    BPBID_Arrays.BreedsPerSpecies[226] = {4}
    BPBID_Arrays.BreedsPerSpecies[227] = {4}
    BPBID_Arrays.BreedsPerSpecies[228] = {7}
    BPBID_Arrays.BreedsPerSpecies[229] = {3}
    BPBID_Arrays.BreedsPerSpecies[230] = false
    BPBID_Arrays.BreedsPerSpecies[231] = {3}
    BPBID_Arrays.BreedsPerSpecies[232] = {8}
    BPBID_Arrays.BreedsPerSpecies[233] = {8}
    BPBID_Arrays.BreedsPerSpecies[234] = {10}
    BPBID_Arrays.BreedsPerSpecies[235] = {10}
    BPBID_Arrays.BreedsPerSpecies[236] = {6}
    BPBID_Arrays.BreedsPerSpecies[237] = {3}
    BPBID_Arrays.BreedsPerSpecies[238] = {11}
    BPBID_Arrays.BreedsPerSpecies[239] = {4}
    BPBID_Arrays.BreedsPerSpecies[240] = {3}
    BPBID_Arrays.BreedsPerSpecies[241] = {12}
    BPBID_Arrays.BreedsPerSpecies[242] = {8}
    BPBID_Arrays.BreedsPerSpecies[243] = {10}
    BPBID_Arrays.BreedsPerSpecies[244] = {7}
    BPBID_Arrays.BreedsPerSpecies[245] = {8}
    BPBID_Arrays.BreedsPerSpecies[246] = {3}
    BPBID_Arrays.BreedsPerSpecies[247] = {6}
    BPBID_Arrays.BreedsPerSpecies[248] = {8}
    BPBID_Arrays.BreedsPerSpecies[249] = {7}
    BPBID_Arrays.BreedsPerSpecies[250] = {8}
    BPBID_Arrays.BreedsPerSpecies[251] = {3}
    BPBID_Arrays.BreedsPerSpecies[252] = false
    BPBID_Arrays.BreedsPerSpecies[253] = {3}
    BPBID_Arrays.BreedsPerSpecies[254] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[255] = {6}
    BPBID_Arrays.BreedsPerSpecies[256] = {7}
    BPBID_Arrays.BreedsPerSpecies[257] = false
    BPBID_Arrays.BreedsPerSpecies[258] = {6}
    BPBID_Arrays.BreedsPerSpecies[259] = {12}
    BPBID_Arrays.BreedsPerSpecies[260] = {8}
    BPBID_Arrays.BreedsPerSpecies[261] = {4}
    BPBID_Arrays.BreedsPerSpecies[262] = {5}
    BPBID_Arrays.BreedsPerSpecies[263] = false
    BPBID_Arrays.BreedsPerSpecies[264] = {8}
    BPBID_Arrays.BreedsPerSpecies[265] = {6}
    BPBID_Arrays.BreedsPerSpecies[266] = {8}
    BPBID_Arrays.BreedsPerSpecies[267] = {3}
    BPBID_Arrays.BreedsPerSpecies[268] = {4}
    BPBID_Arrays.BreedsPerSpecies[269] = false
    BPBID_Arrays.BreedsPerSpecies[270] = {9}
    BPBID_Arrays.BreedsPerSpecies[271] = {3, 9, 10}
    BPBID_Arrays.BreedsPerSpecies[272] = {6, 9}
    BPBID_Arrays.BreedsPerSpecies[273] = false
    BPBID_Arrays.BreedsPerSpecies[274] = false
    BPBID_Arrays.BreedsPerSpecies[275] = false
    BPBID_Arrays.BreedsPerSpecies[276] = false
    BPBID_Arrays.BreedsPerSpecies[277] = {11}
    BPBID_Arrays.BreedsPerSpecies[278] = {9}
    BPBID_Arrays.BreedsPerSpecies[279] = {8}
    BPBID_Arrays.BreedsPerSpecies[280] = {3}
    BPBID_Arrays.BreedsPerSpecies[281] = {3}
    BPBID_Arrays.BreedsPerSpecies[282] = {3}
    BPBID_Arrays.BreedsPerSpecies[283] = {3}
    BPBID_Arrays.BreedsPerSpecies[284] = false
    BPBID_Arrays.BreedsPerSpecies[285] = {10}
    BPBID_Arrays.BreedsPerSpecies[286] = {7}
    BPBID_Arrays.BreedsPerSpecies[287] = {3}
    BPBID_Arrays.BreedsPerSpecies[288] = false
    BPBID_Arrays.BreedsPerSpecies[289] = {6}
    BPBID_Arrays.BreedsPerSpecies[290] = false
    BPBID_Arrays.BreedsPerSpecies[291] = {12}
    BPBID_Arrays.BreedsPerSpecies[292] = {3}
    BPBID_Arrays.BreedsPerSpecies[293] = {9}
    BPBID_Arrays.BreedsPerSpecies[294] = {8}
    BPBID_Arrays.BreedsPerSpecies[295] = false
    BPBID_Arrays.BreedsPerSpecies[296] = {3}
    BPBID_Arrays.BreedsPerSpecies[297] = {4}
    BPBID_Arrays.BreedsPerSpecies[298] = {3}
    BPBID_Arrays.BreedsPerSpecies[299] = false
    BPBID_Arrays.BreedsPerSpecies[300] = false
    BPBID_Arrays.BreedsPerSpecies[301] = {11}
    BPBID_Arrays.BreedsPerSpecies[302] = {7}
    BPBID_Arrays.BreedsPerSpecies[303] = {5}
    BPBID_Arrays.BreedsPerSpecies[304] = false
    BPBID_Arrays.BreedsPerSpecies[305] = false
    BPBID_Arrays.BreedsPerSpecies[306] = {11}
    BPBID_Arrays.BreedsPerSpecies[307] = {3}
    BPBID_Arrays.BreedsPerSpecies[308] = {3}
    BPBID_Arrays.BreedsPerSpecies[309] = {8}
    BPBID_Arrays.BreedsPerSpecies[310] = {8}
    BPBID_Arrays.BreedsPerSpecies[311] = {3}
    BPBID_Arrays.BreedsPerSpecies[312] = false
    BPBID_Arrays.BreedsPerSpecies[313] = false
    BPBID_Arrays.BreedsPerSpecies[314] = false
    BPBID_Arrays.BreedsPerSpecies[315] = false
    BPBID_Arrays.BreedsPerSpecies[316] = {3}
    BPBID_Arrays.BreedsPerSpecies[317] = {3}
    BPBID_Arrays.BreedsPerSpecies[318] = {3}
    BPBID_Arrays.BreedsPerSpecies[319] = {10}
    BPBID_Arrays.BreedsPerSpecies[320] = {7}
    BPBID_Arrays.BreedsPerSpecies[321] = {6}
    BPBID_Arrays.BreedsPerSpecies[322] = false
    BPBID_Arrays.BreedsPerSpecies[323] = {8}
    BPBID_Arrays.BreedsPerSpecies[324] = false
    BPBID_Arrays.BreedsPerSpecies[325] = {5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[326] = false
    BPBID_Arrays.BreedsPerSpecies[327] = false
    BPBID_Arrays.BreedsPerSpecies[328] = {4}
    BPBID_Arrays.BreedsPerSpecies[329] = {8}
    BPBID_Arrays.BreedsPerSpecies[330] = {10}
    BPBID_Arrays.BreedsPerSpecies[331] = {3}
    BPBID_Arrays.BreedsPerSpecies[332] = {3}
    BPBID_Arrays.BreedsPerSpecies[333] = {11}
    BPBID_Arrays.BreedsPerSpecies[334] = false
    BPBID_Arrays.BreedsPerSpecies[335] = {12}
    BPBID_Arrays.BreedsPerSpecies[336] = {3}
    BPBID_Arrays.BreedsPerSpecies[337] = {12}
    BPBID_Arrays.BreedsPerSpecies[338] = {7}
    BPBID_Arrays.BreedsPerSpecies[339] = {12}
    BPBID_Arrays.BreedsPerSpecies[340] = {3}
    BPBID_Arrays.BreedsPerSpecies[341] = {3}
    BPBID_Arrays.BreedsPerSpecies[342] = {3}
    BPBID_Arrays.BreedsPerSpecies[343] = {3, 8}
    BPBID_Arrays.BreedsPerSpecies[344] = false
    BPBID_Arrays.BreedsPerSpecies[345] = false
    BPBID_Arrays.BreedsPerSpecies[346] = {3}
    BPBID_Arrays.BreedsPerSpecies[347] = {3}
    BPBID_Arrays.BreedsPerSpecies[348] = {8}
    BPBID_Arrays.BreedsPerSpecies[349] = false
    BPBID_Arrays.BreedsPerSpecies[350] = false
    BPBID_Arrays.BreedsPerSpecies[351] = false
    BPBID_Arrays.BreedsPerSpecies[352] = false
    BPBID_Arrays.BreedsPerSpecies[353] = false
    BPBID_Arrays.BreedsPerSpecies[354] = false
    BPBID_Arrays.BreedsPerSpecies[355] = false
    BPBID_Arrays.BreedsPerSpecies[356] = false
    BPBID_Arrays.BreedsPerSpecies[357] = false
    BPBID_Arrays.BreedsPerSpecies[358] = false
    BPBID_Arrays.BreedsPerSpecies[359] = false
    BPBID_Arrays.BreedsPerSpecies[360] = false
    BPBID_Arrays.BreedsPerSpecies[361] = false
    BPBID_Arrays.BreedsPerSpecies[362] = false
    BPBID_Arrays.BreedsPerSpecies[363] = false
    BPBID_Arrays.BreedsPerSpecies[364] = false
    BPBID_Arrays.BreedsPerSpecies[365] = false
    BPBID_Arrays.BreedsPerSpecies[366] = false
    BPBID_Arrays.BreedsPerSpecies[367] = false
    BPBID_Arrays.BreedsPerSpecies[368] = false
    BPBID_Arrays.BreedsPerSpecies[369] = false
    BPBID_Arrays.BreedsPerSpecies[370] = false
    BPBID_Arrays.BreedsPerSpecies[371] = false
    BPBID_Arrays.BreedsPerSpecies[372] = false
    BPBID_Arrays.BreedsPerSpecies[373] = false
    BPBID_Arrays.BreedsPerSpecies[374] = {7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[375] = false
    BPBID_Arrays.BreedsPerSpecies[376] = false
    BPBID_Arrays.BreedsPerSpecies[377] = false
    BPBID_Arrays.BreedsPerSpecies[378] = {3, 5, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[379] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[380] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[381] = {9}
    BPBID_Arrays.BreedsPerSpecies[382] = {3}
    BPBID_Arrays.BreedsPerSpecies[383] = {8, 11}
    BPBID_Arrays.BreedsPerSpecies[384] = false
    BPBID_Arrays.BreedsPerSpecies[385] = {3, 5, 8, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[386] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[387] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[388] = {3, 6, 7}
    BPBID_Arrays.BreedsPerSpecies[389] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[390] = false
    BPBID_Arrays.BreedsPerSpecies[391] = {3, 5, 9}
    BPBID_Arrays.BreedsPerSpecies[392] = {3, 5, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[393] = {5, 6, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[394] = false
    BPBID_Arrays.BreedsPerSpecies[395] = {3, 6, 7}
    BPBID_Arrays.BreedsPerSpecies[396] = {8, 11}
    BPBID_Arrays.BreedsPerSpecies[397] = {3, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[398] = {3, 5, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[399] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[400] = {3, 4, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[401] = {3, 6, 7}
    BPBID_Arrays.BreedsPerSpecies[402] = {3, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[403] = {3, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[404] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[405] = {3, 4, 7}
    BPBID_Arrays.BreedsPerSpecies[406] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[407] = {3, 5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[408] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[409] = {5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[410] = {3, 5, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[411] = {3, 4}
    BPBID_Arrays.BreedsPerSpecies[412] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[413] = false
    BPBID_Arrays.BreedsPerSpecies[414] = {3, 8}
    BPBID_Arrays.BreedsPerSpecies[415] = {6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[416] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[417] = {3, 5, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[418] = {3, 11}
    BPBID_Arrays.BreedsPerSpecies[419] = {3, 11}
    BPBID_Arrays.BreedsPerSpecies[420] = {3, 7, 12}
    BPBID_Arrays.BreedsPerSpecies[421] = {3, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[422] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[423] = {3, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[424] = {5, 6, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[425] = {3, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[426] = false
    BPBID_Arrays.BreedsPerSpecies[427] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[428] = {3, 5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[429] = {4, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[430] = {5}
    BPBID_Arrays.BreedsPerSpecies[431] = {8, 9}
    BPBID_Arrays.BreedsPerSpecies[432] = {3, 8}
    BPBID_Arrays.BreedsPerSpecies[433] = {3, 5, 7}
    BPBID_Arrays.BreedsPerSpecies[434] = false
    BPBID_Arrays.BreedsPerSpecies[435] = false
    BPBID_Arrays.BreedsPerSpecies[436] = false
    BPBID_Arrays.BreedsPerSpecies[437] = {3, 10}
    BPBID_Arrays.BreedsPerSpecies[438] = {6, 9}
    BPBID_Arrays.BreedsPerSpecies[439] = {6, 9}
    BPBID_Arrays.BreedsPerSpecies[440] = {3, 4, 8}
    BPBID_Arrays.BreedsPerSpecies[441] = {5, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[442] = {6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[443] = {3, 5, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[444] = false
    BPBID_Arrays.BreedsPerSpecies[445] = {6, 7, 9, 10}
    BPBID_Arrays.BreedsPerSpecies[446] = {3, 4, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[447] = {3, 5, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[448] = {3, 5, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[449] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[450] = {3, 6}
    BPBID_Arrays.BreedsPerSpecies[451] = false
    BPBID_Arrays.BreedsPerSpecies[452] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[453] = {6, 7}
    BPBID_Arrays.BreedsPerSpecies[454] = {3, 5, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[455] = {7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[456] = {3, 6, 7, 8}
    BPBID_Arrays.BreedsPerSpecies[457] = {6, 9}
    BPBID_Arrays.BreedsPerSpecies[458] = {3, 6}
    BPBID_Arrays.BreedsPerSpecies[459] = {3, 5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[460] = {3, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[461] = {3}
    BPBID_Arrays.BreedsPerSpecies[462] = false
    BPBID_Arrays.BreedsPerSpecies[463] = {6, 9}
    BPBID_Arrays.BreedsPerSpecies[464] = {3, 5, 9}
    BPBID_Arrays.BreedsPerSpecies[465] = {3, 4, 8}
    BPBID_Arrays.BreedsPerSpecies[466] = {3, 5, 7}
    BPBID_Arrays.BreedsPerSpecies[467] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[468] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[469] = {3, 4, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[470] = {3, 4, 7, 11}
    BPBID_Arrays.BreedsPerSpecies[471] = {3, 5, 6, 8, 9, 10}
    BPBID_Arrays.BreedsPerSpecies[472] = {3, 4, 5, 6, 7, 8, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[473] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[474] = {5}
    BPBID_Arrays.BreedsPerSpecies[475] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[476] = false
    BPBID_Arrays.BreedsPerSpecies[477] = {3, 11}
    BPBID_Arrays.BreedsPerSpecies[478] = {3, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[479] = {3, 11}
    BPBID_Arrays.BreedsPerSpecies[480] = {3, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[481] = false
    BPBID_Arrays.BreedsPerSpecies[482] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[483] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[484] = {3, 5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[485] = {6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[486] = false
    BPBID_Arrays.BreedsPerSpecies[487] = {3, 5, 7, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[488] = {12}
    BPBID_Arrays.BreedsPerSpecies[489] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[490] = false
    BPBID_Arrays.BreedsPerSpecies[491] = {5, 8}
    BPBID_Arrays.BreedsPerSpecies[492] = {3, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[493] = {3, 6, 7}
    BPBID_Arrays.BreedsPerSpecies[494] = {3, 6, 7}
    BPBID_Arrays.BreedsPerSpecies[495] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[496] = {3, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[497] = {6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[498] = {3, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[499] = {7}
    BPBID_Arrays.BreedsPerSpecies[500] = {3, 4, 6, 7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[501] = false
    BPBID_Arrays.BreedsPerSpecies[502] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[503] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[504] = {3, 4, 10}
    BPBID_Arrays.BreedsPerSpecies[505] = {3, 5, 7, 11}
    BPBID_Arrays.BreedsPerSpecies[506] = {3, 6, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[507] = {3, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[508] = {3, 4, 7}
    BPBID_Arrays.BreedsPerSpecies[509] = {6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[510] = false
    BPBID_Arrays.BreedsPerSpecies[511] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[512] = {4, 6, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[513] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[514] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[515] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[516] = false
    BPBID_Arrays.BreedsPerSpecies[517] = {3, 8}
    BPBID_Arrays.BreedsPerSpecies[518] = {3, 6}
    BPBID_Arrays.BreedsPerSpecies[519] = {6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[520] = false
    BPBID_Arrays.BreedsPerSpecies[521] = {10}
    BPBID_Arrays.BreedsPerSpecies[522] = false
    BPBID_Arrays.BreedsPerSpecies[523] = {6, 9}
    BPBID_Arrays.BreedsPerSpecies[524] = false
    BPBID_Arrays.BreedsPerSpecies[525] = {3, 5, 12}
    BPBID_Arrays.BreedsPerSpecies[526] = false
    BPBID_Arrays.BreedsPerSpecies[527] = false
    BPBID_Arrays.BreedsPerSpecies[528] = {9, 12}
    BPBID_Arrays.BreedsPerSpecies[529] = {4, 7}
    BPBID_Arrays.BreedsPerSpecies[530] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[531] = false
    BPBID_Arrays.BreedsPerSpecies[532] = {4, 6}
    BPBID_Arrays.BreedsPerSpecies[533] = false
    BPBID_Arrays.BreedsPerSpecies[534] = {3, 4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[535] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[536] = {7, 9}
    BPBID_Arrays.BreedsPerSpecies[537] = {3, 4, 6, 7}
    BPBID_Arrays.BreedsPerSpecies[538] = {6, 8}
    BPBID_Arrays.BreedsPerSpecies[539] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[540] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[541] = {5, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[542] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[543] = {3, 5, 9}
    BPBID_Arrays.BreedsPerSpecies[544] = {5, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[545] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[546] = {6, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[547] = {3, 5, 7, 9, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[548] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[549] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[550] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[551] = false
    BPBID_Arrays.BreedsPerSpecies[552] = {3, 4, 6, 7, 11}
    BPBID_Arrays.BreedsPerSpecies[553] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[554] = {3, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[555] = {5, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[556] = {6, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[557] = {4, 5, 7, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[558] = {8}
    BPBID_Arrays.BreedsPerSpecies[559] = {4, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[560] = {3, 5, 10}
    BPBID_Arrays.BreedsPerSpecies[561] = false
    BPBID_Arrays.BreedsPerSpecies[562] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[563] = false
    BPBID_Arrays.BreedsPerSpecies[564] = {3, 6, 12}
    BPBID_Arrays.BreedsPerSpecies[565] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[566] = {3, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[567] = {5, 10}
    BPBID_Arrays.BreedsPerSpecies[568] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[569] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[570] = {3, 10}
    BPBID_Arrays.BreedsPerSpecies[571] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[572] = {4, 6}
    BPBID_Arrays.BreedsPerSpecies[573] = {3, 5, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[574] = false
    BPBID_Arrays.BreedsPerSpecies[575] = false
    BPBID_Arrays.BreedsPerSpecies[576] = false
    BPBID_Arrays.BreedsPerSpecies[577] = false
    BPBID_Arrays.BreedsPerSpecies[578] = false
    BPBID_Arrays.BreedsPerSpecies[579] = false
    BPBID_Arrays.BreedsPerSpecies[580] = false
    BPBID_Arrays.BreedsPerSpecies[581] = false
    BPBID_Arrays.BreedsPerSpecies[582] = false
    BPBID_Arrays.BreedsPerSpecies[583] = false
    BPBID_Arrays.BreedsPerSpecies[584] = false
    BPBID_Arrays.BreedsPerSpecies[585] = false
    BPBID_Arrays.BreedsPerSpecies[586] = false
    BPBID_Arrays.BreedsPerSpecies[587] = false
    BPBID_Arrays.BreedsPerSpecies[588] = false
    BPBID_Arrays.BreedsPerSpecies[589] = false
    BPBID_Arrays.BreedsPerSpecies[590] = false
    BPBID_Arrays.BreedsPerSpecies[591] = false
    BPBID_Arrays.BreedsPerSpecies[592] = false
    BPBID_Arrays.BreedsPerSpecies[593] = false
    BPBID_Arrays.BreedsPerSpecies[594] = false
    BPBID_Arrays.BreedsPerSpecies[595] = false
    BPBID_Arrays.BreedsPerSpecies[596] = false
    BPBID_Arrays.BreedsPerSpecies[597] = false
    BPBID_Arrays.BreedsPerSpecies[598] = false
    BPBID_Arrays.BreedsPerSpecies[599] = false
    BPBID_Arrays.BreedsPerSpecies[600] = false
    BPBID_Arrays.BreedsPerSpecies[601] = false
    BPBID_Arrays.BreedsPerSpecies[602] = false
    BPBID_Arrays.BreedsPerSpecies[603] = false
    BPBID_Arrays.BreedsPerSpecies[604] = false
    BPBID_Arrays.BreedsPerSpecies[605] = false
    BPBID_Arrays.BreedsPerSpecies[606] = false
    BPBID_Arrays.BreedsPerSpecies[607] = false
    BPBID_Arrays.BreedsPerSpecies[608] = false
    BPBID_Arrays.BreedsPerSpecies[609] = false
    BPBID_Arrays.BreedsPerSpecies[610] = false
    BPBID_Arrays.BreedsPerSpecies[611] = false
    BPBID_Arrays.BreedsPerSpecies[612] = false
    BPBID_Arrays.BreedsPerSpecies[613] = false
    BPBID_Arrays.BreedsPerSpecies[614] = false
    BPBID_Arrays.BreedsPerSpecies[615] = false
    BPBID_Arrays.BreedsPerSpecies[616] = false
    BPBID_Arrays.BreedsPerSpecies[617] = false
    BPBID_Arrays.BreedsPerSpecies[618] = false
    BPBID_Arrays.BreedsPerSpecies[619] = false
    BPBID_Arrays.BreedsPerSpecies[620] = false
    BPBID_Arrays.BreedsPerSpecies[621] = false
    BPBID_Arrays.BreedsPerSpecies[622] = false
    BPBID_Arrays.BreedsPerSpecies[623] = false
    BPBID_Arrays.BreedsPerSpecies[624] = false
    BPBID_Arrays.BreedsPerSpecies[625] = false
    BPBID_Arrays.BreedsPerSpecies[626] = {4, 5, 7, 8, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[627] = {7, 10}
    BPBID_Arrays.BreedsPerSpecies[628] = {3, 10}
    BPBID_Arrays.BreedsPerSpecies[629] = {3, 4, 7}
    BPBID_Arrays.BreedsPerSpecies[630] = {3, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[631] = {7, 9}
    BPBID_Arrays.BreedsPerSpecies[632] = {3, 10}
    BPBID_Arrays.BreedsPerSpecies[633] = {3, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[634] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[635] = {3, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[636] = false
    BPBID_Arrays.BreedsPerSpecies[637] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[638] = {5, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[639] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[640] = {3, 5, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[641] = {3, 5, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[642] = false
    BPBID_Arrays.BreedsPerSpecies[643] = false
    BPBID_Arrays.BreedsPerSpecies[644] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[645] = {3, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[646] = {3, 5, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[647] = {3, 5, 8, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[648] = {3, 6, 7, 12}
    BPBID_Arrays.BreedsPerSpecies[649] = {3, 7, 8}
    BPBID_Arrays.BreedsPerSpecies[650] = {8}
    BPBID_Arrays.BreedsPerSpecies[651] = false
    BPBID_Arrays.BreedsPerSpecies[652] = {11}
    BPBID_Arrays.BreedsPerSpecies[653] = false
    BPBID_Arrays.BreedsPerSpecies[654] = false
    BPBID_Arrays.BreedsPerSpecies[655] = false
    BPBID_Arrays.BreedsPerSpecies[656] = false
    BPBID_Arrays.BreedsPerSpecies[657] = false
    BPBID_Arrays.BreedsPerSpecies[658] = false
    BPBID_Arrays.BreedsPerSpecies[659] = false
    BPBID_Arrays.BreedsPerSpecies[660] = false
    BPBID_Arrays.BreedsPerSpecies[661] = false
    BPBID_Arrays.BreedsPerSpecies[662] = false
    BPBID_Arrays.BreedsPerSpecies[663] = false
    BPBID_Arrays.BreedsPerSpecies[664] = false
    BPBID_Arrays.BreedsPerSpecies[665] = {11}
    BPBID_Arrays.BreedsPerSpecies[666] = {7}
    BPBID_Arrays.BreedsPerSpecies[667] = false
    BPBID_Arrays.BreedsPerSpecies[668] = false
    BPBID_Arrays.BreedsPerSpecies[669] = false
    BPBID_Arrays.BreedsPerSpecies[670] = false
    BPBID_Arrays.BreedsPerSpecies[671] = {8}
    BPBID_Arrays.BreedsPerSpecies[672] = false
    BPBID_Arrays.BreedsPerSpecies[673] = false
    BPBID_Arrays.BreedsPerSpecies[674] = false
    BPBID_Arrays.BreedsPerSpecies[675] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[676] = false
    BPBID_Arrays.BreedsPerSpecies[677] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[678] = {6, 9}
    BPBID_Arrays.BreedsPerSpecies[679] = {5, 11}
    BPBID_Arrays.BreedsPerSpecies[680] = {5, 11}
    BPBID_Arrays.BreedsPerSpecies[681] = false
    BPBID_Arrays.BreedsPerSpecies[682] = false
    BPBID_Arrays.BreedsPerSpecies[683] = false
    BPBID_Arrays.BreedsPerSpecies[684] = false
    BPBID_Arrays.BreedsPerSpecies[685] = false
    BPBID_Arrays.BreedsPerSpecies[686] = false
    BPBID_Arrays.BreedsPerSpecies[687] = false
    BPBID_Arrays.BreedsPerSpecies[688] = false
    BPBID_Arrays.BreedsPerSpecies[689] = false
    BPBID_Arrays.BreedsPerSpecies[690] = false
    BPBID_Arrays.BreedsPerSpecies[691] = false
    BPBID_Arrays.BreedsPerSpecies[692] = false
    BPBID_Arrays.BreedsPerSpecies[693] = false
    BPBID_Arrays.BreedsPerSpecies[694] = false
    BPBID_Arrays.BreedsPerSpecies[695] = false
    BPBID_Arrays.BreedsPerSpecies[696] = false
    BPBID_Arrays.BreedsPerSpecies[697] = false
    BPBID_Arrays.BreedsPerSpecies[698] = false
    BPBID_Arrays.BreedsPerSpecies[699] = {3, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[700] = false
    BPBID_Arrays.BreedsPerSpecies[701] = false
    BPBID_Arrays.BreedsPerSpecies[702] = {3, 5, 12}
    BPBID_Arrays.BreedsPerSpecies[703] = {3, 11}
    BPBID_Arrays.BreedsPerSpecies[704] = false
    BPBID_Arrays.BreedsPerSpecies[705] = false
    BPBID_Arrays.BreedsPerSpecies[706] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[707] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[708] = {3, 5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[709] = {3, 5, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[710] = {3, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[711] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[712] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[713] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[714] = {3, 4, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[715] = false
    BPBID_Arrays.BreedsPerSpecies[716] = {7, 9}
    BPBID_Arrays.BreedsPerSpecies[717] = {5, 6, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[718] = {3, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[719] = false
    BPBID_Arrays.BreedsPerSpecies[720] = false
    BPBID_Arrays.BreedsPerSpecies[721] = false
    BPBID_Arrays.BreedsPerSpecies[722] = {3, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[723] = {3, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[724] = {5, 10}
    BPBID_Arrays.BreedsPerSpecies[725] = {3, 11}
    BPBID_Arrays.BreedsPerSpecies[726] = {3, 5, 7}
    BPBID_Arrays.BreedsPerSpecies[727] = {3, 5, 8, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[728] = {3, 5, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[729] = {3, 5, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[730] = {3, 5, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[731] = {7, 9}
    BPBID_Arrays.BreedsPerSpecies[732] = {8, 9}
    BPBID_Arrays.BreedsPerSpecies[733] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[734] = false
    BPBID_Arrays.BreedsPerSpecies[735] = false
    BPBID_Arrays.BreedsPerSpecies[736] = false
    BPBID_Arrays.BreedsPerSpecies[737] = {5, 8}
    BPBID_Arrays.BreedsPerSpecies[738] = false
    BPBID_Arrays.BreedsPerSpecies[739] = {5, 8}
    BPBID_Arrays.BreedsPerSpecies[740] = {3, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[741] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[742] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[743] = {3, 5, 12}
    BPBID_Arrays.BreedsPerSpecies[744] = {5, 6, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[745] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[746] = {4, 6}
    BPBID_Arrays.BreedsPerSpecies[747] = {3, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[748] = {3, 5, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[749] = {5, 11}
    BPBID_Arrays.BreedsPerSpecies[750] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[751] = {3, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[752] = {3, 4, 12}
    BPBID_Arrays.BreedsPerSpecies[753] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[754] = {3, 5, 7, 8, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[755] = {8, 10}
    BPBID_Arrays.BreedsPerSpecies[756] = {3, 5, 9}
    BPBID_Arrays.BreedsPerSpecies[757] = {5}
    BPBID_Arrays.BreedsPerSpecies[758] = {8}
    BPBID_Arrays.BreedsPerSpecies[759] = false
    BPBID_Arrays.BreedsPerSpecies[760] = false
    BPBID_Arrays.BreedsPerSpecies[761] = false
    BPBID_Arrays.BreedsPerSpecies[762] = false
    BPBID_Arrays.BreedsPerSpecies[763] = false
    BPBID_Arrays.BreedsPerSpecies[764] = false
    BPBID_Arrays.BreedsPerSpecies[765] = false
    BPBID_Arrays.BreedsPerSpecies[766] = false
    BPBID_Arrays.BreedsPerSpecies[767] = false
    BPBID_Arrays.BreedsPerSpecies[768] = false
    BPBID_Arrays.BreedsPerSpecies[769] = false
    BPBID_Arrays.BreedsPerSpecies[770] = false
    BPBID_Arrays.BreedsPerSpecies[771] = false
    BPBID_Arrays.BreedsPerSpecies[772] = false
    BPBID_Arrays.BreedsPerSpecies[773] = false
    BPBID_Arrays.BreedsPerSpecies[774] = false
    BPBID_Arrays.BreedsPerSpecies[775] = false
    BPBID_Arrays.BreedsPerSpecies[776] = false
    BPBID_Arrays.BreedsPerSpecies[777] = false
    BPBID_Arrays.BreedsPerSpecies[778] = false
    BPBID_Arrays.BreedsPerSpecies[779] = false
    BPBID_Arrays.BreedsPerSpecies[780] = false
    BPBID_Arrays.BreedsPerSpecies[781] = false
    BPBID_Arrays.BreedsPerSpecies[782] = false
    BPBID_Arrays.BreedsPerSpecies[783] = false
    BPBID_Arrays.BreedsPerSpecies[784] = false
    BPBID_Arrays.BreedsPerSpecies[785] = false
    BPBID_Arrays.BreedsPerSpecies[786] = false
    BPBID_Arrays.BreedsPerSpecies[787] = false
    BPBID_Arrays.BreedsPerSpecies[788] = false
    BPBID_Arrays.BreedsPerSpecies[789] = false
    BPBID_Arrays.BreedsPerSpecies[790] = false
    BPBID_Arrays.BreedsPerSpecies[791] = false
    BPBID_Arrays.BreedsPerSpecies[792] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[793] = false
    BPBID_Arrays.BreedsPerSpecies[794] = false
    BPBID_Arrays.BreedsPerSpecies[795] = false
    BPBID_Arrays.BreedsPerSpecies[796] = false
    BPBID_Arrays.BreedsPerSpecies[797] = false
    BPBID_Arrays.BreedsPerSpecies[798] = false
    BPBID_Arrays.BreedsPerSpecies[799] = false
    BPBID_Arrays.BreedsPerSpecies[800] = false
    BPBID_Arrays.BreedsPerSpecies[801] = false
    BPBID_Arrays.BreedsPerSpecies[802] = {4}
    BPBID_Arrays.BreedsPerSpecies[803] = false
    BPBID_Arrays.BreedsPerSpecies[804] = false
    BPBID_Arrays.BreedsPerSpecies[805] = false
    BPBID_Arrays.BreedsPerSpecies[806] = false
    BPBID_Arrays.BreedsPerSpecies[807] = false
    BPBID_Arrays.BreedsPerSpecies[808] = false
    BPBID_Arrays.BreedsPerSpecies[809] = false
    BPBID_Arrays.BreedsPerSpecies[810] = false
    BPBID_Arrays.BreedsPerSpecies[811] = false
    BPBID_Arrays.BreedsPerSpecies[812] = false
    BPBID_Arrays.BreedsPerSpecies[813] = false
    BPBID_Arrays.BreedsPerSpecies[814] = false
    BPBID_Arrays.BreedsPerSpecies[815] = false
    BPBID_Arrays.BreedsPerSpecies[816] = false
    BPBID_Arrays.BreedsPerSpecies[817] = {7}
    BPBID_Arrays.BreedsPerSpecies[818] = {8}
    BPBID_Arrays.BreedsPerSpecies[819] = {5}
    BPBID_Arrays.BreedsPerSpecies[820] = {12}
    BPBID_Arrays.BreedsPerSpecies[821] = {11}
    BPBID_Arrays.BreedsPerSpecies[822] = false
    BPBID_Arrays.BreedsPerSpecies[823] = {3, 5, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[824] = false
    BPBID_Arrays.BreedsPerSpecies[825] = false
    BPBID_Arrays.BreedsPerSpecies[826] = false
    BPBID_Arrays.BreedsPerSpecies[827] = false
    BPBID_Arrays.BreedsPerSpecies[828] = false
    BPBID_Arrays.BreedsPerSpecies[829] = false
    BPBID_Arrays.BreedsPerSpecies[830] = false
    BPBID_Arrays.BreedsPerSpecies[831] = false
    BPBID_Arrays.BreedsPerSpecies[832] = false
    BPBID_Arrays.BreedsPerSpecies[833] = false
    BPBID_Arrays.BreedsPerSpecies[834] = {7}
    BPBID_Arrays.BreedsPerSpecies[835] = {5}
    BPBID_Arrays.BreedsPerSpecies[836] = {5}
    BPBID_Arrays.BreedsPerSpecies[837] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[838] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[839] = false
    BPBID_Arrays.BreedsPerSpecies[840] = false
    BPBID_Arrays.BreedsPerSpecies[841] = false
    BPBID_Arrays.BreedsPerSpecies[842] = false
    BPBID_Arrays.BreedsPerSpecies[843] = false
    BPBID_Arrays.BreedsPerSpecies[844] = {5}
    BPBID_Arrays.BreedsPerSpecies[845] = {3, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[846] = {5}
    BPBID_Arrays.BreedsPerSpecies[847] = {12}
    BPBID_Arrays.BreedsPerSpecies[848] = {3, 5, 9}
    BPBID_Arrays.BreedsPerSpecies[849] = {3}
    BPBID_Arrays.BreedsPerSpecies[850] = {3}
    BPBID_Arrays.BreedsPerSpecies[851] = {3, 5, 7}
    BPBID_Arrays.BreedsPerSpecies[852] = false
    BPBID_Arrays.BreedsPerSpecies[853] = false
    BPBID_Arrays.BreedsPerSpecies[854] = false
    BPBID_Arrays.BreedsPerSpecies[855] = {3}
    BPBID_Arrays.BreedsPerSpecies[856] = {9, 12}
    BPBID_Arrays.BreedsPerSpecies[857] = false
    BPBID_Arrays.BreedsPerSpecies[858] = false
    BPBID_Arrays.BreedsPerSpecies[859] = false
    BPBID_Arrays.BreedsPerSpecies[860] = false
    BPBID_Arrays.BreedsPerSpecies[861] = false
    BPBID_Arrays.BreedsPerSpecies[862] = false
    BPBID_Arrays.BreedsPerSpecies[863] = false
    BPBID_Arrays.BreedsPerSpecies[864] = false
    BPBID_Arrays.BreedsPerSpecies[865] = false
    BPBID_Arrays.BreedsPerSpecies[866] = false
    BPBID_Arrays.BreedsPerSpecies[867] = false
    BPBID_Arrays.BreedsPerSpecies[868] = {9}
    BPBID_Arrays.BreedsPerSpecies[869] = false
    BPBID_Arrays.BreedsPerSpecies[870] = false
    BPBID_Arrays.BreedsPerSpecies[871] = false
    BPBID_Arrays.BreedsPerSpecies[872] = {3}
    BPBID_Arrays.BreedsPerSpecies[873] = {3}
    BPBID_Arrays.BreedsPerSpecies[874] = {3}
    BPBID_Arrays.BreedsPerSpecies[875] = {8}
    BPBID_Arrays.BreedsPerSpecies[876] = {7}
    BPBID_Arrays.BreedsPerSpecies[877] = {9}
    BPBID_Arrays.BreedsPerSpecies[878] = {3}
    BPBID_Arrays.BreedsPerSpecies[879] = {7}
    BPBID_Arrays.BreedsPerSpecies[880] = {7}
    BPBID_Arrays.BreedsPerSpecies[881] = {8}
    BPBID_Arrays.BreedsPerSpecies[882] = {9}
    BPBID_Arrays.BreedsPerSpecies[883] = {6}
    BPBID_Arrays.BreedsPerSpecies[884] = {8}
    BPBID_Arrays.BreedsPerSpecies[885] = {8}
    BPBID_Arrays.BreedsPerSpecies[886] = {9}
    BPBID_Arrays.BreedsPerSpecies[887] = {8}
    BPBID_Arrays.BreedsPerSpecies[888] = {3}
    BPBID_Arrays.BreedsPerSpecies[889] = {3}
    BPBID_Arrays.BreedsPerSpecies[890] = {3}
    BPBID_Arrays.BreedsPerSpecies[891] = {5}
    BPBID_Arrays.BreedsPerSpecies[892] = {8}
    BPBID_Arrays.BreedsPerSpecies[893] = {3}
    BPBID_Arrays.BreedsPerSpecies[894] = {5}
    BPBID_Arrays.BreedsPerSpecies[895] = {8}
    BPBID_Arrays.BreedsPerSpecies[896] = {6}
    BPBID_Arrays.BreedsPerSpecies[897] = {9}
    BPBID_Arrays.BreedsPerSpecies[898] = {3}
    BPBID_Arrays.BreedsPerSpecies[899] = {8}
    BPBID_Arrays.BreedsPerSpecies[900] = {6}
    BPBID_Arrays.BreedsPerSpecies[901] = {6}
    BPBID_Arrays.BreedsPerSpecies[902] = {9}
    BPBID_Arrays.BreedsPerSpecies[903] = {10}
    BPBID_Arrays.BreedsPerSpecies[904] = {9}
    BPBID_Arrays.BreedsPerSpecies[905] = {8}
    BPBID_Arrays.BreedsPerSpecies[906] = {5}
    BPBID_Arrays.BreedsPerSpecies[907] = {9}
    BPBID_Arrays.BreedsPerSpecies[908] = {8}
    BPBID_Arrays.BreedsPerSpecies[909] = {5}
    BPBID_Arrays.BreedsPerSpecies[910] = false
    BPBID_Arrays.BreedsPerSpecies[911] = {7}
    BPBID_Arrays.BreedsPerSpecies[912] = {4}
    BPBID_Arrays.BreedsPerSpecies[913] = {8}
    BPBID_Arrays.BreedsPerSpecies[914] = false
    BPBID_Arrays.BreedsPerSpecies[915] = {7}
    BPBID_Arrays.BreedsPerSpecies[916] = {8}
    BPBID_Arrays.BreedsPerSpecies[917] = {6}
    BPBID_Arrays.BreedsPerSpecies[918] = false
    BPBID_Arrays.BreedsPerSpecies[919] = false
    BPBID_Arrays.BreedsPerSpecies[920] = false
    BPBID_Arrays.BreedsPerSpecies[921] = {7}
    BPBID_Arrays.BreedsPerSpecies[922] = {4}
    BPBID_Arrays.BreedsPerSpecies[923] = {6}
    BPBID_Arrays.BreedsPerSpecies[924] = {9}
    BPBID_Arrays.BreedsPerSpecies[925] = {7}
    BPBID_Arrays.BreedsPerSpecies[926] = {8}
    BPBID_Arrays.BreedsPerSpecies[927] = {5}
    BPBID_Arrays.BreedsPerSpecies[928] = {8}
    BPBID_Arrays.BreedsPerSpecies[929] = {9}
    BPBID_Arrays.BreedsPerSpecies[930] = false
    BPBID_Arrays.BreedsPerSpecies[931] = {9}
    BPBID_Arrays.BreedsPerSpecies[932] = {6}
    BPBID_Arrays.BreedsPerSpecies[933] = {5}
    BPBID_Arrays.BreedsPerSpecies[934] = {6}
    BPBID_Arrays.BreedsPerSpecies[935] = {8}
    BPBID_Arrays.BreedsPerSpecies[936] = {3}
    BPBID_Arrays.BreedsPerSpecies[937] = {8}
    BPBID_Arrays.BreedsPerSpecies[938] = {9}
    BPBID_Arrays.BreedsPerSpecies[939] = {7}
    BPBID_Arrays.BreedsPerSpecies[940] = false
    BPBID_Arrays.BreedsPerSpecies[941] = {8}
    BPBID_Arrays.BreedsPerSpecies[942] = {6}
    BPBID_Arrays.BreedsPerSpecies[943] = {9}
    BPBID_Arrays.BreedsPerSpecies[944] = {6}
    BPBID_Arrays.BreedsPerSpecies[945] = {7}
    BPBID_Arrays.BreedsPerSpecies[946] = {5}
    BPBID_Arrays.BreedsPerSpecies[947] = {9}
    BPBID_Arrays.BreedsPerSpecies[948] = {5}
    BPBID_Arrays.BreedsPerSpecies[949] = {8}
    BPBID_Arrays.BreedsPerSpecies[950] = {6}
    BPBID_Arrays.BreedsPerSpecies[951] = {7}
    BPBID_Arrays.BreedsPerSpecies[952] = {7}
    BPBID_Arrays.BreedsPerSpecies[953] = {6}
    BPBID_Arrays.BreedsPerSpecies[954] = {3}
    BPBID_Arrays.BreedsPerSpecies[955] = {5}
    BPBID_Arrays.BreedsPerSpecies[956] = {6}
    BPBID_Arrays.BreedsPerSpecies[957] = {8}
    BPBID_Arrays.BreedsPerSpecies[958] = {3}
    BPBID_Arrays.BreedsPerSpecies[959] = {8}
    BPBID_Arrays.BreedsPerSpecies[960] = {4}
    BPBID_Arrays.BreedsPerSpecies[961] = {4}
    BPBID_Arrays.BreedsPerSpecies[962] = {8}
    BPBID_Arrays.BreedsPerSpecies[963] = {7}
    BPBID_Arrays.BreedsPerSpecies[964] = {3}
    BPBID_Arrays.BreedsPerSpecies[965] = {3}
    BPBID_Arrays.BreedsPerSpecies[966] = {9}
    BPBID_Arrays.BreedsPerSpecies[967] = {8}
    BPBID_Arrays.BreedsPerSpecies[968] = {7}
    BPBID_Arrays.BreedsPerSpecies[969] = {9}
    BPBID_Arrays.BreedsPerSpecies[970] = {8}
    BPBID_Arrays.BreedsPerSpecies[971] = {7}
    BPBID_Arrays.BreedsPerSpecies[972] = {9}
    BPBID_Arrays.BreedsPerSpecies[973] = {8}
    BPBID_Arrays.BreedsPerSpecies[974] = {8}
    BPBID_Arrays.BreedsPerSpecies[975] = {6}
    BPBID_Arrays.BreedsPerSpecies[976] = {7}
    BPBID_Arrays.BreedsPerSpecies[977] = {9}
    BPBID_Arrays.BreedsPerSpecies[978] = {8}
    BPBID_Arrays.BreedsPerSpecies[979] = {6}
    BPBID_Arrays.BreedsPerSpecies[980] = {6}
    BPBID_Arrays.BreedsPerSpecies[981] = {8}
    BPBID_Arrays.BreedsPerSpecies[982] = {5}
    BPBID_Arrays.BreedsPerSpecies[983] = {6}
    BPBID_Arrays.BreedsPerSpecies[984] = {9}
    BPBID_Arrays.BreedsPerSpecies[985] = {7}
    BPBID_Arrays.BreedsPerSpecies[986] = {4}
    BPBID_Arrays.BreedsPerSpecies[987] = {9}
    BPBID_Arrays.BreedsPerSpecies[988] = {8}
    BPBID_Arrays.BreedsPerSpecies[989] = {9}
    BPBID_Arrays.BreedsPerSpecies[990] = {5}
    BPBID_Arrays.BreedsPerSpecies[991] = {8}
    BPBID_Arrays.BreedsPerSpecies[992] = {6}
    BPBID_Arrays.BreedsPerSpecies[993] = {5}
    BPBID_Arrays.BreedsPerSpecies[994] = {8}
    BPBID_Arrays.BreedsPerSpecies[995] = {9}
    BPBID_Arrays.BreedsPerSpecies[996] = {6}
    BPBID_Arrays.BreedsPerSpecies[997] = {7}
    BPBID_Arrays.BreedsPerSpecies[998] = {9}
    BPBID_Arrays.BreedsPerSpecies[999] = {6}
    BPBID_Arrays.BreedsPerSpecies[1000] = {8}
    BPBID_Arrays.BreedsPerSpecies[1001] = {8}
    BPBID_Arrays.BreedsPerSpecies[1002] = {9}
    BPBID_Arrays.BreedsPerSpecies[1003] = {9}
    BPBID_Arrays.BreedsPerSpecies[1004] = {9}
    BPBID_Arrays.BreedsPerSpecies[1005] = {9}
    BPBID_Arrays.BreedsPerSpecies[1006] = {6}
    BPBID_Arrays.BreedsPerSpecies[1007] = {4}
    BPBID_Arrays.BreedsPerSpecies[1008] = {6}
    BPBID_Arrays.BreedsPerSpecies[1009] = {7}
    BPBID_Arrays.BreedsPerSpecies[1010] = {8}
    BPBID_Arrays.BreedsPerSpecies[1011] = {7}
    BPBID_Arrays.BreedsPerSpecies[1012] = {5}
    BPBID_Arrays.BreedsPerSpecies[1013] = {3, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[1014] = false
    BPBID_Arrays.BreedsPerSpecies[1015] = false
    BPBID_Arrays.BreedsPerSpecies[1016] = false
    BPBID_Arrays.BreedsPerSpecies[1017] = false
    BPBID_Arrays.BreedsPerSpecies[1018] = false
    BPBID_Arrays.BreedsPerSpecies[1019] = false
    BPBID_Arrays.BreedsPerSpecies[1020] = false
    BPBID_Arrays.BreedsPerSpecies[1021] = false
    BPBID_Arrays.BreedsPerSpecies[1022] = false
    BPBID_Arrays.BreedsPerSpecies[1023] = false
    BPBID_Arrays.BreedsPerSpecies[1024] = false
    BPBID_Arrays.BreedsPerSpecies[1025] = false
    BPBID_Arrays.BreedsPerSpecies[1026] = false
    BPBID_Arrays.BreedsPerSpecies[1027] = false
    BPBID_Arrays.BreedsPerSpecies[1028] = false
    BPBID_Arrays.BreedsPerSpecies[1029] = false
    BPBID_Arrays.BreedsPerSpecies[1030] = false
    BPBID_Arrays.BreedsPerSpecies[1031] = false
    BPBID_Arrays.BreedsPerSpecies[1032] = false
    BPBID_Arrays.BreedsPerSpecies[1033] = false
    BPBID_Arrays.BreedsPerSpecies[1034] = false
    BPBID_Arrays.BreedsPerSpecies[1035] = false
    BPBID_Arrays.BreedsPerSpecies[1036] = false
    BPBID_Arrays.BreedsPerSpecies[1037] = false
    BPBID_Arrays.BreedsPerSpecies[1038] = false
    BPBID_Arrays.BreedsPerSpecies[1039] = {6}
    BPBID_Arrays.BreedsPerSpecies[1040] = {6}
    BPBID_Arrays.BreedsPerSpecies[1041] = false
    BPBID_Arrays.BreedsPerSpecies[1042] = {8}
    BPBID_Arrays.BreedsPerSpecies[1043] = false
    BPBID_Arrays.BreedsPerSpecies[1044] = false
    BPBID_Arrays.BreedsPerSpecies[1045] = false
    BPBID_Arrays.BreedsPerSpecies[1046] = false
    BPBID_Arrays.BreedsPerSpecies[1047] = false
    BPBID_Arrays.BreedsPerSpecies[1048] = false
    BPBID_Arrays.BreedsPerSpecies[1049] = false
    BPBID_Arrays.BreedsPerSpecies[1050] = false
    BPBID_Arrays.BreedsPerSpecies[1051] = false
    BPBID_Arrays.BreedsPerSpecies[1052] = false
    BPBID_Arrays.BreedsPerSpecies[1053] = false
    BPBID_Arrays.BreedsPerSpecies[1054] = false
    BPBID_Arrays.BreedsPerSpecies[1055] = false
    BPBID_Arrays.BreedsPerSpecies[1056] = false
    BPBID_Arrays.BreedsPerSpecies[1057] = false
    BPBID_Arrays.BreedsPerSpecies[1058] = false
    BPBID_Arrays.BreedsPerSpecies[1059] = false
    BPBID_Arrays.BreedsPerSpecies[1060] = false
    BPBID_Arrays.BreedsPerSpecies[1061] = {5}
    BPBID_Arrays.BreedsPerSpecies[1062] = {3, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1063] = {8}
    BPBID_Arrays.BreedsPerSpecies[1064] = false
    BPBID_Arrays.BreedsPerSpecies[1065] = {8}
    BPBID_Arrays.BreedsPerSpecies[1066] = {10}
    BPBID_Arrays.BreedsPerSpecies[1067] = {7}
    BPBID_Arrays.BreedsPerSpecies[1068] = {3, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1069] = false
    BPBID_Arrays.BreedsPerSpecies[1070] = false
    BPBID_Arrays.BreedsPerSpecies[1071] = false
    BPBID_Arrays.BreedsPerSpecies[1072] = false
    BPBID_Arrays.BreedsPerSpecies[1073] = {12}
    BPBID_Arrays.BreedsPerSpecies[1074] = false
    BPBID_Arrays.BreedsPerSpecies[1075] = false
    BPBID_Arrays.BreedsPerSpecies[1076] = false
    BPBID_Arrays.BreedsPerSpecies[1077] = false
    BPBID_Arrays.BreedsPerSpecies[1078] = false
    BPBID_Arrays.BreedsPerSpecies[1079] = false
    BPBID_Arrays.BreedsPerSpecies[1080] = false
    BPBID_Arrays.BreedsPerSpecies[1081] = false
    BPBID_Arrays.BreedsPerSpecies[1082] = false
    BPBID_Arrays.BreedsPerSpecies[1083] = false
    BPBID_Arrays.BreedsPerSpecies[1084] = false
    BPBID_Arrays.BreedsPerSpecies[1085] = false
    BPBID_Arrays.BreedsPerSpecies[1086] = false
    BPBID_Arrays.BreedsPerSpecies[1087] = false
    BPBID_Arrays.BreedsPerSpecies[1088] = false
    BPBID_Arrays.BreedsPerSpecies[1089] = false
    BPBID_Arrays.BreedsPerSpecies[1090] = false
    BPBID_Arrays.BreedsPerSpecies[1091] = false
    BPBID_Arrays.BreedsPerSpecies[1092] = false
    BPBID_Arrays.BreedsPerSpecies[1093] = false
    BPBID_Arrays.BreedsPerSpecies[1094] = false
    BPBID_Arrays.BreedsPerSpecies[1095] = false
    BPBID_Arrays.BreedsPerSpecies[1096] = false
    BPBID_Arrays.BreedsPerSpecies[1097] = false
    BPBID_Arrays.BreedsPerSpecies[1098] = false
    BPBID_Arrays.BreedsPerSpecies[1099] = false
    BPBID_Arrays.BreedsPerSpecies[1100] = false
    BPBID_Arrays.BreedsPerSpecies[1101] = false
    BPBID_Arrays.BreedsPerSpecies[1102] = false
    BPBID_Arrays.BreedsPerSpecies[1103] = false
    BPBID_Arrays.BreedsPerSpecies[1104] = false
    BPBID_Arrays.BreedsPerSpecies[1105] = false
    BPBID_Arrays.BreedsPerSpecies[1106] = false
    BPBID_Arrays.BreedsPerSpecies[1107] = false
    BPBID_Arrays.BreedsPerSpecies[1108] = false
    BPBID_Arrays.BreedsPerSpecies[1109] = false
    BPBID_Arrays.BreedsPerSpecies[1110] = false
    BPBID_Arrays.BreedsPerSpecies[1111] = false
    BPBID_Arrays.BreedsPerSpecies[1112] = false
    BPBID_Arrays.BreedsPerSpecies[1113] = false
    BPBID_Arrays.BreedsPerSpecies[1114] = false
    BPBID_Arrays.BreedsPerSpecies[1115] = false
    BPBID_Arrays.BreedsPerSpecies[1116] = false
    BPBID_Arrays.BreedsPerSpecies[1117] = {3}
    BPBID_Arrays.BreedsPerSpecies[1118] = false
    BPBID_Arrays.BreedsPerSpecies[1119] = false
    BPBID_Arrays.BreedsPerSpecies[1120] = false
    BPBID_Arrays.BreedsPerSpecies[1121] = false
    BPBID_Arrays.BreedsPerSpecies[1122] = false
    BPBID_Arrays.BreedsPerSpecies[1123] = false
    BPBID_Arrays.BreedsPerSpecies[1124] = {8}
    BPBID_Arrays.BreedsPerSpecies[1125] = {3}
    BPBID_Arrays.BreedsPerSpecies[1126] = {7}
    BPBID_Arrays.BreedsPerSpecies[1127] = {8}
    BPBID_Arrays.BreedsPerSpecies[1128] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[1129] = {7}
    BPBID_Arrays.BreedsPerSpecies[1130] = {8}
    BPBID_Arrays.BreedsPerSpecies[1131] = {11}
    BPBID_Arrays.BreedsPerSpecies[1132] = {5}
    BPBID_Arrays.BreedsPerSpecies[1133] = {10}
    BPBID_Arrays.BreedsPerSpecies[1134] = {9}
    BPBID_Arrays.BreedsPerSpecies[1135] = {12}
    BPBID_Arrays.BreedsPerSpecies[1136] = {3}
    BPBID_Arrays.BreedsPerSpecies[1137] = {6}
    BPBID_Arrays.BreedsPerSpecies[1138] = {9}
    BPBID_Arrays.BreedsPerSpecies[1139] = {8}
    BPBID_Arrays.BreedsPerSpecies[1140] = {3}
    BPBID_Arrays.BreedsPerSpecies[1141] = {7}
    BPBID_Arrays.BreedsPerSpecies[1142] = {11}
    BPBID_Arrays.BreedsPerSpecies[1143] = {8}
    BPBID_Arrays.BreedsPerSpecies[1144] = {9}
    BPBID_Arrays.BreedsPerSpecies[1145] = {5}
    BPBID_Arrays.BreedsPerSpecies[1146] = {7}
    BPBID_Arrays.BreedsPerSpecies[1147] = {4}
    BPBID_Arrays.BreedsPerSpecies[1148] = false
    BPBID_Arrays.BreedsPerSpecies[1149] = {8}
    BPBID_Arrays.BreedsPerSpecies[1150] = {9}
    BPBID_Arrays.BreedsPerSpecies[1151] = {7}
    BPBID_Arrays.BreedsPerSpecies[1152] = {6}
    BPBID_Arrays.BreedsPerSpecies[1153] = {4}
    BPBID_Arrays.BreedsPerSpecies[1154] = {9}
    BPBID_Arrays.BreedsPerSpecies[1155] = {6}
    BPBID_Arrays.BreedsPerSpecies[1156] = {8}
    BPBID_Arrays.BreedsPerSpecies[1157] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[1158] = {12}
    BPBID_Arrays.BreedsPerSpecies[1159] = {12}
    BPBID_Arrays.BreedsPerSpecies[1160] = {8}
    BPBID_Arrays.BreedsPerSpecies[1161] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1162] = {5, 8}
    BPBID_Arrays.BreedsPerSpecies[1163] = {6, 7}
    BPBID_Arrays.BreedsPerSpecies[1164] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[1165] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1166] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1167] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1168] = {12}
    BPBID_Arrays.BreedsPerSpecies[1169] = false
    BPBID_Arrays.BreedsPerSpecies[1170] = false
    BPBID_Arrays.BreedsPerSpecies[1171] = false
    BPBID_Arrays.BreedsPerSpecies[1172] = false
    BPBID_Arrays.BreedsPerSpecies[1173] = false
    BPBID_Arrays.BreedsPerSpecies[1174] = {12}
    BPBID_Arrays.BreedsPerSpecies[1175] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[1176] = {3}
    BPBID_Arrays.BreedsPerSpecies[1177] = {6, 7, 9, 10}
    BPBID_Arrays.BreedsPerSpecies[1178] = {4}
    BPBID_Arrays.BreedsPerSpecies[1179] = {3}
    BPBID_Arrays.BreedsPerSpecies[1180] = {4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1181] = {6, 9}
    BPBID_Arrays.BreedsPerSpecies[1182] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[1183] = {4}
    BPBID_Arrays.BreedsPerSpecies[1184] = {4}
    BPBID_Arrays.BreedsPerSpecies[1185] = {9}
    BPBID_Arrays.BreedsPerSpecies[1186] = false
    BPBID_Arrays.BreedsPerSpecies[1187] = {4}
    BPBID_Arrays.BreedsPerSpecies[1188] = {3}
    BPBID_Arrays.BreedsPerSpecies[1189] = {9}
    BPBID_Arrays.BreedsPerSpecies[1190] = {11}
    BPBID_Arrays.BreedsPerSpecies[1191] = {6}
    BPBID_Arrays.BreedsPerSpecies[1192] = {10}
    BPBID_Arrays.BreedsPerSpecies[1193] = {12}
    BPBID_Arrays.BreedsPerSpecies[1194] = {8}
    BPBID_Arrays.BreedsPerSpecies[1195] = {5}
    BPBID_Arrays.BreedsPerSpecies[1196] = {9}
    BPBID_Arrays.BreedsPerSpecies[1197] = {7}
    BPBID_Arrays.BreedsPerSpecies[1198] = {8}
    BPBID_Arrays.BreedsPerSpecies[1199] = false
    BPBID_Arrays.BreedsPerSpecies[1200] = {8}
    BPBID_Arrays.BreedsPerSpecies[1201] = {10}
    BPBID_Arrays.BreedsPerSpecies[1202] = {3, 10}
    BPBID_Arrays.BreedsPerSpecies[1203] = false
    BPBID_Arrays.BreedsPerSpecies[1204] = {11}
    BPBID_Arrays.BreedsPerSpecies[1205] = {3, 6, 7, 9, 10}
    BPBID_Arrays.BreedsPerSpecies[1206] = {10}
    BPBID_Arrays.BreedsPerSpecies[1207] = {12}
    BPBID_Arrays.BreedsPerSpecies[1208] = {11}
    BPBID_Arrays.BreedsPerSpecies[1209] = {3}
    BPBID_Arrays.BreedsPerSpecies[1210] = false
    BPBID_Arrays.BreedsPerSpecies[1211] = {4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1212] = {4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1213] = {4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1214] = false
    BPBID_Arrays.BreedsPerSpecies[1215] = false
    BPBID_Arrays.BreedsPerSpecies[1216] = false
    BPBID_Arrays.BreedsPerSpecies[1217] = false
    BPBID_Arrays.BreedsPerSpecies[1218] = false
    BPBID_Arrays.BreedsPerSpecies[1219] = false
    BPBID_Arrays.BreedsPerSpecies[1220] = false
    BPBID_Arrays.BreedsPerSpecies[1221] = false
    BPBID_Arrays.BreedsPerSpecies[1222] = false
    BPBID_Arrays.BreedsPerSpecies[1223] = false
    BPBID_Arrays.BreedsPerSpecies[1224] = false
    BPBID_Arrays.BreedsPerSpecies[1225] = false
    BPBID_Arrays.BreedsPerSpecies[1226] = {3, 4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1227] = {6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[1228] = {4, 6, 8}
    BPBID_Arrays.BreedsPerSpecies[1229] = {5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1230] = {6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[1231] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1232] = {3, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1233] = {4, 6, 7, 8}
    BPBID_Arrays.BreedsPerSpecies[1234] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[1235] = {5, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1236] = {8}
    BPBID_Arrays.BreedsPerSpecies[1237] = {8}
    BPBID_Arrays.BreedsPerSpecies[1238] = {3, 6}
    BPBID_Arrays.BreedsPerSpecies[1239] = false
    BPBID_Arrays.BreedsPerSpecies[1240] = false
    BPBID_Arrays.BreedsPerSpecies[1241] = false
    BPBID_Arrays.BreedsPerSpecies[1242] = false
    BPBID_Arrays.BreedsPerSpecies[1243] = {8}
    BPBID_Arrays.BreedsPerSpecies[1244] = {7}
    BPBID_Arrays.BreedsPerSpecies[1245] = {3, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[1246] = false
    BPBID_Arrays.BreedsPerSpecies[1247] = {8}
    BPBID_Arrays.BreedsPerSpecies[1248] = {3}
    BPBID_Arrays.BreedsPerSpecies[1249] = false
    BPBID_Arrays.BreedsPerSpecies[1250] = false
    BPBID_Arrays.BreedsPerSpecies[1251] = false
    BPBID_Arrays.BreedsPerSpecies[1252] = false
    BPBID_Arrays.BreedsPerSpecies[1253] = false
    BPBID_Arrays.BreedsPerSpecies[1254] = false
    BPBID_Arrays.BreedsPerSpecies[1255] = {7}
    BPBID_Arrays.BreedsPerSpecies[1256] = {10, 11}
    BPBID_Arrays.BreedsPerSpecies[1257] = {3}
    BPBID_Arrays.BreedsPerSpecies[1258] = {8}
    BPBID_Arrays.BreedsPerSpecies[1259] = {6}
    BPBID_Arrays.BreedsPerSpecies[1260] = false
    BPBID_Arrays.BreedsPerSpecies[1261] = false
    BPBID_Arrays.BreedsPerSpecies[1262] = false
    BPBID_Arrays.BreedsPerSpecies[1263] = false
    BPBID_Arrays.BreedsPerSpecies[1264] = false
    BPBID_Arrays.BreedsPerSpecies[1265] = false
    BPBID_Arrays.BreedsPerSpecies[1266] = {4}
    BPBID_Arrays.BreedsPerSpecies[1267] = {8}
    BPBID_Arrays.BreedsPerSpecies[1268] = {6}
    BPBID_Arrays.BreedsPerSpecies[1269] = {4}
    BPBID_Arrays.BreedsPerSpecies[1270] = false
    BPBID_Arrays.BreedsPerSpecies[1271] = {3}
    BPBID_Arrays.BreedsPerSpecies[1272] = false
    BPBID_Arrays.BreedsPerSpecies[1273] = false
    BPBID_Arrays.BreedsPerSpecies[1274] = false
    BPBID_Arrays.BreedsPerSpecies[1275] = false
    BPBID_Arrays.BreedsPerSpecies[1276] = {4, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[1277] = {5}
    BPBID_Arrays.BreedsPerSpecies[1278] = {4}
    BPBID_Arrays.BreedsPerSpecies[1279] = {6}
    BPBID_Arrays.BreedsPerSpecies[1280] = {6}
    BPBID_Arrays.BreedsPerSpecies[1281] = {5}
    BPBID_Arrays.BreedsPerSpecies[1282] = {8}
    BPBID_Arrays.BreedsPerSpecies[1283] = {4}
    BPBID_Arrays.BreedsPerSpecies[1284] = {6}
    BPBID_Arrays.BreedsPerSpecies[1285] = {5}
    BPBID_Arrays.BreedsPerSpecies[1286] = {5}
    BPBID_Arrays.BreedsPerSpecies[1287] = {4}
    BPBID_Arrays.BreedsPerSpecies[1288] = {6}
    BPBID_Arrays.BreedsPerSpecies[1289] = {4}
    BPBID_Arrays.BreedsPerSpecies[1290] = {3}
    BPBID_Arrays.BreedsPerSpecies[1291] = {3}
    BPBID_Arrays.BreedsPerSpecies[1292] = {7}
    BPBID_Arrays.BreedsPerSpecies[1293] = {3}
    BPBID_Arrays.BreedsPerSpecies[1294] = false
    BPBID_Arrays.BreedsPerSpecies[1295] = {3}
    BPBID_Arrays.BreedsPerSpecies[1296] = {6}
    BPBID_Arrays.BreedsPerSpecies[1297] = {5}
    BPBID_Arrays.BreedsPerSpecies[1298] = {4}
    BPBID_Arrays.BreedsPerSpecies[1299] = {5}
    BPBID_Arrays.BreedsPerSpecies[1300] = {4}
    BPBID_Arrays.BreedsPerSpecies[1301] = {6}
    BPBID_Arrays.BreedsPerSpecies[1302] = false
    BPBID_Arrays.BreedsPerSpecies[1303] = {8}
    BPBID_Arrays.BreedsPerSpecies[1304] = {8}
    BPBID_Arrays.BreedsPerSpecies[1305] = {8}
    BPBID_Arrays.BreedsPerSpecies[1306] = false
    BPBID_Arrays.BreedsPerSpecies[1307] = false
    BPBID_Arrays.BreedsPerSpecies[1308] = false
    BPBID_Arrays.BreedsPerSpecies[1309] = false
    BPBID_Arrays.BreedsPerSpecies[1310] = false
    BPBID_Arrays.BreedsPerSpecies[1311] = {8}
    BPBID_Arrays.BreedsPerSpecies[1312] = false
    BPBID_Arrays.BreedsPerSpecies[1313] = false
    BPBID_Arrays.BreedsPerSpecies[1314] = false
    BPBID_Arrays.BreedsPerSpecies[1315] = false
    BPBID_Arrays.BreedsPerSpecies[1316] = false
    BPBID_Arrays.BreedsPerSpecies[1317] = {8}
    BPBID_Arrays.BreedsPerSpecies[1318] = false
    BPBID_Arrays.BreedsPerSpecies[1319] = {6}
    BPBID_Arrays.BreedsPerSpecies[1320] = {5}
    BPBID_Arrays.BreedsPerSpecies[1321] = {4, 5, 7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1322] = {4, 6, 7}
    BPBID_Arrays.BreedsPerSpecies[1323] = {3, 4, 5, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[1324] = {3, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[1325] = {3, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[1326] = {3, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[1327] = false
    BPBID_Arrays.BreedsPerSpecies[1328] = {3, 6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[1329] = {5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[1330] = {3, 4, 5, 6, 8}
    BPBID_Arrays.BreedsPerSpecies[1331] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1332] = {4, 5, 6}
    BPBID_Arrays.BreedsPerSpecies[1333] = {3, 5, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[1334] = {6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[1335] = {8}
    BPBID_Arrays.BreedsPerSpecies[1336] = {3, 6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[1337] = {4, 6}
    BPBID_Arrays.BreedsPerSpecies[1338] = {3, 7, 12}
    BPBID_Arrays.BreedsPerSpecies[1339] = {3}
    BPBID_Arrays.BreedsPerSpecies[1340] = false
    BPBID_Arrays.BreedsPerSpecies[1341] = false
    BPBID_Arrays.BreedsPerSpecies[1342] = false
    BPBID_Arrays.BreedsPerSpecies[1343] = {4, 5, 7, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[1344] = {7}
    BPBID_Arrays.BreedsPerSpecies[1345] = {6, 9}
    BPBID_Arrays.BreedsPerSpecies[1346] = {9}
    BPBID_Arrays.BreedsPerSpecies[1347] = false
    BPBID_Arrays.BreedsPerSpecies[1348] = {8}
    BPBID_Arrays.BreedsPerSpecies[1349] = {4}
    BPBID_Arrays.BreedsPerSpecies[1350] = {3}
    BPBID_Arrays.BreedsPerSpecies[1351] = {7}
    BPBID_Arrays.BreedsPerSpecies[1352] = {6}
    BPBID_Arrays.BreedsPerSpecies[1353] = false
    BPBID_Arrays.BreedsPerSpecies[1354] = {3}
    BPBID_Arrays.BreedsPerSpecies[1355] = false
    BPBID_Arrays.BreedsPerSpecies[1356] = false
    BPBID_Arrays.BreedsPerSpecies[1357] = false
    BPBID_Arrays.BreedsPerSpecies[1358] = false
    BPBID_Arrays.BreedsPerSpecies[1359] = false
    BPBID_Arrays.BreedsPerSpecies[1360] = false
    BPBID_Arrays.BreedsPerSpecies[1361] = false
    BPBID_Arrays.BreedsPerSpecies[1362] = false
    BPBID_Arrays.BreedsPerSpecies[1363] = {8}
    BPBID_Arrays.BreedsPerSpecies[1364] = {4}
    BPBID_Arrays.BreedsPerSpecies[1365] = {9}
    BPBID_Arrays.BreedsPerSpecies[1366] = false
    BPBID_Arrays.BreedsPerSpecies[1367] = false
    BPBID_Arrays.BreedsPerSpecies[1368] = false
    BPBID_Arrays.BreedsPerSpecies[1369] = false
    BPBID_Arrays.BreedsPerSpecies[1370] = false
    BPBID_Arrays.BreedsPerSpecies[1371] = false
    BPBID_Arrays.BreedsPerSpecies[1372] = false
    BPBID_Arrays.BreedsPerSpecies[1373] = false
    BPBID_Arrays.BreedsPerSpecies[1374] = false
    BPBID_Arrays.BreedsPerSpecies[1375] = false
    BPBID_Arrays.BreedsPerSpecies[1376] = false
    BPBID_Arrays.BreedsPerSpecies[1377] = false
    BPBID_Arrays.BreedsPerSpecies[1378] = false
    BPBID_Arrays.BreedsPerSpecies[1379] = false
    BPBID_Arrays.BreedsPerSpecies[1380] = false
    BPBID_Arrays.BreedsPerSpecies[1381] = false
    BPBID_Arrays.BreedsPerSpecies[1382] = false
    BPBID_Arrays.BreedsPerSpecies[1383] = false
    BPBID_Arrays.BreedsPerSpecies[1384] = {7}
    BPBID_Arrays.BreedsPerSpecies[1385] = {3, 4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1386] = {4}
    BPBID_Arrays.BreedsPerSpecies[1387] = {4, 6, 7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1388] = false
    BPBID_Arrays.BreedsPerSpecies[1389] = false
    BPBID_Arrays.BreedsPerSpecies[1390] = false
    BPBID_Arrays.BreedsPerSpecies[1391] = false
    BPBID_Arrays.BreedsPerSpecies[1392] = false
    BPBID_Arrays.BreedsPerSpecies[1393] = false
    BPBID_Arrays.BreedsPerSpecies[1394] = {6}
    BPBID_Arrays.BreedsPerSpecies[1395] = {6}
    BPBID_Arrays.BreedsPerSpecies[1396] = {8}
    BPBID_Arrays.BreedsPerSpecies[1397] = false
    BPBID_Arrays.BreedsPerSpecies[1398] = false
    BPBID_Arrays.BreedsPerSpecies[1399] = false
    BPBID_Arrays.BreedsPerSpecies[1400] = {3}
    BPBID_Arrays.BreedsPerSpecies[1401] = {3}
    BPBID_Arrays.BreedsPerSpecies[1402] = {3}
    BPBID_Arrays.BreedsPerSpecies[1403] = {4, 5, 7, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[1404] = false
    BPBID_Arrays.BreedsPerSpecies[1405] = false
    BPBID_Arrays.BreedsPerSpecies[1406] = false
    BPBID_Arrays.BreedsPerSpecies[1407] = false
    BPBID_Arrays.BreedsPerSpecies[1408] = false
    BPBID_Arrays.BreedsPerSpecies[1409] = {3}
    BPBID_Arrays.BreedsPerSpecies[1410] = false
    BPBID_Arrays.BreedsPerSpecies[1411] = {10}
    BPBID_Arrays.BreedsPerSpecies[1412] = {4, 5, 6}
    BPBID_Arrays.BreedsPerSpecies[1413] = false
    BPBID_Arrays.BreedsPerSpecies[1414] = false
    BPBID_Arrays.BreedsPerSpecies[1415] = false
    BPBID_Arrays.BreedsPerSpecies[1416] = {7}
    BPBID_Arrays.BreedsPerSpecies[1417] = false
    BPBID_Arrays.BreedsPerSpecies[1418] = false
    BPBID_Arrays.BreedsPerSpecies[1419] = false
    BPBID_Arrays.BreedsPerSpecies[1420] = false
    BPBID_Arrays.BreedsPerSpecies[1421] = false
    BPBID_Arrays.BreedsPerSpecies[1422] = false
    BPBID_Arrays.BreedsPerSpecies[1423] = false
    BPBID_Arrays.BreedsPerSpecies[1424] = {11}
    BPBID_Arrays.BreedsPerSpecies[1425] = false
    BPBID_Arrays.BreedsPerSpecies[1426] = {6}
    BPBID_Arrays.BreedsPerSpecies[1427] = {3, 4, 5, 6, 7, 8, 12}
    BPBID_Arrays.BreedsPerSpecies[1428] = {7}
    BPBID_Arrays.BreedsPerSpecies[1429] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1430] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1431] = false
    BPBID_Arrays.BreedsPerSpecies[1432] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1433] = false
    BPBID_Arrays.BreedsPerSpecies[1434] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1435] = {3, 6}
    BPBID_Arrays.BreedsPerSpecies[1436] = false
    BPBID_Arrays.BreedsPerSpecies[1437] = false
    BPBID_Arrays.BreedsPerSpecies[1438] = false
    BPBID_Arrays.BreedsPerSpecies[1439] = false
    BPBID_Arrays.BreedsPerSpecies[1440] = false
    BPBID_Arrays.BreedsPerSpecies[1441] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[1442] = {6}
    BPBID_Arrays.BreedsPerSpecies[1443] = {12}
    BPBID_Arrays.BreedsPerSpecies[1444] = {3}
    BPBID_Arrays.BreedsPerSpecies[1445] = false
    BPBID_Arrays.BreedsPerSpecies[1446] = {10}
    BPBID_Arrays.BreedsPerSpecies[1447] = {4, 6, 7, 8}
    BPBID_Arrays.BreedsPerSpecies[1448] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1449] = {4}
    BPBID_Arrays.BreedsPerSpecies[1450] = {8}
    BPBID_Arrays.BreedsPerSpecies[1451] = {5}
    BPBID_Arrays.BreedsPerSpecies[1452] = false
    BPBID_Arrays.BreedsPerSpecies[1453] = {9}
    BPBID_Arrays.BreedsPerSpecies[1454] = {3}
    BPBID_Arrays.BreedsPerSpecies[1455] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1456] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1457] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1458] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1459] = false
    BPBID_Arrays.BreedsPerSpecies[1460] = false
    BPBID_Arrays.BreedsPerSpecies[1461] = false
    BPBID_Arrays.BreedsPerSpecies[1462] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1463] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1464] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1465] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1466] = {11}
    BPBID_Arrays.BreedsPerSpecies[1467] = {4, 5}
    BPBID_Arrays.BreedsPerSpecies[1468] = {3, 4, 7, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1469] = {3, 4, 7, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1470] = {3, 4, 7, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1471] = {10}
    BPBID_Arrays.BreedsPerSpecies[1472] = {3}
    BPBID_Arrays.BreedsPerSpecies[1473] = {3}
    BPBID_Arrays.BreedsPerSpecies[1474] = {6}
    BPBID_Arrays.BreedsPerSpecies[1475] = {6}
    BPBID_Arrays.BreedsPerSpecies[1476] = {4}
    BPBID_Arrays.BreedsPerSpecies[1477] = {8}
    BPBID_Arrays.BreedsPerSpecies[1478] = {7}
    BPBID_Arrays.BreedsPerSpecies[1479] = {3}
    BPBID_Arrays.BreedsPerSpecies[1480] = {3}
    BPBID_Arrays.BreedsPerSpecies[1481] = false
    BPBID_Arrays.BreedsPerSpecies[1482] = {3}
    BPBID_Arrays.BreedsPerSpecies[1483] = {3}
    BPBID_Arrays.BreedsPerSpecies[1484] = {3}
    BPBID_Arrays.BreedsPerSpecies[1485] = {3}
    BPBID_Arrays.BreedsPerSpecies[1486] = {3}
    BPBID_Arrays.BreedsPerSpecies[1487] = {3}
    BPBID_Arrays.BreedsPerSpecies[1488] = {3}
    BPBID_Arrays.BreedsPerSpecies[1489] = {3}
    BPBID_Arrays.BreedsPerSpecies[1490] = {3}
    BPBID_Arrays.BreedsPerSpecies[1491] = false
    BPBID_Arrays.BreedsPerSpecies[1492] = {3}
    BPBID_Arrays.BreedsPerSpecies[1493] = {3}
    BPBID_Arrays.BreedsPerSpecies[1494] = {3}
    BPBID_Arrays.BreedsPerSpecies[1495] = {3, 4, 5, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[1496] = {3}
    BPBID_Arrays.BreedsPerSpecies[1497] = {3}
    BPBID_Arrays.BreedsPerSpecies[1498] = {3}
    BPBID_Arrays.BreedsPerSpecies[1499] = {3}
    BPBID_Arrays.BreedsPerSpecies[1500] = {3}
    BPBID_Arrays.BreedsPerSpecies[1501] = {3}
    BPBID_Arrays.BreedsPerSpecies[1502] = {3}
    BPBID_Arrays.BreedsPerSpecies[1503] = {3}
    BPBID_Arrays.BreedsPerSpecies[1504] = {3}
    BPBID_Arrays.BreedsPerSpecies[1505] = {3}
    BPBID_Arrays.BreedsPerSpecies[1506] = {3}
    BPBID_Arrays.BreedsPerSpecies[1507] = {3}
    BPBID_Arrays.BreedsPerSpecies[1508] = {3}
    BPBID_Arrays.BreedsPerSpecies[1509] = {3}
    BPBID_Arrays.BreedsPerSpecies[1510] = {3}
    BPBID_Arrays.BreedsPerSpecies[1511] = {5}
    BPBID_Arrays.BreedsPerSpecies[1512] = false
    BPBID_Arrays.BreedsPerSpecies[1513] = false
    BPBID_Arrays.BreedsPerSpecies[1514] = {3}
    BPBID_Arrays.BreedsPerSpecies[1515] = {8}
    BPBID_Arrays.BreedsPerSpecies[1516] = {10}
    BPBID_Arrays.BreedsPerSpecies[1517] = {4}
    BPBID_Arrays.BreedsPerSpecies[1518] = {4}
    BPBID_Arrays.BreedsPerSpecies[1519] = false
    BPBID_Arrays.BreedsPerSpecies[1520] = false
    BPBID_Arrays.BreedsPerSpecies[1521] = {8}
    BPBID_Arrays.BreedsPerSpecies[1522] = false
    BPBID_Arrays.BreedsPerSpecies[1523] = {5}
    BPBID_Arrays.BreedsPerSpecies[1524] = {7, 9}
    BPBID_Arrays.BreedsPerSpecies[1525] = false
    BPBID_Arrays.BreedsPerSpecies[1526] = false
    BPBID_Arrays.BreedsPerSpecies[1527] = false
    BPBID_Arrays.BreedsPerSpecies[1528] = false
    BPBID_Arrays.BreedsPerSpecies[1529] = false
    BPBID_Arrays.BreedsPerSpecies[1530] = {4}
    BPBID_Arrays.BreedsPerSpecies[1531] = {7}
    BPBID_Arrays.BreedsPerSpecies[1532] = {8}
    BPBID_Arrays.BreedsPerSpecies[1533] = {8}
    BPBID_Arrays.BreedsPerSpecies[1534] = false
    BPBID_Arrays.BreedsPerSpecies[1535] = false
    BPBID_Arrays.BreedsPerSpecies[1536] = {3}
    BPBID_Arrays.BreedsPerSpecies[1537] = {6}
    BPBID_Arrays.BreedsPerSpecies[1538] = {5}
    BPBID_Arrays.BreedsPerSpecies[1539] = {4}
    BPBID_Arrays.BreedsPerSpecies[1540] = {8}
    BPBID_Arrays.BreedsPerSpecies[1541] = {10}
    BPBID_Arrays.BreedsPerSpecies[1542] = {8}
    BPBID_Arrays.BreedsPerSpecies[1543] = {7}
    BPBID_Arrays.BreedsPerSpecies[1544] = {10}
    BPBID_Arrays.BreedsPerSpecies[1545] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1546] = {10}
    BPBID_Arrays.BreedsPerSpecies[1547] = {3}
    BPBID_Arrays.BreedsPerSpecies[1548] = {6}
    BPBID_Arrays.BreedsPerSpecies[1549] = {3}
    BPBID_Arrays.BreedsPerSpecies[1550] = {4}
    BPBID_Arrays.BreedsPerSpecies[1551] = false
    BPBID_Arrays.BreedsPerSpecies[1552] = {5}
    BPBID_Arrays.BreedsPerSpecies[1553] = {7}
    BPBID_Arrays.BreedsPerSpecies[1554] = {7}
    BPBID_Arrays.BreedsPerSpecies[1555] = {7}
    BPBID_Arrays.BreedsPerSpecies[1556] = {6}
    BPBID_Arrays.BreedsPerSpecies[1557] = {4}
    BPBID_Arrays.BreedsPerSpecies[1558] = {7}
    BPBID_Arrays.BreedsPerSpecies[1559] = {7}
    BPBID_Arrays.BreedsPerSpecies[1560] = {7}
    BPBID_Arrays.BreedsPerSpecies[1561] = {7}
    BPBID_Arrays.BreedsPerSpecies[1562] = {7}
    BPBID_Arrays.BreedsPerSpecies[1563] = {4, 5, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[1564] = {7}
    BPBID_Arrays.BreedsPerSpecies[1565] = {4, 5, 7, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[1566] = {5}
    BPBID_Arrays.BreedsPerSpecies[1567] = {8}
    BPBID_Arrays.BreedsPerSpecies[1568] = {8}
    BPBID_Arrays.BreedsPerSpecies[1569] = {7}
    BPBID_Arrays.BreedsPerSpecies[1570] = {8}
    BPBID_Arrays.BreedsPerSpecies[1571] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[1572] = {3, 4, 5, 9, 10}
    BPBID_Arrays.BreedsPerSpecies[1573] = {3, 4, 5, 9, 10}
    BPBID_Arrays.BreedsPerSpecies[1574] = {8}
    BPBID_Arrays.BreedsPerSpecies[1575] = {10}
    BPBID_Arrays.BreedsPerSpecies[1576] = {4}
    BPBID_Arrays.BreedsPerSpecies[1577] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1578] = {4, 6}
    BPBID_Arrays.BreedsPerSpecies[1579] = {4, 6}
    BPBID_Arrays.BreedsPerSpecies[1580] = false
    BPBID_Arrays.BreedsPerSpecies[1581] = {4, 6}
    BPBID_Arrays.BreedsPerSpecies[1582] = {4, 6}
    BPBID_Arrays.BreedsPerSpecies[1583] = {4, 6}
    BPBID_Arrays.BreedsPerSpecies[1584] = false
    BPBID_Arrays.BreedsPerSpecies[1585] = false
    BPBID_Arrays.BreedsPerSpecies[1586] = {3, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[1587] = {3, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[1588] = {3, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[1589] = {3, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[1590] = {3, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1591] = {3, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1592] = {3, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1593] = {3, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1594] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[1595] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[1596] = {8}
    BPBID_Arrays.BreedsPerSpecies[1597] = {8}
    BPBID_Arrays.BreedsPerSpecies[1598] = {3, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[1599] = {3, 6, 9}
    BPBID_Arrays.BreedsPerSpecies[1600] = {3, 5, 6, 8}
    BPBID_Arrays.BreedsPerSpecies[1601] = {4}
    BPBID_Arrays.BreedsPerSpecies[1602] = {8}
    BPBID_Arrays.BreedsPerSpecies[1603] = {9}
    BPBID_Arrays.BreedsPerSpecies[1604] = {7}
    BPBID_Arrays.BreedsPerSpecies[1605] = {7}
    BPBID_Arrays.BreedsPerSpecies[1606] = false
    BPBID_Arrays.BreedsPerSpecies[1607] = {3}
    BPBID_Arrays.BreedsPerSpecies[1608] = {3}
    BPBID_Arrays.BreedsPerSpecies[1609] = {3}
    BPBID_Arrays.BreedsPerSpecies[1610] = false
    BPBID_Arrays.BreedsPerSpecies[1611] = false
    BPBID_Arrays.BreedsPerSpecies[1612] = false
    BPBID_Arrays.BreedsPerSpecies[1613] = false
    BPBID_Arrays.BreedsPerSpecies[1614] = false
    BPBID_Arrays.BreedsPerSpecies[1615] = {3, 5, 7}
    BPBID_Arrays.BreedsPerSpecies[1616] = false
    BPBID_Arrays.BreedsPerSpecies[1617] = false
    BPBID_Arrays.BreedsPerSpecies[1618] = false
    BPBID_Arrays.BreedsPerSpecies[1619] = false
    BPBID_Arrays.BreedsPerSpecies[1620] = false
    BPBID_Arrays.BreedsPerSpecies[1621] = false
    BPBID_Arrays.BreedsPerSpecies[1622] = {6}
    BPBID_Arrays.BreedsPerSpecies[1623] = {7, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1624] = {4}
    BPBID_Arrays.BreedsPerSpecies[1625] = {7}
    BPBID_Arrays.BreedsPerSpecies[1626] = {12}
    BPBID_Arrays.BreedsPerSpecies[1627] = {9}
    BPBID_Arrays.BreedsPerSpecies[1628] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1629] = {10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1630] = false
    BPBID_Arrays.BreedsPerSpecies[1631] = {5}
    BPBID_Arrays.BreedsPerSpecies[1632] = {6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[1633] = {10}
    BPBID_Arrays.BreedsPerSpecies[1634] = {3}
    BPBID_Arrays.BreedsPerSpecies[1635] = {3}
    BPBID_Arrays.BreedsPerSpecies[1636] = {7}
    BPBID_Arrays.BreedsPerSpecies[1637] = {3}
    BPBID_Arrays.BreedsPerSpecies[1638] = false
    BPBID_Arrays.BreedsPerSpecies[1639] = {7}
    BPBID_Arrays.BreedsPerSpecies[1640] = {9}
    BPBID_Arrays.BreedsPerSpecies[1641] = {3}
    BPBID_Arrays.BreedsPerSpecies[1642] = {7}
    BPBID_Arrays.BreedsPerSpecies[1643] = {10}
    BPBID_Arrays.BreedsPerSpecies[1644] = {7}
    BPBID_Arrays.BreedsPerSpecies[1645] = {9}
    BPBID_Arrays.BreedsPerSpecies[1646] = {5}
    BPBID_Arrays.BreedsPerSpecies[1647] = {8}
    BPBID_Arrays.BreedsPerSpecies[1648] = {10}
    BPBID_Arrays.BreedsPerSpecies[1649] = {3}
    BPBID_Arrays.BreedsPerSpecies[1650] = false
    BPBID_Arrays.BreedsPerSpecies[1651] = {12}
    BPBID_Arrays.BreedsPerSpecies[1652] = {8}
    BPBID_Arrays.BreedsPerSpecies[1653] = {8}
    BPBID_Arrays.BreedsPerSpecies[1654] = {8}
    BPBID_Arrays.BreedsPerSpecies[1655] = {3, 4, 5, 7, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1656] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1657] = false
    BPBID_Arrays.BreedsPerSpecies[1658] = false
    BPBID_Arrays.BreedsPerSpecies[1659] = false
    BPBID_Arrays.BreedsPerSpecies[1660] = {5}
    BPBID_Arrays.BreedsPerSpecies[1661] = {8}
    BPBID_Arrays.BreedsPerSpecies[1662] = {4}
    BPBID_Arrays.BreedsPerSpecies[1663] = {6, 7}
    BPBID_Arrays.BreedsPerSpecies[1664] = {3}
    BPBID_Arrays.BreedsPerSpecies[1665] = {9}
    BPBID_Arrays.BreedsPerSpecies[1666] = {3}
    BPBID_Arrays.BreedsPerSpecies[1667] = false
    BPBID_Arrays.BreedsPerSpecies[1668] = false
    BPBID_Arrays.BreedsPerSpecies[1669] = false
    BPBID_Arrays.BreedsPerSpecies[1670] = false
    BPBID_Arrays.BreedsPerSpecies[1671] = {3}
    BPBID_Arrays.BreedsPerSpecies[1672] = {6}
    BPBID_Arrays.BreedsPerSpecies[1673] = {3}
    BPBID_Arrays.BreedsPerSpecies[1674] = {3}
    BPBID_Arrays.BreedsPerSpecies[1675] = {3}
    BPBID_Arrays.BreedsPerSpecies[1676] = {3}
    BPBID_Arrays.BreedsPerSpecies[1677] = {3}
    BPBID_Arrays.BreedsPerSpecies[1678] = {3}
    BPBID_Arrays.BreedsPerSpecies[1679] = {3}
    BPBID_Arrays.BreedsPerSpecies[1680] = {3}
    BPBID_Arrays.BreedsPerSpecies[1681] = {3}
    BPBID_Arrays.BreedsPerSpecies[1682] = {3}
    BPBID_Arrays.BreedsPerSpecies[1683] = {3}
    BPBID_Arrays.BreedsPerSpecies[1684] = {3}
    BPBID_Arrays.BreedsPerSpecies[1685] = {3}
    BPBID_Arrays.BreedsPerSpecies[1686] = {3}
    BPBID_Arrays.BreedsPerSpecies[1687] = {3}
    BPBID_Arrays.BreedsPerSpecies[1688] = {4, 6, 7, 8}
    BPBID_Arrays.BreedsPerSpecies[1689] = false
    BPBID_Arrays.BreedsPerSpecies[1690] = {8}
    BPBID_Arrays.BreedsPerSpecies[1691] = {8}
    BPBID_Arrays.BreedsPerSpecies[1692] = {10}
    BPBID_Arrays.BreedsPerSpecies[1693] = {4}
    BPBID_Arrays.BreedsPerSpecies[1694] = false
    BPBID_Arrays.BreedsPerSpecies[1695] = false
    BPBID_Arrays.BreedsPerSpecies[1696] = false
    BPBID_Arrays.BreedsPerSpecies[1697] = false
    BPBID_Arrays.BreedsPerSpecies[1698] = false
    BPBID_Arrays.BreedsPerSpecies[1699] = {12}
    BPBID_Arrays.BreedsPerSpecies[1700] = {10}
    BPBID_Arrays.BreedsPerSpecies[1701] = {11}
    BPBID_Arrays.BreedsPerSpecies[1702] = false
    BPBID_Arrays.BreedsPerSpecies[1703] = false
    BPBID_Arrays.BreedsPerSpecies[1704] = false
    BPBID_Arrays.BreedsPerSpecies[1705] = {7}
    BPBID_Arrays.BreedsPerSpecies[1706] = {6}
    BPBID_Arrays.BreedsPerSpecies[1707] = false
    BPBID_Arrays.BreedsPerSpecies[1708] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1709] = {3, 4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1710] = {3, 4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1711] = {10}
    BPBID_Arrays.BreedsPerSpecies[1712] = {3, 4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1713] = {3, 4, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1714] = {8}
    BPBID_Arrays.BreedsPerSpecies[1715] = {8}
    BPBID_Arrays.BreedsPerSpecies[1716] = {4}
    BPBID_Arrays.BreedsPerSpecies[1717] = {10}
    BPBID_Arrays.BreedsPerSpecies[1718] = {4}
    BPBID_Arrays.BreedsPerSpecies[1719] = {7}
    BPBID_Arrays.BreedsPerSpecies[1720] = {8}
    BPBID_Arrays.BreedsPerSpecies[1721] = {8}
    BPBID_Arrays.BreedsPerSpecies[1722] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1723] = {7}
    BPBID_Arrays.BreedsPerSpecies[1724] = false
    BPBID_Arrays.BreedsPerSpecies[1725] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1726] = {3, 5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[1727] = {11}
    BPBID_Arrays.BreedsPerSpecies[1728] = {6, 8, 9, 10}
    BPBID_Arrays.BreedsPerSpecies[1729] = {3, 5, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1730] = {5, 8, 9, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[1731] = {3, 5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[1732] = false
    BPBID_Arrays.BreedsPerSpecies[1733] = false
    BPBID_Arrays.BreedsPerSpecies[1734] = {3, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1735] = {6, 9}
    BPBID_Arrays.BreedsPerSpecies[1736] = {3, 5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[1737] = {3, 4, 7, 8}
    BPBID_Arrays.BreedsPerSpecies[1738] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[1739] = {3, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1740] = {3, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[1741] = {9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1742] = {3}
    BPBID_Arrays.BreedsPerSpecies[1743] = {3, 11}
    BPBID_Arrays.BreedsPerSpecies[1744] = {3, 11}
    BPBID_Arrays.BreedsPerSpecies[1745] = {11}
    BPBID_Arrays.BreedsPerSpecies[1746] = {6}
    BPBID_Arrays.BreedsPerSpecies[1747] = false
    BPBID_Arrays.BreedsPerSpecies[1748] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[1749] = {3, 4, 5, 6, 8, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[1750] = {3, 6}
    BPBID_Arrays.BreedsPerSpecies[1751] = false
    BPBID_Arrays.BreedsPerSpecies[1752] = {8}
    BPBID_Arrays.BreedsPerSpecies[1753] = {8}
    BPBID_Arrays.BreedsPerSpecies[1754] = {9}
    BPBID_Arrays.BreedsPerSpecies[1755] = {12}
    BPBID_Arrays.BreedsPerSpecies[1756] = {12}
    BPBID_Arrays.BreedsPerSpecies[1757] = false
    BPBID_Arrays.BreedsPerSpecies[1758] = false
    BPBID_Arrays.BreedsPerSpecies[1759] = {8}
    BPBID_Arrays.BreedsPerSpecies[1760] = {8}
    BPBID_Arrays.BreedsPerSpecies[1761] = {3, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[1762] = {4, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[1763] = {3, 7, 12}
    BPBID_Arrays.BreedsPerSpecies[1764] = {5}
    BPBID_Arrays.BreedsPerSpecies[1765] = {6}
    BPBID_Arrays.BreedsPerSpecies[1766] = {4}
    BPBID_Arrays.BreedsPerSpecies[1767] = false
    BPBID_Arrays.BreedsPerSpecies[1768] = false
    BPBID_Arrays.BreedsPerSpecies[1769] = false
    BPBID_Arrays.BreedsPerSpecies[1770] = {3}
    BPBID_Arrays.BreedsPerSpecies[1771] = {9}
    BPBID_Arrays.BreedsPerSpecies[1772] = {7}
    BPBID_Arrays.BreedsPerSpecies[1773] = {9}
    BPBID_Arrays.BreedsPerSpecies[1774] = {8}
    BPBID_Arrays.BreedsPerSpecies[1775] = {5, 8, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[1776] = {3, 7, 12}
    BPBID_Arrays.BreedsPerSpecies[1777] = {3}
    BPBID_Arrays.BreedsPerSpecies[1778] = {5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[1779] = false
    BPBID_Arrays.BreedsPerSpecies[1780] = {7}
    BPBID_Arrays.BreedsPerSpecies[1781] = {9}
    BPBID_Arrays.BreedsPerSpecies[1782] = {7}
    BPBID_Arrays.BreedsPerSpecies[1783] = false
    BPBID_Arrays.BreedsPerSpecies[1784] = false
    BPBID_Arrays.BreedsPerSpecies[1785] = false
    BPBID_Arrays.BreedsPerSpecies[1786] = false
    BPBID_Arrays.BreedsPerSpecies[1787] = {3}
    BPBID_Arrays.BreedsPerSpecies[1788] = {3}
    BPBID_Arrays.BreedsPerSpecies[1789] = {12}
    BPBID_Arrays.BreedsPerSpecies[1790] = {4}
    BPBID_Arrays.BreedsPerSpecies[1791] = {9}
    BPBID_Arrays.BreedsPerSpecies[1792] = {10}
    BPBID_Arrays.BreedsPerSpecies[1793] = {3}
    BPBID_Arrays.BreedsPerSpecies[1794] = {4}
    BPBID_Arrays.BreedsPerSpecies[1795] = {4}
    BPBID_Arrays.BreedsPerSpecies[1796] = {8}
    BPBID_Arrays.BreedsPerSpecies[1797] = {10}
    BPBID_Arrays.BreedsPerSpecies[1798] = {12}
    BPBID_Arrays.BreedsPerSpecies[1799] = {3}
    BPBID_Arrays.BreedsPerSpecies[1800] = {7}
    BPBID_Arrays.BreedsPerSpecies[1801] = {5}
    BPBID_Arrays.BreedsPerSpecies[1802] = {12}
    BPBID_Arrays.BreedsPerSpecies[1803] = {9}
    BPBID_Arrays.BreedsPerSpecies[1804] = {3}
    BPBID_Arrays.BreedsPerSpecies[1805] = {6}
    BPBID_Arrays.BreedsPerSpecies[1806] = {9}
    BPBID_Arrays.BreedsPerSpecies[1807] = {10}
    BPBID_Arrays.BreedsPerSpecies[1808] = {12}
    BPBID_Arrays.BreedsPerSpecies[1809] = {3, 6, 8, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[1810] = {3, 7}
    BPBID_Arrays.BreedsPerSpecies[1811] = {6}
    BPBID_Arrays.BreedsPerSpecies[1812] = false
    BPBID_Arrays.BreedsPerSpecies[1813] = false
    BPBID_Arrays.BreedsPerSpecies[1814] = false
    BPBID_Arrays.BreedsPerSpecies[1815] = {10}
    BPBID_Arrays.BreedsPerSpecies[1816] = {3}
    BPBID_Arrays.BreedsPerSpecies[1817] = {3}
    BPBID_Arrays.BreedsPerSpecies[1818] = {3}
    BPBID_Arrays.BreedsPerSpecies[1819] = false
    BPBID_Arrays.BreedsPerSpecies[1820] = false
    BPBID_Arrays.BreedsPerSpecies[1821] = false
    BPBID_Arrays.BreedsPerSpecies[1822] = false
    BPBID_Arrays.BreedsPerSpecies[1823] = false
    BPBID_Arrays.BreedsPerSpecies[1824] = false
    BPBID_Arrays.BreedsPerSpecies[1825] = false
    BPBID_Arrays.BreedsPerSpecies[1826] = false
    BPBID_Arrays.BreedsPerSpecies[1827] = false
    BPBID_Arrays.BreedsPerSpecies[1828] = {7}
    BPBID_Arrays.BreedsPerSpecies[1829] = false
    BPBID_Arrays.BreedsPerSpecies[1830] = false
    BPBID_Arrays.BreedsPerSpecies[1831] = false
    BPBID_Arrays.BreedsPerSpecies[1832] = false
    BPBID_Arrays.BreedsPerSpecies[1833] = false
    BPBID_Arrays.BreedsPerSpecies[1834] = false
    BPBID_Arrays.BreedsPerSpecies[1835] = false
    BPBID_Arrays.BreedsPerSpecies[1836] = false
    BPBID_Arrays.BreedsPerSpecies[1837] = false
    BPBID_Arrays.BreedsPerSpecies[1838] = false
    BPBID_Arrays.BreedsPerSpecies[1839] = false
    BPBID_Arrays.BreedsPerSpecies[1840] = {12}
    BPBID_Arrays.BreedsPerSpecies[1841] = {7}
    BPBID_Arrays.BreedsPerSpecies[1842] = {12}
    BPBID_Arrays.BreedsPerSpecies[1843] = {8}
    BPBID_Arrays.BreedsPerSpecies[1844] = false
    BPBID_Arrays.BreedsPerSpecies[1845] = false
    BPBID_Arrays.BreedsPerSpecies[1846] = {8}
    BPBID_Arrays.BreedsPerSpecies[1847] = {5}
    BPBID_Arrays.BreedsPerSpecies[1848] = {3}
    BPBID_Arrays.BreedsPerSpecies[1849] = {7}
    BPBID_Arrays.BreedsPerSpecies[1850] = {9}
    BPBID_Arrays.BreedsPerSpecies[1851] = {8}
    BPBID_Arrays.BreedsPerSpecies[1852] = {10}
    BPBID_Arrays.BreedsPerSpecies[1853] = {7}
    BPBID_Arrays.BreedsPerSpecies[1854] = false
    BPBID_Arrays.BreedsPerSpecies[1855] = {11}
    BPBID_Arrays.BreedsPerSpecies[1856] = false
    BPBID_Arrays.BreedsPerSpecies[1857] = {3}
    BPBID_Arrays.BreedsPerSpecies[1858] = {7}
    BPBID_Arrays.BreedsPerSpecies[1859] = {3}
    BPBID_Arrays.BreedsPerSpecies[1860] = {11}
    BPBID_Arrays.BreedsPerSpecies[1861] = {7}
    BPBID_Arrays.BreedsPerSpecies[1862] = {6}
    BPBID_Arrays.BreedsPerSpecies[1863] = {5}
    BPBID_Arrays.BreedsPerSpecies[1864] = {6}
    BPBID_Arrays.BreedsPerSpecies[1865] = {4}
    BPBID_Arrays.BreedsPerSpecies[1866] = {4}
    BPBID_Arrays.BreedsPerSpecies[1867] = {6}
    BPBID_Arrays.BreedsPerSpecies[1868] = {9}
    BPBID_Arrays.BreedsPerSpecies[1869] = {7}
    BPBID_Arrays.BreedsPerSpecies[1870] = {10}
    BPBID_Arrays.BreedsPerSpecies[1871] = {6}
    BPBID_Arrays.BreedsPerSpecies[1872] = {6}
    BPBID_Arrays.BreedsPerSpecies[1873] = {11}
    BPBID_Arrays.BreedsPerSpecies[1874] = {5}
    BPBID_Arrays.BreedsPerSpecies[1875] = {12}
    BPBID_Arrays.BreedsPerSpecies[1876] = false
    BPBID_Arrays.BreedsPerSpecies[1877] = {12}
    BPBID_Arrays.BreedsPerSpecies[1878] = {10}
    BPBID_Arrays.BreedsPerSpecies[1879] = {5}
    BPBID_Arrays.BreedsPerSpecies[1880] = {3}
    BPBID_Arrays.BreedsPerSpecies[1881] = {3}
    BPBID_Arrays.BreedsPerSpecies[1882] = {6}
    BPBID_Arrays.BreedsPerSpecies[1883] = {6}
    BPBID_Arrays.BreedsPerSpecies[1884] = {7}
    BPBID_Arrays.BreedsPerSpecies[1885] = {12}
    BPBID_Arrays.BreedsPerSpecies[1886] = {6}
    BPBID_Arrays.BreedsPerSpecies[1887] = {10}
    BPBID_Arrays.BreedsPerSpecies[1888] = {7}
    BPBID_Arrays.BreedsPerSpecies[1889] = {11}
    BPBID_Arrays.BreedsPerSpecies[1890] = {5}
    BPBID_Arrays.BreedsPerSpecies[1891] = {4}
    BPBID_Arrays.BreedsPerSpecies[1892] = {3}
    BPBID_Arrays.BreedsPerSpecies[1893] = {3}
    BPBID_Arrays.BreedsPerSpecies[1894] = {3}
    BPBID_Arrays.BreedsPerSpecies[1895] = {10}
    BPBID_Arrays.BreedsPerSpecies[1896] = {9}
    BPBID_Arrays.BreedsPerSpecies[1897] = {12}
    BPBID_Arrays.BreedsPerSpecies[1898] = {6}
    BPBID_Arrays.BreedsPerSpecies[1899] = {4}
    BPBID_Arrays.BreedsPerSpecies[1900] = false
    BPBID_Arrays.BreedsPerSpecies[1901] = false
    BPBID_Arrays.BreedsPerSpecies[1902] = false
    BPBID_Arrays.BreedsPerSpecies[1903] = {6}
    BPBID_Arrays.BreedsPerSpecies[1904] = {5}
    BPBID_Arrays.BreedsPerSpecies[1905] = {6}
    BPBID_Arrays.BreedsPerSpecies[1906] = {4}
    BPBID_Arrays.BreedsPerSpecies[1907] = {8}
    BPBID_Arrays.BreedsPerSpecies[1908] = false
    BPBID_Arrays.BreedsPerSpecies[1909] = false
    BPBID_Arrays.BreedsPerSpecies[1910] = false
    BPBID_Arrays.BreedsPerSpecies[1911] = {3}
    BPBID_Arrays.BreedsPerSpecies[1912] = {7}
    BPBID_Arrays.BreedsPerSpecies[1913] = {3, 4, 5, 9, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[1914] = {5, 8, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[1915] = {3, 4, 5, 6, 7, 8, 12}
    BPBID_Arrays.BreedsPerSpecies[1916] = false
    BPBID_Arrays.BreedsPerSpecies[1917] = {3, 4}
    BPBID_Arrays.BreedsPerSpecies[1918] = {12}
    BPBID_Arrays.BreedsPerSpecies[1919] = {12}
    BPBID_Arrays.BreedsPerSpecies[1920] = {10}
    BPBID_Arrays.BreedsPerSpecies[1921] = {4}
    BPBID_Arrays.BreedsPerSpecies[1922] = {8}
    BPBID_Arrays.BreedsPerSpecies[1923] = false
    BPBID_Arrays.BreedsPerSpecies[1924] = false
    BPBID_Arrays.BreedsPerSpecies[1925] = false
    BPBID_Arrays.BreedsPerSpecies[1926] = {9}
    BPBID_Arrays.BreedsPerSpecies[1927] = {8}
    BPBID_Arrays.BreedsPerSpecies[1928] = {10}
    BPBID_Arrays.BreedsPerSpecies[1929] = {3}
    BPBID_Arrays.BreedsPerSpecies[1930] = {12}
    BPBID_Arrays.BreedsPerSpecies[1931] = {8}
    BPBID_Arrays.BreedsPerSpecies[1932] = {7}
    BPBID_Arrays.BreedsPerSpecies[1933] = {11}
    BPBID_Arrays.BreedsPerSpecies[1934] = {7}
    BPBID_Arrays.BreedsPerSpecies[1935] = {3}
    BPBID_Arrays.BreedsPerSpecies[1936] = {8}
    BPBID_Arrays.BreedsPerSpecies[1937] = {3}
    BPBID_Arrays.BreedsPerSpecies[1938] = {7}
    BPBID_Arrays.BreedsPerSpecies[1939] = {8}
    BPBID_Arrays.BreedsPerSpecies[1940] = {8}
    BPBID_Arrays.BreedsPerSpecies[1941] = {4}
    BPBID_Arrays.BreedsPerSpecies[1942] = false
    BPBID_Arrays.BreedsPerSpecies[1943] = {5}
    BPBID_Arrays.BreedsPerSpecies[1944] = false
    BPBID_Arrays.BreedsPerSpecies[1945] = false
    BPBID_Arrays.BreedsPerSpecies[1946] = false
    BPBID_Arrays.BreedsPerSpecies[1947] = false
    BPBID_Arrays.BreedsPerSpecies[1948] = false
    BPBID_Arrays.BreedsPerSpecies[1949] = {10}
    BPBID_Arrays.BreedsPerSpecies[1950] = false
    BPBID_Arrays.BreedsPerSpecies[1951] = false
    BPBID_Arrays.BreedsPerSpecies[1952] = {3}
    BPBID_Arrays.BreedsPerSpecies[1953] = {5, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[1954] = {8, 11}
    BPBID_Arrays.BreedsPerSpecies[1955] = {4}
    BPBID_Arrays.BreedsPerSpecies[1956] = {6, 12}
    BPBID_Arrays.BreedsPerSpecies[1957] = {3}
    BPBID_Arrays.BreedsPerSpecies[1958] = {3, 4, 7, 10}
    BPBID_Arrays.BreedsPerSpecies[1959] = {6}
    BPBID_Arrays.BreedsPerSpecies[1960] = {3}
    BPBID_Arrays.BreedsPerSpecies[1961] = {6, 7, 12}
    BPBID_Arrays.BreedsPerSpecies[1962] = {8}
    BPBID_Arrays.BreedsPerSpecies[1963] = {3}
    BPBID_Arrays.BreedsPerSpecies[1964] = {3, 4, 5, 6, 7, 8, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[1965] = {3, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[1966] = {11}
    BPBID_Arrays.BreedsPerSpecies[1967] = {3}
    BPBID_Arrays.BreedsPerSpecies[1968] = {5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[1969] = {5}
    BPBID_Arrays.BreedsPerSpecies[1970] = false
    BPBID_Arrays.BreedsPerSpecies[1971] = false
    BPBID_Arrays.BreedsPerSpecies[1972] = false
    BPBID_Arrays.BreedsPerSpecies[1973] = false
    BPBID_Arrays.BreedsPerSpecies[1974] = {5}
    BPBID_Arrays.BreedsPerSpecies[1975] = {7}
    BPBID_Arrays.BreedsPerSpecies[1976] = {4}
    BPBID_Arrays.BreedsPerSpecies[1977] = {8}
    BPBID_Arrays.BreedsPerSpecies[1978] = {3}
    BPBID_Arrays.BreedsPerSpecies[1979] = {3}
    BPBID_Arrays.BreedsPerSpecies[1980] = false
    BPBID_Arrays.BreedsPerSpecies[1981] = false
    BPBID_Arrays.BreedsPerSpecies[1982] = false
    BPBID_Arrays.BreedsPerSpecies[1983] = false
    BPBID_Arrays.BreedsPerSpecies[1984] = {6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[1985] = false
    BPBID_Arrays.BreedsPerSpecies[1986] = false
    BPBID_Arrays.BreedsPerSpecies[1987] = {10}
    BPBID_Arrays.BreedsPerSpecies[1988] = {7}
    BPBID_Arrays.BreedsPerSpecies[1989] = {4}
    BPBID_Arrays.BreedsPerSpecies[1990] = {12}
    BPBID_Arrays.BreedsPerSpecies[1991] = {5}
    BPBID_Arrays.BreedsPerSpecies[1992] = {9}
    BPBID_Arrays.BreedsPerSpecies[1993] = {11}
    BPBID_Arrays.BreedsPerSpecies[1994] = {8}
    BPBID_Arrays.BreedsPerSpecies[1995] = {3}
    BPBID_Arrays.BreedsPerSpecies[1996] = {6}
    BPBID_Arrays.BreedsPerSpecies[1997] = {4}
    BPBID_Arrays.BreedsPerSpecies[1998] = {6}
    BPBID_Arrays.BreedsPerSpecies[1999] = {5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2000] = {7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2001] = {3, 7, 12}
    BPBID_Arrays.BreedsPerSpecies[2002] = {6}
    BPBID_Arrays.BreedsPerSpecies[2003] = {6}
    BPBID_Arrays.BreedsPerSpecies[2004] = {7}
    BPBID_Arrays.BreedsPerSpecies[2005] = false
    BPBID_Arrays.BreedsPerSpecies[2006] = false
    BPBID_Arrays.BreedsPerSpecies[2007] = false
    BPBID_Arrays.BreedsPerSpecies[2008] = {12}
    BPBID_Arrays.BreedsPerSpecies[2009] = {4}
    BPBID_Arrays.BreedsPerSpecies[2010] = {7}
    BPBID_Arrays.BreedsPerSpecies[2011] = {5}
    BPBID_Arrays.BreedsPerSpecies[2012] = {10}
    BPBID_Arrays.BreedsPerSpecies[2013] = {3}
    BPBID_Arrays.BreedsPerSpecies[2014] = {12}
    BPBID_Arrays.BreedsPerSpecies[2015] = {7}
    BPBID_Arrays.BreedsPerSpecies[2016] = {7}
    BPBID_Arrays.BreedsPerSpecies[2017] = {4}
    BPBID_Arrays.BreedsPerSpecies[2018] = {10}
    BPBID_Arrays.BreedsPerSpecies[2019] = false
    BPBID_Arrays.BreedsPerSpecies[2020] = false
    BPBID_Arrays.BreedsPerSpecies[2021] = false
    BPBID_Arrays.BreedsPerSpecies[2022] = {3}
    BPBID_Arrays.BreedsPerSpecies[2023] = {7}
    BPBID_Arrays.BreedsPerSpecies[2024] = {8}
    BPBID_Arrays.BreedsPerSpecies[2025] = {8}
    BPBID_Arrays.BreedsPerSpecies[2026] = {4}
    BPBID_Arrays.BreedsPerSpecies[2027] = {9}
    BPBID_Arrays.BreedsPerSpecies[2028] = {8}
    BPBID_Arrays.BreedsPerSpecies[2029] = false
    BPBID_Arrays.BreedsPerSpecies[2030] = false
    BPBID_Arrays.BreedsPerSpecies[2031] = {7}
    BPBID_Arrays.BreedsPerSpecies[2032] = {6}
    BPBID_Arrays.BreedsPerSpecies[2033] = {12}
    BPBID_Arrays.BreedsPerSpecies[2034] = false
    BPBID_Arrays.BreedsPerSpecies[2035] = {7}
    BPBID_Arrays.BreedsPerSpecies[2036] = {10}
    BPBID_Arrays.BreedsPerSpecies[2037] = {8}
    BPBID_Arrays.BreedsPerSpecies[2038] = {8}
    BPBID_Arrays.BreedsPerSpecies[2039] = {12}
    BPBID_Arrays.BreedsPerSpecies[2040] = {7}
    BPBID_Arrays.BreedsPerSpecies[2041] = {7}
    BPBID_Arrays.BreedsPerSpecies[2042] = {8}
    BPBID_Arrays.BreedsPerSpecies[2043] = false
    BPBID_Arrays.BreedsPerSpecies[2044] = false
    BPBID_Arrays.BreedsPerSpecies[2045] = false
    BPBID_Arrays.BreedsPerSpecies[2046] = false
    BPBID_Arrays.BreedsPerSpecies[2047] = {5}
    BPBID_Arrays.BreedsPerSpecies[2048] = false
    BPBID_Arrays.BreedsPerSpecies[2049] = {12}
    BPBID_Arrays.BreedsPerSpecies[2050] = {5}
    BPBID_Arrays.BreedsPerSpecies[2051] = {11}
    BPBID_Arrays.BreedsPerSpecies[2052] = false
    BPBID_Arrays.BreedsPerSpecies[2053] = false
    BPBID_Arrays.BreedsPerSpecies[2054] = false
    BPBID_Arrays.BreedsPerSpecies[2055] = false
    BPBID_Arrays.BreedsPerSpecies[2056] = false
    BPBID_Arrays.BreedsPerSpecies[2057] = {5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[2058] = {7, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2059] = false
    BPBID_Arrays.BreedsPerSpecies[2060] = false
    BPBID_Arrays.BreedsPerSpecies[2061] = false
    BPBID_Arrays.BreedsPerSpecies[2062] = {8}
    BPBID_Arrays.BreedsPerSpecies[2063] = {4, 5, 12}
    BPBID_Arrays.BreedsPerSpecies[2064] = {8}
    BPBID_Arrays.BreedsPerSpecies[2065] = {3, 4, 5}
    BPBID_Arrays.BreedsPerSpecies[2066] = {9}
    BPBID_Arrays.BreedsPerSpecies[2067] = {3}
    BPBID_Arrays.BreedsPerSpecies[2068] = {12}
    BPBID_Arrays.BreedsPerSpecies[2069] = false
    BPBID_Arrays.BreedsPerSpecies[2070] = false
    BPBID_Arrays.BreedsPerSpecies[2071] = {7}
    BPBID_Arrays.BreedsPerSpecies[2072] = {3}
    BPBID_Arrays.BreedsPerSpecies[2073] = false
    BPBID_Arrays.BreedsPerSpecies[2074] = false
    BPBID_Arrays.BreedsPerSpecies[2075] = false
    BPBID_Arrays.BreedsPerSpecies[2076] = false
    BPBID_Arrays.BreedsPerSpecies[2077] = {8}
    BPBID_Arrays.BreedsPerSpecies[2078] = {6}
    BPBID_Arrays.BreedsPerSpecies[2079] = {7, 12}
    BPBID_Arrays.BreedsPerSpecies[2080] = {3}
    BPBID_Arrays.BreedsPerSpecies[2081] = {8, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2082] = {5, 11}
    BPBID_Arrays.BreedsPerSpecies[2083] = {4, 8, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2084] = {8}
    BPBID_Arrays.BreedsPerSpecies[2085] = {5}
    BPBID_Arrays.BreedsPerSpecies[2086] = {4, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2087] = {8}
    BPBID_Arrays.BreedsPerSpecies[2088] = {5, 9}
    BPBID_Arrays.BreedsPerSpecies[2089] = {10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2090] = {4, 8, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[2091] = {8}
    BPBID_Arrays.BreedsPerSpecies[2092] = {7}
    BPBID_Arrays.BreedsPerSpecies[2093] = {4}
    BPBID_Arrays.BreedsPerSpecies[2094] = false
    BPBID_Arrays.BreedsPerSpecies[2095] = {3}
    BPBID_Arrays.BreedsPerSpecies[2096] = {3}
    BPBID_Arrays.BreedsPerSpecies[2097] = {3}
    BPBID_Arrays.BreedsPerSpecies[2098] = {3}
    BPBID_Arrays.BreedsPerSpecies[2099] = {3}
    BPBID_Arrays.BreedsPerSpecies[2100] = {3}
    BPBID_Arrays.BreedsPerSpecies[2101] = {3}
    BPBID_Arrays.BreedsPerSpecies[2102] = {3}
    BPBID_Arrays.BreedsPerSpecies[2103] = {3}
    BPBID_Arrays.BreedsPerSpecies[2104] = {3}
    BPBID_Arrays.BreedsPerSpecies[2105] = {3}
    BPBID_Arrays.BreedsPerSpecies[2106] = {3}
    BPBID_Arrays.BreedsPerSpecies[2107] = {3}
    BPBID_Arrays.BreedsPerSpecies[2108] = {3}
    BPBID_Arrays.BreedsPerSpecies[2109] = {3}
    BPBID_Arrays.BreedsPerSpecies[2110] = {3}
    BPBID_Arrays.BreedsPerSpecies[2111] = {3}
    BPBID_Arrays.BreedsPerSpecies[2112] = {3}
    BPBID_Arrays.BreedsPerSpecies[2113] = {8}
    BPBID_Arrays.BreedsPerSpecies[2114] = {10}
    BPBID_Arrays.BreedsPerSpecies[2115] = {12}
    BPBID_Arrays.BreedsPerSpecies[2116] = {9}
    BPBID_Arrays.BreedsPerSpecies[2117] = {4}
    BPBID_Arrays.BreedsPerSpecies[2118] = {6}
    BPBID_Arrays.BreedsPerSpecies[2119] = {4}
    BPBID_Arrays.BreedsPerSpecies[2120] = {5}
    BPBID_Arrays.BreedsPerSpecies[2121] = {4}
    BPBID_Arrays.BreedsPerSpecies[2122] = {7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2123] = {6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2124] = {3, 4, 6, 7, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[2125] = false
    BPBID_Arrays.BreedsPerSpecies[2126] = {3, 5, 7, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2127] = {9}
    BPBID_Arrays.BreedsPerSpecies[2128] = {3, 8}
    BPBID_Arrays.BreedsPerSpecies[2129] = {3, 8}
    BPBID_Arrays.BreedsPerSpecies[2130] = {3, 5, 6, 7, 8, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2131] = {3, 5, 6, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2132] = {3, 4, 7, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2133] = {3, 5, 7, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2134] = {3, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2135] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2136] = {3}
    BPBID_Arrays.BreedsPerSpecies[2137] = false
    BPBID_Arrays.BreedsPerSpecies[2138] = false
    BPBID_Arrays.BreedsPerSpecies[2139] = false
    BPBID_Arrays.BreedsPerSpecies[2140] = false
    BPBID_Arrays.BreedsPerSpecies[2141] = false
    BPBID_Arrays.BreedsPerSpecies[2142] = false
    BPBID_Arrays.BreedsPerSpecies[2143] = {9}
    BPBID_Arrays.BreedsPerSpecies[2144] = false
    BPBID_Arrays.BreedsPerSpecies[2145] = false
    BPBID_Arrays.BreedsPerSpecies[2146] = false
    BPBID_Arrays.BreedsPerSpecies[2147] = false
    BPBID_Arrays.BreedsPerSpecies[2148] = false
    BPBID_Arrays.BreedsPerSpecies[2149] = false
    BPBID_Arrays.BreedsPerSpecies[2150] = false
    BPBID_Arrays.BreedsPerSpecies[2151] = false
    BPBID_Arrays.BreedsPerSpecies[2152] = false
    BPBID_Arrays.BreedsPerSpecies[2153] = false
    BPBID_Arrays.BreedsPerSpecies[2154] = false
    BPBID_Arrays.BreedsPerSpecies[2155] = false
    BPBID_Arrays.BreedsPerSpecies[2156] = false
    BPBID_Arrays.BreedsPerSpecies[2157] = {3}
    BPBID_Arrays.BreedsPerSpecies[2158] = {11}
    BPBID_Arrays.BreedsPerSpecies[2159] = false
    BPBID_Arrays.BreedsPerSpecies[2160] = false
    BPBID_Arrays.BreedsPerSpecies[2161] = false
    BPBID_Arrays.BreedsPerSpecies[2162] = false
    BPBID_Arrays.BreedsPerSpecies[2163] = {7}
    BPBID_Arrays.BreedsPerSpecies[2164] = false
    BPBID_Arrays.BreedsPerSpecies[2165] = {7}
    BPBID_Arrays.BreedsPerSpecies[2166] = false
    BPBID_Arrays.BreedsPerSpecies[2167] = false
    BPBID_Arrays.BreedsPerSpecies[2168] = false
    BPBID_Arrays.BreedsPerSpecies[2169] = false
    BPBID_Arrays.BreedsPerSpecies[2170] = false
    BPBID_Arrays.BreedsPerSpecies[2171] = false
    BPBID_Arrays.BreedsPerSpecies[2172] = false
    BPBID_Arrays.BreedsPerSpecies[2173] = false
    BPBID_Arrays.BreedsPerSpecies[2174] = false
    BPBID_Arrays.BreedsPerSpecies[2175] = false
    BPBID_Arrays.BreedsPerSpecies[2176] = false
    BPBID_Arrays.BreedsPerSpecies[2177] = false
    BPBID_Arrays.BreedsPerSpecies[2178] = false
    BPBID_Arrays.BreedsPerSpecies[2179] = false
    BPBID_Arrays.BreedsPerSpecies[2180] = false
    BPBID_Arrays.BreedsPerSpecies[2181] = false
    BPBID_Arrays.BreedsPerSpecies[2182] = false
    BPBID_Arrays.BreedsPerSpecies[2183] = false
    BPBID_Arrays.BreedsPerSpecies[2184] = {9}
    BPBID_Arrays.BreedsPerSpecies[2185] = {5}
    BPBID_Arrays.BreedsPerSpecies[2186] = {8}
    BPBID_Arrays.BreedsPerSpecies[2187] = {6}
    BPBID_Arrays.BreedsPerSpecies[2188] = {8}
    BPBID_Arrays.BreedsPerSpecies[2189] = {8}
    BPBID_Arrays.BreedsPerSpecies[2190] = {5}
    BPBID_Arrays.BreedsPerSpecies[2191] = false
    BPBID_Arrays.BreedsPerSpecies[2192] = {3}
    BPBID_Arrays.BreedsPerSpecies[2193] = {7}
    BPBID_Arrays.BreedsPerSpecies[2194] = {4}
    BPBID_Arrays.BreedsPerSpecies[2195] = {9}
    BPBID_Arrays.BreedsPerSpecies[2196] = {8}
    BPBID_Arrays.BreedsPerSpecies[2197] = {7}
    BPBID_Arrays.BreedsPerSpecies[2198] = {11}
    BPBID_Arrays.BreedsPerSpecies[2199] = {4}
    BPBID_Arrays.BreedsPerSpecies[2200] = {6}
    BPBID_Arrays.BreedsPerSpecies[2201] = {3}
    BPBID_Arrays.BreedsPerSpecies[2202] = {7}
    BPBID_Arrays.BreedsPerSpecies[2203] = {7}
    BPBID_Arrays.BreedsPerSpecies[2204] = {7}
    BPBID_Arrays.BreedsPerSpecies[2205] = {7}
    BPBID_Arrays.BreedsPerSpecies[2206] = {8}
    BPBID_Arrays.BreedsPerSpecies[2207] = false
    BPBID_Arrays.BreedsPerSpecies[2208] = {3}
    BPBID_Arrays.BreedsPerSpecies[2209] = {5}
    BPBID_Arrays.BreedsPerSpecies[2210] = {10}
    BPBID_Arrays.BreedsPerSpecies[2211] = {6}
    BPBID_Arrays.BreedsPerSpecies[2212] = {6}
    BPBID_Arrays.BreedsPerSpecies[2213] = {5}
    BPBID_Arrays.BreedsPerSpecies[2214] = {5}
    BPBID_Arrays.BreedsPerSpecies[2215] = {5}
    BPBID_Arrays.BreedsPerSpecies[2216] = false
    BPBID_Arrays.BreedsPerSpecies[2217] = false
    BPBID_Arrays.BreedsPerSpecies[2218] = false
    BPBID_Arrays.BreedsPerSpecies[2219] = false
    BPBID_Arrays.BreedsPerSpecies[2220] = {11}
    BPBID_Arrays.BreedsPerSpecies[2221] = {4}
    BPBID_Arrays.BreedsPerSpecies[2222] = {3}
    BPBID_Arrays.BreedsPerSpecies[2223] = {7}
    BPBID_Arrays.BreedsPerSpecies[2224] = false
    BPBID_Arrays.BreedsPerSpecies[2225] = {7}
    BPBID_Arrays.BreedsPerSpecies[2226] = {7}
    BPBID_Arrays.BreedsPerSpecies[2227] = {7}
    BPBID_Arrays.BreedsPerSpecies[2228] = {7}
    BPBID_Arrays.BreedsPerSpecies[2229] = {7}
    BPBID_Arrays.BreedsPerSpecies[2230] = {7}
    BPBID_Arrays.BreedsPerSpecies[2231] = {8}
    BPBID_Arrays.BreedsPerSpecies[2232] = {9}
    BPBID_Arrays.BreedsPerSpecies[2233] = {7}
    BPBID_Arrays.BreedsPerSpecies[2234] = false
    BPBID_Arrays.BreedsPerSpecies[2235] = false
    BPBID_Arrays.BreedsPerSpecies[2236] = false
    BPBID_Arrays.BreedsPerSpecies[2237] = false
    BPBID_Arrays.BreedsPerSpecies[2238] = false
    BPBID_Arrays.BreedsPerSpecies[2239] = false
    BPBID_Arrays.BreedsPerSpecies[2240] = false
    BPBID_Arrays.BreedsPerSpecies[2241] = false
    BPBID_Arrays.BreedsPerSpecies[2242] = false
    BPBID_Arrays.BreedsPerSpecies[2243] = false
    BPBID_Arrays.BreedsPerSpecies[2244] = false
    BPBID_Arrays.BreedsPerSpecies[2245] = false
    BPBID_Arrays.BreedsPerSpecies[2246] = false
    BPBID_Arrays.BreedsPerSpecies[2247] = false
    BPBID_Arrays.BreedsPerSpecies[2248] = false
    BPBID_Arrays.BreedsPerSpecies[2249] = false
    BPBID_Arrays.BreedsPerSpecies[2250] = false
    BPBID_Arrays.BreedsPerSpecies[2251] = false
    BPBID_Arrays.BreedsPerSpecies[2252] = false
    BPBID_Arrays.BreedsPerSpecies[2253] = false
    BPBID_Arrays.BreedsPerSpecies[2254] = false
    BPBID_Arrays.BreedsPerSpecies[2255] = false
    BPBID_Arrays.BreedsPerSpecies[2256] = false
    BPBID_Arrays.BreedsPerSpecies[2257] = false
    BPBID_Arrays.BreedsPerSpecies[2258] = false
    BPBID_Arrays.BreedsPerSpecies[2259] = false
    BPBID_Arrays.BreedsPerSpecies[2260] = false
    BPBID_Arrays.BreedsPerSpecies[2261] = false
    BPBID_Arrays.BreedsPerSpecies[2262] = false
    BPBID_Arrays.BreedsPerSpecies[2263] = false
    BPBID_Arrays.BreedsPerSpecies[2264] = false
    BPBID_Arrays.BreedsPerSpecies[2265] = false
    BPBID_Arrays.BreedsPerSpecies[2266] = false
    BPBID_Arrays.BreedsPerSpecies[2267] = false
    BPBID_Arrays.BreedsPerSpecies[2268] = false
    BPBID_Arrays.BreedsPerSpecies[2269] = false
    BPBID_Arrays.BreedsPerSpecies[2270] = false
    BPBID_Arrays.BreedsPerSpecies[2271] = false
    BPBID_Arrays.BreedsPerSpecies[2272] = false
    BPBID_Arrays.BreedsPerSpecies[2273] = false
    BPBID_Arrays.BreedsPerSpecies[2274] = false
    BPBID_Arrays.BreedsPerSpecies[2275] = false
    BPBID_Arrays.BreedsPerSpecies[2276] = false
    BPBID_Arrays.BreedsPerSpecies[2277] = false
    BPBID_Arrays.BreedsPerSpecies[2278] = false
    BPBID_Arrays.BreedsPerSpecies[2279] = false
    BPBID_Arrays.BreedsPerSpecies[2280] = false
    BPBID_Arrays.BreedsPerSpecies[2281] = false
    BPBID_Arrays.BreedsPerSpecies[2282] = false
    BPBID_Arrays.BreedsPerSpecies[2283] = false
    BPBID_Arrays.BreedsPerSpecies[2284] = false
    BPBID_Arrays.BreedsPerSpecies[2285] = false
    BPBID_Arrays.BreedsPerSpecies[2286] = false
    BPBID_Arrays.BreedsPerSpecies[2287] = false
    BPBID_Arrays.BreedsPerSpecies[2288] = false
    BPBID_Arrays.BreedsPerSpecies[2289] = false
    BPBID_Arrays.BreedsPerSpecies[2290] = false
    BPBID_Arrays.BreedsPerSpecies[2291] = false
    BPBID_Arrays.BreedsPerSpecies[2292] = false
    BPBID_Arrays.BreedsPerSpecies[2293] = false
    BPBID_Arrays.BreedsPerSpecies[2294] = false
    BPBID_Arrays.BreedsPerSpecies[2295] = false
    BPBID_Arrays.BreedsPerSpecies[2296] = false
    BPBID_Arrays.BreedsPerSpecies[2297] = false
    BPBID_Arrays.BreedsPerSpecies[2298] = false
    BPBID_Arrays.BreedsPerSpecies[2299] = false
    BPBID_Arrays.BreedsPerSpecies[2300] = false
    BPBID_Arrays.BreedsPerSpecies[2301] = false
    BPBID_Arrays.BreedsPerSpecies[2302] = false
    BPBID_Arrays.BreedsPerSpecies[2303] = false
    BPBID_Arrays.BreedsPerSpecies[2304] = false
    BPBID_Arrays.BreedsPerSpecies[2305] = false
    BPBID_Arrays.BreedsPerSpecies[2306] = false
    BPBID_Arrays.BreedsPerSpecies[2307] = false
    BPBID_Arrays.BreedsPerSpecies[2308] = false
    BPBID_Arrays.BreedsPerSpecies[2309] = false
    BPBID_Arrays.BreedsPerSpecies[2310] = false
    BPBID_Arrays.BreedsPerSpecies[2311] = false
    BPBID_Arrays.BreedsPerSpecies[2312] = false
    BPBID_Arrays.BreedsPerSpecies[2313] = false
    BPBID_Arrays.BreedsPerSpecies[2314] = false
    BPBID_Arrays.BreedsPerSpecies[2315] = false
    BPBID_Arrays.BreedsPerSpecies[2316] = false
    BPBID_Arrays.BreedsPerSpecies[2317] = false
    BPBID_Arrays.BreedsPerSpecies[2318] = false
    BPBID_Arrays.BreedsPerSpecies[2319] = false
    BPBID_Arrays.BreedsPerSpecies[2320] = false
    BPBID_Arrays.BreedsPerSpecies[2321] = false
    BPBID_Arrays.BreedsPerSpecies[2322] = false
    BPBID_Arrays.BreedsPerSpecies[2323] = false
    BPBID_Arrays.BreedsPerSpecies[2324] = false
    BPBID_Arrays.BreedsPerSpecies[2325] = false
    BPBID_Arrays.BreedsPerSpecies[2326] = false
    BPBID_Arrays.BreedsPerSpecies[2327] = false
    BPBID_Arrays.BreedsPerSpecies[2328] = false
    BPBID_Arrays.BreedsPerSpecies[2329] = false
    BPBID_Arrays.BreedsPerSpecies[2330] = {7}
    BPBID_Arrays.BreedsPerSpecies[2331] = false
    BPBID_Arrays.BreedsPerSpecies[2332] = {7}
    BPBID_Arrays.BreedsPerSpecies[2333] = {6}
    BPBID_Arrays.BreedsPerSpecies[2334] = {9}
    BPBID_Arrays.BreedsPerSpecies[2335] = {8}
    BPBID_Arrays.BreedsPerSpecies[2336] = {4}
    BPBID_Arrays.BreedsPerSpecies[2337] = {12}
    BPBID_Arrays.BreedsPerSpecies[2338] = {8}
    BPBID_Arrays.BreedsPerSpecies[2339] = {8}
    BPBID_Arrays.BreedsPerSpecies[2340] = {8}
    BPBID_Arrays.BreedsPerSpecies[2341] = {9}
    BPBID_Arrays.BreedsPerSpecies[2342] = false
    BPBID_Arrays.BreedsPerSpecies[2343] = {4}
    BPBID_Arrays.BreedsPerSpecies[2344] = {9}
    BPBID_Arrays.BreedsPerSpecies[2345] = {8}
    BPBID_Arrays.BreedsPerSpecies[2346] = {3}
    BPBID_Arrays.BreedsPerSpecies[2347] = {6}
    BPBID_Arrays.BreedsPerSpecies[2348] = false
    BPBID_Arrays.BreedsPerSpecies[2349] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2350] = {3}
    BPBID_Arrays.BreedsPerSpecies[2351] = false
    BPBID_Arrays.BreedsPerSpecies[2352] = {3}
    BPBID_Arrays.BreedsPerSpecies[2353] = {7}
    BPBID_Arrays.BreedsPerSpecies[2354] = {6}
    BPBID_Arrays.BreedsPerSpecies[2355] = {5}
    BPBID_Arrays.BreedsPerSpecies[2356] = {10}
    BPBID_Arrays.BreedsPerSpecies[2357] = {3}
    BPBID_Arrays.BreedsPerSpecies[2358] = {3}
    BPBID_Arrays.BreedsPerSpecies[2359] = {12}
    BPBID_Arrays.BreedsPerSpecies[2360] = {12}
    BPBID_Arrays.BreedsPerSpecies[2361] = {9}
    BPBID_Arrays.BreedsPerSpecies[2362] = false
    BPBID_Arrays.BreedsPerSpecies[2363] = {5}
    BPBID_Arrays.BreedsPerSpecies[2364] = {5}
    BPBID_Arrays.BreedsPerSpecies[2365] = {10}
    BPBID_Arrays.BreedsPerSpecies[2366] = {6}
    BPBID_Arrays.BreedsPerSpecies[2367] = {12}
    BPBID_Arrays.BreedsPerSpecies[2368] = {11}
    BPBID_Arrays.BreedsPerSpecies[2369] = false
    BPBID_Arrays.BreedsPerSpecies[2370] = {7}
    BPBID_Arrays.BreedsPerSpecies[2371] = {5}
    BPBID_Arrays.BreedsPerSpecies[2372] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2373] = {3, 4, 7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2374] = {3, 4, 5, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[2375] = {3, 4, 6, 7, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2376] = {3, 4, 5, 6, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[2377] = {3, 4, 5, 6, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2378] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[2379] = {3, 4, 6, 7, 8, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[2380] = {3, 4, 7, 8, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[2381] = {6, 12}
    BPBID_Arrays.BreedsPerSpecies[2382] = {3, 4, 6, 7, 8}
    BPBID_Arrays.BreedsPerSpecies[2383] = {3, 6, 7, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[2384] = {4, 5, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2385] = {5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2386] = {3, 6, 12}
    BPBID_Arrays.BreedsPerSpecies[2387] = {3, 4, 7, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2388] = {5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2389] = {5, 7, 8, 9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[2390] = {3, 5, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2391] = false
    BPBID_Arrays.BreedsPerSpecies[2392] = {3, 5, 6, 7, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2393] = {6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2394] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2395] = {4, 7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2396] = false
    BPBID_Arrays.BreedsPerSpecies[2397] = {3, 4, 5, 8, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2398] = {5}
    BPBID_Arrays.BreedsPerSpecies[2399] = {5}
    BPBID_Arrays.BreedsPerSpecies[2400] = {3, 5, 9, 10}
    BPBID_Arrays.BreedsPerSpecies[2401] = {7}
    BPBID_Arrays.BreedsPerSpecies[2402] = {12}
    BPBID_Arrays.BreedsPerSpecies[2403] = {3}
    BPBID_Arrays.BreedsPerSpecies[2404] = {11}
    BPBID_Arrays.BreedsPerSpecies[2405] = {11}
    BPBID_Arrays.BreedsPerSpecies[2406] = {3}
    BPBID_Arrays.BreedsPerSpecies[2407] = {10}
    BPBID_Arrays.BreedsPerSpecies[2408] = {12}
    BPBID_Arrays.BreedsPerSpecies[2409] = {3}
    BPBID_Arrays.BreedsPerSpecies[2410] = {7}
    BPBID_Arrays.BreedsPerSpecies[2411] = {9}
    BPBID_Arrays.BreedsPerSpecies[2412] = {7}
    BPBID_Arrays.BreedsPerSpecies[2413] = {10}
    BPBID_Arrays.BreedsPerSpecies[2414] = {8}
    BPBID_Arrays.BreedsPerSpecies[2415] = {5}
    BPBID_Arrays.BreedsPerSpecies[2416] = {3}
    BPBID_Arrays.BreedsPerSpecies[2417] = {4}
    BPBID_Arrays.BreedsPerSpecies[2418] = {8}
    BPBID_Arrays.BreedsPerSpecies[2419] = {11}
    BPBID_Arrays.BreedsPerSpecies[2420] = {10}
    BPBID_Arrays.BreedsPerSpecies[2421] = {10}
    BPBID_Arrays.BreedsPerSpecies[2422] = {5}
    BPBID_Arrays.BreedsPerSpecies[2423] = {7}
    BPBID_Arrays.BreedsPerSpecies[2424] = {3}
    BPBID_Arrays.BreedsPerSpecies[2425] = {12}
    BPBID_Arrays.BreedsPerSpecies[2426] = {5}
    BPBID_Arrays.BreedsPerSpecies[2427] = {7}
    BPBID_Arrays.BreedsPerSpecies[2428] = {4}
    BPBID_Arrays.BreedsPerSpecies[2429] = {6}
    BPBID_Arrays.BreedsPerSpecies[2430] = {8}
    BPBID_Arrays.BreedsPerSpecies[2431] = {8}
    BPBID_Arrays.BreedsPerSpecies[2432] = {3, 6, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2433] = {5}
    BPBID_Arrays.BreedsPerSpecies[2434] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[2435] = {3}
    BPBID_Arrays.BreedsPerSpecies[2436] = {6, 7}
    BPBID_Arrays.BreedsPerSpecies[2437] = {3, 5, 9}
    BPBID_Arrays.BreedsPerSpecies[2438] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[2439] = {10}
    BPBID_Arrays.BreedsPerSpecies[2440] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[2441] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[2442] = {8}
    BPBID_Arrays.BreedsPerSpecies[2443] = {3, 6, 7}
    BPBID_Arrays.BreedsPerSpecies[2444] = {3, 6, 7}
    BPBID_Arrays.BreedsPerSpecies[2445] = {7}
    BPBID_Arrays.BreedsPerSpecies[2446] = {12}
    BPBID_Arrays.BreedsPerSpecies[2447] = {11}
    BPBID_Arrays.BreedsPerSpecies[2448] = {9}
    BPBID_Arrays.BreedsPerSpecies[2449] = {7}
    BPBID_Arrays.BreedsPerSpecies[2450] = {8}
    BPBID_Arrays.BreedsPerSpecies[2451] = {5}
    BPBID_Arrays.BreedsPerSpecies[2452] = {7}
    BPBID_Arrays.BreedsPerSpecies[2453] = {12}
    BPBID_Arrays.BreedsPerSpecies[2454] = {4}
    BPBID_Arrays.BreedsPerSpecies[2455] = {10}
    BPBID_Arrays.BreedsPerSpecies[2456] = {11}
    BPBID_Arrays.BreedsPerSpecies[2457] = {8}
    BPBID_Arrays.BreedsPerSpecies[2458] = {6}
    BPBID_Arrays.BreedsPerSpecies[2459] = {6}
    BPBID_Arrays.BreedsPerSpecies[2460] = {5}
    BPBID_Arrays.BreedsPerSpecies[2461] = {11}
    BPBID_Arrays.BreedsPerSpecies[2462] = {5}
    BPBID_Arrays.BreedsPerSpecies[2463] = {9}
    BPBID_Arrays.BreedsPerSpecies[2464] = {4}
    BPBID_Arrays.BreedsPerSpecies[2465] = {7}
    BPBID_Arrays.BreedsPerSpecies[2466] = {4}
    BPBID_Arrays.BreedsPerSpecies[2467] = {5}
    BPBID_Arrays.BreedsPerSpecies[2468] = {6}
    BPBID_Arrays.BreedsPerSpecies[2469] = {9}
    BPBID_Arrays.BreedsPerSpecies[2470] = false
    BPBID_Arrays.BreedsPerSpecies[2471] = {5}
    BPBID_Arrays.BreedsPerSpecies[2472] = {6}
    BPBID_Arrays.BreedsPerSpecies[2473] = {4}
    BPBID_Arrays.BreedsPerSpecies[2474] = {6}
    BPBID_Arrays.BreedsPerSpecies[2475] = {5}
    BPBID_Arrays.BreedsPerSpecies[2476] = {8}
    BPBID_Arrays.BreedsPerSpecies[2477] = {3}
    BPBID_Arrays.BreedsPerSpecies[2478] = {10}
    BPBID_Arrays.BreedsPerSpecies[2479] = {10}
    BPBID_Arrays.BreedsPerSpecies[2480] = false
    BPBID_Arrays.BreedsPerSpecies[2481] = false
    BPBID_Arrays.BreedsPerSpecies[2482] = {3}
    BPBID_Arrays.BreedsPerSpecies[2483] = {3}
    BPBID_Arrays.BreedsPerSpecies[2484] = {3}
    BPBID_Arrays.BreedsPerSpecies[2485] = {8}
    BPBID_Arrays.BreedsPerSpecies[2486] = {6}
    BPBID_Arrays.BreedsPerSpecies[2487] = {11}
    BPBID_Arrays.BreedsPerSpecies[2488] = false
    BPBID_Arrays.BreedsPerSpecies[2489] = false
    BPBID_Arrays.BreedsPerSpecies[2490] = {6}
    BPBID_Arrays.BreedsPerSpecies[2491] = false
    BPBID_Arrays.BreedsPerSpecies[2492] = {8}
    BPBID_Arrays.BreedsPerSpecies[2493] = {11}
    BPBID_Arrays.BreedsPerSpecies[2494] = {11}
    BPBID_Arrays.BreedsPerSpecies[2495] = {8}
    BPBID_Arrays.BreedsPerSpecies[2496] = {10}
    BPBID_Arrays.BreedsPerSpecies[2497] = {4}
    BPBID_Arrays.BreedsPerSpecies[2498] = {3}
    BPBID_Arrays.BreedsPerSpecies[2499] = {3}
    BPBID_Arrays.BreedsPerSpecies[2500] = {5}
    BPBID_Arrays.BreedsPerSpecies[2501] = {6}
    BPBID_Arrays.BreedsPerSpecies[2502] = {4}
    BPBID_Arrays.BreedsPerSpecies[2503] = {9}
    BPBID_Arrays.BreedsPerSpecies[2504] = {6}
    BPBID_Arrays.BreedsPerSpecies[2505] = false
    BPBID_Arrays.BreedsPerSpecies[2506] = false
    BPBID_Arrays.BreedsPerSpecies[2507] = false
    BPBID_Arrays.BreedsPerSpecies[2508] = false
    BPBID_Arrays.BreedsPerSpecies[2509] = false
    BPBID_Arrays.BreedsPerSpecies[2510] = false
    BPBID_Arrays.BreedsPerSpecies[2511] = false
    BPBID_Arrays.BreedsPerSpecies[2512] = false
    BPBID_Arrays.BreedsPerSpecies[2513] = false
    BPBID_Arrays.BreedsPerSpecies[2514] = false
    BPBID_Arrays.BreedsPerSpecies[2515] = false
    BPBID_Arrays.BreedsPerSpecies[2516] = false
    BPBID_Arrays.BreedsPerSpecies[2517] = false
    BPBID_Arrays.BreedsPerSpecies[2518] = false
    BPBID_Arrays.BreedsPerSpecies[2519] = false
    BPBID_Arrays.BreedsPerSpecies[2520] = false
    BPBID_Arrays.BreedsPerSpecies[2521] = false
    BPBID_Arrays.BreedsPerSpecies[2522] = false
    BPBID_Arrays.BreedsPerSpecies[2523] = false
    BPBID_Arrays.BreedsPerSpecies[2524] = false
    BPBID_Arrays.BreedsPerSpecies[2525] = {5}
    BPBID_Arrays.BreedsPerSpecies[2526] = {6}
    BPBID_Arrays.BreedsPerSpecies[2527] = {8}
    BPBID_Arrays.BreedsPerSpecies[2528] = {7}
    BPBID_Arrays.BreedsPerSpecies[2529] = {3}
    BPBID_Arrays.BreedsPerSpecies[2530] = {8}
    BPBID_Arrays.BreedsPerSpecies[2531] = {9}
    BPBID_Arrays.BreedsPerSpecies[2532] = {4}
    BPBID_Arrays.BreedsPerSpecies[2533] = {6}
    BPBID_Arrays.BreedsPerSpecies[2534] = {4}
    BPBID_Arrays.BreedsPerSpecies[2535] = {7}
    BPBID_Arrays.BreedsPerSpecies[2536] = false
    BPBID_Arrays.BreedsPerSpecies[2537] = {3, 4, 5, 10}
    BPBID_Arrays.BreedsPerSpecies[2538] = {9}
    BPBID_Arrays.BreedsPerSpecies[2539] = {5}
    BPBID_Arrays.BreedsPerSpecies[2540] = {3}
    BPBID_Arrays.BreedsPerSpecies[2541] = false
    BPBID_Arrays.BreedsPerSpecies[2542] = false
    BPBID_Arrays.BreedsPerSpecies[2543] = false
    BPBID_Arrays.BreedsPerSpecies[2544] = {8}
    BPBID_Arrays.BreedsPerSpecies[2545] = {4}
    BPBID_Arrays.BreedsPerSpecies[2546] = {11}
    BPBID_Arrays.BreedsPerSpecies[2547] = {7}
    BPBID_Arrays.BreedsPerSpecies[2548] = {6}
    BPBID_Arrays.BreedsPerSpecies[2549] = {4}
    BPBID_Arrays.BreedsPerSpecies[2550] = {9}
    BPBID_Arrays.BreedsPerSpecies[2551] = {7}
    BPBID_Arrays.BreedsPerSpecies[2552] = {11}
    BPBID_Arrays.BreedsPerSpecies[2553] = {5}
    BPBID_Arrays.BreedsPerSpecies[2554] = {4, 7}
    BPBID_Arrays.BreedsPerSpecies[2555] = {10}
    BPBID_Arrays.BreedsPerSpecies[2556] = {11}
    BPBID_Arrays.BreedsPerSpecies[2557] = {7}
    BPBID_Arrays.BreedsPerSpecies[2558] = {4}
    BPBID_Arrays.BreedsPerSpecies[2559] = {5}
    BPBID_Arrays.BreedsPerSpecies[2560] = {8}
    BPBID_Arrays.BreedsPerSpecies[2561] = {9}
    BPBID_Arrays.BreedsPerSpecies[2562] = {4, 5, 6}
    BPBID_Arrays.BreedsPerSpecies[2563] = {7}
    BPBID_Arrays.BreedsPerSpecies[2564] = {8}
    BPBID_Arrays.BreedsPerSpecies[2565] = {5}
    BPBID_Arrays.BreedsPerSpecies[2566] = {3}
    BPBID_Arrays.BreedsPerSpecies[2567] = {8}
    BPBID_Arrays.BreedsPerSpecies[2568] = {8}
    BPBID_Arrays.BreedsPerSpecies[2569] = {6}
    BPBID_Arrays.BreedsPerSpecies[2570] = false
    BPBID_Arrays.BreedsPerSpecies[2571] = false
    BPBID_Arrays.BreedsPerSpecies[2572] = false
    BPBID_Arrays.BreedsPerSpecies[2573] = false
    BPBID_Arrays.BreedsPerSpecies[2574] = false
    BPBID_Arrays.BreedsPerSpecies[2575] = {8}
    BPBID_Arrays.BreedsPerSpecies[2576] = {12}
    BPBID_Arrays.BreedsPerSpecies[2577] = {5}
    BPBID_Arrays.BreedsPerSpecies[2578] = {11}
    BPBID_Arrays.BreedsPerSpecies[2579] = {6}
    BPBID_Arrays.BreedsPerSpecies[2580] = {4}
    BPBID_Arrays.BreedsPerSpecies[2581] = {11}
    BPBID_Arrays.BreedsPerSpecies[2582] = {12}
    BPBID_Arrays.BreedsPerSpecies[2583] = {8}
    BPBID_Arrays.BreedsPerSpecies[2584] = {11}
    BPBID_Arrays.BreedsPerSpecies[2585] = {4}
    BPBID_Arrays.BreedsPerSpecies[2586] = {6}
    BPBID_Arrays.BreedsPerSpecies[2587] = {6}
    BPBID_Arrays.BreedsPerSpecies[2588] = false
    BPBID_Arrays.BreedsPerSpecies[2589] = {11}
    BPBID_Arrays.BreedsPerSpecies[2590] = {10}
    BPBID_Arrays.BreedsPerSpecies[2591] = {4}
    BPBID_Arrays.BreedsPerSpecies[2592] = false
    BPBID_Arrays.BreedsPerSpecies[2593] = false
    BPBID_Arrays.BreedsPerSpecies[2594] = false
    BPBID_Arrays.BreedsPerSpecies[2595] = false
    BPBID_Arrays.BreedsPerSpecies[2596] = false
    BPBID_Arrays.BreedsPerSpecies[2597] = false
    BPBID_Arrays.BreedsPerSpecies[2598] = false
    BPBID_Arrays.BreedsPerSpecies[2599] = false
    BPBID_Arrays.BreedsPerSpecies[2600] = false
    BPBID_Arrays.BreedsPerSpecies[2601] = false
    BPBID_Arrays.BreedsPerSpecies[2602] = false
    BPBID_Arrays.BreedsPerSpecies[2603] = false
    BPBID_Arrays.BreedsPerSpecies[2604] = false
    BPBID_Arrays.BreedsPerSpecies[2605] = false
    BPBID_Arrays.BreedsPerSpecies[2606] = false
    BPBID_Arrays.BreedsPerSpecies[2607] = false
    BPBID_Arrays.BreedsPerSpecies[2608] = false
    BPBID_Arrays.BreedsPerSpecies[2609] = false
    BPBID_Arrays.BreedsPerSpecies[2610] = false
    BPBID_Arrays.BreedsPerSpecies[2611] = false
    BPBID_Arrays.BreedsPerSpecies[2612] = false
    BPBID_Arrays.BreedsPerSpecies[2613] = false
    BPBID_Arrays.BreedsPerSpecies[2614] = false
    BPBID_Arrays.BreedsPerSpecies[2615] = false
    BPBID_Arrays.BreedsPerSpecies[2616] = false
    BPBID_Arrays.BreedsPerSpecies[2617] = false
    BPBID_Arrays.BreedsPerSpecies[2618] = false
    BPBID_Arrays.BreedsPerSpecies[2619] = false
    BPBID_Arrays.BreedsPerSpecies[2620] = false
    BPBID_Arrays.BreedsPerSpecies[2621] = {7}
    BPBID_Arrays.BreedsPerSpecies[2622] = false
    BPBID_Arrays.BreedsPerSpecies[2623] = {10}
    BPBID_Arrays.BreedsPerSpecies[2624] = false
    BPBID_Arrays.BreedsPerSpecies[2625] = false
    BPBID_Arrays.BreedsPerSpecies[2626] = false
    BPBID_Arrays.BreedsPerSpecies[2627] = false
    BPBID_Arrays.BreedsPerSpecies[2628] = false
    BPBID_Arrays.BreedsPerSpecies[2629] = false
    BPBID_Arrays.BreedsPerSpecies[2630] = false
    BPBID_Arrays.BreedsPerSpecies[2631] = false
    BPBID_Arrays.BreedsPerSpecies[2632] = false
    BPBID_Arrays.BreedsPerSpecies[2633] = false
    BPBID_Arrays.BreedsPerSpecies[2634] = false
    BPBID_Arrays.BreedsPerSpecies[2635] = false
    BPBID_Arrays.BreedsPerSpecies[2636] = false
    BPBID_Arrays.BreedsPerSpecies[2637] = false
    BPBID_Arrays.BreedsPerSpecies[2638] = {6}
    BPBID_Arrays.BreedsPerSpecies[2639] = false
    BPBID_Arrays.BreedsPerSpecies[2640] = false
    BPBID_Arrays.BreedsPerSpecies[2641] = false
    BPBID_Arrays.BreedsPerSpecies[2642] = false
    BPBID_Arrays.BreedsPerSpecies[2643] = false
    BPBID_Arrays.BreedsPerSpecies[2644] = false
    BPBID_Arrays.BreedsPerSpecies[2645] = {3, 7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2646] = {7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2647] = {3, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2648] = {5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[2649] = {4, 8}
    BPBID_Arrays.BreedsPerSpecies[2650] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2651] = {5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[2652] = {4}
    BPBID_Arrays.BreedsPerSpecies[2653] = {3, 6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2654] = false
    BPBID_Arrays.BreedsPerSpecies[2655] = false
    BPBID_Arrays.BreedsPerSpecies[2656] = false
    BPBID_Arrays.BreedsPerSpecies[2657] = {7}
    BPBID_Arrays.BreedsPerSpecies[2658] = {7, 8}
    BPBID_Arrays.BreedsPerSpecies[2659] = {3, 12}
    BPBID_Arrays.BreedsPerSpecies[2660] = {3, 7, 12}
    BPBID_Arrays.BreedsPerSpecies[2661] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2662] = {9}
    BPBID_Arrays.BreedsPerSpecies[2663] = {6, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2664] = {6, 7}
    BPBID_Arrays.BreedsPerSpecies[2665] = {5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2666] = {7}
    BPBID_Arrays.BreedsPerSpecies[2667] = {7, 8, 9, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2668] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[2669] = {3, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2670] = {5, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2671] = {5}
    BPBID_Arrays.BreedsPerSpecies[2672] = {7, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2673] = {3, 5, 6, 7, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2674] = {3}
    BPBID_Arrays.BreedsPerSpecies[2675] = {3, 5, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2676] = {3, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2677] = {7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2678] = {4, 5, 8, 9, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2679] = false
    BPBID_Arrays.BreedsPerSpecies[2680] = {12}
    BPBID_Arrays.BreedsPerSpecies[2681] = {10}
    BPBID_Arrays.BreedsPerSpecies[2682] = {3}
    BPBID_Arrays.BreedsPerSpecies[2683] = {11}
    BPBID_Arrays.BreedsPerSpecies[2684] = {6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2685] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2686] = {6}
    BPBID_Arrays.BreedsPerSpecies[2687] = {7}
    BPBID_Arrays.BreedsPerSpecies[2688] = {7}
    BPBID_Arrays.BreedsPerSpecies[2689] = {8}
    BPBID_Arrays.BreedsPerSpecies[2690] = {8}
    BPBID_Arrays.BreedsPerSpecies[2691] = {4}
    BPBID_Arrays.BreedsPerSpecies[2692] = {5}
    BPBID_Arrays.BreedsPerSpecies[2693] = {9}
    BPBID_Arrays.BreedsPerSpecies[2694] = {4, 5, 8, 9, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2695] = {4, 7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2696] = {11}
    BPBID_Arrays.BreedsPerSpecies[2697] = {3}
    BPBID_Arrays.BreedsPerSpecies[2698] = {12}
    BPBID_Arrays.BreedsPerSpecies[2699] = {10}
    BPBID_Arrays.BreedsPerSpecies[2700] = {9}
    BPBID_Arrays.BreedsPerSpecies[2701] = {7}
    BPBID_Arrays.BreedsPerSpecies[2702] = {8}
    BPBID_Arrays.BreedsPerSpecies[2703] = {9}
    BPBID_Arrays.BreedsPerSpecies[2704] = {9, 12}
    BPBID_Arrays.BreedsPerSpecies[2705] = false
    BPBID_Arrays.BreedsPerSpecies[2706] = {6}
    BPBID_Arrays.BreedsPerSpecies[2707] = {7}
    BPBID_Arrays.BreedsPerSpecies[2708] = {4}
    BPBID_Arrays.BreedsPerSpecies[2709] = {5, 10}
    BPBID_Arrays.BreedsPerSpecies[2710] = {8}
    BPBID_Arrays.BreedsPerSpecies[2711] = {8}
    BPBID_Arrays.BreedsPerSpecies[2712] = {5}
    BPBID_Arrays.BreedsPerSpecies[2713] = {12}
    BPBID_Arrays.BreedsPerSpecies[2714] = {3}
    BPBID_Arrays.BreedsPerSpecies[2715] = {11}
    BPBID_Arrays.BreedsPerSpecies[2716] = {10}
    BPBID_Arrays.BreedsPerSpecies[2717] = {7}
    BPBID_Arrays.BreedsPerSpecies[2718] = {6}
    BPBID_Arrays.BreedsPerSpecies[2719] = {9}
    BPBID_Arrays.BreedsPerSpecies[2720] = {5}
    BPBID_Arrays.BreedsPerSpecies[2721] = {10}
    BPBID_Arrays.BreedsPerSpecies[2722] = false
    BPBID_Arrays.BreedsPerSpecies[2723] = {3}
    BPBID_Arrays.BreedsPerSpecies[2724] = {3}
    BPBID_Arrays.BreedsPerSpecies[2725] = {3}
    BPBID_Arrays.BreedsPerSpecies[2726] = {3}
    BPBID_Arrays.BreedsPerSpecies[2727] = {3}
    BPBID_Arrays.BreedsPerSpecies[2728] = {3}
    BPBID_Arrays.BreedsPerSpecies[2729] = {3}
    BPBID_Arrays.BreedsPerSpecies[2730] = {3}
    BPBID_Arrays.BreedsPerSpecies[2731] = {3}
    BPBID_Arrays.BreedsPerSpecies[2732] = {3}
    BPBID_Arrays.BreedsPerSpecies[2733] = {3}
    BPBID_Arrays.BreedsPerSpecies[2734] = {3}
    BPBID_Arrays.BreedsPerSpecies[2735] = {3}
    BPBID_Arrays.BreedsPerSpecies[2736] = {3}
    BPBID_Arrays.BreedsPerSpecies[2737] = {3}
    BPBID_Arrays.BreedsPerSpecies[2738] = {3}
    BPBID_Arrays.BreedsPerSpecies[2739] = {3}
    BPBID_Arrays.BreedsPerSpecies[2740] = {3}
    BPBID_Arrays.BreedsPerSpecies[2741] = {3}
    BPBID_Arrays.BreedsPerSpecies[2742] = {3}
    BPBID_Arrays.BreedsPerSpecies[2743] = false
    BPBID_Arrays.BreedsPerSpecies[2744] = false
    BPBID_Arrays.BreedsPerSpecies[2745] = false
    BPBID_Arrays.BreedsPerSpecies[2746] = false
    BPBID_Arrays.BreedsPerSpecies[2747] = {7}
    BPBID_Arrays.BreedsPerSpecies[2748] = {7}
    BPBID_Arrays.BreedsPerSpecies[2749] = {4}
    BPBID_Arrays.BreedsPerSpecies[2750] = {8}
    BPBID_Arrays.BreedsPerSpecies[2751] = false
    BPBID_Arrays.BreedsPerSpecies[2752] = false
    BPBID_Arrays.BreedsPerSpecies[2753] = {6}
    BPBID_Arrays.BreedsPerSpecies[2754] = {8}
    BPBID_Arrays.BreedsPerSpecies[2755] = {7}
    BPBID_Arrays.BreedsPerSpecies[2756] = {4}
    BPBID_Arrays.BreedsPerSpecies[2757] = {6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2758] = {3, 4, 5, 10}
    BPBID_Arrays.BreedsPerSpecies[2759] = false
    BPBID_Arrays.BreedsPerSpecies[2760] = {3, 4, 5, 10}
    BPBID_Arrays.BreedsPerSpecies[2761] = {3, 4, 5, 6}
    BPBID_Arrays.BreedsPerSpecies[2762] = {7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2763] = {3, 4, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[2764] = false
    BPBID_Arrays.BreedsPerSpecies[2765] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2766] = {6}
    BPBID_Arrays.BreedsPerSpecies[2767] = {8}
    BPBID_Arrays.BreedsPerSpecies[2768] = false
    BPBID_Arrays.BreedsPerSpecies[2769] = false
    BPBID_Arrays.BreedsPerSpecies[2770] = false
    BPBID_Arrays.BreedsPerSpecies[2771] = false
    BPBID_Arrays.BreedsPerSpecies[2772] = false
    BPBID_Arrays.BreedsPerSpecies[2773] = false
    BPBID_Arrays.BreedsPerSpecies[2774] = false
    BPBID_Arrays.BreedsPerSpecies[2775] = false
    BPBID_Arrays.BreedsPerSpecies[2776] = {11}
    BPBID_Arrays.BreedsPerSpecies[2777] = {4}
    BPBID_Arrays.BreedsPerSpecies[2778] = {6}
    BPBID_Arrays.BreedsPerSpecies[2779] = {9}
    BPBID_Arrays.BreedsPerSpecies[2780] = {12}
    BPBID_Arrays.BreedsPerSpecies[2781] = false
    BPBID_Arrays.BreedsPerSpecies[2782] = false
    BPBID_Arrays.BreedsPerSpecies[2783] = false
    BPBID_Arrays.BreedsPerSpecies[2784] = false
    BPBID_Arrays.BreedsPerSpecies[2785] = false
    BPBID_Arrays.BreedsPerSpecies[2786] = false
    BPBID_Arrays.BreedsPerSpecies[2787] = false
    BPBID_Arrays.BreedsPerSpecies[2788] = false
    BPBID_Arrays.BreedsPerSpecies[2789] = false
    BPBID_Arrays.BreedsPerSpecies[2790] = false
    BPBID_Arrays.BreedsPerSpecies[2791] = false
    BPBID_Arrays.BreedsPerSpecies[2792] = {4, 5, 10}
    BPBID_Arrays.BreedsPerSpecies[2793] = {3, 4, 5}
    BPBID_Arrays.BreedsPerSpecies[2794] = {5, 8}
    BPBID_Arrays.BreedsPerSpecies[2795] = {8}
    BPBID_Arrays.BreedsPerSpecies[2796] = {3}
    BPBID_Arrays.BreedsPerSpecies[2797] = {8}
    BPBID_Arrays.BreedsPerSpecies[2798] = {7}
    BPBID_Arrays.BreedsPerSpecies[2799] = false
    BPBID_Arrays.BreedsPerSpecies[2800] = false
    BPBID_Arrays.BreedsPerSpecies[2801] = false
    BPBID_Arrays.BreedsPerSpecies[2802] = false
    BPBID_Arrays.BreedsPerSpecies[2803] = false
    BPBID_Arrays.BreedsPerSpecies[2804] = false
    BPBID_Arrays.BreedsPerSpecies[2805] = false
    BPBID_Arrays.BreedsPerSpecies[2806] = false
    BPBID_Arrays.BreedsPerSpecies[2807] = false
    BPBID_Arrays.BreedsPerSpecies[2808] = false
    BPBID_Arrays.BreedsPerSpecies[2809] = false
    BPBID_Arrays.BreedsPerSpecies[2810] = false
    BPBID_Arrays.BreedsPerSpecies[2811] = false
    BPBID_Arrays.BreedsPerSpecies[2812] = false
    BPBID_Arrays.BreedsPerSpecies[2813] = false
    BPBID_Arrays.BreedsPerSpecies[2814] = false
    BPBID_Arrays.BreedsPerSpecies[2815] = false
    BPBID_Arrays.BreedsPerSpecies[2816] = false
    BPBID_Arrays.BreedsPerSpecies[2817] = false
    BPBID_Arrays.BreedsPerSpecies[2818] = false
    BPBID_Arrays.BreedsPerSpecies[2819] = false
    BPBID_Arrays.BreedsPerSpecies[2820] = false
    BPBID_Arrays.BreedsPerSpecies[2821] = false
    BPBID_Arrays.BreedsPerSpecies[2822] = false
    BPBID_Arrays.BreedsPerSpecies[2823] = false
    BPBID_Arrays.BreedsPerSpecies[2824] = false
    BPBID_Arrays.BreedsPerSpecies[2825] = false
    BPBID_Arrays.BreedsPerSpecies[2826] = false
    BPBID_Arrays.BreedsPerSpecies[2827] = false
    BPBID_Arrays.BreedsPerSpecies[2828] = false
    BPBID_Arrays.BreedsPerSpecies[2829] = false
    BPBID_Arrays.BreedsPerSpecies[2830] = false
    BPBID_Arrays.BreedsPerSpecies[2831] = false
    BPBID_Arrays.BreedsPerSpecies[2832] = {8}
    BPBID_Arrays.BreedsPerSpecies[2833] = {6}
    BPBID_Arrays.BreedsPerSpecies[2834] = {7}
    BPBID_Arrays.BreedsPerSpecies[2835] = {8}
    BPBID_Arrays.BreedsPerSpecies[2836] = {8}
    BPBID_Arrays.BreedsPerSpecies[2837] = {4}
    BPBID_Arrays.BreedsPerSpecies[2838] = {5}
    BPBID_Arrays.BreedsPerSpecies[2839] = {8}
    BPBID_Arrays.BreedsPerSpecies[2840] = {4}
    BPBID_Arrays.BreedsPerSpecies[2841] = {4}
    BPBID_Arrays.BreedsPerSpecies[2842] = {4}
    BPBID_Arrays.BreedsPerSpecies[2843] = {3}
    BPBID_Arrays.BreedsPerSpecies[2844] = {3}
    BPBID_Arrays.BreedsPerSpecies[2845] = {8}
    BPBID_Arrays.BreedsPerSpecies[2846] = {4}
    BPBID_Arrays.BreedsPerSpecies[2847] = {4}
    BPBID_Arrays.BreedsPerSpecies[2848] = {7}
    BPBID_Arrays.BreedsPerSpecies[2849] = {6}
    BPBID_Arrays.BreedsPerSpecies[2850] = {8}
    BPBID_Arrays.BreedsPerSpecies[2851] = {8}
    BPBID_Arrays.BreedsPerSpecies[2852] = {6}
    BPBID_Arrays.BreedsPerSpecies[2853] = {8}
    BPBID_Arrays.BreedsPerSpecies[2854] = {8}
    BPBID_Arrays.BreedsPerSpecies[2855] = {4}
    BPBID_Arrays.BreedsPerSpecies[2856] = {7}
    BPBID_Arrays.BreedsPerSpecies[2857] = {5}
    BPBID_Arrays.BreedsPerSpecies[2858] = {8}
    BPBID_Arrays.BreedsPerSpecies[2859] = {6}
    BPBID_Arrays.BreedsPerSpecies[2860] = {3}
    BPBID_Arrays.BreedsPerSpecies[2861] = {4}
    BPBID_Arrays.BreedsPerSpecies[2862] = false
    BPBID_Arrays.BreedsPerSpecies[2863] = {4, 5, 6, 8, 12}
    BPBID_Arrays.BreedsPerSpecies[2864] = {3, 6, 12}
    BPBID_Arrays.BreedsPerSpecies[2865] = {4, 7, 8}
    BPBID_Arrays.BreedsPerSpecies[2866] = {5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2867] = {4, 5, 6}
    BPBID_Arrays.BreedsPerSpecies[2868] = {5}
    BPBID_Arrays.BreedsPerSpecies[2869] = {4}
    BPBID_Arrays.BreedsPerSpecies[2870] = {8}
    BPBID_Arrays.BreedsPerSpecies[2871] = false
    BPBID_Arrays.BreedsPerSpecies[2872] = {5}
    BPBID_Arrays.BreedsPerSpecies[2873] = false
    BPBID_Arrays.BreedsPerSpecies[2874] = false
    BPBID_Arrays.BreedsPerSpecies[2875] = false
    BPBID_Arrays.BreedsPerSpecies[2876] = false
    BPBID_Arrays.BreedsPerSpecies[2877] = false
    BPBID_Arrays.BreedsPerSpecies[2878] = {7}
    BPBID_Arrays.BreedsPerSpecies[2879] = false
    BPBID_Arrays.BreedsPerSpecies[2880] = false
    BPBID_Arrays.BreedsPerSpecies[2881] = false
    BPBID_Arrays.BreedsPerSpecies[2882] = false
    BPBID_Arrays.BreedsPerSpecies[2883] = false
    BPBID_Arrays.BreedsPerSpecies[2884] = false
    BPBID_Arrays.BreedsPerSpecies[2885] = false
    BPBID_Arrays.BreedsPerSpecies[2886] = false
    BPBID_Arrays.BreedsPerSpecies[2887] = false
    BPBID_Arrays.BreedsPerSpecies[2888] = {11}
    BPBID_Arrays.BreedsPerSpecies[2889] = {4, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[2890] = false
    BPBID_Arrays.BreedsPerSpecies[2891] = {11}
    BPBID_Arrays.BreedsPerSpecies[2892] = {4, 8}
    BPBID_Arrays.BreedsPerSpecies[2893] = {5}
    BPBID_Arrays.BreedsPerSpecies[2894] = {4, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[2895] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2896] = {6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[2897] = {6, 7, 8}
    BPBID_Arrays.BreedsPerSpecies[2898] = {4, 10}
    BPBID_Arrays.BreedsPerSpecies[2899] = {10}
    BPBID_Arrays.BreedsPerSpecies[2900] = {5}
    BPBID_Arrays.BreedsPerSpecies[2901] = {8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2902] = {4, 5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2903] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2904] = {8}
    BPBID_Arrays.BreedsPerSpecies[2905] = {5}
    BPBID_Arrays.BreedsPerSpecies[2906] = false
    BPBID_Arrays.BreedsPerSpecies[2907] = {10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2908] = {5, 9}
    BPBID_Arrays.BreedsPerSpecies[2909] = {8}
    BPBID_Arrays.BreedsPerSpecies[2910] = {10}
    BPBID_Arrays.BreedsPerSpecies[2911] = {5}
    BPBID_Arrays.BreedsPerSpecies[2912] = {7}
    BPBID_Arrays.BreedsPerSpecies[2913] = {11}
    BPBID_Arrays.BreedsPerSpecies[2914] = {8}
    BPBID_Arrays.BreedsPerSpecies[2915] = {11}
    BPBID_Arrays.BreedsPerSpecies[2916] = {9}
    BPBID_Arrays.BreedsPerSpecies[2917] = {11}
    BPBID_Arrays.BreedsPerSpecies[2918] = {3}
    BPBID_Arrays.BreedsPerSpecies[2919] = {3, 7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2920] = {4, 7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2921] = {4}
    BPBID_Arrays.BreedsPerSpecies[2922] = {4, 8}
    BPBID_Arrays.BreedsPerSpecies[2923] = {5}
    BPBID_Arrays.BreedsPerSpecies[2924] = {5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2925] = {4, 7, 10}
    BPBID_Arrays.BreedsPerSpecies[2926] = {7, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2927] = {3, 5, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2928] = {8}
    BPBID_Arrays.BreedsPerSpecies[2929] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[2930] = {6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2931] = {6}
    BPBID_Arrays.BreedsPerSpecies[2932] = {7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2933] = {8}
    BPBID_Arrays.BreedsPerSpecies[2934] = {4}
    BPBID_Arrays.BreedsPerSpecies[2935] = {3}
    BPBID_Arrays.BreedsPerSpecies[2936] = {3, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2937] = {4, 8}
    BPBID_Arrays.BreedsPerSpecies[2938] = {3, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2939] = {3, 5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[2940] = {8, 10}
    BPBID_Arrays.BreedsPerSpecies[2941] = {5}
    BPBID_Arrays.BreedsPerSpecies[2942] = {7, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[2943] = {4, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[2944] = {4}
    BPBID_Arrays.BreedsPerSpecies[2945] = {6}
    BPBID_Arrays.BreedsPerSpecies[2946] = {6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2947] = {9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[2948] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2949] = {5, 8}
    BPBID_Arrays.BreedsPerSpecies[2950] = {8, 9, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[2951] = false
    BPBID_Arrays.BreedsPerSpecies[2952] = {4, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2953] = {3, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[2954] = {9}
    BPBID_Arrays.BreedsPerSpecies[2955] = {8, 9}
    BPBID_Arrays.BreedsPerSpecies[2956] = {7, 9, 10}
    BPBID_Arrays.BreedsPerSpecies[2957] = {9, 12}
    BPBID_Arrays.BreedsPerSpecies[2958] = {7}
    BPBID_Arrays.BreedsPerSpecies[2959] = {3}
    BPBID_Arrays.BreedsPerSpecies[2960] = {5}
    BPBID_Arrays.BreedsPerSpecies[2961] = {4, 8}
    BPBID_Arrays.BreedsPerSpecies[2962] = {4}
    BPBID_Arrays.BreedsPerSpecies[2963] = {10}
    BPBID_Arrays.BreedsPerSpecies[2964] = {3, 5, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[2965] = {3}
    BPBID_Arrays.BreedsPerSpecies[2966] = {6}
    BPBID_Arrays.BreedsPerSpecies[2967] = {6}
    BPBID_Arrays.BreedsPerSpecies[2968] = {7}
    BPBID_Arrays.BreedsPerSpecies[2969] = {5}
    BPBID_Arrays.BreedsPerSpecies[2970] = {5}
    BPBID_Arrays.BreedsPerSpecies[2971] = {6}
    BPBID_Arrays.BreedsPerSpecies[2972] = {8}
    BPBID_Arrays.BreedsPerSpecies[2973] = {4}
    BPBID_Arrays.BreedsPerSpecies[2974] = {3}
    BPBID_Arrays.BreedsPerSpecies[2975] = {3}
    BPBID_Arrays.BreedsPerSpecies[2976] = {8}
    BPBID_Arrays.BreedsPerSpecies[2977] = {9}
    BPBID_Arrays.BreedsPerSpecies[2978] = {9}
    BPBID_Arrays.BreedsPerSpecies[2979] = {7}
    BPBID_Arrays.BreedsPerSpecies[2980] = {5}
    BPBID_Arrays.BreedsPerSpecies[2981] = {4}
    BPBID_Arrays.BreedsPerSpecies[2982] = {4}
    BPBID_Arrays.BreedsPerSpecies[2983] = {9}
    BPBID_Arrays.BreedsPerSpecies[2984] = {9}
    BPBID_Arrays.BreedsPerSpecies[2985] = {4}
    BPBID_Arrays.BreedsPerSpecies[2986] = {9}
    BPBID_Arrays.BreedsPerSpecies[2987] = {5}
    BPBID_Arrays.BreedsPerSpecies[2988] = {4}
    BPBID_Arrays.BreedsPerSpecies[2989] = {4}
    BPBID_Arrays.BreedsPerSpecies[2990] = {3}
    BPBID_Arrays.BreedsPerSpecies[2991] = {4}
    BPBID_Arrays.BreedsPerSpecies[2992] = {4}
    BPBID_Arrays.BreedsPerSpecies[2993] = {6}
    BPBID_Arrays.BreedsPerSpecies[2994] = {6}
    BPBID_Arrays.BreedsPerSpecies[2995] = false
    BPBID_Arrays.BreedsPerSpecies[2996] = {4}
    BPBID_Arrays.BreedsPerSpecies[2997] = false
    BPBID_Arrays.BreedsPerSpecies[2998] = {6}
    BPBID_Arrays.BreedsPerSpecies[2999] = {4}
    BPBID_Arrays.BreedsPerSpecies[3000] = {8}
    BPBID_Arrays.BreedsPerSpecies[3001] = {12}
    BPBID_Arrays.BreedsPerSpecies[3002] = {4}
    BPBID_Arrays.BreedsPerSpecies[3003] = {9}
    BPBID_Arrays.BreedsPerSpecies[3004] = {4}
    BPBID_Arrays.BreedsPerSpecies[3005] = {3}
    BPBID_Arrays.BreedsPerSpecies[3006] = {6}
    BPBID_Arrays.BreedsPerSpecies[3007] = {3, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[3008] = {5}
    BPBID_Arrays.BreedsPerSpecies[3009] = {4}
    BPBID_Arrays.BreedsPerSpecies[3010] = {3}
    BPBID_Arrays.BreedsPerSpecies[3011] = {5}
    BPBID_Arrays.BreedsPerSpecies[3012] = {6}
    BPBID_Arrays.BreedsPerSpecies[3013] = {4, 7}
    BPBID_Arrays.BreedsPerSpecies[3014] = {3, 7, 8, 10}
    BPBID_Arrays.BreedsPerSpecies[3015] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[3016] = {9}
    BPBID_Arrays.BreedsPerSpecies[3017] = {7}
    BPBID_Arrays.BreedsPerSpecies[3018] = {6}
    BPBID_Arrays.BreedsPerSpecies[3019] = {6}
    BPBID_Arrays.BreedsPerSpecies[3020] = {5, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[3021] = {5, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[3022] = {5}
    BPBID_Arrays.BreedsPerSpecies[3023] = {8}
    BPBID_Arrays.BreedsPerSpecies[3024] = {7}
    BPBID_Arrays.BreedsPerSpecies[3025] = {5}
    BPBID_Arrays.BreedsPerSpecies[3026] = {6, 7}
    BPBID_Arrays.BreedsPerSpecies[3027] = {9, 12}
    BPBID_Arrays.BreedsPerSpecies[3028] = {4, 10}
    BPBID_Arrays.BreedsPerSpecies[3029] = {5, 8}
    BPBID_Arrays.BreedsPerSpecies[3030] = {7, 8}
    BPBID_Arrays.BreedsPerSpecies[3031] = false
    BPBID_Arrays.BreedsPerSpecies[3032] = {4, 10}
    BPBID_Arrays.BreedsPerSpecies[3033] = {7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[3034] = {8}
    BPBID_Arrays.BreedsPerSpecies[3035] = {10, 12}
    BPBID_Arrays.BreedsPerSpecies[3036] = {4}
    BPBID_Arrays.BreedsPerSpecies[3037] = {8, 10}
    BPBID_Arrays.BreedsPerSpecies[3038] = {3, 7}
    BPBID_Arrays.BreedsPerSpecies[3039] = {8, 9}
    BPBID_Arrays.BreedsPerSpecies[3040] = {3, 11}
    BPBID_Arrays.BreedsPerSpecies[3041] = {6}
    BPBID_Arrays.BreedsPerSpecies[3042] = {6}
    BPBID_Arrays.BreedsPerSpecies[3043] = {8}
    BPBID_Arrays.BreedsPerSpecies[3044] = {4, 8}
    BPBID_Arrays.BreedsPerSpecies[3045] = {9}
    BPBID_Arrays.BreedsPerSpecies[3046] = {8}
    BPBID_Arrays.BreedsPerSpecies[3047] = {5}
    BPBID_Arrays.BreedsPerSpecies[3048] = false
    BPBID_Arrays.BreedsPerSpecies[3049] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[3050] = {3, 5, 8, 12}
    BPBID_Arrays.BreedsPerSpecies[3051] = {3, 6, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[3052] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[3053] = {8}
    BPBID_Arrays.BreedsPerSpecies[3054] = {8}
    BPBID_Arrays.BreedsPerSpecies[3055] = false
    BPBID_Arrays.BreedsPerSpecies[3056] = false
    BPBID_Arrays.BreedsPerSpecies[3057] = false
    BPBID_Arrays.BreedsPerSpecies[3058] = false
    BPBID_Arrays.BreedsPerSpecies[3059] = false
    BPBID_Arrays.BreedsPerSpecies[3060] = false
    BPBID_Arrays.BreedsPerSpecies[3061] = {12}
    BPBID_Arrays.BreedsPerSpecies[3062] = {7}
    BPBID_Arrays.BreedsPerSpecies[3063] = {5, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[3064] = {8}
    BPBID_Arrays.BreedsPerSpecies[3065] = {4}
    BPBID_Arrays.BreedsPerSpecies[3066] = {11}
    BPBID_Arrays.BreedsPerSpecies[3067] = {8}
    BPBID_Arrays.BreedsPerSpecies[3068] = false
    BPBID_Arrays.BreedsPerSpecies[3069] = false
    BPBID_Arrays.BreedsPerSpecies[3070] = false
    BPBID_Arrays.BreedsPerSpecies[3071] = false
    BPBID_Arrays.BreedsPerSpecies[3072] = false
    BPBID_Arrays.BreedsPerSpecies[3073] = false
    BPBID_Arrays.BreedsPerSpecies[3074] = false
    BPBID_Arrays.BreedsPerSpecies[3075] = false
    BPBID_Arrays.BreedsPerSpecies[3076] = false
    BPBID_Arrays.BreedsPerSpecies[3077] = false
    BPBID_Arrays.BreedsPerSpecies[3078] = false
    BPBID_Arrays.BreedsPerSpecies[3079] = {8}
    BPBID_Arrays.BreedsPerSpecies[3080] = {8, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[3081] = {3, 5, 7, 8, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[3082] = {3, 5, 8, 9, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[3083] = {3, 5, 8, 9, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[3084] = false
    BPBID_Arrays.BreedsPerSpecies[3085] = false
    BPBID_Arrays.BreedsPerSpecies[3086] = false
    BPBID_Arrays.BreedsPerSpecies[3087] = false
    BPBID_Arrays.BreedsPerSpecies[3088] = false
    BPBID_Arrays.BreedsPerSpecies[3089] = false
    BPBID_Arrays.BreedsPerSpecies[3090] = false
    BPBID_Arrays.BreedsPerSpecies[3091] = false
    BPBID_Arrays.BreedsPerSpecies[3092] = {9}
    BPBID_Arrays.BreedsPerSpecies[3093] = false
    BPBID_Arrays.BreedsPerSpecies[3094] = false
    BPBID_Arrays.BreedsPerSpecies[3095] = false
    BPBID_Arrays.BreedsPerSpecies[3096] = false
    BPBID_Arrays.BreedsPerSpecies[3097] = {6}
    BPBID_Arrays.BreedsPerSpecies[3098] = {7}
    BPBID_Arrays.BreedsPerSpecies[3099] = {4}
    BPBID_Arrays.BreedsPerSpecies[3100] = false
    BPBID_Arrays.BreedsPerSpecies[3101] = {8}
    BPBID_Arrays.BreedsPerSpecies[3102] = {3, 5, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[3103] = {5, 8}
    BPBID_Arrays.BreedsPerSpecies[3104] = {7}
    BPBID_Arrays.BreedsPerSpecies[3105] = {3}
    BPBID_Arrays.BreedsPerSpecies[3106] = {9}
    BPBID_Arrays.BreedsPerSpecies[3107] = {5}
    BPBID_Arrays.BreedsPerSpecies[3108] = {5, 11}
    BPBID_Arrays.BreedsPerSpecies[3109] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[3110] = {8}
    BPBID_Arrays.BreedsPerSpecies[3111] = {3, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[3112] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[3113] = {7}
    BPBID_Arrays.BreedsPerSpecies[3114] = {3, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[3115] = {5, 8, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[3116] = {8}
    BPBID_Arrays.BreedsPerSpecies[3117] = {7}
    BPBID_Arrays.BreedsPerSpecies[3118] = {3, 8, 9, 11}
    BPBID_Arrays.BreedsPerSpecies[3119] = {3, 4, 5, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[3120] = {6, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[3121] = {7}
    BPBID_Arrays.BreedsPerSpecies[3122] = {4}
    BPBID_Arrays.BreedsPerSpecies[3123] = {3, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[3124] = {6, 7}
    BPBID_Arrays.BreedsPerSpecies[3125] = {5}
    BPBID_Arrays.BreedsPerSpecies[3126] = {3, 7, 9, 12}
    BPBID_Arrays.BreedsPerSpecies[3127] = {4}
    BPBID_Arrays.BreedsPerSpecies[3128] = {8}
    BPBID_Arrays.BreedsPerSpecies[3129] = {4}
    BPBID_Arrays.BreedsPerSpecies[3130] = {12}
    BPBID_Arrays.BreedsPerSpecies[3131] = {3, 9}
    BPBID_Arrays.BreedsPerSpecies[3132] = {7}
    BPBID_Arrays.BreedsPerSpecies[3133] = {6}
    BPBID_Arrays.BreedsPerSpecies[3134] = {5, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[3135] = {9, 10, 12}
    BPBID_Arrays.BreedsPerSpecies[3136] = {7}
    BPBID_Arrays.BreedsPerSpecies[3137] = {6}
    BPBID_Arrays.BreedsPerSpecies[3138] = {12}
    BPBID_Arrays.BreedsPerSpecies[3139] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[3140] = {6}
    BPBID_Arrays.BreedsPerSpecies[3141] = {3, 9, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[3142] = false
    BPBID_Arrays.BreedsPerSpecies[3143] = false
    BPBID_Arrays.BreedsPerSpecies[3144] = false
    BPBID_Arrays.BreedsPerSpecies[3145] = false
    BPBID_Arrays.BreedsPerSpecies[3146] = false
    BPBID_Arrays.BreedsPerSpecies[3147] = false
    BPBID_Arrays.BreedsPerSpecies[3148] = false
    BPBID_Arrays.BreedsPerSpecies[3149] = false
    BPBID_Arrays.BreedsPerSpecies[3150] = false
    BPBID_Arrays.BreedsPerSpecies[3151] = false
    BPBID_Arrays.BreedsPerSpecies[3152] = false
    BPBID_Arrays.BreedsPerSpecies[3153] = {11}
    BPBID_Arrays.BreedsPerSpecies[3154] = false
    BPBID_Arrays.BreedsPerSpecies[3155] = false
    BPBID_Arrays.BreedsPerSpecies[3156] = false
    BPBID_Arrays.BreedsPerSpecies[3157] = false
    BPBID_Arrays.BreedsPerSpecies[3158] = false
    BPBID_Arrays.BreedsPerSpecies[3159] = false
    BPBID_Arrays.BreedsPerSpecies[3160] = false
    BPBID_Arrays.BreedsPerSpecies[3161] = false
    BPBID_Arrays.BreedsPerSpecies[3162] = false
    BPBID_Arrays.BreedsPerSpecies[3163] = false
    BPBID_Arrays.BreedsPerSpecies[3164] = false
    BPBID_Arrays.BreedsPerSpecies[3165] = false
    BPBID_Arrays.BreedsPerSpecies[3166] = false
    BPBID_Arrays.BreedsPerSpecies[3167] = false
    BPBID_Arrays.BreedsPerSpecies[3168] = false
    BPBID_Arrays.BreedsPerSpecies[3169] = {9}
    BPBID_Arrays.BreedsPerSpecies[3170] = {9}
    BPBID_Arrays.BreedsPerSpecies[3171] = {9}
    BPBID_Arrays.BreedsPerSpecies[3172] = {4}
    BPBID_Arrays.BreedsPerSpecies[3173] = {3, 6, 7, 12}
    BPBID_Arrays.BreedsPerSpecies[3174] = {3}
    BPBID_Arrays.BreedsPerSpecies[3175] = false
    BPBID_Arrays.BreedsPerSpecies[3176] = {3}
    BPBID_Arrays.BreedsPerSpecies[3177] = false
    BPBID_Arrays.BreedsPerSpecies[3178] = {3}
    BPBID_Arrays.BreedsPerSpecies[3179] = {3}
    BPBID_Arrays.BreedsPerSpecies[3180] = {4}
    BPBID_Arrays.BreedsPerSpecies[3181] = {3}
    BPBID_Arrays.BreedsPerSpecies[3182] = false
    BPBID_Arrays.BreedsPerSpecies[3183] = false
    BPBID_Arrays.BreedsPerSpecies[3184] = false
    BPBID_Arrays.BreedsPerSpecies[3185] = false
    BPBID_Arrays.BreedsPerSpecies[3186] = false
    BPBID_Arrays.BreedsPerSpecies[3187] = false
    BPBID_Arrays.BreedsPerSpecies[3188] = false
    BPBID_Arrays.BreedsPerSpecies[3189] = {5}
    BPBID_Arrays.BreedsPerSpecies[3190] = {3, 5, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[3191] = {3, 5, 7, 9, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[3192] = false
    BPBID_Arrays.BreedsPerSpecies[3193] = false
    BPBID_Arrays.BreedsPerSpecies[3194] = false
    BPBID_Arrays.BreedsPerSpecies[3195] = false
    BPBID_Arrays.BreedsPerSpecies[3196] = {3, 4, 5, 8, 11}
    BPBID_Arrays.BreedsPerSpecies[3197] = {3}
    BPBID_Arrays.BreedsPerSpecies[3198] = false
    BPBID_Arrays.BreedsPerSpecies[3199] = false
    BPBID_Arrays.BreedsPerSpecies[3200] = {5}
    BPBID_Arrays.BreedsPerSpecies[3201] = {3}
    BPBID_Arrays.BreedsPerSpecies[3202] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[3203] = {3, 5, 11}
    BPBID_Arrays.BreedsPerSpecies[3204] = {3}
    BPBID_Arrays.BreedsPerSpecies[3205] = {3, 6, 7, 9}
    BPBID_Arrays.BreedsPerSpecies[3206] = {3, 4, 5, 9}
    BPBID_Arrays.BreedsPerSpecies[3207] = {3}
    BPBID_Arrays.BreedsPerSpecies[3208] = {3, 5}
    BPBID_Arrays.BreedsPerSpecies[3209] = {5}
    BPBID_Arrays.BreedsPerSpecies[3210] = {4, 5}
    BPBID_Arrays.BreedsPerSpecies[3211] = {3}
    BPBID_Arrays.BreedsPerSpecies[3212] = {3, 10, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[3213] = {4, 5, 8, 10, 11}
    BPBID_Arrays.BreedsPerSpecies[3214] = {5}
    BPBID_Arrays.BreedsPerSpecies[3215] = {3, 8, 9}
    BPBID_Arrays.BreedsPerSpecies[3216] = {3, 5, 8}
    BPBID_Arrays.BreedsPerSpecies[3217] = {3, 4, 5}
    BPBID_Arrays.BreedsPerSpecies[3218] = {3, 5, 11, 12}
    BPBID_Arrays.BreedsPerSpecies[3219] = {3, 5, 12}
    BPBID_Arrays.BreedsPerSpecies[3220] = {5}
    BPBID_Arrays.BreedsPerSpecies[3221] = {10}
    BPBID_Arrays.BreedsPerSpecies[3222] = {3}
    BPBID_Arrays.BreedsPerSpecies[3223] = {3}
    BPBID_Arrays.BreedsPerSpecies[3224] = {3}
    BPBID_Arrays.BreedsPerSpecies[3225] = false
    BPBID_Arrays.BreedsPerSpecies[3226] = {5}
    BPBID_Arrays.BreedsPerSpecies[3227] = {3}
    BPBID_Arrays.BreedsPerSpecies[3228] = false
    BPBID_Arrays.BreedsPerSpecies[3229] = {3}
    BPBID_Arrays.BreedsPerSpecies[3230] = {3}
    BPBID_Arrays.BreedsPerSpecies[3231] = {3}
    BPBID_Arrays.BreedsPerSpecies[3232] = {5}
    BPBID_Arrays.BreedsPerSpecies[3233] = {3}
    BPBID_Arrays.BreedsPerSpecies[3234] = {3}
    BPBID_Arrays.BreedsPerSpecies[3235] = {3}
    BPBID_Arrays.BreedsPerSpecies[3236] = false
    BPBID_Arrays.BreedsPerSpecies[3237] = {3}
    BPBID_Arrays.BreedsPerSpecies[3238] = false
    BPBID_Arrays.BreedsPerSpecies[3239] = false
    BPBID_Arrays.BreedsPerSpecies[3240] = false
    BPBID_Arrays.BreedsPerSpecies[3241] = false
    BPBID_Arrays.BreedsPerSpecies[3242] = false
    BPBID_Arrays.BreedsPerSpecies[3243] = false
    BPBID_Arrays.BreedsPerSpecies[3244] = false
    BPBID_Arrays.BreedsPerSpecies[3245] = false
    BPBID_Arrays.BreedsPerSpecies[3246] = false
    BPBID_Arrays.BreedsPerSpecies[3247] = {3}
end


--[[
Written by: Hugh@Burning Blade-US and Simca@Malfurion-US

Special thanks to Ro for letting me bounce solutions off him regarding tooltip conflicts.
]]--

-- The only localized functions needed here
local PB_GetName = _G.C_PetBattles.GetName
local PJ_GetPetInfoByPetID = C_PetJournal.GetPetInfoByPetID
local PJ_GetPetInfoBySpeciesID = C_PetJournal.GetPetInfoBySpeciesID
local PJ_GetPetStats = C_PetJournal.GetPetStats
local ceil = math.ceil

-- Initalize AddOn locals used in this section
local BattleNameText = ""
local BPTNameText = ""

-- This is the new Battle Pet BreedID "Breed Tooltip" creation and setup function
function BPBID_SetBreedTooltip(parent, speciesID, tblBreedID, rareness, tooltipDistance)

    -- Impossible checks (if missing parent, speciesID, or "rareness")
    local rarity
    if (not parent) or (not speciesID) then return end
    if (rareness) then
        rarity = rareness
    else
        rarity = 4
    end

    -- Arrays are now initialized if they weren't before
    if (not BPBID_Arrays.BasePetStats) then BPBID_Arrays.InitializeArrays() end

    -- Set local reference to my tooltip or create it if it doesn't exist
    -- It inherits TooltipBorderedFrameTemplate AND GameTooltipTemplate to match Blizzard's "psuedo-tooltips" yet still make it easy to use 
    local breedtip
    local breedtiptext
    if (parent == FloatingBattlePetTooltip) then
        breedtiptext = "BPBID_BreedTooltip2"
    else
        breedtiptext = "BPBID_BreedTooltip"
    end

    breedtip = _G[breedtiptext] or CreateFrame("GameTooltip", breedtiptext, nil, "GameTooltipTemplate")

    -- Check for existence of LibExtraTip
    local extratip = false
    if (internal.LibExtraTip) and (internal.LibExtraTip.GetExtraTip) then
        extratip = internal.LibExtraTip:GetExtraTip(parent)

        -- See if it has hooked our parent
        if (extratip) and (extratip:IsVisible()) then
            parent = extratip
        end
    end

    -- Set positioning/parenting/ownership of Breed Tooltip
    breedtip:SetParent(parent)
    breedtip:SetOwner(parent, "ANCHOR_NONE")
    breedtip:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, tooltipDistance or 2)
    breedtip:SetPoint("TOPRIGHT", parent, "BOTTOMRIGHT", 0, tooltipDistance or 2)

    -- Workaround for TradeSkillMaster's tooltip
    -- Note that setting parent breaks floating tooltip and setting two corner points breaks borders on TSM tooltip
    -- Setting parent is also required for BattlePetTooltip because TSMExtraTip constantly reanchors itself on its parent
    if (_G.IsAddOnLoaded("TradeSkillMaster")) then
        for i = 1, 10 do
            local t = _G["TSMExtraTip" .. i]
            if t then
                local _, relativeFrame = t:GetPoint("TOP")
                if (relativeFrame == BattlePetTooltip) then
                    t:ClearAllPoints()
                    t:SetParent(BPBID_BreedTooltip)
                    t:SetPoint("TOP", BPBID_BreedTooltip, "BOTTOM", 0, -1)
                elseif (t:GetParent() == FloatingBattlePetTooltip) then
                    t:ClearAllPoints()
                    t:SetPoint("TOP", BPBID_BreedTooltip2, "BOTTOM", 0, -1)
                end
            end
        end
    end

    -- Set line for "Current pet's breed"
    if (BPBID_Options.Breedtip.Current) and (tblBreedID) then
        local current = "\124cFFD4A017Current Breed:\124r "
        local numBreeds = #tblBreedID
        for i = 1, numBreeds do
            if (i == 1) then
                current = current .. internal.RetrieveBreedName(tblBreedID[i])
            elseif (i == 2) and (i == numBreeds) then
                current = current .. " or " .. internal.RetrieveBreedName(tblBreedID[i])
            elseif (i == numBreeds) then
                current = current .. ", or " .. internal.RetrieveBreedName(tblBreedID[i])
            else
                current = current .. ", " .. internal.RetrieveBreedName(tblBreedID[i])
            end
        end
        breedtip:AddLine(current, 1, 1, 1, 1)
    end

    -- Set line for "Current pet's possible breeds"
    if (BPBID_Options.Breedtip.Possible) then
        local possible = "\124cFFD4A017Possible Breed"
        if (speciesID) and (BPBID_Arrays.BreedsPerSpecies[speciesID]) then
            local numBreeds = #BPBID_Arrays.BreedsPerSpecies[speciesID]
            if numBreeds == internal.MAX_BREEDS then
                possible = possible .. "s:\124r All"
            else
                for i = 1, numBreeds do
                    if (numBreeds == 1) then
                        possible = possible .. ":\124r " .. internal.RetrieveBreedName(BPBID_Arrays.BreedsPerSpecies[speciesID][i])
                    elseif (i == 1) then
                        possible = possible .. "s:\124r " .. internal.RetrieveBreedName(BPBID_Arrays.BreedsPerSpecies[speciesID][i])
                    elseif (i == 2) and (i == numBreeds) then
                        possible = possible .. " and " .. internal.RetrieveBreedName(BPBID_Arrays.BreedsPerSpecies[speciesID][i])
                    elseif (i == numBreeds) then
                        possible = possible .. ", and " .. internal.RetrieveBreedName(BPBID_Arrays.BreedsPerSpecies[speciesID][i])
                    else
                        possible = possible .. ", " .. internal.RetrieveBreedName(BPBID_Arrays.BreedsPerSpecies[speciesID][i])
                    end
                end
            end
        else
            possible = possible .. "s:\124r Unknown"
        end
        breedtip:AddLine(possible, 1, 1, 1, 1)
    end

    -- Have to have BasePetStats from here on out
    if (BPBID_Arrays.BasePetStats[speciesID]) then
        -- Set line for "Pet species' base stats"
        if (BPBID_Options.Breedtip.SpeciesBase) then
            local speciesbase = "\124cFFD4A017Base Stats:\124r " .. BPBID_Arrays.BasePetStats[speciesID][1] .. "/" .. BPBID_Arrays.BasePetStats[speciesID][2] .. "/" .. BPBID_Arrays.BasePetStats[speciesID][3]
            breedtip:AddLine(speciesbase, 1, 1, 1, 1)
        end

        local extrabreeds
        -- Check duplicates (have to have BreedsPerSpecies and tblBreedID for this)
        if (BPBID_Arrays.BreedsPerSpecies[speciesID]) and (tblBreedID) then
            extrabreeds = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
            -- "inspection" time! if the breed is not found in the array, it doesn't get passed on to extrabreeds and is effectively discarded
            for q = 1, #tblBreedID do
                for i = 1, #BPBID_Arrays.BreedsPerSpecies[speciesID] do
                    local j = BPBID_Arrays.BreedsPerSpecies[speciesID][i]
                    if (tblBreedID[q] == j) then extrabreeds[j - 2] = false end -- If the breed is found in both tables, flag it as false
                    if (extrabreeds[j - 2]) then extrabreeds[j - 2] = j end
                end
            end
        end

        -- Set line for "Current breed's base stats (level 1 Poor)" (have to have tblBreedID for this)
        if (BPBID_Options.Breedtip.CurrentStats) and (tblBreedID) then
            for i = 1, #tblBreedID do
                local currentbreed = tblBreedID[i]
                local currentstats = "\124cFFD4A017Breed " .. internal.RetrieveBreedName(currentbreed) .. "*:\124r " .. (BPBID_Arrays.BasePetStats[speciesID][1] + BPBID_Arrays.BreedStats[currentbreed][1]) .. "/" .. (BPBID_Arrays.BasePetStats[speciesID][2] + BPBID_Arrays.BreedStats[currentbreed][2]) .. "/" .. (BPBID_Arrays.BasePetStats[speciesID][3] + BPBID_Arrays.BreedStats[currentbreed][3])
                breedtip:AddLine(currentstats, 1, 1, 1, 1)
            end
        end

        -- Set line for "All breeds' base stats (level 1 Poor)" (have to have BreedsPerSpecies for this)
        if (BPBID_Options.Breedtip.AllStats) and (BPBID_Arrays.BreedsPerSpecies[speciesID]) then
            if (not BPBID_Options.Breedtip.CurrentStats) or (not extrabreeds) then
                for i = 1, #BPBID_Arrays.BreedsPerSpecies[speciesID] do
                    local currentbreed = BPBID_Arrays.BreedsPerSpecies[speciesID][i]
                    local allstatsp1 = "\124cFFD4A017Breed " .. internal.RetrieveBreedName(currentbreed)
                    local allstatsp2 = ":\124r " .. (BPBID_Arrays.BasePetStats[speciesID][1] + BPBID_Arrays.BreedStats[currentbreed][1]) .. "/" .. (BPBID_Arrays.BasePetStats[speciesID][2] + BPBID_Arrays.BreedStats[currentbreed][2]) .. "/" .. (BPBID_Arrays.BasePetStats[speciesID][3] + BPBID_Arrays.BreedStats[currentbreed][3])
                    local allstats -- Will be defined by the if statement below to see the asterisk needs to be added
                    
                    if (not extrabreeds) or ((extrabreeds[currentbreed - 2]) and (extrabreeds[currentbreed - 2] > 2)) then
                        allstats = allstatsp1 .. allstatsp2
                    else
                        allstats = allstatsp1 .. "*" .. allstatsp2
                    end
                    
                    breedtip:AddLine(allstats, 1, 1, 1, 1)
                end
            else
                for i = 1, 10 do
                    if (extrabreeds[i]) and (extrabreeds[i] > 2) then
                        local currentbreed = i + 2
                        local allstats = "\124cFFD4A017Breed " .. internal.RetrieveBreedName(currentbreed) .. ":\124r " .. (BPBID_Arrays.BasePetStats[speciesID][1] + BPBID_Arrays.BreedStats[currentbreed][1]) .. "/" .. (BPBID_Arrays.BasePetStats[speciesID][2] + BPBID_Arrays.BreedStats[currentbreed][2]) .. "/" .. (BPBID_Arrays.BasePetStats[speciesID][3] + BPBID_Arrays.BreedStats[currentbreed][3])
                        breedtip:AddLine(allstats, 1, 1, 1, 1)
                    end
                end
            end
        end

        -- Set line for "Current breed's stats at level 25" (have to have tblBreedID for this)
        if (BPBID_Options.Breedtip.CurrentStats25) and (tblBreedID) then
            for i = 1, #tblBreedID do
                local currentbreed = tblBreedID[i]
                local hex = "\124cFF0070DD" -- Always use rare color by default
                local quality = 4 -- Always use rare pet quality by default

                -- Unless the user specifies they want the real color OR the pet is epic/legendary quality
                if (not BPBID_Options.Breedtip.AllStats25Rare) or (rarity > 4) then
                    hex = ITEM_QUALITY_COLORS[rarity - 1].hex
                    quality = rarity
                end

                local currentstats25 = hex .. internal.RetrieveBreedName(currentbreed) .. "* at 25:\124r " .. ceil((BPBID_Arrays.BasePetStats[speciesID][1] + BPBID_Arrays.BreedStats[currentbreed][1]) * 25 * ((BPBID_Arrays.RealRarityValues[quality] - 0.5) * 2 + 1) * 5 + 100 - 0.5) .. "/" .. ceil((BPBID_Arrays.BasePetStats[speciesID][2] + BPBID_Arrays.BreedStats[currentbreed][2]) * 25 * ((BPBID_Arrays.RealRarityValues[quality] - 0.5) * 2 + 1) - 0.5) .. "/" .. ceil((BPBID_Arrays.BasePetStats[speciesID][3] + BPBID_Arrays.BreedStats[currentbreed][3]) * 25 * ((BPBID_Arrays.RealRarityValues[quality] - 0.5) * 2 + 1) - 0.5)
                breedtip:AddLine(currentstats25, 1, 1, 1, 1)
            end
        end

        -- Set line for "All breeds' stats at level 25" (have to have BreedsPerSpecies for this)
        if (BPBID_Options.Breedtip.AllStats25) and (BPBID_Arrays.BreedsPerSpecies[speciesID]) then
            local hex = "\124cFF0070DD" -- Always use rare color by default
            local quality = 4 -- Always use rare pet quality by default

            -- Unless the user specifies they want the real color OR the pet is epic/legendary quality
            if (not BPBID_Options.Breedtip.AllStats25Rare) or (rarity > 4) then
                hex = ITEM_QUALITY_COLORS[rarity - 1].hex
                quality = rarity
            end

            -- Choose loop (whether I have to show ALL breeds including the one I am looking at or just the other breeds besides the one I'm looking at)
            if ((rarity == 4) and (BPBID_Options.Breedtip.CurrentStats25Rare ~= BPBID_Options.Breedtip.AllStats25Rare)) or (not BPBID_Options.Breedtip.CurrentStats25) or (not extrabreeds) then
                for i = 1, #BPBID_Arrays.BreedsPerSpecies[speciesID] do
                    local currentbreed = BPBID_Arrays.BreedsPerSpecies[speciesID][i]
                    local allstats25p1 = hex .. internal.RetrieveBreedName(currentbreed)
                    local allstats25p2 = " at 25:\124r " .. ceil((BPBID_Arrays.BasePetStats[speciesID][1] + BPBID_Arrays.BreedStats[currentbreed][1]) * 25 * ((BPBID_Arrays.RealRarityValues[quality] - 0.5) * 2 + 1) * 5 + 100 - 0.5) .. "/" .. ceil((BPBID_Arrays.BasePetStats[speciesID][2] + BPBID_Arrays.BreedStats[currentbreed][2]) * 25 * ((BPBID_Arrays.RealRarityValues[quality] - 0.5) * 2 + 1) - 0.5) .. "/" .. ceil((BPBID_Arrays.BasePetStats[speciesID][3] + BPBID_Arrays.BreedStats[currentbreed][3]) * 25 * ((BPBID_Arrays.RealRarityValues[quality] - 0.5) * 2 + 1) - 0.5)
                    local allstats25 -- Will be defined by the if statement below to see the asterisk needs to be added

                    if (not extrabreeds) or ((extrabreeds[currentbreed - 2]) and (extrabreeds[currentbreed - 2] > 2)) then
                        allstats25 = allstats25p1 .. allstats25p2
                    else
                        allstats25 = allstats25p1 .. "*" .. allstats25p2
                    end
                    
                    breedtip:AddLine(allstats25, 1, 1, 1, 1)
                end
            else
                for i = 1, 10 do
                    if (extrabreeds[i]) and (extrabreeds[i] > 2) then
                        local currentbreed = i + 2
                        local allstats25 = hex .. internal.RetrieveBreedName(currentbreed) .. " at 25:\124r " .. ceil((BPBID_Arrays.BasePetStats[speciesID][1] + BPBID_Arrays.BreedStats[currentbreed][1]) * 25 * ((BPBID_Arrays.RealRarityValues[quality] - 0.5) * 2 + 1) * 5 + 100 - 0.5) .. "/" .. ceil((BPBID_Arrays.BasePetStats[speciesID][2] + BPBID_Arrays.BreedStats[currentbreed][2]) * 25 * ((BPBID_Arrays.RealRarityValues[quality] - 0.5) * 2 + 1) - 0.5) .. "/" .. ceil((BPBID_Arrays.BasePetStats[speciesID][3] + BPBID_Arrays.BreedStats[currentbreed][3]) * 25 * ((BPBID_Arrays.RealRarityValues[quality] - 0.5) * 2 + 1) - 0.5)
                        breedtip:AddLine(allstats25, 1, 1, 1, 1)
                    end
                end
            end
        end
    end

    -- Fix wordwrapping on smaller tooltips
    if _G[breedtiptext .. "TextLeft1"] then
        _G[breedtiptext .. "TextLeft1"]:CanNonSpaceWrap(true)
    end

    -- Fix fonts to all match (if multiple lines exist, which they should 99.9% of the time)
    if _G[breedtiptext .. "TextLeft2"] then
        -- Get fonts from line 1
        local fontpath, fontheight, fontflags = _G[breedtiptext .. "TextLeft1"]:GetFont()

        -- Set iterator at line 2 to start
        local iterline = 2

        -- Match all fonts to line 1
        while _G[breedtiptext .. "TextLeft" .. iterline] do
            _G[breedtiptext .. "TextLeft" .. iterline]:SetFont(fontpath, fontheight, fontflags)
            _G[breedtiptext .. "TextLeft" .. iterline]:CanNonSpaceWrap(true)
            iterline = iterline + 1
        end
    end

    -- Resize height automatically when reshown
    breedtip:Show()
end

-- Display breed, quality if necessary, and breed tooltips on pet frames/tooltips in Pet Battles
local function BPBID_Hook_BattleUpdate(self)
    if not self.petOwner or not self.petIndex or not self.Name then return end

    -- Cache all pets if it is the start of a battle
    if (internal.cacheTime == true) then internal.CacheAllPets() internal.cacheTime = false end

    -- Check if it is a tooltip
    local tooltip = (self:GetName() == "PetBattlePrimaryUnitTooltip")

    -- Calculate offset
    local offset = 0
    if (self.petOwner == 2) then offset = 3 end

    -- Retrieve breed
    local breed = internal.RetrieveBreedName(internal.breedCache[self.petIndex + offset])

    -- Get pet's name
    local name = PB_GetName(self.petOwner, self.petIndex)

    if not tooltip then
        -- Set the name header if the user wants
        if (name) and (BPBID_Options.Names.PrimaryBattle) then
            -- Set standard text or use hex coloring based on font fix option
            if (BPBID_Options.BattleFontFix) then
                local _, _, _, hex = GetItemQualityColor(internal.rarityCache[self.petIndex + offset] - 1)
                self.Name:SetText("|c"..hex..name.." ["..breed.."]".."|r")
            else
                self.Name:SetText(name.." ["..breed.."]")
            end
        end
    else
        -- Set the name header if the user wants
        if (name) and (BPBID_Options.Names.BattleTooltip) then
            -- Set standard text or use hex coloring based on font fix option
            if (not BPBID_Options.BattleFontFix) then
                local _, _, _, hex = GetItemQualityColor(internal.rarityCache[self.petIndex + offset] - 1)
                self.Name:SetText("|c"..hex..name.." ["..breed.."]".."|r")
            else
                self.Name:SetText(name.." ["..breed.."]")
            end
        end

        -- If this not the same tooltip as before
        if (BattleNameText ~= self.Name:GetText()) then

            -- Downside font if the name/breed gets chopped off
            if self.Name:IsTruncated() then
                -- Retrieve font elements
                local fontName, fontHeight, fontFlags = self.Name:GetFont()

                -- Manually set height to perserve placing of other elements
                self.Name:SetHeight(self.Name:GetHeight())

                -- Store font in addon namespace for later
                if not internal.BattleFontSize then internal.BattleFontSize = { fontName, fontHeight, fontFlags } end

                -- Decrease the font size by 1 until it fits
                while self.Name:IsTruncated() do
                    fontHeight = fontHeight - 1
                    self.Name:SetFont(fontName, fontHeight, fontFlags)
                end
            elseif internal.BattleFontSize then
                -- Reset font size to original if not truncated and original font size known
                self.Name:SetFont(internal.BattleFontSize[1], internal.BattleFontSize[2], internal.BattleFontSize[3])
            end
        end

        -- Set the name text variable to match the real name text now to prepare for the next check
        BattleNameText = self.Name:GetText()

        -- Send to tooltip
        if (BPBID_Options.Tooltips.Enabled) and (BPBID_Options.Tooltips.BattleTooltip) then
            BPBID_SetBreedTooltip(PetBattlePrimaryUnitTooltip, internal.speciesCache[self.petIndex + offset], internal.resultsCache[self.petIndex + offset], internal.rarityCache[self.petIndex + offset])
        end
    end
end

-- Display breed, quality if necessary, and breed tooltips on item-based pet tooltips
local function BPBID_Hook_BPTShow(speciesID, level, rarity, maxHealth, power, speed)
    -- Impossible checks for safety reasons
    if (not BattlePetTooltip.Name) or (not speciesID) or (not level) or (not rarity) or (not maxHealth) or (not power) or (not speed) then return end

    -- Fix rarity to match our system and calculate breedID and breedname
    rarity = rarity + 1
    local breedNum, quality, resultslist = internal.CalculateBreedID(speciesID, rarity, level, maxHealth, power, speed, false, false)

    -- Add the breed to the tooltip's name text
    if (BPBID_Options.Names.BPT) then
        local breed = internal.RetrieveBreedName(breedNum)

        -- BattlePetTooltip does not allow customnames for now, so we can just get this ourself (more reliable)
        local currentText = BattlePetTooltip.Name:GetText()

        -- Test if we've already written to the tooltip
        if not strfind(currentText, " [" .. breed .. "]") then
            -- Append breed to tooltip
            BattlePetTooltip.Name:SetText(currentText .. " [" .. breed .. "]")

            -- If this not the same tooltip as before
            if (BPTNameText ~= BattlePetTooltip.Name:GetText()) then
                -- Downside font if the name/breed gets chopped off
                if BattlePetTooltip.Name:IsTruncated() then
                    -- Retrieve font elements
                    local fontName, fontHeight, fontFlags = BattlePetTooltip.Name:GetFont()

                    -- Manually set height to perserve placing of other elements
                    BattlePetTooltip.Name:SetHeight(BattlePetTooltip.Name:GetHeight()) 
                    
                    -- Store font in addon namespace for later
                    if not internal.BPTFontSize then internal.BPTFontSize = { fontName, fontHeight, fontFlags } end
                    
                    -- Decrease the font size by 1 until it fits
                    while BattlePetTooltip.Name:IsTruncated() do
                        fontHeight = fontHeight - 1
                        BattlePetTooltip.Name:SetFont(fontName, fontHeight, fontFlags)
                    end
                elseif (internal.BPTFontSize) then
                    -- Reset font size to original if not truncated AND original font size known
                    BattlePetTooltip.Name:SetFont(internal.BPTFontSize[1], internal.BPTFontSize[2], internal.BPTFontSize[3])
                end
            end

            -- Set the name text variable to match the real name text now to prepare for the next check
            BPTNameText = BattlePetTooltip.Name:GetText()
        end
    end

    -- Set up the breed tooltip
    if (BPBID_Options.Tooltips.Enabled) and (BPBID_Options.Tooltips.BPT) then
        BPBID_SetBreedTooltip(BattlePetTooltip, speciesID, resultslist, quality)
    end
end

-- Display breed, quality if necessary, and breed tooltips on pet tooltips from chat links
local function BPBID_Hook_FBPTShow(speciesID, level, rarity, maxHealth, power, speed, name)
    -- Impossible checks for safety reasons
    if (not FloatingBattlePetTooltip.Name) or (not speciesID) or (not level) or (not rarity) or (not maxHealth) or (not power) or (not speed) then return end

    -- Fix rarity to match our system and calculate breedID and breedname
    rarity = rarity + 1
    local breedNum, quality, resultslist = internal.CalculateBreedID(speciesID, rarity, level, maxHealth, power, speed, false, false)

    -- Avoid strange quality errors (investigate further?)
    if (not quality) then return end

    -- Add the breed to the tooltip's name text
    if (BPBID_Options.Names.FBPT) then
        local breed = internal.RetrieveBreedName(breedNum)

        -- Account for possibility of not having the name passed to us
        local realname
        if (not name) then
            realname = PJ_GetPetInfoBySpeciesID(speciesID)
        else
            realname = name
        end

        -- Append breed to tooltip
        FloatingBattlePetTooltip.Name:SetText(realname.." ["..breed.."]")

        -- Could potentially try to avoid collisons better here but it will be hard because these aren't even really GameTooltips
        -- Resize all relevant parts of tooltip to avoid cutoff breeds/names (since Blizzard made these static-sized!)
        -- Use alternative method (Simca has this stored) if this doesn't work long-term
        local stringwide = FloatingBattlePetTooltip.Name:GetStringWidth() + 14
        if stringwide < 238 then stringwide = 238 end

        FloatingBattlePetTooltip:SetWidth(stringwide + 22)
        FloatingBattlePetTooltip.Name:SetWidth(stringwide)
        FloatingBattlePetTooltip.BattlePet:SetWidth(stringwide)
        FloatingBattlePetTooltip.PetType:SetPoint("TOPRIGHT", FloatingBattlePetTooltip.Name, "BOTTOMRIGHT", 0, -2)
        FloatingBattlePetTooltip.Level:SetWidth(stringwide)
        FloatingBattlePetTooltip.Delimiter:SetWidth(stringwide + 13)
        FloatingBattlePetTooltip.JournalClick:SetWidth(stringwide)
    end

    -- Set up the breed tooltip
    if (BPBID_Options.Tooltips.Enabled) and (BPBID_Options.Tooltips.FBPT) then
        if petbm and petbm.TooltipHook and petbm.TooltipHook.tooltipFrame and petbm.TooltipHook.tooltipFrame.text then
            BPBID_SetBreedTooltip(FloatingBattlePetTooltip, speciesID, resultslist, quality, 0 - (petbm.TooltipHook.tooltipFrame.text:GetHeight() + 6))
        else
            BPBID_SetBreedTooltip(FloatingBattlePetTooltip, speciesID, resultslist, quality)
        end
    end
end

-- Display breed, quality if necessary, and breed tooltips on Pet Journal tooltips
function internal.Hook_PJTEnter(self, motion)
    -- Impossible check for safety reasons
    if (not GameTooltip:IsVisible()) then return end

    if (PetJournalPetCard.petID) then
        -- Get data from PetID (which can get from the current PetCard since we know the current PetCard has to be responsible for the tooltip too)
        local speciesID, _, level = PJ_GetPetInfoByPetID(PetJournalPetCard.petID)
        local _, maxHealth, power, speed, rarity = PJ_GetPetStats(PetJournalPetCard.petID)

        -- Calculate breedID and breedname
        local breedNum, quality, resultslist = internal.CalculateBreedID(speciesID, rarity, level, maxHealth, power, speed, false, false)

        -- If fields become nil due to everything being filtered, show the special runthrough tooltip and escape from the function
        if not quality then
            BPBID_SetBreedTooltip(GameTooltip, PetJournalPetCard.speciesID, false, false)
            return
        end

        -- Add the breed to the tooltip's name text
        if (BPBID_Options.Names.PJT) then
            local breed = internal.RetrieveBreedName(breedNum)
            
            -- Write breed to tooltip
            GameTooltipTextLeft1:SetText(GameTooltipTextLeft1:GetText().." ["..breed.."]")
            
            -- Resize to avoid cutting off breed
            GameTooltip:Show()
        end

        -- Color tooltip header
        if (BPBID_Options.Names.PJTRarity) then
            GameTooltipTextLeft1:SetTextColor(ITEM_QUALITY_COLORS[quality - 1].r, ITEM_QUALITY_COLORS[quality - 1].g, ITEM_QUALITY_COLORS[quality - 1].b)
        end

        -- Set up the breed tooltip
        if (BPBID_Options.Tooltips.Enabled) and (BPBID_Options.Tooltips.PJT) then
            BPBID_SetBreedTooltip(GameTooltip, speciesID, resultslist, quality)
        end
    elseif (PetJournalPetCard.speciesID) and (BPBID_Options.Tooltips.Enabled) and (BPBID_Options.Tooltips.PJT) then
        -- Set up the breed tooltip for a special runthrough (no known breed)
        BPBID_SetBreedTooltip(GameTooltip, PetJournalPetCard.speciesID, false, false)
    end
end

function internal.Hook_PJTLeave(self, motion)
    -- Uncolor tooltip header
    if (BPBID_Options.Names.PJTRarity) then
        GameTooltipTextLeft1:SetTextColor(1, 1, 1)
    end
end

-- Hook for ArkInventory compability, following the example of BattlePetTooltip
function internal.Hook_ArkInventory(tooltip, h, i)
    -- If the user has chosen not to let ArkInventory handle Battle Pets then we won't need to intervene
    if ((tooltip ~= GameTooltip) and (tooltip ~= ItemRefTooltip)) or (not ArkInventory or not ArkInventory.db or not ArkInventory.db.option or not ArkInventory.db.option.tooltip or not ArkInventory.db.option.tooltip.battlepet or not ArkInventory.db.option.tooltip.battlepet.enable) then return end

    -- Decode string
    local class, speciesID, level, rarity, maxHealth, power, speed = unpack( ArkInventory.ObjectStringDecode( h ) )

    -- Escape if not a battlepet link
    if class ~= "battlepet" then return end

    -- Impossible checks for safety reasons
    if (not speciesID) or (not level) or (not rarity) or (not maxHealth) or (not power) or (not speed) then return end

    -- Change rarity to match our system and calculate breedID and breedname
    rarity = rarity + 1
    local breedNum, quality, resultslist = internal.CalculateBreedID(speciesID, rarity, level, maxHealth, power, speed, false, false)

    -- Fix width if too small
    local reloadTooltip = false
    if (tooltip:GetWidth() < 210) then
        tooltip:SetMinimumWidth(210)
        reloadTooltip = true
    end

    -- Add the breed to the tooltip's name text
    if (BPBID_Options.Names.BPT) and (tooltip == GameTooltip) then
        local breed = internal.RetrieveBreedName(breedNum)
        local currentText = GameTooltipTextLeft1:GetText()

        -- Test if we've already written to the tooltip
        if currentText and not strfind(currentText, " [" .. breed .. "]") then
            -- Append breed to tooltip
            GameTooltipTextLeft1:SetText(currentText .. " [" .. breed .. "]")
            reloadTooltip = true
        end
    elseif (BPBID_Options.Names.FBPT) and (tooltip == ItemRefTooltip) then
        local breed = internal.RetrieveBreedName(breedNum)
        local currentText = ItemRefTooltipTextLeft1:GetText()

        -- Append breed to tooltip
        ItemRefTooltipTextLeft1:SetText(currentText .. " [" .. breed .. "]")
        reloadTooltip = true
    end
    
    -- Reshow tooltip if needed
    if reloadTooltip then
        tooltip:Show()
    end

    -- Set up the breed tooltip
    if (BPBID_Options.Tooltips.Enabled) and (((BPBID_Options.Tooltips.BPT) and (tooltip == GameTooltip)) or ((BPBID_Options.Tooltips.FBPT) and (tooltip == ItemRefTooltip))) then
        BPBID_SetBreedTooltip(tooltip, speciesID, resultslist, quality)
    end
end

-- Hook our tooltip functions
hooksecurefunc("PetBattleUnitFrame_UpdateDisplay", BPBID_Hook_BattleUpdate)
hooksecurefunc("BattlePetToolTip_Show", BPBID_Hook_BPTShow)
hooksecurefunc("FloatingBattlePet_Show", BPBID_Hook_FBPTShow)
-- Internal.Hook_PJTEnter is called by the ADDON_LOADED event for Blizzard_Collections in BattlePetBreedID's Core
-- Internal.Hook_PJTLeave is called by the ADDON_LOADED event for Blizzard_Collections in BattlePetBreedID's Core
-- HSFUpdate is handled in BattlePetBreedID's Core entirely because it is unrelated to tooltips


--[[
Written by: Hugh@Burning Blade-US and Simca@Malfurion-US

Special thanks to Ro for inspiration for the overall structure of this options panel (and the title/version/description code)
]]--

--GLOBALS: BPBID_Options

--[[
(BPBID_Options.format) CHANGING TEXT BLURB BELOW FORMAT DROPDOWN MENU

Show BreedIDs in the Name line...
BPBID_Options.Names.PrimaryBattle: In Battle (on primary pets for both owners)
BPBID_Options.Names.BattleTooltip: In PrimaryBattlePetUnitTooltip's header (in-battle tooltips)
BPBID_Options.Names.BPT: In BattlePetTooltip's header (items)
BPBID_Options.Names.FBPT: In FloatingBattlePetTooltip's header (chat links)
BPBID_Options.Names.HSFUpdate: In the Pet Journal scrolling frame
BPBID_Options.Names.PJT: In the Pet Journal tooltips
    BPBID_Options.Names.PJTRarity: Color Pet Journal tooltip headers by rarity

BPBID_Options.Tooltips.Enabled: Enable Battle Pet BreedID Tooltips
Show Battle Pet BreedID Tooltips...
BPBID_Options.Tooltips.BattleTooltip: In Battle (PrimaryBattlePetUnitTooltip)
BPBID_Options.Tooltips.BPT: On Items (BattlePetTooltip)
BPBID_Options.Tooltips.FBPT: On Chat Links (FloatingBattlePetTooltip)
BPBID_Options.Tooltips.PJT: In the Pet Journal (GameTooltip)

In Tooltips, show...
BPBID_Options.Breedtip.Current: Current pet's breed
BPBID_Options.Breedtip.Possible: Current pet's possible breeds
BPBID_Options.Breedtip.SpeciesBase: Pet species' base stats
BPBID_Options.Breedtip.CurrentStats: Current breed's base stats (level 1 Poor)
BPBID_Options.Breedtip.AllStats: All breed's base stats (level 1 Poor)
BPBID_Options.Breedtip.CurrentStats25: Current breed's stats at level 25
    BPBID_Options.Breedtip.CurrentStats25Rare: Always assume pet will be Rare at level 25
BPBID_Options.Breedtip.AllStats25: All breeds' stats at level 25
    BPBID_Options.Breedtip.AllStats25Rare: Always assume pet will be Rare at level 25
--]]

if GetLocale() == "zhCN" then
  BattlePetBreedIDOptionsName = "|cFFBF00FF[宠物]|r三围数据";
elseif GetLocale() == "zhTW" then
  BattlePetBreedIDOptionsName = "|cFFBF00FF[宠物]|r三围数据r";
else
  BattlePetBreedIDOptionsName = "|cFFBF00FF[BB]|rBattlePet BreedID";
end

-- Create options panel
local Options = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
Options:Hide()
Options.name = BattlePetBreedIDOptionsName

-- Variable for easy positioning
local lastcheckbox

-- Ro's CreateFont function for easy FontString creation
local function CreateFont(fontName, r, g, b, anchorPoint, relativeTo, relativePoint, cx, cy, xoff, yoff, text)
    local font = Options:CreateFontString(nil, "BACKGROUND", fontName)
    font:SetJustifyH("LEFT")
    font:SetJustifyV("TOP")
    if type(r) == "string" then -- R is text, no positioning
        text = r
    else
        if r then
            font:SetTextColor(r, g, b, 1)
        end
        font:SetSize(cx, cy)
        font:SetPoint(anchorPoint, relativeTo, relativePoint, xoff, yoff)
    end
    font:SetText(text)
    return font
end

-- My CreateCheckbox function for easy Checkbox creation (going to need lots and lots)
local function CreateCheckbox(text, height, width, anchorPoint, relativeTo, relativePoint, xoff, yoff, font)
    local checkbox = CreateFrame("CheckButton", nil, Options, "UICheckButtonTemplate")
    checkbox:SetPoint(anchorPoint, relativeTo, relativePoint, xoff, yoff)
    checkbox:SetSize(height, width)
    local realfont = font or "GameFontNormal"
    checkbox.text:SetFontObject(realfont)
    checkbox.text:SetText(" " .. text)
    lastcheckbox = checkbox
    return checkbox
end

local panelWidth = InterfaceOptionsFramePanelContainer:GetWidth() -- ~623
local wideWidth = panelWidth - 40

-- Create title, version, author, and description fields
local title = CreateFont("GameFontNormalLarge", "BattlePet BreedID")
title:SetPoint("TOPLEFT", 16, -16)
local ver = CreateFont("GameFontNormalSmall", "v1.20.2")
ver:SetPoint("BOTTOMLEFT", title, "BOTTOMRIGHT", 4, 0)
local auth = CreateFont("GameFontNormalSmall", "by Simca@Malfurion and Hugh@Burning Blade")
auth:SetPoint("BOTTOMLEFT", ver, "BOTTOMRIGHT", 3, 0)
local desc = CreateFont("GameFontHighlight", nil, nil, nil, "TOPLEFT", title, "BOTTOMLEFT", wideWidth, 40, 0, -8, "Battle Pet BreedID displays the BreedID of pets in your journal, in battle, in chat links, and in item tooltips.")

-- Create temp format variable
local tempformat = 3

-- Create dropdownmenu
if not BPBID_OptionsFormatMenu then
    CreateFrame("Button", "BPBID_OptionsFormatMenu", Options, "UIDropDownMenuTemplate")
end

-- Set dropdownmenu location
BPBID_OptionsFormatMenu:ClearAllPoints()
BPBID_OptionsFormatMenu:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 16, -8)
BPBID_OptionsFormatMenu:Show()

-- Create array for dropdownmenu
local formats = {
    "Number (3)",
    "Dual numbers (3/13)",
    "Letters (B/B)",
}

-- Create array for text blurb
local formatTexts = {
    "The number system was created by Blizzard developers and is used internally (it was discovered via the Web API). As such, it is fairly arbitrary (why does it start at 3?), but it was all we had at first. However, a lot of people have learned the system by numbers, and a few of the first-created resources and addons use it, such as Warla's popular website, PetSear.ch.",
    "Same as numbers but for people who like a reminder that we cannot figure out the sex of pets. Male pets are the first number (3 - 12) and female pets are the second number (13 - 22). Remember that not all pets can be both sexes. For example, all (?) Elemental type pets are exclusively male.",
    "The letter system was developed as a way to more quickly tell breeds apart from each other. Each letter represents one half of the stat contribution that makes up a breed. A few examples: S/S (#5) is a pure Speed breed. S/B (#11) is half Speed with the other half Balanced between all three stats. H/P (#7) is half Health and half Power.",
}

-- Create text blurb explaining format choices
local FormatTextBlurb = CreateFont("GameFontNormal", nil, nil, nil, "TOPLEFT", BPBID_OptionsFormatMenu, "TOPRIGHT" , 350, 100, 16, 24, formatTexts[tempformat])
FormatTextBlurb:SetTextColor(1, 1, 1, 1)

-- OnClick function for dropdownmenu
local function BPBID_OptionsFormatMenu_OnClick(self, arg1, arg2, checked)
    -- Update temp variable
    tempformat = arg1
    
    -- Update dropdownmenu text
    UIDropDownMenu_SetText(BPBID_OptionsFormatMenu, formats[tempformat])
    
    -- Update text blurb to the new choice
    FormatTextBlurb:SetText(formatTexts[tempformat])
end

-- Initialization function for dropdownmenu
local function BPBID_OptionsFormatMenu_Initialize(self, level)
    local info = UIDropDownMenu_CreateInfo()
    info = UIDropDownMenu_CreateInfo()
    info.func = BPBID_OptionsFormatMenu_OnClick
    info.arg1, info.text = 1, formats[1]
    UIDropDownMenu_AddButton(info)
    info.arg1, info.text = 2, formats[2]
    UIDropDownMenu_AddButton(info)
    info.arg1, info.text = 3, formats[3]
    UIDropDownMenu_AddButton(info)
end

-- Final setup for dropdownmenu
UIDropDownMenu_Initialize(BPBID_OptionsFormatMenu, BPBID_OptionsFormatMenu_Initialize)
UIDropDownMenu_SetWidth(BPBID_OptionsFormatMenu, 148);
UIDropDownMenu_SetButtonWidth(BPBID_OptionsFormatMenu, 124)
UIDropDownMenu_SetText(BPBID_OptionsFormatMenu, formats[tempformat])
UIDropDownMenu_JustifyText(BPBID_OptionsFormatMenu, "LEFT")

-- Set on top of colored region
local nameTitle = CreateFont("GameFontNormal", "Show BreedIDs in the Name line...")
nameTitle:SetPoint("TOPLEFT", BPBID_OptionsFormatMenu, "BOTTOMLEFT", -8, -16)
nameTitle:SetTextColor(1, 1, 1, 1)

-- Make Names checkboxes
local OptNamesPrimaryBattle = CreateCheckbox("In Battle (on primary pets)", 32, 32, "TOPLEFT", nameTitle, "BOTTOMLEFT", 0, 0)
local OptNamesBattleTooltip = CreateCheckbox("On in-battle tooltips", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptNamesBPT = CreateCheckbox("In Item tooltips", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptNamesFBPT = CreateCheckbox("In Chat Link tooltips", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptNamesHSFUpdate = CreateCheckbox("In the Pet Journal scrolling frame", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptNamesHSFUpdateRarity = CreateCheckbox("Color Pet Journal scrolling frame by rarity.", 16, 16, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 32, 0, "GameFontNormalSmall")
local OptNamesPJT = CreateCheckbox("In the Pet Journal description tooltip", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", -32, 0)
local OptNamesPJTRarity = CreateCheckbox("Color Pet Journal tooltip headers by rarity", 16, 16, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 32, 0, "GameFontNormalSmall")

-- Above the Tooltips region's title (this checkbox disables the rest of them)
local OptTooltipsEnabled = CreateCheckbox("Enable Battle Pet BreedID Tooltips", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", -32, -16)

-- Text above the Tooltips region
local tooltipsTitle = CreateFont("GameFontNormal", "Show Battle Pet BreedID Tooltips...")
tooltipsTitle:SetPoint("TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, -2)
tooltipsTitle:SetTextColor(1, 1, 1, 1)

-- Make Tooltips checkboxes
local OptTooltipsBattleTooltip = CreateCheckbox("In Battle", 32, 32, "TOPLEFT", tooltipsTitle, "BOTTOMLEFT", 0, 0)
local OptTooltipsBPT = CreateCheckbox("On Items", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptTooltipsFBPT = CreateCheckbox("On Chat Links", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptTooltipsPJT = CreateCheckbox("In the Pet Journal", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)

-- Text above the Tooltips region
local breedtipTitle = CreateFont("GameFontNormal", "In Tooltips, show...")
breedtipTitle:SetPoint("TOP", FormatTextBlurb, "BOTTOM", -48, -8)
breedtipTitle:SetTextColor(1, 1, 1, 1)

-- Make Breedtip checkboxes
local OptBreedtipCurrent = CreateCheckbox("Current pet's breed", 32, 32, "TOPLEFT", breedtipTitle, "BOTTOMLEFT", 0, 0)
local OptBreedtipPossible = CreateCheckbox("Current pet's possible breeds", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipSpeciesBase = CreateCheckbox("Pet species' base stats", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipCurrentStats = CreateCheckbox("Current breed's base stats", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipAllStats = CreateCheckbox("All breed's base stats", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipCurrentStats25 = CreateCheckbox("Current breed's stats at level 25", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipCurrentStats25Rare = CreateCheckbox("Always assume pet will be Rare at level 25", 16, 16, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 32, 0, "GameFontNormalSmall")
local OptBreedtipAllStats25 = CreateCheckbox("All breeds' stats at level 25", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", -32, 0)
local OptBreedtipAllStats25Rare = CreateCheckbox("Always assume pet will be Rare at level 25", 16, 16, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 32, 0, "GameFontNormalSmall")

-- Text above the BlizzBug region
local blizzbugTitle = CreateFont("GameFontNormal", "Fix Bugs:") -- Used to say "Fix Blizzard Bugs:"
blizzbugTitle:SetPoint("TOPLEFT", OptBreedtipAllStats25Rare, "BOTTOMLEFT", -32, -16)
blizzbugTitle:SetTextColor(1, 1, 1, 1)

local OptBugBattleFontFix = CreateCheckbox("Test old Pet Battle rarity coloring", 32, 32, "TOPLEFT", blizzbugTitle, "BOTTOMLEFT", 0, 0)

-- To disable rarity checkbox since it is dependent
local function BPBID_OptNamesHSFUpdate_OnClick(self, button, down)
    
    -- If the checkbox is checked
    if (OptNamesHSFUpdate:GetChecked()) then
        
        -- Enable and check rarity checkbox
        OptNamesHSFUpdateRarity:Enable()
        OptNamesHSFUpdateRarity:SetChecked(true)
        
    elseif (not OptNamesHSFUpdate:GetChecked()) then
        
        -- Disable and uncheck rarity checkbox
        OptNamesHSFUpdateRarity:Disable()
        OptNamesHSFUpdateRarity:SetChecked(nil)
    end
end

-- Variable to store settings until window is closed in case user wants to 
local tempstorage

-- Disable dependent checkboxes if unchecked
local function BPBID_OptTooltipsEnabled_OnClick(self, button, down)
    
    -- If the checkbox is checked AND it was unchecked at one point in time (to create tempstorage!)
    if (OptTooltipsEnabled:GetChecked()) and (tempstorage) then
        
        -- Enable all tooltip-related checkboxes
        OptTooltipsBattleTooltip:Enable()
        OptTooltipsBPT:Enable()
        OptTooltipsFBPT:Enable()
        OptTooltipsPJT:Enable()
        OptBreedtipCurrent:Enable()
        OptBreedtipPossible:Enable()
        OptBreedtipSpeciesBase:Enable()
        OptBreedtipCurrentStats:Enable()
        OptBreedtipAllStats:Enable()
        OptBreedtipCurrentStats25:Enable()
        OptBreedtipCurrentStats25Rare:Enable()
        OptBreedtipAllStats25:Enable()
        OptBreedtipAllStats25Rare:Enable()
        
        -- Set them to their old values
        OptTooltipsBattleTooltip:SetChecked(tempstorage[1])
        OptTooltipsBPT:SetChecked(tempstorage[2])
        OptTooltipsFBPT:SetChecked(tempstorage[3])
        OptTooltipsPJT:SetChecked(tempstorage[4])
        OptBreedtipCurrent:SetChecked(tempstorage[5])
        OptBreedtipPossible:SetChecked(tempstorage[6])
        OptBreedtipSpeciesBase:SetChecked(tempstorage[7])
        OptBreedtipCurrentStats:SetChecked(tempstorage[8])
        OptBreedtipAllStats:SetChecked(tempstorage[9])
        OptBreedtipCurrentStats25:SetChecked(tempstorage[10])
        OptBreedtipCurrentStats25Rare:SetChecked(tempstorage[11])
        OptBreedtipAllStats25:SetChecked(tempstorage[12])
        OptBreedtipAllStats25Rare:SetChecked(tempstorage[13])
        
    elseif (not OptTooltipsEnabled:GetChecked()) then
        
        -- Update tempstorage with the current values from the checkboxes (before they get wiped)
        tempstorage = {
            OptTooltipsBattleTooltip:GetChecked(),
            OptTooltipsBPT:GetChecked(),
            OptTooltipsFBPT:GetChecked(),
            OptTooltipsPJT:GetChecked(),
            OptBreedtipCurrent:GetChecked(),
            OptBreedtipPossible:GetChecked(),
            OptBreedtipSpeciesBase:GetChecked(),
            OptBreedtipCurrentStats:GetChecked(),
            OptBreedtipAllStats:GetChecked(),
            OptBreedtipCurrentStats25:GetChecked(),
            OptBreedtipCurrentStats25Rare:GetChecked(),
            OptBreedtipAllStats25:GetChecked(),
            OptBreedtipAllStats25Rare:GetChecked(),
        }
        
        -- Disable any tooltip-related checkboxes
        OptTooltipsBattleTooltip:Disable()
        OptTooltipsBPT:Disable()
        OptTooltipsFBPT:Disable()
        OptTooltipsPJT:Disable()
        OptBreedtipCurrent:Disable()
        OptBreedtipPossible:Disable()
        OptBreedtipSpeciesBase:Disable()
        OptBreedtipCurrentStats:Disable()
        OptBreedtipAllStats:Disable()
        OptBreedtipCurrentStats25:Disable()
        OptBreedtipCurrentStats25Rare:Disable()
        OptBreedtipAllStats25:Disable()
        OptBreedtipAllStats25Rare:Disable()
        
        -- Uncheck all tooltip-related checkboxes
        OptTooltipsBattleTooltip:SetChecked(nil)
        OptTooltipsBPT:SetChecked(nil)
        OptTooltipsFBPT:SetChecked(nil)
        OptTooltipsPJT:SetChecked(nil)
        OptBreedtipCurrent:SetChecked(nil)
        OptBreedtipPossible:SetChecked(nil)
        OptBreedtipSpeciesBase:SetChecked(nil)
        OptBreedtipCurrentStats:SetChecked(nil)
        OptBreedtipAllStats:SetChecked(nil)
        OptBreedtipCurrentStats25:SetChecked(nil)
        OptBreedtipCurrentStats25Rare:SetChecked(nil)
        OptBreedtipAllStats25:SetChecked(nil)
        OptBreedtipAllStats25Rare:SetChecked(nil)
    end
end

local function BPBID_Options_Refresh()
    -- Reset the dropdownmenu to the old value
    tempformat = BPBID_Options.format
    UIDropDownMenu_SetText(BPBID_OptionsFormatMenu, formats[tempformat])
    
    -- Reset the text blurb to the old value
    FormatTextBlurb:SetText(formatTexts[tempformat])
    
    -- Reset all the checkboxes to the old value
    OptNamesPrimaryBattle:SetChecked(BPBID_Options.Names.PrimaryBattle)
    OptNamesBattleTooltip:SetChecked(BPBID_Options.Names.BattleTooltip)
    OptNamesBPT:SetChecked(BPBID_Options.Names.BPT)
    OptNamesFBPT:SetChecked(BPBID_Options.Names.FBPT)
    OptNamesHSFUpdate:SetChecked(BPBID_Options.Names.HSFUpdate)
    OptNamesHSFUpdateRarity:SetChecked(BPBID_Options.Names.HSFUpdateRarity)
    OptNamesPJT:SetChecked(BPBID_Options.Names.PJT)
    OptNamesPJTRarity:SetChecked(BPBID_Options.Names.PJTRarity)
    OptTooltipsEnabled:SetChecked(BPBID_Options.Tooltips.Enabled)
    OptTooltipsBattleTooltip:SetChecked(BPBID_Options.Tooltips.BattleTooltip)
    OptTooltipsBPT:SetChecked(BPBID_Options.Tooltips.BPT)
    OptTooltipsFBPT:SetChecked(BPBID_Options.Tooltips.FBPT)
    OptTooltipsPJT:SetChecked(BPBID_Options.Tooltips.PJT)
    OptBreedtipCurrent:SetChecked(BPBID_Options.Breedtip.Current)
    OptBreedtipPossible:SetChecked(BPBID_Options.Breedtip.Possible)
    OptBreedtipSpeciesBase:SetChecked(BPBID_Options.Breedtip.SpeciesBase)
    OptBreedtipCurrentStats:SetChecked(BPBID_Options.Breedtip.CurrentStats)
    OptBreedtipAllStats:SetChecked(BPBID_Options.Breedtip.AllStats)
    OptBreedtipCurrentStats25:SetChecked(BPBID_Options.Breedtip.CurrentStats25)
    OptBreedtipCurrentStats25Rare:SetChecked(BPBID_Options.Breedtip.CurrentStats25Rare)
    OptBreedtipAllStats25:SetChecked(BPBID_Options.Breedtip.AllStats25)
    OptBreedtipAllStats25Rare:SetChecked(BPBID_Options.Breedtip.AllStats25Rare)
    OptBugBattleFontFix:SetChecked(BPBID_Options.BattleFontFix)
    
    -- Call this to fix the checkboxes to their correct enabled state
    BPBID_OptTooltipsEnabled_OnClick()
end

function Options.refresh()
    BPBID_Options_Refresh()
end

function Options.default()
    
    tempstorage = nil
    
    BPBID_Options = {}

    BPBID_Options.format = 3

    BPBID_Options.Names = {}
    BPBID_Options.Names.PrimaryBattle = true -- In Battle (on primary pets for both owners)
    BPBID_Options.Names.BattleTooltip = true -- In PrimaryBattlePetUnitTooltip's header (in-battle tooltips)
    BPBID_Options.Names.BPT = true -- In BattlePetTooltip's header (items)
    BPBID_Options.Names.FBPT = true -- In FloatingBattlePetTooltip's header (chat links)
    BPBID_Options.Names.HSFUpdate = true -- In the Pet Journal scrolling frame
    BPBID_Options.Names.HSFUpdateRarity = true -- Color Pet Journal scrolling frame entries by rarity
    BPBID_Options.Names.PJT = true -- In the Pet Journal tooltip header
    BPBID_Options.Names.PJTRarity = false -- Color Pet Journal tooltip headers by rarity

    BPBID_Options.Tooltips = {}
    BPBID_Options.Tooltips.Enabled = true -- Enable Battle Pet BreedID Tooltips
    BPBID_Options.Tooltips.BattleTooltip = true -- In Battle (PrimaryBattlePetUnitTooltip)
    BPBID_Options.Tooltips.BPT = true -- On Items (BattlePetTooltip)
    BPBID_Options.Tooltips.FBPT = true -- On Chat Links (FloatingBattlePetTooltip)
    BPBID_Options.Tooltips.PJT = true -- In the Pet Journal (GameTooltip)

    BPBID_Options.Breedtip = {}
    BPBID_Options.Breedtip.Current = true -- Current pet's breed
    BPBID_Options.Breedtip.Possible = true -- Current pet's possible breeds
    BPBID_Options.Breedtip.SpeciesBase = false -- Pet species' base stats
    BPBID_Options.Breedtip.CurrentStats = false -- Current breed's base stats (level 1 Poor)
    BPBID_Options.Breedtip.AllStats = false -- All breed's base stats (level 1 Poor)
    BPBID_Options.Breedtip.CurrentStats25 = true -- Current breed's stats at level 25
    BPBID_Options.Breedtip.CurrentStats25Rare = true -- Always assume pet will be Rare at level 25
    BPBID_Options.Breedtip.AllStats25 = true -- All breeds' stats at level 25
    BPBID_Options.Breedtip.AllStats25Rare = true -- Always assume pet will be Rare at level 25
    
    BPBID_Options.BattleFontFix = false -- Use alternate rarity coloring method in-battle
    
    -- Refresh the options page to display the new defaults
    BPBID_Options_Refresh()
end

function Options.okay()
    -- IF THE LAST TOOLTIP CALLED BEFORE THE OPTIONS ARE CHANGED HAS CHANGED FONT,
    -- BAD STUFF WILL HAPPEN SO CALL ORIGINAL FONT CHANGING FUNCTIONS IN OKAY BOX
    
    -- Clear storage for TooltipsEnabled remembering
    tempstorage = nil
    
    -- Store format setting
    BPBID_Options.format = tempformat
    
    -- Retrieve the rest of the settings from the checkboxes
    BPBID_Options.Names.PrimaryBattle = OptNamesPrimaryBattle:GetChecked()
    BPBID_Options.Names.BattleTooltip = OptNamesBattleTooltip:GetChecked()
    BPBID_Options.Names.BPT = OptNamesBPT:GetChecked()
    BPBID_Options.Names.FBPT = OptNamesFBPT:GetChecked()
    BPBID_Options.Names.HSFUpdate = OptNamesHSFUpdate:GetChecked()
    BPBID_Options.Names.HSFUpdateRarity = OptNamesHSFUpdateRarity:GetChecked()
    BPBID_Options.Names.PJT = OptNamesPJT:GetChecked()
    BPBID_Options.Names.PJTRarity = OptNamesPJTRarity:GetChecked()
    BPBID_Options.Tooltips.Enabled = OptTooltipsEnabled:GetChecked()
    BPBID_Options.Tooltips.BattleTooltip = OptTooltipsBattleTooltip:GetChecked()
    BPBID_Options.Tooltips.BPT = OptTooltipsBPT:GetChecked()
    BPBID_Options.Tooltips.FBPT = OptTooltipsFBPT:GetChecked()
    BPBID_Options.Tooltips.PJT = OptTooltipsPJT:GetChecked()
    BPBID_Options.Breedtip.Current = OptBreedtipCurrent:GetChecked()
    BPBID_Options.Breedtip.Possible = OptBreedtipPossible:GetChecked()
    BPBID_Options.Breedtip.SpeciesBase = OptBreedtipSpeciesBase:GetChecked()
    BPBID_Options.Breedtip.CurrentStats = OptBreedtipCurrentStats:GetChecked()
    BPBID_Options.Breedtip.AllStats = OptBreedtipAllStats:GetChecked()
    BPBID_Options.Breedtip.CurrentStats25 = OptBreedtipCurrentStats25:GetChecked()
    BPBID_Options.Breedtip.CurrentStats25Rare = OptBreedtipCurrentStats25Rare:GetChecked()
    BPBID_Options.Breedtip.AllStats25 = OptBreedtipAllStats25:GetChecked()
    BPBID_Options.Breedtip.AllStats25Rare = OptBreedtipAllStats25Rare:GetChecked()
    BPBID_Options.BattleFontFix = OptBugBattleFontFix:GetChecked()
    
    -- Fix fontsize for PrimaryBattlePetUnitTooltip (TODO: PetFrame)
    if (not BPBID_Options.Names.BattleTooltip) and (internal.BattleFontSize) then
        PetBattlePrimaryUnitTooltip.Name:SetFont(internal.BattleFontSize[1], internal.BattleFontSize[2], internal.BattleFontSize[3])
    end
    
    -- Reset fontsize for BattlePetTooltip if original font size known
    if (not BPBID_Options.Names.BPT) and (internal.BPTFontSize) then
        BattlePetTooltip.Name:SetFont(internal.BPTFontSize[1], internal.BPTFontSize[2], internal.BPTFontSize[3])
    end
    
    -- Fix width for FloatingBattlePetTooltip
    if (not BPBID_Options.Names.FBPT) then
        FloatingBattlePetTooltip:SetWidth(260)
        FloatingBattlePetTooltip.Name:SetWidth(238)
        FloatingBattlePetTooltip.BattlePet:SetWidth(238)
        FloatingBattlePetTooltip.PetType:SetPoint("TOP", FloatingBattlePetTooltip.Name, "BOTTOM", 0, -5)
        FloatingBattlePetTooltip.Level:SetWidth(238)
        FloatingBattlePetTooltip.Delimiter:SetWidth(251)
        FloatingBattlePetTooltip.JournalClick:SetWidth(238)
    end
    
    -- Fix font size for HSFUpdate
    if (not BPBID_Options.Names.HSFUpdate) then
        for i = 1, #PetJournalListScrollFrame.buttons do
            PetJournalListScrollFrame.buttons[i].name:SetFontObject("GameFontNormal")
        end
    end
    
    -- A manual change has occurred (added in v1.0.8 to help update values added in new versions)
    BPBID_Options.ManualChange = "v1.20.2"
    
    -- Refresh the options page to display the new values
    BPBID_Options_Refresh()
end

function Options.cancel()
    
    -- Clear storage for TooltipsEnabled remembering
    tempstorage = nil
    
    -- Refresh the options page to display the old settings
    BPBID_Options_Refresh()
end

-- Set script for needed checkbox
OptNamesHSFUpdate:SetScript("OnClick", BPBID_OptNamesHSFUpdate_OnClick)
OptTooltipsEnabled:SetScript("OnClick", BPBID_OptTooltipsEnabled_OnClick)

-- Add the options panel to the Blizzard list
InterfaceOptions_AddCategory(Options)
