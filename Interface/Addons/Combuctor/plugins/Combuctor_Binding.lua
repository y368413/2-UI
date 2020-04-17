--## Author: kageneko

local L = {}
if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
L.Binding = "绑定"
L.All = "全部"
L.Account = "战网"
L.Equip = "装绑"
L.Use = "使用绑定"
L.Pickup = "拾取绑定"
L.Soulbound = "灵魂绑定"
else
L.Binding = "Binding"
L.All = "All"
L.Account = "Account"
L.Equip = "On Equip"
L.Use = "On Use"
L.Pickup = "On Pickup"
L.Soulbound = "Soulbound"
end

local tooltipCache = setmetatable({}, {__index = function(t, k) local v = {} t[k] = v return v end})
local tooltipScanner = _G['LibItemSearchTooltipScanner'] or CreateFrame('GameTooltip', 'LibItemSearchTooltipScanner', UIParent, 'GameTooltipTemplate')

local Addon = Combuctor

---- Copied pretty much wholesale from LibItemSearch 1.2-- 
local function link_FindSearchInTooltip(itemLink, search, bag, slot)
    local itemID = itemLink:match('item:(%d+)')
    if not itemID then
		return false
    end

    local cachedResult = tooltipCache[search][itemID]
    if cachedResult ~= nil then
		return cachedResult
    end

    tooltipScanner:SetOwner(UIParent, 'ANCHOR_NONE')
	tooltipScanner:SetBagItem(bag, slot)

	if _G[tooltipScanner:GetName() .. 'TextLeft1']:GetText() == nil then
		return false
	end
        
    local numLines = tooltipScanner:NumLines()
    local result = false
    if numLines > 1 and _G[tooltipScanner:GetName() .. 'TextLeft2']:GetText() == search then
		result = true
    elseif numLines > 2 and _G[tooltipScanner:GetName() .. 'TextLeft3']:GetText() == search then
		result = true
    elseif numLines > 3 and _G[tooltipScanner:GetName() .. 'TextLeft4']:GetText() == search then
		result = true
    elseif numLines > 4 and _G[tooltipScanner:GetName() .. 'TextLeft5']:GetText() == search then
		result = true
    elseif numLines > 5 and _G[tooltipScanner:GetName() .. 'TextLeft6']:GetText() == search then
		result = true
    end

	tooltipCache[search][itemID] = result
	return result
end

local function isBindToAccount(player, bag, slot, bagInfo, itemInfo)
    if not itemInfo then
        return false
    end
    link = itemInfo.link
    if not link then
        return false
    end
    return link_FindSearchInTooltip(link, ITEM_BIND_TO_BNETACCOUNT, bag, slot)
		or link_FindSearchInTooltip(link, ITEM_BNETACCOUNTBOUND, bag, slot)
		or link_FindSearchInTooltip(link, ITEM_BIND_TO_ACCOUNT, bag, slot)
		or link_FindSearchInTooltip(link, ITEM_ACCOUNTBOUND, bag, slot)
end

local function isBindOnEquip(player, bag, slot, bagInfo, itemInfo)
    if not itemInfo then
        return false
    end
    link = itemInfo.link
    if not link then
        return false
    end
    return link_FindSearchInTooltip(link, ITEM_BIND_ON_EQUIP, bag, slot) and not link_FindSearchInTooltip(link, ITEM_SOULBOUND, bag, slot)
end

local function isBindOnUse(player, bag, slot, bagInfo, itemInfo)
    if not itemInfo then
        return false
    end
    link = itemInfo.link
    if not link then
        return false
    end
    return link_FindSearchInTooltip(link, ITEM_BIND_ON_USE, bag, slot) and not link_FindSearchInTooltip(link, ITEM_SOULBOUND, bag, slot)
end

local function isBindOnPickup(player, bag, slot, bagInfo, itemInfo)
    if not itemInfo then
        return false
    end
    link = itemInfo.link
    if not link then
        return false
    end
    return link_FindSearchInTooltip(link, ITEM_BIND_ON_PICKUP, bag, slot)
end

local function isSoulbound(player, bag, slot, bagInfo, itemInfo)
    if not itemInfo then
        return false
    end
    link = itemInfo.link
    if not link then
        return false
    end
    return link_FindSearchInTooltip(link, ITEM_SOULBOUND, bag, slot)
end

local function isBinding(player, bag, slot, bagInfo, itemInfo)
    if not itemInfo then
        return false
    end
    link = itemInfo.link
    if not link then
        return false
    end
    return isBindToAccount(player, bag, slot, bagInfo, itemInfo)
		or isBindOnEquip(player, bag, slot, bagInfo, itemInfo)
		--or isBindOnUse(player, bag, slot, bagInfo, itemInfo)
		or isSoulbound(player, bag, slot, bagInfo, itemInfo)
end

Addon.Rules:New('binding', L.Binding, 'Interface/Icons/Achievement_Reputation_ArgentChampion', isBinding)
--Addon.Rules:New('binding/all', L.All, nil, isBinding)
--Addon.Rules:New('binding/use', L.Use, nil, isBindOnUse)
Addon.Rules:New('binding/soulbound', L.Soulbound, nil, isSoulbound)
Addon.Rules:New('binding/equip', L.Equip, nil, isBindOnEquip)
Addon.Rules:New('binding/account', L.Account, nil, isBindToAccount)
