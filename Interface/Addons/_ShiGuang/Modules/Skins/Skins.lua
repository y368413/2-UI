local _, ns = ...
local M, R, U, I = unpack(ns)
local S = M:RegisterModule("Skins")

local pairs, wipe = pairs, wipe
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded

R.defaultThemes = {}
R.themes = {}
R.otherSkins = {}

function S:RegisterSkin(addonName, func)
	R.otherSkins[addonName] = func
end

function S:LoadSkins(list)
	if not next(list) then return end

	for addonName, func in pairs(list) do
		local isLoaded, isFinished = IsAddOnLoaded(addonName)
		if isLoaded and isFinished then
			func()
			list[addonName] = nil
		end
	end
end

function S:LoadAddOnSkins()
	if IsAddOnLoaded("AuroraClassic") or IsAddOnLoaded("Aurora") then return end

	-- Reskin Blizzard UIs
	for _, func in pairs(R.defaultThemes) do
		func()
	end
	wipe(R.defaultThemes)

	S:LoadSkins(R.themes) -- blizzard ui
	S:LoadSkins(R.otherSkins) -- other addons

	M:RegisterEvent("ADDON_LOADED", function(_, addonName)
		local func = R.themes[addonName]
		if func then
			func()
			R.themes[addonName] = nil
		end

		local func = R.otherSkins[addonName]
		if func then
			func()
			R.otherSkins[addonName] = nil
		end
	end)
end

function S:OnLogin()
   ----BOTTOM
   if R.db["Skins"]["InfobarLine"] then
   local Bottomline = CreateFrame("Frame", nil, UIParent) 
   Bottomline:SetFrameLevel(0) 
   Bottomline:SetFrameStrata("BACKGROUND")
   Bottomline:SetHeight(16)
   Bottomline:SetWidth(UIParent:GetWidth())
   Bottomline:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 0) 
   end

	self:LoadAddOnSkins()
	-- Add Skins
	self:DBMSkin()
	self:PGFSkin()
	--self:ReskinRematch()
	self:OtherSkins()
	self:LootEx()		-- 拾取增强
	-- Register skin
	local media = LibStub and LibStub("LibSharedMedia-3.0", true)
	if media then
		media:Register("statusbar", "normTex", I.normTex)
		media:Register("statusbar", "ShiGuang", [[Interface\Addons\_ShiGuang\Media\Modules\Raid\ColorBar]])
		media:Register("statusbar", "SorasThreat", [[Interface\Addons\_ShiGuang\Media\Modules\Raid\SorasThreatbar]])
		media:Register("statusbar", "HalfStyle", [[Interface\Addons\_ShiGuang\Media\Modules\Skada\YaSkada05]])
		media:Register("statusbar", "AtlzSkada", [[Interface\Addons\_ShiGuang\Media\Modules\Skada\AtlzSkada]])
		media:Register("statusbar", "Yaskada", [[Interface\Addons\_ShiGuang\Media\Modules\Skada\Yaskada]])
		media:Register("statusbar", "Yaskada02", [[Interface\Addons\_ShiGuang\Media\Modules\Skada\Yaskada02]])
		media:Register("statusbar", "Yaskada03", [[Interface\Addons\_ShiGuang\Media\Modules\Skada\Yaskada03]])
		media:Register("statusbar", "Yaskada04", [[Interface\Addons\_ShiGuang\Media\Modules\Skada\Yaskada04]])
		media:Register("statusbar", "Rainbow", [[Interface\Addons\_ShiGuang\Media\Modules\Skada\Rainbow]])
		media:Register("statusbar", "Fire", [[Interface\Addons\_ShiGuang\Media\Modules\Skada\Fire]])
		media:Register("statusbar", "Cold", [[Interface\Addons\_ShiGuang\Media\Modules\Skada\Cold]])
		media:Register("statusbar", "RainowCat", [[Interface\Addons\_ShiGuang\Media\Modules\Skada\RainowCat]])
		media:Register("statusbar", "None",	[[Interface\Addons\_ShiGuang\Media\backdrop]])
		media:Register("font", "Vera Serif", [[Interface\Addons\_ShiGuang\Media\Fonts\Pixel.ttf]])
	end
	  local function noop() end
    local function DisableBlzFrame(frame)
	     frame.RegisterEvent = noop
	     frame.Show = noop
	     frame:UnregisterAllEvents()
	     frame:Hide()
    end
	if R.db["Skins"]["CastBarstyle"] then DisableBlzFrame(TargetFrameSpellBar) DisableBlzFrame(FocusFrameSpellBar) DisableBlzFrame(PetCastingBarFrame) return end --CastingBarFrame
end

function S:GetToggleDirection()
	local direc = R.db["Skins"]["ToggleDirection"]
	if direc == 1 then
		return ">", "<", "RIGHT", "LEFT", -2, 0, 20, 80
	elseif direc == 2 then
		return "<", ">", "LEFT", "RIGHT", 2, 0, 20, 80
	elseif direc == 3 then
		return "∨", "∧", "BOTTOM", "TOP", 0, 2, 80, 20
	else
		return "∧", "∨", "TOP", "BOTTOM", 0, -2, 80, 20
	end
end

local toggleFrames = {}

local function CreateToggleButton(parent)
	local bu = CreateFrame("Button", nil, parent)
	bu:SetSize(20, 80)
	bu.text = M.CreateFS(bu, 18, nil, true)

	return bu
end

function S:CreateToggle(frame)
	local close = CreateToggleButton(frame)
	frame.closeButton = close

	local open = CreateToggleButton(UIParent)
	open:Hide()
	frame.openButton = open

	open:SetScript("OnClick", function()
		open:Hide()
	end)
	close:SetScript("OnClick", function()
		open:Show()
	end)

	S:SetToggleDirection(frame)
	tinsert(toggleFrames, frame)

	return open, close
end

function S:SetToggleDirection(frame)
	local str1, str2, rel1, rel2, x, y, width, height = S:GetToggleDirection()
	local parent = frame.bg
	local close = frame.closeButton
	local open = frame.openButton
	close:ClearAllPoints()
	close:SetPoint(rel1, parent, rel2, x, y)
	close:SetSize(width, height)
	open:ClearAllPoints()
	open:SetPoint(rel1, parent, rel1, -x, -y)
	open:SetSize(width, height)

	if R.db["Skins"]["ToggleDirection"] == 5 then
		close:SetScale(.001)
		close:SetAlpha(0)
		open:SetScale(.001)
		open:SetAlpha(0)
		close.text:SetText("")
		open.text:SetText("")
	else
		close:SetScale(1)
		close:SetAlpha(1)
		open:SetScale(1)
		open:SetAlpha(1)
		close.text:SetText(str1)
		open.text:SetText(str2)
	end
end

function S:RefreshToggleDirection()
	for _, frame in pairs(toggleFrames) do
		S:SetToggleDirection(frame)
	end
end
