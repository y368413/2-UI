------------------------------------
-- Credit: Narcissus, by Peterodox
------------------------------------
local ItemList, gearFrame = {}

local fontSize = 14
local TRANSMOGRIFY = TRANSMOGRIFY

if GetLocale() ~= "zhCN" and GetLocale() ~= "zhTW" then
	fontSize = 10
	TRANSMOGRIFY = "Transmog"
end

local SlotIDtoName = {
    [1] = HEADSLOT,
    [2] = NECKSLOT,
    [3] = SHOULDERSLOT,
    [4] = SHIRTSLOT,
    [5] = CHESTSLOT,
    [6] = WAISTSLOT,
    [7] = LEGSSLOT,
    [8] = FEETSLOT,
    [9] = WRISTSLOT,
    [10]= HANDSSLOT,
    [11]= FINGER0SLOT_UNIQUE,
    [12]= FINGER1SLOT_UNIQUE,
    [13]= TRINKET0SLOT_UNIQUE,
    [14]= TRINKET1SLOT_UNIQUE,
    [15]= BACKSLOT,
    [16]= MAINHANDSLOT,
    [17]= SECONDARYHANDSLOT,
    [18]= RANGEDSLOT,
    [19]= TABARDSLOT,
}

local defaults = {
	["ShowHideVisual"] = false,
	["ShowIllusion"] = false,
}

local function createGearFrame()
	if gearFrame then gearFrame:Show() return end

	gearFrame = CreateFrame("Frame", "CopyMogGearTexts", UIParent, "BackdropTemplate")
	gearFrame:SetPoint("TOP", InspectPaperDollFrame, "BOTTOM", 0, 0)
	gearFrame:SetSize(330, 250)
	gearFrame:SetFrameStrata("DIALOG")
	gearFrame:SetBackdrop({ 
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		insets = {left = 5,right = 5,top = 5,bottom = 5},
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 16,
	})
	local close = CreateFrame("Button", nil, gearFrame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", gearFrame)
	gearFrame.Close = close

	local scrollArea = CreateFrame("ScrollFrame", nil, gearFrame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", 10, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", -28, 10)

	local editBox = CreateFrame("EditBox", nil, gearFrame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(true)
	editBox:SetFont(STANDARD_TEXT_FONT, 14)
	editBox:SetWidth(scrollArea:GetWidth())
	editBox:SetHeight(scrollArea:GetHeight())
	editBox:SetScript("OnEscapePressed", function() gearFrame:Hide() end)
	scrollArea:SetScrollChild(editBox)
	gearFrame.EditBox = editBox
end

local function GenerateSource(sourceID, sourceType, itemModID, itemQuality)
	local sourceTextColorized = ""
    if sourceType == 1 then --TRANSMOG_SOURCE_BOSS_DROP
        local drops = C_TransmogCollection.GetAppearanceSourceDrops(sourceID)
        if drops and drops[1] then
            sourceTextColorized = drops[1].encounter.." ".."|cFFFFD100"..drops[1].instance.."|r|CFFf8e694"
            if itemModID == 0 then 
                sourceTextColorized = sourceTextColorized.." "..PLAYER_DIFFICULTY1
            elseif itemModID == 1 then 
                sourceTextColorized = sourceTextColorized.." "..PLAYER_DIFFICULTY2
            elseif itemModID == 3 then 
                sourceTextColorized = sourceTextColorized.." "..PLAYER_DIFFICULTY6
            elseif itemModID == 4 then
                sourceTextColorized = sourceTextColorized.." "..PLAYER_DIFFICULTY3
            end
        end
    else
        if sourceType == 2 then --quest
            sourceTextColorized = TRANSMOG_SOURCE_2
        elseif sourceType == 3 then --vendor
            sourceTextColorized = TRANSMOG_SOURCE_3
        elseif sourceType == 4 then --world drop
            sourceTextColorized = TRANSMOG_SOURCE_4
        elseif sourceType == 5 then --achievement
            sourceTextColorized = TRANSMOG_SOURCE_5
        elseif sourceType == 6 then	--profession
            sourceTextColorized = TRANSMOG_SOURCE_6
        else
            if itemQuality == 6 then
                sourceTextColorized = ITEM_QUALITY6_DESC
            elseif itemQuality == 5 then
                sourceTextColorized = ITEM_QUALITY5_DESC
            end
        end
    end

    return sourceTextColorized
end

local function GetIllusionSource(sourceID)
	local _, name = C_TransmogCollection.GetIllusionSourceInfo(sourceID)
	local sourceText = ""
	name = name and format(TRANSMOGRIFIED_ENCHANT, name)

	local illusionList = C_TransmogCollection.GetIllusions()
	for i = 1, #illusionList do
		local info = illusionList[i]
		if info.sourceID == sourceID and info.sourceText then
			sourceText = info.sourceText
			break
		end
	end

    return name, sourceText
end

local function GetSourceInfo(sourceID)
	local sourceInfo = C_TransmogCollection.GetSourceInfo(sourceID)
	if not sourceInfo then return end

	return sourceInfo.isHideVisual, sourceInfo.sourceType, sourceInfo.itemModID, sourceInfo.itemID, sourceInfo.name, sourceInfo.quality
end

local function getInspectSources()
	wipe(ItemList)

	local appearanceSources, mainHandEnchant, offHandEnchant = C_TransmogCollection.GetInspectSources()
	if not appearanceSources then return end

	for i = 1, #appearanceSources do
		local sourceID = appearanceSources[i]
		if sourceID and sourceID ~= NO_TRANSMOG_SOURCE_ID then
			local isHideVisual, sourceType, itemModID, itemID, itemName, itemQuality = GetSourceInfo(sourceID)
			if not isHideVisual or defaults["ShowHideVisual"] then
				local sourceTextColorized = GenerateSource(sourceID, sourceType, itemModID, itemQuality)
				table.insert(ItemList, {["SlotID"] = i, ["Name"] = itemName, ["Source"] = sourceTextColorized})
			end
		end
	end

	if not defaults["ShowIllusion"] then return end

	if mainHandEnchant > 0 then
		local illusionName, sourceText = GetIllusionSource(mainHandEnchant)
		table.insert(ItemList, {["SlotID"] = 16, ["Name"] = illusionName, ["Source"] = sourceText})
	end

	if offHandEnchant > 0 then
		local illusionName, sourceText = GetIllusionSource(offHandEnchant)
		table.insert(ItemList, {["SlotID"] = 17, ["Name"] = illusionName, ["Source"] = sourceText})
	end
end

local function GetSlotVisualID(slotId, type)
	if slotId == 2 or slotId == 18 or (slotId > 10 and slotId < 15) then
		return -1, -1
	end
	local slotName = TransmogUtil.GetSlotName(slotId)
	local location = TransmogUtil.GetTransmogLocation(slotName, type, Enum.TransmogModification.None)
	local baseSourceID, baseVisualID, appliedSourceID, appliedVisualID, _, _, _, _, _, hideVisual = C_Transmog.GetSlotVisualInfo(location)
	if ( hideVisual ) then
		return 0, 0
	elseif ( appliedSourceID == NO_TRANSMOG_SOURCE_ID ) then
		return baseSourceID, baseVisualID
	else
		return appliedSourceID, appliedVisualID
	end
end

local function getPlayerSources()
	wipe(ItemList)

	for slotId = 1, 19 do 
		local appliedSourceID, appliedVisualID = GetSlotVisualID(slotId, Enum.TransmogType.Appearance)
		if appliedVisualID > 0 and appliedSourceID and appliedSourceID ~= NO_TRANSMOG_SOURCE_ID then
			local isHideVisual, sourceType, itemModID, itemID, itemName, itemQuality = GetSourceInfo(appliedSourceID)
			if not isHideVisual or defaults["ShowHideVisual"] then
				local sourceTextColorized = GenerateSource(appliedSourceID, sourceType, itemModID, itemQuality)
				table.insert(ItemList, {["SlotID"] = slotId, ["Name"] = itemName, ["Source"] = sourceTextColorized})
			end
		end
	end

	if not defaults["ShowIllusion"] then return end

	local mainHandEnchant = GetSlotVisualID(16, Enum.TransmogType.Illusion)
	if mainHandEnchant > 0 then
		local illusionName, sourceText = GetIllusionSource(mainHandEnchant)
		table.insert(ItemList, {["SlotID"] = 16, ["Name"] = illusionName, ["Source"] = sourceText})
	end

	local offHandEnchant = GetSlotVisualID(17, Enum.TransmogType.Illusion)
	if offHandEnchant > 0 then
		local illusionName, sourceText = GetIllusionSource(offHandEnchant)
		table.insert(ItemList, {["SlotID"] = 17, ["Name"] = illusionName, ["Source"] = sourceText})
	end
end

local function copyTexts()
	local texts = ""

	for _, info in ipairs(ItemList) do
		if info.Name and info.Name ~= "" then
			texts = texts .. "|cFFFFD100"..SlotIDtoName[info.SlotID]..":|r " .. info.Name
			if info.Source and info.Source ~= "" then
				texts = texts .. " |cFF40C7EB(" .. info.Source .. ")|r|r"
			end
			texts = texts .. "\n"
		end
	end

	gearFrame.EditBox:SetText(strtrim(texts))
	gearFrame.EditBox:HighlightText()
end

local function createCopyButton(parent)
	local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
	button:SetSize(50, 20)
	button:SetText(TRANSMOGRIFY)
	button.Text:SetFont(STANDARD_TEXT_FONT, fontSize, "OUTLINE")
	parent.CopyButton = button

	if IsAddOnLoaded("NDui") then
		local B, C, L, DB = unpack(_G.NDui)
		local cr, cg, cb = DB.r, DB.g, DB.b
		B.Reskin(button)
		button.Text:SetTextColor(cr, cg, cb)
	elseif IsAddOnLoaded("ElvUI") then
		local E, L, V, P, G = unpack(_G.ElvUI)
		local S = E:GetModule('Skins')
		S:HandleButton(button)
	end

	return button
end

local function InitialSettings(source, target)
	for i, j in pairs(source) do
		if type(j) == "table" then
			if target[i] == nil then target[i] = {} end
			for k, v in pairs(j) do
				if target[i][k] == nil then
					target[i][k] = v
				end
			end
		else
			if target[i] == nil then target[i] = j end
		end
	end

	for i, j in pairs(target) do
		if source[i] == nil then target[i] = nil end
	end
end

local index = 0
local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:RegisterEvent("PLAYER_LOGIN")
loader:SetScript("OnEvent", function(self, event, addon)
	if event == "ADDON_LOADED" then
		if addon == "_ShiGuang" then
			defaults = defaults or {}
			InitialSettings(defaults, defaults)
			index = index + 1
		end

		if addon == "Blizzard_InspectUI" then
			local button = createCopyButton(InspectPaperDollFrame)
			button:SetPoint("BOTTOMLEFT", 5, 6)
			button:SetScript("OnClick", function()
				createGearFrame()
				getInspectSources()
				copyTexts()
			end)
			index = index + 1
		end

		if index >= 2 then
			self:UnregisterEvent(event)
		end
	end

	if event == "PLAYER_LOGIN" then
		local button = createCopyButton(PaperDollFrame)
		button:SetPoint("BOTTOMLEFT", 5, 6)
		button:SetScript("OnClick", function()
			createGearFrame()
			getPlayerSources()
			copyTexts()
		end)
		self:UnregisterEvent(event)
	end
end)