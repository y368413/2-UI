--## Author: wT  ## Version: 1.5.8
local _, BossesKilled = ...
if not BossesKilled.RegisterEvent and not BossesKilled.UnregisterEvent and not BossesKilled.UnregisterAllEvents then
	local f = CreateFrame("frame")
	f:SetScript("OnEvent", function(self, event, ...) BossesKilled[event](BossesKilled, ...) end)
	function BossesKilled:RegisterEvent(event) f:RegisterEvent(event) end
	function BossesKilled:UnregisterEvent(event) f:UnregisterEvent(event) end
	function BossesKilled:UnregisterAllEvents() f:UnregisterAllEvents() end
end

function BossesKilled:PLAYER_LOGIN()
	-- Hook raid finder frame's onshow and onhide
	if RaidFinderQueueFrame and RaidFinderQueueFrame_SetRaid then
		local function myRaidFinderFrame_OnShow(frame)
			self:CreateButtons(frame, GetNumRFDungeons, GetRFDungeonInfo, RaidFinderQueueFrame_SetRaid)
			self:UpdateButtonsAndTooltips(frame)
			self:UpdateQueueStatuses()
			--self.UpdateArrow()
			self:RegisterEvent("LFG_UPDATE")
			self.LFG_UPDATE = self.UpdateQueueStatuses -- Our event dispatcher calls functions like addon[eventName](...), so point it to the right update function
		end

		local function myRaidFinderFrame_OnHide(frame)
			self:UnregisterEvent("LFG_UPDATE")
		end

		RaidFinderQueueFrame:HookScript("OnShow", myRaidFinderFrame_OnShow)
		RaidFinderQueueFrame:HookScript("OnHide", myRaidFinderFrame_OnHide)
		--hooksecurefunc("RaidFinderQueueFrame_SetRaid", self.UpdateArrow)
	end
end
BossesKilled:RegisterEvent("PLAYER_LOGIN")

-- Creates the buttons. LFR and Flex use different functions and dropdown menus so take them as arguments
function BossesKilled:CreateButtons(parentFrame, DungeonAmountFunc, DungeonInfoFunc, SetDropdownMenuFunc)
	local scale = self:GetButtonScale(DungeonAmountFunc())

	if not parentFrame.BossesKilledButtons then
		parentFrame.BossesKilledButtons = {}
	end
	local buttons = parentFrame.BossesKilledButtons

	for i = 1, DungeonAmountFunc() do
		local id, name = DungeonInfoFunc(i)
		local isAvailable, isAvailableToPlayer = IsLFGDungeonJoinable(id)

		if isAvailable and isAvailableToPlayer and not buttons[id] and self.raidData[id] then
			local button = self:CreateButton(parentFrame, scale)
			buttons[id] = button
			button.dungeonID = id
			button.dungeonName = name
			parentFrame.lastButton = button
			-- I just realised a CheckButton might already have it's own FontString, but uh... whatever.
			button.number = self:CreateNumberFontstring(button)
			button:SetScript("OnEnter", function(this)
				if this.tooltip then
					self:ShowTooltip(this)
				end
			end)

			button:SetScript("OnClick", function(this)
				SetDropdownMenuFunc(this.dungeonID)
				--self.UpdateArrow()
				this:SetChecked(this.checked)
			end)
			button.checked = false
		end
	end
end

---------------------------------------- Overridables ----------------------------------------
function BossesKilled:CreateButton(parent, scale)
	local button = CreateFrame("CheckButton", parent:GetName().."BossesKilledButton"..tostring(id), parent, "SpellBookSkillLineTabTemplate")
	button:Show()

	if parent.lastButton then
		button:SetPoint("TOPLEFT", parent.lastButton, "BOTTOMLEFT", 0, -15)
	else
		local x = 3
		if IsAddOnLoaded("SocialTabs") then x = x + ceil(32 / scale) end
		button:SetPoint("TOPLEFT", parent, "TOPRIGHT", x, -50)
	end

	button:SetScale(scale)
	button:SetWidth(32 + 16) -- Originally 32
	for _, region in ipairs({button:GetRegions()}) do
		if type(region) ~= "userdata" and region.GetTexture and region:GetTexture() == "Interface\\SpellBook\\SpellBook-SkillLineTab" then
			region:SetWidth(64 + 24) -- Originally 64
			break
		end
	end
	return button
end

function BossesKilled:GetButtonScale(numDungeons) return min(480 / (numDungeons * 17), 1) end

-- Must return a fontstring
function BossesKilled:CreateNumberFontstring(parentButton)
	local number = parentButton:CreateFontString(parentButton:GetName().."Number", "OVERLAY", "SystemFont_Shadow_Huge3")
	number:SetPoint("TOPLEFT", -4, 4)
	number:SetPoint("BOTTOMRIGHT", 5, -5)
	return number
end

-- Must return a texture, which will be pointing to selected dungeon's button
function BossesKilled:CreateArrow()
	local arrow = GroupFinderFrame:CreateTexture("BossesKilledArrow", "ARTWORK")
	arrow:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
	arrow:SetTexCoord(1, 0, 0, 1) -- This somehow turns the arrow other way around. Magic. /shrug
	arrow:SetSize(32, 32) -- Originally 16, 16
	arrow:Hide()
	return arrow
end

--------------------------------------- Update functions -------------------------------------
function BossesKilled:UpdateButtonsAndTooltips(parentFrame)
	local buttons = parentFrame.BossesKilledButtons

	for id, button in pairs(buttons) do
		local numKilled = 0

		local index = self.raidData[id].startFrom
		local numEncounters = self.raidData[id].numEncounters

		local tooltip = {{text = button.dungeonName}} -- Set up tooltip data with the dungeon name
		for i = index, numEncounters + index - 1 do
      
            if id == 847 and i == 3 then i = 7 end
            if id == 846 and i == 4 then i = 3 end
            if id == 846 and i == 6 then i = 8 end
            if id == 848 and i == 7 then i = 4 end
            if id == 848 and i == 8 then i = 6 end      
            if id == 984 and i == 9 then i = 11 end
            if id == 985 and i == 10 then i = 9 end
            if id == 985 and i == 11 then i = 10 end

      
			local encounterLine = {}
			local bossName, _, isDead = GetLFGDungeonEncounterInfo(id, i)

			if isDead then
				if ENABLE_COLORBLIND_MODE == "0" then -- TODO: figure out if it's 0/false/null when not set
					encounterLine.color = {RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b}
				end
                if bossName == nil then
                    bossName = "bossname"
                    encounterLine.text = "X - "..bossName
                else 
				    encounterLine.text = "X - "..bossName
                    numKilled = numKilled + 1
                end
			else
				if ENABLE_COLORBLIND_MODE == "0" then
					encounterLine.color = {GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b}
				end
                if bossName == nil then
                    bossName = "bossname"
                    encounterLine.text = "O - "..bossName
                else 
				    encounterLine.text = "O - "..bossName
                end
			end
			table.insert(tooltip, encounterLine)
		end
		button.tooltip = tooltip

		local statusString = numKilled.."/"..numEncounters
		if ENABLE_COLORBLIND_MODE == "1" then button.number:SetFormattedText("|c00ffffff%s|r", statusString)
		else button.number:SetFormattedText(self.textColorTable[statusString], statusString)
		end
	end
end

function BossesKilled:UpdateQueueStatuses()
	for id, button in pairs(RaidFinderQueueFrame.BossesKilledButtons) do
		local mode = GetLFGMode(LE_LFG_CATEGORY_RF, id);
		if mode == "queued" or mode == "listed" or mode == "rolecheck" or mode == "suspended" then
			button:SetChecked(true)
			button.checked = true -- This is for the PostClick script earlier
		else
			button:SetChecked(false)
			button.checked = false
		end
	end
end

--[[ Not a method because it's used as callback for hooksecurefuncs so it would get the wrong "self"
function BossesKilled.UpdateArrow()
	--local self = BossesKilled

	if not BossesKilled.arrow then BossesKilled.arrow = BossesKilled:CreateArrow() end

	local parent
	if RaidFinderQueueFrame and RaidFinderQueueFrame:IsVisible() then
		parent = RaidFinderQueueFrame
	else
		BossesKilled.arrow:Hide()
		return
	end

	if parent.raid and parent.BossesKilledButtons[parent.raid] then
		local button = parent.BossesKilledButtons[parent.raid]
		BossesKilled.arrow:SetParent(button) -- Re-set the parent so we inherit the scale, so our smaller LFR buttons get a smaller arrow
		BossesKilled.arrow:SetPoint("LEFT", button, "RIGHT")
		BossesKilled.arrow:Show()
	end
end]]

--------------------------------- Tooltip and colorization stuff -----------------------------

function BossesKilled:ShowTooltip(button)
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	for i = 1, #button.tooltip do
		tooltip = button.tooltip[i]
		if tooltip.color then
			GameTooltip:AddLine(tooltip.text, unpack(tooltip.color))
		else
			GameTooltip:AddLine(tooltip.text)
		end
	end
	--GameTooltip:AddLine(" ")
	--GameTooltip:AddLine("<点击选择这个副本>")
	--GameTooltip:AddLine(" ")
	--if ENABLE_COLORBLIND_MODE == "1" then -- TODO: Remove duplicates. Only check for not ENABLE_COLORBLIND_MODE in which case add the first AddLine. After outside of if, add second AddLine
		--GameTooltip:AddLine("(Button lights up if you're queued for this raid)")
	--else
		--GameTooltip:AddLine("(|c00ff0000红色|r 就是你打过了, |c0000ff00绿的|r 就快去打,")
		--GameTooltip:AddLine(" 按钮亮起，说明你正在排这个本~)")
	--end
	GameTooltip:Show()
end

-- gets passed a "x/y" STRING. No sanity checks so make sure the calling function feeds it the expected format.
-- the vararg gets passed color triples, eg. 0.0,1.0,0.0,  1.0,0.0,0.0 (green to red)
function BossesKilled:TextColorGradient(str_percent, ...)
	local num = select("#", ...)
	local low, high = strmatch(str_percent, "(%d+)/(%d+)")
	local percent = (low + 0) / (high + 0) -- implicit cast to number, cheaper than tonumber
	local r, g, b

	if percent >= 1 then
		r, g, b = select(num - 2, ...), select(num - 1, ...), select(num, ...)
		return format("|cff%02x%02x%02x%%s|r", r * 255, g * 255, b * 255)
	elseif percent <= 0 then
		r, g, b = ...
		return format("|cff%02x%02x%02x%%s|r", r * 255, g * 255, b * 255)
	end

	local segment, relperc = math.modf(percent * (num / 3 - 1))
	local r1, g1, b1, r2, g2, b2
	r1, g1, b1 = select((segment * 3) + 1, ...), select((segment * 3) + 2, ...), select((segment * 3) + 3, ...)
	r2, g2, b2 = select((segment * 3) + 4, ...), select((segment * 3) + 5, ...), select((segment * 3) + 6, ...)

	if not r2 or not g2 or not b2 then
		r, g, b = r1, g1, b1
	else
		r, g, b = r1 + (r2 - r1) * relperc,
		          g1 + (g2 - g1) * relperc,
		          b1 + (b2 - b1) * relperc
	end
	return format("|cff%02x%02x%02x%%s|r", r * 255, g * 255, b * 255)
end

-- Use a memoization table so each x/y colorstring is only computed once and then does a simple lookup
BossesKilled.textColorTable = setmetatable({}, {__index = function(t, k)
	local colorStr = BossesKilled:TextColorGradient(k, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b, -- "From" color
	                                            RED_FONT_COLOR.r,   RED_FONT_COLOR.g,   RED_FONT_COLOR.b)   -- "To" color
	rawset(t, k, colorStr)
	return colorStr
end})

-- Index is from the first argument of DungeonInfoFunc.
-- This data table is needed as there's no way to find out how many encounters are in each part of the same raid (to my knowledge).
BossesKilled.raidData = {
  -- MoP Raid finder as of 5.4
  [527] = { numEncounters = 3, startFrom =  1 }, -- Guardians of Mogu'shan
  [528] = { numEncounters = 3, startFrom =  4 }, -- The Vault of Mysteries
  [529] = { numEncounters = 3, startFrom =  1 }, -- The Dread Approach
  [530] = { numEncounters = 3, startFrom =  4 }, -- Nightmare of Shek'zeer
  [526] = { numEncounters = 4, startFrom =  1 }, -- Terrace of Endless Spring
  [610] = { numEncounters = 3, startFrom =  1 }, -- Last Stand of the Zandalari
  [611] = { numEncounters = 3, startFrom =  4 }, -- Forgotten Depths
  [612] = { numEncounters = 3, startFrom =  7 }, -- Halls of Flesh-Shaping
  [613] = { numEncounters = 3, startFrom = 10 }, -- Pinnacle of Storms
  [716] = { numEncounters = 4, startFrom =  1 }, -- Vale of Eternal Sorrows
  [717] = { numEncounters = 4, startFrom =  5 }, -- Gates of Retribution
  [724] = { numEncounters = 3, startFrom =  9 }, -- The Underhold
  [725] = { numEncounters = 3, startFrom = 12 }, -- Downfall
  -- MoP Flex raids as of 5.4
  [726] = { numEncounters = 4, startFrom =  1 }, -- Vale of Eternal Sorrows
  [728] = { numEncounters = 4, startFrom =  5 }, -- Gates of Retribution
  [729] = { numEncounters = 3, startFrom =  9 }, -- The Underhold
  [730] = { numEncounters = 3, startFrom = 12 }, -- Downfall

  -- Highmaul LFR as of 6.0.3
  [849] = { numEncounters = 3, startFrom =  1 }, -- Walled City
  [850] = { numEncounters = 3, startFrom =  4 }, -- Arcane Sanctum
  [851] = { numEncounters = 1, startFrom =  7 }, -- Imperator's Rise
  -- Blackrock Foundry LFR as of 6.0.3
  [847] = { numEncounters = 3, startFrom =  1 }, -- Slagworks
  [846] = { numEncounters = 3, startFrom =  4 }, -- The Black Forge
  [848] = { numEncounters = 3, startFrom =  7 }, -- Iron Assembly
  [823] = { numEncounters = 1, startFrom =  10 }, -- Blackhand's Crucible
  -- .. LFR as of 6.2
  -- 18, 19, 21, 23, 25
  [982] = { numEncounters = 3, startFrom =  1 }, -- Hellbreach
  [983] = { numEncounters = 3, startFrom =  4 }, -- Halls of Blood
  [984] = { numEncounters = 3, startFrom =  7 }, -- Bastion of Shadows
  [985] = { numEncounters = 3, startFrom =  10 }, -- Destructor's Rise
  [986] = { numEncounters = 1, startFrom =  13 }, -- The Black Gate
  
  -- Emerald Nightmare LFR
  [1287] = { numEncounters = 3, startFrom =  1 }, -- Darkbough
  [1288] = { numEncounters = 3, startFrom =  1 }, -- Tormented Guardians 4
  [1289] = { numEncounters = 1, startFrom =  1 }, -- Rift of Aln 7
    
  -- Trial of Valor LFR
  [1411] = { numEncounters = 3, startFrom =  1 }, -- Trial of Valor
  
  -- Nighthold
  [1290] = { numEncounters = 3, startFrom =  1 }, -- Arcing Aqueducts
  [1291] = { numEncounters = 3, startFrom =  1 }, -- Royal Athenaeum 4
  [1292] = { numEncounters = 3, startFrom =  1 }, -- Nightspire 7
  [1293] = { numEncounters = 1, startFrom =  1 }, -- Betrayers Rise 10
	
	-- Tomb of Sargeras
	[1494] = { numEncounters = 3, startFrom =  1 }, -- The Gates of Hell
	[1495] = { numEncounters = 3, startFrom =  1 }, -- Wailing Halls
	[1496] = { numEncounters = 2, startFrom =  1 }, -- Chamber of the Avatar
	[1497] = { numEncounters = 1, startFrom =  1 }, -- Deceiver’s Fall

	-- Antorus, the Burning Throne
	[1610] = { numEncounters = 3, startFrom =  1 }, -- Light's Breach
	[1611] = { numEncounters = 3, startFrom =  1 }, -- Forbidden Descent
	[1612] = { numEncounters = 3, startFrom =  1 }, -- Hope's End
	[1613] = { numEncounters = 2, startFrom =  1 }, -- Seat of the Pantheon

  -- Uldir
  [1731] = { numEncounters = 3, startFrom =  1 }, -- Halls of Containment
  [1732] = { numEncounters = 3, startFrom =  1 }, -- Crimson Descent
  [1733] = { numEncounters = 2, startFrom =  1 }, -- Heart of Corruption
	
	-- Battle of Dazar'alor
	[1945] = { numEncounters = 3, startFrom =  1 },
	[1946] = { numEncounters = 3, startFrom =  1 },
	[1947] = { numEncounters = 3, startFrom =  1 },
	[1948] = { numEncounters = 3, startFrom =  1 },
	[1949] = { numEncounters = 3, startFrom =  1 },
	[1950] = { numEncounters = 3, startFrom =  1 },
	
	-- Crucible of Storms
	[1951] = { numEncounters = 2, startFrom =  1 }, -- Crucible of Storms
		
	-- The Eternal Palace
	[2009] = { numEncounters = 3, startFrom =  1 }, -- The Grand Reception
	[2010] = { numEncounters = 3, startFrom =  1 }, -- Depths of the Devoted
	[2011] = { numEncounters = 2, startFrom =  1 }, -- The Circle of Stars
	
	-- Ny'alotha, the Waking City
	[2036] = { numEncounters = 3, startFrom =  1 }, -- Vision of Destiny
	[2037] = { numEncounters = 4, startFrom =  1 }, -- Halls of Devotion
	[2038] = { numEncounters = 3, startFrom =  1 }, -- Gift of Flesh
	[2039] = { numEncounters = 2, startFrom =  1 }, -- The Waking Dream
}