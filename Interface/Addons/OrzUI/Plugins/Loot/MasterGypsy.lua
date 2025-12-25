--## Version: r2.15b ## SavedVariables: Gypsy_Options

Gypsy = {}
Gypsy.Players = {}
Gypsy.inspecting = false
Gypsy.waitForResponse = false
Gypsy.inspectCycle = 0
Gypsy.ExAn = false
Gypsy.Gamehook = CreateFrame("Frame", nil, nil)


--Iteminfo 
	--[3] quality
	--[4] ilvl
	--[9] slot
	--[13] 
		-- type 0 trinket back rings neck
		-- type 1 cloth
		-- type 2 leather
		-- type 3 mail
		-- type 4 plate
		-- type 5 non-wearable
		

function Gypsy.managePlayers()
	if Gypsy.localizedGem == nil then
		Gypsy.MockForLocal = {GetItemInfo(152055)}
		Gypsy.localizedGem, Gypsy.localizedRelic =  Gypsy.MockForLocal[6],Gypsy.MockForLocal[7]
	end
	if (GetNumGroupMembers == 0 and Gypsy.Players ~= nil) then Gypsy.Players = nil Gypsy.Players = {} end
	if (Gypsy.Itemclass == nil) then Gypsy.Itemclass = Gypsy.getItemClass() end
	-- not inspecting
	if (Gypsy.inspecting == false) then
		for i_1 = 1, GetNumGroupMembers(), 1 do
			local name, _, _, _, class = GetRaidRosterInfo(i_1)
			if (name ~= nil and class ~= nil) then
				if (Gypsy.Players[name] ~= nil) then
					if (Gypsy.Players[name].isInspected == false and Gypsy.Players[name].timeout == 0) then
						--print("trying " .. name)
						Gypsy.fetchData(name)
					end
				else
				Gypsy.createPlayer(name, class)
				end
			end
		end
	else
	-- inspecting
	Gypsy.fetchData(nil)
	end
	
	--general
	for i_2 = 1, GetNumGroupMembers(), 1 do
		local name, _, _, _, class = GetRaidRosterInfo(i_2)
		if Gypsy.Players[name] ~= nil then
			if (Gypsy.Players[name].timeout > 0) then Gypsy.Players[name].timeout = Gypsy.Players[name].timeout - 1 end
		end
	end
end

function Gypsy.createPlayer(name, class)
	--print("Creating: ".. name)
	local player = {}
	player.name = name
	player.class = class
	player.inventory = {}
	player.timeout = 0
	player.isInspected = false
	
	Gypsy.Players[name] = player
end

--RegisterAddonMessagePrefix("GYPSY")

function Gypsy.AnswerReq()
	C_ChatInfo.SendAddonMessage("GYPSY", "0;ANSWER;"..UnitName("player") .. "-" ..GetRealmName() .. ";", "RAID")
end

function Gypsy.SendReq()
	print("Who is a gypsy?")
	C_ChatInfo.SendAddonMessage("GYPSY", "0;WHOIS;", "RAID")
end


SLASH_GYPSY1 = "/gypsy"
SlashCmdList["GYPSY"] = function(msg1, msg2) 
	msg1 = string.lower(msg1)
	if string.find(msg1, "whois") then
		Gypsy.ExAn = true
		Gypsy.SendReq()
	end
	--if string.find(msg1, "stop") then
	--	Prankboi.Mainframe.SetScript("onUpdate", nil)
	--end
 end

function Gypsy.fetchData(name)
		local inventory = {}
		local inspectSuccess = false
		
		Gypsy.inspectCycle = Gypsy.inspectCycle + 1
		if (Gypsy.waitForResponse == false) then
			if Gypsy.inspectedPlayer == nil and name ~= nil then
				--print("inspecting: " .. name)
				Gypsy.inspecting = true
				Gypsy.inspectCycle = 0
				Gypsy.inspectedPlayer = name
				NotifyInspect(name)
			else
				--print(Gypsy.inspectCycle)
				inspectSuccess, inventory = Gypsy.getInventory(Gypsy.inspectedPlayer)
			end
			
			if (inspectSuccess) then
				--print("Successfully inspected:" .. Gypsy.inspectedPlayer)
				--SendChatMessage(Gypsy.inspectedPlayer, "WHISPER", "COMMON", UnitName("player"))
				Gypsy.Players[Gypsy.inspectedPlayer].inventory = inventory
				Gypsy.Players[Gypsy.inspectedPlayer].isInspected = true
				Gypsy.Players[Gypsy.inspectedPlayer].timeout = 0
				Gypsy.inspectCycle = 0
				Gypsy.inspecting = false
				Gypsy.inspectedPlayer = nil
				ClearInspectPlayer()
			end		
				
				if (Gypsy.inspectCycle >= 100) then
					--print("STOP: " .. Gypsy.inspectCycle .. " --> " .. Gypsy.inspectedPlayer)
					Gypsy.inspectCycle = 0
					Gypsy.Players[Gypsy.inspectedPlayer].timeout = 300
					ClearInspectPlayer()
					Gypsy.inspecting = false
					Gypsy.inspectedPlayer = nil
				end
				
		else		
			
			--if parsing wasnt possible
			--if Gypsy.inspectedPlayer ~= nil and Gypsy.waitForResponse == false then
			if Gypsy.inspectedPlayer ~= nil then
				if (Gypsy.inspectCycle % 10 == 0) then NotifyInspect(Gypsy.inspectedPlayer) end
				if (Gypsy.inspectCycle >= 100 or CanInspect(Gypsy.inspectedPlayer) == false) then
					--print("STOP: " .. Gypsy.inspectCycle .. " --> " .. Gypsy.inspectedPlayer)
					Gypsy.inspectCycle = 0
					Gypsy.Players[Gypsy.inspectedPlayer].timeout = 50
					ClearInspectPlayer()
					Gypsy.inspecting = false
					Gypsy.inspectedPlayer = nil
				end
			end
		end
		
	
end

function Gypsy.getGemLevel(item)
	local arr = {GetItemInfo(item)}
	return arr[4]
end

function Gypsy.getWeaponInfo(item)
	local lowestGemLevel = 1000
	local mh1 = {GetItemGem(GetInventoryItemLink(UnitName("player"), 16),1)}
	if (mh1[2] ~= nil) then 
		if C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot(Gypsy.getItemID(item), 1) then
			mh1 = Gypsy.getGemLevel(mh1[2])
		else mh1 = nil
		end
	end
	
	local mh2 = {GetItemGem(GetInventoryItemLink(UnitName("player"), 16),2)}
	if (mh2[2] ~= nil) then 
		if C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot(Gypsy.getItemID(item), 2) then
			mh2 = Gypsy.getGemLevel(mh2[2])
		else mh2 = nil			
		end
	end
	
	local mh3 = {GetItemGem(GetInventoryItemLink(UnitName("player"), 16),3)}
	if (mh3[2] ~= nil) then
		if C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot(Gypsy.getItemID(item), 3) == true then
			mh3 = Gypsy.getGemLevel(mh3[2])
		else mh3 = nil
		end
	end
	
	
	if GetInventoryItemLink(UnitName("player"), 17) ~= nil then
		local oh1 = {GetItemGem(GetInventoryItemLink(UnitName("player"), 17),1)}
		if (oh1[2] ~= nil) then 
			if C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot(Gypsy.getItemID(item), 1) then
				oh1 = Gypsy.getGemLevel(oh1[2]) else oh1 = nil
			end
		end
		
		local oh2 = {GetItemGem(GetInventoryItemLink(UnitName("player"), 17),2)}
		if (oh2[2] ~= nil) then 
			if C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot(Gypsy.getItemID(item), 2) then
				oh2 = Gypsy.getGemLevel(oh2[2]) else oh2 = nil 
			end
		end
		
		local oh3 = {GetItemGem(GetInventoryItemLink(UnitName("player"), 17),3)}
		if (oh3[2] ~= nil) then 
			if C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot(Gypsy.getItemID(item),3) then
				oh3 = Gypsy.getGemLevel(oh3[2]) else oh3 = nil
			end
		end
	end
	
	if (mh1 ~= nil or mh2 ~= nil or mh3 ~= nil) then
		if mh1 ~= nil and mh1 <= lowestGemLevel then lowestGemLevel = mh1 end
		if mh2 ~= nil and mh2 <= lowestGemLevel then lowestGemLevel = mh2 end
		if mh3 ~= nil and mh3 <= lowestGemLevel then lowestGemLevel = mh3 end
	elseif (oh1 ~= nil or oh2 ~= nil or oh3 ~= nil) then
		if oh1[2] <= lowestGemLevel then lowestGemLevel = oh1[2] end
		if oh2[2] <= lowestGemLevel then lowestGemLevel = oh2[2] end
		if oh3[2] <= lowestGemLevel then lowestGemLevel = oh3[2] end
	else
		lowestGemLevel =100000
	end
	
	return lowestGemLevel
end

function Gypsy.getInventory(player)
  local checkedEverything = true
		local inventory = {}
		if(GetInventoryItemLink(player, 1) == nil) then checkedEverything = false else inventory.head = GetInventoryItemLink(player, 1) end
		if(GetInventoryItemLink(player, 2) == nil) then checkedEverything = false else inventory.neck = GetInventoryItemLink(player, 2) end
		if(GetInventoryItemLink(player, 3) == nil) then checkedEverything = false else inventory.shoulder = GetInventoryItemLink(player, 3) end
		if(GetInventoryItemLink(player, 5) == nil) then checkedEverything = false else inventory.chest = GetInventoryItemLink(player, 5) end
		if(GetInventoryItemLink(player, 6) == nil) then checkedEverything = false else inventory.waist = GetInventoryItemLink(player, 6) end
		if(GetInventoryItemLink(player, 7) == nil) then checkedEverything = false else inventory.legs = GetInventoryItemLink(player, 7) end
		if(GetInventoryItemLink(player, 8) == nil) then checkedEverything = false else inventory.feet = GetInventoryItemLink(player, 8) end
		if(GetInventoryItemLink(player, 9) == nil) then checkedEverything = false else inventory.wrist = GetInventoryItemLink(player, 9) end
		if(GetInventoryItemLink(player, 10) == nil) then checkedEverything = false else inventory.hand = GetInventoryItemLink(player, 10) end
		if(GetInventoryItemLink(player, 11) == nil) then checkedEverything = false else inventory.finger1 = GetInventoryItemLink(player, 11) end
		if(GetInventoryItemLink(player, 12) == nil) then checkedEverything = false else inventory.finger2 = GetInventoryItemLink(player, 12) end
		if(GetInventoryItemLink(player, 13) == nil) then checkedEverything = false else inventory.trinket1 = GetInventoryItemLink(player, 13) end
		if(GetInventoryItemLink(player, 14) == nil) then checkedEverything = false else inventory.trinket2 = GetInventoryItemLink(player, 14) end
		if(GetInventoryItemLink(player, 15) == nil) then checkedEverything = false else inventory.back = GetInventoryItemLink(player, 15) end
    if(GetInventoryItemLink(player, 16) == nil) then checkedEverything = false else inventory.mainhand = GetInventoryItemLink(player, 16) end
    --if(GetInventoryItemLink(player, 17) == nil) then checkedEverything = false else inventory.mainhand = GetInventoryItemLink(player, 17) end
		
		return checkedEverything, inventory
end

function Gypsy.extractItemlink(msg)
	local s_start = string.find(msg, "|")
	local s_end = string.find(msg, "|h|r") + 3
	local s_itemname = string.sub(msg, s_start, s_end)
	--local s_itemname = string.match(msg, "|%x+|Hitem:.-|h.-|h|r")  --s_start, s_end
	--local s_itemname = string.match(msg, "|c.-|h%[.-%]|h|r")  
	return s_itemname
end

function Gypsy.isWearable(item)
	local itemInfo = {GetItemInfo(item)}
	if (Gypsy.getItemSlot ~= "MISC") then
		--wearables
		if itemInfo[13] == Gypsy.Itemclass or itemInfo[13] == 0 or (itemInfo[13] == 1 and (itemInfo[9] == "INVTYPE_BACK" or itemInfo[9] == "INVTYPE_CLOAK")) then return true end
		-- weapons
		if (itemInfo[9] == "INVTYPE_2HWEAPON" or itemInfo[9] == "INVTYPE_WEAPON" or itemInfo[9] == "INVTYPE_HOLDABLE" or itemInfo[9] == "INVTYPE_SHIELD" or itemInfo[9] == "INVTYPE_RANGED" or itemInfo[9] == "INVTYPE_RANGEDRIGHT") then 
				if Gypsy.CheckClassWeapon(item) then 
					return true
				end
		end
	end
	return false	
end

function Gypsy.isMisc(item)

	if Gypsy.localizedGem == nil then
		Gypsy.MockForLocal = {GetItemInfo(152055)}
		Gypsy.localizedGem, Gypsy.localizedRelic =  Gypsy.MockForLocal[6],Gypsy.MockForLocal[7]
	end
	local itemInfo = {GetItemInfo(item)}

	if (itemInfo[9] == "INVTYPE_2HWEAPON" or itemInfo[9] == "INVTYPE_WEAPON" or itemInfo[9] == "INVTYPE_HOLDABLE" or itemInfo[9] == "INVTYPE_SHIELD" or itemInfo[9] == "INVTYPE_RANGED" or itemInfo[9] == "INVTYPE_RANGEDRIGHT") then 
		return false
	end
	
	if itemInfo[6] == Gypsy.localizedGem and itemInfo[7] ~= Gypsy.localizedRelic then
		return false
	end
	
	if itemInfo[7] == Gypsy.localizedRelic then
		if itemInfo[4] >= Gypsy.getWeaponInfo(item) then return true else return false end
	end
	
	if itemInfo[3] == 4 and itemInfo[7] ~= Gypsy.localizedRelic then
		if itemInfo[13] == 5 then return true end
		if itemInfo[13] == 11 then return true end
	end
	return false	
end

function Gypsy.getItemSlot(item)
	local itemInfo = {GetItemInfo(item)}
	local fs = itemInfo[9]
	if string.sub(fs, 1, 7) == "INVTYPE" then
		local snipper = string.sub(fs, 9)
		if (snipper == "CLOAK") then return "BACK" end
		if string.len(snipper) > 2 then 
			return snipper
		else
			return "MISC"
		end
	else
		return "MISC"
	end
end

function Gypsy.getItemID(item)
	local arr = {GetItemInfo(item)}
	local i_start = string.find(arr[2], "item:") + 5
	local i_end = string.find(arr[2], ":", i_start + 2)-1
	local txt_x = string.sub(arr[2], i_start, i_end)
	return txt_x
end

function Gypsy.checkUseful(item, looter)
	local itemInfo = {GetItemInfo(item)}
	local itemslot = string.lower(Gypsy.getItemSlot(item))
	--print("checking item: " .. itemInfo[1] .. " (slot: " .. itemslot .. ")")
	--print("looter: " .. looter)
	if (itemInfo[3] == 4 or itemInfo[3] == 3) then
		if (string.lower(itemslot) ~= "finger" and string.lower(itemslot) ~= "trinket" ) then
			--regular itemslot
			if Gypsy.Players[looter].inventory[itemslot] ~= nil and Gypsy.Players[UnitName("player")].inventory[itemslot] ~= nil then 
				local item_looter = {GetItemInfo(Gypsy.Players[looter].inventory[itemslot])}
				local item_player = {GetItemInfo(Gypsy.Players[UnitName("player")].inventory[itemslot])}
				if item_looter[4] >= itemInfo[4] and item_player[4] <= itemInfo[4] then return true end
			else 
				return false
			end
			
		else
			-- trinkets and rings(1-2)
			if string.lower(itemslot) == "finger"  and Gypsy.Players[UnitName("player")].inventory["finger1"] ~= nil and Gypsy.Players[UnitName("player")].inventory["finger2"] ~= nil and Gypsy.Players[looter].inventory["finger1"] ~= nil and Gypsy.Players[looter].inventory["finger2"] ~= nil then
				local item_looter1 = {GetItemInfo(Gypsy.Players[looter].inventory["finger1"])}
				local item_looter2 = {GetItemInfo(Gypsy.Players[looter].inventory["finger2"])}
				local item_player1 = {GetItemInfo(Gypsy.Players[UnitName("player")].inventory["finger1"])}
				local item_player2 = {GetItemInfo(Gypsy.Players[UnitName("player")].inventory["finger2"])}
				
				local looter_best = ""
				local player_best = ""
				if item_looter1[4] > item_looter2[4] then looter_best = item_looter1 else looter_best = item_looter2 end
				if item_player1[4] > item_player2[4] then player_best = item_player1 else player_best = item_player2 end
				
				if (looter_best[4] >= itemInfo[4] and itemInfo[4] >= player_best[4]) then return true end
				
			elseif string.lower(itemslot) == "trinket" and Gypsy.Players[UnitName("player")].inventory["trinket1"] ~= nil and Gypsy.Players[UnitName("player")].inventory["trinket2"] ~= nil and Gypsy.Players[looter].inventory["trinket1"] ~= nil and Gypsy.Players[looter].inventory["trinket2"] ~= nil then
				local item_looter1 = {GetItemInfo(Gypsy.Players[looter].inventory["trinket1"])}
				local item_looter2 = {GetItemInfo(Gypsy.Players[looter].inventory["trinket2"])}
				local item_player1 = {GetItemInfo(Gypsy.Players[UnitName("player")].inventory["trinket1"])}
				local item_player2 = {GetItemInfo(Gypsy.Players[UnitName("player")].inventory["trinket2"])}
				
				local looter_best = ""
				local player_best = ""
				if item_looter1[4] > item_looter2[4] then looter_best = item_looter1 else looter_best = item_looter2 end
				if item_player1[4] > item_player2[4] then player_best = item_player1 else player_best = item_player2 end
				
				if (looter_best[4] >= itemInfo[4] and itemInfo[4] >= player_best[4]) then return true end
			else
				return false
			end
		end
	end
	return false
end

function Gypsy.ChatCmdSplit(msg) -- returns message as array, { [1] ID | [2] command | [3..1000] payloads
	local arr = {}
	local curPos = 1 
		while(string.find(msg, ";", curPos) ~= nil) do
			local newPos = string.find(msg, ";", curPos) 
			table.insert(arr, string.sub(msg, curPos, newPos-1))
			curPos = newPos + 1
		end
	return arr
end

function Gypsy.lootRoutine(...)
	local msg, _, _, _, sender = ...
	local item = Gypsy.extractItemlink(msg)
	local looter = sender
  if (Gypsy.Players[looter] == nil) then
    looter = string.sub(looter, 1, string.len(looter) - (string.len(GetRealmName())+1))
    if (Gypsy.Players[looter] ~= nil) then
      --print("Looter now found!")
    end
  end
	--print("looter and player inspected?")
	if (string.find(msg, "bonus") == nil and Gypsy.Players[looter] ~= nil and Gypsy.Players[looter].isInspected and Gypsy.Players[UnitName("player")].isInspected and looter ~= UnitName("player")) then
		--print("true, isWearable?")
		if Gypsy.isWearable(item) then
			if Gypsy.checkUseful(item, looter) then Gypsy.createLootframe(looter, item) end
		elseif Gypsy.isMisc(item) then
			Gypsy.createLootframe(looter, item)
		end
	else
	end
end

function Gypsy.CheckClassWeapon(weapon)
	local w = {GetItemInfo(weapon)}
	local weapontype = w[7]
	local uc = {UnitClass("player")}
	local myclass = uc[2]
	if (myclass == "WARRIOR") then 
		if weapontype == "One-Handed Maces" then return true end
		if weapontype == "Two-Handed Maces" then return true end
		if weapontype == "One-Handed Swords" then return true end
		if weapontype == "Two-Handed Swords" then return true end
		if weapontype == "One-Handed Axes" then return true end
		if weapontype == "Two-Handed Axes" then return true end
		if weapontype == "Polearms" then return true end
		if weapontype == "Staves" then return true end
		if weapontype == "Daggers" then return true end
		if weapontype == "Fist Weapons" then return true end
		if weapontype == "Shields" then return true end		
	end
	if (myclass == "PALADIN") then 
		if weapontype == "One-Handed Maces" then return true end
		if weapontype == "Two-Handed Maces" then return true end
		if weapontype == "One-Handed Swords" then return true end
		if weapontype == "Two-Handed Swords" then return true end
		if weapontype == "One-Handed Axes" then return true end
		if weapontype == "Two-Handed Axes" then return true end
		if weapontype == "Polearms" then return true end
		if weapontype == "One-Handed Maces" then return true end
		if weapontype == "Shields" then return true end
	end
	if (myclass == "HUNTER") then 
		if weapontype == "One-Handed Swords" then return true end
		if weapontype == "Two-Handed Swords" then return true end
		if weapontype == "One-Handed Axes" then return true end
		if weapontype == "Two-Handed Axes" then return true end
		if weapontype == "Polearms" then return true end
		if weapontype == "Staves" then return true end
		if weapontype == "Daggers" then return true end
		if weapontype == "Fist Weapons" then return true end
		if weapontype == "Bows" then return true end
		if weapontype == "Crossbows" then return true end
		if weapontype == "Guns" then return true end
	end
	if (myclass == "ROGUE") then 
		if weapontype == "One-Handed Maces" then return true end
		if weapontype == "One-Handed Swords" then return true end
		if weapontype == "One-Handed Axes" then return true end
		if weapontype == "Daggers" then return true end
		if weapontype == "Fist Weapons" then return true end
	end
	if (myclass == "PRIEST") then 
		if weapontype == "One-Handed Maces" then return true end
		if weapontype == "Staves" then return true end
		if weapontype == "Daggers" then return true end
		if weapontype == "Wands" then return true end
		if weapontype == "Miscellaneous" then return true end
	end
	if (myclass == "DEATHKNIGHT") then 
		if weapontype == "One-Handed Maces" then return true end
		if weapontype == "Two-Handed Maces" then return true end
		if weapontype == "One-Handed Swords" then return true end
		if weapontype == "Two-Handed Swords" then return true end
		if weapontype == "One-Handed Axes" then return true end
		if weapontype == "Two-Handed Axes" then return true end
		if weapontype == "Polearms" then return true end
	end
	if (myclass == "SHAMAN") then 
		if weapontype == "One-Handed Maces" then return true end
		if weapontype == "Two-Handed Maces" then return true end
		if weapontype == "One-Handed Axes" then return true end
		if weapontype == "Two-Handed Axes" then return true end
		if weapontype == "Staves" then return true end
		if weapontype == "Daggers" then return true end
		if weapontype == "Fist Weapons" then return true end
		if weapontype == "Shields" then return true end
	end
	if (myclass == "MAGE") then 
		if weapontype == "One-Handed Swords" then return true end
		if weapontype == "Staves" then return true end
		if weapontype == "Daggers" then return true end
		if weapontype == "Wands" then return true end
		if weapontype == "Miscellaneous" then return true end
	end
	if (myclass == "WARLOCK") then 
		if weapontype == "One-Handed Swords" then return true end
		if weapontype == "Polearms" then return true end
		if weapontype == "Staves" then return true end
		--if weapontype == "法杖" then return true end
		if weapontype == "Daggers" then return true end
		if weapontype == "Wands" then return true end
		if weapontype == "Miscellaneous" then return true end
	end
	if (myclass == "MONK") then 
		if weapontype == "One-Handed Maces" then return true end
		if weapontype == "One-Handed Swords" then return true end
		if weapontype == "One-Handed Axes" then return true end
		if weapontype == "Polearms" then return true end
		if weapontype == "Staves" then return true end
		if weapontype == "Fist Weapons" then return true end
		if weapontype == "Miscellaneous" then return true end
	end
	if (myclass == "DRUID") then 
		if weapontype == "One-Handed Maces" then return true end
		if weapontype == "Two-Handed Maces" then return true end
		if weapontype == "Polearms" then return true end
		if weapontype == "Staves" then return true end
		if weapontype == "Daggers" then return true end
		if weapontype == "Fist Weapons" then return true end
		if weapontype == "Miscellaneous" then return true end
	end
	if (myclass == "DEMONHUNTER") then 
		if weapontype == "Warglaives" then return true end
		if weapontype == "Two-Handed Swords" then return true end
		if weapontype == "One-Handed Axes" then return true end
		if weapontype == "Fist Weapons" then return true end
	end
	return false
end

function Gypsy.evt(self, evt, ...)
	if (evt == "INSPECT_READY") then Gypsy.waitForResponse = false end
	if (evt == "CHAT_MSG_LOOT") then Gypsy.lootRoutine(...) end
	--if (evt == "ADDON_LOADED") then Gypsy.init(...) end
	if (evt == "CHAT_MSG_ADDON") then
		local prefix, message, channel, sender = ...
		--print (prefix)
		if prefix == "GYPSY" then
			--print(message)
			local dmsg = Gypsy.ChatCmdSplit(message)
			local id = tonumber(dmsg[1])
			local cmd = dmsg[2]
			local payload = {}
			if (string.find(sender, "-") == nil) then 	sender = sender .. "-" .. GetRealmName() end
			--print(cmd)
			for i = 3, #dmsg do tinsert(payload, dmsg[i]) end
			if (cmd == "WHOIS") then
				--print("WHOIS received")
				Gypsy.AnswerReq()
			end
			if (cmd == "ANSWER") and (Gypsy.ExAn == true) then
			--	print("0: " .. payload[0])
				print(payload[1])
			end
		end -- 
	end -- end of CHAT MESSAGE ADDON events
end

function Gypsy.getItemClass()
	UC = {UnitClass(UnitName("player"))}
	
	if UC[2] == "PRIEST" then return 1 end
	if UC[2] == "WARRIOR" then return 4 end
	if UC[2] == "PALADIN" then return 4 end
	if UC[2] == "HUNTER" then return 3 end
	if UC[2] == "ROGUE" then return 2 end
	if UC[2] == "DEATHKNIGHT" then return 4 end
	if UC[2] == "SHAMAN" then return 3 end
	if UC[2] == "MAGE" then return 1 end
	if UC[2] == "WARLOCK" then return 1 end
	if UC[2] == "MONK" then return 2 end
	if UC[2] == "DRUID" then return 2 end
	if UC[2] == "DEMONHUNTER" then return 2 end
	if UC[2] == "EVOKER" then return 2 end
end

--function Gypsy.createCondition(con1, operator, con2, item, looter) -- not finished. Not sure if I'm going to implement the dynamic system again.
	
--	local con1 = Gypsy.conditionManager(con1, item, looter)
--	local con2 = Gypsy.conditionManager(con2, item, looter)
--	
--	if operator == "==" then
--		if con1 == con2 then true else false end
--	end
--	
--	if operator == ">=" then
--		if con1 >= con2 then true else false end
--	end
--end

function Gypsy.initFrameContainer()
	Gypsy.Lootframes = {}
	Gypsy.FrameHeader = CreateFrame("Frame", "GypsyFrameHeader", UIParent)
	Gypsy.FrameHeader:SetHeight(21) --+ (80*7))
	Gypsy.FrameHeader:SetWidth(10+60+10+150+10+10)
	Gypsy.FrameHeader:SetPoint("RIGHT", -80, 210)
	Gypsy.FrameHeader:SetScale(0.85)
	Gypsy.FrameHeader.TexBorder = Gypsy.FrameHeader:CreateTexture() Gypsy.FrameHeader.TexBorder:SetPoint("TOPLEFT", 0,0) Gypsy.FrameHeader.TexBorder:SetSize(10+60+10+150+10+10,45)
	Gypsy.FrameHeader.TexBackground = Gypsy.FrameHeader:CreateTexture()
	local mx,my = Gypsy.FrameHeader.TexBorder:GetSize()
	--print(mx, my)
	Gypsy.FrameHeader.TexBackground:SetSize(mx-4, my-4)
	Gypsy.FrameHeader.TexBackground:SetPoint("TOPLEFT", Gypsy.FrameHeader.TexBorder, 2, -2)	
	Gypsy.FrameHeader.TexBorder:SetColorTexture(.2,.2,.2)
	Gypsy.FrameHeader.TexBackground:SetColorTexture(.05,.05,.05)
	Gypsy.FrameHeader.TexBackground:SetDrawLayer("ARTWORK", 1)
	
	Gypsy.FrameHeader.Text = Gypsy.FrameHeader:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	Gypsy.FrameHeader.Text:SetPoint("TOP", Gypsy.FrameHeader.TexBackground)
	Gypsy.FrameHeader.Text:SetDrawLayer("Artwork", 2)
	Gypsy.FrameHeader.Text:SetText(" - 快乐滴去求大佬赐装备 - ")
	Gypsy.FrameHeader:SetScript("OnMouseDown", function() Gypsy.FrameHeader:SetMovable(true) Gypsy.FrameHeader:StartMoving() end)
	Gypsy.FrameHeader:SetScript("OnMouseUp", function() Gypsy.FrameHeader:SetMovable(false) Gypsy.FrameHeader:StopMovingOrSizing() end)
	
	--Gypsy.FrameHeader:Hide()
	
	Gypsy.FrameHeader.Options = CreateFrame("Button", nil, Gypsy.FrameHeader)
	Gypsy.FrameHeader.Options:SetSize(26,26)
	Gypsy.FrameHeader.Options:SetPoint("RIGHT", 12, 12)
	Gypsy.FrameHeader.Options.Texture = Gypsy.FrameHeader.Options:CreateTexture()
	Gypsy.FrameHeader.Options.Texture:SetAllPoints()
	Gypsy.FrameHeader.Options.Texture:SetTexture("Interface\\Addons\\OrzUI\\Media\\Hutu\\close")
	Gypsy.FrameHeader.Options:SetScript("OnClick", function() Gypsy.FrameHeader:Hide() end)  -- Gypsy.Lootframes:Hide()
	
	Gypsy.FrameContainer = CreateFrame("Frame", "GypsyFrameContainer", Gypsy.FrameHeader)
	-- width: 10 + 60 + 10 + 150 + 10 + 150 + 10
	-- height: 10 + 60 + 10
	Gypsy.FrameContainer:SetHeight((30*7)+0)
	Gypsy.FrameContainer:SetWidth((10+60+10+150+10+10)) -- 7 frames
	Gypsy.FrameContainer:SetPoint("BOTTOMLEFT", Gypsy.FrameHeader, 0, -(30*7)) 
	--Gypsy.FrameContainer:SetScale(0.85)
	
	--Gypsy.FrameContainer:SetPoint("CENTER", 0, 0) 	
for i = 1, 7, 1 do -- create 7 frames
		Gypsy.initLootframe(i)
	end
end

function Gypsy.initLootframe(index)
	local lf = CreateFrame("Frame", "GypsyLootframe" .. index, Gypsy.FrameContainer)
	lf.Item = nil
	lf.Looter = nil
	lf.isUsed = false
	
	lf:SetHeight(30)
	lf:SetWidth(10+60+10+150+10+10)
	lf:SetPoint("TOPLEFT", 0, -(((index-1)*30)+0))
	
	lf.Border = lf:CreateTexture()
	lf.Border:SetColorTexture(.2,.2,.2)
	lf.Border:SetAllPoints()
	lf.Border:SetDrawLayer("Background", 1)
	lf.Background = lf:CreateTexture()
	lf.Background:SetColorTexture(0.05,0.05,0.05)
	lf.Background:SetWidth(lf:GetWidth() - 4)
	lf.Background:SetHeight(lf:GetHeight() - 4)
	lf.Background:SetPoint("TOPLEFT", 2, -2)
	lf.Background:SetDrawLayer("Background", 2)
	
	lf.ItemContainer = CreateFrame("FRAME", nil, lf)
	lf.ItemContainer:SetSize(30,30)
	lf.ItemContainer:SetPoint("TOPLEFT", 0, 0)
	lf.ItemContainer.Texture = lf.ItemContainer:CreateTexture()
	lf.ItemContainer.Texture:SetAllPoints()
	
	lf.Button1 = CreateFrame("Button", nil, lf, "UIPanelButtonTemplate")
	lf.Button1:SetWidth(60)
	lf.Button1:SetHeight(30)
	lf.Button1:SetPoint("TOPLEFT", 130+30+30, 0)
	lf.Button1.Text:SetText("求装")
	
	
	lf.Button2 = CreateFrame("Button", nil, lf, "UIPanelButtonTemplate")
	lf.Button2:SetWidth(50)
	lf.Button2:SetHeight(30)
	lf.Button2:SetPoint("TOPLEFT", 130+10+100, 0)
	lf.Button2.Text:SetText(" X ")
	
	lf.Description = lf:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	lf.Description:SetSize(310, 30)
	lf.Description:SetPoint("TOPLEFT", 30+3, 0)
	lf.Description:SetJustifyH("LEFT")
	lf.Description:SetText("This text should be visible")
	
	function lf.ShowItemInfo()
		local itemtable = {GetItemInfo(lf.Item)}
		GameTooltip:SetAnchorType("ANCHOR_CURSOR")
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		--GameTooltip:SetAllPoints()
		GameTooltip:SetHyperlink(itemtable[2])
		GameTooltip:Show()
	end
	
	function lf.HideItemInfo()
		GameTooltip:Hide()
		
	end
	
	function lf.SetItemIcon()
		local itemtable = {GetItemInfo(lf.Item)}
		lf.ItemContainer.Texture:SetTexture(itemtable[10])
	end
	
	function lf.unsetFrame()
		lf.isUsed = false
		lf:Hide()
		local allhidden = true
		for i = 1, #Gypsy.Lootframes do if Gypsy.Lootframes[i]:IsVisible() then allhidden = false end end
		if allhidden then Gypsy.FrameHeader:Hide() end
	end
	
	function lf.getItem()
		--if ShiGuangDB.isRaid == true then
		--	lf.Button1.Text:SetText("Roll")
			-- if raid
			-- roll
		--else
		-- if group/rnd
			local chatString = Gypsy.CreateChatMessage(lf.Item)
			SendChatMessage(chatString, "WHISPER", nil, lf.Looter)
		--end
		
		lf.unsetFrame()
		
	end
	
	function lf.SetButton1()
		--if ShiGuangDB.isRaid == true then
			--lf.Button1.Text:SetText("Roll")
		--else
			lf.Button1.Text:SetText("求装")
		--end
	end
	
	lf.ItemContainer:SetScript("onEnter", lf.ShowItemInfo)
	lf.ItemContainer:SetScript("onLeave", lf.HideItemInfo)
	lf.Button2:SetScript("OnClick", lf.unsetFrame)
	lf.Button1:SetScript("OnClick", lf.getItem)
	lf:Hide()
	tinsert(Gypsy.Lootframes, lf)
end

function Gypsy.CreateChatMessage(item)
	local msg = "你好!这件[神仙装备]，如果你不要,能否惠赠给我呢?非常感谢!!!"
  
	local a, b, c
	a = string.find(msg, "[神仙装备]") -2
	if a ~= nil then 
		b = a + 7
		local lstr = string.sub(msg, 1, a)
		local itemstring = item
		--local itemstring = string.sub(msg, a, b)
		local rstring = string.sub(msg, b)
		local prestring = "[求装]:"
		--if ShiGuangDB.Gypsy_Options_MessagePrefix then prestring = "[求装] " else prestring = "" end
		--if (ShiGuangDB.Gypsy_Options_CustomMessage == "") then
      return prestring .. "你好!这件[神仙装备] " .. itemstring .. " 如果你不要,能否惠赠给我呢?非常感谢!!!"  --"Hey, do you need " .. itemstring .. "?"
    --else
      --local rsnew = string.gsub(ShiGuangDB.Gypsy_Options_CustomMessage, '#item#', item)
      --return prestring .. rsnew
    --end
      
		--return (lstr .. itemstring .. rstring)
	else
		return msg
	end
end

function Gypsy.createLootframe(looter, item)
	local isCreated = false
	for i = 1, #Gypsy.Lootframes, 1 do
		if (isCreated == false and Gypsy.Lootframes[i].isUsed == false) then
			Gypsy.Lootframes[i].isUsed = true
			isCreated = true
			Gypsy.Lootframes[i].SetButton1()
			Gypsy.Lootframes[i].Looter = looter
			Gypsy.Lootframes[i].Item = item
			Gypsy.Lootframes[i].SetItemIcon()
			Gypsy.Lootframes[i].Description:SetText(looter)  -- .. " → " .. Gypsy.getItemSlot(item)
			Gypsy.Lootframes[i]:Show()
		end
	end
	Gypsy.FrameHeader:Show()
end

Gypsy.Gamehook:RegisterEvent("INSPECT_READY")
Gypsy.Gamehook:RegisterEvent("CHAT_MSG_LOOT")
Gypsy.Gamehook:RegisterEvent("ADDON_LOADED")
Gypsy.Gamehook:RegisterEvent("CHAT_MSG_ADDON")

Gypsy.Gamehook:SetScript("onUpdate", Gypsy.managePlayers)
Gypsy.Gamehook:SetScript("onEvent", Gypsy.evt)
Gypsy.initFrameContainer()
Gypsy.FrameHeader:Hide()
Gypsy.MockForLocal = {GetItemInfo(152055)}
Gypsy.localizedGem, Gypsy.localizedRelic =  Gypsy.MockForLocal[6],Gypsy.MockForLocal[7]