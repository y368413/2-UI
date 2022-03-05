--## Author: Reglohpri  ## Version: 1.53
local vars, Ld, La = {},{}, {}

vars.L = setmetatable({},{
    __index = function(t, s) return La[s] or Ld[s] or rawget(t,s) or s end
})

-- Ld means default (english) if no translation found. So we don't need a translation for "enUS" or "enGB".
Ld["Agi"] = "Agi"
Ld["Crit"] = "Crit"
Ld["Haste"] = "Haste"
Ld["Int"] = "Int"
Ld["Mastery"] = "Mastery"
Ld["Sta"] = "Stam"
Ld["Str"] = "Str"
Ld["Vers"] = "Vers"
Ld["Armor"] = "Armor"

if GetLocale() == "zhCN" then do end
	La["Agi"] = "敏捷"
	La["Haste"] = "急速"
	La["Crit"] = "暴击"
	La["Int"] = "智力"
	La["Mastery"] = "精通"
	La["Sta"] = "耐力"
	La["Str"] = "力量"
	La["Vers"] = "全能"
	La["Armor"] = "盔甲"
elseif GetLocale() == "zhTW" then do end
	La["Agi"] = "敏捷"
	La["Haste"] = "加速"
	La["Crit"] = "致命"
	La["Int"] = "智力"
	La["Mastery"] = "精通"
	La["Sta"] = "耐力"
	La["Str"] = "力量"
	La["Vers"] = "臨機"
	La["Armor"] = "盔甲"
end

local sFrameInit = false
local pHooked = false
local elapsedTime = 0

-- Changed for Patch 9.0.1 - Shadowlands
--stats_Frame = CreateFrame("Frame",stats_Frame,UIParent)
local stats_Frame = CreateFrame("Frame",stats_Frame,UIParent,"BackdropTemplate")

function stats_Frame:CreateWin()
    if PaperDollFrame:IsVisible() then
        if not stats_Window then
			stats_Window = CreateFrame("Frame",stats_Window,stats_Frame,"BackdropTemplate")

			stats_Frame:SetBackdropColor(0,0,0,1)
            stats_Frame:SetFrameStrata("TOOLTIP")
            stats_Frame:SetWidth(PaperDollFrame:GetWidth()-50)
			stats_Frame:SetHeight(21)

			stats_txt = stats_Frame:CreateFontString(nil,"OVERLAY","GameFontWhite")
			local ft = stats_txt
			ft:ClearAllPoints()
			ft:SetAllPoints(stats_Frame)
			ft:SetJustifyH("CENTER")
			ft:SetJustifyV("CENTER")
            stats_Frame:ClearAllPoints()
            stats_Frame:SetPoint("BOTTOMRIGHT",PaperDollFrame,"TOPRIGHT",0,0)
            stats_Frame:SetParent(PaperDollFrame)
            stats_Frame:Show()
        end
        return true
    end
    return false
end

function stats_Frame:Update()
    if GetSpecialization() == nil then
          return false
    end

	local specID = select(1,GetSpecializationInfo(GetSpecialization()))

    if stats_Frame:CreateWin() then
        local s = stats_Table[specID]

        if s then
            s = gsub(s,"Strength","Str")
            s = gsub(s,"Agility","Agi")
            s = gsub(s,"Intellect","Int")
            s = gsub(s,"Stamina","Stam")
            s = gsub(s,"Versatility","Vers")

			-- H.Sch For multiple language
			s = gsub(s,"Int", vars.L["Int"])
			s = gsub(s,"Crit", vars.L["Crit"])
			s = gsub(s,"Str", vars.L["Str"])
			s = gsub(s,"Agi", vars.L["Agi"])
			s = gsub(s,"Stam", vars.L["Sta"])
			s = gsub(s,"Vers", vars.L["Vers"])
			s = gsub(s,"Haste", vars.L["Haste"])
			s = gsub(s,"Mast", vars.L["Mastery"])
			s = gsub(s,"Armor", vars.L["Armor"])
			-- H.Sch End for multiple language
			statsw_txt:SetText(v)
            stats_txt:SetText(s)
        end
		sFrameInit = true
    end
end

stats_Frame:RegisterEvent("SPELLS_CHANGED")
stats_Frame:RegisterEvent("ADDON_LOADED")
stats_Frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
		stats_Frame:Update()
		PaperDollFrame:HookScript("OnShow", function() stats_Frame:Update() end)
		pHooked = true
    elseif event == "SPELLS_CHANGED" then
            stats_Frame:Update()
    end
end)

local delayTimer = CreateFrame("Frame")
delayTimer:SetScript("OnUpdate", function (self, elapsed)
	elapsedTime = elapsedTime + elapsed
	if (elapsedTime < 10) then
		return
	else
		elapsedTime = 0
	end

	if not sFrameInit then
		stats_Frame:Update()
		if not pHooked then
			PaperDollFrame:HookScript("OnShow", function() stats_Frame:Update() end)
			pHooked = true
		end
	end

end)

stats_Table["Version"] = "|cFFFAFA44Icy-Veins Stat Priorities:|cFF00EA00 07.03.2021|r"

--[[ Deathknight Blood]]
stats_Table[250] = "Item Level > Str > Vers > Haste > Crit > Mast"
--[[ Deathknight Frost]]
stats_Table[251] = "Str > Mast > Crit > Haste > Vers"
--[[ Deathknight Unholy]]
stats_Table[252] = "Str > Mast > Haste > (Crit / Vers)"

--[[ Druid Balance]]
stats_Table[102] = "KYR: Int > Mast > Haste > Vers > Crit \n NF: Int > Mast > Vers > Haste > Crit"
--[[ Druid Feral]]
stats_Table[103] =  "Agi > Crit > Mast > Vers > Haste"
--[[ Druid Guardian]]
stats_Table[104] = "Survival: (Armor/Agi/Stam)>Vers>Mast>Haste>Crit \n DPS Boost: Agi > Vers >= Haste >= Crit > Mast"
--[[ Druid Restoration]]
stats_Table[105] = "Raid: Int > Haste > (Mast = Crit = Vers) \n Dungeon: Int > (Mast = Haste) > Vers > Crit"

--[[ Hunter Beastmaster]]
stats_Table[253] = "Agi > Haste > (Crit / Vers) > Mast"
--[[ Hunter Marksmanship]]
stats_Table[254] = "Agi > Crit > Mast > (Vers / Haste)"
--[[ Hunter Survival]]
stats_Table[255] = "Agi > Haste > (Vers / Crit) > Mast"

--[[ Mage Arcane]]
stats_Table[62] = "Int > Crit > Mast > Vers > Haste"
--[[ Mage Fire]]
stats_Table[63] = "Int > Haste > Vers > Mast > Crit"
--[[ Mage Fros]]
stats_Table[64] = "Int > Crit 33.34% > Haste > Vers > Mast > Crit"

--[[ Monk Brewmaster]]
stats_Table[268] = "DEF: (Vers = Mast = Crit) > Haste > Agi \n OFF: (Vers = Crit) > Haste > Mast > Agi"
--[[ Monk Mistweaver]]
stats_Table[270] = "Raid: Int > Crit > Vers > Haste > Mast \n Dungeon Mythic+: Int > (Crit => Mast = Vers >= Haste)"
--[[ Monk Windwalker]]
stats_Table[269] = "Agi > Vers > Mast > Crit > Haste"

--[[ Paladin Holy]]
stats_Table[65] = "Int > Haste > Mast > Vers > Crit"
--[[ Paladin Protection]]
stats_Table[66] = "Haste > Mast > Vers > Crit"
--[[ Paladin Retribution]]
stats_Table[70] = "Str > (Haste ~= Vers ~= Mast ~= Crit)"

--[[ Priest Discipline]]
stats_Table[256] = "Int > Haste > Crit > Vers > Mast"
--[[ Priest Holy]]
stats_Table[257] = "Raid: Int > (Mast = Crit) > Vers > Haste \n Dungeon: Int > Crit > Haste > Vers > Mast"
--[[ Priest Shadow]]
stats_Table[258] = "Int > (Haste = Mast) > Crit > Vers"

--[[ Rogue Assassination]]
stats_Table[259] = "Raid: Haste > Crit > Vers > Mast > Agi \n Dungeon Mythic+: Crit > Vers > Mast > Haste > Agi"
--[[ Rogue Outlaw]]
stats_Table[260] = "Raid: Agi > Vers > Haste > Crit > Mast \n Dungeon Mythic+: Agi > Vers > Crit > Haste > Mast"
--[[ Rogue Subtlety]]
stats_Table[261] = "Single Target: Agi > Vers > Crit > Haste > Mast \n Multi Target: Agi > Crit > Vers > Mast > Haste"

--[[ Shaman Elemental]]
stats_Table[262] = "Int > Vers > Haste > Crit > Mast"
--[[ Shaman Enhancement]]
stats_Table[263] = "Agi > Haste > (Crit = Vers) > Mast"
--[[ Shaman Restoration]]
stats_Table[264] = "Int > (Vers = Crit) > (Haste = Mast)"

--[[ Warlock Affliction]]
stats_Table[265] = "Int > Mast > Haste > Crit > Vers"
--[[ Warlock Demonology]]
stats_Table[266] = "Int > Haste > Mast > (Crit = Vers)"
--[[ Warlock Destruction]]
stats_Table[267] = "Int > (Haste >= Mast) > Crit > Vers"

--[[ Warrior Arms]]
stats_Table[71] = "Str > Crit > Mast > Vers > Haste"
--[[ Warrior Fury]]
stats_Table[72] = "Str > Haste > Mast > Crit > Vers"
--[[ Warrior Protection]]
stats_Table[73] = "General: Haste > Vers > Mast > Crit > Str > Armor \n Mythic+: Haste > (Vers >= Crit) > Mast > Str > Armor"

--[[ Demon Hunter Havoc]]
stats_Table[577] = "Agi > (Haste = Vers) > Crit > Mast"
--[[ Demon Hunter Vengeance]]
stats_Table[581] = "Agi > (Haste >= Vers) > Crit > Mast"