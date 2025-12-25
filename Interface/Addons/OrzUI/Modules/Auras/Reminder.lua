local _, ns = ...
local M, R, U, I = unpack(ns)
local A = M:GetModule("Auras")

local pairs, tinsert, next = pairs, table.insert, next
local GetZonePVPInfo = C_PvP and C_PvP.GetZonePVPInfo or GetZonePVPInfo
local GetSpecialization = GetSpecialization
local UnitIsDeadOrGhost, UnitInVehicle, InCombatLockdown = UnitIsDeadOrGhost, UnitInVehicle, InCombatLockdown
local IsInInstance, IsPlayerSpell = IsInInstance, IsPlayerSpell
local GetWeaponEnchantInfo, IsEquippedItem = GetWeaponEnchantInfo, IsEquippedItem
local GetNumGroupMembers = GetNumGroupMembers

local groups = I.ReminderBuffs[I.MyClass]
local iconSize = 36
local frames, parentFrame = {}

function A:Reminder_Update(cfg)
	local frame = cfg.frame
	local depend = cfg.depend
	local spec = cfg.spec
	local combat = cfg.combat
	local instance = cfg.instance
	local pvp = cfg.pvp
	local itemID = cfg.itemID
	local equip = cfg.equip
	local inGroup = cfg.inGroup
	local isPlayerSpell, isRightSpec, isEquipped, isGrouped, isInCombat, isInInst, isInPVP = true, true, true, true
	local inInst, instType = IsInInstance()
	local weaponIndex = cfg.weaponIndex

	if itemID then
		if inGroup and GetNumGroupMembers() < 2 then isGrouped = false end
		if equip and not IsEquippedItem(itemID) then isEquipped = false end
		if C_Item.GetItemCount(itemID) == 0 or (not isEquipped) or (not isGrouped) or C_Item.GetItemCooldown(itemID) > 0 then -- check item cooldown
			frame:Hide()
			return
		end
	end

	if depend and not IsPlayerSpell(depend) then isPlayerSpell = false end
	if spec and spec ~= GetSpecialization() then isRightSpec = false end
	if combat and InCombatLockdown() then isInCombat = true end
	if instance and inInst and (instType == "scenario" or instType == "party" or instType == "raid") then isInInst = true end
	if pvp and (instType == "arena" or instType == "pvp" or GetZonePVPInfo() == "combat") then isInPVP = true end
	if not combat and not instance and not pvp then isInCombat, isInInst, isInPVP = true, true, true end

	frame:Hide()
	if isPlayerSpell and isRightSpec and (isInCombat or isInInst or isInPVP) and not UnitInVehicle("player") and not UnitIsDeadOrGhost("player") then
		if weaponIndex then
			local hasMainHandEnchant, _, _, _, hasOffHandEnchant = GetWeaponEnchantInfo()
			if (hasMainHandEnchant and weaponIndex == 1) or (hasOffHandEnchant and weaponIndex == 2) then
				frame:Hide()
				return
			end
		else
			for i = 1, 40 do
				local auraData = C_UnitAuras.GetBuffDataByIndex("player", i, "HELPFUL")
				if not auraData then break end
				if auraData.spellId and cfg.spells[auraData.spellId] then
					frame:Hide()
					return
				end
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
	local texture = cfg.texture
	if not texture then
		for spellID in pairs(cfg.spells) do
			texture = C_Spell.GetSpellTexture(spellID)
			break
		end
	end
	frame.Icon:SetTexture(texture)
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

function A:Reminder_AddItemGroup()
	for _, value in pairs(I.ReminderBuffs["ITEMS"]) do
		if not value.disable and C_Item.GetItemCount(value.itemID) > 0 then
			if not value.texture then
				value.texture = C_Item.GetItemIconByID(value.itemID)
			end
			if not groups then groups = {} end
			tinsert(groups, value)
		end
	end
end

function A:InitReminder()
	A:Reminder_AddItemGroup()

	if not groups or not next(groups) then return end

	if R.db["Auras"]["Reminder"] then
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
		M:RegisterEvent("WEAPON_ENCHANT_CHANGED", A.Reminder_OnEvent)
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
			M:UnregisterEvent("WEAPON_ENCHANT_CHANGED", A.Reminder_OnEvent)
		end
	end
end