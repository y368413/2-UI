local _, ns = ...
local M, R, U, I = unpack(ns)
local S = M:GetModule("Skins")
local TT = M:GetModule("Tooltip")

function S:PGFSkin()
	if not R.db["Skins"]["BlizzardSkins"] then return end
	if not R.db["Skins"]["PGFSkin"] then return end
	if not C_AddOns.IsAddOnLoaded("PremadeGroupsFilter") then return end

	local DungeonPanel = _G.PremadeGroupsFilterDungeonPanel
	if not DungeonPanel then return end

	local ArenaPanel = _G.PremadeGroupsFilterArenaPanel
	local RBGPanel = _G.PremadeGroupsFilterRBGPanel
	local RaidPanel = _G.PremadeGroupsFilterRaidPanel
	local MiniPanel = _G.PremadeGroupsFilterMiniPanel
	local RolePanel = _G.PremadeGroupsFilterRolePanel
	local PGFDialog = _G.PremadeGroupsFilterDialog

	local names = {"Difficulty", "MPRating", "Members", "Tanks", "Heals", "DPS", "Partyfit", "BLFit", "BRFit", "Defeated", "MatchingId", "PvPRating", "NotDeclined"}

	local function handleDropdown(drop)
		M.StripTextures(drop)

		local bg = M.CreateBDFrame(drop, 0, true)
		bg:SetPoint("TOPLEFT", 16, -4)
		bg:SetPoint("BOTTOMRIGHT", -18, 8)

		local down = drop.Button
		down:ClearAllPoints()
		down:SetPoint("RIGHT", bg, -2, 0)
		M.ReskinArrow(down, "down")
	end

	local function handleGroup(panel)
		for _, name in pairs(names) do
			local frame = panel.Group[name]
			if frame then
				local check = frame.Act
				if check then
					check:SetSize(26, 26)
					check:SetPoint("TOPLEFT", 5, -1)
					M.ReskinCheck(check)
				end
				local input = frame.Min
				if input then
					M.ReskinInput(input)
					M.ReskinInput(frame.Max)
				end
				if frame.DropDown then
					handleDropdown(frame.DropDown)
				end
			end
		end

		M.ReskinInput(panel.Advanced.Expression)
	end

	local styled
	hooksecurefunc(PGFDialog, "Show", function(self)
		if styled then return end
		styled = true

		M.StripTextures(self)
		M.SetBD(self):SetAllPoints()
		M.ReskinClose(self.CloseButton)
		M.Reskin(self.ResetButton)
		M.Reskin(self.RefreshButton)

		M.ReskinInput(MiniPanel.Advanced.Expression)
		M.ReskinInput(MiniPanel.Sorting.Expression)

		local button = self.MaxMinButtonFrame
		if button.MinimizeButton then
			M.ReskinArrow(button.MinimizeButton, "down")
			button.MinimizeButton:ClearAllPoints()
			button.MinimizeButton:SetPoint("RIGHT", self.CloseButton, "LEFT", -3, 0)
			M.ReskinArrow(button.MaximizeButton, "up")
			button.MaximizeButton:ClearAllPoints()
			button.MaximizeButton:SetPoint("RIGHT", self.CloseButton, "LEFT", -3, 0)
		end

		handleGroup(RaidPanel)
		handleGroup(DungeonPanel)
		handleGroup(ArenaPanel)
		handleGroup(RBGPanel)
		handleGroup(RolePanel)

		for i = 1, 8 do
			local dungeon = DungeonPanel.Dungeons["Dungeon"..i]
			local check = dungeon and dungeon.Act
			if check then
				check:SetSize(26, 26)
				check:SetPoint("TOPLEFT", 5, -1)
				M.ReskinCheck(check)
			end
		end
	end)

	hooksecurefunc(PGFDialog, "ResetPosition", function(self)
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", PVEFrame, "TOPRIGHT", 2, 0)
	end)
--[[
	local PGFDialog = _G.PremadeGroupsFilterDialog

	local tipStyled
	hooksecurefunc(PremadeGroupsFilter.Debug, "PopupMenu_Initialize", function()
		if tipStyled then return end
		for i = 1, PGFDialog:GetNumChildren() do
			local child = select(i, PGFDialog:GetChildren())
			if child and child.Shadow then
				TT.ReskinTooltip(child)
				tipStyled = true
				break
			end
		end
	end)
]]
	local button = UsePGFButton
	if button then
		M.ReskinCheck(button)
		button.text:SetWidth(35)
	end

	local popup = PremadeGroupsFilterStaticPopup
	if popup then
		M.StripTextures(popup)
		M.SetBD(popup)
		M.ReskinInput(popup.EditBox)
		M.Reskin(popup.Button1)
		M.Reskin(popup.Button2)
	end
end