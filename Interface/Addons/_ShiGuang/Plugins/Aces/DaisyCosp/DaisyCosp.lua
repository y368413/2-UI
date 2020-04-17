local DaisyCospdata = LibStub("LibHuanHuaData-1.1")
local DaisyCosp = LibStub("AceAddon-3.0"):NewAddon("DaisyCosp", "AceHook-3.0", "AceEvent-3.0")  
local showHuahuaSet = true

function DaisyCosp:GetSetItemCount(sets)
  local count = 0;
  for i, itemID in ipairs(sets) do
    if (GetItemCount(itemID) > 0) then
      count = count + 1;
    end
  end
  return count, #sets;
end

local function CreateHuanHuaInfo(tooltip, itemID)
    local iType, subType, setName, setsdata = DaisyCospdata:FindItem(itemID);
    if (iType) then
      local curCount, totalCount = DaisyCosp:GetSetItemCount(setsdata);
      tooltip:AddLine("["..TRANSMOGRIFY.."]" .. setName .. (" (%d/%d)"):format(curCount, totalCount), 0.97, 0.51, 0.97);
      for i, id in ipairs(setsdata) do
        local name = GetItemInfo(id);
        if (GetItemCount(id) > 0) then
          tooltip:AddLine(name, 1, 1, 1);
        else
          tooltip:AddLine(name, 0.62, 0.62, 0.62);
        end
      end
      tooltip:AddLine(SPLASH_LEGION_NEW_7_2_FEATURE2_TITLE .. iType .. "-" .. subType, 0.9, 0.9, 0.9);
      --tooltip:AddLine("\nCtrl + Shift +鼠标左键可查看套装效果", 0, 0.6, 0.8);
    end
end

--[[function DaisyCosp:DressUpItemLink(link) 
  if IsShiftKeyDown() then
    local itemID = string.match(link, "item:(%d+)");
    local iType, subType, setName, setsdata = DaisyCospdata:FindItem(itemID);
    if (not iType) then return; end
    local model = DressUpModel; --DressUpFrame.ModelScene:GetPlayerActor()
    if ( SideDressUpFrame.parentFrame and SideDressUpFrame.parentFrame:IsShown() ) then
      model = SideDressUpModel;
    end
    model:Undress();
    for _, id in ipairs(setsdata) do
      if (IsDressableItem(id)) then
        model:TryOn(id);
      end
    end
  end
end

function DaisyCosp:OnEnable() 
  self:SecureHook("DressUpItemLink");
end]]

GameTooltip:HookScript("OnTooltipSetItem", function(tooltip, ...)
	local item = select(2, tooltip:GetItem())
	if (not item) then return; end  -- or (not GetItemInfo(item)) 
	local itemID = string.match(item, "item:(%d+)")
	if itemID and showHuahuaSet then
		CreateHuanHuaInfo(tooltip, itemID)
	end
end)