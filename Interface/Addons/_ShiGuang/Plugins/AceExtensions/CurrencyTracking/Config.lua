-- $Id: Config.lua 242 2022-07-23 08:25:29Z arithmandar $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs, ipairs, type = _G.pairs, _G.ipairs, _G.type
local math = _G.math
local table = _G.table
local tsort = table.sort
local string = _G.string
-- Libraries
local format = string.format
-- WoW
local GetSpellTexture, GetSpellInfo, GetItemInfo, GetItemCount = _G.GetSpellTexture, _G.GetSpellInfo, _G.GetItemInfo, _G.GetItemCount
local GetLocale = _G.GetLocale

local WoWClassicEra, WoWClassicTBC, WoWWOTLKC, WoWRetail, WoWDragonflight
local wowversion  = select(4, GetBuildInfo())
if wowversion < 20000 then
	WoWClassicEra = true
elseif wowversion < 30000 then 
	WoWClassicTBC = true
elseif wowversion < 40000 then 
	WoWWOTLKC = true
elseif wowversion < 100000 then
	WoWRetail = true
else
	WoWDragonflight = true
end
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local LibStub = _G.LibStub
local CurrencyTracking = LibStub("AceAddon-3.0"):GetAddon("CurrencyTracking")
local LibCurrencyInfo = LibStub:GetLibrary("LibCurrencyInfo")

local AceConfigReg = LibStub("AceConfigRegistry-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")

local profile
local item_list


local function orderednext(t, n)
	local key = t[t.__next]
	
	if not key then return end
	t.__next = t.__next + 1
	return key, t.__source[key]
end

local function orderedpairs(t, f)
	local keys, kn = {__source = t, __next = 1}, 1
	
	for k in pairs(t) do
		keys[kn], kn = k, kn + 1
	end
	tsort(keys, f)
	return orderednext, keys
end


-- /////////////////////////////////////////////////////////
-- Options
-- /////////////////////////////////////////////////////////
local optGetter, optSetter
do
	function optGetter(info)
		local key = info[#info]
		return CurrencyTracking.db.profile[key]
	end

	function optSetter(info, value)
		local key = info[#info]
		CurrencyTracking.db.profile[key] = value
		CurrencyTracking:Refresh()
	end
end

local aboutPanel, moduleOptions = nil, {}
local function getAboutPanel()
	if not aboutPanel then
		aboutPanel = {
			type = "group",
			name = CurrencyTracking_TITLE,
			args = {
				general = {
					order = 1,
					type = "group",
					name = "About",
					args = {
						description = {
							order = 10,
							type = "description",
							name = CurrencyTracking_Notes,
							width = "full",
						},
						info = {
							order = 20,
							type = "group",
							name = "Addon Info",
							inline = true,
							args = {
								version = {
									order = 21,
									type = "description",
									name = GAME_VERSION_LABEL..HEADER_COLON.." v7.02",
									width = "full",
								},
								update = {
									order = 22, 
									type = "description",
									name = UPDATE..HEADER_COLON.." 2022-08-21T14:39:55Z",
									width = "full",
								},
								author = {
									order = 23, 
									type = "description",
									name = "Author"..HEADER_COLON.." arith",
									width = "full",
								},
							},
						},
					},
				},
			},
		}
		for k,v in pairs(moduleOptions) do
			aboutPanel.args[k] = (type(v) == "function") and v() or v
		end
	end
	
	return aboutPanel
end

local options

local function getOptions()
	profile = CurrencyTracking.db.profile
	if not options then
		options = {
			order = 1,
			type = "group",
			name = "Options",
			get = optGetter,
			set = optSetter,
			args = {
						group1 = {
							order = 10,
							type = "group",
							name = CurrencyTracking_ON_SCREEN_FRAME,
							inline = true,
							args = {
								show_currency = {
									order = 11,
									type = "toggle",
									name = CurrencyTracking_OPT_SHOWONSCREEN,
									width = "full",
								},
								show_tooltip = {
									order = 11.1,
									type = "toggle",
									name = CurrencyTracking_SHOWTOOLTIP,
									desc = CurrencyTracking_SHOWTOOLTIPINFO,
									width = "full",
									disabled = function() return not CurrencyTracking.db.profile.show_currency end,
								},
								always_lock = {
									order = 12,
									type = "toggle",
									name = CurrencyTracking_OPT_ALWAYS_LOCK,
									desc = CurrencyTracking_OPT_ALWAYS_LOCK_TIP,
									width = "full",
									disabled = function() return not CurrencyTracking.db.profile.show_currency end,
								},
								hide_in_combat = {
									order = 13,
									type = "toggle",
									name = CURRENCYTRACKING_OPT_HIDE_IN_COMBAT,
									desc = CURRENCYTRACKING_OPT_HIDE_IN_COMBAT_DEC,
									width = "full",
									disabled = function() return not CurrencyTracking.db.profile.show_currency end,
								},
								hide_in_battleground = {
									order = 14,
									type = "toggle",
									name = CurrencyTracking_OPT_HIDE_IN_BATTLEGROUND,
									desc = CurrencyTracking_OPT_HIDE_IN_BATTLEGROUND_DEC,
									width = "full",
									disabled = function() return not CurrencyTracking.db.profile.show_currency end,
								},
								hide_in_petbattle = {
									order = 15,
									type = "toggle",
									name = CurrencyTracking_OPT_HIDE_IN_PETBATTLE,
									desc = CurrencyTracking_OPT_AUTO_HIDE_IN_PETBATTLE,
									width = "full",
									disabled = function() return not CurrencyTracking.db.profile.show_currency end,
								},
								resetPos = {
									order = 20, 
									type = "execute",
									name = CurrencyTracking_RESET_POSITION,
									desc = CurrencyTracking_RESET_SCREEN_POSITION,
									func = function()
										CurrencyTracking.frame:SetPoint("TOPLEFT", nil, "TOPLEFT", 150, -80)
										profile.point = { "TOPLEFT", "UIParent", "TOPLEFT", 150, -80 }
									end,
									disabled = function() return not CurrencyTracking.db.profile.show_currency end,
								},
							},
						},
						group2 = {
							order = 20,
							type = "group",
							name = CurrencyTracking_DISPLAYSETTINGS,
							inline = true,
							args = {
								show_money = {
									order = 21,
									type = "toggle",
									name = CurrencyTracking_SHOW_MONEY,
									desc = CurrencyTracking_ENABLE_SHOW_MONEY_WITH_CURRENCIES,
									width = "double",
								},
								showLowerDenominations = {
									order = 22,
									type = "toggle",
									name = CurrencyTracking_SHOW_LOWER_DENOMINATIONS,
									desc = CurrencyTracking_SHOW_LOWER_DENOMINATIONS_DEC,
									width = "double",
									disabled = function() return not CurrencyTracking.db.profile.show_money end,
								},
								breakupnumbers = {
									order = 23,
									type = "toggle",
									name = CurrencyTracking_BREAKUP_NUMBERS,
									desc = CurrencyTracking_OPT_BREAKUP_NUMBERS,
									width = "double",
								},
								hide_zero = {
									order = 24,
									type = "toggle",
									name = CurrencyTracking_HIDEZERO,
									desc = CurrencyTracking_AUTOHIDEITEMS,
									width = "double",
								},
								show_iconOnly = {
									order = 25,
									type = "toggle",
									name = CurrencyTracking_SHOW_ICON,
									desc = CurrencyTracking_SHOW_ICONINFO,
									width = "double",
								},
								icon_first = {
									order = 26,
									type = "toggle",
									name = CurrencyTracking_ICON_FIRST,
									desc = CurrencyTracking_OPT_ICON_PRIORTO_NUMBER,
									width = "double",
									disabled = function() return CurrencyTracking.db.profile.show_iconOnly end,
								},
								maxItems = {
									order = 27,
									type = "range",
									name = CurrencyTracking_MAXITEMS,
									desc = CurrencyTracking_MAXITEMSINFO,
									width = "double",
									min = 0, max = 60, bigStep = 1,
								},
							},
						},
						group3 = {
							order = 30,
							type = "group",
							name = CurrencyTracking_SCALE_TRANSPARENCY,
							inline = true,
							args = {
								group31 = {
									order = 20,
									type = "group",
									name = CurrencyTracking_ON_SCREEN_FRAME,
									inline = true,
									disabled = function() return not CurrencyTracking.db.profile.show_currency end,
									args = {
										scale = {
											order = 21,
											type = "range",
											name = CurrencyTracking_SCALE,
											min = 0.5, max = 2, bigStep = 0.1, 
										},
										alpha = {
											order = 22,
											type = "range",
											name = CurrencyTracking_TRANSPARENCY,
											min = 0, max = 1, bigStep = 0.1, 
										},
--[[
										bgalpha = {
											order = 23,
											type = "range",
											name = CurrencyTracking_BACKGROUND,
											desc = CurrencyTracking_OPT_BGTRANSPARENCY,
											min = 0, max = 1, bigStep = 0.1, 
										},
]]
									},
								},
								group32 = {
									order = 30,
									type = "group",
									name = CurrencyTracking_TOOLTIP,
									inline = true,
									args = {
										tooltip_scale = {
											order = 31,
											type = "range",
											name = CurrencyTracking_SCALE,
											min = 0, max = 1.75, bigStep = 0.01, 
										},
										tooltip_alpha = {
											order = 32,
											type = "range",
											name = CurrencyTracking_TRANSPARENCY,
											min = 0, max = 1, bigStep = 0.1, 
								},
							},
						},
					},
				},
			},
		}
	end
	
	return options
end

-- /////////////////////////////////////////////////////////
-- Currencies
-- /////////////////////////////////////////////////////////
local currenciesOptions = nil
local function currencyButton_ToggleTrack(id)
	profile = CurrencyTracking.db.profile
	if (not profile["currencies"][id]) then 
		profile["currencies"][id] = true
	else
		profile["currencies"][id] = nil
	end
	
	CurrencyTracking:Refresh()
end

local function getCurrenciesOptions()
	if not profile then profile = CurrencyTracking.db.profile end
	local lang = GetLocale()
	if not currenciesOptions then
		currenciesOptions = {
			type = "group",
			name = CurrencyTracking_TRACKED_CURRENCY,
			args = { },
		}
		local t = currenciesOptions.args
		local i = 1
		
		--for k,v in orderedpairs(LibCurrencyInfo.data.CurrencyByCategory) do
		for ki,vi in ipairs(CurrencyTracking.constants.currencyCategories) do
			local k = vi
			local v = LibCurrencyInfo.data.CurrencyByCategory[k]
			t["group"..i] = {}
			t["group"..i].order = i
			t["group"..i].type = "group"
			t["group"..i].name = LibCurrencyInfo:GetCurrencyCategoryNameByCategoryID(k, lang)
			t["group"..i].args = { }
			local j = 1
			local tg = t["group"..i].args
			for index, id in ipairs(v) do
				-- name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered, rarity, categoryID, categoryName, currencyDesc = lib:GetCurrencyByID(currencyID)
				local name, count, icon, _, _, totalMax, _, _, _, _, currencyDesc = LibCurrencyInfo:GetCurrencyByID(id)
				if not count then count = 0 end
				if not currencyDesc then 
					currencyDesc = ""
				else
					currencyDesc = currencyDesc.."\n\n"
				end
				
				if icon and name then
					local displayString = format("|T%d:16:16:2:0|t %s%s|r", icon or 0, count > 0 and HIGHLIGHT_FONT_COLOR_CODE or GRAY_FONT_COLOR_CODE, name or "")
					tg["currency"..index] = {}
					tg["currency"..index].order = index
					tg["currency"..index].type = "toggle"
					tg["currency"..index].name = displayString
					if (totalMax and totalMax > 0) then
						tg["currency"..index].desc = NORMAL_FONT_COLOR_CODE..currencyDesc..format(CURRENCY_TOTAL_CAP, HIGHLIGHT_FONT_COLOR_CODE, count, totalMax)
					else
						tg["currency"..index].desc = NORMAL_FONT_COLOR_CODE..currencyDesc..format(CURRENCY_TOTAL, HIGHLIGHT_FONT_COLOR_CODE, count)
					end
					tg["currency"..index].get = (function() return profile["currencies"][id] end)
					tg["currency"..index].set = (function() currencyButton_ToggleTrack(id) end)
				end
				j = j + 1
			end
			i = i + 1
		end
	end
	
	return currenciesOptions
end

-- /////////////////////////////////////////////////////////
-- Items
-- /////////////////////////////////////////////////////////
local itemOptions = nil
local function itemButton_ToggleTrack(itemID)
	if not profile then profile = CurrencyTracking.db.profile end
	if (not profile["items"][itemID]) then 
		profile["items"][itemID] = true 
	else
		profile["items"][itemID] = nil
	end

	CurrencyTracking:Refresh()
end

local function getItemOptions()
	if not profile then profile = CurrencyTracking.db.profile end
	if not item_list then item_list = CurrencyTracking.db.item_list end
	
	local function retrieveItems(tp, itemID, n)
		local itemName, icon, _
	
		if (item_list[itemID] and item_list[itemID][1] and item_list[itemID][2]) then
			itemName, icon = item_list[itemID][1], item_list[itemID][2]
		else
			itemName, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
			if not (itemName) then 
				itemName, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
			end
			if ( itemName and icon ) then
				item_list[itemID] = { itemName, icon, }
			end
		end
		local count = GetItemCount(itemID, true)
		
		if icon and itemName then
			local displayString = format("|T%d:16:16:2:0|t %s%s|r", icon, count > 0 and HIGHLIGHT_FONT_COLOR_CODE or GRAY_FONT_COLOR_CODE, itemName)
			tp["item"..n] = {}
			tp["item"..n].order = n
			tp["item"..n].type = "toggle"
			tp["item"..n].name = displayString
			tp["item"..n].desc = format(NORMAL_FONT_COLOR_CODE..CURRENCY_TOTAL, HIGHLIGHT_FONT_COLOR_CODE, count or 0)
			tp["item"..n].get = (function() return profile["items"][itemID] end)
			tp["item"..n].set = (function() itemButton_ToggleTrack(itemID) end)
		
			n = n + 1
		end
		
		return tp, n
	end
	
	if not itemOptions then
		itemOptions = {
			type = "group",
			name = CurrencyTracking_TRACKED_ITEMS,
			args = { },
		}
		local i = 1
		for k, v in pairs(CurrencyTracking.items) do
			itemOptions.args["group"..i] = {}
			itemOptions.args["group"..i].order = i
			itemOptions.args["group"..i].type = "group"
			itemOptions.args["group"..i].name = CurrencyTracking.constants.itemCategories[k]
			itemOptions.args["group"..i].args = { }
			local t = itemOptions.args["group"..i].args
			local j = 1
			for ka, va in ipairs(v) do
				if (WoWClassicEra and j > 1) then
					break
				elseif (WoWClassicTBC and j > 2) then 
					break
				elseif (WoWWOTLKC and j > 3) then
					break
				else
					t["group"..j] = {}
					t["group"..j].order = j
					t["group"..j].type = "group"
					t["group"..j].name = CurrencyTracking.constants.expansions[j]
					t["group"..j].inline = true
					t["group"..j].args = { }

					local n = 1
					local tp = t["group"..j].args

					for kb, vb in ipairs(va) do
						if (type(vb) == "number") then
							tp, n = retrieveItems(tp, vb, n)
						end
					end
				end
				j = j + 1
			end
			i = i + 1
		end
	end
	
	return itemOptions
end

local function openOptions(openItems)
	-- open the profiles tab before, so the menu expands
	InterfaceOptionsFrame_OpenToCategory(CurrencyTracking.optionsFrames.Profiles)
	InterfaceOptionsFrame_OpenToCategory(CurrencyTracking.optionsFrames.Profiles) -- yes, run twice to force the tre get expanded
	if (openItems) then
		InterfaceOptionsFrame_OpenToCategory(CurrencyTracking.optionsFrames.Items)
	else
		if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then
			InterfaceOptionsFrame_OpenToCategory(CurrencyTracking.optionsFrames.General)
		else
			InterfaceOptionsFrame_OpenToCategory(CurrencyTracking.optionsFrames.Currencies)
		end
	end
	InterfaceOptionsFrame:Raise()
end

function CurrencyTracking:OpenOptions(openItems) 
	openOptions(openItems)
end

local function giveProfiles()
	return AceDBOptions:GetOptionsTable(CurrencyTracking.db)
end

function CurrencyTracking:SetupOptions()
	self.optionsFrames = {}

	-- setup options table
	AceConfigReg:RegisterOptionsTable(CurrencyTracking_TITLE, getAboutPanel)
	self.optionsFrames.General = AceConfigDialog:AddToBlizOptions(CurrencyTracking_TITLE, nil, nil, "general")
	self:RegisterModuleOptions("Options", getOptions, BASE_SETTINGS )
	self:RegisterModuleOptions("Items", getItemOptions, CurrencyTracking_TRACKED_ITEMS)
	--addTokenOptionFrame()
	if (WoWRetail) then
	self:RegisterModuleOptions("Currencies", getCurrenciesOptions, CurrencyTracking_TRACKED_CURRENCY)
	end
	self:RegisterModuleOptions("Profiles", giveProfiles, CurrencyTracking_PROFILE_OPTIONS)
end

-- Description: Function which extends our options table in a modular way
-- Expected result: add a new modular options table to the modularOptions upvalue as well as the Blizzard config
-- Input:
--		name		: index of the options table in our main options table
--		optionsTable	: the sub-table to insert
--		displayName	: the name to display in the config interface for this set of options
-- Output: None.
function CurrencyTracking:RegisterModuleOptions(name, optionTbl, displayName)
	moduleOptions[name] = optionTbl
	self.optionsFrames[name] = AceConfigDialog:AddToBlizOptions(CurrencyTracking_TITLE, displayName, CurrencyTracking_TITLE, name)
end

