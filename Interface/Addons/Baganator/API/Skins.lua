---@class addonTableBaganator
local addonTable = select(2, ...)

addonTable.Utilities.OnAddonLoaded("Masque", function()
  local Masque = LibStub("Masque", true)
  local masqueGroup = Masque:Group("Baganator", "Bag")

  Baganator.API.Skins.RegisterListener(function(details)
    if details.regionType == "ItemButton" then
      local button = details.region
      if button.masqueApplied then
        masqueGroup:ReSkin(button)
      else
        button.masqueApplied = true
        masqueGroup:AddButton(button, nil, "Item")
      end
    end
  end)
end)

function addonTable.API.IsMasqueApplying()
  if C_AddOns.IsAddOnLoaded("Masque") then
    local Masque = LibStub("Masque", true)
    local masqueGroup = Masque:Group("Baganator", "Bag")
    return not masqueGroup.db.Disabled
  end
  return false
end
