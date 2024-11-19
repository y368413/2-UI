--## Author: Vladinator  ## Version: 10.1.0.230503
local DF_10_1 = select(4, GetBuildInfo()) >= 100100
if DF_10_1 then return end -- TODO: DF revamp disjoints the roll system and the history system so there is no clean connection between these two - any ideas?

local GameTooltip = GameTooltip ---@type GameTooltip
local STANDARD_TEXT_FONT = STANDARD_TEXT_FONT -- Fonts.xml
local NUM_GROUP_LOOT_FRAMES = NUM_GROUP_LOOT_FRAMES or 4 -- GroupLootFrame.lua

---@class Callbacks
local Callbacks do

	---@alias Event "CLEAR" | "UPDATE"

	---@alias Callback fun(event: Event, ...: any)

	---@class Callbacks
	---@field public callbacks table<Event, table<Callback, boolean>?>

	Callbacks = { callbacks = {} }

	---@param callback Callback
	---@param event Event
	function Callbacks:RegisterCallback(callback, event)
		local callbacks = self.callbacks[event]
		if not callbacks then
			callbacks = {}
			self.callbacks[event] = callbacks
		end
		callbacks[callback] = true
	end

	---@param callback Callback
	---@param event Event
	function Callbacks:UnregisterCallback(callback, event)
		local callbacks = self.callbacks[event]
		if not callbacks then
			return
		end
		callbacks[callback] = nil
	end

	local function error()
		print("Callback Error:", debugstack(2))
	end

	---@param event Event
	---@param ... any
	function Callbacks:Emit(event, ...)
		local callbacks = self.callbacks[event]
		if not callbacks then
			return
		end
		for callback, _ in pairs(callbacks) do
			xpcall(callback, error, event, ...)
		end
	end

end

---@class LootHistory : Callbacks
local LootHistory do

	---@alias EnumEncounterLootDropRollStatePolyfill number `Enum.EncounterLootDropRollState`

	---@class LootHistoryDropInfoPlayerRollResultsPolyfill
	---@field public isWinner? boolean
	---@field public roll? number

	---@class LootHistoryDropInfoPlayerPolyfill : LootHistoryDropInfoPlayerRollResultsPolyfill
	---@field public playerClass string
	---@field public playerName string

	---@class LootHistoryDropInfoRollInfoPolyfill : LootHistoryDropInfoPlayerPolyfill
	---@field public state EnumEncounterLootDropRollStatePolyfill
	---@field public isSelf boolean

	---@class LootHistoryDropInfoPolyfill
	---@field public lootListID number
	---@field public itemHyperlink string
	---@field public currentLeader LootHistoryDropInfoPlayerPolyfill
	---@field public winner? LootHistoryDropInfoPlayerPolyfill
	---@field public rollInfos LootHistoryDropInfoRollInfoPolyfill[]
	---@field public playerRollState EnumEncounterLootDropRollStatePolyfill
	---@field public isTied boolean
	---@field public allPassed boolean

	---@class LootHistoryRollStatePlayerInfo : LootHistoryDropInfoPlayerRollResultsPolyfill
	---@field public name string
	---@field public className string

	---@class LootHistoryRollStateRollSummary
	---@field public type number
	---@field public count number
	---@field public players LootHistoryRollStatePlayerInfo[]

	---@class LootHistoryRollState
	---@field public uniqueID string
	---@field public lootListID? number
	---@field public rollID? number
	---@field public itemLink string
	---@field public rolls LootHistoryRollStateRollSummary[]

	---@class LootHistoryDropSummary
	---@field public rollNeedMainSpec LootHistoryRollStatePlayerInfo[]|false
	---@field public rollNeedOffSpec LootHistoryRollStatePlayerInfo[]|false
	---@field public rollTransmog LootHistoryRollStatePlayerInfo[]|false
	---@field public rollGreed LootHistoryRollStatePlayerInfo[]|false
	---@field public rollPass LootHistoryRollStatePlayerInfo[]|false
	---@field public rollNoRoll LootHistoryRollStatePlayerInfo[]|false

	---@class LootHistoryRollTypeToSummaryKey
	local rollTypeToSummaryKey = {
		[5] = "rollNeedMainSpec", -- pre revamp this is "Need"
		[4] = "rollNeedOffSpec", -- pre revamp this is unused
		[3] = "rollTransmog", -- pre revamp this is "Disenchant"
		[2] = "rollGreed", -- pre revamp this is "Greed"
		[1] = "rollPass", -- pre revamp this is "Pass"
		[0] = "rollNoRoll", -- pre revamp this is "Undecided"
	}

	---@class LootHistory
	---@field public drops LootHistoryRollState[]

	---@class LootHistory : Callbacks
	LootHistory = Mixin({ drops = {} }, Callbacks)

	---@class LootHistoryFrame : Frame
	local frame = CreateFrame("Frame")

	if DF_10_1 then
		frame:RegisterEvent("LOOT_HISTORY_UPDATE_DROP") ---@diagnostic disable-line: param-type-mismatch
	else
		frame:RegisterEvent("LOOT_HISTORY_AUTO_SHOW")
		frame:RegisterEvent("LOOT_HISTORY_FULL_UPDATE")
		frame:RegisterEvent("LOOT_HISTORY_ROLL_CHANGED")
		frame:RegisterEvent("LOOT_HISTORY_ROLL_COMPLETE")
	end

	---@param self LootHistoryFrame
	---@param event WowEvent
	---@param ... any
	frame:SetScript("OnEvent", function(self, event, ...)
		if event == "LOOT_HISTORY_UPDATE_DROP" then
			local encounterID, lootListID = ...
			---@type LootHistoryDropInfoPolyfill
			local dropInfo = C_LootHistory.GetSortedInfoForDrop(encounterID, lootListID) ---@diagnostic disable-line: assign-type-mismatch
			if dropInfo then
				LootHistory:UpdateDropStateByDropInfo(dropInfo)
			end
		elseif event == "LOOT_HISTORY_AUTO_SHOW"
			or event == "LOOT_HISTORY_FULL_UPDATE"
			or event == "LOOT_HISTORY_ROLL_CHANGED"
			or event == "LOOT_HISTORY_ROLL_COMPLETE" then
			if event == "LOOT_HISTORY_FULL_UPDATE" then
				LootHistory:Clear()
			end
			for i = 1, C_LootHistory.GetNumItems() do
				---@type number, string, number, boolean, number?
				local rollID, itemLink, numPlayers, isDone, winnerIdx = C_LootHistory.GetItem(i) ---@diagnostic disable-line: assign-type-mismatch
				if rollID then
					LootHistory:UpdateDropStateByRollInfo(rollID, itemLink, numPlayers, isDone, winnerIdx)
				end
			end
		end
	end)

	function LootHistory:Clear()
		table.wipe(self.drops)
		self:Emit("CLEAR")
	end

	---@param uniqueID string
	---@return LootHistoryRollState roll
	function LootHistory:CreateDropState(uniqueID)
		---@type LootHistoryRollState
		local roll = {
			uniqueID = uniqueID,
			rolls = {},
		}
		return roll
	end

	---@param uniqueID string
	---@return LootHistoryRollState? roll, number rollIndex
	function LootHistory:GetDropByUniqueID(uniqueID)
		for index, drop in ipairs(self.drops) do
			if drop.uniqueID == uniqueID then
				return drop, index
			end
		end
		return nil, 0
	end

	---@param rollType? number
	---@param isPreDFRevamp? boolean
	---@return number rollType
	function LootHistory:GetRollType(rollType, isPreDFRevamp)
		if isPreDFRevamp then
			if rollType == LOOT_ROLL_TYPE_NEED then
				return 5
			elseif rollType == LOOT_ROLL_TYPE_GREED then
				return 2
			elseif rollType == LOOT_ROLL_TYPE_DISENCHANT then
				return 3
			elseif rollType == LOOT_ROLL_TYPE_PASS then
				return 1
			end
			return 0
		end
		if rollType == Enum.EncounterLootDropRollState.NeedMainSpec then
			return 5
		elseif rollType == Enum.EncounterLootDropRollState.NeedOffSpec then
			return 4
		elseif rollType == Enum.EncounterLootDropRollState.Transmog then
			return 3
		elseif rollType == Enum.EncounterLootDropRollState.Greed then
			return 2
		elseif rollType == Enum.EncounterLootDropRollState.NoRoll then
			return 0
		elseif rollType == Enum.EncounterLootDropRollState.Pass then
			return 1
		end
		return 0
	end

	---@param rolls LootHistoryRollStateRollSummary[]
	---@param name string
	---@param className string
	---@param rollType number
	---@param isWinner boolean?
	---@param rollNumber number?
	local function ApplyRoll(rolls, name, className, rollType, isWinner, rollNumber)
		local roll ---@type LootHistoryRollStateRollSummary?
		for _, _roll in ipairs(rolls) do
			if _roll.type == rollType then
				roll = _roll
				break
			end
		end
		if not roll then
			---@type LootHistoryRollStateRollSummary
			roll = {
				type = rollType,
				count = 0,
				players = {},
			}
			rolls[#rolls + 1] = roll
		end
		roll.count = roll.count + 1
		roll.players[#roll.players + 1] = {
			name = name,
			className = className,
			isWinner = isWinner,
			roll = rollNumber,
		}
	end

	---@param a LootHistoryRollStateRollSummary
	---@param b LootHistoryRollStateRollSummary
	local function SortRollsCmp(a, b)
		return a.type > b.type
	end

	---@param a LootHistoryRollStatePlayerInfo
	---@param b LootHistoryRollStatePlayerInfo
	local function SortRollPlayersCmp(a, b)
		local x = a.isWinner and a.roll or 0
		local y = b.isWinner and b.roll or 0
		if x == y then
			return strcmputf8i(a.name, b.name) > 0
		end
		return x < y
	end

	---@param rolls LootHistoryRollStateRollSummary[]
	local function SortRolls(rolls)
		table.sort(rolls, SortRollsCmp)
		for _, roll in ipairs(rolls) do
			table.sort(roll.players, SortRollPlayersCmp)
		end
	end

	---@param dropInfo LootHistoryDropInfoPolyfill
	function LootHistory:UpdateDropStateByDropInfo(dropInfo)
		local uniqueID = format("DI_%d", dropInfo.lootListID)
		local drop = self:GetDropByUniqueID(uniqueID)
		if not drop then
			drop = self:CreateDropState(uniqueID)
			drop.lootListID = dropInfo.lootListID
			drop.itemLink = dropInfo.itemHyperlink
			self.drops[#self.drops + 1] = drop
		end
		table.wipe(drop.rolls)
		for _, rollInfo in ipairs(dropInfo.rollInfos) do
			ApplyRoll(drop.rolls, rollInfo.playerName, rollInfo.playerClass, self:GetRollType(rollInfo.state), rollInfo.isWinner, rollInfo.roll)
		end
		SortRolls(drop.rolls)
		self:Emit("UPDATE", drop)
	end

	---@param rollID number
	---@param itemLink string
	---@param numPlayers number
	---@param isDone boolean
	---@param winnerIdx number?
	function LootHistory:UpdateDropStateByRollInfo(rollID, itemLink, numPlayers, isDone, winnerIdx)
		local uniqueID = format("RI_%d", rollID)
		local drop = self:GetDropByUniqueID(uniqueID)
		if not drop then
			drop = self:CreateDropState(uniqueID)
			drop.rollID = rollID
			drop.itemLink = itemLink
			self.drops[#self.drops + 1] = drop
		end
		table.wipe(drop.rolls)
		for i = 1, numPlayers do
			---@type string, string, number, number, boolean?
			local name, className, rollType, rollNumber, isWinner = C_LootHistory.GetPlayerInfo(rollID, i) ---@diagnostic disable-line: assign-type-mismatch
			if name then
				ApplyRoll(drop.rolls, name, className, self:GetRollType(rollType, true), isWinner, rollNumber)
			end
		end
		SortRolls(drop.rolls)
		self:Emit("UPDATE", drop)
	end

	function LootHistory:GetRollTypeToSummaryKeyMap()
		return rollTypeToSummaryKey
	end

	---@return LootHistoryRollState[] drops
	function LootHistory:GetDrops()
		return self.drops
	end

	---@param drop LootHistoryRollState
	---@return LootHistoryDropSummary dropSummary
	function LootHistory:GetDropSummary(drop)
		---@type LootHistoryDropSummary
		local dropSummary = {}
		for _, roll in ipairs(drop.rolls) do
			local key = rollTypeToSummaryKey[roll.type]
			if key then
				dropSummary[key] = roll.players
			end
		end
		for _, key in pairs(rollTypeToSummaryKey) do
			if not dropSummary[key] then
				dropSummary[key] = false
			end
		end
		return dropSummary
	end

end

---@class RollFrames : Frame
local RollFrames do

	---@alias RollFrameOverlayFrameKind "NEED" | "GREED" | "TRANSMOG" | "PASS" | "NOROLL"

	---@class RollFrameOverlayFrame : Button
	---@field public overlay RollFrameOverlay
	---@field public text FontString
	---@field public rollHistoryText string[]

	---@class RollFrameOverlayLine
	---@field public order number
	---@field public name string
	---@field public text string

	---@class RollFrameOverlayFrame
	local RollFrameOverlayFrame = {}

	---@param kind RollFrameOverlayFrameKind
	function RollFrameOverlayFrame:OnLoad(kind)
		self:EnableMouse(kind == "NOROLL")
		self.overlay = self:GetParent() ---@diagnostic disable-line: assign-type-mismatch
		self.text = self:CreateFontString(nil, "ARTWORK")
		self.text:SetAllPoints()
		self.text:SetFont(STANDARD_TEXT_FONT, 16, "THICKOUTLINE")
		self.rollHistoryText = {}
		local rollFrame = self.overlay.rollFrame
		if kind == "NEED" then
			self:SetAllPoints(rollFrame.NeedButton)
		elseif kind == "GREED" then
			self:SetAllPoints(rollFrame.GreedButton)
		elseif kind == "TRANSMOG" then
			self:SetAllPoints(rollFrame.TransmogButton)
		elseif kind == "PASS" then
			self:SetAllPoints(rollFrame.PassButton)
		elseif kind == "NOROLL" then
			self:SetPoint("TOP", rollFrame.PassButton, "BOTTOM", 5, 3)
			self:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
			self:SetHighlightTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Highlight", "ADD")
			self:SetPushedTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Down")
			self.tooltipText = "Undecided"
			self.newbieText = "These players haven't decided what to roll on this item."
		end
		self:SetScript("OnEnter", self.OnEnter)
		rollFrame:HookScript("OnHide", function() self:OnHide() end)
	end

	---@param lines string[]
	---@param addSpace boolean?
	---@param addHeader string?
	local function AddTooltipText(lines, addSpace, addHeader)
		local has = lines[1]
		if not has then
			return
		end
		if addSpace then
			GameTooltip:AddLine(" ")
		end
		if addHeader then
			GameTooltip:AddLine(addHeader, 1, 1, 1, true)
			GameTooltip:AddLine(" ")
		end
		for _, line in ipairs(lines) do
			GameTooltip:AddLine(line, 1, 1, 1, true)
		end
		return true
	end

	function RollFrameOverlayFrame:OnEnter()
		local added = AddTooltipText(self.rollHistoryText, true)
		local noRollButton = self.overlay.noRollButton
		if self ~= noRollButton then
			added = AddTooltipText(noRollButton.rollHistoryText, added, noRollButton.tooltipText) or added
		end
		if not added then
			return
		end
		GameTooltip:Show()
	end

	function RollFrameOverlayFrame:OnHide()
		table.wipe(self.rollHistoryText)
		self.text:SetText("")
	end

	---@param a RollFrameOverlayLine
	---@param b RollFrameOverlayLine
	local function SortOverlayNames(a, b)
		local x = a.order
		local y = b.order
		if x == y then
			return strcmputf8i(a.name, b.name) > 0
		end
		return x > y
	end

	---@param ... LootHistoryRollStatePlayerInfo[]|false
	function RollFrameOverlayFrame:Update(...)
		local temp = {...}
		local lines = { index = 0 } ---@type RollFrameOverlayLine[]
		for i = 1, #temp do
			local players = temp[i]
			if players then
				for _, roll in ipairs(players) do
					lines.index = lines.index + 1
					local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[roll.className or "PRIEST"]
					local text = color:WrapTextInColorCode(roll.name)
					lines[lines.index] = {
						order = i,
						name = roll.name,
						text = text,
					}
				end
			end
		end
		table.sort(lines, SortOverlayNames)
		local text = self.rollHistoryText
		for i, line in ipairs(lines) do
			text[i] = line.text
		end
		for i = lines.index + 1, #text do
			text[i] = nil
		end
		self.text:SetText(lines.index > 0 and lines.index or "")
	end

	---@param overlay RollFrameOverlay
	---@param kind RollFrameOverlayFrameKind
	---@return RollFrameOverlayFrame overlayFrame
	local function CreateOverlayFrame(overlay, kind)
		local template = kind == "NOROLL" and "LootRollButtonTemplate" or nil
		---@diagnostic disable-next-line: assign-type-mismatch
		local overlayFrame = CreateFrame("Button", nil, overlay, template) ---@type RollFrameOverlayFrame
		Mixin(overlayFrame, RollFrameOverlayFrame)
		overlayFrame:OnLoad(kind)
		return overlayFrame
	end

	---@class RollFrameOverlay : Frame
	---@field public rollFrame RollFrame

	---@class RollFrameOverlay : Frame
	local RollFrameOverlay = {}

	function RollFrameOverlay:OnLoad()
		self.rollFrame = self:GetParent() ---@diagnostic disable-line: assign-type-mismatch
		self.needButton = CreateOverlayFrame(self, "NEED")
		self.greedButton = CreateOverlayFrame(self, "GREED")
		self.transmogButton = CreateOverlayFrame(self, "TRANSMOG")
		self.passButton = CreateOverlayFrame(self, "PASS")
		self.noRollButton = CreateOverlayFrame(self, "NOROLL")
	end

	---@param drop LootHistoryRollState
	function RollFrameOverlay:Update(drop)
		local dropSummary = LootHistory:GetDropSummary(drop)
		self.needButton:Update(dropSummary.rollNeedMainSpec, dropSummary.rollNeedOffSpec)
		self.greedButton:Update(dropSummary.rollGreed)
		self.transmogButton:Update(dropSummary.rollTransmog)
		self.passButton:Update(dropSummary.rollPass)
		self.noRollButton:Update(dropSummary.rollNoRoll)
	end

	---@class LootRollButtonTemplatePolyfill : Button

	---@class RollFrame : Frame
	---@field public rollID number
	---@field public NeedButton LootRollButtonTemplatePolyfill
	---@field public GreedButton LootRollButtonTemplatePolyfill
	---@field public TransmogButton LootRollButtonTemplatePolyfill
	---@field public PassButton LootRollButtonTemplatePolyfill

	---@class RollFrames
	---@field public overlays table<RollFrame, RollFrameOverlay>

	RollFrames = { overlays = {} }

	---@param drop LootHistoryRollState
	---@return RollFrame? rollFrame
	function RollFrames:GetByDrop(drop)
		if not drop or not drop.lootListID then
			return
		end
		---@diagnostic disable-next-line: assign-type-mismatch
		local rollIDs = GetActiveLootRollIDs() ---@type number[]
		local id ---@type number?
		-- local myName = UnitNameUnmodified("player")
		-- local myRoll ---@type LootHistoryRollStateRollSummary?
		-- local myPlayer ---@type LootHistoryRollStatePlayerInfo?
		-- for _, roll in ipairs(drop.rolls) do
		-- 	for _, player in ipairs(roll.players) do
		-- 		if player.name == myName then
		-- 			myRoll = roll
		-- 			myPlayer = player
		-- 			break
		-- 		end
		-- 	end
		-- end
		for _, rollID in ipairs(rollIDs) do
			local itemLink = GetLootRollItemLink(rollID)
			if itemLink and itemLink == drop.itemLink then
				-- local texture, name, count, quality, bindOnPickUp, canNeed, canGreed, canDisenchant, reasonNeed, reasonGreed, reasonDisenchant, deSkillRequired, canTransmog = GetLootRollItemInfo(rollID)
				-- local tooltipData = C_TooltipInfo.GetLootRollItem(rollID)
				-- if myRoll and myPlayer then end
				if id then
					return
				end
				id = rollID
			end
		end
		if not id then
			return
		end
		return self:GetByRollID(id)
	end

	---@param id number
	---@return RollFrame? rollFrame
	function RollFrames:GetByRollID(id)
		if not id then
			return
		end
		for i = 1, NUM_GROUP_LOOT_FRAMES do
			local name = format("GroupLootFrame%d", i)
			local frame = _G[name] ---@type RollFrame?
			if not frame or not frame:IsShown() then
				break
			end
			if frame.rollID == id then
				return frame
			end
		end
	end

	---@param rollFrame RollFrame
	---@return RollFrameOverlay overlay
	local function CreateOverlay(rollFrame)
		---@diagnostic disable-next-line: assign-type-mismatch
		local overlay = CreateFrame("Frame", nil, rollFrame) ---@type RollFrameOverlay
		Mixin(overlay, RollFrameOverlay)
		overlay:OnLoad()
		return overlay
	end

	---@param frame RollFrame
	---@param drop LootHistoryRollState
	function RollFrames:Update(frame, drop)
		local overlay = self.overlays[frame]
		if not overlay then
			overlay = CreateOverlay(frame)
			self.overlays[frame] = overlay
		end
		overlay:Update(drop)
	end

end

---@class ns
local ns do

	---@class ns
	ns = select(2, ...)

	---@param event Event
	---@param drop LootHistoryRollState
	function ns:OnEvent(event, drop)
		local rollFrame = RollFrames:GetByDrop(drop) or RollFrames:GetByRollID(drop.rollID)
		if not rollFrame then
			return
		end
		RollFrames:Update(rollFrame, drop)
	end

	function ns:OnLoad()
		local function callback(...) self:OnEvent(...) end
		LootHistory:RegisterCallback(callback, "UPDATE")
	end

	ns:OnLoad()

end

-- [[
-- _G.Callbacks = Callbacks -- DEBUG -- /tinspect Callbacks
_G.LootHistory = LootHistory -- DEBUG -- /tinspect LootHistory
_G.RollFrames = RollFrames -- DEBUG -- /tinspect RollFrames
-- _G.ns = ns -- DEBUG -- /tinspect ns
--]]
