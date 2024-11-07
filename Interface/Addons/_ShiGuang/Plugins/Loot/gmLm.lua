--## Version: 1010-2023051102 ## Author: gmarco
local L = {}
local arg = {}

local loots = {}
local prgname = "|cffffd200gmLm|r"

if GetLocale() == "zhCN" then
	-- Chinese translation by BNS
	L["Right-Click"] 		= "右键点击"
	L["Left-Click"] 		= "左键点击"
	L["Middle-Click"] 		= "中键点击"
	L["Items reports"]		= "物品报告"

	L["No items yet"]		= "尚无物品"
	
	L["Whisp player"]		= "密语玩家"
	L["Show item"]			= "显示物品"
	
	L["Min Quality"]		= "最低品质"
	L["Equip Only"]			= "只限可装备"
	L["Myself"]				= "我自己"
	L["Demo"]				= "范例"

	L["Hey, do you mind to trade me %s if you don't need it ?"] = "你好!这件装备 %s 如果你不要,能否惠赠给我呢?非常感谢!!!"
elseif GetLocale() == "zhTW" then
	-- Chinese translations by BNS 
	L["Right-Click"] 		= "右鍵點擊"
	L["Left-Click"] 		= "左鍵點擊"
	L["Middle-Click"] 		= "中鍵點擊"
	
	L["Items reports"]		= "物品報告"
	L["No items yet"]		= "尚無物品"
	
	L["Whisp player"]		= "密語玩家"
	L["Show item"]			= "顯示物品"
	
	L["Min Quality"]		= "最低品質"
	L["Equip Only"]			= "只限可裝備"
	L["Myself"]				= "我自己"
	L["Demo"]				= "範例"

	L["Hey, do you mind to trade me %s if you don't need it ?"] = "您好！如果您並不需要 %s 可否交易給我呢？感謝！"
else
	L["Right-Click"] 		= "Right-Click"
	L["Left-Click"] 		= "Left-Click"
	L["Middle-Click"] 		= "Middle-Click"

	L["Items reports"]		= "Items reports"
	L["No items yet"]		= "No items yet"
	
	L["Whisp player"]		= "Whisp player"
	L["Show item"]			= "Show item"
	
	L["Min Quality"]		= "Min Quality"
	L["Equip Only"]			= "Equip Only"
	L["Myself"]				= "Myself"
	L["Demo"]				= "Demo"

	L["Hey, do you mind to trade me %s if you don't need it ?"] = "Hey, do you mind to trade me %s if you don't need it ?"

	L["DataBroker"]			= "DataBroker"
end
--
-- minquality values from: 	http://wowprogramming.com/docs/api_types#itemQuality
--
-- 0. Poor (gray): Broken I.W.I.N. Button
-- 1. Common (white): Archmage Vargoth's Staff
-- 2. Uncommon (green): X-52 Rocket Helmet
-- 3. Rare / Superior (blue): Onyxia Scale Cloak
-- 4. Epic (purple): Talisman of Ephemeral Power
-- 5. Legendary (orange): Fragment of Val'anyr
-- 6. Artifact (golden yellow): The Twin Blades of Azzinoth
-- 7. Heirloom (light yellow): Bloodied Arcanite Reaper

local LeftButton = " |TInterface\\TUTORIALFRAME\\UI-TUTORIAL-FRAME:13:11:0:-1:512:512:12:66:230:307|t "
local RightButton = " |TInterface\\TUTORIALFRAME\\UI-TUTORIAL-FRAME:13:11:0:-1:512:512:12:66:333:411|t "
local MiddleButton = " |TInterface\\TUTORIALFRAME\\UI-TUTORIAL-FRAME:13:11:0:-1:512:512:12:66:127:204|t "

-- Local Conn ----------------------------------------------------------------------

local LibQTip = LibStub('LibQTip-1.0')
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
 
local dataobj = ldb:NewDataObject("gmLm", {
    type 	= "data source",
	label 	= "gmLm", 
    icon 	= "Interface\\Addons\\_ShiGuang\\Media\\Modules\\gmlm.tga",
    text 	= ""
})

-- LibStub("LibDBIcon-1.0"):Register(ADDON, dataobj, mmobjDB)

local icon = LibStub("LibDBIcon-1.0")
icon:Register("gmLm", dataobj, minimapicondb)

-- icon:Show(ADDON)

local frame = CreateFrame("Frame")

-- Local Functions ------------------------------------------------------------------

local function classcolor(name,class)
	if class then
		local color = _G["RAID_CLASS_COLORS"][class]
		if color then 
			return string.format("\124cff%02x%02x%02x%s\124r", color.r*255, color.g*255, color.b*255, name)
		end
	end
	return name
end

local function Button_OnClick(row,arg,button)
    
		LibQTip:Release(tooltip)
		tooltip = nil  
	
		if button == "RightButton" then

		SendChatMessage(string.format(L["Hey, do you mind to trade me %s if you don't need it ?"],arg.itemLink), "WHISPER", nil, arg.player)

	elseif button == "LeftButton" then
	
		ShowUIPanel(ItemRefTooltip)
		
		if not ItemRefTooltip:IsShown() then
			
			ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")

		end
		
		ItemRefTooltip:SetHyperlink(arg.itemLink)
	end
end

local function demoToolTip()
	
	local loots = {}
	
	for i=1,15 do
		local drops = {192627, 21877, 200224, 205686, 194308, 169223}
		local loot = drops[math.random(6)]
		
		print(loot)
		
		local _, _, quality, _, _, class, subclass, _, equipSlot, texture, _, ClassID, SubClassID = GetItemInfo(loot)
		
		player = UnitName("player")
		local class = UnitClass("player")
			
			loots[#loots+1] = {
				ilv				= GetDetailedItemLevelInfo(loot),
				player			= player,
				class			= class,
				itemLink		= select(2,GetItemInfo(loot)),
			}	
	end
	return loots
	
end
local function UpdateLDB()
	
	local myself, equiponly
	
	local _, _, _, hex = GetItemQualityColor(GMLM_CFG["MINQUALITY"])
	local longquality = string.format("|c%s%s|r",hex, _G["ITEM_QUALITY" .. GMLM_CFG["MINQUALITY"] .. "_DESC"])
	local shortquality = string.format("|c%sQ|r",hex)
	
	if GMLM_CFG["MYSELF"] == false then 
		myself = "|cFFFF0000SELF|r" 
	else 
		myself = "|cFF00FF00SELF|r"
	end
	
	if GMLM_CFG["EQUIPONLY"] == false then 
		equiponly = "|cFFFF0000EQ|r" 
	else 
		equiponly = "|cFF00FF00EQ|r"
	end
	
	dataobj.text = string.format("%s %s %s", shortquality, myself, equiponly)
	print(string.format("|cFFFFFF00%s|r config: %s %s %s scale %s","gmLm",longquality, myself, equiponly,GMLM_CFG["SCALE"]))
	
	if GMLM_CFG["MINIMAP"] == false then 
		icon:Hide("gmLm")
	else 
		icon:Show("gmLm")
	end
	
end

local function OnRelease_legenda(self)
	LibQTip:Release(self.tooltip_legenda)
	self.tooltip_legenda = nil  
end  
 
local function OnLeave_legenda(self)
	if self.tooltip_legenda and not self.tooltip_legenda:IsMouseOver() then
		self.tooltip_legenda:Release()
	end
end  

local function ShowLegenda(self)
	
	arg = {}

	if self.tooltip_legenda then
		LibQTip:Release(self.tooltip_legenda)
		self.tooltip_legenda = nil  
	end
	
	local row,col
    local tooltip_legenda = LibQTip:Acquire("gmLm".."tip_legenda", 2, "LEFT","RIGHT")
    self.tooltip_legenda = tooltip_legenda 
	tooltip_legenda:SmartAnchorTo(self)
	tooltip_legenda:EnableMouse(true)
	tooltip_legenda.OnRelease = OnRelease_legenda
	tooltip_legenda.OnLeave = OnLeave_legenda
    tooltip_legenda:SetAutoHideDelay(.1, self)
	tooltip_legenda:SetScale(GMLM_CFG["SCALE"])
	
 	row,col = tooltip_legenda:AddLine("")
	
	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,_G["GAMEMENU_HELP"],"CENTER",2)
	
	row,col = tooltip_legenda:AddLine("")	
	row,col = tooltip_legenda:AddLine("")		

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,L["Items reports"],"CENTER",2)
	row,col = tooltip_legenda:AddSeparator()
	row,col = tooltip_legenda:AddLine()
	
	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,LeftButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200" .. L["Show item"] .. "|r")

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,RightButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200" .. L["Whisp player"] .. "|r")

	row,col = tooltip_legenda:AddLine("")	
	row,col = tooltip_legenda:AddLine("")		

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,L["DataBroker"],"CENTER",2)
	row,col = tooltip_legenda:AddSeparator()
	row,col = tooltip_legenda:AddLine()
	
	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,LeftButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200" .. L["Min Quality"] .. "|r")

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,RightButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200" .. L["Myself"] .. "|r")

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,MiddleButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200" .. L["Equip Only"] .. "|r")

	row,col = tooltip_legenda:AddLine("")		
	row,col = tooltip_legenda:AddLine("")		

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,_G["SHIFT_KEY"] .. " " .. LeftButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200 - " .. _G["UI_SCALE"] .. "|r")

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,_G["SHIFT_KEY"] .. " " ..RightButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200 + " .. _G["UI_SCALE"] .. "|r")

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,_G["SHIFT_KEY"] .. " " ..MiddleButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200 1.0 " .. _G["UI_SCALE"] .. "|r")

	row,col = tooltip_legenda:AddLine("")		
	row,col = tooltip_legenda:AddLine("")	

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,_G["CTRL_KEY"] .. " " ..LeftButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200" .. _G["MINIMAP_LABEL"] .. " " .. _G["NO"] .. "|r")
	
	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,_G["CTRL_KEY"] .. " " ..RightButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200" .. _G["MINIMAP_LABEL"] .. " " .. _G["YES"] .. "|r")

	row,col = tooltip_legenda:AddLine("")		
	row,col = tooltip_legenda:AddLine("")	

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,_G["ALT_KEY"] .. " " ..LeftButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200" .. _G["GAMEMENU_HELP"] .. "|r")
	
	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,_G["ALT_KEY"] .. " " ..MiddleButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200" .. _G["RESET"] .. "|r")

	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,_G["ALT_KEY"] .. " " ..RightButton)
	tooltip_legenda:SetCell(row,2,"|cffffd200" .. L["demo"] .. "|r")
	
	row,col = tooltip_legenda:AddLine("")		
	row,col = tooltip_legenda:AddLine("")		
	
	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,_G["GAME_VERSION_LABEL"],"CENTER",2)
	row,col = tooltip_legenda:AddSeparator()
	row,col = tooltip_legenda:AddLine()	
	
	row,col = tooltip_legenda:AddLine()
	tooltip_legenda:SetCell(row,1,prgname)
	tooltip_legenda:SetCell(row,2,"ver.|cffffd2001010-2023051102|r")
	row,col = tooltip_legenda:AddLine("")		
	
	
	tooltip_legenda:Show()
end

local function OnRelease(self)
	LibQTip:Release(self.tooltip)
	self.tooltip = nil  
end

local function OnLeave(self)
	if self.tooltip and not self.tooltip:IsMouseOver() then
		self.tooltip:Release()
	end
end  
 
local function anchor_OnEnter(self)

	arg = {}

	if self.tooltip then
		LibQTip:Release(self.tooltip)
		self.tooltip = nil  
	end
	
    local row,col
    local tooltip = LibQTip:Acquire("gmLm".."tip", 3, "LEFT", "CENTER", "LEFT")
    self.tooltip = tooltip 
    tooltip:SmartAnchorTo(self)
	tooltip:EnableMouse(true)
	tooltip.OnRelease = OnRelease
	tooltip.OnLeave = OnLeave
    tooltip:SetAutoHideDelay(.1, self)
	tooltip:SetScale(GMLM_CFG["SCALE"])
	
 	row,col = tooltip:AddLine("")
	row,col = tooltip:AddLine("")
 
	if #loots > 0 then 

		row,col = tooltip:AddLine()
		tooltip:SetCell(row,1,L["Items reports"],"CENTER",3)
		tooltip:SetColumnTextColor(1,1,1,0)
		row,col = tooltip:AddLine("")

		row,col = tooltip:AddLine()
		tooltip:SetCell(row,1,_G["PLAYER"])
		tooltip:SetCell(row,2,_G["ITEM_LEVEL_ABBR"])
		tooltip:SetCell(row,3,_G["LOOT"])
		tooltip:SetLineTextColor(row, 1, 1, 0)

		for i=1, #loots do
			row,col = tooltip:AddLine()
			tooltip:SetCell(row,1,classcolor(loots[i]["player"],loots[i]["class"]))
			tooltip:SetCell(row,2,loots[i]["ilv"])
			tooltip:SetCell(row,3,loots[i]["itemLink"])
			
			arg[row] = { 
				player=loots[i]["player"],
				ilv=loots[i]["ilv"],
				itemLink=loots[i]["itemLink"],
				tooltip=tooltip
			}
			tooltip:SetLineScript(row, 'OnMouseUp', Button_OnClick, arg[row])
			row,col = tooltip:Show()
		end
		
	else
	
		row,col = tooltip:AddLine()
		tooltip:SetCell(row,1,L["No items yet"],"CENTER",3)
	
	end
	
	row,col = tooltip:AddLine("")		
	row,col = tooltip:AddLine("")
	row,col = tooltip:AddLine("")	
		
	row,col = tooltip:AddLine()
	tooltip:SetCell(row,2,_G["ALT_KEY"] .. " " .. LeftButton .. " |cffffd200" .. _G["GAMEMENU_HELP"] .. "|r","RIGHT",2)

	tooltip:UpdateScrolling(GetScreenHeight()-100)
	row,col = tooltip:Show()		
	
end
 
function dataobj.OnEnter(self)
    anchor_OnEnter(self)
end
 
function dataobj.OnLeave(self)
    -- Null operation: Some LDB displays get cranky if this method is missing.
end

function dataobj.OnClick(self, button)

	LibQTip:Release(self.tooltip_legenda)
	self.tooltip_legenda = nil

	LibQTip:Release(self.tooltip)
	self.tooltip = nil

	if IsShiftKeyDown() then 	
		if button == "LeftButton" then	
			if GMLM_CFG["SCALE"] < 0.8 then return end
			GMLM_CFG["SCALE"] = GMLM_CFG["SCALE"] - 0.05
		end

		if button == "RightButton" then 
			if GMLM_CFG["SCALE"] > 2 then return end
			GMLM_CFG["SCALE"] = GMLM_CFG["SCALE"] + 0.05
		end
		
		if button == "MiddleButton" then 
			GMLM_CFG["SCALE"] = 1
		end
	end

	if IsAltKeyDown() then
		if 	button == "LeftButton" then 
			ShowLegenda(self)
		end
		
		if button == "MiddleButton" then 
			loots = {}
		end
		
		if button == "RightButton" then 
			loots = demoToolTip()
		end	
	end

	if IsControlKeyDown() then
	
		if 	button == "LeftButton" then 
			icon:Hide("gmLm")
			GMLM_CFG["MINIMAP"] = false
		end
		
		if button == "MiddleButton" then 
		end
		
		if button == "RightButton" then 
			icon:Show("gmLm")
			GMLM_CFG["MINIMAP"] = true
		end	
	end

	if button == "LeftButton" and not IsModifierKeyDown() then
		if GMLM_CFG["MINQUALITY"] == 5 then 					
			GMLM_CFG["MINQUALITY"] = 1
		else
			GMLM_CFG["MINQUALITY"] = GMLM_CFG["MINQUALITY"] + 1
		end	
	end
	
	if button == "RightButton" and not IsModifierKeyDown() then	
		GMLM_CFG["MYSELF"] = not GMLM_CFG["MYSELF"]
	end
	
	if button == "MiddleButton" and not IsModifierKeyDown() then
		GMLM_CFG["EQUIPONLY"] = not GMLM_CFG["EQUIPONLY"]
	end	
	
	UpdateLDB()
	
end

frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("CHAT_MSG_LOOT")
frame:SetScript("OnEvent", function(self, event, ...)

	if event == "PLAYER_LOGIN" then 
		-- defaults
		local GMLM_DEFAULTS = {MAXLOOTS=20,MYSELF=false,MINQUALITY=2,EQUIPONLY=false,MINIMAP=true,SCALE=1}
		GMLM_CFG = GMLM_CFG or {}

		for k in pairs(GMLM_DEFAULTS) do
			if GMLM_CFG[k] == nil then GMLM_CFG[k] = GMLM_DEFAULTS[k] end
		end
		
		-- destroy the old vars if present
		GMLM_CFG["scale"]		= nil
		GMLM_CFG["minimap"]		= nil
		GMLM_CFG["minquality"]	= nil
		GMLM_CFG["equiponly"]	= nil
		GMLM_CFG["maxloots"]	= nil
		GMLM_CFG["myself"]		= nil
	end
			
	if event == "PLAYER_ENTERING_WORLD" then	
		UpdateLDB()
	end

	if event == "CHAT_MSG_LOOT" then

		local lootstring, player_src, _, _, player = ...
		-- print(" DEBUG: player_src: " .. (player_src or "player-Name1") .. " player: " .. (player or "player-Name2") .. " text: " .. lootstring )			
				
		if player == "" then 
		-- need/greed raid method.
		-- player is not yet defined ... so it is nil and boom ! :)
		-- Later I'd like to implement the Need - roll score here ...
		
		else
		
			local itemLink 	= string.match(lootstring,"|%x+|Hitem:.-|h.-|h|r")
			if not itemLink then return end

			local itemString = string.match(itemLink, "item[%-?%d:]+")
			local _, _, quality, _, _, class, subclass, _, equipSlot, texture, _, ClassID, SubClassID = GetItemInfo(itemString)

			local AddTooLoot = true
			if GMLM_CFG["MYSELF"] == false and UnitName("player") == player then 
				AddTooLoot = false
			end	

			if GMLM_CFG["MINQUALITY"] > quality then 
				AddTooLoot = false
			end

			if GMLM_CFG["EQUIPONLY"] == true and (ClassID <= 1 or ClassID > 4 ) then 
				AddTooLoot = false
			end		
				
			-- print(" DEBUG: player: " .. player .. " itemlink: " .. itemLink .. " qlt:" .. quality .. " class:" .. class .. " subclass:" .. subclass .. " equislot:" .. equipSlot .. " classid:" .. ClassID .. " subclassid:" .. SubClassID .. " disabled:" .. tostring(AddTooLoot))
				
			-- let's add
			if player and AddTooLoot == true then 
				
				if #loots >= GMLM_CFG["MAXLOOTS"] then table.remove(loots, 1) end
			
				local nm,dm,cl
			
				if select(2,UnitClass(player)) == nil then 
				
					nm,dm = player:match("(.+)-(.+)")
					cl = select(2,UnitClass(nm))
					
				else
			
					cl = select(2,UnitClass(player))
					
				end
				
				loots[#loots+1] = {
					ilv				= GetDetailedItemLevelInfo(itemLink),
					player			= player,
					class			= cl,
					itemLink		= itemLink,
				}	
			end
		end
	end
end)

SLASH_GMLM1 = "/gmlm"
SlashCmdList["GMLM"] = function(args) 
	local param=SecureCmdOptionParse(args)
	param=param:lower()
	
	if param=="" then
		print("gmLm" .. " help:")
		print("/gmlm minimap show")
		print("/gmlm minimap hide")
		print("/gmLm demo")
		print("/gmLm reset")
		
	elseif param == "minimap show" then 
			icon:Show("gmLm")
			GMLM_CFG["MINIMAP"] = true

	elseif param == "minimap hide" then 
			icon:Hide("gmLm")
			GMLM_CFG["MINIMAP"] = false
	elseif param == "demo" then 
			loots = demoToolTip()
	elseif param == "reset" then 
			loots = {}
	end		
	return
end