--## Author: Remeen  4.2.1
local ST_Item = 1
local ST_Spell = 2
local ST_Challenge = 3


-- I'm not going to attempt any prefixes with different character sets. I may have missed some variations.
-- Some of these are odd - inconsistent translations in-game?
local RedundantStrings =
{
	-- German
	"Pfad der ",
	"Pfad des ",
	-- English
	"Path of the ",
	"Path of ",
	-- Spanish
	"Camino de los  ",
	"Senda de las ",
	"Senda de los ",
	"Senda del ",
	"Senda de ",
	-- French
	"Chemin du ",
	"Voie de ",
	"Voie des ",
	"Voie du ",
	-- Italian
	"Sentiero del ",
	"Via degli ",
	"Via dei ",
	"Via del ",
	"Via dell'",
	-- Brazilian Portugese
	"Caminho da ",
	"Caminho do ",
	"Caminho dos ",
	-- Simplified Chinese
	"之路",
	-- Traditional Chinese
	"之路",
	"之道",
	"之徑",
	-- Korean
	" 길",
}

local TeleporterSpell = {}

function TeleporterSpell:IsItem()
    return self.spellType == ST_Item
end

function TeleporterSpell:IsSpell()
    return self.spellType == ST_Spell
end

function TeleporterSpell:IsDungeonSpell()
    return self.spellType == ST_Challenge
end

function TeleporterSpell:CleanupName()
	local hide = TeleporterGetOption("conciseDungeonSpells")
    local name = self.spellName
	if hide and hide ~= "0" and self:IsDungeonSpell() then
		for index, str in pairs(RedundantStrings) do
			name = name: gsub(str, "")
		end
	end
	return name
end

function TeleporterSpell:GetOptionId()
	-- Must use the original zone name here.
	return self.spellId .. "." .. self.zone
end

function TeleporterSpell:IsVisible()
	local showSpells = TeleporterGetOption("showSpells")
	local visible = showSpells[self:GetOptionId()]
	if visible ~= nil then
		return visible
	else
		return true
	end
end

function TeleporterSpell:IsAlwaysVisible()
	local showSpells = TeleporterGetOption("alwaysShowSpells")
	if not showSpells then
		return false
	end
	local visible = showSpells[self:GetOptionId()]
	if visible ~= nil then
		return visible
	else
		return false
	end
end


 function TeleporterSpell:SetVisible()
	local showSpells = TeleporterGetOption("showSpells")
	local alwaysShowSpells = TeleporterGetOption("alwaysShowSpells")

	if not showSpells then showSpells = {} end
	if not alwaysShowSpells then alwaysShowSpells = {} end

	showSpells[self:GetOptionId()] = true
	alwaysShowSpells[self:GetOptionId()] = false

	TeleporterSetOption("showSpells", showSpells)
	TeleporterSetOption("alwaysShowSpells", alwaysShowSpells)
end

 function TeleporterSpell:SetAlwaysVisible()
	local showSpells = TeleporterGetOption("showSpells")
	local alwaysShowSpells = TeleporterGetOption("alwaysShowSpells")

	if not showSpells then showSpells = {} end
	if not alwaysShowSpells then alwaysShowSpells = {} end

	showSpells[self:GetOptionId()] = true
	alwaysShowSpells[self:GetOptionId()] = true

	TeleporterSetOption("showSpells", showSpells)
	TeleporterSetOption("alwaysShowSpells", alwaysShowSpells)
end

 function TeleporterSpell:SetHidden()
	local showSpells = TeleporterGetOption("showSpells")
	local alwaysShowSpells = TeleporterGetOption("alwaysShowSpells")

	if not showSpells then showSpells = {} end
	if not alwaysShowSpells then alwaysShowSpells = {} end

	showSpells[self:GetOptionId()] = false
	alwaysShowSpells[self:GetOptionId()] = false

	TeleporterSetOption("showSpells", showSpells)
	TeleporterSetOption("alwaysShowSpells", alwaysShowSpells)
end

function TeleporterSpell:CanUse()
    local spell = self
	local spellId = spell.spellId
	local spellType = spell.spellType
	local isItem = spell:IsItem()
	local condition = spell.condition
	local consumable = spell.consumable
	local itemTexture = nil

	if spell:IsAlwaysVisible() then
		return true
	end

	local haveSpell = false
	local haveToy = false
	local toyUsable =  false
	if C_ToyBox then
		toyUsable = C_ToyBox.IsToyUsable(spellId)
	end
	-- C_ToyBox.IsToyUsable returns nil if the toy hasn't been loaded yet.
	if toyUsable == nil then
		toyUsable = true
	end
	if isItem then
		if toyUsable then
			haveToy = PlayerHasToy(spellId) and toyUsable
		end
		haveSpell = GetItemCount( spellId ) > 0 or haveToy
	else
		haveSpell = IsSpellKnown( spellId )
	end

	if condition and not CustomizeSpells then
		if not condition() then
			haveSpell = false
		end
	end

	if TeleporterDebugMode then
		haveSpell = true
	end

	if not TeleporterGetSearchString() or not TeleporterGetOption("searchHidden") then

		if TeleporterGetOption("hideItems") and isItem then
			haveSpell = false
		end

		if TeleporterGetOption("hideConsumable") and consumable then
			haveSpell = false
		end

		if TeleporterGetOption("hideSpells") and spell:IsSpell() then
			haveSpell = false
		end

		if TeleporterGetOption("hideChallenge") and spell:IsDungeonSpell() then
			haveSpell = false
		end

		if TeleporterGetOption("seasonOnly") and spell:IsDungeonSpell() and not self:IsSeasonDungeon() then
			haveSpell = false
		end
	end

	if not CustomizeSpells and not spell:IsVisible() then
		haveSpell = false
	end

	return haveSpell
end

function TeleporterSpell:GetZone()
	local zo = TeleporterGetOption("zoneOverrides") or {}
	return zo[self:GetOptionId()] or self.zone
end

function TeleporterSpell:AddZoneAndParents(mapID)
	if not self.parentZones then
		self.parentZones = {}
	end

	while mapID ~= 0 do
		local mapInfo = C_Map.GetMapInfo(mapID)
		if mapInfo then
			tinsert(self.parentZones, string.lower(mapInfo.name))
			mapID = mapInfo.parentMapID
		else
			mapID = 0
		end
	end
end

function TeleporterSpell:SetZone(zone, mapID)
	self.zone = zone
	if mapID then
		local mapInfo = C_Map.GetMapInfo(mapID)
		if mapInfo then
			local parentMapID = mapInfo.parentMapID
			self:AddZoneAndParents(parentMapID)
		end
	end
end

function TeleporterSpell:OverrideZoneName(zone)
	local zo = TeleporterGetOption("zoneOverrides") or {}
	if zone == "" then
		zone = nil
	end
	zo[self:GetOptionId()] = zone
	TeleporterSetOption("zoneOverrides", zo)
end

function TeleporterSpell:Equals(other)
	return ""..self.spellId == ""..other.spellId and self.spellType == other.spellType
end

function TeleporterSpell:MatchesSearch(searchString)
	local searchLower = string.lower(searchString)

	if self.dungeon then
		if string.find(string.lower(self.dungeon), searchLower) then
			return true
		end
	end

	if self.parentZones then
		for i, parentZone in ipairs(self.parentZones) do
			if string.find(parentZone, searchLower) then
				return true
			end
		end
	end

	return string.find(string.lower(self.spellName), searchLower) or string.find(string.lower(self.zone), searchLower)
end

-- dungeonID from: https://warcraft.wiki.gg/wiki/LfgDungeonID, or using GetLFGDungeonInfo().
function TeleporterSpell:IsSeasonDungeon()
	-- Dragonflight Season 4
	return tContains({
		2654,	-- Ara-Kara, City of Echoes
		2652,	-- City of Threads
		2693,	-- The Stonevault
		2719,	-- The Dawnbreaker
		2120,	-- Mists of Tirna Scithe
		2123,	-- The Necrotic Wake
		1700,	-- Siege of Boralus
		304,	-- Grim Batol
	}, self.dungeonID)
end

-- Spell factories
function TeleporterCreateSpell(id, dest)
	local spell = {}
    TeleporterInitSpell(spell)
	spell.spellId = id
	spell.spellType = ST_Spell
	spell.zone = dest
	return spell
end

function TeleporterCreateItem(id, dest)
	local spell = {}
    TeleporterInitSpell(spell)
	spell.spellId = id
	spell.spellType = ST_Item
	spell.zone = dest
	return spell
end

-- dungeonID from: https://warcraft.wiki.gg/wiki/LfgDungeonID
function TeleporterCreateChallengeSpell(id, dungeonID, mapID)
	local spell = {}
	TeleporterInitSpell(spell)
	spell.spellId = id
	spell.dungeonID = dungeonID
	spell.spellType = ST_Challenge
	spell.dungeon = GetLFGDungeonInfo(dungeonID)

	if mapID then
		spell:AddZoneAndParents(mapID)
	else
		print("Missing mapID for " .. spell.dungeon)
		for i = 1,3000 do
			--local name, description, bgImage, buttonImage1, loreImage, buttonImage2, dungeonAreaMapID, link, shouldDisplayDifficulty, mapID = EJ_GetInstanceInfo(i)
			local mapInfo = C_Map.GetMapInfo(i)
			if mapInfo and mapInfo.name == spell.dungeon then
				while mapInfo.parentMapID ~= 0 do
					print(mapInfo.mapID, mapInfo.name)
					mapInfo = C_Map.GetMapInfo(mapInfo.parentMapID)
				end
			end
		end
		print("----")
	end

	return spell
end

function TeleporterCreateConditionalItem(id, condition, dest)
	local spell = {}
    TeleporterInitSpell(spell)
	spell.spellId = id
	spell.spellType = ST_Item
	spell.condition = condition
	spell.zone = dest
	return spell
end

function TeleporterCreateConditionalSpell(id, condition, dest)
	local spell = {}
    TeleporterInitSpell(spell)
	spell.spellId = id
	spell.spellType = ST_Spell
	spell.condition = condition
	spell.zone = dest
	return spell
end

function TeleporterCreateConditionalConsumable(id, condition, dest)
	local spell = {}
    TeleporterInitSpell(spell)
	spell.spellId = id
	spell.spellType = ST_Item
	spell.condition = condition
	spell.zone = dest
	spell.consumable = true
	return spell
end

function TeleporterCreateConsumable(id, dest)
	local spell = {}
    TeleporterInitSpell(spell)
	spell.spellId = id
	spell.spellType = ST_Item
	spell.zone = dest
	spell.consumable = true
	return spell
end

function TeleporterInitSpell(spell)
	setmetatable(spell, {__index=TeleporterSpell})
end


local SettingControls = {}

local ControlWidth = 300
local HideUnknown = false

local MoveButton = nil
local CancelMoveButton = nil
local AboveButton = nil
local BelowButton = nil
local ResetSortButton = nil
local MovingSpell = nil
local SelectedSpell = nil
local SetZoneButton = nil
local NewSpellZoneFrame = nil

SLASH_TELESETTINGS1 = "/telesettings"

local TeleporterSettings = {}

SlashCmdList.TELESETTINGS = function(msg, editBox)
    InterfaceOptionsFrame_OpenToCategory(TeleporterSettings.settingsPanel)
end

local function CreateText(text, optionName, parent, previous)
    local title = parent:CreateFontString(nil, nil, "GameFontNormal")
    title:SetText(text)

    if previous then
        title:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, -15)
    else
        title:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -5)
    end

    title:SetWidth(180)
    title:SetJustifyH("LEFT")

    return title
end

local function CreateResetButton(title, optionName, parent, control)
    local resetButton = CreateFrame( "Button", nil, parent, "UIPanelButtonTemplate" )
	resetButton:SetText( "Reset" )
	resetButton:SetPoint( "TOPLEFT", title, "TOPRIGHT", ControlWidth + 4,  4)
    resetButton:SetPoint( "BOTTOMLEFT", title, "BOTTOMRIGHT", ControlWidth + 4,  -4)
	resetButton:SetWidth( 80 )
    resetButton:SetScript( "OnClick",
        function()
            TeleporterSetOption(optionName, nil)
            control.loadValue()
            control.updateResetButton()
        end )

    control.resetButton = resetButton
    control.updateResetButton = function()
        if TeleporterIsOptionModified(optionName) then
            resetButton:Enable()
        else
            resetButton:Disable()
        end
    end

    return resetButton
end

local function AddStringOption(text, optionName, parent, previous)
    local title = CreateText(text, optionName, parent, previous)

    local editFrame = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    editFrame:SetPoint("TOPLEFT", title, "TOPRIGHT", 0, 4)
    editFrame:SetPoint("BOTTOMLEFT", title, "BOTTOMRIGHT", 0, -4)
    editFrame:SetWidth(ControlWidth)
    editFrame:SetAutoFocus(false)
    editFrame:SetMultiLine(false)

    local newControl = {}
    newControl.loadValue = function()
        local optionValue = TeleporterGetOption(optionName)
        if optionValue then
            editFrame:SetText(optionValue)
        else
            editFrame:SetText("")
        end
    end
    tinsert(SettingControls, newControl)

    CreateResetButton(title, optionName, parent, newControl)

    editFrame:SetScript("OnTextChanged", function(self, userInput)
        if userInput then
            TeleporterSetOption(optionName, editFrame:GetText())
            newControl.updateResetButton()
        end
    end)

    return title
end

local function AddSliderOption(text, optionName, min, max, delta, parent, previous, isFloat, offset, changeCallback)
    local labelWidth = 50

    if not offset then
        offset = 0
    end

    local title = CreateText(text, optionName, parent, previous)

    local sliderFrame = CreateFrame("Slider", "slider" .. optionName, parent, "OptionsSliderTemplate")
    sliderFrame:SetPoint("TOPLEFT", title, "TOPRIGHT", offset, 4)
    sliderFrame:SetPoint("BOTTOMLEFT", title, "BOTTOMLEFT", offset, -4)
    sliderFrame:SetWidth(ControlWidth - labelWidth - offset)
    sliderFrame:SetMinMaxValues(min, max)
    if delta then
        sliderFrame:SetValueStep(delta)
        sliderFrame:SetObeyStepOnDrag(true)
    end
    sliderFrame:Enable()
    sliderFrame:SetOrientation("HORIZONTAL")

    getglobal(sliderFrame:GetName() .. 'Low'):SetText("")
    getglobal(sliderFrame:GetName() .. 'High'):SetText("")

    local valueFrame = parent:CreateFontString(nil, nil, "GameFontNormal")
    valueFrame:SetPoint("LEFT", sliderFrame, "RIGHT", 0, 0)
    valueFrame:SetPoint("TOP", title, "TOP")
    valueFrame:SetWidth(labelWidth)

    title:SetHeight(sliderFrame:GetHeight())

    local updateDisplay = function()
        if isFloat then
            valueFrame:SetText(string.format("%.2f", TeleporterGetOption(optionName)))
        else
            valueFrame:SetText(TeleporterGetOption(optionName))
        end

        if changeCallback then
            changeCallback.run()
        end
    end

    local newControl = {}
    newControl.loadValue = function()
        updateDisplay()
        sliderFrame:SetValue(TeleporterGetOption(optionName))
    end
    tinsert(SettingControls, newControl)

    CreateResetButton(title, optionName, parent, newControl)

    sliderFrame:SetScript("OnValueChanged", function()
        TeleporterSetOption(optionName, sliderFrame:GetValue())
        updateDisplay()
        newControl.updateResetButton()
    end)

    return title
end

local function AddCheckOption(text, optionName, parent, previous)
    local title = CreateText(text, optionName, parent, previous)
    title:SetHeight(20)

    local checkFrame = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    checkFrame:SetPoint("TOPLEFT", title, "TOPRIGHT", 0, 4)
    checkFrame:SetPoint("BOTTOMLEFT", title, "BOTTOMLEFT", 0, -4)

    local newControl = {}
    newControl.loadValue = function()
        checkFrame:SetChecked(TeleporterGetOption(optionName))
    end
    tinsert(SettingControls, newControl)

    CreateResetButton(title, optionName, parent, newControl)

    checkFrame:SetScript("OnClick", function()
        TeleporterSetOption(optionName, checkFrame:GetChecked())
        newControl.updateResetButton()
    end)

    return title
end

local function AddColourOption(text, optionName, parent, hasAlpha, previous)
    local changeCallback = {}

    local colourPanelWidth = 50
    local p = previous
    p = AddSliderOption(text .. " Red", optionName .. "R", 0, 1, nil, parent, p, true, colourPanelWidth, changeCallback)
    local redTitle = p
    p = AddSliderOption(text .. " Green", optionName .. "G", 0, 1, nil, parent, p, true, colourPanelWidth, changeCallback)
    local greenTitle = p
    p = AddSliderOption(text .. " Blue", optionName .. "B", 0, 1, nil, parent, p, true, colourPanelWidth, changeCallback)
    local blueTitle = p
    if hasAlpha then
        p = AddSliderOption(text .. " Alpha", optionName .. "A", 0, 1, nil, parent, p, true)
    end

    local colourPanel = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    colourPanel:SetPoint("TOPLEFT", redTitle, "TOPRIGHT")
    colourPanel:SetPoint("BOTTOMLEFT", blueTitle, "BOTTOMRIGHT")
    colourPanel:SetWidth(colourPanelWidth)
    colourPanel.backdropInfo = {bgFile = "Interface/Buttons/WHITE8X8"}
    colourPanel:ApplyBackdrop()
    colourPanel:SetBackdropColor(1, 1, 1, 1)

    changeCallback.run = function()
        colourPanel:SetBackdropColor(TeleporterGetOption(optionName .. "R"), TeleporterGetOption(optionName .. "G"), TeleporterGetOption(optionName .. "B"), 1)
    end
    return p
end

local function RefreshSettings()
    TeleporterSettings.settingsPanel.scrollChild:SetWidth(TeleporterSettings.settingsPanel:GetWidth() - 18)
    TeleporterSettings.spellsPanel.scrollChild:SetWidth(TeleporterSettings.settingsPanel:GetWidth() - 18)

    for i,c in pairs(SettingControls) do
        c.loadValue()
        c.updateResetButton()
    end

end

local function CreateSettings(panel)
    local scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 3, -4)
    scrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)

    local scrollChild = CreateFrame("Frame", nil, panel)
    scrollFrame:SetScrollChild(scrollChild)
    scrollChild:SetHeight(1)
    panel.scrollChild = scrollChild

    local p = nil


	p = AddCheckOption("所有契约炉石", "allCovenants",         scrollChild, p)
    p = AddCheckOption("隐藏物品",                "hideItems",            scrollChild, p)
    p = AddCheckOption("隐藏地下城法术",       "hideChallenge",        scrollChild, p)
    p = AddCheckOption("显示法术",               "hideSpells",           scrollChild, p)
    p = AddCheckOption("显示地下城名称",        "showDungeonNames",     scrollChild, p)
    p = AddCheckOption("仅限当前地下城",     "seasonOnly",           scrollChild, p)
    p = AddCheckOption("将地下城分组",   "groupDungeons",        scrollChild, p)
    p = AddCheckOption("随机炉石",         "randomHearth",         scrollChild, p)
    p = AddCheckOption("在所有区域显示法术",    "showInWrongZone",      scrollChild, p)
    p = AddCheckOption("施法后关闭",          "closeAfterCast",       scrollChild, p)
    p = AddCheckOption("显示标题",                "showTitle",            scrollChild, p)
    p = AddCheckOption("简洁地下城法术",    "conciseDungeonSpells", scrollChild, p)
    p = AddCheckOption("使用旧版试衣间",        "oldCustomizer",        scrollChild, p)
    p = AddCheckOption("显示搜索框",           "showSearch",        scrollChild, p)

	p = AddSliderOption("按钮宽度",         "buttonWidth", 20, 400, 1,              scrollChild, p)
    p = AddSliderOption("按钮高度",        "buttonHeight", 20, 200, 1,             scrollChild, p)
    p = AddSliderOption("标签高度",         "labelHeight", 10, 50, 1,               scrollChild, p)
    p = AddSliderOption("最大高度",       "maximumHeight", 100, 1000, 10,         scrollChild, p)
    p = AddSliderOption("高度缩放",         "heightScalePercent", 100, 300, 50,     scrollChild, p)
    p = AddSliderOption("字体高度",          "fontHeight", 5, 30, 1,                 scrollChild, p)
    p = AddSliderOption("按钮内边距",         "buttonInset", 1, 20, 1,                scrollChild, p)
    p = AddSliderOption("缩放比例",                "scale", 0.6, 2, 0.1,                   scrollChild, p, true)
    p = AddStringOption("背景纹理",   "background",                           scrollChild, p)
    p = AddStringOption("边缘纹理",         "edge",                                 scrollChild, p)
    p = AddSliderOption("边缘大小",            "frameEdgeSize", 0, 50, 1,              scrollChild, p)
    p = AddColourOption("背景颜色",           "background",                           scrollChild, true, p)
    p = AddStringOption("标题背景",     "titleBackground",                      scrollChild, p)
    p = AddStringOption("标题字体",           "titleFont",                            scrollChild, p)
    p = AddSliderOption("标题宽度",          "titleWidth", 50, 400, 5,               scrollChild, p)
    p = AddSliderOption("标题高度",         "titleHeight", 10, 100, 5,              scrollChild, p)
    p = AddSliderOption("标题偏移",         "titleOffset", 1, 30, 1,                scrollChild, p)
    --p = AddStringOption("Button Font",          "buttonFont",                         scrollChild, p)
	p = AddStringOption("按钮背景",    "buttonBackground",                     scrollChild, p)
    p = AddStringOption("按钮边缘",          "buttonEdge",                           scrollChild, p)
    p = AddSliderOption("按钮边缘大小",     "buttonEdgeSize", 0, 50, 1,             scrollChild, p)
    p = AddSliderOption("按钮平铺尺寸",     "buttonTileSize", 1, 50, 1,             scrollChild, p)
    p = AddColourOption("准备就绪颜色",         "readyColour",                          scrollChild, false, p)
    p = AddColourOption("未装备颜色",     "unequipedColour",                      scrollChild, false, p)
    p = AddColourOption("冷却颜色",      "cooldownColour",                       scrollChild, false, p)
    p = AddColourOption("禁用颜色",      "disabledColour",                       scrollChild, false, p)

end

local ZoneLabels = {}
local SpellFrames = {}

local TextShow = "Show If Known"
local TextHide = "Hide"
local TextAlways = "Always Show"

local function CreateSpellFrame(parent)
    local spellFrame = {}
    spellFrame.mainFrame = CreateFrame("Frame", nil, parent)
    spellFrame.mainFrame:SetWidth(400)
    spellFrame.mainFrame:SetHeight(25)

    spellFrame.spellLabel = spellFrame.mainFrame:CreateFontString(nil, nil, "GameFontNormal")
    spellFrame.spellLabel:SetJustifyH("LEFT")

    spellFrame.dropDown = CreateFrame("Frame", nil, spellFrame.mainFrame, "UIDropDownMenuTemplate")
    spellFrame.dropDown:SetPoint("TOPLEFT", spellFrame.spellLabel, "TOPRIGHT", 4, 4)
    UIDropDownMenu_Initialize(spellFrame.dropDown, function()
        local info = UIDropDownMenu_CreateInfo()

        info.text = TextShow
        info.func = function()
            UIDropDownMenu_SetText(spellFrame.dropDown, TextShow)
            spellFrame.spell : SetVisible()
        end
        UIDropDownMenu_AddButton(info)

        info.text = TextHide
        info.func = function()
            UIDropDownMenu_SetText(spellFrame.dropDown, TextHide)
            spellFrame.spell:SetHidden()
        end
        UIDropDownMenu_AddButton(info)

        info.text = TextAlways
        info.func = function()
            UIDropDownMenu_SetText(spellFrame.dropDown, TextAlways)
            spellFrame.spell:SetAlwaysVisible()
        end
        UIDropDownMenu_AddButton(info)
    end)

    return spellFrame
end

local function RefreshSpellFrame(spellFrame, spell, parent, previous, refreshFunction)
    spellFrame.mainFrame:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, -15)
    spellFrame.mainFrame:SetWidth(600)

    spellFrame.spellLabel:SetPoint("TOPLEFT", spellFrame.mainFrame, "TOPLEFT", 0, 0)
    spellFrame.spellLabel:SetPoint("BOTTOMLEFT", spellFrame.mainFrame, "BOTTOMLEFT", 0, 0)
    spellFrame.spellLabel:SetText(spell.spellName)
    spellFrame.spellLabel:SetWidth(200)

    if spell:IsAlwaysVisible() then
        UIDropDownMenu_SetText(spellFrame.dropDown, TextAlways)
    elseif spell:IsVisible() then
        UIDropDownMenu_SetText(spellFrame.dropDown, TextShow)
    else
        UIDropDownMenu_SetText(spellFrame.dropDown, TextHide)
    end

    if spell.isCustom then
        if not spellFrame.deleteButton then
            spellFrame.deleteButton = CreateFrame( "Button", nil, spellFrame.mainFrame, "UIPanelButtonTemplate" )
            spellFrame.deleteButton:SetPoint("TOPLEFT", spellFrame.spellLabel, "TOPRIGHT", 160, 0)
            spellFrame.deleteButton:SetText("Delete")
            spellFrame.deleteButton:SetWidth(100)
        end
        spellFrame.deleteButton:SetScript( "OnClick", function()
            local extraSpellsAndItems = TeleporterGetOption("extraSpellsAndItems")
            for i, spell in ipairs(extraSpellsAndItems) do
                if spell == spellFrame.spell then
                    tremove(extraSpellsAndItems, i)
                end
            end
            TeleporterSetOption("extraSpellsAndItems", extraSpellsAndItems)
            TeleporterRebuildSpellList()
            refreshFunction()
        end)
        spellFrame.deleteButton:Show()
    else
        if spellFrame.deleteButton then
            spellFrame.deleteButton:Hide()
        end
    end

    spellFrame.spell = spell
end

local function ShowAboveAndBelowButtons()
    MoveButton:Hide()

    if TeleporterGetOption("sort") == 3 then
        AboveButton:SetEnabled(true)
        BelowButton:SetEnabled(true)
        if SelectedSpell == MovingSpell then
            AboveButton:Hide()
            BelowButton:Hide()
            CancelMoveButton:Show()
        else
            AboveButton:Show()
            BelowButton:Show()
            CancelMoveButton:Hide()
        end
    else
        AboveButton:SetEnabled(false)
        AboveButton:Hide()
        BelowButton:SetEnabled(false)
        AboveButton:Hide()
        CancelMoveButton:Show()
    end
end

local function ShowMoveButton()
    AboveButton:Hide()
    BelowButton:Hide()
    CancelMoveButton:Hide()
    MoveButton:Show()
end

-- Spells aren't loaded by default because creating the frames takes a long time.
local LoadSpells = false

local function RefreshSpells(panel)
    if not LoadSpells then return end

    for i,label in ipairs(ZoneLabels) do
        label:Hide()
    end

    for i,spellFrame in ipairs(SpellFrames) do
        spellFrame.mainFrame:Hide()
    end

    local lastZone
    local p
    local zoneIndex = 1
    local spellIndex = 1

    for index, spell in ipairs(TeleporterGetSpells()) do
        if spell:CanUse() or not HideUnknown then
            local zone = spell:GetZone()
            if zone ~= lastZone then
                if not ZoneLabels[zoneIndex] then
                    ZoneLabels[zoneIndex] = panel:CreateFontString(nil, nil, "GameFontWhite")
                end
                local zoneLabel = ZoneLabels[zoneIndex]
                zoneIndex = zoneIndex + 1

                zoneLabel:SetText(zone)

                if p then
                    zoneLabel:SetPoint("TOPLEFT", p, "BOTTOMLEFT", 0, -15)
                else
                    zoneLabel:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -5)
                end
                zoneLabel:SetWidth(180)
                zoneLabel:SetJustifyH("LEFT")
                zoneLabel:Show()

                p = zoneLabel
            end
            lastZone = zone

            if not SpellFrames[spellIndex] then
                SpellFrames[spellIndex] = CreateSpellFrame(panel)
            end
            RefreshSpellFrame(SpellFrames[spellIndex], spell, panel, p, function() RefreshSpells(panel) end)
            p = SpellFrames[spellIndex].mainFrame
            p:Show()

            p:SetScript("OnEnter", function(frame)
                MoveButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 360, 0)
                AboveButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 360, 0)
                CancelMoveButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 360, 0)
                SetZoneButton:Show()
                SelectedSpell = spell
                if MovingSpell then
                    ShowAboveAndBelowButtons()
                end
                RefreshSpells(panel)  -- Without this the button becomes unclickable
            end)
            spellIndex = spellIndex + 1
        end
    end
end

local TextItem = "物品"
local TextSpell = "技能"
local TextDungeon = "地下城"
local TextConsumable = "消耗品"

local function CreateSpell(spellType, id, zone)
    if id == "" or zone == "" then
        return
    end

    local spell
    if spellType == TextItem then
        spell = TeleporterCreateItem(id, zone)
    elseif spellType == TextSpell then
        spell = TeleporterCreateSpell(id, zone)
    elseif spellType == TextDungeon then
        spell = TeleporterCreateChallengeSpell(id, zone)
        spell:SetZone(zone)
    elseif spellType == TextConsumable then
        spell = TeleporterCreateConsumable(id, zone)
    else
        return
    end

    spell.isCustom = true

    local extraSpellsAndItems = TeleporterGetOption("extraSpellsAndItems")
    if not extraSpellsAndItems then
        extraSpellsAndItems = {}
    end

    tinsert(extraSpellsAndItems, spell)

    TeleporterSetOption("extraSpellsAndItems", extraSpellsAndItems)

    TeleporterRebuildSpellList()
end

local function CreateSpellCustomiser(panel)
    local scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 3, -80)
    scrollFrame:SetPoint("RIGHT", -27, 4)

    local scrollChild = CreateFrame("Frame", nil, panel)
    scrollFrame:SetScrollChild(scrollChild)
    scrollChild:SetHeight(1)
    panel.scrollChild = scrollChild

    local beginButton = CreateFrame( "Button", nil, panel, "UIPanelButtonTemplate" )
    beginButton:SetPoint("TOPLEFT", panel, "TOPLEFT", 4, -4)
    beginButton:SetText("显示技能列表")
    beginButton:SetWidth(150)
    beginButton:SetScript( "OnClick", function()
        LoadSpells = true
        beginButton:SetText("刷新技能列表")
        RefreshSpells(scrollChild)
    end)

    -- Hide unknown
    local hideUnknownLabel = panel:CreateFontString(nil, nil, "GameFontNormal")
    hideUnknownLabel:SetPoint("TOPLEFT", beginButton, "TOPRIGHT", 4, 0)
    hideUnknownLabel:SetWidth(100)
    hideUnknownLabel:SetHeight(30)
    hideUnknownLabel:SetText("隐藏未知")

    local hideUnknownButton = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
    hideUnknownButton:SetPoint("TOPLEFT", hideUnknownLabel, "TOPRIGHT", 4, 0)
    hideUnknownButton:SetWidth(30)
    hideUnknownButton:SetHeight(30)
    hideUnknownButton:SetScript( "OnClick", function()
        HideUnknown = hideUnknownButton:GetChecked()
        RefreshSpells(scrollChild)
    end)

    -- Sorting
    local sortLabel = panel:CreateFontString(nil, nil, "GameFontNormal")
    sortLabel:SetPoint("TOPLEFT", panel, "TOPLEFT", 4, -40)
    sortLabel:SetWidth(50)
    sortLabel:SetHeight(20)
    sortLabel:SetText("类别")

    local sortText = { "按目标", "按类型", "自定义" }

    local sortFrame = CreateFrame("Frame", nil, panel, "UIDropDownMenuTemplate")
    sortFrame:SetPoint("TOPLEFT", sortLabel, "TOPRIGHT", 0, 4)
    sortFrame:SetWidth(160)
    UIDropDownMenu_Initialize(sortFrame, function()
        for i = 1, #sortText do
            local info = UIDropDownMenu_CreateInfo()
            info.text = sortText[i]
            info.func = function()
                UIDropDownMenu_SetText(sortFrame, sortText[i])
                TeleporterSetOption("sort", i)
                RefreshSpells(scrollChild)
                MoveButton:SetEnabled(i == 3)
                ResetSortButton:SetEnabled(i == 3)
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    local sortMode = TeleporterGetOption("sort") or 1
    UIDropDownMenu_SetText(sortFrame, sortText[sortMode])

    MoveButton = CreateFrame( "Button", nil, scrollChild, "UIPanelButtonTemplate" )
    MoveButton:SetText("移动")
    MoveButton:SetWidth(140)
    MoveButton:SetEnabled(sortMode == 3)
    MoveButton:SetScript( "OnClick", function()
        MovingSpell = SelectedSpell
        ShowAboveAndBelowButtons()
        RefreshSpells(scrollChild)  -- Without this the button is unclickable for some reason
    end)

    AboveButton = CreateFrame( "Button", nil, scrollChild, "UIPanelButtonTemplate" )
    AboveButton:SetText("关于")
    AboveButton:SetWidth(70)
    AboveButton:Hide()
    AboveButton:SetScript( "OnClick", function()
        TeleporterMoveSpellBefore(MovingSpell, SelectedSpell)
        MovingSpell = nil
        ShowMoveButton()
        RefreshSpells(scrollChild)  -- Without this the button is unclickable for some reason
    end)

    BelowButton = CreateFrame( "Button", nil, scrollChild, "UIPanelButtonTemplate" )
    BelowButton:SetText("Below")
    BelowButton:SetWidth(70)
    BelowButton:Hide()
    BelowButton:SetPoint("TOPLEFT", AboveButton, "TOPRIGHT")
    BelowButton:SetScript( "OnClick", function()
        TeleporterMoveSpellAfter(MovingSpell, SelectedSpell)
        MovingSpell = nil
        ShowMoveButton()
        RefreshSpells(scrollChild)  -- Without this the button is unclickable for some reason
    end)

    CancelMoveButton = CreateFrame( "Button", nil, scrollChild, "UIPanelButtonTemplate" )
    CancelMoveButton:SetText("取消移动")
    CancelMoveButton:SetWidth(140)
    CancelMoveButton:Hide()
    CancelMoveButton:SetPoint("TOPLEFT", AboveButton, "TOPRIGHT")
    CancelMoveButton:SetScript( "OnClick", function()
        MovingSpell = nil
        ShowMoveButton()
        RefreshSpells(scrollChild)  -- Without this the button is unclickable for some reason
    end)

    ResetSortButton = CreateFrame( "Button", nil, panel, "UIPanelButtonTemplate" )
    ResetSortButton:SetText("重设类别")
    ResetSortButton:SetWidth(100)
    ResetSortButton:SetPoint("TOPLEFT", sortFrame, "TOPRIGHT", 0, 0)
    ResetSortButton:SetScript( "OnClick", function()
        TeleporterSetOption("sortOrder", {})
        RefreshSpells(scrollChild)
    end)
    ResetSortButton:SetEnabled(sortMode == 3)

    SetZoneButton = CreateFrame( "Button", nil, scrollChild, "UIPanelButtonTemplate" )
    SetZoneButton:SetText("设置区域")
    SetZoneButton:SetPoint("TOPLEFT", MoveButton, "TOPRIGHT", 2, 0)
    SetZoneButton:SetWidth(120)
    SetZoneButton:Hide()
    SetZoneButton:SetScript( "OnClick", function()
        if NewSpellZoneFrame:GetText() == "" then
            print("重置区域名称。使用下面的区域框来指定一个新的区域名称。")
        end
        SelectedSpell:OverrideZoneName(NewSpellZoneFrame:GetText())
        RefreshSpells(scrollChild)
    end)

    -- New spell
    local newSpellTypeFrame = CreateFrame("Frame", nil, panel, "UIDropDownMenuTemplate")
    newSpellTypeFrame:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 4, 4)
    newSpellTypeFrame:SetWidth(160)
    UIDropDownMenu_Initialize(newSpellTypeFrame, function()
        local info = UIDropDownMenu_CreateInfo()

        info.text = TextItem
        info.func = function()
            UIDropDownMenu_SetText(newSpellTypeFrame, TextItem)
        end
        UIDropDownMenu_AddButton(info)

        info.text = TextSpell
        info.func = function()
            UIDropDownMenu_SetText(newSpellTypeFrame, TextSpell)
        end
        UIDropDownMenu_AddButton(info)

        info.text = TextConsumable
        info.func = function()
            UIDropDownMenu_SetText(newSpellTypeFrame, TextConsumable)
        end
        UIDropDownMenu_AddButton(info)

        info.text = TextDungeon
        info.func = function()
            UIDropDownMenu_SetText(newSpellTypeFrame, TextDungeon)
        end
        UIDropDownMenu_AddButton(info)
    end)

    local idLabel = panel:CreateFontString(nil, nil, "GameFontNormal")
    idLabel:SetPoint("TOPLEFT", newSpellTypeFrame, "TOPRIGHT", 0, 0)
    idLabel:SetHeight(25)
    idLabel:SetWidth(20)
    idLabel:SetText("ID:")

    local newSpellIdFrame = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
    newSpellIdFrame:SetPoint("TOPLEFT", idLabel, "TOPRIGHT", 4, 0)
    newSpellIdFrame:SetPoint("BOTTOMLEFT", idLabel, "BOTTOMRIGHT", 4, 0)
    newSpellIdFrame:SetWidth(100)
    newSpellIdFrame:SetAutoFocus(false)
    newSpellIdFrame:SetMultiLine(false)

    local zoneLabel = panel:CreateFontString(nil, nil, "GameFontNormal")
    zoneLabel:SetPoint("TOPLEFT", newSpellIdFrame, "TOPRIGHT", 5, 0)
    zoneLabel:SetHeight(25)
    zoneLabel:SetText("区域：")

    NewSpellZoneFrame = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
    NewSpellZoneFrame:SetPoint("TOPLEFT", zoneLabel, "TOPRIGHT", 4, 0)
    NewSpellZoneFrame:SetPoint("BOTTOMLEFT", zoneLabel, "BOTTOMRIGHT", 4, 0)
    NewSpellZoneFrame:SetWidth(100)
    NewSpellZoneFrame:SetAutoFocus(false)
    NewSpellZoneFrame:SetMultiLine(false)

    local createButton = CreateFrame( "Button", nil, panel, "UIPanelButtonTemplate" )
    createButton:SetPoint("TOPLEFT", NewSpellZoneFrame, "TOPRIGHT", 4, 0)
    createButton:SetPoint("BOTTOMLEFT", NewSpellZoneFrame, "BOTTOMRIGHT", 4, 0)
    createButton:SetText("创建")
    createButton:SetWidth(150)
    createButton:SetScript( "OnClick", function()
        CreateSpell(UIDropDownMenu_GetText(newSpellTypeFrame), newSpellIdFrame:GetText(), NewSpellZoneFrame:GetText())
        RefreshSpells(scrollChild)
    end)

    scrollFrame:SetPoint("BOTTOM", newSpellTypeFrame, "TOP", -27, 10)

    panel.refresh = function()
       RefreshSpells(scrollChild)
    end
end

if GetLocale() == "zhCN" then
  TomeofTeleportationLocal = "|cffe6cc80[传送]|r助手合辑";
elseif GetLocale() == "zhTW" then
  TomeofTeleportationLocal = "|cffe6cc80[传送]|r助手合辑";
else
  TomeofTeleportationLocal = "TomeofTeleportation";
end

function TeleporterSettings_OnLoad()
    TeleporterSettings.settingsPanel = CreateFrame("Frame")
	TeleporterSettings.settingsPanel.name = TomeofTeleportationLocal
    TeleporterSettings.settingsPanel.refresh = RefreshSettings
    TeleporterSettings.settingsPanel.OnCommit = TeleporterSettings.settingsPanel.okay;
	TeleporterSettings.settingsPanel.OnDefault = TeleporterSettings.settingsPanel.default;
	TeleporterSettings.settingsPanel.OnRefresh = TeleporterSettings.settingsPanel.refresh;
    CreateSettings(TeleporterSettings.settingsPanel)

    local category = Settings.RegisterCanvasLayoutCategory(TeleporterSettings.settingsPanel, TeleporterSettings.settingsPanel.name, TeleporterSettings.settingsPanel.name);
    category.ID = TeleporterSettings.settingsPanel.name;
    Settings.RegisterAddOnCategory(category);

    TeleporterSettings.spellsPanel = CreateFrame("Frame")
	TeleporterSettings.spellsPanel.name = "自定义传送门"
    TeleporterSettings.spellsPanel.parent = TeleporterSettings.settingsPanel.name
    TeleporterSettings.spellsPanel.OnCommit = TeleporterSettings.spellsPanel.okay;
	TeleporterSettings.spellsPanel.OnDefault = TeleporterSettings.spellsPanel.default;
	TeleporterSettings.spellsPanel.OnRefresh = TeleporterSettings.spellsPanel.refresh;
    CreateSpellCustomiser(TeleporterSettings.spellsPanel)

    local customizeName = "自定义传送门"
    local subcategory = Settings.RegisterCanvasLayoutSubcategory(category, TeleporterSettings.spellsPanel, TeleporterSettings.spellsPanel.name, TeleporterSettings.spellsPanel.name);
	subcategory.ID = TeleporterSettings.spellsPanel.name;
end

function TeleporterOpenSettings()
    Settings.OpenToCategory(TeleporterSettings.settingsPanel.name);
end
-- Tome of Teleportation by Remeen.

-- TODO:
-- Improve speed
-- Optional compact UI

-- Known issues:
-- Overlapping buttons
-- Special case strings start with number to force them to be sorted first.
TeleporterHearthString = "0 炉石"
TeleporterRecallString = "1 星界传送"
TeleporterFlightString = "2 飞行管理员"

local DungeonsTitle = "地下城"

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local icon = LibStub("LibDBIcon-1.0")
--[[local dataobj = ldb:NewDataObject("TomeTele", {
	label = TOMEOFTELEPORTATIONTITLE, 
	type = "data source", 
	icon = "Interface\\Icons\\Spell_arcane_portalshattrath",  --Interface\\Icons\\Spell_Arcane_TeleportDalaran
	text = "Teleport"
})]]

local TeleporterParentFrame = nil
local CastSpell = nil
local ItemSlot = nil
local OldItems = {}
local RemoveItem = {}
local ButtonSettings = {}
local OrderedButtonSettings = {}
local IsVisible = false
local NeedUpdate = false
local OpenTime = 0
local ShouldNotBeEquiped = {}
local ShouldBeEquiped = {}
local EquipTime = 0
local CustomizeSpells = false
local RemoveIconOffset = 0
local ShowIconOffset = 0
local SortUpIconOffset = 0
local SortDownIconOffset = 0
local AddItemButton = nil
local AddSpellButton = nil
local ChosenHearth = nil
local IsRefreshing = nil

BINDING_NAME_TOMEOFTELEPORTATION = TOMEOFTELEPORTATIONTITLE
_G["BINDING_NAME_TOMEOFTELEPORTATIONSHOW"] = "    "..TOMEOFTELEPORTATIONTITLE

local InvTypeToSlot = 
{	
	["INVTYPE_HEAD"] = 1,
	["INVTYPE_NECK"] = 2,
	["INVTYPE_SHOULDER"] = 3,
	["INVTYPE_BODY"] = 4,
	["INVTYPE_CHEST"] = 5,
	["INVTYPE_ROBE"] = 5,
	["INVTYPE_WAIST"] = 6,
	["INVTYPE_LEGS"] = 7,
	["INVTYPE_FEET"] = 8,
	["INVTYPE_WRIST"] = 9,
	["INVTYPE_HAND"] = 10,
	["INVTYPE_FINGER"] = 11,
	["INVTYPE_TRINKET"] = 13,
	["INVTYPE_CLOAK"] = 15,
	["INVTYPE_2HWEAPON"] = 16,
	["INVTYPE_WEAPONMAINHAND"] = 16,
	["INVTYPE_TABARD"] = 19
}

local SortByDestination = 1
local SortByType = 2
local SortCustom = 3

local DefaultOptions = 
{
	["scale"] = 1.25, 
	["buttonHeight"] = 26,
	["buttonWidth"] = 128,
	["labelHeight"] = 16,
	["maximumHeight"] = 520,
	["heightScalePercent"] = 100,
	["fontHeight"] = 10,
	["buttonInset"] = 12,
	["showHelp"] = false,
	["background"] = "Interface/DialogFrame/UI-DialogBox-Gold-Background",
	["edge"] = "Interface/DialogFrame/UI-DialogBox-Border",
	["backgroundR"] = 0,
	["backgroundG"] = 0,
	["backgroundB"] = 0,
	["backgroundA"] = 0.8,
	["frameEdgeSize"] = 16,
	["showTitle"] = true,
	["titleBackground"] = "Interface/DialogFrame/UI-DialogBox-Header",
	["titleFont"] = "GameFontNormalSmall",
	["titleWidth"] = 280,
	["titleHeight"] = 50,
	["titleOffset"] = 12,
	["buttonFont"] = GameFontNormal:GetFont(),
	["buttonBackground"] = "Interface/Tooltips/UI-Tooltip-Background",
	["buttonEdge"] = "Interface/Tooltips/UI-Tooltip-Border",
	["buttonEdgeSize"] = 16,
	["buttonTileSize"] = 16,
	["readyColourR"] = 0,
	["readyColourG"] = 0.6,
	["readyColourB"] = 0,
	["unequipedColourR"] = 1,
	["unequipedColourG"] = 0,
	["unequipedColourB"] = 0,
	["cooldownColourR"] = 1,
	["cooldownColourG"] = 0.7,
	["cooldownColourB"] = 0,
	["cooldownBarInset"] = 4,
	["disabledColourR"] = 0.5,
	["disabledColourG"] = 0.5,
	["disabledColourB"] = 0.5,
	["sortUpIcon"] = "Interface/Icons/misc_arrowlup",
	["sortDownIcon"] = "Interface/Icons/misc_arrowdown",
	["showButtonIcon"] = "Interface/Icons/levelupicon-lfd",
	["removeButtonIcon"] = "Interface/Icons/INV_Misc_Bone_Skull_03",
	["conciseDungeonSpells"] = 1,
	["showSearch"] = false,
	["searchHidden"] = 1,
}
	

---------------------------------------------------------------

local ItemsFound = {}
local EmulateSlowServer = false

-- Emulating slow server.
local function GetCachedItemInfo(itemId)
	if EmulateSlowServer then
		if ItemsFound[itemId] == nil then
			ItemsFound[itemId] = true
			return nil
		else
			return GetItemInfo(itemId)
		end
	else
		return GetItemInfo(itemId)
	end
end
	
-- [Orignal spell ID] = { Alt spell ID, Buff }
-- Currently unused
local SpellBuffs =
{
	--[126892] = { 126896, 126896 }	-- Zen Pilgrimage / Zen Pilgrimage: Return
}

local TeleporterSpells = {}

local function GetOption(option)
	local value = nil
		if ShiGuangPerDB then
			value = ShiGuangPerDB[option]
		end
	
	if value == nil then
			return DefaultOptions[option]
	else
		return value
	end
end

function TeleporterGetOption(option)
	return GetOption(option)
end

function TeleporterIsOptionModified(option)
	local value = nil
	if ShiGuangPerDB then
			value = ShiGuangPerDB[option]
	end

	if value ~= nil then
		return true
	else
		return false
	end
end

local function GetScale()
	return GetOption("scale") * UIParent:GetEffectiveScale()
end

local function GetScaledOption(option)
	return GetOption(option) * GetScale()
end

local function SetOption(option, value)
		ShiGuangPerDB[option] = value
end


function TeleporterSetOption(option, value)
	local oldValue = GetOption(option)
	local isSame = value == oldValue
	if type(value) == "number" and type(oldValue) == "number" then
		isSame = math.abs(value - oldValue) < 0.0001
	end

	if not isSame then
		SetOption(option, value)
	end
end

function Teleporter_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" then
		local loadedAddon = ...
		if string.upper(loadedAddon) == string.upper("_ShiGuang") then
			Teleporter_OnAddonLoaded()
		end
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		local player, guid, spell = ...
		if player == "player" then
			if C_Spell and C_Spell.GetSpellInfo then
				if C_Spell.GetSpellInfo(spell).name == CastSpell then
					TeleporterClose()
				end
			else
				if GetSpellInfo(spell) == CastSpell then
					TeleporterClose()
				end
			end
		end
	elseif event == "UNIT_INVENTORY_CHANGED" then
		if IsVisible then
			TeleporterUpdateAllButtons()
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		-- Can't close while in combat due to secure buttons, so disable Esc key
		if TeleporterParentFrame then
			local frameIndex = TeleporterFindInSpecialFrames()
			if frameIndex then
				tremove(UISpecialFrames,frameIndex);
			end
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		if TeleporterParentFrame then
			if not TeleporterFindInSpecialFrames() then
				tinsert(UISpecialFrames,TeleporterParentFrame:GetName());
			end
		end
	elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" or event == "ZONE_CHANGED_INDOORS" then
		TeleporterCheckItemsWereEquiped()
	end
end

function TeleporterFindInSpecialFrames()
	for i,f in ipairs(UISpecialFrames) do
		if f == TeleporterParentFrame:GetName() then
			return i
		end
	end
	return nil
end

local function RebuildSpellList()
	TeleporterSpells = {}
	for i,spell in ipairs(TeleporterDefaultSpells) do
		tinsert(TeleporterSpells, spell)
	end

	local extraSpells = GetOption("extraSpells")
	if extraSpells then
		for id,dest in pairs(extraSpells) do
			local spell = TeleporterCreateSpell(id,dest)
			spell.isCustom = true
			tinsert(TeleporterSpells, spell)
		end
	end

	local extraItems = GetOption("extraItems")
	if extraItems then
		for id,dest in pairs(extraItems) do
			local spell = TeleporterCreateItem(id,dest)
			spell.isCustom = true
			tinsert(TeleporterSpells, spell)
		end
	end

	local extraSpellsAndItems = GetOption("extraSpellsAndItems")
	if extraSpellsAndItems then
		for index = #extraSpellsAndItems,1,-1 do
			local spell = extraSpellsAndItems[index]
			local isDuplicate = false
			for id2, spell2 in ipairs(TeleporterSpells) do
				if spell2:Equals(spell) then
					isDuplicate = true
					table.remove(extraSpellsAndItems, index)
				end
			end
			if not isDuplicate then
				TeleporterInitSpell(spell)
				tinsert(TeleporterSpells, spell)
			end
		end
	end
end

function TeleporterRebuildSpellList()
	RebuildSpellList()
end

function Teleporter_OnLoad() 
	SlashCmdList["TELEPORTER"] = TeleporterFunction
	SLASH_TELEPORTER1 = "/tomeofteleport"
	SLASH_TELEPORTER2 = "/tele"

	SlashCmdList["TELEPORTEREQUIP"] = TeleporterEquipSlashCmdFunction
	SLASH_TELEPORTEREQUIP1 = "/teleporterequip"

	SlashCmdList["TELEPORTERUSEITEM"] = TeleporterUseItemSlashCmdFunction
	SLASH_TELEPORTERUSEITEM1 = "/teleporteruseitem"

	SlashCmdList["TELEPORTERCASTSPELL"] = TeleporterCastSpellSlashCmdFunction
	SLASH_TELEPORTERCASTSPELL1 = "/teleportercastspell"

	SlashCmdList["TELEPORTERCREATEMACRO"] = TeleporterCreateMacroSlashCmdFunction
	SLASH_TELEPORTERCREATEMACRO1 = "/teleportercreatemacro"

	if TeleporterSettings_OnLoad then
		TeleporterSettings_OnLoad()
	end
end

local function SavePosition()
	local points = {}
	for i = 1,TeleporterParentFrame:GetNumPoints(),1 do
		tinsert(points,{TeleporterParentFrame:GetPoint(i)})
	end
	SetOption("points", points)
end


local function Refresh()
	if IsVisible then
		IsRefreshing = true
		TeleporterClose()
		TeleporterOpenFrame()
		IsRefreshing = false
	end
end

local TeleporterMenu = nil
local TeleporterOptionsMenu = nil

local function SortSpells(spell1, spell2, sortType)
	local spellId1 = spell1.spellId
	local spellId2 = spell2.spellId
	local spellName1 = spell1.spellName
	local spellName2 = spell2.spellName
	local spellType1 = spell1.spellType
	local spellType2 = spell2.spellType
	local zone1 = spell1:GetZone()
	local zone2 = spell2:GetZone()

	if GetOption("groupDungeons") then
		if spell1:IsDungeonSpell() then zone1 = DungeonsTitle end
		if spell2:IsDungeonSpell() then zone2 = DungeonsTitle end
	end
	
	local so = GetOption("sortOrder") or {}
	
	if sortType == SortCustom then
		local optId1 = spell1:GetOptionId()
		local optId2 = spell2:GetOptionId()
		-- New spells always sort last - not ideal, but makes it easier to have a deterministic sort.
		if so[optId1] and so[optId2] then
			return so[optId1] < so[optId2]			
		elseif so[optId1] then
			return true
		elseif so[optId2] then
			return false
		end
	elseif sortType == SortByType then
		if spellType1 ~= spellType2 then
			return spellType1 < spellType2
		end
	end

	if zone1 ~= zone2 then
		return zone1 < zone2
	end
	
	return spellName1 < spellName2
end

function TeleporterGetSearchString()
	if GetOption("showSearch") then
		local searchString = TeleporterSearchBox:GetText()
		if searchString == "" then
			return nil
		else
			return searchString
		end
	else
		return nil
	end
end

local function SetupSpells()
	local loaded = true
	for index, spell in ipairs(TeleporterSpells) do
		if spell:IsItem() then
			spell.spellName = GetCachedItemInfo( spell.spellId )
		else
			if C_Spell and C_Spell.GetSpellInfo then
				spell.spellName = C_Spell.GetSpellInfo( spell.spellId).name
			else
				spell.spellName = GetSpellInfo( spell.spellId)
			end
		end

		if not spell.spellName then
			spell.spellName = "<Loading>"
			if spell:CanUse() then
				loaded = false
			end
		end
		
		spell.isItem = spell:IsItem()
	end
	
	return loaded
end

local function GetSortedFavourites(favourites)
	SetupSpells()
	
	local sorted = {}
	local index = 1

	for spellId, isItem in pairs(favourites) do
		for i,spell in ipairs(TeleporterSpells) do
			if spell.spellId == spellId then
				sorted[index] = spell
				index = index + 1
				break
			end
		end		
	end
	
	local sortType = GetOption("sort")
	table.sort(sorted, function(a,b) return SortSpells(a, b, sortType) end)
	
	return sorted
end

function TeleporterItemMustBeEquipped(item)
	if IsEquippableItem( item ) then
		return not IsEquippedItem ( item )
	else
		return false
	end
end


local function SafeGetItemCooldown(itemId)
	if GetItemCooldown ~= nil then
		return GetItemCooldown(itemId)
	else
		return C_Container.GetItemCooldown(itemId)
	end
end

function TeleporterUpdateButton(button)
	if UnitAffectingCombat("player") then return end

	local settings = ButtonSettings[button]
	local isItem = settings.isItem
	
	local item = settings.spellName
	local cooldownbar = settings.cooldownbar
	local cooldownString = settings.cooldownString
	local itemId = settings.spellId
	local countString = settings.countString
	local toySpell = settings.toySpell
	local spell = settings.spell
	local onCooldown = false
	local buttonInset = GetScaledOption("buttonInset")
	
	if item then
		local cooldownStart, cooldownDuration
		if isItem then
			cooldownStart, cooldownDuration = SafeGetItemCooldown(itemId)
		else
			if C_Spell and C_Spell.GetSpellCooldown then
				local spellCooldownInfo = C_Spell.GetSpellCooldown(itemId);
				cooldownStart = spellCooldownInfo.startTime
				cooldownDuration = spellCooldownInfo.duration
			else
				cooldownStart, cooldownDuration = GetSpellCooldown(itemId)
			end
		end

		if cooldownStart and cooldownStart > 0 then
			if GetTime() < cooldownStart then
				-- Long cooldowns seem to be reported incorrectly after a server reset.  Looks like the
				-- time is taken from a 32 bit unsigned int.
				cooldownStart = cooldownStart - 4294967.295
			end

			onCooldown = true
			local durationRemaining = cooldownDuration - ( GetTime() - cooldownStart )

			if durationRemaining < 0 then
				durationRemaining = 0
			end
			if durationRemaining > cooldownDuration then
				durationRemaining = cooldownDuration
			end
			
			local parentWidth = button:GetWidth()
			local inset = GetOption("cooldownBarInset") * 2
			cooldownbar:SetWidth( inset + ( parentWidth - inset ) * durationRemaining / cooldownDuration )
			
			if durationRemaining > 3600 then
				cooldownString:SetText(string.format("%.0fh", durationRemaining / 3600))
			elseif durationRemaining > 60 then
				cooldownString:SetText(string.format("%.0fm", durationRemaining / 60))
			else
				cooldownString:SetText(string.format("%.0fs", durationRemaining))
			end
			
			cooldownbar:SetBackdropColor(1, 1, 1, 1)
		else			
			cooldownString:SetText("")
			cooldownbar:SetWidth( 1 )
			cooldownbar:SetBackdropColor(0, 0, 0, 0)
		end		
		
		cooldownString:SetPoint("TOPLEFT",button,"TOPRIGHT",-cooldownString:GetStringWidth()*1.1-buttonInset-2,-buttonInset)
		cooldownString:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-buttonInset - 2,6)
		
		if countString and isItem then
			countString:SetText(GetItemCount(itemId, false, true))
		end

		if CustomizeSpells then
			local alpha = 1
			if not spell:IsVisible() then
				alpha = 0.5
			end
			button.backdrop:SetBackdropColor(GetOption("disabledColourR"), GetOption("disabledColourG"), GetOption("disabledColourB"), alpha)
			button:SetAttribute("macrotext", nil)
		elseif isItem and TeleporterItemMustBeEquipped( item ) then 
			button.backdrop:SetBackdropColor(GetOption("unequipedColourR"), GetOption("unequipedColourG"), GetOption("unequipedColourB"), 1)

			button:SetAttribute(
				"macrotext",
				"/teleporterequip " .. item)
		elseif onCooldown then
			if cooldownDuration >2 then
				button.backdrop:SetBackdropColor(GetOption("cooldownColourR"), GetOption("cooldownColourG"), GetOption("cooldownColourB"), 1)
			else
				button.backdrop:SetBackdropColor(GetOption("readyColourR"), GetOption("readyColourG"), GetOption("readyColourB"), 1)
			end
			button:SetAttribute(
				"macrotext",
				"/script print( \"" .. item .. " is currently on cooldown.\")")
		else
			button.backdrop:SetBackdropColor(GetOption("readyColourR"), GetOption("readyColourG"), GetOption("readyColourB"), 1)
			
			if toySpell then		
				button:SetAttribute(
					"macrotext",
					"/teleportercastspell " .. toySpell .. "\n" ..
					"/cast " .. item .. "\n" )
			elseif isItem then
				button:SetAttribute(
					"macrotext",
					"/teleporteruseitem " .. item .. "\n" ..
					"/use " .. item .. "\n" )
			else
				button:SetAttribute(
					"macrotext",
					"/teleportercastspell " .. item .. "\n" ..
					"/cast " .. item .. "\n" )
			end
		end
	end	
end

function TeleporterUpdateAllButtons()	
	for button, settings in pairs(ButtonSettings) do
		TeleporterUpdateButton( button )
	end
end

function TeleporterShowItemTooltip( item, button )
	local _,link = GetCachedItemInfo(item)
	if link then
		GameTooltip:SetOwner(button, "ANCHOR_BOTTOMRIGHT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
end

function TeleporterShowSpellTooltip( item, button )
	local link
	if C_Spell and C_Spell.GetSpellLink then
		link = C_Spell.GetSpellLink(item)
	else
		link = GetSpellLink(item)
	end
	if link then
		GameTooltip:SetOwner(button, "ANCHOR_BOTTOMRIGHT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
end

local function ApplyResort()
	local newSo = {}
	
	for index, spell in ipairs(TeleporterSpells) do		
		local optId = spell:GetOptionId()
		newSo[optId] = index
	end
		
	SetOption("sortOrder", newSo)
end

local function RebuildCustomSort()
	SetupSpells()
	local oldSo = GetOption("sortOrder")
	
	table.sort(TeleporterSpells, function(a, b) return SortSpells(a, b, SortCustom) end)
	
	ApplyResort()
end

local function OnClickShow(spell)
	local showSpells = GetOption("showSpells")
	showSpells[spell:GetOptionId()] = not spell:IsVisible()
end

local function OnClickSortUp(spell)
	RebuildCustomSort()
	
	local so = GetOption("sortOrder")
	local id = spell:GetOptionId()	
	if so[id] and so[id] > 1 then
		local potentialPos = so[id] - 1
		while potentialPos > 0 do
			local spellToSwap = TeleporterSpells[potentialPos]
			TeleporterSpells[potentialPos] = spell
			TeleporterSpells[potentialPos+1] = spellToSwap
			if spellToSwap:CanUse() then
				break
			end
			potentialPos = potentialPos - 1
		end
	end
	
	ApplyResort()
	
	Refresh()
end

function RenormalizeCustomSort()
	RebuildCustomSort()

	local so = GetOption("sortOrder")

	for i = 1, #TeleporterSpells do
		local id = TeleporterSpells[i]:GetOptionId()
		so[id] = i
	end

	RebuildCustomSort()
end

function TeleporterMoveSpellBefore(movingSpell, destSpell)
	RebuildCustomSort()
	
	local so = GetOption("sortOrder")
	local movingId = movingSpell:GetOptionId()
	local destId = destSpell:GetOptionId()	
	
	so[movingId] = so[destId] - 0.5
	
	RenormalizeCustomSort()
end

function TeleporterMoveSpellAfter(movingSpell, destSpell)
	RebuildCustomSort()
	
	local so = GetOption("sortOrder")
	local movingId = movingSpell:GetOptionId()	
	local destId = destSpell:GetOptionId()	
	
	so[movingId] = so[destId] + 0.5
	
	RenormalizeCustomSort()
end

function TeleporterResetSort()
	SetOption("sortOrder", {})
	RebuildCustomSort()
end


local function OnClickSortDown(spell)
	RebuildCustomSort()
	
	local so = GetOption("sortOrder")
	local id = spell:GetOptionId()	
	if so[id] and so[id] < #TeleporterSpells then
		local potentialPos = so[id] + 1
		while potentialPos <= #TeleporterSpells do
			local spellToSwap = TeleporterSpells[potentialPos]
			TeleporterSpells[potentialPos] = spell
			TeleporterSpells[potentialPos-1] = spellToSwap
			if spellToSwap:CanUse() then
				break
			end
			potentialPos = potentialPos + 1
		end
	end
	
	ApplyResort()
	
	Refresh()
end

local function OnClickRemove(spell)
	local dialogText = "Are you sure you want to remove " .. spell.spellName .. "?"
	
	StaticPopupDialogs["TELEPORTER_CONFIRM_REMOVE"] = 
	{
		text = dialogText,
		button1 = "Yes",
		button2 = "No",
		OnAccept = function() 
			if spell:IsItem() then
				GetOption("extraItems")[spell.spellId] = nil
			else
				GetOption("extraSpells")[spell.spellId] = nil
			end
			RebuildSpellList()
			Refresh()
		end,
		OnCancel = function() end,
		hideOnEscape = true
	}
	
	StaticPopup_Show("TELEPORTER_CONFIRM_REMOVE")
end

local function AddCustomizationIcon(existingIcon, buttonFrame, showAboveFrame, xOffset, yOffset, width, height, optionName, onClick, forceHidden)
	local iconObject = existingIcon
	if not iconObject then		
		iconObject = {}
		iconObject.icon = showAboveFrame:CreateTexture()
		-- Invisible frame use for button notifications
		iconObject.frame = TeleporterCreateReusableFrame("Frame","TeleporterIconFrame",showAboveFrame)	
	end
	
	if iconObject.icon then
		iconObject.icon:SetPoint("TOPRIGHT",buttonFrame,"TOPRIGHT", xOffset, yOffset)
		iconObject.icon:SetTexture(GetOption(optionName))
		
		iconObject.icon:SetWidth(width)
		iconObject.icon:SetHeight(height)
		
		iconObject.frame:SetPoint("TOPRIGHT",buttonFrame,"TOPRIGHT", xOffset, yOffset)
		iconObject.frame:SetWidth(width)
		iconObject.frame:SetHeight(height)
		
		if CustomizeSpells and not forceHidden then
			iconObject.icon:Show()
			iconObject.frame:Show()
		else
			iconObject.icon:Hide()
			iconObject.frame:Hide()
		end
		
		iconObject.frame:SetScript("OnMouseUp", onClick)	
	end
	
	return iconObject
end


local function InitalizeOptions()
	if not ShiGuangPerDB["showSpells"] then ShiGuangPerDB["showSpells"] = {} end
	if not ShiGuangPerDB["alwaysShowSpells"] then ShiGuangPerDB["alwaysShowSpells"] = {} end
	if not ShiGuangPerDB["sortOrder"] then ShiGuangPerDB["sortOrder"] = {} end
	if not ShiGuangPerDB["randomHearth"] then ShiGuangPerDB["randomHearth"] = true end	
end

local IsAdding = false

local function FinishAddingItem(dialog, isItem, id)
	IsAdding = false
	
	if isItem then
		local extraItems = GetOption("extraItems")
		if not extraItems then
			extraItems = {}
			SetOption("extraItems", extraItems)
		end
		extraItems[id] = dialog.editBox:GetText()
	else
		local extraSpells = GetOption("extraSpells")
		if not extraSpells then
			extraSpells = {}
			SetOption("extraSpells", extraSpells)
		end
		extraSpells[id] = dialog.editBox:GetText()
	end
	
	RebuildSpellList()
	Refresh()
end

local function ShowSelectDestinationUI(dialog, isItem)
	local id = dialog.editBox:GetText()
	local name
	if isItem then
		name = GetCachedItemInfo(id)
	else
		if C_Spell and C_Spell.GetSpellInfo then
			name = C_Spell.GetSpellInfo(id).name
		else
			name = GetSpellInfo(id)
		end
	end
	
	if name then
		local dialogText = "Adding " .. name .. ".\nWhat zone does it teleport to?"
		
		StaticPopupDialogs["TELEPORTER_ADDITEM_DEST"] = 
		{
			text = dialogText,
			button1 = "OK",
			button2 = "Cancel",
			OnAccept = function(dialog) FinishAddingItem(dialog, isItem, id) end,
			OnCancel = function() IsAdding = false; end,
			hideOnEscape = true,
			hasEditBox = true
		}
		
		StaticPopup_Show("TELEPORTER_ADDITEM_DEST")
	else
		local dialogText
		
		if isItem then
			dialogText = "Could not find an item with this ID."
		else
			dialogText = "Could not find a spell with this ID."
		end
		
		StaticPopupDialogs["TELEPORTER_ADDITEM_FAIL"] = 
		{
			text = dialogText,
			button1 = "OK",
			OnAccept = function() IsAdding = false; end,
			OnCancel = function() IsAdding = false; end,
			hideOnEscape = true
		}
		
		StaticPopup_Show("TELEPORTER_ADDITEM_FAIL")
	end
	
	
end

local function ShowAddItemUI(isItem)
	local dialogText
	
	if IsAdding then return end
	
	IsAdding = true
	
	if isItem then
		dialogText = "Enter the item ID. You can get this from wowhead.com."
	else
		dialogText = "Enter the spell ID. You can get this from wowhead.com."
	end
	
	StaticPopupDialogs["TELEPORTER_ADDITEM"] = 
	{
		text = dialogText,
		button1 = "OK",
		button2 = "Cancel",
		OnAccept = function(dialog) ShowSelectDestinationUI(dialog, isItem) end,
		OnCancel = function() IsAdding = false; end,
		hideOnEscape = true,
		hasEditBox = true
	}
	
	StaticPopup_Show("TELEPORTER_ADDITEM")
end

local function GetMaximumHeight()
	return GetScaledOption("maximumHeight") * GetOption("heightScalePercent") / 100
end

local function UpdateSearch(searchString)
	if  UnitAffectingCombat("player") then
		print("Cannot search while in combat")
	else
		IsRefreshing = true
		TeleporterHideCreatedUI()
		TeleporterOpenFrame(true)
		IsRefreshing = false
	end
end

local function CreateMainFrame()
	TeleporterParentFrame = TeleporterFrame
	TeleporterParentFrame:SetFrameStrata("HIGH")

	local buttonHeight = GetScaledOption("buttonHeight")
	local buttonWidth = GetScaledOption("buttonWidth")
	local labelHeight = GetScaledOption("labelHeight")
	local numColumns = 1
	local lastDest = nil
	local fontHeight = GetScaledOption("fontHeight")
	local frameEdgeSize = GetOption("frameEdgeSize")
	local fontFile = GetOption("buttonFont")
	local fontFlags = nil
	local titleWidth = GetScaledOption("titleWidth")
	local titleHeight = GetScaledOption("titleHeight")
	local buttonInset = GetOption("buttonInset")

	TeleporterParentFrame:ClearAllPoints()
	local points = GetOption("points")
	if points then
		for i,pt in ipairs(points) do
			TeleporterParentFrame:SetPoint(pt[1], pt[2], pt[3], pt[4], pt[5])
		end
	else
		TeleporterParentFrame:SetPoint("RIGHT",-43,43)
	end
				
	tinsert(UISpecialFrames,TeleporterParentFrame:GetName());
	--TeleporterParentFrame:SetScript( "OnHide", TeleporterClose )

	-- Title bar
	TeleporterParentFrame:RegisterForDrag("LeftButton")			
	TeleporterParentFrame:SetScript("OnDragStart", function() TeleporterParentFrame:StartMoving() end )
	TeleporterParentFrame:SetScript("OnDragStop", function() TeleporterParentFrame:StopMovingOrSizing(); SavePosition(); end )
	TeleporterParentFrame:EnableMouse(true)
	TeleporterParentFrame:SetMovable(true)
	TeleporterParentFrame:SetScript("OnMouseUp", OnClickFrame)

	-- Close button
	local closeButton = CreateFrame( "Button", "TeleporterCloseButton", TeleporterParentFrame, "UIPanelButtonTemplate" )
	closeButton:SetText( "X" )
	closeButton:SetPoint( "TOPRIGHT", TeleporterParentFrame, "TOPRIGHT", -buttonInset, -buttonInset )
	closeButton:SetWidth( buttonWidth )
	closeButton:SetHeight( buttonHeight )
	closeButton:SetScript( "OnClick", TeleporterClose )

	-- Search box
	local searchFrame = CreateFrame("EditBox", "TeleporterSearchBox", TeleporterParentFrame, "InputBoxTemplate")
	searchFrame:SetPoint("LEFT", TeleporterParentFrame, "LEFT", buttonInset * 2, 0)
	searchFrame:SetPoint("TOPRIGHT", closeButton, "TOPLEFT", -4, -2)
	searchFrame:SetHeight(buttonHeight)
	searchFrame:SetAutoFocus(false)
	searchFrame:SetMultiLine(false)

	searchFrame:SetScript("OnTextChanged", function(self, userInput)
		if userInput then
			UpdateSearch(searchFrame:GetText())
		end
	end)
	if GetOption("showSearch") then
		searchFrame:Show()
	else
		searchFrame:Hide()
	end

	-- Help text
	if GetOption("showHelp") then
		local helpString = TeleporterParentFrame:CreateFontString("TeleporterHelpString", nil, GetOption("titleFont"))
		helpString:SetFont(fontFile, fontHeight, fontFlags)
		helpString:SetText( "Click to teleport, Ctrl+click to create a macro." )
		helpString:SetJustifyV("MIDDLE")
		helpString:SetJustifyH("LEFT")
	end

	AddItemButton = CreateFrame( "Button", "TeleporterAddItemButton", TeleporterParentFrame, "UIPanelButtonTemplate" )
	AddItemButton:SetText( "Add Item" )
	AddItemButton:SetPoint( "BOTTOMLEFT", TeleporterParentFrame, "BOTTOMLEFT", buttonInset, buttonInset )
	AddItemButton:SetScript( "OnClick", function() ShowAddItemUI(true) end )
	
	AddSpellButton = CreateFrame( "Button", "TeleporterAddSpellButton", TeleporterParentFrame, "UIPanelButtonTemplate" )
	AddSpellButton:SetText( "Add Spell" )
	AddSpellButton:SetPoint( "BOTTOMRIGHT", TeleporterParentFrame, "BOTTOMRIGHT", -buttonInset, buttonInset )
	AddSpellButton:SetScript( "OnClick", function() ShowAddItemUI(false) end )
end

local function GetRandomHearth(validSpells)
	if ChosenHearth then
		return ChosenHearth
	end
	local hearthSpellsFastestCooldown = {}
	local hearthSpellsNotCooldown = {}
	local fastestCooldownEnd = 0
	for index, spell in ipairs(validSpells) do
		if spell:GetZone() == TeleporterHearthString then
			local cooldownStart, cooldownDuration = SafeGetItemCooldown(spell.spellId)
			if cooldownStart and cooldownStart > 0 then
				local cooldownEnd = cooldownStart + cooldownDuration
				if fastestCooldownEnd == 0 or cooldownEnd < fastestCooldownEnd then
					hearthSpellsFastestCooldown = {}
					fastestCooldownEnd = cooldownEnd
				end
				if cooldownEnd == fastestCooldownEnd then
					tinsert(hearthSpellsFastestCooldown, spell.spellId)
				end
			else
				tinsert(hearthSpellsNotCooldown, spell.spellId)
			end
		end
	end
	if  #hearthSpellsNotCooldown > 0 then
		ChosenHearth =  hearthSpellsNotCooldown[math.random(#hearthSpellsNotCooldown)]
		return ChosenHearth
	elseif  #hearthSpellsFastestCooldown > 0 then
		ChosenHearth =  hearthSpellsFastestCooldown[math.random(#hearthSpellsFastestCooldown)]
		return ChosenHearth
	else
		return nil
	end
end

local function FindValidSpells()
	local validSpells = {}
	
	for index, spell in ipairs(TeleporterSpells) do		
		local spellId = spell.spellId
		local spellType = spell.spellType
		local isItem = spell:IsItem()
		local spellName = spell.spellName
		local isValidSpell = true
		local zone = spell:GetZone()
		
		spell.displayDestination = zone
		if zone == TeleporterHearthString or zone == TeleporterRecallString then
			local bindLocation = GetBindLocation()
			if bindLocation then
				spell.displayDestination =  bindLocation 
			else
				spell.displayDestination = "Hearth"
			end
		end
					
		if zone == TeleporterFlightString then
			spell.displayDestination = MINIMAP_TRACKING_FLIGHTMASTER
		end

		if spell:IsDungeonSpell() and GetOption("groupDungeons") then
			spell.displayDestination = DungeonsTitle
		end

		if isItem then
			_, _, _, _, _, _, _, _, _, spell.itemTexture = GetCachedItemInfo( spellId )
			if not spellName then
				isValidSpell = false
			end
		else
			if C_Spell and C_Spell.GetSpellInfo then
				spell.itemTexture = C_Spell.GetSpellInfo(spellId).iconID
			else
				_,_,spell.itemTexture = GetSpellInfo( spellId )
			end
			if not spellName then
				isValidSpell = false
			end
		end
		
		local haveSpell = isValidSpell and spell:CanUse()

		spell.toySpell = nil
		if isItem then
			if C_ToyBox and PlayerHasToy(spellId) then
				spell.toySpell = GetItemSpell(spellId)
			end			
		end
		
		if haveSpell then
			tinsert(validSpells, spell)
		end
	end
	
	return validSpells
end

function TeleporterSortSpells()
	local SortType = GetOption("sort")
	if CustomizeSpells then
		SortType = SortCustom
	end
	table.sort(TeleporterSpells, function(a,b) return SortSpells(a, b, SortType) end)
end

function TeleporterOpenFrame(isSearching)
	if UnitAffectingCombat("player") then
		print( "Cannot use " .. TOMEOFTELEPORTATIONTITLE .. " while in combat." )
		return
	end

	InitalizeOptions()

	if not IsVisible or isSearching then
		local buttonHeight = GetScaledOption("buttonHeight")
		local buttonWidth = GetScaledOption("buttonWidth")
		local labelHeight = GetScaledOption("labelHeight")
		local numColumns = 1
		local lastDest = nil
		local maximumHeight = GetMaximumHeight()
		local fontHeight = GetScaledOption("fontHeight")
		local frameEdgeSize = GetOption("frameEdgeSize")
		local fontFile = GetOption("buttonFont")
		local fontFlags = nil
		local titleWidth = GetScaledOption("titleWidth")
		local titleHeight = GetScaledOption("titleHeight")
		local buttonInset = GetOption("buttonInset")

		local _,_,_,version = GetBuildInfo()
		
		IsVisible = true

		if not IsRefreshing then
			ChosenHearth = nil
		end

		if TeleporterParentFrame == nil then
			CreateMainFrame()			
		end
		
		TeleporterParentFrame.backdropInfo =
			{bgFile = GetOption("background"),
			--edgeFile = GetOption("edge"),
			tile = false, edgeSize = frameEdgeSize,
			insets = { left = buttonInset, right = buttonInset, top = buttonInset, bottom = buttonInset }};
		TeleporterParentFrame:ApplyBackdrop();
		TeleporterParentFrame:SetBackdropColor(
				GetOption("backgroundR"),
				GetOption("backgroundG"),
				GetOption("backgroundB"),
				GetOption("backgroundA"))
		
		-- UI scale may have changed, resize
		TeleporterCloseButton:SetWidth( buttonHeight )
		TeleporterCloseButton:SetHeight( buttonHeight )
		TeleporterCloseButtonText:SetFont(fontFile, fontHeight, fontFlags)
		TeleporterSearchBox:SetHeight(buttonHeight)

		if TeleporterHelpString then
			TeleporterHelpString:SetFont(fontFile, fontHeight, fontFlags)
		end

		local minyoffset = -buttonInset - 10

		local searchString = TeleporterGetSearchString()
		if GetOption("showSearch") then
			TeleporterSearchBox:Show()
			minyoffset = -2 * buttonInset - TeleporterSearchBox:GetHeight()
			maximumHeight = maximumHeight + TeleporterSearchBox:GetHeight() - buttonInset
			searchString = TeleporterSearchBox:GetText()
		else
			TeleporterSearchBox:Hide()
		end

		local yoffset = minyoffset
		local maxyoffset = -yoffset
		local xoffset = buttonInset

		ButtonSettings = {}
		
		if not SetupSpells() then
			NeedUpdate = true
			OpenTime = GetTime()
		end
		
		TeleporterSortSpells()		
		
		local validSpells = FindValidSpells()
		
		local onlyHearth = GetRandomHearth(validSpells)

		local ShowDungeonNames = GetOption("showDungeonNames")

		local spellIndex = 1
		
		for index, spell in ipairs(validSpells) do
			local spellId = spell.spellId
			local spellType = spell.spellType
			local isItem = spell:IsItem()
			local destination = spell.displayDestination
			local consumable = spell.consumable
			local spellName = spell.spellName
			local displaySpellName = spell:CleanupName(spellName, spellType)
			local itemTexture = spell.itemTexture
			local toySpell = spell.toySpell
			
			local haveSpell = true
			if spell:GetZone() == TeleporterHearthString and GetOption("randomHearth") then
				if spellId ~= onlyHearth and not CustomizeSpells then
					haveSpell = false
				end
			end

			if searchString and searchString ~= "" then
				if not spell:MatchesSearch(searchString) then
					haveSpell = false
				end
			end

			if haveSpell then
				-- Add extra column if needed
				local newColumn = false
				if -yoffset > maximumHeight then
					yoffset = minyoffset
					xoffset = xoffset + buttonWidth
					numColumns = numColumns + 1
					newColumn = true
				end

				if spell:IsDungeonSpell() and ShowDungeonNames and spell.dungeon then
					displaySpellName = spell.dungeon
				end
				
				-- Title
				if newColumn or lastDest ~= destination then
					local destString = TeleporterCreateReusableFontString("TeleporterDL", TeleporterParentFrame, "GameFontNormalSmall")
					destString:SetFont(fontFile, fontHeight, fontFlags)
					destString:SetPoint("TOPLEFT", TeleporterParentFrame, "TOPLEFT", xoffset, yoffset)
					destString:SetPoint("BOTTOMRIGHT", TeleporterParentFrame, "TOPLEFT", buttonWidth + xoffset, yoffset - labelHeight)					
					destString:SetText(destination)
					yoffset = yoffset - labelHeight
				end
				lastDest = destination	

				-- Main button
				local buttonFrame = TeleporterCreateReusableFrame("Button","TeleporterB",TeleporterParentFrame,"InsecureActionButtonTemplate")
				--buttonFrame:SetFrameStrata("MEDIUM")
				buttonFrame:SetWidth(buttonWidth)
				buttonFrame:SetHeight(buttonHeight)
				buttonFrame:SetPoint("TOPLEFT",TeleporterParentFrame,"TOPLEFT",xoffset,yoffset)
				if version >= 100000 then
					buttonFrame:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
				end
				yoffset = yoffset - buttonHeight
				
				buttonFrame.backdrop = TeleporterCreateReusableFrame("Frame","TeleporterBD", buttonFrame,"BackdropTemplate")
				buttonFrame.backdrop:SetPoint("TOPLEFT",buttonFrame,"TOPLEFT",0,0)
				buttonFrame.backdrop:SetPoint("BOTTOMRIGHT",buttonFrame,"BOTTOMRIGHT",0,0)
				
				local buttonBorder = 4 * GetScale()
		
				buttonFrame.backdrop.backdropInfo = 
					{bgFile = GetOption("buttonBackground"), 
					--edgeFile = GetOption("buttonEdge"), 
					tile = true, tileSize = GetOption("buttonTileSize"), 
					--edgeSize = GetScaledOption("buttonEdgeSize"), 
					insets = { left = buttonBorder, right = buttonBorder, top = buttonBorder, bottom = buttonBorder }}
				buttonFrame.backdrop:ApplyBackdrop();
				
				buttonFrame:SetAttribute("type", "macro")
				buttonFrame:Show()

				if isItem then
					buttonFrame:SetScript(
						"OnEnter",
						function()
							TeleporterShowItemTooltip( spellId, buttonFrame )
						end )
				else
					buttonFrame:SetScript(
						"OnEnter",
						function()
							TeleporterShowSpellTooltip( spellName, buttonFrame )
						end )
				end

				buttonFrame:SetScript(
					"OnLeave",
					function()
						GameTooltip:Hide()
					end )

				-- Icon
				local iconOffsetX = 6 * GetScale()
				local iconOffsetY = -5 * GetScale()
				local iconW = 1
				local iconH = 1
				
				local teleicon = buttonFrame.TeleporterIcon
				if not teleicon then
					teleicon = buttonFrame.backdrop:CreateTexture()
					buttonFrame.TeleporterIcon = teleicon
				end
				
				if teleicon then
					teleicon:SetPoint("TOPLEFT",buttonFrame,"TOPLEFT", iconOffsetX, iconOffsetY)
					if itemTexture then
						iconW = buttonHeight - 10 * GetScale()
						iconH = buttonHeight - 10 * GetScale()
						teleicon:SetTexture(itemTexture)
					end
					
					teleicon:SetWidth(iconW)
					teleicon:SetHeight(iconH)
				end

				-- Cooldown bar
				local cooldownbar = TeleporterCreateReusableFrame( "Frame", "TeleporterCB", buttonFrame.backdrop, "BackdropTemplate" )
				--cooldownbar:SetFrameStrata("MEDIUM")
				cooldownbar:SetWidth(64)
				cooldownbar:SetHeight(buttonHeight)
				cooldownbar:SetPoint("TOPLEFT",buttonFrame,"TOPLEFT",0,0)
				local cdOffset = GetOption("cooldownBarInset")
				cooldownbar.backdropInfo = {bgFile = "Interface/Tooltips/UI-Tooltip-Background",insets = { left = cdOffset, right = cdOffset, top = cdOffset - 1, bottom = cdOffset - 1 }}
				cooldownbar:ApplyBackdrop()

				-- Cooldown label
				local cooldownString = TeleporterCreateReusableFontString("TeleporterCL", cooldownbar, "GameFontNormalSmall")
				cooldownString:SetFont(fontFile, fontHeight, fontFlags)
				cooldownString:SetJustifyH("RIGHT")
				cooldownString:SetJustifyV("MIDDLE")
				cooldownString:SetPoint("TOPLEFT",buttonFrame,"TOPRIGHT",-50,-buttonInset - 2)
				cooldownString:SetPoint("BOTTOMRIGHT",buttonFrame,"BOTTOMRIGHT",-buttonInset - 2,6)
				
				-- Name label
				local nameString = TeleporterCreateReusableFontString("TeleporterSNL", cooldownbar, "GameFontNormalSmall")
				nameString:SetFont(fontFile, fontHeight, fontFlags)
				nameString:SetJustifyH("LEFT")
				nameString:SetJustifyV("MIDDLE")
				nameString:SetPoint("TOPLEFT", teleicon, "TOPRIGHT", 2, 0)
				if CustomizeSpells then
					nameString:SetPoint("BOTTOMRIGHT",cooldownString,"BOTTOMLEFT",-iconW * 4,0)
				else
					nameString:SetPoint("RIGHT",cooldownString,"LEFT",0,0)
					nameString:SetPoint("BOTTOM",teleicon,"BOTTOM",0,0)
				end
				nameString:SetText( displaySpellName )
				
				-- Count label
				local countString = nil
				if consumable then
					countString = TeleporterCreateReusableFontString("TeleporterCT", cooldownbar, "SystemFont_Outline_Small")
					countString:SetJustifyH("RIGHT")
					countString:SetJustifyV("MIDDLE")
					countString:SetPoint("TOPLEFT",cooldownbar,"TOPLEFT",iconOffsetX,iconOffsetY)
					countString:SetPoint("BOTTOMRIGHT", cooldownbar, "TOPLEFT", iconOffsetX + iconW, iconOffsetY - iconH - 2)
					countString:SetText("")
				end
			
				if -yoffset > maxyoffset then
					maxyoffset = -yoffset
				end
				
				RemoveIconOffset = -iconOffsetX - iconW * 3
				ShowIconOffset = -iconOffsetX - iconW * 2
				SortUpIconOffset = -iconOffsetX - iconW
				SortDownIconOffset = -iconOffsetX
				
				buttonFrame.RemoveIcon = AddCustomizationIcon(buttonFrame.RemoveIcon, buttonFrame, cooldownbar, RemoveIconOffset, iconOffsetY, iconW, iconH, "removeButtonIcon", function() OnClickRemove(spell) end, not spell.isCustom)
				buttonFrame.ShowIcon = AddCustomizationIcon(buttonFrame.ShowIcon, buttonFrame, cooldownbar, ShowIconOffset, iconOffsetY, iconW, iconH, "showButtonIcon", function() OnClickShow(spell) end)				
				buttonFrame.SortUpIcon = AddCustomizationIcon(buttonFrame.SortUpIcon, buttonFrame, cooldownbar, SortUpIconOffset, iconOffsetY, iconW, iconH, "sortUpIcon", function() OnClickSortUp(spell) end)
				buttonFrame.SortDownIcon = AddCustomizationIcon(buttonFrame.SortDownIcon, buttonFrame, cooldownbar, SortDownIconOffset, iconOffsetY, iconW, iconH, "sortDownIcon", function() OnClickSortDown(spell) end)

				buttonFrame:SetScript("OnMouseUp", OnClickTeleButton)

				local buttonSetting = { }
				buttonSetting.isItem = isItem
				buttonSetting.spellName = spellName
				buttonSetting.cooldownbar = cooldownbar
				buttonSetting.cooldownString = cooldownString
				buttonSetting.spellId = spellId
				buttonSetting.countString = countString
				buttonSetting.toySpell = toySpell
				buttonSetting.spell = spell
				buttonSetting.spellType = spellType
				buttonSetting.frame = buttonFrame
				buttonSetting.displaySpellName = displaySpellName
				ButtonSettings[buttonFrame] = buttonSetting
				OrderedButtonSettings[spellIndex] = buttonSetting
				spellIndex = spellIndex + 1
			end
		end
		
		local helpTextHeight		
		
		if TeleporterHelpString then
			if numColumns == 1 then
				helpTextHeight = 40
			else
				helpTextHeight = 10
			end
			TeleporterHelpString:SetPoint("TOPLEFT", TeleporterParentFrame, "TOPLEFT", 4 + buttonInset, -maxyoffset - 3 )
			TeleporterHelpString:SetPoint("RIGHT", TeleporterParentFrame, "RIGHT", -buttonInset, 0)
			TeleporterHelpString:SetHeight( helpTextHeight )	
		else
			helpTextHeight = 0
		end
		
		local addRemoveButtonsHeight = 0
	
		if CustomizeSpells then
			if numColumns < 2 then
				numColumns = 2
			end
			
			AddItemButton:SetWidth((numColumns * buttonWidth) / 2)			
			AddSpellButton:SetWidth((numColumns * buttonWidth) / 2)			
			addRemoveButtonsHeight = buttonInset + buttonHeight
			
			AddItemButton:Show()
			AddSpellButton:Show()
		else
			AddItemButton:Hide()
			AddSpellButton:Hide()
		end
		
		TeleporterParentFrame:SetWidth(numColumns * buttonWidth + buttonInset * 2)
		TeleporterParentFrame:SetHeight(maxyoffset + buttonInset * 2 + 2 + helpTextHeight + addRemoveButtonsHeight)
		
	end

	TeleporterUpdateAllButtons()	
	TeleporterParentFrame:Show()
end


function TeleporterRestoreEquipment()
	ShouldNotBeEquiped = {}
	for slot,item in pairs(OldItems) do		
		ShouldNotBeEquiped[slot] = GetInventoryItemID("player", slot)
		ShouldBeEquiped[slot] = item
		RemoveItem[slot](item)
	end
	OldItems = {}
	EquipTime = GetTime()
end

function TeleporterCheckItemsWereEquiped()
	-- Sometimes equipping after casting fails. If that happens
	-- then try equipping after the next teleport.
	if GetTime() < EquipTime + 60 then 
		for slot, item in pairs(ShouldNotBeEquiped) do
			if IsEquippedItem ( item ) then
				RemoveItem[slot](ShouldBeEquiped[slot])
			end
		end
	end
	ShouldNotBeEquiped = {}
	ShouldBeEquiped = {}
end

function TeleporterClose()
	--if IsVisible and UnitAffectingCombat("player") then
		--print( "Sorry, cannot close " .. TOMEOFTELEPORTATIONTITLE .. " while in combat." )
	--else
		if TeleporterParentFrame then
			TeleporterParentFrame:Hide()
			IsVisible = false
		end

	--end
end

local function CacheItems()
	TomeOfTele_DevCache = {}
	for index, spell in ipairs(TeleporterSpells) do
		if spell:IsItem() then
			local item = Item:CreateFromItemID(spell.spellId)
			item:ContinueOnItemLoad(function()
				TomeOfTele_DevCache[spell.spellId] = {GetItemInfo(spell.spellId)}
			end)
		end
	end
end

function TeleporterFunction()
		if IsVisible then
			TeleporterClose()
		else
			TeleporterOpenFrame()
		end	
end

local function PrepareUnequippedSlot(item, itemSlot)
	OldItems[ itemSlot ] = 0
	
	local inBag = 0
	for bagIdx = 1,NUM_BAG_SLOTS,1 do
		for slotIdx = 1, C_Container.GetContainerNumSlots(bagIdx), 1 do
			local itemInBag = C_Container.GetContainerItemID(bagIdx, slotIdx)
			if itemInBag then
				local bagItemName = GetCachedItemInfo(itemInBag)
				if bagItemName == item or itemInBag == item then
					inBag = bagIdx
				end
			end
		end
	end

	if inBag == 0 then
		RemoveItem[itemSlot] = function(newItem)
			PickupInventoryItem(itemSlot)
			PutItemInBackpack()
		end
	else		
		RemoveItem[itemSlot] = function(newItem)
			PickupInventoryItem(itemSlot)
			PutItemInBag(inBag + 30)
		end
	end
end

-- This function exists because of a bug in patch 10.2.6 that has now been fixed.
local function SafeEquipItemByName(item, slot)	
	EquipItemByName(item, slot)
end

local function SaveItem(itemSlot, item)
	local OldItem = GetInventoryItemID( "player", itemSlot )
	if OldItem then
		OldItems[ itemSlot ] = OldItem
		RemoveItem[itemSlot] = function(newItem)
			SafeEquipItemByName( newItem, itemSlot )
		end
	else
		PrepareUnequippedSlot(item, itemSlot)				
	end
end

function TeleporterEquipSlashCmdFunction( item )
	CastSpell = nil

	if not IsEquippedItem ( item ) then
		if IsEquippableItem( item ) then 
			local _, _, _, _, _, _, _, _,itemEquipLoc = GetCachedItemInfo(item)
			local itemSlot = InvTypeToSlot[ itemEquipLoc ]
			if itemSlot == nil then
				print( "Unrecognised equipable item type: " .. itemEquipLoc )
				return
			end			
			SaveItem(itemSlot, item)
			if itemEquipLoc == "INVTYPE_2HWEAPON" then
				-- Also need to save offhand
				SaveItem(17, nil)
			end		
			SafeEquipItemByName( item, itemSlot )
		end
	end
end

local function DoCast(spell, closeFrame)
	CastSpell = spell
	if closeFrame and not GetOption("closeAfterCast") then
		TeleporterClose()
	end
end

function TeleporterUseItemSlashCmdFunction( item )
	local spell = GetItemSpell( item )
	-- Can't close the window immediately for equippable items, as closing unequips.
	local equippable = IsEquippableItem(item)
	DoCast( spell, not equippable )
end

function TeleporterCastSpellSlashCmdFunction( spell, closeFrame )
	DoCast(spell, true)	
end

function TeleporterCreateMacroSlashCmdFunction( spell )
	if spell then
		local macro
		local printEquipInfo = false

		if GetCachedItemInfo( spell ) then			
			if IsEquippableItem( spell ) then
				macro =
					"#showtooltip " .. spell .. "\n" ..
					"/teleporterequip " .. spell .. "\n" ..
					"/teleporteruseitem " .. spell .. "\n" ..
					"/use " .. spell .. "\n"
				printEquipInfo = true
			else
				macro =
					"#showtooltip " .. spell .. "\n" ..
					"/use " .. spell .. "\n"
			end
		else
			macro =
				"#showtooltip " .. spell .. "\n" ..
				"/cast " .. spell .. "\n"
		end

		local macroName = "Use" .. string.gsub( spell, "[^%a%d]", "" )
		if GetMacroInfo( macroName ) then
			DeleteMacro( macroName )
		end
		CreateMacro( macroName, 1, macro, 1, 1 )

		local extraInstructions = ""
		if printEquipInfo then
			extraInstructions = "If the item is not equipped then the first click of the macro will equip it and the second click will use it."
		end
		print( "Created macro " .. macroName .. ". " .. extraInstructions )

		PickupMacro( macroName )
	end
end

function Teleporter_OnAddonLoaded()
	--if TomeOfTele_Icon == nil then
		--TomeOfTele_Icon = {}
	--end
	
	--icon:Register("TomeTele", dataobj, TomeOfTele_Icon)		
	RebuildSpellList()
	for index, spell in ipairs(TeleporterSpells) do		
		local spellId = spell.spellId
		local spellType = spell.spellType
		local isItem = spell:IsItem()
		if isItem and C_ToyBox then
			-- Query this early so it will be ready when we need it.
			C_ToyBox.IsToyUsable(spellId)			
		end
	end
end

function Teleporter_OnUpdate()	
	if IsVisible then		
		-- The first time the UI is opened toy ownership may be incorrect. Reopen once it's correct.
		if NeedUpdate then		
			-- If it's still wrong then will try again later.
			if GetTime() > OpenTime + 0.5 then
				NeedUpdate = false
				Refresh()			
			end
		end
		TeleporterUpdateAllButtons()		
		
		--if not TeleporterParentFrame:IsVisible() then			
		--	TeleporterHideCreatedUI()
		--	IsVisible = false			
		--	TeleporterRestoreEquipment()
		--end
	end
end

function Teleporter_OnHide()
	TeleporterHideCreatedUI()
	IsVisible = false
	if not IsRefreshing then
		TeleporterRestoreEquipment()
	end
end

-----------------------------------------------------------------------
-- UI reuse

local uiElements = {}
local numUIElements = {}

-- Returns frame,frameName.  if frame is null then the caller must create a new object with this name
function TeleporterFindOrAddUIElement( prefix, parentFrame )
	local fullPrefix = parentFrame:GetName() .. prefix

	local numElementsWithPrefix = numUIElements[ fullPrefix ]
	if not numElementsWithPrefix then
		numElementsWithPrefix = 0
	end

	local frameName = fullPrefix .. numElementsWithPrefix
	local oldFrame = getglobal( frameName )
	if oldFrame then
		oldFrame:Show()
	end

	tinsert(uiElements, frameName)

	numElementsWithPrefix = numElementsWithPrefix + 1
	numUIElements[ fullPrefix ] = numElementsWithPrefix	
	
	return oldFrame, frameName
end


function TeleporterCreateReusableFrame( frameType, prefix, parentFrame, inheritsFrame )
	local frame, frameName = TeleporterFindOrAddUIElement( prefix, parentFrame )

	if not frame then
		frame = CreateFrame( frameType, frameName, parentFrame, inheritsFrame )
	end	
	
	return frame
end

function TeleporterCreateReusableFontString( prefix, parentFrame, font )
	local frame, frameName = TeleporterFindOrAddUIElement( prefix, parentFrame )

	if not frame then
		frame = parentFrame:CreateFontString(frameName, nil, font)
	end	
	
	return frame
end

function TeleporterHideCreatedUI()
	for index, itemName in pairs( uiElements ) do		
		local item = getglobal(itemName)
		if item then
			item:Hide()
		end
	end
	numUIElements = {}
	uiElements = {}
end

--[[------- Isle of Thunder Weekly Check---- by Fluffies------DIY by y368413-------------------------------------------
local chest_icon = "|TInterface\\Icons\\Trade_Archaeology_ChestofTinyGlassAnimals:12|t "
local rare_icon = "|TInterface\\Icons\\Achievement_Boss_Archaedas:12|t "
local quest_icon = "|TInterface\\CURSOR\\QUEST:12|t "
local rare_name = EXAMPLE_TARGET_MONSTER.." ("..ITEM_QUALITY3_DESC..")"

-- string colors
local LIGHT_RED   = "|cffFF2020"
local LIGHT_GREEN = "|cff20FF20"
local LIGHT_BLUE  = "|cff00ddFF"
local ZONE_BLUE   = "|cff00aacc"
local GREY        = "|cff999999"
local COORD_GREY  = "|cffBBBBBB"
local GOLD        = "|cffffcc00"
local WHITE       = "|cffffffff"
local PINK        = "|cffFFaaaa"
local function AddColor(str,color) return color..(str or " ^-^ ").."|r" end

local function completedstring(arg)
 if C_QuestLog.IsQuestFlaggedCompleted(arg) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end

-------------------------------------------------------------
local bonus = {52834, 52838, 52835, 52839, 52837, 52840,}						--Order Resources(前3)  -Gold(中3)  --Orderhall(后1) 
local count = 0
for _, id in pairs(bonus) do if C_QuestLog.IsQuestFlaggedCompleted(id) then count = count + 1 end end
local function CheckCurrency()
	if count < 2 then return AddColor(count.." / 2",LIGHT_RED) elseif count >= 2 then return AddColor(count.." / 2",LIGHT_GREEN) end
end
local function TimeTravelFB()
 if C_QuestLog.IsQuestFlaggedCompleted(40168) or C_QuestLog.IsQuestFlaggedCompleted(40173) or C_QuestLog.IsQuestFlaggedCompleted(40786) or C_QuestLog.IsQuestFlaggedCompleted(45799) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function GarrisonInvade()
 if C_QuestLog.IsQuestFlaggedCompleted(37638) or C_QuestLog.IsQuestFlaggedCompleted(37639) or C_QuestLog.IsQuestFlaggedCompleted(37640) or C_QuestLog.IsQuestFlaggedCompleted(38482) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function LegionWolrdBoss()
 if C_QuestLog.IsQuestFlaggedCompleted(42270) or C_QuestLog.IsQuestFlaggedCompleted(42269) or C_QuestLog.IsQuestFlaggedCompleted(42779) or C_QuestLog.IsQuestFlaggedCompleted(43192) or IsQuestFlaggedCompleted(42819) or IsQuestFlaggedCompleted(43193) or IsQuestFlaggedCompleted(43513) or IsQuestFlaggedCompleted(43448) or IsQuestFlaggedCompleted(43512) or IsQuestFlaggedCompleted(43985) or IsQuestFlaggedCompleted(44287) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function TombWolrdBoss()
 if C_QuestLog.IsQuestFlaggedCompleted(46947) or C_QuestLog.IsQuestFlaggedCompleted(46948) or C_QuestLog.IsQuestFlaggedCompleted(46945) or C_QuestLog.IsQuestFlaggedCompleted(47061) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function ArgusWolrdBoss()
 if C_QuestLog.IsQuestFlaggedCompleted(38276) or C_QuestLog.IsQuestFlaggedCompleted(47461) or C_QuestLog.IsQuestFlaggedCompleted(47462) or C_QuestLog.IsQuestFlaggedCompleted(47463) then return AddColor(COMPLETE,LIGHT_GREEN) else return AddColor(INCOMPLETE,LIGHT_RED) end
end
local function CheckIslandweekly()
	local iwqID = C_IslandsQueue.GetIslandsWeeklyQuestID()
	local _, _, _, cur, max = GetQuestObjectiveInfo(iwqID, 1, false)
	if iwqID and UnitLevel("player") == 120 and C_QuestLog.IsQuestFlaggedCompleted(iwqID) then return AddColor(COMPLETE,LIGHT_RED) elseif iwqID and UnitLevel("player") == 120 then return AddColor(cur.." / "..max,LIGHT_GREEN) end
end
------------------------------------------------------------------------------------

function dataobj:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_NONE")
    GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
    GameTooltip:ClearLines()
    GameTooltip:AddDoubleLine(TITLEREADME)
    --GameTooltip:AddDoubleLine(ERR_QUEST_HAS_IN_PROGRESS,"|T".."Interface\\Addons\\_ShiGuang\\Media\\Modules\\MaoR-UI"..":32|t")
    GameTooltip:AddLine(" ")
    --GameTooltip:AddDoubleLine(quest_icon..AddColor("[|cffFFaaaa"..C_CurrencyInfo.GetCurrencyInfo(1580).."|r] ",GOLD), CheckCurrency())
    --GameTooltip:AddDoubleLine(quest_icon..AddColor(GetItemInfo(138019),LIGHT_BLUE), completedstring(44554))            --史诗钥石
    GameTooltip:AddDoubleLine(quest_icon..AddColor(GARRISON_LANDING_INVASION,LIGHT_BLUE), GarrisonInvade())
    --GameTooltip:AddDoubleLine(quest_icon..AddColor(PLAYER_DIFFICULTY_TIMEWALKER,LIGHT_BLUE), TimeTravelFB())   --TBC--WLK--CTM 
    --GameTooltip:AddDoubleLine(quest_icon..AddColor(GetItemInfo(132892),LIGHT_BLUE), completedstring(34774))            --布林顿 C_PetJournal.GetPetAbilityInfo(989)
    GameTooltip:AddLine(" ")
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("Legion  1/11 ",PINK), LegionWolrdBoss())
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("Tomb  1/4 ",PINK), TombWolrdBoss())
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("Argus  1/4 ",PINK), ArgusWolrdBoss())
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-暗影领主艾斯卡|cffffddFF(死爪)|r",ZONE_BLUE), completedstring(39287))
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-游侠将军|cffffddFF(泰罗菲斯特)|r",ZONE_BLUE), completedstring(39288))
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-攻城大师玛塔克|cffffddFF(末日之轮)|r",ZONE_BLUE), completedstring(39289))
 --GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-暴君维哈里|cffffddFF(维金斯)|r",ZONE_BLUE), completedstring(39290)) 
   GameTooltip:AddDoubleLine(rare_icon..AddColor("WOD-鲁克玛",ZONE_BLUE), completedstring(37464)) 
   GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-怒之煞",ZONE_BLUE), completedstring(32099))
   GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-炮舰",ZONE_BLUE), completedstring(32098))
   GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-纳拉克",ZONE_BLUE), completedstring(32518))
   GameTooltip:AddDoubleLine(rare_icon..AddColor("MOP-乌达斯塔",ZONE_BLUE), completedstring(32519))
   GameTooltip:AddLine(" ")
   --GameTooltip:AddDoubleLine(quest_icon..AddColor(ISLANDS_HEADER,LIGHT_BLUE), CheckIslandweekly())
   --GameTooltip:AddLine(" ")
   GameTooltip:AddLine(chest_icon..AddColor(BOSS_DEAD,GOLD))
   for i = 1, GetNumSavedInstances() do
	   local name, id, _, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, level, total, progress = GetSavedInstanceInfo(i)
	   GameTooltip:AddDoubleLine(AddColor(name.."("..level..")",WHITE), locked and AddColor(progress.."/"..total, LIGHT_GREEN) or AddColor(" 0/0 ", LIGHT_RED))
   end
   GameTooltip:Show()
end

function dataobj:OnLeave()
    GameTooltip:Hide()
end

function dataobj:OnClick(button)
	TeleporterFunction()
end]]

function TeleporterIsUnsupportedItem(spell)
	return false
end

function TeleporterCanUseCovenantHearthstone(covenant)
	return function()
		return (C_Covenants and C_Covenants.GetActiveCovenantID() == covenant) or not GetOption("randomHearth")  or GetOption("allCovenants")
	end
end
function TeleporterGetSpells()
	SetupSpells()
	TeleporterSortSpells()
	return TeleporterSpells
end

