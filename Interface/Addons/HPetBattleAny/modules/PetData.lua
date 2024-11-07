--[[
新的宠物数据可以通过同时使用BattlePetBreedID来提供
请自行下载。
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
end