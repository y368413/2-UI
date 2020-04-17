local MAJOR, MINOR = "LibItemUpgradeInfo-1.0", 30
local type,tonumber,select,strsplit,GetItemInfoFromHyperlink=type,tonumber,select,strsplit,GetItemInfoFromHyperlink
local unpack,GetDetailedItemLevelInfo=unpack,GetDetailedItemLevelInfo
local library,previous = _G.LibStub:NewLibrary(MAJOR, MINOR)
local lib=library --#lib Needed to keep Eclipse LDT happy
if not lib then return end
local pp=print
local print=function() end
-- ItemLink Constants
local i_Name=1
local i_Link=2
local i_Rarity=3
local i_Quality=3
local i_Level=4
local i_MinLevel =5
local i_ClassName=6
local i_SubClassName=7
local i_StackCount=8
local i_EquipLoc=9
local i_TextureId=10
local i_SellPrice=11
local i_ClassID=12
local i_SubClass_ID=13
local i_unk1=14
local i_unk2=15
local i_unk3=16
local i_unk4=17


do
local oGetItemInfo=GetItemInfo
lib.itemcache=lib.itemcache or
	setmetatable({miss=0,tot=0},{
		__index=function(table,key)
			if (not key) then return "" end
			if (key=="miss") then return 0 end
			if (key=="tot") then return 0 end
			local cached={oGetItemInfo(key)}
			if #cached==0 then return nil end
			local itemLink=cached[2]
			if not itemLink then return nil end
			local itemID=lib:GetItemID(itemLink)
			local quality=cached[3]
			local cacheIt=true
			if quality==LE_ITEM_QUALITY_ARTIFACT then 
				local relic1, relic2, relic3 = select(4,strsplit(':', itemLink))
				if relic1 and relic1 ~= '' and not oGetItemInfo(relic1) then cacheIt = false end
				if relic2 and relic2 ~= '' and not oGetItemInfo(relic2) then cacheIt = false end
				if relic3 and relic3 ~= '' and not oGetItemInfo(relic3) then cacheIt = false end
			end
			cached.englishClass=GetItemClassInfo(cached[12])
			cached.englishSubClass=GetItemSubClassInfo(cached[12],cached[13])
			if cacheIt then
				rawset(table,key,cached)
			end
			table.miss=table.miss+1
			return cached
		end

	})
end
local cache=lib.itemcache
local	function CachedGetItemInfo(key,index)
	if not key then return nil end
	index=index or 1
	cache.tot=cache.tot+1
	local cached=cache[key]
	if cached and type(cached)=='table' then
		return select(index,unpack(cached))
	else
		rawset(cache,key,nil) -- voiding broken cache entry
	end
end

local upgradeTable = {
	[  1] = { upgrade = 1, max = 1, ilevel = 8 },
	[373] = { upgrade = 1, max = 3, ilevel = 4 },
	[374] = { upgrade = 2, max = 3, ilevel = 8 },
	[375] = { upgrade = 1, max = 3, ilevel = 4 },
	[376] = { upgrade = 2, max = 3, ilevel = 4 },
	[377] = { upgrade = 3, max = 3, ilevel = 4 },
	[378] = {                       ilevel = 7 },
	[379] = { upgrade = 1, max = 2, ilevel = 4 },
	[380] = { upgrade = 2, max = 2, ilevel = 4 },
	[445] = { upgrade = 0, max = 2, ilevel = 0 },
	[446] = { upgrade = 1, max = 2, ilevel = 4 },
	[447] = { upgrade = 2, max = 2, ilevel = 8 },
	[451] = { upgrade = 0, max = 1, ilevel = 0 },
	[452] = { upgrade = 1, max = 1, ilevel = 8 },
	[453] = { upgrade = 0, max = 2, ilevel = 0 },
	[454] = { upgrade = 1, max = 2, ilevel = 4 },
	[455] = { upgrade = 2, max = 2, ilevel = 8 },
	[456] = { upgrade = 0, max = 1, ilevel = 0 },
	[457] = { upgrade = 1, max = 1, ilevel = 8 },
	[458] = { upgrade = 0, max = 4, ilevel = 0 },
	[459] = { upgrade = 1, max = 4, ilevel = 4 },
	[460] = { upgrade = 2, max = 4, ilevel = 8 },
	[461] = { upgrade = 3, max = 4, ilevel = 12 },
	[462] = { upgrade = 4, max = 4, ilevel = 16 },
	[465] = { upgrade = 0, max = 2, ilevel = 0 },
	[466] = { upgrade = 1, max = 2, ilevel = 4 },
	[467] = { upgrade = 2, max = 2, ilevel = 8 },
	[468] = { upgrade = 0, max = 4, ilevel = 0 },
	[469] = { upgrade = 1, max = 4, ilevel = 4 },
	[470] = { upgrade = 2, max = 4, ilevel = 8 },
	[471] = { upgrade = 3, max = 4, ilevel = 12 },
	[472] = { upgrade = 4, max = 4, ilevel = 16 },
	[491] = { upgrade = 0, max = 4, ilevel = 0 },
	[492] = { upgrade = 1, max = 4, ilevel = 4 },
	[493] = { upgrade = 2, max = 4, ilevel = 8 },
	[494] = { upgrade = 0, max = 6, ilevel = 0 },
	[495] = { upgrade = 1, max = 6, ilevel = 4 },
	[496] = { upgrade = 2, max = 6, ilevel = 8 },
	[497] = { upgrade = 3, max = 6, ilevel = 12 },
	[498] = { upgrade = 4, max = 6, ilevel = 16 },
	[503] = { upgrade = 3, max = 3, ilevel = 1 },
	[504] = { upgrade = 3, max = 4, ilevel = 12 },
	[505] = { upgrade = 4, max = 4, ilevel = 16 },
	[506] = { upgrade = 5, max = 6, ilevel = 20 },
	[507] = { upgrade = 6, max = 6, ilevel = 24 },
	[529] = { upgrade = 0, max = 2, ilevel = 0 },
	[530] = { upgrade = 1, max = 2, ilevel = 5 },
	[531] = { upgrade = 2, max = 2, ilevel = 10 },
	[535] = { upgrade = 1, max = 3, ilevel = 15 },
	[536] = { upgrade = 2, max = 3, ilevel = 30 },
	[537] = { upgrade = 3, max = 3, ilevel = 45 },
	[538] = { upgrade = 0, max = 3, ilevel = 0 },

}
do
	local stub = { ilevel = 0 }
	setmetatable(upgradeTable, { __index = function(t, key)
		return stub
	end})
end
-- Tooltip Scanning stuff
local itemLevelPattern = _G.ITEM_LEVEL:gsub("%%d", "(%%d+)")
local soulboundPattern = _G.ITEM_SOULBOUND
local boePattern=_G.ITEM_BIND_ON_EQUIP
local bopPattern=_G.ITEM_BIND_ON_PICKUP
local boaPattern1=_G.ITEM_BIND_TO_BNETACCOUNT
local boaPattern2=_G.ITEM_BNETACCOUNTBOUND
local patterns={
  [soulboundPattern]="soulbound",
  [boePattern]="boe",
  [bopPattern]="bop",
  [boaPattern1]="boa",
  [boaPattern2]="boa",
}

local scanningTooltip
local anchor
lib.tipCache = lib.tipCache or setmetatable({},{__index=function(table,key) return {} end})
local tipCache = lib.tipCache
local emptytable={}

local function ScanTip(itemLink,itemLevel,show)
	if type(itemLink)=="number" then
		itemLink=CachedGetItemInfo(itemLink,2)
		if not itemLink then return emptytable end
	end
	if type(tipCache[itemLink].ilevel)=="nil"then -- or not tipCache[itemLink].cached then
		local cacheIt=true
		if not scanningTooltip then
			anchor=CreateFrame("Frame")
			anchor:Hide()
			scanningTooltip = _G.CreateFrame("GameTooltip", "LibItemUpgradeInfoTooltip", nil, "GameTooltipTemplate")
		end
		--scanningTooltip:ClearLines()
		GameTooltip_SetDefaultAnchor(scanningTooltip,anchor)
		local itemString=itemLink:match("|H(.-)|h")
		local rc,message=pcall(scanningTooltip.SetHyperlink,scanningTooltip,itemString)
		if (not rc) then
			return emptytable
		end
		scanningTooltip:Show()
		local quality,_,_,class,subclass,_,_,_,_,classIndex,subclassIndex=CachedGetItemInfo(itemLink,3)
		
		-- line 1 is the item name
		-- line 2 may be the item level, or it may be a modifier like "Heroic"
		-- check up to line 6 just in case
		local ilevel,soulbound,bop,boe,boa,heirloom
		if quality==LE_ITEM_QUALITY_ARTIFACT and itemLevel then 
			local relic1, relic2, relic3 = select(4,strsplit(':', itemLink))
			if relic1 and relic1 ~= '' and not CachedGetItemInfo(relic1) then cacheIt = false end
			if relic2 and relic2 ~= '' and not CachedGetItemInfo(relic2) then cacheIt = false end
			if relic3 and relic3 ~= '' and not CachedGetItemInfo(relic3) then cacheIt = false end
			ilevel=itemLevel 
		end
		if show then
			for i=1,12 do
				local l, ltext = _G["LibItemUpgradeInfoTooltipTextLeft"..i], nil		
				local r, rtext  = _G["LibItemUpgradeInfoTooltipTextRight"..i], nil
				if l then
  				ltext=l:GetText()
  				rtext=r:GetText()
  				_G.print(i,ltext,' - ',rtext)
				end		
			end
		end
    tipCache[itemLink]={
      ilevel=nil,
      soulbound=nil,
      bop=nil,
      boe=nil,
      boa=nil,
      cached=cacheIt
    }
    local c=tipCache[itemLink]
		for i = 2, 6 do
			local label, text = _G["LibItemUpgradeInfoTooltipTextLeft"..i], nil
			if label then text=label:GetText() end
			if text then
        if show then _G.print("|cFFFFFF00".. text .. "|r") end
				if c.ilevel==nil then c.ilevel = tonumber(text:match(itemLevelPattern)) end
				for pattern,key in pairs(patterns) do
          if type(c[key])=="nil" then
            if text:find(pattern) then
              if show then _G.print(text , "matched",pattern) end
 				      c[key]=true
            end
          end
        end
			end
		end
		c.ilevel=c.ilevel or itemLevel
		itemLevel=GetDetailedItemLevelInfo(itemLink)
		if type(c.ilevel)=="number" then
		  c.ilevel=math.max(c.ilevel,itemLevel)
		else
		  c.ilevel=itemLevel
	  end
		
		scanningTooltip:Hide()
	end
	return tipCache[itemLink]
end


-- GetUpgradeID(itemString)
--
-- Arguments:
--   itemString - String - An itemLink or itemString denoting the item
--
-- Returns:
--   Number - The upgrade ID (possibly 0), or nil if the input is invalid or
--            does not contain upgrade info
function lib:GetUpgradeID(itemString)
	if type(itemString)~="string" then return end
	local itemString = itemString:match("item[%-?%d:]+") or ""-- Standardize itemlink to itemstring
	local instaid, _, numBonuses, affixes = select(12, strsplit(":", itemString, 15))
	instaid=tonumber(instaid) or 7
	numBonuses=tonumber(numBonuses) or 0
	if instaid >0 and (instaid-4)%8==0 then
		return tonumber((select(numBonuses + 1, strsplit(":", affixes))))
	end
end

-- GetCurrentUpgrade(id)
--
-- Returns the current upgrade level of the item, e.g. 1 for a 1/2 item.
--
-- Arguments:
--   id - Number - The upgrade ID of the item (obtained via GetUpgradeID())
--
-- Returns:
--   Number - The current upgrade level of the item. Returns nil if the item
--            cannot be upgraded
function lib:GetCurrentUpgrade(id)
	return upgradeTable[id].upgrade
end

-- GetMaximumUpgrade(id)
--
-- Returns the maximum upgrade level of the item, e.g. 2 for a 1/2 item.
--
-- Arguments:
--   id - Number - The upgrade ID of the item (obtained via GetUpgradeID())
--
-- Returns:
--   Number - The maximum upgrade level of the item. Returns nil if the item
--            cannot be upgraded
function lib:GetMaximumUpgrade(id)
	return upgradeTable[id].max
end

-- GetItemLevelUpgrade(id)
--
-- Returns the item level increase that this upgrade is worth, e.g. 4 for a
-- 1/2 item or 8 for a 2/2 item.
--
-- Arguments:
--   id - Number - The upgrade ID of the item (obtained via GetUpgradeID())
--
-- Returns:
--   Number - The item level increase of the item. Returns 0 if the item
--            cannot be or has not been upgraded
function lib:GetItemLevelUpgrade(id)
	return upgradeTable[id].ilevel
end

-- GetItemUpgradeInfo(itemString)
--
-- Returns the current upgrade level, maximum upgrade level, and item level
-- increase for an item.
--
-- Arguments:
--   itemString - String - An itemLink or itemString denoting the item
--
-- Returns if the item can be upgraded:
--   Number - The current upgrade level of the item
--   Number - The maximum upgrade level of the item
--   Number - The item level increase of the item
-- or if the item cannot be upgraded:
--   nil
--   nil
--   0
-- or if the item is invalid or does not contain upgrade info:
--   nil
function lib:GetItemUpgradeInfo(itemString)
	local id = self:GetUpgradeID(itemString)
	if id then
		local cur = self:GetCurrentUpgrade(id)
		local max = self:GetMaximumUpgrade(id)
		local delta = self:GetItemLevelUpgrade(id)
		return cur, max, delta
	end
	return nil
end

-- GetHeirloomTrueLevel(itemString)
--
-- Returns the true item level for an heirloom (actually, returns the true level for any adapting item)
--
-- Arguments:
--   itemString - String - An itemLink or itemString denoting the item
--
-- Returns:
--   Number, Boolean - The true item level of the item. If the item is not
--                     an heirloom, or an error occurs when trying to scan the
--                     item tooltip, the second return value is false. Otherwise
--                     the second return value is true. If the input is invalid,
--                     (nil, false) is returned.
-- Convert the ITEM_LEVEL constant into a pattern for our use
function lib:GetHeirloomTrueLevel(itemString)
	if type(itemString) ~= "string" then return nil,false end
	local _, itemLink, rarity, itemLevel = CachedGetItemInfo(itemString)
	if (not itemLink) then
		return nil,false
	end
	local rc=ScanTip(itemLink,itemLevel)
	if rc.ilevel then
		return rc.ilevel,true
	end
	return itemLevel, false
end

-- GetUpgradedItemLevel(itemString)
--
-- Returns the true item level of the item, including upgrades and heirlooms.
--
-- Arguments:
--   itemString - String - An itemLink or itemString denoting the item
--
-- Returns:
--   Number - The true item level of the item, or nil if the input is invalid
function lib:GetUpgradedItemLevel(itemString)
	-- check for heirlooms first
	local ilvl, isTrue = self:GetHeirloomTrueLevel(itemString)
	if isTrue then
		return ilvl
	end
	-- not an heirloom? fall back to the regular item logic
	local id = self:GetUpgradeID(itemString)
	if ilvl and id then
		ilvl = ilvl + self:GetItemLevelUpgrade(id)
	end
	return ilvl
end

-- IsBop(itemString)
--
-- Check an item for  Bind On Pickup.
--
-- Arguments:
--   itemString - String - An itemLink or itemString denoting the item
--
-- Returns:
--   Boolean - True if Bind On Pickup

function lib:IsBop(itemString)
	local rc=ScanTip(itemString)
	return rc.bop
end
-- IsBoe(itemString)
--
-- Check an item for  Bind On Equip.
--
-- Arguments:
--   itemString - String - An itemLink or itemString denoting the item
--
-- Returns:
--   Boolean - True if Bind On Equip

function lib:IsBoe(itemString)
	local rc=ScanTip(itemString)
	return rc.boe
end
-- IsBoa(itemString)
--
-- Check an item for  Bind On Aaccount
--
-- Arguments:
--   itemString - String - An itemLink or itemString denoting the item
--
-- Returns:
--   Boolean - True if Bind On Equip

function lib:IsBoa(itemString)
	local rc=ScanTip(itemString)
	return rc.boa
end

-- IsArtifact(itemString)
--
-- Check an item for  Heirloom
--
-- Arguments:
--   itemString - String - An itemLink or itemString denoting the item
--
-- Returns:
--   Boolean - True if Artifact

function lib:IsArtifact(itemString)
	return CachedGetItemInfo(itemString,i_Quality)==LE_ITEM_QUALITY_ARTIFACT
end

function lib:GetClassInfo(itemString)
	local rc=ScantTip(itemString)
	return rc.class,rc.subclass
end



function lib:IsHeirloom(itemString)
	return CachedGetItemInfo(itemString,i_Quality) ==LE_ITEM_QUALITY_HEIRLOOM
end

function lib:GetItemID(itemlink)
	if (type(itemlink)=="string") then
			local itemid,context=GetItemInfoFromHyperlink(itemlink)
			return tonumber(itemid) or 0
			--return tonumber(itemlink:match("Hitem:(%d+):")) or 0
	else
			return 0
	end
end


--@do-not-package--
local slots={
INVSLOT_AMMO    = INVSLOT_AMMO,
INVSLOT_HEAD    = INVSLOT_HEAD,
INVSLOT_NECK    = INVSLOT_NECK,
INVSLOT_SHOULDER  = INVSLOT_SHOULDER,
INVSLOT_BODY    = INVSLOT_BODY,
INVSLOT_CHEST   = INVSLOT_CHEST,
INVSLOT_WAIST   = INVSLOT_WAIST,
INVSLOT_LEGS    = INVSLOT_LEGS,
INVSLOT_FEET    = INVSLOT_FEET,
INVSLOT_WRIST   = INVSLOT_WRIST,
INVSLOT_HAND    = INVSLOT_HAND,
INVSLOT_FINGER1 = INVSLOT_FINGER1,
INVSLOT_FINGER2 = INVSLOT_FINGER2,
INVSLOT_TRINKET1  = INVSLOT_TRINKET1,
INVSLOT_TRINKET2  = INVSLOT_TRINKET2,
INVSLOT_BACK    = INVSLOT_BACK,
INVSLOT_MAINHAND  = INVSLOT_MAINHAND,
INVSLOT_OFFHAND = INVSLOT_OFFHAND,
INVSLOT_RANGED    = INVSLOT_RANGED,
INVSLOT_TABARD    = INVSLOT_TABARD,
}
local INVSLOT_FIRST_EQUIPPED = INVSLOT_FIRST_EQUIPPED;
local INVSLOT_LAST_EQUIPPED = INVSLOT_LAST_EQUIPPED
_G.SLASH_CHECKSLOT1="/checkslot"
SlashCmdList['CHECKSLOT'] = function(args,chatframe)
  _G.print(args)
  local slot=strsplit(' ',args)
  if not slot or slot=="" then
    DevTools_Dump(slots)
    return
  end
  slot=tonumber(slot)
  local itemlink=GetInventoryItemLink("player",slot)
  if itemlink then
    for k,v in pairs(slots) do
      if slot==v then _G.print("Item in " , k) break end
    end
    _G.print(itemlink)
    DevTools_Dump({GetDetailedItemLevelInfo(itemlink)})
    print(itemlink)
    _G.print(lib:ScanTip(itemlink))
  end
end
function lib:ScanTip(itemLink)
  --self.itemcache[itemLink]=nil
  self.tipCache[itemLink]=nil
	local GameTooltip=_G.LibItemUpgradeInfoTooltip
	if GameTooltip then
		GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
		GameTooltip:SetHyperlink(itemLink)
		GameTooltip:Show()
	end
	return ScanTip(itemLink,100,true)
end
function lib:GetCachingGetItemInfo()
	return CachedGetItemInfo
end
function lib:GetCacheStats()
	local c=lib.itemcache
	local h=c.tot-c.miss
	local perc=( h>0) and h/c.tot*100 or 0
	return c.miss,h,perc
end
function lib:GetCache()
	return lib.itemcache
end
function lib:CleanCache()
	return wipe(lib.itemcache)
end