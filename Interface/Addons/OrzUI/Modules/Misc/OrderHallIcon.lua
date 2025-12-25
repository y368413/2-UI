local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")
--[[
	职业大厅图标，取代自带的信息条
]]
local ipairs, format = ipairs, format
local IsShiftKeyDown = IsShiftKeyDown
local C_CurrencyInfo_GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo
local C_Garrison_GetCurrencyTypes = C_Garrison.GetCurrencyTypes
local C_Garrison_GetClassSpecCategoryInfo = C_Garrison.GetClassSpecCategoryInfo
local C_Garrison_RequestClassSpecCategoryInfo = C_Garrison.RequestClassSpecCategoryInfo
local LE_GARRISON_TYPE_7_0 = Enum.GarrisonType.Type_7_0_Garrison or Enum.GarrisonType.Type_7_0
local LE_FOLLOWER_TYPE_GARRISON_7_0 = Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower or Enum.GarrisonFollowerType.FollowerType_7_0

function MISC:OrderHall_CreateIcon()
	local hall = CreateFrame("Frame", "UIOrderHallIcon", UIParent)
	hall:SetSize(50, 50)
	hall:SetPoint("TOP", 0, -30)
	hall:SetFrameStrata("HIGH")
	hall:Hide()
	M.CreateMF(hall, nil, true)
	M.RestoreMF(hall)
	MISC.OrderHallIcon = hall

	hall.Icon = hall:CreateTexture(nil, "ARTWORK")
	hall.Icon:SetAllPoints()
	hall.Icon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
	hall.Icon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[I.MyClass]))
	hall.Category = {}

	hall:SetScript("OnEnter", MISC.OrderHall_OnEnter)
	hall:SetScript("OnLeave", MISC.OrderHall_OnLeave)
	hooksecurefunc(OrderHallCommandBar, "SetShown", function(_, state)
		hall:SetShown(state)
	end)

	-- Default objects
	M.HideOption(OrderHallCommandBar)
	M.HideObject(OrderHallCommandBar.CurrencyHitTest)
end

function MISC:OrderHall_Refresh()
	C_Garrison_RequestClassSpecCategoryInfo(LE_FOLLOWER_TYPE_GARRISON_7_0)
	local currency = C_Garrison_GetCurrencyTypes(LE_GARRISON_TYPE_7_0)
	local info = C_CurrencyInfo_GetCurrencyInfo(currency)
	self.name = info.name
	self.amount = info.quantity
	self.texture = info.iconFileID

	local categoryInfo = C_Garrison_GetClassSpecCategoryInfo(LE_FOLLOWER_TYPE_GARRISON_7_0)
	for index, info in ipairs(categoryInfo) do
		local category = self.Category
		if not category[index] then category[index] = {} end
		category[index].name = info.name
		category[index].count = info.count
		category[index].limit = info.limit
		category[index].description = info.description
		category[index].icon = info.icon
	end
	self.numCategory = #categoryInfo
end

function MISC:OrderHall_OnShiftDown(btn)
	if btn == "LSHIFT" then
		MISC.OrderHall_OnEnter(MISC.OrderHallIcon)
	end
end

local function getIconString(texture)
	return format("|T%s:12:12:0:0:64:64:5:59:5:59|t ", texture)
end

function MISC:OrderHall_OnEnter()
	MISC.OrderHall_Refresh(self)

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 5, -5)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(I.MyColor.._G["ORDER_HALL_"..I.MyClass])
	--GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(getIconString(self.texture)..self.name, self.amount, 1,1,1, 1,1,1)

	local blank
	for i = 1, self.numCategory do
		if not blank then
			GameTooltip:AddLine(" ")
			blank = true
		end
		local category = self.Category[i]
		if category then
			GameTooltip:AddDoubleLine(getIconString(category.icon)..category.name, category.count.."/"..category.limit, 1,1,1, 1,1,1)
			if IsShiftKeyDown() then
				GameTooltip:AddLine(category.description, .6,.8,1, 1)
			end
		end
	end

	GameTooltip:AddDoubleLine(" ", I.LineString)
	GameTooltip:AddDoubleLine(" ", U["Details by Shift"], 1,1,1, .6,.8,1)
	GameTooltip:Show()

	M:RegisterEvent("MODIFIER_STATE_CHANGED", MISC.OrderHall_OnShiftDown)
end

function MISC:OrderHall_OnLeave()
	GameTooltip:Hide()
	M:UnregisterEvent("MODIFIER_STATE_CHANGED", MISC.OrderHall_OnShiftDown)
end

function MISC:OrderHall_OnLoad(addon)
	if addon == "Blizzard_OrderHallUI" then
		MISC:OrderHall_CreateIcon()
		M:UnregisterEvent(self, MISC.OrderHall_OnLoad)
	end
end

function MISC:OrderHall_OnInit()
	if C_AddOns.IsAddOnLoaded("Blizzard_OrderHallUI") then
		MISC:OrderHall_CreateIcon()
	else
		M:RegisterEvent("ADDON_LOADED", MISC.OrderHall_OnLoad)
	end
end
MISC:RegisterMisc("OrderHallIcon", MISC.OrderHall_OnInit)