local _, ns = ...
local M, R, U, I = unpack(ns)
local A = M:GetModule("Auras")

if I.MyClass ~= "HUNTER" then return end

function A:PostCreateLumos(self)
	local iconSize = self.bu[1]:GetWidth()
	local boom = CreateFrame("Frame", nil, self.Health)
	boom:SetSize(iconSize, iconSize)
	boom:SetPoint("BOTTOM", self.Health, "TOP", 0, 5)
	M.AuraIcon(boom)

	self.boom = boom
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

local boomGroups = {
	[270339] = 186270,
	[270332] = 259489,
	[271049] = 259491,
}

function A:ChantLumos(self)
	if GetSpecialization() == 1 then
		UpdateCooldown(self.bu[1], 34026, true)
		UpdateCooldown(self.bu[2], 217200, true)
		UpdateBuff(self.bu[3], 106785, 272790, false, true, "END")
		UpdateBuff(self.bu[4], 19574, 19574, true, false, true)
		UpdateBuff(self.bu[5], 193530, 193530, true, false, true)

	elseif GetSpecialization() == 2 then
		UpdateCooldown(self.bu[1], 19434, true)

		do
			local button = self.bu[2]
			if IsPlayerSpell(271788) then
				UpdateDebuff(button, 271788, 271788)
			elseif IsPlayerSpell(131894) then
				UpdateDebuff(button, 131894, 131894, true)
			else
				if IsPlayerSpell(260367) then
					UpdateBuff(button, 260242, 260242)
				else
					UpdateCooldown(button, 257044, true)
				end
			end
		end

		do
			local button = self.bu[3]
			if IsPlayerSpell(193533) then
				local name, count, duration, expire, caster, spellID = GetUnitAura("target", 277959, "HARMFUL")
				if not name then name, count, duration, expire, caster, spellID = GetUnitAura("player", 193534, "HELPFUL") end
				if name and caster == "player" then
					button.Count:SetText(count)
					button.CD:SetCooldown(expire-duration, duration)
					button.CD:Show()
					button.Icon:SetDesaturated(false)
					button.Icon:SetTexture(GetSpellTexture(spellID))
				else
					button.Count:SetText("")
					button.CD:Hide()
					button.Icon:SetDesaturated(true)
					button.Icon:SetTexture(GetSpellTexture(193534))
				end
			elseif IsPlayerSpell(257284) then
				UpdateDebuff(button, 257284, 257284)
			else
				UpdateCooldown(button, 257044, true)
			end
		end

		do
			local button = self.bu[4]
			if IsPlayerSpell(260402) then
				UpdateBuff(button, 260402, 260402, true, false, true)
			elseif IsPlayerSpell(120360) then
				UpdateCooldown(button, 120360, true)
			else
				UpdateBuff(button, 260395, 260395)
			end
		end

		UpdateBuff(self.bu[5], 288613, 288613, true, false, true)

	elseif GetSpecialization() == 3 then
		UpdateDebuff(self.bu[1], 259491, 259491, false, "END")

		do
			local button = self.bu[2]
			if IsPlayerSpell(260248) then
				UpdateBuff(button, 260248, 260249)
			elseif IsPlayerSpell(162488) then
				UpdateDebuff(button, 162488, 162487, true)
			else
				UpdateDebuff(button, 131894, 131894, true)
			end
		end

		do
			local button = self.bu[3]
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
			local button = self.bu[4]
			if IsPlayerSpell(260285) then
				UpdateBuff(button, 260285, 260286)
			elseif IsPlayerSpell(269751) then
				UpdateCooldown(button, 269751, true)
			else
				UpdateBuff(button, 259387, 259388, false, false, "END")
			end
		end

		UpdateBuff(self.bu[5], 266779, 266779, true, false, true)
	end
end

--PetHealthWarning------------------
PetHealthAlert_Threshold=35
PetHealthAlert_Warned=false
-- Initialize
function PetHealthAlert_Initialize()	
	PetHealthAlert:SetWidth(450)
	PetHealthAlert:SetHeight(200)
	PetHealthAlert:SetPoint("CENTER",UIParent,"CENTER",0,360)	
	PetHealthAlert:SetFont("Interface\\addons\\HunterMaster\\Media\\REDCIRCL.TTF",36,"THICKOUTLINE")
	PetHealthAlert:SetShadowColor(0.00,0.00,0.00,0.75)
	PetHealthAlert:SetShadowOffset(3.00,-3.00)
	PetHealthAlert:SetJustifyH("CENTER")		
	PetHealthAlert:SetMaxLines(2)
	--PetHealthAlert:SetInsertMode("BOTTOM")
	PetHealthAlert:SetTimeVisible(2)
	PetHealthAlert:SetFadeDuration(1)		
	--HealthWatch:Update()
end
-- Update health warning
function PetHealthAlert_Update()	
	if(floor((UnitHealth("pet")/UnitHealthMax("pet"))*100)<=PetHealthAlert_Threshold and PetHealthAlert_Warned==false)then
		PlaySoundFile("Interface\\AddOns\\_ShiGuang\\Media\\Sounds\\beep.ogg")	
		PetHealthAlert:AddMessage("- CRITICAL PET HEALTH -", 1, 0, 0, nil, 3)
		PetHealthAlert_Warned=true
		return
	end
	if(floor((UnitHealth("pet")/UnitHealthMax("pet"))*100)>PetHealthAlert_Threshold)then
		PetHealthAlert_Warned=false
		return
	end	
end
local PetHealthAlert=CreateFrame("ScrollingMessageFrame","!PHA",UIParent)	
PetHealthAlert:RegisterEvent("PLAYER_LOGIN")
PetHealthAlert:RegisterEvent("UNIT_HEALTH")
PetHealthAlert:SetScript("OnEvent",function(Event,Arg1,...)
  if MaoRUIPerDB["Misc"]["HunterPetHelp"] then return end
	if(Event=="PLAYER_LOGIN")then
		PetHealthAlert_Initialize()
		return
	end	
	if(Event=="UNIT_HEALTH" and Arg1=="pet")then
		PetHealthAlert_Update()
		return
	end	
end)

--ImprovedStableFrame------------------
local maxSlots = NUM_PET_STABLE_PAGES * NUM_PET_STABLE_SLOTS
local NUM_PER_ROW, heightChange = 10, 60

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
end

PetStableStabledPet1:ClearAllPoints()
PetStableStabledPet1:SetPoint("TOPLEFT", PetStableBottomInset, 9, -9)

for i = NUM_PER_ROW+1, maxSlots, NUM_PER_ROW do
	_G["PetStableStabledPet"..i]:ClearAllPoints()
	_G["PetStableStabledPet"..i]:SetPoint("TOPLEFT", _G["PetStableStabledPet"..i-NUM_PER_ROW], "BOTTOMLEFT", 0, -5)
end

PetStableNextPageButton:Hide()
PetStablePrevPageButton:Hide()
PetStableFrameModelBg:SetHeight(281 - heightChange)
PetStableFrameModelBg:SetTexCoord(0.16406250, 0.77734375, 0.00195313, 0.55078125 - heightChange/512)
PetStableFrameInset:SetPoint("BOTTOMRIGHT", PetStableFrame, "BOTTOMRIGHT", -6, 126 + heightChange)
PetStableFrameStableBg:SetHeight(116 + heightChange)
NUM_PET_STABLE_SLOTS = maxSlots
NUM_PET_STABLE_PAGES = 1
PetStableFrame.page = 1