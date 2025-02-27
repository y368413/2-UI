--[[
Written by: Simca@Malfurion-US

Thanks to Hugh@Burning-Blade, a co-author for the first few versions of the AddOn.

Special thanks to Nullberri, Ro, and Warla for helping at various points throughout the addon's development.
]]--

--GLOBALS: BPBID_Internal, BPBID_Options, GetBreedID_Battle, GetBreedID_Journal, SLASH_BATTLEPETBREEDID1, SLASH_BATTLEPETBREEDID2, SLASH_BATTLEPETBREEDID3

-- Get folder path and set addon namespace
local internal = {}
if GetLocale() == "zhCN" then
  BattlePetBreedIDOptionsName = "|cFFBF00FF[宠物]|r三围数据";
elseif GetLocale() == "zhTW" then
  BattlePetBreedIDOptionsName = "|cFFBF00FF[宠物]|r三围数据r";
else
  BattlePetBreedIDOptionsName = "|cFFBF00FF[BB]|rBattlePet BreedID";
end
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
local is_ptr = select(4, _G.GetBuildInfo()) ~= C_AddOns.GetAddOnMetadata("HPetBattleAny", "Interface")

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
    nLevel = tonumber(nLevel)
    local wildHPFactor, wildPowerFactor = 1, 1
    if wild then
        wildHPFactor = 1.2
        if nLevel < 6 then
            wildPowerFactor = 1.4
        else
            wildPowerFactor = 1.25
        end
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
        
        -- Lowbie pets go here, the bane of my existence. Calculations must be intense and logic loops numerous.
        else
            -- Calculate diffs much more intensely. Round calculations with 10^-2 and by using math.floor after adding 0.5. Also, properly devalue HP by dividing its absolute value by 5.
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

-- Retrieve pre-determined Breed ID from cache for pet being moused over (requires Blizzard Pet tooltip to be passed)
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
			-- In Patch 11.0.0, Blizzard decreased the natural quality values passed from this function by 1.
			-- This is inconsistent with all other quality APIs.
            local nQuality = CPB.GetBreedQuality(iOwner, iIndex) + 1
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
                    print(string.format("NEW Species found; Owner #%i, Pet #%i, Wild status %s, SpeciesID %u, Base+Breed Stats %4.4f / %4.4f / %4.4f", iOwner, iIndex, wild and "true" or "false", nSpeciesID, ((nMaxHP * wildnum - 100) / 5) / (nLevel * (1 + (0.1 * (nQuality - 1)))), nPower / (nLevel * (1 + (0.1 * (nQuality - 1)))), (nSpeed / flyingnum) / (nLevel * (1 + (0.1 * (nQuality - 1))))))
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
                        print(string.format("NEW Breed found for existing species; Owner #%i, Pet #%i, Wild status %s, SpeciesID %u, Base+Breed Stats %4.4f / %4.4f / %4.4f, Breed %s", iOwner, iIndex, wild and "true" or "false", nSpeciesID, ((nMaxHP * wildnum - 100) / 5) / (nLevel * (1 + (0.1 * (nQuality - 1)))), nPower / (nLevel * (1 + (0.1 * (nQuality - 1)))), (nSpeed / flyingnum) / (nLevel * (1 + (0.1 * (nQuality - 1)))), breed))
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

-- Display breed on PetJournal's ScrollBox frames
local function BPBID_Hook_PetJournal_InitPetButton(petScrollListFrame, elementData)
    -- Shouldn't apply if using Rematch or PJE    
    -- Make sure the option is enabled
    if not BPBID_Options.Names.HSFUpdate or not petScrollListFrame or not elementData or not elementData.index then return end

    -- Ensure petID and name are not bogus
    local petID, _, _, customName, _, _, _, name = CPJ.GetPetInfoByIndex(elementData.index)
    if not petID or not name then return end
        
    -- Get pet hex color from rarity
    local _, _, _, _, rarity = CPJ.GetPetStats(petID)
    if not rarity then return end
    local hex = ITEM_QUALITY_COLORS[rarity - 1].hex
    if not hex then return end
    
    -- FONT DOWNSIZING ROUTINE HERE COULD USE SOME WORK
    
    -- If user doesn't want rarity coloring then use default
    if not BPBID_Options.Names.HSFUpdateRarity then hex = "|cffffd100" end
    
    local breedID = GetBreedID_Journal(petID)
    if not breedID then return end
    
    -- Display breed as part of the nickname if the pet has one, otherwise use the real name
    if customName then
        petScrollListFrame.name:SetText(hex..customName.." ("..GetBreedID_Journal(petID)..")".."|r")
        petScrollListFrame.subName:Show()
        petScrollListFrame.subName:SetText(name)
    else
        petScrollListFrame.name:SetText(hex..name.." ("..GetBreedID_Journal(petID)..")".."|r")
        petScrollListFrame.subName:Hide()
    end
    
    -- Downside font if the name/breed gets chopped off
    if petScrollListFrame.name:IsTruncated() then
        petScrollListFrame.name:SetFontObject("GameFontNormalSmall")
    else
        petScrollListFrame.name:SetFontObject("GameFontNormal")
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
        if (not BPBID_Options.Names) then
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
            BPBID_Options.Breedtip.Collected = true -- Collected breeds for current pet
            
            BPBID_Options.BattleFontFix = false -- Test old Pet Battle rarity coloring
        end
        
        -- Set up new system for detecting manual changes added in v1.0.8
        if (BPBID_Options.ManualChange == nil) then
            BPBID_Options.ManualChange = false
        end
        
        -- Disable option unless user has manually changed it
        if (not BPBID_Options.ManualChange) or (BPBID_Options.ManualChange ~= "v1.32.3") then
            BPBID_Options.BattleFontFix = false
        end
        
        -- If this addon loads after the Pet Journal
        if (PetJournalPetCardPetInfo) then
            
            -- Hook into the OnEnter script for the frame that calls GameTooltip in the Pet Journal
            PetJournalPetCardPetInfo:HookScript("OnEnter", internal.Hook_PJTEnter)
            PetJournalPetCardPetInfo:HookScript("OnLeave", internal.Hook_PJTLeave)
			
			-- Hook into the Pet Journal's list button initialization
			hooksecurefunc("PetJournal_InitPetButton", BPBID_Hook_PetJournal_InitPetButton)
            
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
			
			-- Hook into the Pet Journal's list button initialization
			hooksecurefunc("PetJournal_InitPetButton", BPBID_Hook_PetJournal_InitPetButton)
            
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
			
			-- Hook into the Pet Journal's list button initialization
			hooksecurefunc("PetJournal_InitPetButton", BPBID_Hook_PetJournal_InitPetButton)
            
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

-- Create slash commands
SLASH_BATTLEPETBREEDID1 = "/battlepetbreedID"
SLASH_BATTLEPETBREEDID2 = "/BPBID"
SLASH_BATTLEPETBREEDID3 = "/breedID"
SlashCmdList["BATTLEPETBREEDID"] = function(msg)
    Settings.OpenToCategory(BattlePetBreedIDOptionsName)
end

local mouseButtonNote = "\nDisplay the BreedID of pets in your journal, in battle, in chat links, and in AH tooltips.";
AddonCompartmentFrame:RegisterAddon({
	text = BattlePetBreedIDOptionsName,  --addonname,
	icon = "Interface/Icons/petjournalportrait.blp",
	notCheckable = true,
	func = function(button, menuInputData, menu)
		Settings.OpenToCategory(BattlePetBreedIDOptionsName)
	end,
	funcOnEnter = function(button)
		MenuUtil.ShowTooltip(button, function(tooltip)
			tooltip:SetText(BattlePetBreedIDOptionsName .. mouseButtonNote)
		end)
	end,
	funcOnLeave = function(button)
		MenuUtil.HideTooltip(button)
	end,
})


--[[
Written by: Simca@Malfurion-US

Thanks to Hugh@Burning-Blade, a co-author for the first few versions of the AddOn.

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
    -- Setting parent is also required for BattlePetTooltip because TSMExtraTooltip constantly reanchors itself on its parent
    if (C_AddOns.IsAddOnLoaded("TradeSkillMaster")) then
        for i = 1, 10 do
            local t = _G["TSMExtraTooltip" .. i]
            if t then
				-- It probably never matters which point we check to learn the relative frame
				-- This is because TSM tooltips should only be relative to one frame each
				-- If this changes in the future or this assumption is wrong, we'll have to iterate points here
                local _, relativeFrame = t:GetPoint()
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

	-- Set line for "Collected"
    if (BPBID_Options.Breedtip.Collected) then
		if (not PetJournalPetCardPetInfo) or (not PetJournalPetCardPetInfo:IsVisible()) or (parent == FloatingBattlePetTooltip) then
			C_PetJournal.ClearSearchFilter()
		end

        numPets, numOwned = C_PetJournal.GetNumPets()
        local collectedPets = {}
        for i = 1, numPets do
            local petID, speciesID2, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(i)
            if petID and speciesID2 == speciesID then 
                local speciesID, customName, level, xp, maxXp, displayID, isFavorite, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique, obtainable = C_PetJournal.GetPetInfoByPetID(petID)
                local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID)

                local breedNum, quality, resultslist = internal.CalculateBreedID(speciesID, rarity, level, maxHealth, power, speed, false, false)

                local breed = internal.RetrieveBreedName(breedNum)
                table.insert(collectedPets, ITEM_QUALITY_COLORS[quality-1].hex .. "L" .. level .. " (" .. breed .. ")"  .. "|r")
            end
        end
        if (#collectedPets > 0) then
            breedtip:AddLine("\124cFFD4A017Collected:\124r " .. table.concat(collectedPets, ", "), 1, 1, 1, 1)
        end
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

        -- Set line for "Current breed's base stats (level 1 Poor)" (have to have BreedsPerSpecies and tblBreedID for this)
        if (BPBID_Options.Breedtip.CurrentStats) and (BPBID_Arrays.BreedsPerSpecies[speciesID]) and (tblBreedID) then
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

        -- Set line for "Current breed's stats at level 25" (have to have BreedsPerSpecies and tblBreedID for this)
        if (BPBID_Options.Breedtip.CurrentStats25) and (BPBID_Arrays.BreedsPerSpecies[speciesID]) and (tblBreedID) then
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
                local _, _, _, hex = C_Item.GetItemQualityColor(internal.rarityCache[self.petIndex + offset] - 1)
                self.Name:SetText("|c"..hex..name.." ("..breed..")".."|r")
            else
                self.Name:SetText(name.." ("..breed..")")
            end
        end
    else
        -- Set the name header if the user wants
        if (name) and (BPBID_Options.Names.BattleTooltip) then
            -- Set standard text or use hex coloring based on font fix option
            if (BPBID_Options.BattleFontFix) then
                local _, _, _, hex = C_Item.GetItemQualityColor(internal.rarityCache[self.petIndex + offset] - 1)
                self.Name:SetText("|c"..hex..name.." ("..breed..")".."|r")
            else
                self.Name:SetText(name.." ("..breed..")")
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
        if not strfind(currentText, " (" .. breed .. ")") then
            -- Append breed to tooltip
            BattlePetTooltip.Name:SetText(currentText .. " (" .. breed .. ")")

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
-- Pet Journal's list button initialization hook is handled in BattlePetBreedID's Core entirely because it is unrelated to tooltips
--[[
Written by: Simca@Malfurion-US

Thanks to Hugh@Burning-Blade, a co-author for the first few versions of the AddOn.

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
    BPBID_Options.Names.HSFUpdateRarity: Color Pet Journal scrolling frame by rarity
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



-- Create options panel
local Options = CreateFrame("Frame")
local properName = BattlePetBreedIDOptionsName

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

-- Similar function for buttons
local function CreateButton(text, height, width, anchorPoint, relativeTo, relativePoint, xoff, yoff)
    local button = CreateFrame("Button", nil, Options, "UIPanelButtonTemplate")
    button:SetPoint(anchorPoint, relativeTo, relativePoint, xoff, yoff)
    button:SetSize(height, width)
    button:SetText(text)
    return button
end

-- Create title, version, author, and description fields
local title = CreateFont("GameFontNormalLarge", properName)
title:SetPoint("TOPLEFT", 16, -16)
local ver = CreateFont("GameFontNormalSmall", "v1.32.3")
ver:SetPoint("BOTTOMLEFT", title, "BOTTOMRIGHT", 4, 0)
local auth = CreateFont("GameFontNormalSmall", "by Simca@Malfurion")
auth:SetPoint("BOTTOMLEFT", ver, "BOTTOMRIGHT", 3, 0)
local desc = CreateFont("GameFontHighlight", nil, nil, nil, "TOPLEFT", title, "BOTTOMLEFT", 580, 40, 0, -8, "在宠物对战日志中、战斗中、聊天链接以及物品提示中的显示你的宠物品种ID。")

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
    "数字 (3)",
    "两个数字 (3/13)",
    "字母 (B/B)",
}

-- Create array for text blurb
local formatTexts = {
    "这个数字体系是由暴雪开发者创建并内部使用的（它是通过Web API被发现的）。因此，它相当随意（为什么它从3开始？），但这就是我们原始能够使用的。不管怎样，有些人已经通过数字学会了这个系统，一些较旧的资源和插件也在使用它。",
    "对那些喜欢提醒我们无法在游戏中确定宠物性别的人来说，这些数字看起来一样。雄性宠物是第一个数字（3 - 12），雌性宠物是第二个数字（13 - 22）。请记住，并非所有宠物都是两种性别。例如，所有（？）元素类型的宠物都是专属雄性。",
    "字母体系是作为一种更快速区分不同品种的方法而开发的。每个字母代表构成品种的一半信息。一些例子：S/S（#5）是纯速度品种。S/B（#11）是一半速度，另一半在所有三个数据之间平衡。H/P（#7）是一半生命和一半力量。",
}

-- Create text blurb explaining format choices
local FormatTextBlurb = CreateFont("GameFontNormal", nil, nil, nil, "TOPLEFT", BPBID_OptionsFormatMenu, "TOPRIGHT" , 350, 100, 16, 24, formatTexts[tempformat])
FormatTextBlurb:SetTextColor(1, 1, 1, 1)

-- OnClick function for dropdownmenu
local function BPBID_OptionsFormatMenu_OnClick(self, arg1, arg2, checked)
    -- Update temp variable
    BPBID_Options.format = arg1
    
    -- Update dropdownmenu text
    UIDropDownMenu_SetText(BPBID_OptionsFormatMenu, formats[BPBID_Options.format])
    
    -- Update text blurb to the new choice
    FormatTextBlurb:SetText(formatTexts[BPBID_Options.format])
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
local nameTitle = CreateFont("GameFontNormal", "在姓名行显示品种ID...")
nameTitle:SetPoint("TOPLEFT", BPBID_OptionsFormatMenu, "BOTTOMLEFT", -8, -16)
nameTitle:SetTextColor(1, 1, 1, 1)

-- Make Names checkboxes
local OptNamesPrimaryBattle = CreateCheckbox("在战斗中（主要宠物）", 32, 32, "TOPLEFT", nameTitle, "BOTTOMLEFT", 0, 0)
local OptNamesBattleTooltip = CreateCheckbox("在战斗提示中", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptNamesBPT = CreateCheckbox("在物品提示中", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptNamesFBPT = CreateCheckbox("在聊天链接提示中", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptNamesHSFUpdate = CreateCheckbox("在宠物对战日志中", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptNamesHSFUpdateRarity = CreateCheckbox("稀有度着色宠物对战日志", 16, 16, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 32, 0, "GameFontNormalSmall")
local OptNamesPJT = CreateCheckbox("在宠物对战日志描述提示中", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", -32, 0)
local OptNamesPJTRarity = CreateCheckbox("稀有度着色宠物对战日志提示标题", 16, 16, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 32, 0, "GameFontNormalSmall")

-- Above the Tooltips region's title (this checkbox disables the rest of them)
local OptTooltipsEnabled = CreateCheckbox("“启用对战宠物品种ID提示", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", -32, -16)

-- Text above the Tooltips region
local tooltipsTitle = CreateFont("GameFontNormal", "显示对战宠物品种ID提示...")
tooltipsTitle:SetPoint("TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, -2)
tooltipsTitle:SetTextColor(1, 1, 1, 1)

-- Make Tooltips checkboxes
local OptTooltipsBattleTooltip = CreateCheckbox("在战斗中", 32, 32, "TOPLEFT", tooltipsTitle, "BOTTOMLEFT", 0, 0)
local OptTooltipsBPT = CreateCheckbox("在物品上", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptTooltipsFBPT = CreateCheckbox("在聊天链接上", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptTooltipsPJT = CreateCheckbox("在宠物对战日志中", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)

-- Text above the Tooltips region
local breedtipTitle = CreateFont("GameFontNormal", "在提示中显示...")
breedtipTitle:SetPoint("TOP", FormatTextBlurb, "BOTTOM", -48, -8)
breedtipTitle:SetTextColor(1, 1, 1, 1)

-- Make Breedtip checkboxes
local OptBreedtipCurrent = CreateCheckbox("当前宠物的品种", 32, 32, "TOPLEFT", breedtipTitle, "BOTTOMLEFT", 0, 0)
local OptBreedtipPossible = CreateCheckbox("当前宠物可能的品种", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipCollected = CreateCheckbox("当前宠物已收集的品种", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipSpeciesBase = CreateCheckbox("宠物种类的基础属性", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipCurrentStats = CreateCheckbox("当前品种的基础属性", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipAllStats = CreateCheckbox("所有品种的基础属性", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipCurrentStats25 = CreateCheckbox("当前品种25级时的属性", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, 0)
local OptBreedtipCurrentStats25Rare = CreateCheckbox("始终假设宠物在25级时为稀有品质", 16, 16, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 32, 0, "GameFontNormalSmall")
local OptBreedtipAllStats25 = CreateCheckbox("所有品种25级时的属性", 32, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", -32, 0)
local OptBreedtipAllStats25Rare = CreateCheckbox("始终假设宠物在25级时为稀有品质", 16, 16, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 32, 0, "GameFontNormalSmall")

-- Text above the BlizzBug region
local blizzbugTitle = CreateFont("GameFontNormal", "修复错误：") -- Used to say "Fix Blizzard Bugs:"
blizzbugTitle:SetPoint("TOPLEFT", OptBreedtipAllStats25Rare, "BOTTOMLEFT", -32, -16)
blizzbugTitle:SetTextColor(1, 1, 1, 1)

local OptBugBattleFontFix = CreateCheckbox("测试旧的对战宠物稀有度着色", 32, 32, "TOPLEFT", blizzbugTitle, "BOTTOMLEFT", 0, 0)

local OptDefaultButton = CreateButton("默认设置", 80, 32, "TOPLEFT", lastcheckbox, "BOTTOMLEFT", 0, -32)

-- Refresh all settings from storage
local function BPBID_Options_Refresh()
    -- Reset the dropdownmenu to the old value
    UIDropDownMenu_SetText(BPBID_OptionsFormatMenu, formats[BPBID_Options.format])
    
    -- Reset the text blurb to the old value
    FormatTextBlurb:SetText(formatTexts[BPBID_Options.format])
    
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
    OptBreedtipCollected:SetChecked(BPBID_Options.Breedtip.Collected)

    -- Enable/disable dependent checkboxes
    if (OptNamesHSFUpdate:GetChecked()) then
        OptNamesHSFUpdateRarity:Enable()
    elseif (not OptNamesHSFUpdate:GetChecked()) then
        OptNamesHSFUpdateRarity:Disable()
    end
    if (OptNamesPJT:GetChecked()) then
        OptNamesPJTRarity:Enable()
    elseif (not OptNamesPJT:GetChecked()) then
        OptNamesPJTRarity:Disable()
    end
    if (OptTooltipsEnabled:GetChecked()) then
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
        OptBreedtipCollected:Enable()
    elseif (not OptTooltipsEnabled:GetChecked()) then
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
        OptBreedtipCollected:Disable()
    end

    if (OptBreedtipCurrentStats25:GetChecked()) then
        OptBreedtipCurrentStats25Rare:Enable()
    elseif (not OptBreedtipCurrentStats25:GetChecked()) then
        OptBreedtipCurrentStats25Rare:Disable()
    end

    if (OptBreedtipAllStats25:GetChecked()) then
        OptBreedtipAllStats25Rare:Enable()
    elseif (not OptBreedtipAllStats25:GetChecked()) then
        OptBreedtipAllStats25Rare:Disable()
    end
end

-- Enable/disable dependent checkboxes
local function BPBID_OptNamesHSFUpdate_OnClick(self, button, down)
    
    -- Change value of dependent checkbox accordingly (default sub-checkbox to true)
    if (OptNamesHSFUpdate:GetChecked()) then
        BPBID_Options.Names.HSFUpdate = true
        BPBID_Options.Names.HSFUpdateRarity = true
    elseif (not OptNamesHSFUpdate:GetChecked()) then
        BPBID_Options.Names.HSFUpdate = false
        BPBID_Options.Names.HSFUpdateRarity = false
    end
    
    -- A manual change has occurred (added in v1.0.8 to help update values added in new versions)
    BPBID_Options.ManualChange = "v1.32.3"
    
    -- Refresh the options page to display the new values
    BPBID_Options_Refresh()
end
local function BPBID_OptNamesPJT_OnClick(self, button, down)
    
    -- Change value of dependent checkbox accordingly (default sub-checkbox to false)
    if (OptNamesPJT:GetChecked()) then
        BPBID_Options.Names.PJT = true
        BPBID_Options.Names.PJTRarity = false
    elseif (not OptNamesPJT:GetChecked()) then
        BPBID_Options.Names.PJT = false
        BPBID_Options.Names.PJTRarity = false
    end
    
    -- A manual change has occurred (added in v1.0.8 to help update values added in new versions)
    BPBID_Options.ManualChange = "v1.32.3"
    
    -- Refresh the options page to display the new values
    BPBID_Options_Refresh()
end
local function BPBID_OptBreedtipCurrentStats25_OnClick(self, button, down)
    
    -- Change value of dependent checkbox accordingly (default sub-checkbox to true)
    if (OptBreedtipCurrentStats25:GetChecked()) then
        BPBID_Options.Breedtip.CurrentStats25 = true
        BPBID_Options.Breedtip.CurrentStats25Rare = true
    elseif (not OptBreedtipCurrentStats25:GetChecked()) then
        BPBID_Options.Breedtip.CurrentStats25 = false
        BPBID_Options.Breedtip.CurrentStats25Rare = false
    end
    
    -- A manual change has occurred (added in v1.0.8 to help update values added in new versions)
    BPBID_Options.ManualChange = "v1.32.3"
    
    -- Refresh the options page to display the new values
    BPBID_Options_Refresh()
end
local function BPBID_OptBreedtipAllStats25_OnClick(self, button, down)
    
    -- Change value of dependent checkbox accordingly (default sub-checkbox to true)
    if (OptBreedtipAllStats25:GetChecked()) then
        BPBID_Options.Breedtip.AllStats25 = true
        BPBID_Options.Breedtip.AllStats25Rare = true
    elseif (not OptBreedtipAllStats25:GetChecked()) then
        BPBID_Options.Breedtip.AllStats25 = false
        BPBID_Options.Breedtip.AllStats25Rare = false
    end
    
    -- A manual change has occurred (added in v1.0.8 to help update values added in new versions)
    BPBID_Options.ManualChange = "v1.32.3"
    
    -- Refresh the options page to display the new values
    BPBID_Options_Refresh()
end

-- Disable dependent checkboxes if unchecked
local function BPBID_OptTooltipsEnabled_OnClick(self, button, down)
    
    -- If the checkbox is checked
    if (OptTooltipsEnabled:GetChecked()) then
        
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
        OptBreedtipCollected:Enable()
        
        -- Restore defaults for previously disabled checkboxes
        BPBID_Options.Tooltips.Enabled = true -- Enable Battle Pet BreedID Tooltips
        BPBID_Options.Tooltips.BattleTooltip = true -- In Battle (PrimaryBattlePetUnitTooltip)
        BPBID_Options.Tooltips.BPT = true -- On Items (BattlePetTooltip)
        BPBID_Options.Tooltips.FBPT = true -- On Chat Links (FloatingBattlePetTooltip)
        BPBID_Options.Tooltips.PJT = true -- In the Pet Journal (GameTooltip)
        BPBID_Options.Breedtip.Current = true -- Current pet's breed
        BPBID_Options.Breedtip.Possible = true -- Current pet's possible breeds
        BPBID_Options.Breedtip.SpeciesBase = false -- Pet species' base stats
        BPBID_Options.Breedtip.CurrentStats = false -- Current breed's base stats (level 1 Poor)
        BPBID_Options.Breedtip.AllStats = false -- All breed's base stats (level 1 Poor)
        BPBID_Options.Breedtip.CurrentStats25 = true -- Current breed's stats at level 25
        BPBID_Options.Breedtip.CurrentStats25Rare = true -- Always assume pet will be Rare at level 25
        BPBID_Options.Breedtip.AllStats25 = true -- All breeds' stats at level 25
        BPBID_Options.Breedtip.AllStats25Rare = true -- Always assume pet will be Rare at level 25
        
    elseif (not OptTooltipsEnabled:GetChecked()) then
        
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
        OptBreedtipCollected:Disable()
        
        -- Uncheck all tooltip-related checkboxes
        BPBID_Options.Tooltips.Enabled = false -- Enable Battle Pet BreedID Tooltips
        BPBID_Options.Tooltips.BattleTooltip = false -- In Battle (PrimaryBattlePetUnitTooltip)
        BPBID_Options.Tooltips.BPT = false -- On Items (BattlePetTooltip)
        BPBID_Options.Tooltips.FBPT = false -- On Chat Links (FloatingBattlePetTooltip)
        BPBID_Options.Tooltips.PJT = false -- In the Pet Journal (GameTooltip)
        BPBID_Options.Breedtip.Current = false -- Current pet's breed
        BPBID_Options.Breedtip.Possible = false -- Current pet's possible breeds
        BPBID_Options.Breedtip.SpeciesBase = false -- Pet species' base stats
        BPBID_Options.Breedtip.CurrentStats = false -- Current breed's base stats (level 1 Poor)
        BPBID_Options.Breedtip.AllStats = false -- All breed's base stats (level 1 Poor)
        BPBID_Options.Breedtip.CurrentStats25 = false -- Current breed's stats at level 25
        BPBID_Options.Breedtip.CurrentStats25Rare = false -- Always assume pet will be Rare at level 25
        BPBID_Options.Breedtip.AllStats25 = false -- All breeds' stats at level 25
        BPBID_Options.Breedtip.AllStats25Rare = false -- Always assume pet will be Rare at level 25
    end
    
    -- A manual change has occurred (added in v1.0.8 to help update values added in new versions)
    BPBID_Options.ManualChange = "v1.32.3"
    
    -- Refresh the options page to display the new values
    BPBID_Options_Refresh()
end

local function BPBID_Options_EnableAll()
    OptNamesHSFUpdateRarity:Enable()
    OptNamesPJTRarity:Enable()
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
    OptBreedtipCollected:Enable()
end

local function BPBID_Options_Default()
    
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

    -- Enable all checkboxes that can be enabled (defaults would enable them)
    BPBID_Options_EnableAll()
    
    -- Refresh the options page to display the new defaults
    BPBID_Options_Refresh()
end

local function BPBID_GeneralCheckbox_OnClick(self, button, down)
    -- IF THE LAST TOOLTIP CALLED BEFORE THE OPTIONS ARE CHANGED HAS CHANGED FONT,
    -- BAD STUFF WILL HAPPEN SO CALL ORIGINAL FONT CHANGING FUNCTIONS HERE
    
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
    BPBID_Options.Breedtip.Collected = OptBreedtipCollected:GetChecked()
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
    
    -- A manual change has occurred (added in v1.0.8 to help update values added in new versions)
    BPBID_Options.ManualChange = "v1.32.3"
    
    -- Refresh the options page to display the new defaults
    BPBID_Options_Refresh()
end

-- Refresh on show
Options:SetScript("OnShow", BPBID_Options_Refresh)

-- Enable/disable dependent checkboxes
OptNamesHSFUpdate:SetScript("OnClick", BPBID_OptNamesHSFUpdate_OnClick)
OptNamesPJT:SetScript("OnClick", BPBID_OptNamesPJT_OnClick)
OptTooltipsEnabled:SetScript("OnClick", BPBID_OptTooltipsEnabled_OnClick)
OptBreedtipCurrentStats25:SetScript("OnClick", BPBID_OptBreedtipCurrentStats25_OnClick)
OptBreedtipAllStats25:SetScript("OnClick", BPBID_OptBreedtipAllStats25_OnClick)

-- Toggle settings
OptNamesPrimaryBattle:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptNamesBattleTooltip:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptNamesBPT:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptNamesFBPT:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptNamesHSFUpdateRarity:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptNamesPJTRarity:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptTooltipsBattleTooltip:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptTooltipsBPT:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptTooltipsFBPT:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptTooltipsPJT:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptBreedtipCurrent:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptBreedtipPossible:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptBreedtipSpeciesBase:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptBreedtipCurrentStats:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptBreedtipAllStats:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptBreedtipCurrentStats25Rare:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptBreedtipAllStats25Rare:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptBreedtipCollected:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)
OptBugBattleFontFix:SetScript("OnClick", BPBID_GeneralCheckbox_OnClick)

-- Reset to Defaults button
OptDefaultButton:SetScript("OnClick", BPBID_Options_Default)

-- Set up required functions on frame
Options.OnCommit = BPBID_GeneralCheckbox_OnClick
Options.OnDefault = BPBID_Options_Default
Options.OnRefresh = BPBID_Options_Refresh

-- Add the options panel to the Blizzard list
local category = Settings.RegisterCanvasLayoutCategory(Options, properName, properName)
category.ID = BattlePetBreedIDOptionsName
Settings.RegisterAddOnCategory(category)
