---@class addonTableBaganator
local addonTable = select(2, ...)
-- Refresh bags so that searches for #locked reflect the new unlocked status of
-- a particular lockbox
local events = {
  "UNIT_SPELLCAST_START",
  "UNIT_SPELLCAST_FAILED",
  "UNIT_SPELLCAST_INTERRUPTED",
  "UNIT_SPELLCAST_STOP",
}
local frame = CreateFrame("Frame")

local timer
local counter = 0

frame:SetScript("OnEvent", function(self, eventName)
  if eventName == "UNIT_SPELLCAST_START" then
    counter = counter + 1
  elseif eventName == "UNIT_SPELLCAST_INTERRUPTED" then
    counter = counter - 1
  elseif eventName == "UNIT_SPELLCAST_STOP" then
    counter = counter - 1
    C_Timer.After(0.5, function()
      Baganator.API.RequestItemButtonsRefresh()
    end)
  end
  if counter == 0 then
    frame:UnregisterAllEvents()
    timer:Cancel()
    timer = nil
  end
end)

addonTable.CallbackRegistry:RegisterCallback("ItemSpellTargeted", function(_, itemID)
  for _, e in ipairs(events) do
    frame:RegisterUnitEvent(e, "player")
  end
  if timer then
    timer:Cancel()
  end
  timer = C_Timer.NewTimer(15, function()
    frame:UnregisterAllEvents()
  end)
end)
