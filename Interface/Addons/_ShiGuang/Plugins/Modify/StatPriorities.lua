--"Release Version Jan 2021 for Patch 9.0.2" by Wyr3d

local Wyr3d_StatTable = {}
Wyr3d_StatTable["DEATHKNIGHT-250"] = "Str > ilvl > Vers > Haste > Crit > Mast"
Wyr3d_StatTable["DEATHKNIGHT-251"] = "Str > Mast > Crit > Vers > Haste"
Wyr3d_StatTable["DEATHKNIGHT-252"] = "Str > Mast > Haste > Crit = Vers"

Wyr3d_StatTable["DRUID-102"] = "Normal: Int > Mast > Haste > Vers > Crit \n Night Fae: Int > Mast > Vers > Haste > Crit"
Wyr3d_StatTable["DRUID-103"] = "Agil > Crit > Mast > Vers > Haste"
Wyr3d_StatTable["DRUID-104"] = "Survival: ilvl > Armor = Agil = Stam > Vers > Mast > Haste > Crit \n Damage: Agil > Vers >= Haste >= Crit > Mast"
Wyr3d_StatTable["DRUID-105"] = "Raid: Int > Haste > Mast = Crit = Vers > Int \n Dungeon: Int > Mast = Haste > Vers > Crit"

Wyr3d_StatTable["HUNTER-253"] = "Agil > Haste > Crit > Vers > Mast"
Wyr3d_StatTable["HUNTER-254"] = "Agil > Crit > Mast > Vers > Haste"
Wyr3d_StatTable["HUNTER-255"] = "Agil > Haste > Vers = Crit > Mast"

Wyr3d_StatTable["MAGE-62"] = "Int > Crit > Mast > Vers > Haste"
Wyr3d_StatTable["MAGE-63"] = "Solo: Int > Haste > Mast > Vers > Crit \n Multi: Int > Mast > Haste > Vers > Crit"
Wyr3d_StatTable["MAGE-64"] = "Int > Crit 33% > Haste > Vers > Mast > Crit 33%+"

Wyr3d_StatTable["MONK-268"] = "Defense: Vers = Mast = Crit > Haste > Agil \n Offense: Vers = Crit > Haste > Mast > Agil"
Wyr3d_StatTable["MONK-269"] = "Weapon Dam > Agi > Vers > Mast > Crit > Haste"
Wyr3d_StatTable["MONK-270"] = "Mist: Int > Crit > Vers > Haste > Mast \n Fist: Int > Crit > Vers > Haste > Mast \n Dungeon: Int => Crit > Mast =  Vers >= Haste"

Wyr3d_StatTable["PALADIN-65"] = "Spread Group: (Leech) > Int > Crit > Haste > Mast > Vers \n Close Group: (Leech) > Int > Mast > Crit > Haste > Vers \n Glimmer: Int > Haste > Mast > Vers > Crit \n Dungeon: (Leech) > Int > Crit > Haste > Vers > Mast"
Wyr3d_StatTable["PALADIN-66"] = "Haste > Mast > Vers > Crit > Str = Stam"
Wyr3d_StatTable["PALADIN-70"] = "Str > Haste = Vers = Mast = Crit"

Wyr3d_StatTable["PRIEST-256"] = "Int > Haste > Crit > Vers > Mast"
Wyr3d_StatTable["PRIEST-257"] = "Raid: (Leech = Avoid) > Int > Mast = Crit > Vers > Haste \n Dungeon: (Leech = Avoid) Int > Crit > Haste > Vers > Mast"
Wyr3d_StatTable["PRIEST-258"] = "Int > Haste = Mast > Crit > Vers"

Wyr3d_StatTable["ROGUE-259"] = "Raid: Agil > Haste > Crit > Vers > Mast \n Dungeon: Agil > Crit > Vers > Mast > Haste"
Wyr3d_StatTable["ROGUE-260"] = "Agi > Vers > Haste > Crit > Mast"
Wyr3d_StatTable["ROGUE-261"] = "Solo: Agil > Vers > Crit > Haste > Mast \n Multi: Agi > Crit > Vers > Mast > Haste"

Wyr3d_StatTable["SHAMAN-262"] = "Int > Vers > Haste > Crit > Mast"
Wyr3d_StatTable["SHAMAN-263"] = "Agil > Haste > Crit = Vers > Mast"
Wyr3d_StatTable["SHAMAN-264"] = "Heal: Int > ilvl > Vers = Crit > Haste = Mast > (Leech = Avoid > Speed) \n Damage: Int > ilvl > Vers = Haste > Crit > Mast" 

Wyr3d_StatTable["WARLOCK-265"] = "Int > Mast > Haste > Crit > Vers"
Wyr3d_StatTable["WARLOCK-266"] = "Solo: Int > Haste > Mast > Crit = Vers \n Multi: Int > Mast > Haste > Crit = Vers"
Wyr3d_StatTable["WARLOCK-267"] = "Int > Haste >= Mastery > Crit > Vers"

Wyr3d_StatTable["WARRIOR-71"] = "Str > Haste 20% > Crit > Mast > Vers > Haste"
Wyr3d_StatTable["WARRIOR-72"] = "Str > Haste > Mast > Crit > Vers"
Wyr3d_StatTable["WARRIOR-73"] = "Standard: Haste > Vers > Mast > Crit > Str > Armor \n Dungeon: Haste > Vers >= Crit > Mast > Str > Armor"

Wyr3d_StatTable["DEMONHUNTER-577"] = "Agil > Haste = Vers > Crit > Mast"
Wyr3d_StatTable["DEMONHUNTER-581"] = "Agi > Haste >= Vers > Crit > Mast"

local Wyr3d_STATS = CreateFrame("Frame",Wyr3d_STATS,UIParent, BackdropTemplateMixin and "BackdropTemplate")

function Wyr3d_STATS:CreateWin()
    if PaperDollFrame:IsVisible() then
        if not Wyr3d_STATSwin then
            Wyr3d_STATSwin = CreateFrame("Frame",Wyr3d_STATSwin,Wyr3d_STATS)
            --Wyr3d_STATS:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 1, right = 1, top = 1, bottom = 1 }}) 
            --Wyr3d_STATS:SetBackdropColor(0,0,0,1)
            Wyr3d_STATS:SetFrameStrata("TOOLTIP")
            Wyr3d_STATS:SetWidth(PaperDollFrame:GetWidth()-50) 
            Wyr3d_STATS:SetHeight(21)
    	    Wyr3d_STATStxt = Wyr3d_STATS:CreateFontString(nil,"OVERLAY","GameFontWhite")
			local ft = Wyr3d_STATStxt 
			ft:ClearAllPoints()
			ft:SetAllPoints(Wyr3d_STATS) 
			ft:SetJustifyH("CENTER")
			ft:SetJustifyV("CENTER")
            Wyr3d_STATS:ClearAllPoints()
            Wyr3d_STATS:SetPoint("BOTTOMRIGHT",PaperDollFrame,"TOPRIGHT",0,0)
            Wyr3d_STATS:SetParent(PaperDollFrame)
            Wyr3d_STATS:Show()            
        end
        return true
    end
    return false
end

function Wyr3d_STATS:Update()
    if Wyr3d_STATS:CreateWin() then
        local _, className = UnitClass("player")
        local sId, specName = GetSpecializationInfo(GetSpecialization())
        local s = Wyr3d_StatTable[className .. "-" .. sId]
        if s then
            s = gsub(s,"Strength","STR")
            s = gsub(s,"Agility","AGI")
            s = gsub(s,"Intelligence","INT")
            s = gsub(s,"Stamina","STA")
            Wyr3d_STATStxt:SetText(s) 
        end               
    end
end

Wyr3d_STATS:RegisterEvent("SPELLS_CHANGED") 
Wyr3d_STATS:RegisterEvent("ADDON_LOADED") 
Wyr3d_STATS:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" then
        Wyr3d_STATS:Update()
        PaperDollFrame:HookScript("OnShow", function() Wyr3d_STATS:Update() end)
    end
    if event == "SPELLS_CHANGED" then
            Wyr3d_STATS:Update()
    end
end)