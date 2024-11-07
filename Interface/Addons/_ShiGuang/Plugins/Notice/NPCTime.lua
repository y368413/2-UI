--## Author: Yuyuli ## Version: 1.0.24
local NPCTime = CreateFrame('frame')
local timeFormat = "%H:%M, %d.%m"
local band = bit.band

local timeFormatter = CreateFromMixins(SecondsFormatterMixin);
timeFormatter:Init(1, SecondsFormatter.Abbreviation.Truncate);

-- Compat
local function AddColoredDoubleLine(tooltip, leftT, rightT, leftC, rightC, wrap)
  leftC = leftC or NORMAL_FONT_COLOR
  rightC = rightC or HIGHLIGHT_FONT_COLOR
  wrap = wrap or true
  tooltip:AddDoubleLine(leftT, rightT, leftC.r, leftC.g, leftC.b, rightC.r, rightC.g, rightC.b, wrap);
end

function NPCTime:ShowTime(self)
  if not IsModifierKeyDown() then return end  -- Settings.UsingMod and 
  local _, unit = self:GetUnit()
  local guid = UnitGUID(unit or "none")
  if not guid then return end

  local unitType, _, serverID, _, layerUID, unitID, uuid = strsplit("-", guid)
  local id = tonumber(strsub(guid, -6), 16)
  if id and (unitType == "Creature" or unitType == "Vehicle") then
    local serverTime = GetServerTime()
    local spawnTime  = ( serverTime - (serverTime % 2^23) ) + band(id, 0x7fffff)
    if spawnTime > serverTime then
      spawnTime = spawnTime - ((2^23) - 1)
    end
    AddColoredDoubleLine(self, serverID.."-"..layerUID, timeFormatter:Format((serverTime-spawnTime), false, false).." ("..date(timeFormat, spawnTime)..")")
    self:Show()
  end
end

function NPCTime:OnLoad()
  self:RegisterEvent("ADDON_LOADED")
  if C_TooltipInfo and TooltipDataProcessor then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, tooltipData)
      if tooltip ~= GameTooltip then return end
      self:ShowTime(tooltip)
    end)
  else
      GameTooltip:HookScript("OnTooltipSetUnit", function(...) self:ShowTime(...) end)
  end
end

NPCTime:OnLoad()