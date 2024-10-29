-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local _, Core = ...

-------------------------------------------------------------------------------
----------------------------------- TOOLTIP -----------------------------------
-------------------------------------------------------------------------------

local function ItemStatus(itemID, numNeed, note, spacer)
    local txt
    local numHave = C_Item.GetItemCount(itemID, true)
    local status = format('%d/%s', numHave, numNeed)
    if type(numNeed) == 'number' and numHave >= numNeed then
        txt = Core.status.Green(status)
    else
        txt = Core.status.Red(status)
    end
    if note then txt = txt .. ' ' .. note end
    if spacer == nil or spacer == true then txt = '\n\n' .. txt end
    return txt
end

local function QuestStatus(questID, identifier, note, spacer)
    local txt = '\n'
    if C_QuestLog.IsQuestFlaggedCompleted(questID) then
        txt = txt .. Core.status.Green(identifier)
    else
        txt = txt .. Core.status.Red(identifier)
    end
    if note then txt = txt .. ' ' .. note end
    if spacer then txt = txt .. '\n' end -- adds a blank line after the status text
    return txt
end

local function ReputationGain(value, factionID)
    local factionName = Core.api.GetFactionInfoByID(factionID)

    return Core.status.LightBlue('+' .. value .. ' ' .. factionName)
end

local function RenderPinTooltip(pin)
    local x, _ = pin:GetCenter()
    local parentX, _ = pin:GetParent():GetCenter()
    if (x > parentX) then
        GameTooltip:SetOwner(pin, 'ANCHOR_LEFT')
    else
        GameTooltip:SetOwner(pin, 'ANCHOR_RIGHT')
    end

    Core.PrepareLinks(pin.label)
    Core.PrepareLinks(pin.note)

    C_Timer.After(0, function()
        -- label
        GameTooltip:SetText(Core.RenderLinks(pin.label, true))

        -- note
        if pin.note and Core:GetOpt('show_notes') then
            GameTooltip:AddLine(Core.RenderLinks(pin.note), 1, 1, 1, true)
        end

        GameTooltip:Show()
    end)
end

Core.tooltip = {
    ItemStatus = ItemStatus,
    QuestStatus = QuestStatus,
    ReputationGain = ReputationGain,
    RenderPinTooltip = RenderPinTooltip
}
