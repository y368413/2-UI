local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")
----------------------------
-- Improved Loot Frame, by Cybeloras
-- RayUI Loot, by fgprodigal
----------------------------
local _G = getfenv(0)
local select, format = select, format
local upper = string.upper
local GetNumLootItems, GetLootSlotLink, GetLootSlotInfo = GetNumLootItems, GetLootSlotLink, GetLootSlotInfo

local ScrollBoxElementHeight = 46
local ScrollBoxSpacing = 2

local function AnnounceLoot(chn)
	for i = 1, GetNumLootItems() do
		local link = GetLootSlotLink(i)
		local quality = select(5, GetLootSlotInfo(i))
		if link and quality then  --and quality >= MISC.I["AnnounceRarity"]
			C_ChatInfo.SendChatMessage(format("- %MISC", link), chn)
		end
	end
end

-- Math
do
	-- AceTimer
	_G.LibStub("AceTimer-3.0"):Embed(MISC)

	function MISC:WaitFunc(elapse)
		local i = 1
		while i <= #MISC.WaitTable do
			local data = MISC.WaitTable[i]
			if data[1] > elapse then
				data[1], i = data[1] - elapse, i + 1
			else
				tremove(MISC.WaitTable, i)
				data[2](unpack(data[3]))

				if #MISC.WaitTable == 0 then
					MISC.WaitFrame:Hide()
				end
			end
		end
	end

	MISC.WaitTable = {}
	MISC.WaitFrame = CreateFrame("Frame", "NDuiPlus_WaitFrame", _G.UIParent)
	MISC.WaitFrame:SetScript("OnUpdate", MISC.WaitFunc)

	function MISC:Delay(delay, func, ...)
		if type(delay) ~= "number" or type(func) ~= "function" then
			return false
		end

		if delay < 0.01 then delay = 0.01 end

		if select("#", ...) <= 0 then
			C_Timer.After(delay, func)
		else
			tinsert(MISC.WaitTable,{delay,func,{...}})
			MISC.WaitFrame:Show()
		end

		return true
	end

	function MISC.WaitFor(condition, callback, interval, leftTimes)
		leftTimes = (leftTimes or 10) - 1
		interval = interval or 0.1

		if condition() then
			callback()
			return
		end

		if leftTimes and leftTimes <= 0 then
			return
		end

		MISC:Delay(interval, MISC.WaitFor, condition, callback, interval, leftTimes)
	end
end

local function Announce(chn)
	local nums = GetNumLootItems()
	if nums == 0 then return end
	--if MISC.I["AnnounceTitle"] then
		if UnitIsPlayer("target") or not UnitExists("target") then
			C_ChatInfo.SendChatMessage(format("*** %MISC ***", "箱子中的战利品"), chn)
		else
			C_ChatInfo.SendChatMessage(format("*** %MISC%MISC ***", UnitName("target"), "的战利品"), chn)
		end
	--end
	if IsInInstance() or chn ~= "say" then
		MISC:Delay(.1, AnnounceLoot, chn)
	else
		AnnounceLoot(chn)
	end
end

function MISC:LootEx()
	--if not MISC.I["Enable"] then return end

	local LootFrame = _G.LootFrame
	LootFrame.panelMaxHeight = 1000
	LootFrame.ScrollBox:SetPoint("BOTTOMRIGHT", -4, 4)

	local title = LootFrame:CreateFontString(nil, "OVERLAY")
	title:SetFont(I.Font[1], I.Font[2]+2, I.Font[3])
	title:SetPoint("TOPLEFT", 3, -4)
	title:SetPoint("TOPRIGHT", -105, -4)
	title:SetHeight(16)
	title:SetJustifyH("LEFT")
	LootFrame.title = title
	LootFrame:SetTitle("")

	function LootFrame:CalculateElementsHeight()
		return ScrollUtil.CalculateScrollBoxElementExtent(self.ScrollBox:GetDataProviderSize(), ScrollBoxElementHeight, ScrollBoxSpacing) - 8
	end

	hooksecurefunc(LootFrame, "Open", function(self)
		if UnitExists("target") and UnitIsDead("target") then
			self.title:SetText(UnitName("target"))
		else
			self.title:SetText(ITEMS)
		end

		for _, button in self.ScrollBox:EnumerateFrames() do
			if not button.__styled then
				if button.NameFrame then button.NameFrame:Hide() end
				if button.QualityStripe then button.QualityStripe:Hide() end
				if button.QualityText then button.QualityText:Hide() end

				button.__styled = true
			end
		end
	end)

	--if not MISC.I["Announce"] then return end

	local chn = { "say", "guild", "party", "raid"}
	local chncolor = {
		say = { 1, 1, 1},
		guild = { .25, 1, .25},
		party = { 2/3, 2/3, 1},
		raid = { 1, .5, 0},
	}

	LootFrame.announce = {}
	for i = 1, #chn do
		LootFrame.announce[i] = CreateFrame("Button", nil, LootFrame)
		LootFrame.announce[i]:SetSize(17, 17)
		M.PixelIcon(LootFrame.announce[i], I.normTex, true)
		M.CreateSD(LootFrame.announce[i])
		LootFrame.announce[i]:SetFrameLevel(999)
		LootFrame.announce[i].Icon:SetVertexColor(unpack(chncolor[chn[i]]))
		LootFrame.announce[i]:SetPoint("RIGHT", i==1 and LootFrame.ClosePanelButton or LootFrame.announce[i-1], "LEFT", -3, 0)
		LootFrame.announce[i]:SetScript("OnClick", function() Announce(chn[i]) end)
		LootFrame.announce[i]:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 5)
			GameTooltip:ClearLines()
			GameTooltip:AddLine("将战利品通报至".._G[upper(chn[i])])
			GameTooltip:Show()
		end)
		LootFrame.announce[i]:SetScript("OnLeave", M.HideTooltip)
	end
end