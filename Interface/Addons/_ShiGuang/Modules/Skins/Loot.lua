local _, ns = ...
local M, R, U, I = unpack(ns)
local P = M:GetModule("Skins")

function P:LootEx()
--if not R.db["Skins"]["Loot"] then return end
------------------------------------------------------------ImprovedLootFrame
	--LOOTFRAME_AUTOLOOT_DELAY = 0.5;
	--LOOTFRAME_AUTOLOOT_RATE = 0.1;

	-- Woah, nice coding, blizz.
	-- Anchor something positioned at the top of the frame to the center of the frame instead,
	-- and make it an anonymous font string so I have to work to find it
	local i = 1

	while true do
		local r = select(i, LootFrame:GetRegions())
		if not r then break end
		if r.GetText and r:GetText() == ITEMS then
			r:ClearAllPoints()
			r:SetPoint("TOP", 12, -5)
		end
		i = i + 1
	end

if LootButton1 then
	-- Calculate base height of the loot frame
	local p, r, x, y = "TOP", "BOTTOM", 0, -4
	local buttonHeight = LootButton1:GetHeight() + abs(y)
	local baseHeight = LootFrame:GetHeight() - (buttonHeight * LOOTFRAME_NUMBUTTONS)
	LootFrame.OverflowText = LootFrame:CreateFontString(nil, "OVERLAY", "GameFontRedSmall")
	local OverflowText = LootFrame.OverflowText

	OverflowText:SetPoint("TOP", LootFrame, "TOP", 0, -26)
	OverflowText:SetPoint("LEFT", LootFrame, "LEFT", 60, 0)
	OverflowText:SetPoint("RIGHT", LootFrame, "RIGHT", -8, 0)
	OverflowText:SetPoint("BOTTOM", LootFrame, "TOP", 0, -65)

	OverflowText:SetSize(1, 1)
	OverflowText:SetJustifyH("LEFT")
	OverflowText:SetJustifyV("TOP")
	OverflowText:SetText("Hit 50-mob limit! Take some, then re-loot for more.")
	OverflowText:Hide()

	local t = {}
	local function CalculateNumMobsLooted()
		wipe(t)

		for i = 1, GetNumLootItems() do
			for n = 1, select("#", GetLootSourceInfo(i)), 2 do
				local GUID, num = select(n, GetLootSourceInfo(i))
				t[GUID] = true
			end
		end

		local n = 0
		for k, v in pairs(t) do
			n = n + 1
		end

		return n
	end

	hooksecurefunc("LootFrame_Show", function(self, ...)
		local maxButtons = floor(UIParent:GetHeight()/LootButton1:GetHeight() * 0.7)
		
		local num = GetNumLootItems()

		if self.AutoLootTable then
			num = #self.AutoLootTable
		end

		--self.AutoLootDelay = 0.4 + (num * 0.05)
		
		num = min(num, maxButtons)
		
		LootFrame:SetHeight(baseHeight + (num * buttonHeight))
		for i = 1, num do
			if i > LOOTFRAME_NUMBUTTONS then
				local button = _G["LootButton"..i]
				if not button then
					button = CreateFrame(ItemButtonMixin and "ItemButton" or "Button", "LootButton"..i, LootFrame, "LootButtonTemplate", i)
				end
				LOOTFRAME_NUMBUTTONS = i
			end
			if i > 1 then
				local button = _G["LootButton"..i]
				button:ClearAllPoints()
				button:SetPoint(p, "LootButton"..(i-1), r, x, y)
			end
		end

		if CalculateNumMobsLooted() >= 50 then
			OverflowText:Show()
		else
			OverflowText:Hide()
		end
		
		LootFrame_Update();
	end)

	local chn = { "raid", "party", "guild", "say"}
	local chncolor = {
		raid = { 1, .5, 0},
		party = { 2/3, 2/3, 1},
		guild = { .25, 1, .25},
		say = { 1, 1, 1},
	}

	local function Announce(chn)
		if (GetNumLootItems() == 0) then return end
		--if UnitIsPlayer("target") or not UnitExists("target") then -- Chests are hard to identify!
			--SendChatMessage(format("*** %s ***", "�����е�ս��Ʒ"), chn)
		--else
			--SendChatMessage(format("*** %s%s ***", UnitName("target"), "��ս��Ʒ"), chn)
		--end
		for i = 1, GetNumLootItems() do
			-- local link
			-- if (LootSlotHasItem(i)) then     --�жϣ�ֻ������Ʒ
				-- link = GetLootSlotLink(i)
			-- else
				-- _, link = GetLootSlotInfo(i)
			-- end
			local link = GetLootSlotLink(i)
			local quality = select(5, GetLootSlotInfo(i))
			if link and quality and quality >= 1 then
				local messlink = "- %s"
				SendChatMessage(format(messlink, link), chn)
			end
		end
	end

	LootFrame.announce = {}
	for i = 1, #chn do
		LootFrame.announce[i] = CreateFrame("Button", "ItemLootAnnounceButton"..i, LootFrame)
		LootFrame.announce[i]:SetSize(21, 21)
		M.PixelIcon(LootFrame.announce[i], I.normTex, true)
		M.CreateSD(LootFrame.announce[i])
		LootFrame.announce[i].Icon:SetVertexColor(unpack(chncolor[chn[i]]))
		if i==1 then
		LootFrame.announce[i]:SetPoint("TOPRIGHT", LootFrameCloseButton, "BOTTOM", 3, -3)
		else
		LootFrame.announce[i]:SetPoint("RIGHT", LootFrame.announce[i-1], "LEFT", -6, 0)
		end
		LootFrame.announce[i]:SetScript("OnClick", function() Announce(chn[i]) end)
	end
else
	LootFrame.panelMaxHeight = UIParent:GetHeight() * .7
end
end
