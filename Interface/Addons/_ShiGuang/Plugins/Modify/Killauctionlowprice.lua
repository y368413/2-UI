--## Version: 1.0   ## Notes:秒杀低于物品实际拍卖价的物品，专治拍卖行脚本。   ## Author: BG
do
    local e = CreateFrame("Frame")

    function e:Init()
        self.limit_rate = 0.1 * 0.01
        self.buy_button = self.buy_button or self:CreateBuyButton()
        self.can_buy_lowest = self.can_buy_lowest or false
    end
    
    --COMMODITY_SEARCH_RESULTS_UPDATED, COMMODITY_PRICE_UPDATED
    function e:ON_EVENT(event,...)
        if event == "COMMODITY_SEARCH_RESULTS_UPDATED" then
            local itemID = ...
            self.itemID = itemID
            if not self:IsSelling() then return nil end
            local lowest_item = C_AuctionHouse.GetCommoditySearchResultInfo(itemID, 1)
            if lowest_item then self.lowest_item = lowest_item else self.lowest_item = nil end
            self:BuyButtonShow()
            local start = self:GetIgnoreStart(itemID)
            if not start or (start == 1) then return nil end
            local start_result = C_AuctionHouse.GetCommoditySearchResultInfo(itemID, start)
            AuctionHouseFrame.CommoditiesSellFrame:GetCommoditiesSellList():SetSelectedEntry(start_result);
        elseif event == "COMMODITY_PRICE_UPDATED" then
            local updatedUnitPrice, updatedTotalPrice = ...
            if not self:IsSelling() then return nil end
            self.can_buy_lowest = false
            if self.lowest_item and updatedUnitPrice == self.lowest_item.unitPrice and updatedTotalPrice == self.lowest_item.unitPrice then
                self.can_buy_lowest = true
            end
        elseif event == "AUCTION_HOUSE_THROTTLED_SYSTEM_READY" then
            if self.buy_itemID then
                e:ConfirmBuy(self.buy_itemID)
                self.buy_itemID = nil
            end
        end
    end
    
    e:RegisterEvent("COMMODITY_SEARCH_RESULTS_UPDATED")
    e:RegisterEvent("COMMODITY_PRICE_UPDATED")
    e:RegisterEvent("AUCTION_HOUSE_THROTTLED_SYSTEM_READY")
    e:SetScript("OnEvent", e.ON_EVENT)
    
    function e:IsSelling()
        local sell_tab = AuctionHouseFrameSellTabMiddleDisabled
        if sell_tab and sell_tab:IsShown() then return true else return false end
    end
    
    function e:GetIgnoreStart(itemID)
        if not itemID then return end
        local total = 0
        local results = {}
        for i = 1, C_AuctionHouse.GetNumCommoditySearchResults(itemID) do
            local result = C_AuctionHouse.GetCommoditySearchResultInfo(itemID, i)
            results[i] = result
            total = total + result.quantity
        end
        local limit = self.limit_rate * total
        local count = 0
        for i, result in ipairs(results) do
            count = count + result.quantity
            if count >= limit then return i end
        end
    end
    
    function e:ConfirmBuy(itemID)
        if self.can_buy_lowest then
            C_AuctionHouse.ConfirmCommoditiesPurchase(itemID,1)
            self:PrintBuyResult(true)
        else
            self:PrintBuyResult(false)
        end
    end
    
    function e:PrintBuyResult(succeed)
        if not self.lowest_item then return nil end
        local itemName = GetItemInfo(self.lowest_item.itemID)
        local price_string = GetCoinTextureString(self.lowest_item.unitPrice)
        if not (itemName and price_string) then return nil end
        if succeed then
            print(itemName.."购买成功1件：" .. price_string)
        else
            print(itemName.."购买失败，价格变化")
        end
    end
    
    function e:BuyOneItem(itemID)
        if not itemID then return nil end
        C_AuctionHouse.StartCommoditiesPurchase(itemID,1)
        self.buy_itemID = itemID
        --C_Timer.After(.5, function() e:ConfirmBuy(itemID) end)
    end
    
    function e:CreateBuyButton()
        local buy_button = CreateFrame("Button", "WA_AuctionLowPrice_BuyOne_Button", UIParent, "UIPanelButtonTemplate")
        buy_button:SetSize(150, 32)
        buy_button:SetText("最低价秒一个")
        buy_button:SetScript("OnClick", function() if e.lowest_item then e:BuyOneItem(e.lowest_item.itemID) end end)
        buy_button:SetFrameStrata("TOOLTIP")
        return buy_button
    end
    
    function e:BuyButtonShow()
        local refresh = AuctionHouseFrame.CommoditiesSellList.RefreshFrame
        if not refresh then return nil end
        self.buy_button:SetPoint("RIGHT", refresh, "LEFT")
        self.buy_button:SetParent(refresh)
        self.buy_button:Show()
    end
    
    e:Init()
end
