-- Battle Pet Counter by Jadya - EU-Well of Eternity
-- constants
local MaxPetLevel = 25

-- string colors
local LIGHT_BLUE  = "|cff00ccff"
local LIGHT_RED   = "|cffff6060"
local GREEN       = "|cff71C671"
local LIGHT_GREEN = "|cff71FF71"
local YELLOW      = "|cffffff00"
local GRAY        = "|cff888888"
local GOLD        = "|cffffcc00"
local RED         = "|cffff0000"
local WHITE       = "|cffffffff"
local function AddColor(str,color) return color..str.."|r" end

local topheader = AddColor("- - - - - ",GRAY)..AddColor("Battle Pet Counter",LIGHT_BLUE)..AddColor(" - - - - -", GRAY)
local bottomheader = AddColor("- - - - - - - - - - - - - - - - - - - - - - -", GRAY)

local function CountPetsbyLevel(arg)
  ----------- filters handling --------------
  local last_search = ""
  local last_flags = {}
  local last_types = {}
  local last_sources = {}
  
    local flags_cleared = {
        [LE_PET_JOURNAL_FILTER_COLLECTED] = true,
        [LE_PET_JOURNAL_FILTER_NOT_COLLECTED] = true,
        --[LE_PET_JOURNAL_FLAG_FAVORITES] = false
    }

  local function ClearFilters()
   for k,v in pairs(flags_cleared) do
    last_flags[k] = not C_PetJournal.IsFilterChecked(k)
	if not last_flags[k] then
	 C_PetJournal.SetFilterChecked(k, v)
	end
   end
   
   local s = ""
   for i = 1,C_PetJournal.GetNumPetTypes() do
    last_types[i] = not C_PetJournal.IsPetTypeChecked(i)
	if not last_types[i] then
	 C_PetJournal.SetPetTypeFilter(i, true)
	end
   end

   for i = 1,C_PetJournal.GetNumPetSources() do
    last_sources[i] = not C_PetJournal.IsPetSourceChecked(i)
	if not last_sources[i] then
	 C_PetJournal.SetPetSourceChecked(i, true)
	end
   end
   
   if PetJournalSearchBox then
    last_search = PetJournalSearchBox:GetText()
   end
   C_PetJournal.ClearSearchFilter()
  end
  
  

  local function RestoreFilters()
   for k,v in pairs(last_flags) do
    C_PetJournal.SetFilterChecked(k, v)
   end
   
   for k,v in pairs(last_types) do
    if C_PetJournal.IsPetTypeChecked(k) == v then
     C_PetJournal.SetPetTypeFilter(k, v)
	end
   end

   for k,v in pairs(last_sources) do
    if C_PetJournal.IsPetSourceChecked(k) == v then
     C_PetJournal.SetPetSourceChecked(k, v)
	end
   end
   
   if last_search ~= "" and last_search ~= SEARCH then
    C_PetJournal.SetSearchFilter(last_search)
   end
  end
  -------------------------------------------

 -----------
 local function tablelength(tab)
  local result = 0
  table.foreach(tab,function() result = result+1 end)
  return result
 end
 -----------
 local inputlev = tonumber(arg)
 DEFAULT_CHAT_FRAME:AddMessage(topheader)
 if type(inputlev) == "number" and inputlev > 0 and inputlev <= MaxPetLevel then

  local counter = {} -- this will contain the top rarity for each possessed pet
 -- counters
  local c_cantbattle = 0
  local c_poor = 0
  local c_common = 0
  local c_uncommon = 0
  local c_rare = 0
  local c_epic = 0
  local c_legendary = 0
  
  ClearFilters()
  
  local _, numpets = C_PetJournal.GetNumPets()
  
  for id = 1,numpets do
   local petID, _, _, _, level, _, _, _, _, _, companionID, _, _, _, canBattle = C_PetJournal.GetPetInfoByIndex(id)

   if petID then
    local _, _, _, _, rarity = C_PetJournal.GetPetStats(petID)
    if level == inputlev then
     if canBattle then
      if not counter[companionID] then 
       counter[companionID] = rarity 
      elseif rarity > counter[companionID] then 
       counter[companionID] = rarity
      end
     else
      c_cantbattle = c_cantbattle + 1
     end
	end
   end
  end
 
 
  table.foreach(counter, function(id,rarity)
   if      rarity == 1 then c_poor = c_poor + 1
    elseif rarity == 2 then c_common = c_common + 1
    elseif rarity == 3 then c_uncommon = c_uncommon + 1
    elseif rarity == 4 then c_rare = c_rare + 1
    elseif rarity == 5 then c_epic = c_epic + 1
    elseif rarity == 6 then c_legendary = c_legendary + 1
   end
  end)

  if counter then
   DEFAULT_CHAT_FRAME:AddMessage(" - You have a total of "..AddColor(tablelength(counter),LIGHT_GREEN).." different level "..AddColor(inputlev,GOLD).." pets")
   if c_poor > 0 then 
    DEFAULT_CHAT_FRAME:AddMessage(AddColor(c_poor,GOLD).." of these are "..AddColor("poor",GRAY).." quality.")
   end
   if c_common > 0 then 
    DEFAULT_CHAT_FRAME:AddMessage(AddColor(c_common,GOLD).." of these are common quality.")
   end
   if c_uncommon > 0 then
    DEFAULT_CHAT_FRAME:AddMessage(AddColor(c_uncommon,GOLD).." of these are "..AddColor("uncommon",LIGHT_GREEN).." quality.")
   end
   if c_rare > 0 then
    DEFAULT_CHAT_FRAME:AddMessage(AddColor(c_rare,GOLD).." of these are "..AddColor("rare",LIGHT_BLUE).." quality.")
   end
   if c_epic > 0 then
    DEFAULT_CHAT_FRAME:AddMessage(AddColor(c_epic,GOLD).." of these are "..AddColor("epic",GOLD).." quality.")
   end
   if c_legendary > 0 then
    DEFAULT_CHAT_FRAME:AddMessage(AddColor(c_legendary,GOLD).." of these are "..AddColor("legendary",LIGHT_RED).." quality!")
   end
   if c_cantbattle > 0 then
    DEFAULT_CHAT_FRAME:AddMessage(AddColor(c_cantbattle,GOLD).." pets can't pet battle and are not listed above.")
   end
  else
   DEFAULT_CHAT_FRAME:AddMessage("You have "..AddColor(counter,LIGHT_RED).." level "..AddColor(inputlev,GOLD).." pets")
  end
 else -- bad argument
  DEFAULT_CHAT_FRAME:AddMessage("Bad argument, type:")
  DEFAULT_CHAT_FRAME:AddMessage(AddColor("/petcount x",GOLD))
  DEFAULT_CHAT_FRAME:AddMessage("where "..GOLD.."x|r goes from 1 to 25")
 end
 DEFAULT_CHAT_FRAME:AddMessage(bottomheader)
 
 --RestoreFilters()
end

-- slash command
SLASH_PETCOUNT1 = "/petcount"
SlashCmdList["PETCOUNT"] = CountPetsbyLevel