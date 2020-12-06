local _, ns = ...
local M, R, U, I = unpack(ns)
local module = M:RegisterModule("Infobar")
local tinsert, pairs, unpack = table.insert, pairs, unpack

function module:GetMoneyString(money, full)
	if money >= 1e6 and not full then
		return format("%.0f%s", money / 1e4, "|cffffd700●|r")
	else
		if money > 0 then
			local moneyString = ""
			local gold = floor(money / 1e4)
			if gold > 0 then
				moneyString = " "..gold.."|cffffd700●|r"
			end
			local silver = floor((money - (gold * 1e4)) / 100)
			if silver > 0 then
				moneyString = moneyString.." "..silver.."|cffb0b0b0●|r"
			end
			local copper = mod(money, 100)
			if copper > 0 then
				moneyString = moneyString.." "..copper.."|cffc77050●|r"
			end
			return moneyString
		else
			return " 0".."|cffc77050●|r"
		end
	end
end

function module:RegisterInfobar(name, point)
	if not self.modules then self.modules = {} end

	local info = CreateFrame("Frame", nil, UIParent)
	info:SetHitRectInsets(0, 0, -10, -10)
	info.text = M.CreateFS(info, R.Infobar.FontSize)
	info.text:ClearAllPoints()
	if R.Infobar.AutoAnchor then
		info.point = point
	else
		info.text:SetPoint(unpack(point))
	end
	info:SetAllPoints(info.text)
	info.name = name
	tinsert(self.modules, info)

	return info
end

function module:LoadInfobar(info)
	if info.eventList then
		for _, event in pairs(info.eventList) do
			info:RegisterEvent(event)
		end
		info:SetScript("OnEvent", info.onEvent)
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

function module:BackgroundLines()
	if not R.db["Skins"]["InfobarLine"] then return end

	local cr, cg, cb = 0, 0, 0
	if R.db["Skins"]["ClassLine"] then cr, cg, cb = I.r, I.g, I.b end

	local parent = UIParent
	local width, height = 450, 18
	local anchors = {
		[1] = {"TOPLEFT", 0, .5, 0},
		[2] = {"BOTTOMRIGHT", 0, 0, .5},
	}
	for _, v in pairs(anchors) do
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetPoint(v[1], parent, v[1], 0, v[2])
		frame:SetSize(width, height)
		frame:SetFrameStrata("BACKGROUND")

		local tex = M.SetGradient(frame, "H", 0, 0, 0, v[3], v[4], width, height)
		tex:SetPoint("CENTER")
		local bottomLine = M.SetGradient(frame, "H", cr, cg, cb, v[3], v[4], width, R.mult)
		bottomLine:SetPoint("TOP", frame, "BOTTOM")
		local topLine = M.SetGradient(frame, "H", cr, cg, cb, v[3], v[4], width, R.mult)
		topLine:SetPoint("BOTTOM", frame, "TOP")
	end
end

function module:OnLogin()
	if MaoRUIDB["DisableInfobars"] then return end

	if not self.modules then return end
	for _, info in pairs(self.modules) do
		self:LoadInfobar(info)
	end

	self:BackgroundLines()
	self.loginTime = GetTime()

	if not R.Infobar.AutoAnchor then return end
	for index, info in pairs(self.modules) do
		if index == 1 or index == 10 then
			info.text:SetPoint(unpack(info.point))
		else
			info.text:SetPoint("LEFT", self.modules[index-1], "RIGHT", 6, 0)
		end
	end
end