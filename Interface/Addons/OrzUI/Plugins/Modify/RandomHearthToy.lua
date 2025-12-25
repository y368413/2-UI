--## Author: Hemco  ## Version: 3.2  -- To use random hearthstone toys gathered through world events.

local AllHearthToyIndex = {} --All the toys
local UsableHearthToyIndex = {} --Usable toys
local RHTIndex = false --Macro index
RHT = {} --Setup for button and timeout frame
local RHTInitialized = false

--Frame to catch events
local frame = CreateFrame("Frame")
-- Setting up an invisible button named RHTB.  Toys can only be used through a button click, so we need one for the macro to click.
RHT.b = CreateFrame("Button","RHTB",nil,"SecureActionButtonTemplate")
RHT.b:RegisterForClicks("AnyUp","AnyDown")
RHT.b:SetAttribute("type","item")

-- Setting up a frame to wait and see if the toybox is loaded before getting stones on login.
local timeOut = 10 --Delay for checking stones.
C_Timer.After(timeOut, function()
	local ticker
	ticker = C_Timer.NewTicker(1, function()
		if C_ToyBox.GetNumToys() > 0 then
			GetLearnedStones()
			if RHTInitialized then
				SetRandomHearthToy()
				ticker:Cancel()
			end
		end
	end)
end)

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("LOADING_SCREEN_DISABLED")
-- Spellcast stopping is the check for if a hearthstone has been used.
frame:RegisterEvent("UNIT_SPELLCAST_STOP")

local function Event(self, event, arg1, arg2, arg3)
	if event == "PLAYER_ENTERING_WORLD" or event == "LOADING_SCREEN_DISABLED" then
		if RHTInitialized then
			SetRandomHearthToy()
		else
			GetMacroIndex()
		end
	end
	-- When a spell cast stops and it's the player's spell, send the ID to check if it's a stone.
	if event == "UNIT_SPELLCAST_STOP" and arg1 == "player" then
		SpellcastUpdate(arg3)
	end
end

frame:SetScript("OnEvent", Event)

-- Generate list of stones in game.
-- [Item ID] = Spell ID
AllHearthToyIndex[166747] = 286353 --Brewfest
AllHearthToyIndex[165802] = 286031 --Noble
AllHearthToyIndex[165670] = 285424 --Peddlefeet
AllHearthToyIndex[165669] = 285362 --Lunar
AllHearthToyIndex[166746] = 286331 --Fire Eater
AllHearthToyIndex[163045] = 278559 --Horseman
AllHearthToyIndex[162973] = 278244 --Greatfather
--AllHearthToyIndex[142542] = 231504 --Tome of TP *CD is broken with TWW pre-patch and messes up the rotation.
AllHearthToyIndex[64488]  = 94719  --Innkeeper
AllHearthToyIndex[54452]  = 75136  --Ethereal
AllHearthToyIndex[93672]  = 136508 --Dark Portal
AllHearthToyIndex[168907] = 298068 --Holographic Digitalization
AllHearthToyIndex[172179] = 308742 --Eternal Traveler
AllHearthToyIndex[190237] = 367013 --Broker
AllHearthToyIndex[188952] = 363799 --Dominated
AllHearthToyIndex[193588] = 375357 --Timewalker
AllHearthToyIndex[200630] = 391042 --Windsage
AllHearthToyIndex[206195] = 412555 --Path of the Naaru
AllHearthToyIndex[190196] = 366945 --Enlightened
AllHearthToyIndex[209035] = 422284 --Flame
--AllHearthToyIndex[212337] = 401802 --Stone of Hearth *CD is broken with TWW pre-patch and messes up the rotation.
AllHearthToyIndex[208704] = 420418 --Deepdweller's
--These need covenat checks, can't use it unless you are one.  Also, covenant check can't occur until fully loaded; moving this to check along stone checking.
--AllHearthToyIndex[182773] = 340200 --Necrolord
--AllHearthToyIndex[180290] = 326064 --Night Fae
--AllHearthToyIndex[184353] = 345393 --Kyrian
--AllHearthToyIndex[183716] = 342122 --Venthyr
--Needs a Draenai check, will add later.
--AllHearthToyIndex[210455] = 438606 --Draenic *CD is broken with TWW pre-patch and messes up the rotation.

-- This is the meat right here.
function SetRandomHearthToy()
	-- Setting the new stone while in combat is bad.
	if not InCombatLockdown() then
		-- Find the macro.
		CheckMacroIndex()
		-- Rebuild the stone list if it's empty.
		if next(UsableHearthToyIndex) == nil then
			GetLearnedStones()
		end		
		local itemID, toyName = ''
		-- Randomly pick one.
		local k = RandomKey(UsableHearthToyIndex)
		local itemID, toyName = C_ToyBox.GetToyInfo(k)
		if toyName then
			-- Remove it from the list so we don't pick it again.
			RemoveStone(k)
			-- Write the macro.
			GenMacro(itemID, toyName)
			-- Set button for first use
			if not RHT.b:GetAttribute("item") then RHT.b:SetAttribute("item",toyName) end
		end
	end
end

-- Get stones learned and usable by character
function GetLearnedStones()
	-- Checking to see if we're a Necrolord. We should be fully loaded by now since we're wating for the ToyBox to load.
	if C_Covenants.GetActiveCovenantID() == 4 then
		AllHearthToyIndex[182773] = 340200 --Necrolord
	elseif C_Covenants.GetActiveCovenantID() == 3 then
		AllHearthToyIndex[180290] = 326064 --Night Fae
	elseif C_Covenants.GetActiveCovenantID() == 2 then
		AllHearthToyIndex[183716] = 342122 --Venthyr
	elseif C_Covenants.GetActiveCovenantID() == 1 then
		AllHearthToyIndex[184353] = 345393 --Kyrian
	end
	-- Get the current setting for the toybox so we can set it back after we're done.
	ToyCollSetting = C_ToyBox.GetCollectedShown()
	ToyUnCollSetting = C_ToyBox.GetUncollectedShown()
	ToyUsableSetting = C_ToyBox.GetUnusableShown()
	
	C_ToyBox.SetCollectedShown(true) -- List collected toys
	C_ToyBox.SetUncollectedShown(false) -- Don't list uncollected toys
	C_ToyBox.SetUnusableShown(false) -- Don't list unusable toys in the the collection.	
	
	-- Go through all the toys to find the usable stones.
	for i = 1, C_ToyBox.GetNumFilteredToys() do
		-- Go through all the stones to see if this toy is a stone.
		for k in pairs(AllHearthToyIndex) do
			if k == C_ToyBox.GetToyFromIndex(i) then
				UsableHearthToyIndex [k] = 1
			end
		end
	end
	 -- Reset the toybox filter
	C_ToyBox.SetCollectedShown(ToyCollSetting)
	C_ToyBox.SetUncollectedShown(ToyUnCollSetting)
	C_ToyBox.SetUnusableShown(ToyUsableSetting)
	if next(UsableHearthToyIndex) then
		RHTInitialized = true
	end
end

-- We've removed the name from the macro, so now we need to find it so we know which one to edit.
function GetMacroIndex()
	local numg, numc = GetNumMacros()
	for i = 1, numg do
		local macroCont = GetMacroBody(i)
		if(macroCont) then -- apperently there's a chance of not having anything here
		--  Hopefully no other macro ever made has "RHT.b" in it...
		if string.find(macroCont, "RHT.b") then
			RHTIndex = i
			end
		end
	end
end

-- Have we found the macro yet? Also, make sure the macro we're editing is the right one in case the user rearranged things or deleted it.  If not, go find it.
function CheckMacroIndex()
	local macroCont = GetMacroBody(RHTIndex)
	if macroCont then
		if string.find(macroCont, "RHT.b") then
			return
		end
	end
	GetMacroIndex()
end

-- Macro writing time.
function GenMacro(itemID, toyName)
	-- Did we find the index?  If so, edit that. The macro changes the button to the next stone, but only if we aren't in combat; can't SetAttribute. It then "clicks" the RHTB button
	if RHTIndex then
		EditMacro(RHTIndex, " ", "INV_MISC_QUESTIONMARK", "#showtooltip item:" .. itemID .. "\r/run if not InCombatLockdown() then RHT.b:SetAttribute(\"item\",\"" .. toyName .. "\") end\r/click RHTB X " .. GetCVar("ActionButtonUseKeyDown"))
	else
		-- No macro found, make a new one, get it's ID, then set the toy on the invisble button. This one is named so people can find it on first use.
		CreateMacro("RHT", "INV_MISC_QUESTIONMARK", "#showtooltip item:" .. itemID .. "\r/run if not InCombatLockdown() then RHT.b:SetAttribute(\"item\",\"" .. toyName .. "\") end\r/click RHTB X " .. GetCVar("ActionButtonUseKeyDown"))
		GetMacroIndex()
	end
end

-- Remove stone from the list so we don't use it again. (Here for debugging)
function RemoveStone(k)
	if(UsableHearthToyIndex[k]) then
		UsableHearthToyIndex[k] = nil
	end
end

-- Did a stone get used?
function SpellcastUpdate(spellID)
if not InCombatLockdown() then
	for k in pairs(AllHearthToyIndex) do
		if spellID == AllHearthToyIndex[k] then
			SetRandomHearthToy()
			break
		end
	end
end
end

-- Old function to delete the base HS from bags.  Leaving in case I can find a workaround from Blizz's change.
function DeleteHearthstone()
	for bag = 0,4 do
		for slot = 1, 32 do
			local itemID = GetContainerItemID(bag,slot)
			if itemID == 6948 then
				PickupContainerItem(bag,slot)
				DeleteCursorItem()
			end
		end
	end
end

-- Code to randomly pick a key from a table.
function RandomKey(t)
	local keys = {}
	for key, value in pairs(t) do
		keys[#keys+1] = key --Store keys in another table.
	end
	if (not #keys) or (#keys < 1) then return 0 end
	index = keys[math.random(1, #keys)]
	return index
end