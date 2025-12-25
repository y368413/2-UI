--## Author: Yuyuli ## Version: 1.0.41
local NPCTime = CreateFrame('frame')
local timeFormat = "%H:%M, %d.%m"
local band = bit.band
local dontShowPhaseOnInit = true

local timeFormatter = CreateFromMixins(SecondsFormatterMixin);
timeFormatter:Init(1, SecondsFormatter.Abbreviation.Truncate);
local function AddMessage(...) _G.DEFAULT_CHAT_FRAME:AddMessage(strjoin(" ", tostringall(...))) end

-- Compat
local function AddColoredDoubleLine(tooltip, leftT, rightT, leftC, rightC, wrap)
  leftC = leftC or NORMAL_FONT_COLOR
  rightC = rightC or HIGHLIGHT_FONT_COLOR
  wrap = wrap or true
  tooltip:AddDoubleLine(leftT, rightT, leftC.r, leftC.g, leftC.b, rightC.r, rightC.g, rightC.b, wrap);
end

function NPCTime:PhaseAlert(e)
  local text = string.format("|cff9BFFA8 # %s New Connection|r", date("%H:%M"))
  AddMessage(text)
end

function NPCTime:OnEvent(e,...)
  if e == "CONSOLE_MESSAGE" then
    local message = ...
    if string.find(message, "new connection") then
      if not dontShowPhaseOnInit then
        self:PhaseAlert(e)
      end
    end
  end
end

function NPCTime:ShowTime(self)
  if not IsModifierKeyDown() then return end
  local _, unit = self:GetUnit()
  local guid = UnitGUID(unit or "none") --[[@as string]]
  if issecretvalue then
      if issecretvalue(guid) then return end
  end

  local unitType, _, serverID, _, layerUID, unitID = strsplit("-", guid)
  local timeRaw = tonumber(strsub(guid, -6), 16)
  if timeRaw and (unitType == "Creature" or unitType == "Vehicle") then
    local serverTime = GetServerTime() --[[@as integer]]
    local spawnTime = ( serverTime - (serverTime % 2^23) ) + bit.band(timeRaw, 0x7fffff)

    local spawnIndex = bit.rshift(band(tonumber(strsub(guid, -10, -6), 16) --[[@as integer]], 0xffff8), 3)

      --AddColoredDoubleLine(self, TIMEMANAGER_TOOLTIP_REALMTIME , date(timeFormat, serverTime))

    if spawnTime > serverTime then
      spawnTime = spawnTime - ((2^23) - 1)
    end
    AddColoredDoubleLine(self, serverID.."-"..layerUID, timeFormatter:Format((serverTime-spawnTime), false).." ("..date(timeFormat, spawnTime)..")")
      --if spawnIndex > 0 then
        --AddColoredDoubleLine(self, "Index", spawnIndex)
      --end
    self:Show()
  end
end

function NPCTime:OnLoad()
  self:RegisterEvent("ADDON_LOADED")
  --self:RegisterEvent("CONSOLE_MESSAGE")
  C_Timer.After(1, function() dontShowPhaseOnInit = false end)
  if C_TooltipInfo and TooltipDataProcessor then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, tooltipData)
      if tooltip ~= GameTooltip then return end
      if GetRestrictedActionStatus then
        if not GetRestrictedActionStatus(1) then
          self:ShowTime(tooltip)
        end
      else
        self:ShowTime(tooltip)
      end
    end)
  else
    GameTooltip:HookScript("OnTooltipSetUnit", function(...) self:ShowTime(...) end)
  end
  self:SetScript("OnEvent", self.OnEvent)
end

NPCTime:OnLoad()