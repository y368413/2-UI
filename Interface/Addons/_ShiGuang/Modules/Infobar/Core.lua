local _, ns = ...
local M, R, U, I = unpack(ns)
local INFO = M:RegisterModule("Infobar")

local tinsert, pairs, unpack = table.insert, pairs, unpack
local GOLD_AMOUNT_SYMBOL = "|cffffd700●|r"--format("|cffffd700%s|r", GOLD_AMOUNT_SYMBOL)
local SILVER_AMOUNT_SYMBOL = "|cffb0b0b0●|r"--format("|cffd0d0d0%s|r", SILVER_AMOUNT_SYMBOL)
local COPPER_AMOUNT_SYMBOL = "|cffc77050●|r"--format("|cffc77050%s|r", COPPER_AMOUNT_SYMBOL)

INFO.modules = {}
INFO.leftModules, INFO.rightModules = {}, {}

function INFO:GetMoneyString(money, full)
	if money >= 1e6 and not full then
		return format(" %.0f%s", money / 1e4, GOLD_AMOUNT_SYMBOL)
	else
		if money > 0 then
			local moneyString = ""
			local gold, silver, copper = floor(money/1e4), floor(money/100) % 100, money % 100
			if gold > 0 then
				moneyString = " "..gold..GOLD_AMOUNT_SYMBOL
			end
			if silver > 0 then
				moneyString = moneyString.." "..silver..SILVER_AMOUNT_SYMBOL
			end
			if copper > 0 then
				moneyString = moneyString.." "..copper..COPPER_AMOUNT_SYMBOL
			end
			return moneyString
		else
			return " 0"..COPPER_AMOUNT_SYMBOL
		end
	end
end

function INFO:RegisterInfobar(name, point)
	local info = CreateFrame("Frame", nil, UIParent)
	info:SetHitRectInsets(0, 0, -10, -10)
	info.text = M.CreateFS(info, 13)
	info.text:ClearAllPoints()
	if R.Infobar.CustomAnchor then
		info.text:SetPoint(unpack(point))
		info.isActive = true
	end
	info:SetAllPoints(info.text)

	INFO.modules[strlower(name)] = info

	return info
end

function INFO:UpdateInfobarSize()
	for _, info in pairs(INFO.modules) do
		info.text:SetFont(I.Font[1], R.db["Misc"]["InfoSize"], I.Font[3])
	end
end

local function info_OnEvent(self, ...)
	if not self.isActive then return end
	self:onEvent(...)
end

function INFO:LoadInfobar(info)
	if info.eventList then
		for _, event in pairs(info.eventList) do
			info:RegisterEvent(event)
		end
		info:SetScript("OnEvent", info_OnEvent)
	end
	if info.onEnter then
		info:SetScript("OnEnter", info.onEnter)
	end
	if info.onLeave then
		info:SetScript("OnLeave", info.onLeave)
	end
	if info.onMouseUp then
		info:SetScript("OnMouseUp", info.onMouseUp)
	end
	if info.onUpdate then
		info:SetScript("OnUpdate", info.onUpdate)
	end
end

function INFO:BackgroundLines()
	local cr, cg, cb = 0, 0, 0
	if R.db["Skins"]["ClassLine"] then cr, cg, cb = I.r, I.g, I.b end

	local parent = UIParent
	local width, height = 460, 18
	local anchors = {
		[1] = {"TOPLEFT", 0, .5, 0, "LeftInfobar"},
		--[2] = {"TOP", 0, 0, .5, "RightInfobar"},
	}
	for _, v in pairs(anchors) do
		local frame = CreateFrame("Frame", "UI"..v[5], parent)
		frame:SetSize(width, height)
		frame:SetFrameStrata("BACKGROUND")
		M.Mover(frame, U[v[5]], v[5], {v[1], parent, v[1], 0, v[2]})

		if R.db["Skins"]["InfobarLine"] then
			local tex = M.SetGradient(frame, "H", 0, 0, 0, v[3], v[4], width, height)
			tex:SetPoint("CENTER")
			local bottomLine = M.SetGradient(frame, "H", cr, cg, cb, v[3], v[4], width, R.mult)
			bottomLine:SetPoint("TOP", frame, "BOTTOM")
			local topLine = M.SetGradient(frame, "H", cr, cg, cb, v[3], v[4], width, R.mult)
			topLine:SetPoint("BOTTOM", frame, "TOP")
		end
	end
end

function INFO:Infobar_UpdateValues()
	local modules = INFO.modules

	wipe(INFO.leftModules)
	for name in gmatch(R.db["Misc"]["InfoStrLeft"], "%[(%w+)%]") do
		if modules[name] and not modules[name].isActive then
			modules[name].isActive = true
			tinsert(INFO.leftModules, name) -- left to right
		end
	end

	wipe(INFO.rightModules)
	for name in gmatch(R.db["Misc"]["InfoStrRight"], "%[(%w+)%]") do
		if modules[name] and not modules[name].isActive then
			modules[name].isActive = true
			tinsert(INFO.rightModules, 1, name) -- right to left
		end
	end
end

function INFO:Infobar_UpdateAnchor()
	if R.Infobar.CustomAnchor then return end

	for _, info in pairs(INFO.modules) do
		info:Hide()
		info.isActive = false
	end

	INFO:Infobar_UpdateValues()

	local previousLeft
	for index, name in pairs(INFO.leftModules) do
		local info = INFO.modules[name]
		info.text:ClearAllPoints()
		if index == 1 then
			info.text:SetPoint("LEFT", _G["UILeftInfobar"], 0, 0)
		else
			info.text:SetPoint("LEFT", previousLeft, "RIGHT", 3, 0)
		end
		previousLeft = info

		info:Show()
		if info.onEvent then info:onEvent("PLAYER_ENTERING_WORLD") end
	end

	local previousRight
	for index, name in pairs(INFO.rightModules) do
		local info = INFO.modules[name]
		info.text:ClearAllPoints()
		if index == 1 then
			info.text:SetPoint("TOP", _G["UIRightInfobar"], 0, 0)
		else
			info.text:SetPoint("LEFT", previousRight, "RIGHT", 3, 0)
		end
		previousRight = info

		info:Show()
		if info.onEvent then info:onEvent("PLAYER_ENTERING_WORLD") end
	end
end

function INFO:GetTooltipAnchor(info)
	local _, height = info:GetCenter()
	if height and height > GetScreenHeight()/2 then
		return "TOP", "BOTTOM", -15
	else
		return "BOTTOM", "TOP", 15
	end
end

function INFO:OnLogin()
	if MaoRUIDB["DisableInfobars"] then return end

	for _, info in pairs(INFO.modules) do
		INFO:LoadInfobar(info)
	end

	INFO.loginTime = GetTime()
	INFO:BackgroundLines()
	--INFO:UpdateInfobarSize()
	INFO:Infobar_UpdateAnchor()
end