-- 符号 ●○◆◇◼◻△▽

-- 资料片版本文本  0-9 自行增加改名
local _expacText = {[0]='经典旧世(或未分类)',[1]='燃烧的远征',[2]='巫妖王之怒',[3]='大地的裂变',[4]='熊猫人之谜',[5]='德拉诺之王',[6]='军团再临',[7]='争霸艾泽拉斯',[8]='暗影国度',[9]='巨龙时代',[10]='地心之战'}
-- 配色方案，没有你喜欢的颜色？自己想选一个合适的值 ff ffffff
local _expacColor = {[0]='ffffff66',[1]='ffccef66',[2]='ffccdf66',[3]='ffcccf66',[4]='ffccbf66',[5]='ffccaf66',[6]='ffcc9f66',[7]='ffcc8f66',[8]='ffcc7f66',[9]='ffcc6f66',[10]='ffccff66'}
-- 在ItemBtn上写个字 ，空值表示没有字
local _expacNumber={[0]='①',[1]='②',[2]='③',[3]='④',[4]='⑤',[5]='⑥',[6]='⑦',[7]='⑧',[8]='⑨',[9]='⑩',[10]='#'}    
local _Unknow_Text ='Expansion'
local _Unknow_Color = 'ffff0000'
-- -- GetServerExpansionLevel() 取得当前服务的版本等级号，例如，巨龙时代，这个值就是9 
-- -- 但是 这个方法并不会第一时间返回有效值，故下面这行被注释掉
-- local _SrvExp=GetServerExpansionLevel()


--  AAA 文本配色
local function _colortext(color,text)
  return '|c'..color..text..'|r'
end
-- ------------------------------------------------------------------------------------------
-- -- 以下是一些其它尝试，但是和资料片信息无关，仅供参考
-- local _TooltipDataTypes={}
-- for _K,_V in pairs(Enum.TooltipDataType)  do
--   _TooltipDataTypes[_V]=_K
-- end

-- local _ict = {}
-- for _K,_V in pairs(Enum.ItemCreationContext) do
--   _ict[_V]=_K
-- end

-- local function Debug_TooltipInfo(tooltip, data)
--   -- 测试，输出鼠标信息窗体名称
--   local _type = data.type
--   local _typestr = _TooltipDataTypes[_type]
--   local _name1 =  tooltip:GetName()
--   tooltip:AddLine('○ '.._name1..'→'.._typestr..' ('.._type..')')
-- end

-- local function Debug_ItemSource(tooltip,link)
--   local _t = {strsplit(":",link)}
--   local _ictid = tonumber(_t[13])
--   if _ictid == 14 then
--     tooltip:AddLine('○ 商人出售')
--   end
-- end

-- local function Debug_ItemSource2(tooltip,id)  
--   local item = Item:CreateFromItemID(id)
--   item:ContinueOnItemLoad(function()
--     local link = item:GetItemLink()    
--     Debug_ItemSource(tooltip,link)
--   end)    
-- end

-- local function Spell_Info(tooltip)
--   local _spell=tooltip:GetSpell()
--   if (_spell) then        
--     local _name, _rank, _icon, _castTime, _minRange, _maxRange, _spellID, _originalIcon=GetSpellInfo(_spell)
--     if (_spellID) then
--     -- print(_spell,_spellID)
--       tooltip:AddLine('◇ [ '.._colortext('ffff00ff',_spellID)..' ]')  
--     end  
--   end  
-- end

-- ---------------------------------------------------------------------------------------

-- BBB 输出物品分类信息
local function Item_Type_SubType_Info(tooltip,itemType,itemSubType)
  if (itemType) and (itemSubType) then
    local _info=''            
    if (itemType == '商业技能') then  
      _info='◇ '.._colortext('ff00ff00',itemType)..'→'..itemSubType
    elseif (itemType == '护甲') or (itemType == '武器') then
      _info='◇ '.._colortext('ff77ffff',itemType)..'→'..itemSubType
    elseif (itemType == '消耗品') then
      _info='◇ '.._colortext('ffff7777',itemType)..'→'..itemSubType
    elseif (itemType == '任务') then
      _info='◇ '.._colortext('ffff9999',itemType)..'→'..itemSubType          
    else
      _info='◇ '..itemType..'→'..itemSubType
    end
    tooltip:AddLine(_info)
  end
end

-- CCC 输出资料片版本信息
local function Item_Expansons_Info(tooltip,expacID,itemType,itemSubType)
  if (expacID) then          
    local _number = tonumber(expacID)    
    local _text=''
    if (expacID > #_expacText) then
      _text=_colortext(_Unknow_Color,_Unknow_Text)            
    else
      _text=_colortext(_expacColor[_number],_expacText[_number])   
    end                                                                                                                             
    --tooltip:AddLine('|n● '.._text..' '..'['..(_number+1)..']')
    tooltip:AddLine(_text..' '.._expacNumber[_number])  --'|n● '..
    --        
    -- 如果不需要，请用 '--'注释掉下面这行                               
    --Item_Type_SubType_Info(tooltip,itemType,itemSubType)  -- 调用 BBB 输出额外的物品分类信息
    -- Debug_ItemSource(tooltip,link)
  end
end

-- DDD 取得 物品ID 调用 CCC 继续处理
local function Item_Info(tooltip)
  local _,link=tooltip:GetItem()
  if (link) then                    
    local id = string.match(link, "item:(%d*)")
    if (id) then        
      local _, _, _, _, _, itemType, itemSubType, _, _, _, _, _, _, _, expacID = GetItemInfo(id)
      Item_Expansons_Info(tooltip,expacID,itemType,itemSubType) -- 调用 CCC
    end
  end
end

-- EEE  分析 tooltip信息，类型匹配时调用 DDD 继续处理
local function OnTooltipSetItem(tooltip, data)                
  -- ShoppingTooltip1,ShoppingTooltip2异常，暂时未处理  
  if (tooltip == GameTooltip) or (tooltip == ItemRefTooltip) then
    if (data.type==0) then        
      Item_Info(tooltip)  -- 调用 DDD
    end
    -- if (data.type==1) then
    --   Spell_Info(tooltip)      
    -- end    
  end
  -- Debug_TooltipInfo(tooltip, data)
end

-- 起点, 注册方法或事件，触发时调用 EEE
TooltipDataProcessor.AddTooltipPostCall(TooltipDataProcessor.AllTypes, OnTooltipSetItem)
--TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, OnTooltipSetItem)
-- 全部的Tooltip类型
-- /dump Enum.TooltipDataType

----------------------------------------------------------------------------------------------------------
-- 以下是在类似ItemLevel TinyInspect显示物品等级功能的显示物品版本号功能
-- 参考了TinyInspect中的ItemLevel.Lua

-- FFF 初始化或设置 覆盖层Frame(指ItemExpansionsFrame)
local function GetItemExpansionsFrame(self)
  if (not self.ItemExpansionsFrame) then
        -- 不存在则构建一个ItemExpansionsFrame
        local anchor, w, h = self.IconBorder or self, self:GetSize()
        local ww, hh = anchor:GetSize()
        if (ww == 0 or hh == 0) then
            anchor = self.Icon or self.icon or self
            w, h = anchor:GetSize()
        else
            w, h = min(w, ww), min(h, hh)
        end
        self.ItemExpansionsFrame = CreateFrame("Frame", nil, self)
        self.ItemExpansionsFrame:SetScale(max(0.75, h<32 and h/32 or 1))
        self.ItemExpansionsFrame:SetFrameLevel(53)
        self.ItemExpansionsFrame:SetSize(w, h)
        self.ItemExpansionsFrame:SetPoint("CENTER", anchor, "CENTER", 0, 0)
        -- 构建ItemExpansionsFrame.expansionsString
        self.ItemExpansionsFrame.expansionsString = self.ItemExpansionsFrame:CreateFontString(nil, "OVERLAY")
        self.ItemExpansionsFrame.expansionsString:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
        self.ItemExpansionsFrame.expansionsString:SetPoint("TOPRIGHT",6,4)
        --self.ItemExpansionsFrame.expansionsString:SetTextColor(1, 0.82, 0.5)
    end
        self.ItemExpansionsFrame:Show() --显示
    return self.ItemExpansionsFrame
end

-- GGG 分析数据 调用方法 FFF 设置覆盖层Frame 
local function OnSetItemExpansions(self, quality, itemIDOrLink, suppressOverlays, isBound)

    if (self.ItemLevelCategory) then return end --这句啥意思？？？
    
    local frame = GetItemExpansionsFrame(self) -- 调用方法 FFF 取得覆盖层
    if (itemIDOrLink) then
        -- -- itemIDOrLink不为nil时设置覆盖层信息
        
        -- -- itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType,itemStackCount,  -- 1-8 
        -- -- itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType,expacID, setID, isCraftingReagent  -- 9 -17 
        -- -- = GetItemInfo(item)
        -- --  itemType = classID , itemSubType = subclassID
        local _, _, _, _, _, itemType, itemSubType, _, _, _, _, _classID, _subclassID, _, expacID = GetItemInfo(itemIDOrLink)
        if (expacID) then
          local _number=tonumber(expacID)
          --if (_SrvExp ~=_number ) then -- 如果服务器的版本号和expacID不等，则显示，否则不显示，注释掉的原因见开头
              frame.expansionsString:SetText(_colortext(_expacColor[_number],_expacNumber[_number]))
          --end
        end  
        -- -- 这里可以用Api GetDetailedItemLevelInfo取得物品等级值effectiveILvl，然后类似TinyInspect那样显示出来
        -- local effectiveILvl, isPreview, baseILvl = GetDetailedItemLevelInfo(itemIDOrLink)
        -- -- effectiveILvl值就是装备的等级
        -- -- _classID 2 武器 4 护甲 ，饰品戒指副手算护甲分类
        -- -- if ( _classID == 2) or ( _classID == 4) then
        -- -- 写上装备的装等，这里或许应该写到另一个子Frame里   
        -- frame.expansionsString:SetText(_colortext(_expacColor[_number],effectiveILvl..(expacID+1)))
        -- -- end    
    else
        frame:Hide(); -- itemIDOrLink为nil时隐藏frame 
    end
end
-- 起点 注册方法或事件 ，触发时调用 方法 GGG 分析数据 
hooksecurefunc("SetItemButtonQuality", OnSetItemExpansions)
