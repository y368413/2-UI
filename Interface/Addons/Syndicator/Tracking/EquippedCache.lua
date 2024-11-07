SyndicatorEquippedCacheMixin = {}

-- Assumed to run after PLAYER_LOGIN
function SyndicatorEquippedCacheMixin:OnLoad()
  self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

  self.currentCharacter = Syndicator.Utilities.GetCharacterFullName()

  self:ScanEquipped()
end

local function GetSlotInfo(slot)
  local location = {equipmentSlotIndex = slot}
  if not C_Item.DoesItemExist(location) then
    return {}
  end

  return {
    itemID = GetInventoryItemID("player", slot),
    itemCount = GetInventoryItemCount("player", slot),
    iconTexture = GetInventoryItemTexture("player", slot),
    itemLink = GetInventoryItemLink("player", slot),
    quality = GetInventoryItemQuality("player", slot),
    isBound = C_Item.IsBound(location),
  }
end

function SyndicatorEquippedCacheMixin:OnEvent(eventName, ...)
  if eventName == "PLAYER_EQUIPMENT_CHANGED" then
    local slot = ...
    -- Ignore bags
    if slot >= C_Container.ContainerIDToInventoryID(1) then
      return
    end

    local storedOffset = slot + Syndicator.Constants.EquippedInventorySlotOffset

    local equipped = SYNDICATOR_DATA.Characters[self.currentCharacter].equipped

    equipped[storedOffset] = {}

    local itemID = GetInventoryItemID("player", slot)
    if itemID ~= nil then
      if C_Item.IsItemDataCachedByID(itemID) then
        equipped[storedOffset] = GetSlotInfo(slot)
      else
        Syndicator.Utilities.LoadItemData(itemID, function()
          equipped[storedOffset] = GetSlotInfo(slot)
        end)
      end
    end

    Syndicator.CallbackRegistry:TriggerEvent("EquippedCacheUpdate", self.currentCharacter)
  end
end

function SyndicatorEquippedCacheMixin:ScanEquipped()
  local start = debugprofilestop()

  local equipped = {}

  local function Finish()
    if Syndicator.Config.Get(Syndicator.Config.Options.DEBUG_TIMERS) then
      print("equipped finish", debugprofilestop() - start)
    end
    SYNDICATOR_DATA.Characters[self.currentCharacter].equipped = equipped
    Syndicator.CallbackRegistry:TriggerEvent("EquippedCacheUpdate", self.currentCharacter)
  end

  local waiting, loopComplete = C_Container.ContainerIDToInventoryID(1), false

  local function DoSlot(slot, storedOffset, expectedItemID)
    equipped[storedOffset] = GetSlotInfo(slot)

    if loopComplete and waiting == 0 then
      Finish()
    end
  end

  local anyStored = false

  for slot = 0, C_Container.ContainerIDToInventoryID(1) - 1 do
    local storedOffset = slot + Syndicator.Constants.EquippedInventorySlotOffset
    equipped[storedOffset] = {}

    local itemID = GetInventoryItemID("player", slot)
    if itemID ~= nil then
      if C_Item.IsItemDataCachedByID(itemID) then
        waiting = waiting - 1
        DoSlot(slot, storedOffset, itemID)
      else
        if C_Item.GetItemInfoInstant(itemID) ~= nil then
          Syndicator.Utilities.LoadItemData(itemID, function()
            waiting = waiting - 1
            DoSlot(slot, storedOffset, itemID)
          end)
        else
          waiting = waiting - 1
        end
      end
    else
      waiting = waiting - 1
    end
  end

  loopComplete = true

  if waiting == 0 then
    Finish()
  end
end
