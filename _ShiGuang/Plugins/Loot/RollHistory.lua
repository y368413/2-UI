--## Author: Vladinator  ## Version: 8.3.0.200202
local format = string.format
local table_insert = table.insert
local table_sort = table.sort
local table_wipe = table.wipe
local C_LootHistory_GetItem = C_LootHistory.GetItem
local C_LootHistory_GetNumItems = C_LootHistory.GetNumItems
local C_LootHistory_GetPlayerInfo = C_LootHistory.GetPlayerInfo
-- framexml references
local UNKNOWNOBJECT = UNKNOWNOBJECT or UNKNOWN or "Unknown" -- ?

-- private constants
local MAX_LOOT_FRAMES = 4 -- number of roll frames in the UI
local UNIQUE_KEY = "NumPicked" -- we use this as a child on each roll frame
local FALLBACK_CLASS = "PRIEST" -- if class is unknown we guess a priest
local LOOT_ROLL_TYPE_UNDECIDED = -10 -- a custom key for all those undecided players
local LOOT_ROLL_TYPES = { -- array over roll type and frame that goes with it
	[LOOT_ROLL_TYPE_NEED] = "NeedButton",
	[LOOT_ROLL_TYPE_GREED] = "GreedButton",
	[LOOT_ROLL_TYPE_DISENCHANT] = "DisenchantButton",
	[LOOT_ROLL_TYPE_PASS] = "PassButton",
	[LOOT_ROLL_TYPE_UNDECIDED] = "UndecidedButton", -- TODO
}

-- reusable variables
local rollFrame
local rollID, itemLink, numPlayers, isDone, winnerIdx, isMasterLoot
local button, fontString
local name, class, rollType, roll, isWinner
local player, classColor, tooltip

-- helps find the roll frame for a specific roll
local function GetRollFrame(rollID)
	for i = 1, MAX_LOOT_FRAMES do
		rollFrame = _G["GroupLootFrame" .. i]
		if rollFrame and rollFrame.rollID == rollID and rollFrame:IsShown() then -- only care about the visible frames
			return rollFrame
		end
	end
end

-- sorts players by descending rolls
local function SortPlayers(a, b)
	if a.roll and b.roll then
		return a.roll < b.roll -- compare a to b
	elseif a.roll then
		return true -- a has roll and comes first
	elseif b.roll then
		return false -- b has roll and comes first
	end
	if a.class == b.class then
		return a.name < b.name -- sort by name
	end
	return a.class < b.class -- sort by class
end

-- appends text to the tooltip of a choice
local function RollButtonEnter(button)
	fontString = button[UNIQUE_KEY]
	-- separator
	GameTooltip:AddLine(" ")
	-- add the tooltip lines
	for i = 1, #fontString.tooltip do
		GameTooltip:AddLine(fontString.tooltip[i], 1, 1, 1, true)
	end
	-- add the tooltip lines for the undecided
	button = (button:GetParent())[ LOOT_ROLL_TYPES[LOOT_ROLL_TYPE_UNDECIDED] or "" ]
	if button then
		-- separator
		if #fontString.tooltip > 0 then
			GameTooltip:AddLine(" ")
		end
		fontString = button[UNIQUE_KEY]
		-- section header
		GameTooltip:AddLine(button.tooltipText or button.newbieText, 1, 1, 1, true)
		GameTooltip:AddLine(" ")
		-- add the tooltip lines
		for i = 1, #fontString.tooltip do
			GameTooltip:AddLine(fontString.tooltip[i], 1, 1, 1, true)
		end
	end
	-- refresh to update the tooltip size
	GameTooltip:Show()
end

-- reset a roll frame and all our data
local function ResetRollFrame(rollFrame)
	for rollType, rollButton in pairs(LOOT_ROLL_TYPES) do
		button = rollFrame[rollButton]
		if button then
			fontString = button[UNIQUE_KEY]
			table_wipe(fontString.players)
			table_wipe(fontString.tooltip)
			fontString:SetText("")
		end
	end
end

-- installs the requires widgets onto the roll frame - if appropriate
local function ModifyRollFrame(rollFrame)
	if rollFrame.HasNumRolledFontString then
		return
	end
	rollFrame.HasNumRolledFontString = 1
	-- add the font strings to each button
	for rollType, rollButton in pairs(LOOT_ROLL_TYPES) do
		button = rollFrame[rollButton]
		if not button and rollType == LOOT_ROLL_TYPE_UNDECIDED then
			button = CreateFrame("Button", nil, rollFrame, "LootRollButtonTemplate")
			button:Hide() -- pointless to show this as it's not really directly used
			button:SetPoint("LEFT", rollFrame[LOOT_ROLL_TYPE_NEED], "RIGHT", 5, 3)
			button:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
			button:SetHighlightTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Highlight", "ADD")
			button:SetPushedTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Down")
			button.tooltipText = "Undecided"
			button.newbieText = "These players haven't decided what to roll on this item."
			rollFrame[rollButton] = button
		end
		if button then
			-- create large white readable text on top of the button
			fontString = button:CreateFontString()
			fontString:SetFont(STANDARD_TEXT_FONT, 16, "THICKOUTLINE")
			fontString:SetAllPoints()
			fontString.players = {}
			fontString.tooltip = {}
			-- store for later usage
			button[UNIQUE_KEY] = fontString
			-- expand the tooltip with roll choices
			button:HookScript("OnEnter", RollButtonEnter)
		end
	end
	-- cleanup once the frame is hidden
	rollFrame:HookScript("OnHide", ResetRollFrame)
end

-- all these events trigger a roll state change so we update accordingly
local RollHistory = CreateFrame("Frame")
if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
	RollHistory:RegisterEvent("BONUS_ROLL_ACTIVATE")
	RollHistory:RegisterEvent("BONUS_ROLL_DEACTIVATE")
	RollHistory:RegisterEvent("BONUS_ROLL_FAILED")
	RollHistory:RegisterEvent("BONUS_ROLL_RESULT")
	RollHistory:RegisterEvent("BONUS_ROLL_STARTED")
	RollHistory:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
end
RollHistory:RegisterEvent("CANCEL_LOOT_ROLL")
RollHistory:RegisterEvent("LOOT_CLOSED")
RollHistory:RegisterEvent("LOOT_HISTORY_AUTO_SHOW")
RollHistory:RegisterEvent("LOOT_HISTORY_FULL_UPDATE")
RollHistory:RegisterEvent("LOOT_HISTORY_ROLL_CHANGED")
RollHistory:RegisterEvent("LOOT_HISTORY_ROLL_COMPLETE")
RollHistory:RegisterEvent("LOOT_OPENED")
RollHistory:RegisterEvent("LOOT_READY")
RollHistory:RegisterEvent("LOOT_ROLLS_COMPLETE")
RollHistory:RegisterEvent("LOOT_SLOT_CHANGED")
RollHistory:RegisterEvent("LOOT_SLOT_CLEARED")
RollHistory:RegisterEvent("MODIFIER_STATE_CHANGED")
RollHistory:RegisterEvent("OPEN_MASTER_LOOT_LIST")
RollHistory:RegisterEvent("START_LOOT_ROLL")
RollHistory:RegisterEvent("UPDATE_MASTER_LOOT_LIST")

-- update the roll frames according to the loot history
RollHistory:SetScript("OnEvent", function(RollHistory, event)
	for i = 1, C_LootHistory_GetNumItems(), 1 do
		rollID, itemLink, numPlayers, isDone, winnerIdx, isMasterLoot = C_LootHistory_GetItem(i)
		-- check that the roll actually exists
		if rollID then
			rollFrame = GetRollFrame(rollID)
			-- we have a frame associated with said roll
			if rollFrame then
				-- modify the roll frame
				ModifyRollFrame(rollFrame)
				-- cleanup the roll frame before we do anything
				ResetRollFrame(rollFrame)
				-- we only care for the rolls that are actually rolls - not all loot is rolled and such
				if not isDone or winnerIdx or isMasterLoot then
					for j = 1, numPlayers do
						if LootHistoryFrameUtil_ShouldDisplayPlayer(i, j) then
							name, class, rollType, roll, isWinner = C_LootHistory_GetPlayerInfo(i, j)
							rollType = rollType or LOOT_ROLL_TYPE_UNDECIDED
							button = rollFrame[ LOOT_ROLL_TYPES[rollType] or "" ]
							if button then
								fontString = button[UNIQUE_KEY]
								table_insert(fontString.players, {
									name = name or UNKNOWNOBJECT,
									class = class or FALLBACK_CLASS,
									roll = roll,
									isWinner = isWinner,
								})
							end
						end
					end
				end
				-- summarize the results
				for rollType, rollButton in pairs(LOOT_ROLL_TYPES) do
					button = rollFrame[rollButton]
					if button then
						fontString = button[UNIQUE_KEY]
						numPlayers = #fontString.players
						-- sort highest rollers first
						table_sort(fontString.players, SortPlayers)
						for j = 1, numPlayers do
							player = fontString.players[j]
							class = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[player.class]
							table_insert(fontString.tooltip, format("%s |cff%02x%02x%02x%s|r |cffFFFF00%s|r", player.roll or "", class.r * 255, class.g * 255, class.b * 255, player.name, player.isWinner and "WINNER" or ""))
						end
						fontString:SetText(numPlayers > 0 and numPlayers or "")
					end
				end
			end
		end
	end
end)
