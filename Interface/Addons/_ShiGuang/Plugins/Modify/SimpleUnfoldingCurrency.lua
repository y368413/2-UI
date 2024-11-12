--## Author: cc27
local SimpleUnfoldingCurrency = CreateFrame("Frame")
local isCurrencyExpanded = true


local function ExpandAllCurrenciesRecursively(index)
    local currencyInfo = C_CurrencyInfo.GetCurrencyListInfo(index)
    if currencyInfo and currencyInfo.isHeader and not currencyInfo.isHeaderExpanded then
        C_CurrencyInfo.ExpandCurrencyList(index, true)
        local size = C_CurrencyInfo.GetCurrencyListSize()
        for i = index + 1, size do
            ExpandAllCurrenciesRecursively(i)
        end
    end
end


local function ExpandAllCurrencies()
    local size = C_CurrencyInfo.GetCurrencyListSize()
    for i = 1, size do
        ExpandAllCurrenciesRecursively(i)
    end
end


local function CollapseAllCurrencies()
    for i = 1, C_CurrencyInfo.GetCurrencyListSize() do
        C_CurrencyInfo.ExpandCurrencyList(i, false)
    end
end


local function OnEvent(self, event)
    if event == "PLAYER_LOGIN" and isCurrencyExpanded then
        for j = 1, 3 do
            C_Timer.After((j - 1) * 0.1, ExpandAllCurrencies)
        end
    end
end

SimpleUnfoldingCurrency:RegisterEvent("PLAYER_LOGIN")
SimpleUnfoldingCurrency:SetScript("OnEvent", OnEvent)

SLASH_SIMPLECURRENCY1 = "/SimpleCurrency"
function SlashCmdList.SIMPLECURRENCY(msg)
    local command = msg:lower()
    if command == "on" then
        isCurrencyExpanded = true
        for j = 1, 3 do
            C_Timer.After((j - 1) * 0.1, ExpandAllCurrencies)
        end
    elseif command == "off" then
        isCurrencyExpanded = false
        CollapseAllCurrencies()
    end
end
