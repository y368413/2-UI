-- ## Author: null  ## Version: 0.0.1
-- 资料片版本文本  1-9  
local _expacText = {
  '经典旧世(或未分类)',
	'燃烧的远征(2)',
	'巫妖王之怒(3)',
	'大地的裂变(4)',
	'熊猫人之谜(5)',
	'德拉诺之王(6)',
	'军团再临(7)',
	'争霸艾泽拉斯(8)',
	'暗影国度(9)'
}

-- 输出资料片文本
local function setExpacText(tooltip,expacID,frameType,itemType,itemSubType)
  local expacText = "nil"
  local itemTypeText = "nil"
  local itemSubTypeText = "nil"
  
  if (expacID ~= nil) then 
  	expacText = _expacText[expacID+1]
  end
  
  if (itemType ~= nil) then
    itemTypeText = itemType 
  end
  
  if (itemSubType ~= nil) then  
  	itemSubTypeText = itemSubType
  end
  	
  local headerText = expacText.."/"..itemTypeText.."/"..itemSubTypeText;  --"\n"..expacText[expacID+1].."→"..itemType.."→"..itemSubType
  tooltip:AddLine(headerText);
end;


-- 信息窗体处理
local TooltipItem = function(self, ...)    	
	local frameType = self:GetName();
	-- print(frameType);
	local _, itemLink = self:GetItem();
	
	if(itemLink) then
		local itemID = GetItemInfoFromHyperlink(itemLink);		
		if(itemID) then
			local _, _, itemQuality, itemLevel, _, itemType, itemSubType, _, itemEquipLoc, _, _, _, _, _, expacID = GetItemInfo(itemID);
			-- expacID 0-8 						  			                  
			setExpacText(self,expacID,frameType,itemType,itemSubType);			
		end;
	end;
end

--  循环取得信息窗体
--  这里有一定的问题
for _, obj in next, {
	GameTooltip,       --物品信息窗体
	ShoppingTooltip1,  --物品对比窗体1
	ShoppingTooltip2,  --物品对比窗体2	
	ItemRefTooltip     --聊天框物品引用窗体
	--  ItemRefShoppingTooltip1,
	--  ItemRefShoppingTooltip2
  } do
	  obj:HookScript('OnTooltipSetItem', TooltipItem)
end