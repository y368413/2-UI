-- 全局变量
EXTMERCHANT = {
    ItemsPerSubpage = MERCHANT_ITEMS_PER_PAGE, -- 此处为10，表示左右两个页面为10。每个子页面的物品数量
}

-- 覆盖原本商人界面显示物品数量的默认值。
-- HACK 这里会造成全局变量的污染。
MERCHANT_ITEMS_PER_PAGE = 20;

--========================================
-- 初始化加载例程
--========================================
function ExtMerchant_OnLoad(self)
    -- 将商人框体重建成扩展设计
    ExtMerchant_RebuildMerchantFrame()
    -- 重新排列上一页/下一页按钮的位置
    ExtMerchant_RebuildPageButtonPositions()
    -- 重新排列回购按钮的位置
    ExtMerchant_RebuildBuyBackItemPositions()
    -- 重新排列货币的位置
    ExtMerchant_RebuildTokenPositions()
    -- 重新排列出售所有垃圾按钮的位置
    hooksecurefunc("MerchantFrame_UpdateRepairButtons", ExtMerchant_RebuildSellAllJunkButtonPositions)
    -- 重新排列公会修理的位置
    ExtMerchant_RebuildGuildBankRepairButtonPositions()

    -- 商品页面钩子函数
    -- 上下翻页的时候也会触发
    -- 拾取物品(非金币)也会触发
    hooksecurefunc("MerchantFrame_UpdateMerchantInfo", ExtMerchant_UpdateSlotPositions)

    -- 回购页面钩子函数
    -- 回购页面的触发相对商品页面较为稳定，只有进入回购才触发。
    hooksecurefunc("MerchantFrame_UpdateBuybackInfo", ExtMerchant_UpdateBuyBackSlotPositions)
end

--========================================
-- 将商人框体重建成扩展设计
--========================================
function ExtMerchant_RebuildMerchantFrame()
    -- 设置新的框体宽度
    MerchantFrame:SetWidth(696)

    -- 创建新的物品槽
    for i = 1, MERCHANT_ITEMS_PER_PAGE, 1 do
        if (not _G["MerchantItem" .. i]) then
            CreateFrame("Frame", "MerchantItem" .. i, MerchantFrame, "MerchantItemTemplate")
        end
    end
end

--========================================
-- 重新排列商品物品槽的位置。
--========================================
function ExtMerchant_UpdateSlotPositions()
    local vertSpacing= -16 -- 垂直间距
    local horizSpacing = 12 -- 水平间距
    local buy_slot -- 临时变量

    -- 遍历物品槽，调整物品槽的锚点和位置。
    for i = 1, MERCHANT_ITEMS_PER_PAGE, 1 do
        buy_slot = _G["MerchantItem" .. i]
        -- 在暴雪原生UI中，MerchantItem11和MerchantItem12被隐藏了。需要主动显示全部物品槽。
        buy_slot:Show()

        if ((i % EXTMERCHANT.ItemsPerSubpage) == 1) then
            if (i == 1) then
                -- 确定物品槽1的位置
                buy_slot:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 24, -70)
            else
                -- 第二排
                buy_slot:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - (EXTMERCHANT.ItemsPerSubpage - 1))], "TOPRIGHT", 12, 0)
            end
        else
            if ((i % 2) == 1) then
                -- 单数按钮，不包含物品槽1
                buy_slot:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 2)], "BOTTOMLEFT", 0, vertSpacing)
            else
                -- 双数按钮
                buy_slot:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 1)], "TOPRIGHT", horizSpacing, 0)
            end
        end
    end

    -- 显示下一页/上一页按钮。
    local numMerchantItems = securecall("GetMerchantNumItems");
    if ( numMerchantItems <= MERCHANT_ITEMS_PER_PAGE ) then
        MerchantPageText:Show();
        MerchantPrevPageButton:Show();
        MerchantPrevPageButton:Disable();
        MerchantNextPageButton:Show();
        MerchantNextPageButton:Disable();
    end
end

--========================================
-- 重新排列回购物品槽的位置。
--========================================
function ExtMerchant_UpdateBuyBackSlotPositions()
    -- 回购垂直间距为-30，水平间距为50，单位：像素
    local vertSpacing= -30 -- 垂直间距
    local horizSpacing = 50 -- 水平间距
    local buyback_slot -- 临时变量

    -- 遍历回购物品槽，调整回购物品槽的锚点和位置。
    for i = 1, MERCHANT_ITEMS_PER_PAGE, 1 do
        buyback_slot = _G["MerchantItem" .. i]

        -- BUYBACK_ITEMS_PER_PAGE 默认为12
        if (i > BUYBACK_ITEMS_PER_PAGE) then
            buyback_slot:Hide(); -- 隐藏多余的物品栏
        else
            -- 回购槽1
            if (i == 1) then
                buyback_slot:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 64, -105);
            else
                -- 下一排
                if ((i % 3) == 1) then
                    buyback_slot:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 3)], "BOTTOMLEFT", 0, vertSpacing);
                else
                    buyback_slot:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 1)], "TOPRIGHT", horizSpacing, 0);
                end
            end
        end
    end
end

--========================================
-- 重新排列货币的位置
--========================================
function ExtMerchant_RebuildTokenPositions()
    MerchantMoneyBg:SetPoint("TOPRIGHT", MerchantFrame, "BOTTOMRIGHT", -8, 25);
    MerchantMoneyBg:SetPoint("BOTTOMLEFT", MerchantFrame, "BOTTOMRIGHT",-169, 6);
    MerchantExtraCurrencyInset:ClearAllPoints();
    MerchantExtraCurrencyInset:SetPoint("TOPLEFT", MerchantMoneyInset, "TOPLEFT", -171, 0);
    MerchantExtraCurrencyInset:SetPoint("BOTTOMRIGHT", MerchantMoneyInset, "BOTTOMLEFT", 0, 0);
    MerchantExtraCurrencyBg:ClearAllPoints();
    MerchantExtraCurrencyBg:SetPoint("TOPLEFT", MerchantMoneyBg, "TOPLEFT", -171, 0);
    MerchantExtraCurrencyBg:SetPoint("BOTTOMRIGHT", MerchantMoneyBg, "BOTTOMLEFT", -3, 0);

    local currencies = { GetMerchantCurrencies() };
    MerchantFrame.numCurrencies = #currencies;
    for index = 1, MerchantFrame.numCurrencies do
        local tokenButton = _G["MerchantToken"..index];
        tokenButton:ClearAllPoints();
        -- token display order is: 6 5 4 | 3 2 1
        if ( index == 1 ) then
            tokenButton:SetPoint("BOTTOMRIGHT", -16, 8);
        elseif ( index == 4 ) then
            tokenButton:SetPoint("RIGHT", _G["MerchantToken"..index - 1], "LEFT", -15, 0);
        else
            tokenButton:SetPoint("RIGHT", _G["MerchantToken"..index - 1], "LEFT", 0, 0);
        end
    end
end

--========================================
-- 重新排列出售所有垃圾按钮的位置
--========================================
function ExtMerchant_RebuildSellAllJunkButtonPositions()
    if ( not securecall("CanMerchantRepair") ) then
        MerchantSellAllJunkButton:SetPoint("RIGHT", MerchantBuyBackItem, "LEFT", -18, 0);
    end
end

--========================================
-- 重新排列公会修理的位置
--========================================
function ExtMerchant_RebuildGuildBankRepairButtonPositions()
    MerchantGuildBankRepairButton:SetPoint("LEFT", MerchantRepairAllButton, "RIGHT", 10, 0);
end

--========================================
-- 重新排列回购按钮的位置
--========================================
function ExtMerchant_RebuildBuyBackItemPositions()
    MerchantBuyBackItem:SetPoint("TOPLEFT", MerchantItem10, "BOTTOMLEFT", 17, -20);
end

--========================================
-- 重新排列上一页/下一页按钮的位置
--========================================
function ExtMerchant_RebuildPageButtonPositions()
    MerchantPrevPageButton:SetPoint("CENTER", MerchantFrame, "BOTTOM", 36, 55);
    MerchantPageText:SetPoint("BOTTOM", MerchantFrame, "BOTTOM", 166, 50);
    MerchantNextPageButton:SetPoint("CENTER", MerchantFrame, "BOTTOM", 296, 55);
end
