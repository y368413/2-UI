--"Release Version Jan 2024 for Patch 11.0.2" by y368413
local IcyVeins_StatTable = {}
IcyVeins_StatTable["DEATHKNIGHT-250"] = "[Deathbringer]：Item Level > Haste(5%) > Critical Strike = Versatility = Mastery \n [San'layn]: Item Level > Haste > Critical Strike = Versatility = Mastery"
IcyVeins_StatTable["DEATHKNIGHT-251"] = "Critical Strike > Haste > Mastery > Versatility"
IcyVeins_StatTable["DEATHKNIGHT-252"] = "Haste > Mastery > Critical Strike > Versatility"

IcyVeins_StatTable["DEMONHUNTER-577"] = "[Single]: Agility > Critical Strike > Mastery > Haste > Versatility \n [Multi]: Agility > Critical Strike > Mastery > Versatility > Haste"
IcyVeins_StatTable["DEMONHUNTER-581"] = "Agility > Haste > Critical Strike = Versatility > Mastery"

IcyVeins_StatTable["DRUID-102"] = "Intellect > Mastery > Versatility > Haste > Critical Strike"
IcyVeins_StatTable["DRUID-103"] = "[Single]: Critical Strike = Mastery > Agility > Haste > Versatility \n [Multi]: Mastery > Critical Strike = Haste > Agility > Versatility"  --Mastery > Agility > Critical Strike > Versatility = Haste", "Multi-Target (Druid of the Claw)
IcyVeins_StatTable["DRUID-104"] = "[Survival]: Agility > Haste > Versatility > Mastery > Critical Strike \n [Damage]: Agility > Versatility = Haste = Critical Strike > Mastery"
IcyVeins_StatTable["DRUID-105"] = "[Raid]: Intellect > Haste > Mastery > Versatility > Critical Strike \n [Dungeon]: Intellect > Mastery = Haste > Versatility > Critical Strike"  --Intellect > Haste > Versatility > Critical Strike > Mastery", "Dungeon Damage Dealing

IcyVeins_StatTable["EVOKER-1467"] = "Intellect > Critical Strike > Versatility = Mastery = Haste"
IcyVeins_StatTable["EVOKER-1468"] = "[Raiding]: Intellect > Mastery > Critical Strike > Versatility > Haste \n [Mythic+]: Intellect > Critical Strike > Haste > Versatility > Mastery"
IcyVeins_StatTable["EVOKER-1473"] = "[Chronowarden]: Intellect > Haste (10%) > Mastery = Critical Strike > Haste > Versatility \n [Scalecommander]: Intellect > Haste (10%) > Mastery > Critical Strike = Haste > Versatility"

IcyVeins_StatTable["HUNTER-253"] = "[Single]: Haste > Critical Strike > Mastery > Versatility \n [Multi]: Mastery > Haste > Critical Strike > Versatility"
IcyVeins_StatTable["HUNTER-254"] = "Weapon Damage > Critical Strike > Mastery >  > Versatility > Haste"
IcyVeins_StatTable["HUNTER-255"] = "Mastery > Agility > Haste > Critical Strike > Versatility"

IcyVeins_StatTable["MAGE-62"] = "Intellect > Mastery = Haste ≥ Versatility ≥ Critical Strike"
IcyVeins_StatTable["MAGE-63"] = "Intellect > Haste > Versatility > Mastery > Critical Strike"
IcyVeins_StatTable["MAGE-64"] = "Intellect > Mastery > Haste > Critical Strike(33.34%) > Versatility"

IcyVeins_StatTable["MONK-268"] = "[Defensive]: Agility > Versatility = Mastery = Critical Strike > Haste \n [Offensive]: Agility > Versatility = Critical Strike > Mastery > Haste"
IcyVeins_StatTable["MONK-269"] = "Weapon Damage > Agility > Haste > Versatility > Critical Strike > Mastery"
IcyVeins_StatTable["MONK-270"] = "[Raid]: Intellect > Haste > Critical Strike > Versatility = Mastery \n [Mythic+]: Intellect > Haste > Critical Strike ≥ Mastery > Versatility"

IcyVeins_StatTable["PALADIN-65"] = "[Raid]: Intellect > Critical Strike > Haste > Mastery > Versatility \n [Mythic+]: Intellect > Critical Strike > Haste > Versatility > Mastery"
IcyVeins_StatTable["PALADIN-66"] = "[Defensive]: Strength > Haste ≥ Mastery ≥ Versatility > Critical Strike"
IcyVeins_StatTable["PALADIN-70"] = "Mastery > Strength > Critical Strike = Haste > Versatility"

IcyVeins_StatTable["PRIEST-256"] = "Intellect > Haste > Mastery > Critical Strike > Versatility"
IcyVeins_StatTable["PRIEST-257"] = "[Raid]: Intellect > Critical Strike = Mastery > Versatility > Haste \n [Mythic+]: Intellect > Critical Strike = Haste > Versatility > Mastery"
IcyVeins_StatTable["PRIEST-258"] = "Intellect > Haste > Mastery > Critical Strike > Versatility"

IcyVeins_StatTable["ROGUE-259"] = "Mastery > Critical Strike > Haste > Versatility"
IcyVeins_StatTable["ROGUE-260"] = "Versatility > Haste > Critical Strike > Mastery"
IcyVeins_StatTable["ROGUE-261"] = "Mastery > Versatility > Critical Strike > Haste"

IcyVeins_StatTable["SHAMAN-262"] = "[Lightning]: Intellect > Haste >> Critical Strike > Versatility >> Mastery \n [Fire]: Intellect > Haste >> Versatility > Mastery >> Critical Strike"
IcyVeins_StatTable["SHAMAN-263"] = "[Stormbringer]: Haste = Agility > Mastery > Critical Strike > Versatility \n [Totemic]: Agility = Haste > Mastery > Versatility > Critical Strike"
IcyVeins_StatTable["SHAMAN-264"] = "Intellect > Versatility = Critical Strike > Haste = Mastery" 

IcyVeins_StatTable["WARLOCK-265"] = "Intellect > Mastery = Critical Strike > Haste > Versatility"
IcyVeins_StatTable["WARLOCK-266"] = "Intellect > Haste(24%) > Critical Strike = Versatility > Mastery"
IcyVeins_StatTable["WARLOCK-267"] = "Haste = Critical Strike > Intellect > Mastery > Versatility"

IcyVeins_StatTable["WARRIOR-71"] = "Strength > Critical Strike > Haste > Mastery > Versatility"
IcyVeins_StatTable["WARRIOR-72"] = "Strength > Mastery > Haste > Versatility > Critical Strike"
IcyVeins_StatTable["WARRIOR-73"] = "Strength > Haste > Versatility = Critical Strike > Mastery"


local IcyVeins_StatTableFrame = CreateFrame("Frame",IcyVeins_StatTableFrame,UIParent, BackdropTemplateMixin and "BackdropTemplate")

function IcyVeins_StatTableFrame:CreateWin()
    if PaperDollFrame:IsVisible() then
        if not IcyVeins_STATSwin then
            IcyVeins_STATSwin = CreateFrame("Frame",IcyVeins_STATSwin,IcyVeins_StatTableFrame)
            --IcyVeins_StatTableFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 1, right = 1, top = 1, bottom = 1 }}) 
            --IcyVeins_StatTableFrame:SetBackdropColor(0,0,0,1)
            IcyVeins_StatTableFrame:SetFrameStrata("TOOLTIP")
            IcyVeins_StatTableFrame:SetWidth(PaperDollFrame:GetWidth()-43) 
            IcyVeins_StatTableFrame:SetHeight(26)
            IcyVeins_StatTableFrame:ClearAllPoints()
            IcyVeins_StatTableFrame:SetPoint("BOTTOMRIGHT",PaperDollFrame,"TOPRIGHT",0,0)
            IcyVeins_StatTableFrame:SetParent(PaperDollFrame)
            IcyVeins_StatTableFrame:Show() 
    	    IcyVeins_STATStxt = IcyVeins_StatTableFrame:CreateFontString(nil,"OVERLAY","GameFontWhite") 
			IcyVeins_STATStxt:ClearAllPoints()
			IcyVeins_STATStxt:SetAllPoints(IcyVeins_StatTableFrame) 
			IcyVeins_STATStxt:SetJustifyH("CENTER")
			IcyVeins_STATStxt:SetJustifyV("MIDDLE")           
        end
        return true
    end
    return false
end

function IcyVeins_StatTableFrame:Update()
    if IcyVeins_StatTableFrame:CreateWin() then
        local _, className = UnitClass("player")
        local sId, specName = GetSpecializationInfo(GetSpecialization())
        local s = IcyVeins_StatTable[className .. "-" .. sId]
        if s then
      -- H.Sch For multiple language
			s = gsub(s,"Intellect", SPEC_FRAME_PRIMARY_STAT_INTELLECT)
			s = gsub(s,"Critical Strike", STAT_CRITICAL_STRIKE)
			s = gsub(s,"Strength", SPEC_FRAME_PRIMARY_STAT_STRENGTH)
			s = gsub(s,"Agility", SPEC_FRAME_PRIMARY_STAT_AGILITY)
			s = gsub(s,"Stamina", ITEM_MOD_STAMINA_SHORT)
			s = gsub(s,"Versatility", STAT_VERSATILITY)
			s = gsub(s,"Haste", STAT_HASTE)
			s = gsub(s,"Mastery", STAT_MASTERY)
			s = gsub(s,"Armor", STAT_ARMOR)
			s = gsub(s,"Weapon Damage", DAMAGE_TOOLTIP)
			s = gsub(s,"Item Level", STAT_AVERAGE_ITEM_LEVEL)
            IcyVeins_STATStxt:SetText(s) 
        end               
    end
end

--IcyVeins_StatTableFrame:RegisterEvent("SPELLS_CHANGED") 
IcyVeins_StatTableFrame:RegisterEvent("ADDON_LOADED") 
IcyVeins_StatTableFrame:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" then
        IcyVeins_StatTableFrame:Update()
        PaperDollFrame:HookScript("OnShow", function() IcyVeins_StatTableFrame:Update() end)
    end
    --if event == "SPELLS_CHANGED" then
            --IcyVeins_StatTableFrame:Update()
    --end
end)