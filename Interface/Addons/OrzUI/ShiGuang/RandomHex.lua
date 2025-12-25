--## Author: zecmo, cloned from RandomLure then modified into RandomHex ## Version: 1.0.2
local rhexList

--------------------------------------------------------------------
-- Produced Marco Name [in player's macros]
--------------------------------------------------------------------

local HexMacroName = "Hex"
local hexMacroSrc = "\n/click rhexButton 1\n/click rhexButton LeftButton 1"

local debugHex = false
local unusableHexTextColor = "|cffFF0000"

--------------------------------------------------------------------
-- Hex & Hex Variants List
--------------------------------------------------------------------

local rhexVariants = {
--- Default Hex  --
	{51514, "青蛙"},
--- Collectable Hex Variants --
	{211015, "蟑螂"},
	{210873, "掠食龙"},
	{309328, "活体蜂蜜"},
	{269352, "骸骨幼体"},
	{211004, "蜘蛛"},
	{277784, "混血柳魔"},
	{277778, "赞达拉碎肉者"},
	}

--------------------------------------------------------------------
-- Used to check incoming spellIds, hex cast?
--------------------------------------------------------------------
function IsHexVariantSpellId(spellId)
	for k in pairs(rhexVariants) do
		-- Is spellId one of the hex variants? --
		if spellId == rhexVariants[k][1] then
			return true
		end
	end
	
	return false
end

--------------------------------------------------------------------
-- UI in Options panel
--------------------------------------------------------------------

local rhexOptionsPanel = CreateFrame("Frame")
rhexOptionsPanel.name = "[萨满]随机妖术"  --Random Hex [/hex]
rhexOptionsPanel.OnCommit = function() rhexOptionsOkay(); end
rhexOptionsPanel.OnDefault = function() end
rhexOptionsPanel.OnRefresh = function() end
local rhexCategory = Settings.RegisterCanvasLayoutCategory(rhexOptionsPanel, "[萨满]随机妖术")  --Random Hex [/hex]
Settings.RegisterAddOnCategory(rhexCategory)

-- Title --
local rhexTitle = CreateFrame("Frame",nil, rhexOptionsPanel)
rhexTitle:SetPoint("TOPLEFT", 10, -10)
rhexTitle:SetWidth(SettingsPanel.Container:GetWidth()-35)
rhexTitle:SetHeight(1)
rhexTitle.text = rhexTitle:CreateFontString(nil, "OVERLAY", "GameFontNormal")
rhexTitle.text:SetPoint("TOPLEFT", rhexTitle, 0, 0)
rhexTitle.text:SetText("Random Hex")
rhexTitle.text:SetFont("Fonts\\FRIZQT__.TTF", 18)

-- Thanks --
rhexOptionsPanel.Thanks = rhexOptionsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
rhexOptionsPanel.Thanks:SetPoint("BOTTOMRIGHT",-5,5)
rhexOptionsPanel.Thanks:SetText("致所有收集妖术变体，我的萨满同胞们。\n 自JamienAU的\"随机炉石\"克隆。  \n 由zecmo改造成\"随机鱼饵\"和\"随机妖术\"。    \nHakkar\n汉化：胡里胡涂 整合：2UI")
rhexOptionsPanel.Thanks:SetFont("Fonts\\FRIZQT__.TTF", 9)
rhexOptionsPanel.Thanks:SetJustifyH("RIGHT")

-- Description
local rhexDesc = CreateFrame("Frame", nil, rhexOptionsPanel)
rhexDesc:SetPoint("TOPLEFT", 20, -40)
rhexDesc:SetWidth(SettingsPanel.Container:GetWidth()-35)
rhexDesc:SetHeight(1)
rhexDesc.text = rhexDesc:CreateFontString(nil, "OVERLAY", "GameFontNormal")
rhexDesc.text:SetPoint("TOPLEFT", rhexDesc, 0, 0)
rhexDesc.text:SetText("在随机池中 添加/移除 妖术变体 [红色字体 表示未获得/不可用的变体]")
rhexDesc.text:SetFont("Fonts\\FRIZQT__.TTF", 14)

-- Scroll Frame
local rhexOptionsScroll = CreateFrame("ScrollFrame", nil, rhexOptionsPanel, "UIPanelScrollFrameTemplate")
rhexOptionsScroll:SetPoint("TOPLEFT", 5, -60)
rhexOptionsScroll:SetPoint("BOTTOMRIGHT", -25, 100)

-- Divider
local rhexDivider = rhexOptionsScroll:CreateLine()
rhexDivider:SetStartPoint("BOTTOMLEFT", 20, -10)
rhexDivider:SetEndPoint("BOTTOMRIGHT", 0, -10)
rhexDivider:SetColorTexture(0.25,0.25,0.25,1)
rhexDivider:SetThickness(1.2)

-- Scroll Frame child
local rhexScrollChild = CreateFrame("Frame")
rhexOptionsScroll:SetScrollChild(rhexScrollChild)
rhexScrollChild:SetWidth(SettingsPanel.Container:GetWidth()-35)
rhexScrollChild:SetHeight(1)

-- Checkbox for each hex variant
local rhexCheckButtons = {}
for i = 1, #rhexVariants do
	local chkOffset = 0
	if i > 1 then
		local _,_,_,_,yOffSet = rhexCheckButtons[i-1]:GetPoint()
		chkOffset = math.floor(yOffSet) + -26
	end
	rhexCheckButtons[i] = CreateFrame("CheckButton", nil, rhexScrollChild, "UICheckButtonTemplate")
	rhexCheckButtons[i]:SetPoint("TOPLEFT", 15, chkOffset)
	rhexCheckButtons[i]:SetSize(25,25)
	rhexCheckButtons[i].ID = rhexVariants[i][1]
	rhexCheckButtons[i].Text:SetText("  " .. rhexVariants[i][2])
	rhexCheckButtons[i].Text:SetTextColor(1,1,1,1)
	rhexCheckButtons[i].Text:SetFont("Fonts\\FRIZQT__.TTF", 13)
end

-- Select All button --
local rhexSelectAll = CreateFrame("Button", nil, rhexOptionsPanel, "UIPanelButtonTemplate")
rhexSelectAll:SetPoint("BOTTOMLEFT", 20, 50)
rhexSelectAll:SetSize(100,25)
rhexSelectAll:SetText("选择所有")
rhexSelectAll:SetScript("OnClick", function(self)
	for i = 1, #rhexVariants do
		rhexCheckButtons[i]:SetChecked(true)
	end
end)

-- Deselect All button --
local rhexDeselectAll = CreateFrame("Button", nil, rhexOptionsPanel, "UIPanelButtonTemplate")
rhexDeselectAll:SetPoint("BOTTOMLEFT", 135, 50)
rhexDeselectAll:SetSize(100,25)
rhexDeselectAll:SetText("取消全选")
rhexDeselectAll:SetScript("OnClick", function(self)
	for i = 1, #rhexVariants do
		rhexCheckButtons[i]:SetChecked(false)
	end
end)

--------------------------------------------------------------------
-- Init/Awake AddonLoaded Msg Handling & Loading
--------------------------------------------------------------------
local rhexListener = CreateFrame("Frame")
rhexListener:RegisterEvent("ADDON_LOADED")
rhexListener:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "OrzUI" then
		if rhexOptions == nil then
			-- Adds all hex variant IDs to savedvariables as enabled
			rhexOptions = {}
			for i=1, #rhexVariants do
				rhexOptions[i] = {rhexVariants[i][1], true}
			end
		else
			-- Deletes hex variant IDs that no longer exist in rhexVariants list
			for i,v in pairs(rhexOptions) do
				local chk = 0
				for l = 1, #rhexVariants do
					if v[1] == rhexVariants[l][1] then
						chk = 1
					end
				end
				if chk == 0 then 
					rhexOptions[i] = nil
				end
			end

			-- Adds any missing hex variant IDs to savedvariables as enabled
			for i,v in pairs(rhexVariants) do
				local chk = 0
				for l = 1, #rhexOptions do
					if v[1] == rhexOptions[l][1] then
						chk = 1
					end
				end
				if chk == 0 then
					table.insert(rhexOptions, {v[1], true})
				end
			end
		end
		
		-- Loop through options and set checkbox state
		for i,v in pairs(rhexOptions) do
			for l = 1, #rhexOptions do
				if rhexCheckButtons[l].ID == v[1] and v[2] == true then
					rhexCheckButtons[l]:SetChecked(true)
				end
			end
		end

		self:UnregisterEvent("ADDON_LOADED")
	end
end)

--------------------------------------------------------------------
-- Assigned methods to the UI Panel's Confirm/Okay & Cancel [which Option UI updates where all changes are live with confirm, I'm not sure if the Cancel ever gets called. Perhaps in other use cases.
--------------------------------------------------------------------

function rhexOptionsOkay()
	-- Class Check!
	local classFilename, classId = UnitClassBase("player")
	if classFilename ~= "SHAMAN" then
		return
	end

	for i = 1, #rhexOptions do
		for _,v in pairs(rhexOptions) do
			if rhexCheckButtons[i].ID == v[1] then
				v[2] = rhexCheckButtons[i]:GetChecked()
			end
		end
	end

	RefreshRandomHexPool()
	SelectRandomHexVariant()

	if #rhexList == 0 then
		print("|cffFF0000随机妖术插：未选择有效的妖术变体 -|r 呱！") end	
end

--------------------------------------------------------------------
-- Create an invisible button for our macro to click.
--  Button creation, named [rhexButton]
--------------------------------------------------------------------
local rhexBtn = CreateFrame("Button", "rhexButton", nil,  "SecureActionButtonTemplate")

-- WoW client events we want to know about --
rhexBtn:RegisterEvent("PLAYER_ENTERING_WORLD")
rhexBtn:RegisterEvent("UNIT_SPELLCAST_START")
rhexBtn:RegisterEvent("UNIT_SPELLCAST_STOP")
rhexBtn:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
rhexBtn:RegisterEvent("PLAYER_LEAVE_COMBAT")
rhexBtn:RegisterForClicks("LeftButtonDown", "LeftButtonUp" )
rhexBtn:SetAttribute("type","spell")

local hexWasCast = false
local hexCastId = 000000
-- Pass in an anonymous function which handles the events --
rhexBtn:SetScript("OnEvent", function(self, event, arg1, arg2, arg3)
	-- Capture any Hex Variant cast start --
	if event == "UNIT_SPELLCAST_START" and arg1 == "player" then
		if IsHexVariantSpellId(arg3) then
			hexCastId = arg3
		end
	end

	if not InCombatLockdown() then
		-- Out of Combat --
		if event == "PLAYER_ENTERING_WORLD" then
			RefreshRandomHexPool()
			SelectRandomHexVariant()
			-- Unregister from event --
			rhexBtn:UnregisterEvent("PLAYER_ENTERING_WORLD")
		end

		if  event == "UNIT_SPELLCAST_SUCCEEDED" or event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_STOP" then
			if arg1 == "player" and IsHexVariantSpellId(arg3) and hexCastId == arg3 then
				hexCastId = 000000
				SelectRandomHexVariant()
			end
		end
	else
		-- In Combat --
		if event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" then
			if IsHexVariantSpellId(arg3) then				
				hexWasCast = true

				if debugHex then
					print("== 战斗中使用妖术") end
			end
		end
	end

	-- Always do whenever player leaves combat, regardless of lockdown
	if event == "PLAYER_LEAVE_COMBAT" then
		if debugHex then
			print("== 玩家脱离战斗……") end

		if hexWasCast then
			WaitThenSetRandomHex()

			if debugHex then
				print("=== 妖术已被释放！！") end
		end		
	end
end)

--------------------------------------------------------------------
-- Convenient to have a method to call that executes after timer completes
--------------------------------------------------------------------
function WaitThenSetRandomHex()
	local timeOut = 1
	C_Timer.After(timeOut, function()
		local ticker
		ticker = C_Timer.NewTicker(1, function()
			if InCombatLockdown() then
				WaitThenSetRandomHex()
			else
				-- Now call hex selection --
				if hexWasCast then
					if debugHex then
						print("==== 妖术在战斗结束后已更新。") end

					hexWasCast = false
					SelectRandomHexVariant()
				end
			end

			-- Always cancel the ticker
  			ticker:Cancel()
	    end)
	end)
end

--------------------------------------------------------------------
-- Generate the list of valid Hex Variants
--------------------------------------------------------------------
function RefreshRandomHexPool()
	-- Re-initialize
	rhexList = {}

	for i=1, #rhexOptions do
		if rhexOptions[i][2] == true then
			if IsSpellKnownOrOverridesKnown(rhexOptions[i][1]) then
				table.insert(rhexList,rhexOptions[i][1])
			end
		end
	end

	if debugHex then
		print("==== 刷新随机池：" .. #rhexList) end

	ColorizeHexVariantText()
end

--------------------------------------------------------------------
-- White text for known/usable, Red text for unknown/unusable[faction]
--------------------------------------------------------------------
function ColorizeHexVariantText()
	-- Check for usable hex variants then colorize and [debug] print out all available hex variants --		
	for k in pairs(rhexVariants) do

		-- Add a faction suffix for convenince --
		local factionSuffix = ""
		if rhexVariants[k][2] == "Wicker Mongrel" then
			factionSuffix = " [Alliance]" end
		if rhexVariants[k][2] == "Zandalari Tendonripper" then
			factionSuffix = " [Horde]" end

		if IsSpellKnownOrOverridesKnown(rhexVariants[k][1]) then
			if debugHex then
				print("=== " .. rhexVariants[k][2] .. "：可用！") end
				-- Default white --
				rhexCheckButtons[k].Text:SetText("  " .. rhexVariants[k][2] .. factionSuffix)
		else
			if debugHex then
				print("=== " .. rhexVariants[k][2] .. " 不可用！") end
				-- Unknowns red --
				rhexCheckButtons[k].Text:SetText("  " .. unusableHexTextColor .. rhexVariants[k][2] .. factionSuffix)
		end
	end
end

--------------------------------------------------------------------
-- Set random Hex Variant from a diminishing pool 
--------------------------------------------------------------------
function SelectRandomHexVariant()
	if debugHex then
		print("== remainingInPool_OnEnter: " .. #rhexList) end

	-- Make sure the poolList is not empty 
	if #rhexList == 0 then
		RefreshRandomHexPool()
	end

	-- Still no valid entries?
	if #rhexList == 0 then
		-- Default Hex --
		rhexBtn:SetAttribute("spell", 51514)
		UpdateRandomHexMacro("Hex(Frog)","237579")
		return
	end

	-- Get random index --
	local rnd = GetRandomHexVariantIndex(#rhexList)
	local randomHexIndexSpellId = rhexList[rnd]

	-- Get Spell Info with many return values --
	local spellInfo = C_Spell.GetSpellInfo(randomHexIndexSpellId)

	-- Update button --
	rhexBtn:SetAttribute("spell", spellInfo["spellID"])

	-- Build name and update macro --
	local hexVariantName = HexNameFromSpellId(randomHexIndexSpellId)
	local hexCompoundName = spellInfo["name"] .. "(" .. hexVariantName .. ")"
	UpdateRandomHexMacro(hexCompoundName, spellInfo["originalIconID"])

	if debugHex then
		print("=== 已选中：" .. hexVariantName) end

	-- Once the hex variant data is loaded, remove the variant id from the pool --
	table.remove(rhexList, rnd)	
end

function HexNameFromSpellId(spellId)
	for i=1, #rhexVariants do
		if rhexVariants[i][1] == spellId then
			return rhexVariants[i][2]
		end
	end

	return ""
end

--------------------------------------------------------------------
-- Gets random index without allowing the same hex variant twice in a row
--   which could happen on pool refresh
--------------------------------------------------------------------
local prevHexId = -1
function GetRandomHexVariantIndex(size)
	if size > 1 then
		local rando = math.random(1,size)
		if rhexList[rando] == prevHexId then
			if rando == 1 then
				rando = size
			else
				rando = rando - 1
			end
		end

		prevHexId = rhexList[rando]
		return rando
	end

	if size == 1 then
		prevHexId = rhexList[1]
		return 1
	end

	return 0		
end

--------------------------------------------------------------------
-- Update/Create the global macro
--------------------------------------------------------------------
function UpdateRandomHexMacro(name,icon)
	if not InCombatLockdown() then
		local macroIndex = GetMacroIndexByName(HexMacroName)
		if macroIndex > 0 then
			EditMacro(macroIndex, HexMacroName, icon, "#showtooltip " .. name .. hexMacroSrc)
		else
			CreateMacro(HexMacroName, icon, "#showtooltip " .. name .. hexMacroSrc, nil)
		end
	end
end

--------------------------------------------------------------------
-- Create slash commands
--------------------------------------------------------------------
SLASH_RandomHex1 = "/hex"
function SlashCmdList.RandomHex(msg, editbox)
	Settings.OpenToCategory(rhexCategory:GetID())
end
