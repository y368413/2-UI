local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = getfenv(0)
local tinsert, pairs, type = table.insert, pairs, type
local buttonList, menubar = {}

function Bar:MicroButton_SetupTexture(icon, texture)
	local r, g, b = I.r, I.g, I.b
	--if not R.db["Skins"]["ClassLine"] then r, g, b = 0, 0, 0 end
	icon:SetOutside(nil, 3, 3)
	icon:SetTexture("Interface\\BUTTONS\\"..texture)
	icon:SetVertexColor(1, 1, 1)
end

local function ResetButtonParent(button, parent)
	if parent ~= button.__owner then
		button:SetParent(button.__owner)
	end
end

local function ResetButtonAnchor(button)
	button:ClearAllPoints()
	button:SetAllPoints()
end

function Bar:MicroButton_Create(parent, data)
	local texture, method, tooltip = unpack(data)

	local bu = CreateFrame("Frame", nil, parent)
	tinsert(buttonList, bu)
	bu:SetSize(21, 21)

	local icon = bu:CreateTexture(nil, "ARTWORK")
	Bar:MicroButton_SetupTexture(icon, texture)

	if type(method) == "string" then
		local button = _G[method]
		if not button then return end
		button:SetHitRectInsets(0, 0, 0, 0)
		button:SetParent(bu)
		button.__owner = bu
		hooksecurefunc(button, "SetParent", ResetButtonParent)
		ResetButtonAnchor(button)
		hooksecurefunc(button, "SetPoint", ResetButtonAnchor)
		--button:UnregisterAllEvents() -- statusbar on quest tracker needs this for anchoring
		--button:SetNormalTexture(0)
		--button:SetPushedTexture(0)
		--button:SetDisabledTexture(0)
		--button:SetHighlightTexture(0) -- 10.1.5
		if tooltip then M.AddTooltip(button, "ANCHOR_RIGHT", tooltip) end

		--[[local hl = button:GetHighlightTexture()
		Bar:MicroButton_SetupTexture(hl, texture)
		hooksecurefunc(button, "SetHighlightAtlas", function()
			button:SetHighlightTexture("Interface\\BUTTONS\\"..texture)
			hl:SetBlendMode("ADD")
		end)
		--if not R.db["Skins"]["ClassLine"] then hl:SetVertexColor(1, 1, 1) end

		local flash = button.FlashBorder
		if flash then
			Bar:MicroButton_SetupTexture(flash, texture)
			--if not R.db["Skins"]["ClassLine"] then flash:SetVertexColor(1, 1, 1) end
		end]]
		if button.FlashContent then button.FlashContent:SetAlpha(0) end
		if button.Portrait then button.Portrait:Hide() end
		if button.Background then button.Background:SetAlpha(0) end
		if button.PushedBackground then button.PushedBackground:SetAlpha(0) end
		if texture == "player" then
			button.Shadow:Hide()
			button.PushedShadow:SetAlpha(0)
		end
		if texture == "guild" then
			button:DisableDrawLayer("ARTWORK")
			button:DisableDrawLayer("OVERLAY")
			button.HighlightEmblem:SetAlpha(0)
			button.NotificationOverlay:SetPoint("TOPLEFT", 3, 0)
		end
	else
		bu:SetScript("OnMouseUp", method)
		M.AddTooltip(bu, "ANCHOR_RIGHT", tooltip)

		--local hl = bu:CreateTexture(nil, "HIGHLIGHT")
		--hl:SetBlendMode("ADD")
		--Bar:MicroButton_SetupTexture(hl, texture)
		--if not R.db["Skins"]["ClassLine"] then hl:SetVertexColor(1, 1, 1) end
	end
end

function Bar:MicroMenu_Setup()
	if not menubar then return end

	local size = R.db["Actionbar"]["MBSize"]
	local perRow = R.db["Actionbar"]["MBPerRow"]
	local margin = R.db["Actionbar"]["MBSpacing"]

	for i = 1, #buttonList do
		local button = buttonList[i]
		button:SetSize(size, size)
		button:ClearAllPoints()
		if i == 1 then
			button:SetPoint("BOTTOMLEFT")
		elseif mod(i-1, perRow) == 0 then
			button:SetPoint("BOTTOM", buttonList[i-perRow], "TOP", 0, margin)
		else
			button:SetPoint("LEFT", buttonList[i-1], "RIGHT", margin, 0)
		end
	end

	local column = min(11, perRow)
	local rows = ceil(11/perRow)
	local width = column*size + (column-1)*margin
	local height = size*rows + (rows)*margin
	menubar:SetSize(width, height)
	menubar.mover:SetSize(width, height)
end

function Bar:MicroMenu()
	BagsBar:Hide()
	BagsBar:UnregisterAllEvents()
	if not R.db["Actionbar"]["MicroMenu"] then return end

	menubar = CreateFrame("Frame", nil, UIParent)
	menubar:SetSize(310, 21)
	menubar.mover = M.Mover(menubar, U["Menubar"], "Menubar", R.Skins.MicroMenuPos)

	-- Generate Buttons
	local buttonInfo = {
		{"UI-CheckBox-Up", "CharacterMicroButton"},  --UI-MicroButton-Raid-Up
		{"UI-CheckBox-Up", "ProfessionMicroButton"},  --UI-MicroButton-Spellbook-Up
		{"UI-CheckBox-Up", "PlayerSpellsMicroButton"},  --UI-MicroButton-Talents-Up
		{"UI-CheckBox-Up", "AchievementMicroButton"},  --UI-MicroButton-Achievement-Up
		{"UI-CheckBox-Up", "QuestLogMicroButton"},  --UI-MICROBUTTON-QUEST-UP
		{"UI-CheckBox-Up", "GuildMicroButton"},  --UI-MICROBUTTON-SOCIALS-UP
		{"UI-CheckBox-Up", "LFDMicroButton"},  --UI-MicroButton-LFG-Up
		{"UI-CheckBox-Up", "EJMicroButton"},  --UI-MicroButton-EJ-Up
		{"UI-CheckBox-Up", "CollectionsMicroButton"},  --UI-MicroButton-Mounts-Up
		{"UI-CheckBox-Up", "StoreMicroButton"},  --UI-MicroButton-BStore-Up
		{"UI-CheckBox-Up", "MainMenuMicroButton", MicroButtonTooltipText(MAINMENU_BUTTON, "TOGGLEGAMEMENU")},  --UI-MicroButton-Help-Up
		--{"UI-SquareButton-Up", function() ToggleAllBags() end, MicroButtonTooltipText(BAGSLOT, "OPENALLBAGS")},  --UI-MicroButton-Abilities-Up
	}
	for _, info in pairs(buttonInfo) do
		Bar:MicroButton_Create(menubar, info)
	end

	-- Order Positions
	Bar:MicroMenu_Setup()

	-- Default elements
	if MainMenuMicroButton.MainMenuBarPerformanceBar then
		M.HideObject(MainMenuMicroButton.MainMenuBarPerformanceBar)
	end
	M.HideObject(HelpOpenWebTicketButton)
	MainMenuMicroButton:SetScript("OnUpdate", nil)

	MicroButtonAndBagsBar:Hide()
	MicroButtonAndBagsBar:UnregisterAllEvents()

	if R.db["Map"]["DisableMinimap"] then
		QueueStatusButton:SetParent(Minimap)
		QueueStatusButton:ClearAllPoints()
		QueueStatusButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 30, -10)
		QueueStatusButton:SetFrameLevel(5)
		QueueStatusButton:SetScale(.9)
	end

	if MicroMenu and MicroMenu.UpdateHelpTicketButtonAnchor then
		MicroMenu.UpdateHelpTicketButtonAnchor = M.Dummy
	end
end