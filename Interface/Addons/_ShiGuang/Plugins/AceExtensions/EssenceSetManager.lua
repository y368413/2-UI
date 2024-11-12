--## Author: Metriss - Stormrage  ## Version: 1.07
local esm = ESSENCE_SET_MANAGER_ADDON or LibStub("AceAddon-3.0"):NewAddon("ESSENCE_SET_MANAGER_ADDON", "AceConsole-3.0")
local setButtons = {}
esm.setNames = {}
esm.azeriteUIOpen = false

local MAX_SETS = 8
local Y_OFFSET = -32
local SLOT_MAJOR = 115
local SLOT_MINOR1 = 116
local SLOT_MINOR2 = 117
local SLOT_MINOR3 = 119
local CHANGE_SPELL_IDS = {227041, 256231, 226241, 256229}

esm.specProfiles = {}
esm.ae = C_AzeriteEssence

esm.eventHandlerFrame = CreateFrame("Frame")
esm.eventHandlerFrame:RegisterEvent("ADDON_LOADED")
esm.eventHandlerFrame:RegisterEvent("AZERITE_ESSENCE_UPDATE")
esm.eventHandlerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
esm.eventHandlerFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
esm.eventHandlerFrame:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" then
		if arg1 == "_ShiGuang" then
			if ShiGuangPerDB.EssenceSetManager == nil then ShiGuangPerDB.EssenceSetManager = {} end
			esm.specProfiles = ShiGuangPerDB.EssenceSetManager
			esm.createFonts()
		elseif arg1 == "Blizzard_AzeriteEssenceUI" then
			esm.createSaveFrames()
			_G.AzeriteEssenceUI:HookScript("OnShow", function() esm.azeriteUIShow() end)
			_G.AzeriteEssenceUI:HookScript("OnHide", function() esm.azeriteUIHide() end)
		end
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
		esm.currentSpec = esm.getSpecName()
		esm.createSpecSet(esm.currentSpec)
		esm.updateSetNames()
		--esm.updateLDBButton()
		if event == "PLAYER_SPECIALIZATION_CHANGED" then
			esm.updateSetButtons()
			--esm.updateLDBSetButtons()
			--esm.updateLDBButton()
			esm.setInputText("")
		end
	elseif event == "AZERITE_ESSENCE_UPDATE" then
		--esm.updateLDBButton()
		esm.updateSetButtons()
		--esm.updateLDBSetButtons()
		esm.updateInfoTooltip()
	elseif event == "PLAYER_UPDATE_RESTING" or (event == "UNIT_AURA" and arg1 == "player") then
		esm.updateBtnSaturation()
	end
end)


esm.setInputText = function(text)
	if esm.input then
		esm.input:SetText(text)
	end
end

esm.azeriteUIShow = function()
	esm.azeriteUIOpen = true
	esm.currentSpec = esm.getSpecName()
	esm.checkEvents()
	esm.updateSetButtons()
end

esm.azeriteUIHide = function()
	esm.azeriteUIOpen = false
	esm.setInputText("")
	esm.checkEvents()
end

esm.checkEvents = function()
	if esm.azeriteUIOpen then  -- or esm.LDBOpen
		esm.eventHandlerFrame:RegisterEvent("PLAYER_UPDATE_RESTING")
		esm.eventHandlerFrame:RegisterEvent("UNIT_AURA")
	else
		esm.eventHandlerFrame:UnregisterEvent("PLAYER_UPDATE_RESTING")
		esm.eventHandlerFrame:UnregisterEvent("UNIT_AURA")
	end

end

esm.getSpecName = function()
	local currentSpec = GetSpecialization()
	local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"
	return currentSpecName
end

esm.updateBtnSaturation = function()
	esm.saturation = esm.checkIfCanChange()
	for i=0, #(esm.setNames) do
		if setButtons[i] then
			setButtons[i].tex:SetDesaturated(esm.saturation)
		end
		--if esm.LDBSetButtons[i] then
			--esm.LDBSetButtons[i].tex:SetDesaturated(esm.saturation)
		--end
	end
	esm.updateTomeButton()
end

esm.getTomeInfo = function()
	local tranquilCount = GetItemCount("item:"..141446)
	local quietCount =  GetItemCount("item:"..153647)
	local totalCount = tranquilCount + quietCount
	local itemID
	if tranquilCount > 0 then
		itemID = 141446
	else
		itemID = 153647
	end
	return totalCount, itemID
end

esm.updateTomeButton = function()
	if esm.itemBtn then
		local tomeCount, itemID = esm.getTomeInfo()
		esm.itemBtn:SetText(tomeCount)
		if InCombatLockdown() then return end
		esm.itemBtn:SetAttribute("item", "item:"..itemID);
		if esm.saturation == 1 and tomeCount > 0 then
			esm.itemBtn:Enable()
		else
			esm.itemBtn:Disable()
		end
	end
end

esm.createSpecSet = function(spec)
	if esm.specProfiles[spec] == nil then
		esm.specProfiles[spec] = {}
	end
end

esm.updateSetNames = function()
	esm.setNames = {}
	for k,v in pairs(esm.specProfiles[esm.currentSpec]) do
		table.insert(esm.setNames, k)
	end
end

esm.pairsByKeys = function(t)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a,  function(a,b) return b>a end)
    local i = 0 
    local iter = function () 
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
     end
     return iter
end


esm.updateSetButtons = function()
	if _G.AzeriteEssenceUI then
		esm.saturation = esm.checkIfCanChange()
		esm.createSetFromEquipped()
		esm.getUnlockedCount()
		local i = 0
		for name, line in esm.pairsByKeys(esm.specProfiles[esm.currentSpec]) do
			if i < 20 then
				esm.createSetButton(name, i)
				i = i + 1
			else
				break;
			end
		end
		if (#(setButtons)+1) > i then --hide unused buttons if you delete some
			for ii=i, #(setButtons)+1 do
				if setButtons[ii] then
					setButtons[ii]:Hide()
				end
			end
		end
		esm.updateBtnSaturation()
	end
end

esm.createFonts = function()
	esm.fontWhite = CreateFont("noMatch")
	esm.fontWhite:CopyFontObject("GameFontNormal");
	esm.fontWhite:SetTextColor(1, 1, 1, 1.0);
	esm.fontWhite:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
	
	esm.fontTome = CreateFont("Tome")
	esm.fontTome:CopyFontObject("GameFontNormal");
	esm.fontTome:SetTextColor(1, 1, 1, 1.0);
	esm.fontTome:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
	
	esm.fontGreen = CreateFont("Match")
	esm.fontGreen:CopyFontObject("GameFontNormal");
	esm.fontGreen:SetTextColor(0, 1, 0, 1.0);
	esm.fontGreen:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
	
	esm.fontRed = CreateFont("Missing")
	esm.fontRed:CopyFontObject("GameFontNormal");
	esm.fontRed:SetTextColor(1, 0, 0, 1.0);
	esm.fontRed:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")

end

esm.createSaveFrames = function()
	esm.input = CreateFrame("EditBox", "", AzeriteEssenceUI, "InputBoxTemplate");
	esm.input:SetPoint("BOTTOMLEFT", AzeriteEssenceUI, "BOTTOM" , -33, 8)
	esm.input:SetFrameStrata("DIALOG")
	esm.input:SetSize(80,30)
	esm.input:SetMultiLine(false)
  esm.input:SetAutoFocus(false)
	esm.input:SetMaxLetters(10)
	esm.input:SetScript("OnTextChanged", function() esm.inputTextChanged() end)

	esm.save = CreateFrame("Button", "", esm.input, "UIPanelButtonTemplate")
	esm.save:SetPoint("RIGHT", esm.input, "RIGHT" , 85, 0)
	esm.save:SetWidth(80)
	esm.save:SetHeight(25)
	esm.save:SetNormalFontObject("GameFontNormal")
	esm.save:SetScript("OnClick", function() esm.saveButtonPress(esm.save) end)
	esm.save:SetText(COMMUNITIES_CREATE)
	esm.save:Disable()
	
	esm.itemBtn = CreateFrame("Button", nil, esm.save, "InsecureActionButtonTemplate, UIPanelButtonTemplate");
	esm.itemBtn:SetPoint("BOTTOMRIGHT", esm.save, "TOPRIGHT" , 0, 0)
	esm.itemBtn:SetNormalFontObject("GameFontNormal")
	--esm.itemBtn:SetSize(50, 50)
	esm.itemBtn:SetWidth(26)
	esm.itemBtn:SetHeight(26)
	esm.itemBtn:SetText("Use Tome ("..GetItemCount("Tome of the Tranquil Mind")..")" )
	esm.itemBtn:SetAttribute("type", "item");
	--esm.itemBtn:SetNormalTexture("interface\\addons\\nickalert\\green-panel-button-up.tga")

end


esm.isSetEquipped = function(set)
	local equipped = true
	if set.major.ID ~= esm.equippedMajorID then
		equipped = false
	else
		for k,v in pairs(set.minors) do
			if v.ID then
				if not tContains(esm.equippedMinorIDs, v.ID) then
					equipped = false
				end
			end
		end
	end
	return equipped
end

esm.getFont = function(set)
	local useFont
	if esm.isMissingEssence(set) then
		useFont = esm.fontRed
	else
		if esm.isSetEquipped(set) then
			useFont = esm.fontGreen
		else
			useFont = esm.fontWhite
		end
	end
	return useFont
end

esm.createSetButton = function(text, i)
	local set = esm.specProfiles[esm.currentSpec][text]
	if not setButtons[i] then
		setButtons[i] = CreateFrame("Button", "", AzeriteEssenceUI, "UIPanelButtonTemplate")
		setButtons[i]:SetPoint("TOPRIGHT", AzeriteEssenceUI, "TOP" , 126, Y_OFFSET + -43 * i)
		setButtons[i]:SetWidth(43)
		setButtons[i]:SetHeight(43)
		setButtons[i]:SetScript("OnClick", function() esm.setButtonPress(setButtons[i]) end)
		setButtons[i]:SetScript("OnEnter", function() esm.showInfoTooltip(setButtons[i]) end)
		setButtons[i]:SetScript("OnLeave", function() esm.hideInfoTooltip(setButtons[i]) end)
		setButtons[i].tex = setButtons[i]:CreateTexture()
		setButtons[i].tex:SetAllPoints()
		--setButtons[i]:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, edgeFile = [[Interface\ButtoPLTrader:NS\WHITE8X8]], edgeSize = 47})
		--setButtons[i]:SetBackdropBorderColor (0, 0, 0, 1)
	end
	local useFont = esm.getFont(set)
	if set.major.ID then
		setButtons[i].tex:SetTexture(esm.ae.GetEssenceInfo(set.major.ID).icon)
		setButtons[i].tex:SetDesaturated(esm.saturation)
		setButtons[i].tex:SetTexCoord(.08, .92, .08, .92)
	end
	setButtons[i]:SetNormalFontObject(useFont)
	setButtons[i]:SetHighlightFontObject(useFont)
	setButtons[i]:Show()
	setButtons[i].setName = text
	setButtons[i]:SetText(esm.getSplitText(text))
end

esm.getSplitText = function(text)
	part1, part2 = strsplit(" ", text, 2)
	if part1 and part2 then
		return part1 .. "\n" .. part2
	else
		return text
	end
end

esm.getUnlockedCount = function()
	esm.unlocked = 0
	local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
    local level = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)

	if level >= 75 then
		esm.unlocked = 4
	elseif level >= 65 then
		esm.unlocked = 3
	elseif level >= 55 then
		esm.unlocked = 2
	elseif level >= 35 then
		esm.unlocked = 1
	end
end

esm.isMissingEssence = function(set, unlocked)	
	local saveCount = 0
	if set.major.ID then
		saveCount = 1
	end
	
	saveCount = saveCount + #(set.minors)

	for k, v in pairs(set.minors) do
		if v.ID then
			saveCount = saveCount + 1
		end
	end
	
	if saveCount < esm.unlocked then
		return true
	end
	
end

esm.addTooltipLine = function(type, essence)
	local r, g, b
	local match = false
	local emptyText = "|cffff0009<EMPTY>|r"
	local text = essence.name or emptyText
	if type == "major" then
		if esm.equippedMajorID == essence.ID then
			match = true
		end
	else
		text = "|cffffc500>|r"..text
		if tContains(esm.equippedMinorIDs, essence.ID) then
			match = true
		end
	end
	if match then
		r, g, b = 0, 1, 0
	else
		r, g, b = 1, 1, 1
	end
	GameTooltip:AddLine(text, r, g, b)

end

esm.showInfoTooltip = function(button)
	esm.currentButton = button
	--if not esm.LDBOpen then
		GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	--[[else
		local x, y = esm.LDBButton:GetCenter()
		if y > GetScreenWidth()/2 then
			if x < GetScreenWidth()/2 then
				GameTooltip:SetOwner(esm.LDBButton.background, "ANCHOR_RIGHT")
			else
				GameTooltip:SetOwner(esm.LDBButton.background, "ANCHOR_LEFT")
			end
		else
			if x < GetScreenWidth()/2 then
				GameTooltip:SetOwner(esm.LDBButton.background, "ANCHOR_TOPRIGHT")
			else
				GameTooltip:SetOwner(esm.LDBButton.background, "ANCHOR_TOPLEFT")
			end
		
		end
	end]]
	local major = esm.specProfiles[esm.currentSpec][button.setName].major
	local minors = esm.specProfiles[esm.currentSpec][button.setName].minors
	local mOneName, mTwoName, mThreeName
	
	esm.addTooltipLine("major", major)
	if esm.unlocked >= 2 then
		esm.addTooltipLine("minor", minors.one)
	end
	if esm.unlocked >= 3 then
		esm.addTooltipLine("minor", minors.two)
	end
	if esm.unlocked >= 4 then
		esm.addTooltipLine("minor", minors.three)
	end
	
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("|cffeda55fShift-Click |r to |cfff98f00 Update/Overwrite |r")
	GameTooltip:AddLine("|cffeda55fShift-CTRL-Click |r to |cffff0009 Delete |r")
	GameTooltip:Show()
end


esm.hideInfoTooltip = function(button)
	GameTooltip:Hide()
	esm.currentButton = nil
end

esm.updateInfoTooltip = function()
	if esm.currentButton then
		esm.showInfoTooltip(esm.currentButton)
	end
end

esm.saveButtonPress = function()
	if esm.input:GetText() ~= "" then
		esm.saveSet(esm.input:GetText())
		esm.setInputText("")
	end
end

esm.setButtonPress = function(button)
	if IsShiftKeyDown() then
		if IsControlKeyDown() then
			esm.deleteSet(button.setName)
			esm.updateSetButtons()
			--esm.updateLDBSetButtons()
		else
			esm.saveSet(button.setName)
		end
	else
		if InCombatLockdown() then return end
		esm.activateSet(button.setName)
	end
end

esm.inputTextChanged = function()
	if esm.input:GetText() == "" then
		esm.save:Disable()
	else
		esm.save:Enable()
	end
	if not tContains(esm.setNames, esm.input:GetText()) then
		esm.save:SetText(COMMUNITIES_CREATE)
	else
		esm.save:SetText(UPDATE)
	end
end

esm.printHelp = function()
   print("|cff60d4d4Essence Set Manager|r commands: ")
   esm.printHelpActivate()
end

esm.printHelpActivate = function()
   print("|cff60d4d4/esm|r |cffffff33activate|r |cfffcffb0<name>|r - Activate the Azerite Essence set saved as <name>. Use this if you wish to activate from a macro.")
end

esm.activateSet = function(name)
	local set = esm.specProfiles[esm.currentSpec][name]
	
	if set.major.ID then
		esm.ae.ActivateEssence(set.major.ID, SLOT_MAJOR)
	end
	if set.minors.one.ID then
		esm.ae.ActivateEssence(set.minors.one.ID, SLOT_MINOR1)
	end
	if set.minors.two.ID then
		esm.ae.ActivateEssence(set.minors.two.ID, SLOT_MINOR2)
	end
	if set.minors.three.ID then
		esm.ae.ActivateEssence(set.minors.three.ID, SLOT_MINOR3)
	end
end

esm.checkIfCanChange = function()
	if IsResting() then
		return nil
	end
	for i = 1, 40 do
		local _, _, _, _, _, _, _, _, _, spellID = UnitAura("player", i, "HELPFUL")
		if spellID then
			if tContains(CHANGE_SPELL_IDS, spellID) then
				return nil
			end
		end
	end
	return 1
end

esm.getEssenceNameByID = function(ID)
	return esm.ae.GetEssenceInfo(ID).name
end

esm.createEssenceTableBySlot = function(slot)
	local ID = esm.ae.GetMilestoneEssence(slot)
	local name
	if ID then
		name = esm.getEssenceNameByID(ID)
	end
	return {ID = ID, name = name}
end

esm.createEquipIDVariables = function(major, minors)
	esm.equippedMajorID = major.ID
	esm.equippedMinorIDs = {minors.one.ID or -1, minors.two.ID or -1, minors.three.ID or -1}
end

esm.createSetFromEquipped = function()
	local major = esm.createEssenceTableBySlot(SLOT_MAJOR)
	local one = esm.createEssenceTableBySlot(SLOT_MINOR1)
	local two = esm.createEssenceTableBySlot(SLOT_MINOR2)
	local three = esm.createEssenceTableBySlot(SLOT_MINOR3)
	local minors = {one = one, two = two, three = three}
	esm.createEquipIDVariables(major, minors)
	if major.ID then
		return {major = major or nil, minors = minors}
	else
		return nil
	end

end

esm.saveSet = function(name)
	local set = esm.createSetFromEquipped()
	if set then
		esm.specProfiles[esm.currentSpec][name] = set
		esm.updateSetButtons()
		--esm.updateLDBSetButtons()
		esm.updateSetNames()
		--esm.updateLDBButton()
		esm.updateInfoTooltip()
	else
		esm.errorPrint("You can not save a set without a major essence!")
	end
end

esm.errorPrint = function(text)
	print("|cff60d4d4ESM|r |cffff0009<ERROR>|r "..text)
end

esm.deleteSet = function(name)
	esm.specProfiles[esm.currentSpec][name] = nil
	esm.updateSetNames()
	if esm.input and name == esm.input:GetText() then
		esm.save:SetText(COMMUNITIES_CREATE)
	end
end

esm:RegisterChatCommand("esm", function(msg, editbox)
	local words = {}
	for word in msg:gmatch("[^ ]+") do 
		table.insert(words, word)
	end
	if words[1] == "activate" then
		table.remove(words, 1)
		local name = table.concat(words, " ")
		if name == "" then 
			esm.printHelpActivate()
		else
			if esm.specProfiles[esm.currentSpec][name] then
				esm.activateSet(name)
			else
				esm.errorPrint("There is no set saved with this name for this spec. Capitalization must be the same.")
			end
		end
	--elseif words[1] == "debugreset" then
		--EssenceSetManager = {}
		--print("Congrats you just RESET all of your profiles. I hope you didn't type this by accident.")
	else
		esm.printHelp()
	end
      
end)

