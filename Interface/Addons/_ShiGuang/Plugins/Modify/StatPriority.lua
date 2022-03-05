--## Author: Vampyr78
--## Version: 1.9
--## SavedVariablesPerCharacter: statPriorityStoredStats

if statPriorityStoredStats == nil then
	statPriorityStoredStats = {}
end

local statPriorityStats = {}
local statPriorityTexts = {}
local statPriorityBoxes = {}

statPriorityStats["WARRIORArms"] = "Strength > Critical Strike > Mastery > Versatility > Haste"
statPriorityStats["WARRIORFury"] = "Strength > Haste > Mastery > Critical Strike > Versatility"
statPriorityStats["WARRIORProtection"] = "Strength > Haste > Versatility > Mastery > Critical Strike"

statPriorityStats["PALADINHoly"] = "Intellect > Haste > Mastery > Versatility > Critical Strike"
statPriorityStats["PALADINProtection"] = "Haste > Mastery > Versatility > Critical Strike"
statPriorityStats["PALADINRetribution"] = "Strength > Mastery = Versatility = Critical Strike = Haste"

statPriorityStats["HUNTERBeast Mastery"] = "Critical Strike > Haste > Versatility > Mastery"
statPriorityStats["HUNTERMarksmanship"] = "Mastery > Critical Strike > Versatility > Haste"
statPriorityStats["HUNTERSurvival"] = "Haste > Versatility = Critical Strike > Mastery"

statPriorityStats["ROGUEAssassination"] = "Critical Strike > Haste > Versatility > Mastery"
statPriorityStats["ROGUEOutlaw"] = "Versatility > Critical Strike > Haste > Mastery"
statPriorityStats["ROGUESubtlety"] = "Critical Strike > Versatility > Mastery > Haste"

statPriorityStats["PRIESTDiscipline"] = "Intellect > Haste > Critical Strike > Versatility > Mastery"
statPriorityStats["PRIESTHoly"] = "Intellect > Critical Strike > Haste > Versatility > Mastery"
statPriorityStats["PRIESTShadow"] = "Intellect > Haste = Mastery > Critical Strike > Versatility"

statPriorityStats["SHAMANElemental"] = "Intellect > Versatility > Critical Strike > Haste > Mastery"
statPriorityStats["SHAMANEnhancement"] = "Agility > Haste > Critical Strike = Versatility > Mastery"
statPriorityStats["SHAMANRestoration"] = "Intellect > Versatility = Critical Strike > Haste = Mastery"

statPriorityStats["MAGEArcane"] = "Intellect > Critical Strike > Mastery > Versatility > Haste"
statPriorityStats["MAGEFire"] = "Intellect > Haste > Versatility > Mastery > Critical Strike"
statPriorityStats["MAGEFrost"] = "Intellect > Critical Strike to 33.34% > Haste > Versatility > Mastery"

statPriorityStats["WARLOCKAffliction"] = "Intellect > Mastery > Haste > Critical Strike > Versatility"
statPriorityStats["WARLOCKDemonology"] = "Intellect > Haste > Mastery > Critical Strike = Versatility"
statPriorityStats["WARLOCKDestruction"] = "Intellect > Haste > Mastery > Critical Strike > Versatility"

statPriorityStats["DRUIDBalance"] = "Intellect > Mastery > Haste > Versatility > Critical Strike"
statPriorityStats["DRUIDFeral"] = "Agility > Critical Strike > Mastery > Versatility > Haste"
statPriorityStats["DRUIDGuardian"] = "Armor = Agility = Stamina > Versatility > Mastery > Haste > Critical Strike"
statPriorityStats["DRUIDRestoration"] = "Intellect > Haste > Mastery = Critical Strike = Versatility"

statPriorityStats["MONKBrewmaster"] = "Versatility = Mastery = Critical Strike > Haste"
statPriorityStats["MONKMistweaver"] = "Intellect > Critical Strike > Versatility > Haste > Mastery"
statPriorityStats["MONKFistweaver"] = "Intellect > Critical Strike > Versatility > Haste > Mastery"
statPriorityStats["MONKWindwalker"] = "Agility > Versatility > Mastery > Critical Strike > Haste"

statPriorityStats["DEATHKNIGHTBlood"] = "Strength > Versatility > Haste > Critical Strike > Mastery"
statPriorityStats["DEATHKNIGHTFrost"] = "Mastery > Critical Strike > Haste > Versatility"
statPriorityStats["DEATHKNIGHTUnholy"] = "Mastery > Haste > Critical Strike > Versatility"

statPriorityStats["DEMONHUNTERHavoc"] = "Agility > Haste = Versatility > Critical Strike > Mastery"
statPriorityStats["DEMONHUNTERVengeance"] = "Agility > Haste > Versatility > Critical Strike > Mastery"

function statPriorityFrameOnEvent(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "StatPriority" then
		self:UnregisterEvent("ADDON_LOADED")
		PaperDollFrame:HookScript("OnShow", function() statPriorityFrameUpdate(self, statPriorityText, PaperDollFrame, "player") end)
	elseif event == "SPELLS_CHANGED" and IsAddOnLoaded("StatPriority") then
		statPriorityFrameUpdate(self, statPriorityText, PaperDollFrame, "player")
	--elseif event == "INSPECT_READY" and IsAddOnLoaded("StatPriority") then
	--	statPriorityFrameUpdate(statPriorityInspectFrame, statPriorityInspectText, InspectPaperDollFrame, "target")
	end
end

function statPriorityFrameCreate(frame, text, parent)
	if parent:IsVisible() then
		frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
						   edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
						   tile = true,
						   tileSize = 16,
						   edgeSize = 16, 
						   insets = {left = 1,
									 right = 1,
									 top = 1,
									 bottom = 1}}) 
		frame:SetBackdropColor(0, 0, 0, 1)
		frame:SetFrameStrata("TOOLTIP")
		frame:SetWidth(parent:GetWidth() - 50)
		if parent == PaperDollFrame then
			frame:SetHeight(25)
		else
			frame:SetHeight(50)
		end
		text:ClearAllPoints()
		text:SetAllPoints(frame) 
		text:SetJustifyH("CENTER")
		text:SetJustifyV("CENTER")
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT",0,0)
		frame:SetParent(parent)
		frame:Show()
		return true
	end
	return false
end

function GetSpecializationName(id)
	local spec = ""
	if id == 62 then 
		spec = "Arcane"
	elseif id == 63 then 
		spec = "Fire"
	elseif id == 64 then 
		spec = "Frost"
	elseif id == 65 then 
		spec = "Holy"
	elseif id == 66 then 
		spec = "Protection"
	elseif id == 70 then 
		spec = "Retribution"
	elseif id == 71 then 
		spec = "Arms"
	elseif id == 72 then 
		spec = "Fury"
	elseif id == 73 then 
		spec = "Protection"
	elseif id == 102 then 
		spec = "Balance"
	elseif id == 103 then 
		spec = "Feral"
	elseif id == 104 then 
		spec = "Guardian"
	elseif id == 105 then 
		spec = "Restoration"
	elseif id == 250 then 
		spec = "Blood"
	elseif id == 251 then 
		spec = "Frost"
	elseif id == 252 then 
		spec = "Unholy"
	elseif id == 253 then 
		spec = "Beast Mastery"
	elseif id == 254 then 
		spec = "Marksmanship"
	elseif id == 255 then 
		spec = "Survival"
	elseif id == 256 then 
		spec = "Discipline"
	elseif id == 257 then 
		spec = "Holy"
	elseif id == 258 then 
		spec = "Shadow"
	elseif id == 259 then 
		spec = "Assassination"
	elseif id == 260 then 
		spec = "Outlaw"
	elseif id == 261 then 
		spec = "Subtlety"
	elseif id == 262 then 
		spec = "Elemental"
	elseif id == 263 then 
		spec = "Enhancement"
	elseif id == 264 then 
		spec = "Restoration"
	elseif id == 265 then 
		spec = "Affliction"
	elseif id == 266 then 
		spec = "Demonology"
	elseif id == 267 then 
		spec = "Destruction"
	elseif id == 268 then 
		spec = "Brewmaster"
	elseif id == 269 then 
		spec = "Windwalker"
	elseif id == 270 then 
		spec = "Mistweaver"
	elseif id == 577 then 
		spec = "Havoc"
	elseif id == 581 then 
		spec = "Vengeance"
	end
	return spec
end

function statPriorityFrameUpdate(frame, frameText, parent, unit)
	if parent ~= nil and statPriorityFrameCreate(frame, frameText, parent) then
		local temp, class = UnitClass(unit)
		local spec
		local text
		if parent == PaperDollFrame then
			spec = GetSpecializationInfo(GetSpecialization())
			spec = GetSpecializationName(spec)
			text = statPriorityStats[class .. spec];
			if class == "MONK" then
				if IsSpellKnown(210802) then
					text = statPriorityStats[class .. "Fistweaver"]
				end
			end
			if statPriorityStoredStats[class..spec] == nil then
				text = statPriorityStats[class..spec]
			else
				text = statPriorityStoredStats[class..spec]
			end
		else
			spec = GetSpecializationName(GetInspectSpecialization(unit))
			text = statPriorityStats[class .. spec];
			if statPriorityStats[class..spec] ~= nil and class == UnitClass("player") then
				text = statPriorityStats[class..spec]
			end
		end
		frameText:SetText(text)
	end
end

function statPrioritySpecBox(parent, x, y)
	local text = parent:CreateFontString(nil, "OVERLAY", "GameFontWhite")
	text:SetPoint("TOPLEFT", x, y)
	table.insert(statPriorityTexts, text)
	local box = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
	box:SetAutoFocus(false)
	box:SetHeight(25)
	box:SetWidth(400)
	box:SetPoint("TOPLEFT", x, y - 15)
	table.insert(statPriorityBoxes, box)
end

function statPriorityGetSpecs()
	local temp, class = UnitClass("player")
	if class == "WARRIOR" then
		return {"Arms", "Fury", "Protection"}
	elseif class == "PALADIN" then
		 return {"Holy", "Protection", "Retribution"}
	elseif class == "HUNTER" then
		 return {"Beast Mastery", "Marksmanship", "Survival"}
	elseif class == "ROGUE" then
		 return {"Assassination", "Outlaw", "Subtlety"}
	elseif class == "PRIEST" then
		 return {"Discipline", "Holy", "Shadow"}
	elseif class == "SHAMAN" then
		 return {"Elemental", "Enhancement", "Restoration"}
	elseif class == "MAGE" then
		 return {"Arcane", "Fire", "Frost"}
	elseif class == "WARLOCK" then
		 return {"Affliction", "Demonology", "Destruction"}
	elseif class == "DRUID" then
		 return {"Balance", "Feral", "Guardian", "Restoration"}
	elseif class == "MONK" then
		 return {"Brewmaster", "Mistweaver", "Windwalker"}
	elseif class == "DEATHKNIGHT" then
		 return {"Blood", "Frost", "Unholy"}
	elseif class == "DEMONHUNTER" then
		 return {"Havoc", "Vengeance"}
	end
end

function statPriorityOptionsRefresh()
	local temp, name = UnitClass("player")
	local specs = statPriorityGetSpecs()
	for i = 1, table.getn(statPriorityTexts) do
		if specs[i] ~= nil then
			statPriorityTexts[i]:Show()
			statPriorityTexts[i]:SetText(specs[i])
			statPriorityBoxes[i]:Show()
			if statPriorityStoredStats[name..specs[i]] == nil then
				statPriorityBoxes[i]:SetText("")
			else
				statPriorityBoxes[i]:SetText(statPriorityStoredStats[name..specs[i]])
			end
			statPriorityBoxes[i]:SetCursorPosition(0)
		else
			statPriorityTexts[i]:Hide()
			statPriorityBoxes[i]:Hide()
		end
	end
end

function statPriorityOptionsOkay()
	local temp, name = UnitClass("player")
	local specs = statPriorityGetSpecs()
	for i = 1, table.getn(specs) do
		local text = statPriorityBoxes[i]:GetText()
		if text == "" then
			statPriorityStoredStats[name..specs[i]] = nil
		else
			statPriorityStoredStats[name..specs[i]] = text
		end
	end
end

local statPriorityFrame = CreateFrame("FRAME", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
statPriorityInspectFrame = CreateFrame("FRAME", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
statPriorityText = statPriorityFrame:CreateFontString(nil, "OVERLAY", "GameFontWhite")
statPriorityInspectText = statPriorityInspectFrame:CreateFontString(nil, "OVERLAY", "GameFontWhite")
statPriorityFrame:RegisterEvent("ADDON_LOADED")
statPriorityFrame:RegisterEvent("SPELLS_CHANGED")
statPriorityFrame:RegisterEvent("INSPECT_READY");
statPriorityFrame:SetScript("OnEvent", statPriorityFrameOnEvent)

local statPriorityOptions = CreateFrame("FRAME")
statPriorityOptions.name = "Stat Priority"
local statPriorityOptionsText = statPriorityOptions:CreateFontString(nil, "OVERLAY", "GameFontWhite")
statPriorityOptionsText:SetPoint("TOPLEFT", 20, -20)
statPriorityOptionsText:SetText("You can put your own custom priority strings here")
statPrioritySpecBox(statPriorityOptions, 20, -40)
statPrioritySpecBox(statPriorityOptions, 20, -85)
statPrioritySpecBox(statPriorityOptions, 20, -130)
statPrioritySpecBox(statPriorityOptions, 20, -175)
statPriorityOptions.refresh = statPriorityOptionsRefresh
statPriorityOptions.okay = statPriorityOptionsOkay
statPriorityOptions.cancel = statPriorityOptionsRefresh
InterfaceOptions_AddCategory(statPriorityOptions)