--[[
AtlasLootReverse
Written by pceric
http://www.wowinterface.com/downloads/info9179-Know-It-All.html
]]
local AtlasLootReverse = LibStub("AceAddon-3.0"):NewAddon("AtlasLootReverse") -- , "AceConsole-3.0")

-- searches a table for string s
local function tfind(t, s)
    local last
    for k, v in pairs(t) do
        if type(v) == "table" then
            tfind(v, s)
        else
            if v == s then
                tmp = last
            end
            last = v
        end
    end 
end

function AtlasLootReverse:OnInitialize()
    --AtlasLootReverseDBx 由开发人员生成, 事先存在db.lua里
    db = AtlasLootReverseDBx or {}
    db.sources = db.sources or {}
    db.whoTable = db.whoTable or {}
    AtlasLootReverseDBx = db
    local OnTooltipSetItem = function(...) return AtlasLootReverse:OnTooltipSetItem(...) end
    for _, tip in next, { 'GameTooltip', 'ItemRefTooltip', 'ShoppingTooltip1', 'ShoppingTooltip2', 'ShoppingTooltip3', 'AtlasLootTooltipTEMP' } do
        local f = _G[tip]
        if f then
            if f:GetScript('OnTooltipSetItem') then
            	return f:HookScript('OnTooltipSetItem',OnTooltipSetItem)
            else
            	return f:SetScript('OnTooltipSetItem',OnTooltipSetItem)
            end   
        end
    end
end

function AtlasLootReverse:OnTooltipSetItem(tooltip, item)
    item = item or select(2, tooltip:GetItem());
    if type(item)=="string" then
        local _, itemId = strsplit(":", item)
        local from = db.whoTable[tonumber(itemId)]
        if from then
            for id in string.gmatch(from, "[^,]+") do
                local v = db.sources[tonumber(id)]
                if not string.find(v, 'Tier ') and not string.find(v, 'Tabards') and not string.find(v, 'PvP ') then
                    v = FROM .. v
                end
                tooltip:AddLine(v, 0, 0.6, 0.8)
            end
        end
    end
end
