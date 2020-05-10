-- Version: 2019.10.28ÐÞ¸´°æ @ ¸ßÆµ±äÑ¹Æ÷ by NGA - for 8.2.5(v0.1)
-- Author: Shagu

libnotify = {}
libnotify.window = {}
libnotify.max_window = 5

function libnotify:CreateFrame()
  local frame = CreateFrame("Button", "Achievment", UIParent)

  frame:SetWidth(300)
  frame:SetHeight(88)
  frame:SetFrameStrata("DIALOG")
  frame:Hide()

  do -- animations
    frame:SetScript("OnShow", function(self)
      self.modifyA = 1
      self.modifyB = 0
      self.stateA = 0
      self.stateB = 0
      self.animate = true

      self.showTime = GetTime()
    end)

    frame:SetScript("OnUpdate", function(self)
      if ( self.tick or 1) > GetTime() then return else self.tick = GetTime() + .01 end

      if self.animate == true then
        if self.stateA > .50 and self.modifyA == 1 then
          self.modifyB = 1
        end

        if self.stateA > .75 then
          self.modifyA = -1
        end

        if self.stateB > .50 then
          self.modifyB = -1
        end

        self.stateA = self.stateA + self.modifyA/50
        self.stateB = self.stateB + self.modifyB/50

        self.glow:SetGradientAlpha("HORIZONTAL",
          self.stateA, self.stateA, self.stateA, self.stateA,
          self.stateB, self.stateB, self.stateB, self.stateB)

        self.shine:SetGradientAlpha("VERTICAL",
          self.stateA, self.stateA, self.stateA, self.stateA,
          self.stateB, self.stateB, self.stateB, self.stateB)

        if self.stateA < 0 and self.stateB < 0 then
          self.animate = false
        end
      end

      if self.showTime + 5 < GetTime() then
        self:SetAlpha(self:GetAlpha() - .05)
        if self:GetAlpha() <= 0 then
          self:Hide()
          self:SetAlpha(1)
        end
      end
    end)
  end

  frame.background = frame:CreateTexture("background", "BACKGROUND")
  frame.background:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Alert-Background")
  frame.background:SetPoint("TOPLEFT", 0, 120)
  frame.background:SetPoint("BOTTOMRIGHT", 0, 120)
  frame.background:SetTexCoord(0, .605, 0, .703)

  frame.unlocked = frame:CreateFontString("Unlocked", "DIALOG", "GameFontBlack")
  frame.unlocked:SetWidth(200)
  frame.unlocked:SetHeight(11)
  frame.unlocked:SetPoint("TOP", 7, 97)
  frame.unlocked:SetText(COMPLETE)

  frame.name = frame:CreateFontString("Name", "DIALOG", "GameFontHighlight")
  frame.name:SetWidth(240)
  frame.name:SetHeight(16)
  frame.name:SetPoint("BOTTOMLEFT", 72, 156)
  frame.name:SetPoint("BOTTOMRIGHT", -60, 156)

  frame.glow = frame:CreateTexture("glow", "OVERLAY")
  frame.glow:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Alert-Glow")
  frame.glow:SetBlendMode("ADD")
  frame.glow:SetWidth(400)
  frame.glow:SetHeight(171)
  frame.glow:SetPoint("CENTER", 0, 120)
  frame.glow:SetTexCoord(0, 0.78125, 0, 0.66796875)
  frame.glow:SetAlpha(0)

  frame.shine = frame:CreateTexture("shine", "OVERLAY")
  frame.shine:SetBlendMode("ADD")
  frame.shine:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Alert-Glow")
  frame.shine:SetWidth(67)
  frame.shine:SetHeight(72)
  frame.shine:SetPoint("BOTTOMLEFT", 0, 128)
  frame.shine:SetTexCoord(0.78125, 0.912109375, 0, 0.28125)
  frame.shine:SetAlpha(0)

  frame.icon = CreateFrame("Frame", "icon", frame)
  frame.icon:SetWidth(124)
  frame.icon:SetHeight(124)
  frame.icon:SetPoint("TOPLEFT", -26, 136)

  --[[
  frame.icon.backfill = frame.icon:CreateTexture("backfill", "BACKGROUND")
  frame.icon.backfill:SetBlendMode("ADD")
  frame.icon.backfill:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-Achievement-IconFrame-Backfill")
  frame.icon.backfill:SetPoint("CENTER", 0, 0)
  frame.icon.backfill:SetWidth(64)
  frame.icon.backfill:SetHeight(64)
  ]]--

  frame.icon.bling = frame.icon:CreateTexture("bling", "BORDER")
  frame.icon.bling:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Bling")
  frame.icon.bling:SetPoint("CENTER", -1, 1)
  frame.icon.bling:SetWidth(116)
  frame.icon.bling:SetHeight(116)

  frame.icon.texture = frame.icon:CreateTexture("texture", "ARTWORK")
  frame.icon.texture:SetPoint("CENTER", 0, 3)
  frame.icon.texture:SetWidth(50)
  frame.icon.texture:SetHeight(50)

  frame.icon.overlay = frame.icon:CreateTexture("overlay", "OVERLAY")
  frame.icon.overlay:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-Achievement-IconFrame")
  frame.icon.overlay:SetPoint("CENTER", -1, 2)
  frame.icon.overlay:SetHeight(72)
  frame.icon.overlay:SetWidth(72)
  frame.icon.overlay:SetTexCoord(0, 0.5625, 0, 0.5625)

  frame.shield = CreateFrame("Frame", "shield", frame)
  frame.shield:SetWidth(64)
  frame.shield:SetHeight(64)
  frame.shield:SetPoint("TOPRIGHT", -10, 107)

  frame.shield.icon = frame.shield:CreateTexture("icon", "BACKGROUND")
  frame.shield.icon:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-ACHIEVEMENT-SHIELDS-NOPOINTS")
  frame.shield.icon:SetWidth(52)
  frame.shield.icon:SetHeight(48)
  frame.shield.icon:SetPoint("TOPRIGHT", 1, -8)

  frame.shield.points = frame.shield:CreateFontString("Name", "DIALOG", "GameFontWhite")
  frame.shield.points:SetPoint("CENTER", 6, 3)
  frame.shield.points:SetWidth(64)
  frame.shield.points:SetHeight(64)

  return frame
end

function libnotify:ShowPopup(text, points, icon, elite)
  for i=1, libnotify.max_window do
    if not libnotify.window[i]:IsVisible() then
      libnotify.window[i].unlocked:SetText(COMPLETE)
      libnotify.window[i].name:SetText(text or "DUMMY")
      libnotify.window[i].icon.texture:SetTexture(icon or "Interface\\QuestFrame\\UI-QuestLog-BookIcon")

      if elite then
        libnotify.window[i].shield.icon:SetTexCoord(0, .5 , .5 , 1)
      else
        libnotify.window[i].shield.icon:SetTexCoord(0, .5 , 0 , .5)
      end

      libnotify.window[i].shield.points:SetText(points or nil) --points or "10"
      libnotify.window[i]:Show()

      return
    end
  end
end

for i=1, libnotify.max_window do
  libnotify.window[i] = libnotify:CreateFrame()
  libnotify.window[i]:SetPoint("BOTTOM", 0, 16 + (88*i))  --"TOP", 0, -66 - (88*i)
end


-- A notification trigger for quest objective commpletion
local QuestCompleteNotification = CreateFrame("Frame")
QuestCompleteNotification:RegisterEvent("QUEST_WATCH_UPDATE")
QuestCompleteNotification:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
QuestCompleteNotification.queue = nil
QuestCompleteNotification:SetScript("OnEvent", function(self, event, unit)
	if event == "QUEST_WATCH_UPDATE" then
		QuestCompleteNotification.queue = unit
	elseif event == "UNIT_QUEST_LOG_CHANGED" and QuestCompleteNotification.queue and unit == "player" then
		local title, level, tag, header, collapsed, complete = GetQuestLogTitle(QuestCompleteNotification.queue)
		if complete then
			libnotify:ShowPopup(title, nil, nil, tag)  --title, level, nil, tag
			PlaySoundFile("Interface\\AddOns\\ShaguNotify\\textures\\complete.ogg", "Master")
		end
		QuestCompleteNotification.queue = nil
	end
end)