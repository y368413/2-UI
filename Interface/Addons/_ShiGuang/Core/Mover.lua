local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:RegisterModule("Mover")

local cr, cg, cb = I.r, I.g, I.b

-- Movable Frame
function M:CreateMF(parent, saved)
	local frame = parent or self
	frame:SetMovable(true)
	frame:SetUserPlaced(true)
	frame:SetClampedToScreen(true)

	self:EnableMouse(true)
	self:RegisterForDrag("LeftButton")
	self:SetScript("OnDragStart", function() frame:StartMoving() end)
	self:SetScript("OnDragStop", function()
		frame:StopMovingOrSizing()
		if not saved then return end
		local orig, _, tar, x, y = frame:GetPoint()
		x, y = M:Round(x), M:Round(y)
		R.db["TempAnchor"][frame:GetName()] = {orig, "UIParent", tar, x, y}
	end)
end

function M:RestoreMF()
	local name = self:GetName()
	if name and R.db["TempAnchor"][name] then
		self:ClearAllPoints()
		self:SetPoint(unpack(R.db["TempAnchor"][name]))
	end
end

function M:UpdateBlizzFrame()
	if InCombatLockdown() then return end
	if self.isRestoring then return end
	self.isRestoring = true
	M.RestoreMF(self)
	self.isRestoring = nil
end

function M:RestoreBlizzFrame()
	if IsControlKeyDown() then
		R.db["TempAnchor"][self:GetName()] = nil
		UpdateUIPanelPositions(self)
	end
end

function M:BlizzFrameMover(frame)
	M.CreateMF(frame, nil, true)
	hooksecurefunc(frame, "SetPoint", M.UpdateBlizzFrame)
	frame:HookScript("OnMouseUp", M.RestoreBlizzFrame)
end

-- Frame Mover
local MoverList, f = {}
local updater

function M:Mover(text, value, anchor, width, height, isAuraWatch)
	local key = "Mover"
	if isAuraWatch then key = "AuraWatchMover" end

	local mover = CreateFrame("Frame", nil, UIParent)
	mover:SetWidth(width or self:GetWidth())
	mover:SetHeight(height or self:GetHeight())
	mover.bg = M.SetBD(mover)
	mover:Hide()
	mover.text = M.CreateFS(mover, I.Font[2], text)
	mover.text:SetWordWrap(true)

	if not R.db[key][value] then
		mover:SetPoint(unpack(anchor))
	else
		mover:SetPoint(unpack(R.db[key][value]))
	end
	mover:EnableMouse(true)
	mover:SetMovable(true)
	mover:SetClampedToScreen(true)
	mover:SetFrameStrata("HIGH")
	mover:RegisterForDrag("LeftButton")
	mover.__key = key
	mover.__value = value
	mover.__anchor = anchor
	mover.isAuraWatch = isAuraWatch
	mover:SetScript("OnEnter", MISC.Mover_OnEnter)
	mover:SetScript("OnLeave", MISC.Mover_OnLeave)
	mover:SetScript("OnDragStart", MISC.Mover_OnDragStart)
	mover:SetScript("OnDragStop", MISC.Mover_OnDragStop)
	mover:SetScript("OnMouseUp", MISC.Mover_OnClick)
	if not isAuraWatch then
		tinsert(MoverList, mover)
	end

	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", mover)

	return mover
end

function MISC:CalculateMoverPoints(mover, trimX, trimY)
	local screenWidth = M:Round(UIParent:GetRight())
	local screenHeight = M:Round(UIParent:GetTop())
	local screenCenter = M:Round(UIParent:GetCenter(), nil)
	local x, y = mover:GetCenter()

	local LEFT = screenWidth / 3
	local RIGHT = screenWidth * 2 / 3
	local TOP = screenHeight / 2
	local point

	if y >= TOP then
		point = "TOP"
		y = -(screenHeight - mover:GetTop())
	else
		point = "BOTTOM"
		y = mover:GetBottom()
	end

	if x >= RIGHT then
		point = point.."RIGHT"
		x = mover:GetRight() - screenWidth
	elseif x <= LEFT then
		point = point.."LEFT"
		x = mover:GetLeft()
	else
		x = x - screenCenter
	end

	x = x + (trimX or 0)
	y = y + (trimY or 0)
	x, y = M:Round(x), M:Round(y)

	return x, y, point
end

function MISC:UpdateTrimFrame()
	if not f then return end -- for aurawatch preview

	local x, y = MISC:CalculateMoverPoints(self)
	f.__x:SetText(x)
	f.__y:SetText(y)
	f.__x.__current = x
	f.__y.__current = y
	f.__trimText:SetText(self.text:GetText())
end

function MISC:DoTrim(trimX, trimY)
	local mover = updater.__owner
	if mover then
		local x, y, point = MISC:CalculateMoverPoints(mover, trimX, trimY)
		f.__x:SetText(x)
		f.__y:SetText(y)
		f.__x.__current = x
		f.__y.__current = y
		mover:ClearAllPoints()
		mover:SetPoint(point, UIParent, point, x, y)
		R.db[mover.__key][mover.__value] = {point, "UIParent", point, x, y}
	end
end

function MISC:Mover_OnClick(btn)
	if IsShiftKeyDown() and btn == "RightButton" then
		if self.isAuraWatch then
			UIErrorsFrame:AddMessage(I.InfoColor..U["AuraWatchToggleError"])
		else
			self:Hide()
		end
	elseif IsControlKeyDown() and btn == "RightButton" then
		self:ClearAllPoints()
		self:SetPoint(unpack(self.__anchor))
		R.db[self.__key][self.__value] = nil
	end
	updater.__owner = self
	MISC.UpdateTrimFrame(self)
end

function MISC:Mover_OnEnter()
	self.bg:SetBackdropBorderColor(cr, cg, cb)
	self.text:SetTextColor(1, .8, 0)
end

function MISC:Mover_OnLeave()
	M.SetBorderColor(self.bg)
	self.text:SetTextColor(1, 1, 1)
end

function MISC:Mover_OnDragStart()
	self:StartMoving()
	MISC.UpdateTrimFrame(self)
	updater.__owner = self
	updater:Show()
end

function MISC:Mover_OnDragStop()
	self:StopMovingOrSizing()
	local orig, _, tar, x, y = self:GetPoint()
	x = M:Round(x)
	y = M:Round(y)

	self:ClearAllPoints()
	self:SetPoint(orig, "UIParent", tar, x, y)
	R.db[self.__key][self.__value] = {orig, "UIParent", tar, x, y}
	MISC.UpdateTrimFrame(self)
	updater:Hide()
end

function MISC:UnlockElements()
	for i = 1, #MoverList do
		local mover = MoverList[i]
		if not mover:IsShown() and not mover.isDisable then
			mover:Show()
		end
	end
	f:Show()
end

function MISC:LockElements()
	for i = 1, #MoverList do
		local mover = MoverList[i]
		mover:Hide()
	end
	f:Hide()
	--SlashCmdList["TOGGLEGRID"]("1")
	SlashCmdList.AuraWatch("lock")
end

StaticPopupDialogs["RESET_MOVER"] = {
	text = U["Reset Mover Confirm"],
	button1 = OKAY,
	button2 = CANCEL,
	OnAccept = function()
		wipe(R.db["Mover"])
		wipe(R.db["AuraWatchMover"])
		ReloadUI()
	end,
}

-- Mover Console
local function CreateConsole()
	if f then return end

	f = CreateFrame("Frame", nil, UIParent)
	f:SetPoint("TOP", 0, -150)
	f:SetSize(212, 80)
	M.SetBD(f)
	M.CreateFS(f, 15, U["Mover Console"], "system", "TOP", 0, -8)
	local bu, text = {}, {LOCK, U["Grids"], U["AuraWatch"], RESET}
	for i = 1, 4 do
		bu[i] = M.CreateButton(f, 100, 22, text[i])
		if i == 1 then
			bu[i]:SetPoint("BOTTOMLEFT", 5, 29)
		elseif i == 3 then
			bu[i]:SetPoint("TOP", bu[1], "BOTTOM", 0, -2)
		else
			bu[i]:SetPoint("LEFT", bu[i-1], "RIGHT", 2, 0)
		end
	end

	-- Lock
	bu[1]:SetScript("OnClick", MISC.LockElements)
	-- Grids
	bu[2]:SetScript("OnClick", function()
		SlashCmdList["TOGGLEGRID"]("64")
	end)
	-- Cancel
	bu[3]:SetScript("OnClick", function(self)
		self.state = not self.state
		if self.state then
			SlashCmdList.AuraWatch("move")
		else
			SlashCmdList.AuraWatch("lock")
		end
	end)
	-- Reset
	bu[4]:SetScript("OnClick", function()
		StaticPopup_Show("RESET_MOVER")
	end)

	local header = CreateFrame("Frame", nil, f)
	header:SetSize(212, 30)
	header:SetPoint("TOP")
	M.CreateMF(header, f)

	local helpInfo = M.CreateHelpInfo(header, "|nCTRL +"..I.RightButton..U["Reset anchor"].."|nSHIFT +"..I.RightButton..U["Hide panel"])
	helpInfo:SetPoint("TOPRIGHT", 2, 5)

	local frame = CreateFrame("Frame", nil, f)
	frame:SetSize(212, 73)
	frame:SetPoint("TOP", f, "BOTTOM", 0, -3)
	M.SetBD(frame)
	f.__trimText = M.CreateFS(frame, 12, NONE, "system", "BOTTOM", 0, 5)

	local xBox = M.CreateEditBox(frame, 60, 22)
	xBox:SetPoint("TOPRIGHT", frame, "TOP", -12, -5)
	M.CreateFS(xBox, 14, "X", "system", "LEFT", -20, 0)
	xBox:SetJustifyH("CENTER")
	xBox.__current = 0
	xBox:HookScript("OnEnterPressed", function(self)
		local text = self:GetText()
		text = tonumber(text)
		if text then
			local diff = text - self.__current
			self.__current = text
			MISC:DoTrim(diff)
		end
	end)
	f.__x = xBox

	local yBox = M.CreateEditBox(frame, 60, 22)
	yBox:SetPoint("TOPRIGHT", frame, "TOP", -12, -29)
	M.CreateFS(yBox, 14, "Y", "system", "LEFT", -20, 0)
	yBox:SetJustifyH("CENTER")
	yBox.__current = 0
	yBox:HookScript("OnEnterPressed", function(self)
		local text = self:GetText()
		text = tonumber(text)
		if text then
			local diff = text - self.__current
			self.__current = text
			MISC:DoTrim(nil, diff)
		end
	end)
	f.__y = yBox

	local arrows = {}
	local arrowIndex = {
		[1] = {degree = 180, offset = -1, x = 28, y = 9},
		[2] = {degree = 0, offset = 1, x = 72, y = 9},
		[3] = {degree = 90, offset = 1, x = 50, y = 20},
		[4] = {degree = -90, offset = -1, x = 50, y = -2},
	}
	local function arrowOnClick(self)
		local modKey = IsModifierKeyDown()
		if self.__index < 3 then
			MISC:DoTrim(self.__offset * (modKey and 10 or 1))
		else
			MISC:DoTrim(nil, self.__offset * (modKey and 10 or 1))
		end
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	end

	for i = 1, 4 do
		arrows[i] = CreateFrame("Button", nil, frame)
		arrows[i]:SetSize(20, 20)
		M.PixelIcon(arrows[i], "Interface\\OPTIONSFRAME\\VoiceChat-Play", true)
		local arrowData = arrowIndex[i]
		arrows[i].__index = i
		arrows[i].__offset = arrowData.offset
		arrows[i]:SetScript("OnClick", arrowOnClick)
		arrows[i]:SetPoint("CENTER", arrowData.x, arrowData.y)
		arrows[i].Icon:SetPoint("TOPLEFT", 3, -3)
		arrows[i].Icon:SetPoint("BOTTOMRIGHT", -3, 3)
		arrows[i].Icon:SetRotation(math.rad(arrowData.degree))
	end

	local function showLater(event)
		if event == "PLAYER_REGEN_DISABLED" then
			if f:IsShown() then
				MISC:LockElements()
				M:RegisterEvent("PLAYER_REGEN_ENABLED", showLater)
			end
		else
			MISC:UnlockElements()
			M:UnregisterEvent(event, showLater)
		end
	end
	M:RegisterEvent("PLAYER_REGEN_DISABLED", showLater)
end

SlashCmdList["UI_MOVER"] = function()
	if InCombatLockdown() then
		UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT)
		return
	end
	CreateConsole()
	MISC:UnlockElements()
end
SLASH_UI_MOVER1 = "/moveit"

function MISC:OnLogin()
	updater = CreateFrame("Frame")
	updater:Hide()
	updater:SetScript("OnUpdate", function()
		MISC.UpdateTrimFrame(updater.__owner)
	end)

	MISC:DisableBlizzardMover()
end

-- Disable blizzard edit mode
local function isUnitFrameEnable()
	return R.db["UFs"]["Enable"]
end

local function isBuffEnable()
	return R.db["Auras"]["BuffFrame"] or R.db["Auras"]["HideBlizBuff"]
end

local function isActionbarEnable()
	return R.db["Actionbar"]["Enable"]
end

local function isCastbarEnable()
	return R.db["UFs"]["Enable"] and R.db["UFs"]["Castbars"]
end

local function isPartyEnable()
	return R.db["UFs"]["RaidFrame"] and R.db["UFs"]["PartyFrame"]
end

local function isRaidEnable()
	return R.db["UFs"]["RaidFrame"]
end

local function isArenaEnable()
	return R.db["UFs"]["Enable"] and R.db["UFs"]["Arena"]
end

function MISC:DisableBlizzardMover()
	local editMode = _G.EditModeManagerFrame

	-- account settings will be tainted
	local mixin = editMode.AccountSettings
	if isCastbarEnable() then mixin.RefreshCastBar = M.Dummy end
	if isBuffEnable() then mixin.RefreshBuffsAndDebuffs = M.Dummy end
	if isRaidEnable() then mixin.RefreshRaidFrames = M.Dummy end
	if isArenaEnable() then mixin.RefreshArenaFrames = M.Dummy end
	if isPartyEnable() then mixin.RefreshPartyFrames = M.Dummy end
	if isUnitFrameEnable() then
		mixin.RefreshTargetAndFocus = M.Dummy
		mixin.RefreshBossFrames = M.Dummy
	end
	if isActionbarEnable() then
		mixin.RefreshPetFrame = M.Dummy
		mixin.RefreshEncounterBar = M.Dummy
		mixin.RefreshActionBarShown = M.Dummy
		mixin.RefreshVehicleLeaveButton = M.Dummy
		mixin.ResetActionBarShown = M.Dummy
	end
end