--## Author: cc27
local function CreateButton(name, label, func, point, relativeTo, relativePoint, offsetX, offsetY)
    local button = CreateFrame("Button", name, UIParent, "UIPanelButtonTemplate")
    button:SetSize(70, 50)
    button:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY)

    local buttonText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    buttonText:SetPoint("CENTER")
    buttonText:SetText(label)
    buttonText:SetJustifyH("CENTER")
    buttonText:SetJustifyV("MIDDLE")

    button:SetMovable(true)
    button:EnableMouse(true)
    button:RegisterForDrag("LeftButton")
    button:SetScript("OnDragStart", function(self)
        if IsShiftKeyDown() then
            self:StartMoving()
        end
    end)
    button:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    button:SetScript("OnClick", func)

    button:Hide() 
    return button
end

local function GetLocalizedText()
    local locale = GetLocale()
    if locale == "zhCN" then
        return "安全", "警报", "【%s】有%d个敌人！", "【%s】安全。"
    elseif locale == "zhTW" then
        return "安全", "警報", "【%s】有%d個敵人！", "【%s】安全。"
    elseif locale == "esES" then
        return "A salvo", "Alerta", "¡[%s] Hay %d enemigos!", "[%s] está a salvo."
    elseif locale == "esMX" then
        return "A salvo", "Alerta", "¡[%s] Hay %d enemigos!", "[%s] está a salvo."
    elseif locale == "deDE" then
        return "Sicher", "Alarm", "[%s] Es gibt %d Feinde!", "[%s] ist sicher."
    elseif locale == "frFR" then
        return "Sauf", "Alerte", "Il y a %d ennemis à [%s] !", "[%s] est sauf."
    elseif locale == "ptBR" then
        return "A salvo", "Alerta", "[%s] Há %d inimigos!", "[%s] está a salvo."
    elseif locale == "itIT" then
        return "Al sicuro", "Allarme", "Ci sono %d nemici a [%s]!", "[%s] è al sicuro."
    elseif locale == "koKR" then
        return "안전", "경고", "[%s]에 %d명의 적이 있습니다!", "[%s]은(는) 안전합니다."
    elseif locale == "ruRU" then
        return "Безопасно", "Тревога", "[%s] здесь %d врагов!", "[%s] безопасно."
    elseif locale == "enUS" then
        return "Safe", "Alert", "[%s] There are %d enemies!", "[%s] is safe."
    else
        return "Safe", "Alert", "[%s] There are %d enemies!", "[%s] is safe."
    end
end


local safeText, alertText, alertMessageFormat, safeMessageFormat = GetLocalizedText()

local enemyCount, lastPressTime, alertDelay = 0, 0, 5
local function BattlefieldAlert()
    local currentTime = GetTime()
    if currentTime - lastPressTime > alertDelay then
        enemyCount = 0
    end
    enemyCount = enemyCount + 1
    lastPressTime = currentTime
    local playerSubZone = GetSubZoneText() or "Unknown Location"
    SendChatMessage(format(alertMessageFormat, playerSubZone, enemyCount), "INSTANCE_CHAT")
end

local function BattlefieldSafe()
    local playerSubZone = GetSubZoneText() or "Unknown Location"
    SendChatMessage(format(safeMessageFormat, playerSubZone), "INSTANCE_CHAT")
end

local forceShowButtons = false

local safeButton = CreateButton("SafeButton", safeText, BattlefieldSafe, "CENTER", UIParent, "CENTER", 300, -150)
local alertButton = CreateButton("AlertButton", alertText, BattlefieldAlert, "CENTER", UIParent, "CENTER", 370, -150)

local function UpdateButtonVisibility()
    if C_PvP.IsBattleground() or forceShowButtons then
        safeButton:Show()
        alertButton:Show()
    else
        safeButton:Hide()
        alertButton:Hide()
    end
end

SLASH_SIMPLEBA1 = '/SimpleBA'
SlashCmdList["SIMPLEBA"] = function(msg)
    if msg == "show" then
        forceShowButtons = true
        UpdateButtonVisibility()
    end
end

local Masque = LibStub("Masque", true)
if Masque then
    local groupAlert = Masque:Group("BattlefieldButtons", "Alert")
    local groupSafe = Masque:Group("BattlefieldButtons", "Safe")
    groupAlert:AddButton(alertButton)
    groupSafe:AddButton(safeButton)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA") 
frame:SetScript("OnEvent", function(self, event, ...)
    UpdateButtonVisibility()
end)
