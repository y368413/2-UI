local _, ns = ...
local M, R, U, I = unpack(ns)
local A = M:GetModule("Auras")

if I.MyClass ~= "HUNTER" then return end

local pairs, IsEquippedItem = pairs, IsEquippedItem
local playerGUID = UnitGUID("player")

local GetSpellCost = {
	[53351]  = 10, -- 杀戮射击
	[19434]  = 35, -- 瞄准射击
	[185358] = 20, -- 奥术射击
	[257620] = 20, -- 多重射击
	[271788] = 10, -- 毒蛇钉刺
	[212431] = 20, -- 爆炸射击
	[186387] = 10, -- 爆裂射击
	[157863] = 35, -- 复活宠物
	[131894] = 20, -- 夺命黑鸦
	[120360] = 30, -- 弹幕射击
	[342049] = 20, -- 奇美拉射击
	[355589] = 15, -- 哀痛箭
}

function A:UpdateFocusCost(unit, _, spellID)
	if unit ~= "player" then return end

	local focusCal = A.MMFocus
	local cost = GetSpellCost[spellID]
	if cost then
		focusCal.cost = focusCal.cost + cost
	end
	if spellID == 19434 then
		--print("带着技巧读条："..tostring(focusCal.isTrickCast), "消耗技巧层数："..focusCal.trickActive)
		if (focusCal.isTrickCast and focusCal.trickActive == 1) or (not focusCal.isTrickCast and focusCal.trickActive == 0) then
			focusCal.cost = 35
			--print("此时重置集中值为35")
		end
	end
	focusCal:SetFormattedText("%d/40", focusCal.cost%40)
end

function A:ResetFocusCost()
	A.MMFocus.cost = 0
	A.MMFocus:SetFormattedText("%d/40", A.MMFocus.cost%40)
end

function A:ResetOnRaidEncounter(_, _, _, groupSize)
	if groupSize and groupSize > 5 then
		A:ResetFocusCost()
	end
end

local eventSpentIndex = {
	["SPELL_AURA_APPLIED"] = 1,
	["SPELL_AURA_REFRESH"] = 2,
	["SPELL_AURA_REMOVED"] = 0,
}

function A:CheckTrickState(...)
	local _, eventType, _, sourceGUID, _, _, _, _, _, _, _, spellID = ...
	if eventSpentIndex[eventType] and spellID == 257622 and sourceGUID == playerGUID then
		A.MMFocus.trickActive = eventSpentIndex[eventType]
	end
end

function A:StartAimedShot(unit, _, spellID)
	if unit ~= "player" then return end
	if spellID == 19434 then
		A.MMFocus.isTrickCast = A.MMFocus.trickActive ~= 0
	end
end

local hunterSets = {188856, 188858, 188859, 188860, 188861}

function A:CheckSetsCount()
	local count = 0
	for _, itemID in pairs(hunterSets) do
		if IsEquippedItem(itemID) then
			count = count + 1
		end
	end

	if count < 4 then
		A.MMFocus:Hide()
		M:UnregisterEvent("UNIT_SPELLCAST_START", A.StartAimedShot)
		M:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED", A.UpdateFocusCost)
		M:UnregisterEvent("PLAYER_DEAD", A.ResetFocusCost)
		M:UnregisterEvent("PLAYER_ENTERING_WORLD", A.ResetFocusCost)
		M:UnregisterEvent("ENCOUNTER_START", A.ResetOnRaidEncounter)
		M:UnregisterEvent("CLEU", A.CheckTrickState)
	else
		A.MMFocus:Show()
		M:RegisterEvent("UNIT_SPELLCAST_START", A.StartAimedShot)
		M:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", A.UpdateFocusCost)
		M:RegisterEvent("PLAYER_DEAD", A.ResetFocusCost)
		M:RegisterEvent("PLAYER_ENTERING_WORLD", A.ResetFocusCost)
		M:RegisterEvent("ENCOUNTER_START", A.ResetOnRaidEncounter)
		M:RegisterEvent("CLEU", A.CheckTrickState)
	end
end

local oldSpec
function A:ToggleFocusCalculation()
	if not A.MMFocus then return end

	local spec = GetSpecialization()
	if R.db["Auras"]["MMT29X4"] and spec == 2 then
		if self ~= "PLAYER_SPECIALIZATION_CHANGED" or spec ~= oldSpec then -- don't reset when talent changed only
			A:ResetFocusCost() -- reset calculation when switch on
		end
		A.MMFocus:Show()
		A:CheckSetsCount()
		M:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", A.CheckSetsCount)
	else
		M:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED", A.CheckSetsCount)
	end
	oldSpec = spec
end

function A:PostCreateLumos(self)
	local iconSize = self.lumos[1]:GetWidth()
	local boom = CreateFrame("Frame", nil, self.Health)
	boom:SetSize(iconSize, iconSize)
	boom:SetPoint("BOTTOM", self.Health, "TOP", 0, 5)
	M.AuraIcon(boom)
	boom:Hide()

	self.boom = boom

	-- MM hunter T29 4sets
	A.MMFocus = M.CreateFS(self.Health, 16)
	A.MMFocus:ClearAllPoints()
	A.MMFocus:SetPoint("BOTTOM", self.Health, "TOP", 0, 5)
	A.MMFocus.trickActive = 0
	A:ToggleFocusCalculation()
	M:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", A.ToggleFocusCalculation)
end

function A:PostUpdateVisibility(self)
	if self.boom then self.boom:Hide() end
end

local function GetUnitAura(unit, spell, filter)
	return A:GetUnitAura(unit, spell, filter)
end

local function UpdateCooldown(button, spellID, texture)
	return A:UpdateCooldown(button, spellID, texture)
end

local function UpdateBuff(button, spellID, auraID, cooldown, isPet, glow)
	return A:UpdateAura(button, isPet and "pet" or "player", auraID, "HELPFUL", spellID, cooldown, glow)
end

local function UpdateDebuff(button, spellID, auraID, cooldown, glow)
	return A:UpdateAura(button, "target", auraID, "HARMFUL", spellID, cooldown, glow)
end

local function UpdateSpellStatus(button, spellID)
	button.Icon:SetTexture(GetSpellTexture(spellID))
	if IsUsableSpell(spellID) then
		button.Icon:SetDesaturated(false)
	else
		button.Icon:SetDesaturated(true)
	end
end

local boomGroups = {
	[270339] = 186270,
	[270332] = 259489,
	[271049] = 259491,
}

function A:ChantLumos(self)
	local spec = GetSpecialization()
	if spec == 1 then
		UpdateCooldown(self.lumos[1], 34026, true)
		UpdateCooldown(self.lumos[2], 217200, true)
		UpdateBuff(self.lumos[3], 106785, 272790, false, true, "END")
		UpdateBuff(self.lumos[4], 19574, 19574, true, false, true)
		UpdateBuff(self.lumos[5], 193530, 193530, true, false, true)

	elseif spec == 2 then
		UpdateCooldown(self.lumos[1], 19434, true)
		UpdateCooldown(self.lumos[2], 257044, true)
		UpdateBuff(self.lumos[3], 257622, 257622)

		do
			local button = self.lumos[4]
			if IsPlayerSpell(260402) then
				UpdateBuff(button, 260402, 260402, true, false, true)
			elseif IsPlayerSpell(321460) then
				UpdateCooldown(button, 53351)
				UpdateSpellStatus(button, 53351)
			else
				UpdateBuff(button, 260242, 260242)
			end
		end

		UpdateBuff(self.lumos[5], 288613, 288613, true, false, true)

	elseif spec == 3 then
		UpdateDebuff(self.lumos[1], 259491, 259491, false, "END")

		do
			local button = self.lumos[2]
			if IsPlayerSpell(260248) then
				UpdateBuff(button, 260248, 260249)
			elseif IsPlayerSpell(162488) then
				UpdateDebuff(button, 162488, 162487, true)
			else
				UpdateDebuff(button, 131894, 131894, true)
			end
		end

		do
			local button = self.lumos[3]
			local boom = self.boom
			if IsPlayerSpell(271014) then
				boom:Show()

				local name, _, duration, expire, caster, spellID = GetUnitAura("target", 270339, "HARMFUL")
				if not name then name, _, duration, expire, caster, spellID = GetUnitAura("target", 270332, "HARMFUL") end
				if not name then name, _, duration, expire, caster, spellID = GetUnitAura("target", 271049, "HARMFUL") end
				if name and caster == "player" then
					boom.Icon:SetTexture(GetSpellTexture(boomGroups[spellID]))
					boom.CD:SetCooldown(expire-duration, duration)
					boom.CD:Show()
					boom.Icon:SetDesaturated(false)
				else
					local texture = GetSpellTexture(259495)
					if texture == GetSpellTexture(270323) then
						boom.Icon:SetTexture(GetSpellTexture(259489))
					elseif texture == GetSpellTexture(271045) then
						boom.Icon:SetTexture(GetSpellTexture(259491))
					else
						boom.Icon:SetTexture(GetSpellTexture(186270))	-- 270335
					end
					boom.Icon:SetDesaturated(true)
				end

				UpdateCooldown(button, 259495, true)
			else
				boom:Hide()
				UpdateDebuff(button, 259495, 269747, true)
			end
		end

		do
			local button = self.lumos[4]
			if IsPlayerSpell(260285) then
				UpdateBuff(button, 260285, 260286)
			elseif IsPlayerSpell(269751) then
				UpdateCooldown(button, 269751, true)
			else
				UpdateBuff(button, 259387, 259388, false, false, "END")
			end
		end

		UpdateBuff(self.lumos[5], 266779, 266779, true, false, true)
	end
end

--## Version: 3.4.0  ## Author: Cybeloras of Aerie Peak
local clientVersion = select(4, GetBuildInfo())
local wow_900 = clientVersion >= 90000
local wow_800 = clientVersion >= 80000
local wow_503 = clientVersion >= 50300

local maxSlots = NUM_PET_STABLE_PAGES * NUM_PET_STABLE_SLOTS

local NUM_PER_ROW, heightChange
if wow_900 then
	NUM_PER_ROW = 10
elseif wow_800 then
	NUM_PER_ROW = 10
	heightChange = 65
elseif wow_503 then
	NUM_PER_ROW = 10
	heightChange = 36
else
	NUM_PER_ROW = 7
	heightChange = 17
end

for i = NUM_PET_STABLE_SLOTS + 1, maxSlots do 
	if not _G["PetStableStabledPet"..i] then
		CreateFrame("Button", "PetStableStabledPet"..i, PetStableFrame, "PetStableSlotTemplate", i)
	end
end

for i = 1, maxSlots do
	local frame = _G["PetStableStabledPet"..i]
	if i > 1 then
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", _G["PetStableStabledPet"..i-1], "RIGHT", 7.3, 0)
	end
	frame:SetFrameLevel(PetStableFrame:GetFrameLevel() + 1)
	frame:SetScale(7/NUM_PER_ROW)
	frame.dimOverlay = frame:CreateTexture(nil, "OVERLAY");
	frame.dimOverlay:SetColorTexture(0, 0, 0, 0.8);
	frame.dimOverlay:SetAllPoints();
	frame.dimOverlay:Hide();
end

for i = NUM_PER_ROW+1, maxSlots, NUM_PER_ROW do
	_G["PetStableStabledPet"..i]:ClearAllPoints()
	_G["PetStableStabledPet"..i]:SetPoint("TOPLEFT", _G["PetStableStabledPet"..i-NUM_PER_ROW], "BOTTOMLEFT", 0, -5)
end

PetStableNextPageButton:Hide()
PetStablePrevPageButton:Hide()


function ImprovedStableFrame_Update()
	local input = ISF_SearchInput:GetText()
	if not input or input:trim() == "" then
		for i = 1, maxSlots do
			local button = _G["PetStableStabledPet"..i];
			button.dimOverlay:Hide();
		end
		return
	end

	for i = 1, maxSlots do
		local icon, name, level, family, talent = GetStablePetInfo(NUM_PET_ACTIVE_SLOTS + i);
		local button = _G["PetStableStabledPet"..i];

		button.dimOverlay:Show();
		if icon then
			local matched, expected = 0, 0
			for str in input:gmatch("([^%s]+)") do
				expected = expected + 1
				str = str:trim():lower()

				if name:lower():find(str)
				or family:lower():find(str)
				or talent:lower():find(str)
				then
					matched = matched + 1
				end
			end
			if matched == expected then
				button.dimOverlay:Hide();
			end
		end
	end
end

if wow_900 then
	local widthDelta = 315
	local heightDelta = 204
	local f = CreateFrame("Frame", "ImprovedStableFrameSlots", PetStableFrame, "InsetFrameTemplate")
	f:ClearAllPoints()
	f:SetSize(widthDelta, PetStableFrame:GetHeight() + heightDelta - 28)
	-- f:SetPoint("BOTTOMRIGHT", _G["PetStableStabledPet"..maxSlots], 5, -5)

	f:SetPoint(PetStableFrame.Inset:GetPoint(1))
	PetStableFrame.Inset:SetPoint("TOPLEFT", f, "TOPRIGHT")
	PetStableFrame:SetWidth(PetStableFrame:GetWidth() + widthDelta)
	PetStableFrame:SetHeight(PetStableFrame:GetHeight() + heightDelta)

	PetStableFrameModelBg:SetHeight(281 + heightDelta)

	local p, r, rp, x, y = PetStableModel:GetPoint(1)
	PetStableModel:SetPoint(p, r, rp, x, y - 32)

	PetStableStabledPet1:ClearAllPoints()
	PetStableStabledPet1:SetPoint("TOPLEFT", f, 8, -36)


	local searchInput = CreateFrame("EditBox", "ISF_SearchInput", f, "SearchBoxTemplate")
	searchInput:SetPoint("TOPLEFT", 9, 0)
	searchInput:SetPoint("RIGHT", -3, 0)
	searchInput:SetHeight(20)
	searchInput:HookScript("OnTextChanged", ImprovedStableFrame_Update)
	searchInput.Instructions:SetText(SEARCH .. " (" .. NAME .. ", " .. PET_FAMILIES .. ", " .. PET_TALENTS  .. ")")

	hooksecurefunc("PetStable_Update", ImprovedStableFrame_Update)
else

	PetStableStabledPet1:ClearAllPoints()
	PetStableStabledPet1:SetPoint("TOPLEFT", PetStableBottomInset, 9, -9)

	PetStableFrameModelBg:SetHeight(281 - heightChange)
	PetStableFrameModelBg:SetTexCoord(0.16406250, 0.77734375, 0.00195313, 0.55078125 - heightChange/512)

	PetStableFrameInset:SetPoint("BOTTOMRIGHT", PetStableFrame, "BOTTOMRIGHT", -6, 126 + heightChange)

	PetStableFrameStableBg:SetHeight(116 + heightChange)
end

NUM_PET_STABLE_SLOTS = maxSlots
NUM_PET_STABLE_PAGES = 1
PetStableFrame.page = 1


--PetHealthWarning------------------
local PetHealthWarningFrame=CreateFrame("ScrollingMessageFrame","PHA",UIParent)	
PetHealthWarningFrame:RegisterEvent("PLAYER_LOGIN")
PetHealthWarningFrame:RegisterEvent("UNIT_HEALTH")
PetHealthWarningFrame.Threshold=35
PetHealthWarningFrame.Warned=false
PetHealthWarningFrame:SetScript("OnEvent",function(Event,Arg1,...)
	if(Event=="PLAYER_LOGIN")then
			PetHealthWarningFrame:SetWidth(450)
			PetHealthWarningFrame:SetHeight(200)
			PetHealthWarningFrame:SetPoint("CENTER",UIParent,"CENTER",0,360)	
			PetHealthWarningFrame:SetFont("Interface\\addons\\_ShiGuang\\Media\\Fonts\\RedCircl.TTF",36,"THICKOUTLINE")
			PetHealthWarningFrame:SetShadowColor(0.00,0.00,0.00,0.75)
			PetHealthWarningFrame:SetShadowOffset(3.00,-3.00)
			PetHealthWarningFrame:SetJustifyH("CENTER")		
			PetHealthWarningFrame:SetMaxLines(2)
			--PetHealthWarningFrame:SetInsertMode("BOTTOM")
			PetHealthWarningFrame:SetTimeVisible(2)
			PetHealthWarningFrame:SetFadeDuration(1)		
			--HealthWatch:Update()
		return
	end	
	if(Event=="UNIT_HEALTH" and Arg1=="pet")then
			if(floor((UnitHealth("pet")/UnitHealthMax("pet"))*100)<=PetHealthWarningFrame_Threshold and PetHealthWarningFrame_Warned==false)then
				PlaySoundFile("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\Beep.ogg")	
				PetHealthWarningFrame:AddMessage("- CRITICAL PET HEALTH -", 1, 0, 0, nil, 3)
				PetHealthWarningFrame_Warned=true
				return
			end
			if(floor((UnitHealth("pet")/UnitHealthMax("pet"))*100)>PetHealthWarningFrame_Threshold) then
				PetHealthWarningFrame_Warned=false
				return
			end	
		return
	end	
end)