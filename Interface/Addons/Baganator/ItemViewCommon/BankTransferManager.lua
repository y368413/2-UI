---@class addonTableBaganator
local addonTable = select(2, ...)

addonTable.BankTransferManagerMixin = {}

function addonTable.BankTransferManagerMixin:OnLoad()
  if not C_Bank then
    return
  end
  self.allocatedSlots = {}
  self.queue = {}
end

local function GetMatching(depositFlags, item)
  local class, subClass, _, xpac, _, isReagent = select(12, C_Item.GetItemInfo(item.itemID))
  local expansionFlags = {
    [Enum.BagSlotFlags.ExpansionCurrent] = xpac and xpac == LE_EXPANSION_LEVEL_CURRENT or false,
    [Enum.BagSlotFlags.ExpansionLegacy] = xpac and xpac ~= LE_EXPANSION_LEVEL_CURRENT or false,
  }
  for flag, state in pairs(expansionFlags) do
    if FlagsUtil.IsSet(depositFlags, flag) then
      if not state then
        return false
      end
    end
  end

  local typeFlags = {
    [Enum.BagSlotFlags.ClassEquipment] = class == Enum.ItemClass.Armor or class == Enum.ItemClass.Weapon,
    [Enum.BagSlotFlags.ClassConsumables] = class == Enum.ItemClass.Consumable,
    [Enum.BagSlotFlags.ClassProfessionGoods] = (class == Enum.ItemClass.Tradegoods or class == Enum.ItemClass.Container or class == Enum.ItemClass.Profession or class == Enum.ItemClass.Gem) and not isReagent,
    [Enum.BagSlotFlags.ClassReagents] = isReagent or false,
    [Enum.BagSlotFlags.ClassJunk] = item.quality == 0,
  }
  local typesSet = false
  for flag, state in pairs(typeFlags) do
    if FlagsUtil.IsSet(depositFlags, flag) then
      typesSet = true
      if state then
        return true
      end
    end
  end
  return not typesSet and depositFlags ~= 0 and depositFlags ~= Enum.BagSlotFlags.DisableAutoSort
end

function addonTable.BankTransferManagerMixin:Queue(bagID, slotID)
  if not C_Bank or not BankPanel:IsShown() then
    return
  end
  ClearCursor()

  local location = {bagID = bagID, slotIndex = slotID}
  if not C_Item.DoesItemExist(location) or C_Item.IsLocked(location) then
    return
  end

  local bagIndex = tIndexOf(Syndicator.Constants.AllBagIndexes, bagID)
  local source = Syndicator.Search.GetBaseInfo(Syndicator.API.GetCharacter(Syndicator.API.GetCurrentCharacter()).bags[bagIndex][slotID])

  if not source.itemID then
    return
  end

  local tabData, indexes
  local bankFrame = addonTable.ViewManagement.GetBankFrame()
  if bankFrame.Character:IsVisible() then
    tabData = Syndicator.API.GetCharacter(Syndicator.API.GetCurrentCharacter()).bankTabs
    indexes = Syndicator.Constants.AllBankIndexes
  elseif bankFrame.Warband:IsVisible() then
    tabData = Syndicator.API.GetWarband(1).bank
    indexes = Syndicator.Constants.AllWarbandIndexes
  else
    error("Unknown bank type")
  end

  local stackLimit = C_Item.GetItemMaxStackSizeByID(source.itemID)
  local match

  local function CheckTargets(targets)
    for index, item in ipairs(targets) do
      if (self.allocatedSlots[item.bagID] == nil or not self.allocatedSlots[item.bagID][item.slotID]) and (
        item.itemID == nil or (item.itemID == source.itemID and item.itemCount < stackLimit)
      ) then
        match = item
        break
      end
    end
  end

  local function CheckStackTargets(targets)
    for index, item in ipairs(targets) do
      if (self.allocatedSlots[item.bagID] == nil or not self.allocatedSlots[item.bagID][item.slotID]) and (
        item.itemID ~= nil and item.itemID == source.itemID and item.itemCount < stackLimit
      ) then
        match = item
        break
      end
    end
  end

  -- Tabs with specific items in them prioritised
  for tabIndex, tabDetails in ipairs(tabData) do
    local targets = addonTable.Transfers.GetBagsSlots({tabDetails.slots}, {indexes[tabIndex]})
    CheckStackTargets(targets)
    if match then
      break
    end
  end
  -- Then scan for tabs with matching settings
  if not match then
    for tabIndex, tabDetails in ipairs(tabData) do
      local targets = addonTable.Transfers.GetBagsSlots({tabDetails.slots}, {indexes[tabIndex]})
      if GetMatching(tabDetails.depositFlags, source) then
        CheckTargets(targets)
        if match then
          break
        end
      end
    end
  end

  -- Fallback to current view
  if not match then
    local targets = addonTable.Transfers.GetCurrentBankSlots()
    CheckTargets(targets)
  end
  C_Container.PickupContainerItem(bagID, slotID)
  if match then
    self.allocatedSlots[match.bagID] = self.allocatedSlots[match.bagID] or {}
    self.allocatedSlots[match.bagID][match.slotID] = true

    C_Container.PickupContainerItem(match.bagID, match.slotID)

    Syndicator.CallbackRegistry:RegisterCallback("BagCacheUpdate", self.BagUpdate, self)
    Syndicator.CallbackRegistry:RegisterCallback("WarbandBankCacheUpdate", self.BagUpdate, self)

    if match.itemCount and match.itemCount + source.itemCount > stackLimit then
      table.insert(self.queue, {bagID = bagID, slotID = slotID})
    end
  else
    UIErrorsFrame:AddMessage(addonTable.Locales.CANNOT_MOVE_ITEMS_AS_NO_SPACE_LEFT, 1.0, 0.1, 0.1, 1.0)
    C_Timer.After(0, function()
      ClearCursor()
    end)
  end
end

function addonTable.BankTransferManagerMixin:BagUpdate()
  if not BankPanel:IsShown() then
    self.allocatedSlots = {}
  end
  if #self.queue > 0 then
    local item = table.remove(self.queue)
    self:Queue(item.bagID, item.slotID)
  end
  for bagID, slots in pairs(self.allocatedSlots) do
    for slotID, state in pairs(slots) do
      if C_Item.DoesItemExist({bagID = bagID, slotIndex = slotID}) then
        slots[slotID] = nil
      end
    end
    if next(slots) == nil then
      self.allocatedSlots[bagID] = nil
    end
  end
  if next(self.allocatedSlots) == nil then
    Syndicator.CallbackRegistry:UnregisterCallback("BagCacheUpdate", self)
    Syndicator.CallbackRegistry:UnregisterCallback("WarbandBankCacheUpdate", self)
  end
end
