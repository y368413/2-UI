local _, ns = ...
local M, R, U, I = unpack(ns)
local A = M:GetModule("Auras")

local groups = I.ReminderBuffs[I.MyClass]
local iconSize = R.Auras.IconSize + 4
local frames, parentFrame = {}
local GetSpecialization, InCombatLockdown, GetZonePVPInfo, UnitInVehicle = GetSpecialization, InCombatLockdown, GetZonePVPInfo, UnitInVehicle
local IsInInstance, IsPlayerSpell, UnitBuff, GetSpellTexture = IsInInstance, IsPlayerSpell, UnitBuff, GetSpellTexture
local pairs, tinsert, next = pairs, table.insert, next

function A:Reminder_Update(cfg)
	local frame = cfg.frame
	local depend = cfg.depend
	local spec = cfg.spec
	local combat = cfg.combat
	local instance = cfg.instance
	local pvp = cfg.pvp
	local isPlayerSpell, isRightSpec, isInCombat, isInInst, isInPVP = true, true
	local inInst, instType = IsInInstance()

	if depend and not IsPlayerSpell(depend) then isPlayerSpell = false end
	if spec and spec ~= GetSpecialization() then isRightSpec = false end
	if combat and InCombatLockdown() then isInCombat = true end
	if instance and inInst and (instType == "scenario" or instType == "party" or instType == "raid") then isInInst = true end
	if pvp and (instType == "arena" or instType == "pvp" or GetZonePVPInfo() == "combat") then isInPVP = true end
	if not combat and not instance and not pvp then isInCombat, isInInst, isInPVP = true, true, true end

	frame:Hide()
	if isPlayerSpell and isRightSpec and (isInCombat or isInInst or isInPVP) and not UnitInVehicle("player") then
		for i = 1, 32 do
			local name, _, _, _, _, _, _, _, _, spellID = UnitBuff("player", i)
			if not name then break end
			if name and cfg.spells[spellID] then
				frame:Hide()
				return
			end
		end
		frame:Show()
	end
end

function A:Reminder_Create(cfg)
	local frame = CreateFrame("Frame", nil, parentFrame)
	frame:SetSize(iconSize, iconSize)
	M.PixelIcon(frame)
	M.CreateSD(frame)
	for spell in pairs(cfg.spells) do
		frame.Icon:SetTexture(GetSpellTexture(spell))
		break
	end
	frame.text = M.CreateFS(frame, 14, ADDON_MISSING, false, "TOP", 1, 15)
	frame:Hide()
	cfg.frame = frame

	tinsert(frames, frame)
end

function A:Reminder_UpdateAnchor()
	local index = 0
	local offset = iconSize + 5
	for _, frame in next, frames do
		if frame:IsShown() then
			frame:SetPoint("LEFT", offset * index, 0)
			index = index + 1
		end
	end
	parentFrame:SetWidth(offset * index)
end

function A:Reminder_OnEvent()
	for _, cfg in pairs(groups) do
		if not cfg.frame then A:Reminder_Create(cfg) end
		A:Reminder_Update(cfg)
	end
	A:Reminder_UpdateAnchor()
end

function A:InitReminder()
	if not groups then return end

	if MaoRUIPerDB["Auras"]["Reminder"] then
		if not parentFrame then
			parentFrame = CreateFrame("Frame", nil, UIParent)
			parentFrame:SetPoint("CENTER", -220, 130)
			parentFrame:SetSize(iconSize, iconSize)
		end
		parentFrame:Show()

		A:Reminder_OnEvent()
		M:RegisterEvent("UNIT_AURA", A.Reminder_OnEvent, "player")
		M:RegisterEvent("UNIT_EXITED_VEHICLE", A.Reminder_OnEvent)
		M:RegisterEvent("UNIT_ENTERED_VEHICLE", A.Reminder_OnEvent)
		M:RegisterEvent("PLAYER_REGEN_ENABLED", A.Reminder_OnEvent)
		M:RegisterEvent("PLAYER_REGEN_DISABLED", A.Reminder_OnEvent)
		M:RegisterEvent("ZONE_CHANGED_NEW_AREA", A.Reminder_OnEvent)
		M:RegisterEvent("PLAYER_ENTERING_WORLD", A.Reminder_OnEvent)
	else
		if parentFrame then
			parentFrame:Hide()
			M:UnregisterEvent("UNIT_AURA", A.Reminder_OnEvent)
			M:UnregisterEvent("UNIT_EXITED_VEHICLE", A.Reminder_OnEvent)
			M:UnregisterEvent("UNIT_ENTERED_VEHICLE", A.Reminder_OnEvent)
			M:UnregisterEvent("PLAYER_REGEN_ENABLED", A.Reminder_OnEvent)
			M:UnregisterEvent("PLAYER_REGEN_DISABLED", A.Reminder_OnEvent)
			M:UnregisterEvent("ZONE_CHANGED_NEW_AREA", A.Reminder_OnEvent)
			M:UnregisterEvent("PLAYER_ENTERING_WORLD", A.Reminder_OnEvent)
		end
	end
end