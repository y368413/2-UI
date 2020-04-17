--## Author: Babe2212  ## Version: 8.0.5

local BFA_HF_Tracker = {}

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_BFA_HF_Tracker", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes", true)
BFA_HF_Tracker_HL = HL

local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes
local GetItemInfo = GetItemInfo
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementCriteriaInfoByID = GetAchievementCriteriaInfoByID
local GetCurrencyInfo = GetCurrencyInfo
local gl = GetLocale()
NPC_Name_CacheDB = NPC_Name_CacheDB or {}
Item_Name_CacheDB = Item_Name_CacheDB or {}

local ARTIFACT_LABEL = '|cffff8000' .. ARTIFACT_POWER .. '|r'

local cache_tooltip = CreateFrame("GameTooltip", "HN_BFA_HF_TrackerTooltip")
cache_tooltip:AddFontStrings(
    cache_tooltip:CreateFontString("$parentTextLeft1", nil, "GameTooltipText"),
    cache_tooltip:CreateFontString("$parentTextRight1", nil, "GameTooltipText")
)

function BFA_HF_Tracker_mob_name(id, npcLine)
	if npcLine == 2 then name = id.."_2"; elseif npcLine == 3 then name = id.."_3"; else name = id; end
	if NPC_Name_CacheDBtemp[gl] and NPC_Name_CacheDBtemp[gl][name] then
		return NPC_Name_CacheDBtemp[gl][name]
    elseif (not NPC_Name_CacheDBtemp[gl] or not NPC_Name_CacheDBtemp[gl][name]) and (not NPC_Name_CacheDB[gl] or not NPC_Name_CacheDB[gl][name]) then
        NPC_Name_CacheDB[gl] = NPC_Name_CacheDB[gl] or {}
		local TextLeft1, TextLeft2, TextLeft3
		cache_tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
        cache_tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
		if HN_BFA_HF_TrackerTooltipTextLeft1 then TextLeft1 = HN_BFA_HF_TrackerTooltipTextLeft1:GetText() end
		--local TextLeft1 = HN_BFA_HF_TrackerTooltipTextLeft1:GetText()
		if HN_BFA_HF_TrackerTooltipTextLeft2 then TextLeft2 = HN_BFA_HF_TrackerTooltipTextLeft2:GetText() end
		--local TextLeft2 = HN_BFA_HF_TrackerTooltipTextLeft2:GetText()
		if HN_BFA_HF_TrackerTooltipTextLeft3 then TextLeft3 = HN_BFA_HF_TrackerTooltipTextLeft3:GetText() end
		--local TextLeft3 = HN_BFA_HF_TrackerTooltipTextLeft3:GetText()
        if cache_tooltip:IsShown() then
			if npcLine == 3 and TextLeft2 and TextLeft3 then
				NPC_Name_CacheDB[gl][id.."_3"] = TextLeft1.."\n|cFFFFFFFF"..TextLeft2.."\n"..TextLeft3.."|r"
			elseif npcLine and npcLine >= 2 and TextLeft2 then
				NPC_Name_CacheDB[gl][id.."_2"] = TextLeft1.."\n|cFFFFFFFF"..TextLeft2.."|r"
			elseif TextLeft1 then
				NPC_Name_CacheDB[gl][name] = TextLeft1
			else
				return UNKNOWN
			end
        end
    end
    return NPC_Name_CacheDB[gl][name]
end
------------------ Function nameItemID --------------------
function BFA_HF_Tracker_nameItemID(itemId, bag)
	local itemName, itemLink
	if Item_Name_CacheDBtemp[gl] and Item_Name_CacheDBtemp[gl][itemId] then
		itemName = Item_Name_CacheDBtemp[gl][itemId]["name"]
		itemLink = Item_Name_CacheDBtemp[gl][itemId]["link"]
	elseif Item_Name_CacheDB[gl] and Item_Name_CacheDB[gl][itemId] then
		itemName = Item_Name_CacheDB[gl][itemId]["name"]
		itemLink = Item_Name_CacheDB[gl][itemId]["link"]
	else
		itemName, itemLink = GetItemInfo(itemId)
		if itemName and itemLink then
			Item_Name_CacheDB[gl] = Item_Name_CacheDB[gl] or {}
			Item_Name_CacheDB[gl][itemId] = Item_Name_CacheDB[gl][itemId] or {}
			Item_Name_CacheDB[gl][itemId]["name"] = itemName
			Item_Name_CacheDB[gl][itemId]["link"] = itemLink
		end
	end
	if bag == "bag" and itemName then
		for bag = BACKPACK_CONTAINER,NUM_BAG_SLOTS,1 do
			for slot = 1,GetContainerNumSlots(bag),1 do
				local ID = GetContainerItemID(bag,slot)
				if ID == itemId then
					return "|cFF00FF00"..itemName.."|r" -- vert
				end
			end
		end
		return "|cFFFF0000"..itemName.."|r" -- rouge
	elseif bag == "link" and itemLink then
		return itemLink
	elseif itemName then
		return itemName
	else
		return UNKNOWN
	end
end
------------------ Function icons -------------------------
local default_texture, npc_texture, follower_texture, currency_texture, junk_texture, cauldron_texture, timeRift_texture
local icon_cache = {}
local trimmed_icon = function(texture)
    if not icon_cache[texture] then
        icon_cache[texture] = {
            icon = texture,
            tCoordLeft = 0.1,
            tCoordRight = 0.9,
            tCoordTop = 0.1,
            tCoordBottom = 0.9,
        }
    end
    return icon_cache[texture]
end
local atlas_texture = function(atlas, scale)
    local texture, _, _, left, right, top, bottom = GetAtlasInfo(atlas)
    return {
        icon = texture,
        tCoordLeft = left,
        tCoordRight = right,
        tCoordTop = top,
        tCoordBottom = bottom,
        scale = scale or 1,
    }
end
local atlas_perso = function(texture, scale)
    return {
        icon = texture,
        scale = scale or 1,
    }
end
------------------ Function Buy items -----------------------
local function tooltipBuy(buy)
	local buy_2
	local buyItems
	if type(buy) == 'table' then
		if not buy.item or not buy.npc then return end
		if buy.bag then bag = buy.bag; else bag = "bag"; end
		if buy.to and type(buy.to) == 'string' then to = buy.to; else to = ""; end
		if type(buy.item) == 'table' then
			if #buy.item == 2 then
				buyItems = "\n"..BFA_HF_Tracker_nameItemID(buy.item[1], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[2], bag).."\n"
			elseif #buy.item == 3 then
				buyItems = "\n"..BFA_HF_Tracker_nameItemID(buy.item[1], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[2], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[3], bag).."\n"
			elseif #buy.item == 4 then
				buyItems = "\n"..BFA_HF_Tracker_nameItemID(buy.item[1], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[2], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[3], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[4], bag).."\n"
			elseif #buy.item == 5 then
				buyItems = "\n"..BFA_HF_Tracker_nameItemID(buy.item[1], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[2], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[3], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[4], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[5], bag).."\n"
			elseif #buy.item == 6 then
				buyItems = "\n"..BFA_HF_Tracker_nameItemID(buy.item[1], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[2], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[3], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[4], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[5], bag).."\n"..BFA_HF_Tracker_nameItemID(buy.item[6], bag).."\n"
			end
		else
			buyItems = BFA_HF_Tracker_nameItemID(buy.item, bag)
		end
		buy_2 = format(L["Buy %s from %s "], buyItems, BFA_HF_Tracker_mob_name(buy.npc))..to;
		return buy_2
	end
	if buy == 13087 then
		buy_2 = format(L["Buy %s from %s "], "\n"..BFA_HF_Tracker_nameItemID(155812, "bag").."\n"..BFA_HF_Tracker_nameItemID(155811, "bag").."\n"..BFA_HF_Tracker_nameItemID(155813, "bag").."\n"..BFA_HF_Tracker_nameItemID(155814, "bag").."\n", BFA_HF_Tracker_mob_name(128467)).."\n"..format(L["Use Cooking for %s"], "\n"..BFA_HF_Tracker_nameItemID(163781, "bag"));
	elseif buy == 130872 then
		buy_2 = format(L["Buy %s from %s "], "\n"..BFA_HF_Tracker_nameItemID(163110, "bag").."\n", BFA_HF_Tracker_mob_name(136655)).."\n"..format(L["Use Cooking for %s"], "\n"..BFA_HF_Tracker_nameItemID(163781, "bag"));
	elseif buy == 130873 then
		buy_2 = format(L["The recipe %s and loot on %s to Waycrest Manor"], "\n"..BFA_HF_Tracker_nameItemID(163833, "link").."\n", BFA_HF_Tracker_mob_name(131863));
	end
	return buy_2
end
-------------------------------------------------------------
local function tooltipNote2(note2)
	local note_2
	if type(note2) == 'table' then
		if not note2.text then return end
		note_2 = note2.text..BFA_HF_Tracker_mob_name(note2.npc)
	else
		note_2 = note2
	end
	return note_2
end
-------------------------------------------------------------
local function work_out_label(point, npcLine)
    local fallback
	local force
    if point.label and type(point.label) == "string" then
        return point.label
	elseif point.label and type(point.label) == "number" then
		force = point.label
    end
	if (point.npc and not force) or (point.npc and force == 1) then
        local name = BFA_HF_Tracker_mob_name(point.npc, npcLine)
        if name then
            return name
        end
        fallback = 'npc:'..point.npc
    end
    if (point.achievement and point.criteria and not force) or (point.achievement and point.criteria and force == 2) then
		if type(point.criteria) ~= 'table' then
			local criteria = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
			if criteria then
				return criteria
			end
			fallback = 'achievement:'..point.achievement..'.'..point.criteria
		end
    end
    if (point.follower and not force) or (point.follower and force == 3) then
        local follower = C_Garrison.GetFollowerInfo(point.follower)
        if follower then
            return follower.name
        end
        fallback = 'follower:'..point.follower
    end
    if (point.item and not force) or (point.item and force == 4) then
        local _, link, _, _, _, _, _, _, _, texture = GetItemInfo(point.item)
        if link then
            return link
        end
        fallback = 'item:'..point.item
    end
    if (point.currency and not force) or (point.currency and force == 5) then
        if point.currency == 'ARTIFACT' then
            return ARTIFACT_LABEL
        end
        local name, _, texture = GetCurrencyInfo(point.currency)
        if name then
            return name
        end
    end
    return fallback or UNKNOWN
end

local function work_out_texture(point)
	local default_texture
	if not point.scale then
		point.scale = 1
	end
    if point.atlas then
        if not icon_cache[point.atlas] then
            icon_cache[point.atlas] = atlas_texture("bags-junkcoin", point.scale)--point.atlas
        end
        return icon_cache[point.atlas]
    end
	if point.atlasHf then
		local texture = point.atlasHf
		if texture then
			return atlas_perso(texture, point.scale)
		end
	end
    if BFA_HF_Tracker_db.icon_item then
        if point.item then
            local texture = select(10, GetItemInfo(point.item))
            if texture then
                return trimmed_icon(texture)
            end
        end
        if point.currency then
            if point.currency == 'ARTIFACT' then
                local texture = select(10, GetAchievementInfo(11144))
                if texture then
                    return trimmed_icon(texture)
                end
            else
                local texture = select(3, GetCurrencyInfo(point.currency))
                if texture then
                    return trimmed_icon(texture)
                end
            end
        end
        if point.achievement then
            local texture = select(10, GetAchievementInfo(point.achievement))
            if texture then
                return trimmed_icon(texture)
            end
        end
    else
        if point.currency then
            if not currency_texture then
                currency_texture = atlas_texture("VignetteLoot", point.scale*1.5)
            end
            return currency_texture
        end
    end
	------------- Hauts Faits ------------
	if point.hf then
		if BFA_HF_Tracker_db.icon_item_hf then
			if point.item then
				local texture = select(10, GetItemInfo(point.item))
				if texture then
					return trimmed_icon(texture)
				end
			elseif point.achievement then
				local texture = select(10, GetAchievementInfo(point.achievement))
				if texture then
					return trimmed_icon(texture)
				end
			end
		end
		local texture = "Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Progressive-Shield-NoPoints" --"Interface\\Addons\\HandyNotes\\Icons\\Achievement"
		default_texture = atlas_perso(texture, point.scale*2)
	end
	--------------------------------------
    if point.follower then
        if not follower_texture then
            follower_texture = atlas_texture("GreenCross", point.scale*1.5)
        end
        return follower_texture
    end
    if point.npc then
        if not npc_texture then
            npc_texture = atlas_texture("DungeonSkull", point.scale)
        end
        return npc_texture
    end
    if point.junk then
        if not junk_texture then
            junk_texture = atlas_texture("VignetteLoot", point.scale*1.5)
        end
        return junk_texture
    end
    if point.cauldron then
        if not cauldron_texture then
            cauldron_texture = atlas_texture("loottoast-arrow-blue", point.scale*1.0)
        end
        return cauldron_texture
    end
     if point.timeRift then
        if not timeRift_texture then
            --timeRift_texture = atlas_texture("nameplate-WarlockShard-On", point.scale*1.2)
            timeRift_texture = atlas_texture("worldquest-icon-tailoring", point.scale*1.2)      
        end
        return timeRift_texture
     end
    if not default_texture then
        default_texture = atlas_texture("Garr_TreasureIcon", point.scale*2)
    end
    return default_texture
end

local get_point_info = function(point)
    if point then
        local label = work_out_label(point)
        local icon = work_out_texture(point)
        local category = "treasure"
        if point.npc then
            category = "npc"
	elseif point.timeRift then
            category = "timeRift"
        elseif point.junk then
            category = "junk"
		elseif point.hf then
            category = "achievement"
        end
        return label, icon, category, point.quest, point.faction, point.scale, point.alpha or 1
    end
end

local get_point_info_by_coord = function(uiMapID, coord)
    return get_point_info(BFA_HF_Tracker_points[uiMapID] and BFA_HF_Tracker_points[uiMapID][coord])
end

local function handle_tooltip(tooltip, point)
    if point then
        -- major:
        tooltip:AddLine(work_out_label(point, point.npcLine or 2))
        if point.follower then
            local follower = C_Garrison.GetFollowerInfo(point.follower)
            if follower then
                local quality = BAG_ITEM_QUALITY_COLORS[follower.quality]
                tooltip:AddDoubleLine(REWARD_FOLLOWER, follower.name,
                    0, 1, 0,
                    quality.r, quality.g, quality.b
                )
                tooltip:AddDoubleLine(follower.className, UNIT_LEVEL_TEMPLATE:format(follower.level))
            end
        end
        if point.currency then
            local name
            if point.currency == 'ARTIFACT' then
                name = ARTIFACT_LABEL
            else
                name = GetCurrencyInfo(point.currency)
            end
            tooltip:AddDoubleLine(CURRENCY, name or point.currency)
        end
        if point.achievement then
            local _, name, _, complete = GetAchievementInfo(point.achievement)
            tooltip:AddDoubleLine(BATTLE_PET_SOURCE_6, name or point.achievement,
                nil, nil, nil,
                complete and 0 or 1, complete and 1 or 0, 0
            )
            if point.criteria then
				if type(point.criteria) == 'table' then
					for _, criterias in ipairs(point.criteria) do
						local criteria, _, complete = GetAchievementCriteriaInfoByID(point.achievement, criterias)
						tooltip:AddDoubleLine(" ", criteria,
							nil, nil, nil,
							complete and 0 or 1, complete and 1 or 0, 0
						)
					end
				else
					local criteria, _, complete = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
					tooltip:AddDoubleLine(" ", criteria,
						nil, nil, nil,
						complete and 0 or 1, complete and 1 or 0, 0
					)
				end
            end
        end
		if point.requireItem then
			local isBag = point.requireItem[1]
			for i=1, #point.requireItem do
				local id = point.requireItem[i]
				if type(id) == "number" then
					tooltip:AddLine(L["Require item : "]..BFA_HF_Tracker_nameItemID(id, isBag), nil, nil, nil, false)
				end
			end
		end
		if point.note then
			tooltip:AddLine(point.note, nil, nil, nil, true)
        end
		if point.note2 then
			--tooltip:AddLine(point.note2, nil, nil, nil, true)
			tooltip:AddLine(tooltipNote2(point.note2), nil, nil, nil, true)
        end
		if point.buy then
			tooltip:AddLine(tooltipBuy(point.buy), nil, nil, nil, true)
        end
		if point.npc and BFA_HF_Tracker_db.tooltip_npcid then
			tooltip:AddDoubleLine("NPC ID :", point.npc or UNKNOWN)
		end
        if point.quest and BFA_HF_Tracker_db.tooltip_questid then
            local quest = point.quest
            if type(quest) == 'table' then
                quest = string.join(", ", unpack(quest))
            end
			tooltip:AddDoubleLine("QuestID :", quest or UNKNOWN)
        end

        if (BFA_HF_Tracker_db.tooltip_item or IsShiftKeyDown()) and (point.item or point.npc) then
            local comparison = ShoppingTooltip1

            do
                local side
                local rightDist = 0
                local leftPos = tooltip:GetLeft() or 0
                local rightPos = tooltip:GetRight() or 0

                rightDist = GetScreenWidth() - rightPos

                if (leftPos and (rightDist < leftPos)) then
                    side = "left"
                else
                    side = "right"
                end

                -- see if we should slide the tooltip
                if tooltip:GetAnchorType() and tooltip:GetAnchorType() ~= "ANCHOR_PRESERVE" then
                    local totalWidth = 0
                    if ( primaryItemShown  ) then
                        totalWidth = totalWidth + comparison:GetWidth()
                    end

                    if ( (side == "left") and (totalWidth > leftPos) ) then
                        tooltip:SetAnchorType(tooltip:GetAnchorType(), (totalWidth - leftPos), 0)
                    elseif ( (side == "right") and (rightPos + totalWidth) >  GetScreenWidth() ) then
                        tooltip:SetAnchorType(tooltip:GetAnchorType(), -((rightPos + totalWidth) - GetScreenWidth()), 0)
                    end
                end

                comparison:SetOwner(tooltip, "ANCHOR_NONE")
                comparison:ClearAllPoints()

                if ( side and side == "left" ) then
                    comparison:SetPoint("TOPRIGHT", tooltip, "TOPLEFT", 0, -10)
                else
                    comparison:SetPoint("TOPLEFT", tooltip, "TOPRIGHT", 0, -10)
                end
            end

            if point.item then
                comparison:SetHyperlink(("item:%d"):format(point.item))
            elseif point.npc then
                comparison:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
            end
            comparison:Show()
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapID, coord)
    return handle_tooltip(tooltip, BFA_HF_Tracker_points[uiMapID] and BFA_HF_Tracker_points[uiMapID][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(uiMapID, coord)
    local tooltip = GameTooltip
    if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    handle_tooltip_by_coord(tooltip, uiMapID, coord)
end

local function createWaypoint(button, uiMapID, coord)
    if TomTom then
		local note = BFA_HF_Tracker_points[uiMapID][coord]["note"]
		if note then 
			title = get_point_info_by_coord(uiMapID, coord).."\n"..note
		else
			title = get_point_info_by_coord(uiMapID, coord)
		end
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uiMapID, x, y, {
            title = title,
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function AddNPCScan(button, uiMapID, coord)
    if IsAddOnLoaded("NPCScan") then
		local npc = BFA_HF_Tracker_points[uiMapID][coord]["NPCScan"]
		if npc then 
			DEFAULT_CHAT_FRAME.editBox:SetText(npc) ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0);
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cFFFF7D00BFA_HF_Tracker :|r "..L["Information for NPCScan and not available."]);
		end
    end
end

local function hideNode(button, uiMapID, coord)
    BFA_HF_Tracker_hidden[uiMapID][coord] = true
    HL:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

do
    local currentZone, currentCoord
    local function generateMenu(button, level)
        if (not level) then return end
        wipe(info)
        if (level == 1) then
            -- Create the title of the menu
            info.isTitle      = 1
            info.text         = "BFA_HF_Tracker"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)
			
            if TomTom then
                -- Waypoint menu item
                info.text = L["Create waypoint"]
                info.notCheckable = 1
                info.func = createWaypoint
                info.arg1 = currentZone
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level)
                wipe(info)
            end
			
			if IsAddOnLoaded("NPCScan") then
                -- NPCScan menu item
                info.text = L["ADD to NPCScan"]
                info.notCheckable = 1
                info.func = AddNPCScan
                info.arg1 = currentZone
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level)
                wipe(info)
			end

            -- Hide menu item
            info.text         = L["Hide node"]
            info.notCheckable = 1
            info.func         = hideNode
            info.arg1         = currentZone
            info.arg2         = currentCoord
            UIDropDownMenu_AddButton(info, level)
            wipe(info)

            -- Close menu item
            info.text         = L["Close"]
            info.func         = closeAllDropdowns
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)
            wipe(info)
        end
    end
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_BFA_HF_TrackerDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapID, coord)
        currentZone = uiMapID
        currentCoord = coord
        -- given we're in a click handler, this really *should* exist, but just in case...
        local point = BFA_HF_Tracker_points[currentZone] and BFA_HF_Tracker_points[currentZone][currentCoord]
        if button == "RightButton" and not down then
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(uiMapID, coord)

        GameTooltip:Hide()
    ShoppingTooltip1:Hide()
end

do
    -- This is a custom iterator we use to iterate over every node in a given zone
    local currentZone, isMinimap
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value and BFA_HF_Tracker_should_show_point(state, value, currentZone, isMinimap) then
                local label, icon, _, _, _, scale, alpha = get_point_info(value)
                scale = (scale or 1) * (icon and icon.scale or 1) * BFA_HF_Tracker_db.icon_scale
                return state, nil, icon, scale, BFA_HF_Tracker_db.icon_alpha * alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    local function UnitHasBuff(unit, spellid)
        local buffname = GetSpellInfo(spellid)
        for i = 1, 40 do
            local name = UnitBuff(unit, i)
            if not name then
                -- reached the end, probably
                return
            end
            if buffname == name then
                return UnitBuff(unit, i)
            end
        end
    end
    function HLHandler:GetNodes2(uiMapID, minimap)
        currentZone = uiMapID
        isMinimap = minimap
        if minimap and BFA_HF_Tracker_map_spellids[uiMapID] then
            if BFA_HF_Tracker_map_spellids[uiMapID] == true then
                return iter
            end
            if UnitHasBuff("player", BFA_HF_Tracker_map_spellids[uiMapID]) then
                return iter
            end
        end
        return iter, BFA_HF_Tracker_points[uiMapID], nil
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_BFA_HF_TrackerDB", BFA_HF_Tracker_defaults)
    BFA_HF_Tracker_db = self.db.profile
    BFA_HF_Tracker_hidden = self.db.char.hidden
	NPC_Name_CacheDB = NPC_Name_CacheDB or {}
	Item_Name_CacheDB = Item_Name_CacheDB or {}
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("HandyNotes_BFA_HF_Tracker", HLHandler, BFA_HF_Tracker_options)

    -- watch for LOOT_CLOSED
    self:RegisterEvent("LOOT_CLOSED", "Refresh")
    self:RegisterEvent("ZONE_CHANGED_INDOORS", "Refresh")
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_BFA_HF_Tracker")
end


local function achievementComplete(id)
	local complete = select(13, GetAchievementInfo(id))
	return complete
end

local function nameAchievement(id)
	local name = select(2, GetAchievementInfo(id))
	local complete = select(13, GetAchievementInfo(id))
	if complete then
		return "|cFF00FF00"..id.." - "..name.."|r"	-- vert
	end
	return "|cFFFF0000"..id.." - "..name.."|r"	-- rouge
end

BFA_HF_Tracker_defaults = {
    profile = {
        show_on_world = true,
        show_on_minimap = false,
        show_junk = false,
        show_npcs = true,
	show_cauldron = true,
        show_treasure = true,
		show_hautsFaits = true,
		show_hautsFaits_complete = false,
        found = false,
        repeatable = true,
        icon_scale = 1.3,
        icon_alpha = 1.0,
        icon_item = false,
		icon_item_hf = false,
        tooltip_item = true,
        tooltip_questid = false,
		tooltip_npcid = false,
		hf_12482 = true,
		hf_13016 = true,
		hf_13018 = true,
		hf_13024 = true,
		hf_13028 = true,
		hf_13029 = true,
		hf_13036 = true,
		hf_13046 = true,
		hf_13051 = true,
		hf_13057 = true,
		hf_13061 = true,
		hf_13064 = true,
		hf_13082 = true,
		hf_13087 = true,
		hf_13094 = true,
    },
    char = {
        hidden = {
            ['*'] = {},
        },
    },
}

BFA_HF_Tracker_options = {
    type = "group",
    name = "HF_Tracker",
    get = function(info) return BFA_HF_Tracker_db[info[#info]] end,
    set = function(info, v)
        BFA_HF_Tracker_db[info[#info]] = v
        BFA_HF_Tracker_HL:SendMessage("HandyNotes_NotifyUpdate", "HandyNotes_BFA_HF_Tracker")
    end,
    args = {
        icon = {
            type = "group",
            name = L["Icon settings"],
            inline = true,
			order = 1,
            args = {
                desc = {
                    name = L["These settings control the look and feel of the icon."],
                    type = "description",
                    order = 0,
                },
                icon_scale = {
                    type = "range",
                    name = L["Icon Scale"],
                    desc = L["The scale of the icons"],
                    min = 0.25, max = 2, step = 0.01,
                    order = 20,
                },
                icon_alpha = {
                    type = "range",
                    name = L["Icon Alpha"],
                    desc = L["The alpha transparency of the icons"],
                    min = 0, max = 1, step = 0.01,
                    order = 30,
                },
                show_on_world = {
                    type = "toggle",
                    name = L["World Map"],
                    desc = L["Show icons on world map"],
                    order = 40,
                },
                show_on_minimap = {
                    type = "toggle",
                    name = L["Minimap"],
                    desc = L["Show icons on the minimap"],
                    order = 50,
                },
            },
        },
        display = {
            type = "group",
            name = L["What to display"],
            inline = true,
			order = 2,
            args = {
                icon_item = {
                    type = "toggle",
                    name = L["Use item icons"],
                    desc = L["Show the icons for items, if known; otherwise, the achievement icon will be used"],
                    order = 0,
                },
                tooltip_item = {
                    type = "toggle",
                    name = L["Use item tooltips"],
                    desc = L["Show the full tooltips for items"],
                    order = 10,
                },
                found = {
                    type = "toggle",
                    name = L["Show found"],
                    desc = L["Show waypoints for items you've already found?"],
                    order = 20,
                },
                show_npcs = {
                    type = "toggle",
                    name = L["Show NPCs"],
                    desc = L["Show rare NPCs to be killed, generally for items or achievements"],
                    order = 30,
                },
                show_treasure = {
                    type = "toggle",
                    name = L["Show treasure"],
                    desc = L["Show treasure that can be looted"],
                    order = 35,
                },
                show_junk = {
                    type = "toggle",
                    name = L["Junk"],
                    desc = L["Show items which don't count for any achievement"],
                    order = 40,
                },
                tooltip_questid = {
                    type = "toggle",
                    name = L["Show quest ids"],
                    desc = L["Show the internal id of the quest associated with this node. Handy if you want to report a problem with it."],
                    order = 42,
                },
				tooltip_npcid = {
                    type = "toggle",
                    name = L["Show NPCs ids"],
                    desc = L["Show the internal id of the NPC associated with this node. Handy if you want to report a problem with it."],
                    order = 45,
                },
                show_cauldron = {
                    type = "toggle",
                    name = "Show Jetpacks",
                    desc = "Show Alchemy treasures that can be looted",
                    order = 50,
                },		
                unhide = {
                    type = "execute",
                    name = L["Reset hidden nodes"],
                    desc = L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."],
                    width = "full",
					func = function()
                        for map,coords in pairs(BFA_HF_Tracker_hidden) do
                            wipe(coords)
                        end
                        BFA_HF_Tracker_HL:Refresh()
                    end,
                    order = 50,
                },
            },
        },
		achievement = {
            type = "group",
            name = L["What to display achievement"],
            inline = true,
			order = 3,
            args = {
				show_hautsFaits = {
                    type = "toggle",
                    name = L["Show Achievement"],
                    desc = L["Show Achievement that can be looted"],
                    order = 0,
                },
                icon_item_hf = {
                    type = "toggle",
                    name = L["Use item icons achievement"],
                    desc = L["Show the icons for items, if known; otherwise, the achievement icon will be used"],
                    disabled = function() return not BFA_HF_Tracker_db.show_hautsFaits; end,
					order = 5,
                },
				show_hautsFaits_complete = {
                    type = "toggle",
                    name = L["Show Achievements completed"],
                    desc = L["Show Achievements completed"],
					width = "full",
					disabled = function() return not BFA_HF_Tracker_db.show_hautsFaits; end,
                    order = 10,
                },
				header2 = {
					type = "header",
					name = L["Select achievement"],
					order = 20,
				},
				hf_12482 = {
					type = "toggle",
					name = function() return nameAchievement(12482); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(12482) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 12482,
				},
				hf_13016 = {
					type = "toggle",
					name = function() return nameAchievement(13016); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13016) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13016,
				},
				hf_13018 = {
					type = "toggle",
					name = function() return nameAchievement(13018); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13018) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13018,
				},
				hf_13024 = {
					type = "toggle",
					name = function() return nameAchievement(13024); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13024) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13024,
				},
				hf_13028 = {
					type = "toggle",
					name = function() return nameAchievement(13028); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13028) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13028,
				},
				hf_13029 = {
					type = "toggle",
					name = function() return nameAchievement(13029); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13029) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13029,
				},
				hf_13036 = {
					type = "toggle",
					name = function() return nameAchievement(13036); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13036) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13036,
				},
				hf_13046 = {
					type = "toggle",
					name = function() return nameAchievement(13046); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13046) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13046,
				},
				hf_13051 = {
					type = "toggle",
					name = function() return nameAchievement(13051); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13051) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13051,
				},
				hf_13057 = {
					type = "toggle",
					name = function() return nameAchievement(13057); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13057) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13057,
				},
				hf_13061 = {
					type = "toggle",
					name = function() return nameAchievement(13061); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13061) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13061,
				},
				hf_13064 = {
					type = "toggle",
					name = function() return nameAchievement(13064); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13064) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13064,
				},
				hf_13082 = {
					type = "toggle",
					name = function() return nameAchievement(13082); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13082) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13082,
				},
				hf_13087 = {
					type = "toggle",
					name = function() return nameAchievement(13087); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13087) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13087,
				},
				hf_13094 = {
					type = "toggle",
					name = function() return nameAchievement(13094); end,
					desc = L["Show the icons Achievement"],
					width = "full",
					hidden = function() return not BFA_HF_Tracker_db.show_hautsFaits or (achievementComplete(13094) and not BFA_HF_Tracker_db.show_hautsFaits_complete); end,
					order = 13094,
				},
            },
        },
    },
}

local player_faction = UnitFactionGroup("player")
local player_name = UnitName("player")

local allQuestsComplete = function(quests)
    if type(quests) == 'table' then
        -- if it's a table, only count as complete if all quests are complete
        for _, quest in ipairs(quests) do
            if not IsQuestFlaggedCompleted(quest) then
                return false
            end
        end
        return true
    elseif IsQuestFlaggedCompleted(quests) then
        return true
    end
end
local allCriteriaComplete = function(achievement, criterias)
    if type(criterias) == 'table' then
        -- if it's a table, only count as complete if all criterias are complete
        for _, criteria in ipairs(criterias) do
			local _, _, completed, _, _, completedBy = GetAchievementCriteriaInfoByID(achievement, criteria)
			if not completed and not completedBy then
				return false
			end
        end
        return true
    else
		local _, _, completed, _, _, completedBy = GetAchievementCriteriaInfoByID(achievement, criterias)
		if completed and completedBy == player_name then
			return true
		end
    end
end

BFA_HF_Tracker_should_show_point = function(coord, point, currentZone, isMinimap)
    if isMinimap and not BFA_HF_Tracker_db.show_on_minimap and not point.minimap then
        return false
    elseif not isMinimap and not BFA_HF_Tracker_db.show_on_world then
        return false
    end
    if point.level and point.level ~= currentLevel then
        return false
    end
    if BFA_HF_Tracker_hidden[currentZone] and BFA_HF_Tracker_hidden[currentZone][coord] then
        return false
    end
    if BFA_HF_Tracker_outdoors_only and IsIndoors() then
        return false
    end
    if point.junk and not BFA_HF_Tracker_db.show_junk then
        return false
    end
    if point.faction and point.faction ~= player_faction then
        return false
    end
    if (not BFA_HF_Tracker_db.found) then
        if point.quest then
            if allQuestsComplete(point.quest) then
                return false
            end
        elseif point.achievement then
            local completedByMe = select(13, GetAchievementInfo(point.achievement))
            if completedByMe then
                return false
            end
            if point.criteria then
				--[[
                local _, _, completed, _, _, completedBy = GetAchievementCriteriaInfoByID(point.achievement, point.criteria)
                if completed and completedBy == player_name then
                    return false
                end
				]]--
				if allCriteriaComplete(point.achievement, point.criteria) then
					return false
				end
			end
        end
        if point.follower and C_Garrison.IsFollowerCollected(point.follower) then
            return false
        end
        if point.toy and point.item and PlayerHasToy(point.item) then
            return false
        end
	if point.cauldron and not BFA_HF_Tracker_db.show_cauldron then
            return false
        end
        if point.timeRift and not BFA_HF_Tracker_db.show_timeRift then
            return false
        end
    end
    if not point.follower then
        if point.npc then
            if not BFA_HF_Tracker_db.show_npcs then
                return false
            end
		elseif point.hf then
            if not BFA_HF_Tracker_db.show_hautsFaits then
                return false
            end
			if not BFA_HF_Tracker_db.hf_12482 and point.achievement == 12482 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13016 and point.achievement == 13016 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13018 and point.achievement == 13018 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13024 and point.achievement == 13024 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13028 and point.achievement == 13028 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13029 and point.achievement == 13029 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13036 and point.achievement == 13036 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13046 and point.achievement == 13046 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13051 and point.achievement == 13051 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13057 and point.achievement == 13057 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13061 and point.achievement == 13061 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13064 and point.achievement == 13064 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13082 and point.achievement == 13082 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13087 and point.achievement == 13087 then
                return false
            end
			if not BFA_HF_Tracker_db.hf_13094 and point.achievement == 13094 then
                return false
            end
        else
            -- Not an NPC, not a follower, must be treasure
            if not BFA_HF_Tracker_db.show_treasure then
                return false
            end
        end
    end
    if point.hide_before and not BFA_HF_Tracker_db.upcoming and not allQuestsComplete(point.hide_before) then
        return false
    end
    return true
end


local merge = function(t1, t2)
	if not t2 then return t1 end
    for k, v in pairs(t2) do
        t1[k] = v
    end
end
BFA_HF_Tracker_merge = merge

local AZERITE = 1553
local CHEST = L['Treasure Chest']
local CHEST_SM = L['Small Treasure Chest']
local CHEST_GLIM = 'Glimmering Treasure Chest'
local path = function(questid, label, atlas, note, scale)
    label = label or L["Entrance "]
    atlas = atlas or "map-icon-SuramarDoor.tga"
    return {
        quest = questid,
        label = label,
        atlas = atlas,
        path = true,
        scale = scale,
        note = note,
    }
end
BFA_HF_Tracker_path = path

BFA_HF_Tracker_map_spellids = {
    -- [862] = 0, -- Zuldazar
    -- [863] = 0, -- Nazmir
    -- [864] = 0, -- Vol'dun
    -- [895] = 0, -- Tiragarde Sound
    -- [896] = 0, -- Drustvar
    -- [942] = 0, -- Stormsong Valley
}

BFA_HF_Tracker_points = {
    --[[ structure:
    [uiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            currency=[id], -- currencyid
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
            hide_before=[id], -- hide if quest not completed
        },
    },
    --]]
    [862] = { -- Zuldazar
        [54093150] = {quest=48938, achievement=12851, criteria=40988, note="On second floor",}, -- Offerings of the Chosen
        [64712167] = {quest=50259, achievement=12851, criteria=40989,}, -- Witch Doctor's Hoard
        [51718690] = {quest=49936, achievement=12851, criteria=40990, note="Bottom floor of ship",}, -- Spoils of Pandaria
        [51442661] = {quest=50582, achievement=12851, criteria=40991, note="Top of hill"}, -- Gift of the Brokenhearted
        [50112715] = path{quest=50582},
        [49506526] = {quest=49257, achievement=12851, criteria=40992, note="Top of ship",}, -- Warlord's Cache
        [38793444] = {quest=50707, achievement=12851, criteria=40993, note="Up on the rocks",}, -- Dazar's Forgotten Chest
        [41003328] = path{quest=50707, note="Path behind the waterfall"},
        [41973566] = path{quest=50707},
        [61065863] = {quest=50947, achievement=12851, criteria=40994, npc=133208, note="Event: kill Da White Shark first",}, -- Da White Shark's Bounty
        [71821677] = {quest=50949, item=163036, achievement=12851, criteria=40995, note="In cave",}, -- The Exile's Lament
        [71161767] = path{quest=50949},
        [56123806] = {quest=51338, achievement=12851, criteria=40996, note="In cave behind waterfall",}, -- Cache of Secrets
        [52974719] = {quest=51624, achievement=12851, criteria=40997}, -- Riches of Tor'nowa
        -- junk
        [50823158] = {quest=50711, junk=true, label=CHEST,},
        [65041636] = {quest=50715, junk=true, label=CHEST,},
        [68902222] = {quest=50715, junk=true, label=CHEST,},
        [68503365] = {quest=50716, junk=true, label=CHEST,},
        [66552896] = {quest=50720, junk=true, label=CHEST,},
        [63062832] = {quest=50720, junk=true, label=CHEST,},
        [75042303] = {quest=50721, junk=true, label=CHEST,},
        [48984088] = {quest=50722, junk=true, label=CHEST,},
        [45676019] = {quest=50723, junk=true, label=CHEST,},
        [47526049] = {quest=50723, junk=true, label=CHEST,},
        [80791415] = {quest=50724, junk=true, label=CHEST,},
        [80151648] = {quest=50724, junk=true, label=CHEST,},
        [41127489] = {quest=50726, junk=true, label=CHEST,},
        [43177297] = {quest=50726, junk=true, label=CHEST,},
        [40953756] = {quest=50727, junk=true, label=CHEST,},
        [81203857] = {quest=50728, junk=true, label=CHEST,},
        [80135512] = {quest=51346, junk=true, label=CHEST,},
        [82465431] = {quest=51346, junk=true, label=CHEST,},
        -- [71684127] = {quest=50308, junk=true, label="Mysterious trashpile", achievement="12482", note="Jani"},
    },
    [863] = { -- Nazmir
        [77903634] = {quest=49867, achievement=12771, criteria=40857,}, -- Lucky Horace's Lucky Chest
        [77884635] = {quest=50061, achievement=12771, criteria=40858, note=L["In dead hippo's mouth"],}, -- Partially-Digested Treasure
        [43065078] = {quest=49979, achievement=12771, criteria=40859, note=L["In cave"],}, -- Cursed Nazmani Chest
        [42275056] = path(49979),
        [35668560] = {quest=49885, achievement=12771, criteria=40860, note=L["In cave"],}, -- Cleverly Disguised Chest
        [62103487] = {quest=49891, achievement=12771, criteria=40861, note=L["In an underwater cave"],}, -- Lost Nazmani Treasure
        [42772620] = {quest=49484, achievement=12771, criteria=40862, note=L["Climb the tree"],}, -- Offering to Bwonsamdi
        [66791735] = {quest=49483, achievement=12771, criteria=40863, note=L["Climb the tree"],}, -- Shipwrecked Chest
        [46228295] = {quest=49889, achievement=12771, criteria=40864,}, -- Venomous Seal
        [76826220] = {quest=50045, achievement=12771, criteria=40865, note=L["In an underwater cave"],}, -- Swallowed Naga Chest
        [35455498] = {quest=49313, achievement=12771, criteria=40866, note=L["In cave"],}, -- Wunja's Trove
        -- Hoppin' Sad (Lost Spawn of Krag'wa)
        [69105790] = {quest=53417, achievement=13028, minimap=true, atlas="WildBattlePetCapturable",}, --verify
        [65605090] = {quest=53418, achievement=13028, minimap=true, atlas="WildBattlePetCapturable",}, --verify
        [56106490] = {quest=53419, achievement=13028, minimap=true, atlas="WildBattlePetCapturable",},
        [52804290] = {quest=53420, achievement=13028, minimap=true, atlas="WildBattlePetCapturable",}, --verify
        [33506160] = {quest=53421, achievement=13028, minimap=true, atlas="WildBattlePetCapturable",},
        [45609100] = {quest=53422, achievement=13028, minimap=true, atlas="WildBattlePetCapturable",}, --verify
        [28408230] = {quest=53423, achievement=13028, minimap=true, atlas="WildBattlePetCapturable", note="Cave in cliffs",}, --verify
        [24209160] = {quest=53424, achievement=13028, minimap=true, atlas="WildBattlePetCapturable",}, --verify
        [21706930] = {quest=53425, achievement=13028, minimap=true, atlas="WildBattlePetCapturable",},
        -- [52804290] = {quest=53426, achievement=13828, minimap=true,}, -- maybe?
        [25694058] = {quest=53426, achievement=13028, minimap=true, atlas="WildBattlePetCapturable",},
        -- junk
        [41575046] = {quest=49916, junk=true, label=CHEST,},
        [41596574] = {quest=49916, junk=true, label=CHEST,},
        [28048187] = {quest=50895, junk=true, label=CHEST,},
    },
    [864] = { -- Vol'dun
        [46598801] = {quest=50237, achievement=12849, criteria=40966, note="Use mine cart",}, -- Ashvane Spoils
        [44339222] = path{quest=50237, label="Mine cart"},
        [49787940] = {quest=51132, achievement=12849, criteria=40968, note="Climb the rock arch",}, -- Lost Explorer's Bounty
        [44502613] = {quest=51135, achievement=12849, criteria=40970, note="Climb fallen tree",}, -- Stranded Cache
        [44712480] = path{quest=51135},
        [29388742] = {quest=51137, achievement=12849, criteria=40972, note="Under Disturbed Sand",}, -- Zem'lan's Buried Treasure
        [40578574] = {quest=52994, achievement=12849, criteria=41003,}, -- Deadwood Chest
        [38848290] = path{quest=52994},
        [48186469] = {quest=51093, achievement=12849, criteria=40967, note="Door on East side", hide_before=50550, faction="Horde",}, -- Grayal's Last Offering
        [49166469] = path{quest=51093},
        [47195846] = {quest=51133, achievement=12849, criteria=40969, note="Path from South side",}, -- Sandfury Reserve
        [47445984] = path{quest=51133},
        [57746464] = {quest=51136, achievement=12849, criteria=40971,}, -- Excavator's Greed
        [56696469] = path{quest=51136},
        [57061121] = {quest=52992, achievement=12849, criteria=41002, note="Enter at top of temple",}, -- Lost Offerings of Kimbul
        [26484534] = {quest=53004, item=163036, achievement=12849, criteria=41004, note="Use Abandoned Bobber",}, -- Sandsunken Treasure
        -- Scavenger of the Sands
        [56297011] = {quest=53132, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41342, note="Under the bridge",}, -- Jason's Rusty Blade
        [36217838] = {quest=53133, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41343, note="Inside the turned over box",}, -- Ian's Empty Bottle
        [53568981] = {quest=53134, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41344, note="On the table",}, -- Julie's Cracked Dish
        [37813049] = {quest=53135, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41345, note="Under the rock",}, -- Brian's Broken Compass
        [26775289] = {quest=53136, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41346, note="First floor, blue stone table",}, -- Ofer's Bound Journal
        [29455937] = {quest=53137, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41347, note="On the small hill",}, -- Skye's Pet Rock
        [52431439] = {quest=53138, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41348, note="Near the bones close to the cliff",}, -- Julien's Left Boot
        [43217700] = {quest=53139, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41349, note="Near the wall",}, -- Navarro's Flask
        [47067577] = {quest=53140, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41350, note="Under the stairs",}, -- Zach's Canteen
        [45883072] = {quest=53141, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41351, note="Hanging on the hut",}, -- Damarcus' Backpack
        [66413590] = {quest=53142, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41352, note="In cave",}, -- Rachel's Flute
        [64883632] = path(53142),
        [47933673] = {quest=53143, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41353, note="Cave under the giant tree",}, -- Josh's Fang Necklace
        [45229114] = {quest=53144, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41354, note="On the wall",}, -- Portrait of Commander Martens
        [62832267] = {quest=53145, minimap=true, atlas="VignetteLootElite", scale=1.2, achievement=13016, criteria=41355, note="Down from Tortaka Refuge",}, -- Kurt's Ornate Key
        -- junk
        [46984656] = {quest=50883, junk=true, label="Mysterious trashpile", achievement=12482, note="In alcove, Summon Jani, give her Charged Ranishu Antennae"},
        [59631517] = {quest=50914, junk=true, label=CHEST,},
        [61071734] = {quest=50914, junk=true, label=CHEST,},
        [53841481] = {quest=50915, junk=true, label=CHEST,},
        [60843637] = {quest=50916, junk=true, label=CHEST,},
        [62783373] = {quest=50916, junk=true, label=CHEST,},
        [54363351] = {quest=50917, junk=true, label=CHEST,},
        [64172528] = {quest=50918, junk=true, label=CHEST,},
        [35095003] = {quest=50919, junk=true, label=CHEST,},
        [48338890] = {quest=50920, junk=true, label=CHEST, note="In cave"},
        [46384538] = {quest=50921, junk=true, label=CHEST,},
        [30344624] = {quest=50922, junk=true, label=CHEST,},
        [29815402] = {quest=50922, junk=true, label=CHEST,},
        [26496777] = {quest=50923, junk=true, label=CHEST,},
        [31158381] = {quest=50924, junk=true, label=CHEST,},
        [37577607] = {quest=50924, junk=true, label=CHEST,},
        [36918033] = {quest=50924, junk=true, label=CHEST,},
        [44858126] = {quest=50925, junk=true, label=CHEST,},
        [52747649] = {quest=50926, junk=true, label=CHEST,},
        [56496993] = {quest=50926, junk=true, label=CHEST,},
        [57545508] = {quest=50928, junk=true, label=CHEST,},
        [52328519] = {quest=51673, junk=true, label=CHEST,},
        [51908251] = {quest=51673, junk=true, label=CHEST,},
    },
    [895] = { -- Tiragarde Sound
        [61515233] = {quest=49963, achievement=12852, criteria=41012, note="Ride the Guardian",}, -- Hay Covered Chest
        [56033319] = {quest=52866, achievement=12852, criteria=41014,}, -- Precarious Noble Cache
        [72482169] = {quest=52870, achievement=12852, criteria=41016, note=L["In cave"],}, -- Scrimshaw Cache
        [72495814] = {quest=50442, item=155381, achievement=12852, criteria=41013,}, -- Cutwater Treasure Chest
        [61786275] = {quest=52867, achievement=12852, criteria=41015, note=L["In cave"],}, -- Forgotten Smuggler's Stash
        [73103950] = {quest=52195, item=161342, achievement=12852, criteria=41017, note=L["In Boralus, on Stomsong Monastary"],}, -- Secret of the Depths
        [55769095] = {quest=52195, hide_before={52134, 52135, 52136, 52137, 52138}, item=161342, achievement=12852, criteria=41017, note=L["Teleport here from Stormsong, pick up the gem"],}, -- Secret of the Depths
        -- Freehold treasure maps
        [80007600] = {quest=52853, item=162571, achievement=12852, criteria=41018, note=L["Kill pirates in Freehold until the map drops"],}, -- Soggy Treasure Map 162571 (q:52853)
        [80708050] = {quest=52859, item=162581, achievement=12852, criteria=41020, note=L["Kill pirates in Freehold until the map drops"],}, -- Yellowed Treasure Map 162581 (q:52859)
        [74008300] = {quest=52854, item=162580, achievement=12852, criteria=41019, note=L["Kill pirates in Freehold until the map drops"],}, -- Fading Treasure Map 162580 (q:52854)
        [76008500] = {quest=52860, item=162584, achievement=12852, criteria=41021, note=L["Kill pirates in Freehold until the map drops"],}, -- Singed Treasure Map 162584 (q:52860)
        -- ...and the actual treasures they point to
        [54994608] = {quest=52807, hide_before=52853, achievement=12852, criteria=41018, note=L["Kill pirates in Freehold until the map drops"],}, -- Soggy Treasure Map 162571 (q:52853)
        [90507551] = {quest=52836, hide_before=52859, achievement=12852, criteria=41020, note=L["Kill pirates in Freehold until the map drops"],}, -- Yellowed Treasure Map 162581 (q:52859)
        [29222534] = {quest=52833, hide_before=52854, achievement=12852, criteria=41019, note=L["Kill pirates in Freehold until the map drops"],}, -- Fading Treasure Map 162580 (q:52854)
        [48983759] = {quest=52845, hide_before=52860, achievement=12852, criteria=41021, note=L["Kill pirates in Freehold until the map drops"],}, -- Singed Treasure Map 162584 (q:52860)
        -- Shanty Raid
        [43382585] = {quest=53410, item=163715, atlas="poi-workorders", minimap=true, achievement=13057, criteria=41542, note="In a cave",}, -- Fruit Counting
        [76218305] = {quest=50233, item=163717, atlas="poi-workorders", minimap=true, achievement=13057, criteria=41544, note="Kill Barman Bill",}, -- Josephus
        [56706990] = {quest=50096, item=163718, atlas="poi-workorders", minimap=true, achievement=13057, criteria=41545, note="Kill Black-Eyed Bart",}, -- Black Sphere
        [73208410] = {quest=53411, item=163719, atlas="poi-workorders", minimap=true, achievement=13057, criteria=41546, note="Ground floor, on a table",}, -- Horse
        [70602270] = {quest=53407, item=163716, atlas="poi-workorders", minimap=true, achievement=13057, criteria=41543, note="Behind Jay the Tavern Bard",}, -- Inebriation
        [74403540] = {quest=53408, item=163714, atlas="poi-workorders", minimap=true, achievement=13057, criteria=41541, note="On the fireplace mantel",}, -- Lively Men
        -- junk:
        [83673580] = {quest=53631, junk=true, label="Dusty Marine Supplies",},
        [76967543] = {quest=48593, junk=true, label=CHEST_SM,},
        [78008050] = {quest=48595, junk=true, label=CHEST_SM,},
        [76358090] = {quest=48595, junk=true, label=CHEST_SM,},
        [73468317] = {quest=48596, junk=true, label=CHEST_SM,},
        [75758283] = {quest=48596, junk=true, label=CHEST_SM,},
        [38432868] = {quest=48598, junk=true, label=CHEST_SM,},
        [38762673] = {quest=48599, junk=true, label=CHEST_SM,},
        [78114901] = {quest=48607, junk=true, label=CHEST_SM,},
        [79205050] = {quest=48607, junk=true, label=CHEST_SM,},
        [81344938] = {quest=48607, junk=true, label=CHEST_SM,},
        [76126733] = {quest=48608, junk=true, label=CHEST_SM,},
        [68635108] = {quest=48609, junk=true, label=CHEST_SM,},
        [50842310] = {quest=48611, junk=true, label=CHEST_SM,},
        [47442365] = {quest=48611, junk=true, label=CHEST_SM,},
        [48392785] = {quest=48611, junk=true, label=CHEST_SM,},
        [61212836] = {quest=48612, junk=true, label=CHEST_SM,},
        [57311757] = {quest=48617, junk=true, label=CHEST_SM,},
        [87347379] = {quest=48618, junk=true, label=CHEST_SM,},
        [88387840] = {quest=48618, junk=true, label=CHEST_SM,},
        [69801270] = {quest=48619, junk=true, label=CHEST_SM,},
        [46481829] = {quest=48621, junk=true, label=CHEST_SM,},
    },
    [896] = { -- Drustvar
        [33713008] = {quest=53356, achievement=12995, criteria=41697,}, -- Web-Covered Chest
        [63306585] = {quest=53385, item=163743, achievement=12995, criteria=41699, note="Left Down Up Right",}, -- Runebound Cache
        [33687173] = {quest=53387, item=163740, achievement=12995, criteria=41701, note="Right Up Left Down",}, -- Runebound Coffer
        [55605181] = {quest=53472, item=163790, minimap=true, achievement=12995, criteria=41703, note="Click on Witch Torch",}, -- Bespelled Chest
        [25472416] = {quest=53474, item=163796, minimap=true, achievement=12995, criteria=41705, note="Click on Witch Torch",}, -- Enchanted Chest
        [25751995] = {quest=53357, achievement=12995, criteria=41698, note="Get keys from Gorging Raven",}, -- Merchant's Chest
        [44222770] = {quest=53386, item=163742, achievement=12995, criteria=41700, note="Left Right Down Up",}, -- Runebound Chest
        [18515133] = {quest=53471, item=163789, minimap=true, achievement=12995, criteria=41702, note="Click on Witch Torch",}, -- Hexed Chest
        [67767367] = {quest=53473, item=163791, minimap=true, achievement=12995, criteria=41704, note="Click on Witch Torch",}, -- Ensorcelled Chest
        [24304840] = {quest=53475, minimap=true, achievement=12995, criteria=41752,}, -- Stolen Thornspeaker Cache
        -- junk
        [65312905] = {quest=51871, junk=true, label=CHEST_SM,},
        [57862187] = {quest=51875, junk=true, label=CHEST_SM,},
        [58642825] = {quest=51875, junk=true, label=CHEST_SM,},
        [50332252] = {quest=51878, junk=true, label=CHEST_SM,},
        [62094463] = {quest=51882, junk=true, label=CHEST_SM,},
        [60306860] = {quest=51896, junk=true, label=CHEST_SM,},
        [26222993] = {quest=51907, junk=true, label=CHEST_SM,},
        [23181263] = {quest=5191, junk=true, label=CHEST_SM,},
        [24223681] = {quest=51911, junk=true, label=CHEST_SM,},
        [39326173] = {quest=51914, junk=true, label=CHEST_SM,},
    },
    [942] = { -- Stormsong Valley
        [66901200] = {quest=51449, achievement=12853, criteria=41061,}, -- Weathered Treasure Chest
        [42854723] = {quest=50089, achievement=12853, criteria=41062, note="In cave",}, -- Old Ironbound Chest
        [48968407] = {quest=50526, achievement=12853, criteria=41063,}, -- Frosty Treasure Chest
        [67224321] = {quest=50734, achievement=12853, criteria=41064, note="Under ship",}, -- Sunken Strongbox
        [59913907] = {quest=50937, achievement=12853, criteria=41065, note="On roof",}, -- Hidden Scholar's Chest
        [58608388] = {quest=49811, achievement=12853, criteria=41066, note="Under platform",}, -- Smuggler's Stash
        [58216368] = {quest=52326, achievement=12853, criteria=41067, note="Top shelf inside shed",}, -- Discarded Lunchbox
        [44447353] = {quest=52429, item=162000, achievement=12853, criteria=41068, note="Jump down onto platform",}, -- Carved Wooden Chest
        [36692323] = {quest=52976, achievement=12853, criteria=41069, note="Climb ladder onto ship",}, -- Venture Co. Supply Chest
        [46003069] = {quest=52980, achievement=12853, criteria=41070, note="Behind pillar",}, -- Forgotten Chest
        [41256950] = {achievement=13046, atlas="Food", minimap=true, note="Open an Unforgettable Luncheon here; buy them at the Inn, or loot one from the Discarded Lunchbox in Brennadam",}, -- These Hills Sing
        -- Legends of the Tidesages
        [49518090] = {achievement=13051, criteria=41425, minimap=true, atlas="poi-workorders",}, -- Part 1 (Near the waterfall)
        [59025954] = {achievement=13051, criteria=41426, minimap=true, atlas="poi-workorders",}, -- Part 2 (On top of the hill)
        [31957291] = {achievement=13051, criteria=41427, minimap=true, atlas="poi-workorders",}, -- Part 3 (Near the lake)
        [33813323] = {achievement=13051, criteria=41428, minimap=true, atlas="poi-workorders",}, -- Part 4 (On top of the island)
        [56023853] = {achievement=13051, criteria=41429, minimap=true, atlas="poi-workorders",}, -- Part 5 (Up the mountain right of Warfang Hold)
        [44183660] = {achievement=13051, criteria=41430, minimap=true, atlas="poi-workorders",}, -- Part 6 (Up the mountain left of Warfang Hold)
        [62083022] = {achievement=13051, criteria=41431, minimap=true, atlas="poi-workorders",}, -- Part 7
        [75073113] = {achievement=13051, criteria=41432, minimap=true, atlas="poi-workorders",}, -- Part 8 (Near the Shrine of the Storm entrance)
        -- junk
        [32126620] = {quest=53635, junk=true, label="Curious Grain Sack",},
        [32946967] = {quest=53652, junk=true, label="Curious Grain Sack",},
        [66567107] = {quest=50576, item=154476, label="Honey Vat", note="Strangely, not part of the achievement",},
        [62056563] = {quest=51184, junk=true, label=CHEST_SM,},
        [51796523] = {quest=51184, junk=true, label=CHEST_SM,},
        [70265958] = {quest=51927, junk=true, label=CHEST_SM,},
        [75103513] = {quest=51938, junk=true, label=CHEST_SM,},
        [64366899] = {quest=51939, junk=true, label=CHEST_SM,},
        [68067158] = {quest=51939, junk=true, label=CHEST_SM, note="In a bush",},
        [48406562] = {quest=51940, junk=true, label=CHEST_SM,},
        [44107300] = {quest=51942, junk=true, label=CHEST_SM,},
        [29776948] = {quest=51943, junk=true, label=CHEST_SM,},
        [29985150] = {quest=51944, junk=true, label=CHEST_SM,},
        [36272737] = {quest=51945, junk=true, label=CHEST_SM,},
        [57645092] = {quest=51946, junk=true, label=CHEST_SM,},
        [60865118] = {quest=51946, junk=true, label=CHEST_SM,},
        [46915393] = {quest=51949, junk=true, label=CHEST_SM,},
    },
    [1183] = { -- Thornheart
        [60804121] = {quest=52429, item=162000, achievement=12853, criteria=41068, note="Jump down from here",}, -- Carved Wooden chest
    },
    [1161] = { -- Boralus
        [61901010] = {quest=52870, achievement=12852, criteria=41016, note=L["In cave"],}, -- Scrimshaw Cache
        -- Secret of the Depths:
        [61518382] = {quest=52195, atlas="MagePortalAlliance", minimap=true, achievement=12852, criteria=41017, note=L["Entrance to the underwater cave"],},
        [55979126] = {quest=52134, atlas="poi-workorders", minimap=true, achievement=12852, criteria=41017, note=L["Read Damp Scrolls; in the underwater cave, from the monastary"],},
        [61527772] = {quest=52135, atlas="poi-workorders", minimap=true, achievement=12852, criteria=41017, note=L["Read Damp Scrolls; underground"],},
        [63078186] = {quest=52136, atlas="poi-workorders", minimap=true, achievement=12852, criteria=41017, note=L["Read Damp Scrolls; upstairs"],},
        [70328576] = {quest=52137, atlas="poi-workorders", minimap=true, achievement=12852, criteria=41017, note=L["Read Damp Scrolls; underground"],},
        [67147982] = {quest=52138, atlas="poi-workorders", minimap=true, achievement=12852, criteria=41017, note=L["Read Damp Scrolls"],},
        [55769095] = {quest=52195, atlas="DemonInvasion2", scale=1.4, minimap=true, hide_before={52134, 52135, 52136, 52137, 52138}, item=161342, achievement=12852, criteria=41017, note=L["Ominous Altar; use it, get teleported, pick up the gem"],}, -- Secret of the Depths
        -- Shanty Raid
        [72616853] = {quest=53408, item=163714, atlas="poi-workorders", minimap=true, achievement=13057, criteria=41541, note="On the fireplace mantel",}, -- Lively Men
        [53141767] = {quest=53407, item=163716, atlas="poi-workorders", minimap=true, achievement=13057, criteria=41543, note="Behind Jay the Tavern Bard",}, -- Inebriation
        -- junk
        [66758031] = {quest=50952, junk=true, label=CHEST_SM,},
    },
	[1165] = { -- Dazar'alor
        [59258870] = {quest=50947, minimap=true, achievement=12851, criteria=40994, npc=133208, note="Event: kill Da White Shark first",}, -- Da White Shark's Bounty
        [44472690] = {quest=51338, minimap=true, achievement=12851, criteria=40996, note="In cave behind waterfall",}, -- Cache of Secrets
        [38300716] = {quest=48938, minimap=true, achievement=12851, criteria=40988, note="On top of the Hall of the High Priests",}, -- Offerings of the Chosen
        [41141101] = path(48938),
        -- junk
        [48981013] = {quest=49142, junk=true, label=CHEST,},
	},
--    [1355] = { -- Nazjatar
--		-- [43227436] = {quest=56290, minimap=true, achievement=13549, label=CHEST_AR,}, -- forgot what this is 		
--		[85203860] = {quest=55938, minimap=true, achievement=13549, label=CHEST_AR,},
--		[80302980] = {quest=55939, minimap=true, achievement=13549, label=CHEST_AR,},
--		[74805320] = {quest=55940, minimap=true, achievement=13549, label=CHEST_AR,},
--		[73313580] = {quest=55941, minimap=true, achievement=13549, label=CHEST_AR, note="Inside Temple, bottom floor"},
--		[79502720] = {quest=55942, minimap=true, achievement=13549, label=CHEST_AR},
--		[64303350] = {quest=55943, minimap=true, achievement=13549, label=CHEST_AR},
--		[56493390] = {quest=55944, minimap=true, achievement=13549, label=CHEST_AR, note="Top of the cliffs"},
--		[52904980] = {quest=55945, minimap=true, achievement=13549, label=CHEST_AR},
--		[58103510] = {quest=55946, minimap=true, achievement=13549, label=CHEST_AR, note="Underwater Cave"}, [57303900] = path{quest=55946},
--		[44804880] = {quest=55947, minimap=true, achievement=13549, label=CHEST_AR},
--		[43305810] = {quest=55948, minimap=true, achievement=13549, label=CHEST_AR},
--		[49506450] = {quest=55949, minimap=true, achievement=13549, label=CHEST_AR},
--		[38707440] = {quest=55950, minimap=true, achievement=13549, label=CHEST_AR},
--		[48508740] = {quest=55951, minimap=true, achievement=13549, label=CHEST_AR},
--		[34704350] = {quest=55952, minimap=true, achievement=13549, label=CHEST_AR, note="Inside Cave"}, [37404280] = path{quest=55952},
--		[26003230] = {quest=55953, minimap=true, achievement=13549, label=CHEST_AR, note="Under Starfish pile"},
--		[34504050] = {quest=55954, minimap=true, achievement=13549, label=CHEST_AR},
--		[50605000] = {quest=55955, minimap=true, achievement=13549, label=CHEST_AR, note="Inside Cave"}, [49705030] = path{quest=55955},
--		[39804930] = {quest=55956, minimap=true, achievement=13549, label=CHEST_AR},
--		[38006060] = {quest=55957, minimap=true, achievement=13549, label=CHEST_AR},
		
--		[61502290] = {quest=55958, minimap=true, achievement=13549, label=AR_TRUNK, note="Inside Cave"}, [61401990] = path{quest=55958}, -- game quest id: 55359
--		[37906040] = {quest=55959, minimap=true, achievement=13549, label=AR_TRUNK},
--		[55701440] = {quest=55961, minimap=true, achievement=13549, label=AR_TRUNK}, -- game quest id: 55998 
--		[64202850] = {quest=55962, minimap=true, achievement=13549, label=AR_TRUNK, note="Click Arcane device on the side on the right"}, -- game quest id: 55996
--		[43901680] = {quest=55963, minimap=true, achievement=13549, label=AR_TRUNK},
--		[37900650] = {quest=55960, minimap=true, achievement=13549, label=AR_TRUNK, note="Underwater Cave"}, [39701000] = path{quest=55960}, 
--		[24803520] = {quest=56912, minimap=true, achievement=13549, label=AR_TRUNK, note="Inside Cave"}, [26703380] = path{quest=56912}, -- game quest id: 56913
--		[80503190] = {quest=56547, minimap=true, achievement=13549, label=AR_TRUNK, note="Up the building"}, [83003380] = path{quest=56547}, -- game quest id: 56913
        -- Cats!
--        [28802910] = {quest=56983, minimap=true, achievement=13836, label=KITTY, atlas="Warfront-AllianceHero-Silver", scale=1.2},
--        [61102680] = {quest=56984, minimap=true, achievement=13836, label=KITTY, atlas="Warfront-AllianceHero-Silver", scale=1.2},
--        [59103040] = {quest=56985, minimap=true, achievement=13836, label=KITTY, atlas="Warfront-AllianceHero-Silver", scale=1.2},
--        [55302720] = {quest=56986, minimap=true, achievement=13836, label=KITTY, atlas="Warfront-AllianceHero-Silver", scale=1.2},
--        [40158608] = {quest=56987, minimap=true, achievement=13836, label=KITTY, note="In underwater cave", atlas="Warfront-AllianceHero-Silver", scale=1.2}, [40318144] = path{quest=56987},
--        [71402370] = {quest=56988, minimap=true, achievement=13836, label=KITTY, atlas="Warfront-AllianceHero-Silver", scale=1.2},
--        [38004930] = {quest=56989, minimap=true, achievement=13836, label=KITTY, atlas="Warfront-AllianceHero-Silver", scale=1.2}, [38704930] = path{quest=56989},
--        [58202200] = {quest=56990, minimap=true, achievement=13836, label=KITTY, atlas="Warfront-AllianceHero-Silver", scale=1.2},
--        [61601070] = {quest=56991, minimap=true, achievement=13836, label=KITTY, atlas="Warfront-AllianceHero-Silver", scale=1.2},
--        [73602590] = {quest=56992, minimap=true, achievement=13836, label=KITTY, atlas="Warfront-AllianceHero-Silver", scale=1.2},
--    },
    [1462] = { --Mechagon
        [14988130] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
        [23617467] = {label = "Jetpack", ["cont"] = true, cauldron = true,},     
        [37104801] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
        [39433918] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
		[45435013] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
        [49073498] = {label = "Jetpack", ["cont"] = true, cauldron = true,},     
        [55062542] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
        [58744807] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
		[66483501] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
        [68905000] = {label = "Jetpack", ["cont"] = true, cauldron = true,},     
        [78003970] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
        [79205650] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
		[79704810] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
        [82206240] = {label = "Jetpack", ["cont"] = true, cauldron = true,},     
        [71376704] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
        [71955044] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
		[77875051] = {label = "Jetpack", ["cont"] = true, cauldron = true,},
		[10802777] = {label = "!! Jetpacks spawn once every 1-2 days !!", ["cont"] = true, cauldron = false,} --extra question mark to explain jetpack
    },
}

------ Icons DB -------
local eliteOr = "Interface\\Worldmap\\Skull_64Blue" -- Jaune
local eliteAr = "Interface\\Worldmap\\Skull_64Grey" -- Gris
local skull = "Interface\\Worldmap\\Skull_64Purple" -- violet
-----------------------

local merge = BFA_HF_Tracker_merge

local path = function(questid, label, atlas, note, scale)
    label = label or L["Entrance "]
    atlas = atlas or "map-icon-SuramarDoor.tga"
    return {
        quest = questid,
        label = label,
        atlas = atlas,
        path = true,
        scale = scale,
        note = note,
    }
end
BFA_HF_Tracker_path = path

--[[ structure:
    [uiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            currency=[id], -- currencyid
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
            hide_before=[id], -- hide if quest not completed
			faction=[string], -- Alliance / Horde
        },
    },
]]--

merge(BFA_HF_Tracker_points[862], { -- Zuldazar
    [80972163] = {quest=50280, npc=129961, item=161042, achievement=12944, criteria=41850, note="Climb the ropes onto the ship"}, -- Atal'zul Gotaka
    [53944489] = path{50280},
    [64253271] = {quest=50439, npc=129954, item=161043, achievement=12944, criteria=41851,}, -- Gahz'ralka
    [44157652] = {quest=51083, npc=136428, item=160979, achievement=12944, criteria=41852,}, -- Dark Chronicler
    [53404465] = {quest=51080, npc=136413, item=161047, achievement=12944, criteria=41853, note="In cave, down the river"}, -- Syrawon the Dominus
    [48005424] = {quest=49972, npc=131476, item=161125, achievement=12944, criteria=41869,}, -- Zayoos
    [58777395] = {quest=49911, npc=131233, item=161033, achievement=12944, criteria=41870,}, -- Lei-zhi
    [49855744] = {quest=49410, npc=129343, item=161034, achievement=12944, criteria=41871, note="In cave",}, -- Avatar of Xolotal
    [49605911] = path{49410},
    [59821830] = {quest=49267, npc=128699, item=161104, achievement=12944, criteria=41872,}, -- Bloodbulge
    [46616533] = {quest=49004, npc=127939, item=161029, achievement=12944, criteria=41873,}, -- Torraske the Eternal
    [68714875] = {quest=48543, npc=126637, item=160984, achievement=12944, criteria=41874,}, -- Kandak
    [59605640] = {quest=48333, npc=120899, item=160947, achievement=12944, criteria=41875,}, -- Kul'krazahn
    [74112850] = {quest=47792, npc=124185, item=161035, achievement=12944, criteria=41876,}, -- Golrakahn
    [71423239] = {quest=47567, npc=122004, item=161091, achievement=12944, criteria=41877, note="In cave",}, -- Umbra'jin
    [70333301] = path{47567},
    [65411022] = {quest=50693, npc=134760, item=160958, achievement=12944, criteria=41855,}, -- Darkspeaker Jo'la
    [42003620] = {quest=50677, npc=134738, item=160978, achievement=12944, criteria=41856,}, -- Hakbi the Risen
    [61904622] = {quest=50508, npc=134048, item=162613, achievement=12944, criteria=41858, note="Interact with Strange Egg",}, -- Vukuba
    [43952544] = {quest=50438, npc=133842, item=161040, achievement=12944, criteria=41859,}, -- Warcrawler Karkithiss
    [60626627] = {quest=50281, npc=134782, item=161022, achievement=12944, criteria=41863,}, -- Murderbeak
    [74203930] = {quest=50269, npc=133190, achievement=12944, criteria=41864,}, -- Daggerjaw
    [79973597] = {quest=50260, npc=133155, achievement=12944, criteria=41865,}, -- G'Naat
    [75613582] = {quest=50159, npc=132244, item=161112, achievement=12944, criteria=41866,}, -- Kiboku
    [66203240] = {quest=50034, npc=131718, item=161020, achievement=12944, criteria=41867,}, -- Bramblewing
    [77711029] = {quest=50013, npc=131687, item=161109, achievement=12944, criteria=41868,}, -- Tambano
    [69783776] = {quest=54770, npc=149147, item=166345,}, -- N'chala  the Egg Thief
    -- Life Finds a Way... To Die!
    [67732903] = {npc=135512, achievement=13048, criteria=41675, note="Shares spawn timer with Azuresail the Ancient and Kil'Tawan",}, -- Thuderfoot the Brutosaur
    [67102657] = {npc=135510, achievement=13048, criteria=41676, note="Shares spawn timer with Thunderfoot and Kil'Tawan",}, -- Azuresail the Diemetrodon
    [71134034] = {npc=139365, achievement=13048, criteria=41672, note="South of Savagelands",}, -- Queenfeather the Ravasaur
    [52394771] = {npc=129323, achievement=13048, criteria=41674, note="Can be found near the road in the grass",}, -- The Sabertusk Empress
    [66082238] = {npc=143910, achievement=13048, criteria=41684, note="South of the Nesingwary's Trek windrider",}, -- Sludgecrusher the Anklyodon
    [61622537] = {npc=130741, achievement=13048, criteria=41673, note="Fighting Ten'gor at crossroad",}, -- Nol'ixwan the Direhorn
    [71242184] = {npc=123502, achievement=13048, criteria=41677, note="On the road from Zeb'ahari to Tal'gurub",}, -- King K'tal the Devilsaur
    -- Mushroom Harvest
    [45537917] = {npc=143314, achievement=13027, criteria=41391, note="On the beach, between trees",}, -- Bane of the Woods
})
merge(BFA_HF_Tracker_points[1165], { -- Dazar'alor
	[55378240] = {quest=48333, npc=120899, item=160947, achievement=12944, criteria=41875,}, -- Kul'krazahn
})
merge(BFA_HF_Tracker_points[863], { -- Nazmir
    [67812972] = {quest=48063, npc=125250, achievement=12942, criteria=41440,}, -- Ancient Jawbreaker
    [32802690] = {quest=50563, npc=134293, achievement=12942, criteria=41447,}, -- Azerite-Infused Slag
    [44224873] = {quest=49305, npc=128965, achievement=12942, criteria=41450,}, -- Uroku the Bound
    [68102023] = {quest=50567, npc=134296, achievement=12942, criteria=41452,}, -- Chag's Challenge
    [81813057] = {quest=48057, npc=125232, achievement=12942, criteria=41454,}, -- Cursed Chest
    [68955747] = {quest=50361, npc=121242, achievement=12942, criteria=41456,}, -- Glompmaw
    [56666932] = {quest=49312, npc=128974, achievement=12942, criteria=41458,}, -- Queen Tzxi'kik
    [45375197] = {quest=50307, npc=133373, achievement=12942, criteria=41460,}, -- Jax'teb the Reanimated
    [52931340] = {quest=47843, npc=124397, achievement=12942, criteria=41462,}, -- Kal'draxa
    [81696105] = {quest=50565, npc=134295, achievement=12942, criteria=41464,}, -- Lost Scroll
    [58963893] = {quest=48972, npc=127820, achievement=12942, criteria=41467,}, -- Scout Skrasniss
    [31443815] = {quest=48508, npc=126460, achievement=12942, criteria=41469,}, -- Tainted Guardian
    [38095768] = {quest=50888, npc=135565, achievement=12942, criteria=41472,}, -- Urn of Agussu
    [48985082] = {quest=48623, npc=126907, achievement=12942, criteria=41474,}, -- Wardrummer Zurula
    [38722674] = {quest=49469, npc=129657, achievement=12942, criteria=41476,}, -- Za'amar the Queen's Blade
    [78084451] = {quest=50355, npc=133539, achievement=12942, criteria=41478,}, -- Lo'kuno
    [54128110] = {quest=50569, npc=134298, achievement=12942, criteria=41444,}, -- Azerite-Infused Elemental
    [43199131] = {quest=48541, npc=126635, achievement=12942, criteria=41448, note="In cave, behind waterfall"}, -- Blood Priest Xak'lar
    [43069011] = path{48541},
    [53694287] = {quest=49317, npc=129005, achievement=12942, criteria=41451,}, -- King Kooba
    [41665344] = {quest=48462, npc=126187, achievement=12942, criteria=41453,}, -- Corpse Bringer Yal'kar
    [33538708] = {quest=48638, npc=127001, achievement=12942, criteria=41455,}, -- Gwugnug the Cursed
    [32344332] = {quest=49231, npc=128426, achievement=12942, criteria=41457,}, -- Gutrip
    [24967778] = {quest=47877, npc=124399, achievement=12942, criteria=41459,}, -- Infected Direhorn
    [27823357] = {quest=50342, npc=133527, achievement=12942, criteria=41461,}, -- Juba the Scarred
    [76033654] = {quest=48052, npc=125214, achievement=12942, criteria=41463,}, -- Krubbs
    [42805949] = {quest=48439, npc=126142, achievement=12942, criteria=41466,}, -- Bajiatha
    [58431014] = {quest=48980, npc=127873, achievement=12942, criteria=41468,}, -- Scrounger Patriarch
    [49453714] = {quest=48406, npc=126056, achievement=12942, criteria=41470,}, -- Totem Maker Jash'ga
    [29705107] = {quest=48626, npc=126926, achievement=12942, criteria=41473,}, -- Venomjaw
    [36555053] = {quest=50348, npc=133531, achievement=12942, criteria=41475,}, -- Xu'ba
    [38887148] = {quest=50423, npc=133812, achievement=12942, criteria=41477,}, -- Zanxib
    [52605489] = {quest=50040, npc=128930, achievement=12942, criteria=41479,}, -- Mala'kili and Rohnkor
    -- Life Finds a Way... To Die!
    [25706971] = {npc=143898, achievement=13048, criteria=41683, note="Flying close to the road from Vol'dun to Zuldazar",}, -- Makatau the Pterrordax
    -- Mushroom Harvest
    [52357020] = {npc=143316, achievement=13027, criteria=41390, note="South of Heart of Darkness. Entrance is from the north side of Xal'vor ruins",}, -- Skullcap
    [73614870] = {npc=143311, achievement=13027, criteria=41393, note="In cave, entrance at 73.2 49.7",}, -- Toadcruel
    -- [73204970] = path(), Path without quest?
})
merge(BFA_HF_Tracker_points[864], { -- Vol'dun
    [50378160] = {quest=51058, npc=135852, achievement=12943, criteria=41606,}, -- Ak'tar
    [54701517] = {quest=47532, npc=130439, achievement=12943, criteria=41607,}, -- Ashmane
    [49058905] = {quest=49252, npc=128553, achievement=12943, criteria=41608,}, -- Azer'tor
    [31008109] = {quest=49251, npc=128497, achievement=12943, criteria=41609,}, -- Bajiani the Slick
    [49064989] = {quest=47562, npc=129476, achievement=12943, criteria=41610,}, -- Bloated Krolusk
    [56105356] = {quest=51079, npc=136393, achievement=12943, criteria=41611,}, -- Bloodwing Bonepicker
    [41272449] = {quest=51073, npc=136346, achievement=12943, criteria=41612,}, -- Captain Stef "Marrow" Quin
    [42679245] = {quest=50905, npc=124722, achievement=12943, criteria=41613,}, -- Commodore Calhoun
    [61853788] = {quest=51077, npc=136335, achievement=12943, criteria=41614,}, -- Enraged Krolusk
    [64004757] = {quest=49270, npc=128674, achievement=12943, criteria=41615,}, -- Gut-Gut the Glutton
    [53685347] = {quest=47533, npc=130443, achievement=12943, criteria=41616, note="In cave"}, -- Hivemother Kraxi
    [53835149] = path{47533},
    [37428498] = {quest=49392, npc=129283, achievement=12943, criteria=41617,}, -- Jumbo Sandsnapper
    [60561801] = {quest=51074, npc=136341, achievement=12943, criteria=41618,}, -- Jungleweb Hunter
    [35085183] = {quest=50528, npc=128686, achievement=12943, criteria=41619,}, -- Kamid the Trapper
    [38284138] = {quest=51424, item=161108, npc=137681, achievement=12943, criteria=41620, note="In cave"}, -- King Clickyclack
    [37354050] = path{51424},
    [43758624] = {quest=50898, npc=128951, achievement=12943, criteria=41621,}, -- Nez'ara
    [49017210] = {quest=51126, npc=136340, achievement=12943, criteria=41622,}, -- Relic Hunter Hazaak
    [44538023] = {quest=48960, npc=127776, achievement=12943, criteria=41623,}, -- Scaleclaw Broodmother
    [32716522] = {quest=51076, npc=136336, achievement=12943, criteria=41624,}, -- Scorpox
    [24736850] = {quest=51075, npc=136338, achievement=12943, criteria=41625,}, -- Sirokar
    [46972518] = {quest=50637, npc=134571, achievement=12943, criteria=41626, note="In cave",}, -- Skycaller Teskris
    [46242714] = path{50637},
    [51263645] = {quest=50686, npc=134745, achievement=12943, criteria=41627,}, -- Skycarver Krakit
    [66892446] = {quest=51063, npc=136304, achievement=12943, criteria=41628,}, -- Songstress Nahjeen
    [57197349] = {quest=49674, npc=130401, achievement=12943, criteria=41629,}, -- Vathikur
    [37084616] = {quest=49373, npc=129180, achievement=12943, criteria=41630,}, -- Warbringer Hozzik
    [30115256] = {quest=50662, npc=134638, achievement=12943, criteria=41631,}, -- Warlord Zothix
    [50713086] = {quest=50658, npc=134625, achievement=12943, criteria=41632,}, -- Warmother Captive
    [43915405] = {quest=48319, npc=129411, achievement=12943, criteria=41633, note="Inside skeleton under the sand"}, -- Zunashi the Exile
    [43985246] = path{48319},
	-- Elite Rare Argent
	[53603500] = {quest=51065, atlasHf=eliteAr, npc=136323, item=162612,}, -- Mandecroc
	[29904640] = {quest=50663, atlasHf=eliteAr, npc=134643, item=161044,}, -- Brgl-Lrgl le Cogneur
	[37408870] = {quest=50666, atlasHf=eliteAr, npc=134694, item=162616,}, -- Mor'fani l'Exilé
	-- Elite Rare Or
	[43905690] = {quest=53000, atlasHf=eliteOr, npc=138794, item=161405,}, -- Krolauk gorgedune
    -- HF 13027 - Récolte de champignons
    [61101826] = {npc=143313, achievement=13027, criteria=41392, note="Shrouded Shore, on the hill",}, -- Portakillo
})
merge(BFA_HF_Tracker_points[895], { -- Tiragarde Sound
    [75147848] = {quest=50156, npc=132182, achievement=12939, criteria=41793,}, -- Auditor Dolp
    [76218305] = {quest=50233, npc=129181, item=163717, achievement=12939, criteria=41795,}, -- Barman Bill
    [34013029] = {quest=50094, npc=132068, achievement=12939, criteria=41796,}, -- Bashmu
    [56676994] = {quest=50096, npc=132086, item=163718, achievement=12939, criteria=41797,}, -- Black-Eyed Bart
    [84707385] = {quest=51808, npc=139145, item=154411, achievement=12939, criteria=41798, note="Hillside above the cave",}, -- Blackthorne
    [83364413] = {quest=49999, npc=130508, achievement=12939, criteria=41800,}, -- Broodmother Razora
    [38422066] = {quest=50097, npc=132088, achievement=12939, criteria=41806,}, -- Captain Wintersail
    [72838146] = {quest=51809, npc=139152, achievement=12939, criteria=41812,}, -- Carla Smirk
    [89787815] = {quest=50155, npc=132211, achievement=12939, criteria=41813,}, -- Fowlmouth
    [59982275] = {quest=50137, npc=132127, achievement=12939, criteria=41814,}, -- Foxhollow Skyterror
    [57725613] = {quest=53373, npc=139233, achievement=12939, criteria=41819,}, -- Gulliver
    [48072334] = {quest=49984, npc=131520, achievement=12939, criteria=41820,}, -- Kulett the Ornery
    [68352088] = {quest=50525, npc=134106, item=155524, achievement=12939, criteria=41821,}, -- Lumbergrasp Sentinel
    [58094870] = {quest=51880, npc=139290, item=154458, achievement=12939, criteria=41822,}, -- Maison the Portable
    [64291931] = {quest=51321, npc=137183, item=160472, achievement=12939, criteria=41823,}, -- Imperiled Merchants (Honey-Coated Slitherer)
    [43801771] = {quest=49921, npc=131252, achievement=12939, criteria=41824,}, -- Merianae
    [65176460] = {quest=51833, npc=139205, achievement=12939, criteria=41825,}, -- P4-N73R4
    [39461517] = {quest=49923, npc=131262, item=160263, achievement=12939, criteria=41826,}, -- Pack Leader Asenya
    [64805893] = {quest=50148, npc=132179, item=161446, achievement=12939, criteria=41827,}, -- Raging Swell
    [68336362] = {quest=51872, npc=139278, achievement=12939, criteria=41828,}, -- Ranja
    [58541513] = {quest=48806, npc=127290, item=154416, achievement=12939, criteria=41829,}, -- Saurolisk Tamer Mugg (Mugg)
    [76022887] = {quest=51877, npc=139287, item=155273, achievement=12939, criteria=41830,}, -- Sawtooth
    [55703318] = {quest=51876, npc=139285, achievement=12939, criteria=41831,}, -- Shiverscale the Toxic
    [80838277] = {quest=50160, npc=132280, achievement=12939, criteria=41832,}, -- Squacks
    [49353613] = {quest=51807, npc=139135, achievement=12939, criteria=41833,}, -- Squirgle of the Depths
    [66701427] = {quest=51873, npc=139280, achievement=12939, criteria=41834,}, -- Sythian the Swift
    [60801727] = {quest=50301, npc=133356, achievement=12939, criteria=41835,}, -- Tempestria
    [55095056] = {quest=51879, npc=139289, achievement=12939, criteria=41836,}, -- Tentulos the Drifter
    [63735039] = {quest=49942, npc=131389, item=158556, achievement=12939, criteria=41837,}, -- Teres
    [70035567] = {quest=51835, npc=139235, achievement=12939, criteria=41838,}, -- Tort Jaw
    [46391997] = {quest=50095, npc=132076, item=160452, achievement=12939, criteria=41839,}, -- Totes
    [70271283] = {quest=50073, npc=131984, item=160473, achievement=12939, criteria=41840,}, -- Twin-hearted Construct
    [61515233] = {quest=49963, npc=130350, item=155571, note="Ride to Roan Berthold in Southwind Station; follow the road",}, -- Guardian of the Spring (49983 is the ride, 49963 is the loot)
    -- [52253215] = {quest=nil, npc=132052, item=155074,}, -- Vol'Jim (removed from game?)
})
merge(BFA_HF_Tracker_points[1161], { -- Boralus
    [80403500] = {quest=51877, npc=139287, achievement=12939, criteria=41830,}, -- Sawtooth
})
merge(BFA_HF_Tracker_points[896], { -- Drustvar
    [59933466] = {quest=47884, npc=124548, achievement=12941, criteria=41706,}, -- Betsy
    [58901790] = {quest=48842, npc=127333, achievement=12941, criteria=41708,}, -- Barbthorn Queen
    [66585068] = {quest=48978, item=154376, npc=126621, achievement=12941, criteria=41711,}, -- Bonesquall
    [59245526] = {quest=48981, npc=127877, achievement=12941, criteria=41713, note="Pick one to fight; Dagger from Longfang, mail gloves from Henry",}, -- Longfang & Henry Breakwater
    [52074697] = {quest=49216, item=163036, npc=129904, achievement=12941, criteria=41715,}, -- Cottontail Matron
    [65002266] = {quest=49311, npc=128973, achievement=12941, criteria=41718,}, -- Whargarble the Ill-Tempered
    [50842040] = {quest=49388, npc=127129, achievement=12941, criteria=41720,}, -- Grozgore
    [51352957] = {quest=49481, npc=129805, achievement=12941, criteria=41722,}, -- Beshol
    [63414020] = {quest=49530, npc=129995, achievement=12941, criteria=41724,}, -- Emily Mayville
    [56572924] = {quest=49602, item=160475, npc=130143, achievement=12941, criteria=41726,}, -- Balethorn
    [31011831] = {quest=50546, npc=134213, achievement=12941, criteria=41728,}, -- Executioner Blackwell
    [22934796] = {quest=50688, npc=134754, achievement=12941, criteria=41729,}, -- Hyo'gi
    [34966921] = {quest=51383, npc=137529, achievement=12941, criteria=41732,}, -- Arvon the Betrayed
    [43808828] = {quest=51471, npc=137825, achievement=12941, criteria=41736,}, -- Avalanche
    [29202488] = {quest=51700, npc=138675, achievement=12941, criteria=41742,}, -- Gorged Boar
    [24242193] = {quest=51749, npc=138866, item=154217, achievement=12941, criteria=41748,}, -- Fungi Trio (quest 51887 also?)
    [30476344] = {quest=51923, npc=139322, item=154315, achievement=12941, criteria=41751,}, -- Whitney "Steelclaw" Ramsay
    [66574259] = {quest=48178, npc=125453, item=158583, achievement=12941, criteria=41707,}, -- Quillrat Matriarch
    [72786036] = {quest=48928, item=160474, npc=127651, achievement=12941, criteria=41709,}, -- Vicemaul
    [62956938] = {quest=48979, npc=127844, achievement=12941, criteria=41712,}, -- Gluttonous Yeti
    [43463611] = {quest=49137, achievement=12941, criteria=41714,}, -- Ancient Sarcophagus
    [59557181] = {quest=49269, npc=128707, achievement=12941, criteria=41717,}, -- Rimestone
    [67936683] = {quest=49341, item=158598, achievement=12941, criteria=41719,}, -- Seething Cache
    [57424380] = {quest=49480, npc=129835, achievement=12941, criteria=41721,}, -- Gorehorn
    [32204036] = {quest=49528, npc=129950, achievement=12941, criteria=41723,}, -- Talon
    [59874478] = {quest=49601, npc=130138, achievement=12941, criteria=41725,}, -- Nevermore
    [35483290] = {quest=50163, npc=132319, achievement=12941, criteria=41727,}, -- Bilefang Mother
    [18746057] = {quest=50669, npc=134706, achievement=12941, criteria=42342,}, -- Deathcap
    [28051425] = {quest=50939, npc=135796, achievement=12941, criteria=41730,}, -- Captain Leadfist
    [29056863] = {quest=51470, npc=137824, achievement=12941, criteria=41733,}, -- Arclight
    [23422975] = {quest=51698, npc=138618, achievement=12941, criteria=41739,}, -- Haywire Golem
    [33245765] = {quest=51748, npc=138863, achievement=12941, criteria=41745,}, -- Sister Martha
    [26935962] = {quest=51922, npc=139321, achievement=12941, criteria=41750,}, -- Braedan Whitewall
    -- [20295731] = {quest=nil, npc=137665,}, -- Soul Goliath
    -- [35711177] = {quest=nil, npc=138667,}, -- Blighted Monstrosity
    -- [25151616] = {quest=nil, npc=139358,}, -- The Caterer
    -- [34722062] = {quest=nil, npc=137704,}, -- Matron Morana
})
merge(BFA_HF_Tracker_points[942], { -- Stormsong Valley
    [71003200] = {quest=52448, npc=141175, item=158218, achievement=12940, criteria=41753,}, -- Song Mistress Dadalea
    [22607300] = {quest=50938, npc=140997, achievement=12940, criteria=41754,}, -- Severus the Outcast
    [33603800] = {quest=51757, npc=138938, item=160477, achievement=12940, criteria=41755,}, -- Seabreaker Skoloth
    [34203240] = {quest=51956, npc=139328, item=154664, achievement=12940, criteria=41756,}, -- Sabertron
    [51807960] = {quest=50974, npc=136189, item=155222, achievement=12940, criteria=41757,}, -- The Lichen King
    [41607360] = {quest=50725, npc=134884, item=160465, achievement=12940, criteria=41758,}, -- Ragna
    [41302920] = {quest=51958, npc=139319, item=158216, achievement=12940, criteria=41759,}, -- Slickspill
    [29206960] = {quest=51298, npc=137025, item=160470, achievement=12940, criteria=41760,}, -- Broodmother
    [71305430] = {quest=50075, npc=132007, item=155568, achievement=12940, criteria=41761,}, -- Galestorm
    [47004220] = {quest=52457, npc=142088, item=158215, achievement=12940, criteria=41762,}, -- Whirlwing
    [31406260] = {quest=52318, npc=141029, item=154475, achievement=12940, criteria=41763,}, -- Kickers
    [64406560] = {quest=49951, npc=131404, item=160471, achievement=12940, criteria=41765,}, -- Foreman Scripps
    [34406760] = {quest=52469, npc=141286, achievement=12940, criteria=41769,}, -- Poacher Zane
    [37905040] = {quest=51959, npc=139298, item=163678, achievement=12940, criteria=41772,}, -- Pinku'shon
    [62007340] = {quest=52329, npc=141059, item=155572, achievement=12940, criteria=41774,}, -- Grimscowl the Harebrained
    [53005200] = {quest=50692, npc=139385, item=160464, achievement=12940, criteria=41775,}, -- Deepfang
    [63003300] = {quest=52303, npc=140938, item=154460, achievement=12940, criteria=41776,}, -- Croaker
    [66905200] = {quest=52121, npc=139968, item=154183, achievement=12940, criteria=41777,}, -- Corrupted Tideskipper (also i:162028)
    [51405540] = {quest=52466, npc=136183, item=154857, achievement=12940, criteria=41778,}, -- Crushtacean
    [67804000] = {quest=50731, npc=134897, item=160476, achievement=12940, criteria=43470,}, -- Dagrus the Scorned
    [49807000] = {quest=50037, npc=135939, item=158299, achievement=12940, criteria=41782,}, -- Vinespeaker Ratha
    [53106910] = {quest=50024, npc=135947, achievement=12940, criteria=41787,}, -- Strange Mushroom Ring
    [33607500] = {quest=52460, npc=141226, achievement=12940, criteria=41815,}, -- Haegol the Hammer
    [57007580] = {quest=52433, npc=141088, item=158224, achievement=12940, criteria=41816,}, -- Squall
    [63408320] = {quest=52327, npc=141039, achievement=12940, criteria=41817,}, -- Ice Sickle
    [47206580] = {quest=50170, npc=130897, item=155287, achievement=12940, criteria=41818,}, -- Captain Razorspine
    [47306590] = {quest=52296, npc=129803, achievement=12940, criteria=41841,}, -- Whiplash
    [61605700] = {quest=52441, npc=141143, item=155164, achievement=12940, criteria=41842,}, -- Sister Absinthe
    [42807500] = {quest=50819, npc=130079, item=154431, achievement=12940, criteria=41843,}, -- Wagga Snarltusk
    [43404490] = {quest=51762, npc=138963, item=160477, achievement=12940, criteria=41844,}, -- Nestmother Acada
    [42006280] = {quest=52461, npc=141239, item=159169, achievement=12940, criteria=41845,}, -- Osca the Bloodied
    [73806080] = {quest=52125, npc=139988, item=154389, achievement=12940, criteria=41846,}, -- Sandfang
    [60004600] = {quest=52123, npc=139980, item=154449, achievement=12940, criteria=41847,}, -- Taja the Tidehowler
    [53406450] = {quest=52323, npc=140925, item=159179, achievement=12940, criteria=nil, faction="Horde",}, -- Doc Marrtens
    [53416451] = {quest=52324, npc=141043, item=nil, achievement=12940, criteria=nil, faction="Alliance", note="Talk to Doc Marrtens",}, -- Jakala the Cruel
	-- Elite Rare Argent
	[66407490] = {quest=50541, atlasHf=eliteAr, npc=134147, item=160459,}, -- Béhémiel
    -- [72545052] = {quest=nil, npc=139515,}, -- Sandscour
    -- [68745147] = {quest=nil, npc=132047,}, -- Reinforced Hullbreaker
    -- [40143732] = {quest=nil, npc=137649,}, -- Pest Remover Mk. II
    -- [67217525] = {quest=nil, npc=134147,}, -- Beehemoth
})
--merge(BFA_HF_Tracker_points[1355], { -- Nazjatar
--    [78003280] = {quest=56276, npc=151870, item=169369, achievement=13691, criteria=45543,note="Summoned using a [Scrying Stone]"}, -- Sandcastle
--    [58805460] = {quest=56281, npc=152566, item=170184, achievement=13691, criteria=45522,note="Requires killing a Colossal Ray on top of it for spawn"}, -- Anemonar
--    [50606920] = {quest=56287, npc=152567, item=170184, achievement=13691, criteria=45535,note="Requries charming a Muck Slug using a [Prismatic Crystal] and bringing it in front of him"}, -- Kelpwillow
--    [78602580] = {quest=56288, npc=152397, item=170184, achievement=13691, criteria=45539,note="Requires summoning the Drowned Hatchling pet in front of him"}, -- Oronu
--    [31603060] = {quest=56299, npc=152568, item=170184, achievement=13691, criteria=45557,note="Must kill a Staghorn Reefwalker in front of him"}, -- Urduu
--    [71605420] = {quest=56282, npc=152561, item=170179, achievement=13691, criteria=45524,note="Spawns after you kill Siltstalker",}, -- Banescale the Packfather
--    [56204360] = {quest=56272, npc=152291, item=nil, achievement=13691, criteria=45530,}, -- Deepglider
--    [28802900] = {quest=55671, npc=152323, item=169371, achievement=13691, criteria=45536,note="Requires to Shoo the Bloodfin Tadpoles until the King emotes a few times"}, -- King Gakula
--    [71405480] = {quest=56297, npc=152359, item=170179, achievement=13691, criteria=45550,}, -- Siltstalker the Packmother
--    [64604700] = {quest=56278, npc=152360, item=170178, achievement=13691, criteria=45556,}, -- Toxigore the Alpha
--    [63803260] = {quest=56284, npc=152414, item=nil, achievement=13691, criteria=45531,}, -- Elder Unu
--    [52404200] = {quest=56279, npc=152415, item=nil, achievement=13691, criteria=45519,}, -- Alga the Eyeless
--    [69204020] = {quest=56280, npc=152416, item=nil, achievement=13691, criteria=45520,}, -- Allseer Oma'kil
--    [47205500] = {quest=56286, npc=152448, item=169352, achievement=13691, criteria=45534,note="Requires killing Glimmershell Hulks around his spawn points"}, -- Iridescent Glimmershell
--    [45602560] = {quest=56275, npc=152465, item=169355, achievement=13691, criteria=45538,}, -- Needlespine
--    [35604120] = {quest=56292, npc=152548, item=169370, achievement=13691, criteria=45545,}, -- Scale Matriarch Gratinax
--    [27403720] = {quest=56293, npc=152545, item=169370, achievement=13691, criteria=45546,}, -- Scale Matriarch Vynara
--    [28704630] = {quest=56294, npc=152542, item=169370, achievement=13691, criteria=45547,}, -- Scale Matriarch Zodia
--    [37201320] = {quest=56274, npc=144644, item=169366, achievement=13691, criteria=45537,}, -- Mirecrawler
--    [36003960] = {quest=56273, npc=152553, item=170180, achievement=13691, criteria=45533,}, -- Garnetscale
--    [52207400] = {quest=56285, npc=152555, item=169359, achievement=13691, criteria=45532,}, -- Elderspawn Nalaada
--    [49008800] = {quest=56270, npc=152556, item=nil, achievement=13691, criteria=45528,}, -- Chasm-Haunter
--    [43008760] = {quest=56289, npc=152681, item=169367, achievement=13691, criteria=45540,}, -- Prince Typhonus
--    [42807480] = {quest=56290, npc=152682, item=169368, achievement=13691, criteria=45541,}, -- Prince Vortran
--    [36408000] = {quest=56269, npc=152712, item=169372, achievement=13691, criteria=45525,}, -- Blindlight
--    [72203620] = {quest=56268, npc=152794, item=169363, achievement=13691, criteria=45521,}, -- Amethyst Spireshell
--    [64804060] = {quest=56277, npc=152795, item=169350, achievement=13691, criteria=45544,}, -- Sandclaw Stoneshell
--    [37801440] = {quest=56296, npc=153658, item=170182, achievement=13691, criteria=45549,}, -- Shiz'narasz the Consumer
--    [62402960] = {quest=56122, npc=153898, item=170502, achievement=13691, criteria=45553,note="Must kill chanelling Azsh'ari Invokers until it spawns"}, -- Tidelord Aquatus
--    [57602600] = {quest=56123, npc=153928, item=170502, achievement=13691, criteria=45554,note="Must kill chanelling Azsh'ari Invokers until it spawns"}, -- Tidelord Dispersius
--    [39005930] = {quest=56271, npc=152756, item=169361, achievement=13691, criteria=45529,}, -- Daggertooth Terror
--    [63401160] = {quest=56295, npc=152552, item=170187, achievement=13691, criteria=45548,}, -- Shassera
--    [67152325] = {quest=56106, npc=154148, item=170196, achievement=13691, criteria=45555,}, -- Tidemistress Leth'sindra
--    [40800735] = {quest=56283, npc=152464, item=169356, achievement=13691, criteria=45527,}, -- Caverndark Terror
--    [62405950] = {quest=56291, npc=150583, item=169374, achievement=13691, criteria=45542,note="Has a chance to spawn after you kill Algans"}, -- Rockweed Shambler
--    [57605220] = {quest=56298, npc=152290, item=169163, achievement=13691, criteria=45551,}, -- Soundless
--    [67603460] = {quest=56300, npc=151719, item=nil, achievement=13691, criteria=45558, note="Get a Molted Shell to break rocks"}, -- Voice in the Deeps
--    [83403300] = {quest=nil, npc=152729, item=nil,}, -- Moon Priestess Liara
--    [83603740] = {quest=nil, npc=152736, item=nil,}, -- Guardian Tannin
--    [33204000] = {quest=nil, npc=153296, item=nil,}, -- Shalan'ali Stormtongue
--    [63805700] = {quest=nil, npc=153299, item=nil,}, -- Bonebreaker Szun
--    [42804300] = {quest=nil, npc=153300, item=nil,}, -- Iron Zoko
--    [33203920] = {quest=nil, npc=153301, item=nil,}, -- Shirakess Starseeker
--    [43004240] = {quest=nil, npc=153302, item=nil,}, -- Glacier Mage Zhiela
--    [33603020] = {quest=nil, npc=153303, item=nil,}, -- Voidblade Kassar
--    [68203300] = {quest=nil, npc=153304, item=nil,}, -- Undana Frostbarb
--    [68403340] = {quest=nil, npc=153305, item=nil,}, -- Zanj'ir Brutalizer
--    [61202440] = {quest=nil, npc=153309, item=nil,}, -- Alzana, Arrow of Thunder
--    [61801220] = {quest=nil, npc=153310, item=nil,}, -- Qalina, Spear of Ice
--    [33403020] = {quest=nil, npc=153311, item=nil,}, -- Slitherblade Azanz
--    [41402400] = {quest=nil, npc=153312, item=nil,}, -- Kyx'zhul the Deepspeaker
--    [60401440] = {quest=nil, npc=153314, item=nil,}, -- Aldrantiss
---   [33402940] = {quest=nil, npc=155811, item=nil,}, -- Commander Minzera
--    [49406580] = {quest=nil, npc=155836, item=nil,}, -- Theurgist Nitara
--    [48352400] = {quest=55603, npc=150468, item=169376,}, -- Vor'koth
--    [36901120] = {quest=55584, npc=150191, item=169373,}, -- Avarius
--    [54804200] = {quest=55366, npc=149653, item=169375,}, -- Carnivorous Lasher (also seen 56296 + 56587)
--})
--merge(BFA_HF_Tracker_points[1462], { -- Mechagon
--    [62802600] = {quest=55814, npc=150342, item=167042, achievement=13470, criteria=45138,}, -- Earthbreaker Gulroc
--    [60604460] = {quest=55546, npc=150394, item=170072, achievement=13470, criteria=45158,}, -- Armored Vaultbot
--    [38805320] = {quest=55368, npc=150575, item=168001, achievement=13470, criteria=45123,}, -- Rumblerocks
--    [19207940] = {quest=55545, npc=150937, item=168063, achievement=13470, criteria=45133,}, -- Seaspit
--    [56905330] = {quest=55207, npc=151124, item=168490, achievement=13470, criteria=45117,}, -- Mechagonian Nullifier
--    [65605100] = {quest=55513, npc=151202, item=167871, achievement=13470, criteria=45127,}, -- Foul Manifestation
--    [56803990] = {quest=nil, npc=151296, item=nil, achievement=13470, criteria=45129,}, -- OOX-Avenger/MG
--    [53003300] = {quest=55539, npc=151308, item=nil, achievement=13470, criteria=45131,}, -- Boggac Skullbash
--    [35804300] = {quest=55514, npc=151569, item=167836, achievement=13470, criteria=45128,}, -- Deepwater Maw
--    [71204840] = {quest=55364, npc=151623, item=168435, achievement=13470, criteria=45118,}, -- The Scrap King
--    [59806080] = {quest=55859, npc=151627, item=168248, achievement=13470, criteria=45156,}, -- Mr. Fixthis
--    [86801940] = {quest=55386, npc=151672, item=169393, achievement=13470, criteria=45119,}, -- Mecharantula
--    [75404400] = {quest=55399, npc=151684, item=nil, achievement=13470, criteria=45121,}, -- Jawbreaker
--    [23006860] = {quest=55405, npc=151702, item=nil, achievement=13470, criteria=45122,}, -- Paol Pondwader
--    [48704760] = {quest=55367, npc=151884, item=169379, achievement=13470, criteria=45126,}, -- Fungarian Furor
--    [61004120] = {quest=55544, npc=151933, item=169382, achievement=13470, criteria=45136,}, -- Malfunctioning Beastbot
--    [51604160] = {quest=55512, npc=151934, item=168823, achievement=13470, criteria=45124,}, -- Arachnoid Harvester
--    [57002140] = {quest=55538, npc=151940, item=nil, achievement=13470, criteria=45132,}, -- Uncle T'Rogg
--    [65202320] = {quest=55537, npc=152001, item=169392, achievement=13470, criteria=45130,}, -- Bonepicker
--    [43404900] = {quest=55369, npc=152007, item=167931, achievement=13470, criteria=45125,}, -- Killsaw
--    [68905430] = {quest=55858, npc=152113, item=169886, achievement=13470, criteria=45153,}, -- The Kleptoboss
--    [63807800] = {quest=55811, npc=152182, item=168370, achievement=13470, criteria=45135,}, -- Rustfeather
--    [82202100] = {quest=55812, npc=152570, item=169167, achievement=13470, criteria=45137,}, -- Crazed Trogg
--    [57206260] = {quest=55856, npc=152764, item=nil, achievement=13470, criteria=45157,}, -- Oxidized Leachbeast
--    [78203080] = {quest=nil, npc=153000, item=nil, achievement=13470, criteria=45134,}, -- Sparkqueen P'Emp
--    [51205000] = {quest=55857, npc=153200, item=167042, achievement=13470, criteria=45152,}, -- Boilburn
--    [59606730] = {quest=55855, npc=153205, item=nil, achievement=13470, criteria=45146,}, -- Gemicide
--    [56103600] = {quest=55853, npc=153206, item=169691, achievement=13470, criteria=45145,}, -- Ol' Big Tusk
--    [24807720] = {quest=55854, npc=153226, item=168062, achievement=13470, criteria=45154,}, -- Steel Singer Freza
--    [40203960] = {quest=55852, npc=153228, item=167847, achievement=13470, criteria=45155,}, -- Gear Checker Cogstar
--    [53806180] = {quest=56207, npc=154153, item=170467, achievement=13470, criteria=45373,}, -- Enforcer KX-T57
--    [58305690] = {quest=56182, npc=154225, item=nil, achievement=13470, criteria=45374, note="Time displaced",}, -- The Rusty Prince
--    [69205340] = {quest=56367, npc=154701, item=167846, achievement=13470, criteria=45410,}, -- Gorged Gear-Cruncher
--    [66505870] = {quest=56368, npc=154739, item=nil, achievement=13470, criteria=45411,}, -- Caustic Mechaslime
--    [80902020] = {quest=nil, npc=155060, item=nil, achievement=13470, criteria=45433,}, -- Doppel Ganger
--    [81407600] = {quest=56737, npc=155583, item=168490, achievement=13470, criteria=nil,}, -- Scrapclaw
--})
--merge(BFA_HF_Tracker_points[14], { --Arathi
    --World Boss
--    [38804140] = {quest=52848, npc=137374,}, -- The Lion's Roar
--    [38804140] = {quest=52847, npc=138122,}, -- Doom's Howl
	--Mounts
--	[65906790] = {quest=nil, npc=142709, item=163644,}, -- Beastrider Kama
--	[56604450] = {quest=nil, npc=142312, item=163645,}, -- Skullripper
--	[67406120] = {quest=nil, npc=142692, item=163706,}, -- Nimar the Slayer
--	[33003860] = {quest=nil, npc=132074, item=163646,}, -- Overseer Krix
--	[49004000] = {quest=nil, npc=142739, item=163578,note="Spawns when Horde have control?"}, -- Knight-Captain Aldrin
--	[53805820] = {quest=nil, npc=142741, item=163579,note="Spawns when Alliance have control?"}, -- Doomrider Helgrim
	--Toys
--	[47607790] = {quest=nil, npc=132965, item=163775,}, -- Molok the Crusher
--	[28904550] = {quest=nil, npc=142684, item=163750,}, -- Kovork
--	[62808080] = {quest=nil, npc=142682, item=163745,}, -- Zalas Witherbark
--    [48908430] = {quest=nil, npc=135058, item=163744,}, -- Kor'gresh Coldrage
--    [43005700] = {quest=nil, npc=142683, item=163741,}, -- Ruul Onestone
--    [51224018] = {quest=nil, npc=142690, item=163738,}, -- Singer
--    [26703260] = {quest=nil, npc=142725, item=163736,}, -- Horrific Apparition 1
--    [19506090] = {quest=nil, npc=142725, item=163736,}, -- Horrific Apparition 2
--    [23104670] = {quest=nil, npc=142686, item=163735,}, -- Foulbelly
--    [79603030] = {quest=nil, npc=142662, item=163713,}, -- Geomancer Flintdagger
    --Pets
--    [21532120] = {quest=nil, npc=126427, item=163650,}, -- Branchlord Aldrus
--    [36906600] = {quest=nil, npc=142361, item=163690,}, -- Plaguefeather
--    [42006100] = {quest=nil, npc=126462, item=163711,note="Patrols the roads"}, -- Fozruk
--    [56705410] = {quest=nil, npc=142301, item=163648,}, -- Venomarus
--    [18302760] = {quest=nil, npc=142321, item=163689,}, -- Ragebeak
--    [14003690] = {quest=nil, npc=142251, item=163684,}, -- Yogursa
 --   [52207660] = {quest=nil, npc=142716, item=163712,}, -- Man-Hunter Rog
--    [56603600] = {quest=nil, npc=141668, item=163677,}, -- Echo of Myzrael
--    [50653690] = {quest=nil, npc=142688, item=163652,}, -- Darbel Montrose
    --Goliaths
--    [61933150] = {quest=nil, npc=141618, item=163700,}, -- Cresting Goliath
--    [45805280] = {quest=nil, npc=141616, item=163698,}, -- Thundering Goliath
--    [29905960] = {quest=nil, npc=140765, item=163701,}, -- Rumbling Goliath
--    [30604500] = {quest=nil, npc=141615, item=163691,}, -- Burning Goliath
--})

------ Icons DB -------
local planche = "Interface\\Icons\\INV_Sword_05"
local conte = "Interface\\Addons\\HandyNotes\\Icons\\Conte"
local krag = "Interface\\Addons\\HandyNotes\\Icons\\Krag"
local trashpile = "Interface\\Addons\\HandyNotes\\Icons\\Trashpile"
-- MiniMap-DeadArrow = fléche rouge
-- MiniMap-VignetteArrow = fléche grise
-- MiniMap-QuestArrow = fléche jaune
-- None = loupe
-----------------------

local merge = BFA_HF_Tracker_merge

local function nameAchievement(id, i)
    local _, name, _, _, _, _, _, description = GetAchievementInfo(id)
	if i == 1 then
		return name
	elseif i == 2 then
		return description
	end
end
local function nameCriteria(id, criteria)
    local criteria = GetAchievementCriteriaInfoByID(id, criteria)
	return criteria
end

local path = function(achievement, criteria, questid, label, atlas, note, scale)
    label = label or L["Entrance "]
    atlas = atlas or "map-icon-SuramarDoor.tga"
    return {
		achievement = achievement,
        criteria = criteria,
        quest = questid,
        label = label,
        atlas = atlas,
        path = true,
		hf = true,
        scale = scale,
        note = note,
    }
end
BFA_HF_Tracker_path = path

BFA_HF_Tracker_map_spellids = {
    -- [862] = 0, -- Zuldazar
    -- [863] = 0, -- Nazmir
    -- [864] = 0, -- Vol'dun
    -- [895] = 0, -- Tiragarde Sound
    -- [896] = 0, -- Drustvar
    -- [942] = 0, -- Stormsong Valley
}

--[[ structure:
    [uiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            currency=[id], -- currencyid
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
            hide_before=[id], -- hide if quest not completed
			faction=[string], -- Alliance / Horde
        },
    },
]]--

merge(BFA_HF_Tracker_points[862], { -- Zuldazar
	-- HF 12482 - Maléficié, mal au fessier
	[71704128] = {quest=50308, hf=true, atlasHf=trashpile, item=156963, achievement=12482, criteria=40037, requireItem={"bag", 156963}, note=nameAchievement(12482, 2),},	-- Œuf de ravasaure doré
	[66211662] = {quest=50332, hf=true, atlasHf=trashpile, achievement=12482, criteria=40038, note=nameAchievement(12482, 2),},	-- Le chasseur balèze
	[61964689] = {quest=50381, hf=true, atlasHf=trashpile, achievement=12482, criteria=40039, note=nameAchievement(12482, 2),},	-- Le chapeau ou la vie !
	[62632058] = {quest=50331, hf=true, atlasHf=trashpile, item=157794, achievement=12482, criteria=40040, requireItem={"bag", 157794}, note=nameAchievement(12482, 2),},	-- Écaille de vipère à plumes
	-- HF 13029 - Pas les doigts !
	[71252950] = {quest=nil, hf=true, atlas="Banker", npc=124034, npcLine=3, item=163564, achievement=13029, criteria=41580, note=nameAchievement(13029, 2), buy={item=163564, npc=124034,},},
	[64003900] = {quest=nil, hf=true, atlas="Food", npc=130922, npcLine=3, item=163564, achievement=13029, criteria=41580, note=nameAchievement(13029, 2), buy={item=163564, npc=124034, bag="link",}, requireItem={"bag", 163564},},
	-- HF 13036 - Nul n’est censé les ignorer
	[51692825] = {quest=nil, hf=true, atlasHf=conte, achievement=13036, criteria=41566, note= L["Next to the river"],},
	[75506760] = {quest=53536, hf=true, atlasHf=conte, achievement=13036, criteria=41567, note= L["Between the roots"],},
    [48545460] = {quest=nil, hf=true, atlasHf=conte, achievement=13036, criteria=41569, note= L["At the destroyed pillar"]},
    [49004129] = {quest=53541, hf=true, atlasHf=conte, achievement=13036, criteria=41572, note= L["Above, at the pond on the big stone"],},
    [48203980] = path(13036, 41572, 53541, L["Entrance "]..nameCriteria(13036, 41572), _, _, 1.2),
    [43757672] = {quest=53542, hf=true, atlasHf=conte, achievement=13036, criteria=41573, note= L["In the eye of the skeleton, outside"],},
    [47842884] = {quest=nil, hf=true, atlasHf=conte, achievement=13036, criteria=41576, note= L["On the wall, behind the torch"],},        
    [67281762] = {quest=53546, hf=true, atlasHf=conte, achievement=13036, criteria=41577, note= L["Above, to the right of the small staircase"],},
	[59053220] = {quest=53548, hf=true, atlasHf=conte, achievement=13036, criteria=41581, note= L["Behind the NPC in the Corner"],},
})
merge(BFA_HF_Tracker_points[863], { -- Nazmir
	-- HF 12482 - Maléficié, mal au fessier
	[80904680] = {quest=50435, hf=true, atlasHf=trashpile, item=157797, achievement=12482, criteria=40041, requireItem={"bag", 157797}, note=nameAchievement(12482, 2),},	-- Perle vilécaille
	[34007510] = {quest=50437, hf=true, atlasHf=trashpile, item=157801, achievement=12482, criteria=40042, requireItem={"bag", 157801}, note=nameAchievement(12482, 2),},	-- Queue de gueule d’acier
	[68533283] = {quest=50440, hf=true, atlasHf=trashpile, item=157802, achievement=12482, criteria=40043, requireItem={"bag", 157802}, note=nameAchievement(12482, 2),},	-- Relique nazwathani
	[54007410] = {quest=50444, hf=true, atlasHf=trashpile, achievement=12482, criteria=40044, note=nameAchievement(12482, 2),},	-- Sur Loa route
	-- HF 13024 - Gravé dans la pierre en lettres de sang
	[56355736] = {hf=true, atlas="Reagents", achievement=13024, criteria=41860, note= L["Inside a building ruins near the mountain"],},
    [43354811] = {hf=true, atlas="Reagents", achievement=13024, criteria=41861, note= L["Next to broken pillar as you enter the ruins"],},
    [51278510] = {hf=true, atlas="Reagents", achievement=13024, criteria=41862, note= L["Island between Nazmir and Zuldazar zones"],},
    [42555710] = {hf=true, atlas="Reagents", achievement=13024, criteria=42116, note= L["Near Kel'vax Deathwalker rare"],},
	-- HF 13028 - Triste sot
	[69605860] = {label= L["Lost Spawn of Krag'wa 1"], quest=53417, hf=true, atlasHf=krag, achievement=13028, note= L["In an underwater cave"],},
	[65505090] = {label= L["Lost Spawn of Krag'wa 2"], quest=53418, hf=true, atlasHf=krag, achievement=13028, note= L["In an underwater cave"],},	--ok
	[56106490] = {label= L["Lost Spawn of Krag'wa 3"], quest=53419, hf=true, atlasHf=krag, achievement=13028, note= L["Between the huge roots"],},
	[52804290] = {label= L["Lost Spawn of Krag'wa 4"], quest=53420, hf=true, atlasHf=krag, achievement=13028, note= L["Sits in a ruin"],},			--ok
	[34106180] = {label= L["Lost Spawn of Krag'wa 5"], quest=53421, hf=true, atlasHf=krag, achievement=13028, note= L["In cave"],},
	[44609280] = {label= L["Lost Spawn of Krag'wa 6"], quest=53422, hf=true, atlasHf=krag, achievement=13028, note= L["In cave"],},
	[28908320] = {label= L["Lost Spawn of Krag'wa 7"], quest=53423, hf=true, atlasHf=krag, achievement=13028, note= L["In cave"],},
	[24209160] = {label= L["Lost Spawn of Krag'wa 8"], quest=53424, hf=true, atlasHf=krag, achievement=13028, note= L["Sits up between trees"],},
    [21706930] = {label= L["Lost Spawn of Krag'wa 9"], quest=53425, hf=true, atlasHf=krag, achievement=13028, note= L["Sits near the bridge behind the big tree"],},
	[25604060] = {label= L["Lost Spawn of Krag'wa 10"], quest=53426, hf=true, atlasHf=krag, achievement=13028, note= L["Sits behind a curtain of scrub"],},
	-- HF 13029 - Pas les doigts !
	[35405530] = {quest=nil, hf=true, atlas="Banker", npc=126833, npcLine=3, item=163563, achievement=13029, criteria=41575, note=nameAchievement(13029, 2), buy={item=163563, npc=126833, to=L["in cave"],},},
	[32003500] = {quest=nil, hf=true, atlas="Food", npc=143644, item=163563, achievement=13029, criteria=41575, note=nameAchievement(13029, 2), buy={item=163563, npc=126833, bag="link", to=L["in cave"],}, requireItem={"bag", 163563},},
	-- HF 13036 - Nul n’est censé les ignorer
	[39123865] = {quest=53534, hf=true, atlasHf=conte, achievement=13036, criteria=41565, note= L["At the destroyed pillar on the left"],},
    [39575467] = {quest=53537, hf=true, atlasHf=conte, achievement=13036, criteria=41568, note= L["Scroll on the altar"],},
    [58924865] = {quest=53540, hf=true, atlasHf=conte, achievement=13036, criteria=41571, note= L["At the destroyed wall"],},
    [72850760] = {quest=53547, hf=true, atlasHf=conte, achievement=13036, criteria=41579, note= L["Under water, at the bottom, at the destroyed pillar"],},
})
merge(BFA_HF_Tracker_points[864], { -- Vol'dun
	-- HF 12482 - Maléficié, mal au fessier
	[47004655] = {quest=50883, hf=true, atlasHf=trashpile, item=158910, achievement=12482, criteria=40045, requireItem={"bag", 158910}, note=nameAchievement(12482, 2),},	-- Antenne ranishu chargée
	[56241526] = {quest=50890, hf=true, atlasHf=trashpile, item=158915, achievement=12482, criteria=40046, requireItem={"bag", 158915}, note=nameAchievement(12482, 2),},	-- Sabot strié poli
	[49358440] = {quest=50892, hf=true, atlasHf=trashpile, item=158916, achievement=12482, criteria=40047, requireItem={"bag", 158916}, note=nameAchievement(12482, 2),},	-- Mâchoire de rocherouge solide
	[42187208] = {quest=50901, hf=true, atlasHf=trashpile, achievement=12482, criteria=40048, note=nameAchievement(12482, 2),},	-- La surprise sauride
	-- HF 13016 - Pilleur des sables
	[56297011] = {quest=53132, hf=true, item=163321, achievement=13016, criteria=41342,},	-- Lame rouillée de Jason
	[36217838] = {quest=53133, hf=true, item=163322, achievement=13016, criteria=41343,},	-- Bouteille vide de Ian
	[53568981] = {quest=53134, hf=true, item=163323, achievement=13016, criteria=41344,},	-- Assiette ébréchée de Julie
	[37803046] = {quest=53135, hf=true, item=163324, achievement=13016, criteria=41345,},	-- Boussole cassée de Brian
	[26795291] = {quest=53136, hf=true, item=163325, achievement=13016, criteria=41346,},	-- Journal relié d’Ofer
	[29465938] = {quest=53137, hf=true, item=163326, achievement=13016, criteria=41347,},	-- Caillou préféré de Skye
	[52431439] = {quest=53138, hf=true, item=163327, achievement=13016, criteria=41348,},	-- Botte gauche de Julien
	[43217700] = {quest=53139, hf=true, item=163328, achievement=13016, criteria=41349,},	-- Flacon de Navarro
	[47067577] = {quest=53140, hf=true, item=163329, achievement=13016, criteria=41350,},	-- Gourde de Zach
	[45883073] = {quest=53141, hf=true, item=163372, achievement=13016, criteria=41351,},	-- Sac à dos de Damarcus
	[66413595] = {quest=53142, hf=true, item=163373, achievement=13016, criteria=41352,},	-- Flûte de Rachel
	[64873610] = path(13016, 41352, 53142, L["Entrance "]..nameCriteria(13016, 41352), _, _, 1.2),
	[47933673] = {quest=53143, hf=true, item=163374, achievement=13016, criteria=41353,},	-- Croc en collier de Josh
	[45229114] = {quest=53144, hf=true, item=163375, achievement=13016, criteria=41354,},	-- Portrait du commandant Martens
	[62862267] = {quest=53145, hf=true, item=163376, achievement=13016, criteria=41355,},	-- Clé ornée de Kurt
	-- HF 13018 - Chevaucheur des dunes
	[47906249] = {hf=true, atlasHf=planche, label=nameAchievement(13018, 1), achievement=13018, criteria=41360,},
	[32126908] = {hf=true, atlasHf=planche, label=nameAchievement(13018, 1), achievement=13018, criteria=41361,},
	[54902136] = {hf=true, atlasHf=planche, label=nameAchievement(13018, 1), achievement=13018, criteria=41362, note=L["On top of the slither snake"],},
	[54703160] = path(13018, 41362, _, L["Start "]..nameAchievement(13018, 1), _, _, 1.2),
	[42226211] = {achievement=13036, criteria=41564, note= L["In the pond"],},
	[27706212] = {achievement=13036, criteria=41570, note= L["Next to the withered tree"],},
    [49572457] = {achievement=13036, criteria=41574, note= L["Scroll next to the altar, behind the mobs"],},
	[38037097] = {hf=true, atlasHf=planche, label=nameAchievement(13018, 1), achievement=13018, criteria=41363,},
	[45786358] = {hf=true, atlasHf=planche, label=nameAchievement(13018, 1), achievement=13018, criteria=41564, note=L["Along the pyramid edge"],},
	-- HF 13029 - Pas les doigts !
	[40405540] = {quest=nil, hf=true, atlas="Banker", npc=133833, npcLine=3, item=163567, achievement=13029, criteria=41578, note=nameAchievement(13029, 2), buy={item=163567, npc=133833,},},
	[62000900] = {quest=nil, hf=true, atlas="Food", npc=143332, item=163567, achievement=13029, criteria=41578, note=nameAchievement(13029, 2), buy={item=163567, npc=133833, bag="link"}, requireItem={"bag", 163567},},
	-- HF 13036 - Nul n’est censé les ignorer
	[42206206] = {quest=53532, hf=true, atlasHf=conte, achievement=13036, criteria=41564, note=L["In the pond"],},
	[27706205] = {quest=53539, hf=true, atlasHf=conte, achievement=13036, criteria=41570, note=L["Next to the withered tree"],},
	[49592446] = {quest=53543, hf=true, atlasHf=conte, achievement=13036, criteria=41574, note=L["Scroll next to the altar, behind the mobs"],},
})
merge(BFA_HF_Tracker_points[895], { -- Tiragarde Sound
	-- HF 13057 - Les chants de la mer
	[74873655] = {quest=53408, hf=true, atlas="Profession", achievement=13057, criteria=41541, note=L["On the fireplace mantel"].."\n"..nameAchievement(13057, 2),},
	[43502560] = {quest=53410, hf=true, atlas="Profession", achievement=13057, criteria=41542, note=nameAchievement(13057, 2),},
	[70202403] = {quest=53407, hf=true, atlas="Profession", achievement=13057, criteria=41543, note=L["Behind the Jay the Tavern Bard"].."\n"..nameAchievement(13057, 2),},
	[76218305] = {quest=nil, hf=true, atlas="Profession", achievement=13057, criteria=41544, note=nameAchievement(13057, 2),},
	[56676994] = {quest=nil, hf=true, atlas="Profession", npc=132086, npcLine=3, achievement=13057, criteria=41545, note=nameAchievement(13057, 2),},
	[73198415] = {quest=53411, hf=true, atlas="Profession", achievement=13057, criteria=41546, note=nameAchievement(13057, 2),},	-- La fugue du cheval
	-- HF 13061 - Du vent dans les voiles
	[77208425] = {hf=true, atlas="Food", npc=129044, item=163103, achievement=13061, criteria=41397, note=nameAchievement(13061, 2), buy={npc=129044, item=163103, bag="link",},},
	[49802515] = {hf=true, atlas="Food", npc=126601, achievement=13061, criteria={41404, 41406, 41407, 41408, 41412, 41416,}, note=nameAchievement(13061, 2), note2={text=L["You can buy them from : "], npc=126601,}, faction="Alliance",},
	[71413679] = {hf=true, atlas="Food", npc=143487, achievement=13061, criteria={41398, 41402,}, note=nameAchievement(13061, 2), note2={text=L["You can buy them from : "], npc=143487,},},
	[75552325] = {hf=true, atlas="Food", npc=123639, achievement=13061, criteria={41396, 41401,}, note=nameAchievement(13061, 2), note2={text=L["You can buy them from : "], npc=123639,}, faction="Alliance",},
	[74102700] = {hf=true, atlas="Food", npc=142189, achievement=13061, criteria={41397, 41406, 41411, 41414, 41416, 41417,}, note=nameAchievement(13061, 2), note2={text=L["You can buy them from : "], npc=142189,}, faction="Alliance",},
})
merge(BFA_HF_Tracker_points[896], { -- Drustvar
	-- HF 13061 - Du vent dans les voiles
	[21006600] = {hf=true, atlas="Food", npc=139638, achievement=13061, criteria={41400, 41408, 41413, 41414, 41417,}, note=nameAchievement(13061, 2), note2={text=L["You can buy them from : "], npc=139638,},},
	[21504360] = {hf=true, atlas="Food", npc=137040, achievement=13061, criteria={41397, 41399, 41400, 41407, 41408, 41410, 41415, 41417,}, note=nameAchievement(13061, 2), note2={text=L["You can buy them from : "], npc=139638,},},
	-- HF 13064 - Drust sera la chute
	[36806452] = {hf=true, atlas="Reagents", achievement=13064, criteria=41436, note=L["At the bottom of the upper waterfall"],},
    [50777371] = {hf=true, atlas="Reagents", achievement=13064, criteria=41437, note=L["Under the leaning tree"],},
    [37126380] = {achievement=13064, criteria=41436, note= L["At the bottom of the upper waterfall"],},
	[27354833] = {hf=true, atlas="Reagents", achievement=13064, criteria=41438, note=L["Under water"],},
	[59396668] = {hf=true, atlas="Reagents", achievement=13064, criteria=41439, note=L["At the destroyed wall"],},
    [27605760] = {hf=true, atlas="Reagents", achievement=13064, criteria=41441, note=L["Under water at the foot of the small waterfall"],},
    [50144232] = {hf=true, atlas="Reagents", achievement=13064, criteria=41442, note=L["At the destroyed wall"],},
	[19065787] = {hf=true, atlas="Reagents", achievement=13064, criteria=41443, note=L["Behind the scrub"],},
    [46453723] = {hf=true, atlas="Reagents", achievement=13064, criteria=41445, note=L["At the destroyed wall"],},
	[56558583] = {hf=true, atlas="Reagents", achievement=13064, criteria=41446, note=L["On the mountain, a bit difficult to find the way up (see path)"],},
    [62707005] = path(13064, 41446, _, L["Path to The Flayed Man: Start"], "MiniMap-VignetteArrow", _, 1.2),
    [59207210] = path(13064, 41446, _, L["Path to The Flayed Man: Step 1"], "MiniMap-QuestArrow", _, 1.2),
    [58507420] = path(13064, 41446, _, L["Path to The Flayed Man: Step 2"], "MiniMap-QuestArrow", _, 1.2),
    [60307950] = path(13064, 41446, _, L["Path to The Flayed Man: Step 3"], "MiniMap-QuestArrow", _, 1.2),
    [57708100] = path(13064, 41446, _, L["Path to The Flayed Man: Step 4"], "MiniMap-DeadArrow", _, 1.2),
    [56608480] = path(13064, 41446, _, L["Path to The Flayed Man: End, jump down carefully"], "MiniMap-DeadArrow", _, 1.2),
    [44584566] = {hf=true, atlas="Reagents", achievement=13064, criteria=41449, note=L["In a cave, at the very back of the wall"],},
    [46304510] = path(13064, 41449, _, L["Path to Protectors of the Forest: cave entrance"]),
	-- HF 13082 - Du neuf avec du vieux
	[35525187] = {hf=true, item=163749, achievement=13082, criteria=41636, note=L["Near the cliff under the trees west of Arom's Stand flight master."],},
	[64876779] = {hf=true, item=163746, achievement=13082, criteria=41637, note=L["Between the rocks mid level of the waterfall"],},
	[55432714] = {hf=true, item=163748, achievement=13082, criteria=41638, note=L["On the mountain north of Fallhaven in the pile of bones."],},
	[32585891] = {hf=true, item=163747, achievement=13082, criteria=41639, note=L["In the tree trunk from the south side"],},
	[44892743] = {quest=53430, hf=true, label=nameAchievement(13082, 1), achievement=13082, requireItem={"bag", 163746, 163747, 163748, 163749}, note=nameAchievement(13082, 2),},
	[44902743] = {quest=53431, hf=true, label=nameAchievement(13082, 1), achievement=13082, hide_before={53430}, requireItem={"bag", 163746, 163747, 163748}, note=nameAchievement(13082, 2),},
	[44892742] = {quest=53432, hf=true, label=nameAchievement(13082, 1), achievement=13082, hide_before={53430, 53431}, requireItem={"bag", 163747, 163748}, note=nameAchievement(13082, 2),},
	[44882743] = {quest=53433, hf=true, label=nameAchievement(13082, 1), achievement=13082, hide_before={53430, 53431, 53432}, requireItem={"bag", 163748}, note=nameAchievement(13082, 2),},
	-- HF 13087 - Six cent six saucisses
	[55573482] = {hf=true, atlas="Banker", npc=128467, achievement=13087, criteria={41648, 41651, 41652, 41653}, note=nameAchievement(13087, 2), buy=13087,}, -- Saucisse fumée fermière de Comté-de-l’Or + 3
	[26687251] = {hf=true, atlas="Innkeeper", npc=136655, achievement=13087, criteria=41649, note=nameAchievement(13087, 2), buy=130872,}, -- Saucisse de sanglier grillée
	[33001370] = {hf=true, atlas="Banker", label=nameAchievement(13087, 1), achievement=13087, criteria=41650, note=nameAchievement(13087, 2), buy=130873,}, -- Sorcisson malecarde
	-- HF 13094 - La chasse au gibier maudit
	[53872072] = {hf=true, atlas="None", npc=143929, achievement=13094, note=nameAchievement(13094, 2), NPCScan="/npcscan add 143929",}, -- Chèvre
	[32216170] = {hf=true, atlas="None", npc=142278, achievement=13094, note=nameAchievement(13094, 2), NPCScan="/npcscan add 142278",}, -- Griffépines
	[21902260] = {hf=true, atlas="None", npc=143953, achievement=13094, note=nameAchievement(13094, 2), NPCScan="/npcscan add 143953",}, -- Otaries
	[74346589] = {hf=true, atlas="None", npc=143928, achievement=13094, note=nameAchievement(13094, 2), NPCScan="/npcscan add 143928",}, -- Crabes
	[22366947] = {hf=true, atlas="None", npc=143951, achievement=13094, note=nameAchievement(13094, 2), NPCScan="/npcscan add 143951",}, -- Requins
})
merge(BFA_HF_Tracker_points[942], { -- Stormsong Valley
	-- HF 13046 - Les collines de l'appétit
	[58587031] = {hf=true, atlas="Innkeeper", npc=138221, achievement=13046, buy={item=160485, npc=138221, to=L["to Brennadam"],}, requireItem={"bag", 160485},},
	[41256955] = {hf=true, atlas="Food", label=nameAchievement(13046, 1), achievement=13046, note=nameAchievement(13046, 2), buy={item=160485, npc=138221, to=L["to Brennadam"],}, requireItem={"bag", 160485},},
	-- HF 13051 - Légendes des Eaugures
	[49508090] = {hf=true, atlas="poi-workorders", achievement=13051, criteria=41425, note=L["Near the waterfall"],},
	[59025954] = {hf=true, atlas="poi-workorders", achievement=13051, criteria=41426, note=L["On top of the hill"],},
	[31957291] = {hf=true, atlas="poi-workorders", achievement=13051, criteria=41427, note=L["Near the lake"],},
	[33803323] = {hf=true, atlas="poi-workorders", achievement=13051, criteria=41428, note=L["On top of the island"],},
	[56003853] = {hf=true, atlas="poi-workorders", achievement=13051, criteria=41429, note=L["Up the mountain right of Warfang Hold"],},
	[44183660] = {hf=true, atlas="poi-workorders", achievement=13051, criteria=41430, note=L["Up the mountain left of Warfang Hold"],},
	[62083022] = {hf=true, atlas="poi-workorders", achievement=13051, criteria=41431,},
	[75073113] = {hf=true, atlas="poi-workorders", achievement=13051, criteria=41432, note=L["Near the Shrine of the Storm entrance"],},
	-- HF 13061 - Du vent dans les voiles
	[44455420] = {hf=true, atlas="Food", npc=135600, achievement=13061, criteria=41405, note=nameAchievement(13061, 2), buy={item=158927, npc=135600, bag="link",},},
	[49075722] = {hf=true, atlas="Food", achievement=13061, criteria=41409, note=nameAchievement(13061, 2),},
})
merge(BFA_HF_Tracker_points[1161], { -- Boralus
	-- HF 13057 - Les chants de la mer
	[72456933] = {quest=53408, hf=true, atlas="Profession", achievement=13057, criteria=41541, note=L["On the fireplace mantel"].."\n"..nameAchievement(13057, 2),},
	[53141760] = {quest=53407, hf=true, atlas="Profession", achievement=13057, criteria=41543, note=L["Behind the Jay the Tavern Bard"].."\n"..nameAchievement(13057, 2),},
	-- HF 13061 - Du vent dans les voiles
	[47604735] = {hf=true, atlas="Food", npc=137411, achievement=13061, criteria={41396, 41400, 41403, 41406, 41415, 41417}, note=nameAchievement(13061, 2), note2={text=L["You can buy them from : "], npc=137411,},},
	[58157030] = {hf=true, atlas="Food", npc=143487, achievement=13061, criteria={41398, 41402}, note=nameAchievement(13061, 2), note2={text=L["You can buy them from : "], npc=143487,},},
	[75301440] = {hf=true, atlas="Food", npc=123639, achievement=13061, criteria={41396, 41399, 41400, 41401, 41407, 41410, 41417}, note=nameAchievement(13061, 2), note2={text=L["You can buy them from : "], npc=123639,}, faction="Alliance",},
	[69252983] = {hf=true, atlas="Food", npc=142189, achievement=13061, criteria={41397, 41406, 41411, 41414, 41416, 41417}, note=nameAchievement(13061, 2), note2={text=L["You can buy them from : "], npc=142189,}, faction="Alliance",},
}) 
merge(BFA_HF_Tracker_points[1165], { -- Dazar'alor
	-- HF 13036 - Nul n’est censé les ignorer
	[53250930] = {quest=53548, hf=true, atlasHf=conte, achievement=13036, criteria=41581, note= L["Behind the NPC in the Corner"],},
	[53230940] = {achievement=13036, criteria=41581, note= L["Behind the NPC in the Corner"]},
})
