--------------------------------------------------------------------------------
-- 感谢原作者 盒子哥
-- Fix and Updata by 冰色之舞、图图 、ShiGuang
--------------------------------------------------------------------------------
local LibHuanHuaData, oldminor = LibStub:NewLibrary("LibHuanHuaData-1.1", 1.02) --20190528
local FindItemCache = {}
setmetatable(FindItemCache, {__mode = "kv"})

local function tableFind(t, value)
	for i, id in pairs(t) do
		if (id == tonumber(value)) then
			return id;
		end
	end
	return false;
end

function LibHuanHuaData:FindItem(itemID)
	if FindItemCache[itemID] then
		if FindItemCache[itemID] == 'nil' then
			return nil
		else
			local iType, subType, setName = string.match(FindItemCache[itemID], "(.+)|(.+)|(.+)");
			local tmpInfo = HuanhuaItemData[iType][subType][setName];
			return iType, subType, setName, tmpInfo;
		end
	else
		local itemName, itemLink, itemQuality = GetItemInfo(itemID);
		if not itemQuality then return nil; end
		if (itemQuality < 2 or itemQuality>5) then
			FindItemCache[itemID] = 'nil';
			return nil;
		end		

		local iType, subType, setName;
		for t in pairs(HuanhuaItemData) do
			for tt, b in pairs(HuanhuaItemData[t]) do
				for name, ids in pairs(b) do
					local retVal = tableFind(ids, itemID);
					if (retVal) then
						iType, subType, setName = t, tt, name;
					end
				end
			end
		end
		if iType then
			FindItemCache[itemID] = string.format("%s|%s|%s", iType, subType, setName);
			local tmpInfo = HuanhuaItemData[iType][subType][setName];
			return iType, subType, setName, tmpInfo;
		else
			FindItemCache[itemID] = "nil";
			return nil;
		end
	end
end