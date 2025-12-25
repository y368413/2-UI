local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local rollQueue = {}

local function ProcessNextRoll()
	if #rollQueue > 0 then
		local roll = tremove(rollQueue, 1)
		pcall(RollOnLoot, roll[1], roll[2])

		C_Timer.After(.3, ProcessNextRoll)
	end
end

local ROLL_TYPES = {
	PASS = 0,
	NEED = 1,
	GREED = 2,
	DISENCHANT = 3,
	TRANSMOG = 4,
}

function MISC:AutoRoll_OnEvent(rollID)
	local autoRoll = R.db["Misc"]["AutoRoll"]
	if autoRoll == 3 then return end

	local _, name, _, _, _, canNeed, canGreed, _, _, _, _, _, canTransmog = GetLootRollItemInfo(rollID)
	if not name then return end

	local rollType = ROLL_TYPES.PASS
	if autoRoll == 1 then
		rollType = canNeed and ROLL_TYPES.NEED or canTransmog and ROLL_TYPES.TRANSMOG or canGreed and ROLL_TYPES.GREED or ROLL_TYPES.PASS
	end

	if not next(rollQueue) then
		C_Timer.After(1, ProcessNextRoll)
	end

	tinsert(rollQueue, { rollID, rollType })
end

do
	function AtlasString(atlas, data)
		return format("|A:%s:%s|a", atlas, data or "16:16")
	end
end

local options = {
	{text = AtlasString("lootroll-toast-icon-need-up").." "..NEED, icon = 130772, size = 20},
	{text = AtlasString("lootroll-toast-icon-pass-up").." "..PASS, icon = 130775, size = 20},
	{text = DISABLE, icon = 616343, size = 30},
}

local function UpdateButtonIcon(bu)
	local option = options[R.db["Misc"]["AutoRoll"]]
	bu:SetSize(option.size, option.size)
	bu.Icon:SetTexture(option.icon)
	bu:SetHighlightTexture(option.icon)
end

function MISC:AutoRoll_CreateButton()
	local bu = CreateFrame("Button", nil, GroupLootHistoryFrame)
	bu.Icon = bu:CreateTexture(nil, "ARTWORK")
	bu.Icon:SetAllPoints()
	UpdateButtonIcon(bu)
	bu:SetPoint("CENTER", GroupLootHistoryFrame.ClosePanelButton, "LEFT", -14, 0)
	M.AddTooltip(bu, "ANCHOR_RIGHT", U["Auto Roll"], "info")

	local menuList = {}
	for i, option in ipairs(options) do
		tinsert(menuList, {
			text = option.text,
			func = function()
				R.db["Misc"]["AutoRoll"] = i
				UpdateButtonIcon(bu)
			end,
			checked = function()
				return i == R.db["Misc"]["AutoRoll"]
			end
		})
	end

	bu:SetScript("OnClick", function()
		M:EasyMenu(menuList, bu)
	end)
end

function MISC:AutoRoll()
	MISC:AutoRoll_CreateButton()
	M:RegisterEvent("START_LOOT_ROLL", MISC.AutoRoll_OnEvent)
end

MISC:RegisterMisc("AutoRoll", MISC.AutoRoll)